import { Ionicons } from '@expo/vector-icons';
import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { OPIS_STYLU, PALETY, Spacing, STYLE } from '@/constants/theme';
import { useColorScheme } from '@/hooks/use-color-scheme';
import { useTheme } from '@/hooks/use-theme';
import { useStyl } from '@/lib/wyglad';

/**
 * Wybór stylu aplikacji.
 *
 * Każda pozycja pokazuje PRAWDZIWE kolory swojego stylu, a nie tylko nazwę.
 * Cztery kropki: tło, akcent, obramowanie i tekst pomocniczy — dokładnie te
 * cztery rzeczy, które odróżniają style od siebie na ekranie.
 *
 * Podgląd bierze się z tej samej wersji (jasnej albo ciemnej), którą ma teraz
 * system. Inaczej wieczorem wybierałbyś kolory, których i tak nie zobaczysz.
 */
export function WyborStylu() {
  const { styl, ustawStyl } = useStyl();
  const motyw = useTheme();
  const schemat = useColorScheme();
  const tryb = schemat === 'dark' ? 'dark' : 'light';

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        WYGLĄD
      </ThemedText>

      {STYLE.map((s) => {
        const wybrany = s === styl;
        const paleta = PALETY[s][tryb];
        return (
          <Pressable
            key={s}
            onPress={() => ustawStyl(s)}
            accessibilityRole="radio"
            accessibilityState={{ selected: wybrany }}
            accessibilityLabel={`${OPIS_STYLU[s].nazwa}. ${OPIS_STYLU[s].opis}`}
            style={({ pressed }) => [
              styles.pozycja,
              {
                borderColor: wybrany ? motyw.accent : motyw.border,
                borderWidth: wybrany ? 2 : 1,
                backgroundColor: wybrany ? motyw.backgroundSelected : motyw.backgroundElement,
              },
              pressed && styles.wcisniete,
            ]}>
            <View style={styles.podglad}>
              {[paleta.background, paleta.accent, paleta.border, paleta.textSecondary].map(
                (kolor, i) => (
                  <View
                    key={i}
                    style={[styles.kropka, { backgroundColor: kolor, borderColor: paleta.text }]}
                  />
                )
              )}
            </View>

            <View style={styles.opis}>
              <ThemedText type="default" themeColor={wybrany ? 'accent' : 'text'}>
                {OPIS_STYLU[s].nazwa}
              </ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                {OPIS_STYLU[s].opis}
              </ThemedText>
            </View>

            {wybrany && <Ionicons name="checkmark-circle" size={22} color={motyw.accent} />}
          </Pressable>
        );
      })}

      <ThemedText type="small" themeColor="textSecondary">
        Jasny czy ciemny wybiera system — styl działa w obu. Ustawienie jest
        zapamiętane na tym urządzeniu, więc na telefonie możesz mieć inne
        niż na komputerze.
      </ThemedText>
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.two },
  pozycja: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
    borderRadius: Spacing.two,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
  },
  podglad: { flexDirection: 'row', gap: 2 },
  kropka: {
    width: 14,
    height: 22,
    borderWidth: 1,
    borderRadius: 2,
  },
  opis: { flex: 1, gap: 2 },
  wcisniete: { opacity: 0.7 },
});
