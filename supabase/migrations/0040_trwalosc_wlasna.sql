-- =============================================================================
--  TALERZ — własna (per-konto) trwałość dania w lodówce
-- =============================================================================
--  Przepis ma jedną wspólną trwałość (`przepisy.trwalosc_dni`), ustawianą
--  przez autora w formularzu przepisu — to GÓRNY LIMIT, bezpieczny dla
--  wszystkich. Różne konta mogą mieć jednak różną tolerancję: jedna osoba
--  chętnie zje coś czwartego dnia, druga wolałaby najwyżej dwa.
--
--  Ta tabela trzyma WŁASNE skrócenie tej trwałości dla danego konta. Brak
--  wiersza = konto trzyma się wartości z przepisu (najczęstszy przypadek,
--  nie ma sensu zakładać wiersza dla każdej pary konto×przepis).
--
--  Górny limit z przepisu pilnowany jest przy odczycie (patrz
--  `lib/przepisy.ts`, `pobierzPrzepisy` — efektywna trwałość to
--  `min(własna, z przepisu)`), więc nawet gdyby ktoś zapisał tu wartość
--  większą niż aktualny limit przepisu (np. autor go później obniżył),
--  aplikacja i tak pokaże i użyje mniejszej z dwóch.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create table trwalosc_wlasna (
  przepis_id  uuid        not null references przepisy (id) on delete cascade,
  konto_id    uuid        not null references konta (id) on delete cascade,
  dni         integer     not null check (dni >= 0),
  utworzono   timestamptz not null default now(),
  primary key (przepis_id, konto_id)
);

comment on table trwalosc_wlasna is
  'Własne (skrócone) ustawienie "ile dni wytrzyma w lodówce" dla danego konta. Brak wiersza = konto trzyma się wartości z przepisu. Efektywna wartość to zawsze min(dni, przepisy.trwalosc_dni).';

alter table trwalosc_wlasna enable row level security;

create policy trwalosc_wlasna_wlasne on trwalosc_wlasna
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());
