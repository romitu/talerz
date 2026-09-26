/**
 * Odczyt przepisów z bazy wraz z wyliczonym makro.
 *
 * Zasada projektu: makroskładników nigdy nie wpisujemy ręcznie. Wylicza je
 * widok `przepis_makro` w bazie, z gramatur składników. Ten plik tylko je czyta.
 */

import { supabase } from './supabase';
import type { RolaSkladnika } from './skladniki';

/**
 * Kategoria przepisu. Trzy pierwsze to pory dnia, czwarta nią nie jest:
 * „dodatek” to coś, co dokładasz do posiłku — grillowana pierś do sałatki,
 * ciecierzyca do zupy, surówka do drugiego dania.
 */
export type PoraPosilku = 'sniadanie' | 'obiad' | 'kolacja' | 'dodatek';
export type Kuchnia = 'srodziemnomorska' | 'azjatycka' | 'polska' | 'inna';

/**
 * Rodzaj dania — czym danie jest na talerzu. Trzecia oś obok pory i kuchni
 * (migracja 0046). Przepis ma jeden albo dwa; pusta lista = jeszcze nieprzypisany.
 */
export type RodzajDania =
  | 'zupa'
  | 'salatka'
  | 'makaron'
  | 'kasza_ryz'
  | 'gulasz_curry'
  | 'z_piekarnika'
  | 'kanapki'
  | 'jajka'
  | 'na_slodko';

/**
 * Główne źródło białka — wyliczane z tagów składników przez widok
 * `przepis_bialko`, nigdy wpisywane ręcznie. To nie jest filtr diety.
 */
export type GlowneBialko = 'drob' | 'mieso' | 'ryba' | 'straczki' | 'jaja' | 'nabial';
export type Widocznosc = 'prywatna' | 'zgloszona' | 'publiczna';

/**
 * Poziomy zapisywane w bazie (tabela `preferencje_przepisow`, migracja 0025,
 * bez „ulubione” od migracji 0042). „neutralne” do nich nie należy — to brak
 * wiersza, nie osobny stan. Patrz `Preferencja` niżej.
 */
export type PoziomPreferencji = 'lubie' | 'nie_proponuj';

/**
 * Preferencja użytkownika WZGLĘDEM JEGO WŁASNEGO konta, nie popularność
 * przepisu wśród wszystkich. Automat wypełniający plan (`lib/automat.ts`)
 * ma premiować to, co lubi DANY użytkownik, a nie to, co polubił ktoś inny —
 * stąd to rozróżnienie jest tu istotne, nie tylko kosmetyczne.
 */
export type Preferencja = PoziomPreferencji | 'neutralne';

export type PrzepisZMakro = {
  id: string;
  nazwa: string;
  opis: string | null;
  pory: PoraPosilku[];
  kuchnie: Kuchnia[];
  rodzaje: RodzajDania[];
  /** `null`, gdy żadna grupa składników nie daje wyraźnej większości białka. */
  glowne_bialko: GlowneBialko | null;
  /**
   * Efektywna trwałość TEGO konta — `min(trwalosc_dni_wlasna, trwalosc_dni_bazowa)`,
   * gdy konto ma własne (skrócone) ustawienie, inaczej równa bazowej. To ta
   * wartość ma trafiać wszędzie tam, gdzie liczy się planowanie i wyświetlanie
   * (patrz `trwalosc_wlasna`, migracja 0040).
   */
  trwalosc_dni: number;
  /** Górny limit z przepisu — ustawia go autor w formularzu przepisu. */
  trwalosc_dni_bazowa: number;
  /** Własne skrócenie TEGO konta, albo `null`, gdy trzyma się wartości z przepisu. */
  trwalosc_dni_wlasna: number | null;
  liczba_porcji_bazowych: number;
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
  /** Czy automat wolno automatycznie skalować ten przepis kalorycznie (migracja 0036). */
  skalowalny: boolean;
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
  /** Preferencja TEGO konta względem przepisu. `neutralne`, gdy nie ma wiersza. */
  preferencja: Preferencja;
  /** Czy TO konto schowało przepis z listy (migracja 0042, tabela `przepisy_ukryte`). */
  ukryty: boolean;
};

export const OPIS_PREFERENCJI: Record<Preferencja, string> = {
  lubie: 'Lubię',
  neutralne: 'Neutralne',
  nie_proponuj: 'Nie proponuj',
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

/** Kolejność i nazwy rodzajów — tak samo w filtrach, formularzu i arkuszu. */
export const RODZAJE_DAN: RodzajDania[] = [
  'zupa',
  'salatka',
  'makaron',
  'kasza_ryz',
  'gulasz_curry',
  'z_piekarnika',
  'kanapki',
  'jajka',
  'na_slodko',
];

export const OPIS_RODZAJU: Record<RodzajDania, string> = {
  zupa: 'Zupa lub krem',
  salatka: 'Sałatka',
  makaron: 'Makaron',
  kasza_ryz: 'Kasza lub ryż z dodatkami',
  gulasz_curry: 'Gulasz lub curry',
  z_piekarnika: 'Z piekarnika',
  kanapki: 'Kanapki i tortille',
  jajka: 'Jajka',
  na_slodko: 'Na słodko',
};

/** Krótkie nazwy — na pigułki filtrów, gdzie liczy się szerokość. */
export const SKROT_RODZAJU: Record<RodzajDania, string> = {
  zupa: 'Zupy',
  salatka: 'Sałatki',
  makaron: 'Makarony',
  kasza_ryz: 'Kasza, ryż',
  gulasz_curry: 'Gulasz, curry',
  z_piekarnika: 'Z piekarnika',
  kanapki: 'Kanapki',
  jajka: 'Jajka',
  na_slodko: 'Na słodko',
};

export const GLOWNE_BIALKA: GlowneBialko[] = ['drob', 'mieso', 'ryba', 'straczki', 'jaja', 'nabial'];

export const OPIS_BIALKA: Record<GlowneBialko, string> = {
  drob: 'Drób',
  mieso: 'Mięso',
  ryba: 'Ryby i owoce morza',
  straczki: 'Strączki i tofu',
  jaja: 'Jajka',
  nabial: 'Nabiał',
};

export const SKROT_BIALKA: Record<GlowneBialko, string> = {
  drob: 'Drób',
  mieso: 'Mięso',
  ryba: 'Ryby',
  straczki: 'Strączki',
  jaja: 'Jajka',
  nabial: 'Nabiał',
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
  const [wynikPrzepisow, wynikMakro, wynikBialka] = await Promise.all([
    supabase
      .from('przepisy')
      .select(
        `id, nazwa, opis, pory, kuchnie, rodzaje, trwalosc_dni, liczba_porcji_bazowych, porcje,
         czas_przygotowania_min, czas_obrobki_min, sprzet, przechowywanie, mozna_mrozic,
         ratunek, porcjowanie, widocznosc, zgloszono_kiedy, powod_odrzucenia, autor_id, zdjecie,
         skalowalny, preferencje_przepisow (konto_id, poziom), trwalosc_wlasna (konto_id, dni),
         przepisy_ukryte (konto_id)`
      )
      .order('nazwa'),
    supabase
      .from('przepis_makro')
      .select(
        'przepis_id, porcje_wyliczone, gramy_porcji, gramy_calosc, kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, cukry_wolne_g, kcal_calosc, bialko_g_calosc, nova_max'
      ),
    supabase.from('przepis_bialko').select('przepis_id, glowne_bialko'),
  ]);

  if (wynikPrzepisow.error) throw wynikPrzepisow.error;
  if (wynikMakro.error) throw wynikMakro.error;
  if (wynikBialka.error) throw wynikBialka.error;

  const makroWedlugPrzepisu = new Map(
    (wynikMakro.data ?? []).map((m) => [m.przepis_id as string, m])
  );
  const bialkoWedlugPrzepisu = new Map(
    (wynikBialka.data ?? []).map((b) => [b.przepis_id as string, b.glowne_bialko as GlowneBialko])
  );

  return (wynikPrzepisow.data ?? []).map((p): PrzepisZMakro => {
    const makro = makroWedlugPrzepisu.get(p.id);
    const preferencje = (p.preferencje_przepisow ?? []) as {
      konto_id: string;
      poziom: PoziomPreferencji;
    }[];
    const wlasna = kontoId ? preferencje.find((x) => x.konto_id === kontoId) : undefined;

    const trwalosciWlasne = (p.trwalosc_wlasna ?? []) as { konto_id: string; dni: number }[];
    const trwaloscWlasna = kontoId
      ? (trwalosciWlasne.find((x) => x.konto_id === kontoId)?.dni ?? null)
      : null;
    // Górny limit z przepisu obowiązuje zawsze, nawet gdyby własne ustawienie
    // było starsze niż ostatnia (niższa) zmiana bazowej wartości przez autora.
    const trwaloscEfektywna =
      trwaloscWlasna !== null ? Math.min(trwaloscWlasna, p.trwalosc_dni) : p.trwalosc_dni;

    const ukryte = (p.przepisy_ukryte ?? []) as { konto_id: string }[];
    const ukryty = kontoId ? ukryte.some((x) => x.konto_id === kontoId) : false;

    return {
      id: p.id,
      nazwa: p.nazwa,
      opis: p.opis,
      pory: p.pory ?? [],
      kuchnie: p.kuchnie ?? [],
      rodzaje: p.rodzaje ?? [],
      glowne_bialko: bialkoWedlugPrzepisu.get(p.id) ?? null,
      trwalosc_dni: trwaloscEfektywna,
      trwalosc_dni_bazowa: p.trwalosc_dni,
      trwalosc_dni_wlasna: trwaloscWlasna,
      liczba_porcji_bazowych: p.liczba_porcji_bazowych,
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
      skalowalny: p.skalowalny,
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
      preferencja: wlasna?.poziom ?? 'neutralne',
      ukryty,
    };
  });
}

/**
 * Ustawia preferencję konta względem przepisu.
 *
 * `neutralne` kasuje wiersz — to jest wartość domyślna, więc nie ma czego
 * zapisywać. Pozostałe trzy poziomy zapisuje się jednym upsertem: jeśli
 * wiersz już był (inny poziom), podmienia się sam, bez osobnego sprawdzania.
 */
export async function ustawPreferencje(
  przepisId: string,
  kontoId: string,
  poziom: Preferencja
): Promise<void> {
  if (poziom === 'neutralne') {
    const { error } = await supabase
      .from('preferencje_przepisow')
      .delete()
      .eq('przepis_id', przepisId)
      .eq('konto_id', kontoId);
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from('preferencje_przepisow')
    .upsert(
      { przepis_id: przepisId, konto_id: kontoId, poziom },
      { onConflict: 'przepis_id,konto_id' }
    );
  if (error) throw error;
}

/**
 * Chowa albo przywraca przepis na liście TEGO konta (migracja 0042, tabela
 * `przepisy_ukryte`). Czysto widokowe — automat wypełniający plan
 * (`lib/automat.ts`) w ogóle na to nie patrzy, tylko na preferencję.
 */
export async function ustawUkryty(
  przepisId: string,
  kontoId: string,
  ukryty: boolean
): Promise<void> {
  if (!ukryty) {
    const { error } = await supabase
      .from('przepisy_ukryte')
      .delete()
      .eq('przepis_id', przepisId)
      .eq('konto_id', kontoId);
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from('przepisy_ukryte')
    .upsert(
      { przepis_id: przepisId, konto_id: kontoId },
      { onConflict: 'przepis_id,konto_id' }
    );
  if (error) throw error;
}

/**
 * Ustawia własną (skróconą) trwałość konta dla danego przepisu (migracja 0040).
 *
 * `dni` równe bazowej wartości z przepisu kasuje wiersz — to znaczy „trzymaj
 * się przepisu”, więc nie ma czego osobno zapisywać. Wartość zawsze przycinamy
 * do `[0, bazowaDni]`, żeby nie dało się ustawić dłużej niż pozwala przepis.
 */
export async function ustawTrwaloscWlasna(
  przepisId: string,
  kontoId: string,
  dni: number,
  bazowaDni: number
): Promise<void> {
  const docelowe = Math.min(Math.max(0, dni), bazowaDni);

  if (docelowe === bazowaDni) {
    const { error } = await supabase
      .from('trwalosc_wlasna')
      .delete()
      .eq('przepis_id', przepisId)
      .eq('konto_id', kontoId);
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from('trwalosc_wlasna')
    .upsert(
      { przepis_id: przepisId, konto_id: kontoId, dni: docelowe },
      { onConflict: 'przepis_id,konto_id' }
    );
  if (error) throw error;
}

/** Włącza/wyłącza checkbox „można skalować kalorycznie" (migracja 0036) bez otwierania pełnego formularza. */
export async function ustawSkalowalny(przepisId: string, skalowalny: boolean): Promise<void> {
  const { error } = await supabase.from('przepisy').update({ skalowalny }).eq('id', przepisId);
  if (error) throw error;
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
  rodzaje: RodzajDania[];
  trwalosc_dni: number;
  liczba_porcji_bazowych: number;
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
  /** Czy automat wolno automatycznie skalować ten przepis kalorycznie (migracja 0036). */
  skalowalny: boolean;
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
    /** Nadpisanie roli/kwantyzacji TYLKO dla tego przepisu — patrz migracja 0035. */
    rola: RolaSkladnika | null;
    mozna_dzielic: boolean | null;
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
        `id, nazwa, opis, pory, kuchnie, rodzaje, trwalosc_dni, liczba_porcji_bazowych, porcjowanie,
         porcje, porcja_g, czas_przygotowania_min, czas_obrobki_min, sprzet, przechowywanie,
         mozna_mrozic, ratunek, widocznosc, zgloszono_kiedy, powod_odrzucenia, zdjecie, skalowalny`
      )
      .eq('id', id)
      .single(),
    supabase
      .from('przepis_skladniki')
      .select(
        'skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, opis_potoczny, kolejnosc, rola, mozna_dzielic, skladniki (nazwa)'
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
    rola: s.rola as RolaSkladnika | null,
    mozna_dzielic: s.mozna_dzielic as boolean | null,
  }));

  return {
    ...(wynikPrzepisu.data as Omit<PelnyPrzepis, 'skladniki' | 'etapy'>),
    skladniki,
    etapy,
  };
}

/**
 * Wszystkie pełne przepisy naraz — do eksportu.
 *
 * `pobierzPelnyPrzepis` woła trzy zapytania NA JEDEN przepis, więc dla
 * całej bazy zrobiłby ich dziesiątki. Tutaj te same trzy tabele pytamy raz,
 * dla wszystkich przepisów widocznych temu kontu, i składamy w pamięci —
 * dokładnie ta sama sztuczka co w `pobierzPrzepisy` z widokiem makra.
 *
 * Widoczność pilnują reguły dostępu w bazie: zwykły użytkownik dostanie
 * tylko swoje prywatne i to, co publiczne; eksport nie omija tego w żaden sposób.
 */
export async function pobierzWszystkiePelnePrzepisy(): Promise<PelnyPrzepis[]> {
  const [wynikPrzepisow, wynikSkladnikow, wynikEtapow] = await Promise.all([
    supabase
      .from('przepisy')
      .select(
        `id, nazwa, opis, pory, kuchnie, rodzaje, trwalosc_dni, liczba_porcji_bazowych, porcjowanie,
         porcje, porcja_g, czas_przygotowania_min, czas_obrobki_min, sprzet, przechowywanie,
         mozna_mrozic, ratunek, widocznosc, zgloszono_kiedy, powod_odrzucenia, zdjecie, skalowalny`
      )
      .order('nazwa'),
    supabase
      .from('przepis_skladniki')
      .select(
        'przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, opis_potoczny, kolejnosc, rola, mozna_dzielic, skladniki (nazwa)'
      )
      .order('kolejnosc'),
    supabase
      .from('etapy')
      .select('id, przepis_id, nazwa, minuty, kolejnosc, kroki (tresc, sygnal, uwaga, kolejnosc)')
      .order('kolejnosc'),
  ]);

  if (wynikPrzepisow.error) throw wynikPrzepisow.error;
  if (wynikSkladnikow.error) throw wynikSkladnikow.error;
  if (wynikEtapow.error) throw wynikEtapow.error;

  const skladnikiWedlugPrzepisu = new Map<string, PelnyPrzepis['skladniki']>();
  for (const s of wynikSkladnikow.data ?? []) {
    const id = s.przepis_id as string;
    const lista = skladnikiWedlugPrzepisu.get(id) ?? [];
    lista.push({
      skladnik_id: s.skladnik_id as string,
      nazwa: nazwaSkladnika(s.skladniki),
      ilosc: Number(s.ilosc),
      jednostka: s.jednostka as 'g' | 'ml' | 'szt',
      gramy: Number(s.gramy),
      stan: s.stan as string | null,
      zamiennik: s.zamiennik as string | null,
      opis_potoczny: s.opis_potoczny as string | null,
      kolejnosc: s.kolejnosc as number,
      rola: s.rola as RolaSkladnika | null,
      mozna_dzielic: s.mozna_dzielic as boolean | null,
    });
    skladnikiWedlugPrzepisu.set(id, lista);
  }

  const etapyWedlugPrzepisu = new Map<string, PelnyPrzepis['etapy']>();
  for (const e of wynikEtapow.data ?? []) {
    const id = e.przepis_id as string;
    const lista = etapyWedlugPrzepisu.get(id) ?? [];
    lista.push({
      nazwa: e.nazwa as string,
      minuty: e.minuty as number | null,
      kroki: (
        (e.kroki ?? []) as { tresc: string; sygnal: string | null; uwaga: boolean; kolejnosc: number }[]
      )
        .slice()
        .sort((a, b) => a.kolejnosc - b.kolejnosc)
        .map((k) => ({ tresc: k.tresc, sygnal: k.sygnal, uwaga: k.uwaga })),
    });
    etapyWedlugPrzepisu.set(id, lista);
  }

  return (wynikPrzepisow.data ?? []).map((p) => ({
    ...(p as Omit<PelnyPrzepis, 'skladniki' | 'etapy'>),
    skladniki: (skladnikiWedlugPrzepisu.get(p.id) ?? []).slice().sort((a, b) => a.kolejnosc - b.kolejnosc),
    etapy: etapyWedlugPrzepisu.get(p.id) ?? [],
  }));
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
 * Moderator ukrywa już opublikowany przepis — bez podawania powodu, bo nie ma
 * tu autora, którego trzeba czegokolwiek nauczyć (to nie jest odrzucenie
 * zgłoszenia, tylko wycofanie publikacji).
 */
export async function ukryjPrzepis(przepisId: string) {
  const { error } = await supabase
    .from('przepisy')
    .update({ widocznosc: 'prywatna' })
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
