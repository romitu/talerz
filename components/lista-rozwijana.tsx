import { Ionicons } from '@expo/vector-icons';
import { useState } from 'react';
import { Pressable, ScrollView, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type Opcja<T extends string> = {
  wartosc: T;
  etykieta: string;
  opis?: string;
};

type Props<T extends string> = {
  /** Pominięta = bez podpisu nad polem, do ciasnych nagłówków. */
  etykieta?: string;
  /** Ikona przed wartością — zastępuje podpis, gdy miejsca jest mało. */
  ikona?: keyof typeof Ionicons.glyphMap;
  /**
   * Ścieśniona wersja: niższe pole, mniejsza czcionka, bez drugiej linii
   * (`opis` przy wybranej opcji się nie mieści). Lista PO rozwinięciu zostaje
   * pełnowymiarowa — zwinięte pole zajmuje mniej miejsca, ale wybieranie
   * z niego jedną ręką w kuchni ma być tak samo wygodne jak zawsze.
   */
  kompaktowy?: boolean;
  opcje: Opcja<T>[];
  wybrana: T | null;
  onZmiana: (wartosc: T) => void;
  /** Co pokazać, gdy nic nie wybrano. */
  placeholder?: string;
  /** Ile opcji zmieści się bez przewijania. Reszta pod palcem. */
  widocznychOpcji?: number;
};

/**
 * Pole rozwijane — zwinięte pokazuje wybraną wartość, po dotknięciu rozwija listę.
 *
 * Czym się różni od komponentu `Wybor`
 * ------------------------------------
 * `Wybor` pokazuje wszystkie opcje naraz. Świetnie sprawdza się przy trzech czy
 * czterech (pora posiłku, poziom aktywności), ale przy czternastu datach zjada
 * pół ekranu i spycha treść w dół.
 *
 * Dlaczego nie natywny kalendarz
 * ------------------------------
 * Bo wybór nie jest dowolny. Plan zaczyna się od dziś albo w ciągu najbliższych
 * dwóch tygodni — data z zeszłego roku nie ma sensu, a kalendarz systemowy
 * kazałby ją odfiltrowywać po fakcie i tłumaczyć użytkownikowi, czemu nie działa.
 * Lista możliwych dat mówi to samo, tylko wprost.
 *
 * Lista rozwija się W DÓŁ, w normalnym układzie, a nie nad treścią. Element
 * pozycjonowany bezwzględnie bywa przycinany przez przewijaną kartę i na
 * telefonie znika bez śladu — mieliśmy już ten błąd przy składnikach.
 */
export function ListaRozwijana<T extends string>({
  etykieta,
  ikona,
  kompaktowy = false,
  opcje,
  wybrana,
  onZmiana,
  placeholder = 'wybierz…',
  widocznychOpcji = 6,
}: Props<T>) {
  const motyw = useTheme();
  const [otwarta, setOtwarta] = useState(false);

  const aktualna = opcje.find((o) => o.wartosc === wybrana);
  const wysokoscOpcji = 44;

  return (
    <View style={styles.grupa}>
      {etykieta && (
        <ThemedText type="smallBold" themeColor="textSecondary">
          {etykieta}
        </ThemedText>
      )}

      <Pressable
        onPress={() => setOtwarta((x) => !x)}
        accessibilityRole="button"
        accessibilityState={{ expanded: otwarta }}
        accessibilityLabel={
          etykieta
            ? `${etykieta}: ${aktualna?.etykieta ?? placeholder}`
            : (aktualna?.etykieta ?? placeholder)
        }
        style={({ pressed }) => [
          styles.pole,
          kompaktowy && styles.poleKompaktowe,
          {
            borderColor: otwarta ? motyw.accent : motyw.border,
            backgroundColor: motyw.backgroundElement,
          },
          pressed && styles.wcisniete,
        ]}>
        {ikona && <Ionicons name={ikona} size={kompaktowy ? 15 : 18} color={motyw.textSecondary} />}
        <View style={styles.trescPola}>
          <ThemedText
            type={kompaktowy ? 'small' : 'default'}
            themeColor={aktualna ? 'text' : 'textSecondary'}
            numberOfLines={1}>
            {aktualna?.etykieta ?? placeholder}
          </ThemedText>
          {aktualna?.opis && !kompaktowy && (
            <ThemedText type="small" themeColor="textSecondary">
              {aktualna.opis}
            </ThemedText>
          )}
        </View>
        <Ionicons
          name={otwarta ? 'chevron-up' : 'chevron-down'}
          size={kompaktowy ? 15 : 18}
          color={motyw.textSecondary}
        />
      </Pressable>

      {otwarta && (
        <View style={[styles.lista, { borderColor: motyw.border }]}>
          <ScrollView
            style={{ maxHeight: wysokoscOpcji * widocznychOpcji }}
            nestedScrollEnabled>
            {opcje.map((o) => {
              const zaznaczona = o.wartosc === wybrana;
              return (
                <Pressable
                  key={o.wartosc}
                  onPress={() => {
                    onZmiana(o.wartosc);
                    setOtwarta(false);
                  }}
                  accessibilityRole="radio"
                  accessibilityState={{ selected: zaznaczona }}
                  style={({ pressed }) => [
                    styles.opcja,
                    {
                      backgroundColor: zaznaczona
                        ? motyw.backgroundSelected
                        : motyw.backgroundElement,
                    },
                    pressed && styles.wcisniete,
                  ]}>
                  <View style={styles.trescOpcji}>
                    <ThemedText type={zaznaczona ? 'smallBold' : 'small'}>{o.etykieta}</ThemedText>
                    {o.opis && (
                      <ThemedText type="small" themeColor="textSecondary">
                        {o.opis}
                      </ThemedText>
                    )}
                  </View>
                  {zaznaczona && <Ionicons name="checkmark" size={16} color={motyw.accent} />}
                </Pressable>
              );
            })}
          </ScrollView>
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.one },
  pole: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
  },
  poleKompaktowe: {
    borderRadius: Spacing.one,
    paddingHorizontal: Spacing.two,
    paddingVertical: Spacing.one,
    gap: Spacing.one,
  },
  trescPola: { flex: 1, gap: 2 },
  lista: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  opcja: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
  },
  trescOpcji: { flex: 1, gap: 2 },
  wcisniete: { opacity: 0.7 },
});
