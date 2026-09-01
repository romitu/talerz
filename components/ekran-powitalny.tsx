import { Image } from 'expo-image';
import { ScrollView, StyleSheet, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { MaxContentWidth, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/**
 * Ekran powitalny — pokazuje się po każdym zalogowaniu.
 *
 * Dlaczego za każdym razem, a nie raz
 * -----------------------------------
 * Decyzja Romana. Logowanie zdarza się rzadko — sesja trzyma się tygodniami —
 * więc ten ekran nie wejdzie w drogę przy codziennym używaniu. Za to za każdym
 * razem przypomni, czym Talerz jest i czym NIE jest, a to drugie ma znaczenie
 * przy aplikacji dotykającej jedzenia i zdrowia.
 *
 * Grafika
 * -------
 * `assets/images/logo-talerz.png`, 610 na 342 punkty. Proporcja wychodzi
 * 1,784 przy 1,778 dla klasycznego szesnaście do dziewięciu — różnica to
 * niecały procent, więc `contain` zmieści obraz w całości bez widocznych
 * pasów po bokach i bez obcinania czegokolwiek.
 *
 * Plik przeniosłem z katalogu głównego do `assets/images` i zmieniłem nazwę
 * na bezspacjową. Spacja w nazwie pliku potrafi się rozjechać przy budowaniu
 * na serwer — a to akurat ta klasa usterek, która wychodzi dopiero po
 * opublikowaniu strony.
 */
export function EkranPowitalny({ onDalej }: { onDalej: () => void }) {
  const motyw = useTheme();

  /*
    Ścieżka WZGLĘDNA, nie skrót `@/`.

    Skrót `@/` jest ustawiony w `tsconfig.json` i działa dla modułów, ale to
    był pierwszy obrazek wczytywany w tym projekcie przez `require` — reszta
    grafik podawana jest w `app.json` ścieżką względną. TypeScript tego nie
    sprawdza, bo `require` zwraca `any` i nie rozwiązuje ścieżki, więc
    `tsc` przechodził niezależnie od tego, czy skrót zadziała.

    Ścieżka względna nie zależy od żadnej konfiguracji i rozwiązuje się tak
    samo przy uruchomieniu lokalnym i przy budowaniu na serwer.
  */
  const grafika = require('../assets/images/logo-talerz.png');

  return (
    <ThemedView style={styles.tlo}>
      <SafeAreaView edges={['top']} style={styles.bezpieczny}>
        <ScrollView contentContainerStyle={styles.zawartosc}>
          <Image
            source={grafika}
            style={[styles.grafika, { borderColor: motyw.border }]}
            contentFit="contain"
            /*
              Opis dla czytników ekranu. Obrazek niesie tu treść — pokazuje,
              czym aplikacja się zajmuje — więc pominięcie go zostawiłoby
              kogoś niewidomego bez połowy powitania.
            */
            accessibilityLabel="Talerz — tygodniowy plan posiłków w notesie, obok listy zakupów i produktów"
            transition={200}
          />

          <View style={styles.tekst}>
            <ThemedText type="subtitle">Jeden plan, jedna lista zakupów</ThemedText>

            <ThemedText type="default">
              Zakładasz profil dla siebie i domowników — do czterech osób. Ustalasz cele,
              nanosisz własne korekty. Przeglądasz przepisy, które omijają żywność wysoko
              przetworzoną, i oznaczasz: bardzo lubię, lubię, nie lubię. Co lubisz najbardziej,
              wraca częściej; czego nie lubisz, nie wraca wcale.
            </ThemedText>

            <ThemedText type="default" themeColor="textSecondary">
              Przy każdym daniu wybierasz, na ile dni ma starczyć. Klikasz raz — Talerz układa
              plan do siedmiu dni i składa z niego jedną listę zakupów. W sklepie odhaczasz,
              w domu klikasz nazwę przepisu i gotujesz krok po kroku.
            </ThemedText>

            <ThemedText type="default" themeColor="textSecondary">
              Kalorie liczy równaniami NASEM 2023 — amerykańską normą DRI na energię — z wieku,
              wzrostu, masy ciała i aktywności. Żadna liczba nie jest brana na oko.
            </ThemedText>

            <View style={[styles.zastrzezenie, { borderLeftColor: motyw.border }]}>
              <ThemedText type="small" themeColor="textSecondary">
                Talerz jest narzędziem do planowania, nie poradnią. Nie stawia rozpoznań,
                nie leczy i nie zastępuje rozmowy z lekarzem ani dietetykiem. Przeznaczony
                dla osób pełnoletnich.
              </ThemedText>
            </View>
          </View>

          <Przycisk tytul="Zaczynamy" onPress={onDalej} />
        </ScrollView>
      </SafeAreaView>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  tlo: { flex: 1 },
  bezpieczny: { flex: 1 },
  zawartosc: {
    paddingHorizontal: Spacing.three,
    paddingTop: Spacing.four,
    paddingBottom: Spacing.six,
    gap: Spacing.four,
    width: '100%',
    maxWidth: MaxContentWidth,
    alignSelf: 'center',
    flexGrow: 1,
    justifyContent: 'center',
  },
  grafika: {
    width: '100%',
    // Proporcja wprost z pliku, nie zaokrąglona do 16/9. Przy `contain`
    // różnica jednego procenta dałaby cienkie paski na górze i dole.
    aspectRatio: 610 / 342,
    borderRadius: Spacing.three,
    borderWidth: 1,
  },
  tekst: { gap: Spacing.three },
  zastrzezenie: {
    borderLeftWidth: 3,
    paddingLeft: Spacing.two,
    paddingVertical: Spacing.one,
  },
});
