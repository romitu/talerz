-- =============================================================================
--  TALERZ — konta wyłączane zamiast kasowanych
-- =============================================================================
--  Po co
--  -----
--  Kasowanie konta wymagałoby klucza `service_role`, a ten nie może trafić do
--  strony w przeglądarce — omija wszystkie zabezpieczenia. Wyłączenie załatwia
--  to samo w praktyce: dane zostają, dostęp znika, a przywrócenie to jedno
--  kliknięcie zamiast zakładania konta od nowa.
--
--  DLACZEGO TO MUSI SIEDZIEĆ W BAZIE
--  ---------------------------------
--  Supabase Auth nic nie wie o naszej kolumnie. Wyłączony użytkownik dalej
--  zaloguje się poprawnie i dostanie ważny token — dla usługi logowania to
--  wciąż istniejące konto. Wylogowanie go przez aplikację jest więc wyłącznie
--  grzecznościowe: klucz publiczny jest jawny w opublikowanej stronie, więc
--  ktoś uparty ominie aplikację jednym zapytaniem.
--
--  Prawdziwą granicą są reguły dostępu. Zamiast dopisywać warunek do
--  czterdziestu reguł, podmieniamy SAMĄ TOŻSAMOŚĆ: funkcja `id_czynnego_konta()`
--  zwraca `auth.uid()` tylko wtedy, gdy konto jest czynne, a w przeciwnym razie
--  `null`. Reguła „to moje, bo id się zgadza” przestaje wtedy pasować do
--  czegokolwiek — bez zmiany jej sensu i bez ryzyka, że gdzieś zapomnimy
--  dopisać warunek.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================


-- =============================================================================
--  1. KOLUMNA I TOŻSAMOŚĆ
-- =============================================================================

alter table konta
  add column if not exists aktywne         boolean not null default true,
  add column if not exists wylaczone_kiedy timestamptz,
  add column if not exists wylaczone_przez uuid references konta (id) on delete set null;

/*
  Adres kopiujemy do `konta`, bo aplikacja nie ma dostępu do `auth.users`.

  Bez tego ekran zarządzania kontami pokazywałby wyłącznie identyfikatory —
  ciągi w rodzaju „280f0021-c001-473f…”, po których nie da się rozpoznać
  człowieka. Kopia jest tylko do czytania; prawdziwym adresem zarządza usługa
  logowania i to ona rozstrzyga przy logowaniu.
*/
alter table konta
  add column if not exists email text;

update konta k
   set email = u.email
  from auth.users u
 where u.id = k.id and k.email is distinct from u.email;

create or replace function utworz_konto_po_rejestracji()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into konta (id, email) values (new.id, new.email)
  on conflict (id) do update set email = excluded.email;
  return new;
end;
$$;

comment on column konta.aktywne is
  'Wyłączone konto loguje się poprawnie, ale nie widzi i nie zapisuje żadnych danych. Kasowanie kont wymagałoby klucza service_role, którego nie wolno umieścić w aplikacji.';

/**
 * Tożsamość konta czynnego. Serce całej migracji.
 *
 * SECURITY DEFINER, bo czyta `konta`, na których stoi reguła dostępu — bez
 * tego wpadłaby w rekurencję. STABLE, bo w obrębie jednego zapytania wynik
 * się nie zmienia, a PostgreSQL może go policzyć raz.
 */
create or replace function id_czynnego_konta()
returns uuid
language sql
stable
security definer
set search_path = public
as $$
  select case
    when coalesce((select aktywne from konta where id = auth.uid()), false)
      then auth.uid()
    else null
  end;
$$;

comment on function id_czynnego_konta is
  'auth.uid() dla konta czynnego, null dla wyłączonego. Podmiana tożsamości zamiast dopisywania warunku do każdej reguły z osobna.';


-- =============================================================================
--  2. UPRAWNIENIA MODERATORA I ADMINISTRATORA TEŻ GASNĄ
-- =============================================================================
/*
  Wystarczy przepisać te dwie funkcje — używa ich kilkanaście reguł, więc
  wyłączony moderator traci prawa wszędzie naraz, bez dotykania reguł.
*/
create or replace function czy_moderator()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (select rola in ('moderator', 'administrator') and aktywne
       from konta where id = auth.uid()),
    false
  );
$$;

create or replace function czy_administrator()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (select rola = 'administrator' and aktywne from konta where id = auth.uid()),
    false
  );
$$;


-- =============================================================================
--  3. REGUŁY NA DANYCH UŻYTKOWNIKA
-- =============================================================================
/*
  Wszędzie ta sama zamiana: `auth.uid()` na `id_czynnego_konta()`.

  WYJĄTKIEM jest odczyt własnego konta — musi działać także wtedy, gdy konto
  jest wyłączone. Inaczej aplikacja nie miałaby skąd wiedzieć, że ma pokazać
  komunikat o wyłączeniu, i użytkownik chodziłby po pustych ekranach, nie
  rozumiejąc, co się stało.
*/

drop policy if exists profile_wlasne on profile;
create policy profile_wlasne on profile
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

drop policy if exists cele_wlasne on cele;
create policy cele_wlasne on cele
  for all
  using (exists (select 1 from profile p where p.id = cele.profil_id and p.konto_id = id_czynnego_konta()))
  with check (exists (select 1 from profile p where p.id = cele.profil_id and p.konto_id = id_czynnego_konta()));

drop policy if exists pomiary_wlasne on pomiary;
create policy pomiary_wlasne on pomiary
  for all
  using (exists (select 1 from profile p where p.id = pomiary.profil_id and p.konto_id = id_czynnego_konta()))
  with check (exists (select 1 from profile p where p.id = pomiary.profil_id and p.konto_id = id_czynnego_konta()));

drop policy if exists plany_wlasne on plany;
create policy plany_wlasne on plany
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

drop policy if exists partie_wlasne on partie;
create policy partie_wlasne on partie
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

drop policy if exists plan_pozycje_wlasne on plan_pozycje;
create policy plan_pozycje_wlasne on plan_pozycje
  for all
  using (exists (select 1 from plany p where p.id = plan_pozycje.plan_id and p.konto_id = id_czynnego_konta()))
  with check (exists (select 1 from plany p where p.id = plan_pozycje.plan_id and p.konto_id = id_czynnego_konta()));

drop policy if exists zakupy_reczne_wlasne on zakupy_reczne;
create policy zakupy_reczne_wlasne on zakupy_reczne
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

drop policy if exists zakupy_odhaczone_wlasne on zakupy_odhaczone;
create policy zakupy_odhaczone_wlasne on zakupy_odhaczone
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

drop policy if exists wersje_wlasne on wersje_uzytkownika;
create policy wersje_wlasne on wersje_uzytkownika
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

drop policy if exists polubienia_wlasne on polubienia;
create policy polubienia_wlasne on polubienia
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

-- Przepisy: autorstwo też liczy się tylko dla konta czynnego.
drop policy if exists przepisy_wstawianie on przepisy;
create policy przepisy_wstawianie on przepisy
  for insert with check (autor_id = id_czynnego_konta());

drop policy if exists przepisy_edycja_autor on przepisy;
create policy przepisy_edycja_autor on przepisy
  for update
  using (autor_id = id_czynnego_konta() and widocznosc in ('prywatna', 'zgloszona'))
  with check (autor_id = id_czynnego_konta());

drop policy if exists przepisy_usuwanie on przepisy;
create policy przepisy_usuwanie on przepisy
  for delete using (
    czy_administrator()
    or (autor_id = id_czynnego_konta() and widocznosc in ('prywatna', 'zgloszona'))
  );

drop policy if exists przepisy_odczyt on przepisy;
create policy przepisy_odczyt on przepisy
  for select using (
    widocznosc = 'publiczna'
    or autor_id = id_czynnego_konta()
    or czy_moderator()
  );


-- =============================================================================
--  4. ADMINISTRATOR ZARZĄDZA KONTAMI
-- =============================================================================

/*
  UWAGA na skutek uboczny reguły niżej.

  Nowa reguła pozwala administratorowi zmieniać CUDZE wiersze w `konta` —
  bo bez tego nie wyłączyłby nikomu konta. Ale reguły dostępu działają na
  wierszach, nie na kolumnach, więc razem z aktywnością otworzyłaby się też
  kolumna `rola`: administrator mógłby nadawać uprawnienia z aplikacji,
  choć uzgodniliśmy, że robi się to wyłącznie w panelu.

  Wyszło to dopiero po puszczeniu CAŁEGO zestawu testów — sprawdzenie
  „nawet administrator nie zmienia cudzej roli z aplikacji” z migracji 0021
  przestało przechodzić. Dlatego zaostrzamy tamten wyzwalacz: zmiana roli
  jest teraz odrzucana zawsze, gdy żądanie przychodzi z tokenem, czyli
  z aplikacji. Panel i migracje działają jak dotąd.
*/
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

  -- Brak tokenu = panel Supabase, migracja albo service_role. Tylko tamtędy.
  if auth.uid() is null then
    return new;
  end if;

  raise exception
    'Role nadaje się w panelu Supabase, nie z aplikacji. Aplikacja pozwala jedynie włączać i wyłączać konta.'
    using errcode = '42501';
end;
$$;

drop policy if exists konta_admin_zarzadza on konta;
create policy konta_admin_zarzadza on konta
  for update using (czy_administrator()) with check (czy_administrator());

/**
 * Kto może wyłączać i włączać konta.
 *
 * Ta sama pułapka co przy kolumnie `rola` (migracja 0021): reguły dostępu
 * działają na wierszach, więc bez wyzwalacza użytkownik mógłby sobie po prostu
 * włączyć konto z powrotem — reguła „to mój wiersz” by na to pozwoliła.
 *
 * Administrator nie wyłączy też SAM SIEBIE. Nie chodzi o wygodę: przy jednym
 * administratorze byłoby to zatrzaśnięcie drzwi z kluczem w środku, bo prawa
 * administratora gasną razem z kontem i nie miałby kto ich przywrócić.
 */
create or replace function konta_chron_aktywnosc()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  if new.aktywne is not distinct from old.aktywne then
    return new;
  end if;

  -- Panel Supabase i migracje rozpoznajemy po braku tokenu. Nie sprawdzamy
  -- `current_user` — ta funkcja jest `security definer`, więc zwróciłby jej
  -- właściciela, a nie rolę żądania (patrz komentarz w migracji 0021).
  if auth.uid() is null then
    return new;
  end if;

  if not czy_administrator() then
    raise exception 'Włączanie i wyłączanie kont wymaga uprawnień administratora.'
      using errcode = '42501';
  end if;

  if new.id = auth.uid() and not new.aktywne then
    raise exception 'Nie można wyłączyć własnego konta administratora.'
      using errcode = '42501';
  end if;

  if new.aktywne then
    new.wylaczone_kiedy := null;
    new.wylaczone_przez := null;
  else
    new.wylaczone_kiedy := now();
    new.wylaczone_przez := auth.uid();
  end if;

  return new;
end;
$$;

drop trigger if exists konta_ochrona_aktywnosci on konta;
create trigger konta_ochrona_aktywnosci
  before update of aktywne on konta
  for each row execute function konta_chron_aktywnosc();


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from konta where aktywne)      as "kont czynnych",
  (select count(*) from konta where not aktywne)  as "kont wylaczonych",
  (select count(*) from pg_trigger
    where tgname = 'konta_ochrona_aktywnosci' and not tgisinternal) as "wyzwalacz (ma byc 1)",
  (select count(*) from pg_proc where proname = 'id_czynnego_konta') as "funkcja (ma byc 1)";
