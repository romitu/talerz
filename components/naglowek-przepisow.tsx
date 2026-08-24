import { Ionicons } from '@expo/vector-icons';
import { Pressable, StyleSheet, TextInput, View } from 'react-native';

import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export type ZakladkaPrzepisow = {
  klucz: string;
  etykieta: string;
  ile: number;
  wybrana: boolean;
  /** Zakładka kolejki moderatora — tekst akcentem nawet gdy nieaktywna. */
  akcent?: boolean;
  onPress: () => void;
};

/**
 * Nagłówek ekranu przepisów — ikona, tytuł z licznikiem, szukajka i zakładki
 * kategorii. Stały (patrz `naglowekStaly` w `Ekran`), więc szukanie i filtry
 * zostają pod ręką, nawet gdy lista przepisów jest długa i przewija się.
 */
export function NaglowekPrzepisow({
  liczbaWBazie,
  wczytywanie,
  fraza,
  onZmianaFrazy,
  zakladki,
}: {
  liczbaWBazie: number;
  wczytywanie: boolean;
  fraza: string;
  onZmianaFrazy: (tekst: string) => void;
  zakladki: ZakladkaPrzepisow[];
}) {
  const motyw = useTheme();

  return (
    <ThemedView type="backgroundElement" style={[styles.karta, { borderColor: motyw.border }]}>
      <View style={styles.gorny}>
        <View style={[styles.ikonaKolo, { backgroundColor: motyw.backgroundSelected }]}>
          <Ionicons name="book-outline" size={26} color={motyw.accent} />
        </View>

        <View style={styles.tytulOpis}>
          <ThemedText type="subtitle" numberOfLines={1}>
            Przepisy
          </ThemedText>
          <View style={[styles.licznikPigulka, { backgroundColor: motyw.backgroundSelected }]}>
            <ThemedText type="smallBold" themeColor="accent" numberOfLines={1}>
              {wczytywanie ? 'wczytywanie…' : `${liczbaWBazie} w bazie`}
            </ThemedText>
          </View>
        </View>
      </View>

      {liczbaWBazie > 0 && (
        <View
          style={[styles.szukajka, { borderColor: motyw.accent, backgroundColor: motyw.background }]}>
          <Ionicons name="search" size={20} color={motyw.textSecondary} />
          <TextInput
            value={fraza}
            onChangeText={onZmianaFrazy}
            placeholder="Szukaj przepisu…"
            placeholderTextColor={motyw.textSecondary}
            autoCorrect={false}
            autoCapitalize="none"
            clearButtonMode="while-editing"
            style={[styles.wejscie, { color: motyw.text }]}
          />
          {fraza.length > 0 && (
            <Pressable
              onPress={() => onZmianaFrazy('')}
              hitSlop={8}
              accessibilityRole="button"
              accessibilityLabel="Wyczyść szukanie">
              <Ionicons name="close-circle" size={20} color={motyw.textSecondary} />
            </Pressable>
          )}
        </View>
      )}

      {zakladki.length > 0 && (
        <View style={styles.zakladki}>
          {zakladki.map((z) => (
            <Pressable
              key={z.klucz}
              onPress={z.onPress}
              accessibilityRole="button"
              accessibilityState={{ selected: z.wybrana }}
              accessibilityLabel={`${z.etykieta}, ${z.ile}`}
              style={[
                styles.zakladka,
                z.wybrana
                  ? { backgroundColor: motyw.accent, borderColor: motyw.accent }
                  : { backgroundColor: motyw.background, borderColor: motyw.border },
              ]}>
              <ThemedText
                type="smallBold"
                style={{ color: z.wybrana ? '#FFFFFF' : z.akcent ? motyw.accent : motyw.textSecondary }}
                numberOfLines={1}>
                {z.etykieta} {z.ile}
              </ThemedText>
            </Pressable>
          ))}
        </View>
      )}
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  karta: {
    borderWidth: 1,
    borderRadius: Spacing.three,
    padding: Spacing.three,
    gap: Spacing.two,
  },
  gorny: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  ikonaKolo: {
    width: 52,
    height: 52,
    borderRadius: 26,
    alignItems: 'center',
    justifyContent: 'center',
  },
  tytulOpis: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  licznikPigulka: {
    borderRadius: 999,
    paddingHorizontal: Spacing.two,
    paddingVertical: Spacing.half,
  },
  szukajka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderWidth: 1.5,
    borderRadius: Spacing.two,
    paddingHorizontal: Spacing.two,
    minHeight: 48,
  },
  wejscie: {
    flex: 1,
    fontSize: 16,
    paddingVertical: Spacing.one,
  },
  zakladki: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
  },
  zakladka: {
    borderWidth: 1,
    borderRadius: 999,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
});
