-- =============================================================================
--  TALERZ — poziom aktywności wg czterech kategorii NASEM
-- =============================================================================
--  Problem
--  -------
--  Ekran Profil liczył zapotrzebowanie wzorem Mifflina-St Jeora: przemiana
--  podstawowa razy jeden z pięciu mnożników aktywności (`poziom_aktywnosci`).
--  Zastępuje go biblioteka lib/nasem.ts, oparta na równaniach NASEM 2023
--  (Dietary Reference Intakes for Energy, tabela 5-5) — te dają wynik WPROST,
--  bez pośredniego mnożnika, i mają osobno dopasowane współczynniki dla
--  CZTERECH poziomów aktywności, nie pięciu.
--
--  Rozwiązanie
--  -----------
--  `poziom_aktywnosci` przechodzi z pięciu wartości na cztery, zgodne z NASEM:
--    nieaktywny, malo_aktywny, aktywny, bardzo_aktywny.
--
--  Migracja danych
--  ----------------
--  Środkowe trzy stare wartości trzeba było ścisnąć do dwóch środkowych nowych
--  — NASEM po prostu nie rozróżnia „umiarkowanej” i „dużej” aktywności osobno:
--    siedzacy     -> nieaktywny
--    lekki        -> malo_aktywny
--    umiarkowany  -> aktywny
--    duzy         -> aktywny
--    bardzo_duzy  -> bardzo_aktywny
--
--  Po tej migracji trzeba odświeżyć cache schematu PostgREST (Settings -> API
--  -> Reload schema cache w panelu Supabase), inaczej zapytania z zagnieżdżonym
--  `profile (...)` mogą jeszcze chwilę pamiętać starą definicję enuma.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create type poziom_aktywnosci_nasem as enum ('nieaktywny', 'malo_aktywny', 'aktywny', 'bardzo_aktywny');

alter table profile add column aktywnosc_nowa poziom_aktywnosci_nasem;

update profile set aktywnosc_nowa = (case aktywnosc
  when 'siedzacy' then 'nieaktywny'
  when 'lekki' then 'malo_aktywny'
  when 'umiarkowany' then 'aktywny'
  when 'duzy' then 'aktywny'
  when 'bardzo_duzy' then 'bardzo_aktywny'
end)::poziom_aktywnosci_nasem;

alter table profile
  alter column aktywnosc_nowa set not null,
  alter column aktywnosc_nowa set default 'aktywny';

alter table profile drop column aktywnosc;
alter table profile rename column aktywnosc_nowa to aktywnosc;

drop type poziom_aktywnosci;
alter type poziom_aktywnosci_nasem rename to poziom_aktywnosci;

comment on column profile.wzrost_cm is
  'Niezbędny do równań NASEM (Dietary Reference Intakes for Energy, 2023) liczących zapotrzebowanie energetyczne w lib/nasem.ts.';

notify pgrst, 'reload schema';
