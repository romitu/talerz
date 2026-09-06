-- =============================================================================
--  TALERZ — usunięcie poziomu „ulubione”, dodanie ukrywania przepisów
-- =============================================================================
--  Co było
--  -------
--  Trzeci poziom preferencji, „ulubione”, dawał dodatkową premię w automacie
--  wypełniającym plan (`WAGA_ULUBIONE` w `lib/automat.ts`) — miał sprawiać,
--  że dany przepis pojawia się w planie częściej niż zwykłe „lubię”.
--  W praktyce różnica między dwoma stopniami „lubię to” okazała się niepotrzebnie
--  subtelna, a przydałoby się coś zupełnie innego: sposób na schowanie z listy
--  przepisów tych, których już się nie gotuje, bez ich kasowania.
--
--  Co jest teraz
--  -------------
--  * Poziom „ulubione” znika. Wiersze, które go miały, dostają „lubie” —
--    to był i tak silniejszy z dwóch pozytywnych sygnałów, więc nic nikomu
--    nie „pogarsza się” do neutralnego.
--  * Nowa tabela `przepisy_ukryte` — czysty znacznik „to konto nie chce
--    widzieć tego przepisu na liście”. Sama obecność wiersza znaczy „ukryty”,
--    dokładnie jak dawne `polubienia` przed migracją 0025. To osobna sprawa
--    od `preferencje_przepisow`: ukrycie nie zmienia zachowania automatu,
--    tylko czyści listę w zakładce „Przepisy”.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

-- --- 1. „ulubione” → „lubie”, potem nowy typ enum bez tej wartości ----------

update preferencje_przepisow set poziom = 'lubie' where poziom = 'ulubione';

alter type poziom_preferencji rename to poziom_preferencji_stary;
create type poziom_preferencji as enum ('lubie', 'nie_proponuj');

alter table preferencje_przepisow
  alter column poziom type poziom_preferencji
  using poziom::text::poziom_preferencji;

drop type poziom_preferencji_stary;

comment on column preferencje_przepisow.poziom is
  'lubie = chętnie zjem ponownie, nie_proponuj = automat ma to pomijać całkowicie.';

-- --- 2. Ukrywanie przepisów, per konto ---------------------------------------

create table przepisy_ukryte (
  przepis_id  uuid        not null references przepisy (id) on delete cascade,
  konto_id    uuid        not null references konta (id) on delete cascade,
  utworzono   timestamptz not null default now(),
  primary key (przepis_id, konto_id)
);

comment on table przepisy_ukryte is
  'Przepisy schowane z listy przez dane konto — czysto widokowe, nie wpływa na automat wypełniający plan. Brak wiersza = przepis widoczny normalnie.';

alter table przepisy_ukryte enable row level security;

create policy przepisy_ukryte_wlasne on przepisy_ukryte
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select poziom, count(*) as ile from preferencje_przepisow group by poziom order by poziom;
select count(*) as ile_ukrytych from przepisy_ukryte;
