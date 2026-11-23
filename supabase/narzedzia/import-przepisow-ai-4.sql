-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 4 (część 4 z 4)
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
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Kurczak, pałka bez skóry, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Mleko kokosowe z puszki', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Tajska Żółta Lekko Ostra Pasta Curry Yellow Curry Paste Mild 400g MAE PLOY', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Papryka czerwona, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Cukinia, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Cebula, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Imbir korzeń, surowy', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Sos sojowy', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Limonka', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Oliwa z oliwek extra virgin', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Ryż jaśminowy, suchy', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Szczypiorek świeży', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'woda', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Czosnek, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Fasola biała z puszki, odsączona', false),
    ('Zupa z białej fasoli i jarmużu', 'Jarmuż, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Pomidory krojone z puszki', false),
    ('Zupa z białej fasoli i jarmużu', 'Marchew, surowa', false),
    ('Zupa z białej fasoli i jarmużu', 'Seler naciowy, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Cebula, surowa', false),
    ('Zupa z białej fasoli i jarmużu', 'Czosnek, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Oliwa z oliwek extra virgin', false),
    ('Zupa z białej fasoli i jarmużu', 'Tymianek suszony', false),
    ('Zupa z białej fasoli i jarmużu', 'Chleb żytni razowy', true),
    ('Zupa z białej fasoli i jarmużu', 'Sól kłodawska', false),
    ('Zupa z białej fasoli i jarmużu', 'Czarny pieprz mielony', false),
    ('Zupa z białej fasoli i jarmużu', 'Pietruszka korzeń', false),
    ('Zupa z białej fasoli i jarmużu', 'Seler korzeń', false),
    ('Zupa z białej fasoli i jarmużu', 'Por, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'woda', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Soczewica czerwona, sucha', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Pomidory krojone z puszki', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Marchew, surowa', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Cebula, surowa', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Czosnek, surowy', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Oliwa z oliwek extra virgin', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Kmin rzymski mielony', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Papryka wędzona mielona', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Cytryna', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Chleb żytni razowy', true),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Sól kłodawska', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Czarny pieprz mielony', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Pietruszka korzeń', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Seler korzeń', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Por, surowy', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'woda', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Łosoś dziki, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Szpinak, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Jogurt grecki naturalny 2%', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Cytryna', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Czosnek, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Oliwa z oliwek extra virgin', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Sól kłodawska', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Czarny pieprz mielony', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Garnek 3 l'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Garnek 2 l'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Patelnia 24 cm'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Nóż szefa kuchni'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Deska do krojenia'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Sitko'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Łyżka cedzakowa'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Widelec'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Waga kuchenna'),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Termometr do mięsa'),
    ('Zupa z białej fasoli i jarmużu', 'Garnek 3 l'),
    ('Zupa z białej fasoli i jarmużu', 'Nóż szefa kuchni'),
    ('Zupa z białej fasoli i jarmużu', 'Deska do krojenia'),
    ('Zupa z białej fasoli i jarmużu', 'Waga kuchenna'),
    ('Zupa z białej fasoli i jarmużu', 'Sitko'),
    ('Zupa z białej fasoli i jarmużu', 'Garnek 2 l'),
    ('Zupa z białej fasoli i jarmużu', 'Łyżka cedzakowa'),
    ('Zupa z białej fasoli i jarmużu', 'Miska'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Garnek 3 l'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Nóż szefa kuchni'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Deska do krojenia'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Waga kuchenna'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Sitko'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Patelnia 24 cm'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Garnek 2 l'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Nóż szefa kuchni'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Deska do krojenia'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Waga kuchenna'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Sitko'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Miska'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Termometr do mięsa')
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
--  Zupa - Tajskie żółte curry z kurczakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa - Tajskie żółte curry z kurczakiem', 'Kremowa zupa curry z kurczakiem, mlekiem kokosowym, warzywami, imbirem i limonką, podana z ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. W etapie 1 przygotuj wszystkie składniki. Etap 2 rozpocznij od nastawienia kurczaka; podczas jego gotowania ugotuj ryż i przygotuj bazę curry na drugim palniku. Czasy etapów są orientacyjne i uwzględniają pracę równoległą. Dłuższe gotowanie ryżu zgodnie z opakowaniem lub dodatkowe dogotowanie mięsa wydłuży etap gotowania.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 528, 1, 2,
  12, 48,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Garnek 2 l', 'Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Sitko', 'Łyżka cedzakowa', 'Widelec', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Samo curry bez ryżu możesz przechować do 3 dni; do kolejnych podań ugotuj świeży ryż. Lodówka: do 4°C.',
  false, 'Jeżeli po 32 minutach gotowania pałki nie są miękkie lub nie osiągnęły 74°C w najgrubszym miejscu mięsa, gotuj dalej i sprawdzaj co 5 minut. Gotową bazę curry zdejmij wtedy z ognia, aby nie rozgotować warzyw. Jeśli curry jest zbyt gęste, dodawaj po łyżce wywaru z ugotowanego kurczaka.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'całe pałki z kością, bez skóry; podana masa dotyczy części jadalnej bez kości', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Kurczak, pałka bez skóry, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Mleko kokosowe z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Tajska Żółta Lekko Ostra Pasta Curry Yellow Curry Paste Mild 400g MAE PLOY';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'paski szerokości około 5 mm', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'półplasterki grubości około 5 mm', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Cukinia, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'cienkie piórka', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'do wyciśnięcia soku', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Ryż jaśminowy, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekany', 'Kolendra świeża', sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'ml'::jednostka_miary, 120,
       'do curry; woda do gotowania ryżu i mięsa jest dodatkowa, jej nadmiar odlej po gotowaniu', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Czosnek, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Kurczak.** Umyj udka z kurczaka. Zostaw mięso w całości.', null::text, false),
         (2::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Imbir.** Obierz imbir i drobno posiekaj.', null::text, false),
         (6::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w paski szerokości około 5 mm.', null::text, false),
         (7::smallint, '**Cukinia.** Umyj cukinię i pokrój w półplasterki grubości około 5 mm.', null::text, false),
         (8::smallint, '**Szczypiorek.** Umyj i osusz szczypiorek, następnie drobno posiekaj.', null::text, false),
         (9::smallint, '**Limonka.** Umyj limonkę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (10::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (11::smallint, '**Baza curry.** Odmierz mleko kokosowe, pastę curry, sos sojowy i wodę do curry do osobnych naczyń.', null::text, false),
         (12::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kurczaka oraz równoległe przygotowanie ryżu i curry', 42 from przepisy p where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Kurczak do garnka.** Włóż pałki do garnka mieszczącego przygotowywaną ilość mięsa. Zalej zimną wodą tak, aby przykryła mięso, i włącz grzanie na pierwszym palniku.', null::text, true),
         (2::smallint, '**Zagotowanie.** Doprowadź wodę z mięsem do wrzenia; zwykle zajmuje to około **5 minut**. Czas zależy od ilości wody i mocy palnika.', null::text, false),
         (3::smallint, '**Zebranie szumowin.** Po zagotowaniu zbierz szumowiny łyżką cedzakową. Zmniejsz ogień i uchyl pokrywkę.', null::text, false),
         (4::smallint, '**Gotowanie kurczaka.** Gotuj łagodnie przez **32 minuty** od zebrania szumowin. Nastaw minutnik. W tym czasie gotuj ryż i curry według kolejnych kroków; po minutniku od razu sprawdź mięso.', null::text, true),
         (5::smallint, '**Ryż — drugi palnik.** Na drugim palniku zagotuj w garnku większą ilość wody, tak aby ryż po wsypaniu był zanurzony i mógł swobodnie się gotować. Wsyp opłukany ryż, zamieszaj i gotuj przez czas podany na opakowaniu. Przed odcedzeniem sprawdź, czy ziarna są miękkie. Kurczak w tym czasie gotuje się na pierwszym palniku.', null::text, false),
         (6::smallint, '**Odcedzenie ryżu.** Ugotowany ryż odcedź na sitku, przełóż z powrotem do garnka i przykryj. Odstaw poza palnik do podania. Drugi palnik jest teraz wolny do przygotowania curry.', 'ziarna są miękkie, a nadmiar wody został odcedzony'::text, false),
         (7::smallint, '**Oliwa na wolnym palniku.** Zacznij około **15 minut** przed końcem gotowania kurczaka, gdy palnik po ryżu jest wolny. Rozgrzej oliwę na patelni przez **1 minutę** na średnim ogniu. Jeśli ryż jeszcze się gotuje, poczekaj na zwolnienie palnika.', null::text, false),
         (8::smallint, '**Cebula.** Dodaj pokrojoną cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (9::smallint, '**Czosnek i imbir.** Dodaj posiekany czosnek i imbir. Smaż przez **1 minutę** na średnim ogniu, mieszając.', null::text, false),
         (10::smallint, '**Pasta curry.** Dodaj odmierzoną pastę curry i smaż przez **1 minutę**, stale mieszając.', 'pasta intensywnie pachnie, ale nie przypala się'::text, false),
         (11::smallint, '**Baza curry.** Wlej odmierzone mleko kokosowe oraz wodę do curry, dodaj sos sojowy. Wymieszaj i doprowadź do łagodnego wrzenia, podgrzewając przez około **2 minuty**.', null::text, false),
         (12::smallint, '**Papryka.** Dodaj paski papryki do łagodnie gotującej się bazy curry. Gotuj przez **3 minuty** na małym ogniu.', null::text, false),
         (13::smallint, '**Cukinia.** Dodaj cukinię i gotuj jeszcze przez **4 minuty** na małym ogniu. Papryka będzie gotowała się łącznie **7 minut**, cukinia **4 minuty**. Jeśli mięso nie jest jeszcze gotowe do dodania, zdejmij patelnię z ognia.', 'warzywa lekko zmiękły i zachowują kształt'::text, false),
         (14::smallint, '**Sprawdzenie kurczaka.** Po **32 minutach** łagodnego gotowania sprawdź najgrubszą część mięsa termometrem, nie dotykając kości. Sprawdź też widelcem, czy mięso łatwo odchodzi od kości. Jeżeli nie osiągnęło **74°C** albo nadal jest twarde, gotuj kolejne **5 minut** i ponów kontrolę. Powtarzaj w razie potrzeby.', 'co najmniej 74°C w mięsie i łatwe oddzielanie go od kości'::text, true),
         (15::smallint, '**Wyjęcie kurczaka.** Gotowe pałki wyjmij łyżką cedzakową na czystą deskę. Wyłącz pierwszy palnik. Wodę z gotowania odlej; możesz zachować niewielką ilość wywaru do ewentualnego rozrzedzenia curry.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Oddzielenie mięsa, połączenie i podanie', 6 from przepisy p where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Przestudzenie mięsa.** Odczekaj około **1 minuty** przed oddzielaniem mięsa; pałki nadal będą gorące, więc przytrzymuj je widelcem.', null::text, false),
         (2::smallint, '**Oddzielenie mięsa.** Przytrzymując pałki widelcem, oddziel mięso od kości i chrząstek. Podziel na większe kawałki.', null::text, false),
         (3::smallint, '**Mięso do curry.** Dodaj mięso do gotowej bazy curry. Podgrzewaj przez **2 minuty** na małym ogniu, delikatnie mieszając. Jeśli patelnia czekała poza palnikiem i zawartość przestała być gorąca, najpierw ponownie doprowadź ją do łagodnego wrzenia, a następnie odlicz **2 minuty**.', null::text, false),
         (4::smallint, '**Sok z limonki.** Zdejmij patelnię z ognia i wmieszaj sok z limonki.', null::text, false),
         (5::smallint, '**Podanie.** Rozdziel ugotowany ryż oraz całe curry na przygotowywaną liczbę porcji. Posyp szczypiorkiem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Zupa z białej fasoli i jarmużu
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa z białej fasoli i jarmużu', 'Warzywna zupa z białą fasolą, jarmużem i pomidorami, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Wywar z marchwi, korzenia pietruszki, korzenia selera i pora gotuje się w osobnym garnku równolegle z bazą pomidorową; cały wywar i wszystkie warzywa trafiają do zupy.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 896, 1, 2,
  20, 32,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Garnek 2 l', 'Łyżka cedzakowa', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Zupę przechowuj w lodówce do 3 dni lub zamroź. Pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Za rzadką zupę zagęść, rozgniatając część fasoli. Twardy jarmuż gotuj kilka minut dłużej.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa z białej fasoli i jarmużu'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa z białej fasoli i jarmużu'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Fasola biała z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'bez twardych łodyg', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Jarmuż, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Seler naciowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki; do wywaru', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'cała odmierzona ilość do wywaru; wywar i wszystkie ugotowane warzywa trafiają do zupy', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż osobno do wywaru.', null::text, false),
         (5::smallint, '**Jarmuż.** Umyj jarmuż, usuń twarde łodygi i porwij liście na mniejsze kawałki.', null::text, false),
         (6::smallint, '**Seler naciowy.** Umyj seler naciowy i pokrój w cienkie plasterki.', null::text, false),
         (7::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (8::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (9::smallint, '**Fasola.** Przełóż fasolę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (10::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników do ugotowania wywaru.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz pieprz i tymianek.', null::text, false),
         (13::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false),
         (14::smallint, '**Sól.** Odmierz sól.', null::text, false),
         (15::smallint, '**Pomidory.** Otwórz puszkę i odmierz pomidory.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie wywaru i bazy pomidorowej', 19 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Wywar — drugi palnik.** W garnku 2 l umieść całą przygotowaną marchew, korzeń pietruszki i korzeń selera. Zalej całą odmierzoną wodą. Przykryj i doprowadź do łagodnego wrzenia, orientacyjnie przez **5–7 minut**. Od zagotowania gotuj na małym ogniu przez **6 minut**. Nastaw minutnik; w tym czasie przygotuj bazę zupy.', null::text, false),
         (2::smallint, '**Baza zupy — równolegle.** W garnku 3 l rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (3::smallint, '**Cebula i seler naciowy.** Smaż cebulę i seler naciowy przez **5 minut**, mieszając.', null::text, false),
         (4::smallint, '**Czosnek i tymianek.** Dodaj czosnek oraz tymianek i smaż przez **30 sekund**.', null::text, false),
         (5::smallint, '**Pomidory.** Dodaj pomidory i doprowadź do wrzenia. Duś bez przykrycia na małym ogniu przez **10 minut**, mieszając co kilka minut.', 'pomidory lekko zgęstniały'::text, false),
         (6::smallint, '**Por — po minutniku wywaru.** Po **6 minutach gotowania korzeni** dodaj por do wywaru. Gotuj jeszcze przez **4 minuty**.', null::text, false),
         (7::smallint, '**Kontrola warzyw.** Sprawdź kostkę marchewki i selera. Jeśli ma twardy, surowy środek, gotuj jeszcze po **2 minuty**, sprawdzając po każdej takiej próbie.', 'warzywa są lekko jędrne, ale bez twardego, surowego środka'::text, true),
         (8::smallint, '**Uzupełnienie wywaru.** Jeżeli podczas gotowania odparowała woda, uzupełnij jej ubytek gorącą wodą do początkowego poziomu, zanim wyjmiesz warzywa.', null::text, false),
         (9::smallint, '**Zachowanie warzyw i wywaru.** Wyjmij wszystkie warzywa łyżką cedzakową do miski i przykryj. Cały wywar zachowaj w garnku do następnego etapu. Nie wylewaj wywaru ani płynu zebranego w misce.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Gotowanie fasoli i jarmużu', 13 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Wywar, fasola i jarmuż.** Do pomidorów wlej cały wywar, dodaj fasolę i jarmuż. Po zagotowaniu gotuj przez **7–8 minut**, aż liście zmiękną. Jeżeli pozostają twarde, przed kolejnym krokiem dogotowuj po **2 minuty**.', null::text, false),
         (2::smallint, '**Warzywa z wywaru.** Dodaj wszystkie odłożone warzywa wraz z płynem, który zebrał się w misce. Doprowadź ponownie do łagodnego wrzenia i podgrzewaj przez **1 minutę**.', null::text, false),
         (3::smallint, '**Doprawienie i podanie.** Dopraw solą i pieprzem, wymieszaj i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Zupa z czerwonej soczewicy i pomidorów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa z czerwonej soczewicy i pomidorów', 'Gęsta zupa z czerwonej soczewicy, pomidorów i marchewki, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Marchew, korzeń pietruszki, korzeń selera i por gotują się razem z zupą w jednym garnku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 774, 1, 2,
  20, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Zupę przechowuj w lodówce do 3 dni albo zamroź po ostudzeniu. Pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Za gęstą zupę rozcieńcz gorącą wodą. Za kwaśną pogotuj z dodatkową marchewką.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 360, 'g'::jednostka_miary, 360,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'cała odmierzona ilość do zupy', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż do zupy.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (7::smallint, '**Soczewica.** Odmierz soczewicę i opłucz na sitku.', null::text, false),
         (8::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (9::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników.', null::text, false),
         (10::smallint, '**Pomidory.** Otwórz puszkę i odmierz pomidory.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz sól, pieprz, wędzoną paprykę i kmin rzymski.', null::text, false),
         (13::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie soczewicy, warzyw i pomidorów', 35 from przepisy p where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Baza zupy.** W garnku rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, kmin i paprykę wędzoną. Smaż przez **30 sekund**.', null::text, false),
         (4::smallint, '**Soczewica.** Dodaj soczewicę i całą odmierzoną wodę. Doprowadź do wrzenia przez około **4 minuty**. Gotuj pod uchyloną pokrywką na małym ogniu przez **7 minut**, mieszając co kilka minut.', null::text, false),
         (5::smallint, '**Warzywa korzeniowe i por.** Dodaj marchew, korzeń pietruszki, korzeń selera i por. Po ponownym zagotowaniu gotuj przez **8 minut**, mieszając co kilka minut, żeby soczewica nie przywarła.', null::text, false),
         (6::smallint, '**Kontrola soczewicy.** Spróbuj soczewicy i sprawdź kostkę marchewki. Jeśli soczewica pozostaje twarda, dogotowuj po **3 minuty**, mieszając i w razie potrzeby uzupełniając odparowany płyn gorącą wodą. Pomidory dodaj dopiero do miękkiej soczewicy.', 'soczewica jest miękka, bez twardego środka'::text, true),
         (7::smallint, '**Pomidory.** Dodaj pomidory. Po ponownym zagotowaniu gotuj przez **6 minut**.', null::text, false),
         (8::smallint, '**Doprawienie.** Zdejmij garnek z ognia, dodaj sok z cytryny, sól i pieprz. Wymieszaj.', null::text, false),
         (9::smallint, '**Podanie.** Podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Łosoś ze szpinakiem i kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Łosoś ze szpinakiem i kaszą bulgur', 'Smażony łosoś ze szpinakiem, cytryną i kaszą bulgur. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 410, 1, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Miska', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Kaszę najlepiej trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeśli łosoś przywiera, poczekaj aż sam łatwo odejdzie od patelni. Za suchy szpinak podlej odrobiną wody.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Łosoś dziki, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (4::smallint, '**Sos jogurtowy.** Wymieszaj jogurt z połową odmierzonego soku z cytryny.', null::text, false),
         (5::smallint, '**Łosoś.** Osusz łososia, usuń ości i dopraw częścią soli oraz pieprzu.', null::text, false),
         (6::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false),
         (7::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Bulgur — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp kaszę bulgur i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Bulgur — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Gdy do końca gotowania kaszy pozostaje około **11 minut**, rozgrzej oliwę na patelni przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie łososia.** Smaż filet grubości około 2–3 cm przez **4 minuty** z jednej strony i **3–4 minuty** z drugiej.', null::text, true),
         (5::smallint, '**Sprawdzenie łososia.** Sprawdź środek; grubszy kawałek dosmaż po **1 minucie**.', 'ryba ma co najmniej 63°C i rozdziela się na płatki'::text, true),
         (6::smallint, '**Zdjęcie łososia.** Zdejmij na talerz.', null::text, false),
         (7::smallint, '**Czosnek.** Zmniejsz ogień. Na tej samej patelni smaż czosnek **20–30 sekund**.', null::text, false),
         (8::smallint, '**Szpinak.** Dodaj szpinak i smaż **1–2 minuty** do zwiędnięcia.', null::text, false),
         (9::smallint, '**Doprawienie szpinaku.** Zdejmij z ognia, dodaj pozostały sok z cytryny i przyprawy.', null::text, false),
         (10::smallint, '**Podanie.** Podaj łososia z kaszą, szpinakiem i sosem jogurtowym.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Zupa - Tajskie żółte curry z kurczakiem', 14, 3, 32),
  ('Zupa z białej fasoli i jarmużu', 16, 3, 27),
  ('Zupa z czerwonej soczewicy i pomidorów', 16, 2, 22),
  ('Łosoś ze szpinakiem i kaszą bulgur', 9, 2, 18)
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
where lower(p.nazwa) in (lower('Zupa - Tajskie żółte curry z kurczakiem'), lower('Zupa z białej fasoli i jarmużu'), lower('Zupa z czerwonej soczewicy i pomidorów'), lower('Łosoś ze szpinakiem i kaszą bulgur'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
