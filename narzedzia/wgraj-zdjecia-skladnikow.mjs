/**
 * Wgrywa zdjęcia składników z folderu do Supabase Storage.
 *
 *     node narzedzia/wgraj-zdjecia-skladnikow.mjs --podglad
 *     node narzedzia/wgraj-zdjecia-skladnikow.mjs
 *
 * Skąd bierze pliki
 * -----------------
 *     zdjecia-skladnikow/
 *       AI/       ← grafiki wygenerowane   → skladniki.zdjecie_zrodlo = 'ai'
 *       wlasne/   ← zdjęcia zrobione samemu → skladniki.zdjecie_zrodlo = 'wlasne'
 *
 * Nazwa pliku to nazwa składnika, opcjonalnie z numerem z przodu:
 * „025 - Cebula, surowa.png”. Numer jest pomijany.
 *
 * Dopasowanie
 * -----------
 * Najpierw dokładne, potem „luźne” — bez wielkich liter, polskich znaków
 * i interpunkcji („cebula surowa.png” też trafi w „Cebula, surowa.”).
 * Luźne dopasowanie musi być JEDNOZNACZNE: gdy pasują dwa składniki, plik
 * zostaje pominięty. Niedopasowane pliki trafiają do raportu z podpowiedzią
 * najbliższej nazwy — ale podpowiedź NIE jest wgrywana. Zdjęcie przypięte
 * „pod coś podobnego” byłoby gorsze niż brak zdjęcia, bo nikt by nie
 * zauważył pomyłki.
 *
 * Gdy ten sam składnik ma plik w obu folderach, wygrywa `wlasne/`.
 *
 * Co robi z plikiem
 * -----------------
 * Przycina do kwadratu 480×480 i zapisuje jako JPG (~70 kB zamiast ~450 kB
 * PNG). Ścieżka w zasobniku to id składnika + skrót zawartości, np.
 * „3f2a…-9c1e04d2.jpg” — zmiana nazwy składnika nie gubi zdjęcia, a podmiana
 * zdjęcia daje nową ścieżkę, więc telefon nie pokaże starego z pamięci.
 * Poprzedni plik składnika jest kasowany.
 *
 * Plik identyczny z już wgranym jest pomijany — skrypt można puszczać
 * wielokrotnie, np. po dorzuceniu kilku zdjęć.
 */

import { createHash } from 'node:crypto';
import { existsSync, readdirSync, readFileSync } from 'node:fs';
import { dirname, extname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createRequire } from 'node:module';

import { createClient } from '@supabase/supabase-js';

const require = createRequire(import.meta.url);
const Jimp = require('jimp-compact');

const KATALOG = dirname(fileURLToPath(import.meta.url));
const KORZEN = join(KATALOG, '..');
const FOLDER = join(KORZEN, 'zdjecia-skladnikow');
const ZASOBNIK = 'zdjecia-skladnikow';
const BOK = 480;
const JAKOSC = 80;
const ROZSZERZENIA = new Set(['.png', '.jpg', '.jpeg', '.webp']);

// Kolejność ma znaczenie: późniejszy folder nadpisuje wcześniejszy.
const ZRODLA = [
  { folder: 'AI', zrodlo: 'ai' },
  { folder: 'wlasne', zrodlo: 'wlasne' },
];

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

/** „025 - Cebula, surowa.png” → „Cebula, surowa”. Sam numer („024.png”) → pusty napis. */
export function nazwaZPliku(plik) {
  return plik
    .slice(0, -extname(plik).length)
    .replace(/^\s*\d+\s*(-\s*)?/, '')
    .trim();
}

/** Klucz luźnego porównania: bez wielkości liter, ogonków i interpunkcji. */
export function klucz(nazwa) {
  return nazwa
    .normalize('NFD')
    .replace(/[̀-ͯ]/g, '')
    .replace(/ł/g, 'l')
    .replace(/Ł/g, 'L')
    .toLowerCase()
    .replace(/[^a-z0-9%]+/g, ' ')
    .trim();
}

function odleglosc(a, b) {
  const d = Array.from({ length: b.length + 1 }, (_, i) => i);
  for (let i = 1; i <= a.length; i++) {
    let poprzednia = d[0];
    d[0] = i;
    for (let j = 1; j <= b.length; j++) {
      const tmp = d[j];
      d[j] = Math.min(d[j] + 1, d[j - 1] + 1, poprzednia + (a[i - 1] === b[j - 1] ? 0 : 1));
      poprzednia = tmp;
    }
  }
  return d[b.length];
}

function najblizsza(nazwa, skladniki) {
  const k = klucz(nazwa);
  let najlepsza = null;
  for (const s of skladniki) {
    const o = odleglosc(k, klucz(s.nazwa));
    if (!najlepsza || o < najlepsza.o) najlepsza = { o, nazwa: s.nazwa };
  }
  return najlepsza && najlepsza.o <= Math.max(3, k.length / 3) ? najlepsza.nazwa : null;
}

async function naJpg(sciezka) {
  const obraz = await Jimp.read(sciezka);
  obraz.background(0xffffffff).cover(BOK, BOK).quality(JAKOSC);
  return obraz.getBufferAsync(Jimp.MIME_JPEG);
}

// ---------------------------------------------------------------------------
//  Główna część
// ---------------------------------------------------------------------------

async function main() {
  const PODGLAD = process.argv.includes('--podglad');

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

  // W podglądzie kolumny zdjęcia mogą jeszcze nie istnieć (migracja 0045).
  let { data: skladniki, error } = await supabase.from('skladniki').select('id, nazwa, zdjecie, zdjecie_zrodlo');
  if (error && PODGLAD) {
    ({ data: skladniki, error } = await supabase.from('skladniki').select('id, nazwa'));
    if (!error) console.log('(Kolumn zdjęcia jeszcze nie ma — uruchom migrację 0045 przed wgraniem.)\n');
  }
  if (error) {
    console.error('Nie udało się pobrać składników:', error.message);
    process.exit(1);
  }

  const poNazwie = new Map(skladniki.map((s) => [s.nazwa, s]));
  const poKluczu = new Map();
  for (const s of skladniki) {
    const k = klucz(s.nazwa);
    poKluczu.set(k, poKluczu.has(k) ? null : s); // null = niejednoznaczny
  }

  // --- zbieranie plików ----------------------------------------------------
  const przypisania = new Map(); // skladnik_id → { skladnik, plik, zrodlo, luzne }
  const bezNazwy = [];
  const niedopasowane = [];
  const niejednoznaczne = [];

  for (const { folder, zrodlo } of ZRODLA) {
    const katalog = join(FOLDER, folder);
    if (!existsSync(katalog)) continue;
    for (const plik of readdirSync(katalog).sort()) {
      if (!ROZSZERZENIA.has(extname(plik).toLowerCase())) continue;
      const opis = `${folder}/${plik}`;
      const nazwa = nazwaZPliku(plik);
      if (!nazwa) {
        bezNazwy.push(opis);
        continue;
      }
      let skladnik = poNazwie.get(nazwa) ?? poNazwie.get(nazwa + '.');
      let luzne = false;
      if (!skladnik) {
        const k = klucz(nazwa);
        if (poKluczu.get(k) === null) {
          niejednoznaczne.push(opis);
          continue;
        }
        skladnik = poKluczu.get(k);
        luzne = true;
      }
      if (!skladnik) {
        niedopasowane.push({ opis, podpowiedz: najblizsza(nazwa, skladniki) });
        continue;
      }
      przypisania.set(skladnik.id, { skladnik, plik: join(katalog, plik), opis, zrodlo, luzne });
    }
  }

  // --- wgrywanie -----------------------------------------------------------
  let wgrane = 0;
  let bezZmian = 0;
  const bledy = [];

  for (const { skladnik, plik, opis, zrodlo, luzne } of przypisania.values()) {
    const dane = await naJpg(plik);
    const skrot = createHash('sha1').update(dane).digest('hex').slice(0, 8);
    const sciezka = `${skladnik.id}-${skrot}.jpg`;
    const znak = zrodlo === 'ai' ? 'AI' : 'własne';
    const uwaga = luzne ? `  (luźno: „${skladnik.nazwa}”)` : '';

    if (skladnik.zdjecie === sciezka && skladnik.zdjecie_zrodlo === zrodlo) {
      bezZmian++;
      continue;
    }

    if (PODGLAD) {
      console.log(`  ${znak.padEnd(6)} ${opis} → ${Math.round(dane.length / 1024)} kB${uwaga}`);
      wgrane++;
      continue;
    }

    const { error: bladWysylki } = await supabase.storage
      .from(ZASOBNIK)
      .upload(sciezka, dane, { contentType: 'image/jpeg', upsert: true, cacheControl: '31536000' });
    if (bladWysylki) {
      bledy.push(`${opis}: ${bladWysylki.message}`);
      continue;
    }

    const { error: bladZapisu } = await supabase
      .from('skladniki')
      .update({ zdjecie: sciezka, zdjecie_zrodlo: zrodlo })
      .eq('id', skladnik.id);
    if (bladZapisu) {
      bledy.push(`${opis} (zapis w bazie): ${bladZapisu.message}`);
      continue;
    }

    if (skladnik.zdjecie && skladnik.zdjecie !== sciezka) {
      await supabase.storage.from(ZASOBNIK).remove([skladnik.zdjecie]);
    }

    console.log(`  ok  ${znak.padEnd(6)} ${opis}${uwaga}`);
    wgrane++;
  }

  // --- raport --------------------------------------------------------------
  const zeZdjeciem = new Set([
    ...przypisania.keys(),
    ...skladniki.filter((s) => s.zdjecie).map((s) => s.id),
  ]);
  const bezZdjecia = skladniki.filter((s) => !zeZdjeciem.has(s.id)).map((s) => s.nazwa).sort((a, b) => a.localeCompare(b, 'pl'));

  console.log(`\n${PODGLAD ? 'Do wgrania' : 'Wgrano'}: ${wgrane}`);
  if (bezZmian) console.log(`Bez zmian (już w bazie): ${bezZmian}`);

  if (niedopasowane.length) {
    console.log(`\nNie pasuje do żadnego składnika (${niedopasowane.length}) — popraw nazwę pliku:`);
    niedopasowane.forEach(({ opis, podpowiedz }) =>
      console.log(`  - ${opis}${podpowiedz ? `   → może „${podpowiedz}”?` : ''}`),
    );
  }
  if (niejednoznaczne.length) {
    console.log(`\nPasuje do kilku składników naraz (${niejednoznaczne.length}) — wpisz pełną nazwę:`);
    niejednoznaczne.forEach((o) => console.log('  -', o));
  }
  if (bezNazwy.length) {
    console.log(`\nPlik bez nazwy składnika (${bezNazwy.length}):`);
    bezNazwy.forEach((o) => console.log('  -', o));
  }
  if (bledy.length) {
    console.log(`\nBłędy (${bledy.length}):`);
    bledy.forEach((b) => console.log('  -', b));
  }
  console.log(`\nSkładniki bez zdjęcia (${bezZdjecia.length} z ${skladniki.length}):`);
  bezZdjecia.forEach((n) => console.log('  -', n));

  if (PODGLAD) console.log('\nTo był podgląd — nic nie zostało wysłane.');
}

if (process.argv[1] && process.argv[1].endsWith('wgraj-zdjecia-skladnikow.mjs')) {
  main();
}
