import { Ionicons } from '@expo/vector-icons';
import { StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/**
 * Nagłówek ekranu profilu — tytuł, adres konta i pigułka z rolą. Stały (patrz
 * `naglowekStaly` w `Ekran`), tak jak nagłówki innych ekranów z listą poniżej —
 * tożsamość konta zostaje na miejscu, gdy lista profili się przewija.
 */
export function NaglowekProfilu({
  email,
  rola,
}: {
  email?: string;
  rola: string | null;
}) {
  const motyw = useTheme();

  return (
    <ThemedView type="backgroundElement" style={[styles.karta, { borderColor: motyw.border }]}>
      <View style={styles.wiersz}>
        <ThemedText type="subtitle" numberOfLines={1}>
          Profil
        </ThemedText>

        {email && (
          <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
            {email}
          </ThemedText>
        )}

        <View style={[styles.rola, { backgroundColor: motyw.backgroundSelected }]}>
          <View style={[styles.rolaIkona, { backgroundColor: motyw.backgroundElement }]}>
            <Ionicons name="shield-checkmark-outline" size={15} color={motyw.accent} />
          </View>
          <ThemedText type="small" numberOfLines={1}>
            <ThemedText type="smallBold">Rola: </ThemedText>
            {rola ?? 'wczytywanie…'}
          </ThemedText>
        </View>
      </View>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  karta: {
    borderWidth: 1,
    borderRadius: Spacing.three,
    padding: Spacing.three,
  },
  wiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  rola: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderRadius: 999,
    paddingVertical: Spacing.half,
    paddingHorizontal: Spacing.two,
    marginLeft: 'auto',
  },
  rolaIkona: {
    width: 26,
    height: 26,
    borderRadius: 13,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
