-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 30 (część 3 z 4)
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
    ('Polędwiczka z pieczarkami i boczniakami', 'Polędwiczka wieprzowa, surowa', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Pieczarki, surowe', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Boczniaki, surowe', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Cebula, surowa', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Czosnek, surowy', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Kapusta kiszona', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Jogurt grecki naturalny 2%', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'woda', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Kasza gryczana, sucha', false),
    ('Polędwiczka z pieczarkami i boczniakami', 'Oliwa z oliwek extra virgin', false),
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
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Oliwa z oliwek extra virgin', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Tymianek suszony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Sól kłodawska', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Czarny pieprz mielony', false),
    ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 'Pietruszka korzeń', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Pstrąg tęczowy, surowy', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Pasternak, surowy', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Seler korzeń', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Oliwa z oliwek extra virgin', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Cytryna', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Rozmaryn suszony', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Sól kłodawska', false),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Ryż parboiled, suchy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Pieczarki, surowe', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Szpinak, surowy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Parmezan', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Cebula, surowa', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czosnek, surowy', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'woda', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Oliwa z oliwek extra virgin', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Sól kłodawska', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Czarny pieprz mielony', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Pietruszka korzeń', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Seler korzeń', false),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Por, surowy', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Pierś z kurczaka, surowa', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Ser feta', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Pomidory, surowe', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Ogórek, surowy', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Papryka czerwona, surowa', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Cebula czerwona, surowa', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Oliwki czarne', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Cytryna', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Chleb żytni razowy', true),
    ('Sałatka grecka z grillowanym kurczakiem', 'Oregano suszone', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Czarny pieprz mielony', false),
    ('Sałatka grecka z grillowanym kurczakiem', 'Sól kłodawska', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Makaron pełnoziarnisty, suchy', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Ser mozzarella', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Pomidory, surowe', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Ogórek, surowy', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Papryka czerwona, surowa', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Oliwki czarne', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Bazylia świeża', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Cytryna', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Sól kłodawska', false),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka z ciecierzycy', 'Ciecierzyca, sucha', false),
    ('Sałatka z ciecierzycy', 'woda', false),
    ('Sałatka z ciecierzycy', 'Pomidory, surowe', false),
    ('Sałatka z ciecierzycy', 'Ogórek, surowy', false),
    ('Sałatka z ciecierzycy', 'Cebula, surowa', false),
    ('Sałatka z ciecierzycy', 'Pietruszka natka', false),
    ('Sałatka z ciecierzycy', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka z ciecierzycy', 'Cytryna', false),
    ('Sałatka z ciecierzycy', 'Sól kłodawska', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Fasola czarna z puszki, odsączona', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kukurydza konserwowa, odsączona', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Pomidory, surowe', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Papryka czerwona, surowa', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Awokado', true),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Cebula czerwona, surowa', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Limonka', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kolendra świeża', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Kmin rzymski mielony', false),
    ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 'Sól kłodawska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Jaja kurze, całe, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ser feta', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Pomidory, surowe', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Ogórek, surowy', true),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sałata rzymska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Sól kłodawska', false),
    ('Sałatka z jajkiem, fetą i warzywami', 'Czarny pieprz mielony', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Jarmuż, surowy', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Jabłko ze skórką', true),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Pomarańcza', true),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Orzechy włoskie', false),
    ('Sałatka z jarmużu, jabłka i orzechów', 'Oliwa z oliwek extra virgin', false),
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
    ('Sałatka z komosy, buraka i koziego sera', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Ocet winny czerwony', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Tymianek suszony', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Sól kłodawska', false),
    ('Sałatka z komosy, buraka i koziego sera', 'Czarny pieprz mielony', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Buraki, surowe', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Ser feta', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Rukola', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Cebula czerwona, surowa', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Orzechy włoskie', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Ocet winny czerwony', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Tymianek suszony', false),
    ('Sałatka z pieczonym burakiem i fetą', 'Czarny pieprz mielony', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Tuńczyk w wodzie, odsączony', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Jaja kurze, całe, surowe', true),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Cebula czerwona, surowa', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Cytryna', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Oliwa z oliwek extra virgin', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Chleb żytni razowy', true),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Ziemniaki, surowe', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'ogórki kiszone bio', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Jogurt grecki naturalny 2%', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Musztarda', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Szczypiorek świeży', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Czarny pieprz mielony', false),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Sól kłodawska', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Pierś z kurczaka, surowa', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Jaja kurze, całe, surowe', true),
    ('Smażony ryż z kurczakiem i jajkiem', 'Ryż basmati, suchy', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Marchew, surowa', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Cebula, surowa', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Czosnek, surowy', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Groszek zielony mrożony', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Sos sojowy', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Olej rzepakowy rafinowany', false),
    ('Smażony ryż z kurczakiem i jajkiem', 'Szczypiorek świeży', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Tuńczyk świeży, surowy', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Fasolka szparagowa, surowa', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Ziemniaki, surowe', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Oliwa z oliwek extra virgin', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Cytryna', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Czosnek, surowy', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Sól kłodawska', false),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Czarny pieprz mielony', false),
    ('Szakszuka z mozzarellą', 'Jaja kurze, całe, surowe', true),
    ('Szakszuka z mozzarellą', 'Cebula, surowa', false),
    ('Szakszuka z mozzarellą', 'Papryka czerwona, surowa', false),
    ('Szakszuka z mozzarellą', 'Passata pomidorowa', false),
    ('Szakszuka z mozzarellą', 'Pomidory suszone w oleju', false),
    ('Szakszuka z mozzarellą', 'Ser mozzarella', false),
    ('Szakszuka z mozzarellą', 'Czosnek, surowy', false),
    ('Szakszuka z mozzarellą', 'Oliwa z oliwek extra virgin', false),
    ('Szakszuka z mozzarellą', 'Chleb żytni razowy', true),
    ('Szakszuka z mozzarellą', 'Papryka słodka mielona', false),
    ('Szakszuka z mozzarellą', 'Kmin rzymski mielony', false),
    ('Szakszuka z mozzarellą', 'Pietruszka natka', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Kasza bulgur, sucha', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Ciecierzyca z puszki, odsączona', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Pomidory, surowe', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Ogórek, surowy', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Cebula czerwona, surowa', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Pietruszka natka', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Mięta świeża', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Cytryna', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Oliwa z oliwek extra virgin', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Sól kłodawska', false),
    ('Tabbouleh z kaszy bulgur i ciecierzycy', 'Czarny pieprz mielony', false),
    ('Tofu z brokułem i ryżem', 'Tofu naturalne', false),
    ('Tofu z brokułem i ryżem', 'Brokuł, surowy', false),
    ('Tofu z brokułem i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Tofu z brokułem i ryżem', 'Sos sojowy', false),
    ('Tofu z brokułem i ryżem', 'Oliwa z oliwek extra virgin', false),
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
    ('Tofucznica ze szpinakiem i pomidorem', 'Oliwa z oliwek extra virgin', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Kurkuma mielona', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Sól kłodawska', false),
    ('Tofucznica ze szpinakiem i pomidorem', 'Czarny pieprz mielony', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Pierś z kurczaka, surowa', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Mleko kokosowe light z puszki', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Pasta tom kha', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Pieczarki, surowe', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Imbir korzeń, surowy', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Czosnek, surowy', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Cytryna', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Marchew, surowa', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Sos rybny', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Oliwa z oliwek extra virgin', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Ryż basmati, suchy', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Pietruszka natka', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Papryka ostra mielona', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Pietruszka korzeń', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Seler korzeń', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Por, surowy', false),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'woda', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Tortilla pełnoziarnista', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Ser Gouda', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Szpinak, surowy', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Pomidory, surowe', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Cebula, surowa', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Oliwa z oliwek extra virgin', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Oregano suszone', false),
    ('Tortilla z Goudą, szpinakiem i pomidorem', 'Czarny pieprz mielony', false),
    ('Tortilla z hummusem i warzywami', 'Tortilla pełnoziarnista', false),
    ('Tortilla z hummusem i warzywami', 'Ciecierzyca z puszki, odsączona', false),
    ('Tortilla z hummusem i warzywami', 'Sezam', false),
    ('Tortilla z hummusem i warzywami', 'Oliwa z oliwek extra virgin', false),
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
    ('Tortilla z jajkiem i szpinakiem', 'Oliwa z oliwek extra virgin', false),
    ('Tortilla z jajkiem i szpinakiem', 'Sól kłodawska', false),
    ('Tortilla z jajkiem i szpinakiem', 'Czarny pieprz mielony', false),
    ('Tortilla z jajkiem i szpinakiem', 'Ser mozzarella', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Tortilla pełnoziarnista', true),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Pierś z kurczaka, surowa', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Papryka czerwona, surowa', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Pomidory, surowe', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Ogórek, surowy', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Sałata rzymska', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Jogurt grecki naturalny 2%', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Czosnek, surowy', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'koperek świeży', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Cytryna', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Oliwa z oliwek extra virgin', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Papryka słodka mielona', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Sól kłodawska', false),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Czarny pieprz mielony', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Tortilla pełnoziarnista', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Pierś z kurczaka, surowa', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Awokado', true),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Pomidory, surowe', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Ogórek, surowy', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Sałata rzymska', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Jogurt naturalny 2%', false),
    ('Tortilla z kurczakiem, awokado i warzywami', 'Oliwa z oliwek extra virgin', false),
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
    ('Tortilla z tofu i chrupiącymi warzywami', 'Oliwa z oliwek extra virgin', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'Sezam', false),
    ('Tortilla z tofu i chrupiącymi warzywami', 'woda', false),
    ('Wieprzowina w sosie chrzanowym', 'Szynka wieprzowa chuda, surowa', false),
    ('Wieprzowina w sosie chrzanowym', 'Ziemniaki, surowe', false),
    ('Wieprzowina w sosie chrzanowym', 'Czosnek, surowy', false),
    ('Wieprzowina w sosie chrzanowym', 'woda', false),
    ('Wieprzowina w sosie chrzanowym', 'Chrzan tarty', false),
    ('Wieprzowina w sosie chrzanowym', 'Jogurt grecki naturalny 2%', false),
    ('Wieprzowina w sosie chrzanowym', 'Fasolka szparagowa mrożona', false),
    ('Wieprzowina w sosie chrzanowym', 'Oliwa z oliwek extra virgin', false),
    ('Wieprzowina w sosie chrzanowym', 'Pietruszka natka', false),
    ('Wieprzowina w sosie chrzanowym', 'koperek świeży', false),
    ('Wieprzowina w sosie chrzanowym', 'Czarny pieprz mielony', false),
    ('Wieprzowina w sosie chrzanowym', 'Sól kłodawska', false),
    ('Wieprzowina w sosie chrzanowym', 'Marchew, surowa', false),
    ('Wieprzowina w sosie chrzanowym', 'Pietruszka korzeń', false),
    ('Wieprzowina w sosie chrzanowym', 'Seler korzeń', false),
    ('Wieprzowina w sosie chrzanowym', 'Por, surowy', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Polędwiczka wieprzowa, surowa', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Papryka czerwona, surowa', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Marchew, surowa', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Cebula, surowa', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Czosnek, surowy', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Imbir korzeń, surowy', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Sos sojowy', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Fasolka szparagowa mrożona', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Ryż basmati, suchy', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Olej rzepakowy rafinowany', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Sezam', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Sól kłodawska', false),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Czarny pieprz mielony', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Polędwiczka wieprzowa, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Kapusta pekińska, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Ryż jaśminowy, suchy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Marchew, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Cebula, surowa', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Sos sojowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Imbir korzeń, surowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Czosnek, surowy', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Oliwa z oliwek extra virgin', false),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Sezam', false),
    ('Wołowina z brokułami po chińsku', 'Wołowina na plastry (udziec), surowa', false),
    ('Wołowina z brokułami po chińsku', 'Brokuł, surowy', false),
    ('Wołowina z brokułami po chińsku', 'Cebula, surowa', false),
    ('Wołowina z brokułami po chińsku', 'Czosnek, surowy', false),
    ('Wołowina z brokułami po chińsku', 'Imbir korzeń, surowy', false),
    ('Wołowina z brokułami po chińsku', 'Sos sojowy', false),
    ('Wołowina z brokułami po chińsku', 'Ryż basmati, suchy', false),
    ('Wołowina z brokułami po chińsku', 'Olej rzepakowy rafinowany', false),
    ('Wołowina z brokułami po chińsku', 'Sezam', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
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
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Piekarnik'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Blacha do pieczenia'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Deska do krojenia'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Waga kuchenna'),
    ('Pstrąg pieczony z warzywami korzeniowymi', 'Termometr do mięsa'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Garnek 3 l'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Tarka o drobnych oczkach'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Nóż szefa kuchni'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Deska do krojenia'),
    ('Ryż z pieczarkami, szpinakiem i parmezanem', 'Waga kuchenna'),
    ('Sałatka grecka z grillowanym kurczakiem', 'Grill kontaktowy'),
    ('Sałatka grecka z grillowanym kurczakiem', 'Miska'),
    ('Sałatka grecka z grillowanym kurczakiem', 'Nóż szefa kuchni'),
    ('Sałatka grecka z grillowanym kurczakiem', 'Deska do krojenia'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Garnek 3 l'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Sitko'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Miska'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Nóż szefa kuchni'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Deska do krojenia'),
    ('Sałatka makaronowa z mozzarellą i warzywami', 'Waga kuchenna'),
    ('Sałatka z ciecierzycy', 'Miska'),
    ('Sałatka z ciecierzycy', 'Deska do krojenia'),
    ('Sałatka z ciecierzycy', 'Nóż szefa kuchni'),
    ('Sałatka z ciecierzycy', 'Durszlak'),
    ('Sałatka z ciecierzycy', 'Waga kuchenna'),
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
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Garnek 2 l'),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Miska'),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Nóż szefa kuchni'),
    ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Deska do krojenia'),
    ('Smażony ryż z kurczakiem i jajkiem', 'Patelnia 28 cm'),
    ('Smażony ryż z kurczakiem i jajkiem', 'Garnek 2 l'),
    ('Smażony ryż z kurczakiem i jajkiem', 'Nóż szefa kuchni'),
    ('Smażony ryż z kurczakiem i jajkiem', 'Deska do krojenia'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Patelnia 28 cm'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Garnek 3 l'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Garnek 2 l'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Nóż szefa kuchni'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Deska do krojenia'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Waga kuchenna'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Durszlak'),
    ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Termometr do mięsa'),
    ('Szakszuka z mozzarellą', 'Patelnia 28 cm'),
    ('Szakszuka z mozzarellą', 'Nóż szefa kuchni'),
    ('Szakszuka z mozzarellą', 'Deska do krojenia'),
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
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Garnek 3 l'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Garnek 2 l'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Nóż szefa kuchni'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Deska do krojenia'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Sitko'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Waga kuchenna'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Termometr do mięsa'),
    ('Tom kha gai — kokosowa zupa z kurczakiem', 'Tarka o drobnych oczkach'),
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
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Patelnia 28 cm'),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Miska'),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Nóż szefa kuchni'),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Deska do krojenia'),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Widelec'),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Waga kuchenna'),
    ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Termometr do mięsa'),
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
    ('Wieprzowina w sosie chrzanowym', 'Garnek 3 l'),
    ('Wieprzowina w sosie chrzanowym', 'Patelnia 24 cm'),
    ('Wieprzowina w sosie chrzanowym', 'Tłuczek do ziemniaków'),
    ('Wieprzowina w sosie chrzanowym', 'Nóż szefa kuchni'),
    ('Wieprzowina w sosie chrzanowym', 'Deska do krojenia'),
    ('Wieprzowina w sosie chrzanowym', 'Garnek 2 l'),
    ('Wieprzowina w sosie chrzanowym', 'Rondel'),
    ('Wieprzowina w sosie chrzanowym', 'Blender ręczny'),
    ('Wieprzowina w sosie chrzanowym', 'Miska'),
    ('Wieprzowina w sosie chrzanowym', 'Waga kuchenna'),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Patelnia 28 cm'),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Garnek 2 l'),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Tarka o drobnych oczkach'),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Nóż szefa kuchni'),
    ('Wieprzowina w sosie sojowo-imbirowym', 'Deska do krojenia'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Patelnia 28 cm'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Garnek 2 l'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Tarka o drobnych oczkach'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Nóż szefa kuchni'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Deska do krojenia'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Waga kuchenna'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Sitko'),
    ('Wieprzowina z kapustą pekińską i ryżem', 'Termometr do mięsa'),
    ('Wołowina z brokułami po chińsku', 'Patelnia 28 cm'),
    ('Wołowina z brokułami po chińsku', 'Garnek 2 l'),
    ('Wołowina z brokułami po chińsku', 'Nóż szefa kuchni'),
    ('Wołowina z brokułami po chińsku', 'Deska do krojenia')
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka z pieczarkami i boczniakami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
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
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Smażenie kurczaka.** Smaż kurczaka **5 minut**, obracając.', null::text, false),
         (3::smallint, '**Warzywa.** Dodaj por, marchew, seler naciowy oraz drobno posiekany korzeń pietruszki. Smaż przez **4 minuty**, mieszając, aż por zmięknie.', null::text, false),
         (4::smallint, '**Wywar z mięsa i warzyw.** Wlej odmierzoną wodę i mieszaj przez **1–2 minuty**, delikatnie odrywając z dna zrumienione pozostałości po smażeniu. Nie zeskrobuj czarnych, przypalonych fragmentów. Dodaj tymianek. Doprowadź do łagodnego wrzenia przez około **3 minuty**, przykryj i gotuj przez **5 minut**.', null::text, false),
         (5::smallint, '**Kasza.** Wsyp kaszę, wymieszaj i gotuj na małym ogniu pod przykryciem przez czas podany na opakowaniu, orientacyjnie **20–30 minut**. Mieszaj co kilka minut. Jeśli ziarna są twarde, a płynu brakuje, dolewaj niewielkie ilości gorącej wody. Kolejny krok wykonaj na ostatnie **5 minut** gotowania.', null::text, false),
         (6::smallint, '**Groszek.** Gdy kasza jest prawie miękka, dodaj groszek i gotuj przez **5 minut**. Sprawdź miękkość kaszy i temperaturę najgrubszego kawałka kurczaka. Jeśli kasza jest twarda lub mięso nie osiągnęło **74°C**, dogotowuj po **2 minuty**, kontrolując płyn.', 'kasza jest miękka, kurczak ma co najmniej 74°C, potrawka jest wilgotna'::text, true),
         (7::smallint, '**Doprawienie i podanie.** Dopraw solą i pieprzem i podaj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój na kawałki około 1,5–2 cm.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz marchew, pokrój na kawałki około 2 cm.', null::text, false),
         (3::smallint, '**Pasternak.** Umyj i obierz pasternak, pokrój na kawałki około 2 cm.', null::text, false),
         (4::smallint, '**Seler korzeniowy.** Umyj i obierz seler, pokrój na kawałki około 2 cm.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Warzywa do pieczenia.** Wymieszaj warzywa z większością odmierzonej oliwy, rozmarynem i częścią soli oraz pieprzu.', null::text, false),
         (7::smallint, '**Pstrąg.** Osusz filety i usuń ości. Podana masa dotyczy części jadalnej. Natrzyj resztą oliwy, soli i pieprzu.', null::text, false),
         (8::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 55 from przepisy p where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **200°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie warzyw.** Rozłóż warzywa na blasze, piecz **25–30 minut** i przemieszaj w połowie. Powinny być prawie miękkie przed dodaniem ryby.', null::text, false),
         (3::smallint, '**Pieczenie pstrąga.** Dodaj filety i piecz **12–15 minut**, zależnie od ich grubości. Gotową rybę zdejmij; twarde warzywa dopiecz osobno.', 'ryba ma co najmniej 63°C, mięso rozdziela się widelcem'::text, true),
         (4::smallint, '**Podanie.** Skrop przygotowanym sokiem z cytryny i podaj.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pstrąg pieczony z warzywami korzeniowymi') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Ryż z pieczarkami, szpinakiem i parmezanem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
--  Sałatka grecka z grillowanym kurczakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka grecka z grillowanym kurczakiem', 'Świeża sałatka z grillowanym kurczakiem, fetą, pomidorem, ogórkiem, papryką, oliwkami i lekkim dressingiem cytrynowo-oliwnym. Sycący, pełnowartościowy posiłek w stylu śródziemnomorskim.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  1, 'prywatna',
  'waga', 681, 1, 1,
  7, 13,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Bez dressingu przechowuj w lodówce do 2 dni. Oliwę z cytryną najlepiej dodać dopiero przed jedzeniem. Nie nadaje się do mrożenia.',
  false, 'Za słona — feta jest słona, nie dosalaj. Przepłucz ser zimną wodą przed pokruszeniem. Puściła wodę — odlej i dopraw na nowo.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka grecka z grillowanym kurczakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka grecka z grillowanym kurczakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'pokruszona', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Ser feta';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'w cienkich piórkach', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'bez pestek', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Oliwki czarne';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Oregano suszone';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Pomidory.** Umyj pomidory i pokrój w grubą kostkę.', null::text, false),
         (2::smallint, '**Ogórek.** Umyj ogórek i pokrój w grubą kostkę.', null::text, false),
         (3::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój na kawałki około 2 cm.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (5::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (6::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (7::smallint, '**Kurczak.** Osusz pierś i rozkrój na płaty grubości około 1,5 cm. Natrzyj częścią oliwy, oregano i pieprzem.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Sól.** Odmierz sól.', null::text, false),
         (10::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Grillowanie kurczaka', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie grilla.** Rozgrzej grill kontaktowy zgodnie z instrukcją urządzenia, zwykle przez około **3 minuty**.', null::text, false),
         (2::smallint, '**Grillowanie kurczaka.** Grilluj kurczaka około **6–7 minut**, bez mocnego dociskania pokrywy. Mięso jest gotowe, gdy w najgrubszym miejscu osiągnie około **74°C**.', null::text, false),
         (3::smallint, '**Odpoczynek i krojenie.** Zdejmij kurczaka z grillownicy, odstaw na **3 minuty**, a następnie pokrój w paski.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Przygotowanie sałatki i podanie', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Warzywa.** W dużej misce wymieszaj pomidory, ogórka, paprykę, cebulę i oliwki.', null::text, false),
         (2::smallint, '**Sos cytrynowy.** Pozostałą oliwę wymieszaj z sokiem z cytryny. Polej sałatkę i delikatnie wymieszaj.', null::text, false),
         (3::smallint, '**Kurczak i feta.** Na sałatce ułóż grillowanego kurczaka i pokruszoną fetę. Posyp pozostałym oregano.', null::text, false),
         (4::smallint, '**Doprawienie.** Spróbuj przed dodaniem soli — feta i oliwki są już słone. Sól dodaj tylko w razie potrzeby.', null::text, false),
         (5::smallint, '**Podanie.** Podawaj z pieczywem żytnim.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka grecka z grillowanym kurczakiem') and e.kolejnosc = 3;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (2::smallint, '**Ogórek.** Umyj ogórek i pokrój w kostkę.', null::text, false),
         (3::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój w kostkę około 1 cm.', null::text, false),
         (4::smallint, '**Bazylia.** Umyj i osusz bazylię, oderwij liście od łodyg.', null::text, false),
         (5::smallint, '**Mozzarella.** Odsącz mozzarellę i porwij na mniejsze kawałki.', null::text, false),
         (6::smallint, '**Oliwki.** Odsącz oliwki i sprawdź, czy nie mają pestek.', null::text, false),
         (7::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (8::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i chłodzenie makaronu', 20 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie makaronu.** Zagotuj wodę i ugotuj makaron przez czas podany na opakowaniu.', null::text, false),
         (2::smallint, '**Schłodzenie makaronu.** Odcedź na sitku, krótko przelej zimną wodą i dokładnie odsącz.', null::text, false),
         (3::smallint, '**Sprawdzenie temperatury.** Przed dodaniem sera i surowych warzyw upewnij się, że makaron jest chłodny.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Połączenie sałatki.** Połącz makaron, mozzarellę, pokrojone warzywa, oliwki i bazylię. Skrop oliwą oraz przygotowanym sokiem z cytryny, dopraw solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka makaronowa z mozzarellą i warzywami') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka z ciecierzycy
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka z ciecierzycy', 'Świeża sałatka z ciecierzycy, pomidora, ogórka i cebuli z natką pietruszki oraz dressingiem cytrynowo-oliwnym. Lekki, bogaty w błonnik dodatek do obiadu lub kolacji.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['dodatek']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'sztuki', null, 1, 1,
  10, 65,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Miska', 'Deska do krojenia', 'Nóż szefa kuchni', 'Durszlak', 'Waga kuchenna']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w szczelnym pojemniku w lodówce do 2 dni. Jeżeli sałatka puści dużo wody, przed podaniem odlej nadmiar płynu i ponownie wymieszaj.',
  false, 'Wodnista — odlej płyn i dosyp garść ugotowanej ciecierzycy. Mdła — dodaj sok z cytryny, nie sól.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z ciecierzycy'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka z ciecierzycy'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'namoczona przez noc', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Ciecierzyca, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 300, 'g'::jednostka_miary, 300,
       'wchłonięta podczas gotowania', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'w kostce, bez gniazd nasiennych', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'w kostce', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'posiekana bardzo drobno', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sam sok', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Sałatka z ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ciecierzyca — poprzedniego dnia.** Odmierz suchą ciecierzycę. Zalej dużą ilością zimnej wody i mocz przez **8–12 godzin**. Ten czas trzeba doliczyć przed przygotowaniem posiłku.', null::text, false),
         (2::smallint, '**Ciecierzyca po namoczeniu.** Odlej wodę z moczenia i przepłucz ciecierzycę na sitku.', null::text, false),
         (3::smallint, '**Pomidory.** Umyj pomidory, usuń wodniste gniazda nasienne i pokrój miąższ w kostkę. Dzięki temu sałatka nie będzie wodnista.', null::text, true),
         (4::smallint, '**Ogórek.** Umyj ogórek i pokrój w kostkę.', null::text, true),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (7::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Sól.** Odmierz sól.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ciecierzycy', 45 from przepisy p where lower(p.nazwa) = lower('Sałatka z ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Woda do gotowania.** Namoczoną i przepłukaną ciecierzycę przełóż do garnka i zalej świeżą wodą tak, aby znajdowała się kilka centymetrów ponad ziarnami.', null::text, false),
         (2::smallint, '**Gotowanie ciecierzycy.** Doprowadź do wrzenia, zmniejsz ogień i gotuj około **45 minut** od zagotowania. Jeśli po tym czasie ciecierzyca jest jeszcze twarda, dogotowuj po **10 minut**, kontrolując miękkość i uzupełniając odparowaną wodę.', 'ziarna są miękkie, dają się łatwo rozgnieść, ale zachowują kształt'::text, true),
         (3::smallint, '**Sprawdzenie miękkości.** Gotowe ziarno powinno łatwo rozgniatać się między palcami.', null::text, false),
         (4::smallint, '**Studzenie.** Odcedź ciecierzycę i pozostaw do ostygnięcia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Połączenie sałatki', 20 from przepisy p where lower(p.nazwa) = lower('Sałatka z ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ciecierzyca i warzywa.** Ostudzoną ciecierzycę przełóż do miski i dodaj przygotowane warzywa oraz natkę pietruszki.', null::text, false),
         (2::smallint, '**Doprawienie.** Dodaj oliwę i sok z cytryny. Dopraw solą i dokładnie wymieszaj.', null::text, false),
         (3::smallint, '**Odstawienie sałatki.** Odstaw sałatkę na około **15 minut**, aby smaki się połączyły, a cebula nieco złagodniała.', 'cebula traci ostrość'::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z ciecierzycy') and e.kolejnosc = 3;

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
  12, 3,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Fasola.** Przełóż fasolę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (2::smallint, '**Kukurydza.** Odsącz kukurydzę i odmierz potrzebną ilość.', null::text, false),
         (3::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (4::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój w kostkę około 1 cm.', null::text, false),
         (5::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (6::smallint, '**Kolendra.** Umyj i osusz kolendrę, następnie posiekaj.', null::text, false),
         (7::smallint, '**Limonka.** Umyj limonkę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (8::smallint, '**Awokado.** Umyj awokado, usuń skórkę i pestkę. Pokrój miąższ i skrop odmierzonym sokiem z limonki.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz kmin rzymski.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Sałatka z czarnej fasoli, kukurydzy i pomidora');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Fasola i warzywa.** Wymieszaj fasolę, kukurydzę, paprykę, pomidora oraz cebulę.', null::text, false),
         (2::smallint, '**Doprawienie i awokado.** Dodaj oliwę, kmin, sól i awokado wraz z sokiem z limonki. Delikatnie wymieszaj i posyp kolendrą.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Pomidor.** Umyj pomidory i pokrój w cząstki.', null::text, false),
         (2::smallint, '**Ogórek.** Umyj ogórek i pokrój w cienkie półplasterki.', null::text, false),
         (3::smallint, '**Sałata.** Umyj liście sałaty, dokładnie osusz i porwij na mniejsze kawałki.', null::text, false),
         (4::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (5::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (6::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie jajek', 18 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie jajek.** Zagotuj tyle wody, aby przykryła jajka. Ostrożnie włóż jajka i gotuj przy łagodnym wrzeniu przez **9–10 minut**, licząc od włożenia.', null::text, false),
         (2::smallint, '**Schłodzenie jajek.** Przełóż jajka do zimnej wody. Po schłodzeniu obierz.', null::text, false),
         (3::smallint, '**Krojenie jajek.** Pokrój jajka w ćwiartki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 2 from przepisy p where lower(p.nazwa) = lower('Sałatka z jajkiem, fetą i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Połączenie sałatki.** Połącz warzywa, jajka i fetę. Skrop oliwą, spróbuj i dopraw odmierzoną solą oraz pieprzem; feta jest słona. Delikatnie wymieszaj.', null::text, false)
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
  10, 5,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Jarmuż.** Umyj jarmuż, usuń twarde łodygi i porwij liście na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Jabłko.** Umyj jabłko, usuń gniazdo nasienne i pokrój miąższ w kostkę.', null::text, false),
         (3::smallint, '**Pomarańcza.** Umyj i obierz pomarańczę. Podziel na cząstki, zachowując wypływający sok.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Orzechy.** Odmierz orzechy włoskie i grubo posiekaj.', null::text, false),
         (6::smallint, '**Musztarda.** Odmierz musztardę.', null::text, false),
         (7::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Łączenie sałatki', 5 from przepisy p where lower(p.nazwa) = lower('Sałatka z jarmużu, jabłka i orzechów');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Sos.** Wymieszaj oliwę z sokiem z cytryny, zachowanym sokiem pomarańczowym, musztardą, solą i pieprzem.', null::text, false),
         (2::smallint, '**Zmiękczenie jarmużu.** Masuj liście jarmużu z dressingiem przez **2–3 minuty**.', 'liście ciemnieją i stają się delikatniejsze'::text, true),
         (3::smallint, '**Połączenie i podanie.** Dodaj jabłko, cząstki pomarańczy i orzechy. Wymieszaj i podaj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Buraki.** Umyj i obierz buraki, pokrój w kostkę około 1 cm. Wymieszaj z połową oliwy i tymiankiem.', null::text, false),
         (2::smallint, '**Komosa.** Odmierz komosę i dokładnie opłucz na sitku.', null::text, false),
         (3::smallint, '**Rukola.** Umyj rukolę i dokładnie osusz.', null::text, false),
         (4::smallint, '**Jabłko.** Umyj jabłko, usuń gniazdo nasienne i pokrój miąższ w kostkę.', null::text, false),
         (5::smallint, '**Orzechy.** Odmierz orzechy włoskie i grubo posiekaj.', null::text, false),
         (6::smallint, '**Ser kozi.** Odmierz ser i podziel na mniejsze kawałki.', null::text, false),
         (7::smallint, '**Dodatki.** Odmierz ocet winny.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 50 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **200°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie buraków.** Rozłóż buraki na blasze i piecz **30–40 minut**, mieszając w połowie.', null::text, false),
         (3::smallint, '**Komosa — równolegle.** Równolegle ugotuj komosę przez czas z opakowania, w dodatkowej wodzie. Odcedź, rozsyp cienko na talerzu do przestudzenia.', null::text, false),
         (4::smallint, '**Sprawdzenie buraków.** Sprawdź buraki widelcem; muszą być miękkie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Studzenie i łączenie', 13 from przepisy p where lower(p.nazwa) = lower('Sałatka z komosy, buraka i koziego sera');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Studzenie buraków.** Przestudź buraki rozłożone na talerzu przez około **10 minut**, aby nie zwiędła rukola.', null::text, false),
         (2::smallint, '**Połączenie sałatki.** Połącz letnią lub chłodną komosę i buraki z rukolą, jabłkiem, orzechami oraz kozim serem. Dodaj pozostałą oliwę, ocet, sól i pieprz.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Buraki.** Umyj i obierz buraki, pokrój w kostkę około 1 cm. Wymieszaj z połową oliwy i tymiankiem.', null::text, false),
         (2::smallint, '**Rukola.** Umyj rukolę i dokładnie osusz.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (5::smallint, '**Orzechy.** Odmierz orzechy włoskie i grubo posiekaj.', null::text, false),
         (6::smallint, '**Dodatki.** Odmierz ocet winny.', null::text, false),
         (7::smallint, '**Pieprz.** Odmierz pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 50 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **200°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie buraków.** Rozłóż buraki na blasze, piecz **30–40 minut**, obracając w połowie.', 'buraki łatwo dają się nakłuć widelcem'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Studzenie i łączenie', 13 from przepisy p where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Studzenie buraków.** Przestudź buraki przez około **10 minut** na talerzu; nie dodawaj gorących do rukoli.', null::text, false),
         (2::smallint, '**Połączenie sałatki.** Połącz rukolę, buraki, cebulę, orzechy i fetę. Skrop pozostałą oliwą i octem, dopraw pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka z pieczonym burakiem i fetą') and e.kolejnosc = 3;

-- -------------------------------------------------------------------------
--  Sałatka ziemniaczana z tuńczykiem i jajkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Sałatka ziemniaczana z tuńczykiem i jajkiem', 'Kremowa sałatka ziemniaczana z tuńczykiem, jajkiem i ogórkiem kiszonym w lekkim sosie jogurtowo-musztardowym. Dzięki ziemniakom, jajku i sosowi smak tuńczyka jest łagodniejszy i dobrze łączy się z pozostałymi składnikami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['salatka']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 640, 1, 1,
  5, 29,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 2 l', 'Miska', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w szczelnym pojemniku w lodówce do 2 dni. Nie nadaje się do mrożenia.',
  false, 'Puściła wodę — odlej i dopraw na nowo. Za kwaśna — łyżka oliwy zbalansuje.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Tuńczyk w wodzie, odsączony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'w cienkich piórkach', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Cebula czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'g'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'ogórki kiszone bio';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 10, 'g'::jednostka_miary, 10,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Musztarda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Szczypiorek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (2::smallint, '**Ogórek kiszony.** Odsącz ogórki kiszone i pokrój w drobną kostkę.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (4::smallint, '**Szczypiorek.** Umyj i osusz szczypiorek, następnie drobno posiekaj.', null::text, false),
         (5::smallint, '**Tuńczyk.** Odsącz tuńczyka i lekko rozdrobnij widelcem. Odmierz po odsączeniu.', null::text, false),
         (6::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (7::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (8::smallint, '**Musztarda.** Odmierz musztardę.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false),
         (11::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ziemniaków i jajka', 15 from przepisy p where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie ziemniaków.** Ziemniaki ugotuj w lekko osolonej wodzie przez około **10–12 minut**. Powinny być miękkie, ale nadal zwarte i nie mogą się rozpadać.', null::text, false),
         (2::smallint, '**Jajka — równolegle.** Równolegle zagotuj wodę w drugim garnku, ostrożnie włóż jajka i gotuj przez **9 minut** od włożenia, przy łagodnym wrzeniu.', null::text, false),
         (3::smallint, '**Krojenie jajek.** Jajko ostudź, obierz i pokrój w większą kostkę.', null::text, false),
         (4::smallint, '**Studzenie ziemniaków.** Ugotowane ziemniaki odcedź i rozłóż na talerzu i pozostaw na około **5 minut** do przestudzenia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Przygotowanie sosu', 7 from przepisy p where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Sos jogurtowy.** Jogurt grecki wymieszaj z musztardą, oliwą i częścią soku z cytryny.', null::text, false),
         (2::smallint, '**Pieprz.** Dodaj pieprz i spróbuj.', null::text, false),
         (3::smallint, '**Sok z cytryny.** Jeśli sos potrzebuje więcej świeżości, stopniowo dodawaj pozostały sok z cytryny. Z solą poczekaj do końca, ponieważ tuńczyk, musztarda i ogórek kiszony są już słone.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and e.kolejnosc = 3;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 4, 'Połączenie sałatki', 7 from przepisy p where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Warzywa i tuńczyk.** Do miski włóż ziemniaki, ogórka kiszonego, cebulę i tuńczyka.', null::text, false),
         (2::smallint, '**Sos.** Dodaj przygotowany sos i delikatnie wymieszaj, żeby nie rozgnieść ziemniaków.', null::text, false),
         (3::smallint, '**Jajka i szczypiorek.** Dodaj jajko oraz szczypiorek i jeszcze raz delikatnie wymieszaj.', null::text, false),
         (4::smallint, '**Doprawienie.** Spróbuj i w razie potrzeby dopraw pieprzem lub niewielką ilością soli.', null::text, false),
         (5::smallint, '**Podanie.** Podawaj z pieczywem żytnim. Sałatkę można jeść od razu, ale najlepiej smakuje po około **15–30 minutach** w lodówce', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Sałatka ziemniaczana z tuńczykiem i jajkiem') and e.kolejnosc = 4;

-- -------------------------------------------------------------------------
--  Smażony ryż z kurczakiem i jajkiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Smażony ryż z kurczakiem i jajkiem', 'Smażony ryż z kurczakiem, jajkiem, marchewką i groszkiem, doprawiony sosem sojowym i szczypiorkiem. Dobry sposób na wykorzystanie ryżu ugotowanego poprzedniego dnia.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 403, 1, 1,
  7, 13,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w szczelnym pojemniku w lodówce do 2 dni. Po przygotowaniu danie szybko ostudź i włóż do lodówki. Przy odgrzewaniu podgrzej je dokładnie i najlepiej tylko jeden raz.',
  false, 'Ryż się klei — był ciepły. Musi być z lodówki, najlepiej wczorajszy.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Smażony ryż z kurczakiem i jajkiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Smażony ryż z kurczakiem i jajkiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 90, 'g'::jednostka_miary, 90,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'suchy, ugotowany osobno', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Groszek zielony mrożony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 12, 'g'::jednostka_miary, 12,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'posiekany', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and sk.nazwa = 'Szczypiorek świeży';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — wcześniej.** Odmierz suchy ryż i ugotuj zgodnie z opakowaniem przed rozpoczęciem tego przepisu. Szybko ostudź w płytkim naczyniu i przechowuj w lodówce; do smażenia użyj zimnego ryżu.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w drobną kostkę lub cienkie krótkie słupki.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Jajka.** Wbij jajka do miski i roztrzep widelcem.', null::text, false),
         (6::smallint, '**Szczypiorek.** Umyj i osusz szczypiorek, następnie drobno posiekaj.', null::text, false),
         (7::smallint, '**Kurczak.** Osusz mięso kurczaka bez skóry i kości, pokrój w kostkę około 2 cm.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Dodatki.** Odmierz sos sojowy.', null::text, false),
         (10::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (11::smallint, '**Groszek.** Odmierz mrożony groszek i pozostaw w zamrażarce do gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 13 from przepisy p where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oleju.** Na dużej patelni mocno rozgrzej olej.', null::text, false),
         (2::smallint, '**Smażenie kurczaka.** Dodaj kurczaka i smaż około **3–4 minut**, mieszając, aż lekko się zrumieni i będzie usmażony w środku.', null::text, false),
         (3::smallint, '**Zdjęcie kurczaka.** Zdejmij mięso z patelni i odłóż.', null::text, false),
         (4::smallint, '**Smażenie jajek.** Na tę samą patelnię wlej roztrzepane jajko. Smaż około **1 minuty**, energicznie mieszając i dzieląc jajko na małe kawałki.', null::text, false),
         (5::smallint, '**Zdjęcie jajek.** Zdejmij z patelni i odłóż razem z kurczakiem.', null::text, false),
         (6::smallint, '**Cebula i marchew.** Na patelnię wrzuć cebulę i marchew. Smaż około **2–3 minut**, często mieszając.', null::text, false),
         (7::smallint, '**Czosnek.** Dodaj czosnek i smaż jeszcze około **30 sekund**.', null::text, false),
         (8::smallint, '**Groszek.** Dodaj mrożony groszek i smaż około **1 minuty**.', null::text, false),
         (9::smallint, '**Smażenie ryżu.** Dodaj zimny ugotowany ryż. Rozbij łopatką wszystkie grudki i smaż na dość dużym ogniu około **3–4 minut**, często mieszając.', null::text, false),
         (10::smallint, '**Połączenie składników.** Dodaj z powrotem kurczaka i jajko. Wlej sos sojowy i dokładnie wymieszaj. Smaż jeszcze około **1 minuty**, aż wszystkie składniki będą gorące.', null::text, false),
         (11::smallint, '**Szczypiorek.** Zdejmij patelnię z ognia i posyp danie świeżym szczypiorkiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Smażony ryż z kurczakiem i jajkiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Stek z tuńczyka z fasolką szparagową i ziemniakami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Stek z tuńczyka z fasolką szparagową i ziemniakami', 'Krótko smażony stek z tuńczyka z fasolką szparagową i gotowanymi ziemniakami. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (2::smallint, '**Fasolka szparagowa.** Umyj fasolkę i odetnij końcówki.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Sos cytrynowy.** Wymieszaj sok z cytryny z połową oliwy i czosnkiem.', null::text, false),
         (6::smallint, '**Tuńczyk.** Osusz stek grubości około 2 cm. Posmaruj pozostałą oliwą i dopraw solą oraz pieprzem.', null::text, false),
         (7::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie dodatków i smażenie', 38 from przepisy p where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie ziemniaków.** Zalej ziemniaki wodą, zagotuj przez około **5 minut** i gotuj **15–20 minut** do miękkości. Odcedź i przykryj.', null::text, false),
         (2::smallint, '**Fasolka — równolegle.** Równolegle zagotuj wodę w drugim garnku. Dodaj fasolkę, gotuj **8–12 minut** do miękkości, zachowując lekki opór przy gryzieniu; odcedź.', null::text, false),
         (3::smallint, '**Rozgrzanie patelni.** Gdy zwolni się palnik, rozgrzej patelnię przez **1–2 minuty**.', null::text, false),
         (4::smallint, '**Smażenie tuńczyka.** Smaż tuńczyka około **3 minuty** z każdej strony.', null::text, false),
         (5::smallint, '**Sprawdzenie ryby.** Sprawdź temperaturę najgrubszego miejsca; w razie potrzeby dosmaż po **1 minucie** na mniejszym ogniu.', 'ryba ma co najmniej 63°C, bez surowego środka'::text, true),
         (6::smallint, '**Podanie.** Polej ziemniaki oraz fasolkę przygotowaną oliwą z cytryną i czosnkiem, podaj z tuńczykiem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Stek z tuńczyka z fasolką szparagową i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Szakszuka z mozzarellą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Szakszuka z mozzarellą', 'Szakszuka z jajkami, papryką i mozzarellą w niewielkiej ilości intensywnego sosu pomidorowego. Suszone pomidory dodają smaku, a mozzarella łagodzi kwasowość pomidorów i nadaje daniu kremowości.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['srodziemnomorska']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 554, 1, 1,
  7, 18,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Najlepiej przygotowywać jajka bezpośrednio przed jedzeniem. Sam sos pomidorowo-warzywny można przechowywać w szczelnym pojemniku w lodówce do 3 dni. Przy kolejnym podaniu podgrzej sos i dopiero wtedy wbij świeże jajka oraz dodaj mozzarellę.',
  false, 'Sos za rzadki — duś dłużej bez przykrycia. Jajka się rozlały — nie mieszaj po wbiciu, tylko przykryj.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Szakszuka z mozzarellą'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Szakszuka z mozzarellą'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'ml'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Pomidory suszone w oleju';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Ser mozzarella';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Kmin rzymski mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and sk.nazwa = 'Pietruszka natka';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 7 from przepisy p where lower(p.nazwa) = lower('Szakszuka z mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój w kostkę około 1 cm.', null::text, false),
         (3::smallint, '**Suszone pomidory.** Odsącz suszone pomidory z oleju i drobno posiekaj.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (5::smallint, '**Mozzarella.** Odsącz mozzarellę i porwij na mniejsze kawałki.', null::text, false),
         (6::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (7::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz słodką paprykę i kmin rzymski.', null::text, false),
         (10::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie szakszuki', 18 from przepisy p where lower(p.nazwa) = lower('Szakszuka z mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Na patelni rozgrzej oliwę.', null::text, false),
         (2::smallint, '**Cebula i papryka.** Dodaj cebulę i paprykę. Smaż około **4–5 minut**, aż cebula się zeszkli, a papryka lekko zmięknie, ale nadal będzie miała strukturę.', null::text, false),
         (3::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, słodką paprykę i kmin rzymski. Smaż około **30 sekund**, cały czas mieszając.', null::text, false),
         (4::smallint, '**Sos pomidorowy.** Wlej passatę i dodaj posiekane suszone pomidory. Wymieszaj i gotuj na małym ogniu około **4 minut**. Sos powinien lekko zgęstnieć, ale nadal pozostać wilgotny — nie odparowuj go do konsystencji pasty.', null::text, false),
         (5::smallint, '**Jajka do sosu.** Łyżką zrób w sosie wgłębienia (tak żeby jajka nie rozlały się po całej patelni) i wbij do nich jajka. Po wbiciu jajek nie mieszaj sosu.', null::text, false),
         (6::smallint, '**Gotowanie jajek.** Przykryj patelnię i gotuj na małym ogniu około **5–6 minut**, aż białka będą ścięte, a żółtka pozostaną miękkie lub lekko płynne.', null::text, false),
         (7::smallint, '**Mozzarella.** Rozłóż na wierzchu kawałki mozzarelli. Ponownie przykryj patelnię i podgrzewaj jeszcze około **1 minuty**, tylko do lekkiego zmięknięcia sera.', null::text, false),
         (8::smallint, '**Podanie.** Zdejmij patelnię z ognia, posyp natką pietruszki i podawaj od razu z pieczywem żytnim.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Szakszuka z mozzarellą') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ciecierzyca.** Przełóż ciecierzycę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (3::smallint, '**Ogórek.** Umyj ogórek i pokrój w kostkę.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (5::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (6::smallint, '**Mięta.** Umyj i osusz miętę, oderwij liście i posiekaj.', null::text, false),
         (7::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (8::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i chłodzenie kaszy', 20 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie kaszy.** Zagotuj wodę i gotuj bulgur przez czas z opakowania.', null::text, false),
         (2::smallint, '**Schłodzenie kaszy.** Odcedź, krótko przepłucz chłodną wodą i dokładnie odsącz. Upewnij się, że kasza nie jest gorąca.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Łączenie sałatki', 3 from przepisy p where lower(p.nazwa) = lower('Tabbouleh z kaszy bulgur i ciecierzycy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Połączenie sałatki.** Połącz kaszę, ciecierzycę, warzywa i zioła. Dodaj sok z cytryny, oliwę, sól i pieprz. Wymieszaj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (2::smallint, '**Tofu.** Odsącz i dokładnie osusz tofu. Pokrój w kostkę około 2 cm.', null::text, false),
         (3::smallint, '**Brokuł.** Umyj brokuł i podziel na małe różyczki około 2 cm.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (6::smallint, '**Dymka.** Umyj dymkę i pokrój w cienkie plasterki.', null::text, false),
         (7::smallint, '**Woda do brokułu.** Odmierz wodę z listy do krótkiego duszenia brokułu. Woda do gotowania ryżu jest dodatkowa i zostanie odlana.', null::text, false),
         (8::smallint, '**Dodatki.** Odmierz sezam i sos sojowy.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Tofu z brokułem i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp ryż i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Ryż — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na drugim palniku rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie tofu.** Smaż tofu przez **6–8 minut**, obracając.', null::text, false),
         (5::smallint, '**Zdjęcie tofu.** Przełóż na talerz.', null::text, false),
         (6::smallint, '**Obsmażenie brokułu.** Dodaj pozostałą oliwę i brokuł, smaż **2 minuty**.', null::text, false),
         (7::smallint, '**Duszenie brokułu.** Dolej odmierzoną wodę do brokułu i przykryj; duś **3–4 minuty**.', null::text, false),
         (8::smallint, '**Odparowanie.** Odkryj i odparuj resztę płynu.', null::text, false),
         (9::smallint, '**Czosnek i imbir.** Dodaj czosnek oraz imbir, smaż **30 sekund**.', null::text, false),
         (10::smallint, '**Połączenie z tofu.** Włóż tofu, dodaj sos sojowy i podgrzewaj **1 minutę**.', null::text, false),
         (11::smallint, '**Podanie.** Podaj z ryżem, sezamem i dymką.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofu z brokułem i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tofucznica ze szpinakiem i pomidorem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tofucznica ze szpinakiem i pomidorem', 'Szybka tofucznica ze szpinakiem, pomidorem, cebulą i kurkumą, podana z pieczywem. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Tofu.** Odsącz tofu i rozgnieć widelcem w misce.', null::text, false),
         (2::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (3::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (5::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (6::smallint, '**Przyprawy.** Odmierz sól, pieprz i kurkumę.', null::text, false),
         (7::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 11 from przepisy p where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Pomidor.** Dodaj pomidora i smaż **2–3 minuty**, odparowując nadmiar płynu.', null::text, false),
         (4::smallint, '**Tofu.** Dodaj tofu i kurkumę, podgrzewaj **2 minuty**.', null::text, false),
         (5::smallint, '**Szpinak.** Dodaj szpinak i smaż **1–2 minuty**, tylko do zwiędnięcia.', 'tofu jest gorące, szpinak zwiędł, bez kałuży płynu'::text, true),
         (6::smallint, '**Doprawienie i podanie.** Dopraw solą i pieprzem, podaj z pieczywem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tofucznica ze szpinakiem i pomidorem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tom kha gai — kokosowa zupa z kurczakiem
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tom kha gai — kokosowa zupa z kurczakiem', 'Aromatyczna, lekko pikantna zupa kokosowa z kurczakiem, pieczarkami i marchewką, doprawiona imbirem, pastą tom kha, sosem rybnym i cytryną. Podawana z ryżem basmati. Marchew, korzeń pietruszki, korzeń selera i por gotują się bezpośrednio w zupie. Czasy etapów są orientacyjne dla porcji bazowych; czas gotowania ryżu dobierz z opakowania.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['zupa']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 755, 1, 2,
  20, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 3 l', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia', 'Sitko', 'Waga kuchenna', 'Termometr do mięsa', 'Tarka o drobnych oczkach']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Zupę przechowuj w szczelnym pojemniku w lodówce do 3 dni. Ryż najlepiej przechowywać osobno. Podgrzewaj zupę łagodnie i nie doprowadzaj jej do intensywnego wrzenia.',
  false, 'Zupa się rozwarstwiła — cytryna trafiła do wrzącego mleka. Zblenduj chwilę, wróci. Za ostra — dolej mleka kokosowego.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 240, 'g'::jednostka_miary, 240,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 200, 'ml'::jednostka_miary, 200,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Pasta tom kha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 160, 'g'::jednostka_miary, 160,
       'w plastrach', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 12, 'g'::jednostka_miary, 12,
       'obrany, starty', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 6, 'g'::jednostka_miary, 6,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
       'sok', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Sos rybny';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       'suchy, ugotowany osobno', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Papryka ostra mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, kostka około 7–8 mm', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'biała i jasnozielona część, dokładnie wypłukana, cienkie półplasterki', null, sk.rola, sk.mozna_dzielic, 16
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'Por, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 500, 'ml'::jednostka_miary, 500,
       'cała odmierzona ilość do zupy', null, sk.rola, sk.mozna_dzielic, 17
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and sk.nazwa = 'woda';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (2::smallint, '**Korzeń pietruszki.** Umyj i obierz korzeń pietruszki, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (3::smallint, '**Korzeń selera.** Umyj i obierz seler korzeniowy, pokrój w kostkę około 7–8 mm. Odłóż do zupy.', null::text, false),
         (4::smallint, '**Por.** Odetnij korzonki i twarde końce liści. Białą i jasnozieloną część przekrój wzdłuż, dokładnie wypłucz ziemię spomiędzy warstw i pokrój w cienkie półplasterki. Odłóż do zupy.', null::text, false),
         (5::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (6::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (7::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (8::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (9::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (10::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (11::smallint, '**Kurczak.** Osusz kurczaka i pokrój w paski grubości około 1 cm.', null::text, false),
         (12::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (13::smallint, '**Woda.** Odmierz całą ilość wody wskazaną na liście składników.', null::text, false),
         (14::smallint, '**Mleko kokosowe.** Odmierz mleko kokosowe.', null::text, false),
         (15::smallint, '**Dodatki.** Odmierz sos rybny i pastę tom kha.', null::text, false),
         (16::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (17::smallint, '**Przyprawy.** Odmierz ostrą paprykę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie zupy i ryżu', 25 from przepisy p where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — drugi palnik.** W garnku 2 l zagotuj wodę do ryżu. Wsyp ryż i gotuj zgodnie z instrukcją na opakowaniu. Nastaw minutnik i w tym czasie przygotowuj zupę. Nadmiar wody po ugotowaniu odcedź; ta woda nie trafia do zupy.', null::text, false),
         (2::smallint, '**Baza zupy.** W garnku 3 l rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (3::smallint, '**Pasta tom kha.** Dodaj pastę i smaż przez **1 minutę**, mieszając.', null::text, false),
         (4::smallint, '**Warzywa korzeniowe.** Dodaj marchew, korzeń pietruszki, korzeń selera, imbir, czosnek i całą odmierzoną wodę. Przykryj i doprowadź do łagodnego wrzenia, orientacyjnie przez **5 minut**. Gotuj na małym ogniu przez **5 minut**.', null::text, false),
         (5::smallint, '**Kurczak i por.** Dodaj paski kurczaka i por. Po ponownym zagotowaniu gotuj łagodnie przez **3 minuty**.', null::text, false),
         (6::smallint, '**Pieczarki.** Dodaj pieczarki i gotuj przez **2 minuty**.', null::text, false),
         (7::smallint, '**Mleko kokosowe.** Dodaj mleko kokosowe. Podgrzewaj łagodnie przez około **2–3 minuty**, aż cała zupa będzie gorąca; nie doprowadzaj do intensywnego wrzenia.', null::text, false),
         (8::smallint, '**Kontrola kurczaka.** Sprawdź temperaturę najgrubszego kawałka mięsa. Jeśli jest niższa niż **74°C**, podgrzewaj łagodnie po **1 minucie** i sprawdzaj ponownie.', 'kurczak osiągnął co najmniej 74°C'::text, true),
         (9::smallint, '**Ryż — po minutniku.** Sprawdź miękkość ryżu po czasie z opakowania, odcedź nadmiar wody i przykryj. Zrób to po sygnale minutnika, niezależnie od postępu gotowania zupy.', null::text, false),
         (10::smallint, '**Doprawienie.** Dodaj około jednej trzeciej sosu rybnego i ostrą paprykę. Wymieszaj, spróbuj i stopniowo dodawaj pozostały sos według smaku.', null::text, false),
         (11::smallint, '**Cytryna.** Zdejmij garnek z ognia. Dodaj około dwóch trzecich przygotowanego soku z cytryny, spróbuj i w razie potrzeby dodaj pozostały sok.', null::text, false),
         (12::smallint, '**Podanie.** Nałóż ugotowany ryż do misek, zalej zupą i posyp natką pietruszki. Jeśli ryż wymaga więcej czasu niż zupa, zakończ jego gotowanie przed podaniem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tom kha gai — kokosowa zupa z kurczakiem') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (4::smallint, '**Gouda.** Odmierz Goudę i drobno pokrój.', null::text, false),
         (5::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (6::smallint, '**Przyprawy.** Odmierz pieprz i oregano.', null::text, false),
         (7::smallint, '**Tortille.** Wyjmij potrzebne placki i przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie farszu i opiekanie', 16 from przepisy p where lower(p.nazwa) = lower('Tortilla z Goudą, szpinakiem i pomidorem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Pomidor.** Dodaj pomidora i smaż **3–4 minuty**, odparowując płyn.', null::text, false),
         (4::smallint, '**Szpinak.** Dodaj szpinak i smaż **1 minutę** do zwiędnięcia. Dopraw oregano i pieprzem.', null::text, false),
         (5::smallint, '**Odłożenie farszu.** Przełóż farsz na talerz i wytrzyj patelnię.', null::text, false),
         (6::smallint, '**Ogrzanie tortilli.** Ogrzej tortillę na suchej patelni po **15–20 sekund** z każdej strony.', null::text, false),
         (7::smallint, '**Nadzienie.** Rozłóż farsz i ser, zostawiając brzegi wolne. Jeśli farszu jest za dużo do zawinięcia, podaj nadmiar obok.', null::text, false),
         (8::smallint, '**Zwijanie.** Złóż boki i zwiń.', null::text, false),
         (9::smallint, '**Opiekanie.** Opiekaj na średnio małym ogniu po **2–3 minuty** z każdej strony, aż ser się rozpuści.', null::text, false)
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
  10, 7,
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
       null, 'Sucha gotowana pod ciśnieniem 50 min', sk.rola, sk.mozna_dzielic, 2
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ciecierzyca.** Przełóż ciecierzycę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu
**Sucha.** Wersja ekspresowa (Bez moczenia): Suche ziarna wrzucasz prosto do szybkowaru. Zalewasz wodą (ok. 3-4 szklanki wody na 1 szklankę ciecierzycy) i gotujesz na wysokim ciśnieniu przez 40–50 minut.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w cienkie plastry. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (3::smallint, '**Ogórek.** Umyj ogórek i pokrój w cienkie słupki.', null::text, false),
         (4::smallint, '**Sałata.** Umyj liście sałaty, dokładnie osusz i porwij na mniejsze kawałki.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Czosnek.** Obierz czosnek; zostanie zblendowany w hummusie.', null::text, false),
         (7::smallint, '**Baza hummusu.** Odmierz sezam, oliwę i wodę do hummusu do osobnych naczyń.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz sól i kmin rzymski.', null::text, false),
         (9::smallint, '**Tortille.** Wyjmij potrzebne placki i przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Przygotowanie hummusu i zwijanie', 7 from przepisy p where lower(p.nazwa) = lower('Tortilla z hummusem i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Blendowanie sezamu.** W wąskim naczyniu zblenduj sezam z oliwą, sokiem z cytryny i częścią wody.', null::text, false),
         (2::smallint, '**Blendowanie hummusu.** Dodaj ciecierzycę, czosnek, kmin i sól; blenduj **2–3 minuty**, dodając stopniowo resztę wody. Pasta ma się łatwo rozsmarowywać; drobinki sezamu mogą pozostać.', null::text, false),
         (3::smallint, '**Nadziewanie.** Posmaruj tortillę hummusem, ułóż sałatę i warzywa, zostawiając wolne brzegi.', null::text, false),
         (4::smallint, '**Zwijanie.** Zawiń boki i zroluj.', null::text, false),
         (5::smallint, '**Podanie nadmiaru.** Nadmiar hummusu i warzyw, który nie mieści się w tortilli, podaj obok.', null::text, false)
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
  'waga', 396, 1, 1,
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
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and sk.nazwa = 'Ser mozzarella';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (3::smallint, '**Mozzarella.** Odmierz mozzarellę i pokrój w plastry', null::text, false),
         (4::smallint, '**Jajka.** Wbij jajka do miski i roztrzep z pieprzem oraz odmierzoną solą.', null::text, false),
         (5::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (6::smallint, '**Tortille.** Wyjmij potrzebne placki i przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i zwijanie', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Pomidor.** Smaż pomidora **2–3 minuty**, aby odparować płyn.', null::text, false),
         (3::smallint, '**Szpinak.** Dodaj szpinak i smaż **1 minutę**.', null::text, false),
         (4::smallint, '**Jajka.** Wlej jajka, smaż na małym ogniu **2–3 minuty**, mieszając do ścięcia bez płynnego białka.', null::text, false),
         (5::smallint, '**Mozzarella.**. Połóż pokrojone plastry na lekko ścięte jaja i poczekaj ok **1-2 minuty** aż ser lekko się stopi.', null::text, false),
         (6::smallint, '**Odłożenie farszu.** Przełóż farsz na talerz.', null::text, false),
         (7::smallint, '**Ogrzanie tortilli.** Ogrzej tortillę na suchej patelni po **15–20 sekund** na stronę.', null::text, false),
         (8::smallint, '**Nadzienie.** Dodaj farsz oraz mozzarella, zostawiając wolne brzegi. Nadmiar farszu podaj obok.', null::text, false),
         (9::smallint, '**Zwijanie i opiekanie.** Zwiń i opiekaj po **1 minucie** z każdej strony na średnio małym ogniu. Podaj od razu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z jajkiem i szpinakiem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 'Pełnoziarniste tortille z soczystym kurczakiem, papryką, pomidorem, ogórkiem i sałatą oraz jogurtowym sosem czosnkowo-koperkowym. Porcja bazowa obejmuje cały posiłek z ilości składników podanych na liście. Czasy etapów dotyczą jednej porcji bazowej; przy większej ilości dolicz czas podgrzewania placków i smażenia mięsa partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'szt'::jednostka_miary, round((2 * sk.masa_sztuki_g)::numeric, 1),
       'duże, elastyczne placki do zawijania', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Tortilla pełnoziarnista';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 130, 'g'::jednostka_miary, 130,
       'bez skóry i kości; paski grubości około 1 cm', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'bez gniazda nasiennego, w cienkich paskach', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'w cienkich półplasterkach, osuszone z nadmiaru wilgoci', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Pomidory, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'w cienkich słupkach', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Ogórek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'umyta, dokładnie osuszona, porwana', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Sałata rzymska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'do sosu', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Jogurt grecki naturalny 2%';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       'obrany, bardzo drobno posiekany i roztarty; do sosu', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'umyte, osuszone i drobno posiekane delikatne gałązki; do sosu', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'koperek świeży';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'sok, do sosu', null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'do smażenia kurczaka', null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       'do kurczaka', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       'podzielona między sos i kurczaka', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       'podzielony między sos i kurczaka', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym');

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
         (12::smallint, '**Oliwa.** Odmierz oliwę do smażenia i odstaw przy kuchence.', null::text, false),
         (13::smallint, '**Placki tortilli.** Wyjmij potrzebne placki z opakowania. Przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Podgrzewanie tortilli i smażenie kurczaka', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie patelni.** Rozgrzej suchą patelnię na średnim ogniu przez około 1 minutę.', null::text, false),
         (2::smallint, '**Podgrzanie placków.** Ogrzewaj tortille kolejno po **15–20 sekund z każdej strony**, tylko do zmięknięcia. Odkładaj na talerz i przykrywaj czystą ściereczką.', null::text, false),
         (3::smallint, '**Oliwa na patelnię.** Wlej odmierzoną oliwę na tę samą patelnię. Rozgrzewaj przez około 30 sekund. Jeśli smażysz mięso partiami, podziel oliwę między partie.', null::text, false),
         (4::smallint, '**Smażenie kurczaka.** Rozłóż paski w jednej warstwie. Smaż przez **6–8 minut na średnim ogniu**, obracając co około 2 minuty. Przy większej ilości smaż partiami.', null::text, false),
         (5::smallint, '**Sprawdzenie kurczaka.** Zmierz temperaturę w środku najgrubszego kawałka: powinna wynosić **co najmniej 74°C**. Jeśli jest niższa, dosmażaj **po 1 minucie** i ponawiaj pomiar.', 'temperatura w środku najgrubszego kawałka wynosi co najmniej 74°C'::text, true),
         (6::smallint, '**Zdjęcie mięsa.** Gotowego kurczaka od razu przełóż na czysty talerz, żeby nie wysychał na gorącej patelni.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Składanie i podanie', 4 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Sos na placki.** Wyjmij sos z lodówki i rozdziel między tortille. Rozsmaruj, pozostawiając przy brzegach około 3 cm wolnego miejsca.', null::text, false),
         (2::smallint, '**Nadzienie.** Rozdziel sałatę, paprykę, ogórek, pomidora i kurczaka między placki. Układaj nadzienie na środku.', null::text, false),
         (3::smallint, '**Zwijanie.** Złóż boczne brzegi do środka. Zwiń tortillę od dołu, przytrzymując nadzienie, i ułóż łączeniem w dół. Jeśli część nadzienia się nie mieści, podaj ją obok jako część tego samego posiłku.', null::text, false),
         (4::smallint, '**Podanie.** Przekrój tortille na skos i podaj od razu. Rozdziel całość na przygotowywaną liczbę porcji.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym') and e.kolejnosc = 3;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Sałata.** Umyj liście sałaty, dokładnie osusz i porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w cienkie plastry. Osusz plasterki z nadmiaru wilgoci.', null::text, false),
         (3::smallint, '**Ogórek.** Umyj ogórek i pokrój w cienkie słupki.', null::text, false),
         (4::smallint, '**Awokado.** Umyj awokado, usuń skórkę i pestkę. Pokrój miąższ.', null::text, false),
         (5::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Sos jogurtowy.** Wymieszaj sok z cytryny z jogurtem oraz częścią soli i pieprzu.', null::text, false),
         (7::smallint, '**Kurczak.** Osusz mięso, pokrój w paski grubości około 1 cm. Wymieszaj z oliwą, słodką papryką oraz pozostałą solą i pieprzem.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Tortille.** Wyjmij potrzebne placki i przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie', 13 from przepisy p where lower(p.nazwa) = lower('Tortilla z kurczakiem, awokado i warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie patelni.** Rozgrzej patelnię przez **1 minutę**.', null::text, false),
         (2::smallint, '**Smażenie kurczaka.** Smaż kurczaka przez **6–8 minut** na średnio dużym ogniu, obracając.', 'mięso ma co najmniej 74°C w środku'::text, true),
         (3::smallint, '**Zdjęcie kurczaka.** Przełóż kurczaka na czysty talerz.', null::text, false),
         (4::smallint, '**Ogrzanie tortilli.** Ogrzej tortillę na patelni po **15–20 sekund** na stronę.', null::text, false),
         (5::smallint, '**Nadziewanie.** Posmaruj tortillę sosem, ułóż sałatę, warzywa, awokado i kurczaka.', null::text, false),
         (6::smallint, '**Zwijanie.** Zostaw wolne brzegi, zwiń boki i zroluj.', null::text, false),
         (7::smallint, '**Podanie nadmiaru.** Nadmiar nadzienia podaj obok jako sałatkę.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Kapusta pekińska.** Umyj i osusz kapustę, następnie pokrój w cienkie paski.', null::text, false),
         (2::smallint, '**Ogórek.** Umyj ogórek i pokrój w cienkie słupki.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (4::smallint, '**Tofu.** Odsącz i dokładnie osusz tofu, pokrój w cienkie paski.', null::text, false),
         (5::smallint, '**Limonka.** Umyj limonkę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (6::smallint, '**Sos orzechowy.** Wymieszaj odmierzone masło orzechowe, sos sojowy, sok z limonki i wodę.', null::text, false),
         (7::smallint, '**Sezam.** Odmierz sezam.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Tortille.** Wyjmij potrzebne placki i przykryj, żeby nie wysychały.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie i składanie', 12 from przepisy p where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Smażenie tofu.** Smaż tofu **6–8 minut**, obracając, aż brzegi się zrumienią.', null::text, false),
         (3::smallint, '**Zdjęcie tofu.** Przełóż na talerz.', null::text, false),
         (4::smallint, '**Ogrzanie tortilli.** Ogrzej tortillę na suchej patelni po **15–20 sekund** na stronę.', null::text, false),
         (5::smallint, '**Nadziewanie.** Posmaruj sosem, ułóż tofu i warzywa, posyp sezamem.', null::text, false),
         (6::smallint, '**Zwijanie.** Zawiń boki i zroluj bez przepełniania. Pozostałe tofu i warzywa podaj obok z resztą sosu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Tortilla z tofu i chrupiącymi warzywami') and e.kolejnosc = 2;

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
  'waga', 936, 1, 1,
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       'obrany korzeń, drobna kostka około 3–4 mm; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 45, 'g'::jednostka_miary, 45,
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
         (12::smallint, '**Wyjęcie mięsa.** Gdy mięso będzie miękkie, przełóż je na czysty talerz i przykryj. Sprawdź korzenie w sosie. Jeśli są jeszcze twarde, dogotowuj je bez mięsa po **3 minuty**, w razie potrzeby dolewając trochę gorącej wody.', 'korzenie łatwo rozgniatają się widelcem.'::text, true),
         (13::smallint, '**Blendowanie warzyw - tylko jeżlei lubsiz** Zdejmij rondel z ognia i zblenduj wszystkie warzywa z całym płynem na gładki sos. Trzymaj końcówkę blendera zanurzoną; przy małej ilości przelej sos do wąskiego naczynia do blendowania i po zblendowaniu przelej z powrotem do rondla.', null::text, false),
         (14::smallint, '**Konsystencja - jeżeli blendowałeś** Sos powinien swobodnie spływać z łyżki. Jeśli jest zbyt gęsty, dodawaj po trochu gorącą wodę i mieszaj. Nie odcedzaj warzyw.', null::text, false),
         (15::smallint, '**Hartowanie jogurtu.** Do jogurtu stopniowo dodawaj trochę ciepłego sosu, mieszając do ogrzania i uzyskania jednolitej konsystencji. Wmieszaj zahartowany jogurt do rondla poza ogniem.', null::text, false),
         (16::smallint, '**Chrzan i koperek.** Dodaj pozostałą część chrzanu oraz koperek. Wymieszaj i spróbuj. Po dodaniu jogurtu i końcowej porcji chrzanu nie gotuj już sosu.', null::text, false),
         (17::smallint, '**Podanie.** Włóż mięso wraz z sokami z talerza do ciepłego sosu, wymieszaj delikatnie i podaj z puree oraz fasolką szparagową. Posyp natką pietruszki. Po dodaniu jogurtu nie zagotowuj sosu.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina w sosie chrzanowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Wieprzowina w sosie sojowo-imbirowym
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wieprzowina w sosie sojowo-imbirowym', 'Szybko smażona polędwiczka wieprzowa z chrupiącymi warzywami, imbirem i czosnkiem w sosie sojowym. Podawana z ryżem basmati i sezamem.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 541, 1, 1,
  8, 17,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Mięso z warzywami przechowuj w szczelnym pojemniku w lodówce do 3 dni. Ryż najlepiej przechowywać osobno. Przy odgrzewaniu podgrzewaj krótko na patelni, żeby warzywa nie straciły całkowicie jędrności.',
  false, 'Za słone — sos sojowy jest bardzo słony, nie dosalaj. Ratunek: dorzuć więcej warzyw i ryżu. Warzywa miękkie — smażone za długo.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Polędwiczka wieprzowa, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'obrany, starty', null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Fasolka szparagowa mrożona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'suchy, ugotowany osobno', null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Sezam';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w cienkie paski.', null::text, false),
         (2::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w cienkie półplasterki.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (5::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (6::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (7::smallint, '**Polędwiczka.** Osusz mięso i usuń twardą błonę. Pokrój w poprzek włókien w cienkie plastry. Wymieszaj z jedną trzecią odmierzonego sosu sojowego.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Sezam.** Odmierz sezam.', null::text, false),
         (10::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (11::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false),
         (12::smallint, '**Fasolka szparagowa.** Odmierz mrożoną fasolkę i pozostaw w zamrażarce do gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i smażenie', 17 from przepisy p where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Ryż ugotuj zgodnie z instrukcją na opakowaniu. Gotuj go równolegle podczas przygotowywania mięsa i warzyw.', null::text, false),
         (2::smallint, '**Rozgrzanie oleju.** Na dużej patelni mocno rozgrzej olej.', null::text, false),
         (3::smallint, '**Obsmażenie polędwiczki.** Dodaj polędwiczkę w jednej warstwie i smaż około **1–2 minuty** z każdej strony, tylko do zrumienienia.', null::text, false),
         (4::smallint, '**Zdjęcie mięsa.** Zdejmij mięso z patelni i odłóż.', null::text, false),
         (5::smallint, '**Cebula i marchew.** Na tę samą patelnię dodaj cebulę i marchew. Smaż na dużym ogniu około **2 minut**, często mieszając.', null::text, false),
         (6::smallint, '**Papryka i fasolka.** Dodaj paprykę i mrożoną fasolkę szparagową. Smaż jeszcze około **3–4 minut**. Warzywa powinny się rozgrzać i lekko zmięknąć, ale nadal pozostać jędrne.', null::text, false),
         (7::smallint, '**Czosnek i imbir.** Dodaj czosnek i imbir. Smaż około **30 sekund**, cały czas mieszając.', null::text, false),
         (8::smallint, '**Mięso i sos sojowy.** Włóż mięso z powrotem na patelnię. Dodaj pozostały odmierzony sos sojowy i dokładnie wymieszaj. Sól i pieprz do smaku.', null::text, false),
         (9::smallint, '**Podgrzanie.** Smaż wszystko razem jeszcze około **1 minuty**. Nie smaż dłużej, żeby polędwiczka nie zrobiła się sucha, a warzywa zbyt miękkie.', null::text, false),
         (10::smallint, '**Podanie.** Zdejmij patelnię z ognia, posyp sezamem i podawaj z ugotowanym ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina w sosie sojowo-imbirowym') and e.kolejnosc = 2;

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
  3, 'prywatna',
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (2::smallint, '**Kapusta pekińska.** Umyj kapustę, oddziel grube białe części od liści. Obie części cienko pokrój i odłóż osobno.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w cienkie słupki.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (5::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (6::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (7::smallint, '**Polędwiczka.** Osusz polędwiczkę, usuń twardą błonę i pokrój w paski grubości około 1 cm. Wymieszaj z połową sosu sojowego.', null::text, false),
         (8::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (9::smallint, '**Sezam.** Odmierz sezam.', null::text, false),
         (10::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp ryż i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Ryż — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie polędwiczki.** Smaż mięso **4–5 minut**, obracając, do temperatury co najmniej **63°C**.', null::text, false),
         (5::smallint, '**Odpoczynek mięsa.** Przełóż na czysty talerz na co najmniej **3 minuty**.', null::text, false),
         (6::smallint, '**Twarde części warzyw.** Dodaj pozostałą oliwę, cebulę, marchew i białe części kapusty; smaż **4 minuty**.', null::text, false),
         (7::smallint, '**Czosnek i imbir.** Dodaj imbir i czosnek, smaż **30 sekund**.', null::text, false),
         (8::smallint, '**Liście kapusty.** Dodaj liście kapusty, pozostały sos sojowy i smaż **1–2 minuty**.', null::text, false),
         (9::smallint, '**Podgrzanie mięsa.** Włóż mięso i podgrzewaj **1 minutę**, delikatnie mieszając.', null::text, false),
         (10::smallint, '**Podanie.** Podaj z ryżem i sezamem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wieprzowina z kapustą pekińską i ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Wołowina z brokułami po chińsku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Wołowina z brokułami po chińsku', 'Szybko smażona wołowina z jędrnym brokułem, imbirem, czosnkiem i sosem sojowym, podawana z ryżem basmati. Kluczem jest bardzo gorąca patelnia i krótkie smażenie mięsa.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 439, 1, 1,
  10, 20,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Wołowinę z brokułami przechowuj w szczelnym pojemniku w lodówce do 3 dni. Ryż najlepiej przechowywać osobno.
Przy odgrzewaniu podgrzewaj krótko i na dość dużym ogniu. Brokuł po przechowywaniu będzie nieco mniej chrupiący niż bezpośrednio po przygotowaniu.',
  false, 'Mięso twarde — pokrojone wzdłuż włókien zamiast w poprzek. Wyszło wodniste — patelnia była za zimna albo mięso smażone naraz.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wołowina z brokułami po chińsku'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Wołowina z brokułami po chińsku'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'g'::jednostka_miary, 120,
       'w cienkich paskach w poprzek włókien', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Wołowina na plastry (udziec), surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 180, 'g'::jednostka_miary, 180,
       'podzielony na różyczki', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Brokuł, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'obrany, starty', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'suchy, ugotowany osobno', 'Makaron', sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and sk.nazwa = 'Sezam';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 10 from przepisy p where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Brokuł.** Umyj brokuł i podziel na małe różyczki.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (4::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (5::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (6::smallint, '**Wołowina.** Osusz mięso i pokrój w poprzek włókien w cienkie paski. Dzięki temu łatwiej zmięknie podczas krótkiego smażenia.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Dodatki.** Odmierz sezam i sos sojowy.', null::text, false),
         (9::smallint, '**Olej.** Odmierz olej.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 20 from przepisy p where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marynowanie wołowiny.** Wołowinę wymieszaj z około jedną trzecią sosu sojowego i pozostaw na około **15 minut**.', null::text, false),
         (2::smallint, '**Ryż — równolegle.** W czasie marynowania mięsa ugotuj ryż zgodnie z instrukcją na opakowaniu.', null::text, false),
         (3::smallint, '**Blanszowanie brokułu.** W osobnym garnku zagotuj wodę. Wrzuć brokuł i blanszuj około **2–3 minut**. Powinien lekko zmięknąć, ale nadal pozostać jędrny i intensywnie zielony.', null::text, false),
         (4::smallint, '**Odcedzenie brokułu.** Brokuł odcedź, przelej zimną wodą i bardzo dokładnie osusz. Nadmiar wody spowodowałby duszenie składników na patelni zamiast ich smażenia.', null::text, false),
         (5::smallint, '**Rozgrzanie patelni.** Mocno rozgrzej dużą patelnię lub wok.', null::text, false),
         (6::smallint, '**Smażenie wołowiny.** Dodaj olej, a następnie wołowinę. Smaż na dużym ogniu około **1–2 minut**, szybko mieszając. Jeśli mięso nie mieści się swobodnie w jednej warstwie, smaż je w dwóch partiach.', null::text, false),
         (7::smallint, '**Zdjęcie mięsa.** Zdejmij z patelni.', null::text, false),
         (8::smallint, '**Cebula.** Na tę samą patelnię wrzuć cebulę i smaż około **1 minuty**.', null::text, false),
         (9::smallint, '**Czosnek i imbir.** Dodaj czosnek i imbir i smaż jeszcze około **30 sekund**.', null::text, false),
         (10::smallint, '**Połączenie składników.** Dodaj brokuł oraz usmażoną wołowinę. Wlej pozostały sos sojowy.', null::text, false),
         (11::smallint, '**Podgrzanie.** Smaż wszystko razem na dużym ogniu jeszcze około **1 minuty**, tylko do połączenia smaków i ponownego rozgrzania mięsa. Nie smaż dłużej, żeby wołowina nie zrobiła się twarda, a brokuł miękki.', null::text, false),
         (12::smallint, '**Podanie.** Zdejmij patelnię z ognia, posyp sezamem i podawaj z ugotowanym ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Wołowina z brokułami po chińsku') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Polędwiczka z pieczarkami i boczniakami', 16, 2, 30),
  ('Potrawka z kurczaka, kaszy jęczmiennej i warzyw', 12, 2, 18),
  ('Pstrąg pieczony z warzywami korzeniowymi', 10, 2, 12),
  ('Ryż z pieczarkami, szpinakiem i parmezanem', 13, 2, 21),
  ('Sałatka grecka z grillowanym kurczakiem', 13, 3, 18),
  ('Sałatka makaronowa z mozzarellą i warzywami', 11, 3, 13),
  ('Sałatka z ciecierzycy', 9, 3, 16),
  ('Sałatka z czarnej fasoli, kukurydzy i pomidora', 11, 2, 12),
  ('Sałatka z jajkiem, fetą i warzywami', 8, 3, 10),
  ('Sałatka z jarmużu, jabłka i orzechów', 9, 2, 11),
  ('Sałatka z komosy, buraka i koziego sera', 11, 3, 14),
  ('Sałatka z pieczonym burakiem i fetą', 9, 3, 11),
  ('Sałatka ziemniaczana z tuńczykiem i jajkiem', 13, 4, 23),
  ('Smażony ryż z kurczakiem i jajkiem', 10, 2, 22),
  ('Stek z tuńczyka z fasolką szparagową i ziemniakami', 8, 2, 13),
  ('Szakszuka z mozzarellą', 12, 2, 18),
  ('Tabbouleh z kaszy bulgur i ciecierzycy', 11, 3, 13),
  ('Tofu z brokułem i ryżem', 10, 2, 20),
  ('Tofucznica ze szpinakiem i pomidorem', 9, 2, 13),
  ('Tom kha gai — kokosowa zupa z kurczakiem', 17, 2, 29),
  ('Tortilla z Goudą, szpinakiem i pomidorem', 8, 2, 16),
  ('Tortilla z hummusem i warzywami', 12, 2, 14),
  ('Tortilla z jajkiem i szpinakiem', 8, 2, 15),
  ('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym', 14, 3, 23),
  ('Tortilla z kurczakiem, awokado i warzywami', 12, 2, 16),
  ('Tortilla z tofu i chrupiącymi warzywami', 11, 2, 15),
  ('Wieprzowina w sosie chrzanowym', 16, 2, 32),
  ('Wieprzowina w sosie sojowo-imbirowym', 13, 2, 22),
  ('Wieprzowina z kapustą pekińską i ryżem', 10, 2, 20),
  ('Wołowina z brokułami po chińsku', 9, 2, 21)
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
where lower(p.nazwa) in (lower('Polędwiczka z pieczarkami i boczniakami'), lower('Potrawka z kurczaka, kaszy jęczmiennej i warzyw'), lower('Pstrąg pieczony z warzywami korzeniowymi'), lower('Ryż z pieczarkami, szpinakiem i parmezanem'), lower('Sałatka grecka z grillowanym kurczakiem'), lower('Sałatka makaronowa z mozzarellą i warzywami'), lower('Sałatka z ciecierzycy'), lower('Sałatka z czarnej fasoli, kukurydzy i pomidora'), lower('Sałatka z jajkiem, fetą i warzywami'), lower('Sałatka z jarmużu, jabłka i orzechów'), lower('Sałatka z komosy, buraka i koziego sera'), lower('Sałatka z pieczonym burakiem i fetą'), lower('Sałatka ziemniaczana z tuńczykiem i jajkiem'), lower('Smażony ryż z kurczakiem i jajkiem'), lower('Stek z tuńczyka z fasolką szparagową i ziemniakami'), lower('Szakszuka z mozzarellą'), lower('Tabbouleh z kaszy bulgur i ciecierzycy'), lower('Tofu z brokułem i ryżem'), lower('Tofucznica ze szpinakiem i pomidorem'), lower('Tom kha gai — kokosowa zupa z kurczakiem'), lower('Tortilla z Goudą, szpinakiem i pomidorem'), lower('Tortilla z hummusem i warzywami'), lower('Tortilla z jajkiem i szpinakiem'), lower('Tortilla z kurczakiem i warzywami z sosem czosnkowo-koperkowym'), lower('Tortilla z kurczakiem, awokado i warzywami'), lower('Tortilla z tofu i chrupiącymi warzywami'), lower('Wieprzowina w sosie chrzanowym'), lower('Wieprzowina w sosie sojowo-imbirowym'), lower('Wieprzowina z kapustą pekińską i ryżem'), lower('Wołowina z brokułami po chińsku'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
