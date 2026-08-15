-- =============================================================================
--  TALERZ — kilka dań w jednym posiłku
-- =============================================================================
--  Problem
--  -------
--  Plan dopuszczał jedno danie na porę posiłku. To nie odpowiada temu, jak się
--  je: obiad to zupa i drugie danie, śniadanie to owsianka i jajko, kolacja to
--  sałatka i pieczywo.
--
--  Skutek był widoczny od razu: porcja zupy ogórkowej daje 10 g białka przy
--  progu 43 g, więc aplikacja ostrzegała przy każdym daniu jarzynowym.
--  Ostrzeżenie było formalnie słuszne, a praktycznie bezużyteczne — dotyczyło
--  jednego składnika posiłku, a nie posiłku.
--
--  Rozwiązanie
--  -----------
--  Zdejmujemy ograniczenie „jedno danie na porę”. Pozycje planu dostają
--  kolejność, żeby zupa stała przed drugim daniem. Próg białka liczy się
--  po stronie aplikacji dla sumy dań w danej porze.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table plan_pozycje
  drop constraint if exists plan_pozycje_plan_id_data_pora_key;

alter table plan_pozycje
  add column kolejnosc smallint not null default 1 check (kolejnosc between 1 and 10);

comment on column plan_pozycje.kolejnosc is
  'Kolejność dania w obrębie posiłku: zupa przed drugim daniem, danie główne przed dodatkiem.';

-- Dania w jednym posiłku nie mogą się dublować na tej samej pozycji.
alter table plan_pozycje
  add constraint plan_pozycje_kolejnosc_klucz unique (plan_id, data, pora, kolejnosc);

drop index if exists plan_pozycje_plan_idx;
create index plan_pozycje_plan_idx on plan_pozycje (plan_id, data, pora, kolejnosc);
