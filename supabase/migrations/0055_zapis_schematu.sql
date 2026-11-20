-- =============================================================================
--  TALERZ — zapis schematu w jednym kroku (edytor schematów)
-- =============================================================================
--  Po co
--  -----
--  Edytor schematów (app/schematy.tsx) zapisuje cały schemat naraz: nazwę,
--  długość i wszystkie pozycje. Z aplikacji wymagałoby to trzech zapytań —
--  zmiana nagłówka, skasowanie pozycji, wstawienie nowych — bez transakcji.
--  Awaria w połowie zostawiłaby schemat pusty albo z nową nazwą i starymi
--  daniami. Funkcja robi to w jednej transakcji: albo wszystko, albo nic.
--
--  `security invoker` — funkcja działa z uprawnieniami wołającego, więc reguły
--  dostępu z migracji 0054 obowiązują bez zmian: cudzego schematu nie zmieni,
--  bo go po prostu nie zobaczy.
--
--  Wykonanie: SQL Editor w panelu Supabase, po migracji 0054.
-- =============================================================================

create or replace function zapisz_schemat(
  p_schemat_id uuid,
  p_nazwa      text,
  p_dni        smallint,
  p_pozycje    jsonb
)
returns void
language plpgsql
security invoker
set search_path = public
as $$
begin
  update schematy
     set nazwa = trim(p_nazwa),
         dni   = p_dni
   where id = p_schemat_id;

  if not found then
    raise exception 'Nie ma takiego schematu albo nie należy do tego konta'
      using errcode = 'P0002';
  end if;

  delete from schemat_pozycje where schemat_id = p_schemat_id;

  insert into schemat_pozycje (schemat_id, dzien, pora, przepis_id, nazwa, gotowanie, kolejnosc)
  select p_schemat_id, x.dzien, x.pora, x.przepis_id, x.nazwa, x.gotowanie, coalesce(x.kolejnosc, 1)
    from jsonb_to_recordset(coalesce(p_pozycje, '[]'::jsonb)) as x (
      dzien      smallint,
      pora       pora_posilku,
      przepis_id uuid,
      nazwa      text,
      gotowanie  smallint,
      kolejnosc  smallint
    );

  -- Dzień spoza długości schematu to błąd edytora, nie dana do przechowania.
  if exists (select 1 from schemat_pozycje where schemat_id = p_schemat_id and dzien >= p_dni) then
    raise exception 'Pozycja schematu wypada poza jego długość (% dni)', p_dni
      using errcode = '23514';
  end if;
end;
$$;

comment on function zapisz_schemat(uuid, text, smallint, jsonb) is
  'Zastępuje nazwę, długość i wszystkie pozycje schematu w jednej transakcji. Reguły dostępu wołającego obowiązują (security invoker).';

do $$
declare
  rola text;
begin
  foreach rola in array array['authenticated', 'service_role'] loop
    continue when not exists (select 1 from pg_roles where rolname = rola);
    execute format('grant execute on function public.zapisz_schemat(uuid, text, smallint, jsonb) to %I', rola);
  end loop;
end
$$;
