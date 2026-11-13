/**
 * Przepis jako JSON — jeden format dla aplikacji, skryptów i AI.
 *
 * Ten sam kształt pliku czytają: ekran „Import / eksport” w aplikacji,
 * `narzedzia/generuj-import-ai.mjs` (SQL do panelu Supabase) i czat z AI,
 * któremu wkleja się prompt z `zbudujPromptPrzepisu`.
 *
 * PLIK BEZ ZALEŻNOŚCI — importuje wyłącznie typy. Dzięki temu Node wczytuje
 * go wprost ze skryptów w `narzedzia/` (typy sam wycina), bez Metro i bez
 * klienta Supabase. Nie dopisuj tu importów wartości z innych plików `lib/`.
 *
 * KATALOGI SĄ ZAMKNIĘTE. Import nie dopisuje ani składnika, ani sprzętu —
 * nieznana nazwa odrzuca przepis i podpowiada podobne pozycje z katalogu.
 * Składnik bez wartości odżywczych zepsułby makro, a „Nóż” obok „Noża szefa
 * kuchni” zepsułby katalog.
 */

import type { BladImportu, PrzepisDoImportu, WynikWczytania } from './import-przepisow';
import type { Kuchnia, PelnyPrzepis, PoraPosilku, RodzajDania } from './przepisy';
import type { RolaSkladnika } from './skladniki';

export const PORY = ['sniadanie', 'obiad', 'kolacja', 'dodatek'];
export const KUCHNIE = ['srodziemnomorska', 'azjatycka', 'polska', 'inna'];
export const RODZAJE = [
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
export const JEDNOSTKI = ['g', 'ml', 'szt'];

// =============================================================================
//  KSZTAŁT PLIKU
// =============================================================================

export type SkladnikJson = {
  nazwa: string;
  ilosc: number;
  jednostka: 'g' | 'ml' | 'szt';
  stan?: string;
  zamiennik?: string;
  opis_potoczny?: string;
  /** Tylko gdy przepis nadpisuje wartość z katalogu składników (migracja 0035). */
  rola?: string;
  mozna_dzielic?: boolean;
};

export type PrzepisJson = {
  nazwa: string;
  opis?: string;
  pory: string[];
  kuchnie: string[];
  rodzaje?: string[];
  porcjowanie: 'waga' | 'sztuki';
  porcja_g?: number;
  porcje?: number;
  liczba_porcji_bazowych?: number;
  trwalosc_dni: number;
  czas_przygotowania_min?: number | null;
  czas_obrobki_min?: number | null;
  sprzet: string[];
  przechowywanie?: string;
  mozna_mrozic?: boolean | null;
  ratunek?: string;
  skladniki: SkladnikJson[];
  etapy: {
    nazwa: string;
    minuty?: number | null;
    kroki: { tresc: string; sygnal?: string; uwaga?: boolean }[];
  }[];
};

// =============================================================================
//  SPRAWDZENIE KSZTAŁTU
// =============================================================================

const calkowita = (x: unknown, od: number, do_: number) =>
  typeof x === 'number' && Number.isInteger(x) && x >= od && x <= do_;
const napis = (x: unknown): x is string => typeof x === 'string' && x.trim().length > 0;
const brak = (x: unknown) => x === undefined || x === null;

/**
 * Sprawdza kształt jednego przepisu: wymagane pola, dozwolone wartości, zakresy.
 * Zwraca listę błędów — pusta znaczy, że plik jest w porządku.
 *
 * Nie zagląda do katalogów: czy składnik i sprzęt istnieją, sprawdza dopiero
 * `wczytajJsonPrzepisow` (w aplikacji) albo skrypt SQL (w narzędziach).
 *
 * UWAGA: zaokrągla `porcja_g` w podanym obiekcie.
 */
// eslint-disable-next-line @typescript-eslint/no-explicit-any
export function sprawdzPrzepis(p: any): string[] {
  const b: string[] = [];

  if (p === null || typeof p !== 'object' || Array.isArray(p)) return ['przepis ma być obiektem { … }'];

  if (!napis(p.nazwa) || p.nazwa.trim().length < 3 || p.nazwa.length > 120)
    b.push('nazwa: od 3 do 120 znaków');

  for (const [pole, dozwolone] of [
    ['pory', PORY],
    ['kuchnie', KUCHNIE],
  ] as const) {
    if (!Array.isArray(p[pole])) b.push(`${pole}: ma być listą`);
    else
      p[pole]
        .filter((x: unknown) => !dozwolone.includes(x as string))
        .forEach((x: unknown) => b.push(`${pole}: „${x}” — dozwolone ${dozwolone.join(', ')}`));
  }

  // Nieobowiązkowe: bez pola import nie rusza rodzajów w bazie (migracja 0046).
  if (p.rodzaje !== undefined) {
    if (!Array.isArray(p.rodzaje)) b.push('rodzaje: ma być listą');
    else {
      p.rodzaje
        .filter((x: unknown) => !RODZAJE.includes(x as string))
        .forEach((x: unknown) => b.push(`rodzaje: „${x}” — dozwolone ${RODZAJE.join(', ')}`));
      if (p.rodzaje.length > 2) b.push('rodzaje: najwyżej dwa');
    }
  }

  // AI liczy porcja_g jako sumę mas, razem z pół grama pieprzu — wychodzi
  // 196,5 g. Kolumna jest całkowita, a pół grama porcji nie zmienia, więc
  // zaokrąglamy zamiast odrzucać plik.
  if (typeof p.porcja_g === 'number') p.porcja_g = Math.round(p.porcja_g);

  // Ograniczenie porcjowanie_spojne z migracji 0007.
  if (p.porcjowanie === 'waga') {
    if (!calkowita(p.porcja_g, 20, 2000)) b.push('porcja_g: liczba całkowita od 20 do 2000');
    if (p.porcje !== undefined) b.push('porcje: przy porcjowaniu „waga” nie podawaj — liczy się z masy');
  } else if (p.porcjowanie === 'sztuki') {
    if (!calkowita(p.porcje, 1, 30)) b.push('porcje: liczba całkowita od 1 do 30');
    if (p.porcja_g !== undefined) b.push('porcja_g: przy porcjowaniu „sztuki” nie podawaj');
  } else {
    b.push('porcjowanie: „waga” albo „sztuki”');
  }

  // Nieobowiązkowe: bez pola import nie nadpisuje liczby ustawionej już w bazie.
  if (p.liczba_porcji_bazowych !== undefined && !calkowita(p.liczba_porcji_bazowych, 1, 30)) {
    b.push('liczba_porcji_bazowych: liczba całkowita od 1 do 30');
  }

  if (!calkowita(p.trwalosc_dni, 0, 3)) b.push('trwalosc_dni: od 0 do 3');

  // Czasy i mrożenie bywają w bazie puste („nie wiadomo”) — przepis wyjęty
  // eksportem musi dać się wczytać z powrotem, więc brak pola jest dozwolony.
  if (!brak(p.czas_przygotowania_min) && !calkowita(p.czas_przygotowania_min, 1, 1440))
    b.push('czas_przygotowania_min: od 1 do 1440');
  if (!brak(p.czas_obrobki_min) && !calkowita(p.czas_obrobki_min, 0, 1440))
    b.push('czas_obrobki_min: od 0 do 1440');
  if (!brak(p.mozna_mrozic) && typeof p.mozna_mrozic !== 'boolean') b.push('mozna_mrozic: true albo false');

  if (!Array.isArray(p.sprzet) || !p.sprzet.every(napis)) b.push('sprzet: lista nazw z katalogu');

  if (!Array.isArray(p.skladniki) || p.skladniki.length === 0) {
    b.push('skladniki: co najmniej jeden');
  } else {
    const widziane = new Set<string>();
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    p.skladniki.forEach((s: any, i: number) => {
      const gdzie = `skladniki[${i + 1}] „${s?.nazwa ?? '?'}”`;
      if (s === null || typeof s !== 'object') {
        b.push(`${gdzie}: ma być obiektem`);
        return;
      }
      if (!napis(s.nazwa)) b.push(`${gdzie}: brak nazwy`);
      if (!(typeof s.ilosc === 'number' && s.ilosc > 0)) b.push(`${gdzie}: ilosc większa od zera`);
      if (!JEDNOSTKI.includes(s.jednostka)) b.push(`${gdzie}: jednostka ${JEDNOSTKI.join(', ')}`);
      if (s.mozna_dzielic !== undefined && typeof s.mozna_dzielic !== 'boolean')
        b.push(`${gdzie}: mozna_dzielic true albo false`);
      // Baza trzyma jeden wiersz na składnik w przepisie (unique przepis_id, skladnik_id).
      if (widziane.has(s.nazwa)) b.push(`${gdzie}: występuje dwa razy — połącz ilości`);
      widziane.add(s.nazwa);
    });
  }

  if (!Array.isArray(p.etapy) || p.etapy.length === 0) {
    b.push('etapy: co najmniej jeden');
  } else {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    p.etapy.forEach((e: any, i: number) => {
      const gdzie = `etapy[${i + 1}] „${e?.nazwa ?? '?'}”`;
      if (e === null || typeof e !== 'object') {
        b.push(`${gdzie}: ma być obiektem`);
        return;
      }
      if (!napis(e.nazwa) || e.nazwa.trim().length < 2 || e.nazwa.length > 120)
        b.push(`${gdzie}: nazwa od 2 do 120 znaków`);
      if (!brak(e.minuty) && !calkowita(e.minuty, 1, 1440)) b.push(`${gdzie}: minuty od 1 do 1440`);
      if (!Array.isArray(e.kroki) || e.kroki.length === 0) b.push(`${gdzie}: co najmniej jeden krok`);
      else
        e.kroki.forEach((k: { tresc?: unknown } | null, j: number) => {
          if (!napis(k?.tresc)) b.push(`${gdzie}, krok ${j + 1}: pusta treść`);
        });
    });
  }

  return b;
}

// =============================================================================
//  EKSPORT: PRZEPIS Z BAZY -> JSON
// =============================================================================

/** Pomija puste pola nieobowiązkowe, żeby JSON był czytelny. */
function jesli<T>(pole: string, wartosc: T | null | undefined | ''): Record<string, T> {
  return wartosc === null || wartosc === undefined || wartosc === '' ? {} : { [pole]: wartosc as T };
}

type SkladnikKatalogu = {
  id: string;
  nazwa: string;
  masa_sztuki_g: number | null;
  rola: RolaSkladnika;
  mozna_dzielic: boolean | null;
};

/**
 * Zamienia pełny przepis z bazy na obiekt do zapisania jako JSON.
 *
 * Z `katalog` rola i podzielność trafiają do pliku tylko tam, gdzie przepis
 * NADPISUJE wartość składnika — plik zostaje krótki, a nadpisania nie giną.
 * Zdjęcie i stan publikacji do pliku nie trafiają.
 */
export function przepisDoJson(p: PelnyPrzepis, katalog: SkladnikKatalogu[] = []): PrzepisJson {
  const waga = p.porcjowanie === 'waga';
  const wKatalogu = new Map(katalog.map((s) => [s.id, s]));

  return {
    nazwa: p.nazwa,
    ...jesli('opis', p.opis),
    pory: p.pory ?? [],
    kuchnie: p.kuchnie ?? [],
    ...(p.rodzaje && p.rodzaje.length > 0 ? { rodzaje: p.rodzaje } : {}),
    porcjowanie: p.porcjowanie,
    ...(waga ? { porcja_g: p.porcja_g ?? undefined } : { porcje: p.porcje }),
    // Zero znaczy w bazie „nie ustawiono” — import i tak by go nie przyjął.
    ...(p.liczba_porcji_bazowych > 0 ? { liczba_porcji_bazowych: p.liczba_porcji_bazowych } : {}),
    trwalosc_dni: p.trwalosc_dni,
    ...jesli('czas_przygotowania_min', p.czas_przygotowania_min),
    ...jesli('czas_obrobki_min', p.czas_obrobki_min),
    sprzet: p.sprzet ?? [],
    ...jesli('przechowywanie', p.przechowywanie),
    ...jesli('mozna_mrozic', p.mozna_mrozic),
    ...jesli('ratunek', p.ratunek),
    skladniki: p.skladniki.map((s) => {
      const bazowy = wKatalogu.get(s.skladnik_id);
      return {
        nazwa: s.nazwa,
        ilosc: Number(s.ilosc),
        jednostka: s.jednostka,
        ...jesli('stan', s.stan),
        ...jesli('zamiennik', s.zamiennik),
        ...jesli('opis_potoczny', s.opis_potoczny),
        ...(bazowy && s.rola !== null && s.rola !== bazowy.rola ? { rola: s.rola } : {}),
        ...(bazowy && s.mozna_dzielic !== null && s.mozna_dzielic !== bazowy.mozna_dzielic
          ? { mozna_dzielic: s.mozna_dzielic }
          : {}),
      };
    }),
    etapy: p.etapy.map((e) => ({
      nazwa: e.nazwa,
      ...jesli('minuty', e.minuty),
      kroki: e.kroki.map((k) => ({
        tresc: k.tresc,
        ...jesli('sygnal', k.sygnal),
        ...(k.uwaga ? { uwaga: true } : {}),
      })),
    })),
  } as PrzepisJson;
}

/** Tekst pliku: jeden przepis to obiekt, kilka — lista obiektów. */
export function tekstJson(przepisy: PrzepisJson[]): string {
  return JSON.stringify(przepisy.length === 1 ? przepisy[0] : przepisy, null, 2) + '\n';
}

// =============================================================================
//  IMPORT: JSON -> PRZEPISY GOTOWE DO ZAPISU
// =============================================================================

/** Nazwa do porównań: bez wielkości liter i nadmiarowych odstępów. */
function klucz(nazwa: string): string {
  return nazwa.trim().replace(/\s+/g, ' ').toLowerCase();
}

/**
 * Pozycje katalogu, które mają wspólny początek słowa z szukaną nazwą —
 * ta sama reguła co w sprawdzeniu katalogów w `generuj-import-ai.mjs`.
 * Zwykle wystarczy poprawić nazwę w JSON-ie, zamiast dodawać nową pozycję.
 */
function podobne(nazwa: string, katalog: string[]): string[] {
  const slowa = nazwa
    .toLowerCase()
    .split(/[^\p{L}]+/u)
    .filter((w) => w.length >= 3);
  if (slowa.length === 0) return [];
  return katalog
    .filter((k) => {
      const slowaKatalogu = k.toLowerCase().split(/[^\p{L}]+/u);
      return slowa.some((w) => slowaKatalogu.some((sk) => sk.startsWith(w)));
    })
    .sort((a, b) => a.localeCompare(b, 'pl'))
    .slice(0, 6);
}

/**
 * Wyjmuje JSON z tekstu wklejonego z czatu: AI lubi owinąć go w ```json
 * i dopisać pod spodem sekcję „BRAKUJE W KATALOGU”. Bierzemy od pierwszego
 * nawiasu do pasującego zamknięcia, z pominięciem nawiasów w napisach.
 */
export function wyjmijJson(tekst: string): string | null {
  const start = tekst.search(/[[{]/);
  if (start < 0) return null;

  let glebokosc = 0;
  let wNapisie = false;
  for (let i = start; i < tekst.length; i++) {
    const z = tekst[i];
    if (wNapisie) {
      if (z === '\\') i++;
      else if (z === '"') wNapisie = false;
    } else if (z === '"') wNapisie = true;
    else if (z === '{' || z === '[') glebokosc++;
    else if (z === '}' || z === ']') {
      glebokosc--;
      if (glebokosc === 0) return tekst.slice(start, i + 1);
    }
  }
  return null;
}

export type KatalogiImportu = {
  skladniki: SkladnikKatalogu[];
  /** Nazwy z katalogu sprzętu, w pisowni z bazy. */
  sprzet: string[];
  /** Dozwolone role składnika — do sprawdzenia nadpisań w pliku. */
  role: readonly string[];
};

/**
 * Wczytuje tekst JSON (jeden przepis albo lista) i zwraca przepisy gotowe
 * do zapisania przez `zaimportujPrzepisy`.
 *
 * Atomowo NA PRZEPIS: błąd odrzuca tylko to danie, reszta pliku przechodzi.
 */
export function wczytajJsonPrzepisow(tekst: string, katalogi: KatalogiImportu): WynikWczytania {
  const wyjety = wyjmijJson(tekst);
  if (wyjety === null) {
    return { przepisy: [], bledy: [{ przepis: null, tresc: 'To nie jest JSON — brak nawiasu { albo [.' }] };
  }

  let dane: unknown;
  try {
    dane = JSON.parse(wyjety);
  } catch (e) {
    return {
      przepisy: [],
      bledy: [{ przepis: null, tresc: `Nie da się odczytać JSON-a: ${e instanceof Error ? e.message : String(e)}` }],
    };
  }

  const lista = Array.isArray(dane) ? dane : [dane];
  const skladnikiWedlugNazwy = new Map(katalogi.skladniki.map((s) => [klucz(s.nazwa), s]));
  const sprzetWedlugNazwy = new Map(katalogi.sprzet.map((n) => [klucz(n), n]));
  const nazwySkladnikow = katalogi.skladniki.map((s) => s.nazwa);

  const przepisy: PrzepisDoImportu[] = [];
  const bledy: BladImportu[] = [];
  const widzianeNazwy = new Set<string>();

  lista.forEach((surowy, indeks) => {
    const p = surowy as PrzepisJson;
    const nazwa = napis(p?.nazwa) ? p.nazwa.trim() : null;
    const podpis = nazwa ?? `pozycja ${indeks + 1}`;
    const problemy = sprawdzPrzepis(p);

    if (nazwa) {
      if (widzianeNazwy.has(klucz(nazwa))) problemy.push('nazwa powtarza się w pliku — druga pozycja pominięta');
      widzianeNazwy.add(klucz(nazwa));
    }

    // Kształt musi być poprawny, zanim zajrzymy do środka — inaczej poniższe
    // pętle potknęłyby się o brakujące listy.
    if (problemy.length > 0) {
      problemy.forEach((tresc) => bledy.push({ przepis: podpis, tresc }));
      return;
    }

    const skladniki: PrzepisDoImportu['skladniki'] = [];
    for (const s of p.skladniki) {
      const zKatalogu = skladnikiWedlugNazwy.get(klucz(s.nazwa));
      if (!zKatalogu) {
        const propozycje = podobne(s.nazwa, nazwySkladnikow);
        problemy.push(
          `brak składnika „${s.nazwa}” w katalogu` +
            (propozycje.length > 0 ? ` — podobne: ${propozycje.join(', ')}` : '')
        );
        continue;
      }
      if (s.jednostka === 'szt' && !zKatalogu.masa_sztuki_g) {
        problemy.push(`„${zKatalogu.nazwa}” nie ma masy sztuki — podaj ilość w g albo ml`);
        continue;
      }
      if (s.rola !== undefined && !katalogi.role.includes(s.rola)) {
        problemy.push(`„${zKatalogu.nazwa}”: rola „${s.rola}” — dozwolone ${katalogi.role.join(', ')}`);
        continue;
      }

      skladniki.push({
        skladnik_id: zKatalogu.id,
        nazwa: zKatalogu.nazwa,
        ilosc: s.ilosc,
        jednostka: s.jednostka,
        gramy:
          s.jednostka === 'szt'
            ? Math.round(s.ilosc * (zKatalogu.masa_sztuki_g ?? 0) * 10) / 10
            : s.ilosc,
        stan: s.stan?.trim() || null,
        zamiennik: s.zamiennik?.trim() || null,
        opis_potoczny: s.opis_potoczny?.trim() || null,
        // Bez nadpisania w pliku kopiujemy ze składnika — tak samo robi
        // formularz przepisu (migracja 0035).
        rola: (s.rola as RolaSkladnika | undefined) ?? zKatalogu.rola,
        mozna_dzielic: s.mozna_dzielic ?? zKatalogu.mozna_dzielic,
      });
    }

    // Sprzęt w pisowni z katalogu — widok sprzet_uzycie porównuje nazwy
    // dokładnie, więc „miska” z pliku nie zostałaby policzona jako „Miska”.
    const sprzet: string[] = [];
    for (const x of p.sprzet) {
      const zKatalogu = sprzetWedlugNazwy.get(klucz(x));
      if (!zKatalogu) {
        const propozycje = podobne(x, katalogi.sprzet);
        problemy.push(
          `brak sprzętu „${x}” w katalogu` + (propozycje.length > 0 ? ` — podobne: ${propozycje.join(', ')}` : '')
        );
      } else if (!sprzet.includes(zKatalogu)) sprzet.push(zKatalogu);
    }

    if (problemy.length > 0) {
      problemy.forEach((tresc) => bledy.push({ przepis: podpis, tresc }));
      return;
    }

    przepisy.push({
      nazwa: p.nazwa.trim(),
      opis: p.opis?.trim() || null,
      pory: p.pory as PoraPosilku[],
      kuchnie: p.kuchnie as Kuchnia[],
      ...(p.rodzaje !== undefined ? { rodzaje: p.rodzaje as RodzajDania[] } : {}),
      trwalosc_dni: p.trwalosc_dni,
      porcjowanie: p.porcjowanie,
      porcje: p.porcjowanie === 'sztuki' ? (p.porcje as number) : 1,
      porcja_g: p.porcjowanie === 'waga' ? (p.porcja_g as number) : null,
      ...(p.liczba_porcji_bazowych !== undefined ? { liczba_porcji_bazowych: p.liczba_porcji_bazowych } : {}),
      czas_przygotowania_min: p.czas_przygotowania_min ?? null,
      czas_obrobki_min: p.czas_obrobki_min ?? null,
      sprzet,
      przechowywanie: p.przechowywanie?.trim() || null,
      mozna_mrozic: p.mozna_mrozic ?? null,
      ratunek: p.ratunek?.trim() || null,
      skladniki,
      etapy: p.etapy.map((e) => ({
        nazwa: e.nazwa.trim(),
        minuty: e.minuty ?? null,
        kroki: e.kroki.map((k) => ({
          tresc: k.tresc.trim(),
          sygnal: k.sygnal?.trim() || null,
          uwaga: k.uwaga === true,
        })),
      })),
    });
  });

  return { przepisy, bledy };
}

// =============================================================================
//  PROMPT DLA AI
// =============================================================================

/**
 * Gotowy prompt do wklejenia w dowolny czat z AI: zasady, format i AKTUALNE
 * listy składników i sprzętu. Na końcu dopisuje się, jakie danie ma powstać.
 *
 * Treść ta sama co w `supabase/narzedzia/prompt-przepisu-ai.sql` — zmieniając
 * jedno, popraw drugie.
 */
export function zbudujPromptPrzepisu(
  skladniki: { nazwa: string; masa_sztuki_g: number | null }[],
  sprzet: string[]
): string {
  const poNazwie = (a: string, b: string) => a.localeCompare(b, 'pl');

  return [
    'Przygotuj przepis dla aplikacji Talerz jako JEDEN obiekt JSON, bez komentarzy i bez tekstu wokół.',
    '',
    'ZASADY',
    '1. Składniki i sprzęt wybieraj WYŁĄCZNIE z list poniżej. Nazwę przepisz znak w znak.',
    '2. Nie twórz nowych nazw ani wariantów (np. „Nóż” zamiast „Nóż szefa kuchni”). Jeśli czegoś',
    '   naprawdę brakuje, NIE wstawiaj tego do JSON-a — wypisz to osobno pod JSON-em w sekcji',
    '   „BRAKUJE W KATALOGU” z uzasadnieniem, dlaczego żadna pozycja z listy nie wystarcza.',
    '3. Jednostki: g, ml albo szt. Sztuki tylko przy składnikach oznaczonych [szt].',
    '4. Nie podawaj kalorii ani makroskładników — aplikacja liczy je ze składników.',
    '5. Każdy składnik występuje najwyżej raz; ilości tego samego składnika zsumuj.',
    '6. Ilości podawaj na JEDNĄ porcję (liczba_porcji_bazowych = 1). Dwie porcje tylko wtedy, gdy',
    '   jednej nie da się ugotować bez straty smaku — np. zupa. Nigdy więcej niż 2; aplikacja sama',
    '   przeskaluje przepis na większą liczbę porcji.',
    '',
    'FORMAT',
    '{',
    '  "nazwa": "3-120 znaków",',
    '  "opis": "tekst",',
    '  "pory": ["sniadanie" | "obiad" | "kolacja" | "dodatek"],',
    '  "kuchnie": ["srodziemnomorska" | "azjatycka" | "polska" | "inna"],',
    `  "rodzaje": jeden albo dwa z [${RODZAJE.map((r) => `"${r}"`).join(' | ')}],`,
    '  "porcjowanie": "waga" albo "sztuki",',
    '  "porcja_g": liczba całkowita 20-2000 — TYLKO przy "waga", równa masie składników / liczbie porcji,',
    '  "porcje": liczba całkowita 1-30 — TYLKO przy "sztuki",',
    '  "liczba_porcji_bazowych": na ile porcji są podane ilości składników — zawsze najmniejsza możliwa (zasada 6);',
    '      przy "waga" porcja_g × liczba_porcji_bazowych = masa wszystkich składników,',
    '  "trwalosc_dni": 0-3 (0 = tylko na świeżo),',
    '  "czas_przygotowania_min": 1-1440 (praca przy blacie),',
    '  "czas_obrobki_min": 0-1440 (garnek, piekarnik; 0 = danie na zimno),',
    '  "sprzet": ["nazwy z listy SPRZĘT"],',
    '  "przechowywanie": "w czym trzymać, jak odgrzewać",',
    '  "mozna_mrozic": true albo false,',
    '  "ratunek": "co zrobić, gdy danie wyjdzie za słone, za rzadkie itp.",',
    '  "skladniki": [',
    '    { "nazwa": "z listy SKŁADNIKI", "ilosc": liczba, "jednostka": "g" | "ml" | "szt",',
    '      "stan": "np. posiekany drobno (opcjonalnie)", "zamiennik": "np. lub mintaj (opcjonalnie)" }',
    '  ],',
    '  "etapy": [',
    '    { "nazwa": "np. Przygotowanie", "minuty": liczba,',
    '      "kroki": [ { "tresc": "instrukcja", "sygnal": "po czym poznać, że się udało (opcjonalnie)",',
    '                   "uwaga": true (opcjonalnie, dla kroku, którego nie wolno przegapić) } ] }',
    '  ]',
    '}',
    '',
    'SKŁADNIKI',
    ...skladniki
      .slice()
      .sort((a, b) => poNazwie(a.nazwa, b.nazwa))
      .map(
        (s) =>
          `- ${s.nazwa}` + (s.masa_sztuki_g ? ` [szt, 1 szt = ${Math.round(s.masa_sztuki_g)} g]` : '')
      ),
    '',
    'SPRZĘT',
    ...sprzet
      .slice()
      .sort(poNazwie)
      .map((n) => `- ${n}`),
    '',
    'DANIE, KTÓRE MA POWSTAĆ:',
    '',
  ].join('\n');
}
