# Talerz

Aplikacja do planowania posiłków — jeden kod źródłowy, trzy platformy:
Android, iPhone i przeglądarka.

Zbudowana na **Expo SDK 54** — tej wersji wymaga Expo Go zainstalowane
na telefonie.

---

## Uruchomienie — najprościej

**Kliknij dwukrotnie `Uruchom Talerz.cmd`.**

Plik sam sprawdzi, czy wszystko jest na miejscu, w razie potrzeby pobierze
biblioteki i otworzy aplikację w przeglądarce. Kod QR dla telefonu pojawi się
w oknie konsoli.

Gdy coś zacznie się dziwnie zachowywać — `Napraw i uruchom.cmd`. Czyści pamięć
podręczną, a w razie potrzeby pobiera biblioteki od nowa.

**Skrót na pulpicie:** kliknij prawym przyciskiem na `Uruchom Talerz.cmd` →
Pokaż więcej opcji → Wyślij do → Pulpit (utwórz skrót).

---

## Uruchomienie z terminala

Otwórz PowerShell w tym folderze: kliknij prawym przyciskiem na puste miejsce
w folderze `talerz` w Eksploratorze plików i wybierz **„Otwórz w terminalu"**.

### Krok 1 — pobierz biblioteki (tylko za pierwszym razem)

```
npm.cmd install
```

Potrwa 2–5 minut i utworzy folder `node_modules` (kilkaset megabajtów).
Tego folderu nie oglądamy i nie wysyłamy do GitHuba — to pobrany kod cudzych
bibliotek.

### Krok 2 — uruchom aplikację

```
npx.cmd expo start
```

| Chcesz zobaczyć | Zrób |
|---|---|
| Wersję w przeglądarce | naciśnij klawisz `w` |
| Wersję na telefonie | zeskanuj kod QR aplikacją **Expo Go** |
| Zakończyć pracę | `Ctrl + C` |

Telefon i komputer muszą być w tej samej sieci Wi-Fi.

Po zapisaniu zmiany w kodzie aplikacja przeładowuje się sama.

> Końcówki `.cmd` omijają blokadę skryptów w PowerShellu. Jeśli wykonasz
> `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`,
> wystarczy pisać `npm` i `npx`.

---

## Co gdzie leży

```
talerz/
├─ app/                 ← ekrany; nazwa pliku = adres w aplikacji
│  ├─ _layout.tsx          układ główny i cztery zakładki na dole
│  ├─ index.tsx            zakładka „Plan"
│  ├─ przepisy.tsx         zakładka „Przepisy"
│  ├─ spolecznosc.tsx      zakładka „Społeczność"
│  └─ profil.tsx           zakładka „Profil"
├─ components/         ← klocki używane na wielu ekranach
│  ├─ ekran.tsx           wspólny układ ekranu (tło, nagłówek, przewijanie)
│  ├─ karta.tsx           prostokąt z zaokrąglonymi rogami
│  └─ makro.tsx           liczba z podpisem, np. „142 g / białko"
├─ constants/theme.ts  ← kolory i odstępy w jednym miejscu
├─ data/               ← posiłki i przepisy (na razie wpisane na stałe)
├─ hooks/              ← funkcje pomocnicze (jasny/ciemny motyw)
├─ assets/             ← ikony i grafiki
├─ app.json            ← nazwa aplikacji, ikona, identyfikatory dla sklepów
└─ package.json        ← lista używanych bibliotek
```

**Zasada expo-router:** każdy plik w `app/` staje się osobnym ekranem
automatycznie. Nowy plik `zakupy.tsx` = nowy ekran pod adresem `/zakupy`.

Chcesz zmienić posiłki? `data/plan.ts` — to najprostszy plik na początek.

---

## Przydatne komendy

| Komenda | Co robi |
|---|---|
| `npx.cmd expo start` | uruchamia aplikację do podglądu |
| `npx.cmd expo start --clear` | to samo, ale czyści pamięć podręczną |
| `npm.cmd run typecheck` | sprawdza kod pod kątem błędów, bez uruchamiania |
| `git log --oneline` | pokazuje historię zmian |
| `git diff` | pokazuje, co zmieniło się od ostatniego zapisu |

---

## Stan projektu

**Gotowe**

- Szkielet działający na Androidzie, iPhonie i w przeglądarce
- Cztery zakładki
- Ekran „Plan dnia" z makroskładnikami (2290 kcal, 142 g białka)
- Ekran „Przepisy" z serduszkami (działają tylko do zamknięcia aplikacji)

**Następne kroki**

1. Baza danych Supabase — posiłki i przepisy zapisywane na stałe
2. Logowanie: e-mail, Google, Apple
3. Trwałe polubienia, widoczne dla wszystkich
4. Czat na żywo
5. Polityka prywatności i zgody RODO (wymagane przed publikacją w sklepach)
6. Publikacja przez EAS Build

---

## Gdy coś nie działa

```
npx.cmd expo start --clear
```

Gdy to nie pomoże — usuń folder `node_modules` i wykonaj `npm.cmd install`
ponownie.
