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
  czas_minut: number | null;
  widocznosc: Widocznosc;
  autor_id: string | null;
  kcal: number | null;
  bialko_g: number | null;
  tluszcz_g: number | null;
  wegle_g: number | null;
  cukry_wolne_g: number | null;
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
        `id, nazwa, opis, pory, kuchnie, trwalosc_dni, czas_minut, widocznosc, autor_id,
         polubienia (konto_id)`
      )
      .order('nazwa'),
    supabase
      .from('przepis_makro')
      .select('przepis_id, kcal, bialko_g, tluszcz_g, wegle_g, cukry_wolne_g, nova_max'),
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
      czas_minut: p.czas_minut,
      widocznosc: p.widocznosc,
      autor_id: p.autor_id,
      kcal: makro?.kcal ?? null,
      bialko_g: makro?.bialko_g ?? null,
      tluszcz_g: makro?.tluszcz_g ?? null,
      wegle_g: makro?.wegle_g ?? null,
      cukry_wolne_g: makro?.cukry_wolne_g ?? null,
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
