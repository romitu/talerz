-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 12
--  Wygenerowano: 2026-09-25
--
--  Skrypt najpierw sprawdza katalogi składników i sprzętu. Jeśli czegoś
--  brakuje, kończy się błędem „IMPORT PRZERWANY — …” z listą braków
--  i niczego nie zapisuje.
--
--  Przepis o tej samej nazwie jest AKTUALIZOWANY, nie kasowany. Nowe przepisy
--  wchodzą jako prywatne.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

begin;

with
  potrzebne_skladniki(przepis, nazwa, w_sztukach) as (values
    ('Jajecznica z pomidorem i szczypiorkiem', 'Jaja kurze, całe, surowe', true),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Pomidory, surowe', true),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Szczypiorek świeży', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Masło', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Sól kuchenna', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Czarny pieprz mielony', false),
    ('Jajka na miękko z pieczywem i warzywami', 'Jaja kurze, całe, surowe', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Chleb żytni razowy', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Pomidory, surowe', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Ogórek, surowy', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Sól kuchenna', false),
    ('Jajka na miękko z pieczywem i warzywami', 'Czarny pieprz mielony', false),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Chleb żytni razowy', true),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Jaja kurze, całe, surowe', true),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Awokado', true),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Pomidory, surowe', true),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Sól kuchenna', false),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Czarny pieprz mielony', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Chleb żytni razowy', true),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Ser mozzarella', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Pomidory, surowe', true),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Bazylia świeża', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Oliwa z oliwek', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Sól kuchenna', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Czarny pieprz mielony', false),
    ('Kanapki z pastą jajeczną', 'Jaja kurze, całe, surowe', true),
    ('Kanapki z pastą jajeczną', 'Chleb żytni razowy', true),
    ('Kanapki z pastą jajeczną', 'Jogurt grecki naturalny 2%', false),
    ('Kanapki z pastą jajeczną', 'Musztarda', false),
    ('Kanapki z pastą jajeczną', 'Szczypiorek świeży', false),
    ('Kanapki z pastą jajeczną', 'Sól kuchenna', false),
    ('Kanapki z pastą jajeczną', 'Czarny pieprz mielony', false),
    ('Omlet ze szpinakiem i fetą', 'Jaja kurze, całe, surowe', true),
    ('Omlet ze szpinakiem i fetą', 'Szpinak, surowy', false),
    ('Omlet ze szpinakiem i fetą', 'Ser feta', false),
    ('Omlet ze szpinakiem i fetą', 'Olej rzepakowy', false),
    ('Omlet ze szpinakiem i fetą', 'Sól kuchenna', false),
    ('Omlet ze szpinakiem i fetą', 'Czarny pieprz mielony', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Płatki owsiane', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Mleko 2%', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Jabłko ze skórką', true),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Cynamon mielony', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Orzechy włoskie', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Sól kuchenna', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Jaja kurze, całe, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ser feta', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Pomidory, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ogórek, surowy', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sałata rzymska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Oliwa z oliwek', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sól kuchenna', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Czarny pieprz mielony', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Serek wiejski naturalny', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Pomidory, surowe', true),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Ogórek, surowy', true),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Pestki dyni', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Sól kuchenna', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Czarny pieprz mielony', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Skyr naturalny', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Banan', true),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Borówki amerykańskie', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Płatki owsiane', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Orzechy włoskie', false),
    ('Tosty z mozzarellą i pomidorem', 'Chleb żytni razowy', true),
    ('Tosty z mozzarellą i pomidorem', 'Ser mozzarella', false),
    ('Tosty z mozzarellą i pomidorem', 'Pomidory, surowe', true),
    ('Tosty z mozzarellą i pomidorem', 'Bazylia świeża', false),
    ('Tosty z mozzarellą i pomidorem', 'Sól kuchenna', false),
    ('Tosty z mozzarellą i pomidorem', 'Czarny pieprz mielony', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Twaróg półtłusty', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Jogurt naturalny 2%', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Rzodkiewka, surowa', true),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Szczypiorek świeży', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Chleb żytni razowy', true),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Sól kuchenna', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Czarny pieprz mielony', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Jajecznica z pomidorem i szczypiorkiem', 'Patelnia 24 cm'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'miska'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Widelec'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Deska do krojenia'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Waga kuchenna'),
    ('Jajka na miękko z pieczywem i warzywami', 'Garnek 2 l'),
    ('Jajka na miękko z pieczywem i warzywami', 'Nóż szefa kuchni'),
    ('Jajka na miękko z pieczywem i warzywami', 'Deska do krojenia'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Garnek 2 l'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'miska'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Widelec'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Nóż szefa kuchni'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Deska do krojenia'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Nóż szefa kuchni'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Deska do krojenia'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Waga kuchenna'),
    ('Kanapki z pastą jajeczną', 'Garnek 2 l'),
    ('Kanapki z pastą jajeczną', 'miska'),
    ('Kanapki z pastą jajeczną', 'Widelec'),
    ('Kanapki z pastą jajeczną', 'Nóż szefa kuchni'),
    ('Kanapki z pastą jajeczną', 'Deska do krojenia'),
    ('Kanapki z pastą jajeczną', 'Waga kuchenna'),
    ('Omlet ze szpinakiem i fetą', 'Patelnia 24 cm'),
    ('Omlet ze szpinakiem i fetą', 'miska'),
    ('Omlet ze szpinakiem i fetą', 'Widelec'),
    ('Omlet ze szpinakiem i fetą', 'Nóż szefa kuchni'),
    ('Omlet ze szpinakiem i fetą', 'Deska do krojenia'),
    ('Omlet ze szpinakiem i fetą', 'Waga kuchenna'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Rondel'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'miska'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Widelec'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Nóż szefa kuchni'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Deska do krojenia'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Waga kuchenna'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Garnek 2 l'),
    ('Sałatka z jajkiem, fetą i warzywami', 'miska'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Widelec'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Deska do krojenia'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Waga kuchenna'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'miska'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Widelec'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Nóż szefa kuchni'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Deska do krojenia'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Waga kuchenna'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'miska'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Nóż szefa kuchni'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Deska do krojenia'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Waga kuchenna'),
    ('Tosty z mozzarellą i pomidorem', 'Grill kontaktowy'),
    ('Tosty z mozzarellą i pomidorem', 'Nóż szefa kuchni'),
    ('Tosty z mozzarellą i pomidorem', 'Deska do krojenia'),
    ('Tosty z mozzarellą i pomidorem', 'Waga kuchenna'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'miska'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Widelec'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Nóż szefa kuchni'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Deska do krojenia'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Waga kuchenna')
  ),
  braki(opis) as (
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
--  Jajecznica z pomidorem i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajecznica z pomidorem i szczypiorkiem', 'Kremowa jajecznica z pomidorem i świeżym szczypiorkiem. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 197, 1,
  6, 5,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Jajecznicę zjedz bezpośrednio po przygotowaniu.',
  false, 'Jeśli jajecznica wyszła zbyt sucha, zdejmij ją z ognia i wmieszaj mały kawałek masła. Jeśli pomidor puścił dużo wody, smaż chwilę dłużej bez przykrycia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'roztrzepane', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Masło';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pomidora pokrój w kostkę, a szczypiorek drobno posiekaj.', null::text, false),
         (2::smallint, 'Jajka wbij do miski, dopraw solą i pieprzem, po czym roztrzep widelcem.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 5 from przepisy p where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na patelni rozpuść masło, dodaj pomidora i smaż około 2 minut, aż odparuje część soku.', null::text, false),
         (2::smallint, 'Wlej jajka i smaż na małym ogniu, mieszając, aż będą miękko ścięte.', 'jajka są kremowe i nie ma na patelni płynnego białka'::text, false),
         (3::smallint, 'Zdejmij z ognia, dodaj szczypiorek i od razu podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Jajka na miękko z pieczywem i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajka na miękko z pieczywem i warzywami', 'Jajka z płynnym żółtkiem, podane z chlebem żytnim, pomidorem i ogórkiem. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 297, 1,
  5, 6,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie najlepiej zjedz od razu po przygotowaniu. Jajek ugotowanych na miękko nie przechowuj na później.',
  false, 'Jeśli żółtko jest zbyt płynne, włóż jajka ponownie do gorącej wody na 30–60 sekund. Jeśli są zbyt twarde, skróć gotowanie przy następnym przygotowaniu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajka na miękko z pieczywem i warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajka na miękko z pieczywem i warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w cząstki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plasterki', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie jajek', 6 from przepisy p where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'W garnku zagotuj tyle wody, aby przykryła jajka.', null::text, false),
         (2::smallint, 'Delikatnie włóż jajka do wrzątku i gotuj 5–6 minut od ponownego zagotowania.', 'białko jest ścięte, a żółtko pozostaje płynne'::text, true),
         (3::smallint, 'Jajka wyjmij i krótko schłodź pod zimną wodą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 5 from przepisy p where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pomidora pokrój w cząstki, a ogórek w plasterki.', null::text, false),
         (2::smallint, 'Podaj jajka z pieczywem i warzywami. Dopraw solą oraz pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z jajkiem, awokado i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z jajkiem, awokado i pomidorem', 'Syte kanapki z jajkiem na twardo, kremowym awokado i świeżym pomidorem. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 262, 1,
  10, 9,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki zjedz od razu po przygotowaniu. Ugotowane jajko możesz przechować osobno w lodówce do następnego dnia.',
  false, 'Jeśli awokado jest zbyt twarde, pokrój je w cienkie plasterki zamiast rozgniatać. Jeśli pasta ciemnieje, przygotuj ją bezpośrednio przed podaniem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'miąższ rozgnieciony widelcem', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Awokado';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie jajka', 9 from przepisy p where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajko włóż do garnka, zalej wodą i gotuj 9 minut od zagotowania.', null::text, false),
         (2::smallint, 'Schłodź je w zimnej wodzie, obierz i pokrój w plastry.', 'żółtko jest całkowicie ścięte'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 7 from przepisy p where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Miąższ awokado rozgnieć w misce widelcem i dopraw częścią soli oraz pieprzu.', null::text, true),
         (2::smallint, 'Pastę z awokado rozsmaruj na chlebie, a na wierzchu ułóż plastry pomidora i jajka.', null::text, false),
         (3::smallint, 'Dopraw pozostałą solą oraz pieprzem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z mozzarellą, pomidorem i bazylią
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z mozzarellą, pomidorem i bazylią', 'Kanapki z mozzarellą, świeżym pomidorem i bazylią, skropione oliwą. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 227, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki najlepiej zjedz od razu. Składniki możesz przechowywać osobno w lodówce i złożyć tuż przed podaniem.',
  false, 'Jeśli pomidor jest bardzo soczysty, osusz plasterki ręcznikiem papierowym. Jeśli kanapki są mdłe, dodaj odrobinę soli i pieprzu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie kanapek', 7 from przepisy p where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mozzarellę i pomidora pokrój w plastry.', null::text, false),
         (2::smallint, 'Na kromkach chleba ułóż mozzarellę, pomidora i liście bazylii.', null::text, false),
         (3::smallint, 'Skrop oliwą, dopraw solą oraz pieprzem i podaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kanapki z pastą jajeczną
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z pastą jajeczną', 'Kanapki z kremową pastą z jajek, jogurtu, musztardy i szczypiorku. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 227, 1,
  10, 9,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Pastę przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Pieczywo smaruj dopiero przed podaniem.',
  false, 'Jeśli pasta jest zbyt gęsta, dodaj odrobinę jogurtu. Jeśli jest za rzadka, dodaj więcej rozgniecionego jajka.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z pastą jajeczną'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z pastą jajeczną'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie jajek', 9 from przepisy p where lower(p.nazwa) = lower('Kanapki z pastą jajeczną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka włóż do garnka, zalej wodą i gotuj 9 minut od zagotowania.', 'żółtka są całkowicie ścięte'::text, false),
         (2::smallint, 'Ugotowane jajka schłodź w zimnej wodzie i obierz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie pasty', 8 from przepisy p where lower(p.nazwa) = lower('Kanapki z pastą jajeczną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka przełóż do miski i rozgnieć widelcem.', null::text, false),
         (2::smallint, 'Dodaj jogurt, musztardę i szczypiorek. Dopraw solą oraz pieprzem i wymieszaj.', null::text, true),
         (3::smallint, 'Pastę rozsmaruj na kromkach chleba.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Omlet ze szpinakiem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Omlet ze szpinakiem i fetą', 'Delikatny omlet z liśćmi szpinaku i słoną fetą. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 207, 1,
  7, 8,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Odgrzej na patelni na małym ogniu.',
  false, 'Jeśli omlet przywiera, zmniejsz ogień i delikatnie podważ brzegi. Jeśli wierzch pozostaje płynny, przykryj patelnię na 1–2 minuty.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Omlet ze szpinakiem i fetą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Omlet ze szpinakiem i fetą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'roztrzepane', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie masy', 7 from przepisy p where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka wbij do miski, dopraw solą i pieprzem, a następnie roztrzep widelcem.', null::text, false),
         (2::smallint, 'Fetę pokrusz, a większe liście szpinaku posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie omletu', 8 from przepisy p where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej na patelni, dodaj szpinak i smaż około 1 minuty, aż zwiędnie.', null::text, false),
         (2::smallint, 'Wlej jajka, rozłóż fetę na wierzchu i smaż na małym ogniu.', null::text, true),
         (3::smallint, 'Gdy spód się zetnie, złóż omlet na pół i smaż jeszcze 1–2 minuty.', 'środek jest ścięty, ale pozostaje miękki'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Owsianka z jabłkiem, cynamonem i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Owsianka z jabłkiem, cynamonem i orzechami', 'Kremowa owsianka na mleku z jabłkiem, cynamonem i orzechami włoskimi. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 423, 1,
  5, 7,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Rondel', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Przy odgrzewaniu dodaj odrobinę mleka.',
  false, 'Jeśli owsianka jest za gęsta, dolej trochę mleka. Jeśli jest zbyt rzadka, gotuj jeszcze 1–2 minuty, często mieszając.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojone w małą kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Jabłko ze skórką';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Cynamon mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'grubo posiekane', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jabłko pokrój w małą kostkę, a orzechy grubo posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie owsianki', 7 from przepisy p where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Do rondla wsyp płatki, wlej mleko i dodaj sól.', null::text, false),
         (2::smallint, 'Gotuj na małym ogniu przez 5–7 minut, często mieszając.', 'płatki są miękkie, a owsianka kremowa'::text, true),
         (3::smallint, 'Dodaj jabłko i cynamon, wymieszaj i podgrzewaj jeszcze około minuty.', null::text, false),
         (4::smallint, 'Przełóż do miski i posyp orzechami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka z jajkiem, fetą i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z jajkiem, fetą i warzywami', 'Sałatka z jajkami na twardo, fetą, pomidorem, ogórkiem i sałatą, skropiona oliwą. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 387, 1,
  10, 9,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Oliwę i przyprawy najlepiej dodaj przed jedzeniem.',
  false, 'Jeśli sałatka puściła wodę, odlej płyn i dodaj świeżą sałatę. Jeśli feta jest bardzo słona, ogranicz ilość dodatkowej soli.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z jajkiem, fetą i warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z jajkiem, fetą i warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w cząstki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w półplasterki', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'porwana na mniejsze kawałki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Sałata rzymska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie jajek', 9 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka włóż do garnka, zalej wodą i gotuj 9 minut od zagotowania.', null::text, false),
         (2::smallint, 'Schłodź jajka, obierz i pokrój w ćwiartki.', 'żółtka są całkowicie ścięte'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sałatki', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pomidora pokrój w cząstki, ogórek w półplasterki, a sałatę porwij.', null::text, false),
         (2::smallint, 'Warzywa przełóż do miski, dodaj jajka i pokruszoną fetę.', null::text, false),
         (3::smallint, 'Skrop oliwą, dopraw solą oraz pieprzem i delikatnie wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Serek wiejski z pomidorem, ogórkiem i pestkami dyni
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Serek wiejski ze świeżym pomidorem, chrupiącym ogórkiem i pestkami dyni. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 447, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Pestki dyni najlepiej dodaj tuż przed jedzeniem.',
  false, 'Jeśli całość puściła dużo wody, odlej nadmiar płynu. Jeśli smak jest zbyt łagodny, dodaj odrobinę soli i pieprzu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Serek wiejski naturalny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Pestki dyni';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 5 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pomidora i ogórek pokrój w kostkę.', null::text, false),
         (2::smallint, 'Serek wiejski przełóż do miski i dodaj pokrojone warzywa.', null::text, false),
         (3::smallint, 'Dopraw solą i pieprzem, a następnie delikatnie wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Posyp porcję pestkami dyni i podaj od razu.', 'pestki pozostają suche i chrupiące'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Skyr z owocami, płatkami owsianymi i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Skyr z owocami, płatkami owsianymi i orzechami', 'Skyr z bananem, borówkami, płatkami owsianymi i orzechami włoskimi. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 385, 1,
  5, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Orzechy i płatki dodaj przed jedzeniem, aby pozostały chrupiące.',
  false, 'Jeśli skyr jest zbyt gęsty, dodaj odrobinę wody lub mleka. Jeśli owoce są kwaśne, rozgnieć część banana i wymieszaj ze skyrem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and sk.nazwa = 'Skyr naturalny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plasterki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and sk.nazwa = 'Banan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and sk.nazwa = 'Borówki amerykańskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'grubo posiekane', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and sk.nazwa = 'Orzechy włoskie';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 5 from przepisy p where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Banana pokrój w plasterki, a orzechy grubo posiekaj.', null::text, false),
         (2::smallint, 'Skyr przełóż do miski i ułóż na nim banana oraz borówki.', null::text, false),
         (3::smallint, 'Posyp płatkami owsianymi i orzechami tuż przed podaniem.', 'płatki i orzechy pozostają suche i chrupiące'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Tosty z mozzarellą i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z mozzarellą i pomidorem', 'Chrupiące tosty z roztopioną mozzarellą, pomidorem i bazylią. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 219, 1,
  5, 5,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Tosty zjedz bezpośrednio po przygotowaniu, zanim pieczywo zmięknie.',
  false, 'Jeśli pieczywo rumieni się szybciej niż topi ser, zmniejsz temperaturę urządzenia. Jeśli pomidor puszcza dużo soku, osusz plasterki przed ułożeniem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tosty z mozzarellą i pomidorem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tosty z mozzarellą i pomidorem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w cienkie plastry', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Składanie tostów', 5 from przepisy p where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mozzarellę i pomidora pokrój w cienkie plastry.', null::text, false),
         (2::smallint, 'Na jednej kromce ułóż mozzarellę, pomidora i bazylię. Dopraw solą oraz pieprzem i przykryj drugą kromką.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Opiekanie', 5 from przepisy p where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Tost opiekaj w rozgrzanym tosterze lub grillu kontaktowym.', 'pieczywo jest rumiane i chrupiące, a mozzarella się roztopiła'::text, false),
         (2::smallint, 'Odczekaj minutę, przekrój tost i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Twarożek ze szczypiorkiem, rzodkiewką i pieczywem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Klasyczny twarożek z chrupiącą rzodkiewką i świeżym szczypiorkiem, podany z dwiema kromkami chleba żytniego razowego. Przepis na 1 porcję.', (select id from konta order by utworzono limit 1),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 312, 1,
  8, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Twarożek przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Pieczywo trzymaj osobno i dodaj dopiero przy podaniu.',
  false, 'Twarożek za gęsty — dodaj łyżkę jogurtu. Zbyt rzadki — dodaj trochę więcej twarogu. Za słony — dołóż kilka plasterków rzodkiewki albo odrobinę jogurtu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  trwalosc_dni           = excluded.trwalosc_dni,
  porcjowanie            = excluded.porcjowanie,
  porcja_g               = excluded.porcja_g,
  porcje                 = excluded.porcje,
  czas_przygotowania_min = excluded.czas_przygotowania_min,
  czas_obrobki_min       = excluded.czas_obrobki_min,
  sprzet                 = excluded.sprzet,
  przechowywanie         = excluded.przechowywanie,
  mozna_mrozic           = excluded.mozna_mrozic,
  ratunek                = excluded.ratunek,
  zmieniono              = now();

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'rozgnieciony widelcem', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'do rozluźnienia twarogu', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'szt'::jednostka_miary, round((5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojona w drobną kostkę lub cienkie półplasterki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Rzodkiewka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie twarożku', 6 from przepisy p where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Twaróg przełóż do miski i rozgnieć widelcem z jogurtem.', 'aż masa będzie kremowa, ale nadal lekko grudkowata'::text, false),
         (2::smallint, 'Rzodkiewki pokrój drobno, a szczypiorek posiekaj.', null::text, false),
         (3::smallint, 'Dodaj rzodkiewkę i szczypiorek do twarogu, dopraw solą oraz pieprzem i wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Spróbuj twarożku i w razie potrzeby skoryguj solą albo pieprzem.', null::text, false),
         (2::smallint, 'Podaj twarożek z kromkami chleba żytniego razowego.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Jajecznica z pomidorem i szczypiorkiem', 6, 2, 5),
  ('Jajka na miękko z pieczywem i warzywami', 6, 2, 5),
  ('Kanapki z jajkiem, awokado i pomidorem', 6, 2, 5),
  ('Kanapki z mozzarellą, pomidorem i bazylią', 7, 1, 3),
  ('Kanapki z pastą jajeczną', 7, 2, 5),
  ('Omlet ze szpinakiem i fetą', 6, 2, 5),
  ('Owsianka z jabłkiem, cynamonem i orzechami', 6, 2, 5),
  ('Sałatka z jajkiem, fetą i warzywami', 8, 2, 5),
  ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 6, 2, 4),
  ('Skyr z owocami, płatkami owsianymi i orzechami', 5, 1, 3),
  ('Tosty z mozzarellą i pomidorem', 6, 2, 4),
  ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 7, 2, 5)
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
where lower(p.nazwa) in (lower('Jajecznica z pomidorem i szczypiorkiem'), lower('Jajka na miękko z pieczywem i warzywami'), lower('Kanapki z jajkiem, awokado i pomidorem'), lower('Kanapki z mozzarellą, pomidorem i bazylią'), lower('Kanapki z pastą jajeczną'), lower('Omlet ze szpinakiem i fetą'), lower('Owsianka z jabłkiem, cynamonem i orzechami'), lower('Sałatka z jajkiem, fetą i warzywami'), lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni'), lower('Skyr z owocami, płatkami owsianymi i orzechami'), lower('Tosty z mozzarellą i pomidorem'), lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
