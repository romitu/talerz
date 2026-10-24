/**
 * Wyjmuje przepis z bazy do pliku JSON w formacie narzedzia/przepisy-ai/
 * — do poprawienia na zewnątrz i wgrania z powrotem przez generuj-import-ai.mjs.
 *
 *     node narzedzia/eksportuj-przepis.mjs "Zupa - Tajskie żółte curry z kurczakiem"
 *     node narzedzia/eksportuj-przepis.mjs --wszystkie
 *     node narzedzia/eksportuj-przepis.mjs --wszystkie --nadpisz
 *
 * Plik ląduje w narzedzia/przepisy-ai/<nazwa>.json. Istniejący plik nie jest
 * nadpisywany — trzeba go najpierw usunąć albo przenieść, albo dodać
 * `--nadpisz` (wtedy co zmieniło się w bazie, pokaże `git diff`).
 *
 * Logowanie jak w import-usda.mjs: TALERZ_EMAIL i TALERZ_HASLO z .env.local.
 */

import { existsSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient } from '@supabase/supabase-js';

import { sprawdzPrzepis } from './generuj-import-ai.mjs';
import { wczytajEnv } from './import-usda.mjs';

const FOLDER = join(dirname(fileURLToPath(import.meta.url)), 'przepisy-ai');
const NADPISZ = process.argv.includes('--nadpisz');

/** Pomija puste pola nieobowiązkowe, żeby JSON był czytelny. */
const jesli = (pole, wartosc) => (wartosc === null || wartosc === undefined || wartosc === '' ? {} : { [pole]: wartosc });

export function doPliku(p, skladniki, etapy) {
  const waga = p.porcjowanie === 'waga';
  return {
    nazwa: p.nazwa,
    ...jesli('opis', p.opis),
    pory: p.pory ?? [],
    kuchnie: p.kuchnie ?? [],
    ...jesli('rodzaje', p.rodzaje),
    porcjowanie: p.porcjowanie,
    ...(waga ? { porcja_g: p.porcja_g } : { porcje: p.porcje }),
    liczba_porcji_bazowych: p.liczba_porcji_bazowych,
    trwalosc_dni: p.trwalosc_dni,
    czas_przygotowania_min: p.czas_przygotowania_min,
    czas_obrobki_min: p.czas_obrobki_min,
    sprzet: p.sprzet ?? [],
    ...jesli('przechowywanie', p.przechowywanie),
    mozna_mrozic: p.mozna_mrozic,
    ...jesli('ratunek', p.ratunek),
    skladniki: skladniki.map((s) => ({
      nazwa: s.skladniki.nazwa,
      ilosc: Number(s.ilosc),
      jednostka: s.jednostka,
      ...jesli('stan', s.stan),
      ...jesli('zamiennik', s.zamiennik),
    })),
    etapy: etapy.map((e) => ({
      nazwa: e.nazwa,
      ...jesli('minuty', e.minuty),
      kroki: [...e.kroki]
        .sort((a, b) => a.kolejnosc - b.kolejnosc)
        .map((k) => ({ tresc: k.tresc, ...jesli('sygnal', k.sygnal), ...(k.uwaga ? { uwaga: true } : {}) })),
    })),
  };
}

/** Nazwa pliku bez znaków, których Windows nie przyjmie. */
const nazwaPliku = (nazwa) => `${nazwa.replace(/[<>:"/\\|?*]/g, '-').trim()}.json`;

/** Zapisuje jeden przepis. Zwraca 'zapisany' albo 'istnieje'. */
async function eksportuj(supabase, p) {
  const sciezka = join(FOLDER, nazwaPliku(p.nazwa));
  if (!NADPISZ && existsSync(sciezka)) return 'istnieje';

  const [{ data: skladniki, error: b1 }, { data: etapy, error: b2 }] = await Promise.all([
    supabase.from('przepis_skladniki').select('*, skladniki(nazwa)').eq('przepis_id', p.id).order('kolejnosc'),
    supabase.from('etapy').select('*, kroki(*)').eq('przepis_id', p.id).order('kolejnosc'),
  ]);
  if (b1 || b2) throw new Error(`${p.nazwa}: nie udało się pobrać składników albo etapów: ${(b1 ?? b2).message}`);

  const plik = doPliku(p, skladniki, etapy);
  const bledy = sprawdzPrzepis(structuredClone(plik));
  if (bledy.length > 0) {
    console.log(`Uwaga — „${p.nazwa}” w tej postaci import nie przyjmie, popraw przy edycji:`);
    bledy.forEach((b) => console.log('  !', b));
  }

  writeFileSync(sciezka, JSON.stringify(plik, null, 2) + '\n');
  return 'zapisany';
}

async function main() {
  const wszystkie = process.argv.includes('--wszystkie');
  const nazwa = process.argv.slice(2).find((a) => !a.startsWith('--'));
  if (!nazwa && !wszystkie) {
    console.error('Podaj nazwę przepisu: node narzedzia/eksportuj-przepis.mjs "Nazwa"');
    console.error('albo wszystkie naraz:  node narzedzia/eksportuj-przepis.mjs --wszystkie [--nadpisz]');
    process.exit(1);
  }

  const env = wczytajEnv();
  for (const k of ['EXPO_PUBLIC_SUPABASE_URL', 'EXPO_PUBLIC_SUPABASE_ANON_KEY', 'TALERZ_EMAIL', 'TALERZ_HASLO']) {
    if (!env[k]) {
      console.error(`Brak ${k} w .env.local — wzór w narzedzia/README.md`);
      process.exit(1);
    }
  }

  const supabase = createClient(env.EXPO_PUBLIC_SUPABASE_URL, env.EXPO_PUBLIC_SUPABASE_ANON_KEY);
  const { error: bladLogowania } = await supabase.auth.signInWithPassword({
    email: env.TALERZ_EMAIL,
    password: env.TALERZ_HASLO,
  });
  if (bladLogowania) {
    console.error('Nie udało się zalogować:', bladLogowania.message);
    process.exit(1);
  }

  let zapytanie = supabase.from('przepisy').select('*').order('nazwa');
  if (!wszystkie) zapytanie = zapytanie.ilike('nazwa', nazwa);
  const { data: znalezione, error: bladPrzepisu } = await zapytanie;
  if (bladPrzepisu) {
    console.error('Nie udało się pobrać przepisu:', bladPrzepisu.message);
    process.exit(1);
  }
  if (!wszystkie && znalezione.length !== 1) {
    console.error(`Przepisów o nazwie „${nazwa}”: ${znalezione.length}. Potrzebny dokładnie jeden.`);
    process.exit(1);
  }

  const pominiete = [];
  let zapisanych = 0;
  for (const p of znalezione) {
    if ((await eksportuj(supabase, p)) === 'istnieje') pominiete.push(p.nazwa);
    else zapisanych++;
  }

  console.log(`Zapisano: ${zapisanych} w ${FOLDER}`);
  if (pominiete.length > 0) {
    console.log(`Pominięte, bo plik już istnieje (${pominiete.length}) — usuń albo przenieś, żeby wyjąć ponownie:`);
    pominiete.forEach((n) => console.log('  -', n));
  }
}

main();
