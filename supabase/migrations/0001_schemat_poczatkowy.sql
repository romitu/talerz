-- =============================================================================
--  TALERZ — schemat początkowy bazy danych
-- =============================================================================
--  Odpowiada sekcji 5 dokumentu docs/plan-aplikacji.md.
--
--  Zasady, które ten plik realizuje:
--    * plan i pomiary są prywatne — widzi je wyłącznie właściciel konta
--    * przepis publiczny ma jedną wersję, edytuje ją moderator lub administrator
--    * użytkownik tworzy własne wersje prywatne, nie ruszając oryginału
--    * wyłącznie osoby pełnoletnie, maksymalnie 3 profile na konto
--
--  Wykonanie: SQL Editor w panelu Supabase, wklej całość i uruchom.
-- =============================================================================


-- =============================================================================
--  1. TYPY WYLICZENIOWE
-- =============================================================================

create type rola_uzytkownika as enum ('uzytkownik', 'moderator', 'administrator');

create type pora_posilku as enum ('sniadanie', 'obiad', 'kolacja');

create type rodzaj_kuchni as enum ('srodziemnomorska', 'azjatycka', 'polska', 'inna');

create type etap_przepisu as enum ('przygotowanie', 'wykonanie');

create type rodzaj_sprzetu as enum ('piekarnik', 'garnek_cisnieniowy', 'grill_kontaktowy', 'plyta');

create type typ_pomiaru as enum ('waga', 'talia');

create type zrodlo_pomiaru as enum ('reczne', 'health_connect', 'apple_health');

create type widocznosc_przepisu as enum ('prywatna', 'zgloszona', 'publiczna');

create type stan_zgloszenia as enum ('nowe', 'w_toku', 'zamkniete');

create type poziom_aktywnosci as enum ('siedzacy', 'lekki', 'umiarkowany', 'duzy', 'bardzo_duzy');

create type zrodlo_danych as enum ('usda', 'open_food_facts', 'wlasne');

comment on type rodzaj_kuchni is
  'Druga oś etykiet, niezależna od pory posiłku — danie azjatyckie też bywa obiadem.';


-- =============================================================================
--  2. KONTA I ROLE
-- =============================================================================

create table konta (
  id                uuid primary key references auth.users (id) on delete cascade,
  rola              rola_uzytkownika not null default 'uzytkownik',
  zgoda_regulamin   boolean          not null default false,
  zgoda_zdrowie     boolean          not null default false,
  zgoda_data        timestamptz,
  utworzono         timestamptz      not null default now()
);

comment on table konta is
  'Rozszerzenie auth.users o rolę i zgody. Zgoda na dane o zdrowiu jest osobna od regulaminu (RODO, kategoria szczególna).';

alter table konta enable row level security;

-- Funkcja pomocnicza do reguł dostępu.
-- SECURITY DEFINER, żeby odczyt roli nie wpadał w rekurencję z RLS na tabeli konta.
create or replace function rola_biezaca()
returns rola_uzytkownika
language sql
stable
security definer
set search_path = public
as $$
  select rola from konta where id = auth.uid();
$$;

create or replace function czy_moderator()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (select rola in ('moderator', 'administrator') from konta where id = auth.uid()),
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
    (select rola = 'administrator' from konta where id = auth.uid()),
    false
  );
$$;

create policy konta_odczyt_wlasne on konta
  for select using (id = auth.uid() or czy_administrator());

create policy konta_zapis_wlasne on konta
  for update using (id = auth.uid()) with check (id = auth.uid());

create policy konta_wstawianie on konta
  for insert with check (id = auth.uid());

-- Konto powstaje automatycznie razem z użytkownikiem w auth.users.
create or replace function utworz_konto_po_rejestracji()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into konta (id) values (new.id) on conflict do nothing;
  return new;
end;
$$;

create trigger konto_po_rejestracji
  after insert on auth.users
  for each row execute function utworz_konto_po_rejestracji();


-- =============================================================================
--  3. PROFILE I CELE
-- =============================================================================

create table profile (
  id                uuid primary key default gen_random_uuid(),
  konto_id          uuid              not null references konta (id) on delete cascade,
  imie              text              not null check (length(trim(imie)) between 1 and 40),
  plec              char(1)           not null check (plec in ('K', 'M')),
  data_urodzenia    date              not null,
  wzrost_cm         smallint          not null check (wzrost_cm between 120 and 230),
  aktywnosc         poziom_aktywnosci not null default 'umiarkowany',
  kolejnosc         smallint          not null default 1,
  utworzono         timestamptz       not null default now()
);

comment on column profile.wzrost_cm is
  'Niezbędny do wzoru Mifflina-St Jeora. Bez wzrostu nie da się policzyć zapotrzebowania.';

create index profile_konto_idx on profile (konto_id);

alter table profile enable row level security;

create policy profile_wlasne on profile
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());

-- Bariera wieku 18+ oraz limit trzech profili na konto.
create or replace function sprawdz_profil()
returns trigger
language plpgsql
as $$
declare
  liczba_profili integer;
begin
  if new.data_urodzenia > (current_date - interval '18 years') then
    raise exception 'Talerz jest przeznaczony wyłącznie dla osób pełnoletnich.';
  end if;

  if new.data_urodzenia < (current_date - interval '120 years') then
    raise exception 'Nieprawidłowa data urodzenia.';
  end if;

  select count(*) into liczba_profili
    from profile
   where konto_id = new.konto_id
     and id is distinct from new.id;

  if liczba_profili >= 3 then
    raise exception 'Konto może mieć najwyżej 3 profile.';
  end if;

  return new;
end;
$$;

create trigger profil_walidacja
  before insert or update on profile
  for each row execute function sprawdz_profil();


create table cele (
  id             uuid        primary key default gen_random_uuid(),
  profil_id      uuid        not null references profile (id) on delete cascade,
  obowiazuje_od  date        not null default current_date,
  kcal           integer     not null check (kcal between 800 and 6000),
  bialko_g       smallint    not null check (bialko_g between 0 and 400),
  tluszcz_g      smallint    not null check (tluszcz_g between 0 and 300),
  wegle_g        smallint    not null check (wegle_g between 0 and 800),
  utworzono      timestamptz not null default now(),
  unique (profil_id, obowiazuje_od)
);

comment on table cele is
  'Cele obowiązują od daty — historia zmian zachowana. Twarde granice w CHECK, ostrzeżenia miękkie (AMDR) po stronie aplikacji.';

create index cele_profil_idx on cele (profil_id, obowiazuje_od desc);

alter table cele enable row level security;

create policy cele_wlasne on cele
  for all
  using (exists (select 1 from profile p where p.id = cele.profil_id and p.konto_id = auth.uid()))
  with check (exists (select 1 from profile p where p.id = cele.profil_id and p.konto_id = auth.uid()));


create table pomiary (
  id          uuid           primary key default gen_random_uuid(),
  profil_id   uuid           not null references profile (id) on delete cascade,
  typ         typ_pomiaru    not null,
  wartosc     numeric(5, 1)  not null check (wartosc > 0),
  data        date           not null default current_date,
  zrodlo      zrodlo_pomiaru not null default 'reczne',
  utworzono   timestamptz    not null default now(),
  unique (profil_id, typ, data)
);

comment on table pomiary is
  'Waga i obwód talii. Obwód wprowadzany ręcznie — żadne urządzenie go nie podaje.';

create index pomiary_profil_idx on pomiary (profil_id, typ, data desc);

alter table pomiary enable row level security;

create policy pomiary_wlasne on pomiary
  for all
  using (exists (select 1 from profile p where p.id = pomiary.profil_id and p.konto_id = auth.uid()))
  with check (exists (select 1 from profile p where p.id = pomiary.profil_id and p.konto_id = auth.uid()));


-- =============================================================================
--  4. SKŁADNIKI
-- =============================================================================

create table skladniki (
  id                      uuid          primary key default gen_random_uuid(),
  nazwa                   text          not null unique,
  zrodlo                  zrodlo_danych not null,
  zewnetrzny_id           text,
  kcal_100g               numeric(6, 2) not null check (kcal_100g >= 0),
  bialko_100g             numeric(5, 2) not null check (bialko_100g >= 0),
  tluszcz_100g            numeric(5, 2) not null check (tluszcz_100g >= 0),
  wegle_100g              numeric(5, 2) not null check (wegle_100g >= 0),
  cukry_ogolem_100g       numeric(5, 2) not null default 0 check (cukry_ogolem_100g >= 0),
  cukry_wolne_100g        numeric(5, 2) not null default 0 check (cukry_wolne_100g >= 0),
  nova                    smallint      check (nova between 1 and 4),
  gramatura_opakowania_g  integer       check (gramatura_opakowania_g > 0),
  tagi                    text[]        not null default '{}',
  utworzono               timestamptz   not null default now(),
  constraint cukry_wolne_nie_wieksze check (cukry_wolne_100g <= cukry_ogolem_100g)
);

comment on column skladniki.cukry_wolne_100g is
  'Osobno od cukrów ogółem. Etykieta unijna podaje sumę, w tym laktozę i cukier z całych owoców — tej liczby nie wolno użyć wprost.';

comment on column skladniki.gramatura_opakowania_g is
  'Wielkość opakowania ze sklepu — podstawa planowania bez resztek.';

comment on column skladniki.tagi is
  'Etykiety do preferencji żywieniowych (np. mieso, nabial, ryba). NIE JEST to filtr alergenów.';

create index skladniki_tagi_idx on skladniki using gin (tagi);
create index skladniki_nazwa_idx on skladniki (lower(nazwa));

alter table skladniki enable row level security;

create policy skladniki_odczyt on skladniki
  for select using (auth.uid() is not null);

create policy skladniki_zapis_moderator on skladniki
  for all using (czy_moderator()) with check (czy_moderator());


-- =============================================================================
--  5. PRZEPISY
-- =============================================================================

create table przepisy (
  id             uuid                primary key default gen_random_uuid(),
  nazwa          text                not null check (length(trim(nazwa)) between 3 and 120),
  opis           text,
  pory           pora_posilku[]      not null default '{}',
  kuchnie        rodzaj_kuchni[]     not null default '{srodziemnomorska}',
  trwalosc_dni   smallint            not null default 0 check (trwalosc_dni between 0 and 3),
  czas_minut     smallint            check (czas_minut > 0),
  autor_id       uuid                references konta (id) on delete set null,
  widocznosc     widocznosc_przepisu not null default 'prywatna',
  utworzono      timestamptz         not null default now(),
  zmieniono      timestamptz         not null default now()
);

comment on column przepisy.trwalosc_dni is
  '0 = tylko świeże. Maksimum 3 dni, ostrożniej niż zalecenie USDA (3-4 dni przy 4 stopniach).';

comment on column przepisy.widocznosc is
  'Domyślnie prywatna. Publikacja wymaga zgłoszenia przez autora i zatwierdzenia przez moderatora.';

create index przepisy_widocznosc_idx on przepisy (widocznosc);
create index przepisy_autor_idx on przepisy (autor_id);
create index przepisy_pory_idx on przepisy using gin (pory);

alter table przepisy enable row level security;

create policy przepisy_odczyt on przepisy
  for select using (
    widocznosc = 'publiczna'
    or autor_id = auth.uid()
    or czy_moderator()
  );

create policy przepisy_wstawianie on przepisy
  for insert with check (autor_id = auth.uid());

-- Autor zmienia wyłącznie własny przepis prywatny.
-- Przepis publiczny edytuje tylko moderator lub administrator.
create policy przepisy_edycja_autor on przepisy
  for update
  using (autor_id = auth.uid() and widocznosc = 'prywatna')
  with check (autor_id = auth.uid());

create policy przepisy_edycja_moderator on przepisy
  for update using (czy_moderator()) with check (czy_moderator());

create policy przepisy_usuwanie on przepisy
  for delete using (
    czy_administrator()
    or (autor_id = auth.uid() and widocznosc = 'prywatna')
  );


create table przepis_skladniki (
  id              uuid          primary key default gen_random_uuid(),
  przepis_id      uuid          not null references przepisy (id) on delete cascade,
  skladnik_id     uuid          not null references skladniki (id) on delete restrict,
  gramy           numeric(7, 1) not null check (gramy > 0),
  opis_potoczny   text,
  kolejnosc       smallint      not null default 1,
  unique (przepis_id, skladnik_id)
);

comment on column przepis_skladniki.opis_potoczny is
  'Zapis dla człowieka, np. "1 marchewka (ok. 70 g)". Liczy się zawsze pole gramy.';

create index przepis_skladniki_przepis_idx on przepis_skladniki (przepis_id, kolejnosc);

alter table przepis_skladniki enable row level security;

create policy przepis_skladniki_odczyt on przepis_skladniki
  for select using (
    exists (
      select 1 from przepisy p
       where p.id = przepis_skladniki.przepis_id
         and (p.widocznosc = 'publiczna' or p.autor_id = auth.uid() or czy_moderator())
    )
  );

create policy przepis_skladniki_zapis on przepis_skladniki
  for all
  using (
    czy_moderator()
    or exists (
      select 1 from przepisy p
       where p.id = przepis_skladniki.przepis_id
         and p.autor_id = auth.uid()
         and p.widocznosc = 'prywatna'
    )
  )
  with check (
    czy_moderator()
    or exists (
      select 1 from przepisy p
       where p.id = przepis_skladniki.przepis_id
         and p.autor_id = auth.uid()
         and p.widocznosc = 'prywatna'
    )
  );


create table kroki (
  id          uuid          primary key default gen_random_uuid(),
  przepis_id  uuid          not null references przepisy (id) on delete cascade,
  etap        etap_przepisu not null,
  kolejnosc   smallint      not null,
  tresc       text          not null check (length(trim(tresc)) > 0),
  unique (przepis_id, etap, kolejnosc)
);

comment on table kroki is
  'Układ dwuetapowy: najpierw wszystko przygotuj, potem gotuj.';

create index kroki_przepis_idx on kroki (przepis_id, etap, kolejnosc);

alter table kroki enable row level security;

create policy kroki_odczyt on kroki
  for select using (
    exists (
      select 1 from przepisy p
       where p.id = kroki.przepis_id
         and (p.widocznosc = 'publiczna' or p.autor_id = auth.uid() or czy_moderator())
    )
  );

create policy kroki_zapis on kroki
  for all
  using (
    czy_moderator()
    or exists (
      select 1 from przepisy p
       where p.id = kroki.przepis_id and p.autor_id = auth.uid() and p.widocznosc = 'prywatna'
    )
  )
  with check (
    czy_moderator()
    or exists (
      select 1 from przepisy p
       where p.id = kroki.przepis_id and p.autor_id = auth.uid() and p.widocznosc = 'prywatna'
    )
  );


create table czasy_sprzet (
  id       uuid           primary key default gen_random_uuid(),
  krok_id  uuid           not null references kroki (id) on delete cascade,
  sprzet   rodzaj_sprzetu not null,
  minuty   smallint       not null check (minuty > 0),
  unique (krok_id, sprzet)
);

comment on table czasy_sprzet is
  'Warianty czasu dla różnych urządzeń. Aplikacja pokazuje ten pasujący do sprzętu z profilu — użytkownik nic nie edytuje.';

alter table czasy_sprzet enable row level security;

create policy czasy_sprzet_odczyt on czasy_sprzet
  for select using (
    exists (
      select 1 from kroki k join przepisy p on p.id = k.przepis_id
       where k.id = czasy_sprzet.krok_id
         and (p.widocznosc = 'publiczna' or p.autor_id = auth.uid() or czy_moderator())
    )
  );

create policy czasy_sprzet_zapis on czasy_sprzet
  for all using (czy_moderator()) with check (czy_moderator());


create table historia_przepisu (
  id          uuid        primary key default gen_random_uuid(),
  przepis_id  uuid        not null references przepisy (id) on delete cascade,
  kto_id      uuid        references konta (id) on delete set null,
  co          text        not null,
  kiedy       timestamptz not null default now()
);

create index historia_przepisu_idx on historia_przepisu (przepis_id, kiedy desc);

alter table historia_przepisu enable row level security;

create policy historia_odczyt on historia_przepisu
  for select using (czy_moderator());

create policy historia_zapis on historia_przepisu
  for insert with check (czy_moderator());


-- =============================================================================
--  6. WERSJE UŻYTKOWNIKA — prywatna warstwa nad przepisem
-- =============================================================================

create table wersje_uzytkownika (
  id           uuid        primary key default gen_random_uuid(),
  przepis_id   uuid        not null references przepisy (id) on delete cascade,
  konto_id     uuid        not null references konta (id) on delete cascade,
  nazwa        text,
  utworzono    timestamptz not null default now(),
  unique (przepis_id, konto_id)
);

comment on table wersje_uzytkownika is
  'Kopia przepisu w chwili utworzenia. Zmiana oryginału przez moderatora NIE nadpisuje tej wersji — aplikacja jedynie informuje o różnicy.';

alter table wersje_uzytkownika enable row level security;

create policy wersje_wlasne on wersje_uzytkownika
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());


create table wersje_skladniki (
  id           uuid          primary key default gen_random_uuid(),
  wersja_id    uuid          not null references wersje_uzytkownika (id) on delete cascade,
  skladnik_id  uuid          not null references skladniki (id) on delete restrict,
  gramy        numeric(7, 1) not null check (gramy >= 0),
  unique (wersja_id, skladnik_id)
);

comment on column wersje_skladniki.gramy is
  'Zero oznacza składnik pominięty we własnej wersji.';

alter table wersje_skladniki enable row level security;

create policy wersje_skladniki_wlasne on wersje_skladniki
  for all
  using (exists (select 1 from wersje_uzytkownika w where w.id = wersje_skladniki.wersja_id and w.konto_id = auth.uid()))
  with check (exists (select 1 from wersje_uzytkownika w where w.id = wersje_skladniki.wersja_id and w.konto_id = auth.uid()));


create table wersje_kroki (
  id         uuid     primary key default gen_random_uuid(),
  wersja_id  uuid     not null references wersje_uzytkownika (id) on delete cascade,
  krok_id    uuid     not null references kroki (id) on delete cascade,
  minuty     smallint not null check (minuty > 0),
  unique (wersja_id, krok_id)
);

alter table wersje_kroki enable row level security;

create policy wersje_kroki_wlasne on wersje_kroki
  for all
  using (exists (select 1 from wersje_uzytkownika w where w.id = wersje_kroki.wersja_id and w.konto_id = auth.uid()))
  with check (exists (select 1 from wersje_uzytkownika w where w.id = wersje_kroki.wersja_id and w.konto_id = auth.uid()));


-- =============================================================================
--  7. PLANY I PARTIE
-- =============================================================================

create table plany (
  id          uuid        primary key default gen_random_uuid(),
  konto_id    uuid        not null references konta (id) on delete cascade,
  data_start  date        not null,
  dni         smallint    not null default 7 check (dni between 7 and 31),
  utworzono   timestamptz not null default now()
);

comment on column plany.dni is
  'Minimum 7 dni — wymóg z punktu 14 specyfikacji.';

create index plany_konto_idx on plany (konto_id, data_start desc);

alter table plany enable row level security;

create policy plany_wlasne on plany
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());


create table partie (
  id                uuid        primary key default gen_random_uuid(),
  konto_id          uuid        not null references konta (id) on delete cascade,
  przepis_id        uuid        not null references przepisy (id) on delete restrict,
  wersja_id         uuid        references wersje_uzytkownika (id) on delete set null,
  data_ugotowania   date        not null default current_date,
  porcji_razem      smallint    not null check (porcji_razem between 1 and 20),
  porcji_zostalo    smallint    not null check (porcji_zostalo >= 0),
  wazne_do          date        not null,
  utworzono         timestamptz not null default now(),
  constraint porcji_nie_wiecej_niz_razem check (porcji_zostalo <= porcji_razem)
);

comment on table partie is
  'Ugotowany garnek. Osobny byt, nie pole w pozycji planu — to kluczowa decyzja strukturalna projektu.';

create index partie_konto_idx on partie (konto_id, wazne_do);

alter table partie enable row level security;

create policy partie_wlasne on partie
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());

-- Data przydatności wynika z trwałości przepisu, nie z ręcznego wpisu.
create or replace function ustal_wazne_do()
returns trigger
language plpgsql
as $$
declare
  dni smallint;
begin
  select trwalosc_dni into dni from przepisy where id = new.przepis_id;
  new.wazne_do := new.data_ugotowania + coalesce(dni, 0);
  return new;
end;
$$;

create trigger partie_wazne_do
  before insert or update of data_ugotowania, przepis_id on partie
  for each row execute function ustal_wazne_do();


create table plan_pozycje (
  id          uuid         primary key default gen_random_uuid(),
  plan_id     uuid         not null references plany (id) on delete cascade,
  data        date         not null,
  pora        pora_posilku not null,
  przepis_id  uuid         not null references przepisy (id) on delete restrict,
  wersja_id   uuid         references wersje_uzytkownika (id) on delete set null,
  porcje      smallint     not null default 1 check (porcje between 1 and 5),
  partia_id   uuid         references partie (id) on delete set null,
  zjedzone    boolean      not null default false,
  unique (plan_id, data, pora)
);

comment on column plan_pozycje.porcje is
  'Liczba porcji, czyli dla ilu osób gotujemy. Niezależna od liczby profili — dziecko je porcję, ale nie ma profilu.';

comment on column plan_pozycje.zjedzone is
  'Obsługuje zapisywanie przez wyjątek: domyślnie fałsz, potwierdzenie dnia ustawia prawdę hurtem.';

create index plan_pozycje_plan_idx on plan_pozycje (plan_id, data);

alter table plan_pozycje enable row level security;

create policy plan_pozycje_wlasne on plan_pozycje
  for all
  using (exists (select 1 from plany p where p.id = plan_pozycje.plan_id and p.konto_id = auth.uid()))
  with check (exists (select 1 from plany p where p.id = plan_pozycje.plan_id and p.konto_id = auth.uid()));


-- =============================================================================
--  8. NOTATKI, POLUBIENIA, ZGŁOSZENIA
-- =============================================================================

create table notatki (
  id          uuid        primary key default gen_random_uuid(),
  przepis_id  uuid        not null references przepisy (id) on delete cascade,
  konto_id    uuid        not null references konta (id) on delete cascade,
  tresc       text        not null check (length(trim(tresc)) between 1 and 2000),
  publiczna   boolean     not null default false,
  ukryta      boolean     not null default false,
  utworzono   timestamptz not null default now()
);

comment on column notatki.ukryta is
  'Ustawiana przy zgłoszeniu — treść znika z widoku do czasu rozpatrzenia.';

create index notatki_przepis_idx on notatki (przepis_id) where publiczna;

alter table notatki enable row level security;

create policy notatki_odczyt on notatki
  for select using (
    konto_id = auth.uid()
    or czy_moderator()
    or (publiczna and not ukryta)
  );

create policy notatki_wlasne_zapis on notatki
  for insert with check (konto_id = auth.uid());

create policy notatki_wlasna_edycja on notatki
  for update using (konto_id = auth.uid() or czy_moderator());

create policy notatki_usuwanie on notatki
  for delete using (konto_id = auth.uid() or czy_moderator());


create table polubienia (
  przepis_id  uuid        not null references przepisy (id) on delete cascade,
  konto_id    uuid        not null references konta (id) on delete cascade,
  utworzono   timestamptz not null default now(),
  primary key (przepis_id, konto_id)
);

comment on table polubienia is
  'Polubienie znaczy "powtórzę u siebie", nie "ładne zdjęcie".';

alter table polubienia enable row level security;

create policy polubienia_odczyt on polubienia
  for select using (auth.uid() is not null);

create policy polubienia_wlasne on polubienia
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());


create table zgloszenia (
  id              uuid            primary key default gen_random_uuid(),
  typ             text            not null check (typ in ('przepis', 'notatka', 'zdjecie')),
  obiekt_id       uuid            not null,
  zglaszajacy_id  uuid            references konta (id) on delete set null,
  powod           text            not null check (length(trim(powod)) between 3 and 1000),
  stan            stan_zgloszenia not null default 'nowe',
  utworzono       timestamptz     not null default now(),
  rozpatrzono     timestamptz
);

comment on table zgloszenia is
  'Deklarowany czas reakcji: zwykle 24 godziny. Do czasu rozpatrzenia treść pozostaje ukryta.';

create index zgloszenia_stan_idx on zgloszenia (stan, utworzono);

alter table zgloszenia enable row level security;

create policy zgloszenia_wlasne_odczyt on zgloszenia
  for select using (zglaszajacy_id = auth.uid() or czy_moderator());

create policy zgloszenia_wstawianie on zgloszenia
  for insert with check (zglaszajacy_id = auth.uid());

create policy zgloszenia_obsluga on zgloszenia
  for update using (czy_moderator()) with check (czy_moderator());


-- =============================================================================
--  9. WIDOK POMOCNICZY — makro przepisu liczone ze składników
-- =============================================================================
--  Kluczowa zasada projektu: makroskładników nigdy nie wpisujemy ręcznie.
--  Zawsze wynikają ze składników i ich gramatur.
-- =============================================================================

create view przepis_makro as
select
  p.id                                                            as przepis_id,
  round(sum(ps.gramy * s.kcal_100g          / 100.0))::integer    as kcal,
  round(sum(ps.gramy * s.bialko_100g        / 100.0), 1)          as bialko_g,
  round(sum(ps.gramy * s.tluszcz_100g       / 100.0), 1)          as tluszcz_g,
  round(sum(ps.gramy * s.wegle_100g         / 100.0), 1)          as wegle_g,
  round(sum(ps.gramy * s.cukry_wolne_100g   / 100.0), 1)          as cukry_wolne_g,
  max(s.nova)                                                     as nova_max
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join skladniki s          on s.id = ps.skladnik_id
group by p.id;

comment on view przepis_makro is
  'Makro wyliczane, nie wpisywane. nova_max pokazuje najwyższy stopień przetworzenia wśród składników — grupa 4 dyskwalifikuje przepis.';
