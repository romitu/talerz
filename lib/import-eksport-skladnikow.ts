/**
 * Import i eksport katalogu składników przez plik Excel.
 *
 * ZASADA DOPASOWANIA: NAZWA
 * --------------------------
 * Tak samo jak przy przepisach (`import-eksport-przepisow.ts`): składnik
 * rozpoznawany jest PO NAZWIE, bez względu na wielkość liter i białe znaki.
 * Nazwa identyczna z już istniejącym składnikiem = AKTUALIZACJA jego wartości
 * odżywczych. Nowa nazwa = nowy składnik.
 *
 * Import jest ATOMOWY NA SKŁADNIK — błąd w jednym wierszu (np. suma makro
 * powyżej 100 g) odrzuca tylko ten wiersz, reszta pliku importuje się
 * normalnie. Walidacja jest identyczna jak w formularzu składnika
 * (`sprawdzSkladnik` w `lib/skladniki.ts`), więc plik nie ominie żadnej
 * reguły, którą wymusza ręczne dodawanie.
 */

import { Workbook } from 'exceljs';

import {
  bajtyDoBase64,
  dodajArkuszTabeli,
  komorka,
  kluczNazwy,
  liczbaKomorki,
  mapaNaglowkow,
  odwrotnySlownik,
  podzielListe,
  ROZDZIELACZ,
  tekstKomorki,
  wczytajSkoroszyt,
} from './import-eksport-wspolne';
import { sprawdzSkladnik, zapiszSkladnik, type DaneSkladnika, type Skladnik } from './skladniki';

const OPIS_ZRODLA: Record<Skladnik['zrodlo'], string> = {
  usda: 'USDA',
  open_food_facts: 'Open Food Facts',
  wlasne: 'Własne',
};

const ZRODLO_WEDLUG_ETYKIETY = odwrotnySlownik(OPIS_ZRODLA);

const NAGLOWKI_SKLADNIKOW = [
  'Nazwa',
  'Źródło',
  'Kalorie (kcal/100g)',
  'Białko (g/100g)',
  'Tłuszcz (g/100g)',
  'Węglowodany (g/100g)',
  'Błonnik (g/100g)',
  'Cukry ogółem (g/100g)',
  'Cukry wolne (g/100g)',
  'NOVA',
  'Gramatura opakowania (g)',
  'Masa sztuki (g)',
  'Tagi',
] as const;

function nazwaPlikuInstrukcji(): string[] {
  return [
    'TALERZ — eksport składników',
    '',
    'Import rozpoznaje składnik PO NAZWIE (bez względu na wielkość liter). Jeśli',
    'w bazie jest już składnik o identycznej nazwie, jego wartości odżywcze',
    'zostaną ZASTĄPIONE tym, co jest w tym pliku. Nowa nazwa = nowy składnik.',
    '',
    'Wszystkie wartości liczbowe podaje się na 100 g produktu.',
    `Źródło: ${Object.values(OPIS_ZRODLA).join(' / ')} — puste pole liczy się jako „Własne”.`,
    'NOVA: liczba całkowita od 1 do 4, opcjonalnie.',
    'Gramatura opakowania i Masa sztuki: opcjonalne, w gramach.',
    'Tagi: kilka naraz, oddzielone średnikiem.',
    '',
    'Wiersz odrzucony przez walidację (np. suma białka, tłuszczu i węglowodanów',
    'powyżej 100 g) nie blokuje importu reszty pliku — trafia tylko do listy błędów.',
  ];
}

/** Buduje plik .xlsx z podanych składników i zwraca go jako base64 — gotowe do zapisu na dysk. */
export async function eksportujSkladniki(skladniki: Skladnik[]): Promise<string> {
  const wb = new Workbook();
  wb.creator = 'Talerz';
  wb.created = new Date();

  const instrukcja = wb.addWorksheet('Instrukcja');
  instrukcja.getColumn(1).width = 100;
  nazwaPlikuInstrukcji().forEach((linia) => instrukcja.addRow([linia]));

  const wiersze = skladniki.map((s) => [
    s.nazwa,
    OPIS_ZRODLA[s.zrodlo],
    s.kcal_100g,
    s.bialko_100g,
    s.tluszcz_100g,
    s.wegle_100g,
    s.blonnik_100g,
    s.cukry_ogolem_100g,
    s.cukry_wolne_100g,
    s.nova ?? '',
    s.gramatura_opakowania_g ?? '',
    s.masa_sztuki_g ?? '',
    s.tagi.join(`${ROZDZIELACZ} `),
  ]);
  dodajArkuszTabeli(wb, 'Składniki', NAGLOWKI_SKLADNIKOW, wiersze);

  const bufor = await wb.xlsx.writeBuffer();
  return bajtyDoBase64(new Uint8Array(bufor as ArrayBuffer));
}

// =============================================================================
//  IMPORT — WCZYTANIE I WALIDACJA
// =============================================================================

export type BladImportuSkladnika = {
  skladnik: string | null;
  tresc: string;
};

export type WynikWczytaniaSkladnikow = {
  /** Tylko składniki, które przeszły walidację — reszta trafiła do `bledy`. */
  skladniki: DaneSkladnika[];
  bledy: BladImportuSkladnika[];
};

/** Wczytuje plik .xlsx (base64) i zwraca gotowe do zapisania składniki. */
export async function wczytajPlikSkladnikow(base64: string): Promise<WynikWczytaniaSkladnikow> {
  const wb = await wczytajSkoroszyt(base64);

  const arkusz = wb.getWorksheet('Składniki');
  if (!arkusz) {
    return { skladniki: [], bledy: [{ skladnik: null, tresc: 'W pliku brakuje arkusza „Składniki”.' }] };
  }

  const nagl = mapaNaglowkow(arkusz);
  const bledy: BladImportuSkladnika[] = [];
  const gotowe = new Map<string, DaneSkladnika>();

  arkusz.eachRow({ includeEmpty: false }, (wiersz, numer) => {
    if (numer === 1) return;

    const nazwa = tekstKomorki(komorka(wiersz, nagl, 'Nazwa')).trim();
    if (!nazwa) return; // pusty wiersz — pomijamy po cichu, to nie błąd

    const klucz = kluczNazwy(nazwa);
    if (gotowe.has(klucz)) {
      bledy.push({
        skladnik: nazwa,
        tresc: `Wiersz ${numer}: nazwa „${nazwa}” powtarza się w pliku — druga pozycja pominięta.`,
      });
      return;
    }

    const etykietaZrodla = tekstKomorki(komorka(wiersz, nagl, 'Źródło')).trim().toLowerCase();
    const zrodlo = etykietaZrodla ? ZRODLO_WEDLUG_ETYKIETY.get(etykietaZrodla) : 'wlasne';
    if (!zrodlo) {
      bledy.push({ skladnik: nazwa, tresc: `Wiersz ${numer}: nieznane źródło „${etykietaZrodla}”.` });
      return;
    }

    const nova = liczbaKomorki(komorka(wiersz, nagl, 'NOVA'));

    const dane: DaneSkladnika = {
      nazwa,
      zrodlo,
      kcal_100g: liczbaKomorki(komorka(wiersz, nagl, 'Kalorie (kcal/100g)')) ?? NaN,
      bialko_100g: liczbaKomorki(komorka(wiersz, nagl, 'Białko (g/100g)')) ?? NaN,
      tluszcz_100g: liczbaKomorki(komorka(wiersz, nagl, 'Tłuszcz (g/100g)')) ?? NaN,
      wegle_100g: liczbaKomorki(komorka(wiersz, nagl, 'Węglowodany (g/100g)')) ?? NaN,
      blonnik_100g: liczbaKomorki(komorka(wiersz, nagl, 'Błonnik (g/100g)')) ?? 0,
      cukry_ogolem_100g: liczbaKomorki(komorka(wiersz, nagl, 'Cukry ogółem (g/100g)')) ?? 0,
      cukry_wolne_100g: liczbaKomorki(komorka(wiersz, nagl, 'Cukry wolne (g/100g)')) ?? 0,
      nova,
      gramatura_opakowania_g: liczbaKomorki(komorka(wiersz, nagl, 'Gramatura opakowania (g)')),
      masa_sztuki_g: liczbaKomorki(komorka(wiersz, nagl, 'Masa sztuki (g)')),
      tagi: podzielListe(tekstKomorki(komorka(wiersz, nagl, 'Tagi'))),
    };

    const problemy = sprawdzSkladnik(dane);
    if (problemy.length > 0) {
      bledy.push({ skladnik: nazwa, tresc: `Wiersz ${numer}: ${problemy[0]}` });
      return;
    }

    gotowe.set(klucz, dane);
  });

  return { skladniki: Array.from(gotowe.values()), bledy };
}

// =============================================================================
//  KLASYFIKACJA: CO JEST NOWE, CO JEST AKTUALIZACJĄ
// =============================================================================

export type PozycjaImportuSkladnika = {
  dane: DaneSkladnika;
  /** `null` = nowy składnik. W przeciwnym razie identyfikator istniejącego, który zostanie nadpisany. */
  istniejacyId: string | null;
};

export function sklasyfikujSkladniki(
  wczytane: DaneSkladnika[],
  istniejace: { id: string; nazwa: string }[]
): PozycjaImportuSkladnika[] {
  const idWedlugNazwy = new Map(istniejace.map((s) => [kluczNazwy(s.nazwa), s.id]));
  return wczytane.map((dane) => ({
    dane,
    istniejacyId: idWedlugNazwy.get(kluczNazwy(dane.nazwa)) ?? null,
  }));
}

// =============================================================================
//  ZAPIS DO BAZY
// =============================================================================

/** Zapisuje całą partię — składnik po składniku, nowy albo aktualizacja rozpoznanego po nazwie. */
export async function zaimportujSkladniki(
  pozycje: PozycjaImportuSkladnika[],
  poKazdym?: (zrobione: number, razem: number) => void
): Promise<{ bledy: BladImportuSkladnika[] }> {
  const bledy: BladImportuSkladnika[] = [];
  for (let i = 0; i < pozycje.length; i++) {
    const { dane, istniejacyId } = pozycje[i];
    try {
      await zapiszSkladnik(dane, istniejacyId ?? undefined);
    } catch (e) {
      bledy.push({ skladnik: dane.nazwa, tresc: e instanceof Error ? e.message : String(e) });
    }
    poKazdym?.(i + 1, pozycje.length);
  }
  return { bledy };
}
