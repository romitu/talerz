-- =============================================================================
--  TALERZ — każdy użytkownik może dopisać składnik, edycja zostaje moderatorowi
-- =============================================================================
--  Problem
--  -------
--  Reguła `skladniki_zapis_moderator` (migracja 0001) obejmowała `for all`,
--  czyli INSERT, UPDATE i DELETE naraz — dodać nowy składnik do katalogu mógł
--  więc wyłącznie moderator albo administrator. Zwykłe konto, dodając własny
--  przepis, nie miało jak dopisać brakującego składnika.
--
--  Rozwiązanie
--  -----------
--  Rozbijamy jedną regułę na trzy, po operacji:
--    * `skladniki_wstawianie` — dowolne zalogowane konto może dodać nowy wiersz.
--    * `skladniki_edycja_moderator` / `skladniki_usuwanie_moderator` — edycja
--      i kasowanie zostają wyłącznie dla moderatora/administratora, tak jak
--      dotąd. Bez wyjątku dla autora — `skladniki` nie ma kolumny właściciela
--      (w odróżnieniu od `przepisy`), więc każdy dodany wiersz od razu
--      dołącza do wspólnego katalogu i porządkuje go już tylko moderator.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

drop policy if exists skladniki_zapis_moderator on skladniki;

create policy skladniki_wstawianie on skladniki
  for insert with check (auth.uid() is not null);

create policy skladniki_edycja_moderator on skladniki
  for update using (czy_moderator()) with check (czy_moderator());

create policy skladniki_usuwanie_moderator on skladniki
  for delete using (czy_moderator());

notify pgrst, 'reload schema';
