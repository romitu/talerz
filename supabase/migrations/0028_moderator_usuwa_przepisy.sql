-- =============================================================================
--  TALERZ — moderator może usuwać przepisy, nie tylko administrator
-- =============================================================================
--  Problem
--  -------
--  Reguła `przepisy_usuwanie` (migracja 0001) pozwalała skasować cudzy albo
--  publiczny przepis wyłącznie administratorowi. Edycja od początku miała
--  osobną regułę dla moderatora (`przepisy_edycja_moderator`) — usuwanie tej
--  drugiej reguły nigdy nie dostało.
--
--  Rozwiązanie
--  -----------
--  Nowa reguła `przepisy_usuwanie_moderator`, obok istniejącej
--  `przepisy_usuwanie` (ta zostaje bez zmian — pilnuje autora i administratora).
--  Reguły dla tej samej operacji łączą się w Postgresie logicznym OR,
--  więc obie działają razem, tak jak już działa para reguł edycji.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

drop policy if exists przepisy_usuwanie_moderator on przepisy;
create policy przepisy_usuwanie_moderator on przepisy
  for delete using (czy_moderator());

notify pgrst, 'reload schema';
