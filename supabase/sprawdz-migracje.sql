-- =============================================================================
--  TALERZ — sprawdzenie, które migracje zostały wykonane
-- =============================================================================
--  Wklej całość do SQL Editor w Supabase i uruchom.
--  Dostaniesz tabelę: która migracja jest wgrana, a której brakuje.
--
--  Migracje wykonuj PO KOLEI, od najniższego numeru. Każda zakłada, że
--  poprzednia już przeszła.
-- =============================================================================

with sprawdzenia as (
  select
    '0001_schemat_poczatkowy' as migracja,
    'konta, profile, przepisy, skladniki'                            as czego_dotyczy,
    to_regclass('public.konta') is not null                          as wykonana
  union all
  select
    '0002_etapy_przepisu',
    'etapy przepisu z czasami zamiast dwoch workow',
    to_regclass('public.etapy') is not null
  union all
  select
    '0003_pelna_struktura_przepisu',
    'liczba porcji, czasy, sprzet, stan skladnika, zamienniki',
    exists (
      select 1 from information_schema.columns
       where table_name = 'przepisy' and column_name = 'porcje'
    )
  union all
  select
    '0004_blonnik',
    'blonnik w skladnikach i w makro',
    exists (
      select 1 from information_schema.columns
       where table_name = 'skladniki' and column_name = 'blonnik_100g'
    )
  union all
  select
    '0005_cel_blonnika',
    'cel blonnikowy w celach dziennych',
    exists (
      select 1 from information_schema.columns
       where table_name = 'cele' and column_name = 'blonnik_g'
    )
  union all
  select
    '0006_katalog_sprzetu',
    'katalog sprzetu kuchennego do wyboru',
    to_regclass('public.sprzet') is not null
  union all
  select
    '0007_porcjowanie',
    'porcjowanie na wage albo na sztuki',
    exists (
      select 1 from information_schema.columns
       where table_name = 'przepisy' and column_name = 'porcjowanie'
    )
)
select
  migracja,
  case when wykonana then 'TAK' else 'BRAKUJE — wgraj ten plik' end as stan,
  czego_dotyczy
from sprawdzenia
order by migracja;
