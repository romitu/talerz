-- =============================================================================
--  TALERZ — role składników widoczne tylko dla moderatora/administratora
-- =============================================================================
--  Do tej pory (migracja 0031) tabelę `role_skladnikow` mógł ODCZYTAĆ każdy
--  zalogowany — bo screen jest o skalowaniu przepisów, więc wydawało się to
--  nieszkodliwą dokumentacją. W praktyce jednak żaden inny ekran tych
--  wierszy nie czyta (skalowanie liczy się w bazie), więc dla zwykłego
--  użytkownika ten ekran to wyłącznie hałas i pytanie „co mogę tu popsuć".
--
--  Zapis już wymagał moderatora (`role_skladnikow_zapis_moderator`) — teraz
--  odczyt dostaje dokładnie te same warunki, przez tę samą funkcję
--  `czy_moderator()` (zwraca true też dla administratora, patrz migracja
--  0023). Ekran `app/role-skladnikow.tsx` sam sprawdza rolę i pokazuje
--  komunikat zamiast pustej tabeli — to tylko UX, prawdziwa bariera jest tu.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

drop policy if exists role_skladnikow_odczyt on role_skladnikow;

create policy role_skladnikow_odczyt on role_skladnikow
  for select using (czy_moderator());
