import { Ionicons } from '@expo/vector-icons';
import { StyleSheet, View } from 'react-native';

import { ListaRozwijana } from './lista-rozwijana';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { czyDzisiaj, opisDnia, type Plan } from '@/lib/plan';

/**
 * Nagłówek ekranu planu — tytuł, liczba osób i kompaktowe pole daty z ikoną,
 * bez ikony-koła i bez podpisów nad polami (v03). Stały (patrz
 * `naglowekStaly` w `Ekran`), więc data zostaje pod ręką przy przewijaniu
 * długiej listy dni, tak jak nagłówki list zakupów i przepisów.
 *
 * Wysokość karty celowo dopasowana do nagłówka listy zakupów
 * (`NaglowekZakupow`) — ten sam rozmiar tytułu i ta sama otoczka dolnego
 * wiersza — żeby ekrany obok siebie w dolnej nawigacji nie „skakały”.
 *
 * Wyboru OGLĄDANEGO tygodnia celowo tu nie ma — nie robił nic, czego nie
 * robi już samo przewijanie do najnowszego, a zajmował drugi wiersz.
 */
export function NaglowekPlanu({
  plan,
  osoby,
  mozliweDaty,
  onZmianaPierwszegoDnia,
}: {
  plan: Plan;
  osoby: number;
  mozliweDaty: string[];
  onZmianaPierwszegoDnia: (data: string) => void;
}) {
  const motyw = useTheme();

  return (
    <ThemedView type="backgroundElement" style={[styles.karta, { borderColor: motyw.border }]}>
      <View style={styles.gorny}>
        <ThemedText type="subtitle" numberOfLines={1}>
          Plan dnia
        </ThemedText>

        <View style={styles.osoby}>
          <Ionicons name="people-outline" size={14} color={motyw.textSecondary} />
          <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
            {osoby} {osoby === 1 ? 'osoba' : 'osoby'}
          </ThemedText>
        </View>
      </View>

      <View style={[styles.dolny, { backgroundColor: motyw.background, borderColor: motyw.border }]}>
        <ThemedText type="small" themeColor="textSecondary">
          Start od:
        </ThemedText>

        <View style={styles.poleDaty}>
          <ListaRozwijana
            ikona="calendar-outline"
            kompaktowy
            wybrana={plan.data_start}
            onZmiana={onZmianaPierwszegoDnia}
            opcje={mozliweDaty.map((d) => ({
              wartosc: d,
              etykieta: opisDnia(d),
              opis: czyDzisiaj(d) ? 'dzisiaj' : undefined,
            }))}
          />
        </View>
      </View>
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
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  osoby: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  /* Ta sama otoczka co pasek liczników w nagłówku listy zakupów — żeby obie
     karty miały porównywalną wysokość na ekranach obok siebie w nawigacji. */
  dolny: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    paddingVertical: Spacing.two,
    paddingHorizontal: Spacing.two,
  },
  poleDaty: {
    flexBasis: 190,
    flexGrow: 0,
    flexShrink: 0,
  },
});
