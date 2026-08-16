-- =============================================================================
--  TALERZ — nikt nie awansuje się sam
-- =============================================================================
--  DZIURA, KTÓRĄ TO ZAMYKA
--  -----------------------
--  Reguła dostępu do tabeli `konta` brzmiała:
--
--      create policy konta_zapis_wlasne on konta
--        for update using (id = auth.uid()) with check (id = auth.uid());
--
--  Czyta się to jako „każdy może zmieniać swoje konto” i to jest prawda —
--  tylko że reguły dostępu w PostgreSQL działają na CAŁYCH WIERSZACH, nie na
--  pojedynczych kolumnach. „Swoje konto” obejmowało więc także kolumnę `rola`.
--
--  Dowolny zalogowany użytkownik mógł wykonać jedno zapytanie:
--
--      update konta set rola = 'administrator' where id = <swoje id>;
--
--  i zyskiwał prawo edytowania oraz kasowania cudzych przepisów, zarządzania
--  bazą składników i wgrywania plików do zasobnika. Sprawdzone na prawdziwym
--  PostgreSQL z odtworzoną rolą `authenticated`: podniesienie roli przechodzi
--  bez błędu.
--
--  Dopóki aplikacja chodziła tylko na komputerze Romana, nie miało to znaczenia.
--  Po opublikowaniu w sieci klucz `anon` jest jawny (i tak ma być), a rejestracja
--  domyślnie otwarta — więc wystarczyłby jeden obcy użytkownik.
--
--  JAK TO ZAMYKAMY
--  ---------------
--  Wyzwalaczem, a nie regułą dostępu. Reguły nie potrafią ograniczyć pojedynczej
--  kolumny; osobne uprawnienia kolumnowe potrafią, ale rozjeżdżają się przy
--  każdej zmianie schematu i łatwo je przypadkiem przywrócić. Wyzwalacz pilnuje
--  jednej rzeczy i widać go w jednym miejscu.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create or replace function konta_chron_role()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  -- Bez zmiany roli nie ma o czym mówić.
  if new.rola is not distinct from old.rola then
    return new;
  end if;

  /*
    Połączenia spoza aplikacji przepuszczamy.

    Rozpoznajemy je po BRAKU `auth.uid()`, czyli po tym, że w żądaniu nie ma
    tokenu zalogowanego użytkownika. Tak wygląda panel Supabase, migracje
    i `service_role`. Gdyby wyzwalacz je blokował, nie dałoby się nadać
    pierwszej roli administratora — nie byłoby komu.

    Uwaga na pułapkę: NIE wolno tu sprawdzać `current_user`. Ta funkcja jest
    `security definer`, więc `current_user` zwraca jej WŁAŚCICIELA, a nie rolę,
    z której przyszło żądanie. Pierwsza wersja tego wyzwalacza sprawdzała
    właśnie `current_user` i przepuszczała atak, choć wyglądała poprawnie.
    Wyszło to dopiero w teście, który próbuje awansu naprawdę.
  */
  if auth.uid() is null then
    return new;
  end if;

  if not czy_administrator() then
    raise exception 'Zmiana roli konta wymaga uprawnień administratora.'
      using errcode = '42501';
  end if;

  return new;
end;
$$;

comment on function konta_chron_role is
  'Blokuje samodzielny awans na moderatora i administratora. Reguły dostępu działają na wierszach, więc kolumny „rola” nie dało się osłonić inaczej.';

drop trigger if exists konta_ochrona_roli on konta;
create trigger konta_ochrona_roli
  before update of rola on konta
  for each row execute function konta_chron_role();


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from pg_trigger
    where tgname = 'konta_ochrona_roli' and not tgisinternal) as "wyzwalacz (ma byc 1)",
  (select count(*) from konta where rola = 'administrator') as "administratorow",
  (select count(*) from konta) as "kont razem";
