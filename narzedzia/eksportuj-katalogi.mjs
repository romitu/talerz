/**
 * Wyjmuje z bazy katalogi składników i sprzętu do plików JSON — jako ściągawkę
 * dokładnych nazw przy poprawianiu przepisów w narzedzia/przepisy-ai/.
 *
 *     node narzedzia/eksportuj-katalogi.mjs
 *
 * Wynik (nadpisywany przy każdym uruchomieniu):
 *     narzedzia/skladniki/skladniki.json
 *     narzedzia/potrzebny sprzet/potrzebny sprzet.json   — lista do „POTRZEBNY SPRZĘT”
 *
 * Pliki są tylko do odczytu — import przepisów niczego do katalogów nie dopisuje.
 */

import { mkdirSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { createClient } from '@supabase/supabase-js';

import { wczytajEnv } from './import-usda.mjs';

const KATALOG = dirname(fileURLToPath(import.meta.url));

// Bez id, dat i zdjęć — przy pisaniu przepisu liczy się nazwa i to,
// co wpływa na import (masa sztuki dla jednostki „szt”).
const POLA_SKLADNIKOW =
  'nazwa, tagi, rola, mozna_dzielic, masa_sztuki_g, gramatura_opakowania_g, kcal_100g, bialko_100g, ' +
  'tluszcz_100g, wegle_100g, blonnik_100g, cukry_ogolem_100g, cukry_wolne_100g, nova, zrodlo';

async function main() {
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

  const [{ data: skladniki, error: b1 }, { data: sprzet, error: b2 }] = await Promise.all([
    supabase.from('skladniki').select(POLA_SKLADNIKOW).order('nazwa').range(0, 9999),
    supabase.from('sprzet').select('nazwa, rodzaj').order('rodzaj').order('nazwa'),
  ]);
  if (b1 || b2) {
    console.error('Nie udało się pobrać katalogów:', (b1 ?? b2).message);
    process.exit(1);
  }

  for (const [plik, dane] of [
    [join(KATALOG, 'skladniki', 'skladniki.json'), skladniki],
    [join(KATALOG, 'potrzebny sprzet', 'potrzebny sprzet.json'), sprzet],
  ]) {
    mkdirSync(dirname(plik), { recursive: true });
    writeFileSync(plik, JSON.stringify(dane, null, 2) + '\n');
    console.log(`Zapisano: ${plik} (${dane.length})`);
  }
}

main();
