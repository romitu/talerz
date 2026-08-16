/**
 * Zamienia dania ze starego planera na SQL do wgrania w panelu Supabase.
 *
 *     node narzedzia/generuj-import.mjs                     # wszystkie z mapowania
 *     node narzedzia/generuj-import.mjs "Kurczak po tajsku" # wybrane
 *
 * Wynik ląduje w supabase/narzedzia/import-przepisow.sql.
 *
 * Dlaczego generator, a nie SQL pisany ręcznie
 * --------------------------------------------
 * Dań jest trzydzieści, a każde ma kilkanaście składników i kilkanaście kroków.
 * Napisane ręcznie raz — po pierwszej poprawce w przelicznikach trzeba by
 * przepisać wszystko od nowa. Tutaj poprawiasz mapowanie i uruchamiasz ponownie.
 *
 * Czego generator NIE robi
 * ------------------------
 * Nie zgaduje. Jeśli składnika nie ma w mapowaniu albo w bazie, przerywa
 * i wypisuje, czego brakuje. Cicho podstawiony „podobny” składnik byłby gorszy
 * niż błąd — nikt by go nie zauważył.
 */

import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const KATALOG = dirname(fileURLToPath(import.meta.url));
const KORZEN = join(KATALOG, '..');

// ---------------------------------------------------------------------------
//  Jednostki
// ---------------------------------------------------------------------------

/**
 * Jednostki domowe z planera przełożone na to, co rozumie baza.
 *
 * `mnoznik` mówi, ile jednej miary składnika stanowi ta jednostka. Łyżeczka to
 * jedna trzecia łyżki, więc „pół łyżeczki oliwy” zapisujemy jako 0,1667 miary,
 * a masę wylicza już baza z kolumny `masa_sztuki_g`.
 *
 * Gramy i mililitry zostają, jakie są — Talerz zna je bezpośrednio.
 */
export const JEDNOSTKI = {
  g: { docelowa: 'g', mnoznik: 1 },
  ml: { docelowa: 'ml', mnoznik: 1 },
  'szt.': { docelowa: 'szt', mnoznik: 1 },
  ząbek: { docelowa: 'szt', mnoznik: 1 },
  kromka: { docelowa: 'szt', mnoznik: 1 },
  puszka: { docelowa: 'szt', mnoznik: 1 },
  torebka: { docelowa: 'szt', mnoznik: 1 },
  łyżka: { docelowa: 'szt', mnoznik: 1 },
  łyżeczka: { docelowa: 'szt', mnoznik: 1 / 3 },
};

/** Ilość po przeliczeniu na krotność i jednostkę docelową. */
export function przelicz(ilosc, jednostka, krotnosc) {
  const j = JEDNOSTKI[jednostka];
  if (!j) throw new Error(`Nieznana jednostka „${jednostka}”`);
  const wynik = ilosc * krotnosc * j.mnoznik;
  return { jednostka: j.docelowa, ilosc: Math.round(wynik * 1000) / 1000 };
}

// ---------------------------------------------------------------------------
//  Pomocnicze
// ---------------------------------------------------------------------------

/** Apostrof w tekście SQL podwajamy; null zostaje słowem kluczowym NULL. */
export function tekst(x) {
  if (x === null || x === undefined) return 'null';
  return `'${String(x).replace(/'/g, "''")}'`;
}

/** Tablica PostgreSQL z listy napisów. */
export function tablica(xs) {
  if (!xs || xs.length === 0) return `'{}'`;
  return `array[${xs.map(tekst).join(', ')}]`;
}

// ---------------------------------------------------------------------------
//  Budowanie SQL
// ---------------------------------------------------------------------------

/**
 * Składniki jednego dania: pozycje z planera plus dolewki z mapowania.
 * Zwraca listę gotową do wpisania, zachowując kolejność z przepisu.
 */
export function skladnikiDania(danie, ustawienia, mapaSkladnikow) {
  const krotnosc = ustawienia.krotnosc ?? 1;
  const wynik = [];
  const brakujace = [];

  // Podmiany dotyczą JEDNEGO dania, w odróżnieniu od mapowania, które działa
  // wszędzie. Barszcz gotujemy na prędze wołowej, ale gulasz zostaje na
  // łopatce — a oba używają w planerze tej samej nazwy „Mięso gulaszowe”.
  const zamiany = ustawienia.zamiany ?? {};

  for (const [nazwa, ilosc, jednostka] of danie.skladniki) {
    const m = zamiany[nazwa] ? { ...mapaSkladnikow[nazwa], ...zamiany[nazwa] } : mapaSkladnikow[nazwa];
    if (!m || !m.baza) {
      brakujace.push(nazwa);
      continue;
    }

    if (ilosc === null) {
      // „Do smaku”. Bez liczby składnik zniknąłby z listy zakupów, a wtedy
      // wychodząc do sklepu nie wiesz, że potrzebujesz majeranku.
      const g = m.doSmaku_g;
      if (g === undefined) {
        brakujace.push(`${nazwa} (brak doSmaku_g)`);
        continue;
      }
      wynik.push({ baza: m.baza, ilosc: g * krotnosc, jednostka: 'g', stan: m.stan ?? null });
    } else {
      const p = przelicz(ilosc, jednostka, krotnosc);
      wynik.push({ baza: m.baza, ilosc: p.ilosc, jednostka: p.jednostka, stan: m.stan ?? null });
    }

    // Dolewki wstawiamy zaraz za wskazanym składnikiem, żeby kolejność
    // w przepisie odpowiadała kolejności wrzucania do garnka.
    for (const d of ustawienia.dolej ?? []) {
      if (d.po === nazwa) {
        const md = mapaSkladnikow[d.skladnik];
        if (!md) brakujace.push(d.skladnik);
        else wynik.push({ baza: md.baza, ilosc: d.gramy, jednostka: 'g', stan: d.stan ?? null });
      }
    }
  }

  // Dolewki bez wskazania „po” trafiają na koniec.
  for (const d of ustawienia.dolej ?? []) {
    if (d.po) continue;
    const md = mapaSkladnikow[d.skladnik];
    if (!md) brakujace.push(d.skladnik);
    else wynik.push({ baza: md.baza, ilosc: d.gramy, jednostka: 'g', stan: d.stan ?? null });
  }

  return { skladniki: wynik, brakujace };
}

/**
 * SQL dla jednego dania — zwykłe instrukcje, bez PL/pgSQL.
 *
 * Dlaczego nie `do $$ ... $$`
 * ---------------------------
 * Panel Supabase przed wykonaniem skanuje skrypt, szukając `create table`,
 * żeby dopisać do nowych tabel reguły dostępu. Przy trzydziestu blokach
 * `do $$ ... $$` jego parser gubi się w cudzysłowach dolarowych: ucina skrypt
 * w połowie instrukcji i dokleja własne `alter table` na zmiennych z `declare`.
 * Kończy się to komunikatem „unterminated dollar-quoted string”.
 *
 * Dlatego cała treść to zwykłe `insert`, `update` i `delete`. Nie ma zmiennych
 * ani cudzysłowów dolarowych, więc nie ma się o co potknąć.
 *
 * Zamiast zmiennej z identyfikatorem przepisu używamy jego nazwy — stąd
 * wymóg, żeby nazwa była niepowtarzalna (migracja 0018).
 */
export function sqlDania(danie, ustawienia, mapaSkladnikow) {
  const { skladniki, brakujace } = skladnikiDania(danie, ustawienia, mapaSkladnikow);
  if (brakujace.length > 0) {
    throw new Error(`„${danie.nazwa}” — brak w mapowaniu: ${brakujace.join(', ')}`);
  }

  const krotnosc = ustawienia.krotnosc ?? 1;
  const opis = [
    danie.wskazowka,
    krotnosc > 1
      ? `Przepis rozpisany na cały garnek — ${krotnosc} porcje.`
      : 'Przepis na jedną porcję.',
    'Przeniesiony z planera posiłków; wartości odżywcze przeliczone ze składników.',
  ]
    .filter(Boolean)
    .join(' ');

  const N = tekst(danie.nazwa);
  const l = [];

  l.push('-- ' + '-'.repeat(73));
  l.push(`--  ${danie.nazwa}`);
  l.push(`--  Planer podawał ${danie.kcal} kcal i ${danie.bialko} g białka na porcję.`);
  l.push('--  Talerz policzy to ze składników — porównaj obie liczby po imporcie.');
  l.push('-- ' + '-'.repeat(73));
  l.push('');

  // --- przepis: wstaw albo odśwież -----------------------------------------
  // Nie kasujemy istniejącego. Gdy danie jest w planie, wiersz w `partie`
  // się na nie powołuje i baza odmówiłaby usunięcia; przepadłyby też
  // polubienia i zdjęcie.
  l.push('insert into przepisy');
  l.push('  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,');
  l.push('   porcjowanie, porcja_g, czas_przygotowania_min, czas_obrobki_min,');
  l.push('   sprzet, przechowywanie, mozna_mrozic, ratunek)');
  l.push('select');
  l.push(`  ${N}, ${tekst(opis)}, (select id from konta order by utworzono limit 1),`);
  l.push(`  ${tablica(ustawienia.pory)}::pora_posilku[], ${tablica(ustawienia.kuchnie)}::rodzaj_kuchni[],`);
  l.push(`  ${ustawienia.trwalosc_dni}, 'prywatna', 'waga', ${ustawienia.porcja_g},`);
  l.push(`  ${czasPrzygotowania(danie)}, ${czasObrobki(danie)},`);
  l.push(`  ${tablica(ustawienia.sprzet)}, ${tekst(ustawienia.przechowywanie)},`);
  l.push(`  ${ustawienia.mozna_mrozic ? 'true' : 'false'}, ${tekst(ustawienia.ratunek)}`);
  l.push('on conflict (lower(nazwa)) do update set');
  l.push('  opis                   = excluded.opis,');
  l.push('  pory                   = excluded.pory,');
  l.push('  kuchnie                = excluded.kuchnie,');
  l.push('  trwalosc_dni           = excluded.trwalosc_dni,');
  l.push('  porcjowanie            = excluded.porcjowanie,');
  l.push('  porcja_g               = excluded.porcja_g,');
  l.push('  czas_przygotowania_min = excluded.czas_przygotowania_min,');
  l.push('  czas_obrobki_min       = excluded.czas_obrobki_min,');
  l.push('  sprzet                 = excluded.sprzet,');
  l.push('  przechowywanie         = excluded.przechowywanie,');
  l.push('  mozna_mrozic           = excluded.mozna_mrozic,');
  l.push('  ratunek                = excluded.ratunek;');
  l.push('');

  // --- stara treść znika, sam przepis zostaje ------------------------------
  l.push(`delete from przepis_skladniki where przepis_id in (select id from przepisy where nazwa = ${N});`);
  l.push(`delete from etapy            where przepis_id in (select id from przepisy where nazwa = ${N});`);
  l.push('');

  // --- składniki ------------------------------------------------------------
  skladniki.forEach((s, i) => {
    // Gramy liczy baza z `masa_sztuki_g`, a nie generator — inaczej po zmianie
    // masy jednej marchewki trzeba by generować wszystkie przepisy od nowa.
    const gramy =
      s.jednostka === 'szt'
        ? `round((${s.ilosc} * sk.masa_sztuki_g)::numeric, 1)`
        : `${s.ilosc}`;
    l.push('insert into przepis_skladniki (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, kolejnosc)');
    l.push(`select p.id, sk.id, ${s.ilosc}, ${tekst(s.jednostka)}::jednostka_miary, ${gramy}, ${tekst(s.stan)}, ${i + 1}`);
    l.push(`  from przepisy p, skladniki sk where p.nazwa = ${N} and sk.nazwa = ${tekst(s.baza)};`);
  });
  l.push('');

  // --- etap i kroki ---------------------------------------------------------
  l.push('insert into etapy (przepis_id, kolejnosc, nazwa, minuty)');
  l.push(`select p.id, 1, 'Przygotowanie', ${danie.czas_min} from przepisy p where p.nazwa = ${N};`);
  l.push('');
  l.push('insert into kroki (etap_id, kolejnosc, tresc)');
  l.push('select e.id, v.nr, v.tresc');
  l.push('  from etapy e join przepisy p on p.id = e.przepis_id,');
  l.push('       (values');
  l.push(danie.kroki.map((k, i) => `         (${i + 1}::smallint, ${tekst(k)})`).join(',\n'));
  l.push('       ) as v(nr, tresc)');
  l.push(` where p.nazwa = ${N} and e.kolejnosc = 1;`);
  l.push('');

  return l.join('\n');
}

/**
 * Planer podaje jeden czas na całe danie. Talerz rozdziela krojenie od gotowania,
 * bo to różne rzeczy: krojenie da się zrobić dzień wcześniej.
 *
 * Bez lepszych danych przyjmujemy jedną trzecią na przygotowanie, nie mniej
 * niż pięć minut. Przy daniu pięciominutowym wychodzi z tego zero minut
 * obróbki — i tak ma być, bo twarogu z rzodkiewką się nie gotuje.
 * Migracja 0013 na to pozwala.
 *
 * To jest oszacowanie i tak zostanie opisane w przepisie. Prawdziwy podział
 * dałoby się wyciągnąć tylko z kroków, a to już zgadywanie.
 */
export function czasPrzygotowania(danie) {
  return Math.max(5, Math.min(danie.czas_min, Math.round(danie.czas_min / 3)));
}

export function czasObrobki(danie) {
  return Math.max(0, danie.czas_min - czasPrzygotowania(danie));
}

// ---------------------------------------------------------------------------
//  Główna część
// ---------------------------------------------------------------------------

function main() {
  const dania = JSON.parse(readFileSync(join(KATALOG, 'planer-html-dania.json'), 'utf8')).dania;
  const mapowanie = JSON.parse(readFileSync(join(KATALOG, 'mapowanie-planera.json'), 'utf8'));

  const wybrane = process.argv.slice(2).filter((a) => !a.startsWith('--'));
  const nazwy = wybrane.length > 0 ? wybrane : Object.keys(mapowanie.dania);

  const czesci = [];
  const bledy = [];
  const oczekiwane = [];

  for (const nazwa of nazwy) {
    const danie = dania.find((d) => d.nazwa === nazwa);
    if (!danie) {
      bledy.push(`Nie ma dania „${nazwa}” w planer-html-dania.json`);
      continue;
    }
    const ustawienia = mapowanie.dania[nazwa];
    if (!ustawienia) {
      bledy.push(`Nie ma dania „${nazwa}” w mapowaniu`);
      continue;
    }
    try {
      czesci.push(sqlDania(danie, ustawienia, mapowanie.skladniki));
      const { skladniki } = skladnikiDania(danie, ustawienia, mapowanie.skladniki);
      oczekiwane.push({ nazwa, skladnikow: skladniki.length, krokow: danie.kroki.length });
    } catch (e) {
      bledy.push(e.message);
    }
  }

  if (bledy.length > 0) {
    console.error('Nie da się wygenerować:\n');
    bledy.forEach((b) => console.error('  !', b));
    console.error('\nUzupełnij narzedzia/mapowanie-planera.json i uruchom ponownie.');
    process.exit(1);
  }

  const naglowek = `-- =============================================================================
--  TALERZ — przepisy przeniesione ze starego planera
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import.mjs. Nie poprawiaj go
--  ręcznie — przy następnym uruchomieniu poprawki znikną. Zmiany wprowadzaj
--  w narzedzia/mapowanie-planera.json.
--
--  Dań w tym pliku: ${czesci.length}
--  Wygenerowano: ${new Date().toISOString().slice(0, 10)}
--
--  Zanim uruchomisz
--  ----------------
--  1. Migracja 0012 musi być wgrana (przeliczniki jednostek domowych).
--  2. Składniki ręczne muszą być wgrane (narzedzia/skladniki-recznie.sql).
--  3. Nazwa przepisu musi być niepowtarzalna (migracja 0018) — po niej
--     skrypt rozpoznaje, czy danie już jest w bazie.
--  4. Sprawdź wcześniej narzedzia/sprawdz-skladniki.sql.
--
--  Skrypt można uruchamiać wielokrotnie. Przepis o tej samej nazwie jest
--  AKTUALIZOWANY, a nie kasowany — dzięki temu nie znikają polubienia,
--  zdjęcie ani powiązanie z planem. Wymieniana jest tylko treść: składniki,
--  etapy i kroki.
--
--  Cały skrypt to zwykłe instrukcje SQL, bez bloków PL/pgSQL. Panel
--  Supabase potrafi się na nich wywrócić przy dużych plikach.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

`;

  // Bez bloków PL/pgSQL nie ma jak przerwać z komunikatem — brakujący składnik
  // po prostu wstawiłby zero wierszy, po cichu. Dlatego na końcu porównujemy,
  // ile pozycji MIAŁO wejść, z tym, ile weszło.
  const stopka = `
-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło
-- =============================================================================
--  Ten skrypt nie przerywa na błędzie, bo nie używa PL/pgSQL (patrz nagłówek).
--  Brakujący składnik wstawiłby zero wierszy i nikt by tego nie zauważył —
--  danie miałoby po prostu zaniżone kalorie.
--
--  Poniższe zapytanie porównuje stan z tym, co miało powstać.
--  Pusta tabelka oznacza, że wszystko się zgadza.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, krokow) as (values
${oczekiwane.map((o) => `  (${tekst(o.nazwa)}, ${o.skladnikow}, ${o.krokow})`).join(',\n')}
)
select
  o.nazwa,
  o.skladnikow                                       as skladnikow_mialo_byc,
  coalesce(s.ile, 0)                                 as skladnikow_jest,
  o.krokow                                           as krokow_mialo_byc,
  coalesce(k.ile, 0)                                 as krokow_jest
from oczekiwane o
left join (select przepis_id, count(*) as ile from przepis_skladniki group by przepis_id) s
       on s.przepis_id = (select id from przepisy p where p.nazwa = o.nazwa)
left join (select e.przepis_id, count(*) as ile from kroki k join etapy e on e.id = k.etap_id
            group by e.przepis_id) k
       on k.przepis_id = (select id from przepisy p where p.nazwa = o.nazwa)
where coalesce(s.ile, 0) <> o.skladnikow
   or coalesce(k.ile, 0) <> o.krokow
order by o.nazwa;


-- --- CO WYSZŁO --------------------------------------------------------------
select
  p.nazwa,
  p.porcja_g,
  round(sum(ps.gramy))                  as masa_calosci_g,
  round(sum(ps.gramy) / p.porcja_g, 1)  as porcji_wychodzi,
  round(m.kcal)                         as kcal_na_porcje,
  round(m.bialko_g)                     as bialko_na_porcje
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join przepis_makro m      on m.przepis_id = p.id
where p.nazwa in (${nazwy.map(tekst).join(', ')})
group by p.nazwa, p.porcja_g, m.kcal, m.bialko_g
order by p.nazwa;
`;

  const sciezka = join(KORZEN, 'supabase', 'narzedzia', 'import-przepisow.sql');
  writeFileSync(sciezka, naglowek + czesci.join('\n') + stopka, 'utf8');

  console.log(`Wygenerowano ${czesci.length} dań:`);
  nazwy.forEach((n) => console.log('  -', n));
  console.log(`\nPlik: supabase/narzedzia/import-przepisow.sql`);
}

if (process.argv[1] && process.argv[1].endsWith('generuj-import.mjs')) {
  main();
}
