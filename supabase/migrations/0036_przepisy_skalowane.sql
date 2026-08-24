-- =============================================================================
--  TALERZ — przepisy skalowane kalorycznie
-- =============================================================================
--  Niektóre przepisy (sałatka, kanapka „na kromkę") mają z założenia elastyczną
--  wielkość — dokładamy ich tyle, ile trzeba, żeby dobić do celu kalorycznego
--  posiłku. Silnik liczący to skalowanie żyje w kodzie (`lib/skalowanie-kalorii.ts`),
--  tutaj jest tylko miejsce, żeby wynik ZAPISAĆ, nie dotykając przepisu źródłowego.
--
--  Trzy elementy:
--
--    przepisy.skalowalny        — checkbox na przepisie: wolno go tak skalować?
--                                  Domyślnie NIE — automat dostaje jawną zgodę,
--                                  a nie zgaduje po kategorii czy nazwie.
--
--    przepisy_skalowane         — jeden wiersz na jeden wynik skalowania:
--                                  KONKRETNY wariant KONKRETNEGO przepisu, dla
--                                  jednego celu kalorycznego. Przepis źródłowy
--                                  zostaje nietknięty — to świadomie ODDZIELNY
--                                  byt, tak jak `partie` jest oddzielne od
--                                  `przepisy`. Ma to znaczenie na przyszłość:
--                                  kilka kont (2-3 osoby) będzie mogło mieć
--                                  różne warianty tego samego przepisu obok
--                                  siebie, każdy pod swój cel.
--
--    przepisy_skalowane_skladniki — zrzut ilości KAŻDEGO składnika po
--                                  przeliczeniu i zaokrągleniu — dokładnie to,
--                                  co liczy `przeskalujPrzepis`. Bez tego lista
--                                  zakupów widziałaby tylko mnożnik, nie realne
--                                  gramatury.
--
--  Makro liczy się tak samo jak wszędzie: NIGDY nie wpisujemy go ręcznie,
--  zawsze wynika ze składników — stąd widok `przepis_skalowany_makro`,
--  odpowiednik `przepis_makro` (migracja 0007) dla wariantów skalowanych.
--
--  `plan_pozycje.przepis_skalowany_id` pozwala pozycji planu wskazać: „makro
--  tego posiłku licz z TEGO WARIANTU, nie z przepisu źródłowego". `przepis_id`
--  zostaje ustawione jak dotąd (na przepis źródłowy) — dzięki temu kategoria,
--  preferencje i reszta logiki działają bez zmian, a scalanie dopisuje się
--  tylko tam, gdzie faktycznie jest potrzebne.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table przepisy
  add column skalowalny boolean not null default false;

comment on column przepisy.skalowalny is
  'Czy automat wolno automatycznie skalować kalorycznie ten przepis przy wypełnianiu planu (np. sałatka/kanapka "na kromkę"). Domyślnie nie.';


create table przepisy_skalowane (
  id                    uuid          primary key default gen_random_uuid(),
  konto_id              uuid          not null references konta (id) on delete cascade,
  przepis_zrodlowy_id   uuid          not null references przepisy (id) on delete restrict,
  wspolczynnik_k        numeric(5,3)  not null check (wspolczynnik_k > 0),
  cel_kcal              integer       not null check (cel_kcal > 0),
  utworzono             timestamptz   not null default now()
);

comment on table przepisy_skalowane is
  'Jeden konkretny wynik skalowania kalorycznego przepisu źródłowego — osobny byt, przepis w katalogu zostaje nietknięty.';

comment on column przepisy_skalowane.wspolczynnik_k is
  'Współczynnik k dobrany przez lib/skalowanie-kalorii.ts — informacyjny, makro liczy się ze składników poniżej, nie z niego.';

create index przepisy_skalowane_zrodlo_idx on przepisy_skalowane (przepis_zrodlowy_id);

alter table przepisy_skalowane enable row level security;

create policy przepisy_skalowane_wlasne on przepisy_skalowane
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());


create table przepisy_skalowane_skladniki (
  id                     uuid          primary key default gen_random_uuid(),
  przepis_skalowany_id   uuid          not null references przepisy_skalowane (id) on delete cascade,
  skladnik_id            uuid          not null references skladniki (id) on delete restrict,
  ilosc                  numeric       not null check (ilosc >= 0),
  jednostka              jednostka_miary not null,
  gramy                  numeric(8, 2) not null check (gramy >= 0)
);

comment on column przepisy_skalowane_skladniki.ilosc is
  'Ilość PO przeskalowaniu i ewentualnym zaokrągleniu (gdy skladniki.mozna_dzielic = false).';

create index przepisy_skalowane_skladniki_idx on przepisy_skalowane_skladniki (przepis_skalowany_id);

alter table przepisy_skalowane_skladniki enable row level security;

create policy przepisy_skalowane_skladniki_wlasne on przepisy_skalowane_skladniki
  for all using (
    exists (
      select 1 from przepisy_skalowane ps
      where ps.id = przepisy_skalowane_skladniki.przepis_skalowany_id and ps.konto_id = auth.uid()
    )
  )
  with check (
    exists (
      select 1 from przepisy_skalowane ps
      where ps.id = przepisy_skalowane_skladniki.przepis_skalowany_id and ps.konto_id = auth.uid()
    )
  );


-- Odpowiednik przepis_makro (migracja 0007) dla wariantów skalowanych. Wariant
-- reprezentuje JEDEN posiłek (tyle, ile potrzeba na zamknięcie celu kalorycznego
-- tego miejsca w planie) — bez dzielenia przez liczbę porcji, w przeciwieństwie
-- do przepis_makro.
create view przepis_skalowany_makro as
select
  psk.przepis_skalowany_id                                          as przepis_skalowany_id,
  round(sum(psk.gramy), 1)                                          as gramy_porcji,
  round(sum(psk.gramy * s.kcal_100g        / 100.0))::integer       as kcal,
  round(sum(psk.gramy * s.bialko_100g      / 100.0), 1)             as bialko_g,
  round(sum(psk.gramy * s.tluszcz_100g     / 100.0), 1)             as tluszcz_g,
  round(sum(psk.gramy * s.wegle_100g       / 100.0), 1)             as wegle_g,
  round(sum(psk.gramy * s.blonnik_100g     / 100.0), 1)             as blonnik_g
from przepisy_skalowane_skladniki psk
join skladniki s on s.id = psk.skladnik_id
group by psk.przepis_skalowany_id;


alter table plan_pozycje
  add column przepis_skalowany_id uuid references przepisy_skalowane (id) on delete restrict;

comment on column plan_pozycje.przepis_skalowany_id is
  'Gdy ustawione, makro tej pozycji liczy się z przepis_skalowany_makro (konkretny przeskalowany wariant), a nie z przepis_makro przepisu źródłowego. przepis_id nadal wskazuje przepis źródłowy.';

notify pgrst, 'reload schema';
