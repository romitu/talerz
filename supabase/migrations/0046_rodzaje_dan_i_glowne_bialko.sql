-- =============================================================================
--  TALERZ — rodzaj dania i główne białko
-- =============================================================================
--  Problem
--  -------
--  Przepis miał porę i kuchnię. Przy wyborze obiadu to za mało — nikt nie
--  myśli „coś śródziemnomorskiego”, tylko „zjadłbym zupę” albo „coś z rybą”.
--  Kuchnia „inna” trafiła do ponad jednej trzeciej przepisów, więc i ona
--  niewiele różnicuje.
--
--  Rozwiązanie
--  -----------
--  Dwie nowe osie, niezależne od pory i kuchni:
--
--  1. RODZAJ DANIA — ustawiany ręcznie, zamknięta lista (typ `rodzaj_dania`).
--     Przepis może mieć jeden albo dwa rodzaje: potrawka z kaszą jest i gulaszem,
--     i daniem z kaszą. Pusta lista = jeszcze nieprzypisany, NIE „pasuje
--     wszędzie” — lista przepisów pokazuje takie dania osobno, żeby było widać,
--     co zostało do uzupełnienia.
--
--  2. GŁÓWNE BIAŁKO — wyliczane, nigdy wpisywane (widok `przepis_bialko`).
--     Ta sama zasada co przy makro: wynika ze składników, więc nie rozjedzie się
--     z przepisem po zmianie gramatur. Liczy się grupa składników, która wnosi
--     najwięcej białka — po tagach składnika:
--
--       drob                    -> drob
--       mieso, podroby          -> mieso      (bez drobiu — drób ma też tag „mieso”)
--       ryba, owoce morza       -> ryba
--       straczki                -> straczki   (tofu też ma ten tag)
--       jaja                    -> jaja
--       nabial                  -> nabial
--
--     Grupa musi dawać co najmniej 25% białka całego dania. Inaczej danie nie
--     ma głównego białka: garść parmezanu nad makaronem nie czyni go daniem
--     „z nabiałem”.
--
--  Czego to NIE jest
--  -----------------
--  To nie filtr diety ani alergenów (plan aplikacji, sekcja 8). „Ryba” mówi,
--  co jest bazą białkową dania, a nie że w daniu nie ma nic innego.
--
--  Przypisanie rodzajów istniejącym przepisom: supabase/narzedzia/rodzaje-dan.sql
--  (osobno, bo to dane, nie schemat).
--
--  Wykonanie: SQL Editor w panelu Supabase. Jednorazowo — drugie uruchomienie
--  zatrzyma się na `create type` (typ już istnieje) i niczego nie zepsuje.
-- =============================================================================

-- --- RODZAJ DANIA ------------------------------------------------------------
create type rodzaj_dania as enum (
  'zupa',
  'salatka',
  'makaron',
  'kasza_ryz',
  'gulasz_curry',
  'z_piekarnika',
  'kanapki',
  'jajka',
  'na_slodko'
);

comment on type rodzaj_dania is
  'Trzecia oś etykiet przepisu, obok pory i kuchni: czym danie jest na talerzu — zupa, sałatka, makaron…';

alter table przepisy
  add column if not exists rodzaje rodzaj_dania[] not null default '{}';

-- Jeden albo dwa. Trzy rodzaje naraz to znak, że etykieta przestała coś mówić.
alter table przepisy drop constraint if exists przepisy_rodzaje_najwyzej_dwa;
alter table przepisy add constraint przepisy_rodzaje_najwyzej_dwa
  check (coalesce(array_length(rodzaje, 1), 0) <= 2);

create index if not exists przepisy_rodzaje_idx on przepisy using gin (rodzaje);

comment on column przepisy.rodzaje is
  'Rodzaj dania, jeden albo dwa. Pusta lista = jeszcze nieprzypisany (lista przepisów pokazuje takie osobno).';


-- --- GŁÓWNE BIAŁKO -----------------------------------------------------------
drop view if exists przepis_bialko;

create view przepis_bialko as
with udzialy as (
  select
    ps.przepis_id,
    case
      when 'drob' = any (s.tagi)                                   then 'drob'
      when s.tagi && array['mieso', 'podroby']                     then 'mieso'
      when s.tagi && array['ryba', 'owoce morza']                  then 'ryba'
      when 'straczki' = any (s.tagi)                               then 'straczki'
      when 'jaja' = any (s.tagi)                                   then 'jaja'
      when 'nabial' = any (s.tagi)                                 then 'nabial'
    end                                        as grupa,
    ps.gramy * s.bialko_100g / 100.0           as bialko
  from przepis_skladniki ps
  join skladniki s on s.id = ps.skladnik_id
),
razem as (
  select przepis_id, sum(bialko) as bialko
  from udzialy
  group by przepis_id
),
grupy as (
  select
    przepis_id,
    grupa,
    sum(bialko) as bialko,
    row_number() over (partition by przepis_id order by sum(bialko) desc, grupa) as miejsce
  from udzialy
  where grupa is not null
  group by przepis_id, grupa
)
select
  g.przepis_id,
  g.grupa                                      as glowne_bialko,
  round(g.bialko / nullif(r.bialko, 0) * 100)::integer as udzial_procent
from grupy g
join razem r using (przepis_id)
where g.miejsce = 1
  and g.bialko >= 0.25 * r.bialko;

comment on view przepis_bialko is
  'Główne źródło białka w przepisie, wyliczone z tagów składników. Brak wiersza = danie nie ma wyraźnego głównego białka.';

grant select on przepis_bialko to authenticated;
grant select on przepis_bialko to service_role;


-- --- SKŁADNIKI BEZ TAGÓW, KTÓRE SĄ ŹRÓDŁEM BIAŁKA ------------------------------
-- Bez tagu składnik nie trafi do żadnej grupy i klopsiki z indyka wyszłyby
-- jako danie bez głównego białka. Uzupełniamy tylko puste tagi — ręcznie
-- ustawionych nie ruszamy.
update skladniki set tagi = array['mieso', 'drob']
 where nazwa = 'Mięso mielone z indyka, surowe' and tagi = '{}';

update skladniki set tagi = array['ryba']
 where nazwa = 'Filet z dorsza atlantyckiego' and tagi = '{}';
