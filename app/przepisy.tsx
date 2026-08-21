import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router, useFocusEffect } from 'expo-router';
import { useCallback, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { WierszMakro } from '@/components/wiersz-makro';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import {
  czasRazem,
  KATEGORIE,
  OPIS_KATEGORII,
  OPIS_KUCHNI,
  OPIS_PORY,
  opisTrwalosci,
  odrzucPrzepis,
  pobierzPrzepisy,
  ustawPreferencje,
  zatwierdzPrzepis,
  type PoraPosilku,
  type Preferencja,
  type PrzepisZMakro,
} from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { adresZdjecia } from '@/lib/zdjecia';
import { supabase } from '@/lib/supabase';

/**
 * Tekst do porównywania — bez wielkich liter i bez ogonków.
 *
 * Dzięki temu „zurek” znajduje „Żurek”, a „lopatka” — „Łopatkę”. Przy szukaniu
 * jedzenia nikt nie przełącza się na polską klawiaturę, a i tak każdy błąd
 * ogonka kończyłby się pustą listą.
 */
function doPorownania(tekst: string): string {
  return tekst
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/ł/g, 'l')
    .replace(/Ł/g, 'L')
    .toLowerCase();
}

export default function EkranPrzepisow() {
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [przepisy, setPrzepisy] = useState<PrzepisZMakro[]>([]);
  const [rola, setRola] = useState<string | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  /** `null` oznacza „wszystkie kategorie”. */
  const [kategoria, setKategoria] = useState<PoraPosilku | null>(null);

  /** Szukana fraza. Pusta = bez filtrowania. */
  const [fraza, setFraza] = useState('');

  /** Kolejka moderatora — zamiast kategorii pokazujemy zgłoszone przepisy. */
  const [kolejka, setKolejka] = useState(false);
  /** Przepis, który moderator właśnie odrzuca, i pisane uzasadnienie. */
  const [odrzucany, setOdrzucany] = useState<string | null>(null);
  const [powod, setPowod] = useState('');

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);

    // Rola pobierana niezależnie od przepisów. Gdyby lista się nie wczytała,
    // przycisk dodawania i tak ma się pojawić — inaczej jeden błąd ukrywa drugą rzecz.
    supabase
      .from('konta')
      .select('rola')
      .single()
      .then(({ data, error }) => {
        if (!error && data) setRola(data.rola);
      });

    try {
      setPrzepisy(await pobierzPrzepisy(sesja?.user.id));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [sesja?.user.id]);

  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

  /**
   * Ustawia preferencję. Dotknięcie już aktywnego poziomu cofa do „neutralne” —
   * to jedyny sposób wrócić do stanu bez wiersza w bazie, skoro sam poziom
   * nie ma osobnego przycisku „wyczyść”.
   */
  async function przelaczPreferencje(p: PrzepisZMakro, poziom: Preferencja) {
    if (!sesja) return;
    const nowy: Preferencja = p.preferencja === poziom ? 'neutralne' : poziom;

    // Zmiana widoczna od razu, zanim baza potwierdzi.
    setPrzepisy((poprzednie) =>
      poprzednie.map((x) => (x.id === p.id ? { ...x, preferencja: nowy } : x))
    );

    try {
      await ustawPreferencje(p.id, sesja.user.id, nowy);
    } catch (e) {
      setBlad(komunikatBledu(e));
      pobierz(); // nie udało się — wracamy do stanu z bazy
    }
  }

  const mozeDodawac = rola === 'moderator' || rola === 'administrator';

  /**
   * Filtrowanie frazą idzie PRZED zakładkami kategorii, a nie po nich.
   *
   * Dzięki temu liczby przy zakładkach pokazują, ile pasujących przepisów
   * siedzi w każdej kategorii. Gdyby było odwrotnie, wpisanie „dorsz” przy
   * wybranych „Obiadach” dawałoby pustą listę i żadnej podpowiedzi, że
   * szukane danie leży w „Kolacjach”.
   */
  const szukane = doPorownania(fraza.trim());

  const poFrazie = useMemo(() => {
    if (!szukane) return przepisy;
    return przepisy.filter((p) => {
      const tekst = [
        p.nazwa,
        p.opis ?? '',
        ...p.kuchnie.map((x) => OPIS_KUCHNI[x]),
        ...p.pory.map((x) => OPIS_PORY[x]),
      ].join(' ');
      return doPorownania(tekst).includes(szukane);
    });
  }, [przepisy, szukane]);

  // Przepis bez kategorii nie znika — trafia do „Bez kategorii”. Inaczej
  // dodany w pośpiechu przepis przepadałby z widoku i nie dałoby się go poprawić.
  const bezKategorii = poFrazie.filter((p) => p.pory.length === 0);
  const licznik = (k: PoraPosilku) => poFrazie.filter((p) => p.pory.includes(k)).length;

  /** Ile przepisów czeka na decyzję. Liczone z całej listy, nie z przefiltrowanej. */
  const doZatwierdzenia = przepisy.filter((p) => p.widocznosc === 'zgloszona');

  const widoczne = kolejka
    ? poFrazie
        .filter((p) => p.widocznosc === 'zgloszona')
        .sort((a, b) => (a.zgloszono_kiedy ?? '').localeCompare(b.zgloszono_kiedy ?? ''))
    : kategoria === null
      ? poFrazie
      : poFrazie.filter((p) => p.pory.includes(kategoria));

  return (
    <Ekran
      tytul="Przepisy"
      podtytul={
        wczytywanie
          ? 'wczytywanie…'
          : szukane
            ? `${widoczne.length} z ${przepisy.length}`
            : `${przepisy.length} w bazie`
      }>
      {przepisy.length > 0 && (
        <View style={styles.szukanie}>
          <View style={styles.polePola}>
            <Pole
              etykieta="Szukaj przepisu"
              value={fraza}
              onChangeText={setFraza}
              placeholder="dorsz, tom kha, zupa…"
              autoCorrect={false}
              autoCapitalize="none"
              // Krzyżyk czyszczący pola na iOS. Na pozostałych platformach
              // pomijany, dlatego niżej jest jeszcze własny przycisk.
              clearButtonMode="while-editing"
            />
          </View>
          {fraza.length > 0 && (
            <Pressable
              onPress={() => setFraza('')}
              hitSlop={8}
              accessibilityRole="button"
              accessibilityLabel="Wyczyść szukanie"
              style={({ pressed }) => [styles.wyczysc, pressed && styles.wcisniety]}>
              <Ionicons name="close-circle" size={22} color={motyw.textSecondary} />
            </Pressable>
          )}
        </View>
      )}

      {przepisy.length > 0 && (
        <View style={styles.zakladki}>
          {[null, ...KATEGORIE].map((k) => {
            const wybrana = kategoria === k;
            const etykieta = k === null ? 'Wszystkie' : OPIS_KATEGORII[k];
            const ile = k === null ? poFrazie.length : licznik(k);
            return (
              <Pressable
                key={k ?? 'wszystkie'}
                onPress={() => {
                  setKategoria(k);
                  setKolejka(false);
                }}
                accessibilityRole="button"
                accessibilityState={{ selected: wybrana }}
                accessibilityLabel={`${etykieta}, ${ile}`}
                style={[
                  styles.zakladka,
                  { borderColor: wybrana ? motyw.accent : motyw.border },
                  wybrana && styles.zakladkaWybrana,
                ]}>
                <ThemedText
                  type="smallBold"
                  themeColor={wybrana ? 'accent' : 'textSecondary'}>
                  {etykieta} {ile}
                </ThemedText>
              </Pressable>
            );
          })}

          {/*
            Kolejka moderatora stoi OBOK kategorii, a nie w osobnym miejscu.
            Przepisy przegląda się tutaj, więc i decyzje o nich zapadają tutaj.
            Zakładka pokazuje się tylko wtedy, gdy jest co rozpatrywać — pusta
            uczyłaby, że zwykle nic w niej nie ma, i przestałaby być zauważana.
          */}
          {mozeDodawac && doZatwierdzenia.length > 0 && (
            <Pressable
              onPress={() => setKolejka((x) => !x)}
              accessibilityRole="button"
              accessibilityState={{ selected: kolejka }}
              accessibilityLabel={`Do zatwierdzenia, ${doZatwierdzenia.length}`}
              style={[
                styles.zakladka,
                { borderColor: motyw.accent, borderWidth: kolejka ? 2 : 1 },
              ]}>
              <ThemedText type="smallBold" themeColor="accent">
                Do zatwierdzenia {doZatwierdzenia.length}
              </ThemedText>
            </Pressable>
          )}
        </View>
      )}

      {kategoria !== null && bezKategorii.length > 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          {bezKategorii.length} {bezKategorii.length === 1 ? 'przepis nie ma' : 'przepisów nie ma'}
          {' '}przypisanej kategorii — zobaczysz je w „Wszystkie”.
        </ThemedText>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            Nie udało się wczytać: {blad}
          </ThemedText>
        </Karta>
      )}

      {!wczytywanie && przepisy.length === 0 && (
        <Karta>
          <ThemedText type="default">Baza przepisów jest pusta</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Składniki są już wczytane, więc makro policzy się samo — wystarczy podać, ile
            czego wchodzi w skład dania.
          </ThemedText>
        </Karta>
      )}

      {!wczytywanie && przepisy.length > 0 && poFrazie.length === 0 && szukane !== '' && (
        <Karta>
          <ThemedText type="default">Nic nie pasuje do „{fraza.trim()}”</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Szukam w nazwie, opisie, kuchni i kategorii. Ogonki i wielkość liter nie mają
            znaczenia.
          </ThemedText>
          <Przycisk tytul="Wyczyść szukanie" wariant="poboczny" onPress={() => setFraza('')} />
        </Karta>
      )}

      {!wczytywanie &&
        poFrazie.length > 0 &&
        widoczne.length === 0 &&
        kategoria !== null && (
          <Karta>
            <ThemedText type="default">
              Brak przepisów w kategorii „{OPIS_KATEGORII[kategoria]}”
              {szukane ? ` dla frazy „${fraza.trim()}”` : ''}
            </ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {szukane
                ? 'Coś pasuje, ale w innej kategorii — sprawdź liczby przy zakładkach powyżej.'
                : kategoria === 'dodatek'
                  ? 'Dodatek to coś, co dokładasz do posiłku — grillowana pierś, surówka, sałatka z ciecierzycy. Przy wyborze dania pojawia się przy każdym posiłku.'
                  : 'Kategorię ustawiasz w formularzu przepisu, w polu „Kategoria”. Przepis może należeć do kilku naraz.'}
            </ThemedText>
          </Karta>
        )}

      {widoczne.map((p) => {
        const zdjecie = adresZdjecia(p.zdjecie);
        return (
        <Karta key={p.id}>
          {zdjecie && (
            <Image
              source={{ uri: zdjecie }}
              style={styles.zdjecie}
              contentFit="cover"
              transition={150}
              accessibilityLabel={p.nazwa}
            />
          )}
          <View style={styles.naglowek}>
            <ThemedText type="default" style={styles.nazwa}>
              {p.nazwa}
            </ThemedText>
            {p.widocznosc !== 'publiczna' && (
              <ThemedText type="small" themeColor="textSecondary">
                {p.widocznosc === 'prywatna' ? 'prywatny' : 'zgłoszony'}
              </ThemedText>
            )}
          </View>

          {p.opis && (
            <ThemedText type="small" themeColor="textSecondary">
              {p.opis}
            </ThemedText>
          )}

          <ThemedText type="small" themeColor="textSecondary">
            {p.pory.map((x) => OPIS_PORY[x]).join(', ') || 'bez kategorii'}
            {' · '}
            {p.kuchnie.map((x) => OPIS_KUCHNI[x]).join(', ')}
            {(() => {
              const razem = czasRazem(p.czas_przygotowania_min, p.czas_obrobki_min);
              return razem ? ` · ${razem} min` : '';
            })()}
            {' · '}
            {opisTrwalosci(p.trwalosc_dni)}
            {p.mozna_mrozic ? ' · można mrozić' : ''}
          </ThemedText>

          {p.kcal !== null ? (
            <>
              <ThemedText type="smallBold" themeColor="textSecondary">
                NA PORCJĘ
                {p.gramy_porcji ? ` (${p.gramy_porcji} g)` : ''}
                {p.porcje_wyliczone ? ` · z ${p.porcje_wyliczone} porcji` : ''}
              </ThemedText>
              <WierszMakro
                pozycje={[
                  { etykieta: 'kcal', wartosc: p.kcal, jednostka: '' },
                  { etykieta: 'białko', wartosc: p.bialko_g ?? 0, jednostka: ' g' },
                  { etykieta: 'tłuszcz', wartosc: p.tluszcz_g ?? 0, jednostka: ' g' },
                  { etykieta: 'węgle', wartosc: p.wegle_g ?? 0, jednostka: ' g' },
                ]}
              />
              {p.kcal_calosc !== null && (
                <ThemedText type="small" themeColor="textSecondary">
                  Cała potrawa: {p.gramy_calosc ? `${p.gramy_calosc} g, ` : ''}
                  {p.kcal_calosc} kcal, {p.bialko_g_calosc} g białka
                </ThemedText>
              )}
            </>
          ) : (
            <ThemedText type="small" themeColor="accent">
              Brak składników — nie ma z czego policzyć makro.
            </ThemedText>
          )}

          {/*
            Decyzja moderatora zapada przy przepisie, nie na osobnym ekranie.
            Żeby ją podjąć, trzeba widzieć makro i skład — a to jest właśnie tu.
          */}
          {mozeDodawac && p.widocznosc === 'zgloszona' && (
            <View style={[styles.moderacja, { borderColor: motyw.accent }]}>
              <ThemedText type="smallBold" themeColor="accent">
                Czeka na decyzję
              </ThemedText>

              {odrzucany === p.id ? (
                <>
                  <Pole
                    etykieta="Co autor ma poprawić"
                    value={powod}
                    onChangeText={setPowod}
                    placeholder="Brakuje gramatury przy dwóch składnikach."
                    multiline
                  />
                  <ThemedText type="small" themeColor="textSecondary">
                    Bez uzasadnienia autor zgłosi to samo drugi raz.
                  </ThemedText>
                  <Przycisk
                    tytul="Odeślij do poprawki"
                    wariant="poboczny"
                    wylaczony={powod.trim().length < 3}
                    onPress={async () => {
                      setBlad(null);
                      try {
                        await odrzucPrzepis(p.id, powod);
                        setOdrzucany(null);
                        setPowod('');
                        await pobierz();
                      } catch (e) {
                        setBlad(komunikatBledu(e));
                      }
                    }}
                  />
                  <Przycisk
                    tytul="Anuluj"
                    wariant="poboczny"
                    onPress={() => {
                      setOdrzucany(null);
                      setPowod('');
                    }}
                  />
                </>
              ) : (
                <View style={styles.decyzje}>
                  <View style={styles.decyzja}>
                    <Przycisk
                      tytul="Zatwierdź"
                      onPress={async () => {
                        setBlad(null);
                        try {
                          await zatwierdzPrzepis(p.id);
                          await pobierz();
                        } catch (e) {
                          setBlad(komunikatBledu(e));
                        }
                      }}
                    />
                  </View>
                  <View style={styles.decyzja}>
                    <Przycisk
                      tytul="Do poprawki"
                      wariant="poboczny"
                      onPress={() => {
                        setOdrzucany(p.id);
                        setPowod('');
                      }}
                    />
                  </View>
                </View>
              )}
            </View>
          )}

          <View style={styles.stopka}>
            {p.cukry_wolne_g !== null && p.cukry_wolne_g > 0 && (
              <ThemedText type="small" themeColor="textSecondary">
                cukry wolne: {p.cukry_wolne_g} g
              </ThemedText>
            )}

            {(mozeDodawac || (p.autor_id === sesja?.user.id && p.widocznosc === 'prywatna')) && (
              <Pressable
                onPress={() =>
                  router.push({
                    pathname: '/przepis-formularz',
                    params: { id: p.id, powrot: '/przepisy' },
                  })
                }
                hitSlop={8}
                accessibilityLabel={`Edytuj ${p.nazwa}`}
                style={styles.edytuj}>
                <Ionicons name="create-outline" size={18} color={motyw.textSecondary} />
              </Pressable>
            )}

            <View style={styles.preferencje}>
              {(
                [
                  { poziom: 'ulubione', ikona: 'star', ikonaPusta: 'star-outline', etykieta: 'Ulubione — chcę jeść często' },
                  { poziom: 'lubie', ikona: 'heart', ikonaPusta: 'heart-outline', etykieta: 'Lubię — chętnie zjem ponownie' },
                  { poziom: 'nie_proponuj', ikona: 'close-circle', ikonaPusta: 'close-circle-outline', etykieta: 'Nie proponuj — nie chcę tego dania' },
                ] as const
              ).map((opcja) => {
                const aktywna = p.preferencja === opcja.poziom;
                return (
                  <Pressable
                    key={opcja.poziom}
                    onPress={() => przelaczPreferencje(p, opcja.poziom)}
                    hitSlop={6}
                    accessibilityRole="button"
                    accessibilityState={{ selected: aktywna }}
                    accessibilityLabel={opcja.etykieta}
                    style={({ pressed }) => [styles.preferencja, pressed && styles.wcisniety]}>
                    <Ionicons
                      name={aktywna ? opcja.ikona : opcja.ikonaPusta}
                      size={20}
                      color={aktywna ? motyw.accent : motyw.textSecondary}
                    />
                  </Pressable>
                );
              })}
            </View>
          </View>
        </Karta>
        );
      })}

      {mozeDodawac && (
        <>
          <Przycisk
            tytul="Dodaj przepis"
            onPress={() =>
              router.push({
                pathname: '/przepis-formularz',
                params: { powrot: '/przepisy' },
              })
            }
          />
          <Przycisk
            tytul="Składniki"
            wariant="poboczny"
            onPress={() =>
              router.push({ pathname: '/skladniki', params: { powrot: '/przepisy' } })
            }
          />
          <Przycisk
            tytul="Import / eksport (Excel)"
            wariant="poboczny"
            onPress={() =>
              router.push({
                pathname: '/przepisy-import-eksport',
                params: { powrot: '/przepisy' },
              })
            }
          />
        </>
      )}

      {!mozeDodawac && !wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          Dodawanie przepisów wymaga uprawnień moderatora.
        </ThemedText>
      )}
    </Ekran>
  );
}

const styles = StyleSheet.create({
  szukanie: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    gap: Spacing.two,
  },
  polePola: { flex: 1 },
  wyczysc: {
    height: 46,
    alignItems: 'center',
    justifyContent: 'center',
  },
  zakladki: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
    paddingBottom: Spacing.one,
  },
  zakladka: {
    borderWidth: 1,
    borderRadius: 999,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  zakladkaWybrana: { opacity: 1 },
  zdjecie: {
    width: '100%',
    aspectRatio: 16 / 9,
    borderRadius: Spacing.two,
    marginBottom: Spacing.one,
  },
  naglowek: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  nazwa: { flex: 1 },
  moderacja: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
    marginTop: Spacing.one,
  },
  decyzje: { flexDirection: 'row', gap: Spacing.two },
  decyzja: { flex: 1 },
  stopka: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
    paddingTop: Spacing.one,
  },
  edytuj: {
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
    marginLeft: 'auto',
  },
  preferencje: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    marginLeft: 'auto',
  },
  preferencja: {
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.half,
  },
  wcisniety: { opacity: 0.6 },
});
