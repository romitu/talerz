import { Ionicons } from '@expo/vector-icons';
import { router, useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, useWindowDimensions, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { MiniaturaPrzepisu, PasekMiniatur } from '@/components/miniatura-przepisu';
import { Pole } from '@/components/pole';
import { PrzelacznikAutomatu } from '@/components/przelacznik-automatu';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { WyborDania } from '@/components/wybor-dania';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { PORY } from '@/lib/plan';
import { pasujeDoPory, pobierzPrzepisy, type PoraPosilku, type PrzepisZMakro } from '@/lib/przepisy';
import {
  cofnijUdostepnienie,
  NazwaSchematuZajeta,
  pobierzPozycjeSchematu,
  pobierzSchemat,
  pobierzWszystkieSchematy,
  SchematNiePublikowalny,
  skopiujSchemat,
  ustawPublicznosc,
  usunSchemat,
  zapiszSchemat,
  zapiszZmianySchematu,
  GRUPY,
  TYTUL_GRUPY,
  type Schemat,
} from '@/lib/schematy';
import { supabase } from '@/lib/supabase';
import {
  dniGarnka,
  dodajDanie,
  naMiejscu,
  przedluzGarnek,
  skrocGarnek,
  MAX_DNI_SCHEMATU,
  usunDzienGarnka,
  usunGarnek,
  wolneDniOd,
  zmienDlugosc,
  type PozycjaSchematu,
} from '@/lib/schematy-uklad';
import { dniZLimitem, garnekNiepodzielny } from '@/lib/automat';
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
  const kontoId = sesja?.user.id;

  const [schematy, setSchematy] = useState<Schemat[] | null>(null);
  const [moderator, setModerator] = useState(false);
  const [nazwa, setNazwa] = useState('');
  const [doUsuniecia, setDoUsuniecia] = useState<string | null>(null);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  const [zajety, setZajety] = useState(false);

  const wczytaj = useCallback(async () => {
    if (!kontoId) return;
    setBlad(null);
    try {
      const [lista, konto] = await Promise.all([
        pobierzWszystkieSchematy(kontoId),
        supabase.from('konta').select('rola').eq('id', kontoId).maybeSingle(),
      ]);
      setSchematy(lista);
      const rola = konto.data?.rola as string | undefined;
      setModerator(rola === 'moderator' || rola === 'administrator');
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }, [kontoId]);

  useFocusEffect(
    useCallback(() => {
      wczytaj();
    }, [wczytaj])
  );

  /** Wspólna obsługa: blokada przycisków, czyszczenie komunikatów, błąd. */
  async function wykonaj(akcja: () => Promise<void>) {
    setZajety(true);
    setBlad(null);
    setKomunikat(null);
    try {
      await akcja();
    } catch (e) {
      if (e instanceof NazwaSchematuZajeta) setKomunikat(t('schematy.nazwaZajeta', { nazwa: e.message }));
      else if (e instanceof SchematNiePublikowalny)
        setKomunikat(
          e.niepubliczne > 0
            ? t('schematy.niePublikowalny', { count: e.niepubliczne })
            : t('schematy.pustyDoKatalogu')
        );
      else setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  function utworz() {
    if (!kontoId) return;
    if (!nazwa.trim()) {
      setKomunikat(t('schematy.podajNazwe'));
      return;
    }
    wykonaj(async () => {
      const nowy = await zapiszSchemat({ kontoId, nazwa, dni: 7, pozycje: [] });
      setNazwa('');
      router.push(`/schematy?id=${nowy.id}`);
    });
  }

  function skopiuj(s: Schemat) {
    if (!kontoId) return;
    wykonaj(async () => {
      const kopia = await skopiujSchemat(kontoId, s, t('schematy.kopia'));
      router.push(`/schematy?id=${kopia.id}`);
    });
  }

  function usun(s: Schemat) {
    wykonaj(async () => {
      await usunSchemat(s.id);
      setDoUsuniecia(null);
      await wczytaj();
      setKomunikat(t('schematy.usunieto', { nazwa: s.nazwa }));
    });
  }

  function odrzuc(s: Schemat) {
    if (!s.profilId) return;
    const profilId = s.profilId;
    wykonaj(async () => {
      await cofnijUdostepnienie(s.id, profilId);
      await wczytaj();
      setKomunikat(t('schematy.odrzucono', { nazwa: s.nazwa }));
    });
  }

  function przelaczPublicznosc(s: Schemat) {
    wykonaj(async () => {
      await ustawPublicznosc(s.id, !s.publiczny);
      await wczytaj();
      setKomunikat(s.publiczny ? t('schematy.wycofano', { nazwa: s.nazwa }) : t('schematy.opublikowano', { nazwa: s.nazwa }));
    });
  }

  const kluczWiersza = (s: Schemat) => `${s.zrodlo}|${s.id}|${s.profilId ?? ''}`;

  function wiersz(s: Schemat) {
    return (
      <Karta key={kluczWiersza(s)} style={styles.odstep}>
        <PasekMiniatur zdjecia={s.zdjecia} />
        <ThemedText type="smallBold">{s.nazwa}</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('plan.dni', { count: s.dni })} · {t('plan.dania', { count: s.liczbaDan })}
          {s.zrodlo === 'dietetyk' ? ` · ${t('schematy.odDietetyka', { kto: s.dietetyk ?? '', imie: s.imie ?? '' })}` : ''}
          {s.zrodlo === 'moje' && s.publiczny ? ` · ${t('schematy.wKatalogu')}` : ''}
        </ThemedText>

        {doUsuniecia === kluczWiersza(s) ? (
          <>
            <ThemedText type="small" themeColor="accent">
              {t('schematy.usunPytanie', { nazwa: s.nazwa })}
            </ThemedText>
            <Przycisk tytul={t('schematy.takUsun')} onPress={() => usun(s)} zajety={zajety} />
            <Przycisk tytul={t('uzytkownicy.zostaw')} wariant="poboczny" onPress={() => setDoUsuniecia(null)} />
          </>
        ) : s.zrodlo === 'moje' ? (
          <View style={styles.rzad}>
            <Przycisk
              tytul={t('schematy.edytuj')}
              ikona="create-outline"
              onPress={() => router.push(`/schematy?id=${s.id}`)}
              style={styles.rosnie}
            />
            {moderator && (
              <Przycisk
                tytul={s.publiczny ? t('schematy.wycofaj') : t('schematy.opublikuj')}
                wariant="poboczny"
                ikona={s.publiczny ? 'eye-off-outline' : 'globe-outline'}
                onPress={() => przelaczPublicznosc(s)}
                wylaczony={zajety}
                style={styles.rosnie}
              />
            )}
            <Pressable
              onPress={() => setDoUsuniecia(kluczWiersza(s))}
              accessibilityRole="button"
              accessibilityLabel={t('schematy.usun', { nazwa: s.nazwa })}
              hitSlop={8}
              style={({ pressed }) => [styles.ikona, pressed && styles.wcisniete]}>
              <Ionicons name="trash-outline" size={22} color={motyw.textSecondary} />
            </Pressable>
          </View>
        ) : (
          <View style={styles.rzad}>
            <Przycisk
              tytul={t('schematy.skopiuj')}
              ikona="copy-outline"
              onPress={() => skopiuj(s)}
              wylaczony={zajety}
              style={styles.rosnie}
            />
            {s.zrodlo === 'dietetyk' && (
              <Przycisk
                tytul={t('schematy.odrzuc')}
                wariant="poboczny"
                onPress={() => odrzuc(s)}
                wylaczony={zajety}
                style={styles.rosnie}
              />
            )}
          </View>
        )}
      </Karta>
    );
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
      </Karta>

      {komunikat && (
        <ThemedText type="small" themeColor="textSecondary">
          {komunikat}
        </ThemedText>
      )}

      {schematy === null ? (
        <ActivityIndicator color={motyw.accent} />
      ) : (
        GRUPY.map((zrodlo) => {
          const wGrupie = schematy.filter((s) => s.zrodlo === zrodlo);
          // Własne pokazujemy zawsze — pusta grupa mówi, jak zacząć.
          if (wGrupie.length === 0 && zrodlo !== 'moje') return null;
          return (
            <View key={zrodlo} style={styles.odstep}>
              <ThemedText type="smallBold" themeColor="textSecondary">
                {t(TYTUL_GRUPY[zrodlo])}
              </ThemedText>
              {wGrupie.length === 0 ? (
                <ThemedText type="small" themeColor="textSecondary">
                  {t('schematy.brakNaLiscie')}
                </ThemedText>
              ) : (
                wGrupie.map(wiersz)
              )}
              {zrodlo === 'katalog' && (
                <ThemedText type="small" themeColor="textSecondary">
                  {t('schematy.katalogOpis')}
                </ThemedText>
              )}
            </View>
          );
        })
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
  // Domyślnie włączone, jak na Planie — danie od razu na tyle dni, ile
  // wytrzyma w lodówce.
  const [uwzglednijTrwalosc, setUwzglednijTrwalosc] = useState(true);
  /** Ile osób na koncie je z garnka — do limitu porcji z jednego gotowania. */
  const [osoby, setOsoby] = useState(1);

  // Wczytanie raz, przy zamontowaniu. Celowo nie przy każdym powrocie na
  // ekran: odświeżenie z bazy nadpisałoby niezapisane zmiany. Inny schemat
  // to inny `key` w EkranSchematow, czyli świeży edytor.
  const kontoId = sesja?.user.id;
  useEffect(() => {
    if (!kontoId) return;
    let aktywny = true;
    (async () => {
      try {
        const [naglowek, lista, katalog, profile] = await Promise.all([
          pobierzSchemat(id, kontoId),
          pobierzPozycjeSchematu(id),
          pobierzPrzepisy(kontoId),
          // Liczba jedzących jak na Planie: tyle profili, ile ma konto.
          supabase.from('profile').select('id', { count: 'exact', head: true }),
        ]);
        if (profile.error) throw profile.error;
        if (aktywny) setOsoby(Math.max(1, profile.count ?? 1));
        if (!aktywny) return;
        if (!naglowek) {
          setBrak(true);
        } else {
          setNazwa(naglowek.nazwa);
          setDni(Math.min(naglowek.dni, MAX_DNI_SCHEMATU));
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
  const zdjecieDla = useCallback(
    (przepisId: string | null) => (przepisId ? (wedlugId.get(przepisId)?.zdjecie ?? null) : null),
    [wedlugId]
  );

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

  /**
   * Najmniej dni, na które wolno skrócić garnek. Zupa (`garnekNiepodzielny`)
   * gotuje się w całości, więc nie schodzi poniżej liczby porcji przepisu —
   * inaczej lista zakupów policzyłaby ułamek garnka, który i tak trzeba
   * ugotować cały. Ta sama zasada co przy wstawianiu dania.
   */
  const minDniGarnka = useCallback(
    (przepisId: string | null) => {
      const przepis = przepisId ? wedlugId.get(przepisId) : undefined;
      return przepis && garnekNiepodzielny(przepis) ? Math.max(1, przepis.liczba_porcji_bazowych) : 1;
    },
    [wedlugId]
  );

  function ustawDni(nowe: number) {
    const d = Math.min(MAX_DNI_SCHEMATU, Math.max(1, nowe));
    if (d === dni) return;

    // Skrócenie schematu nie może przyciąć zupy: zupa zaczynająca się przed
    // nowym końcem, a sięgająca za niego, zostałaby ułamkiem garnka.
    const przycietaZupa = pozycje.find((p) => {
      if (p.dzien < d || minDniGarnka(p.przepis_id) <= 1) return false;
      return dniGarnka(pozycje, p.gotowanie)[0] < d;
    });
    if (przycietaZupa) {
      setKomunikat(t('schematy.zupaPrzycinanie', { nazwa: przycietaZupa.nazwa }));
      return;
    }

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
              // Jak ręczny wybór na planie: z włączoną trwałością garnek
              // starcza na tyle dni, ile danie wytrzyma w lodówce (z limitem
              // porcji z jednego gotowania, `dniZLimitem`), bez niej — na tyle,
              // ile przepis ma porcji bazowych. Seria kończy się na pierwszym
              // zajętym dniu.
              const porcje = Math.max(1, p.liczba_porcji_bazowych);
              let ile = uwzglednijTrwalosc ? dniZLimitem(p.trwalosc_dni, osoby) : porcje;
              // Zupy nie przycinamy (`garnekNiepodzielny`) — pełny garnek albo
              // wcale, więc nigdy mniej dni niż porcji. Tak samo jak na planie.
              const zupa = garnekNiepodzielny(p);
              if (zupa) ile = Math.max(ile, porcje);
              const wolne = wolneDniOd(pozycje, wybierany.dzien, wybierany.pora, ile, dni);
              if (zupa && wolne.length < porcje) {
                setKomunikat(
                  t('schematy.zupaNieMiesci', {
                    nazwa: p.nazwa,
                    potrzeba: t('plan.dni', { count: porcje }),
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
      minDniGarnka={minDniGarnka}
      zdjecieDla={zdjecieDla}
      onDodaj={() => setWybierany({ dzien, pora })}
      onZmien={zmien}
      onKomunikat={setKomunikat}
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
              <IkonaAkcji ikona="add" opis={t('schematy.wiecejDni')} onPress={() => ustawDni(dni + 1)} wylaczona={dni >= MAX_DNI_SCHEMATU} />
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

        <PrzelacznikAutomatu
          zaznaczone={uwzglednijTrwalosc}
          onZmiana={setUwzglednijTrwalosc}
          etykieta={t('plan.trwalosc')}
          opis={t('schematy.trwaloscOpis')}
          ikona="archive-outline"
        />

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
  minDniGarnka,
  zdjecieDla,
  onDodaj,
  onZmien,
  onKomunikat,
}: {
  pozycje: PozycjaSchematu[];
  dzien: number;
  pora: PoraPosilku;
  dni: number;
  /** Najmniej dni garnka dla przepisu — dla zupy liczba porcji, inaczej 1. */
  minDniGarnka: (przepisId: string | null) => number;
  /** Ścieżka zdjęcia przepisu albo null (brak zdjęcia, przepis usunięty lub niewidoczny). */
  zdjecieDla: (przepisId: string | null) => string | null;
  onDodaj: () => void;
  onZmien: (nowe: PozycjaSchematu[]) => void;
  onKomunikat: (tekst: string) => void;
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
  const minimum = minDniGarnka(p.przepis_id);
  const calyGarnek = minimum > 1 && dniG.length <= minimum;

  return (
    <View
      style={[
        styles.pelna,
        { backgroundColor: pierwszy ? motyw.backgroundSelected : 'transparent', borderColor: motyw.border },
      ]}>
      {pierwszy ? (
        <>
          {/* Zdjęcie tylko w pierwszym dniu garnka — kolejne dni to ten sam garnek. */}
          <MiniaturaPrzepisu sciezka={zdjecieDla(p.przepis_id)} szerokosc="100%" wysokosc={72} />
          <ThemedText type="small" themeColor={usuniety ? 'accent' : 'text'} numberOfLines={3}>
            {p.nazwa}
          </ThemedText>
        </>
      ) : (
        <View style={styles.ciagDalszy}>
          <MiniaturaPrzepisu sciezka={zdjecieDla(p.przepis_id)} szerokosc={28} wysokosc={28} style={styles.przygaszona} />
          <ThemedText
            type="small"
            themeColor={usuniety ? 'accent' : 'textSecondary'}
            numberOfLines={3}
            style={styles.rosnieTekst}>
            {`↳ ${p.nazwa}`}
          </ThemedText>
        </View>
      )}
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
      {pierwszy && calyGarnek && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('schematy.zupaCalyGarnek')}
        </ThemedText>
      )}
      {pierwszy && (
        <View style={styles.akcjeKomorki}>
          <IkonaAkcji
            ikona="remove-circle-outline"
            opis={calyGarnek ? t('schematy.zupaCalyGarnek') : t('schematy.krocej')}
            onPress={() => onZmien(skrocGarnek(pozycje, p.gotowanie))}
            wylaczona={dniG.length < 2 || dniG.length <= minimum}
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
      {!pierwszy && (
        // Kosz w dalszym dniu garnka usuwa TEN dzień — garnek starcza wtedy na
        // mniej dni. Zupy nie da się przyciąć poniżej liczby porcji, więc
        // wtedy znika cały garnek, z komunikatem, że to jedna zupa.
        <View style={styles.akcjeKomorki}>
          <IkonaAkcji
            ikona="trash-outline"
            opis={
              calyGarnek
                ? t('schematy.usunZupe', { nazwa: p.nazwa })
                : t('schematy.usunDzien', { nazwa: p.nazwa, dzien: dzien + 1 })
            }
            onPress={() => {
              if (calyGarnek) {
                onZmien(usunGarnek(pozycje, p.gotowanie));
                onKomunikat(t('schematy.zupaUsunietaCala', { nazwa: p.nazwa, dni: t('plan.dni', { count: dniG.length }) }));
              } else {
                onZmien(usunDzienGarnka(pozycje, p.gotowanie, dzien));
              }
            }}
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
  ciagDalszy: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  przygaszona: {
    opacity: 0.7,
  },
  rosnieTekst: {
    flex: 1,
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
