/**
 * Wgrywa zdjęcia ze starego planera do Supabase Storage.
 *
 *     node narzedzia/wgraj-zdjecia.mjs zdjecia-planera.json --podglad
 *     node narzedzia/wgraj-zdjecia.mjs zdjecia-planera.json
 *
 * Plik wejściowy powstaje ze skryptu narzedzia/wyjmij-zdjecia.js — instrukcja
 * jest w jego nagłówku.
 *
 * Co robi
 * -------
 * Dla każdego zdjęcia szuka przepisu o tej samej nazwie. Znalezione wgrywa
 * do zasobnika i zapisuje ścieżkę w kolumnie `przepisy.zdjecie`.
 *
 * Czego NIE robi
 * --------------
 * Nie zgaduje. Zdjęcie dania, którego nie ma jeszcze w bazie, zostaje
 * pominięte i wypisane na końcu — wgrasz je, gdy zaimportujesz ten przepis.
 * Podpięcie zdjęcia „pod coś podobnego” byłoby gorsze niż brak zdjęcia,
 * bo nikt by nie zauważył pomyłki.
 */

import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient } from '@supabase/supabase-js';

const KATALOG = dirname(fileURLToPath(import.meta.url));
const KORZEN = join(KATALOG, '..');
const ZASOBNIK = 'zdjecia-przepisow';

// ---------------------------------------------------------------------------
//  Pomocnicze
// ---------------------------------------------------------------------------

function wczytajEnv() {
  const wynik = {};
  for (const nazwa of ['.env', '.env.local']) {
    try {
      for (const linia of readFileSync(join(KORZEN, nazwa), 'utf8').split('\n')) {
        const m = linia.match(/^\s*([A-Z0-9_]+)\s*=\s*(.*)\s*$/);
        if (m) wynik[m[1]] = m[2].replace(/^["']|["']$/g, '');
      }
    } catch {
      // brak pliku to nie błąd
    }
  }
  return { ...wynik, ...process.env };
}

/**
 * Nazwa pliku z nazwy dania. Storage nie lubi polskich znaków ani spacji
 * w ścieżkach — „Zupa pomidorowa z ryżem" staje się „zupa-pomidorowa-z-ryzem".
 */
export function nazwaPliku(danie, rozszerzenie) {
  const bez = danie
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/ł/g, 'l')
    .replace(/Ł/g, 'L')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
  return `${bez}.${rozszerzenie}`;
}

/** Rozkłada data URL na typ i same bajty. */
export function rozlozDataUrl(url) {
  const m = String(url).match(/^data:(image\/[a-z+]+);base64,(.+)$/i);
  if (!m) return null;
  const typ = m[1].toLowerCase();
  const rozszerzenia = { 'image/jpeg': 'jpg', 'image/png': 'png', 'image/webp': 'webp' };
  const rozszerzenie = rozszerzenia[typ];
  if (!rozszerzenie) return null;
  return { typ, rozszerzenie, dane: Buffer.from(m[2], 'base64') };
}

// ---------------------------------------------------------------------------
//  Główna część
// ---------------------------------------------------------------------------

async function main() {
  const sciezka = process.argv[2];
  const PODGLAD = process.argv.includes('--podglad');

  if (!sciezka) {
    console.error('Podaj plik ze zdjęciami, np. node narzedzia/wgraj-zdjecia.mjs zdjecia-planera.json');
    process.exit(1);
  }

  const zdjecia = JSON.parse(readFileSync(sciezka, 'utf8'));
  const nazwy = Object.keys(zdjecia);
  console.log(`W pliku: ${nazwy.length} zdjęć\n`);

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

  const { data: przepisy, error: bladPrzepisow } = await supabase.from('przepisy').select('id, nazwa');
  if (bladPrzepisow) {
    console.error('Nie udało się pobrać przepisów:', bladPrzepisow.message);
    process.exit(1);
  }
  const wBazie = new Map(przepisy.map((p) => [p.nazwa, p.id]));
  console.log(`W bazie: ${przepisy.length} przepisów\n`);

  const wgrane = [];
  const bezPrzepisu = [];
  const zepsute = [];

  for (const danie of nazwy) {
    const id = wBazie.get(danie);
    if (!id) {
      bezPrzepisu.push(danie);
      continue;
    }

    const obraz = rozlozDataUrl(zdjecia[danie]);
    if (!obraz) {
      zepsute.push(danie);
      continue;
    }

    const plik = nazwaPliku(danie, obraz.rozszerzenie);
    const kb = Math.round(obraz.dane.length / 1024);

    if (PODGLAD) {
      console.log(`  ${danie} -> ${plik} (${kb} kB)`);
      wgrane.push(danie);
      continue;
    }

    const { error: bladWysylki } = await supabase.storage
      .from(ZASOBNIK)
      .upload(plik, obraz.dane, { contentType: obraz.typ, upsert: true });

    if (bladWysylki) {
      console.error(`  BŁĄD ${danie}: ${bladWysylki.message}`);
      continue;
    }

    const { error: bladZapisu } = await supabase.from('przepisy').update({ zdjecie: plik }).eq('id', id);
    if (bladZapisu) {
      console.error(`  BŁĄD ${danie} (zapis ścieżki): ${bladZapisu.message}`);
      continue;
    }

    console.log(`  ok  ${danie} -> ${plik} (${kb} kB)`);
    wgrane.push(danie);
  }

  console.log(`\n${PODGLAD ? 'Do wgrania' : 'Wgrano'}: ${wgrane.length}`);

  if (bezPrzepisu.length) {
    console.log(`\nNie ma jeszcze takich przepisów w bazie (${bezPrzepisu.length}) — zdjęcia czekają:`);
    bezPrzepisu.forEach((n) => console.log('  -', n));
    console.log('\nPo zaimportowaniu tych dań uruchom skrypt ponownie na tym samym pliku.');
  }

  if (zepsute.length) {
    console.log(`\nNieczytelne zdjęcia (${zepsute.length}):`);
    zepsute.forEach((n) => console.log('  -', n));
  }

  if (PODGLAD) console.log('\nTo był podgląd — nic nie zostało wysłane.');
}

if (process.argv[1] && process.argv[1].endsWith('wgraj-zdjecia.mjs')) {
  main();
}
