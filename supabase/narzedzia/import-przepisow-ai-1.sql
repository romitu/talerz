-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 30 (część 1 z 4)
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
    ('Chili sin carne z czarną fasolą', 'Fasola czarna z puszki, odsączona', false),
    ('Chili sin carne z czarną fasolą', 'Fasola czerwona z puszki, odsączona', false),
    ('Chili sin carne z czarną fasolą', 'Kukurydza konserwowa, odsączona', false),
    ('Chili sin carne z czarną fasolą', 'Pomidory krojone z puszki', false),
    ('Chili sin carne z czarną fasolą', 'Passata pomidorowa', false),
    ('Chili sin carne z czarną fasolą', 'Papryka czerwona, surowa', false),
    ('Chili sin carne z czarną fasolą', 'Cebula, surowa', false),
    ('Chili sin carne z czarną fasolą', 'Czosnek, surowy', false),
    ('Chili sin carne z czarną fasolą', 'Oliwa z oliwek extra virgin', false),
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
    ('Curry z ciecierzycy, pomidorów i szpinaku', 'Oliwa z oliwek extra virgin', false),
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
    ('Curry z czerwonej soczewicy i szpinaku', 'Oliwa z oliwek extra virgin', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Kurkuma mielona', false),
    ('Curry z czerwonej soczewicy i szpinaku', 'Sól kłodawska', false),
    ('Dorsz po grecku', 'Marchew, surowa', false),
    ('Dorsz po grecku', 'Cebula, surowa', false),
    ('Dorsz po grecku', 'Pietruszka korzeń', false),
    ('Dorsz po grecku', 'Cytryna', false),
    ('Dorsz po grecku', 'Ziemniaki, surowe', false),
    ('Dorsz po grecku', 'Passata pomidorowa', false),
    ('Dorsz po grecku', 'Oliwa z oliwek extra virgin', false),
    ('Dorsz po grecku', 'liść laurowy', true),
    ('Dorsz po grecku', 'Papryka słodka mielona', false),
    ('Dorsz po grecku', 'Sól kłodawska', false),
    ('Dorsz po grecku', 'Czarny pieprz mielony', false),
    ('Dorsz po grecku', 'woda', false),
    ('Dorsz po grecku', 'Filet z dorsza atlantyckiego', false),
    ('Dorsz po grecku', 'Seler korzeń', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Filet z dorsza atlantyckiego', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Szpinak, surowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Mleko kokosowe light z puszki', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Pomidory krojone z puszki', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Ryż basmati, suchy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Cebula, surowa', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Pasta curry czerwona', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Imbir korzeń, surowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Czosnek, surowy', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Oliwa z oliwek extra virgin', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Limonka', false),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Sól kłodawska', false),
    ('Fasolka po bretońsku z indykiem', 'Filet z indyka, surowy', false),
    ('Fasolka po bretońsku z indykiem', 'Fasola biała z puszki, odsączona', false),
    ('Fasolka po bretońsku z indykiem', 'Passata pomidorowa', false),
    ('Fasolka po bretońsku z indykiem', 'Pomidory suszone w oleju', false),
    ('Fasolka po bretońsku z indykiem', 'Cebula, surowa', false),
    ('Fasolka po bretońsku z indykiem', 'Czosnek, surowy', false),
    ('Fasolka po bretońsku z indykiem', 'Chleb żytni razowy', true),
    ('Fasolka po bretońsku z indykiem', 'Oliwa z oliwek extra virgin', false),
    ('Fasolka po bretońsku z indykiem', 'Majeranek suszony', false),
    ('Fasolka po bretońsku z indykiem', 'Papryka słodka mielona', false),
    ('Fasolka po bretońsku z indykiem', 'liść laurowy', true),
    ('Fasolka po bretońsku z indykiem', 'Sól kłodawska', false),
    ('Fasolka po bretońsku z indykiem', 'Czarny pieprz mielony', false),
    ('Grillowany indyk z halloumi', 'Filet z indyka, surowy', false),
    ('Grillowany indyk z halloumi', 'Halloumi', false),
    ('Grillowany indyk z halloumi', 'Pomidory, surowe', false),
    ('Grillowany indyk z halloumi', 'Rukola', false),
    ('Grillowany indyk z halloumi', 'Czosnek, surowy', false),
    ('Grillowany indyk z halloumi', 'Cytryna', false),
    ('Grillowany indyk z halloumi', 'Chleb żytni razowy', true),
    ('Grillowany indyk z halloumi', 'Oliwa z oliwek extra virgin', false),
    ('Grillowany indyk z halloumi', 'Tymianek suszony', false),
    ('Grillowany indyk z halloumi', 'Sól kłodawska', false),
    ('Grillowany indyk z halloumi', 'Czarny pieprz mielony', false),
    ('Grillowany kurczak caprese', 'Pierś z kurczaka, surowa', false),
    ('Grillowany kurczak caprese', 'Ser mozzarella', false),
    ('Grillowany kurczak caprese', 'Pomidory, surowe', false),
    ('Grillowany kurczak caprese', 'Czosnek, surowy', false),
    ('Grillowany kurczak caprese', 'Bazylia świeża', false),
    ('Grillowany kurczak caprese', 'Chleb żytni razowy', true),
    ('Grillowany kurczak caprese', 'Oliwa z oliwek extra virgin', false),
    ('Grillowany kurczak caprese', 'Oregano suszone', false),
    ('Grillowany kurczak caprese', 'Czarny pieprz mielony', false),
    ('Grillowany kurczak caprese', 'Sól kłodawska', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Pierś z kurczaka, surowa', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Twaróg półtłusty', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Jogurt grecki naturalny 2%', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'ogórki kiszone bio', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Chleb żytni razowy', true),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Cebula czerwona, surowa', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Oliwa z oliwek extra virgin', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'koperek świeży', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Szczypiorek świeży', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Papryka słodka mielona', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Czosnek, surowy', false),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Czarny pieprz mielony', false),
    ('Grochówka z indykiem', 'Groch łuskany, suchy', false),
    ('Grochówka z indykiem', 'Pierś z indyka, surowa', false),
    ('Grochówka z indykiem', 'Ziemniaki, surowe', false),
    ('Grochówka z indykiem', 'Marchew, surowa', false),
    ('Grochówka z indykiem', 'Pietruszka korzeń', false),
    ('Grochówka z indykiem', 'Cebula, surowa', false),
    ('Grochówka z indykiem', 'woda', false),
    ('Grochówka z indykiem', 'Oliwa z oliwek extra virgin', false),
    ('Grochówka z indykiem', 'Majeranek suszony', false),
    ('Grochówka z indykiem', 'liść laurowy', false),
    ('Grochówka z indykiem', 'ziele angielskie', false),
    ('Grochówka z indykiem', 'Sól kłodawska', false),
    ('Grochówka z indykiem', 'Czarny pieprz mielony', false),
    ('Grochówka z indykiem', 'Seler korzeń', false),
    ('Grochówka z indykiem', 'Por, surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Jagnięcina, udziec surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Ciecierzyca z puszki, odsączona', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Pomidory krojone z puszki', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Kasza bulgur, sucha', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Marchew, surowa', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Cebula, surowa', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'woda', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Czosnek, surowy', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Olej rzepakowy rafinowany', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Kmin rzymski mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Cynamon mielony', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Papryka słodka mielona', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Sól kłodawska', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Pietruszka korzeń', false),
    ('Gulasz jagnięcy z ciecierzycą i pomidorami', 'Seler korzeń', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Pręga wołowa bez kości, surowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Seler korzeń', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Cebula, surowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Passata pomidorowa', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'woda', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Olej rzepakowy rafinowany', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Papryka słodka mielona', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Majeranek suszony', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'liść laurowy', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Sól kłodawska', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Gulasz wołowy z warzywami korzeniowymi', 'ogórki kiszone bio', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Fasola biała z puszki, odsączona', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Jarmuż, surowy', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Pomidory krojone z puszki', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Marchew, surowa', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Cebula, surowa', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czosnek, surowy', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'woda', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Oliwa z oliwek extra virgin', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Chleb żytni razowy', true),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Tymianek suszony', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Papryka wędzona mielona', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Sól kłodawska', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Czarny pieprz mielony', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Pietruszka korzeń', false),
    ('Gulasz z białej fasoli, jarmużu i pomidorów', 'Seler korzeń', false),
    ('Gulasz z kaszą gryczaną', 'Gulasz wieprzowy, surowy', false),
    ('Gulasz z kaszą gryczaną', 'Cebula, surowa', false),
    ('Gulasz z kaszą gryczaną', 'Czosnek, surowy', false),
    ('Gulasz z kaszą gryczaną', 'Marchew, surowa', false),
    ('Gulasz z kaszą gryczaną', 'Papryka czerwona, surowa', false),
    ('Gulasz z kaszą gryczaną', 'Passata pomidorowa', false),
    ('Gulasz z kaszą gryczaną', 'Kasza gryczana, sucha', false),
    ('Gulasz z kaszą gryczaną', 'Kapusta kiszona', false),
    ('Gulasz z kaszą gryczaną', 'Olej rzepakowy rafinowany', false),
    ('Gulasz z kaszą gryczaną', 'Papryka słodka mielona', false),
    ('Gulasz z kaszą gryczaną', 'liść laurowy', true),
    ('Gulasz z kaszą gryczaną', 'ziele angielskie', true),
    ('Gulasz z kaszą gryczaną', 'woda', false),
    ('Gulasz z kaszą gryczaną', 'Czarny pieprz mielony', false),
    ('Gulasz z kaszą gryczaną', 'Sól kłodawska', false),
    ('Indyk w sosie orzechowym (satay)', 'Filet z indyka, surowy', false),
    ('Indyk w sosie orzechowym (satay)', 'Masło orzechowe bez cukru', false),
    ('Indyk w sosie orzechowym (satay)', 'Mleko kokosowe light z puszki', false),
    ('Indyk w sosie orzechowym (satay)', 'Czosnek, surowy', false),
    ('Indyk w sosie orzechowym (satay)', 'Imbir korzeń, surowy', false),
    ('Indyk w sosie orzechowym (satay)', 'Sos sojowy', false),
    ('Indyk w sosie orzechowym (satay)', 'Cytryna', false),
    ('Indyk w sosie orzechowym (satay)', 'Marchew, surowa', false),
    ('Indyk w sosie orzechowym (satay)', 'Papryka czerwona, surowa', false),
    ('Indyk w sosie orzechowym (satay)', 'Ryż basmati, suchy', false),
    ('Indyk w sosie orzechowym (satay)', 'Olej rzepakowy rafinowany', false),
    ('Indyk w sosie orzechowym (satay)', 'Papryka ostra mielona', false),
    ('Jajecznica ze szpinakiem', 'Jaja kurze, całe, surowe', true),
    ('Jajecznica ze szpinakiem', 'Szpinak mrożony', false),
    ('Jajecznica ze szpinakiem', 'Oliwa z oliwek extra virgin', false),
    ('Jajecznica ze szpinakiem', 'Chleb żytni razowy', true),
    ('Jajecznica ze szpinakiem', 'Pomidory, surowe', false),
    ('Jajecznica ze szpinakiem', 'Szczypiorek świeży', false),
    ('Jajecznica ze szpinakiem', 'Sól kłodawska', false),
    ('Jajecznica ze szpinakiem', 'Czarny pieprz mielony', false),
    ('Jajka w koszulkach z pastą twarogową', 'Jaja kurze, całe, surowe', true),
    ('Jajka w koszulkach z pastą twarogową', 'Twaróg półtłusty', false),
    ('Jajka w koszulkach z pastą twarogową', 'Mleko 2%', false),
    ('Jajka w koszulkach z pastą twarogową', 'Czosnek, surowy', false),
    ('Jajka w koszulkach z pastą twarogową', 'Oliwa z oliwek extra virgin', false),
    ('Jajka w koszulkach z pastą twarogową', 'Chleb żytni razowy', true),
    ('Jajka w koszulkach z pastą twarogową', 'Papryka słodka mielona', false),
    ('Jajka w koszulkach z pastą twarogową', 'koperek świeży', false),
    ('Jajka w koszulkach z pastą twarogową', 'Ocet jabłkowy', false),
    ('Jajka w koszulkach z pastą twarogową', 'Sól kłodawska', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Chleb żytni razowy', true),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Ser mozzarella', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Pomidory, surowe', true),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Bazylia świeża', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Oliwa z oliwek extra virgin', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Sól kłodawska', false),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Czarny pieprz mielony', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Sardynki w oliwie, odsączone', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Chleb żytni razowy', true),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Pomidory, surowe', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Rukola', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Cytryna', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Oliwa z oliwek extra virgin', false),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Czarny pieprz mielony', false),
    ('Kałamarnica z papryką i ryżem', 'Kałamarnica, surowa', false),
    ('Kałamarnica z papryką i ryżem', 'Papryka czerwona, surowa', false),
    ('Kałamarnica z papryką i ryżem', 'Ryż basmati, suchy', false),
    ('Kałamarnica z papryką i ryżem', 'Passata pomidorowa', false),
    ('Kałamarnica z papryką i ryżem', 'Cebula, surowa', false),
    ('Kałamarnica z papryką i ryżem', 'Czosnek, surowy', false),
    ('Kałamarnica z papryką i ryżem', 'Oliwa z oliwek extra virgin', false),
    ('Kałamarnica z papryką i ryżem', 'Papryka wędzona mielona', false),
    ('Kałamarnica z papryką i ryżem', 'Cytryna', false),
    ('Kałamarnica z papryką i ryżem', 'Pietruszka natka', false),
    ('Kałamarnica z papryką i ryżem', 'Sól kłodawska', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Mięso mielone wołowo-wieprzowe, surowe', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Jaja kurze, całe, surowe', true),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Bułka tarta', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Cebula, surowa', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Czosnek, surowy', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Passata pomidorowa', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Ziemniaki, surowe', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Oliwa z oliwek extra virgin', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Majeranek suszony', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Oregano suszone', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Pietruszka natka', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Sól kłodawska', false),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Czarny pieprz mielony', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Mięso mielone z indyka, surowe', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Bułka tarta', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Jaja kurze, całe, surowe', true),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Passata pomidorowa', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Kasza bulgur, sucha', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Cebula, surowa', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Czosnek, surowy', false),
    ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 'Oliwa z oliwek extra virgin', false),
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
    ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 'Oliwa z oliwek extra virgin', false),
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
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Oliwa z oliwek extra virgin', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Kmin rzymski mielony', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Papryka słodka mielona', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Ogórek, surowy', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Cytryna', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Sól kłodawska', false),
    ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Czarny pieprz mielony', false),
    ('Krem z brokułów z fetą', 'Brokuł, surowy', false),
    ('Krem z brokułów z fetą', 'Ziemniaki, surowe', false),
    ('Krem z brokułów z fetą', 'Cebula, surowa', false),
    ('Krem z brokułów z fetą', 'Czosnek, surowy', false),
    ('Krem z brokułów z fetą', 'Oliwa z oliwek extra virgin', false),
    ('Krem z brokułów z fetą', 'Jogurt naturalny 2%', false),
    ('Krem z brokułów z fetą', 'Ser feta', false),
    ('Krem z brokułów z fetą', 'Chleb żytni razowy', true),
    ('Krem z brokułów z fetą', 'Gałka muszkatołowa mielona', false),
    ('Krem z brokułów z fetą', 'Czarny pieprz mielony', false),
    ('Krem z brokułów z fetą', 'Marchew, surowa', false),
    ('Krem z brokułów z fetą', 'Pietruszka korzeń', false),
    ('Krem z brokułów z fetą', 'Seler korzeń', false),
    ('Krem z brokułów z fetą', 'Por, surowy', false),
    ('Krem z brokułów z fetą', 'woda', false),
    ('Krem z dyni na mleku kokosowym', 'Dynia, surowa', false),
    ('Krem z dyni na mleku kokosowym', 'Marchew, surowa', false),
    ('Krem z dyni na mleku kokosowym', 'Mleko kokosowe light z puszki', false),
    ('Krem z dyni na mleku kokosowym', 'Soczewica czerwona, sucha', false),
    ('Krem z dyni na mleku kokosowym', 'woda', false),
    ('Krem z dyni na mleku kokosowym', 'Cebula, surowa', false),
    ('Krem z dyni na mleku kokosowym', 'Imbir korzeń, surowy', false),
    ('Krem z dyni na mleku kokosowym', 'Czosnek, surowy', false),
    ('Krem z dyni na mleku kokosowym', 'Pasta curry czerwona', false),
    ('Krem z dyni na mleku kokosowym', 'Oliwa z oliwek extra virgin', false),
    ('Krem z dyni na mleku kokosowym', 'Limonka', false),
    ('Krem z dyni na mleku kokosowym', 'Pietruszka natka', false),
    ('Krem z dyni na mleku kokosowym', 'Sól kłodawska', false),
    ('Krem z dyni na mleku kokosowym', 'Pietruszka korzeń', false),
    ('Krem z dyni na mleku kokosowym', 'Seler korzeń', false),
    ('Krem z dyni na mleku kokosowym', 'Por, surowy', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Kalafior, surowy', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Ziemniaki, surowe', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Ciecierzyca z puszki, odsączona', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Cebula, surowa', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Czosnek, surowy', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Oliwa z oliwek extra virgin', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Chleb żytni razowy', true),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Kmin rzymski mielony', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Papryka wędzona mielona', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Sól kłodawska', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Czarny pieprz mielony', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Marchew, surowa', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Pietruszka korzeń', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Seler korzeń', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'Por, surowy', false),
    ('Krem z kalafiora z pieczoną ciecierzycą', 'woda', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Krewetki, surowe', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Cukinia, surowa', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Czosnek, surowy', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Oliwa z oliwek extra virgin', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Cytryna', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Pietruszka natka', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Chili suszone', false),
    ('Krewetki z czosnkiem, cukinią i ryżem', 'Sól kłodawska', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Udo z kurczaka bez skóry, surowe', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Kasza jęczmienna, sucha', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Marchew, surowa', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Pietruszka korzeń', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Seler korzeń', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Por, surowy', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Ziemniaki, surowe', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Pietruszka natka', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'liść laurowy', true),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'ziele angielskie', true),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'woda', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Czarny pieprz mielony', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Sól kłodawska', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Cebula, surowa', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Czosnek, surowy', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Oliwa z oliwek extra virgin', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Papryka słodka mielona', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Chili suszone', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Cytryna', false),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'koperek świeży', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Królik, mięso surowe', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Seler korzeń', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Cebula, surowa', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'woda', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Oliwa z oliwek extra virgin', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Czosnek, surowy', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Rozmaryn świeży', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Sól kłodawska', false),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Czarny pieprz mielony', false)
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
    ('Dorsz po grecku', 'Piekarnik'),
    ('Dorsz po grecku', 'Patelnia 28 cm'),
    ('Dorsz po grecku', 'Naczynie żaroodporne'),
    ('Dorsz po grecku', 'Tarka o grubych oczkach'),
    ('Dorsz po grecku', 'Nóż szefa kuchni'),
    ('Dorsz po grecku', 'Deska do krojenia'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Patelnia 28 cm'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Garnek 2 l'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Nóż szefa kuchni'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Deska do krojenia'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Waga kuchenna'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Sitko'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Termometr do mięsa'),
    ('Dorsz w kokosowym curry ze szpinakiem', 'Widelec'),
    ('Fasolka po bretońsku z indykiem', 'Garnek 3 l'),
    ('Fasolka po bretońsku z indykiem', 'Nóż szefa kuchni'),
    ('Fasolka po bretońsku z indykiem', 'Deska do krojenia'),
    ('Grillowany indyk z halloumi', 'Grill kontaktowy'),
    ('Grillowany indyk z halloumi', 'Nóż szefa kuchni'),
    ('Grillowany indyk z halloumi', 'Deska do krojenia'),
    ('Grillowany kurczak caprese', 'Grill kontaktowy'),
    ('Grillowany kurczak caprese', 'Nóż szefa kuchni'),
    ('Grillowany kurczak caprese', 'Deska do krojenia'),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Grill kontaktowy'),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Nóż szefa kuchni'),
    ('Grillowany kurczak z ogórkiem kiszonym', 'Deska do krojenia'),
    ('Grochówka z indykiem', 'Garnek 3 l'),
    ('Grochówka z indykiem', 'Nóż szefa kuchni'),
    ('Grochówka z indykiem', 'Deska do krojenia'),
    ('Grochówka z indykiem', 'Waga kuchenna'),
    ('Grochówka z indykiem', 'Sitko'),
    ('Grochówka z indykiem', 'Termometr do mięsa'),
    ('Grochówka z indykiem', 'Garnek 2 l'),
    ('Grochówka z indykiem', 'Łyżka cedzakowa'),
    ('Grochówka z indykiem', 'Miska'),
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
    ('Gulasz z kaszą gryczaną', 'Garnek 4 l'),
    ('Gulasz z kaszą gryczaną', 'Garnek 2 l'),
    ('Gulasz z kaszą gryczaną', 'Nóż szefa kuchni'),
    ('Gulasz z kaszą gryczaną', 'Deska do krojenia'),
    ('Indyk w sosie orzechowym (satay)', 'Patelnia 28 cm'),
    ('Indyk w sosie orzechowym (satay)', 'Garnek 2 l'),
    ('Indyk w sosie orzechowym (satay)', 'Nóż szefa kuchni'),
    ('Indyk w sosie orzechowym (satay)', 'Deska do krojenia'),
    ('Jajecznica ze szpinakiem', 'Patelnia 24 cm'),
    ('Jajecznica ze szpinakiem', 'Nóż szefa kuchni'),
    ('Jajecznica ze szpinakiem', 'Deska do krojenia'),
    ('Jajka w koszulkach z pastą twarogową', 'Garnek 2 l'),
    ('Jajka w koszulkach z pastą twarogową', 'Miska'),
    ('Jajka w koszulkach z pastą twarogową', 'Sitko'),
    ('Jajka w koszulkach z pastą twarogową', 'Łyżka cedzakowa'),
    ('Jajka w koszulkach z pastą twarogową', 'Patelnia 24 cm'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Nóż szefa kuchni'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Deska do krojenia'),
    ('Kanapki z mozzarellą, pomidorem i bazylią', 'Waga kuchenna'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Miska'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Widelec'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Nóż szefa kuchni'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Deska do krojenia'),
    ('Kanapki z sardynkami, pomidorem i rukolą', 'Waga kuchenna'),
    ('Kałamarnica z papryką i ryżem', 'Patelnia 28 cm'),
    ('Kałamarnica z papryką i ryżem', 'Garnek 2 l'),
    ('Kałamarnica z papryką i ryżem', 'Nóż szefa kuchni'),
    ('Kałamarnica z papryką i ryżem', 'Deska do krojenia'),
    ('Kałamarnica z papryką i ryżem', 'Waga kuchenna'),
    ('Kałamarnica z papryką i ryżem', 'Sitko'),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Patelnia 28 cm'),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Garnek 2 l'),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Tłuczek do ziemniaków'),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Miska'),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Nóż szefa kuchni'),
    ('Klopsiki w sosie pomidorowym – tradycyjne', 'Deska do krojenia'),
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
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Garnek 4 l'),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Patelnia 28 cm'),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Sitko'),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Nóż szefa kuchni'),
    ('Krupnik z kurczakiem, chili, papryką i cytryną', 'Deska do krojenia'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Piekarnik'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Naczynie żaroodporne'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Deska do krojenia'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Waga kuchenna'),
    ('Królik z rozmarynem i warzywami korzeniowymi', 'Termometr do mięsa')
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój w kostkę około 1 cm.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Fasole.** Obie fasole opłucz i odsącz na sitku. Odmierz każdą po odsączeniu.', null::text, false),
         (5::smallint, '**Kukurydza.** Odsącz kukurydzę i odmierz potrzebną ilość.', null::text, false),
         (6::smallint, '**Płynna baza.** Odmierz passatę i pomidory z puszki.', null::text, false),
         (7::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz wędzoną paprykę, chili i kmin rzymski.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie chili', 34 from przepisy p where lower(p.nazwa) = lower('Chili sin carne z czarną fasolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Dodaj cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Papryka.** Dodaj paprykę i smaż **3 minuty**.', null::text, false),
         (4::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, kmin, paprykę wędzoną oraz chili i smaż **30 sekund**, mieszając.', null::text, false),
         (5::smallint, '**Baza chili.** Dodaj pomidory, passatę, obie fasole i kukurydzę. Doprowadź do łagodnego wrzenia przez około **3 minuty**.', null::text, false),
         (6::smallint, '**Gotowanie chili.** Gotuj bez przykrycia na małym ogniu przez **20 minut**, mieszając co kilka minut.', 'papryka jest miękka, sos gęsty, fasola zachowuje kształt'::text, true),
         (7::smallint, '**Doprawienie i podanie.** Spróbuj, dopraw odmierzoną solą i podaj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Imbir.** Obierz imbir i drobno posiekaj.', null::text, false),
         (4::smallint, '**Ciecierzyca.** Przełóż ciecierzycę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (5::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (6::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (7::smallint, '**Płynna baza.** Odmierz mleko kokosowe.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól, kmin rzymski i garam masala.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 27 from przepisy p where lower(p.nazwa) = lower('Curry z ciecierzycy, pomidorów i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, imbir, garam masala i kmin; smaż **1 minutę**, mieszając.', null::text, false),
         (4::smallint, '**Gotowanie bazy curry.** Dodaj pomidory, mleko kokosowe i ciecierzycę. Doprowadź do wrzenia przez około **2 minuty**, następnie gotuj łagodnie bez przykrycia **15 minut**.', null::text, false),
         (5::smallint, '**Szpinak.** Dodaj szpinak i gotuj jeszcze **1–2 minuty**.', 'liście właśnie zwiędły, a sos zgęstniał'::text, true),
         (6::smallint, '**Doprawienie i podanie.** Zdejmij z ognia. Dodaj przygotowany sok z cytryny, dopraw solą i podaj.', null::text, false)
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
  'waga', 622, 1, 2,
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
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       'dolej jeżeli potrawa za gęsta', null, sk.rola, sk.mozna_dzielic, 5
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Soczewica.** Odmierz soczewicę i opłucz na sitku.', null::text, false),
         (4::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (5::smallint, '**Płynna baza.** Odmierz pomidory z puszki, mleko kokosowe i wodę z listy składników.', null::text, false),
         (6::smallint, '**Pasta curry.** Odmierz pastę curry.', null::text, false),
         (7::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz sól i kurkumę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie curry', 35 from przepisy p where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Pasta curry.** Dodaj czosnek, pastę curry i kurkumę; smaż **1 minutę**, mieszając.', null::text, false),
         (4::smallint, '**Gotowanie soczewicy.** Dodaj soczewicę, odmierzoną wodę i mleko kokosowe. Doprowadź do wrzenia przez około **3 minuty** i gotuj na małym ogniu **12–15 minut** pod uchyloną pokrywką. Mieszaj co kilka minut.', null::text, false),
         (5::smallint, '**Pomidory.** Gdy soczewica zmięknie, dodaj pomidory i gotuj bez przykrycia jeszcze **6–8 minut**. Jeśli soczewica jest twarda, przed dodaniem pomidorów dogotuj ją po **3 minuty**, uzupełniając odparowaną wodę.', 'soczewica jest miękka i częściowo się rozpada'::text, true),
         (6::smallint, '**Szpinak.** Dodaj szpinak i gotuj **1–2 minuty**, tylko do zwiędnięcia.', null::text, false),
         (7::smallint, '**Doprawienie i podanie.** Dopraw solą i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Curry z czerwonej soczewicy i szpinaku') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Dorsz po grecku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Dorsz po grecku', 'Dorsz z duszonymi warzywami korzeniowymi w sosie pomidorowym, podawany z gotowanymi ziemniakami. Danie dobrze smakuje zarówno na ciepło, jak i na zimno, a po kilku godzinach smaki jeszcze lepiej się łączą.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 845, 1, 1,
  10, 30,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Patelnia 28 cm', 'Naczynie żaroodporne', 'Tarka o grubych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w szczelnym pojemniku w lodówce do 3 dni. Danie można jeść również na zimno. Najlepiej przechowywać ziemniaki osobno od dorsza z warzywami.',
  false, 'Ryba się rozpadła — to nie problem, wymieszaj z warzywami. Warzywa za suche — dolej passaty i pogotuj.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Dorsz po grecku'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Dorsz po grecku'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       'obrane', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'Tylko jeżeli sos będzie zbyt gęsty', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Filet z dorsza atlantyckiego';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz po grecku') and sk.nazwa = 'Seler korzeń';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Dorsz po grecku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (2::smallint, '**Seler korzeniowy.** Umyj i obierz seler, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (3::smallint, '**Pietruszka korzeń.** Umyj i obierz korzeń pietruszki, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (5::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki. Pokrój na kawałki podobnej wielkości.', null::text, false),
         (6::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (7::smallint, '**Dorsz.** Osusz dorsza, usuń ewentualne ości. Skrop połową odmierzonego soku z cytryny i dopraw częścią soli oraz pieprzu.', null::text, false),
         (8::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false),
         (9::smallint, '**Płynna baza.** Odmierz passatę i wodę z listy składników.', null::text, false),
         (10::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (11::smallint, '**Przyprawy.** Odmierz słodką paprykę i liście laurowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz po grecku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i pieczenie', 30 from przepisy p where lower(p.nazwa) = lower('Dorsz po grecku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **190°C**.', null::text, false),
         (2::smallint, '**Ziemniaki — równolegle.** Ziemniaki włóż do lekko osolonej wody i gotuj około **15–20 minut**, aż będą miękkie. Będą gotowały się równolegle z przygotowywaniem ryby i warzyw.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na patelni rozgrzej około połowę oliwy.', null::text, false),
         (4::smallint, '**Cebula.** Dodaj cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (5::smallint, '**Warzywa korzeniowe.** Dodaj marchew i pietruszkę i seler. Smaż około **2 minut**, mieszając.', null::text, false),
         (6::smallint, '**Duszenie warzyw.** Dodaj passatę, słodką paprykę i liść laurowy. Wymieszaj, przykryj i duś na niewielkim ogniu około **12–15 minut**. Jeśli sos stanie się zbyt gęsty, dolewaj stopniowo niewielką ilość wody.', 'Warzywa powinny być miękkie, ale nadal zachowywać wyczuwalną strukturę — nie powinny zamienić się w jednolitą masę.'::text, false),
         (7::smallint, '**Pieczenie dorsza.** Gdy warzywa zaczną się dusić, pozostałą oliwą lekko posmaruj dorsza lub naczynie do pieczenia. Włóż dorsza do nagrzanego piekarnika i piecz około **12–15 minut**, zależnie od grubości filetu. Dorsz jest gotowy, gdy mięso staje się nieprzezroczyste i łatwo rozdziela się na płatki widelcem.', 'Dorsz jest gotowy, gdy mięso staje się nieprzezroczyste i łatwo rozdziela się na płatki widelcem.'::text, false),
         (8::smallint, '**Doprawienie sosu.** Usuń liść laurowy. Dodaj pozostały sok z cytryny. Dopraw pozostałą solą i pieprzem. Wymieszaj i spróbuj.', null::text, false),
         (9::smallint, '**Podanie.** Na talerz wyłóż dorsza, przykryj porcją warzyw w sosie pomidorowym i podawaj z ugotowanymi ziemniakami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz po grecku') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Imbir.** Obierz imbir i drobno posiekaj.', null::text, false),
         (4::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (5::smallint, '**Limonka.** Umyj limonkę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (7::smallint, '**Dorsz.** Osusz filet i usuń ości. Pokrój na kawałki szerokości około 3–4 cm, o podobnej grubości do około 3 cm. Mrożoną rybę wcześniej rozmroź w lodówce.', null::text, false),
         (8::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false),
         (9::smallint, '**Płynna baza.** Odmierz pomidory z puszki i mleko kokosowe.', null::text, false),
         (10::smallint, '**Pasta curry.** Odmierz pastę curry.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Sól.** Odmierz sól.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i curry', 26 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Na pierwszym palniku zagotuj w garnku większą ilość wody. Wsyp opłukany ryż i gotuj przez czas podany na opakowaniu. Ryż ma być zanurzony i mieć miejsce do swobodnego gotowania. Nastaw minutnik; podczas podgrzewania wody i gotowania ryżu wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Rozgrzanie oliwy.** Na drugim palniku rozgrzewaj odmierzoną oliwę na patelni przez około **1 minutę** na średnim ogniu. Dobierz patelnię tak, aby później kawałki dorsza zmieściły się w jednej warstwie.', null::text, false),
         (3::smallint, '**Cebula.** Dodaj cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (4::smallint, '**Czosnek i imbir.** Dodaj czosnek oraz imbir i smaż przez **1 minutę**, mieszając.', null::text, false),
         (5::smallint, '**Pasta curry.** Dodaj odmierzoną pastę curry i smaż przez **1 minutę**, stale mieszając.', 'pasta intensywnie pachnie, ale nie przypala się'::text, false),
         (6::smallint, '**Mleko kokosowe i pomidory.** Wlej mleko kokosowe, dodaj odmierzone pomidory i wymieszaj. Podgrzewaj do łagodnego wrzenia przez około **2 minuty**.', null::text, false),
         (7::smallint, '**Gotowanie sosu.** Gotuj sos bez przykrycia na małym ogniu przez **8 minut**, od czasu do czasu mieszając.', 'sos lekko zgęstniał, ale pozostaje płynny i nie przywiera do dna'::text, false),
         (8::smallint, '**Odcedzenie ryżu.** Gdy upłynie czas gotowania ryżu, sprawdź, czy jest miękki. Odcedź go na sitku, przełóż z powrotem do garnka i przykryj. Odstaw poza palnik do podania. Wykonaj ten krok po sygnale minutnika, niezależnie od postępu gotowania curry.', null::text, false),
         (9::smallint, '**Gotowanie dorsza.** Ułóż kawałki dorsza w sosie w jednej warstwie i polej je sosem. Gotuj na małym ogniu przez **5–6 minut**, licząc od ponownego łagodnego wrzenia. Po około **3 minutach** ostrożnie odwróć kawałki; nie mieszaj energicznie. Ryba dokończy gotowanie po dodaniu szpinaku.', null::text, true),
         (10::smallint, '**Szpinak.** Dodaj szpinak między kawałki dorsza i delikatnie zanurz liście w sosie. Gotuj jeszcze przez **1–2 minuty**, aż liście zwiędną. Łączny czas gotowania dorsza wynosi około **6–8 minut**.', null::text, true),
         (11::smallint, '**Sprawdzenie dorsza.** Sprawdź najgrubszy kawałek ryby; jeśli nie jest gotowy, dogotowuj po **1 minucie** i sprawdzaj ponownie. Zakończ gotowanie, gdy ryba jest gotowa, aby jej nie przesuszyć.', 'szpinak właśnie zwiędł; temperatura w środku najgrubszego kawałka dorsza wynosi co najmniej 63°C, a mięso jest nieprzezroczyste i łatwo rozdziela się widelcem'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Doprawienie i podanie', 2 from przepisy p where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Doprawienie.** Zdejmij patelnię z ognia. Dodaj przygotowany sok z limonki i delikatnie rozprowadź go w sosie. Spróbuj sosu i dopraw odmierzoną solą według smaku; pasta curry może już być słona.', null::text, true),
         (2::smallint, '**Podanie.** Rozdziel ryż oraz curry na przygotowywaną liczbę porcji. Przekładaj rybę ostrożnie, aby kawałki zachowały kształt. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Dorsz w kokosowym curry ze szpinakiem') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Fasolka po bretońsku z indykiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Fasolka po bretońsku z indykiem', 'Fasolę zawsze przepłucz po odsączeniu — zejdzie zalewa i danie nie będzie mętne. Trzyma się w lodówce 3 dni. Suszone pomidory odsącz z oleju, inaczej danie wyjdzie tłuste.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 647, 1, 1,
  13, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w szczelnym pojemniku w lodówce do 3 dni. Chleb przechowuj osobno.',
  true, 'Jeżeli sos jest zbyt gęsty, dolej niewielką ilość wody. Jeśli jest zbyt rzadki, gotuj kilka minut bez przykrycia.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Fasolka po bretońsku z indykiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Fasolka po bretońsku z indykiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Filet z indyka, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'odsączona i przepłukana', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Fasola biała z puszki, odsączona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'odsączone, posiekane', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Pomidory suszone w oleju';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 13 from przepisy p where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (3::smallint, '**Suszone pomidory.** Odsącz pomidory z oleju i pokrój na mniejsze kawałki.', null::text, false),
         (4::smallint, '**Fasola.** Przełóż fasolę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (5::smallint, '**Indyk.** Osusz indyka i pokrój w kostkę około 2 cm.', null::text, false),
         (6::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (7::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz pieprz, słodką paprykę, majeranek i liście laurowe.', null::text, false),
         (10::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie indyka i warzyw', 10 from przepisy p where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Na dużej patelni lub w garnku rozgrzej oliwę.', null::text, false),
         (2::smallint, '**Obsmażenie indyka.** Dodaj indyka i smaż na średnio dużym ogniu około **3–4 minut**, aż mięso lekko się zarumieni.', null::text, false),
         (3::smallint, '**Zdjęcie indyka.** Następnie zdejmij indyka z patelni i odłóż na bok.', null::text, false),
         (4::smallint, '**Cebula.** Dodaj cebulę i smaż jeszcze **3–4 minuty** na średnim ogniu, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (5::smallint, '**Czosnek i suszone pomidory.** Dodaj czosnek oraz suszone pomidory. Smaż jeszcze około **1 minuty**, mieszając.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Przygotowanie sosu', 10 from przepisy p where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Składniki sosu.** Dodaj passatę, liść laurowy, majeranek i słodką paprykę.', null::text, false),
         (2::smallint, '**Zagotowanie sosu.** Dokładnie wymieszaj i doprowadź do lekkiego wrzenia', null::text, false),
         (3::smallint, '**Duszenie sosu.** Zmniejsz ogień, przykryj i duś około **8–10 minut**.', null::text, false),
         (4::smallint, '**Konsystencja sosu.** Jeżeli sos zrobi się zbyt gęsty, dolej niewielką ilość wody.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Dodanie fasoli i wykończenie', 5 from przepisy p where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Fasola i indyk.** Dodaj odsączoną i przepłukaną fasolę oraz wcześniej obsmażonego indyka.', null::text, false),
         (2::smallint, '**Dokończenie gotowania.** Delikatnie wymieszaj i gotuj około **4–5 minut**, tylko do pełnego rozgrzania fasoli i dokończenia obróbki indyka.', null::text, false),
         (3::smallint, '**Liść laurowy.** Usuń liść laurowy.', null::text, false),
         (4::smallint, '**Doprawienie.** Dopraw solą i pieprzem do smaku.', null::text, false),
         (5::smallint, '**Podanie.** Podawaj z kromkami chleba żytniego.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Fasolka po bretońsku z indykiem') and e.kolejnosc = 4;

-- -------------------------------------------------------------------------
--  Grillowany indyk z halloumi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grillowany indyk z halloumi', 'Grillowany filet z indyka z halloumi, pomidorem, rukolą i pieczywem żytnim. Halloumi jest wcześniej moczone w wodzie, aby zmniejszyć jego słoność.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 534, 1, 1,
  20, 19,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Halloumi po wystudzeniu twardnieje, dlatego przed podaniem najlepiej krótko podgrzać je na patelni lub grillownicy.',
  false, 'Jeśli indyk jest suchy, prawdopodobnie był grillowany zbyt długo. Przy kolejnym przygotowaniu kontroluj temperaturę i zdejmij mięso po osiągnięciu 74°C. Jeśli halloumi jest zbyt słone, następnym razem mocz je przez około 20 minut w zimnej wodzie.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grillowany indyk z halloumi'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grillowany indyk z halloumi'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 170, 'g'::jednostka_miary, 170,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Filet z indyka, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       'w plastrach 1 cm', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Halloumi';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Rukola';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Grillowany indyk z halloumi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Moczenie halloumi.** Włóż halloumi do zimnej wody i mocz przez **20 minut**. W tym czasie przygotuj pozostałe składniki.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (3::smallint, '**Pomidor.** Umyj pomidory i pokrój w cienkie plastry. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (4::smallint, '**Rukola.** Umyj rukolę i dokładnie osusz.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Indyk.** Rozkrój filet wzdłuż na cieńsze płaty lub delikatnie rozbij do grubości około 1,5 cm. Osusz.', null::text, false),
         (7::smallint, '**Marynata do indyka.** Natrzyj mięso częścią odmierzonej oliwy, czosnkiem i tymiankiem.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Krojenie halloumi.** Po namoczeniu dokładnie osusz ser i pokrój w plastry grubości około 1 cm.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false),
         (11::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Grillowanie indyka', 12 from przepisy p where lower(p.nazwa) = lower('Grillowany indyk z halloumi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie grilla.** Rozgrzej grill kontaktowy zgodnie z instrukcją urządzenia, zwykle przez około **3 minuty**.', null::text, false),
         (2::smallint, '**Indyk na grill.** Indyka lekko dopraw solą i pieprzem. Połóż na grillownicy i zamknij pokrywę bez dodatkowego dociskania.', null::text, false),
         (3::smallint, '**Grillowanie indyka.** Grilluj około **6–8 minut**, aż temperatura wewnątrz mięsa osiągnie **74°C**.', null::text, false),
         (4::smallint, '**Odpoczynek indyka.** Zdejmij indyka z grillownicy i pozostaw na około **3–5 minut** przed krojeniem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Grillowanie halloumi i pieczywa', 5 from przepisy p where lower(p.nazwa) = lower('Grillowany indyk z halloumi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Grillowanie halloumi.** Plastry halloumi połóż na rozgrzanej grillownicy i grilluj przy zamkniętej pokrywie przez około **2–3 minuty**, aż lekko się zarumienią.', null::text, false),
         (2::smallint, '**Opiekanie pieczywa.** Zdejmij halloumi i połóż na grillownicy chleb. Grilluj około **1–2 minuty**, aż będzie lekko chrupiący.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Podanie', 2 from przepisy p where lower(p.nazwa) = lower('Grillowany indyk z halloumi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Warzywa.** Pomidora i rukolę skrop pozostałą oliwą oraz sokiem z cytryny.', null::text, false),
         (2::smallint, '**Podanie.** Indyka pokrój i podawaj z grillowanym halloumi, pomidorem, rukolą i pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany indyk z halloumi') and e.kolejnosc = 4;

-- -------------------------------------------------------------------------
--  Grillowany kurczak caprese
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grillowany kurczak caprese', 'Grillowana pierś z kurczaka z pomidorem, mozzarellą i świeżą bazylią, podawana z chrupiącym pieczywem żytnim.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 441, 1, 1,
  7, 13,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 2 dni. Mozzarellę i pomidora najlepiej dokładać przy podaniu.',
  false, 'eśli pierś jest sucha, następnym razem przekrój ją wzdłuż na dwa cieńsze płaty — dzięki temu będzie grillowała się krócej.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grillowany kurczak caprese'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grillowany kurczak caprese'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'w plastrach', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'świeże listki', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Bazylia świeża';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak caprese') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Grillowany kurczak caprese');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Pomidor.** Umyj pomidory i pokrój w cienkie plastry. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (2::smallint, '**Mozzarella.** Odsącz mozzarellę i pokrój w plastry.', null::text, false),
         (3::smallint, '**Bazylia.** Umyj i osusz bazylię, oderwij liście od łodyg.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i przekrój ząbki na pół; posłużą do natarcia pieczywa.', null::text, false),
         (5::smallint, '**Kurczak.** Rozkrój pierś wzdłuż na cieńsze płaty grubości około 1,5 cm. Osusz, natrzyj oliwą i oregano. Dopraw solą i pieprzem.', null::text, false),
         (6::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany kurczak caprese') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Grillowanie kurczaka', 10 from przepisy p where lower(p.nazwa) = lower('Grillowany kurczak caprese');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie grilla.** Rozgrzej grill kontaktowy zgodnie z instrukcją urządzenia, zwykle przez około **3 minuty**.', null::text, false),
         (2::smallint, '**Grillowanie kurczaka.** Połóż kurczaka na rozgrzanej grillownicy i grilluj przez około **6–7 minut**.', null::text, false),
         (3::smallint, '**Sprawdzenie kurczaka.** Kurczak jest gotowy, gdy temperatura w najgrubszym miejscu mięsa osiągnie około **74°C**.', null::text, false),
         (4::smallint, '**Pomidor i mozzarella.** Zdejmij gorącego kurczaka z grillownicy. Na każdym kawałku ułóż plastry pomidora i mozzarelli.', null::text, false),
         (5::smallint, '**Zmiękczenie sera.** Przykryj luźno na około **2 minuty**, aby mozzarella lekko zmiękła.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany kurczak caprese') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Pieczywo i podanie', 3 from przepisy p where lower(p.nazwa) = lower('Grillowany kurczak caprese');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Opiekanie pieczywa.** Chleb grilluj przez około **1–2 minuty**, aż będzie lekko chrupiący.', null::text, false),
         (2::smallint, '**Czosnek na pieczywo.** Po zdjęciu z grillownicy natrzyj pieczywo przekrojonym ząbkiem czosnku.', null::text, false),
         (3::smallint, '**Bazylia.** Kurczaka z pomidorem i mozzarellą posyp świeżymi listkami bazylii.', null::text, false),
         (4::smallint, '**Podanie.** Podawaj od razu z grillowanym pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany kurczak caprese') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Grillowany kurczak z ogórkiem kiszonym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grillowany kurczak z ogórkiem kiszonym', 'Grillowany kurczak z kremowym twarożkiem, ogórkiem kiszonym i czerwoną cebulą, podawany na chrupiącym pieczywie żytnim. Danie dobrze smakuje również na zimno.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kanapki']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 488, 1, 1,
  7, 13,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'W lodówce do 2 dni.',
  false, 'Jeśli pierś jest sucha, była grillowana zbyt długo. Jeśli ogórek jest zbyt słony, przepłucz go przed pokrojeniem.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'ogórki kiszone bio';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'w cienkich piórkach', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ogórek kiszony.** Odsącz ogórki kiszone i pokrój w plasterki.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (3::smallint, '**Koperek.** Umyj i osusz koperek, usuń grube łodygi i drobno posiekaj delikatne gałązki.', null::text, false),
         (4::smallint, '**Szczypiorek.** Umyj i osusz szczypiorek, następnie drobno posiekaj.', null::text, false),
         (5::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (6::smallint, '**Twarożek.** Rozgnieć twaróg i wymieszaj z jogurtem, czosnkiem oraz większością koperku i szczypiorku. Pozostałe zioła odłóż do podania.', null::text, false),
         (7::smallint, '**Kurczak.** Osusz pierś i wyrównaj grubość do około 1,5 cm. Natrzyj oliwą, słodką papryką i pieprzem.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Grillowanie kurczaka', 10 from przepisy p where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie grilla.** Rozgrzej grill kontaktowy zgodnie z instrukcją urządzenia, zwykle przez około **3 minuty**.', null::text, false),
         (2::smallint, '**Grillowanie kurczaka.** Grilluj kurczaka przez około **6–7 minut**, bez mocnego dociskania pokrywy.', null::text, false),
         (3::smallint, '**Sprawdzenie kurczaka.** Mięso jest gotowe, gdy temperatura w najgrubszym miejscu osiągnie około **74°C**.', null::text, false),
         (4::smallint, '**Odpoczynek i krojenie.** Zdejmij kurczaka z grillownicy i pozostaw na **3–5 minut**, a następnie pokrój w ukośne plastry.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Pieczywo i podanie', 3 from przepisy p where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Opiekanie pieczywa.** Kromki chleba grilluj przez około **1–2 minuty**, aż będą lekko chrupiące.', null::text, false),
         (2::smallint, '**Twarożek na pieczywo.** Pieczywo posmaruj przygotowanym twarożkiem.', null::text, false),
         (3::smallint, '**Nadzienie kanapek.** Ułóż kurczaka, ogórki kiszone i czerwoną cebulę.', null::text, false),
         (4::smallint, '**Zioła i podanie.** Posyp pozostałym koperkiem lub szczypiorkiem i podawaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grillowany kurczak z ogórkiem kiszonym') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Grochówka z indykiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Grochówka z indykiem', 'Treściwa grochówka z mięsem indyka, ziemniakami, warzywami korzeniowymi i majerankiem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Wywar z marchwi, korzenia pietruszki, korzenia selera i pora gotuje się w osobnym garnku równolegle z grochem; cały wywar i wszystkie warzywa trafiają do zupy.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 906, 1, 2,
  20, 44,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko', 'Termometr do mięsa', 'Garnek 2 l', 'Łyżka cedzakowa', 'Miska']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź w porcjach. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeśli groch pozostaje twardy, gotuj dalej i uzupełniaj wodę. Za gęstą zupę rozcieńcz gorącą wodą.'
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
select p.id, sk.id, 110, 'g'::jednostka_miary, 110,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 900, 'ml'::jednostka_miary, 900,
       'połowa do gotowania grochu, połowa do wywaru; cały wywar i wszystkie ugotowane warzywa trafiają do zupy', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'obrany korzeń, kostka około 7–8 mm; do wywaru', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki; do wywaru', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Grochówka z indykiem') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Całość przeznacz do wywaru.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż osobno do wywaru.', null::text, false),
         (5::smallint, '**Groch.** Odmierz i opłucz łuskany groch w połówkach. Całe ziarna wymagają dłuższego gotowania.', null::text, false),
         (6::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (7::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (8::smallint, '**Indyk.** Osusz indyka i pokrój w kostkę około 2 cm.', null::text, false),
         (9::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (10::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników i podziel ją na dwie równe części: do grochu i do wywaru.', null::text, false),
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz sól, pieprz, majeranek, liście laurowe i ziele angielskie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie grochu i wywaru', 23 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Wywar — drugi palnik.** W garnku 2 l umieść całą przygotowaną marchew, korzeń pietruszki i korzeń selera. Zalej połową odmierzonej wody. Przykryj i doprowadź do łagodnego wrzenia, orientacyjnie przez **4–5 minut**. Od zagotowania gotuj na małym ogniu przez **6 minut**. Nastaw minutnik; w tym czasie zajmij się grochem.', null::text, false),
         (2::smallint, '**Baza zupy — równolegle.** W garnku 3 l rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (3::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (4::smallint, '**Groch.** Do cebuli dodaj groch, drugą połowę wody, liście laurowe i ziele angielskie. Doprowadź do wrzenia przez około **3 minuty**. Gotuj pod uchyloną pokrywką na małym ogniu. Nastaw drugi minutnik na **15 minut** od zagotowania. Mieszaj co kilka minut, żeby groch nie przywarł; jeśli płyn mocno odparuje, dolej trochę gorącej wody.', null::text, false),
         (5::smallint, '**Por — po minutniku wywaru.** Po **6 minutach gotowania korzeni** dodaj por do wywaru. Gotuj jeszcze przez **4 minuty**.', null::text, false),
         (6::smallint, '**Kontrola warzyw.** Sprawdź kostkę marchewki i selera. Jeśli ma twardy, surowy środek, gotuj jeszcze po **2 minuty**, sprawdzając po każdej takiej próbie.', 'warzywa są lekko jędrne, ale bez twardego, surowego środka'::text, true),
         (7::smallint, '**Uzupełnienie wywaru.** Jeżeli podczas gotowania odparowała woda, uzupełnij jej ubytek gorącą wodą do początkowego poziomu, zanim wyjmiesz warzywa.', null::text, false),
         (8::smallint, '**Zachowanie warzyw i wywaru.** Wyjmij wszystkie warzywa łyżką cedzakową do miski i przykryj. Wywar zostaw w garnku pod przykryciem, poza palnikiem, do czasu dodania ziemniaków. Nie wylewaj wywaru ani płynu zebranego w misce.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Gotowanie ziemniaków i indyka', 21 from przepisy p where lower(p.nazwa) = lower('Grochówka z indykiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ziemniaki i wywar.** Po **15 minutach** gotowania grochu dodaj ziemniaki i cały wywar, bez warzyw z miski. Po ponownym zagotowaniu gotuj przez **6 minut**.', null::text, false),
         (2::smallint, '**Indyk.** Dodaj indyka. Po ponownym zagotowaniu gotuj na małym ogniu przez **6–7 minut**. Sprawdź temperaturę najgrubszego kawałka mięsa; jeśli jest niższa, gotuj jeszcze po **2 minuty**.', 'indyk osiągnął co najmniej 74°C'::text, true),
         (3::smallint, '**Kontrola grochu i ziemniaków.** Sprawdź miękkość grochu i ziemniaków. Jeżeli groch jest jeszcze twardy, dogotuj zupę po **3 minuty**, uzupełniając odparowany płyn gorącą wodą.', 'groch jest miękki, ziemniaki nie mają twardego środka'::text, true),
         (4::smallint, '**Warzywa z wywaru.** Dodaj wszystkie odłożone warzywa wraz z płynem, który zebrał się w misce. Doprowadź ponownie do łagodnego wrzenia i podgrzewaj przez **1 minutę**.', null::text, false),
         (5::smallint, '**Doprawienie i podanie.** Usuń liście laurowe i ziele angielskie. Dodaj majeranek, sól i pieprz. Wymieszaj i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Grochówka z indykiem') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Gulasz jagnięcy z ciecierzycą i pomidorami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz jagnięcy z ciecierzycą i pomidorami', 'Aromatyczny gulasz jagnięcy z ciecierzycą, pomidorami i korzennymi przyprawami, podany z bulgurem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz jagnięcy z ciecierzycą i pomidorami') and sk.nazwa = 'Olej rzepakowy rafinowany';
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
         (11::smallint, '**Olej.** Odmierz olej.', null::text, false),
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
         (1::smallint, '**Rozgrzanie oleju.** Rozgrzej olej przez **1 minutę**.', null::text, false),
         (2::smallint, '**Obsmażenie jagnięciny.** Obsmaż jagnięcinę partiami po **4–5 minut**, obracając; dla porcji bazowej przeznacz około **10 minut**.', null::text, false),
         (3::smallint, '**Zdjęcie mięsa.** Przełóż na talerz.', null::text, false),
         (4::smallint, '**Cebula.** W tym samym garnku smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
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
--  Gulasz wołowy z warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz wołowy z warzywami korzeniowymi', 'Długo duszony gulasz wołowy z ziemniakami, marchewką, pasternakiem i selerem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 749, 1, 2,
  20, 150,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź po ostudzeniu. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeśli mięso jest twarde, duś je dalej przed dodaniem większych kawałków warzyw. Gęstniejący i przywierający sos podlewaj niewielką ilością gorącej wody. Jeśli gotowy sos jest za rzadki, wyjmij miękkie mięso i warzywa, odparuj sos bez pokrywki i połącz składniki ponownie.'
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
       'kostka około 1,5 cm', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'jedna trzecia drobno posiekana do sosu; reszta w kostce około 1 cm', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'jedna trzecia drobno posiekana do sosu; reszta w kostce około 1 cm', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'jedna trzecia drobno posiekana do sosu; reszta w kostce około 1 cm', null, sk.rola, sk.mozna_dzielic, 5
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
select p.id, sk.id, 250, 'ml'::jednostka_miary, 250,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and sk.nazwa = 'ogórki kiszone bio';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 1,5 cm.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz warzywo. Jedną trzecią drobno posiekaj do bazy sosu, resztę pokrój w kostkę około 1 cm i odłóż osobno.', null::text, false),
         (3::smallint, '**Pasternak.** Umyj i obierz warzywo. Jedną trzecią drobno posiekaj do bazy sosu, resztę pokrój w kostkę około 1 cm i odłóż osobno.', null::text, false),
         (4::smallint, '**Seler.** Umyj i obierz warzywo. Jedną trzecią drobno posiekaj do bazy sosu, resztę pokrój w kostkę około 1 cm i odłóż osobno.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Wołowina.** Osusz wołowinę i pokrój w kostkę około 3 cm.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Płynna baza.** Odmierz passatę i wodę z listy składników.', null::text, false),
         (9::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól, pieprz, słodką paprykę, majeranek i liście laurowe.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Duszenie', 150 from przepisy p where lower(p.nazwa) = lower('Gulasz wołowy z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oleju.** Rozgrzej olej przez **1 minutę**.', null::text, false),
         (2::smallint, '**Obsmażenie wołowiny.** Obsmaż wołowinę partiami po **4–5 minut**, obracając; dla bazy przeznacz około **10 minut**.', null::text, false),
         (3::smallint, '**Zdjęcie mięsa.** Przełóż na talerz.', null::text, false),
         (4::smallint, '**Cebula.** W garnku po mięsie smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (5::smallint, '**Warzywa do sosu.** Dodaj drobno posiekane części marchwi, pasternaku i selera. Smaż przez **4 minuty**, mieszając.', null::text, false),
         (6::smallint, '**Papryka mielona.** Dodaj paprykę i mieszaj przez **20 sekund**.', null::text, false),
         (7::smallint, '**Baza sosu.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Dodaj passatę, mięso wraz z sokami z talerza i liść laurowy.', null::text, false),
         (8::smallint, '**Duszenie wołowiny.** Doprowadź do łagodnego wrzenia przez około **3 minuty**. Duś pod przykryciem przez **90 minut**. Sprawdzaj płyn co **20 minut**. Dolewaj niewielką ilość gorącej wody tylko wtedy, gdy sos nadmiernie gęstnieje lub zaczyna przywierać; nie uzupełniaj automatycznie każdego ubytku.', null::text, false),
         (9::smallint, '**Kontrola wołowiny.** Sprawdź mięso przed dodaniem pozostałych warzyw. Jeżeli jest nadal twarde, duś dalej po **15 minut**, kontrolując płyn.', 'mięso jest prawie miękkie przed dodaniem pozostałych warzyw'::text, true),
         (10::smallint, '**Ziemniaki i pozostałe warzywa.** Dodaj ziemniaki oraz odłożone kostki marchwi, pasternaku i selera. Wymieszaj z sosem, przykryj i duś przez **20–25 minut**. Delikatnie przemieszaj w połowie. Jeśli warzywa są nadal twarde, dogotowuj po **3 minuty**.', 'mięso łatwo rozdziela się widelcem, ziemniaki i warzywa nie mają twardego środka'::text, true),
         (11::smallint, '**Doprawienie i podanie.** Usuń liść laurowy, dodaj majeranek, sól i pieprz. Wymieszaj i podaj z kiszonym ogórkiem.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', 'chleb wieloziarnisty', sk.rola, sk.mozna_dzielic, 9
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
         (2::smallint, '**Warzywna baza.** Dodaj cebulę, marchew, korzeń pietruszki i seler korzeniowy. Smaż przez **5–6 minut**, mieszając, aż cebula zmięknie i się zeszkli.', null::text, false),
         (3::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, tymianek i paprykę wędzoną; smaż **30 sekund**.', null::text, false),
         (4::smallint, '**Baza sosu.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Dodaj pomidory i doprowadź do łagodnego wrzenia przez około **2 minuty**.', null::text, false),
         (5::smallint, '**Gotowanie warzyw.** Gotuj pod przykryciem przez **15 minut**, mieszając kilka razy. Sprawdź marchew, pietruszkę i seler. Jeśli mają twardy środek, dogotowuj po **3 minuty** przed dodaniem fasoli. Dolej trochę gorącej wody, gdy sos nadmiernie gęstnieje.', 'warzywa korzeniowe są miękkie przed dodaniem fasoli'::text, true),
         (6::smallint, '**Fasola.** Dodaj fasolę i gotuj **5 minut**.', null::text, false),
         (7::smallint, '**Jarmuż.** Dodaj jarmuż i gotuj jeszcze **5 minut**.', 'liście jarmużu są miękkie, marchew bez twardego środka'::text, true),
         (8::smallint, '**Doprawienie i podanie.** Dopraw solą i pieprzem, podaj z przygotowanym pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z białej fasoli, jarmużu i pomidorów') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Gulasz z kaszą gryczaną
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Gulasz z kaszą gryczaną', 'Gulasz wieprzowy z wyraźnym smakiem zrumienionego mięsa i cebuli, niewielkim dodatkiem passaty oraz jędrną marchewką i papryką. Podawany z kaszą gryczaną i kapustą kiszoną.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 671, 1, 1,
  15, 110,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 4 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Kaszę najlepiej przechowywać osobno.',
  true, 'Jeśli mięso jest twarde, przed dodaniem warzyw duś je dalej po 10 minut. Jeśli sos nadmiernie gęstnieje, dolewaj po trochu gorącej wody. Zbyt rzadki sos odparuj przed dodaniem marchewki i papryki. Jeżeli rozrzedzi się po ich dodaniu, wyjmij gotowe mięso i warzywa, zredukuj sam sos i ponownie połącz składniki.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz z kaszą gryczaną'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Gulasz z kaszą gryczaną'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'w kostce 3 cm', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Gulasz wieprzowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'półplasterki grubości 4–5 mm; dodawana pod koniec duszenia', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'kawałki około 2 cm; dodawana po marchewce', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 46, 'ml'::jednostka_miary, 46,
       'niewielki dodatek do sosu', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'sucha, ugotowana osobno', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Kasza gryczana, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'odciśnięta i jest surówką', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Kapusta kiszona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 62, 'ml'::jednostka_miary, 62,
       'ilość początkowa do duszenia; dodatkową gorącą wodę dolewaj małymi porcjami tylko wtedy, gdy sos nadmiernie gęstnieje', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w półplasterki grubości **4–5 mm**. Odłóż do dodania pod koniec duszenia.', null::text, false),
         (4::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój na kawałki około **2 cm**. Odłóż osobno od marchewki.', null::text, false),
         (5::smallint, '**Kapusta kiszona.** Odciśnij kapustę kiszoną i odłóż do podania jako surówkę.', null::text, false),
         (6::smallint, '**Wieprzowina.** Osusz wieprzowinę i pokrój w kostkę około 3 cm.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Kasza gryczana.** Odmierz kaszę gryczaną.', null::text, false),
         (9::smallint, '**Płynna baza.** Odmierz passatę i wodę z listy składników.', null::text, false),
         (10::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (11::smallint, '**Przyprawy.** Odmierz sól, pieprz, słodką paprykę, liście laurowe i ziele angielskie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Obsmażanie mięsa i przygotowanie sosu', 15 from przepisy p where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oleju.** Rozgrzej olej w garnku przez około **1 minutę** na średnio dużym ogniu. Przy smażeniu partiami podziel odmierzony tłuszcz między partie.', null::text, false),
         (2::smallint, '**Obsmażenie mięsa.** Ułóż osuszone mięso w jednej warstwie. Obsmażaj przez **4–5 minut na partię**, obracając dopiero po zrumienieniu powierzchni. Przy większej ilości dolicz czas kolejnych partii.', 'mięso ma wyraźnie zrumienioną powierzchnię, a na dnie nie stoi woda'::text, true),
         (3::smallint, '**Zdjęcie mięsa.** Przełóż obsmażone mięso na talerz. Zachowaj soki, które z niego wypłyną.', null::text, false),
         (4::smallint, '**Cebula.** Zmniejsz ogień do średniego. Dodaj cebulę i smaż **3–4 minuty**, mieszając, aż się zeszkli. Jeśli przywiera, dodaj odrobinę odmierzonej wody.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (5::smallint, '**Czosnek i przyprawy.** Dodaj czosnek oraz słodką paprykę mieloną. Smaż przez **20–30 sekund**, stale mieszając; nie przypal przypraw.', null::text, false),
         (6::smallint, '**Baza sosu.** Wlej passatę i pozostałą odmierzoną wodę. Zeskrob łopatką zrumieniony osad z dna. Włóż mięso wraz z sokami, dodaj liść laurowy i ziele angielskie.', null::text, false),
         (7::smallint, '**Zagotowanie.** Doprowadź do łagodnego wrzenia przez około **2–3 minuty**, następnie zmniejsz ogień.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Duszenie mięsa, dodanie warzyw i podanie', 95 from przepisy p where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Duszenie mięsa.** Przykryj garnek i duś łagodnie przez **60–75 minut**. Mięso powinno być niemal miękkie przed dodaniem warzyw. Jeśli nadal jest twarde, wydłużaj ten etap po **10 minut**.', 'widelec wchodzi w mięso z niewielkim oporem; marchew i papryka nadal czekają osobno'::text, true),
         (2::smallint, '**Kontrola płynu.** Podczas duszenia sprawdzaj sos co **15–20 minut**. Jeśli nadmiernie zgęstnieje lub zaczyna przywierać, dolej trochę gorącej wody. Nie uzupełniaj płynu automatycznie do początkowego poziomu.', null::text, false),
         (3::smallint, '**Kasza — równolegle.** Gdy mięso jest niemal miękkie, nastaw na drugim palniku odmierzoną kaszę gryczaną. Gotuj zgodnie z instrukcją na opakowaniu, równolegle z kończeniem gulaszu. Nastaw minutnik; po ugotowaniu odcedź i przykryj.', null::text, false),
         (4::smallint, '**Sos przed warzywami.** Jeżeli sos jest wodnisty, odkryj garnek i odparowuj go, mieszając oraz sprawdzając co **3–5 minut**. Gotowe mięso możesz na ten czas wyjąć i włożyć z powrotem po zagęszczeniu.', 'sos oblepia mięso, pozostaje wilgotny i nie tworzy wokół niego wodnistej kałuży'::text, true),
         (5::smallint, '**Marchew.** Dodaj marchew, wymieszaj i duś łagodnie pod przykryciem przez **5 minut**.', null::text, false),
         (6::smallint, '**Papryka.** Dodaj paprykę i duś pod przykryciem przez kolejne **10–13 minut**. Marchew dusi się łącznie **15–18 minut**, a papryka **10–13 minut**.', null::text, false),
         (7::smallint, '**Sprawdzenie warzyw.** Sprawdź warzywa po **10 minutach od dodania papryki**. Zakończ duszenie, gdy mają lekki opór przy gryzieniu. Jeśli są zbyt twarde, dogotowuj po **2 minuty**; nie czekaj, aż zaczną się rozpadać.', 'mięso jest miękkie, marchew i papryka zachowują kształt oraz lekką jędrność'::text, true),
         (8::smallint, '**Doprawienie.** Usuń liść laurowy i ziele angielskie. Dopraw odmierzoną solą i pieprzem.', null::text, false),
         (9::smallint, '**Podanie.** Rozdziel gulasz, ugotowaną kaszę i kapustę kiszoną na przygotowywaną liczbę porcji. Kapustę podaj jako surówkę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Gulasz z kaszą gryczaną') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Indyk w sosie orzechowym (satay)
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Indyk w sosie orzechowym (satay)', 'Indyk z chrupiącymi warzywami w kremowym sosie z masła orzechowego, mleka kokosowego, imbiru i sosu sojowego, podawany z ryżem basmati.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 534, 1, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Ryż przechowuj osobno. Sos po schłodzeniu zgęstnieje — podczas odgrzewania dolej niewielką ilość wody.',
  false, 'Jeśli sos się rozwarstwi, zdejmij patelnię z ognia i energicznie wmieszaj niewielką ilość ciepłej wody. Jeśli jest zbyt gęsty, również rozcieńcz go niewielką ilością wody. Jeśli danie jest zbyt mdłe, dodaj trochę soku z cytryny.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Indyk w sosie orzechowym (satay)'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Indyk w sosie orzechowym (satay)'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Filet z indyka, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Masło orzechowe bez cukru';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'ml'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'obrany, starty', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 12, 'g'::jednostka_miary, 12,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 55, 'g'::jednostka_miary, 55,
       'suchy, ugotowany osobno', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and sk.nazwa = 'Papryka ostra mielona';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w cienkie półplasterki.', null::text, false),
         (2::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w cienkie paski.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (7::smallint, '**Indyk.** Osusz indyka i pokrój w kostkę około 2 cm.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Płynna baza.** Odmierz mleko kokosowe.', null::text, false),
         (10::smallint, '**Dodatki.** Odmierz masło orzechowe i sos sojowy.', null::text, false),
         (11::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (12::smallint, '**Przyprawy.** Odmierz ostrą paprykę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Ryż, sos i obsmażenie indyka', 10 from przepisy p where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Ryż zacznij gotować zgodnie z instrukcją na opakowaniu. Będzie gotował się równolegle z przygotowaniem pozostałej części dania.', null::text, false),
         (2::smallint, '**Sos orzechowy.** W miseczce dokładnie wymieszaj masło orzechowe, mleko kokosowe i sos sojowy.', null::text, false),
         (3::smallint, '**Rozgrzanie oleju.** Na patelni rozgrzej olej.', null::text, false),
         (4::smallint, '**Obsmażenie indyka.** Dodaj indyka i smaż na dość dużym ogniu przez około **2–3 minuty**, tylko do lekkiego zarumienienia z zewnątrz. Mięso nie musi być jeszcze całkowicie usmażone — dojdzie później w sosie.', null::text, false),
         (5::smallint, '**Zdjęcie indyka.** Zdejmij mięso z patelni i odłóż na bok.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Warzywa, sos i wykończenie', 10 from przepisy p where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Czosnek i imbir.** Zmniejsz ogień do średniego. Na tę samą patelnię dodaj czosnek i imbir. Smaż około **30 sekund**.', null::text, false),
         (2::smallint, '**Marchew i papryka.** Dodaj marchew i paprykę. Smaż około **3–4 minuty**, aby warzywa lekko zmiękły, ale pozostały jędrne.', null::text, false),
         (3::smallint, '**Sos na patelnię.** Zmniejsz ogień. Wlej przygotowany sos orzechowo-kokosowy i dokładnie wymieszaj. Jeśli sos jest zbyt gęsty, dodaj niewielką ilość ciepłej wody.', null::text, false),
         (4::smallint, '**Duszenie indyka.** Włóż indyka z powrotem na patelnię. Duś na małym ogniu przez około **4–5 minut**, aż mięso będzie całkowicie gotowe, a sos zgęstnieje.', null::text, false),
         (5::smallint, '**Doprawienie.** Zdejmij patelnię z ognia. Dodaj sok z cytryny i ostrą paprykę. Wymieszaj.', null::text, false),
         (6::smallint, '**Podanie.** Indyka w sosie orzechowym podawaj z ugotowanym ryżem basmati.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Indyk w sosie orzechowym (satay)') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Jajecznica ze szpinakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajecznica ze szpinakiem', 'Delikatna jajecznica ze szpinakiem — szybka, sycąca i lekka. Szpinak dodaje świeżości i dobrze równoważy kremowe jajka.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 498, 1, 1,
  3, 7,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej jedz od razu. Odgrzewana jajecznica robi się gumowata. Jeśli musisz ją przechować, trzymaj w szczelnym pojemniku w lodówce maksymalnie 1 dzień.',
  false, 'Wyszła wodnista — to znak, że szpinak nie odparował. Odlej płyn i dosmaż na większym ogniu.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajecznica ze szpinakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajecznica ze szpinakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Szpinak mrożony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 9, 'g'::jednostka_miary, 9,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 3 from przepisy p where lower(p.nazwa) = lower('Jajecznica ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Pomidor.** Umyj pomidory i pokrój w cząstki.', null::text, false),
         (2::smallint, '**Szczypiorek.** Umyj i osusz szczypiorek, następnie drobno posiekaj.', null::text, false),
         (3::smallint, '**Jajka.** Wbij jajka do miski i roztrzep widelcem.', null::text, false),
         (4::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false),
         (5::smallint, '**Szpinak.** Odmierz mrożony szpinak i pozostaw w zamrażarce do smażenia.', null::text, false),
         (6::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (7::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie szpinaku', 3 from przepisy p where lower(p.nazwa) = lower('Jajecznica ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Na patelni rozgrzej oliwę.', null::text, false),
         (2::smallint, '**Rozmrożenie szpinaku.** Dodaj mrożony szpinak bez wcześniejszego rozmrażania i smaż przez około **2–3 minuty**, aż się rozmrozi i odparuje z niego nadmiar wody.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Smażenie jajecznicy i podanie', 4 from przepisy p where lower(p.nazwa) = lower('Jajecznica ze szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Smażenie jajek.** Zmniejsz ogień. Wlej jajka i smaż na małym ogniu przez około **2–3 minuty**, delikatnie mieszając, aż się zetną, ale pozostaną wilgotne. Dopraw solą i pieprzem.', null::text, false),
         (2::smallint, '**Szczypiorek.** Zdejmij patelnię z ognia i posyp jajecznicę szczypiorkiem.', null::text, false),
         (3::smallint, '**Podanie.** Podawaj od razu z pomidorem i pieczywem żytnim.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajecznica ze szpinakiem') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Jajka w koszulkach z pastą twarogową
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Jajka w koszulkach z pastą twarogową', 'Jajka w koszulkach z kremową pastą twarogową — delikatne, sycące śniadanie z miękkim żółtkiem i świeżym, lekko wytrawnym smakiem.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 448, 1, 1,
  7, 13,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Miska', 'Sitko', 'Łyżka cedzakowa', 'Patelnia 24 cm']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Pasta twarogowa w lodówce do 2 dni. Jajka rób na świeżo.',
  false, 'Białko się rozeszło po wodzie — jajko było za stare albo woda za mocno wrzała. Ma ledwo drgać, nie bulgotać.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajka w koszulkach z pastą twarogową'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Jajka w koszulkach z pastą twarogową'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Twaróg półtłusty';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'ml'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Mleko 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Ocet jabłkowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Koperek.** Umyj i osusz koperek, usuń grube łodygi i drobno posiekaj delikatne gałązki.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (3::smallint, '**Jajka.** Wybij jajka pojedynczo do osobnych miseczek lub filiżanek.', null::text, false),
         (4::smallint, '**Nabiał.** Odmierz twaróg i mleko.', null::text, false),
         (5::smallint, '**Dodatki.** Odmierz ocet jabłkowy.', null::text, false),
         (6::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (7::smallint, '**Przyprawy.** Odmierz sól i słodką paprykę.', null::text, false),
         (8::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pasta twarogowa i pieczywo', 6 from przepisy p where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Pasta twarogowa.** Twaróg rozgnieć widelcem. Dodaj mleko i czosnek, a następnie dokładnie wymieszaj na kremową pastę. Dopraw niewielką ilością soli.', null::text, false),
         (2::smallint, '**Oliwa z papryką.** Oliwę wymieszaj ze słodką papryką i odstaw.', null::text, false),
         (3::smallint, '**Opiekanie pieczywa.** Opiekaj chleb na suchej patelni przez około **1–2 minuty** z każdej strony, aż będzie lekko chrupiący.', null::text, false),
         (4::smallint, '**Pasta na pieczywo.** Podpieczone kromki posmaruj przygotowaną pastą twarogową.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Jajka w koszulkach i podanie', 7 from przepisy p where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Woda z octem.** W garnku zagotuj wodę. Dodaj odmierzony ocet jabłkowy, następnie zmniejsz ogień — woda powinna jedynie delikatnie drgać, a nie intensywnie wrzeć.', null::text, false),
         (2::smallint, '**Gotowanie jajek.** Wprowadzaj jajka pojedynczo do wody i gotuj około **3 minut**, aby białko się ścięło, a żółtko pozostało płynne.', null::text, false),
         (3::smallint, '**Odcedzenie jajek.** Jajka wyjmij łyżką cedzakową i pozostaw na chwilę do odsączenia z nadmiaru wody.', null::text, false),
         (4::smallint, '**Jajka na pieczywo.** Jajka ułóż na pieczywie z pastą twarogową.', null::text, false),
         (5::smallint, '**Doprawienie i podanie.** Polej oliwą ze słodką papryką, posyp koperkiem i podawaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Jajka w koszulkach z pastą twarogową') and e.kolejnosc = 3;

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
  5, 2,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Pomidor.** Umyj pomidory i pokrój w cienkie plastry. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (2::smallint, '**Bazylia.** Umyj i osusz bazylię, oderwij liście od łodyg.', null::text, false),
         (3::smallint, '**Mozzarella.** Odsącz mozzarellę i pokrój w plastry.', null::text, false),
         (4::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (5::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false),
         (6::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 2 from przepisy p where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Składanie kanapek.** Na pieczywie ułóż mozzarellę, pomidora i bazylię. Skrop odmierzoną oliwą, dopraw solą i pieprzem, podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z mozzarellą, pomidorem i bazylią') and e.kolejnosc = 2;

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
  6, 4,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Sardynki.** Odsącz sardynki i odmierz po odsączeniu.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w cienkie plastry. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (3::smallint, '**Rukola.** Umyj rukolę i dokładnie osusz.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (6::smallint, '**Pieprz.** Odmierz pieprz.', null::text, false),
         (7::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Składanie kanapek', 4 from przepisy p where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Pasta z sardynek.** Rozgnieć sardynki widelcem z odmierzoną oliwą, sokiem z cytryny i pieprzem.', null::text, false),
         (2::smallint, '**Składanie kanapek.** Na pieczywie ułóż rukolę, pastę oraz pomidora. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kanapki z sardynkami, pomidorem i rukolą') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w cienkie paski.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (7::smallint, '**Kałamarnica.** Oczyszczoną i rozmrożoną kałamarnicę osusz, następnie pokrój w krążki grubości około 1 cm.', null::text, false),
         (8::smallint, '**Po przygotowaniu kałamarnicy.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowymi owocami morza.', null::text, false),
         (9::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (10::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (11::smallint, '**Przyprawy.** Odmierz sól i wędzoną paprykę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i sosu', 25 from przepisy p where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp ryż i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Ryż — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na drugim palniku rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (4::smallint, '**Cebula i papryka.** Dodaj cebulę i paprykę, smaż **5–6 minut**.', null::text, false),
         (5::smallint, '**Czosnek i przyprawy.** Dodaj czosnek oraz wędzoną paprykę i smaż **30 sekund**.', null::text, false),
         (6::smallint, '**Sos pomidorowy.** Wlej passatę, zagotuj przez około **2 minuty** i gotuj łagodnie jeszcze **5 minut**. Zakończ gotowanie ryżu przed dodaniem kałamarnicy.', null::text, false),
         (7::smallint, '**Gotowanie kałamarnicy.** Do gorącego sosu dodaj krążki kałamarnicy i gotuj **2–3 minuty**, delikatnie mieszając.', 'krążki są nieprzezroczyste i jędrne, ale nie gumowate'::text, true),
         (8::smallint, '**Doprawienie i podanie.** Zdejmij z ognia, dodaj przygotowany sok z cytryny, sól i natkę. Podaj od razu z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kałamarnica z papryką i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Klopsiki w sosie pomidorowym – tradycyjne
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Klopsiki w sosie pomidorowym – tradycyjne', 'Klopsiki wołowo-wieprzowe duszone w aromatycznym sosie pomidorowym z oregano, podawane z ziemniakami i świeżą natką pietruszki.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
  3, 'prywatna',
  'waga', 772, 1, 1,
  8, 37,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tłuczek do ziemniaków', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'W lodówce do 3 dni. Świetnie się mrożą — porcję na trzeci dzień odłóż od razu do zamrażarki.',
  true, 'Klopsiki się rozpadają — za mało bułki tartej albo za mokre mięso. Sos za kwaśny — szczypta słodkiej papryki i pogotuj.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Mięso mielone wołowo-wieprzowe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Bułka tarta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'ml'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'obrane', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj lub zetrzyj. Podziel na połowę: do klopsików i do sosu.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (4::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój na mniejsze kawałki. Przy przygotowywaniu posiłków na kilka dni ziemniaki gotuj świeże do każdego posiłku.', null::text, false),
         (5::smallint, '**Mięso i jajka.** Odmierz mięso mielone. Wbij jajka do miseczki i lekko roztrzep. Po kontakcie z surowym mięsem umyj ręce i przybory.', null::text, false),
         (6::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (7::smallint, '**Dodatki.** Odmierz bułkę tartą.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól, pieprz, oregano i majeranek.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie i obsmażenie klopsików', 12 from przepisy p where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Masa na klopsiki.** Mięso wymieszaj z jajkiem, bułką tartą, połową cebuli i majerankiem. Dopraw częścią soli i pieprzu.', null::text, false),
         (2::smallint, '**Formowanie klopsików.** Uformuj niewielkie klopsiki.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na patelni rozgrzej oliwę.', null::text, false),
         (4::smallint, '**Obsmażenie klopsików.** Obsmaż klopsiki przez **5–6 minut**, ostrożnie obracając, aż zrumienią się ze wszystkich stron. Przełóż na talerz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Duszenie w sosie', 20 from przepisy p where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Na tej samej patelni dodaj pozostałą cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (2::smallint, '**Baza sosu.** Dodaj czosnek, passatę i oregano.', null::text, false),
         (3::smallint, '**Klopsiki do sosu.** Włóż klopsiki do sosu.', null::text, false),
         (4::smallint, '**Duszenie klopsików.** Przykryj i duś na małym ogniu przez około **20 minut**. Jeśli sos robi się zbyt gęsty, dolej niewielką ilość wody.', null::text, false),
         (5::smallint, '**Ziemniaki — równolegle.** W czasie duszenia klopsików ugotuj ziemniaki w lekko osolonej wodzie przez około **15–20 minut**. Odcedź i utłucz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Wykończenie i podanie', 5 from przepisy p where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Doprawienie sosu.** Dopraw sos pozostałą solą i pieprzem.', null::text, false),
         (2::smallint, '**Podanie.** Klopsiki podawaj z puree ziemniaczanym i posiekaną natką pietruszki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki w sosie pomidorowym – tradycyjne') and e.kolejnosc = 4;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Cebula.** Obierz i drobno posiekaj cebulę. Połowę odłóż do klopsików, połowę do sosu.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Jajka.** Wbij jajka do miski i roztrzep widelcem.', null::text, false),
         (4::smallint, '**Masa na klopsiki.** Połącz mięso z roztrzepanymi jajkami, bułką tartą, połową cebuli oraz częścią soli i pieprzu. Odstaw na **5 minut**, aby bułka wchłonęła wilgoć.', null::text, false),
         (5::smallint, '**Formowanie klopsików.** Wilgotnymi dłońmi uformuj klopsiki o średnicy około 3 cm.', null::text, false),
         (6::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (7::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (8::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz słodką paprykę i oregano.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kaszy i duszenie klopsików', 32 from przepisy p where lower(p.nazwa) = lower('Klopsiki z indyka w sosie pomidorowym z bulgurem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Bulgur — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp kaszę bulgur i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Bulgur — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na drugim palniku rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (4::smallint, '**Obsmażenie klopsików.** Obsmaż klopsiki przez **5–6 minut**, ostrożnie obracając.', null::text, false),
         (5::smallint, '**Zdjęcie klopsików.** Przełóż na talerz.', null::text, false),
         (6::smallint, '**Cebula.** Na tej samej patelni smaż pozostałą cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (7::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, oregano i paprykę; smaż **30 sekund**.', null::text, false),
         (8::smallint, '**Passata.** Dodaj passatę i doprowadź do łagodnego wrzenia przez około **2 minuty**.', null::text, false),
         (9::smallint, '**Duszenie klopsików.** Włóż klopsiki i duś pod przykryciem przez **15 minut** na małym ogniu. Obróć je w połowie; w razie gęstnienia sosu dodaj trochę gorącej wody.', 'temperatura w środku największego klopsika wynosi co najmniej 74°C'::text, true),
         (10::smallint, '**Doprawienie i podanie.** Dopraw sos pozostałą solą i pieprzem. Podaj z odcedzoną kaszą.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Cukinia.** Umyj cukinię i pokrój na kawałki około 2 cm.', null::text, false),
         (2::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój na kawałki około 2 cm.', null::text, false),
         (3::smallint, '**Pomidory.** Umyj pomidory i pokrój w ćwiartki.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (5::smallint, '**Komosa.** Odmierz komosę i dokładnie opłucz na sitku.', null::text, false),
         (6::smallint, '**Ciecierzyca.** Opłucz, odsącz i dokładnie osusz ciecierzycę. Odmierz po odsączeniu.', null::text, false),
         (7::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (8::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (9::smallint, '**Doprawienie do pieczenia.** Wymieszaj warzywa i ciecierzycę z odmierzoną oliwą, oregano, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 42 from przepisy p where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **210°C**, grzanie góra–dół; zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie warzyw.** Rozłóż warzywa i ciecierzycę luźno na blasze. Piecz **25–30 minut**, obracając w połowie.', null::text, false),
         (3::smallint, '**Komosa — równolegle.** Podczas pieczenia ugotuj komosę przez czas z opakowania w dodatkowej wodzie. Odcedź i odstaw pod przykryciem na **5 minut**.', null::text, false),
         (4::smallint, '**Połączenie i podanie.** Połącz komosę, upieczone warzywa i ciecierzycę. Dodaj sok z cytryny oraz natkę.', 'warzywa są miękkie i zarumienione, ziarna komosy miękkie'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kotleciki z czerwonej soczewicy z sosem jogurtowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kotleciki z czerwonej soczewicy z sosem jogurtowym', 'Rumiane kotleciki z czerwonej soczewicy i płatków owsianych, podane z ogórkowym sosem jogurtowym. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Soczewica.** Odmierz soczewicę i opłucz na sitku.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz marchew, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Ogórek.** Umyj ogórek, zetrzyj i odciśnij nadmiar soku.', null::text, false),
         (6::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (7::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (8::smallint, '**Płatki owsiane.** Odmierz płatki owsiane.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól, pieprz, słodką paprykę i kmin rzymski.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie soczewicy i przygotowanie masy', 42 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie soczewicy.** Zagotuj wodę, co zwykle trwa około **5 minut**, i gotuj soczewicę **12–15 minut**, do miękkości.', null::text, false),
         (2::smallint, '**Odcedzenie soczewicy.** Dokładnie odcedź na sitku i odstaw na **10 minut** do odparowania.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy — równolegle.** Równolegle rozgrzej połowę oliwy na patelni przez **1 minutę**.', null::text, false),
         (4::smallint, '**Cebula i marchew.** Smaż cebulę i marchew **5 minut**.', null::text, false),
         (5::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, kmin i paprykę; smaż jeszcze **30 sekund**.', null::text, false),
         (6::smallint, '**Masa na kotleciki.** Rozgnieć soczewicę widelcem. Dodaj podsmażone warzywa, płatki oraz część soli i pieprzu. Wymieszaj i odstaw na **10 minut**, żeby płatki wchłonęły wilgoć.', null::text, false),
         (7::smallint, '**Sos jogurtowy.** W tym czasie wymieszaj jogurt z ogórkiem, sokiem z cytryny i pozostałą solą oraz pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Formowanie i smażenie', 15 from przepisy p where lower(p.nazwa) = lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Formowanie kotlecików.** Uformuj kotleciki grubości około 1,5 cm.', null::text, false),
         (2::smallint, '**Rozgrzanie oliwy.** Rozgrzej pozostałą oliwę na patelni nieprzywierającej przez **1 minutę**.', null::text, false),
         (3::smallint, '**Smażenie kotlecików.** Smaż po **4–5 minut** z każdej strony na średnim ogniu. Obracaj dopiero po zrumienieniu spodu. Przy większej ilości smaż partiami, doliczając czas kolejnej partii.', 'kotleciki utrzymują kształt i mają rumianą powierzchnię'::text, true),
         (4::smallint, '**Podanie.** Podaj z sosem jogurtowym.', null::text, false)
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
  'Krem z brokułów z fetą', 'Kremowa zupa brokułowa z ziemniakiem, jogurtem i fetą, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Marchew, korzeń pietruszki, korzeń selera i por gotują się razem z zupą w jednym garnku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 871, 1, 2,
  20, 35,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Jeśli planujesz mrożenie, odłóż porcję przed dodaniem jogurtu i fety; dodaj je dopiero po rozmrożeniu i podgrzaniu. Pieczywo trzymaj osobno. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Za gęsty krem rozcieńcz gorącą wodą. Jeśli feta mocno zasoliła zupę, dodaj więcej brokułu lub ziemniaka.'
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
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Jogurt naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'pokruszony', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Gałka muszkatołowa mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'cała odmierzona ilość do zupy', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z brokułów z fetą') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Krem z brokułów z fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż do zupy.', null::text, false),
         (5::smallint, '**Brokuł.** Umyj brokuł i podziel na małe różyczki. Obierz miękki środek łodygi i pokrój go drobno.', null::text, false),
         (6::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 1 cm.', null::text, false),
         (7::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (8::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (9::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (10::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników.', null::text, false),
         (11::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (12::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (13::smallint, '**Przyprawy.** Odmierz pieprz i gałkę muszkatołową.', null::text, false),
         (14::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z brokułów z fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie zupy i blendowanie', 35 from przepisy p where lower(p.nazwa) = lower('Krem z brokułów z fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Baza zupy.** W garnku rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Czosnek.** Dodaj czosnek i smaż przez **30 sekund**.', null::text, false),
         (4::smallint, '**Warzywa korzeniowe i ziemniaki.** Dodaj marchew, korzeń pietruszki, korzeń selera, por, ziemniaki, pokrojoną łodygę brokułu i całą odmierzoną wodę. Doprowadź do wrzenia przez około **5 minut** i gotuj pod przykryciem przez **10 minut**.', null::text, false),
         (5::smallint, '**Różyczki brokułu.** Dodaj różyczki. Po ponownym zagotowaniu gotuj przez **6–8 minut**.', null::text, false),
         (6::smallint, '**Kontrola miękkości.** Sprawdź ziemniaki, brokuł i warzywa korzeniowe. Jeżeli są twarde, dogotowuj po **2 minuty** przed blendowaniem.', 'warzywa łatwo rozgniatają się widelcem'::text, true),
         (7::smallint, '**Blendowanie.** Zdejmij garnek z ognia. Zblenduj zupę, trzymając końcówkę blendera zanurzoną. Dodaj gałkę muszkatołową i pieprz. Część przeznaczoną do mrożenia odłóż teraz, przed dodaniem jogurtu i fety.', null::text, false),
         (8::smallint, '**Jogurt.** Wymieszaj jogurt z niewielką ilością ciepłej zupy, następnie wmieszaj do garnka poza ogniem. Nie zagotowuj ponownie.', 'krem jest gładki, bez grudek jogurtu'::text, true),
         (9::smallint, '**Podanie.** Podaj z fetą i pieczywem.', null::text, false)
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
  'Krem z dyni na mleku kokosowym', 'Aromatyczny krem z dyni, czerwonej soczewicy, imbiru i mleka kokosowego. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Marchew, korzeń pietruszki, korzeń selera i por gotują się razem z zupą w jednym garnku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 857, 1, 2,
  20, 36,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Blender ręczny', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Sitko']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni albo zamroź po szybkim schłodzeniu. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Za gęsty krem rozcieńcz gorącą wodą. Za ostry złagodź dodatkowym mlekiem kokosowym.'
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
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'opłukana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Soczewica czerwona, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'cała odmierzona ilość do zupy', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'sok', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Limonka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'umyta, osuszona i posiekana; do posypania przed podaniem', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and sk.nazwa = 'Por, surowy';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż do zupy.', null::text, false),
         (5::smallint, '**Dynia.** Umyj dynię, usuń nasiona i twardą skórę. Pokrój miąższ w kostkę około 2 cm.', null::text, false),
         (6::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (7::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (8::smallint, '**Imbir.** Obierz imbir i drobno posiekaj.', null::text, false),
         (9::smallint, '**Soczewica.** Odmierz soczewicę i opłucz na sitku.', null::text, false),
         (10::smallint, '**Limonka.** Umyj limonkę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (11::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (12::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników.', null::text, false),
         (13::smallint, '**Mleko kokosowe.** Odmierz mleko kokosowe.', null::text, false),
         (14::smallint, '**Pasta curry.** Odmierz pastę curry.', null::text, false),
         (15::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (16::smallint, '**Sól.** Odmierz sól.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie zupy i blendowanie', 36 from przepisy p where lower(p.nazwa) = lower('Krem z dyni na mleku kokosowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Baza zupy.** W garnku rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Czosnek, imbir i curry.** Dodaj czosnek, imbir i pastę curry. Smaż przez **1 minutę**, mieszając.', null::text, false),
         (4::smallint, '**Warzywa, dynia i soczewica.** Dodaj marchew, korzeń pietruszki, korzeń selera, por, dynię, soczewicę i całą odmierzoną wodę. Doprowadź do wrzenia przez około **5 minut**. Gotuj pod uchyloną pokrywką przez **18 minut**, mieszając co kilka minut.', null::text, false),
         (5::smallint, '**Kontrola miękkości.** Sprawdź dynię, soczewicę i warzywa korzeniowe. W razie potrzeby dogotowuj po **3 minuty**, mieszając i uzupełniając odparowany płyn gorącą wodą.', 'warzywa łatwo rozgniatają się widelcem, soczewica jest miękka'::text, true),
         (6::smallint, '**Mleko kokosowe.** Dodaj mleko kokosowe i podgrzewaj przez **2 minuty**.', null::text, false),
         (7::smallint, '**Blendowanie.** Zdejmij garnek z ognia i zblenduj zupę, trzymając końcówkę blendera zanurzoną.', null::text, false),
         (8::smallint, '**Doprawienie.** Dodaj sok z limonki i sól, wymieszaj.', null::text, false),
         (9::smallint, '**Podanie.** Rozlej krem do talerzy, posyp przygotowaną natką pietruszki i podaj.', null::text, false)
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
  'Krem z kalafiora z pieczoną ciecierzycą', 'Krem z kalafiora i ziemniaka podany z pieczoną ciecierzycą oraz pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Marchew, korzeń pietruszki, korzeń selera i por gotują się razem z zupą w jednym garnku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 897, 1, 2,
  20, 32,
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
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 16, 'g'::jednostka_miary, 16,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'szt'::jednostka_miary, round((4 * sk.masa_sztuki_g)::numeric, 1),
       'kromki', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Papryka wędzona mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'cała odmierzona ilość do zupy', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Piekarnik.** Włącz piekarnik na 210°C, grzanie góra–dół. Rozgrzewanie zajmuje zwykle około 10 minut; w tym czasie przygotuj ciecierzycę i pozostałe składniki.', null::text, false),
         (2::smallint, '**Ciecierzyca.** Opłucz, odsącz i dokładnie osusz ciecierzycę. Wymieszaj z połową oliwy, kminem i wędzoną papryką.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (4::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (5::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (6::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż do zupy.', null::text, false),
         (7::smallint, '**Kalafior.** Umyj kalafior i podziel na podobnej wielkości różyczki, około 3 cm.', null::text, false),
         (8::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 1 cm.', null::text, false),
         (9::smallint, '**Ciecierzyca do piekarnika.** Gdy piekarnik osiągnie ustawioną temperaturę, rozłóż przygotowaną ciecierzycę na blasze. Piecz przez **25–30 minut**. Nastaw minutnik i przemieszaj w połowie pieczenia; pieczenie trwa dalej podczas gotowania zupy.', null::text, false),
         (10::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (11::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (12::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników.', null::text, false),
         (13::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false),
         (14::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie kremu i dokończenie pieczenia', 32 from przepisy p where lower(p.nazwa) = lower('Krem z kalafiora z pieczoną ciecierzycą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Baza zupy.** W garnku rozgrzej pozostałą oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Czosnek.** Dodaj czosnek i smaż przez **30 sekund**.', null::text, false),
         (4::smallint, '**Warzywa.** Dodaj marchew, korzeń pietruszki, korzeń selera, por, ziemniaki, kalafior i całą odmierzoną wodę. Doprowadź do wrzenia przez około **5 minut**. Gotuj pod przykryciem przez **15–18 minut**.', null::text, false),
         (5::smallint, '**Ciecierzyca — po minutniku.** Niezależnie od postępu gotowania zupy, wyjmij ciecierzycę po **25–30 minutach pieczenia**, gdy jest lekko zrumieniona i chrupiąca z zewnątrz.', null::text, false),
         (6::smallint, '**Kontrola miękkości.** Sprawdź ziemniaki, kalafior i warzywa korzeniowe. Jeżeli są twarde, dogotowuj po **2 minuty** przed blendowaniem.', 'wszystkie warzywa łatwo rozgniatają się widelcem'::text, true),
         (7::smallint, '**Blendowanie.** Zdejmij garnek z ognia i zblenduj zupę z zanurzoną końcówką blendera. Dopraw solą i pieprzem.', null::text, false),
         (8::smallint, '**Podanie.** Podaj krem z pieczywem. Pieczoną ciecierzycę dodaj dopiero na talerzu.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (2::smallint, '**Cukinia.** Umyj cukinię i pokrój w półplasterki grubości około 5 mm.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Krewetki.** Obierz krewetki i usuń przewód pokarmowy, jeśli pozostał. Osusz. Mrożone krewetki wcześniej rozmroź w lodówce.', null::text, false),
         (7::smallint, '**Po przygotowaniu krewetek.** Umyj ręce, nóż, deskę i powierzchnie po kontakcie z surowymi krewetkami.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól i chili.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp ryż i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Ryż — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Gdy do końca gotowania ryżu pozostaje około **10 minut**, rozgrzej połowę oliwy na patelni przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie cukinii.** Smaż cukinię na średnio dużym ogniu **4–5 minut** i przełóż na talerz. Nadmiar wody odparuj teraz, przed dodaniem krewetek.', null::text, false),
         (5::smallint, '**Oliwa.** Wlej pozostałą oliwę i zmniejsz ogień do średniego.', null::text, false),
         (6::smallint, '**Czosnek i chili.** Dodaj czosnek i chili, smaż **20–30 sekund**.', null::text, false),
         (7::smallint, '**Smażenie krewetek.** Dodaj krewetki i smaż łącznie **3–4 minuty**, obracając w połowie; większe mogą wymagać nieco dłużej.', 'mięso jest nieprzezroczyste i perłowe także w środku'::text, true),
         (8::smallint, '**Połączenie i podanie.** Dodaj cukinię, wymieszaj i zdejmij z ognia. Dopraw przygotowanym sokiem z cytryny, solą i natką. Podaj z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krewetki z czosnkiem, cukinią i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Krupnik z kurczakiem, chili, papryką i cytryną
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Krupnik z kurczakiem, chili, papryką i cytryną', 'Lżejsza i bardziej wyrazista wersja klasycznego krupniku. Chudy kurczak zapewnia dużo białka, wędzona papryka i chili nadają głębi oraz lekkiej ostrości, a sok z cytryny dodany na końcu odświeża smak zupy.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 1050, 1, 2,
  15, 69,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 4 l', 'Patelnia 28 cm', 'Sitko', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Kasza jęczmienna będzie nadal chłonęła płyn, dlatego następnego dnia krupnik może być znacznie gęstszy. Podczas odgrzewania dolej trochę wody.',
  true, 'Jeśli krupnik jest za gęsty, dolej trochę wody. Jeśli jest mdły, najpierw skoryguj ilość soli i dodaj świeżego koperku lub natki pietruszki.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Udo z kurczaka bez skóry, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'sucha, przepłukana', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Kasza jęczmienna, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'część biała i jasnozielona, w plastrach', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 250, 'g'::jednostka_miary, 250,
       'obrane', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 900, 'g'::jednostka_miary, 900,
       'na wywar — po odparowaniu', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 17
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 18
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Chili suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'ml'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 19
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       'umyty, osuszony i drobno posiekany; do zupy i posypania przed podaniem', null, sk.rola, sk.mozna_dzielic, 20
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and sk.nazwa = 'koperek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Kasza jęczmienna.** Odmierz kaszę i dokładnie przepłucz na sitku pod zimną wodą.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 1 cm.', null::text, false),
         (3::smallint, '**Pietruszka korzeń.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 1 cm.', null::text, false),
         (4::smallint, '**Seler korzeniowy.** Umyj i obierz seler, pokrój w kostkę około 1 cm.', null::text, false),
         (5::smallint, '**Por.** Przekrój por wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w plasterki.', null::text, false),
         (6::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (7::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (8::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (9::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (10::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (11::smallint, '**Kurczak.** Przygotuj mięso z uda bez skóry. Jeśli ma kość, podana masa dotyczy samego mięsa.', null::text, false),
         (12::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (13::smallint, '**Koperek.** Umyj i osusz koperek, usuń grube łodygi i drobno posiekaj delikatne gałązki.', null::text, false),
         (14::smallint, '**Woda.** Odmierz wodę z listy składników.', null::text, false),
         (15::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (16::smallint, '**Przyprawy.** Odmierz sól, pieprz, słodką paprykę, chili, liście laurowe i ziele angielskie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie wywaru', 45 from przepisy p where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Kurczak do garnka.** Włóż mięso do garnka, dodaj liść laurowy, ziele angielskie i odmierzoną wodę.', null::text, false),
         (2::smallint, '**Gotowanie wywaru.** Doprowadź do wrzenia i zbierz szumowiny. Zmniejsz ogień i gotuj łagodnie przez około **40 minut**. Uzupełniaj odparowaną wodę.', null::text, false),
         (3::smallint, '**Cebula — równolegle.** Pod koniec gotowania wywaru rozgrzej odmierzoną oliwę na patelni przez **1 minutę**. Dodaj cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (4::smallint, '**Czosnek i przyprawy.** Dodaj do cebuli czosnek, odmierzoną słodką paprykę i chili. Smaż przez **30 sekund**, mieszając.', null::text, false),
         (5::smallint, '**Wyjęcie kurczaka.** Wyjmij ugotowanego kurczaka. Oddziel mięso od kości, jeśli są, i podziel na mniejsze kawałki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Gotowanie warzyw i kaszy', 24 from przepisy p where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Warzywa i kasza.** Do wywaru dodaj marchew, pietruszkę, seler, por, ziemniaki, przepłukaną kaszę i podsmażoną cebulę z przyprawami.', null::text, false),
         (2::smallint, '**Gotowanie kaszy.** Gotuj na małym ogniu przez około **20 minut**, aż kasza i ziemniaki będą miękkie. Sprawdź też czas na opakowaniu kaszy; w razie potrzeby dogotowuj po **3–5 minut**.', null::text, false),
         (3::smallint, '**Powrót kurczaka.** Włóż mięso do zupy i podgrzewaj przez **2 minuty**. Usuń liść laurowy i ziele angielskie.', null::text, false),
         (4::smallint, '**Doprawienie.** Zdejmij garnek z ognia. Wmieszaj odmierzony sok z cytryny oraz część natki i koperku. Dopraw solą i pieprzem.', null::text, false),
         (5::smallint, '**Podanie.** Rozlej zupę i posyp pozostałą natką oraz koperkiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Krupnik z kurczakiem, chili, papryką i cytryną') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Królik z rozmarynem i warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Królik z rozmarynem i warzywami korzeniowymi', 'Królik pieczony z ziemniakami, marchewką, pasternakiem, selerem i rozmarynem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 732, 1, 1,
  20, 90,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Nóż szefa kuchni', 'Deska do krojenia', 'Waga kuchenna', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w zamkniętym pojemniku w lodówce do 3 dni. Pozostałości szybko schłodź w płytkich pojemnikach i wstaw do lodówki najpóźniej w ciągu 2 godzin od przygotowania. Lodówka: do 4°C.',
  true, 'Jeżeli mięso pozostaje twarde, piecz dalej pod przykryciem po 10 minut. Dolewaj trochę gorącej wody tylko wtedy, gdy dno naczynia wysycha. Gotowe mięso i warzywa polej sosem powstałym podczas pieczenia.'
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
       'jedna trzecia drobno posiekana do sosu; reszta w kawałkach około 2 cm', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'jedna trzecia drobno posiekana do sosu; reszta w kawałkach około 2 cm', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Pasternak, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'jedna trzecia drobno posiekana do sosu; reszta w kawałkach około 2 cm', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'pokrojona', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       'ilość początkowa do potrawy; w trakcie gotowania uzupełniaj tylko w razie potrzeby, zgodnie z instrukcją', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz warzywo. Jedną trzecią drobno posiekaj do sosu, resztę pokrój na kawałki około 2 cm i odłóż osobno.', null::text, false),
         (3::smallint, '**Pasternak.** Umyj i obierz warzywo. Jedną trzecią drobno posiekaj do sosu, resztę pokrój na kawałki około 2 cm i odłóż osobno.', null::text, false),
         (4::smallint, '**Seler korzeniowy.** Umyj i obierz warzywo. Jedną trzecią drobno posiekaj do sosu, resztę pokrój na kawałki około 2 cm i odłóż osobno.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i pokrój w ósemki.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (7::smallint, '**Rozmaryn.** Umyj i osusz rozmaryn.', null::text, false),
         (8::smallint, '**Warzywa do pieczenia.** Połowę odmierzonej oliwy i część soli oraz pieprzu rozdziel między cebulę, drobno posiekane warzywa oraz odłożone większe kawałki z ziemniakami. Wymieszaj każdą grupę osobno.', null::text, false),
         (9::smallint, '**Królik.** Osusz mięso bez kości i podziel na kawałki około 4 cm. Natrzyj pozostałą oliwą, czosnkiem, rozmarynem oraz resztą soli i pieprzu.', null::text, false),
         (10::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (11::smallint, '**Woda.** Odmierz wodę z listy składników do przygotowania potrawy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie pod przykryciem', 90 from przepisy p where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **180°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Baza sosu.** Wybierz naczynie z pokrywą, dopasowane do ilości mięsa. Na dnie rozłóż cebulę i drobno posiekane części marchwi, pasternaku oraz selera. Ułóż na nich mięso, wlej odmierzoną wodę i szczelnie przykryj.', null::text, false),
         (3::smallint, '**Pierwsze pieczenie.** Piecz pod przykryciem **35 minut**.', null::text, false),
         (4::smallint, '**Pozostałe warzywa.** Dodaj ziemniaki i odłożone większe kawałki marchwi, pasternaku oraz selera. Wymieszaj je z płynem z pieczenia i ponownie przykryj. Jeśli dno zaczyna wysychać, dolej niewielką ilość gorącej wody.', null::text, false),
         (5::smallint, '**Dalsze pieczenie.** Piecz kolejne **35–40 minut**. Jeśli mięso jest nadal twarde, piecz dalej po **10 minut** pod przykryciem, kontrolując ilość płynu.', 'królik jest miękki, ma co najmniej 71°C w środku; warzywa miękkie'::text, true),
         (6::smallint, '**Podanie.** Podaj, polewając mięso i warzywa płynem z pieczenia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Królik z rozmarynem i warzywami korzeniowymi') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Chili sin carne z czarną fasolą', 13, 2, 15),
  ('Curry z ciecierzycy, pomidorów i szpinaku', 12, 2, 15),
  ('Curry z czerwonej soczewicy i szpinaku', 11, 2, 15),
  ('Dorsz po grecku', 14, 2, 20),
  ('Dorsz w kokosowym curry ze szpinakiem', 12, 3, 25),
  ('Fasolka po bretońsku z indykiem', 13, 4, 24),
  ('Grillowany indyk z halloumi', 11, 4, 19),
  ('Grillowany kurczak caprese', 10, 3, 15),
  ('Grillowany kurczak z ogórkiem kiszonym', 12, 3, 17),
  ('Grochówka z indykiem', 15, 3, 25),
  ('Gulasz jagnięcy z ciecierzycą i pomidorami', 15, 2, 26),
  ('Gulasz wołowy z warzywami korzeniowymi', 15, 2, 21),
  ('Gulasz z białej fasoli, jarmużu i pomidorów', 15, 2, 20),
  ('Gulasz z kaszą gryczaną', 15, 3, 27),
  ('Indyk w sosie orzechowym (satay)', 12, 3, 23),
  ('Jajecznica ze szpinakiem', 8, 3, 12),
  ('Jajka w koszulkach z pastą twarogową', 10, 3, 17),
  ('Kanapki z mozzarellą, pomidorem i bazylią', 7, 2, 7),
  ('Kanapki z sardynkami, pomidorem i rukolą', 7, 2, 9),
  ('Kałamarnica z papryką i ryżem', 11, 2, 19),
  ('Klopsiki w sosie pomidorowym – tradycyjne', 13, 4, 20),
  ('Klopsiki z indyka w sosie pomidorowym z bulgurem', 12, 2, 20),
  ('Komosa ryżowa z ciecierzycą i pieczonymi warzywami', 12, 2, 13),
  ('Kotleciki z czerwonej soczewicy z sosem jogurtowym', 13, 3, 21),
  ('Krem z brokułów z fetą', 15, 2, 23),
  ('Krem z dyni na mleku kokosowym', 16, 2, 25),
  ('Krem z kalafiora z pieczoną ciecierzycą', 16, 2, 22),
  ('Krewetki z czosnkiem, cukinią i ryżem', 9, 2, 17),
  ('Krupnik z kurczakiem, chili, papryką i cytryną', 20, 3, 26),
  ('Królik z rozmarynem i warzywami korzeniowymi', 12, 2, 17)
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
where lower(p.nazwa) in (lower('Chili sin carne z czarną fasolą'), lower('Curry z ciecierzycy, pomidorów i szpinaku'), lower('Curry z czerwonej soczewicy i szpinaku'), lower('Dorsz po grecku'), lower('Dorsz w kokosowym curry ze szpinakiem'), lower('Fasolka po bretońsku z indykiem'), lower('Grillowany indyk z halloumi'), lower('Grillowany kurczak caprese'), lower('Grillowany kurczak z ogórkiem kiszonym'), lower('Grochówka z indykiem'), lower('Gulasz jagnięcy z ciecierzycą i pomidorami'), lower('Gulasz wołowy z warzywami korzeniowymi'), lower('Gulasz z białej fasoli, jarmużu i pomidorów'), lower('Gulasz z kaszą gryczaną'), lower('Indyk w sosie orzechowym (satay)'), lower('Jajecznica ze szpinakiem'), lower('Jajka w koszulkach z pastą twarogową'), lower('Kanapki z mozzarellą, pomidorem i bazylią'), lower('Kanapki z sardynkami, pomidorem i rukolą'), lower('Kałamarnica z papryką i ryżem'), lower('Klopsiki w sosie pomidorowym – tradycyjne'), lower('Klopsiki z indyka w sosie pomidorowym z bulgurem'), lower('Komosa ryżowa z ciecierzycą i pieczonymi warzywami'), lower('Kotleciki z czerwonej soczewicy z sosem jogurtowym'), lower('Krem z brokułów z fetą'), lower('Krem z dyni na mleku kokosowym'), lower('Krem z kalafiora z pieczoną ciecierzycą'), lower('Krewetki z czosnkiem, cukinią i ryżem'), lower('Krupnik z kurczakiem, chili, papryką i cytryną'), lower('Królik z rozmarynem i warzywami korzeniowymi'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
