/**
 * Plan tygodniowy — odczyt i zapis.
 *
 * Plan składa się z pozycji: dzień, pora posiłku, przepis i liczba porcji.
 * Wartości odżywcze pozycji wynikają z przepisu przeliczonego na porcje —
 * nigdy nie są zapisywane osobno, żeby nie rozjechały się z przepisem.
 */

import { supabase } from './supabase';
import type { PoraPosilku } from './przepisy';

export const PORY: PoraPosilku[] = ['sniadanie', 'obiad', 'kolacja'];

export type Plan = {
  id: string;
  data_start: string;
  dni: number;
};

export type PozycjaPlanu = {
  id: string;
  data: string;
  pora: PoraPosilku;
  przepis_id: string;
  nazwa: string;
  porcje: number;
  kolejnosc: number;
  zjedzone: boolean;
  /** Wspólny identyfikator dań ugotowanych jednym garnkiem. */
  partia_id: string | null;
  /** Waga jednej porcji przepisu w gramach. */
  gramy_porcji: number;
  /** Wartości jednej porcji przepisu. */
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number;
};

export type Makro = {
  kcal: number;
  bialko: number;
  tluszcz: number;
  wegle: number;
  blonnik: number;
};

/** Data w formacie zrozumiałym dla bazy: RRRR-MM-DD. */
export function naDate(d: Date): string {
  return d.toISOString().slice(0, 10);
}

/** Kolejne dni planu, począwszy od daty startu. */
export function dniPlanu(plan: Plan): string[] {
  const start = new Date(plan.data_start);
  return Array.from({ length: plan.dni }, (_, i) => {
    const d = new Date(start);
    d.setDate(start.getDate() + i);
    return naDate(d);
  });
}

/** Opis dnia po polsku: „środa, 13 sierpnia”. */
export function opisDnia(data: string): string {
  return new Date(data).toLocaleDateString('pl-PL', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
  });
}

export function czyDzisiaj(data: string): boolean {
  return data === naDate(new Date());
}

/** Pobiera najnowszy plan konta albo null, gdy żadnego jeszcze nie ma. */
export async function pobierzPlan(): Promise<Plan | null> {
  const { data, error } = await supabase
    .from('plany')
    .select('id, data_start, dni')
    .order('data_start', { ascending: false })
    .limit(1)
    .maybeSingle();

  if (error) throw error;
  return data;
}

/** Przesuwa datę początku istniejącego planu. */
export async function zmienDatePlanu(planId: string, dataStart: string) {
  const { error } = await supabase.from('plany').update({ data_start: dataStart }).eq('id', planId);
  if (error) throw error;
}

export async function utworzPlan(kontoId: string, dataStart: string, dni = 7): Promise<Plan> {
  const { data, error } = await supabase
    .from('plany')
    .insert({ konto_id: kontoId, data_start: dataStart, dni })
    .select('id, data_start, dni')
    .single();

  if (error) throw error;
  return data;
}

/**
 * Pozycje planu wraz z makro przepisów.
 *
 * Dwa zapytania, bo `przepis_makro` jest widokiem — nie da się go dołączyć
 * automatycznie, brakuje klucza obcego.
 */
export async function pobierzPozycje(planId: string): Promise<PozycjaPlanu[]> {
  const { data: pozycje, error } = await supabase
    .from('plan_pozycje')
    .select('id, data, pora, przepis_id, porcje, kolejnosc, zjedzone, partia_id, przepisy (nazwa)')
    .eq('plan_id', planId)
    .order('data')
    .order('kolejnosc');

  if (error) throw error;
  if (!pozycje || pozycje.length === 0) return [];

  const idPrzepisow = [...new Set(pozycje.map((p) => p.przepis_id as string))];

  const { data: makro, error: bladMakro } = await supabase
    .from('przepis_makro')
    .select('przepis_id, kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, gramy_porcji')
    .in('przepis_id', idPrzepisow);

  if (bladMakro) throw bladMakro;

  const wedlugPrzepisu = new Map((makro ?? []).map((m) => [m.przepis_id as string, m]));

  return pozycje.map((p): PozycjaPlanu => {
    const m = wedlugPrzepisu.get(p.przepis_id as string);
    const przepis = p.przepisy as { nazwa: string } | { nazwa: string }[] | null;

    return {
      id: p.id,
      data: p.data,
      pora: p.pora,
      przepis_id: p.przepis_id,
      nazwa: (Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa) ?? '(bez nazwy)',
      porcje: p.porcje,
      kolejnosc: p.kolejnosc,
      zjedzone: p.zjedzone,
      partia_id: p.partia_id,
      gramy_porcji: Number(m?.gramy_porcji ?? 0),
      kcal: Number(m?.kcal ?? 0),
      bialko_g: Number(m?.bialko_g ?? 0),
      tluszcz_g: Number(m?.tluszcz_g ?? 0),
      wegle_g: Number(m?.wegle_g ?? 0),
      blonnik_g: Number(m?.blonnik_g ?? 0),
    };
  });
}

/** Ocena białka w posiłku — liczona dla WSZYSTKICH dań tej pory razem. */
export function bialkoPosilku(dania: PozycjaPlanu[]): number {
  return dania.reduce((s, p) => s + p.bialko_g * p.porcje, 0);
}

/** Suma makro z podanych pozycji, z uwzględnieniem liczby porcji. */
export function sumujDzien(pozycje: PozycjaPlanu[]): Makro {
  return pozycje.reduce<Makro>(
    (s, p) => ({
      kcal: s.kcal + p.kcal * p.porcje,
      bialko: s.bialko + p.bialko_g * p.porcje,
      tluszcz: s.tluszcz + p.tluszcz_g * p.porcje,
      wegle: s.wegle + p.wegle_g * p.porcje,
      blonnik: s.blonnik + p.blonnik_g * p.porcje,
    }),
    { kcal: 0, bialko: 0, tluszcz: 0, wegle: 0, blonnik: 0 }
  );
}

/**
 * Dokłada danie do posiłku — razem z całą partią.
 *
 * Gotujesz raz, jesz kilka dni. Danie trafia więc nie na jeden dzień, tylko
 * na tyle kolejnych, ile pozwala jego trwałość — i tyle porcji dziennie,
 * ile osób je je. Wszystkie pozycje dostają wspólny identyfikator partii,
 * dzięki czemu usunięcie jednej usuwa cały garnek.
 *
 * @returns na ile dni rozłożono danie
 */
export async function dodajPartie(opcje: {
  kontoId: string;
  planId: string;
  odData: string;
  pora: PoraPosilku;
  przepisId: string;
  kolejnosc: number;
  /** Ile osób je ten posiłek. */
  osoby: number;
  /** Ile dni wytrzyma danie: 0 oznacza „tylko świeże”, czyli jeden dzień. */
  trwaloscDni: number;
  /** Dni planu od dnia dodania włącznie — dalej nie sięgamy. */
  dostepneDni: string[];
}): Promise<number> {
  const { kontoId, planId, odData, pora, przepisId, kolejnosc, osoby, trwaloscDni, dostepneDni } =
    opcje;

  const dni = dostepneDni
    .filter((d) => d >= odData)
    .slice(0, Math.max(1, trwaloscDni));

  const porcjiRazem = dni.length * Math.max(1, osoby);

  const { data: partia, error: bladPartii } = await supabase
    .from('partie')
    .insert({
      konto_id: kontoId,
      przepis_id: przepisId,
      data_ugotowania: odData,
      porcji_razem: porcjiRazem,
      porcji_zostalo: porcjiRazem,
      wazne_do: odData, // wyzwalacz w bazie policzy właściwą datę z trwałości przepisu
    })
    .select('id')
    .single();
  if (bladPartii) throw bladPartii;

  const { error } = await supabase.from('plan_pozycje').insert(
    dni.map((d) => ({
      plan_id: planId,
      data: d,
      pora,
      przepis_id: przepisId,
      porcje: Math.max(1, osoby),
      kolejnosc,
      partia_id: partia.id,
    }))
  );
  if (error) throw error;

  return dni.length;
}

/** Usuwa całą partię — wszystkie dni, na które rozłożono jedno gotowanie. */
export async function usunPartie(partiaId: string) {
  const { error } = await supabase.from('partie').delete().eq('id', partiaId);
  if (error) throw error;
}

export async function usunPosilek(id: string) {
  const { error } = await supabase.from('plan_pozycje').delete().eq('id', id);
  if (error) throw error;
}

/** Przeniesienie posiłku na inny dzień albo porę. */
export async function przeniesPosilek(id: string, data: string, pora: PoraPosilku) {
  const { error } = await supabase.from('plan_pozycje').update({ data, pora }).eq('id', id);
  if (error) throw error;
}

/**
 * Potwierdzenie całego dnia — podstawa zapisywania przez wyjątek.
 * Jedno dotknięcie zamiast trzech osobnych wpisów.
 */
export async function oznaczDzien(planId: string, data: string, zjedzone: boolean) {
  const { error } = await supabase
    .from('plan_pozycje')
    .update({ zjedzone })
    .eq('plan_id', planId)
    .eq('data', data);
  if (error) throw error;
}
