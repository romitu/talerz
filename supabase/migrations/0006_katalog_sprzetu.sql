-- =============================================================================
--  TALERZ — katalog sprzętu kuchennego
-- =============================================================================
--  Sprzęt przy przepisie był dotąd zwykłym tekstem wpisywanym po przecinku.
--  Prowadziło to do rozjazdu nazw: „garnek 3l”, „garnek 3 l”, „Garnek 3L”
--  to dla bazy trzy różne rzeczy, więc nie dałoby się po nich filtrować.
--
--  Teraz sprzęt wybiera się z katalogu, tak samo jak składniki: tabela
--  z filtrem i znakiem plus. Kolumna przepisy.sprzet nadal przechowuje nazwy,
--  więc przepis pozostaje czytelny bez łączenia tabel.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create table sprzet (
  id         uuid        primary key default gen_random_uuid(),
  nazwa      text        not null unique check (length(trim(nazwa)) between 2 and 80),
  rodzaj     text        not null default 'inne',
  utworzono  timestamptz not null default now()
);

comment on table sprzet is
  'Katalog narzędzi kuchennych do wyboru przy przepisie. Zapobiega rozjazdowi nazw.';

comment on column sprzet.rodzaj is
  'Grupa do filtrowania: naczynia, urzadzenia, narzedzia, inne.';

create index sprzet_nazwa_idx on sprzet (lower(nazwa));

alter table sprzet enable row level security;

create policy sprzet_odczyt on sprzet
  for select using (auth.uid() is not null);

create policy sprzet_zapis on sprzet
  for all using (czy_moderator()) with check (czy_moderator());


-- =============================================================================
--  ZAWARTOŚĆ POCZĄTKOWA
-- =============================================================================
--  Najczęstszy sprzęt w kuchni śródziemnomorskiej i przy gotowaniu na zapas.
--  Resztę dopiszesz w aplikacji.
-- =============================================================================

insert into sprzet (nazwa, rodzaj) values
  ('Garnek 2 l',                  'naczynia'),
  ('Garnek 3 l',                  'naczynia'),
  ('Garnek 5 l',                  'naczynia'),
  ('Garnek ciśnieniowy',          'urzadzenia'),
  ('Patelnia 24 cm',              'naczynia'),
  ('Patelnia 28 cm',              'naczynia'),
  ('Rondel',                      'naczynia'),
  ('Blacha do pieczenia',         'naczynia'),
  ('Naczynie żaroodporne',        'naczynia'),
  ('Piekarnik',                   'urzadzenia'),
  ('Grill kontaktowy',            'urzadzenia'),
  ('Blender kielichowy',          'urzadzenia'),
  ('Blender ręczny',              'urzadzenia'),
  ('Robot kuchenny',              'urzadzenia'),
  ('Waga kuchenna',               'narzedzia'),
  ('Tarka o grubych oczkach',     'narzedzia'),
  ('Tarka o drobnych oczkach',    'narzedzia'),
  ('Deska do krojenia',           'narzedzia'),
  ('Nóż szefa kuchni',            'narzedzia'),
  ('Obieraczka',                  'narzedzia'),
  ('Sitko',                       'narzedzia'),
  ('Durszlak',                    'narzedzia'),
  ('Chochla',                     'narzedzia'),
  ('Termometr do mięsa',          'narzedzia'),
  ('Pojemniki do przechowywania', 'narzedzia');
