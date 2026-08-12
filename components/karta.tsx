import type { ReactNode } from 'react';
import { StyleSheet, type ViewStyle } from 'react-native';

import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';

/** Biały (lub ciemny) prostokąt z zaokrąglonymi rogami — podstawowy klocek interfejsu. */
export function Karta({ children, style }: { children: ReactNode; style?: ViewStyle }) {
  return (
    <ThemedView type="backgroundElement" style={[styles.karta, style]}>
      {children}
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  karta: {
    borderRadius: Spacing.three,
    padding: Spacing.three,
    gap: Spacing.two,
  },
});
