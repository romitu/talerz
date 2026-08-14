/**
 * Odczyt przepisów z bazy wraz z wyliczonym makro.
 *
 * Zasada projektu: makroskładników nigdy nie wpisujemy ręcznie. Wylicza je
 * widok `przepis_makro` w bazie, z gramatur składników. Ten plik tylko je czyta.
 */

import { supabase } from './supabase';

export type PoraPosilku = 'sniadanie' | 'obiad' | 'kolacja';
export type Kuchnia = 'srodziemnomorska' | 'azjatycka' | 'polska' | 'inna';
export type Widocznosc = 'prywatna' | 'zgloszona' | 'publiczna';

export type PrzepisZMakro = {
  id: string;
  nazwa: string;
  opis: string | null;
  pory: PoraPosilku[];
  kuchnie: Kuchnia[];
  trwalosc_dni: number;
  porcjowanie: 'waga' | 'sztuki';
  /** Ile porcji wychodzi — wyliczone przez bazę zgodnie ze sposobem porcjowania. */
  porcje_wyliczone: number | null;
  gramy_calosc: number | null;
  czas_przygotowania_min: number | null;
  czas_obrobki_min: number | null;
  sprzet: string[];
  przechowywanie: string | null;
  mozna_mrozic: boolean | null;
  ratunek: string | null;
  widocznosc: Widocznosc;
  autor_id: string | null;
  /** Wartości NA JEDNĄ PORCJĘ — bo to ona trafia na talerz. */
  kcal: number | null;
  bialko_g: number | null;
  tluszcz_g: number | null;
  wegle_g: number | null;
  blonnik_g: number | null;
  cukry_wolne_g: number | null;
  /** Wartości całego garnka. */
  kcal_calosc: number | null;
  bialko_g_calosc: number | null;
  gramy_porcji: number | null;
  nova_max: number | null;
  polubienia: number;
  polubiony: boolean;
};

export const OPIS_PORY: Record<PoraPosilku, string> = {
  sniadanie: 'Śniadanie',
  obiad: 'Obiad',
  kolacja: 'Kolacja',
};

export const OPIS_KUCHNI: Record<Kuchnia, string> = {
  srodziemnomorska: 'śródziemnomorska',
  azjatycka: 'azjatycka',
  polska: 'polska',
  inna: 'inna',
};

/** Łączny czas: przygotowanie plus obróbka termiczna. */
export function czasRazem(przygotowanie: number | null, obrobka: number | null): number | null {
  if (przygotowanie === null && obrobka === null) return null;
  return (przygotowanie ?? 0) + (obrobka ?? 0);
}

/** Opis trwałości dania w zrozumiałej formie. */
export function opisTrwalosci(dni: number): string {
  if (dni === 0) return 'tylko świeże';
  if (dni === 1) return 'najwyżej 1 dzień';
  return `najwyżej ${dni} dni`;
}

/**
 * Pobiera przepisy widoczne dla zalogowanego użytkownika.
 * Reguły dostępu w bazie same decydują, co pokazać — tutaj nie ma filtrowania.
 */
export async function pobierzPrzepisy(kontoId: string | undefined) {
  // Dwa zapytania zamiast jednego, bo `przepis_makro` jest WIDOKIEM.
  // Widok nie ma klucza obcego, więc Supabase nie potrafi go dołączyć
  // do przepisów automatycznie — łączymy je po stronie aplikacji.
  const [wynikPrzepisow, wynikMakro] = await Promise.all([
    supabase
      .from('przepisy')
      .select(
        `id, nazwa, opis, pory, kuchnie, trwalosc_dni, porcje, czas_przygotowania_min,
         czas_obrobki_min, sprzet, przechowywanie, mozna_mrozic, ratunek, porcjowanie,
         widocznosc, autor_id,
         polubienia (konto_id)`
      )
      .order('nazwa'),
    supabase
      .from('przepis_makro')
      .select(
        'przepis_id, porcje_wyliczone, gramy_porcji, gramy_calosc, kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, cukry_wolne_g, kcal_calosc, bialko_g_calosc, nova_max'
      ),
  ]);

  if (wynikPrzepisow.error) throw wynikPrzepisow.error;
  if (wynikMakro.error) throw wynikMakro.error;

  const makroWedlugPrzepisu = new Map(
    (wynikMakro.data ?? []).map((m) => [m.przepis_id as string, m])
  );

  return (wynikPrzepisow.data ?? []).map((p): PrzepisZMakro => {
    const makro = makroWedlugPrzepisu.get(p.id);
    const polubienia = (p.polubienia ?? []) as { konto_id: string }[];

    return {
      id: p.id,
      nazwa: p.nazwa,
      opis: p.opis,
      pory: p.pory ?? [],
      kuchnie: p.kuchnie ?? [],
      trwalosc_dni: p.trwalosc_dni,
      porcjowanie: p.porcjowanie,
      czas_przygotowania_min: p.czas_przygotowania_min,
      czas_obrobki_min: p.czas_obrobki_min,
      sprzet: p.sprzet ?? [],
      przechowywanie: p.przechowywanie,
      mozna_mrozic: p.mozna_mrozic,
      ratunek: p.ratunek,
      widocznosc: p.widocznosc,
      autor_id: p.autor_id,
      kcal: makro?.kcal ?? null,
      bialko_g: makro?.bialko_g ?? null,
      tluszcz_g: makro?.tluszcz_g ?? null,
      wegle_g: makro?.wegle_g ?? null,
      blonnik_g: makro?.blonnik_g ?? null,
      cukry_wolne_g: makro?.cukry_wolne_g ?? null,
      kcal_calosc: makro?.kcal_calosc ?? null,
      bialko_g_calosc: makro?.bialko_g_calosc ?? null,
      gramy_porcji: makro?.gramy_porcji ?? null,
      porcje_wyliczone: makro?.porcje_wyliczone ?? null,
      gramy_calosc: makro?.gramy_calosc ?? null,
      nova_max: makro?.nova_max ?? null,
      polubienia: polubienia.length,
      polubiony: kontoId ? polubienia.some((x) => x.konto_id === kontoId) : false,
    };
  });
}

/** Dodaje albo cofa polubienie. */
export async function przelaczPolubienie(przepisId: string, kontoId: string, polubiony: boolean) {
  if (polubiony) {
    const { error } = await supabase
      .from('polubienia')
      .delete()
      .eq('przepis_id', przepisId)
      .eq('konto_id', kontoId);
    if (error) throw error;
  } else {
    const { error } = await supabase
      .from('polubienia')
      .insert({ przepis_id: przepisId, konto_id: kontoId });
    if (error) throw error;
  }
}
