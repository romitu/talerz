-- =============================================================================
--  TALERZ — „dni w lodówce” konta Pkondzio takie jak u administratora
-- =============================================================================
--  Po co
--  -----
--  Trwałość dania w lodówce konto widzi jako min(własna, z przepisu):
--    - `przepisy.trwalosc_dni`  — wartość z przepisu (górny limit),
--    - `trwalosc_wlasna`        — własne skrócenie konta (migracja 0040);
--                                  brak wiersza = trzymaj się przepisu.
--
--  Wartościami referencyjnymi są tu ustawienia konta administratora.
--  Skrypt kopiuje je na konto Pkondzio: kasuje wszystkie jego własne
--  wiersze i wstawia kopię wierszy administratora. Tam, gdzie administrator
--  nie ma własnej wartości, Pkondzio też będzie trzymał się przepisu.
--
--  Konta szukane po `konta.rola = 'administrator'` i po adresie e-mail
--  (`konta.email`) — zmień wzorzec niżej, jeśli trzeba.
--
--  Wykonanie: SQL Editor w panelu Supabase. Najpierw krok 1 (podgląd),
--  potem krok 2.
-- =============================================================================

-- --- 1. Podgląd: przepisy, w których wynik się zmieni -----------------------
with admin as (
  select id from konta where rola = 'administrator'
), pk as (
  select id from konta where email ilike '%pkondzio%'
)
select p.nazwa,
       p.trwalosc_dni                                  as z_przepisu,
       least(coalesce(ta.dni, p.trwalosc_dni), p.trwalosc_dni) as administrator,
       least(coalesce(tp.dni, p.trwalosc_dni), p.trwalosc_dni) as pkondzio_teraz
  from przepisy p
  left join trwalosc_wlasna ta on ta.przepis_id = p.id and ta.konto_id in (select id from admin)
  left join trwalosc_wlasna tp on tp.przepis_id = p.id and tp.konto_id in (select id from pk)
 where ta.dni is distinct from tp.dni
 order by p.nazwa;

-- --- 2. Kopia ustawień administratora na konto Pkondzio ---------------------
--  Przerywa, jeśli administratorów albo pasujących kont Pkondzio jest
--  inna liczba niż jeden.
do $$
declare
  ile       integer;
  id_admin  uuid;
  id_pk     uuid;
  usuniete  integer;
  wstawione integer;
begin
  select count(*), min(id::text)::uuid into ile, id_admin
    from konta where rola = 'administrator';
  if ile <> 1 then
    raise exception 'Kont administratora: % — oczekiwano dokładnie jednego.', ile;
  end if;

  select count(*), min(id::text)::uuid into ile, id_pk
    from konta where email ilike '%pkondzio%';
  if ile <> 1 then
    raise exception 'Wzorzec pasuje do % kont — oczekiwano dokładnie jednego.', ile;
  end if;

  delete from trwalosc_wlasna where konto_id = id_pk;
  get diagnostics usuniete = row_count;

  insert into trwalosc_wlasna (przepis_id, konto_id, dni)
  select przepis_id, id_pk, dni
    from trwalosc_wlasna
   where konto_id = id_admin;
  get diagnostics wstawione = row_count;

  raise notice 'Usunięto % własnych wartości Pkondzio, skopiowano % od administratora.',
    usuniete, wstawione;
end $$;
