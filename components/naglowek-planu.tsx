import { Ionicons } from '@expo/vector-icons';
import { StyleSheet, View } from 'react-native';

import { ListaRozwijana } from './lista-rozwijana';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { czyDzisiaj, opisDnia, type Plan } from '@/lib/plan';

/**
 * Nagłówek ekranu planu — ikona, tytuł z licznikiem dni/osób i dwa pola
 * wyboru (pierwszy dzień, oglądany tydzień). Stały (patrz `naglowekStaly`
 * w `Ekran`), więc daty zostają pod ręką przy przewijaniu długiej listy dni,
 * tak jak nagłówki list zakupów i przepisów.
 */
export function NaglowekPlanu({
  plan,
  osoby,
  mozliweDaty,
  onZmianaPierwszegoDnia,
  plany,
  onZmianaTygodnia,
}: {
  plan: Plan;
  osoby: number;
  mozliweDaty: string[];
  onZmianaPierwszegoDnia: (data: string) => void;
  plany: Plan[];
  onZmianaTygodnia: (id: string) => void;
}) {
  const motyw = useTheme();

  return (
    <ThemedView type="backgroundElement" style={[styles.karta, { borderColor: motyw.border }]}>
      <View style={styles.gorny}>
        <View style={[styles.ikonaKolo, { backgroundColor: motyw.backgroundSelected }]}>
          <Ionicons name="calendar-outline" size={26} color={motyw.accent} />
        </View>

        <View style={styles.tytulOpis}>
          <ThemedText type="subtitle" numberOfLines={1}>
            Plan dnia
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
            {plan.dni} dni · {osoby} {osoby === 1 ? 'osoba' : 'osoby'}
          </ThemedText>
        </View>
      </View>

      <View style={styles.pola}>
        <View style={styles.pole}>
          <ListaRozwijana
            etykieta="PIERWSZY DZIEŃ PLANU"
            wybrana={plan.data_start}
            onZmiana={onZmianaPierwszegoDnia}
            opcje={mozliweDaty.map((d) => ({
              wartosc: d,
              etykieta: opisDnia(d),
              opis: czyDzisiaj(d) ? 'dzisiaj' : undefined,
            }))}
          />
        </View>

        {/*
          Przełącznik tygodni pokazuje się dopiero, gdy jest co przełączać.
          Przy pierwszym tygodniu byłby polem z jedną pozycją.
        */}
        {plany.length > 1 && (
          <View style={styles.pole}>
            <ListaRozwijana
              etykieta="OGLĄDANY TYDZIEŃ"
              wybrana={plan.id}
              onZmiana={onZmianaTygodnia}
              opcje={plany.map((p) => ({
                wartosc: p.id,
                etykieta: `od ${opisDnia(p.data_start)}`,
                opis: p.id === plany[0].id ? 'najnowszy' : undefined,
              }))}
            />
          </View>
        )}
      </View>

      <ThemedText type="small" themeColor="textSecondary">
        Pozostałe dni ułożą się od niego. Posiłki zostają przy swoich datach.
      </ThemedText>
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
  tytulOpis: { flex: 1, gap: 2 },
  pola: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.three,
  },
  pole: {
    flexGrow: 1,
    flexBasis: 220,
  },
});
