import { useEffect, useState } from 'react';
import { StyleSheet, TextInput, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type KomorkaProps = {
  wartosc: string;
  szerokosc: number;
  /** Zamiast stałej szerokości kolumna zabiera wolne miejsce. */
  elastycznaSzerokosc?: boolean;
  edytowalna: boolean;
  liczba?: boolean;
  /** Wywoływane po opuszczeniu komórki, tylko gdy wartość faktycznie się zmieniła. */
  onZapisz: (nowa: string) => void;
};

/**
 * Komórka tabeli, którą można edytować na miejscu.
 *
 * Zapis następuje po opuszczeniu pola albo po naciśnięciu Enter — tak jak
 * w arkuszu kalkulacyjnym. Gdy wartość się nie zmieniła, nic nie jest wysyłane
 * do bazy.
 */
export function KomorkaEdytowalna({
  wartosc,
  szerokosc,
  elastycznaSzerokosc = false,
  edytowalna,
  liczba = false,
  onZapisz,
}: KomorkaProps) {
  const motyw = useTheme();
  const wymiar = elastycznaSzerokosc ? { flex: 1, minWidth: 200 } : { width: szerokosc };
  const [tekst, setTekst] = useState(wartosc);
  const [aktywna, setAktywna] = useState(false);

  // Wartość z zewnątrz ma pierwszeństwo, dopóki nie piszemy w tej komórce.
  useEffect(() => {
    if (!aktywna) setTekst(wartosc);
  }, [wartosc, aktywna]);

  if (!edytowalna) {
    return (
      <View style={[styles.komorka, wymiar]}>
        <ThemedText type="small" style={liczba ? styles.doPrawej : undefined} numberOfLines={2}>
          {wartosc}
        </ThemedText>
      </View>
    );
  }

  function zakoncz() {
    setAktywna(false);
    if (tekst !== wartosc) onZapisz(tekst);
  }

  return (
    <View style={[styles.komorka, wymiar]}>
      <TextInput
        value={tekst}
        onChangeText={setTekst}
        onFocus={() => setAktywna(true)}
        onBlur={zakoncz}
        onSubmitEditing={zakoncz}
        selectTextOnFocus
        inputMode={liczba ? 'decimal' : 'text'}
        style={[
          styles.pole,
          liczba && styles.doPrawej,
          {
            color: motyw.text,
            borderColor: aktywna ? motyw.accent : motyw.border,
            backgroundColor: aktywna ? motyw.backgroundSelected : 'transparent',
          },
        ]}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  komorka: {
    paddingHorizontal: Spacing.one,
    paddingVertical: Spacing.one,
    justifyContent: 'center',
  },
  pole: {
    borderWidth: 1,
    borderRadius: Spacing.one,
    paddingHorizontal: Spacing.one,
    paddingVertical: 2,
    fontSize: 14,
    minHeight: 30,
  },
  doPrawej: { textAlign: 'right' },
});
