import { Ionicons } from '@expo/vector-icons';
import { useMemo, useState, type ReactNode } from 'react';
import { Pressable, ScrollView, StyleSheet, useWindowDimensions, View } from 'react-native';

import { Pole } from './pole';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export type KolumnaWyboru<T> = {
  tytul: string;
  /** Stała szerokość w pikselach. Pomijana, gdy kolumna jest elastyczna. */
  szerokosc?: number;
  /** Kolumna zabiera całe wolne miejsce — zwykle nazwa. */
  elastyczna?: boolean;
  liczba?: boolean;
  wartosc: (element: T) => string;
};

/** Poniżej tej szerokości kolumna elastyczna przestaje być czytelna. */
const MIN_ELASTYCZNEJ = 160;

type TabelaWyboruProps<T> = {
  dane: T[];
  klucz: (element: T) => string;
  kolumny: KolumnaWyboru<T>[];
  /** Identyfikatory elementów już wybranych. */
  wybrane: Set<string>;
  onPrzelacz: (element: T) => void;
  /** Do przeszukiwania — z czego składa się tekst brany pod uwagę przy filtrze. */
  tekstDoFiltra: (element: T) => string;
  /** Pola uzupełniane po dodaniu, rozwijane pod wierszem. */
  szczegoly?: (element: T) => ReactNode;
  etykietaFiltra?: string;
  placeholderFiltra?: string;
  /** Pokazywane pod tabelą, np. przycisk dopisania nowej pozycji. */
  stopka?: (fraza: string) => ReactNode;
  wysokosc?: number;
};

/**
 * Tabela do wybierania pozycji — filtrowana, ze znakiem plus przy każdym wierszu.
 *
 * Ten sam wzorzec obsługuje składniki i sprzęt: filtrujesz, dodajesz znakiem
 * plus, a wiersz rozwija się i prosi o szczegóły (gramaturę, stan). Wybrane
 * pozycje przechodzą na górę listy, żeby nie trzeba ich było szukać.
 */
export function TabelaWyboru<T>({
  dane,
  klucz,
  kolumny,
  wybrane,
  onPrzelacz,
  tekstDoFiltra,
  szczegoly,
  etykietaFiltra = 'Filtruj',
  placeholderFiltra,
  stopka,
  wysokosc = 320,
}: TabelaWyboruProps<T>) {
  const motyw = useTheme();
  const [fraza, setFraza] = useState('');
  // Diagnostyka: ile razy dotknięcie wiersza doszło do skutku.
  const [dotkniec, setDotkniec] = useState(0);
  const [ostatnie, setOstatnie] = useState<string | null>(null);
  const { width: szerokoscOkna } = useWindowDimensions();

  const szerokoscMinimalna =
    kolumny.reduce((s, k) => s + (k.elastyczna ? MIN_ELASTYCZNEJ : (k.szerokosc ?? 0)), 0) + 40;

  /**
   * Gdy tabela mieści się na ekranie, rezygnujemy z przewijania w bok
   * i pozwalamy kolumnie elastycznej zabrać całe wolne miejsce.
   * Na wąskim ekranie wracamy do przewijania ze stałymi szerokościami.
   */
  const miesciSie = szerokoscOkna >= szerokoscMinimalna + 64;

  function przelacz(element: T, id: string) {
    setDotkniec((n) => n + 1);
    setOstatnie(kolumny[0]?.wartosc(element) ?? id);
    onPrzelacz(element);
  }

  const stylKolumny = (k: KolumnaWyboru<T>) =>
    miesciSie && k.elastyczna
      ? { flex: 1, minWidth: MIN_ELASTYCZNEJ }
      : { width: k.elastyczna ? MIN_ELASTYCZNEJ : (k.szerokosc ?? 80) };

  const szerokoscTabeli = miesciSie ? ('100%' as const) : szerokoscMinimalna;

  const widoczne = useMemo(() => {
    const f = fraza.trim().toLowerCase();
    const pasujace = f
      ? dane.filter((x) => tekstDoFiltra(x).toLowerCase().includes(f))
      : dane;

    // Wybrane na górze — inaczej po odfiltrowaniu znikają z oczu.
    return [...pasujace].sort((a, b) => {
      const wa = wybrane.has(klucz(a)) ? 0 : 1;
      const wb = wybrane.has(klucz(b)) ? 0 : 1;
      return wa - wb;
    });
  }, [dane, fraza, wybrane, klucz, tekstDoFiltra]);

  return (
    <View style={styles.calosc}>
      <Pole
        etykieta={etykietaFiltra}
        value={fraza}
        onChangeText={setFraza}
        placeholder={placeholderFiltra}
      />

      <Poziomo wlaczone={!miesciSie}>
        <View style={{ width: szerokoscTabeli }}>
          <View style={[styles.wiersz, styles.naglowek, { borderColor: motyw.border }]}>
            <View style={styles.komorkaZnaku} />
            {kolumny.map((k) => (
              <View key={k.tytul} style={[styles.komorka, stylKolumny(k)]}>
                <ThemedText
                  type="smallBold"
                  themeColor="textSecondary"
                  style={k.liczba ? styles.doPrawej : undefined}
                  numberOfLines={1}>
                  {k.tytul}
                </ThemedText>
              </View>
            ))}
          </View>

          <ScrollView style={{ maxHeight: wysokosc }} nestedScrollEnabled>
            {widoczne.map((element, i) => {
              const id = klucz(element);
              const zaznaczony = wybrane.has(id);

              return (
                <View key={id}>
                  {/*
                    Wiersz jest zwykłym pojemnikiem, a klikalne są dwa
                    osobne obszary OBOK siebie: znak plus i część z danymi.
                    Zagnieżdżenie przycisku w przycisku daje nieprawidłowy
                    dokument HTML — przeglądarka przebudowuje wtedy stronę
                    po swojemu i dotknięcia przestają działać przewidywalnie.
                  */}
                  <View
                    style={[
                      styles.wiersz,
                      {
                        borderColor: motyw.border,
                        backgroundColor: zaznaczony
                          ? motyw.backgroundSelected
                          : i % 2 === 0
                            ? motyw.backgroundElement
                            : motyw.background,
                      },
                    ]}>
                    <Pressable
                      onPress={() => przelacz(element, id)}
                      hitSlop={6}
                      accessibilityRole="button"
                      accessibilityLabel={zaznaczony ? 'Usuń z wyboru' : 'Dodaj do wyboru'}
                      style={({ pressed }) => [styles.komorkaZnaku, pressed && styles.wcisniety]}>
                      <Ionicons
                        name={zaznaczony ? 'checkmark-circle' : 'add-circle-outline'}
                        size={22}
                        color={motyw.accent}
                      />
                    </Pressable>

                    <Pressable
                      onPress={() => przelacz(element, id)}
                      accessibilityRole="button"
                      accessibilityState={{ selected: zaznaczony }}
                      style={({ pressed }) => [styles.komorki, pressed && styles.wcisniety]}>
                      {kolumny.map((k) => (
                        <View key={k.tytul} style={[styles.komorka, stylKolumny(k)]}>
                          <ThemedText
                            type={zaznaczony ? 'smallBold' : 'small'}
                            style={k.liczba ? styles.doPrawej : undefined}
                            numberOfLines={2}>
                            {k.wartosc(element)}
                          </ThemedText>
                        </View>
                      ))}
                    </Pressable>
                  </View>

                  {zaznaczony && szczegoly && (
                    <View
                      style={[
                        styles.szczegoly,
                        { borderColor: motyw.accent, backgroundColor: motyw.background },
                      ]}>
                      {szczegoly(element)}
                    </View>
                  )}
                </View>
              );
            })}

            {widoczne.length === 0 && (
              <ThemedText type="small" themeColor="textSecondary" style={styles.pusto}>
                Nic nie pasuje do wpisanej frazy.
              </ThemedText>
            )}
          </ScrollView>
        </View>
      </Poziomo>

      {dotkniec > 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          Diagnostyka: dotknięć {dotkniec}, ostatnie „{ostatnie}”, wybranych {wybrane.size}.
        </ThemedText>
      )}

      {stopka?.(fraza.trim())}
    </View>
  );
}

/** Owija zawartość w przewijanie poziome tylko wtedy, gdy jest potrzebne. */
function Poziomo({ wlaczone, children }: { wlaczone: boolean; children: ReactNode }) {
  if (!wlaczone) return <>{children}</>;
  return (
    <ScrollView horizontal showsHorizontalScrollIndicator>
      {children}
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  calosc: { gap: Spacing.two },
  wiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    borderBottomWidth: 1,
    minHeight: 38,
  },
  naglowek: { borderBottomWidth: 2 },
  komorka: {
    paddingHorizontal: Spacing.one,
    paddingVertical: Spacing.one,
    justifyContent: 'center',
  },
  komorki: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    alignSelf: 'stretch',
  },
  komorkaZnaku: {
    width: 40,
    alignItems: 'center',
    justifyContent: 'center',
    alignSelf: 'stretch',
  },
  doPrawej: { textAlign: 'right' },
  wcisniety: { opacity: 0.7 },
  szczegoly: {
    borderLeftWidth: 3,
    borderBottomWidth: 1,
    paddingVertical: Spacing.two,
    paddingHorizontal: Spacing.three,
    gap: Spacing.two,
  },
  pusto: { padding: Spacing.three },
});
