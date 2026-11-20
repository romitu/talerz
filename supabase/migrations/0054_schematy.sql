-- =============================================================================
--  TALERZ — schematy tygodnia
-- =============================================================================
--  Po co
--  -----
--  „Powtórz poprzedni tydzień” jest przywiązane do kalendarza: bierze
--  najbliższy wcześniejszy tydzień w bazie. Po wyczyszczeniu, po przerwie
--  w planowaniu albo po sprzątnięciu starych tygodni (TYGODNI_HISTORII
--  w lib/plan.ts) nie ma skąd wziąć dań, choć układ był dobry i ktoś chciał
--  do niego wrócić.
--
--  Schemat to tydzień BEZ DAT: dzień 1..N × pora → przepis, z zapamiętanym,
--  które posiłki pochodzą z jednego gotowania. Zastosowanie schematu przenosi
--  go na bieżący tydzień tą samą drogą co powtórka (`powtorzTydzien`
--  w lib/automat.ts): garnek w całości albo wcale, bez dań ze składnikami
--  „Nie jemy”, z porcjami przeliczonymi pod cel osoby, która go stosuje.
--
--  Etap 1: schematy prywatne konta. Dietetyk i publiczny katalog moderatora
--  przyjdą później — wtedy dojdzie tu kolumna widoczności, a nie nowa tabela.
--
--  Przepis zapisujemy w BAZOWEJ porcji, nie wariant skalowany. Wariant był
--  liczony pod cel jednej osoby i jednego dnia; po zastosowaniu przelicza się
--  od nowa pod aktualny cel.
--
--  Usunięty przepis NIE znika ze schematu po cichu (`on delete set null`,
--  nazwa zostaje). Schemat pokazuje wtedy dziurę z nazwą dania, a
--  zastosowanie mówi, ile dań pominęło. `restrict` jak w plan_pozycje odpada:
--  schematy nie są sprzątane, więc przepis użyty raz w schemacie nie dałby
--  się już nigdy usunąć.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create table schematy (
  id         uuid        primary key default gen_random_uuid(),
  konto_id   uuid        not null references konta (id) on delete cascade,
  nazwa      text        not null check (length(trim(nazwa)) between 1 and 80),
  dni        smallint    not null check (dni between 1 and 31),
  utworzono  timestamptz not null default now(),
  -- Dwa schematy o tej samej nazwie na jednym koncie to proszenie się o pomyłkę
  -- przy wyborze — baza tego nie przepuści.
  constraint schematy_nazwa_unikalna unique (konto_id, nazwa)
);

comment on table schematy is
  'Tydzień bez dat do wielokrotnego użycia. Pozycje w schemat_pozycje.';

create index schematy_konto_idx on schematy (konto_id, nazwa);

alter table schematy enable row level security;

create policy schematy_wlasne on schematy
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());


create table schemat_pozycje (
  id          uuid         primary key default gen_random_uuid(),
  schemat_id  uuid         not null references schematy (id) on delete cascade,
  dzien       smallint     not null check (dzien between 0 and 30),
  pora        pora_posilku not null check (pora in ('sniadanie', 'obiad', 'kolacja')),
  przepis_id  uuid         references przepisy (id) on delete set null,
  nazwa       text         not null,
  gotowanie   smallint     not null check (gotowanie >= 0),
  kolejnosc   smallint     not null default 1,
  constraint schemat_pozycje_miejsce unique (schemat_id, dzien, pora, kolejnosc)
);

comment on column schemat_pozycje.dzien is
  'Dzień schematu liczony od zera (0 = pierwszy dzień tygodnia, do którego schemat się stosuje).';
comment on column schemat_pozycje.przepis_id is
  'NULL = przepis został usunięty. Pozycja zostaje, żeby dziura była widoczna, a nie zamaskowana.';
comment on column schemat_pozycje.nazwa is
  'Nazwa dania z chwili zapisu — pokazywana także wtedy, gdy przepisu już nie ma.';
comment on column schemat_pozycje.gotowanie is
  'Numer gotowania w obrębie schematu. Pozycje z tym samym numerem to jeden garnek rozłożony na kilka dni.';

create index schemat_pozycje_schemat_idx on schemat_pozycje (schemat_id, dzien, pora, kolejnosc);

alter table schemat_pozycje enable row level security;

create policy schemat_pozycje_wlasne on schemat_pozycje
  for all
  using (exists (select 1 from schematy s where s.id = schemat_pozycje.schemat_id and s.konto_id = id_czynnego_konta()))
  with check (exists (select 1 from schematy s where s.id = schemat_pozycje.schemat_id and s.konto_id = id_czynnego_konta()));

-- Uprawnienia dla Data API — zasada z migracji 0044. Role sprawdzamy, bo
-- lokalne testy schematu nie zawsze je zakładają.
do $$
declare
  rola text;
begin
  foreach rola in array array['authenticated', 'service_role'] loop
    continue when not exists (select 1 from pg_roles where rolname = rola);
    execute format('grant select, insert, update, delete on public.schematy to %I', rola);
    execute format('grant select, insert, update, delete on public.schemat_pozycje to %I', rola);
  end loop;
end
$$;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from schematy)        as ile_schematow,
  (select count(*) from schemat_pozycje) as ile_pozycji_schematow;
