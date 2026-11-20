-- =============================================================================
--  TALERZ — schematy od dietetyka (etap 3 modułu schematów)
-- =============================================================================
--  Po co
--  -----
--  Dietetyk układa tydzień w edytorze schematów (app/schematy.tsx) na swoim
--  koncie i udostępnia go klientowi — konkretnemu PROFILOWI, tak jak cała
--  współpraca z migracji 0050. Klient widzi taki schemat na zakładce Plan
--  obok własnych i wstawia go do tygodnia sam. Porcje przeliczą się wtedy
--  pod JEGO cel.
--
--  Dietetyk nie dostaje prawa zapisu w planie klienta. Schemat to propozycja,
--  a decyzja o wstawieniu należy do klienta — ta sama zasada co w 0050:
--  dietetyk zmienia tylko cel.
--
--  Dlaczego funkcje, a nie reguły dostępu
--  --------------------------------------
--  Z tego samego powodu co w 0050: ekrany pytają o `schematy` bez filtra
--  „moje” w regułach dostępu. Gdyby reguła wpuściła klienta do schematów
--  dietetyka, pomieszałyby się z własnymi. Klient czyta je więc wyłącznie
--  przez funkcje niżej, które same sprawdzają udostępnienie i to, czy
--  współpraca dalej trwa.
--
--  Koniec współpracy (usunięcie wiersza z dietetyk_podopieczni) odcina dostęp
--  od razu: funkcje wymagają ŻYWEGO powiązania, a nie tylko wiersza tutaj.
--
--  Przepisy prywatne dietetyka
--  ---------------------------
--  Klient widzi tylko przepisy publiczne i własne. Danie z prywatnego przepisu
--  dietetyka zostanie przy wstawianiu pominięte (aplikacja to policzy
--  i powie). Funkcja udostępniająca zwraca, ile takich dań jest, żeby
--  dietetyk wiedział o tym od razu, a nie od klienta.
--
--  Wykonanie: SQL Editor w panelu Supabase, po 0054 i 0055.
-- =============================================================================

create table schematy_udostepnione (
  id           uuid        primary key default gen_random_uuid(),
  schemat_id   uuid        not null references schematy (id) on delete cascade,
  profil_id    uuid        not null references profile (id) on delete cascade,
  dietetyk_id  uuid        not null references konta (id) on delete cascade,
  utworzono    timestamptz not null default now(),
  constraint schematy_udostepnione_raz unique (schemat_id, profil_id)
);

comment on table schematy_udostepnione is
  'Schemat dietetyka udostępniony profilowi klienta. Powstaje tylko przez funkcję dietetyk_udostepnij_schemat; cofnąć może każda ze stron.';

create index schematy_udostepnione_profil_idx on schematy_udostepnione (profil_id);
create index schematy_udostepnione_dietetyk_idx on schematy_udostepnione (dietetyk_id);

alter table schematy_udostepnione enable row level security;

create policy schematy_udostepnione_odczyt on schematy_udostepnione
  for select using (
    dietetyk_id = id_czynnego_konta()
    or exists (select 1 from profile p where p.id = profil_id and p.konto_id = id_czynnego_konta())
  );

-- Cofnąć może każda ze stron: dietetyk wycofuje propozycję, klient ją odrzuca.
create policy schematy_udostepnione_usuwanie on schematy_udostepnione
  for delete using (
    dietetyk_id = id_czynnego_konta()
    or exists (select 1 from profile p where p.id = profil_id and p.konto_id = id_czynnego_konta())
  );


-- =============================================================================
--  FUNKCJE DIETETYKA
-- =============================================================================

/**
  Udostępnia własny schemat klientowi. Zwraca liczbę dań, których klient
  nie zobaczy: z prywatnego przepisu albo z przepisu już usuniętego.
*/
create or replace function dietetyk_udostepnij_schemat(p_schemat uuid, p_profil uuid)
returns integer
language plpgsql
security definer
set search_path = public
as $$
begin
  if not dietetyk_ma_dostep(p_profil) then
    raise exception 'Brak dostępu do tego klienta.' using errcode = '42501';
  end if;

  if not exists (select 1 from schematy s where s.id = p_schemat and s.konto_id = auth.uid()) then
    raise exception 'To nie jest Twój schemat.' using errcode = '42501';
  end if;

  insert into schematy_udostepnione (schemat_id, profil_id, dietetyk_id)
  values (p_schemat, p_profil, auth.uid())
  on conflict (schemat_id, profil_id) do update
    set utworzono = now(), dietetyk_id = excluded.dietetyk_id;

  return (
    select count(*)::integer
      from schemat_pozycje sp
      left join przepisy pr on pr.id = sp.przepis_id
     where sp.schemat_id = p_schemat
       and (pr.id is null or pr.widocznosc <> 'publiczna')
  );
end;
$$;

/** Schematy udostępnione danemu klientowi — do karty klienta w panelu. */
create or replace function dietetyk_schematy_klienta(p_profil uuid)
returns table (schemat_id uuid, nazwa text, dni smallint, od timestamptz)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
begin
  if not dietetyk_ma_dostep(p_profil) then
    raise exception 'Brak dostępu do tego klienta.' using errcode = '42501';
  end if;

  return query
  select s.id, s.nazwa, s.dni, su.utworzono
    from schematy_udostepnione su
    join schematy s on s.id = su.schemat_id
   where su.profil_id = p_profil
     and su.dietetyk_id = auth.uid()
   order by lower(s.nazwa);
end;
$$;


-- =============================================================================
--  FUNKCJE KLIENTA
-- =============================================================================

/*
  Udostępnienie liczy się tylko wtedy, gdy współpraca trwa: ten sam dietetyk
  dalej jest powiązany z profilem, a jego konto jest czynne.
*/
create or replace function udostepnienie_zywe(p_schemat uuid)
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
      from schematy_udostepnione su
      join profile p on p.id = su.profil_id and p.konto_id = id_czynnego_konta()
      join dietetyk_podopieczni dp on dp.profil_id = su.profil_id and dp.dietetyk_id = su.dietetyk_id
      join konta kd on kd.id = su.dietetyk_id and kd.aktywne
     where su.schemat_id = p_schemat
  );
$$;

/** Schematy od dietetyków dla profili zalogowanego konta. */
create or replace function schematy_od_dietetyka()
returns table (
  schemat_id uuid,
  nazwa text,
  dni smallint,
  liczba_dan integer,
  profil_id uuid,
  imie text,
  dietetyk text,
  od timestamptz
)
language sql
stable
security definer
set search_path = public
as $$
  select s.id, s.nazwa, s.dni,
         (select count(*)::integer from schemat_pozycje sp where sp.schemat_id = s.id),
         p.id, p.imie, coalesce(d.nazwa, kd.email), su.utworzono
    from schematy_udostepnione su
    join schematy s on s.id = su.schemat_id
    join profile p on p.id = su.profil_id and p.konto_id = id_czynnego_konta()
    join dietetyk_podopieczni dp on dp.profil_id = su.profil_id and dp.dietetyk_id = su.dietetyk_id
    join konta kd on kd.id = su.dietetyk_id and kd.aktywne
    left join dietetycy d on d.konto_id = su.dietetyk_id
   order by lower(s.nazwa), lower(p.imie);
$$;

/** Pozycje schematu od dietetyka — tylko przy żywym udostępnieniu. */
create or replace function schemat_od_dietetyka_pozycje(p_schemat uuid)
returns table (
  dzien smallint,
  pora pora_posilku,
  przepis_id uuid,
  nazwa text,
  gotowanie smallint,
  kolejnosc smallint
)
language plpgsql
stable
security definer
set search_path = public
as $$
#variable_conflict use_column
begin
  if not udostepnienie_zywe(p_schemat) then
    raise exception 'Ten schemat nie jest już dla Ciebie dostępny.' using errcode = '42501';
  end if;

  return query
  select sp.dzien, sp.pora, sp.przepis_id, sp.nazwa, sp.gotowanie, sp.kolejnosc
    from schemat_pozycje sp
   where sp.schemat_id = p_schemat
   order by sp.dzien, sp.kolejnosc;
end;
$$;


-- =============================================================================
--  UPRAWNIENIA
-- =============================================================================
do $$
declare
  rola text;
begin
  foreach rola in array array['authenticated', 'service_role'] loop
    continue when not exists (select 1 from pg_roles where rolname = rola);
    execute format('grant select, delete on public.schematy_udostepnione to %I', rola);
  end loop;
end
$$;

revoke execute on function dietetyk_udostepnij_schemat(uuid, uuid) from public;
revoke execute on function dietetyk_schematy_klienta(uuid) from public;
revoke execute on function udostepnienie_zywe(uuid) from public;
revoke execute on function schematy_od_dietetyka() from public;
revoke execute on function schemat_od_dietetyka_pozycje(uuid) from public;

do $$
begin
  if exists (select 1 from pg_roles where rolname = 'authenticated') then
    grant execute on function dietetyk_udostepnij_schemat(uuid, uuid) to authenticated;
    grant execute on function dietetyk_schematy_klienta(uuid) to authenticated;
    grant execute on function schematy_od_dietetyka() to authenticated;
    grant execute on function schemat_od_dietetyka_pozycje(uuid) to authenticated;
  end if;
end
$$;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select count(*) as ile_udostepnien from schematy_udostepnione;
