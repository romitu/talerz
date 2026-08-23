-- =============================================================================
--  TALERZ — „kwant.” jako wybór tak/nie zamiast liczby
-- =============================================================================
--  Kolumna `skladniki.domyslna_kwantyzacja` (migracja 0030) była wolną liczbą,
--  ale w praktyce liczyło się tylko jedno: czy składnik da się podzielić na
--  dowolną ilość (np. sól), czy tylko na całe sztuki (np. jajko). Kolumna nie
--  była jeszcze używana w żadnym przeliczeniu, więc zamieniamy ją wprost na
--  boolean zamiast dorabiać drugą kolumnę obok.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  drop column domyslna_kwantyzacja,
  add column mozna_dzielic boolean;

comment on column skladniki.mozna_dzielic is
  'Czy składnik można podzielić na dowolną ilość (np. sól) — false gdy tylko na całe sztuki (np. jajko). Nieobowiązkowe.';

notify pgrst, 'reload schema';
