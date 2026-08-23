-- =============================================================================
--  TALERZ — rola składnika przy skalowaniu porcji
-- =============================================================================
--  Siedem stałych ról (patrz ekran „Role składników”), przypisywanych teraz
--  KAŻDEMU składnikowi z osobna. Wzory skalowania dla poszczególnych ról
--  żyją w kodzie aplikacji, nie w bazie — tutaj zapisujemy wyłącznie to,
--  KTÓRĄ rolę ma dany składnik.
--
--  „Baza” jest domyślna, bo dotyczy większości składników (mięso, kasza,
--  warzywa) — nowy składnik bez wybranej roli skaluje się więc liniowo,
--  co jest bezpiecznym założeniem.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create type rola_skladnika as enum (
  'baza', 'doprawienie', 'aromat', 'smazenie', 'duszenie', 'woda', 'do_smaku'
);

alter table skladniki
  add column rola rola_skladnika not null default 'baza';

comment on column skladniki.rola is
  'Rola przy skalowaniu przepisu na inną liczbę porcji. Wzory dla poszczególnych ról są zaszyte w kodzie aplikacji.';

notify pgrst, 'reload schema';
