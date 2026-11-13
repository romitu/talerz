/**
 * Testy formatu JSON przepisu: sprawdzenie kształtu, import z katalogami
 * i droga w obie strony (baza -> JSON -> import).
 *
 *     node --experimental-strip-types testy/test-przepis-json.ts
 */

import {
  przepisDoJson,
  sprawdzPrzepis,
  tekstJson,
  wczytajJsonPrzepisow,
  wyjmijJson,
  zbudujPromptPrzepisu,
} from '../lib/przepis-json.ts';

const przeszlo: string[] = [];
const nieprzeszlo: string[] = [];

function sprawdz(nazwa: string, otrzymano: unknown, oczekiwano: unknown) {
  const a = JSON.stringify(otrzymano);
  const b = JSON.stringify(oczekiwano);
  if (a === b) przeszlo.push(`${nazwa} = ${a}`);
  else nieprzeszlo.push(`${nazwa}: otrzymano ${a}, oczekiwano ${b}`);
}

const katalogi = {
  skladniki: [
    { id: 's1', nazwa: 'Płatki owsiane', masa_sztuki_g: null, rola: 'baza' as const, mozna_dzielic: true },
    { id: 's2', nazwa: 'Jaja kurze', masa_sztuki_g: 56, rola: 'baza' as const, mozna_dzielic: false },
    { id: 's3', nazwa: 'Sól', masa_sztuki_g: null, rola: 'do_smaku' as const, mozna_dzielic: true },
  ],
  sprzet: ['Garnek 2 l', 'Miska', 'Nóż szefa kuchni'],
  role: ['baza', 'doprawienie', 'aromat', 'smazenie', 'duszenie', 'woda', 'do_smaku'],
};

const wzor = () => ({
  nazwa: 'Owsianka z jajkiem',
  pory: ['sniadanie'],
  kuchnie: ['inna'],
  porcjowanie: 'waga',
  porcja_g: 196.5,
  trwalosc_dni: 0,
  czas_przygotowania_min: 4,
  czas_obrobki_min: 10,
  sprzet: ['garnek 2 l'],
  mozna_mrozic: false,
  skladniki: [
    { nazwa: 'płatki owsiane', ilosc: 85, jednostka: 'g' },
    { nazwa: 'Jaja kurze', ilosc: 2, jednostka: 'szt', stan: 'ugotowane na miękko' },
  ],
  etapy: [{ nazwa: 'Gotowanie', minuty: 10, kroki: [{ tresc: 'Gotuj.', uwaga: true }] }],
});

// --- Kształt ---------------------------------------------------------------

sprawdz('poprawny przepis nie ma błędów', sprawdzPrzepis(wzor()), []);
sprawdz('lista zamiast obiektu', sprawdzPrzepis([]).length, 1);
sprawdz('brak czasów i mrożenia jest dozwolony', sprawdzPrzepis({
  ...wzor(), czas_przygotowania_min: undefined, czas_obrobki_min: null, mozna_mrozic: null,
}), []);
sprawdz('zła pora', sprawdzPrzepis({ ...wzor(), pory: ['brunch'] }),
  ['pory: „brunch” — dozwolone sniadanie, obiad, kolacja, dodatek']);
sprawdz('składnik dwa razy', sprawdzPrzepis({
  ...wzor(), skladniki: [{ nazwa: 'Sól', ilosc: 1, jednostka: 'g' }, { nazwa: 'Sól', ilosc: 2, jednostka: 'g' }],
}), ['skladniki[2] „Sól”: występuje dwa razy — połącz ilości']);

// --- Wyjmowanie JSON-a z odpowiedzi czatu -----------------------------------

sprawdz('JSON w płotku z dopiskiem',
  wyjmijJson('Proszę:\n```json\n{"a": "x } y", "b": [1, 2]}\n```\nBRAKUJE W KATALOGU: {nic}'),
  '{"a": "x } y", "b": [1, 2]}');
sprawdz('tekst bez JSON-a', wyjmijJson('nic tu nie ma'), null);

// --- Import -----------------------------------------------------------------

const wynik = wczytajJsonPrzepisow(JSON.stringify(wzor()), katalogi);
sprawdz('import: bez błędów', wynik.bledy, []);
const p = wynik.przepisy[0];
sprawdz('import: porcja_g zaokrąglona', p.porcja_g, 197);
sprawdz('import: porcje przy wadze', p.porcje, 1);
sprawdz('import: sprzęt w pisowni z katalogu', p.sprzet, ['Garnek 2 l']);
sprawdz('import: składnik w pisowni z katalogu', p.skladniki[0].nazwa, 'Płatki owsiane');
sprawdz('import: sztuki przeliczone na gramy', p.skladniki[1].gramy, 112);
sprawdz('import: rola i podzielność ze składnika',
  [p.skladniki[1].rola, p.skladniki[1].mozna_dzielic], ['baza', false]);
sprawdz('import: bez pola rodzaje nie rusza rodzajów', 'rodzaje' in p, false);

const zBrakami = wczytajJsonPrzepisow(JSON.stringify({
  ...wzor(),
  sprzet: ['Nóż'],
  skladniki: [
    { nazwa: 'Płatki jaglane', ilosc: 50, jednostka: 'g' },
    { nazwa: 'Sól', ilosc: 1, jednostka: 'szt' },
  ],
}), katalogi);
sprawdz('import: braki w katalogach odrzucają przepis', zBrakami.przepisy.length, 0);
sprawdz('import: braki z podpowiedzią', zBrakami.bledy.map((b) => b.tresc), [
  'brak składnika „Płatki jaglane” w katalogu — podobne: Płatki owsiane',
  '„Sól” nie ma masy sztuki — podaj ilość w g albo ml',
  'brak sprzętu „Nóż” w katalogu — podobne: Nóż szefa kuchni',
]);

const lista = wczytajJsonPrzepisow(
  JSON.stringify([wzor(), { ...wzor(), nazwa: 'owsianka z  jajkiem' }, { ...wzor(), nazwa: 'Inna owsianka', pory: 'x' }]),
  katalogi
);
sprawdz('lista: dobry przechodzi mimo złych', lista.przepisy.map((x) => x.nazwa), ['Owsianka z jajkiem']);
sprawdz('lista: błędy z nazwą dania', lista.bledy.map((b) => b.przepis), ['owsianka z  jajkiem', 'Inna owsianka']);
sprawdz('zepsuty JSON', wczytajJsonPrzepisow('{"nazwa": ', katalogi).bledy.length, 1);

// --- Droga w obie strony ----------------------------------------------------

const zBazy = {
  id: 'p1',
  nazwa: 'Owsianka z jajkiem',
  opis: null,
  pory: ['sniadanie'],
  kuchnie: ['inna'],
  rodzaje: [],
  trwalosc_dni: 0,
  liczba_porcji_bazowych: 0,
  porcjowanie: 'sztuki',
  porcje: 2,
  porcja_g: null,
  czas_przygotowania_min: null,
  czas_obrobki_min: 0,
  sprzet: ['Miska'],
  przechowywanie: null,
  mozna_mrozic: null,
  ratunek: 'Dolej mleka.',
  widocznosc: 'publiczna',
  zgloszono_kiedy: null,
  powod_odrzucenia: null,
  zdjecie: 'x.jpg',
  zdjecie_zrodlo: null,
  skalowalny: true,
  skladniki: [
    { skladnik_id: 's2', nazwa: 'Jaja kurze', ilosc: 2, jednostka: 'szt', gramy: 112, stan: null, zamiennik: null,
      opis_potoczny: '2 jajka', kolejnosc: 1, rola: 'baza', mozna_dzielic: false },
    { skladnik_id: 's3', nazwa: 'Sól', ilosc: 1, jednostka: 'g', gramy: 1, stan: null, zamiennik: null,
      opis_potoczny: null, kolejnosc: 2, rola: 'doprawienie', mozna_dzielic: true },
  ],
  etapy: [{ nazwa: 'Gotowanie', minuty: null, kroki: [{ tresc: 'Gotuj.', sygnal: null, uwaga: false }] }],
};

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const plik = przepisDoJson(zBazy as any, katalogi.skladniki);
sprawdz('eksport: bez zdjęcia, widoczności i pustych pól', Object.keys(plik), [
  'nazwa', 'pory', 'kuchnie', 'porcjowanie', 'porcje', 'trwalosc_dni', 'czas_obrobki_min', 'sprzet', 'ratunek',
  'skladniki', 'etapy',
]);
sprawdz('eksport: nadpisanie roli tylko tam, gdzie różni się od katalogu', plik.skladniki, [
  { nazwa: 'Jaja kurze', ilosc: 2, jednostka: 'szt', opis_potoczny: '2 jajka' },
  { nazwa: 'Sól', ilosc: 1, jednostka: 'g', rola: 'doprawienie' },
]);

const zPowrotem = wczytajJsonPrzepisow(tekstJson([plik]), katalogi);
sprawdz('w obie strony: bez błędów', zPowrotem.bledy, []);
sprawdz('w obie strony: nadpisana rola wraca', zPowrotem.przepisy[0].skladniki[1].rola, 'doprawienie');
sprawdz('w obie strony: puste pola zostają puste',
  [zPowrotem.przepisy[0].czas_przygotowania_min, zPowrotem.przepisy[0].mozna_mrozic, zPowrotem.przepisy[0].porcje],
  [null, null, 2]);

// --- Prompt -----------------------------------------------------------------

const prompt = zbudujPromptPrzepisu(katalogi.skladniki, katalogi.sprzet);
sprawdz('prompt: składnik na sztuki z masą', prompt.includes('- Jaja kurze [szt, 1 szt = 56 g]'), true);
sprawdz('prompt: składnik wagowy bez dopisku', prompt.includes('- Sól\n'), true);
sprawdz('prompt: kończy się miejscem na danie', prompt.endsWith('DANIE, KTÓRE MA POWSTAĆ:\n'), true);

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
