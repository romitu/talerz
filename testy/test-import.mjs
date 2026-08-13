/**
 * Testy odczytu danych z odpowiedzi USDA.
 *
 *     node testy/test-import.mjs
 *
 * Sieć nie jest potrzebna — sprawdzamy samo przetwarzanie odpowiedzi
 * na przygotowanych przykładach o kształcie takim, jaki zwraca USDA.
 */

import { odczytajSkladniki, wiarygodne, wybierzNajlepszy } from '../narzedzia/import-usda.mjs';

const przeszlo = [];
const nieprzeszlo = [];

function sprawdz(nazwa, otrzymano, oczekiwano) {
  const a = JSON.stringify(otrzymano);
  const b = JSON.stringify(oczekiwano);
  if (a === b) przeszlo.push(`${nazwa} = ${a}`);
  else nieprzeszlo.push(`${nazwa}: otrzymano ${a}, oczekiwano ${b}`);
}

// Kształt odpowiedzi z punktu /foods/search
const dorsz = {
  fdcId: 171955,
  description: 'Fish, cod, Atlantic, raw',
  dataType: 'SR Legacy',
  foodNutrients: [
    { nutrientNumber: '208', nutrientName: 'Energy', unitName: 'KCAL', value: 82 },
    { nutrientNumber: '203', nutrientName: 'Protein', unitName: 'G', value: 17.81 },
    { nutrientNumber: '204', nutrientName: 'Total lipid (fat)', unitName: 'G', value: 0.67 },
    { nutrientNumber: '205', nutrientName: 'Carbohydrate', unitName: 'G', value: 0 },
    { nutrientNumber: '269', nutrientName: 'Sugars, total', unitName: 'G', value: 0 },
  ],
};

sprawdz('odczyt wartości dorsza', odczytajSkladniki(dorsz), {
  kcal: 82,
  bialko: 17.81,
  tluszcz: 0.67,
  wegle: 0,
  cukry: 0,
});

// Kształt odpowiedzi z punktu /food/{id} — inne nazwy pól
const miod = {
  fdcId: 169640,
  description: 'Honey',
  dataType: 'SR Legacy',
  foodNutrients: [
    { nutrient: { number: '208', name: 'Energy' }, amount: 304 },
    { nutrient: { number: '203', name: 'Protein' }, amount: 0.3 },
    { nutrient: { number: '204', name: 'Total lipid (fat)' }, amount: 0 },
    { nutrient: { number: '205', name: 'Carbohydrate' }, amount: 82.4 },
    { nutrient: { number: '269', name: 'Sugars, total' }, amount: 82.12 },
  ],
};

sprawdz('odczyt wartości miodu (inny kształt odpowiedzi)', odczytajSkladniki(miod), {
  kcal: 304,
  bialko: 0.3,
  tluszcz: 0,
  wegle: 82.4,
  cukry: 82.12,
});

// Brakujące wartości mają dać null, a nie zero — zero to informacja, brak danych to co innego.
sprawdz('brak wartości daje null', odczytajSkladniki({ foodNutrients: [] }), {
  kcal: null,
  bialko: null,
  tluszcz: null,
  wegle: null,
  cukry: null,
});

sprawdz('pozycja bez listy składników nie wywraca odczytu', odczytajSkladniki({}), {
  kcal: null,
  bialko: null,
  tluszcz: null,
  wegle: null,
  cukry: null,
});

// Wybór najlepszego dopasowania
sprawdz(
  'dane opracowane (Foundation) mają pierwszeństwo',
  wybierzNajlepszy([
    { fdcId: 1, dataType: 'Branded' },
    { fdcId: 2, dataType: 'SR Legacy' },
    { fdcId: 3, dataType: 'Foundation' },
  ])?.fdcId,
  3
);

sprawdz(
  'gdy brak Foundation, wybieramy SR Legacy',
  wybierzNajlepszy([
    { fdcId: 1, dataType: 'Branded' },
    { fdcId: 2, dataType: 'SR Legacy' },
  ])?.fdcId,
  2
);

sprawdz('brak wyników daje null', wybierzNajlepszy([]), null);
sprawdz('brak listy wyników daje null', wybierzNajlepszy(undefined), null);

// Reguła cukrów wolnych — miód liczy się w całości, reszta zero.
const reguła = (pozycja, cukryOgolem) =>
  pozycja.cukry_wolne === 'wszystkie' ? cukryOgolem : 0;

sprawdz('miód: cukry wolne równe cukrom ogółem', reguła({ cukry_wolne: 'wszystkie' }, 82.12), 82.12);
sprawdz('dorsz: cukry wolne zerowe', reguła({}, 0), 0);
sprawdz('jabłko: cukry z owocu nie są wolne', reguła({}, 10.39), 0);


// ---------------------------------------------------------------------------
//  Warianty zapisu energii — powód, dla którego migdały wcześniej wypadały
// ---------------------------------------------------------------------------

// Nowszy wpis: brak numeru 208, jest tylko energia Atwatera (957).
const migdaly = {
  fdcId: 2346393,
  description: 'Almonds',
  dataType: 'Foundation',
  foodNutrients: [
    { nutrientNumber: '957', nutrientName: 'Energy (Atwater General Factors)', unitName: 'KCAL', value: 601 },
    { nutrientNumber: '203', nutrientName: 'Protein', unitName: 'G', value: 21.2 },
    { nutrientNumber: '204', nutrientName: 'Total lipid (fat)', unitName: 'G', value: 50.6 },
    { nutrientNumber: '205', nutrientName: 'Carbohydrate', unitName: 'G', value: 21.6 },
    { nutrientNumber: '269', nutrientName: 'Sugars, total', unitName: 'G', value: 4.35 },
  ],
};

sprawdz('energia odczytana z numeru 957 (migdały)', odczytajSkladniki(migdaly).kcal, 601);
sprawdz('migdały: białko odczytane', odczytajSkladniki(migdaly).bialko, 21.2);

// Wpis z energią właściwą dla produktu (958).
const zEnergia958 = {
  foodNutrients: [
    { nutrientNumber: '958', nutrientName: 'Energy (Atwater Specific Factors)', unitName: 'KCAL', value: 579 },
    { nutrientNumber: '203', unitName: 'G', value: 20 },
  ],
};
sprawdz('energia odczytana z numeru 958', odczytajSkladniki(zEnergia958).kcal, 579);

// Kilodżule to nie kilokalorie — takiej wartości nie wolno wziąć.
const tylkoKilodzule = {
  foodNutrients: [
    { nutrientNumber: '268', nutrientName: 'Energy', unitName: 'KJ', value: 2515 },
    { nutrientNumber: '203', unitName: 'G', value: 21.2 },
  ],
};
sprawdz('kilodżule nie są brane za kilokalorie', odczytajSkladniki(tylkoKilodzule).kcal, null);

// Gdy numeru brak, ratuje nas dopasowanie po nazwie i jednostce.
const bezNumeru = {
  foodNutrients: [
    { nutrientName: 'Energy', unitName: 'KCAL', value: 250 },
    { nutrientNumber: '203', unitName: 'G', value: 10 },
  ],
};
sprawdz('energia rozpoznana po nazwie, gdy brak numeru', odczytajSkladniki(bezNumeru).kcal, 250);

// Gdy obecne są oba zapisy, pierwszeństwo ma numer 208.
const obaZapisy = {
  foodNutrients: [
    { nutrientNumber: '957', unitName: 'KCAL', value: 601 },
    { nutrientNumber: '208', unitName: 'KCAL', value: 579 },
    { nutrientNumber: '203', unitName: 'G', value: 21 },
  ],
};
sprawdz('przy dwóch zapisach energii wygrywa numer 208', odczytajSkladniki(obaZapisy).kcal, 579);


// ---------------------------------------------------------------------------
//  Próg rozsądku — wyłapywanie trafień w niewłaściwy produkt
// ---------------------------------------------------------------------------

sprawdz('dynia: pestki (555 kcal) odrzucone wobec oczekiwanych 26', wiarygodne(555, 26).ok, false);
sprawdz('płatki owsiane: olej (884 kcal) odrzucony wobec oczekiwanych 389', wiarygodne(884, 389).ok, false);
sprawdz('oliwki: pomidor (18 kcal) odrzucony wobec oczekiwanych 145', wiarygodne(18, 145).ok, false);
sprawdz('cytryna: ogórek (15,9 kcal) odrzucony wobec oczekiwanych 29', wiarygodne(15.9, 29).ok, false);
sprawdz('komosa: figi (249 kcal) odrzucone wobec oczekiwanych 368', wiarygodne(249, 368).ok, false);

sprawdz('migdały 626 wobec oczekiwanych 579: przyjęte', wiarygodne(626, 579).ok, true);
sprawdz('dorsz 66 wobec oczekiwanych 82: przyjęty', wiarygodne(66, 82).ok, true);
sprawdz('parmezan 421 wobec oczekiwanych 420: przyjęty', wiarygodne(421, 420).ok, true);
sprawdz('miód 304 wobec oczekiwanych 304: przyjęty', wiarygodne(304, 304).ok, true);

sprawdz('brak wartości orientacyjnej wyłącza sprawdzenie', wiarygodne(999, undefined).ok, true);
sprawdz('odchylenie podawane w procentach', wiarygodne(555, 26).odchylenie, 2035);

console.log('=== PRZESZŁO ===');
przeszlo.forEach((x) => console.log('  +', x));

if (nieprzeszlo.length > 0) {
  console.log('\n=== NIE PRZESZŁO ===');
  nieprzeszlo.forEach((x) => console.log('  -', x));
  console.log(`\nNIEPOWODZENIE: ${nieprzeszlo.length} z ${przeszlo.length + nieprzeszlo.length}.`);
  process.exit(1);
}

console.log(`\nWszystkie ${przeszlo.length} kontroli zakończone powodzeniem.`);
