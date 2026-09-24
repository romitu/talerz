-- =============================================================================
--  TALERZ — jawne uprawnienia Data API do tabel i widoków
-- =============================================================================
--  Od 30 października 2026 Supabase przestaje automatycznie nadawać rolom
--  `anon`, `authenticated` i `service_role` uprawnienia do NOWYCH tabel
--  w schemacie `public`. Tabela bez GRANT jest dla aplikacji niewidoczna —
--  supabase-js dostaje `permission denied`, zanim w ogóle dojdzie do RLS.
--
--  Na obecnej bazie produkcyjnej ta migracja niczego nie zmienia: stare
--  tabele zachowują nadane kiedyś uprawnienia. Chodzi o bazę stawianą od zera
--  (nowy projekt, kopia testowa, odtworzenie po awarii) — tam migracje
--  0001–0043 utworzyłyby tabele, do których aplikacja nie ma dostępu.
--
--  Kto co dostaje:
--    * authenticated — pełny odczyt i zapis. To NIE jest furtka: kto co
--      naprawdę widzi i zmienia, dalej rozstrzygają reguły RLS na każdej
--      tabeli. GRANT tylko wpuszcza do drzwi, RLS decyduje o pokojach.
--    * service_role  — pełny dostęp (panel Supabase, skrypty administracyjne).
--    * anon          — NIC. Cała aplikacja działa dopiero po zalogowaniu
--      (`app/_layout.tsx` pokazuje niezalogowanym tylko ekran logowania),
--      więc niezalogowany klient nie ma czego czytać.
--
--  Widoki (`przepis_makro`, `przepis_czas`, `sprzet_uzycie`,
--  `przepis_skalowany_makro`) też dostają uprawnienia: dla Postgresa widok
--  to relacja jak tabela, a my kilka razy je usuwaliśmy i tworzyliśmy od nowa.
--
--  ZASADA NA PRZYSZŁOŚĆ: każda migracja z `create table` / `create view`
--  nadaje uprawnienia w tym samym pliku, zaraz po utworzeniu:
--
--    grant select, insert, update, delete on public.nowa_tabela to authenticated;
--    grant select, insert, update, delete on public.nowa_tabela to service_role;
--
--  (dla widoku wystarczy `grant select`).
--
--  Migracja jest bezpieczna do wielokrotnego uruchomienia. Role sprawdzamy
--  przed nadaniem, bo lokalne testy (`testy/`) nie zawsze je zakładają.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

do $$
declare
  rola text;
  r record;
begin
  foreach rola in array array['authenticated', 'service_role'] loop
    continue when not exists (select 1 from pg_roles where rolname = rola);

    execute format('grant usage on schema public to %I', rola);

    for r in
      select c.relname, c.relkind
        from pg_class c
        join pg_namespace n on n.oid = c.relnamespace
       where n.nspname = 'public'
         and c.relkind in ('r', 'p', 'v', 'm')
    loop
      if r.relkind in ('r', 'p') then
        execute format(
          'grant select, insert, update, delete on public.%I to %I',
          r.relname, rola);
      else
        execute format('grant select on public.%I to %I', r.relname, rola);
      end if;
    end loop;
  end loop;
end
$$;


-- =============================================================================
--  SPRAWDZENIE — każda tabela i widok powinny mieć TAK w obu kolumnach
-- =============================================================================
select
  c.relname as relacja,
  case c.relkind when 'v' then 'widok' when 'm' then 'widok zmaterializowany' else 'tabela' end as rodzaj,
  case
    when not exists (select 1 from pg_roles where rolname = 'authenticated') then 'brak roli'
    when has_table_privilege('authenticated', c.oid, 'select') then 'TAK' else 'BRAK'
  end as authenticated,
  case
    when not exists (select 1 from pg_roles where rolname = 'service_role') then 'brak roli'
    when has_table_privilege('service_role', c.oid, 'select') then 'TAK' else 'BRAK'
  end as service_role
from pg_class c
join pg_namespace n on n.oid = c.relnamespace
where n.nspname = 'public'
  and c.relkind in ('r', 'p', 'v', 'm')
order by rodzaj, relacja;
