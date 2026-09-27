-- =============================================================================
--  TALERZ — liczba porcji bazowych dla przepisów z plików AI
-- =============================================================================
--  Problem
--  -------
--  Generator importu (narzedzia/generuj-import-ai.mjs) nie przenosił pola
--  `liczba_porcji_bazowych` do SQL, więc każdy przepis z plików AI dostał
--  domyślne 0. Przy porcjowaniu wagowym formularz przepisu wymaga liczby
--  porcji bazowych większej od zera — bez niej „Zapisz” jest nieaktywny.
--
--  Kiedy to uruchamiać
--  -------------------
--  Tylko jeśli NIE uruchamiasz ponownie import-przepisow-ai.sql — nowy import
--  sam wpisuje liczbę porcji. Ten skrypt uzupełnia ją w przepisach już
--  zaimportowanych, bez ruszania składników.
--
--  Zabezpieczenie
--  --------------
--  Liczby pochodzą z plików narzedzia/przepisy-ai/*.json (76 × 1, 13 × 2).
--  Część dań przeskalowano w plikach na 2 porcje (podwojone ilości). Jeśli
--  w bazie są jeszcze ilości na 1 porcję, wpisanie 2 zmniejszyłoby porcję
--  o połowę. Dlatego skrypt wpisuje liczbę tylko tam, gdzie zgadza się
--  z bazą: masa składników / porcja_g ≈ liczba porcji. Pozostałe pokaże
--  sprawdzenie na końcu — te trzeba zaimportować ponownie.
--
--  Uzupełnia TYLKO przepisy, które nadal mają 0: liczba ustawiona ręcznie
--  w formularzu zostaje nietknięta. Można uruchomić kilka razy.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

drop table if exists porcje_z_plikow;
create temp table porcje_z_plikow (nazwa text, liczba smallint);

insert into porcje_z_plikow (nazwa, liczba) values
    ('Chili sin carne z czarną fasolą',                       2),
    ('Curry z ciecierzycy, pomidorów i szpinaku',             2),
    ('Curry z czerwonej soczewicy i szpinaku',                2),
    ('Dorsz w kokosowym curry ze szpinakiem',                 1),
    ('Grochówka z indykiem',                                  2),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami',            2),
    ('Gulasz wołowy z warzywami korzeniowymi',                2),
    ('Gulasz z białej fasoli, jarmużu i pomidorów',           2),
    ('Jaglanka z gruszką i orzechami',                        1),
    ('Jajecznica z pomidorem i szczypiorkiem',                1),
    ('Jajka na miękko z pieczywem i warzywami',               1),
    ('Kałamarnica z papryką i ryżem',                         1),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem',              1),
    ('Kanapki z Goudą, pomidorem i sałatą',                   1),
    ('Kanapki z halloumi, awokado i pomidorem',               1),
    ('Kanapki z jajkiem, awokado i pomidorem',                1),
    ('Kanapki z mozzarellą, pomidorem i bazylią',             1),
    ('Kanapki z pastą jajeczną',                              1),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem',         1),
    ('Kanapki z sardynkami, pomidorem i rukolą',              1),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 1),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem',      1),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami',    1),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym',    1),
    ('Krem z brokułów z fetą',                                2),
    ('Krem z dyni na mleku kokosowym',                        2),
    ('Krem z kalafiora z pieczoną ciecierzycą',               2),
    ('Krewetki z czosnkiem, cukinią i ryżem',                 1),
    ('Królik z rozmarynem i warzywami korzeniowymi',          1),
    ('Kurczak pieczony z batatem i brokułem',                 1),
    ('Łosoś ze szpinakiem i kaszą bulgur',                    1),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy',  1),
    ('Makaron z brokułem i fetą',                             1),
    ('Makaron z ciecierzycą, bazylią i orzechami',            1),
    ('Makaron z indykiem, pieczarkami i jogurtem',            1),
    ('Makaron z kurczakiem, szpinakiem i pomidorami',         1),
    ('Makaron z pieczonymi warzywami i mozzarellą',           1),
    ('Makaron z polędwiczką i pieczarkami',                   1),
    ('Makaron z ricottą i szpinakiem',                        1),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki',      1),
    ('Makaron z wołowiną i sosem pomidorowym',                1),
    ('Małże w pomidorowym bulionie',                          1),
    ('Morszczuk w sosie pomidorowym z ryżem',                 1),
    ('Nocna owsianka z bananem i chia',                       1),
    ('Nocna owsianka z borówkami i orzechami',                1),
    ('Omlet ze szpinakiem i fetą',                            1),
    ('Owsianka z jabłkiem, cynamonem i orzechami',            1),
    ('Papryka faszerowana soczewicą i kaszą bulgur',          1),
    ('Pełnoziarniste placuszki ze skyrem i owocami',          1),
    ('Pieczona makrela z burakami i ziemniakami',             1),
    ('Pieczone warzywa korzeniowe z tymiankiem',              1),
    ('Pieczony bakłażan z ciecierzycą i fetą',                1),
    ('Pieczony kalafior z ziołowym sosem jogurtowym',         1),
    ('Pieczony łosoś z brokułem i ziemniakami',               1),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą',        1),
    ('Placuszki bananowo-owsiane',                            1),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur',       1),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw',       2),
    ('Pstrąg pieczony z warzywami korzeniowymi',              1),
    ('Pudding chia z mango i mlekiem kokosowym',              1),
    ('Ryż z pieczarkami, szpinakiem i parmezanem',            1),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym',        1),
    ('Sałatka makaronowa z mozzarellą i warzywami',           1),
    ('Sałatka makaronowa z tuńczykiem i warzywami',           1),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora',        1),
    ('Sałatka z jajkiem, fetą i warzywami',                   1),
    ('Sałatka z jarmużu, jabłka i orzechów',                  1),
    ('Sałatka z komosy, buraka i koziego sera',               1),
    ('Sałatka z pieczonym burakiem i fetą',                   1),
    ('Serek wiejski z owocami i orzechami',                   1),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni',   1),
    ('Skyr kakaowy z bananem i masłem orzechowym',            1),
    ('Skyr z owocami, płatkami owsianymi i orzechami',        1),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami',    1),
    ('Tabbouleh z kaszy bulgur i ciecierzycy',                1),
    ('Tofu z brokułem i ryżem',                               1),
    ('Tofucznica ze szpinakiem i pomidorem',                  1),
    ('Tortilla z Goudą, szpinakiem i pomidorem',              1),
    ('Tortilla z hummusem i warzywami',                       1),
    ('Tortilla z jajkiem i szpinakiem',                       1),
    ('Tortilla z kurczakiem, awokado i warzywami',            1),
    ('Tortilla z tofu i chrupiącymi warzywami',               1),
    ('Tosty z Goudą i pieczarkami',                           1),
    ('Tosty z mozzarellą i pomidorem',                        1),
    ('Tosty z serem salami i papryką',                        1),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem',     1),
    ('Wieprzowina z kapustą pekińską i ryżem',                1),
    ('Zupa z białej fasoli i jarmużu',                        2),
    ('Zupa z czerwonej soczewicy i pomidorów',                2);

with masa as (
  select p.id, sum(ps.gramy) / nullif(p.porcja_g, 0) as porcji_w_bazie
  from przepisy p
  join przepis_skladniki ps on ps.przepis_id = p.id
  group by p.id, p.porcja_g
)
update przepisy p
set liczba_porcji_bazowych = z.liczba
from porcje_z_plikow z, masa m
where lower(p.nazwa) = lower(z.nazwa)
  and m.id = p.id
  and p.liczba_porcji_bazowych = 0
  and abs(m.porcji_w_bazie - z.liczba) < 0.25;

-- --- Sprawdzenie -------------------------------------------------------------
--  Przepisy z plików AI, które dalej mają 0. Pusto = wszystko uzupełnione.
--  „porcji_w_bazie” różne od „w_pliku” = w bazie są inne ilości niż w pliku;
--  takie danie zaimportuj ponownie (import-przepisow-ai.sql).
select
  p.nazwa,
  z.liczba                                           as w_pliku,
  round(sum(ps.gramy) / nullif(p.porcja_g, 0), 2)    as porcji_w_bazie
from przepisy p
join porcje_z_plikow z on lower(z.nazwa) = lower(p.nazwa)
left join przepis_skladniki ps on ps.przepis_id = p.id
where p.liczba_porcji_bazowych = 0
group by p.nazwa, z.liczba, p.porcja_g
order by p.nazwa;
