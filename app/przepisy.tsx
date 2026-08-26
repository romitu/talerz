import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { router, useFocusEffect } from 'expo-router';
import { useCallback, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { NaglowekPrzepisow, type ZakladkaPrzepisow } from '@/components/naglowek-przepisow';
import { ThemedView } from '@/components/themed-view';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
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
  ukryjPrzepis,
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

/**
 * Skrócone etykiety zakładek kategorii — tylko na te pigułki w nagłówku.
 * Pełne nazwy (`OPIS_KATEGORII`) zostają wszędzie indziej (komunikaty,
 * formularz przepisu) — tam nie ma problemu z miejscem w jednej linii.
 */
const SKROT_KATEGORII: Record<PoraPosilku, string> = {
  sniadanie: 'Śniad.',
  obiad: 'Obiad',
  kolacja: 'Kolacj.',
  dodatek: 'Dodat.',
};

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

  /** Przepis, który ktoś właśnie chce skasować — potwierdzenie przed usunięciem. */
  const [doUsuniecia, setDoUsuniecia] = useState<PrzepisZMakro | null>(null);
  const [usuwanie, setUsuwanie] = useState(false);

  /**
   * Dymek z wyjaśnieniem ikony preferencji — `id przepisu:poziom` albo `null`.
   * Na dotyk (telefon) i tak się nie pojawi, bo tam nie ma najechania myszką —
   * tam wyjaśnienie niesie sam `accessibilityLabel` czytany przez czytnik ekranu.
   */
  const [dymek, setDymek] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);

    // Rola pobierana niezależnie od przepisów. Gdyby lista się nie wczytała,
    // przycisk dodawania i tak ma się pojawić — inaczej jeden błąd ukrywa drugą rzecz.
    supabase
      .from('konta')
      .select('rola')
      .eq('id', sesja?.user.id)
      .single()
      .then(({ data, error }) => {
        if (error) setBlad((poprzedni) => poprzedni ?? error.message);
        else if (data) setRola(data.rola);
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

  /** Kto wolno edytować, wolno też usuwać — ta sama zasada co przy ołówku niżej. */
  function mozeUsuwac(p: PrzepisZMakro): boolean {
    return mozeDodawac || (p.autor_id === sesja?.user.id && p.widocznosc !== 'publiczna');
  }

  async function usunPrzepis(p: PrzepisZMakro) {
    setUsuwanie(true);
    setBlad(null);
    try {
      const { error } = await supabase.from('przepisy').delete().eq('id', p.id);
      if (error) throw error;
      setDoUsuniecia(null);
      await pobierz();
    } catch (e) {
      // Kod 23503 — przepis jest wpięty w plan posiłków albo w ugotowaną
      // partię (klucz obcy z `on delete restrict`, celowo, żeby nie znikał
      // spod nóg z planu, który ktoś właśnie realizuje).
      const kod = (e as { code?: string })?.code;
      setBlad(
        kod === '23503'
          ? `Nie można usunąć „${p.nazwa}” — jest użyty w czyimś planie posiłków albo w ugotowanej partii. Usuń go najpierw stamtąd.`
          : komunikatBledu(e)
      );
    } finally {
      setUsuwanie(false);
    }
  }

  /**
   * Szybki przełącznik publiczny/prywatny dla moderatora — poza kolejką
   * zgłoszeń, żeby dało się cofnąć publikację albo opublikować coś wprost,
   * bez przechodzenia przez obieg „zgłoszenie → decyzja”.
   */
  async function przelaczWidocznosc(p: PrzepisZMakro) {
    setBlad(null);
    try {
      if (p.widocznosc === 'publiczna') await ukryjPrzepis(p.id);
      else await zatwierdzPrzepis(p.id);
      await pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

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

  // Zakładki: „Wszystkie" + jedna na kategorię, a na końcu — tylko gdy jest co
  // rozpatrywać — kolejka moderatora. Przepisy przegląda się tutaj, więc
  // i decyzje o nich zapadają tutaj, obok zwykłych filtrów.
  const zakladki: ZakladkaPrzepisow[] = przepisy.length === 0
    ? []
    : [
        {
          klucz: 'wszystkie',
          etykieta: 'Wszyst.',
          ile: poFrazie.length,
          wybrana: kategoria === null,
          onPress: () => {
            setKategoria(null);
            setKolejka(false);
          },
        },
        ...KATEGORIE.map((k) => ({
          klucz: k,
          etykieta: SKROT_KATEGORII[k],
          ile: licznik(k),
          wybrana: kategoria === k,
          onPress: () => {
            setKategoria(k);
            setKolejka(false);
          },
        })),
        ...(mozeDodawac && doZatwierdzenia.length > 0
          ? [
              {
                klucz: 'kolejka',
                etykieta: 'Do zatwierdzenia',
                ile: doZatwierdzenia.length,
                wybrana: kolejka,
                akcent: true,
                onPress: () => setKolejka((x) => !x),
              },
            ]
          : []),
      ];

  return (
    <Ekran
      tytul="Przepisy"
      naglowekStaly={
        <NaglowekPrzepisow
          liczbaWBazie={przepisy.length}
          fraza={fraza}
          onZmianaFrazy={setFraza}
          zakladki={zakladki}
        />
      }>
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
        const razem = czasRazem(p.czas_przygotowania_min, p.czas_obrobki_min);

        const tagi: { klucz: string; ikona: keyof typeof Ionicons.glyphMap; tekst: string }[] = [
          {
            klucz: 'pora',
            ikona: 'restaurant-outline',
            tekst: p.pory.map((x) => OPIS_PORY[x]).join(', ') || 'bez kategorii',
          },
          ...(p.kuchnie.length > 0
            ? [{ klucz: 'kuchnia', ikona: 'earth-outline' as const, tekst: p.kuchnie.map((x) => OPIS_KUCHNI[x]).join(', ') }]
            : []),
          ...(razem ? [{ klucz: 'czas', ikona: 'time-outline' as const, tekst: `${razem} min` }] : []),
          { klucz: 'trwalosc', ikona: 'calendar-outline', tekst: opisTrwalosci(p.trwalosc_dni) },
          ...(p.mozna_mrozic
            ? [{ klucz: 'mrozenie', ikona: 'snow-outline' as const, tekst: 'można mrozić' }]
            : []),
        ];

        return (
        <Karta key={p.id}>
          <View style={styles.naglowek}>
            <ThemedText type="subtitle" style={styles.nazwa}>
              {p.nazwa}
            </ThemedText>

            {/*
              Dla moderatora pigułka statusu jest jednocześnie przełącznikiem
              publiczny/prywatny — najszybszy sposób ustalić i zmienić, co jest
              widoczne dla wszystkich, bez wchodzenia w kolejkę zgłoszeń.
              Zgłoszony ma swój własny obieg decyzji niżej, więc tu jest tylko
              etykietą.
            */}
            {mozeDodawac && p.widocznosc !== 'zgloszona' ? (
              <Pressable
                onPress={() => przelaczWidocznosc(p)}
                accessibilityRole="button"
                accessibilityLabel={
                  p.widocznosc === 'publiczna' ? `Ukryj ${p.nazwa}` : `Opublikuj ${p.nazwa}`
                }
                style={({ pressed }) => [
                  styles.widocznoscPigulka,
                  p.widocznosc === 'publiczna'
                    ? { backgroundColor: motyw.backgroundSelected }
                    : { borderWidth: 1, borderColor: motyw.border },
                  pressed && styles.wcisniety,
                ]}>
                <Ionicons
                  name={p.widocznosc === 'publiczna' ? 'earth' : 'lock-closed-outline'}
                  size={14}
                  color={p.widocznosc === 'publiczna' ? motyw.accent : motyw.textSecondary}
                />
                <ThemedText
                  type="small"
                  themeColor={p.widocznosc === 'publiczna' ? 'accent' : 'textSecondary'}>
                  {p.widocznosc === 'publiczna' ? 'publiczny' : 'prywatny'}
                </ThemedText>
              </Pressable>
            ) : (
              <ThemedText type="small" themeColor="textSecondary">
                {p.widocznosc === 'publiczna'
                  ? 'publiczny'
                  : p.widocznosc === 'prywatna'
                    ? 'prywatny'
                    : 'zgłoszony'}
              </ThemedText>
            )}
          </View>

          {zdjecie && (
            <Image
              source={{ uri: zdjecie }}
              style={styles.zdjecie}
              contentFit="cover"
              transition={150}
              accessibilityLabel={p.nazwa}
            />
          )}

          {p.opis && (
            <ThemedText type="small" themeColor="textSecondary">
              {p.opis}
            </ThemedText>
          )}

          <View style={styles.tagi}>
            {tagi.map((t) => (
              <View
                key={t.klucz}
                style={[styles.tag, { borderColor: motyw.border, backgroundColor: motyw.background }]}>
                <Ionicons name={t.ikona} size={16} color={motyw.accent} />
                <ThemedText type="small">{t.tekst}</ThemedText>
              </View>
            ))}
          </View>

          <View style={[styles.dzielnik, { backgroundColor: motyw.border }]} />

          {p.kcal !== null ? (
            <>
              <ThemedText type="smallBold" themeColor="accent">
                NA PORCJĘ
                {p.gramy_porcji ? ` (${p.gramy_porcji} g)` : ''}
                {p.porcje_wyliczone ? ` · z ${p.porcje_wyliczone} porcji` : ''}
              </ThemedText>

              <View style={[styles.makroBox, { backgroundColor: motyw.background }]}>
                {(
                  [
                    { etykieta: 'kcal', wartosc: p.kcal, jednostka: '', ikona: 'flame-outline' as const, kolor: KOLOR_MAKRO.bialko },
                    { etykieta: 'białko', wartosc: p.bialko_g ?? 0, jednostka: ' g', ikona: 'barbell-outline' as const, kolor: KOLOR_MAKRO.bialko },
                    { etykieta: 'tłuszcz', wartosc: p.tluszcz_g ?? 0, jednostka: ' g', ikona: 'water-outline' as const, kolor: KOLOR_MAKRO.tluszcz },
                    { etykieta: 'węgle', wartosc: p.wegle_g ?? 0, jednostka: ' g', ikona: 'nutrition-outline' as const, kolor: KOLOR_MAKRO.wegle },
                  ]
                ).map((m, i, tablica) => (
                  <View
                    key={m.etykieta}
                    style={[
                      styles.makroPozycja,
                      i < tablica.length - 1 && { borderRightWidth: 1, borderRightColor: motyw.border },
                    ]}>
                    <Ionicons name={m.ikona} size={20} color={m.kolor} />
                    <ThemedText type="smallBold" numberOfLines={1}>
                      {m.wartosc}
                      {m.jednostka}
                    </ThemedText>
                    <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
                      {m.etykieta}
                    </ThemedText>
                  </View>
                ))}
              </View>

              {(p.kcal_calosc !== null || (p.cukry_wolne_g ?? 0) > 0) && (
                <View style={[styles.podsumowanie, { backgroundColor: motyw.background }]}>
                  {p.kcal_calosc !== null && (
                    <View style={styles.podsumowanieWiersz}>
                      <Ionicons name="scale-outline" size={16} color={motyw.accent} />
                      <ThemedText type="small" themeColor="textSecondary">
                        Cała potrawa: {p.gramy_calosc ? `${p.gramy_calosc} g, ` : ''}
                        {p.kcal_calosc} kcal, {p.bialko_g_calosc} g białka
                      </ThemedText>
                    </View>
                  )}
                  {p.cukry_wolne_g !== null && p.cukry_wolne_g > 0 && (
                    <View style={styles.podsumowanieWiersz}>
                      <Ionicons name="diamond-outline" size={16} color={motyw.accent} />
                      <ThemedText type="small" themeColor="textSecondary">
                        cukry wolne: {p.cukry_wolne_g} g
                      </ThemedText>
                    </View>
                  )}
                </View>
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

          {/*
            Pasek akcji na dole karty — segmenty oddzielone pionową kreską,
            jak w makiecie. Edytuj/Usuń mają etykietę, preferencje są
            ikonami — jest ich zawsze trzy, więc tylko ostatnia jest bez
            prawej krawędzi niezależnie od tego, czy Edytuj/Usuń się pokazują.
          */}
          <View style={[styles.akcjeBar, { borderColor: motyw.border, backgroundColor: motyw.background }]}>
            {(mozeDodawac || (p.autor_id === sesja?.user.id && p.widocznosc === 'prywatna')) && (
              <Pressable
                onPress={() =>
                  router.push({
                    pathname: '/przepis-formularz',
                    params: { id: p.id, powrot: '/przepisy' },
                  })
                }
                accessibilityRole="button"
                accessibilityLabel={`Edytuj ${p.nazwa}`}
                style={({ pressed }) => [
                  styles.akcjaSegment,
                  { borderRightColor: motyw.border },
                  pressed && styles.wcisniety,
                ]}>
                <Ionicons name="create-outline" size={18} color={motyw.textSecondary} />
                <ThemedText type="small" themeColor="textSecondary">
                  Edytuj
                </ThemedText>
              </Pressable>
            )}

            {mozeUsuwac(p) && (
              <Pressable
                onPress={() => setDoUsuniecia(p)}
                accessibilityRole="button"
                accessibilityLabel={`Usuń ${p.nazwa}`}
                style={({ pressed }) => [
                  styles.akcjaSegment,
                  { borderRightColor: motyw.border },
                  pressed && styles.wcisniety,
                ]}>
                <Ionicons name="trash-outline" size={18} color={motyw.textSecondary} />
                <ThemedText type="small" themeColor="textSecondary">
                  Usuń
                </ThemedText>
              </Pressable>
            )}

            {(
              [
                { poziom: 'ulubione', ikona: 'star', ikonaPusta: 'star-outline', etykieta: 'Ulubione — planuj często podczas automatyzacji planu' },
                { poziom: 'lubie', ikona: 'heart', ikonaPusta: 'heart-outline', etykieta: 'Lubię — wybieraj podczas automatyzacji planu' },
                { poziom: 'nie_proponuj', ikona: 'close-circle', ikonaPusta: 'close-circle-outline', etykieta: 'Nie proponuj podczas automatyzacji planu' },
              ] as const
            ).map((opcja, i) => {
              const aktywna = p.preferencja === opcja.poziom;
              const klucz = `${p.id}:${opcja.poziom}`;
              const ostatnia = i === 2;
              return (
                <View key={opcja.poziom} style={styles.preferencjaOpakowanie}>
                  {dymek === klucz && (
                    <ThemedView
                      type="backgroundElement"
                      style={[styles.dymek, { borderColor: motyw.border }]}>
                      <ThemedText type="small">{opcja.etykieta}</ThemedText>
                    </ThemedView>
                  )}
                  <Pressable
                    onPress={() => przelaczPreferencje(p, opcja.poziom)}
                    onHoverIn={() => setDymek(klucz)}
                    onHoverOut={() => setDymek(null)}
                    accessibilityRole="button"
                    accessibilityState={{ selected: aktywna }}
                    accessibilityLabel={opcja.etykieta}
                    style={({ pressed }) => [
                      styles.akcjaSegmentIkona,
                      !ostatnia && { borderRightWidth: 1, borderRightColor: motyw.border },
                      pressed && styles.wcisniety,
                    ]}>
                    <Ionicons
                      name={aktywna ? opcja.ikona : opcja.ikonaPusta}
                      size={22}
                      color={aktywna ? motyw.accent : motyw.textSecondary}
                    />
                  </Pressable>
                </View>
              );
            })}
          </View>

          {/* Potwierdzenie usunięcia — wewnątrz TEJ karty, żeby nie znikało z pola widzenia na długiej liście. */}
          {doUsuniecia?.id === p.id && (
            <View style={[styles.potwierdzenieUsuniecia, { borderColor: motyw.accent }]}>
              <ThemedText type="smallBold" themeColor="accent">
                Usunąć „{p.nazwa}”?
              </ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                Razem z przepisem znikną jego składniki, etapy i kroki. Tej operacji nie da się
                cofnąć. Jeśli przepis jest w czyimś planie posiłków albo w ugotowanej partii,
                usunięcie się nie powiedzie — trzeba go najpierw stamtąd zdjąć.
              </ThemedText>
              <Przycisk tytul="Usuń" onPress={() => usunPrzepis(p)} zajety={usuwanie} />
              <Przycisk
                tytul="Anuluj"
                wariant="poboczny"
                onPress={() => setDoUsuniecia(null)}
                wylaczony={usuwanie}
              />
            </View>
          )}
        </Karta>
        );
      })}

      {mozeDodawac && (
        <Przycisk
          tytul="Dodaj przepis"
          onPress={() =>
            router.push({
              pathname: '/przepis-formularz',
              params: { powrot: '/przepisy' },
            })
          }
        />
      )}

      {/*
        Składniki widzi każde konto — każdy może dopisać brakujący, a katalog
        i tak jest wspólny (patrz `skladniki_wstawianie`, migracja 0037).
        Edycję i kasowanie istniejących wierszy pilnuje RLS, więc ekran
        składników sam ukrywa te przyciski dla nie-moderatorów.
      */}
      <Przycisk
        tytul="Składniki"
        wariant="poboczny"
        onPress={() => router.push({ pathname: '/skladniki', params: { powrot: '/przepisy' } })}
      />

      {mozeDodawac && (
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
  widocznoscPigulka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    borderRadius: 999,
    paddingVertical: Spacing.half,
    paddingHorizontal: Spacing.two,
  },
  moderacja: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
    marginTop: Spacing.one,
  },
  potwierdzenieUsuniecia: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
    marginTop: Spacing.one,
  },
  decyzje: { flexDirection: 'row', gap: Spacing.two },
  decyzja: { flex: 1 },

  /* Tagi — pigułki z ikoną, jak w makiecie. */
  tagi: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
  },
  tag: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderWidth: 1,
    borderRadius: Spacing.two,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  dzielnik: { height: 1 },

  /* Makro na porcję — cztery ikony w rzędzie na wspólnym tle. */
  makroBox: {
    flexDirection: 'row',
    borderRadius: Spacing.two,
    paddingVertical: Spacing.two,
  },
  makroPozycja: {
    flex: 1,
    alignItems: 'center',
    gap: 2,
    paddingHorizontal: Spacing.one,
  },

  /* Podsumowanie — cała potrawa / cukry wolne, wiersz z ikoną. */
  podsumowanie: {
    gap: Spacing.one,
    borderRadius: Spacing.two,
    padding: Spacing.two,
  },
  podsumowanieWiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },

  /* Pasek akcji na dole karty — segmenty oddzielone pionową kreską. */
  akcjeBar: {
    flexDirection: 'row',
    alignItems: 'stretch',
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
    marginTop: Spacing.one,
  },
  akcjaSegment: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.two,
    paddingHorizontal: Spacing.one,
    borderRightWidth: 1,
  },
  akcjaSegmentIkona: {
    flex: 1,
    width: 52,
    alignItems: 'center',
    justifyContent: 'center',
  },
  preferencjaOpakowanie: { position: 'relative', flex: 1 },
  dymek: {
    position: 'absolute',
    bottom: '100%',
    right: 0,
    marginBottom: Spacing.one,
    paddingVertical: Spacing.half,
    paddingHorizontal: Spacing.two,
    borderRadius: Spacing.one,
    borderWidth: 1,
    zIndex: 10,
    // Szerokość zależy od tekstu, ale nie może rozjechać się na cały ekran
    // na wąskim widoku telefonu — stąd `right: 0` zamiast wyśrodkowania.
    maxWidth: 220,
  },
  wcisniety: { opacity: 0.6 },
});
