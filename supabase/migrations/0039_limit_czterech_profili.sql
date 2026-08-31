-- Podnosi limit profili na koncie z 3 do 4 (patrz 0001_schemat_poczatkowy.sql).
create or replace function sprawdz_profil()
returns trigger
language plpgsql
as $$
declare
  liczba_profili integer;
begin
  if new.data_urodzenia > (current_date - interval '18 years') then
    raise exception 'Talerz jest przeznaczony wyłącznie dla osób pełnoletnich.';
  end if;

  if new.data_urodzenia < (current_date - interval '120 years') then
    raise exception 'Nieprawidłowa data urodzenia.';
  end if;

  select count(*) into liczba_profili
    from profile
   where konto_id = new.konto_id
     and id is distinct from new.id;

  if liczba_profili >= 4 then
    raise exception 'Konto może mieć najwyżej 4 profile.';
  end if;

  return new;
end;
$$;
