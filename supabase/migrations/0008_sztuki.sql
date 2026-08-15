-- =============================================================================
--  TALERZ — sztuki jako jednostka
-- =============================================================================
--  Problem
--  -------
--  Część składników odmierza się w sztukach, nie w gramach: „2 liście laurowe”,
--  „4 ziarna ziela angielskiego”, „1 jajko”. Wpisywanie tego w gramach jest
--  nienaturalne, a samo „2 sztuki” nie wystarcza, bo makro liczy się z masy.
--
--  Rozwiązanie
--  -----------
--  Składnik może podać, ile waży jedna sztuka. Wtedy przepis przyjmuje ilość
--  w sztukach, a masę wylicza mnożeniem. Składniki bez tej wartości pozostają
--  wyłącznie wagowe — jednostka „szt” nie jest dla nich dostępna.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  add column masa_sztuki_g numeric(7, 2) check (masa_sztuki_g > 0 and masa_sztuki_g <= 5000);

comment on column skladniki.masa_sztuki_g is
  'Ile waży jedna sztuka: liść laurowy 0,2 g, ziarno ziela 0,1 g, jajko 55 g. Puste = składnik odmierzany wyłącznie wagowo.';

alter type jednostka_miary add value if not exists 'szt';

comment on column przepis_skladniki.jednostka is
  'g, ml albo szt. Przy sztukach pole `gramy` przechowuje masę wyliczoną z liczby sztuk — makro zawsze liczy się z masy.';

comment on column przepis_skladniki.gramy is
  'Masa w gramach, także gdy jednostką są sztuki albo mililitry. To z niej wylicza się wartości odżywcze.';


-- =============================================================================
--  ILOŚĆ W JEDNOSTCE WYBRANEJ PRZEZ UŻYTKOWNIKA
-- =============================================================================
--  Do tej pory przechowywaliśmy wyłącznie masę. Przy sztukach trzeba zapamiętać
--  też liczbę, żeby przepis wyświetlał „2 liście”, a nie „0,4 g liścia”.
-- =============================================================================

alter table przepis_skladniki
  add column ilosc numeric(8, 2) check (ilosc > 0);

comment on column przepis_skladniki.ilosc is
  'Liczba w jednostce widocznej dla użytkownika: 2 przy sztukach, 350 przy gramach. Pole `gramy` pozostaje podstawą wyliczeń.';

-- Dla istniejących wierszy ilość odpowiada masie, bo wszystkie były wagowe.
update przepis_skladniki set ilosc = gramy where ilosc is null;


-- =============================================================================
--  WARTOŚCI DLA SKŁADNIKÓW ODMIERZANYCH W SZTUKACH
-- =============================================================================

update skladniki set masa_sztuki_g = 0.2  where nazwa ilike 'liść laurowy%';
update skladniki set masa_sztuki_g = 0.1  where nazwa ilike 'ziele angielskie%';
update skladniki set masa_sztuki_g = 55   where nazwa ilike 'jaja kurze%';
update skladniki set masa_sztuki_g = 70   where nazwa ilike 'marchew%';
update skladniki set masa_sztuki_g = 110  where nazwa ilike 'cebula%';
update skladniki set masa_sztuki_g = 5    where nazwa ilike 'czosnek%';
update skladniki set masa_sztuki_g = 120  where nazwa ilike 'ziemniaki%';
update skladniki set masa_sztuki_g = 180  where nazwa ilike 'jabłko%';
update skladniki set masa_sztuki_g = 120  where nazwa ilike 'banan%';
update skladniki set masa_sztuki_g = 130  where nazwa ilike 'pomidory, surowe%';
update skladniki set masa_sztuki_g = 150  where nazwa ilike 'papryka czerwona%';
update skladniki set masa_sztuki_g = 60   where nazwa ilike 'cytryna%';
update skladniki set masa_sztuki_g = 140  where nazwa ilike 'pomarańcza%';
