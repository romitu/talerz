-- =============================================================================
--  TALERZ — dodatek nie jest porą posiłku
-- =============================================================================
--  Dopełnienie migracji 0014. Osobny plik, bo PostgreSQL nie pozwala użyć
--  świeżo dodanej wartości typu wyliczeniowego w tej samej transakcji,
--  w której ją dodano.
--
--  Co pilnuje
--  ----------
--  Kolumna `plan_pozycje.pora` mówi, o której porze dnia coś jest zjadane.
--  Po dodaniu wartości `dodatek` dałoby się tam wpisać czwartą porę, której
--  w dniu nie ma. Aplikacja tego nie zrobi — oferuje tylko trzy — ale reguła
--  ma stać w bazie, nie w interfejsie. Interfejsy się zmieniają.
--
--  Dodatek trafia do planu tak jak każde inne danie: jako kolejna pozycja
--  w obrębie śniadania, obiadu albo kolacji (`kolejnosc` z migracji 0009).
--
--  Wykonanie: SQL Editor w panelu Supabase, PO migracji 0014.
-- =============================================================================

alter table plan_pozycje
  drop constraint if exists plan_pozycje_pora_to_pora_dnia;

alter table plan_pozycje
  add constraint plan_pozycje_pora_to_pora_dnia
  check (pora in ('sniadanie', 'obiad', 'kolacja'));

comment on column plan_pozycje.pora is
  'Która pora dnia: śniadanie, obiad albo kolacja. „Dodatek” tu nie wejdzie — dodatek jest kategorią przepisu, nie porą.';

comment on column przepisy.pory is
  'Kategorie przepisu: śniadanie, obiad, kolacja, dodatek. Dodatek pojawia się przy wyborze dania do każdego posiłku. Pusta lista oznacza „pasuje wszędzie”.';
