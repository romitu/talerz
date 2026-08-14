-- =============================================================================
--  TALERZ — cel błonnikowy
-- =============================================================================
--  Błonnik dołącza do celów dziennych, bo od migracji 0004 potrafimy go
--  policzyć z przepisów. To ważne rozróżnienie: cel, którego aplikacja nie
--  umie zmierzyć, jest tylko deklaracją.
--
--  Zakresy zaleceń różnią się między źródłami:
--      EFSA                  25 g dla dorosłych, 20 g dla osób starszych
--      normy amerykańskie    14 g na 1000 kcal (kobiety min. 25 g, mężczyźni min. 35 g)
--      WHO                   27–40 g
--
--  Dlatego wartość ustawia użytkownik, a aplikacja jedynie podpowiada
--  i pilnuje — tak samo jak przy białku.
--
--  WODA celowo nie trafia do tej tabeli. Nie pochodzi z jedzenia, więc nie da
--  się jej policzyć z przepisów. Pozostaje wskazówką na ekranie profilu.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table cele
  add column blonnik_g smallint check (blonnik_g between 0 and 100);

comment on column cele.blonnik_g is
  'Dzienny cel błonnikowy. Puste oznacza brak celu — błonnik jest wtedy tylko pokazywany, bez oceny.';
