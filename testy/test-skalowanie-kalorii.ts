/**
 * Testy silnika skalowania przepisu do zadanej liczby kalorii.
 *
 *     node --experimental-strip-types testy/test-skalowanie-kalorii.ts
 */

import {
  dobierzWspolczynnik,
  gornaMasaPorcji,
  kDlaMasy,
  limitPorcjiG,
  masaPrzySkali,
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
//  Granice porcji — limity posiłków i wzrost o połowę
// =============================================================

sprawdz('limit obiadu', limitPorcjiG('obiad', ['obiad', 'kolacja']), 900);
sprawdz('limit śniadania', limitPorcjiG('sniadanie', ['sniadanie']), 600);
sprawdz('dodatek ma swój limit niezależnie od posiłku', limitPorcjiG('obiad', ['obiad', 'dodatek']), 600);
sprawdz('kanapka 250 g na śniadanie: ×1,5 ostrzejsze niż 600 g', gornaMasaPorcji(250, 600), 375);
sprawdz('krem z dyni 792 g na obiad: limit 900 g ostrzejszy niż ×1,5', gornaMasaPorcji(792, 900), 900);
sprawdz('barszcz 1065 g na obiad: nie rośnie, ale nie jest ścinany do 900', gornaMasaPorcji(1065, 900), 1065);

// =============================================================
//  Owsianka — sama baza, bez zaokrągleń
// =============================================================
//  Płatki 60 g (380 kcal/100 g) + mleko 200 g (50 kcal/100 g)
//  = 260 g, 328 kcal. Śniadanie: najwyżej 260 × 1,5 = 390 g.

const owsianka: SkladnikPrzepisu[] = [
  {
    id: 'platki', rola: 'baza', moznaDzielic: true, ilosc: 60, gramyNaJednostke: 1,
    kcal_100g: 380, bialko_100g: 13, tluszcz_100g: 7, wegle_100g: 60,
  },
  {
    id: 'mleko', rola: 'baza', moznaDzielic: true, ilosc: 200, gramyNaJednostke: 1,
    kcal_100g: 50, bialko_100g: 3.3, tluszcz_100g: 2, wegle_100g: 4.8,
  },
];
const masaMaxOwsianki = gornaMasaPorcji(260, limitPorcjiG('sniadanie', ['sniadanie']));

const owsiankaWZasiegu = przeskalujPrzepis(owsianka, 400, masaMaxOwsianki);
bliskie('owsianka pod 400 kcal: trafia w cel', owsiankaWZasiegu.kcalRazem, 400, 0.01);
sprawdz('owsianka pod 400 kcal: nie jest ograniczona', owsiankaWZasiegu.kOgraniczone, false);

const owsiankaZaDuzo = przeskalujPrzepis(owsianka, 800, masaMaxOwsianki);
bliskie('owsianka pod 800 kcal: staje na ×1,5', owsiankaZaDuzo.k, 1.5, 0.001);
bliskie('owsianka pod 800 kcal: 390 g, nie więcej',
  owsiankaZaDuzo.pozycje.reduce((s, p) => s + p.gramyPoSkalowaniu, 0), 390, 0.01);
sprawdz('owsianka pod 800 kcal: oznaczona jako ograniczona', owsiankaZaDuzo.kOgraniczone, true);

const owsiankaZaMalo = przeskalujPrzepis(owsianka, 200, masaMaxOwsianki);
sprawdz('owsianka pod 200 kcal: porcja nie maleje (k = 1)', owsiankaZaMalo.k, 1);
bliskie('owsianka pod 200 kcal: zostaje 328 kcal z przepisu', owsiankaZaMalo.kcalRazem, 328, 0.01);

// =============================================================
//  Barszcz — porcja bazowa już ponad limitem obiadu
// =============================================================
//  Jedna porcja z garnka na dwie: woda 700 g, buraki 250 g, fasola 115 g
//  = 1065 g, ok. 257 kcal. Brakuje 500 kcal — a i tak nie rośnie.

const barszcz: SkladnikPrzepisu[] = [
  {
    id: 'woda', rola: 'woda', moznaDzielic: true, ilosc: 700, gramyNaJednostke: 1,
    kcal_100g: 0, bialko_100g: 0, tluszcz_100g: 0, wegle_100g: 0,
  },
  {
    id: 'buraki', rola: 'baza', moznaDzielic: true, ilosc: 250, gramyNaJednostke: 1,
    kcal_100g: 43, bialko_100g: 1.6, tluszcz_100g: 0.2, wegle_100g: 10,
  },
  {
    id: 'fasola', rola: 'baza', moznaDzielic: true, ilosc: 115, gramyNaJednostke: 1,
    kcal_100g: 130, bialko_100g: 9, tluszcz_100g: 0.5, wegle_100g: 23,
  },
];
const masaMaxBarszczu = gornaMasaPorcji(1065, limitPorcjiG('obiad', ['obiad']));
sprawdz('barszcz: granica masy to sama porcja bazowa', kDlaMasy(barszcz, masaMaxBarszczu), 1);
const barszczPod500 = przeskalujPrzepis(barszcz, 500, masaMaxBarszczu);
sprawdz('barszcz pod 500 kcal: k = 1, nic nie rośnie', barszczPod500.k, 1);
sprawdz('barszcz pod 500 kcal: brak oznaczony jako ograniczenie', barszczPod500.kOgraniczone, true);

// =============================================================
//  Zaokrąglenia — tylko składniki całe w porcji bazowej
// =============================================================
//  Kromka 60 g (250 kcal/100 g) + szynka 30 g (120 kcal/100 g) = 186 kcal.

const kanapka: SkladnikPrzepisu[] = [
  {
    id: 'chleb', rola: 'baza', moznaDzielic: false, ilosc: 1, gramyNaJednostke: 60,
    kcal_100g: 250, bialko_100g: 8, tluszcz_100g: 2, wegle_100g: 48,
  },
  {
    id: 'szynka', rola: 'baza', moznaDzielic: true, ilosc: 30, gramyNaJednostke: 1,
    kcal_100g: 120, bialko_100g: 20, tluszcz_100g: 4, wegle_100g: 1,
  },
];
const kanapkaX14 = przeskalujPrzepis(kanapka, 260, 1000);
sprawdz('kanapka ×1,4: kromka zaokrąglona do całej', kanapkaX14.pozycje[0].iloscPoSkalowaniu, 1);
bliskie('kanapka ×1,4: szynka rośnie ułamkowo', kanapkaX14.pozycje[1].iloscPoSkalowaniu, 30 * kanapkaX14.k, 0.001);

// Porcja z garnka na dwie osoby: 3 jajka w garnku to 1,5 jajka na porcję.
// To udział w garnku, nie jajko do rozbicia — nie zaokrąglamy go do 2.
const jajkaZGarnka: SkladnikPrzepisu[] = [
  {
    id: 'jajka', rola: 'baza', moznaDzielic: false, ilosc: 1.5, gramyNaJednostke: 50,
    kcal_100g: 143, bialko_100g: 12.6, tluszcz_100g: 9.5, wegle_100g: 0.7,
  },
];
const jajkaWynik = przeskalujPrzepis(jajkaZGarnka, 110, 1000);
sprawdz('ułamek jajka z garnka nie jest zaokrąglany',
  Number.isInteger(jajkaWynik.pozycje[0].iloscPoSkalowaniu), false);

// =============================================================
//  Przepis z mieszanymi rolami — kalorie od tłumionych ról rosną wolniej
// =============================================================
//  Baza: 400 g kurczaka, 165 kcal/100g -> 660 kcal
//  Aromat: 4 szt czosnku po 5 g, 150 kcal/100g -> 30 kcal
//  Woda: 200 g, 0 kcal/100g -> 0 kcal (i tak się nie liczy)
//  Bazowo razem: 690 kcal, 620 g

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

// Granica masy liczy prawdziwe gramy: woda stoi, czosnek rośnie wolniej, więc
// kurczak może urosnąć bardziej niż o połowę, a porcja i tak nie przekroczy 930 g.
const kGulaszu = kDlaMasy(gulasz, 930);
sprawdz('gulasz: k przy granicy masy większe niż 1,5 (woda nie rośnie)', kGulaszu > 1.5, true);
bliskie('gulasz: masa przy granicznym k to dokładnie 930 g', masaPrzySkali(gulasz, kGulaszu), 930, 0.01);

const wynikGulasz = przeskalujPrzepis(gulasz, 1350, 2000); // dwukrotność -> k dąży do ~2, ale aromat rośnie wolniej
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

const { k: kBezposrednio } = dobierzWspolczynnik(gulasz, 1350, kDlaMasy(gulasz, 2000));
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
