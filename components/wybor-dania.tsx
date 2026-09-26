import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Pole } from './pole';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import type { PrzepisZMakro } from '@/lib/przepisy';
import { adresZdjecia } from '@/lib/zdjecia';

/** Kafel nie węższy niż tyle — niżej nazwa dania łamie się na trzy linijki. */
const MIN_KAFLA = 150;
const ODSTEP = 6;

/**
 * Wybór dania do planu jako kafle ze zdjęciami albo wiersze z miniaturką.
 * Widok „Lista” to nadal `TabelaWyboru` na ekranie planu — tylko ona sortuje
 * po kolumnach; tu kolejność jest ta sama, w jakiej przychodzą przepisy.
 *
 * Dotknięcie od razu wstawia danie — bez zaznaczania i zatwierdzania,
 * tak samo jak znak plus w tabeli.
 */
export function WyborDania({
  dania,
  kafle,
  onWybierz,
}: {
  dania: PrzepisZMakro[];
  /** `true` — kafle; `false` — wiersze z miniaturką. */
  kafle: boolean;
  onWybierz: (danie: PrzepisZMakro) => void;
}) {
  const [fraza, setFraza] = useState('');
  const [szerokosc, setSzerokosc] = useState(0);

  const f = fraza.trim().toLowerCase();
  const widoczne = f ? dania.filter((p) => p.nazwa.toLowerCase().includes(f)) : dania;

  // Ile kafli w rzędzie, z faktycznej szerokości karty: na telefonie dwa,
  // na komputerze tyle, ile się zmieści, zamiast trzech ogromnych zdjęć.
  const wRzedzie = Math.max(2, Math.floor((szerokosc + ODSTEP) / (MIN_KAFLA + ODSTEP)));

  // Mierzony jest zewnętrzny pojemnik, obecny w obu widokach. Pomiar na samej
  // siatce nie działał w przeglądarce: po przełączeniu z wierszy React
  // używa ponownie tego samego `View`, a react-native-web zaczyna śledzić
  // rozmiar tylko elementu, który miał `onLayout` od chwili zamontowania —
  // szerokość nigdy nie przychodziła i kafle się nie pokazywały.
  return (
    <View style={styles.calosc} onLayout={(e) => setSzerokosc(e.nativeEvent.layout.width)}>
      <Pole
        etykieta="Filtruj przepisy"
        value={fraza}
        onChangeText={setFraza}
        placeholder="zupa, dorsz, owsianka…"
      />

      {kafle ? (
        <View style={styles.siatka}>
          {szerokosc > 0 &&
            widoczne.map((p) => (
              <View key={p.id} style={[styles.komorka, { width: `${100 / wRzedzie}%` }]}>
                <KafelDania danie={p} onPress={() => onWybierz(p)} />
              </View>
            ))}
        </View>
      ) : (
        <View>
          {widoczne.map((p) => (
            <WierszDania key={p.id} danie={p} onPress={() => onWybierz(p)} />
          ))}
        </View>
      )}

      {widoczne.length === 0 && dania.length > 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          Żadne danie nie zawiera „{fraza.trim()}” w nazwie.
        </ThemedText>
      )}
    </View>
  );
}

/** „450 kcal · 32 g białka” — to samo, co kolumny tabeli, w jednej linijce. */
function opisMakro(p: PrzepisZMakro): string {
  const czesci = [
    p.kcal !== null ? `${p.kcal} kcal` : null,
    p.bialko_g !== null ? `${p.bialko_g} g białka` : null,
  ].filter(Boolean);
  return czesci.length > 0 ? czesci.join(' · ') : 'brak wartości odżywczych';
}

/** Zdjęcie przepisu albo neutralne pole z ikoną talerza, gdy go brak. */
function Obraz({ sciezka, rozmiarIkony }: { sciezka: string | null; rozmiarIkony: number }) {
  const motyw = useTheme();
  const adres = adresZdjecia(sciezka);
  if (adres) {
    return (
      <Image
        source={{ uri: adres }}
        style={StyleSheet.absoluteFill}
        contentFit="cover"
        transition={150}
        accessibilityIgnoresInvertColors
      />
    );
  }
  return (
    <View style={[styles.brak, { backgroundColor: motyw.backgroundSelected }]}>
      <Ionicons name="restaurant-outline" size={rozmiarIkony} color={motyw.textSecondary} />
    </View>
  );
}

function KafelDania({ danie, onPress }: { danie: PrzepisZMakro; onPress: () => void }) {
  const motyw = useTheme();
  return (
    <Pressable
      onPress={onPress}
      accessibilityRole="button"
      accessibilityLabel={`Wybierz: ${danie.nazwa}`}
      style={({ pressed }) => [
        styles.kafel,
        { backgroundColor: motyw.background, borderColor: motyw.border },
        pressed && styles.wcisniety,
      ]}>
      <View style={styles.zdjecie}>
        <Obraz sciezka={danie.zdjecie} rozmiarIkony={28} />
      </View>
      <View style={styles.podpis}>
        <ThemedText type="smallBold" numberOfLines={2}>
          {danie.nazwa}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
          {opisMakro(danie)}
        </ThemedText>
      </View>
    </Pressable>
  );
}

/**
 * Wiersz: miniatura, nazwa z porcją pod spodem, kcal i białko po prawej —
 * zawsze w tym samym miejscu, żeby dało się je porównać wzrokiem w kolumnie.
 */
function WierszDania({ danie, onPress }: { danie: PrzepisZMakro; onPress: () => void }) {
  const motyw = useTheme();
  return (
    <Pressable
      onPress={onPress}
      accessibilityRole="button"
      accessibilityLabel={`Wybierz: ${danie.nazwa}`}
      style={({ pressed }) => [styles.wiersz, { borderColor: motyw.border }, pressed && styles.wcisniety]}>
      <View style={[styles.miniatura, { backgroundColor: motyw.backgroundSelected }]}>
        <Obraz sciezka={danie.zdjecie} rozmiarIkony={20} />
      </View>

      <View style={styles.wierszNazwa}>
        <ThemedText type="default" numberOfLines={2}>
          {danie.nazwa}
        </ThemedText>
        {danie.gramy_porcji ? (
          <ThemedText type="small" themeColor="textSecondary">
            porcja {danie.gramy_porcji} g
          </ThemedText>
        ) : null}
      </View>

      <View style={styles.wierszMakro}>
        <ThemedText type="smallBold" themeColor="accent" numberOfLines={1}>
          {danie.kcal !== null ? `${danie.kcal} kcal` : '—'}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
          {danie.bialko_g !== null ? `${danie.bialko_g} g białka` : ''}
        </ThemedText>
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  calosc: { gap: Spacing.two },
  siatka: { flexDirection: 'row', flexWrap: 'wrap', margin: -ODSTEP / 2 },
  komorka: { padding: ODSTEP / 2 },
  kafel: {
    flex: 1,
    borderRadius: Spacing.two,
    borderWidth: 1,
    overflow: 'hidden',
  },
  zdjecie: { aspectRatio: 4 / 3 },
  brak: { flex: 1, alignItems: 'center', justifyContent: 'center' },
  podpis: { gap: 2, paddingHorizontal: Spacing.two, paddingVertical: 6 },
  wcisniety: { opacity: 0.8 },
  wiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    minHeight: 60,
    paddingVertical: Spacing.one,
    borderBottomWidth: StyleSheet.hairlineWidth,
  },
  miniatura: {
    width: 48,
    height: 48,
    borderRadius: 6,
    overflow: 'hidden',
  },
  wierszNazwa: { flex: 1 },
  wierszMakro: { alignItems: 'flex-end' },
});
