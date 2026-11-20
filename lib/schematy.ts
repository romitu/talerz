/**
 * Schematy tygodnia — odczyt i zapis (migracje 0054–0057).
 *
 * Przeliczenia bez bazy siedzą w `lib/schematy-uklad.ts`.
 */

import { supabase } from './supabase';
import type { PozycjaSchematu } from './schematy-uklad';

/**
 * Skąd schemat pochodzi — od tego zależy, jak czytać jego pozycje i co
 * wolno z nim zrobić:
 *  - `moje` — własny, edytowalny (0054),
 *  - `dietetyk` — udostępniony przez dietetyka, czytany tylko przez funkcje bazy (0056),
 *  - `katalog` — opublikowany przez moderatora dla wszystkich (0057).
 */
export type ZrodloSchematu = 'moje' | 'dietetyk' | 'katalog';

/** Kolejność grup na listach: własne, od dietetyka, katalog Talerza. */
export const GRUPY: ZrodloSchematu[] = ['moje', 'dietetyk', 'katalog'];

/** Klucz tłumaczenia nagłówka grupy. */
export const TYTUL_GRUPY = {
  moje: 'schematy.grupaMoje',
  dietetyk: 'schematy.grupaDietetyk',
  katalog: 'schematy.grupaKatalog',
} as const satisfies Record<ZrodloSchematu, string>;

export type Schemat = {
  id: string;
  nazwa: string;
  dni: number;
  /** Ile dań (pozycji) ma schemat — do podpisu na liście. */
  liczbaDan: number;
  zrodlo: ZrodloSchematu;
  /**
   * Zdjęcia pierwszych kilku dań (ścieżki w zasobniku) — do paska miniatur
   * na listach. Dla schematów od dietetyka zwraca je funkcja bazy (0058),
   * tylko z przepisów, które klient widzi.
   */
  zdjecia: string[];
  /** Własny schemat opublikowany w katalogu (publikuje tylko moderator). */
  publiczny: boolean;
  /** Dla `dietetyk`: kto udostępnił i dla którego profilu. */
  dietetyk?: string;
  profilId?: string;
  imie?: string;
};

type WierszSchematu = {
  id: string;
  nazwa: string;
  dni: number;
  publiczny: boolean;
  schemat_pozycje: { przepisy: { zdjecie: string | null } | { zdjecie: string | null }[] | null }[] | null;
};

/** Ile miniatur pokazujemy przy schemacie na liście. */
const MINIATUR = 4;

/** Pierwsze różne zdjęcia dań schematu, w kolejności dni. */
function zdjeciaZPozycji(pozycje: WierszSchematu['schemat_pozycje']): string[] {
  const wynik: string[] = [];
  for (const p of pozycje ?? []) {
    const przepis = Array.isArray(p.przepisy) ? p.przepisy[0] : p.przepisy;
    const z = przepis?.zdjecie;
    if (z && !wynik.includes(z)) wynik.push(z);
    if (wynik.length === MINIATUR) break;
  }
  return wynik;
}

function zWiersza(s: WierszSchematu, zrodlo: ZrodloSchematu): Schemat {
  return {
    id: s.id,
    nazwa: s.nazwa,
    dni: s.dni,
    liczbaDan: s.schemat_pozycje?.length ?? 0,
    zdjecia: zdjeciaZPozycji(s.schemat_pozycje),
    zrodlo,
    publiczny: s.publiczny,
  };
}

/**
 * Własne schematy konta, alfabetycznie.
 *
 * Filtr po koncie jest konieczny: reguły dostępu wpuszczają też schematy
 * publiczne (0057), a te mają się pokazywać osobno, w katalogu.
 */
export async function pobierzSchematy(kontoId: string): Promise<Schemat[]> {
  const { data, error } = await supabase
    .from('schematy')
    .select('id, nazwa, dni, publiczny, schemat_pozycje (dzien, przepisy (zdjecie))')
    .eq('konto_id', kontoId)
    .order('nazwa')
    .order('dzien', { referencedTable: 'schemat_pozycje' });
  if (error) throw error;
  return ((data ?? []) as WierszSchematu[]).map((s) => zWiersza(s, 'moje'));
}

/** Katalog Talerza: schematy opublikowane przez moderatorów, bez własnych. */
export async function pobierzKatalogSchematow(kontoId: string): Promise<Schemat[]> {
  const { data, error } = await supabase
    .from('schematy')
    .select('id, nazwa, dni, publiczny, schemat_pozycje (dzien, przepisy (zdjecie))')
    .eq('publiczny', true)
    .neq('konto_id', kontoId)
    .order('nazwa')
    .order('dzien', { referencedTable: 'schemat_pozycje' });
  if (error) throw error;
  return ((data ?? []) as WierszSchematu[]).map((s) => zWiersza(s, 'katalog'));
}

/** Schematy, które dietetycy udostępnili profilom tego konta (0056). */
export async function pobierzSchematyOdDietetyka(): Promise<Schemat[]> {
  const { data, error } = await supabase.rpc('schematy_od_dietetyka');
  if (error) throw error;
  type Wiersz = {
    schemat_id: string;
    nazwa: string;
    dni: number;
    liczba_dan: number;
    profil_id: string;
    imie: string;
    dietetyk: string | null;
    /** Od migracji 0058; przed nią funkcja tego pola nie zwraca. */
    zdjecia?: string[] | null;
  };
  return ((data ?? []) as Wiersz[]).map((s) => ({
    id: s.schemat_id,
    nazwa: s.nazwa,
    dni: s.dni,
    liczbaDan: s.liczba_dan,
    zrodlo: 'dietetyk',
    zdjecia: s.zdjecia ?? [],
    publiczny: false,
    dietetyk: s.dietetyk ?? undefined,
    profilId: s.profil_id,
    imie: s.imie,
  }));
}

/** Wszystko, co konto może wstawić do planu: własne, od dietetyka, z katalogu. */
export async function pobierzWszystkieSchematy(kontoId: string): Promise<Schemat[]> {
  const [moje, odDietetyka, katalog] = await Promise.all([
    pobierzSchematy(kontoId),
    pobierzSchematyOdDietetyka(),
    pobierzKatalogSchematow(kontoId),
  ]);
  return [...moje, ...odDietetyka, ...katalog];
}

export async function pobierzPozycjeSchematu(
  schematId: string,
  zrodlo: ZrodloSchematu = 'moje'
): Promise<PozycjaSchematu[]> {
  if (zrodlo === 'dietetyk') {
    const { data, error } = await supabase.rpc('schemat_od_dietetyka_pozycje', { p_schemat: schematId });
    if (error) throw error;
    return (data ?? []) as PozycjaSchematu[];
  }

  const { data, error } = await supabase
    .from('schemat_pozycje')
    .select('dzien, pora, przepis_id, nazwa, gotowanie, kolejnosc')
    .eq('schemat_id', schematId)
    .order('dzien')
    .order('kolejnosc');
  if (error) throw error;
  return (data ?? []) as PozycjaSchematu[];
}

/** Nazwa już zajęta na tym koncie (ograniczenie `schematy_nazwa_unikalna`). */
export class NazwaSchematuZajeta extends Error {}

/**
 * Zapisuje nowy schemat razem z pozycjami.
 *
 * Dwa zapytania, bez transakcji — Data API jej nie daje. Gdy wstawienie
 * pozycji się nie uda, kasujemy świeży nagłówek, żeby nie został pusty
 * schemat udający zapisany.
 */
export async function zapiszSchemat(opcje: {
  kontoId: string;
  nazwa: string;
  dni: number;
  pozycje: PozycjaSchematu[];
}): Promise<Schemat> {
  const nazwa = opcje.nazwa.trim();

  const { data: schemat, error } = await supabase
    .from('schematy')
    .insert({ konto_id: opcje.kontoId, nazwa, dni: opcje.dni })
    .select('id, nazwa, dni')
    .single();
  if (error) {
    if (error.code === '23505') throw new NazwaSchematuZajeta(nazwa);
    throw error;
  }

  if (opcje.pozycje.length > 0) {
    const { error: bladPozycji } = await supabase
      .from('schemat_pozycje')
      .insert(opcje.pozycje.map((p) => ({ ...p, schemat_id: schemat.id })));
    if (bladPozycji) {
      await supabase.from('schematy').delete().eq('id', schemat.id);
      throw bladPozycji;
    }
  }

  return { ...schemat, liczbaDan: opcje.pozycje.length, zdjecia: [], zrodlo: 'moje', publiczny: false };
}

export async function usunSchemat(schematId: string) {
  const { error } = await supabase.from('schematy').delete().eq('id', schematId);
  if (error) throw error;
}

/**
 * Nagłówek WŁASNEGO schematu — do edytora. `null`, gdy go nie ma albo jest
 * cudzy (także publiczny z katalogu: ten się kopiuje, nie edytuje).
 */
export async function pobierzSchemat(
  schematId: string,
  kontoId: string
): Promise<{ id: string; nazwa: string; dni: number } | null> {
  const { data, error } = await supabase
    .from('schematy')
    .select('id, nazwa, dni')
    .eq('id', schematId)
    .eq('konto_id', kontoId)
    .maybeSingle();
  if (error) throw error;
  return data;
}

/**
 * Zapis z edytora: nazwa, długość i wszystkie pozycje naraz, w jednej
 * transakcji po stronie bazy (funkcja `zapisz_schemat`, migracja 0055).
 */
export async function zapiszZmianySchematu(opcje: {
  schematId: string;
  nazwa: string;
  dni: number;
  pozycje: PozycjaSchematu[];
}) {
  const nazwa = opcje.nazwa.trim();
  const { error } = await supabase.rpc('zapisz_schemat', {
    p_schemat_id: opcje.schematId,
    p_nazwa: nazwa,
    p_dni: opcje.dni,
    p_pozycje: opcje.pozycje,
  });
  if (error) {
    if (error.code === '23505') throw new NazwaSchematuZajeta(nazwa);
    throw error;
  }
}

/**
 * Kopia schematu na własne konto — żeby schemat z katalogu czy od dietetyka
 * dało się przerobić w edytorze. Przy zajętej nazwie kolejny numer:
 * „X (kopia)”, „X (kopia 2)”…
 */
export async function skopiujSchemat(kontoId: string, s: Schemat, dopisek: string): Promise<Schemat> {
  const pozycje = await pobierzPozycjeSchematu(s.id, s.zrodlo);
  for (let nr = 1; nr < 20; nr++) {
    const numer = nr > 1 ? ` ${nr}` : '';
    const nazwa = `${s.nazwa} (${dopisek}${numer})`.slice(0, 80);
    try {
      return await zapiszSchemat({ kontoId, nazwa, dni: s.dni, pozycje });
    } catch (e) {
      if (!(e instanceof NazwaSchematuZajeta)) throw e;
    }
  }
  throw new NazwaSchematuZajeta(s.nazwa);
}

/**
 * Publikacja w katalogu nie przeszła. `niepubliczne` — ile dań ma przepis
 * prywatny albo usunięty; 0 = schemat pusty.
 */
export class SchematNiePublikowalny extends Error {
  niepubliczne: number;
  constructor(niepubliczne: number) {
    super(String(niepubliczne));
    this.niepubliczne = niepubliczne;
  }
}

/** Publikuje albo wycofuje własny schemat moderatora (0057). */
export async function ustawPublicznosc(schematId: string, publiczny: boolean) {
  const { error } = await supabase.rpc('ustaw_publicznosc_schematu', {
    p_schemat: schematId,
    p_publiczny: publiczny,
  });
  if (error) {
    if (error.code === '23514') throw new SchematNiePublikowalny(Number(error.hint ?? 0));
    throw error;
  }
}

// --- Dietetyk (0056) ---

export type SchematKlienta = { schemat_id: string; nazwa: string; dni: number; od: string };

/** Udostępnia własny schemat klientowi. Zwraca, ilu dań klient nie zobaczy. */
export async function udostepnijSchemat(schematId: string, profilId: string): Promise<number> {
  const { data, error } = await supabase.rpc('dietetyk_udostepnij_schemat', {
    p_schemat: schematId,
    p_profil: profilId,
  });
  if (error) throw error;
  return Number(data ?? 0);
}

export async function pobierzSchematyKlienta(profilId: string): Promise<SchematKlienta[]> {
  const { data, error } = await supabase.rpc('dietetyk_schematy_klienta', { p_profil: profilId });
  if (error) throw error;
  return (data ?? []) as SchematKlienta[];
}

/** Cofnięcie udostępnienia — przez dietetyka albo odrzucenie przez klienta. */
export async function cofnijUdostepnienie(schematId: string, profilId: string) {
  const { error } = await supabase
    .from('schematy_udostepnione')
    .delete()
    .eq('schemat_id', schematId)
    .eq('profil_id', profilId);
  if (error) throw error;
}
