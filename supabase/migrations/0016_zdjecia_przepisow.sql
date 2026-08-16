-- =============================================================================
--  TALERZ — zdjęcia przepisów
-- =============================================================================
--  Gdzie trzymamy pliki
--  --------------------
--  W Supabase Storage, a nie w kolumnie bazy. Stary planer trzymał zdjęcia
--  wprost w Firebase jako tekst — każde po 60 kB zakodowane w base64.
--  Działało, dopóki dań było trzydzieści.
--
--  Trzy powody, żeby zrobić to inaczej:
--
--    1. Base64 puchnie o jedną trzecią. Zdjęcie 60 kB zajmuje 80 kB tekstu.
--    2. Kolumna tekstowa wchodzi do KAŻDEGO zapytania o przepisy. Lista
--       trzydziestu dań pobierałaby 2,5 MB, zanim cokolwiek się wyświetli.
--    3. Storage podaje pliki przez sieć dostarczania treści i umie zrobić
--       miniaturę w locie. Kolumna nie umie nic.
--
--  W tabeli zostaje sama ścieżka do pliku.
--
--  Kto może wgrywać
--  ----------------
--  Czytać może każdy, także niezalogowany — zdjęcie dania to nie jest dana
--  wrażliwa. Wgrywać i kasować tylko moderator i administrator, tak jak przy
--  samych przepisach (plan, sekcja C9).
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table przepisy
  add column if not exists zdjecie text;

comment on column przepisy.zdjecie is
  'Ścieżka pliku w zasobniku „zdjecia-przepisow”, np. „zupa-pomidorowa-z-ryzem.jpg”. Puste = brak zdjęcia. Samego obrazu w bazie NIE trzymamy.';


-- --- ZASOBNIK NA PLIKI ------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'zdjecia-przepisow',
  'zdjecia-przepisow',
  true,
  2097152,                                   -- 2 MB; telefon robi 4 MB, więc zmniejszamy przed wysłaniem
  array['image/jpeg', 'image/png', 'image/webp']
)
on conflict (id) do update set
  public             = excluded.public,
  file_size_limit    = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;


-- --- KTO CO MOŻE ------------------------------------------------------------
--  Zasady zakładamy od nowa przy każdym uruchomieniu, żeby migracja dała się
--  powtórzyć. Bez tego drugie wykonanie kończy się „policy already exists”.

drop policy if exists "zdjecia przepisow — czyta kazdy"      on storage.objects;
drop policy if exists "zdjecia przepisow — wgrywa moderator" on storage.objects;
drop policy if exists "zdjecia przepisow — zmienia moderator" on storage.objects;
drop policy if exists "zdjecia przepisow — kasuje moderator" on storage.objects;

create policy "zdjecia przepisow — czyta kazdy"
  on storage.objects for select
  using (bucket_id = 'zdjecia-przepisow');

create policy "zdjecia przepisow — wgrywa moderator"
  on storage.objects for insert
  with check (bucket_id = 'zdjecia-przepisow' and czy_moderator());

create policy "zdjecia przepisow — zmienia moderator"
  on storage.objects for update
  using (bucket_id = 'zdjecia-przepisow' and czy_moderator())
  with check (bucket_id = 'zdjecia-przepisow' and czy_moderator());

create policy "zdjecia przepisow — kasuje moderator"
  on storage.objects for delete
  using (bucket_id = 'zdjecia-przepisow' and czy_moderator());


-- --- SPRAWDZENIE ------------------------------------------------------------
select id, public, file_size_limit, allowed_mime_types
  from storage.buckets
 where id = 'zdjecia-przepisow';
