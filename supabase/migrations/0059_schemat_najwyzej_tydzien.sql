-- =============================================================================
--  TALERZ — schemat najwyżej na 7 dni
-- =============================================================================
--  Po co
--  -----
--  Schemat to TYDZIEŃ do powtarzania. Migracja 0054 dopuszczała 1–31 dni,
--  jak plan, ale dłuższy schemat nie ma zastosowania: wstawia się go do
--  tygodnia, a resztę i tak ucina koniec planu. Edytor pozwala już tylko na
--  1–7 dni; tu baza pilnuje tego samego.
--
--  Istniejące dłuższe schematy przycinamy do 7 dni — pozycje z dni 8+ odpadają
--  (jak przy skracaniu w edytorze). Garnek, który na nie zachodził, zostaje
--  krótszy.
--
--  Wykonanie: SQL Editor w panelu Supabase, po 0054–0058.
-- =============================================================================

delete from schemat_pozycje where dzien >= 7;
update schematy set dni = 7 where dni > 7;

alter table schematy drop constraint if exists schematy_dni_check;
alter table schematy drop constraint if exists schematy_dni_tydzien;
alter table schematy
  add constraint schematy_dni_tydzien check (dni between 1 and 7);

alter table schemat_pozycje drop constraint if exists schemat_pozycje_dzien_check;
alter table schemat_pozycje drop constraint if exists schemat_pozycje_dzien_tydzien;
alter table schemat_pozycje
  add constraint schemat_pozycje_dzien_tydzien check (dzien between 0 and 6);

comment on column schematy.dni is
  'Długość schematu: 1–7 dni (migracja 0059).';
