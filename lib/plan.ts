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
  /** Ustawione, gdy ten posiłek to przeskalowany wariant (migracja 0036), nie bazowy przepis. */
  przepis_skalowany_id: string | null;
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

/**
 * Ile tygodni wstecz trzymamy.
 *
 * Nie chodzi o miejsce w bazie. Sprawdzone na prawdziwym PostgreSQL: pełny rok
 * planowania — 52 plany, 1092 pozycje, 364 partie — zajmuje z indeksami około
 * 576 kB. Przy pięciuset megabajtach darmowego Supabase starczyłoby na kilkaset
 * lat, więc argument „baza urośnie” po prostu nie jest prawdziwy.
 *
 * Powód jest inny i dotyczy ekranu: lista wyboru tygodnia po roku miałaby
 * pięćdziesiąt dwie pozycje i przestałaby być użyteczna. Kwartał to sensowny
 * kompromis — mieści „powtórz poprzedni tydzień”, pozwala zajrzeć miesiąc czy
 * dwa wstecz, a lista zostaje krótka.
 *
 * Zmiana tej liczby to jedyne, co trzeba zrobić, żeby trzymać dłużej lub krócej.
 */
export const TYGODNI_HISTORII = 12;

/**
 * Wszystkie tygodnie konta, od najnowszego.
 *
 * Każdy tydzień to osobny wiersz w `plany`. Stare zostają — z nich bierze się
 * „powtórz poprzedni tydzień”, a kiedyś wszystko, co da się o sobie policzyć.
 */
export async function pobierzPlany(ile = 12): Promise<Plan[]> {
  const { data, error } = await supabase
    .from('plany')
    .select('id, data_start, dni')
    .order('data_start', { ascending: false })
    .limit(ile);

  if (error) throw error;
  return data ?? [];
}

/** Tydzień poprzedzający wskazany — po dacie startu, nie po kolejności dodania. */
export async function pobierzPoprzedniPlan(planId: string): Promise<Plan | null> {
  const { data: biezacy, error: bladBiezacego } = await supabase
    .from('plany')
    .select('data_start')
    .eq('id', planId)
    .single();
  if (bladBiezacego) throw bladBiezacego;

  const { data, error } = await supabase
    .from('plany')
    .select('id, data_start, dni')
    .lt('data_start', biezacy.data_start)
    .order('data_start', { ascending: false })
    .limit(1)
    .maybeSingle();

  if (error) throw error;
  return data;
}

/**
 * Kasuje całą zawartość tygodnia: posiłki i gotowania, z których wynikały.
 *
 * Kolejność jak w `usunPartie` i z tego samego powodu: `plan_pozycje.partia_id`
 * ma `on delete set null`, więc skasowanie partii jako pierwszej zostawiłoby
 * posiłki w planie bez powiązania. Najpierw posiłki, potem partie.
 *
 * Partie kasujemy po identyfikatorach zebranych z pozycji, a nie po planie —
 * `partie` nie ma kolumny `plan_id`, bo garnek jest bytem niezależnym od planu.
 */
export async function wyczyscPlan(planId: string) {
  const { data: pozycje, error: bladOdczytu } = await supabase
    .from('plan_pozycje')
    .select('partia_id')
    .eq('plan_id', planId);
  if (bladOdczytu) throw bladOdczytu;

  const partie = [
    ...new Set((pozycje ?? []).map((p) => p.partia_id as string | null).filter(Boolean)),
  ] as string[];

  const { error } = await supabase.from('plan_pozycje').delete().eq('plan_id', planId);
  if (error) throw error;

  if (partie.length > 0) {
    const { error: bladPartii } = await supabase.from('partie').delete().in('id', partie);
    if (bladPartii) throw bladPartii;
  }
}

/**
 * Kasuje tygodnie starsze niż `TYGODNI_HISTORII` ostatnich.
 *
 * Liczymy TYGODNIE, nie dni. Odmierzanie datą myliłoby się przy przerwach:
 * ktoś nie planuje przez miesiąc, wraca — i traci wszystko, choć zebrał
 * dopiero trzy tygodnie. Reguła „trzymaj dwanaście ostatnich” jest odporna
 * na dziury w planowaniu.
 *
 * Partie trzeba skasować OSOBNO. Usunięcie planu kasuje jego pozycje
 * kaskadowo, ale `plan_pozycje.partia_id` ma `on delete set null` w drugą
 * stronę — więc gotowania zostałyby w bazie jako sieroty, których nic już
 * nie pokazuje ani nie kasuje. Dlatego najpierw zbieramy ich identyfikatory,
 * a dopiero potem usuwamy plany.
 *
 * @returns ile tygodni usunięto
 */
export async function posprzatajStarePlany(ile = TYGODNI_HISTORII): Promise<number> {
  const { data: wszystkie, error } = await supabase
    .from('plany')
    .select('id')
    .order('data_start', { ascending: false });
  if (error) throw error;

  const doUsuniecia = (wszystkie ?? []).slice(ile).map((p) => p.id as string);
  if (doUsuniecia.length === 0) return 0;

  const { data: pozycje, error: bladPozycji } = await supabase
    .from('plan_pozycje')
    .select('partia_id')
    .in('plan_id', doUsuniecia);
  if (bladPozycji) throw bladPozycji;

  const partie = [
    ...new Set((pozycje ?? []).map((p) => p.partia_id as string | null).filter(Boolean)),
  ] as string[];

  const { error: bladPlanow } = await supabase.from('plany').delete().in('id', doUsuniecia);
  if (bladPlanow) throw bladPlanow;

  if (partie.length > 0) {
    const { error: bladPartii } = await supabase.from('partie').delete().in('id', partie);
    if (bladPartii) throw bladPartii;
  }

  return doUsuniecia.length;
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
    .select(
      'id, data, pora, przepis_id, przepis_skalowany_id, porcje, kolejnosc, zjedzone, partia_id, przepisy (nazwa)'
    )
    .eq('plan_id', planId)
    .order('data')
    .order('kolejnosc');

  if (error) throw error;
  if (!pozycje || pozycje.length === 0) return [];

  const idPrzepisow = [...new Set(pozycje.map((p) => p.przepis_id as string))];
  const idSkalowanych = [
    ...new Set(pozycje.map((p) => p.przepis_skalowany_id as string | null).filter((x): x is string => x !== null)),
  ];

  // Dwa osobne widoki, bo jedna pozycja czerpie makro ALBO z przepisu
  // źródłowego, ALBO z konkretnego wariantu skalowanego (migracja 0036) —
  // nigdy z obu naraz.
  const [wynikMakro, wynikMakroSkalowanych] = await Promise.all([
    supabase
      .from('przepis_makro')
      .select('przepis_id, kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, gramy_porcji')
      .in('przepis_id', idPrzepisow),
    idSkalowanych.length > 0
      ? supabase
          .from('przepis_skalowany_makro')
          .select('przepis_skalowany_id, kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, gramy_porcji')
          .in('przepis_skalowany_id', idSkalowanych)
      : Promise.resolve({ data: [], error: null }),
  ]);

  if (wynikMakro.error) throw wynikMakro.error;
  if (wynikMakroSkalowanych.error) throw wynikMakroSkalowanych.error;

  const wedlugPrzepisu = new Map((wynikMakro.data ?? []).map((m) => [m.przepis_id as string, m]));
  const wedlugSkalowanego = new Map(
    (wynikMakroSkalowanych.data ?? []).map((m) => [m.przepis_skalowany_id as string, m])
  );

  return pozycje.map((p): PozycjaPlanu => {
    const przepisSkalowanyId = p.przepis_skalowany_id as string | null;
    const m = przepisSkalowanyId
      ? wedlugSkalowanego.get(przepisSkalowanyId)
      : wedlugPrzepisu.get(p.przepis_id as string);
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
      przepis_skalowany_id: przepisSkalowanyId,
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
 * na tyle kolejnych, ile ma porcji bazowych — i tyle porcji dziennie,
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
  /** Liczba porcji bazowych przepisu: 0 traktujemy jak jeden dzień. */
  liczbaPorcjiBazowych: number;
  /** Dni planu od dnia dodania włącznie — dalej nie sięgamy. */
  dostepneDni: string[];
  /**
   * Ustawione, gdy zamiast bazowego przepisu wstawiamy jego przeskalowany
   * wariant (migracja 0036) — `przepis_id` nadal wskazuje przepis źródłowy,
   * to pole mówi, skąd brać makro. Domyślnie rozkłada się na JEDEN dzień
   * (wariant jest policzony pod cel kaloryczny TEGO posiłku), chyba że
   * wołający przekaże `liczbaPorcjiBazowych` większą niż 1 — dzieje się tak,
   * gdy trwałość dania (checkbox „Uwzględnij ile dni wytrzyma w lodówce”)
   * ma pierwszeństwo: patrz `zaplanuj` w `lib/automat.ts`.
   */
  przepisSkalowanyId?: string;
}): Promise<number> {
  const {
    kontoId,
    planId,
    odData,
    pora,
    przepisId,
    kolejnosc,
    osoby,
    liczbaPorcjiBazowych,
    dostepneDni,
    przepisSkalowanyId,
  } = opcje;

  const dni = dostepneDni
    .filter((d) => d >= odData)
    .slice(0, Math.max(1, liczbaPorcjiBazowych));

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
      przepis_skalowany_id: przepisSkalowanyId ?? null,
      porcje: Math.max(1, osoby),
      kolejnosc,
      partia_id: partia.id,
    }))
  );
  if (error) throw error;

  return dni.length;
}

/** Usuwa całą partię — wszystkie dni, na które rozłożono jedno gotowanie. */
/**
 * Usuwa partię wraz ze wszystkimi posiłkami, które z niej wynikały.
 *
 * Kolejność ma znaczenie i nie jest oczywista. Klucz obcy `plan_pozycje.partia_id`
 * ma `on delete set null`, więc samo skasowanie partii NIE usuwa posiłków —
 * one zostają w planie, tylko tracą powiązanie z gotowaniem.
 *
 * Objawiało się to tak: „Usuń całą partię” sprzątało wpis o gotowaniu, dania
 * nadal stały w planie, a lista zakupów dalej ich potrzebowała. Wyglądało to
 * na błąd listy zakupów, a było tutaj.
 *
 * Najpierw więc posiłki, potem partia.
 */
export async function usunPartie(partiaId: string) {
  const { error: bladPozycji } = await supabase
    .from('plan_pozycje')
    .delete()
    .eq('partia_id', partiaId);
  if (bladPozycji) throw bladPozycji;

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
 * Podmienia wariant skalowany JUŻ ISTNIEJĄCEJ pozycji planu — bez usuwania
 * i wstawiania od nowa. `przepis_id` (przepis źródłowy) zostaje bez zmian,
 * zmienia się tylko to, skąd bierze się makro tego jednego posiłku.
 */
export async function ustawPrzepisSkalowanyPozycji(
  pozycjaId: string,
  przepisSkalowanyId: string
): Promise<void> {
  const { error } = await supabase
    .from('plan_pozycje')
    .update({ przepis_skalowany_id: przepisSkalowanyId })
    .eq('id', pozycjaId);
  if (error) throw error;
}

/**
 * Potwierdzenie całego dnia — oznacza wszystkie posiłki jako zjedzone.
 *
 * NIEUŻYWANE. Przycisk „Poszło zgodnie z planem” został usunięty z ekranu
 * planu, bo pola `zjedzone` nikt nie czytał: nie było historii, statystyki
 * ani żadnego wniosku wyciąganego z potwierdzenia. Przycisk zmieniał własny
 * napis i tyle.
 *
 * Funkcja i kolumna zostają, bo mają jeden sensowny przyszły odbiorca:
 * potwierdzenie posiłku mogłoby zdejmować porcję ze stanu `partie`
 * (`porcji_zostalo`) — i wtedy „ile zostało barszczu” byłoby prawdą,
 * a nie deklaracją sprzed trzech dni. Do tego czasu nic tego nie wywołuje.
 */
export async function oznaczDzien(planId: string, data: string, zjedzone: boolean) {
  const { error } = await supabase
    .from('plan_pozycje')
    .update({ zjedzone })
    .eq('plan_id', planId)
    .eq('data', data);
  if (error) throw error;
}
