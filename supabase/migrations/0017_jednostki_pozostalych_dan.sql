-- =============================================================================
--  TALERZ — przeliczniki dla składników z pozostałych dań
-- =============================================================================
--  Dopełnienie migracji 0012. Tamta objęła składniki trzech dań próbnych;
--  po przeniesieniu wszystkich trzydziestu jeden doszło sześć nowych miar
--  domowych.
--
--  Tak samo jak 0012: wypełnia WYŁĄCZNIE puste pola. Jeśli którąś wartość
--  już poprawiłeś, zostaje Twoja.
--
--  Skąd te liczby
--  --------------
--  Awokado          jadalny miąższ jednego owocu, bez pestki i skórki.
--                   Całe awokado waży ok. 200 g, zjadasz z niego 140.
--  Cebula czerwona  jak zwykła — jedna średnia sztuka.
--  Fasola z puszki  puszka 400 g brutto to ok. 240 g po odsączeniu.
--                   To dlatego fasola z puszki jest osobnym składnikiem
--                   od suchej: 240 g ugotowanej to tylko 85 g suchej,
--                   a różnica w kaloriach wynosi jakieś 500 na danie.
--  Olej rzepakowy   łyżka stołowa 15 ml razy gęstość 0,92 — jak oliwa.
--  Sos rybny        łyżka; przepis podaje łyżeczkę, czyli jedną trzecią.
--
--  Wykonanie: SQL Editor w panelu Supabase, po migracji 0012.
-- =============================================================================

do $$
declare
  wiersz     record;
  obecna     numeric;
  wypelnione text[] := '{}';
  zostawione text[] := '{}';
  nieobecne  text[] := '{}';
begin
  for wiersz in
    select * from (values
      ('Awokado',                             140),
      ('Cebula czerwona, surowa',             110),
      ('Fasola biała z puszki, odsączona',    240),
      ('Fasola czerwona z puszki, odsączona', 240),
      ('Olej rzepakowy',                       12),
      ('Sos rybny',                            18)
    ) as t(nazwa, masa)
  loop
    select masa_sztuki_g into obecna from skladniki where nazwa = wiersz.nazwa;

    if not found then
      nieobecne := nieobecne || wiersz.nazwa;
    elsif obecna is not null then
      zostawione := zostawione || wiersz.nazwa;
    else
      update skladniki set masa_sztuki_g = wiersz.masa where nazwa = wiersz.nazwa;
      wypelnione := wypelnione || wiersz.nazwa;
    end if;
  end loop;

  raise notice 'WYPEŁNIONE: %', array_to_string(wypelnione, ', ');
  raise notice 'ZOSTAWIONE BEZ ZMIAN: %', array_to_string(zostawione, ', ');
  raise notice 'NIE MA W BAZIE: %', array_to_string(nieobecne, ', ');
end $$;


-- --- SPRAWDZENIE ------------------------------------------------------------
select nazwa, masa_sztuki_g
  from skladniki
 where nazwa in ('Awokado', 'Cebula czerwona, surowa',
                 'Fasola biała z puszki, odsączona', 'Fasola czerwona z puszki, odsączona',
                 'Olej rzepakowy', 'Sos rybny')
 order by nazwa;
