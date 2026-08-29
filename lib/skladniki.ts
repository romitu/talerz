/**
 * Składniki — odczyt i zapis.
 *
 * Wartości odżywcze podajemy zawsze na 100 g. Makro przepisu wylicza z nich
 * baza, więc błąd w tej tabeli przekłada się na każde danie, w którym składnik
 * wystąpi. Stąd sprawdzenia przed zapisem.
 */

import { supabase } from './supabase';

/**
 * Rola składnika przy skalowaniu przepisu na inną liczbę porcji.
 * Wzory dla poszczególnych ról żyją w kodzie (`lib/role-skladnikow.ts`),
 * nie tutaj — to pole mówi tylko, KTÓRĄ rolę ma dany składnik.
 */
export type RolaSkladnika =
  | 'baza'
  | 'doprawienie'
  | 'aromat'
  | 'smazenie'
  | 'duszenie'
  | 'woda'
  | 'do_smaku';

export const ROLE_SKLADNIKA: RolaSkladnika[] = [
  'baza',
  'doprawienie',
  'aromat',
  'smazenie',
  'duszenie',
  'woda',
  'do_smaku',
];

export const OPIS_ROLI_SKLADNIKA: Record<RolaSkladnika, string> = {
  baza: 'Baza',
  doprawienie: 'Doprawienie',
  aromat: 'Aromat mocny',
  smazenie: 'Tłuszcz do smażenia',
  duszenie: 'Płyn do duszenia',
  woda: 'Woda technologiczna',
  do_smaku: 'Do smaku',
};

export type Skladnik = {
  id: string;
  nazwa: string;
  zrodlo: 'usda' | 'open_food_facts' | 'wlasne';
  kcal_100g: number;
  bialko_100g: number;
  tluszcz_100g: number;
  wegle_100g: number;
  blonnik_100g: number;
  cukry_ogolem_100g: number;
  cukry_wolne_100g: number;
  nova: number | null;
  gramatura_opakowania_g: number | null;
  /** Ile waży jedna sztuka. Puste = składnik odmierzany wyłącznie wagowo. */
  masa_sztuki_g: number | null;
  /** Czy składnik można podzielić na dowolną ilość (np. sól) — false = tylko całe sztuki (np. jajko). */
  mozna_dzielic: boolean | null;
  rola: RolaSkladnika;
  tagi: string[];
};

export type DaneSkladnika = Omit<Skladnik, 'id'>;

/**
 * Lista pól musi być zapisana wprost, a nie sklejana ze zmiennych — Supabase
 * odczytuje z niej typy w czasie sprawdzania kodu i potrzebuje stałego tekstu.
 */
const POLA =
  'id, nazwa, zrodlo, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g, blonnik_100g, cukry_ogolem_100g, cukry_wolne_100g, nova, gramatura_opakowania_g, masa_sztuki_g, mozna_dzielic, rola, tagi';

export async function pobierzSkladniki(): Promise<Skladnik[]> {
  const { data, error } = await supabase.from('skladniki').select(POLA).order('nazwa');
  if (error) throw error;
  return (data ?? []) as unknown as Skladnik[];
}

export async function zapiszSkladnik(dane: DaneSkladnika, id?: string): Promise<Skladnik> {
  const zapytanie = id
    ? supabase.from('skladniki').update(dane).eq('id', id)
    : supabase.from('skladniki').insert(dane);

  const { data, error } = await zapytanie.select(POLA).single();
  if (error) throw error;
  return data as unknown as Skladnik;
}

export async function usunSkladnik(id: string) {
  const { error } = await supabase.from('skladniki').delete().eq('id', id);
  if (error) throw error;
}

/**
 * Sprawdzenia wykonywane przed wysłaniem do bazy.
 *
 * Baza ma własne ograniczenia i one są ostateczne — ale komunikat z bazy jest
 * po angielsku i mówi o nazwach kolumn. Tutaj tłumaczymy to na ludzki język,
 * zanim użytkownik zdąży się zdziwić.
 */
export function sprawdzSkladnik(dane: Partial<DaneSkladnika>): string[] {
  const bledy: string[] = [];
  const { nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g } = dane;
  const cukryOgolem = dane.cukry_ogolem_100g ?? 0;
  const cukryWolne = dane.cukry_wolne_100g ?? 0;

  if (!nazwa || nazwa.trim().length < 2) {
    bledy.push('Nazwa musi mieć co najmniej 2 znaki.');
  }

  for (const [pole, wartosc] of Object.entries({
    Kalorie: kcal_100g,
    Białko: bialko_100g,
    Tłuszcz: tluszcz_100g,
    Węglowodany: wegle_100g,
  })) {
    if (wartosc === undefined || wartosc === null || Number.isNaN(wartosc)) {
      bledy.push(`${pole}: podaj wartość na 100 g.`);
    } else if (wartosc < 0) {
      bledy.push(`${pole}: wartość nie może być ujemna.`);
    }
  }

  const blonnik = dane.blonnik_100g ?? 0;
  if (blonnik > (wegle_100g ?? 0)) {
    bledy.push('Błonnik nie może przekraczać węglowodanów — jest ich częścią.');
  }

  if (cukryWolne > cukryOgolem) {
    bledy.push(
      'Cukry wolne nie mogą przekraczać cukrów ogółem — cukry wolne są ich częścią.'
    );
  }

  const suma = (bialko_100g ?? 0) + (tluszcz_100g ?? 0) + (wegle_100g ?? 0);
  if (suma > 100) {
    bledy.push(
      `Białko, tłuszcz i węglowodany dają razem ${Math.round(suma)} g na 100 g produktu. ` +
        'To niemożliwe — sprawdź, czy wartości nie są pomylone.'
    );
  }

  if (dane.nova !== null && dane.nova !== undefined && (dane.nova < 1 || dane.nova > 4)) {
    bledy.push('Grupa NOVA mieści się w zakresie od 1 do 4.');
  }

  return bledy;
}

/**
 * Ostrzeżenie, gdy podane makro nie zgadza się z kaloriami.
 *
 * Nie blokuje zapisu — różnice do kilkunastu procent są normalne (błonnik,
 * alkohole cukrowe, zaokrąglenia na etykiecie). Powyżej tego progu to zwykle
 * literówka.
 */
export function ostrzezenieOKaloriach(dane: Partial<DaneSkladnika>): string | null {
  const kcal = dane.kcal_100g ?? 0;

  // Same zera oznaczają zwykle niewypełniony formularz, a nie produkt bez wartości.
  const wszystkoZero =
    kcal === 0 &&
    (dane.bialko_100g ?? 0) === 0 &&
    (dane.tluszcz_100g ?? 0) === 0 &&
    (dane.wegle_100g ?? 0) === 0;

  if (wszystkoZero) {
    return 'Wszystkie wartości są zerowe. Uzupełnij dane z etykiety, inaczej każde danie z tym składnikiem policzy się źle.';
  }

  if (kcal <= 0) return null;

  const zMakro =
    (dane.bialko_100g ?? 0) * 4 + (dane.tluszcz_100g ?? 0) * 9 + (dane.wegle_100g ?? 0) * 4;
  const roznica = Math.abs(zMakro - kcal) / kcal;

  if (roznica <= 0.25) return null;

  return (
    `Z podanych makroskładników wychodzi około ${Math.round(zMakro)} kcal, ` +
    `a wpisano ${kcal}. Sprawdź, czy nie ma pomyłki.`
  );
}

/** W jakich przepisach i w jakiej ilości użyto poszczególnych składników. */
export type UzycieWPrzepisie = {
  nazwa: string;
  gramy: number;
};

export type UzycieSkladnika = {
  przepisy: UzycieWPrzepisie[];
};

/**
 * Zwraca mapę: identyfikator składnika -> przepisy, w których go użyto.
 *
 * Dwa zapytania, nie jedno: składnik może siedzieć w zwykłym przepisie
 * (`przepis_skladniki`) ALBO w zrzucie wariantu przeskalowanego kalorycznie
 * (`przepisy_skalowane_skladniki`, migracja 0036) — to rozłączne tabele,
 * a klucz obcy `przepisy_skalowane_skladniki_skladnik_id_fkey` blokuje
 * kasowanie składnika użytego tylko w wariancie. Pomijanie tej drugiej
 * tabeli dawało fałszywe „0 użyć” na ekranie i surowy błąd bazy (23503)
 * zamiast zrozumiałego komunikatu z listą dań.
 *
 * Widoczność przepisów i wariantów ograniczają reguły dostępu w bazie,
 * więc zwykły użytkownik zobaczy tylko te, do których ma prawo.
 */
export async function pobierzUzycia(): Promise<Map<string, UzycieSkladnika>> {
  const [zwykle, skalowane] = await Promise.all([
    supabase.from('przepis_skladniki').select('skladnik_id, gramy, przepisy (nazwa)'),
    supabase
      .from('przepisy_skalowane_skladniki')
      .select('skladnik_id, gramy, przepisy_skalowane (przepisy (nazwa))'),
  ]);

  if (zwykle.error) throw zwykle.error;
  if (skalowane.error) throw skalowane.error;

  const mapa = new Map<string, UzycieSkladnika>();

  function dodaj(id: string, nazwa: string | undefined, gramy: number) {
    if (!nazwa) return;
    const wpis = mapa.get(id) ?? { przepisy: [] };
    wpis.przepisy.push({ nazwa, gramy });
    mapa.set(id, wpis);
  }

  for (const wiersz of zwykle.data ?? []) {
    const przepis = wiersz.przepisy as { nazwa: string } | { nazwa: string }[] | null;
    const nazwa = Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa;
    dodaj(wiersz.skladnik_id as string, nazwa, Number(wiersz.gramy));
  }

  for (const wiersz of skalowane.data ?? []) {
    const skalowany = wiersz.przepisy_skalowane as
      | { przepisy: { nazwa: string } | { nazwa: string }[] | null }
      | { przepisy: { nazwa: string } | { nazwa: string }[] | null }[]
      | null;
    const jeden = Array.isArray(skalowany) ? skalowany[0] : skalowany;
    const przepis = jeden?.przepisy ?? null;
    const nazwa = Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa;
    dodaj(wiersz.skladnik_id as string, nazwa, Number(wiersz.gramy));
  }

  // Alfabetycznie, żeby kolejność nie zmieniała się przy każdym odświeżeniu.
  for (const wpis of mapa.values()) {
    wpis.przepisy.sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl'));
  }

  return mapa;
}
