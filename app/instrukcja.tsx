import { useLocalSearchParams } from 'expo-router';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { wroc } from '@/lib/nawigacja';

/**
 * Instrukcja — dlaczego Talerz istnieje i jak z niego korzystać.
 *
 * Zastąpiła zakładkę Społeczność (czat nigdy nie powstał, a pusta zakładka
 * uczyła, że część aplikacji nic nie robi). Ta uczy czegoś realnego.
 *
 * Treść w sekcji „Dlaczego Talerz” pochodzi od Romana niemal bez zmian —
 * to jego uzasadnienie, nie wygenerowany opis. Skorygowane zostały wyłącznie
 * miejsca, w których opisywały funkcję inaczej, niż działa ona naprawdę:
 *   - „Powtórz posiłek” z wyborem liczby dni -> opisany jako rzeczywisty
 *     przycisk „Powtórz poprzedni tydzień” (przenosi cały tydzień, nie
 *     pojedynczy posiłek).
 *   - Cztery poziomy preferencji jako lista możliwości -> opisane jako to,
 *     czym są naprawdę: trzy dotykalne ikony przy przepisie („neutralne”
 *     to brak zaznaczenia, a nie czwarty przycisk).
 *   - Poziomy aktywności: w aplikacji jest ich pięć, nie cztery.
 *   - Wybór celu „chcę schudnąć / utrzymać / więcej energii” -> w aplikacji
 *     nie ma takiej listy. Jest jeden przycisk podpowiadający rozsądny
 *     deficyt, a liczby dalej edytuje się ręcznie.
 * Bez tych poprawek instrukcja uczyłaby szukać przycisków, których nie ma.
 */

type PytanieOdpowiedz = {
  tytul: string;
  akapity: string[];
};

const DLACZEGO_TALERZ: PytanieOdpowiedz[] = [
  {
    tytul: 'Dlaczego powstał Talerz?',
    akapity: [
      'Talerz powstał z bardzo prostego powodu: żeby codziennie nie zastanawiać się, co jutro zjeść.',
      'Nie chcę każdego wieczoru otwierać lodówki i wymyślać obiadu. Nie chcę też robić przypadkowych zakupów, z których później połowa zostaje w lodówce.',
      'Chcę zaplanować kilka kolejnych dni, wygenerować listę zakupów, zrobić zakupy, a później po prostu jeść to, co wcześniej zaplanowałem — z zachowaniem odpowiedniego balansu białka, węglowodanów i tłuszczów.',
      'Dzięki temu łatwiej jeść rozsądnie i regularnie. Łatwiej również kontrolować masę ciała. A efekty zdrowego odżywiania nie kończą się na wadze. Chodzi także o to, żeby lepiej się czuć, mieć więcej energii, swobodniej się poruszać i żeby koszulka leżała na nas, a nie na brzuchu.',
      'Talerz nie jest dietą na miesiąc. Ma być sposobem normalnego jedzenia przez lata.',
    ],
  },
  {
    tytul: 'Pierwsze kroki',
    akapity: [
      'Z aplikacji mogą wspólnie korzystać maksymalnie 3 osoby. Wszyscy korzystają z tego samego konta — jednego adresu e-mail podanego podczas rejestracji oraz wspólnego hasła.',
      'Po rejestracji należy w zakładce „Profil” określić cele żywieniowe dla każdej osoby.',
      'Następnie warto przejrzeć zakładkę „Przepisy” i określić swoje preferencje. Gwiazdką zaznaczamy posiłki, które aplikacja powinna proponować często, serduszkiem te, które lubimy, a iksem te, których aplikacja nie powinna proponować podczas automatycznego planowania.',
      'Kolejnym krokiem jest przejście do zakładki „Plan”.',
      'Aplikacja pozwala zaplanować posiłki maksymalnie na 7 dni. Przepisy referencyjne mogą być zmieniane wyłącznie przez moderatora. Każdy przycisk w zakładce jest opisany, dlatego można sprawdzić, do czego służy albo po prostu wypróbować jego działanie.',
      'Każdy posiłek można również wybrać ręcznie z listy. W tym celu należy kliknąć znak „+” przy pozycji „ŚNIADANIE”, „OBIAD” lub „KOLACJA”.',
      'Można też automatycznie wypełnić cały tydzień, a następnie usunąć ostatni dzień lub dwa ostatnie dni. W ten sposób można łatwo przygotować plan np. na 5 dni, a lista zakupów zostanie utworzona tylko dla zaplanowanego okresu.',
    ],
  },
  {
    tytul: 'Przyrządzanie posiłku',
    akapity: [
      'Idziemy do Planu, odszukujemy aktualny dzień i klikamy na wybrany wcześniej posiłek. Aplikacja przeniesie nas do ekranu gdzie krok po kroku poprowadzi nas przez proces przygotowania posiłku.',
    ],
  },
  {
    tytul: 'Nie gotuj codziennie',
    akapity: [
      'Jednym z podstawowych założeń Talerza jest to, że zdrowe jedzenie nie powinno oznaczać codziennego spędzania godziny w kuchni.',
      'Jeżeli przygotowujesz danie, zastanów się, czy możesz od razu zrobić go na dwa albo trzy dni.',
      'Przykład: dzisiaj około godziny gotowania, jutro 10–15 minut na przygotowanie lub odgrzanie posiłku.',
      'Talerz preferuje więc takie planowanie, w którym gotujemy rzadziej, ale rozsądnie wykorzystujemy przygotowane jedzenie — dlatego przepis ma trwałość w dniach, a plan rozkłada jedno gotowanie na kilka posiłków z rzędu.',
    ],
  },
  {
    tytul: 'Planowanie dla jednej, dwóch i kilku osób',
    akapity: [
      'Liczba osób nie zmienia sposobu działania Talerza. Zmienia jedynie liczbę przygotowywanych porcji.',
      'Jedna osoba: 1 osoba × 3 dni = 3 porcje. Gotujesz raz i masz obiad na trzy dni.',
      'Dwie osoby: 2 osoby × 2 dni = 4 porcje. Jedno gotowanie zapewnia dwa wspólne obiady.',
      'Trzy osoby: 3 osoby × 1 dzień = 3 porcje albo 3 osoby × 2 dni = 6 porcji.',
      'To Ty decydujesz, jak często chcesz gotować — w formularzu przepisu podajesz wagę porcji albo liczbę sztuk, a Talerz sam przelicza składniki i układa plan.',
    ],
  },
  {
    tytul: 'Czy mogę powtórzyć wczorajszy posiłek?',
    akapity: [
      'Oczywiście. W Talerzu powtarzanie posiłku nie jest błędem — jest jedną z podstawowych funkcji planowania.',
      'W zakładce Plan jest przycisk „Powtórz poprzedni tydzień”. Przenosi cały układ poprzedniego tygodnia na bieżący, zachowując GARNKI, nie pojedyncze posiłki — danie ugotowane raz i rozłożone na trzy dni zostaje przeniesione jako jedno gotowanie, a nie trzy osobne.',
      'Miejsca już zajęte w bieżącym tygodniu zostają nietknięte — przycisk wypełnia tylko to, co jest jeszcze puste.',
    ],
  },
  {
    tytul: 'Co się dzieje, kiedy oznaczę posiłek?',
    akapity: [
      'Przy każdym przepisie są trzy ikony: gwiazdka, serce i przekreślone kółko (X). Gwiazdka oznacza, że przepis będzie wybierany często podczas automatycznego wypełniania listy. Serce oznacza, że przepis będzie wybierany podczas automatycznego wypełniania listy. Przekreślone kółko (X) oznacza „Nie proponuj” — taki przepis będzie pomijany podczas automatycznego wypełniania listy. Dotknięcie już zaznaczonej ikony cofa ją do stanu neutralnego — bez żadnej preferencji.',
      'Gwiazdka nie oznacza, że dane danie będziesz jadł bez przerwy. Oznacza natomiast, że podczas automatycznego wypełniania listy aplikacja będzie wybierała ten przepis częściej niż pozostałe.',
      'Serce oznacza, że przepis będzie brany pod uwagę podczas automatycznego wypełniania listy, ale bez dodatkowej preferencji częstszego wyboru, jak w przypadku gwiazdki.',
      '„Nie proponuj” działa inaczej niż pozostałe oznaczenia: takiego dania automat nie zaproponuje sam. Ręcznie oczywiście nadal możesz je wybrać.',
      'Z czasem plan wypełniany automatycznie powinien coraz bardziej odpowiadać Twoim własnym preferencjom. Preferencja jest zawsze Twoja własna — nie zależy od tego, co lubią inni użytkownicy.',
    ],
  },
  {
    tytul: 'Dlaczego właśnie takie potrawy?',
    akapity: [
      'Talerz nie ma być największą książką kucharską świata. Nie o to chodzi.',
      'Przepisy powinny być wybierane przede wszystkim dlatego, że: można z nich stworzyć rozsądnie zbilansowany posiłek, wykorzystują normalnie dostępne produkty, nie wymagają kilkunastu egzotycznych składników, można je przygotować w normalnej kuchni, wiele z nich można przechować na kolejny dzień, część można zamrozić, pozwalają kontrolować wielkość porcji i są po prostu smaczne.',
      'Dobry przepis w Talerzu to taki, który chcesz ugotować ponownie.',
    ],
  },
  {
    tytul: 'Dlaczego nie ma tutaj wielu soków, ciast, słodyczy i cukru?',
    akapity: [
      'Talerz nie udaje, że kawałek ciasta nigdy nie istnieje. Ale też nie musi go planować.',
      'Podstawą codziennego jedzenia powinny być warzywa, owoce, produkty pełnoziarniste, odpowiednie źródła białka i dobrej jakości tłuszcze. Produkty zawierające dużo wolnych cukrów powinny stanowić ograniczoną część diety. WHO zaleca, aby wolne cukry dostarczały mniej niż 10% energii, a dalsze ograniczenie może przynosić dodatkowe korzyści.',
      'Dlatego Talerz nie wpisuje automatycznie do planu batonika, słodkiego napoju czy ciasta. Jeżeli masz ochotę na kawałek dobrego ciasta — zjedz go. Talerz ma uporządkować codzienne jedzenie, a nie kontrolować każdą minutę Twojego życia.',
      'Soki również nie są traktowane jak zwykły zamiennik owoców. Cały owoc dostarcza między innymi błonnika i daje większą sytość, podczas gdy WHO zalicza cukry zawarte w sokach do wolnych cukrów.',
    ],
  },
  {
    tytul: 'Ile białka, węglowodanów, tłuszczu i błonnika?',
    akapity: [
      'Nie istnieje jedna idealna proporcja odpowiednia dla wszystkich. Dla zdrowej osoby dorosłej dobrym punktem odniesienia są europejskie wartości referencyjne (EFSA): węglowodany około 45–60% energii, tłuszcze około 20–35% energii, białko około 0,83 g na kilogram masy ciała dziennie, błonnik co najmniej około 25 g dziennie.',
      'Praktyczna zasada komponowania posiłku jest bardzo prosta: ½ talerza warzywa i owoce z przewagą warzyw, ¼ talerza produkty zbożowe, najlepiej pełnoziarniste, ¼ talerza źródło białka, plus niewielka ilość dobrej jakości tłuszczu. Tak wygląda również polski model Talerza Zdrowego Żywienia.',
    ],
  },
  {
    tytul: 'A jeżeli dużo trenuję?',
    akapity: [
      'Wraz z aktywnością fizyczną rośnie przede wszystkim zapotrzebowanie na energię. Przy regularnym i intensywnym treningu zwiększa się także znaczenie odpowiedniej podaży węglowodanów i białka — w żywieniu sportowym zapotrzebowanie na białko może być wyraźnie większe niż podstawowa wartość dla przeciętnej osoby dorosłej.',
      'Dlatego w Profilu ustawiasz poziom aktywności: siedzący (praca siedząca, brak ćwiczeń), lekki (lekkie ćwiczenia 1–3 razy w tygodniu), umiarkowany (ćwiczenia 3–5 razy w tygodniu), duży (ćwiczenia 6–7 razy w tygodniu) albo bardzo duży (praca fizyczna lub dwa treningi dziennie). Talerz liczy z tego zapotrzebowanie energetyczne, które od razu widać niżej na tym samym ekranie, w sekcji celów dziennych.',
    ],
  },
  {
    tytul: 'A wiek?',
    akapity: [
      'Wraz z wiekiem zmienia się przede wszystkim zapotrzebowanie energetyczne oraz sytuacja zdrowotna. Dlatego dzieci, osoby starsze, kobiety w ciąży oraz osoby mające określone choroby lub specjalne wymagania żywieniowe nie powinny otrzymywać przypadkowo wygenerowanej „diety” tylko na podstawie kilku danych.',
      'Talerz może pomagać w planowaniu jedzenia, ale nie udaje lekarza ani dietetyka.',
    ],
  },
  {
    tytul: 'Chcę schudnąć. Ile powinienem jeść?',
    akapity: [
      'W zakładce Profil, przy edycji profilu, wybierasz tryb (redukcja albo utrzymanie wagi) i proporcje makroskładników w procentach energii. Kcal i gramy Talerz liczy z tego sam, na bieżąco z Twojej wagi, wzrostu, wieku i aktywności — nie zapisujesz sztywnej liczby, więc zmiana wagi od razu przesuwa cel.',
      'Talerz jest narzędziem do planowania i realizacji sposobu żywienia, a nie indywidualną konsultacją dietetyczną. Jeżeli potrzebujesz dokładnie określonego zapotrzebowania energetycznego ze względu na chorobę, intensywny sport, znaczną redukcję masy ciała albo inne szczególne potrzeby — warto ustalić je z lekarzem lub dietetykiem. Talerz może potem pomóc konsekwentnie ten cel realizować.',
      'To ważne rozróżnienie: specjalista pomaga ustalić cel, Talerz pomaga go codziennie wykonać.',
    ],
  },
  {
    tytul: 'Jak wytrzymać?',
    akapity: [
      'Najważniejsze jest to, żeby przestać codziennie podejmować te same decyzje. Jeżeli znalazłeś kilkanaście potraw, które naprawdę lubisz, nie ma potrzeby ciągle szukać nowych — możesz wypełnić nimi kolejnych siedem dni, zrobić zakupy i po prostu jeść zgodnie z planem.',
      'Trochę tak, jak realizuje się wcześniej przygotowany plan treningowy albo receptę — nie negocjujesz sam ze sobą przy każdym posiłku.',
      'Oczywiście czasami coś się zmieni — kolacja ze znajomymi, wyjazd, ochota na coś innego. Nic się nie stało: zmieniasz jeden posiłek i wracasz do planu.',
      'Nie potrzebujesz perfekcyjnego tygodnia. Potrzebujesz dobrego sposobu jedzenia przez większość tygodni w roku.',
    ],
  },
  {
    tytul: 'Czy naprawdę warto?',
    akapity: [
      'Tak. Niezdrowy sposób żywienia, nadmierna masa ciała i brak ruchu nie są wyłącznie problemem tego, jak wyglądamy w lustrze. Nadwaga i otyłość zwiększają ryzyko między innymi chorób sercowo-naczyniowych, cukrzycy typu 2, części nowotworów oraz problemów układu ruchu.',
      'Ale nie trzeba czekać kilkudziesięciu lat na chorobę, żeby zauważyć różnicę. Kilka lub kilkanaście niepotrzebnych kilogramów nosimy ze sobą przez cały dzień — kiedy wchodzimy po schodach, kiedy idziemy na dłuższy spacer, kiedy wsiadamy na rower i kiedy przymierzamy koszulkę.',
      'Dlatego Talerz nie powstał po to, żeby przez trzy tygodnie być „na diecie”. Powstał po to, żeby dobre jedzenie stało się najprostszym wyborem, a nie kolejnym codziennym problemem do rozwiązania.',
    ],
  },
  {
    tytul: 'Zasada Talerza',
    akapity: [
      'Zaplanuj. Kup. Ugotuj. Zjedz. Powtórz.',
      'Im mniej niepotrzebnych decyzji musisz podejmować każdego dnia, tym łatwiej być konsekwentnym.',
    ],
  },
];

const ZAKLADKI: PytanieOdpowiedz[] = [
  {
    tytul: 'Profil',
    akapity: [
      'Jeden formularz na profil zawiera zarówno dane potrzebne do wyliczeń (płeć, data urodzenia, wzrost, waga, poziom aktywności), jak i cele dzienne (tryb, proporcje makro, błonnik, próg białka na posiłek) — kcal i gramy nie są zapisane na sztywno, tylko liczone na bieżąco z tych danych. Do 3 profili na konto.',
      'Administrator widzi tu dodatkowo zarządzanie kontami: włączanie i wyłączanie użytkowników oraz nadawanie roli moderatora.',
    ],
  },
  {
    tytul: 'Plan',
    akapity: [
      'Tydzień podzielony na dni, a każdy dzień na śniadanie, obiad i kolację. Puste miejsce ma przycisk wyboru dania; wybrane miejsce pokazuje makro i pozwala je usunąć.',
      '„Wypełnij wolne miejsca” układa automat: dobiera dania pod cel kaloryczny i białkowy dnia, premiuje „Ulubione” i „Lubię”, nigdy nie proponuje sam dania oznaczonego jako „Nie proponuj” i unika powtórek z ostatnich dni. Rusza tylko puste miejsca — nic, co już wpisałeś ręcznie, nie zostanie nadpisane.',
      '„Powtórz poprzedni tydzień” przenosi układ z poprzedniego tygodnia na bieżący, całymi gotowaniami. „Wyczyść wszystko” czyści cały bieżący tydzień od nowa.',
      'Bilans dnia pokazuje liczbowo, ile brakuje do celu kalorycznego i białkowego — nie tylko kolor, bo „prawie dobrze” i „daleko od celu” to różne sytuacje.',
    ],
  },
  {
    tytul: 'Zakupy',
    akapity: [
      'Lista zakupów liczy się sama z zaplanowanych posiłków — sumuje gramatury składników z całego tygodnia. Odhaczone pozycje zostają odhaczone do końca zakupów.',
      'Produkty spoza listy żywieniowej (worki na śmieci, papier śniadaniowy i podobne) dopisujesz ręcznie — zostają zapamiętane i wracają automatycznie w kolejnych tygodniach.',
    ],
  },
  {
    tytul: 'Przepisy',
    akapity: [
      'Baza dań z filtrem po nazwie i zakładkami kategorii (śniadanie, obiad, kolacja, dodatek). „Dodatek” to coś, co dokładasz do posiłku — grillowana pierś, surówka, sałatka z ciecierzycy — dlatego pojawia się przy wyborze dania do każdej pory dnia.',
      'Dodawanie i edycja przepisów wymaga roli moderatora. Nowy przepis jest prywatny; zgłoszenie do publikacji i zatwierdzenie to osobny obieg z ptaszkiem zgody autora.',
      'Import i eksport przez plik Excel (dostępny dla moderatora) pozwala zrobić kopię zapasową całej bazy albo masowo poprawić przepisy poza aplikacją — plik rozpoznaje dania po nazwie i nadpisuje istniejące zamiast tworzyć duplikaty.',
    ],
  },
];

function Sekcja({ dane }: { dane: PytanieOdpowiedz[] }) {
  return (
    <>
      {dane.map((pozycja) => (
        <Karta key={pozycja.tytul}>
          <ThemedText type="smallBold">{pozycja.tytul}</ThemedText>
          {pozycja.akapity.map((akapit, i) => (
            <ThemedText key={i} type="small" themeColor="textSecondary">
              {akapit}
            </ThemedText>
          ))}
        </Karta>
      ))}
    </>
  );
}

export default function EkranInstrukcji() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();

  return (
    <Ekran tytul="Instrukcja" podtytul="Po co jest Talerz i jak z niego korzystać">
      <View style={styles.naglowekSekcji}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          DLACZEGO TALERZ
        </ThemedText>
      </View>
      <Sekcja dane={DLACZEGO_TALERZ} />

      <View style={styles.naglowekSekcji}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          JAK KORZYSTAĆ Z APLIKACJI
        </ThemedText>
      </View>
      <Sekcja dane={ZAKLADKI} />

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  naglowekSekcji: {
    paddingTop: Spacing.two,
  },
});
