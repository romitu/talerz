# Talerz — plan aplikacji

Wersja po korektach merytorycznych i rozstrzygnięciu decyzji otwartych.
Ten dokument zastępuje wcześniejsze notatki jako obowiązujący opis zakresu.
Uzasadnienia korekt zostały w `specyfikacja-analiza.md`.

**Stan:** sierpień 2026. Zaprogramowany jest wyłącznie szkielet interfejsu —
cztery zakładki i przykładowy plan dnia na danych wpisanych na stałe.

---

## 1. Czym jest Talerz

> Aplikacja dla ludzi, którzy gotują raz i jedzą trzy dni — pilnuje, ile porcji
> stoi w lodówce, nie każe wpisywać każdego posiłku i planuje zakupy tak,
> żeby nic się nie zmarnowało.

Kuchnia domowa, trzy posiłki dziennie, wysokie białko, gotowanie na zapas.
Android, iPhone i przeglądarka z jednego kodu.

**O kuchni — zmiana z sierpnia 2026.** Pierwotnie aplikacja miała być
śródziemnomorska. Baza startowa pochodzi jednak z planera, który autor
gotował przez rok, a tam obok sałatki greckiej stoi barszcz ukraiński,
krupnik i tom kha gai. Z trzydziestu dań śródziemnomorskich jest osiem.

Można było albo odrzucić dwie trzecie sprawdzonych przepisów, albo opisać
aplikację tak, jak jest. Wybieramy drugie. **Zasady żywieniowe zostają bez
zmian** — to one, a nie region kuchni, decydują o tym, czym Talerz jest:
mało cukrów wolnych, przewaga produktów nieprzetworzonych, oliwa i olej
rzepakowy zamiast tłuszczów utwardzonych, warzywa w każdym posiłku, ryby.

Kuchnia śródziemnomorska zostaje jako **wzorzec żywieniowy** i punkt
odniesienia w materiałach edukacyjnych (G1), a nie jako granica tego,
co wolno wpisać do bazy.

---

## 2. Zasady nadrzędne

Reguły, które rozstrzygają spory przy każdej późniejszej decyzji:

1. **Aplikacja informuje, nie ocenia.** Żadnego moralizowania na temat jedzenia.
2. **Blokujemy niebezpieczeństwo, nie nietypowość.** Poza normą — ostrzeżenie.
   Groźnie — blokada.
3. **Talerz nie przepisuje diet.** Pomaga prowadzić tę, którą użytkownik wybrał.
4. **Wąsko przed szeroko.** Jedna wyraźna tożsamość zamiast aplikacji dla każdego.
5. **Domyślnie prywatne.** Plan i pomiary są prywatne; publiczne jest tylko to,
   co użytkownik świadomie udostępni.

---

## 3. Podstawy żywieniowe

### 3.1. Źródła

**Podstawa:** „Normy żywienia dla populacji Polski" (NIZP-PZH, edycja 2024)
oraz model **Talerza Zdrowego Żywienia** (NIZP-PZH, 2020, zastąpił polską
piramidę).

**Zakresy techniczne dla suwaków:** AMDR — Acceptable Macronutrient Distribution
Ranges, dorośli od 19 lat.

| Składnik | Zakres (% energii dziennej) |
|---|---|
| Białko | 10–35% |
| Tłuszcz | 20–35% |
| Węglowodany | 45–65% |

**Cukry:** zalecenie WHO — cukry wolne poniżej 10% energii dziennej, docelowo
poniżej 5% (około 25 g dla dorosłego). Cukry wolne to cukry dodane plus obecne
w miodzie, syropach i sokach; cukier w całym owocu i laktoza się **nie liczą**.

> **Zastrzeżenie obowiązkowe:** Talerz nie jest powiązany z NIZP-PZH ani przez
> tę instytucję firmowany. Podobieństwo nazwy do „Talerza Zdrowego Żywienia"
> nie oznacza patronatu. Musi to być napisane wprost na stronie edukacyjnej.

### 3.2. Dwa poziomy ograniczeń

**Ostrzeżenie miękkie** — można potwierdzić i przejść dalej:

- wyjście poza zakresy AMDR
- posiłek poniżej progu białka
- przekroczenie dziennego limitu cukrów wolnych

**Blokada twarda** — nie da się ustawić:

- kalorie poniżej podstawowej przemiany materii
- deficyt powyżej około 1 kg tygodniowo
- białko powyżej 35% energii
- wiek poniżej 18 lat

*Sprawdzenie kontrolne:* plan autora (142 g białka, 82 g tłuszczu,
246 g węglowodanów, 2290 kcal) daje 24,8% / 32,2% / **43,0%**. Węglowodany
wypadają poniżej progu AMDR — i właśnie dlatego to ostrzeżenie, nie blokada.

### 3.3. Zasady dotyczące cukrów i słodzenia

Reguły obowiązujące przy dopuszczaniu przepisów do bazy:

| Zasada | Rozstrzygnięcie |
|---|---|
| Soki owocowe | **niedopuszczone** — owoce wyłącznie w całości |
| Cukry dodane | **niedopuszczone** w żadnej postaci |
| Zamienniki cukru (słodziki) | **niedopuszczone** |
| Miód | **dopuszczony**, jako jedyny słodzik |
| Suszone owoce w całości | dopuszczone |
| Pasta i syrop daktylowy | niedopuszczone |
| Sok z cytryny i limonki | dopuszczony jako zakwaszacz |
| Soki warzywne | dopuszczone bez ograniczeń |
| Sok marchwiowy i buraczany | dopuszczone, ale cukry wliczane do licznika |
| Passata, przecier i pomidory z puszki | **nie są sokami** — składniki podstawowe, bez ograniczeń |
| Kakao bez cukru, ziarna kakao (nibs) | dopuszczone bez ograniczeń |
| Czekolada gorzka od 85% | dopuszczona, do 15 g na porcję |
| Czekolada poniżej 85%, mleczna, biała, z nadzieniem | niedopuszczone |
| Polewy i kremy czekoladowo-orzechowe | niedopuszczone |
| Czekolada „bez cukru" na maltitolu lub stewii | niedopuszczona |

**Miód — zasada i jej granica.** WHO wymienia miód wprost jako cukier wolny,
obok syropów i soków. Dopuszczamy go jako **wybór kulinarny zgodny z tradycją
śródziemnomorską, nie jako decyzję zdrowotną**, i wliczamy w całości do limitu
cukrów wolnych. Bez liczenia zasada byłaby fikcją: łyżka miodu to około 17 g
cukrów wolnych, czyli blisko 60% wartości docelowej dla dorosłego (29 g przy
2290 kcal).

**Suszone owoce.** Daktyle, rodzynki i figi **w całości** nie są cukrem wolnym —
cukier pozostaje zamknięty w strukturze owocu. Pasta daktylowa i syrop z daktyli
już nim są, bo struktura zostaje rozbita. Granica ważna, bo wypieki
śródziemnomorskie stoją na daktylach.

**Sok z cytryny.** Formalnie sok owocowy, w praktyce zakwaszacz o śladowej
zawartości cukru. Wyjątek od zakazu soków, zapisany wprost, żeby moderator
nie musiał zgadywać.

**Soki warzywne.** Definicja cukrów wolnych WHO obejmuje wyłącznie soki owocowe,
więc warzywne wchodzą bez zastrzeżeń.

> **Sól nie jest osią zasad w Talerzu.** Rozważaliśmy warunek „bez dodatku soli"
> przy sokach warzywnych, ale skoro sól nie ogranicza żadnej innej kategorii,
> nie może rządzić tą jedną. Świadomy koszt: solony sok pomidorowy z półki
> przechodzi. Zasady pozostają oparte na dwóch osiach — cukrach wolnych
> i stopniu przetworzenia (NOVA).

Sok marchwiowy i buraczany mają 7–9 g cukru na 100 ml. WHO nie zalicza ich
do cukrów wolnych, ale mechanizm, którym uzasadniliśmy zakaz soków owocowych —
rozbita struktura i szybkie wchłanianie — działa tu tak samo. Dlatego są
dopuszczone, ale ich cukry wchodzą do licznika.

**Przetwory pomidorowe to nie soki.** Passata, przecier i pomidory krojone
z puszki są podstawowymi składnikami tej kuchni. Zapisane wprost, żeby zakaz
soków nie złapał ich przez nieostrą granicę.

**Czekolada.** Częsty dodatek do owsianki, więc granica musi być jednoznaczna.
Punktem odniesienia są liczby, nie wrażenia:

| Produkt | Cukier na 100 g | Porcja | Cukier w porcji |
|---|---|---|---|
| Miód (dopuszczony) | ~82 g | łyżka, 21 g | ~17 g |
| Czekolada mleczna | ~50 g | kostka, 10 g | ~5 g |
| Gorzka 70% | ~30 g | kostka, 10 g | ~3 g |
| Gorzka 85% | ~14 g | kostka, 10 g | ~1,4 g |
| Kakao bez cukru | ~1–2 g | łyżka, 5 g | ~0,1 g |

Jedna łyżka miodu odpowiada mniej więcej dwunastu kostkom gorzkiej 85%.
Wykluczanie czekolady przy jednoczesnym dopuszczeniu miodu byłoby nie do obrony.

**Próg 85%** jest umowny — to miejsce, w którym czekolada przestaje być słodyczą,
a staje się dodatkiem smakowym. Poniżej tego progu argument o braku cukrów
dodanych przestaje się bronić.

Czekolada poniżej 85%, mleczna i z nadzieniem odpada również na mocy punktu 22:
to żywność wysoko przetworzona, grupa 4 klasyfikacji NOVA.

**Pułapka nazwy.** Czekolada opisana jako „bez cukru" jest zwykle słodzona
maltitolem lub stewią, więc odpada na mocy zakazu słodzików — mimo że nazwa
sugeruje coś przeciwnego. Zapisane wprost, bo moderator się na tym potknie.

**Słodziki — jak to opisać na stronie edukacyjnej.** WHO odradza stosowanie
słodzików bezcukrowych do kontroli masy ciała. Uczciwość wymaga jednak dodania,
że zalecenie jest **warunkowe**, oparte na dowodach o **niskiej pewności**,
i **nie obejmuje alkoholi cukrowych** (erytrytol, ksylitol), które nie są
klasyfikowane jako słodziki bezcukrowe. Zasada w Talerzu pozostaje, ale
przedstawiamy ją jako wybór projektowy poparty zaleceniem, nie jako pewnik naukowy.

### 3.4. Wyliczanie zapotrzebowania

Wzór **Mifflina-St Jeora** — wymaga wieku, płci, wagi **i wzrostu**. Wzrost
dochodzi do listy danych profilu; bez niego wyliczenie jest niemożliwe.

**Białko liczone na kilogram masy ciała.** Cel dzienny powstaje ze wzoru:

> współczynnik (g/kg) × masa odniesienia = dzienny cel białkowy
> dzienny cel ÷ 3 = próg na pojedynczy posiłek

Współczynnik zależy od **wieku** i **poziomu aktywności fizycznej** — obie
zmienne są już w profilu. Zapotrzebowanie osób starszych jest wyższe niż
u pozostałych dorosłych, co potwierdza NIZP-PZH.

| Do ustalenia przed wdrożeniem | Skąd |
|---|---|
| Konkretne współczynniki g/kg dla przedziałów wieku | Normy żywienia dla populacji Polski, edycja 2024 |
| Modyfikatory dla poziomów aktywności | jw. |

Edycja 2024 zaktualizowała właśnie normy energii i białka, więc wartości należy
wziąć z niej, a nie z opracowań wcześniejszych. **Nie wpisujemy liczb
„z pamięci"** — to jedyne miejsce w aplikacji, gdzie zmyślona wartość
przekłada się wprost na to, co ktoś zje.

**Masa odniesienia — pułapka.** Przy dużej nadwadze przeliczanie na masę
rzeczywistą zawyża wynik: osoba o wadze 140 kg dostałaby ponad 200 g białka
dziennie. Dla wartości BMI powyżej progu otyłości trzeba stosować masę
skorygowaną, nie rzeczywistą. Sposób korekty również do wzięcia z norm.

**Przeciwwskazanie.** Wysoka podaż białka jest przeciwwskazana przy chorobach
nerek. To trafia do zastrzeżenia medycznego (G3), a nie do algorytmu — aplikacja
nie zna stanu zdrowia użytkownika.

---

## 4. Zakres funkcjonalny

### A. Profil i cele

| # | Funkcja | Uwagi |
|---|---|---|
| A1 | Dane osoby: imię, wiek, płeć, waga, **wzrost**, obwód talii | wzrost dodany względem pierwotnej listy |
| A2 | Preferencje żywieniowe (wykluczenia smakowe) | **nie jest to filtr alergenów** — patrz sekcja 8 |
| A3 | Wyliczenie kalorii (Mifflin-St Jeor), interfejs graficzny | pkt 4 |
| A4 | Suwaki makroskładników z ostrzeżeniami i blokadami | pkt 3, wg 3.2 |
| A5 | **Do 3 profili** z osobnymi celami, **wyłącznie osoby pełnoletnie** | pkt 25; każdy to osobne dane zdrowotne i osobna zgoda |
| A6 | Podział porcji między osoby + dodatki osobiste | pkt 17, patrz niżej |
| A7 | Automatyczny odczyt wagi (Health Connect / Apple Health) | pkt 1, etap 4 |
| A8 | Wykres obwodu talii w czasie | brakowało; talia mówi więcej niż waga |

**Jak działa podział między osoby (A6).** Z jednego garnka wszyscy jedzą
w **tych samych proporcjach** — jeśli danie ma 30% energii z białka, ma je dla
każdego. Różni się tylko wielkość porcji. Dlatego:

- porcja trafia w **jeden** cel na osobę (domyślnie kalorie)
- pozostałe makroskładniki układają się proporcjonalnie
- różnicę wyrównuje **dodatek osobisty**: „Roman dokłada 100 g kurczaka"

To jest właściwa odpowiedź na punkt 17 — nie sam procent porcji, lecz porcja
plus ewentualny dodatek.

### B. Silnik planowania

| # | Funkcja | Uwagi |
|---|---|---|
| B1 | Zawsze trzy posiłki | pkt 21, świadome ograniczenie |
| B2 | Data startu — plan układa się od niej | pkt 13 |
| B3 | Plan na minimum 7 dni | pkt 14 |
| B4 | Trwałość ustawiana w przepisie: 0–3 dni | pkt 7, 8 — patrz niżej |
| B5 | Obiady od 1 do 3 dni, nigdy dłużej | maksimum, nie wartość stała |
| B6 | Przenoszenie posiłków między dniami | pkt 6 |
| B7 | Skalowanie na 1–5 porcji | pkt 9 — porcje, nie profile |
| B8 | Partie w lodówce: ile porcji zostało, do kiedy zjeść | rdzeń pomysłu |
| B9 | Zapisywanie przez wyjątek | brakowało; patrz niżej |

**Trwałość dania (B4, B5).** Pierwotna reguła wiązała trwałość z porą posiłku:
obiady na zapas, śniadania i kolacje świeże. To błędne przypisanie — trwałość
zależy od **rodzaju dania**, nie od godziny jedzenia. Zupa nie przestaje być
zupą dlatego, że zjadasz ją wieczorem; jajecznica na obiad i tak nie zniesie
trzech dni.

Dlatego liczba dni jest **polem przepisu**, ustawianym przez moderatora:

| Wartość | Typowe zastosowanie |
|---|---|
| 0 dni — tylko świeże | jajecznica, sałatki, dania z grilla |
| 1 dzień | dania delikatne, z dużą ilością nabiału |
| 2 dni | dania rybne, zupy lekkie |
| 3 dni | zupy, gulasze, dania z kaszą i strączkami |

**Trzy dni to maksimum, nie norma.** Przepis może mieć 1 lub 2 — decyduje
charakter potrawy, nie chęć zaoszczędzenia gotowania.

Dwa różne powody prowadzą do tej samej liczby: jajecznicy nie odgrzewamy,
bo **smakuje źle**, a dań rybnych, bo **szybciej się psują**. Oba sprowadzają
się do jednego pola, więc model pozostaje prosty.

**Zakotwiczenie w bezpieczeństwie.** Ogólne zalecenie USDA to 3–4 dni dla
większości ugotowanych potraw przechowywanych w temperaturze 4°C lub niższej.
Nasze maksimum trzech dni jest więc ostrożniejsze od wytycznych.

**Ryż wymaga osobnej uwagi.** Zarodniki *Bacillus cereus* przeżywają gotowanie
i namnażają się w temperaturze pokojowej, wytwarzając toksyny. Przepisy z ryżem
muszą zawierać instrukcję szybkiego schłodzenia, niezależnie od liczby dni.

**Zapisywanie przez wyjątek (B9).** Skoro istnieje plan, zakładamy, że został
wykonany. Wieczorem jedno pytanie:

> Dzisiaj poszło zgodnie z planem? [Tak] [Coś zmieniłem]

„Tak" zamyka dzień jednym dotknięciem i odejmuje porcje z lodówki. Dopiero
„Coś zmieniłem" otwiera edycję. To najtańsza funkcja o największym wpływie
na to, czy ludzie zostaną po miesiącu.

### C. Przepisy

| # | Funkcja | Uwagi |
|---|---|---|
| C1 | Układ dwuetapowy: najpierw przygotowanie, potem wykonanie | pkt 10 |
| C2 | Precyzyjne gramatury — „1 marchewka (ok. 70 g)" | pkt 12 |
| C3 | Tagi składników do wykluczeń | pkt 5 |
| C4 | Zero kiełbas, minimum żywności przetworzonej | pkt 22, kryterium: **klasyfikacja NOVA, grupa 4** |
| C5 | Dwie niezależne osie etykiet | pkt 23, patrz niżej |
| C6 | Licznik cukrów wolnych z progiem WHO | pkt 27, **zamiast blokady**; zasady w 3.3 |
| C7 | Gramatura opakowań ze sklepu | pod planowanie bez resztek |
| C8 | Ustawienia sprzętu: garnek ciśnieniowy, grill kontaktowy, piekarnik, płyta | te same przepisy, inne czasy |
| C9 | Edytowalne ilości składników — **tylko moderator i administrator** | z przeliczeniem makro na żywo |
| C10 | Edytowalne czasy — **tylko moderator i administrator** | warianty czasów dla różnych sprzętów |
| C11 | Historia zmian przepisu | kto, kiedy, co |
| C12 | **Moja wersja przepisu** — prywatna kopia z własnymi ilościami i czasami | oryginał pozostaje nietknięty |

**Dwie osie etykiet (C5).** Kuchnia i pora posiłku to niezależne wymiary —
danie azjatyckie też jest obiadem:

- **pora:** śniadanie / obiad / kolacja
- **kuchnia:** śródziemnomorska / azjatycka / polska / inna

Żadna z kuchni nie jest marginesem — filtr traktuje je równorzędnie
(patrz sekcja 1, „O kuchni"). Etykieta służy do wyszukiwania, nie do
oceniania, czy danie „pasuje do aplikacji".

**Cukier (C6).** Dwie rzeczy działają równolegle. Na wejściu do bazy obowiązują
zasady z sekcji 3.3 — bez soków, bez cukrów dodanych, bez słodzików. Natomiast
wobec użytkownika aplikacja **informuje, nie blokuje**:
*„Ten przepis pokrywa 80% dziennego limitu cukrów wolnych"*. Bez oceniania
człowieka.

**Uwaga techniczna:** licznik nie może brać liczby z etykiety. Unijne oznaczenie
„w tym cukry" obejmuje wszystko — także laktozę i cukier z całych owoców.
Cukry wolne trzeba liczyć ze składników przepisu, a nie odczytywać z opakowania.

**Kto edytuje przepis (C9, C10).** Ilości składników i czasy są edytowalne,
ale **wyłącznie przez moderatora przepisów i administratora**. Zwykły użytkownik
przepisu nie zmienia — może go skomentować notatką (E1).

| Rola | Uprawnienia wobec przepisu |
|---|---|
| Administrator | pełna edycja oryginału, także usuwanie |
| Moderator przepisów | edycja ilości, czasów, kroków, zatwierdzanie zdjęć i publikacji |
| Użytkownik | odczyt, **własna wersja prywatna**, notatka, polubienie |

Zaleta: przepis publiczny pozostaje spójny i sprawdzony, a odpowiedzialność
za treść ma konkretną osobę — co przy aplikacji zdrowotnej ma znaczenie także
prawne. Uwagi użytkowników nie giną: trafiają do notatek, a moderator może
na ich podstawie poprawić oryginał.

Konsekwencje edycji moderatorskiej, które muszą działać automatycznie:

- **przeliczenie makroskładników na żywo** — zmiana gramatury natychmiast
  zmienia kalorie i makro posiłku oraz sumę dnia
- **aktualizacja listy zakupów** u wszystkich, którzy mają przepis w planie
- **ostrzeżenie**, jeśli zmiana zbija białko poniżej progu (miękkie, wg 3.2)
- **historia zmian** — kto, kiedy i co zmienił

**Moja wersja przepisu (C12).** Użytkownik nie zmienia oryginału, ale może
utworzyć **własną kopię prywatną** i w niej zmienić ilości składników oraz czasy.

| Warstwa | Kto zmienia | Kto widzi |
|---|---|---|
| Oryginał | moderator, administrator | wszyscy |
| Moja wersja | właściciel | wyłącznie właściciel |

Zasady działania:

- moja wersja jest **kopią w chwili utworzenia**, nie żywym odbiciem oryginału
- makro, cukry wolne i lista zakupów liczą się z mojej wersji
- gdy moderator zmieni oryginał, moja wersja **pozostaje nietknięta**;
  pojawia się jedynie informacja „oryginał został zaktualizowany" z możliwością
  podejrzenia różnic
- moja wersja nie staje się publiczna sama z siebie — publikacja wymaga
  zgłoszenia i zatwierdzenia, jak każdy przepis użytkownika (E7)
- ostrzeżenia działają tak samo: jeśli zmiana zbija białko poniżej progu,
  użytkownik dostaje informację (miękką, wg 3.2)

Dzięki temu przepis publiczny pozostaje jedną, sprawdzoną wersją, a każdy i tak
gotuje po swojemu.

**Co działa niezależnie od tego.** Dwie rzeczy nie są w ogóle edycją przepisu:

1. **Skalowanie porcji (B7)** — wybór „gotuję dla 4 osób" przelicza wszystkie
   ilości automatycznie. To parametr użycia, nie zmiana treści.
2. **Czasy zależne od sprzętu (C8)** — przepis przechowuje warianty czasów dla
   różnych urządzeń (piekarnik, garnek ciśnieniowy, grill kontaktowy, płyta), wpisane przez
   moderatora. Aplikacja pokazuje wariant pasujący do sprzętu zadeklarowanego
   w profilu. Użytkownik nic nie edytuje, a i tak widzi swoje czasy.

Wariant drugi jest lepszy niż ręczne poprawki: raz wpisany przez moderatora
działa dla wszystkich posiadaczy tego samego sprzętu.

### D. Zakupy

| # | Funkcja | Uwagi |
|---|---|---|
| D1 | Lista zakupów pogrupowana według działów sklepu | pkt 15 |
| D2 | Tryb bez internetu dla listy i przepisu | brakowało; sklep i kuchnia to słaby zasięg |
| D3 | Planowanie zamykające opakowania | z notatki o pomysłach |
| D4 | Odesłania do sklepów | pkt 11 — **odłożone**, patrz sekcja 8 |

### E. Społeczność i moderacja

| # | Funkcja | Uwagi |
|---|---|---|
| E1 | Notatki przy przepisie: prywatne albo publiczne | pkt 19 |
| E2 | Wyłączenie widoku notatek publicznych | pkt 20 |
| E3 | Zdjęcia użytkowników zatwierdzane przez moderatora | pkt 18 |
| E4 | Polubienia przepisów | „powtórzę u siebie", nie „ładne zdjęcie" |
| E5 | Zgłaszanie treści | brakowało; wymagane przez sklepy i przepisy unijne |
| E6 | Role: administrator, moderator, użytkownik | pkt 24 |
| E7 | **Przepisy użytkowników prywatne domyślnie** | publikacja wyłącznie przez zgłoszenie i zatwierdzenie |
| E8 | Stan „zgłoszone" ukrywa treść do czasu rozpatrzenia | ochrona na czas oczekiwania |

**Czat: poza zakresem.** Wymiana doświadczeń odbywa się przez notatki publiczne.
Baza zostanie zaprojektowana tak, żeby czat dało się dopisać później, ale nie
budujemy go teraz — odpada stała moderacja rozmów na żywo.

### F. Dane i prywatność

| # | Funkcja | Uwagi |
|---|---|---|
| F1 | Plan i pomiary widoczne wyłącznie dla właściciela | pkt 16, reguły w bazie (RLS) |
| F2 | Osobna, wyraźna zgoda na dane o zdrowiu | RODO, kategoria szczególna |
| F3 | Eksport własnych danych | RODO |
| F4 | Usunięcie konta z poziomu aplikacji | wymóg Apple przy kontach |
| F5 | Bariera wieku 18+ | liczenie kalorii u nastolatków to uznane ryzyko |
| F6 | Region bazy: Unia Europejska | dane zdrowotne nie opuszczają UE |
| F7 | Umowa powierzenia przetwarzania (DPA) z Supabase | wymóg RODO |
| F8 | Rozdzielenie tożsamości od danych zdrowotnych | osobne tabele, węższy dostęp |

### F.1. Szyfrowanie danych — co jest, a czego nie warto robić

**Działa automatycznie, nic nie trzeba programować:**

| Warstwa | Stan |
|---|---|
| Dane w bazie i kopie zapasowe | szyfrowane AES-256 |
| Połączenie aplikacja ↔ baza | szyfrowane TLS |
| Certyfikaty | ISO 27001, SOC 2 Type II |
| Region UE | dane pozostają w regionie; dostępna umowa DPA |

To pokrywa wymóg „odpowiednich środków technicznych" z artykułu 32 RODO
w zakresie szyfrowania. Zwykłe podejrzenie „a co, jeśli ktoś wykradnie plik
bazy" jest tym załatwione.

**Szyfrowanie pojedynczych kolumn — odradzane.**
Supabase odradza używanie Transparent Column Encryption z rozszerzenia
pgsodium: całe rozszerzenie jest w trakcie wycofywania, a możliwość szyfrowania
kolumn usunięto z panelu, bo zbyt łatwo było ją włączyć bez zrozumienia
konsekwencji. Nowych wdrożeń nie zaleca sam dostawca.

**Supabase Vault** pozostaje, ale służy do czego innego — do przechowywania
sekretów (kluczy, tokenów), nie danych użytkowników.

**Dlaczego to i tak nie jest właściwa obrona.** Szyfrowanie kolumn chroni przed
jednym scenariuszem: ktoś zdobywa kopię plików bazy. Ten scenariusz jest już
pokryty szyfrowaniem dyskowym. Nie chroni natomiast przed ryzykiem realnym:
wyciekiem klucza serwisowego albo błędem w regułach dostępu — bo w obu tych
przypadkach dane odszyfrowują się same, w drodze do napastnika.

**Koszt uboczny, o którym warto wiedzieć.** Zaszyfrowanej kolumny nie da się
sensownie sortować, filtrować, sumować ani użyć w regułach dostępu. Gdyby
zaszyfrować wagę i obwód talii, wykres postępu (A8) musiałby powstawać w całości
na urządzeniu — koniec z liczeniem średnich po stronie bazy.

**Co robimy zamiast tego** — w kolejności skuteczności:

1. **Reguły dostępu na każdej tabeli**, domyślnie odmowa. To tu wydarzy się
   ewentualny wyciek, nie w kryptografii.
2. **Zbieramy minimum.** Imię zamiast pełnych danych, brak adresu, brak numeru
   telefonu. Danych, których nie ma, nie da się wykraść.
3. **Rozdzielenie tożsamości od zdrowia** — konto w jednej tabeli, waga i talia
   w innej, powiązane identyfikatorem.
4. **Klucz serwisowy nigdy w aplikacji.** Aplikacja mobilna i webowa używa
   wyłącznie klucza publicznego, ograniczonego regułami dostępu.
5. **Region UE i umowa DPA.**

Szyfrowanie po stronie aplikacji (dane szyfrowane zanim opuszczą telefon)
zostaje w odwodzie dla wąskiego przypadku — np. treści notatek prywatnych,
gdzie i tak niczego nie sortujemy. Nie na start.

### G. Treści edukacyjne

| # | Funkcja | Uwagi |
|---|---|---|
| G1 | Strona o wzorcu śródziemnomorskim jako punkcie odniesienia — co z niego bierzemy i czego nie | pkt 2, 26; patrz sekcja 1 „O kuchni" |
| G2 | Strona o przyjętych normach: NIZP-PZH, AMDR, WHO | pkt 26, **po korekcie źródeł** |
| G3 | Zastrzeżenie o braku porad medycznych | ciąża, cukrzyca, choroby nerek, zaburzenia odżywiania → lekarz |
| G5 | Zastrzeżenie o braku obsługi alergenów | „Talerz nie filtruje alergenów. Przy alergii sprawdź skład przepisu i etykiety produktów" |
| G4 | Zastrzeżenie o braku powiązania z NIZP-PZH | patrz 3.1 |

---

## 5. Model danych w zarysie

Tabele, które wynikają z powyższego zakresu. Szczegóły przy projektowaniu bazy.

| Tabela | Zawartość |
|---|---|
| `konta` | logowanie, rola, zgody, data usunięcia |
| `profile` | imię, wiek, płeć, wzrost, waga, talia (do 3 na konto) |
| `cele` | kcal i makro na profil, obowiązujące od daty |
| `pomiary` | waga i talia w czasie, źródło: ręczne albo Health Connect |
| `skladniki` | gramatura opakowania, makro na 100 g, **cukry wolne osobno od cukrów ogółem**, grupa NOVA, tagi |
| `przepisy` | nazwa, pora, kuchnia, czas, trwałość w dniach (0–3), autor, **widoczność: prywatna / zgłoszona / publiczna** |
| `przepis_skladniki` | gramy + opis potoczny („1 marchewka, ok. 70 g") |
| `kroki` | etap (przygotowanie / wykonanie), kolejność, treść |
| `plany` | data startu, długość, właściciel |
| `plan_pozycje` | dzień, pora, przepis, liczba porcji, powiązanie z partią |
| `partie` | ugotowany garnek: porcji razem, porcji zostało, ważne do |
| `czasy_sprzet` | warianty czasów kroku dla piekarnika, garnka ciśnieniowego, grilla, płyty |
| `historia_przepisu` | kto, kiedy i co zmienił w oryginale |
| `wersje_uzytkownika` | prywatna kopia przepisu: własne ilości i czasy |
| `notatki` | treść, prywatna czy publiczna |
| `polubienia` | kto, co |
| `zgloszenia` | zgłoszona treść, powód, stan obsługi |

Kluczowe decyzje strukturalne, kosztowne do zmiany później:

- **partia jest osobnym bytem**, nie polem w pozycji planu
- **składnik ma tagi i gramaturę opakowania** od pierwszego dnia
- **pora i kuchnia to dwie niezależne etykiety**, nie jedna kategoria
- **profil jest oddzielony od konta** — jedno konto, do trzech profili
- **przepis ma jedną wersję publiczną** — edytuje ją wyłącznie moderator lub
  administrator; wersje prywatne użytkowników są osobną warstwą

---

## 6. Etapy realizacji

**Etap 0 — zasilenie bazy** *(równolegle z etapem 1, patrz sekcja 10)*
Baza 300–400 składników z USDA. Skrypt importujący z walidacją. Przeniesienie
przepisów z dotychczasowego planera HTML. Cel: 50–60 przepisów przed premierą.

**Etap 1 — fundament**
Baza danych, konta, role, reguły dostępu (F1, E6). Profil z celami i blokadami
(A1–A5). Przepisy z tagami i gramaturami (C1–C3, C7). Trzy posiłki (B1).
Plan 7-dniowy z datą startu (B2, B3). Przenoszenie posiłków (B6). Lista
zakupów (D1). Strony edukacyjne (G1–G4) — bo od nich zależy uzasadnienie blokad.

**Etap 2 — to, co nas odróżnia**
Partie i trwałość dania (B4, B5, B8). Skalowanie porcji (B7). Zapisywanie
przez wyjątek (B9). Edycja ilości i czasów (C9, C10). Wykres talii (A8).
Licznik cukrów wolnych (C6). Tryb bez internetu (D2).

**Etap 3 — społeczność**
Notatki (E1, E2). Zdjęcia z moderacją (E3). Polubienia (E4). Zgłaszanie
treści (E5). Wymogi prawne przed publiczną premierą (F2–F5).

**Etap 4 — integracje i dopieszczanie**
Health Connect i Apple Health (A7) — wymaga przejścia na development build.
Cele rodzinne z podziałem porcji (A6). Planowanie zamykające opakowania (D3).
Ustawienia sprzętu kuchennego (C8).

---

## 7. Obowiązki przed publiczną premierą

Rzeczy spoza kodu, bez których sklepy nie dopuszczą aplikacji:

- polityka prywatności i regulamin
- osobna zgoda na przetwarzanie danych o zdrowiu
- eksport i usunięcie danych, usunięcie konta w aplikacji
- mechanizm zgłaszania treści i procedura ich obsługi
- zastrzeżenie o braku porad medycznych
- bariera wieku 18+
- konto Apple Developer (99 USD rocznie) i Google Play (25 USD jednorazowo)

---

## 8. Co świadomie odrzucamy

| Odrzucone | Powód |
|---|---|
| Zakaz cukru z komunikatem oceniającym | sprzeczny z kuchnią śródziemnomorską; moralizowanie przy jedzeniu bywa szkodliwe |
| Twarde blokady poza zakresem AMDR | zablokowałyby dietę autora, która jest bezpieczna |
| Piramida żywieniowa z USA jako podstawa | wycofana w 2011 roku |
| Czat na żywo w pierwszych wersjach | koszt moderacji nieproporcjonalny do korzyści |
| Odesłania zakupowe do konkretnych produktów | brak publicznego dostępu do cen Lidla, wygasające odnośniki, obowiązki informacyjne przy odsyłaczach partnerskich |
| Gotowe programy diet (wegańska, keto) | brak kompetencji do ich firmowania; wariant roślinny przyjdzie od użytkowników przez tagi |
| Liczenie kalorii ze zdjęcia | duży błąd pomiaru, szybka utrata zaufania do liczb |
| Punkty, odznaki, serie dni | przy jedzeniu potrafią wzmacniać niezdrowe zachowania |
| **Obsługa alergii i filtr alergenów** | patrz uzasadnienie poniżej |

---

### 8.1. Dlaczego rezygnujemy z obsługi alergii

Rzetelny filtr alergenowy wymagałby otagowania każdego składnika czternastoma
alergenami z rozporządzenia UE 1169/2011, wraz ze źródłami ukrytymi — gorczyca
w musztardzie, seler w kostkach rosołowych, siarczyny w suszonych owocach.
Jedno przeoczenie i filtr milczy tam, gdzie powinien ostrzec.

**Filtr alergenowy z dziurami jest gorszy niż jego brak**, bo buduje fałszywe
poczucie bezpieczeństwa u osoby, dla której pomyłka kończy się wstrząsem
anafilaktycznym. Skoro nie zbudujemy go rzetelnie, nie budujemy go wcale.

Aplikacja publikuje przepisy, nie podaje jedzenia. Precyzyjne składy z gramaturami
(C2) są pełną informacją — osoba uczulona na ryby widzi „200 g dorsza" i pomija
przepis.

**Warunek obowiązkowy:** słowo „alergia" nie pojawia się nigdzie w interfejsie.
Wykluczenia z punktu A2 nazywamy **preferencjami** i tylko tak. Gdyby użytkownik
mógł je odczytać jako filtr bezpieczeństwa, wracamy do problemu fałszywego
poczucia bezpieczeństwa — tyle że tylnymi drzwiami.

---

## 9. Decyzje podjęte

### 9.1. Dzieci wykluczone

Wszystkie profile dotyczą wyłącznie osób pełnoletnich. Aplikacja nie prowadzi
celów żywieniowych dla dzieci i młodzieży.

**Co z tego wynika:**

- punkt 17 z pierwotnej listy („mężczyzna, kobieta, dziecko") zawęża się:
  cele ustawiamy dla dorosłych, dziecko **nie ma profilu**
- gotowanie dla dziecka pozostaje możliwe — jako **liczba porcji** (B7), bez
  celów i bez śledzenia. Skalowanie na 4 osoby działa niezależnie od tego, kto
  siedzi przy stole
- w regulaminie: korzystanie wyłącznie przez osoby pełnoletnie, deklaracja wieku
  przy zakładaniu konta i każdego profilu

To decyzja bezpieczeństwa, nie ograniczenie techniczne: liczenie kalorii
i cele redukcyjne u nastolatków to uznane ryzyko zaburzeń odżywiania.

### 9.2. Przepisy prywatne domyślnie

Przepis dodany przez użytkownika jest widoczny wyłącznie dla niego. Publikacja
wymaga zgłoszenia przez autora i zatwierdzenia przez moderatora.

**Co z tego wynika:**

- moderacja obejmuje **cały przepis**, nie tylko zdjęcie (E3 rozszerzone)
- ryzyko przypadkowego upublicznienia danych osobistych w treści spada do zera
- obciążenie moderacyjne rośnie tylko wtedy, gdy ktoś świadomie chce publikować
- **konsekwencja na start:** baza przepisów będzie na początku pusta,
  więc pierwsze przepisy musi wprowadzić administrator. To praca do zaplanowania
  przed premierą, nie po niej

### 9.3. Moderacja: administrator, reakcja do 24 godzin

Na starcie rolę moderatora pełni administrator. Deklarowany czas reakcji
na zgłoszenie: 24 godziny.

**Uwaga do sformułowania w regulaminie.** Zapis „rozpatrujemy zgłoszenia
w ciągu 24 godzin" jest zobowiązaniem, które obowiązuje także w weekendy,
święta i podczas urlopu. Przy jednej osobie bezpieczniejsze jest sformułowanie
**„zwykle w ciągu 24 godzin"**, a docelowo — drugi moderator, zanim liczba
użytkowników urośnie.

Do czasu rozpatrzenia zgłoszona treść jest ukryta (E8). Lepiej pokazać mniej
przez dobę niż zostawić widoczne coś, co wymaga usunięcia.

### 9.4. Białko przeliczane na kilogram masy ciała

Cel białkowy wynika ze współczynnika g/kg, zależnego od wieku i poziomu
aktywności fizycznej. Próg na posiłek to jedna trzecia celu dziennego.

Szczegóły, w tym pułapka masy odniesienia przy otyłości, w sekcji 3.4.
Konkretne współczynniki pochodzą z Norm żywienia dla populacji Polski (2024)
i muszą zostać z nich odczytane przed wdrożeniem.

---

## 10. Zasilanie bazy przed premierą

Skoro przepisy są prywatne domyślnie (9.2), pierwsze musi wprowadzić
administrator. To praca do wykonania **przed** premierą.

### 10.1. Kolejność: składniki przed przepisami

Przepisu się nie wpisuje — przepis się **wylicza**. Przy porządnej bazie
składników przepis to lista par *składnik + gramy* oraz kroki. Kalorie, makro,
cukry wolne i grupa NOVA wyliczają się automatycznie.

Bez bazy składników każdy przepis trzeba by liczyć ręcznie i tam projekt
utknie. Dlatego kolejność jest odwrotna do intuicyjnej:

> **Najpierw 300–400 składników. Dopiero potem przepisy.**

Tyle wystarczy na kuchnię domową w zakresie, jaki obejmuje aplikacja.

### 10.2. Źródła danych o składnikach

| Źródło | Licencja | Werdykt |
|---|---|---|
| **USDA FoodData Central** | CC0, domena publiczna, API z darmowym kluczem | **tak** — surowce, brak zobowiązań |
| **Open Food Facts** | ODbL — uznanie autorstwa i na tych samych warunkach | **tak** — polskie produkty, kody kreskowe, NOVA; konsekwencje w 10.2.1 |
| Tabele składu żywności IŻŻ | prawo autorskie | nie do przedruku |

### 10.2.1. Co dokładnie oznacza ODbL — decyzja przyjęta

**Przyjmujemy Open Food Facts.** Poniżej pełne konsekwencje.

ODbL rozróżnia trzy rzeczy i to rozróżnienie jest tu kluczowe:

| Pojęcie | Co to u nas | Czy obejmuje je licencja |
|---|---|---|
| **Baza pochodna** | nasza tabela składników, jeśli powstanie z danych OFF | **tak** — udostępniana na tych samych warunkach |
| **Dzieło wytworzone** | przepisy, plany, ekrany aplikacji, wyliczone makro | **nie** — dowolne warunki, wystarczy informacja o źródle |
| **Sposób zarobkowania** | reklamy, abonament, funkcje płatne | **nie dotyczy w ogóle** |

**Czy można zarabiać na reklamach: tak.** ODbL przyznaje prawo do komercyjnego
wykorzystania bez opłat licencyjnych. Reklamy, abonament, wersja płatna —
licencja tego nie ogranicza i nie żąda udziału w przychodach.

**Co realnie oddajesz:** wyłączność na **tabelę składników**, nie na pieniądze.
Na żądanie musisz udostępnić bazę pochodną na warunkach ODbL. Przepisy,
plany użytkowników, ich dane i sama aplikacja pozostają Twoje.

Innymi słowy: konkurent może poprosić o Twoją tabelę wartości odżywczych
marchewki. Nie może zażądać Twoich przepisów, użytkowników ani przychodów.

**Obowiązki, o których trzeba pamiętać:**

1. **Uznanie autorstwa** — informacja o źródle i licencji, widoczna w aplikacji
   (np. na stronie „O danych")
2. **Na tych samych warunkach** — baza pochodna udostępniana na ODbL na żądanie
3. **Zdjęcia produktów z OFF** mają osobną licencję (CC BY-SA) — jeśli w ogóle
   ich użyjemy, wymagają własnego oznaczenia

**Jak ograniczyć zasięg zobowiązania.** Trzymać dane z OFF w **wyodrębnionej
tabeli**, a własne ustalenia (gramatury spisane z etykiet, autorska selekcja
składników) osobno. Wtedy granica tego, co trzeba udostępnić, jest wyraźna.
Wymieszanie wszystkiego w jednej tabeli tę granicę zaciera.

> **Zastrzeżenie:** to opis mechanizmu licencji, nie porada prawna — nie jestem
> prawnikiem. Jeśli baza składników miałaby stać się aktywem firmy, warto
> potwierdzić to u prawnika od własności intelektualnej przed premierą.

**Nadal warto** brać surowce (marchew, dorsz, oliwa) z USDA, bo są w domenie
publicznej i nie wnoszą żadnych zobowiązań. Open Food Facts przydaje się tam,
gdzie USDA nie sięga: polskie produkty z półki, kody kreskowe i gotowa
klasyfikacja NOVA.

### 10.3. Sposób ładowania

Plik strukturalny (JSON lub arkusz) z odwołaniami do składników po
identyfikatorze oraz skrypt importujący dostępny **wyłącznie dla administratora**.

Skrypt waliduje przy wejściu i odrzuca:

- nieznany składnik
- brak gramatury
- naruszenie reguł z sekcji 3.3 (cukry, soki, czekolada, sól)
- brak ustawionej trwałości (B4)

Dzięki temu reguły przestają być zapisem w dokumencie, a stają się działającym
filtrem. Ten sam skrypt obsługuje później dodawanie pojedynczych przepisów.

### 10.4. Ile przepisów na start

Tydzień to około 3 obiady (partie na 2–3 dni), 4–5 kolacji i 7 śniadań, przy
czym śniadania bywają powtarzane chętnie. Realnie **15 dań tygodniowo**.

| Cel | Liczba przepisów |
|---|---|
| Miesiąc bez powtórek | 50–60 |
| Minimum na premierę | 30 |

Przy gotowej bazie składników jeden przepis to 10–15 minut pracy. Sześćdziesiąt
przepisów to kilkanaście godzin — nieprzyjemne, ale policzalne.

### 10.5. Skąd treść

**Punkt wyjścia: własny planer HTML** z przepisami dopracowanymi przez lata pod
konkretne ograniczenia. Materiał sprawdzony w praktyce i bez kłopotu prawnego.
Przeniesienie go jest pierwszym zadaniem tego etapu.

**Czego nie robimy:** nie pobieramy przepisów z cudzych stron. Sama lista
składników nie podlega ochronie, ale opisy kroków i zdjęcia już tak.

**Rola sztucznej inteligencji:** pomoc przy redagowaniu kroków i porządkowaniu
zapisu — **nigdy przy liczbach**. Makroskładniki zawsze wyliczamy z bazy
składników, nigdy nie przyjmujemy ich od modelu językowego.

---

## 11. Decyzje podjęte — druga tura

1. **Sól nie jest osią zasad.** Warunek „bez dodatku soli" przy sokach
   warzywnych zniesiony, bo nie mógł rządzić jedną kategorią, skoro nie
   obowiązuje nigdzie indziej. Zostają dwie osie: cukry wolne i NOVA.
2. **„Moja wersja" przepisu wchodzi** jako prywatna warstwa nad oryginałem
   (C12). Oryginał nadal edytuje wyłącznie moderator.
3. **Open Food Facts przyjęty** wraz z zobowiązaniami ODbL. Zarabianie
   na reklamach pozostaje nieograniczone — szczegóły w 10.2.1.

---

## 12. Pozostaje do rozstrzygnięcia

1. Model zarobkowy: reklamy, abonament, wersja płatna czy aplikacja darmowa?
   (wpływa na politykę prywatności i wymogi sklepów — reklamy w aplikacji
   zdrowotnej mają własne ograniczenia)
2. Ile przepisów administrator wprowadza przed premierą — cel 50–60 czy
   minimum 30?
3. Czy strona „O danych" z uznaniem autorstwa jest osobnym ekranem, czy
   częścią strony edukacyjnej (G1–G2)?

---

## Źródła

- [Talerz zdrowego żywienia — NCEŻ, NIZP-PZH](https://ncez.pzh.gov.pl/abc-zywienia/talerz-zdrowego-zywienia/)
- [Normy żywienia dla populacji Polski — edycja 2024](https://ncez.pzh.gov.pl/abc-zywienia/zasady-zdrowego-zywienia/normy-zywieniowe-2024/)
- [Acceptable Macronutrient Distribution Range — NCBI](https://www.ncbi.nlm.nih.gov/books/NBK610333/)
- [MyPlate — zastąpienie piramidy w 2011](https://en.wikipedia.org/wiki/MyPlate)
- [WHO — Guideline: Sugars Intake for Adults and Children](https://www.ncbi.nlm.nih.gov/books/NBK285525/)
- [WHO — Use of non-sugar sweeteners (2023)](https://www.ncbi.nlm.nih.gov/books/NBK592246/)
- [PAHO/WHO — komunikat o słodzikach](https://www.paho.org/en/news/15-5-2023-who-advises-not-use-non-sugar-sweeteners-weight-control-newly-released-guideline)
- [Security at Supabase — szyfrowanie i certyfikaty](https://supabase.com/security)
- [pgsodium (pending deprecation) — Supabase Docs](https://supabase.com/docs/guides/database/extensions/pgsodium)
- [pgsodium / TCE not recommended and deprecated — dyskusja Supabase](https://github.com/orgs/supabase/discussions/27109)
- [USDA FoodData Central — dokumentacja i API](https://fdc.nal.usda.gov/data-documentation/)
- [Open Food Facts — warunki ponownego wykorzystania danych (ODbL)](https://world.openfoodfacts.org/terms-of-use)
- [USDA — Leftovers and Food Safety](https://www.fsis.usda.gov/food-safety/safe-food-handling-and-preparation/food-safety-basics/leftovers-and-food-safety)
