/**
 * Wyciąga dania ze strony starego planera do planer-html-dania.json.
 *
 *     node narzedzia/wczytaj-planer.mjs sciezka/do/index.html
 *
 * Po co osobny skrypt
 * -------------------
 * Planer żyje — dopisujesz do niego dania i poprawiasz składniki. Za każdym
 * razem przepisywanie trzydziestu przepisów ręcznie byłoby proszeniem się
 * o literówkę w gramaturze. Tutaj wystarczy podać nowy plik.
 *
 * Skrypt NIE nadpisuje mapowania ani wygenerowanego SQL-a — to osobne kroki
 * (generuj-import.mjs). Zmiana danych źródłowych nie ma prawa po cichu
 * zmienić przepisów, które są już w bazie.
 */

import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const KATALOG = dirname(fileURLToPath(import.meta.url));

/**
 * Wyjmuje tablicę DISHES ze strony.
 *
 * Tablica jest zapisana jako literał JavaScriptu z kluczami bez cudzysłowów,
 * więc JSON.parse jej nie przeczyta. Wykonujemy więc sam ten fragment —
 * to czyste dane, bez wywołań funkcji.
 */
export function wyjmijDania(html) {
  const poczatek = html.indexOf('const DISHES = [');
  if (poczatek === -1) throw new Error('Nie znalazłem tablicy DISHES — czy to na pewno plik planera?');

  const koniec = html.indexOf('\n];', poczatek);
  if (koniec === -1) throw new Error('Tablica DISHES nie ma zakończenia.');

  const kod = html.slice(poczatek + 'const DISHES = '.length, koniec + 2);
  return new Function('return ' + kod)();
}

/** Zamiana zapisu planera na nasz — czytelne nazwy pól zamiast skrótów. */
export function naNaszFormat(d) {
  const czas = parseInt(String(d.time), 10);
  if (!Number.isFinite(czas)) throw new Error(`„${d.n}” — nie umiem odczytać czasu „${d.time}”`);

  return {
    grupa: d.g,
    nazwa: d.n,
    kcal: d.kcal,
    bialko: d.prot,
    czas_min: czas,
    garnek: d.batch ?? null,
    weekend: Boolean(d.wknd),
    skladniki: d.ing.map(([nazwa, ilosc, jednostka, dzial]) => [
      nazwa,
      ilosc ?? null,
      jednostka ?? '',
      dzial,
    ]),
    kroki: d.steps,
    wskazowka: d.tip ?? null,
  };
}

function main() {
  const sciezka = process.argv[2];
  if (!sciezka) {
    console.error('Podaj ścieżkę do index.html planera.');
    process.exit(1);
  }

  const dania = wyjmijDania(readFileSync(sciezka, 'utf8')).map(naNaszFormat);

  const wyjscie = join(KATALOG, 'planer-html-dania.json');
  const poprzednie = (() => {
    try {
      return JSON.parse(readFileSync(wyjscie, 'utf8')).dania;
    } catch {
      return [];
    }
  })();

  const stare = new Map(poprzednie.map((d) => [d.nazwa, d]));
  const nowe = dania.filter((d) => !stare.has(d.nazwa)).map((d) => d.nazwa);
  const zniknely = poprzednie.filter((d) => !dania.find((n) => n.nazwa === d.nazwa)).map((d) => d.nazwa);

  const tresc = {
    _opis: [
      'Dania wydobyte z Twojego starego planera HTML (romitu.github.io/dieta).',
      `Wczytane skryptem narzedzia/wczytaj-planer.mjs — ${new Date().toISOString().slice(0, 10)}.`,
      '',
      'To surowe dane wejściowe do importu. Plik jest GENEROWANY — nie poprawiaj',
      'go ręcznie, bo przy następnym wczytaniu poprawki znikną. Swoje decyzje',
      'zapisuj w narzedzia/mapowanie-planera.json.',
      '',
      'Pola:',
      '  grupa    — Śniadania / Obiady / Dania azjatyckie / Kolacje',
      '  kcal, bialko — na jedną porcję, wartości szacunkowe autora (±10%)',
      '  czas_min — czas podany na karcie dania',
      '  garnek   — na ile porcji sensownie gotować naraz (null = danie jednoporcjowe)',
      '  weekend  — danie oznaczone jako weekendowe',
      '  skladniki — [nazwa, ilość, jednostka, dział sklepu]; ilość null = „do smaku”',
      '  dzialy: m=mięso i ryby, w=warzywa i grzyby, n=nabiał i jaja, p=pieczywo,',
      '          s=sypkie i zboża, k=puszki i słoiki, z=mrożonki, t=tłuszcze, x=przyprawy',
    ],
    dania,
  };

  writeFileSync(wyjscie, JSON.stringify(tresc, null, 2) + '\n', 'utf8');

  console.log(`Wczytano ${dania.length} dań.`);
  if (nowe.length) console.log('  nowe:', nowe.join(', '));
  if (zniknely.length) console.log('  zniknęły:', zniknely.join(', '));
  console.log(`\nZapisano: narzedzia/planer-html-dania.json`);
  console.log('Przepisy w bazie NIE zmieniły się — uruchom generuj-import.mjs, jeśli chcesz je odświeżyć.');
}

if (process.argv[1] && process.argv[1].endsWith('wczytaj-planer.mjs')) {
  main();
}
