/**
 * Testy schematów tygodnia: zapis tygodnia jako schematu i przeniesienie
 * schematu na inny tydzień przez `powtorzTydzien`.
 *
 *     node --experimental-strip-types --import ./testy/dopisz-ts.mjs testy/test-schematy.ts
 *
 * Czego pilnujemy:
 *  - garnek rozłożony na kilka dni zostaje JEDNYM gotowaniem po obu krokach,
 *  - schemat trafia na właściwe dni niezależnie od daty startu tygodnia,
 *  - usunięty przepis i składnik „Nie jemy” zabierają cały garnek i są liczone,
 *    a nie gubione po cichu.
 */

import { powtorzTydzien } from '../lib/automat.ts';
import {
  dniGarnka,
  dodajDanie,
  naMiejscu,
  przedluzGarnek,
  schematZPlanu,
  skrocGarnek,
  START_SCHEMATU,
  MAX_DNI_SCHEMATU,
  usunDzienGarnka,
  usunGarnek,
  wolneDniOd,
  zmienDlugosc,
  zrodloZeSchematu,
  type PozycjaSchematu,
} from '../lib/schematy-uklad.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, warunek: boolean, szczegoly: string) {
  if (warunek) przeszlo.push(nazwa);
  else nieprzeszlo.push(`${nazwa}: ${szczegoly}`);
}

// Tydzień od poniedziałku 2 listopada 2026: gulasz na obiad pon–śr z jednego
// garnka, owsianka bez partii (stary wpis) we wtorek, omlet w sobotę.
const tydzien = [
  { data: '2026-11-03', pora: 'sniadanie' as const, przepis_id: 'owsianka', nazwa: 'Owsianka', partia_id: null, kolejnosc: 1 },
  { data: '2026-11-02', pora: 'obiad' as const, przepis_id: 'gulasz', nazwa: 'Gulasz', partia_id: 'p1', kolejnosc: 1 },
  { data: '2026-11-03', pora: 'obiad' as const, przepis_id: 'gulasz', nazwa: 'Gulasz', partia_id: 'p1', kolejnosc: 1 },
  { data: '2026-11-04', pora: 'obiad' as const, przepis_id: 'gulasz', nazwa: 'Gulasz', partia_id: 'p1', kolejnosc: 1 },
  { data: '2026-11-07', pora: 'kolacja' as const, przepis_id: 'omlet', nazwa: 'Omlet', partia_id: 'p2', kolejnosc: 1 },
  // Ogon garnka z poprzedniego tygodnia — nie należy do tego tygodnia.
  { data: '2026-11-01', pora: 'obiad' as const, przepis_id: 'zupa', nazwa: 'Zupa', partia_id: 'p0', kolejnosc: 1 },
];

const schemat = schematZPlanu(tydzien, '2026-11-02', 7);

sprawdz('pozycje spoza tygodnia odpadają', schemat.length === 5, `${schemat.length}`);
sprawdz(
  'dni liczone od zera i posortowane',
  schemat.map((p) => `${p.dzien}${p.pora[0]}`).join(',') === '0o,1s,1o,2o,5k',
  schemat.map((p) => `${p.dzien}${p.pora[0]}`).join(',')
);
const gulasz = schemat.filter((p) => p.przepis_id === 'gulasz');
sprawdz(
  'garnek gulaszu ma jeden numer gotowania',
  new Set(gulasz.map((p) => p.gotowanie)).size === 1,
  JSON.stringify(gulasz)
);
sprawdz(
  'każdy garnek ma własny numer',
  new Set(schemat.map((p) => p.gotowanie)).size === 3,
  JSON.stringify(schemat.map((p) => p.gotowanie))
);

// --- Zastosowanie do tygodnia zaczynającego się w czwartek ---

const { zrodlo, usuniete, wykluczone } = zrodloZeSchematu(schemat, new Set());
sprawdz('nic nie odpada bez powodu', usuniete === 0 && wykluczone === 0 && zrodlo.length === 5, `${usuniete} ${wykluczone}`);

const dniCelu = ['2026-11-19', '2026-11-20', '2026-11-21', '2026-11-22', '2026-11-23', '2026-11-24', '2026-11-25'];
const wynik = powtorzTydzien({ zrodlo, odDaty: START_SCHEMATU, dni: dniCelu, zajete: [] });

sprawdz('trzy gotowania, nie pięć', wynik.wstawienia.length === 3, `${wynik.wstawienia.length}`);
const gulaszCel = wynik.wstawienia.find((w) => w.przepisId === 'gulasz');
sprawdz(
  'gulasz na pierwsze trzy dni nowego tygodnia',
  gulaszCel?.dni.join(',') === '2026-11-19,2026-11-20,2026-11-21',
  `${gulaszCel?.dni}`
);
sprawdz(
  'omlet na szósty dzień',
  wynik.wstawienia.find((w) => w.przepisId === 'omlet')?.dni.join(',') === '2026-11-24',
  JSON.stringify(wynik.wstawienia)
);

// --- Zajęte miejsce zabiera cały garnek ---

const zZajetym = powtorzTydzien({
  zrodlo,
  odDaty: START_SCHEMATU,
  dni: dniCelu,
  zajete: [{ data: '2026-11-20', pora: 'obiad' }],
});
sprawdz(
  'zajęty wtorek: gulasz wcale, reszta tak',
  !zZajetym.wstawienia.some((w) => w.przepisId === 'gulasz') && zZajetym.wstawienia.length === 2,
  JSON.stringify(zZajetym.wstawienia)
);

// --- Krótszy tydzień docelowy ---

const zaKrotki = powtorzTydzien({ zrodlo, odDaty: START_SCHEMATU, dni: dniCelu.slice(0, 5), zajete: [] });
sprawdz(
  'omlet z szóstego dnia nie mieści się w pięciu dniach',
  !zaKrotki.wstawienia.some((w) => w.przepisId === 'omlet'),
  JSON.stringify(zaKrotki.wstawienia)
);

// --- Usunięty przepis i „Nie jemy” ---

const zDziura: PozycjaSchematu[] = schemat.map((p, i) =>
  // drugi dzień gulaszu traci przepis
  p.przepis_id === 'gulasz' && i === 2 ? { ...p, przepis_id: null } : p
);
const poUsunieciu = zrodloZeSchematu(zDziura, new Set(['omlet']));
sprawdz('usunięty przepis policzony', poUsunieciu.usuniete === 1, `${poUsunieciu.usuniete}`);
sprawdz('wykluczone policzone', poUsunieciu.wykluczone === 1, `${poUsunieciu.wykluczone}`);
sprawdz(
  'odpada cały garnek gulaszu i omlet, zostaje owsianka',
  poUsunieciu.zrodlo.map((p) => p.przepis_id).join(',') === 'owsianka',
  JSON.stringify(poUsunieciu.zrodlo)
);

// --- Przepis, którego konto nie widzi (prywatny u dietetyka) ---

const zNiedostepnym = zrodloZeSchematu(schemat, new Set(), new Set(['owsianka', 'omlet']));
sprawdz(
  'niewidoczny przepis zabiera cały garnek i jest liczony',
  zNiedostepnym.niedostepne === 3 && zNiedostepnym.zrodlo.every((p) => p.przepis_id !== 'gulasz'),
  JSON.stringify(zNiedostepnym)
);
sprawdz(
  'bez listy dostępnych nic nie odpada z tego powodu',
  zrodloZeSchematu(schemat, new Set()).niedostepne === 0,
  ''
);

// --- Edycja ---

const trzyDni = dodajDanie([], 1, 'obiad', { id: 'gulasz', nazwa: 'Gulasz' }, 3, 7);
sprawdz('obiad na 3 porcje od razu na trzy dni jednym garnkiem', trzyDni.map((p) => `${p.dzien}:${p.gotowanie}`).join(',') === '1:0,2:0,3:0', JSON.stringify(trzyDni));
const przyKoncu = dodajDanie([], 5, 'obiad', { id: 'gulasz', nazwa: 'Gulasz' }, 3, 7);
sprawdz('przy końcu schematu tyle dni, ile się mieści', przyKoncu.map((p) => p.dzien).join(',') === '5,6', JSON.stringify(przyKoncu));
const przedZajetym = dodajDanie(dodajDanie([], 2, 'obiad', { id: 'x', nazwa: 'X' }), 0, 'obiad', { id: 'g', nazwa: 'G' }, 3, 7);
sprawdz('seria kończy się na zajętym dniu', dniGarnka(przedZajetym, 1).join(',') === '0,1', JSON.stringify(przedZajetym));
sprawdz('wolneDniOd liczy tak samo', wolneDniOd(przedZajetym, 3, 'obiad', 9, 7).join(',') === '3,4,5,6', '');

let e: PozycjaSchematu[] = [];
e = dodajDanie(e, 0, 'obiad', { id: 'gulasz', nazwa: 'Gulasz' });
e = dodajDanie(e, 0, 'obiad', { id: 'zupa', nazwa: 'Zupa' });
sprawdz('zajęte miejsce nie przyjmuje drugiego dania', e.length === 1 && e[0].przepis_id === 'gulasz', JSON.stringify(e));

e = przedluzGarnek(e, 0, 7);
e = przedluzGarnek(e, 0, 7);
sprawdz('przedłużenie dokłada kolejne dni', dniGarnka(e, 0).join(',') === '0,1,2', dniGarnka(e, 0).join(','));

e = dodajDanie(e, 4, 'obiad', { id: 'omlet', nazwa: 'Omlet' });
sprawdz('nowe danie to nowy garnek', naMiejscu(e, 4, 'obiad')?.gotowanie === 1, JSON.stringify(e));
e = przedluzGarnek(e, 0, 7);
e = przedluzGarnek(e, 0, 7);
sprawdz('przedłużenie zatrzymuje się na zajętym dniu', dniGarnka(e, 0).join(',') === '0,1,2,3', dniGarnka(e, 0).join(','));

const naKoncu = przedluzGarnek(dodajDanie([], 6, 'kolacja', { id: 'x', nazwa: 'X' }), 0, 7);
sprawdz('przedłużenie nie wychodzi poza schemat', naKoncu.length === 1, JSON.stringify(naKoncu));

e = skrocGarnek(e, 0);
sprawdz('skrócenie zabiera ostatni dzień', dniGarnka(e, 0).join(',') === '0,1,2', dniGarnka(e, 0).join(','));
sprawdz('jednodniowy garnek nie znika przy skracaniu', skrocGarnek(e, 1).length === e.length, '');

const krotszy = zmienDlugosc(e, 2);
sprawdz(
  'skrócenie schematu ucina garnek, nie kasuje go',
  dniGarnka(krotszy, 0).join(',') === '0,1' && !krotszy.some((p) => p.przepis_id === 'omlet'),
  JSON.stringify(krotszy)
);

e = usunGarnek(e, 0);
sprawdz('usunięcie garnka zabiera wszystkie jego dni', e.length === 1 && e[0].przepis_id === 'omlet', JSON.stringify(e));

// --- Usunięcie jednego dnia garnka ---

const garnek3 = dodajDanie([], 0, 'obiad', { id: 'g', nazwa: 'G' }, 3, 7);
const bezSrodka = usunDzienGarnka(garnek3, 0, 1);
sprawdz('usunięcie środkowego dnia zostawia resztę jednym garnkiem', dniGarnka(bezSrodka, 0).join(',') === '0,2', JSON.stringify(bezSrodka));

// --- Najwyżej tydzień ---

const dwaTygodnie = Array.from({ length: 14 }, (_, i) => ({
  data: new Date(Date.UTC(2026, 10, 2 + i)).toISOString().slice(0, 10),
  pora: 'obiad' as const,
  przepis_id: i >= 5 && i <= 7 ? 'zupa' : 'x' + i,
  nazwa: 'D',
  partia_id: i >= 5 && i <= 7 ? 'pz' : null,
  kolejnosc: 1,
}));
const tydzienZPlanu = schematZPlanu(dwaTygodnie, '2026-11-02', 14, new Set(['zupa']));
sprawdz('z dłuższego planu najwyżej 7 dni', tydzienZPlanu.every((p) => p.dzien < MAX_DNI_SCHEMATU), JSON.stringify(tydzienZPlanu.map((p) => p.dzien)));
sprawdz('zupa wychodząca za tydzień odpada w całości', !tydzienZPlanu.some((p) => p.przepis_id === 'zupa') && tydzienZPlanu.length === 5, JSON.stringify(tydzienZPlanu.map((p) => p.przepis_id)));

for (const p of przeszlo) console.log(`  ok   ${p}`);
for (const n of nieprzeszlo) console.log(`  ZLE  ${n}`);
console.log(`\n${przeszlo.length} ok, ${nieprzeszlo.length} źle`);
if (nieprzeszlo.length > 0) process.exit(1);
