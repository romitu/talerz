#!/usr/bin/env python3
"""
Test sprzątania starych tygodni.

    pip install pgserver
    python3 testy/test_sprzatania_planow.py

Czego tu naprawdę pilnujemy
---------------------------
Sprzątanie robi aplikacja, nie baza — ale opiera się na tym, JAK baza reaguje
na skasowanie planu. Te reakcje są w dwóch miejscach ustawione przeciwnie:

    plany → plan_pozycje        on delete cascade    (pozycje znikają same)
    partie → plan_pozycje       on delete set null   (partie NIE znikają)

Druga z nich jest zdradliwa. Skasowanie planu zabiera pozycje, ale zostawia
gotowania jako wiersze, których nic już nie pokazuje ani nie kasuje — cicha
sterta rosnąca dokładnie tam, gdzie sprzątaliśmy. Dlatego kod usuwa partie
osobno, a ten test potwierdza, że to nie nadgorliwość.

Sprawdzamy też rozmiar rocznej historii, bo to on przesądził o tym, że limit
istnieje z powodu wygody, a nie miejsca w bazie.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_sprzatanie")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))

TYGODNI_HISTORII = 12  # musi zgadzać się ze stałą w lib/plan.ts


def sql(q):
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
 $$ select nullif(current_setting('request.jwt.claim.sub', true),'')::uuid $$;
create schema if not exists storage;
create table if not exists storage.buckets (
  id text primary key, name text not null, public boolean not null default false,
  file_size_limit bigint, allowed_mime_types text[]);
create table if not exists storage.objects (
  id uuid primary key default gen_random_uuid(),
  bucket_id text references storage.buckets (id), name text);
alter table storage.objects enable row level security;""")

for n in sorted(p.name for p in K.glob("*.sql")):
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1500])
        sys.exit(1)
print(f"Migracje wykonane ({len(list(K.glob('*.sql')))} plików).")

A = "11111111-1111-1111-1111-111111111111"

# Rok planowania: 52 tygodnie po 7 gotowań i 21 posiłków.
sql(f"""
insert into auth.users (id, email) values ('{A}', 'a@t.pl');
insert into konta (id) values ('{A}') on conflict do nothing;
insert into skladniki (nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
                       blonnik_100g, cukry_wolne_100g, zrodlo)
  values ('Składnik próbny', 41, 0.9, 0.2, 9.6, 2.8, 0, 'wlasne');
insert into przepisy (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                      porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min)
  values ('Danie próbne', 'x', '{A}', '{{obiad}}', '{{polska}}', 3, 'waga', 800, 10, 50);

do $wypelnij$
declare t int; d int; p uuid; pid uuid; par uuid;
begin
  select id into pid from przepisy where nazwa = 'Danie próbne';
  for t in 0..51 loop
    insert into plany (konto_id, data_start, dni)
      values ('{A}', date '2026-01-05' + (t * 7), 7) returning id into p;
    for d in 0..6 loop
      insert into partie (konto_id, przepis_id, data_ugotowania,
                          porcji_razem, porcji_zostalo, wazne_do)
        values ('{A}', pid, date '2026-01-05' + (t * 7) + d, 3, 3, date '2026-01-05')
        returning id into par;
      insert into plan_pozycje (plan_id, data, pora, przepis_id, porcje, kolejnosc, partia_id)
        values (p, date '2026-01-05' + (t * 7) + d, 'sniadanie', pid, 1, 1, par),
               (p, date '2026-01-05' + (t * 7) + d, 'obiad',     pid, 1, 1, par),
               (p, date '2026-01-05' + (t * 7) + d, 'kolacja',   pid, 1, 1, par);
    end loop;
  end loop;
end
$wypelnij$;
""")

sprawdz("rok planowania to 52 tygodnie", w("select count(*) from plany") == "52")
sprawdz("i 1092 posiłki", w("select count(*) from plan_pozycje") == "1092")
sprawdz("i 364 gotowania", w("select count(*) from partie") == "364")

# --- rozmiar: to on przesądza, że limit jest dla wygody, nie dla miejsca -----
bajty = int(w("""select pg_total_relation_size('plany')
                      + pg_total_relation_size('plan_pozycje')
                      + pg_total_relation_size('partie')"""))
print(f"       (rok historii zajmuje {round(bajty / 1024)} kB razem z indeksami)")
sprawdz("rok historii mieści się w 2 MB", bajty < 2 * 1024 * 1024, f"({bajty} B)")

# --- 1. kasowanie planu zabiera pozycje kaskadowo ----------------------------
plan = w("select id from plany order by data_start limit 1")
przed = w("select count(*) from plan_pozycje")
sql(f"delete from plany where id = '{plan}';")
po = w("select count(*) from plan_pozycje")
sprawdz("skasowanie tygodnia zabiera jego 21 posiłków",
        int(przed) - int(po) == 21, f"(przed {przed}, po {po})")

# --- 2. ...ale ZOSTAWIA gotowania. To jest sedno testu ----------------------
sprawdz("gotowania NIE znikają razem z planem — trzeba je kasować osobno",
        w("select count(*) from partie") == "364")

osierocone = w("""select count(*) from partie p
                  where not exists (select 1 from plan_pozycje pp where pp.partia_id = p.id)""")
sprawdz("po skasowaniu tygodnia zostaje 7 osieroconych gotowań",
        osierocone == "7", f"(jest {osierocone})")

# --- 3. sprzątanie tak, jak robi to aplikacja --------------------------------
# Krok w krok: zbierz partie ze skazanych planów, usuń plany, usuń te partie.
sql(f"""
create temp table skazane as
  select id from plany order by data_start desc offset {TYGODNI_HISTORII};

create temp table ich_partie as
  select distinct partia_id as id from plan_pozycje
   where plan_id in (select id from skazane) and partia_id is not null;

delete from plany where id in (select id from skazane);
delete from partie where id in (select id from ich_partie);
""")

sprawdz(f"zostaje dokładnie {TYGODNI_HISTORII} tygodni",
        w("select count(*) from plany") == str(TYGODNI_HISTORII))
sprawdz("zostają tylko posiłki zachowanych tygodni",
        w("select count(*) from plan_pozycje") == str(TYGODNI_HISTORII * 21))
sprawdz("zostają tylko gotowania zachowanych tygodni",
        w("select count(*) from partie") == str(TYGODNI_HISTORII * 7 + 7),
        f"(jest {w('select count(*) from partie')}, w tym 7 osieroconych z kroku 1)")

# Tygodnie 0..51 startują 5 stycznia. Dwanaście najnowszych to numery 40–51,
# więc najstarszy zachowany zaczyna się 5 stycznia + 280 dni = 12 października.
sprawdz("zachowane są NAJNOWSZE tygodnie",
        w("select min(data_start) from plany") == "2026-10-12",
        w("select min(data_start) from plany"))
sprawdz("najnowszy tydzień jest nietknięty",
        w("select max(data_start) from plany") == "2026-12-28",
        w("select max(data_start) from plany"))

# --- 4. przepisy przeżywają sprzątanie ---------------------------------------
# `plan_pozycje.przepis_id` ma `on delete restrict` w drugą stronę, ale samo
# kasowanie planów nie może ruszyć przepisów — to byłaby katastrofa.
sprawdz("przepis nie znika razem z historią", w("select count(*) from przepisy") == "1")
sprawdz("składnik nie znika razem z historią", w("select count(*) from skladniki") != "0")

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
