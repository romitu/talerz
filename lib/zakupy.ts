/**
 * Lista zakupów wyliczana z planu.
 *
 * Nie jest osobnym bytem w bazie — powstaje z tego, co stoi w planie.
 * Dzięki temu nie może się rozjechać z posiłkami: zmiana planu zmienia listę.
 */

import { supabase } from './supabase';

export type PozycjaZakupow = {
  skladnik_id: string;
  nazwa: string;
  gramy: number;
  tagi: string[];
  /** Wielkość opakowania w sklepie, jeśli znana. */
  opakowanie_g: number | null;
  /** Ile opakowań trzeba kupić. */
  opakowan: number | null;
  /** Ile zostanie po ugotowaniu wszystkiego z listy. */
  reszta_g: number | null;
  /** W ilu daniach składnik wystąpi. */
  dania: string[];
};

/** Działy sklepu — kolejność odpowiada typowej trasie po markecie. */
export const DZIALY: { nazwa: string; tagi: string[] }[] = [
  { nazwa: 'Warzywa i owoce', tagi: ['warzywo', 'owoc', 'ziola', 'suszone'] },
  { nazwa: 'Mięso i ryby', tagi: ['mieso', 'drob', 'ryba', 'owoce morza'] },
  { nazwa: 'Nabiał i jaja', tagi: ['nabial', 'jaja'] },
  { nazwa: 'Kasze, pieczywo, strączki', tagi: ['zboze', 'straczki'] },
  { nazwa: 'Orzechy i nasiona', tagi: ['orzechy', 'nasiona'] },
  { nazwa: 'Tłuszcze i przyprawy', tagi: ['tluszcz', 'przyprawa', 'slodzik', 'kakao'] },
  { nazwa: 'Pozostałe', tagi: [] },
];

export function dzialDla(tagi: string[]): string {
  for (const dzial of DZIALY) {
    if (dzial.tagi.some((t) => tagi.includes(t))) return dzial.nazwa;
  }
  return 'Pozostałe';
}

/**
 * Zbiera składniki ze wszystkich posiłków planu w podanym zakresie dat.
 *
 * Ilość każdego składnika mnożymy przez liczbę porcji w planie i dzielimy
 * przez liczbę porcji, na które rozpisany jest przepis — inaczej przy zupie
 * na sześć osób kupilibyśmy sześciokrotność tego, co potrzebne.
 */
export async function pobierzListeZakupow(
  planId: string,
  odData: string,
  doData: string
): Promise<PozycjaZakupow[]> {
  const { data: pozycje, error } = await supabase
    .from('plan_pozycje')
    .select('przepis_id, porcje, przepisy (nazwa)')
    .eq('plan_id', planId)
    .gte('data', odData)
    .lte('data', doData);

  if (error) throw error;
  if (!pozycje || pozycje.length === 0) return [];

  const idPrzepisow = [...new Set(pozycje.map((p) => p.przepis_id as string))];

  const [wynikSkladnikow, wynikMakro] = await Promise.all([
    supabase
      .from('przepis_skladniki')
      .select('przepis_id, skladnik_id, gramy, skladniki (nazwa, tagi, gramatura_opakowania_g)')
      .in('przepis_id', idPrzepisow),
    supabase.from('przepis_makro').select('przepis_id, porcje_wyliczone').in('przepis_id', idPrzepisow),
  ]);

  if (wynikSkladnikow.error) throw wynikSkladnikow.error;
  if (wynikMakro.error) throw wynikMakro.error;

  const porcjiWPrzepisie = new Map(
    (wynikMakro.data ?? []).map((m) => [m.przepis_id as string, Number(m.porcje_wyliczone) || 1])
  );

  const zebrane = new Map<string, PozycjaZakupow>();

  for (const pozycja of pozycje) {
    const przepisId = pozycja.przepis_id as string;
    const przepis = pozycja.przepisy as { nazwa: string } | { nazwa: string }[] | null;
    const nazwaDania = (Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa) ?? '';
    const naPorcje = porcjiWPrzepisie.get(przepisId) ?? 1;
    const mnoznik = (pozycja.porcje as number) / naPorcje;

    for (const s of wynikSkladnikow.data ?? []) {
      if (s.przepis_id !== przepisId) continue;

      type DaneSkladnika = {
        nazwa: string;
        tagi: string[];
        gramatura_opakowania_g: number | null;
      };
      // Supabase zwraca powiązanie raz jako obiekt, raz jako jednoelementową listę.
      const surowy = s.skladniki as unknown as DaneSkladnika | DaneSkladnika[] | null;
      const skladnik = Array.isArray(surowy) ? surowy[0] : surowy;
      if (!skladnik) continue;

      const id = s.skladnik_id as string;
      const wpis = zebrane.get(id) ?? {
        skladnik_id: id,
        nazwa: skladnik.nazwa,
        gramy: 0,
        tagi: skladnik.tagi ?? [],
        opakowanie_g: skladnik.gramatura_opakowania_g,
        opakowan: null,
        reszta_g: null,
        dania: [],
      };

      wpis.gramy += Number(s.gramy) * mnoznik;
      if (nazwaDania && !wpis.dania.includes(nazwaDania)) wpis.dania.push(nazwaDania);
      zebrane.set(id, wpis);
    }
  }

  // Przeliczenie na opakowania — ile kupić i ile zostanie.
  for (const wpis of zebrane.values()) {
    wpis.gramy = Math.round(wpis.gramy);
    if (wpis.opakowanie_g && wpis.opakowanie_g > 0) {
      wpis.opakowan = Math.ceil(wpis.gramy / wpis.opakowanie_g);
      wpis.reszta_g = wpis.opakowan * wpis.opakowanie_g - wpis.gramy;
    }
  }

  return [...zebrane.values()].sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl'));
}
