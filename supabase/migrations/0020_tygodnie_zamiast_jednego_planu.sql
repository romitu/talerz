-- =============================================================================
--  TALERZ — każdy tydzień osobnym planem
-- =============================================================================
--  Co się zmienia
--  --------------
--  Do tej pory konto miało w praktyce JEDEN plan. Pole „pierwszy dzień planu”
--  nie zakładało nowego tygodnia, tylko przesuwało datę temu jedynemu — więc
--  poprzedni tydzień przestawał istnieć. Nie było się na co powołać przy
--  „wypełnij jak ostatnio” i nie dało się odpowiedzieć na żadne pytanie
--  zaczynające się od „a jak było w zeszłym miesiącu”.
--
--  Sama tabela `plany` od początku dopuszcza wiele wierszy na konto — brakowało
--  tylko jednej rzeczy: pewności, że dwa tygodnie nie zaczną się tego samego
--  dnia. Bez tego „poprzedni tydzień” bywałby niejednoznaczny, a przy dwóch
--  planach na te same daty lista zakupów liczyłaby zakupy z jednego z nich,
--  losowo wybranego.
--
--  Dlatego cała migracja to jeden indeks. Żadnych danych nie ruszamy.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create unique index if not exists plany_konto_data_klucz
  on plany (konto_id, data_start);

comment on index plany_konto_data_klucz is
  'Jeden tydzień na datę startu. Historia planów opiera się na tym, że data jednoznacznie wskazuje tydzień.';


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from pg_indexes where indexname = 'plany_konto_data_klucz')
    as "indeks utworzony (ma byc 1)",
  (select count(*) from plany) as "planow w bazie",
  (select count(distinct data_start) from plany) as "roznych dat startu";
