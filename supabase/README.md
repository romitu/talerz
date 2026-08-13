# Baza danych Talerza

Schemat początkowy: `migrations/0001_schemat_poczatkowy.sql`

19 tabel, reguły dostępu na każdej z nich, wyzwalacze pilnujące zasad
z `docs/plan-aplikacji.md`.

---

## Zakładanie projektu w Supabase

### Krok 1 — konto i projekt

1. Wejdź na [supabase.com](https://supabase.com) i załóż konto (można przez GitHub).
2. **New project**.
3. Wypełnij:

| Pole | Wartość |
|---|---|
| Name | `talerz` |
| Database Password | wygeneruj i **zapisz w bezpiecznym miejscu** |
| Region | **Central EU (Frankfurt)** |
| Plan | Free |

> **Region to nie drobiazg.** Dane o zdrowiu mają zostać w Unii Europejskiej.
> Regionu nie da się później zmienić — trzeba by zakładać projekt od nowa.

Zakładanie trwa 2–3 minuty.

### Krok 2 — wykonanie schematu

1. W panelu po lewej: **SQL Editor**.
2. **New query**.
3. Otwórz plik `migrations/0001_schemat_poczatkowy.sql`, skopiuj **całą** zawartość
   i wklej do okna.
4. **Run** (albo `Ctrl+Enter`).

Powinno pojawić się `Success. No rows returned`.

### Krok 3 — sprawdzenie

W panelu **Table Editor** powinno być widocznych 19 tabel: `cele`, `czasy_sprzet`,
`historia_przepisu`, `konta`, `kroki`, `notatki`, `partie`, `plan_pozycje`,
`plany`, `polubienia`, `pomiary`, `profile`, `przepis_skladniki`, `przepisy`,
`skladniki`, `wersje_kroki`, `wersje_skladniki`, `wersje_uzytkownika`,
`zgloszenia`.

Przy każdej powinna widnieć etykieta **RLS enabled**. Jeśli gdzieś jej brakuje,
coś poszło nie tak — daj znać.

### Krok 4 — nadanie sobie uprawnień administratora

Konto tworzy się automatycznie przy rejestracji, ale z rolą zwykłego użytkownika.
Po pierwszym zalogowaniu w aplikacji wykonaj w SQL Editor:

```sql
update konta set rola = 'administrator'
where id = (select id from auth.users where email = 'romitu@gmail.com');
```

### Krok 5 — klucze do aplikacji

**Project Settings → API**. Potrzebne będą dwie wartości:

| Nazwa | Do czego |
|---|---|
| Project URL | adres bazy |
| `anon` `public` key | klucz publiczny dla aplikacji |

> **Klucz `service_role` nigdy nie trafia do aplikacji.** Omija wszystkie reguły
> dostępu. Zostaje w panelu Supabase i nigdzie indziej.

---

## Co pilnuje sama baza

Te zasady działają niezależnie od aplikacji — nie da się ich obejść, nawet
wysyłając zapytanie bezpośrednio do bazy:

| Zasada | Mechanizm |
|---|---|
| Wyłącznie osoby pełnoletnie | wyzwalacz na `profile` |
| Najwyżej 3 profile na konto | wyzwalacz na `profile` |
| Trwałość dania 0–3 dni | ograniczenie CHECK |
| Cukry wolne nie większe niż ogółem | ograniczenie CHECK |
| Data przydatności partii z trwałości przepisu | wyzwalacz na `partie` |
| Nie zostało więcej porcji, niż ugotowano | ograniczenie CHECK |
| Plan i pomiary widoczne tylko dla właściciela | reguły RLS |
| Przepis prywatny niewidoczny dla obcych | reguły RLS |
| Przepis publiczny edytuje tylko moderator | reguły RLS |
| Konto powstaje automatycznie po rejestracji | wyzwalacz na `auth.users` |

Makroskładniki nigdy nie są wpisywane ręcznie — wylicza je widok `przepis_makro`
ze składników i ich gramatur.

---

## Testy schematu

`testy/test_schematu.py` uruchamia prawdziwy PostgreSQL, wykonuje migrację
i sprawdza 17 zachowań: wyzwalacze, ograniczenia, wyliczanie makro i szczelność
reguł dostępu między kontami.

```
pip install pgserver
python3 testy/test_schematu.py
```

Test nie wymaga połączenia z Supabase — stawia własną bazę i tworzy atrapę
schematu `auth`, który na produkcji dostarcza sama platforma.

Warto uruchomić go po każdej zmianie schematu, **zanim** trafi ona do Supabase.
