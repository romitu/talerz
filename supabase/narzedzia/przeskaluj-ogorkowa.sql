-- =============================================================================
--  TALERZ — przeliczenie zupy ogórkowej na bazę 800 ml
-- =============================================================================
--  Co robi
--  -------
--  Sprowadza przepis do jednej porcji bazowej (800 ml gotowej zupy, czyli dwa
--  talerze po 400 ml). Krotności ×2 i ×3 aplikacja wylicza z tej bazy.
--
--  Czego NIE skaluje
--  -----------------
--  Przypraw i tłuszczu do smażenia. Masła potrzebujesz 20 g niezależnie od
--  wielkości garnka — tyle zajmuje dno patelni. Liść laurowy i ziele
--  ustawiamy na wartości sensowne dla 800 ml.
--
--  Jak uruchomić
--  -------------
--  Wklej całość do SQL Editor w Supabase. Skrypt najpierw pokazuje stan
--  przed zmianą, potem po — możesz porównać.
--
--  Bezpieczeństwo: działa wyłącznie na przepisie o nazwie „Zupa ogórkowa”.
--  Jeśli nazwałeś go inaczej, popraw wartość w pierwszym bloku.
-- =============================================================================

-- --- STAN PRZED ---------------------------------------------------------
select
  'PRZED' as etap,
  s.nazwa,
  ps.ilosc,
  ps.jednostka,
  ps.gramy
from przepis_skladniki ps
join skladniki s   on s.id = ps.skladnik_id
join przepisy p    on p.id = ps.przepis_id
where p.nazwa = 'Zupa ogórkowa'
order by ps.kolejnosc;


-- --- PRZELICZENIE -------------------------------------------------------
do $$
declare
  id_przepisu uuid;
  masa_teraz  numeric;
  wspolczynnik numeric;
begin
  select id into id_przepisu from przepisy where nazwa = 'Zupa ogórkowa' limit 1;

  if id_przepisu is null then
    raise exception 'Nie znaleziono przepisu „Zupa ogórkowa”. Popraw nazwę w skrypcie.';
  end if;

  select sum(gramy) into masa_teraz from przepis_skladniki where przepis_id = id_przepisu;

  if masa_teraz is null or masa_teraz <= 0 then
    raise exception 'Przepis nie ma składników — nie ma czego przeliczać.';
  end if;

  -- Docelowo 800 g gotowej zupy. Przyjmujemy gęstość zbliżoną do wody,
  -- więc 800 ml odpowiada 800 g.
  wspolczynnik := 800.0 / masa_teraz;

  raise notice 'Masa przed: % g, współczynnik: %', round(masa_teraz), round(wspolczynnik, 4);

  -- 1. Wszystko skalujemy proporcjonalnie.
  update przepis_skladniki
     set gramy = round((gramy * wspolczynnik)::numeric, 1),
         ilosc = round((ilosc * wspolczynnik)::numeric, 1)
   where przepis_id = id_przepisu;

  -- 2. Przyprawy wracają do wartości sensownych dla 800 ml.
  update przepis_skladniki ps
     set ilosc = 1, jednostka = 'szt', gramy = 0.2
    from skladniki s
   where s.id = ps.skladnik_id
     and ps.przepis_id = id_przepisu
     and s.nazwa ilike 'liść laurowy%';

  update przepis_skladniki ps
     set ilosc = 2, jednostka = 'szt', gramy = 0.2
    from skladniki s
   where s.id = ps.skladnik_id
     and ps.przepis_id = id_przepisu
     and s.nazwa ilike 'ziele angielskie%';

  -- 3. Tłuszcz do smażenia nie zależy od wielkości garnka — dno patelni ma swoje.
  update przepis_skladniki ps
     set ilosc = 20, jednostka = 'g', gramy = 20
    from skladniki s
   where s.id = ps.skladnik_id
     and ps.przepis_id = id_przepisu
     and s.nazwa ilike 'masło%';

  -- 4. Sól proporcjonalnie, ale zaokrąglona do pełnego grama.
  update przepis_skladniki ps
     set ilosc = greatest(round(ps.gramy), 1), gramy = greatest(round(ps.gramy), 1)
    from skladniki s
   where s.id = ps.skladnik_id
     and ps.przepis_id = id_przepisu
     and s.nazwa ilike 'sól%';

  -- 5. Porcjowanie: jedna porcja bazowa to 800 g.
  update przepisy
     set porcjowanie = 'waga',
         porcja_g = 800,
         opis = coalesce(opis, '') ||
                case when opis is null or opis = '' then '' else ' ' end ||
                'Przepis rozpisany na jedną porcję bazową 800 ml (dwa talerze). ' ||
                'Gotując dla większej liczby osób albo na kilka dni, zwielokrotnij całość.'
   where id = id_przepisu;

  raise notice 'Gotowe. Masa po przeliczeniu: % g',
    (select round(sum(gramy)) from przepis_skladniki where przepis_id = id_przepisu);
end $$;


-- --- STAN PO ------------------------------------------------------------
select
  'PO' as etap,
  s.nazwa,
  ps.ilosc,
  ps.jednostka,
  ps.gramy
from przepis_skladniki ps
join skladniki s   on s.id = ps.skladnik_id
join przepisy p    on p.id = ps.przepis_id
where p.nazwa = 'Zupa ogórkowa'
order by ps.kolejnosc;


-- --- SPRAWDZENIE --------------------------------------------------------
select
  round(sum(ps.gramy))                                  as masa_bazy_g,
  (select porcja_g from przepisy where nazwa = 'Zupa ogórkowa') as porcja_g,
  (select kcal from przepis_makro m
     join przepisy p on p.id = m.przepis_id
    where p.nazwa = 'Zupa ogórkowa')                    as kcal_na_porcje
from przepis_skladniki ps
join przepisy p on p.id = ps.przepis_id
where p.nazwa = 'Zupa ogórkowa';
