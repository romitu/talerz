import { Ionicons } from '@expo/vector-icons';
import { Pressable, ScrollView, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export type OpcjaFiltra = {
  klucz: string;
  etykieta: string;
  /** Ile przepisów zostanie po zaznaczeniu — przy pozostałych filtrach bez zmian. */
  ile: number;
  wybrana: boolean;
  onPress: () => void;
};

export type GrupaFiltrow = {
  klucz: string;
  tytul: string;
  opcje: OpcjaFiltra[];
};

/**
 * Filtry listy przepisów: rodzaj dania, główne białko, szybkie przełączniki.
 *
 * Zwinięte domyślnie, bo nagłówek jest stały i na telefonie każda linijka
 * zabiera miejsce liście. Po zwinięciu widać tylko to, co jest włączone —
 * każdy aktywny filtr da się zdjąć jednym dotknięciem, bez rozwijania.
 *
 * Jak opcje się łączą, decyduje ekran — komponent tylko je pokazuje. Opcja
 * z zerem jest przygaszona i nieaktywna: zaznaczenie jej dałoby pustą listę
 * bez żadnej podpowiedzi dlaczego.
 */
export function FiltryPrzepisow({
  grupy,
  otwarte,
  onPrzelaczOtwarte,
  onWyczysc,
}: {
  grupy: GrupaFiltrow[];
  otwarte: boolean;
  onPrzelaczOtwarte: () => void;
  onWyczysc: () => void;
}) {
  const motyw = useTheme();
  const aktywne = grupy.flatMap((g) => g.opcje.filter((o) => o.wybrana));

  return (
    <View style={styles.calosc}>
      <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.rzad}>
        <Pressable
          onPress={onPrzelaczOtwarte}
          accessibilityRole="button"
          accessibilityState={{ expanded: otwarte }}
          accessibilityLabel={`Filtry${aktywne.length > 0 ? `, włączone: ${aktywne.length}` : ''}`}
          style={[
            styles.pigulka,
            aktywne.length > 0
              ? { backgroundColor: motyw.backgroundSelected, borderColor: motyw.accent }
              : { backgroundColor: motyw.background, borderColor: motyw.border },
          ]}>
          <Ionicons name="options-outline" size={16} color={motyw.accent} />
          <ThemedText type="smallBold" style={{ color: motyw.accent }}>
            Filtry{aktywne.length > 0 ? ` ${aktywne.length}` : ''}
          </ThemedText>
          <Ionicons name={otwarte ? 'chevron-up' : 'chevron-down'} size={14} color={motyw.accent} />
        </Pressable>

        {!otwarte &&
          aktywne.map((o) => (
            <Pressable
              key={o.klucz}
              onPress={o.onPress}
              accessibilityRole="button"
              accessibilityLabel={`Zdejmij filtr ${o.etykieta}`}
              style={[styles.pigulka, { backgroundColor: motyw.accent, borderColor: motyw.accent }]}>
              <ThemedText type="smallBold" style={styles.tekstWybrany} numberOfLines={1}>
                {o.etykieta}
              </ThemedText>
              <Ionicons name="close" size={14} color="#FFFFFF" />
            </Pressable>
          ))}

        {aktywne.length > 0 && (
          <Pressable
            onPress={onWyczysc}
            accessibilityRole="button"
            accessibilityLabel="Wyczyść wszystkie filtry"
            hitSlop={6}
            style={styles.wyczysc}>
            <ThemedText type="small" themeColor="textSecondary">
              Wyczyść
            </ThemedText>
          </Pressable>
        )}
      </ScrollView>

      {otwarte &&
        grupy.map((g) => (
          <View key={g.klucz} style={styles.grupa}>
            <ThemedText type="small" themeColor="textSecondary">
              {g.tytul}
            </ThemedText>
            <View style={styles.opcje}>
              {g.opcje.map((o) => {
                const pusta = o.ile === 0 && !o.wybrana;
                return (
                  <Pressable
                    key={o.klucz}
                    onPress={o.onPress}
                    disabled={pusta}
                    accessibilityRole="checkbox"
                    accessibilityState={{ checked: o.wybrana, disabled: pusta }}
                    accessibilityLabel={`${o.etykieta}, ${o.ile}`}
                    style={[
                      styles.pigulka,
                      o.wybrana
                        ? { backgroundColor: motyw.accent, borderColor: motyw.accent }
                        : { backgroundColor: motyw.background, borderColor: motyw.border },
                      pusta && styles.pusta,
                    ]}>
                    <ThemedText
                      type="smallBold"
                      style={o.wybrana ? styles.tekstWybrany : { color: motyw.textSecondary }}
                      numberOfLines={1}>
                      {o.etykieta} {o.ile}
                    </ThemedText>
                  </Pressable>
                );
              })}
            </View>
          </View>
        ))}
    </View>
  );
}

const styles = StyleSheet.create({
  calosc: {
    gap: Spacing.two,
  },
  rzad: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  grupa: {
    gap: Spacing.one,
  },
  /* W rozwiniętym panelu opcje się zawijają — tu ważniejsze jest widzieć wszystkie naraz. */
  opcje: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
  },
  pigulka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
    borderWidth: 1,
    borderRadius: 999,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  tekstWybrany: {
    color: '#FFFFFF',
  },
  pusta: {
    opacity: 0.4,
  },
  wyczysc: {
    paddingHorizontal: Spacing.one,
  },
});
