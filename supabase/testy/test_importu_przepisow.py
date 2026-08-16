#!/usr/bin/env python3
"""
Test importu przepisów ze starego planera.

    pip install pgserver
    python3 testy/test_importu_przepisow.py

Buduje pełną bazę od zera, wgrywa składniki z prawdziwymi wartościami USDA,
uruchamia wygenerowany import i porównuje wyliczone makro z tym, co podawał
planer.

Po co ten test
--------------
Import jest generowany, więc pojedyncza pomyłka w przelicznikach rozejdzie się
po wszystkich trzydziestu daniach naraz. Sprawdzamy tu rzeczy, których człowiek
patrzący na SQL nie zauważy: czy sztuki przeliczyły się na gramy, czy waga
porcji ma sens i o ile wyliczone kalorie różnią się od tych z planera.
"""
import pgserver, pathlib, re, shutil, subprocess, sys

KORZEN = pathlib.Path(__file__).resolve().parent.parent
K = KORZEN / "migrations"
N = KORZEN / "narzedzia"
B = pathlib.Path("/tmp/talerz_import")
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


def liczba(q):
    x = w(q)
    try:
        return float(x)
    except (TypeError, ValueError):
        return None


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
  id uuid primary key default gen_random_uuid(),
  email text,
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
        print(out[:1500])
        sys.exit(1)
print(f"Migracje wykonane ({len(list(K.glob('*.sql')))} plików).")

sql("insert into auth.users (id, email) values ('11111111-1111-1111-1111-111111111111','a@t.pl');")

# --- składniki ---------------------------------------------------------------
# Wartości skopiowane z prawdziwej bazy Romana (zrzut z 15.08.2026), a nie
# z tabel USDA. Dzięki temu test przewiduje dokładnie to, co Roman zobaczy
# u siebie — łącznie z tym, co wpisał ręcznie.
#
#              nazwa                             kcal  białko tłuszcz węgle błonnik  szt.
SKLADNIKI = [
    ("Awokado", 160, 2, 12.44, 10, 1, 140),
    ("Bazylia świeża", 23, 3.15, 0.64, 2.65, 1.6, None),
    ("Boczniaki, surowe", 33, 3.3, 0.00, 10, 1, None),
    ("Brokuł, surowy", 34, 2.82, 0.37, 6.64, 2.6, 400),
    ("Bulion warzywny gotowy", 5, 0.4, 0.00, 10, 1, None),
    ("Buraki, surowe", 43, 1.61, 0.17, 9.56, 2.8, None),
    ("Bułka tarta", 395, 13.4, 33.49, 10, 1, None),
    ("Cebula czerwona, surowa", 40, 1.1, 0.00, 10, 1, 110),
    ("Cebula, surowa", 40, 1.1, 0.10, 9.34, 1.7, 110),
    ("Chleb żytni razowy", 259, 8.5, 3.30, 48.3, 5.8, 35),
    ("Chrzan tarty", 48, 1.2, 0.36, 10, 1, None),
    ("Cynamon mielony", 247, 4, 21.22, 10, 1, None),
    ("Cytryna", 29, 1.1, 0.30, 9.32, 2.8, 60),
    ("Czosnek, surowy", 149, 6.36, 0.50, 33.1, 2.1, 5),
    ("Dorsz atlantycki, surowy", 82, 17.8, 0.67, 0, 0, None),
    ("Fasola biała z puszki, odsączona", 114, 7.4, 4.93, 10, 1, 240),
    ("Fasola czerwona z puszki, odsączona", 124, 8.7, 5.47, 10, 1, 240),
    ("Fasolka szparagowa mrożona", 33, 1.79, 0.21, 7.54, 2.6, None),
    ("Filet z indyka, surowy", 114, 23.7, 0.00, 10, 1, None),
    ("Groszek zielony mrożony", 77, 5.2, 1.80, 10, 1, None),
    ("Halloumi", 321, 22, 25.00, 2, 0, None),
    ("Imbir korzeń, surowy", 80, 1.82, 0.75, 17.8, 2, None),
    ("Jaja kurze, całe, surowe", 143, 12.6, 9.51, 0.72, 0, 55),
    ("Jogurt grecki naturalny 2%", 73, 9.95, 1.92, 3.94, 0, 20),
    ("Kapusta biała, surowa", 25, 1.3, 0.00, 10, 1, None),
    ("Kapusta kiszona", 19, 0.9, 0.00, 10, 1, None),
    ("Kasza gryczana, sucha", 343, 13.2, 3.40, 71.5, 10, 100),
    ("Kasza jęczmienna, sucha", 352, 9.9, 30.27, 10, 1, None),
    ("Kmin rzymski mielony", 375, 17.8, 29.31, 10, 1, None),
    ("Majeranek suszony", 271, 12.7, 20.02, 10, 1, None),
    ("Marchew, surowa", 41, 0.93, 0.24, 9.58, 2.8, 70),
    ("Masło orzechowe bez cukru", 598, 22.2, 52.13, 10, 1, None),
    ("Mięso mielone wołowo-wieprzowe, surowe", 215, 17, 11.89, 10, 1, None),
    ("Mleko 2%", 50, 3.3, 1.98, 4.8, 0, None),
    ("Mleko kokosowe light z puszki", 99, 1, 10.70, 1.4, 0, None),
    ("Nasiona chia", 486, 16.5, 42.22, 10, 1, None),
    ("Ogórek, surowy", 15, 0.65, 0.11, 3.63, 0.5, 200),
    ("Olej rzepakowy", 884, 0, 100.00, 0, 0, 12),
    ("Oliwa z oliwek", 884, 0, 100.00, 0, 0, 12),
    ("Oliwki czarne", 115, 0.8, 7.98, 10, 1, None),
    ("Oregano suszone", 265, 9, 4.28, 68.9, 42.5, None),
    ("Orzechy włoskie", 654, 15.2, 65.20, 13.7, 6.7, None),
    ("Otręby owsiane", 246, 17.3, 15.20, 10, 1, None),
    ("Papryka czerwona, surowa", 31.3, 0.9, 0.13, 6.65, 1.16, 150),
    ("Papryka ostra mielona", 318, 12, 25.56, 10, 1, None),
    ("Papryka słodka mielona", 282, 14.1, 12.90, 54, 34.9, None),
    ("Passata pomidorowa", 38, 1.65, 0.21, 8.98, 1.9, None),
    ("Pasta curry czerwona", 110, 3, 5.00, 12, 3, 15),
    ("Pasta tom kha", 120, 3, 6.00, 13, 2, 15),
    ("Pieczarki, surowe", 22, 3.1, 0.00, 10, 1, None),
    ("Pieprz biały mielony", 296, 10.4, 23.82, 10, 1, None),
    ("Pierś z kurczaka, surowa", 120, 22.5, 2.62, 0, 0, None),
    ("Pietruszka korzeń", 49, 2.6, 0.50, 10.5, 0, 50),
    ("Pietruszka natka", 36, 2.97, 0.79, 6.33, 3.3, None),
    ("Polędwiczka wieprzowa, surowa", 109, 21, 0.00, 10, 1, None),
    ("Pręga wołowa bez kości, surowa", 137, 21.40, 4.90, 0, 0, None),
    ("Pomidory suszone w oleju", 213, 4.8, 17.09, 10, 1, None),
    ("Pomidory, surowe", 18, 0.88, 0.20, 3.89, 1.2, 130),
    ("Por, surowy", 61, 1.5, 0.30, 14.2, 1.8, 90),
    ("Płatki owsiane", 379, 13.2, 6.52, 67.7, 10.1, None),
    ("Rukola", 25, 2.6, 0.00, 10, 1, None),
    ("Ryż basmati, suchy", 365, 7.13, 0.66, 80, 1.3, None),
    ("Rzodkiewka, surowa", 16, 0.68, 0.10, 3.4, 1.6, 10),
    ("Schab wieprzowy, surowy", 143, 21, 2.11, 10, 1, None),
    ("Seler korzeń", 42, 1.5, 0.30, 9.2, 0, None),
    ("Ser feta", 265, 14.2, 21.50, 3.88, 0, None),
    ("Ser mozzarella", 304, 23.6, 19.70, 8.06, 0, None),
    ("Sezam", 573, 17.7, 49.70, 23.4, 11.8, 9),
    ("Siemię lniane", 534, 18.3, 42.20, 28.9, 27.3, 10),
    ("Sos rybny", 35, 5, 0.00, 10, 1, 18),
    ("Sos sojowy", 53, 8.14, 0.57, 4.93, 0.8, 16),
    ("Szczypiorek świeży", 30, 3.27, 0.73, 4.35, 2.5, None),
    ("Szpinak mrożony", 29, 3.6, 0.00, 10, 1, None),
    ("Szynka wieprzowa chuda, surowa", 136, 21, 1.33, 10, 1, None),
    ("Tuńczyk w wodzie, odsączony", 116, 25.5, 0.82, 0, 0, 140),
    ("Twaróg półtłusty", 133, 18.7, 4.70, 3.5, 0, None),
    ("Tymianek suszony", 276, 9.1, 22.18, 10, 1, None),
    ("Udo z kurczaka bez skóry, surowe", 121, 19.7, 4.12, 0, 0, 110),
    ("Wołowina na plastry (udziec), surowa", 133, 22, 0.56, 10, 1, None),
    ("Ziemniaki, surowe", 77, 2.05, 0.09, 17.5, 2.1, 120),
    ("koperek świeży", 43, 3.5, 1.10, 7, 2.1, None),
    ("liść laurowy", 313, 7.6, 8.40, 75, 26.3, 0.2),
    ("ogórki kiszone bio", 11, 0.5, 0.10, 1.2, 0, 60),
    ("woda", 0, 0, 0.00, 0, 0, None),
    ("ziele angielskie", 263, 6.1, 8.70, 72, 21.6, 0.1),
    ("Gulasz wieprzowy, surowy", 151, 19.60, 7.40, 0, 0, None),
]
# Twaróg wpisany po poprawce z narzedzia/skladniki-recznie.sql. Import z USDA
# podstawił serek wiejski (84 kcal, 11 g białka) zamiast twarogu (133 / 18,7).
sql(
    "insert into skladniki (nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g, blonnik_100g, nova, masa_sztuki_g) values "
    + ",".join(
        f"('{n}','usda',{k},{b},{t_},{wg},{bl},1,{'null' if ms is None else ms})"
        for n, k, b, t_, wg, bl, ms in SKLADNIKI
    )
    + ";"
)
sprawdz("składniki wgrane", liczba("select count(*) from skladniki") == len(SKLADNIKI))

# migracja 0012 wpisuje przeliczniki dopiero teraz, bo składniki muszą istnieć
out, blad = sql((K / "0012_jednostki_domowe.sql").read_text(encoding="utf-8"))
sprawdz("przeliczniki jednostek wpisane", not blad, out[:400] if blad else "")

# To jest obawa Romana wprost: czy import nie zepsuje tego, co już ustawił.
# Marchewkę ustawił na 70 g, czosnek na 5 g, paprykę na 150 g. Migracja
# proponuje odpowiednio 75, 4 i 120 — i ma tego NIE ruszyć.
for nazwa, jego in [("Marchew, surowa", 70), ("Czosnek, surowy", 5), ("Papryka czerwona, surowa", 150)]:
    sprawdz(f"migracja nie nadpisała Twojej wartości: {nazwa} = {jego} g",
            liczba(f"select masa_sztuki_g from skladniki where nazwa='{nazwa}'") == jego)
sprawdz("puste pola zostały uzupełnione: kromka chleba 35 g",
        liczba("select masa_sztuki_g from skladniki where nazwa='Chleb żytni razowy'") == 35)

# --- generowanie i wgranie importu -------------------------------------------
wynik = subprocess.run(
    ["node", "narzedzia/generuj-import.mjs"],
    cwd=KORZEN.parent, capture_output=True, text=True,
)
sprawdz("generator kończy się bez błędu", wynik.returncode == 0, wynik.stderr[:600])
if wynik.returncode != 0:
    sys.exit(1)

plik = KORZEN / "narzedzia" / "import-przepisow.sql"
out, blad = sql(plik.read_text(encoding="utf-8"))
sprawdz("import wykonuje się", not blad, out[:900] if blad else "")
if blad:
    sys.exit(1)

LICZBA_DAN = 31
sprawdz(f"wgrało się {LICZBA_DAN} przepisów", liczba("select count(*) from przepisy") == LICZBA_DAN)

# --- przepis użyty w planie da się odświeżyć ---------------------------------
# To był prawdziwy błąd u Romana: „Twaróg z warzywami” siedział w jego planie,
# a import próbował go SKASOWAĆ przed wstawieniem od nowa. Klucz obcy z tabeli
# `partie` ma `on delete restrict`, więc baza odmówiła i cofnęła cały import.
#
# Po poprawce przepis jest aktualizowany w miejscu — identyfikator zostaje,
# więc plan, polubienia i zdjęcie trzymają się przepisu.
sql("insert into konta (id) values ('11111111-1111-1111-1111-111111111111') on conflict (id) do nothing;")
id_twarogu = w("select id from przepisy where nazwa='Twaróg z warzywami'")
sql(f"""insert into partie (konto_id, przepis_id, porcji_razem, porcji_zostalo, wazne_do)
        values ('11111111-1111-1111-1111-111111111111',
                '{id_twarogu}', 1, 1, current_date + 1);""")
sprawdz("danie trafiło do planu (partia założona)",
        liczba("select count(*) from partie") == 1)

out, blad = sql(plik.read_text(encoding="utf-8"))
sprawdz("import przechodzi mimo dania użytego w planie", not blad, out[:600] if blad else "")
sprawdz("partia przetrwała odświeżenie", liczba("select count(*) from partie") == 1)
sprawdz("przepis zachował swój identyfikator",
        w("select id from przepisy where nazwa='Twaróg z warzywami'") == id_twarogu)

# --- dwukrotne uruchomienie nie tworzy duplikatów ----------------------------
sprawdz("powtórne uruchomienie nie dubluje przepisów",
        liczba("select count(*) from przepisy") == LICZBA_DAN)
sprawdz("powtórne uruchomienie nie zostawia osieroconych składników",
        liczba("""select count(*) from przepis_skladniki ps
                  where not exists (select 1 from przepisy p where p.id = ps.przepis_id)""") == 0)

# --- sztuki przeliczone na gramy ---------------------------------------------
sprawdz("barszcz jest na prędze wołowej",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Barszcz ukraiński z fasolą'
                    and s.nazwa='Pręga wołowa bez kości, surowa'""") == 400)
# Podmiana jest punktowa: gulasz używa w planerze tej samej nazwy „Mięso
# gulaszowe”, a ma zostać na łopatce wieprzowej.
sprawdz("gulasz jest na gulaszu wieprzowym z tacki",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Gulasz z kaszą gryczaną'
                    and s.nazwa='Gulasz wieprzowy, surowy'""") == 700)
sprawdz("w barszczu nie ma już wieprzowiny",
        liczba("""select count(*) from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Barszcz ukraiński z fasolą'
                    and s.nazwa like '%wieprzow%'""") == 0)

sprawdz("2 marchewki w zupie to 140 g",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Zupa pomidorowa z ryżem' and s.nazwa='Marchew, surowa'""") == 140)
sprawdz("2 ząbki czosnku w tajskim to 10 g",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Kurczak po tajsku' and s.nazwa='Czosnek, surowy'""") == 10)
sprawdz("3 kromki chleba w twarogu to 105 g",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Twaróg z warzywami' and s.nazwa='Chleb żytni razowy'""") == 105)
sprawdz("2 łyżki jogurtu w twarogu to 40 g",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Twaróg z warzywami' and s.nazwa='Jogurt grecki naturalny 2%'""") == 40)
sprawdz("żaden składnik nie ma zerowych gramów",
        liczba("select count(*) from przepis_skladniki where gramy is null or gramy <= 0") == 0)

# --- „do smaku” trafiło na listę ---------------------------------------------
sprawdz("natka „do smaku” ma wpisaną gramaturę",
        liczba("""select ps.gramy from przepis_skladniki ps
                  join skladniki s on s.id = ps.skladnik_id
                  join przepisy p on p.id = ps.przepis_id
                  where p.nazwa='Zupa pomidorowa z ryżem' and s.nazwa='Pietruszka natka'""") == 30)

# --- kroki i etapy -----------------------------------------------------------
sprawdz("każdy przepis ma etap",
        liczba("""select count(*) from przepisy p
                  where not exists (select 1 from etapy e where e.przepis_id = p.id)""") == 0)
sprawdz("każdy przepis ma kroki",
        liczba("""select count(*) from przepisy p
                  where not exists (select 1 from etapy e join kroki k on k.etap_id = e.id
                                     where e.przepis_id = p.id)""") == 0)
sprawdz("każdy przepis ma składniki",
        liczba("""select count(*) from przepisy p
                  where not exists (select 1 from przepis_skladniki ps where ps.przepis_id = p.id)""") == 0)
sprawdz("każdy przepis ma policzone makro",
        liczba("select count(*) from przepis_makro where kcal is null or kcal <= 0") == 0)

# Import to zwykłe instrukcje SQL, więc brakujący składnik nie przerywa go
# błędem — po prostu wstawia zero wierszy. Liczymy, czy każde danie ma tyle
# składników i kroków, ile ma mieć.
import json as _json
_map = _json.loads((KORZEN.parent / "narzedzia" / "mapowanie-planera.json").read_text(encoding="utf-8"))
_dania = {d["nazwa"]: d for d in _json.loads(
    (KORZEN.parent / "narzedzia" / "planer-html-dania.json").read_text(encoding="utf-8"))["dania"]}
niekompletne = []
for nazwa, ust in _map["dania"].items():
    n = nazwa.replace("'", "''")
    ile_sk = liczba(f"""select count(*) from przepis_skladniki ps join przepisy p on p.id=ps.przepis_id
                        where p.nazwa='{n}'""")
    ile_kr = liczba(f"""select count(*) from kroki k join etapy e on e.id=k.etap_id
                        join przepisy p on p.id=e.przepis_id where p.nazwa='{n}'""")
    ma_kr = len(_dania[nazwa]["kroki"])
    ma_sk = len(_dania[nazwa]["skladniki"]) + len(ust.get("dolej") or [])
    if ile_sk != ma_sk or ile_kr != ma_kr:
        niekompletne.append(f"{nazwa}: składników {ile_sk}/{ma_sk}, kroków {ile_kr}/{ma_kr}")
sprawdz("nic nie wpadło po cichu — każde danie ma komplet składników i kroków",
        not niekompletne, "\n       " + "\n       ".join(niekompletne))

# --- waga porcji ma sens ------------------------------------------------------
import json
mapowanie = json.loads((KORZEN.parent / "narzedzia" / "mapowanie-planera.json").read_text(encoding="utf-8"))
zle_porcje = []
for nazwa in mapowanie["dania"]:
    n = nazwa.replace("'", "''")
    wyszlo = liczba(f"""select round(sum(ps.gramy) / p.porcja_g, 2)
                        from przepisy p join przepis_skladniki ps on ps.przepis_id = p.id
                        where p.nazwa = '{n}' group by p.porcja_g""")
    porcja = liczba(f"select porcja_g from przepisy where nazwa = '{n}'")
    if wyszlo is None:
        zle_porcje.append(f"{nazwa}: nie ma go w bazie")
    elif abs(wyszlo - round(wyszlo)) > 0.06:
        # Garnek musi dzielić się na całe porcje. Ułamek znaczy, że waga porcji
        # nie pasuje do zawartości — zostanie resztka, której nikt nie zje.
        zle_porcje.append(f"{nazwa}: wychodzi {wyszlo} porcji, a ma wyjść okrągła liczba")
    elif not (250 <= porcja <= 1400):
        zle_porcje.append(f"{nazwa}: porcja {porcja} g wygląda nierealnie")
sprawdz("każdy garnek dzieli się na całe porcje o sensownej wadze",
        not zle_porcje, "\n       " + "\n       ".join(zle_porcje))

# --- porównanie z planerem ----------------------------------------------------
print("\n  Wyliczone ze składników kontra wartości z planera:\n")
print(f"    {'danie':32} {'kcal':>14}   {'białko':>14}")
PLANER = {
    "Zupa pomidorowa z ryżem": (645, 33),
    "Kurczak po tajsku": (805, 51),  # planer liczył na 2 porcje z garnka, my dzielimy na 3
    "Twaróg z warzywami": (640, 49),
}
roznice = {}
for nazwa, (pk, pb) in PLANER.items():
    k = liczba(f"select round(kcal) from przepis_makro m join przepisy p on p.id=m.przepis_id where p.nazwa='{nazwa}'")
    b = liczba(f"select round(bialko_g) from przepis_makro m join przepisy p on p.id=m.przepis_id where p.nazwa='{nazwa}'")
    dk = round((k - pk) / pk * 100)
    db = round((b - pb) / pb * 100)
    roznice[nazwa] = (k, b, dk, db)
    print(f"    {nazwa:32} {int(k):5} ({dk:+4}%)   {int(b):5} g ({db:+4}%)")

print()
# Wartości z planera były wpisywane ręcznie, więc różnica jest spodziewana.
# Sprawdzamy tylko, czy nie jest absurdalna — to by znaczyło, że coś się
# pomyliło w przelicznikach, a nie że planer był niedokładny.
for nazwa, (k, b, dk, db) in roznice.items():
    sprawdz(f"{nazwa}: kalorie w granicach rozsądku", abs(dk) <= 50, f"({dk:+}%)")
    sprawdz(f"{nazwa}: białko w granicach rozsądku", abs(db) <= 50, f"({db:+}%)")

print()
if bledy:
    print(f"NIEUDANE: {len(bledy)}")
    for b in bledy:
        print("  -", b)
    sys.exit(1)
print("Wszystkie sprawdzenia przeszły.")
