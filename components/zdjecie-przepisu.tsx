import { Image } from 'expo-image';
import { useState } from 'react';
import { ActivityIndicator, Pressable, StyleSheet, View } from 'react-native';

import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import {
  adresZdjecia,
  mozliwyWyborZdjecia,
  usunZdjecie,
  wybierzZdjecie,
  wyslijZdjecie,
} from '@/lib/zdjecia';

type Props = {
  /** Nazwa przepisu — z niej powstaje nazwa pliku w zasobniku. */
  nazwaPrzepisu: string;
  /** Ścieżka zapisana w bazie albo `null`. */
  zdjecie: string | null;
  /** Wywoływane po wysłaniu lub usunięciu — rodzic zapisuje ścieżkę w bazie. */
  onZmiana: (sciezka: string | null) => void;
};

/**
 * Dodawanie, wymiana i usuwanie zdjęcia przepisu.
 *
 * Zdjęcie ląduje w zasobniku od razu po wybraniu, a nie przy zapisie formularza.
 * Powód: plik trafia do Storage, nie do wiersza w tabeli, więc i tak są to dwie
 * osobne operacje. Wysyłanie od razu daje natychmiastowy podgląd i wyklucza
 * sytuację, w której użytkownik widzi zdjęcie, ale zapomni nacisnąć „Zapisz".
 *
 * Cena tego wyboru: porzucenie formularza po wybraniu zdjęcia zostawia plik
 * w zasobniku. Nikomu to nie szkodzi — nazwa pliku wynika z nazwy przepisu,
 * więc następne wgranie po prostu go nadpisze.
 */
export function ZdjeciePrzepisu({ nazwaPrzepisu, zdjecie, onZmiana }: Props) {
  const motyw = useTheme();
  const [pracuje, setPracuje] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  /**
   * Podgląd świeżo wgranego pliku RAZEM ze ścieżką, pod którą poszedł.
   *
   * Ścieżka jest tu kluczowa. Formularz przepisu nie znika z pamięci przy
   * przejściu do innego dania, więc sam podgląd bez przypisania zostawał na
   * ekranie i pokazywał zdjęcie poprzedniego przepisu — wgrywasz fotkę do
   * „Dorsza po grecku”, otwierasz „Tom kha gai” i widzisz dorsza.
   *
   * Porównanie ze ścieżką z formularza zamyka to raz na zawsze: podgląd
   * pokazujemy tylko wtedy, gdy dotyczy zdjęcia, które przepis ma teraz.
   */
  const [wgrane, setWgrane] = useState<{ sciezka: string; podglad: string } | null>(null);

  /** Podgląd w trakcie wysyłki — zanim znamy ścieżkę. */
  const [wysylany, setWysylany] = useState<string | null>(null);

  const adres =
    wysylany ??
    (wgrane && wgrane.sciezka === zdjecie ? wgrane.podglad : adresZdjecia(zdjecie));
  const mozna = mozliwyWyborZdjecia();
  const nazwaGotowa = nazwaPrzepisu.trim().length > 0;

  async function wybierz() {
    setBlad(null);

    if (!nazwaGotowa) {
      // Nazwa pliku powstaje z nazwy przepisu. Bez niej zdjęcie trafiłoby pod
      // „przepis.jpg" i nadpisało cudze — lepiej poprosić o nazwę najpierw.
      setBlad('Najpierw wpisz nazwę przepisu — z niej powstaje nazwa pliku.');
      return;
    }

    setPracuje(true);
    try {
      const wybrane = await wybierzZdjecie();
      if (!wybrane) return;
      setWysylany(wybrane.podglad);
      const sciezka = await wyslijZdjecie(nazwaPrzepisu, wybrane.dane);
      setWgrane({ sciezka, podglad: wybrane.podglad });
      onZmiana(sciezka);
    } catch (e) {
      setWgrane(null);
      setBlad(komunikatBledu(e));
    } finally {
      setWysylany(null);
      setPracuje(false);
    }
  }

  async function usun() {
    setBlad(null);
    setPracuje(true);
    try {
      if (zdjecie) await usunZdjecie(zdjecie);
      setWgrane(null);
      onZmiana(null);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        ZDJĘCIE
      </ThemedText>

      {adres ? (
        <Image
          source={{ uri: adres }}
          style={[styles.podglad, { borderColor: motyw.border }]}
          contentFit="cover"
          transition={150}
        />
      ) : (
        <Pressable
          onPress={mozna ? wybierz : undefined}
          disabled={!mozna || pracuje}
          accessibilityRole="button"
          accessibilityLabel="Dodaj zdjęcie"
          style={({ pressed }) => [
            styles.pusto,
            { borderColor: motyw.border },
            pressed && styles.wcisniete,
          ]}>
          <ThemedText type="small" themeColor="textSecondary">
            {mozna ? 'Brak zdjęcia — dotknij, żeby wybrać plik' : 'Brak zdjęcia'}
          </ThemedText>
        </Pressable>
      )}

      {pracuje && (
        <View style={styles.pracuje}>
          <ActivityIndicator color={motyw.accent} />
          <ThemedText type="small" themeColor="textSecondary">
            Zmniejszam i wysyłam…
          </ThemedText>
        </View>
      )}

      {mozna ? (
        <View style={styles.przyciski}>
          <View style={styles.przycisk}>
            <Przycisk
              tytul={zdjecie ? 'Wymień zdjęcie' : 'Dodaj zdjęcie'}
              wariant="poboczny"
              onPress={wybierz}
              wylaczony={pracuje}
            />
          </View>
          {zdjecie && (
            <View style={styles.przycisk}>
              <Przycisk tytul="Usuń zdjęcie" wariant="poboczny" onPress={usun} wylaczony={pracuje} />
            </View>
          )}
        </View>
      ) : (
        <ThemedText type="small" themeColor="textSecondary">
          Zdjęcia dodajesz z przeglądarki — na telefonie na razie tylko je oglądasz.
        </ThemedText>
      )}

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        Zdjęcie jest zmniejszane do 1024 px przed wysłaniem, więc możesz wybrać
        prosto z aparatu. Zapisuje się od razu, bez czekania na „Zapisz przepis”.
      </ThemedText>
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.one },
  podglad: {
    width: '100%',
    aspectRatio: 16 / 9,
    borderRadius: Spacing.two,
    borderWidth: 1,
  },
  pusto: {
    width: '100%',
    aspectRatio: 16 / 9,
    borderRadius: Spacing.two,
    borderWidth: 1,
    borderStyle: 'dashed',
    alignItems: 'center',
    justifyContent: 'center',
    padding: Spacing.two,
  },
  wcisniete: { opacity: 0.6 },
  pracuje: { flexDirection: 'row', alignItems: 'center', gap: Spacing.two },
  przyciski: { flexDirection: 'row', gap: Spacing.two },
  przycisk: { flex: 1 },
});
