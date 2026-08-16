-- =============================================================================
--  TALERZ — produkty dopisywane ręcznie i trwałe odhaczenia
-- =============================================================================
--  Dlaczego to musi być OSOBNY byt
--  -------------------------------
--  Lista zakupów nie istnieje w bazie. Powstaje za każdym razem na nowo:
--  plan → przepisy → składniki → gramy → opakowania. To celowa decyzja z
--  początku projektu i dzięki niej lista nie może się rozjechać z posiłkami.
--
--  Worki na śmieci nie mają przepisu, nie mają gramów i nie należą do żadnego
--  dnia planu. Nie da się ich wcisnąć w tamten mechanizm, nie psując go.
--  Są więc DRUGIM źródłem, które ekran skleja z pierwszym.
--
--  Dlaczego ilość jest tekstem
--  ---------------------------
--  Przy jedzeniu gramy mają sens: z nich liczy się makro i liczba opakowań.
--  Papier śniadaniowy kupuje się „w rolce”, worki „w opakowaniu 20 szt.”.
--  Kolumna liczbowa zmusiłaby do wymyślania, ile waży rolka — a ta liczba
--  nie służyłaby niczemu. Krótki tekst jest tu uczciwszy od fałszywej precyzji.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================


-- =============================================================================
--  1. PRODUKTY DOPISYWANE RĘCZNIE
-- =============================================================================

create table if not exists zakupy_reczne (
  id             uuid        primary key default gen_random_uuid(),
  konto_id       uuid        not null references konta (id) on delete cascade,
  nazwa          text        not null check (length(btrim(nazwa)) between 1 and 60),
  ilosc          text        check (ilosc is null or length(btrim(ilosc)) between 1 and 30),
  kupione        boolean     not null default false,
  utworzono      timestamptz not null default now(),
  kupiono_kiedy  timestamptz
);

comment on table zakupy_reczne is
  'Produkty spoza planu — chemia, papier, worki. Kupione zostają w tabeli jako historia do podpowiedzi.';

comment on column zakupy_reczne.ilosc is
  'Dowolny tekst: „2 rolki”, „1 opak.”, „duże”. Gramy nie mają tu zastosowania.';

comment on column zakupy_reczne.kupione is
  'Odhaczone znika z listy, ale NIE z tabeli — z historii biorą się podpowiedzi przy następnym dopisywaniu.';

/*
  Ta sama rzecz może wisieć na liście tylko RAZ.

  Indeks jest częściowy — obejmuje wyłącznie pozycje niekupione. Dzięki temu
  „Worki na śmieci” da się kupić dwanaście razy w roku (dwanaście wierszy
  w historii), ale nie da się mieć dwóch otwartych wpisów naraz. Bez tego
  dopisanie tej samej rzeczy w środę i w piątek dawałoby duplikat na liście.

  Nazwa jest przed porównaniem sprowadzana do jednej postaci: małe litery,
  bez spacji na brzegach, wielokrotne spacje w środku zwinięte do jednej.
  Aplikacja robi to samo przed wysłaniem, ale baza nie może na tym polegać —
  „worki na  śmieci” z dwiema spacjami weszłoby jako druga pozycja i lista
  pokazywałaby tę samą rzecz dwa razy.
*/
create unique index if not exists zakupy_reczne_jedna_otwarta
  on zakupy_reczne (konto_id, lower(regexp_replace(btrim(nazwa), '\s+', ' ', 'g')))
  where not kupione;

create index if not exists zakupy_reczne_historia_idx
  on zakupy_reczne (konto_id, kupiono_kiedy desc nulls last);

alter table zakupy_reczne enable row level security;

drop policy if exists zakupy_reczne_wlasne on zakupy_reczne;
create policy zakupy_reczne_wlasne on zakupy_reczne
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());

/*
  Data zakupu ustawia się sama.

  Aplikacja mogłaby ją wpisywać przy odhaczaniu, ale wtedy każde kolejne
  miejsce zmieniające `kupione` musiałoby o tym pamiętać. Wyzwalacz pamięta
  zawsze — a to z tej daty bierze się kolejność podpowiedzi.
*/
create or replace function zakupy_reczne_znacznik()
returns trigger
language plpgsql
as $$
begin
  if new.kupione and not coalesce(old.kupione, false) then
    new.kupiono_kiedy := now();
  elsif not new.kupione then
    new.kupiono_kiedy := null;
  end if;
  return new;
end;
$$;

drop trigger if exists zakupy_reczne_data_zakupu on zakupy_reczne;
create trigger zakupy_reczne_data_zakupu
  before insert or update of kupione on zakupy_reczne
  for each row execute function zakupy_reczne_znacznik();


-- =============================================================================
--  2. ODHACZENIA POZYCJI Z PLANU
-- =============================================================================
/*
  Do tej pory ptaszki siedziały wyłącznie w pamięci ekranu. Wystarczyło
  przejść na inną zakładkę i wracało się do listy odznaczonej od zera —
  w sklepie, w połowie zakupów.

  Nie da się tego zapisać w liście zakupów, bo listy nie ma w bazie. Zapisujemy
  więc SAM FAKT odhaczenia, powiązany ze składnikiem. Gdy plan się zmieni
  i składnik zniknie z listy, jego odhaczenie po prostu przestaje być
  do czegokolwiek stosowane.

  Klucz główny na parze (konto, składnik) zamiast osobnego identyfikatora:
  odhaczenie albo jest, albo go nie ma. Drugie takie samo nie znaczyłoby nic.
*/
create table if not exists zakupy_odhaczone (
  konto_id     uuid        not null references konta (id) on delete cascade,
  skladnik_id  uuid        not null references skladniki (id) on delete cascade,
  odhaczono    timestamptz not null default now(),
  primary key (konto_id, skladnik_id)
);

comment on table zakupy_odhaczone is
  'Co już wrzucone do koszyka. Kasowane jednym ruchem przy rozpoczęciu nowych zakupów.';

alter table zakupy_odhaczone enable row level security;

drop policy if exists zakupy_odhaczone_wlasne on zakupy_odhaczone;
create policy zakupy_odhaczone_wlasne on zakupy_odhaczone
  for all using (konto_id = auth.uid()) with check (konto_id = auth.uid());


-- =============================================================================
--  3. SPRAWDZENIE
-- =============================================================================
select
  (select count(*) from information_schema.tables
    where table_name in ('zakupy_reczne', 'zakupy_odhaczone')) as "tabel utworzonych (ma być 2)",
  (select count(*) from pg_policies
    where tablename in ('zakupy_reczne', 'zakupy_odhaczone')) as "regul dostepu (ma byc 2)",
  (select count(*) from pg_indexes
    where indexname = 'zakupy_reczne_jedna_otwarta') as "indeks bez duplikatow (ma byc 1)";
