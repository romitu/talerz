#!/usr/bin/env python3
"""
Test migracji 0014 i 0015 — dodatki jako czwarta kategoria przepisu.

    pip install pgserver
    python3 testy/test_dodatkow.py

Sprawdza trzy rzeczy:

  1. że przepis da się oznaczyć jako „dodatek”,
  2. że przepis może należeć do kilku kategorii naraz,
  3. że „dodatek” NIE przejdzie jako pora w planie dnia — dzień ma trzy posiłki
     i to jest reguła bazy, nie interfejsu.

Punkt trzeci jest sednem. Aplikacja oferuje tylko trzy pory, więc bez tego
testu nikt by nie zauważył, gdyby ograniczenie zniknęło przy jakiejś kolejnej
migracji.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_dodatki")
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


bledy = []


def sprawdz(opis, warunek, dodatek=""):
    if warunek:
        print(f"  ok   {opis}")
    else:
        print(f"  ZLE  {opis} {dodatek}")
        bledy.append(opis)


sql("""create schema if not exists auth;
create table if not exists auth.users (
  id uuid primary key default gen_random_uuid(), email text,
  created_at timestamptz not null default now());
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

for n in sorted(p.name for p in K.glob("*.sql")):
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1200])
        sys.exit(1)
print(f"Migracje wykonane ({len(list(K.glob('*.sql')))} plików).")

A = "11111111-1111-1111-1111-111111111111"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl');")

# --- 1. wartość istnieje w typie ---------------------------------------------
sprawdz("typ pora_posilku ma cztery wartości",
        w("""select count(*) from pg_enum e join pg_type t on t.oid = e.enumtypid
             where t.typname = 'pora_posilku'""") == "4")
sprawdz("jedną z nich jest „dodatek”",
        w("""select count(*) from pg_enum e join pg_type t on t.oid = e.enumtypid
             where t.typname = 'pora_posilku' and e.enumlabel = 'dodatek'""") == "1")

# --- 2. przepis oznaczony jako dodatek ---------------------------------------
out, blad = sql(f"""
insert into przepisy (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                      porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min)
values ('Grillowana pierś', 'do sałatki albo do ryżu', '{A}',
        '{{dodatek}}', '{{polska}}', 3, 'waga', 200, 10, 10);
""")
sprawdz("przepis może być dodatkiem", not blad, out[:300] if blad else "")

# --- 3. kilka kategorii naraz ------------------------------------------------
out, blad = sql(f"""
insert into przepisy (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                      porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min)
values ('Zupa ogórkowa próbna', 'i obiad, i kolacja', '{A}',
        '{{obiad,kolacja}}', '{{polska}}', 3, 'waga', 800, 20, 50);
""")
sprawdz("przepis może mieć kilka kategorii", not blad, out[:300] if blad else "")
sprawdz("obie kategorie się zapisały",
        w("select array_length(pory,1) from przepisy where nazwa='Zupa ogórkowa próbna'") == "2")

# --- 4. dodatek NIE jest porą w planie ---------------------------------------
# Konto zakłada wyzwalacz na auth.users; gdyby go nie było, robimy to sami.
sql(f"insert into konta (id) values ('{A}') on conflict (id) do nothing;")
out, blad = sql(f"""
insert into plany (id, konto_id, data_start)
values ('22222222-2222-2222-2222-222222222222', '{A}', current_date);
""")
sprawdz("plan próbny założony", not blad, out[:300] if blad else "")

id_przepisu = w("select id from przepisy where nazwa='Grillowana pierś'")

przed = w("select count(*) from plan_pozycje")
out, blad = sql(f"""
insert into plan_pozycje (plan_id, data, pora, przepis_id, porcje)
values ('22222222-2222-2222-2222-222222222222', current_date, 'dodatek',
        '{id_przepisu}', 1);
""")
po = w("select count(*) from plan_pozycje")
sprawdz("„dodatek” nie wchodzi do planu jako pora", przed == po,
        f"(przed {przed}, po {po})")

# a trzy prawdziwe pory wchodzą
for pora in ("sniadanie", "obiad", "kolacja"):
    przed = w("select count(*) from plan_pozycje")
    sql(f"""
    insert into plan_pozycje (plan_id, data, pora, przepis_id, porcje)
    values ('22222222-2222-2222-2222-222222222222', current_date, '{pora}',
            '{id_przepisu}', 1);
    """)
    po = w("select count(*) from plan_pozycje")
    sprawdz(f"„{pora}” wchodzi do planu normalnie", int(po) == int(przed) + 1)

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
