-- =============================================================================
--  TALERZ — sposób porcjowania
-- =============================================================================
--  Problem
--  -------
--  Pole `porcje` pytało „na ile porcji wychodzi danie”. To nie jest cecha
--  przepisu. Garnek ma stałą zawartość; zmienna jest wielkość chochli.
--
--  Zupa ogórkowa: 2054 kcal w garnku, „4 do 6 porcji”. Daje to od 342
--  do 514 kcal na posiłek — 172 kcal niepewności przy dziennym celu 2290 kcal.
--  Plan dnia zbudowany na takich danych nie ma sensu.
--
--  Rozwiązanie
--  -----------
--  Dwa sposoby porcjowania, bo istnieją dwa rodzaje dań:
--
--    waga    — zupy, gulasze, sosy. Podajesz wagę jednej porcji (350 g),
--              a liczba porcji wynika z podzielenia zawartości garnka.
--    sztuki  — kotlety, naleśniki, muffiny. Podajesz liczbę sztuk,
--              a waga porcji wynika z podzielenia masy składników.
--
--  W obu przypadkach jedna wartość jest podawana, druga wyliczana.
--  Nigdy obie naraz — inaczej rozjechałyby się przy pierwszej zmianie.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create type sposob_porcjowania as enum ('waga', 'sztuki');

alter table przepisy
  add column porcjowanie sposob_porcjowania not null default 'sztuki',
  add column porcja_g    smallint check (porcja_g between 20 and 2000);

comment on column przepisy.porcjowanie is
  'waga — porcję określa gramatura (zupy, gulasze); sztuki — liczba sztuk (kotlety, naleśniki).';

comment on column przepisy.porcja_g is
  'Waga jednej porcji. Wypełniane tylko przy porcjowaniu wagowym; przy sztukach wylicza się z masy składników.';

comment on column przepisy.porcje is
  'Liczba porcji. Wypełniane tylko przy porcjowaniu na sztuki; przy wadze wylicza się z masy składników.';

-- Podana musi być dokładnie ta wartość, która pasuje do wybranego sposobu.
alter table przepisy
  add constraint porcjowanie_spojne check (
    (porcjowanie = 'sztuki' and porcja_g is null)
    or (porcjowanie = 'waga' and porcja_g is not null)
  );


-- =============================================================================
--  WIDOK MAKRO — porcja liczona zgodnie z wybranym sposobem
-- =============================================================================

drop view if exists przepis_makro;

create view przepis_makro as
with sumy as (
  select
    p.id                                       as przepis_id,
    p.porcjowanie,
    p.porcje                                   as porcje_podane,
    p.porcja_g                                 as porcja_podana_g,
    sum(ps.gramy)                              as masa_calosci,
    sum(ps.gramy * s.kcal_100g        / 100.0) as kcal,
    sum(ps.gramy * s.bialko_100g      / 100.0) as bialko,
    sum(ps.gramy * s.tluszcz_100g     / 100.0) as tluszcz,
    sum(ps.gramy * s.wegle_100g       / 100.0) as wegle,
    sum(ps.gramy * s.blonnik_100g     / 100.0) as blonnik,
    sum(ps.gramy * s.cukry_wolne_100g / 100.0) as cukry_wolne,
    max(s.nova)                                as nova_max
  from przepisy p
  join przepis_skladniki ps on ps.przepis_id = p.id
  join skladniki s          on s.id = ps.skladnik_id
  group by p.id, p.porcjowanie, p.porcje, p.porcja_g
),
przeliczone as (
  select
    sumy.*,
    -- Ile porcji wychodzi: przy wadze dzielimy masę, przy sztukach bierzemy podaną liczbę.
    case
      when porcjowanie = 'waga' and porcja_podana_g > 0
        then greatest(masa_calosci / porcja_podana_g, 0.1)
      else greatest(porcje_podane, 1)
    end as ile_porcji,
    -- Ile waży porcja: przy wadze podana wprost, przy sztukach z podziału masy.
    case
      when porcjowanie = 'waga' then porcja_podana_g::numeric
      else masa_calosci / greatest(porcje_podane, 1)
    end as masa_porcji
  from sumy
)
select
  przepis_id,
  porcjowanie,
  round(ile_porcji, 1)                          as porcje_wyliczone,
  round(masa_porcji)::integer                   as gramy_porcji,
  round(masa_calosci)::integer                  as gramy_calosc,

  -- całe danie
  round(kcal)::integer                          as kcal_calosc,
  round(bialko, 1)                              as bialko_g_calosc,
  round(tluszcz, 1)                             as tluszcz_g_calosc,
  round(wegle, 1)                               as wegle_g_calosc,
  round(blonnik, 1)                             as blonnik_g_calosc,
  round(cukry_wolne, 1)                         as cukry_wolne_g_calosc,

  -- jedna porcja
  round(kcal        / ile_porcji)::integer      as kcal,
  round(bialko      / ile_porcji, 1)            as bialko_g,
  round(tluszcz     / ile_porcji, 1)            as tluszcz_g,
  round(wegle       / ile_porcji, 1)            as wegle_g,
  round(blonnik     / ile_porcji, 1)            as blonnik_g,
  round(cukry_wolne / ile_porcji, 1)            as cukry_wolne_g,

  nova_max
from przeliczone;

comment on view przepis_makro is
  'Makro ze składników. Kolumny bez przyrostka dotyczą JEDNEJ PORCJI, liczonej zgodnie ze sposobem porcjowania wybranym w przepisie.';
