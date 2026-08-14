import type { ReactNode } from 'react';
import { StyleSheet, useWindowDimensions, View } from 'react-native';

import { Spacing } from '@/constants/theme';

/** Od tej szerokości ekranu układ dzieli się na dwie kolumny. */
export const PROG_DWOCH_KOLUMN = 1100;

type KolumnyProps = {
  lewa: ReactNode;
  prawa: ReactNode;
  /** Proporcja szerokości lewej kolumny do prawej. */
  proporcja?: [number, number];
};

/**
 * Układ dwukolumnowy na szerokich ekranach, jednokolumnowy na wąskich.
 *
 * Długi formularz na monitorze zmusza do ciągłego przewijania, a połowa
 * ekranu stoi pusta. Na telefonie odwrotnie — dwie kolumny byłyby nieczytelne.
 * Dlatego układ zmienia się wraz z szerokością okna, a nie z rodzajem urządzenia:
 * liczy się to, ile miejsca jest naprawdę.
 */
export function Kolumny({ lewa, prawa, proporcja = [1, 1] }: KolumnyProps) {
  const { width } = useWindowDimensions();
  const dwieKolumny = width >= PROG_DWOCH_KOLUMN;

  if (!dwieKolumny) {
    return (
      <View style={styles.jedna}>
        {lewa}
        {prawa}
      </View>
    );
  }

  return (
    <View style={styles.dwie}>
      <View style={[styles.kolumna, { flex: proporcja[0] }]}>{lewa}</View>
      <View style={[styles.kolumna, { flex: proporcja[1] }]}>{prawa}</View>
    </View>
  );
}

const styles = StyleSheet.create({
  jedna: { gap: Spacing.three },
  dwie: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.three,
  },
  kolumna: { gap: Spacing.three },
});
