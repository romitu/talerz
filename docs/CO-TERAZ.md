# Co teraz — siedem kroków po kolei

Wszystko jest gotowe i sprawdzone. Zostało to wykonać. Rób po kolei,
każdy krok mówi, co ma się stać.

---

## 1. Wgraj składniki ręczne

SQL Editor w Supabase → wklej całą zawartość:

```
supabase/narzedzia/skladniki-recznie.sql
```

Dokłada mleko kokosowe light, pastę curry, sos sojowy, halloumi, pastę tom kha,
sól, otręby, chia, cynamon — i **poprawia twaróg półtłusty** (USDA podstawił
serek wiejski, patrz niżej).

---

## 2. Wgraj 32 składniki z planera

SQL Editor → cała zawartość:

```
supabase/narzedzia/skladniki-z-planera.sql
```

Schab, polędwiczka, pieczarki, boczniaki, awokado, rukola, kapusta, kasza
jęczmienna, fasola z puszki, mrożonki i przyprawy — wszystko, czego potrzebują
przenoszone przepisy.

**Powinno wypisać** tabelkę z 42 pozycjami (`zrodlo = wlasne`).

> Wartości wpisane wprost z USDA, zamiast pobierane skryptem. Dopisywanie ich
> po jednej, po każdej nieudanej próbie importu, zajęłoby więcej czasu —
> a część i tak by nie przeszła, bo USDA przy otrębach owsianych podstawia
> muffiny, a przy nasionach chia napoje.
>
> Skrypt `import-usda.mjs` zostaje do przyszłych składników; te 32 są już
> załatwione.

---

## 3. Wgraj siedem migracji, po kolei

SQL Editor, każdą osobno, w tej kolejności:

| Plik | Co robi |
|---|---|
| `0012_jednostki_domowe.sql` | łyżka, ząbek, kromka → gramy |
| `0013_danie_bez_gotowania.sql` | pozwala na danie bez obróbki termicznej |
| `0014_dodatki.sql` | czwarta kategoria przepisu |
| `0015_dodatek_nie_jest_pora.sql` | dodatek nie wchodzi do planu jako pora |
| `0016_zdjecia_przepisow.sql` | miejsce na zdjęcia |
| `0017_jednostki_pozostalych_dan.sql` | awokado, cebula czerwona, puszka fasoli |
| `0018_nazwa_przepisu_niepowtarzalna.sql` | po nazwie import rozpoznaje danie |

**0014 i 0015 muszą być osobno** — PostgreSQL nie pozwala użyć świeżo dodanej
wartości typu w tej samej transakcji.

Migracja 0012 wypisze, co wypełniła i **czego nie ruszyła**. Twoje wcześniejsze
wartości (marchewka 70 g, czosnek 5 g) zostają nietknięte.

---

## 4. Sprawdź, czy niczego nie brakuje

SQL Editor → `supabase/narzedzia/sprawdz-skladniki.sql`

Wynik to jedna tabelka. **Ma w niej być tylko jeden wiersz — `INFO`.**

| Co widzisz | Co zrobić |
|---|---|
| tylko `INFO` | wszystko gotowe, idź dalej |
| `BRAK SKLADNIKA` | wróć do kroku 1 i 2; jeśli zostaje — wklej mi listę |
| `BRAK MASY SZTUKI` | wróć do kroku 3, migracje 0012 i 0017 |

To zapytanie istnieje po to, żeby nie odkrywać braków po jednym.
Import przerywa się na **pierwszym** brakującym składniku i cofa całą resztę —
dlatego po nieudanej próbie w bazie nie ma ani jednego nowego przepisu,
tylko Twoje stare sześć.

---

## 5. Wgraj wszystkie przepisy

SQL Editor → cała zawartość:

```
supabase/narzedzia/import-przepisow.sql
```

To jest duży plik. Supabase pokaże ostrzeżenie o operacjach niszczących —
to normalne.

**Żaden przepis nie zostanie skasowany.** Jeśli danie o tej nazwie już jest
w bazie, import je aktualizuje w miejscu i wymienia tylko treść: składniki,
etapy i kroki. Identyfikator zostaje ten sam, więc plan, polubienia i zdjęcie
trzymają się przepisu. Twoja ogórkowa nie jest nawet dotykana.

**Na końcu są dwie tabelki:**

1. **Pusta** — to sprawdzenie, czy wszystko weszło. Gdyby jakiegoś składnika
   zabrakło, wpisałby się tu wiersz „składników miało być 12, jest 11".
2. **31 dań** — waga porcji, ile porcji wychodzi z garnka, kalorie i białko.

Można uruchamiać wielokrotnie.

> Cały plik to zwykłe `insert` i `update`, bez bloków PL/pgSQL. Panel Supabase
> przy dużych skryptach gubi się na cudzysłowach dolarowych — dopisuje własne
> instrukcje w środku i wywala „unterminated dollar-quoted string".

---

## 6. Odśwież aplikację

W oknie Metro naciśnij `R`. Zobaczysz:

- **Dolna wstążka** — nowa zakładka **Zakupy**, obok Planu
- **Przepisy** — zakładki Wszystkie / Śniadania / Obiady / Kolacje / Dodatki
  z licznikami, a pod nimi 31 dań
- **Formularz przepisu** — nowe pole **ZDJĘCIE** pod krótkim opisem
- **Plan dnia** — pierwszy dzień z pola rozwijanego

---

## 7. Zdjęcia

**Nowe zdjęcia** dodajesz w formularzu przepisu: Przepisy → ołówek przy daniu →
„Dodaj zdjęcie". Wybierasz plik, aplikacja sama go zmniejsza do 1024 px
i wysyła. Można wymienić i usunąć.

**Stare zdjęcia z planera** — otwórz https://romitu.github.io/dieta/, naciśnij
F12, zakładka Console, wklej całą zawartość `narzedzia/wyjmij-zdjecia.js`.
(Chrome przy pierwszym wklejeniu każe wpisać `allow pasting`.)

Pobierze plik `zdjecia-planera.json`. Wrzuć go do folderu projektu i uruchom:

```
node narzedzia/wgraj-zdjecia.mjs zdjecia-planera.json --podglad
```

Najpierw z `--podglad` — pokaże, co gdzie trafi, nic nie wysyłając.
Potem to samo bez `--podglad`.

---

## Cztery rzeczy, o których warto wiedzieć

**Twaróg półtłusty był serkiem wiejskim.** USDA podstawiło *cottage cheese*:
84 kcal i 11 g białka zamiast 133 i 18,7. Przy 210 g na śniadanie to 16 g
białka różnicy — aplikacja mówiłaby, że brakuje Ci białka, choć je zjadłeś.
Krok 2 to poprawia. Sprawdź jeszcze etykietę swojego twarogu.

**Trwałość skrócona z 4 dni do 3.** Planer przy barszczu, gulaszu, dorszu,
fasolce i schabie pisał „trzyma się 4 dni". Talerz ma zasadę „najwyżej 3"
i baza jej pilnuje. Jeśli uznasz, że 4 dni są w porządku, zmieniamy zasadę
w jednym miejscu — ale świadomie, nie przy okazji importu.

**Bulion z kostki liczy się jako gotowy płyn.** Kostka ma około 250 kcal
na 100 g, ale przepis podaje „200 ml bulionu", czyli płyn. Kostka waży 10 g
i robi 500 ml, więc 200 ml to 4 g kostki — jakieś 10 kcal. Gdyby wpisać
wartości kostki, wyszłoby 500 kcal zamiast 10. Lista zakupów wypisze
„bulion warzywny gotowy, 1200 ml" — czyli dwie i pół kostki.

**Kalorie nie zgodzą się z planerem** i to jest w porządku. W planerze były
wpisane ręcznie („szacunkowe ±10%"), tutaj liczą się ze składników. Trzy dania
sprawdzone dokładnie: zupa pomidorowa −18%, kurczak po tajsku −21%,
twaróg z warzywami −6%.

---

## Czego jeszcze nie ma

- **Zdjęcia z aparatu telefonu.** Na razie dodajesz je z przeglądarki.
  Dołożenie tego wymaga biblioteki `expo-image-picker`, której nie dało się
  zainstalować z mojej strony. Gdy będzie potrzebne, uruchomisz
  `npx expo install expo-image-picker` i podmienię jedną funkcję.
- **Fasola z puszki policzona osobno** — jest już jako własny składnik,
  więc fasolka po bretońsku i barszcz liczą się poprawnie.
- **Przegląd tego, co dopisałem od siebie**: sprzęt, przechowywanie, mrożenie
  i „jak uratować danie" przy 28 daniach. Planer tych pól nie miał. Przejrzyj
  je przy okazji gotowania i popraw, co nie pasuje.
