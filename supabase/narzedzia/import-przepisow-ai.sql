-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 1
--  Wygenerowano: 2026-11-11
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
    ('Owsianka z bananem i cynamonem', 'Płatki owsiane', false),
    ('Owsianka z bananem i cynamonem', 'Mleko 2%', false),
    ('Owsianka z bananem i cynamonem', 'Banan', true),
    ('Owsianka z bananem i cynamonem', 'Cynamon mielony', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Owsianka z bananem i cynamonem', 'Rondel'),
    ('Owsianka z bananem i cynamonem', 'Miska'),
    ('Owsianka z bananem i cynamonem', 'Widelec'),
    ('Owsianka z bananem i cynamonem', 'Nóż szefa kuchni'),
    ('Owsianka z bananem i cynamonem', 'Deska do krojenia'),
    ('Owsianka z bananem i cynamonem', 'Waga kuchenna')
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
--  Owsianka z bananem i cynamonem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Owsianka z bananem i cynamonem', 'Kremowa owsianka na mleku, naturalnie słodzona rozgniecionym bananem, z cynamonem i plasterkami banana na wierzchu. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 432, 1, 1,
  3, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Rondel', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Plasterki banana do posypania krój tuż przed podaniem, bo ciemnieją. Przy odgrzewaniu dodaj odrobinę mleka. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeśli owsianka jest za gęsta, dolej trochę mleka. Jeśli jest zbyt rzadka, gotuj jeszcze 1–2 minuty, często mieszając. Gdy banan jest mało dojrzały i owsianka wychodzi mało słodka, następnym razem wybierz banan z brązowymi plamkami na skórce.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Owsianka z bananem i cynamonem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Owsianka z bananem i cynamonem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem') and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'dojrzały; połowa rozgnieciona, połowa w plasterkach', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem') and sk.nazwa = 'Banan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem') and sk.nazwa = 'Cynamon mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 3 from przepisy p where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Banan.** Obierz banana i przekrój na pół. Jedną połowę rozgnieć widelcem w misce na gładką masę. Drugą odłóż do pokrojenia przy podaniu.', null::text, false),
         (2::smallint, '**Baza owsianki.** Odmierz mleko i płatki.', null::text, false),
         (3::smallint, '**Cynamon.** Odmierz cynamon.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie owsianki', 12 from przepisy p where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Zagotowanie płatków.** Wsyp płatki do rondla i wlej mleko. Podgrzewaj około **3 minut** do łagodnego wrzenia, mieszając.', null::text, false),
         (2::smallint, '**Gotowanie owsianki.** Gotuj na małym ogniu przez **5–7 minut** lub czas z opakowania płatków, często mieszając.', null::text, false),
         (3::smallint, '**Banan i cynamon.** Dodaj rozgnieciony banan i połowę cynamonu. Podgrzewaj jeszcze **1 minutę**, mieszając.', 'banan rozszedł się w owsiance, masa jest kremowa i gładka'::text, false),
         (4::smallint, '**Podanie.** Pokrój drugą połowę banana w plasterki. Przełóż owsiankę do miseczki, ułóż na wierzchu plasterki banana i oprósz resztą cynamonu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Owsianka z bananem i cynamonem') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Owsianka z bananem i cynamonem', 4, 2, 7)
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
where lower(p.nazwa) in (lower('Owsianka z bananem i cynamonem'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
