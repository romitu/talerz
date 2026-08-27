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

/**
 * Dział produktów dopisywanych ręcznie.
 *
 * Celowo POZA tablicą DZIAŁÓW i celowo na końcu listy. Po pierwsze odpowiada
 * to trasie po sklepie — chemia leży przy kasach. Po drugie oddziela wzrokowo
 * to, co wyliczyło się z planu, od tego, co dopisałeś sam.
 */
export const DZIAL_RECZNY = 'Dom i chemia';

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
    .select('przepis_id, przepis_skalowany_id, porcje, przepisy (nazwa)')
    .eq('plan_id', planId)
    .gte('data', odData)
    .lte('data', doData);

  if (error) throw error;
  if (!pozycje || pozycje.length === 0) return [];

  // Pozycja bierze składniki ALBO z przepisu źródłowego, ALBO z konkretnego
  // wariantu skalowanego (migracja 0036) — nigdy z obu naraz. Stąd dwa
  // rozłączne zbiory identyfikatorów i dwa niezależne zapytania niżej.
  const zwykle = pozycje.filter((p) => !p.przepis_skalowany_id);
  const skalowane = pozycje.filter((p) => p.przepis_skalowany_id);

  const idPrzepisow = [...new Set(zwykle.map((p) => p.przepis_id as string))];
  const idSkalowanych = [...new Set(skalowane.map((p) => p.przepis_skalowany_id as string))];

  type DaneSkladnika = { nazwa: string; tagi: string[]; gramatura_opakowania_g: number | null };
  // Supabase zwraca powiązanie raz jako obiekt, raz jako jednoelementową listę.
  function jedenSkladnik(surowy: unknown): DaneSkladnika | null {
    const x = surowy as DaneSkladnika | DaneSkladnika[] | null;
    return Array.isArray(x) ? (x[0] ?? null) : x;
  }

  const [wynikSkladnikow, wynikMakro, wynikSkalowanych] = await Promise.all([
    idPrzepisow.length > 0
      ? supabase
          .from('przepis_skladniki')
          .select('przepis_id, skladnik_id, gramy, skladniki (nazwa, tagi, gramatura_opakowania_g)')
          .in('przepis_id', idPrzepisow)
      : Promise.resolve({ data: [], error: null }),
    idPrzepisow.length > 0
      ? supabase.from('przepis_makro').select('przepis_id, porcje_wyliczone').in('przepis_id', idPrzepisow)
      : Promise.resolve({ data: [], error: null }),
    idSkalowanych.length > 0
      ? supabase
          .from('przepisy_skalowane_skladniki')
          .select(
            'przepis_skalowany_id, skladnik_id, gramy, skladniki (nazwa, tagi, gramatura_opakowania_g)'
          )
          .in('przepis_skalowany_id', idSkalowanych)
      : Promise.resolve({ data: [], error: null }),
  ]);

  if (wynikSkladnikow.error) throw wynikSkladnikow.error;
  if (wynikMakro.error) throw wynikMakro.error;
  if (wynikSkalowanych.error) throw wynikSkalowanych.error;

  const porcjiWPrzepisie = new Map(
    (wynikMakro.data ?? []).map((m) => [m.przepis_id as string, Number(m.porcje_wyliczone) || 1])
  );

  const zebrane = new Map<string, PozycjaZakupow>();

  function dolicz(
    id: string,
    dane: DaneSkladnika,
    gramy: number,
    nazwaDania: string
  ) {
    const wpis = zebrane.get(id) ?? {
      skladnik_id: id,
      nazwa: dane.nazwa,
      gramy: 0,
      tagi: dane.tagi ?? [],
      opakowanie_g: dane.gramatura_opakowania_g,
      opakowan: null,
      reszta_g: null,
      dania: [],
    };
    wpis.gramy += gramy;
    if (nazwaDania && !wpis.dania.includes(nazwaDania)) wpis.dania.push(nazwaDania);
    zebrane.set(id, wpis);
  }

  for (const pozycja of zwykle) {
    const przepisId = pozycja.przepis_id as string;
    const przepis = pozycja.przepisy as { nazwa: string } | { nazwa: string }[] | null;
    const nazwaDania = (Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa) ?? '';
    const naPorcje = porcjiWPrzepisie.get(przepisId) ?? 1;
    const mnoznik = (pozycja.porcje as number) / naPorcje;

    for (const s of wynikSkladnikow.data ?? []) {
      if (s.przepis_id !== przepisId) continue;
      const skladnik = jedenSkladnik(s.skladniki);
      if (!skladnik) continue;
      dolicz(s.skladnik_id as string, skladnik, Number(s.gramy) * mnoznik, nazwaDania);
    }
  }

  // Wariant skalowany reprezentuje JEDEN posiłek (patrz lib/skalowanie-kalorii.ts
  // i migracja 0036) — bez dzielenia przez porcje_wyliczone, tylko razy liczba
  // jedzących (porcje) tej pozycji, tak jak przy zwykłym przepisie na sztuki.
  for (const pozycja of skalowane) {
    const przepisSkalowanyId = pozycja.przepis_skalowany_id as string;
    const przepis = pozycja.przepisy as { nazwa: string } | { nazwa: string }[] | null;
    const nazwaDania = (Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa) ?? '';
    const mnoznik = pozycja.porcje as number;

    for (const s of wynikSkalowanych.data ?? []) {
      if (s.przepis_skalowany_id !== przepisSkalowanyId) continue;
      const skladnik = jedenSkladnik(s.skladniki);
      if (!skladnik) continue;
      dolicz(s.skladnik_id as string, skladnik, Number(s.gramy) * mnoznik, nazwaDania);
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

// =============================================================================
//  PRODUKTY DOPISYWANE RĘCZNIE
// =============================================================================

export type ProduktReczny = {
  id: string;
  nazwa: string;
  /** Dowolny tekst: „2 rolki”, „1 opak.”. Może być pusty. */
  ilosc: string | null;
};

/** Produkty czekające na kupienie. Kupione tu nie wracają — zostają w historii. */
export async function pobierzReczne(kontoId: string): Promise<ProduktReczny[]> {
  const { data, error } = await supabase
    .from('zakupy_reczne')
    .select('id, nazwa, ilosc')
    .eq('konto_id', kontoId)
    .eq('kupione', false)
    .order('utworzono');

  if (error) throw error;
  return data ?? [];
}

/**
 * Dopisuje produkt do listy.
 *
 * Gdy taka rzecz już na liście wisi, baza odrzuci wstawienie przez indeks
 * `zakupy_reczne_jedna_otwarta`. Zamieniamy to na zrozumiałe zdanie zamiast
 * pokazywać nazwę indeksu — użytkownik nie ma pojęcia, co to znaczy.
 */
export async function dodajReczny(kontoId: string, nazwa: string, ilosc: string) {
  const czysta = nazwa.trim().replace(/\s+/g, ' ');
  if (!czysta) throw new Error('Podaj nazwę produktu.');
  if (czysta.length > 60) throw new Error('Nazwa może mieć najwyżej 60 znaków.');

  const { error } = await supabase.from('zakupy_reczne').insert({
    konto_id: kontoId,
    nazwa: czysta,
    ilosc: ilosc.trim() || null,
  });

  if (error) {
    if (error.code === '23505') throw new Error(`„${czysta}” już jest na liście.`);
    throw error;
  }
}

/**
 * Odhacza produkt — schodzi z listy, zostaje w historii.
 *
 * Datę zakupu wpisuje wyzwalacz w bazie, nie my. Inaczej każde kolejne
 * miejsce zmieniające `kupione` musiałoby o niej pamiętać.
 */
export async function kupionoReczny(id: string, kupione = true) {
  const { error } = await supabase.from('zakupy_reczne').update({ kupione }).eq('id', id);
  if (error) throw error;
}

/** Kasuje pozycję razem z historią — dla pomyłek przy wpisywaniu. */
export async function usunReczny(id: string) {
  const { error } = await supabase.from('zakupy_reczne').delete().eq('id', id);
  if (error) throw error;
}

/**
 * Podpowiedzi z historii — zamiast katalogu produktów, który trzeba utrzymywać.
 *
 * Katalog buduje się sam z użycia: dopisujesz „Worki na śmieci” raz, a za
 * miesiąc wpisujesz „wor” i pozycja jest gotowa. Nazwy powtórzone zwijamy
 * do jednej, zachowując tę najświeższą.
 */
export async function podpowiedziZHistorii(kontoId: string, ile = 40): Promise<string[]> {
  const { data, error } = await supabase
    .from('zakupy_reczne')
    .select('nazwa, kupiono_kiedy')
    .eq('konto_id', kontoId)
    .eq('kupione', true)
    .order('kupiono_kiedy', { ascending: false })
    .limit(ile * 3);

  if (error) throw error;

  const widziane = new Set<string>();
  const wynik: string[] = [];
  for (const w of data ?? []) {
    const klucz = w.nazwa.toLowerCase();
    if (widziane.has(klucz)) continue;
    widziane.add(klucz);
    wynik.push(w.nazwa);
    if (wynik.length >= ile) break;
  }
  return wynik;
}

// =============================================================================
//  ODHACZENIA POZYCJI Z PLANU
// =============================================================================

/**
 * Identyfikatory składników już wrzuconych do koszyka — DLA TEGO PLANU.
 *
 * Ptaszek jest właściwością tygodnia, nie konta: bez `planId` w kluczu ten
 * sam składnik w nowo wygenerowanym, identycznym planie wracał jako „już
 * kupiony", choć do tej listy nikt jeszcze nie zajrzał.
 */
export async function pobierzOdhaczone(kontoId: string, planId: string): Promise<Set<string>> {
  const { data, error } = await supabase
    .from('zakupy_odhaczone')
    .select('skladnik_id')
    .eq('konto_id', kontoId)
    .eq('plan_id', planId);

  if (error) throw error;
  return new Set((data ?? []).map((x) => x.skladnik_id as string));
}

export async function ustawOdhaczenie(
  kontoId: string,
  planId: string,
  skladnikId: string,
  odhaczony: boolean
) {
  if (odhaczony) {
    const { error } = await supabase
      .from('zakupy_odhaczone')
      .upsert({ konto_id: kontoId, plan_id: planId, skladnik_id: skladnikId });
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from('zakupy_odhaczone')
    .delete()
    .eq('konto_id', kontoId)
    .eq('plan_id', planId)
    .eq('skladnik_id', skladnikId);
  if (error) throw error;
}

/** Czyści ptaszki TEGO planu — początek nowych zakupów albo czyszczenie tygodnia. */
export async function wyczyscOdhaczenia(kontoId: string, planId: string) {
  const { error } = await supabase
    .from('zakupy_odhaczone')
    .delete()
    .eq('konto_id', kontoId)
    .eq('plan_id', planId);
  if (error) throw error;
}
