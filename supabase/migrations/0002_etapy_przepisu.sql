-- =============================================================================
--  TALERZ — etapy przepisu
-- =============================================================================
--  Powód zmiany
--  ------------
--  Pierwotnie kroki dzieliły się na dwa sztywne worki: „przygotowanie”
--  i „wykonanie”. Prawdziwe przepisy tak nie wyglądają. Zupa ogórkowa ma
--  pięć etapów, każdy z własnym czasem:
--
--      1. Gotowanie wywaru            45 min
--      2. Dodanie warzyw i ziemniaków 15 min
--      3. Podsmażanie ogórków         10 min
--      4. Łączenie składników          5 min
--      5. Zabielanie                   2 min
--
--  Etapy nakładają się w czasie („w międzyczasie rozpuść masło”), mają nazwy
--  i mierzalny czas. Dwa worki tego nie wyrażą.
--
--  Nowa struktura
--  --------------
--      etapy         — nazwa, kolejność, czas
--      kroki         — należą do etapu, mogą być oznaczone jako uwaga
--      czasy_sprzet  — przeniesione z kroku na etap (gotowanie trwa inaczej
--                      w garnku ciśnieniowym niż na płycie)
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================


-- =============================================================================
--  1. NOWA TABELA ETAPÓW
-- =============================================================================

create table etapy (
  id          uuid     primary key default gen_random_uuid(),
  przepis_id  uuid     not null references przepisy (id) on delete cascade,
  kolejnosc   smallint not null,
  nazwa       text     not null check (length(trim(nazwa)) between 2 and 120),
  minuty      smallint check (minuty > 0 and minuty <= 1440),
  unique (przepis_id, kolejnosc)
);

comment on table etapy is
  'Etap przygotowania dania: nazwa, kolejność i czas. Suma czasów daje czas całego przepisu.';

comment on column etapy.minuty is
  'Czas etapu. Etapy mogą się nakładać („w międzyczasie”), więc suma jest szacunkiem górnym.';

create index etapy_przepis_idx on etapy (przepis_id, kolejnosc);

alter table etapy enable row level security;

create policy etapy_odczyt on etapy
  for select using (
    exists (
      select 1 from przepisy p
       where p.id = etapy.przepis_id
         and (p.widocznosc = 'publiczna' or p.autor_id = auth.uid() or czy_moderator())
    )
  );

create policy etapy_zapis on etapy
  for all
  using (
    czy_moderator()
    or exists (
      select 1 from przepisy p
       where p.id = etapy.przepis_id and p.autor_id = auth.uid() and p.widocznosc = 'prywatna'
    )
  )
  with check (
    czy_moderator()
    or exists (
      select 1 from przepisy p
       where p.id = etapy.przepis_id and p.autor_id = auth.uid() and p.widocznosc = 'prywatna'
    )
  );


-- =============================================================================
--  2. PRZENIESIENIE ISTNIEJĄCYCH KROKÓW DO ETAPÓW
-- =============================================================================
--  Dla przepisów, które już mają kroki, tworzymy etapy odpowiadające
--  dotychczasowemu podziałowi. Nic nie ginie.
-- =============================================================================

insert into etapy (przepis_id, kolejnosc, nazwa)
select distinct
  k.przepis_id,
  case k.etap when 'przygotowanie' then 1 else 2 end,
  case k.etap when 'przygotowanie' then 'Przygotowanie' else 'Wykonanie' end
from kroki k;


-- =============================================================================
--  3. PRZEBUDOWA TABELI KROKÓW
-- =============================================================================

alter table kroki add column etap_id uuid references etapy (id) on delete cascade;
alter table kroki add column uwaga boolean not null default false;

comment on column kroki.uwaga is
  'Krok oznaczony jako uwaga — wyświetlany z wyróżnieniem, np. „Ziemniaki muszą być miękkie przed dodaniem ogórków”.';

update kroki k
   set etap_id = e.id
  from etapy e
 where e.przepis_id = k.przepis_id
   and e.nazwa = case k.etap when 'przygotowanie' then 'Przygotowanie' else 'Wykonanie' end;

-- KOLEJNOŚĆ MA ZNACZENIE.
-- PostgreSQL nie pozwoli usunąć kolumny, od której zależy reguła dostępu.
-- Najpierw znika stara tabela czasów (jej reguła sięgała do kroki.przepis_id),
-- potem reguły na krokach, a dopiero na końcu same kolumny.
drop table if exists czasy_sprzet;

drop policy if exists kroki_odczyt on kroki;
drop policy if exists kroki_zapis on kroki;

alter table kroki drop constraint if exists kroki_przepis_id_etap_kolejnosc_key;
drop index if exists kroki_przepis_idx;

alter table kroki drop column etap;
alter table kroki drop column przepis_id;

alter table kroki alter column etap_id set not null;
alter table kroki add constraint kroki_etap_kolejnosc_klucz unique (etap_id, kolejnosc);

create index kroki_etap_idx on kroki (etap_id, kolejnosc);

-- Reguły dostępu opierają się teraz na etapie, a nie wprost na przepisie.
create policy kroki_odczyt on kroki
  for select using (
    exists (
      select 1 from etapy e join przepisy p on p.id = e.przepis_id
       where e.id = kroki.etap_id
         and (p.widocznosc = 'publiczna' or p.autor_id = auth.uid() or czy_moderator())
    )
  );

create policy kroki_zapis on kroki
  for all
  using (
    exists (
      select 1 from etapy e join przepisy p on p.id = e.przepis_id
       where e.id = kroki.etap_id
         and (czy_moderator() or (p.autor_id = auth.uid() and p.widocznosc = 'prywatna'))
    )
  )
  with check (
    exists (
      select 1 from etapy e join przepisy p on p.id = e.przepis_id
       where e.id = kroki.etap_id
         and (czy_moderator() or (p.autor_id = auth.uid() and p.widocznosc = 'prywatna'))
    )
  );


-- =============================================================================
--  4. CZASY SPRZĘTU PRZENIESIONE Z KROKU NA ETAP
-- =============================================================================
--  „Gotowanie wywaru: 45 minut w garnku, 15 minut pod ciśnieniem” dotyczy
--  całego etapu, nie pojedynczego zdania instrukcji.
-- =============================================================================

drop table if exists czasy_sprzet;

create table czasy_sprzet (
  id       uuid           primary key default gen_random_uuid(),
  etap_id  uuid           not null references etapy (id) on delete cascade,
  sprzet   rodzaj_sprzetu not null,
  minuty   smallint       not null check (minuty > 0 and minuty <= 1440),
  unique (etap_id, sprzet)
);

comment on table czasy_sprzet is
  'Warianty czasu etapu dla różnych urządzeń. Aplikacja pokazuje ten pasujący do sprzętu z profilu.';

create index czasy_sprzet_etap_idx on czasy_sprzet (etap_id);

alter table czasy_sprzet enable row level security;

create policy czasy_sprzet_odczyt on czasy_sprzet
  for select using (
    exists (
      select 1 from etapy e join przepisy p on p.id = e.przepis_id
       where e.id = czasy_sprzet.etap_id
         and (p.widocznosc = 'publiczna' or p.autor_id = auth.uid() or czy_moderator())
    )
  );

create policy czasy_sprzet_zapis on czasy_sprzet
  for all using (czy_moderator()) with check (czy_moderator());


-- =============================================================================
--  5. WIDOK Z CZASEM CAŁEGO PRZEPISU
-- =============================================================================

create view przepis_czas as
select
  e.przepis_id,
  count(*)::integer            as liczba_etapow,
  sum(coalesce(e.minuty, 0))::integer as minuty_razem
from etapy e
group by e.przepis_id;

comment on view przepis_czas is
  'Czas przepisu liczony z etapów. Kolumna przepisy.czas_minut pozostaje jako wartość podawana ręcznie, gdy przepis nie ma etapów.';
