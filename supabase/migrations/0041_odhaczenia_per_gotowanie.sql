-- =============================================================================
--  TALERZ — odhaczenia zakupów przypisane do gotowania, nie do okna planu
-- =============================================================================
--  Migracja 0038 przypięła odhaczenie do `plan_id`. Okazało się to złym
--  kluczem: plan bywa dowolnej długości i zaczyna się w dowolnym dniu —
--  "Start od" przesuwa datę na TYM SAMYM planie, zamiast zakładać nowy
--  tydzień. Danie ugotowane raz, wciąż jadalne (`partie.wazne_do`), potrafiło
--  więc wypaść z okna planu po samym przesunięciu "Start od" i wrócić na
--  listę zakupów jako "do kupienia", mimo że było już kupione.
--
--  Odhaczenie musi trzymać się GOTOWANIA — konkretnej partii (danie na kilka
--  dni) albo pojedynczej pozycji planu (danie jednodniowe, bez partii) —
--  a nie okna dat czy identyfikatora planu. To przeżywa każdą zmianę planu
--  wokół niego.
--
--  Jak przy migracji 0038: istniejące wiersze kasujemy zamiast migrować —
--  to tylko stan roboczy „co już w koszyku", bez wartości historycznej.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

delete from zakupy_odhaczone;

do $$ begin
  create type zrodlo_odhaczenia as enum ('partia', 'pozycja');
exception
  when duplicate_object then null;
end $$;

alter table zakupy_odhaczone drop constraint if exists zakupy_odhaczone_pkey;
alter table zakupy_odhaczone drop column if exists plan_id;

alter table zakupy_odhaczone
  add column if not exists zrodlo_typ zrodlo_odhaczenia not null,
  add column if not exists zrodlo_id uuid not null;

alter table zakupy_odhaczone add primary key (konto_id, skladnik_id, zrodlo_typ, zrodlo_id);

comment on table zakupy_odhaczone is
  'Co już wrzucone do koszyka, dla KONKRETNEGO gotowania albo posiłku (zrodlo_typ + zrodlo_id) — nie dla całego planu ani okna dat.';

comment on column zakupy_odhaczone.zrodlo_typ is
  'Czy składnik należy do gotowania na kilka dni (partia) czy do pojedynczego posiłku bez partii (pozycja) — patrz zrodlo_id.';

comment on column zakupy_odhaczone.zrodlo_id is
  'id partii albo id plan_pozycje, zależnie od zrodlo_typ. Bez klucza obcego, bo zrodlo_typ decyduje, do której tabeli się odnosi (powiązanie polimorficzne) — a wiersz i tak jest tylko stanem roboczym, patrz komentarz na tabeli.';

-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from information_schema.columns
    where table_name = 'zakupy_odhaczone' and column_name in ('zrodlo_typ', 'zrodlo_id')) as "nowe kolumny (ma być 2)",
  (select count(*) from information_schema.columns
    where table_name = 'zakupy_odhaczone' and column_name = 'plan_id') as "stara kolumna plan_id (ma być 0)",
  (select count(*) from pg_constraint
    where conrelid = 'zakupy_odhaczone'::regclass and contype = 'p'
      and pg_get_constraintdef(oid) like '%zrodlo_typ%') as "klucz głowny ze zrodlo (ma być 1)";
