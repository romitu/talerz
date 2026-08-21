/**
 * Wspólne narzędzia do importu i eksportu przez plik Excel.
 *
 * Bez założeń o konkretnej tabeli — współdzielone przez
 * `import-eksport-przepisow.ts` i `import-eksport-skladnikow.ts`.
 */

import { Workbook } from 'exceljs';
import type { Row, Worksheet } from 'exceljs';

// =============================================================================
//  BASE64 <-> BAJTY, BEZ ŻADNYCH ZAŁOŻEŃ O ŚRODOWISKU
// =============================================================================
/*
  `Buffer` nie jest globalne w silniku JS aplikacji mobilnej, a `atob`/`btoa`
  bywają obecne albo nie, zależnie od wersji React Native i platformy. Zamiast
  zgadywać, co akurat jest dostępne, liczymy base64 sami — te same kilkanaście
  linijek działa identycznie na Androidzie, iOS i w przeglądarce.
*/
const ZNAKI_BASE64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';

export function bajtyDoBase64(bajty: Uint8Array): string {
  let wynik = '';
  for (let i = 0; i < bajty.length; i += 3) {
    const b0 = bajty[i];
    const b1 = i + 1 < bajty.length ? bajty[i + 1] : undefined;
    const b2 = i + 2 < bajty.length ? bajty[i + 2] : undefined;

    wynik += ZNAKI_BASE64[b0 >> 2];
    wynik += ZNAKI_BASE64[((b0 & 0x03) << 4) | (b1 === undefined ? 0 : b1 >> 4)];
    wynik += b1 === undefined ? '=' : ZNAKI_BASE64[((b1 & 0x0f) << 2) | (b2 === undefined ? 0 : b2 >> 6)];
    wynik += b2 === undefined ? '=' : ZNAKI_BASE64[b2 & 0x3f];
  }
  return wynik;
}

/**
 * Na webie `expo-document-picker` zwraca zawartość pliku jako pełny data URL
 * (`data:...;base64,AAAA…`), nie sam base64 — a znaki nazwy typu MIME
 * (litery, cyfry) przeszłyby przez filtr w `base64DoBajtow` bez zmian
 * i zepsułyby początek pliku. Ucinamy więc wszystko przed pierwszym
 * przecinkiem, jeśli tekst faktycznie jest data URL-em.
 */
export function bezPrefiksuDataUrl(tekst: string): string {
  const przecinek = tekst.indexOf(',');
  return tekst.startsWith('data:') && przecinek !== -1 ? tekst.slice(przecinek + 1) : tekst;
}

export function base64DoBajtow(base64: string): Uint8Array {
  const czysty = base64.replace(/[^A-Za-z0-9+/]/g, '');
  const odwrocone = new Map(Array.from(ZNAKI_BASE64).map((znak, i) => [znak, i]));
  const bajty: number[] = [];

  for (let i = 0; i < czysty.length; i += 4) {
    const a = odwrocone.get(czysty[i]) ?? 0;
    const b = odwrocone.get(czysty[i + 1]) ?? 0;
    const c = czysty[i + 2] !== undefined ? odwrocone.get(czysty[i + 2]) : undefined;
    const d = czysty[i + 3] !== undefined ? odwrocone.get(czysty[i + 3]) : undefined;

    bajty.push((a << 2) | (b >> 4));
    if (c !== undefined) bajty.push(((b & 0x0f) << 4) | (c >> 2));
    if (d !== undefined) bajty.push(((c! & 0x03) << 6) | d);
  }

  return new Uint8Array(bajty);
}

// =============================================================================
//  SŁOWNIKI: ETYKIETA W ARKUSZU <-> WARTOŚĆ W BAZIE
// =============================================================================

/** Etykieta po polsku -> klucz w bazie. Przyjmuje też sam klucz, na wypadek gdyby ktoś wpisał klucz zamiast etykiety. */
export function odwrotnySlownik<T extends string>(slownik: Record<T, string>): Map<string, T> {
  const mapa = new Map<string, T>();
  for (const [klucz, etykieta] of Object.entries(slownik) as [T, string][]) {
    mapa.set(etykieta.trim().toLowerCase(), klucz);
    mapa.set(String(klucz).trim().toLowerCase(), klucz);
  }
  return mapa;
}

/** Rozdzielacz list w jednej komórce (kategorie, kuchnie, sprzęt, tagi). */
export const ROZDZIELACZ = ';';

export function podzielListe(tekst: string): string[] {
  return tekst
    .split(ROZDZIELACZ)
    .map((x) => x.trim())
    .filter((x) => x.length > 0);
}

/** Klucz do dopasowania nazw — taki sam jak w bazie (migracja 0018): białe znaki złożone do jednej spacji, bez wielkości liter. */
export function kluczNazwy(nazwa: string): string {
  return nazwa.trim().replace(/\s+/g, ' ').toLowerCase();
}

// =============================================================================
//  ODCZYT KOMÓREK
// =============================================================================

export function tekstKomorki(wartosc: unknown): string {
  if (wartosc === null || wartosc === undefined) return '';
  if (typeof wartosc === 'object') {
    const w = wartosc as { text?: unknown; result?: unknown; richText?: { text: string }[] };
    if (Array.isArray(w.richText)) return w.richText.map((x) => x.text).join('');
    if (typeof w.text === 'string') return w.text;
    if (w.result !== undefined) return String(w.result);
    return '';
  }
  return String(wartosc);
}

export function liczbaKomorki(wartosc: unknown): number | null {
  if (wartosc === null || wartosc === undefined || wartosc === '') return null;
  if (typeof wartosc === 'number') return Number.isFinite(wartosc) ? wartosc : null;
  const tekst = tekstKomorki(wartosc).trim().replace(',', '.');
  if (tekst === '') return null;
  const n = Number(tekst);
  return Number.isFinite(n) ? n : null;
}

/** Nagłówki wiersza 1 -> numer kolumny. Kolejność kolumn w pliku nie ma znaczenia. */
export function mapaNaglowkow(arkusz: Worksheet): Map<string, number> {
  const mapa = new Map<string, number>();
  arkusz.getRow(1).eachCell({ includeEmpty: false }, (cel, kolumna) => {
    const naglowek = tekstKomorki(cel.value).trim();
    if (naglowek) mapa.set(naglowek, kolumna);
  });
  return mapa;
}

export function komorka(wiersz: Row, naglowki: Map<string, number>, nazwaKolumny: string): unknown {
  const kolumna = naglowki.get(nazwaKolumny);
  return kolumna === undefined ? undefined : wiersz.getCell(kolumna).value;
}

// =============================================================================
//  ZAPIS ARKUSZA
// =============================================================================

export function dodajArkuszTabeli(
  wb: Workbook,
  nazwa: string,
  naglowki: readonly string[],
  wiersze: unknown[][]
) {
  const arkusz = wb.addWorksheet(nazwa);
  arkusz.addRow([...naglowki]).font = { bold: true };
  for (const w of wiersze) arkusz.addRow(w);
  for (let i = 1; i <= naglowki.length; i++) {
    arkusz.getColumn(i).width = i === 1 ? 28 : 22;
  }
}

// =============================================================================
//  ODCZYT ARKUSZA
// =============================================================================

/**
 * Wczytuje plik .xlsx z base64 do gotowego `Workbook`.
 *
 * Błąd z JSZip/exceljs przy niepoprawnym pliku (np. „Can't find end of
 * central directory”) jest po angielsku i nic nie mówi użytkownikowi —
 * zamieniamy go tutaj, w jednym miejscu, na czytelny komunikat po polsku.
 */
export async function wczytajSkoroszyt(base64: string): Promise<Workbook> {
  const wb = new Workbook();
  try {
    await wb.xlsx.load(base64DoBajtow(base64).buffer as ArrayBuffer);
  } catch {
    throw new Error(
      'Nie udało się odczytać pliku — to nie jest poprawny plik .xlsx albo jest uszkodzony.'
    );
  }
  return wb;
}
