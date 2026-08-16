import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { WierszMakro } from '@/components/wiersz-makro';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import {
  czasRazem,
  opisTrwalosci,
  pobierzPelnyPrzepis,
  pobierzPrzepisy,
  type PelnyPrzepis,
  type PrzepisZMakro,
} from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { adresZdjecia } from '@/lib/zdjecia';

/**
 * Przepis do czytania przy garnku.
 *
 * Czym się różni od formularza
 * ----------------------------
 * Formularz służy do wpisywania i ma pola, przyciski i tabele. Ten ekran
 * służy do gotowania: duże kroki, gramatury pod ręką, żadnych elementów,
 * które da się przypadkiem nacisnąć mokrą dłonią.
 *
 * Dwie decyzje wynikają wprost z tego, że stoisz przy kuchence
 * ------------------------------------------------------------
 *   * Kroki można odhaczać. Odchodzisz do lodówki, wracasz i wiesz, gdzie
 *     byłeś. Odhaczenia siedzą tylko w pamięci ekranu — nie trafiają do bazy,
 *     bo dotyczą tego jednego gotowania, nie przepisu.
 *
 *   * Składniki i sprzęt są NAD krokami. Zanim zaczniesz, chcesz wiedzieć,
 *     czy masz wszystko i czy trzeba wyjąć blender.
 */
export default function EkranPrzepisu() {
  const { id, powrot } = useLocalSearchParams<{ id: string; powrot?: string }>();
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [przepis, setPrzepis] = useState<PelnyPrzepis | null>(null);
  const [makro, setMakro] = useState<PrzepisZMakro | null>(null);
  const [zrobione, setZrobione] = useState<Set<string>>(new Set());
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    if (!id) return;
    setWczytywanie(true);
    setBlad(null);
    try {
      const [pelny, wszystkie] = await Promise.all([
        pobierzPelnyPrzepis(id),
        pobierzPrzepisy(sesja?.user.id),
      ]);
      setPrzepis(pelny);
      setMakro(wszystkie.find((p) => p.id === id) ?? null);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [id, sesja?.user.id]);

  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

  function przelacz(klucz: string) {
    setZrobione((poprzednie) => {
      const nowe = new Set(poprzednie);
      if (nowe.has(klucz)) nowe.delete(klucz);
      else nowe.add(klucz);
      return nowe;
    });
  }

  if (wczytywanie) {
    return (
      <Ekran tytul="Przepis">
        <ThemedText type="small" themeColor="textSecondary">
          Wczytywanie…
        </ThemedText>
      </Ekran>
    );
  }

  if (blad || !przepis) {
    return (
      <Ekran tytul="Przepis">
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad ?? 'Nie znaleziono przepisu.'}
          </ThemedText>
        </Karta>
        <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/')} />
      </Ekran>
    );
  }

  const zdjecie = adresZdjecia(przepis.zdjecie);
  const czas = czasRazem(przepis.czas_przygotowania_min, przepis.czas_obrobki_min);
  const krokowRazem = przepis.etapy.reduce((s, e) => s + e.kroki.length, 0);

  return (
    <Ekran
      tytul={przepis.nazwa}
      podtytul={[
        czas ? `${czas} min` : null,
        przepis.porcja_g ? `porcja ${przepis.porcja_g} g` : null,
        opisTrwalosci(przepis.trwalosc_dni),
      ]
        .filter(Boolean)
        .join(' · ')}>
      {zdjecie && (
        <Image source={{ uri: zdjecie }} style={styles.zdjecie} contentFit="cover" transition={150} />
      )}

      {przepis.opis && (
        <Karta>
          <ThemedText type="small" themeColor="textSecondary">
            {przepis.opis}
          </ThemedText>
        </Karta>
      )}

      {makro?.kcal != null && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            NA PORCJĘ
          </ThemedText>
          <WierszMakro
            pozycje={[
              { etykieta: 'kcal', wartosc: makro.kcal, jednostka: '' },
              { etykieta: 'białko', wartosc: makro.bialko_g ?? 0, jednostka: ' g' },
              { etykieta: 'tłuszcz', wartosc: makro.tluszcz_g ?? 0, jednostka: ' g' },
              { etykieta: 'węgle', wartosc: makro.wegle_g ?? 0, jednostka: ' g' },
              { etykieta: 'błonnik', wartosc: makro.blonnik_g ?? 0, jednostka: ' g' },
            ]}
          />
          {makro.porcje_wyliczone && (
            <ThemedText type="small" themeColor="textSecondary">
              Z całego garnka wychodzi {Math.round(makro.porcje_wyliczone * 10) / 10} porcji
              {makro.gramy_calosc ? ` (${makro.gramy_calosc} g razem)` : ''}.
            </ThemedText>
          )}
        </Karta>
      )}

      {/* --- sprzęt: zanim zaczniesz ------------------------------------- */}
      {przepis.sprzet.length > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            WYJMIJ Z SZAFKI
          </ThemedText>
          <ThemedText type="default">{przepis.sprzet.join(' · ')}</ThemedText>
        </Karta>
      )}

      {/* --- składniki ---------------------------------------------------- */}
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          SKŁADNIKI ({przepis.skladniki.length})
        </ThemedText>
        {przepis.skladniki.map((s) => {
          const klucz = `s:${s.skladnik_id}`;
          const odhaczony = zrobione.has(klucz);
          return (
            <Pressable
              key={klucz}
              onPress={() => przelacz(klucz)}
              accessibilityRole="checkbox"
              accessibilityState={{ checked: odhaczony }}
              style={({ pressed }) => [styles.pozycja, pressed && styles.wcisniete]}>
              <Ionicons
                name={odhaczony ? 'checkbox' : 'square-outline'}
                size={20}
                color={odhaczony ? motyw.accent : motyw.textSecondary}
              />
              <View style={styles.trescPozycji}>
                <ThemedText
                  type="default"
                  themeColor={odhaczony ? 'textSecondary' : 'text'}>
                  {s.nazwa}
                </ThemedText>
                {(s.stan || s.zamiennik) && (
                  <ThemedText type="small" themeColor="textSecondary">
                    {[s.stan, s.zamiennik].filter(Boolean).join(' · ')}
                  </ThemedText>
                )}
              </View>
              <ThemedText type="smallBold" themeColor="textSecondary" style={styles.ilosc}>
                {opisIlosci(s)}
              </ThemedText>
            </Pressable>
          );
        })}
      </Karta>

      {/* --- etapy i kroki ------------------------------------------------ */}
      {przepis.etapy.map((etap, ie) => (
        <Karta key={`e${ie}`}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {etap.nazwa.toUpperCase()}
            {etap.minuty ? ` · ${etap.minuty} min` : ''}
          </ThemedText>
          {etap.kroki.map((krok, ik) => {
            const klucz = `k:${ie}:${ik}`;
            const odhaczony = zrobione.has(klucz);
            return (
              <Pressable
                key={klucz}
                onPress={() => przelacz(klucz)}
                accessibilityRole="checkbox"
                accessibilityState={{ checked: odhaczony }}
                style={({ pressed }) => [styles.krok, pressed && styles.wcisniete]}>
                <Ionicons
                  name={odhaczony ? 'checkmark-circle' : 'ellipse-outline'}
                  size={24}
                  color={odhaczony ? motyw.accent : motyw.textSecondary}
                />
                <View style={styles.trescPozycji}>
                  <ThemedText
                    type="default"
                    themeColor={odhaczony ? 'textSecondary' : 'text'}>
                    {krok.tresc}
                  </ThemedText>
                  {krok.sygnal && (
                    <ThemedText type="small" themeColor="textSecondary">
                      Po czym poznać: {krok.sygnal}
                    </ThemedText>
                  )}
                  {krok.uwaga && (
                    <ThemedText type="smallBold" themeColor="accent">
                      Uwaga — tego kroku nie pomijaj.
                    </ThemedText>
                  )}
                </View>
              </Pressable>
            );
          })}
        </Karta>
      ))}

      {/* --- po ugotowaniu ------------------------------------------------ */}
      {(przepis.przechowywanie || przepis.mozna_mrozic !== null) && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            PO UGOTOWANIU
          </ThemedText>
          {przepis.przechowywanie && (
            <ThemedText type="default">{przepis.przechowywanie}</ThemedText>
          )}
          <ThemedText type="small" themeColor="textSecondary">
            {przepis.mozna_mrozic ? 'Można mrozić.' : 'Nie nadaje się do mrożenia.'}
          </ThemedText>
        </Karta>
      )}

      {przepis.ratunek && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            GDY COŚ PÓJDZIE NIE TAK
          </ThemedText>
          <ThemedText type="default">{przepis.ratunek}</ThemedText>
        </Karta>
      )}

      {zrobione.size > 0 && (
        <Przycisk
          tytul={`Odznacz wszystko (${zrobione.size} z ${przepis.skladniki.length + krokowRazem})`}
          wariant="poboczny"
          onPress={() => setZrobione(new Set())}
        />
      )}

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/')} />
    </Ekran>
  );
}

/**
 * Ilość tak, jak się ją odmierza.
 *
 * Przy sztukach pokazujemy jedno i drugie: „2 szt (140 g)”. Przy garnku
 * bierzesz dwie marchewki, ale gdy chcesz odważyć — masz gramy pod ręką.
 */
export function opisIlosci(s: {
  ilosc: number;
  jednostka: 'g' | 'ml' | 'szt';
  gramy: number;
}): string {
  const liczba = (x: number) =>
    (Math.round(x * 100) / 100).toString().replace('.', ',');

  if (s.jednostka === 'szt') return `${liczba(s.ilosc)} szt (${liczba(s.gramy)} g)`;
  return `${liczba(s.ilosc)} ${s.jednostka}`;
}

const styles = StyleSheet.create({
  zdjecie: {
    width: '100%',
    aspectRatio: 16 / 9,
    borderRadius: Spacing.two,
  },
  pozycja: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    paddingVertical: Spacing.one,
  },
  krok: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    paddingVertical: Spacing.two,
  },
  trescPozycji: { flex: 1, gap: 2 },
  ilosc: { minWidth: 96, textAlign: 'right' },
  wcisniete: { opacity: 0.6 },
});
