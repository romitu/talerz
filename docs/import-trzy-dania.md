# Trzy dania próbne — co zrobić i czego się spodziewać

Wszystko sprawdzone na prawdziwym PostgreSQL, na **wartościach z Twojej bazy**,
a nie na moich. Kolejność ma znaczenie.

---

## Nic nie zostanie nadpisane

Miałeś rację, że warto uważać. W Twojej bazie były już decyzje, których moja
migracja nie znała: marchewka 70 g, ząbek czosnku 5 g, papryka 150 g.
Ja proponowałem 75, 4 i 120.

**Migracja 0012 wypełnia teraz wyłącznie puste pola.** Twoje wartości zostają,
a skrypt na końcu wypisuje, czego nie ruszył i co proponował — możesz porównać
i zdecydować sam. Test to sprawdza osobno, właśnie dlatego, że o to pytałeś.

Import przepisów usuwa wyłącznie trzy nazwy: „Zupa pomidorowa z ryżem",
„Kurczak po tajsku", „Twaróg z warzywami". Ogórkowa i reszta są nietknięte.

---

## Kroki

**1. Popraw fasolkę**

Pierwszy import trafił w fasolkę **żółtą** zamiast zielonej. Wartości wyszły
niemal identyczne, ale nazwa kłamie:

```
node narzedzia/import-usda.mjs --tylko=szparagowa
```

**2. Wgraj składniki ręczne**

`supabase/narzedzia/skladniki-recznie.sql` — mleko kokosowe light, pasta curry
**i poprawka twarogu** (patrz niżej, to ważne).

Wartości mleka kokosowego są wyliczone, nie zmierzone. **Sprawdź etykietę** —
przy 400 ml na garnek to ma znaczenie. Przy paście curry nie ma żadnego
(7 g na porcję).

**3. Wgraj dwie migracje**

`0012_jednostki_domowe.sql`, potem `0013_danie_bez_gotowania.sql`.

**4. Wgraj przepisy**

`supabase/narzedzia/import-przepisow.sql`. Można uruchamiać wielokrotnie —
przepis o tej samej nazwie jest najpierw usuwany, duplikaty nie powstaną.

Na końcu skrypt sam pokaże tabelkę z wynikami.

> Wody i pietruszki korzenia **nie musisz dodawać** — masz je. Nazwałeś je
> krócej niż USDA („woda", „Pietruszka korzeń", „Seler korzeń"), więc to
> mapowanie zostało poprawione na Twoje nazwy.

---

## Twaróg półtłusty to nie serek wiejski

To znalazło się przy okazji i jest poważniejsze niż sam import.

USDA podstawiło pod „Twaróg półtłusty" **cottage cheese** — serek wiejski,
ziarnisty, w śmietance:

| | kcal | białko |
|---|---|---|
| To, co masz w bazie (USDA cottage cheese) | 84 | **11,0 g** |
| Polski twaróg półtłusty (tabele IŻŻ) | 133 | **18,7 g** |

Przy 210 g twarogu na śniadanie to różnica **16 g białka** — tyle, ile daje
solidny kawałek mięsa. Aplikacja mówiłaby Ci, że brakuje białka, kiedy
w rzeczywistości je zjadłeś.

Poprawka jest w `skladniki-recznie.sql`. Sprawdź jeszcze etykietę swojego
twarogu — producenci różnią się o 10–15%.

To samo warto potem przejrzeć przy innych produktach polskich, których USDA
nie zna: śmietana, kefir, kiełbasa, wędliny.

---

## Czego się spodziewać

To są liczby z testu policzone na Twoich składnikach, więc dokładnie to zobaczysz:

| Danie | Talerz | Planer | Różnica |
|---|---|---|---|
| Zupa pomidorowa z ryżem | **526 kcal, 27 g B** | 645 kcal, 33 g | −18% |
| Kurczak po tajsku | **639 kcal, 46 g B** | 805 kcal, 51 g | −21% |
| Twaróg z warzywami | **602 kcal, 53 g B** | 640 kcal, 49 g | −6% |

### Kurczak po tajsku — dlaczego trzy porcje, nie dwie

Planer dzielił ten garnek na dwie porcje. Po przeliczeniu ze składników
wychodziło z tego **945 kcal i 67 g białka na porcję** — bo przepis daje
250 g surowej piersi na osobę. To nie jest błąd rachunku, tylko duże danie.

Nic nie zmieniamy w składnikach. Ten sam garnek dzielimy na **trzy porcje
po 575 g**: 639 kcal i 46 g białka. Gotujesz raz, jesz przez trzy dni,
a obiad mieści się w dziennym rozkładzie.

W mapowaniu to jedna liczba: `porcja_g` z 850 na 575.

### Dlaczego zupa wyszła niżej

Planer liczył udka **ze skórą i kością**. W bazie jest samo mięso — i to jest
poprawne, bo kości nie zjadasz. Ten sam problem znaleźliśmy przy żeberkach
w ogórkowej.

### Dlaczego tajski wyszedł wyżej — i to jest ciekawsze

Przepis daje **250 g surowej piersi z kurczaka na porcję**. Sama pierś to już
**56 g białka**. Planer podawał dla całego dania 51 g, czyli mniej, niż wynosi
zawartość samego mięsa.

To nie jest zaokrąglenie. To znaczy, że **wartości w starym planerze były
zgadywane**, a nie liczone. Dla trzech dań różnica wyszła raz w jedną, raz
w drugą stronę — czyli przy pozostałych dwudziestu siedmiu też trzeba się
spodziewać niespodzianek.

Dobra wiadomość: teraz liczby biorą się ze składników i da się je sprawdzić.

---

## Co znalazł test, a czego nie widać w SQL-u

Dwie rzeczy wyszły dopiero przy uruchomieniu na prawdziwej bazie:

**Twaróg z warzywami się nie wgrywał.** Baza wymagała, żeby czas obróbki był
większy od zera — zakładaliśmy, że każde danie się gotuje. Twarogu z rzodkiewką
się nie gotuje. Stąd migracja 0013.

**Udka z kurczaka nie miały masy sztuki**, więc gramatura wychodziła pusta.
Dopisane do 0012. Generator sprawdza to teraz sam i przerywa z czytelnym
komunikatem, zamiast wstawiać puste wartości.

**Migracja nadpisywała Twoje przeliczniki.** Wyszło dopiero wtedy, gdy
przepisałem test na wartości z Twojej bazy. Teraz wypełnia wyłącznie puste pola.

---

## Jak to jest zbudowane

Nie pisałem SQL-a ręcznie — przy trzydziestu daniach każda poprawka
w przelicznikach oznaczałaby przepisywanie wszystkiego od nowa.

```
narzedzia/planer-html-dania.json      surowe dane ze starego planera
narzedzia/mapowanie-planera.json      Twoje decyzje: co na co, ile wody, jak
                                      przechowywać  ← TO SIĘ EDYTUJE
narzedzia/generuj-import.mjs          generator
supabase/narzedzia/import-przepisow.sql   wynik  ← TEGO NIE EDYTUJ
```

Chcesz zmienić wagę porcji zupy albo ilość wody — poprawiasz mapowanie
i uruchamiasz `node narzedzia/generuj-import.mjs`.

Generator **niczego nie zgaduje**. Jeśli składnika nie ma w mapowaniu, przerywa
i mówi którego. Cicho podstawiony „podobny" składnik byłby gorszy niż błąd,
bo nikt by go nie zauważył.

---

## Co dopisałem od siebie

Stary planer nie miał tych pól, więc je wymyśliłem. **Przejrzyj i popraw**,
zwłaszcza przechowywanie — Ty wiesz, ile te dania naprawdę wytrzymują:

- lista sprzętu
- jak przechowywać i czy można mrozić
- jak uratować danie
- podział czasu na przygotowanie i obróbkę (przyjąłem jedną trzecią przy blacie)
- waga porcji: zupa 900 g, tajski 850 g, twaróg 510 g

Wszystkie kroki trafiły do jednego etapu „Przygotowanie". Podział na etapy
uzupełnisz w aplikacji tam, gdzie Ci na tym zależy.

---

## Zanim ruszymy z resztą

Wersja na Twojej stronie jest nowsza niż w repozytorium — ma 31 dań zamiast 30
i inne wartości szakszuki. Wrzuć aktualny `index.html` do `romitu/dieta`,
zanim zaimportujemy pozostałe dwadzieścia siedem.

Do rozwiązania przy fasolce po bretońsku: **puszka fasoli to 240 g fasoli
ugotowanej, a w bazie jest sucha** (330 kcal/100 g). Wpisanie 240 g suchej
zawyżyłoby danie o jakieś 500 kcal. Trzeba osobnego składnika.
