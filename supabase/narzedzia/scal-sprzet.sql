-- =============================================================================
--  TALERZ — scalenie powtórek w katalogu sprzętu
-- =============================================================================
--  Katalog ma zostać zwarty: jedna nazwa na jedno narzędzie. Migracja 0011
--  scaliła powtórki różniące się wielkością liter; tu scalamy te, które różnią
--  się słowami („Grillownica kontaktowa” = „Grill kontaktowy”).
--
--  Co zostaje i dlaczego
--  ---------------------
--  Grill kontaktowy     ← Grillownica kontaktowa, Toster / grill kontaktowy
--                         Tak nazywa to urządzenie profil (grill_kontaktowy).
--  Garnek ciśnieniowy   ← Szybkowar / multicooker ciśnieniowy
--                         Jak wyżej (garnek_cisnieniowy); obejmuje też multicooker.
--  Naczynie żaroodporne ← Naczynie żaroodporne / blacha
--                         Blacha do pieczenia zostaje osobno — to inne naczynie.
--  Blender ręczny       ← Blender
--                         Kielichowy zostaje osobno — robi co innego.
--  Miska                ← miska, Miseczka do hartowania śmietany
--                         Miseczka to po prostu miska; „miska” małą literą nie
--                         pasowała do „Miska” w przepisach (widok sprzet_uzycie
--                         porównuje nazwy dokładnie i pokazywał 0 użyć).
--  Łyżka cedzakowa      ← łyżkę cedzakowa (literówka)
--
--  Przepisy przechowują nazwy sprzętu (przepisy.sprzet), więc podmieniamy je
--  w tablicach — z zachowaniem kolejności i bez dublowania, gdy przepis miał
--  obie wersje. Przy okazji każdą nazwę w przepisie ujednolicamy do pisowni
--  z katalogu.
--
--  Zwykłe instrukcje, bez PL/pgSQL — panel Supabase gubi się w `do $$`.
--  Wykonanie: SQL Editor w panelu Supabase. Można uruchomić ponownie.
-- =============================================================================

begin;

create temp table scalenia (stara text primary key, nowa text not null) on commit drop;

insert into scalenia (stara, nowa) values
  ('Grillownica kontaktowa',              'Grill kontaktowy'),
  ('Toster / grill kontaktowy',           'Grill kontaktowy'),
  ('Szybkowar / multicooker ciśnieniowy', 'Garnek ciśnieniowy'),
  ('Naczynie żaroodporne / blacha',       'Naczynie żaroodporne'),
  ('Blender',                             'Blender ręczny'),
  ('Miseczka do hartowania śmietany',     'Miska'),
  ('łyżkę cedzakowa',                     'Łyżka cedzakowa');


-- 1. Pisownia i rodzaj pozycji, które zostają.
update sprzet set nazwa = 'Miska', rodzaj = 'naczynia' where lower(nazwa) = 'miska';
update sprzet set rodzaj = 'naczynia'  where nazwa = 'Garnek 4 l';
update sprzet set rodzaj = 'narzedzia' where nazwa = 'Łyżka cedzakowa';


-- 2. Każda docelowa nazwa musi być w katalogu. Brak przerywa cały skrypt
--    (rzutowanie tekstu na liczbę się nie udaje, a komunikat pokazuje tekst).
select ('SCALANIE PRZERWANE — brak w katalogu: ' || string_agg(distinct s.nowa, ', '))::int
  from scalenia s
 where not exists (select 1 from sprzet x where x.nazwa = s.nowa);


-- 3. Przepisy: stara nazwa → nowa, reszta → pisownia z katalogu.
update przepisy p
   set sprzet = (
         select coalesce(array_agg(q.nazwa order by q.poz), '{}')
           from (
             select coalesce(s.nowa, k.nazwa, u.x) as nazwa, min(u.poz) as poz
               from unnest(p.sprzet) with ordinality as u(x, poz)
               left join scalenia s on lower(s.stara) = lower(u.x)
               left join sprzet   k on lower(k.nazwa) = lower(u.x)
              group by 1
           ) q
       ),
       zmieniono = now()
 where exists (
         select 1
           from unnest(p.sprzet) as x
           left join sprzet k on lower(k.nazwa) = lower(x)
          where lower(x) in (select lower(stara) from scalenia)
             or k.nazwa is distinct from x
       );


-- 4. Scalone pozycje znikają z katalogu.
delete from sprzet
 where lower(nazwa) in (select lower(stara) from scalenia);

commit;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================

-- Nazwy w przepisach, których nie ma w katalogu. Pusta tabelka = w porządku.
select p.nazwa as przepis, x as sprzet_spoza_katalogu
  from przepisy p
 cross join lateral unnest(p.sprzet) as x
 where not exists (select 1 from sprzet s where s.nazwa = x)
 order by 1, 2;

-- Katalog po scaleniu, z liczbą przepisów.
select nazwa, rodzaj, w_przepisach
  from sprzet_uzycie
 order by rodzaj, nazwa;
