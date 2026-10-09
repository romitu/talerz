import { Image } from 'expo-image';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, StyleSheet, View } from 'react-native';

import { ZnaczekZrodla } from './kafel-zakupu';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import type { ZrodloZdjecia } from '@/lib/zakupy';
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
  /** Skąd zdjęcie; `null` przy zdjęciu = jeszcze nieoznaczone (migracja 0047). */
  zrodlo: ZrodloZdjecia | null;
  onZmianaZrodla: (zrodlo: ZrodloZdjecia | null) => void;
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
export function ZdjeciePrzepisu({ nazwaPrzepisu, zdjecie, onZmiana, zrodlo, onZmianaZrodla }: Props) {
  const motyw = useTheme();
  const { t } = useTranslation();
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
      setBlad(t('zdjeciePrzepisu.najpierwNazwa'));
      return;
    }

    setPracuje(true);
    try {
      const wybrane = await wybierzZdjecie();
      if (!wybrane) return;
      setWysylany(wybrane.podglad);
      const poprzednia = zdjecie;
      const sciezka = await wyslijZdjecie(nazwaPrzepisu, wybrane.dane);
      setWgrane({ sciezka, podglad: wybrane.podglad });
      onZmiana(sciezka);
      // Nowe zdjęcie nie dziedziczy oznaczenia poprzedniego — grafikę AI łatwo
      // podmienić na własne zdjęcie i zostawić stary znaczek. Bez domyślnej
      // wartości: pomyłka „własne” przy grafice AI byłaby niewidoczna.
      onZmianaZrodla(null);
      // Każde wgranie ma teraz unikalną nazwę (patrz nazwaPliku w lib/zdjecia.ts),
      // więc stary plik trzeba skasować osobno — inaczej zostaje osierocony w zasobniku.
      if (poprzednia && poprzednia !== sciezka) usunZdjecie(poprzednia);
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
      onZmianaZrodla(null);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {t('zdjeciePrzepisu.naglowek')}
      </ThemedText>

      {adres ? (
        <View>
          <Image
            source={{ uri: adres }}
            style={[styles.podglad, { borderColor: motyw.border }]}
            contentFit="cover"
            transition={150}
          />
          {zdjecie && zrodlo && <ZnaczekZrodla zrodlo={zrodlo} />}
        </View>
      ) : (
        <Pressable
          onPress={mozna ? wybierz : undefined}
          disabled={!mozna || pracuje}
          accessibilityRole="button"
          accessibilityLabel={t('zdjeciePrzepisu.dodaj')}
          style={({ pressed }) => [
            styles.pusto,
            { borderColor: motyw.border },
            pressed && styles.wcisniete,
          ]}>
          <ThemedText type="small" themeColor="textSecondary">
            {mozna ? t('zdjeciePrzepisu.brakDotknij') : t('wspolne.brakZdjecia')}
          </ThemedText>
        </Pressable>
      )}

      {pracuje && (
        <View style={styles.pracuje}>
          <ActivityIndicator color={motyw.accent} />
          <ThemedText type="small" themeColor="textSecondary">
            {t('zdjeciePrzepisu.wysylam')}
          </ThemedText>
        </View>
      )}

      {zdjecie && (
        <View style={styles.grupa}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {t('zdjeciePrzepisu.pochodzenie')}
          </ThemedText>
          <View style={styles.przyciski}>
            {(['ai', 'wlasne'] as const).map((z) => {
              const aktywny = zrodlo === z;
              return (
                <Pressable
                  key={z}
                  onPress={() => onZmianaZrodla(z)}
                  disabled={pracuje}
                  accessibilityRole="radio"
                  accessibilityState={{ selected: aktywny }}
                  style={[
                    styles.opcja,
                    {
                      borderColor: aktywny ? motyw.accent : motyw.border,
                      backgroundColor: aktywny ? motyw.backgroundSelected : 'transparent',
                    },
                  ]}>
                  <ThemedText type="smallBold" themeColor={aktywny ? 'accent' : undefined}>
                    {t(`zrodloZdjecia.${z}.tytul`)}
                  </ThemedText>
                  <ThemedText type="small" themeColor="textSecondary">
                    {t(`zrodloZdjecia.${z}.opis`)}
                  </ThemedText>
                </Pressable>
              );
            })}
          </View>
          {!zrodlo && (
            <ThemedText type="small" themeColor="accent">
              {t('zdjeciePrzepisu.nieoznaczone')}
            </ThemedText>
          )}
        </View>
      )}

      {mozna ? (
        <View style={styles.przyciski}>
          <View style={styles.przycisk}>
            <Przycisk
              tytul={zdjecie ? t('zdjeciePrzepisu.wymien') : t('zdjeciePrzepisu.dodaj')}
              wariant="poboczny"
              onPress={wybierz}
              wylaczony={pracuje}
            />
          </View>
          {zdjecie && (
            <View style={styles.przycisk}>
              <Przycisk tytul={t('zdjeciePrzepisu.usun')} wariant="poboczny" onPress={usun} wylaczony={pracuje} />
            </View>
          )}
        </View>
      ) : (
        <ThemedText type="small" themeColor="textSecondary">
          {t('zdjeciePrzepisu.tylkoPrzegladarka')}
        </ThemedText>
      )}

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        {t('zdjeciePrzepisu.wskazowka')}
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
  opcja: { flex: 1, borderWidth: 1, borderRadius: Spacing.two, padding: Spacing.two, gap: 2 },
});
