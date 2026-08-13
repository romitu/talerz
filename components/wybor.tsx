import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type Opcja<T extends string> = {
  wartosc: T;
  etykieta: string;
  opis?: string;
};

type WyborProps<T extends string> = {
  etykieta: string;
  opcje: Opcja<T>[];
  wybrana: T;
  onZmiana: (wartosc: T) => void;
};

/** Lista wzajemnie wykluczających się opcji — zastępuje listę rozwijaną. */
export function Wybor<T extends string>({ etykieta, opcje, wybrana, onZmiana }: WyborProps<T>) {
  const motyw = useTheme();

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {etykieta}
      </ThemedText>

      {opcje.map((o) => {
        const zaznaczona = o.wartosc === wybrana;
        return (
          <Pressable
            key={o.wartosc}
            onPress={() => onZmiana(o.wartosc)}
            accessibilityRole="radio"
            accessibilityState={{ selected: zaznaczona }}
            style={({ pressed }) => [
              styles.opcja,
              {
                borderColor: zaznaczona ? motyw.accent : motyw.border,
                backgroundColor: zaznaczona ? motyw.backgroundSelected : motyw.backgroundElement,
              },
              pressed && styles.wcisnieta,
            ]}>
            <ThemedText type={zaznaczona ? 'smallBold' : 'small'}>{o.etykieta}</ThemedText>
            {o.opis && (
              <ThemedText type="small" themeColor="textSecondary">
                {o.opis}
              </ThemedText>
            )}
          </Pressable>
        );
      })}
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.one },
  opcja: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
    gap: 2,
  },
  wcisnieta: { opacity: 0.7 },
});
