/**
 * Role składników przy skalowaniu przepisu na inną liczbę porcji.
 *
 * Siedem stałych wierszy (migracja 0031, przeniesionych z prototypu
 * ROLE_RB.html) — edytowalny jest tylko `wzor`, reszta to dokumentacja.
 * Zapis wymaga uprawnień moderatora; zwykły użytkownik widzi tabelę,
 * ale próba zapisu skończy się komunikatem z bazy.
 */

import { supabase } from './supabase';

export type RolaSkladnika = {
  klucz: string;
  kolejnosc: number;
  etykieta: string;
  opis_roli: string;
  wzor: string;
  kiedy_uzywac: string;
  przyklady: string[];
};

const POLA = 'klucz, kolejnosc, etykieta, opis_roli, wzor, kiedy_uzywac, przyklady';

export async function pobierzRoleSkladnikow(): Promise<RolaSkladnika[]> {
  const { data, error } = await supabase.from('role_skladnikow').select(POLA).order('kolejnosc');
  if (error) throw error;
  return (data ?? []) as unknown as RolaSkladnika[];
}

/** Zapisuje wzór jednej roli. Pusty wzór nie ma sensu — rola zawsze coś opisuje. */
export async function zapiszWzorRoli(klucz: string, wzor: string): Promise<void> {
  const tresc = wzor.trim();
  if (!tresc) throw new Error('Wzór nie może być pusty.');

  const { error } = await supabase.from('role_skladnikow').update({ wzor: tresc }).eq('klucz', klucz);
  if (error) throw error;
}
