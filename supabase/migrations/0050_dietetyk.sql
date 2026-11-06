-- =============================================================================
--  TALERZ — dietetyk i jego podopieczni
-- =============================================================================
--  Po co
--  -----
--  „Specjalista pomaga ustalić cel — Talerz pomaga go codziennie wykonać”
--  (opis-talerza.md). Do tej pory ustalony z dietetykiem cel trzeba było
--  przepisywać ręcznie, a dietetyk nie widział, jak plan wygląda w praktyce.
--
--  Teraz konto z rolą `dietetyk` ma stały kod zaproszenia. Klient wpisuje go
--  przy wybranym profilu i od tej chwili dietetyk:
--    * WIDZI profil (płeć, wiek, wzrost, aktywność), pomiary, historię celów,
--      najnowszy tydzień planu i wykluczone składniki,
--    * ZMIENIA wyłącznie cel: tryb, proporcje makro i — nowość — kcal
--      ustalone na sztywno zamiast liczenia ze wzoru.
--  Klient może odwołać dostęp w każdej chwili, dietetyk może zakończyć
--  współpracę. Usunięcie wiersza powiązania = koniec dostępu, natychmiast.
--
--  Dlaczego FUNKCJE, a nie reguły dostępu
--  --------------------------------------
--  Ekrany aplikacji pytają o plany, profile i pomiary BEZ filtra „moje” —
--  polegają na tym, że reguła dostępu zwraca tylko własne wiersze
--  (np. `pobierzPlany()` w lib/plan.ts). Gdyby reguła wpuściła dietetyka do
--  cudzych planów, zobaczyłby je pomieszane z własnymi na zakładce Plan,
--  a sprzątanie starych tygodni brałoby je pod uwagę.
--
--  Dlatego istniejące reguły zostają BEZ ZMIAN, a dietetyk dostaje dane
--  klientów wyłącznie przez funkcje `dietetyk_*` niżej. Każda z nich sprawdza
--  rolę dietetyka i istnienie powiązania z danym profilem.
--
--  Uwaga techniczna: wartość 'dietetyk' dopisujemy do typu wyliczeniowego
--  w tej samej transakcji, w której powstają funkcje. PostgreSQL nie pozwala
--  UŻYĆ nowej wartości przed zatwierdzeniem transakcji, dlatego wszędzie
--  porównujemy `rola::text = 'dietetyk'`, a nie `rola = 'dietetyk'`.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================


-- =============================================================================
--  1. ROLA
-- =============================================================================
/*
  Nadaje ją administrator na ekranie Użytkownicy — wyzwalacz z migracji 0024
  już na to pozwala (zabrania tylko zmiany własnej roli i roli administratora).
*/
alter type rola_uzytkownika add value if not exists 'dietetyk';

create or replace function czy_dietetyk()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(
    (select rola::text = 'dietetyk' and aktywne from konta where id = auth.uid()),
    false
  );
$$;

comment on function czy_dietetyk is
  'Czy zalogowane konto jest czynnym dietetykiem. Wyłączone konto traci uprawnienia od razu, jak moderator w 0023.';


-- =============================================================================
--  2. KOD ZAPROSZENIA
-- =============================================================================
create table dietetycy (
  konto_id   uuid        primary key references konta (id) on delete cascade,
  kod        text        not null unique check (kod ~ '^[A-HJ-NP-Z2-9]{6}$'),
  nazwa      text        check (nazwa is null or length(trim(nazwa)) between 2 and 80),
  utworzono  timestamptz not null default now()
);

comment on table dietetycy is
  'Kod zaproszenia dietetyka i nazwa, którą widzi klient. Wiersz powstaje przy pierwszym otwarciu panelu (funkcja dietetyk_moj_kod).';

alter table dietetycy enable row level security;

-- Dietetyk widzi i podpisuje tylko siebie. Kod zmienia funkcja, nie zapis wprost.
create policy dietetycy_wlasne_odczyt on dietetycy
  for select using (konto_id = id_czynnego_konta());

create policy dietetycy_wlasne_nazwa on dietetycy
  for update using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());

/*
  Kod bez liter i cyfr, które łatwo pomylić przy przepisywaniu z kartki
  (0/O, 1/I). 32 znaki ^ 6 = ponad miliard kombinacji.
*/
create or replace function nowy_kod_dietetyka()
returns text
language plpgsql
volatile
set search_path = public
as $$
declare
  znaki constant text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  v_kod text;
begin
  loop
    v_kod := '';
    for i in 1..6 loop
      v_kod := v_kod || substr(znaki, 1 + floor(random() * length(znaki))::int, 1);
    end loop;
    exit when not exists (select 1 from dietetycy d where d.kod = v_kod);
  end loop;
  return v_kod;
end;
$$;

/** Kod zalogowanego dietetyka — przy pierwszym wywołaniu tworzy go. */
create or replace function dietetyk_moj_kod()
returns table (kod text, nazwa text)
language plpgsql
security definer
set search_path = public
as $$
#variable_conflict use_column
begin
  if not czy_dietetyk() then
    raise exception 'Panel dietetyka wymaga roli dietetyka.' using errcode = '42501';
  end if;

  insert into dietetycy (konto_id, kod)
  values (auth.uid(), nowy_kod_dietetyka())
  on conflict (konto_id) do nothing;

  return query select d.kod, d.nazwa from dietetycy d where d.konto_id = auth.uid();
end;
$$;

/**
  Nowy kod — gdy stary trafił w niepowołane ręce. Dotychczasowi klienci
  zostają; kod służy tylko do nawiązania współpracy.
*/
create or replace function dietetyk_zmien_kod()
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  nowy text;
begin
  if not czy_dietetyk() then
    raise exception 'Panel dietetyka wymaga roli dietetyka.' using errcode = '42501';
  end if;

  nowy := nowy_kod_dietetyka();
  update dietetycy set kod = nowy where konto_id = auth.uid();
  if not found then
    insert into dietetycy (konto_id, kod) values (auth.uid(), nowy);
  end if;
  return nowy;
end;
$$;


-- =============================================================================
--  3. POWIĄZANIE DIETETYK — PROFIL
-- =============================================================================
/*
  Per PROFIL, nie per konto: konto może mieć do czterech osób, a dietetyk
  jednej z nich nie ma czego szukać w danych pozostałych.

  Jeden dietetyk na profil — „Mój dietetyk” to jedna osoba. Zmiana dietetyka
  = odwołanie i wpisanie nowego kodu.

  Brak reguły INSERT: powiązanie powstaje wyłącznie przez funkcję
  `polacz_z_dietetykiem`, która sprawdza kod i własność profilu.
*/
create table dietetyk_podopieczni (
  id           uuid        primary key default gen_random_uuid(),
  dietetyk_id  uuid        not null references konta (id) on delete cascade,
  profil_id    uuid        not null unique references profile (id) on delete cascade,
  utworzono    timestamptz not null default now()
);

create index dietetyk_podopieczni_dietetyk_idx on dietetyk_podopieczni (dietetyk_id);

comment on table dietetyk_podopieczni is
  'Zgoda klienta na wgląd dietetyka w dany profil. Usunięcie wiersza (przez klienta albo dietetyka) natychmiast odbiera dostęp.';

alter table dietetyk_podopieczni enable row level security;

create policy dietetyk_podopieczni_odczyt on dietetyk_podopieczni
  for select using (
    dietetyk_id = id_czynnego_konta()
    or exists (select 1 from profile p where p.id = profil_id and p.konto_id = id_czynnego_konta())
  );

-- Odwołać może każda ze stron.
create policy dietetyk_podopieczni_usuwanie on dietetyk_podopieczni
  for delete using (
    dietetyk_id = id_czynnego_konta()
    or exists (select 1 from profile p where p.id = profil_id and p.konto_id = id_czynnego_konta())
  );

/** Klient wpisuje kod dietetyka przy swoim profilu. Zwraca nazwę dietetyka. */
create or replace function polacz_z_dietetykiem(p_kod text, p_profil uuid)
returns text
language plpgsql
security definer
set search_path = public
as $$
declare
  v_dietetyk uuid;
  v_nazwa text;
begin
  if not exists (select 1 from profile p where p.id = p_profil and p.konto_id = id_czynnego_konta()) then
    raise exception 'To nie jest Twój profil.' using errcode = '42501';
  end if;

  select d.konto_id, coalesce(d.nazwa, k.email)
    into v_dietetyk, v_nazwa
    from dietetycy d
    join konta k on k.id = d.konto_id
   where d.kod = upper(trim(p_kod))
     and k.rola::text = 'dietetyk'
     and k.aktywne;

  if v_dietetyk is null then
    raise exception 'Nie ma dietetyka z takim kodem.' using errcode = 'P0002';
  end if;

  if v_dietetyk = auth.uid() then
    raise exception 'Nie możesz zostać własnym dietetykiem.' using errcode = '22023';
  end if;

  insert into dietetyk_podopieczni (dietetyk_id, profil_id)
  values (v_dietetyk, p_profil)
  on conflict (profil_id) do update
    set dietetyk_id = excluded.dietetyk_id, utworzono = now();

  return v_nazwa;
end;
$$;

/** Dietetycy profili zalogowanego konta — do ekranu „Mój dietetyk”. */
create or replace function moi_dietetycy()
returns table (profil_id uuid, dietetyk_id uuid, nazwa text, email text, od timestamptz)
language sql
stable
security definer
set search_path = public
as $$
  select dp.profil_id, dp.dietetyk_id, d.nazwa, k.email, dp.utworzono
    from dietetyk_podopieczni dp
    join profile p on p.id = dp.profil_id
    join konta k on k.id = dp.dietetyk_id
    left join dietetycy d on d.konto_id = dp.dietetyk_id
   where p.konto_id = id_czynnego_konta();
$$;


-- =============================================================================
--  4. CEL USTALONY PRZEZ DIETETYKA
-- =============================================================================
/*
  `kcal_ustalone` — gdy wpisane, ma pierwszeństwo przed wzorem NASEM
  (lib/nasem.ts). Dietetyk zwykle podaje konkretną liczbę, a nie tryb.
  Proporcje makro dzielą tę liczbę tak samo jak wyliczoną.

  `ustawil_dietetyk` — kto ustawił cel. Formularz profilu przenosi taki cel
  dalej przy zapisie, zamiast nadpisywać go domyślnymi 25/30/45.
*/
alter table cele
  add column if not exists kcal_ustalone integer check (kcal_ustalone between 800 and 6000),
  add column if not exists ustawil_dietetyk uuid references konta (id) on delete set null;

comment on column cele.kcal_ustalone is
  'Kcal ustalone przez dietetyka. Null = liczone na bieżąco wzorem NASEM z profilu i ostatniej wagi.';
comment on column cele.ustawil_dietetyk is
  'Konto dietetyka, który ustawił ten cel. Null = cel ustawiony przez samego użytkownika.';


-- =============================================================================
--  5. FUNKCJE PANELU DIETETYKA
-- =============================================================================

/** Sprawdzenie wspólne dla wszystkich funkcji odczytu i zapisu klienta. */
create or replace function dietetyk_ma_dostep(p_profil uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select czy_dietetyk() and exists (
    select 1
      from dietetyk_podopieczni dp
      join profile p on p.id = dp.profil_id
      join konta k on k.id = p.konto_id
     where dp.profil_id = p_profil
       and dp.dietetyk_id = auth.uid()
       and k.aktywne
  );
$$;

/** Lista klientów z ostatnią wagą — lewa kolumna panelu. */
create or replace function dietetyk_klienci()
returns table (
  profil_id uuid,
  imie text,
  plec char(1),
  data_urodzenia date,
  wzrost_cm smallint,
  aktywnosc text,
  waga numeric,
  data_wagi date,
  od timestamptz
)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
begin
  if not czy_dietetyk() then
    raise exception 'Panel dietetyka wymaga roli dietetyka.' using errcode = '42501';
  end if;

  return query
  select p.id, p.imie, p.plec, p.data_urodzenia, p.wzrost_cm, p.aktywnosc::text,
         w.wartosc, w.data, dp.utworzono
    from dietetyk_podopieczni dp
    join profile p on p.id = dp.profil_id
    join konta k on k.id = p.konto_id and k.aktywne
    left join lateral (
      select pm.wartosc, pm.data from pomiary pm
       where pm.profil_id = p.id and pm.typ = 'waga'
       order by pm.data desc limit 1
    ) w on true
   where dp.dietetyk_id = auth.uid()
   order by lower(p.imie);
end;
$$;

/**
  Wszystko o jednym kliencie w jednym zapytaniu (jsonb):
    profil, pomiary (ostatnie 180 dni), cele (historia), wykluczone składniki
    i najnowszy tydzień planu z makro jednej porcji każdej pozycji.

  Makro pozycji liczymy tak samo jak `pobierzPozycje` w lib/plan.ts: z wariantu
  skalowanego, jeśli jest, inaczej z przepisu źródłowego. Jeden talerz na
  pozycję — patrz komentarz przy `bialkoPosilku`.
*/
create or replace function dietetyk_klient(p_profil uuid)
returns jsonb
language plpgsql
stable
security definer
set search_path = public
as $$
declare
  v_konto uuid;
  v_plan record;
  wynik jsonb;
begin
  if not dietetyk_ma_dostep(p_profil) then
    raise exception 'Brak dostępu do tego klienta.' using errcode = '42501';
  end if;

  select konto_id into v_konto from profile where id = p_profil;

  select pl.id, pl.data_start, pl.dni into v_plan
    from plany pl
   where pl.konto_id = v_konto
   order by pl.data_start desc
   limit 1;

  select jsonb_build_object(
    'profil', (
      select jsonb_build_object(
        'id', p.id, 'imie', p.imie, 'plec', p.plec, 'data_urodzenia', p.data_urodzenia,
        'wzrost_cm', p.wzrost_cm, 'aktywnosc', p.aktywnosc,
        'liczba_osob', (select count(*) from profile p2 where p2.konto_id = v_konto)
      )
      from profile p where p.id = p_profil
    ),
    'pomiary', coalesce((
      select jsonb_agg(jsonb_build_object('typ', pm.typ, 'wartosc', pm.wartosc, 'data', pm.data) order by pm.data)
        from pomiary pm
       where pm.profil_id = p_profil and pm.data >= current_date - 180
    ), '[]'::jsonb),
    'cele', coalesce((
      select jsonb_agg(jsonb_build_object(
               'obowiazuje_od', c.obowiazuje_od, 'tryb', c.tryb,
               'bialko_procent', c.bialko_procent, 'tluszcz_procent', c.tluszcz_procent,
               'wegle_procent', c.wegle_procent, 'blonnik_g', c.blonnik_g,
               'prog_bialka_posilek', c.prog_bialka_posilek,
               'kcal_ustalone', c.kcal_ustalone,
               'od_dietetyka', c.ustawil_dietetyk is not null
             ) order by c.obowiazuje_od desc)
        from cele c where c.profil_id = p_profil
    ), '[]'::jsonb),
    'wykluczone', coalesce((
      select jsonb_agg(s.nazwa order by lower(s.nazwa))
        from wykluczone_skladniki ws
        join skladniki s on s.id = ws.skladnik_id
       where ws.konto_id = v_konto
    ), '[]'::jsonb),
    'plan', case when v_plan.id is null then null else jsonb_build_object(
      'data_start', v_plan.data_start,
      'dni', v_plan.dni,
      'pozycje', coalesce((
        select jsonb_agg(jsonb_build_object(
                 'data', pp.data, 'pora', pp.pora, 'nazwa', pr.nazwa,
                 'zjedzone', pp.zjedzone,
                 'kcal', coalesce(ms.kcal, m.kcal, 0),
                 'bialko_g', coalesce(ms.bialko_g, m.bialko_g, 0),
                 'tluszcz_g', coalesce(ms.tluszcz_g, m.tluszcz_g, 0),
                 'wegle_g', coalesce(ms.wegle_g, m.wegle_g, 0),
                 'blonnik_g', coalesce(ms.blonnik_g, m.blonnik_g, 0)
               ) order by pp.data, pp.kolejnosc)
          from plan_pozycje pp
          join przepisy pr on pr.id = pp.przepis_id
          left join przepis_makro m on m.przepis_id = pp.przepis_id and pp.przepis_skalowany_id is null
          left join przepis_skalowany_makro ms on ms.przepis_skalowany_id = pp.przepis_skalowany_id
         where pp.plan_id = v_plan.id
      ), '[]'::jsonb)
    ) end
  ) into wynik;

  return wynik;
end;
$$;

/**
  Dietetyk ustawia cel. Zapis na dzisiejszą datę — historia celów zostaje,
  jak przy zapisie z formularza profilu. Błonnik i próg białka na posiłek
  przechodzą z poprzedniego celu, bo dietetyk ich tu nie ustawia.
*/
create or replace function dietetyk_ustaw_cel(
  p_profil uuid,
  p_tryb tryb_celu,
  p_bialko_procent smallint,
  p_tluszcz_procent smallint,
  p_wegle_procent smallint,
  p_kcal_ustalone integer
)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  poprzedni record;
begin
  if not dietetyk_ma_dostep(p_profil) then
    raise exception 'Brak dostępu do tego klienta.' using errcode = '42501';
  end if;

  select c.blonnik_g, c.prog_bialka_posilek into poprzedni
    from cele c
   where c.profil_id = p_profil
   order by c.obowiazuje_od desc
   limit 1;

  insert into cele (
    profil_id, obowiazuje_od, tryb,
    bialko_procent, tluszcz_procent, wegle_procent,
    blonnik_g, prog_bialka_posilek,
    kcal_ustalone, ustawil_dietetyk
  ) values (
    p_profil, current_date, p_tryb,
    p_bialko_procent, p_tluszcz_procent, p_wegle_procent,
    poprzedni.blonnik_g, poprzedni.prog_bialka_posilek,
    p_kcal_ustalone, auth.uid()
  )
  on conflict (profil_id, obowiazuje_od) do update set
    tryb = excluded.tryb,
    bialko_procent = excluded.bialko_procent,
    tluszcz_procent = excluded.tluszcz_procent,
    wegle_procent = excluded.wegle_procent,
    kcal_ustalone = excluded.kcal_ustalone,
    ustawil_dietetyk = excluded.ustawil_dietetyk;
end;
$$;


-- =============================================================================
--  6. UPRAWNIENIA
-- =============================================================================
/*
  Jak w 0044/0049: Data API widzi tylko tabele, do których rola ma GRANT.
  Funkcji nie wystawiamy anonimowi — wszystkie wymagają zalogowania.
*/
do $$
declare
  rola text;
begin
  foreach rola in array array['authenticated', 'service_role'] loop
    continue when not exists (select 1 from pg_roles where rolname = rola);
    execute format('grant select, update on public.dietetycy to %I', rola);
    execute format('grant select, delete on public.dietetyk_podopieczni to %I', rola);
  end loop;
end
$$;

revoke execute on function nowy_kod_dietetyka() from public;
revoke execute on function czy_dietetyk() from public;
revoke execute on function dietetyk_ma_dostep(uuid) from public;
revoke execute on function dietetyk_moj_kod() from public;
revoke execute on function dietetyk_zmien_kod() from public;
revoke execute on function polacz_z_dietetykiem(text, uuid) from public;
revoke execute on function moi_dietetycy() from public;
revoke execute on function dietetyk_klienci() from public;
revoke execute on function dietetyk_klient(uuid) from public;
revoke execute on function dietetyk_ustaw_cel(uuid, tryb_celu, smallint, smallint, smallint, integer) from public;

do $$
begin
  if exists (select 1 from pg_roles where rolname = 'authenticated') then
    grant execute on function czy_dietetyk() to authenticated;
    grant execute on function dietetyk_moj_kod() to authenticated;
    grant execute on function dietetyk_zmien_kod() to authenticated;
    grant execute on function polacz_z_dietetykiem(text, uuid) to authenticated;
    grant execute on function moi_dietetycy() to authenticated;
    grant execute on function dietetyk_klienci() to authenticated;
    grant execute on function dietetyk_klient(uuid) to authenticated;
    grant execute on function dietetyk_ustaw_cel(uuid, tryb_celu, smallint, smallint, smallint, integer) to authenticated;
  end if;
end
$$;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from konta where rola::text = 'dietetyk') as dietetykow,
  (select count(*) from dietetyk_podopieczni) as powiazan,
  (select count(*) from information_schema.columns
    where table_name = 'cele' and column_name in ('kcal_ustalone', 'ustawil_dietetyk')) as nowe_kolumny_celu;
