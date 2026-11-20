-- =============================================================================
--  TALERZ — katalog schematów (etap 4 modułu schematów)
-- =============================================================================
--  Po co
--  -----
--  Moderator układa schematy pokazowe („Tydzień śródziemnomorski”,
--  „Tydzień na 3 gotowania”) i publikuje je dla wszystkich. Każdy może
--  taki schemat wstawić do swojego tygodnia albo skopiować do swoich
--  i przerobić.
--
--  Publikacja jest flagą przy schemacie, nie kopią: poprawka moderatora
--  w edytorze od razu widać w katalogu.
--
--  Kto może publikować
--  -------------------
--  Tylko moderator (i administrator) — pilnuje tego wyzwalacz, bo reguła
--  `schematy_wlasne` z 0054 pozwala właścicielowi zmieniać swój wiersz,
--  a o kolumnie `publiczny` nic nie mówi (ta sama pułapka co z
--  `przepisy.widocznosc`, patrz 0022).
--
--  Publikować wolno tylko schemat złożony z przepisów publicznych — inaczej
--  w katalogu stałby tydzień, z którego każdy dostanie same dziury. Sprawdza
--  to funkcja `ustaw_publicznosc_schematu`.
--
--  Odczyt cudzych schematów
--  ------------------------
--  Publiczne są widoczne przez reguły dostępu (to dane dla wszystkich, nie
--  dane konkretnej osoby). Aplikacja pyta o „moje” z filtrem po koncie
--  (`pobierzSchematy` w lib/schematy.ts), a o katalog osobno.
--
--  Wykonanie: SQL Editor w panelu Supabase, po 0054–0056.
-- =============================================================================

alter table schematy
  add column if not exists publiczny boolean not null default false;

comment on column schematy.publiczny is
  'Schemat w katalogu Talerza — widoczny dla wszystkich. Ustawia wyłącznie moderator (wyzwalacz schematy_publikacja).';

create index if not exists schematy_publiczne_idx on schematy (nazwa) where publiczny;

create policy schematy_publiczne on schematy
  for select using (publiczny);

create policy schemat_pozycje_publiczne on schemat_pozycje
  for select using (exists (select 1 from schematy s where s.id = schemat_pozycje.schemat_id and s.publiczny));


create or replace function pilnuj_publikacji_schematu()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  if new.publiczny
     and (tg_op = 'INSERT' or not old.publiczny)
     and not czy_moderator() then
    raise exception 'Publikować schematy może tylko moderator.' using errcode = '42501';
  end if;
  return new;
end;
$$;

drop trigger if exists schematy_publikacja on schematy;
create trigger schematy_publikacja
  before insert or update of publiczny on schematy
  for each row execute function pilnuj_publikacji_schematu();


/**
  Publikuje albo wycofuje WŁASNY schemat moderatora. Przy publikacji
  odmawia, gdy któreś danie ma przepis prywatny albo usunięty.
  `security invoker` — reguły dostępu i wyzwalacz działają normalnie.
*/
create or replace function ustaw_publicznosc_schematu(p_schemat uuid, p_publiczny boolean)
returns void
language plpgsql
security invoker
set search_path = public
as $$
declare
  v_niepubliczne integer;
begin
  if not czy_moderator() then
    raise exception 'Publikować schematy może tylko moderator.' using errcode = '42501';
  end if;

  if p_publiczny then
    select count(*) into v_niepubliczne
      from schemat_pozycje sp
      left join przepisy pr on pr.id = sp.przepis_id
     where sp.schemat_id = p_schemat
       and (pr.id is null or pr.widocznosc <> 'publiczna');

    if v_niepubliczne > 0 then
      raise exception 'Schemat ma % dań z przepisów, które nie są publiczne.', v_niepubliczne
        using errcode = '23514', hint = v_niepubliczne::text;
    end if;

    if not exists (select 1 from schemat_pozycje sp where sp.schemat_id = p_schemat) then
      raise exception 'Pusty schemat nie trafi do katalogu.' using errcode = '23514', hint = '0';
    end if;
  end if;

  update schematy set publiczny = p_publiczny
   where id = p_schemat and konto_id = id_czynnego_konta();

  if not found then
    raise exception 'To nie jest Twój schemat.' using errcode = '42501';
  end if;
end;
$$;

revoke execute on function ustaw_publicznosc_schematu(uuid, boolean) from public;

do $$
begin
  if exists (select 1 from pg_roles where rolname = 'authenticated') then
    grant execute on function ustaw_publicznosc_schematu(uuid, boolean) to authenticated;
  end if;
end
$$;


-- =============================================================================
--  SPRAWDZENIE
-- =============================================================================
select count(*) filter (where publiczny) as w_katalogu, count(*) as wszystkich from schematy;
