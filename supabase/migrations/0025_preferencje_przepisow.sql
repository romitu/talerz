-- =============================================================================
--  TALERZ — poziomy preferencji zamiast binarnego polubienia
-- =============================================================================
--  Co było
--  -------
--  Tabela `polubienia` znała tylko dwa stany: wiersz jest (polubione) albo go
--  nie ma (nie polubione). Do serduszka przy przepisie to wystarczało, ale
--  automat wypełniający plan liczył PREMIĘ Z GLOBALNEGO LICZNIKA polubień —
--  czyli tego, ile osób w ogóle polubiło dany przepis, a nie tego, czy TY go
--  lubisz. Przy jednym koncie różnicy nie było widać. Przy kilku — mój plan
--  premiowałby dania, które polubił ktoś inny.
--
--  Co jest teraz
--  -------------
--  Trzy zapamiętywane poziomy:
--
--    ulubione    – chcę jeść często (mocna premia w automacie)
--    lubie       – chętnie zjem ponownie (zwykła premia; to był dawny „lajk”)
--    nie_proponuj – automat ma go NIGDY nie proponować sam
--
--  Czwarty stan, „neutralne”, NIE JEST zapisywany osobno. To brak wiersza —
--  dokładnie tak samo jak dawne „nie polubione”. Zakładanie wiersza dla
--  każdej pary konto×przepis tylko po to, żeby zapisać „nic nie sądzę”, byłoby
--  bazą rosnącą bez potrzeby.
--
--  Dane się nie gubią: istniejące polubienia dostają poziom `lubie` — to był
--  ich faktyczny sens („chętnie zjem ponownie”), więc nic nikomu nie znika.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

alter table polubienia rename to preferencje_przepisow;

create type poziom_preferencji as enum ('ulubione', 'lubie', 'nie_proponuj');

alter table preferencje_przepisow
  add column poziom poziom_preferencji not null default 'lubie';

-- Domyślna wartość posłużyła tylko do wypełnienia istniejących wierszy —
-- każdy kolejny zapis podaje poziom wprost z aplikacji.
alter table preferencje_przepisow alter column poziom drop default;

comment on table preferencje_przepisow is
  'Poziom preferencji względem przepisu. Brak wiersza = neutralne ("może się pojawiać") — to wartość domyślna, nie osobny stan do zapisania.';

comment on column preferencje_przepisow.poziom is
  'ulubione = chcę jeść często, lubie = chętnie zjem ponownie, nie_proponuj = automat ma to pomijać całkowicie.';

/*
  Stare polubienia miały PUBLICZNY odczyt (`polubienia_odczyt`) — potrzebny do
  pokazania licznika serduszek pod przepisem, czyli tego, ile osób W OGÓLE go
  polubiło. Preferencja tego nie robi: to prywatna wskazówka dla automatu tego
  KONKRETNEGO konta (patrz `lib/automat.ts`), nie publiczna popularność.

  Dlatego starą politykę KASUJEMY, a nie zamieniamy na odpowiednik. Gdyby
  obie polityki select istniały naraz, PostgreSQL i tak zsumowałby je przez
  OR — szersza wygrałaby, a węższa `preferencje_wlasne` niżej byłaby martwym
  zapisem. Zostaje tylko ona: każde konto widzi (i zmienia) wyłącznie własne
  wiersze.
*/
drop policy if exists polubienia_odczyt on preferencje_przepisow;

drop policy if exists polubienia_wlasne on preferencje_przepisow;
create policy preferencje_wlasne on preferencje_przepisow
  for all using (konto_id = id_czynnego_konta())
  with check (konto_id = id_czynnego_konta());


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select
  poziom,
  count(*) as ile
 from preferencje_przepisow
group by poziom
order by poziom;
