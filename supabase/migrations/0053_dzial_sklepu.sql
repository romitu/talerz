-- =============================================================================
--  TALERZ — dział sklepu przy składniku (lista zakupów jak regały w Lidlu)
-- =============================================================================
--  Po co
--  -----
--  Do tej pory dział na liście zakupów zgadywał kod z tagów. Tagi mówią
--  jednak, CZYM produkt jest (warzywo, strączki), a nie GDZIE leży w sklepie:
--  passata i świeże pomidory to oba „warzywo”, a fasola z puszki i sucha to
--  oba „straczki” — w sklepie stoją w zupełnie innych miejscach. Tagi zostają
--  bez zmian (liczy się z nich np. główne białko dania), a dział staje się
--  osobną kolumną, ustawianą wprost przy każdym składniku.
--
--  Kolejność działów to trasa po typowym Lidlu: pieczywo przy wejściu, obok
--  owoce i warzywa, potem lodówki z nabiałem i mięsem, środek sklepu (kasze,
--  konserwy, przyprawy, bakalie), na końcu napoje i mrożonki. Kolejność żyje
--  w kodzie (`lib/zakupy.ts`), tu jest tylko lista dozwolonych wartości.
--
--  Edytuje moderator, tak jak resztę katalogu — reguły dostępu do tabeli
--  `skladniki` obejmują nową kolumnę bez zmian.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  add column dzial text not null default 'pozostale'
    check (dzial in (
      'pieczywo', 'warzywa', 'nabial', 'mieso', 'kasze', 'konserwy',
      'przyprawy', 'bakalie', 'napoje', 'mrozonki', 'pozostale'
    ));

comment on column skladniki.dzial is
  'Dział sklepu na liście zakupów (gdzie produkt leży, nie czym jest — od tego są tagi). Kolejność działów w lib/zakupy.ts.';


-- =============================================================================
--  KROK 1 — przybliżenie z tagów
-- =============================================================================
--  Kolejność gałęzi ma znaczenie: suszone owoce mają też tag „owoc”, a masło
--  „tluszcz” — pierwsza pasująca gałąź wygrywa.

update skladniki set dzial = case
  when 'suszone' = any (tagi)                                       then 'bakalie'
  when tagi && array['nabial', 'jaja']                              then 'nabial'
  when tagi && array['mieso', 'drob', 'podroby', 'ryba', 'owoce morza'] then 'mieso'
  when tagi && array['warzywo', 'owoc', 'ziola', 'grzyby']          then 'warzywa'
  when tagi && array['zboze', 'straczki']                           then 'kasze'
  when tagi && array['orzechy', 'nasiona', 'czekolada', 'kakao', 'slodzik'] then 'bakalie'
  when tagi && array['przyprawa', 'tluszcz']                        then 'przyprawy'
  else 'pozostale'
end;


-- =============================================================================
--  KROK 2 — wyjątki: produkty, które w sklepie stoją gdzie indziej, niż
--  wynikałoby z tagów, oraz składniki bez tagów
-- =============================================================================

update skladniki set dzial = 'pieczywo'
 where nazwa in ('Chleb wieloziarnisty', 'Chleb żytni razowy', 'Tortilla pełnoziarnista');

update skladniki set dzial = 'warzywa'
 where nazwa in (
   'Limonka', 'Pietruszka korzeń', 'Seler korzeń', 'koperek świeży',
   'Imbir korzeń, surowy'
 );

update skladniki set dzial = 'nabial'
 where nazwa in ('śmietana 18% kwaśna', 'Stracciatella', 'Tofu naturalne');

-- Puszki i słoiki — passata obok fasoli z puszki.
update skladniki set dzial = 'konserwy'
 where nazwa in (
   'Passata pomidorowa', 'Pomidory krojone z puszki', 'Koncentrat pomidorowy',
   'Pomidory suszone w oleju', 'Kukurydza konserwowa, odsączona',
   'Ciecierzyca z puszki, odsączona', 'Fasola biała z puszki, odsączona',
   'Fasola czarna z puszki, odsączona', 'Fasola czerwona z puszki, odsączona',
   'ogórki kiszone bio', 'kwas ogórków kiszonych', 'Kapusta kiszona',
   'Oliwki zielone', 'Oliwki czarne',
   'Mleko kokosowe z puszki', 'Mleko kokosowe light z puszki',
   'Sardynki w oliwie, odsączone', 'Tuńczyk w wodzie, odsączony',
   'Pasta curry czerwona', 'Pasta tom kha',
   'Tajska Żółta Lekko Ostra Pasta Curry Yellow Curry Paste Mild 400g MAE PLOY'
 );

-- Suszone zioła i przyprawy stoją na regale z przyprawami, nie przy warzywach.
update skladniki set dzial = 'przyprawy'
 where nazwa in (
   'Bazylia suszona', 'Chili suszone', 'Garam masala', 'liść laurowy',
   'ziele angielskie', 'Papryka wędzona mielona', 'Musztarda', 'Oregano suszone'
 );

update skladniki set dzial = 'mrozonki'
 where nazwa in (
   'Edamame mrożone', 'Fasolka szparagowa mrożona', 'Groszek zielony mrożony',
   'Szpinak mrożony'
 );

update skladniki set dzial = 'napoje'
 where nazwa in ('Kawa');


-- =============================================================================
--  SPRAWDZENIE — ile w każdym dziale i co zostało w „Pozostałe”
-- =============================================================================
select dzial, count(*) as skladnikow,
       string_agg(nazwa, ', ' order by nazwa) filter (where dzial = 'pozostale') as pozostale
  from skladniki
 group by dzial
 order by dzial;
