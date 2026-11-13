/**
 * Zapis zaimportowanych przepisów do bazy.
 *
 * Skąd przepisy przychodzą, nie ma tu znaczenia — czyta je i sprawdza
 * `lib/przepis-json.ts`. Ten plik wie tylko, jak gotowy przepis zapisać.
 *
 * ZASADA DOPASOWANIA: NAZWA
 * --------------------------
 * Import rozpoznaje przepis PO NAZWIE (migracja 0018 zakłada na to unikalny
 * indeks). Nazwa identyczna bez względu na wielkość liter i białe znaki = to
 * samo danie: treść w bazie zostaje ZASTĄPIONA tym, co jest w pliku. Nazwa,
 * której nie ma w bazie = nowy, prywatny przepis. Zmiana nazwy w pliku nie
 * „przenosi” starego przepisu — tworzy nowy, a stary zostaje bez zmian.
 *
 * Import jest ATOMOWY NA PRZEPIS, nie na cały plik: błąd w jednym daniu
 * odrzuca TYLKO to danie.
 *
 * Czego import NIE rusza
 * -----------------------
 * Zdjęcia i stanu publikacji (widocznosc, zgloszono_kiedy, powod_odrzucenia) —
 * obieg publikacji ma własne reguły w bazie (migracja 0022). Katalogów
 * składników i sprzętu też nie: mają zostać zwarte, więc nieznana nazwa
 * odrzuca danie już przy wczytaniu, zamiast dopisywać nową pozycję.
 */

import { wyczyscTrescPrzepisu, type Kuchnia, type PoraPosilku, type RodzajDania } from './przepisy';
import type { RolaSkladnika } from './skladniki';
import { supabase } from './supabase';

/** Klucz do dopasowania nazw — taki sam jak w bazie (migracja 0018): białe znaki złożone do jednej spacji, bez wielkości liter. */
function klucz(nazwa: string): string {
  return nazwa.trim().replace(/\s+/g, ' ').toLowerCase();
}

// =============================================================================
//  PRZEPIS GOTOWY DO ZAPISU
// =============================================================================

export type BladImportu = {
  przepis: string | null;
  tresc: string;
};

export type SkladnikDoImportu = {
  skladnik_id: string;
  nazwa: string;
  ilosc: number;
  jednostka: 'g' | 'ml' | 'szt';
  gramy: number;
  stan: string | null;
  zamiennik: string | null;
  opis_potoczny: string | null;
  /**
   * Rola i kwantyzacja TYLKO dla tego przepisu (patrz migracja 0035) —
   * z pliku, a gdy plik ich nie nadpisuje, skopiowane ze składnika.
   */
  rola?: RolaSkladnika | null;
  mozna_dzielic?: boolean | null;
};

export type EtapDoImportu = {
  nazwa: string;
  minuty: number | null;
  kroki: { tresc: string; sygnal: string | null; uwaga: boolean }[];
};

export type PrzepisDoImportu = {
  nazwa: string;
  opis: string | null;
  pory: PoraPosilku[];
  kuchnie: Kuchnia[];
  /**
   * `undefined`, gdy plik nie ma pola `rodzaje` — wtedy zapis nie rusza
   * rodzajów w bazie, zamiast je wyzerować.
   */
  rodzaje?: RodzajDania[];
  trwalosc_dni: number;
  porcjowanie: 'waga' | 'sztuki';
  porcje: number;
  porcja_g: number | null;
  /**
   * `undefined`, gdy plik jej nie podaje — wtedy zapis nie rusza wartości
   * ustawionej w bazie, a zero uzupełnia wyliczeniem (patrz `zaimportujPrzepis`).
   */
  liczba_porcji_bazowych?: number;
  czas_przygotowania_min: number | null;
  czas_obrobki_min: number | null;
  sprzet: string[];
  przechowywanie: string | null;
  mozna_mrozic: boolean | null;
  ratunek: string | null;
  skladniki: SkladnikDoImportu[];
  etapy: EtapDoImportu[];
};

export type WynikWczytania = {
  /** Tylko przepisy, które przeszły walidację w całości — reszta trafiła do `bledy`. */
  przepisy: PrzepisDoImportu[];
  bledy: BladImportu[];
};

// =============================================================================
//  KLASYFIKACJA: CO JEST NOWE, CO JEST KOREKTĄ
// =============================================================================

export type PozycjaImportu = {
  dane: PrzepisDoImportu;
  /** `null` = nowy przepis. W przeciwnym razie identyfikator istniejącego, który zostanie nadpisany. */
  istniejacyId: string | null;
};

export function sklasyfikujPrzepisy(
  wczytane: PrzepisDoImportu[],
  istniejace: { id: string; nazwa: string }[]
): PozycjaImportu[] {
  const idWedlugNazwy = new Map(istniejace.map((p) => [klucz(p.nazwa), p.id]));
  return wczytane.map((dane) => ({
    dane,
    istniejacyId: idWedlugNazwy.get(klucz(dane.nazwa)) ?? null,
  }));
}

// =============================================================================
//  ZAPIS DO BAZY
// =============================================================================

/**
 * Zapisuje jeden przepis: nowy albo korektę istniejącego (rozpoznanego po nazwie).
 *
 * Przy korekcie zachowuje się tak samo, jak edycja z formularza — nagłówek
 * się aktualizuje, a treść (składniki, etapy, kroki) wstawia od nowa. Nie
 * rusza zdjęcia ani stanu publikacji, bo plik o nich nic nie wie.
 */
export async function zaimportujPrzepis(
  pozycja: PozycjaImportu,
  autorId: string
): Promise<string> {
  const { dane, istniejacyId } = pozycja;

  const naglowek = {
    nazwa: dane.nazwa,
    opis: dane.opis,
    pory: dane.pory,
    kuchnie: dane.kuchnie,
    trwalosc_dni: dane.trwalosc_dni,
    porcjowanie: dane.porcjowanie,
    porcje: dane.porcje,
    porcja_g: dane.porcja_g,
    czas_przygotowania_min: dane.czas_przygotowania_min,
    czas_obrobki_min: dane.czas_obrobki_min,
    sprzet: dane.sprzet,
    przechowywanie: dane.przechowywanie,
    mozna_mrozic: dane.mozna_mrozic,
    ratunek: dane.ratunek,
    ...(dane.rodzaje !== undefined ? { rodzaje: dane.rodzaje } : {}),
    // Plik bez tego pola (`undefined`) — wtedy update() go pomija i dotychczasowa
    // wartość w bazie zostaje nietknięta, zamiast wyzerować się.
    ...(dane.liczba_porcji_bazowych !== undefined
      ? { liczba_porcji_bazowych: dane.liczba_porcji_bazowych }
      : {}),
  };

  /*
    Plik bez liczby porcji bazowych (tak pisze AI — prompt o nią nie pyta) nie
    może zostawić w bazie zera: formularz przy porcjowaniu na wagę liczy z niej
    masę porcji i z zerem nie pozwala zapisać przepisu. Wyliczamy ją więc tak,
    jak formularz liczy w drugą stronę: masa całości / masa porcji.
  */
  const masaCalosci = dane.skladniki.reduce((suma, s) => suma + s.gramy, 0);
  const porcjeBazoweWyliczone =
    dane.porcjowanie === 'waga' && dane.porcja_g
      ? Math.min(30, Math.max(1, Math.round(masaCalosci / dane.porcja_g)))
      : 1;

  let przepisId: string;

  if (istniejacyId) {
    const { error } = await supabase.from('przepisy').update(naglowek).eq('id', istniejacyId);
    if (error) throw error;
    // Ręcznie ustawiona liczba zostaje — uzupełniamy tylko zero.
    if (dane.liczba_porcji_bazowych === undefined) {
      const { error: bladPorcji } = await supabase
        .from('przepisy')
        .update({ liczba_porcji_bazowych: porcjeBazoweWyliczone })
        .eq('id', istniejacyId)
        .eq('liczba_porcji_bazowych', 0);
      if (bladPorcji) throw bladPorcji;
    }
    await wyczyscTrescPrzepisu(istniejacyId);
    przepisId = istniejacyId;
  } else {
    const { data, error } = await supabase
      .from('przepisy')
      .insert({
        liczba_porcji_bazowych: porcjeBazoweWyliczone,
        ...naglowek,
        autor_id: autorId,
        widocznosc: 'prywatna',
      })
      .select('id')
      .single();
    if (error) throw error;
    przepisId = data.id;
  }

  if (dane.skladniki.length > 0) {
    const { error } = await supabase.from('przepis_skladniki').insert(
      dane.skladniki.map((s, i) => ({
        przepis_id: przepisId,
        skladnik_id: s.skladnik_id,
        gramy: s.gramy,
        ilosc: s.ilosc,
        jednostka: s.jednostka,
        stan: s.stan,
        zamiennik: s.zamiennik,
        opis_potoczny: s.opis_potoczny,
        kolejnosc: i + 1,
        rola: s.rola ?? null,
        mozna_dzielic: s.mozna_dzielic ?? null,
      }))
    );
    if (error) throw error;
  }

  if (dane.etapy.length > 0) {
    const { data: zapisaneEtapy, error: bladEtapow } = await supabase
      .from('etapy')
      .insert(
        dane.etapy.map((e, i) => ({
          przepis_id: przepisId,
          kolejnosc: i + 1,
          nazwa: e.nazwa,
          minuty: e.minuty,
        }))
      )
      .select('id, kolejnosc');
    if (bladEtapow) throw bladEtapow;

    const idWedlugKolejnosci = new Map((zapisaneEtapy ?? []).map((e) => [e.kolejnosc as number, e.id as string]));

    const krokiDoZapisu = dane.etapy.flatMap((e, i) =>
      e.kroki.map((k, j) => ({
        etap_id: idWedlugKolejnosci.get(i + 1)!,
        kolejnosc: j + 1,
        tresc: k.tresc,
        sygnal: k.sygnal,
        uwaga: k.uwaga,
      }))
    );

    if (krokiDoZapisu.length > 0) {
      const { error: bladKrokow } = await supabase.from('kroki').insert(krokiDoZapisu);
      if (bladKrokow) throw bladKrokow;
    }
  }

  return przepisId;
}

/**
 * Zapisuje całą partię, przepis po przepisie. Błąd jednego dania nie zatrzymuje reszty.
 * `zapisane` — żeby ekran mógł od razu otworzyć nowy przepis.
 */
export async function zaimportujPrzepisy(
  pozycje: PozycjaImportu[],
  autorId: string,
  poKazdym?: (zrobione: number, razem: number) => void
): Promise<{ bledy: BladImportu[]; zapisane: { id: string; nazwa: string }[] }> {
  const bledy: BladImportu[] = [];
  const zapisane: { id: string; nazwa: string }[] = [];
  for (let i = 0; i < pozycje.length; i++) {
    try {
      zapisane.push({ id: await zaimportujPrzepis(pozycje[i], autorId), nazwa: pozycje[i].dane.nazwa });
    } catch (e) {
      bledy.push({
        przepis: pozycje[i].dane.nazwa,
        tresc: e instanceof Error ? e.message : String(e),
      });
    }
    poKazdym?.(i + 1, pozycje.length);
  }
  return { bledy, zapisane };
}
