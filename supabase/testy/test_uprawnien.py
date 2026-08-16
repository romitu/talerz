#!/usr/bin/env python3
"""
Test uprawnień — czy da się awansować samemu na administratora.

    pip install pgserver
    python3 testy/test_uprawnien.py

Po co ten test istnieje
-----------------------
Bo dziura, którą sprawdza, BYŁA. Reguła „każdy może zmieniać swoje konto”
obejmowała także kolumnę `rola`, bo reguły dostępu w PostgreSQL działają na
całych wierszach. Jedno zapytanie i zwykły użytkownik miał prawa administratora.

Czytając samą regułę nie widać tego wcale — wygląda poprawnie. Widać dopiero
wtedy, gdy się spróbuje. Dlatego ten plik nie sprawdza, czy reguły „są”,
tylko czy ATAK SIĘ NIE UDAJE.

Odtwarzamy rolę `authenticated` i ustawienie `request.jwt.claim.sub`, czyli
dokładnie to, czym PostgREST przedstawia zalogowanego użytkownika. Zapytania
idą tą samą drogą co z przeglądarki.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_uprawnienia")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))

NAPASTNIK = "11111111-1111-1111-1111-111111111111"
ROMAN = "22222222-2222-2222-2222-222222222222"


def sql(q):
    try:
        return srv.psql("\\set ON_ERROR_STOP on\n" + q), False
    except Exception as e:
        return str(e), True


def jako(kto, q):
    """Wykonuje zapytanie tak, jak zrobiłaby to przeglądarka zalogowanego użytkownika."""
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


# --- baza z odtworzonym otoczeniem Supabase ----------------------------------
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

# Uprawnienia tabelowe takie, jakie Supabase nadaje rolom aplikacji.
sql("""grant usage on schema public to authenticated;
grant select, insert, update, delete on all tables in schema public to authenticated;
grant usage on all sequences in schema public to authenticated;""")

sql(f"""insert into auth.users (id, email) values
      ('{NAPASTNIK}', 'napastnik@obcy.pl'),
      ('{ROMAN}', 'roman@t.pl');""")

# Pierwszego administratora nadaje się z panelu, poza aplikacją — i to musi działać.
out, blad = sql(f"update konta set rola = 'administrator' where id = '{ROMAN}';")
sprawdz("administratora da się nadać z panelu Supabase", not blad, out[:300] if blad else "")
sprawdz("i rola faktycznie się zapisała",
        w(f"select rola from konta where id = '{ROMAN}'") == "administrator")

# --- 1. SEDNO: samodzielny awans ---------------------------------------------
out, blad = jako(NAPASTNIK, f"update konta set rola = 'administrator' where id = '{NAPASTNIK}';")
po = w(f"select rola from konta where id = '{NAPASTNIK}'")
sprawdz("zwykły użytkownik NIE awansuje się na administratora", po == "uzytkownik",
        f"(rola po próbie: {po})")
sprawdz("próba kończy się błędem, a nie cichym pominięciem", blad, out[:200])

out, blad = jako(NAPASTNIK, f"update konta set rola = 'moderator' where id = '{NAPASTNIK}';")
sprawdz("ani na moderatora",
        w(f"select rola from konta where id = '{NAPASTNIK}'") == "uzytkownik")

# --- 2. cudzych kont nie rusza ------------------------------------------------
jako(NAPASTNIK, f"update konta set rola = 'uzytkownik' where id = '{ROMAN}';")
sprawdz("nie odbiera roli administratorowi",
        w(f"select rola from konta where id = '{ROMAN}'") == "administrator")

# --- 3. własne konto poza rolą dalej edytowalne -------------------------------
out, blad = jako(NAPASTNIK, f"update konta set zgoda_regulamin = true where id = '{NAPASTNIK}';")
sprawdz("zgody na własnym koncie dalej da się zapisać", not blad, out[:200] if blad else "")
sprawdz("i zapisały się naprawdę",
        w(f"select zgoda_regulamin from konta where id = '{NAPASTNIK}'") == "true")

# --- 4. role nadaje się WYŁĄCZNIE z panelu ------------------------------------
# Reguła `konta_zapis_wlasne` pozwala zmieniać tylko własny wiersz, więc nawet
# administrator nie zmieni cudzej roli PRZEZ APLIKACJĘ. To zamierzone: aplikacja
# nie ma ekranu do nadawania uprawnień, a im mniej dróg do tej kolumny, tym
# mniej jest do pilnowania. Nadawanie ról odbywa się w SQL Editorze.
jako(ROMAN, f"update konta set rola = 'moderator' where id = '{NAPASTNIK}';")
sprawdz("nawet administrator nie zmienia cudzej roli z aplikacji",
        w(f"select rola from konta where id = '{NAPASTNIK}'") == "uzytkownik")

out, blad = sql(f"update konta set rola = 'moderator' where id = '{NAPASTNIK}';")
sprawdz("z panelu Supabase rola zmienia się normalnie",
        not blad and w(f"select rola from konta where id = '{NAPASTNIK}'") == "moderator")

# --- 5. co z tego wynikało: dostęp do cudzych przepisów -----------------------
sql(f"""
insert into przepisy (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                      porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,
                      widocznosc)
values ('Przepis Romana', 'x', '{ROMAN}', '{{obiad}}', '{{polska}}', 3, 'waga', 800, 10, 50,
        'prywatna');
""")
sql(f"update konta set rola = 'uzytkownik' where id = '{NAPASTNIK}';")

jako(NAPASTNIK, "delete from przepisy where nazwa = 'Przepis Romana';")
sprawdz("zwykły użytkownik nie kasuje cudzego przepisu",
        w("select count(*) from przepisy where nazwa = 'Przepis Romana'") == "1")

jako(NAPASTNIK, """
insert into skladniki (nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
                       blonnik_100g, cukry_wolne_100g, zrodlo)
values ('Podrzucony składnik', 1, 1, 1, 1, 1, 1, 'wlasne');
""")
sprawdz("zwykły użytkownik nie dopisuje składników do wspólnej bazy",
        w("select count(*) from skladniki where nazwa = 'Podrzucony składnik'") == "0")

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
