import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, useWindowDimensions, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/** Poniżej tej szerokości „Dodaj przepis” jest samą ikonką „+” — szukajka ma pierwszeństwo. */
const SZEROKOSC_Z_NAPISEM = 600;

/**
 * Przyciski w stałym nagłówku przepisów: „+ Dodaj przepis” (tylko dla
 * moderatora) i „⋯ Więcej”, które rozwija rzadziej używane akcje.
 *
 * Dawniej wszystkie trzy leżały pod listą — przy kilkuset przepisach nikt
 * do nich nie dojeżdżał. Nagłówek nie przewija się z listą, więc tu są
 * zawsze pod ręką.
 */
export function AkcjePrzepisow({
  mozeDodawac,
  onDodaj,
  wiecejOtwarte,
  onPrzelaczWiecej,
}: {
  mozeDodawac: boolean;
  onDodaj: () => void;
  wiecejOtwarte: boolean;
  onPrzelaczWiecej: () => void;
}) {
  const motyw = useTheme();
  const { t } = useTranslation();
  const { width } = useWindowDimensions();
  const zNapisem = width >= SZEROKOSC_Z_NAPISEM;

  return (
    <View style={styles.rzad}>
      {mozeDodawac && (
        <Pressable
          onPress={onDodaj}
          accessibilityRole="button"
          accessibilityLabel={t('przepisy.dodaj')}
          style={({ pressed }) => [
            styles.przycisk,
            { backgroundColor: motyw.accent, borderColor: motyw.accent },
            pressed && styles.wcisniety,
          ]}>
          <Ionicons name="add" size={20} color={motyw.onAccent} />
          {zNapisem && (
            <ThemedText type="smallBold" style={{ color: motyw.onAccent }}>
              {t('przepisy.dodaj')}
            </ThemedText>
          )}
        </Pressable>
      )}

      <Pressable
        onPress={onPrzelaczWiecej}
        accessibilityRole="button"
        accessibilityState={{ expanded: wiecejOtwarte }}
        accessibilityLabel={t('akcjePrzepisow.wiecej')}
        style={({ pressed }) => [
          styles.przycisk,
          wiecejOtwarte
            ? { backgroundColor: motyw.backgroundSelected, borderColor: motyw.accent }
            : { backgroundColor: motyw.background, borderColor: motyw.border },
          pressed && styles.wcisniety,
        ]}>
        <Ionicons name="ellipsis-horizontal" size={20} color={motyw.accent} />
      </Pressable>
    </View>
  );
}

/**
 * Rozwinięte „⋯ Więcej” — pod szukajką, w samym nagłówku, a nie jako
 * wyskakujące menu: nic nie zasłania listy i działa tak samo na telefonie
 * i w przeglądarce.
 */
export function PanelWiecejPrzepisow({
  mozeImportowac,
  onSkladniki,
  onImportEksport,
}: {
  mozeImportowac: boolean;
  onSkladniki: () => void;
  onImportEksport: () => void;
}) {
  const motyw = useTheme();
  const { t } = useTranslation();

  const pozycje = [
    { klucz: 'skladniki', ikona: 'nutrition-outline' as const, etykieta: t('menu.skladniki'), onPress: onSkladniki },
    ...(mozeImportowac
      ? [
          {
            klucz: 'import',
            ikona: 'swap-vertical-outline' as const,
            etykieta: t('przepisy.importEksport'),
            onPress: onImportEksport,
          },
        ]
      : []),
  ];

  return (
    <View style={styles.panel}>
      {pozycje.map((p) => (
        <Pressable
          key={p.klucz}
          onPress={p.onPress}
          accessibilityRole="button"
          style={({ pressed }) => [
            styles.pozycja,
            { backgroundColor: motyw.background, borderColor: motyw.border },
            pressed && styles.wcisniety,
          ]}>
          <Ionicons name={p.ikona} size={18} color={motyw.accent} />
          <ThemedText type="smallBold" style={{ color: motyw.accent }}>
            {p.etykieta}
          </ThemedText>
        </Pressable>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  rzad: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  przycisk: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 4,
    borderWidth: 1.5,
    borderRadius: Spacing.two,
    minHeight: 48,
    minWidth: 48,
    paddingHorizontal: Spacing.two,
  },
  panel: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
  },
  pozycja: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderWidth: 1,
    borderRadius: 999,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  wcisniety: { opacity: 0.7 },
});
