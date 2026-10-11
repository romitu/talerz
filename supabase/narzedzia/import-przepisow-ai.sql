-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 1
--  Wygenerowano: 2026-10-11
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
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Tortilla pełnoziarnista', true),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Pierś z kurczaka, surowa', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Papryka czerwona, surowa', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Pomidory, surowe', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Ogórek, surowy', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Sałata rzymska', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Jogurt grecki naturalny 2%', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Czosnek, surowy', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'koperek świeży', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Cytryna', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Olej rzepakowy', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Papryka słodka mielona', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Sól kłodawska', false),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Czarny pieprz mielony', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Patelnia 28 cm'),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Miska'),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Nóż szefa kuchni'),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Deska do krojenia'),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Widelec'),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Waga kuchenna'),
    ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Termometr do mięsa')
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
--  Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Pełnoziarniste tortille z soczystym kurczakiem, papryką, pomidorem, ogórkiem i sałatą oraz jogurtowym sosem czosnkowo-koperkowym. Porcja bazowa obejmuje cały posiłek z ilości składników podanych na liście. Czasy etapów dotyczą jednej porcji bazowej; przy większej ilości dolicz czas podgrzewania placków i smażenia mięsa partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 481, 1, 1,
  12, 16,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Widelec', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej składaj tortille bezpośrednio przed jedzeniem. Kurczaka, sos i osuszone warzywa przechowuj osobno, w zamkniętych pojemnikach w lodówce do 4°C, do 1 dnia. Usmażone mięso szybko schłodź w płytkim pojemniku i wstaw do lodówki najpóźniej w ciągu 2 godzin. Przed podaniem odgrzej mięso do gorącego środka, ogrzej placki i dodaj chłodny sos oraz warzywa. Placki przechowuj zgodnie z opakowaniem.',
  false, 'Jeśli placek pęka podczas zwijania, ogrzej go ponownie na suchej patelni przez 10–15 sekund z każdej strony i zawiń od razu. Mokre warzywa dokładnie osusz przed składaniem. Jeżeli placek jest zbyt mały na całe nadzienie, pozostałą część podaj obok z resztą sosu, zamiast rozrywać tortillę.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'duże, elastyczne placki do zawijania', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'bez skóry i kości; paski grubości około 1 cm', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'bez gniazda nasiennego, w cienkich paskach', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'w cienkich półplasterkach, osuszone z nadmiaru wilgoci', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'w cienkich słupkach', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'umyta, dokładnie osuszona, porwana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Sałata rzymska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'do sosu', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       'obrany, bardzo drobno posiekany i roztarty; do sosu', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'umyte, osuszone i drobno posiekane delikatne gałązki; do sosu', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'sok, do sosu', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'do smażenia kurczaka', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       'do kurczaka', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       'podzielona między sos i kurczaka', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       'podzielony między sos i kurczaka', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w cienkie paski.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidora i pokrój w cienkie półplasterki. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (3::smallint, '**Ogórek.** Umyj i osusz ogórek. Pokrój w cienkie słupki.', null::text, false),
         (4::smallint, '**Sałata.** Umyj liście, dokładnie osusz i porwij na mniejsze kawałki.', null::text, false),
         (5::smallint, '**Koperek.** Umyj i osusz koperek, usuń grube łodygi i drobno posiekaj delikatne gałązki.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek, bardzo drobno posiekaj i rozetrzyj płaską stroną noża.', null::text, false),
         (7::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (8::smallint, '**Sól i pieprz.** Odmierz sól oraz pieprz. Każdą z przypraw podziel na połowę: jedną część do sosu, drugą do kurczaka.', null::text, false),
         (9::smallint, '**Sos.** Odmierz jogurt do miski. Dodaj czosnek, koperek, sok z cytryny oraz przyprawy przeznaczone do sosu. Wymieszaj, przykryj i odstaw do lodówki.', null::text, false),
         (10::smallint, '**Kurczak.** Osusz mięso, usuń twarde błony i pokrój w paski grubości około 1 cm. Dopraw odmierzoną papryką mieloną oraz pozostałą solą i pieprzem.', null::text, false),
         (11::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnię roboczą, które miały kontakt z surowym kurczakiem.', null::text, false),
         (12::smallint, '**Olej.** Odmierz olej do smażenia i odstaw przy kuchence.', null::text, false),
         (13::smallint, '**Placki tortilli.** Wyjmij potrzebne placki z opakowania. Przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podgrzewanie tortilli i smażenie kurczaka', 12 from przepisy p where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie patelni.** Rozgrzej suchą patelnię na średnim ogniu przez około 1 minutę.', null::text, false),
         (2::smallint, '**Podgrzanie placków.** Ogrzewaj tortille kolejno po **15–20 sekund z każdej strony**, tylko do zmięknięcia. Odkładaj na talerz i przykrywaj czystą ściereczką.', null::text, false),
         (3::smallint, '**Olej na patelnię.** Wlej odmierzony olej na tę samą patelnię. Rozgrzewaj przez około 30 sekund. Jeśli smażysz mięso partiami, podziel olej między partie.', null::text, false),
         (4::smallint, '**Smażenie kurczaka.** Rozłóż paski w jednej warstwie. Smaż przez **6–8 minut na średnim ogniu**, obracając co około 2 minuty. Przy większej ilości smaż partiami.', null::text, false),
         (5::smallint, '**Sprawdzenie kurczaka.** Zmierz temperaturę w środku najgrubszego kawałka: powinna wynosić **co najmniej 74°C**. Jeśli jest niższa, dosmażaj **po 1 minucie** i ponawiaj pomiar.', 'temperatura w środku najgrubszego kawałka wynosi co najmniej 74°C'::text, true),
         (6::smallint, '**Zdjęcie mięsa.** Gotowego kurczaka od razu przełóż na czysty talerz, żeby nie wysychał na gorącej patelni.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Składanie i podanie', 4 from przepisy p where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Sos na placki.** Wyjmij sos z lodówki i rozdziel między tortille. Rozsmaruj, pozostawiając przy brzegach około 3 cm wolnego miejsca.', null::text, false),
         (2::smallint, '**Nadzienie.** Rozdziel sałatę, paprykę, ogórek, pomidora i kurczaka między placki. Układaj nadzienie na środku.', null::text, false),
         (3::smallint, '**Zwijanie.** Złóż boczne brzegi do środka. Zwiń tortillę od dołu, przytrzymując nadzienie, i ułóż łączeniem w dół. Jeśli część nadzienia się nie mieści, podaj ją obok jako część tego samego posiłku.', null::text, false),
         (4::smallint, '**Podanie.** Przekrój tortille na skos i podaj od razu. Rozdziel całość na przygotowywaną liczbę porcji.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and e.kolejnosc = 3;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 14, 3, 23)
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
where lower(p.nazwa) in (lower('Tortille z kurczakiem i warzywami z sosem czosnkowo-koperkowym'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
