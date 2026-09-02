-- =============================================================================
--  TALERZ — sprawdzenie, które migracje zostały wykonane
-- =============================================================================
--  Wklej całość do SQL Editor w Supabase i uruchom.
--  Dostaniesz tabelę: która migracja jest wgrana, a której brakuje.
--
--  Migracje wykonuj PO KOLEI, od najniższego numeru. Każda zakłada, że
--  poprzednia już przeszła.
--
--  Migracje 0012 i 0017 tylko wypełniają puste pola danymi (nie dodają
--  kolumn ani tabel), a 0030 dodaje kolumnę, którą migracje 0033/0034
--  i tak później usuwają — żadna z tych trzech nie zostawia trwałego śladu
--  do sprawdzenia automatem, więc nie ma ich w tej liście. Uruchom je
--  ręcznie, jeśli baza pochodzi z importu sprzed tych migracji.
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
  union all
  select
    '0008_sztuki',
    'sztuki jako jednostka skladnika',
    exists (
      select 1 from information_schema.columns
       where table_name = 'skladniki' and column_name = 'masa_sztuki_g'
    )
  union all
  select
    '0009_kilka_dan_w_posilku',
    'kilka dan w jednym posilku, kolejnosc w planie',
    exists (
      select 1 from information_schema.columns
       where table_name = 'plan_pozycje' and column_name = 'kolejnosc'
    )
  union all
  select
    '0010_prog_bialka',
    'prog bialka na posilek oddzielony od celu dziennego',
    exists (
      select 1 from information_schema.columns
       where table_name = 'cele' and column_name = 'prog_bialka_posilek'
    )
  union all
  select
    '0011_sprzet_bez_powtorek',
    'sprzet bez powtorek (case-insensitive)',
    not exists (
      select 1 from pg_constraint where conname = 'sprzet_nazwa_key'
    )
  union all
  select
    '0013_danie_bez_gotowania',
    'czas_obrobki_min moze byc zero',
    exists (
      select 1 from pg_constraint
       where conname = 'przepisy_czas_obrobki_min_check'
         and pg_get_constraintdef(oid) like '%>= 0%'
    )
  union all
  select
    '0014_dodatki',
    'dodatek jako czwarta kategoria przepisu',
    'dodatek' = any (enum_range(null::pora_posilku)::text[])
  union all
  select
    '0015_dodatek_nie_jest_pora',
    'dodatek nie jest pora posilku w planie',
    exists (
      select 1 from pg_constraint where conname = 'plan_pozycje_pora_to_pora_dnia'
    )
  union all
  select
    '0016_zdjecia_przepisow',
    'zdjecia przepisow w Storage',
    exists (
      select 1 from information_schema.columns
       where table_name = 'przepisy' and column_name = 'zdjecie'
    )
  union all
  select
    '0018_nazwa_przepisu_niepowtarzalna',
    'nazwa przepisu niepowtarzalna (bez wzgledu na wielkosc liter)',
    exists (
      select 1 from pg_indexes where indexname = 'przepisy_nazwa_klucz'
    )
  union all
  select
    '0019_zakupy_reczne',
    'produkty dopisywane recznie i trwale odhaczenia',
    to_regclass('public.zakupy_reczne') is not null
  union all
  select
    '0020_tygodnie_zamiast_jednego_planu',
    'kazdy tydzien osobnym planem',
    exists (
      select 1 from pg_indexes where indexname = 'plany_konto_data_klucz'
    )
  union all
  select
    '0021_ochrona_roli_konta',
    'nikt nie awansuje sie sam (wyzwalacz na konta.rola)',
    exists (
      select 1 from pg_trigger where tgname = 'konta_ochrona_roli'
    )
  union all
  select
    '0022_obieg_publikacji',
    'obieg publikacji przepisu (zgloszona/publiczna)',
    exists (
      select 1 from information_schema.columns
       where table_name = 'przepisy' and column_name = 'zgloszono_kiedy'
    )
  union all
  select
    '0023_konta_nieaktywne',
    'konta wylaczane zamiast kasowanych',
    exists (
      select 1 from information_schema.columns
       where table_name = 'konta' and column_name = 'aktywne'
    )
  union all
  select
    '0024_nadawanie_roli_moderatora',
    'administrator mianuje moderatorow z aplikacji',
    exists (
      select 1 from pg_proc
       where proname = 'konta_chron_role'
         and pg_get_functiondef(oid) like '%czy_administrator%'
    )
  union all
  select
    '0025_preferencje_przepisow',
    'poziomy preferencji zamiast binarnego polubienia',
    to_regclass('public.preferencje_przepisow') is not null
  union all
  select
    '0026_cel_liczony_na_biezaco',
    'cel kaloryczny liczony na biezaco, nie zapisany na sztywno',
    exists (
      select 1 from information_schema.columns
       where table_name = 'cele' and column_name = 'tryb'
    )
  union all
  select
    '0027_aktywnosc_nasem',
    'poziom aktywnosci wg czterech kategorii NASEM',
    -- Migracja na koniec przemianowuje typ z powrotem na `poziom_aktywnosci`,
    -- wiec po jej wykonaniu nie da sie po nazwie typu odroznic starej wersji
    -- od nowej — sprawdzamy zamiast tego, czy enum ma nowe (czteroelementowe)
    -- wartosci zamiast starych pieciu.
    'nieaktywny' = any (enum_range(null::poziom_aktywnosci)::text[])
  union all
  select
    '0028_moderator_usuwa_przepisy',
    'moderator moze usuwac przepisy, nie tylko administrator',
    exists (
      select 1 from pg_policy where polname = 'przepisy_usuwanie_moderator'
    )
  union all
  select
    '0029_liczba_porcji_bazowych',
    'liczba porcji bazowych',
    exists (
      select 1 from information_schema.columns
       where table_name = 'przepisy' and column_name = 'liczba_porcji_bazowych'
    )
  union all
  -- 0030_domyslna_kwantyzacja pominieta: kolumne, ktora dodawala, usuwaja
  -- migracje 0033 i 0034, wiec po ich wykonaniu nie zostaje po niej zaden
  -- slad do sprawdzenia — tak samo jak 0012 i 0017.
  select
    '0031_role_skladnikow',
    'katalog rol skladnikow przy skalowaniu porcji',
    to_regclass('public.role_skladnikow') is not null
  union all
  select
    '0032_rola_skladnika',
    'rola skladnika przy skalowaniu porcji',
    exists (
      select 1 from information_schema.columns
       where table_name = 'skladniki' and column_name = 'rola'
    )
  union all
  select
    '0033_usun_jednostke_dk',
    'usuniecie kolumny "Jednostka - DK"',
    not exists (
      select 1 from information_schema.columns
       where table_name = 'skladniki' and column_name = 'jednostka_dk'
    )
  union all
  select
    '0034_mozna_dzielic',
    '"kwant." jako wybor tak/nie zamiast liczby',
    exists (
      select 1 from information_schema.columns
       where table_name = 'skladniki' and column_name = 'mozna_dzielic'
    )
  union all
  select
    '0035_rola_kwant_przepis_skladniki',
    'rola i kwantyzacja na poziomie przepisu',
    exists (
      select 1 from information_schema.columns
       where table_name = 'przepis_skladniki' and column_name = 'rola'
    )
  union all
  select
    '0036_przepisy_skalowane',
    'przepisy skalowane kalorycznie',
    to_regclass('public.przepisy_skalowane') is not null
  union all
  select
    '0037_skladniki_dodawanie_uzytkownika',
    'kazdy uzytkownik moze dopisac skladnik',
    exists (
      select 1 from pg_policy where polname = 'skladniki_wstawianie'
    )
  union all
  select
    '0038_odhaczenia_per_plan',
    'odhaczenia zakupow przypisane do planu',
    exists (
      select 1 from information_schema.columns
       where table_name = 'zakupy_odhaczone' and column_name = 'plan_id'
    )
  union all
  select
    '0039_limit_czterech_profili',
    'limit profili na koncie podniesiony z 3 do 4',
    exists (
      select 1 from pg_proc
       where proname = 'sprawdz_profil'
         and pg_get_functiondef(oid) like '%liczba_profili >= 4%'
    )
  union all
  select
    '0040_trwalosc_wlasna',
    'wlasna (per-konto) trwalosc dania w lodowce',
    to_regclass('public.trwalosc_wlasna') is not null
)
select
  migracja,
  case when wykonana then 'TAK' else 'BRAKUJE — wgraj ten plik' end as stan,
  czego_dotyczy
from sprawdzenia
order by migracja;
