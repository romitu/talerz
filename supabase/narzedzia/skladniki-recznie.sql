-- =============================================================================
--  TALERZ — składniki, których USDA nie ma
-- =============================================================================
--  Dwie pozycje z importu wypadły i nie da się tego naprawić lepszym zapytaniem:
--
--    Mleko kokosowe light  — USDA zna wyłącznie pełnotłuste z puszki
--    Pasta curry czerwona  — produkt złożony, każdy producent robi inaczej
--
--  Skąd wzięte liczby
--  ------------------
--  MLEKO KOKOSOWE LIGHT wyliczone z pełnotłustego, które jest w bazie.
--  Wersja „light" to to samo mleko rozcieńczone mniej więcej o połowę,
--  więc wszystkie wartości dzielimy przez dwa:
--
--      pełne (USDA):  197 kcal, 2,0 B, 21,3 T, 2,8 W
--      light:          99 kcal, 1,0 B, 10,7 T, 1,4 W
--
--  PASTA CURRY CZERWONA — wartości typowe dla past tajskich dostępnych
--  w Polsce. Skład to papryczki, trawa cytrynowa, galangal, czosnek, szalotka,
--  pasta krewetkowa i sól.
--
--  ZANIM UZNASZ TO ZA PRAWDĘ
--  -------------------------
--  Sprawdź etykiety i popraw wartości w tabeli składników. Obie te pozycje
--  masz w Lidlu, a tabela żywieniowa jest z tyłu opakowania.
--
--  Który błąd ile kosztuje:
--
--    Mleko kokosowe   ma znaczenie. Kurczak po tajsku zużywa 400 ml na garnek,
--                     więc pomyłka o 30 kcal/100 ml to 120 kcal na dwie porcje.
--
--    Pasta curry      nie ma znaczenia. Łyżka na dwie porcje to 7,5 g na porcję,
--                     czyli około 8 kcal. Nawet stuprocentowa pomyłka niczego
--                     tu nie zmieni.
--
--  Wykonanie: SQL Editor w panelu Supabase, po migracji 0012.
-- =============================================================================

insert into skladniki
  (nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g,
   cukry_ogolem_100g, cukry_wolne_100g, blonnik_100g, nova, masa_sztuki_g, tagi)
values
  ('Mleko kokosowe light z puszki', 'wlasne',
    99, 1.0, 10.7, 1.4, 1.4, 0, 0.0, 3, null, '{roslinne}'),

  ('Pasta curry czerwona', 'wlasne',
    110, 3.0, 5.0, 12.0, 5.0, 0, 3.0, 4, 15, '{przyprawa}'),

  -- Sos sojowy USDA znalazł („Soy sauce made from soy and wheat (shoyu)"),
  -- ale wiersz nie trafił do bazy — import zgłosił 9 pobranych, a zapisało się
  -- 6 nowych. Wartości poniżej to dokładnie te, które pokazał tamten przebieg,
  -- więc nic tu nie zgadujemy.
  --
  -- Uwaga o soli: 100 g sosu sojowego to około 15 g soli. Talerz soli nie
  -- liczy (decyzja z planu, sekcja 11), ale łyżka do dania to już 2,4 g soli
  -- przy dziennej normie 5 g. Dlatego w przepisach azjatyckich nie dosalamy.
  ('Sos sojowy', 'wlasne',
    53, 8.14, 0.57, 4.93, 0.4, 0, 0.8, 3, 16, '{przyprawa}'),

  -- HALLOUMI. USDA nie zna tego sera. Podstawienie mozzarelli zaniżyłoby
  -- kalorie o jedną trzecią, a halloumi to ser solankowy — tłusty i bardzo
  -- słony (2,5–3 g soli na 100 g). Wartości z etykiet serów cypryjskich
  -- dostępnych w Polsce.
  ('Halloumi', 'wlasne',
    321, 22.0, 25.0, 2.0, 2.0, 0, 0.0, 3, null, '{nabial}'),

  -- PASTA TOM KHA. Produkt złożony: galangal, trawa cytrynowa, liście kaffiru,
  -- szalotka, pasta krewetkowa. Każdy producent robi po swojemu.
  -- Wchodzi jej 15–20 g na garnek, więc pomyłka nic tu nie zmienia.
  ('Pasta tom kha', 'wlasne',
    120, 3.0, 6.0, 13.0, 6.0, 0, 2.0, 4, 15, '{przyprawa}'),

  -- SÓL. Bez kalorii, ale musi być w bazie, żeby dało się ją wpisać
  -- do przepisu i policzyć do listy zakupów.
  ('Sól kuchenna', 'wlasne',
    0, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 2, null, '{przyprawa}'),

  -- TRZY POZYCJE, KTÓRYCH IMPORT Z USDA NIE DOPASOWAŁ
  -- ------------------------------------------------
  -- Wartości pochodzą z tej samej bazy USDA, tylko wpisane wprost. Skrypt
  -- odrzucał je, bo jego zapytania trafiały w produkty złożone: „oat bran
  -- muffin" zamiast otrębów, „chia drink" zamiast nasion, „cinnamon roll"
  -- zamiast przyprawy. Dobieranie słów kluczowych do skutku zajęłoby więcej
  -- czasu niż przepisanie trzech wierszy.
  --
  -- Wszystkie trzy są w owsiance i razem odpowiadają za jej błonnik:
  -- 17,5 g na porcję, czyli połowa dziennej normy.
  ('Otręby owsiane', 'wlasne',
    246, 17.30, 7.03, 66.20, 1.40, 0, 15.40, 1, null, '{zboze,gluten}'),

  ('Nasiona chia', 'wlasne',
    486, 16.50, 30.70, 42.10, 0.00, 0, 34.40, 1, null, '{nasiona}'),

  ('Cynamon mielony', 'wlasne',
    247, 4.00, 1.24, 80.60, 2.20, 0, 53.10, 2, null, '{przyprawa}')

on conflict (nazwa) do update set
  kcal_100g         = excluded.kcal_100g,
  bialko_100g       = excluded.bialko_100g,
  tluszcz_100g      = excluded.tluszcz_100g,
  wegle_100g        = excluded.wegle_100g,
  cukry_ogolem_100g = excluded.cukry_ogolem_100g,
  cukry_wolne_100g  = excluded.cukry_wolne_100g,
  blonnik_100g      = excluded.blonnik_100g,
  nova              = excluded.nova,
  masa_sztuki_g     = excluded.masa_sztuki_g,
  tagi              = excluded.tagi;


-- =============================================================================
--  POPRAWKA: TWARÓG PÓŁTŁUSTY TO NIE SEREK WIEJSKI
-- =============================================================================
--  Import z USDA podstawił pod „Twaróg półtłusty" produkt o 84 kcal i 11 g
--  białka na 100 g. To jest *cottage cheese* — serek wiejski, ziarnisty,
--  pływający w śmietance. Polski twaróg półtłusty to zupełnie co innego:
--  odciśnięta masa serowa, prawie dwa razy bardziej skoncentrowana.
--
--      USDA cottage cheese 2%      84 kcal, 11,0 g białka
--      twaróg półtłusty (IŻŻ)     133 kcal, 18,7 g białka
--
--  Dlaczego to ma znaczenie
--  ------------------------
--  Twaróg jest u Ciebie jednym z głównych źródeł białka — 210 g na śniadanie.
--  Przy wartościach serka wiejskiego to 23 g białka, przy prawdziwym twarogu
--  39 g. Różnica 16 g, czyli tyle, ile daje solidny kawałek mięsa.
--
--  Aplikacja mówiłaby Ci, że brakuje białka, kiedy w rzeczywistości je zjadłeś.
--
--  Skąd te liczby
--  --------------
--  Tabele składu i wartości odżywczej żywności, Kunachowicz i wsp., IŻŻ —
--  standardowe źródło dla produktów polskich, których USDA nie zna.
--  Sprawdź jeszcze etykietę swojego twarogu: producenci różnią się o 10–15%.
--
--  Uruchamiaj świadomie — to nadpisuje dane, które już masz.
-- =============================================================================

update skladniki set
  zrodlo        = 'wlasne',
  kcal_100g     = 133,
  bialko_100g   = 18.7,
  tluszcz_100g  = 4.7,
  wegle_100g    = 3.5,
  cukry_ogolem_100g = 3.5,
  cukry_wolne_100g  = 0,
  blonnik_100g  = 0,
  nova          = 3
where nazwa = 'Twaróg półtłusty';


-- --- CO WPISANO -----------------------------------------------------------
--  Panel Supabase pokazuje wynik tylko OSTATNIEGO zapytania, więc jest tu
--  jedno. Braki sprawdza osobny plik: narzedzia/sprawdz-skladniki.sql
select nazwa, kcal_100g, bialko_100g, tluszcz_100g, blonnik_100g, masa_sztuki_g
  from skladniki
 where zrodlo = 'wlasne'
 order by nazwa;
