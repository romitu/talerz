-- =============================================================================
--  TALERZ — czego brakuje do importu przepisów
-- =============================================================================
--  Po co
--  -----
--  Import przepisów przerywa się na PIERWSZYM brakującym składniku i cofa
--  całą resztę. Dlatego po nieudanej próbie w bazie nie ma ani jednego
--  nowego przepisu — nie „części”, tylko zera.
--
--  To zapytanie sprawdza wszystko naraz, żeby nie odkrywać braków po jednym
--  przy kolejnych próbach.
--
--  Jak czytać wynik
--  ----------------
--  Wszystko jest w JEDNEJ tabelce, bo panel Supabase pokazuje wynik tylko
--  ostatniego zapytania — trzy osobne `select` byłyby niewidoczne.
--
--    tylko wiersz „INFO”          -> można wgrywać import-przepisow.sql
--    „BRAK SKLADNIKA”             -> uruchom node narzedzia/import-usda.mjs
--                                    i supabase/narzedzia/skladniki-recznie.sql
--    „BRAK MASY SZTUKI”           -> uruchom migracje 0012 i 0017
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

with potrzebne(nazwa) as (values
  ('Awokado'),
  ('Bazylia świeża'),
  ('Boczniaki, surowe'),
  ('Brokuł, surowy'),
  ('Bulion warzywny gotowy'),
  ('Buraki, surowe'),
  ('Bułka tarta'),
  ('Cebula czerwona, surowa'),
  ('Cebula, surowa'),
  ('Chleb żytni razowy'),
  ('Chrzan tarty'),
  ('Cynamon mielony'),
  ('Cytryna'),
  ('Czosnek, surowy'),
  ('Dorsz atlantycki, surowy'),
  ('Fasola biała z puszki, odsączona'),
  ('Fasola czerwona z puszki, odsączona'),
  ('Fasolka szparagowa mrożona'),
  ('Filet z indyka, surowy'),
  ('Groszek zielony mrożony'),
  ('Halloumi'),
  ('Imbir korzeń, surowy'),
  ('Jaja kurze, całe, surowe'),
  ('Jogurt grecki naturalny 2%'),
  ('Kapusta biała, surowa'),
  ('Kapusta kiszona'),
  ('Kasza gryczana, sucha'),
  ('Kasza jęczmienna, sucha'),
  ('Kmin rzymski mielony'),
  ('Majeranek suszony'),
  ('Marchew, surowa'),
  ('Masło orzechowe bez cukru'),
  ('Mięso mielone wołowo-wieprzowe, surowe'),
  ('Mleko 2%'),
  ('Mleko kokosowe light z puszki'),
  ('Nasiona chia'),
  ('Ogórek, surowy'),
  ('Olej rzepakowy'),
  ('Oliwa z oliwek'),
  ('Oliwki czarne'),
  ('Oregano suszone'),
  ('Orzechy włoskie'),
  ('Otręby owsiane'),
  ('Papryka czerwona, surowa'),
  ('Papryka ostra mielona'),
  ('Papryka słodka mielona'),
  ('Passata pomidorowa'),
  ('Pasta curry czerwona'),
  ('Pasta tom kha'),
  ('Pieczarki, surowe'),
  ('Pieprz biały mielony'),
  ('Pierś z kurczaka, surowa'),
  ('Pietruszka korzeń'),
  ('Pietruszka natka'),
  ('Polędwiczka wieprzowa, surowa'),
  ('Pomidory suszone w oleju'),
  ('Pomidory, surowe'),
  ('Por, surowy'),
  ('Płatki owsiane'),
  ('Rukola'),
  ('Ryż basmati, suchy'),
  ('Rzodkiewka, surowa'),
  ('Schab wieprzowy, surowy'),
  ('Seler korzeń'),
  ('Ser feta'),
  ('Ser mozzarella'),
  ('Sezam'),
  ('Siemię lniane'),
  ('Sos rybny'),
  ('Sos sojowy'),
  ('Szczypiorek świeży'),
  ('Szpinak mrożony'),
  ('Szynka wieprzowa chuda, surowa'),
  ('Tuńczyk w wodzie, odsączony'),
  ('Twaróg półtłusty'),
  ('Tymianek suszony'),
  ('Udo z kurczaka bez skóry, surowe'),
  ('Wołowina na plastry (udziec), surowa'),
  ('Ziemniaki, surowe'),
  ('koperek świeży'),
  ('liść laurowy'),
  ('ogórki kiszone bio'),
  ('woda'),
  ('ziele angielskie'),
  ('Łopatka wieprzowa gulaszowa, surowa')
),
na_sztuki(nazwa) as (values
  ('Awokado'),
  ('Brokuł, surowy'),
  ('Cebula czerwona, surowa'),
  ('Cebula, surowa'),
  ('Chleb żytni razowy'),
  ('Cytryna'),
  ('Czosnek, surowy'),
  ('Fasola biała z puszki, odsączona'),
  ('Fasola czerwona z puszki, odsączona'),
  ('Jaja kurze, całe, surowe'),
  ('Jogurt grecki naturalny 2%'),
  ('Kasza gryczana, sucha'),
  ('Marchew, surowa'),
  ('Ogórek, surowy'),
  ('Olej rzepakowy'),
  ('Oliwa z oliwek'),
  ('Papryka czerwona, surowa'),
  ('Pasta curry czerwona'),
  ('Pietruszka korzeń'),
  ('Pomidory, surowe'),
  ('Por, surowy'),
  ('Rzodkiewka, surowa'),
  ('Sos rybny'),
  ('Sos sojowy'),
  ('Tuńczyk w wodzie, odsączony'),
  ('Udo z kurczaka bez skóry, surowe'),
  ('Ziemniaki, surowe'),
  ('ogórki kiszone bio')
)

select 'BRAK SKLADNIKA' as co_jest_nie_tak, p.nazwa as czego_dotyczy
  from potrzebne p
 where p.nazwa not in (select nazwa from skladniki)

union all

select 'BRAK MASY SZTUKI', s.nazwa
  from skladniki s
  join na_sztuki n on n.nazwa = s.nazwa
 where s.masa_sztuki_g is null

union all

select 'INFO', 'skladnikow w bazie: ' || (select count(*) from skladniki)
                || ', przepisow: '     || (select count(*) from przepisy)
                || ', do wgrania: 31'

order by 1 desc, 2;
