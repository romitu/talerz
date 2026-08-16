-- =============================================================================
--  TALERZ — nazwa przepisu niepowtarzalna
-- =============================================================================
--  Po co
--  -----
--  Import ze starego planera rozpoznaje przepisy po nazwie: „jeśli danie o tej
--  nazwie już jest, odśwież je zamiast tworzyć drugie". Bez ograniczenia
--  w bazie to działa tylko dopóki nikt nie założy dwóch przepisów tak samo
--  nazwanych — a wtedy import cicho zaktualizowałby przypadkowy.
--
--  Przy okazji to zwykły porządek: dwie „Zupy ogórkowe" na liście, różniące
--  się tylko zawartością, są nie do rozróżnienia dla człowieka.
--
--  Wielkość liter nie ma znaczenia — „Barszcz" i „barszcz" to jedno danie.
--  Ta sama zasada co przy sprzęcie (migracja 0011).
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

-- --- 1. Najpierw przycinamy białe znaki ------------------------------------
update przepisy
   set nazwa = regexp_replace(trim(nazwa), '\s+', ' ', 'g')
 where nazwa <> regexp_replace(trim(nazwa), '\s+', ' ', 'g');


-- --- 2. Czy są powtórki -----------------------------------------------------
--  Gdyby były, indeks by się nie założył. Wypisujemy je, zamiast przerywać
--  z komunikatem, z którego nic nie wynika.
select lower(nazwa) as nazwa, count(*) as ile
  from przepisy
 group by lower(nazwa)
having count(*) > 1;


-- --- 3. Ograniczenie --------------------------------------------------------
create unique index if not exists przepisy_nazwa_klucz on przepisy (lower(nazwa));

comment on index przepisy_nazwa_klucz is
  'Nazwa przepisu niepowtarzalna bez względu na wielkość liter. Po niej import rozpoznaje, czy danie już jest w bazie.';
