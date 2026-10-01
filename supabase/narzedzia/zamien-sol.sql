-- =============================================================================
--  TALERZ — „Sól kuchenna” zamieniona na „Sól kłodawska” we wszystkich daniach
-- =============================================================================
--  Przepina składnik we wszystkich tabelach, które go używają:
--    przepis_skladniki, przepisy_skalowane_skladniki, wersje_skladniki,
--    zakupy_odhaczone.
--
--  Ilości i gramy zostają bez zmian — oba składniki mają masę sztuki 1 g.
--  Gdyby danie miało już obie sole, ilości są sumowane w jeden wiersz
--  (przepis_skladniki i wersje_skladniki pozwalają na jeden wiersz na składnik).
--
--  Składnik „Sól kuchenna” zostaje w katalogu — tylko nic go już nie używa.
--
--  Wykonanie: SQL Editor w panelu Supabase. Całość to jedna transakcja.
-- =============================================================================

begin;

-- Bez obu składników nie ma czego zamieniać — rzutowanie przerywa skrypt
-- z czytelnym komunikatem (ten sam sposób co w import-przepisow-ai.sql).
select ('ZAMIANA PRZERWANA — ' || string_agg('brak składnika „' || n || '”', '; '))::int as sprawdzenie
  from unnest(array['Sól kuchenna', 'Sól kłodawska']) as n
 where not exists (select 1 from skladniki where nazwa = n);

create temp table sol on commit drop as
select (select id from skladniki where nazwa = 'Sól kuchenna')  as stara,
       (select id from skladniki where nazwa = 'Sól kłodawska') as nowa;

-- --- przepis_skladniki -------------------------------------------------------
update przepis_skladniki n
   set ilosc = n.ilosc + s.ilosc,
       gramy = n.gramy + s.gramy
  from przepis_skladniki s, sol
 where s.skladnik_id = sol.stara and n.skladnik_id = sol.nowa and n.przepis_id = s.przepis_id;

delete from przepis_skladniki s using sol
 where s.skladnik_id = sol.stara
   and exists (select 1 from przepis_skladniki n where n.przepis_id = s.przepis_id and n.skladnik_id = sol.nowa);

update przepis_skladniki set skladnik_id = sol.nowa from sol where skladnik_id = sol.stara;

-- --- przepisy_skalowane_skladniki (bez ograniczenia unikalności) ------------
update przepisy_skalowane_skladniki set skladnik_id = sol.nowa from sol where skladnik_id = sol.stara;

-- --- wersje_skladniki --------------------------------------------------------
update wersje_skladniki n
   set gramy = n.gramy + s.gramy
  from wersje_skladniki s, sol
 where s.skladnik_id = sol.stara and n.skladnik_id = sol.nowa and n.wersja_id = s.wersja_id;

delete from wersje_skladniki s using sol
 where s.skladnik_id = sol.stara
   and exists (select 1 from wersje_skladniki n where n.wersja_id = s.wersja_id and n.skladnik_id = sol.nowa);

update wersje_skladniki set skladnik_id = sol.nowa from sol where skladnik_id = sol.stara;

-- --- zakupy_odhaczone (stan roboczy listy zakupów) ---------------------------
delete from zakupy_odhaczone s using sol
 where s.skladnik_id = sol.stara
   and exists (select 1 from zakupy_odhaczone n
                where n.konto_id = s.konto_id and n.zrodlo_typ = s.zrodlo_typ
                  and n.zrodlo_id = s.zrodlo_id and n.skladnik_id = sol.nowa);

update zakupy_odhaczone set skladnik_id = sol.nowa from sol where skladnik_id = sol.stara;

commit;

-- =============================================================================
--  SPRAWDZENIE — „Sól kuchenna” ma mieć wszędzie 0.
-- =============================================================================
select s.nazwa,
       (select count(*) from przepis_skladniki x            where x.skladnik_id = s.id) as przepisy,
       (select count(*) from przepisy_skalowane_skladniki x where x.skladnik_id = s.id) as warianty_skalowane,
       (select count(*) from wersje_skladniki x             where x.skladnik_id = s.id) as wersje,
       (select count(*) from zakupy_odhaczone x             where x.skladnik_id = s.id) as odhaczenia
  from skladniki s
 where s.nazwa in ('Sól kuchenna', 'Sól kłodawska')
 order by s.nazwa;
