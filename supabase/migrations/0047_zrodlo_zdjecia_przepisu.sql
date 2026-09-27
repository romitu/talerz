-- =============================================================================
--  TALERZ — pochodzenie zdjęcia przepisu
-- =============================================================================
--  To samo, co przy składnikach (migracja 0045): część zdjęć dań wygenerowało
--  AI, część to zdjęcia autorskie. Użytkownik musi to widzieć — grafika AI
--  jest poglądowa i nie pokazuje, jak danie naprawdę wyjdzie. Na zdjęciu
--  zamienia się to w znaczek „AI” albo ikonę zdjęcia.
--
--  Istniejące zdjęcia
--  ------------------
--  Zdjęcia przepisów przyszły ze starego planera (narzedzia/wgraj-zdjecia.mjs)
--  i nie wiadomo, skąd pochodzą. Nie zgadujemy: zostają z pustym
--  `zdjecie_zrodlo` jako „nieoznaczone”, a formularz przepisu pokazuje to
--  jako lukę do uzupełnienia. Dlatego — inaczej niż przy składnikach —
--  zdjęcie bez oznaczenia jest dozwolone; oznaczenie bez zdjęcia nie.
--
--  Wykonanie: SQL Editor w panelu Supabase. Można uruchomić kilka razy.
-- =============================================================================

alter table przepisy
  add column if not exists zdjecie_zrodlo text;

alter table przepisy drop constraint if exists przepisy_zdjecie_zrodlo_poprawne;
alter table przepisy add constraint przepisy_zdjecie_zrodlo_poprawne
  check (
    zdjecie_zrodlo is null
    or (zdjecie is not null and zdjecie_zrodlo in ('ai', 'wlasne'))
  );

comment on column przepisy.zdjecie_zrodlo is
  '„ai” = grafika wygenerowana (poglądowa), „wlasne” = zdjęcie autorskie. Puste = brak zdjęcia albo jeszcze nieoznaczone.';

notify pgrst, 'reload schema';


-- --- SPRAWDZENIE ------------------------------------------------------------
--  Ile zdjęć czeka na oznaczenie.
select
  count(*) filter (where zdjecie is not null and zdjecie_zrodlo is null) as nieoznaczone,
  count(*) filter (where zdjecie_zrodlo = 'ai')                          as ai,
  count(*) filter (where zdjecie_zrodlo = 'wlasne')                      as autorskie
from przepisy;
