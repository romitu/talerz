import type { ReactNode } from 'react';
import { StyleSheet, type ViewProps, type ViewStyle } from 'react-native';

import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/**
 * Biały (lub ciemny) prostokąt z zaokrąglonymi rogami — podstawowy klocek interfejsu.
 *
 * Cienka ramka w kolorze linii, jak karty na stronie mojtalerz.com: na
 * jasnym papierze biała karta bez ramki ledwo odcina się od tła.
 * Własny `borderColor`/`borderWidth` w `style` (np. wyróżnienie nowego
 * konta) dalej wygrywa, bo `style` jest nakładany na końcu.
 */
export function Karta({
  children,
  style,
  onLayout,
}: {
  children: ReactNode;
  style?: ViewStyle;
  onLayout?: ViewProps['onLayout'];
}) {
  const motyw = useTheme();

  return (
    <ThemedView
      type="backgroundElement"
      style={[styles.karta, { borderColor: motyw.border }, style]}
      onLayout={onLayout}>
      {children}
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  karta: {
    borderRadius: 12,
    borderWidth: 1,
    padding: Spacing.three,
    gap: Spacing.two,
  },
});
