-- =============================================================================
--  TALERZ — liczba porcji bazowych
-- =============================================================================
--  Nowa kolumna `przepisy.liczba_porcji_bazowych`. Na start wypełniana wartością
--  z `trwalosc_dni` („ile dni wytrzyma w lodówce”) — tak zlecono to wypełnienie
--  wprost, bez odrębnego uzasadnienia biznesowego.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table przepisy
  add column liczba_porcji_bazowych smallint not null default 0 check (liczba_porcji_bazowych >= 0);

update przepisy set liczba_porcji_bazowych = trwalosc_dni;

comment on column przepisy.liczba_porcji_bazowych is
  'Liczba porcji bazowych przepisu. Wypełniona przy wprowadzeniu wartością z trwalosc_dni.';

notify pgrst, 'reload schema';
