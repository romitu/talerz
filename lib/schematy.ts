/**
 * Schematy tygodnia — odczyt i zapis (migracja 0054).
 *
 * Przeliczenia bez bazy siedzą w `lib/schematy-uklad.ts`.
 */

import { supabase } from './supabase';
import type { PozycjaSchematu } from './schematy-uklad';

export type Schemat = {
  id: string;
  nazwa: string;
  dni: number;
  /** Ile dań (pozycji) ma schemat — do podpisu na liście. */
  liczbaDan: number;
};

/** Schematy konta, alfabetycznie. */
export async function pobierzSchematy(): Promise<Schemat[]> {
  const { data, error } = await supabase
    .from('schematy')
    .select('id, nazwa, dni, schemat_pozycje (count)')
    .order('nazwa');
  if (error) throw error;

  return (data ?? []).map((s) => {
    const licznik = s.schemat_pozycje as { count: number }[] | null;
    return { id: s.id, nazwa: s.nazwa, dni: s.dni, liczbaDan: licznik?.[0]?.count ?? 0 };
  });
}

export async function pobierzPozycjeSchematu(schematId: string): Promise<PozycjaSchematu[]> {
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

  return { ...schemat, liczbaDan: opcje.pozycje.length };
}

export async function usunSchemat(schematId: string) {
  const { error } = await supabase.from('schematy').delete().eq('id', schematId);
  if (error) throw error;
}

/** Nagłówek jednego schematu — do edytora. `null`, gdy go nie ma (albo jest cudzy). */
export async function pobierzSchemat(schematId: string): Promise<Omit<Schemat, 'liczbaDan'> | null> {
  const { data, error } = await supabase
    .from('schematy')
    .select('id, nazwa, dni')
    .eq('id', schematId)
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
