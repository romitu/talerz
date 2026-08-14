-- =============================================================================
--  TALERZ — pełna struktura przepisu
-- =============================================================================
--  Uzupełnienie modelu o elementy, których wymaga poprawnie napisany przepis:
--
--    1. Metadane      — liczba porcji, czas przygotowania osobno od obróbki, sprzęt
--    2. Składniki     — stan (obrana, starta), zamienniki, jednostka g albo ml
--    3. Kroki         — sygnał wizualny („aż cebula się zeszkli”)
--    4. Podsumowanie  — przechowywanie, mrożenie, ratowanie dania
--
--  Najważniejsza zmiana: LICZBA PORCJI.
--  Bez niej makro liczyło się z całego garnka. Przepis na sześć porcji
--  pokazywałby 3000 kcal jako wartość posiłku — i tak trafiłby do planu dnia.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================


-- =============================================================================
--  1. METADANE PRZEPISU
-- =============================================================================

alter table przepisy
  add column porcje                smallint not null default 1 check (porcje between 1 and 30),
  add column czas_przygotowania_min smallint check (czas_przygotowania_min > 0 and czas_przygotowania_min <= 1440),
  add column czas_obrobki_min       smallint check (czas_obrobki_min > 0 and czas_obrobki_min <= 1440),
  add column sprzet                 text[]   not null default '{}',
  add column przechowywanie         text,
  add column mozna_mrozic           boolean,
  add column ratunek                text;

comment on column przepisy.porcje is
  'Ile porcji wychodzi z całego przepisu. Podstawa przeliczenia makro na jedną porcję.';

comment on column przepisy.czas_przygotowania_min is
  'Krojenie, tarcie, odmierzanie — praca przy blacie.';

comment on column przepisy.czas_obrobki_min is
  'Gotowanie, pieczenie, smażenie — czas przy garnku i piekarniku.';

comment on column przepisy.sprzet is
  'Wykaz narzędzi, np. {"garnek 3 l","tarka o grubych oczkach","patelnia"}. Zapobiega szukaniu blendera w połowie gotowania.';

comment on column przepisy.przechowywanie is
  'Uzupełnienie pola trwalosc_dni o wskazówki: w czym trzymać, czy odgrzewać pod przykryciem.';

comment on column przepisy.ratunek is
  'Co zrobić, gdy danie wyjdzie za słone, za kwaśne albo zbyt rzadkie.';

-- Dotychczasowa kolumna z jednym czasem przestaje być potrzebna —
-- czas wynika z etapów, a metadane rozbijają go na przygotowanie i obróbkę.
alter table przepisy drop column if exists czas_minut;


-- =============================================================================
--  2. SKŁADNIKI: STAN, ZAMIENNIKI, JEDNOSTKA
-- =============================================================================

create type jednostka_miary as enum ('g', 'ml');

alter table przepis_skladniki
  add column stan       text,
  add column zamiennik  text,
  add column jednostka  jednostka_miary not null default 'g';

comment on column przepis_skladniki.stan is
  'W jakiej postaci składnik wchodzi do dania: „obrana i starta”, „w temperaturze pokojowej”, „posiekany drobno”.';

comment on column przepis_skladniki.zamiennik is
  'Dopuszczalna alternatywa, np. „lub korpus z kurczaka”. Podana przy składniku, a nie w osobnej sekcji.';

comment on column przepis_skladniki.jednostka is
  'Gramy albo mililitry. Wartości odżywcze liczymy zawsze z pola gramy — przy płynach przyjmujemy gęstość zbliżoną do wody.';


-- =============================================================================
--  3. KROKI: SYGNAŁ WIZUALNY
-- =============================================================================

alter table kroki add column sygnal text;

comment on column kroki.sygnal is
  'Po czym poznać, że krok się udał: „aż cebula się zeszkli”, „aż ziemniaki będą miękkie”. Czas bywa mylący, wygląd nie.';


-- =============================================================================
--  4. MAKRO NA PORCJĘ
-- =============================================================================
--  Widok przelicza teraz wartości zarówno dla całego przepisu, jak i dla
--  jednej porcji. Aplikacja pokazuje porcję — bo to ją się je.
-- =============================================================================

drop view if exists przepis_makro;

create view przepis_makro as
select
  p.id                                                                as przepis_id,
  p.porcje,

  -- całe danie
  round(sum(ps.gramy * s.kcal_100g        / 100.0))::integer          as kcal_calosc,
  round(sum(ps.gramy * s.bialko_100g      / 100.0), 1)                as bialko_g_calosc,
  round(sum(ps.gramy * s.tluszcz_100g     / 100.0), 1)                as tluszcz_g_calosc,
  round(sum(ps.gramy * s.wegle_100g       / 100.0), 1)                as wegle_g_calosc,
  round(sum(ps.gramy * s.cukry_wolne_100g / 100.0), 1)                as cukry_wolne_g_calosc,

  -- jedna porcja
  round(sum(ps.gramy * s.kcal_100g        / 100.0) / p.porcje)::integer    as kcal,
  round(sum(ps.gramy * s.bialko_100g      / 100.0) / p.porcje, 1)          as bialko_g,
  round(sum(ps.gramy * s.tluszcz_100g     / 100.0) / p.porcje, 1)          as tluszcz_g,
  round(sum(ps.gramy * s.wegle_100g       / 100.0) / p.porcje, 1)          as wegle_g,
  round(sum(ps.gramy * s.cukry_wolne_100g / 100.0) / p.porcje, 1)          as cukry_wolne_g,

  round(sum(ps.gramy) / p.porcje)::integer                            as gramy_porcji,
  max(s.nova)                                                         as nova_max
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join skladniki s          on s.id = ps.skladnik_id
group by p.id, p.porcje;

comment on view przepis_makro is
  'Makro wyliczane ze składników. Kolumny bez przyrostka dotyczą JEDNEJ PORCJI — bo to ona trafia na talerz. Wartości całego garnka mają przyrostek _calosc.';
