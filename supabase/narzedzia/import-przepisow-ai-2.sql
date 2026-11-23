-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: 30 (część 2 z 4)
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
    ('Kurczak pieczony z batatem i brokułem', 'Pierś z kurczaka, surowa', false),
    ('Kurczak pieczony z batatem i brokułem', 'Batat, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Brokuł, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Cebula czerwona, surowa', false),
    ('Kurczak pieczony z batatem i brokułem', 'Oliwa z oliwek extra virgin', false),
    ('Kurczak pieczony z batatem i brokułem', 'Papryka wędzona mielona', false),
    ('Kurczak pieczony z batatem i brokułem', 'Tymianek suszony', false),
    ('Kurczak pieczony z batatem i brokułem', 'Czosnek, surowy', false),
    ('Kurczak pieczony z batatem i brokułem', 'Sól kłodawska', false),
    ('Kurczak pieczony z batatem i brokułem', 'Czarny pieprz mielony', false),
    ('Kurczak po tajsku', 'Pierś z kurczaka, surowa', false),
    ('Kurczak po tajsku', 'Cebula, surowa', false),
    ('Kurczak po tajsku', 'Czosnek, surowy', false),
    ('Kurczak po tajsku', 'Imbir korzeń, surowy', false),
    ('Kurczak po tajsku', 'Marchew, surowa', false),
    ('Kurczak po tajsku', 'Papryka czerwona, surowa', false),
    ('Kurczak po tajsku', 'Cytryna', false),
    ('Kurczak po tajsku', 'Mleko kokosowe light z puszki', false),
    ('Kurczak po tajsku', 'Pasta curry czerwona', false),
    ('Kurczak po tajsku', 'Sos sojowy', false),
    ('Kurczak po tajsku', 'Fasolka szparagowa mrożona', false),
    ('Kurczak po tajsku', 'Ryż basmati, suchy', false),
    ('Kurczak po tajsku', 'Olej rzepakowy rafinowany', false),
    ('Kurczak po tajsku', 'Pietruszka natka', false),
    ('Kurczak po tajsku', 'Sos rybny', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Marchew, surowa', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Cebula, surowa', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Czosnek, surowy', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'woda', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Oliwa z oliwek extra virgin', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Sól kłodawska', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Czarny pieprz mielony', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Pierś z kurczaka, surowa', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Ryż basmati, suchy', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Jogurt grecki naturalny 2%', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Pietruszka natka', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Pietruszka korzeń', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Seler korzeń', false),
    ('Kurczak z ryżem, marchewką i jogurtem greckim', 'Por, surowy', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Soczewica czerwona, sucha', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Passata pomidorowa', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'woda', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Marchew, surowa', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Cebula, surowa', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Czosnek, surowy', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Oliwa z oliwek extra virgin', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Oregano suszone', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Bazylia suszona', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Papryka słodka mielona', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Sól kłodawska', false),
    ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 'Czarny pieprz mielony', false),
    ('Makaron z brokułem i fetą', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z brokułem i fetą', 'Brokuł, surowy', false),
    ('Makaron z brokułem i fetą', 'Ser feta', false),
    ('Makaron z brokułem i fetą', 'Czosnek, surowy', false),
    ('Makaron z brokułem i fetą', 'Oliwa z oliwek extra virgin', false),
    ('Makaron z brokułem i fetą', 'Cytryna', false),
    ('Makaron z brokułem i fetą', 'Papryka ostra mielona', false),
    ('Makaron z brokułem i fetą', 'Czarny pieprz mielony', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Ciecierzyca z puszki, odsączona', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Bazylia świeża', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Orzechy włoskie', false),
    ('Makaron z ciecierzycą, bazylią i orzechami', 'Oliwa z oliwek extra virgin', false),
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
    ('Makaron z indykiem, pieczarkami i jogurtem', 'Oliwa z oliwek extra virgin', false),
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
    ('Makaron z kurczakiem, szpinakiem i pomidorami', 'Oliwa z oliwek extra virgin', false),
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
    ('Makaron z pieczonymi warzywami i mozzarellą', 'Oliwa z oliwek extra virgin', false),
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
    ('Makaron z polędwiczką i pieczarkami', 'Oliwa z oliwek extra virgin', false),
    ('Makaron z polędwiczką i pieczarkami', 'Musztarda', false),
    ('Makaron z polędwiczką i pieczarkami', 'Tymianek suszony', false),
    ('Makaron z polędwiczką i pieczarkami', 'Sól kłodawska', false),
    ('Makaron z polędwiczką i pieczarkami', 'Czarny pieprz mielony', false),
    ('Makaron z ricottą i szpinakiem', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z ricottą i szpinakiem', 'Ser ricotta', false),
    ('Makaron z ricottą i szpinakiem', 'Szpinak, surowy', false),
    ('Makaron z ricottą i szpinakiem', 'Czosnek, surowy', false),
    ('Makaron z ricottą i szpinakiem', 'Oliwa z oliwek extra virgin', false),
    ('Makaron z ricottą i szpinakiem', 'Cytryna', false),
    ('Makaron z ricottą i szpinakiem', 'Gałka muszkatołowa mielona', false),
    ('Makaron z ricottą i szpinakiem', 'Sól kłodawska', false),
    ('Makaron z ricottą i szpinakiem', 'Czarny pieprz mielony', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Tuńczyk w wodzie, odsączony', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Cytryna', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Pietruszka natka', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Czosnek, surowy', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Oliwa z oliwek extra virgin', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Chili suszone', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Sól kłodawska', false),
    ('Makaron z tuńczykiem, cytryną i natką pietruszki', 'Czarny pieprz mielony', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Makaron pełnoziarnisty, suchy', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Wołowina mielona 5% tłuszczu, surowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Passata pomidorowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Marchew, surowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Cebula, surowa', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Czosnek, surowy', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Oliwa z oliwek extra virgin', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Oregano suszone', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Bazylia suszona', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Sól kłodawska', false),
    ('Makaron z wołowiną i sosem pomidorowym', 'Czarny pieprz mielony', false),
    ('Małże w pomidorowym bulionie', 'Małże, surowe', false),
    ('Małże w pomidorowym bulionie', 'Pomidory krojone z puszki', false),
    ('Małże w pomidorowym bulionie', 'woda', false),
    ('Małże w pomidorowym bulionie', 'Seler naciowy, surowy', false),
    ('Małże w pomidorowym bulionie', 'Cebula, surowa', false),
    ('Małże w pomidorowym bulionie', 'Czosnek, surowy', false),
    ('Małże w pomidorowym bulionie', 'Oliwa z oliwek extra virgin', false),
    ('Małże w pomidorowym bulionie', 'Pietruszka natka', false),
    ('Małże w pomidorowym bulionie', 'Chleb żytni razowy', true),
    ('Małże w pomidorowym bulionie', 'Czarny pieprz mielony', false),
    ('Małże w pomidorowym bulionie', 'Marchew, surowa', false),
    ('Małże w pomidorowym bulionie', 'Pietruszka korzeń', false),
    ('Małże w pomidorowym bulionie', 'Por, surowy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Morszczuk, surowy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Passata pomidorowa', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Ryż parboiled, suchy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Cebula, surowa', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Czosnek, surowy', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Oliwa z oliwek extra virgin', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Papryka słodka mielona', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Oregano suszone', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Pietruszka natka', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Sól kłodawska', false),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Czarny pieprz mielony', false),
    ('Omlet z pieczarkami', 'Jaja kurze, całe, surowe', true),
    ('Omlet z pieczarkami', 'Pieczarki, surowe', false),
    ('Omlet z pieczarkami', 'Cebula, surowa', false),
    ('Omlet z pieczarkami', 'Szpinak mrożony', false),
    ('Omlet z pieczarkami', 'Oliwa z oliwek extra virgin', false),
    ('Omlet z pieczarkami', 'Chleb żytni razowy', true),
    ('Omlet z pieczarkami', 'Sól kłodawska', false),
    ('Omlet z pieczarkami', 'Czarny pieprz mielony', false),
    ('Omlet ze szpinakiem i fetą', 'Jaja kurze, całe, surowe', true),
    ('Omlet ze szpinakiem i fetą', 'Szpinak, surowy', false),
    ('Omlet ze szpinakiem i fetą', 'Ser feta', false),
    ('Omlet ze szpinakiem i fetą', 'Oliwa z oliwek extra virgin', false),
    ('Omlet ze szpinakiem i fetą', 'Chleb żytni razowy', true),
    ('Omlet ze szpinakiem i fetą', 'Sól kłodawska', false),
    ('Omlet ze szpinakiem i fetą', 'Czarny pieprz mielony', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Gulasz wieprzowy, surowy', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Cebula, surowa', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Czosnek, surowy', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Marchew, surowa', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Papryka czerwona, surowa', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Passata pomidorowa', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Kasza gryczana, sucha', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Kapusta kiszona', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Olej rzepakowy rafinowany', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Papryka słodka mielona', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'liść laurowy', true),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'ziele angielskie', true),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'woda', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Czarny pieprz mielony', false),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Sól kłodawska', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Papryka czerwona, surowa', true),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Soczewica brązowa, sucha', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Passata pomidorowa', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Cebula, surowa', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Czosnek, surowy', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Oliwa z oliwek extra virgin', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Kmin rzymski mielony', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Pietruszka natka', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Sól kłodawska', false),
    ('Papryka faszerowana soczewicą i kaszą bulgur', 'Czarny pieprz mielony', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Mąka orkiszowa pełnoziarnista', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Jaja kurze, całe, surowe', true),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Mleko 2%', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Skyr naturalny', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Borówki amerykańskie', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Oliwa z oliwek extra virgin', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Miód', false),
    ('Pełnoziarniste placuszki ze skyrem i owocami', 'Cynamon mielony', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Makrela atlantycka, surowa', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Buraki, surowe', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Ziemniaki, surowe', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Cebula czerwona, surowa', false),
    ('Pieczona makrela z burakami i ziemniakami', 'Oliwa z oliwek extra virgin', false),
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
    ('Pieczone warzywa korzeniowe z tymiankiem', 'Oliwa z oliwek extra virgin', false),
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
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Oliwa z oliwek extra virgin', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Oregano suszone', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Sól kłodawska', false),
    ('Pieczony bakłażan z ciecierzycą i fetą', 'Czarny pieprz mielony', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Kalafior, surowy', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Jogurt grecki naturalny 2%', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Oliwa z oliwek extra virgin', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Cytryna', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Czosnek, surowy', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Pietruszka natka', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Kmin rzymski mielony', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Papryka wędzona mielona', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Sól kłodawska', false),
    ('Pieczony kalafior z ziołowym sosem jogurtowym', 'Czarny pieprz mielony', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Schab wieprzowy, surowy', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Marchew, surowa', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Pietruszka korzeń', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Seler korzeń', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Ziemniaki, surowe', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Czosnek, surowy', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Oliwa z oliwek extra virgin', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Majeranek suszony', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Tymianek suszony', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Sól kłodawska', false),
    ('Pieczony schab z warzywami korzeniowymi', 'Czarny pieprz mielony', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Łosoś dziki, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Brokuł, surowy', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Ziemniaki, surowe', false),
    ('Pieczony łosoś z brokułem i ziemniakami', 'Oliwa z oliwek extra virgin', false),
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
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Oliwa z oliwek extra virgin', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Ocet jabłkowy', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Cynamon mielony', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Goździki suszone', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Sól kłodawska', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Czarny pieprz mielony', false),
    ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 'woda', false),
    ('Pierś z kurczaka z grilla', 'Pierś z kurczaka, surowa', false),
    ('Pierś z kurczaka z grilla', 'Oliwa z oliwek extra virgin', false),
    ('Pierś z kurczaka z grilla', 'Czosnek, surowy', false),
    ('Pierś z kurczaka z grilla', 'Sól kłodawska', false),
    ('Pierś z kurczaka z grilla', 'Papryka słodka mielona', false),
    ('Placuszki bananowo-owsiane', 'Banan', true),
    ('Placuszki bananowo-owsiane', 'Jaja kurze, całe, surowe', true),
    ('Placuszki bananowo-owsiane', 'Mąka owsiana pełnoziarnista', false),
    ('Placuszki bananowo-owsiane', 'Mleko 2%', false),
    ('Placuszki bananowo-owsiane', 'Jogurt naturalny 2%', false),
    ('Placuszki bananowo-owsiane', 'Oliwa z oliwek extra virgin', false),
    ('Placuszki bananowo-owsiane', 'Cynamon mielony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa, surowa', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Kasza bulgur, sucha', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Pieczarki, surowe', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Jogurt grecki naturalny 2%', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Musztarda', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Cebula, surowa', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'woda', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Oliwa z oliwek extra virgin', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Tymianek suszony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Sól kłodawska', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Czarny pieprz mielony', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Pietruszka korzeń', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Seler korzeń', false),
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Por, surowy', false)
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
    ('Kurczak pieczony z batatem i brokułem', 'Piekarnik'),
    ('Kurczak pieczony z batatem i brokułem', 'Blacha do pieczenia'),
    ('Kurczak pieczony z batatem i brokułem', 'Nóż szefa kuchni'),
    ('Kurczak pieczony z batatem i brokułem', 'Deska do krojenia'),
    ('Kurczak pieczony z batatem i brokułem', 'Waga kuchenna'),
    ('Kurczak pieczony z batatem i brokułem', 'Termometr do mięsa'),
    ('Kurczak po tajsku', 'Patelnia 28 cm'),
    ('Kurczak po tajsku', 'Garnek 2 l'),
    ('Kurczak po tajsku', 'Tarka o drobnych oczkach'),
    ('Kurczak po tajsku', 'Nóż szefa kuchni'),
    ('Kurczak po tajsku', 'Deska do krojenia'),
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
    ('Małże w pomidorowym bulionie', 'Tarka o drobnych oczkach'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Patelnia 28 cm'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Garnek 2 l'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Nóż szefa kuchni'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Deska do krojenia'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Waga kuchenna'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Sitko'),
    ('Morszczuk w sosie pomidorowym z ryżem', 'Termometr do mięsa'),
    ('Omlet z pieczarkami', 'Patelnia 24 cm'),
    ('Omlet z pieczarkami', 'Nóż szefa kuchni'),
    ('Omlet z pieczarkami', 'Deska do krojenia'),
    ('Omlet ze szpinakiem i fetą', 'Patelnia 24 cm'),
    ('Omlet ze szpinakiem i fetą', 'Miska'),
    ('Omlet ze szpinakiem i fetą', 'Widelec'),
    ('Omlet ze szpinakiem i fetą', 'Nóż szefa kuchni'),
    ('Omlet ze szpinakiem i fetą', 'Deska do krojenia'),
    ('Omlet ze szpinakiem i fetą', 'Waga kuchenna'),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Garnek 4 l'),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Nóż szefa kuchni'),
    ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Deska do krojenia'),
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
    ('Pieczony schab z warzywami korzeniowymi', 'Piekarnik'),
    ('Pieczony schab z warzywami korzeniowymi', 'Naczynie żaroodporne'),
    ('Pieczony schab z warzywami korzeniowymi', 'Nóż szefa kuchni'),
    ('Pieczony schab z warzywami korzeniowymi', 'Deska do krojenia'),
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
    ('Pierś z kurczaka z grilla', 'Grill kontaktowy'),
    ('Pierś z kurczaka z grilla', 'Deska do krojenia'),
    ('Pierś z kurczaka z grilla', 'Nóż szefa kuchni'),
    ('Pierś z kurczaka z grilla', 'Termometr do mięsa'),
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
    ('Polędwiczka w sosie musztardowym z kaszą bulgur', 'Tarka o drobnych oczkach')
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Batat.** Umyj i obierz batata, pokrój w kostkę około 2 cm.', null::text, false),
         (2::smallint, '**Brokuł.** Umyj brokuł i podziel na małe różyczki.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Doprawienie warzyw.** Podziel oliwę między batata z cebulą, brokuł i kurczaka. Warzywa wymieszaj oddzielnie ze swoją częścią oliwy, tymianku, papryki, soli i pieprzu.', null::text, false),
         (6::smallint, '**Kurczak.** Osusz pierś i wyrównaj grubość do około 2–3 cm. Natrzyj oliwą, czosnkiem i pozostałymi przyprawami.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz wędzoną paprykę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 47 from przepisy p where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **210°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Batat i cebula.** Rozłóż batata i cebulę na blasze. Piecz **15 minut**.', null::text, false),
         (3::smallint, '**Kurczak i brokuł.** Dodaj kurczaka i brokuł, układając luźno. Piecz **18–22 minuty**.', null::text, false),
         (4::smallint, '**Sprawdzenie mięsa.** Sprawdź mięso termometrem w najgrubszym miejscu; gotowego kurczaka zdejmij. Niedopieczone warzywa dopiekaj osobno przez kolejne **5 minut**.', 'kurczak ma co najmniej 74°C, batat miękki, brokuł lekko rumiany'::text, true),
         (5::smallint, '**Podanie.** Podaj mięso z warzywami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak pieczony z batatem i brokułem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Kurczak po tajsku
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Kurczak po tajsku', 'Kurczak z warzywami w sosie z czerwonej pasty curry i mleka kokosowego, podawany z ryżem basmati. Pastę curry warto podsmażyć w tłuszczu przed dodaniem mleka kokosowego, a sok z cytryny dodać dopiero na końcu.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['azjatycka']::rodzaj_kuchni[],
  array['gulasz_curry']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 628, 1, 1,
  8, 25,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 28 cm', 'Garnek 2 l', 'Tarka o drobnych oczkach', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Ryż najlepiej przechowywać w osobnym pojemniku.',
  false, 'Jeśli sos się rozwarstwi, zdejmij patelnię z ognia i wmieszaj niewielką ilość zimnego mleka kokosowego. Jeśli danie jest zbyt ostre, dodaj trochę mleka kokosowego. Jeśli jest zbyt mdłe, dodaj niewielką ilość soku z cytryny.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kurczak po tajsku'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Kurczak po tajsku'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 110, 'g'::jednostka_miary, 110,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 40, 'g'::jednostka_miary, 40,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 8, 'g'::jednostka_miary, 8,
       'obrany, starty', null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Imbir korzeń, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 70, 'g'::jednostka_miary, 70,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'sok', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Cytryna';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'ml'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Mleko kokosowe light z puszki';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 15, 'g'::jednostka_miary, 15,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Pasta curry czerwona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 12, 'ml'::jednostka_miary, 12,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Sos sojowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Fasolka szparagowa mrożona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 55, 'g'::jednostka_miary, 55,
       'suchy, ugotowany osobno', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Ryż basmati, suchy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       'posiekana', null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Pietruszka natka';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak po tajsku') and sk.nazwa = 'Sos rybny';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 8 from przepisy p where lower(p.nazwa) = lower('Kurczak po tajsku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Imbir.** Obierz imbir i zetrzyj na drobnej tarce.', null::text, false),
         (4::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w cienkie półplasterki.', null::text, false),
         (5::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój miąższ w cienkie paski.', null::text, false),
         (6::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (7::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (8::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (9::smallint, '**Kurczak.** Osusz pierś i pokrój w paski szerokości około 1,5 cm.', null::text, false),
         (10::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (11::smallint, '**Płynna baza.** Odmierz mleko kokosowe.', null::text, false),
         (12::smallint, '**Dodatki.** Odmierz sos sojowy, sos rybny i pastę curry.', null::text, false),
         (13::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (14::smallint, '**Fasolka szparagowa.** Odmierz mrożoną fasolkę i pozostaw w zamrażarce do gotowania.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak po tajsku') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Ryż i obsmażanie kurczaka', 10 from przepisy p where lower(p.nazwa) = lower('Kurczak po tajsku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Nastaw ryż i ugotuj go zgodnie z instrukcją na opakowaniu. Ryż będzie gotował się równolegle z przygotowaniem kurczaka.', null::text, false),
         (2::smallint, '**Rozgrzanie oleju.** Na patelni rozgrzej olej.', null::text, false),
         (3::smallint, '**Obsmażenie kurczaka.** Dodaj kurczaka i smaż na dość dużym ogniu przez około **3–4 minuty**.', null::text, false),
         (4::smallint, '**Zdjęcie kurczaka.** Następnie zdejmij mięso z patelni i odłóż na bok.', null::text, false),
         (5::smallint, '**Cebula.** Na tę samą patelnię dodaj cebulę i smaż około **2 minut**.', null::text, false),
         (6::smallint, '**Czosnek i imbir.** Dodaj czosnek i starty imbir. Smaż około **30 sekund**.', null::text, false),
         (7::smallint, '**Pasta curry.** Dodaj niewielką część odmierzonego mleka kokosowego, a następnie pastę curry. Smaż na średnim ogniu przez około **30–60 sekund**, cały czas mieszając, aż pasta zacznie intensywnie pachnieć.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak po tajsku') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Warzywa, sos i wykończenie', 15 from przepisy p where lower(p.nazwa) = lower('Kurczak po tajsku');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew i papryka.** Dodaj marchew i paprykę. Smaż około **2 minut**.', null::text, false),
         (2::smallint, '**Mleko kokosowe i dodatki.** Wlej pozostałe mleko kokosowe, wymieszaj, dodaj sos rybny i znowu wymieszaj. Dodaj podsmażonego kurczaka oraz mrożoną fasolkę szparagową.', null::text, false),
         (3::smallint, '**Duszenie curry.** Duś bez przykrycia przez około **12–15 minut**, aż kurczak będzie gotowy, warzywa zmiękną, ale pozostaną lekko jędrne, a sos nieco zgęstnieje.', null::text, false),
         (4::smallint, '**Doprawienie.** Zdejmij patelnię z ognia. Dodaj sos sojowy oraz sok z cytryny. Wymieszaj i spróbuj.', null::text, false),
         (5::smallint, '**Podanie.** Podawaj z ugotowanym ryżem basmati i posyp posiekaną natką pietruszki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Kurczak po tajsku') and e.kolejnosc = 3;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Kurczak z ryżem, marchewką i jogurtem greckim') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (4::smallint, '**Cebula.** Na tę samą patelnię dodaj pozostałą oliwę i cebulę. Smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Marchew.** Umyj i obierz marchew, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Soczewica.** Odmierz soczewicę i opłucz na sitku.', null::text, false),
         (5::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (6::smallint, '**Płynna baza.** Odmierz passatę i wodę z listy składników.', null::text, false),
         (7::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (8::smallint, '**Przyprawy.** Odmierz sól, pieprz, słodką paprykę, oregano i suszoną bazylię.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie sosu i makaronu', 35 from przepisy p where lower(p.nazwa) = lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę w garnku przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula i marchew.** Smaż cebulę i marchew **5 minut**.', null::text, false),
         (3::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, oregano, bazylię i paprykę; smaż **30 sekund**.', null::text, false),
         (4::smallint, '**Gotowanie soczewicy.** Dodaj soczewicę oraz odmierzoną wodę. Doprowadź do wrzenia przez około **2 minuty** i gotuj pod uchyloną pokrywką **12–15 minut**, często mieszając. Uzupełnij odparowaną wodę, jeżeli soczewica jeszcze nie zmiękła.', null::text, false),
         (5::smallint, '**Makaron — równolegle.** Już podczas gotowania soczewicy nastaw wodę na makaron na drugim palniku. Ugotuj go przez czas z opakowania tak, aby był gotowy pod koniec gotowania sosu; zachowaj nieco wody przed odcedzeniem.', null::text, false),
         (6::smallint, '**Passata do soczewicy.** Do miękkiej soczewicy dodaj passatę i gotuj sos **10 minut** bez przykrycia.', null::text, false),
         (7::smallint, '**Połączenie i doprawienie.** Wymieszaj sos z makaronem, dopraw solą i pieprzem. W razie potrzeby rozluźnij wodą z makaronu.', 'soczewica miękka, sos oblepia makaron'::text, true)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Brokuł.** Umyj brokuł i podziel na małe różyczki. Obierz miękki środek łodygi i pokrój go drobno.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (6::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (7::smallint, '**Przyprawy.** Odmierz pieprz i ostrą paprykę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z brokułem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i łączenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z brokułem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Makaron i brokuł.** Zagotuj wodę i gotuj makaron przez czas z opakowania. Na ostatnie **4 minuty** dodaj małe różyczki i cienko pokrojoną łodygę brokułu.', null::text, false),
         (2::smallint, '**Odcedzenie.** Zachowaj trochę wody z gotowania i odcedź makaron z brokułem.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy — równolegle.** Pod koniec gotowania makaronu rozgrzej oliwę na patelni przez **1 minutę**.', null::text, false),
         (4::smallint, '**Czosnek i papryka.** Dodaj czosnek i ostrą paprykę, smaż **20–30 sekund**.', null::text, false),
         (5::smallint, '**Połączenie makaronu.** Dodaj makaron z brokułem, fetę i odrobinę zachowanej wody. Mieszaj na małym ogniu przez **1 minutę**.', null::text, false),
         (6::smallint, '**Doprawienie.** Zdejmij z ognia i dodaj sok z cytryny oraz pieprz.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ciecierzyca.** Przełóż ciecierzycę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w kostkę.', null::text, false),
         (3::smallint, '**Bazylia.** Umyj i osusz bazylię, oderwij liście od łodyg.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek; zostanie zblendowany w sosie.', null::text, false),
         (5::smallint, '**Orzechy.** Odmierz orzechy włoskie i grubo posiekaj.', null::text, false),
         (6::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (7::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól i pieprz.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i przygotowanie sosu', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z ciecierzycą, bazylią i orzechami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie makaronu.** Ugotuj makaron przez czas z opakowania. Przed odcedzeniem zachowaj nieco wody z gotowania.', null::text, false),
         (2::smallint, '**Sos bazyliowy — równolegle.** Podczas gotowania makaronu zblenduj bazylię, orzechy, oliwę, czosnek, sok z cytryny, sól i pieprz. Rozluźnij sos niewielką ilością ciepłej, nie wrzącej wody z makaronu.', null::text, false),
         (3::smallint, '**Ciecierzyca.** Na ostatnie **2 minuty** gotowania makaronu dodaj ciecierzycę do garnka. Odcedź całość.', null::text, false),
         (4::smallint, '**Połączenie i podanie.** Poza ogniem wymieszaj makaron i ciecierzycę z sosem oraz pokrojonymi pomidorami. Podaj bez dodatkowego gotowania bazylii.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Indyk.** Osusz indyka i pokrój w paski grubości około 1 cm.', null::text, false),
         (5::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (6::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (7::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól, pieprz i tymianek.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Makaron z indykiem, pieczarkami i jogurtem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Makaron — równolegle.** Zagotuj wodę i wsyp makaron. Gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku.', null::text, false),
         (2::smallint, '**Makaron — po minutniku.** Sprawdź, czy makaron jest gotowy. Zachowaj trochę wody z gotowania, a następnie odcedź makaron. Zrób to po minutniku, niezależnie od postępu przygotowania sosu.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na drugim palniku rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie indyka.** Smaż indyka **5–6 minut**, obracając, do temperatury co najmniej **74°C**.', null::text, false),
         (5::smallint, '**Zdjęcie indyka.** Zdejmij na czysty talerz.', null::text, false),
         (6::smallint, '**Pieczarki i cebula.** Dodaj pozostałą oliwę, cebulę i pieczarki; smaż **7–9 minut**, aż woda odparuje.', null::text, false),
         (7::smallint, '**Czosnek i tymianek.** Dodaj czosnek i tymianek, smaż **30 sekund**.', null::text, false),
         (8::smallint, '**Hartowanie jogurtu.** W misce połącz jogurt z niewielką ilością ciepłej wody z makaronu, dodawanej stopniowo.', null::text, false),
         (9::smallint, '**Połączenie makaronu.** Do patelni dodaj makaron i indyka, podgrzej przez **1 minutę**.', null::text, false),
         (10::smallint, '**Jogurt i doprawienie.** Zdejmij z ognia, odczekaj około **1 minuty**, wmieszaj jogurt i dopraw solą oraz pieprzem. Nie zagotowuj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Kurczak.** Osusz kurczaka i pokrój w paski grubości około 1 cm.', null::text, false),
         (5::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (6::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (7::smallint, '**Płynna baza.** Odmierz passatę i pomidory z puszki.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól, pieprz, oregano i suszoną bazylię.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie makaronu i sosu', 25 from przepisy p where lower(p.nazwa) = lower('Makaron z kurczakiem, szpinakiem i pomidorami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Makaron — równolegle.** Zagotuj wodę i wsyp makaron. Gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku.', null::text, false),
         (2::smallint, '**Makaron — po minutniku.** Sprawdź, czy makaron jest gotowy. Zachowaj trochę wody z gotowania, a następnie odcedź makaron. Zrób to po minutniku, niezależnie od postępu przygotowania sosu.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę na drugim palniku przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie kurczaka.** Smaż kurczaka **5–6 minut** do temperatury co najmniej **74°C**, obracając.', null::text, false),
         (5::smallint, '**Zdjęcie kurczaka.** Zdejmij na czysty talerz.', null::text, false),
         (6::smallint, '**Cebula.** Na tej samej patelni smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli. Gdy przywiera, dodaj odrobinę wody z makaronu.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (7::smallint, '**Czosnek.** Dodaj czosnek, smaż **30 sekund**.', null::text, false),
         (8::smallint, '**Sos pomidorowy.** Dodaj pomidory, passatę, oregano i bazylię suszoną. Doprowadź do łagodnego wrzenia i gotuj przez **8 minut**.', null::text, false),
         (9::smallint, '**Szpinak.** Dodaj szpinak, gotuj **1–2 minuty** do zwiędnięcia.', null::text, false),
         (10::smallint, '**Połączenie makaronu.** Włóż kurczaka oraz odcedzony makaron, podgrzej przez **1 minutę**. Dopraw solą i pieprzem.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Cukinia.** Umyj cukinię i pokrój na kawałki około 2 cm.', null::text, false),
         (2::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój na kawałki około 2 cm.', null::text, false),
         (3::smallint, '**Pomidory.** Umyj pomidory i pokrój na kawałki około 2 cm.', null::text, false),
         (4::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (5::smallint, '**Bazylia.** Umyj i osusz bazylię, oderwij liście od łodyg.', null::text, false),
         (6::smallint, '**Mozzarella.** Odsącz mozzarellę i porwij na mniejsze kawałki.', null::text, false),
         (7::smallint, '**Warzywa do pieczenia.** Wymieszaj warzywa z odmierzoną oliwą, oregano, solą i pieprzem.', null::text, false),
         (8::smallint, '**Makaron.** Odmierz makaron.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie', 42 from przepisy p where lower(p.nazwa) = lower('Makaron z pieczonymi warzywami i mozzarellą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **210°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie warzyw.** Rozłóż warzywa luźno na blasze i piecz **25–30 minut**, obracając w połowie.', null::text, false),
         (3::smallint, '**Makaron — równolegle.** W czasie pieczenia ugotuj makaron przez czas z opakowania. Zachowaj nieco wody i odcedź. Zakończ gotowanie makaronu możliwie blisko końca pieczenia.', null::text, false),
         (4::smallint, '**Połączenie i podanie.** Połącz gorący makaron z warzywami, płynem z blachy i mozzarellą. Dodaj bazylię. W razie potrzeby rozluźnij zachowaną wodą.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Polędwiczka.** Osusz polędwiczkę, usuń twardą błonę i pokrój w paski grubości około 1 cm.', null::text, false),
         (5::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (6::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (7::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (8::smallint, '**Musztarda.** Odmierz musztardę.', null::text, false),
         (9::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (10::smallint, '**Przyprawy.** Odmierz sól, pieprz i tymianek.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i smażenie', 25 from przepisy p where lower(p.nazwa) = lower('Makaron z polędwiczką i pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Makaron — równolegle.** Zagotuj wodę i wsyp makaron. Gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku.', null::text, false),
         (2::smallint, '**Makaron — po minutniku.** Sprawdź, czy makaron jest gotowy. Zachowaj trochę wody z gotowania, a następnie odcedź makaron. Zrób to po minutniku, niezależnie od postępu przygotowania sosu.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na drugim palniku rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (4::smallint, '**Smażenie polędwiczki.** Smaż mięso przez **4–5 minut**, obracając.', null::text, false),
         (5::smallint, '**Sprawdzenie i odpoczynek.** Sprawdź temperaturę: co najmniej **63°C**. Przełóż na czysty talerz i pozostaw na co najmniej **3 minuty**.', null::text, false),
         (6::smallint, '**Pieczarki i cebula.** Dodaj pozostałą oliwę, cebulę i pieczarki. Smaż **7–9 minut**, aż woda odparuje.', null::text, false),
         (7::smallint, '**Czosnek i tymianek.** Dodaj czosnek i tymianek, smaż **30 sekund**.', null::text, false),
         (8::smallint, '**Sos jogurtowy.** W misce wymieszaj jogurt, musztardę i niewielką ilość ciepłej wody z makaronu.', null::text, false),
         (9::smallint, '**Połączenie makaronu.** Do patelni dodaj makaron i mięso, podgrzej **1 minutę**.', null::text, false),
         (10::smallint, '**Jogurt i doprawienie.** Zdejmij z ognia, odczekaj około **1 minuty** i dodaj sos jogurtowy. Dopraw solą i pieprzem; nie zagotowuj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (4::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (5::smallint, '**Ricotta.** Odmierz ricottę.', null::text, false),
         (6::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (7::smallint, '**Przyprawy.** Odmierz sól, pieprz i gałkę muszkatołową.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i łączenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z ricottą i szpinakiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Makaron — równolegle.** Zagotuj wodę i wsyp makaron. Gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku.', null::text, false),
         (2::smallint, '**Makaron — po minutniku.** Sprawdź, czy makaron jest gotowy. Zachowaj trochę wody z gotowania, a następnie odcedź makaron. Zrób to po minutniku, niezależnie od postępu przygotowania sosu.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Na ostatnie minuty gotowania makaronu rozgrzej oliwę na patelni przez **1 minutę**.', null::text, false),
         (4::smallint, '**Czosnek.** Dodaj czosnek, smaż **20–30 sekund**.', null::text, false),
         (5::smallint, '**Szpinak.** Dodaj szpinak i smaż **1–2 minuty**, tylko do zwiędnięcia.', null::text, false),
         (6::smallint, '**Ricotta.** Zmniejsz ogień, dodaj ricottę, gałkę i trochę wody z makaronu.', null::text, false),
         (7::smallint, '**Połączenie makaronu.** Dodaj makaron, wymieszaj na małym ogniu przez **1 minutę**.', null::text, false),
         (8::smallint, '**Doprawienie.** Zdejmij z ognia, dodaj sok z cytryny, sól i pieprz.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Tuńczyk.** Odsącz tuńczyka i lekko rozdrobnij widelcem. Odmierz po odsączeniu.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (6::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (7::smallint, '**Przyprawy.** Odmierz sól, pieprz i chili.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie i łączenie', 20 from przepisy p where lower(p.nazwa) = lower('Makaron z tuńczykiem, cytryną i natką pietruszki');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Makaron — równolegle.** Zagotuj wodę i wsyp makaron. Gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie przygotowuj sos na drugim palniku.', null::text, false),
         (2::smallint, '**Makaron — po minutniku.** Sprawdź, czy makaron jest gotowy. Zachowaj trochę wody z gotowania, a następnie odcedź makaron. Zrób to po minutniku, niezależnie od postępu przygotowania sosu.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Gdy do końca gotowania makaronu pozostaje około **4 minut**, rozgrzej oliwę na drugim palniku przez **1 minutę**.', null::text, false),
         (4::smallint, '**Czosnek i chili.** Dodaj czosnek i chili; podgrzewaj **20–30 sekund**.', null::text, false),
         (5::smallint, '**Makaron z tuńczykiem.** Dodaj tuńczyka, makaron i niewielką ilość zachowanej wody. Podgrzewaj na małym ogniu przez **1–2 minuty**, delikatnie mieszając.', null::text, false),
         (6::smallint, '**Doprawienie i podanie.** Zdejmij z ognia. Dodaj sok z cytryny, natkę, sól i pieprz. Podaj.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Marchew.** Umyj i obierz marchew, zetrzyj na tarce o grubych oczkach.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Wołowina.** Odmierz mięso mielone do osobnego naczynia.', null::text, false),
         (5::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (6::smallint, '**Makaron.** Odmierz makaron.', null::text, false),
         (7::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól, pieprz, oregano i suszoną bazylię.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie sosu i makaronu', 37 from przepisy p where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula i marchew.** Smaż cebulę i marchew **4 minuty**.', null::text, false),
         (3::smallint, '**Smażenie wołowiny.** Dodaj mięso i smaż **6–7 minut**, rozdzielając grudki.', null::text, false),
         (4::smallint, '**Czosnek.** Dodaj czosnek i smaż **30 sekund**.', null::text, false),
         (5::smallint, '**Gotowanie sosu.** Dodaj passatę, oregano oraz bazylię suszoną. Doprowadź do wrzenia i gotuj łagodnie przez **18–20 minut**, mieszając.', null::text, false),
         (6::smallint, '**Makaron — równolegle.** W czasie gotowania sosu ugotuj makaron przez czas z opakowania na drugim palniku, następnie odcedź.', null::text, false),
         (7::smallint, '**Sprawdzenie i podanie.** Sprawdź sos, dopraw solą i pieprzem i podaj z makaronem.', 'wołowina jest rozdrobniona i ugotowana, sos gęsty; mięso co najmniej 71°C'::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Makaron z wołowiną i sosem pomidorowym') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Małże w pomidorowym bulionie') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ryż.** Odmierz suchy ryż i przepłucz na sitku pod zimną wodą.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (5::smallint, '**Morszczuk.** Osusz rozmrożony filet i usuń ości. Podziel na podobne kawałki grubości około 2–3 cm. Dopraw częścią soli i pieprzu.', null::text, false),
         (6::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false),
         (7::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz słodką paprykę i oregano.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie ryżu i duszenie ryby', 30 from przepisy p where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Ryż — równolegle.** Zagotuj na pierwszym palniku tyle wody, aby ziarna swobodnie się gotowały. Wsyp ryż i gotuj przez czas z opakowania. Nastaw minutnik; w tym czasie wykonuj kolejne kroki na drugim palniku.', null::text, false),
         (2::smallint, '**Ryż — po minutniku.** Po upływie czasu sprawdź miękkość ziaren i odcedź nadmiar wody. Przykryj garnek i odstaw poza palnik. Zrób to niezależnie od postępu pracy przy pozostałych składnikach.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę na drugim palniku przez **1 minutę**.', null::text, false),
         (4::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (5::smallint, '**Czosnek i przyprawy.** Dodaj czosnek, paprykę i oregano, smaż **30 sekund**.', null::text, false),
         (6::smallint, '**Sos pomidorowy.** Dodaj passatę, doprowadź do łagodnego wrzenia przez około **2 minuty** i gotuj **10 minut**.', null::text, false),
         (7::smallint, '**Duszenie morszczuka.** Włóż rybę do sosu, polej sosem i duś pod przykryciem przez **8–10 minut**, bez energicznego mieszania.', 'ryba ma co najmniej 63°C, jest nieprzezroczysta i rozdziela się na płatki'::text, true),
         (8::smallint, '**Doprawienie i podanie.** Dodaj natkę, dopraw pozostałą solą i pieprzem. Podaj z ryżem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Morszczuk w sosie pomidorowym z ryżem') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Omlet z pieczarkami
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Omlet z pieczarkami', 'Sycący omlet z pieczarkami, szpinakiem i cebulą, podawany z pieczywem żytnim. Prosty, szybki posiłek z dużą ilością warzyw i białka.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['kolacja', 'sniadanie']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  array['jajka']::rodzaj_dania[],
  0, 'prywatna',
  'waga', 581, 1, 1,
  5, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Patelnia 24 cm', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Jedz od razu. Odgrzewany omlet jest gumowaty.',
  false, 'Nie chce się złożyć — patelnia za mała albo masa za rzadka. Podaj jako jajecznicę, smakuje tak samo.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Omlet z pieczarkami'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Omlet z pieczarkami'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Jaja kurze, całe, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'w plastrach', null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Pieczarki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Szpinak mrożony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Chleb żytni razowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet z pieczarkami') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 5 from przepisy p where lower(p.nazwa) = lower('Omlet z pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Pieczarki.** Oczyść pieczarki i pokrój w cienkie plasterki.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Jajka.** Wbij jajka do miski, roztrzep widelcem i dopraw solą oraz pieprzem.', null::text, false),
         (4::smallint, '**Szpinak.** Odmierz mrożony szpinak i pozostaw w zamrażarce do smażenia.', null::text, false),
         (5::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (6::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet z pieczarkami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie omletu', 15 from przepisy p where lower(p.nazwa) = lower('Omlet z pieczarkami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Na patelni rozgrzej oliwę.', null::text, false),
         (2::smallint, '**Pieczarki i cebula.** Dodaj cebulę i pieczarki. Smaż około **4–5 minut**, aż pieczarki lekko się zarumienią, a większość wody odparuje.', null::text, false),
         (3::smallint, '**Szpinak.** Dodaj mrożony szpinak i smaż jeszcze około **2–3 minuty**, aż się rozmrozi i nadmiar płynu odparuje.', null::text, false),
         (4::smallint, '**Masa jajeczna.** Zmniejsz ogień i wlej roztrzepane jajka. Rozprowadź je równomiernie po patelni.', null::text, false),
         (5::smallint, '**Smażenie omletu.** Przykryj patelnię i smaż na małym ogniu około **4–5 minut**, aż masa jajeczna będzie prawie całkowicie ścięta.', null::text, false),
         (6::smallint, '**Złożenie omletu.** Złóż omlet na pół i pozostaw na patelni jeszcze około **1 minuty**.', null::text, false),
         (7::smallint, '**Podanie.** Podawaj od razu z pieczywem żytnim.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet z pieczarkami') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Szpinak.** Umyj i odsącz szpinak. Usuń grube łodygi, duże liście porwij na mniejsze kawałki.', null::text, false),
         (2::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (3::smallint, '**Jajka.** Wbij jajka do miski i roztrzep widelcem z odmierzoną solą i pieprzem.', null::text, false),
         (4::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (5::smallint, '**Pieczywo.** Przygotuj pieczywo w ilości wskazanej na liście składników.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie omletu', 9 from przepisy p where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** Rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (2::smallint, '**Szpinak.** Dodaj szpinak i smaż **1 minutę**.', null::text, false),
         (3::smallint, '**Smażenie omletu.** Wlej jajka i rozłóż fetę. Smaż na małym ogniu pod pokrywką przez **4–5 minut**.', null::text, false),
         (4::smallint, '**Złożenie i kontrola omletu.** Gdy masa się zetnie, złóż omlet i podgrzewaj jeszcze **1 minutę**. Jeśli środek nadal jest płynny, smaż pod pokrywką kolejną minutę.', 'środek ścięty, bez surowej masy jajecznej'::text, true),
         (5::smallint, '**Podanie.** Podaj z pieczywem w ilości z listy.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Omlet ze szpinakiem i fetą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  POD CIŚNIENIEM - Gulasz z kaszą gryczaną
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 'Treściwy gulasz wieprzowy z warzywami, passatą i aromatycznymi przyprawami, przygotowany pod ciśnieniem i podawany z kaszą gryczaną oraz kapustą kiszoną.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['gulasz_curry', 'kasza_ryz']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 833, 1, 1,
  15, 44,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Garnek 4 l', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Przechowuj w lodówce do 3 dni. Kaszę najlepiej przechowywać osobno.',
  true, 'Jeśli mięso jest jeszcze twarde, ponownie zamknij garnek i gotuj pod ciśnieniem przez kilka dodatkowych minut. Jeśli sos jest zbyt rzadki, odparuj go bez przykrycia.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       'w kostce 3 cm', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Gulasz wieprzowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Cebula, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 4, 'g'::jednostka_miary, 4,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Papryka czerwona, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 120, 'ml'::jednostka_miary, 120,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Passata pomidorowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 60, 'g'::jednostka_miary, 60,
       'sucha, ugotowana osobno', null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Kasza gryczana, sucha';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'odciśnięta i jest surówką', null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Kapusta kiszona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 5, 'g'::jednostka_miary, 5,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Olej rzepakowy rafinowany';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Papryka słodka mielona';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'szt'::jednostka_miary, round((1 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'liść laurowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'szt'::jednostka_miary, round((3 * sk.masa_sztuki_g)::numeric, 1),
       null, null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'ziele angielskie';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'ml'::jednostka_miary, 150,
       'na wywar — po odparowaniu', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'woda';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 14
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Czarny pieprz mielony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 15
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and sk.nazwa = 'Sól kłodawska';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 15 from przepisy p where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, pokrój w cienkie półplasterki.', null::text, false),
         (4::smallint, '**Papryka.** Umyj paprykę, usuń gniazdo nasienne i pokrój na kawałki około 2 cm.', null::text, false),
         (5::smallint, '**Kapusta kiszona.** Odciśnij kapustę kiszoną i odłóż do podania jako surówkę.', null::text, false),
         (6::smallint, '**Wieprzowina.** Osusz wieprzowinę i pokrój w kostkę około 3 cm.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Kasza gryczana.** Odmierz kaszę gryczaną.', null::text, false),
         (9::smallint, '**Płynna baza.** Odmierz passatę i wodę z listy składników.', null::text, false),
         (10::smallint, '**Olej.** Odmierz olej.', null::text, false),
         (11::smallint, '**Przyprawy.** Odmierz sól, pieprz, słodką paprykę, liście laurowe i ziele angielskie.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Obsmażanie mięsa i warzyw', 10 from przepisy p where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oleju.** Włącz funkcję podsmażania. Rozgrzej olej.', null::text, false),
         (2::smallint, '**Obsmażenie mięsa.** Obsmaż mięso partiami po **4–5 minut**, obracając, aż powierzchnia lekko się zarumieni. Przy większej ilości dolicz czas kolejnych partii.', null::text, false),
         (3::smallint, '**Cebula.** Dodaj cebulę i smaż na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (4::smallint, '**Warzywa i przyprawy.** Dodaj czosnek, marchew, paprykę oraz słodką paprykę mieloną i wymieszaj.', null::text, false),
         (5::smallint, '**Baza sosu.** Wlej passatę i wodę. Dodaj liść laurowy i ziele angielskie. Dokładnie wymieszaj i zeskrob z dna ewentualne przypieczone fragmenty.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Gotowanie pod ciśnieniem i wykończenie', 34 from przepisy p where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie pod ciśnieniem.** Zamknij szybkowar i gotuj pod ciśnieniem przez **20–25 minut**, licząc od osiągnięcia ciśnienia roboczego.', null::text, false),
         (2::smallint, '**Kasza — równolegle.** W czasie gotowania gulaszu ugotuj kaszę gryczaną zgodnie z instrukcją na opakowaniu.', null::text, false),
         (3::smallint, '**Spadek ciśnienia.** Po gotowaniu pozwól ciśnieniu opaść naturalnie. Otwórz dopiero po jego całkowitym spadku, zgodnie z instrukcją urządzenia.', null::text, false),
         (4::smallint, '**Otwarcie i doprawienie.** Otwórz garnek, usuń liść laurowy i ziele angielskie. Dopraw solą i pieprzem.', null::text, false),
         (5::smallint, '**Zagęszczenie sosu.** Jeśli sos jest zbyt rzadki, gotuj bez przykrycia na funkcji podsmażania przez **3–5 minut**, mieszając i kontrolując gęstość.', null::text, false),
         (6::smallint, '**Podanie.** Gulasz podawaj z kaszą gryczaną i odciśniętą kapustą kiszoną.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną') and e.kolejnosc = 3;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Papryka.** Umyj paprykę, przekrój wzdłuż i usuń gniazdo nasienne.', null::text, false),
         (2::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (5::smallint, '**Soczewica.** Odmierz soczewicę i opłucz na sitku.', null::text, false),
         (6::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (7::smallint, '**Passata.** Odmierz passatę.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
         (9::smallint, '**Przyprawy.** Odmierz sól, pieprz i kmin rzymski.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie farszu', 40 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Gotowanie soczewicy.** Soczewicę ugotuj w dodatkowej wodzie przez czas z opakowania, zwykle **25–30 minut** od zagotowania; odcedź.', null::text, false),
         (2::smallint, '**Bulgur — równolegle.** Równolegle ugotuj bulgur w osobnym garnku przez czas z opakowania i odcedź. Woda do gotowania jest dodatkowa.', null::text, false),
         (3::smallint, '**Rozgrzanie oliwy.** Po odcedzeniu bulguru odstaw go pod przykryciem. Na zwolnionym palniku na patelni rozgrzej oliwę przez **1 minutę**.', null::text, false),
         (4::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (5::smallint, '**Czosnek i kmin.** Dodaj czosnek oraz kmin i smaż **30 sekund**.', null::text, false),
         (6::smallint, '**Passata.** Wlej passatę i gotuj **3 minuty**.', null::text, false),
         (7::smallint, '**Połączenie farszu.** Połącz sos z ugotowaną soczewicą i bulgurem. Dopraw solą i pieprzem.', null::text, false),
         (8::smallint, '**Piekarnik — równolegle.** W ostatnich **10 minutach** gotowania farszu rozgrzej piekarnik do **190°C**, grzanie góra–dół.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Nadziewanie i pieczenie', 45 from przepisy p where lower(p.nazwa) = lower('Papryka faszerowana soczewicą i kaszą bulgur');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Nadziewanie papryki.** Napełnij połówki papryki farszem, ułóż w naczyniu. Jeśli farszu jest więcej, rozłóż resztę między paprykami.', null::text, false),
         (2::smallint, '**Pieczenie pod przykryciem.** Przykryj naczynie i piecz **25 minut**.', null::text, false),
         (3::smallint, '**Dopiekanie bez przykrycia.** Odkryj i piecz **10–15 minut**.', null::text, false),
         (4::smallint, '**Sprawdzenie i podanie.** Sprawdź paprykę i podaj z natką.', 'papryka daje się łatwo nakłuć, farsz gorący w środku'::text, true)
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
  array['sniadanie', 'kolacja']::pora_posilku[], array['inna']::rodzaj_kuchni[],
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Borówki.** Umyj borówki i dokładnie osusz.', null::text, false),
         (2::smallint, '**Ciasto.** Odmierz mąkę, mleko i cynamon. Wbij jajka do miski, roztrzep z mlekiem, następnie dodaj mąkę i cynamon. Wymieszaj i odstaw na **5 minut**.', null::text, false),
         (3::smallint, '**Do podania.** Odmierz skyr i miód do osobnych naczyń.', null::text, false),
         (4::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Pełnoziarniste placuszki ze skyrem i owocami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie patelni.** Rozgrzej patelnię nieprzywierającą przez **1 minutę** na średnim ogniu. Rozdziel odmierzoną oliwę między partie.', null::text, false),
         (2::smallint, '**Smażenie placuszków.** Nakładaj małe porcje ciasta i smaż **2–3 minuty**, aż brzegi się zetną i spód zrumieni. Odwróć i smaż jeszcze **1–2 minuty**. Powtarzaj z resztą ciasta; etap obejmuje około 3 partie dla bazy.', 'placuszki mają rumiane strony i nie mają surowego ciasta w środku'::text, true),
         (3::smallint, '**Podanie.** Podaj ze skyrem, borówkami i miodem.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Buraki.** Umyj i obierz buraki, pokrój w kostkę około 1 cm.', null::text, false),
         (2::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Koperek.** Umyj i osusz koperek, usuń grube łodygi i drobno posiekaj delikatne gałązki.', null::text, false),
         (6::smallint, '**Warzywa do pieczenia.** Wymieszaj warzywa z oliwą oraz częścią soli i pieprzu.', null::text, false),
         (7::smallint, '**Makrela.** Osusz filety i usuń ości. Podana masa dotyczy części jadalnej. Dopraw pozostałą solą i pieprzem.', null::text, false),
         (8::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 58 from przepisy p where lower(p.nazwa) = lower('Pieczona makrela z burakami i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **200°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie warzyw.** Piecz warzywa przez **30 minut**, mieszając po **15 minutach**. Sprawdź buraki; jeśli są nadal twarde, dopiekaj same warzywa przez **5–10 minut** przed dodaniem ryby.', null::text, false),
         (3::smallint, '**Pieczenie makreli.** Do prawie miękkich warzyw dodaj filety makreli i piecz przez **12–15 minut**, zależnie od grubości.', 'ryba ma co najmniej 63°C, warzywa miękkie'::text, true),
         (4::smallint, '**Cytryna i koperek.** Po wyjęciu skrop rybę przygotowanym sokiem z cytryny i posyp koperkiem.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój w kostkę około 2 cm.', null::text, false),
         (2::smallint, '**Buraki.** Umyj i obierz buraki, pokrój w kostkę około 1 cm.', null::text, false),
         (3::smallint, '**Marchew.** Umyj i obierz marchew, pokrój na kawałki około 2 cm.', null::text, false),
         (4::smallint, '**Pasternak.** Umyj i obierz pasternak, pokrój na kawałki około 2 cm.', null::text, false),
         (5::smallint, '**Seler korzeniowy.** Umyj i obierz seler, pokrój na kawałki około 2 cm.', null::text, false),
         (6::smallint, '**Cebula.** Obierz cebulę i pokrój w ósemki.', null::text, false),
         (7::smallint, '**Warzywa do pieczenia.** Wymieszaj warzywa z odmierzoną oliwą, tymiankiem, rozmarynem, solą i pieprzem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 50 from przepisy p where lower(p.nazwa) = lower('Pieczone warzywa korzeniowe z tymiankiem');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **210°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie warzyw.** Rozłóż warzywa luźno na blasze i piecz **35–40 minut**. Przemieszaj po **20 minutach**. Jeśli najtwardsze kawałki nie są miękkie, dopiekaj po **5 minut**, zdejmując wcześniej gotowe.', 'warzywa są miękkie w środku i zarumienione na brzegach'::text, true),
         (3::smallint, '**Podanie.** Podaj jako dodatek.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Bakłażan.** Umyj bakłażana i pokrój w kostkę około 2 cm.', null::text, false),
         (2::smallint, '**Pomidor.** Umyj pomidory i pokrój w cząstki.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i pokrój w cienkie piórka.', null::text, false),
         (4::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (5::smallint, '**Ciecierzyca.** Przełóż ciecierzycę z puszki na sitko, opłucz i odsącz. Odmierz po odsączeniu.', null::text, false),
         (6::smallint, '**Feta.** Odmierz fetę i pokrusz.', null::text, false),
         (7::smallint, '**Warzywa do pieczenia.** Wymieszaj bakłażana, cebulę i ciecierzycę z oliwą, czosnkiem, oregano i pieprzem.', null::text, false),
         (8::smallint, '**Bulgur.** Odmierz kaszę bulgur.', null::text, false),
         (9::smallint, '**Sól.** Odmierz sól.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i gotowanie kaszy', 48 from przepisy p where lower(p.nazwa) = lower('Pieczony bakłażan z ciecierzycą i fetą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **210°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie bakłażana.** Rozłóż przygotowaną mieszankę w szerokim naczyniu i piecz **25 minut**, mieszając w połowie.', null::text, false),
         (3::smallint, '**Kasza — równolegle.** Podczas pieczenia ugotuj bulgur w dodatkowej wodzie przez czas z opakowania i odcedź.', null::text, false),
         (4::smallint, '**Pomidor i feta.** Do naczynia dodaj pomidora oraz fetę. Piecz **8–10 minut**; bakłażan powinien być zupełnie miękki. Jeśli nadal jest twardy, dopiekaj pod przykryciem po **5 minut**.', null::text, false),
         (5::smallint, '**Doprawienie i podanie.** Spróbuj, dopraw odmierzoną solą i podaj z kaszą.', null::text, false)
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Kalafior.** Umyj kalafior i podziel na podobnej wielkości różyczki, około 3 cm.', null::text, false),
         (2::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (3::smallint, '**Natka pietruszki.** Umyj i osusz natkę, usuń grube łodygi i drobno posiekaj liście.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę, wyciśnij sok i odmierz ilość wskazaną na liście składników.', null::text, false),
         (5::smallint, '**Kalafior do pieczenia.** Wymieszaj różyczki z oliwą, kminem, papryką oraz częścią soli i pieprzu.', null::text, false),
         (6::smallint, '**Sos jogurtowy.** Wymieszaj jogurt z czosnkiem, natką, sokiem z cytryny oraz resztą soli i pieprzu. Przykryj i odstaw do lodówki.', null::text, false),
         (7::smallint, '**Przyprawy.** Odmierz wędzoną paprykę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie i podanie', 42 from przepisy p where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **220°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie kalafiora.** Rozłóż kalafior w jednej warstwie i piecz **25–30 minut**, obracając w połowie.', 'różyczki miękkie w środku i rumiane na brzegach'::text, true),
         (3::smallint, '**Podanie.** Podaj jako dodatek, z sosem jogurtowym obok.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony kalafior z ziołowym sosem jogurtowym') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pieczony schab z warzywami korzeniowymi
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pieczony schab z warzywami korzeniowymi', 'Soczysty pieczony schab z marchewką, pietruszką, selerem i ziemniakami, doprawiony czosnkiem, majerankiem i tymiankiem. Warzywa pieką się dłużej, a mięso dokładamy później, dzięki czemu schab pozostaje soczysty.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad', 'kolacja']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['z_piekarnika']::rodzaj_dania[],
  3, 'prywatna',
  'waga', 594, 1, 1,
  20, 45,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Piekarnik', 'Naczynie żaroodporne', 'Nóż szefa kuchni', 'Deska do krojenia']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'Gotowe danie przechowuj w szczelnym pojemniku w lodówce do 3 dni. Schab można później podgrzać razem z warzywami albo wykorzystać na zimno, np. do kanapek.',
  true, 'Gotowe danie przechowuj w szczelnym pojemniku w lodówce do 3 dni. Schab można podgrzać razem z warzywami lub wykorzystać na zimno, np. do kanapek.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony schab z warzywami korzeniowymi'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pieczony schab z warzywami korzeniowymi'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 150, 'g'::jednostka_miary, 150,
       null, null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Schab wieprzowy, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Marchew, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 50, 'g'::jednostka_miary, 50,
       null, null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 80, 'g'::jednostka_miary, 80,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 220, 'g'::jednostka_miary, 220,
       'obrane', null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Ziemniaki, surowe';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 6
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 7, 'g'::jednostka_miary, 7,
       null, null, sk.rola, sk.mozna_dzielic, 7
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 8
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Majeranek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 9
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Tymianek suszony';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 10
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 11
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and sk.nazwa = 'Czarny pieprz mielony';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 20 from przepisy p where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Marchew.** Umyj i obierz marchew, pokrój na kawałki około 2,5–3 cm.', null::text, false),
         (2::smallint, '**Pietruszka korzeń.** Umyj i obierz korzeń pietruszki, pokrój na kawałki około 2,5–3 cm.', null::text, false),
         (3::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój na kawałki około 2,5–3 cm.', null::text, false),
         (4::smallint, '**Seler.** Umyj i obierz seler. Pokrój w cienkie paski, a następnie na mniejsze kawałki, aby zdążył się upiec.', null::text, false),
         (5::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (6::smallint, '**Schab.** Osusz schab. Natrzyj połową oliwy, czosnkiem, majerankiem oraz częścią soli i pieprzu.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Odpoczynek mięsa.** Odstaw schab na **15–20 minut**. W tym czasie rozgrzej piekarnik do **200°C** i dopraw warzywa.', null::text, false),
         (9::smallint, '**Warzywa do pieczenia.** Wymieszaj warzywa z pozostałą oliwą, tymiankiem oraz resztą soli i pieprzu. Rozłóż w jednej warstwie w naczyniu do pieczenia.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 45 from przepisy p where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Wstępne pieczenie warzyw.** Wstępne pieczenie warzyw. Wstaw warzywa do piekarnika nagrzanego do **200°C** i piecz przez około **20 minut**. Po około **10 minutach** przemieszaj.', null::text, false),
         (2::smallint, '**Dodanie schabu.** Dodanie schabu. Po **20 minutach** przesuń warzywa i ułóż między nimi przygotowany schab.', null::text, false),
         (3::smallint, '**Pieczenie schabu.** Pieczenie schabu z warzywami. Piecz wszystko razem jeszcze około **18–20 minut**. Schab jest gotowy, gdy temperatura w jego najgrubszym miejscu osiągnie około **65°C**.', null::text, false),
         (4::smallint, '**Odpoczynek mięsa.** Odpoczynek mięsa. Wyjmij schab i pozostaw na około **5 minut** przed krojeniem. Jeśli warzywa potrzebują jeszcze chwili, pozostaw je w tym czasie w piekarniku.', null::text, false),
         (5::smallint, '**Podanie.** Podanie. Schab pokrój w plastry i podawaj z pieczonymi ziemniakami oraz warzywami korzeniowymi.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony schab z warzywami korzeniowymi') and e.kolejnosc = 2;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój na kawałki około 1,5–2 cm.', null::text, false),
         (2::smallint, '**Brokuł.** Umyj brokuł i podziel na małe różyczki.', null::text, false),
         (3::smallint, '**Czosnek.** Obierz czosnek i drobno posiekaj.', null::text, false),
         (4::smallint, '**Cytryna.** Umyj cytrynę. Z części wskazanej na liście składników przygotuj sok i cząstki do podania.', null::text, false),
         (5::smallint, '**Oliwa.** Podziel odmierzoną oliwę między ziemniaki, brokuł i rybę.', null::text, false),
         (6::smallint, '**Ziemniaki do pieczenia.** Wymieszaj ziemniaki z ich częścią oliwy, tymiankiem i częścią soli.', null::text, false),
         (7::smallint, '**Brokuł do pieczenia.** Skrop brokuł przeznaczoną dla niego oliwą.', null::text, false),
         (8::smallint, '**Łosoś.** Osusz filet, usuń ości. Natrzyj pozostałą oliwą, czosnkiem, solą i pieprzem.', null::text, false),
         (9::smallint, '**Po przygotowaniu ryby.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surową rybą.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Pieczenie', 49 from przepisy p where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie piekarnika.** Rozgrzej piekarnik do **210°C**, grzanie góra–dół, zwykle około **10 minut**.', null::text, false),
         (2::smallint, '**Pieczenie ziemniaków.** Piecz ziemniaki **20 minut**.', null::text, false),
         (3::smallint, '**Dodanie brokułu.** Dodaj brokuł i piecz **5 minut**.', null::text, false),
         (4::smallint, '**Pieczenie łososia.** Dodaj łososia grubości około 2–3 cm i piecz jeszcze **10–12 minut**. Grubszy kawałek może wymagać dłużej; gotowe warzywa zdejmij wcześniej.', 'ryba ma co najmniej 63°C, ziemniaki miękkie'::text, true),
         (5::smallint, '**Podanie.** Skrop rybę przygotowanym sokiem z cytryny i podaj z warzywami oraz cząstkami cytryny.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pieczony łosoś z brokułem i ziemniakami') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pierś z kaczki z pomarańczą i czerwoną kapustą
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pierś z kaczki z pomarańczą i czerwoną kapustą', 'Pierś z kaczki z duszoną czerwoną kapustą, jabłkiem, pomarańczą i ziemniakami. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['inna']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Kapusta czerwona.** Umyj kapustę, usuń twardy głąb i cienko poszatkuj liście.', null::text, false),
         (2::smallint, '**Jabłko.** Umyj jabłko, usuń gniazdo nasienne i pokrój miąższ w kostkę.', null::text, false),
         (3::smallint, '**Cebula.** Obierz cebulę i drobno posiekaj.', null::text, false),
         (4::smallint, '**Ziemniaki.** Umyj i obierz ziemniaki, pokrój na kawałki około 3 cm.', null::text, false),
         (5::smallint, '**Pomarańcza.** Umyj pomarańczę. Część przygotuj w cząstkach bez błon, z pozostałej wyciśnij sok.', null::text, false),
         (6::smallint, '**Kaczka.** Osusz pierś bez skóry i dopraw częścią soli i pieprzu.', null::text, false),
         (7::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (8::smallint, '**Oliwa.** Odmierz oliwę i podziel na połowę: do kapusty i do smażenia kaczki.', null::text, false),
         (9::smallint, '**Woda.** Odmierz wodę z listy składników.', null::text, false),
         (10::smallint, '**Dodatki.** Odmierz ocet jabłkowy.', null::text, false),
         (11::smallint, '**Przyprawy.** Odmierz cynamon i goździki.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Gotowanie dodatków i smażenie kaczki', 45 from przepisy p where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie oliwy.** W garnku rozgrzej połowę oliwy przez **1 minutę**.', null::text, false),
         (2::smallint, '**Cebula.** Smaż cebulę na średnim ogniu **3–4 minuty**, mieszając, aż się zeszkli.', 'cebula miękka i szklista, bez zrumienionych brzegów'::text, false),
         (3::smallint, '**Duszenie kapusty.** Dodaj kapustę, jabłko, połowę soku pomarańczowego, cynamon i goździki. Dodaj odmierzoną wodę do duszenia, i duś pod przykryciem **25–30 minut**.', null::text, false),
         (4::smallint, '**Ocet do kapusty.** Ocet dodaj pod koniec, gdy kapusta jest miękka.', null::text, false),
         (5::smallint, '**Ziemniaki — równolegle.** Równolegle na drugim palniku zagotuj ziemniaki w wodzie, zwykle około **5 minut**, a następnie gotuj **15–20 minut** do miękkości. Odcedź i trzymaj pod przykryciem.', null::text, false),
         (6::smallint, '**Rozgrzanie oliwy po ziemniakach.** Na palniku zwolnionym przez ziemniaki rozgrzej pozostałą oliwę na patelni przez **1 minutę**.', null::text, false),
         (7::smallint, '**Smażenie kaczki.** Smaż pierś przez **3–4 minuty** z każdej strony.', null::text, false),
         (8::smallint, '**Sprawdzenie kaczki.** Sprawdź najgrubsze miejsce termometrem. W razie potrzeby zmniejsz ogień i dosmażaj pod przykryciem po **1–2 minuty**.', 'kaczka ma co najmniej 74°C w środku'::text, true),
         (9::smallint, '**Odpoczynek kaczki.** Gotową pierś odstaw na **5 minut**.', null::text, false),
         (10::smallint, '**Sos pomarańczowy.** W tym czasie wlej pozostały sok pomarańczowy na patelnię, dodaj cząstki pomarańczy i gotuj **1–2 minuty**, zbierając smaki z dna.', null::text, false),
         (11::smallint, '**Doprawienie kapusty.** Usuń goździki z kapusty, dopraw resztą soli i pieprzu.', null::text, false),
         (12::smallint, '**Podanie.** Pokrój kaczkę, podaj z sosem, kapustą i ziemniakami.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kaczki z pomarańczą i czerwoną kapustą') and e.kolejnosc = 2;

-- -------------------------------------------------------------------------
--  Pierś z kurczaka z grilla
-- -------------------------------------------------------------------------

insert into przepisy
  (nazwa, opis, autor_id, pory, kuchnie, rodzaje, trwalosc_dni, widocznosc,
   porcjowanie, porcja_g, porcje, liczba_porcji_bazowych, czas_przygotowania_min, czas_obrobki_min,
   sprzet, przechowywanie, mozna_mrozic, ratunek)
select
  'Pierś z kurczaka z grilla', 'Soczysta grillowana pierś z kurczaka z czosnkiem i słodką papryką. Uniwersalny dodatek białkowy do zup, sałatek, kanapek i innych posiłków; dobrze smakuje również na zimno.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['dodatek']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  '{}'::rodzaj_dania[],
  3, 'prywatna',
  'waga', 107, 1, 1,
  13, 15,
  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')
     from unnest(array['Grill kontaktowy', 'Deska do krojenia', 'Nóż szefa kuchni', 'Termometr do mięsa']::text[]) with ordinality as v(nazwa, poz)
     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),
  'W lodówce do 3 dni, w zamkniętym pojemniku. Na zimno nadaje się do sałatek i kanapek.',
  false, 'Przesuszona — pokrój w paski i wymieszaj z łyżką jogurtu greckiego albo dodaj do zupy, gdzie nawilgnie.'
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

delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pierś z kurczaka z grilla'));
delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower('Pierś z kurczaka z grilla'));

insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 100, 'g'::jednostka_miary, 100,
       'rozbita do grubości 1,5 cm', null, sk.rola, sk.mozna_dzielic, 1
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and sk.nazwa = 'Pierś z kurczaka, surowa';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 3, 'g'::jednostka_miary, 3,
       null, null, sk.rola, sk.mozna_dzielic, 2
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and sk.nazwa = 'Oliwa z oliwek extra virgin';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 2, 'g'::jednostka_miary, 2,
       'przeciśnięty przez praskę', null, sk.rola, sk.mozna_dzielic, 3
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and sk.nazwa = 'Czosnek, surowy';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 0.5, 'g'::jednostka_miary, 0.5,
       null, null, sk.rola, sk.mozna_dzielic, 4
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and sk.nazwa = 'Sól kłodawska';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 1, 'g'::jednostka_miary, 1,
       null, null, sk.rola, sk.mozna_dzielic, 5
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and sk.nazwa = 'Papryka słodka mielona';

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 1, 'Przygotowanie składników', 13 from przepisy p where lower(p.nazwa) = lower('Pierś z kurczaka z grilla');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Czosnek.** Obierz czosnek i przeciśnij przez praskę lub bardzo drobno posiekaj.', null::text, false),
         (2::smallint, '**Kurczak.** Osusz pierś i rozbij do równej grubości około 1,5 cm. Natrzyj z obu stron oliwą, czosnkiem, solą i słodką papryką.', null::text, false),
         (3::smallint, '**Po przygotowaniu mięsa.** Umyj ręce, nóż, deskę i powierzchnie, które miały kontakt z surowym mięsem.', null::text, false),
         (4::smallint, '**Marynowanie.** Odstaw mięso na około **10 minut** w temperaturze pokojowej.', null::text, true)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Grillowanie', 10 from przepisy p where lower(p.nazwa) = lower('Pierś z kurczaka z grilla');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie grilla.** Rozgrzej grill kontaktowy do wysokiej temperatury zgodnie z instrukcją urządzenia, zwykle przez około **3 minuty**.', null::text, false),
         (2::smallint, '**Kurczak na grill.** Połóż kurczaka na rozgrzanym grillu i zamknij pokrywę. Nie dociskaj jej dodatkowo.', null::text, false),
         (3::smallint, '**Grillowanie kurczaka.** Grilluj około **5–7 minut** bez obracania, ponieważ grill kontaktowy ogrzewa mięso jednocześnie z obu stron.', null::text, false),
         (4::smallint, '**Sprawdzenie kurczaka.** Sprawdź termometrem temperaturę w najgrubszym miejscu mięsa. Kurczak jest gotowy po osiągnięciu około **74°C**.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and e.kolejnosc = 2;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 3, 'Odpoczynek i krojenie', 5 from przepisy p where lower(p.nazwa) = lower('Pierś z kurczaka z grilla');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Odpoczynek kurczaka.** Zdejmij kurczaka z grilla i odstaw na około **5 minut**.', null::text, false),
         (2::smallint, '**Krojenie.** Po odpoczynku pokrój mięso zgodnie z przeznaczeniem — w plastry, paski lub kostkę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Pierś z kurczaka z grilla') and e.kolejnosc = 3;

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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
         (1::smallint, '**Banan.** Obierz banana i rozgnieć miąższ widelcem.', null::text, false),
         (2::smallint, '**Ciasto.** Odmierz mleko, mąkę i cynamon. Wymieszaj z rozgniecionym bananem i jajkami. Odstaw na **5 minut**, aby mąka wchłonęła płyn.', null::text, false),
         (3::smallint, '**Jogurt.** Odmierz jogurt.', null::text, false),
         (4::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Placuszki bananowo-owsiane') and e.kolejnosc = 1;

insert into etapy (przepis_id, kolejnosc, nazwa, minuty)
select p.id, 2, 'Smażenie', 18 from przepisy p where lower(p.nazwa) = lower('Placuszki bananowo-owsiane');

insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)
select e.id, v.nr, v.tresc, v.sygnal, v.uwaga
  from etapy e join przepisy p on p.id = e.przepis_id,
       (values
         (1::smallint, '**Rozgrzanie patelni.** Rozgrzej patelnię nieprzywierającą przez **1 minutę** na średnim ogniu. Podziel oliwę między partie.', null::text, false),
         (2::smallint, '**Smażenie placuszków.** Nakładaj małe porcje ciasta i smaż około **2–3 minut** z pierwszej strony oraz **1–2 minuty** z drugiej. Etap obejmuje około 3 partie dla bazy; przy większej ilości dolicz kolejne partie.', 'spód rumiany, brzegi ścięte, środek bez surowego ciasta'::text, true),
         (3::smallint, '**Podanie.** Podaj z odmierzoną ilością jogurtu.', null::text, false)
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
  'Polędwiczka w sosie musztardowym z kaszą bulgur', 'Polędwiczka wieprzowa w lekkim sosie musztardowo-jogurtowym z pieczarkami i kaszą bulgur. Ilości składników dobierz z listy dla przygotowywanej liczby porcji. Czasy etapów dotyczą porcji bazowych; przy większej ilości uwzględnij dodatkowy czas pracy i ewentualne smażenie lub pieczenie partiami. Smak sosu lub płynu do gotowania powstaje z przygotowywanych składników w tym samym naczyniu. Podana ilość wody jest początkowa; ewentualne dolewanie zależy od konsystencji i miękkości składników. Warzywna baza obejmuje korzeń pietruszki, seler korzeniowy, por, przygotowane razem z pozostałymi składnikami; wszystkie warzywa pozostają w posiłku.', (select id from konta where lower(email) = lower('romitu@gmail.com')),
  array['obiad']::pora_posilku[], array['polska']::rodzaj_kuchni[],
  array['kasza_ryz']::rodzaj_dania[],
  2, 'prywatna',
  'waga', 726, 1, 1,
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
       'Można również gotować oddzielnie w każdym dniu odpowiednią ilość.', null, sk.rola, sk.mozna_dzielic, 2
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
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Oliwa z oliwek extra virgin';
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
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 12
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Pietruszka korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 20, 'g'::jednostka_miary, 20,
       'obrany korzeń, starty na drobnych oczkach; do warzywnej bazy', null, sk.rola, sk.mozna_dzielic, 13
  from przepisy p, skladniki sk where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and sk.nazwa = 'Seler korzeń';
insert into przepis_skladniki
  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)
select p.id, sk.id, 30, 'g'::jednostka_miary, 30,
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
         (11::smallint, '**Oliwa.** Odmierz oliwę.', null::text, false),
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
         (2::smallint, '**Rozgrzanie tłuszczu.** Na patelni rozgrzej połowę oliwy przez **1 minutę**. Pozostałą część zachowaj do mięsa.', null::text, false),
         (3::smallint, '**Cebula, korzenie i por.** Dodaj cebulę, starte korzenie pietruszki i selera oraz por. Smaż przez **3 minuty** na umiarkowanym ogniu, mieszając.', null::text, false),
         (4::smallint, '**Pieczarki.** Dodaj pieczarki i smaż przez **7–9 minut**, aż większość wody odparuje, a grzyby lekko się zrumienią.', null::text, false),
         (5::smallint, '**Tymianek i woda.** Dodaj tymianek i całą odmierzoną wodę. Mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości z dna patelni.', null::text, false),
         (6::smallint, '**Gotowanie warzywnej bazy.** Doprowadź do łagodnego wrzenia przez około **1–2 minuty**. Przykryj i duś przez **10–12 minut**. Sprawdź korzenie; jeśli są twarde, dogotowuj po **2 minuty**. Jeśli płynu brakuje, dolej niewielką ilość gorącej wody.', 'korzenie i por są miękkie, w sosie pozostaje płyn'::text, true),
         (7::smallint, '**Kasza — po minutniku.** Niezależnie od postępu przygotowania sosu sprawdź miękkość kaszy po czasie z opakowania. Odcedź nadmiar wody, przykryj i odstaw poza palnik.', null::text, false),
         (8::smallint, '**Odłożenie sosu.** Przełóż całą bazę warzywno-grzybową wraz z płynem do miski i przykryj. Na patelni nie pozostawiaj kawałków warzyw, które mogłyby przypalić się podczas smażenia mięsa. Ewentualny nadmiar wody wylej. Baza powinna być gęsta.', null::text, false),
         (9::smallint, '**Rozgrzanie tłuszczu do mięsa.** Na opróżnionej patelni rozgrzej pozostałą część oliwy przez około **1 minutę**.', null::text, false),
         (10::smallint, '**Smażenie polędwiczki.** Smaż medaliony przez **2–3 minuty z każdej strony**. Sprawdź temperaturę w środku najgrubszego kawałka. Jeśli jest niższa niż **63°C**, dosmażaj po **1 minucie**, kontrolując temperaturę.', 'najgrubszy medalion ma w środku co najmniej 63°C'::text, true),
         (11::smallint, '**Odpoczynek mięsa.** Przełóż gotowe mięso na czysty talerz i pozostaw na co najmniej **3 minuty**. W tym czasie wykończ sos.', null::text, false),
         (12::smallint, '**Połączenie smaków.** Przełóż na patelnię najpierw płynną część sosu z miski. Mieszaj przez **1 minutę**, rozpuszczając zrumienione pozostałości po mięsie. Dodaj wszystkie warzywa i grzyby oraz soki z talerza po mięsie. Podgrzewaj przez **1–2 minuty**. Jeśli sos jest za gęsty, dolej trochę gorącej wody.', null::text, false),
         (13::smallint, '**Sos jogurtowo-musztardowy.** Zdejmij patelnię z ognia. Przygotowaną mieszaninę jogurtu i musztardy ogrzej stopniowo małymi porcjami ciepłego sosu, następnie wmieszaj do patelni. Nie zagotowuj.', null::text, false),
         (14::smallint, '**Doprawienie.** Dopraw sos pozostałą solą i pieprzem.', null::text, false),
         (15::smallint, '**Podanie.** Po co najmniej 3 minutach odpoczynku przełóż mięso do ciepłego sosu i podaj z bulgurem.', null::text, false)
       ) as v(nr, tresc, sygnal, uwaga)
 where lower(p.nazwa) = lower('Polędwiczka w sosie musztardowym z kaszą bulgur') and e.kolejnosc = 2;

commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
  ('Kurczak pieczony z batatem i brokułem', 10, 2, 13),
  ('Kurczak po tajsku', 15, 3, 26),
  ('Kurczak z ryżem, marchewką i jogurtem greckim', 14, 3, 28),
  ('Makaron pełnoziarnisty z bolońskim sosem z soczewicy', 13, 2, 15),
  ('Makaron z brokułem i fetą', 8, 2, 13),
  ('Makaron z ciecierzycą, bazylią i orzechami', 10, 2, 13),
  ('Makaron z indykiem, pieczarkami i jogurtem', 10, 2, 19),
  ('Makaron z kurczakiem, szpinakiem i pomidorami', 12, 2, 19),
  ('Makaron z pieczonymi warzywami i mozzarellą', 11, 2, 12),
  ('Makaron z polędwiczką i pieczarkami', 11, 2, 20),
  ('Makaron z ricottą i szpinakiem', 9, 2, 15),
  ('Makaron z tuńczykiem, cytryną i natką pietruszki', 9, 2, 13),
  ('Makaron z wołowiną i sosem pomidorowym', 11, 2, 16),
  ('Małże w pomidorowym bulionie', 13, 2, 20),
  ('Morszczuk w sosie pomidorowym z ryżem', 11, 2, 17),
  ('Omlet z pieczarkami', 8, 2, 13),
  ('Omlet ze szpinakiem i fetą', 7, 2, 10),
  ('POD CIŚNIENIEM - Gulasz z kaszą gryczaną', 15, 3, 22),
  ('Papryka faszerowana soczewicą i kaszą bulgur', 11, 3, 21),
  ('Pełnoziarniste placuszki ze skyrem i owocami', 8, 2, 7),
  ('Pieczona makrela z burakami i ziemniakami', 9, 2, 12),
  ('Pieczone warzywa korzeniowe z tymiankiem', 11, 2, 10),
  ('Pieczony bakłażan z ciecierzycą i fetą', 11, 2, 14),
  ('Pieczony kalafior z ziołowym sosem jogurtowym', 10, 2, 10),
  ('Pieczony schab z warzywami korzeniowymi', 11, 2, 14),
  ('Pieczony łosoś z brokułem i ziemniakami', 9, 2, 14),
  ('Pierś z kaczki z pomarańczą i czerwoną kapustą', 13, 2, 23),
  ('Pierś z kurczaka z grilla', 5, 3, 10),
  ('Placuszki bananowo-owsiane', 7, 2, 7),
  ('Polędwiczka w sosie musztardowym z kaszą bulgur', 14, 2, 27)
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
where lower(p.nazwa) in (lower('Kurczak pieczony z batatem i brokułem'), lower('Kurczak po tajsku'), lower('Kurczak z ryżem, marchewką i jogurtem greckim'), lower('Makaron pełnoziarnisty z bolońskim sosem z soczewicy'), lower('Makaron z brokułem i fetą'), lower('Makaron z ciecierzycą, bazylią i orzechami'), lower('Makaron z indykiem, pieczarkami i jogurtem'), lower('Makaron z kurczakiem, szpinakiem i pomidorami'), lower('Makaron z pieczonymi warzywami i mozzarellą'), lower('Makaron z polędwiczką i pieczarkami'), lower('Makaron z ricottą i szpinakiem'), lower('Makaron z tuńczykiem, cytryną i natką pietruszki'), lower('Makaron z wołowiną i sosem pomidorowym'), lower('Małże w pomidorowym bulionie'), lower('Morszczuk w sosie pomidorowym z ryżem'), lower('Omlet z pieczarkami'), lower('Omlet ze szpinakiem i fetą'), lower('POD CIŚNIENIEM - Gulasz z kaszą gryczaną'), lower('Papryka faszerowana soczewicą i kaszą bulgur'), lower('Pełnoziarniste placuszki ze skyrem i owocami'), lower('Pieczona makrela z burakami i ziemniakami'), lower('Pieczone warzywa korzeniowe z tymiankiem'), lower('Pieczony bakłażan z ciecierzycą i fetą'), lower('Pieczony kalafior z ziołowym sosem jogurtowym'), lower('Pieczony schab z warzywami korzeniowymi'), lower('Pieczony łosoś z brokułem i ziemniakami'), lower('Pierś z kaczki z pomarańczą i czerwoną kapustą'), lower('Pierś z kurczaka z grilla'), lower('Placuszki bananowo-owsiane'), lower('Polędwiczka w sosie musztardowym z kaszą bulgur'))
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
