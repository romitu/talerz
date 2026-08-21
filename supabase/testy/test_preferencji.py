#!/usr/bin/env python3
"""
Test poziomów preferencji (migracja 0025).

    pip install pgserver
    python3 testy/test_preferencji.py

Po co ten test istnieje
------------------------
Migracja 0025 zamienia tabelę `polubienia` (był / nie było) na
`preferencje_przepisow` z trzema poziomami. Przy tej okazji pierwsza wersja
migracji zostawiła DWIE polityki odczytu naraz: starą publiczną
(`polubienia_odczyt`, każdy zalogowany widzi wszystko) i nową prywatną
(`preferencje_wlasne`, tylko własne wiersze). W PostgreSQL wiele reguł
permisywnych dla tej samej komendy sumuje się przez OR — szersza wygrywa,
więc węższa była martwym zapisem, a preferencja każdego konta była jawna
dla każdego innego zalogowanego użytkownika.

Ten plik nie sprawdza, czy polityka „jest”. Sprawdza, czy CUDZEJ preferencji
NAPRAWDĘ nie widać — tą samą drogą co przeglądarka.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_preferencje")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))

ROMAN = "11111111-1111-1111-1111-111111111111"
GOSC = "22222222-2222-2222-2222-222222222222"
PRZEPIS = "33333333-3333-3333-3333-333333333333"


def sql(q):
    try:
        return srv.psql("\\set ON_ERROR_STOP on\n" + q), False
    except Exception as e:
        return str(e), True


def jako(kto, q):
    return sql(f"""
begin;
set local role authenticated;
set local request.jwt.claim.sub = '{kto}';
{q}
commit;
""")


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


# --- otoczenie Supabase -------------------------------------------------------
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
alter table storage.objects enable row level security;
do $r$ begin
  if not exists (select 1 from pg_roles where rolname = 'authenticated') then
    create role authenticated nologin;
  end if;
end $r$;""")

# --- migracje w dwóch turach: PRZED 0025 i OD 0025 ----------------------------
# Rozdział jest celowy: chcemy wstawić wiersz do starej tabeli `polubienia`,
# zanim migracja 0025 przemianuje ją i doda kolumnę `poziom` — dokładnie tak,
# jak wygląda to na serwerze, gdzie migracje wykonują się PO KOLEI na bazie
# z już istniejącymi danymi, a nie na pustej.
wszystkie = sorted(p.name for p in K.glob("*.sql"))
przed_0025 = [n for n in wszystkie if n < "0025"]
od_0025 = [n for n in wszystkie if n >= "0025"]

for n in przed_0025:
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1500])
        sys.exit(1)

sql("""grant usage on schema public to authenticated;
grant select, insert, update, delete on all tables in schema public to authenticated;""")

sql(f"""
insert into auth.users (id, email) values ('{ROMAN}', 'roman@t.pl'), ('{GOSC}', 'gosc@t.pl');

insert into przepisy (id, nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                      porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
                      widocznosc)
values ('{PRZEPIS}', 'Barszcz testowy', 'x', '{ROMAN}', '{{obiad}}', '{{polska}}', 3,
        'waga', 800, 10, 50, 'publiczna');

-- Stary, binarny „lajk” — ma przetrwać migrację 0025 jako poziom 'lubie'.
insert into polubienia (przepis_id, konto_id) values ('{PRZEPIS}', '{ROMAN}');
""")

sprawdz("stare polubienie zapisane przed migracją 0025", w(
    f"select count(*) from polubienia where przepis_id='{PRZEPIS}' and konto_id='{ROMAN}'"
) == "1")

for n in od_0025:
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1500])
        sys.exit(1)
print(f"Migracje wykonane ({len(wszystkie)} plików, podzielone wokół 0025).")

# --- 1. SEDNO: dane się nie zgubiły przy zmianie nazwy tabeli -----------------
sprawdz("tabela `polubienia` już nie istnieje",
        w("select count(*) from information_schema.tables where table_name='polubienia'") == "0")
sprawdz("stare polubienie przetrwało jako poziom 'lubie'", w(
    f"select poziom from preferencje_przepisow where przepis_id='{PRZEPIS}' and konto_id='{ROMAN}'"
) == "lubie")

# --- 2. własną preferencję widać i da się ją zmienić --------------------------
out, blad = jako(ROMAN, f"""
update preferencje_przepisow set poziom = 'ulubione'
 where przepis_id = '{PRZEPIS}' and konto_id = '{ROMAN}';
""")
sprawdz("właściciel zmienia własną preferencję", not blad, out[:200] if blad else "")
sprawdz("zmiana się zapisała", w(
    f"select poziom from preferencje_przepisow where przepis_id='{PRZEPIS}' and konto_id='{ROMAN}'"
) == "ulubione")

# --- 3. SEDNO: gość nie widzi preferencji Romana -------------------------------
out, _ = jako(GOSC, f"select 'L<'||count(*)||'>' from preferencje_przepisow;")
sprawdz("gość bez własnych preferencji widzi ZERO wierszy (nie cudze Romana)",
        "L<0>" in out, out[:200])

# Gość zapisuje WŁASNĄ preferencję na tym samym przepisie.
jako(GOSC, f"""
insert into preferencje_przepisow (przepis_id, konto_id, poziom)
values ('{PRZEPIS}', '{GOSC}', 'nie_proponuj');
""")
out, _ = jako(GOSC, "select 'L<'||count(*)||'>' from preferencje_przepisow;")
sprawdz("gość widzi WYŁĄCZNIE swój własny wiersz, nie widzi Romana", "L<1>" in out, out[:200])

# --- 4. gość nie podszyje się pod Romana ---------------------------------------
out, blad = jako(GOSC, f"""
update preferencje_przepisow set poziom = 'nie_proponuj'
 where przepis_id = '{PRZEPIS}' and konto_id = '{ROMAN}';
""")
sprawdz("gość nie zmieni preferencji Romana (0 wierszy dotkniętych)",
        w(f"select poziom from preferencje_przepisow where konto_id='{ROMAN}'") == "ulubione")

out, blad = jako(GOSC, f"""
insert into preferencje_przepisow (przepis_id, konto_id, poziom)
values ('{PRZEPIS}', '{ROMAN}', 'ulubione')
on conflict (przepis_id, konto_id) do update set poziom = excluded.poziom;
""")
sprawdz("gość nie wstawi/nadpisze wiersza na cudzym koncie", blad, out[:200] if blad else "")

# --- 5. „neutralne” to brak wiersza — kasowanie działa -------------------------
jako(GOSC, f"""
delete from preferencje_przepisow where przepis_id = '{PRZEPIS}' and konto_id = '{GOSC}';
""")
out, _ = jako(GOSC, "select 'L<'||count(*)||'>' from preferencje_przepisow;")
sprawdz("skasowanie wiersza wraca do neutralnego (zero wierszy)", "L<0>" in out, out[:200])

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
