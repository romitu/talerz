import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useMemo, useState } from 'react';

import { DopiszProdukt } from '@/components/dopisz-produkt';
import { Ekran } from '@/components/ekran';
import { KafelZakupu, SiatkaKafli } from '@/components/kafel-zakupu';
import { Karta } from '@/components/karta';
import { NaglowekZakupow } from '@/components/naglowek-zakupow';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { naDate } from '@/lib/plan';
import { useSesja } from '@/lib/sesja';
import { adresZdjeciaSkladnika } from '@/lib/zdjecia';
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
 * Zrealizowane W POPRZEDNIEJ SESJI — albo automatycznie (danie ugotowane
 * przed dzisiaj, patrz `zrealizowano_automatycznie` w lib/zakupy.ts), albo
 * odhaczone ręcznie, ale zanim ten ekran się otworzył.
 *
 * Celowo `przedSesja`, nie bieżący stan `kupione` — inaczej odhaczenie
 * TERAZ przerzucałoby pozycję do sekcji „poprzednia sesja" pod ręką
 * użytkownika, zamiast zostawić ją na aktualnej liście z ptaszkiem.
 */
function czyZrealizowany(p: PozycjaZakupow, przedSesja: Set<string>): boolean {
  return p.zrealizowano_automatycznie || przedSesja.has(kluczOdhaczenia(p));
}

export default function EkranZakupow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();
  const kontoId = sesja?.user.id;

  const [pozycje, setPozycje] = useState<PozycjaZakupow[]>([]);
  const [reczne, setReczne] = useState<ProduktReczny[]>([]);
  const [historia, setHistoria] = useState<string[]>([]);
  const [kupione, setKupione] = useState<Set<string>>(new Set());
  /** Migawka `kupione` sprzed otwarcia ekranu — patrz `czyZrealizowany`. */
  const [kupionePrzedSesja, setKupionePrzedSesja] = useState<Set<string>>(new Set());
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
        setKupionePrzedSesja(new Set(odhaczone));
      } catch (e) {
        setReczne([]);
        setHistoria([]);
        setKupione(new Set());
        setKupionePrzedSesja(new Set());
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
    for (const p of pozycje) (czyZrealizowany(p, kupionePrzedSesja) ? zrobione : aktualne).push(p);
    return {
      doKupienia: skonsolidujSkladniki(aktualne),
      zrealizowaneSkladniki: skonsolidujSkladniki(zrobione),
    };
  }, [pozycje, kupionePrzedSesja]);

  /** Czy pozycja została odhaczona TERAZ, w tej sesji (patrz `kupionePrzedSesja`). */
  function czyOdhaczonaWSesji(p: PozycjaSkonsolidowana): boolean {
    return p.zrodla.every((z) => kupione.has(kluczOdhaczenia({ ...z, skladnik_id: p.skladnik_id })));
  }

  function pogrupujWgDzialow(lista: PozycjaSkonsolidowana[]) {
    const mapa = new Map<string, PozycjaSkonsolidowana[]>();
    for (const p of lista) mapa.set(dzialDla(p.tagi), [...(mapa.get(dzialDla(p.tagi)) ?? []), p]);
    return DZIALY.map((dzial) => {
      const wDziale = mapa.get(dzial.nazwa);
      return wDziale && wDziale.length > 0 ? { dzial, pozycje: wDziale } : null;
    }).filter((x): x is NonNullable<typeof x> => x !== null);
  }

  /**
   * Odhaczone TERAZ pozycje schodzą na dół własnego działu, a dział cały
   * odhaczony — na dół całej aktualnej listy. Nigdy jednak poniżej sekcji
   * „zrealizowane w poprzedniej sesji" — ta zostaje osobnym blokiem niżej.
   */
  const dzialyDoKupienia = useMemo(() => {
    const grupy = pogrupujWgDzialow(doKupienia).map((g) => ({
      dzial: g.dzial,
      pozycje: [...g.pozycje].sort(
        (a, b) => Number(czyOdhaczonaWSesji(a)) - Number(czyOdhaczonaWSesji(b))
      ),
    }));
    return [...grupy].sort(
      (a, b) =>
        Number(a.pozycje.every(czyOdhaczonaWSesji)) - Number(b.pozycje.every(czyOdhaczonaWSesji))
    );
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [doKupienia, kupione]);
  const dzialyZrealizowane = useMemo(
    () => pogrupujWgDzialow(zrealizowaneSkladniki),
    [zrealizowaneSkladniki]
  );

  // Licznik w nagłówku liczy TERAZ odhaczone razem z tymi z poprzedniej
  // sesji — inaczej odhaczenie czegoś nie ruszałoby paska postępu, mimo że
  // pozycja fizycznie została kupiona (tylko wizualnie zostaje na aktualnej
  // liście, patrz `czyZrealizowany`).
  const zaznaczoneTeraz = doKupienia.filter(czyOdhaczonaWSesji).length;
  const zrealizowane = zrealizowaneSkladniki.length + zaznaczoneTeraz;
  const niezrealizowane = doKupienia.length - zaznaczoneTeraz + reczne.length;
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
   * Odhaczenie (albo cofnięcie) widoczne od razu, zapis w tle. Pozycja jest
   * już scalona, więc może nieść WIELE źródeł (kilka gotowań potrzebujących
   * tego samego składnika) — przełączamy je wszystkie naraz, bo kupno
   * jednego worka mąki pokrywa je wszystkie razem.
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
    const nowyStan = !czyOdhaczonaWSesji(pozycja);

    setKupione((p) => {
      const n = new Set(p);
      klucze.forEach((k) => (nowyStan ? n.add(k) : n.delete(k)));
      return n;
    });

    try {
      await Promise.all(
        pozycja.zrodla.map((z) =>
          ustawOdhaczenie(kontoId, z.zrodlo_typ, z.zrodlo_id, pozycja.skladnik_id, nowyStan)
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

  /*
    Dopóki jest tu coś niekupionego, dział wisi NA GÓRZE aktualnej listy —
    tak samo jak dowolny inny niedokończony dział (patrz sortowanie w
    `dzialyDoKupienia`). Inaczej rzeczy spoza kuchni ginęłyby pod już
    odhaczonym jedzeniem, które zjechało na dół. Gdy jest pusty, wraca na
    koniec (jedyne miejsce, w którym da się cokolwiek dopisać, i tak zawsze
    widoczny).
  */
  const dzialReczny = (
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
        <SiatkaKafli>
          {reczne.map((p) => (
            <KafelZakupu
              key={p.id}
              nazwa={p.nazwa}
              ilosc={p.ilosc}
              zdjecie={null}
              zrodlo={null}
              zaznaczona={false}
              onPress={() => odhaczReczny(p)}
              onUsun={() => skasujReczny(p)}
            />
          ))}
        </SiatkaKafli>
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
  );

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

      {reczne.length > 0 && dzialReczny}

      {dzialyDoKupienia.map(({ dzial, pozycje: wDziale }) => (
        <Karta key={`do-kupienia-${dzial.nazwa}`}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {dzial.nazwa.toUpperCase()}
          </ThemedText>

          <SiatkaKafli>
            {wDziale.map((p) => (
              <KafelZakupu
                key={p.skladnik_id}
                nazwa={p.nazwa}
                ilosc={opisIlosci(p.gramy)}
                zdjecie={adresZdjeciaSkladnika(p.zdjecie)}
                zrodlo={p.zdjecie_zrodlo}
                zaznaczona={czyOdhaczonaWSesji(p)}
                onPress={() => oznaczKupione(p)}
              />
            ))}
          </SiatkaKafli>
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

          <SiatkaKafli>
            {wDziale.map((p) => (
              <KafelZakupu
                key={p.skladnik_id}
                nazwa={p.nazwa}
                ilosc={opisIlosci(p.gramy)}
                zdjecie={adresZdjeciaSkladnika(p.zdjecie)}
                zrodlo={p.zdjecie_zrodlo}
                zaznaczona
              />
            ))}
          </SiatkaKafli>
        </Karta>
      ))}

      {reczne.length === 0 && dzialReczny}

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
