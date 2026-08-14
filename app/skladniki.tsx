import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, ScrollView, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { FormularzSkladnika } from '@/components/formularz-skladnika';
import { KomorkaEdytowalna } from '@/components/komorka-edytowalna';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import {
  pobierzSkladniki,
  pobierzUzycia,
  sprawdzSkladnik,
  usunSkladnik,
  zapiszSkladnik,
  type DaneSkladnika,
  type Skladnik,
  type UzycieSkladnika,
} from '@/lib/skladniki';

/** Definicja kolumn tabeli — szerokości muszą się zgadzać z nagłówkiem. */
const SZEROKOSC_ROZWIJANIA = 36;

const KOLUMNY = [
  { klucz: 'nazwa', tytul: 'Nazwa', szerokosc: 220, liczba: false },
  { klucz: 'kcal_100g', tytul: 'kcal', szerokosc: 64, liczba: true },
  { klucz: 'bialko_100g', tytul: 'B', szerokosc: 56, liczba: true },
  { klucz: 'tluszcz_100g', tytul: 'T', szerokosc: 56, liczba: true },
  { klucz: 'wegle_100g', tytul: 'W', szerokosc: 56, liczba: true },
  { klucz: 'cukry_wolne_100g', tytul: 'c. wolne', szerokosc: 76, liczba: true },
  { klucz: 'nova', tytul: 'NOVA', szerokosc: 60, liczba: true },
  { klucz: 'gramatura_opakowania_g', tytul: 'opak.', szerokosc: 64, liczba: true },
  { klucz: 'uzycia', tytul: 'w daniach', szerokosc: 84, liczba: true },
] as const;

type KluczKolumny = (typeof KOLUMNY)[number]['klucz'];

const SZEROKOSC_TABELI =
  KOLUMNY.reduce((s, k) => s + k.szerokosc, 0) + SZEROKOSC_ROZWIJANIA + 40; /* rozwijanie + kosz */

export default function EkranSkladnikow() {
  const motyw = useTheme();

  const [skladniki, setSkladniki] = useState<Skladnik[]>([]);
  const [uzycia, setUzycia] = useState<Map<string, UzycieSkladnika>>(new Map());
  const [szukaj, setSzukaj] = useState('');
  const [sortujPo, setSortujPo] = useState<KluczKolumny>('nazwa');
  const [malejaco, setMalejaco] = useState(false);

  const [edytowany, setEdytowany] = useState<Skladnik | null>(null);
  const [dodawanie, setDodawanie] = useState(false);
  const [doUsuniecia, setDoUsuniecia] = useState<Skladnik | null>(null);
  const [rozwiniete, setRozwiniete] = useState<Set<string>>(new Set());
  const [trybEdycji, setTrybEdycji] = useState(false);
  const [zapisywany, setZapisywany] = useState<string | null>(null);

  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const [lista, mapa] = await Promise.all([pobierzSkladniki(), pobierzUzycia()]);
      setSkladniki(lista);
      setUzycia(mapa);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, []);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  const liczbaUzyc = useCallback(
    (id: string) => uzycia.get(id)?.przepisy.length ?? 0,
    [uzycia]
  );

  const widoczne = useMemo(() => {
    const fraza = szukaj.trim().toLowerCase();

    const przefiltrowane = fraza
      ? skladniki.filter(
          (s) =>
            s.nazwa.toLowerCase().includes(fraza) ||
            s.tagi.some((t) => t.toLowerCase().includes(fraza))
        )
      : [...skladniki];

    return przefiltrowane.sort((a, b) => {
      let wynik: number;

      if (sortujPo === 'nazwa') {
        wynik = a.nazwa.localeCompare(b.nazwa, 'pl');
      } else if (sortujPo === 'uzycia') {
        wynik = liczbaUzyc(a.id) - liczbaUzyc(b.id);
      } else {
        wynik = ((a[sortujPo] as number) ?? -1) - ((b[sortujPo] as number) ?? -1);
      }

      return malejaco ? -wynik : wynik;
    });
  }, [skladniki, szukaj, sortujPo, malejaco, liczbaUzyc]);

  function przelaczRozwiniecie(id: string) {
    setRozwiniete((poprzednie) => {
      const nowe = new Set(poprzednie);
      if (nowe.has(id)) nowe.delete(id);
      else nowe.add(id);
      return nowe;
    });
  }

  function przelaczSortowanie(klucz: KluczKolumny) {
    if (klucz === sortujPo) setMalejaco((p) => !p);
    else {
      setSortujPo(klucz);
      setMalejaco(false);
    }
  }

  /**
   * Zapis pojedynczej komórki.
   *
   * Zmiana trafia najpierw na ekran, żeby nie było migotania, a dopiero potem
   * do bazy. Gdy baza odmówi, wracamy do poprzedniej wartości i pokazujemy powód.
   */
  async function zapiszKomorke(skladnik: Skladnik, pole: keyof Skladnik, tekst: string) {
    const poprzednie = skladniki;
    setBlad(null);

    const liczbowe = pole !== 'nazwa';
    let wartosc: string | number | null;

    if (liczbowe) {
      const t = tekst.replace(',', '.').trim();
      if (t === '' || t === '—') {
        wartosc = pole === 'nova' || pole === 'gramatura_opakowania_g' ? null : 0;
      } else {
        const n = Number(t);
        if (!Number.isFinite(n)) {
          setBlad(`„${tekst}” nie jest liczbą.`);
          return;
        }
        wartosc = n;
      }
    } else {
      wartosc = tekst.trim();
    }

    const zmieniony = { ...skladnik, [pole]: wartosc } as Skladnik;

    const problemy = sprawdzSkladnik(zmieniony);
    if (problemy.length > 0) {
      setBlad(problemy[0]);
      return;
    }

    setSkladniki((p) => p.map((x) => (x.id === skladnik.id ? zmieniony : x)));
    setZapisywany(skladnik.id);

    try {
      const { id, ...dane } = zmieniony;
      await zapiszSkladnik(dane as DaneSkladnika, id);
    } catch (e) {
      setSkladniki(poprzednie);
      setBlad(komunikatBledu(e));
    } finally {
      setZapisywany(null);
    }
  }

  async function usun(s: Skladnik) {
    setBlad(null);
    try {
      await usunSkladnik(s.id);
      setDoUsuniecia(null);
      pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  function wartoscKomorki(s: Skladnik, klucz: KluczKolumny): string {
    if (klucz === 'nazwa') return s.nazwa;
    if (klucz === 'uzycia') {
      const n = liczbaUzyc(s.id);
      return n === 0 ? (trybEdycji ? '' : '—') : String(n);
    }
    const w = s[klucz] as number | null;
    if (w === null || w === undefined) return trybEdycji ? '' : '—';
    return String(w);
  }

  // --- ekran edycji zamiast tabeli ---
  if (edytowany || dodawanie) {
    return (
      <Ekran tytul={edytowany ? edytowany.nazwa : 'Nowy składnik'}>
        <FormularzSkladnika
          skladnik={edytowany ?? undefined}
          onZapisano={() => {
            setEdytowany(null);
            setDodawanie(false);
            pobierz();
          }}
          onAnuluj={() => {
            setEdytowany(null);
            setDodawanie(false);
          }}
        />
      </Ekran>
    );
  }

  return (
    <Ekran
      tytul="Składniki"
      podtytul={
        wczytywanie
          ? 'wczytywanie…'
          : `${widoczne.length} z ${skladniki.length}${szukaj.trim() ? ' (filtr)' : ''}`
      }>
      <Pole
        etykieta="Filtruj po nazwie lub etykiecie"
        value={szukaj}
        onChangeText={setSzukaj}
        placeholder="dorsz, warzywo, orzechy…"
      />

      <View style={styles.paskiNarzedzi}>
        <Przycisk tytul="Dodaj składnik" onPress={() => setDodawanie(true)} style={styles.przyciskPaska} />
        <Przycisk
          tytul={trybEdycji ? 'Zakończ edycję' : 'Edytuj w tabeli'}
          wariant={trybEdycji ? 'glowny' : 'poboczny'}
          onPress={() => setTrybEdycji((p) => !p)}
          style={styles.przyciskPaska}
        />
      </View>

      {trybEdycji && (
        <Karta>
          <ThemedText type="smallBold" themeColor="accent">
            Tryb edycji w tabeli
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Dotknij komórki i wpisz wartość. Zapis następuje po opuszczeniu pola albo
            po naciśnięciu Enter. Nazwy etykiet i grupy NOVA edytujesz tak samo.
            Pełny formularz — z etykietami i źródłem danych — otworzysz po wyłączeniu
            tego trybu.
          </ThemedText>
        </Karta>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      {/* Okno potwierdzenia usunięcia — z wykazem dań, jeśli składnik jest używany. */}
      {doUsuniecia && (
        <Karta>
          {liczbaUzyc(doUsuniecia.id) > 0 ? (
            <>
              <ThemedText type="smallBold" themeColor="accent">
                Nie można usunąć: „{doUsuniecia.nazwa}”
              </ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                Składnik jest używany w {liczbaUzyc(doUsuniecia.id)}{' '}
                {liczbaUzyc(doUsuniecia.id) === 1 ? 'przepisie' : 'przepisach'}. Usunięcie
                zmieniłoby makro tych dań, więc baza na to nie pozwoli.
              </ThemedText>
              {uzycia.get(doUsuniecia.id)?.przepisy.map((p) => (
                <ThemedText key={`${p.nazwa}-${p.gramy}`} type="small">
                  • {p.nazwa} — {p.gramy} g
                </ThemedText>
              ))}
              <ThemedText type="small" themeColor="textSecondary">
                Najpierw usuń składnik z tych przepisów albo podmień go na inny.
              </ThemedText>
              <Przycisk tytul="Rozumiem" wariant="poboczny" onPress={() => setDoUsuniecia(null)} />
            </>
          ) : (
            <>
              <ThemedText type="smallBold">Usunąć „{doUsuniecia.nazwa}”?</ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                Składnik nie występuje w żadnym przepisie. Tej operacji nie da się cofnąć.
              </ThemedText>
              <Przycisk tytul="Usuń" onPress={() => usun(doUsuniecia)} />
              <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => setDoUsuniecia(null)} />
            </>
          )}
        </Karta>
      )}

      {/* Tabela — przewijana w poziomie, żeby zmieściła się na telefonie. */}
      <ScrollView horizontal showsHorizontalScrollIndicator style={styles.przewijanie}>
        <View style={{ width: SZEROKOSC_TABELI }}>
          <View style={[styles.wiersz, styles.naglowek, { borderColor: motyw.border }]}>
            <View style={styles.komorkaRozwijania} />
            {KOLUMNY.map((k) => {
              const aktywna = k.klucz === sortujPo;
              return (
                <Pressable
                  key={k.klucz}
                  onPress={() => przelaczSortowanie(k.klucz)}
                  style={[styles.komorka, { width: k.szerokosc }]}>
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
            <View style={styles.komorkaKosza} />
          </View>

          {widoczne.map((s, i) => {
            const uzyty = liczbaUzyc(s.id) > 0;
            const otwarty = rozwiniete.has(s.id);
            const tlo = i % 2 === 0 ? motyw.backgroundElement : motyw.background;

            return (
              <View key={s.id}>
                <View style={[styles.wiersz, { borderColor: motyw.border, backgroundColor: tlo }]}>
                  {/* Znak + rozwija wykaz dań; przy nieużywanym składniku nie ma czego pokazywać. */}
                  <Pressable
                    onPress={() => uzyty && przelaczRozwiniecie(s.id)}
                    disabled={!uzyty}
                    hitSlop={6}
                    accessibilityLabel={
                      uzyty ? `Pokaż dania z „${s.nazwa}”` : `${s.nazwa} nie występuje w żadnym daniu`
                    }
                    style={styles.komorkaRozwijania}>
                    {uzyty && (
                      <Ionicons
                        name={otwarty ? 'remove' : 'add'}
                        size={16}
                        color={motyw.accent}
                      />
                    )}
                  </Pressable>

                  {trybEdycji ? (
                    <View style={styles.komorki}>
                      {KOLUMNY.map((k) => (
                        <KomorkaEdytowalna
                          key={k.klucz}
                          wartosc={wartoscKomorki(s, k.klucz)}
                          szerokosc={k.szerokosc}
                          liczba={k.liczba}
                          /* Kolumna „w daniach” jest wyliczana, więc nie da się jej wpisać. */
                          edytowalna={k.klucz !== 'uzycia'}
                          onZapisz={(nowa) => zapiszKomorke(s, k.klucz as keyof Skladnik, nowa)}
                        />
                      ))}
                    </View>
                  ) : (
                    <Pressable
                      onPress={() => setEdytowany(s)}
                      style={({ pressed }) => [styles.komorki, pressed && styles.wcisniety]}>
                      {KOLUMNY.map((k) => (
                        <View key={k.klucz} style={[styles.komorka, { width: k.szerokosc }]}>
                          <ThemedText
                            type="small"
                            style={k.liczba ? styles.doPrawej : undefined}
                            numberOfLines={2}>
                            {wartoscKomorki(s, k.klucz)}
                          </ThemedText>
                        </View>
                      ))}
                    </Pressable>
                  )}

                  {zapisywany === s.id ? (
                    <View style={styles.komorkaKosza}>
                      <Ionicons name="sync" size={16} color={motyw.accent} />
                    </View>
                  ) : (
                    <Pressable
                      onPress={() => setDoUsuniecia(s)}
                      hitSlop={8}
                      accessibilityLabel={`Usuń ${s.nazwa}`}
                      style={styles.komorkaKosza}>
                      <Ionicons
                        name="trash-outline"
                        size={16}
                        color={uzyty ? motyw.border : motyw.textSecondary}
                      />
                    </Pressable>
                  )}
                </View>

                {otwarty && (
                  <View
                    style={[
                      styles.rozwiniecie,
                      { borderColor: motyw.border, backgroundColor: motyw.backgroundSelected },
                    ]}>
                    <ThemedText type="smallBold" themeColor="textSecondary">
                      UŻYTY W DANIACH
                    </ThemedText>
                    {uzycia.get(s.id)?.przepisy.map((p) => (
                      <ThemedText key={`${p.nazwa}-${p.gramy}`} type="small">
                        • {p.nazwa} — {p.gramy} g
                      </ThemedText>
                    ))}
                  </View>
                )}
              </View>
            );
          })}
        </View>
      </ScrollView>

      {!wczytywanie && widoczne.length === 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          Nic nie pasuje do wpisanej frazy.
        </ThemedText>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        Wszystkie wartości na 100 g. Dotknij nagłówka, aby posortować; znaku plus — aby
        zobaczyć dania, w których składnik występuje.
        {trybEdycji
          ? ' Komórki są teraz polami do wpisywania.'
          : ' Dotknij wiersza, aby otworzyć pełny formularz.'}
        {' '}B — białko, T — tłuszcz, W — węglowodany.
      </ThemedText>

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => router.back()} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  paskiNarzedzi: {
    flexDirection: 'row',
    gap: Spacing.two,
  },
  przyciskPaska: { flex: 1 },
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
  naglowek: {
    borderBottomWidth: 2,
  },
  komorka: {
    paddingHorizontal: Spacing.one,
    paddingVertical: Spacing.one,
    justifyContent: 'center',
  },
  komorki: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  komorkaRozwijania: {
    width: SZEROKOSC_ROZWIJANIA,
    alignItems: 'center',
    justifyContent: 'center',
    alignSelf: 'stretch',
  },
  rozwiniecie: {
    borderBottomWidth: 1,
    paddingVertical: Spacing.two,
    paddingHorizontal: Spacing.three,
    paddingLeft: SZEROKOSC_ROZWIJANIA + Spacing.two,
    gap: 2,
  },
  komorkaKosza: {
    width: 40,
    alignItems: 'center',
    justifyContent: 'center',
  },
  doPrawej: { textAlign: 'right' },
  wcisniety: { opacity: 0.7 },
});
