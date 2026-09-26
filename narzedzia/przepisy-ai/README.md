# Przepisy przygotowane przez AI

Jeden plik JSON = jeden przepis. Import:

```
node narzedzia/generuj-import-ai.mjs
```

Autorem przepisów jest konto `TALERZ_EMAIL` z pliku `.env.local` (albo
`--autor=adres@e-mail`). Nowy przepis jest prywatny — widzi go autor
i moderator, dopóki moderator go nie opublikuje.

Powstaje `supabase/narzedzia/import-przepisow-ai.sql` — uruchom go w SQL Editorze
w panelu Supabase. Jeśli w katalogach brakuje składnika albo sprzętu, skrypt
kończy się błędem `IMPORT PRZERWANY — …` z listą braków i podobnymi pozycjami
z katalogu — i nic nie zapisuje.

## Katalogi zostają zwarte

Import niczego nie dopisuje do katalogów składników i sprzętu. Zamiast dodawać
„Nóż” obok „Noża szefa kuchni”, popraw nazwę w JSON-ie. Nową pozycję dodawaj
tylko wtedy, gdy żadna z podpowiedzi naprawdę nie pasuje.

Prompt dla AI z aktualnymi, zamkniętymi listami nazw zwraca
`supabase/narzedzia/prompt-przepisu-ai.sql`.

## Pola

| Pole | Wartości | Uwagi |
|---|---|---|
| `nazwa` | 3–120 znaków | Ta sama nazwa co w bazie = aktualizacja przepisu |
| `pory` | `sniadanie`, `obiad`, `kolacja`, `dodatek` | Pusta lista = pasuje wszędzie |
| `kuchnie` | `srodziemnomorska`, `azjatycka`, `polska`, `inna` | |
| `rodzaje` | `zupa`, `salatka`, `makaron`, `kasza_ryz`, `gulasz_curry`, `z_piekarnika`, `kanapki`, `jajka`, `na_slodko` | Jeden albo dwa. Nieobowiązkowe — bez pola import nie zmienia rodzajów w bazie |
| `porcjowanie` | `waga` albo `sztuki` | |
| `porcja_g` | liczba całkowita 20–2000 | Tylko przy `waga` |
| `porcje` | liczba całkowita 1–30 | Tylko przy `sztuki` |
| `trwalosc_dni` | 0–3 | 0 = tylko na świeżo |
| `czas_przygotowania_min` | 1–1440 | Praca przy blacie |
| `czas_obrobki_min` | 0–1440 | Garnek, piekarnik; 0 = danie na zimno |
| `sprzet` | nazwy z katalogu sprzętu | |
| `przechowywanie`, `ratunek`, `opis` | tekst | Nieobowiązkowe |
| `mozna_mrozic` | `true` / `false` | |
| `skladniki[].nazwa` | nazwa **dokładnie** z katalogu składników | |
| `skladniki[].ilosc` | liczba > 0 | |
| `skladniki[].jednostka` | `g`, `ml`, `szt` | `szt` wymaga masy sztuki w katalogu |
| `skladniki[].stan`, `zamiennik` | tekst | Nieobowiązkowe |
| `etapy[].nazwa` | 2–120 znaków | |
| `etapy[].minuty` | 1–1440 | Nieobowiązkowe |
| `etapy[].kroki[].tresc` | tekst | |
| `etapy[].kroki[].sygnal` | tekst | Po czym poznać, że krok się udał |
| `etapy[].kroki[].uwaga` | `true` | Krok wyróżniony w aplikacji |

Kalorii nie podajemy — Talerz liczy je ze składników. Rola składnika
i podzielność są kopiowane z katalogu. Nowy przepis wchodzi jako prywatny.
