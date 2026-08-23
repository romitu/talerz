-- =============================================================================
--  TALERZ — domyślna kwantyzacja składnika
-- =============================================================================
--  Dwie nowe kolumny w `skladniki`:
--
--    domyslna_kwantyzacja  — liczba: domyślny krok, po jakim wpisuje się
--                             ilość tego składnika w przepisie.
--    jednostka_dk          — jednostka tego kroku, do wyboru z zamkniętej
--                             listy: 1 szt., 10g, 1g, 5 ml, 0.5g.
--
--  Obie nieobowiązkowe — bez wypełnienia formularz przepisu działa tak jak
--  dotąd.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create type jednostka_dk as enum ('1 szt.', '10g', '1g', '5 ml', '0.5g');

alter table skladniki
  add column domyslna_kwantyzacja numeric,
  add column jednostka_dk         jednostka_dk;

comment on column skladniki.domyslna_kwantyzacja is
  'Domyślny krok, po jakim wpisuje się ilość tego składnika w przepisie. Nieobowiązkowe.';

comment on column skladniki.jednostka_dk is
  'Jednostka domyślnej kwantyzacji: 1 szt., 10g, 1g, 5 ml albo 0.5g. Nieobowiązkowe.';

notify pgrst, 'reload schema';
