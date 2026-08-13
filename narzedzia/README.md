# Narzędzia

Skrypty uruchamiane ręcznie z komputera — nie są częścią aplikacji.

---

## Import składników z USDA

Pobiera wartości odżywcze z **USDA FoodData Central** i zapisuje je w bazie.
Dane USDA są w domenie publicznej (CC0) — nie wnoszą żadnych zobowiązań
licencyjnych.

### Krok 1 — klucz do USDA

Wejdź na [fdc.nal.usda.gov/api-key-signup](https://fdc.nal.usda.gov/api-key-signup),
podaj adres e-mail. Klucz przychodzi pocztą od razu, bez zatwierdzania.

### Krok 2 — plik `.env.local`

Utwórz w głównym katalogu projektu plik **`.env.local`** o takiej treści:

```
USDA_API_KEY=twoj_klucz_z_usda
TALERZ_EMAIL=adres@twojego-konta.pl
TALERZ_HASLO=haslo_do_tego_konta
```

Adres i hasło to dane Twojego konta w aplikacji. Skrypt loguje się nimi jak
zwykły użytkownik i korzysta z uprawnień administratora — **klucz `service_role`
nie jest potrzebny**.

Plik `.env.local` jest pomijany przez Git tak samo jak `.env`.

Konto musi mieć rolę `administrator` albo `moderator`. Nadanie roli opisuje
`supabase/README.md`, krok 4.

### Krok 3 — podgląd

Najpierw bez zapisywania czegokolwiek:

```
node narzedzia/import-usda.mjs --podglad
```

Przy każdej pozycji zobaczysz **nazwę produktu, który USDA faktycznie dopasowało**:

```
34. Dynia, surowa: 26 kcal, 1 g białka  ← Squash, winter, pumpkin, raw
```

To najważniejsza informacja w całym wydruku — po niej od razu widać pomyłkę.

### Dobór właściwego produktu

Wyszukiwarka USDA jest kapryśna. Dlatego każda pozycja ma trzy zabezpieczenia,
w tej kolejności:

**1. Słowa wymagane i wykluczone** — najważniejsze, bo kaloryczność nie
rozróżni produktów podobnych energetycznie:

```json
"slowa": ["sardine"],
"wyklucz": ["anchov"]
```

Anchois mają 210 kcal, sardynki 208 — sama liczba ich nie odróżni. Podobnie
bataty (79 kcal) i ziemniaki (77 kcal).

**2. Wybór najbliższy kalorycznie** spośród tych, które przeszły sito słów.

**3. Próg rozsądku

Wyszukiwarka USDA przy nietrafionym zapytaniu zwraca cokolwiek podobnego:
dla „pumpkin, raw" potrafi podać pestki dyni (555 kcal zamiast 26), dla „oats"
— olej (884 kcal zamiast 389).

** — wynik odbiegający od `kcal_okolo` o ponad 30% jest
odrzucany i nie trafia do bazy:

```
34. Dynia, surowa: ODRZUCONE — dopasowano „Seeds, pumpkin seed kernels", 555 kcal zamiast ~26
```

Przy odrzuceniu skrypt wypisuje **kandydatów z ich identyfikatorami**:

```
- Dynia, surowa — dopasowano „Squash, winter, acorn, raw", 48.6 kcal zamiast ~26
    inne wyniki:
      fdcId 168448 — Pumpkin, raw (26 kcal)
      fdcId 170492 — Squash, winter, acorn, raw (48.6 kcal)
```

Wystarczy wybrać właściwy i wpisać jego numer w pole `fdcId` — wtedy skrypt
pomija wyszukiwanie i bierze dokładnie ten produkt.

```json
{
  "nazwa": "Dynia, surowa",
  "usda": "squash, winter, pumpkin, raw",
  "fdcId": 168448,
  "kcal_okolo": 26,
  "tagi": ["warzywo"],
  "nova": 1
}
```

Lepiej odrzucić dziesięć pozycji do ręcznego sprawdzenia niż wpuścić do bazy
jedną, przez którą aplikacja policzy komuś makro czterokrotnie za wysoko.

### Krok 4 — import

```
node narzedzia/import-usda.mjs
```

Ponowne uruchomienie nie tworzy duplikatów — składniki o tej samej nazwie są
uaktualniane.

---

## Czego USDA nie poda

Trzy rzeczy nasza baza wymaga, a USDA ich nie zawiera:

| Pole | Skąd pochodzi |
|---|---|
| **cukry wolne** | z pliku `skladniki-lista.json`; USDA podaje wyłącznie cukry ogółem, a rozróżnienie jest naszą decyzją (zasady w `docs/plan-aplikacji.md`, sekcja 3.3) |
| **grupa NOVA** | z tego samego pliku |
| **gramatura opakowania** | z etykiet polskich produktów, uzupełniana ręcznie |

Reguła cukrów wolnych w pliku listy:

- brak pola → cukry wolne = 0 (surowce, warzywa, całe owoce)
- `"cukry_wolne": "wszystkie"` → cukry wolne = cukry ogółem (miód, syropy)

Dlatego jabłko z 10 g cukrów ogółem ma zero cukrów wolnych, a miód z 82 g ma
82 g. Tak stanowi definicja WHO i tak działa licznik w aplikacji.

---

## Dodawanie nowych składników

Dopisz pozycję do `skladniki-lista.json`:

```json
{
  "nazwa": "Kasza jaglana, sucha",
  "usda": "millet, raw",
  "tagi": ["zboze"],
  "nova": 1
}
```

Potem uruchom import ponownie. Istniejące pozycje zostaną odświeżone, nowe
dojdą.

---

## Testy

```
node testy/test-import.mjs
```

Sprawdzają odczyt odpowiedzi USDA na przygotowanych przykładach — bez łączenia
się z siecią i bez kluczy.
