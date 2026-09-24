import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { Children, useEffect, useState, type ReactNode } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import type { ZrodloZdjecia } from '@/lib/zakupy';

/** Ile kafli w rzędzie — trzy mieszczą się czytelnie nawet na małym telefonie. */
const W_RZEDZIE = 3;
const ODSTEP = 3;

/** Siatka kafli po trzy w rzędzie. */
export function SiatkaKafli({ children }: { children: ReactNode }) {
  return (
    <View style={styles.siatka}>
      {Children.map(children, (dziecko) => (dziecko ? <View style={styles.komorka}>{dziecko}</View> : null))}
    </View>
  );
}

export const OPIS_ZRODLA: Record<ZrodloZdjecia, { tytul: string; opis: string }> = {
  ai: { tytul: 'Grafika AI', opis: 'Wygenerowana, poglądowa' },
  wlasne: { tytul: 'Zdjęcie własne', opis: 'Dodane przez użytkownika' },
};

/**
 * Znaczek pochodzenia zdjęcia w rogu kafla.
 *
 * Na stałe widać tylko ikonę („AI” albo obrazek) — pełny opis pokazuje
 * dymek po najechaniu myszką (przeglądarka) albo po dotknięciu (telefon).
 * Na telefonie dymek chowa się sam po chwili, bo nie ma „zjechania” palcem.
 */
export function ZnaczekZrodla({ zrodlo }: { zrodlo: ZrodloZdjecia }) {
  const [widoczny, setWidoczny] = useState(false);

  useEffect(() => {
    if (!widoczny) return;
    const t = setTimeout(() => setWidoczny(false), 2500);
    return () => clearTimeout(t);
  }, [widoczny]);

  const { tytul, opis } = OPIS_ZRODLA[zrodlo];

  return (
    <>
      {widoczny && (
        <View style={styles.dymek} pointerEvents="none">
          <ThemedText style={styles.dymekTytul}>{tytul}</ThemedText>
          <ThemedText style={styles.dymekOpis}>{opis}</ThemedText>
        </View>
      )}
      <Pressable
        onPress={() => setWidoczny((w) => !w)}
        onHoverIn={() => setWidoczny(true)}
        onHoverOut={() => setWidoczny(false)}
        hitSlop={10}
        accessibilityRole="button"
        accessibilityLabel={tytul}
        style={styles.znaczek}>
        {zrodlo === 'ai' ? (
          <ThemedText style={styles.znaczekTekst}>AI</ThemedText>
        ) : (
          <Ionicons name="image-outline" size={12} color="#4b514e" />
        )}
      </Pressable>
    </>
  );
}

type Props = {
  nazwa: string;
  /** Już sformatowana ilość, np. „250 g” albo „2 rolki”. Pusta = sama nazwa. */
  ilosc: string | null;
  /** Publiczny adres zdjęcia albo null — wtedy szare pole „Brak zdjęcia”. */
  zdjecie: string | null;
  zrodlo: ZrodloZdjecia | null;
  zaznaczona: boolean;
  /** Brak = kafel tylko do oglądania (np. zrealizowane w poprzedniej sesji). */
  onPress?: () => void;
  /** Krzyżyk w podpisie — tylko produkty dopisane ręcznie. */
  onUsun?: () => void;
};

/** Pozycja listy zakupów jako kafel ze zdjęciem. Podpis taki sam jak na liście: „nazwa — ilość”. */
export function KafelZakupu({ nazwa, ilosc, zdjecie, zrodlo, zaznaczona, onPress, onUsun }: Props) {
  const motyw = useTheme();
  const podpis = ilosc ? `${nazwa} — ${ilosc}` : nazwa;
  const wyciszony = zaznaczona ? styles.wyciszony : null;

  return (
    <Pressable
      onPress={onPress}
      disabled={!onPress}
      accessibilityRole="checkbox"
      accessibilityState={{ checked: zaznaczona, disabled: !onPress }}
      accessibilityLabel={`Kupione: ${podpis}`}
      style={({ pressed }) => [
        styles.kafel,
        {
          backgroundColor: motyw.backgroundSelected,
          borderColor: zaznaczona ? motyw.accent : 'transparent',
        },
        pressed && styles.wcisniety,
      ]}>
      <View style={styles.zdjecie}>
        {zdjecie ? (
          <Image
            source={{ uri: zdjecie }}
            style={[StyleSheet.absoluteFill, wyciszony]}
            contentFit="cover"
            transition={150}
            accessibilityIgnoresInvertColors
          />
        ) : (
          <View style={[styles.brak, wyciszony]}>
            <Ionicons name="image-outline" size={26} color="#8a96a3" />
            <ThemedText style={styles.brakTekst}>Brak zdjęcia</ThemedText>
          </View>
        )}

        <View style={styles.pole} pointerEvents="none">
          <Ionicons
            name={zaznaczona ? 'checkbox' : 'square-outline'}
            size={20}
            color={zaznaczona ? motyw.accent : '#52667a'}
          />
        </View>

        {zdjecie && zrodlo && <ZnaczekZrodla zrodlo={zrodlo} />}
      </View>

      <View style={styles.podpis}>
        <ThemedText type="smallBold" themeColor={zaznaczona ? 'textSecondary' : undefined} style={styles.podpisTekst}>
          {nazwa}
          {ilosc ? ' — ' : ''}
          {ilosc ? (
            <ThemedText type="smallBold" themeColor={zaznaczona ? 'textSecondary' : 'accent'}>
              {ilosc}
            </ThemedText>
          ) : null}
        </ThemedText>
        {onUsun && (
          <Pressable
            onPress={onUsun}
            hitSlop={8}
            accessibilityRole="button"
            accessibilityLabel={`Usuń ${nazwa} z listy`}>
            <Ionicons name="close" size={16} color={motyw.textSecondary} />
          </Pressable>
        )}
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  siatka: { flexDirection: 'row', flexWrap: 'wrap', margin: -ODSTEP / 2 },
  komorka: { width: `${100 / W_RZEDZIE}%`, padding: ODSTEP / 2 },
  kafel: {
    flex: 1,
    borderRadius: Spacing.two,
    borderWidth: 2,
    overflow: 'hidden',
  },
  wcisniety: { opacity: 0.8 },
  zdjecie: { aspectRatio: 1, backgroundColor: '#ffffff' },
  wyciszony: { opacity: 0.5 },
  brak: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    gap: 4,
    backgroundColor: '#eef1f5',
  },
  brakTekst: { fontSize: 11, lineHeight: 14, color: '#8a96a3' },
  pole: {
    position: 'absolute',
    top: 6,
    right: 6,
    backgroundColor: '#ffffff',
    borderRadius: 4,
  },
  znaczek: {
    position: 'absolute',
    left: 6,
    bottom: 6,
    minWidth: 24,
    height: 20,
    paddingHorizontal: 5,
    borderRadius: 4,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(255,255,255,0.75)',
  },
  znaczekTekst: { fontSize: 11, lineHeight: 14, fontWeight: '500', color: '#4b514e' },
  dymek: {
    position: 'absolute',
    left: 6,
    right: 6,
    bottom: 32,
    padding: 6,
    borderRadius: 6,
    backgroundColor: '#ffffff',
    boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
  },
  dymekTytul: { fontSize: 12, lineHeight: 15, fontWeight: '600', color: '#203047' },
  dymekOpis: { fontSize: 10, lineHeight: 13, color: '#596675' },
  podpis: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: 4,
    paddingHorizontal: Spacing.two,
    paddingVertical: 6,
  },
  podpisTekst: { flex: 1 },
});
