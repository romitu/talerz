/**
 * Schemat tygodnia — przeliczenia bez bazy danych.
 *
 * Osobny plik, żeby dało się go testować w Node (patrz
 * `testy/test-schematy.ts`): `lib/schematy.ts` ciągnie klienta Supabase.
 *
 * Schemat to tydzień bez dat. Dzień jest numerem od zera, a posiłki
 * z jednego garnka łączy wspólny numer `gotowanie` — odpowiednik `partia_id`
 * z planu, tyle że lokalny dla schematu.
 */

import type { PoraPosilku } from './przepisy';

export type PozycjaSchematu = {
  dzien: number;
  pora: PoraPosilku;
  /** `null` = przepis usunięty od czasu zapisu schematu. */
  przepis_id: string | null;
  nazwa: string;
  gotowanie: number;
  kolejnosc: number;
};

/** Pozycja planu w kształcie potrzebnym do zapisu schematu. */
type PozycjaZPlanu = {
  data: string;
  pora: PoraPosilku;
  przepis_id: string;
  nazwa: string;
  partia_id: string | null;
  kolejnosc: number;
};

const KOLEJNOSC_PORY: Record<PoraPosilku, number> = {
  sniadanie: 0,
  obiad: 1,
  kolacja: 2,
  dodatek: 3,
};

const DOBA_MS = 86400000;

/**
 * Najdłuższy schemat: tydzień. Schemat wstawia się do tygodnia, więc dłuższy
 * nie ma zastosowania. Baza pilnuje tego samego (migracja 0059).
 */
export const MAX_DNI_SCHEMATU = 7;

function dniOd(start: string, data: string): number {
  return Math.round((Date.parse(data) - Date.parse(start)) / DOBA_MS);
}

/**
 * Zamienia tydzień planu na schemat.
 *
 * Garnki numerujemy w kolejności pierwszego pojawienia się. Pozycja bez
 * `partia_id` (starsze wpisy) to osobne gotowanie — tak samo traktuje ją
 * `powtorzTydzien`. Pozycje spoza tygodnia (np. sprzed `dataStart`) odpadają.
 */
export function schematZPlanu(
  pozycje: PozycjaZPlanu[],
  dataStart: string,
  dni: number,
  /**
   * Przepisy gotowane zawsze w całości (zupy). Garnek takiego dania, który
   * wychodzi poza schemat (plan dłuższy niż tydzień), odpada w całości —
   * przycięta zupa to ułamek garnka na liście zakupów.
   */
  niepodzielne: Set<string> = new Set()
): PozycjaSchematu[] {
  const dlugosc = Math.min(dni, MAX_DNI_SCHEMATU);
  const zDniami = pozycje.map((p) => ({ ...p, dzien: dniOd(dataStart, p.data) }));
  const ucieteZupy = new Set(
    zDniami
      .filter((p) => p.partia_id !== null && niepodzielne.has(p.przepis_id) && (p.dzien < 0 || p.dzien >= dlugosc))
      .map((p) => p.partia_id)
  );
  const posortowane = zDniami
    .filter((p) => p.dzien >= 0 && p.dzien < dlugosc && !(p.partia_id !== null && ucieteZupy.has(p.partia_id)))
    .sort(
      (a, b) =>
        a.dzien - b.dzien || KOLEJNOSC_PORY[a.pora] - KOLEJNOSC_PORY[b.pora] || a.kolejnosc - b.kolejnosc
    );

  const numery = new Map<string, number>();
  let nastepny = 0;

  return posortowane.map((p) => {
    let gotowanie: number;
    if (p.partia_id === null) {
      gotowanie = nastepny++;
    } else {
      const znany = numery.get(p.partia_id);
      gotowanie = znany ?? nastepny++;
      if (znany === undefined) numery.set(p.partia_id, gotowanie);
    }
    return {
      dzien: p.dzien,
      pora: p.pora,
      przepis_id: p.przepis_id,
      nazwa: p.nazwa,
      gotowanie,
      kolejnosc: p.kolejnosc,
    };
  });
}

/**
 * Dzień, od którego „udajemy”, że leży schemat, żeby przepuścić go przez
 * `powtorzTydzien`. Data jest dowolna — liczą się tylko odstępy między dniami.
 */
export const START_SCHEMATU = '2000-01-03';

function dataDnia(dzien: number): string {
  return new Date(Date.parse(START_SCHEMATU) + dzien * DOBA_MS).toISOString().slice(0, 10);
}

/**
 * Pozycje schematu jako źródło dla `powtorzTydzien` (z `odDaty: START_SCHEMATU`).
 *
 * Rozdziela to, czego przenieść się nie da, i mówi o tym wprost, zamiast
 * po cichu gubić:
 *  - `usuniete` — dania, których przepisu już nie ma,
 *  - `wykluczone` — dania ze składnikiem „Nie jemy”,
 *  - `niedostepne` — dania z przepisu, którego to konto nie widzi (np.
 *    prywatny przepis dietetyka); sprawdzane, gdy podano `dostepnePrzepisy`.
 * Odpada wtedy cały garnek, a nie jeden jego dzień — przeniesienie połowy
 * garnka to ugotowanie za dużo i wyrzucenie reszty.
 */
export function zrodloZeSchematu(
  pozycje: PozycjaSchematu[],
  wykluczonePrzepisy: Set<string>,
  dostepnePrzepisy?: Set<string>
): {
  zrodlo: { data: string; pora: PoraPosilku; przepis_id: string; nazwa: string; partia_id: string }[];
  usuniete: number;
  wykluczone: number;
  niedostepne: number;
} {
  const odpadajaceGotowania = new Set<number>();
  let usuniete = 0;
  let wykluczone = 0;
  let niedostepne = 0;

  for (const p of pozycje) {
    if (p.przepis_id === null) {
      usuniete++;
      odpadajaceGotowania.add(p.gotowanie);
    } else if (dostepnePrzepisy && !dostepnePrzepisy.has(p.przepis_id)) {
      niedostepne++;
      odpadajaceGotowania.add(p.gotowanie);
    } else if (wykluczonePrzepisy.has(p.przepis_id)) {
      wykluczone++;
      odpadajaceGotowania.add(p.gotowanie);
    }
  }

  const zrodlo = pozycje
    .filter((p): p is PozycjaSchematu & { przepis_id: string } => !odpadajaceGotowania.has(p.gotowanie))
    .map((p) => ({
      data: dataDnia(p.dzien),
      pora: p.pora,
      przepis_id: p.przepis_id,
      nazwa: p.nazwa,
      partia_id: `gotowanie:${p.gotowanie}`,
    }));

  return { zrodlo, usuniete, wykluczone, niedostepne };
}

// =============================================================================
//  Edycja schematu (app/schematy.tsx)
// =============================================================================
//
// Wszystkie funkcje zwracają NOWĄ tablicę i nie ruszają wejściowej — edytor
// trzyma pozycje w stanie Reacta. Jedno miejsce (dzień × pora) to jedno
// danie: tak samo rozumie schemat `powtorzTydzien`, które drugie danie
// w tym samym posiłku traktowałoby jako kolizję i gubiło.

/** Pozycja zajmująca dane miejsce albo `undefined`. */
export function naMiejscu(pozycje: PozycjaSchematu[], dzien: number, pora: PoraPosilku) {
  return pozycje.find((p) => p.dzien === dzien && p.pora === pora);
}

/** Dni jednego garnka, rosnąco. */
export function dniGarnka(pozycje: PozycjaSchematu[], gotowanie: number): number[] {
  return pozycje
    .filter((p) => p.gotowanie === gotowanie)
    .map((p) => p.dzien)
    .sort((a, b) => a - b);
}

/**
 * Kolejne WOLNE dni tej pory od `dzien`, najwyżej `ile` — pierwsza
 * przeszkoda (zajęte miejsce albo koniec schematu) kończy serię. Ta sama
 * zasada co `dniGotowania` w `lib/automat.ts`: nie nadpisujemy tego,
 * co już stoi w schemacie.
 */
export function wolneDniOd(
  pozycje: PozycjaSchematu[],
  dzien: number,
  pora: PoraPosilku,
  ile: number,
  dni: number
): number[] {
  const wynik: number[] = [];
  for (let d = dzien; d < dni && wynik.length < Math.max(1, ile); d++) {
    if (naMiejscu(pozycje, d, pora)) break;
    wynik.push(d);
  }
  return wynik;
}

/**
 * Wstawia danie jako nowe gotowanie rozłożone na `ileDni` kolejnych wolnych
 * dni — tak jak ręczny wybór na planie, który bierze liczbę porcji bazowych
 * przepisu: obiad na 3 porcje od razu zajmuje trzy dni. Zajęte miejsce
 * startowe — bez zmian.
 */
export function dodajDanie(
  pozycje: PozycjaSchematu[],
  dzien: number,
  pora: PoraPosilku,
  przepis: { id: string; nazwa: string },
  ileDni = 1,
  dni = dzien + 1
): PozycjaSchematu[] {
  const dniGotowania = wolneDniOd(pozycje, dzien, pora, ileDni, Math.max(dni, dzien + 1));
  if (dniGotowania.length === 0) return pozycje;
  const gotowanie = pozycje.reduce((m, p) => Math.max(m, p.gotowanie), -1) + 1;
  return [
    ...pozycje,
    ...dniGotowania.map((d) => ({
      dzien: d,
      pora,
      przepis_id: przepis.id,
      nazwa: przepis.nazwa,
      gotowanie,
      kolejnosc: 1,
    })),
  ];
}

/**
 * Dokłada garnkowi kolejny dzień tej samej pory — „ugotuj raz, zjedz też
 * jutro”. Nie przeskakuje dni: następny dzień musi być wolny i mieścić się
 * w schemacie, inaczej bez zmian.
 */
export function przedluzGarnek(pozycje: PozycjaSchematu[], gotowanie: number, dni: number): PozycjaSchematu[] {
  const garnek = pozycje.filter((p) => p.gotowanie === gotowanie);
  if (garnek.length === 0) return pozycje;
  const ostatni = garnek.reduce((a, b) => (b.dzien > a.dzien ? b : a));
  const nastepny = ostatni.dzien + 1;
  if (nastepny >= dni || naMiejscu(pozycje, nastepny, ostatni.pora)) return pozycje;
  return [...pozycje, { ...ostatni, dzien: nastepny }];
}

/**
 * Usuwa jeden dzień garnka. Garnek zostaje jednym gotowaniem na pozostałe dni
 * (mniej porcji). Usunięcie jedynego dnia usuwa danie. O zupie, której nie
 * wolno przyciąć, decyduje wołający — wtedy woła `usunGarnek`.
 */
export function usunDzienGarnka(pozycje: PozycjaSchematu[], gotowanie: number, dzien: number): PozycjaSchematu[] {
  return pozycje.filter((p) => !(p.gotowanie === gotowanie && p.dzien === dzien));
}

/** Zabiera garnkowi ostatni dzień. Garnek jednodniowy zostaje — od tego jest `usunGarnek`. */
export function skrocGarnek(pozycje: PozycjaSchematu[], gotowanie: number): PozycjaSchematu[] {
  const dniG = dniGarnka(pozycje, gotowanie);
  if (dniG.length < 2) return pozycje;
  const ostatni = dniG[dniG.length - 1];
  return pozycje.filter((p) => !(p.gotowanie === gotowanie && p.dzien === ostatni));
}

export function usunGarnek(pozycje: PozycjaSchematu[], gotowanie: number): PozycjaSchematu[] {
  return pozycje.filter((p) => p.gotowanie !== gotowanie);
}

/**
 * Zmienia długość schematu. Dni za nowym końcem odpadają; garnek, który
 * na nie zachodził, po prostu się skraca — to dalej jedno gotowanie,
 * tylko na mniej dni.
 */
export function zmienDlugosc(pozycje: PozycjaSchematu[], dni: number): PozycjaSchematu[] {
  return pozycje.filter((p) => p.dzien < dni);
}
