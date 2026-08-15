-- =============================================================================
--  TALERZ — sprzęt bez powtórek
-- =============================================================================
--  Problem
--  -------
--  Kolumna `nazwa` miała ograniczenie UNIQUE, ale PostgreSQL rozróżnia wielkość
--  liter. „Deska do krojenia” i „deska do krojenia” to dla bazy dwie różne
--  pozycje, więc katalog zaczął się dublować. Spacja na końcu daje trzecią.
--
--  Rozwiązanie
--  -----------
--  Nazwy przycinamy, sprowadzamy powtórki do jednej pozycji i zakładamy
--  ograniczenie niewrażliwe na wielkość liter.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

-- 1. Zdjęcie starego ograniczenia MUSI być pierwsze.
--    Inaczej przycięcie „Deska  do krojenia ” do „Deska do krojenia” zderza się
--    z istniejącym wpisem i cała operacja przerywa się w połowie.
alter table sprzet drop constraint if exists sprzet_nazwa_key;
drop index if exists sprzet_nazwa_idx;


-- 2. Przycięcie białych znaków i zbędnych spacji w środku.
update sprzet
   set nazwa = regexp_replace(trim(nazwa), '\s+', ' ', 'g')
 where nazwa <> regexp_replace(trim(nazwa), '\s+', ' ', 'g');


-- 3. Scalenie powtórek różniących się wyłącznie wielkością liter.
--    Zostaje najstarszy wpis; nazwy w przepisach zamieniamy na jego wersję.
do $$
declare
  wiersz record;
  zachowana_nazwa text;
  zachowany_id uuid;
begin
  for wiersz in
    select lower(nazwa) as klucz
      from sprzet
     group by lower(nazwa)
    having count(*) > 1
  loop
    select id, nazwa into zachowany_id, zachowana_nazwa
      from sprzet
     where lower(nazwa) = wiersz.klucz
     order by utworzono, id
     limit 1;

    -- Przepisy przechowują nazwy sprzętu, więc podmieniamy je w tablicach.
    update przepisy
       set sprzet = array(
             select distinct case when lower(x) = wiersz.klucz then zachowana_nazwa else x end
               from unnest(sprzet) as x
           )
     where exists (
             select 1 from unnest(sprzet) as x where lower(x) = wiersz.klucz
           );

    -- Usuwamy po identyfikatorze, a NIE po nazwie.
    -- Po przycięciu białych znaków powtórki bywają identyczne co do znaku,
    -- więc warunek „inna nazwa” nie usunąłby żadnej z nich.
    delete from sprzet
     where lower(nazwa) = wiersz.klucz
       and id <> zachowany_id;
  end loop;
end $$;


-- 4. Ograniczenie niewrażliwe na wielkość liter.
create unique index sprzet_nazwa_klucz on sprzet (lower(nazwa));

comment on index sprzet_nazwa_klucz is
  'Nazwa niepowtarzalna bez względu na wielkość liter — „Deska” i „deska” to ta sama pozycja.';


-- =============================================================================
--  4. WIDOK: KTÓRY SPRZĘT JEST UŻYWANY
-- =============================================================================
--  Sprzęt można usunąć tylko wtedy, gdy nie występuje w żadnym przepisie.
--  Baza nie pilnuje tego kluczem obcym, bo przepisy przechowują nazwy,
--  a nie odwołania — dlatego sprawdzenie robi widok.
-- =============================================================================

create view sprzet_uzycie as
select
  s.id,
  s.nazwa,
  s.rodzaj,
  coalesce(u.ile, 0)::integer      as w_przepisach,
  coalesce(u.przepisy, '{}')       as przepisy
from sprzet s
left join lateral (
  select count(*) as ile, array_agg(p.nazwa order by p.nazwa) as przepisy
    from przepisy p
   where s.nazwa = any (p.sprzet)
) u on true;

comment on view sprzet_uzycie is
  'Sprzęt wraz z wykazem przepisów, w których występuje. Pozycja z zerem może zostać usunięta.';
