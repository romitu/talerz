-- =============================================================================
--  TALERZ — role składników przy skalowaniu porcji
-- =============================================================================
--  Przeniesienie tabeli z prototypu ROLE_RB.html (dotąd tylko w localStorage
--  przeglądarki, więc każdy widział własną wersję i nic się nie zapisywało
--  na serwerze) do bazy — jedna wspólna wersja dla wszystkich.
--
--  k = liczba porcji przygotowywanych / liczba porcji bazowych (migracja 0029).
--  Każda rola opisuje, jak przy zmianie k skaluje się ilość składnika. Siedem
--  ról jest stałe i się nie dodaje — edytowalny jest tylko `wzor`, reszta to
--  dokumentacja wyjaśniająca, kiedy której roli użyć.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

create table role_skladnikow (
  klucz         text     primary key,
  kolejnosc     smallint not null,
  etykieta      text     not null,
  opis_roli     text     not null,
  wzor          text     not null,
  kiedy_uzywac  text     not null,
  przyklady     text[]   not null default '{}'
);

comment on table role_skladnikow is
  'Siedem stałych ról składnika przy skalowaniu przepisu na inną liczbę porcji. Wiersze się nie dodaje ani nie usuwa — edytuje się tylko wzor.';

comment on column role_skladnikow.wzor is
  'Wzór skalowania w zależności od k = porcje docelowe / liczba_porcji_bazowych. Jedyna kolumna edytowana z poziomu aplikacji.';

alter table role_skladnikow enable row level security;

create policy role_skladnikow_odczyt on role_skladnikow
  for select using (auth.uid() is not null);

-- Tylko UPDATE — liczba ról jest stała, nikt nie powinien dopisywać ani kasować wierszy.
create policy role_skladnikow_zapis_moderator on role_skladnikow
  for update using (czy_moderator()) with check (czy_moderator());

insert into role_skladnikow (klucz, kolejnosc, etykieta, opis_roli, wzor, kiedy_uzywac, przyklady) values
(
  'baza', 1, 'Baza',
  'Domyślna rola większości składników.',
  'ilość × k',
  'Gdy ilość składnika powinna rosnąć lub maleć bezpośrednio proporcjonalnie do liczby przygotowywanych porcji.',
  array[
    'Mięso: 400 g kurczaka na 4 porcje → przy 6 porcjach 600 g.',
    'Ryż: 240 g na 4 porcje → przy 6 porcjach 360 g.',
    'Warzywa: 300 g marchwi na 4 porcje → przy 6 porcjach 450 g.',
    'Nabiał: 200 g jogurtu w sosie na 4 porcje → przy 6 porcjach 300 g.',
    'Passata: 500 g na 4 porcje → przy 6 porcjach 750 g.'
  ]
),
(
  'doprawienie', 2, 'Doprawienie',
  'Składniki wpływające przede wszystkim na smak i stężenie.',
  'k ≤ 1: ilość × k; k > 1: ilość × k^0,85',
  'Dla składników, których ilość powinna rosnąć wraz z daniem, ale przy większej skali można zastosować lekkie tłumienie.',
  array[
    'Sól: 8 g na 4 porcje → dla 6 porcji ok. 11,3 g zamiast pełnych 12 g.',
    'Sos sojowy: 30 ml na 4 porcje → dla 8 porcji ok. 54 ml zamiast 60 ml.',
    'Ocet: 20 ml w sosie na 4 porcje → przy podwojeniu dania wzrost jest lekko tłumiony.',
    'Musztarda: gdy pełni funkcję smakową w sosie, a nie głównego składnika.'
  ]
),
(
  'aromat', 3, 'Aromat mocny',
  'Składniki dominujące aromatem lub ostrością.',
  'k ≤ 1: ilość × k; k > 1: ilość × k^0,75',
  'Dla składników, których zbyt szybkie zwiększanie może zdominować danie. Przy większej liczbie porcji rosną wolniej niż baza.',
  array[
    'Czosnek: 4 ząbki na 4 porcje → dla 8 porcji ok. 7 zamiast 8 po kwantyzacji.',
    'Chili: 4 g na 4 porcje → dla 8 porcji ok. 6,7 g zamiast 8 g.',
    'Liść laurowy: 2 szt. na 4 porcje → wynik po skalowaniu można skwantyzować do pełnej sztuki.',
    'Pasta curry: gdy jest bardzo intensywna i stanowi tylko akcent smakowy.'
  ]
),
(
  'smazenie', 4, 'Tłuszcz do smażenia',
  'Zależny bardziej od powierzchni naczynia niż liczby porcji.',
  'k ≤ 1: ilość × k; k > 1: ilość × k^0,67',
  'Gdy olej, oliwa, masło lub inny tłuszcz służy głównie do pokrycia patelni lub przeprowadzenia obróbki cieplnej.',
  array[
    'Oliwa do smażenia cebuli: 15 ml na 4 porcje → dla 8 porcji nie trzeba automatycznie dawać 30 ml.',
    'Masło do smażenia pieczarek: większa ilość pieczarek może wymagać dwóch partii, ale niekoniecznie dwa razy więcej masła.',
    'Olej do obsmażenia mięsa: jego ilość zależy od patelni, temperatury i techniki smażenia.'
  ]
),
(
  'duszenie', 5, 'Płyn do duszenia',
  'Płyn pracujący technologicznie w garnku.',
  'k ≤ 1: ilość × k; k > 1: ilość × k^0,85',
  'Dla bulionu, wina, mleka kokosowego lub innego płynu, który podczas duszenia częściowo odparowuje i nie zawsze musi rosnąć dokładnie proporcjonalnie.',
  array[
    'Bulion w gulaszu: 500 ml na 4 porcje → dla 8 porcji mniej niż 1000 ml może być wystarczające.',
    'Wino do duszenia: część alkoholu i wody odparowuje, więc pełne skalowanie może dać zbyt rzadki sos.',
    'Mleko kokosowe: jeśli jest bazą sosu może mieć rolę „baza”, a jeśli tylko pomaga w duszeniu — „płyn do duszenia”.'
  ]
),
(
  'woda', 6, 'Woda technologiczna',
  'Nie jest bezpośrednio częścią porcji.',
  'bez automatycznego skalowania',
  'Gdy woda służy do ugotowania produktu, blanszowania, płukania lub innego procesu, a jej większość nie trafia do gotowego dania.',
  array[
    'Woda na makaron: 2 l nie oznacza, że przy podwojeniu makaronu zawsze trzeba użyć 4 l.',
    'Woda do ziemniaków: jej zadaniem jest przykrycie produktu w garnku.',
    'Woda do blanszowania: zależy od wielkości garnka i procesu, nie od kalorii dania.',
    'Uwaga: woda będąca składnikiem zupy nie powinna mieć tej roli — wtedy jest bazą albo podlega ograniczeniom przepisu.'
  ]
),
(
  'do_smaku', 7, 'Do smaku',
  'Składnik orientacyjny, bez sztywnego przelicznika.',
  'bez automatycznego skalowania',
  'Gdy dokładna ilość nie powinna być wyliczana matematycznie, bo użytkownik dobiera ją według własnego smaku lub jako wykończenie dania.',
  array[
    'Pieprz na talerzu: użytkownik dodaje według własnych preferencji.',
    'Natka pietruszki: kilka gramów jako posypka nie wymaga ścisłego skalowania.',
    'Szczypiorek: dekoracja i świeży akcent smakowy.',
    'Kolendra: szczególnie gdy część osób dodaje ją dopiero na swoim talerzu.'
  ]
);

notify pgrst, 'reload schema';
