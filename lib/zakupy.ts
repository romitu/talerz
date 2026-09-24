/**
 * Lista zakupów wyliczana z planu.
 *
 * Nie jest osobnym bytem w bazie — powstaje z tego, co stoi w planie.
 * Dzięki temu nie może się rozjechać z posiłkami: zmiana planu zmienia listę.
 */

import { supabase } from './supabase';

/**
 * Co identyfikuje „potrzebę" składnika przy odhaczaniu: konkretne gotowanie
 * (partia — danie na kilka dni) albo pojedynczy posiłek bez partii.
 *
 * NIE plan i NIE okno dat — plan bywa dowolnej długości i zaczyna się
 * w dowolnym dniu („Start od" przesuwa ten sam plan zamiast zakładać nowy
 * tydzień), więc odhaczenie przypięte do planu gubiło się przy każdej takiej
 * zmianie. Gotowanie samo w sobie jest jedyną rzeczą, która się nie zmienia.
 */
export type ZrodloTyp = 'partia' | 'pozycja';

/** Skąd zdjęcie składnika: grafika AI (poglądowa) albo zdjęcie własne. */
export type ZrodloZdjecia = 'ai' | 'wlasne';

export type PozycjaZakupow = {
  skladnik_id: string;
  zrodlo_typ: ZrodloTyp;
  zrodlo_id: string;
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
  /** Ścieżka w zasobniku „zdjecia-skladnikow” albo null (migracja 0045). */
  zdjecie: string | null;
  zdjecie_zrodlo: ZrodloZdjecia | null;
  /**
   * Danie było ugotowane przed dzisiaj — skoro powstało zgodnie z planem,
   * składniki musiały już być kupione, niezależnie czy ktoś zdążył odhaczyć
   * checkbox (np. aplikacja zawiesiła się w sklepie). Patrz `pobierzListeZakupow`.
   */
  zrealizowano_automatycznie: boolean;
};

/** Klucz odhaczenia — ten sam wzór używany przy zapisie i przy odczycie. */
export function kluczOdhaczenia(p: {
  zrodlo_typ: string;
  zrodlo_id: string;
  skladnik_id: string;
}): string {
  return `${p.zrodlo_typ}:${p.zrodlo_id}:${p.skladnik_id}`;
}

export type PozycjaSkonsolidowana = {
  skladnik_id: string;
  nazwa: string;
  gramy: number;
  tagi: string[];
  opakowanie_g: number | null;
  opakowan: number | null;
  reszta_g: number | null;
  dania: string[];
  zdjecie: string | null;
  zdjecie_zrodlo: ZrodloZdjecia | null;
  /** Wszystkie źródła zsumowane w tę pozycję — odhaczenie musi ustawić je WSZYSTKIE naraz. */
  zrodla: { zrodlo_typ: ZrodloTyp; zrodlo_id: string }[];
};

/**
 * Sumuje granularne pozycje (per składnik + źródło) do jednej pozycji na
 * składnik, do pokazania w jednej sekcji listy („do kupienia" albo
 * „zrealizowane w poprzedniej sesji").
 *
 * Podział na sekcje robi wywołujący, PRZED wywołaniem tej funkcji — inaczej
 * już kupiona partia zlałaby się z jeszcze nie kupioną w jedną liczbę
 * z niejednoznacznym stanem odhaczenia.
 */
export function skonsolidujSkladniki(pozycje: PozycjaZakupow[]): PozycjaSkonsolidowana[] {
  const zebrane = new Map<string, PozycjaSkonsolidowana>();

  for (const p of pozycje) {
    const wpis = zebrane.get(p.skladnik_id) ?? {
      skladnik_id: p.skladnik_id,
      nazwa: p.nazwa,
      gramy: 0,
      tagi: p.tagi,
      opakowanie_g: p.opakowanie_g,
      opakowan: null,
      reszta_g: null,
      dania: [],
      zdjecie: p.zdjecie,
      zdjecie_zrodlo: p.zdjecie_zrodlo,
      zrodla: [],
    };
    wpis.gramy += p.gramy;
    for (const d of p.dania) if (!wpis.dania.includes(d)) wpis.dania.push(d);
    wpis.zrodla.push({ zrodlo_typ: p.zrodlo_typ, zrodlo_id: p.zrodlo_id });
    zebrane.set(p.skladnik_id, wpis);
  }

  for (const wpis of zebrane.values()) {
    wpis.gramy = Math.round(wpis.gramy);
    if (wpis.opakowanie_g && wpis.opakowanie_g > 0) {
      wpis.opakowan = Math.ceil(wpis.gramy / wpis.opakowanie_g);
      wpis.reszta_g = wpis.opakowan * wpis.opakowanie_g - wpis.gramy;
    }
  }

  return [...zebrane.values()].sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl'));
}

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
 * Zbiera składniki ze WSZYSTKICH posiłków konta, które są jeszcze aktualne —
 * nie z jednego planu ani jednego zakresu dat.
 *
 * „Aktualne" znaczy:
 *  - danie z partii (gotowanie na kilka dni): dopóki partia jest jadalna
 *    (`wazne_do` >= dzisiaj) — bez względu na to, w którym planie i w jakim
 *    oknie dat leżą jej poszczególne dni;
 *  - danie bez partii (pojedynczy posiłek): dopóki jego dzień jeszcze nie minął.
 *
 * RLS na `plan_pozycje` już ogranicza wynik do własnych planów konta — nie
 * trzeba filtrować po `plan_id`. To celowe: plan bywa dowolnej długości
 * i zaczyna się w dowolnym dniu, więc „zakres dat jednego planu" nie jest
 * stabilnym pojęciem, na którym dałoby się oprzeć listę zakupów.
 *
 * Ilość każdego składnika mnożymy przez liczbę porcji w planie i dzielimy
 * przez liczbę porcji, na które rozpisany jest przepis — inaczej przy zupie
 * na sześć osób kupilibyśmy sześciokrotność tego, co potrzebne.
 */
export async function pobierzListeZakupow(dzisiaj: string): Promise<PozycjaZakupow[]> {
  const { data: wszystkie, error } = await supabase
    .from('plan_pozycje')
    .select(
      'id, data, przepis_id, przepis_skalowany_id, porcje, partia_id, przepisy (nazwa), partie (data_ugotowania, wazne_do)'
    );

  if (error) throw error;
  if (!wszystkie || wszystkie.length === 0) return [];

  type DanePartii = { data_ugotowania: string; wazne_do: string };
  // Supabase zwraca powiązanie raz jako obiekt, raz jako jednoelementową listę.
  function jednaPartia(surowy: unknown): DanePartii | null {
    const x = surowy as DanePartii | DanePartii[] | null;
    return Array.isArray(x) ? (x[0] ?? null) : x;
  }

  const pozycje = wszystkie.filter((p) => {
    const partia = jednaPartia(p.partie);
    if (partia) return partia.wazne_do >= dzisiaj;
    return (p.data as string) >= dzisiaj;
  });

  if (pozycje.length === 0) return [];

  // Pozycja bierze składniki ALBO z przepisu źródłowego, ALBO z konkretnego
  // wariantu skalowanego (migracja 0036) — nigdy z obu naraz. Stąd dwa
  // rozłączne zbiory identyfikatorów i dwa niezależne zapytania niżej.
  const zwykle = pozycje.filter((p) => !p.przepis_skalowany_id);
  const skalowane = pozycje.filter((p) => p.przepis_skalowany_id);

  const idPrzepisow = [...new Set(zwykle.map((p) => p.przepis_id as string))];
  const idSkalowanych = [...new Set(skalowane.map((p) => p.przepis_skalowany_id as string))];

  type DaneSkladnika = {
    nazwa: string;
    tagi: string[];
    gramatura_opakowania_g: number | null;
    zdjecie: string | null;
    zdjecie_zrodlo: ZrodloZdjecia | null;
  };
  // Supabase zwraca powiązanie raz jako obiekt, raz jako jednoelementową listę.
  function jedenSkladnik(surowy: unknown): DaneSkladnika | null {
    const x = surowy as DaneSkladnika | DaneSkladnika[] | null;
    return Array.isArray(x) ? (x[0] ?? null) : x;
  }

  const [wynikSkladnikow, wynikMakro, wynikSkalowanych] = await Promise.all([
    idPrzepisow.length > 0
      ? supabase
          .from('przepis_skladniki')
          .select('przepis_id, skladnik_id, gramy, skladniki (nazwa, tagi, gramatura_opakowania_g, zdjecie, zdjecie_zrodlo)')
          .in('przepis_id', idPrzepisow)
      : Promise.resolve({ data: [], error: null }),
    idPrzepisow.length > 0
      ? supabase.from('przepis_makro').select('przepis_id, porcje_wyliczone').in('przepis_id', idPrzepisow)
      : Promise.resolve({ data: [], error: null }),
    idSkalowanych.length > 0
      ? supabase
          .from('przepisy_skalowane_skladniki')
          .select(
            'przepis_skalowany_id, skladnik_id, gramy, skladniki (nazwa, tagi, gramatura_opakowania_g, zdjecie, zdjecie_zrodlo)'
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

  // Klucz to skladnik_id + zrodlo (partia albo pozycja) — NIE sam skladnik_id.
  // Inaczej ten sam składnik z gotowania już zrealizowanego zlałby się z tym
  // samym składnikiem dania dopiero zaplanowanego, dając jedną scaloną ilość
  // z niejednoznacznym stanem odhaczenia.
  const zebrane = new Map<string, PozycjaZakupow>();

  function dolicz(
    id: string,
    zrodloTyp: ZrodloTyp,
    zrodloId: string,
    zrealizowanoAutomatycznie: boolean,
    dane: DaneSkladnika,
    gramy: number,
    nazwaDania: string
  ) {
    const klucz = `${zrodloTyp}::${zrodloId}::${id}`;
    const wpis = zebrane.get(klucz) ?? {
      skladnik_id: id,
      zrodlo_typ: zrodloTyp,
      zrodlo_id: zrodloId,
      nazwa: dane.nazwa,
      gramy: 0,
      tagi: dane.tagi ?? [],
      opakowanie_g: dane.gramatura_opakowania_g,
      opakowan: null,
      reszta_g: null,
      dania: [],
      zdjecie: dane.zdjecie ?? null,
      zdjecie_zrodlo: dane.zdjecie_zrodlo ?? null,
      zrealizowano_automatycznie: zrealizowanoAutomatycznie,
    };
    wpis.gramy += gramy;
    if (nazwaDania && !wpis.dania.includes(nazwaDania)) wpis.dania.push(nazwaDania);
    zebrane.set(klucz, wpis);
  }

  for (const pozycja of zwykle) {
    const przepisId = pozycja.przepis_id as string;
    const partia = jednaPartia(pozycja.partie);
    const zrodloTyp: ZrodloTyp = partia ? 'partia' : 'pozycja';
    const zrodloId = partia ? (pozycja.partia_id as string) : (pozycja.id as string);
    const zrealizowanoAutomatycznie = partia ? partia.data_ugotowania < dzisiaj : false;
    const przepis = pozycja.przepisy as { nazwa: string } | { nazwa: string }[] | null;
    const nazwaDania = (Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa) ?? '';
    const naPorcje = porcjiWPrzepisie.get(przepisId) ?? 1;
    const mnoznik = (pozycja.porcje as number) / naPorcje;

    for (const s of wynikSkladnikow.data ?? []) {
      if (s.przepis_id !== przepisId) continue;
      const skladnik = jedenSkladnik(s.skladniki);
      if (!skladnik) continue;
      dolicz(
        s.skladnik_id as string,
        zrodloTyp,
        zrodloId,
        zrealizowanoAutomatycznie,
        skladnik,
        Number(s.gramy) * mnoznik,
        nazwaDania
      );
    }
  }

  // Wariant skalowany reprezentuje JEDEN posiłek (patrz lib/skalowanie-kalorii.ts
  // i migracja 0036) — bez dzielenia przez porcje_wyliczone, tylko razy liczba
  // jedzących (porcje) tej pozycji, tak jak przy zwykłym przepisie na sztuki.
  for (const pozycja of skalowane) {
    const przepisSkalowanyId = pozycja.przepis_skalowany_id as string;
    const partia = jednaPartia(pozycja.partie);
    const zrodloTyp: ZrodloTyp = partia ? 'partia' : 'pozycja';
    const zrodloId = partia ? (pozycja.partia_id as string) : (pozycja.id as string);
    const zrealizowanoAutomatycznie = partia ? partia.data_ugotowania < dzisiaj : false;
    const przepis = pozycja.przepisy as { nazwa: string } | { nazwa: string }[] | null;
    const nazwaDania = (Array.isArray(przepis) ? przepis[0]?.nazwa : przepis?.nazwa) ?? '';
    const mnoznik = pozycja.porcje as number;

    for (const s of wynikSkalowanych.data ?? []) {
      if (s.przepis_skalowany_id !== przepisSkalowanyId) continue;
      const skladnik = jedenSkladnik(s.skladniki);
      if (!skladnik) continue;
      dolicz(
        s.skladnik_id as string,
        zrodloTyp,
        zrodloId,
        zrealizowanoAutomatycznie,
        skladnik,
        Number(s.gramy) * mnoznik,
        nazwaDania
      );
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
 * Klucze (patrz `kluczOdhaczenia`) składników już wrzuconych do koszyka —
 * DLA TEGO KONTA, po gotowaniu (`zrodlo_typ` + `zrodlo_id`), nie po planie.
 *
 * Ptaszek jest właściwością gotowania, nie okna planu: plan bywa dowolnej
 * długości i zaczyna się w dowolnym dniu („Start od" przesuwa ten sam plan
 * zamiast zakładać nowy tydzień), więc klucz na `plan_id` gubił odhaczenie
 * przy każdej takiej zmianie, mimo że danie fizycznie zostało kupione.
 */
export async function pobierzOdhaczone(kontoId: string): Promise<Set<string>> {
  const { data, error } = await supabase
    .from('zakupy_odhaczone')
    .select('skladnik_id, zrodlo_typ, zrodlo_id')
    .eq('konto_id', kontoId);

  if (error) throw error;
  return new Set((data ?? []).map((x) => kluczOdhaczenia(x)));
}

export async function ustawOdhaczenie(
  kontoId: string,
  zrodloTyp: ZrodloTyp,
  zrodloId: string,
  skladnikId: string,
  odhaczony: boolean
) {
  if (odhaczony) {
    const { error } = await supabase.from('zakupy_odhaczone').upsert({
      konto_id: kontoId,
      zrodlo_typ: zrodloTyp,
      zrodlo_id: zrodloId,
      skladnik_id: skladnikId,
    });
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from('zakupy_odhaczone')
    .delete()
    .eq('konto_id', kontoId)
    .eq('zrodlo_typ', zrodloTyp)
    .eq('zrodlo_id', zrodloId)
    .eq('skladnik_id', skladnikId);
  if (error) throw error;
}

/**
 * Czyści wszystkie ptaszki konta — początek nowego, świeżego liczenia zakupów.
 *
 * Bezpieczne mimo braku podziału na plan: danie już zrealizowane automatycznie
 * (`zrealizowano_automatycznie` — data ugotowania minęła) i tak nie wróci jako
 * „do kupienia", więc czyszczenie rusza tylko to, co faktycznie wymaga
 * ponownego potwierdzenia.
 */
export async function wyczyscOdhaczenia(kontoId: string) {
  const { error } = await supabase.from('zakupy_odhaczone').delete().eq('konto_id', kontoId);
  if (error) throw error;
}
