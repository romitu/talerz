/**
 * Import i eksport przepisów przez plik Excel.
 *
 * Po co to jest
 * -------------
 * Ręczne przepisywanie kilkudziesięciu dań w formularzu jest wolne, a bywają
 * sytuacje, w których wygodniejszy jest arkusz: masowa korekta gramatur,
 * kopia zapasowa całej bazy przepisów, przygotowanie dań poza aplikacją.
 * Ten plik zamienia bazę w jeden plik .xlsx i z powrotem.
 *
 * ZASADA DOPASOWANIA: NAZWA
 * --------------------------
 * Import rozpoznaje przepis PO NAZWIE, dokładnie tak samo jak robił to stary
 * import z Firebase (migracja 0018 zakłada na to unikalny indeks). Nazwa
 * identyczna bez względu na wielkość liter i białe znaki = to samo danie:
 * treść w bazie zostaje ZASTĄPIONA tym, co jest w arkuszu. Nazwa, której nie
 * ma w bazie = nowy, prywatny przepis. Zmiana nazwy w arkuszu nie „przenosi”
 * starego przepisu — tworzy nowy, a stary zostaje bez zmian.
 *
 * Import jest ATOMOWY NA PRZEPIS, nie na cały plik. Błąd w jednym daniu
 * (nieznany składnik, zła jednostka, brakujący etap) odrzuca TYLKO to danie —
 * reszta pliku importuje się normalnie. Lepsze to niż odrzucenie całego pliku
 * z powodu jednej literówki w wierszu 400.
 *
 * Czego import NIE rusza
 * -----------------------
 * Zdjęcia i stanu publikacji (widocznosc, zgloszono_kiedy, powod_odrzucenia).
 * Arkusz nie ma jak sensownie unieść zdjęcia, a obieg publikacji ma własne
 * reguły w bazie (migracja 0022) — nadpisanie go przy okazji korekty
 * gramatury byłoby zaskoczeniem, nie funkcją.
 */

import { Workbook } from 'exceljs';

import {
  KATEGORIE,
  OPIS_KUCHNI,
  OPIS_PORY,
  wyczyscTrescPrzepisu,
  type Kuchnia,
  type PelnyPrzepis,
  type PoraPosilku,
} from './przepisy';
import { supabase } from './supabase';
import type { Skladnik } from './skladniki';
import {
  bajtyDoBase64,
  dodajArkuszTabeli,
  komorka,
  kluczNazwy,
  liczbaKomorki,
  mapaNaglowkow,
  odwrotnySlownik,
  podzielListe,
  tekstKomorki,
  wczytajSkoroszyt,
} from './import-eksport-wspolne';

// =============================================================================
//  SŁOWNIKI: ETYKIETA W ARKUSZU <-> WARTOŚĆ W BAZIE
// =============================================================================

const PORA_WEDLUG_ETYKIETY = odwrotnySlownik(OPIS_PORY);
const KUCHNIA_WEDLUG_ETYKIETY = odwrotnySlownik(OPIS_KUCHNI);

const PORCJOWANIE_WEDLUG_ETYKIETY = new Map<string, 'waga' | 'sztuki'>([
  ['na wagę', 'waga'],
  ['na wage', 'waga'],
  ['waga', 'waga'],
  ['na sztuki', 'sztuki'],
  ['sztuki', 'sztuki'],
]);

const ETYKIETA_PORCJOWANIA: Record<'waga' | 'sztuki', string> = {
  waga: 'Na wagę',
  sztuki: 'Na sztuki',
};

// =============================================================================
//  EKSPORT
// =============================================================================

const NAGLOWKI_PRZEPISOW = [
  'Nazwa',
  'Opis',
  'Kategoria',
  'Kuchnia',
  'Trwałość (dni)',
  'Porcjowanie',
  'Porcje',
  'Porcja (g)',
  'Czas przygotowania (min)',
  'Czas obróbki (min)',
  'Sprzęt',
  'Przechowywanie',
  'Można mrozić',
  'Ratunek',
] as const;

const NAGLOWKI_SKLADNIKOW = [
  'Przepis',
  'Składnik',
  'Ilość',
  'Jednostka',
  'Stan',
  'Zamiennik',
  'Opis potoczny',
  'Kolejność',
] as const;

const NAGLOWKI_ETAPOW = ['Przepis', 'Kolejność etapu', 'Nazwa etapu', 'Minuty'] as const;

const NAGLOWKI_KROKOW = [
  'Przepis',
  'Kolejność etapu',
  'Kolejność kroku',
  'Treść',
  'Sygnał',
  'Uwaga',
] as const;

/** Buduje plik .xlsx z podanych przepisów i zwraca go jako base64 — gotowe do zapisu na dysk. */
export async function eksportujPrzepisy(przepisy: PelnyPrzepis[]): Promise<string> {
  const wb = new Workbook();
  wb.creator = 'Talerz';
  wb.created = new Date();

  const instrukcja = wb.addWorksheet('Instrukcja');
  instrukcja.getColumn(1).width = 100;
  [
    'TALERZ — eksport przepisów',
    '',
    'Import rozpoznaje przepis PO NAZWIE (bez względu na wielkość liter). Jeśli w bazie',
    'jest już przepis o identycznej nazwie, jego treść zostanie ZASTĄPIONA tym, co jest',
    'w tym pliku. Nowa nazwa = nowy, prywatny przepis. Zmiana nazwy w arkuszu nie',
    'przenosi starego przepisu — tworzy nowy obok niego.',
    '',
    'Import NIE rusza zdjęcia ani stanu publikacji przepisu.',
    '',
    `Kategoria (arkusz Przepisy): ${KATEGORIE.map((k) => OPIS_PORY[k]).join('; ')} — kilka naraz, oddzielone średnikiem.`,
    `Kuchnia: ${(Object.values(OPIS_KUCHNI) as string[]).join('; ')} — tak samo, kilka naraz.`,
    'Porcjowanie: „Na wagę” (podajesz Porcja (g)) albo „Na sztuki” (podajesz Porcje).',
    'Sprzęt: nazwy oddzielone średnikiem. Nieznane trafiają do katalogu sprzętu same.',
    'Można mrozić: Tak / Nie / puste (nie wiadomo).',
    '',
    'Arkusz Składniki: kolumna „Przepis” musi mieć TĘ SAMĄ nazwę co w arkuszu Przepisy.',
    'Kolumna „Składnik” musi być nazwą, która już istnieje w bazie składników —',
    'import nie tworzy nowych składników, bo brakowałoby im wartości odżywczych.',
    'Jednostka „szt” działa tylko dla składników z ustaloną masą jednej sztuki.',
    '',
    'Arkusze Etapy i Kroki są nieobowiązkowe — przepis bez nich zaimportuje się',
    'z samymi składnikami.',
  ].forEach((linia) => instrukcja.addRow([linia]));

  const wierszePrzepisow = przepisy.map((p) => [
    p.nazwa,
    p.opis ?? '',
    p.pory.map((x) => OPIS_PORY[x]).join('; '),
    p.kuchnie.map((x) => OPIS_KUCHNI[x]).join('; '),
    p.trwalosc_dni,
    ETYKIETA_PORCJOWANIA[p.porcjowanie],
    p.porcjowanie === 'sztuki' ? p.porcje : '',
    p.porcjowanie === 'waga' ? p.porcja_g : '',
    p.czas_przygotowania_min ?? '',
    p.czas_obrobki_min ?? '',
    p.sprzet.join('; '),
    p.przechowywanie ?? '',
    p.mozna_mrozic === null ? '' : p.mozna_mrozic ? 'Tak' : 'Nie',
    p.ratunek ?? '',
  ]);
  dodajArkuszTabeli(wb, 'Przepisy', NAGLOWKI_PRZEPISOW, wierszePrzepisow);

  const wierszeSkladnikow = przepisy.flatMap((p) =>
    p.skladniki.map((s) => [
      p.nazwa,
      s.nazwa,
      s.ilosc,
      s.jednostka,
      s.stan ?? '',
      s.zamiennik ?? '',
      s.opis_potoczny ?? '',
      s.kolejnosc,
    ])
  );
  dodajArkuszTabeli(wb, 'Składniki', NAGLOWKI_SKLADNIKOW, wierszeSkladnikow);

  const wierszeEtapow = przepisy.flatMap((p) =>
    p.etapy.map((e, i) => [p.nazwa, i + 1, e.nazwa, e.minuty ?? ''])
  );
  dodajArkuszTabeli(wb, 'Etapy', NAGLOWKI_ETAPOW, wierszeEtapow);

  const wierszeKrokow = przepisy.flatMap((p) =>
    p.etapy.flatMap((e, i) =>
      e.kroki.map((k, j) => [p.nazwa, i + 1, j + 1, k.tresc, k.sygnal ?? '', k.uwaga ? 'Tak' : 'Nie'])
    )
  );
  dodajArkuszTabeli(wb, 'Kroki', NAGLOWKI_KROKOW, wierszeKrokow);

  const bufor = await wb.xlsx.writeBuffer();
  return bajtyDoBase64(new Uint8Array(bufor as ArrayBuffer));
}

// =============================================================================
//  IMPORT — WCZYTANIE I WALIDACJA
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
  skladniki: SkladnikDoImportu[];
  etapy: EtapDoImportu[];
};

export type WynikWczytania = {
  /** Tylko przepisy, które przeszły walidację w całości — reszta trafiła do `bledy`. */
  przepisy: PrzepisDoImportu[];
  bledy: BladImportu[];
};

/**
 * Składnik w trakcie wczytywania — z dodatkową kolejnością do sortowania.
 * Osobny typ od `SkladnikDoImportu`, żeby to pole robocze nie wyciekło
 * na zewnątrz tego pliku.
 */
type SkladnikRoboczy = SkladnikDoImportu & { kolejnosc: number };
type PrzepisRoboczy = Omit<PrzepisDoImportu, 'skladniki'> & { skladniki: SkladnikRoboczy[] };

/**
 * Wczytuje plik .xlsx (base64) i zwraca gotowe do zapisania przepisy.
 *
 * `dostepneSkladniki` to aktualna baza składników — po niej rozpoznajemy
 * nazwy z arkusza. Import nigdy nie tworzy nowego składnika: brakowałoby mu
 * wartości odżywczych, a zgadywanie ich zepsułoby makro każdego dania,
 * w którym by wystąpił.
 */
export async function wczytajPlikPrzepisow(
  base64: string,
  dostepneSkladniki: Skladnik[]
): Promise<WynikWczytania> {
  const wb = await wczytajSkoroszyt(base64);

  const arkuszPrzepisow = wb.getWorksheet('Przepisy');
  if (!arkuszPrzepisow) {
    return { przepisy: [], bledy: [{ przepis: null, tresc: 'W pliku brakuje arkusza „Przepisy”.' }] };
  }

  const skladnikiWedlugNazwy = new Map(dostepneSkladniki.map((s) => [kluczNazwy(s.nazwa), s]));

  const bledy: BladImportu[] = [];
  const robocze = new Map<string, PrzepisRoboczy>();

  // --- 1. Nagłówek przepisu -----------------------------------------------
  const naglPrzepisow = mapaNaglowkow(arkuszPrzepisow);
  arkuszPrzepisow.eachRow({ includeEmpty: false }, (wiersz, numer) => {
    if (numer === 1) return;

    const nazwa = tekstKomorki(komorka(wiersz, naglPrzepisow, 'Nazwa')).trim();
    if (!nazwa) return; // pusty wiersz — pomijamy po cichu, to nie błąd

    if (nazwa.length < 3) {
      bledy.push({ przepis: nazwa, tresc: `Arkusz Przepisy, wiersz ${numer}: nazwa za krótka.` });
      return;
    }

    const klucz = kluczNazwy(nazwa);
    if (robocze.has(klucz)) {
      bledy.push({
        przepis: nazwa,
        tresc: `Arkusz Przepisy, wiersz ${numer}: nazwa „${nazwa}” powtarza się w pliku — druga pozycja pominięta.`,
      });
      return;
    }

    const etykietyKategorii = podzielListe(tekstKomorki(komorka(wiersz, naglPrzepisow, 'Kategoria')));
    const pory: PoraPosilku[] = [];
    for (const e of etykietyKategorii) {
      const k = PORA_WEDLUG_ETYKIETY.get(e.toLowerCase());
      if (!k) {
        bledy.push({ przepis: nazwa, tresc: `Wiersz ${numer}: nieznana kategoria „${e}”.` });
        return;
      }
      pory.push(k);
    }

    const etykietyKuchni = podzielListe(tekstKomorki(komorka(wiersz, naglPrzepisow, 'Kuchnia')));
    const kuchnie: Kuchnia[] = [];
    for (const e of etykietyKuchni) {
      const k = KUCHNIA_WEDLUG_ETYKIETY.get(e.toLowerCase());
      if (!k) {
        bledy.push({ przepis: nazwa, tresc: `Wiersz ${numer}: nieznana kuchnia „${e}”.` });
        return;
      }
      kuchnie.push(k);
    }

    const trwalosc = liczbaKomorki(komorka(wiersz, naglPrzepisow, 'Trwałość (dni)'));
    if (trwalosc === null || !Number.isInteger(trwalosc) || trwalosc < 0 || trwalosc > 3) {
      bledy.push({
        przepis: nazwa,
        tresc: `Wiersz ${numer}: „Trwałość (dni)” musi być liczbą całkowitą od 0 do 3.`,
      });
      return;
    }

    const etykietaPorcjowania = tekstKomorki(komorka(wiersz, naglPrzepisow, 'Porcjowanie')).trim().toLowerCase();
    const porcjowanie = PORCJOWANIE_WEDLUG_ETYKIETY.get(etykietaPorcjowania);
    if (!porcjowanie) {
      bledy.push({
        przepis: nazwa,
        tresc: `Wiersz ${numer}: „Porcjowanie” musi być „Na wagę” albo „Na sztuki”.`,
      });
      return;
    }

    let porcje = 1;
    let porcjaG: number | null = null;

    if (porcjowanie === 'sztuki') {
      const wartosc = liczbaKomorki(komorka(wiersz, naglPrzepisow, 'Porcje'));
      if (wartosc === null || !Number.isInteger(wartosc) || wartosc < 1 || wartosc > 30) {
        bledy.push({
          przepis: nazwa,
          tresc: `Wiersz ${numer}: „Porcje” musi być liczbą całkowitą od 1 do 30 przy porcjowaniu na sztuki.`,
        });
        return;
      }
      porcje = wartosc;
    } else {
      const wartosc = liczbaKomorki(komorka(wiersz, naglPrzepisow, 'Porcja (g)'));
      if (wartosc === null || wartosc < 20 || wartosc > 2000) {
        bledy.push({
          przepis: nazwa,
          tresc: `Wiersz ${numer}: „Porcja (g)” musi być liczbą od 20 do 2000 przy porcjowaniu na wagę.`,
        });
        return;
      }
      porcjaG = Math.round(wartosc);
    }

    const czasPrzygotowania = liczbaKomorki(komorka(wiersz, naglPrzepisow, 'Czas przygotowania (min)'));
    const czasObrobki = liczbaKomorki(komorka(wiersz, naglPrzepisow, 'Czas obróbki (min)'));

    const mrozicTekst = tekstKomorki(komorka(wiersz, naglPrzepisow, 'Można mrozić')).trim().toLowerCase();
    const moznaMrozic = mrozicTekst === 'tak' ? true : mrozicTekst === 'nie' ? false : null;

    robocze.set(klucz, {
      nazwa,
      opis: tekstKomorki(komorka(wiersz, naglPrzepisow, 'Opis')).trim() || null,
      pory,
      kuchnie,
      trwalosc_dni: trwalosc,
      porcjowanie,
      porcje,
      porcja_g: porcjaG,
      czas_przygotowania_min: czasPrzygotowania,
      czas_obrobki_min: czasObrobki,
      sprzet: podzielListe(tekstKomorki(komorka(wiersz, naglPrzepisow, 'Sprzęt'))),
      przechowywanie: tekstKomorki(komorka(wiersz, naglPrzepisow, 'Przechowywanie')).trim() || null,
      mozna_mrozic: moznaMrozic,
      ratunek: tekstKomorki(komorka(wiersz, naglPrzepisow, 'Ratunek')).trim() || null,
      skladniki: [],
      etapy: [],
    });
  });

  // Przepisy odrzucone w nagłówku nie mogą przyjmować składników ani etapów —
  // stąd osobny zbiór kluczy, które dalsze arkusze wolno im dopisywać.
  const odrzucone = new Set(bledy.map((b) => b.przepis).filter((x): x is string => x !== null).map(kluczNazwy));

  // --- 2. Składniki ---------------------------------------------------------
  const arkuszSkladnikow = wb.getWorksheet('Składniki');
  if (arkuszSkladnikow) {
    const nagl = mapaNaglowkow(arkuszSkladnikow);
    const licznikWKolejnosci = new Map<string, number>();

    arkuszSkladnikow.eachRow({ includeEmpty: false }, (wiersz, numer) => {
      if (numer === 1) return;
      const nazwaPrzepisu = tekstKomorki(komorka(wiersz, nagl, 'Przepis')).trim();
      if (!nazwaPrzepisu) return;

      const klucz = kluczNazwy(nazwaPrzepisu);
      if (odrzucone.has(klucz)) return;
      const przepis = robocze.get(klucz);
      if (!przepis) {
        bledy.push({
          przepis: nazwaPrzepisu,
          tresc: `Arkusz Składniki, wiersz ${numer}: przepis „${nazwaPrzepisu}” nie występuje w arkuszu Przepisy.`,
        });
        odrzucone.add(klucz);
        return;
      }

      const nazwaSkladnika = tekstKomorki(komorka(wiersz, nagl, 'Składnik')).trim();
      const skladnik = skladnikiWedlugNazwy.get(kluczNazwy(nazwaSkladnika));
      if (!skladnik) {
        bledy.push({
          przepis: nazwaPrzepisu,
          tresc: `Wiersz ${numer}: nieznany składnik „${nazwaSkladnika}”. Dodaj go najpierw w zakładce Składniki.`,
        });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }

      const jednostkaTekst = tekstKomorki(komorka(wiersz, nagl, 'Jednostka')).trim().toLowerCase();
      if (jednostkaTekst !== 'g' && jednostkaTekst !== 'ml' && jednostkaTekst !== 'szt') {
        bledy.push({
          przepis: nazwaPrzepisu,
          tresc: `Wiersz ${numer}: jednostka musi być „g”, „ml” albo „szt”.`,
        });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }
      if (jednostkaTekst === 'szt' && !skladnik.masa_sztuki_g) {
        bledy.push({
          przepis: nazwaPrzepisu,
          tresc: `Wiersz ${numer}: „${skladnik.nazwa}” nie ma ustalonej masy sztuki — jednostka „szt” niedostępna.`,
        });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }

      const ilosc = liczbaKomorki(komorka(wiersz, nagl, 'Ilość'));
      if (ilosc === null || ilosc <= 0) {
        bledy.push({ przepis: nazwaPrzepisu, tresc: `Wiersz ${numer}: „Ilość” musi być liczbą większą od zera.` });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }

      const jednostka = jednostkaTekst as 'g' | 'ml' | 'szt';
      const gramy = jednostka === 'szt' ? ilosc * (skladnik.masa_sztuki_g ?? 0) : ilosc;

      const podanaKolejnosc = liczbaKomorki(komorka(wiersz, nagl, 'Kolejność'));
      const kolejnosc =
        podanaKolejnosc !== null
          ? podanaKolejnosc
          : (licznikWKolejnosci.get(klucz) ?? 0) + 1;
      licznikWKolejnosci.set(klucz, kolejnosc);

      przepis.skladniki.push({
        skladnik_id: skladnik.id,
        nazwa: skladnik.nazwa,
        ilosc,
        jednostka,
        gramy,
        stan: tekstKomorki(komorka(wiersz, nagl, 'Stan')).trim() || null,
        zamiennik: tekstKomorki(komorka(wiersz, nagl, 'Zamiennik')).trim() || null,
        opis_potoczny: tekstKomorki(komorka(wiersz, nagl, 'Opis potoczny')).trim() || null,
        kolejnosc,
      });
    });
  }

  // Przepisy bez ani jednego składnika nie da się zaimportować — nie ma z czego
  // policzyć makro, a przepis bez makra jest bezużyteczny w planie dnia.
  for (const [klucz, przepis] of robocze) {
    if (odrzucone.has(klucz)) continue;
    if (przepis.skladniki.length === 0) {
      bledy.push({ przepis: przepis.nazwa, tresc: 'Brak składników w arkuszu Składniki.' });
      odrzucone.add(klucz);
    }
  }

  for (const przepis of robocze.values()) {
    przepis.skladniki.sort((a, b) => a.kolejnosc - b.kolejnosc);
  }

  // --- 3. Etapy ---------------------------------------------------------
  type EtapRoboczy = EtapDoImportu & { kolejnosc: number };
  const etapyWedlugPrzepisu = new Map<string, Map<number, EtapRoboczy>>();

  const arkuszEtapow = wb.getWorksheet('Etapy');
  if (arkuszEtapow) {
    const nagl = mapaNaglowkow(arkuszEtapow);
    const licznik = new Map<string, number>();

    arkuszEtapow.eachRow({ includeEmpty: false }, (wiersz, numer) => {
      if (numer === 1) return;
      const nazwaPrzepisu = tekstKomorki(komorka(wiersz, nagl, 'Przepis')).trim();
      if (!nazwaPrzepisu) return;
      const klucz = kluczNazwy(nazwaPrzepisu);
      if (odrzucone.has(klucz) || !robocze.has(klucz)) return;

      const nazwaEtapu = tekstKomorki(komorka(wiersz, nagl, 'Nazwa etapu')).trim();
      if (nazwaEtapu.length < 2) {
        bledy.push({ przepis: nazwaPrzepisu, tresc: `Arkusz Etapy, wiersz ${numer}: nazwa etapu za krótka.` });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }

      const podanaKolejnosc = liczbaKomorki(komorka(wiersz, nagl, 'Kolejność etapu'));
      const kolejnosc = podanaKolejnosc !== null ? podanaKolejnosc : (licznik.get(klucz) ?? 0) + 1;
      licznik.set(klucz, kolejnosc);

      const minuty = liczbaKomorki(komorka(wiersz, nagl, 'Minuty'));

      const mapaEtapow = etapyWedlugPrzepisu.get(klucz) ?? new Map<number, EtapRoboczy>();
      mapaEtapow.set(kolejnosc, { nazwa: nazwaEtapu, minuty, kroki: [], kolejnosc });
      etapyWedlugPrzepisu.set(klucz, mapaEtapow);
    });
  }

  // --- 4. Kroki ---------------------------------------------------------
  const arkuszKrokow = wb.getWorksheet('Kroki');
  if (arkuszKrokow) {
    const nagl = mapaNaglowkow(arkuszKrokow);

    arkuszKrokow.eachRow({ includeEmpty: false }, (wiersz, numer) => {
      if (numer === 1) return;
      const nazwaPrzepisu = tekstKomorki(komorka(wiersz, nagl, 'Przepis')).trim();
      if (!nazwaPrzepisu) return;
      const klucz = kluczNazwy(nazwaPrzepisu);
      if (odrzucone.has(klucz) || !robocze.has(klucz)) return;

      const kolejnoscEtapu = liczbaKomorki(komorka(wiersz, nagl, 'Kolejność etapu'));
      const mapaEtapow = etapyWedlugPrzepisu.get(klucz);
      const etap = kolejnoscEtapu !== null ? mapaEtapow?.get(kolejnoscEtapu) : undefined;
      if (!etap) {
        bledy.push({
          przepis: nazwaPrzepisu,
          tresc: `Arkusz Kroki, wiersz ${numer}: brak etapu o kolejności ${kolejnoscEtapu ?? '(pusto)'} w arkuszu Etapy.`,
        });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }

      const tresc = tekstKomorki(komorka(wiersz, nagl, 'Treść')).trim();
      if (!tresc) {
        bledy.push({ przepis: nazwaPrzepisu, tresc: `Wiersz ${numer}: treść kroku jest pusta.` });
        robocze.delete(klucz);
        odrzucone.add(klucz);
        return;
      }

      const uwagaTekst = tekstKomorki(komorka(wiersz, nagl, 'Uwaga')).trim().toLowerCase();
      etap.kroki.push({
        tresc,
        sygnal: tekstKomorki(komorka(wiersz, nagl, 'Sygnał')).trim() || null,
        uwaga: uwagaTekst === 'tak' || uwagaTekst === 'true' || uwagaTekst === '1',
      });
    });
  }

  // Etapy dopinamy do przepisów, posortowane po kolejności.
  for (const [klucz, przepis] of robocze) {
    const mapaEtapow = etapyWedlugPrzepisu.get(klucz);
    if (!mapaEtapow) continue;
    przepis.etapy = Array.from(mapaEtapow.values())
      .sort((a, b) => a.kolejnosc - b.kolejnosc)
      .map((e) => ({ nazwa: e.nazwa, minuty: e.minuty, kroki: e.kroki }));
  }

  const gotowe = Array.from(robocze.entries())
    .filter(([klucz]) => !odrzucone.has(klucz))
    .map(([, p]) => p)
    // Pole robocze `kolejnosc` przy składnikach posłużyło tylko do sortowania —
    // do typu `SkladnikDoImportu` go nie przepuszczamy.
    .map((p) => ({
      ...p,
      skladniki: p.skladniki.map(({ skladnik_id, nazwa, ilosc, jednostka, gramy, stan, zamiennik, opis_potoczny }) => ({
        skladnik_id,
        nazwa,
        ilosc,
        jednostka,
        gramy,
        stan,
        zamiennik,
        opis_potoczny,
      })),
    }));

  return { przepisy: gotowe, bledy };
}

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
  const idWedlugNazwy = new Map(istniejace.map((p) => [kluczNazwy(p.nazwa), p.id]));
  return wczytane.map((dane) => ({
    dane,
    istniejacyId: idWedlugNazwy.get(kluczNazwy(dane.nazwa)) ?? null,
  }));
}

// =============================================================================
//  ZAPIS DO BAZY
// =============================================================================

/**
 * Zakłada w katalogu sprzętu brakujące pozycje z importowanych przepisów.
 *
 * Bez tego pierwszy import dania z nowym narzędziem wywaliłby się na
 * ograniczeniu klucza obcego — a Talerz i tak zakłada brakujący sprzęt sam,
 * dokładnie tak samo jak przycisk „Dopisz sprzęt” w formularzu przepisu.
 */
async function zapewnijSprzet(wszystkieNazwy: string[]): Promise<void> {
  const unikalne = Array.from(new Set(wszystkieNazwy.map((n) => n.trim()).filter(Boolean)));
  if (unikalne.length === 0) return;

  const { data, error } = await supabase.from('sprzet').select('nazwa');
  if (error) throw error;

  const istniejace = new Set((data ?? []).map((s) => kluczNazwy(s.nazwa as string)));
  const brakujace = unikalne.filter((n) => !istniejace.has(kluczNazwy(n)));
  if (brakujace.length === 0) return;

  const { error: bladWstawienia } = await supabase
    .from('sprzet')
    .insert(brakujace.map((nazwa) => ({ nazwa })));
  if (bladWstawienia) throw bladWstawienia;
}

/**
 * Zapisuje jeden przepis: nowy albo korektę istniejącego (rozpoznanego po nazwie).
 *
 * Przy korekcie zachowuje się tak samo, jak edycja z formularza — nagłówek
 * się aktualizuje, a treść (składniki, etapy, kroki) wstawia od nowa. Nie
 * rusza zdjęcia ani stanu publikacji, bo arkusz o nich nic nie wie.
 */
export async function zaimportujPrzepis(
  pozycja: PozycjaImportu,
  autorId: string
): Promise<void> {
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
  };

  let przepisId: string;

  if (istniejacyId) {
    const { error } = await supabase.from('przepisy').update(naglowek).eq('id', istniejacyId);
    if (error) throw error;
    await wyczyscTrescPrzepisu(istniejacyId);
    przepisId = istniejacyId;
  } else {
    const { data, error } = await supabase
      .from('przepisy')
      .insert({ ...naglowek, autor_id: autorId, widocznosc: 'prywatna' })
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
}

/** Zapisuje całą partię — najpierw zakłada brakujący sprzęt, potem przepis po przepisie. */
export async function zaimportujPrzepisy(
  pozycje: PozycjaImportu[],
  autorId: string,
  poKazdym?: (zrobione: number, razem: number) => void
): Promise<{ bledy: BladImportu[] }> {
  await zapewnijSprzet(pozycje.flatMap((p) => p.dane.sprzet));

  const bledy: BladImportu[] = [];
  for (let i = 0; i < pozycje.length; i++) {
    try {
      await zaimportujPrzepis(pozycje[i], autorId);
    } catch (e) {
      bledy.push({
        przepis: pozycje[i].dane.nazwa,
        tresc: e instanceof Error ? e.message : String(e),
      });
    }
    poKazdym?.(i + 1, pozycje.length);
  }
  return { bledy };
}
