import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, ScrollView, StyleSheet, useWindowDimensions, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { OPIS_KUCHNI, OPIS_PORY, pobierzPrzepisy, ustawSkalowalny, type PrzepisZMakro } from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';

/**
 * Zestawienie makro wszystkich przepisów w jednej tabeli — do szybkiego
 * porównania dań, bez otwierania każdego z osobna.
 *
 * Wartości makro są NA JEDNĄ PORCJĘ — tak samo jak wszędzie indziej w
 * Talerzu (ekran przepisu, plan dnia). Liczy je baza, widok `przepis_makro`
 * (patrz `lib/przepisy.ts`) — tu tylko czytamy i sortujemy.
 */

const KOLUMNY = [
  { klucz: 'nazwa', tytul: 'Nazwa', szerokosc: 220, liczba: false },
  { klucz: 'kategoria', tytul: 'Kategoria', szerokosc: 140, liczba: false },
  { klucz: 'kuchnia', tytul: 'Kuchnia', szerokosc: 130, liczba: false },
  { klucz: 'liczba_porcji_bazowych', tytul: 'porcje baz.', szerokosc: 78, liczba: true },
  { klucz: 'kcal', tytul: 'kcal', szerokosc: 60, liczba: true },
  { klucz: 'bialko_g', tytul: 'białko', szerokosc: 62, liczba: true },
  { klucz: 'wegle_g', tytul: 'węgle', szerokosc: 62, liczba: true },
  { klucz: 'tluszcz_g', tytul: 'tłuszcz', szerokosc: 62, liczba: true },
  { klucz: 'blonnik_g', tytul: 'błonnik', szerokosc: 62, liczba: true },
  { klucz: 'trwalosc_dni', tytul: 'dni w lodówce', szerokosc: 90, liczba: true },
  { klucz: 'skalowalny', tytul: 'skalowalny', szerokosc: 80, liczba: false },
] as const;

type KluczKolumny = (typeof KOLUMNY)[number]['klucz'];

const SZEROKOSC_TABELI = KOLUMNY.reduce((s, k) => s + k.szerokosc, 0) + 24;
const MIN_NAZWY = 180;

/** Kuchnie przepisu jako tekst — do wyświetlenia i do sortowania. */
function tekstKuchni(p: PrzepisZMakro): string {
  return p.kuchnie.map((k) => OPIS_KUCHNI[k]).join(', ');
}

/** Kategorie (pory) przepisu jako tekst — do wyświetlenia i do sortowania. */
function tekstKategorii(p: PrzepisZMakro): string {
  return p.pory.map((k) => OPIS_PORY[k]).join(', ');
}

function tekstKomorki(p: PrzepisZMakro, klucz: KluczKolumny): string {
  if (klucz === 'nazwa') return p.nazwa;
  if (klucz === 'kategoria') return tekstKategorii(p) || '—';
  if (klucz === 'kuchnia') return tekstKuchni(p) || '—';
  if (klucz === 'liczba_porcji_bazowych') return String(p.liczba_porcji_bazowych);
  if (klucz === 'trwalosc_dni') return String(p.trwalosc_dni);
  if (klucz === 'skalowalny') return p.skalowalny ? 'tak' : 'nie';

  const w = p[klucz];
  if (w === null || w === undefined) return '—';
  return klucz === 'kcal' ? String(Math.round(w)) : String(Math.round(w * 10) / 10);
}

export default function EkranPrzepisyMakro() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();
  const motyw = useTheme();
  const { width: szerokoscOkna } = useWindowDimensions();

  const [przepisy, setPrzepisy] = useState<PrzepisZMakro[]>([]);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);
  const [szukaj, setSzukaj] = useState('');
  const [sortujPo, setSortujPo] = useState<KluczKolumny>('nazwa');
  const [malejaco, setMalejaco] = useState(false);
  const [zapisywany, setZapisywany] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      setPrzepisy(await pobierzPrzepisy(sesja?.user.id));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [sesja?.user.id]);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  /**
   * Zmienia checkbox „skalowalny" wprost z tabeli, bez otwierania formularza.
   *
   * Optymistycznie na ekranie od razu, zapis do bazy potem — przy odmowie
   * bazy wraca poprzednia wartość, tak jak w pozostałych tabelach Talerza.
   */
  async function przelaczSkalowalny(p: PrzepisZMakro) {
    setBlad(null);
    const nowaWartosc = !p.skalowalny;
    setPrzepisy((lista) => lista.map((x) => (x.id === p.id ? { ...x, skalowalny: nowaWartosc } : x)));
    setZapisywany(p.id);
    try {
      await ustawSkalowalny(p.id, nowaWartosc);
    } catch (e) {
      setPrzepisy((lista) => lista.map((x) => (x.id === p.id ? { ...x, skalowalny: p.skalowalny } : x)));
      setBlad(komunikatBledu(e));
    } finally {
      setZapisywany(null);
    }
  }

  function przelaczSortowanie(klucz: KluczKolumny) {
    if (klucz === sortujPo) setMalejaco((p) => !p);
    else {
      setSortujPo(klucz);
      setMalejaco(false);
    }
  }

  const widoczne = useMemo(() => {
    const fraza = szukaj.trim().toLowerCase();
    const przefiltrowane = fraza ? przepisy.filter((p) => p.nazwa.toLowerCase().includes(fraza)) : [...przepisy];

    return przefiltrowane.sort((a, b) => {
      let wynik: number;
      if (sortujPo === 'nazwa') {
        wynik = a.nazwa.localeCompare(b.nazwa, 'pl');
      } else if (sortujPo === 'kategoria') {
        wynik = tekstKategorii(a).localeCompare(tekstKategorii(b), 'pl');
      } else if (sortujPo === 'kuchnia') {
        wynik = tekstKuchni(a).localeCompare(tekstKuchni(b), 'pl');
      } else if (sortujPo === 'skalowalny') {
        wynik = Number(a.skalowalny) - Number(b.skalowalny);
      } else {
        wynik = ((a[sortujPo] as number | null) ?? -1) - ((b[sortujPo] as number | null) ?? -1);
      }
      return malejaco ? -wynik : wynik;
    });
  }, [przepisy, szukaj, sortujPo, malejaco]);

  const miesciSie = szerokoscOkna >= SZEROKOSC_TABELI + 64;
  const stylKolumny = (k: (typeof KOLUMNY)[number]) =>
    miesciSie && k.klucz === 'nazwa' ? { flex: 1, minWidth: MIN_NAZWY } : { width: k.szerokosc };

  return (
    <Ekran
      pelnaSzerokosc
      tytul="Makro przepisów"
      podtytul={
        wczytywanie
          ? 'wczytywanie…'
          : `${widoczne.length} z ${przepisy.length}${szukaj.trim() ? ' (filtr)' : ''} — wartości na jedną porcję`
      }>
      <Pole
        etykieta="Filtruj po nazwie"
        value={szukaj}
        onChangeText={setSzukaj}
        placeholder="zupa, kasza, sałatka…"
      />

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <ScrollView
        horizontal={!miesciSie}
        showsHorizontalScrollIndicator={!miesciSie}
        style={styles.przewijanie}>
        <View style={{ width: miesciSie ? '100%' : SZEROKOSC_TABELI }}>
          <View style={[styles.wiersz, styles.naglowek, { borderColor: motyw.border }]}>
            {KOLUMNY.map((k) => {
              const aktywna = k.klucz === sortujPo;
              return (
                <Pressable
                  key={k.klucz}
                  onPress={() => przelaczSortowanie(k.klucz)}
                  style={[styles.komorka, stylKolumny(k)]}>
                  <ThemedText
                    type="smallBold"
                    themeColor={aktywna ? 'accent' : 'textSecondary'}
                    style={k.liczba ? styles.doPrawej : undefined}
                    numberOfLines={1}>
                    {k.tytul}
                    {aktywna ? (malejaco ? ' ↓' : ' ↑') : ''}
                  </ThemedText>
                </Pressable>
              );
            })}
          </View>

          {widoczne.map((p, i) => (
            <View
              key={p.id}
              style={[
                styles.wiersz,
                {
                  borderColor: motyw.border,
                  backgroundColor: i % 2 === 0 ? motyw.backgroundElement : motyw.background,
                },
              ]}>
              {KOLUMNY.map((k) =>
                k.klucz === 'skalowalny' ? (
                  <Pressable
                    key={k.klucz}
                    onPress={() => przelaczSkalowalny(p)}
                    disabled={zapisywany === p.id}
                    accessibilityRole="checkbox"
                    accessibilityState={{ checked: p.skalowalny }}
                    accessibilityLabel={`Można skalować kalorycznie: ${p.nazwa}`}
                    style={[styles.komorka, styles.komorkaSrodek, stylKolumny(k)]}>
                    <Ionicons
                      name={p.skalowalny ? 'checkbox' : 'square-outline'}
                      size={20}
                      color={p.skalowalny ? motyw.accent : motyw.textSecondary}
                    />
                  </Pressable>
                ) : (
                  <View key={k.klucz} style={[styles.komorka, stylKolumny(k)]}>
                    <ThemedText type="small" style={k.liczba ? styles.doPrawej : undefined} numberOfLines={2}>
                      {tekstKomorki(p, k.klucz)}
                    </ThemedText>
                  </View>
                )
              )}
            </View>
          ))}
        </View>
      </ScrollView>

      {!wczytywanie && widoczne.length === 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          Nic nie pasuje do wpisanej frazy.
        </ThemedText>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        Dotknij nagłówka, aby posortować. Wartości puste (—) oznaczają przepis bez policzonego
        makro — zwykle brak zapisanych składników. Kolumna „skalowalny" — dotknij, żeby
        przełączyć: czy automat wypełniający plan wolno mu rozciągać ten przepis pod cel
        kaloryczny posiłku.
      </ThemedText>

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  przewijanie: {
    marginHorizontal: -Spacing.three,
    paddingHorizontal: Spacing.three,
  },
  wiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    borderBottomWidth: 1,
    minHeight: 40,
  },
  naglowek: { borderBottomWidth: 2 },
  komorka: {
    paddingHorizontal: Spacing.one,
    paddingVertical: Spacing.one,
    justifyContent: 'center',
  },
  komorkaSrodek: { alignItems: 'center' },
  doPrawej: { textAlign: 'right' },
});
