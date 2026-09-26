import { Ionicons } from '@expo/vector-icons';
import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { WIDOKI_LISTY, type WidokListy } from '@/lib/widok-listy';

/** Trzy przyciski obok siebie: kafle, z miniaturką, lista. */
export function PrzelacznikWidoku({
  widok,
  onZmiana,
}: {
  widok: WidokListy;
  onZmiana: (widok: WidokListy) => void;
}) {
  const motyw = useTheme();

  return (
    <View
      style={[styles.przelacznik, { backgroundColor: motyw.background, borderColor: motyw.border }]}
      accessibilityRole="radiogroup"
      accessibilityLabel="Widok listy">
      {WIDOKI_LISTY.map((w) => {
        const wybrany = w.wartosc === widok;
        return (
          <Pressable
            key={w.wartosc}
            onPress={() => onZmiana(w.wartosc)}
            accessibilityRole="radio"
            accessibilityState={{ checked: wybrany }}
            style={[styles.opcja, wybrany && { backgroundColor: motyw.backgroundSelected }]}>
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
  );
}

const styles = StyleSheet.create({
  przelacznik: {
    flexDirection: 'row',
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: 3,
    gap: 3,
  },
  opcja: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 4,
    paddingVertical: 6,
    borderRadius: 6,
  },
});
