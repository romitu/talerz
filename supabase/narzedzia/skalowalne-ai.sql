-- =============================================================================
--  TALERZ — zgoda na skalowanie kaloryczne dań z plików AI
-- =============================================================================
--  Ustawia przepisy.skalowalny = true dla 76 jednoporcjowych dań z plików
--  narzedzia/przepisy-ai/*.json (liczba_porcji_bazowych = 1). Automat może
--  wtedy dopasować wielkość dania do dziennego celu kalorii (migracja 0036).
--
--  Czego tu NIE ma
--  ---------------
--  13 dań na 2 porcje (zupy, gulasze, curry). Skalować się dadzą, ale gotujesz
--  je na zapas — przeliczanie garnka pod cel jednego dnia niewiele daje.
--  Dopisz je ręcznie w „Makro przepisów”, jeśli zmienisz zdanie.
--
--  Jak wybrać
--  ----------
--  Lista jest pogrupowana po rodzaju dania. Linię, której nie chcesz, usuń
--  albo zakomentuj (`--` na początku). Ostatnia pozycja listy nie może mieć
--  przecinka na końcu.
--
--  „w sztukach” = składnik podany w sztukach. Jeśli w katalogu ma „można
--  dzielić: nie” (jajka, kromki), skalowanie zaokrągla go do całości — danie
--  trafia w cel mniej dokładnie, bo 2 jajka mogą wyjść 2 albo 3.
--
--  Zmienia tylko dania, które mają jeszcze „nie”. Można uruchomić kilka razy.
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

with skalowalne (nazwa) as (
  values
    -- Kanapki (18)
    ('Kanapki z Goudą, jajkiem i szczypiorkiem'),                -- w sztukach: Chleb żytni razowy, Jaja kurze, całe, surowe
    ('Kanapki z Goudą, pomidorem i sałatą'),                     -- w sztukach: Chleb żytni razowy
    ('Kanapki z halloumi, awokado i pomidorem'),                 -- w sztukach: Chleb żytni razowy, Awokado, Pomidory, surowe
    ('Kanapki z jajkiem, awokado i pomidorem'),                  -- w sztukach: Chleb żytni razowy, Jaja kurze, całe, surowe, Awokado, Pomidory, surowe
    ('Kanapki z mozzarellą, pomidorem i bazylią'),               -- w sztukach: Chleb żytni razowy, Pomidory, surowe
    ('Kanapki z pastą jajeczną'),                                -- w sztukach: Jaja kurze, całe, surowe, Chleb żytni razowy
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem'),           -- w sztukach: Chleb żytni razowy, Rzodkiewka, surowa
    ('Kanapki z sardynkami, pomidorem i rukolą'),                -- w sztukach: Chleb żytni razowy
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą'),   -- w sztukach: Chleb żytni razowy
    ('Tortilla z Goudą, szpinakiem i pomidorem'),
    ('Tortilla z hummusem i warzywami'),
    ('Tortilla z jajkiem i szpinakiem'),                         -- w sztukach: Jaja kurze, całe, surowe
    ('Tortilla z kurczakiem, awokado i warzywami'),              -- w sztukach: Awokado
    ('Tortilla z tofu i chrupiącymi warzywami'),
    ('Tosty z Goudą i pieczarkami'),                             -- w sztukach: Chleb żytni razowy
    ('Tosty z mozzarellą i pomidorem'),                          -- w sztukach: Chleb żytni razowy, Pomidory, surowe
    ('Tosty z serem salami i papryką'),                          -- w sztukach: Chleb żytni razowy
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem'),       -- w sztukach: Rzodkiewka, surowa, Chleb żytni razowy

    -- Sałatki (10)
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym'),          -- w sztukach: Jaja kurze, całe, surowe
    ('Sałatka makaronowa z mozzarellą i warzywami'),
    ('Sałatka makaronowa z tuńczykiem i warzywami'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora'),          -- w sztukach: Awokado
    ('Sałatka z jajkiem, fetą i warzywami'),                     -- w sztukach: Jaja kurze, całe, surowe, Pomidory, surowe, Ogórek, surowy
    ('Sałatka z jarmużu, jabłka i orzechów'),                    -- w sztukach: Jabłko ze skórką, Pomarańcza
    ('Sałatka z komosy, buraka i koziego sera'),
    ('Sałatka z pieczonym burakiem i fetą'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni'),     -- w sztukach: Pomidory, surowe, Ogórek, surowy, Chleb żytni razowy
    ('Tabbouleh z kaszy bulgur i ciecierzycy'),

    -- Na słodko (10)
    ('Jaglanka z gruszką i orzechami'),                          -- w sztukach: Gruszka ze skórką
    ('Nocna owsianka z bananem i chia'),                         -- w sztukach: Banan
    ('Nocna owsianka z borówkami i orzechami'),
    ('Owsianka z jabłkiem, cynamonem i orzechami'),              -- w sztukach: Jabłko ze skórką
    ('Pełnoziarniste placuszki ze skyrem i owocami'),            -- w sztukach: Jaja kurze, całe, surowe
    ('Placuszki bananowo-owsiane'),                              -- w sztukach: Banan, Jaja kurze, całe, surowe
    ('Pudding chia z mango i mlekiem kokosowym'),
    ('Serek wiejski z owocami i orzechami'),                     -- w sztukach: Banan
    ('Skyr kakaowy z bananem i masłem orzechowym'),              -- w sztukach: Banan
    ('Skyr z owocami, płatkami owsianymi i orzechami'),          -- w sztukach: Banan

    -- Jajka (3)
    ('Jajecznica z pomidorem i szczypiorkiem'),                  -- w sztukach: Jaja kurze, całe, surowe, Pomidory, surowe, Chleb żytni razowy
    ('Jajka na miękko z pieczywem i warzywami'),                 -- w sztukach: Jaja kurze, całe, surowe, Chleb żytni razowy, Pomidory, surowe, Ogórek, surowy
    ('Omlet ze szpinakiem i fetą'),                              -- w sztukach: Jaja kurze, całe, surowe, Chleb żytni razowy

    -- Makarony (10)
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy'),
    ('Makaron z brokułem i fetą'),
    ('Makaron z ciecierzycą, bazylią i orzechami'),
    ('Makaron z indykiem, pieczarkami i jogurtem'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami'),
    ('Makaron z pieczonymi warzywami i mozzarellą'),
    ('Makaron z polędwiczką i pieczarkami'),
    ('Makaron z ricottą i szpinakiem'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki'),
    ('Makaron z wołowiną i sosem pomidorowym'),

    -- Kasza, ryż (10)
    ('Kałamarnica z papryką i ryżem'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem'),        -- w sztukach: Jaja kurze, całe, surowe
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami'),
    ('Krewetki z czosnkiem, cukinią i ryżem'),
    ('Łosoś ze szpinakiem i kaszą bulgur'),
    ('Morszczuk w sosie pomidorowym z ryżem'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem'),
    ('Tofu z brokułem i ryżem'),
    ('Wieprzowina z kapustą pekińską i ryżem'),

    -- Z piekarnika (9)
    ('Królik z rozmarynem i warzywami korzeniowymi'),
    ('Kurczak pieczony z batatem i brokułem'),
    ('Papryka faszerowana soczewicą i kaszą bulgur'),            -- w sztukach: Papryka czerwona, surowa
    ('Pieczona makrela z burakami i ziemniakami'),
    ('Pieczone warzywa korzeniowe z tymiankiem'),
    ('Pieczony bakłażan z ciecierzycą i fetą'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym'),
    ('Pieczony łosoś z brokułem i ziemniakami'),
    ('Pstrąg pieczony z warzywami korzeniowymi'),

    -- Gulasz, curry (1)
    ('Dorsz w kokosowym curry ze szpinakiem'),

    -- Bez rodzaju (5)
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym'),
    ('Małże w pomidorowym bulionie'),                            -- w sztukach: Chleb żytni razowy
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą'),          -- w sztukach: Pomarańcza, Jabłko ze skórką
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami'),
    ('Tofucznica ze szpinakiem i pomidorem')                    -- w sztukach: Chleb żytni razowy
)
update przepisy p
set skalowalny = true
from skalowalne s
where lower(p.nazwa) = lower(s.nazwa)
  and not p.skalowalny;

-- --- Sprawdzenie -------------------------------------------------------------
--  Ile przepisów jest skalowalnych, a ile nie.
select skalowalny, count(*)
from przepisy
group by skalowalny
order by skalowalny;
