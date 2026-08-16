#!/usr/bin/env python3
"""
Test migracji 0012 — jednostki domowe przeliczone na gramy.

    pip install pgserver
    python3 testy/test_jednostek.py

Sprawdza dwie rzeczy:

  1. że migracja wpisuje przeliczniki tam, gdzie trzeba, i nie wywraca się,
     gdy któregoś składnika jeszcze nie ma w bazie,

  2. że „łyżka” NIE jest jedną liczbą dla wszystkich produktów — to jest sedno
     tej migracji i najłatwiejsza rzecz do zepsucia przy późniejszym uproszczeniu.

Metoda jak w pozostałych testach: sprawdzamy skutki w danych, nie treść
komunikatów.
"""
import pgserver, pathlib, re, shutil, sys

K = pathlib.Path(__file__).resolve().parent.parent / "migrations"
B = pathlib.Path("/tmp/talerz_p12")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))


def sql(q):
    """
    Wykonuje SQL i zwraca (wynik, czy_blad).

    `ON_ERROR_STOP` jest konieczne. Bez niego psql przy skrypcie z wieloma
    instrukcjami wypisuje błąd, leci dalej i kończy się kodem zero — a wtedy
    test „przechodzi” mimo wywróconej migracji. Tak przeszła kiedyś migracja
    0018 z błędem w GROUP BY.
    """
    try:
        return srv.psql("\\set ON_ERROR_STOP on\n" + q), False
    except Exception as e:
        return str(e), True


def w(q):
    out, _ = sql(f"select 'W<'||coalesce(({q})::text,'NULL')||'>';")
    m = re.search(r"W<([^>]*)>", out)
    return m.group(1) if m else None


def liczba(q):
    """Wartość liczbowa. Kolumna `masa_sztuki_g` jest typu numeric, więc baza
    zwraca „4.00”, a nie „4” — porównywanie tekstem dawałoby fałszywe błędy."""
    x = w(q)
    try:
        return float(x)
    except (TypeError, ValueError):
        return None


sql("""create schema if not exists auth;
create table if not exists auth.users (id uuid primary key default gen_random_uuid(), email text);
create or replace function auth.uid() returns uuid language sql stable as
 $$ select nullif(current_setting('request.jwt.claim.sub', true),'')::uuid $$;""")

sql("""
-- Namiastka schematu `storage`. W Supabase tworzy go sama usługa plików;
-- w piaskownicy trzeba go podstawić, inaczej migracja 0016 nie ma czego
-- zmieniać. Odwzorowane tylko te kolumny, których migracja dotyka.
create schema if not exists storage;
create table if not exists storage.buckets (
  id text primary key,
  name text not null,
  public boolean not null default false,
  file_size_limit bigint,
  allowed_mime_types text[]
);
create table if not exists storage.objects (
  id uuid primary key default gen_random_uuid(),
  bucket_id text references storage.buckets (id),
  name text
);
alter table storage.objects enable row level security;
""")

pliki = sorted(p.name for p in K.glob("*.sql"))
przed = [x for x in pliki if not x.startswith("0012")]
for n in przed:
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1500])
        sys.exit(1)
print(f"Migracje przed 0012 wykonane ({len(przed)} plików).")

bledy = []


def sprawdz(opis, warunek, dodatek=""):
    if warunek:
        print(f"  ok   {opis}")
    else:
        print(f"  ZLE  {opis} {dodatek}")
        bledy.append(opis)


# --- składniki testowe -------------------------------------------------------
# Celowo NIE dodajemy „Brokuł, surowy” ani „Miód” — migracja ma sobie poradzić
# z tym, że części pozycji z listy jeszcze nie ma w bazie.
sql("""
insert into skladniki (nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g, blonnik_100g, nova) values
  ('Marchew, surowa',              'usda',  41, 0.9, 0.2,  9.6, 2.8, 1),
  ('Czosnek, surowy',              'usda', 149, 6.4, 0.5, 33.1, 2.1, 1),
  ('Chleb żytni razowy',           'usda', 250, 8.5, 3.3, 48.3, 5.8, 3),
  ('Oliwa z oliwek',               'usda', 884, 0.0,100.0, 0.0, 0.0, 2),
  ('Jogurt grecki naturalny 2%',   'usda',  73,10.0, 1.9,  3.9, 0.0, 1),
  ('Sos sojowy',                   'usda',  53, 8.1, 0.6,  4.9, 0.8, 3),
  ('Pasta curry czerwona',         'usda', 100, 2.0, 3.0, 15.0, 3.0, 4),
  ('Tuńczyk w wodzie, odsączony',  'usda', 116,25.5, 0.8,  0.0, 0.0, 3),
  ('Kasza gryczana, sucha',        'usda', 343,13.3, 3.4, 71.5,10.0, 1);
""")

out, blad = sql((K / "0012_jednostki_domowe.sql").read_text(encoding="utf-8"))
sprawdz("migracja 0012 wykonuje się", not blad, out[:600] if blad else "")
if blad:
    sys.exit(1)

# --- 1. przeliczniki trafiają tam, gdzie trzeba ------------------------------
sprawdz("marchewka waży 75 g",
        liczba("select masa_sztuki_g from skladniki where nazwa='Marchew, surowa'") == 75)
sprawdz("ząbek czosnku waży 4 g",
        liczba("select masa_sztuki_g from skladniki where nazwa='Czosnek, surowy'") == 4)
sprawdz("kromka chleba waży 35 g",
        liczba("select masa_sztuki_g from skladniki where nazwa='Chleb żytni razowy'") == 35)
sprawdz("puszka tuńczyka to 140 g",
        liczba("select masa_sztuki_g from skladniki where nazwa='Tuńczyk w wodzie, odsączony'") == 140)
sprawdz("torebka kaszy to 100 g",
        liczba("select masa_sztuki_g from skladniki where nazwa='Kasza gryczana, sucha'") == 100)

# --- 2. łyżka to NIE jedna liczba -------------------------------------------
lyzki = {
    "Oliwa z oliwek": 12,
    "Jogurt grecki naturalny 2%": 20,
    "Sos sojowy": 16,
    "Pasta curry czerwona": 15,
}
for nazwa, oczek in lyzki.items():
    sprawdz(f"łyżka — {nazwa}: {oczek} g",
            liczba(f"select masa_sztuki_g from skladniki where nazwa='{nazwa}'") == oczek)

sprawdz("cztery produkty mają cztery różne masy łyżki",
        w("""select count(distinct masa_sztuki_g) from skladniki
             where nazwa in ('Oliwa z oliwek','Jogurt grecki naturalny 2%',
                             'Sos sojowy','Pasta curry czerwona')""") == "4")

# --- 3. brak składnika nie wywraca migracji ----------------------------------
sprawdz("nieobecne pozycje zostały pominięte bez błędu",
        w("select count(*) from skladniki where nazwa='Brokuł, surowy'") == "0")

# --- 4. przeliczenie sztuk na gramy działa w przepisie ------------------------
A = "11111111-1111-1111-1111-111111111111"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl');")
sql(f"""
insert into przepisy (id, nazwa, opis, autor_id, pory, kuchnie, porcjowanie, porcja_g,
                      czas_przygotowania_min, czas_obrobki_min, trwalosc_dni)
values ('22222222-2222-2222-2222-222222222222', 'Test jednostek', 'x',
        '{A}', '{{obiad}}', '{{polska}}', 'waga', 113, 10, 10, 3);
""")

# dwa ząbki czosnku i trzy kromki chleba, podane w sztukach
sql("""
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, kolejnosc)
select '22222222-2222-2222-2222-222222222222', id, 2, 'szt', 2*masa_sztuki_g, 1
  from skladniki where nazwa='Czosnek, surowy';
insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, kolejnosc)
select '22222222-2222-2222-2222-222222222222', id, 3, 'szt', 3*masa_sztuki_g, 2
  from skladniki where nazwa='Chleb żytni razowy';
""")

sprawdz("2 ząbki czosnku to 8 g",
        liczba("""select gramy from przepis_skladniki ps join skladniki s on s.id=ps.skladnik_id
                  where s.nazwa='Czosnek, surowy'""") == 8)
sprawdz("3 kromki chleba to 105 g",
        liczba("""select gramy from przepis_skladniki ps join skladniki s on s.id=ps.skladnik_id
                  where s.nazwa='Chleb żytni razowy'""") == 105)

# 8 g czosnku po 149 kcal/100 g = 11,9 kcal; 105 g chleba po 250 = 262,5 kcal.
# Razem 274 kcal — to musi wyjść z gramów, a nie z „2 sztuk” i „3 sztuk”.
#
# Waga porcji ustawiona na 113 g, czyli dokładnie tyle, ile waży cały przepis.
# Widok `przepis_makro` podaje wartości NA PORCJĘ, więc przy porcji 400 g
# pokazałby 970 kcal — poprawnie, ale to sprawdzałoby już co innego.
kcal = liczba("select round(kcal) from przepis_makro where przepis_id='22222222-2222-2222-2222-222222222222'")
sprawdz("makro liczy się z gramów: około 274 kcal",
        kcal is not None and 265 <= kcal <= 285, f"(otrzymano {kcal})")

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
