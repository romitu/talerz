-- =============================================================================
--  TALERZ — administrator mianuje moderatorów z aplikacji
-- =============================================================================
--  Zmiana decyzji i dlaczego
--  -------------------------
--  Migracje 0021 i 0023 zamykały kolumnę `rola` szczelnie: role nadawało się
--  wyłącznie z panelu Supabase. Rozumowanie brzmiało „im mniej dróg do tej
--  kolumny, tym mniej do pilnowania” i było słuszne, dopóki role pozostawały
--  teoretyczne.
--
--  Przestały nimi być w migracji 0022. Obieg publikacji przepisów opiera się
--  na moderatorach, a mianowanie moderatora wymagało wejścia do SQL Editora,
--  odnalezienia identyfikatora w rodzaju „280f0021-c001-473f…” i napisania
--  zapytania ręcznie. Jedna literówka w identyfikatorze nadaje uprawnienia
--  komuś zupełnie innemu, w dodatku bez ostrzeżenia. Ostrożność, która zmusza
--  do ręcznego przepisywania identyfikatorów, przestaje być ostrożnością.
--
--  CZTERY GRANICE, KTÓRE ZOSTAJĄ
--  -----------------------------
--    1. Role zmienia wyłącznie administrator.
--    2. Wyłącznie między `uzytkownik` a `moderator`.
--    3. Administratora nadaje się TYLKO z panelu. Zdarza się to raz na rok,
--       a przejęta sesja administratora nie może wtedy narobić kolejnych
--       administratorów, którzy zostaliby w bazie nawet po zmianie hasła.
--    4. Nikt nie zmienia własnej roli — ani w górę, ani w dół. W dół dlatego,
--       że jedyny administrator odebrałby sobie klucz do własnego domu.
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
  if new.rola is not distinct from old.rola then
    return new;
  end if;

  -- Brak tokenu = panel Supabase, migracja albo service_role. Tamtędy wolno
  -- wszystko, łącznie z nadaniem pierwszego administratora — inaczej nie
  -- byłoby komu nadać go po założeniu bazy.
  --
  -- NIE sprawdzamy `current_user`: ta funkcja jest `security definer`, więc
  -- zwróciłaby swojego właściciela, a nie rolę, z której przyszło żądanie.
  -- Pierwsza wersja tego wyzwalacza sprawdzała właśnie `current_user`
  -- i przepuszczała atak, wyglądając przy tym całkiem poprawnie.
  if auth.uid() is null then
    return new;
  end if;

  if not czy_administrator() then
    raise exception 'Zmiana roli konta wymaga uprawnień administratora.'
      using errcode = '42501';
  end if;

  if new.id = auth.uid() then
    raise exception 'Własnej roli nie da się zmienić. Poproś innego administratora albo zrób to w panelu Supabase.'
      using errcode = '42501';
  end if;

  if new.rola = 'administrator' or old.rola = 'administrator' then
    raise exception 'Rolę administratora nadaje się i odbiera wyłącznie w panelu Supabase.'
      using errcode = '42501';
  end if;

  return new;
end;
$$;

comment on function konta_chron_role is
  'Administrator mianuje moderatorów z aplikacji. Rola administratora pozostaje poza jej zasięgiem — nadaje się ją w panelu Supabase.';


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  rola,
  count(*) as ile,
  count(*) filter (where aktywne) as czynnych
 from konta
group by rola
order by rola;
