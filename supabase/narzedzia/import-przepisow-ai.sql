-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 9
--  Wygenerowano: 2026-10-22
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
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Jagnięcina, udziec surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Ciecierzyca z puszki, odsączona', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Pomidory krojone z puszki', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Kasza bulgur, sucha', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Marchew, surowa', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Cebula, surowa', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'woda', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Czosnek, surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Oliwa z oliwek', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Kmin rzymski mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Cynamon mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Papryka słodka mielona', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Sól kłodawska', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Pietruszka korzeń', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Seler korzeń', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Fasola biała z puszki, odsączona', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Jarmuż, surowy', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Pomidory krojone z puszki', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Marchew, surowa', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Cebula, surowa', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czosnek, surowy', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'woda', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Oliwa z oliwek', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Chleb żytni razowy', true),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Tymianek suszony', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Papryka wędzona mielona', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Sól kłodawska', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czarny pieprz mielony', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Pietruszka korzeń', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Seler korzeń', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Marchew, surowa', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Cebula, surowa', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Czosnek, surowy', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'woda', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Oliwa z oliwek', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Sól kłodawska', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Czarny pieprz mielony', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Pierś z kurczaka, surowa', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Ryż basmati, suchy', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Jogurt grecki naturalny 2%', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Pietruszka natka', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Pietruszka korzeń', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Seler korzeń', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Por, surowy', false),
    ('Małże w pomidorowym bulionie', 'Małże, surowe', false),
    ('Małże w pomidorowym bulionie', 'Pomidory krojone z puszki', false),
    ('Małże w pomidorowym bulionie', 'woda', false),
    ('Małże w pomidorowym bulionie', 'Seler naciowy, surowy', false),
    ('Małże w pomidorowym bulionie', 'Cebula, surowa', false),
    ('Małże w pomidorowym bulionie', 'Czosnek, surowy', false),
    ('Małże w pomidorowym bulionie', 'Oliwa z oliwek', false),
    ('Małże w pomidorowym bulionie', 'Pietruszka natka', false),
    ('Małże w pomidorowym bulionie', 'Chleb żytni razowy', true),
    ('Małże w pomidorowym bulionie', 'Czarny pieprz mielony', false),
    ('Małże w pomidorowym bulionie', 'Marchew, surowa', false),
    ('Małże w pomidorowym bulionie', 'Pietruszka korzeń', false),
    ('Małże w pomidorowym bulionie', 'Por, surowy', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa, surowa', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Pieczarki, surowe', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Jogurt grecki naturalny 2%', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Musztarda', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Cebula, surowa', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'woda', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Olej rzepakowy', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Tymianek suszony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Sól kłodawska', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Czarny pieprz mielony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Pietruszka korzeń', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Seler korzeń', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Por, surowy', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Polędwiczka wieprzowa, surowa', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Pieczarki, surowe', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Boczniaki, surowe', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Cebula, surowa', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Czosnek, surowy', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Kapusta kiszona', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Jogurt grecki naturalny 2%', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'woda', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Kasza gryczana, sucha', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Oliwa z oliwek', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Tymianek suszony', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Sól kłodawska', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Czarny pieprz mielony', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Pietruszka korzeń', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Seler korzeń', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Por, surowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Udo z kurczaka bez skóry, surowe', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Kasza jęczmienna, sucha', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Marchew, surowa', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Por, surowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Groszek zielony mrożony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Seler naciowy, surowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'woda', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Olej rzepakowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Tymianek suszony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Sól kłodawska', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Czarny pieprz mielony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Pietruszka korzeń', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Ryż parboiled, suchy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Pieczarki, surowe', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Szpinak, surowy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Parmezan', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Cebula, surowa', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czosnek, surowy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'woda', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Oliwa z oliwek', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Sól kłodawska', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czarny pieprz mielony', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Pietruszka korzeń', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Seler korzeń', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Por, surowy', false),
    ('Wieprzowina w sosie chrzanowym', 'Szynka wieprzowa chuda, surowa', false),
    ('Wieprzowina w sosie chrzanowym', 'Ziemniaki, surowe', false),
    ('Wieprzowina w sosie chrzanowym', 'Czosnek, surowy', false),
    ('Wieprzowina w sosie chrzanowym', 'woda', false),
    ('Wieprzowina w sosie chrzanowym', 'Chrzan tarty', false),
    ('Wieprzowina w sosie chrzanowym', 'Jogurt grecki naturalny 2%', false),
    ('Wieprzowina w sosie chrzanowym', 'Fasolka szparagowa mrożona', false),
    ('Wieprzowina w sosie chrzanowym', 'Oliwa z oliwek', false),
    ('Wieprzowina w sosie chrzanowym', 'Pietruszka natka', false),
    ('Wieprzowina w sosie chrzanowym', 'koperek świeży', false),
    ('Wieprzowina w sosie chrzanowym', 'Czarny pieprz mielony', false),
    ('Wieprzowina w sosie chrzanowym', 'Sól kłodawska', false),
    ('Wieprzowina w sosie chrzanowym', 'Marchew, surowa', false),
    ('Wieprzowina w sosie chrzanowym', 'Pietruszka korzeń', false),
    ('Wieprzowina w sosie chrzanowym', 'Seler korzeń', false),
    ('Wieprzowina w sosie chrzanowym', 'Por, surowy', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Garnek 3 l'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Garnek 2 l'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Nóż szefa kuchni'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Deska do krojenia'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Waga kuchenna'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Sitko'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Garnek 3 l'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Nóż szefa kuchni'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Deska do krojenia'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Waga kuchenna'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Sitko'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Garnek 3 l'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Patelnia 28 cm'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Blender ręczny'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Nóż szefa kuchni'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Deska do krojenia'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Tarka o grubych oczkach'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Waga kuchenna'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Termometr do mięsa'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Sitko'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Miska'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Tarka o drobnych oczkach'),
    ('Małże w pomidorowym bulionie', 'Garnek 3 l'),
    ('Małże w pomidorowym bulionie', 'Nóż szefa kuchni'),
    ('Małże w pomidorowym bulionie', 'Deska do krojenia'),
    ('Małże w pomidorowym bulionie', 'Waga kuchenna'),
    ('Małże w pomidorowym bulionie', 'Tarka o drobnych oczkach'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Patelnia 28 cm'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Garnek 2 l'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Miska'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Nóż szefa kuchni'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Deska do krojenia'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Waga kuchenna'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Sitko'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Termometr do mięsa'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Tarka o drobnych oczkach'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Patelnia 28 cm'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Nóż szefa kuchni'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Deska do krojenia'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Garnek 2 l'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Sitko'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Miska'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Termometr do mięsa'),
    ('Polędwiczka z pieczarkami i boczniakami', 'Tarka o drobnych oczkach'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Garnek 3 l'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Nóż szefa kuchni'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Deska do krojenia'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Waga kuchenna'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Sitko'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Termometr do mięsa'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Garnek 3 l'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Tarka o drobnych oczkach'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Nóż szefa kuchni'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Deska do krojenia'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Waga kuchenna'),
    ('Wieprzowina w sosie chrzanowym', 'Garnek 3 l'),
    ('Wieprzowina w sosie chrzanowym', 'Patelnia 24 cm'),
    ('Wieprzowina w sosie chrzanowym', 'Tłuczek do ziemniaków'),
    ('Wieprzowina w sosie chrzanowym', 'Nóż szefa kuchni'),
    ('Wieprzowina w sosie chrzanowym', 'Deska do krojenia'),
    ('Wieprzowina w sosie chrzanowym', 'Garnek 2 l'),
    ('Wieprzowina w sosie chrzanowym', 'Rondel'),
    ('Wieprzowina w sosie chrzanowym', 'Blender ręczny'),
    ('Wieprzowina w sosie chrzanowym', 'Miska'),
    ('Wieprzowina w sosie chrzanowym', 'Waga kuchenna')
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
--  Gulasz jagnięcy z ciecierzycą i pomidorami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz jagnięcy z ciecierzycą i pomidorami', 'Aromatyczny gulasz jagnięcy z ciecierzycą, pomidorami i korzennymi przyprawami, podany z bulgurem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 713, 1, 2,
  20, 127,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź. Kaszę trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Twardą jagnięcinę duś dalej na małym ogniu. Za rzadki sos odparuj bez przykrycia.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 320, 'g'::jednostka_miary, 320,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Jagnięcina, udziec surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 360, 'g'::jednostka_miary, 360,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'jedna trzecia drobno posiekana do sosu; reszta w półplasterkach około 5 mm', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Cynamon mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Seler korzeń';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń selera.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Marchew.** Umyj i obierz marchew. Jedną trzecią drobno posiekaj do bazy sosu, a pozostałą część pokrój w półplasterki grubości około 5 mm i odłóż osobno.', null::text, false),
         (6::smallint, '**Ciecierzyca.** Przełóż ciecierzycę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (7::smallint, '**Jagnięcina.** Osusz mięso i pokrój w kostkę około 3 cm.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (10::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz sól, słodką paprykę, kmin rzymski i cynamon.', null::text, false),
         (13::smallint, '**Pomidory.** Otwórz puszkę i odmierz pomidory.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie i gotowanie kaszy', 127 from przepisy p where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Obsmażenie jagnięciny.** Obsmaż jagnięcinę partiami po **4–5 minut**, obracając; dla porcji bazowej przeznacz około **10 minut**.', null::text, false),
         (3::smallint, '**Zdjęcie mięsa.** Przełóż na talerz.', null::text, false),
         (4::smallint, '**Cebula.** W tym samym garnku smaż cebulę **4 minuty**.', null::text, false),
         (5::smallint, '**Warzywa do sosu.** Dodaj drobno posiekaną część marchwi, cały korzeń pietruszki i seler korzeniowy. Smaż przez **3–4 minuty**, mieszając. Warzywa będą dusiły się z mięsem od początku.', null::text, false),
         (6::smallint, '**Przyprawy.** Dodaj czosnek, kmin, cynamon i paprykę; smaż **30 sekund**.', null::text, false),
         (7::smallint, '**Sos z warzyw.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Dodaj pomidory, obsmażoną jagnięcinę oraz soki z talerza.', null::text, false),
         (8::smallint, '**Duszenie jagnięciny.** Doprowadź do łagodnego wrzenia przez około **3 minuty**. Duś pod przykryciem przez **80 minut**. Sprawdzaj płyn co **20 minut**. Dolewaj niewielką ilość gorącej wody tylko wtedy, gdy sos nadmiernie gęstnieje lub zaczyna przywierać; nie uzupełniaj automatycznie każdego ubytku.', null::text, false),
         (9::smallint, '**Kontrola mięsa.** Sprawdź jagnięcinę. Powinna być prawie miękka, zanim dodasz pozostałą marchew. Jeżeli jest nadal twarda, duś dalej po **15 minut**, kontrolując sos.', null::text, false),
         (10::smallint, '**Pozostała marchew.** Dodaj półplasterki marchwi i duś przez **8 minut**.', null::text, false),
         (11::smallint, '**Kasza — równolegle.** Gdy mięso jest już prawie miękkie, ugotuj bulgur na drugim palniku przez czas z opakowania. Wodę do kaszy traktuj jako wodę do gotowania i odcedź jej nadmiar.', null::text, false),
         (12::smallint, '**Ciecierzyca.** Dodaj ciecierzycę i gotuj przez **10 minut**. Sprawdź miękkość mięsa i marchwi. Jeśli sos jest zbyt rzadki, pod koniec zdejmij pokrywkę; przy zbyt gęstym dolej niewielką ilość gorącej wody.', 'mięso łatwo rozdziela się widelcem, marchew jest miękka, ale zachowuje kształt'::text, true),
         (13::smallint, '**Doprawienie i podanie.** Dopraw solą i podaj z kaszą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz z białej fasoli, jarmużu i pomidorów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz z białej fasoli, jarmużu i pomidorów', 'Gęsty roślinny gulasz z białej fasoli, jarmużu i pomidorów, podany z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 678, 1, 2,
  15, 42,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Gulasz przechowuj w lodówce do 3 dni albo zamroź po szybkim schłodzeniu. Pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Za rzadki gulasz zagęść, rozgniatając część fasoli w sosie. Jeśli zbytnio zgęstnieje, dodaj niewielką ilość gorącej wody.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 320, 'g'::jednostka_miary, 320,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Fasola biała z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'bez twardych łodyg', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Jarmuż, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 360, 'g'::jednostka_miary, 360,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'kostka około 7–8 mm; podsmażona z cebulą tworzy bazę sosu', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Seler korzeń';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń selera.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Fasola.** Przełóż fasolę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (4::smallint, '**Jarmuż.** Umyj jarmuż, usuń twarde łodygi i porwij liście na mniejsze kawałki.', null::text, false),
         (5::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm.', null::text, false),
         (6::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (7::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (8::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól, pieprz, wędzoną paprykę i tymianek.', null::text, false),
         (11::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false),
         (12::smallint, '**Pomidory.** Otwórz puszkę i odmierz pomidory.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 42 from przepisy p where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Warzywna baza.** Dodaj cebulę, marchew, korzeń pietruszki i seler korzeniowy. Smaż przez **5–6 minut**, mieszając, aż cebula zmięknie i lekko się zezłoci.', null::text, false),
         (3::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, tymianek i paprykę wędzoną; smaż **30 sekund**.', null::text, false),
         (4::smallint, '**Baza sosu.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Dodaj pomidory i doprowadź do łagodnego wrzenia przez około **2 minuty**.', null::text, false),
         (5::smallint, '**Gotowanie warzyw.** Gotuj pod przykryciem przez **15 minut**, mieszając kilka razy. Sprawdź marchew, pietruszkę i seler. Jeśli mają twardy środek, dogotowuj po **3 minuty** przed dodaniem fasoli. Dolej trochę gorącej wody, gdy sos nadmiernie gęstnieje.', 'warzywa korzeniowe są miękkie przed dodaniem fasoli'::text, true),
         (6::smallint, '**Fasola.** Dodaj fasolę i gotuj **5 minut**.', null::text, false),
         (7::smallint, '**Jarmuż.** Dodaj jarmuż i gotuj jeszcze **5 minut**.', 'liście jarmużu są miękkie, marchew bez twardego środka'::text, true),
         (8::smallint, '**Doprawienie i podanie.** Dopraw solą i pieprzem, podaj z przygotowanym pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kurczak z ryżem, marchewką i jogurtem greckim
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kurczak z ryżem, marchewką i jogurtem greckim', 'Kurczak z ryżem i marchewką przygotowany na jednej patelni, z dodatkiem cebuli, czosnku i jogurtu greckiego. Kremowe, sycące danie na kilka porcji. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, por, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 640, 1, 3,
  15, 52,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Patelnia 28 cm', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Tarka o grubych oczkach', 'Waga kuchenna', 'Termometr do mięsa', 'Sitko', 'Miska', 'Tarka o drobnych oczkach']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po wystudzeniu przechowuj w szczelnym pojemniku w lodówce do 3 dni. Podczas odgrzewania, jeśli ryż wchłonie sos i danie zrobi się zbyt gęste, dodaj niewielką ilość wody.',
  false, null
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, 'koperek', sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana; cienkie półplasterki do bazy sosu', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń selera.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Por.** Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki.', null::text, false),
         (4::smallint, '**Marchew.** Umyj i obierz marchew, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (7::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (8::smallint, '**Kurczak.** Osusz mięso kurczaka bez skóry i kości, pokrój w kostkę około 2 cm.', null::text, false),
         (9::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (10::smallint, '**Ryż.** Odmierz ryż i opłucz na sitku. Sprawdź na opakowaniu czas gotowania metodą wchłaniania wody.', null::text, false),
         (11::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (12::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (13::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (14::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie kurczaka i warzyw', 17 from przepisy p where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Na głębokiej patelni z pokrywą rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (2::smallint, '**Obsmażenie kurczaka.** Dodaj pokrojonego kurczaka. Smaż około **2 minuty** z każdej strony, aż mięso zrumieni się z zewnątrz, ale w środku nie będzie jeszcze całkowicie gotowe. W trakcie smażenia dopraw częścią soli i pieprzu.', null::text, false),
         (3::smallint, '**Zdjęcie kurczaka.** Podsmażonego kurczaka zdejmij z patelni i odłóż na bok.', null::text, false),
         (4::smallint, '**Cebula.** Na tę samą patelnię dodaj pozostałą oliwę i cebulę. Smaż około **3 minut**.', null::text, false),
         (5::smallint, '**Warzywa korzeniowe i por.** Dodaj startą marchew, korzeń pietruszki, seler oraz pokrojony por. Smaż z cebulą przez **5–6 minut**, mieszając, aż por zmięknie.', null::text, false),
         (6::smallint, '**Czosnek.** Dodaj czosnek, wymieszaj i smaż jeszcze około **30 sekund**.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Gotowanie ryżu i wykończenie dania', 35 from przepisy p where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie warzywnej bazy.** Do podsmażonych warzyw z czosnkiem wlej odmierzoną wodę. Mieszając przez **1 minutę**, rozpuść zrumienione pozostałości z dna. Doprowadź do wrzenia przez około **3 minuty**, przykryj i gotuj łagodnie przez **8–10 minut**. Wszystkie warzywa pozostają w daniu.', null::text, false),
         (2::smallint, '**Ryż i kurczak.** Dodaj opłukany ryż oraz obsmażonego kurczaka wraz z sokami z talerza. Wymieszaj i doprowadź ponownie do łagodnego wrzenia.', null::text, false),
         (3::smallint, '**Gotowanie ryżu.** Przykryj i gotuj na małym ogniu przez czas podany na opakowaniu, orientacyjnie **12–15 minut**. Sprawdź stan płynu w połowie; jeśli ryż pozostaje twardy, a płynu prawie nie ma, dolej trochę gorącej wody.', null::text, false),
         (4::smallint, '**Kontrola ryżu i kurczaka.** Sprawdź miękkość ziaren oraz temperaturę największego kawałka kurczaka. Jeśli ryż jest twardy lub mięso nie osiągnęło **74°C**, gotuj dalej po **2 minuty**, kontrolując płyn. Jeśli ziarna i mięso są gotowe, a płynu jest dużo, odparuj go bez pokrywki przez **1–2 minuty**.', 'ryż jest miękki, danie wilgotne, a kurczak ma co najmniej 74°C'::text, true),
         (5::smallint, '**Zdjęcie z ognia.** Zdejmij patelnię z ognia.', null::text, false),
         (6::smallint, '**Hartowanie jogurtu.** Wymieszaj jogurt w misce z niewielką ilością gorącego ryżu i sosu z patelni. Stopniowo dodawaj kolejne małe porcje, aż jogurt się ogrzeje. Wmieszaj go do dania poza ogniem.', null::text, false),
         (7::smallint, '**Doprawienie.** Po dodaniu jogurtu nie gotuj już dania. Dopraw pozostałą solą i pieprzem według smaku.', null::text, false),
         (8::smallint, '**Natka i podanie.** Dodaj posiekaną natkę pietruszki, wymieszaj i podawaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Małże w pomidorowym bulionie
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Małże w pomidorowym bulionie', 'Małże gotowane w wywarze powstającym w garnku z podsmażonej cebuli, selera naciowego, marchwi, korzenia pietruszki, pora, czosnku, pomidorów i wody, podane z natką. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
  0, 'prywatna',
  'waga', 712, 1, 1,
  13, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Tarka o drobnych oczkach']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie najlepiej zjedz bezpośrednio po przygotowaniu.',
  false, 'Jeśli bulion za bardzo zgęstnieje, rozrzedź go gorącą wodą. Małże dodawaj dopiero do gotowej bazy, aby nie gotować ich nadmiernie.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Małże w pomidorowym bulionie'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Małże w pomidorowym bulionie'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'surowe mięso małży bez muszli; podana masa dotyczy części jadalnej, nie muszli', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Małże, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Seler naciowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'biała i jasnozielona część, dokładnie wypłukana; cienkie półplasterki do bazy sosu', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 13 from przepisy p where lower(p.nazwa) = lower('Małże w pomidorowym bulionie');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Por.** Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki.', null::text, false),
         (4::smallint, '**Seler naciowy.** Umyj seler naciowy i pokrój w cienkie plasterki.', null::text, false),
         (5::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (6::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (7::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (8::smallint, '**Małże.** Przygotuj surowe mięso małży bez muszli, usuń ewentualne fragmenty muszli. Mrożone mięso wcześniej rozmroź w lodówce i odsącz.', null::text, false),
         (9::smallint, '**Po przygotowaniu małży.** Umyj ręce i przybory, które miały kontakt z surowymi małżami.', null::text, false),
         (10::smallint, '**Płynna baza.** Odmierz pomidory z puszki i wodę z listy składników.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Pieprz.** Odmierz pieprz.', null::text, false),
         (13::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 30 from przepisy p where lower(p.nazwa) = lower('Małże w pomidorowym bulionie');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Warzywna baza.** Dodaj cebulę, seler naciowy, startą marchew i korzeń pietruszki oraz por. Smaż przez **5–6 minut**, mieszając, aż cebula i por zmiękną.', null::text, false),
         (3::smallint, '**Czosnek.** Dodaj czosnek i smaż **30 sekund**.', null::text, false),
         (4::smallint, '**Wywar pomidorowo-warzywny.** Wlej odmierzoną wodę i mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości z dna. Dodaj pomidory, doprowadź do wrzenia przez około **2 minuty** i gotuj pod przykryciem przez **10–12 minut**.', null::text, false),
         (5::smallint, '**Kontrola warzyw.** Sprawdź seler naciowy i starte korzenie. Jeśli są twarde, dogotowuj po **2 minuty** przed dodaniem małży. Jeśli wywar za bardzo zgęstniał, dolej trochę gorącej wody.', 'wszystkie warzywa są miękkie przed dodaniem małży'::text, true),
         (6::smallint, '**Gotowanie małży.** Dodaj mięso małży, ponownie doprowadź do łagodnego wrzenia i od tego momentu gotuj przez **4–5 minut**. W razie potrzeby dogotuj przez kolejną minutę.', 'mięso jest nieprzezroczyste i jędrne, gorące w środku'::text, true),
         (7::smallint, '**Podanie.** Dodaj pieprz i natkę, podaj od razu z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Polędwiczka w sosie musztardowym z kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa w lekkim sosie musztardowo-jogurtowym z pieczarkami i kaszą bulgur. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, por, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 691, 1, 1,
  16, 45,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa', 'Tarka o drobnych oczkach']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj łagodnie, do gorącego środka całej porcji. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Mięso wyjmij z patelni na czas smażenia pieczarek. Sos jogurtowy dodawaj poza ogniem po zahartowaniu. Długie duszenie gotowej polędwiczki ją wysuszy.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 170, 'g'::jednostka_miary, 170,
       'pokrojona w plastry', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'biała i jasnozielona część, dokładnie wypłukana; cienkie półplasterki do bazy sosu', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 16 from przepisy p where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń selera.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Por.** Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki.', null::text, false),
         (4::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Sos jogurtowy.** Odmierz jogurt i musztardę, wymieszaj w misce.', null::text, false),
         (7::smallint, '**Polędwiczka.** Osusz polędwiczkę, usuń twardą błonę i pokrój na medaliony grubości około 1,5 cm. Dopraw częścią soli i pieprzu.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (10::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (11::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz tymianek, sól i pieprz; część soli i pieprzu wykorzystaj do przygotowania mięsa, resztę zachowaj do doprawienia sosu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy, przygotowanie sosu i smażenie mięsa', 45 from przepisy p where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Kasza — równolegle.** Zagotuj wodę w garnku, wsyp bulgur i gotuj zgodnie z instrukcją na opakowaniu. Nastaw minutnik; podczas gotowania przygotowuj sos. Woda do kaszy jest osobna i jej nadmiar zostanie odcedzony.', null::text, false),
         (2::smallint, '**Rozgrzanie tłuszczu.** Na patelni rozgrzej połowę oleju przez **1 minutę**. Pozostałą część zachowaj do mięsa.', null::text, false),
         (3::smallint, '**Cebula, korzenie i por.** Dodaj cebulę, starte korzenie pietruszki i selera oraz por. Smaż przez **3 minuty** na umiarkowanym ogniu, mieszając.', null::text, false),
         (4::smallint, '**Pieczarki.** Dodaj pieczarki i smaż przez **7–9 minut**, aż większość wody odparuje, a grzyby lekko się zrumienią.', null::text, false),
         (5::smallint, '**Tymianek i woda.** Dodaj tymianek i całą odmierzoną wodę. Mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości z dna patelni.', null::text, false),
         (6::smallint, '**Gotowanie warzywnej bazy.** Doprowadź do łagodnego wrzenia przez około **1–2 minuty**. Przykryj i duś przez **10–12 minut**. Sprawdź korzenie; jeśli są twarde, dogotowuj po **2 minuty**. Jeśli płynu brakuje, dolej niewielką ilość gorącej wody.', 'korzenie i por są miękkie, w sosie pozostaje płyn'::text, true),
         (7::smallint, '**Kasza — po minutniku.** Niezależnie od postępu przygotowania sosu sprawdź miękkość kaszy po czasie z opakowania. Odcedź nadmiar wody, przykryj i odstaw poza palnik.', null::text, false),
         (8::smallint, '**Odłożenie sosu.** Przełóż całą bazę warzywno-grzybową wraz z płynem do miski i przykryj. Na patelni nie pozostawiaj kawałków warzyw, które mogłyby przypalić się podczas smażenia mięsa.', null::text, false),
         (9::smallint, '**Rozgrzanie tłuszczu do mięsa.** Na opróżnionej patelni rozgrzej pozostałą część oleju przez około **1 minutę**.', null::text, false),
         (10::smallint, '**Smażenie polędwiczki.** Smaż medaliony przez **2–3 minuty z każdej strony**. Sprawdź temperaturę w środku najgrubszego kawałka. Jeśli jest niższa niż **63°C**, dosmażaj po **1 minucie**, kontrolując temperaturę.', 'najgrubszy medalion ma w środku co najmniej 63°C'::text, true),
         (11::smallint, '**Odpoczynek mięsa.** Przełóż gotowe mięso na czysty talerz i pozostaw na co najmniej **3 minuty**. W tym czasie wykończ sos.', null::text, false),
         (12::smallint, '**Połączenie smaków.** Przełóż na patelnię najpierw płynną część sosu z miski. Mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości po mięsie. Dodaj wszystkie warzywa i grzyby oraz soki z talerza po mięsie. Podgrzewaj przez **1–2 minuty**. Jeśli sos jest za gęsty, dolej trochę gorącej wody.', null::text, false),
         (13::smallint, '**Sos jogurtowo-musztardowy.** Zdejmij patelnię z ognia. Przygotowaną mieszaninę jogurtu i musztardy ogrzej stopniowo małymi porcjami ciepłego sosu, następnie wmieszaj do patelni. Nie zagotowuj.', null::text, false),
         (14::smallint, '**Doprawienie.** Dopraw sos pozostałą solą i pieprzem.', null::text, false),
         (15::smallint, '**Podanie.** Po co najmniej 3 minutach odpoczynku przełóż mięso do ciepłego sosu i podaj z bulgurem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Polędwiczka z pieczarkami i boczniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Polędwiczka z pieczarkami i boczniakami', 'Delikatna polędwiczka wieprzowa z pieczarkami i boczniakami w lekkim sosie jogurtowym z tymiankiem. Podawana z kaszą gryczaną i kapustą kiszoną. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, por, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
  3, 'prywatna',
  'waga', 705, 1, 1,
  15, 45,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Garnek 2 l', 'Sitko', 'Miska', 'Termometr do mięsa', 'Tarka o drobnych oczkach']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Kaszę najlepiej przechowywać osobno. Dania nie polecałbym do mrożenia ze względu na sos jogurtowy.',
  false, 'Zbyt gęsty sos rozcieńcz niewielką ilością gorącej wody przed dodaniem jogurtu. Mięso smaż dopiero po przygotowaniu warzywnej bazy i kontroluj temperaturę, żeby nie przesuszyć polędwiczki. Jogurt dodawaj poza ogniem.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Polędwiczka z pieczarkami i boczniakami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Polędwiczka z pieczarkami i boczniakami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'w plastrach', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'porwane na paski', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Boczniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'odciśnięta', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Kapusta kiszona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'sucha, ugotowana osobno', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Kasza gryczana, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       'doprawiaj stopniowo, uwzględniając słoną kapustę podawaną obok', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.2, 'g'::jednostka_miary, 0.2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'biała i jasnozielona część, dokładnie wypłukana; cienkie półplasterki do bazy sosu', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń selera.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Por.** Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki.', null::text, false),
         (4::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (5::smallint, '**Boczniaki.** Oczyść boczniaki i porwij na paski.', null::text, false),
         (6::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (7::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (8::smallint, '**Kapusta kiszona.** Odciśnij kapustę kiszoną i odłóż do podania jako surówkę.', null::text, false),
         (9::smallint, '**Jogurt.** Odmierz jogurt i wyjmij z lodówki na czas przygotowania dania.', null::text, false),
         (10::smallint, '**Polędwiczka.** Osusz polędwiczkę, usuń twardą błonę i pokrój na medaliony grubości około 2 cm.', null::text, false),
         (11::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (12::smallint, '**Kasza gryczana.** Odmierz kaszę gryczaną.', null::text, false),
         (13::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (14::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (15::smallint, '**Przyprawy.** Odmierz tymianek, sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy, przygotowanie sosu i smażenie mięsa', 45 from przepisy p where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Kasza — równolegle.** Zagotuj wodę w garnku, wsyp kaszę gryczaną i gotuj zgodnie z instrukcją na opakowaniu. Nastaw minutnik; podczas gotowania przygotowuj sos. Woda do kaszy jest osobna i jej nadmiar zostanie odcedzony.', null::text, false),
         (2::smallint, '**Rozgrzanie tłuszczu.** Na patelni rozgrzej połowę oliwy przez **1 minutę**. Pozostałą część zachowaj do mięsa.', null::text, false),
         (3::smallint, '**Cebula, korzenie i por.** Dodaj cebulę, starte korzenie pietruszki i selera oraz por. Smaż przez **3 minuty** na umiarkowanym ogniu, mieszając.', null::text, false),
         (4::smallint, '**Grzyby.** Dodaj pieczarki i boczniaki. Smaż przez **7–9 minut**, aż większość wody odparuje, a brzegi grzybów lekko się zrumienią.', null::text, false),
         (5::smallint, '**Czosnek i tymianek.** Dodaj czosnek i tymianek. Smaż przez **30 sekund**, następnie wlej całą odmierzoną wodę i mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości z dna.', null::text, false),
         (6::smallint, '**Gotowanie warzywnej bazy.** Doprowadź do łagodnego wrzenia przez około **1–2 minuty**. Przykryj i duś przez **10–12 minut**. Sprawdź korzenie; jeśli są twarde, dogotowuj po **2 minuty**. Jeśli płynu brakuje, dolej niewielką ilość gorącej wody.', 'korzenie i por są miękkie, w sosie pozostaje płyn'::text, true),
         (7::smallint, '**Kasza — po minutniku.** Niezależnie od postępu przygotowania sosu sprawdź miękkość kaszy po czasie z opakowania. Odcedź nadmiar wody, przykryj i odstaw poza palnik.', null::text, false),
         (8::smallint, '**Odłożenie sosu.** Przełóż całą bazę warzywno-grzybową wraz z płynem do miski i przykryj. Na patelni nie pozostawiaj kawałków warzyw, które mogłyby przypalić się podczas smażenia mięsa.', null::text, false),
         (9::smallint, '**Rozgrzanie tłuszczu do mięsa.** Na opróżnionej patelni rozgrzej pozostałą część oliwy przez około **1 minutę**.', null::text, false),
         (10::smallint, '**Smażenie polędwiczki.** Smaż medaliony przez **2–3 minuty z każdej strony**. Sprawdź temperaturę w środku najgrubszego kawałka. Jeśli jest niższa niż **63°C**, dosmażaj po **1 minucie**, kontrolując temperaturę.', 'najgrubszy medalion ma w środku co najmniej 63°C'::text, true),
         (11::smallint, '**Odpoczynek mięsa.** Przełóż gotowe mięso na czysty talerz i pozostaw na co najmniej **3 minuty**. W tym czasie wykończ sos.', null::text, false),
         (12::smallint, '**Połączenie smaków.** Przełóż na patelnię najpierw płynną część sosu z miski. Mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości po mięsie. Dodaj wszystkie warzywa i grzyby oraz soki z talerza po mięsie. Podgrzewaj przez **1–2 minuty**. Jeśli sos jest za gęsty, dolej trochę gorącej wody.', null::text, false),
         (13::smallint, '**Jogurt.** Zdejmij patelnię z ognia. Jogurt ogrzej stopniowo małymi porcjami ciepłego sosu, następnie wmieszaj do patelni. Nie zagotowuj.', null::text, false),
         (14::smallint, '**Doprawienie.** Dodaj pieprz i stopniowo sól. Spróbuj sosu, uwzględniając słoną kapustę kiszoną podawaną obok.', null::text, false),
         (15::smallint, '**Podanie.** Po co najmniej 3 minutach odpoczynku przełóż mięso do ciepłego sosu. Podaj z kaszą gryczaną i kapustą kiszoną.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Potrawka z kurczaka, kaszy jęczmiennej i warzyw
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Jednogarnkowa potrawka z kurczaka, kaszy jęczmiennej, marchewki, pora i groszku. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 703, 1, 2,
  14, 52,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Potrawkę można zamrozić. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeśli kasza jest twarda, a płynu brakuje, dolej niewielką ilość gorącej wody i gotuj dalej. Za rzadką potrawkę odparuj bez pokrywki przez 2–3 minuty, mieszając i kontrolując konsystencję.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Udo z kurczaka bez skóry, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'opłukana; wybierz kaszę o czasie gotowania około 20–30 minut i kieruj się instrukcją opakowania', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Kasza jęczmienna, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Groszek zielony mrożony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Seler naciowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Pietruszka korzeń';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 14 from przepisy p where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Kasza jęczmienna.** Odmierz kaszę i opłucz na sitku. Sprawdź czas gotowania na opakowaniu; podany czas etapu zakłada odmianę gotującą się około 20–30 minut.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 1 cm.', null::text, false),
         (4::smallint, '**Por.** Przekrój por wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w plasterki.', null::text, false),
         (5::smallint, '**Seler naciowy.** Umyj seler naciowy i pokrój w cienkie plasterki.', null::text, false),
         (6::smallint, '**Kurczak.** Osusz mięso z uda bez skóry i kości. Pokrój w kostkę około 2 cm; podana masa dotyczy mięsa bez kości.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (9::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól, pieprz i tymianek.', null::text, false),
         (11::smallint, '**Groszek.** Odmierz mrożony groszek i pozostaw w zamrażarce do gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie potrawki', 52 from przepisy p where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oleju.** Rozgrzej olej przez **1 minutę**.', null::text, false),
         (2::smallint, '**Smażenie kurczaka.** Smaż kurczaka **5 minut**, obracając.', null::text, false),
         (3::smallint, '**Warzywa.** Dodaj por, marchew, seler naciowy oraz drobno posiekany korzeń pietruszki. Smaż przez **4 minuty**, mieszając, aż por zmięknie.', null::text, false),
         (4::smallint, '**Wywar z mięsa i warzyw.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Dodaj tymianek. Doprowadź do łagodnego wrzenia przez około **3 minuty**, przykryj i gotuj przez **5 minut**.', null::text, false),
         (5::smallint, '**Kasza.** Wsyp kaszę, wymieszaj i gotuj na małym ogniu pod przykryciem przez czas podany na opakowaniu, orientacyjnie **20–30 minut**. Mieszaj co kilka minut. Jeśli ziarna są twarde, a płynu brakuje, dolewaj niewielkie ilości gorącej wody. Kolejny krok wykonaj na ostatnie **5 minut** gotowania.', null::text, false),
         (6::smallint, '**Groszek.** Gdy kasza jest prawie miękka, dodaj groszek i gotuj przez **5 minut**. Sprawdź miękkość kaszy i temperaturę najgrubszego kawałka kurczaka. Jeśli kasza jest twarda lub mięso nie osiągnęło **74°C**, dogotowuj po **2 minuty**, kontrolując płyn.', 'kasza jest miękka, kurczak ma co najmniej 74°C, potrawka jest wilgotna'::text, true),
         (7::smallint, '**Doprawienie i podanie.** Dopraw solą i pieprzem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Ryż z pieczarkami, szpinakiem i parmezanem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Ryż z pieczarkami, szpinakiem i parmezanem', 'Ryż parboiled z pieczarkami, szpinakiem i parmezanem przygotowany w jednym garnku. Ziarna pozostają wyraźnie oddzielne; ser nadaje sosowi kremowość. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, por, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 734, 1, 1,
  14, 45,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
  false, 'Twardy ryż z małą ilością płynu podlej niewielką ilością gorącej wody i dogotuj pod przykryciem. Jeśli ryż jest miękki, ale płynu pozostało zbyt dużo, odparuj go bez pokrywki przed dodaniem szpinaku i parmezanu.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Ryż parboiled, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojone w plasterki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25,
       'drobno starty', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Parmezan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'ml'::jednostka_miary, 250,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25,
       'biała i jasnozielona część, dokładnie wypłukana; cienkie półplasterki do bazy sosu', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 14 from przepisy p where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Korzeń pietruszki.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń selera.** Umyj, obierz i zetrzyj na tarce o drobnych oczkach. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Por.** Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki.', null::text, false),
         (4::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (7::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (8::smallint, '**Parmezan.** Odmierz parmezan i drobno zetrzyj.', null::text, false),
         (9::smallint, '**Ryż.** Odmierz ryż i sprawdź na opakowaniu czas gotowania metodą wchłaniania wody.', null::text, false),
         (10::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu z warzywami', 45 from przepisy p where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula, por i korzenie.** Dodaj cebulę, por oraz starte korzenie pietruszki i selera. Smaż przez **3 minuty**, mieszając.', null::text, false),
         (3::smallint, '**Pieczarki.** Dodaj pieczarki i smaż przez **7–9 minut**, aż płyn odparuje, a grzyby lekko się zrumienią.', null::text, false),
         (4::smallint, '**Czosnek.** Dodaj czosnek i smaż **30 sekund**.', null::text, false),
         (5::smallint, '**Warzywno-grzybowa baza.** Wlej odmierzoną wodę i mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości z dna. Doprowadź do łagodnego wrzenia przez około **2 minuty**, przykryj i gotuj przez **5 minut**.', null::text, false),
         (6::smallint, '**Dodanie ryżu.** Wsyp ryż do gotującej się bazy i wymieszaj. Wszystkie warzywa i grzyby pozostają w garnku.', null::text, false),
         (7::smallint, '**Gotowanie ryżu.** Gotuj na małym ogniu pod przykryciem przez czas wskazany na opakowaniu, orientacyjnie **15–20 minut**, mieszając co kilka minut. Jeśli ryż jest twardy, a płynu brakuje, dolej trochę gorącej wody. Jeśli po czasie z opakowania pozostaje twardy, dogotowuj po **2 minuty**.', null::text, false),
         (8::smallint, '**Szpinak.** Na ostatnie **1–2 minuty** dodaj szpinak.', null::text, false),
         (9::smallint, '**Parmezan i doprawienie.** Gdy zwiędnie, zdejmij z ognia i wmieszaj parmezan. Dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Wieprzowina w sosie chrzanowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wieprzowina w sosie chrzanowym', 'Wieprzowina duszona z marchewką, korzeniem pietruszki, selerem i porem. Wszystkie warzywa są blendowane z płynem z duszenia, tworząc bazę sosu wykończonego chrzanem, jogurtem greckim i koperkiem. Podawana z puree ziemniaczanym i fasolką szparagową.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
  3, 'prywatna',
  'waga', 816, 1, 1,
  20, 70,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Patelnia 24 cm', 'Tłuczek do ziemniaków', 'Nóż szefa kuchni', 'Deska do krojenia', 'Garnek 2 l', 'Rondel', 'Blender ręczny', 'Miska', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Mięso z sosem przechowuj w szczelnym pojemniku w lodówce do 3 dni. Puree i fasolkę najlepiej przechowywać osobno. Podgrzewaj sos na małym ogniu, bez doprowadzania do intensywnego wrzenia, żeby jogurt się nie zwarzył.',
  false, 'Zbyt gęsty sos po zblendowaniu warzyw rozcieńcz niewielką ilością gorącej wody przed dodaniem jogurtu. Jogurt dodawaj stopniowo poza ogniem, po zahartowaniu. Jeśli chrzan jest mało wyczuwalny, końcową odmierzoną część dodaj po zdjęciu sosu z ognia.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wieprzowina w sosie chrzanowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wieprzowina w sosie chrzanowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Szynka wieprzowa chuda, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'obrane', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'ml'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Chrzan tarty';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'ml'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Fasolka szparagowa mrożona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'biała i jasnozielona część, dokładnie wypłukana; cienkie półplasterki do bazy sosu', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj, obierz i pokrój w drobną kostkę około 3–4 mm. Odłóż do przygotowania warzywnej bazy.', null::text, false),
         (4::smallint, '**Por.** Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki.', null::text, false),
         (5::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki. Pokrój na kawałki podobnej wielkości.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (7::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (8::smallint, '**Koperek.** Umyj i osusz koperek, usuń grube łodygi i drobno posiekaj delikatne gałązki.', null::text, false),
         (9::smallint, '**Jogurt.** Odmierz jogurt i wyjmij z lodówki na czas przygotowania dania.', null::text, false),
         (10::smallint, '**Chrzan.** Odmierz chrzan i podziel na połowę: do gotowania i do wykończenia sosu.', null::text, false),
         (11::smallint, '**Wieprzowina.** Osusz mięso, pokrój na plastry grubości około 2 cm i lekko rozbij. Dopraw częścią soli i pieprzu.', null::text, false),
         (12::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (13::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false),
         (14::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (15::smallint, '**Fasolka szparagowa.** Odmierz mrożoną fasolkę i pozostaw w zamrażarce do gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie mięsa, dodatków i sosu', 70 from przepisy p where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Na patelni rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (2::smallint, '**Obsmażenie mięsa.** Obsmaż mięso krótko, około **1–2 minuty** z każdej strony, tylko do lekkiego zrumienienia.', null::text, false),
         (3::smallint, '**Zdjęcie mięsa.** Zdejmij z patelni.', null::text, false),
         (4::smallint, '**Soki ze smażenia.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Zachowaj cały płyn do duszenia mięsa.', null::text, false),
         (5::smallint, '**Rozgrzanie oliwy w rondlu.** W niewielkim rondlu z pokrywą rozgrzej pozostałą oliwę przez **1 minutę**.', null::text, false),
         (6::smallint, '**Warzywna baza sosu.** Dodaj drobno pokrojoną marchew, korzenie pietruszki i selera oraz por. Smaż na małym ogniu przez **4–5 minut**, mieszając. Warzywa mają zmięknąć z wierzchu, bez mocnego rumienienia.', null::text, false),
         (7::smallint, '**Czosnek.** Dodaj czosnek i smaż około **20–30 sekund**, nie dopuszczając do jego zrumienienia.', null::text, false),
         (8::smallint, '**Sos i mięso.** Do rondla z warzywami i czosnkiem wlej cały płyn z patelni. Dodaj mięso wraz z sokami z talerza i pierwszą część chrzanu. Doprowadź do łagodnego wrzenia przez około **2 minuty**.', null::text, false),
         (9::smallint, '**Duszenie wieprzowiny.** Duś pod przykryciem na bardzo małym ogniu przez **35–45 minut**. Sprawdź sos co **10–15 minut**; dolej trochę gorącej wody tylko wtedy, gdy nadmiernie gęstnieje lub przywiera. Jeśli mięso jest nadal twarde, duś dalej po **10 minut**.', null::text, false),
         (10::smallint, '**Ziemniaki — równolegle.** W czasie duszenia mięsa ugotuj ziemniaki w lekko osolonej wodzie do miękkości, około **15–20 minut**. Odcedź i utłucz na puree.', null::text, false),
         (11::smallint, '**Gotowanie fasolki.** Po odcedzeniu ziemniaków ugotuj fasolkę w zwolnionym garnku przez około **6–8 minut**, tak aby pozostała lekko jędrna. Odcedź.', null::text, false),
         (12::smallint, '**Wyjęcie mięsa.** Gdy mięso będzie miękkie, przełóż je na czysty talerz i przykryj. Sprawdź korzenie w sosie. Jeśli są jeszcze twarde, dogotowuj je bez mięsa po **3 minuty**, w razie potrzeby dolewając trochę gorącej wody.', 'korzenie łatwo rozgniatają się widelcem przed blendowaniem'::text, true),
         (13::smallint, '**Blendowanie warzyw.** Zdejmij rondel z ognia i zblenduj wszystkie warzywa z całym płynem na gładki sos. Trzymaj końcówkę blendera zanurzoną; przy małej ilości przelej sos do wąskiego naczynia do blendowania i po zblendowaniu przelej z powrotem do rondla.', null::text, false),
         (14::smallint, '**Konsystencja.** Sos powinien swobodnie spływać z łyżki. Jeśli jest zbyt gęsty, dodawaj po trochu gorącą wodę i mieszaj. Nie odcedzaj warzyw.', null::text, false),
         (15::smallint, '**Hartowanie jogurtu.** Do jogurtu stopniowo dodawaj trochę ciepłego sosu, mieszając do ogrzania i uzyskania jednolitej konsystencji. Wmieszaj zahartowany jogurt do rondla poza ogniem.', null::text, false),
         (16::smallint, '**Chrzan i koperek.** Dodaj pozostałą część chrzanu oraz koperek. Wymieszaj i spróbuj. Po dodaniu jogurtu i końcowej porcji chrzanu nie gotuj już sosu.', null::text, false),
         (17::smallint, '**Podanie.** Włóż mięso wraz z sokami z talerza do ciepłego sosu, wymieszaj delikatnie i podaj z puree oraz fasolką szparagową. Posyp natką pietruszki. Po dodaniu jogurtu nie zagotowuj sosu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Gulasz jagnięcy z ciecierzycą i pomidorami', 15, 2, 26),
  ('Gulasz z białej fasoli, jarmużu i pomidorów', 15, 2, 20),
  ('Kurczak z ryżem, marchewką i jogurtem greckim', 14, 3, 28),
  ('Małże w pomidorowym bulionie', 13, 2, 20),
  ('Polędwiczka w sosie musztardowym z kaszą bulgur', 14, 2, 27),
  ('Polędwiczka z pieczarkami i boczniakami', 16, 2, 30),
  ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 12, 2, 18),
  ('Ryż z pieczarkami, szpinakiem i parmezanem', 13, 2, 21),
  ('Wieprzowina w sosie chrzanowym', 16, 2, 32)
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
where lower(p.nazwa) in (lower('Gulasz jagnięcy z ciecierzycą i pomidorami'), lower('Gulasz z białej fasoli, jarmużu i pomidorów'), lower('Kurczak z ryżem, marchewką i jogurtem greckim'), lower('Małże w pomidorowym bulionie'), lower('Polędwiczka w sosie musztardowym z kaszą bulgur'), lower('Polędwiczka z pieczarkami i boczniakami'), lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'), lower('Ryż z pieczarkami, szpinakiem i parmezanem'), lower('Wieprzowina w sosie chrzanowym'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
