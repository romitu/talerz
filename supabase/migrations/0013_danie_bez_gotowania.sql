-- =============================================================================
--  TALERZ — dania bez obróbki termicznej
-- =============================================================================
--  Problem
--  -------
--  Kolumna `czas_obrobki_min` wymagała wartości większej od zera. Zakładaliśmy,
--  że każde danie się gotuje, piecze albo smaży.
--
--  Nieprawda. „Twaróg z warzywami” to pięć minut przy blacie i zero przy
--  kuchence: rozgnieść twaróg, pokroić rzodkiewki, posmarować chleb.
--  Tak samo sałatka grecka i większość kanapek.
--
--  Przy imporcie ze starego planera baza odrzuciła takie danie w całości.
--  Wyszło to dopiero na teście — SQL wyglądał poprawnie.
--
--  Rozwiązanie
--  -----------
--  Czas obróbki może wynosić zero. Czas przygotowania nadal musi być dodatni,
--  bo danie zerowej pracy nie istnieje — nawet nałożenie na talerz coś zajmuje.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table przepisy
  drop constraint if exists przepisy_czas_obrobki_min_check;

alter table przepisy
  add constraint przepisy_czas_obrobki_min_check
  check (czas_obrobki_min >= 0 and czas_obrobki_min <= 1440);

comment on column przepisy.czas_obrobki_min is
  'Gotowanie, pieczenie, smażenie — czas przy garnku i piekarniku. Zero oznacza danie składane na zimno: sałatkę, pastę, kanapki.';
