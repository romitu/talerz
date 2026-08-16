-- =============================================================================
--  TALERZ — jednostki domowe przeliczone na gramy
-- =============================================================================
--  Problem
--  -------
--  Przepisy ze starego planera podają ilości tak, jak się gotuje: „łyżka oliwy",
--  „ząbek czosnku", „trzy kromki chleba", „puszka tuńczyka". Talerz liczy makro
--  z gramów i inaczej nie umie.
--
--  Dlaczego to nie jest tabela przeliczników
--  -----------------------------------------
--  Kuszące byłoby zrobić słownik „łyżka = 15 g". To jednak nieprawda:
--
--      łyżka oliwy         12 g
--      łyżka jogurtu       20 g
--      łyżka sosu sojowego 16 g
--      łyżka pasty curry   15 g
--
--  Ta sama łyżka, cztery różne masy — bo różnią się gęstością i tym, jak produkt
--  się na niej układa. Przelicznik należy więc do SKŁADNIKA, nie do jednostki.
--  Mamy już na to miejsce: kolumnę `masa_sztuki_g` z migracji 0008.
--
--  Znaczenie kolumny rozszerzamy: „ile waży jedna naturalna miara tego
--  składnika". Dla marchwi to jedna marchewka, dla czosnku ząbek, dla chleba
--  kromka, dla oliwy łyżka. W formularzu wszystkie występują jako „szt".
--
--  MIGRACJA NICZEGO NIE NADPISUJE
--  ------------------------------
--  Wypełnia wyłącznie puste pola. Jeśli wpisałeś już, że marchewka waży 70 g,
--  a czosnek 5 g — tak zostanie. Twoje liczby są z Twojej kuchni, moje
--  z tabel; przy sprzeczności wygrywa kuchnia.
--
--  Na końcu skrypt wypisuje, czego NIE ruszył, żeby było widać różnicę.
--
--  Skąd te liczby
--  --------------
--  Warzywa i owoce — masa jadalnej części sztuki średniej wielkości, spójna
--  z tym, jak USDA definiuje porcję („1 medium"). Produkty sypkie i płynne —
--  łyżka stołowa 15 ml przemnożona przez gęstość produktu.
--
--  To są wartości przybliżone i takie zostaną. Marchewka waży od 50 do 120 g
--  i żadna liczba tego nie naprawi. Dokładność ±30% na marchewce zmienia
--  kaloryczność porcji o kilkanaście kilokalorii — mniej, niż wynosi błąd
--  samych tabel składu. Gdzie dokładność ma znaczenie (mięso, ryż, oliwa),
--  przepisy i tak podają gramy.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

comment on column skladniki.masa_sztuki_g is
  'Ile waży jedna naturalna miara: sztuka warzywa, ząbek czosnku, kromka chleba, łyżka oliwy. Puste = składnik podawany wyłącznie na wagę.';


do $$
declare
  wiersz     record;
  ile        integer;
  wypelnione text[] := '{}';
  zostawione text[] := '{}';
  nieobecne  text[] := '{}';
  obecna     numeric;
begin
  for wiersz in
    select * from (values
      -- warzywa i owoce: jedna sztuka średniej wielkości, część jadalna
      ('Marchew, surowa',                     75),
      ('Cebula, surowa',                     110),
      ('Papryka czerwona, surowa',           120),
      ('Pomidory, surowe',                   120),
      ('Ogórek, surowy',                     200),
      ('ogórki kiszone bio',                  60),
      ('Ziemniaki, surowe',                  150),
      ('Pietruszka korzeń',                   50),
      ('Por, surowy',                         90),
      ('Brokuł, surowy',                     400),
      ('Cytryna',                             60),
      ('Rzodkiewka, surowa',                  10),
      ('Czosnek, surowy',                      4),

      -- mięso liczone na sztuki
      ('Udo z kurczaka bez skóry, surowe',   110),

      -- nabiał i jaja
      ('Jaja kurze, całe, surowe',            55),
      ('Jogurt grecki naturalny 2%',          20),
      ('śmietana 18% kwaśna',                 20),

      -- pieczywo
      ('Chleb żytni razowy',                  35),

      -- tłuszcze: łyżka stołowa 15 ml razy gęstość
      ('Oliwa z oliwek',                      12),
      ('Masło',                               15),

      -- płyny i pasty
      ('Sos sojowy',                          16),
      ('Pasta curry czerwona',                15),
      ('Miód',                                21),

      -- opakowania
      ('Tuńczyk w wodzie, odsączony',        140),
      ('Kasza gryczana, sucha',              100),

      -- orzechy i nasiona
      ('Siemię lniane',                       10),
      ('Sezam',                                9)
    ) as t(nazwa, masa)
  loop
    select masa_sztuki_g into obecna from skladniki where nazwa = wiersz.nazwa;

    if not found then
      nieobecne := nieobecne || wiersz.nazwa;
    elsif obecna is not null then
      -- Twoja wartość zostaje. Zapisujemy ją do raportu razem z moją,
      -- żebyś mógł porównać i ewentualnie poprawić ręcznie.
      zostawione := zostawione ||
        format('%s (masz %s, proponowałem %s)', wiersz.nazwa, trim(trailing '0' from trim(trailing '.' from obecna::text)), wiersz.masa);
    else
      update skladniki set masa_sztuki_g = wiersz.masa where nazwa = wiersz.nazwa;
      get diagnostics ile = row_count;
      if ile > 0 then wypelnione := wypelnione || wiersz.nazwa; end if;
    end if;
  end loop;

  raise notice '';
  raise notice 'WYPEŁNIONE (% szt.): %',
    coalesce(array_length(wypelnione, 1), 0), array_to_string(wypelnione, ', ');
  raise notice '';
  raise notice 'ZOSTAWIONE BEZ ZMIAN (% szt.): %',
    coalesce(array_length(zostawione, 1), 0), array_to_string(zostawione, E'\n    ');
  raise notice '';
  raise notice 'NIE MA W BAZIE (% szt.): %',
    coalesce(array_length(nieobecne, 1), 0), array_to_string(nieobecne, ', ');
end $$;


-- --- CO WYSZŁO --------------------------------------------------------------
select nazwa, masa_sztuki_g, zrodlo
  from skladniki
 where masa_sztuki_g is not null
 order by nazwa;


-- =============================================================================
--  ZNANE PUŁAPKI — do rozwiązania przy imporcie pozostałych dań
-- =============================================================================
--  1. FASOLA Z PUSZKI
--     Baza ma „Fasola biała, sucha" (333 kcal/100 g). Przepis mówi „puszka".
--     Puszka to ~240 g fasoli ugotowanej, czyli ~85 g suchej. Wpisanie 240 g
--     suchej fasoli zawyżyłoby danie o mniej więcej 500 kcal.
--     Rozwiązanie: osobny składnik „Fasola biała z puszki, odsączona".
--     Ta sama sprawa dotyczy fasoli czerwonej i ciecierzycy.
--
--  2. RYŻ I KASZA — SUCHE CZY UGOTOWANE
--     Przepisy podają wagę suchego, ale porcja na talerzu to ugotowany, który
--     waży dwa i pół raza więcej. Nie wpływa to na makro (woda nie ma kalorii),
--     ale wpływa na wyliczoną wagę porcji.
--
--  3. MIĘSO SUROWE CZY PO OBRÓBCE
--     USDA podaje surowe. Przepis podaje surowe. Porcja na talerzu jest
--     lżejsza o 20–30% (odparowana woda). Makro zostaje, waga porcji nie.
--     Ten sam problem co przy żeberkach w ogórkowej.
-- =============================================================================
