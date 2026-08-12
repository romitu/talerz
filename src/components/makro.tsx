import { StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';

/** Pojedyncza liczba z podpisem, np. „142 g / białko”. */
export function Makro({
  etykieta,
  wartosc,
  jednostka,
  cel,
}: {
  etykieta: string;
  wartosc: number;
  jednostka: string;
  cel?: number;
}) {
  return (
    <View style={styles.kolumna}>
      <ThemedText type="smallBold">
        {wartosc}
        {jednostka}
        {cel !== undefined ? (
          <ThemedText type="small" themeColor="textSecondary">
            {' / '}
            {cel}
            {jednostka}
          </ThemedText>
        ) : null}
      </ThemedText>
      <ThemedText type="small" themeColor="textSecondary">
        {etykieta}
      </ThemedText>
    </View>
  );
}

const styles = StyleSheet.create({
  kolumna: {
    gap: Spacing.half,
    flex: 1,
    minWidth: 70,
  },
});
