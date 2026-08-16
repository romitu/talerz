-- =============================================================================
--  TALERZ — co naprawdę jest w bazie składników
-- =============================================================================
--  Po co
--  -----
--  Import przepisów szuka składników po nazwie, co do znaku. „Pietruszka
--  korzeń" i „Pietruszka korzeń, surowa" to dla bazy dwie różne rzeczy.
--
--  Zamiast zgadywać, jak nazwałeś składniki dodane ręcznie — pytamy bazę.
--  Skopiuj wynik i wklej mi go, poprawię mapowanie.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

-- --- 1. Czego szuka import, a czego nie ma ---------------------------------
select
  szukane.nazwa                                   as szuka_importu,
  coalesce(
    (select string_agg(s.nazwa, ' | ' order by s.nazwa)
       from skladniki s
      where s.nazwa ilike '%' || split_part(szukane.nazwa, ',', 1) || '%'),
    '— nic podobnego —'
  )                                               as masz_w_bazie
from (values
  ('Udo z kurczaka bez skóry, surowe'),
  ('Pierś z kurczaka, surowa'),
  ('Marchew, surowa'),
  ('Pietruszka korzeń, surowa'),
  ('Pietruszka natka'),
  ('Seler korzeniowy, surowy'),
  ('Por, surowy'),
  ('Cebula, surowa'),
  ('Czosnek, surowy'),
  ('Imbir korzeń, surowy'),
  ('Papryka czerwona, surowa'),
  ('Cytryna'),
  ('Ogórek, surowy'),
  ('Rzodkiewka, surowa'),
  ('Passata pomidorowa'),
  ('Mleko kokosowe light z puszki'),
  ('Pasta curry czerwona'),
  ('Sos sojowy'),
  ('Fasolka szparagowa mrożona'),
  ('Ryż basmati, suchy'),
  ('Jogurt grecki naturalny 2%'),
  ('Twaróg półtłusty'),
  ('Chleb żytni razowy'),
  ('Oliwa z oliwek'),
  ('Szczypiorek świeży'),
  ('Woda')
) as szukane(nazwa)
where not exists (select 1 from skladniki s where s.nazwa = szukane.nazwa)
order by 1;


-- --- 2. Pełna lista, gdyby powyższe nie wystarczyło ------------------------
select nazwa, zrodlo, kcal_100g, masa_sztuki_g
  from skladniki
 order by nazwa;


-- --- 3. Ile masz przepisów i jak się nazywają ------------------------------
--  Import usuwa WYŁĄCZNIE przepisy o nazwach: „Zupa pomidorowa z ryżem”,
--  „Kurczak po tajsku”, „Twaróg z warzywami”. Jeśli nie ma ich na tej liście,
--  import niczego Ci nie skasuje.
select nazwa, porcjowanie, porcja_g, utworzono::date as dodano
  from przepisy
 order by utworzono;
