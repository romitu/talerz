import { Ionicons } from '@expo/vector-icons';
import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, StyleSheet, TextInput, View } from 'react-native';

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
 * Nagłówek ekranu przepisów — szukajka z przyciskiem Filtry na początku,
 * zakładki (dziś tylko kolejka moderatora) i pod nimi panel filtrów
 * (`FiltryPrzepisow`).
 * Stały (patrz `naglowekStaly` w `Ekran`), więc szukanie i filtry zostają
 * pod ręką, nawet gdy lista przepisów jest długa i przewija się.
 */
export function NaglowekPrzepisow({
  liczbaWBazie,
  fraza,
  onZmianaFrazy,
  zakladki,
  przyciskFiltrow,
  filtry,
}: {
  liczbaWBazie: number;
  fraza: string;
  onZmianaFrazy: (tekst: string) => void;
  zakladki: ZakladkaPrzepisow[];
  /** Pigułka „Filtry” w szukajce — tam, gdzie dawniej stała ikona książki. */
  przyciskFiltrow?: ReactNode;
  filtry?: ReactNode;
}) {
  const motyw = useTheme();
  const { t } = useTranslation();

  return (
    <ThemedView type="backgroundElement" style={[styles.karta, { borderColor: motyw.border }]}>
      {liczbaWBazie > 0 && (
        <View
          style={[styles.szukajka, { borderColor: motyw.accent, backgroundColor: motyw.background }]}>
          {przyciskFiltrow}
          <Ionicons name="search" size={20} color={motyw.textSecondary} />
          <TextInput
            value={fraza}
            onChangeText={onZmianaFrazy}
            placeholder={t('naglowekPrzepisow.szukaj')}
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
              accessibilityLabel={t('naglowekPrzepisow.wyczysc')}>
              <Ionicons name="close-circle" size={20} color={motyw.textSecondary} />
            </Pressable>
          )}
        </View>
      )}

      {zakladki.length > 0 && (
        <ScrollView
          horizontal
          showsHorizontalScrollIndicator={false}
          contentContainerStyle={styles.zakladki}>
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
        </ScrollView>
      )}

      {filtry}
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
  /*
    Jeden wiersz, bez zawijania — na wąskim telefonie i tak by się nie
    zmieściło (pięć zakładek plus ewentualna kolejka moderatora), więc
    zamiast łamać się na dwie linie, rząd przewija się w bok.
  */
  zakladki: {
    flexDirection: 'row',
    gap: Spacing.one,
  },
  zakladka: {
    borderWidth: 1,
    borderRadius: 999,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
});
