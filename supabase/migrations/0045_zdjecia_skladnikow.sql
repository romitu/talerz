-- =============================================================================
--  TALERZ — zdjęcia składników
-- =============================================================================
--  Zdjęcie przy każdej pozycji listy zakupów. Tak samo jak zdjęcia przepisów
--  (migracja 0016): plik w Supabase Storage, w tabeli sama ścieżka.
--
--  Skąd zdjęcie
--  ------------
--  Część grafik wygenerowało AI, część to zdjęcia własne. Użytkownik musi
--  to widzieć — grafika AI jest poglądowa i nie pokazuje konkretnego
--  produktu ze sklepu. Stąd osobna kolumna `zdjecie_zrodlo`; na liście
--  zakupów zamienia się w znaczek „AI” albo ikonę zdjęcia.
--
--  Nazwa pliku
--  -----------
--  Id składnika + skrót zawartości, np. „3f2a…-9c1e04d2.jpg”. Zmiana nazwy
--  składnika nie gubi zdjęcia, a podmiana zdjęcia daje nową ścieżkę, więc
--  telefon nie pokaże starego obrazka z pamięci podręcznej.
--
--  Kto może wgrywać
--  ----------------
--  Czytać może każdy — zdjęcie cebuli to nie jest dana wrażliwa. Wgrywać
--  i kasować tylko moderator i administrator, jak przy zdjęciach przepisów.
--
--  Wgrywanie hurtowe: narzedzia/wgraj-zdjecia-skladnikow.mjs
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table skladniki
  add column if not exists zdjecie        text,
  add column if not exists zdjecie_zrodlo text;

alter table skladniki drop constraint if exists zdjecie_zrodlo_poprawne;
alter table skladniki add constraint zdjecie_zrodlo_poprawne
  check (
    (zdjecie is null and zdjecie_zrodlo is null)
    or (zdjecie is not null and zdjecie_zrodlo in ('ai', 'wlasne'))
  );

comment on column skladniki.zdjecie is
  'Ścieżka pliku w zasobniku „zdjecia-skladnikow”. Puste = brak zdjęcia. Samego obrazu w bazie NIE trzymamy.';

comment on column skladniki.zdjecie_zrodlo is
  '„ai” = grafika wygenerowana (poglądowa), „wlasne” = zdjęcie zrobione przez użytkownika. Puste tylko razem z pustym zdjęciem.';


-- --- ZASOBNIK NA PLIKI ------------------------------------------------------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values (
  'zdjecia-skladnikow',
  'zdjecia-skladnikow',
  true,
  524288,                                    -- 512 kB; 480×480 JPG waży ok. 70 kB
  array['image/jpeg', 'image/png', 'image/webp']
)
on conflict (id) do update set
  public             = excluded.public,
  file_size_limit    = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;


-- --- KTO CO MOŻE ------------------------------------------------------------
drop policy if exists "zdjecia skladnikow — czyta kazdy"       on storage.objects;
drop policy if exists "zdjecia skladnikow — wgrywa moderator"  on storage.objects;
drop policy if exists "zdjecia skladnikow — zmienia moderator" on storage.objects;
drop policy if exists "zdjecia skladnikow — kasuje moderator"  on storage.objects;

create policy "zdjecia skladnikow — czyta kazdy"
  on storage.objects for select
  using (bucket_id = 'zdjecia-skladnikow');

create policy "zdjecia skladnikow — wgrywa moderator"
  on storage.objects for insert
  with check (bucket_id = 'zdjecia-skladnikow' and czy_moderator());

create policy "zdjecia skladnikow — zmienia moderator"
  on storage.objects for update
  using (bucket_id = 'zdjecia-skladnikow' and czy_moderator())
  with check (bucket_id = 'zdjecia-skladnikow' and czy_moderator());

create policy "zdjecia skladnikow — kasuje moderator"
  on storage.objects for delete
  using (bucket_id = 'zdjecia-skladnikow' and czy_moderator());


-- --- SPRAWDZENIE ------------------------------------------------------------
select id, public, file_size_limit, allowed_mime_types
  from storage.buckets
 where id = 'zdjecia-skladnikow';
