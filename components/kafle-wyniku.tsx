import { Ionicons } from '@expo/vector-icons';
import { StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import type { Makro } from '@/lib/zywienie';

/**
 * Cztery kafle wyniku (kcal, białko, tłuszcz, węgle) obok siebie, z ikoną
 * w miękkim kolorowym kółku nad każdą wartością — używane na liście profili
 * i w formularzu edycji, żeby wynik wyglądał tak samo w obu miejscach.
 *
 * Kółko dostaje tło w kolorze ikony, ale z dopisaną przezroczystością przez
 * dwucyfrowy sufiks szesnastkowy (np. `#3F8F5F22`) — React Native rozumie
 * kolory 8-cyfrowe wprost, więc nie trzeba osobnej „miękkiej” palety.
 */
export function KafleWyniku({ cel }: { cel: Makro }) {
  const motyw = useTheme();
  const kafle: { etykieta: string; wartosc: number; jednostka: string; ikona: keyof typeof Ionicons.glyphMap; kolor: string }[] = [
    { etykieta: 'kcal', wartosc: cel.kcal, jednostka: '', ikona: 'flame', kolor: motyw.accent },
    { etykieta: 'białko', wartosc: cel.bialko, jednostka: 'g', ikona: 'nutrition-outline', kolor: KOLOR_MAKRO.bialko },
    { etykieta: 'tłuszcz', wartosc: cel.tluszcz, jednostka: 'g', ikona: 'water-outline', kolor: KOLOR_MAKRO.tluszcz },
    { etykieta: 'węgle', wartosc: cel.wegle, jednostka: 'g', ikona: 'leaf-outline', kolor: KOLOR_MAKRO.wegle },
  ];

  return (
    <View style={styles.rzad}>
      {kafle.map((k) => (
        <View key={k.etykieta} style={styles.kafel}>
          <View style={[styles.kolko, { backgroundColor: `${k.kolor}22` }]}>
            <Ionicons name={k.ikona} size={22} color={k.kolor} />
          </View>
          <ThemedText type="smallBold" style={styles.wartosc} numberOfLines={1}>
            {k.wartosc}
            {k.jednostka ? ` ${k.jednostka}` : ''}
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
            {k.etykieta}
          </ThemedText>
        </View>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  rzad: {
    flexDirection: 'row',
  },
  kafel: {
    flex: 1,
    alignItems: 'center',
    gap: 2,
    paddingHorizontal: 2,
  },
  kolko: {
    width: 44,
    height: 44,
    borderRadius: 22,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: Spacing.one,
  },
  wartosc: {
    fontSize: 18,
  },
});
