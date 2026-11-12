/**
 * Testy kary za powtórkę dania w automacie układającym plan.
 *
 *     node --experimental-strip-types --import ./testy/dopisz-ts.mjs testy/test-automat-powtorki.ts
 *
 * Błąd, który ten test pilnuje: danie gotowane na kilka dni (np. kurczak
 * z ryżem na 3 porcje, od poniedziałku do środy na śniadanie) trafiało TEŻ
 * na kolację tych samych dni — kara za powtórkę wychodziła ujemna, czyli
 * działała jak premia.
 */

import { karaZaPowtorke, zaplanuj, type Kandydat } from '../lib/automat.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, warunek: boolean, szczegoly: string) {
  if (warunek) przeszlo.push(nazwa);
  else nieprzeszlo.push(`${nazwa}: ${szczegoly}`);
}

function danie(id: string, zmiany: Partial<Kandydat> = {}): Kandydat {
  return {
    id,
    nazwa: id,
    pory: ['sniadanie', 'kolacja'],
    rodzaje: [],
    liczba_porcji_bazowych: 1,
    kcal: 500,
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

// --- Sama kara ---

sprawdz('danie jeszcze nieużyte: bez kary', karaZaPowtorke(null, 0) === 0, `${karaZaPowtorke(null, 0)}`);
sprawdz(
  'garnek obejmuje ten dzień: kara, nie premia',
  karaZaPowtorke(2, 0) > 0 && karaZaPowtorke(0, 0) > 0,
  `${karaZaPowtorke(2, 0)}, ${karaZaPowtorke(0, 0)}`
);
sprawdz(
  'kara maleje z odstępem',
  karaZaPowtorke(0, 1) > karaZaPowtorke(0, 2) && karaZaPowtorke(0, 2) > 0,
  `${karaZaPowtorke(0, 1)}, ${karaZaPowtorke(0, 2)}`
);
sprawdz(
  'ten sam dzień karze mocniej niż dzień po',
  karaZaPowtorke(0, 0) > karaZaPowtorke(0, 1),
  `${karaZaPowtorke(0, 0)} vs ${karaZaPowtorke(0, 1)}`
);

// --- Cały plan: przypadek z poniedziałku i wtorku ---

const dni = ['pon', 'wt', 'sr', 'czw'];
const obiadyZajete = dni.map((data) => ({ data, pora: 'obiad' as const }));
const kurczak = danie('Kurczak z ryżem', {
  liczba_porcji_bazowych: 3,
  trwalosc_dni: 3,
  zawieraChcemyWiecej: ['czosnek'],
});
const inne = ['A', 'B', 'C', 'D', 'E', 'F'].map((id) => danie(id));

for (const uwzglednijTrwalosc of [false, true]) {
  const { wstawienia } = zaplanuj({
    dni,
    zajete: obiadyZajete,
    makroDni: new Map(),
    przepisy: [kurczak, ...inne],
    celKcal: null,
    celBialko: null,
    uwzglednijTrwalosc,
    osoby: 1,
    losowo: () => 0,
  });

  // Ile razy kurczak trafił na ten sam dzień w dwóch posiłkach.
  const dniKurczaka = new Map<string, number>();
  for (const w of wstawienia.filter((x) => x.przepisId === kurczak.id)) {
    for (const d of w.dni) dniKurczaka.set(d, (dniKurczaka.get(d) ?? 0) + 1);
  }
  const podwojne = [...dniKurczaka].filter(([, ile]) => ile > 1).map(([d]) => d);

  sprawdz(
    `kurczak nie jest dwa razy tego samego dnia (trwałość ${uwzglednijTrwalosc ? 'tak' : 'nie'})`,
    podwojne.length === 0,
    `dwa razy w: ${podwojne.join(', ')} — ${wstawienia.map((w) => `${w.pora}:${w.nazwa}[${w.dni.join(',')}]`).join(' ')}`
  );
}

// --- Gdy pasuje tylko jedno danie, miejsce i tak ma być obsadzone ---

const jedyne = zaplanuj({
  dni: ['pon'],
  zajete: [{ data: 'pon', pora: 'obiad' }],
  makroDni: new Map(),
  przepisy: [danie('Jedyne')],
  celKcal: null,
  celBialko: null,
  losowo: () => 0,
});
sprawdz(
  'jedyne pasujące danie wypełnia oba posiłki zamiast zostawić puste',
  jedyne.bezObsady.length === 0,
  `puste: ${jedyne.bezObsady.map((m) => m.pora).join(', ')}`
);

console.log(`Przeszło: ${przeszlo.length}`);
for (const p of przeszlo) console.log(`  ✓ ${p}`);
if (nieprzeszlo.length > 0) {
  console.log(`Nie przeszło: ${nieprzeszlo.length}`);
  for (const n of nieprzeszlo) console.log(`  ✗ ${n}`);
  process.exit(1);
}
