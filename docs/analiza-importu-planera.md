# Import przepisów ze starego planera — analiza

Stan na 15.08.2026. Nic jeszcze nie zaimportowano.

---

## 1. Skąd wzięte są dane

Plik, który wrzuciłeś, to **`Planer posiłków — 14 dni.mhtml`** — archiwum strony,
nie zwykły `.html`. Dlatego wcześniej go nie znalazłem: szukałem `*.html`.

W archiwum **nie ma przepisów**. Zapisuje się w nim tylko to, co było widoczne
na ekranie, a Ty miałeś otwartą zakładkę „Plan i dania". Składniki i kroki
powstają w przeglądarce dopiero po kliknięciu w „Przepisy" — do pliku nie trafiły.

Sięgnąłem więc po źródło strony z Twojego repozytorium
`github.com/romitu/dieta`, gałąź `main`. Tam w skrypcie jest tablica `DISHES`
z kompletem danych. Zapisałem ją jako
`narzedzia/planer-html-dania.json`, żeby nie pobierać jej po raz drugi.

### Uwaga: masz dwie różne wersje

| | Zapisany `.mhtml` (15.08) | Repozytorium `main` (12.08) |
|---|---|---|
| Liczba dań | 31 | 30 |
| Kolacje | 9 | 8 |
| Szakszuka | 635 kcal, 20 min | 665 kcal, 25 min |
| Zakładki | Plan / Zakupy / Przepisy | Zakupy / Przepisy |
| Zdjęcia dań | tak (gałąź `foto`) | nie |

Wersja, z której korzystasz na co dzień, jest **nowsza niż to, co leży
w repozytorium**. Brakuje w niej między innymi dania
**„Grillowany kurczak z ogórkiem kiszonym"** (655 kcal, 66 g białka).

Zanim zaimportujemy — warto, żebyś wrzucił do repozytorium aktualny
`index.html`. Inaczej zaimportujemy wersję sprzed trzech dni.

---

## 2. Co dokładnie jest w danych

Z 30 dań gałęzi `main`:

| | ile |
|---|---|
| Dania | 30 |
| Wpisów składnikowych | 270 |
| Unikalnych nazw składników | 92 |
| Kroków przygotowania | 162 |
| Wskazówek („tip") | 25 |
| Dania garnkowe (na zapas) | 17 |

Podział: Obiady 9, Śniadania 8, Kolacje 8, Dania azjatyckie 5.

Każde danie ma: nazwę, kcal, białko, czas, oznaczenie weekendowe, sensowną
wielkość partii, listę składników z ilościami i działem sklepu, kroki
przygotowania i często wskazówkę.

**To dobry materiał.** Kroki są konkretne, wskazówki wartościowe
(„nabiał zawsze po zdjęciu z ognia", „kwas w gotującym mleku kokosowym
powoduje rozwarstwienie"). Nie ma tu nic do wyrzucenia.

---

## 3. Czego brakuje w bazie składników

Baza ma 81 pozycji z USDA. Z 92 nazw z planera:

- **około 40 trafia wprost** (czosnek, marchew, cebula, passata, pierś z kurczaka…)
- **około 15 to ta sama rzecz inaczej nazwana** — „Jajka" ↔ „Jaja kurze",
  „Pomidor" ↔ „Pomidory, surowe", „Ogórek kiszony" ↔ „Ogórki kiszone",
  „Udka z kurczaka" ↔ „Udo z kurczaka bez skóry"
- **około 35 trzeba dopisać**

Do dopisania (pogrupowane):

**Mięso** — schab wieprzowy, polędwiczka wieprzowa, szynka wieprzowa chuda,
mięso gulaszowe, mielone wołowo-wieprzowe, wołowina na plastry (udziec/rostbef)

**Warzywa** — pieczarki, boczniaki, awokado, rukola, rzodkiewki, szczypiorek,
por, kapusta biała, kapusta kiszona, imbir świeży, cebula czerwona

**Nabiał** — halloumi

**Sypkie** — ryż basmati (baza ma tylko brązowy), kasza jęczmienna,
otręby owsiane, bułka tarta, masło orzechowe bez cukru,
orzechy mieszane niesolone

**Puszki i słoiki** — sos sojowy, bulion warzywny, chrzan tarty, pasta curry,
fasola czerwona z puszki, oliwki czarne, mleko kokosowe light

**Mrożonki** — szpinak mrożony, fasolka szparagowa mrożona,
groszek zielony mrożony

**Przyprawy** — cynamon, kmin rzymski, tymianek, rozmaryn, majeranek,
papryka ostra, biały pieprz

Mrożonki i wersje „light" mają inne wartości niż surowe odpowiedniki, więc
to osobne pozycje, a nie duplikaty. Wszystkie są w USDA — nasz skrypt
`import-usda.mjs` je pobierze.

---

## 4. Pięć rzeczy, które nie przekładają się wprost

To jest sedno analizy. Import nie jest przepisaniem pola w pole.

### 4.1 Jednostki domowe

Planer używa siedmiu jednostek, których Talerz nie zna:

| Jednostka | Ile razy | Ile to gramów |
|---|---|---|
| łyżka | 33 | oliwa 12 g, jogurt 20 g, sos sojowy 16 g — zależy od produktu |
| ząbek | 17 | czosnek ~4 g |
| kromka | 14 | chleb razowy ~35 g |
| puszka | 5 | tuńczyk 140 g po odsączeniu, fasola 240 g |
| torebka | 2 | kasza 100 g suchej |
| łyżeczka | 1 | oliwa 4 g |

Talerz liczy makro z gramów, więc **każdą z tych jednostek trzeba przeliczyć**.
„Łyżka" jest najgorsza, bo znaczy co innego dla oliwy niż dla jogurtu —
przelicznik musi siedzieć przy składniku, nie przy jednostce.

Mamy już do tego miejsce: kolumnę `masa_sztuki_g`. Dla czosnku wpisujemy 4,
dla chleba 35 i „ząbek" oraz „kromka" stają się zwykłymi sztukami.

### 4.2 Ułamki sztuk

**104 z 270 ilości to ułamki** — „0,6667 cebuli", „0,3333 pietruszki".
Biorą się stąd, że planer dzieli garnek na 3 porcje i pokazuje jedną trzecią.

W Talerzu przepis jest zdefiniowany na jedną porcję bazową, więc formalnie
pasuje. Ale „dwie trzecie cebuli" w przepisie wygląda źle i nie da się tego
kupić. **Proponuję importować na poziomie garnka** (×3 dla dania garnkowego),
czyli tak, jak faktycznie gotujesz — wtedy wychodzą 2 cebule, nie 0,6667.

### 4.3 Waga porcji

Planer w ogóle nie zna wagi porcji — porcja to „tyle, ile wyszło z przepisu".
Talerz wymaga `porcja_g` albo liczby sztuk.

Da się to policzyć: suma gramów wszystkich składników ÷ liczba porcji.
Dla zup wyjdzie sensownie. Dla dań smażonych będzie zawyżone, bo woda odparowuje,
a masa surowego mięsa to nie masa usmażonego. **Wartości trzeba będzie przejrzeć
ręcznie**, danie po daniu.

### 4.4 Kalorie się nie zgodzą

To jest najważniejsze i chcę, żeby nie było niespodzianki.

W planerze kcal i białko są **wpisane ręcznie** — sam podpis pod stroną mówi
„wartości szacunkowe (±10%)". Talerz liczy makro **ze składników**.

Po imporcie te same dania pokażą inne liczby. Prawdopodobnie niższe białko,
bo USDA podaje wartości dla mięsa bez kości i bez odpadu — dokładnie ten sam
problem, na który trafiliśmy przy żeberkach w ogórkowej.

To zmiana na lepsze, bo liczby będą wynikać z czegoś sprawdzalnego. Ale plan
dnia, który u Ciebie wychodzi na 2085 kcal, w Talerzu może pokazać 1900 albo 2200.

### 4.5 Brak etapów, sprzętu i przechowywania

Planer ma **płaską listę kroków**. Talerz wymaga co najmniej jednego etapu
z nazwą i czasem, a dodatkowo ma pola, których w planerze nie ma:

- lista sprzętu
- jak przechowywać, czy można mrozić
- jak uratować danie

Część tych informacji siedzi we wskazówkach, ale wymieszana z techniką
(„fasolę przepłucz" to technika, „trzyma się w lodówce 4 dni" to przechowywanie).
Rozdzielenie tego automatycznie byłoby zgadywaniem.

**Propozycja:** import tworzy jeden etap „Przygotowanie" z całym czasem dania
i wszystkimi krokami. Pola przechowywania zostają puste, wskazówka trafia
do opisu. Podział na etapy i resztę uzupełniasz potem ręcznie — tam, gdzie
Ci na tym zależy.

---

## 5. Dwie rzeczy do przemyślenia, nie techniczne

**Kuchnia.** Talerz miał być śródziemnomorski. Z 30 dań śródziemnomorskich jest
może osiem. Reszta to kuchnia polska (barszcz, krupnik, fasolka po bretońsku,
schab) i azjatycka. Trzeba albo poszerzyć deklarowaną tożsamość aplikacji,
albo oznaczyć te dania jako inną kuchnię i pogodzić się z tym, że baza startowa
jest mieszana.

**„Do smaku".** 36 wpisów nie ma ilości — cynamon, tymianek, majeranek.
Talerz wymaga liczby. Można wpisać 0 g (nie wpłynie na makro, ale w liście
zakupów zniknie) albo dopisać do modelu znacznik „do smaku". Skłaniam się
ku drugiemu — inaczej wychodząc do sklepu nie wiesz, że potrzebujesz majeranku.

---

## 6. Co proponuję

Trzy etapy, każdy do sprawdzenia zanim ruszy następny:

1. **Uzupełnić bazę składników** — dopisać ~35 pozycji przez `import-usda.mjs`
   plus przelicznik gramów dla łyżek, kromek i ząbków.
2. **Skrypt importu** — wypluwa SQL, który wgrywasz w panelu Supabase.
   Najpierw dla trzech dań na próbę, żebyś zobaczył, jak wyglądają w aplikacji.
3. **Reszta** — po Twojej akceptacji tych trzech.

Zanim zacznę, potrzebuję od Ciebie dwóch rzeczy: aktualnego `index.html`
w repozytorium (patrz punkt 1) i decyzji, czy importujemy wszystkie 30 dań,
czy tylko te, które faktycznie gotujesz.
