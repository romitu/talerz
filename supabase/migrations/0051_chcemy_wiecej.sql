-- =============================================================================
--  TALERZ — składniki, których konto chce jeść więcej
-- =============================================================================
--  Po co
--  -----
--  Ktoś usłyszał o czarnuszce, siemieniu lnianym albo czosnku i chce, żeby
--  takie dania częściej trafiały do planu. To lustro „Nie jemy” (migracja
--  0049): trwała reguła na SKŁADNIK, a nie oznaczanie przepisów po kolei —
--  nowy przepis z czarnuszką dostaje premię sam, bez niczyjej pomocy.
--
--  Różnica wobec „Nie jemy”: to PREMIA, nie wymóg. Automat (`lib/automat.ts`)
--  przesuwa takie dania w górę, ale dalej pilnuje kalorii, białka i powtórek.
--  Gdyby to był twardy filtr, przy kilku zaznaczonych składnikach plan
--  wychodziłby pusty albo w kółko z tych samych trzech dań.
--
--  Talerz niczego tu nie obiecuje zdrowotnie: to wybór użytkownika („chcę
--  więcej czarnuszki”), a nie twierdzenie aplikacji, że czarnuszka coś leczy.
--
--  Per konto, nie per profil — z tego samego powodu co „Nie jemy”: plan
--  i garnek są wspólne dla całego domu.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create table chcemy_wiecej_skladniki (
  konto_id     uuid        not null references konta (id) on delete cascade,
  skladnik_id  uuid        not null references skladniki (id) on delete cascade,
  utworzono    timestamptz not null default now(),
  primary key (konto_id, skladnik_id)
);

comment on table chcemy_wiecej_skladniki is
  'Składniki, które dane konto chce jeść częściej. Przepis zawierający któryś z nich dostaje premię w automacie układającym plan — nie jest to wymóg ani filtr. Brak wiersza = składnik neutralny.';

alter table chcemy_wiecej_skladniki enable row level security;

create policy chcemy_wiecej_skladniki_wlasne on chcemy_wiecej_skladniki
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
      'grant select, insert, update, delete on public.chcemy_wiecej_skladniki to %I', rola);
  end loop;
end
$$;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select count(*) as ile_chcemy_wiecej from chcemy_wiecej_skladniki;
