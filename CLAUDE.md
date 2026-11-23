# Talerz — zasady pracy

Aplikacja do planowania posiłków (Expo / React Native + web) na Supabase.
Rozmawiamy i piszemy po polsku: komunikaty, komentarze, commity, przepisy.

## Git
- Commity prosto na `main`, bez gałęzi (chyba że użytkownik poprosi o gałąź/PR).
- `git push` tylko na wyraźną prośbę. Push na `main` uruchamia budowanie
  strony na GitHub Pages (`.github/workflows/strona.yml`).

## Dane i katalogi
- **Bez obejść na złe dane.** Duplikaty i błędy w bazie mają być widoczne
  w aplikacji — nie maskuj ich porównywaniem nazw bez wielkości liter,
  zwijaniem „podobnych” itp. Zwijaj tylko to, co jest tym samym bytem (po id).
  Podejrzane dane zgłoś użytkownikowi.
- **Zwarte katalogi** `skladniki` i `sprzet`: bez wariantów typu „Nóż” obok
  „Nóż szefa kuchni”. Nowa pozycja tylko, gdy naprawdę unikalna. Narzędzia
  importu nie dopisują brakujących nazw — przerywają i podpowiadają podobne.
  Istniejących składników nie proponuj scalać (decyzja użytkownika).
- **Kwantyzacja zawsze do całości:** składnik z `mozna_dzielic = false` po
  skalowaniu wychodzi zawsze w całych sztukach. Bez wyjątków („tylko gdy porcja
  bazowa cała” itp.) — `lib/skalowanie-kalorii.ts`. Gdy coś wydaje się temu
  przeczyć, zapytaj.
- **Tylko dorośli:** do 4 profili, wyłącznie 18+. Nie proponuj profili dzieci
  ani podnoszenia limitów. Gdyby temat rodzin wrócił: dodatkowe porcje
  w garnku bez celów.

## Przepisy (narzedzia/przepisy-ai/*.json)
Źródłem prawdy jest baza — użytkownik poprawia przepisy także w aplikacji.
1. Przed edycją JSON wyeksportuj aktualną wersję z bazy:
   `node narzedzia/eksportuj-przepis.mjs "Nazwa" --nadpisz`
   (albo `--wszystkie --nadpisz`). Wymaga `.env.local` z `TALERZ_EMAIL`
   i `TALERZ_HASLO`; bez niego poproś użytkownika o eksport.
2. Popraw JSON (kształt pliku sprawdza `sprawdzPrzepis` w `lib/przepis-json.ts`).
3. Wygeneruj SQL: `node narzedzia/generuj-import-ai.mjs "Plik.json"`
   (`--po=30` dzieli na części). Wynik: `supabase/narzedzia/import-przepisow-ai*.sql`.
4. Użytkownik uruchamia SQL w Supabase → SQL Editor. Przepis o tej samej
   nazwie jest aktualizowany, nie kasowany.
5. Kontrola: ponowny eksport i `git diff` — różnice tylko w końcach linii
   (CRLF) nie są zmianami treści.

Reguły kuchni:
- **Tłuszcz według temperatury:** „Oliwa z oliwek extra virgin” — na zimno,
  średni ogień, piekarnik, grill kontaktowy; „Olej rzepakowy rafinowany” —
  duży ogień, „mocno rozgrzej”, wok, obsmażanie mięsa partiami. Po zamianie
  popraw odmianę w krokach („oleju” ↔ „oliwy” itd.).
- `porcja_g` = suma ilości składników / `liczba_porcji_bazowych`.
- Zmiana czasu w kroku pociąga za sobą `minuty` etapu i `czas_obrobki_min`
  oraz minutniki w powiązanych krokach.

## Supabase: logowanie i maile
- Aplikacja web: `https://romitu.github.io/talerz/` (małe „t”, ukośnik).
- Authentication → URL Configuration: **Site URL** = ten adres;
  **Redirect URLs**: `https://romitu.github.io/talerz/**`, `http://localhost:8081/**`.
  Site URL bywał zmieniany ręcznie (localhost, goły `romitu.github.io`) —
  przy problemach z linkiem z maila poproś o fragment `redirect_to=` z linku.
- Kod podaje adres powrotu sam (`adresPowrotu()` w `lib/haslo.ts`) przy
  rejestracji i resecie hasła.
- Maile wysyła **Resend** przez Custom SMTP (`smtp.resend.com:465`, nadawca
  `Talerz <noreply@mojtalerz.com>`), domena mojtalerz.com zweryfikowana,
  rekordy DNS w Cloudflare. Limit: 30 maili/h, 60 s odstępu na adres.
  Niedoręczenia: Resend → Logs.
- Strona marki: mojtalerz.com. Identyfikator aplikacji `com.romitu.talerz`
  (po publikacji w sklepie nie do zmiany).
