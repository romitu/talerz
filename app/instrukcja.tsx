import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams } from 'expo-router';
import { useRef, useState } from 'react';
import {
  LayoutChangeEvent,
  Pressable,
  ScrollView,
  StyleSheet,
  View,
} from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { wroc } from '@/lib/nawigacja';

/**
 * Instrukcja — treść zsynchronizowana z Instrukcja.html (te same osiem
 * sekcji i Q&A), przełożona na własny, „kartkowy” język wizualny aplikacji:
 * numerowane karty z ikoną, kroki, legenda oznaczeń przepisu i rozwijane
 * pytania — zamiast jednej długiej ściany tekstu.
 */

type Blok =
  | { rodzaj: 'tekst'; tresc: string }
  | { rodzaj: 'podtytul'; tresc: string }
  | { rodzaj: 'lista'; pozycje: string[] }
  | { rodzaj: 'kroki'; pozycje: string[] }
  | { rodzaj: 'wyroznienie'; tresc: string }
  | {
      rodzaj: 'legenda';
      pozycje: { ikona: keyof typeof Ionicons.glyphMap; etykieta: string; opis: string }[];
    };

type Sekcja = {
  id: string;
  numer: string;
  skrot: string;
  tytul: string;
  ikona: keyof typeof Ionicons.glyphMap;
  bloki: Blok[];
};

const SEKCJE: Sekcja[] = [
  {
    id: 's1',
    numer: '1',
    skrot: 'Idea',
    tytul: 'Dlaczego powstał Talerz',
    ikona: 'bulb-outline',
    bloki: [
      { rodzaj: 'tekst', tresc: 'To, co jemy każdego dnia, ma realny wpływ na samopoczucie, energię, masę ciała i zdrowie w dłuższej perspektywie. Problemem często nie jest brak wiedzy o tym, co warto jeść, lecz konieczność podejmowania tych samych decyzji każdego dnia: co ugotować, co kupić i czy dzisiejszy posiłek pasuje do celu.' },
      { rodzaj: 'tekst', tresc: 'Talerz powstał po to, żeby możliwie dużo z tych decyzji podjąć wcześniej. Planujesz kilka kolejnych dni, aplikacja przelicza potrzebne porcje i listę zakupów, a później po prostu realizujesz plan. Baza przepisów i algorytm planowania mają pomagać w utrzymaniu rozsądnego bilansu energii, białka, węglowodanów, tłuszczu i błonnika zgodnie z celem ustawionym w profilu.' },
      { rodzaj: 'tekst', tresc: 'Dzięki temu łatwiej jeść regularnie, ograniczyć przypadkowe wybory i kontrolować masę ciała. Efekt nie musi kończyć się na liczbie kilogramów: chodzi również o lepsze samopoczucie, większy komfort ruchu i zwykłe poczucie, że sposób jedzenia jest pod kontrolą.' },
      { rodzaj: 'tekst', tresc: 'Talerz nie ma być dietą na miesiąc. Ma być sposobem organizowania normalnego jedzenia przez lata.' },
      { rodzaj: 'wyroznienie', tresc: 'Zaplanuj. Kup. Ugotuj. Zjedz. Powtórz.' },
    ],
  },
  {
    id: 's2',
    numer: '2',
    skrot: 'Baza',
    tytul: 'Na czym opiera się Talerz',
    ikona: 'flask-outline',
    bloki: [
      { rodzaj: 'podtytul', tresc: 'Przepisy i stopień przetworzenia żywności' },
      { rodzaj: 'tekst', tresc: 'Baza przepisów jest projektowana tak, aby podstawą były produkty nieprzetworzone lub nisko przetworzone. Jako dodatkowy filtr wykorzystywana jest klasyfikacja NOVA, która dzieli żywność według charakteru i stopnia przetworzenia na cztery grupy. Talerz preferuje składniki z grup 1–3 i co do zasady odrzuca produkty z grupy 4, czyli żywność ultraprzetworzoną.' },
      { rodzaj: 'tekst', tresc: 'NOVA jest tu filtrem pomagającym budować bazę produktów, a nie samodzielnym systemem oceny wartości odżywczej. O jakości całego jadłospisu nadal decydują m.in. ilość energii, źródła białka, warzywa i owoce, pełne ziarna, rodzaj tłuszczu oraz błonnik.' },
      { rodzaj: 'podtytul', tresc: 'Makroskładniki i błonnik' },
      { rodzaj: 'tekst', tresc: 'Do ustawiania zakresów makroskładników Talerz wykorzystuje zakresy AMDR (Acceptable Macronutrient Distribution Range) określane dla grup wiekowych. Są to zakresy udziału energii z białka, węglowodanów i tłuszczu, a nie jedna sztywna proporcja odpowiednia dla wszystkich.' },
      { rodzaj: 'tekst', tresc: 'Błonnik jest traktowany oddzielnie jako cel dzienny. Dzięki temu plan nie sprowadza się wyłącznie do kalorii i makroskładników.' },
      { rodzaj: 'podtytul', tresc: 'Ogólne punkty odniesienia' },
      { rodzaj: 'tekst', tresc: 'Dla zdrowych osób dorosłych europejskie wartości referencyjne EFSA stanowią dobry punkt kontrolny: węglowodany około 45–60% energii, tłuszcz około 20–35% energii, białko 0,83 g/kg masy ciała na dobę jako populacyjna wartość referencyjna oraz około 25 g błonnika dziennie jako ilość odpowiednia dla prawidłowej pracy jelit.' },
      { rodzaj: 'tekst', tresc: 'Praktyczny model komponowania posiłku jest zgodny z polskim Talerzem Zdrowego Żywienia: około ½ talerza powinny stanowić warzywa i owoce z przewagą warzyw, ¼ produkty zbożowe – najlepiej pełnoziarniste – a ¼ źródło białka. Uzupełnieniem jest niewielka ilość tłuszczu roślinnego.' },
      { rodzaj: 'wyroznienie', tresc: 'Talerz jest narzędziem do planowania jedzenia dla ogólnej populacji. Nie zastępuje lekarza ani dietetyka i nie powinien samodzielnie ustalać diety leczniczej, żywienia w ciąży, żywienia dzieci ani planu dla osób ze szczególnymi wymaganiami zdrowotnymi.' },
      { rodzaj: 'podtytul', tresc: 'Podstawa merytoryczna' },
      {
        rodzaj: 'lista',
        pozycje: [
          'National Academies / IOM – zakresy AMDR dla makroskładników według grup wiekowych.',
          'EFSA – Dietary Reference Values dla węglowodanów, tłuszczu, białka i błonnika.',
          'FAO / klasyfikacja NOVA – podział żywności według charakteru i stopnia przetworzenia.',
          'Narodowe Centrum Edukacji Żywieniowej (NCEŻ) – polski Talerz Zdrowego Żywienia.',
        ],
      },
    ],
  },
  {
    id: 's3',
    numer: '3',
    skrot: 'Start',
    tytul: 'Pierwsza konfiguracja',
    ikona: 'person-outline',
    bloki: [
      { rodzaj: 'podtytul', tresc: 'Profil' },
      { rodzaj: 'tekst', tresc: 'Z jednego konta może korzystać maksymalnie 4 osoby. Konto jest powiązane z adresem e-mail użytym przy rejestracji pierwszej osoby i wspólnym hasłem, natomiast każda osoba ma własny profil i własne cele.' },
      { rodzaj: 'tekst', tresc: 'W zakładce „Profil” dla każdej osoby uzupełniasz dane potrzebne do obliczeń: płeć, datę urodzenia, wzrost, wagę i poziom aktywności. W tym samym miejscu ustawiasz tryb, proporcje makroskładników, cel błonnika i próg białka na posiłek. Kalorie i gramy są przeliczane na bieżąco, więc po zmianie danych profil nie pozostaje przy starej, sztywnej wartości.' },
      { rodzaj: 'tekst', tresc: 'Administrator ma dodatkowo dostęp do zarządzania użytkownikami/profilami w ramach konta oraz do nadawania roli moderatora.' },
      { rodzaj: 'podtytul', tresc: 'Preferencje przepisów' },
      { rodzaj: 'tekst', tresc: 'Przed pierwszym automatycznym planowaniem warto przejrzeć zakładkę „Przepisy” i oznaczyć swoje preferencje. Dzięki temu automat od początku pracuje na bazie dań, które rzeczywiście chcesz jeść.' },
      {
        rodzaj: 'legenda',
        pozycje: [
          { ikona: 'eye-off', etykieta: 'Ukryj', opis: 'Chowa przepis z listy przepisów i wyklucza go z automatycznego wypełniania planu.' },
          { ikona: 'close-circle', etykieta: 'Nie proponuj', opis: 'Przepis zostaje widoczny, ale automat go nie proponuje — nadal wybierzesz go ręcznie.' },
          { ikona: 'heart', etykieta: 'Lubię', opis: 'Automat chętniej wybiera to danie przy automatycznym wypełnianiu planu.' },
        ],
      },
      { rodzaj: 'tekst', tresc: 'Dla przepisu możesz również ustawić maksymalną liczbę dni przechowywania gotowego dania w lodówce. Gdy podczas planowania włączysz uwzględnianie trwałości, Talerz może rozłożyć jedno gotowanie na kolejne dni. To ustawienie można pominąć przy konkretnym planie, dlatego wartości domyślne można zostawić na później.' },
    ],
  },
  {
    id: 's4',
    numer: '4',
    skrot: 'Plan',
    tytul: 'Planowanie posiłków',
    ikona: 'calendar-outline',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Tydzień w zakładce „Plan” jest podzielony na dni, a każdy dzień na śniadanie, obiad i kolację. Puste miejsce pozwala wybrać danie ręcznie, a wybrane miejsce pokazuje jego podstawowy bilans i pozwala je usunąć.' },
      {
        rodzaj: 'kroki',
        pozycje: [
          'Ustal datę, od której ma rozpocząć się plan.',
          'Jeżeli chcesz wykorzystać maksymalną trwałość przygotowanych dań, zaznacz opcję „Uwzględnij, ile dni wytrzyma w lodówce”.',
          'Jeżeli w konkretnym dniu chcesz zjeść konkretne danie, wybierz je ręcznie przy odpowiedniej pozycji: „ŚNIADANIE”, „OBIAD” lub „KOLACJA”.',
          'Kliknij „Wypełnij wolne miejsca”. Automat uzupełni tylko puste pozycje – ręcznie ustawione posiłki pozostaną bez zmian.',
          'Jeżeli chcesz plan krótszy niż tydzień, możesz wypełnić cały tydzień, a następnie usunąć ostatni dzień lub dwa ostatnie dni. Lista zakupów obejmie wyłącznie pozostały zaplanowany okres.',
        ],
      },
      { rodzaj: 'tekst', tresc: 'Automatyczne wypełnianie dobiera dania do celu kalorycznego i białkowego dnia, preferuje przepisy oznaczone „Lubię”, pomija w automacie dania oznaczone „Nie proponuj” i stara się unikać zbyt częstych powtórek.' },
      { rodzaj: 'tekst', tresc: 'Bilans dnia pokazuje liczbowo, ile brakuje do celu kalorycznego i białkowego. Dzięki temu widać nie tylko, czy dzień jest „na zielono”, ale również skalę odchylenia od celu.' },
      { rodzaj: 'tekst', tresc: 'Przycisk „Powtórz poprzedni tydzień” przenosi poprzedni układ na bieżący tydzień całymi gotowaniami – danie przygotowane raz i rozłożone na kilka dni pozostaje jednym gotowaniem. Zajęte już miejsca nie są nadpisywane. „Wyczyść wszystko” usuwa plan z bieżącego tygodnia.' },
    ],
  },
  {
    id: 's5',
    numer: '5',
    skrot: 'Zakupy',
    tytul: 'Zakupy',
    ikona: 'cart-outline',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Lista zakupów tworzy się automatycznie z zaplanowanych posiłków i sumuje ilości tych samych składników z całego zaplanowanego okresu. Po oznaczeniu produktu jako kupiony jego status pozostaje zachowany do zakończenia bieżących zakupów.' },
      { rodzaj: 'tekst', tresc: 'Produkty niezwiązane bezpośrednio z przepisami – np. worki na śmieci czy papier śniadaniowy – możesz dopisać ręcznie. Aplikacja je zapamięta i może przywracać w kolejnych tygodniach.' },
      { rodzaj: 'tekst', tresc: 'Jeżeli posiłek z poprzedniego tygodnia przechodzi na początek nowego tygodnia, jego składniki są pokazane na dole listy jako już zrealizowane. Nie trzeba więc kupować ich drugi raz, skoro danie zostało już przygotowane.' },
    ],
  },
  {
    id: 's6',
    numer: '6',
    skrot: 'Gotuj',
    tytul: 'Przygotowanie posiłku',
    ikona: 'restaurant-outline',
    bloki: [
      { rodzaj: 'tekst', tresc: 'W zakładce „Plan” wybierz aktualny dzień i kliknij zaplanowany posiłek. Aplikacja przeprowadzi Cię przez przygotowanie dania krok po kroku, na podstawie liczby porcji wynikającej z planu.' },
      { rodzaj: 'tekst', tresc: 'Jednym z głównych założeń Talerza jest ograniczenie liczby gotowań. Jeżeli danie dobrze przechowuje się przez dwa lub trzy dni, lepiej przygotować kilka porcji za jednym razem niż zaczynać od zera każdego dnia.' },
    ],
  },
  {
    id: 's7',
    numer: '7',
    skrot: 'Dania',
    tytul: 'Przepisy i funkcje moderatora',
    ikona: 'book-outline',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Zakładka „Przepisy” zawiera wyszukiwarkę i kategorie: śniadanie, obiad, kolacja oraz dodatek. „Dodatek” oznacza element, który można dołożyć do dowolnej pory dnia – np. grillowaną pierś, surówkę albo sałatkę z ciecierzycy.' },
      { rodzaj: 'tekst', tresc: 'Dodawanie i edycja przepisów wymaga roli moderatora. Nowy przepis jest domyślnie prywatny; zgłoszenie go do publikacji i zatwierdzenie to osobny obieg wymagający zgody autora zgodnie z zasadami aplikacji.' },
      { rodzaj: 'tekst', tresc: 'Moderator może importować i eksportować bazę przez plik Excel. Pozwala to zrobić kopię zapasową lub masowo poprawiać przepisy poza aplikacją. Przy imporcie dania są rozpoznawane po nazwie, a istniejące rekordy są aktualizowane zamiast tworzenia duplikatów.' },
    ],
  },
  {
    id: 's8',
    numer: '8',
    skrot: 'Zasada',
    tytul: 'Zasada Talerza',
    ikona: 'repeat-outline',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Największą wartością Talerza nie jest pojedynczy przepis ani pojedyncze wyliczenie. Jest nią zamiana codziennego improwizowania na prosty, powtarzalny proces.' },
      { rodzaj: 'wyroznienie', tresc: 'Zaplanuj. Kup. Ugotuj. Zjedz. Powtórz.' },
      { rodzaj: 'tekst', tresc: 'Im mniej niepotrzebnych decyzji trzeba podejmować każdego dnia, tym łatwiej utrzymać rozsądny sposób jedzenia przez większość tygodni w roku.' },
    ],
  },
];

type Pytanie = {
  pytanie: string;
  bloki: Blok[];
};

const PYTANIA: Pytanie[] = [
  {
    pytanie: 'Dlaczego Talerz zachęca, żeby nie gotować codziennie?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Zdrowe jedzenie nie powinno oznaczać codziennego spędzania godziny w kuchni. Jeżeli danie nadaje się do przechowywania, warto przygotować od razu dwie lub trzy porcje na kolejne dni.' },
      { rodzaj: 'tekst', tresc: 'Przykład: dzisiaj około godziny gotowania, jutro 10–15 minut na przygotowanie dodatku lub odgrzanie posiłku. Dlatego każdy przepis ma określoną trwałość, a plan może rozłożyć jedno gotowanie na kilka kolejnych posiłków.' },
    ],
  },
  {
    pytanie: 'Jak działa planowanie dla jednej, dwóch i kilku osób?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Liczba osób nie zmienia sposobu działania Talerza – zmienia liczbę przygotowywanych porcji. Jednocześnie aplikacja ogranicza wielkość jednego gotowania tak, aby liczba osób pomnożona przez liczbę dni nie przekraczała 4 porcji naraz.' },
      {
        rodzaj: 'lista',
        pozycje: [
          '1 osoba × 3 dni = 3 porcje. Jedno gotowanie daje obiad na trzy dni.',
          '2 osoby × 2 dni = 4 porcje. Jedno gotowanie daje dwa wspólne obiady.',
          '3 lub 4 osoby – nawet jeżeli danie wytrzyma w lodówce dłużej, plan obejmuje tylko jeden dzień, czyli odpowiednio 3 albo 4 porcje.',
        ],
      },
      { rodzaj: 'tekst', tresc: 'Danie nie zostaje przez to pominięte. Zawsze może zostać zaplanowane przynajmniej na jeden dzień. Talerz przelicza składniki na podstawie wagi porcji lub liczby sztuk zapisanych w przepisie.' },
    ],
  },
  {
    pytanie: 'Czy mogę powtarzać posiłki albo cały tydzień?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Tak. Powtarzalność jest jedną z podstawowych funkcji Talerza, a nie błędem planowania. Jeżeli masz zestaw dań, które dobrze Ci służą i które lubisz, nie ma potrzeby codziennie szukać czegoś nowego.' },
      { rodzaj: 'tekst', tresc: 'Przycisk „Powtórz poprzedni tydzień” przenosi układ poprzedniego tygodnia na bieżący, zachowując całe gotowania. Danie ugotowane raz i rozłożone na trzy dni nie zmienia się w trzy niezależne gotowania. Zajęte miejsca w bieżącym tygodniu pozostają bez zmian.' },
    ],
  },
  {
    pytanie: 'Co oznaczają oznaczenia przy przepisie?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Przy przepisach dostępne są trzy podstawowe oznaczenia: „Ukryj”, „Lubię” i „Nie proponuj”.' },
      {
        rodzaj: 'lista',
        pozycje: [
          '„Lubię” – zwiększa preferencję przepisu podczas automatycznego wypełniania planu.',
          '„Nie proponuj” – automat nie wybierze dania sam, ale nadal można wybrać je ręcznie.',
          '„Ukryj” – chowa przepis z głównej listy i wyklucza go z automatycznego planowania bez usuwania z bazy.',
        ],
      },
      { rodzaj: 'tekst', tresc: 'Ponowne wybranie aktywnego oznaczenia przywraca stan neutralny. Gdy istnieją ukryte przepisy, pojawia się zakładka „Ukryte”, która pozwala je ponownie wyświetlić. Preferencje są indywidualne dla użytkownika – nie wynikają z ocen innych osób.' },
    ],
  },
  {
    pytanie: 'Czy mogę dodawać przepisy?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Tak. W tym celu wyeksportuj najbardziej podobny przepis do tego, który chcesz przygotować, do pliku Excel. Zmień w pliku nazwę potrawy na własną i w zasadzie możesz od razu zaimportować go z powrotem jako swój prywatny przepis, a następnie edytować jego składniki w aplikacji.' },
      { rodzaj: 'tekst', tresc: 'Eksport i import znajdziesz na ekranie „Import / eksport przepisów” dostępnym z listy przepisów.' },
    ],
  },
  {
    pytanie: 'Ile białka, węglowodanów, tłuszczu i błonnika?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Nie istnieje jedna idealna proporcja odpowiednia dla wszystkich. Talerz traktuje makroskładniki jako zakresy, a nie jedną obowiązkową wartość. Dla zdrowej osoby dorosłej dobrym europejskim punktem odniesienia są wartości EFSA: węglowodany około 45–60% energii, tłuszcz około 20–35% energii, białko 0,83 g/kg masy ciała na dobę jako populacyjna wartość referencyjna i około 25 g błonnika dziennie.' },
      { rodzaj: 'tekst', tresc: 'W praktyce warto też patrzeć na skład samego posiłku: około połowy talerza powinny stanowić warzywa i owoce z przewagą warzyw, ćwierć produkty zbożowe – najlepiej pełnoziarniste – a ćwierć źródło białka. Uzupełnieniem jest niewielka ilość tłuszczu roślinnego.' },
    ],
  },
  {
    pytanie: 'A jeżeli dużo trenuję?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Wraz ze wzrostem aktywności fizycznej rośnie przede wszystkim zapotrzebowanie na energię. Przy regularnym i intensywnym treningu większego znaczenia nabiera również odpowiednia podaż węglowodanów i białka; w żywieniu sportowym zapotrzebowanie na białko może być wyraźnie większe niż podstawowa wartość dla przeciętnej osoby dorosłej.' },
      { rodzaj: 'tekst', tresc: 'W Profilu ustawiasz poziom aktywności: siedzący, lekki, umiarkowany, duży albo bardzo duży. Talerz wykorzystuje tę informację przy wyliczaniu celu energetycznego. Przy bardzo intensywnym sporcie lub konkretnym celu treningowym warto ustalić wartości z dietetykiem sportowym i używać Talerza do ich codziennej realizacji.' },
    ],
  },
  {
    pytanie: 'A wiek?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Wiek wpływa na zapotrzebowanie energetyczne i zakresy referencyjne, ale sam wiek nie wystarcza do bezpiecznego zaplanowania żywienia w każdej sytuacji. Dzieci, kobiety w ciąży, osoby starsze z problemami zdrowotnymi oraz osoby z chorobami lub szczególnymi wymaganiami żywieniowymi powinny mieć cele ustalone odpowiednio do swojej sytuacji.' },
      { rodzaj: 'tekst', tresc: 'Talerz może pomagać w organizacji i realizacji takiego planu, ale nie zastępuje indywidualnej konsultacji medycznej ani dietetycznej.' },
    ],
  },
  {
    pytanie: 'Chcę schudnąć. Ile powinienem jeść?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'W Profilu wybierasz tryb „redukcja” albo „utrzymanie wagi” oraz proporcje makroskładników. Talerz przelicza cel energetyczny i gramatury na podstawie danych profilu, dlatego zmiana masy ciała wpływa na kolejne wyliczenia zamiast pozostawiać na stałe raz wpisaną liczbę kalorii.' },
      { rodzaj: 'tekst', tresc: 'Jeżeli redukcja ma być duża, masz chorobę, przyjmujesz leki wpływające na masę ciała lub intensywnie trenujesz, dokładny cel energetyczny warto ustalić ze specjalistą. Talerz ma wtedy inne zadanie: pomóc konsekwentnie zrealizować ustalony cel.' },
      { rodzaj: 'wyroznienie', tresc: 'Specjalista pomaga ustalić cel, Talerz pomaga go codziennie wykonać.' },
    ],
  },
  {
    pytanie: 'Jak wytrwać?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Najważniejsze jest ograniczenie liczby codziennych decyzji. Jeżeli masz kilkanaście potraw, które naprawdę lubisz, możesz z nich ułożyć kolejny tydzień, zrobić zakupy i po prostu jeść zgodnie z planem. Nie trzeba bez przerwy szukać nowych przepisów.' },
      { rodzaj: 'tekst', tresc: 'Plan nie musi być perfekcyjny. Kolacja ze znajomymi, wyjazd czy ochota na coś innego nie przekreślają tygodnia. Zmieniasz jeden posiłek i wracasz do planu przy kolejnym.' },
      { rodzaj: 'tekst', tresc: 'Celem nie jest idealny tydzień. Celem jest rozsądny sposób jedzenia przez większość tygodni w roku.' },
    ],
  },
  {
    pytanie: 'Czy naprawdę warto?',
    bloki: [
      { rodzaj: 'tekst', tresc: 'Tak – jeżeli aplikacja pomaga Ci jeść bardziej regularnie, lepiej planować zakupy i ograniczać przypadkowe wybory. Nadmierna masa ciała, niska jakość diety i brak aktywności fizycznej wiążą się ze zwiększonym ryzykiem wielu chorób przewlekłych, ale korzyści z lepszego sposobu jedzenia można odczuwać również wcześniej: w codziennej energii, komforcie ruchu i kontroli nad własnym planem.' },
      { rodzaj: 'tekst', tresc: 'Talerz nie powstał po to, żeby przez trzy tygodnie być „na diecie”. Powstał po to, żeby dobre jedzenie było łatwiejszym wyborem i żeby nie trzeba było codziennie zaczynać planowania od zera.' },
    ],
  },
];

function BlokWidok({ blok }: { blok: Blok }) {
  const motyw = useTheme();

  switch (blok.rodzaj) {
    case 'tekst':
      return (
        <ThemedText type="small" themeColor="textSecondary">
          {blok.tresc}
        </ThemedText>
      );
    case 'podtytul':
      return (
        <ThemedText type="smallBold" style={styles.podtytul}>
          {blok.tresc}
        </ThemedText>
      );
    case 'wyroznienie':
      return (
        <View style={[styles.wyroznienie, { backgroundColor: `${motyw.accent}18`, borderColor: `${motyw.accent}33` }]}>
          <ThemedText type="smallBold" style={[styles.wyroznienieTekst, { color: motyw.accent }]}>
            {blok.tresc}
          </ThemedText>
        </View>
      );
    case 'lista':
      return (
        <View style={styles.listaOpakowanie}>
          {blok.pozycje.map((pozycja, i) => (
            <View key={i} style={styles.listaWiersz}>
              <View style={[styles.kropka, { backgroundColor: motyw.accent }]} />
              <ThemedText type="small" themeColor="textSecondary" style={styles.listaTekst}>
                {pozycja}
              </ThemedText>
            </View>
          ))}
        </View>
      );
    case 'kroki':
      return (
        <View style={styles.listaOpakowanie}>
          {blok.pozycje.map((pozycja, i) => (
            <View key={i} style={styles.krokWiersz}>
              <View style={[styles.krokNumer, { backgroundColor: `${motyw.accent}1c` }]}>
                <ThemedText type="smallBold" style={{ color: motyw.accent }}>
                  {i + 1}
                </ThemedText>
              </View>
              <ThemedText type="small" themeColor="textSecondary" style={styles.listaTekst}>
                {pozycja}
              </ThemedText>
            </View>
          ))}
        </View>
      );
    case 'legenda':
      return (
        <View style={styles.legendaOpakowanie}>
          {blok.pozycje.map((pozycja) => (
            <View key={pozycja.etykieta} style={styles.legendaWiersz}>
              <View style={[styles.legendaIkona, { backgroundColor: `${motyw.accent}1c` }]}>
                <Ionicons name={pozycja.ikona} size={18} color={motyw.accent} />
              </View>
              <View style={styles.legendaTekst}>
                <ThemedText type="smallBold">{pozycja.etykieta}</ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  {pozycja.opis}
                </ThemedText>
              </View>
            </View>
          ))}
        </View>
      );
  }
}

function SekcjaKarta({ sekcja, onUklad }: { sekcja: Sekcja; onUklad: (id: string, y: number) => void }) {
  const motyw = useTheme();

  return (
    <View onLayout={(e: LayoutChangeEvent) => onUklad(sekcja.id, e.nativeEvent.layout.y)}>
      <Karta>
        <View style={styles.naglowekKarty}>
          <View style={[styles.numerKarty, { backgroundColor: `${motyw.accent}1c` }]}>
            <Ionicons name={sekcja.ikona} size={20} color={motyw.accent} />
          </View>
          <View style={styles.tytulKartyOpakowanie}>
            <ThemedText type="small" themeColor="textSecondary" style={styles.eyebrow}>
              {sekcja.numer.padStart(2, '0')}
            </ThemedText>
            <ThemedText type="smallBold" style={styles.tytulKarty}>
              {sekcja.tytul}
            </ThemedText>
          </View>
        </View>
        {sekcja.bloki.map((blok, i) => (
          <BlokWidok key={i} blok={blok} />
        ))}
      </Karta>
    </View>
  );
}

function PytanieKarta({ dane, otwarte, onPress }: { dane: Pytanie; otwarte: boolean; onPress: () => void }) {
  const motyw = useTheme();

  return (
    <Karta style={styles.pytanieKarta}>
      <Pressable onPress={onPress} accessibilityRole="button" style={styles.pytanieNaglowek}>
        <ThemedText type="smallBold" style={styles.pytanieTekst}>
          {dane.pytanie}
        </ThemedText>
        <Ionicons
          name={otwarte ? 'chevron-up' : 'chevron-down'}
          size={18}
          color={motyw.textSecondary}
        />
      </Pressable>
      {otwarte && (
        <View style={styles.odpowiedz}>
          {dane.bloki.map((blok, i) => (
            <BlokWidok key={i} blok={blok} />
          ))}
        </View>
      )}
    </Karta>
  );
}

export default function EkranInstrukcji() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const motyw = useTheme();
  const przewijanie = useRef<ScrollView>(null);
  const pozycjeSekcji = useRef<Record<string, number>>({});
  const [otwartePytanie, setOtwartePytanie] = useState<number | null>(null);

  function zapiszUklad(id: string, y: number) {
    pozycjeSekcji.current[id] = y;
  }

  function przewinDo(id: string) {
    const y = pozycjeSekcji.current[id];
    if (y != null) {
      przewijanie.current?.scrollTo({ y: Math.max(y - Spacing.three, 0), animated: true });
    }
  }

  return (
    <Ekran
      tytul="Instrukcja"
      refPrzewijania={przewijanie}
      naglowekStaly={
        <ThemedView type="backgroundElement" style={[styles.pasekToc, { borderColor: motyw.border }]}>
          <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.tocZawartosc}>
            {SEKCJE.map((s) => (
              <Pressable
                key={s.id}
                onPress={() => przewinDo(s.id)}
                style={[styles.chip, { borderColor: motyw.border, backgroundColor: motyw.background }]}>
                <View style={[styles.chipNumer, { backgroundColor: `${motyw.accent}1c` }]}>
                  <ThemedText style={[styles.chipNumerTekst, { color: motyw.accent }]}>{s.numer}</ThemedText>
                </View>
                <ThemedText style={styles.chipTekst} themeColor="textSecondary" numberOfLines={1}>
                  {s.skrot}
                </ThemedText>
              </Pressable>
            ))}
            <Pressable
              onPress={() => przewinDo('qa')}
              style={[styles.chip, { borderColor: motyw.border, backgroundColor: motyw.background }]}>
              <ThemedText style={styles.chipTekst} themeColor="textSecondary" numberOfLines={1}>
                Q&amp;A
              </ThemedText>
            </Pressable>
          </ScrollView>
        </ThemedView>
      }>
      <View style={styles.hero}>
        <View style={[styles.heroIkona, { backgroundColor: `${motyw.accent}1c` }]}>
          <Ionicons name="restaurant" size={30} color={motyw.accent} />
        </View>
        <View style={[styles.heroOdznaka, { borderColor: motyw.border }]}>
          <View style={[styles.heroOdznakaKropka, { backgroundColor: motyw.accent }]} />
          <ThemedText type="small" themeColor="textSecondary" style={styles.heroOdznakaTekst}>
            INSTRUKCJA I IDEA APLIKACJI
          </ThemedText>
        </View>
        <ThemedText type="title" style={styles.heroTytul}>
          Talerz
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary" style={styles.heroPodtytul}>
          Dlaczego powstał i jak z niego korzystać
        </ThemedText>
      </View>

      {SEKCJE.map((sekcja) => (
        <SekcjaKarta key={sekcja.id} sekcja={sekcja} onUklad={zapiszUklad} />
      ))}

      <View onLayout={(e: LayoutChangeEvent) => zapiszUklad('qa', e.nativeEvent.layout.y)} style={styles.naglowekPytan}>
        <Ionicons name="help-circle-outline" size={18} color={motyw.textSecondary} />
        <ThemedText type="smallBold" themeColor="textSecondary">
          PYTANIA I ODPOWIEDZI
        </ThemedText>
      </View>
      {PYTANIA.map((pytanie, i) => (
        <PytanieKarta
          key={pytanie.pytanie}
          dane={pytanie}
          otwarte={otwartePytanie === i}
          onPress={() => setOtwartePytanie(otwartePytanie === i ? null : i)}
        />
      ))}

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  pasekToc: {
    borderBottomWidth: StyleSheet.hairlineWidth,
    paddingVertical: Spacing.two,
  },
  tocZawartosc: {
    flexDirection: 'row',
    flexWrap: 'nowrap',
    paddingHorizontal: Spacing.three,
    gap: Spacing.one,
  },
  chip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: 6,
    paddingHorizontal: Spacing.two,
    borderRadius: 999,
    borderWidth: StyleSheet.hairlineWidth,
  },
  chipNumer: {
    width: 16,
    height: 16,
    borderRadius: 8,
    alignItems: 'center',
    justifyContent: 'center',
  },
  chipNumerTekst: {
    fontSize: 10,
    fontWeight: '700',
    lineHeight: 12,
  },
  chipTekst: {
    fontSize: 12,
  },
  hero: {
    alignItems: 'center',
    paddingTop: Spacing.four,
    paddingBottom: Spacing.two,
    gap: Spacing.one,
  },
  heroIkona: {
    width: 60,
    height: 60,
    borderRadius: 30,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: Spacing.two,
  },
  heroOdznaka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderWidth: StyleSheet.hairlineWidth,
    borderRadius: 999,
    paddingVertical: 5,
    paddingHorizontal: Spacing.three,
  },
  heroOdznakaKropka: {
    width: 6,
    height: 6,
    borderRadius: 3,
  },
  heroOdznakaTekst: {
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 0.6,
  },
  heroTytul: {
    marginTop: Spacing.two,
  },
  heroPodtytul: {
    textAlign: 'center',
  },
  naglowekKarty: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
    marginBottom: Spacing.one,
  },
  numerKarty: {
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  tytulKartyOpakowanie: {
    flex: 1,
    gap: 1,
  },
  eyebrow: {
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 0.8,
  },
  tytulKarty: {
    fontSize: 17,
  },
  podtytul: {
    marginTop: Spacing.two,
  },
  wyroznienie: {
    borderRadius: Spacing.two,
    borderWidth: StyleSheet.hairlineWidth,
    paddingVertical: Spacing.three,
    paddingHorizontal: Spacing.three,
    marginVertical: Spacing.one,
  },
  wyroznienieTekst: {
    textAlign: 'center',
  },
  listaOpakowanie: {
    gap: Spacing.two,
  },
  listaWiersz: {
    flexDirection: 'row',
    gap: Spacing.two,
    alignItems: 'flex-start',
  },
  kropka: {
    width: 6,
    height: 6,
    borderRadius: 3,
    marginTop: 8,
  },
  listaTekst: {
    flex: 1,
  },
  krokWiersz: {
    flexDirection: 'row',
    gap: Spacing.two,
    alignItems: 'flex-start',
  },
  krokNumer: {
    width: 22,
    height: 22,
    borderRadius: 11,
    alignItems: 'center',
    justifyContent: 'center',
  },
  legendaOpakowanie: {
    gap: Spacing.three,
    marginVertical: Spacing.one,
  },
  legendaWiersz: {
    flexDirection: 'row',
    gap: Spacing.three,
    alignItems: 'center',
  },
  legendaIkona: {
    width: 36,
    height: 36,
    borderRadius: 18,
    alignItems: 'center',
    justifyContent: 'center',
  },
  legendaTekst: {
    flex: 1,
    gap: 1,
  },
  naglowekPytan: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    paddingTop: Spacing.two,
  },
  pytanieKarta: {
    gap: 0,
  },
  pytanieNaglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.three,
  },
  pytanieTekst: {
    flex: 1,
  },
  odpowiedz: {
    gap: Spacing.two,
    marginTop: Spacing.three,
  },
});
