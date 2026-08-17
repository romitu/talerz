import type { ReactNode, RefObject } from 'react';
import { ScrollView, StyleSheet, View, type ScrollViewProps } from 'react-native';
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

  /**
   * Dostęp do przewijanego obszaru — potrzebny tam, gdzie ekran musi wrócić
   * na to samo miejsce, na którym był.
   *
   * Bez tego ekran planu po dodaniu dania wracał na samą górę: wybór przepisu
   * podmienia CAŁĄ treść, więc po powrocie lista buduje się od nowa i zaczyna
   * od zera. Przy siódmym dniu tygodnia oznaczało to przewijanie w dół
   * za każdym razem.
   */
  refPrzewijania?: RefObject<ScrollView | null>;
  onScroll?: ScrollViewProps['onScroll'];
  onContentSizeChange?: ScrollViewProps['onContentSizeChange'];

  children: ReactNode;
};

/**
 * Wspólny układ każdego ekranu: tło, bezpieczny obszar (żeby treść nie chowała
 * się pod wycięciem aparatu), przewijanie i nagłówek. Dzięki temu wszystkie
 * ekrany wyglądają tak samo i nie powtarzamy tego kodu cztery razy.
 */
export function Ekran({
  tytul,
  podtytul,
  pelnaSzerokosc = false,
  refPrzewijania,
  onScroll,
  onContentSizeChange,
  children,
}: EkranProps) {
  return (
    <ThemedView style={styles.tlo}>
      <SafeAreaView edges={['top']} style={styles.obszarBezpieczny}>
        <ScrollView
          ref={refPrzewijania}
          onScroll={onScroll}
          onContentSizeChange={onContentSizeChange}
          // Bez tego zdarzenie przewijania przychodzi raz na sekundę i
          // zapamiętana pozycja jest nieaktualna.
          scrollEventThrottle={16}
          style={styles.przewijanie}
          contentContainerStyle={[
            styles.zawartosc,
            pelnaSzerokosc ? styles.bezOgraniczenia : styles.zOgraniczeniem,
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
    alignSelf: 'center',
  },
  /* Ograniczenie szerokości nakładamy osobnym stylem zamiast nadpisywać —
     wartość pusta w nadpisaniu bywa ignorowana i tabela dalej się przewijała. */
  zOgraniczeniem: {
    maxWidth: MaxContentWidth,
  },
  bezOgraniczenia: {
    maxWidth: '100%',
  },
  naglowek: {
    paddingTop: Spacing.three,
    paddingBottom: Spacing.one,
    gap: Spacing.half,
  },
});
