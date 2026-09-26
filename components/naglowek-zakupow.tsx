import { Ionicons } from '@expo/vector-icons';
import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { WIDOKI_ZAKUPOW, type WidokZakupow } from '@/lib/widok-zakupow';

/**
 * Nagłówek listy zakupów — koszyk, tytuł, tydzień i liczniki zrealizowane/
 * niezrealizowane. Zielony/pomarańczowy kolor liczników to identyfikacja
 * stanu (jak `KOLOR_MAKRO`), więc jest stały niezależnie od wybranego stylu.
 */
export function NaglowekZakupow({
  data,
  zrealizowane,
  niezrealizowane,
  widok,
  onZmianaWidoku,
}: {
  data?: string;
  zrealizowane: number;
  niezrealizowane: number;
  widok: WidokZakupow;
  onZmianaWidoku: (widok: WidokZakupow) => void;
}) {
  const motyw = useTheme();
  const zielony = KOLOR_MAKRO.bialko;
  const pomaranczowy = KOLOR_MAKRO.tluszcz;

  return (
    <ThemedView type="backgroundElement" style={[styles.karta, { borderColor: motyw.border }]}>
      <View style={styles.gorny}>
        <View style={[styles.koszyk, { backgroundColor: motyw.backgroundSelected }]}>
          <Ionicons name="cart-outline" size={22} color={zielony} />
        </View>

        <View style={styles.tytulOpis}>
          <ThemedText type="subtitle" numberOfLines={1}>
            Lista zakupów
          </ThemedText>
          {data ? (
            <ThemedText
              type="small"
              themeColor="textSecondary"
              numberOfLines={1}
              style={styles.data}>
              {data}
            </ThemedText>
          ) : null}
        </View>
      </View>

      <View style={[styles.liczniki, { backgroundColor: motyw.background, borderColor: motyw.border }]}>
        <View style={styles.licznik}>
          <View style={[styles.kolkoIkony, { backgroundColor: zielony }]}>
            <Ionicons name="checkmark" size={12} color="#fff" />
          </View>
          <ThemedText type="smallBold" style={{ color: zielony }} numberOfLines={1}>
            {zrealizowane} zrealizowane
          </ThemedText>
        </View>

        <View style={[styles.oddzielacz, { backgroundColor: motyw.border }]} />

        <View style={styles.licznik}>
          <View style={[styles.kolkoIkony, styles.kolkoPuste, { borderColor: pomaranczowy }]} />
          <ThemedText type="smallBold" style={{ color: pomaranczowy }} numberOfLines={1}>
            {niezrealizowane} niezrealizowane
          </ThemedText>
        </View>
      </View>

      <View
        style={[styles.przelacznik, { backgroundColor: motyw.background, borderColor: motyw.border }]}
        accessibilityRole="radiogroup"
        accessibilityLabel="Widok listy">
        {WIDOKI_ZAKUPOW.map((w) => {
          const wybrany = w.wartosc === widok;
          return (
            <Pressable
              key={w.wartosc}
              onPress={() => onZmianaWidoku(w.wartosc)}
              accessibilityRole="radio"
              accessibilityState={{ checked: wybrany }}
              style={[styles.opcjaWidoku, wybrany && { backgroundColor: motyw.backgroundSelected }]}>
              <Ionicons name={w.ikona} size={16} color={wybrany ? motyw.accent : motyw.textSecondary} />
              <ThemedText
                type={wybrany ? 'smallBold' : 'small'}
                themeColor={wybrany ? 'accent' : 'textSecondary'}
                numberOfLines={1}>
                {w.etykieta}
              </ThemedText>
            </Pressable>
          );
        })}
      </View>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  karta: {
    borderWidth: 1,
    borderRadius: Spacing.three,
    padding: Spacing.three,
    gap: Spacing.two,
  },
  gorny: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  koszyk: {
    width: 44,
    height: 44,
    borderRadius: 22,
    alignItems: 'center',
    justifyContent: 'center',
  },
  tytulOpis: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'baseline',
    gap: Spacing.two,
  },
  data: {
    flexShrink: 1,
  },
  liczniki: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    paddingVertical: Spacing.two,
    paddingHorizontal: Spacing.two,
  },
  licznik: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  oddzielacz: {
    width: 1,
    alignSelf: 'stretch',
  },
  kolkoIkony: {
    width: 18,
    height: 18,
    borderRadius: 9,
    alignItems: 'center',
    justifyContent: 'center',
  },
  przelacznik: {
    flexDirection: 'row',
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: 3,
    gap: 3,
  },
  opcjaWidoku: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 4,
    paddingVertical: 6,
    borderRadius: 6,
  },
  kolkoPuste: {
    backgroundColor: 'transparent',
    borderWidth: 2,
  },
});
