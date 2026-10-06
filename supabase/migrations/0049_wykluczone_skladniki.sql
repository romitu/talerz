-- =============================================================================
--  TALERZ — składniki, których konto nie je
-- =============================================================================
--  Po co
--  -----
--  Ktoś w domu nie je jajek (albo ryb, grzybów…). Ręczne oznaczanie „Nie
--  proponuj” przy każdym daniu z jajkiem nie skaluje się: przepisów są setki,
--  a każdy nowy (import, przepisy AI) trzeba by oznaczać od nowa.
--
--  Dlatego wykluczenie jest TRWAŁĄ REGUŁĄ na składnik, a nie hurtowym
--  oznaczeniem przepisów. Aplikacja przy każdym wczytaniu sprawdza, które
--  przepisy zawierają wykluczony składnik, i:
--    * automat wypełniający plan ich nie proponuje (`lib/automat.ts`),
--    * nie ma ich w wyborze dania do planu,
--    * na liście przepisów są schowane pod osobnym przełącznikiem.
--
--  Zdjęcie wykluczenia przywraca wszystko od razu — nic nie trzeba cofać
--  w preferencjach przepisów, bo nic tam nie zostało zapisane.
--
--  Per konto, nie per profil: plan i garnek są wspólne dla całego domu, więc
--  jeśli jedna osoba nie je jajek, nie ma ich w planie nikogo.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create table wykluczone_skladniki (
  konto_id     uuid        not null references konta (id) on delete cascade,
  skladnik_id  uuid        not null references skladniki (id) on delete cascade,
  utworzono    timestamptz not null default now(),
  primary key (konto_id, skladnik_id)
);

comment on table wykluczone_skladniki is
  'Składniki, których dane konto nie je. Przepis zawierający którykolwiek z nich nie jest proponowany przez automat ani pokazywany w wyborze dania. Brak wiersza = składnik dozwolony.';

alter table wykluczone_skladniki enable row level security;

create policy wykluczone_skladniki_wlasne on wykluczone_skladniki
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

-- Uprawnienia dla Data API — zasada z migracji 0044. Role sprawdzamy, bo
-- lokalne testy schematu nie zawsze je zakładają.
do $$
declare
  rola text;
begin
  foreach rola in array array['authenticated', 'service_role'] loop
    continue when not exists (select 1 from pg_roles where rolname = rola);
    execute format(
      'grant select, insert, update, delete on public.wykluczone_skladniki to %I', rola);
  end loop;
end
$$;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select count(*) as ile_wykluczen from wykluczone_skladniki;
