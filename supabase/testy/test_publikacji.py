#!/usr/bin/env python3
"""
Test obiegu publikacji przepisu.

    pip install pgserver
    python3 testy/test_publikacji.py

Po co
-----
Bo dziura, którą sprawdza pierwsza sekcja, BYŁA: autor mógł jednym zapytaniem
ustawić swojemu przepisowi widoczność „publiczna” i ominąć moderatora. Reguła
dostępu wyglądała poprawnie — mówiła, że przepis po zmianie dalej należy
do autora — tylko o kolumnie `widocznosc` nie mówiła nic.

Ten plik nie sprawdza, czy reguły „są”. Sprawdza, czy OBEJŚCIE SIĘ NIE UDAJE,
i czy przy okazji nie zablokowaliśmy rzeczy dozwolonych.
"""
import pgserver, pathlib, re, shutil, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
B = pathlib.Path("/tmp/talerz_publikacja")
if B.exists():
    shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))

AUTOR = "11111111-1111-1111-1111-111111111111"
MODERATOR = "22222222-2222-2222-2222-222222222222"
OBCY = "33333333-3333-3333-3333-333333333333"


def sql(q):
    try:
        return srv.psql("\\set ON_ERROR_STOP on\n" + q), False
    except Exception as e:
        return str(e), True


def jako(kto, q):
    """Zapytanie tak, jak wysłałaby je przeglądarka zalogowanego użytkownika."""
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


def stan():
    return w("select widocznosc from przepisy where nazwa = 'Przepis autora'")


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

sql(f"""insert into auth.users (id, email) values
      ('{AUTOR}', 'autor@t.pl'), ('{MODERATOR}', 'moderator@t.pl'), ('{OBCY}', 'obcy@t.pl');
update konta set rola = 'moderator' where id = '{MODERATOR}';
insert into przepisy (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                      porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min)
values ('Przepis autora', 'x', '{AUTOR}', '{{obiad}}', '{{polska}}', 3, 'waga', 800, 10, 50);
""")

sprawdz("nowy przepis jest prywatny", stan() == "prywatna")

# --- 1. SEDNO: autor nie publikuje się sam -----------------------------------
out, blad = jako(AUTOR, "update przepisy set widocznosc = 'publiczna' where nazwa = 'Przepis autora';")
sprawdz("autor NIE ustawia sobie widoczności publicznej", stan() == "prywatna",
        f"(stan po próbie: {stan()})")
sprawdz("próba kończy się błędem, a nie cichym pominięciem", blad, out[:160])

# --- 2. ...ale może zgłosić i wycofać ----------------------------------------
out, blad = jako(AUTOR, "update przepisy set widocznosc = 'zgloszona' where nazwa = 'Przepis autora';")
sprawdz("autor zgłasza przepis do publikacji", not blad and stan() == "zgloszona",
        out[:160] if blad else stan())
sprawdz("wyzwalacz zapisał datę zgłoszenia",
        w("select zgloszono_kiedy is not null from przepisy where nazwa = 'Przepis autora'") == "true")

out, blad = jako(AUTOR, "update przepisy set widocznosc = 'publiczna' where nazwa = 'Przepis autora';")
sprawdz("ze stanu zgłoszonego też nie przeskoczy na publiczny", stan() == "zgloszona")

out, blad = jako(AUTOR, "update przepisy set widocznosc = 'prywatna' where nazwa = 'Przepis autora';")
sprawdz("autor wycofuje zgłoszenie", not blad and stan() == "prywatna", out[:160] if blad else "")
sprawdz("i data zgłoszenia znika",
        w("select zgloszono_kiedy from przepisy where nazwa = 'Przepis autora'") == "NULL")

# --- 3. obcy nie rusza cudzego -----------------------------------------------
jako(OBCY, "update przepisy set widocznosc = 'zgloszona' where nazwa = 'Przepis autora';")
sprawdz("obcy nie zgłasza cudzego przepisu", stan() == "prywatna")

# --- 4. moderator odrzuca z powodem -------------------------------------------
jako(AUTOR, "update przepisy set widocznosc = 'zgloszona' where nazwa = 'Przepis autora';")
out, blad = jako(MODERATOR, """
update przepisy set widocznosc = 'prywatna',
                    powod_odrzucenia = 'Brakuje gramatury przy dwóch składnikach.'
 where nazwa = 'Przepis autora';
""")
sprawdz("moderator odrzuca przepis", not blad and stan() == "prywatna", out[:200] if blad else "")
sprawdz("powód wraca do autora",
        w("select powod_odrzucenia from przepisy where nazwa = 'Przepis autora'")
        == "Brakuje gramatury przy dwóch składnikach.")
sprawdz("data rozpatrzenia zapisana",
        w("select rozpatrzono_kiedy is not null from przepisy where nazwa = 'Przepis autora'") == "true")

# Ponowne zgłoszenie kasuje nieaktualną już uwagę.
jako(AUTOR, "update przepisy set widocznosc = 'zgloszona' where nazwa = 'Przepis autora';")
sprawdz("ponowne zgłoszenie czyści stary powód odrzucenia",
        w("select powod_odrzucenia from przepisy where nazwa = 'Przepis autora'") == "NULL")

# --- 5. moderator zatwierdza --------------------------------------------------
out, blad = jako(MODERATOR, "update przepisy set widocznosc = 'publiczna' where nazwa = 'Przepis autora';")
sprawdz("moderator publikuje przepis", not blad and stan() == "publiczna", out[:200] if blad else "")

# --- 6. po publikacji autor traci możliwość edycji ----------------------------
jako(AUTOR, "update przepisy set opis = 'podmienione po publikacji' where nazwa = 'Przepis autora';")
sprawdz("autor nie zmienia treści opublikowanego przepisu",
        w("select opis from przepisy where nazwa = 'Przepis autora'") == "x")

jako(AUTOR, "update przepisy set widocznosc = 'prywatna' where nazwa = 'Przepis autora';")
sprawdz("autor nie wycofuje opublikowanego przepisu", stan() == "publiczna")

jako(AUTOR, "delete from przepisy where nazwa = 'Przepis autora';")
sprawdz("autor nie kasuje opublikowanego przepisu",
        w("select count(*) from przepisy where nazwa = 'Przepis autora'") == "1")

# --- 7. kto co widzi ----------------------------------------------------------
sql(f"""insert into przepisy (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni,
                              porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min)
        values ('Szkic autora', 'y', '{AUTOR}', '{{obiad}}', '{{polska}}', 3, 'waga', 800, 10, 50);""")

out, _ = jako(OBCY, "select count(*) as ile from przepisy;")
sprawdz("obcy widzi tylko przepis publiczny", " 1\n" in out, out[-120:])

out, _ = jako(AUTOR, "select count(*) as ile from przepisy;")
sprawdz("autor widzi swój szkic i przepis publiczny", " 2\n" in out, out[-120:])

out, _ = jako(MODERATOR, "select count(*) as ile from przepisy;")
sprawdz("moderator widzi wszystko", " 2\n" in out, out[-120:])

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
