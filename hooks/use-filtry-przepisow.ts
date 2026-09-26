import { useState } from 'react';

import type { GrupaFiltrow } from '@/components/filtry-przepisow';
import {
  czasRazem,
  GLOWNE_BIALKA,
  RODZAJE_DAN,
  SKROT_BIALKA,
  SKROT_RODZAJU,
  type GlowneBialko,
  type PrzepisZMakro,
  type RodzajDania,
} from '@/lib/przepisy';

/**
 * Przełączniki z danych, które przepis już ma — bez nowych etykiet.
 * Każdy włączony zawęża listę (szybkie I bez gotowania), inaczej niż rodzaj
 * i białko, gdzie zaznaczenie kilku opcji listę poszerza.
 */
type Przelacznik = 'szybkie' | 'na_zapas' | 'bez_gotowania';

const PRZELACZNIKI: Record<Przelacznik, { etykieta: string; pasuje: (p: PrzepisZMakro) => boolean }> = {
  szybkie: {
    etykieta: 'Do 20 min',
    pasuje: (p) => {
      const razem = czasRazem(p.czas_przygotowania_min, p.czas_obrobki_min);
      return razem !== null && razem <= 20;
    },
  },
  // Trwałość efektywna, czyli z własnym skróceniem tego konta — liczy się to,
  // ile danie wytrzyma u TEGO użytkownika.
  na_zapas: {
    etykieta: 'Na zapas',
    pasuje: (p) => p.trwalosc_dni >= 3 || p.mozna_mrozic === true,
  },
  // Formularz przepisu zapisuje zero minut obróbki jako puste pole, a import
  // jako 0 — oba znaczą to samo: danie składane na zimno (migracja 0013).
  bez_gotowania: {
    etykieta: 'Bez gotowania',
    pasuje: (p) => (p.czas_obrobki_min ?? 0) === 0,
  },
};

const KOLEJNOSC_PRZELACZNIKOW: Przelacznik[] = ['szybkie', 'na_zapas', 'bez_gotowania'];

/** Dodaje albo zdejmuje wartość z listy zaznaczonych. */
function przelaczNaLiscie<T>(lista: T[], wartosc: T): T[] {
  return lista.includes(wartosc) ? lista.filter((x) => x !== wartosc) : [...lista, wartosc];
}

/**
 * Filtry przepisów: rodzaj dania, główne białko i szybkie przełączniki.
 * Wspólne dla listy przepisów i wyboru dania w planerze — żeby w obu
 * miejscach „Zupy” i „Do 20 min” znaczyły dokładnie to samo.
 *
 * `bazaLicznikow` to przepisy, które użytkownik widzi przed filtrami (np. w bieżącej
 * zakładce albo w danej porze posiłku). Liczba przy opcji to wynik po jej
 * zaznaczeniu: przy pozostałych grupach bez zmian, z pominięciem własnej
 * grupy — inaczej przy zaznaczonych „Zupach” „Sałatki” pokazywałyby zero.
 */
export function useFiltryPrzepisow(bazaLicznikow: PrzepisZMakro[]) {
  /**
   * `brak` to przepisy bez rodzaju / bez wyraźnego głównego białka — osobna
   * opcja, żeby luki w danych było widać, a nie żeby znikały z listy.
   */
  const [rodzaje, setRodzaje] = useState<(RodzajDania | 'brak')[]>([]);
  const [bialka, setBialka] = useState<(GlowneBialko | 'brak')[]>([]);
  const [przelaczniki, setPrzelaczniki] = useState<Przelacznik[]>([]);
  const [otwarte, setOtwarte] = useState(false);

  const pasujeRodzaj = (p: PrzepisZMakro) =>
    rodzaje.length === 0 ||
    rodzaje.some((r) => (r === 'brak' ? p.rodzaje.length === 0 : p.rodzaje.includes(r)));
  const pasujeBialko = (p: PrzepisZMakro) =>
    bialka.length === 0 ||
    bialka.some((b) => (b === 'brak' ? p.glowne_bialko === null : p.glowne_bialko === b));
  const pasujePrzelaczniki = (p: PrzepisZMakro) => przelaczniki.every((k) => PRZELACZNIKI[k].pasuje(p));

  const pasuje = (p: PrzepisZMakro) => pasujeRodzaj(p) && pasujeBialko(p) && pasujePrzelaczniki(p);
  const liczbaFiltrow = rodzaje.length + bialka.length + przelaczniki.length;

  const bazaRodzaju = bazaLicznikow.filter((p) => pasujeBialko(p) && pasujePrzelaczniki(p));
  const bazaBialka = bazaLicznikow.filter((p) => pasujeRodzaj(p) && pasujePrzelaczniki(p));
  const bazaPrzelacznikow = bazaLicznikow.filter(pasuje);

  const bezRodzaju = bazaRodzaju.filter((p) => p.rodzaje.length === 0).length;
  const bezBialka = bazaBialka.filter((p) => p.glowne_bialko === null).length;

  const grupy: GrupaFiltrow[] = [
    {
      klucz: 'rodzaj',
      tytul: 'Rodzaj dania',
      opcje: [
        ...RODZAJE_DAN.map((r) => ({
          klucz: `rodzaj-${r}`,
          etykieta: SKROT_RODZAJU[r],
          ile: bazaRodzaju.filter((p) => p.rodzaje.includes(r)).length,
          wybrana: rodzaje.includes(r),
          onPress: () => setRodzaje((f) => przelaczNaLiscie(f, r)),
        })),
        ...(bezRodzaju > 0 || rodzaje.includes('brak')
          ? [
              {
                klucz: 'rodzaj-brak',
                etykieta: 'Bez rodzaju',
                ile: bezRodzaju,
                wybrana: rodzaje.includes('brak'),
                onPress: () => setRodzaje((f) => przelaczNaLiscie(f, 'brak' as const)),
              },
            ]
          : []),
      ],
    },
    {
      klucz: 'bialko',
      tytul: 'Główne białko — wyliczone ze składników',
      opcje: [
        ...GLOWNE_BIALKA.map((b) => ({
          klucz: `bialko-${b}`,
          etykieta: SKROT_BIALKA[b],
          ile: bazaBialka.filter((p) => p.glowne_bialko === b).length,
          wybrana: bialka.includes(b),
          onPress: () => setBialka((f) => przelaczNaLiscie(f, b)),
        })),
        ...(bezBialka > 0 || bialka.includes('brak')
          ? [
              {
                klucz: 'bialko-brak',
                etykieta: 'Bez wyraźnego',
                ile: bezBialka,
                wybrana: bialka.includes('brak'),
                onPress: () => setBialka((f) => przelaczNaLiscie(f, 'brak' as const)),
              },
            ]
          : []),
      ],
    },
    {
      klucz: 'przelaczniki',
      tytul: 'Szybki wybór',
      opcje: KOLEJNOSC_PRZELACZNIKOW.map((k) => ({
        klucz: `przelacznik-${k}`,
        etykieta: PRZELACZNIKI[k].etykieta,
        ile: bazaPrzelacznikow.filter((p) => PRZELACZNIKI[k].pasuje(p)).length,
        wybrana: przelaczniki.includes(k),
        onPress: () => setPrzelaczniki((f) => przelaczNaLiscie(f, k)),
      })),
    },
  ];

  function wyczysc() {
    setRodzaje([]);
    setBialka([]);
    setPrzelaczniki([]);
  }

  return {
    pasuje,
    liczbaFiltrow,
    wyczysc,
    /** Gotowe do przekazania komponentowi `FiltryPrzepisow`. */
    wlasciwosci: {
      grupy,
      otwarte,
      onPrzelaczOtwarte: () => setOtwarte((x) => !x),
      onWyczysc: wyczysc,
    },
  };
}
