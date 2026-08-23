#!/usr/bin/env python3
"""
Test wyłączania kont (migracja 0023).

    pip install pgserver
    python3 testy/test_kont_nieaktywnych.py

Czego pilnujemy
---------------
Wyłączenie konta MUSI działać w bazie, nie w aplikacji. Klucz publiczny jest
jawny w opublikowanej stronie, więc każdy może wysłać zapytanie z pominięciem
interfejsu — a wtedy „wyłączony” użytkownik, którego blokuje tylko ekran,
dalej ma pełny dostęp do swoich i cudzych danych.

Ten plik nie sprawdza, czy kolumna istnieje. Sprawdza, czy WYŁĄCZONE KONTO
NAPRAWDĘ NIC NIE MOŻE — czytając i pisząc tą samą drogą co przeglądarka.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_nieaktywne")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))

ADMIN = "11111111-1111-1111-1111-111111111111"
GOSC = "22222222-2222-2222-2222-222222222222"


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


def ile_widzi(kto, tabela):
    """Ile wierszy widzi dany użytkownik — tą samą drogą co przeglądarka."""
    out, _ = jako(kto, f"select 'L<'||count(*)||'>' from {tabela};")
    m = re.search(r"L<(\d+)>", out)
    return int(m.group(1)) if m else -1


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

for n in sorted(p.name for p in K.glob("*.sql")):
    out, blad = sql((K / n).read_text(encoding="utf-8"))
    if blad:
        print("BLAD", n)
        print(out[:1500])
        sys.exit(1)
print(f"Migracje wykonane ({len(list(K.glob('*.sql')))} plików).")

sql("""grant usage on schema public to authenticated;
grant select, insert, update, delete on all tables in schema public to authenticated;""")

sql(f"""
insert into auth.users (id, email) values ('{ADMIN}', 'roman@t.pl'), ('{GOSC}', 'gosc@t.pl');
update konta set rola = 'administrator' where id = '{ADMIN}';

insert into profile (konto_id, imie, plec, data_urodzenia, wzrost_cm, aktywnosc)
values ('{GOSC}', 'Gość', 'M', date '1970-03-01', 180, 'nieaktywny');

insert into plany (konto_id, data_start, dni) values ('{GOSC}', current_date, 7);
insert into zakupy_reczne (konto_id, nazwa) values ('{GOSC}', 'Worki na śmieci');
""")

sprawdz("nowe konto jest czynne", w(f"select aktywne from konta where id = '{GOSC}'") == "true")

# --- 1. czynne konto widzi swoje ---------------------------------------------
sprawdz("czynny widzi swój profil", ile_widzi(GOSC, "profile") == 1)
sprawdz("czynny widzi swój plan", ile_widzi(GOSC, "plany") == 1)
sprawdz("czynny widzi swoją listę zakupów", ile_widzi(GOSC, "zakupy_reczne") == 1)

# --- 2. SEDNO: po wyłączeniu nie widzi NICZEGO --------------------------------
out, blad = jako(ADMIN, f"update konta set aktywne = false where id = '{GOSC}';")
sprawdz("administrator wyłącza konto", not blad and w(f"select aktywne from konta where id='{GOSC}'") == "false",
        out[:200] if blad else "")

sprawdz("wyłączony NIE widzi swojego profilu", ile_widzi(GOSC, "profile") == 0)
sprawdz("wyłączony NIE widzi swojego planu", ile_widzi(GOSC, "plany") == 0)
sprawdz("wyłączony NIE widzi swojej listy zakupów", ile_widzi(GOSC, "zakupy_reczne") == 0)

# --- 3. ...ani nic nie zapisze ------------------------------------------------
przed = w("select count(*) from zakupy_reczne")
jako(GOSC, f"insert into zakupy_reczne (konto_id, nazwa) values ('{GOSC}', 'Podrzucone');")
sprawdz("wyłączony nic nie dopisze", przed == w("select count(*) from zakupy_reczne"))

jako(GOSC, f"delete from plany where konto_id = '{GOSC}';")
sprawdz("wyłączony nic nie skasuje", w("select count(*) from plany") == "1")

# --- 4. ale DANE ZOSTAJĄ — to jest sens wyłączania zamiast kasowania ----------
sprawdz("profil dalej jest w bazie", w(f"select count(*) from profile where konto_id='{GOSC}'") == "1")
sprawdz("plan dalej jest w bazie", w(f"select count(*) from plany where konto_id='{GOSC}'") == "1")

# --- 5. konto widzi SAMO SIEBIE, żeby wiedzieć, że jest wyłączone -------------
out, _ = jako(GOSC, "select 'S<'||count(*)||'>' from konta;")
sprawdz("wyłączony widzi własny wiersz konta", "S<1>" in out,
        "bez tego aplikacja nie ma skąd wiedzieć, że ma pokazać komunikat")

# --- 6. sam się nie włączy z powrotem -----------------------------------------
out, blad = jako(GOSC, f"update konta set aktywne = true where id = '{GOSC}';")
sprawdz("wyłączony NIE włączy się sam", w(f"select aktywne from konta where id='{GOSC}'") == "false")
sprawdz("próba kończy się błędem", blad, out[:160])

# --- 7. wyłączony moderator traci uprawnienia ---------------------------------
sql(f"update konta set rola = 'moderator' where id = '{GOSC}';")
sql(f"""insert into skladniki (nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
                               blonnik_100g, cukry_wolne_100g, zrodlo)
        values ('Marchew testowa', 41, 0.9, 0.2, 9.6, 2.8, 0, 'wlasne');""")
przed = w("select count(*) from skladniki")
jako(GOSC, """insert into skladniki (nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
                                     blonnik_100g, cukry_wolne_100g, zrodlo)
              values ('Podrzucony', 1, 1, 1, 1, 1, 1, 'wlasne');""")
sprawdz("wyłączony moderator nie dopisze składnika",
        przed == w("select count(*) from skladniki"))

# --- 8. włączenie przywraca wszystko ------------------------------------------
out, blad = jako(ADMIN, f"update konta set aktywne = true where id = '{GOSC}';")
sprawdz("administrator włącza konto z powrotem", not blad, out[:200] if blad else "")
sprawdz("dane wracają — profil", ile_widzi(GOSC, "profile") == 1)
sprawdz("dane wracają — plan", ile_widzi(GOSC, "plany") == 1)
sprawdz("znacznik wyłączenia wyczyszczony",
        w(f"select wylaczone_kiedy from konta where id='{GOSC}'") == "NULL")

# --- 9. administrator nie zatrzaśnie drzwi z kluczem w środku -----------------
out, blad = jako(ADMIN, f"update konta set aktywne = false where id = '{ADMIN}';")
sprawdz("administrator nie wyłączy sam siebie",
        w(f"select aktywne from konta where id='{ADMIN}'") == "true")
sprawdz("i dostaje o tym błąd", blad, out[:160])

# --- 10. zwykły użytkownik nie wyłącza cudzych kont ---------------------------
sql(f"update konta set rola = 'uzytkownik' where id = '{GOSC}';")
jako(GOSC, f"update konta set aktywne = false where id = '{ADMIN}';")
sprawdz("zwykły użytkownik nie wyłączy administratora",
        w(f"select aktywne from konta where id='{ADMIN}'") == "true")

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
