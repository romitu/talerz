#!/usr/bin/env python3
"""
Test migracji 0011 — sprzęt bez powtórek.

    pip install pgserver
    python3 testy/test_sprzetu.py

Sprawdza scalanie pozycji różniących się tylko wielkością liter albo spacjami,
podmianę nazw w przepisach oraz widok pokazujący, gdzie sprzęt jest używany.

Uwaga metodyczna: powtórki usuwamy po identyfikatorze, a nie po nazwie.
Po przycięciu białych znaków bywają identyczne co do znaku i warunek
„inna nazwa” nie usunąłby żadnej z nich.
"""
import pgserver, pathlib, re, shutil, sys
K = pathlib.Path(__file__).resolve().parent.parent / "migrations"
B = pathlib.Path("/tmp/talerz_p11")
if B.exists(): shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))
def sql(q):
    # ON_ERROR_STOP — bez tego psql leci dalej po błędzie i kończy się kodem zero
    try: return srv.psql("\\set ON_ERROR_STOP on\n" + q), False
    except Exception as e: return str(e), True
def w(q):
    out,_ = sql(f"select 'W<'||({q})||'>';"); m=re.search(r"W<([^>]*)>",out); return m.group(1) if m else None
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
# wgrywamy wszystko poza 0011, potem robimy balagan, potem 0011
for n in [x for x in pliki if not x.startswith("0011")]:
    out, blad = sql((K/n).read_text(encoding="utf-8"))
    if blad: print("BLAD", n); print(out[:1200]); sys.exit(1)
print("Migracje 0001-0010 wykonane.")

A="11111111-1111-1111-1111-111111111111"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl');")
# powtorki roznice wielkoscia liter i spacja
sql("""insert into sprzet (nazwa, rodzaj) values ('deska do krojenia','narzedzia'), ('Deska  do krojenia ','inne');""")
sql(f"""insert into przepisy (nazwa,autor_id,widocznosc,sprzet)
 values ('Zupa','{A}','publiczna','{{"Deska do krojenia","Garnek 3 l"}}'),
        ('Salatka','{A}','publiczna','{{"deska do krojenia"}}');""")
przed = w("select count(*) from sprzet where lower(nazwa) like 'deska%'")
print("desek przed migracja:", przed)

out, blad = sql((K/"0011_sprzet_bez_powtorek.sql").read_text(encoding="utf-8"))
if blad: print("0011 NIE PRZESZLA:"); print(out[:2000]); sys.exit(1)
print("Migracja 0011 wykonana.\n")

ok, zle = [], []
def spr(n,a,b): (ok if str(a)==str(b) else zle).append(f"{n} = {a}" if str(a)==str(b) else f"{n}: {a} zamiast {b}")

spr("powtorki scalone do jednej pozycji", w("select count(*) from sprzet where lower(nazwa) like 'deska%'"), 1)
spr("nazwa przycieta i bez podwojnych spacji",
    w("select nazwa from sprzet where lower(nazwa) like 'deska%'"), "Deska do krojenia")
spr("przepisy wskazuja te sama nazwe",
    w("select count(distinct x) from przepisy, unnest(sprzet) as x where lower(x) like 'deska%'"), 1)
_, blad2 = sql("insert into sprzet (nazwa) values ('DESKA DO KROJENIA');")
spr("powtorka innej wielkosci liter odrzucona", w("select count(*) from sprzet where lower(nazwa) like 'deska%'"), 1)
spr("widok liczy uzycie", w("select w_przepisach from sprzet_uzycie where lower(nazwa) like 'deska%'"), 2)
spr("widok wskazuje przepisy",
    w("select array_to_string(przepisy, ', ') from sprzet_uzycie where lower(nazwa) like 'deska%'"), "Salatka, Zupa")
spr("nieuzywany sprzet ma zero",
    w("select w_przepisach from sprzet_uzycie where nazwa='Chochla'"), 0)

print("=== PRZESZLO ===")
for x in ok: print("  +", x)
if zle:
    print("\n=== NIE PRZESZLO ==="); [print("  -",x) for x in zle]; sys.exit(1)
print(f"\nWszystkie {len(ok)} kontroli zakonczone powodzeniem.")
