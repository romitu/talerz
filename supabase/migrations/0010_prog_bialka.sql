-- =============================================================================
--  TALERZ — próg białka na posiłek oddzielony od celu dziennego
-- =============================================================================
--  Problem
--  -------
--  Próg posiłkowy wyliczaliśmy dzieląc cel dzienny przez trzy: 128 g ÷ 3 = 43 g.
--  To zakłada, że każdy posiłek wnosi dokładnie tyle samo — a tak się nie je.
--
--  Skutek: zupa, sałatka i większość śniadań zawsze wypadały poniżej progu,
--  niezależnie od tego, do której pory zostały przypisane. Ostrzeżenie odzywało
--  się stale i przestawało cokolwiek znaczyć.
--
--  Rozwiązanie
--  -----------
--  To dwie różne wielkości i tak je traktujemy:
--
--    cel dzienny      — ile białka ma być w ciągu doby (suma)
--    próg posiłkowy   — poniżej ilu gramów posiłek nie pobudza syntezy białek
--
--  Próg posiłkowy nie wynika z celu dziennego. Przyjmowana wartość odniesienia
--  to około 0,4 g na kilogram masy ciała — przy 90 kg daje to 36 g.
--  Wartość ustawia użytkownik; wymaga potwierdzenia w Normach żywienia
--  dla populacji Polski przed uznaniem jej za wiążącą.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table cele
  add column prog_bialka_posilek smallint check (prog_bialka_posilek between 0 and 100);

comment on column cele.prog_bialka_posilek is
  'Ile białka ma mieć pojedynczy posiłek. Puste = brak ostrzeżeń posiłkowych, liczy się tylko suma dnia.';
