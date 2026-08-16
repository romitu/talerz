import { StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';

export type PozycjaMakro = {
  etykieta: string;
  wartosc: number;
  /** Dopisek za liczbą: „ g”, „%”, albo nic przy kaloriach. */
  jednostka: string;
  /** Cel dzienny, jeśli jest do czego porównywać. */
  cel?: number;
};

/**
 * Rząd wartości odżywczych — zawsze w JEDNEJ linii.
 *
 * Dlaczego nie zwykły `flexWrap`
 * ------------------------------
 * Poprzednia wersja układała kolumny przez `flex: 1` z `minWidth: 70`
 * i pozwalała im się zawijać. Na komputerze wyglądało to dobrze, na telefonie
 * Romana (Samsung S24) czwarta wartość — „54 g węglow.” — spadała do drugiej
 * linii i wyglądała jak osobna informacja, choć jest częścią tego samego
 * zestawu.
 *
 * Winowajcą nie była szerokość ekranu, tylko POWIĘKSZONA CZCIONKA SYSTEMOWA.
 * `minWidth: 70` jest w punktach i się nie skaluje, ale zmierzona szerokość
 * napisu „tłuszcz” już tak — więc przy większym ustawieniu czcionki kolumna
 * puchła ponad siedemdziesiąt punktów i cztery przestawały się mieścić.
 * Ustawienie czcionki jest cechą użytkownika, nie usterką, i układ musi je
 * przyjąć.
 *
 * Dlatego szerokość kolumny jest UŁAMKIEM rzędu: cztery wartości to po 25%,
 * pięć po 20%. Suma zawsze wynosi sto procent, więc zawijanie nie ma jak
 * nastąpić — niezależnie od czcionki, języka i szerokości ekranu.
 *
 * Ceną jest to, że przy bardzo dużej czcionce liczba może się urwać. To i tak
 * lepsze niż rząd rozsypany na dwie linie: urwanie widać od razu i wiadomo,
 * że trzeba spojrzeć gdzie indziej, a rozsypany rząd po prostu wprowadza w błąd.
 */
export function WierszMakro({ pozycje }: { pozycje: PozycjaMakro[] }) {
  if (pozycje.length === 0) return null;

  const szerokosc = `${100 / pozycje.length}%` as const;

  return (
    <View style={styles.rzad}>
      {pozycje.map((p) => (
        <View key={p.etykieta} style={[styles.kolumna, { width: szerokosc }]}>
          <ThemedText type="smallBold" numberOfLines={1}>
            {p.wartosc}
            {p.jednostka}
          </ThemedText>

          {/*
            Cel w osobnej linii, nie po ukośniku przy wartości. „1936 / 2048”
            to jedenaście znaków — w kolumnie szerokiej na jedną piątą ekranu
            telefonu nie ma na to miejsca.
          */}
          {p.cel !== undefined && (
            <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
              z {p.cel}
              {p.jednostka}
            </ThemedText>
          )}

          <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
            {p.etykieta}
          </ThemedText>
        </View>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  rzad: {
    flexDirection: 'row',
    paddingTop: Spacing.half,
  },
  kolumna: {
    // Odstęp robimy wewnętrznym marginesem, a nie `gap` — `gap` doliczyłby się
    // do stu procent zajmowanych przez kolumny i rząd znów by się zawinął.
    paddingRight: Spacing.two,
    minWidth: 0,
    gap: Spacing.half,
  },
});
