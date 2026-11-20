import { Ionicons } from '@expo/vector-icons';
import { router, useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, useWindowDimensions, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { WyborDania } from '@/components/wybor-dania';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { PORY } from '@/lib/plan';
import { pasujeDoPory, pobierzPrzepisy, type PoraPosilku, type PrzepisZMakro } from '@/lib/przepisy';
import {
  NazwaSchematuZajeta,
  pobierzPozycjeSchematu,
  pobierzSchemat,
  pobierzSchematy,
  usunSchemat,
  zapiszSchemat,
  zapiszZmianySchematu,
  type Schemat,
} from '@/lib/schematy';
import {
  dniGarnka,
  dodajDanie,
  naMiejscu,
  przedluzGarnek,
  skrocGarnek,
  usunGarnek,
  wolneDniOd,
  zmienDlugosc,
  type PozycjaSchematu,
} from '@/lib/schematy-uklad';
import { garnekNiepodzielny } from '@/lib/automat';
import { useSesja } from '@/lib/sesja';
import { SZEROKOSC_TABLETU } from '@/lib/widok-listy';

/**
 * Schematy tygodnia: lista i edytor (etap 2 modułu schematów).
 *
 * `/schematy` — lista schematów konta i zakładanie nowego.
 * `/schematy?id=…` — edytor jednego schematu.
 *
 * Edytor jest pomyślany pod tablet i komputer: od szerokości tabletu dni
 * stoją obok siebie jak w arkuszu, pory jedna pod drugą. Na telefonie te
 * same dane idą dzień pod dniem — da się poprawić drobiazg, ale układanie
 * całego tygodnia wygodniej robić na dużym ekranie.
 */
export default function EkranSchematow() {
  const { id } = useLocalSearchParams<{ id?: string }>();
  // `key` — każdy schemat dostaje świeży stan edytora; nawigator zakładek
  // trzyma ekran zamontowany i inaczej zostałyby dane poprzedniego.
  return id ? <EdytorSchematu key={id} id={id} /> : <ListaSchematow />;
}

// =============================================================================
//  LISTA
// =============================================================================

function ListaSchematow() {
  const { t } = useTranslation();
  const motyw = useTheme();
  const { sesja } = useSesja();

  const [schematy, setSchematy] = useState<Schemat[] | null>(null);
  const [nazwa, setNazwa] = useState('');
  const [doUsuniecia, setDoUsuniecia] = useState<string | null>(null);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  const [zajety, setZajety] = useState(false);

  const wczytaj = useCallback(async () => {
    setBlad(null);
    try {
      setSchematy(await pobierzSchematy());
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }, []);

  useFocusEffect(
    useCallback(() => {
      wczytaj();
    }, [wczytaj])
  );

  async function utworz() {
    if (!sesja) return;
    if (!nazwa.trim()) {
      setKomunikat(t('schematy.podajNazwe'));
      return;
    }
    setZajety(true);
    setBlad(null);
    setKomunikat(null);
    try {
      const nowy = await zapiszSchemat({ kontoId: sesja.user.id, nazwa, dni: 7, pozycje: [] });
      setNazwa('');
      router.push(`/schematy?id=${nowy.id}`);
    } catch (e) {
      if (e instanceof NazwaSchematuZajeta) setKomunikat(t('schematy.nazwaZajeta', { nazwa: nazwa.trim() }));
      else setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  async function usun(s: Schemat) {
    setZajety(true);
    setBlad(null);
    try {
      await usunSchemat(s.id);
      setDoUsuniecia(null);
      setKomunikat(t('schematy.usunieto', { nazwa: s.nazwa }));
      await wczytaj();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  return (
    <Ekran tytul={t('schematy.tytul')} podtytul={t('schematy.podtytul')}>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      <Karta style={styles.odstep}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('schematy.nowy')}
        </ThemedText>
        <Pole
          etykieta={t('schematy.nazwa')}
          value={nazwa}
          onChangeText={setNazwa}
          maxLength={80}
          onSubmitEditing={utworz}
        />
        <Przycisk tytul={t('schematy.utworz')} ikona="add-outline" onPress={utworz} zajety={zajety} wylaczony={zajety} />
        {komunikat && (
          <ThemedText type="small" themeColor="textSecondary">
            {komunikat}
          </ThemedText>
        )}
      </Karta>

      {schematy === null ? (
        <ActivityIndicator color={motyw.accent} />
      ) : schematy.length === 0 ? (
        <ThemedText type="small" themeColor="textSecondary">
          {t('schematy.brakNaLiscie')}
        </ThemedText>
      ) : (
        schematy.map((s) => (
          <Karta key={s.id} style={styles.odstep}>
            <ThemedText type="smallBold">{s.nazwa}</ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {t('plan.dni', { count: s.dni })} · {t('plan.dania', { count: s.liczbaDan })}
            </ThemedText>
            {doUsuniecia === s.id ? (
              <>
                <ThemedText type="small" themeColor="accent">
                  {t('schematy.usunPytanie', { nazwa: s.nazwa })}
                </ThemedText>
                <Przycisk tytul={t('schematy.takUsun')} onPress={() => usun(s)} zajety={zajety} />
                <Przycisk tytul={t('uzytkownicy.zostaw')} wariant="poboczny" onPress={() => setDoUsuniecia(null)} />
              </>
            ) : (
              <View style={styles.rzad}>
                <Przycisk
                  tytul={t('schematy.edytuj')}
                  ikona="create-outline"
                  onPress={() => router.push(`/schematy?id=${s.id}`)}
                  style={styles.rosnie}
                />
                <Pressable
                  onPress={() => setDoUsuniecia(s.id)}
                  accessibilityRole="button"
                  accessibilityLabel={t('schematy.usun', { nazwa: s.nazwa })}
                  hitSlop={8}
                  style={({ pressed }) => [styles.ikona, pressed && styles.wcisniete]}>
                  <Ionicons name="trash-outline" size={22} color={motyw.textSecondary} />
                </Pressable>
              </View>
            )}
          </Karta>
        ))
      )}

      <Przycisk tytul={t('schematy.doPlanu')} wariant="poboczny" ikona="calendar-outline" onPress={() => router.navigate('/')} />
    </Ekran>
  );
}

// =============================================================================
//  EDYTOR
// =============================================================================

type Miejsce = { dzien: number; pora: PoraPosilku };

function EdytorSchematu({ id }: { id: string }) {
  const { t } = useTranslation();
  const motyw = useTheme();
  const { sesja } = useSesja();
  const { width } = useWindowDimensions();
  const szeroki = width >= SZEROKOSC_TABLETU;

  const [wczytany, setWczytany] = useState(false);
  const [brak, setBrak] = useState(false);
  const [nazwa, setNazwa] = useState('');
  const [dni, setDni] = useState(7);
  const [pozycje, setPozycje] = useState<PozycjaSchematu[]>([]);
  const [przepisy, setPrzepisy] = useState<PrzepisZMakro[]>([]);
  const [zmieniony, setZmieniony] = useState(false);
  const [wybierany, setWybierany] = useState<Miejsce | null>(null);
  const [porzucic, setPorzucic] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  const [zapisuje, setZapisuje] = useState(false);

  // Wczytanie raz, przy zamontowaniu. Celowo nie przy każdym powrocie na
  // ekran: odświeżenie z bazy nadpisałoby niezapisane zmiany. Inny schemat
  // to inny `key` w EkranSchematow, czyli świeży edytor.
  const kontoId = sesja?.user.id;
  useEffect(() => {
    let aktywny = true;
    (async () => {
      try {
        const [naglowek, lista, katalog] = await Promise.all([
          pobierzSchemat(id),
          pobierzPozycjeSchematu(id),
          pobierzPrzepisy(kontoId),
        ]);
        if (!aktywny) return;
        if (!naglowek) {
          setBrak(true);
        } else {
          setNazwa(naglowek.nazwa);
          setDni(naglowek.dni);
          setPozycje(lista);
          setPrzepisy(katalog);
        }
        setWczytany(true);
      } catch (e) {
        if (aktywny) setBlad(komunikatBledu(e));
      }
    })();
    return () => {
      aktywny = false;
    };
  }, [id, kontoId]);

  const wedlugId = useMemo(() => new Map(przepisy.map((p) => [p.id, p])), [przepisy]);

  /** Suma dnia w porcjach z przepisu — orientacyjnie, przed dopasowaniem pod cel. */
  const sumaDnia = useCallback(
    (dzien: number) => {
      let kcal = 0;
      let bialko = 0;
      for (const p of pozycje) {
        if (p.dzien !== dzien || !p.przepis_id) continue;
        const przepis = wedlugId.get(p.przepis_id);
        kcal += przepis?.kcal ?? 0;
        bialko += przepis?.bialko_g ?? 0;
      }
      return { kcal: Math.round(kcal), bialko: Math.round(bialko) };
    },
    [pozycje, wedlugId]
  );

  function zmien(nowe: PozycjaSchematu[]) {
    if (nowe === pozycje) return;
    setPozycje(nowe);
    setZmieniony(true);
    setKomunikat(null);
  }

  function ustawDni(nowe: number) {
    const d = Math.min(31, Math.max(1, nowe));
    if (d === dni) return;
    setDni(d);
    setPozycje((p) => zmienDlugosc(p, d));
    setZmieniony(true);
    setKomunikat(null);
  }

  async function zapisz() {
    if (!nazwa.trim()) {
      setKomunikat(t('schematy.podajNazwe'));
      return;
    }
    setZapisuje(true);
    setBlad(null);
    try {
      await zapiszZmianySchematu({ schematId: id, nazwa, dni, pozycje });
      setZmieniony(false);
      setKomunikat(t('schematy.zapisanoZmiany'));
    } catch (e) {
      if (e instanceof NazwaSchematuZajeta) setKomunikat(t('schematy.nazwaZajeta', { nazwa: nazwa.trim() }));
      else setBlad(komunikatBledu(e));
    } finally {
      setZapisuje(false);
    }
  }

  function wrocDoListy() {
    if (zmieniony && !porzucic) {
      setPorzucic(true);
      return;
    }
    router.replace('/schematy');
  }

  // --- Wybór dania: cały ekran, jak na planie ---

  if (wybierany) {
    const dania = przepisy.filter(
      (p) => !p.ukryty && p.zawieraWykluczone.length === 0 && pasujeDoPory(p.pory, wybierany.pora)
    );
    return (
      <Ekran
        tytul={t('schematy.wybierzDanie', {
          dzien: t('schematy.dzien', { nr: wybierany.dzien + 1 }),
          pora: t(`pora.${wybierany.pora}`),
        })}
        pelnaSzerokosc={szeroki}>
        <Karta>
          <WyborDania
            dania={dania}
            kafle={szeroki}
            onWybierz={(p) => {
              // Jak ręczny wybór na planie: garnek od razu na tyle dni, ile
              // przepis ma porcji bazowych — obiad na 3 porcje zajmuje trzy
              // kolejne dni. Seria kończy się na pierwszym zajętym dniu.
              const ile = Math.max(1, p.liczba_porcji_bazowych);
              const wolne = wolneDniOd(pozycje, wybierany.dzien, wybierany.pora, ile, dni);
              // Zupy nie przycinamy (`garnekNiepodzielny`) — pełny garnek albo wcale.
              if (garnekNiepodzielny(p) && wolne.length < ile) {
                setKomunikat(
                  t('schematy.zupaNieMiesci', {
                    nazwa: p.nazwa,
                    potrzeba: t('plan.dni', { count: ile }),
                    wolne: t('plan.dni', { count: wolne.length }),
                  })
                );
                setWybierany(null);
                return;
              }
              zmien(dodajDanie(pozycje, wybierany.dzien, wybierany.pora, p, ile, dni));
              if (wolne.length < ile) {
                setKomunikat(
                  t('schematy.krocejNizPorcji', {
                    nazwa: p.nazwa,
                    potrzeba: t('plan.dni', { count: ile }),
                    dni: t('plan.dni', { count: wolne.length }),
                  })
                );
              }
              setWybierany(null);
            }}
          />
        </Karta>
        <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={() => setWybierany(null)} />
      </Ekran>
    );
  }

  if (!wczytany) {
    return (
      <Ekran tytul={t('schematy.tytul')}>
        {blad ? (
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        ) : (
          <ActivityIndicator color={motyw.accent} />
        )}
      </Ekran>
    );
  }

  if (brak) {
    return (
      <Ekran tytul={t('schematy.tytul')}>
        <ThemedText type="small" themeColor="textSecondary">
          {t('schematy.nieZnaleziono')}
        </ThemedText>
        <Przycisk tytul={t('schematy.doListy')} wariant="poboczny" onPress={() => router.replace('/schematy')} />
      </Ekran>
    );
  }

  const komorka = (dzien: number, pora: PoraPosilku) => (
    <KomorkaSchematu
      pozycje={pozycje}
      dzien={dzien}
      pora={pora}
      dni={dni}
      onDodaj={() => setWybierany({ dzien, pora })}
      onZmien={zmien}
    />
  );

  const dniLista = Array.from({ length: dni }, (_, i) => i);

  return (
    <Ekran tytul={t('schematy.edytor')} podtytul={t('schematy.edytorOpis')} pelnaSzerokosc={szeroki}>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      <Karta style={styles.odstep}>
        <View style={szeroki ? styles.rzadSzeroki : styles.odstep}>
          <View style={szeroki ? styles.rosnie : undefined}>
            <Pole
              etykieta={t('schematy.nazwa')}
              value={nazwa}
              onChangeText={(v) => {
                setNazwa(v);
                setZmieniony(true);
              }}
              maxLength={80}
            />
          </View>
          <View style={styles.odstepMaly}>
            <ThemedText type="smallBold" themeColor="textSecondary">
              {t('schematy.dlugosc')}
            </ThemedText>
            <View style={styles.licznik}>
              <IkonaAkcji ikona="remove" opis={t('schematy.mniejDni')} onPress={() => ustawDni(dni - 1)} wylaczona={dni <= 1} />
              <ThemedText type="smallBold">{t('plan.dni', { count: dni })}</ThemedText>
              <IkonaAkcji ikona="add" opis={t('schematy.wiecejDni')} onPress={() => ustawDni(dni + 1)} wylaczona={dni >= 31} />
            </View>
          </View>
        </View>

        <View style={styles.rzad}>
          <Przycisk
            tytul={zmieniony ? t('schematy.zapiszZmiany') : t('schematy.bezZmian')}
            ikona="save-outline"
            onPress={zapisz}
            zajety={zapisuje}
            wylaczony={!zmieniony || zapisuje}
            style={styles.rosnie}
          />
          <Przycisk tytul={t('schematy.doListy')} wariant="poboczny" onPress={wrocDoListy} style={styles.rosnie} />
        </View>

        {porzucic && (
          <>
            <ThemedText type="small" themeColor="accent">
              {t('schematy.porzucicPytanie')}
            </ThemedText>
            <Przycisk tytul={t('schematy.takPorzuc')} onPress={() => router.replace('/schematy')} />
            <Przycisk tytul={t('uzytkownicy.zostaw')} wariant="poboczny" onPress={() => setPorzucic(false)} />
          </>
        )}

        {komunikat && (
          <ThemedText type="small" themeColor="textSecondary">
            {komunikat}
          </ThemedText>
        )}
      </Karta>

      {szeroki ? (
        // Arkusz: dni w kolumnach, pory w wierszach. Przy długim schemacie
        // przewija się w bok, kolumna z porami zostaje czytelna dzięki
        // minimalnej szerokości kolumny dnia.
        <Karta>
          <ScrollView horizontal showsHorizontalScrollIndicator>
            <View style={styles.arkusz}>
              <View style={styles.wierszArkusza}>
                <View style={styles.kolumnaPor} />
                {dniLista.map((d) => {
                  const s = sumaDnia(d);
                  return (
                    <View key={d} style={styles.kolumnaDnia}>
                      <ThemedText type="smallBold">{t('schematy.dzien', { nr: d + 1 })}</ThemedText>
                      <ThemedText type="small" themeColor="textSecondary">
                        {t('schematy.sumaDnia', { kcal: s.kcal, bialko: s.bialko })}
                      </ThemedText>
                    </View>
                  );
                })}
              </View>
              {PORY.map((pora) => (
                <View key={pora} style={[styles.wierszArkusza, { borderTopColor: motyw.border }, styles.liniaGorna]}>
                  <View style={styles.kolumnaPor}>
                    <ThemedText type="smallBold" themeColor="textSecondary">
                      {t(`pora.${pora}`)}
                    </ThemedText>
                  </View>
                  {dniLista.map((d) => (
                    <View key={d} style={styles.kolumnaDnia}>
                      {komorka(d, pora)}
                    </View>
                  ))}
                </View>
              ))}
            </View>
          </ScrollView>
        </Karta>
      ) : (
        dniLista.map((d) => {
          const s = sumaDnia(d);
          return (
            <Karta key={d} style={styles.odstep}>
              <View style={styles.rzadMiedzy}>
                <ThemedText type="smallBold">{t('schematy.dzien', { nr: d + 1 })}</ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  {t('schematy.sumaDnia', { kcal: s.kcal, bialko: s.bialko })}
                </ThemedText>
              </View>
              {PORY.map((pora) => (
                <View key={pora} style={styles.odstepMaly}>
                  <ThemedText type="small" themeColor="textSecondary">
                    {t(`pora.${pora}`)}
                  </ThemedText>
                  {komorka(d, pora)}
                </View>
              ))}
            </Karta>
          );
        })
      )}

      <ThemedText type="small" themeColor="textSecondary">
        {t('schematy.legenda')}
      </ThemedText>
    </Ekran>
  );
}

/**
 * Jedno miejsce schematu.
 *
 * Danie gotowane na kilka dni ma przyciski tylko w PIERWSZYM dniu garnka;
 * kolejne dni pokazują „ciąg dalszy”, żeby było jasne, że to ten sam garnek,
 * a nie osobne gotowanie.
 */
function KomorkaSchematu({
  pozycje,
  dzien,
  pora,
  dni,
  onDodaj,
  onZmien,
}: {
  pozycje: PozycjaSchematu[];
  dzien: number;
  pora: PoraPosilku;
  dni: number;
  onDodaj: () => void;
  onZmien: (nowe: PozycjaSchematu[]) => void;
}) {
  const { t } = useTranslation();
  const motyw = useTheme();
  const p = naMiejscu(pozycje, dzien, pora);

  if (!p) {
    return (
      <Pressable
        onPress={onDodaj}
        accessibilityRole="button"
        accessibilityLabel={t('schematy.dodajNa', { dzien: dzien + 1, pora: t(`pora.${pora}`) })}
        style={({ pressed }) => [styles.pusta, { borderColor: motyw.border }, pressed && styles.wcisniete]}>
        <Ionicons name="add" size={18} color={motyw.textSecondary} />
        <ThemedText type="small" themeColor="textSecondary">
          {t('schematy.dodaj')}
        </ThemedText>
      </Pressable>
    );
  }

  const dniG = dniGarnka(pozycje, p.gotowanie);
  const ktory = dniG.indexOf(dzien) + 1;
  const pierwszy = ktory === 1;
  const usuniety = p.przepis_id === null;

  return (
    <View
      style={[
        styles.pelna,
        { backgroundColor: pierwszy ? motyw.backgroundSelected : 'transparent', borderColor: motyw.border },
      ]}>
      <ThemedText type="small" themeColor={usuniety ? 'accent' : pierwszy ? 'text' : 'textSecondary'} numberOfLines={3}>
        {pierwszy ? p.nazwa : `↳ ${p.nazwa}`}
      </ThemedText>
      {usuniety && (
        <ThemedText type="small" themeColor="accent">
          {t('schematy.przepisUsuniety')}
        </ThemedText>
      )}
      {dniG.length > 1 && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('schematy.dzienGarnka', { ktory, ile: dniG.length })}
        </ThemedText>
      )}
      {pierwszy && (
        <View style={styles.akcjeKomorki}>
          <IkonaAkcji
            ikona="remove-circle-outline"
            opis={t('schematy.krocej')}
            onPress={() => onZmien(skrocGarnek(pozycje, p.gotowanie))}
            wylaczona={dniG.length < 2}
          />
          <IkonaAkcji
            ikona="add-circle-outline"
            opis={t('schematy.dluzej')}
            onPress={() => onZmien(przedluzGarnek(pozycje, p.gotowanie, dni))}
            wylaczona={przedluzGarnek(pozycje, p.gotowanie, dni) === pozycje}
          />
          <IkonaAkcji
            ikona="trash-outline"
            opis={t('schematy.usunDanie', { nazwa: p.nazwa })}
            onPress={() => onZmien(usunGarnek(pozycje, p.gotowanie))}
          />
        </View>
      )}
    </View>
  );
}

function IkonaAkcji({
  ikona,
  opis,
  onPress,
  wylaczona = false,
}: {
  ikona: keyof typeof Ionicons.glyphMap;
  opis: string;
  onPress: () => void;
  wylaczona?: boolean;
}) {
  const motyw = useTheme();
  return (
    <Pressable
      onPress={onPress}
      disabled={wylaczona}
      accessibilityRole="button"
      accessibilityLabel={opis}
      hitSlop={6}
      style={({ pressed }) => [styles.ikona, (pressed || wylaczona) && styles.wcisniete]}>
      <Ionicons name={ikona} size={22} color={wylaczona ? motyw.textSecondary : motyw.accent} />
    </Pressable>
  );
}

const styles = StyleSheet.create({
  odstep: {
    gap: Spacing.two,
  },
  odstepMaly: {
    gap: Spacing.one,
  },
  rzad: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    alignItems: 'center',
    gap: Spacing.two,
  },
  rzadSzeroki: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    gap: Spacing.four,
  },
  rzadMiedzy: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'baseline',
    gap: Spacing.two,
  },
  rosnie: {
    flexGrow: 1,
  },
  licznik: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  arkusz: {
    flexGrow: 1,
  },
  wierszArkusza: {
    flexDirection: 'row',
    gap: Spacing.two,
    paddingVertical: Spacing.two,
  },
  liniaGorna: {
    borderTopWidth: StyleSheet.hairlineWidth,
  },
  kolumnaPor: {
    width: 90,
    justifyContent: 'center',
  },
  kolumnaDnia: {
    width: 140,
    gap: Spacing.half,
  },
  pusta: {
    minHeight: 64,
    borderWidth: 1,
    borderStyle: 'dashed',
    borderRadius: 10,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    gap: Spacing.one,
    padding: Spacing.two,
  },
  pelna: {
    minHeight: 64,
    borderWidth: 1,
    borderRadius: 10,
    padding: Spacing.two,
    gap: Spacing.half,
  },
  akcjeKomorki: {
    flexDirection: 'row',
    gap: Spacing.two,
    marginTop: Spacing.one,
  },
  ikona: {
    padding: Spacing.one,
  },
  wcisniete: {
    opacity: 0.5,
  },
});
