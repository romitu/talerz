-- =============================================================================
--  TALERZ — każdy przepis domyślnie skalowalny
-- =============================================================================
--  Checkbox „skalowalny” (migracja 0036) miał chronić przed absurdalnymi
--  porcjami, ale sam tego nie robił — skalowanie miało stały zakres ×0,25–×4.
--  Od 2026-09-28 ochronę daje reguła w kodzie (lib/skalowanie-kalorii.ts):
--
--    - porcja nigdy nie maleje poniżej porcji bazowej,
--    - rośnie najwyżej o połowę,
--    - i nie ponad limit posiłku: śniadanie i kolacja 600 g, obiad 900 g,
--      dodatek 600 g — każde danie osobno,
--    - danie, które bazowo przekracza limit (barszcz ~1065 g), nie rośnie.
--
--  Skoro granice pilnują porcji, skalować może każde danie. Checkbox zostaje
--  jako wyjątek: odznaczony = „tego dania nigdy nie zmieniaj”.
--
--  Ta migracja:
--    1. ustawia domyślne „tak” dla nowych przepisów (formularz, import z Excela,
--       import plików AI),
--    2. jednorazowo zaznacza wszystkie istniejące przepisy.
--
--  Wykonanie: SQL Editor w panelu Supabase. Można uruchomić kilka razy, ale
--  drugie uruchomienie zaznaczy też przepisy odznaczone w międzyczasie ręcznie.
-- =============================================================================

alter table przepisy alter column skalowalny set default true;

comment on column przepisy.skalowalny is
  'Czy automat może dopasować wielkość porcji do celu kalorii — w granicach z lib/skalowanie-kalorii.ts (nie mniej niż porcja bazowa, najwyżej ×1,5, limit gramów posiłku). Domyślnie tak; odznaczone = wyjątek „nie zmieniaj”.';

update przepisy set skalowalny = true where not skalowalny;


-- --- SPRAWDZENIE ------------------------------------------------------------
select skalowalny, count(*)
from przepisy
group by skalowalny
order by skalowalny;
