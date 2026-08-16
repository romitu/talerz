/**
 * Import składników z USDA FoodData Central do bazy Talerza.
 *
 *     node narzedzia/import-usda.mjs            # import
 *     node narzedzia/import-usda.mjs --podglad  # tylko pokaż, nic nie zapisuj
 *     node narzedzia/import-usda.mjs --tylko=por,imbir   # tylko wskazane pozycje
 *
 * `--tylko` porównuje fragment nazwy polskiej, bez względu na wielkość liter.
 * Przydaje się przy dopisywaniu kilku składników, żeby nie odpytywać USDA
 * o wszystkie osiemdziesiąt i nie wyczerpać dziennego limitu zapytań.
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

/** Fragmenty nazw z `--tylko=...`; pusta tablica oznacza „bierz wszystko”. */
export function fragmentyZArgumentow(argumenty) {
  const arg = argumenty.find((a) => a.startsWith('--tylko='));
  if (!arg) return [];
  return arg
    .slice('--tylko='.length)
    .split(',')
    .map((x) => x.trim().toLowerCase())
    .filter(Boolean);
}

/** Zostawia pozycje, których nazwa zawiera którykolwiek z fragmentów. */
export function zawezLise(lista, fragmenty) {
  if (fragmenty.length === 0) return lista;
  return lista.filter((p) => {
    const nazwa = String(p.nazwa).toLowerCase();
    return fragmenty.some((f) => nazwa.includes(f));
  });
}

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
  blonnik: ['291'],
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


/**
 * Czy tekst zawiera dane słowo — dopasowanie od początku wyrazu, nie fragmentu.
 *
 * To rozróżnienie jest krytyczne. Zwykłe szukanie fragmentu sprawiało, że
 * wykluczenie „cooked" odrzucało „Quinoa, UNCOOKED", a „sweetened" odrzucało
 * „Cocoa, UNSWEETENED" — czyli dokładnie te produkty, o które chodziło.
 *
 * Dopasowanie od początku wyrazu zachowuje przy tym możliwość podawania
 * rdzeni: „anchov" nadal trafia w „anchovies".
 */
export function zawieraSlowo(tekst, slowo) {
  const bezpieczne = String(slowo).replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  return new RegExp(`\\b${bezpieczne}`, 'i').test(String(tekst));
}

/** O ile procent wynik może odbiegać od wartości orientacyjnej, zanim go odrzucimy. */
export const DOPUSZCZALNE_ODCHYLENIE = 0.3;

/**
 * Sprawdza, czy dopasowanie jest wiarygodne.
 *
 * Wyszukiwarka USDA przy nietrafionym zapytaniu zwraca cokolwiek podobnego —
 * dla „pumpkin, raw” potrafi podać pestki dyni, dla „oats” olej. Różnica
 * kaloryczności wyłapuje takie pomyłki, zanim trafią do bazy.
 */
export function wiarygodne(kcalOtrzymane, kcalOczekiwane) {
  if (!kcalOczekiwane) return { ok: true };
  const odchylenie = Math.abs(kcalOtrzymane - kcalOczekiwane) / kcalOczekiwane;
  return {
    ok: odchylenie <= DOPUSZCZALNE_ODCHYLENIE,
    odchylenie: Math.round(odchylenie * 100),
  };
}

/**
 * Wybiera najlepsze dopasowanie spośród wyników wyszukiwania.
 *
 * Sama zgodność kaloryczności nie wystarcza — „Anchovies” mają tyle samo kalorii
 * co sardynki, a „Sweet potatoes” tyle samo co ziemniaki. Dlatego najpierw
 * odsiewamy po słowach, które w nazwie muszą (albo nie mogą) wystąpić,
 * a dopiero potem wybieramy najbliższy kalorycznie.
 *
 * @param wyniki  lista z USDA
 * @param opcje   { slowa, wyklucz, kcalOkolo }
 */
export function wybierzNajlepszy(wyniki, opcje = {}) {
  if (!wyniki || wyniki.length === 0) return null;

  const { slowa = [], wyklucz = [], kcalOkolo } = opcje;

  const pasuje = (w) => {
    const opis = String(w.description ?? '');
    if (slowa.length > 0 && !slowa.every((s) => zawieraSlowo(opis, s))) return false;
    if (wyklucz.some((s) => zawieraSlowo(opis, s))) return false;
    return true;
  };

  const kandydaci = wyniki.filter(pasuje);
  if (kandydaci.length === 0) return null;

  // Bez wartości orientacyjnej trzymamy się kolejności: dane opracowane przed resztą.
  if (!kcalOkolo) {
    const kolejnosc = ['Foundation', 'SR Legacy', 'Survey (FNDDS)'];
    for (const typ of kolejnosc) {
      const trafiony = kandydaci.find((w) => w.dataType === typ);
      if (trafiony) return trafiony;
    }
    return kandydaci[0];
  }

  // Z wartością orientacyjną wybieramy najbliższy kalorycznie.
  let najlepszy = null;
  let najmniejszaRoznica = Infinity;

  for (const kandydat of kandydaci) {
    const kcal = odczytajSkladniki(kandydat).kcal;
    if (kcal === null) continue;
    const roznica = Math.abs(kcal - kcalOkolo) / kcalOkolo;
    if (roznica < najmniejszaRoznica) {
      najmniejszaRoznica = roznica;
      najlepszy = kandydat;
    }
  }

  return najlepszy ?? kandydaci[0];
}

/** Krótkie zestawienie kandydatów — pomaga wybrać właściwy fdcId po odrzuceniu. */
export function opiszKandydatow(wyniki, ile = 5) {
  return (wyniki ?? []).slice(0, ile).map((w) => {
    const kcal = odczytajSkladniki(w).kcal;
    return `      fdcId ${w.fdcId} — ${w.description} (${kcal ?? '?'} kcal)`;
  });
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
  adres.searchParams.set('pageSize', '25');

  const odpowiedz = await fetch(adres);
  if (!odpowiedz.ok) {
    throw new Error(`USDA odpowiedziało kodem ${odpowiedz.status}`);
  }
  const dane = await odpowiedz.json();
  return dane.foods ?? [];
}

// ---------------------------------------------------------------------------
//  Główna część
// ---------------------------------------------------------------------------

async function main() {
  const env = wczytajEnv();
  sprawdzUstawienia(env);

  const wszystkie = JSON.parse(readFileSync(join(KATALOG, 'skladniki-lista.json'), 'utf8')).skladniki;

  const fragmenty = fragmentyZArgumentow(process.argv);
  const lista = zawezLise(wszystkie, fragmenty);

  if (fragmenty.length > 0) {
    console.log(`Zawężono do „${fragmenty.join(', ')}” — ${lista.length} z ${wszystkie.length} pozycji.`);
    if (lista.length === 0) {
      console.error('Żadna nazwa nie pasuje. Sprawdź pisownię.');
      process.exit(1);
    }
    console.log('');
  }

  // Słowo wykluczone nie może występować w samym zapytaniu — to sprzeczność,
  // przez którą właściwy produkt zostałby odrzucony.
  const sprzecznosci = [];
  for (const pozycja of lista) {
    for (const slowo of pozycja.wyklucz ?? []) {
      if (zawieraSlowo(pozycja.usda, slowo)) {
        sprzecznosci.push(`${pozycja.nazwa}: wykluczone „${slowo}” występuje w zapytaniu „${pozycja.usda}”`);
      }
    }
  }
  if (sprzecznosci.length > 0) {
    console.log('Sprzeczności w liście — te pozycje na pewno się nie znajdą:');
    sprzecznosci.forEach((x) => console.log('  !', x));
    console.log('');
  }

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
      let trafienie = null;
      let wszystkie = [];

      if (pozycja.fdcId) {
        trafienie = await pobierzPelny(pozycja.fdcId, env.USDA_API_KEY);
      } else {
        wszystkie = await szukajWUsda(pozycja.usda, env.USDA_API_KEY);
        trafienie = wybierzNajlepszy(wszystkie, {
          slowa: pozycja.slowa,
          wyklucz: pozycja.wyklucz,
          kcalOkolo: pozycja.kcal_okolo,
        });
      }

      if (!trafienie) {
        pominiete.push(
          `${pozycja.nazwa} — żaden wynik nie spełnia warunków\n` +
            opiszKandydatow(wszystkie).join('\n')
        );
        console.log(`${numer}. ${pozycja.nazwa}: BRAK PASUJĄCYCH WYNIKÓW`);
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

      const opisUsda = trafienie.description ?? '(bez nazwy)';
      const ocena = wiarygodne(w.kcal, pozycja.kcal_okolo);

      if (!ocena.ok) {
        const kandydaci = opiszKandydatow(wszystkie);
        pominiete.push(
          `${pozycja.nazwa} — dopasowano „${opisUsda}” (fdcId ${trafienie.fdcId}), ` +
            `${w.kcal} kcal zamiast oczekiwanych około ${pozycja.kcal_okolo} ` +
            `(różnica ${ocena.odchylenie}%)` +
            (kandydaci.length > 0 ? `\n    inne wyniki:\n${kandydaci.join('\n')}` : '')
        );
        console.log(
          `${numer}. ${pozycja.nazwa}: ODRZUCONE — dopasowano „${opisUsda}”, ` +
            `${w.kcal} kcal zamiast ~${pozycja.kcal_okolo}`
        );
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
        // Błonnik zawiera się w węglowodanach — baza tego pilnuje, więc przycinamy.
        blonnik_100g: Math.min(w.blonnik ?? 0, w.wegle ?? 0),
        cukry_ogolem_100g: cukryOgolem,
        cukry_wolne_100g: cukryWolne,
        nova: pozycja.nova ?? null,
        tagi: pozycja.tagi ?? [],
      });

      console.log(
        `${numer}. ${pozycja.nazwa}: ${w.kcal} kcal, ${w.bialko} g białka` +
          (cukryWolne > 0 ? `, ${cukryWolne} g cukrów wolnych` : '') +
          `  ← ${opisUsda}`
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
    console.log('\nWymagają poprawki w narzedzia/skladniki-lista.json:');
    pominiete.forEach((p) => console.log('  -', p));
    console.log(
      '\nPopraw pole „usda” albo wpisz „fdcId” właściwego produktu, ' +
        'a potem uruchom import ponownie.'
    );
  }
}

// Uruchamiamy tylko przy bezpośrednim wywołaniu — żeby testy mogły importować funkcje.
if (process.argv[1] && process.argv[1].endsWith('import-usda.mjs')) {
  main().catch((e) => {
    console.error('Nieoczekiwany błąd:', e);
    process.exit(1);
  });
}
