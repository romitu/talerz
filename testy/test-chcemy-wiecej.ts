/**
 * Testy premii „Chcemy więcej” w automacie układającym plan.
 *
 *     node --experimental-strip-types --import ./testy/dopisz-ts.mjs testy/test-chcemy-wiecej.ts
 *
 * Sprawdza trzy rzeczy, które łatwo zepsuć wagą w `lib/automat.ts`:
 * premia działa, ma sufit, i nie przebija kalorii — danie z czarnuszką,
 * ale kompletnie nie na to miejsce, dalej przegrywa.
 */

import { nadajeSieNa, ocen, premiaZaChcemyWiecej, type Kandydat } from '../lib/automat.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, warunek: boolean, szczegoly: string) {
  if (warunek) przeszlo.push(nazwa);
  else nieprzeszlo.push(`${nazwa}: ${szczegoly}`);
}

function danie(zmiany: Partial<Kandydat>): Kandydat {
  return {
    id: 'x',
    nazwa: 'Danie',
    pory: ['obiad'],
    rodzaje: [],
    liczba_porcji_bazowych: 1,
    kcal: 600,
    bialko_g: 30,
    gramy_porcji: 400,
    preferencja: 'neutralne',
    skalowalny: false,
    trwalosc_dni: 1,
    ukryty: false,
    zawieraWykluczone: [],
    zawieraChcemyWiecej: [],
    ...zmiany,
  };
}

function ocena(k: Kandydat): number {
  return ocen({
    kandydat: k,
    pora: 'obiad',
    docelowoKcal: 600,
    docelowoBialko: 30,
    ostatnioWDniu: null,
    dzien: 0,
    szum: 0,
  });
}

// --- Premia i jej sufit ---

sprawdz('bez składników z listy premii nie ma', premiaZaChcemyWiecej([]) === 0, `${premiaZaChcemyWiecej([])}`);
sprawdz(
  'dwa składniki dają więcej niż jeden',
  premiaZaChcemyWiecej(['czarnuszka', 'czosnek']) > premiaZaChcemyWiecej(['czarnuszka']),
  `${premiaZaChcemyWiecej(['czarnuszka', 'czosnek'])} vs ${premiaZaChcemyWiecej(['czarnuszka'])}`
);
sprawdz(
  'sufit: pięć składników nie daje więcej niż dwa',
  premiaZaChcemyWiecej(['a', 'b', 'c', 'd', 'e']) === premiaZaChcemyWiecej(['a', 'b']),
  `${premiaZaChcemyWiecej(['a', 'b', 'c', 'd', 'e'])} vs ${premiaZaChcemyWiecej(['a', 'b'])}`
);

// --- Ocena dania ---

const zwykle = danie({});
const zCzarnuszka = danie({ zawieraChcemyWiecej: ['czarnuszka'] });
sprawdz(
  'przy tych samych kaloriach wygrywa danie z czarnuszką',
  ocena(zCzarnuszka) < ocena(zwykle),
  `${ocena(zCzarnuszka)} vs ${ocena(zwykle)}`
);

// Premia musi pokonać losowy szum (do 0,3), inaczej przy równych daniach
// nie zmieniałaby niczego w praktyce.
sprawdz(
  'premia za jeden składnik jest większa niż maksymalny szum',
  ocena(zwykle) - ocena(zCzarnuszka) > 0.3,
  `różnica ${ocena(zwykle) - ocena(zCzarnuszka)}`
);

// 1200 kcal na miejsce, gdzie ma być 600 — podwójna porcja to nie „trochę gorzej”.
const zaDuzeZCzarnuszka = danie({ kcal: 1200, zawieraChcemyWiecej: ['czarnuszka', 'czosnek'] });
sprawdz(
  'danie z czarnuszką, ale dwa razy za kaloryczne, przegrywa z pasującym',
  ocena(zaDuzeZCzarnuszka) > ocena(zwykle),
  `${ocena(zaDuzeZCzarnuszka)} vs ${ocena(zwykle)}`
);

// --- „Nie jemy” ma pierwszeństwo ---

sprawdz(
  'składnik na obu listach: wykluczenie wygrywa',
  !nadajeSieNa(danie({ zawieraWykluczone: ['czosnek'], zawieraChcemyWiecej: ['czosnek'] }), 'obiad'),
  'danie przeszło przez nadajeSieNa'
);

console.log(`Przeszło: ${przeszlo.length}`);
for (const p of przeszlo) console.log(`  ✓ ${p}`);
if (nieprzeszlo.length > 0) {
  console.log(`Nie przeszło: ${nieprzeszlo.length}`);
  for (const n of nieprzeszlo) console.log(`  ✗ ${n}`);
  process.exit(1);
}
