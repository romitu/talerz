#!/usr/bin/env python3
"""
Test migracji 0003 — pełna struktura przepisu.

    pip install pgserver
    python3 testy/test_struktury_przepisu.py

Wykonuje wszystkie trzy migracje po kolei na czystej bazie i sprawdza
na przykładzie zupy ogórkowej dla 6 osób, czy nowa struktura działa.

Najważniejsza kontrola: MAKRO NA PORCJĘ.
Wcześniej widok liczył wartości całego garnka — przepis na sześć porcji
pokazywałby 2067 kcal jako wartość posiłku i tak trafiłby do planu dnia.
"""
import pgserver, pathlib, re, shutil, sys, tempfile
K = pathlib.Path(__file__).resolve().parent.parent / "migrations"
B = pathlib.Path(tempfile.gettempdir()) / "talerz_m3"
if B.exists(): shutil.rmtree(B, ignore_errors=True)
srv = pgserver.get_server(str(B))
def sql(q):
    try: return srv.psql(q), False
    except Exception as e: return str(e), True
def w(q):
    out,_ = sql(f"select 'W<'||({q})||'>';"); m=re.search(r"W<([^>]*)>",out); return m.group(1) if m else None

sql("""create schema if not exists auth;
create table if not exists auth.users (id uuid primary key default gen_random_uuid(), email text);
create or replace function auth.uid() returns uuid language sql stable as
 $$ select nullif(current_setting('request.jwt.claim.sub', true),'')::uuid $$;""")

for nazwa in ["0001_schemat_poczatkowy.sql","0002_etapy_przepisu.sql","0003_pelna_struktura_przepisu.sql"]:
    out, blad = sql((K/nazwa).read_text(encoding="utf-8"))
    if blad:
        print(f"{nazwa} NIE PRZESZLA:"); print(out[:2500]); sys.exit(1)
    print(f"{nazwa} wykonana.")
print()

ok, zle = [], []
def spr(n, a, b):
    (ok if str(a)==str(b) else zle).append(f"{n} = {a}" if str(a)==str(b) else f"{n}: otrzymano {a}, oczekiwano {b}")

A="11111111-1111-1111-1111-111111111111"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl');")
sql("""insert into skladniki (nazwa,zrodlo,kcal_100g,bialko_100g,tluszcz_100g,wegle_100g,cukry_ogolem_100g,cukry_wolne_100g,nova)
 values ('Zeberka wieprzowe','usda',277,17,23,0,0,0,1),
        ('Ziemniaki','usda',77,2,0.1,17,0.8,0,1),
        ('Ogorki kiszone','wlasne',12,0.6,0.2,1.7,1.1,0,3),
        ('Smietana 18%','usda',184,2.8,18,3.4,3.4,0,3);""")

P="66666666-6666-6666-6666-666666666666"
sql(f"""insert into przepisy (id,nazwa,autor_id,widocznosc,trwalosc_dni,pory,porcje,
      czas_przygotowania_min,czas_obrobki_min,sprzet,przechowywanie,mozna_mrozic,ratunek)
 values ('{P}','Zupa ogorkowa','{A}','publiczna',3,'{{obiad}}',6,20,77,
      '{{"garnek 3 l","tarka o grubych oczkach","patelnia"}}',
      'W lodowce do 3 dni, w zamknietym pojemniku.', false,
      'Za kwasna - dodaj ziemniaka i pogotuj. Za slona - dolej wody i smietany.');""")

# 6 porcji, skladniki na caly garnek
sql(f"""insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc,stan,zamiennik,jednostka)
 select '{P}', id, 500, 1, 'oplukane', 'lub korpus z kurczaka', 'g' from skladniki where nazwa='Zeberka wieprzowe';
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc,stan)
 select '{P}', id, 600, 2, 'obrane, w kostce' from skladniki where nazwa='Ziemniaki';
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc,stan)
 select '{P}', id, 300, 3, 'starte na grubych oczkach' from skladniki where nazwa='Ogorki kiszone';
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc,jednostka)
 select '{P}', id, 100, 4, 'ml' from skladniki where nazwa='Smietana 18%';""")

spr("liczba porcji zapisana", w(f"select porcje from przepisy where id='{P}'"), 6)
spr("wykaz sprzetu ma 3 pozycje", w(f"select array_length(sprzet,1) from przepisy where id='{P}'"), 3)
spr("stan skladnika zapisany",
    w(f"select stan from przepis_skladniki ps join skladniki s on s.id=ps.skladnik_id where ps.przepis_id='{P}' and s.nazwa='Ziemniaki'"),
    "obrane, w kostce")
spr("zamiennik zapisany",
    w(f"select zamiennik from przepis_skladniki ps join skladniki s on s.id=ps.skladnik_id where ps.przepis_id='{P}' and s.nazwa='Zeberka wieprzowe'"),
    "lub korpus z kurczaka")
spr("jednostka ml przy smietanie",
    w(f"select jednostka from przepis_skladniki ps join skladniki s on s.id=ps.skladnik_id where ps.przepis_id='{P}' and s.nazwa='Smietana 18%'"),
    "ml")

# makro: 500*2.77 + 600*0.77 + 300*0.12 + 100*1.84 = 1385 + 462 + 36 + 184 = 2067 kcal na caly garnek
spr("makro calego garnka", w(f"select kcal_calosc from przepis_makro where przepis_id='{P}'"), 2067)
spr("makro jednej porcji (2067/6)", w(f"select kcal from przepis_makro where przepis_id='{P}'"), 345)
spr("waga porcji (1500 g / 6)", w(f"select gramy_porcji from przepis_makro where przepis_id='{P}'"), 250)
# bialko: 500*0.17 + 600*0.02 + 300*0.006 + 100*0.028 = 85 + 12 + 1.8 + 2.8 = 101.6 -> /6 = 16.9
spr("bialko na porcje", w(f"select bialko_g from przepis_makro where przepis_id='{P}'"), "16.9")
spr("bialko calosci", w(f"select bialko_g_calosc from przepis_makro where przepis_id='{P}'"), "101.6")

# sygnal wizualny przy kroku
sql(f"insert into etapy (id,przepis_id,kolejnosc,nazwa,minuty) values ('77777777-7777-7777-7777-777777777777','{P}',2,'Dodanie warzyw',15);")
sql("""insert into kroki (etap_id,kolejnosc,tresc,sygnal,uwaga) values
 ('77777777-7777-7777-7777-777777777777',1,'Dodaj ziemniaki i gotuj','az ziemniaki beda miekkie',false),
 ('77777777-7777-7777-7777-777777777777',2,'Nie dodawaj ogorkow przed ugotowaniem ziemniakow',null,true);""")
spr("sygnal wizualny zapisany",
    w("select sygnal from kroki where kolejnosc=1 and etap_id='77777777-7777-7777-7777-777777777777'"),
    "az ziemniaki beda miekkie")
spr("ostrzezenie oznaczone",
    w("select count(*) from kroki where uwaga and etap_id='77777777-7777-7777-7777-777777777777'"), 1)

spr("mrozenie: informacja zapisana", w(f"select mozna_mrozic from przepisy where id='{P}'"), "false")
spr("stara kolumna czas_minut usunieta",
    w("select count(*) from information_schema.columns where table_name='przepisy' and column_name='czas_minut'"), 0)

# ograniczenia
_, blad = sql(f"update przepisy set porcje=0 where id='{P}';")
spr("zero porcji odrzucone", w(f"select porcje from przepisy where id='{P}'"), 6)

print("=== PRZESZLO ===")
for x in ok: print("  +", x)
if zle:
    print("\n=== NIE PRZESZLO ==="); [print("  -", x) for x in zle]; sys.exit(1)
print(f"\nWszystkie {len(ok)} kontroli zakonczone powodzeniem.")
