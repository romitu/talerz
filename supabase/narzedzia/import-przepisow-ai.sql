-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 89
--  Wygenerowano: 2026-09-26
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
    ('Chili sin carne z czarną fasolą', 'Fasola czarna z puszki, odsączona', false),
    ('Chili sin carne z czarną fasolą', 'Fasola czerwona z puszki, odsączona', false),
    ('Chili sin carne z czarną fasolą', 'Kukurydza konserwowa, odsączona', false),
    ('Chili sin carne z czarną fasolą', 'Pomidory krojone z puszki', false),
    ('Chili sin carne z czarną fasolą', 'Passata pomidorowa', false),
    ('Chili sin carne z czarną fasolą', 'Papryka czerwona, surowa', false),
    ('Chili sin carne z czarną fasolą', 'Cebula, surowa', false),
    ('Chili sin carne z czarną fasolą', 'Czosnek, surowy', false),
    ('Chili sin carne z czarną fasolą', 'Olej rzepakowy', false),
    ('Chili sin carne z czarną fasolą', 'Kmin rzymski mielony', false),
    ('Chili sin carne z czarną fasolą', 'Papryka wędzona mielona', false),
    ('Chili sin carne z czarną fasolą', 'Chili suszone', false),
    ('Chili sin carne z czarną fasolą', 'Sól kuchenna', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Ciecierzyca z puszki, odsączona', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Szpinak, surowy', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Pomidory krojone z puszki', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Mleko kokosowe light z puszki', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Cebula, surowa', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Czosnek, surowy', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Imbir korzeń, surowy', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Olej rzepakowy', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Garam masala', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Kmin rzymski mielony', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Sól kuchenna', false),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Cytryna', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Soczewica czerwona, sucha', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Szpinak, surowy', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Pomidory krojone z puszki', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Mleko kokosowe light z puszki', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'woda', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Cebula, surowa', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Czosnek, surowy', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Pasta curry czerwona', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Olej rzepakowy', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Kurkuma mielona', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Sól kuchenna', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Filet z dorsza atlantyckiego', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Szpinak, surowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Mleko kokosowe light z puszki', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Pomidory krojone z puszki', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Ryż basmati, suchy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Cebula, surowa', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Pasta curry czerwona', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Imbir korzeń, surowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Czosnek, surowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Olej rzepakowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Limonka', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Sól kuchenna', false),
    ('Grochówka z indykiem', 'Groch łuskany, suchy', false),
    ('Grochówka z indykiem', 'Pierś z indyka, surowa', false),
    ('Grochówka z indykiem', 'Ziemniaki, surowe', false),
    ('Grochówka z indykiem', 'Marchew, surowa', false),
    ('Grochówka z indykiem', 'Pietruszka korzeń', false),
    ('Grochówka z indykiem', 'Cebula, surowa', false),
    ('Grochówka z indykiem', 'Domowy bulion warzywny', false),
    ('Grochówka z indykiem', 'woda', false),
    ('Grochówka z indykiem', 'Olej rzepakowy', false),
    ('Grochówka z indykiem', 'Majeranek suszony', false),
    ('Grochówka z indykiem', 'liść laurowy', false),
    ('Grochówka z indykiem', 'ziele angielskie', false),
    ('Grochówka z indykiem', 'Sól kuchenna', false),
    ('Grochówka z indykiem', 'Czarny pieprz mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Jagnięcina, udziec surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Ciecierzyca z puszki, odsączona', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Pomidory krojone z puszki', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Kasza bulgur, sucha', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Marchew, surowa', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Cebula, surowa', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Domowy bulion warzywny', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Czosnek, surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Oliwa z oliwek', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Kmin rzymski mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Cynamon mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Papryka słodka mielona', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Sól kuchenna', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Pręga wołowa bez kości, surowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Seler korzeń', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Cebula, surowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Passata pomidorowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Domowy bulion warzywny', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'woda', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Olej rzepakowy', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Papryka słodka mielona', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Majeranek suszony', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'liść laurowy', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Sól kuchenna', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Fasola biała z puszki, odsączona', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Jarmuż, surowy', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Pomidory krojone z puszki', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Marchew, surowa', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Cebula, surowa', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czosnek, surowy', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Domowy bulion warzywny', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Oliwa z oliwek', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Chleb żytni razowy', true),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Tymianek suszony', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Papryka wędzona mielona', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Sól kuchenna', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czarny pieprz mielony', false),
    ('Jaglanka z gruszką i orzechami', 'Kasza jaglana, sucha', false),
    ('Jaglanka z gruszką i orzechami', 'Mleko 2%', false),
    ('Jaglanka z gruszką i orzechami', 'Gruszka ze skórką', true),
    ('Jaglanka z gruszką i orzechami', 'Orzechy włoskie', false),
    ('Jaglanka z gruszką i orzechami', 'Cynamon mielony', false),
    ('Jaglanka z gruszką i orzechami', 'Miód', false),
    ('Jaglanka z gruszką i orzechami', 'Sól kuchenna', false),
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
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Chleb żytni razowy', true),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Ser Gouda', false),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Jaja kurze, całe, surowe', true),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Pomidory, surowe', false),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Jogurt naturalny 2%', false),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Szczypiorek świeży', false),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Czarny pieprz mielony', false),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Chleb żytni razowy', true),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Ser Gouda', false),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Pomidory, surowe', false),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Ogórek, surowy', false),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Sałata masłowa', false),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Musztarda', false),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Czarny pieprz mielony', false),
    ('Kanapki z halloumi, awokado i pomidorem', 'Chleb żytni razowy', true),
    ('Kanapki z halloumi, awokado i pomidorem', 'Halloumi', false),
    ('Kanapki z halloumi, awokado i pomidorem', 'Awokado', true),
    ('Kanapki z halloumi, awokado i pomidorem', 'Pomidory, surowe', true),
    ('Kanapki z halloumi, awokado i pomidorem', 'Rukola', false),
    ('Kanapki z halloumi, awokado i pomidorem', 'Cytryna', false),
    ('Kanapki z halloumi, awokado i pomidorem', 'Czarny pieprz mielony', false),
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
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Chleb żytni razowy', true),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Ser ricotta', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Rzodkiewka, surowa', true),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Szczypiorek świeży', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Jogurt naturalny 2%', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Sól kuchenna', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Czarny pieprz mielony', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Sardynki w oliwie, odsączone', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Chleb żytni razowy', true),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Pomidory, surowe', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Rukola', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Cytryna', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Oliwa z oliwek', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Czarny pieprz mielony', false),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Chleb żytni razowy', true),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Ser salami', false),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'ogórki kiszone bio', false),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Musztarda', false),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Sałata masłowa', false),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Cebula czerwona, surowa', false),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Czarny pieprz mielony', false),
    ('Kałamarnica z papryką i ryżem', 'Kałamarnica, surowa', false),
    ('Kałamarnica z papryką i ryżem', 'Papryka czerwona, surowa', false),
    ('Kałamarnica z papryką i ryżem', 'Ryż basmati, suchy', false),
    ('Kałamarnica z papryką i ryżem', 'Passata pomidorowa', false),
    ('Kałamarnica z papryką i ryżem', 'Cebula, surowa', false),
    ('Kałamarnica z papryką i ryżem', 'Czosnek, surowy', false),
    ('Kałamarnica z papryką i ryżem', 'Oliwa z oliwek', false),
    ('Kałamarnica z papryką i ryżem', 'Papryka wędzona mielona', false),
    ('Kałamarnica z papryką i ryżem', 'Cytryna', false),
    ('Kałamarnica z papryką i ryżem', 'Pietruszka natka', false),
    ('Kałamarnica z papryką i ryżem', 'Sól kuchenna', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Mięso mielone z indyka, surowe', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Bułka tarta', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Jaja kurze, całe, surowe', true),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Passata pomidorowa', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Kasza bulgur, sucha', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Cebula, surowa', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Czosnek, surowy', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Olej rzepakowy', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Oregano suszone', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Papryka słodka mielona', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Sól kuchenna', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Czarny pieprz mielony', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Komosa ryżowa, sucha', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Ciecierzyca z puszki, odsączona', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Cukinia, surowa', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Papryka czerwona, surowa', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Pomidory, surowe', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Cebula czerwona, surowa', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Oliwa z oliwek', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Cytryna', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Pietruszka natka', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Oregano suszone', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Sól kuchenna', false),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Czarny pieprz mielony', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Soczewica czerwona, sucha', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Płatki owsiane', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Marchew, surowa', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Cebula, surowa', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Czosnek, surowy', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Olej rzepakowy', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Kmin rzymski mielony', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Papryka słodka mielona', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Ogórek, surowy', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Cytryna', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Sól kuchenna', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Czarny pieprz mielony', false),
    ('Krem z brokułów z fetą', 'Brokuł, surowy', false),
    ('Krem z brokułów z fetą', 'Ziemniaki, surowe', false),
    ('Krem z brokułów z fetą', 'Domowy bulion warzywny', false),
    ('Krem z brokułów z fetą', 'Cebula, surowa', false),
    ('Krem z brokułów z fetą', 'Czosnek, surowy', false),
    ('Krem z brokułów z fetą', 'Oliwa z oliwek', false),
    ('Krem z brokułów z fetą', 'Jogurt naturalny 2%', false),
    ('Krem z brokułów z fetą', 'Ser feta', false),
    ('Krem z brokułów z fetą', 'Chleb żytni razowy', true),
    ('Krem z brokułów z fetą', 'Gałka muszkatołowa mielona', false),
    ('Krem z brokułów z fetą', 'Czarny pieprz mielony', false),
    ('Krem z dyni na mleku kokosowym', 'Dynia, surowa', false),
    ('Krem z dyni na mleku kokosowym', 'Marchew, surowa', false),
    ('Krem z dyni na mleku kokosowym', 'Mleko kokosowe light z puszki', false),
    ('Krem z dyni na mleku kokosowym', 'Domowy bulion warzywny', false),
    ('Krem z dyni na mleku kokosowym', 'Soczewica czerwona, sucha', false),
    ('Krem z dyni na mleku kokosowym', 'woda', false),
    ('Krem z dyni na mleku kokosowym', 'Cebula, surowa', false),
    ('Krem z dyni na mleku kokosowym', 'Imbir korzeń, surowy', false),
    ('Krem z dyni na mleku kokosowym', 'Czosnek, surowy', false),
    ('Krem z dyni na mleku kokosowym', 'Pasta curry czerwona', false),
    ('Krem z dyni na mleku kokosowym', 'Olej rzepakowy', false),
    ('Krem z dyni na mleku kokosowym', 'Limonka', false),
    ('Krem z dyni na mleku kokosowym', 'Sól kuchenna', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Kalafior, surowy', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Ziemniaki, surowe', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Ciecierzyca z puszki, odsączona', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Domowy bulion warzywny', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Cebula, surowa', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Czosnek, surowy', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Oliwa z oliwek', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Chleb żytni razowy', true),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Kmin rzymski mielony', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Papryka wędzona mielona', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Sól kuchenna', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Czarny pieprz mielony', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Krewetki, surowe', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Cukinia, surowa', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Czosnek, surowy', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Oliwa z oliwek', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Cytryna', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Pietruszka natka', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Chili suszone', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Sól kuchenna', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Królik, mięso surowe', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Seler korzeń', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Cebula, surowa', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Domowy bulion warzywny', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Oliwa z oliwek', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Czosnek, surowy', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Rozmaryn świeży', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Sól kuchenna', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Kurczak pieczony z batatem i brokułem', 'Pierś z kurczaka, surowa', false),
    ('Kurczak pieczony z batatem i brokułem', 'Batat, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Brokuł, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Cebula czerwona, surowa', false),
    ('Kurczak pieczony z batatem i brokułem', 'Oliwa z oliwek', false),
    ('Kurczak pieczony z batatem i brokułem', 'Papryka wędzona mielona', false),
    ('Kurczak pieczony z batatem i brokułem', 'Tymianek suszony', false),
    ('Kurczak pieczony z batatem i brokułem', 'Czosnek, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Sól kuchenna', false),
    ('Kurczak pieczony z batatem i brokułem', 'Czarny pieprz mielony', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Soczewica czerwona, sucha', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Passata pomidorowa', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'woda', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Marchew, surowa', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Cebula, surowa', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Czosnek, surowy', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Oliwa z oliwek', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Oregano suszone', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Bazylia suszona', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Papryka słodka mielona', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Sól kuchenna', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Czarny pieprz mielony', false),
    ('Makaron z brokułem i fetą', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z brokułem i fetą', 'Brokuł, surowy', false),
    ('Makaron z brokułem i fetą', 'Ser feta', false),
    ('Makaron z brokułem i fetą', 'Czosnek, surowy', false),
    ('Makaron z brokułem i fetą', 'Oliwa z oliwek', false),
    ('Makaron z brokułem i fetą', 'Cytryna', false),
    ('Makaron z brokułem i fetą', 'Papryka ostra mielona', false),
    ('Makaron z brokułem i fetą', 'Czarny pieprz mielony', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Ciecierzyca z puszki, odsączona', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Bazylia świeża', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Orzechy włoskie', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Oliwa z oliwek', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Czosnek, surowy', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Cytryna', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Pomidory, surowe', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Sól kuchenna', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Czarny pieprz mielony', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Pierś z indyka, surowa', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Pieczarki, surowe', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Jogurt grecki naturalny 2%', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Cebula, surowa', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Czosnek, surowy', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Olej rzepakowy', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Tymianek suszony', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Sól kuchenna', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Czarny pieprz mielony', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Pierś z kurczaka, surowa', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Szpinak, surowy', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Pomidory krojone z puszki', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Passata pomidorowa', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Cebula, surowa', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Czosnek, surowy', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Oliwa z oliwek', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Oregano suszone', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Bazylia suszona', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Sól kuchenna', false),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Czarny pieprz mielony', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Ser mozzarella', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Cukinia, surowa', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Papryka żółta, surowa', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Pomidory, surowe', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Cebula czerwona, surowa', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Oliwa z oliwek', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Oregano suszone', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Bazylia świeża', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Sól kuchenna', false),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Czarny pieprz mielony', false),
    ('Makaron z polędwiczką i pieczarkami', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z polędwiczką i pieczarkami', 'Polędwiczka wieprzowa, surowa', false),
    ('Makaron z polędwiczką i pieczarkami', 'Pieczarki, surowe', false),
    ('Makaron z polędwiczką i pieczarkami', 'Jogurt grecki naturalny 2%', false),
    ('Makaron z polędwiczką i pieczarkami', 'Cebula, surowa', false),
    ('Makaron z polędwiczką i pieczarkami', 'Czosnek, surowy', false),
    ('Makaron z polędwiczką i pieczarkami', 'Olej rzepakowy', false),
    ('Makaron z polędwiczką i pieczarkami', 'Musztarda', false),
    ('Makaron z polędwiczką i pieczarkami', 'Tymianek suszony', false),
    ('Makaron z polędwiczką i pieczarkami', 'Sól kuchenna', false),
    ('Makaron z polędwiczką i pieczarkami', 'Czarny pieprz mielony', false),
    ('Makaron z ricottą i szpinakiem', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z ricottą i szpinakiem', 'Ser ricotta', false),
    ('Makaron z ricottą i szpinakiem', 'Szpinak, surowy', false),
    ('Makaron z ricottą i szpinakiem', 'Czosnek, surowy', false),
    ('Makaron z ricottą i szpinakiem', 'Oliwa z oliwek', false),
    ('Makaron z ricottą i szpinakiem', 'Cytryna', false),
    ('Makaron z ricottą i szpinakiem', 'Gałka muszkatołowa mielona', false),
    ('Makaron z ricottą i szpinakiem', 'Sól kuchenna', false),
    ('Makaron z ricottą i szpinakiem', 'Czarny pieprz mielony', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Tuńczyk w wodzie, odsączony', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Cytryna', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Pietruszka natka', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Czosnek, surowy', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Oliwa z oliwek', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Chili suszone', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Sól kuchenna', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Czarny pieprz mielony', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Wołowina mielona 5% tłuszczu, surowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Passata pomidorowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Marchew, surowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Cebula, surowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Czosnek, surowy', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Oliwa z oliwek', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Oregano suszone', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Bazylia suszona', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Sól kuchenna', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Czarny pieprz mielony', false),
    ('Małże w pomidorowym bulionie', 'Małże, surowe', false),
    ('Małże w pomidorowym bulionie', 'Pomidory krojone z puszki', false),
    ('Małże w pomidorowym bulionie', 'Domowy bulion warzywny', false),
    ('Małże w pomidorowym bulionie', 'Seler naciowy, surowy', false),
    ('Małże w pomidorowym bulionie', 'Cebula, surowa', false),
    ('Małże w pomidorowym bulionie', 'Czosnek, surowy', false),
    ('Małże w pomidorowym bulionie', 'Oliwa z oliwek', false),
    ('Małże w pomidorowym bulionie', 'Pietruszka natka', false),
    ('Małże w pomidorowym bulionie', 'Chleb żytni razowy', true),
    ('Małże w pomidorowym bulionie', 'Czarny pieprz mielony', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Morszczuk, surowy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Passata pomidorowa', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Ryż parboiled, suchy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Cebula, surowa', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Czosnek, surowy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Oliwa z oliwek', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Papryka słodka mielona', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Oregano suszone', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Pietruszka natka', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Sól kuchenna', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Czarny pieprz mielony', false),
    ('Nocna owsianka z bananem i chia', 'Płatki owsiane', false),
    ('Nocna owsianka z bananem i chia', 'Mleko 2%', false),
    ('Nocna owsianka z bananem i chia', 'Jogurt naturalny 2%', false),
    ('Nocna owsianka z bananem i chia', 'Banan', true),
    ('Nocna owsianka z bananem i chia', 'Nasiona chia', false),
    ('Nocna owsianka z bananem i chia', 'Masło orzechowe bez cukru', false),
    ('Nocna owsianka z bananem i chia', 'Cynamon mielony', false),
    ('Nocna owsianka z borówkami i orzechami', 'Płatki owsiane', false),
    ('Nocna owsianka z borówkami i orzechami', 'Mleko 2%', false),
    ('Nocna owsianka z borówkami i orzechami', 'Jogurt naturalny 2%', false),
    ('Nocna owsianka z borówkami i orzechami', 'Borówki amerykańskie', false),
    ('Nocna owsianka z borówkami i orzechami', 'Nasiona chia', false),
    ('Nocna owsianka z borówkami i orzechami', 'Orzechy włoskie', false),
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
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Papryka czerwona, surowa', true),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Soczewica brązowa, sucha', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Passata pomidorowa', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Cebula, surowa', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Czosnek, surowy', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Oliwa z oliwek', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Kmin rzymski mielony', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Pietruszka natka', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Sól kuchenna', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Czarny pieprz mielony', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Mąka orkiszowa pełnoziarnista', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Jaja kurze, całe, surowe', true),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Mleko 2%', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Skyr naturalny', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Borówki amerykańskie', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Olej rzepakowy', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Miód', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Cynamon mielony', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Makrela atlantycka, surowa', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Buraki, surowe', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Ziemniaki, surowe', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Cebula czerwona, surowa', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Oliwa z oliwek', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Cytryna', false),
    ('Pieczona makrela z burakami i ziemniakami', 'koperek świeży', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Sól kuchenna', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Czarny pieprz mielony', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Ziemniaki, surowe', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Buraki, surowe', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Marchew, surowa', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Pasternak, surowy', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Seler korzeń', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Cebula czerwona, surowa', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Oliwa z oliwek', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Tymianek suszony', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Rozmaryn suszony', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Sól kuchenna', false),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Czarny pieprz mielony', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Bakłażan, surowy', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Ciecierzyca z puszki, odsączona', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Pomidory, surowe', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Ser feta', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Kasza bulgur, sucha', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Cebula czerwona, surowa', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Czosnek, surowy', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Oliwa z oliwek', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Oregano suszone', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Sól kuchenna', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Czarny pieprz mielony', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Kalafior, surowy', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Oliwa z oliwek', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Cytryna', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Czosnek, surowy', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Pietruszka natka', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Kmin rzymski mielony', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Papryka wędzona mielona', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Sól kuchenna', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Czarny pieprz mielony', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Łosoś dziki, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Brokuł, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Ziemniaki, surowe', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Oliwa z oliwek', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Cytryna', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Czosnek, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Tymianek suszony', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Sól kuchenna', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Czarny pieprz mielony', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Kaczka, pierś bez skóry, surowa', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Kapusta czerwona, surowa', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Pomarańcza', true),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Jabłko ze skórką', true),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Ziemniaki, surowe', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Cebula czerwona, surowa', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Olej rzepakowy', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Ocet jabłkowy', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Cynamon mielony', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Goździki suszone', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Sól kuchenna', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Czarny pieprz mielony', false),
    ('Placuszki bananowo-owsiane', 'Banan', true),
    ('Placuszki bananowo-owsiane', 'Jaja kurze, całe, surowe', true),
    ('Placuszki bananowo-owsiane', 'Mąka owsiana pełnoziarnista', false),
    ('Placuszki bananowo-owsiane', 'Mleko 2%', false),
    ('Placuszki bananowo-owsiane', 'Jogurt naturalny 2%', false),
    ('Placuszki bananowo-owsiane', 'Olej rzepakowy', false),
    ('Placuszki bananowo-owsiane', 'Cynamon mielony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa, surowa', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Pieczarki, surowe', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Jogurt grecki naturalny 2%', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Musztarda', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Cebula, surowa', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Domowy bulion warzywny', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Olej rzepakowy', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Tymianek suszony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Sól kuchenna', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Czarny pieprz mielony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Udo z kurczaka bez skóry, surowe', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Kasza jęczmienna, sucha', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Marchew, surowa', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Por, surowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Groszek zielony mrożony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Seler naciowy, surowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Domowy bulion warzywny', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Olej rzepakowy', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Tymianek suszony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Sól kuchenna', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Czarny pieprz mielony', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Pstrąg tęczowy, surowy', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Seler korzeń', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Oliwa z oliwek', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Cytryna', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Rozmaryn suszony', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Sól kuchenna', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Pudding chia z mango i mlekiem kokosowym', 'Nasiona chia', false),
    ('Pudding chia z mango i mlekiem kokosowym', 'Mleko kokosowe light z puszki', false),
    ('Pudding chia z mango i mlekiem kokosowym', 'Mango', false),
    ('Pudding chia z mango i mlekiem kokosowym', 'Migdały', false),
    ('Pudding chia z mango i mlekiem kokosowym', 'Daktyle suszone', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Ryż parboiled, suchy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Pieczarki, surowe', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Szpinak, surowy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Parmezan', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Cebula, surowa', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czosnek, surowy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Domowy bulion warzywny', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Oliwa z oliwek', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Sól kuchenna', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czarny pieprz mielony', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Brokuł, surowy', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Jaja kurze, całe, surowe', true),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Kukurydza konserwowa, odsączona', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Cebula czerwona, surowa', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Musztarda', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Szczypiorek świeży', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Sól kuchenna', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Czarny pieprz mielony', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Makaron pełnoziarnisty, suchy', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Ser mozzarella', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Pomidory, surowe', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Ogórek, surowy', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Papryka czerwona, surowa', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Oliwki czarne', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Oliwa z oliwek', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Bazylia świeża', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Cytryna', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Sól kuchenna', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Makaron pełnoziarnisty, suchy', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Tuńczyk w wodzie, odsączony', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Ogórek, surowy', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Pomidory, surowe', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Kukurydza konserwowa, odsączona', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Jogurt grecki naturalny 2%', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Musztarda', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Szczypiorek świeży', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Sól kuchenna', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Fasola czarna z puszki, odsączona', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kukurydza konserwowa, odsączona', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Pomidory, surowe', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Papryka czerwona, surowa', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Awokado', true),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Cebula czerwona, surowa', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Limonka', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kolendra świeża', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Oliwa z oliwek', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kmin rzymski mielony', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Sól kuchenna', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Jaja kurze, całe, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ser feta', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Pomidory, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ogórek, surowy', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sałata rzymska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Oliwa z oliwek', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sól kuchenna', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Jarmuż, surowy', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Jabłko ze skórką', true),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Pomarańcza', true),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Orzechy włoskie', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Oliwa z oliwek', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Cytryna', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Musztarda', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Sól kuchenna', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Czarny pieprz mielony', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Komosa ryżowa, sucha', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Buraki, surowe', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Ser kozi miękki', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Rukola', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Jabłko ze skórką', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Orzechy włoskie', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Oliwa z oliwek', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Ocet winny czerwony', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Tymianek suszony', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Sól kuchenna', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Czarny pieprz mielony', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Buraki, surowe', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Ser feta', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Rukola', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Cebula czerwona, surowa', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Orzechy włoskie', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Oliwa z oliwek', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Ocet winny czerwony', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Tymianek suszony', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Czarny pieprz mielony', false),
    ('Serek wiejski z owocami i orzechami', 'Serek wiejski naturalny', false),
    ('Serek wiejski z owocami i orzechami', 'Banan', true),
    ('Serek wiejski z owocami i orzechami', 'Borówki amerykańskie', false),
    ('Serek wiejski z owocami i orzechami', 'Orzechy włoskie', false),
    ('Serek wiejski z owocami i orzechami', 'Cynamon mielony', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Serek wiejski naturalny', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Pomidory, surowe', true),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Ogórek, surowy', true),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Pestki dyni', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Sól kuchenna', false),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Czarny pieprz mielony', false),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Skyr naturalny', false),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Banan', true),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Kakao bez cukru, proszek', false),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Masło orzechowe bez cukru', false),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Mleko 2%', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Skyr naturalny', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Banan', true),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Borówki amerykańskie', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Płatki owsiane', false),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Orzechy włoskie', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Tuńczyk świeży, surowy', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Fasolka szparagowa, surowa', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Ziemniaki, surowe', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Oliwa z oliwek', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Cytryna', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Czosnek, surowy', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Sól kuchenna', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Czarny pieprz mielony', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Kasza bulgur, sucha', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Ciecierzyca z puszki, odsączona', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Pomidory, surowe', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Ogórek, surowy', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Cebula czerwona, surowa', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Pietruszka natka', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Mięta świeża', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Cytryna', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Oliwa z oliwek', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Sól kuchenna', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Czarny pieprz mielony', false),
    ('Tofu z brokułem i ryżem', 'Tofu naturalne', false),
    ('Tofu z brokułem i ryżem', 'Brokuł, surowy', false),
    ('Tofu z brokułem i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Tofu z brokułem i ryżem', 'Sos sojowy', false),
    ('Tofu z brokułem i ryżem', 'Olej rzepakowy', false),
    ('Tofu z brokułem i ryżem', 'Imbir korzeń, surowy', false),
    ('Tofu z brokułem i ryżem', 'Czosnek, surowy', false),
    ('Tofu z brokułem i ryżem', 'Sezam', false),
    ('Tofu z brokułem i ryżem', 'Cebula dymka, surowa', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Tofu naturalne', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Szpinak, surowy', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Pomidory, surowe', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Cebula, surowa', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Chleb żytni razowy', true),
    ('Tofucznica ze szpinakiem i pomidorem', 'Olej rzepakowy', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Kurkuma mielona', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Sól kuchenna', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Czarny pieprz mielony', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Tortilla pełnoziarnista', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Ser Gouda', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Szpinak, surowy', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Pomidory, surowe', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Cebula, surowa', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Olej rzepakowy', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Oregano suszone', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Czarny pieprz mielony', false),
    ('Tortilla z hummusem i warzywami', 'Tortilla pełnoziarnista', false),
    ('Tortilla z hummusem i warzywami', 'Ciecierzyca z puszki, odsączona', false),
    ('Tortilla z hummusem i warzywami', 'Sezam', false),
    ('Tortilla z hummusem i warzywami', 'Oliwa z oliwek', false),
    ('Tortilla z hummusem i warzywami', 'Cytryna', false),
    ('Tortilla z hummusem i warzywami', 'Czosnek, surowy', false),
    ('Tortilla z hummusem i warzywami', 'Ogórek, surowy', false),
    ('Tortilla z hummusem i warzywami', 'Pomidory, surowe', false),
    ('Tortilla z hummusem i warzywami', 'Sałata rzymska', false),
    ('Tortilla z hummusem i warzywami', 'Kmin rzymski mielony', false),
    ('Tortilla z hummusem i warzywami', 'Sól kuchenna', false),
    ('Tortilla z jajkiem i szpinakiem', 'Tortilla pełnoziarnista', false),
    ('Tortilla z jajkiem i szpinakiem', 'Jaja kurze, całe, surowe', true),
    ('Tortilla z jajkiem i szpinakiem', 'Szpinak, surowy', false),
    ('Tortilla z jajkiem i szpinakiem', 'Pomidory, surowe', false),
    ('Tortilla z jajkiem i szpinakiem', 'Ser feta', false),
    ('Tortilla z jajkiem i szpinakiem', 'Olej rzepakowy', false),
    ('Tortilla z jajkiem i szpinakiem', 'Sól kuchenna', false),
    ('Tortilla z jajkiem i szpinakiem', 'Czarny pieprz mielony', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Tortilla pełnoziarnista', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Pierś z kurczaka, surowa', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Awokado', true),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Pomidory, surowe', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Ogórek, surowy', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Sałata rzymska', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Jogurt naturalny 2%', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Olej rzepakowy', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Cytryna', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Papryka słodka mielona', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Sól kuchenna', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Czarny pieprz mielony', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Tortilla pełnoziarnista', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Tofu naturalne', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Kapusta pekińska, surowa', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Marchew, surowa', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Ogórek, surowy', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Sos sojowy', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Masło orzechowe bez cukru', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Limonka', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Olej rzepakowy', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Sezam', false),
    ('Tosty z Goudą i pieczarkami', 'Chleb żytni razowy', true),
    ('Tosty z Goudą i pieczarkami', 'Ser Gouda', false),
    ('Tosty z Goudą i pieczarkami', 'Pieczarki, surowe', false),
    ('Tosty z Goudą i pieczarkami', 'Cebula, surowa', false),
    ('Tosty z Goudą i pieczarkami', 'Masło', false),
    ('Tosty z Goudą i pieczarkami', 'Tymianek suszony', false),
    ('Tosty z Goudą i pieczarkami', 'Czarny pieprz mielony', false),
    ('Tosty z mozzarellą i pomidorem', 'Chleb żytni razowy', true),
    ('Tosty z mozzarellą i pomidorem', 'Ser mozzarella', false),
    ('Tosty z mozzarellą i pomidorem', 'Pomidory, surowe', true),
    ('Tosty z mozzarellą i pomidorem', 'Bazylia świeża', false),
    ('Tosty z mozzarellą i pomidorem', 'Sól kuchenna', false),
    ('Tosty z mozzarellą i pomidorem', 'Czarny pieprz mielony', false),
    ('Tosty z serem salami i papryką', 'Chleb żytni razowy', true),
    ('Tosty z serem salami i papryką', 'Ser salami', false),
    ('Tosty z serem salami i papryką', 'Papryka czerwona, surowa', false),
    ('Tosty z serem salami i papryką', 'Musztarda', false),
    ('Tosty z serem salami i papryką', 'Masło', false),
    ('Tosty z serem salami i papryką', 'Papryka wędzona mielona', false),
    ('Tosty z serem salami i papryką', 'Czarny pieprz mielony', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Twaróg półtłusty', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Jogurt naturalny 2%', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Rzodkiewka, surowa', true),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Szczypiorek świeży', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Chleb żytni razowy', true),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Sól kuchenna', false),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Czarny pieprz mielony', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Polędwiczka wieprzowa, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Kapusta pekińska, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Marchew, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Cebula, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Sos sojowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Imbir korzeń, surowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Czosnek, surowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Olej rzepakowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Sezam', false),
    ('Zupa z białej fasoli i jarmużu', 'Fasola biała z puszki, odsączona', false),
    ('Zupa z białej fasoli i jarmużu', 'Jarmuż, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Pomidory krojone z puszki', false),
    ('Zupa z białej fasoli i jarmużu', 'Domowy bulion warzywny', false),
    ('Zupa z białej fasoli i jarmużu', 'Marchew, surowa', false),
    ('Zupa z białej fasoli i jarmużu', 'Seler naciowy, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Cebula, surowa', false),
    ('Zupa z białej fasoli i jarmużu', 'Czosnek, surowy', false),
    ('Zupa z białej fasoli i jarmużu', 'Oliwa z oliwek', false),
    ('Zupa z białej fasoli i jarmużu', 'Tymianek suszony', false),
    ('Zupa z białej fasoli i jarmużu', 'Chleb żytni razowy', true),
    ('Zupa z białej fasoli i jarmużu', 'Sól kuchenna', false),
    ('Zupa z białej fasoli i jarmużu', 'Czarny pieprz mielony', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Soczewica czerwona, sucha', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Pomidory krojone z puszki', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Domowy bulion warzywny', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Marchew, surowa', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Cebula, surowa', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Czosnek, surowy', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Oliwa z oliwek', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Kmin rzymski mielony', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Papryka wędzona mielona', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Cytryna', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Chleb żytni razowy', true),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Sól kuchenna', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Czarny pieprz mielony', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Łosoś dziki, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Szpinak, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Jogurt grecki naturalny 2%', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Cytryna', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Czosnek, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Oliwa z oliwek', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Sól kuchenna', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Czarny pieprz mielony', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Chili sin carne z czarną fasolą', 'Garnek 3 l'),
    ('Chili sin carne z czarną fasolą', 'Nóż szefa kuchni'),
    ('Chili sin carne z czarną fasolą', 'Deska do krojenia'),
    ('Chili sin carne z czarną fasolą', 'Waga kuchenna'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Garnek 3 l'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Nóż szefa kuchni'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Deska do krojenia'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Waga kuchenna'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Garnek 3 l'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Nóż szefa kuchni'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Deska do krojenia'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Waga kuchenna'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Patelnia 28 cm'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Garnek 2 l'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Nóż szefa kuchni'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Deska do krojenia'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Waga kuchenna'),
    ('Grochówka z indykiem', 'Garnek 3 l'),
    ('Grochówka z indykiem', 'Nóż szefa kuchni'),
    ('Grochówka z indykiem', 'Deska do krojenia'),
    ('Grochówka z indykiem', 'Waga kuchenna'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Garnek 3 l'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Garnek 2 l'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Nóż szefa kuchni'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Deska do krojenia'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Waga kuchenna'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Garnek 3 l'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Deska do krojenia'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Waga kuchenna'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Garnek 3 l'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Nóż szefa kuchni'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Deska do krojenia'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Waga kuchenna'),
    ('Jaglanka z gruszką i orzechami', 'Rondel'),
    ('Jaglanka z gruszką i orzechami', 'Sitko'),
    ('Jaglanka z gruszką i orzechami', 'Nóż szefa kuchni'),
    ('Jaglanka z gruszką i orzechami', 'Deska do krojenia'),
    ('Jaglanka z gruszką i orzechami', 'Waga kuchenna'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Patelnia 24 cm'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'miska'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Widelec'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Deska do krojenia'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Waga kuchenna'),
    ('Jajka na miękko z pieczywem i warzywami', 'Garnek 2 l'),
    ('Jajka na miękko z pieczywem i warzywami', 'Nóż szefa kuchni'),
    ('Jajka na miękko z pieczywem i warzywami', 'Deska do krojenia'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Garnek 2 l'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Deska do krojenia'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Waga kuchenna'),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Nóż szefa kuchni'),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Deska do krojenia'),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Waga kuchenna'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Patelnia 24 cm'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Nóż szefa kuchni'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Deska do krojenia'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Waga kuchenna'),
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
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'miska'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Widelec'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Deska do krojenia'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Waga kuchenna'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'miska'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Widelec'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Nóż szefa kuchni'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Deska do krojenia'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Waga kuchenna'),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Nóż szefa kuchni'),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Deska do krojenia'),
    ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Waga kuchenna'),
    ('Kałamarnica z papryką i ryżem', 'Patelnia 28 cm'),
    ('Kałamarnica z papryką i ryżem', 'Garnek 2 l'),
    ('Kałamarnica z papryką i ryżem', 'Nóż szefa kuchni'),
    ('Kałamarnica z papryką i ryżem', 'Deska do krojenia'),
    ('Kałamarnica z papryką i ryżem', 'Waga kuchenna'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Patelnia 28 cm'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Garnek 2 l'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'miska'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Nóż szefa kuchni'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Deska do krojenia'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Waga kuchenna'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Piekarnik'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Blacha do pieczenia'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Garnek 2 l'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Nóż szefa kuchni'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Deska do krojenia'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Waga kuchenna'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Garnek 2 l'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Patelnia 28 cm'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'miska'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Tarka o grubych oczkach'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Nóż szefa kuchni'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Deska do krojenia'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Waga kuchenna'),
    ('Krem z brokułów z fetą', 'Garnek 3 l'),
    ('Krem z brokułów z fetą', 'Blender ręczny'),
    ('Krem z brokułów z fetą', 'Nóż szefa kuchni'),
    ('Krem z brokułów z fetą', 'Deska do krojenia'),
    ('Krem z brokułów z fetą', 'Waga kuchenna'),
    ('Krem z dyni na mleku kokosowym', 'Garnek 3 l'),
    ('Krem z dyni na mleku kokosowym', 'Blender ręczny'),
    ('Krem z dyni na mleku kokosowym', 'Nóż szefa kuchni'),
    ('Krem z dyni na mleku kokosowym', 'Deska do krojenia'),
    ('Krem z dyni na mleku kokosowym', 'Waga kuchenna'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Piekarnik'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Blacha do pieczenia'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Garnek 3 l'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Blender ręczny'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Nóż szefa kuchni'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Deska do krojenia'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Waga kuchenna'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Patelnia 28 cm'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Garnek 2 l'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Nóż szefa kuchni'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Deska do krojenia'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Waga kuchenna'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Piekarnik'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Naczynie żaroodporne'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Deska do krojenia'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Waga kuchenna'),
    ('Kurczak pieczony z batatem i brokułem', 'Piekarnik'),
    ('Kurczak pieczony z batatem i brokułem', 'Blacha do pieczenia'),
    ('Kurczak pieczony z batatem i brokułem', 'Nóż szefa kuchni'),
    ('Kurczak pieczony z batatem i brokułem', 'Deska do krojenia'),
    ('Kurczak pieczony z batatem i brokułem', 'Waga kuchenna'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Garnek 3 l'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Garnek 2 l'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Tarka o grubych oczkach'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Nóż szefa kuchni'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Deska do krojenia'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Waga kuchenna'),
    ('Makaron z brokułem i fetą', 'Garnek 3 l'),
    ('Makaron z brokułem i fetą', 'Patelnia 28 cm'),
    ('Makaron z brokułem i fetą', 'Nóż szefa kuchni'),
    ('Makaron z brokułem i fetą', 'Deska do krojenia'),
    ('Makaron z brokułem i fetą', 'Waga kuchenna'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Garnek 3 l'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Blender ręczny'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Nóż szefa kuchni'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Deska do krojenia'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Waga kuchenna'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Patelnia 28 cm'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Garnek 3 l'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'miska'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Nóż szefa kuchni'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Deska do krojenia'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Waga kuchenna'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Patelnia 28 cm'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Garnek 3 l'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Nóż szefa kuchni'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Deska do krojenia'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Waga kuchenna'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Piekarnik'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Blacha do pieczenia'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Garnek 3 l'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Nóż szefa kuchni'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Deska do krojenia'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Waga kuchenna'),
    ('Makaron z polędwiczką i pieczarkami', 'Patelnia 28 cm'),
    ('Makaron z polędwiczką i pieczarkami', 'Garnek 3 l'),
    ('Makaron z polędwiczką i pieczarkami', 'miska'),
    ('Makaron z polędwiczką i pieczarkami', 'Nóż szefa kuchni'),
    ('Makaron z polędwiczką i pieczarkami', 'Deska do krojenia'),
    ('Makaron z polędwiczką i pieczarkami', 'Waga kuchenna'),
    ('Makaron z ricottą i szpinakiem', 'Patelnia 28 cm'),
    ('Makaron z ricottą i szpinakiem', 'Garnek 3 l'),
    ('Makaron z ricottą i szpinakiem', 'Nóż szefa kuchni'),
    ('Makaron z ricottą i szpinakiem', 'Deska do krojenia'),
    ('Makaron z ricottą i szpinakiem', 'Waga kuchenna'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Garnek 3 l'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Patelnia 28 cm'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Nóż szefa kuchni'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Deska do krojenia'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Waga kuchenna'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Patelnia 28 cm'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Garnek 3 l'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Tarka o grubych oczkach'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Nóż szefa kuchni'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Deska do krojenia'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Waga kuchenna'),
    ('Małże w pomidorowym bulionie', 'Garnek 3 l'),
    ('Małże w pomidorowym bulionie', 'Nóż szefa kuchni'),
    ('Małże w pomidorowym bulionie', 'Deska do krojenia'),
    ('Małże w pomidorowym bulionie', 'Waga kuchenna'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Patelnia 28 cm'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Garnek 2 l'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Nóż szefa kuchni'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Deska do krojenia'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Waga kuchenna'),
    ('Nocna owsianka z bananem i chia', 'miska'),
    ('Nocna owsianka z bananem i chia', 'Widelec'),
    ('Nocna owsianka z bananem i chia', 'Nóż szefa kuchni'),
    ('Nocna owsianka z bananem i chia', 'Deska do krojenia'),
    ('Nocna owsianka z bananem i chia', 'Waga kuchenna'),
    ('Nocna owsianka z borówkami i orzechami', 'miska'),
    ('Nocna owsianka z borówkami i orzechami', 'Waga kuchenna'),
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
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Piekarnik'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Naczynie żaroodporne'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Garnek 2 l'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Nóż szefa kuchni'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Deska do krojenia'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Waga kuchenna'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Patelnia 24 cm'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'miska'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Widelec'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Waga kuchenna'),
    ('Pieczona makrela z burakami i ziemniakami', 'Piekarnik'),
    ('Pieczona makrela z burakami i ziemniakami', 'Blacha do pieczenia'),
    ('Pieczona makrela z burakami i ziemniakami', 'Nóż szefa kuchni'),
    ('Pieczona makrela z burakami i ziemniakami', 'Deska do krojenia'),
    ('Pieczona makrela z burakami i ziemniakami', 'Waga kuchenna'),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Piekarnik'),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Blacha do pieczenia'),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Nóż szefa kuchni'),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Deska do krojenia'),
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Waga kuchenna'),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Piekarnik'),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Naczynie żaroodporne'),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Garnek 2 l'),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Nóż szefa kuchni'),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Deska do krojenia'),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Waga kuchenna'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Piekarnik'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Blacha do pieczenia'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'miska'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Nóż szefa kuchni'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Deska do krojenia'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Waga kuchenna'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Piekarnik'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Blacha do pieczenia'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Nóż szefa kuchni'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Deska do krojenia'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Waga kuchenna'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Patelnia 28 cm'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Garnek 3 l'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Garnek 2 l'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Nóż szefa kuchni'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Deska do krojenia'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Waga kuchenna'),
    ('Placuszki bananowo-owsiane', 'Patelnia 24 cm'),
    ('Placuszki bananowo-owsiane', 'miska'),
    ('Placuszki bananowo-owsiane', 'Widelec'),
    ('Placuszki bananowo-owsiane', 'Waga kuchenna'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Patelnia 28 cm'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Garnek 2 l'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'miska'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Nóż szefa kuchni'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Deska do krojenia'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Waga kuchenna'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Garnek 3 l'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Nóż szefa kuchni'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Deska do krojenia'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Waga kuchenna'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Piekarnik'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Blacha do pieczenia'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Deska do krojenia'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Waga kuchenna'),
    ('Pudding chia z mango i mlekiem kokosowym', 'miska'),
    ('Pudding chia z mango i mlekiem kokosowym', 'Widelec'),
    ('Pudding chia z mango i mlekiem kokosowym', 'Nóż szefa kuchni'),
    ('Pudding chia z mango i mlekiem kokosowym', 'Deska do krojenia'),
    ('Pudding chia z mango i mlekiem kokosowym', 'Waga kuchenna'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Garnek 3 l'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Tarka o drobnych oczkach'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Nóż szefa kuchni'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Deska do krojenia'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Waga kuchenna'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Garnek 3 l'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'miska'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Nóż szefa kuchni'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Deska do krojenia'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Waga kuchenna'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Garnek 3 l'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Sitko'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'miska'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Deska do krojenia'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Waga kuchenna'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Garnek 2 l'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Sitko'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'miska'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Deska do krojenia'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Waga kuchenna'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'miska'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Nóż szefa kuchni'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Deska do krojenia'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Waga kuchenna'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Garnek 2 l'),
    ('Sałatka z jajkiem, fetą i warzywami', 'miska'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Widelec'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Deska do krojenia'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Waga kuchenna'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'miska'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Nóż szefa kuchni'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Deska do krojenia'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Waga kuchenna'),
    ('Sałatka z komosy, buraka i koziego sera', 'Piekarnik'),
    ('Sałatka z komosy, buraka i koziego sera', 'Blacha do pieczenia'),
    ('Sałatka z komosy, buraka i koziego sera', 'Garnek 2 l'),
    ('Sałatka z komosy, buraka i koziego sera', 'miska'),
    ('Sałatka z komosy, buraka i koziego sera', 'Nóż szefa kuchni'),
    ('Sałatka z komosy, buraka i koziego sera', 'Deska do krojenia'),
    ('Sałatka z komosy, buraka i koziego sera', 'Waga kuchenna'),
    ('Sałatka z pieczonym burakiem i fetą', 'Piekarnik'),
    ('Sałatka z pieczonym burakiem i fetą', 'Blacha do pieczenia'),
    ('Sałatka z pieczonym burakiem i fetą', 'miska'),
    ('Sałatka z pieczonym burakiem i fetą', 'Nóż szefa kuchni'),
    ('Sałatka z pieczonym burakiem i fetą', 'Deska do krojenia'),
    ('Sałatka z pieczonym burakiem i fetą', 'Waga kuchenna'),
    ('Serek wiejski z owocami i orzechami', 'miska'),
    ('Serek wiejski z owocami i orzechami', 'Nóż szefa kuchni'),
    ('Serek wiejski z owocami i orzechami', 'Deska do krojenia'),
    ('Serek wiejski z owocami i orzechami', 'Waga kuchenna'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'miska'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Widelec'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Nóż szefa kuchni'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Deska do krojenia'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Waga kuchenna'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'miska'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Widelec'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Nóż szefa kuchni'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Deska do krojenia'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Waga kuchenna'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'miska'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Nóż szefa kuchni'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Deska do krojenia'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Waga kuchenna'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Patelnia 28 cm'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Garnek 3 l'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Garnek 2 l'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Nóż szefa kuchni'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Deska do krojenia'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Waga kuchenna'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Garnek 2 l'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Sitko'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'miska'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Nóż szefa kuchni'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Deska do krojenia'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Waga kuchenna'),
    ('Tofu z brokułem i ryżem', 'Patelnia 28 cm'),
    ('Tofu z brokułem i ryżem', 'Garnek 2 l'),
    ('Tofu z brokułem i ryżem', 'Tarka o drobnych oczkach'),
    ('Tofu z brokułem i ryżem', 'Nóż szefa kuchni'),
    ('Tofu z brokułem i ryżem', 'Deska do krojenia'),
    ('Tofu z brokułem i ryżem', 'Waga kuchenna'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Patelnia 24 cm'),
    ('Tofucznica ze szpinakiem i pomidorem', 'miska'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Widelec'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Nóż szefa kuchni'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Deska do krojenia'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Waga kuchenna'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Patelnia 24 cm'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Nóż szefa kuchni'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Deska do krojenia'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Waga kuchenna'),
    ('Tortilla z hummusem i warzywami', 'Blender ręczny'),
    ('Tortilla z hummusem i warzywami', 'miska'),
    ('Tortilla z hummusem i warzywami', 'Nóż szefa kuchni'),
    ('Tortilla z hummusem i warzywami', 'Deska do krojenia'),
    ('Tortilla z hummusem i warzywami', 'Waga kuchenna'),
    ('Tortilla z jajkiem i szpinakiem', 'Patelnia 24 cm'),
    ('Tortilla z jajkiem i szpinakiem', 'miska'),
    ('Tortilla z jajkiem i szpinakiem', 'Widelec'),
    ('Tortilla z jajkiem i szpinakiem', 'Nóż szefa kuchni'),
    ('Tortilla z jajkiem i szpinakiem', 'Deska do krojenia'),
    ('Tortilla z jajkiem i szpinakiem', 'Waga kuchenna'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Patelnia 24 cm'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'miska'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Nóż szefa kuchni'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Deska do krojenia'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Waga kuchenna'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Patelnia 24 cm'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'miska'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Tarka o grubych oczkach'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Nóż szefa kuchni'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Deska do krojenia'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Waga kuchenna'),
    ('Tosty z Goudą i pieczarkami', 'Patelnia 24 cm'),
    ('Tosty z Goudą i pieczarkami', 'Grill kontaktowy'),
    ('Tosty z Goudą i pieczarkami', 'Nóż szefa kuchni'),
    ('Tosty z Goudą i pieczarkami', 'Deska do krojenia'),
    ('Tosty z Goudą i pieczarkami', 'Waga kuchenna'),
    ('Tosty z mozzarellą i pomidorem', 'Grill kontaktowy'),
    ('Tosty z mozzarellą i pomidorem', 'Nóż szefa kuchni'),
    ('Tosty z mozzarellą i pomidorem', 'Deska do krojenia'),
    ('Tosty z mozzarellą i pomidorem', 'Waga kuchenna'),
    ('Tosty z serem salami i papryką', 'Grill kontaktowy'),
    ('Tosty z serem salami i papryką', 'Nóż szefa kuchni'),
    ('Tosty z serem salami i papryką', 'Deska do krojenia'),
    ('Tosty z serem salami i papryką', 'Waga kuchenna'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'miska'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Widelec'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Nóż szefa kuchni'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Deska do krojenia'),
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Waga kuchenna'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Patelnia 28 cm'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Garnek 2 l'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Tarka o drobnych oczkach'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Nóż szefa kuchni'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Deska do krojenia'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Waga kuchenna'),
    ('Zupa z białej fasoli i jarmużu', 'Garnek 3 l'),
    ('Zupa z białej fasoli i jarmużu', 'Nóż szefa kuchni'),
    ('Zupa z białej fasoli i jarmużu', 'Deska do krojenia'),
    ('Zupa z białej fasoli i jarmużu', 'Waga kuchenna'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Garnek 3 l'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Nóż szefa kuchni'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Deska do krojenia'),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Waga kuchenna'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Patelnia 24 cm'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Garnek 2 l'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Nóż szefa kuchni'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Deska do krojenia'),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Waga kuchenna')
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
--  Chili sin carne z czarną fasolą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Chili sin carne z czarną fasolą', 'Jednogarnkowe chili bez mięsa z czarną i czerwoną fasolą, kukurydzą oraz papryką. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 585, 1,
  10, 28,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Chili przechowuj w lodówce do 3 dni lub zamroź po ostudzeniu.',
  true, 'Za ostre chili złagodź dodatkową passatą. Za rzadkie gotuj kilka minut bez przykrycia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Chili sin carne z czarną fasolą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Chili sin carne z czarną fasolą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Fasola czarna z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Fasola czerwona z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Kukurydza konserwowa, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Chili suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Cebulę oraz czosnek posiekaj, a paprykę pokrój w kostkę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie chili', 28 from przepisy p where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju zeszklij cebulę. Dodaj czosnek, paprykę, kmin, wędzoną paprykę i chili; smaż 3 minuty.', null::text, false),
         (2::smallint, 'Dodaj pomidory, passatę, obie fasole i kukurydzę. Wymieszaj i gotuj 20 minut bez przykrycia.', null::text, true),
         (3::smallint, 'Dopraw solą.', 'sos jest gęsty, a papryka miękka'::text, false),
         (4::smallint, 'Spróbuj i w razie potrzeby skoryguj ostrość.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Curry z ciecierzycy, pomidorów i szpinaku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Curry z ciecierzycy, pomidorów i szpinaku', 'Łagodne jednogarnkowe curry z ciecierzycą, szpinakiem i pomidorami. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 662, 1,
  8, 22,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Curry przechowuj w lodówce do 3 dni lub zamroź po ostudzeniu.',
  true, 'Za gęste curry rozcieńcz wodą. Jeśli jest mdłe, dodaj odrobinę soli, kminu i soku z cytryny.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Garam masala';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Cytryna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 8 from przepisy p where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Cebulę, czosnek i imbir drobno posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 22 from przepisy p where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju smaż cebulę 4 minuty. Dodaj czosnek, imbir, garam masala oraz kmin.', null::text, false),
         (2::smallint, 'Dodaj pomidory, mleko kokosowe i ciecierzycę. Gotuj 15 minut.', null::text, false),
         (3::smallint, 'Dodaj szpinak, sól i sok z cytryny. Gotuj jeszcze 2 minuty.', 'szpinak zwiędł, a sos lekko zgęstniał'::text, true),
         (4::smallint, 'Spróbuj i w razie potrzeby skoryguj sól oraz kwaśność.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Curry z czerwonej soczewicy i szpinaku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Curry z czerwonej soczewicy i szpinaku', 'Kremowe jednogarnkowe curry z czerwonej soczewicy, szpinaku i pomidorów. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 747, 1,
  8, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Curry przechowuj w zamkniętym pojemniku w lodówce do 3 dni.',
  true, 'Za gęste curry rozprowadź niewielką ilością wody. Zbyt łagodny smak popraw odrobiną pasty curry i soku z cytryny.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Curry z czerwonej soczewicy i szpinaku'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Curry z czerwonej soczewicy i szpinaku'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'ml'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Kurkuma mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 8 from przepisy p where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Cebulę i czosnek drobno posiekaj, a soczewicę opłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 25 from przepisy p where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'W garnku rozgrzej olej. Dodaj cebulę i smaż 3 minuty, następnie dodaj czosnek, pastę curry i kurkumę.', null::text, false),
         (2::smallint, 'Dodaj soczewicę, pomidory, mleko kokosowe i wodę. Gotuj na małym ogniu około 18 minut, często mieszając.', null::text, true),
         (3::smallint, 'Dodaj szpinak i sól. Gotuj jeszcze 2–3 minuty.', 'soczewica jest miękka, a sos kremowy'::text, false),
         (4::smallint, 'Spróbuj i w razie potrzeby skoryguj ostrość oraz sól.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Dorsz w kokosowym curry ze szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Dorsz w kokosowym curry ze szpinakiem', 'Delikatny dorsz w kokosowym sosie curry ze szpinakiem, podany z ryżem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 749, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Podgrzewaj delikatnie, aby ryba się nie rozpadła.',
  false, 'Za rzadki sos odparuj przed dodaniem ryby. Jeśli dorsz się rozpadnie, podaj całość jako gęste curry.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojony na duże kawałki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Filet z dorsza atlantyckiego';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj. Cebulę, czosnek i imbir posiekaj, a dorsza pokrój na duże kawałki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 20 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju zeszklij cebulę. Dodaj czosnek, imbir i pastę curry.', null::text, false),
         (2::smallint, 'Dodaj pomidory oraz mleko kokosowe i gotuj 8 minut.', null::text, false),
         (3::smallint, 'Dodaj dorsza i gotuj na małym ogniu 6–8 minut bez intensywnego mieszania.', null::text, true),
         (4::smallint, 'Dodaj szpinak, sok z limonki i sól.', 'ryba jest ścięta, a szpinak zwiędł'::text, false),
         (5::smallint, 'Podaj curry z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Grochówka z indykiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grochówka z indykiem', 'Treściwa grochówka z mięsem indyka, ziemniakami, warzywami korzeniowymi i majerankiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 821, 1,
  15, 55,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź w porcjach.',
  true, 'Jeśli groch pozostaje twardy, gotuj dalej i uzupełniaj wodę. Za gęstą zupę rozcieńcz gorącym bulionem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grochówka z indykiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grochówka z indykiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'opłukany', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Groch łuskany, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Pierś z indyka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'ml'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Groch opłucz. Indyka i warzywa pokrój, a cebulę posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 55 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju zeszklij cebulę, dodaj indyka i smaż, aż straci surowy kolor.', null::text, false),
         (2::smallint, 'Dodaj groch, marchew, pietruszkę, bulion, wodę, liść laurowy i ziele angielskie. Gotuj 30 minut.', null::text, false),
         (3::smallint, 'Dodaj ziemniaki i gotuj jeszcze około 20 minut.', 'groch się rozpada, a mięso i ziemniaki są miękkie'::text, true),
         (4::smallint, 'Dodaj majeranek, sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz jagnięcy z ciecierzycą i pomidorami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz jagnięcy z ciecierzycą i pomidorami', 'Aromatyczny gulasz jagnięcy z ciecierzycą, pomidorami i korzennymi przyprawami, podany z bulgurem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 738, 1,
  15, 80,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź. Kaszę trzymaj osobno.',
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
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Jagnięcina, udziec surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Cynamon mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jagnięcinę pokrój i osusz. Marchew pokrój, cebulę i czosnek posiekaj.', null::text, false),
         (2::smallint, 'Kaszę bulgur ugotuj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie', 80 from przepisy p where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie obsmaż jagnięcinę partiami. Dodaj cebulę i marchew.', null::text, false),
         (2::smallint, 'Dodaj czosnek, przyprawy, pomidory i bulion. Duś pod przykryciem około 60 minut.', null::text, false),
         (3::smallint, 'Dodaj ciecierzycę i duś kolejne 15 minut.', 'mięso jest miękkie, a sos gęsty'::text, true),
         (4::smallint, 'Podaj z kaszą bulgur.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz wołowy z warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz wołowy z warzywami korzeniowymi', 'Długo duszony gulasz wołowy z ziemniakami, marchewką, pasternakiem i selerem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 954, 1,
  18, 130,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź po ostudzeniu.',
  true, 'Twarde mięso duś dalej na małym ogniu, uzupełniając gorącą wodę. Za rzadki sos odparuj bez przykrycia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Pręga wołowa bez kości, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'ml'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 18 from przepisy p where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mięso osusz i pokrój w kostkę. Warzywa pokrój na podobnej wielkości kawałki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie', 130 from przepisy p where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na mocno rozgrzanym oleju obsmaż mięso partiami. Dodaj cebulę.', null::text, false),
         (2::smallint, 'Dodaj passatę, bulion, wodę, paprykę, majeranek i liść laurowy. Duś pod przykryciem około 90 minut; co pewien czas sprawdzaj ilość płynu.', null::text, false),
         (3::smallint, 'Dodaj warzywa i duś jeszcze 30–35 minut.', 'wołowina daje się łatwo rozdzielić widelcem, a warzywa są miękkie'::text, true),
         (4::smallint, 'Dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz z białej fasoli, jarmużu i pomidorów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz z białej fasoli, jarmużu i pomidorów', 'Gęsty roślinny gulasz z białej fasoli, jarmużu i pomidorów, podany z pieczywem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 748, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Gulasz przechowuj w lodówce do 3 dni albo zamroź po całkowitym ostudzeniu. Pieczywo trzymaj osobno.',
  true, 'Za rzadki gulasz odparuj bez przykrycia lub rozgnieć część fasoli. Za kwaśny dodaj trochę marchewki i pogotuj.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Fasola biała z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'bez twardych łodyg', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Jarmuż, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Marchew pokrój w kostkę, cebulę i czosnek posiekaj, a z jarmużu usuń twarde łodygi.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 30 from przepisy p where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i marchew przez 5 minut. Dodaj czosnek i przyprawy.', null::text, false),
         (2::smallint, 'Dodaj pomidory, bulion i fasolę. Gotuj 20 minut na małym ogniu.', null::text, false),
         (3::smallint, 'Dodaj jarmuż i gotuj jeszcze 5 minut.', 'jarmuż jest miękki, a sos gęsty'::text, true),
         (4::smallint, 'Spróbuj, skoryguj sól oraz pieprz i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Jaglanka z gruszką i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jaglanka z gruszką i orzechami', 'Kremowa kasza jaglana na mleku z gruszką, cynamonem i orzechami włoskimi. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 432, 1,
  7, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Rondel', 'Sitko', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj trochę mleka.',
  false, 'Gorycz kaszy oznacza niedokładne wypłukanie — złagodź ją cynamonem i gruszką. Za gęstą jaglankę rozcieńcz mlekiem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jaglanka z gruszką i orzechami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jaglanka z gruszką i orzechami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'dokładnie wypłukana', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Kasza jaglana, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Gruszka ze skórką';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Cynamon mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Miód';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 7 from przepisy p where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kaszę płucz najpierw gorącą, potem zimną wodą. Gruszkę pokrój w kostkę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 18 from przepisy p where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kaszę zalej mlekiem, dodaj sól i gotuj na małym ogniu około 15 minut, często mieszając.', null::text, true),
         (2::smallint, 'Dodaj gruszkę i cynamon, gotuj jeszcze 2–3 minuty.', 'kasza jest miękka i kremowa'::text, false),
         (3::smallint, 'Podaj z miodem i orzechami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Jajecznica z pomidorem i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajecznica z pomidorem i szczypiorkiem', 'Kremowa jajecznica z pomidorem i świeżym szczypiorkiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajka na miękko z pieczywem i warzywami', 'Jajka z płynnym żółtkiem, podane z chlebem żytnim, pomidorem i ogórkiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
--  Kanapki z Goudą, jajkiem i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z Goudą, jajkiem i szczypiorkiem', 'Syte kanapki z serem Gouda, jajkiem na twardo, pomidorem i szczypiorkiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 286, 1,
  8, 9,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki zjedz od razu. Ugotowane jajko możesz przechować osobno w lodówce do następnego dnia.',
  false, 'Jeśli kanapki są suche, dodaj odrobinę jogurtu. Nie dosalaj przed spróbowaniem sera.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Ser Gouda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojone w plastry', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie jajka', 9 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajko ugotuj na twardo, schłodź, obierz i pokrój w plastry.', 'żółtko jest całkowicie ścięte'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 8 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pieczywo cienko posmaruj jogurtem.', null::text, false),
         (2::smallint, 'Ułóż Goudę, pomidora i jajko. Posyp szczypiorkiem i pieprzem.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z Goudą, pomidorem i sałatą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z Goudą, pomidorem i sałatą', 'Klasyczne kanapki z serem Gouda, pomidorem, ogórkiem i sałatą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 276, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki najlepiej zjedz od razu. Składniki przechowuj osobno w lodówce.',
  false, 'Jeśli pomidor jest bardzo soczysty, osusz plasterki. Za łagodny smak popraw musztardą i pieprzem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Ser Gouda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojone w plastry', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Sałata masłowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie kanapek', 7 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pomidora i ogórek pokrój w plastry, a sałatę umyj i osusz.', null::text, false),
         (2::smallint, 'Pieczywo cienko posmaruj musztardą.', null::text, false),
         (3::smallint, 'Ułóż sałatę, Goudę, pomidora i ogórek. Dopraw pieprzem.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kanapki z halloumi, awokado i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z halloumi, awokado i pomidorem', 'Kanapki z grillowanym halloumi, awokado, pomidorem i rukolą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 326, 1,
  8, 6,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki zjedz od razu. Składniki można przechować osobno w lodówce do następnego dnia.',
  false, 'Jeśli halloumi jest zbyt słone, nie dosalaj pozostałych składników. Twarde awokado pokrój w cienkie plastry.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z halloumi, awokado i pomidorem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z halloumi, awokado i pomidorem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojone w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Halloumi';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Awokado';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Rukola';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 8 from przepisy p where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Awokado i pomidora pokrój, a awokado skrop cytryną.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Grillowanie i składanie', 6 from przepisy p where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Halloumi smaż na suchej patelni po około 2 minuty z każdej strony.', 'ser jest złoty z zewnątrz'::text, true),
         (2::smallint, 'Na pieczywie ułóż rukolę, awokado, pomidora i ciepłe halloumi. Dopraw pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z jajkiem, awokado i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z jajkiem, awokado i pomidorem', 'Syte kanapki z jajkiem na twardo, kremowym awokado i świeżym pomidorem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z mozzarellą, pomidorem i bazylią', 'Kanapki z mozzarellą, świeżym pomidorem i bazylią, skropione oliwą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z pastą jajeczną', 'Kanapki z kremową pastą z jajek, jogurtu, musztardy i szczypiorku. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
--  Kanapki z ricottą, rzodkiewką i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Delikatne kanapki z ricottą, chrupiącą rzodkiewką i świeżym szczypiorkiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 251, 1,
  10, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Pastę z ricotty przechowuj w lodówce do 1 dnia. Pieczywo smaruj przed podaniem.',
  false, 'Jeśli ricotta jest zbyt gęsta, dodaj odrobinę jogurtu. Za łagodny smak popraw pieprzem i szczypiorkiem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Ser ricotta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'szt'::jednostka_miary, round((5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojona w cienkie plasterki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Rzodkiewka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie kanapek', 10 from przepisy p where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ricottę wymieszaj z jogurtem, szczypiorkiem, solą i pieprzem.', null::text, true),
         (2::smallint, 'Rzodkiewki pokrój w cienkie plasterki.', null::text, false),
         (3::smallint, 'Pieczywo posmaruj ricottą i ułóż na nim rzodkiewkę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kanapki z sardynkami, pomidorem i rukolą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z sardynkami, pomidorem i rukolą', 'Szybkie kanapki z sardynkami, pomidorem, rukolą i cytryną. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 356, 1,
  10, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki zjedz od razu. Otwarte sardynki przechowuj zgodnie z informacją na opakowaniu.',
  false, 'Jeśli pasta jest sucha, dodaj odrobinę oliwy. Zbyt intensywny smak sardynek złagodź pomidorem i cytryną.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'rozgniecione', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Sardynki w oliwie, odsączone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone w plastry', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Rukola';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie kanapek', 10 from przepisy p where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Sardynki rozgnieć widelcem z sokiem z cytryny, oliwą i pieprzem.', null::text, false),
         (2::smallint, 'Pomidora pokrój w plastry.', null::text, false),
         (3::smallint, 'Na chlebie rozłóż rukolę, pastę z sardynek i pomidora.', null::text, true),
         (4::smallint, 'Podaj bezpośrednio po przygotowaniu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kanapki z serem salami, ogórkiem kiszonym i musztardą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Wyraziste kanapki z serem salami, ogórkiem kiszonym, musztardą i czerwoną cebulą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 271, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kanapki zjedz bezpośrednio po przygotowaniu, aby pieczywo nie zmiękło.',
  false, 'Jeśli ogórek jest bardzo kwaśny lub słony, opłucz go i osusz. Nie dosalaj kanapek przed spróbowaniem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'Ser salami';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojone w plastry', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'ogórki kiszone bio';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'Sałata masłowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'cienko pokrojona', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie kanapek', 7 from przepisy p where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ogórka i cebulę cienko pokrój, a sałatę osusz.', null::text, false),
         (2::smallint, 'Pieczywo posmaruj musztardą.', null::text, false),
         (3::smallint, 'Ułóż sałatę, ser salami, ogórka i cebulę. Dopraw pieprzem.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Kałamarnica z papryką i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kałamarnica z papryką i ryżem', 'Krótko smażona kałamarnica z papryką, pomidorami i ziołami, podana z ryżem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 600, 1,
  12, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Odgrzewaj krótko, aby kałamarnica nie stwardniała.',
  false, 'Twardą kałamarnicę duś dalej w sosie około 25 minut. Wodnisty sos odparuj na dużym ogniu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kałamarnica z papryką i ryżem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kałamarnica z papryką i ryżem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'oczyszczona i pokrojona w krążki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Kałamarnica, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojona w paski', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona w piórka', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj. Kałamarnicę osusz, paprykę pokrój w paski, a cebulę w piórka.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 15 from przepisy p where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i paprykę przez 5 minut. Dodaj czosnek oraz wędzoną paprykę.', null::text, false),
         (2::smallint, 'Dodaj kałamarnicę i smaż na dużym ogniu 2–3 minuty.', 'krążki są nieprzezroczyste, ale nadal miękkie'::text, true),
         (3::smallint, 'Dodaj passatę, zagotuj i zdejmij z ognia. Dopraw cytryną oraz solą.', null::text, false),
         (4::smallint, 'Podaj z ryżem i natką pietruszki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Klopsiki z indyka w sosie pomidorowym z bulgurem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Delikatne klopsiki z indyka duszone w sosie pomidorowym, podane z kaszą bulgur. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 652, 1,
  15, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Klopsiki z sosem przechowuj w lodówce do 3 dni albo zamroź. Kaszę trzymaj osobno.',
  true, 'Jeśli klopsiki się rozpadają, dodaj trochę bułki tartej. Za kwaśny sos gotuj dłużej z odrobiną startej marchewki.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 170, 'g'::jednostka_miary, 170,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Mięso mielone z indyka, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Bułka tarta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'roztrzepane', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Formowanie klopsików', 15 from przepisy p where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mięso połącz z bułką tartą, jajkiem, połową cebuli, solą i pieprzem.', null::text, false),
         (2::smallint, 'Uformuj niewielkie, równe klopsiki.', null::text, true),
         (3::smallint, 'Kaszę bulgur ugotuj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i duszenie', 30 from przepisy p where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju obsmaż klopsiki ze wszystkich stron i przełóż je na bok.', null::text, false),
         (2::smallint, 'Na patelni zeszklij pozostałą cebulę, dodaj czosnek, passatę i przyprawy.', null::text, false),
         (3::smallint, 'Włóż klopsiki do sosu i duś pod przykryciem 15 minut.', 'klopsiki są całkowicie ścięte w środku'::text, false),
         (4::smallint, 'Podaj z kaszą bulgur.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Komosa ryżowa z ciecierzycą i pieczonymi warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Miska z komosą ryżową, ciecierzycą, cukinią, papryką i pomidorem, doprawiona cytryną. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz', 'z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 658, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli warzywa są wodniste, rozłóż je luźniej i dopiecz. Za suchą komosę skrop dodatkowym sokiem z cytryny.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Komosa ryżowa, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Cukinia, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Warzywa pokrój, a komosę dokładnie opłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 30 from przepisy p where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa i ciecierzycę wymieszaj z oliwą, oregano, solą oraz pieprzem. Piecz 25 minut.', 'warzywa są miękkie i rumiane na brzegach'::text, false),
         (2::smallint, 'Komosę ugotuj do miękkości i odstaw pod przykryciem na 5 minut.', 'ziarna są miękkie i sypkie'::text, false),
         (3::smallint, 'Połącz komosę z pieczonymi warzywami, sokiem z cytryny i natką.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kotleciki z czerwonej soczewicy z sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Rumiane kotleciki z czerwonej soczewicy i płatków owsianych, podane z ogórkowym sosem jogurtowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  2, 'prywatna',
  'waga', 407, 1,
  18, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Patelnia 28 cm', 'miska', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kotleciki przechowuj w lodówce do 2 dni. Sos trzymaj osobno.',
  true, 'Jeśli masa się rozpada, dodaj płatki owsiane i odczekaj 5 minut. Za gęsty sos rozrzedź wodą.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'starta', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'starty i odciśnięty', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie masy i sosu', 18 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Soczewicę ugotuj do miękkości i dokładnie odcedź.', null::text, false),
         (2::smallint, 'Połącz ją z marchewką, cebulą, czosnkiem, płatkami i przyprawami. Rozgnieć widelcem.', null::text, false),
         (3::smallint, 'Jogurt wymieszaj z ogórkiem, sokiem z cytryny i częścią soli.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 20 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Z masy uformuj małe, zwarte kotleciki.', null::text, true),
         (2::smallint, 'Smaż je na oleju po 4–5 minut z każdej strony.', 'kotleciki są rumiane i łatwo odchodzą od patelni'::text, false),
         (3::smallint, 'Podaj z sosem jogurtowym.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krem z brokułów z fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem z brokułów z fetą', 'Kremowa zupa brokułowa z ziemniakiem, jogurtem i fetą, podana z pieczywem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 771, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Jeśli planujesz mrożenie, odłóż porcję przed dodaniem jogurtu i fety; dodaj je dopiero po rozmrożeniu i podgrzaniu. Pieczywo trzymaj osobno.',
  true, 'Za gęsty krem rozcieńcz bulionem. Jeśli feta mocno zasoliła zupę, dodaj więcej brokułu lub ziemniaka.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krem z brokułów z fetą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krem z brokułów z fetą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Gałka muszkatołowa mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Krem z brokułów z fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Brokuł podziel na różyczki, ziemniaka pokrój, a cebulę i czosnek posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z brokułów z fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i blendowanie', 25 from przepisy p where lower(p.nazwa) = lower('Krem z brokułów z fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie zeszklij cebulę. Dodaj czosnek, ziemniaki i bulion; gotuj 12 minut.', null::text, false),
         (2::smallint, 'Dodaj brokuł i gotuj kolejne 7–8 minut.', 'brokuł i ziemniaki są miękkie'::text, false),
         (3::smallint, 'Zblenduj zupę, dodaj gałkę i pieprz. Jeśli część zupy mrozisz, odłóż ją teraz; do pozostałej po lekkim przestudzeniu wmieszaj jogurt.', null::text, true),
         (4::smallint, 'Podaj z pokruszoną fetą i pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z brokułów z fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krem z dyni na mleku kokosowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem z dyni na mleku kokosowym', 'Aromatyczny krem z dyni, czerwonej soczewicy, imbiru i mleka kokosowego. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 792, 1,
  12, 28,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź po całkowitym ostudzeniu.',
  true, 'Za gęsty krem rozcieńcz bulionem. Za ostry złagodź dodatkowym mlekiem kokosowym.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krem z dyni na mleku kokosowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krem z dyni na mleku kokosowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Dynia, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Dynię i marchew pokrój, cebulę, czosnek oraz imbir posiekaj, a soczewicę opłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i blendowanie', 28 from przepisy p where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju smaż cebulę 3 minuty. Dodaj czosnek, imbir i pastę curry.', null::text, false),
         (2::smallint, 'Dodaj dynię, marchew, soczewicę, bulion oraz wodę. Gotuj około 20 minut.', 'warzywa i soczewica są całkowicie miękkie'::text, false),
         (3::smallint, 'Dodaj mleko kokosowe i zblenduj na gładko.', null::text, true),
         (4::smallint, 'Dopraw limonką i solą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krem z kalafiora z pieczoną ciecierzycą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem z kalafiora z pieczoną ciecierzycą', 'Krem z kalafiora i ziemniaka podany z pieczoną ciecierzycą oraz pieczywem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 797, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Krem przechowuj w lodówce do 3 dni lub zamroź. Ciecierzycę i pieczywo trzymaj osobno.',
  true, 'Za rzadki krem gotuj chwilę bez przykrycia. Miękką ciecierzycę dopiecz w wyższej temperaturze.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Kalafior, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'dokładnie osuszona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Kalafior podziel na różyczki, ziemniaka pokrój, cebulę posiekaj.', null::text, false),
         (2::smallint, 'Ciecierzycę wymieszaj z połową oliwy, kminem i wędzoną papryką.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i pieczenie', 30 from przepisy p where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ciecierzycę piecz około 25 minut, mieszając w połowie.', 'jest sucha i chrupiąca'::text, false),
         (2::smallint, 'Na pozostałej oliwie zeszklij cebulę, dodaj czosnek, ziemniaki, kalafior i bulion. Gotuj 20 minut.', null::text, false),
         (3::smallint, 'Zblenduj zupę i dopraw.', null::text, true),
         (4::smallint, 'Podaj krem z pieczoną ciecierzycą i pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krewetki z czosnkiem, cukinią i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krewetki z czosnkiem, cukinią i ryżem', 'Krewetki smażone z czosnkiem, cukinią, chili i cytryną, podane z ryżem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 442, 1,
  10, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Podgrzewaj bardzo krótko.',
  false, 'Gumowate krewetki były smażone za długo. Jeśli cukinia puściła wodę, zwiększ ogień i szybko ją odparuj.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'obrane i osuszone', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Krewetki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojona w półplasterki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Cukinia, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Ryż jaśminowy, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Chili suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj. Krewetki dokładnie osusz, a cukinię pokrój.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 15 from przepisy p where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na połowie oliwy smaż cukinię na dużym ogniu przez 4–5 minut. Przełóż ją na bok.', null::text, false),
         (2::smallint, 'Dodaj resztę oliwy, czosnek, chili i krewetki. Smaż 2–3 minuty.', 'krewetki są różowe i sprężyste'::text, true),
         (3::smallint, 'Dodaj cukinię, sok z cytryny, sól oraz natkę. Wymieszaj i podaj z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Królik z rozmarynem i warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Królik z rozmarynem i warzywami korzeniowymi', 'Królik pieczony z ziemniakami, marchewką, pasternakiem, selerem i rozmarynem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 732, 1,
  18, 70,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 3 dni.',
  true, 'Jeśli mięso jest twarde, przykryj naczynie i piecz dłużej z dodatkiem bulionu. Suche mięso polej płynem z pieczenia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Królik, mięso surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Rozmaryn świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 18 from przepisy p where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 190°C. Warzywa pokrój na podobnej wielkości kawałki.', null::text, false),
         (2::smallint, 'Królika natrzyj oliwą, czosnkiem, rozmarynem, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 70 from przepisy p where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Królika i warzywa ułóż w naczyniu, wlej bulion i przykryj.', null::text, false),
         (2::smallint, 'Piecz 50 minut, następnie odkryj i piecz jeszcze około 20 minut.', 'mięso jest miękkie i łatwo odchodzi od kości'::text, true),
         (3::smallint, 'Przed podaniem polej mięso płynem z pieczenia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kurczak pieczony z batatem i brokułem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kurczak pieczony z batatem i brokułem', 'Pierś kurczaka pieczona na jednej blasze z batatem, brokułem i czerwoną cebulą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 709, 1,
  12, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 3 dni.',
  false, 'Jeśli kurczak jest suchy, pokrój go i podaj z jogurtem. Twardego batata dopiekaj osobno.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kurczak pieczony z batatem i brokułem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kurczak pieczony z batatem i brokułem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Batat, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Batata pokrój w małą kostkę, brokuł podziel, a cebulę pokrój.', null::text, false),
         (2::smallint, 'Warzywa wymieszaj z połową oliwy i przyprawami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 35 from przepisy p where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Batata i cebulę piecz 15 minut. Następnie dodaj brokuł.', null::text, false),
         (2::smallint, 'Kurczaka natrzyj pozostałą oliwą, czosnkiem, solą i pieprzem. Ułóż na blasze.', null::text, true),
         (3::smallint, 'Piecz jeszcze około 18–20 minut.', 'kurczak jest całkowicie ścięty, ale soczysty'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron pełnoziarnisty z bolońskim sosem z soczewicy
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Pełnoziarnisty makaron z gęstym pomidorowym sosem z czerwonej soczewicy i warzyw. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 711, 1,
  10, 28,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Garnek 2 l', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Sos przechowuj w lodówce do 3 dni lub zamroź. Makaron najlepiej ugotować świeży.',
  true, 'Za kwaśny sos złagodź dłuższym gotowaniem i dodatkową marchewką. Za gęsty rozcieńcz wodą z makaronu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'starta', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Bazylia suszona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Marchew zetrzyj, a cebulę i czosnek posiekaj. Soczewicę opłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 28 from przepisy p where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i marchew 5 minut. Dodaj czosnek oraz przyprawy.', null::text, false),
         (2::smallint, 'Dodaj passatę, soczewicę i 150 ml wody. Gotuj około 20 minut.', 'soczewica jest miękka, a sos gęsty'::text, true),
         (3::smallint, 'Makaron ugotuj al dente i połącz z sosem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z brokułem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z brokułem i fetą', 'Pełnoziarnisty makaron z brokułem, fetą, czosnkiem i cytryną. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 406, 1,
  8, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni.',
  false, 'Twardy brokuł gotuj minutę dłużej. Za słone danie złagodź dodatkowym makaronem lub brokułem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z brokułem i fetą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z brokułem i fetą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'podzielony na małe różyczki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Papryka ostra mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie', 18 from przepisy p where lower(p.nazwa) = lower('Makaron z brokułem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron gotuj zgodnie z instrukcją. Na 4 minuty przed końcem dodaj do garnka brokuł.', null::text, false),
         (2::smallint, 'Odcedź, zachowując niewielką ilość wody z gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie', 8 from przepisy p where lower(p.nazwa) = lower('Makaron z brokułem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie krótko podgrzej czosnek i ostrą paprykę.', null::text, false),
         (2::smallint, 'Dodaj makaron z brokułem, fetę, cytrynę i odrobinę wody z gotowania.', null::text, true),
         (3::smallint, 'Wymieszaj i dopraw pieprzem.', 'feta częściowo się rozpuszcza i tworzy lekki sos'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z ciecierzycą, bazylią i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z ciecierzycą, bazylią i orzechami', 'Pełnoziarnisty makaron z ciecierzycą i szybkim sosem z bazylii, orzechów oraz oliwy. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 396, 1,
  10, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj odrobinę wody.',
  false, 'Za gęsty sos rozcieńcz wodą z makaronu. Gorycz bazylii złagodź odrobiną cytryny.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 12, 'g'::jednostka_miary, 12,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente. Zachowaj część wody z gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sosu', 10 from przepisy p where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Bazylię, orzechy, oliwę, czosnek, cytrynę, sól i pieprz zblenduj z niewielką ilością wody z makaronu.', null::text, false),
         (2::smallint, 'Makaron połącz z sosem, ciecierzycą i pomidorem.', null::text, true),
         (3::smallint, 'Podgrzewaj krótko, tylko do połączenia smaków.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z indykiem, pieczarkami i jogurtem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z indykiem, pieczarkami i jogurtem', 'Pełnoziarnisty makaron z indykiem i pieczarkami w lekkim sosie jogurtowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 561, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj łagodnie, aby jogurt się nie zwarzył.',
  false, 'Jeśli sos się zwarzył, zdejmij patelnię z ognia i energicznie wymieszaj z łyżką zimnego jogurtu. Za gęsty sos rozcieńcz wodą z makaronu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojona w paski', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Pierś z indyka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojone w plasterki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente. Indyka pokrój w paski, pieczarki w plasterki, a cebulę posiekaj.', null::text, false),
         (2::smallint, 'Jogurt zahartuj dwiema łyżkami ciepłej wody z makaronu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju smaż indyka 5 minut. Dodaj cebulę, pieczarki, czosnek i tymianek.', null::text, false),
         (2::smallint, 'Smaż, aż odparuje woda z pieczarek, a indyk będzie gotowy.', 'mięso jest całkowicie ścięte'::text, true),
         (3::smallint, 'Zmniejsz ogień, dodaj makaron i jogurt. Wymieszaj bez zagotowywania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z kurczakiem, szpinakiem i pomidorami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z kurczakiem, szpinakiem i pomidorami', 'Pełnoziarnisty makaron z kurczakiem, szpinakiem i pomidorowym sosem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 642, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli sos jest zbyt gęsty, dodaj wodę z gotowania makaronu. Suchego kurczaka pokrój drobniej i wymieszaj z sosem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojona w paski', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Bazylia suszona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente. Kurczaka pokrój w paski, a cebulę i czosnek posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sosu', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie obsmaż kurczaka przez 5–6 minut. Dodaj cebulę i czosnek.', null::text, false),
         (2::smallint, 'Dodaj pomidory, passatę oraz zioła i gotuj 8 minut.', null::text, false),
         (3::smallint, 'Dodaj szpinak i ugotowany makaron. Wymieszaj i dopraw.', 'kurczak jest ścięty w środku, a szpinak zwiędł'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z pieczonymi warzywami i mozzarellą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z pieczonymi warzywami i mozzarellą', 'Pełnoziarnisty makaron z pieczoną cukinią, papryką, pomidorem i mozzarellą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 625, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni.',
  false, 'Jeśli warzywa puściły wodę, dopiekaj je kilka minut na wyższej temperaturze. Za suchy makaron skrop oliwą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 90, 'g'::jednostka_miary, 90,
       'porwany na kawałki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Cukinia, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Papryka żółta, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Pieczenie warzyw', 30 from przepisy p where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Warzywa pokrój i wymieszaj z oliwą, oregano, solą oraz pieprzem.', null::text, false),
         (2::smallint, 'Piecz warzywa około 25 minut.', 'są miękkie i lekko zrumienione'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie makaronu', 12 from przepisy p where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente i odcedź.', null::text, false),
         (2::smallint, 'Gorący makaron połącz z warzywami i mozzarellą.', null::text, true),
         (3::smallint, 'Dodaj świeżą bazylię i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z polędwiczką i pieczarkami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z polędwiczką i pieczarkami', 'Pełnoziarnisty makaron z polędwiczką wieprzową i pieczarkami w lekkim sosie jogurtowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 556, 1,
  12, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj na małym ogniu.',
  false, 'Twarde mięso pokrój cieniej i duś chwilę w sosie. Zwarzony jogurt wyrównaj energicznym mieszaniem po zdjęciu z ognia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z polędwiczką i pieczarkami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z polędwiczką i pieczarkami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojona w cienkie paski', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojone w plasterki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente. Mięso pokrój w cienkie paski, a pieczarki w plasterki.', null::text, false),
         (2::smallint, 'Jogurt wymieszaj z musztardą i odrobiną ciepłej wody z makaronu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na mocno rozgrzanym oleju smaż mięso 3–4 minuty. Odłóż je na bok.', null::text, false),
         (2::smallint, 'Na tej samej patelni smaż cebulę i pieczarki, aż odparuje woda. Dodaj czosnek i tymianek.', null::text, false),
         (3::smallint, 'Zmniejsz ogień, dodaj mięso, makaron i sos jogurtowy. Wymieszaj bez gotowania.', 'mięso jest soczyste, a sos gładki'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z ricottą i szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z ricottą i szpinakiem', 'Szybki pełnoziarnisty makaron z kremową ricottą, szpinakiem, czosnkiem i cytryną. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 355, 1,
  7, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj odrobinę wody.',
  false, 'Za gęsty sos rozcieńcz wodą z makaronu. Jeśli ricotta jest mdła, dodaj cytrynę i pieprz.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z ricottą i szpinakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z ricottą i szpinakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Ser ricotta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Gałka muszkatołowa mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie makaronu', 15 from przepisy p where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente. Zachowaj trochę wody z gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sosu', 7 from przepisy p where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie krótko podsmaż czosnek, dodaj szpinak i poczekaj, aż zwiędnie.', null::text, false),
         (2::smallint, 'Dodaj ricottę, cytrynę, gałkę muszkatołową oraz niewielką ilość wody z makaronu.', null::text, false),
         (3::smallint, 'Dodaj makaron, dopraw i dokładnie wymieszaj.', 'sos równomiernie pokrywa makaron'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z tuńczykiem, cytryną i natką pietruszki
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z tuńczykiem, cytryną i natką pietruszki', 'Szybki pełnoziarnisty makaron z tuńczykiem, cytryną, czosnkiem i natką pietruszki. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 267, 1,
  7, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj niewielką ilość wody.',
  false, 'Za suchy makaron rozluźnij wodą z gotowania i oliwą. Zbyt kwaśny smak złagodź dodatkowym makaronem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Tuńczyk w wodzie, odsączony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Chili suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie makaronu', 15 from przepisy p where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente. Zachowaj około pół szklanki wody z gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie', 7 from przepisy p where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie krótko podgrzej czosnek i chili.', null::text, false),
         (2::smallint, 'Dodaj tuńczyka, makaron, sok z cytryny i część wody z gotowania.', null::text, true),
         (3::smallint, 'Wymieszaj, dopraw i posyp natką pietruszki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z wołowiną i sosem pomidorowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z wołowiną i sosem pomidorowym', 'Pełnoziarnisty makaron z mieloną wołowiną i warzywnym sosem pomidorowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 649, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Sos przechowuj w lodówce do 3 dni albo zamroź. Makaron najlepiej trzymaj osobno.',
  true, 'Jeśli sos jest tłusty, zbierz nadmiar tłuszczu. Za kwaśny sos złagodź marchewką i dłuższym gotowaniem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z wołowiną i sosem pomidorowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Makaron z wołowiną i sosem pomidorowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 85, 'g'::jednostka_miary, 85,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Wołowina mielona 5% tłuszczu, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'starta', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Bazylia suszona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Marchew zetrzyj, cebulę i czosnek posiekaj. Makaron ugotuj al dente.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie sosu', 30 from przepisy p where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i marchew 4 minuty. Dodaj wołowinę i rozdrobnij ją.', null::text, false),
         (2::smallint, 'Smaż, aż mięso straci surowy kolor. Dodaj czosnek, passatę i zioła.', null::text, true),
         (3::smallint, 'Gotuj sos 18–20 minut.', 'sos jest gęsty, a mięso całkowicie ścięte'::text, false),
         (4::smallint, 'Podaj z makaronem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Małże w pomidorowym bulionie
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Małże w pomidorowym bulionie', 'Małże gotowane w aromatycznym bulionie pomidorowym z czosnkiem, selerem naciowym i natką. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 677, 1,
  15, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie zjedz bezpośrednio po ugotowaniu. Nie przechowuj małży, które nie otworzyły się podczas gotowania.',
  false, 'Jeśli bulion jest zbyt kwaśny, dodaj nieco więcej bulionu warzywnego. Nieotwarte małże wyrzuć.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Małże w pomidorowym bulionie'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Małże w pomidorowym bulionie'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'oczyszczone', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Małże, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Domowy bulion warzywny';
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

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Małże w pomidorowym bulionie');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Małże dokładnie oczyść. Usuń sztuki pęknięte oraz takie, które nie zamykają się po dotknięciu.', null::text, true),
         (2::smallint, 'Cebulę, czosnek i seler naciowy posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Małże w pomidorowym bulionie');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i seler przez 4 minuty. Dodaj czosnek, pomidory oraz bulion.', null::text, false),
         (2::smallint, 'Doprowadź do wrzenia, dodaj małże i przykryj garnek.', null::text, false),
         (3::smallint, 'Gotuj 5–7 minut, potrząsając garnkiem.', 'muszle się otworzyły'::text, false),
         (4::smallint, 'Wyrzuć nieotwarte małże. Posyp natką i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Morszczuk w sosie pomidorowym z ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Morszczuk w sosie pomidorowym z ryżem', 'Morszczuk duszony w ziołowym sosie pomidorowym, podany z ryżem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 557, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Ryż trzymaj osobno.',
  false, 'Jeśli sos jest kwaśny, dodaj odrobinę startej marchewki. Jeśli ryba się rozpada, ogranicz mieszanie.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Morszczuk, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Ryż parboiled, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj. Cebulę i czosnek posiekaj, a rybę osusz i dopraw.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie', 25 from przepisy p where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie zeszklij cebulę. Dodaj czosnek, passatę, paprykę i oregano.', null::text, false),
         (2::smallint, 'Sos gotuj 10 minut, następnie włóż morszczuka.', null::text, false),
         (3::smallint, 'Duś pod przykryciem 8–10 minut.', 'ryba jest nieprzezroczysta i łatwo dzieli się na płatki'::text, true),
         (4::smallint, 'Posyp natką i podaj z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Nocna owsianka z bananem i chia
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Nocna owsianka z bananem i chia', 'Nocna owsianka z bananem, nasionami chia i masłem orzechowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 386, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj pod przykryciem w lodówce do 2 dni. Banana najlepiej dodaj przed jedzeniem.',
  false, 'Za gęstą owsiankę rozcieńcz mlekiem. Zbyt rzadka zgęstnieje po dodaniu chia i kolejnych 15 minutach chłodzenia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Nocna owsianka z bananem i chia'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Nocna owsianka z bananem i chia'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 55, 'g'::jednostka_miary, 55,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plasterki', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Banan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Nasiona chia';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Masło orzechowe bez cukru';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and sk.nazwa = 'Cynamon mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie wieczorem', 5 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Płatki wymieszaj z mlekiem, jogurtem, chia i cynamonem.', null::text, false),
         (2::smallint, 'Przykryj i wstaw do lodówki na co najmniej 6 godzin.', 'po schłodzeniu płatki są miękkie, a masa kremowa'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rano wymieszaj owsiankę. Dodaj plasterki banana i masło orzechowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Nocna owsianka z borówkami i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Nocna owsianka z borówkami i orzechami', 'Nocna owsianka z borówkami, jogurtem, chia i orzechami włoskimi. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 435, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj pod przykryciem w lodówce do 2 dni. Orzechy dodaj tuż przed jedzeniem.',
  false, 'Za gęstą owsiankę rozcieńcz mlekiem. Jeśli jest mało słodka, rozgnieć część borówek i wymieszaj.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Nocna owsianka z borówkami i orzechami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Nocna owsianka z borówkami i orzechami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 55, 'g'::jednostka_miary, 55,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and sk.nazwa = 'Płatki owsiane';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and sk.nazwa = 'Borówki amerykańskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and sk.nazwa = 'Nasiona chia';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'grubo posiekane', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and sk.nazwa = 'Orzechy włoskie';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie wieczorem', 5 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Płatki wymieszaj z mlekiem, jogurtem, chia i połową borówek.', null::text, false),
         (2::smallint, 'Przykryj i wstaw do lodówki na co najmniej 6 godzin.', 'po schłodzeniu płatki są miękkie, a masa zgęstniała'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Dodaj pozostałe borówki i orzechy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Omlet ze szpinakiem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Omlet ze szpinakiem i fetą', 'Delikatny omlet z liśćmi szpinaku i słoną fetą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Owsianka z jabłkiem, cynamonem i orzechami', 'Kremowa owsianka na mleku z jabłkiem, cynamonem i orzechami włoskimi. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
--  Papryka faszerowana soczewicą i kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Papryka faszerowana soczewicą i kaszą bulgur', 'Pieczona papryka wypełniona soczewicą, kaszą bulgur i pomidorowym farszem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 644, 1,
  15, 40,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w lodówce do 3 dni. Upieczoną paprykę można zamrozić.',
  true, 'Jeśli farsz jest suchy, dodaj passatę. Jeśli papryka pozostaje twarda, przykryj naczynie i piecz 10 minut dłużej.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'przekrojona wzdłuż i oczyszczona', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Soczewica brązowa, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie farszu', 15 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Soczewicę i bulgur ugotuj osobno do miękkości.', null::text, false),
         (2::smallint, 'Papryki przekrój wzdłuż i usuń gniazda nasienne.', null::text, false),
         (3::smallint, 'Na oliwie zeszklij cebulę i czosnek. Dodaj passatę, kmin, soczewicę, bulgur oraz przyprawy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 40 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Napełnij połówki papryki farszem i ułóż je w naczyniu żaroodpornym.', null::text, true),
         (2::smallint, 'Piecz w 190°C przez około 35–40 minut.', 'papryka jest miękka, a farsz gorący w środku'::text, false),
         (3::smallint, 'Przed podaniem posyp natką pietruszki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pełnoziarniste placuszki ze skyrem i owocami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pełnoziarniste placuszki ze skyrem i owocami', 'Pełnoziarniste placuszki podane ze skyrem i borówkami. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 521, 1,
  10, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Widelec', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Placuszki przechowuj w lodówce do 1 dnia. Skyr i owoce trzymaj osobno.',
  false, 'Jeśli ciasto jest za gęste, dolej mleka. Jeśli placuszki przywierają, patelnia jest za chłodna albo ma za mało oleju.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Mąka orkiszowa pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Skyr naturalny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Borówki amerykańskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Miód';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Cynamon mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie ciasta', 10 from przepisy p where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajko roztrzep z mlekiem. Dodaj mąkę i cynamon, a następnie wymieszaj na gładkie ciasto.', null::text, false),
         (2::smallint, 'Odstaw ciasto na 5 minut.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 15 from przepisy p where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Patelnię posmaruj olejem i smaż niewielkie placuszki na średnim ogniu.', null::text, false),
         (2::smallint, 'Odwracaj, gdy na powierzchni pojawią się pęcherzyki.', 'obie strony są złote'::text, true),
         (3::smallint, 'Podaj ze skyrem, borówkami i miodem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczona makrela z burakami i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczona makrela z burakami i ziemniakami', 'Pieczona makrela z burakami, ziemniakami, czerwoną cebulą i koperkiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 717, 1,
  15, 45,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Ze względu na intensywny aromat użyj szczelnego pojemnika.',
  false, 'Jeśli buraki są twarde, pokrój je drobniej i dopiecz bez ryby. Suchą makrelę skrop cytryną.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczona makrela z burakami i ziemniakami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczona makrela z burakami i ziemniakami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Makrela atlantycka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojone w małą kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Buraki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'pokrojone w małą kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 200°C. Buraki i ziemniaki pokrój w małą kostkę, cebulę w piórka.', null::text, false),
         (2::smallint, 'Warzywa wymieszaj z oliwą, solą oraz pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 45 from przepisy p where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa piecz 30 minut, mieszając je po 15 minutach.', null::text, false),
         (2::smallint, 'Dodaj makrelę, skrop ją cytryną i piecz jeszcze 12–15 minut.', 'mięso ryby łatwo odchodzi od ości'::text, true),
         (3::smallint, 'Przed podaniem posyp koperkiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczone warzywa korzeniowe z tymiankiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczone warzywa korzeniowe z tymiankiem', 'Mieszanka pieczonych ziemniaków, buraków, marchewki, pasternaku i selera z tymiankiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['dodatek']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 343, 1,
  15, 40,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Odgrzewaj w piekarniku lub na patelni.',
  true, 'Jeśli warzywa są blade i miękkie, rozłóż je luźniej i zwiększ temperaturę. Twarde kawałki pokrój drobniej i dopiecz.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Buraki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Rozmaryn suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Warzywa pokrój na podobnej wielkości kawałki.', null::text, false),
         (2::smallint, 'Wymieszaj je z oliwą, tymiankiem, rozmarynem, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 40 from przepisy p where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa rozłóż luźno na blasze i piecz około 40 minut.', null::text, false),
         (2::smallint, 'Po 20 minutach dokładnie je przemieszaj i piecz dalej do końca podanego czasu.', 'warzywa są miękkie w środku i rumiane na brzegach'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony bakłażan z ciecierzycą i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony bakłażan z ciecierzycą i fetą', 'Pieczony bakłażan z ciecierzycą, pomidorami, fetą i kaszą bulgur. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 728, 1,
  12, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli bakłażan jest twardy, piecz go dłużej pod przykryciem. Za słone danie złagodź dodatkową porcją pomidorów.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Bakłażan, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona w piórka', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Bakłażana i pomidora pokrój, a cebulę pokrój w piórka.', null::text, false),
         (2::smallint, 'Kaszę bulgur ugotuj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 35 from przepisy p where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Bakłażana, cebulę i ciecierzycę wymieszaj w naczyniu z oliwą, czosnkiem, oregano, solą i pieprzem.', null::text, false),
         (2::smallint, 'Piecz 25 minut, następnie dodaj pomidora i fetę.', null::text, true),
         (3::smallint, 'Piecz jeszcze 8–10 minut.', 'bakłażan jest miękki, a feta lekko zrumieniona'::text, false),
         (4::smallint, 'Podaj z kaszą bulgur.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony kalafior z ziołowym sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony kalafior z ziołowym sosem jogurtowym', 'Rumiany pieczony kalafior podany z lekkim sosem jogurtowym, cytryną i natką pietruszki. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['dodatek']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 372, 1,
  10, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kalafior i sos przechowuj osobno w lodówce do 2 dni.',
  false, 'Jeśli kalafior jest miękki, ale blady, dopiecz go kilka minut w wyższej temperaturze. Za gęsty sos rozcieńcz wodą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Kalafior, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Pieczenie kalafiora', 30 from przepisy p where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 220°C. Kalafior wymieszaj z oliwą, kminem, papryką, solą i pieprzem.', null::text, false),
         (2::smallint, 'Rozłóż różyczki w jednej warstwie i piecz około 25–30 minut.', 'brzegi są mocno zrumienione, a środek miękki'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sosu', 5 from przepisy p where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jogurt wymieszaj z cytryną, czosnkiem i natką.', null::text, false),
         (2::smallint, 'Podaj sos obok gorącego kalafiora.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony łosoś z brokułem i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony łosoś z brokułem i ziemniakami', 'Łosoś pieczony na jednej blasze z brokułem i ziemniakami, doprawiony cytryną oraz czosnkiem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 668, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli łosoś jest suchy, podaj go z jogurtem i cytryną. Twarde ziemniaki dopiekaj osobno jeszcze kilka minut.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Łosoś dziki, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'pokrojone w małe cząstki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok i cząstki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 210°C. Ziemniaki pokrój w małe cząstki, a brokuł podziel na różyczki.', null::text, false),
         (2::smallint, 'Ziemniaki wymieszaj z połową oliwy, tymiankiem i częścią soli.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 30 from przepisy p where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ziemniaki piecz 15 minut. Następnie dodaj brokuł i piecz kolejne 5 minut.', null::text, false),
         (2::smallint, 'Na blasze ułóż łososia. Skrop wszystko pozostałą oliwą i cytryną, dodaj czosnek, sól oraz pieprz.', null::text, true),
         (3::smallint, 'Piecz jeszcze 10–12 minut.', 'łosoś łatwo rozdziela się widelcem, ale pozostaje soczysty'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pierś z kaczki z pomarańczą i czerwoną kapustą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Pierś z kaczki z duszoną czerwoną kapustą, jabłkiem, pomarańczą i ziemniakami. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  2, 'prywatna',
  'waga', 728, 1,
  15, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Kaczkę odgrzewaj krótko, aby jej nie wysuszyć.',
  false, 'Jeśli mięso jest przesmażone, pokrój je cienko i podaj z większą ilością sosu. Za kwaśną kapustę złagodź jabłkiem.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Kaczka, pierś bez skóry, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'cienko poszatkowana', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Kapusta czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'sok i cząstki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Pomarańcza';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Jabłko ze skórką';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Ocet jabłkowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Cynamon mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Goździki suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kapustę poszatkuj, ziemniaki przygotuj do gotowania, jabłko pokrój, cebulę posiekaj, a z pomarańczy wyciśnij sok.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie dodatków', 25 from przepisy p where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ziemniaki gotuj w garnku około 15–20 minut.', 'są miękkie po nakłuciu widelcem'::text, false),
         (2::smallint, 'W drugim garnku na oleju zeszklij cebulę. Dodaj kapustę, jabłko, połowę soku, ocet i przyprawy. Duś około 25 minut.', 'kapusta jest miękka, ale nie rozpada się'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Smażenie kaczki', 15 from przepisy p where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pierś z kaczki osusz i dopraw solą oraz pieprzem.', null::text, false),
         (2::smallint, 'Smaż na średnim ogniu po 3–4 minuty z każdej strony, zależnie od grubości.', 'mięso jest sprężyste, a środek pozostaje soczysty'::text, true),
         (3::smallint, 'Odstaw mięso na 5 minut. Patelnię zdeglasuj pozostałym sokiem pomarańczowym.', null::text, false),
         (4::smallint, 'Kaczkę pokrój i podaj z kapustą, sosem pomarańczowym oraz ziemniakami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Placuszki bananowo-owsiane
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Placuszki bananowo-owsiane', 'Miękkie placuszki z banana, jajka i mąki owsianej, podane z jogurtem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 381, 1,
  8, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Widelec', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Placuszki przechowuj w lodówce do 1 dnia. Jogurt trzymaj osobno.',
  false, 'Jeśli placuszki się rozpadają, dodaj odrobinę mąki. Jeśli zbyt szybko ciemnieją, zmniejsz ogień.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Placuszki bananowo-owsiane'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Placuszki bananowo-owsiane'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'bardzo dojrzały', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Banan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Mąka owsiana pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Cynamon mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie ciasta', 8 from przepisy p where lower(p.nazwa) = lower('Placuszki bananowo-owsiane');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Banana dokładnie rozgnieć widelcem.', null::text, false),
         (2::smallint, 'Dodaj jajko, mleko, mąkę i cynamon. Wymieszaj na jednolitą masę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 12 from przepisy p where lower(p.nazwa) = lower('Placuszki bananowo-owsiane');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Patelnię lekko posmaruj olejem. Nakładaj małe porcje ciasta.', null::text, false),
         (2::smallint, 'Smaż po około 2 minuty z każdej strony.', 'na powierzchni pojawiają się pęcherzyki, a spód jest rumiany'::text, true),
         (3::smallint, 'Podaj z jogurtem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Polędwiczka w sosie musztardowym z kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa w lekkim sosie musztardowo-jogurtowym z pieczarkami i kaszą bulgur. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 656, 1,
  12, 23,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj na małym ogniu.',
  false, 'Twardą polędwiczkę pokrój cieniej i duś chwilę w sosie. Za ostry sos złagodź jogurtem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Domowy bulion warzywny';
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kaszę bulgur ugotuj. Polędwiczkę pokrój w plastry, pieczarki pokrój, a cebulę posiekaj.', null::text, false),
         (2::smallint, 'Jogurt wymieszaj z musztardą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i sos', 23 from przepisy p where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na mocno rozgrzanym oleju smaż mięso partiami po około 2 minuty z każdej strony. Odłóż.', null::text, false),
         (2::smallint, 'Na patelni smaż cebulę i pieczarki, aż odparuje woda. Dodaj bulion i tymianek.', null::text, false),
         (3::smallint, 'Zmniejsz ogień, dodaj mięso oraz jogurt z musztardą. Podgrzej bez zagotowywania.', 'mięso jest soczyste, a sos gładki'::text, true),
         (4::smallint, 'Podaj z kaszą bulgur.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Potrawka z kurczaka, kaszy jęczmiennej i warzyw
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Jednogarnkowa potrawka z kurczaka, kaszy jęczmiennej, marchewki, pora i groszku. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 738, 1,
  12, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Potrawkę można zamrozić.',
  true, 'Za gęstą potrawkę rozcieńcz bulionem. Jeśli kasza jest twarda, gotuj dłużej i uzupełnij płyn.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Udo z kurczaka bez skóry, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Kasza jęczmienna, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Groszek zielony mrożony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Seler naciowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kurczaka i warzywa pokrój, a kaszę opłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 35 from przepisy p where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju obsmaż kurczaka, aż straci surowy kolor. Dodaj por, marchew i seler.', null::text, false),
         (2::smallint, 'Wsyp kaszę, dodaj bulion i tymianek. Gotuj pod przykryciem 25 minut.', null::text, false),
         (3::smallint, 'Dodaj groszek i gotuj jeszcze 5 minut.', 'kasza i mięso są miękkie, a płyn częściowo wchłonięty'::text, true),
         (4::smallint, 'Dopraw solą oraz pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pstrąg pieczony z warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pstrąg pieczony z warzywami korzeniowymi', 'Pstrąg pieczony z ziemniakami, marchewką, pasternakiem i selerem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 673, 1,
  15, 40,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Gotowe danie przechowuj w lodówce do 2 dni.',
  false, 'Jeśli warzywa są twarde, zdejmij rybę i dopiekaj warzywa osobno. Suchą rybę skrop cytryną i oliwą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Pstrąg tęczowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojone w cząstki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Rozmaryn suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 200°C. Warzywa pokrój na podobnej wielkości kawałki.', null::text, false),
         (2::smallint, 'Warzywa wymieszaj z oliwą, rozmarynem, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 40 from przepisy p where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa piecz 20 minut, następnie przesuń je na boki i dodaj pstrąga.', null::text, false),
         (2::smallint, 'Rybę skrop cytryną i lekko dopraw.', null::text, true),
         (3::smallint, 'Piecz jeszcze około 18–20 minut.', 'mięso ryby jest nieprzezroczyste i łatwo odchodzi od ości'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pudding chia z mango i mlekiem kokosowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pudding chia z mango i mlekiem kokosowym', 'Wegański pudding chia na mleku kokosowym z mango, migdałami i daktylami. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 435, 1,
  8, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj pod przykryciem w lodówce do 2 dni. Migdały dodaj przed jedzeniem.',
  false, 'Jeśli pudding jest zbyt rzadki, dodaj łyżeczkę chia i odstaw na 20 minut. Za gęsty rozcieńcz mlekiem kokosowym.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pudding chia z mango i mlekiem kokosowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pudding chia z mango i mlekiem kokosowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and sk.nazwa = 'Nasiona chia';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and sk.nazwa = 'Mango';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'posiekane', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and sk.nazwa = 'Migdały';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'drobno posiekane', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and sk.nazwa = 'Daktyle suszone';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 6 from przepisy p where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Chia wymieszaj z mlekiem kokosowym i daktylami.', null::text, false),
         (2::smallint, 'Po 10 minutach wymieszaj ponownie, przykryj i wstaw do lodówki na co najmniej 4 godziny.', 'po schłodzeniu pudding jest gęsty, a nasiona równomiernie rozłożone'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Dodaj mango i posyp migdałami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Ryż z pieczarkami, szpinakiem i parmezanem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Ryż z pieczarkami, szpinakiem i parmezanem', 'Kremowy ryż z pieczarkami, szpinakiem i parmezanem przygotowany w jednym garnku. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 739, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj z niewielką ilością wody.',
  false, 'Za suchy ryż podlej gorącym bulionem. Jeśli ryż jest twardy, gotuj dłużej na małym ogniu.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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
       'drobno starty; wybierz wersję z podpuszczką mikrobiologiczną', null, sk.rola, sk.mozna_dzielic, 4
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
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       'gorący', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Pieczarki pokrój w plasterki, a cebulę i czosnek posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 25 from przepisy p where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i pieczarki, aż odparuje większość wody.', null::text, false),
         (2::smallint, 'Dodaj czosnek i ryż, wymieszaj, a następnie stopniowo wlewaj gorący bulion.', null::text, true),
         (3::smallint, 'Gotuj na małym ogniu do miękkości ryżu. Dodaj szpinak i parmezan.', 'ryż jest miękki i kremowy'::text, false),
         (4::smallint, 'Dopraw solą oraz pieprzem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka brokułowa z jajkiem i sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Sałatka z brokułem, jajkami na twardo, kukurydzą i szczypiorkiem w sosie jogurtowo-musztardowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 586, 1,
  12, 10,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli brokuł jest rozgotowany, ostudź go szybko i delikatnie mieszaj. Za gęsty sos rozcieńcz wodą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Kukurydza konserwowa, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka ugotuj na twardo, schłodź i obierz.', null::text, false),
         (2::smallint, 'Brokuł gotuj 4–5 minut, aby pozostał lekko jędrny, następnie ostudź.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sałatki', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka pokrój. Jogurt wymieszaj z musztardą, solą i pieprzem.', null::text, false),
         (2::smallint, 'Połącz brokuł, jajka, kukurydzę, cebulę i sos.', null::text, true),
         (3::smallint, 'Posyp szczypiorkiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka makaronowa z mozzarellą i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka makaronowa z mozzarellą i warzywami', 'Sałatka z pełnoziarnistym makaronem, mozzarellą, pomidorem, ogórkiem, papryką i bazylią. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 559, 1,
  12, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Sitko', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Oliwę najlepiej dodaj przed jedzeniem.',
  false, 'Jeśli sałatka puściła wodę, odlej płyn i dopraw ponownie. Za suchą sałatkę skrop dodatkową oliwą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 90, 'g'::jednostka_miary, 90,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Oliwki czarne';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie makaronu', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente, odcedź i całkowicie ostudź.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sałatki', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Mozzarellę i warzywa pokrój na podobnej wielkości kawałki.', null::text, false),
         (2::smallint, 'Połącz makaron, mozzarellę, warzywa, oliwki i bazylię.', null::text, false),
         (3::smallint, 'Skrop oliwą oraz cytryną, dopraw i wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka makaronowa z tuńczykiem i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka makaronowa z tuńczykiem i warzywami', 'Sałatka z pełnoziarnistym makaronem, tuńczykiem, pomidorem, ogórkiem i kukurydzą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 576, 1,
  12, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Sitko', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli sałatka jest sucha, dodaj trochę jogurtu. Jeśli puściła wodę, odlej płyn i dopraw ponownie.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Makaron pełnoziarnisty, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Tuńczyk w wodzie, odsączony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Kukurydza konserwowa, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie makaronu', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Makaron ugotuj al dente, odcedź i całkowicie ostudź.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie sałatki', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ogórek i pomidora pokrój. Jogurt wymieszaj z musztardą, solą oraz pieprzem.', null::text, false),
         (2::smallint, 'Połącz makaron z tuńczykiem, warzywami, kukurydzą i sosem.', null::text, true),
         (3::smallint, 'Posyp szczypiorkiem i podaj lub schłodź.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka z czarnej fasoli, kukurydzy i pomidora
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kolorowa sałatka z czarnej fasoli, kukurydzy, pomidora, papryki i awokado. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 632, 1,
  15, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Awokado najlepiej dodaj przed jedzeniem.',
  false, 'Jeśli sałatka puściła wodę, odlej płyn. Za kwaśny dressing złagodź większą ilością awokado.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Fasola czarna z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Kukurydza konserwowa, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Awokado';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Kolendra świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa i awokado pokrój, a kolendrę posiekaj.', null::text, false),
         (2::smallint, 'Limonkę wymieszaj z oliwą, kminem i solą.', null::text, false),
         (3::smallint, 'Połącz fasolę, kukurydzę, warzywa i dressing.', null::text, true),
         (4::smallint, 'Dodaj awokado oraz kolendrę i delikatnie wymieszaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Sałatka z jajkiem, fetą i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z jajkiem, fetą i warzywami', 'Sałatka z jajkami na twardo, fetą, pomidorem, ogórkiem i sałatą, skropiona oliwą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
--  Sałatka z jarmużu, jabłka i orzechów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z jarmużu, jabłka i orzechów', 'Chrupiąca sałatka z jarmużu, jabłka, pomarańczy i orzechów w cytrynowo-musztardowym dressingu. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 406, 1,
  15, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Orzechy dodaj przed podaniem.',
  false, 'Twardy jarmuż masuj dłużej z dressingiem. Zbyt kwaśny sos złagodź sokiem z pomarańczy.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'bez twardych łodyg', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Jarmuż, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Jabłko ze skórką';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'cząstki i sok', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Pomarańcza';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25,
       'posiekane', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 15 from przepisy p where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Usuń twarde łodygi jarmużu i porwij liście. Jabłko pokrój, a pomarańczę podziel na cząstki.', null::text, false),
         (2::smallint, 'Oliwę wymieszaj z cytryną, sokiem z pomarańczy, musztardą, solą i pieprzem.', null::text, false),
         (3::smallint, 'Jarmuż masuj z dressingiem przez 2–3 minuty.', 'liście stają się ciemniejsze i delikatniejsze'::text, true),
         (4::smallint, 'Dodaj owoce i orzechy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Sałatka z komosy, buraka i koziego sera
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z komosy, buraka i koziego sera', 'Sałatka z komosy ryżowej, pieczonego buraka, koziego sera, rukoli i orzechów. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 502, 1,
  12, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 2 l', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Rukolę i dressing najlepiej trzymaj osobno.',
  false, 'Jeśli burak pozostaje twardy, pokrój go drobniej i dopiecz. Za słony ser zrównoważ dodatkową komosą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z komosy, buraka i koziego sera'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z komosy, buraka i koziego sera'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Komosa ryżowa, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Buraki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Ser kozi miękki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Rukola';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Jabłko ze skórką';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Ocet winny czerwony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Pieczenie i gotowanie', 35 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 200°C. Buraka wymieszaj z połową oliwy i tymiankiem, piecz około 30 minut.', null::text, false),
         (2::smallint, 'Komosę opłucz, ugotuj i ostudź.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie sałatki', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Połącz komosę, buraka, rukolę, jabłko i orzechy.', null::text, false),
         (2::smallint, 'Dodaj kozi ser. Skrop pozostałą oliwą i octem, dopraw i delikatnie wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka z pieczonym burakiem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z pieczonym burakiem i fetą', 'Sałatka z pieczonym burakiem, fetą, rukolą, orzechami i czerwoną cebulą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 432, 1,
  10, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Pieczone buraki przechowuj w lodówce do 2 dni. Rukolę i dressing dodaj przed jedzeniem.',
  false, 'Twardego buraka dopiecz pod przykryciem. Za słoną sałatkę zrównoważ większą ilością rukoli i buraka.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z pieczonym burakiem i fetą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z pieczonym burakiem i fetą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Buraki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Rukola';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'cienko pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Ocet winny czerwony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Pieczenie buraka', 35 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Piekarnik rozgrzej do 200°C. Buraka wymieszaj z połową oliwy i tymiankiem.', null::text, false),
         (2::smallint, 'Piecz około 30–35 minut, a następnie lekko ostudź.', 'burak jest miękki i lekko zrumieniony'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie sałatki', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Połącz rukolę, buraka, cebulę i orzechy.', null::text, false),
         (2::smallint, 'Dodaj fetę, pozostałą oliwę, ocet i pieprz. Delikatnie wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Serek wiejski z owocami i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Serek wiejski z owocami i orzechami', 'Serek wiejski z bananem, borówkami, orzechami i cynamonem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 361, 1,
  5, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Orzechy dodaj tuż przed jedzeniem.',
  false, 'Jeśli serek jest zbyt rzadki, odlej część płynu. Mało słodki smak popraw bardziej dojrzałym bananem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Serek wiejski z owocami i orzechami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Serek wiejski z owocami i orzechami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and sk.nazwa = 'Serek wiejski naturalny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plasterki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and sk.nazwa = 'Banan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and sk.nazwa = 'Borówki amerykańskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'grubo posiekane', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and sk.nazwa = 'Orzechy włoskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and sk.nazwa = 'Cynamon mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 5 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Banana pokrój w plasterki, a orzechy grubo posiekaj.', null::text, false),
         (2::smallint, 'Serek przełóż do miski i dodaj owoce.', null::text, false),
         (3::smallint, 'Posyp cynamonem i orzechami tuż przed podaniem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Serek wiejski z pomidorem, ogórkiem i pestkami dyni
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Serek wiejski ze świeżym pomidorem, chrupiącym ogórkiem i pestkami dyni. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
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
--  Skyr kakaowy z bananem i masłem orzechowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Skyr kakaowy z bananem i masłem orzechowym', 'Kakaowy skyr z bananem i masłem orzechowym, przygotowany bez gotowania. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 380, 1,
  5, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia.',
  false, 'Za gęsty skyr rozcieńcz mlekiem. Jeśli kakao jest zbyt gorzkie, wmieszaj część rozgniecionego banana.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and sk.nazwa = 'Skyr naturalny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'częściowo rozgnieciony', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and sk.nazwa = 'Banan';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and sk.nazwa = 'Kakao bez cukru, proszek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and sk.nazwa = 'Masło orzechowe bez cukru';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and sk.nazwa = 'Mleko 2%';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 5 from przepisy p where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Połowę banana rozgnieć, a połowę pokrój w plasterki.', null::text, false),
         (2::smallint, 'Skyr wymieszaj z kakao, mlekiem i rozgniecionym bananem.', null::text, true),
         (3::smallint, 'Dodaj masło orzechowe i plasterki banana.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and e.kolejnosc = 1;

-- -------------------------------------------------------------------------
--  Skyr z owocami, płatkami owsianymi i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Skyr z owocami, płatkami owsianymi i orzechami', 'Skyr z bananem, borówkami, płatkami owsianymi i orzechami włoskimi. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
--  Stek z tuńczyka z fasolką szparagową i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Krótko smażony stek z tuńczyka z fasolką szparagową i gotowanymi ziemniakami. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 642, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej zjedz od razu. Ewentualną pozostałość przechowuj w lodówce do 1 dnia.',
  false, 'Jeśli tuńczyk jest przesmażony, pokrój go cienko i skrop oliwą z cytryną. Twardą fasolkę gotuj dłużej.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Tuńczyk świeży, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Fasolka szparagowa, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie dodatków', 20 from przepisy p where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ziemniaki ugotuj do miękkości. Fasolkę ugotuj tak, aby pozostała lekko jędrna.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie tuńczyka', 10 from przepisy p where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Tuńczyka osusz, posmaruj połową oliwy i dopraw solą oraz pieprzem.', null::text, false),
         (2::smallint, 'Smaż na mocno rozgrzanej patelni około 2 minuty z każdej strony.', 'środek pozostaje różowy i soczysty'::text, true),
         (3::smallint, 'Pozostałą oliwę połącz z cytryną i czosnkiem. Polej nią fasolkę oraz ziemniaki i podaj z tuńczykiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tabbouleh z kaszy bulgur i ciecierzycy
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tabbouleh z kaszy bulgur i ciecierzycy', 'Świeża sałatka z kaszy bulgur, ciecierzycy, pomidora, ogórka, natki i mięty. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 546, 1,
  15, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Sitko', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni.',
  false, 'Jeśli sałatka puściła wodę, odlej ją i dodaj świeże zioła. Za suchą sałatkę skrop cytryną i oliwą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Kasza bulgur, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojony w kostkę', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 25, 'g'::jednostka_miary, 25,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Mięta świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Gotowanie kaszy', 12 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kaszę bulgur ugotuj, odcedź i całkowicie ostudź.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie sałatki', 15 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa pokrój w drobną kostkę, a zioła posiekaj.', null::text, false),
         (2::smallint, 'Połącz kaszę z ciecierzycą, warzywami i ziołami.', null::text, false),
         (3::smallint, 'Dodaj cytrynę, oliwę, sól oraz pieprz i wymieszaj.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tofu z brokułem i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tofu z brokułem i ryżem', 'Smażone tofu z brokułem, imbirem, czosnkiem i sezamem, podane z ryżem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 518, 1,
  12, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Tofu z brokułem i ryż przechowuj w lodówce do 2 dni. Odgrzewaj krótko na patelni.',
  false, 'Jeśli tofu nie rumieni się, osusz je i smaż partiami. Za słony sos złagodź niewielką ilością wody.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tofu z brokułem i ryżem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tofu z brokułem i ryżem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'osuszone i pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Tofu naturalne';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'podzielony na małe różyczki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Ryż jaśminowy, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'drobno starty', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Sezam';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Cebula dymka, surowa';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Tofu z brokułem i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj. Tofu dokładnie osusz i pokrój w kostkę.', null::text, false),
         (2::smallint, 'Brokuł podziel na małe różyczki, czosnek posiekaj, a imbir zetrzyj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Tofu z brokułem i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na połowie oleju smaż tofu przez 6–8 minut, obracając je, aż będzie rumiane. Przełóż je na bok.', 'kostki mają złote krawędzie'::text, false),
         (2::smallint, 'Dodaj resztę oleju i brokuł. Smaż 5 minut, następnie dodaj czosnek oraz imbir.', null::text, false),
         (3::smallint, 'Włóż tofu z powrotem, dodaj sos sojowy i wymieszaj.', null::text, true),
         (4::smallint, 'Podaj z ryżem, sezamem i cebulą dymką.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tofucznica ze szpinakiem i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tofucznica ze szpinakiem i pomidorem', 'Szybka tofucznica ze szpinakiem, pomidorem, cebulą i kurkumą, podana z pieczywem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 488, 1,
  7, 8,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej zjedz od razu. Pozostałość można przechować w lodówce do 1 dnia.',
  false, 'Jeśli tofucznica jest sucha, dodaj łyżkę wody. Jeżeli pomidor puścił dużo soku, smaż chwilę bez przykrycia.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tofucznica ze szpinakiem i pomidorem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tofucznica ze szpinakiem i pomidorem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'rozgniecione widelcem', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Tofu naturalne';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Kurkuma mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 7 from przepisy p where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Tofu rozgnieć widelcem. Pomidora pokrój w kostkę, a cebulę posiekaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 8 from przepisy p where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju smaż cebulę 2 minuty. Dodaj tofu, kurkumę, sól i pieprz.', null::text, false),
         (2::smallint, 'Dodaj pomidora i szpinak. Smaż, mieszając, jeszcze 4–5 minut.', 'szpinak zwiędł, a tofu jest gorące'::text, true),
         (3::smallint, 'Podaj bezpośrednio po przygotowaniu z kromkami chleba żytniego.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z Goudą, szpinakiem i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z Goudą, szpinakiem i pomidorem', 'Ciepła pełnoziarnista tortilla z roztopioną Goudą, szpinakiem i pomidorem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 336, 1,
  7, 8,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej zjedz od razu. Po przechowaniu tortilla straci chrupkość.',
  false, 'Jeśli tortilla pęka, ogrzej ją przed zwijaniem. Wodnisty farsz smaż chwilę dłużej przed dodaniem sera.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'drobno pokrojony', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Ser Gouda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie farszu', 7 from przepisy p where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju zeszklij cebulę, dodaj pomidora i szpinak. Smaż, aż odparuje nadmiar płynu.', 'szpinak jest zwiędnięty, a farsz nie jest wodnisty'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie i opiekanie', 8 from przepisy p where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na tortilli rozłóż farsz i Goudę, dodaj oregano oraz pieprz.', null::text, true),
         (2::smallint, 'Zawiń tortillę i opiekaj na suchej patelni po 2–3 minuty z każdej strony.', 'tortilla jest rumiana, a ser roztopiony'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z hummusem i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z hummusem i warzywami', 'Pełnoziarnista tortilla z domowym hummusem, pomidorem, ogórkiem i sałatą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 475, 1,
  15, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Blender ręczny', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Hummus przechowuj w lodówce do 2 dni. Tortillę złóż bezpośrednio przed jedzeniem.',
  false, 'Za gęsty hummus rozcieńcz wodą. Jeśli tortilla mięknie, osusz warzywa i składaj ją tuż przed podaniem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z hummusem i warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z hummusem i warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Sezam';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'sok', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Sałata rzymska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Sól kuchenna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie hummusu', 10 from przepisy p where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ciecierzycę, sezam, oliwę, cytrynę, czosnek, kmin i sól zblenduj z odrobiną wody.', 'pasta jest gładka i łatwo się rozsmarowuje'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie tortilli', 5 from przepisy p where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa pokrój, a sałatę osusz.', null::text, false),
         (2::smallint, 'Tortillę posmaruj hummusem, ułóż warzywa i ciasno zawiń.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z jajkiem i szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z jajkiem i szpinakiem', 'Ciepła pełnoziarnista tortilla z jajkiem, szpinakiem, pomidorem i fetą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 366, 1,
  8, 8,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej zjedz bezpośrednio po przygotowaniu.',
  false, 'Jeśli tortilla pęka, ogrzej ją chwilę na suchej patelni. Zbyt mokry farsz smaż dłużej bez przykrycia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z jajkiem i szpinakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z jajkiem i szpinakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'roztrzepane', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone w kostkę', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 8 from przepisy p where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Jajka roztrzep z solą i pieprzem. Pomidora pokrój, a fetę pokrusz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i zwijanie', 8 from przepisy p where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju podsmaż szpinak i pomidora. Dodaj jajka i mieszaj do ścięcia.', null::text, false),
         (2::smallint, 'Tortillę krótko ogrzej, nałóż farsz i dodaj fetę.', null::text, true),
         (3::smallint, 'Zawiń boki do środka, zroluj i opiekaj na suchej patelni po około 1 minucie z każdej strony.', 'tortilla trzyma farsz i jest lekko zrumieniona'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z kurczakiem, awokado i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z kurczakiem, awokado i warzywami', 'Pełnoziarnista tortilla z grillowanym kurczakiem, awokado, pomidorem, ogórkiem i sosem jogurtowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 557, 1,
  12, 10,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Składniki przechowuj osobno w lodówce do 1 dnia. Tortillę składaj przed jedzeniem.',
  false, 'Jeśli tortilla pęka, ogrzej ją na suchej patelni. Suchą pierś pokrój cienko i wymieszaj z sosem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'pokrojona w paski', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Awokado';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Sałata rzymska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Warzywa pokrój, sałatę osusz, a jogurt wymieszaj z cytryną i częścią przypraw.', null::text, false),
         (2::smallint, 'Kurczaka natrzyj olejem, papryką, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie', 10 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kurczaka smaż na rozgrzanej patelni przez 6–8 minut.', 'mięso jest całkowicie ścięte, ale nadal soczyste'::text, true),
         (2::smallint, 'Tortillę ogrzej, posmaruj sosem i ułóż na niej sałatę, warzywa, awokado oraz kurczaka.', null::text, false),
         (3::smallint, 'Zawiń boki do środka i ciasno zroluj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z tofu i chrupiącymi warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z tofu i chrupiącymi warzywami', 'Pełnoziarnista tortilla z rumianym tofu, kapustą pekińską, marchewką i ogórkiem w sosie orzechowo-sojowym. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 513, 1,
  12, 8,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'miska', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Farsz przechowuj w lodówce do 1 dnia. Tortillę składaj bezpośrednio przed jedzeniem.',
  false, 'Jeśli tofu nie rumieni się, dokładnie je osusz. Za gęsty sos rozcieńcz wodą lub sokiem z limonki.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       'osuszone i pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Tofu naturalne';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'cienko pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Kapusta pekińska, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'starta', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony w paski', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Masło orzechowe bez cukru';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Sezam';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kapustę i ogórek pokrój, marchew zetrzyj. Tofu osusz.', null::text, false),
         (2::smallint, 'Masło orzechowe wymieszaj z sosem sojowym, limonką i odrobiną wody.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie', 8 from przepisy p where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oleju smaż tofu przez 5–6 minut.', 'tofu ma złote krawędzie'::text, true),
         (2::smallint, 'Tortillę ogrzej, posmaruj sosem i ułóż tofu oraz warzywa.', null::text, false),
         (3::smallint, 'Posyp sezamem i ciasno zawiń.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tosty z Goudą i pieczarkami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z Goudą i pieczarkami', 'Chrupiące tosty z serem Gouda, podsmażonymi pieczarkami i cebulą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 296, 1,
  8, 9,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Grill kontaktowy', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Tosty zjedz bezpośrednio po przygotowaniu.',
  false, 'Jeśli nadzienie jest wodniste, smaż pieczarki dłużej. Gdy pieczywo rumieni się za szybko, zmniejsz temperaturę urządzenia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tosty z Goudą i pieczarkami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tosty z Goudą i pieczarkami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Ser Gouda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'pokrojone w plasterki', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Masło';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie nadzienia', 8 from przepisy p where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na maśle smaż cebulę i pieczarki, aż odparuje cała woda. Dodaj tymianek i pieprz.', 'pieczarki są rumiane i suche'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Opiekanie', 5 from przepisy p where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na kromce ułóż połowę Goudy, pieczarki i pozostały ser. Przykryj drugą kromką.', null::text, true),
         (2::smallint, 'Opiekaj w tosterze lub grillu kontaktowym.', 'pieczywo jest rumiane, a ser całkowicie roztopiony'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tosty z mozzarellą i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z mozzarellą i pomidorem', 'Chrupiące tosty z roztopioną mozzarellą, pomidorem i bazylią. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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
--  Tosty z serem salami i papryką
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z serem salami i papryką', 'Ciepłe tosty z serem salami, papryką i musztardą. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 251, 1,
  6, 6,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Tosty zjedz bezpośrednio po przygotowaniu.',
  false, 'Jeśli papryka pozostaje zbyt twarda, pokrój ją bardzo cienko. Gdy ser wypływa, zostaw szerszy brzeg pieczywa bez nadzienia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tosty z serem salami i papryką'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tosty z serem salami i papryką'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojony w plastry', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Ser salami';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona w cienkie paski', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Masło';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Składanie tostów', 6 from przepisy p where lower(p.nazwa) = lower('Tosty z serem salami i papryką');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Paprykę pokrój w bardzo cienkie paski.', null::text, false),
         (2::smallint, 'Pieczywo posmaruj musztardą. Ułóż ser, paprykę i przyprawy, a następnie przykryj drugą kromką.', null::text, true),
         (3::smallint, 'Zewnętrzne strony pieczywa cienko posmaruj masłem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Opiekanie', 6 from przepisy p where lower(p.nazwa) = lower('Tosty z serem salami i papryką');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Opiekaj w tosterze lub grillu kontaktowym.', 'pieczywo jest chrupiące, a ser roztopiony'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Twarożek ze szczypiorkiem, rzodkiewką i pieczywem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Klasyczny twarożek z chrupiącą rzodkiewką i świeżym szczypiorkiem, podany z dwiema kromkami chleba żytniego razowego. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
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
  rodzaje                = excluded.rodzaje,
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

-- -------------------------------------------------------------------------
--  Wieprzowina z kapustą pekińską i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wieprzowina z kapustą pekińską i ryżem', 'Szybko smażona wieprzowina z kapustą pekińską, marchewką, imbirem i ryżem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 621, 1,
  12, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Ryż najlepiej trzymaj osobno.',
  false, 'Jeśli danie jest wodniste, smaż na większym ogniu. Za słony sos złagodź dodatkową kapustą i ryżem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 170, 'g'::jednostka_miary, 170,
       'pokrojona w cienkie paski', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Kapusta pekińska, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Ryż jaśminowy, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojona w cienkie paski', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'starty', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Sezam';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ryż ugotuj. Mięso i warzywa pokrój w cienkie paski, imbir zetrzyj.', null::text, false),
         (2::smallint, 'Mięso wymieszaj z połową sosu sojowego.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na mocno rozgrzanym oleju smaż mięso partiami przez 3–4 minuty. Odłóż.', null::text, false),
         (2::smallint, 'Dodaj cebulę, marchew, imbir i czosnek, a po 3 minutach kapustę.', null::text, false),
         (3::smallint, 'Włóż mięso z powrotem, dodaj pozostały sos i smaż jeszcze 2 minuty.', 'kapusta jest lekko chrupiąca, a mięso całkowicie ścięte'::text, true),
         (4::smallint, 'Podaj z ryżem i sezamem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Zupa z białej fasoli i jarmużu
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa z białej fasoli i jarmużu', 'Warzywna zupa z białą fasolą, jarmużem i pomidorami, podana z pieczywem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 826, 1,
  12, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Zupę przechowuj w lodówce do 3 dni lub zamroź. Pieczywo trzymaj osobno.',
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
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Fasola biała z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'bez twardych łodyg', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Jarmuż, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Seler naciowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 12 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Marchew i seler pokrój, cebulę i czosnek posiekaj, a z jarmużu usuń twarde łodygi.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 30 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę, marchew i seler przez 5 minut. Dodaj czosnek i tymianek.', null::text, false),
         (2::smallint, 'Dodaj pomidory, bulion i fasolę. Gotuj 18 minut.', null::text, false),
         (3::smallint, 'Dodaj jarmuż i gotuj jeszcze 5–7 minut.', 'warzywa są miękkie, a jarmuż delikatny'::text, true),
         (4::smallint, 'Dopraw solą oraz pieprzem i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Zupa z czerwonej soczewicy i pomidorów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa z czerwonej soczewicy i pomidorów', 'Gęsta zupa z czerwonej soczewicy, pomidorów i marchewki, podana z pieczywem. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 704, 1,
  10, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Zupę przechowuj w lodówce do 3 dni albo zamroź po ostudzeniu. Pieczywo trzymaj osobno.',
  true, 'Za gęstą zupę rozcieńcz bulionem. Za kwaśną pogotuj z dodatkową marchewką.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
  rodzaje                = excluded.rodzaje,
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'sok', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Marchew pokrój, cebulę i czosnek posiekaj, a soczewicę opłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 30 from przepisy p where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż cebulę i marchew przez 5 minut. Dodaj czosnek oraz przyprawy.', null::text, false),
         (2::smallint, 'Dodaj pomidory, bulion i soczewicę. Gotuj około 22 minut.', 'soczewica całkowicie zmiękła'::text, true),
         (3::smallint, 'Dopraw cytryną, solą oraz pieprzem i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Łosoś ze szpinakiem i kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Łosoś ze szpinakiem i kaszą bulgur', 'Smażony łosoś ze szpinakiem, cytryną i kaszą bulgur. Przepis na 1 porcję.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 410, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Kaszę najlepiej trzymaj osobno.',
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Sól kuchenna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie', 10 from przepisy p where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Kaszę bulgur ugotuj. Łososia osusz i dopraw solą oraz pieprzem.', null::text, false),
         (2::smallint, 'Jogurt wymieszaj z połową soku z cytryny.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 20 from przepisy p where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na oliwie smaż łososia po 4–5 minut z każdej strony.', 'środek jest soczysty, a mięso rozdziela się na płatki'::text, true),
         (2::smallint, 'Zdejmij rybę. Na tej samej patelni krótko podsmaż czosnek i szpinak.', null::text, false),
         (3::smallint, 'Podaj łososia ze szpinakiem, bulgurem i sosem jogurtowym.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Chili sin carne z czarną fasolą', 13, 2, 5),
  ('Curry z ciecierzycy, pomidorów i szpinaku', 12, 2, 5),
  ('Curry z czerwonej soczewicy i szpinaku', 11, 2, 5),
  ('Dorsz w kokosowym curry ze szpinakiem', 12, 2, 6),
  ('Grochówka z indykiem', 14, 2, 5),
  ('Gulasz jagnięcy z ciecierzycą i pomidorami', 13, 2, 6),
  ('Gulasz wołowy z warzywami korzeniowymi', 15, 2, 5),
  ('Gulasz z białej fasoli, jarmużu i pomidorów', 13, 2, 5),
  ('Jaglanka z gruszką i orzechami', 7, 2, 4),
  ('Jajecznica z pomidorem i szczypiorkiem', 6, 2, 5),
  ('Jajka na miękko z pieczywem i warzywami', 6, 2, 5),
  ('Kanapki z Goudą, jajkiem i szczypiorkiem', 7, 2, 3),
  ('Kanapki z Goudą, pomidorem i sałatą', 7, 1, 3),
  ('Kanapki z halloumi, awokado i pomidorem', 7, 2, 3),
  ('Kanapki z jajkiem, awokado i pomidorem', 6, 2, 5),
  ('Kanapki z mozzarellą, pomidorem i bazylią', 7, 1, 3),
  ('Kanapki z pastą jajeczną', 7, 2, 5),
  ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 7, 1, 3),
  ('Kanapki z sardynkami, pomidorem i rukolą', 7, 1, 4),
  ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 7, 1, 3),
  ('Kałamarnica z papryką i ryżem', 11, 2, 5),
  ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 12, 2, 7),
  ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 12, 2, 4),
  ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 13, 2, 6),
  ('Krem z brokułów z fetą', 11, 2, 5),
  ('Krem z dyni na mleku kokosowym', 13, 2, 5),
  ('Krem z kalafiora z pieczoną ciecierzycą', 12, 2, 6),
  ('Krewetki z czosnkiem, cukinią i ryżem', 9, 2, 4),
  ('Królik z rozmarynem i warzywami korzeniowymi', 12, 2, 5),
  ('Kurczak pieczony z batatem i brokułem', 10, 2, 5),
  ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 13, 2, 4),
  ('Makaron z brokułem i fetą', 8, 2, 5),
  ('Makaron z ciecierzycą, bazylią i orzechami', 10, 2, 4),
  ('Makaron z indykiem, pieczarkami i jogurtem', 10, 2, 5),
  ('Makaron z kurczakiem, szpinakiem i pomidorami', 12, 2, 4),
  ('Makaron z pieczonymi warzywami i mozzarellą', 11, 2, 5),
  ('Makaron z polędwiczką i pieczarkami', 11, 2, 5),
  ('Makaron z ricottą i szpinakiem', 9, 2, 4),
  ('Makaron z tuńczykiem, cytryną i natką pietruszki', 9, 2, 4),
  ('Makaron z wołowiną i sosem pomidorowym', 11, 2, 5),
  ('Małże w pomidorowym bulionie', 10, 2, 6),
  ('Morszczuk w sosie pomidorowym z ryżem', 11, 2, 5),
  ('Nocna owsianka z bananem i chia', 7, 2, 3),
  ('Nocna owsianka z borówkami i orzechami', 6, 2, 3),
  ('Omlet ze szpinakiem i fetą', 6, 2, 5),
  ('Owsianka z jabłkiem, cynamonem i orzechami', 6, 2, 5),
  ('Papryka faszerowana soczewicą i kaszą bulgur', 11, 2, 6),
  ('Pełnoziarniste placuszki ze skyrem i owocami', 8, 2, 5),
  ('Pieczona makrela z burakami i ziemniakami', 9, 2, 5),
  ('Pieczone warzywa korzeniowe z tymiankiem', 11, 2, 4),
  ('Pieczony bakłażan z ciecierzycą i fetą', 11, 2, 6),
  ('Pieczony kalafior z ziołowym sosem jogurtowym', 10, 2, 4),
  ('Pieczony łosoś z brokułem i ziemniakami', 9, 2, 5),
  ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 12, 3, 7),
  ('Placuszki bananowo-owsiane', 7, 2, 5),
  ('Polędwiczka w sosie musztardowym z kaszą bulgur', 11, 2, 6),
  ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 11, 2, 5),
  ('Pstrąg pieczony z warzywami korzeniowymi', 10, 2, 5),
  ('Pudding chia z mango i mlekiem kokosowym', 5, 2, 3),
  ('Ryż z pieczarkami, szpinakiem i parmezanem', 10, 2, 5),
  ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 9, 2, 5),
  ('Sałatka makaronowa z mozzarellą i warzywami', 11, 2, 4),
  ('Sałatka makaronowa z tuńczykiem i warzywami', 10, 2, 4),
  ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 11, 1, 4),
  ('Sałatka z jajkiem, fetą i warzywami', 8, 2, 5),
  ('Sałatka z jarmużu, jabłka i orzechów', 9, 1, 4),
  ('Sałatka z komosy, buraka i koziego sera', 11, 2, 4),
  ('Sałatka z pieczonym burakiem i fetą', 9, 2, 4),
  ('Serek wiejski z owocami i orzechami', 5, 1, 3),
  ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 6, 2, 4),
  ('Skyr kakaowy z bananem i masłem orzechowym', 5, 1, 3),
  ('Skyr z owocami, płatkami owsianymi i orzechami', 5, 1, 3),
  ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 8, 2, 4),
  ('Tabbouleh z kaszy bulgur i ciecierzycy', 11, 2, 4),
  ('Tofu z brokułem i ryżem', 9, 2, 6),
  ('Tofucznica ze szpinakiem i pomidorem', 9, 2, 4),
  ('Tortilla z Goudą, szpinakiem i pomidorem', 8, 2, 3),
  ('Tortilla z hummusem i warzywami', 11, 2, 3),
  ('Tortilla z jajkiem i szpinakiem', 8, 2, 4),
  ('Tortilla z kurczakiem, awokado i warzywami', 12, 2, 5),
  ('Tortilla z tofu i chrupiącymi warzywami', 10, 2, 5),
  ('Tosty z Goudą i pieczarkami', 7, 2, 3),
  ('Tosty z mozzarellą i pomidorem', 6, 2, 4),
  ('Tosty z serem salami i papryką', 7, 2, 4),
  ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 7, 2, 5),
  ('Wieprzowina z kapustą pekińską i ryżem', 10, 2, 6),
  ('Zupa z białej fasoli i jarmużu', 13, 2, 5),
  ('Zupa z czerwonej soczewicy i pomidorów', 13, 2, 4),
  ('Łosoś ze szpinakiem i kaszą bulgur', 9, 2, 5)
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
where lower(p.nazwa) in (lower('Chili sin carne z czarną fasolą'), lower('Curry z ciecierzycy, pomidorów i szpinaku'), lower('Curry z czerwonej soczewicy i szpinaku'), lower('Dorsz w kokosowym curry ze szpinakiem'), lower('Grochówka z indykiem'), lower('Gulasz jagnięcy z ciecierzycą i pomidorami'), lower('Gulasz wołowy z warzywami korzeniowymi'), lower('Gulasz z białej fasoli, jarmużu i pomidorów'), lower('Jaglanka z gruszką i orzechami'), lower('Jajecznica z pomidorem i szczypiorkiem'), lower('Jajka na miękko z pieczywem i warzywami'), lower('Kanapki z Goudą, jajkiem i szczypiorkiem'), lower('Kanapki z Goudą, pomidorem i sałatą'), lower('Kanapki z halloumi, awokado i pomidorem'), lower('Kanapki z jajkiem, awokado i pomidorem'), lower('Kanapki z mozzarellą, pomidorem i bazylią'), lower('Kanapki z pastą jajeczną'), lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem'), lower('Kanapki z sardynkami, pomidorem i rukolą'), lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą'), lower('Kałamarnica z papryką i ryżem'), lower('Klopsiki z indyka w sosie pomidorowym z bulgurem'), lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami'), lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym'), lower('Krem z brokułów z fetą'), lower('Krem z dyni na mleku kokosowym'), lower('Krem z kalafiora z pieczoną ciecierzycą'), lower('Krewetki z czosnkiem, cukinią i ryżem'), lower('Królik z rozmarynem i warzywami korzeniowymi'), lower('Kurczak pieczony z batatem i brokułem'), lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy'), lower('Makaron z brokułem i fetą'), lower('Makaron z ciecierzycą, bazylią i orzechami'), lower('Makaron z indykiem, pieczarkami i jogurtem'), lower('Makaron z kurczakiem, szpinakiem i pomidorami'), lower('Makaron z pieczonymi warzywami i mozzarellą'), lower('Makaron z polędwiczką i pieczarkami'), lower('Makaron z ricottą i szpinakiem'), lower('Makaron z tuńczykiem, cytryną i natką pietruszki'), lower('Makaron z wołowiną i sosem pomidorowym'), lower('Małże w pomidorowym bulionie'), lower('Morszczuk w sosie pomidorowym z ryżem'), lower('Nocna owsianka z bananem i chia'), lower('Nocna owsianka z borówkami i orzechami'), lower('Omlet ze szpinakiem i fetą'), lower('Owsianka z jabłkiem, cynamonem i orzechami'), lower('Papryka faszerowana soczewicą i kaszą bulgur'), lower('Pełnoziarniste placuszki ze skyrem i owocami'), lower('Pieczona makrela z burakami i ziemniakami'), lower('Pieczone warzywa korzeniowe z tymiankiem'), lower('Pieczony bakłażan z ciecierzycą i fetą'), lower('Pieczony kalafior z ziołowym sosem jogurtowym'), lower('Pieczony łosoś z brokułem i ziemniakami'), lower('Pierś z kaczki z pomarańczą i czerwoną kapustą'), lower('Placuszki bananowo-owsiane'), lower('Polędwiczka w sosie musztardowym z kaszą bulgur'), lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'), lower('Pstrąg pieczony z warzywami korzeniowymi'), lower('Pudding chia z mango i mlekiem kokosowym'), lower('Ryż z pieczarkami, szpinakiem i parmezanem'), lower('Sałatka brokułowa z jajkiem i sosem jogurtowym'), lower('Sałatka makaronowa z mozzarellą i warzywami'), lower('Sałatka makaronowa z tuńczykiem i warzywami'), lower('Sałatka z czarnej fasoli, kukurydzy i pomidora'), lower('Sałatka z jajkiem, fetą i warzywami'), lower('Sałatka z jarmużu, jabłka i orzechów'), lower('Sałatka z komosy, buraka i koziego sera'), lower('Sałatka z pieczonym burakiem i fetą'), lower('Serek wiejski z owocami i orzechami'), lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni'), lower('Skyr kakaowy z bananem i masłem orzechowym'), lower('Skyr z owocami, płatkami owsianymi i orzechami'), lower('Stek z tuńczyka z fasolką szparagową i ziemniakami'), lower('Tabbouleh z kaszy bulgur i ciecierzycy'), lower('Tofu z brokułem i ryżem'), lower('Tofucznica ze szpinakiem i pomidorem'), lower('Tortilla z Goudą, szpinakiem i pomidorem'), lower('Tortilla z hummusem i warzywami'), lower('Tortilla z jajkiem i szpinakiem'), lower('Tortilla z kurczakiem, awokado i warzywami'), lower('Tortilla z tofu i chrupiącymi warzywami'), lower('Tosty z Goudą i pieczarkami'), lower('Tosty z mozzarellą i pomidorem'), lower('Tosty z serem salami i papryką'), lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem'), lower('Wieprzowina z kapustą pekińską i ryżem'), lower('Zupa z białej fasoli i jarmużu'), lower('Zupa z czerwonej soczewicy i pomidorów'), lower('Łosoś ze szpinakiem i kaszą bulgur'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
