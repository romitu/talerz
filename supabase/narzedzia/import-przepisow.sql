-- =============================================================================
--  TALERZ — przepisy przeniesione ze starego planera
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import.mjs. Nie poprawiaj go
--  ręcznie — przy następnym uruchomieniu poprawki znikną. Zmiany wprowadzaj
--  w narzedzia/mapowanie-planera.json.
--
--  Dań w tym pliku: 31
--  Wygenerowano: 2026-08-15
--
--  Zanim uruchomisz
--  ----------------
--  1. Migracja 0012 musi być wgrana (przeliczniki jednostek domowych).
--  2. Składniki ręczne muszą być wgrane (narzedzia/skladniki-recznie.sql).
--  3. Nazwa przepisu musi być niepowtarzalna (migracja 0018) — po niej
--     skrypt rozpoznaje, czy danie już jest w bazie.
--  4. Sprawdź wcześniej narzedzia/sprawdz-skladniki.sql.
--
--  Skrypt można uruchamiać wielokrotnie. Przepis o tej samej nazwie jest
--  AKTUALIZOWANY, a nie kasowany — dzięki temu nie znikają polubienia,
--  zdjęcie ani powiązanie z planem. Wymieniana jest tylko treść: składniki,
--  etapy i kroki.
--
--  Cały skrypt to zwykłe instrukcje SQL, bez bloków PL/pgSQL. Panel
--  Supabase potrafi się na nich wywrócić przy dużych plikach.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

-- -------------------------------------------------------------------------
--  Owsianka
--  Planer podawał 635 kcal i 29 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Owsianka', 'ŻEL Z CHIA NA CAŁY TYDZIEŃ — 60 g nasion zalej 480 ml zimnej wody w słoiku, zamieszaj, odczekaj 10 minut i zamieszaj drugi raz. Ten drugi raz jest kluczowy: bez niego nasiona zbiją się w grudy, których już nie rozbijesz. Po 2 godzinach w lodówce masz konsystencję kisielu. Wychodzi ok. 540 g, czyli 6 porcji po 4 czubate łyżki. Trzyma się 5 dni w zamkniętym słoiku. Namoczona chia jest łagodniejsza dla jelit niż sucha, bo przychodzi z własną wodą i nie ściąga jej z treści pokarmowej. Cała owsianka to cztery źródła błonnika naraz — beta-glukan, otręby, siemię i chia, razem ok. 17,5 g na porcję, czyli połowa dziennej normy. Jeśli teraz jesz go niewiele, przez pierwszy tydzień dawaj pół porcji żelu, bo skok z dnia na dzień częściej kończy się wzdęciami niż ulgą. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 434,
  5, 5,
  array['Garnek 2 l', 'Miska'], 'Owsiankę jedz świeżą. Żel z chia zrób na cały tydzień — trzyma się 5 dni w zamkniętym słoiku.',
  false, 'Za gęsta — dolej mleka albo wody. Za rzadka — pogotuj chwilę dłużej, ale pamiętaj, że chia jeszcze zgęstnieje.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Owsianka');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Owsianka');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 300, 'ml'::jednostka_miary, 300, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10, null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Otręby owsiane';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10, 'mielone', 4
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Siemię lniane';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10, null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Nasiona chia';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 17, 'g'::jednostka_miary, 17, null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Owsianka' and sk.nazwa = 'Cynamon mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where p.nazwa = 'Owsianka';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Płatki zalej mlekiem i gotuj na małym ogniu 7–10 minut, często mieszając.'),
         (2::smallint, 'Jeśli owsianka jest zbyt gęsta, dolej odrobinę wody; zbyt rzadka — gotuj chwilę dłużej.'),
         (3::smallint, 'Zdejmij z ognia, wmieszaj otręby i siemię lniane.'),
         (4::smallint, 'Dodaj żel z chia i wymieszaj. Jeśli używasz suchych nasion, odstaw owsiankę na 5 minut, żeby napęczniały w misce, a nie w Tobie — i dolej wody lub mleka, bo mocno zgęstnieje.'),
         (5::smallint, 'Posyp cynamonem i orzechami.')
       ) as v(nr, tresc)
 where p.nazwa = 'Owsianka' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Tosty z jajkiem sadzonym
--  Planer podawał 680 kcal i 38 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z jajkiem sadzonym', 'Awokado kupuj twarde — dojrzeje na blacie w 3–5 dni. Chcesz przyspieszyć? Włóż do papierowej torby z jabłkiem. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 425,
  5, 10,
  array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Jedz od razu. Awokado po rozgnieceniu ciemnieje w godzinę.',
  false, 'Awokado ściemniało — skrop cytryną. Żółtko się rozlało — zrób z tego jajecznicę i nie tłumacz się nikomu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Tosty z jajkiem sadzonym');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Tosty z jajkiem sadzonym');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Tosty z jajkiem sadzonym' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'obrane, bez pestki', 2
  from przepisy p, skladniki sk where p.nazwa = 'Tosty z jajkiem sadzonym' and sk.nazwa = 'Awokado';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Tosty z jajkiem sadzonym' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Tosty z jajkiem sadzonym' and sk.nazwa = 'Rukola';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10, 'posiekana', 5
  from przepisy p, skladniki sk where p.nazwa = 'Tosty z jajkiem sadzonym' and sk.nazwa = 'Pietruszka natka';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where p.nazwa = 'Tosty z jajkiem sadzonym';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pieczywo opiecz w tosterze lub na patelni.'),
         (2::smallint, 'Awokado obierz i rozsmaruj na kromkach.'),
         (3::smallint, 'Na suchej, rozgrzanej patelni pod przykryciem usmaż jajka sadzone. Dopraw solą i pieprzem.'),
         (4::smallint, 'Na kanapkach ułóż rukolę i jajka, posyp natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Tosty z jajkiem sadzonym' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Twaróg z warzywami
--  Planer podawał 640 kcal i 49 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Twaróg z warzywami', 'Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 510,
  5, 0,
  array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Pasta w lodówce do 2 dni, warzywa krój na świeżo. Kanapki rób bezpośrednio przed jedzeniem — pieczywo rozmięknie.',
  false, 'Pasta za sucha — dołóż łyżkę jogurtu. Za rzadka — odsącz twaróg na sitku.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Twaróg z warzywami');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Twaróg z warzywami');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 210, 'g'::jednostka_miary, 210, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Twaróg z warzywami' and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Twaróg z warzywami' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Twaróg z warzywami' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 5, 'szt'::jednostka_miary, round((5 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Twaróg z warzywami' and sk.nazwa = 'Rzodkiewka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Twaróg z warzywami' and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 6
  from przepisy p, skladniki sk where p.nazwa = 'Twaróg z warzywami' and sk.nazwa = 'Szczypiorek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 5 from przepisy p where p.nazwa = 'Twaróg z warzywami';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Twaróg rozgnieć widelcem i wymieszaj z jogurtem na gładką masę.'),
         (2::smallint, 'Dopraw solą, pieprzem i posiekanym szczypiorkiem.'),
         (3::smallint, 'Podawaj z pieczywem, rzodkiewkami i ogórkiem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Twaróg z warzywami' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Jajecznica ze szpinakiem
--  Planer podawał 635 kcal i 31 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajecznica ze szpinakiem', 'Szpinak wrzucaj mrożony prosto na patelnię — najpierw odparuj z niego wodę, inaczej jajecznica wyjdzie wodnista. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 503,
  5, 5,
  array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Jedz od razu. Odgrzewana jajecznica robi się gumowata.',
  false, 'Wyszła wodnista — to znak, że szpinak nie odparował. Odlej płyn i dosmaż na większym ogniu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Jajecznica ze szpinakiem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Jajecznica ze szpinakiem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Jajecznica ze szpinakiem' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Jajecznica ze szpinakiem' and sk.nazwa = 'Szpinak mrożony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.25, 'szt'::jednostka_miary, round((1.25 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Jajecznica ze szpinakiem' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Jajecznica ze szpinakiem' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Jajecznica ze szpinakiem' and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 6
  from przepisy p, skladniki sk where p.nazwa = 'Jajecznica ze szpinakiem' and sk.nazwa = 'Szczypiorek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where p.nazwa = 'Jajecznica ze szpinakiem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie rozgrzej szpinak, aż odparuje nadmiar wody (2–3 minuty).'),
         (2::smallint, 'Wbij jajka, dopraw i smaż na małym ogniu, mieszając.'),
         (3::smallint, 'Podawaj z pieczywem, pomidorem i szczypiorkiem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Jajecznica ze szpinakiem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Szakszuka z mozzarellą
--  Planer podawał 635 kcal i 35 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Szakszuka z mozzarellą', 'Passata zmniejszona o połowę, do 100 ml — sos jest teraz warstwą pod jajkami, a nie kąpielą, więc duś go krótko i nie odparowuj do gęstości pasty. Jeśli smak nadal wychodzi za mocny, następne w kolejności do cięcia są suszone pomidory: zejdź z 20 do 10 g, one niosą najwięcej umami w tym daniu. Po wbiciu jajek już nie mieszaj. Pomidory odsącz z oleju przed posiekaniem — dlatego oliwy do smażenia idzie tu mniej niż zwykle. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 674,
  7, 13,
  array['Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Sam sos w lodówce do 3 dni. Jajka wbijaj dopiero przy podaniu — odgrzewane robią się gumowate.',
  false, 'Sos za rzadki — duś dłużej bez przykrycia. Jajka się rozlały — nie mieszaj po wbiciu, tylko przykryj.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Szakszuka z mozzarellą');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Szakszuka z mozzarellą');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, 'odsączone, posiekane', 5
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Pomidory suszone w oleju';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60, 'w plastrach', 6
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.75, 'szt'::jednostka_miary, round((0.75 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Szakszuka z mozzarellą' and sk.nazwa = 'Kmin rzymski mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Szakszuka z mozzarellą';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zeszklij cebulę z papryką na oliwie ok. 5 minut.'),
         (2::smallint, 'Dodaj przeciśnięty czosnek, słodką paprykę i kmin. Smaż 30 sekund, mieszając.'),
         (3::smallint, 'Wlej passatę, dorzuć drobno posiekane suszone pomidory, dopraw. Duś na małym ogniu tylko 4–5 minut — przy tej ilości sosu dłuższe odparowanie zostawi Cię z samą pastą.'),
         (4::smallint, 'Łyżką zrób w sosie dwa wgłębienia i wbij w nie jajka.'),
         (5::smallint, 'Przykryj i gotuj 5–6 minut, aż białka się zetną, a żółtka zostaną płynne.'),
         (6::smallint, 'Porozrzucaj kawałki mozzarelli, przykryj jeszcze na minutę.'),
         (7::smallint, 'Posyp natką, podawaj z chlebem do maczania.')
       ) as v(nr, tresc)
 where p.nazwa = 'Szakszuka z mozzarellą' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Jajka w koszulkach z pastą twarogową
--  Planer podawał 650 kcal i 41 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajka w koszulkach z pastą twarogową', 'Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 441,
  7, 13,
  array['Garnek 2 l', 'Miska', 'Sitko'], 'Pasta twarogowa w lodówce do 2 dni. Jajka rób na świeżo.',
  false, 'Białko się rozeszło po wodzie — jajko było za stare albo woda za mocno wrzała. Ma ledwo drgać, nie bulgotać.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Jajka w koszulkach z pastą twarogową');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Jajka w koszulkach z pastą twarogową');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 40, 'ml'::jednostka_miary, 40, null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.25, 'szt'::jednostka_miary, round((1.25 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 8
  from przepisy p, skladniki sk where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and sk.nazwa = 'koperek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Jajka w koszulkach z pastą twarogową';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Twaróg rozetrzyj z mlekiem i roztartym czosnkiem na gładką pastę. Dopraw solą.'),
         (2::smallint, 'Pieczywo opiecz i rozsmaruj na nim pastę.'),
         (3::smallint, 'Zagotuj wodę z łyżką octu, zrób wir i wbijaj jajka pojedynczo. Gotuj 3 minuty.'),
         (4::smallint, 'Wyjmij łyżką cedzakową, odsącz i ułóż na grzankach.'),
         (5::smallint, 'Oliwę wymieszaj z papryką słodką, polej wierzch, posyp koperkiem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Jajka w koszulkach z pastą twarogową' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Pasta jajeczna z awokado
--  Planer podawał 660 kcal i 36 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pasta jajeczna z awokado', 'Skrop pastę cytryną — awokado nie ściemnieje, a smak się rozjaśni. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 453,
  5, 10,
  array['Garnek 2 l', 'Miska', 'Widelec'], 'W lodówce do 2 dni, w szczelnym pojemniku. Skrop cytryną, żeby awokado nie ściemniało.',
  false, 'Pasta ściemniała — wierzchnia warstwa utleniła się, zbierz ją łyżką. Za sucha — łyżka jogurtu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Pasta jajeczna z awokado');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Pasta jajeczna z awokado');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Pasta jajeczna z awokado' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'obrane, bez pestki', 2
  from przepisy p, skladniki sk where p.nazwa = 'Pasta jajeczna z awokado' and sk.nazwa = 'Awokado';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Pasta jajeczna z awokado' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Pasta jajeczna z awokado' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 5
  from przepisy p, skladniki sk where p.nazwa = 'Pasta jajeczna z awokado' and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Pasta jajeczna z awokado' and sk.nazwa = 'Rzodkiewka, surowa';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where p.nazwa = 'Pasta jajeczna z awokado';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka ugotuj na twardo (9 minut), ostudź w zimnej wodzie i obierz.'),
         (2::smallint, 'Awokado rozgnieć widelcem, wymieszaj z jogurtem, solą i pieprzem.'),
         (3::smallint, 'Jajka posiekaj i wmieszaj do pasty. Dodaj szczypiorek.'),
         (4::smallint, 'Rozsmaruj na pieczywie, podawaj z rzodkiewkami.')
       ) as v(nr, tresc)
 where p.nazwa = 'Pasta jajeczna z awokado' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kanapki z pastą z tuńczyka
--  Planer podawał 665 kcal i 67 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z pastą z tuńczyka', 'Najwięcej białka ze wszystkich śniadań w planie — 45 g przy zaledwie 500 kcal. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 546,
  5, 5,
  array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Pasta w lodówce do 2 dni. Kanapki składaj przed jedzeniem.',
  false, 'Za sucha — łyżka jogurtu. Za słona — dołóż twarogu, nie soli.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Kanapki z pastą z tuńczyka');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Kanapki z pastą z tuńczyka');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Kanapki z pastą z tuńczyka' and sk.nazwa = 'Tuńczyk w wodzie, odsączony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 205, 'g'::jednostka_miary, 205, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Kanapki z pastą z tuńczyka' and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Kanapki z pastą z tuńczyka' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'w cienkich piórkach', 4
  from przepisy p, skladniki sk where p.nazwa = 'Kanapki z pastą z tuńczyka' and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Kanapki z pastą z tuńczyka' and sk.nazwa = 'ogórki kiszone bio';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 6
  from przepisy p, skladniki sk where p.nazwa = 'Kanapki z pastą z tuńczyka' and sk.nazwa = 'Szczypiorek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where p.nazwa = 'Kanapki z pastą z tuńczyka';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Tuńczyka odsącz i rozgnieć widelcem.'),
         (2::smallint, 'Wymieszaj z twarogiem na gładką pastę, dopraw pieprzem.'),
         (3::smallint, 'Dodaj drobno posiekaną cebulę i szczypiorek.'),
         (4::smallint, 'Rozsmaruj na pieczywie, podawaj z ogórkiem kiszonym.')
       ) as v(nr, tresc)
 where p.nazwa = 'Kanapki z pastą z tuńczyka' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Gulasz z kaszą gryczaną
--  Planer podawał 815 kcal i 53 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz z kaszą gryczaną', 'Cook4Me: podsmażanie, potem 20–25 min pod ciśnieniem (wołowina 30–35 min). Wlej tylko 150 ml wody. Rozprężanie naturalne. Odetnij widoczny tłuszcz przed obsmażeniem. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 802,
  30, 60,
  array['Garnek 4 l', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni, z dnia na dzień smakuje lepiej. Kaszę trzymaj osobno.',
  true, 'Mięso twarde — duś dalej, wołowina potrzebuje nawet dwóch godzin. Sos za rzadki — odparuj bez przykrycia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Gulasz z kaszą gryczaną');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Gulasz z kaszą gryczaną');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 700, 'g'::jednostka_miary, 700, 'w kostce 3 cm', 1
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Gulasz wieprzowy, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 300, 'ml'::jednostka_miary, 300, null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3.75, 'szt'::jednostka_miary, round((3.75 * sk.masa_sztuki_g)::numeric, 1), 'sucha, ugotowana osobno', 7
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Kasza gryczana, sucha';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200, 'odciśnięta', 8
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Kapusta kiszona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.25, 'szt'::jednostka_miary, round((2.25 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 9, 'g'::jednostka_miary, 9, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 12
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200, 'na wywar — po odparowaniu', 13
  from przepisy p, skladniki sk where p.nazwa = 'Gulasz z kaszą gryczaną' and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 90 from przepisy p where p.nazwa = 'Gulasz z kaszą gryczaną';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mięso osusz i obsmaż na oliwie partiami, aż się zarumieni. Nie wrzucaj wszystkiego naraz.'),
         (2::smallint, 'Dodaj posiekaną cebulę, zeszklij, wrzuć czosnek.'),
         (3::smallint, 'Dorzuć marchew i paprykę, wsyp słodką paprykę.'),
         (4::smallint, 'Wlej passatę i ok. 200 ml wody, dorzuć liść laurowy i ziele.'),
         (5::smallint, 'Duś pod przykryciem 70–90 minut (wołowina 1,5–2 h).'),
         (6::smallint, 'Dopraw. Podawaj z kaszą gryczaną i surówką z kiszonej kapusty.')
       ) as v(nr, tresc)
 where p.nazwa = 'Gulasz z kaszą gryczaną' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Barszcz ukraiński z fasolą
--  Planer podawał 800 kcal i 43 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Barszcz ukraiński z fasolą', 'Cook4Me — dwa etapy: mięso 25 min, otwórz, warzywa kolejne 6–8 min. Fasolę, cytrynę i mięso dodaj po otwarciu. Barszcz z dnia na dzień smakuje lepiej i trzyma się 4 dni. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 1231,
  30, 60,
  array['Garnek 4 l', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni, z dnia na dzień smakuje lepiej. Chleb osobno.',
  true, 'Stracił kolor — buraki nie lubią długiego gotowania; dodaj sok z cytryny, kolor wróci. Za mdły — więcej cytryny, nie soli.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Barszcz ukraiński z fasolą');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Barszcz ukraiński z fasolą');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 400, 'g'::jednostka_miary, 400, 'w kawałkach 3 cm', 1
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Pręga wołowa bez kości, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 600, 'g'::jednostka_miary, 600, 'obrane, starte na grubych oczkach', 2
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Buraki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), 'obrane', 5
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300, 'poszatkowana', 6
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Kapusta biała, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'sok', 8
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), 'odsączona i przepłukana', 9
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Fasola czerwona z puszki, odsączona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'ml'::jednostka_miary, 200, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 9, 'szt'::jednostka_miary, round((9 * sk.masa_sztuki_g)::numeric, 1), null, 12
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 13
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 14
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1100, 'g'::jednostka_miary, 1100, 'na wywar — po odparowaniu', 15
  from przepisy p, skladniki sk where p.nazwa = 'Barszcz ukraiński z fasolą' and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 90 from przepisy p where p.nazwa = 'Barszcz ukraiński z fasolą';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj wywar na mięsie (ok. 60 minut). Wyjmij mięso i pokrój.'),
         (2::smallint, 'Do wywaru dodaj starte buraki, marchew, pietruszkę, ziemniaki w kostce i kapustę w paskach.'),
         (3::smallint, 'Wlej passatę i gotuj ok. 25 minut, aż warzywa zmiękną.'),
         (4::smallint, 'Dodaj odsączoną fasolę i mięso.'),
         (5::smallint, 'Zakwaś sokiem z cytryny, dopraw czosnkiem, majerankiem, solą i pieprzem.'),
         (6::smallint, 'Podawaj z łyżką jogurtu i kromką razowego chleba.')
       ) as v(nr, tresc)
 where p.nazwa = 'Barszcz ukraiński z fasolą' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Wieprzowina w sosie chrzanowym
--  Planer podawał 805 kcal i 63 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wieprzowina w sosie chrzanowym', 'Nabiał zawsze po zdjęciu z ognia — jogurt wrzucony do wrzątku się zwarzy. Chrzan pod ciśnieniem traci ostrość, więc w Cook4Me dodaj go po otwarciu (18–20 min). Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 1005,
  22, 43,
  array['Garnek 3 l', 'Patelnia 24 cm', 'Tłuczek do ziemniaków', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Puree i fasolka w osobnych pojemnikach.',
  false, 'Sos się zwarzył — jogurt trafił do wrzątku. Zblenduj i wmieszaj łyżkę zimnego jogurtu. Chrzan stracił ostrość — dodaj świeżego po zdjęciu z ognia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Wieprzowina w sosie chrzanowym');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Wieprzowina w sosie chrzanowym');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 420, 'g'::jednostka_miary, 420, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Szynka wieprzowa chuda, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 800, 'g'::jednostka_miary, 800, 'obrane', 2
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 250, 'ml'::jednostka_miary, 250, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Bulion warzywny gotowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40, null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Chrzan tarty';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300, null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Fasolka szparagowa mrożona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.333, 'szt'::jednostka_miary, round((0.333 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, 'posiekana', 9
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16, 'posiekany', 10
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie chrzanowym' and sk.nazwa = 'koperek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 65 from przepisy p where p.nazwa = 'Wieprzowina w sosie chrzanowym';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mięso pokrój na mniejsze kawałki i rozbij tłuczkiem. Oprósz solą i pieprzem.'),
         (2::smallint, 'W garnku podsmaż na oliwie starty czosnek, wlej bulion i zagotuj.'),
         (3::smallint, 'Osobno obsmaż mięso na suchej, dobrze rozgrzanej patelni.'),
         (4::smallint, 'Przełóż do gotującego bulionu, przykryj i gotuj 40–50 minut. Po 20 minutach dodaj chrzan.'),
         (5::smallint, 'Ziemniaki ugotuj i utłucz na puree. Fasolkę ugotuj osobno.'),
         (6::smallint, 'Zdejmij garnek z ognia. Zahartuj jogurt kilkoma łyżkami bulionu i wmieszaj razem z koperkiem.'),
         (7::smallint, 'Podawaj z puree i fasolką, posyp natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Wieprzowina w sosie chrzanowym' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Polędwiczka z pieczarkami i boczniakami
--  Planer podawał 790 kcal i 58 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Polędwiczka z pieczarkami i boczniakami', 'Polędwiczka ma ok. 3% tłuszczu — najchudsze mięso wieprzowe. Nie przesmażaj: w środku ma zostać lekko różowa. Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 846,
  10, 20,
  array['Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Kasza osobno.',
  false, 'Mięso wyszło suche — przesmażone; następnym razem 2–3 minuty z każdej strony i koniec. Sos się zwarzył — zdejmij z ognia przed jogurtem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Polędwiczka z pieczarkami i boczniakami');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Polędwiczka z pieczarkami i boczniakami');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250, 'w plastrach', 2
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, 'porwane na paski', 3
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Boczniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, 'odciśnięta', 6
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Kapusta kiszona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100, null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Bulion warzywny gotowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.5, 'szt'::jednostka_miary, round((2.5 * sk.masa_sztuki_g)::numeric, 1), 'sucha, ugotowana osobno', 9
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Kasza gryczana, sucha';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and sk.nazwa = 'Tymianek suszony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 30 from przepisy p where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Polędwiczkę pokrój w medaliony ok. 2 cm, oprósz solą i pieprzem.'),
         (2::smallint, 'Obsmaż na oliwie po 2–3 minuty z każdej strony i odłóż.'),
         (3::smallint, 'Na tej samej patelni podsmaż cebulę, pieczarki i boczniaki — aż odparuje woda.'),
         (4::smallint, 'Dodaj czosnek i tymianek, wlej bulion i zagotuj.'),
         (5::smallint, 'Zdejmij z ognia i zabiel jogurtem.'),
         (6::smallint, 'Włóż mięso z powrotem na 2 minuty. Podawaj z kaszą i surówką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Polędwiczka z pieczarkami i boczniakami' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kurczak po tajsku
--  Planer podawał 805 kcal i 51 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kurczak po tajsku', 'Pastę curry koniecznie podsmaż w tłuszczu — wrzucona prosto do mleka będzie płaska. Kwas dodawaj na końcu. Wybieraj mleko bez dodatków lub z gumą guar (E412), unikaj karagenu (E407). Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 575,
  8, 17,
  array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Tarka o drobnych oczkach'], 'W lodówce do 3 dni. Ryż w osobnym pojemniku. Z garnka wychodzą trzy porcje po 575 g — na trzy obiady.',
  false, 'Sos się rozwarstwił — zdejmij z ognia i wmieszaj łyżkę zimnego mleka kokosowego. Za ostre — dodaj mleka kokosowego, nie wody. Za mdłe — sok z cytryny, nie sól.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Kurczak po tajsku');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Kurczak po tajsku');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, 'obrany, starty', 4
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'sok', 7
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 400, 'ml'::jednostka_miary, 400, null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Fasolka szparagowa mrożona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130, 'suchy, ugotowany osobno', 12
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.5, 'szt'::jednostka_miary, round((1.5 * sk.masa_sztuki_g)::numeric, 1), null, 13
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, 'posiekana', 14
  from przepisy p, skladniki sk where p.nazwa = 'Kurczak po tajsku' and sk.nazwa = 'Pietruszka natka';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 25 from przepisy p where p.nazwa = 'Kurczak po tajsku';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Nastaw ryż — basmati gotuje się ok. 12 minut.'),
         (2::smallint, 'Pierś pokrój w paski 1,5 cm. Obsmaż na rozgrzanej oliwie 3–4 minuty i wyjmij.'),
         (3::smallint, 'Zeszklij cebulę (2 min), dodaj czosnek i starty imbir, smaż 30 sekund.'),
         (4::smallint, 'Wsyp pastę curry i smaż minutę, cały czas mieszając.'),
         (5::smallint, 'Dodaj marchew i paprykę. Smaż 2 minuty.'),
         (6::smallint, 'Wlej mleko kokosowe, wrzuć mięso i fasolkę. Duś 12–15 minut bez przykrycia.'),
         (7::smallint, 'Zdejmij z ognia. Dopraw sosem sojowym i sokiem z cytryny. Spróbuj i dopraw.'),
         (8::smallint, 'Podawaj z ryżem, posypane natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Kurczak po tajsku' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Dorsz po grecku
--  Planer podawał 800 kcal i 48 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Dorsz po grecku', 'Trzyma się 3–4 dni i z dnia na dzień smakuje lepiej. Dorsz i mintaj to ryby dziko poławiane — szukaj oznaczenia MSC. Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 1062,
  13, 27,
  array['Piekarnik', 'Patelnia 28 cm', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Z dnia na dzień smakuje lepiej — dobrze też na zimno.',
  false, 'Ryba się rozpadła — to nie problem, wymieszaj z warzywami. Warzywa za suche — dolej passaty i pogotuj.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Dorsz po grecku');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Dorsz po grecku');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 400, 'g'::jednostka_miary, 400, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Dorsz atlantycki, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'sok', 5
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 740, 'g'::jednostka_miary, 740, 'obrane', 6
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 250, 'ml'::jednostka_miary, 250, null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Dorsz po grecku' and sk.nazwa = 'Papryka słodka mielona';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 40 from przepisy p where p.nazwa = 'Dorsz po grecku';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Filety pokrój, dopraw, skrop cytryną. Upiecz w 200°C przez 15 minut.'),
         (2::smallint, 'Marchew i pietruszkę zetrzyj na tarce. Zeszklij na oliwie z cebulą.'),
         (3::smallint, 'Dodaj passatę, liść laurowy i słodką paprykę. Duś ok. 20 minut.'),
         (4::smallint, 'Rybę przełóż warstwą warzyw.'),
         (5::smallint, 'Podawaj ciepłe lub na zimno, z ziemniakami albo pieczywem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Dorsz po grecku' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Klopsiki w sosie pomidorowym
--  Planer podawał 805 kcal i 42 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Klopsiki w sosie pomidorowym', 'Cook4Me: obsmaż na trybie podsmażania, potem 10 minut pod ciśnieniem. Klopsiki świetnie się mrożą — porcję na trzeci dzień odłóż od razu do zamrażarki. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 837,
  15, 30,
  array['Patelnia 28 cm', 'Garnek 2 l', 'Tłuczek do ziemniaków', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Świetnie się mrożą — porcję na trzeci dzień odłóż od razu do zamrażarki.',
  true, 'Klopsiki się rozpadają — za mało bułki tartej albo za mokre mięso. Sos za kwaśny — szczypta słodkiej papryki i pogotuj.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Klopsiki w sosie pomidorowym');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Klopsiki w sosie pomidorowym');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Mięso mielone wołowo-wieprzowe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60, null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Bułka tarta';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500, null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1080, 'g'::jednostka_miary, 1080, 'obrane', 7
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3.75, 'szt'::jednostka_miary, round((3.75 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'posiekana', 11
  from przepisy p, skladniki sk where p.nazwa = 'Klopsiki w sosie pomidorowym' and sk.nazwa = 'Pietruszka natka';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 45 from przepisy p where p.nazwa = 'Klopsiki w sosie pomidorowym';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mięso wymieszaj z jajkiem, bułką tartą i drobno startą cebulą. Dopraw solą, pieprzem i majerankiem.'),
         (2::smallint, 'Uformuj klopsiki wielkości orzecha włoskiego. Wilgotne dłonie ułatwiają formowanie.'),
         (3::smallint, 'Obsmaż je na oliwie ze wszystkich stron i odłóż.'),
         (4::smallint, 'Na tej samej patelni zeszklij drugą cebulę z czosnkiem, wlej passatę i oregano.'),
         (5::smallint, 'Włóż klopsiki do sosu i duś pod przykryciem 20 minut.'),
         (6::smallint, 'Ziemniaki ugotuj i utłucz na puree. Podawaj z klopsikami i natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Klopsiki w sosie pomidorowym' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Fasolka po bretońsku z indykiem
--  Planer podawał 780 kcal i 54 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Fasolka po bretońsku z indykiem', 'Fasolę zawsze przepłucz po odsączeniu — zejdzie zalewa i danie nie będzie mętne. Trzyma się w lodówce 4 dni. Suszone pomidory odsącz z oleju, inaczej danie wyjdzie tłuste. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 720,
  13, 27,
  array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Chleb osobno.',
  true, 'Za gęsta — dolej wody. Mętna — fasola nieprzepłukana po odsączeniu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Fasolka po bretońsku z indykiem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Fasolka po bretońsku z indykiem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 400, 'g'::jednostka_miary, 400, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Filet z indyka, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), 'odsączona i przepłukana', 2
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Fasola biała z puszki, odsączona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 400, 'ml'::jednostka_miary, 400, null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 45, 'g'::jednostka_miary, 45, 'odsączone, posiekane', 4
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Pomidory suszone w oleju';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 9, 'szt'::jednostka_miary, round((9 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.7, 'szt'::jednostka_miary, round((2.7 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 9, 'g'::jednostka_miary, 9, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Fasolka po bretońsku z indykiem' and sk.nazwa = 'liść laurowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 40 from przepisy p where p.nazwa = 'Fasolka po bretońsku z indykiem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Indyka pokrój w kostkę i obsmaż na oliwie do zarumienienia.'),
         (2::smallint, 'Dodaj posiekaną cebulę i czosnek, zeszklij.'),
         (3::smallint, 'Wlej passatę, dorzuć posiekane suszone pomidory, dodaj majeranek, słodką paprykę i liść laurowy. Duś 15 minut.'),
         (4::smallint, 'Fasolę odsącz, przepłucz i wrzuć do garnka. Duś jeszcze 10 minut.'),
         (5::smallint, 'Dopraw i podawaj z kromką razowego chleba. Sól dodaj na końcu — pomidory i fasola z puszki już ją wnoszą.')
       ) as v(nr, tresc)
 where p.nazwa = 'Fasolka po bretońsku z indykiem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Pieczony schab z warzywami korzeniowymi
--  Planer podawał 795 kcal i 57 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony schab z warzywami korzeniowymi', 'Schab jest chudy i łatwo go przesuszyć — najlepiej sprawdzić termometrem: 65–68°C w środku i wyjmować. Zimny schab następnego dnia jest świetny na kanapki. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 751,
  25, 50,
  array['Piekarnik', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Zimny schab następnego dnia jest świetny na kanapki.',
  true, 'Schab wyszedł suchy — piekłeś za długo. Termometr: 65–68°C w środku i wyjmować. Ratunek: pokrój cienko i polej sosem z brytfanny.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Pieczony schab z warzywami korzeniowymi');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Pieczony schab z warzywami korzeniowymi');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 700, 'g'::jednostka_miary, 700, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Schab wieprzowy, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 900, 'g'::jednostka_miary, 900, 'obrane', 5
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3.75, 'szt'::jednostka_miary, round((3.75 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and sk.nazwa = 'Tymianek suszony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 75 from przepisy p where p.nazwa = 'Pieczony schab z warzywami korzeniowymi';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Schab natrzyj oliwą, roztartym czosnkiem, majerankiem, solą i pieprzem. Zostaw na 20 minut.'),
         (2::smallint, 'Warzywa korzeniowe i ziemniaki pokrój w grubą kostkę, wymieszaj z oliwą i tymiankiem.'),
         (3::smallint, 'Rozłóż warzywa w brytfannie, na wierzchu ułóż mięso.'),
         (4::smallint, 'Piecz w 180°C przez 55–65 minut. Po drodze raz przemieszaj warzywa.'),
         (5::smallint, 'Wyjmij i odstaw mięso na 10 minut przed krojeniem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Pieczony schab z warzywami korzeniowymi' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Wołowina z brokułami po chińsku
--  Planer podawał 790 kcal i 62 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wołowina z brokułami po chińsku', 'Sekret stir-fry to bardzo gorąca patelnia i smażenie partiami. Wrzucone naraz mięso puści wodę i będzie się dusić zamiast rumienić. Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 642,
  8, 17,
  array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Ryż osobno. Brokuł traci chrupkość — to normalne.',
  false, 'Mięso twarde — pokrojone wzdłuż włókien zamiast w poprzek. Wyszło wodniste — patelnia była za zimna albo mięso smażone naraz.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Wołowina z brokułami po chińsku');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Wołowina z brokułami po chińsku');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, 'w cienkich paskach w poprzek włókien', 1
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Wołowina na plastry (udziec), surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), 'podzielony na różyczki', 2
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, 'obrany, starty', 5
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, 'suchy, ugotowany osobno', 7
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.5, 'szt'::jednostka_miary, round((2.5 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Wołowina z brokułami po chińsku' and sk.nazwa = 'Sezam';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 25 from przepisy p where p.nazwa = 'Wołowina z brokułami po chińsku';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wołowinę pokrój w cienkie paski w poprzek włókien — to klucz do miękkości.'),
         (2::smallint, 'Zamarynuj mięso w łyżce sosu sojowego przez 15 minut. W tym czasie ugotuj ryż.'),
         (3::smallint, 'Brokuł podziel na różyczki i zblanszuj 3 minuty we wrzątku, potem przelej zimną wodą.'),
         (4::smallint, 'Rozgrzej patelnię lub wok bardzo mocno. Smaż mięso partiami po 2 minuty i wyjmij.'),
         (5::smallint, 'Na tym samym tłuszczu smaż cebulę, czosnek i imbir 30 sekund.'),
         (6::smallint, 'Wrzuć brokuł i mięso, wlej resztę sosu sojowego, smaż jeszcze minutę.'),
         (7::smallint, 'Posyp sezamem i podawaj z ryżem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Wołowina z brokułami po chińsku' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Smażony ryż z kurczakiem i jajkiem
--  Planer podawał 805 kcal i 49 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Smażony ryż z kurczakiem i jajkiem', 'To najlepszy sposób na wykorzystanie ryżu, który został z poprzedniego dania — zero marnowania. Ugotuj większą partię ryżu przy kurczaku po tajsku. Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 544,
  7, 13,
  array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 2 dni. To danie z resztek, więc nie rób z niego kolejnych resztek.',
  false, 'Ryż się klei — był ciepły. Musi być z lodówki, najlepiej wczorajszy.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Smażony ryż z kurczakiem i jajkiem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Smażony ryż z kurczakiem i jajkiem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200, 'suchy, ugotowany osobno', 3
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Groszek zielony mrożony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16, 'posiekany', 10
  from przepisy p, skladniki sk where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and sk.nazwa = 'Szczypiorek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj dzień wcześniej i schłodź w lodówce — świeży, ciepły ryż się zlepi.'),
         (2::smallint, 'Kurczaka pokrój w kostkę i obsmaż na mocno rozgrzanym oleju. Wyjmij.'),
         (3::smallint, 'Roztrzepane jajka wlej na patelnię, zetnij mieszając i wyjmij.'),
         (4::smallint, 'Smaż cebulę, marchew i czosnek 3 minuty. Dodaj groszek.'),
         (5::smallint, 'Wsyp zimny ryż, rozbij grudki i smaż 3–4 minuty, aż się rozgrzeje.'),
         (6::smallint, 'Wrzuć mięso i jajka z powrotem, wlej sos sojowy, wymieszaj.'),
         (7::smallint, 'Posyp szczypiorkiem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Smażony ryż z kurczakiem i jajkiem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Tom kha gai — kokosowa zupa z kurczakiem
--  Planer podawał 795 kcal i 62 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tom kha gai — kokosowa zupa z kurczakiem', 'Sok z cytryny zawsze po zdjęciu z ognia — kwas w gotującym się mleku kokosowym powoduje rozwarstwienie. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 838,
  10, 20,
  array['Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Ryż osobno. Odgrzewaj łagodnie — mleko kokosowe nie lubi wrzenia.',
  false, 'Zupa się rozwarstwiła — cytryna trafiła do wrzącego mleka. Zblenduj chwilę, wróci. Za ostra — dolej mleka kokosowego.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 735, 'g'::jednostka_miary, 735, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 400, 'ml'::jednostka_miary, 400, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 600, 'ml'::jednostka_miary, 600, null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Bulion warzywny gotowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Pasta tom kha';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200, 'w plastrach', 5
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'obrany, starty', 6
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.5, 'szt'::jednostka_miary, round((1.5 * sk.masa_sztuki_g)::numeric, 1), 'sok', 8
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.167, 'szt'::jednostka_miary, round((0.167 * sk.masa_sztuki_g)::numeric, 1), null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Sos rybny';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.75, 'szt'::jednostka_miary, round((0.75 * sk.masa_sztuki_g)::numeric, 1), null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 303, 'g'::jednostka_miary, 303, 'suchy, ugotowany osobno', 12
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'posiekana', 13
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 14
  from przepisy p, skladniki sk where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and sk.nazwa = 'Papryka ostra mielona';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 30 from przepisy p where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj ryż osobno.'),
         (2::smallint, 'W garnku rozgrzej olej, wsyp pastę tom kha i smaż minutę, cały czas mieszając, aż mocno zapachnie i olej zabarwi się od niej. To najważniejszy moment — pasta wrzucona prosto do płynu zostanie płaska.'),
         (3::smallint, 'Wlej bulion, dodaj imbir i czosnek, gotuj 5 minut.'),
         (4::smallint, 'Dodaj kurczaka i marchew. Gotuj 8 minut.'),
         (5::smallint, 'Wrzuć pieczarki, gotuj kolejne 3 minuty.'),
         (6::smallint, 'Wlej mleko kokosowe i podgrzej, ale nie gotuj mocno — ma tylko pyrkać.'),
         (7::smallint, 'Zdejmij z ognia. Wlej sok z połówki cytryny i pół łyżeczki sosu rybnego, dopraw ostrą papryką. Spróbuj i dokwaś — ta pasta jest słodka, więc kwasu potrzeba więcej, niż się wydaje. Soli nie dodawaj, pasta i sos wnoszą jej dość.'),
         (8::smallint, 'Podawaj z ryżem, posypane natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Tom kha gai — kokosowa zupa z kurczakiem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Wieprzowina w sosie sojowo-imbirowym
--  Planer podawał 805 kcal i 61 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wieprzowina w sosie sojowo-imbirowym', 'Nie dosalaj — sos sojowy jest bardzo słony. Jeśli chcesz łagodniej, użyj wersji o obniżonej zawartości sodu. Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 684,
  8, 17,
  array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Tarka o drobnych oczkach'], 'W lodówce do 3 dni. Ryż osobno.',
  false, 'Za słone — sos sojowy jest bardzo słony, nie dosalaj. Ratunek: dorzuć więcej warzyw i ryżu. Warzywa miękkie — smażone za długo.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Wieprzowina w sosie sojowo-imbirowym');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Wieprzowina w sosie sojowo-imbirowym');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25, 'obrany, starty', 6
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Fasolka szparagowa mrożona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 190, 'g'::jednostka_miary, 190, 'suchy, ugotowany osobno', 9
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.5, 'szt'::jednostka_miary, round((2.5 * sk.masa_sztuki_g)::numeric, 1), null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and sk.nazwa = 'Sezam';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 25 from przepisy p where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj ryż. Polędwiczkę pokrój w cienkie plastry i zamarynuj w łyżce sosu sojowego.'),
         (2::smallint, 'Na mocno rozgrzanym oleju obsmaż mięso partiami po 2 minuty. Wyjmij.'),
         (3::smallint, 'Smaż czosnek i imbir 30 sekund, dodaj cebulę, marchew i paprykę. Smaż 3 minuty.'),
         (4::smallint, 'Dorzuć fasolkę, wrzuć mięso z powrotem, wlej resztę sosu sojowego.'),
         (5::smallint, 'Smaż jeszcze minutę, posyp sezamem. Podawaj z ryżem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Wieprzowina w sosie sojowo-imbirowym' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Indyk w sosie orzechowym (satay)
--  Planer podawał 810 kcal i 61 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Indyk w sosie orzechowym (satay)', 'Masło orzechowe musi być bez cukru — czytaj skład, bo większość popularnych marek ma dodany cukier i olej palmowy. Skład powinien brzmieć: orzeszki 100%. Przepis rozpisany na cały garnek — 2 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 648,
  10, 20,
  array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Ryż osobno. Sos gęstnieje po schłodzeniu — dolej wody przy odgrzewaniu.',
  false, 'Sos się zważył — wmieszaj łyżkę ciepłej wody poza ogniem. Za gęsty — mleko kokosowe. Za mdły — sok z cytryny.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Indyk w sosie orzechowym (satay)');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Indyk w sosie orzechowym (satay)');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Filet z indyka, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Masło orzechowe bez cukru';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 200, 'ml'::jednostka_miary, 200, null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20, 'obrany, starty', 5
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'sok', 7
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, 'suchy, ugotowany osobno', 10
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 12
  from przepisy p, skladniki sk where p.nazwa = 'Indyk w sosie orzechowym (satay)' and sk.nazwa = 'Papryka ostra mielona';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 30 from przepisy p where p.nazwa = 'Indyk w sosie orzechowym (satay)';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj ryż. Indyka pokrój w kostkę.'),
         (2::smallint, 'Obsmaż mięso na oleju na mocnym ogniu 4–5 minut, aż się zarumieni. Wyjmij.'),
         (3::smallint, 'Na tej samej patelni smaż czosnek i imbir 30 sekund, dodaj marchew i paprykę, smaż 3 minuty.'),
         (4::smallint, 'Zmniejsz ogień. Wmieszaj masło orzechowe, wlej mleko kokosowe i sos sojowy. Mieszaj, aż sos będzie gładki.'),
         (5::smallint, 'Wrzuć mięso z powrotem i duś 5 minut.'),
         (6::smallint, 'Zdejmij z ognia, dopraw sokiem z cytryny i szczyptą ostrej papryki. Podawaj z ryżem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Indyk w sosie orzechowym (satay)' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Zupa pomidorowa z ryżem
--  Planer podawał 645 kcal i 33 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa pomidorowa z ryżem', 'Gotujesz jeden garnek na 3 kolacje — jedną porcję od razu zamroź. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 900,
  17, 33,
  array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Sitko'], 'Po wystudzeniu w lodówce, pod przykryciem, do 3 dni. Ryż trzymaj osobno — w zupie rozmięknie i wypije wywar.',
  true, 'Za kwaśna od passaty — dodaj startą marchewkę i pogotuj 10 minut. Za rzadka — odparuj bez przykrycia. Za mało wyrazista — dosól i dodaj łyżkę passaty, nie kostkę rosołową.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Zupa pomidorowa z ryżem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Zupa pomidorowa z ryżem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Udo z kurczaka bez skóry, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1250, 'g'::jednostka_miary, 1250, 'zimna, na wywar — do garnka wlej około 1,6 l, przez 40 minut gotowania odparuje jakieś 350 ml', 2
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'woda';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100, null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), 'część biała i jasnozielona, w plastrach', 6
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500, null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240, 'suchy, ugotowany osobno', 8
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'posiekana', 10
  from przepisy p, skladniki sk where p.nazwa = 'Zupa pomidorowa z ryżem' and sk.nazwa = 'Pietruszka natka';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 50 from przepisy p where p.nazwa = 'Zupa pomidorowa z ryżem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj wywar z udek i włoszczyzny (ok. 40 minut). Wyjmij mięso i obierz z kości.'),
         (2::smallint, 'Wlej passatę do wywaru, zagotuj i dopraw.'),
         (3::smallint, 'Ryż ugotuj osobno.'),
         (4::smallint, 'Podawaj z ryżem, kawałkami mięsa, łyżką jogurtu i natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Zupa pomidorowa z ryżem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Krem marchewkowy z ryżem
--  Planer podawał 645 kcal i 33 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem marchewkowy z ryżem', 'Zupa przetarta z pełnowartościowym białkiem — łagodna i sycąca, dobra na dni bez apetytu. Cook4Me: 8 minut. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 835,
  12, 23,
  array['Garnek 3 l', 'Blender', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 3 dni. Po zblendowaniu gęstnieje — przy odgrzewaniu dolej ciepłej wody.',
  true, 'Za gęsty — dolej ciepłej wody i zamieszaj. Za rzadki — pogotuj bez przykrycia. Mdły — łyżeczka oliwy na wierzch i biały pieprz.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Krem marchewkowy z ryżem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Krem marchewkowy z ryżem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 700, 'g'::jednostka_miary, 700, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240, 'obrane', 3
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120, 'suchy, ugotowany osobno', 4
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1000, 'ml'::jednostka_miary, 1000, null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Bulion warzywny gotowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3.75, 'szt'::jednostka_miary, round((3.75 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6, null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Pieprz biały mielony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'posiekana', 10
  from przepisy p, skladniki sk where p.nazwa = 'Krem marchewkowy z ryżem' and sk.nazwa = 'Pietruszka natka';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 35 from przepisy p where p.nazwa = 'Krem marchewkowy z ryżem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Marchew pokrój w cienkie plasterki, ziemniaki w kostkę ok. 1,5 cm.'),
         (2::smallint, 'Ryż wypłucz na sitku pod zimną wodą.'),
         (3::smallint, 'Do garnka wlej bulion. Dodaj mięso, marchew, ziemniaki i ryż. Gotuj 20 minut pod częściowym przykryciem.'),
         (4::smallint, 'Wyjmij mięso i podziel na kawałki.'),
         (5::smallint, 'Zblenduj zupę na gładki krem razem z oliwą. Za gęsta — dolej ciepłej wody.'),
         (6::smallint, 'Włóż mięso z powrotem, dopraw. Odstaw pod przykryciem na 1–2 minuty.'),
         (7::smallint, 'Przed podaniem udekoruj jogurtem i natką.')
       ) as v(nr, tresc)
 where p.nazwa = 'Krem marchewkowy z ryżem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Omlet z pieczarkami
--  Planer podawał 665 kcal i 31 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Omlet z pieczarkami', 'Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna', 'waga', 476,
  5, 10,
  array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Jedz od razu. Odgrzewany omlet jest gumowaty.',
  false, 'Nie chce się złożyć — patelnia za mała albo masa za rzadka. Podaj jako jajecznicę, smakuje tak samo.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Omlet z pieczarkami');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Omlet z pieczarkami');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Omlet z pieczarkami' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100, 'w plastrach', 2
  from przepisy p, skladniki sk where p.nazwa = 'Omlet z pieczarkami' and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Omlet z pieczarkami' and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Omlet z pieczarkami' and sk.nazwa = 'Szpinak mrożony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.5, 'szt'::jednostka_miary, round((1.5 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Omlet z pieczarkami' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.5, 'szt'::jednostka_miary, round((2.5 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Omlet z pieczarkami' and sk.nazwa = 'Chleb żytni razowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where p.nazwa = 'Omlet z pieczarkami';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pieczarki i cebulę podsmaż na oliwie, aż odparuje woda. Dodaj szpinak.'),
         (2::smallint, 'Jajka roztrzep widelcem, dopraw i wlej na patelnię.'),
         (3::smallint, 'Smaż na małym ogniu pod przykryciem, aż masa się zetnie. Złóż na pół.'),
         (4::smallint, 'Podawaj z kromką pieczywa.')
       ) as v(nr, tresc)
 where p.nazwa = 'Omlet z pieczarkami' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Sałatka z tuńczykiem i jajkiem
--  Planer podawał 645 kcal i 48 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z tuńczykiem i jajkiem', 'Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 828,
  5, 10,
  array['Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Bez dressingu w lodówce do 2 dni. Oliwę i cytrynę dodawaj przy podaniu, inaczej warzywa puszczą wodę.',
  false, 'Puściła wodę — odlej i dopraw na nowo. Za kwaśna — łyżka oliwy zbalansuje.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Sałatka z tuńczykiem i jajkiem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Sałatka z tuńczykiem i jajkiem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Tuńczyk w wodzie, odsączony';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), 'odsączona i przepłukana', 3
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Fasola czerwona z puszki, odsączona';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'w cienkich piórkach', 6
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'sok', 7
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.25, 'szt'::jednostka_miary, round((1.25 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and sk.nazwa = 'Chleb żytni razowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where p.nazwa = 'Sałatka z tuńczykiem i jajkiem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka ugotuj na twardo (8–9 minut), ostudź i pokrój.'),
         (2::smallint, 'Warzywa pokrój, fasolę odsącz i przepłucz.'),
         (3::smallint, 'Wymieszaj wszystko z odsączonym tuńczykiem.'),
         (4::smallint, 'Polej oliwą i sokiem z cytryny, dopraw. Podawaj z pieczywem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Sałatka z tuńczykiem i jajkiem' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Grillowany indyk z halloumi
--  Planer podawał 645 kcal i 47 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grillowany indyk z halloumi', 'Indyk jest bardzo chudy i wysycha błyskawicznie. Termometr: 74°C. Namoczenie halloumi usuwa część soli — ten ser ma ok. 2,5–3 g soli na 100 g. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 490,
  7, 13,
  array['Grillownica kontaktowa', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 2 dni. Halloumi po wystudzeniu twardnieje — odgrzej na patelni.',
  false, 'Indyk suchy — grillowany za długo. Termometr: 74°C. Halloumi za słone — namocz następnym razem 20 minut w wodzie.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Grillowany indyk z halloumi');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Grillowany indyk z halloumi');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Filet z indyka, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60, 'w plastrach 1 cm', 2
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Halloumi';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25, null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Rukola';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'sok', 6
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2.5, 'szt'::jednostka_miary, round((2.5 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.25, 'szt'::jednostka_miary, round((1.25 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 9
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany indyk z halloumi' and sk.nazwa = 'Tymianek suszony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Grillowany indyk z halloumi';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Filet rozkrój wzdłuż na dwa cieńsze płaty albo rozbij do grubości 1,5 cm. Osusz ręcznikiem.'),
         (2::smallint, 'Natrzyj oliwą, czosnkiem i tymiankiem. Sól i pieprz dodaj tuż przed grillowaniem.'),
         (3::smallint, 'Rozgrzej grillownicę do końca. Połóż mięso, zamknij pokrywę, nie dociskaj.'),
         (4::smallint, 'Grilluj 6–8 minut, nie otwierając przez pierwsze 4 minuty.'),
         (5::smallint, 'Namoczone halloumi osusz, pokrój w plastry i zgrilluj po 2 minuty z każdej strony.'),
         (6::smallint, 'Mięso odstaw na 5 minut pod odwróconym talerzem.'),
         (7::smallint, 'Chleb zgrilluj na końcu. Podawaj z pomidorem i rukolą polanymi oliwą.')
       ) as v(nr, tresc)
 where p.nazwa = 'Grillowany indyk z halloumi' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Grillowany kurczak caprese
--  Planer podawał 670 kcal i 53 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grillowany kurczak caprese', 'Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 472,
  7, 13,
  array['Grillownica kontaktowa', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 2 dni. Mozzarellę i pomidora dokładaj przy podaniu.',
  false, 'Pierś sucha — przekrój ją wzdłuż na dwa cieńsze płaty, grilluje się o połowę krócej.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Grillowany kurczak caprese');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Grillowany kurczak caprese');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60, 'w plastrach', 2
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5, 'świeże listki', 5
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 6
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.25, 'szt'::jednostka_miary, round((1.25 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak caprese' and sk.nazwa = 'Oregano suszone';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Grillowany kurczak caprese';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pierś przekrój wzdłuż na dwa cieńsze płaty. Natrzyj oliwą i oregano.'),
         (2::smallint, 'Grilluj po ok. 4 minuty z każdej strony (w grillownicy 6–7 minut).'),
         (3::smallint, 'Pod koniec połóż plastry mozzarelli i pomidora, przykryj na 2 minuty.'),
         (4::smallint, 'Posyp świeżą bazylią.'),
         (5::smallint, 'Chleb zgrilluj i natrzyj przekrojonym ząbkiem czosnku.')
       ) as v(nr, tresc)
 where p.nazwa = 'Grillowany kurczak caprese' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Grillowany kurczak z ogórkiem kiszonym
--  Planer podawał 655 kcal i 66 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grillowany kurczak z ogórkiem kiszonym', 'Ogórek kiszony, nie konserwowy. Ten drugi siedzi w occie i cukrze, a tu chodzi o kwas mlekowy, który przecina suchość grillowanej piersi — to dlatego to zestawienie działa. Danie jest równie dobre na zimno, więc jeśli wolisz je na śniadanie, zgrilluj mięso poprzedniego wieczoru. Na indyku: filet 150 g, grilluj 2 minuty dłużej i sprawdź termometrem 74°C. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 562,
  7, 13,
  array['Grillownica kontaktowa', 'Nóż szefa kuchni', 'Deska do krojenia'], 'W lodówce do 2 dni.',
  false, 'Pierś sucha — grillowana za długo. Ogórek za słony — przepłucz przed pokrojeniem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Grillowany kurczak z ogórkiem kiszonym');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Grillowany kurczak z ogórkiem kiszonym');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100, null, 2
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'ogórki kiszone bio';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'w cienkich piórkach', 6
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 7
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 9
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8, 'posiekany', 10
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and sk.nazwa = 'Papryka słodka mielona';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Grilluj mięso po 4 minuty z każdej strony (w grillownicy 6–7 minut). Nie dociskaj i nie zaglądaj przez pierwsze 3 minuty.'),
         (2::smallint, 'Odstaw pod odwróconym talerzem na 5 minut, potem pokrój w ukośne plastry.'),
         (3::smallint, 'Pieczywo zgrilluj na tej samej patelni — zbierze tłuszcz i smak z mięsa.'),
         (4::smallint, 'Grzanki posmaruj twarożkiem, ułóż kurczaka, na wierzch ogórki i cebulę.'),
         (5::smallint, 'Posyp koperkiem i szczypiorkiem. Nie dosalaj — ogórki wnoszą dość soli.')
       ) as v(nr, tresc)
 where p.nazwa = 'Grillowany kurczak z ogórkiem kiszonym' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Krupnik z kaszą jęczmienną
--  Planer podawał 650 kcal i 36 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krupnik z kaszą jęczmienną', 'Kasza jęczmienna pęcznieje jeszcze w lodówce — następnego dnia dolej trochę wody przy odgrzewaniu. Cook4Me: wywar 20 min, potem warzywa i kasza 8 min. Przepis rozpisany na cały garnek — 3 porcje. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  3, 'prywatna', 'waga', 900,
  20, 40,
  array['Garnek 4 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Sitko'], 'W lodówce do 3 dni. Kasza pęcznieje jeszcze w lodówce — następnego dnia dolej wody przy odgrzewaniu.',
  true, 'Za gęsty — dolej wody, to normalne po nocy. Mdły — dosól i dodaj świeżego koperku, nie kostki rosołowej.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Krupnik z kaszą jęczmienną');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Krupnik z kaszą jęczmienną');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Udo z kurczaka bez skóry, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240, 'sucha, przepłukana', 2
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Kasza jęczmienna, sucha';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100, null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), 'część biała i jasnozielona, w plastrach', 6
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 600, 'g'::jednostka_miary, 600, 'obrane', 7
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'posiekana', 8
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 24, 'g'::jednostka_miary, 24, 'posiekany', 9
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1200, 'g'::jednostka_miary, 1200, 'na wywar — po odparowaniu', 12
  from przepisy p, skladniki sk where p.nazwa = 'Krupnik z kaszą jęczmienną' and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 60 from przepisy p where p.nazwa = 'Krupnik z kaszą jęczmienną';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj wywar z udek, liścia laurowego i ziela (ok. 40 minut). Wyjmij mięso i obierz z kości.'),
         (2::smallint, 'Warzywa pokrój w kostkę, ziemniaki nieco większą.'),
         (3::smallint, 'Wrzuć warzywa i przepłukaną kaszę do wywaru. Gotuj 20 minut, aż kasza zmięknie.'),
         (4::smallint, 'Dodaj mięso, dopraw solą i pieprzem.'),
         (5::smallint, 'Podawaj posypane natką i koperkiem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Krupnik z kaszą jęczmienną' and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Sałatka grecka z grillowanym kurczakiem
--  Planer podawał 655 kcal i 45 g białka na porcję.
--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka grecka z grillowanym kurczakiem', 'Feta jest słona — nie dosalaj sałatki. Jeśli chcesz zbić sól, przepłucz ser zimną wodą przed pokruszeniem. Przepis na jedną porcję. Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.', (select id from konta order by utworzono limit 1),
  array['kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  2, 'prywatna', 'waga', 747,
  7, 13,
  array['Grillownica kontaktowa', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia'], 'Bez dressingu w lodówce do 2 dni. Oliwę i cytrynę dodawaj przy podaniu.',
  false, 'Za słona — feta jest słona, nie dosalaj. Przepłucz ser zimną wodą przed pokruszeniem. Puściła wodę — odlej i dopraw na nowo.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek;

delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = 'Sałatka grecka z grillowanym kurczakiem');
delete from etapy            where przepis_id in (select id from przepisy where nazwa = 'Sałatka grecka z grillowanym kurczakiem');

insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150, null, 1
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50, 'pokruszona', 2
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Ser feta';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 3
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1), null, 4
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1), null, 5
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'w cienkich piórkach', 6
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30, 'bez pestek', 7
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Oliwki czarne';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.25, 'szt'::jednostka_miary, round((1.25 * sk.masa_sztuki_g)::numeric, 1), null, 8
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1), 'sok', 9
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Cytryna';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 1.5, 'szt'::jednostka_miary, round((1.5 * sk.masa_sztuki_g)::numeric, 1), null, 10
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2, null, 11
  from przepisy p, skladniki sk where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and sk.nazwa = 'Oregano suszone';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 20 from przepisy p where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem';

insert into kroki (etap_id, kolejnosc, tresc)
select e.id, v.nr, v.tresc
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pierś przekrój wzdłuż na dwa cieńsze płaty, natrzyj oliwą i oregano.'),
         (2::smallint, 'Grilluj po 4 minuty z każdej strony (w grillownicy 6–7 minut). Odstaw na 5 minut i pokrój.'),
         (3::smallint, 'Warzywa pokrój w grubą kostkę, cebulę w cienkie piórka.'),
         (4::smallint, 'Wymieszaj z oliwkami, polej oliwą i sokiem z cytryny.'),
         (5::smallint, 'Na wierzchu ułóż kurczaka i pokruszoną fetę, posyp oregano. Podawaj z pieczywem.')
       ) as v(nr, tresc)
 where p.nazwa = 'Sałatka grecka z grillowanym kurczakiem' and e.kolejnosc = 1;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło
-- =============================================================================
--  Ten skrypt nie przerywa na błędzie, bo nie używa PL/pgSQL (patrz nagłówek).
--  Brakujący składnik wstawiłby zero wierszy i nikt by tego nie zauważył —
--  danie miałoby po prostu zaniżone kalorie.
--
--  Poniższe zapytanie porównuje stan z tym, co miało powstać.
--  Pusta tabelka oznacza, że wszystko się zgadza.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, krokow) as (values
  ('Owsianka', 7, 5),
  ('Tosty z jajkiem sadzonym', 5, 4),
  ('Twaróg z warzywami', 6, 3),
  ('Jajecznica ze szpinakiem', 6, 3),
  ('Szakszuka z mozzarellą', 11, 7),
  ('Jajka w koszulkach z pastą twarogową', 8, 5),
  ('Pasta jajeczna z awokado', 6, 4),
  ('Kanapki z pastą z tuńczyka', 6, 4),
  ('Gulasz z kaszą gryczaną', 13, 6),
  ('Barszcz ukraiński z fasolą', 15, 6),
  ('Wieprzowina w sosie chrzanowym', 10, 7),
  ('Polędwiczka z pieczarkami i boczniakami', 11, 6),
  ('Kurczak po tajsku', 14, 8),
  ('Dorsz po grecku', 10, 5),
  ('Klopsiki w sosie pomidorowym', 11, 6),
  ('Fasolka po bretońsku z indykiem', 11, 5),
  ('Pieczony schab z warzywami korzeniowymi', 9, 5),
  ('Wołowina z brokułami po chińsku', 9, 7),
  ('Smażony ryż z kurczakiem i jajkiem', 10, 7),
  ('Tom kha gai — kokosowa zupa z kurczakiem', 14, 8),
  ('Wieprzowina w sosie sojowo-imbirowym', 11, 5),
  ('Indyk w sosie orzechowym (satay)', 12, 6),
  ('Zupa pomidorowa z ryżem', 10, 4),
  ('Krem marchewkowy z ryżem', 10, 7),
  ('Omlet z pieczarkami', 6, 4),
  ('Sałatka z tuńczykiem i jajkiem', 9, 4),
  ('Grillowany indyk z halloumi', 9, 7),
  ('Grillowany kurczak caprese', 8, 5),
  ('Grillowany kurczak z ogórkiem kiszonym', 11, 5),
  ('Krupnik z kaszą jęczmienną', 12, 5),
  ('Sałatka grecka z grillowanym kurczakiem', 11, 5)
)
select
  o.nazwa,
  o.skladnikow                                       as skladnikow_mialo_byc,
  coalesce(s.ile, 0)                                 as skladnikow_jest,
  o.krokow                                           as krokow_mialo_byc,
  coalesce(k.ile, 0)                                 as krokow_jest
from oczekiwane o
left join (select przepis_id, count(*) as ile from przepis_skladniki group by przepis_id) s
       on s.przepis_id = (select id from przepisy p where p.nazwa = o.nazwa)
left join (select e.przepis_id, count(*) as ile from kroki k join etapy e on e.id = k.etap_id
            group by e.przepis_id) k
       on k.przepis_id = (select id from przepisy p where p.nazwa = o.nazwa)
where coalesce(s.ile, 0) <> o.skladnikow
   or coalesce(k.ile, 0) <> o.krokow
order by o.nazwa;


-- --- CO WYSZŁO --------------------------------------------------------------
select
  p.nazwa,
  p.porcja_g,
  round(sum(ps.gramy))                  as masa_calosci_g,
  round(sum(ps.gramy) / p.porcja_g, 1)  as porcji_wychodzi,
  round(m.kcal)                         as kcal_na_porcje,
  round(m.bialko_g)                     as bialko_na_porcje
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join przepis_makro m      on m.przepis_id = p.id
where p.nazwa in ('Owsianka', 'Tosty z jajkiem sadzonym', 'Twaróg z warzywami', 'Jajecznica ze szpinakiem', 'Szakszuka z mozzarellą', 'Jajka w koszulkach z pastą twarogową', 'Pasta jajeczna z awokado', 'Kanapki z pastą z tuńczyka', 'Gulasz z kaszą gryczaną', 'Barszcz ukraiński z fasolą', 'Wieprzowina w sosie chrzanowym', 'Polędwiczka z pieczarkami i boczniakami', 'Kurczak po tajsku', 'Dorsz po grecku', 'Klopsiki w sosie pomidorowym', 'Fasolka po bretońsku z indykiem', 'Pieczony schab z warzywami korzeniowymi', 'Wołowina z brokułami po chińsku', 'Smażony ryż z kurczakiem i jajkiem', 'Tom kha gai — kokosowa zupa z kurczakiem', 'Wieprzowina w sosie sojowo-imbirowym', 'Indyk w sosie orzechowym (satay)', 'Zupa pomidorowa z ryżem', 'Krem marchewkowy z ryżem', 'Omlet z pieczarkami', 'Sałatka z tuńczykiem i jajkiem', 'Grillowany indyk z halloumi', 'Grillowany kurczak caprese', 'Grillowany kurczak z ogórkiem kiszonym', 'Krupnik z kaszą jęczmienną', 'Sałatka grecka z grillowanym kurczakiem')
group by p.nazwa, p.porcja_g, m.kcal, m.bialko_g
order by p.nazwa;
