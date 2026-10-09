import { useState } from 'react';
import { useTranslation } from 'react-i18next';

import type { GrupaFiltrow } from '@/components/filtry-przepisow';
import {
  czasRazem,
  GLOWNE_BIALKA,
  KUCHNIE,
  RODZAJE_DAN,
  type GlowneBialko,
  type Kuchnia,
  type PrzepisZMakro,
  type RodzajDania,
} from '@/lib/przepisy';

/**
 * Przełączniki z danych, które przepis już ma — bez nowych etykiet.
 * Każdy włączony zawęża listę (szybkie I bez gotowania), inaczej niż rodzaj,
 * kuchnia i białko, gdzie zaznaczenie kilku opcji listę poszerza.
 */
type Przelacznik = 'szybkie' | 'na_zapas' | 'bez_gotowania';

/** Nazwy przełączników są w tłumaczeniach: `filtry.przelacznik.*`. */
const PRZELACZNIKI: Record<Przelacznik, { pasuje: (p: PrzepisZMakro) => boolean }> = {
  szybkie: {
    pasuje: (p) => {
      const razem = czasRazem(p.czas_przygotowania_min, p.czas_obrobki_min);
      return razem !== null && razem <= 20;
    },
  },
  // Trwałość efektywna, czyli z własnym skróceniem tego konta — liczy się to,
  // ile danie wytrzyma u TEGO użytkownika.
  na_zapas: {
    pasuje: (p) => p.trwalosc_dni >= 3 || p.mozna_mrozic === true,
  },
  // Formularz przepisu zapisuje zero minut obróbki jako puste pole, a import
  // jako 0 — oba znaczą to samo: danie składane na zimno (migracja 0013).
  bez_gotowania: {
    pasuje: (p) => (p.czas_obrobki_min ?? 0) === 0,
  },
};

const KOLEJNOSC_PRZELACZNIKOW: Przelacznik[] = ['szybkie', 'na_zapas', 'bez_gotowania'];

/** Dodaje albo zdejmuje wartość z listy zaznaczonych. */
function przelaczNaLiscie<T>(lista: T[], wartosc: T): T[] {
  return lista.includes(wartosc) ? lista.filter((x) => x !== wartosc) : [...lista, wartosc];
}

/**
 * Filtry przepisów: rodzaj dania, kuchnia, główne białko i szybkie przełączniki.
 * Wspólne dla listy przepisów i wyboru dania w planerze — żeby w obu
 * miejscach „Zupy” i „Do 20 min” znaczyły dokładnie to samo.
 *
 * `bazaLicznikow` to przepisy, które użytkownik widzi przed filtrami (np. w bieżącej
 * zakładce albo w danej porze posiłku). Liczba przy opcji to wynik po jej
 * zaznaczeniu: przy pozostałych grupach bez zmian, z pominięciem własnej
 * grupy — inaczej przy zaznaczonych „Zupach” „Sałatki” pokazywałyby zero.
 */
export function useFiltryPrzepisow(bazaLicznikow: PrzepisZMakro[]) {
  const { t } = useTranslation();
  /**
   * `brak` to przepisy bez rodzaju / bez wyraźnego głównego białka — osobna
   * opcja, żeby luki w danych było widać, a nie żeby znikały z listy.
   */
  const [rodzaje, setRodzaje] = useState<(RodzajDania | 'brak')[]>([]);
  const [kuchnie, setKuchnie] = useState<(Kuchnia | 'brak')[]>([]);
  const [bialka, setBialka] = useState<(GlowneBialko | 'brak')[]>([]);
  const [przelaczniki, setPrzelaczniki] = useState<Przelacznik[]>([]);
  const [otwarte, setOtwarte] = useState(false);

  const pasujeRodzaj = (p: PrzepisZMakro) =>
    rodzaje.length === 0 ||
    rodzaje.some((r) => (r === 'brak' ? p.rodzaje.length === 0 : p.rodzaje.includes(r)));
  const pasujeKuchnia = (p: PrzepisZMakro) =>
    kuchnie.length === 0 ||
    kuchnie.some((k) => (k === 'brak' ? p.kuchnie.length === 0 : p.kuchnie.includes(k)));
  const pasujeBialko = (p: PrzepisZMakro) =>
    bialka.length === 0 ||
    bialka.some((b) => (b === 'brak' ? p.glowne_bialko === null : p.glowne_bialko === b));
  const pasujePrzelaczniki = (p: PrzepisZMakro) => przelaczniki.every((k) => PRZELACZNIKI[k].pasuje(p));

  const pasuje = (p: PrzepisZMakro) =>
    pasujeRodzaj(p) && pasujeKuchnia(p) && pasujeBialko(p) && pasujePrzelaczniki(p);
  const liczbaFiltrow = rodzaje.length + kuchnie.length + bialka.length + przelaczniki.length;

  const bazaRodzaju = bazaLicznikow.filter((p) => pasujeKuchnia(p) && pasujeBialko(p) && pasujePrzelaczniki(p));
  const bazaKuchni = bazaLicznikow.filter((p) => pasujeRodzaj(p) && pasujeBialko(p) && pasujePrzelaczniki(p));
  const bazaBialka = bazaLicznikow.filter((p) => pasujeRodzaj(p) && pasujeKuchnia(p) && pasujePrzelaczniki(p));
  const bazaPrzelacznikow = bazaLicznikow.filter(pasuje);

  const bezRodzaju = bazaRodzaju.filter((p) => p.rodzaje.length === 0).length;
  const bezKuchni = bazaKuchni.filter((p) => p.kuchnie.length === 0).length;
  const bezBialka = bazaBialka.filter((p) => p.glowne_bialko === null).length;

  const grupy: GrupaFiltrow[] = [
    {
      klucz: 'rodzaj',
      tytul: t('filtry.grupaRodzaj'),
      opcje: [
        ...RODZAJE_DAN.map((r) => ({
          klucz: `rodzaj-${r}`,
          etykieta: t(`rodzajSkrot.${r}`),
          ile: bazaRodzaju.filter((p) => p.rodzaje.includes(r)).length,
          wybrana: rodzaje.includes(r),
          onPress: () => setRodzaje((f) => przelaczNaLiscie(f, r)),
        })),
        ...(bezRodzaju > 0 || rodzaje.includes('brak')
          ? [
              {
                klucz: 'rodzaj-brak',
                etykieta: t('filtry.bezRodzaju'),
                ile: bezRodzaju,
                wybrana: rodzaje.includes('brak'),
                onPress: () => setRodzaje((f) => przelaczNaLiscie(f, 'brak' as const)),
              },
            ]
          : []),
      ],
    },
    {
      klucz: 'kuchnia',
      tytul: t('filtry.grupaKuchnia'),
      opcje: [
        ...KUCHNIE.map((k) => ({
          klucz: `kuchnia-${k}`,
          etykieta: t(`kuchniaSkrot.${k}`),
          ile: bazaKuchni.filter((p) => p.kuchnie.includes(k)).length,
          wybrana: kuchnie.includes(k),
          onPress: () => setKuchnie((f) => przelaczNaLiscie(f, k)),
        })),
        ...(bezKuchni > 0 || kuchnie.includes('brak')
          ? [
              {
                klucz: 'kuchnia-brak',
                etykieta: t('filtry.bezKuchni'),
                ile: bezKuchni,
                wybrana: kuchnie.includes('brak'),
                onPress: () => setKuchnie((f) => przelaczNaLiscie(f, 'brak' as const)),
              },
            ]
          : []),
      ],
    },
    {
      klucz: 'bialko',
      tytul: t('filtry.grupaBialko'),
      opcje: [
        ...GLOWNE_BIALKA.map((b) => ({
          klucz: `bialko-${b}`,
          etykieta: t(`glowneBialkoSkrot.${b}`),
          ile: bazaBialka.filter((p) => p.glowne_bialko === b).length,
          wybrana: bialka.includes(b),
          onPress: () => setBialka((f) => przelaczNaLiscie(f, b)),
        })),
        ...(bezBialka > 0 || bialka.includes('brak')
          ? [
              {
                klucz: 'bialko-brak',
                etykieta: t('filtry.bezBialka'),
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
      tytul: t('filtry.grupaSzybki'),
      opcje: KOLEJNOSC_PRZELACZNIKOW.map((k) => ({
        klucz: `przelacznik-${k}`,
        etykieta: t(`filtry.przelacznik.${k}`),
        ile: bazaPrzelacznikow.filter((p) => PRZELACZNIKI[k].pasuje(p)).length,
        wybrana: przelaczniki.includes(k),
        onPress: () => setPrzelaczniki((f) => przelaczNaLiscie(f, k)),
      })),
    },
  ];

  function wyczysc() {
    setRodzaje([]);
    setKuchnie([]);
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
