# Jak wpisać zupę ogórkową — krok po kroku

Przejście przez cały przepis, pole po polu. Na tym przykładzie widać, gdzie
aplikacja pomaga, a gdzie wymaga decyzji.

---

## Zanim zaczniesz: brakujące składniki

Jedenaście składników z tego przepisu nie było w bazie. Dopisałem je do listy
importu, więc wystarczy pobrać je z USDA:

```
node narzedzia/import-usda.mjs
```

Dojdą: żeberka wieprzowe, korpus z kurczaka, seler korzeniowy, pietruszka
korzeń, ogórki kiszone, śmietana 18%, koperek, liść laurowy, ziele angielskie,
sól, olej rzepakowy.

**Dwa składniki trzeba dodać ręcznie**, bo USDA ich nie ma albo nie mają
wartości odżywczych:

| Nazwa | kcal | B | T | W | błonnik | NOVA |
|---|---|---|---|---|---|---|
| Woda | 0 | 0 | 0 | 0 | 0 | 1 |
| Kwas z ogórków kiszonych | 4 | 0.3 | 0 | 0.8 | 0 | 3 |

Przy wodzie zobaczysz ostrzeżenie „wszystkie wartości są zerowe". Tutaj jest to
prawda, więc zapisz mimo niego.

---

## 1. Nazwa i opis

| Pole | Wartość |
|---|---|
| Nazwa | `Zupa ogórkowa` |
| Krótki opis | `Na wywarze z żeberek, z podsmażanymi ogórkami. Wychodzi garnek 3-litrowy.` |

---

## 2. Metryczka

**Sposób porcjowania: NA WAGĘ.** To zupa — dzielisz ją chochlą, nie na sztuki.

| Pole | Wartość |
|---|---|
| Waga jednej porcji | `350` g |
| Czas przygotowania | `20` min |
| Czas obróbki | `50` min |

Twoje „około 4–6 porcji" nie trafia nigdzie, bo nie jest już potrzebne.
Aplikacja policzy liczbę porcji sama, gdy wpiszesz składniki — z masy garnka
podzielonej przez 350 g.

> **Uwaga o parowaniu.** Suma składników to około 4,4 kg, ale po 50 minutach
> gotowania odparuje 300–500 ml. Jeśli chcesz, żeby liczba porcji się zgadzała,
> wpisz przy wodzie **2100 ml zamiast 2500** — reszta i tak wyparuje.
> Wartości odżywcze się przez to nie zmienią, bo woda ich nie wnosi.

---

## 3. Pora, kuchnia, trwałość

| Pole | Wartość |
|---|---|
| Pora posiłku | Obiad |
| Kuchnia | polska |
| Trwałość | najwyżej 3 dni |

Kuchnia polska, nie śródziemnomorska — bądźmy uczciwi wobec własnych etykiet.

---

## 4. Składniki

Filtrujesz, dotykasz wiersza, wiersz się rozwija, wpisujesz ilość. Kolejność
dodawania staje się kolejnością w przepisie, więc dodawaj tak, jak w oryginale.

| # | Składnik w bazie | Ile | Jedn. | Stan | Zamiennik |
|---|---|---|---|---|---|
| 1 | Żeberka wieprzowe, surowe | 500 | g | — | lub 500 g korpusu z kurczaka (o ok. 500 kcal mniej) |
| 2 | Woda | 2100 | ml | zimna | — |
| 3 | Marchew, surowa | 150 | g | obrana, starta na grubych oczkach | — |
| 4 | Pietruszka korzeń, surowa | 100 | g | obrana, starta na grubych oczkach | — |
| 5 | Seler korzeniowy, surowy | 50 | g | obrany, starty na grubych oczkach | — |
| 6 | Ziemniaki, surowe | 400 | g | obrane, w kostce 1,5 cm | — |
| 7 | Sól kuchenna | 15 | g | — | — |
| 8 | Liść laurowy | 1 | g | 2 sztuki | — |
| 9 | Ziele angielskie mielone | 1 | g | 4 ziarna | — |
| 10 | Masło | 20 | g | — | lub 20 ml oleju rzepakowego |
| 11 | Ogórki kiszone | 350 | g | starte na grubych oczkach | — |
| 12 | Kwas z ogórków kiszonych | 100 | ml | odlany ze słoika | — |
| 13 | Śmietana 18% | 100 | ml | kwaśna, w temperaturze pokojowej | — |
| 14 | Koperek świeży | 15 | g | drobno posiekany | — |

**Liść laurowy i ziele angielskie** podaj w gramach, a liczbę sztuk wpisz
w polu „stan". Dwa liście laurowe ważą około grama — wartości odżywcze są
przy tym pomijalne, ale przepis ma być kompletny.

---

## 5. Sprzęt

Wszystko jest w katalogu poza miseczką — ją dopiszesz polem pod tabelą.

- Garnek 3 l
- Tarka o grubych oczkach
- Patelnia 24 cm
- Nóż szefa kuchni
- Deska do krojenia
- *Miseczka do hartowania śmietany* — dopisz

---

## 6. Etapy

Cztery etapy, każdy z czasem. Kroki wpisujesz w kolejności; przy krokach
z ostrzeżeniem włączasz przełącznik **uwaga**, a tam, gdzie liczy się wygląd,
wypełniasz pole **„po czym poznać, że gotowe"**.

### Etap 1 — Przygotowanie wywaru (30 min)

| Krok | Treść | Sygnał | Uwaga |
|---|---|---|---|
| 1 | Włóż mięso do garnka i wlej zimną wodę | | |
| 2 | Doprowadź do wrzenia na dużym ogniu | | |
| 3 | Zmniejsz ogień na minimum | | |
| 4 | Zbierz łyżką szumowiny z powierzchni | aż powierzchnia będzie czysta | |
| 5 | Dodaj liście laurowe, ziele angielskie i sól | | |
| 6 | Gotuj pod przykryciem 30 minut | aż mięso będzie prawie miękkie | |

### Etap 2 — Gotowanie warzyw (15 min)

| Krok | Treść | Sygnał | Uwaga |
|---|---|---|---|
| 1 | Dodaj startą marchewkę, pietruszkę i seler | | |
| 2 | Dodaj ziemniaki pokrojone w kostkę | | |
| 3 | Gotuj 15 minut | aż ziemniaki będą całkowicie miękkie | |
| 4 | Ziemniaki muszą być miękkie przed kolejnym etapem | | **tak** |

### Etap 3 — Ogórki (15 min)

| Krok | Treść | Sygnał | Uwaga |
|---|---|---|---|
| 1 | Rozgrzej masło na patelni | | |
| 2 | Smaż starte ogórki 5 minut na średnim ogniu | aż zciemnieją i zmiękną | |
| 3 | Przełóż podsmażone ogórki do garnka | | |
| 4 | Nie dodawaj ogórków przed ugotowaniem ziemniaków — kwas zablokuje mięknięcie i ziemniaki zostaną twarde na zawsze | | **tak** |
| 5 | Gotuj na małym ogniu 10 minut | | |
| 6 | Spróbuj. Jeśli wolisz kwaśniejszą, wlej kwas z ogórków | | |

### Etap 4 — Zabielanie (2 min)

| Krok | Treść | Sygnał | Uwaga |
|---|---|---|---|
| 1 | Wlej śmietanę do miseczki | | |
| 2 | Odlej z garnka chochelkę gorącego wywaru | | |
| 3 | Wlej gorący wywar do śmietany, mieszając energicznie widelcem | aż masa będzie jednolita | |
| 4 | Wlej zahartowaną śmietanę do garnka, cały czas mieszając | | |
| 5 | Wyłącz ogień | | |
| 6 | Wsyp posiekany koperek | | |

Suma czasów etapów: 62 minuty. Twoje „50 minut gotowania" dotyczy samego
garnka — etapy 2 i 3 częściowo się nakładają, bo ogórki smażysz w międzyczasie.
Aplikacja to zaznacza pod listą etapów.

---

## 7. Przechowywanie i wskazówki

**Jak przechowywać**

> Po wystudzeniu w lodówce, pod przykryciem, do 3 dni.

**Mrożenie:** Nie

**Jak uratować danie**

> Za kwaśna — dodaj 50 ml śmietanki 30% albo pół łyżeczki cukru.
> Za słona — wrzuć obranego surowego ziemniaka, gotuj 10 minut i wyrzuć go.
> Śmietana się zwarzyła — zblenduj część zupy z łyżką śmietany na gładko
> i wmieszaj z powrotem.

---

## Czego się spodziewać po zapisaniu

Przy wadze porcji 350 g i masie garnka około 3800 g wyjdzie **około 11 porcji**
— znacznie więcej niż Twoje „4–6". To nie błąd: w Twoim rachunku porcja miała
600–900 ml, czyli głęboki talerz z dokładką.

Jeśli 350 g wydaje się za mało, wpisz **600 g** — wyjdzie około 6 porcji
i to będzie zgodne z Twoim pierwotnym oszacowaniem. Wartość jest Twoją decyzją;
aplikacja tylko pilnuje, żeby liczby się zgadzały.

Kaloryczność całego garnka powinna wyjść zbliżona do Twoich 2054 kcal.
Różnica rzędu kilku procent wyniknie z tego, że USDA podaje inne wartości
dla żeberek niż tabele polskie.
