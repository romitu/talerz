/**
 * Zamienia przepisy przygotowane przez AI (pliki JSON) na SQL do wgrania
 * w panelu Supabase.
 *
 *     node narzedzia/generuj-import-ai.mjs                  # wszystkie z przepisy-ai/
 *     node narzedzia/generuj-import-ai.mjs "Twarożek.json"  # wybrane pliki
 *
 * Wynik ląduje w supabase/narzedzia/import-przepisow-ai.sql.
 *
 * Format pliku opisuje narzedzia/przepisy-ai/README.md.
 *
 * Dwa poziomy sprawdzania
 * -----------------------
 * 1. Tutaj, przed wygenerowaniem: kształt pliku — wymagane pola, dozwolone
 *    wartości, zakresy liczb. Błąd przerywa i nic nie powstaje.
 * 2. W bazie, na początku skryptu SQL: czy każda nazwa składnika i sprzętu
 *    istnieje w katalogu, a składnik liczony w sztukach ma masę sztuki.
 *    Generator nie ma dostępu do bazy, więc tego sprawdzić nie może.
 *    Brak przerywa CAŁY skrypt, zanim cokolwiek zapisze.
 *
 * Tak jak generuj-import.mjs — nie zgaduje. Podobny składnik podstawiony po
 * cichu byłby gorszy niż błąd.
 */

import { readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { basename, dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { tablica, tekst } from './generuj-import.mjs';
import { wczytajEnv } from './import-usda.mjs';

const KATALOG = dirname(fileURLToPath(import.meta.url));
const KORZEN = join(KATALOG, '..');
const FOLDER = join(KATALOG, 'przepisy-ai');

const PORY = ['sniadanie', 'obiad', 'kolacja', 'dodatek'];
const KUCHNIE = ['srodziemnomorska', 'azjatycka', 'polska', 'inna'];
const JEDNOSTKI = ['g', 'ml', 'szt'];

// ---------------------------------------------------------------------------
//  Sprawdzenie pliku
// ---------------------------------------------------------------------------

const calkowita = (x, od, do_) => Number.isInteger(x) && x >= od && x <= do_;
const napis = (x) => typeof x === 'string' && x.trim().length > 0;

/** Zwraca listę błędów. Pusta lista — plik jest w porządku. */
export function sprawdzPrzepis(p) {
  const b = [];

  if (!napis(p.nazwa) || p.nazwa.trim().length < 3 || p.nazwa.length > 120)
    b.push('nazwa: od 3 do 120 znaków');

  for (const [pole, dozwolone] of [['pory', PORY], ['kuchnie', KUCHNIE]]) {
    if (!Array.isArray(p[pole])) b.push(`${pole}: ma być listą`);
    else
      p[pole].filter((x) => !dozwolone.includes(x))
        .forEach((x) => b.push(`${pole}: „${x}” — dozwolone ${dozwolone.join(', ')}`));
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

  if (!calkowita(p.trwalosc_dni, 0, 3)) b.push('trwalosc_dni: od 0 do 3');
  if (!calkowita(p.czas_przygotowania_min, 1, 1440)) b.push('czas_przygotowania_min: od 1 do 1440');
  if (!calkowita(p.czas_obrobki_min, 0, 1440)) b.push('czas_obrobki_min: od 0 do 1440');
  if (typeof p.mozna_mrozic !== 'boolean') b.push('mozna_mrozic: true albo false');

  if (!Array.isArray(p.sprzet) || !p.sprzet.every(napis)) b.push('sprzet: lista nazw z katalogu');

  if (!Array.isArray(p.skladniki) || p.skladniki.length === 0) {
    b.push('skladniki: co najmniej jeden');
  } else {
    const widziane = new Set();
    p.skladniki.forEach((s, i) => {
      const gdzie = `skladniki[${i + 1}] „${s.nazwa ?? '?'}”`;
      if (!napis(s.nazwa)) b.push(`${gdzie}: brak nazwy`);
      if (!(typeof s.ilosc === 'number' && s.ilosc > 0)) b.push(`${gdzie}: ilosc większa od zera`);
      if (!JEDNOSTKI.includes(s.jednostka)) b.push(`${gdzie}: jednostka ${JEDNOSTKI.join(', ')}`);
      // Baza trzyma jeden wiersz na składnik w przepisie (unique przepis_id, skladnik_id).
      if (widziane.has(s.nazwa)) b.push(`${gdzie}: występuje dwa razy — połącz ilości`);
      widziane.add(s.nazwa);
    });
  }

  if (!Array.isArray(p.etapy) || p.etapy.length === 0) {
    b.push('etapy: co najmniej jeden');
  } else {
    p.etapy.forEach((e, i) => {
      const gdzie = `etapy[${i + 1}] „${e.nazwa ?? '?'}”`;
      if (!napis(e.nazwa) || e.nazwa.trim().length < 2 || e.nazwa.length > 120) b.push(`${gdzie}: nazwa od 2 do 120 znaków`);
      if (e.minuty !== undefined && e.minuty !== null && !calkowita(e.minuty, 1, 1440)) b.push(`${gdzie}: minuty od 1 do 1440`);
      if (!Array.isArray(e.kroki) || e.kroki.length === 0) b.push(`${gdzie}: co najmniej jeden krok`);
      else e.kroki.forEach((k, j) => {
        if (!napis(k.tresc)) b.push(`${gdzie}, krok ${j + 1}: pusta treść`);
      });
    });
  }

  return b;
}

// ---------------------------------------------------------------------------
//  SQL jednego przepisu
// ---------------------------------------------------------------------------

/**
 * Zwykłe instrukcje, bez PL/pgSQL — z tego samego powodu co w
 * generuj-import.mjs: parser panelu Supabase gubi się w `do $$ ... $$`.
 */
export function sqlPrzepisu(p, autor) {
  const N = tekst(p.nazwa);
  const waga = p.porcjowanie === 'waga';
  const l = [];

  l.push('-- ' + '-'.repeat(73));
  l.push(`--  ${p.nazwa}`);
  l.push('-- ' + '-'.repeat(73));
  l.push('');

  // Istniejący przepis o tej nazwie jest aktualizowany, nie kasowany —
  // zostają polubienia, zdjęcie i powiązanie z planem.
  l.push('insert into przepisy');
  l.push('  (nazwa, opis, autor_id, pory, kuchnie, trwalosc_dni, widocznosc,');
  l.push('   porcjowanie, porcja_g, porcje, czas_przygotowania_min, czas_obrobki_min,');
  l.push('   sprzet, przechowywanie, mozna_mrozic, ratunek)');
  l.push('select');
  l.push(`  ${N}, ${tekst(p.opis)}, (select id from konta where lower(email) = lower(${tekst(autor)})),`);
  l.push(`  ${tablica(p.pory)}::pora_posilku[], ${tablica(p.kuchnie)}::rodzaj_kuchni[],`);
  l.push(`  ${p.trwalosc_dni}, 'prywatna',`);
  l.push(`  ${tekst(p.porcjowanie)}, ${waga ? p.porcja_g : 'null'}, ${waga ? 1 : p.porcje},`);
  l.push(`  ${p.czas_przygotowania_min}, ${p.czas_obrobki_min},`);
  // Nazwy sprzętu bierzemy w pisowni z katalogu — widok sprzet_uzycie porównuje
  // je dokładnie, więc „miska” z pliku nie zostałaby policzona jako „Miska”.
  l.push(`  (select coalesce(array_agg(x.nazwa order by v.poz), '{}')`);
  l.push(`     from unnest(${tablica(p.sprzet)}::text[]) with ordinality as v(nazwa, poz)`);
  l.push(`     join sprzet x on lower(x.nazwa) = lower(v.nazwa)),`);
  l.push(`  ${tekst(p.przechowywanie)},`);
  l.push(`  ${p.mozna_mrozic ? 'true' : 'false'}, ${tekst(p.ratunek)}`);
  l.push('on conflict (lower(nazwa)) do update set');
  l.push('  opis                   = excluded.opis,');
  l.push('  pory                   = excluded.pory,');
  l.push('  kuchnie                = excluded.kuchnie,');
  l.push('  trwalosc_dni           = excluded.trwalosc_dni,');
  l.push('  porcjowanie            = excluded.porcjowanie,');
  l.push('  porcja_g               = excluded.porcja_g,');
  l.push('  porcje                 = excluded.porcje,');
  l.push('  czas_przygotowania_min = excluded.czas_przygotowania_min,');
  l.push('  czas_obrobki_min       = excluded.czas_obrobki_min,');
  l.push('  sprzet                 = excluded.sprzet,');
  l.push('  przechowywanie         = excluded.przechowywanie,');
  l.push('  mozna_mrozic           = excluded.mozna_mrozic,');
  l.push('  ratunek                = excluded.ratunek,');
  l.push('  zmieniono              = now();');
  l.push('');

  l.push(`delete from przepis_skladniki where przepis_id in (select id from przepisy where lower(nazwa) = lower(${N}));`);
  l.push(`delete from etapy            where przepis_id in (select id from przepisy where lower(nazwa) = lower(${N}));`);
  l.push('');

  // Rolę i podzielność kopiujemy ze składnika — tak samo robi formularz
  // przepisu w aplikacji (migracja 0035).
  p.skladniki.forEach((s, i) => {
    const gramy =
      s.jednostka === 'szt' ? `round((${s.ilosc} * sk.masa_sztuki_g)::numeric, 1)` : `${s.ilosc}`;
    l.push('insert into przepis_skladniki');
    l.push('  (przepis_id, skladnik_id, ilosc, jednostka, gramy, stan, zamiennik, rola, mozna_dzielic, kolejnosc)');
    l.push(`select p.id, sk.id, ${s.ilosc}, ${tekst(s.jednostka)}::jednostka_miary, ${gramy},`);
    l.push(`       ${tekst(s.stan)}, ${tekst(s.zamiennik)}, sk.rola, sk.mozna_dzielic, ${i + 1}`);
    l.push(`  from przepisy p, skladniki sk where lower(p.nazwa) = lower(${N}) and sk.nazwa = ${tekst(s.nazwa)};`);
  });
  l.push('');

  p.etapy.forEach((e, i) => {
    const nr = i + 1;
    l.push('insert into etapy (przepis_id, kolejnosc, nazwa, minuty)');
    l.push(`select p.id, ${nr}, ${tekst(e.nazwa)}, ${e.minuty ?? 'null'} from przepisy p where lower(p.nazwa) = lower(${N});`);
    l.push('');
    l.push('insert into kroki (etap_id, kolejnosc, tresc, sygnal, uwaga)');
    l.push('select e.id, v.nr, v.tresc, v.sygnal, v.uwaga');
    l.push('  from etapy e join przepisy p on p.id = e.przepis_id,');
    l.push('       (values');
    l.push(
      e.kroki
        .map((k, j) => `         (${j + 1}::smallint, ${tekst(k.tresc)}, ${tekst(k.sygnal)}::text, ${k.uwaga === true})`)
        .join(',\n'),
    );
    l.push('       ) as v(nr, tresc, sygnal, uwaga)');
    l.push(` where lower(p.nazwa) = lower(${N}) and e.kolejnosc = ${nr};`);
    l.push('');
  });

  return l.join('\n');
}

// ---------------------------------------------------------------------------
//  Sprawdzenie katalogów w bazie
// ---------------------------------------------------------------------------

/**
 * Zapytanie, które PRZERYWA skrypt, gdy czegoś brakuje w katalogach.
 *
 * Bez PL/pgSQL nie ma `raise exception`, więc listę braków rzutujemy na
 * liczbę. Rzutowanie się nie udaje, a PostgreSQL pokazuje w komunikacie
 * błędu cały tekst — czyli dokładnie to, czego brakuje. Panel Supabase
 * wykonuje skrypt jako jedną transakcję, więc nic wcześniej nie zostaje zapisane.
 * Gdy braków nie ma, string_agg zwraca null i rzutowanie przechodzi.
 *
 * Katalogi mają zostać zwarte — bez „Noża” obok „Noża szefa kuchni”. Dlatego
 * przy braku pokazujemy pozycje z katalogu, które mają wspólne słowo z brakującą
 * nazwą. Zwykle wystarczy poprawić nazwę w JSON-ie zamiast dodawać nową.
 */
export function sqlSprawdzenia(przepisy, autor) {
  const skladniki = [];
  const sprzet = [];
  for (const p of przepisy) {
    for (const s of p.skladniki) skladniki.push([p.nazwa, s.nazwa, s.jednostka === 'szt']);
    for (const x of p.sprzet) sprzet.push([p.nazwa, x]);
  }

  return `with
  potrzebne_skladniki(przepis, nazwa, w_sztukach) as (values
${skladniki.map(([p, n, szt]) => `    (${tekst(p)}, ${tekst(n)}, ${szt})`).join(',\n')}
  ),
  potrzebny_sprzet(przepis, nazwa) as (values
${sprzet.map(([p, n]) => `    (${tekst(p)}, ${tekst(n)})`).join(',\n')}
  ),
  braki(opis) as (
    -- Bez konta autora przepisy weszłyby bez właściciela i nikt poza
    -- moderatorem by ich nie zobaczył.
    select 'brak konta ' || ${tekst(autor)}
     where not exists (select 1 from konta where lower(email) = lower(${tekst(autor)}))
    union all
    select 'brak składnika „' || ps.nazwa || '” (' || ps.przepis || ')'
           || coalesce(' — podobne w katalogu: ' || (
                select string_agg(sk.nazwa, ', ' order by sk.nazwa)
                  from skladniki sk
                 where exists (select 1 from regexp_split_to_table(lower(ps.nazwa), '[^[:alpha:]]+') w
                                where length(w) >= 3 and lower(sk.nazwa) ~ ('\\m' || w))), '')
      from potrzebne_skladniki ps
     where not exists (select 1 from skladniki sk where sk.nazwa = ps.nazwa)
    union all
    select 'składnik „' || ps.nazwa || '” w sztukach, a nie ma masy sztuki (' || ps.przepis || ')'
      from potrzebne_skladniki ps
      join skladniki sk on sk.nazwa = ps.nazwa
     where ps.w_sztukach and sk.masa_sztuki_g is null
    union all
    select 'brak sprzętu „' || pq.nazwa || '” (' || pq.przepis || ')'
           || coalesce(' — podobne w katalogu: ' || (
                select string_agg(x.nazwa, ', ' order by x.nazwa)
                  from sprzet x
                 where exists (select 1 from regexp_split_to_table(lower(pq.nazwa), '[^[:alpha:]]+') w
                                where length(w) >= 3 and lower(x.nazwa) ~ ('\\m' || w))), '')
      from potrzebny_sprzet pq
     where not exists (select 1 from sprzet x where lower(x.nazwa) = lower(pq.nazwa))
  )
select ('IMPORT PRZERWANY — ' || string_agg(opis, '; '))::int as sprawdzenie_katalogow
  from braki;
`;
}

// ---------------------------------------------------------------------------
//  Główna część
// ---------------------------------------------------------------------------

function main() {
  // Autor po adresie, a nie „najstarsze konto” — to drugie działało tylko
  // dlatego, że najstarsze konto przypadkiem należało do administratora.
  const autor =
    process.argv.find((a) => a.startsWith('--autor='))?.slice('--autor='.length) ??
    wczytajEnv().TALERZ_EMAIL;
  if (!autor) {
    console.error('Podaj autora: --autor=adres@e-mail albo TALERZ_EMAIL w pliku .env.local.');
    process.exit(1);
  }

  const wybrane = process.argv.slice(2).filter((a) => !a.startsWith('--'));
  const pliki = wybrane.length > 0
    ? wybrane.map((f) => basename(f))
    : readdirSync(FOLDER).filter((f) => f.endsWith('.json')).sort();

  if (pliki.length === 0) {
    console.error('Brak plików JSON w narzedzia/przepisy-ai/.');
    process.exit(1);
  }

  const przepisy = [];
  const bledy = [];
  const nazwy = new Map();

  for (const plik of pliki) {
    let p;
    try {
      p = JSON.parse(readFileSync(join(FOLDER, plik), 'utf8'));
    } catch (e) {
      bledy.push(`${plik}: ${e.message}`);
      continue;
    }
    // Przepis to jeden obiekt. Lista to np. eksport tabeli z panelu Supabase.
    if (Array.isArray(p)) {
      console.log(`Pominięto ${plik} — to lista, a nie przepis.`);
      continue;
    }
    sprawdzPrzepis(p).forEach((b) => bledy.push(`${plik}: ${b}`));

    const klucz = String(p.nazwa ?? '').toLowerCase();
    if (nazwy.has(klucz)) bledy.push(`${plik}: ta sama nazwa co w ${nazwy.get(klucz)}`);
    nazwy.set(klucz, plik);

    przepisy.push(p);
  }

  if (bledy.length > 0) {
    console.error('Nie da się wygenerować:\n');
    bledy.forEach((b) => console.error('  !', b));
    console.error('\nPopraw pliki w narzedzia/przepisy-ai/ i uruchom ponownie.');
    process.exit(1);
  }

  const naglowek = `-- =============================================================================
--  TALERZ — przepisy przygotowane przez AI
-- =============================================================================
--  Plik WYGENEROWANY przez narzedzia/generuj-import-ai.mjs z plików
--  w narzedzia/przepisy-ai/. Nie poprawiaj go ręcznie — poprawiaj JSON
--  i generuj ponownie.
--
--  Przepisów w tym pliku: ${przepisy.length}
--  Wygenerowano: ${new Date().toISOString().slice(0, 10)}
--
--  Skrypt najpierw sprawdza katalogi składników i sprzętu. Jeśli czegoś
--  brakuje, kończy się błędem „IMPORT PRZERWANY — …” z listą braków
--  i niczego nie zapisuje.
--
--  Przepis o tej samej nazwie jest AKTUALIZOWANY, nie kasowany. Nowe przepisy
--  wchodzą jako prywatne, a ich autorem jest konto ${autor}.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

begin;

${sqlSprawdzenia(przepisy, autor)}
`;

  const oczekiwane = przepisy.map((p) => ({
    nazwa: p.nazwa,
    skladnikow: p.skladniki.length,
    etapow: p.etapy.length,
    krokow: p.etapy.reduce((n, e) => n + e.kroki.length, 0),
  }));

  const stopka = `
commit;

-- =============================================================================
--  SPRAWDZENIE — czy wszystko weszło. Pusta tabelka = zgadza się.
-- =============================================================================

with oczekiwane(nazwa, skladnikow, etapow, krokow) as (values
${oczekiwane.map((o) => `  (${tekst(o.nazwa)}, ${o.skladnikow}, ${o.etapow}, ${o.krokow})`).join(',\n')}
), jest as (
  select p.nazwa,
         (select count(*) from przepis_skladniki ps where ps.przepis_id = p.id) as skladnikow,
         (select count(*) from etapy e where e.przepis_id = p.id)              as etapow,
         (select count(*) from kroki k join etapy e on e.id = k.etap_id
           where e.przepis_id = p.id)                                         as krokow
    from przepisy p
)
select o.nazwa,
       o.skladnikow as skladnikow_mialo_byc, j.skladnikow as skladnikow_jest,
       o.etapow     as etapow_mialo_byc,     j.etapow     as etapow_jest,
       o.krokow     as krokow_mialo_byc,     j.krokow     as krokow_jest
  from oczekiwane o
  left join jest j on lower(j.nazwa) = lower(o.nazwa)
 where j.nazwa is null
    or (j.skladnikow, j.etapow, j.krokow) <> (o.skladnikow, o.etapow, o.krokow)
 order by o.nazwa;


-- --- CO WYSZŁO --------------------------------------------------------------
select
  p.nazwa,
  p.porcjowanie,
  p.porcja_g,
  p.porcje,
  round(sum(ps.gramy))                                        as masa_calosci_g,
  case when p.porcjowanie = 'waga'
       then round(sum(ps.gramy) / p.porcja_g, 1) end          as porcji_wychodzi,
  round(m.kcal)                                               as kcal_na_porcje,
  round(m.bialko_g)                                           as bialko_na_porcje
from przepisy p
join przepis_skladniki ps on ps.przepis_id = p.id
join przepis_makro m      on m.przepis_id = p.id
where lower(p.nazwa) in (${przepisy.map((p) => `lower(${tekst(p.nazwa)})`).join(', ')})
group by p.nazwa, p.porcjowanie, p.porcja_g, p.porcje, m.kcal, m.bialko_g
order by p.nazwa;
`;

  const sciezka = join(KORZEN, 'supabase', 'narzedzia', 'import-przepisow-ai.sql');
  writeFileSync(sciezka, naglowek + '\n' + przepisy.map((p) => sqlPrzepisu(p, autor)).join('\n') + stopka, 'utf8');

  console.log(`Wygenerowano ${przepisy.length} przepisów:`);
  przepisy.forEach((p) => console.log('  -', p.nazwa));
  console.log('\nPlik: supabase/narzedzia/import-przepisow-ai.sql');
}

if (process.argv[1] && process.argv[1].endsWith('generuj-import-ai.mjs')) {
  main();
}
