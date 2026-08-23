-- =============================================================================
--  TALERZ — usunięcie kolumny „Jednostka - DK”
-- =============================================================================
--  Kolumna `skladniki.jednostka_dk` (migracja 0030) wraz z typem `jednostka_dk`
--  wycofana z aplikacji — zostaje wyłącznie `domyslna_kwantyzacja`.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  drop column jednostka_dk;

drop type jednostka_dk;

notify pgrst, 'reload schema';
