#!/usr/bin/env python3
"""
Test migracji 0019 — produkty dopisywane ręcznie i trwałe odhaczenia.

    pip install pgserver
    python3 testy/test_zakupow_recznych.py

Co tu naprawdę sprawdzamy
-------------------------
Sama tabela jest prosta i człowiek patrzący na SQL nie pomyli się w niej.
Sprawdzamy więc rzeczy, których na oko nie widać:

  1. że ta sama rzecz nie wisi na liście dwa razy — ale DA SIĘ ją kupić
     ponownie po odhaczeniu (na tym polega częściowy indeks unikalny),
  2. że wyzwalacz sam wpisuje datę zakupu i sam ją kasuje przy cofnięciu,
  3. że odhaczenie jest jedno na parę (konto, składnik),
  4. że kasowanie konta zabiera ze sobą listę — inaczej zostałyby sieroty.

Punkt pierwszy jest sednem. Zwykły `unique` zablokowałby kupienie worków
po raz drugi w życiu, a to jest dokładnie to, co robi się co miesiąc.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_zakupy")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))


def sql(q):
    """
    Wykonuje SQL i zwraca (wynik, czy_blad).

    `ON_ERROR_STOP` jest konieczne. Bez niego psql przy skrypcie z wieloma
    instrukcjami wypisuje błąd, leci dalej i kończy się kodem zero — a wtedy
    test „przechodzi” mimo wywróconej migracji.
    """
    try:
        return srv.psql("\\set ON_ERROR_STOP on\n" + q), False
    except Exception as e:
        return str(e), True


def w(q):
    out, _ = sql(f"select 'W<'||coalesce(({q})::text,'NULL')||'>';")
    m = re.search(r"W<([^>]*)>", out)
    return m.group(1) if m else None


bledy = []


def sprawdz(opis, warunek, dodatek=""):
    if warunek:
        print(f"  ok   {opis}")
    else:
        print(f"  ZLE  {opis} {dodatek}")
        bledy.append(opis)


# --- baza --------------------------------------------------------------------
sql("""create schema if not exists auth;
create table if not exists auth.users (
  id uuid primary key default gen_random_uuid(), email text,
  created_at timestamptz not null default now());
create or replace function auth.uid() returns uuid language sql stable as
 $$ select nullif(current_setting('request.jwt.claim.sub', true),'')::uuid $$;""")

sql("""
-- Namiastka schematu `storage` — w Supabase tworzy go sama usługa plików.
create schema if not exists storage;
create table if not exists storage.buckets (
  id text primary key, name text not null, public boolean not null default false,
  file_size_limit bigint, allowed_mime_types text[]);
create table if not exists storage.objects (
  id uuid primary key default gen_random_uuid(),
  bucket_id text references storage.buckets (id), name text);
alter table storage.objects enable row level security;
""")

for n in sorted(p.name for p in K.glob("*.sql")):
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1500])
        sys.exit(1)
print(f"Migracje wykonane ({len(list(K.glob('*.sql')))} plików).")

A = "11111111-1111-1111-1111-111111111111"
C = "33333333-3333-3333-3333-333333333333"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl'),('{C}','c@t.pl');")
sql(f"insert into konta (id) values ('{A}'),('{C}') on conflict (id) do nothing;")

# --- 1. dopisanie produktu ----------------------------------------------------
out, blad = sql(f"""
insert into zakupy_reczne (konto_id, nazwa, ilosc)
values ('{A}', 'Worki na śmieci', '1 opak.');
""")
sprawdz("da się dopisać produkt", not blad, out[:300] if blad else "")
# Uwaga: `w()` rzutuje wynik na text, a boolean::text to „false”/„true”,
# a nie „f”/„t”, które pokazuje psql w tabelce.
sprawdz("nowy produkt nie jest kupiony",
        w("select kupione from zakupy_reczne where nazwa='Worki na śmieci'") == "false")
sprawdz("nowy produkt nie ma daty zakupu",
        w("select kupiono_kiedy from zakupy_reczne where nazwa='Worki na śmieci'") == "NULL")

# --- 2. ta sama rzecz nie wchodzi dwa razy ------------------------------------
przed = w("select count(*) from zakupy_reczne")
out, blad = sql(f"""
insert into zakupy_reczne (konto_id, nazwa) values ('{A}', 'worki na  śmieci');
""")
po = w("select count(*) from zakupy_reczne")
sprawdz("duplikat odrzucony mimo innej wielkości liter", przed == po, f"(przed {przed}, po {po})")

# Ważne: warunek dotyczy TEGO SAMEGO konta. Drugi użytkownik ma własną listę.
out, blad = sql(f"insert into zakupy_reczne (konto_id, nazwa) values ('{C}', 'Worki na śmieci');")
sprawdz("inne konto może mieć tę samą pozycję", not blad, out[:300] if blad else "")

# --- 3. zakup i ponowne dopisanie ---------------------------------------------
sql(f"update zakupy_reczne set kupione = true where konto_id='{A}' and nazwa='Worki na śmieci';")
sprawdz("wyzwalacz wpisał datę zakupu",
        w(f"""select kupiono_kiedy is not null from zakupy_reczne
              where konto_id='{A}' and nazwa='Worki na śmieci'""") == "true")

przed = w(f"select count(*) from zakupy_reczne where konto_id='{A}'")
out, blad = sql(f"""
insert into zakupy_reczne (konto_id, nazwa, ilosc) values ('{A}', 'Worki na śmieci', '2 opak.');
""")
po = w(f"select count(*) from zakupy_reczne where konto_id='{A}'")
sprawdz("po kupieniu da się dopisać tę samą rzecz jeszcze raz",
        not blad and int(po) == int(przed) + 1, out[:300] if blad else f"(przed {przed}, po {po})")
sprawdz("w historii zostały obie pozycje",
        w(f"select count(*) from zakupy_reczne where konto_id='{A}' and nazwa='Worki na śmieci'") == "2")
sprawdz("otwarta jest dokładnie jedna",
        w(f"""select count(*) from zakupy_reczne
              where konto_id='{A}' and nazwa='Worki na śmieci' and not kupione""") == "1")

# Cofnięcie zakupu kasuje datę — inaczej „kupione” i „data” rozjechałyby się.
sql(f"""update zakupy_reczne set kupione = false
        where konto_id='{A}' and nazwa='Worki na śmieci' and kupione;""")
sprawdz("cofnięcie zakupu kasuje datę",
        w(f"""select count(*) from zakupy_reczne
              where konto_id='{A}' and not kupione and kupiono_kiedy is not null""") == "0")

# --- 4. puste i za długie nazwy -----------------------------------------------
przed = w("select count(*) from zakupy_reczne")
sql(f"insert into zakupy_reczne (konto_id, nazwa) values ('{A}', '   ');")
sprawdz("sama spacja nie przechodzi jako nazwa", przed == w("select count(*) from zakupy_reczne"))

przed = w("select count(*) from zakupy_reczne")
sql(f"insert into zakupy_reczne (konto_id, nazwa) values ('{A}', repeat('x', 61));")
sprawdz("nazwa dłuższa niż 60 znaków nie przechodzi",
        przed == w("select count(*) from zakupy_reczne"))

# --- 5. odhaczenia pozycji z planu --------------------------------------------
sql(f"""
insert into skladniki (nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
                       blonnik_100g, cukry_wolne_100g, zrodlo)
values ('Marchew próbna', 41, 0.9, 0.2, 9.6, 2.8, 0, 'wlasne')
on conflict do nothing;
""")
skladnik = w("select id from skladniki where nazwa='Marchew próbna'")

out, blad = sql(f"""
insert into zakupy_odhaczone (konto_id, skladnik_id) values ('{A}', '{skladnik}');
""")
sprawdz("da się odhaczyć składnik", not blad, out[:300] if blad else "")

przed = w("select count(*) from zakupy_odhaczone")
sql(f"insert into zakupy_odhaczone (konto_id, skladnik_id) values ('{A}', '{skladnik}');")
sprawdz("drugie takie samo odhaczenie nie tworzy wiersza",
        przed == w("select count(*) from zakupy_odhaczone"))

sql(f"insert into zakupy_odhaczone (konto_id, skladnik_id) values ('{C}', '{skladnik}');")
sprawdz("dwa konta mogą odhaczyć ten sam składnik",
        w("select count(*) from zakupy_odhaczone") == "2")

sql(f"delete from zakupy_odhaczone where konto_id='{A}';")
sprawdz("czyszczenie zabiera tylko własne ptaszki",
        w("select count(*) from zakupy_odhaczone") == "1")

# --- 6. kasowanie konta zabiera listę -----------------------------------------
sql(f"delete from konta where id='{C}';")
sprawdz("po skasowaniu konta znika jego lista ręczna",
        w(f"select count(*) from zakupy_reczne where konto_id='{C}'") == "0")
sprawdz("po skasowaniu konta znikają jego odhaczenia",
        w(f"select count(*) from zakupy_odhaczone where konto_id='{C}'") == "0")

# --- 7. reguły dostępu --------------------------------------------------------
for tabela in ("zakupy_reczne", "zakupy_odhaczone"):
    sprawdz(f"{tabela} ma włączone reguły dostępu",
            w(f"select relrowsecurity from pg_class where relname='{tabela}'") == "true")
    sprawdz(f"{tabela} ma regułę na własne wiersze",
            w(f"select count(*) from pg_policies where tablename='{tabela}'") == "1")

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
