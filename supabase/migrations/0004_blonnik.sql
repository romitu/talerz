-- =============================================================================
--  TALERZ — błonnik
-- =============================================================================
--  Błonnik pominięto przy pierwszym schemacie, a jest istotny z trzech powodów:
--
--    1. W kuchni śródziemnomorskiej to jeden z głównych wyznaczników jakości
--       — strączki, kasze, warzywa i owoce wnoszą go najwięcej.
--    2. Bez niego nie da się ocenić węglowodanów. 62 g węglowodanów w kaszy
--       gryczanej i 62 g w białym pieczywie to zupełnie co innego.
--    3. Tłumaczy rozbieżności między kaloriami z etykiety a sumą makro —
--       błonnik dostarcza mniej energii niż pozostałe węglowodany.
--
--  USDA podaje błonnik pod numerem 291, więc import go uzupełni.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  add column blonnik_100g numeric(5, 2) not null default 0 check (blonnik_100g >= 0);

comment on column skladniki.blonnik_100g is
  'Błonnik pokarmowy na 100 g. Zawiera się w węglowodanach ogółem (USDA liczy je metodą „by difference”).';

-- Błonnik jest częścią węglowodanów, więc nie może ich przekraczać.
alter table skladniki
  add constraint blonnik_nie_wiekszy_niz_wegle check (blonnik_100g <= wegle_100g);


-- =============================================================================
--  WIDOK MAKRO Z BŁONNIKIEM
-- =============================================================================

drop view if exists przepis_makro;

create view przepis_makro as
select
  p.id                                                                as przepis_id,
  p.porcje,

  -- całe danie
  round(sum(ps.gramy * s.kcal_100g        / 100.0))::integer          as kcal_calosc,
  round(sum(ps.gramy * s.bialko_100g      / 100.0), 1)                as bialko_g_calosc,
  round(sum(ps.gramy * s.tluszcz_100g     / 100.0), 1)                as tluszcz_g_calosc,
  round(sum(ps.gramy * s.wegle_100g       / 100.0), 1)                as wegle_g_calosc,
  round(sum(ps.gramy * s.blonnik_100g     / 100.0), 1)                as blonnik_g_calosc,
  round(sum(ps.gramy * s.cukry_wolne_100g / 100.0), 1)                as cukry_wolne_g_calosc,

  -- jedna porcja
  round(sum(ps.gramy * s.kcal_100g        / 100.0) / p.porcje)::integer    as kcal,
  round(sum(ps.gramy * s.bialko_100g      / 100.0) / p.porcje, 1)          as bialko_g,
  round(sum(ps.gramy * s.tluszcz_100g     / 100.0) / p.porcje, 1)          as tluszcz_g,
  round(sum(ps.gramy * s.wegle_100g       / 100.0) / p.porcje, 1)          as wegle_g,
  round(sum(ps.gramy * s.blonnik_100g     / 100.0) / p.porcje, 1)          as blonnik_g,
  round(sum(ps.gramy * s.cukry_wolne_100g / 100.0) / p.porcje, 1)          as cukry_wolne_g,

  round(sum(ps.gramy) / p.porcje)::integer                            as gramy_porcji,
  max(s.nova)                                                         as nova_max
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join skladniki s          on s.id = ps.skladnik_id
group by p.id, p.porcje;

comment on view przepis_makro is
  'Makro wyliczane ze składników. Kolumny bez przyrostka dotyczą JEDNEJ PORCJI. Wartości całego garnka mają przyrostek _calosc.';
