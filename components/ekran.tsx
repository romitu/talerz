import type { ReactNode } from 'react';
import { ScrollView, StyleSheet, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { MaxContentWidth, Spacing } from '@/constants/theme';

type EkranProps = {
  tytul: string;
  podtytul?: string;
  /**
   * Zdejmuje ograniczenie szerokości treści.
   *
   * Domyślne 760 pikseli jest dobre dla tekstu — dłuższe wiersze źle się czyta.
   * Przy tabelach działa odwrotnie: zmusza do przewijania w bok mimo wolnego
   * miejsca na ekranie.
   */
  pelnaSzerokosc?: boolean;
  children: ReactNode;
};

/**
 * Wspólny układ każdego ekranu: tło, bezpieczny obszar (żeby treść nie chowała
 * się pod wycięciem aparatu), przewijanie i nagłówek. Dzięki temu wszystkie
 * ekrany wyglądają tak samo i nie powtarzamy tego kodu cztery razy.
 */
export function Ekran({ tytul, podtytul, pelnaSzerokosc = false, children }: EkranProps) {
  return (
    <ThemedView style={styles.tlo}>
      <SafeAreaView edges={['top']} style={styles.obszarBezpieczny}>
        <ScrollView
          style={styles.przewijanie}
          contentContainerStyle={[
            styles.zawartosc,
            pelnaSzerokosc && styles.zawartoscPelna,
          ]}
          showsVerticalScrollIndicator={false}>
          <View style={styles.naglowek}>
            <ThemedText type="subtitle">{tytul}</ThemedText>
            {podtytul ? (
              <ThemedText type="small" themeColor="textSecondary">
                {podtytul}
              </ThemedText>
            ) : null}
          </View>
          {children}
        </ScrollView>
      </SafeAreaView>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  tlo: {
    flex: 1,
  },
  obszarBezpieczny: {
    flex: 1,
  },
  przewijanie: {
    flex: 1,
  },
  zawartosc: {
    paddingHorizontal: Spacing.three,
    paddingBottom: Spacing.six,
    gap: Spacing.three,
    width: '100%',
    maxWidth: MaxContentWidth,
    alignSelf: 'center',
  },
  zawartoscPelna: {
    maxWidth: undefined,
  },
  naglowek: {
    paddingTop: Spacing.three,
    paddingBottom: Spacing.one,
    gap: Spacing.half,
  },
});
