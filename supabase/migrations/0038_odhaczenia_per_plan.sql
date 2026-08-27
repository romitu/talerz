-- =============================================================================
--  TALERZ — odhaczenia zakupów przypisane do planu
-- =============================================================================
--  Do tej pory `zakupy_odhaczone` miała klucz (konto, składnik) — bez planu.
--  W praktyce psuło to dokładnie ten scenariusz: wyczyść tydzień (albo skasuj
--  plan) i wygeneruj taki sam od nowa → te same składniki → stare ptaszki
--  „ożywały" na nowej liście, choć nikt ich jeszcze nie odhaczył dla NOWEGO
--  planu. Odhaczenie musi więc być przypisane do planu, nie tylko do konta.
--
--  Istniejące wiersze kasujemy zamiast migrować — to tylko „co już wrzucone
--  do koszyka", stan roboczy bez wartości historycznej, i nie da się ich
--  jednoznacznie przypisać do planu (składnik mógł wystąpić w wielu tygodniach).
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

delete from zakupy_odhaczone;

alter table zakupy_odhaczone
  add column if not exists plan_id uuid references plany (id) on delete cascade;

alter table zakupy_odhaczone
  alter column plan_id set not null;

alter table zakupy_odhaczone drop constraint if exists zakupy_odhaczone_pkey;
alter table zakupy_odhaczone add primary key (konto_id, plan_id, skladnik_id);

comment on table zakupy_odhaczone is
  'Co już wrzucone do koszyka, dla KONKRETNEGO planu. Kasowane jednym ruchem przy rozpoczęciu nowych zakupów albo przy czyszczeniu tygodnia.';

comment on column zakupy_odhaczone.plan_id is
  'Bez tego to samo danie w nowo wygenerowanym, identycznym planie wracało jako już kupione — ptaszek jest właściwością tygodnia, nie konta.';

-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from information_schema.columns
    where table_name = 'zakupy_odhaczone' and column_name = 'plan_id') as "kolumna plan_id (ma być 1)",
  (select count(*) from pg_constraint
    where conrelid = 'zakupy_odhaczone'::regclass and contype = 'p'
      and pg_get_constraintdef(oid) like '%plan_id%') as "klucz glowny z plan_id (ma być 1)";
