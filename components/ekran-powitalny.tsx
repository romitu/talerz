import { Image } from 'expo-image';
import { ScrollView, StyleSheet, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { Przycisk } from './przycisk';
import { ThemedView } from './themed-view';

import { MaxContentWidth, Spacing } from '@/constants/theme';

/**
 * Ekran powitalny — pokazuje się po każdym zalogowaniu.
 *
 * Dlaczego za każdym razem, a nie raz
 * -----------------------------------
 * Decyzja Romana. Logowanie zdarza się rzadko — sesja trzyma się tygodniami —
 * więc ten ekran nie wejdzie w drogę przy codziennym używaniu.
 *
 * Grafika
 * -------
 * `assets/images/ilustracja-plan.png`, 941 na 1672 punkty — logo aplikacji
 * dostarczone przez Romana.
 */
export function EkranPowitalny({ onDalej }: { onDalej: () => void }) {
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
  const grafika = require('../assets/images/ilustracja-plan.png');

  return (
    <ThemedView style={styles.tlo}>
      <SafeAreaView edges={['top']} style={styles.bezpieczny}>
        <ScrollView contentContainerStyle={styles.zawartosc}>
          <Image
            source={grafika}
            style={styles.grafika}
            contentFit="contain"
            accessibilityLabel="Talerz — powiedz, dla ilu osób planujesz i na ile dni; Talerz zdecyduje co ugotować, ile zrobić, co zjeść jutro i co dokładnie kupić"
            transition={200}
          />

          <View style={styles.bialeTlo}>
            <Przycisk tytul="Zaczynamy" onPress={onDalej} />
          </View>
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
    aspectRatio: 941 / 1672,
  },
  bialeTlo: {
    backgroundColor: '#FFFFFF',
    borderRadius: Spacing.three,
    padding: Spacing.three,
  },
});
