-- =============================================================================
--  TALERZ — „Warto wiedzieć” przy składniku
-- =============================================================================
--  Po co
--  -----
--  Krótka uwaga, jak przygotować składnik i dlaczego — np. że czosnek warto
--  zgnieść ok. 10 minut przed użyciem, a siemię lniane zmielić tuż przed
--  podaniem. Pisana RAZ, w katalogu, i widoczna przy tym składniku w każdym
--  przepisie (ikonka ⓘ; przy składnikach z listy „Chcemy więcej” rozwinięta).
--
--  Przepis zostaje przepisem: uwaga niczego w nim nie zmienia ani nie dopisuje
--  kroków. Użytkownik sam decyduje, czy z niej skorzysta.
--
--  Zasada redakcyjna: kuchnia i chemia TAK (smak, konsystencja, wchłanianie,
--  co się dzieje w temperaturze), obietnice zdrowotne NIE („działa
--  przeciwzapalnie”, „wspiera wątrobę”) — to byłyby oświadczenia zdrowotne.
--
--  Edytuje moderator, tak jak resztę katalogu — reguły dostępu do tabeli
--  `skladniki` (migracja 0001) obejmują nową kolumnę bez zmian.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  add column warto_wiedziec text
    check (warto_wiedziec is null or length(btrim(warto_wiedziec)) between 1 and 600);

comment on column skladniki.warto_wiedziec is
  'Krótka uwaga: jak przygotować składnik i dlaczego. Pokazywana przy składniku w przepisie. Bez obietnic zdrowotnych. NULL = brak uwagi.';


-- =============================================================================
--  UWAGI DLA PIERWSZYCH SKŁADNIKÓW
-- =============================================================================
--  Dopasowanie po nazwie bez względu na wielkość liter — jeśli w katalogu
--  składnik nazywa się inaczej, wiersz po prostu się nie zmieni; sprawdzenie
--  na dole pokaże, które uwagi trafiły na miejsce. Czarnuszki może jeszcze
--  nie być w katalogu — wtedy uwagę wkleja się po dopisaniu składnika,
--  w formularzu albo w Excelu.

update skladniki set warto_wiedziec =
  'Zgnieć albo posiekaj ok. 10 minut przed użyciem — wtedy powstaje allicyna, która odpowiada za ostry smak i zapach czosnku. Wysoka temperatura ją rozkłada, więc czosnek dodany na koniec będzie wyrazistszy, a duszony razem z daniem łagodniejszy i lżej strawny.'
 where lower(nazwa) in ('czosnek', 'czosnek, surowy');

update skladniki set warto_wiedziec =
  'Zmiel tuż przed podaniem — całe ziarna mają twardą łupinę i przechodzą przez układ pokarmowy prawie niestrawione, a zmielone szybko jełczeją i gorzknieją. Gotowane robi się kleiste, więc do owsianki najlepiej wmieszać je na koniec. Mielone na zapas trzymaj w lodówce, w zamkniętym słoiku.'
 where lower(nazwa) = 'siemię lniane';

update skladniki set warto_wiedziec =
  'Namocz wcześniej, co najmniej 20 minut, w proporcji ok. 1:6 — suche nasiona chłoną płyn i pęcznieją dopiero w środku. Namoczone są łatwiejsze do zjedzenia i nie „zabierają” płynu z dania. W nocnej owsiance moczą się same.'
 where lower(nazwa) in ('nasiona chia', 'chia');

update skladniki set warto_wiedziec =
  'Posyp danie tuż przed podaniem — ma intensywny aromat, który najlepiej czuć na świeżo. W gotowaniu łatwo ją przypalić, a wtedy robi się gorzka. Jeśli chcesz ją podprażyć, rób to krótko, na suchej patelni.'
 where lower(nazwa) = 'czarnuszka';


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select nazwa, left(warto_wiedziec, 60) || '…' as poczatek_uwagi
  from skladniki
 where warto_wiedziec is not null
 order by nazwa;
