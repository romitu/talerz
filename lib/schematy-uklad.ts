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
export function schematZPlanu(pozycje: PozycjaZPlanu[], dataStart: string, dni: number): PozycjaSchematu[] {
  const posortowane = pozycje
    .map((p) => ({ ...p, dzien: dniOd(dataStart, p.data) }))
    .filter((p) => p.dzien >= 0 && p.dzien < dni)
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
 *  - `wykluczone` — dania ze składnikiem „Nie jemy”.
 * Odpada wtedy cały garnek, a nie jeden jego dzień — przeniesienie połowy
 * garnka to ugotowanie za dużo i wyrzucenie reszty.
 */
export function zrodloZeSchematu(
  pozycje: PozycjaSchematu[],
  wykluczonePrzepisy: Set<string>
): {
  zrodlo: { data: string; pora: PoraPosilku; przepis_id: string; nazwa: string; partia_id: string }[];
  usuniete: number;
  wykluczone: number;
} {
  const odpadajaceGotowania = new Set<number>();
  let usuniete = 0;
  let wykluczone = 0;

  for (const p of pozycje) {
    if (p.przepis_id === null) {
      usuniete++;
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

  return { zrodlo, usuniete, wykluczone };
}
