/**
 * Import składników z USDA FoodData Central do bazy Talerza.
 *
 *     node narzedzia/import-usda.mjs            # import
 *     node narzedzia/import-usda.mjs --podglad  # tylko pokaż, nic nie zapisuj
 *
 * Dane USDA są w domenie publicznej (CC0) — nie wnoszą żadnych zobowiązań
 * licencyjnych. Skrypt loguje się na Twoje konto administratora, więc nie
 * potrzebuje klucza `service_role`; wystarczają uprawnienia z reguł dostępu.
 *
 * Czego USDA NIE poda, a nasza baza tego wymaga:
 *   * cukry wolne — podaje wyłącznie cukry ogółem; rozróżnienie jest naszą
 *     decyzją i pochodzi z pliku skladniki-lista.json (patrz plan, sekcja 3.3)
 *   * grupa NOVA — również z listy
 *   * gramatura opakowania — zależy od polskiego producenta, uzupełniamy ręcznie
 */

import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient } from '@supabase/supabase-js';

const KATALOG = dirname(fileURLToPath(import.meta.url));
const KORZEN = join(KATALOG, '..');

// ---------------------------------------------------------------------------
//  Ustawienia z pliku .env
// ---------------------------------------------------------------------------

function wczytajEnv() {
  const wynik = {};
  for (const nazwa of ['.env', '.env.local']) {
    try {
      const tresc = readFileSync(join(KORZEN, nazwa), 'utf8');
      for (const linia of tresc.split('\n')) {
        const m = linia.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
        if (m) wynik[m[1]] = m[2].replace(/^["']|["']$/g, '');
      }
    } catch {
      // brak pliku to nie błąd — część zmiennych może przyjść ze środowiska
    }
  }
  return { ...wynik, ...process.env };
}

const PODGLAD = process.argv.includes('--podglad');

const WYMAGANE = {
  EXPO_PUBLIC_SUPABASE_URL: 'adres projektu Supabase',
  EXPO_PUBLIC_SUPABASE_ANON_KEY: 'klucz publiczny Supabase',
  USDA_API_KEY: 'klucz z fdc.nal.usda.gov/api-key-signup',
  TALERZ_EMAIL: 'adres e-mail Twojego konta administratora',
  TALERZ_HASLO: 'hasło do tego konta',
};

/**
 * Sprawdzenie ustawień celowo NIE dzieje się przy wczytaniu pliku, tylko przy
 * uruchomieniu importu. Dzięki temu testy mogą korzystać z funkcji odczytu
 * bez posiadania kluczy.
 */
function sprawdzUstawienia(env) {
  const brakujace = Object.keys(WYMAGANE).filter((k) => !env[k]);
  if (brakujace.length === 0) return;

  console.error('Brak wymaganych ustawień w pliku .env.local:\n');
  for (const k of brakujace) console.error(`  ${k}  — ${WYMAGANE[k]}`);
  console.error('\nWzór znajdziesz w narzedzia/README.md');
  process.exit(1);
}

// ---------------------------------------------------------------------------
//  Odczyt wartości odżywczych z odpowiedzi USDA
// ---------------------------------------------------------------------------

/**
 * Numery składników odżywczych w bazie USDA.
 *
 * Energia bywa zapisana na trzy sposoby, zależnie od tego, kiedy powstał wpis:
 *   208 — starsze rekordy (SR Legacy)
 *   957 — energia wyliczona ogólnymi współczynnikami Atwatera
 *   958 — energia wyliczona współczynnikami właściwymi dla produktu
 * Część nowszych wpisów podaje wyłącznie 957 albo 958. Szukamy więc po kolei.
 *
 * Uwaga: numer 268 to energia w kilodżulach — celowo go nie używamy.
 */
const NUMERY = {
  kcal: ['208', '957', '958'],
  bialko: ['203'],
  tluszcz: ['204'],
  wegle: ['205', '205.2'],
  cukry: ['269', '269.3'],
};

/** Wyciąga wartość i jednostkę niezależnie od kształtu odpowiedzi USDA. */
function odczytajPole(n) {
  return {
    numer: String(n.nutrientNumber ?? n.nutrient?.number ?? ''),
    nazwa: String(n.nutrientName ?? n.nutrient?.name ?? ''),
    jednostka: String(n.unitName ?? n.nutrient?.unitName ?? '').toUpperCase(),
    wartosc: n.value ?? n.amount,
  };
}

export function odczytajSkladniki(pozycja) {
  const pola = (pozycja.foodNutrients ?? []).map(odczytajPole);
  const wartosci = {};

  for (const [nazwa, numery] of Object.entries(NUMERY)) {
    let znaleziona = null;

    for (const numer of numery) {
      const trafienie = pola.find((p) => p.numer === numer && typeof p.wartosc === 'number');
      // Energia musi być w kilokaloriach — kilodżule odrzucamy.
      if (trafienie && (nazwa !== 'kcal' || trafienie.jednostka !== 'KJ')) {
        znaleziona = trafienie.wartosc;
        break;
      }
    }

    // Ostatnia deska ratunku dla energii: dopasowanie po nazwie i jednostce.
    if (znaleziona === null && nazwa === 'kcal') {
      const trafienie = pola.find(
        (p) => /^Energy/i.test(p.nazwa) && p.jednostka === 'KCAL' && typeof p.wartosc === 'number'
      );
      if (trafienie) znaleziona = trafienie.wartosc;
    }

    wartosci[nazwa] = znaleziona === null ? null : Math.round(znaleziona * 100) / 100;
  }

  return wartosci;
}

/** Wybiera najlepsze dopasowanie: dane opracowane mają pierwszeństwo nad markowymi. */
export function wybierzNajlepszy(wyniki) {
  if (!wyniki || wyniki.length === 0) return null;
  const kolejnosc = ['Foundation', 'SR Legacy', 'Survey (FNDDS)'];
  for (const typ of kolejnosc) {
    const trafiony = wyniki.find((w) => w.dataType === typ);
    if (trafiony) return trafiony;
  }
  return wyniki[0];
}

/** Pobiera pełny rekord produktu — wyniki wyszukiwania bywają skrócone. */
async function pobierzPelny(fdcId, kluczUsda) {
  const adres = new URL(`https://api.nal.usda.gov/fdc/v1/food/${fdcId}`);
  adres.searchParams.set('api_key', kluczUsda);
  const odpowiedz = await fetch(adres);
  if (!odpowiedz.ok) return null;
  return odpowiedz.json();
}

async function szukajWUsda(zapytanie, kluczUsda) {
  const adres = new URL('https://api.nal.usda.gov/fdc/v1/foods/search');
  adres.searchParams.set('api_key', kluczUsda);
  adres.searchParams.set('query', zapytanie);
  adres.searchParams.set('dataType', 'Foundation,SR Legacy');
  adres.searchParams.set('pageSize', '5');

  const odpowiedz = await fetch(adres);
  if (!odpowiedz.ok) {
    throw new Error(`USDA odpowiedziało kodem ${odpowiedz.status}`);
  }
  const dane = await odpowiedz.json();
  return wybierzNajlepszy(dane.foods);
}

// ---------------------------------------------------------------------------
//  Główna część
// ---------------------------------------------------------------------------

async function main() {
  const env = wczytajEnv();
  sprawdzUstawienia(env);

  const lista = JSON.parse(readFileSync(join(KATALOG, 'skladniki-lista.json'), 'utf8')).skladniki;
  console.log(`Do zaimportowania: ${lista.length} składników\n`);

  const supabase = createClient(env.EXPO_PUBLIC_SUPABASE_URL, env.EXPO_PUBLIC_SUPABASE_ANON_KEY);

  if (!PODGLAD) {
    const { error } = await supabase.auth.signInWithPassword({
      email: env.TALERZ_EMAIL,
      password: env.TALERZ_HASLO,
    });
    if (error) {
      console.error('Nie udało się zalogować:', error.message);
      process.exit(1);
    }
    console.log(`Zalogowano jako ${env.TALERZ_EMAIL}\n`);
  }

  const gotowe = [];
  const pominiete = [];

  for (const [i, pozycja] of lista.entries()) {
    const numer = String(i + 1).padStart(3, ' ');
    try {
      const trafienie = await szukajWUsda(pozycja.usda, env.USDA_API_KEY);
      if (!trafienie) {
        pominiete.push(`${pozycja.nazwa} — brak wyników dla „${pozycja.usda}”`);
        console.log(`${numer}. ${pozycja.nazwa}: BRAK WYNIKÓW`);
        continue;
      }

      let w = odczytajSkladniki(trafienie);

      // Wyniki wyszukiwania bywają skrócone — wtedy sięgamy po pełny rekord.
      if (w.kcal === null || w.bialko === null) {
        const pelny = await pobierzPelny(trafienie.fdcId, env.USDA_API_KEY);
        if (pelny) w = odczytajSkladniki(pelny);
      }

      if (w.kcal === null || w.bialko === null) {
        pominiete.push(
          `${pozycja.nazwa} — brak energii lub białka w rekordzie USDA (fdcId ${trafienie.fdcId})`
        );
        console.log(`${numer}. ${pozycja.nazwa}: NIEKOMPLETNE DANE`);
        continue;
      }

      const cukryOgolem = w.cukry ?? 0;
      const cukryWolne = pozycja.cukry_wolne === 'wszystkie' ? cukryOgolem : 0;

      gotowe.push({
        nazwa: pozycja.nazwa,
        zrodlo: 'usda',
        zewnetrzny_id: String(trafienie.fdcId),
        kcal_100g: w.kcal,
        bialko_100g: w.bialko,
        tluszcz_100g: w.tluszcz ?? 0,
        wegle_100g: w.wegle ?? 0,
        cukry_ogolem_100g: cukryOgolem,
        cukry_wolne_100g: cukryWolne,
        nova: pozycja.nova ?? null,
        tagi: pozycja.tagi ?? [],
      });

      console.log(
        `${numer}. ${pozycja.nazwa}: ${w.kcal} kcal, ${w.bialko} g białka` +
          (cukryWolne > 0 ? `, ${cukryWolne} g cukrów wolnych` : '')
      );
    } catch (e) {
      pominiete.push(`${pozycja.nazwa} — ${e.message}`);
      console.log(`${numer}. ${pozycja.nazwa}: BŁĄD (${e.message})`);
    }

    // USDA ogranicza liczbę zapytań na godzinę — mała przerwa między nimi.
    await new Promise((r) => setTimeout(r, 250));
  }

  console.log(`\nPobrano: ${gotowe.length}, pominięto: ${pominiete.length}`);

  if (PODGLAD) {
    console.log('\nTryb podglądu — nic nie zapisano.');
    return;
  }

  if (gotowe.length > 0) {
    const { error } = await supabase.from('skladniki').upsert(gotowe, { onConflict: 'nazwa' });
    if (error) {
      console.error('\nZapis do bazy nie powiódł się:', error.message);
      if (error.message.includes('row-level security')) {
        console.error(
          'Prawdopodobna przyczyna: konto nie ma roli moderatora ani administratora.\n' +
            'Nadaj ją w SQL Editor — polecenie znajdziesz w supabase/README.md, krok 4.'
        );
      }
      process.exit(1);
    }
    console.log(`Zapisano w bazie: ${gotowe.length} składników.`);
  }

  if (pominiete.length > 0) {
    console.log('\nWymagają ręcznego uzupełnienia:');
    pominiete.forEach((p) => console.log('  -', p));
  }
}

// Uruchamiamy tylko przy bezpośrednim wywołaniu — żeby testy mogły importować funkcje.
if (process.argv[1] && process.argv[1].endsWith('import-usda.mjs')) {
  main().catch((e) => {
    console.error('Nieoczekiwany błąd:', e);
    process.exit(1);
  });
}
