import { StyleSheet, View } from 'react-native';

import {
  Cytat,
  HeroArtykulu,
  Kafel,
  Krok,
  ListaPunktow,
  NaglowekSekcji,
  OsKrokow,
  PasekSekcji,
  PigulkiHero,
  Punkt,
  SiatkaKafli,
  useNawigacjaSekcji,
  WierszZIkona,
  Wyroznienie,
} from '@/components/artykul';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';

/**
 * Dlaczego Talerz — treść zsynchronizowana z makietą `Dlaczego Talerz.html`
 * od Romana. Makieta jest stroną typu landing page: duży nagłówek, sekcje
 * z nadtytułem, oś metody i porównanie „przed / po”. Ten sam układ budujemy
 * z klocków z `components/artykul.tsx`, więc ekran wygląda jak strona,
 * a nie jak wklejony akapit.
 */

const SEKCJE = [
  { id: 'dlaczego', skrot: 'Dlaczego' },
  { id: 'metoda', skrot: 'Metoda' },
  { id: 'system', skrot: 'Nie dieta' },
  { id: 'podstawy', skrot: 'Pod spodem' },
  { id: 'wazne', skrot: 'Znaczenie' },
  { id: 'efekt', skrot: 'Po co' },
];

const HASLA = [
  { ikona: 'calendar-outline' as const, tekst: 'plan na kilka dni' },
  { ikona: 'cart-outline' as const, tekst: 'lista zakupów z planu' },
  { ikona: 'restaurant-outline' as const, tekst: 'gotowanie na 2–3 dni' },
];

const BOLACZKI: Kafel[] = [
  {
    ikona: 'help-circle-outline',
    tytul: '„Co dzisiaj zjeść?”',
    opis: 'Ta sama decyzja wraca codziennie, często wtedy, gdy jesteśmy już głodni i zmęczeni.',
  },
  {
    ikona: 'cart-outline',
    tytul: '„Co właściwie kupić?”',
    opis: 'Bez planu zakupy łatwo stają się zbiorem pojedynczych produktów, a nie podstawą konkretnych posiłków.',
  },
  {
    ikona: 'speedometer-outline',
    tytul: '„Czy to pasuje do mojego celu?”',
    opis: 'Sam pojedynczy „zdrowy” posiłek nie mówi jeszcze, jak wygląda bilans całego dnia i całego tygodnia.',
  },
];

const KROKI: Krok[] = [
  { tytul: 'Ustal swój cel', opis: 'Profil określa zapotrzebowanie i sposób, w jaki ma być układany plan.' },
  { tytul: 'Powiedz, co lubisz', opis: 'Algorytm ma pracować na daniach, które naprawdę chcesz później zjeść.' },
  { tytul: 'Zaplanuj kilka dni', opis: 'Plan bierze pod uwagę porcje, bilans dnia i możliwość przygotowania jedzenia na zapas.' },
  { tytul: 'Kup konkretnie', opis: 'Lista zakupów wynika z planu. Kupujesz to, co ma później trafić na talerz.' },
  { tytul: 'Ugotuj i powtórz', opis: 'Jeżeli danie dobrze się przechowuje, jedno gotowanie może obsłużyć dwa lub trzy dni.' },
];

const IMPROWIZACJA: Punkt[] = [
  { tytul: 'Decyzja przy każdym posiłku', opis: 'ciągłe wymyślanie od nowa' },
  { tytul: 'Zakupy bez pełnego planu', opis: 'produkty nie zawsze składają się w konkretne posiłki' },
  { tytul: 'Gotowanie od zera każdego dnia', opis: 'dużo czasu i wysoki próg wejścia' },
  { tytul: 'Cel gdzieś w tle', opis: 'trudniej ocenić bilans całego dnia' },
];

const METODA: Punkt[] = [
  { tytul: 'Decyzje podejmujesz wcześniej', opis: 'w tygodniu głównie realizujesz plan' },
  { tytul: 'Zakupy wynikają z posiłków', opis: 'lista tworzy się z konkretnego planu' },
  { tytul: 'Gotujesz rozsądniej', opis: 'część potraw może być przygotowana na 2–3 dni' },
  { tytul: 'Bilans jest częścią planu', opis: 'energia, białko i pozostałe cele są widoczne od początku' },
];

const FUNDAMENTY: Kafel[] = [
  {
    ikona: 'leaf-outline',
    tytul: 'Mniej żywności ultraprzetworzonej',
    opis: 'Baza preferuje produkty nieprzetworzone i nisko przetworzone; klasyfikacja NOVA jest jednym z filtrów.',
  },
  {
    ikona: 'pie-chart-outline',
    tytul: 'Bilans, nie jedna magiczna proporcja',
    opis: 'Makroskładniki są traktowane jako zakresy, a nie jako jedna sztywna wartość odpowiednia dla wszystkich.',
  },
  {
    ikona: 'nutrition-outline',
    tytul: 'Błonnik ma znaczenie',
    opis: 'Plan nie kończy się na kaloriach i białku. Błonnik jest osobnym elementem celu żywieniowego.',
  },
  {
    ikona: 'person-outline',
    tytul: 'Cel zależy od człowieka',
    opis: 'Wiek, masa ciała, wzrost, aktywność i wybrany tryb wpływają na wartości widoczne w profilu.',
  },
];

const DLACZEGO_WAZNE: Krok[] = [
  {
    tytul: 'Cel bez wykonania niewiele zmienia',
    opis: 'Wiedzieć, co warto jeść, to jedno. Mieć plan i produkty potrzebne do jego realizacji — to drugie.',
  },
  {
    tytul: 'Najważniejsza jest powtarzalność',
    opis: 'Nie potrzebujesz idealnego menu przez siedem dni. Potrzebujesz rozwiązania, do którego można wracać przez większość tygodni w roku.',
  },
  {
    tytul: 'Małe decyzje sumują się',
    opis: 'Śniadanie, obiad i kolacja to setki decyzji w ciągu roku. Talerz próbuje uprościć właśnie tę codzienność.',
  },
  {
    tytul: 'Specjalista ustala szczególny cel. Talerz pomaga go realizować.',
    opis: 'Przy chorobach, ciąży, żywieniu dzieci czy intensywnym sporcie cel powinien wynikać z właściwej konsultacji.',
  },
];

const EFEKTY: Kafel[] = [
  { ikona: 'bulb-outline', tytul: 'Mniej zastanawiania', opis: 'wiesz wcześniej, co będziesz jeść' },
  { ikona: 'flame-outline', tytul: 'Mniej gotowania od zera', opis: 'wykorzystujesz dania na kolejne dni' },
  { ikona: 'list-outline', tytul: 'Zakupy z konkretnym celem', opis: 'lista wynika z planu posiłków' },
  { ikona: 'repeat-outline', tytul: 'Więcej konsekwencji', opis: 'plan jest łatwiejszy do realizacji niż codzienna improwizacja' },
];

export default function EkranDlaczegoTalerz() {
  const { przewijanie, zapiszUklad, przewinDo } = useNawigacjaSekcji();

  return (
    <Ekran
      tytul="Dlaczego Talerz"
      refPrzewijania={przewijanie}
      naglowekStaly={<PasekSekcji pozycje={SEKCJE} onWybor={przewinDo} />}>
      <HeroArtykulu
        ikona="sparkles"
        odznaka="Nie kolejna dieta"
        tytul="Dobre jedzenie nie powinno wymagać codziennie silnej woli."
        lead="Talerz zamienia codzienne pytanie „co dziś zjeść?” w plan na kilka dni. Ustalasz cel i preferencje, planujesz, robisz jedne konkretne zakupy i później po prostu jesz to, co wcześniej zdecydowałeś."
      />
      <PigulkiHero pozycje={HASLA} />

      <NaglowekSekcji
        nadtytul="Dlaczego powstał Talerz"
        tytul="Problemem często nie jest brak wiedzy. Problemem jest codzienna improwizacja."
        onUklad={zapiszUklad('dlaczego')}
      />
      <ThemedText type="small" themeColor="textSecondary">
        Większość z nas wie, że warto jeść rozsądniej. Trudniejsze jest robienie tego regularnie —
        po pracy, przy pustej lodówce, bez planu i z koniecznością kolejnego wyboru.
      </ThemedText>
      <Cytat
        tekst="Talerz przenosi decyzje z każdego dnia do jednego krótkiego momentu planowania."
        podtekst="Zamiast trzy razy dziennie negocjować ze sobą, najpierw ustalasz plan. Potem realizujesz to, co już zostało wybrane."
      />
      <Karta style={styles.kartaBolaczek}>
        {BOLACZKI.map((b) => (
          <WierszZIkona key={b.tytul} {...b} />
        ))}
      </Karta>

      <NaglowekSekcji
        nadtytul="Metoda Talerza"
        tytul="Najpierw decyzja. Potem wykonanie."
        onUklad={zapiszUklad('metoda')}
      />
      <ThemedText type="small" themeColor="textSecondary">
        Talerz nie próbuje codziennie motywować Cię od nowa. Pomaga zbudować prosty proces, który
        można powtarzać tydzień po tygodniu.
      </ThemedText>
      <Karta>
        <OsKrokow kroki={KROKI} />
      </Karta>
      <Wyroznienie tekst="Zaplanuj. Kup. Ugotuj. Zjedz. Powtórz." />

      <NaglowekSekcji
        nadtytul="Nie dieta. System."
        tytul="Nie chodzi o perfekcyjny tydzień. Chodzi o sposób, który da się utrzymać."
        onUklad={zapiszUklad('system')}
      />
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary" style={styles.tytulPorownania}>
          CODZIENNA IMPROWIZACJA
        </ThemedText>
        <ListaPunktow pozycje={IMPROWIZACJA} wariant="nie" />
      </Karta>
      <Karta>
        <ThemedText type="smallBold" themeColor="accent" style={styles.tytulPorownania}>
          METODA TALERZA
        </ThemedText>
        <ListaPunktow pozycje={METODA} wariant="tak" />
      </Karta>

      <NaglowekSekcji
        nadtytul="Co jest pod spodem"
        tytul="Prosta obsługa, ale nie przypadkowe założenia."
        onUklad={zapiszUklad('podstawy')}
      />
      <ThemedText type="small" themeColor="textSecondary">
        Talerz ma upraszczać codzienne jedzenie, nie upraszczać żywienia do samej liczby kalorii.
      </ThemedText>
      <SiatkaKafli kafle={FUNDAMENTY} />

      <NaglowekSekcji
        nadtytul="Dlaczego to jest ważne"
        tytul="Jedzenie działa codziennie — nie dopiero wtedy, gdy zaczynamy „dietę”."
        onUklad={zapiszUklad('wazne')}
      />
      <ThemedText type="small" themeColor="textSecondary">
        Sposób żywienia wpływa na masę ciała, samopoczucie i zdrowie w dłuższej perspektywie.
        Talerz nie obiecuje leczenia ani szybkiej przemiany. Jego rolą jest pomóc zamienić rozsądny
        cel w codzienny, wykonalny proces.
      </ThemedText>
      <Karta>
        <OsKrokow kroki={DLACZEGO_WAZNE} />
      </Karta>

      <NaglowekSekcji
        nadtytul="Po co to wszystko"
        tytul="Żeby dobre jedzenie stało się najprostszym wyborem, a nie kolejnym codziennym problemem."
        onUklad={zapiszUklad('efekt')}
      />
      <ThemedText type="small" themeColor="textSecondary">
        Talerz nie ma być dietą na miesiąc. Ma pomagać organizować normalne jedzenie przez lata:
        z planem, konkretnymi zakupami, sensownymi porcjami i mniejszą liczbą decyzji.
      </ThemedText>
      <SiatkaKafli kafle={EFEKTY} />

      <View style={styles.stopka}>
        <ThemedText type="small" themeColor="textSecondary" style={styles.stopkaTekst}>
          Talerz jest narzędziem do planowania sposobu żywienia dla ogólnej populacji i nie
          zastępuje lekarza ani dietetyka. Założenia żywieniowe oparto m.in. na zakresach AMDR,
          wartościach referencyjnych EFSA, klasyfikacji NOVA oraz polskim Talerzu Zdrowego
          Żywienia.
        </ThemedText>
      </View>
    </Ekran>
  );
}

const styles = StyleSheet.create({
  kartaBolaczek: {
    gap: Spacing.three,
  },
  tytulPorownania: {
    fontSize: 11,
    letterSpacing: 0.8,
  },
  stopka: {
    paddingTop: Spacing.two,
  },
  stopkaTekst: {
    fontSize: 12,
    lineHeight: 18,
    textAlign: 'center',
  },
});
