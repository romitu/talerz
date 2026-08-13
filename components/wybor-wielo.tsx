import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type WyborWieloProps<T extends string> = {
  etykieta: string;
  opcje: { wartosc: T; etykieta: string }[];
  wybrane: T[];
  onZmiana: (wybrane: T[]) => void;
};

/** Wybór wielu wartości naraz — przełączane klocki zamiast listy z zaznaczeniami. */
export function WyborWielo<T extends string>({
  etykieta,
  opcje,
  wybrane,
  onZmiana,
}: WyborWieloProps<T>) {
  const motyw = useTheme();

  function przelacz(wartosc: T) {
    onZmiana(
      wybrane.includes(wartosc) ? wybrane.filter((x) => x !== wartosc) : [...wybrane, wartosc]
    );
  }

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {etykieta}
      </ThemedText>

      <View style={styles.klocki}>
        {opcje.map((o) => {
          const zaznaczony = wybrane.includes(o.wartosc);
          return (
            <Pressable
              key={o.wartosc}
              onPress={() => przelacz(o.wartosc)}
              accessibilityRole="checkbox"
              accessibilityState={{ checked: zaznaczony }}
              style={({ pressed }) => [
                styles.klocek,
                {
                  borderColor: zaznaczony ? motyw.accent : motyw.border,
                  backgroundColor: zaznaczony ? motyw.backgroundSelected : motyw.backgroundElement,
                },
                pressed && styles.wcisniety,
              ]}>
              <ThemedText type={zaznaczony ? 'smallBold' : 'small'}>{o.etykieta}</ThemedText>
            </Pressable>
          );
        })}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.one },
  klocki: { flexDirection: 'row', flexWrap: 'wrap', gap: Spacing.two },
  klocek: {
    borderWidth: 1,
    borderRadius: Spacing.four,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.one,
  },
  wcisniety: { opacity: 0.7 },
});
