/**
 * Testy silnika skalowania przepisu do zadanej liczby kalorii.
 *
 *     node --experimental-strip-types testy/test-skalowanie-kalorii.ts
 */

import {
  dobierzWspolczynnik,
  K_MAX,
  K_MIN,
  mnoznikRoli,
  przeskalujPrzepis,
  type SkladnikPrzepisu,
} from '../lib/skalowanie-kalorii.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, otrzymano: unknown, oczekiwano: unknown) {
  const a = JSON.stringify(otrzymano);
  const b = JSON.stringify(oczekiwano);
  if (a === b) przeszlo.push(`${nazwa} = ${a}`);
  else nieprzeszlo.push(`${nazwa}: otrzymano ${a}, oczekiwano ${b}`);
}

function bliskie(nazwa: string, otrzymano: number, oczekiwano: number, tolerancja = 0.5) {
  if (Math.abs(otrzymano - oczekiwano) <= tolerancja) {
    przeszlo.push(`${nazwa} ≈ ${otrzymano} (cel ${oczekiwano})`);
  } else {
    nieprzeszlo.push(`${nazwa}: otrzymano ${otrzymano}, oczekiwano ~${oczekiwano} (±${tolerancja})`);
  }
}

// =============================================================
//  mnoznikRoli — wzory z tabeli "Role składników"
// =============================================================

sprawdz('baza, k=2 (liniowo)', mnoznikRoli('baza', 2), 2);
sprawdz('baza, k=0.5 (liniowo)', mnoznikRoli('baza', 0.5), 0.5);
sprawdz('doprawienie, k=0.5 (liniowo, bo k<=1)', mnoznikRoli('doprawienie', 0.5), 0.5);
sprawdz('aromat, k=2 (tłumione: 2^0.75)', mnoznikRoli('aromat', 2), 2 ** 0.75);
sprawdz('smazenie, k=2 (tłumione: 2^0.67)', mnoznikRoli('smazenie', 2), 2 ** 0.67);
sprawdz('duszenie, k=2 (tłumione: 2^0.85)', mnoznikRoli('duszenie', 2), 2 ** 0.85);
sprawdz('woda, k=4 (bez skalowania)', mnoznikRoli('woda', 4), 1);
sprawdz('do_smaku, k=0.25 (bez skalowania)', mnoznikRoli('do_smaku', 0.25), 1);
sprawdz('baza, k=1 (bez zmian)', mnoznikRoli('baza', 1), 1);

// =============================================================
//  Prosty przepis: sałatka na 1 kromkę — sama baza (bez tłumienia)
// =============================================================
//  Chleb: 1 szt (kromka), 60 g/szt, 250 kcal/100g -> 150 kcal bazowo
//  Szynka: 30 g, 120 kcal/100g -> 36 kcal bazowo
//  Razem bazowo: 186 kcal

const salatka: SkladnikPrzepisu[] = [
  {
    id: 'chleb', rola: 'baza', moznaDzielic: false, ilosc: 1, gramyNaJednostke: 60,
    kcal_100g: 250, bialko_100g: 8, tluszcz_100g: 2, wegle_100g: 48,
  },
  {
    id: 'szynka', rola: 'baza', moznaDzielic: true, ilosc: 30, gramyNaJednostke: 1,
    kcal_100g: 120, bialko_100g: 20, tluszcz_100g: 4, wegle_100g: 1,
  },
];

// Same "baza" -> k jest wprost proporcjonalne do kcal: cel 372 kcal (x2) -> k=2.
const wynikX2 = przeskalujPrzepis(salatka, 372);
bliskie('sałatka x2: k', wynikX2.k, 2, 0.01);
bliskie('sałatka x2: kcal razem', wynikX2.kcalRazem, 372, 0.01);
sprawdz('sałatka x2: chleb zaokrąglony do 2 sztuk (całkowita)', wynikX2.pozycje[0].iloscPoSkalowaniu, 2);
bliskie('sałatka x2: szynka może być ułamkowa', wynikX2.pozycje[1].iloscPoSkalowaniu, 60, 0.01);

// Cel poniżej zasięgu K_MIN (186 * 0.25 = 46.5 kcal) -> ograniczone do K_MIN.
const wynikMalo = przeskalujPrzepis(salatka, 10);
sprawdz('cel poniżej zasięgu -> k = K_MIN', wynikMalo.k, K_MIN);
sprawdz('cel poniżej zasięgu -> oznaczone jako ograniczone', wynikMalo.kOgraniczone, true);

// Cel powyżej zasięgu K_MAX (186 * 4 = 744 kcal) -> ograniczone do K_MAX.
const wynikDuzo = przeskalujPrzepis(salatka, 2000);
sprawdz('cel powyżej zasięgu -> k = K_MAX', wynikDuzo.k, K_MAX);
sprawdz('cel powyżej zasięgu -> oznaczone jako ograniczone', wynikDuzo.kOgraniczone, true);

// Zaokrąglenie do zera nie kasuje składnika, gdy bazowo był obecny.
const jednaKromkaMalyCel: SkladnikPrzepisu[] = [
  {
    id: 'chleb', rola: 'baza', moznaDzielic: false, ilosc: 1, gramyNaJednostke: 60,
    kcal_100g: 250, bialko_100g: 8, tluszcz_100g: 2, wegle_100g: 48,
  },
];
const wynikMin = przeskalujPrzepis(jednaKromkaMalyCel, 1);
sprawdz('minimalny cel nie zeruje jedynego składnika', wynikMin.pozycje[0].iloscPoSkalowaniu >= 1, true);

// =============================================================
//  Przepis z mieszanymi rolami — kalorie od tłumionych ról rosną wolniej
// =============================================================
//  Baza: 400 g kurczaka, 165 kcal/100g -> 660 kcal
//  Aromat: 4 szt czosnku po 5 g, 150 kcal/100g -> 30 kcal
//  Woda: 200 g, 0 kcal/100g -> 0 kcal (i tak się nie liczy)
//  Bazowo razem: 690 kcal

const gulasz: SkladnikPrzepisu[] = [
  {
    id: 'kurczak', rola: 'baza', moznaDzielic: true, ilosc: 400, gramyNaJednostke: 1,
    kcal_100g: 165, bialko_100g: 31, tluszcz_100g: 4, wegle_100g: 0,
  },
  {
    id: 'czosnek', rola: 'aromat', moznaDzielic: false, ilosc: 4, gramyNaJednostke: 5,
    kcal_100g: 150, bialko_100g: 6, tluszcz_100g: 0.5, wegle_100g: 33,
  },
  {
    id: 'woda', rola: 'woda', moznaDzielic: true, ilosc: 200, gramyNaJednostke: 1,
    kcal_100g: 0, bialko_100g: 0, tluszcz_100g: 0, wegle_100g: 0,
  },
];

const wynikGulasz = przeskalujPrzepis(gulasz, 1350); // dwukrotność -> k dąży do ~2, ale aromat rośnie wolniej
sprawdz('gulasz x2 kcal: woda nie zmienia ilości', wynikGulasz.pozycje[2].iloscPoSkalowaniu, 200);
sprawdz(
  'gulasz x2 kcal: czosnek rośnie WOLNIEJ niż x2 (bo aromat tłumiony przy k>1)',
  wynikGulasz.pozycje[1].iloscPoSkalowaniu < 8,
  true
);
// Tolerancja szersza niż w sałatce — czosnek (moznaDzielic=false) zaokrągla
// się do całej sztuki, a jedna sztuka to ok. 7,5 kcal, więc do połowy tego
// odchylenia jest tu oczekiwane i akceptowane (patrz założenia w lib).
bliskie('gulasz x2 kcal: trafia blisko celu mimo zaokrąglenia czosnku', wynikGulasz.kcalRazem, 1350, 4);

// =============================================================
//  dobierzWspolczynnik — spójność z przeskalujPrzepis
// =============================================================

const { k: kBezposrednio } = dobierzWspolczynnik(gulasz, 1350);
sprawdz('dobierzWspolczynnik zgodny z przeskalujPrzepis', kBezposrednio, wynikGulasz.k);

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
