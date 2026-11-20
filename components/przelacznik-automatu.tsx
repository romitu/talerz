import { Ionicons } from '@expo/vector-icons';
import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/**
 * Checkbox z opisem i ikoną w kółku — ustawienia rozkładania dań, np.
 * „Uwzględnij ile dni wytrzyma w lodówce”. Wspólny dla Planu
 * (`app/index.tsx`) i edytora schematów (`app/schematy.tsx`), żeby oba
 * miejsca wyglądały i działały tak samo.
 */
export function PrzelacznikAutomatu({
  zaznaczone,
  onZmiana,
  etykieta,
  opis,
  ikona,
}: {
  zaznaczone: boolean;
  onZmiana: (wartosc: boolean) => void;
  etykieta: string;
  opis: string;
  /** Ikona po prawej, w kółku — jak w karcie „Układanie tygodnia". */
  ikona: keyof typeof Ionicons.glyphMap;
}) {
  const motyw = useTheme();
  return (
    <Pressable
      onPress={() => onZmiana(!zaznaczone)}
      accessibilityRole="checkbox"
      accessibilityState={{ checked: zaznaczone }}
      style={({ pressed }) => [styles.wiersz, pressed && styles.wcisniete]}>
      <Ionicons
        name={zaznaczone ? 'checkbox' : 'square-outline'}
        size={20}
        color={zaznaczone ? motyw.accent : motyw.textSecondary}
      />
      <View style={styles.tresc}>
        <ThemedText type="small" themeColor={zaznaczone ? 'accent' : 'text'}>
          {etykieta}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {opis}
        </ThemedText>
      </View>
      <View style={[styles.ikonaKolo, { backgroundColor: motyw.backgroundSelected }]}>
        <Ionicons name={ikona} size={16} color={motyw.accent} />
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  wiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    paddingVertical: Spacing.one,
  },
  tresc: { flex: 1, gap: 2 },
  ikonaKolo: {
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: 'center',
    justifyContent: 'center',
  },
  wcisniete: { opacity: 0.6 },
});
