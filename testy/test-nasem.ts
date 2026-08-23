/**
 * Testy równań NASEM (2023) na zapotrzebowanie energetyczne.
 *
 *     node --experimental-strip-types testy/test-nasem.ts
 *
 * Wartości oczekiwane policzone ręcznie ze wzorów w tabeli 5-5 raportu
 * NASEM, żeby test wyłapał literówkę we współczynnikach w lib/nasem.ts,
 * a nie tylko potwierdzał sam siebie.
 */

import { calkowityWydatekNASEM, celZywieniowyNASEM } from '../lib/nasem.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, otrzymano: unknown, oczekiwano: unknown) {
  const a = JSON.stringify(otrzymano);
  const b = JSON.stringify(oczekiwano);
  if (a === b) przeszlo.push(`${nazwa} = ${a}`);
  else nieprzeszlo.push(`${nazwa}: otrzymano ${a}, oczekiwano ${b}`);
}

// --- TEE, mężczyzna, 59 lat, 189 cm, 90 kg ---

// aktywny: 1004,82 - 10,83*59 + 6,52*189 + 15,91*90
// = 1004,82 - 638,97 + 1232,28 + 1431,9 = 3030,03
sprawdz('TEE NASEM (M, 90 kg, 189 cm, 59 lat, aktywny)',
  calkowityWydatekNASEM('M', 59, 189, 90, 'aktywny'), 3030);

// mało_aktywny: 581,47 - 10,83*59 + 8,30*189 + 14,94*90
// = 581,47 - 638,97 + 1568,7 + 1344,6 = 2855,8
sprawdz('TEE NASEM (M, 90 kg, 189 cm, 59 lat, mało aktywny)',
  calkowityWydatekNASEM('M', 59, 189, 90, 'malo_aktywny'), 2856);

// --- TEE, kobieta, 30 lat, 165 cm, 60 kg ---

// nieaktywny: 584,90 - 7,01*30 + 5,72*165 + 11,71*60
// = 584,90 - 210,3 + 943,8 + 702,6 = 2021
sprawdz('TEE NASEM (K, 60 kg, 165 cm, 30 lat, nieaktywny)',
  calkowityWydatekNASEM('K', 30, 165, 60, 'nieaktywny'), 2021);

// --- cel z podziałem makro ---
// utrzymanie: kcal = TEE = 2021, domyślny podział 25/30/45
// białko: 2021*0,25/4 = 126,3 -> 126
// tłuszcz: 2021*0,30/9 = 67,4 -> 67
// węgle:  2021*0,45/4 = 227,4 -> 227
sprawdz('cel NASEM utrzymanie (K, 60 kg, 165 cm, 30 lat, nieaktywny)',
  celZywieniowyNASEM('K', 30, 165, 60, 'nieaktywny', 'utrzymanie'),
  { kcal: 2021, bialko: 126, tluszcz: 67, wegle: 227 });

// redukcja: TEE - 400 = 1621, nie schodzi poniżej BMR Mifflina (1320)
sprawdz('cel NASEM redukcja (K, 60 kg, 165 cm, 30 lat, nieaktywny)',
  celZywieniowyNASEM('K', 30, 165, 60, 'nieaktywny', 'redukcja').kcal, 1621);

// =============================================================

console.log('=== PRZESZŁO ===');
przeszlo.forEach((x) => console.log('  +', x));

if (nieprzeszlo.length > 0) {
  console.log('\n=== NIE PRZESZŁO ===');
  nieprzeszlo.forEach((x) => console.log('  -', x));
  console.log(`\nNIEPOWODZENIE: ${nieprzeszlo.length} z ${przeszlo.length + nieprzeszlo.length}.`);
  process.exit(1);
}

console.log(`\nWszystkie ${przeszlo.length} kontroli zakończone powodzeniem.`);
