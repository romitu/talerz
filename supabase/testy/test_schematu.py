#!/usr/bin/env python3
"""
Testy schematu bazy Talerza.

Stawia prawdziwy PostgreSQL (pakiet pgserver), tworzy atrapę schematu `auth`,
który na produkcji dostarcza sama platforma Supabase, wykonuje migrację
i sprawdza, czy zasady z docs/plan-aplikacji.md faktycznie działają.

    pip install pgserver
    python3 testy/test_schematu.py

Uruchamiaj po każdej zmianie schematu, ZANIM trafi ona do Supabase.

Uwaga metodyczna: nie sprawdzamy, czy baza zgłosiła błąd — komunikaty trafiają
na inne wyjście i łatwo je przeoczyć. Sprawdzamy skutek: czy wiersz powstał.
To mocniejszy test, bo wykrywa również sytuację, w której baza zgłasza błąd,
ale mimo to coś zapisuje.
"""

import pathlib
import re
import shutil
import sys
import tempfile

import pgserver

KATALOG = pathlib.Path(__file__).resolve().parent
MIGRACJA = KATALOG.parent / "migrations" / "0001_schemat_poczatkowy.sql"
KATALOG_BAZY = pathlib.Path(tempfile.gettempdir()) / "talerz_test_db"

KONTO_A = "11111111-1111-1111-1111-111111111111"
KONTO_B = "22222222-2222-2222-2222-222222222222"
PRZEPIS = "33333333-3333-3333-3333-333333333333"

przeszlo: list[str] = []
nie_przeszlo: list[str] = []


# --------------------------------------------------------------------------
#  Narzędzia
# --------------------------------------------------------------------------

def wykonaj(zapytanie: str) -> None:
    """Wykonuje SQL, ignorując błędy — sprawdzamy skutki, nie komunikaty."""
    try:
        serwer.psql(zapytanie)
    except Exception:
        pass


def wartosc(zapytanie: str) -> str | None:
    """Zwraca pojedynczą wartość, otoczoną znacznikiem dla pewnego odczytu."""
    try:
        wyjscie = serwer.psql(f"select 'W<' || ({zapytanie}) || '>';")
    except Exception:
        return None
    trafienie = re.search(r"W<([^>]*)>", wyjscie)
    return trafienie.group(1) if trafienie else None


def jako(konto: str, zapytanie: str) -> str | None:
    """Wykonuje zapytanie w roli zalogowanego użytkownika — z działającym RLS."""
    try:
        wyjscie = serwer.psql(
            f"begin;"
            f" set local role authenticated;"
            f" set local request.jwt.claim.sub = '{konto}';"
            f" select 'W<' || ({zapytanie}) || '>';"
            f" commit;"
        )
    except Exception:
        return None
    trafienie = re.search(r"W<([^>]*)>", wyjscie)
    return trafienie.group(1) if trafienie else None


def sprawdz(nazwa: str, warunek: bool, szczegol: str = "") -> None:
    if warunek:
        przeszlo.append(nazwa)
    else:
        nie_przeszlo.append(f"{nazwa}{' — ' + szczegol if szczegol else ''}")


def ma_odrzucic(nazwa: str, zapytanie: str, licznik: str) -> None:
    """Sprawdza, że po próbie zapisu liczba wierszy się nie zmieniła."""
    przed = wartosc(licznik)
    wykonaj(zapytanie)
    po = wartosc(licznik)
    sprawdz(nazwa, przed == po, f"liczba wierszy zmieniła się z {przed} na {po}")


# --------------------------------------------------------------------------
#  Przygotowanie bazy
# --------------------------------------------------------------------------

if KATALOG_BAZY.exists():
    shutil.rmtree(KATALOG_BAZY, ignore_errors=True)

serwer = pgserver.get_server(str(KATALOG_BAZY))

# Atrapa tego, co na produkcji tworzy sama platforma Supabase.
wykonaj(
    """
    create schema if not exists auth;
    create table if not exists auth.users (
      id uuid primary key default gen_random_uuid(),
      email text
    );
    create or replace function auth.uid() returns uuid
      language sql stable as
      $$ select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid $$;
    """
)

try:
    serwer.psql(MIGRACJA.read_text(encoding="utf-8"))
except Exception as blad:
    print("MIGRACJA NIE PRZESZŁA:")
    print(str(blad)[:2500])
    sys.exit(1)

if wartosc("select count(*) from pg_tables where schemaname='public'") is None:
    print("MIGRACJA NIE PRZESZŁA — brak tabel.")
    sys.exit(1)

print("Migracja wykonana bez błędów.\n")

wykonaj(
    """
    create role authenticated nologin;
    grant usage on schema public to authenticated;
    grant all on all tables in schema public to authenticated;
    """
)


# --------------------------------------------------------------------------
#  1. Konta i profile
# --------------------------------------------------------------------------

wykonaj(
    f"insert into auth.users (id, email) values "
    f"('{KONTO_A}', 'a@test.pl'), ('{KONTO_B}', 'b@test.pl');"
)

sprawdz("konto powstaje automatycznie po rejestracji",
        wartosc("select count(*) from konta") == "2",
        f"kont: {wartosc('select count(*) from konta')}")

sprawdz("nowe konto ma rolę zwykłego użytkownika",
        wartosc(f"select rola from konta where id='{KONTO_A}'") == "uzytkownik")

ma_odrzucic(
    "profil osoby niepełnoletniej odrzucony",
    f"insert into profile (konto_id, imie, plec, data_urodzenia, wzrost_cm) "
    f"values ('{KONTO_A}', 'Nastolatek', 'M', current_date - interval '15 years', 170);",
    "select count(*) from profile",
)

wykonaj(
    f"""insert into profile (konto_id, imie, plec, data_urodzenia, wzrost_cm) values
        ('{KONTO_A}', 'Roman', 'M', '1967-01-01', 189),
        ('{KONTO_A}', 'Ewa',   'K', '1970-05-05', 165),
        ('{KONTO_A}', 'Marek', 'M', '1990-03-03', 180),
        ('{KONTO_A}', 'Zofia', 'K', '1995-07-07', 168);"""
)

sprawdz("cztery profile pełnoletnie przyjęte",
        wartosc("select count(*) from profile") == "4",
        f"profili: {wartosc('select count(*) from profile')}")

ma_odrzucic(
    "piąty profil odrzucony",
    f"insert into profile (konto_id, imie, plec, data_urodzenia, wzrost_cm) "
    f"values ('{KONTO_A}', 'Piąty', 'M', '1985-01-01', 175);",
    "select count(*) from profile",
)

ma_odrzucic(
    "profil bez wzrostu odrzucony",
    f"insert into profile (konto_id, imie, plec, data_urodzenia) "
    f"values ('{KONTO_B}', 'Bezwzrostu', 'M', '1980-01-01');",
    "select count(*) from profile",
)


# --------------------------------------------------------------------------
#  2. Składniki
# --------------------------------------------------------------------------

wykonaj(
    """
    insert into skladniki
      (nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
       cukry_ogolem_100g, cukry_wolne_100g, nova, gramatura_opakowania_g)
    values
      ('Dorsz atlantycki', 'usda',  82, 17.8, 0.7,  0, 0, 0, 1, 400),
      ('Kasza gryczana',   'usda', 336, 13.3, 3.4, 62, 0, 0, 1, 400);
    """
)

sprawdz("składniki dodane", wartosc("select count(*) from skladniki") == "2")

ma_odrzucic(
    "składnik z cukrami wolnymi większymi niż ogółem odrzucony",
    "insert into skladniki (nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, "
    "wegle_100g, cukry_ogolem_100g, cukry_wolne_100g) "
    "values ('Blad', 'wlasne', 10, 1, 1, 1, 5, 9);",
    "select count(*) from skladniki",
)


# --------------------------------------------------------------------------
#  3. Przepisy i wyliczanie makroskładników
# --------------------------------------------------------------------------

ma_odrzucic(
    "przepis o trwałości 5 dni odrzucony",
    f"insert into przepisy (nazwa, autor_id, trwalosc_dni) "
    f"values ('Zbyt trwaly', '{KONTO_A}', 5);",
    "select count(*) from przepisy",
)

wykonaj(
    f"""
    insert into przepisy (id, nazwa, autor_id, widocznosc, trwalosc_dni, pory)
    values ('{PRZEPIS}', 'Dorsz z kaszą', '{KONTO_A}', 'publiczna', 3, '{{obiad}}');

    insert into przepis_skladniki (przepis_id, skladnik_id, gramy)
    select '{PRZEPIS}', id, 200 from skladniki where nazwa = 'Dorsz atlantycki';

    insert into przepis_skladniki (przepis_id, skladnik_id, gramy)
    select '{PRZEPIS}', id, 80 from skladniki where nazwa = 'Kasza gryczana';
    """
)

# 200 g dorsza (82 kcal/100 g) + 80 g kaszy (336 kcal/100 g) = 164 + 268,8 = 433 kcal
# białko: 200 g x 17,8 + 80 g x 13,3 = 35,6 + 10,64 = 46,2 g
kcal = wartosc(f"select kcal from przepis_makro where przepis_id='{PRZEPIS}'")
bialko = wartosc(f"select bialko_g from przepis_makro where przepis_id='{PRZEPIS}'")

sprawdz("widok makro liczy kalorie ze składników",
        kcal == "433", f"otrzymano {kcal}, oczekiwano 433")
sprawdz("widok makro liczy białko ze składników",
        bialko == "46.2", f"otrzymano {bialko}, oczekiwano 46.2")


# --------------------------------------------------------------------------
#  4. Partie — data przydatności i liczba porcji
# --------------------------------------------------------------------------

# Data przydatności celowo podana błędnie: wyzwalacz ma ją nadpisać.
wykonaj(
    f"""insert into partie
        (konto_id, przepis_id, data_ugotowania, porcji_razem, porcji_zostalo, wazne_do)
        values ('{KONTO_A}', '{PRZEPIS}', '2026-08-13', 6, 6, '2000-01-01');"""
)

data_waznosci = wartosc(f"select wazne_do from partie where konto_id='{KONTO_A}'")
sprawdz("data przydatności wyliczona z trwałości przepisu (3 dni)",
        data_waznosci == "2026-08-16",
        f"otrzymano {data_waznosci}, oczekiwano 2026-08-16")

ma_odrzucic(
    "partia z liczbą porcji ponad stan odrzucona",
    f"insert into partie (konto_id, przepis_id, porcji_razem, porcji_zostalo, wazne_do) "
    f"values ('{KONTO_A}', '{PRZEPIS}', 4, 9, '2026-08-20');",
    "select count(*) from partie",
)


# --------------------------------------------------------------------------
#  5. Reguły dostępu (RLS) — szczelność między kontami
# --------------------------------------------------------------------------

wykonaj(f"insert into plany (konto_id, data_start) values ('{KONTO_A}', '2026-08-13');")
wykonaj(f"insert into przepisy (nazwa, autor_id, widocznosc) "
        f"values ('Sekretny', '{KONTO_A}', 'prywatna');")

sprawdz("RLS: obcy nie widzi cudzego planu",
        jako(KONTO_B, "select count(*) from plany") == "0",
        f"obcy widzi {jako(KONTO_B, 'select count(*) from plany')}")

sprawdz("RLS: właściciel widzi swój plan",
        jako(KONTO_A, "select count(*) from plany") == "1")

sprawdz("RLS: obcy nie widzi cudzych profili",
        jako(KONTO_B, "select count(*) from profile") == "0")

sprawdz("RLS: obcy nie widzi cudzych partii",
        jako(KONTO_B, "select count(*) from partie") == "0")

sprawdz("RLS: przepis prywatny niewidoczny dla obcych",
        jako(KONTO_B, "select count(*) from przepisy where nazwa='Sekretny'") == "0")

sprawdz("RLS: autor widzi swój przepis prywatny",
        jako(KONTO_A, "select count(*) from przepisy where nazwa='Sekretny'") == "1")

sprawdz("RLS: przepis publiczny widoczny dla wszystkich",
        jako(KONTO_B, "select count(*) from przepisy where widocznosc='publiczna'") == "1")

# Zwykły użytkownik nie może zmienić cudzego przepisu publicznego.
przed_nazwa = wartosc(f"select nazwa from przepisy where id='{PRZEPIS}'")
wykonaj(
    f"begin;"
    f" set local role authenticated;"
    f" set local request.jwt.claim.sub = '{KONTO_B}';"
    f" update przepisy set nazwa = 'Przejete' where id = '{PRZEPIS}';"
    f" commit;"
)
sprawdz("RLS: obcy nie zmieni przepisu publicznego",
        wartosc(f"select nazwa from przepisy where id='{PRZEPIS}'") == przed_nazwa,
        "nazwa przepisu została zmieniona przez obcego")


# --------------------------------------------------------------------------
#  Podsumowanie
# --------------------------------------------------------------------------

print("=== PRZESZŁO ===")
for nazwa in przeszlo:
    print("  +", nazwa)

if nie_przeszlo:
    print("\n=== NIE PRZESZŁO ===")
    for nazwa in nie_przeszlo:
        print("  -", nazwa)
    print(f"\nNIEPOWODZENIE: {len(nie_przeszlo)} z {len(przeszlo) + len(nie_przeszlo)} kontroli.")
    sys.exit(1)

print(f"\nWszystkie {len(przeszlo)} kontroli zakończone powodzeniem.")
