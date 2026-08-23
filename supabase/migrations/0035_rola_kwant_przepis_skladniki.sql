-- =============================================================================
--  TALERZ — rola i kwantyzacja NA POZIOMIE PRZEPISU
-- =============================================================================
--  `skladniki.rola` i `skladniki.mozna_dzielic` (migracje 0032, 0034) opisują
--  składnik OGÓLNIE — np. „sól” zawsze jest doprawieniem, które można podzielić.
--  Ale to samo warzywo bywa bazą w jednym daniu, a doprawieniem w innym
--  (np. cebula: dużo w gulaszu, odrobina w sosie).
--
--  Dwie nowe kolumny w `przepis_skladniki` pozwalają nadpisać obie wartości
--  TYLKO dla tego jednego użycia składnika w tym przepisie. Formularz przepisu
--  wypełnia je domyślnie wartościami ze składnika przy dodawaniu, a użytkownik
--  może je zmienić — zmiana nie rusza samego składnika w katalogu.
--
--  Obie nieobowiązkowe (`null` = nie ustawiono jawnie dla tego przepisu).
--  Skalowanie porcji, które ma z nich korzystać, zostaje na później.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table przepis_skladniki
  add column rola          rola_skladnika,
  add column mozna_dzielic boolean;

comment on column przepis_skladniki.rola is
  'Rola SKŁADNIKA W TYM PRZEPISIE — domyślnie kopiowana z rola składnika przy dodawaniu, tutaj zmienialna tylko dla tego przepisu. Nieobowiązkowe.';

comment on column przepis_skladniki.mozna_dzielic is
  'Kwantyzacja SKŁADNIKA W TYM PRZEPISIE — domyślnie kopiowana ze składnika, tutaj zmienialna tylko dla tego przepisu. Nieobowiązkowe.';

notify pgrst, 'reload schema';
