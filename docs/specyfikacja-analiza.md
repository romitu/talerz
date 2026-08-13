# Talerz — analiza listy funkcji

Przegląd 27 punktów: co jest mocne, co wymaga korekty merytorycznej, co się
wzajemnie wyklucza i czego brakuje. Notatka teoretyczna — nic z tego nie zostało
zaprogramowane.

---

## 1. Ocena ogólna

Lista jest spójna i widać w niej jeden pomysł na produkt, a nie zbiór luźnych
życzeń. Mocne punkty, które od razu odróżniają Talerz od konkurencji:

- **precyzyjne gramatury składników** (pkt 12) — brzmi drobno, a rozwiązuje realny
  problem: „jedna marchewka" waży od 40 do 120 g i psuje każde wyliczenie makro
- **przygotowanie przed gotowaniem** (pkt 10) — porządek, którego nie ma
  w przepisach z internetu
- **obiady na trzy dni, śniadania i kolacje świeże** (pkt 7, 8) — to jest ta luka
  rynkowa, o której była mowa, i od razu z sensownym ograniczeniem
- **cele dla kilku osób z podziałem porcji** (pkt 17) — rzadkie i trudne do
  skopiowania, bo wymaga przemyślenia, a nie tylko kodu
- **blokady bezpieczeństwa przy celach** (pkt 3, 4) — dobry instynkt, choć oparty
  na złym źródle; patrz niżej

Trzy punkty wymagają korekty merytorycznej, pięć wzajemnie się wyklucza,
a dziesięć rzeczy na liście brakuje. Po kolei.

---

## 2. Błędy merytoryczne do poprawienia

### 2.1. Piramida żywieniowa z USA już nie istnieje (dotyczy pkt 3, 4, 26)

Amerykańska piramida została **wycofana 2 czerwca 2011 roku** i zastąpiona
grafiką **MyPlate**. Opieranie aplikacji wypuszczanej w 2026 roku na wycofanym
przed piętnastu laty modelu byłoby łatwe do wytknięcia — zwłaszcza że strona
edukacyjna (pkt 26) ma tłumaczyć, *dlaczego* akurat ten model wybraliśmy.

**Czego naprawdę potrzebujesz** — to nie piramida, tylko konkretne zakresy liczbowe:

**AMDR** (Acceptable Macronutrient Distribution Ranges), dorośli od 19 lat:

| Składnik | Zakres (% energii dziennej) |
|---|---|
| Białko | 10–35% |
| Tłuszcz | 20–35% |
| Węglowodany | 45–65% |

To jest właściwa podstawa pod suwaki z punktu 3.

**Dla aplikacji polskiej lepsze źródło:** NIZP-PZH wydał pod koniec 2024 roku nową
edycję **„Norm żywienia dla populacji Polski"**, a w 2020 zastąpił polską piramidę
grafiką **„Talerz Zdrowego Żywienia"**. Powoływanie się na normy krajowe jest
mocniejsze prawnie i bardziej wiarygodne dla polskiego użytkownika niż odwołanie
do wytycznych amerykańskich.

**Zbieg okoliczności wart odnotowania:** oficjalny polski model nazywa się
*Talerz*. Nazwa aplikacji trafia w to idealnie.

> **Uwaga prawna:** właśnie dlatego trzeba wyraźnie napisać, że Talerz nie jest
> powiązany z NIZP-PZH ani przez nikogo firmowany. Podobieństwo nazwy nie może
> sugerować oficjalnego patronatu.

### 2.2. Twoja własna dieta nie przeszłaby Twojej blokady

Sprawdziłem plan, który mamy w aplikacji, względem AMDR:

| Składnik | Twoje wartości | Udział energii | AMDR | Wynik |
|---|---|---|---|---|
| Białko | 142 g | 24,8% | 10–35% | mieści się |
| Tłuszcz | 82 g | 32,2% | 20–35% | mieści się |
| Węglowodany | 246 g | **43,0%** | 45–65% | **poniżej dolnej granicy** |

Twój plan jest o dwa punkty procentowe poniżej progu węglowodanów. Twarda blokada
z punktu 3 zablokowałaby autorowi aplikacji jego własną dietę — a przecież nie
jest to dieta niebezpieczna, tylko rozsądnie ułożona pod wysokie białko.

**Wniosek:** rozdziel dwa poziomy.

- **Ostrzeżenie miękkie** (można kliknąć „rozumiem, zostaw"): wyjście poza AMDR
- **Blokada twarda** (nie da się ustawić): wartości realnie groźne — kalorie
  poniżej podstawowej przemiany materii, deficyt powyżej ok. 1 kg tygodniowo,
  białko powyżej 35% energii

Blokujemy niebezpieczeństwo, nie nietypowość.

### 2.3. Zakaz cukru jest sprzeczny sam ze sobą (pkt 27)

Trzy problemy.

**Sprzeczność wewnętrzna.** Punkt 2 mówi „kuchnia śródziemnomorska". Ta kuchnia
stoi na owocach, miodzie, daktylach i suszonych figach. Blokada przepisów
z cukrem wycięłaby połowę tego, co sama aplikacja promuje.

**Nieprecyzyjność.** „Cukier" to nie jedna rzecz. WHO operuje pojęciem **cukrów
wolnych**: to cukry dodane przez producenta lub kucharza plus te obecne w miodzie,
syropach i sokach owocowych. Cukier zawarty w całym owocu i laktoza w mleku
**nie są** cukrami wolnymi. Zalecenie WHO to poniżej 10% energii dziennej,
a docelowo poniżej 5% — czyli około 25 g dziennie dla dorosłego.

**Ryzyko dla użytkowników.** Komunikat „aplikacja nie wspiera niezdrowego
odżywiania się" w połączeniu z liczeniem kalorii i publiczną społecznością
to mieszanka, która u części osób wzmacnia zaburzenia odżywiania. Moralizujący
ton przy jedzeniu bywa realnie szkodliwy, a przy aplikacji publicznej nie masz
kontroli nad tym, kto ją zainstaluje. To nie jest teoretyczne zastrzeżenie —
to znany mechanizm.

**Propozycja zamiast zakazu:**

- licznik cukrów wolnych z progiem WHO, widoczny przy przepisie i w podsumowaniu dnia
- oznaczenie przepisów przekraczających próg, bez blokowania i bez oceniania
  człowieka
- neutralny język: *„Ten przepis pokrywa 80% dziennego limitu cukrów wolnych"*
  zamiast *„Chcesz być zdrowy, nie możesz spożywać cukru"*

Informacja zamiast wyroku. Skuteczniejsza i bezpieczniejsza.

### 2.4. Białko na osobę jak najbardziej da się ustawić (pkt 25)

Twoja wątpliwość — „chyba np. białka nie da się potem" — jest niepotrzebna.
Cel białkowy dla każdej osoby ustawia się prosto, w gramach na kilogram masy
ciała, i przy osobach po pięćdziesiątce jest to **ważniejsze** niż same kalorie.

Prawdziwe ograniczenie jest inne i warto je znać dokładnie: **z jednego garnka
wszyscy jedzą w tych samych proporcjach**. Jeśli danie ma 30% energii z białka,
to ma je dla każdego — różni się tylko wielkość porcji. Da się więc trafić
w jeden cel na osobę (zwykle kalorie), a reszta ułoży się proporcjonalnie.

Żeby dać komuś inne proporcje, potrzebny jest **dodatek osobisty**: „tata dokłada
100 g kurczaka". I to jest właściwa odpowiedź na punkt 17 — nie procent porcji,
tylko porcja plus ewentualny dodatek.

---

## 3. Sprzeczności do rozstrzygnięcia

| # | Na czym polega | Propozycja |
|---|---|---|
| 1 | Pkt 9 mówi o gotowaniu dla 5 osób, pkt 25 o maksymalnie 3 użytkownikach | Rozdzielić pojęcia: **liczba porcji** (1–5, dowolna) to co innego niż **profil z celami** (1–3, bo każdy wymaga danych i zgód) |
| 2 | Pkt 16 mówi „każdy widzi wyłącznie swój plan", a wcześniej ustaliliśmy czat, lajki i wspólne przepisy | Rozdzielić warstwy: **plan i pomiary prywatne**, **przepisy i notatki publiczne**. Bez tego nie da się zaprojektować reguł dostępu w bazie |
| 3 | Pkt 23 traktuje „dania azjatyckie" jako czwartą kategorię obok śniadań, obiadów i kolacji | To dwie różne osie. Pora posiłku i kuchnia to niezależne etykiety — danie azjatyckie też jest przecież obiadem. Zamiast kategorii: **tagi na dwóch osiach** |
| 4 | Pkt 23 wprowadza kuchnię azjatycką, a pkt 2 deklaruje śródziemnomorską tożsamość | Decyzja świadoma: albo kuchnia azjatycka jest dopuszczonym marginesem, albo tożsamość brzmi szerzej. Nie da się być jednocześnie wąskim i szerokim |
| 5 | Pkt 11 (linki gdzie kupić) — Lidl nie ma publicznego interfejsu z cenami | Linki wygasają, a odsyłacze partnerskie wymagają ujawnienia. Rozważyć wyłącznie odesłanie do wyszukiwarki sklepu, albo odłożyć |

**Pytanie otwarte:** na tej liście nie ma czatu, który był wcześniej jednym
z filarów. Zrezygnowałeś świadomie, czy wypadł przypadkiem? To zmienia zakres
obowiązków moderacyjnych, więc trzeba wiedzieć.

---

## 4. Czego brakuje

### Krytyczne — bez tego nie da się ruszyć

1. **Wzrost użytkownika.** Punkt 25 wymienia wiek, płeć, wagę i talię, ale nie
   wzrost. Bez niego nie policzysz zapotrzebowania kalorycznego — wzór
   Mifflina-St Jeora, standard w tej dziedzinie, wymaga wzrostu.
2. **Alergie osobno od preferencji.** Punkt 5 obsługuje wykluczenia smakowe.
   Alergia to inna kategoria: pomyłka kończy się wstrząsem anafilaktycznym, a nie
   niesmakiem. Wymaga wyraźniejszego oznaczenia i ostrzeżenia o możliwych
   śladowych ilościach.
3. **Zastrzeżenie medyczne.** Aplikacja nie udziela porad medycznych. Ciąża,
   cukrzyca, choroby nerek, zaburzenia odżywiania — odesłanie do lekarza.
   Przy publicznej aplikacji zdrowotnej to nie jest formalność.
4. **Granica wieku 18+.** Liczenie kalorii i cele redukcyjne u nastolatków to
   uznane ryzyko. Skoro aplikacja jest publiczna, potrzebna jest bariera wieku
   i jasny zapis w regulaminie.
5. **Obowiązki RODO.** Zgoda na dane o zdrowiu (osobna, wyraźna), eksport danych,
   usunięcie konta, polityka prywatności. Apple dodatkowo wymaga możliwości
   **usunięcia konta z poziomu aplikacji**, jeśli da się je w niej założyć.

### Ważne — wpływa na to, czy ktoś zostanie

6. **Zapisywanie przez wyjątek.** Z poprzedniej rozmowy, zniknęło z listy.
   Jedno pytanie wieczorem zamiast trzech wpisów dziennie. Najtańsza rzecz
   o największym wpływie na to, czy ludzie zostaną po miesiącu.
7. **Widok postępu.** Zbierasz obwód talii (pkt 25), ale nigdzie go nie
   pokazujesz. Wykres talii w czasie — zgodnie z Twoją własną zasadą, że talia
   mówi więcej niż waga.
8. **Tryb bez internetu.** Lista zakupów w sklepie i przepis podczas gotowania
   muszą działać przy słabym zasięgu.
9. **Zgłaszanie treści.** Aplikacja publiczna z treściami użytkowników wymaga
   mechanizmu zgłaszania — wymagają tego zarówno sklepy, jak i przepisy unijne.
10. **Ekran ustawień gotowania.** Cook4Me, grill kontaktowy, zwykły piekarnik —
    te same przepisy, inne czasy. Drobiazg, który buduje wrażenie, że aplikację
    pisał ktoś, kto naprawdę gotuje.

---

## 5. Uporządkowana specyfikacja

Te same 27 punktów, pogrupowane w moduły — w takiej formie da się z tego
zaprojektować bazę danych.

### A. Profil i cele
- 4, 25 — dane osoby: wiek, płeć, waga, **wzrost**, obwód talii
- 4 — wyliczenie zapotrzebowania kalorycznego, interfejs graficzny
- 3 — suwaki makroskładników z ostrzeżeniami (AMDR) i blokadami (bezpieczeństwo)
- 25 — do 3 profili z osobnymi celami
- 17 — podział porcji między osoby, dodatki osobiste
- 1 — automatyczne pobieranie wagi (Health Connect / Apple Health) — etap późniejszy

### B. Silnik planowania
- 21 — zawsze trzy posiłki
- 13 — data startu, plan układa się od niej
- 14 — plan minimum 7 dni
- 7 — obiady gotowane na maksymalnie 3 dni
- 8 — śniadania i kolacje zawsze świeże
- 6 — przenoszenie posiłków między dniami
- 9 — skalowanie na 1–5 porcji

### C. Przepisy
- 10 — układ dwuetapowy: przygotowanie, potem wykonanie
- 12 — precyzyjne gramatury (jedna marchewka = ile gramów)
- 5 — tagi składników do wykluczeń
- 22 — zero kiełbas, minimum żywności przetworzonej *(warto oprzeć na
  klasyfikacji NOVA — grupa 4 to żywność wysoko przetworzona; kryterium
  obiektywne zamiast uznaniowego)*
- 23 — etykiety kuchni jako druga oś, nie osobna kategoria
- 27 — licznik cukrów wolnych zamiast blokady

### D. Zakupy
- 15 — lista zakupów pogrupowana według działów sklepu
- 11 — odesłania do sklepów — do rozstrzygnięcia, patrz sprzeczność nr 5

### E. Społeczność i moderacja
- 18 — zdjęcia użytkowników zatwierdzane przez moderatora
- 19 — notatki prywatne i publiczne przy przepisie
- 20 — wyłączenie widoku notatek publicznych
- 24 — role: administrator, moderator, użytkownik

### F. Dane i prywatność
- 16 — plan i pomiary widoczne wyłącznie dla właściciela (reguły w bazie)

### G. Treści edukacyjne
- 2, 26 — strona o kuchni śródziemnomorskiej i o przyjętych normach żywienia

---

## 6. Proponowana kolejność

**Etap 1 — fundament.** Baza, role i reguły dostępu (16, 24). Profil z celami
(4, 25 + wzrost). Przepisy z tagami (5, 12, 22). Trzy posiłki (21). Plan 7-dniowy
z datą startu (13, 14). Przenoszenie posiłków (6). Lista zakupów (15).

**Etap 2 — to, co nas odróżnia.** Partie i obiady na 3 dni (7, 8). Skalowanie
porcji (9). Układ przepisu dwuetapowy (10). Zapisywanie przez wyjątek. Widok
postępu talii.

**Etap 3 — społeczność.** Zdjęcia z moderacją (18). Notatki (19, 20). Zgłaszanie
treści. Ewentualny czat.

**Etap 4 — integracje.** Health Connect (1). Cele rodzinne z podziałem porcji (17).
Odesłania zakupowe (11).

Strona edukacyjna (2, 26) powstaje razem z etapem 1 — bo od niej zależy, jak
uzasadniasz blokady z punktów 3 i 4.

---

## 7. Decyzje do podjęcia

1. Normy: polskie (NIZP-PZH) czy amerykańskie (AMDR)? Rekomendacja: polskie jako
   podstawa, AMDR jako zakresy techniczne dla suwaków.
2. Czy zgadzasz się na ostrzeżenia zamiast twardych blokad poza AMDR?
3. Czy licznik cukrów wolnych zastępuje zakaz z punktu 27?
4. Czy czat zostaje w zakresie?
5. Kuchnia azjatycka — margines czy pełnoprawny dział?
6. Ile profili: trzy (jak w pkt 25) czy pięć (jak sugeruje pkt 9)?

---

## Źródła

- [MyPlate — zastąpienie piramidy MyPyramid (2 czerwca 2011)](https://en.wikipedia.org/wiki/MyPlate)
- [Acceptable Macronutrient Distribution Range — NCBI Bookshelf](https://www.ncbi.nlm.nih.gov/books/NBK610333/)
- [Talerz zdrowego żywienia — Narodowe Centrum Edukacji Żywieniowej, NIZP-PZH](https://ncez.pzh.gov.pl/abc-zywienia/talerz-zdrowego-zywienia/)
- [Normy żywienia dla populacji Polski — edycja 2024](https://ncez.pzh.gov.pl/abc-zywienia/zasady-zdrowego-zywienia/normy-zywieniowe-2024/)
- [WHO — Guideline: Sugars Intake for Adults and Children](https://www.ncbi.nlm.nih.gov/books/NBK285525/)
- [WHO calls on countries to reduce sugars intake](https://who.int/news/item/04-03-2015-who-calls-on-countries-to-reduce-sugars-intake-among-adults-and-children)
