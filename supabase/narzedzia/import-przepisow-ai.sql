-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 1
--  Wygenerowano: 2026-11-23
--
--  Skrypt najpierw sprawdza katalogi składników i sprzętu. Jeśli czegoś
--  brakuje, kończy się błędem „IMPORT PRZERWANY — …” z listą braków
--  i niczego nie zapisuje.
--
--  Przepis o tej samej nazwie jest AKTUALIZOWANY, nie kasowany. Nowe przepisy
--  wchodzą jako prywatne, a ich autorem jest konto romitu@gmail.com.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

begin;

with
  potrzebne_skladniki(przepis, nazwa, w_sztukach) as (values
    ('Grochówka z indykiem', 'Groch łuskany, suchy', false),
    ('Grochówka z indykiem', 'Pierś z indyka, surowa', false),
    ('Grochówka z indykiem', 'Ziemniaki, surowe', false),
    ('Grochówka z indykiem', 'Marchew, surowa', false),
    ('Grochówka z indykiem', 'Pietruszka korzeń', false),
    ('Grochówka z indykiem', 'Cebula, surowa', false),
    ('Grochówka z indykiem', 'woda', false),
    ('Grochówka z indykiem', 'Oliwa z oliwek extra virgin', false),
    ('Grochówka z indykiem', 'Majeranek suszony', false),
    ('Grochówka z indykiem', 'liść laurowy', false),
    ('Grochówka z indykiem', 'ziele angielskie', false),
    ('Grochówka z indykiem', 'Sól kłodawska', false),
    ('Grochówka z indykiem', 'Czarny pieprz mielony', false),
    ('Grochówka z indykiem', 'Seler korzeń', false),
    ('Grochówka z indykiem', 'Por, surowy', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Grochówka z indykiem', 'Garnek 3 l'),
    ('Grochówka z indykiem', 'Nóż szefa kuchni'),
    ('Grochówka z indykiem', 'Deska do krojenia'),
    ('Grochówka z indykiem', 'Waga kuchenna'),
    ('Grochówka z indykiem', 'Sitko'),
    ('Grochówka z indykiem', 'Termometr do mięsa'),
    ('Grochówka z indykiem', 'Garnek 2 l'),
    ('Grochówka z indykiem', 'Łyżka cedzakowa'),
    ('Grochówka z indykiem', 'Miska')
  ),
  braki(opis) as (
    -- Bez konta autora przepisy weszłyby bez właściciela i nikt poza
    -- moderatorem by ich nie zobaczył.
    select 'brak konta ' || 'romitu@gmail.com'
     where not exists (select 1 from konta where lower(email) = lower('romitu@gmail.com'))
    union all
    select 'brak składnika „' || ps.nazwa || '” (' || ps.przepis || ')'
           || coalesce(' — podobne w katalogu: ' || (
                select string_agg(sk.nazwa, ', ' order by sk.nazwa)
                  from skladniki sk
                 where exists (select 1 from regexp_split_to_table(lower(ps.nazwa), '[^[:alpha:]]+') w
                                where length(w) >= 3 and lower(sk.nazwa) ~ ('\m' || w))), '')
      from potrzebne_skladniki ps
     where not exists (select 1 from skladniki sk where sk.nazwa = ps.nazwa)
    union all
    select 'składnik „' || ps.nazwa || '” w sztukach, a nie ma masy sztuki (' || ps.przepis || ')'
      from potrzebne_skladniki ps
      join skladniki sk on sk.nazwa = ps.nazwa
     where ps.w_sztukach and sk.masa_sztuki_g is null
    union all
    select 'brak sprzętu „' || pq.nazwa || '” (' || pq.przepis || ')'
           || coalesce(' — podobne w katalogu: ' || (
                select string_agg(x.nazwa, ', ' order by x.nazwa)
                  from sprzet x
                 where exists (select 1 from regexp_split_to_table(lower(pq.nazwa), '[^[:alpha:]]+') w
                                where length(w) >= 3 and lower(x.nazwa) ~ ('\m' || w))), '')
      from potrzebny_sprzet pq
     where not exists (select 1 from sprzet x where lower(x.nazwa) = lower(pq.nazwa))
  )
select ('IMPORT PRZERWANY — ' || string_agg(opis, '; '))::int as sprawdzenie_katalogow
  from braki;


-- -------------------------------------------------------------------------
--  Grochówka z indykiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grochówka z indykiem', 'Treściwa grochówka z mięsem indyka, ziemniakami, warzywami korzeniowymi i majerankiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Wywar z marchwi, korzenia pietruszki, korzenia selera i pora gotuje się w osobnym garnku równolegle z grochem; cały wywar i wszystkie warzywa trafiają do zupy.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 931, 1, 2,
  20, 49,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa', 'Garnek 2 l', 'Łyżka cedzakowa', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź w porcjach. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeśli groch pozostaje twardy, gotuj dalej i uzupełniaj wodę. Za gęstą zupę rozcieńcz gorącą wodą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grochówka z indykiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grochówka z indykiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'łuskany, połówki, opłukany', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Groch łuskany, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Pierś z indyka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 110, 'g'::jednostka_miary, 110,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 900, 'ml'::jednostka_miary, 900,
       'połowa do gotowania grochu, połowa do wywaru; cały wywar i wszystkie ugotowane warzywa trafiają do zupy', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki; do wywaru', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż osobno do wywaru.', null::text, false),
         (5::smallint, '**Groch.** Odmierz i opłucz łuskany groch w połówkach. Całe ziarna wymagają dłuższego gotowania.', null::text, false),
         (6::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (7::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (8::smallint, '**Indyk.** Osusz indyka i pokrój w kostkę około 2 cm.', null::text, false),
         (9::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (10::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników i podziel ją na dwie równe części: do grochu i do wywaru.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz sól, pieprz, majeranek, liście laurowe i ziele angielskie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie grochu i wywaru', 28 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Wywar — drugi palnik.** W garnku 2 l umieść całą przygotowaną marchew, korzeń pietruszki i korzeń selera. Zalej połową odmierzonej wody. Przykryj i doprowadź do łagodnego wrzenia, orientacyjnie przez **4–5 minut**. Od zagotowania gotuj na małym ogniu przez **6 minut**. Nastaw minutnik; w tym czasie zajmij się grochem.', null::text, false),
         (2::smallint, '**Baza zupy — równolegle.** W garnku 3 l rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (3::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (4::smallint, '**Groch.** Do cebuli dodaj groch, drugą połowę wody, liście laurowe i ziele angielskie. Doprowadź do wrzenia przez około **3 minuty**. Gotuj pod uchyloną pokrywką na małym ogniu. Nastaw drugi minutnik na **20 minut** od zagotowania. Mieszaj co kilka minut, żeby groch nie przywarł; jeśli płyn mocno odparuje, dolej trochę gorącej wody.', null::text, false),
         (5::smallint, '**Por — po minutniku wywaru.** Po **6 minutach gotowania korzeni** dodaj por do wywaru. Gotuj jeszcze przez **4 minuty**.', null::text, false),
         (6::smallint, '**Kontrola warzyw.** Sprawdź kostkę marchewki i selera. Jeśli ma twardy, surowy środek, gotuj jeszcze po **2 minuty**, sprawdzając po każdej takiej próbie.', 'warzywa są lekko jędrne, ale bez twardego, surowego środka'::text, true),
         (7::smallint, '**Uzupełnienie wywaru.** Jeżeli podczas gotowania odparowała woda, uzupełnij jej ubytek gorącą wodą do początkowego poziomu, zanim wyjmiesz warzywa.', null::text, false),
         (8::smallint, '**Zachowanie warzyw i wywaru.** Wyjmij wszystkie warzywa łyżką cedzakową do miski i przykryj. Wywar zostaw w garnku pod przykryciem, poza palnikiem, do czasu dodania ziemniaków. Nie wylewaj wywaru ani płynu zebranego w misce.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Gotowanie ziemniaków i indyka', 21 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ziemniaki i wywar.** Po **20 minutach** gotowania grochu dodaj ziemniaki i cały wywar, bez warzyw z miski. Po ponownym zagotowaniu gotuj przez **6 minut**.', null::text, false),
         (2::smallint, '**Indyk.** Dodaj indyka. Po ponownym zagotowaniu gotuj na małym ogniu przez **6–7 minut**. Sprawdź temperaturę najgrubszego kawałka mięsa; jeśli jest niższa, gotuj jeszcze po **2 minuty**.', 'indyk osiągnął co najmniej 74°C'::text, true),
         (3::smallint, '**Kontrola grochu i ziemniaków.** Sprawdź miękkość grochu i ziemniaków. Jeżeli groch jest jeszcze twardy, dogotuj zupę po **3 minuty**, uzupełniając odparowany płyn gorącą wodą.', 'groch jest miękki, ziemniaki nie mają twardego środka'::text, true),
         (4::smallint, '**Warzywa z wywaru.** Dodaj wszystkie odłożone warzywa wraz z płynem, który zebrał się w misce. Doprowadź ponownie do łagodnego wrzenia i podgrzewaj przez **1 minutę**.', null::text, false),
         (5::smallint, '**Doprawienie i podanie.** Usuń liście laurowe i ziele angielskie. Dodaj majeranek, sól i pieprz. Wymieszaj i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 3;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Grochówka z indykiem', 15, 3, 25)
), jest as (
  select p.nazwa,
         (select count(*) from przepis_skladniki ps where ps.przepis_id = p.id) as skladnikow,
         (select count(*) from etapy e where e.przepis_id = p.id)              as etapow,
         (select count(*) from kroki k join etapy e on e.id = k.etap_id
           where e.przepis_id = p.id)                                         as krokow
    from przepisy p
)
select o.nazwa,
       o.skladnikow as skladnikow_mialo_byc, j.skladnikow as skladnikow_jest,
       o.etapow     as etapow_mialo_byc,     j.etapow     as etapow_jest,
       o.krokow     as krokow_mialo_byc,     j.krokow     as krokow_jest
  from oczekiwane o
  left join jest j on lower(j.nazwa) = lower(o.nazwa)
 where j.nazwa is null
    or (j.skladnikow, j.etapow, j.krokow) <> (o.skladnikow, o.etapow, o.krokow)
 order by o.nazwa;


-- --- CO WYSZŁO --------------------------------------------------------------
select
  p.nazwa,
  p.porcjowanie,
  p.porcja_g,
  p.porcje,
  round(sum(ps.gramy))                                        as masa_calosci_g,
  case when p.porcjowanie = 'waga'
       then round(sum(ps.gramy) / p.porcja_g, 1) end          as porcji_wychodzi,
  round(m.kcal)                                               as kcal_na_porcje,
  round(m.bialko_g)                                           as bialko_na_porcje
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join przepis_makro m      on m.przepis_id = p.id
where lower(p.nazwa) in (lower('Grochówka z indykiem'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
