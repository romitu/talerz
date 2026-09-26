-- =============================================================================
--  TALERZ — rodzaje dań dla przepisów, które już są w bazie
-- =============================================================================
--  Wymaga migracji 0046. Przypisanie po nazwie przepisu (nazwy są
--  niepowtarzalne od migracji 0018).
--
--  Nadpisuje tylko PUSTE rodzaje — jeśli ktoś już poprawił rodzaj w formularzu,
--  zostaje jego wersja.
--
--  Świadomie bez rodzaju (żaden z dziewięciu do nich nie pasuje, decyzja
--  należy do moderatora): mięso albo ryba z ziemniakami lub z patelni —
--  pierś z kaczki, stek z tuńczyka, polędwiczka z pieczarkami, wieprzowina
--  w sosie chrzanowym, klopsiki tradycyjne, kotleciki z soczewicy, pierś
--  z kurczaka z grilla, małże, tofucznica, serek wiejski z warzywami.
--
--  Zwykłe instrukcje, bez PL/pgSQL. Można uruchomić ponownie.
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

update przepisy p
   set rodzaje = r.rodzaje::rodzaj_dania[]
  from (values
    ('Barszcz ukraiński z fasolą',                          '{zupa}'),
    ('POD CIŚNIENIEM - Barszcz ukraiński z fasolą',         '{zupa}'),
    ('Grochówka z indykiem',                                '{zupa}'),
    ('Krem z brokułów z fetą',                              '{zupa}'),
    ('Krem z dyni na mleku kokosowym',                      '{zupa}'),
    ('Krem z kalafiora z pieczoną ciecierzycą',             '{zupa}'),
    ('Krupnik z kurczakiem, chili, papryką i cytryną',      '{zupa}'),
    ('Tom kha gai — kokosowa zupa z kurczakiem',            '{zupa}'),
    ('Zupa - Tajskie żółte curry z kurczakiem',             '{zupa}'),
    ('Zupa ogórkowa',                                       '{zupa}'),
    ('Zupa pomidorowa z ryżem',                             '{zupa}'),
    ('Zupa z białej fasoli i jarmużu',                      '{zupa}'),
    ('Zupa z czerwonej soczewicy i pomidorów',              '{zupa}'),

    ('Sałatka brokułowa z jajkiem i sosem jogurtowym',      '{salatka}'),
    ('Sałatka grecka z grillowanym kurczakiem',             '{salatka}'),
    ('Sałatka makaronowa z mozzarellą i warzywami',         '{salatka}'),
    ('Sałatka makaronowa z tuńczykiem i warzywami',         '{salatka}'),
    ('Sałatka z ciecierzycy',                               '{salatka}'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora',      '{salatka}'),
    ('Sałatka z jajkiem, fetą i warzywami',                 '{salatka}'),
    ('Sałatka z jarmużu, jabłka i orzechów',                '{salatka}'),
    ('Sałatka z komosy, buraka i koziego sera',             '{salatka}'),
    ('Sałatka z pieczonym burakiem i fetą',                 '{salatka}'),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem',         '{salatka}'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy',              '{salatka}'),

    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', '{makaron}'),
    ('Makaron z brokułem i fetą',                           '{makaron}'),
    ('Makaron z ciecierzycą, bazylią i orzechami',          '{makaron}'),
    ('Makaron z indykiem, pieczarkami i jogurtem',          '{makaron}'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami',       '{makaron}'),
    ('Makaron z pieczonymi warzywami i mozzarellą',         '{makaron}'),
    ('Makaron z polędwiczką i pieczarkami',                 '{makaron}'),
    ('Makaron z ricottą i szpinakiem',                      '{makaron}'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki',    '{makaron}'),
    ('Makaron z wołowiną i sosem pomidorowym',              '{makaron}'),

    ('Indyk w sosie orzechowym (satay)',                    '{kasza_ryz}'),
    ('Kałamarnica z papryką i ryżem',                       '{kasza_ryz}'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem',    '{kasza_ryz}'),
    ('Krewetki z czosnkiem, cukinią i ryżem',               '{kasza_ryz}'),
    ('Kurczak z ryżem, marchewką i jogurtem greckim',       '{kasza_ryz}'),
    ('Łosoś ze szpinakiem i kaszą bulgur',                  '{kasza_ryz}'),
    ('Morszczuk w sosie pomidorowym z ryżem',               '{kasza_ryz}'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur',     '{kasza_ryz}'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem',          '{kasza_ryz}'),
    ('Smażony ryż z kurczakiem i jajkiem',                  '{kasza_ryz}'),
    ('Tofu z brokułem i ryżem',                             '{kasza_ryz}'),
    ('Wieprzowina w sosie sojowo-imbirowym',                '{kasza_ryz}'),
    ('Wieprzowina z kapustą pekińską i ryżem',              '{kasza_ryz}'),
    ('Wołowina z brokułami po chińsku',                     '{kasza_ryz}'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami',  '{kasza_ryz,z_piekarnika}'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw',     '{gulasz_curry,kasza_ryz}'),
    ('Gulasz z kaszą gryczaną',                             '{gulasz_curry,kasza_ryz}'),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną',            '{gulasz_curry,kasza_ryz}'),
    ('Dorsz w kokosowym curry ze szpinakiem',               '{gulasz_curry,kasza_ryz}'),

    ('Chili sin carne z czarną fasolą',                     '{gulasz_curry}'),
    ('Curry z ciecierzycy, pomidorów i szpinaku',           '{gulasz_curry}'),
    ('Curry z czerwonej soczewicy i szpinaku',              '{gulasz_curry}'),
    ('Fasolka po bretońsku z indykiem',                     '{gulasz_curry}'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami',          '{gulasz_curry}'),
    ('Gulasz wołowy z warzywami korzeniowymi',              '{gulasz_curry}'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów',         '{gulasz_curry}'),
    ('Kurczak po tajsku',                                   '{gulasz_curry}'),

    ('Dorsz po grecku',                                     '{z_piekarnika}'),
    ('Królik z rozmarynem i warzywami korzeniowymi',        '{z_piekarnika}'),
    ('Kurczak pieczony z batatem i brokułem',               '{z_piekarnika}'),
    ('Papryka faszerowana soczewicą i kaszą bulgur',        '{z_piekarnika}'),
    ('Pieczona makrela z burakami i ziemniakami',           '{z_piekarnika}'),
    ('Pieczone warzywa korzeniowe z tymiankiem',            '{z_piekarnika}'),
    ('Pieczony bakłażan z ciecierzycą i fetą',              '{z_piekarnika}'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym',       '{z_piekarnika}'),
    ('Pieczony łosoś z brokułem i ziemniakami',             '{z_piekarnika}'),
    ('Pieczony schab z warzywami korzeniowymi',             '{z_piekarnika}'),
    ('Pstrąg pieczony z warzywami korzeniowymi',            '{z_piekarnika}'),

    ('Grillowany indyk z halloumi',                         '{kanapki}'),
    ('Grillowany kurczak caprese',                          '{kanapki}'),
    ('Grillowany kurczak z ogórkiem kiszonym',              '{kanapki}'),
    ('Kanapka z twarogiem, ogórkiem kiszonym i warzywami',  '{kanapki}'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem',            '{kanapki}'),
    ('Kanapki z Goudą, pomidorem i sałatą',                 '{kanapki}'),
    ('Kanapki z halloumi, awokado i pomidorem',             '{kanapki}'),
    ('Kanapki z jajkiem, awokado i pomidorem',              '{kanapki}'),
    ('Kanapki z mozzarellą, pomidorem i bazylią',           '{kanapki}'),
    ('Kanapki z pastą jajeczną',                            '{kanapki}'),
    ('Kanapki z pastą z tuńczyka',                          '{kanapki}'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem',       '{kanapki}'),
    ('Kanapki z sardynkami, pomidorem i rukolą',            '{kanapki}'),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', '{kanapki}'),
    ('Tortilla z Goudą, szpinakiem i pomidorem',            '{kanapki}'),
    ('Tortilla z hummusem i warzywami',                     '{kanapki}'),
    ('Tortilla z jajkiem i szpinakiem',                     '{kanapki}'),
    ('Tortilla z kurczakiem, awokado i warzywami',          '{kanapki}'),
    ('Tortilla z tofu i chrupiącymi warzywami',             '{kanapki}'),
    ('Tosty z Goudą i pieczarkami',                         '{kanapki}'),
    ('Tosty z jajkiem sadzonym',                            '{kanapki}'),
    ('Tosty z mozzarellą i pomidorem',                      '{kanapki}'),
    ('Tosty z serem salami i papryką',                      '{kanapki}'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem',   '{kanapki}'),
    ('Pasta jajeczna z awokado',                            '{jajka,kanapki}'),

    ('Jajecznica z pomidorem i szczypiorkiem',              '{jajka}'),
    ('Jajecznica ze szpinakiem',                            '{jajka}'),
    ('Jajka na miękko z pieczywem i warzywami',             '{jajka}'),
    ('Jajka w koszulkach z pastą twarogową',                '{jajka}'),
    ('Omlet z pieczarkami',                                 '{jajka}'),
    ('Omlet ze szpinakiem i fetą',                          '{jajka}'),
    ('Szakszuka z mozzarellą',                              '{jajka}'),

    ('Jaglanka z gruszką i orzechami',                      '{na_slodko}'),
    ('Nocna owsianka z bananem i chia',                     '{na_slodko}'),
    ('Nocna owsianka z borówkami i orzechami',              '{na_slodko}'),
    ('Owsianka',                                            '{na_slodko}'),
    ('Owsianka z jabłkiem, cynamonem i orzechami',          '{na_slodko}'),
    ('Pełnoziarniste placuszki ze skyrem i owocami',        '{na_slodko}'),
    ('Placuszki bananowo-owsiane',                          '{na_slodko}'),
    ('Pudding chia z mango i mlekiem kokosowym',            '{na_slodko}'),
    ('Serek wiejski z owocami i orzechami',                 '{na_slodko}'),
    ('Skyr kakaowy z bananem i masłem orzechowym',          '{na_slodko}'),
    ('Skyr z owocami, płatkami owsianymi i orzechami',      '{na_slodko}')
  ) as r(nazwa, rodzaje)
 where p.nazwa = r.nazwa
   and p.rodzaje = '{}';

-- Co zostało bez rodzaju — ta lista ma się zgadzać z nagłówkiem pliku.
select nazwa as bez_rodzaju
  from przepisy
 where rodzaje = '{}'
 order by nazwa;
