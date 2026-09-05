import { Ionicons } from '@expo/vector-icons';
import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { DopiszProdukt } from '@/components/dopisz-produkt';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { NaglowekZakupow } from '@/components/naglowek-zakupow';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { naDate } from '@/lib/plan';
import { useSesja } from '@/lib/sesja';
import {
  dodajReczny,
  dzialDla,
  DZIAL_RECZNY,
  DZIALY,
  kluczOdhaczenia,
  kupionoReczny,
  pobierzListeZakupow,
  pobierzOdhaczone,
  pobierzReczne,
  podpowiedziZHistorii,
  skonsolidujSkladniki,
  ustawOdhaczenie,
  usunReczny,
  wyczyscOdhaczenia,
  type PozycjaSkonsolidowana,
  type PozycjaZakupow,
  type ProduktReczny,
} from '@/lib/zakupy';

/** Zaokrąglenie do wygodnej postaci: 1250 g → „1,25 kg”. */
function opisIlosci(gramy: number): string {
  if (gramy >= 1000) return `${(gramy / 1000).toFixed(2).replace('.', ',')} kg`;
  return `${gramy} g`;
}

/**
 * Zrealizowane — albo ręcznie odhaczone, albo automatycznie: danie było
 * ugotowane przed dzisiaj, więc składniki musiały już być kupione (patrz
 * `zrealizowano_automatycznie` w lib/zakupy.ts).
 */
function czyZrealizowany(p: PozycjaZakupow, kupione: Set<string>): boolean {
  return p.zrealizowano_automatycznie || kupione.has(kluczOdhaczenia(p));
}

export default function EkranZakupow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const motyw = useTheme();
  const { sesja } = useSesja();
  const kontoId = sesja?.user.id;

  const [pozycje, setPozycje] = useState<PozycjaZakupow[]>([]);
  const [reczne, setReczne] = useState<ProduktReczny[]>([]);
  const [historia, setHistoria] = useState<string[]>([]);
  const [kupione, setKupione] = useState<Set<string>>(new Set());
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  /** Kłopot poboczny, który nie może wywrócić całej listy. */
  const [ostrzezenie, setOstrzezenie] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    setOstrzezenie(null);

    /*
      Produkty dopisane ręcznie pobieramy W OSOBNYM bloku i z własną obsługą
      błędu — NIE razem z listą z planu.

      Powód jest konkretny i już raz kosztował pustą listę: gdy tabel
      `zakupy_reczne` i `zakupy_odhaczone` jeszcze nie ma w bazie (migracja 0019
      niewykonana), zapytanie o nie kończy się błędem. Wspólny `try` przerywał
      wtedy CAŁĄ funkcję, zanim doszła do listy z planu — i zakupy wyglądały
      na puste, choć plan był pełny.

      Ta sama zasada obowiązuje w ekranie przepisów przy pobieraniu roli:
      jedna nieudana rzecz nie może ukrywać drugiej, niezależnej.
    */
    if (kontoId) {
      try {
        const [lista, hist, odhaczone] = await Promise.all([
          pobierzReczne(kontoId),
          podpowiedziZHistorii(kontoId),
          pobierzOdhaczone(kontoId),
        ]);
        setReczne(lista);
        setHistoria(hist);
        setKupione(odhaczone);
      } catch (e) {
        setReczne([]);
        setHistoria([]);
        setKupione(new Set());
        setOstrzezenie(
          'Dopisywanie produktów i zapamiętywanie odhaczeń nie działa — wygląda na to, ' +
            'że migracja 0019_zakupy_reczne.sql nie została jeszcze wykonana w Supabase. ' +
            `Lista z planu działa normalnie. (${komunikatBledu(e)})`
        );
      }
    }

    try {
      setPozycje(await pobierzListeZakupow(naDate(new Date())));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [kontoId]);

  // Odświeżenie przy KAŻDYM wejściu na zakładkę, nie tylko przy pierwszym.
  //
  // `useEffect` uruchamia się raz, przy zamontowaniu ekranu. Odkąd zakupy są
  // zakładką na dolnej wstążce, ekran zostaje w pamięci — więc po usunięciu
  // dania z planu lista dalej pokazywała stary stan. Wyglądało to jak błąd
  // w wyliczaniu, a było zwykłym nieodświeżeniem.
  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

  /**
   * Rozdziela na dwie sekcje PRZED scaleniem — inaczej ten sam składnik
   * z gotowania już zrealizowanego i jeszcze nie zrealizowanego zlałby się
   * w jedną liczbę z niejednoznacznym stanem odhaczenia (patrz komentarz
   * przy `skonsolidujSkladniki` w lib/zakupy.ts).
   */
  const { doKupienia, zrealizowaneSkladniki } = useMemo(() => {
    const aktualne: PozycjaZakupow[] = [];
    const zrobione: PozycjaZakupow[] = [];
    for (const p of pozycje) (czyZrealizowany(p, kupione) ? zrobione : aktualne).push(p);
    return {
      doKupienia: skonsolidujSkladniki(aktualne),
      zrealizowaneSkladniki: skonsolidujSkladniki(zrobione),
    };
  }, [pozycje, kupione]);

  function pogrupujWgDzialow(lista: PozycjaSkonsolidowana[]) {
    const mapa = new Map<string, PozycjaSkonsolidowana[]>();
    for (const p of lista) mapa.set(dzialDla(p.tagi), [...(mapa.get(dzialDla(p.tagi)) ?? []), p]);
    return DZIALY.map((dzial) => {
      const wDziale = mapa.get(dzial.nazwa);
      return wDziale && wDziale.length > 0 ? { dzial, pozycje: wDziale } : null;
    }).filter((x): x is NonNullable<typeof x> => x !== null);
  }

  const dzialyDoKupienia = useMemo(() => pogrupujWgDzialow(doKupienia), [doKupienia]);
  const dzialyZrealizowane = useMemo(
    () => pogrupujWgDzialow(zrealizowaneSkladniki),
    [zrealizowaneSkladniki]
  );

  const zrealizowane = zrealizowaneSkladniki.length;
  const niezrealizowane = doKupienia.length + reczne.length;
  const resztyRazem = [...doKupienia, ...zrealizowaneSkladniki].reduce(
    (s, p) => s + (p.reszta_g ?? 0),
    0
  );

  // Tylko odhaczone RĘCZNIE — te zrealizowane automatycznie (danie już
  // ugotowane) i tak nie wrócą jako „do kupienia", więc nie ma czego cofać.
  const odhaczoneRecznie = pozycje.filter(
    (p) => !p.zrealizowano_automatycznie && kupione.has(kluczOdhaczenia(p))
  ).length;

  /**
   * Odhaczenie widoczne od razu, zapis w tle. Pozycja jest już scalona,
   * więc może nieść WIELE źródeł (kilka gotowań potrzebujących tego samego
   * składnika) — odhaczamy je wszystkie naraz, bo kupno jednego worka mąki
   * pokrywa je wszystkie razem.
   *
   * W sklepie liczy się to, żeby ptaszek pojawił się pod palcem, a nie po
   * powrocie odpowiedzi z serwera. Gdy zapis padnie, wracamy do stanu z bazy
   * i mówimy o tym — cicha rozbieżność byłaby gorsza od komunikatu.
   */
  async function oznaczKupione(pozycja: PozycjaSkonsolidowana) {
    if (!kontoId) return;
    const klucze = pozycja.zrodla.map((z) =>
      kluczOdhaczenia({ ...z, skladnik_id: pozycja.skladnik_id })
    );

    setKupione((p) => {
      const n = new Set(p);
      klucze.forEach((k) => n.add(k));
      return n;
    });

    try {
      await Promise.all(
        pozycja.zrodla.map((z) =>
          ustawOdhaczenie(kontoId, z.zrodlo_typ, z.zrodlo_id, pozycja.skladnik_id, true)
        )
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
      pobierz();
    }
  }

  /** Kupiony produkt ręczny schodzi z listy, ale zostaje w historii podpowiedzi. */
  async function odhaczReczny(p: ProduktReczny) {
    setReczne((lista) => lista.filter((x) => x.id !== p.id));
    setHistoria((h) => (h.includes(p.nazwa) ? h : [p.nazwa, ...h]));
    try {
      await kupionoReczny(p.id);
    } catch (e) {
      setBlad(komunikatBledu(e));
      pobierz();
    }
  }

  async function skasujReczny(p: ProduktReczny) {
    setReczne((lista) => lista.filter((x) => x.id !== p.id));
    try {
      await usunReczny(p.id);
    } catch (e) {
      setBlad(komunikatBledu(e));
      pobierz();
    }
  }

  return (
    <Ekran
      tytul="Lista zakupów"
      naglowekStaly={
        <NaglowekZakupow
          data={wczytywanie ? 'wczytywanie…' : undefined}
          zrealizowane={zrealizowane}
          niezrealizowane={niezrealizowane}
        />
      }>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      {ostrzezenie && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {ostrzezenie}
          </ThemedText>
        </Karta>
      )}

      {!wczytywanie && pozycje.length === 0 && reczne.length === 0 && (
        <Karta>
          <ThemedText type="default">Nie ma czego kupować</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Jedzenie zbiera się tu samo z posiłków wpisanych do planu. Rzeczy spoza
            kuchni — worki, papier, chemię — dopisujesz na dole tej listy.
          </ThemedText>
        </Karta>
      )}

      {doKupienia.length > 0 && (
        <ThemedText type="smallBold" themeColor="textSecondary">
          AKTUALNA LISTA ZAKUPÓW
        </ThemedText>
      )}

      {dzialyDoKupienia.map(({ dzial, pozycje: wDziale }) => (
        <Karta key={`do-kupienia-${dzial.nazwa}`}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {dzial.nazwa.toUpperCase()}
          </ThemedText>

          {wDziale.map((p) => (
            <Pressable
              key={p.skladnik_id}
              onPress={() => oznaczKupione(p)}
              style={({ pressed }) => [
                styles.pozycja,
                { borderColor: motyw.border },
                pressed && styles.wcisnieta,
              ]}>
              <Ionicons name="square-outline" size={20} color={motyw.textSecondary} />
              <View style={styles.trescPozycji}>
                <ThemedText type="smallBold">
                  {p.nazwa} — {opisIlosci(p.gramy)}
                </ThemedText>
              </View>
            </Pressable>
          ))}
        </Karta>
      ))}

      {zrealizowaneSkladniki.length > 0 && (
        <ThemedText type="smallBold" themeColor="textSecondary">
          ZREALIZOWANE W POPRZEDNIEJ SESJI
        </ThemedText>
      )}

      {dzialyZrealizowane.map(({ dzial, pozycje: wDziale }) => (
        <Karta key={`zrealizowane-${dzial.nazwa}`}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {dzial.nazwa.toUpperCase()}
          </ThemedText>

          {wDziale.map((p) => (
            <View
              key={p.skladnik_id}
              style={[styles.pozycja, { borderColor: motyw.border }]}>
              <Ionicons name="checkbox" size={20} color={motyw.accent} />
              <View style={styles.trescPozycji}>
                <ThemedText type="small" themeColor="textSecondary">
                  {p.nazwa} — {opisIlosci(p.gramy)}
                </ThemedText>
              </View>
            </View>
          ))}
        </Karta>
      ))}

      {/*
        Dział ręczny zawsze na końcu — i wtedy, gdy jest pusty, bo to jedyne
        miejsce, w którym da się cokolwiek dopisać.
      */}
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {DZIAL_RECZNY.toUpperCase()}
        </ThemedText>

        {reczne.length === 0 ? (
          <ThemedText type="small" themeColor="textSecondary">
            Rzeczy spoza kuchni: worki na śmieci, papier śniadaniowy, gąbki. Nie wynikają
            z planu, więc czekają tu, aż je kupisz.
          </ThemedText>
        ) : (
          reczne.map((p) => (
            <View key={p.id} style={[styles.pozycja, { borderColor: motyw.border }]}>
              <Pressable
                onPress={() => odhaczReczny(p)}
                hitSlop={6}
                accessibilityRole="checkbox"
                accessibilityState={{ checked: false }}
                accessibilityLabel={`Kupione: ${p.nazwa}`}>
                <Ionicons name="square-outline" size={20} color={motyw.textSecondary} />
              </Pressable>

              <Pressable style={styles.trescPozycji} onPress={() => odhaczReczny(p)}>
                <ThemedText type="smallBold">
                  {p.nazwa}
                  {p.ilosc ? ` — ${p.ilosc}` : ''}
                </ThemedText>
              </Pressable>

              <Pressable
                onPress={() => skasujReczny(p)}
                hitSlop={8}
                accessibilityRole="button"
                accessibilityLabel={`Usuń ${p.nazwa} z listy`}>
                <Ionicons name="close" size={18} color={motyw.textSecondary} />
              </Pressable>
            </View>
          ))
        )}

        {kontoId && (
          <DopiszProdukt
            historia={historia}
            juzNaLiscie={reczne.map((p) => p.nazwa)}
            onDodaj={async (nazwa, ilosc) => {
              await dodajReczny(kontoId, nazwa, ilosc);
              setReczne(await pobierzReczne(kontoId));
            }}
          />
        )}
      </Karta>

      {resztyRazem > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            RESZTKI Z OPAKOWAŃ
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Po ugotowaniu wszystkiego z listy zostanie około {opisIlosci(resztyRazem)} produktów.
            To one najczęściej lądują w koszu — warto dobrać przepis, który je zużyje.
          </ThemedText>
        </Karta>
      )}

      {odhaczoneRecznie > 0 && (
        <Przycisk
          tytul={`Zacznij nowe zakupy (odznacz ${odhaczoneRecznie})`}
          wariant="poboczny"
          onPress={async () => {
            if (!kontoId) return;
            setKupione(new Set());
            try {
              await wyczyscOdhaczenia(kontoId);
            } catch (e) {
              setBlad(komunikatBledu(e));
              pobierz();
            }
          }}
        />
      )}

      <ThemedText type="small" themeColor="textSecondary">
        Ptaszki są zapamiętane — możesz wyjść z aplikacji w połowie zakupów i wrócić
        do tego samego miejsca. Same ilości jedzenia przeliczają się z planu, więc po
        zmianie posiłków mogą się zmienić.
      </ThemedText>

      <Przycisk tytul="Wróć do planu" wariant="poboczny" onPress={() => wroc(powrot, '/')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  pozycja: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
  },
  trescPozycji: { flex: 1, gap: 2 },
  wcisnieta: { opacity: 0.7 },
});
