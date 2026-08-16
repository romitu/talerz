/**
 * Odczyt przepisów z bazy wraz z wyliczonym makro.
 *
 * Zasada projektu: makroskładników nigdy nie wpisujemy ręcznie. Wylicza je
 * widok `przepis_makro` w bazie, z gramatur składników. Ten plik tylko je czyta.
 */

import { supabase } from './supabase';

/**
 * Kategoria przepisu. Trzy pierwsze to pory dnia, czwarta nią nie jest:
 * „dodatek” to coś, co dokładasz do posiłku — grillowana pierś do sałatki,
 * ciecierzyca do zupy, surówka do drugiego dania.
 */
export type PoraPosilku = 'sniadanie' | 'obiad' | 'kolacja' | 'dodatek';
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
  /** Kiedy autor poprosił o publikację. */
  zgloszono_kiedy: string | null;
  /** Dlaczego moderator odesłał przepis do poprawki. */
  powod_odrzucenia: string | null;
  autor_id: string | null;
  /** Ścieżka pliku w zasobniku Storage; samego obrazu w bazie nie ma. */
  zdjecie: string | null;
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
  dodatek: 'Dodatek',
};

/** Nazwy kategorii w liczbie mnogiej — do nagłówków i zakładek. */
export const OPIS_KATEGORII: Record<PoraPosilku, string> = {
  sniadanie: 'Śniadania',
  obiad: 'Obiady',
  kolacja: 'Kolacje',
  dodatek: 'Dodatki',
};

/** Kolejność kategorii na ekranie — tak, jak wygląda dzień. */
export const KATEGORIE: PoraPosilku[] = ['sniadanie', 'obiad', 'kolacja', 'dodatek'];

/**
 * Czy przepis pasuje do danej pory dnia.
 *
 * Dwie reguły, obie celowe:
 *   * przepis bez kategorii pasuje wszędzie — dopóki moderator nie zdecyduje,
 *     lepiej pokazać za dużo niż ukryć danie i kazać go szukać,
 *   * dodatek pasuje do każdego posiłku, bo po to jest dodatkiem. Grillowana
 *     pierś pasuje i do sałatki na kolację, i do ryżu na obiad.
 */
export function pasujeDoPory(pory: PoraPosilku[], pora: PoraPosilku): boolean {
  if (pory.length === 0) return true;
  return pory.includes(pora) || pory.includes('dodatek');
}

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
         widocznosc, zgloszono_kiedy, powod_odrzucenia, autor_id, zdjecie,
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
      zgloszono_kiedy: p.zgloszono_kiedy ?? null,
      powod_odrzucenia: p.powod_odrzucenia ?? null,
      autor_id: p.autor_id,
      zdjecie: p.zdjecie ?? null,
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

/**
 * Pełna treść przepisu do edycji.
 *
 * Pobierana osobno od listy, bo lista potrzebuje tylko podsumowania,
 * a formularz — wszystkiego.
 */
export type PelnyPrzepis = {
  id: string;
  nazwa: string;
  opis: string | null;
  pory: PoraPosilku[];
  kuchnie: Kuchnia[];
  trwalosc_dni: number;
  porcjowanie: 'waga' | 'sztuki';
  porcje: number;
  porcja_g: number | null;
  czas_przygotowania_min: number | null;
  czas_obrobki_min: number | null;
  sprzet: string[];
  przechowywanie: string | null;
  mozna_mrozic: boolean | null;
  ratunek: string | null;
  widocznosc: Widocznosc;
  zgloszono_kiedy: string | null;
  powod_odrzucenia: string | null;
  zdjecie: string | null;
  skladniki: {
    skladnik_id: string;
    /** Nazwa z tabeli składników — do wyświetlenia przy gotowaniu. */
    nazwa: string;
    ilosc: number;
    jednostka: 'g' | 'ml' | 'szt';
    /** Masa w gramach; przy sztukach wyliczona z masy jednej sztuki. */
    gramy: number;
    stan: string | null;
    zamiennik: string | null;
    opis_potoczny: string | null;
    kolejnosc: number;
  }[];
  etapy: {
    nazwa: string;
    minuty: number | null;
    kroki: { tresc: string; sygnal: string | null; uwaga: boolean }[];
  }[];
};

/** Wyciąga nazwę z dołączonej tabeli składników, bez względu na jej kształt. */
function nazwaSkladnika(dolaczone: unknown): string {
  if (Array.isArray(dolaczone)) return (dolaczone[0] as { nazwa?: string })?.nazwa ?? '—';
  return (dolaczone as { nazwa?: string } | null)?.nazwa ?? '—';
}

export async function pobierzPelnyPrzepis(id: string): Promise<PelnyPrzepis> {
  const [wynikPrzepisu, wynikSkladnikow, wynikEtapow] = await Promise.all([
    supabase
      .from('przepisy')
      .select(
        `id, nazwa, opis, pory, kuchnie, trwalosc_dni, porcjowanie, porcje, porcja_g,
         czas_przygotowania_min, czas_obrobki_min, sprzet, przechowywanie, mozna_mrozic,
         ratunek, widocznosc, zgloszono_kiedy, powod_odrzucenia, zdjecie`
      )
      .eq('id', id)
      .single(),
    supabase
      .from('przepis_skladniki')
      .select(
        'skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, opis_potoczny, kolejnosc, skladniki (nazwa)'
      )
      .eq('przepis_id', id)
      .order('kolejnosc'),
    supabase
      .from('etapy')
      .select('id, nazwa, minuty, kolejnosc, kroki (tresc, sygnal, uwaga, kolejnosc)')
      .eq('przepis_id', id)
      .order('kolejnosc'),
  ]);

  if (wynikPrzepisu.error) throw wynikPrzepisu.error;
  if (wynikSkladnikow.error) throw wynikSkladnikow.error;
  if (wynikEtapow.error) throw wynikEtapow.error;

  const etapy = (wynikEtapow.data ?? []).map((e) => ({
    nazwa: e.nazwa as string,
    minuty: e.minuty as number | null,
    kroki: ((e.kroki ?? []) as { tresc: string; sygnal: string | null; uwaga: boolean; kolejnosc: number }[])
      .slice()
      .sort((a, b) => a.kolejnosc - b.kolejnosc)
      .map((k) => ({ tresc: k.tresc, sygnal: k.sygnal, uwaga: k.uwaga })),
  }));

  // Nazwa składnika przychodzi z dołączonej tabeli — wypłaszczamy ją,
  // żeby ekrany nie musiały wiedzieć, skąd pochodzi.
  const skladniki = (wynikSkladnikow.data ?? []).map((s) => ({
    skladnik_id: s.skladnik_id as string,
    // Supabase zwraca dołączoną tabelę raz jako obiekt, raz jako tablicę —
    // zależnie od tego, jak rozpozna liczebność relacji. Obsługujemy oba.
    nazwa: nazwaSkladnika(s.skladniki),
    ilosc: Number(s.ilosc),
    jednostka: s.jednostka as 'g' | 'ml' | 'szt',
    gramy: Number(s.gramy),
    stan: s.stan as string | null,
    zamiennik: s.zamiennik as string | null,
    opis_potoczny: s.opis_potoczny as string | null,
    kolejnosc: s.kolejnosc as number,
  }));

  return {
    ...(wynikPrzepisu.data as Omit<PelnyPrzepis, 'skladniki' | 'etapy'>),
    skladniki,
    etapy,
  };
}

/**
 * Usuwa składniki, etapy i kroki przepisu.
 *
 * Przy zapisie zmian wstawiamy je od nowa zamiast dopasowywać po jednym.
 * Przy kilkunastu pozycjach jest to prostsze i pewniejsze niż porównywanie
 * różnic, a usunięcie etapu kasuje jego kroki samo.
 */
export async function wyczyscTrescPrzepisu(id: string) {
  const { error: bladSkladnikow } = await supabase
    .from('przepis_skladniki')
    .delete()
    .eq('przepis_id', id);
  if (bladSkladnikow) throw bladSkladnikow;

  const { error: bladEtapow } = await supabase.from('etapy').delete().eq('przepis_id', id);
  if (bladEtapow) throw bladEtapow;
}


// =============================================================================
//  OBIEG PUBLIKACJI
// =============================================================================
/*
  Wszystkie cztery funkcje robią to samo — zmieniają jedną kolumnę — a mimo to
  są osobne. Powód jest taki, że każda z nich znaczy co innego i wolno ją
  wywołać komu innemu: dwie pierwsze autorowi, dwie kolejne moderatorowi.
  Jedna funkcja `ustawWidocznosc(stan)` zacierałaby tę różnicę w kodzie ekranów,
  a to właśnie ta różnica jest tu istotna.

  O pilnowanie, kto naprawdę może co, dba wyzwalacz w bazie (migracja 0022).
  Tutaj chodzi wyłącznie o czytelność wywołania.
*/

/** Autor prosi o publikację. Znaczniki czasu ustawia wyzwalacz w bazie. */
export async function zglosDoPublikacji(przepisId: string) {
  const { error } = await supabase
    .from('przepisy')
    .update({ widocznosc: 'zgloszona' })
    .eq('id', przepisId);
  if (error) throw error;
}

/** Autor wycofuje zgłoszenie — przepis wraca do prywatnych. */
export async function wycofajZgloszenie(przepisId: string) {
  const { error } = await supabase
    .from('przepisy')
    .update({ widocznosc: 'prywatna' })
    .eq('id', przepisId);
  if (error) throw error;
}

/** Moderator publikuje. Od tej chwili przepis widzą wszyscy, a autor go nie zmieni. */
export async function zatwierdzPrzepis(przepisId: string) {
  const { error } = await supabase
    .from('przepisy')
    .update({ widocznosc: 'publiczna' })
    .eq('id', przepisId);
  if (error) throw error;
}

/**
 * Moderator odsyła przepis do poprawki.
 *
 * Powód jest obowiązkowy. Odrzucenie bez uzasadnienia kończy się tym, że autor
 * zgłasza to samo drugi raz, a moderator odrzuca to samo drugi raz.
 */
export async function odrzucPrzepis(przepisId: string, powod: string) {
  const tresc = powod.trim();
  if (tresc.length < 3) throw new Error('Napisz autorowi, co poprawić.');
  if (tresc.length > 500) throw new Error('Uzasadnienie może mieć najwyżej 500 znaków.');

  const { error } = await supabase
    .from('przepisy')
    .update({ widocznosc: 'prywatna', powod_odrzucenia: tresc })
    .eq('id', przepisId);
  if (error) throw error;
}
