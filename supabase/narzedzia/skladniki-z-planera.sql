-- =============================================================================
--  TALERZ — 32 składniki brakujące do przeniesienia przepisów
-- =============================================================================
--  Dlaczego wprost, a nie przez import z USDA
--  ------------------------------------------
--  Te pozycje miały przyjść skryptem `node narzedzia/import-usda.mjs`.
--  Dopisywanie ich po jednej, po każdej nieudanej próbie importu, zajęłoby
--  więcej czasu niż jedno wklejenie. A część i tak by nie przeszła: USDA
--  odrzuca produkty złożone i trafia w podobnie brzmiące, ale inne rzeczy
--  (przy otrębach owsianych podstawiało muffiny).
--
--  Skąd te liczby
--  --------------
--  USDA FoodData Central, wartości na 100 g produktu SUROWEGO. Mięso liczone
--  jako część chuda bez kości — to samo założenie co przy żeberkach
--  w ogórkowej i przy udkach w zupie pomidorowej.
--
--  Masa jednej miary (`masa_sztuki_g`) wpisana tylko tam, gdzie przepisy
--  podają sztuki: awokado, cebula, puszka fasoli, łyżka oleju, łyżka sosu.
--
--  BULION Z KOSTKI — dlaczego 5 kcal, a nie 250
--  --------------------------------------------
--  Kostka rzeczywiście ma około 250 kcal na 100 g. Ale przepisy podają
--  „200 ml bulionu”, czyli GOTOWY PŁYN, a nie kostkę.
--
--  Rachunek: kostka waży ~10 g i robi 500 ml wywaru. Na 200 ml wychodzi
--  4 g kostki, czyli około 10 kcal. To jest te 5 kcal na 100 ml.
--
--  Gdyby wpisać tu wartości kostki, 200 ml bulionu policzyłoby się na 500 kcal
--  zamiast 10 — pięćdziesiąt razy za dużo. Dlatego składnik nazywa się
--  „gotowy”: mierzymy mililitry płynu, nie gramy kostki.
--
--  Czego to NIE obejmuje
--  ---------------------
--  Soli. Kostka to około 2,4 g soli, więc 200 ml wywaru wnosi blisko 1 g —
--  jedną piątą dziennej normy, w samym tylko bulionie. Talerz soli nie liczy
--  (decyzja z planu, sekcja 11), ale przy zupach warto o tym pamiętać
--  i nie dosalać.
--
--  Lista zakupów wypisze „bulion warzywny gotowy, 1200 ml”. Kupujesz kostki,
--  więc w praktyce znaczy to: dwie i pół kostki.
--
--  FASOLA Z PUSZKI — 240 g po odsączeniu z puszki 400 g. To OSOBNY składnik
--  od suchej: 240 g ugotowanej to 85 g suchej, różnica w kaloriach wynosi
--  około 500 na danie.
--
--  Skrypt można uruchamiać wielokrotnie — istniejące pozycje aktualizuje.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

-- =============================================================================
--  ZMIANA NAZWY: ŁOPATKA -> GULASZ WIEPRZOWY
-- =============================================================================
--  Gulasz kupujesz w Lidlu gotowy, w tackach, i tak nazywa się na etykiecie.
--  „Łopatka wieprzowa gulaszowa" była moim domysłem, z czego go robią.
--  Lista zakupów ma mówić to, co jest napisane na produkcie.
--
--  Zmieniamy NAZWĘ istniejącej pozycji, a nie zakładamy nowej — dzięki temu
--  przepisy, które już się na nią powołują, nie tracą powiązania. Wartości
--  zostają te same: gulasz z tacki to w praktyce łopatka pokrojona w kostkę.
--
--  Warto sprawdzić etykietę. Tacki bywają tłustsze albo chudsze zależnie od
--  partii, a w gulaszu z kaszą wchodzi go 700 g na garnek — pomyłka o 30 kcal
--  na 100 g to 210 kcal na garnek, czyli 70 na porcję.
-- =============================================================================

update skladniki
   set nazwa = 'Gulasz wieprzowy, surowy'
 where nazwa = 'Łopatka wieprzowa gulaszowa, surowa'
   and not exists (select 1 from skladniki s2 where s2.nazwa = 'Gulasz wieprzowy, surowy');


insert into skladniki
  (nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
   cukry_ogolem_100g, cukry_wolne_100g, blonnik_100g, nova, masa_sztuki_g, tagi)
values
  -- --- mięso i ryby -------------------------------------------------------
  ('Schab wieprzowy, surowy',               'wlasne', 143, 21.40,  5.70,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),
  ('Polędwiczka wieprzowa, surowa',         'wlasne', 109, 20.95,  2.17,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),
  ('Szynka wieprzowa chuda, surowa',        'wlasne', 136, 20.90,  5.40,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),
  ('Gulasz wieprzowy, surowy',              'wlasne', 151, 19.60,  7.40,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),
  ('Wołowina na plastry (udziec), surowa',  'wlasne', 133, 22.40,  4.00,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),
  ('Mięso mielone wołowo-wieprzowe, surowe','wlasne', 215, 17.20, 16.00,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),

  -- PRĘGA WOŁOWA BEZ KOŚCI. Do barszczu ukraińskiego, zamiast mięsa
  -- gulaszowego. Kolagen po dwóch godzinach przechodzi w żelatynę i wywar
  -- dostaje ciało — nie jest wodnisty mimo niskiej zawartości tłuszczu.
  --
  -- Wartości dla części chudej. W Lidlu pręga bywa i z kością, i bez;
  -- te liczby dotyczą mięsa bez kości, bo takie kupujesz.
  ('Pręga wołowa bez kości, surowa',       'wlasne', 137, 21.40,  4.90,  0.00, 0.00, 0,  0.00, 1, null,  '{mieso}'),
  ('Filet z indyka, surowy',                'wlasne', 114, 23.70,  1.48,  0.14, 0.05, 0,  0.00, 1, null,  '{mieso,drob}'),

  -- --- warzywa i grzyby ---------------------------------------------------
  ('Pieczarki, surowe',        'wlasne',  22,  3.09, 0.34,  3.26, 1.98, 0,  1.00, 1, null, '{warzywo}'),
  ('Boczniaki, surowe',        'wlasne',  33,  3.31, 0.41,  6.09, 1.11, 0,  2.30, 1, null, '{warzywo}'),
  ('Awokado',                  'wlasne', 160,  2.00, 14.70, 8.53, 0.66, 0,  6.70, 1,  140, '{owoc,tluszcz}'),
  ('Rukola',                   'wlasne',  25,  2.58, 0.66,  3.65, 2.05, 0,  1.60, 1, null, '{warzywo}'),
  ('Cebula czerwona, surowa',  'wlasne',  40,  1.10, 0.10,  9.34, 4.24, 0,  1.70, 1,  110, '{warzywo}'),
  ('Kapusta biała, surowa',    'wlasne',  25,  1.28, 0.10,  5.80, 3.20, 0,  2.50, 1, null, '{warzywo}'),
  ('Kapusta kiszona',          'wlasne',  19,  0.91, 0.14,  4.28, 1.78, 0,  2.90, 3, null, '{warzywo,kiszone}'),

  -- --- sypkie i zboża -----------------------------------------------------
  ('Kasza jęczmienna, sucha',     'wlasne', 352,  9.91,  1.16, 77.70, 0.80, 0, 15.60, 1, null, '{zboze,gluten}'),
  ('Bułka tarta',                 'wlasne', 395, 13.40,  5.30, 71.90, 6.20, 0,  4.60, 3, null, '{zboze,gluten}'),
  ('Masło orzechowe bez cukru',   'wlasne', 598, 22.20, 51.40, 22.30, 4.20, 0,  5.00, 3, null, '{orzechy}'),

  -- --- puszki, słoiki, przetwory -------------------------------------------
  ('Bulion warzywny gotowy',              'wlasne',   5,  0.40,  0.10,  0.90, 0.50, 0, 0.00, 4, null, '{przyprawa}'),
  ('Chrzan tarty',                        'wlasne',  48,  1.18,  0.69, 11.30, 7.99, 0, 3.30, 3, null, '{przyprawa}'),
  ('Oliwki czarne',                       'wlasne', 115,  0.84, 10.70,  6.30, 0.00, 0, 3.20, 3, null, '{owoc,tluszcz}'),
  ('Pomidory suszone w oleju',            'wlasne', 213,  5.06, 14.10, 23.30, 0.00, 0, 5.80, 3, null, '{warzywo}'),
  ('Fasola biała z puszki, odsączona',    'wlasne', 114,  7.40,  0.40, 21.00, 0.30, 0, 5.40, 3,  240, '{straczki}'),
  ('Fasola czerwona z puszki, odsączona', 'wlasne', 124,  8.67,  0.50, 22.80, 0.30, 0, 7.40, 3,  240, '{straczki}'),
  ('Sos rybny',                           'wlasne',  35,  5.06,  0.01,  3.64, 3.64, 0, 0.00, 4,   18, '{przyprawa}'),

  -- --- mrożonki ------------------------------------------------------------
  ('Szpinak mrożony',          'wlasne', 29, 3.63, 0.87,  4.19, 0.45, 0, 2.90, 1, null, '{warzywo}'),
  ('Groszek zielony mrożony',  'wlasne', 77, 5.20, 0.40, 13.70, 4.10, 0, 4.50, 1, null, '{warzywo}'),

  -- --- tłuszcze ------------------------------------------------------------
  ('Olej rzepakowy',           'wlasne', 884, 0.00, 100.00, 0.00, 0.00, 0, 0.00, 2, 12, '{tluszcz}'),

  -- --- przyprawy -----------------------------------------------------------
  ('Majeranek suszony',        'wlasne', 271, 12.70,  7.04, 60.60, 4.10, 0, 40.30, 2, null, '{przyprawa}'),
  ('Tymianek suszony',         'wlasne', 276,  9.11,  7.43, 63.90, 1.71, 0, 37.00, 2, null, '{przyprawa}'),
  ('Rozmaryn suszony',         'wlasne', 331,  4.88, 15.20, 64.10, 0.00, 0, 42.60, 2, null, '{przyprawa}'),
  ('Kmin rzymski mielony',     'wlasne', 375, 17.80, 22.30, 44.20, 2.25, 0, 10.50, 2, null, '{przyprawa}'),
  ('Papryka ostra mielona',    'wlasne', 318, 12.00, 17.30, 56.60, 10.30, 0, 27.20, 2, null, '{przyprawa}'),
  ('Pieprz biały mielony',     'wlasne', 296, 10.40,  2.12, 68.60, 0.00, 0, 26.20, 2, null, '{przyprawa}')

on conflict (nazwa) do update set
  kcal_100g         = excluded.kcal_100g,
  bialko_100g       = excluded.bialko_100g,
  tluszcz_100g      = excluded.tluszcz_100g,
  wegle_100g        = excluded.wegle_100g,
  cukry_ogolem_100g = excluded.cukry_ogolem_100g,
  cukry_wolne_100g  = excluded.cukry_wolne_100g,
  blonnik_100g      = excluded.blonnik_100g,
  nova              = excluded.nova,
  masa_sztuki_g     = coalesce(skladniki.masa_sztuki_g, excluded.masa_sztuki_g),
  tagi              = excluded.tagi;


-- --- CO WPISANO -------------------------------------------------------------
select nazwa, kcal_100g, bialko_100g, tluszcz_100g, blonnik_100g, masa_sztuki_g
  from skladniki
 where zrodlo = 'wlasne'
 order by nazwa;
