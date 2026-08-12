# Talerz — czym się wyróżnić

Notatka robocza do wspólnej dyskusji. Stan na sierpień 2026.

---

## 1. Co jest już standardem (czyli czym nie zaskoczymy)

Te funkcje ma dziś kilkanaście aplikacji. Zbudowanie ich nie da nam przewagi —
najwyżej pozwoli dogonić stawkę:

- generowanie planu posiłków przez sztuczną inteligencję
- automatyczna lista zakupów z planu
- baza kalorii i skanowanie kodów kreskowych
- import przepisów z dowolnej strony internetowej
- filtrowanie po alergiach i preferencjach
- „planowanie z tego, co masz w spiżarni" (deklaruje to już kilka aplikacji)

**Wniosek:** hasło „aplikacja z AI do planowania diety" jest dziś pustym
komunikatem. Musimy mieć inną odpowiedź na pytanie „po co to komu".

---

## 2. Gdzie są prawdziwe luki

Trzy rzeczy wychodzą zgodnie ze wszystkich źródeł — recenzji, badań nad
porzucaniem aplikacji i narzekań użytkowników:

**Luka A — gotowanie na zapas jest ignorowane.**
Recenzenci wprost piszą, że popularne aplikacje nie obsługują scenariusza
„gotuję dwie godziny w niedzielę i jem z tego przez tydzień". Aplikacje myślą
w kategoriach pojedynczych posiłków, nie garnków i porcji w lodówce.

**Luka B — zapisywanie posiłków jest zbyt pracochłonne.**
Badania nad porzucaniem aplikacji zdrowotnych wskazują, że ludzie nie rezygnują
z powodu braku motywacji, tylko dlatego, że wpisanie jednego posiłku zajmuje
kilka minut i powtarza się kilka razy dziennie. Do tego dochodzi brak sensownej
informacji zwrotnej — „logowanie bez zapłaty jest wyczerpujące".

**Luka C — nikt nie liczy pieniędzy i marnowania jedzenia.**
Aplikacje planują przepisy, a potem zostaje 200 g ricotty, której nie ma gdzie
użyć. Ceny w złotówkach i realna zawartość opakowań nie istnieją w żadnym
z popularnych rozwiązań.

---

## 3. Propozycje

Uszeregowane od najmocniejszej. Przy każdej: na czym polega, dlaczego to
wyróżnik i co może pójść nie tak.

### 3.1. Garnek zamiast posiłku — model danych oparty na partiach

**Problem:** gotujesz raz, jesz trzy dni. Aplikacje nie mają na to pojęcia.

**Mechanizm:** podstawową jednostką nie jest „posiłek w poniedziałek", tylko
**partia**: ugotowany garnek podzielony na N porcji, z datą przydatności.
Lodówka w aplikacji pokazuje, co realnie w niej stoi:

> Gulasz z indyka — zostały 2 porcje, zjeść do czwartku
> Kasza gryczana — 3 porcje, do soboty

Plan dnia składa się wtedy z porcji już ugotowanych plus tego, co trzeba
dogotować. Aplikacja sama pilnuje, żeby nie zaplanować gotowania, gdy w lodówce
czeka jedzenie.

**Dlaczego to wyróżnik:** to jest uznana luka rynkowa, nie domysł. Żadna duża
aplikacja tak nie myśli, bo wszystkie wyrosły z przepisów, nie z lodówki.

**Trudność:** średnia. To głównie decyzja projektowa w bazie danych, podjęta na
początku — później przerobienie tego byłoby kosztowne.

**Ryzyko:** wymaga od użytkownika odznaczania zjedzonych porcji. Jeśli tego nie
zrobi, stan lodówki się rozjedzie. Rozwiązanie w punkcie 3.2.

---

### 3.2. Zapisywanie przez wyjątek

**Problem:** największa przyczyna porzucania aplikacji dietetycznych to mozół
wpisywania każdego posiłku.

**Mechanizm:** odwracamy domyślne założenie. Skoro istnieje plan, to zakładamy,
że został wykonany. Wieczorem jedno pytanie i jedno dotknięcie:

> Dzisiaj poszło zgodnie z planem? [Tak] [Coś zmieniłem]

„Tak" zamyka dzień. Dopiero „Coś zmieniłem" otwiera edycję. Zamiast trzech
wpisów dziennie — jedno dotknięcie.

**Dlaczego to wyróżnik:** wszystkie aplikacje pytają „co zjadłeś?". Nasza pyta
„czy coś się zmieniło?". Przy diecie planowanej z góry to zmienia dzienny koszt
korzystania z pięciu minut na pięć sekund.

**Trudność:** mała. Głównie kwestia pomysłu, nie kodu.

**Ryzyko:** działa tylko dla ludzi, którzy faktycznie jedzą według planu.
Dla osób jedzących chaotycznie to bez wartości — ale to nie jest nasz odbiorca.

---

### 3.3. Zamykanie opakowań — planowanie bez resztek

**Problem:** przepis wymaga 150 g czegoś, co sprzedaje się w opakowaniach
po 400 g. Reszta psuje się w lodówce. To codzienność, której żadna aplikacja
nie widzi, bo operuje gramami z przepisu, a nie opakowaniami ze sklepu.

**Mechanizm:** produkty w bazie mają realną gramaturę opakowań z Lidla.
Planując tydzień, aplikacja dobiera przepisy tak, żeby **rozdysponować całe
opakowania**. Gdy zostaje resztka, sama proponuje, gdzie ją zużyć:

> Zostanie 180 g jogurtu greckiego. Dorzucić do owsianki w czwartek?

Na koniec tygodnia licznik: ile jedzenia i ile złotówek nie trafiło do kosza.

**Dlaczego to wyróżnik:** to Twoja własna zasada zero-waste, przełożona na
mechanizm. Dotyka jednocześnie pieniędzy i poczucia winy — dwóch najmocniejszych
motywatorów.

**Trudność:** duża. Wymaga bazy produktów z gramaturami i algorytmu doboru
przepisów. Sensowne jako etap drugi, nie pierwszy.

---

### 3.4. Plan z gazetki — planowanie od promocji

**Problem:** ludzie planują jedzenie, a potem osobno szukają promocji. To dwie
niepołączone czynności.

**Mechanizm:** w czwartek aplikacja pokazuje propozycję tygodnia zbudowaną
wokół tego, co w tym tygodniu jest tanie:

> W tym tygodniu: dorsz MSC −30%, jogurt grecki 2+1.
> Plan dopasowany, koszyk wychodzi 187 zł zamiast 240 zł.

**Dlaczego to wyróżnik:** żadna zagraniczna aplikacja tego nie zrobi, bo nie zna
polskiego rynku. To lokalna przewaga, której duzi gracze nie skopiują szybko.
Dodatkowo argument, który przekonuje ludzi nieprzekonanych do diet — oszczędność.

**Trudność:** duża, i to głównie poza kodem. Lidl nie udostępnia publicznego
interfejsu z cenami. Dane z gazetek zbierają serwisy pośredniczące, ale
pobieranie ich automatycznie bywa zawodne technicznie i niejasne prawnie.

**Możliwe wyjścia:** zacząć od ręcznie wprowadzanych cen kilkudziesięciu
podstawowych produktów, albo od cen podawanych przez samych użytkowników.
Do rozstrzygnięcia osobno — traktowałbym to jako kierunek, nie jako obietnicę.

---

### 3.5. Białko jako twarda granica, nie sugestia

**Problem:** wszystkie aplikacje optymalizują kalorie. Tymczasem po pięćdziesiątce
kluczowa jest ilość białka w pojedynczym posiłku — organizm nie potrafi
wykorzystać dziennej puli zjedzonej naraz wieczorem.

**Mechanizm:** minimalna ilość białka na posiłek jest ograniczeniem twardym.
Aplikacja nigdy nie zaproponuje posiłku poniżej progu, a jeśli użytkownik sam
taki wpisze — proponuje konkretne uzupełnienie:

> 22 g białka. Dołóż 100 g kurczaka (+31 g) albo 150 g twarogu (+27 g).

**Dlaczego to wyróżnik:** to przesunięcie z „ile zjadłem" na „czy ten posiłek ma
sens". Trafia w grupę 50+, którą aplikacje dietetyczne ignorują — są projektowane
dla dwudziestolatków chcących schudnąć na lato.

**Trudność:** mała. Zalążek już działa w ekranie planu.

---

### 3.6. Społeczność wokół garnka, nie wokół zdjęcia

**Problem:** czat i polubienia w aplikacji kulinarnej zwykle kończą się jako
kolejny feed ładnych zdjęć, w którym nikt nie pisze.

**Mechanizm:** przedmiotem rozmowy jest **partia**, nie przepis. Ludzie wrzucają
to, co ugotowali w niedzielę, ile porcji z tego wyszło i na ile dni starczyło:

> Gulasz z indyka, garnek 4 l, wyszło 6 porcji, starczyło do środy.
> Koszt: 38 zł. 52 g białka na porcję.

Polubienie znaczy „powtórzę u siebie", a nie „ładne zdjęcie". Miara sukcesu jest
policzalna: ile osób faktycznie ugotowało to samo.

**Dlaczego to wyróżnik:** rozwiązuje też problem pustej aplikacji na starcie —
przepisy tworzą użytkownicy, a treść ma konkretny format, więc łatwiej ją porównywać.

**Trudność:** średnia. Wymaga moderacji (aplikacja publiczna).

---

## 4. Czego bym nie robił

- **„Zrób zdjęcie posiłku, AI policzy kalorie"** — efektowne na pokazie, w praktyce
  myli się o kilkadziesiąt procent, a użytkownicy szybko tracą zaufanie do liczb.
  Nieufność wobec danych to jedna z opisanych przyczyn porzucania aplikacji.
- **Kolejny generator planów z AI** — pełne nasycenie rynku, brak wyróżnika.
- **Codzienne powiadomienia motywacyjne** — działają krótko, potem irytują.
  Nasza obietnica powinna brzmieć odwrotnie: *pięć minut w niedzielę i masz spokój
  na tydzień*.
- **Punkty, odznaki, serie dni** — przy jedzeniu potrafią wzmacniać niezdrowe
  zachowania. Przy aplikacji publicznej to realne ryzyko, nie teoria.

---

## 5. Jak to razem brzmi

Gdyby ująć w jedno zdanie, czym Talerz różni się od reszty:

> **Aplikacja dla ludzi, którzy gotują raz i jedzą trzy dni** — pilnuje, ile
> porcji stoi w lodówce, nie każe wpisywać każdego posiłku i planuje zakupy
> tak, żeby nic się nie zmarnowało.

Zamiast: „planuj posiłki z pomocą AI" — czyli tego, co pisze dziś każdy.

---

## 6. Do rozstrzygnięcia na następnej rozmowie

1. Czy przyjmujemy partie jako podstawowy model danych? To decyzja do podjęcia
   przed projektowaniem bazy — później kosztowna do zmiany.
2. Które dwie funkcje wchodzą do pierwszej publicznej wersji?
3. Czy kierunek cenowy (3.4) traktujemy poważnie, czy odkładamy jako niepewny?
4. Jak szeroko rozumiemy odbiorcę: osoby 50+ gotujące na zapas, czy każdy?
   Wąska grupa na starcie zwykle wygrywa z szeroką.

---

## Źródła

- [10 Best Meal Planning Apps: Our Top Picks for 2026 Compared](https://blog.eatthismuch.com/best-meal-planning-apps/)
- [10 Best Meal Planning Apps in 2026 (Ranked and Compared) — FoodiePrep](https://www.foodieprep.ai/blog/meal-planning-apps-in-2026-which-tools-actually-simplify-your-kitchen)
- [Best AI Meal Prep Apps 2026: Tested for Batch Cooking — Recipy](https://recipyapp.com/blog/best-ai-meal-prep-apps-2026)
- [When and Why Adults Abandon Lifestyle Behavior and Mental Health Mobile Apps: Scoping Review](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11694054/)
- [Why Calorie Tracking Stops Working After a Few Weeks — mymir](https://mymir.app/blog/why-calorie-tracking-stops-working)
- [How to Actually Choose a Calorie Tracker You'll Still Be Using in Six Months](https://learnmuscles.com/blog/2026/07/29/how-to-actually-choose-a-calorie-tracker-youll-still-be-using-in-six-months/)
- [Porównywarka cen z gazetek — Tańszy Koszyk](https://tanszykoszyk.pl/)
- [Lidl Polska — aplikacje mobilne](https://www.lidl.pl/c/aplikacje-mobilne/s10008408)
