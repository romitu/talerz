/**
 * Testy wyliczeń żywieniowych.
 *
 *     node --experimental-strip-types testy/test-zywienie.ts
 *
 * Sprawdzają wzory na znanych przypadkach oraz to, czy blokady bezpieczeństwa
 * zadziałają tam, gdzie powinny — i NIE zadziałają tam, gdzie nie powinny.
 */

import {
  dataUrodzeniaZWieku,
  kcalZMakro,
  ocenaBlonnika,
  podpowiedzBlonnika,
  oceniaCele,
  podpowiedzProguBialka,
  przemianaPodstawowa,
  udzialyProcentowe,
  wiekZDaty,
  wskazowkaWodna,
} from '../lib/zywienie.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, otrzymano: unknown, oczekiwano: unknown) {
  const a = JSON.stringify(otrzymano);
  const b = JSON.stringify(oczekiwano);
  if (a === b) przeszlo.push(`${nazwa} = ${a}`);
  else nieprzeszlo.push(`${nazwa}: otrzymano ${a}, oczekiwano ${b}`);
}

// --- przemiana podstawowa ---
// Roman: mężczyzna, 90 kg, 189 cm, 59 lat
// 10*90 + 6,25*189 - 5*59 + 5 = 900 + 1181,25 - 295 + 5 = 1791,25
sprawdz('przemiana podstawowa (M, 90 kg, 189 cm, 59 lat)',
  przemianaPodstawowa('M', 90, 189, 59), 1791);

// Kobieta: 60 kg, 165 cm, 30 lat
// 600 + 1031,25 - 150 - 161 = 1320,25
sprawdz('przemiana podstawowa (K, 60 kg, 165 cm, 30 lat)',
  przemianaPodstawowa('K', 60, 165, 30), 1320);

// --- kalorie z makro ---
// 142 g białka x4 + 82 g tłuszczu x9 + 246 g węglowodanów x4 = 568 + 738 + 984
sprawdz('kalorie z makroskładników (142 / 82 / 246)',
  kcalZMakro(142, 82, 246), 2290);

// --- udziały procentowe ---
sprawdz('udziały procentowe planu Romana',
  udzialyProcentowe({ kcal: 2290, bialko: 142, tluszcz: 82, wegle: 246 }),
  { bialko: 24.8, tluszcz: 32.2, wegle: 43 });

// --- wiek ---
sprawdz('wiek z daty urodzenia (urodziny już minęły)',
  wiekZDaty('1967-01-01', new Date('2026-08-13')), 59);
sprawdz('wiek z daty urodzenia (urodziny jeszcze przed nami)',
  wiekZDaty('1967-12-31', new Date('2026-08-13')), 58);

// --- odwrotność: wiek -> data urodzenia ---
sprawdz('data urodzenia z wieku (dziś 2026-08-13, wiek 59)',
  dataUrodzeniaZWieku(59, new Date('2026-08-13')), '1967-08-13');
sprawdz('wiek z tej daty daje z powrotem 59 tego samego dnia',
  wiekZDaty(dataUrodzeniaZWieku(59, new Date('2026-08-13')), new Date('2026-08-13')), 59);
sprawdz('a za rok, tego samego dnia, daje 60',
  wiekZDaty(dataUrodzeniaZWieku(59, new Date('2026-08-13')), new Date('2027-08-13')), 60);

// --- próg białka na posiłek ---
// Próg posiłkowy zależy od masy ciała, a NIE od celu dziennego podzielonego przez trzy.
sprawdz('podpowiedź progu białka przy 90 kg', podpowiedzProguBialka(90), 36);
sprawdz('podpowiedź progu białka przy 60 kg', podpowiedzProguBialka(60), 24);

// =============================================================
//  Ocena celów
// =============================================================

// Plan Romana: bezpieczny, mimo że węglowodany poniżej AMDR — to już nie
// jest sprawdzane, więc ma przejść bez żadnej blokady.
const romanOcena = oceniaCele(
  { kcal: 2290, bialko: 142, tluszcz: 82, wegle: 246 }, 1791, 2776);
sprawdz('plan Romana: brak blokad', romanOcena.blokady.length, 0);

// Cel poniżej przemiany podstawowej — blokada.
const zaMalo = oceniaCele({ kcal: 0, bialko: 80, tluszcz: 40, wegle: 100 }, 1791, 2776);
sprawdz('cel poniżej przemiany podstawowej: zablokowany',
  zaMalo.blokady.some((b) => b.includes('przemiany podstawowej')), true);

// Zbyt duży deficyt — blokada.
const duzyDeficyt = oceniaCele({ kcal: 0, bialko: 90, tluszcz: 45, wegle: 130 }, 1200, 2900);
sprawdz('deficyt ponad 1000 kcal: zablokowany',
  duzyDeficyt.blokady.some((b) => b.includes('Deficyt')), true);

// Białko powyżej 35% energii — blokada.
const zaDuzoBialka = oceniaCele({ kcal: 0, bialko: 200, tluszcz: 50, wegle: 100 }, 1500, 2500);
sprawdz('białko powyżej 35% energii: zablokowane',
  zaDuzoBialka.blokady.some((b) => b.includes('Białko')), true);

// Plan mieszczący się w całości w AMDR — zero uwag.
// 100 g białka (400 kcal), 60 g tłuszczu (540 kcal), 250 g węglowodanów (1000 kcal) = 1940 kcal
const wzorcowy = oceniaCele({ kcal: 1940, bialko: 100, tluszcz: 60, wegle: 250 }, 1500, 2000);
sprawdz('plan mieszczący się w AMDR: brak blokad', wzorcowy.blokady.length, 0);

// =============================================================
//  Błonnik i woda
// =============================================================

// 14 g na 1000 kcal
sprawdz('podpowiedź błonnika przy 2290 kcal', podpowiedzBlonnika(2290), 32);
sprawdz('podpowiedź błonnika przy 1600 kcal', podpowiedzBlonnika(1600), 22);
sprawdz('podpowiedź błonnika przy 2800 kcal', podpowiedzBlonnika(2800), 39);

sprawdz('brak celu błonnikowego nie daje uwagi', ocenaBlonnika(20, null), null);
sprawdz('cel osiągnięty nie daje uwagi', ocenaBlonnika(35, 32), null);
sprawdz('niedobór błonnika opisany',
  ocenaBlonnika(20, 32)?.startsWith('Do celu błonnikowego brakuje 12 g'), true);

// 30 ml na kilogram, zaokrąglone do pełnych 100 ml
sprawdz('wskazówka wodna przy 90 kg', wskazowkaWodna(90), 2700);
sprawdz('wskazówka wodna przy 65 kg', wskazowkaWodna(65), 2000);

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
