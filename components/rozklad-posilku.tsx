import { Ionicons } from '@expo/vector-icons';
import { StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { ThemedText } from './themed-text';

import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export type UdzialOsoby = {
  id: string;
  imie: string;
  /** Ułamek 0–1, wszystkie `udzial` w tablicy sumują się do 1. */
  udzial: number;
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number;
};

/** Ten sam zestaw ikon i kolorów co kafle wyniku na ekranie Profilu — jedna wizualna mowa dla „ile kto ma zjeść". */
const MAKRA: { klucz: keyof Pick<UdzialOsoby, 'bialko_g' | 'tluszcz_g' | 'wegle_g' | 'blonnik_g'>; skrot: string; ikona: keyof typeof Ionicons.glyphMap; kolor: string }[] = [
  { klucz: 'bialko_g', skrot: 'B', ikona: 'nutrition-outline', kolor: KOLOR_MAKRO.bialko },
  { klucz: 'tluszcz_g', skrot: 'T', ikona: 'water-outline', kolor: KOLOR_MAKRO.tluszcz },
  { klucz: 'wegle_g', skrot: 'W', ikona: 'leaf-outline', kolor: KOLOR_MAKRO.wegle },
  { klucz: 'blonnik_g', skrot: 'Bł', ikona: 'flower-outline', kolor: KOLOR_MAKRO.blonnik },
];

/**
 * Ile z TEGO posiłku powinna zjeść każda osoba — proporcjonalnie do jej
 * dziennego zapotrzebowania (patrz `app/przepis.tsx`), nie po równo. Ten sam
 * garnek dzieli się inaczej między dorosłego o wysokim zapotrzebowaniu
 * a dziecko, nawet gdy oboje dostają „jedną porcję" w planie.
 *
 * Macierz małych kafelków w dwóch kolumnach, nie osobna pełna karta na
 * osobę — to informacja pomocnicza nad przepisem, nie główna treść ekranu,
 * więc nie powinna zajmować tyle miejsca co składniki i kroki niżej.
 */
export function RozkladPosilku({ osoby }: { osoby: UdzialOsoby[] }) {
  const motyw = useTheme();

  // Cztery odcienie tego samego akcentu — działa w każdym z trzech stylów
  // i obu trybach, bez trzymania osobnej palety kolorów na sztywno.
  const koloryOsob = [motyw.accent, `${motyw.accent}BB`, `${motyw.accent}80`, `${motyw.accent}50`];

  return (
    <Karta>
      <View style={styles.naglowek}>
        <Ionicons name="people-outline" size={15} color={motyw.textSecondary} />
        <ThemedText type="smallBold" themeColor="textSecondary">
          ROZKŁAD NA OSOBY
        </ThemedText>
      </View>

      <View style={styles.siatka}>
        {osoby.map((o, i) => (
          <View key={o.id} style={[styles.kafelek, { borderColor: motyw.border, backgroundColor: motyw.background }]}>
            <View style={styles.wiersz}>
              <View style={[styles.kropka, { backgroundColor: koloryOsob[i % koloryOsob.length] }]} />
              <ThemedText type="smallBold" numberOfLines={1} style={styles.imie}>
                {o.imie}
              </ThemedText>
              <ThemedText type="small" themeColor="accent">
                {Math.round(o.udzial * 100)}%
              </ThemedText>
            </View>

            <View style={styles.wiersz}>
              <Ionicons name="flame-outline" size={12} color={motyw.accent} />
              <ThemedText type="small">{o.kcal} kcal</ThemedText>
            </View>

            <View style={styles.makra}>
              {MAKRA.map((m) => (
                <View key={m.klucz} style={styles.makroPozycja}>
                  <Ionicons name={m.ikona} size={11} color={m.kolor} />
                  <ThemedText type="small" themeColor="textSecondary">
                    {o[m.klucz]}g
                  </ThemedText>
                </View>
              ))}
            </View>
          </View>
        ))}
      </View>

      <View style={[styles.pasek, { backgroundColor: motyw.background }]}>
        {osoby.map((o, i) => (
          <View
            key={o.id}
            style={{ flex: Math.max(o.udzial, 0.01), backgroundColor: koloryOsob[i % koloryOsob.length] }}
          />
        ))}
      </View>
    </Karta>
  );
}

const styles = StyleSheet.create({
  naglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  siatka: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  kafelek: {
    flexBasis: '47%',
    flexGrow: 1,
    borderWidth: StyleSheet.hairlineWidth,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.half,
  },
  wiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  imie: {
    flex: 1,
  },
  kropka: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  makra: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  makroPozycja: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 3,
  },
  pasek: {
    flexDirection: 'row',
    height: 10,
    borderRadius: 5,
    overflow: 'hidden',
  },
});
