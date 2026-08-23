-- =============================================================================
--  TALERZ — cel kaloryczny liczony na bieżąco, nie zapisany na sztywno
-- =============================================================================
--  Problem
--  -------
--  `cele.kcal` było liczbą zamrożoną w chwili zapisu. Ekran „Cele dzienne”
--  obok niej pokazywał „Zapotrzebowanie dzienne” policzone NA ŻYWO z aktualnej
--  wagi/wzrostu/wieku/aktywności. Te dwie liczby z definicji się rozjeżdżały,
--  gdy tylko coś w profilu się zmieniło (zwłaszcza waga) — a użytkownika to
--  myliło, bo w zakładce Profil widział starą, zamrożoną liczbę.
--
--  Rozwiązanie
--  -----------
--  Cel przestaje być liczbą. Zapisujemy wyłącznie:
--    * `tryb`            — redukcja (deficyt) albo utrzymanie wagi
--    * proporcje makro    — ile % energii ma iść na białko/tłuszcz/węglowodany
--
--  Kcal i gramy makroskładników liczy aplikacja przy każdym wyświetleniu,
--  z aktualnej wagi/wzrostu/wieku/aktywności profilu (lib/zywienie.ts,
--  funkcja celZywieniowy). Zmiana wagi natychmiast przesuwa cel we wszystkich
--  miejscach, zamiast zostawiać go w tyle do następnego ręcznego zapisu.
--
--  Błonnik i próg białka na posiłek zostają jak były — to wartości w gramach,
--  niezależne od wybranego trybu, i tak już z podpowiedzią liczoną na żywo.
--
--  Migracja danych
--  ----------------
--  Stare wpisy nie mają zapisanego trybu ani proporcji — przybliżamy je
--  z dotychczasowych gramów (procent energii z białka/tłuszczu, węglowodany
--  dobierają resztę do 100). Tryb zgadnąć się nie da, więc każdy istniejący
--  cel ląduje jako „utrzymanie” — kto celował w redukcję, przełączy tryb
--  ręcznie przy najbliższej wizycie w Cele dzienne.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create type tryb_celu as enum ('redukcja', 'utrzymanie');

alter table cele
  add column tryb tryb_celu not null default 'utrzymanie',
  add column bialko_procent smallint,
  add column tluszcz_procent smallint,
  add column wegle_procent smallint;

-- Przybliżenie starych gramów jako procentów energii z tego samego wiersza.
update cele set
  bialko_procent = round((bialko_g * 4.0 * 100) / greatest(kcal, 1)),
  tluszcz_procent = round((tluszcz_g * 9.0 * 100) / greatest(kcal, 1))
where kcal > 0;

update cele set
  wegle_procent = 100 - coalesce(bialko_procent, 0) - coalesce(tluszcz_procent, 0)
where kcal > 0;

-- Wiersze bez sensownego kcal (nie powinno ich być, ale ostrożnie) dostają
-- domyślny podział w środku AMDR.
update cele set bialko_procent = 25, tluszcz_procent = 30, wegle_procent = 45
where bialko_procent is null or tluszcz_procent is null or wegle_procent is null;

alter table cele
  alter column bialko_procent set not null,
  alter column tluszcz_procent set not null,
  alter column wegle_procent set not null,
  add constraint cele_procent_bialko check (bialko_procent between 0 and 100),
  add constraint cele_procent_tluszcz check (tluszcz_procent between 0 and 100),
  add constraint cele_procent_wegle check (wegle_procent between 0 and 100),
  add constraint cele_udzialy_100 check (bialko_procent + tluszcz_procent + wegle_procent = 100);

alter table cele
  drop column kcal,
  drop column bialko_g,
  drop column tluszcz_g,
  drop column wegle_g;

comment on table cele is
  'Tryb i proporcje makro — kcal i gramy liczy aplikacja na bieżąco z wagi/wzrostu/wieku/aktywności profilu (lib/zywienie.ts). Historia po dacie zachowana (obowiazuje_od).';
