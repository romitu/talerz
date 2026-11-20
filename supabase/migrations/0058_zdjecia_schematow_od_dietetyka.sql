-- =============================================================================
--  TALERZ — miniatury zdjęć w schematach od dietetyka
-- =============================================================================
--  Po co
--  -----
--  Listy schematów pokazują pasek do czterech zdjęć dań (lib/schematy.ts,
--  `PasekMiniatur`). Własne schematy i katalog biorą zdjęcia wprost z tabel,
--  ale schematy od dietetyka klient czyta wyłącznie przez funkcję
--  `schematy_od_dietetyka` (migracja 0056) — a ta zdjęć nie zwracała.
--
--  Zwracamy tylko zdjęcia przepisów, które klient i tak może zobaczyć:
--  publicznych i własnych. Prywatny przepis dietetyka przy wstawianiu zostaje
--  pominięty (lib/schematy-uklad.ts, `niedostepne`), więc jego zdjęcie w
--  podglądzie obiecywałoby danie, którego w planie nie będzie.
--
--  Zmienia się typ wyniku funkcji, a PostgreSQL nie pozwala tego zrobić przez
--  `create or replace` — stąd `drop` i ponowne nadanie uprawnień.
--
--  Wykonanie: SQL Editor w panelu Supabase, po 0056.
-- =============================================================================

drop function if exists schematy_od_dietetyka();

create function schematy_od_dietetyka()
returns table (
  schemat_id uuid,
  nazwa text,
  dni smallint,
  liczba_dan integer,
  profil_id uuid,
  imie text,
  dietetyk text,
  od timestamptz,
  zdjecia text[]
)
language sql
stable
security definer
set search_path = public
as $$
  select s.id, s.nazwa, s.dni,
         (select count(*)::integer from schemat_pozycje sp where sp.schemat_id = s.id),
         p.id, p.imie, coalesce(d.nazwa, kd.email), su.utworzono,
         (
           -- Pierwsze cztery różne zdjęcia, w kolejności dni.
           select coalesce(array_agg(q.zdjecie order by q.pierwszy_dzien), '{}')
             from (
               select pr.zdjecie, min(sp.dzien) as pierwszy_dzien
                 from schemat_pozycje sp
                 join przepisy pr on pr.id = sp.przepis_id
                where sp.schemat_id = s.id
                  and pr.zdjecie is not null
                  and (pr.widocznosc = 'publiczna' or pr.autor_id = id_czynnego_konta())
                group by pr.zdjecie
                order by min(sp.dzien)
                limit 4
             ) q
         )
    from schematy_udostepnione su
    join schematy s on s.id = su.schemat_id
    join profile p on p.id = su.profil_id and p.konto_id = id_czynnego_konta()
    join dietetyk_podopieczni dp on dp.profil_id = su.profil_id and dp.dietetyk_id = su.dietetyk_id
    join konta kd on kd.id = su.dietetyk_id and kd.aktywne
    left join dietetycy d on d.konto_id = su.dietetyk_id
   order by lower(s.nazwa), lower(p.imie);
$$;

revoke execute on function schematy_od_dietetyka() from public;

do $$
begin
  if exists (select 1 from pg_roles where rolname = 'authenticated') then
    grant execute on function schematy_od_dietetyka() to authenticated;
  end if;
end
$$;
