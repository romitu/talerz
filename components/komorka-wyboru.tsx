import { Ionicons } from '@expo/vector-icons';
import { useState } from 'react';
import { Modal, Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type Opcja<T extends string> = { wartosc: T; etykieta: string };

type KomorkaWyboruProps<T extends string> = {
  /** Aktualna wartość — `null` znaczy „nie wybrano”. */
  wartosc: T | null;
  /** Tekst pokazywany w komórce dla aktualnej wartości. */
  etykieta: string;
  opcje: Opcja<T>[];
  szerokosc: number;
  elastycznaSzerokosc?: boolean;
  edytowalna: boolean;
  onWybierz: (nowa: T) => void;
};

/**
 * Komórka tabeli z zamkniętą listą wartości do wyboru.
 *
 * `KomorkaEdytowalna` daje wolny tekst — dobre dla liczb i nazw, ale przy
 * kolumnie z ustaloną listą (rola, jednostka domyślnej kwantyzacji) pozwalało
 * wpisać cokolwiek i dowiedzieć się o pomyłce dopiero po opuszczeniu pola.
 * Tutaj wybiera się z listy, więc błędnej wartości nie da się w ogóle wpisać.
 */
export function KomorkaWyboru<T extends string>({
  wartosc,
  etykieta,
  opcje,
  szerokosc,
  elastycznaSzerokosc = false,
  edytowalna,
  onWybierz,
}: KomorkaWyboruProps<T>) {
  const motyw = useTheme();
  const [otwarta, setOtwarta] = useState(false);
  const wymiar = elastycznaSzerokosc ? { flex: 1, minWidth: 200 } : { width: szerokosc };

  if (!edytowalna) {
    return (
      <View style={[styles.komorka, wymiar]}>
        <ThemedText type="small" numberOfLines={2}>
          {etykieta}
        </ThemedText>
      </View>
    );
  }

  return (
    <View style={[styles.komorka, wymiar]}>
      <Pressable
        onPress={() => setOtwarta(true)}
        style={[
          styles.pole,
          { borderColor: motyw.border, backgroundColor: motyw.backgroundElement },
        ]}>
        <ThemedText type="small" numberOfLines={1} style={styles.tekstPola}>
          {etykieta}
        </ThemedText>
        <Ionicons name="chevron-down" size={14} color={motyw.textSecondary} />
      </Pressable>

      <Modal
        visible={otwarta}
        transparent
        animationType="fade"
        onRequestClose={() => setOtwarta(false)}>
        <Pressable style={styles.tlo} onPress={() => setOtwarta(false)}>
          <View
            style={[
              styles.lista,
              { backgroundColor: motyw.backgroundElement, borderColor: motyw.border },
            ]}>
            {opcje.map((o) => {
              const zaznaczona = o.wartosc === wartosc;
              return (
                <Pressable
                  key={o.wartosc}
                  onPress={() => {
                    onWybierz(o.wartosc);
                    setOtwarta(false);
                  }}
                  style={({ pressed }) => [
                    styles.pozycja,
                    zaznaczona && { backgroundColor: motyw.backgroundSelected },
                    pressed && styles.wcisnieta,
                  ]}>
                  <ThemedText type={zaznaczona ? 'smallBold' : 'small'}>{o.etykieta}</ThemedText>
                </Pressable>
              );
            })}
          </View>
        </Pressable>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  komorka: {
    paddingHorizontal: Spacing.one,
    paddingVertical: Spacing.one,
    justifyContent: 'center',
  },
  pole: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.one,
    borderWidth: 1,
    borderRadius: Spacing.one,
    paddingHorizontal: Spacing.one,
    paddingVertical: 2,
    minHeight: 30,
  },
  tekstPola: { flex: 1 },
  tlo: {
    flex: 1,
    backgroundColor: 'rgba(0, 0, 0, 0.4)',
    alignItems: 'center',
    justifyContent: 'center',
    padding: Spacing.four,
  },
  lista: {
    width: '100%',
    maxWidth: 320,
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  pozycja: {
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.three,
  },
  wcisnieta: { opacity: 0.7 },
});
