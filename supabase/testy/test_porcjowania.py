#!/usr/bin/env python3
"""
Test migracji 0007 — sposób porcjowania.

    pip install pgserver
    python3 testy/test_porcjowania.py

Sprawdza na zupie ogórkowej i kotletach, że porcja liczy się poprawnie
niezależnie od sposobu porcjowania, oraz że nie da się zapisać przepisu
z obiema wartościami naraz.

Sens tej zmiany: „4 do 6 porcji” dawało od 342 do 514 kcal na posiłek.
Po podaniu wagi chochli niepewność znika.
"""
import pgserver, pathlib, re, shutil, sys
K = pathlib.Path(__file__).resolve().parent.parent / "migrations"
B = pathlib.Path("/tmp/talerz_p7")
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
for n in sorted(p.name for p in K.glob("*.sql")):
    out, blad = sql((K/n).read_text(encoding="utf-8"))
    print(("BLAD " if blad else "OK   ") + n)
    if blad: print(out[:2000]); sys.exit(1)
ok, zle = [], []
def spr(n,a,b): (ok if str(a)==str(b) else zle).append(f"{n} = {a}" if str(a)==str(b) else f"{n}: {a} zamiast {b}")
A="11111111-1111-1111-1111-111111111111"
sql(f"insert into auth.users (id,email) values ('{A}','a@t.pl');")
# skladniki tak dobrane, zeby garnek mial 1500 g i 2054 kcal
sql("""insert into skladniki (nazwa,zrodlo,kcal_100g,bialko_100g,tluszcz_100g,wegle_100g,blonnik_100g,cukry_ogolem_100g,cukry_wolne_100g,nova)
 values ('Zeberka','usda',277,17,23,0,0,0,0,1),
        ('Ziemniaki','usda',77,2,0.1,17,2.2,0.8,0,1),
        ('Ogorki kiszone','wlasne',12,0.6,0.2,1.7,1.2,1.1,0,3),
        ('Smietana','usda',184,2.8,18,3.4,0,3.4,0,3);""")
Z="99999999-9999-9999-9999-999999999999"
sql(f"""insert into przepisy (id,nazwa,autor_id,widocznosc,porcjowanie,porcja_g)
 values ('{Z}','Zupa ogorkowa','{A}','publiczna','waga',350);
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc) select '{Z}',id,500,1 from skladniki where nazwa='Zeberka';
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc) select '{Z}',id,600,2 from skladniki where nazwa='Ziemniaki';
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc) select '{Z}',id,300,3 from skladniki where nazwa='Ogorki kiszone';
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc) select '{Z}',id,100,4 from skladniki where nazwa='Smietana';""")
# 500*2.77 + 600*0.77 + 300*0.12 + 100*1.84 = 1385 + 462 + 36 + 184 = 2067
spr("masa garnka", w(f"select gramy_calosc from przepis_makro where przepis_id='{Z}'"), 1500)
spr("kalorie garnka", w(f"select kcal_calosc from przepis_makro where przepis_id='{Z}'"), 2067)
spr("porcja wazona 350 g", w(f"select gramy_porcji from przepis_makro where przepis_id='{Z}'"), 350)
spr("liczba porcji wyliczona (1500/350)", w(f"select porcje_wyliczone from przepis_makro where przepis_id='{Z}'"), "4.3")
spr("kalorie porcji (2067/4,2857)", w(f"select kcal from przepis_makro where przepis_id='{Z}'"), 482)
# zmiana wielkosci chochli zmienia wynik
sql(f"update przepisy set porcja_g=250 where id='{Z}';")
spr("po zmniejszeniu porcji do 250 g: 6 porcji", w(f"select porcje_wyliczone from przepis_makro where przepis_id='{Z}'"), "6.0")
spr("po zmniejszeniu porcji: 345 kcal", w(f"select kcal from przepis_makro where przepis_id='{Z}'"), 345)
# danie w sztukach
S="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa"
sql(f"""insert into przepisy (id,nazwa,autor_id,widocznosc,porcjowanie,porcje)
 values ('{S}','Kotlety','{A}','publiczna','sztuki',4);
insert into przepis_skladniki (przepis_id,skladnik_id,gramy,kolejnosc) select '{S}',id,800,1 from skladniki where nazwa='Zeberka';""")
spr("kotlety: 4 porcje", w(f"select porcje_wyliczone from przepis_makro where przepis_id='{S}'"), "4.0")
spr("kotlety: waga porcji z podzialu (800/4)", w(f"select gramy_porcji from przepis_makro where przepis_id='{S}'"), 200)
spr("kotlety: kalorie porcji (2216/4)", w(f"select kcal from przepis_makro where przepis_id='{S}'"), 554)
# ograniczenie spojnosci
_,b1 = sql(f"update przepisy set porcjowanie='waga', porcja_g=null where id='{S}';")
spr("waga bez podanej gramatury odrzucona", w(f"select porcjowanie from przepisy where id='{S}'"), "sztuki")
_,b2 = sql(f"update przepisy set porcjowanie='sztuki', porcja_g=300 where id='{Z}';")
spr("sztuki z gramatura porcji odrzucone", w(f"select porcjowanie from przepisy where id='{Z}'"), "waga")
print("\n=== PRZESZLO ===")
for x in ok: print("  +", x)
if zle:
    print("\n=== NIE PRZESZLO ==="); [print("  -",x) for x in zle]; sys.exit(1)
print(f"\nWszystkie {len(ok)} kontroli zakonczone powodzeniem.")
