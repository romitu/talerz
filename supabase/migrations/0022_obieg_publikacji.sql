-- =============================================================================
--  TALERZ — obieg publikacji przepisu
-- =============================================================================
--  Co już było
--  -----------
--  Przepis od początku ma trzy stany: `prywatna`, `zgloszona`, `publiczna`,
--  a rola moderatora istnieje. Brakowało dwóch rzeczy: samego obiegu w aplikacji
--  i — co ważniejsze — pilnowania, KTO może przestawić stan na który.
--
--  DZIURA, KTÓRĄ TO ZAMYKA
--  -----------------------
--  Reguła edycji brzmiała:
--
--      create policy przepisy_edycja_autor on przepisy
--        for update using (autor_id = auth.uid() and widocznosc = 'prywatna')
--        with check (autor_id = auth.uid());
--
--  Warunek `with check` mówi tylko tyle, że po zmianie przepis dalej należy do
--  autora. O kolumnie `widocznosc` nie mówi nic. Autor mógł więc wykonać:
--
--      update przepisy set widocznosc = 'publiczna' where id = <swój przepis>;
--
--  i opublikować się z pominięciem moderatora. To ta sama pomyłka co przy
--  kolumnie `rola` w tabeli `konta` (migracja 0021) i z tego samego powodu:
--  reguły dostępu w PostgreSQL działają na CAŁYCH WIERSZACH, nigdy na
--  pojedynczych kolumnach. Kolumnę osłania się wyzwalaczem.
--
--  DOZWOLONE PRZEJŚCIA
--  -------------------
--      autor:      prywatna  → zgloszona     (zgłoszenie do publikacji)
--                  zgloszona → prywatna      (wycofanie zgłoszenia)
--      moderator:  dowolne                   (zatwierdzenie i odrzucenie)
--
--  Autor nie ma drogi do `publiczna`. Żadnej.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================


-- =============================================================================
--  1. CO MODERATOR MA DO POWIEDZENIA AUTOROWI
-- =============================================================================

alter table przepisy
  add column if not exists zgloszono_kiedy   timestamptz,
  add column if not exists rozpatrzono_kiedy timestamptz,
  add column if not exists powod_odrzucenia  text
    check (powod_odrzucenia is null or length(btrim(powod_odrzucenia)) between 3 and 500);

comment on column przepisy.zgloszono_kiedy is
  'Kiedy autor poprosił o publikację. Po tym sortujemy kolejkę moderatora — najstarsze zgłoszenie idzie pierwsze.';

comment on column przepisy.powod_odrzucenia is
  'Dlaczego przepis wrócił do autora. Odrzucenie bez powodu kończy się tym, że autor zgłasza to samo drugi raz.';


-- =============================================================================
--  2. AUTOR MOŻE WYCOFAĆ ZGŁOSZENIE
-- =============================================================================
/*
  Dotychczasowa reguła pozwalała autorowi ruszać przepis TYLKO gdy prywatny.
  Po zgłoszeniu przepis stawał się nietykalny — autor nie mógł go ani poprawić,
  ani wycofać, dopóki moderator się nim nie zajął. Przy jednym moderatorze
  na cały serwis to jest pułapka bez wyjścia.

  Rozszerzamy więc regułę o stan `zgloszona`. Bezpieczeństwo tego nie osłabia,
  bo o tym, na jaki stan wolno przestawić, decyduje teraz wyzwalacz niżej —
  a `publiczna` dla autora pozostaje zamknięta.
*/
drop policy if exists przepisy_edycja_autor on przepisy;
create policy przepisy_edycja_autor on przepisy
  for update
  using (autor_id = auth.uid() and widocznosc in ('prywatna', 'zgloszona'))
  with check (autor_id = auth.uid());

-- Kasowanie działa tak samo: własny przepis, dopóki nie jest publiczny.
drop policy if exists przepisy_usuwanie on przepisy;
create policy przepisy_usuwanie on przepisy
  for delete using (
    czy_administrator()
    or (autor_id = auth.uid() and widocznosc in ('prywatna', 'zgloszona'))
  );


-- =============================================================================
--  3. WYZWALACZ PILNUJĄCY PRZEJŚĆ
-- =============================================================================

create or replace function przepisy_chron_widocznosc()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Zmiana stanu jest jedyną rzeczą, która nas tu interesuje.
  if new.widocznosc is not distinct from old.widocznosc then
    return new;
  end if;

  /*
    Żądania spoza aplikacji przepuszczamy — rozpoznajemy je po braku `auth.uid()`.
    To panel Supabase, migracje i `service_role`.

    NIE sprawdzamy `current_user`: ta funkcja jest `security definer`, więc
    zwróciłby jej właściciela, a nie rolę, z której przyszło żądanie. Ta sama
    pułapka wywróciła pierwszą wersję wyzwalacza w migracji 0021.
  */
  if auth.uid() is null then
    return new;
  end if;

  if czy_moderator() then
    -- Moderator zatwierdza albo odrzuca. Znaczniki ustawiamy tutaj, żeby nie
    -- zależały od tego, czy aplikacja o nich pamiętała.
    new.rozpatrzono_kiedy := now();
    if new.widocznosc = 'publiczna' then
      new.powod_odrzucenia := null;
    end if;
    return new;
  end if;

  if new.autor_id is distinct from auth.uid() then
    raise exception 'Można zmieniać widoczność tylko własnego przepisu.'
      using errcode = '42501';
  end if;

  if old.widocznosc = 'prywatna' and new.widocznosc = 'zgloszona' then
    new.zgloszono_kiedy := now();
    new.powod_odrzucenia := null;   -- nowe podejście, stara uwaga nieaktualna
    return new;
  end if;

  if old.widocznosc = 'zgloszona' and new.widocznosc = 'prywatna' then
    new.zgloszono_kiedy := null;
    return new;
  end if;

  raise exception
    'Przepis publikuje moderator. Autor może go zgłosić do publikacji albo wycofać zgłoszenie.'
    using errcode = '42501';
end;
$$;

comment on function przepisy_chron_widocznosc is
  'Zamyka autorowi drogę do stanu „publiczna”. Reguły dostępu działają na wierszach, więc tej jednej kolumny nie dało się osłonić inaczej.';

drop trigger if exists przepisy_ochrona_widocznosci on przepisy;
create trigger przepisy_ochrona_widocznosci
  before update of widocznosc on przepisy
  for each row execute function przepisy_chron_widocznosc();


-- =============================================================================
--  4. MODERATOR WIDZI KOLEJKĘ
-- =============================================================================
/*
  Reguła odczytu już przepuszcza moderatora do wszystkiego, więc wystarczy
  indeks pod zapytanie o kolejkę. Bez niego przy tysiącu przepisów lista
  zgłoszeń skanowałaby całą tabelę.
*/
create index if not exists przepisy_kolejka_idx
  on przepisy (zgloszono_kiedy)
  where widocznosc = 'zgloszona';


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from pg_trigger
    where tgname = 'przepisy_ochrona_widocznosci' and not tgisinternal) as "wyzwalacz (ma byc 1)",
  (select count(*) from information_schema.columns
    where table_name = 'przepisy'
      and column_name in ('zgloszono_kiedy', 'rozpatrzono_kiedy', 'powod_odrzucenia'))
    as "nowe kolumny (ma byc 3)",
  (select count(*) from przepisy where widocznosc = 'zgloszona') as "czeka na zatwierdzenie",
  (select count(*) from przepisy where widocznosc = 'publiczna') as "juz publicznych";
