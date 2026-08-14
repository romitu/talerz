#!/usr/bin/env python3
"""
Test migracji 0002 — wprowadzenie etapów przepisu.

    pip install pgserver
    python3 testy/test_migracji.py

Sprawdza dwie rzeczy naraz:
  * czy migracja w ogóle przechodzi na czystej bazie,
  * czy NIE GUBI danych zapisanych wcześniej — kroki istniejących przepisów
    muszą trafić do nowych etapów co do jednego.

Ta druga część jest ważniejsza. Migracja, która się wykona, ale po cichu
usunie czyjeś przepisy, jest gorsza od takiej, która się nie wykona.
"""
import pgserver, pathlib, re, shutil, sys, tempfile
K = pathlib.Path(__file__).resolve().parent.parent / "migrations"
BAZA = pathlib.Path(tempfile.gettempdir()) / "talerz_mig"
if BAZA.exists(): shutil.rmtree(BAZA, ignore_errors=True)
srv = pgserver.get_server(str(BAZA))

def sql(q):
    try: return srv.psql(q), False
    except Exception as e: return str(e), True

def w(q):
    out, _ = sql(f"select 'W<'||({q})||'>';")
    m = re.search(r"W<([^>]*)>", out); return m.group(1) if m else None

sql("""create schema if not exists auth;
create table if not exists auth.users (id uuid primary key default gen_random_uuid(), email text);
create or replace function auth.uid() returns uuid language sql stable as
 $$ select nullif(current_setting('request.jwt.claim.sub', true),'')::uuid $$;""")

out, blad = sql((K/"0001_schemat_poczatkowy.sql").read_text(encoding="utf-8"))
if blad: print("0001 NIE PRZESZLA:"); print(out[:1500]); sys.exit(1)
print("Migracja 0001 wykonana.")

# dane sprzed migracji — sprawdzamy, czy nic nie ginie
A = "11111111-1111-1111-1111-111111111111"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl');")
sql(f"""insert into przepisy (id,nazwa,autor_id,widocznosc)
 values ('33333333-3333-3333-3333-333333333333','Stary przepis','{A}','publiczna');
insert into kroki (przepis_id,etap,kolejnosc,tresc) values
 ('33333333-3333-3333-3333-333333333333','przygotowanie',1,'Obierz warzywa'),
 ('33333333-3333-3333-3333-333333333333','przygotowanie',2,'Zetrzyj ogorki'),
 ('33333333-3333-3333-3333-333333333333','wykonanie',1,'Gotuj 45 minut');""")
przed = w("select count(*) from kroki")
print(f"Kroki przed migracja: {przed}")

out, blad = sql((K/"0002_etapy_przepisu.sql").read_text(encoding="utf-8"))
if blad: print("0002 NIE PRZESZLA:"); print(out[:2500]); sys.exit(1)
print("Migracja 0002 wykonana.\n")

ok, zle = [], []
def spr(n, otrzymano, oczekiwano):
    (ok if str(otrzymano)==str(oczekiwano) else zle).append(
        f"{n} = {otrzymano}" if str(otrzymano)==str(oczekiwano) else f"{n}: otrzymano {otrzymano}, oczekiwano {oczekiwano}")

spr("zadne kroki nie zginely przy migracji", w("select count(*) from kroki"), przed)
spr("powstaly dwa etapy z dawnego podzialu", w("select count(*) from etapy"), 2)
spr("kazdy krok ma przypisany etap", w("select count(*) from kroki where etap_id is null"), 0)
spr("etap przygotowania ma 2 kroki",
    w("select count(*) from kroki k join etapy e on e.id=k.etap_id where e.nazwa='Przygotowanie'"), 2)
spr("etap wykonania ma 1 krok",
    w("select count(*) from kroki k join etapy e on e.id=k.etap_id where e.nazwa='Wykonanie'"), 1)

# nowa struktura: etapy z czasem
P = "44444444-4444-4444-4444-444444444444"
sql(f"""insert into przepisy (id,nazwa,autor_id,widocznosc,trwalosc_dni,pory)
 values ('{P}','Zupa ogorkowa','{A}','publiczna',3,'{{obiad}}');
insert into etapy (przepis_id,kolejnosc,nazwa,minuty) values
 ('{P}',1,'Gotowanie wywaru',45),
 ('{P}',2,'Dodanie warzyw i ziemniakow',15),
 ('{P}',3,'Podsmazanie ogorkow',10),
 ('{P}',4,'Laczenie skladnikow',5),
 ('{P}',5,'Zabielanie',2);""")
spr("piec etapow zupy zapisanych", w(f"select count(*) from etapy where przepis_id='{P}'"), 5)
spr("widok liczy czas calego przepisu (45+15+10+5+2)",
    w(f"select minuty_razem from przepis_czas where przepis_id='{P}'"), 77)

# kroki z uwaga
E2 = w(f"select id from etapy where przepis_id='{P}' and kolejnosc=2")
sql(f"""insert into kroki (etap_id,kolejnosc,tresc,uwaga) values
 ('{E2}',1,'Dodaj starta marchewke i ziemniaki',false),
 ('{E2}',2,'Ziemniaki musza byc miekkie przed dodaniem ogorkow',true);""")
spr("krok oznaczony jako uwaga", w(f"select count(*) from kroki where etap_id='{E2}' and uwaga"), 1)

# czasy sprzetu na etapie
E1 = w(f"select id from etapy where przepis_id='{P}' and kolejnosc=1")
sql(f"""insert into czasy_sprzet (etap_id,sprzet,minuty) values
 ('{E1}','plyta',45), ('{E1}','garnek_cisnieniowy',15);""")
spr("dwa warianty czasu dla etapu", w(f"select count(*) from czasy_sprzet where etap_id='{E1}'"), 2)

# stare kolumny nie moga zostac
spr("kolumna kroki.przepis_id usunieta",
    w("select count(*) from information_schema.columns where table_name='kroki' and column_name='przepis_id'"), 0)
spr("kolumna kroki.etap usunieta",
    w("select count(*) from information_schema.columns where table_name='kroki' and column_name='etap'"), 0)

# reguly dostepu nadal dzialaja
sql("""create role authenticated nologin; grant usage on schema public to authenticated;
grant all on all tables in schema public to authenticated;""")
B = "22222222-2222-2222-2222-222222222222"
sql(f"insert into auth.users (id,email) values ('{B}','b@t.pl');")
sql(f"insert into przepisy (id,nazwa,autor_id,widocznosc) values ('55555555-5555-5555-5555-555555555555','Sekretny','{A}','prywatna');")
S = "55555555-5555-5555-5555-555555555555"
sql(f"insert into etapy (przepis_id,kolejnosc,nazwa,minuty) values ('{S}',1,'Tajny etap',10);")

def jako(uid, q):
    out,_ = sql(f"begin; set local role authenticated; set local request.jwt.claim.sub='{uid}'; select 'W<'||({q})||'>'; commit;")
    m = re.search(r"W<([^>]*)>", out); return m.group(1) if m else None

spr("RLS: obcy nie widzi etapow przepisu prywatnego",
    jako(B, f"select count(*) from etapy where przepis_id='{S}'"), 0)
spr("RLS: autor widzi wlasne etapy",
    jako(A, f"select count(*) from etapy where przepis_id='{S}'"), 1)
spr("RLS: etapy przepisu publicznego widoczne dla wszystkich",
    jako(B, f"select count(*) from etapy where przepis_id='{P}'"), 5)
spr("RLS: kroki przepisu publicznego widoczne dla wszystkich",
    jako(B, f"select count(*) from kroki k join etapy e on e.id=k.etap_id where e.przepis_id='{P}'"), 2)

print("=== PRZESZLO ===")
for x in ok: print("  +", x)
if zle:
    print("\n=== NIE PRZESZLO ==="); [print("  -", x) for x in zle]; sys.exit(1)
print(f"\nWszystkie {len(ok)} kontroli zakonczone powodzeniem.")
