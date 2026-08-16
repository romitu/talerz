import { Ionicons } from '@expo/vector-icons';
import { useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type Props = {
  /** Nazwy kupowane wcześniej — z nich powstają podpowiedzi. */
  historia: string[];
  /** Co już wisi na liście — tego nie podpowiadamy drugi raz. */
  juzNaLiscie: string[];
  onDodaj: (nazwa: string, ilosc: string) => Promise<void>;
};

/** Bez wielkich liter i bez ogonków — „worki” ma znaleźć „Worki”. */
function doPorownania(tekst: string): string {
  return tekst
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/ł/g, 'l')
    .replace(/Ł/g, 'L')
    .toLowerCase();
}

/**
 * Dopisywanie produktu spoza planu.
 *
 * Dlaczego podpowiedzi z historii, a nie katalog
 * ----------------------------------------------
 * Katalog produktów domowych trzeba by raz ułożyć, a potem pilnować, żeby
 * nie zarósł. Historia buduje się sama: dopisujesz „Worki na śmieci” raz,
 * a za miesiąc wpisujesz „wor” i pozycja jest gotowa jednym dotknięciem.
 *
 * Podpowiedzi pokazujemy dopiero od drugiego znaku. Przy jednym literze
 * pasowałaby połowa historii i lista byłaby ścianą tekstu zamiast pomocą.
 */
export function DopiszProdukt({ historia, juzNaLiscie, onDodaj }: Props) {
  const motyw = useTheme();
  const [nazwa, setNazwa] = useState('');
  const [ilosc, setIlosc] = useState('');
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const pasujace = useMemo(() => {
    const szukane = doPorownania(nazwa.trim());
    if (szukane.length < 2) return [];
    const wykluczone = new Set(juzNaLiscie.map(doPorownania));
    return historia
      .filter((h) => doPorownania(h).includes(szukane) && !wykluczone.has(doPorownania(h)))
      .slice(0, 5);
  }, [historia, juzNaLiscie, nazwa]);

  async function dodaj(jaka: string) {
    const czysta = jaka.trim();
    if (!czysta) return;

    setBlad(null);
    setZajety(true);
    try {
      await onDodaj(czysta, ilosc);
      setNazwa('');
      setIlosc('');
    } catch (e) {
      setBlad(e instanceof Error ? e.message : 'Nie udało się dopisać produktu.');
    } finally {
      setZajety(false);
    }
  }

  return (
    <View style={styles.grupa}>
      <View style={styles.wiersz}>
        <View style={styles.poleNazwy}>
          <Pole
            etykieta="Dopisz produkt"
            value={nazwa}
            onChangeText={setNazwa}
            placeholder="Worki na śmieci"
            autoCorrect={false}
            onSubmitEditing={() => dodaj(nazwa)}
            returnKeyType="done"
          />
        </View>
        <View style={styles.poleIlosci}>
          <Pole
            etykieta="Ile"
            value={ilosc}
            onChangeText={setIlosc}
            placeholder="1 opak."
            autoCorrect={false}
            onSubmitEditing={() => dodaj(nazwa)}
            returnKeyType="done"
          />
        </View>
      </View>

      {pasujace.length > 0 && (
        <View style={styles.podpowiedzi}>
          {pasujace.map((h) => (
            <Pressable
              key={h}
              onPress={() => dodaj(h)}
              disabled={zajety}
              accessibilityRole="button"
              accessibilityLabel={`Dopisz ${h}`}
              style={({ pressed }) => [
                styles.podpowiedz,
                { borderColor: motyw.border, backgroundColor: motyw.backgroundElement },
                pressed && styles.wcisnieta,
              ]}>
              <Ionicons name="time-outline" size={14} color={motyw.textSecondary} />
              <ThemedText type="small">{h}</ThemedText>
            </Pressable>
          ))}
        </View>
      )}

      <Przycisk
        tytul="Dopisz do listy"
        wariant="poboczny"
        onPress={() => dodaj(nazwa)}
        zajety={zajety}
        wylaczony={nazwa.trim().length === 0}
      />

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.two },
  wiersz: { flexDirection: 'row', gap: Spacing.two, alignItems: 'flex-end' },
  poleNazwy: { flex: 3 },
  poleIlosci: { flex: 1, minWidth: 90 },
  podpowiedzi: { flexDirection: 'row', flexWrap: 'wrap', gap: Spacing.one },
  podpowiedz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderWidth: 1,
    borderRadius: 999,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  wcisnieta: { opacity: 0.6 },
});
