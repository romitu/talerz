-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 90
--  Wygenerowano: 2026-10-05
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
    ('Chili sin carne z czarną fasolą', 'Sól kłodawska', false),
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
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Sól kłodawska', false),
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
    ('Curry z czerwonej soczewicy i szpinaku', 'Sól kłodawska', false),
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
    ('Dorsz w kokosowym curry ze szpinakiem', 'Sól kłodawska', false),
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
    ('Grochówka z indykiem', 'Sól kłodawska', false),
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
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Sól kłodawska', false),
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
    ('Gulasz wołowy z warzywami korzeniowymi', 'Sól kłodawska', false),
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
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Sól kłodawska', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czarny pieprz mielony', false),
    ('Jaglanka z gruszką i orzechami', 'Kasza jaglana, sucha', false),
    ('Jaglanka z gruszką i orzechami', 'Mleko 2%', false),
    ('Jaglanka z gruszką i orzechami', 'Gruszka ze skórką', true),
    ('Jaglanka z gruszką i orzechami', 'Orzechy włoskie', false),
    ('Jaglanka z gruszką i orzechami', 'Cynamon mielony', false),
    ('Jaglanka z gruszką i orzechami', 'Miód', false),
    ('Jaglanka z gruszką i orzechami', 'Sól kłodawska', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Jaja kurze, całe, surowe', true),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Pomidory, surowe', true),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Szczypiorek świeży', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Masło', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Chleb żytni razowy', true),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Sól kłodawska', false),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Czarny pieprz mielony', false),
    ('Jajka na miękko z pieczywem i warzywami', 'Jaja kurze, całe, surowe', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Chleb żytni razowy', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Masło', false),
    ('Jajka na miękko z pieczywem i warzywami', 'Pomidory, surowe', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Ogórek, surowy', true),
    ('Jajka na miękko z pieczywem i warzywami', 'Sól kłodawska', false),
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
    ('Kanapki z jajkiem, awokado i pomidorem', 'Sól kłodawska', false),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Czarny pieprz mielony', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Chleb żytni razowy', true),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Ser mozzarella', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Pomidory, surowe', true),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Bazylia świeża', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Oliwa z oliwek', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Sól kłodawska', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Czarny pieprz mielony', false),
    ('Kanapki z pastą jajeczną', 'Jaja kurze, całe, surowe', true),
    ('Kanapki z pastą jajeczną', 'Chleb żytni razowy', true),
    ('Kanapki z pastą jajeczną', 'Jogurt grecki naturalny 2%', false),
    ('Kanapki z pastą jajeczną', 'Musztarda', false),
    ('Kanapki z pastą jajeczną', 'Szczypiorek świeży', false),
    ('Kanapki z pastą jajeczną', 'Sól kłodawska', false),
    ('Kanapki z pastą jajeczną', 'Czarny pieprz mielony', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Chleb żytni razowy', true),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Ser ricotta', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Rzodkiewka, surowa', true),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Szczypiorek świeży', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Jogurt naturalny 2%', false),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Sól kłodawska', false),
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
    ('Kałamarnica z papryką i ryżem', 'Sól kłodawska', false),
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
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Sól kłodawska', false),
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
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Sól kłodawska', false),
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
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Sól kłodawska', false),
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
    ('Krem z dyni na mleku kokosowym', 'Pietruszka natka', false),
    ('Krem z dyni na mleku kokosowym', 'Sól kłodawska', false),
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
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Sól kłodawska', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Czarny pieprz mielony', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Krewetki, surowe', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Cukinia, surowa', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Czosnek, surowy', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Oliwa z oliwek', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Cytryna', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Pietruszka natka', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Chili suszone', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Sól kłodawska', false),
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
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Sól kłodawska', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Kurczak pieczony z batatem i brokułem', 'Pierś z kurczaka, surowa', false),
    ('Kurczak pieczony z batatem i brokułem', 'Batat, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Brokuł, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Cebula czerwona, surowa', false),
    ('Kurczak pieczony z batatem i brokułem', 'Oliwa z oliwek', false),
    ('Kurczak pieczony z batatem i brokułem', 'Papryka wędzona mielona', false),
    ('Kurczak pieczony z batatem i brokułem', 'Tymianek suszony', false),
    ('Kurczak pieczony z batatem i brokułem', 'Czosnek, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Sól kłodawska', false),
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
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Sól kłodawska', false),
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
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Sól kłodawska', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Czarny pieprz mielony', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Pierś z indyka, surowa', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Pieczarki, surowe', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Jogurt grecki naturalny 2%', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Cebula, surowa', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Czosnek, surowy', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Olej rzepakowy', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Tymianek suszony', false),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Sól kłodawska', false),
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
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Sól kłodawska', false),
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
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Sól kłodawska', false),
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
    ('Makaron z polędwiczką i pieczarkami', 'Sól kłodawska', false),
    ('Makaron z polędwiczką i pieczarkami', 'Czarny pieprz mielony', false),
    ('Makaron z ricottą i szpinakiem', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z ricottą i szpinakiem', 'Ser ricotta', false),
    ('Makaron z ricottą i szpinakiem', 'Szpinak, surowy', false),
    ('Makaron z ricottą i szpinakiem', 'Czosnek, surowy', false),
    ('Makaron z ricottą i szpinakiem', 'Oliwa z oliwek', false),
    ('Makaron z ricottą i szpinakiem', 'Cytryna', false),
    ('Makaron z ricottą i szpinakiem', 'Gałka muszkatołowa mielona', false),
    ('Makaron z ricottą i szpinakiem', 'Sól kłodawska', false),
    ('Makaron z ricottą i szpinakiem', 'Czarny pieprz mielony', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Tuńczyk w wodzie, odsączony', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Cytryna', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Pietruszka natka', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Czosnek, surowy', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Oliwa z oliwek', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Chili suszone', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Sól kłodawska', false),
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
    ('Makaron z wołowiną i sosem pomidorowym', 'Sól kłodawska', false),
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
    ('Morszczuk w sosie pomidorowym z ryżem', 'Sól kłodawska', false),
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
    ('Omlet ze szpinakiem i fetą', 'Chleb żytni razowy', true),
    ('Omlet ze szpinakiem i fetą', 'Sól kłodawska', false),
    ('Omlet ze szpinakiem i fetą', 'Czarny pieprz mielony', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Płatki owsiane', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Mleko 2%', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Jabłko ze skórką', true),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Cynamon mielony', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Orzechy włoskie', false),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Sól kłodawska', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Papryka czerwona, surowa', true),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Soczewica brązowa, sucha', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Passata pomidorowa', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Cebula, surowa', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Czosnek, surowy', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Oliwa z oliwek', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Kmin rzymski mielony', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Pietruszka natka', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Sól kłodawska', false),
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
    ('Pieczona makrela z burakami i ziemniakami', 'Sól kłodawska', false),
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
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Sól kłodawska', false),
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
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Sól kłodawska', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Czarny pieprz mielony', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Kalafior, surowy', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Oliwa z oliwek', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Cytryna', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Czosnek, surowy', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Pietruszka natka', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Kmin rzymski mielony', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Papryka wędzona mielona', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Sól kłodawska', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Czarny pieprz mielony', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Łosoś dziki, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Brokuł, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Ziemniaki, surowe', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Oliwa z oliwek', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Cytryna', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Czosnek, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Tymianek suszony', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Sól kłodawska', false),
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
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Sól kłodawska', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Czarny pieprz mielony', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'woda', false),
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
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Sól kłodawska', false),
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
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Sól kłodawska', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Czarny pieprz mielony', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Pstrąg tęczowy, surowy', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Seler korzeń', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Oliwa z oliwek', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Cytryna', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Rozmaryn suszony', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Sól kłodawska', false),
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
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Sól kłodawska', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czarny pieprz mielony', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Brokuł, surowy', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Jaja kurze, całe, surowe', true),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Kukurydza konserwowa, odsączona', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Cebula czerwona, surowa', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Musztarda', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Szczypiorek świeży', false),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Sól kłodawska', false),
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
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Sól kłodawska', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Makaron pełnoziarnisty, suchy', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Tuńczyk w wodzie, odsączony', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Ogórek, surowy', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Pomidory, surowe', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Kukurydza konserwowa, odsączona', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Jogurt grecki naturalny 2%', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Musztarda', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Szczypiorek świeży', false),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Sól kłodawska', false),
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
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Sól kłodawska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Jaja kurze, całe, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ser feta', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Pomidory, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ogórek, surowy', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sałata rzymska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Oliwa z oliwek', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sól kłodawska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Jarmuż, surowy', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Jabłko ze skórką', true),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Pomarańcza', true),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Orzechy włoskie', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Oliwa z oliwek', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Cytryna', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Musztarda', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Sól kłodawska', false),
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
    ('Sałatka z komosy, buraka i koziego sera', 'Sól kłodawska', false),
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
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Chleb żytni razowy', true),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Sól kłodawska', false),
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
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Sól kłodawska', false),
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
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Sól kłodawska', false),
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
    ('Tofu z brokułem i ryżem', 'woda', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Tofu naturalne', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Szpinak, surowy', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Pomidory, surowe', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Cebula, surowa', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Chleb żytni razowy', true),
    ('Tofucznica ze szpinakiem i pomidorem', 'Olej rzepakowy', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Kurkuma mielona', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Sól kłodawska', false),
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
    ('Tortilla z hummusem i warzywami', 'Sól kłodawska', false),
    ('Tortilla z hummusem i warzywami', 'woda', false),
    ('Tortilla z jajkiem i szpinakiem', 'Tortilla pełnoziarnista', false),
    ('Tortilla z jajkiem i szpinakiem', 'Jaja kurze, całe, surowe', true),
    ('Tortilla z jajkiem i szpinakiem', 'Szpinak, surowy', false),
    ('Tortilla z jajkiem i szpinakiem', 'Pomidory, surowe', false),
    ('Tortilla z jajkiem i szpinakiem', 'Ser feta', false),
    ('Tortilla z jajkiem i szpinakiem', 'Olej rzepakowy', false),
    ('Tortilla z jajkiem i szpinakiem', 'Sól kłodawska', false),
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
    ('Tortilla z kurczakiem, awokado i warzywami', 'Sól kłodawska', false),
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
    ('Tortilla z tofu i chrupiącymi warzywami', 'woda', false),
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
    ('Tosty z mozzarellą i pomidorem', 'Sól kłodawska', false),
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
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Sól kłodawska', false),
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
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Kurczak, pałka bez skóry, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Mleko kokosowe z puszki', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Tajska Żółta Lekko Ostra Pasta Curry Yellow Curry Paste Mild 400g MAE PLOY', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Papryka czerwona, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Cukinia, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Cebula, surowa', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Imbir korzeń, surowy', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Sos sojowy', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Limonka', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Oliwa z oliwek', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Ryż jaśminowy, suchy', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Szczypiorek świeży', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'woda', false),
    ('Zupa - Tajskie żółte curry z kurczakiem', 'Czosnek, surowy', false),
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
    ('Zupa z białej fasoli i jarmużu', 'Sól kłodawska', false),
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
    ('Zupa z czerwonej soczewicy i pomidorów', 'Sól kłodawska', false),
    ('Zupa z czerwonej soczewicy i pomidorów', 'Czarny pieprz mielony', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Łosoś dziki, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Szpinak, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Jogurt grecki naturalny 2%', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Cytryna', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Czosnek, surowy', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Oliwa z oliwek', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Sól kłodawska', false),
    ('Łosoś ze szpinakiem i kaszą bulgur', 'Czarny pieprz mielony', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Chili sin carne z czarną fasolą', 'Garnek 3 l'),
    ('Chili sin carne z czarną fasolą', 'Nóż szefa kuchni'),
    ('Chili sin carne z czarną fasolą', 'Deska do krojenia'),
    ('Chili sin carne z czarną fasolą', 'Waga kuchenna'),
    ('Chili sin carne z czarną fasolą', 'Sitko'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Garnek 3 l'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Nóż szefa kuchni'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Deska do krojenia'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Waga kuchenna'),
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Sitko'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Garnek 3 l'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Nóż szefa kuchni'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Deska do krojenia'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Waga kuchenna'),
    ('Curry z czerwonej soczewicy i szpinaku', 'Sitko'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Patelnia 28 cm'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Garnek 2 l'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Nóż szefa kuchni'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Deska do krojenia'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Waga kuchenna'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Sitko'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Termometr do mięsa'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Widelec'),
    ('Grochówka z indykiem', 'Garnek 3 l'),
    ('Grochówka z indykiem', 'Nóż szefa kuchni'),
    ('Grochówka z indykiem', 'Deska do krojenia'),
    ('Grochówka z indykiem', 'Waga kuchenna'),
    ('Grochówka z indykiem', 'Sitko'),
    ('Grochówka z indykiem', 'Termometr do mięsa'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Garnek 3 l'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Garnek 2 l'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Nóż szefa kuchni'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Deska do krojenia'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Waga kuchenna'),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Sitko'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Garnek 3 l'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Deska do krojenia'),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Waga kuchenna'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Garnek 3 l'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Nóż szefa kuchni'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Deska do krojenia'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Waga kuchenna'),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Sitko'),
    ('Jaglanka z gruszką i orzechami', 'Rondel'),
    ('Jaglanka z gruszką i orzechami', 'Sitko'),
    ('Jaglanka z gruszką i orzechami', 'Nóż szefa kuchni'),
    ('Jaglanka z gruszką i orzechami', 'Deska do krojenia'),
    ('Jaglanka z gruszką i orzechami', 'Waga kuchenna'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Patelnia 24 cm'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Miska'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Widelec'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Deska do krojenia'),
    ('Jajecznica z pomidorem i szczypiorkiem', 'Waga kuchenna'),
    ('Jajka na miękko z pieczywem i warzywami', 'Garnek 2 l'),
    ('Jajka na miękko z pieczywem i warzywami', 'Nóż szefa kuchni'),
    ('Jajka na miękko z pieczywem i warzywami', 'Deska do krojenia'),
    ('Jajka na miękko z pieczywem i warzywami', 'Waga kuchenna'),
    ('Jajka na miękko z pieczywem i warzywami', 'Łyżka cedzakowa'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Garnek 2 l'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Deska do krojenia'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Waga kuchenna'),
    ('Kanapki z Goudą, jajkiem i szczypiorkiem', 'Łyżka cedzakowa'),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Nóż szefa kuchni'),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Deska do krojenia'),
    ('Kanapki z Goudą, pomidorem i sałatą', 'Waga kuchenna'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Patelnia 24 cm'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Nóż szefa kuchni'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Deska do krojenia'),
    ('Kanapki z halloumi, awokado i pomidorem', 'Waga kuchenna'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Garnek 2 l'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Miska'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Widelec'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Nóż szefa kuchni'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Deska do krojenia'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Waga kuchenna'),
    ('Kanapki z jajkiem, awokado i pomidorem', 'Łyżka cedzakowa'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Nóż szefa kuchni'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Deska do krojenia'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Waga kuchenna'),
    ('Kanapki z pastą jajeczną', 'Garnek 2 l'),
    ('Kanapki z pastą jajeczną', 'Miska'),
    ('Kanapki z pastą jajeczną', 'Widelec'),
    ('Kanapki z pastą jajeczną', 'Nóż szefa kuchni'),
    ('Kanapki z pastą jajeczną', 'Deska do krojenia'),
    ('Kanapki z pastą jajeczną', 'Waga kuchenna'),
    ('Kanapki z pastą jajeczną', 'Łyżka cedzakowa'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Miska'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Widelec'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Nóż szefa kuchni'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Deska do krojenia'),
    ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Waga kuchenna'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Miska'),
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
    ('Kałamarnica z papryką i ryżem', 'Sitko'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Patelnia 28 cm'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Garnek 2 l'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Miska'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Nóż szefa kuchni'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Deska do krojenia'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Waga kuchenna'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Sitko'),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Termometr do mięsa'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Piekarnik'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Blacha do pieczenia'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Garnek 2 l'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Nóż szefa kuchni'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Deska do krojenia'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Waga kuchenna'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Sitko'),
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Miska'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Garnek 2 l'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Patelnia 28 cm'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Miska'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Tarka o grubych oczkach'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Nóż szefa kuchni'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Deska do krojenia'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Waga kuchenna'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Sitko'),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Widelec'),
    ('Krem z brokułów z fetą', 'Garnek 3 l'),
    ('Krem z brokułów z fetą', 'Blender ręczny'),
    ('Krem z brokułów z fetą', 'Nóż szefa kuchni'),
    ('Krem z brokułów z fetą', 'Deska do krojenia'),
    ('Krem z brokułów z fetą', 'Waga kuchenna'),
    ('Krem z brokułów z fetą', 'Miska'),
    ('Krem z dyni na mleku kokosowym', 'Garnek 3 l'),
    ('Krem z dyni na mleku kokosowym', 'Blender ręczny'),
    ('Krem z dyni na mleku kokosowym', 'Nóż szefa kuchni'),
    ('Krem z dyni na mleku kokosowym', 'Deska do krojenia'),
    ('Krem z dyni na mleku kokosowym', 'Waga kuchenna'),
    ('Krem z dyni na mleku kokosowym', 'Sitko'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Piekarnik'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Blacha do pieczenia'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Garnek 3 l'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Blender ręczny'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Nóż szefa kuchni'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Deska do krojenia'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Waga kuchenna'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Sitko'),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Miska'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Patelnia 28 cm'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Garnek 2 l'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Nóż szefa kuchni'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Deska do krojenia'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Waga kuchenna'),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Sitko'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Piekarnik'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Naczynie żaroodporne'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Deska do krojenia'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Waga kuchenna'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Termometr do mięsa'),
    ('Kurczak pieczony z batatem i brokułem', 'Piekarnik'),
    ('Kurczak pieczony z batatem i brokułem', 'Blacha do pieczenia'),
    ('Kurczak pieczony z batatem i brokułem', 'Nóż szefa kuchni'),
    ('Kurczak pieczony z batatem i brokułem', 'Deska do krojenia'),
    ('Kurczak pieczony z batatem i brokułem', 'Waga kuchenna'),
    ('Kurczak pieczony z batatem i brokułem', 'Termometr do mięsa'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Garnek 3 l'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Garnek 2 l'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Tarka o grubych oczkach'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Nóż szefa kuchni'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Deska do krojenia'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Waga kuchenna'),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Sitko'),
    ('Makaron z brokułem i fetą', 'Garnek 3 l'),
    ('Makaron z brokułem i fetą', 'Patelnia 28 cm'),
    ('Makaron z brokułem i fetą', 'Nóż szefa kuchni'),
    ('Makaron z brokułem i fetą', 'Deska do krojenia'),
    ('Makaron z brokułem i fetą', 'Waga kuchenna'),
    ('Makaron z brokułem i fetą', 'Durszlak'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Garnek 3 l'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Blender ręczny'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Nóż szefa kuchni'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Deska do krojenia'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Waga kuchenna'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Sitko'),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Miska'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Patelnia 28 cm'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Garnek 3 l'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Miska'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Nóż szefa kuchni'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Deska do krojenia'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Waga kuchenna'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Durszlak'),
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Termometr do mięsa'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Patelnia 28 cm'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Garnek 3 l'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Nóż szefa kuchni'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Deska do krojenia'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Waga kuchenna'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Durszlak'),
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Termometr do mięsa'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Piekarnik'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Blacha do pieczenia'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Garnek 3 l'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Nóż szefa kuchni'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Deska do krojenia'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Waga kuchenna'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Durszlak'),
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Miska'),
    ('Makaron z polędwiczką i pieczarkami', 'Patelnia 28 cm'),
    ('Makaron z polędwiczką i pieczarkami', 'Garnek 3 l'),
    ('Makaron z polędwiczką i pieczarkami', 'Miska'),
    ('Makaron z polędwiczką i pieczarkami', 'Nóż szefa kuchni'),
    ('Makaron z polędwiczką i pieczarkami', 'Deska do krojenia'),
    ('Makaron z polędwiczką i pieczarkami', 'Waga kuchenna'),
    ('Makaron z polędwiczką i pieczarkami', 'Durszlak'),
    ('Makaron z polędwiczką i pieczarkami', 'Termometr do mięsa'),
    ('Makaron z ricottą i szpinakiem', 'Patelnia 28 cm'),
    ('Makaron z ricottą i szpinakiem', 'Garnek 3 l'),
    ('Makaron z ricottą i szpinakiem', 'Nóż szefa kuchni'),
    ('Makaron z ricottą i szpinakiem', 'Deska do krojenia'),
    ('Makaron z ricottą i szpinakiem', 'Waga kuchenna'),
    ('Makaron z ricottą i szpinakiem', 'Durszlak'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Garnek 3 l'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Patelnia 28 cm'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Nóż szefa kuchni'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Deska do krojenia'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Waga kuchenna'),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Durszlak'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Patelnia 28 cm'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Garnek 3 l'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Tarka o grubych oczkach'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Nóż szefa kuchni'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Deska do krojenia'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Waga kuchenna'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Durszlak'),
    ('Makaron z wołowiną i sosem pomidorowym', 'Termometr do mięsa'),
    ('Małże w pomidorowym bulionie', 'Garnek 3 l'),
    ('Małże w pomidorowym bulionie', 'Nóż szefa kuchni'),
    ('Małże w pomidorowym bulionie', 'Deska do krojenia'),
    ('Małże w pomidorowym bulionie', 'Waga kuchenna'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Patelnia 28 cm'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Garnek 2 l'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Nóż szefa kuchni'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Deska do krojenia'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Waga kuchenna'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Sitko'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Termometr do mięsa'),
    ('Nocna owsianka z bananem i chia', 'Miska'),
    ('Nocna owsianka z bananem i chia', 'Widelec'),
    ('Nocna owsianka z bananem i chia', 'Nóż szefa kuchni'),
    ('Nocna owsianka z bananem i chia', 'Deska do krojenia'),
    ('Nocna owsianka z bananem i chia', 'Waga kuchenna'),
    ('Nocna owsianka z borówkami i orzechami', 'Miska'),
    ('Nocna owsianka z borówkami i orzechami', 'Waga kuchenna'),
    ('Nocna owsianka z borówkami i orzechami', 'Nóż szefa kuchni'),
    ('Nocna owsianka z borówkami i orzechami', 'Deska do krojenia'),
    ('Omlet ze szpinakiem i fetą', 'Patelnia 24 cm'),
    ('Omlet ze szpinakiem i fetą', 'Miska'),
    ('Omlet ze szpinakiem i fetą', 'Widelec'),
    ('Omlet ze szpinakiem i fetą', 'Nóż szefa kuchni'),
    ('Omlet ze szpinakiem i fetą', 'Deska do krojenia'),
    ('Omlet ze szpinakiem i fetą', 'Waga kuchenna'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Rondel'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Miska'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Nóż szefa kuchni'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Deska do krojenia'),
    ('Owsianka z jabłkiem, cynamonem i orzechami', 'Waga kuchenna'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Piekarnik'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Naczynie żaroodporne'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Garnek 2 l'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Nóż szefa kuchni'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Deska do krojenia'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Waga kuchenna'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Garnek 3 l'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Patelnia 24 cm'),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Sitko'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Patelnia 24 cm'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Miska'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Widelec'),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Waga kuchenna'),
    ('Pieczona makrela z burakami i ziemniakami', 'Piekarnik'),
    ('Pieczona makrela z burakami i ziemniakami', 'Blacha do pieczenia'),
    ('Pieczona makrela z burakami i ziemniakami', 'Nóż szefa kuchni'),
    ('Pieczona makrela z burakami i ziemniakami', 'Deska do krojenia'),
    ('Pieczona makrela z burakami i ziemniakami', 'Waga kuchenna'),
    ('Pieczona makrela z burakami i ziemniakami', 'Termometr do mięsa'),
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
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Sitko'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Piekarnik'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Blacha do pieczenia'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Miska'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Nóż szefa kuchni'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Deska do krojenia'),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Waga kuchenna'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Piekarnik'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Blacha do pieczenia'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Nóż szefa kuchni'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Deska do krojenia'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Waga kuchenna'),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Termometr do mięsa'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Patelnia 28 cm'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Garnek 3 l'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Garnek 2 l'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Nóż szefa kuchni'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Deska do krojenia'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Waga kuchenna'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Termometr do mięsa'),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Durszlak'),
    ('Placuszki bananowo-owsiane', 'Patelnia 24 cm'),
    ('Placuszki bananowo-owsiane', 'Miska'),
    ('Placuszki bananowo-owsiane', 'Widelec'),
    ('Placuszki bananowo-owsiane', 'Waga kuchenna'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Patelnia 28 cm'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Garnek 2 l'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Miska'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Nóż szefa kuchni'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Deska do krojenia'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Waga kuchenna'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Sitko'),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Termometr do mięsa'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Garnek 3 l'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Nóż szefa kuchni'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Deska do krojenia'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Waga kuchenna'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Sitko'),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Termometr do mięsa'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Piekarnik'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Blacha do pieczenia'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Deska do krojenia'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Waga kuchenna'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Termometr do mięsa'),
    ('Pudding chia z mango i mlekiem kokosowym', 'Miska'),
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
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Miska'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Nóż szefa kuchni'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Deska do krojenia'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Waga kuchenna'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Garnek 2 l'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Durszlak'),
    ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Łyżka cedzakowa'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Garnek 3 l'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Sitko'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Miska'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Deska do krojenia'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Waga kuchenna'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Garnek 2 l'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Sitko'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Miska'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Deska do krojenia'),
    ('Sałatka makaronowa z tuńczykiem i warzywami', 'Waga kuchenna'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Miska'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Nóż szefa kuchni'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Deska do krojenia'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Waga kuchenna'),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Sitko'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Garnek 2 l'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Miska'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Deska do krojenia'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Waga kuchenna'),
    ('Sałatka z jajkiem, fetą i warzywami', 'Łyżka cedzakowa'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Miska'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Nóż szefa kuchni'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Deska do krojenia'),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Waga kuchenna'),
    ('Sałatka z komosy, buraka i koziego sera', 'Piekarnik'),
    ('Sałatka z komosy, buraka i koziego sera', 'Blacha do pieczenia'),
    ('Sałatka z komosy, buraka i koziego sera', 'Garnek 2 l'),
    ('Sałatka z komosy, buraka i koziego sera', 'Miska'),
    ('Sałatka z komosy, buraka i koziego sera', 'Nóż szefa kuchni'),
    ('Sałatka z komosy, buraka i koziego sera', 'Deska do krojenia'),
    ('Sałatka z komosy, buraka i koziego sera', 'Waga kuchenna'),
    ('Sałatka z komosy, buraka i koziego sera', 'Sitko'),
    ('Sałatka z komosy, buraka i koziego sera', 'Widelec'),
    ('Sałatka z pieczonym burakiem i fetą', 'Piekarnik'),
    ('Sałatka z pieczonym burakiem i fetą', 'Blacha do pieczenia'),
    ('Sałatka z pieczonym burakiem i fetą', 'Miska'),
    ('Sałatka z pieczonym burakiem i fetą', 'Nóż szefa kuchni'),
    ('Sałatka z pieczonym burakiem i fetą', 'Deska do krojenia'),
    ('Sałatka z pieczonym burakiem i fetą', 'Waga kuchenna'),
    ('Serek wiejski z owocami i orzechami', 'Miska'),
    ('Serek wiejski z owocami i orzechami', 'Nóż szefa kuchni'),
    ('Serek wiejski z owocami i orzechami', 'Deska do krojenia'),
    ('Serek wiejski z owocami i orzechami', 'Waga kuchenna'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Miska'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Widelec'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Nóż szefa kuchni'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Deska do krojenia'),
    ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Waga kuchenna'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Miska'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Widelec'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Nóż szefa kuchni'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Deska do krojenia'),
    ('Skyr kakaowy z bananem i masłem orzechowym', 'Waga kuchenna'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Miska'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Nóż szefa kuchni'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Deska do krojenia'),
    ('Skyr z owocami, płatkami owsianymi i orzechami', 'Waga kuchenna'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Patelnia 28 cm'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Garnek 3 l'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Garnek 2 l'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Nóż szefa kuchni'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Deska do krojenia'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Waga kuchenna'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Durszlak'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Termometr do mięsa'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Garnek 2 l'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Sitko'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Miska'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Nóż szefa kuchni'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Deska do krojenia'),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Waga kuchenna'),
    ('Tofu z brokułem i ryżem', 'Patelnia 28 cm'),
    ('Tofu z brokułem i ryżem', 'Garnek 2 l'),
    ('Tofu z brokułem i ryżem', 'Tarka o drobnych oczkach'),
    ('Tofu z brokułem i ryżem', 'Nóż szefa kuchni'),
    ('Tofu z brokułem i ryżem', 'Deska do krojenia'),
    ('Tofu z brokułem i ryżem', 'Waga kuchenna'),
    ('Tofu z brokułem i ryżem', 'Sitko'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Patelnia 24 cm'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Miska'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Widelec'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Nóż szefa kuchni'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Deska do krojenia'),
    ('Tofucznica ze szpinakiem i pomidorem', 'Waga kuchenna'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Patelnia 24 cm'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Nóż szefa kuchni'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Deska do krojenia'),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Waga kuchenna'),
    ('Tortilla z hummusem i warzywami', 'Blender ręczny'),
    ('Tortilla z hummusem i warzywami', 'Miska'),
    ('Tortilla z hummusem i warzywami', 'Nóż szefa kuchni'),
    ('Tortilla z hummusem i warzywami', 'Deska do krojenia'),
    ('Tortilla z hummusem i warzywami', 'Waga kuchenna'),
    ('Tortilla z hummusem i warzywami', 'Sitko'),
    ('Tortilla z jajkiem i szpinakiem', 'Patelnia 24 cm'),
    ('Tortilla z jajkiem i szpinakiem', 'Miska'),
    ('Tortilla z jajkiem i szpinakiem', 'Widelec'),
    ('Tortilla z jajkiem i szpinakiem', 'Nóż szefa kuchni'),
    ('Tortilla z jajkiem i szpinakiem', 'Deska do krojenia'),
    ('Tortilla z jajkiem i szpinakiem', 'Waga kuchenna'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Patelnia 24 cm'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Miska'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Nóż szefa kuchni'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Deska do krojenia'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Waga kuchenna'),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Termometr do mięsa'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Patelnia 24 cm'),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Miska'),
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
    ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Miska'),
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
    ('Wieprzowina z kapustą pekińską i ryżem', 'Sitko'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Termometr do mięsa'),
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
--  Chili sin carne z czarną fasolą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Chili sin carne z czarną fasolą', 'Jednogarnkowe chili bez mięsa z czarną i czerwoną fasolą, kukurydzą oraz papryką. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 585, 1, 2,
  10, 34,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Chili przechowuj w lodówce do 3 dni lub zamroź po ostudzeniu. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Fasola czarna z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Fasola czerwona z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Kukurydza konserwowa, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Chili suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj paprykę, usuń gniazdo nasienne i pokrój w kostkę około 1 cm.', null::text, false),
         (3::smallint, 'Obierz i posiekaj cebulę oraz czosnek.', null::text, false),
         (4::smallint, 'Obie fasole opłucz i odsącz na sitku. Odsącz kukurydzę. Odmierz pomidory i passatę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie chili', 34 from przepisy p where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Dodaj cebulę i smaż 4 minuty na średnim ogniu.', null::text, false),
         (2::smallint, 'Dodaj paprykę i smaż 3 minuty. Dodaj czosnek, kmin, paprykę wędzoną oraz chili i smaż 30 sekund, mieszając.', null::text, false),
         (3::smallint, 'Dodaj pomidory, passatę, obie fasole i kukurydzę. Doprowadź do łagodnego wrzenia przez około 3 minuty.', null::text, false),
         (4::smallint, 'Gotuj bez przykrycia na małym ogniu przez 20 minut, mieszając co kilka minut.', 'papryka jest miękka, sos gęsty, fasola zachowuje kształt'::text, true),
         (5::smallint, 'Spróbuj, dopraw odmierzoną solą i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Curry z ciecierzycy, pomidorów i szpinaku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Curry z ciecierzycy, pomidorów i szpinaku', 'Łagodne jednogarnkowe curry z ciecierzycą, szpinakiem i pomidorami. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 662, 1, 2,
  10, 27,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Curry przechowuj w lodówce do 3 dni lub zamroź po ostudzeniu. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 360, 'g'::jednostka_miary, 360,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 400, 'g'::jednostka_miary, 400,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Garam masala';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Cytryna';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Obierz i posiekaj cebulę, czosnek i imbir.', null::text, false),
         (3::smallint, 'Opłucz i odsącz ciecierzycę. Umyj szpinak, odsącz i usuń grube łodygi.', null::text, false),
         (4::smallint, 'Umyj cytrynę, wyciśnij sok i odmierz ilość z listy. Odmierz pomidory i mleko kokosowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 27 from przepisy p where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Smaż cebulę 4 minuty.', null::text, false),
         (2::smallint, 'Dodaj czosnek, imbir, garam masala i kmin; smaż 1 minutę, mieszając.', null::text, false),
         (3::smallint, 'Dodaj pomidory, mleko kokosowe i ciecierzycę. Doprowadź do wrzenia przez około 2 minuty, następnie gotuj łagodnie bez przykrycia 15 minut.', null::text, false),
         (4::smallint, 'Dodaj szpinak i gotuj jeszcze 1–2 minuty.', 'liście właśnie zwiędły, a sos zgęstniał'::text, true),
         (5::smallint, 'Zdejmij z ognia. Dodaj przygotowany sok z cytryny, dopraw solą i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Curry z czerwonej soczewicy i szpinaku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Curry z czerwonej soczewicy i szpinaku', 'Kremowe jednogarnkowe curry z czerwonej soczewicy, szpinaku i pomidorów. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 747, 1, 2,
  10, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Curry przechowuj w zamkniętym pojemniku w lodówce do 3 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeżeli curry zbyt mocno gęstnieje przed zmięknięciem soczewicy, dolewaj gorącą wodę małymi porcjami i mieszaj. Ostrość pasty oceń przed dodaniem całej odmierzonej ilości.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Curry z czerwonej soczewicy i szpinaku'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Curry z czerwonej soczewicy i szpinaku'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Szpinak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 400, 'g'::jednostka_miary, 400,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Pomidory krojone z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 400, 'ml'::jednostka_miary, 400,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       'drobno posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'drobno posiekany', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Kurkuma mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Obierz i posiekaj cebulę oraz czosnek. Opłucz soczewicę na sitku.', null::text, false),
         (3::smallint, 'Umyj szpinak, odsącz i usuń grube łodygi. Odmierz pomidory, mleko kokosowe i wodę z listy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 35 from przepisy p where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Smaż cebulę 4 minuty. Dodaj czosnek, pastę curry i kurkumę; smaż 1 minutę, mieszając.', null::text, false),
         (2::smallint, 'Dodaj soczewicę, odmierzoną wodę i mleko kokosowe. Doprowadź do wrzenia przez około 3 minuty i gotuj na małym ogniu 12–15 minut pod uchyloną pokrywką. Mieszaj co kilka minut.', null::text, false),
         (3::smallint, 'Gdy soczewica zmięknie, dodaj pomidory i gotuj bez przykrycia jeszcze 6–8 minut. Jeśli soczewica jest twarda, przed dodaniem pomidorów dogotuj ją po 3 minuty, uzupełniając odparowaną wodę.', 'soczewica jest miękka i częściowo się rozpada'::text, true),
         (4::smallint, 'Dodaj szpinak i gotuj 1–2 minuty, tylko do zwiędnięcia. Dopraw solą i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Dorsz w kokosowym curry ze szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Dorsz w kokosowym curry ze szpinakiem', 'Delikatny dorsz w kokosowym sosie curry ze szpinakiem, podany z ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Najpierw przygotuj wszystkie składniki, następnie gotuj ryż i curry równolegle na dwóch palnikach. Czasy etapów są orientacyjne dla porcji bazowej; zależą od czasu gotowania ryżu, grubości ryby i ilości przygotowywanego jedzenia.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 749, 1, 1,
  10, 28,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa', 'Widelec']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
  false, 'Jeśli sos jest za rzadki, odparuj go bez przykrycia przez dodatkowe 2–3 minuty przed dodaniem dorsza. Jeśli zbytnio zgęstnieje, dolewaj niewielkie ilości gorącej wody. Ryby nie mieszaj energicznie; delikatnie poruszaj patelnią. Jeśli po wskazanym czasie środek ryby nie jest gotowy, dogotowuj po 1 minucie i sprawdzaj ponownie.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'świeży lub wcześniej rozmrożony w lodówce, bez ości; kawałki szerokości około 3–4 cm i grubości do około 3 cm', null, sk.rola, sk.mozna_dzielic, 1
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach wskazanych na liście dla przygotowywanej liczby porcji. Odmierz mleko kokosowe, pomidory, pastę curry, olej i sól. Woda do gotowania ryżu jest dodatkowa; jej nadmiar zostanie odcedzony.', null::text, false),
         (2::smallint, 'Obierz cebulę i drobno ją posiekaj.', null::text, false),
         (3::smallint, 'Obierz czosnek i imbir, następnie drobno je posiekaj.', null::text, false),
         (4::smallint, 'Umyj szpinak, odsącz go i usuń grube łodyżki. Duże liście porwij na mniejsze kawałki.', null::text, false),
         (5::smallint, 'Umyj limonkę, wyciśnij sok i odmierz ilość wskazaną na liście składników. Odstaw sok do końcowego doprawienia.', null::text, false),
         (6::smallint, 'Przepłucz ryż na sitku pod zimną wodą i odstaw do gotowania.', null::text, false),
         (7::smallint, 'Dorsza osusz, sprawdź, czy nie ma ości, i usuń je, jeśli są. Pokrój filet na kawałki szerokości około 3–4 cm, zachowując podobną grubość. Jeśli ryba była mrożona, użyj wcześniej rozmrożonej w lodówce.', null::text, false),
         (8::smallint, 'Po przygotowaniu surowej ryby umyj ręce, deskę, nóż i powierzchnie, które miały z nią kontakt.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i curry', 26 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj w garnku większą ilość wody. Wsyp opłukany ryż i gotuj przez czas podany na opakowaniu. Ryż ma być zanurzony i mieć miejsce do swobodnego gotowania. Nastaw minutnik; podczas podgrzewania wody i gotowania ryżu wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzewaj odmierzony olej na patelni przez około 1 minutę na średnim ogniu. Dobierz patelnię tak, aby później kawałki dorsza zmieściły się w jednej warstwie.', null::text, false),
         (3::smallint, 'Dodaj cebulę i smaż przez 4 minuty na średnim ogniu, mieszając.', 'cebula zmiękła i jest szklista, bez przypalonych brzegów'::text, false),
         (4::smallint, 'Dodaj czosnek oraz imbir i smaż przez 1 minutę, mieszając.', null::text, false),
         (5::smallint, 'Dodaj odmierzoną pastę curry i smaż przez 1 minutę, stale mieszając.', 'pasta intensywnie pachnie, ale nie przypala się'::text, false),
         (6::smallint, 'Wlej mleko kokosowe, dodaj odmierzone pomidory i wymieszaj. Podgrzewaj do łagodnego wrzenia przez około 2 minuty.', null::text, false),
         (7::smallint, 'Gotuj sos bez przykrycia na małym ogniu przez 8 minut, od czasu do czasu mieszając.', 'sos lekko zgęstniał, ale pozostaje płynny i nie przywiera do dna'::text, false),
         (8::smallint, 'Gdy upłynie czas gotowania ryżu, sprawdź, czy jest miękki. Odcedź go na sitku, przełóż z powrotem do garnka i przykryj. Odstaw poza palnik do podania. Wykonaj ten krok po sygnale minutnika, niezależnie od postępu gotowania curry.', null::text, false),
         (9::smallint, 'Ułóż kawałki dorsza w sosie w jednej warstwie i polej je sosem. Gotuj na małym ogniu przez 5–6 minut, licząc od ponownego łagodnego wrzenia. Po około 3 minutach ostrożnie odwróć kawałki; nie mieszaj energicznie. Ryba dokończy gotowanie po dodaniu szpinaku.', null::text, true),
         (10::smallint, 'Dodaj szpinak między kawałki dorsza i delikatnie zanurz liście w sosie. Gotuj jeszcze przez 1–2 minuty, aż liście zwiędną. Łączny czas gotowania dorsza wynosi około 6–8 minut. Sprawdź najgrubszy kawałek ryby; jeśli nie jest gotowy, dogotowuj po 1 minucie i sprawdzaj ponownie. Zakończ gotowanie, gdy ryba jest gotowa, aby jej nie przesuszyć.', 'szpinak właśnie zwiędł; temperatura w środku najgrubszego kawałka dorsza wynosi co najmniej 63°C, a mięso jest nieprzezroczyste i łatwo rozdziela się widelcem'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Doprawienie i podanie', 2 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zdejmij patelnię z ognia. Dodaj przygotowany sok z limonki i delikatnie rozprowadź go w sosie. Spróbuj sosu i dopraw odmierzoną solą według smaku; pasta curry może już być słona.', null::text, true),
         (2::smallint, 'Rozdziel ryż oraz curry na przygotowywaną liczbę porcji. Przekładaj rybę ostrożnie, aby kawałki zachowały kształt. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Grochówka z indykiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grochówka z indykiem', 'Treściwa grochówka z mięsem indyka, ziemniakami, warzywami korzeniowymi i majerankiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 821, 1, 2,
  15, 70,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź w porcjach. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
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
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 600, 'ml'::jednostka_miary, 600,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz groch na sitku. Użyj łuskanego grochu dzielonego na połówki; czas całych ziaren może być znacznie dłuższy.', null::text, false),
         (3::smallint, 'Umyj i obierz ziemniaki, marchew i pietruszkę. Ziemniaki pokrój w kostkę około 2 cm, korzenie w kostkę około 1 cm. Obierz i posiekaj cebulę.', null::text, false),
         (4::smallint, 'Indyka pokrój w kostkę około 2 cm. Umyj przybory i ręce po surowym mięsie. Odmierz bulion oraz wodę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie zupy', 70 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę i smaż cebulę 4 minuty.', null::text, false),
         (2::smallint, 'Dodaj groch, bulion, wodę, liść laurowy i ziele angielskie. Doprowadź do wrzenia przez około 5 minut. Gotuj pod uchyloną pokrywką 30 minut na małym ogniu.', null::text, false),
         (3::smallint, 'Dodaj marchew, pietruszkę i ziemniaki. Gotuj 10 minut.', null::text, false),
         (4::smallint, 'Dodaj indyka, doprowadź ponownie do łagodnego wrzenia i gotuj 12–15 minut. Jeśli groch jest nadal twardy, wyjmij gotowe mięso i dogotuj zupę po 5 minut.', 'groch miękki, ziemniaki bez twardego środka, indyk co najmniej 74°C'::text, true),
         (5::smallint, 'Usuń liść laurowy i ziele angielskie. Dodaj majeranek, sól i pieprz; zamieszaj i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz jagnięcy z ciecierzycą i pomidorami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz jagnięcy z ciecierzycą i pomidorami', 'Aromatyczny gulasz jagnięcy z ciecierzycą, pomidorami i korzennymi przyprawami, podany z bulgurem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 738, 1, 2,
  15, 120,
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
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Domowy bulion warzywny';
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

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Mięso osusz i pokrój w kostkę około 3 cm. Po kontakcie z nim umyj przybory i ręce.', null::text, false),
         (3::smallint, 'Obierz i posiekaj cebulę oraz czosnek. Umyj i obierz marchew, pokrój w grube półplasterki.', null::text, false),
         (4::smallint, 'Opłucz i odsącz ciecierzycę. Odmierz bulgur, bulion oraz pomidory.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie i gotowanie kaszy', 120 from przepisy p where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę przez 1 minutę. Obsmaż jagnięcinę partiami po 4–5 minut, obracając; dla porcji bazowej przeznacz około 10 minut. Przełóż na talerz.', null::text, false),
         (2::smallint, 'W tym samym garnku smaż cebulę 4 minuty. Dodaj czosnek, kmin, cynamon i paprykę; smaż 30 sekund.', null::text, false),
         (3::smallint, 'Włóż mięso, dodaj pomidory i bulion. Doprowadź do łagodnego wrzenia przez około 4 minuty. Duś pod przykryciem 60 minut; kontroluj płyn co 20 minut.', null::text, false),
         (4::smallint, 'Dodaj marchew i duś 20 minut. Jeśli jagnięcina nadal jest twarda, przed kolejnym krokiem duś po 15 minut, w razie potrzeby uzupełniając gorącą wodę.', null::text, false),
         (5::smallint, 'Gdy mięso jest już prawie miękkie, ugotuj bulgur na drugim palniku przez czas z opakowania. Wodę do kaszy traktuj jako wodę do gotowania i odcedź jej nadmiar.', null::text, false),
         (6::smallint, 'Dodaj do gulaszu ciecierzycę i gotuj 10 minut, w razie potrzeby bez pokrywki, aby zagęścić sos.', 'mięso łatwo rozdziela się widelcem, marchew miękka'::text, true),
         (7::smallint, 'Dopraw solą i podaj z kaszą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz wołowy z warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz wołowy z warzywami korzeniowymi', 'Długo duszony gulasz wołowy z ziemniakami, marchewką, pasternakiem i selerem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 954, 1, 2,
  18, 150,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź po ostudzeniu. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 360, 'g'::jednostka_miary, 360,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Pręga wołowa bez kości, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 18 from przepisy p where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Wołowinę osusz i pokrój w kostkę około 3 cm. Umyj przybory i ręce po surowym mięsie.', null::text, false),
         (3::smallint, 'Umyj i obierz ziemniaki, marchew, pasternak oraz seler. Pokrój korzenie w kostkę około 1,5 cm, ziemniaki około 2 cm. Obierz i posiekaj cebulę.', null::text, false),
         (4::smallint, 'Odmierz passatę, bulion i wodę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie', 150 from przepisy p where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Obsmaż wołowinę partiami po 4–5 minut, obracając; dla bazy przeznacz około 10 minut. Przełóż na talerz.', null::text, false),
         (2::smallint, 'Smaż cebulę 4 minuty, dodaj paprykę mieloną i mieszaj 20 sekund. Włóż mięso, dodaj passatę, bulion, wodę oraz liść laurowy.', null::text, false),
         (3::smallint, 'Doprowadź do łagodnego wrzenia przez około 5 minut i duś pod przykryciem 90 minut. Co 20–30 minut sprawdź płyn; ubytek uzupełniaj gorącą wodą.', null::text, false),
         (4::smallint, 'Gdy mięso zaczyna mięknąć, dodaj marchew, pasternak, seler oraz ziemniaki. Duś 30–35 minut. Jeśli wołowina po pierwszym duszeniu jest nadal twarda, przed dodaniem warzyw wydłuż duszenie o 15–30 minut.', 'mięso łatwo rozdziela się widelcem; warzywa miękkie, ale nie rozpadają się'::text, true),
         (5::smallint, 'Usuń liść laurowy, dodaj majeranek, sól i pieprz. Wymieszaj i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz z białej fasoli, jarmużu i pomidorów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz z białej fasoli, jarmużu i pomidorów', 'Gęsty roślinny gulasz z białej fasoli, jarmużu i pomidorów, podany z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 748, 1, 2,
  12, 37,
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
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 4
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
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Domowy bulion warzywny';
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

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz i odsącz fasolę. Umyj jarmuż, usuń twarde łodygi i porwij liście.', null::text, false),
         (3::smallint, 'Umyj i obierz marchew i pokrój w kostkę około 1 cm. Obierz i posiekaj cebulę oraz czosnek. Przygotuj pieczywo oraz odmierz bulion i pomidory.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 37 from przepisy p where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę przez 1 minutę. Dodaj cebulę i marchew, smaż 5 minut.', null::text, false),
         (2::smallint, 'Dodaj czosnek, tymianek i paprykę wędzoną; smaż 30 sekund. Wlej bulion i dodaj pomidory. Doprowadź do wrzenia przez około 3 minuty.', null::text, false),
         (3::smallint, 'Gotuj pod uchyloną pokrywką przez 15 minut, aż marchew będzie prawie miękka. Dodaj fasolę i gotuj 5 minut.', null::text, false),
         (4::smallint, 'Dodaj jarmuż i gotuj jeszcze 5 minut.', 'liście jarmużu są miękkie, marchew bez twardego środka'::text, true),
         (5::smallint, 'Dopraw solą i pieprzem, podaj z przygotowanym pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Jaglanka z gruszką i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jaglanka z gruszką i orzechami', 'Kremowa kasza jaglana na mleku z gruszką, cynamonem i orzechami włoskimi. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 432, 1, 1,
  7, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Rondel', 'Sitko', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj trochę mleka. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeżeli kasza jest nadal twarda, dodaj trochę gorącej wody i gotuj po 3 minuty, mieszając. Kaszy lub orzechów o zjełczałym zapachu nie używaj; cynamon nie usunie przyczyny takiej goryczy.'
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Kaszę przepłucz na sitku pod bieżącą wodą i przelej wrzątkiem.', null::text, false),
         (3::smallint, 'Umyj gruszkę, usuń gniazdo nasienne i pokrój w kostkę. Posiekaj orzechy. Odmierz mleko, miód, cynamon i sól.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 25 from przepisy p where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wlej mleko do rondla, dodaj kaszę i sól. Doprowadź do łagodnego wrzenia przez około 3 minuty.', null::text, false),
         (2::smallint, 'Gotuj na małym ogniu pod uchyloną pokrywką przez 15–18 minut lub czas wskazany na opakowaniu, często mieszając przy dnie. W razie potrzeby uzupełnij odparowany płyn gorącą wodą.', null::text, false),
         (3::smallint, 'Dodaj gruszkę i cynamon, gotuj jeszcze 2 minuty.', 'kasza jest miękka i kremowa'::text, true),
         (4::smallint, 'Zdejmij z ognia, dodaj miód i orzechy, podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jaglanka z gruszką i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Jajecznica z pomidorem i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajecznica z pomidorem i szczypiorkiem', 'Kremowa jajecznica z pomidorem i świeżym szczypiorkiem, podana z dwiema kromkami chleba żytniego. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 267, 1, 1,
  6, 7,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Jajecznicę zjedz bezpośrednio po przygotowaniu.',
  false, 'Płyn z pomidora odparuj przed dodaniem jajek. Gdy jajecznica się zetnie, natychmiast zdejmij ją z ognia, aby nie wyschła.'
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
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i szczypiorek. Pomidora pokrój w kostkę, szczypiorek posiekaj. Przygotuj pieczywo.', null::text, false),
         (3::smallint, 'Wbij jajka do miski, dodaj sól i pieprz, roztrzep widelcem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 7 from przepisy p where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozpuść masło na patelni przez około 1 minutę na średnim ogniu. Dodaj pomidora i smaż 2 minuty; przed dodaniem jajek odparuj nadmiar płynu.', null::text, false),
         (2::smallint, 'Wlej jajka, zmniejsz ogień i smaż 2–3 minuty, łagodnie mieszając.', 'jajka są ścięte, bez płynnego białka; pozostają wilgotne'::text, true),
         (3::smallint, 'Zdejmij z ognia, dodaj szczypiorek i podaj z pieczywem w ilości wskazanej na liście.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica z pomidorem i szczypiorkiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Jajka na miękko z pieczywem i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajka na miękko z pieczywem i warzywami', 'Jajka z płynnym żółtkiem, podane z pieczywem posmarowanym masłem, pomidorem i ogórkiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 307, 1, 1,
  5, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Łyżka cedzakowa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie najlepiej zjedz od razu po przygotowaniu. Jajek ugotowanych na miękko nie przechowuj na później.',
  false, 'Jeśli po otwarciu białko jest płynne, przełóż zawartość do małego naczynia i dogotuj do ścięcia. Jajka z twardym żółtkiem możesz rozgnieść na pieczywie z masłem.'
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
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'miękkie, do pieczywa', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Masło';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'szt'::jednostka_miary, round((0.5 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w cząstki', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.25, 'szt'::jednostka_miary, round((0.25 * sk.masa_sztuki_g)::numeric, 1),
       'pokrojony w plasterki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i ogórek. Pomidora pokrój w cząstki, a ogórek w plasterki.', null::text, false),
         (3::smallint, 'Kromki chleba posmaruj masłem. Pieczywo i warzywa ułóż na talerzu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie jajek', 12 from przepisy p where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'W garnku zagotuj tyle wody, aby po włożeniu całkowicie przykryła jajka.', null::text, false),
         (2::smallint, 'Ostrożnie włóż zimne jajka do wrzątku i gotuj około 6 minut od zanurzenia; dla dużych jajek czas może wynieść 7 minut, utrzymując łagodne wrzenie.', null::text, true),
         (3::smallint, 'Wyjmij jajka, schładzaj je pod zimną wodą przez około 30 sekund i od razu podaj z pieczywem oraz warzywami. Dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka na miękko z pieczywem i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z Goudą, jajkiem i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z Goudą, jajkiem i szczypiorkiem', 'Syte kanapki z serem Gouda, jajkiem na twardo, pomidorem i szczypiorkiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 286, 1, 1,
  5, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Łyżka cedzakowa']::text[]) with ordinality as v(nazwa, poz)
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i szczypiorek, pokrój pomidora w plastry, szczypiorek posiekaj. Pokrój Goudę w plastry, przygotuj pieczywo i jogurt.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie jajek', 18 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj w garnku wodę przykrywającą jajka. Włóż je ostrożnie i gotuj przez 9–10 minut przy łagodnym wrzeniu, licząc od włożenia. Schłodź zimną wodą i obierz.', null::text, false),
         (2::smallint, 'Pokrój obrane jajka w plastry.', 'żółtka i białka są całkowicie ścięte'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Składanie kanapek', 2 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Posmaruj pieczywo jogurtem. Ułóż Goudę, pomidora i jajka. Posyp szczypiorkiem i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, jajkiem i szczypiorkiem') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Kanapki z Goudą, pomidorem i sałatą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z Goudą, pomidorem i sałatą', 'Klasyczne kanapki z serem Gouda, pomidorem, ogórkiem i sałatą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 276, 1, 1,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz pomidora, ogórek oraz sałatę. Pomidora, ogórek i Goudę pokrój w plastry. Przygotuj pieczywo, musztardę i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 2 from przepisy p where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Posmaruj pieczywo musztardą. Ułóż sałatę, Goudę, pomidora i ogórek. Dopraw pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z Goudą, pomidorem i sałatą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z halloumi, awokado i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z halloumi, awokado i pomidorem', 'Kanapki z grillowanym halloumi, awokado, pomidorem i rukolą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 326, 1, 1,
  8, 7,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora, rukolę i cytrynę; osusz rukolę. Odmierz sok z cytryny.', null::text, false),
         (3::smallint, 'Umyj awokado, usuń pestkę i skórkę, pokrój miąższ i skrop sokiem. Pomidora oraz halloumi pokrój w plastry; ser osusz. Przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie kanapek', 7 from przepisy p where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej suchą patelnię nieprzywierającą przez 1 minutę.', null::text, false),
         (2::smallint, 'Smaż halloumi po około 2 minuty z każdej strony na średnim ogniu.', 'ser jest złoty na powierzchni'::text, true),
         (3::smallint, 'Na pieczywie ułóż rukolę, awokado, pomidora i ciepły ser. Dopraw pieprzem i od razu podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z halloumi, awokado i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z jajkiem, awokado i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z jajkiem, awokado i pomidorem', 'Syte kanapki z dwoma jajkami na twardo, kremowym awokado i świeżym pomidorem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 317, 1, 1,
  6, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Łyżka cedzakowa']::text[]) with ordinality as v(nazwa, poz)
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i awokado. Pomidora pokrój w plastry.', null::text, false),
         (3::smallint, 'Usuń pestkę i skórkę awokado. Rozgnieć miąższ widelcem z częścią odmierzonej soli i pieprzu; przykryj miskę, aby ograniczyć ciemnienie. Przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie jajek i składanie', 20 from przepisy p where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj w garnku wodę przykrywającą jajka. Włóż je ostrożnie i gotuj przez 9–10 minut przy łagodnym wrzeniu, licząc od włożenia. Schłodź zimną wodą i obierz.', null::text, false),
         (2::smallint, 'Pokrój jajka w plastry. Posmaruj pieczywo awokado, ułóż pomidora i jajka. Dopraw pozostałą solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z jajkiem, awokado i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z mozzarellą, pomidorem i bazylią
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z mozzarellą, pomidorem i bazylią', 'Kanapki z mozzarellą, świeżym pomidorem i bazylią, skropione oliwą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 226, 1, 1,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i bazylię, osusz. Mozzarellę odsącz. Pokrój ser i pomidora w plastry. Przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 2 from przepisy p where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pieczywie ułóż mozzarellę, pomidora i bazylię. Skrop odmierzoną oliwą, dopraw solą i pieprzem, podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z pastą jajeczną
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z pastą jajeczną', 'Trzy kromki chleba żytniego z kremową pastą z jajek, jogurtu, musztardy i szczypiorku. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 261, 1, 1,
  5, 21,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Łyżka cedzakowa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Pastę przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Pieczywo smaruj dopiero przed podaniem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
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
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Kanapki z pastą jajeczną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i posiekaj szczypiorek. Odmierz jogurt oraz musztardę, przygotuj pieczywo w ilości z listy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie jajek i przygotowanie pasty', 21 from przepisy p where lower(p.nazwa) = lower('Kanapki z pastą jajeczną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj w garnku wodę przykrywającą jajka. Włóż je ostrożnie i gotuj przez 9–10 minut przy łagodnym wrzeniu, licząc od włożenia. Schłodź zimną wodą i obierz.', null::text, false),
         (2::smallint, 'Rozgnieć jajka widelcem w misce. Dodaj jogurt, musztardę i szczypiorek. Dopraw solą oraz pieprzem, wymieszaj.', null::text, false),
         (3::smallint, 'Posmaruj przygotowane pieczywo pastą i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z pastą jajeczną') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z ricottą, rzodkiewką i szczypiorkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z ricottą, rzodkiewką i szczypiorkiem', 'Delikatne kanapki z ricottą, chrupiącą rzodkiewką i świeżym szczypiorkiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 251, 1, 1,
  10, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Gotowe kanapki zjedz od razu. Samą pastę z ricotty przechowuj w lodówce do 1 dnia; pieczywo smaruj przed podaniem.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj rzodkiewki i szczypiorek. Odetnij końcówki rzodkiewek, pokrój w cienkie plasterki. Posiekaj szczypiorek. Przygotuj pieczywo i odmierz ricottę oraz jogurt.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 4 from przepisy p where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj ricottę z jogurtem, szczypiorkiem, solą i pieprzem. Posmaruj pieczywo i ułóż rzodkiewkę. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z sardynkami, pomidorem i rukolą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z sardynkami, pomidorem i rukolą', 'Szybkie kanapki z sardynkami, pomidorem, rukolą i cytryną. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 356, 1, 1,
  10, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Odsącz sardynki. Umyj pomidora, rukolę i cytrynę. Osusz rukolę, pokrój pomidora, wyciśnij i odmierz sok z cytryny. Przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 4 from przepisy p where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgnieć sardynki widelcem z odmierzoną oliwą, sokiem z cytryny i pieprzem.', null::text, false),
         (2::smallint, 'Na pieczywie ułóż rukolę, pastę oraz pomidora. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kanapki z serem salami, ogórkiem kiszonym i musztardą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kanapki z serem salami, ogórkiem kiszonym i musztardą', 'Wyraziste kanapki z serem salami, ogórkiem kiszonym, musztardą i czerwoną cebulą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 271, 1, 1,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz sałatę. Obierz cebulę, pokrój ją w cienkie piórka. Odsącz ogórki i pokrój w plastry. Pokrój ser salami w plastry, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 2 from przepisy p where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Posmaruj pieczywo musztardą, ułóż sałatę, ser, ogórki i cebulę. Dopraw pieprzem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kałamarnica z papryką i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kałamarnica z papryką i ryżem', 'Krótko smażona kałamarnica z papryką, pomidorami i ziołami, podana z ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 600, 1, 1,
  12, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
  false, 'Jeżeli kałamarnica jest gumowata, krótkie dodatkowe smażenie jej nie zmiękczy. Możesz przejść na dłuższe duszenie w sosie przez około 30–40 minut, kontrolując miękkość co 10 minut i uzupełniając gorącą wodę. Wydłuży to przygotowanie.'
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj paprykę, usuń nasiona i pokrój w cienkie paski. Obierz cebulę i czosnek; cebulę pokrój w piórka, czosnek posiekaj.', null::text, false),
         (3::smallint, 'Umyj i posiekaj natkę. Umyj cytrynę i przygotuj sok z odmierzonej części. Opłucz ryż na sitku.', null::text, false),
         (4::smallint, 'Oczyszczoną, rozmrożoną kałamarnicę osusz i pokrój w krążki około 1 cm. Po surowych owocach morza umyj przybory i ręce. Odmierz passatę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i sosu', 25 from przepisy p where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj ryż i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzej oliwę przez 1 minutę. Dodaj cebulę i paprykę, smaż 5–6 minut.', null::text, false),
         (3::smallint, 'Dodaj czosnek oraz wędzoną paprykę i smaż 30 sekund. Wlej passatę, zagotuj przez około 2 minuty i gotuj łagodnie jeszcze 5 minut. Zakończ gotowanie ryżu przed dodaniem kałamarnicy.', null::text, false),
         (4::smallint, 'Do gorącego sosu dodaj krążki kałamarnicy i gotuj 2–3 minuty, delikatnie mieszając.', 'krążki są nieprzezroczyste i jędrne, ale nie gumowate'::text, true),
         (5::smallint, 'Zdejmij z ognia, dodaj przygotowany sok z cytryny, sól i natkę. Podaj od razu z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Klopsiki z indyka w sosie pomidorowym z bulgurem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Delikatne klopsiki z indyka duszone w sosie pomidorowym, podane z kaszą bulgur. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 652, 1, 1,
  18, 32,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Klopsiki z sosem przechowuj w lodówce do 3 dni albo zamroź. Kaszę trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeśli masa jest miękka, schłódź ją przez 15 minut i formuj niewielkie klopsiki mokrymi dłońmi. Nie obracaj ich, zanim spód się zetnie. Gęstniejący sos rozrzedzaj niewielką ilością gorącej wody.'
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 18 from przepisy p where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Obierz i drobno posiekaj cebulę oraz czosnek. Odmierz passatę i kaszę.', null::text, false),
         (3::smallint, 'Roztrzep jajko w misce. Połącz mięso z jajkiem, bułką tartą, połową cebuli oraz częścią soli i pieprzu. Odstaw na 5 minut, aby bułka wchłonęła wilgoć.', null::text, false),
         (4::smallint, 'Wilgotnymi dłońmi uformuj klopsiki o średnicy około 3 cm. Umyj przybory i ręce po surowym mięsie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy i duszenie klopsików', 32 from przepisy p where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj kaszę bulgur i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzej olej przez 1 minutę. Obsmaż klopsiki przez 5–6 minut, ostrożnie obracając. Przełóż na talerz.', null::text, false),
         (3::smallint, 'Na tej samej patelni smaż pozostałą cebulę przez 4 minuty. Dodaj czosnek, oregano i paprykę; smaż 30 sekund.', null::text, false),
         (4::smallint, 'Dodaj passatę i doprowadź do łagodnego wrzenia przez około 2 minuty.', null::text, false),
         (5::smallint, 'Włóż klopsiki i duś pod przykryciem przez 15 minut na małym ogniu. Obróć je w połowie; w razie gęstnienia sosu dodaj trochę gorącej wody.', 'temperatura w środku największego klopsika wynosi co najmniej 74°C'::text, true),
         (6::smallint, 'Dopraw sos pozostałą solą i pieprzem. Podaj z odcedzoną kaszą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Komosa ryżowa z ciecierzycą i pieczonymi warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Miska z komosą ryżową, ciecierzycą, cukinią, papryką i pomidorem, doprawiona cytryną. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz', 'z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 658, 1, 1,
  12, 42,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj cukinię, paprykę i pomidory; usuń gniazdo nasienne papryki. Cukinię i paprykę pokrój na kawałki około 2 cm, pomidory w ćwiartki. Obierz cebulę i pokrój w piórka.', null::text, false),
         (3::smallint, 'Opłucz komosę na sitku. Opłucz, odsącz i osusz ciecierzycę. Umyj i posiekaj natkę; przygotuj odmierzoną ilość soku z cytryny.', null::text, false),
         (4::smallint, 'Warzywa oraz ciecierzycę wymieszaj z oliwą, oregano, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 42 from przepisy p where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół; zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż warzywa i ciecierzycę luźno na blasze. Piecz 25–30 minut, obracając w połowie.', null::text, false),
         (3::smallint, 'Podczas pieczenia ugotuj komosę przez czas z opakowania w dodatkowej wodzie. Odcedź i odstaw pod przykryciem na 5 minut.', null::text, false),
         (4::smallint, 'Połącz komosę, upieczone warzywa i ciecierzycę. Dodaj sok z cytryny oraz natkę.', 'warzywa są miękkie i zarumienione, ziarna komosy miękkie'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kotleciki z czerwonej soczewicy z sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Rumiane kotleciki z czerwonej soczewicy i płatków owsianych, podane z ogórkowym sosem jogurtowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  2, 'prywatna',
  'waga', 407, 1, 1,
  12, 57,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Patelnia 28 cm', 'Miska', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Widelec']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kotleciki przechowuj w lodówce do 2 dni albo zamroź po ostudzeniu. Sos jogurtowy przechowuj osobno w lodówce, bez mrożenia. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeśli masa się rozpada, dodaj płatki owsiane i odczekaj 5 minut. Za gęsty sos rozrzedź wodą.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz soczewicę na sitku. Obierz marchew i zetrzyj; obierz i drobno posiekaj cebulę oraz czosnek.', null::text, false),
         (3::smallint, 'Umyj ogórek, zetrzyj go i odciśnij nadmiar soku. Przygotuj sok z cytryny oraz odmierz jogurt i płatki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie soczewicy i przygotowanie masy', 42 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę, co zwykle trwa około 5 minut, i gotuj soczewicę 12–15 minut, do miękkości. Dokładnie odcedź na sitku i odstaw na 10 minut do odparowania.', null::text, false),
         (2::smallint, 'Równolegle rozgrzej połowę oleju na patelni przez 1 minutę. Smaż cebulę i marchew 5 minut, dodaj czosnek, kmin i paprykę; smaż jeszcze 30 sekund.', null::text, false),
         (3::smallint, 'Rozgnieć soczewicę widelcem. Dodaj podsmażone warzywa, płatki oraz część soli i pieprzu. Wymieszaj i odstaw na 10 minut, żeby płatki wchłonęły wilgoć.', null::text, false),
         (4::smallint, 'W tym czasie wymieszaj jogurt z ogórkiem, sokiem z cytryny i pozostałą solą oraz pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Formowanie i smażenie', 15 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Uformuj kotleciki grubości około 1,5 cm. Rozgrzej pozostały olej na patelni nieprzywierającej przez 1 minutę.', null::text, false),
         (2::smallint, 'Smaż po 4–5 minut z każdej strony na średnim ogniu. Obracaj dopiero po zrumienieniu spodu. Przy większej ilości smaż partiami, doliczając czas kolejnej partii.', 'kotleciki utrzymują kształt i mają rumianą powierzchnię'::text, true),
         (3::smallint, 'Podaj z sosem jogurtowym.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Krem z brokułów z fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem z brokułów z fetą', 'Kremowa zupa brokułowa z ziemniakiem, jogurtem i fetą, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 771, 1, 2,
  10, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Jeśli planujesz mrożenie, odłóż porcję przed dodaniem jogurtu i fety; dodaj je dopiero po rozmrożeniu i podgrzaniu. Pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 440, 'g'::jednostka_miary, 440,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Gałka muszkatołowa mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Krem z brokułów z fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj brokuł i podziel na małe różyczki; obrany miękki środek łodygi pokrój drobno. Umyj i obierz ziemniaki, pokrój w kostkę około 1 cm.', null::text, false),
         (3::smallint, 'Obierz i posiekaj cebulę oraz czosnek. Pokrusz fetę, odmierz bulion i jogurt, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z brokułów z fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i blendowanie', 35 from przepisy p where lower(p.nazwa) = lower('Krem z brokułów z fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę 1 minutę, smaż cebulę 4 minuty. Dodaj czosnek i smaż 30 sekund.', null::text, false),
         (2::smallint, 'Dodaj ziemniaki, pokrojoną łodygę brokułu i bulion. Doprowadź do wrzenia przez około 4 minuty; gotuj pod przykryciem 12 minut.', null::text, false),
         (3::smallint, 'Dodaj różyczki i gotuj 6–8 minut, aż ziemniaki i brokuł będą miękkie.', null::text, false),
         (4::smallint, 'Zdejmij garnek z ognia. Zblenduj zupę, trzymając końcówkę blendera zanurzoną. Dodaj gałkę oraz pieprz. Jeśli część mrozisz, odłóż ją teraz.', null::text, false),
         (5::smallint, 'Wymieszaj jogurt z odrobiną ciepłej zupy, następnie wmieszaj do garnka. Nie zagotowuj ponownie. Podaj z fetą i pieczywem.', 'krem jest gładki, bez grudek jogurtu'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z brokułów z fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krem z dyni na mleku kokosowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem z dyni na mleku kokosowym', 'Aromatyczny krem z dyni, czerwonej soczewicy, imbiru i mleka kokosowego. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 797, 1, 2,
  13, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź po szybkim schłodzeniu. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 500, 'g'::jednostka_miary, 500,
       'pokrojona w kostkę', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Dynia, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'ml'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Olej rzepakowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'sok', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'umyta, osuszona i posiekana; do posypania przed podaniem', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 13 from przepisy p where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj dynię, usuń nasiona i twardą skórę; pokrój miąższ w kostkę około 2 cm. Umyj i obierz marchew, pokrój w cienkie plasterki.', null::text, false),
         (3::smallint, 'Obierz i posiekaj cebulę, czosnek oraz imbir. Opłucz soczewicę. Umyj limonkę, wyciśnij i odmierz sok. Odmierz bulion, wodę i mleko kokosowe. Umyj i osusz natkę pietruszki, drobno posiekaj i odłóż do podania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i blendowanie', 35 from przepisy p where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej 1 minutę, smaż cebulę 4 minuty. Dodaj czosnek, imbir i pastę curry, smaż 1 minutę.', null::text, false),
         (2::smallint, 'Dodaj dynię, marchew, soczewicę, bulion i wodę. Doprowadź do wrzenia przez około 4 minuty. Gotuj pod uchyloną pokrywką przez 20 minut, mieszając co kilka minut.', null::text, false),
         (3::smallint, 'Sprawdź miękkość warzyw i soczewicy; w razie potrzeby gotuj kolejne 3–5 minut. Dodaj mleko kokosowe i podgrzewaj 2 minuty.', 'warzywa dają się łatwo rozgnieść, soczewica miękka'::text, true),
         (4::smallint, 'Zdejmij z ognia i zblenduj z zanurzoną końcówką blendera. Dodaj sok z limonki oraz sól i wymieszaj. Rozlej krem do talerzy, posyp przygotowaną natką pietruszki i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krem z kalafiora z pieczoną ciecierzycą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krem z kalafiora z pieczoną ciecierzycą', 'Krem z kalafiora i ziemniaka podany z pieczoną ciecierzycą oraz pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 797, 1, 2,
  12, 42,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Krem przechowuj w lodówce do 3 dni lub zamroź. Ciecierzycę i pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 440, 'g'::jednostka_miary, 440,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Kalafior, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'pokrojone', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'dokładnie osuszona', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Ciecierzyca z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'g'::jednostka_miary, 500,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz ciecierzycę, odsącz i dokładnie osusz. Wymieszaj z połową oliwy, kminem i wędzoną papryką.', null::text, false),
         (3::smallint, 'Umyj kalafior, podziel na różyczki. Umyj i obierz ziemniaki, pokrój w kostkę około 1 cm. Obierz i posiekaj cebulę oraz czosnek. Odmierz bulion, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i pieczenie', 42 from przepisy p where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół, zwykle około 10 minut. Rozłóż ciecierzycę na blasze i piecz 25–30 minut, mieszając w połowie.', null::text, false),
         (2::smallint, 'Już podczas rozgrzewania piekarnika rozgrzej pozostałą oliwę w garnku przez 1 minutę. Smaż cebulę 4 minuty, dodaj czosnek i smaż 30 sekund.', null::text, false),
         (3::smallint, 'Dodaj ziemniaki, kalafior i bulion. Doprowadź do wrzenia przez około 4 minuty, gotuj pod przykryciem 18–20 minut.', null::text, false),
         (4::smallint, 'Zdejmij garnek z ognia i sprawdź miękkość warzyw. Zblenduj z zanurzoną końcówką, dopraw solą i pieprzem.', null::text, false),
         (5::smallint, 'Podaj krem z upieczoną ciecierzycą i pieczywem; ciecierzycę dodawaj dopiero na talerzu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krewetki z czosnkiem, cukinią i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krewetki z czosnkiem, cukinią i ryżem', 'Krewetki smażone z czosnkiem, cukinią, chili i cytryną, podane z ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 442, 1, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz ryż. Umyj cukinię i pokrój w półplasterki około 5 mm. Obierz i posiekaj czosnek.', null::text, false),
         (3::smallint, 'Umyj natkę i cytrynę, posiekaj natkę i odmierz sok. Krewetki obierz, usuń przewód pokarmowy, jeśli pozostał, i osusz; mrożone wcześniej rozmroź w lodówce. Umyj ręce i przybory po surowych krewetkach.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj ryż i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Gdy do końca gotowania ryżu pozostaje około 10 minut, rozgrzej połowę oliwy na patelni przez 1 minutę. Smaż cukinię na średnio dużym ogniu 4–5 minut i przełóż na talerz. Nadmiar wody odparuj teraz, przed dodaniem krewetek.', null::text, false),
         (3::smallint, 'Wlej pozostałą oliwę i zmniejsz ogień do średniego. Dodaj czosnek i chili, smaż 20–30 sekund.', null::text, false),
         (4::smallint, 'Dodaj krewetki i smaż łącznie 3–4 minuty, obracając w połowie; większe mogą wymagać nieco dłużej.', 'mięso jest nieprzezroczyste i perłowe także w środku'::text, true),
         (5::smallint, 'Dodaj cukinię, wymieszaj i zdejmij z ognia. Dopraw przygotowanym sokiem z cytryny, solą i natką. Podaj z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Królik z rozmarynem i warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Królik z rozmarynem i warzywami korzeniowymi', 'Królik pieczony z ziemniakami, marchewką, pasternakiem, selerem i rozmarynem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 732, 1, 1,
  18, 90,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 3 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 18 from przepisy p where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz ziemniaki, marchew, pasternak i seler, pokrój w kawałki około 2 cm. Obierz cebulę i pokrój w ósemki.', null::text, false),
         (3::smallint, 'Obierz i posiekaj czosnek. Umyj rozmaryn. Mięso królika osusz i podziel na kawałki około 4 cm; podana ilość dotyczy mięsa bez kości.', null::text, false),
         (4::smallint, 'Natrzyj mięso połową oliwy, czosnkiem, rozmarynem, częścią soli i pieprzu. Warzywa wymieszaj z pozostałą oliwą i przyprawami. Umyj przybory po mięsie; odmierz bulion.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie pod przykryciem', 90 from przepisy p where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 180°C, grzanie góra–dół, zwykle około 10 minut. Ułóż mięso z cebulą w naczyniu, wlej bulion i przykryj naczynie pokrywą.', null::text, false),
         (2::smallint, 'Piecz pod przykryciem 35 minut. Dodaj ziemniaki, marchew, pasternak i seler; polej płynem i ponownie przykryj.', null::text, false),
         (3::smallint, 'Piecz kolejne 35–40 minut. Jeśli mięso jest nadal twarde, piecz dalej po 10 minut pod przykryciem, kontrolując ilość płynu.', 'królik jest miękki, ma co najmniej 71°C w środku; warzywa miękkie'::text, true),
         (4::smallint, 'Podaj, polewając mięso i warzywa płynem z pieczenia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kurczak pieczony z batatem i brokułem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kurczak pieczony z batatem i brokułem', 'Pierś kurczaka pieczona na jednej blasze z batatem, brokułem i czerwoną cebulą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 709, 1, 1,
  12, 47,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 3 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeżeli kurczak jest gotowy wcześniej niż batat, wyjmij go i dopiecz sam batat. Brokuł mocno rumieniący się na brzegach również zdejmij wcześniej.'
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz batata, pokrój w kostkę około 2 cm. Umyj brokuł i podziel na małe różyczki. Obierz cebulę i pokrój w piórka, czosnek posiekaj.', null::text, false),
         (3::smallint, 'Podziel oliwę między warzywa i mięso. Batata, cebulę i brokuł wymieszaj oddzielnie z oliwą oraz częścią tymianku, papryki wędzonej, soli i pieprzu.', null::text, false),
         (4::smallint, 'Pierś osusz i wyrównaj grubość do około 2–3 cm. Natrzyj oliwą, czosnkiem i pozostałymi przyprawami. Umyj ręce i przybory po mięsie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 47 from przepisy p where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż batata i cebulę na blasze. Piecz 15 minut.', null::text, false),
         (3::smallint, 'Dodaj kurczaka i brokuł, układając luźno. Piecz 18–22 minuty.', null::text, false),
         (4::smallint, 'Sprawdź mięso termometrem w najgrubszym miejscu; gotowego kurczaka zdejmij. Niedopieczone warzywa dopiekaj osobno przez kolejne 5 minut.', 'kurczak ma co najmniej 74°C, batat miękki, brokuł lekko rumiany'::text, true),
         (5::smallint, 'Podaj mięso z warzywami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron pełnoziarnisty z bolońskim sosem z soczewicy
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Pełnoziarnisty makaron z gęstym pomidorowym sosem z czerwonej soczewicy i warzyw. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 711, 1, 1,
  10, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Garnek 2 l', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Sos przechowuj w lodówce do 3 dni lub zamroź. Makaron najlepiej ugotować świeży. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz marchew, zetrzyj na tarce. Obierz i posiekaj cebulę oraz czosnek.', null::text, false),
         (3::smallint, 'Opłucz soczewicę na sitku. Odmierz wodę z listy, passatę i makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie sosu i makaronu', 35 from przepisy p where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę w garnku przez 1 minutę, smaż cebulę i marchew 5 minut. Dodaj czosnek, oregano, bazylię i paprykę; smaż 30 sekund.', null::text, false),
         (2::smallint, 'Dodaj soczewicę oraz odmierzoną wodę. Doprowadź do wrzenia przez około 2 minuty i gotuj pod uchyloną pokrywką 12–15 minut, często mieszając. Uzupełnij odparowaną wodę, jeżeli soczewica jeszcze nie zmiękła.', null::text, false),
         (3::smallint, 'Już podczas gotowania soczewicy nastaw wodę na makaron na drugim palniku. Ugotuj go przez czas z opakowania tak, aby był gotowy pod koniec gotowania sosu; zachowaj nieco wody przed odcedzeniem. Do miękkiej soczewicy dodaj passatę i gotuj sos 10 minut bez przykrycia.', null::text, false),
         (4::smallint, 'Wymieszaj sos z makaronem, dopraw solą i pieprzem. W razie potrzeby rozluźnij wodą z makaronu.', 'soczewica miękka, sos oblepia makaron'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z brokułem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z brokułem i fetą', 'Pełnoziarnisty makaron z brokułem, fetą, czosnkiem i cytryną. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 406, 1, 1,
  8, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Makaron z brokułem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj brokuł i podziel na małe różyczki; obraną łodygę pokrój cienko. Obierz i posiekaj czosnek.', null::text, false),
         (3::smallint, 'Pokrusz fetę. Umyj cytrynę, wyciśnij i odmierz sok. Odmierz makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i łączenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z brokułem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę i gotuj makaron przez czas z opakowania. Na ostatnie 4 minuty dodaj małe różyczki i cienko pokrojoną łodygę brokułu.', null::text, false),
         (2::smallint, 'Zachowaj trochę wody z gotowania i odcedź makaron z brokułem.', null::text, false),
         (3::smallint, 'Pod koniec gotowania makaronu rozgrzej oliwę na patelni przez 1 minutę. Dodaj czosnek i ostrą paprykę, smaż 20–30 sekund.', null::text, false),
         (4::smallint, 'Dodaj makaron z brokułem, fetę i odrobinę zachowanej wody. Mieszaj na małym ogniu przez 1 minutę. Zdejmij z ognia i dodaj sok z cytryny oraz pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z ciecierzycą, bazylią i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z ciecierzycą, bazylią i orzechami', 'Pełnoziarnisty makaron z ciecierzycą i szybkim sosem z bazylii, orzechów oraz oliwy. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 396, 1, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj odrobinę wody. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz i odsącz ciecierzycę. Umyj pomidory i bazylię, osusz liście. Pokrój pomidory.', null::text, false),
         (3::smallint, 'Obierz czosnek. Posiekaj orzechy. Umyj cytrynę i odmierz sok. Przygotuj makaron i oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i przygotowanie sosu', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Ugotuj makaron przez czas z opakowania. Przed odcedzeniem zachowaj nieco wody z gotowania.', null::text, false),
         (2::smallint, 'Podczas gotowania makaronu zblenduj bazylię, orzechy, oliwę, czosnek, sok z cytryny, sól i pieprz. Rozluźnij sos niewielką ilością ciepłej, nie wrzącej wody z makaronu.', null::text, false),
         (3::smallint, 'Na ostatnie 2 minuty gotowania makaronu dodaj ciecierzycę do garnka. Odcedź całość.', null::text, false),
         (4::smallint, 'Poza ogniem wymieszaj makaron i ciecierzycę z sosem oraz pokrojonymi pomidorami. Podaj bez dodatkowego gotowania bazylii.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z indykiem, pieczarkami i jogurtem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z indykiem, pieczarkami i jogurtem', 'Pełnoziarnisty makaron z indykiem i pieczarkami w lekkim sosie jogurtowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 561, 1, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj łagodnie, do gorącego środka całej porcji. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jogurt dodawaj poza ogniem po zahartowaniu. Jeśli sos się zwarzył, łagodne mieszanie może poprawić konsystencję, ale nie cofnie całkowicie zwarzenia. Za gęsty sos rozluźnij ciepłą wodą.'
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Oczyść pieczarki i pokrój w plasterki. Obierz i posiekaj cebulę oraz czosnek. Odmierz makaron i jogurt.', null::text, false),
         (3::smallint, 'Indyka osusz i pokrój w paski grubości około 1 cm. Umyj przybory i ręce po surowym mięsie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę w garnku i ugotuj makaron przez czas wskazany na opakowaniu. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku. Przed odcedzeniem zachowaj nieco wody z gotowania. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzej połowę oleju przez 1 minutę. Smaż indyka 5–6 minut, obracając, do temperatury co najmniej 74°C. Zdejmij na czysty talerz.', null::text, false),
         (3::smallint, 'Dodaj pozostały olej, cebulę i pieczarki; smaż 7–9 minut, aż woda odparuje. Dodaj czosnek i tymianek, smaż 30 sekund.', null::text, false),
         (4::smallint, 'W misce połącz jogurt z niewielką ilością ciepłej wody z makaronu, dodawanej stopniowo.', null::text, false),
         (5::smallint, 'Do patelni dodaj makaron i indyka, podgrzej przez 1 minutę. Zdejmij z ognia, odczekaj około 1 minuty, wmieszaj jogurt i dopraw solą oraz pieprzem. Nie zagotowuj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z kurczakiem, szpinakiem i pomidorami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z kurczakiem, szpinakiem i pomidorami', 'Pełnoziarnisty makaron z kurczakiem, szpinakiem i pomidorowym sosem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 642, 1, 1,
  10, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i odsącz szpinak, usuń grube łodygi. Obierz i posiekaj cebulę oraz czosnek. Odmierz makaron, pomidory i passatę.', null::text, false),
         (3::smallint, 'Kurczaka osusz i pokrój w paski około 1 cm. Umyj przybory i ręce po mięsie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie makaronu i sosu', 25 from przepisy p where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę w garnku i ugotuj makaron przez czas wskazany na opakowaniu. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku. Przed odcedzeniem zachowaj nieco wody z gotowania. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Rozgrzej oliwę na drugim palniku przez 1 minutę. Smaż kurczaka 5–6 minut do temperatury co najmniej 74°C, obracając. Zdejmij na czysty talerz.', null::text, false),
         (3::smallint, 'Na tej samej patelni smaż cebulę 4 minuty; gdy przywiera, dodaj odrobinę wody z makaronu. Dodaj czosnek, smaż 30 sekund.', null::text, false),
         (4::smallint, 'Dodaj pomidory, passatę, oregano i bazylię suszoną. Doprowadź do łagodnego wrzenia i gotuj przez 8 minut.', null::text, false),
         (5::smallint, 'Dodaj szpinak, gotuj 1–2 minuty do zwiędnięcia. Włóż kurczaka oraz odcedzony makaron, podgrzej przez 1 minutę. Dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z pieczonymi warzywami i mozzarellą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z pieczonymi warzywami i mozzarellą', 'Pełnoziarnisty makaron z pieczoną cukinią, papryką, pomidorem i mozzarellą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 625, 1, 1,
  12, 42,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj cukinię, paprykę, pomidory i bazylię. Usuń nasiona papryki. Pokrój warzywa w kawałki około 2 cm, obraną cebulę w piórka.', null::text, false),
         (3::smallint, 'Mozzarellę odsącz i porwij. Warzywa wymieszaj z oliwą, oregano, solą i pieprzem. Odmierz makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 42 from przepisy p where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż warzywa luźno na blasze i piecz 25–30 minut, obracając w połowie.', null::text, false),
         (3::smallint, 'W czasie pieczenia ugotuj makaron przez czas z opakowania. Zachowaj nieco wody i odcedź. Zakończ gotowanie makaronu możliwie blisko końca pieczenia.', null::text, false),
         (4::smallint, 'Połącz gorący makaron z warzywami, płynem z blachy i mozzarellą. Dodaj bazylię. W razie potrzeby rozluźnij zachowaną wodą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z polędwiczką i pieczarkami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z polędwiczką i pieczarkami', 'Pełnoziarnisty makaron z polędwiczką wieprzową i pieczarkami w lekkim sosie jogurtowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 556, 1, 1,
  12, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Odgrzewaj łagodnie, do gorącego środka całej porcji. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Polędwiczki nie duś długo po usmażeniu, bo wyschnie. Jogurt dodaj poza ogniem; gęsty sos rozluźnij ciepłą wodą z makaronu.'
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Oczyść pieczarki i pokrój w plasterki. Obierz i posiekaj cebulę oraz czosnek.', null::text, false),
         (3::smallint, 'Mięso osusz, usuń twardą błonę, pokrój w paski około 1 cm. Umyj przybory i ręce. Odmierz makaron, jogurt i musztardę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę w garnku i ugotuj makaron przez czas wskazany na opakowaniu. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku. Przed odcedzeniem zachowaj nieco wody z gotowania. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzej połowę oleju przez 1 minutę. Smaż mięso przez 4–5 minut, obracając. Sprawdź temperaturę: co najmniej 63°C. Przełóż na czysty talerz i pozostaw na co najmniej 3 minuty.', null::text, false),
         (3::smallint, 'Dodaj pozostały olej, cebulę i pieczarki. Smaż 7–9 minut, aż woda odparuje. Dodaj czosnek i tymianek, smaż 30 sekund.', null::text, false),
         (4::smallint, 'W misce wymieszaj jogurt, musztardę i niewielką ilość ciepłej wody z makaronu.', null::text, false),
         (5::smallint, 'Do patelni dodaj makaron i mięso, podgrzej 1 minutę. Zdejmij z ognia, odczekaj około 1 minuty i dodaj sos jogurtowy. Dopraw solą i pieprzem; nie zagotowuj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z ricottą i szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z ricottą i szpinakiem', 'Szybki pełnoziarnisty makaron z kremową ricottą, szpinakiem, czosnkiem i cytryną. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 355, 1, 1,
  7, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj odrobinę wody. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i odsącz szpinak. Obierz i posiekaj czosnek. Umyj cytrynę i odmierz sok. Przygotuj ricottę oraz makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i łączenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę w garnku i ugotuj makaron przez czas wskazany na opakowaniu. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku. Przed odcedzeniem zachowaj nieco wody z gotowania. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na ostatnie minuty gotowania makaronu rozgrzej oliwę na patelni przez 1 minutę. Dodaj czosnek, smaż 20–30 sekund.', null::text, false),
         (3::smallint, 'Dodaj szpinak i smaż 1–2 minuty, tylko do zwiędnięcia. Zmniejsz ogień, dodaj ricottę, gałkę i trochę wody z makaronu.', null::text, false),
         (4::smallint, 'Dodaj makaron, wymieszaj na małym ogniu przez 1 minutę. Zdejmij z ognia, dodaj sok z cytryny, sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z tuńczykiem, cytryną i natką pietruszki
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z tuńczykiem, cytryną i natką pietruszki', 'Szybki pełnoziarnisty makaron z tuńczykiem, cytryną, czosnkiem i natką pietruszki. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 267, 1, 1,
  7, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Przy odgrzewaniu dodaj niewielką ilość wody. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Odsącz tuńczyka. Obierz i posiekaj czosnek. Umyj i posiekaj natkę. Umyj cytrynę i odmierz sok. Przygotuj makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i łączenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę w garnku i ugotuj makaron przez czas wskazany na opakowaniu. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku. Przed odcedzeniem zachowaj nieco wody z gotowania. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Gdy do końca gotowania makaronu pozostaje około 4 minut, rozgrzej oliwę na drugim palniku przez 1 minutę. Dodaj czosnek i chili; podgrzewaj 20–30 sekund.', null::text, false),
         (3::smallint, 'Dodaj tuńczyka, makaron i niewielką ilość zachowanej wody. Podgrzewaj na małym ogniu przez 1–2 minuty, delikatnie mieszając.', null::text, false),
         (4::smallint, 'Zdejmij z ognia. Dodaj sok z cytryny, natkę, sól i pieprz. Podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Makaron z wołowiną i sosem pomidorowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Makaron z wołowiną i sosem pomidorowym', 'Pełnoziarnisty makaron z mieloną wołowiną i warzywnym sosem pomidorowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['makaron']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 649, 1, 1,
  12, 37,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Sos przechowuj w lodówce do 3 dni albo zamroź. Makaron najlepiej trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz marchew, zetrzyj na tarce. Obierz i posiekaj cebulę oraz czosnek. Odmierz passatę i makaron. Przygotuj mięso.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie sosu i makaronu', 37 from przepisy p where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę przez 1 minutę, smaż cebulę i marchew 4 minuty.', null::text, false),
         (2::smallint, 'Dodaj mięso i smaż 6–7 minut, rozdzielając grudki. Dodaj czosnek i smaż 30 sekund.', null::text, false),
         (3::smallint, 'Dodaj passatę, oregano oraz bazylię suszoną. Doprowadź do wrzenia i gotuj łagodnie przez 18–20 minut, mieszając.', null::text, false),
         (4::smallint, 'W czasie gotowania sosu ugotuj makaron przez czas z opakowania na drugim palniku, następnie odcedź.', null::text, false),
         (5::smallint, 'Sprawdź sos, dopraw solą i pieprzem i podaj z makaronem.', 'wołowina jest rozdrobniona i ugotowana, sos gęsty; mięso co najmniej 71°C'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Małże w pomidorowym bulionie
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Małże w pomidorowym bulionie', 'Małże gotowane w aromatycznym bulionie pomidorowym z czosnkiem, selerem naciowym i natką. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  0, 'prywatna',
  'waga', 677, 1, 1,
  10, 22,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie najlepiej zjedz bezpośrednio po przygotowaniu.',
  false, 'Jeśli bulion za bardzo zgęstnieje, rozrzedź go gorącą wodą. Małże dodawaj dopiero do gotowej bazy, aby nie gotować ich nadmiernie.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
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
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Małże w pomidorowym bulionie');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Przygotuj surowe mięso małży bez muszli; jeśli jest mrożone, wcześniej rozmroź w lodówce i odsącz. Usuń ewentualne fragmenty muszli.', null::text, false),
         (3::smallint, 'Umyj seler naciowy i natkę. Pokrój seler cienko, natkę posiekaj. Obierz i posiekaj cebulę oraz czosnek. Odmierz pomidory i bulion, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie', 22 from przepisy p where lower(p.nazwa) = lower('Małże w pomidorowym bulionie');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę przez 1 minutę. Smaż cebulę i seler 4 minuty. Dodaj czosnek i smaż 30 sekund.', null::text, false),
         (2::smallint, 'Dodaj pomidory i bulion. Doprowadź do wrzenia przez około 3 minuty i gotuj łagodnie 5 minut.', null::text, false),
         (3::smallint, 'Dodaj mięso małży, ponownie doprowadź do łagodnego wrzenia i od tego momentu gotuj przez 4–5 minut. W razie potrzeby dogotuj przez kolejną minutę.', 'mięso jest nieprzezroczyste i jędrne, gorące w środku'::text, true),
         (4::smallint, 'Dodaj pieprz i natkę, podaj od razu z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Morszczuk w sosie pomidorowym z ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Morszczuk w sosie pomidorowym z ryżem', 'Morszczuk duszony w ziołowym sosie pomidorowym, podany z ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 557, 1, 1,
  10, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz ryż. Obierz i posiekaj cebulę oraz czosnek. Umyj i posiekaj natkę. Odmierz passatę.', null::text, false),
         (3::smallint, 'Osusz rozmrożony filet morszczuka, usuń ości i podziel na podobne kawałki grubości około 2–3 cm. Dopraw częścią soli i pieprzu. Umyj przybory po rybie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i duszenie ryby', 30 from przepisy p where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj ryż i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Rozgrzej oliwę na drugim palniku przez 1 minutę. Smaż cebulę 4 minuty. Dodaj czosnek, paprykę i oregano, smaż 30 sekund.', null::text, false),
         (3::smallint, 'Dodaj passatę, doprowadź do łagodnego wrzenia przez około 2 minuty i gotuj 10 minut.', null::text, false),
         (4::smallint, 'Włóż rybę do sosu, polej sosem i duś pod przykryciem przez 8–10 minut, bez energicznego mieszania.', 'ryba ma co najmniej 63°C, jest nieprzezroczysta i rozdziela się na płatki'::text, true),
         (5::smallint, 'Dodaj natkę, dopraw pozostałą solą i pieprzem. Podaj z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Nocna owsianka z bananem i chia
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Nocna owsianka z bananem i chia', 'Owsianka przygotowywana wieczorem. Wymaga co najmniej 6 godzin chłodzenia; praca zajmuje około 7 minut. Podany czas przygotowania obejmuje również oczekiwanie w lodówce. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 386, 1, 1,
  367, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj pod przykryciem w lodówce do 2 dni. Banana najlepiej dodaj przed jedzeniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 4 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Odmierz płatki, mleko, jogurt, chia, cynamon i masło orzechowe. Banana obierz i pokrój; przechowaj osobno w szczelnym pojemniku w lodówce do podania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Mieszanie', 2 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj płatki, mleko, jogurt, chia i cynamon. Przykryj naczynie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Chłodzenie', 360 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wstaw do lodówki na co najmniej 6 godzin. Po około 10 minutach ponownie wymieszaj, żeby rozbić skupiska chia.', 'płatki są miękkie, chia napęczniały'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Podanie', 1 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj owsiankę, dodaj przygotowanego banana i masło orzechowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z bananem i chia') and e.kolejnosc = 4;

-- -------------------------------------------------------------------------
--  Nocna owsianka z borówkami i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Nocna owsianka z borówkami i orzechami', 'Owsianka przygotowywana wieczorem. Wymaga co najmniej 6 godzin chłodzenia; praca zajmuje około 7 minut. Podany czas przygotowania obejmuje również oczekiwanie w lodówce. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 435, 1, 1,
  367, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Waga kuchenna', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj pod przykryciem w lodówce do 2 dni. Orzechy dodaj tuż przed jedzeniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 4 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Odmierz płatki, mleko, jogurt i chia. Umyj i osusz borówki; orzechy posiekaj i odłóż do podania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Mieszanie', 2 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj płatki z mlekiem, jogurtem, chia i połową borówek. Pozostałe borówki przechowaj osobno pod przykryciem w lodówce.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Chłodzenie', 360 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przykryj owsiankę i wstaw do lodówki na co najmniej 6 godzin. Po 10 minutach wymieszaj ponownie, aby chia nie zbiły się w grudki.', 'płatki miękkie, masa kremowa'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Podanie', 1 from przepisy p where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj owsiankę, dodaj pozostałe borówki oraz orzechy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Nocna owsianka z borówkami i orzechami') and e.kolejnosc = 4;

-- -------------------------------------------------------------------------
--  Omlet ze szpinakiem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Omlet ze szpinakiem i fetą', 'Delikatny omlet ze szpinakiem i fetą, podany z kromką chleba żytniego. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 241, 1, 1,
  7, 9,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj omlet w zamkniętym pojemniku w lodówce do 1 dnia. Odgrzej na patelni na małym ogniu do gorącego środka, a pieczywo przechowuj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       'kromka', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz szpinak, duże liście posiekaj. Pokrusz fetę i przygotuj pieczywo.', null::text, false),
         (3::smallint, 'Wbij jajka do miski i roztrzep widelcem z pieprzem oraz odmierzoną solą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie omletu', 9 from przepisy p where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Dodaj szpinak i smaż 1 minutę.', null::text, false),
         (2::smallint, 'Wlej jajka i rozłóż fetę. Smaż na małym ogniu pod pokrywką przez 4–5 minut.', null::text, false),
         (3::smallint, 'Gdy masa się zetnie, złóż omlet i podgrzewaj jeszcze 1 minutę. Jeśli środek nadal jest płynny, smaż pod pokrywką kolejną minutę.', 'środek ścięty, bez surowej masy jajecznej'::text, true),
         (4::smallint, 'Podaj z pieczywem w ilości z listy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Owsianka z jabłkiem, cynamonem i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Owsianka z jabłkiem, cynamonem i orzechami', 'Kremowa owsianka na mleku z jabłkiem, cynamonem i orzechami włoskimi. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 423, 1, 1,
  5, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Rondel', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Przy odgrzewaniu dodaj odrobinę mleka. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj jabłko, usuń gniazdo nasienne i pokrój w małą kostkę. Posiekaj orzechy. Odmierz mleko oraz płatki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie owsianki', 12 from przepisy p where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wsyp płatki do rondla, wlej mleko, dodaj sól. Podgrzewaj około 3 minut do łagodnego wrzenia, mieszając.', null::text, false),
         (2::smallint, 'Gotuj na małym ogniu przez 5–7 minut lub czas z opakowania płatków, często mieszając.', null::text, false),
         (3::smallint, 'Dodaj jabłko i cynamon, podgrzewaj jeszcze 1 minutę. Podaj z orzechami; jabłko pozostanie lekko chrupiące.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Owsianka z jabłkiem, cynamonem i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Papryka faszerowana soczewicą i kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Papryka faszerowana soczewicą i kaszą bulgur', 'Pieczona papryka wypełniona soczewicą, kaszą bulgur i pomidorowym farszem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 644, 1, 1,
  15, 85,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Garnek 3 l', 'Patelnia 24 cm', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w lodówce do 3 dni. Upieczoną paprykę można zamrozić. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj paprykę, przekrój wzdłuż i usuń nasiona. Obierz i posiekaj cebulę oraz czosnek. Umyj i posiekaj natkę.', null::text, false),
         (3::smallint, 'Opłucz soczewicę, odmierz bulgur i passatę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie farszu', 40 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Soczewicę ugotuj w dodatkowej wodzie przez czas z opakowania, zwykle 25–30 minut od zagotowania; odcedź.', null::text, false),
         (2::smallint, 'Równolegle ugotuj bulgur w osobnym garnku przez czas z opakowania i odcedź. Woda do gotowania jest dodatkowa.', null::text, false),
         (3::smallint, 'Po odcedzeniu bulguru odstaw go pod przykryciem. Na zwolnionym palniku na patelni rozgrzej oliwę przez 1 minutę. Smaż cebulę 4 minuty, dodaj czosnek oraz kmin i smaż 30 sekund. Wlej passatę i gotuj 3 minuty.', null::text, false),
         (4::smallint, 'Połącz sos z ugotowaną soczewicą i bulgurem. Dopraw solą i pieprzem. W ostatnich 10 minutach gotowania farszu rozgrzej piekarnik do 190°C, grzanie góra–dół.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Nadziewanie i pieczenie', 45 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Napełnij połówki papryki farszem, ułóż w naczyniu. Jeśli farszu jest więcej, rozłóż resztę między paprykami.', null::text, false),
         (2::smallint, 'Przykryj naczynie i piecz 25 minut, następnie odkryj i piecz 10–15 minut.', null::text, false),
         (3::smallint, 'Sprawdź paprykę i podaj z natką.', 'papryka daje się łatwo nakłuć, farsz gorący w środku'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Pełnoziarniste placuszki ze skyrem i owocami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pełnoziarniste placuszki ze skyrem i owocami', 'Pełnoziarniste placuszki podane ze skyrem i borówkami. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 521, 1, 1,
  10, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Widelec', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Placuszki przechowuj w lodówce do 1 dnia. Skyr i owoce trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeśli spód ciemnieje, a środek jest surowy, zmniejsz ogień i nakładaj cieńsze placuszki. Przywieranie może wynikać z uszkodzonej powierzchni patelni lub zbyt wczesnego obracania.'
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
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz borówki. Odmierz mąkę, mleko, skyr, miód, cynamon i olej.', null::text, false),
         (3::smallint, 'Roztrzep jajko z mlekiem, dodaj mąkę i cynamon. Wymieszaj na jednolite ciasto i odstaw na 5 minut.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej patelnię nieprzywierającą przez 1 minutę na średnim ogniu. Rozdziel odmierzony olej między partie.', null::text, false),
         (2::smallint, 'Nakładaj małe porcje ciasta i smaż 2–3 minuty, aż brzegi się zetną i spód zrumieni. Odwróć i smaż jeszcze 1–2 minuty. Powtarzaj z resztą ciasta; etap obejmuje około 3 partie dla bazy.', 'placuszki mają rumiane strony i nie mają surowego ciasta w środku'::text, true),
         (3::smallint, 'Podaj ze skyrem, borówkami i miodem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczona makrela z burakami i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczona makrela z burakami i ziemniakami', 'Pieczona makrela z burakami, ziemniakami, czerwoną cebulą i koperkiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 717, 1, 1,
  15, 58,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Ze względu na intensywny aromat użyj szczelnego pojemnika. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz buraki oraz ziemniaki. Buraki pokrój w kostkę około 1 cm, ziemniaki około 2 cm. Obierz cebulę, pokrój w piórka.', null::text, false),
         (3::smallint, 'Umyj cytrynę i koperek. Przygotuj sok z odmierzonej części cytryny, posiekaj koperek.', null::text, false),
         (4::smallint, 'Przygotuj filety makreli bez ości, osusz. Podana masa dotyczy jadalnej części ryby. Warzywa wymieszaj z oliwą i częścią soli oraz pieprzu, rybę dopraw resztą. Umyj przybory po rybie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 58 from przepisy p where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 200°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Piecz warzywa przez 30 minut, mieszając po 15 minutach. Sprawdź buraki; jeśli są nadal twarde, dopiekaj same warzywa przez 5–10 minut przed dodaniem ryby.', null::text, false),
         (3::smallint, 'Do prawie miękkich warzyw dodaj filety makreli i piecz przez 12–15 minut, zależnie od grubości.', 'ryba ma co najmniej 63°C, warzywa miękkie'::text, true),
         (4::smallint, 'Po wyjęciu skrop rybę przygotowanym sokiem z cytryny i posyp koperkiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczone warzywa korzeniowe z tymiankiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczone warzywa korzeniowe z tymiankiem', 'Mieszanka pieczonych ziemniaków, buraków, marchewki, pasternaku i selera z tymiankiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['dodatek']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 343, 1, 1,
  15, 50,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Odgrzewaj w piekarniku lub na patelni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz ziemniaki, buraki, marchew, pasternak oraz seler. Buraki pokrój w kostkę około 1 cm, pozostałe korzenie około 2 cm. Obierz cebulę i pokrój w ósemki.', null::text, false),
         (3::smallint, 'Wymieszaj warzywa z odmierzoną oliwą, tymiankiem, rozmarynem, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 50 from przepisy p where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż warzywa luźno na blasze i piecz 35–40 minut. Przemieszaj po 20 minutach. Jeśli najtwardsze kawałki nie są miękkie, dopiekaj po 5 minut, zdejmując wcześniej gotowe.', 'warzywa są miękkie w środku i zarumienione na brzegach'::text, true),
         (3::smallint, 'Podaj jako dodatek.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony bakłażan z ciecierzycą i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony bakłażan z ciecierzycą i fetą', 'Pieczony bakłażan z ciecierzycą, pomidorami, fetą i kaszą bulgur. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 728, 1, 1,
  12, 48,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Danie przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj bakłażana i pomidora. Pokrój bakłażana w kostkę około 2 cm, pomidora na kawałki. Obierz cebulę i czosnek, pokrój cebulę w piórka, czosnek posiekaj.', null::text, false),
         (3::smallint, 'Opłucz i odsącz ciecierzycę. Pokrusz fetę i odmierz kaszę. Wymieszaj bakłażana, cebulę oraz ciecierzycę z oliwą, czosnkiem, oregano i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie kaszy', 48 from przepisy p where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż przygotowaną mieszankę w szerokim naczyniu i piecz 25 minut, mieszając w połowie.', null::text, false),
         (3::smallint, 'Podczas pieczenia ugotuj bulgur w dodatkowej wodzie przez czas z opakowania i odcedź.', null::text, false),
         (4::smallint, 'Do naczynia dodaj pomidora oraz fetę. Piecz 8–10 minut; bakłażan powinien być zupełnie miękki. Jeśli nadal jest twardy, dopiekaj pod przykryciem po 5 minut.', null::text, false),
         (5::smallint, 'Spróbuj, dopraw odmierzoną solą i podaj z kaszą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony kalafior z ziołowym sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony kalafior z ziołowym sosem jogurtowym', 'Rumiany pieczony kalafior podany z lekkim sosem jogurtowym, cytryną i natką pietruszki. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['dodatek']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 372, 1, 1,
  10, 42,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Kalafior i sos przechowuj osobno w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj kalafior, podziel na podobne różyczki około 3 cm. Obierz i posiekaj czosnek. Umyj natkę i cytrynę, posiekaj natkę i odmierz sok.', null::text, false),
         (3::smallint, 'Wymieszaj kalafior z oliwą, kminem, papryką i częścią soli oraz pieprzu.', null::text, false),
         (4::smallint, 'Wymieszaj jogurt z czosnkiem, natką, sokiem z cytryny i resztą przypraw; przykryj i odstaw do lodówki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i podanie', 42 from przepisy p where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 220°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż kalafior w jednej warstwie i piecz 25–30 minut, obracając w połowie.', 'różyczki miękkie w środku i rumiane na brzegach'::text, true),
         (3::smallint, 'Podaj jako dodatek, z sosem jogurtowym obok.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony łosoś z brokułem i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony łosoś z brokułem i ziemniakami', 'Łosoś pieczony na jednej blasze z brokułem i ziemniakami, doprawiony cytryną oraz czosnkiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 668, 1, 1,
  12, 49,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Po ostudzeniu przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz ziemniaki, pokrój w kawałki około 1,5–2 cm. Umyj brokuł i podziel na małe różyczki. Obierz i posiekaj czosnek. Umyj cytrynę, przygotuj sok i cząstki z odmierzonej części.', null::text, false),
         (3::smallint, 'Podziel oliwę między ziemniaki, brokuł i rybę. Wymieszaj ziemniaki z oliwą, tymiankiem i częścią soli. Brokuł skrop oliwą.', null::text, false),
         (4::smallint, 'Łososia osusz i usuń ości. Natrzyj pozostałą oliwą, czosnkiem, solą oraz pieprzem. Umyj przybory i ręce po rybie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 49 from przepisy p where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 210°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Piecz ziemniaki 20 minut. Dodaj brokuł i piecz 5 minut.', null::text, false),
         (3::smallint, 'Dodaj łososia grubości około 2–3 cm i piecz jeszcze 10–12 minut. Grubszy kawałek może wymagać dłużej; gotowe warzywa zdejmij wcześniej.', 'ryba ma co najmniej 63°C, ziemniaki miękkie'::text, true),
         (4::smallint, 'Skrop rybę przygotowanym sokiem z cytryny i podaj z warzywami oraz cząstkami cytryny.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pierś z kaczki z pomarańczą i czerwoną kapustą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Pierś z kaczki z duszoną czerwoną kapustą, jabłkiem, pomarańczą i ziemniakami. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  2, 'prywatna',
  'waga', 778, 1, 1,
  15, 45,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa', 'Durszlak']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Kaczkę odgrzewaj łagodnie do gorącego środka, najlepiej z sosem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeśli mięso jest przesmażone, pokrój je cienko i podaj z większą ilością sosu. Za kwaśną kapustę złagodź jabłkiem.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'ml'::jednostka_miary, 50,
       'do duszenia kapusty', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj kapustę, usuń twardy głąb i cienko poszatkuj. Umyj jabłko, usuń gniazdo nasienne i pokrój w kostkę. Obierz i posiekaj cebulę.', null::text, false),
         (3::smallint, 'Umyj i obierz ziemniaki, pokrój w kawałki około 3 cm. Umyj pomarańczę; część przygotuj w cząstkach bez błon, z pozostałej wyciśnij sok.', null::text, false),
         (4::smallint, 'Osusz pierś bez skóry i dopraw częścią soli i pieprzu. Przygotuj cynamon, goździki oraz ocet. Podziel olej między kapustę i smażenie kaczki. Umyj przybory po mięsie.', null::text, false),
         (5::smallint, 'Odmierz wodę do duszenia kapusty zgodnie z listą składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie dodatków i smażenie kaczki', 45 from przepisy p where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'W garnku rozgrzej połowę oleju przez 1 minutę. Smaż cebulę 4 minuty. Dodaj kapustę, jabłko, połowę soku pomarańczowego, cynamon i goździki. Dodaj odmierzoną wodę do duszenia, i duś pod przykryciem 25–30 minut. Ocet dodaj pod koniec, gdy kapusta jest miękka.', null::text, false),
         (2::smallint, 'Równolegle na drugim palniku zagotuj ziemniaki w wodzie, zwykle około 5 minut, a następnie gotuj 15–20 minut do miękkości. Odcedź i trzymaj pod przykryciem.', null::text, false),
         (3::smallint, 'Na palniku zwolnionym przez ziemniaki rozgrzej pozostały olej na patelni przez 1 minutę. Smaż pierś przez 3–4 minuty z każdej strony.', null::text, false),
         (4::smallint, 'Sprawdź najgrubsze miejsce termometrem. W razie potrzeby zmniejsz ogień i dosmażaj pod przykryciem po 1–2 minuty. Gotową pierś odstaw na 5 minut.', 'kaczka ma co najmniej 74°C w środku'::text, true),
         (5::smallint, 'W tym czasie wlej pozostały sok pomarańczowy na patelnię, dodaj cząstki pomarańczy i gotuj 1–2 minuty, zbierając smaki z dna.', null::text, false),
         (6::smallint, 'Usuń goździki z kapusty, dopraw resztą soli i pieprzu. Pokrój kaczkę, podaj z sosem, kapustą i ziemniakami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Placuszki bananowo-owsiane
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Placuszki bananowo-owsiane', 'Miękkie placuszki z banana, jajka i mąki owsianej, podane z jogurtem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 381, 1, 1,
  10, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Widelec', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Placuszki przechowuj w lodówce do 1 dnia. Jogurt trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Placuszki bananowo-owsiane');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Obierz banana i rozgnieć widelcem. Odmierz mleko, mąkę, jogurt, cynamon i olej.', null::text, false),
         (3::smallint, 'Połącz banana z jajkiem, mlekiem, mąką i cynamonem. Wymieszaj i odstaw na 5 minut, aby mąka wchłonęła płyn.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Placuszki bananowo-owsiane');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej patelnię nieprzywierającą przez 1 minutę na średnim ogniu. Podziel olej między partie.', null::text, false),
         (2::smallint, 'Nakładaj małe porcje ciasta i smaż około 2–3 minut z pierwszej strony oraz 1–2 minuty z drugiej. Etap obejmuje około 3 partie dla bazy; przy większej ilości dolicz kolejne partie.', 'spód rumiany, brzegi ścięte, środek bez surowego ciasta'::text, true),
         (3::smallint, 'Podaj z odmierzoną ilością jogurtu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Polędwiczka w sosie musztardowym z kaszą bulgur
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa w lekkim sosie musztardowo-jogurtowym z pieczarkami i kaszą bulgur. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 656, 1, 1,
  12, 28,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Oczyść i pokrój pieczarki, obierz i posiekaj cebulę. Odmierz bulion oraz kaszę.', null::text, false),
         (3::smallint, 'Usuń błonę z polędwiczki i pokrój na medaliony grubości około 1,5 cm. Dopraw częścią soli i pieprzu; umyj przybory po mięsie.', null::text, false),
         (4::smallint, 'Wymieszaj jogurt z musztardą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy i smażenie', 28 from przepisy p where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj kaszę bulgur i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzej połowę oleju przez 1 minutę. Smaż medaliony po 2–3 minuty z każdej strony. Sprawdź temperaturę co najmniej 63°C i w razie potrzeby dosmaż po 1 minucie. Odstaw na czysty talerz na co najmniej 3 minuty.', null::text, false),
         (3::smallint, 'Dodaj pozostały olej, cebulę i pieczarki. Smaż 7–9 minut, aby odparować wodę.', null::text, false),
         (4::smallint, 'Dodaj bulion oraz tymianek, gotuj 3–4 minuty, aby sos nieco zgęstniał. Dodaj mięso, podgrzej 1 minutę i zdejmij z ognia.', null::text, false),
         (5::smallint, 'Jogurt zahartuj niewielką ilością ciepłego sosu, następnie wmieszaj do patelni. Nie zagotowuj. Dopraw pozostałą solą i pieprzem, podaj z kaszą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Potrawka z kurczaka, kaszy jęczmiennej i warzyw
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Jednogarnkowa potrawka z kurczaka, kaszy jęczmiennej, marchewki, pora i groszku. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 738, 1, 2,
  12, 50,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Potrawkę można zamrozić. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
       'opłukana', null, sk.rola, sk.mozna_dzielic, 2
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
select p.id, sk.id, 600, 'g'::jednostka_miary, 600,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Domowy bulion warzywny';
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

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz kaszę. Umyj i obierz marchew, pokrój w kostkę około 1 cm. Dokładnie wypłucz por między warstwami i pokrój. Umyj seler naciowy, pokrój cienko.', null::text, false),
         (3::smallint, 'Udo bez skóry i kości pokrój w kostkę około 2 cm; podana masa dotyczy mięsa bez kości. Umyj ręce i przybory. Odmierz bulion i groszek.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie potrawki', 50 from przepisy p where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę, smaż kurczaka 5 minut, obracając. Dodaj por, marchew i seler; smaż 3 minuty.', null::text, false),
         (2::smallint, 'Dodaj kaszę, bulion i tymianek. Doprowadź do wrzenia przez około 4 minuty. Gotuj pod uchyloną pokrywką przez czas wskazany na opakowaniu kaszy, orientacyjnie 20–30 minut, mieszając. Kolejny krok wykonaj na ostatnie 5 minut tego czasu. Ubytki płynu uzupełniaj gorącą wodą.', null::text, false),
         (3::smallint, 'Gdy kasza jest prawie miękka, dodaj groszek i gotuj 5 minut.', 'kasza miękka, kurczak co najmniej 74°C, potrawka wilgotna'::text, true),
         (4::smallint, 'Dopraw solą i pieprzem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pstrąg pieczony z warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pstrąg pieczony z warzywami korzeniowymi', 'Pstrąg pieczony z ziemniakami, marchewką, pasternakiem i selerem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 673, 1, 1,
  15, 55,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Gotowe danie przechowuj w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz ziemniaki, marchew, pasternak i seler. Pokrój w kawałki około 1,5–2 cm, wymieszaj z większością oliwy, rozmarynem i częścią przypraw.', null::text, false),
         (3::smallint, 'Przygotuj filety pstrąga, usuń ości, osusz; podana masa dotyczy części jadalnej bez ości. Natrzyj pozostałą oliwą i przyprawami. Umyj cytrynę i przygotuj sok z odmierzonej części. Umyj przybory po rybie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 55 from przepisy p where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 200°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż warzywa na blasze, piecz 25–30 minut i przemieszaj w połowie. Powinny być prawie miękkie przed dodaniem ryby.', null::text, false),
         (3::smallint, 'Dodaj filety i piecz 12–15 minut, zależnie od ich grubości. Gotową rybę zdejmij; twarde warzywa dopiecz osobno.', 'ryba ma co najmniej 63°C, mięso rozdziela się widelcem'::text, true),
         (4::smallint, 'Skrop przygotowanym sokiem z cytryny i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pudding chia z mango i mlekiem kokosowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pudding chia z mango i mlekiem kokosowym', 'Pudding kokosowy z mango, daktylami i migdałami. Wymaga co najmniej 4 godzin chłodzenia; czas przygotowania obejmuje oczekiwanie, sama praca zajmuje około 10 minut. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 435, 1, 1,
  250, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj pod przykryciem w lodówce do 2 dni. Migdały dodaj przed jedzeniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj mango, usuń skórkę i pestkę, pokrój miąższ; przechowaj pod przykryciem w lodówce. Posiekaj migdały.', null::text, false),
         (3::smallint, 'Usuń pestki daktyli, jeśli są, i drobno je posiekaj. Odmierz chia i mleko kokosowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Mieszanie', 2 from przepisy p where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Dokładnie wymieszaj chia z mlekiem kokosowym i daktylami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Chłodzenie', 240 from przepisy p where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przykryj i wstaw do lodówki na co najmniej 4 godziny. Po pierwszych 10 minutach wymieszaj ponownie, aby rozbić grudki.', 'nasiona napęczniały, masa jest gęsta i jednolita'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj pudding, dodaj przygotowane mango i migdały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pudding chia z mango i mlekiem kokosowym') and e.kolejnosc = 4;

-- -------------------------------------------------------------------------
--  Ryż z pieczarkami, szpinakiem i parmezanem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Ryż z pieczarkami, szpinakiem i parmezanem', 'Ryż parboiled z pieczarkami, szpinakiem i parmezanem przygotowany w jednym garnku. Ziarna pozostają wyraźnie oddzielne; ser nadaje sosowi kremowość. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 739, 1, 1,
  10, 38,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Oczyść pieczarki i pokrój w plastry. Obierz i posiekaj cebulę oraz czosnek. Umyj i osusz szpinak.', null::text, false),
         (3::smallint, 'Zetrzyj parmezan, odmierz ryż oraz bulion.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu z warzywami', 38 from przepisy p where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę przez 1 minutę. Smaż cebulę i pieczarki 7–9 minut, aż płyn odparuje.', null::text, false),
         (2::smallint, 'Dodaj czosnek i smaż 30 sekund. Dodaj ryż, wymieszaj przez 1 minutę. Wlej bulion i doprowadź do wrzenia przez około 3 minuty.', null::text, false),
         (3::smallint, 'Gotuj na małym ogniu pod uchyloną pokrywką przez czas z opakowania ryżu, orientacyjnie 15–20 minut, mieszając co kilka minut. Jeśli ryż jeszcze twardy, uzupełniaj odparowany płyn gorącą wodą.', null::text, false),
         (4::smallint, 'Na ostatnie 1–2 minuty dodaj szpinak. Gdy zwiędnie, zdejmij z ognia i wmieszaj parmezan. Dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka brokułowa z jajkiem i sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka brokułowa z jajkiem i sosem jogurtowym', 'Sałatka z brokułem, jajkami na twardo, kukurydzą i szczypiorkiem w sosie jogurtowo-musztardowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 586, 1, 1,
  10, 23,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Garnek 2 l', 'Durszlak', 'Łyżka cedzakowa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj brokuł i podziel na małe różyczki. Obierz i posiekaj cebulę. Umyj i posiekaj szczypiorek. Odsącz kukurydzę.', null::text, false),
         (3::smallint, 'Wymieszaj jogurt z musztardą, solą i pieprzem; odstaw do lodówki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i studzenie', 20 from przepisy p where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj w garnku wodę przykrywającą jajka. Włóż je ostrożnie i gotuj przez 9–10 minut przy łagodnym wrzeniu, licząc od włożenia. Schłodź zimną wodą i obierz.', null::text, false),
         (2::smallint, 'Równolegle w drugim garnku zagotuj wodę. Gotuj brokuł 4–5 minut, odcedź, krótko schłodź zimną wodą i dokładnie odsącz.', null::text, false),
         (3::smallint, 'Pokrój schłodzone jajka.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj brokuł, jajka, kukurydzę, cebulę oraz sos. Posyp szczypiorkiem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka brokułowa z jajkiem i sosem jogurtowym') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka makaronowa z mozzarellą i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka makaronowa z mozzarellą i warzywami', 'Sałatka z pełnoziarnistym makaronem, mozzarellą, pomidorem, ogórkiem, papryką i bazylią. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 559, 1, 1,
  12, 23,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Sitko', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Oliwę najlepiej dodaj przed jedzeniem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora, ogórek, paprykę i bazylię; osusz. Usuń nasiona papryki i pokrój warzywa w kostkę.', null::text, false),
         (3::smallint, 'Odsącz mozzarellę i oliwki, pokrój ser. Umyj cytrynę, odmierz sok. Przygotuj makaron i oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i chłodzenie makaronu', 20 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę i ugotuj makaron przez czas podany na opakowaniu. Odcedź na sitku, krótko przelej zimną wodą i dokładnie odsącz.', null::text, false),
         (2::smallint, 'Przed dodaniem sera i surowych warzyw upewnij się, że makaron jest chłodny.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Połącz makaron, mozzarellę, pokrojone warzywa, oliwki i bazylię. Skrop oliwą oraz przygotowanym sokiem z cytryny, dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka makaronowa z tuńczykiem i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka makaronowa z tuńczykiem i warzywami', 'Sałatka z pełnoziarnistym makaronem, tuńczykiem, pomidorem, ogórkiem i kukurydzą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 576, 1, 1,
  12, 23,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Sitko', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i pokrój pomidora i ogórek. Umyj i posiekaj szczypiorek. Odsącz tuńczyka oraz kukurydzę.', null::text, false),
         (3::smallint, 'Wymieszaj jogurt z musztardą, solą i pieprzem. Odmierz makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i chłodzenie makaronu', 20 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę i ugotuj makaron przez czas z opakowania. Odcedź, krótko przelej zimną wodą i dokładnie odsącz.', null::text, false),
         (2::smallint, 'Sprawdź, czy makaron jest chłodny przed połączeniem z sosem jogurtowym.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj makaron z tuńczykiem, warzywami, kukurydzą i sosem. Posyp szczypiorkiem i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z tuńczykiem i warzywami') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka z czarnej fasoli, kukurydzy i pomidora
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kolorowa sałatka z czarnej fasoli, kukurydzy, pomidora, papryki i awokado. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 632, 1, 1,
  15, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Awokado najlepiej dodaj przed jedzeniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz i odsącz fasolę, odsącz kukurydzę. Umyj pomidora, paprykę, awokado, limonkę oraz kolendrę.', null::text, false),
         (3::smallint, 'Usuń nasiona papryki, pokrój paprykę i pomidora. Obierz i posiekaj cebulę, posiekaj kolendrę.', null::text, false),
         (4::smallint, 'Obierz awokado, usuń pestkę i pokrój miąższ. Wyciśnij i odmierz sok z limonki, skrop nim awokado.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj fasolę, kukurydzę, paprykę, pomidora oraz cebulę.', null::text, false),
         (2::smallint, 'Dodaj oliwę, kmin, sól i awokado wraz z sokiem z limonki. Delikatnie wymieszaj i posyp kolendrą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka z jajkiem, fetą i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z jajkiem, fetą i warzywami', 'Sałatka z jajkami na twardo, fetą, pomidorem, ogórkiem i sałatą, skropiona oliwą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 386, 1, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Łyżka cedzakowa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Oliwę i przyprawy najlepiej dodaj przed jedzeniem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora, ogórek i sałatę. Osusz sałatę i porwij. Pokrój pomidora w cząstki, ogórek w półplasterki.', null::text, false),
         (3::smallint, 'Pokrusz fetę i odmierz oliwę, sól oraz pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie jajek', 18 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj w garnku wodę przykrywającą jajka. Włóż je ostrożnie i gotuj przez 9–10 minut przy łagodnym wrzeniu, licząc od włożenia. Schłodź zimną wodą i obierz.', null::text, false),
         (2::smallint, 'Pokrój jajka w ćwiartki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 2 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Połącz warzywa, jajka i fetę. Skrop oliwą, spróbuj i dopraw odmierzoną solą oraz pieprzem; feta jest słona. Delikatnie wymieszaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka z jarmużu, jabłka i orzechów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z jarmużu, jabłka i orzechów', 'Chrupiąca sałatka z jarmużu, jabłka, pomarańczy i orzechów w cytrynowo-musztardowym dressingu. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 406, 1, 1,
  15, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Orzechy dodaj przed podaniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj jarmuż, jabłko, pomarańczę i cytrynę. Usuń łodygi jarmużu i porwij liście; usuń gniazdo nasienne jabłka i pokrój miąższ.', null::text, false),
         (3::smallint, 'Obierz pomarańczę i podziel na cząstki, zachowaj wypływający sok. Wyciśnij i odmierz sok z cytryny. Posiekaj orzechy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie sałatki', 5 from przepisy p where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Wymieszaj oliwę z sokiem z cytryny, zachowanym sokiem pomarańczowym, musztardą, solą i pieprzem.', null::text, false),
         (2::smallint, 'Masuj liście jarmużu z dressingiem przez 2–3 minuty.', 'liście ciemnieją i stają się delikatniejsze'::text, true),
         (3::smallint, 'Dodaj jabłko, cząstki pomarańczy i orzechy. Wymieszaj i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Sałatka z komosy, buraka i koziego sera
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z komosy, buraka i koziego sera', 'Sałatka z komosy ryżowej, pieczonego buraka, koziego sera, rukoli i orzechów. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 502, 1, 1,
  12, 63,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Widelec']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Rukolę i dressing najlepiej trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz buraki, pokrój w kostkę około 1 cm, wymieszaj z połową oliwy oraz tymiankiem. Opłucz komosę na sitku.', null::text, false),
         (3::smallint, 'Umyj i osusz rukolę. Umyj jabłko, usuń gniazdo nasienne i pokrój. Posiekaj orzechy, podziel kozi ser. Odmierz ocet oraz pozostałą oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 50 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 200°C, grzanie góra–dół, zwykle około 10 minut. Rozłóż buraki na blasze i piecz 30–40 minut, mieszając w połowie.', null::text, false),
         (2::smallint, 'Równolegle ugotuj komosę przez czas z opakowania, w dodatkowej wodzie. Odcedź, rozsyp cienko na talerzu do przestudzenia.', null::text, false),
         (3::smallint, 'Sprawdź buraki widelcem; muszą być miękkie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Studzenie i łączenie', 13 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przestudź buraki rozłożone na talerzu przez około 10 minut, aby nie zwiędła rukola.', null::text, false),
         (2::smallint, 'Połącz letnią lub chłodną komosę i buraki z rukolą, jabłkiem, orzechami oraz kozim serem. Dodaj pozostałą oliwę, ocet, sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka z pieczonym burakiem i fetą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z pieczonym burakiem i fetą', 'Sałatka z pieczonym burakiem, fetą, rukolą, orzechami i czerwoną cebulą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 432, 1, 1,
  10, 63,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Blacha do pieczenia', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Pieczone buraki przechowuj w lodówce do 2 dni. Rukolę i dressing dodaj przed jedzeniem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz buraki, pokrój w kostkę około 1 cm. Wymieszaj z połową oliwy i tymiankiem.', null::text, false),
         (3::smallint, 'Umyj i osusz rukolę. Obierz i cienko pokrój cebulę. Pokrusz fetę i posiekaj orzechy. Odmierz ocet i pozostałą oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 50 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej piekarnik do 200°C, grzanie góra–dół, zwykle około 10 minut.', null::text, false),
         (2::smallint, 'Rozłóż buraki na blasze, piecz 30–40 minut, obracając w połowie.', 'buraki łatwo dają się nakłuć widelcem'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Studzenie i łączenie', 13 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przestudź buraki przez około 10 minut na talerzu; nie dodawaj gorących do rukoli.', null::text, false),
         (2::smallint, 'Połącz rukolę, buraki, cebulę, orzechy i fetę. Skrop pozostałą oliwą i octem, dopraw pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Serek wiejski z owocami i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Serek wiejski z owocami i orzechami', 'Serek wiejski z bananem, borówkami, orzechami i cynamonem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 361, 1, 1,
  5, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 1 dnia. Orzechy dodaj tuż przed jedzeniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 3 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz borówki. Obierz i pokrój banana. Posiekaj orzechy. Odmierz serek oraz cynamon.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przełóż serek do miski, dodaj owoce. Posyp orzechami i cynamonem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z owocami i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Serek wiejski z pomidorem, ogórkiem i pestkami dyni
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 'Serek wiejski ze świeżym pomidorem, ogórkiem i pestkami dyni, podany z dwiema kromkami chleba żytniego. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 516, 1, 1,
  7, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Serek z warzywami przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Pestki dyni i pieczywo dodaj dopiero przed jedzeniem. Lodówka: do 4°C.',
  false, 'Jeśli całość puściła dużo wody, odlej nadmiar płynu. Jeśli smak jest zbyt łagodny, dodaj odrobinę soli i pieprzu.'
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
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i ogórek, pokrój w kostkę. Przygotuj pieczywo, serek i pestki dyni.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie i podanie', 2 from przepisy p where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przełóż serek do miski, dodaj warzywa i delikatnie wymieszaj. Dopraw odmierzoną solą i pieprzem.', null::text, false),
         (2::smallint, 'Posyp pestkami dyni i podaj z pieczywem w ilości wskazanej na liście.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Skyr kakaowy z bananem i masłem orzechowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Skyr kakaowy z bananem i masłem orzechowym', 'Kakaowy skyr z bananem i masłem orzechowym, przygotowany bez gotowania. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'dodatek']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 380, 1, 1,
  5, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 3 from przepisy p where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Obierz przygotowanego banana. Połowę odmierzonego miąższu rozgnieć, pozostałą część pokrój w plasterki. Odmierz skyr, kakao, mleko i masło orzechowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie i podanie', 2 from przepisy p where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozprowadź kakao w mleku, dodaj skyr i rozgniecionego banana, wymieszaj.', null::text, false),
         (2::smallint, 'Dodaj masło orzechowe oraz plasterki banana.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Skyr kakaowy z bananem i masłem orzechowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Skyr z owocami, płatkami owsianymi i orzechami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Skyr z owocami, płatkami owsianymi i orzechami', 'Skyr z bananem, borówkami, płatkami owsianymi i orzechami włoskimi. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['na_slodko']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 385, 1, 1,
  5, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Orzechy i płatki dodaj przed jedzeniem, aby pozostały chrupiące. Lodówka: do 4°C.',
  false, 'Jeśli skyr jest zbyt gęsty, dodaj łyżeczkę wody. Jeśli owoce są kwaśne, rozgnieć część banana i wymieszaj ze skyrem.'
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
select p.id, 1, 'Przygotowanie składników', 3 from przepisy p where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz borówki. Obierz i pokrój banana. Posiekaj orzechy. Odmierz skyr i płatki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przełóż skyr do miski, dodaj owoce. Posyp płatkami i orzechami bezpośrednio przed jedzeniem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Skyr z owocami, płatkami owsianymi i orzechami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Stek z tuńczyka z fasolką szparagową i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Krótko smażony stek z tuńczyka z fasolką szparagową i gotowanymi ziemniakami. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 642, 1, 1,
  10, 38,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Durszlak', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej zjedz od razu. Ewentualną pozostałość przechowuj w lodówce do 1 dnia. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeśli tuńczyk jest przesmażony, pokrój go cienko i skrop oliwą z cytryną. Twardą fasolkę gotuj dłużej.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz ziemniaki, pokrój na kawałki około 2 cm. Umyj fasolkę, odetnij końcówki. Obierz i drobno posiekaj czosnek.', null::text, false),
         (3::smallint, 'Umyj cytrynę, przygotuj sok z odmierzonej części. Wymieszaj sok z połową oliwy oraz czosnkiem.', null::text, false),
         (4::smallint, 'Osusz stek z tuńczyka grubości około 2 cm, posmaruj pozostałą oliwą, dopraw solą i pieprzem. Umyj przybory po rybie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie dodatków i smażenie', 38 from przepisy p where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zalej ziemniaki wodą, zagotuj przez około 5 minut i gotuj 15–20 minut do miękkości. Odcedź i przykryj.', null::text, false),
         (2::smallint, 'Równolegle zagotuj wodę w drugim garnku. Dodaj fasolkę, gotuj 8–12 minut do miękkości, zachowując lekki opór przy gryzieniu; odcedź.', null::text, false),
         (3::smallint, 'Gdy zwolni się palnik, rozgrzej patelnię przez 1–2 minuty. Smaż tuńczyka około 3 minuty z każdej strony.', null::text, false),
         (4::smallint, 'Sprawdź temperaturę najgrubszego miejsca; w razie potrzeby dosmaż po 1 minucie na mniejszym ogniu.', 'ryba ma co najmniej 63°C, bez surowego środka'::text, true),
         (5::smallint, 'Polej ziemniaki oraz fasolkę przygotowaną oliwą z cytryną i czosnkiem, podaj z tuńczykiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tabbouleh z kaszy bulgur i ciecierzycy
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tabbouleh z kaszy bulgur i ciecierzycy', 'Świeża sałatka z kaszy bulgur, ciecierzycy, pomidora, ogórka, natki i mięty. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 546, 1, 1,
  15, 23,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Sitko', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 2 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz i odsącz ciecierzycę. Umyj pomidora, ogórek, natkę, miętę i cytrynę.', null::text, false),
         (3::smallint, 'Pokrój pomidora i ogórek w drobną kostkę. Obierz i posiekaj cebulę. Posiekaj osuszone zioła. Wyciśnij i odmierz sok z cytryny, odmierz kaszę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i chłodzenie kaszy', 20 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Zagotuj wodę i gotuj bulgur przez czas z opakowania. Odcedź, krótko przepłucz chłodną wodą i dokładnie odsącz. Upewnij się, że kasza nie jest gorąca.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Połącz kaszę, ciecierzycę, warzywa i zioła. Dodaj sok z cytryny, oliwę, sól i pieprz. Wymieszaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Tofu z brokułem i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tofu z brokułem i ryżem', 'Smażone tofu z brokułem, imbirem, czosnkiem i sezamem, podane z ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 548, 1, 1,
  12, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'ml'::jednostka_miary, 30,
       'do krótkiego duszenia brokułu', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Tofu z brokułem i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz ryż. Odsącz i osusz tofu, pokrój w kostkę około 2 cm.', null::text, false),
         (3::smallint, 'Umyj brokuł, podziel na małe różyczki około 2 cm. Obierz czosnek i imbir, posiekaj czosnek, zetrzyj imbir. Umyj i pokrój dymkę. Odmierz sos sojowy oraz sezam.', null::text, false),
         (4::smallint, 'Odmierz wodę do brokułu z listy składników; woda do gotowania ryżu jest dodatkowa i zostanie odlana.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Tofu z brokułem i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj ryż i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Na drugim palniku rozgrzej połowę oleju przez 1 minutę. Smaż tofu przez 6–8 minut, obracając; przełóż na talerz.', null::text, false),
         (3::smallint, 'Dodaj pozostały olej i brokuł, smaż 2 minuty. Dolej odmierzoną wodę do brokułu i przykryj; duś 3–4 minuty. Odkryj i odparuj resztę płynu.', null::text, false),
         (4::smallint, 'Dodaj czosnek oraz imbir, smaż 30 sekund. Włóż tofu, dodaj sos sojowy i podgrzewaj 1 minutę.', null::text, false),
         (5::smallint, 'Podaj z ryżem, sezamem i dymką.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tofucznica ze szpinakiem i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tofucznica ze szpinakiem i pomidorem', 'Szybka tofucznica ze szpinakiem, pomidorem, cebulą i kurkumą, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  1, 'prywatna',
  'waga', 488, 1, 1,
  7, 11,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej zjedz od razu. Pozostałość można przechować w lodówce do 1 dnia. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  false, 'Jeśli tofucznica jest sucha, dodaj łyżkę wody. Jeżeli pomidor puścił dużo soku, smaż chwilę bez przykrycia.'
on conflict (lower(nazwa)) do update set
  opis                   = excluded.opis,
  pory                   = excluded.pory,
  kuchnie                = excluded.kuchnie,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Odsącz tofu i rozgnieć widelcem w misce. Umyj szpinak i pomidora; osusz szpinak, pokrój pomidora w kostkę.', null::text, false),
         (3::smallint, 'Obierz i posiekaj cebulę. Przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 11 from przepisy p where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Smaż cebulę 3 minuty.', null::text, false),
         (2::smallint, 'Dodaj pomidora i smaż 2–3 minuty, odparowując nadmiar płynu. Dodaj tofu i kurkumę, podgrzewaj 2 minuty.', null::text, false),
         (3::smallint, 'Dodaj szpinak i smaż 1–2 minuty, tylko do zwiędnięcia.', 'tofu jest gorące, szpinak zwiędł, bez kałuży płynu'::text, true),
         (4::smallint, 'Dopraw solą i pieprzem, podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z Goudą, szpinakiem i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z Goudą, szpinakiem i pomidorem', 'Ciepła pełnoziarnista tortilla z roztopioną Goudą, szpinakiem i pomidorem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 336, 1, 1,
  7, 16,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz szpinak, umyj pomidora i pokrój w drobną kostkę. Obierz i posiekaj cebulę. Drobno pokrój Goudę. Przygotuj tortille.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie farszu i opiekanie', 16 from przepisy p where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Smaż cebulę 3 minuty, dodaj pomidora i smaż 3–4 minuty, odparowując płyn.', null::text, false),
         (2::smallint, 'Dodaj szpinak i smaż 1 minutę do zwiędnięcia. Dopraw oregano i pieprzem. Przełóż farsz na talerz i wytrzyj patelnię.', null::text, false),
         (3::smallint, 'Ogrzej tortillę na suchej patelni po 15–20 sekund z każdej strony. Rozłóż farsz i ser, zostawiając brzegi wolne. Jeśli farszu jest za dużo do zawinięcia, podaj nadmiar obok.', null::text, false),
         (4::smallint, 'Złóż boki i zwiń. Opiekaj na średnio małym ogniu po 2–3 minuty z każdej strony, aż ser się rozpuści.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z hummusem i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z hummusem i warzywami', 'Pełnoziarnista tortilla z domowym hummusem, pomidorem, ogórkiem i sałatą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 505, 1, 1,
  17, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Blender ręczny', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Złożoną tortillę przechowuj w lodówce do 1 dnia; najlepiej zjedz od razu. Sam hummus przechowuj do 2 dni i składaj tortillę przed podaniem. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'ml'::jednostka_miary, 30,
       'do rozluźnienia hummusu; dodawana stopniowo', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz i odsącz ciecierzycę. Umyj pomidora, ogórek, sałatę i cytrynę. Osusz sałatę, pokrój warzywa w cienkie paski.', null::text, false),
         (3::smallint, 'Obierz czosnek, wyciśnij i odmierz sok z cytryny. Odmierz sezam, oliwę i wodę do hummusu. Przygotuj tortille.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie hummusu i zwijanie', 7 from przepisy p where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'W wąskim naczyniu zblenduj sezam z oliwą, sokiem z cytryny i częścią wody. Dodaj ciecierzycę, czosnek, kmin i sól; blenduj 2–3 minuty, dodając stopniowo resztę wody. Pasta ma się łatwo rozsmarowywać; drobinki sezamu mogą pozostać.', null::text, false),
         (2::smallint, 'Posmaruj tortillę hummusem, ułóż sałatę i warzywa, zostawiając wolne brzegi. Zawiń boki i zroluj. Nadmiar hummusu i warzyw, który nie mieści się w tortilli, podaj obok.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z jajkiem i szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z jajkiem i szpinakiem', 'Ciepła pełnoziarnista tortilla z jajkiem, szpinakiem, pomidorem i fetą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 366, 1, 1,
  8, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz szpinak. Umyj pomidora i pokrój drobno. Pokrusz fetę.', null::text, false),
         (3::smallint, 'Roztrzep jajka w misce z pieprzem i odmierzoną solą. Przygotuj tortille.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i zwijanie', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Smaż pomidora 2–3 minuty, aby odparować płyn. Dodaj szpinak i smaż 1 minutę.', null::text, false),
         (2::smallint, 'Wlej jajka, smaż na małym ogniu 2–3 minuty, mieszając do ścięcia bez płynnego białka. Przełóż farsz na talerz.', null::text, false),
         (3::smallint, 'Ogrzej tortillę na suchej patelni po 15–20 sekund na stronę. Dodaj farsz oraz fetę, zostawiając wolne brzegi. Nadmiar farszu podaj obok.', null::text, false),
         (4::smallint, 'Zwiń i opiekaj po 1 minucie z każdej strony na średnio małym ogniu. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z kurczakiem, awokado i warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z kurczakiem, awokado i warzywami', 'Pełnoziarnista tortilla z grillowanym kurczakiem, awokado, pomidorem, ogórkiem i sosem jogurtowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 557, 1, 1,
  12, 13,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Składniki przechowuj osobno w lodówce do 1 dnia. Tortillę składaj przed jedzeniem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj warzywa i awokado. Osusz sałatę, pokrój pomidora i ogórek w cienkie kawałki. Usuń skórkę i pestkę awokado, pokrój miąższ.', null::text, false),
         (3::smallint, 'Umyj cytrynę, wyciśnij i odmierz sok. Wymieszaj go z jogurtem i częścią soli oraz pieprzu.', null::text, false),
         (4::smallint, 'Kurczaka osusz, pokrój w paski około 1 cm i wymieszaj z olejem, papryką oraz resztą przypraw. Umyj przybory i ręce po mięsie. Przygotuj tortille.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie', 13 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej patelnię przez 1 minutę.', null::text, false),
         (2::smallint, 'Smaż kurczaka przez 6–8 minut na średnio dużym ogniu, obracając.', 'mięso ma co najmniej 74°C w środku'::text, true),
         (3::smallint, 'Przełóż kurczaka na czysty talerz. Ogrzej tortillę na patelni po 15–20 sekund na stronę.', null::text, false),
         (4::smallint, 'Posmaruj tortillę sosem, ułóż sałatę, warzywa, awokado i kurczaka. Zostaw wolne brzegi, zwiń boki i zroluj. Nadmiar nadzienia podaj obok jako sałatkę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z tofu i chrupiącymi warzywami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z tofu i chrupiącymi warzywami', 'Pełnoziarnista tortilla z rumianym tofu, kapustą pekińską, marchewką i ogórkiem w sosie orzechowo-sojowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 528, 1, 1,
  12, 12,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Miska', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Farsz przechowuj w lodówce do 1 dnia. Tortillę składaj bezpośrednio przed jedzeniem. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'ml'::jednostka_miary, 15,
       'do sosu orzechowego', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj kapustę i ogórek, osusz i pokrój w cienkie paski. Umyj i obierz marchew, zetrzyj.', null::text, false),
         (3::smallint, 'Odsącz i dokładnie osusz tofu, pokrój w cienkie paski. Umyj limonkę, wyciśnij i odmierz sok.', null::text, false),
         (4::smallint, 'Wymieszaj masło orzechowe z sosem sojowym, sokiem z limonki i odmierzoną wodą. Przygotuj tortille oraz sezam.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej olej przez 1 minutę. Smaż tofu 6–8 minut, obracając, aż brzegi się zrumienią. Przełóż na talerz.', null::text, false),
         (2::smallint, 'Ogrzej tortillę na suchej patelni po 15–20 sekund na stronę. Posmaruj sosem, ułóż tofu i warzywa, posyp sezamem.', null::text, false),
         (3::smallint, 'Zawiń boki i zroluj bez przepełniania. Pozostałe tofu i warzywa podaj obok z resztą sosu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tosty z Goudą i pieczarkami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z Goudą i pieczarkami', 'Chrupiące tosty z serem Gouda, podsmażonymi pieczarkami i cebulą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 296, 1, 1,
  6, 17,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Oczyść pieczarki i pokrój w cienkie plasterki. Obierz i posiekaj cebulę. Pokrój Goudę w plastry, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie nadzienia', 10 from przepisy p where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozpuść masło na patelni przez 1 minutę. Dodaj cebulę i pieczarki, smaż 7–8 minut na średnim ogniu, aż płyn odparuje.', null::text, false),
         (2::smallint, 'Dodaj tymianek i pieprz. Pod koniec smażenia włącz grill kontaktowy zgodnie z instrukcją urządzenia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Składanie i opiekanie', 7 from przepisy p where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozdziel połowę odmierzonego sera między dolne kromki, ułóż pieczarki i resztę sera. Przykryj pozostałym pieczywem. Nadmiar farszu podaj obok.', null::text, false),
         (2::smallint, 'W rozgrzanym grillu kontaktowym opiekaj przez około 3–5 minut, aż ser się rozpuści i chleb zrumieni. Przy większej ilości opiekaj partiami, doliczając czas.', null::text, false),
         (3::smallint, 'Odczekaj 1 minutę i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z Goudą i pieczarkami') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Tosty z mozzarellą i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z mozzarellą i pomidorem', 'Chrupiące tosty z roztopioną mozzarellą, pomidorem i bazylią. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 219, 1, 1,
  5, 10,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj pomidora i bazylię, osusz. Mozzarellę odsącz, pokrój w cienkie plastry. Pokrój pomidora cienko, osusz plasterki. Przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie i opiekanie', 10 from przepisy p where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej grill kontaktowy zgodnie z instrukcją urządzenia, zwykle około 3 minut.', null::text, false),
         (2::smallint, 'Na dolnych kromkach rozłóż mozzarellę, pomidora i bazylię. Dopraw solą oraz pieprzem i przykryj pozostałymi kromkami.', null::text, false),
         (3::smallint, 'Opiekaj w rozgrzanym grillu przez 3–5 minut, aż ser się roztopi, a chleb zrumieni. Większą ilość opiekaj partiami.', null::text, false),
         (4::smallint, 'Odczekaj 1 minutę, przekrój i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z mozzarellą i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tosty z serem salami i papryką
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tosty z serem salami i papryką', 'Ciepłe tosty z serem salami, papryką i musztardą. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 251, 1, 1,
  6, 11,
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 6 from przepisy p where lower(p.nazwa) = lower('Tosty z serem salami i papryką');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj paprykę, usuń nasiona i pokrój miąższ w bardzo cienkie paski. Pokrój ser salami w plastry. Przygotuj pieczywo, musztardę i miękkie masło.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie i opiekanie', 11 from przepisy p where lower(p.nazwa) = lower('Tosty z serem salami i papryką');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej grill kontaktowy według instrukcji, zwykle około 3 minut.', null::text, false),
         (2::smallint, 'Wewnętrzne strony pieczywa posmaruj musztardą. Ułóż ser, cienką warstwę papryki i posyp papryką wędzoną oraz pieprzem. Zamknij kanapki, nadmiar papryki podaj obok.', null::text, false),
         (3::smallint, 'Zewnętrzne strony posmaruj odmierzoną ilością masła. Opiekaj 4–6 minut w grillu, aż chleb się zrumieni i ser stopi.', null::text, false),
         (4::smallint, 'Odczekaj 1 minutę i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tosty z serem salami i papryką') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Twarożek ze szczypiorkiem, rzodkiewką i pieczywem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 'Klasyczny twarożek z chrupiącą rzodkiewką i świeżym szczypiorkiem, podany z dwiema kromkami chleba żytniego razowego. Ilości składników dobierz z listy dla przygotowywanej liczby porcji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 312, 1, 1,
  8, 0,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Widelec', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Twarożek przechowuj w zamkniętym pojemniku w lodówce do 1 dnia. Pieczywo trzymaj osobno i dodaj dopiero przy podaniu. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj rzodkiewki i szczypiorek, osusz. Usuń końcówki rzodkiewek, pokrój drobno; posiekaj szczypiorek. Odmierz twaróg i jogurt, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie i podanie', 3 from przepisy p where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgnieć twaróg widelcem z jogurtem.', 'masa kremowa, lekko grudkowata'::text, false),
         (2::smallint, 'Dodaj rzodkiewki i szczypiorek. Dopraw odmierzoną solą oraz pieprzem, wymieszaj i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Wieprzowina z kapustą pekińską i ryżem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wieprzowina z kapustą pekińską i ryżem', 'Szybko smażona wieprzowina z kapustą pekińską, marchewką, imbirem i ryżem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 621, 1, 1,
  12, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Porcję z ugotowanym ryżem szybko schłodź w płytkim pojemniku i wstaw do lodówki, najlepiej w ciągu godziny. Przechowuj do 24 godzin. Odgrzewaj tylko raz, do gorącego środka całej porcji. Lodówka: do 4°C.',
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
  liczba_porcji_bazowych = excluded.liczba_porcji_bazowych,
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
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Opłucz ryż. Umyj kapustę, oddziel grube białe części od liści i cienko pokrój. Umyj i obierz marchew, pokrój w cienkie paski. Obierz i pokrój cebulę.', null::text, false),
         (3::smallint, 'Obierz czosnek oraz imbir, posiekaj czosnek i zetrzyj imbir. Odmierz sezam i sos sojowy.', null::text, false),
         (4::smallint, 'Osusz polędwiczkę, usuń twardą błonę i pokrój mięso w paski około 1 cm. Wymieszaj z połową sosu sojowego. Umyj przybory i ręce po mięsie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj ryż i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Rozgrzej połowę oleju przez 1 minutę. Smaż mięso 4–5 minut, obracając, do temperatury co najmniej 63°C. Przełóż na czysty talerz na co najmniej 3 minuty.', null::text, false),
         (3::smallint, 'Dodaj pozostały olej, cebulę, marchew i białe części kapusty; smaż 4 minuty. Dodaj imbir i czosnek, smaż 30 sekund.', null::text, false),
         (4::smallint, 'Dodaj liście kapusty, pozostały sos sojowy i smaż 1–2 minuty. Włóż mięso i podgrzewaj 1 minutę, delikatnie mieszając.', null::text, false),
         (5::smallint, 'Podaj z ryżem i sezamem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and sk.nazwa = 'Oliwa z oliwek';
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
         (1::smallint, 'Umyj udka z kurczaka. Zostaw mięso w całości.', null::text, false),
         (2::smallint, 'Umyj ręce oraz przybory i powierzchnie, które miały kontakt z surowym mięsem. Do warzyw użyj czystej deski i noża.', null::text, false),
         (3::smallint, 'Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, 'Obierz i drobno posiekaj czosnek oraz imbir.', null::text, false),
         (5::smallint, 'Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w paski szerokości około 5 mm.', null::text, false),
         (6::smallint, 'Umyj cukinię i pokrój w półplasterki grubości około 5 mm.', null::text, false),
         (7::smallint, 'Umyj i posiekaj szczypiorek. Umyj limonkę, wyciśnij sok z ilości wskazanej na liście składników i odstaw do końcowego doprawienia.', null::text, false),
         (8::smallint, 'Odmierz mleko kokosowe, pastę curry, sos sojowy, oliwę, suchy ryż i wodę do curry w ilościach wskazanych na liście składników dla przygotowywanej liczby porcji.', null::text, false),
         (9::smallint, 'Przepłucz ryż na sitku pod zimną wodą i odstaw do gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kurczaka oraz równoległe przygotowanie ryżu i curry', 42 from przepisy p where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Włóż pałki do garnka mieszczącego przygotowywaną ilość mięsa. Zalej zimną wodą tak, aby przykryła mięso, i włącz grzanie na pierwszym palniku.', null::text, true),
         (2::smallint, 'Doprowadź wodę z mięsem do wrzenia; zwykle zajmuje to około 5 minut. Czas zależy od ilości wody i mocy palnika. Składniki są już przygotowane.', null::text, false),
         (3::smallint, 'Po zagotowaniu zbierz szumowiny łyżką cedzakową. Zmniejsz ogień i uchyl pokrywkę.', null::text, false),
         (4::smallint, 'Gotuj kurczaka na małym ogniu przez 32 minuty. Licz czas od rozpoczęcia łagodnego gotowania po zebraniu szumowin. Woda ma delikatnie bulgotać. Nastaw minutnik. W czasie gotowania mięsa ugotuj ryż i przygotuj bazę curry według kolejnych kroków. Po sygnale minutnika sprawdź mięso, niezależnie od postępu pracy przy curry.', null::text, true),
         (5::smallint, 'Na drugim palniku zagotuj w garnku większą ilość wody, tak aby ryż po wsypaniu był zanurzony i mógł swobodnie się gotować. Wsyp opłukany ryż, zamieszaj i gotuj przez czas podany na opakowaniu. Przed odcedzeniem sprawdź, czy ziarna są miękkie. Kurczak w tym czasie gotuje się na pierwszym palniku.', null::text, false),
         (6::smallint, 'Ugotowany ryż odcedź na sitku, przełóż z powrotem do garnka i przykryj. Odstaw poza palnik do podania. Drugi palnik jest teraz wolny do przygotowania curry.', 'ziarna są miękkie, a nadmiar wody został odcedzony'::text, false),
         (7::smallint, 'Gdy do końca gotowania kurczaka pozostaje około 15 minut, a drugi palnik jest już wolny, postaw na nim patelnię mieszczącą przygotowywaną ilość curry. Wlej odmierzoną oliwę i rozgrzewaj przez około 1 minutę na średnim ogniu. Jeśli ryż nadal się gotuje, rozpocznij przygotowanie curry zaraz po zdjęciu garnka z palnika.', null::text, false),
         (8::smallint, 'Dodaj pokrojoną cebulę i smaż przez 3 minuty na średnim ogniu, mieszając.', 'cebula jest szklista, bez przypalonych brzegów'::text, false),
         (9::smallint, 'Dodaj posiekany czosnek i imbir. Smaż przez 1 minutę na średnim ogniu, mieszając.', null::text, false),
         (10::smallint, 'Dodaj odmierzoną pastę curry i smaż przez 1 minutę, stale mieszając.', 'pasta intensywnie pachnie, ale nie przypala się'::text, false),
         (11::smallint, 'Wlej odmierzone mleko kokosowe oraz wodę do curry, dodaj sos sojowy. Wymieszaj i doprowadź do łagodnego wrzenia, podgrzewając przez około 2 minuty.', null::text, false),
         (12::smallint, 'Dodaj paski papryki do łagodnie gotującej się bazy curry. Gotuj przez 3 minuty na małym ogniu.', null::text, false),
         (13::smallint, 'Dodaj cukinię i gotuj jeszcze przez 4 minuty na małym ogniu. Papryka będzie gotowała się łącznie 7 minut, cukinia 4 minuty. Jeśli mięso nie jest jeszcze gotowe do dodania, zdejmij patelnię z ognia.', 'warzywa lekko zmiękły i zachowują kształt'::text, false),
         (14::smallint, 'Po 32 minutach łagodnego gotowania sprawdź najgrubszą część mięsa termometrem, nie dotykając kości. Sprawdź też widelcem, czy mięso łatwo odchodzi od kości. Jeżeli nie osiągnęło 74°C albo nadal jest twarde, gotuj kolejne 5 minut i ponów kontrolę. Powtarzaj w razie potrzeby.', 'co najmniej 74°C w mięsie i łatwe oddzielanie go od kości'::text, true),
         (15::smallint, 'Gotowe pałki wyjmij łyżką cedzakową na czystą deskę. Wyłącz pierwszy palnik. Wodę z gotowania odlej; możesz zachować niewielką ilość wywaru do ewentualnego rozrzedzenia curry.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Oddzielenie mięsa, połączenie i podanie', 6 from przepisy p where lower(p.nazwa) = lower('Zupa - Tajskie żółte curry z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Odczekaj około 1 minuty przed oddzielaniem mięsa; pałki nadal będą gorące, więc przytrzymuj je widelcem.', null::text, false),
         (2::smallint, 'Przytrzymując pałki widelcem, oddziel mięso od kości i chrząstek. Podziel na większe kawałki.', null::text, false),
         (3::smallint, 'Dodaj mięso do gotowej bazy curry. Podgrzewaj przez 2 minuty na małym ogniu, delikatnie mieszając. Jeśli patelnia czekała poza palnikiem i zawartość przestała być gorąca, najpierw ponownie doprowadź ją do łagodnego wrzenia, a następnie odlicz 2 minuty.', null::text, false),
         (4::smallint, 'Zdejmij patelnię z ognia i wmieszaj sok z limonki. Rozdziel ugotowany ryż oraz całe curry na przygotowywaną liczbę porcji. Posyp szczypiorkiem i podaj.', null::text, false)
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
  'Zupa z białej fasoli i jarmużu', 'Warzywna zupa z białą fasolą, jarmużem i pomidorami, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 826, 1, 2,
  12, 37,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
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
select p.id, sk.id, 500, 'g'::jednostka_miary, 500,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokrojony', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Seler naciowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj jarmuż, usuń twarde łodygi i porwij liście. Umyj i obierz marchew, pokrój w kostkę około 1 cm. Umyj i cienko pokrój seler naciowy.', null::text, false),
         (3::smallint, 'Obierz i posiekaj cebulę oraz czosnek. Opłucz i odsącz fasolę. Odmierz pomidory i bulion, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie zupy', 37 from przepisy p where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę 1 minutę. Smaż cebulę, marchew i seler przez 5 minut. Dodaj czosnek oraz tymianek i smaż 30 sekund.', null::text, false),
         (2::smallint, 'Dodaj pomidory i bulion, doprowadź do wrzenia przez około 4 minuty. Gotuj pod uchyloną pokrywką 15 minut.', null::text, false),
         (3::smallint, 'Dodaj fasolę i jarmuż, gotuj jeszcze 7–8 minut, aż marchew i liście będą miękkie.', null::text, false),
         (4::smallint, 'Dopraw solą oraz pieprzem i podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z białej fasoli i jarmużu') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Zupa z czerwonej soczewicy i pomidorów
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Zupa z czerwonej soczewicy i pomidorów', 'Gęsta zupa z czerwonej soczewicy, pomidorów i marchewki, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 704, 1, 2,
  10, 38,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Zupę przechowuj w lodówce do 3 dni albo zamroź po ostudzeniu. Pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
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
select p.id, sk.id, 500, 'g'::jednostka_miary, 500,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Domowy bulion warzywny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 140, 'g'::jednostka_miary, 140,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Oliwa z oliwek';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i obierz marchew, pokrój w cienkie plasterki. Obierz i posiekaj cebulę oraz czosnek. Opłucz soczewicę na sitku.', null::text, false),
         (3::smallint, 'Umyj cytrynę, wyciśnij i odmierz sok. Odmierz bulion i pomidory, przygotuj pieczywo.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie zupy', 38 from przepisy p where lower(p.nazwa) = lower('Zupa z czerwonej soczewicy i pomidorów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Rozgrzej oliwę przez 1 minutę, smaż cebulę i marchew 5 minut. Dodaj czosnek, kmin i paprykę wędzoną, smaż 30 sekund.', null::text, false),
         (2::smallint, 'Dodaj bulion i soczewicę. Doprowadź do wrzenia przez około 4 minuty. Gotuj pod uchyloną pokrywką 15–18 minut, mieszając co kilka minut.', null::text, false),
         (3::smallint, 'Gdy soczewica jest miękka, dodaj pomidory i gotuj jeszcze 6–8 minut. Jeśli soczewica jest twarda, dogotuj ją przed dodaniem pomidorów.', null::text, false),
         (4::smallint, 'Zdejmij z ognia, dodaj sok z cytryny, sól i pieprz. Podaj z pieczywem.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and sk.nazwa = 'Oliwa z oliwek';
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
         (1::smallint, 'Przygotuj wszystkie składniki w ilościach z listy dla wybranej liczby porcji. Odmierz także wszystkie przyprawy i dodatki podane na liście.', null::text, false),
         (2::smallint, 'Umyj i osusz szpinak. Obierz i posiekaj czosnek. Umyj cytrynę i odmierz sok. Przygotuj kaszę.', null::text, false),
         (3::smallint, 'Osusz łososia, usuń ości i dopraw częścią soli oraz pieprzu. Po surowej rybie umyj przybory i ręce.', null::text, false),
         (4::smallint, 'Wymieszaj jogurt z połową odmierzonego soku z cytryny.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, 'Na pierwszym palniku zagotuj wodę w garnku. Dodaj kaszę bulgur i gotuj przez czas wskazany na opakowaniu; po ugotowaniu odcedź. Wody użyj tyle, by ziarna były zanurzone i swobodnie się gotowały. Nastaw minutnik; równolegle wykonuj kolejne czynności na drugim palniku. Woda do gotowania jest dodatkowa i zostanie odlana.', null::text, false),
         (2::smallint, 'Gdy do końca gotowania kaszy pozostaje około 11 minut, rozgrzej oliwę na patelni przez 1 minutę.', null::text, false),
         (3::smallint, 'Smaż filet grubości około 2–3 cm przez 4 minuty z jednej strony i 3–4 minuty z drugiej. Sprawdź środek; grubszy kawałek dosmaż po 1 minucie. Zdejmij na talerz.', 'ryba ma co najmniej 63°C i rozdziela się na płatki'::text, true),
         (4::smallint, 'Zmniejsz ogień. Na tej samej patelni smaż czosnek 20–30 sekund. Dodaj szpinak i smaż 1–2 minuty do zwiędnięcia. Zdejmij z ognia, dodaj pozostały sok z cytryny i przyprawy.', null::text, false),
         (5::smallint, 'Podaj łososia z kaszą, szpinakiem i sosem jogurtowym.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Łosoś ze szpinakiem i kaszą bulgur') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Chili sin carne z czarną fasolą', 13, 2, 9),
  ('Curry z ciecierzycy, pomidorów i szpinaku', 12, 2, 9),
  ('Curry z czerwonej soczewicy i szpinaku', 11, 2, 7),
  ('Dorsz w kokosowym curry ze szpinakiem', 12, 3, 20),
  ('Grochówka z indykiem', 14, 2, 9),
  ('Gulasz jagnięcy z ciecierzycą i pomidorami', 13, 2, 11),
  ('Gulasz wołowy z warzywami korzeniowymi', 15, 2, 9),
  ('Gulasz z białej fasoli, jarmużu i pomidorów', 13, 2, 8),
  ('Jaglanka z gruszką i orzechami', 7, 2, 7),
  ('Jajecznica z pomidorem i szczypiorkiem', 7, 2, 6),
  ('Jajka na miękko z pieczywem i warzywami', 7, 2, 6),
  ('Kanapki z Goudą, jajkiem i szczypiorkiem', 7, 3, 5),
  ('Kanapki z Goudą, pomidorem i sałatą', 7, 2, 3),
  ('Kanapki z halloumi, awokado i pomidorem', 7, 2, 6),
  ('Kanapki z jajkiem, awokado i pomidorem', 6, 2, 5),
  ('Kanapki z mozzarellą, pomidorem i bazylią', 7, 2, 3),
  ('Kanapki z pastą jajeczną', 7, 2, 5),
  ('Kanapki z ricottą, rzodkiewką i szczypiorkiem', 7, 2, 3),
  ('Kanapki z sardynkami, pomidorem i rukolą', 7, 2, 4),
  ('Kanapki z serem salami, ogórkiem kiszonym i musztardą', 7, 2, 3),
  ('Kałamarnica z papryką i ryżem', 11, 2, 9),
  ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 12, 2, 10),
  ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 12, 2, 8),
  ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 13, 3, 10),
  ('Krem z brokułów z fetą', 11, 2, 8),
  ('Krem z dyni na mleku kokosowym', 14, 2, 7),
  ('Krem z kalafiora z pieczoną ciecierzycą', 12, 2, 8),
  ('Krewetki z czosnkiem, cukinią i ryżem', 9, 2, 8),
  ('Królik z rozmarynem i warzywami korzeniowymi', 12, 2, 8),
  ('Kurczak pieczony z batatem i brokułem', 10, 2, 9),
  ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 13, 2, 7),
  ('Makaron z brokułem i fetą', 8, 2, 7),
  ('Makaron z ciecierzycą, bazylią i orzechami', 10, 2, 7),
  ('Makaron z indykiem, pieczarkami i jogurtem', 10, 2, 8),
  ('Makaron z kurczakiem, szpinakiem i pomidorami', 12, 2, 8),
  ('Makaron z pieczonymi warzywami i mozzarellą', 11, 2, 7),
  ('Makaron z polędwiczką i pieczarkami', 11, 2, 8),
  ('Makaron z ricottą i szpinakiem', 9, 2, 6),
  ('Makaron z tuńczykiem, cytryną i natką pietruszki', 9, 2, 6),
  ('Makaron z wołowiną i sosem pomidorowym', 11, 2, 7),
  ('Małże w pomidorowym bulionie', 10, 2, 7),
  ('Morszczuk w sosie pomidorowym z ryżem', 11, 2, 8),
  ('Nocna owsianka z bananem i chia', 7, 4, 5),
  ('Nocna owsianka z borówkami i orzechami', 6, 4, 5),
  ('Omlet ze szpinakiem i fetą', 7, 2, 7),
  ('Owsianka z jabłkiem, cynamonem i orzechami', 6, 2, 5),
  ('Papryka faszerowana soczewicą i kaszą bulgur', 11, 3, 10),
  ('Pełnoziarniste placuszki ze skyrem i owocami', 8, 2, 6),
  ('Pieczona makrela z burakami i ziemniakami', 9, 2, 8),
  ('Pieczone warzywa korzeniowe z tymiankiem', 11, 2, 6),
  ('Pieczony bakłażan z ciecierzycą i fetą', 11, 2, 8),
  ('Pieczony kalafior z ziołowym sosem jogurtowym', 10, 2, 7),
  ('Pieczony łosoś z brokułem i ziemniakami', 9, 2, 8),
  ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 13, 2, 11),
  ('Placuszki bananowo-owsiane', 7, 2, 6),
  ('Polędwiczka w sosie musztardowym z kaszą bulgur', 11, 2, 9),
  ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 11, 2, 7),
  ('Pstrąg pieczony z warzywami korzeniowymi', 10, 2, 7),
  ('Pudding chia z mango i mlekiem kokosowym', 5, 4, 6),
  ('Ryż z pieczarkami, szpinakiem i parmezanem', 10, 2, 7),
  ('Sałatka brokułowa z jajkiem i sosem jogurtowym', 9, 3, 7),
  ('Sałatka makaronowa z mozzarellą i warzywami', 11, 3, 6),
  ('Sałatka makaronowa z tuńczykiem i warzywami', 10, 3, 6),
  ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 11, 2, 6),
  ('Sałatka z jajkiem, fetą i warzywami', 8, 3, 6),
  ('Sałatka z jarmużu, jabłka i orzechów', 9, 2, 6),
  ('Sałatka z komosy, buraka i koziego sera', 11, 3, 8),
  ('Sałatka z pieczonym burakiem i fetą', 9, 3, 7),
  ('Serek wiejski z owocami i orzechami', 5, 2, 3),
  ('Serek wiejski z pomidorem, ogórkiem i pestkami dyni', 7, 2, 4),
  ('Skyr kakaowy z bananem i masłem orzechowym', 5, 2, 4),
  ('Skyr z owocami, płatkami owsianymi i orzechami', 5, 2, 3),
  ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 8, 2, 9),
  ('Tabbouleh z kaszy bulgur i ciecierzycy', 11, 3, 5),
  ('Tofu z brokułem i ryżem', 10, 2, 9),
  ('Tofucznica ze szpinakiem i pomidorem', 9, 2, 7),
  ('Tortilla z Goudą, szpinakiem i pomidorem', 8, 2, 6),
  ('Tortilla z hummusem i warzywami', 12, 2, 5),
  ('Tortilla z jajkiem i szpinakiem', 8, 2, 7),
  ('Tortilla z kurczakiem, awokado i warzywami', 12, 2, 8),
  ('Tortilla z tofu i chrupiącymi warzywami', 11, 2, 7),
  ('Tosty z Goudą i pieczarkami', 7, 3, 7),
  ('Tosty z mozzarellą i pomidorem', 6, 2, 6),
  ('Tosty z serem salami i papryką', 7, 2, 6),
  ('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem', 7, 2, 4),
  ('Wieprzowina z kapustą pekińską i ryżem', 10, 2, 9),
  ('Zupa - Tajskie żółte curry z kurczakiem', 14, 3, 28),
  ('Zupa z białej fasoli i jarmużu', 13, 2, 7),
  ('Zupa z czerwonej soczewicy i pomidorów', 13, 2, 7),
  ('Łosoś ze szpinakiem i kaszą bulgur', 9, 2, 9)
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
where lower(p.nazwa) in (lower('Chili sin carne z czarną fasolą'), lower('Curry z ciecierzycy, pomidorów i szpinaku'), lower('Curry z czerwonej soczewicy i szpinaku'), lower('Dorsz w kokosowym curry ze szpinakiem'), lower('Grochówka z indykiem'), lower('Gulasz jagnięcy z ciecierzycą i pomidorami'), lower('Gulasz wołowy z warzywami korzeniowymi'), lower('Gulasz z białej fasoli, jarmużu i pomidorów'), lower('Jaglanka z gruszką i orzechami'), lower('Jajecznica z pomidorem i szczypiorkiem'), lower('Jajka na miękko z pieczywem i warzywami'), lower('Kanapki z Goudą, jajkiem i szczypiorkiem'), lower('Kanapki z Goudą, pomidorem i sałatą'), lower('Kanapki z halloumi, awokado i pomidorem'), lower('Kanapki z jajkiem, awokado i pomidorem'), lower('Kanapki z mozzarellą, pomidorem i bazylią'), lower('Kanapki z pastą jajeczną'), lower('Kanapki z ricottą, rzodkiewką i szczypiorkiem'), lower('Kanapki z sardynkami, pomidorem i rukolą'), lower('Kanapki z serem salami, ogórkiem kiszonym i musztardą'), lower('Kałamarnica z papryką i ryżem'), lower('Klopsiki z indyka w sosie pomidorowym z bulgurem'), lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami'), lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym'), lower('Krem z brokułów z fetą'), lower('Krem z dyni na mleku kokosowym'), lower('Krem z kalafiora z pieczoną ciecierzycą'), lower('Krewetki z czosnkiem, cukinią i ryżem'), lower('Królik z rozmarynem i warzywami korzeniowymi'), lower('Kurczak pieczony z batatem i brokułem'), lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy'), lower('Makaron z brokułem i fetą'), lower('Makaron z ciecierzycą, bazylią i orzechami'), lower('Makaron z indykiem, pieczarkami i jogurtem'), lower('Makaron z kurczakiem, szpinakiem i pomidorami'), lower('Makaron z pieczonymi warzywami i mozzarellą'), lower('Makaron z polędwiczką i pieczarkami'), lower('Makaron z ricottą i szpinakiem'), lower('Makaron z tuńczykiem, cytryną i natką pietruszki'), lower('Makaron z wołowiną i sosem pomidorowym'), lower('Małże w pomidorowym bulionie'), lower('Morszczuk w sosie pomidorowym z ryżem'), lower('Nocna owsianka z bananem i chia'), lower('Nocna owsianka z borówkami i orzechami'), lower('Omlet ze szpinakiem i fetą'), lower('Owsianka z jabłkiem, cynamonem i orzechami'), lower('Papryka faszerowana soczewicą i kaszą bulgur'), lower('Pełnoziarniste placuszki ze skyrem i owocami'), lower('Pieczona makrela z burakami i ziemniakami'), lower('Pieczone warzywa korzeniowe z tymiankiem'), lower('Pieczony bakłażan z ciecierzycą i fetą'), lower('Pieczony kalafior z ziołowym sosem jogurtowym'), lower('Pieczony łosoś z brokułem i ziemniakami'), lower('Pierś z kaczki z pomarańczą i czerwoną kapustą'), lower('Placuszki bananowo-owsiane'), lower('Polędwiczka w sosie musztardowym z kaszą bulgur'), lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'), lower('Pstrąg pieczony z warzywami korzeniowymi'), lower('Pudding chia z mango i mlekiem kokosowym'), lower('Ryż z pieczarkami, szpinakiem i parmezanem'), lower('Sałatka brokułowa z jajkiem i sosem jogurtowym'), lower('Sałatka makaronowa z mozzarellą i warzywami'), lower('Sałatka makaronowa z tuńczykiem i warzywami'), lower('Sałatka z czarnej fasoli, kukurydzy i pomidora'), lower('Sałatka z jajkiem, fetą i warzywami'), lower('Sałatka z jarmużu, jabłka i orzechów'), lower('Sałatka z komosy, buraka i koziego sera'), lower('Sałatka z pieczonym burakiem i fetą'), lower('Serek wiejski z owocami i orzechami'), lower('Serek wiejski z pomidorem, ogórkiem i pestkami dyni'), lower('Skyr kakaowy z bananem i masłem orzechowym'), lower('Skyr z owocami, płatkami owsianymi i orzechami'), lower('Stek z tuńczyka z fasolką szparagową i ziemniakami'), lower('Tabbouleh z kaszy bulgur i ciecierzycy'), lower('Tofu z brokułem i ryżem'), lower('Tofucznica ze szpinakiem i pomidorem'), lower('Tortilla z Goudą, szpinakiem i pomidorem'), lower('Tortilla z hummusem i warzywami'), lower('Tortilla z jajkiem i szpinakiem'), lower('Tortilla z kurczakiem, awokado i warzywami'), lower('Tortilla z tofu i chrupiącymi warzywami'), lower('Tosty z Goudą i pieczarkami'), lower('Tosty z mozzarellą i pomidorem'), lower('Tosty z serem salami i papryką'), lower('Twarożek ze szczypiorkiem, rzodkiewką i pieczywem'), lower('Wieprzowina z kapustą pekińską i ryżem'), lower('Zupa - Tajskie żółte curry z kurczakiem'), lower('Zupa z białej fasoli i jarmużu'), lower('Zupa z czerwonej soczewicy i pomidorów'), lower('Łosoś ze szpinakiem i kaszą bulgur'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
