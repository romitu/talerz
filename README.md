# Talerz

Aplikacja do planowania posiłków — jeden kod źródłowy, trzy platformy:
Android, iPhone i przeglądarka.

---

## Pierwsze uruchomienie

Otwórz PowerShell w tym folderze. Najprościej: kliknij prawym przyciskiem na
pusty obszar w folderze `talerz` w Eksploratorze plików i wybierz
**„Otwórz w terminalu"**.

### Krok 1 — pobierz biblioteki (tylko za pierwszym razem)

```
npm install
```

Potrwa 2–5 minut i utworzy folder `node_modules` (kilkaset megabajtów).
Tego folderu nie oglądamy i nie wysyłamy do GitHuba — to pobrany kod cudzych
bibliotek.

### Krok 2 — uruchom aplikację

```
npx expo start
```

W terminalu pojawi się kod QR i lista skrótów.

| Chcesz zobaczyć | Zrób |
|---|---|
| Wersję w przeglądarce | naciśnij klawisz `w` |
| Wersję na telefonie | zeskanuj kod QR aplikacją **Expo Go** |
| Zakończyć pracę | `Ctrl + C` |

Telefon i komputer muszą być w tej samej sieci Wi-Fi.

Po zapisaniu zmiany w kodzie aplikacja przeładowuje się sama — nie trzeba
niczego restartować.

---

## Co gdzie leży

```
talerz/
├─ src/
│  ├─ app/              ← ekrany; nazwa pliku = adres w aplikacji
│  │  ├─ _layout.tsx       układ główny i cztery zakładki na dole
│  │  ├─ index.tsx         zakładka „Plan"
│  │  ├─ przepisy.tsx      zakładka „Przepisy"
│  │  ├─ spolecznosc.tsx   zakładka „Społeczność"
│  │  └─ profil.tsx        zakładka „Profil"
│  ├─ components/       ← klocki używane na wielu ekranach (karta, nagłówek)
│  ├─ constants/        ← kolory i odstępy w jednym miejscu
│  └─ data/             ← dane posiłków i przepisów (na razie wpisane na stałe)
├─ assets/              ← ikony i grafiki
├─ app.json             ← nazwa aplikacji, ikona, identyfikatory dla sklepów
└─ package.json         ← lista używanych bibliotek
```

**Zasada expo-router:** każdy plik w `src/app` staje się osobnym ekranem
automatycznie. Nowy plik `zakupy.tsx` = nowy ekran pod adresem `/zakupy`.

---

## Przydatne komendy

| Komenda | Co robi |
|---|---|
| `npx expo start` | uruchamia aplikację do podglądu |
| `npm run typecheck` | sprawdza kod pod kątem błędów, bez uruchamiania |
| `npm run lint` | sprawdza styl i typowe pomyłki |
| `git log --oneline` | pokazuje historię zmian |
| `git diff` | pokazuje, co zmieniło się od ostatniego zapisu |

---

## Stan projektu

**Gotowe**

- Szkielet działający na Androidzie, iPhonie i w przeglądarce
- Cztery zakładki
- Ekran „Plan dnia" z makroskładnikami (2290 kcal, 142 g białka)
- Ekran „Przepisy" z serduszkami (na razie działają tylko do zamknięcia aplikacji)

**Następne kroki**

1. Baza danych Supabase — posiłki i przepisy zapisywane na stałe
2. Logowanie: e-mail, Google, Apple
3. Trwałe polubienia, widoczne dla wszystkich
4. Czat na żywo
5. Polityka prywatności i zgody RODO (wymagane przed publikacją w sklepach)
6. Publikacja przez EAS Build

---

## Gdy coś nie działa

Usuń folder `node_modules` i zainstaluj ponownie:

```
npm install
npx expo start --clear
```

`--clear` czyści pamięć podręczną — rozwiązuje większość dziwnych błędów
po zmianach w plikach konfiguracyjnych.
