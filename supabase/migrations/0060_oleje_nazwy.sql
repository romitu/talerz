-- =============================================================================
--  TALERZ — oleje: oliwa extra virgin i rzepakowy rafinowany
-- =============================================================================
--  Po co
--  -----
--  W kuchni Talerza są dwa tłuszcze, a wybór zależy od temperatury:
--    • oliwa z oliwek extra virgin — na zimno, średni ogień, piekarnik;
--    • olej rzepakowy rafinowany — duży ogień, obsmażanie mięsa partiami, wok.
--  Dotychczasowe nazwy „Oliwa z oliwek” i „Olej rzepakowy” nie mówiły, który
--  rodzaj kupić, a od tego zależy cała reguła. Zmiana nazwy, nie nowe pozycje —
--  przepisy wskazują składnik po id, więc nic się w nich nie rozjeżdża.
--
--  Wykonanie: SQL Editor w panelu Supabase, PRZED importem przepisów
--  z supabase/narzedzia/import-przepisow-ai.sql (pliki JSON mają już nowe
--  nazwy).
-- =============================================================================

update skladniki set nazwa = 'Oliwa z oliwek extra virgin' where nazwa = 'Oliwa z oliwek';
update skladniki set nazwa = 'Olej rzepakowy rafinowany'  where nazwa = 'Olej rzepakowy';

-- Kontrola: dokładnie po jednym wierszu z nowymi nazwami, żadnego ze starymi.
select nazwa, count(*) as ile
from skladniki
where nazwa in ('Oliwa z oliwek', 'Olej rzepakowy',
                'Oliwa z oliwek extra virgin', 'Olej rzepakowy rafinowany')
group by nazwa
order by nazwa;
