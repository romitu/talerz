import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { JEZYKI, ustawJezyk } from '@/lib/jezyk';

/**
 * Wybór języka w profilu. Przy jednym języku nie ma czego wybierać,
 * więc karta się nie pokazuje — pojawi się sama po dodaniu drugiego.
 */
export function WyborJezyka() {
  const { t, i18n } = useTranslation();
  const motyw = useTheme();

  if (JEZYKI.length < 2) return null;

  return (
    <Karta>
      <View style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('jezyk.naglowek')}
        </ThemedText>

        {JEZYKI.map((j) => {
          const wybrany = j.kod === i18n.language;
          return (
            <Pressable
              key={j.kod}
              onPress={() => ustawJezyk(j.kod)}
              accessibilityRole="radio"
              accessibilityState={{ selected: wybrany }}
              style={({ pressed }) => [
                styles.pozycja,
                {
                  borderColor: wybrany ? motyw.accent : motyw.border,
                  borderWidth: wybrany ? 2 : 1,
                  backgroundColor: wybrany ? motyw.backgroundSelected : motyw.backgroundElement,
                },
                pressed && styles.wcisniete,
              ]}>
              <ThemedText type="default" themeColor={wybrany ? 'accent' : 'text'} style={styles.nazwa}>
                {j.nazwa}
              </ThemedText>
              {wybrany && <Ionicons name="checkmark-circle" size={22} color={motyw.accent} />}
            </Pressable>
          );
        })}
      </View>
    </Karta>
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
  nazwa: { flex: 1 },
  wcisniete: { opacity: 0.7 },
});
