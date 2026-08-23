-- =============================================================================
--  TALERZ — pełna lista składników
-- =============================================================================
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

select
  nazwa,
  zrodlo,
  kcal_100g,
  bialko_100g,
  tluszcz_100g,
  wegle_100g,
  cukry_ogolem_100g,
  cukry_wolne_100g,
  nova,
  gramatura_opakowania_g,
  masa_sztuki_g,
  tagi,
  utworzono::date as dodano
from skladniki
order by nazwa;
