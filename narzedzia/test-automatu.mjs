/**
 * Test automatu układającego plan.
 *
 *     node narzedzia/test-automatu.mjs
 *
 * Po co
 * -----
 * Błąd w doborze posiłków nie objawia się awarią. Plan po prostu wychodzi
 * gorszy — te same dania siedem razy, obiad wciśnięty na zajęte miejsce,
 * dzień na 900 kcal przy celu 2000 — i nikt tego nie zauważy, dopóki nie
 * policzy ręcznie. Dlatego reguły doboru mają test, choć są „tylko” arytmetyką.
 *
 * `lib/automat.ts` nie dotyka bazy, więc wystarczy go skompilować i wywołać.
 * Kompilacja idzie do katalogu tymczasowego, żeby nie zaśmiecać projektu.
 */

import { execFileSync } from 'node:child_process';
import { mkdtempSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { pathToFileURL } from 'node:url';

const korzen = path.resolve(import.meta.dirname, '..');
const kosz = mkdtempSync(path.join(tmpdir(), 'talerz-automat-'));

execFileSync(
  'npx',
  ['tsc', 'lib/automat.ts', '--outDir', kosz, '--module', 'es2022', '--target', 'es2022',
   '--moduleResolution', 'bundler', '--skipLibCheck'],
  { cwd: korzen, stdio: 'inherit' }
);

const { zaplanuj, powtorzTydzien, ocen, dniGotowania, nadajeSieNa } = await import(
  pathToFileURL(path.join(kosz, 'automat.js')).href
);

const bledy = [];
function sprawdz(opis, warunek, dodatek = '') {
  if (warunek) console.log(`  ok   ${opis}`);
  else {
    console.log(`  ZLE  ${opis} ${dodatek}`);
    bledy.push(opis);
  }
}

const DNI = ['2026-08-17', '2026-08-18', '2026-08-19', '2026-08-20',
             '2026-08-21', '2026-08-22', '2026-08-23'];

function danie(id, pory, kcal, bialko, porcjeBazowe = 0, preferencja = 'neutralne', skalowalny = false, trwaloscDni = 3) {
  return {
    id, nazwa: id, pory, liczba_porcji_bazowych: porcjeBazowe, kcal, bialko_g: bialko,
    preferencja, skalowalny, trwalosc_dni: trwaloscDni,
  };
}

// Losowość wyłączona — inaczej test bywałby raz zielony, raz czerwony.
const BEZ_LOSU = () => 0;

const PRZEPISY = [
  danie('owsianka', ['sniadanie'], 635, 29),
  danie('tosty', ['sniadanie'], 680, 38),
  danie('twarog', ['sniadanie'], 640, 49),
  danie('barszcz', ['obiad'], 700, 40, 3),
  danie('gulasz', ['obiad'], 800, 45, 3),
  danie('dorsz', ['obiad'], 650, 42, 2),
  danie('salatka', ['kolacja'], 500, 30),
  danie('kanapki', ['kolacja'], 665, 67),
  danie('surowka', ['dodatek'], 90, 2),
];

// --- 1. wypełnianie pustego tygodnia ----------------------------------------
{
  const { wstawienia, bezObsady } = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(), przepisy: PRZEPISY,
    celKcal: 2048, celBialko: 140, losowo: BEZ_LOSU,
  });

  const miejsca = wstawienia.flatMap((w) => w.dni.map((d) => `${d}|${w.pora}`));
  sprawdz('wypełnia wszystkie 21 miejsc', miejsca.length === 21, `(jest ${miejsca.length})`);
  sprawdz('żadne miejsce nie dostaje dwóch dań', new Set(miejsca).size === miejsca.length);
  sprawdz('nie zgłasza miejsc bez obsady', bezObsady.length === 0);

  const uzyte = wstawienia.map((w) => w.przepisId);
  sprawdz('dodatek nie zostaje daniem głównym', !uzyte.includes('surowka'));

  // Każde danie na właściwej porze.
  const zlaPora = wstawienia.filter((w) => {
    const p = PRZEPISY.find((x) => x.id === w.przepisId);
    return !p.pory.includes(w.pora);
  });
  sprawdz('każde danie trafia na swoją porę', zlaPora.length === 0,
          zlaPora.map((w) => `${w.przepisId}->${w.pora}`).join(', '));
  sprawdz('żadne wstawienie bez skalowania nie ma celKcalDlaSkalowania',
          wstawienia.every((w) => w.celKcalDlaSkalowania === null));
}

// --- 2. gotowanie rozkłada się na kilka dni ----------------------------------
{
  const { wstawienia } = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [danie('owsianka', ['sniadanie'], 635, 29),
               danie('barszcz', ['obiad'], 700, 40, 3),
               danie('kanapki', ['kolacja'], 665, 67)],
    celKcal: 2000, celBialko: 136, losowo: BEZ_LOSU,
  });

  const obiady = wstawienia.filter((w) => w.pora === 'obiad');
  sprawdz('barszcz o 3 porcjach bazowych daje 3 gotowania na 7 dni',
          obiady.length === 3, `(jest ${obiady.length})`);
  sprawdz('pierwszy garnek obejmuje 3 kolejne dni',
          obiady[0].dni.length === 3 && obiady[0].dni[0] === DNI[0] && obiady[0].dni[2] === DNI[2],
          JSON.stringify(obiady[0].dni));
  sprawdz('ostatni garnek skraca się do końca tygodnia',
          obiady[2].dni.length === 1, JSON.stringify(obiady[2].dni));

  const sniadania = wstawienia.filter((w) => w.pora === 'sniadanie');
  sprawdz('danie o 0 porcjach bazowych gotuje się codziennie', sniadania.length === 7);
}

// --- 3. zajęte miejsca zostają nietknięte ------------------------------------
{
  const zajete = [
    { data: DNI[0], pora: 'obiad' },
    { data: DNI[3], pora: 'sniadanie' },
  ];
  const { wstawienia } = zaplanuj({
    dni: DNI, zajete,
    makroDni: new Map([[DNI[0], { kcal: 900, bialko: 50 }]]),
    przepisy: PRZEPISY, celKcal: 2048, celBialko: 140, losowo: BEZ_LOSU,
  });

  const miejsca = new Set(wstawienia.flatMap((w) => w.dni.map((d) => `${d}|${w.pora}`)));
  sprawdz('nie wchodzi na zajęty obiad', !miejsca.has(`${DNI[0]}|obiad`));
  sprawdz('nie wchodzi na zajęte śniadanie', !miejsca.has(`${DNI[3]}|sniadanie`));
  sprawdz('dokłada pozostałe 19 miejsc', miejsca.size === 19, `(jest ${miejsca.size})`);
}

// --- 4. garnek zatrzymuje się przed zajętym dniem ----------------------------
{
  // Obiad drugiego dnia zajęty ręcznie. Garnek startujący pierwszego dnia
  // musi się skrócić do jednego dnia zamiast przykryć wpis użytkownika.
  const zajete = [{ data: DNI[1], pora: 'obiad' }];
  const { wstawienia } = zaplanuj({
    dni: DNI, zajete, makroDni: new Map(),
    przepisy: [danie('barszcz', ['obiad'], 700, 40, 3)],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
  });

  const pierwszy = wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('garnek zatrzymuje się przed zajętym dniem',
          pierwszy.dni.length === 1, JSON.stringify(pierwszy.dni));
}

// --- 5. kara za powtórki -----------------------------------------------------
{
  // Trzy równoważne śniadania, żadnych polubień, cel spełniony przez każde.
  const { wstawienia } = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [danie('a', ['sniadanie'], 600, 30),
               danie('b', ['sniadanie'], 600, 30),
               danie('c', ['sniadanie'], 600, 30)],
    celKcal: 1800, celBialko: 90, losowo: BEZ_LOSU,
  });

  const kolejne = wstawienia.map((w) => w.przepisId);
  const podRzad = kolejne.filter((x, i) => i > 0 && x === kolejne[i - 1]).length;
  sprawdz('to samo danie nie wypada dwa dni pod rząd', podRzad === 0, kolejne.join(','));
  sprawdz('automat korzysta z wszystkich trzech przepisów',
          new Set(kolejne).size === 3, kolejne.join(','));
}

// --- 6. preferencja przesuwa wybór, ale nie unieważnia dopasowania ----------
{
  const ulubione = danie('ulubione', ['kolacja'], 500, 30, 0, 'ulubione');
  const lubiane = danie('lubiane', ['kolacja'], 500, 30, 0, 'lubie');
  const zwykle = danie('zwykle', ['kolacja'], 500, 30, 0, 'neutralne');

  const ocenaZwyklego = ocen({
    kandydat: zwykle, docelowoKcal: 500, docelowoBialko: 30,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  const ocenaLubianego = ocen({
    kandydat: lubiane, docelowoKcal: 500, docelowoBialko: 30,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  const ocenaUlubionego = ocen({
    kandydat: ulubione, docelowoKcal: 500, docelowoBialko: 30,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  sprawdz('przy równym dopasowaniu wygrywa lubiane', ocenaLubianego < ocenaZwyklego);
  sprawdz('ulubione wygrywa z lubianym', ocenaUlubionego < ocenaLubianego);

  // A teraz lubiane, ale kompletnie nie na to miejsce.
  const lubianeAleZle = danie('lubiane-zle', ['kolacja'], 2500, 30, 0, 'lubie');
  const ocenaZlego = ocen({
    kandydat: lubianeAleZle, docelowoKcal: 500, docelowoBialko: 30,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  sprawdz('lubiane, ale trzykrotnie za kaloryczne, przegrywa', ocenaZlego > ocenaZwyklego);
}

// --- 7. dobór pod cel --------------------------------------------------------
{
  // Dzień zaczyna się z 1500 kcal na koncie, cel 2048, zostaje jedno miejsce.
  // Powinno wygrać danie ok. 550 kcal, nie 900.
  const { wstawienia } = zaplanuj({
    dni: [DNI[0]],
    zajete: [{ data: DNI[0], pora: 'sniadanie' }, { data: DNI[0], pora: 'obiad' }],
    makroDni: new Map([[DNI[0], { kcal: 1500, bialko: 100 }]]),
    przepisy: [danie('lekka', ['kolacja'], 550, 35), danie('ciezka', ['kolacja'], 900, 35)],
    celKcal: 2048, celBialko: 140, losowo: BEZ_LOSU,
  });
  sprawdz('do domknięcia dnia wybiera lżejsze danie',
          wstawienia[0]?.przepisId === 'lekka', wstawienia[0]?.przepisId);
}

// --- 8. brak przepisów na porę ----------------------------------------------
{
  const { wstawienia, bezObsady } = zaplanuj({
    dni: [DNI[0]], zajete: [], makroDni: new Map(),
    przepisy: [danie('owsianka', ['sniadanie'], 635, 29)],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
  });
  sprawdz('wypełnia to, co się da', wstawienia.length === 1);
  sprawdz('zgłasza obiad i kolację jako bez obsady', bezObsady.length === 2,
          JSON.stringify(bezObsady));
}

// --- 9. funkcje pomocnicze ---------------------------------------------------
{
  sprawdz('przepis bez makro nie jest kandydatem',
          !nadajeSieNa(danie('brak', ['obiad'], null, null), 'obiad'));
  sprawdz('przepis bez kategorii nie jest kandydatem',
          !nadajeSieNa(danie('nijaki', [], 600, 30), 'obiad'));
  sprawdz('"nie proponuj" wyklucza danie całkowicie, nie tylko obniża ocenę',
          !nadajeSieNa(danie('odrzucone', ['obiad'], 600, 30, 0, 'nie_proponuj'), 'obiad'));
  sprawdz('ulubione i lubiane dalej są kandydatami',
          nadajeSieNa(danie('x', ['obiad'], 600, 30, 0, 'ulubione'), 'obiad')
          && nadajeSieNa(danie('y', ['obiad'], 600, 30, 0, 'lubie'), 'obiad'));
  sprawdz('0 porcji bazowych daje jeden dzień',
          dniGotowania(DNI, 0, 'obiad', 0, new Set()).length === 1);
  sprawdz('porcje bazowe nie wykraczają poza koniec tygodnia',
          dniGotowania(DNI, 6, 'obiad', 3, new Set()).length === 1);
}

// --- 10. powtórzenie tygodnia ------------------------------------------------
{
  const POPRZEDNIE = ['2026-08-10', '2026-08-11', '2026-08-12'];
  const zrodlo = [
    { data: POPRZEDNIE[0], pora: 'sniadanie', przepis_id: 'owsianka', nazwa: 'Owsianka', partia_id: null },
    { data: POPRZEDNIE[0], pora: 'obiad', przepis_id: 'barszcz', nazwa: 'Barszcz', partia_id: 'p1' },
    { data: POPRZEDNIE[1], pora: 'obiad', przepis_id: 'barszcz', nazwa: 'Barszcz', partia_id: 'p1' },
    { data: POPRZEDNIE[2], pora: 'obiad', przepis_id: 'barszcz', nazwa: 'Barszcz', partia_id: 'p1' },
  ];

  const { wstawienia } = powtorzTydzien({
    zrodlo, odDaty: POPRZEDNIE[0], dni: DNI, zajete: [],
  });

  sprawdz('powtórzenie daje dwa gotowania, nie cztery posiłki',
          wstawienia.length === 2, `(jest ${wstawienia.length})`);

  const barszcz = wstawienia.find((w) => w.przepisId === 'barszcz');
  sprawdz('garnek zostaje garnkiem', barszcz.dni.length === 3, JSON.stringify(barszcz.dni));
  sprawdz('daty przesuwają się o właściwy odstęp',
          barszcz.dni[0] === DNI[0] && barszcz.dni[2] === DNI[2], JSON.stringify(barszcz.dni));

  // Zajęty jeden dzień garnka — całego garnka nie przenosimy.
  const zZajetym = powtorzTydzien({
    zrodlo, odDaty: POPRZEDNIE[0], dni: DNI,
    zajete: [{ data: DNI[1], pora: 'obiad' }],
  });
  sprawdz('garnek z jednym zajętym dniem nie wchodzi wcale',
          !zZajetym.wstawienia.some((w) => w.przepisId === 'barszcz'));
  sprawdz('reszta układu wchodzi mimo to',
          zZajetym.wstawienia.some((w) => w.przepisId === 'owsianka'));
  sprawdz('powtórzenie tygodnia nie skaluje (celKcalDlaSkalowania=null)',
          wstawienia.every((w) => w.celKcalDlaSkalowania === null));
}

// --- 11. skalowanie kaloryczne (checkbox "skalowalny", migracja 0036) -------
{
  // Kanapka "na kromkę": bazowo 300 kcal, ale checkbox skalowalny=true
  // pozwala rozciągnąć ją w zakresie [K_MIN, K_MAX] * 300 = [75, 1200].
  // Cel na to miejsce: 900 kcal — poza zasięgiem zwykłego dania (250 kcal
  // twarożku), ale w zasięgu kanapki po przeskalowaniu.
  const kanapka = danie('kanapka', ['sniadanie'], 300, 15, 0, 'neutralne', true);
  const twarozek = danie('twarozek', ['sniadanie'], 250, 20, 0, 'neutralne', false);

  const { wstawienia } = zaplanuj({
    dni: [DNI[0]],
    zajete: [{ data: DNI[0], pora: 'obiad' }, { data: DNI[0], pora: 'kolacja' }],
    makroDni: new Map([[DNI[0], { kcal: 1100, bialko: 60 }]]),
    przepisy: [kanapka, twarozek],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
  });

  sprawdz('skalowalna kanapka wygrywa z niedopasowanym twarożkiem mimo mniejszej bazowej wartości',
          wstawienia[0]?.przepisId === 'kanapka', wstawienia[0]?.przepisId);
  sprawdz('celKcalDlaSkalowania ustawione na ~900 (brakujące kcal na to miejsce)',
          Math.abs((wstawienia[0]?.celKcalDlaSkalowania ?? 0) - 900) < 1,
          wstawienia[0]?.celKcalDlaSkalowania);

  // Ocena bezpośrednio: kanapka (skalowalna) powinna dostać zerową karę
  // kaloryczną za cel w zasięgu [75, 1200], mimo że baza (300) daleko od 900.
  const ocenaKanapki = ocen({
    kandydat: kanapka, docelowoKcal: 900, docelowoBialko: 60,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  const ocenaTwarozku = ocen({
    kandydat: twarozek, docelowoKcal: 900, docelowoBialko: 60,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  sprawdz('skalowalna kanapka dostaje mniejszą karę niż niedopasowany twarożek',
          ocenaKanapki < ocenaTwarozku, `kanapka=${ocenaKanapki} twarozek=${ocenaTwarozku}`);

  // Cel poza zasięgiem [75, 1200] karze proporcjonalnie do odległości od granicy.
  const ocenaZaDuzoCelu = ocen({
    kandydat: kanapka, docelowoKcal: 5000, docelowoBialko: 60,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  sprawdz('cel poza górną granicą [K_MIN,K_MAX] daje karę > 0',
          ocenaZaDuzoCelu > 0, ocenaZaDuzoCelu);

  // Skalowalne danie nie karze nadmiaru białka (tylkoNiedobor=true).
  const bogataWBialko = danie('bogata', ['sniadanie'], 300, 100, 0, 'neutralne', true);
  const ocenaNadmiarBialka = ocen({
    kandydat: bogataWBialko, docelowoKcal: 300, docelowoBialko: 10,
    ostatnioWDniu: null, dzien: 0, szum: 0,
  });
  sprawdz('nadmiar białka przy skalowalnym daniu nie karze (kara białka = 0)',
          ocenaNadmiarBialka < 0.01, ocenaNadmiarBialka);
}

// --- 12. uwzglednijTrwalosc — trwałość, nie porcje bazowe, decyduje o dniach
{
  // "Dorsz po grecku": 1 porcja bazowa (jak wiele przepisów w praktyce), ale
  // trwałość 3 dni. Z opcją włączoną ma się skopiować na 3 kolejne dni —
  // trwałość PRZEBIJA liczbę porcji bazowych, nie jest tylko jej górną granicą.
  const dorsz = danie('dorsz', ['obiad'], 650, 42, 1, 'neutralne', false, 3);

  const bezOpcji = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [dorsz],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
  });
  const pierwszyBezOpcji = bezOpcji.wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('bez uwzglednijTrwalosc garnek rozkłada się na porcje bazowe (1 dzień)',
          pierwszyBezOpcji.dni.length === 1, JSON.stringify(pierwszyBezOpcji.dni));

  const zOpcja = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [dorsz],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
    uwzglednijTrwalosc: true,
  });
  const pierwszyZOpcja = zOpcja.wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('z uwzglednijTrwalosc garnek kopiuje się na trwałość (3 dni), mimo 1 porcji bazowej',
          pierwszyZOpcja.dni.length === 3, JSON.stringify(pierwszyZOpcja.dni));

  // I odwrotny przypadek: trwałość krótsza niż porcje bazowe też obowiązuje.
  const gulaszTrwaly = danie('gulaszTrwaly', ['kolacja'], 700, 40, 6, 'neutralne', false, 2);
  const zKrotszaTrwaloscia = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [gulaszTrwaly],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
    uwzglednijTrwalosc: true,
  });
  const pierwszyGulasz = zKrotszaTrwaloscia.wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('trwałość krótsza niż porcje bazowe (2 dni) też ogranicza rozłożenie',
          pierwszyGulasz.dni.length === 2, JSON.stringify(pierwszyGulasz.dni));

  // trwalosc_dni=0 ("tylko świeże") nie zeruje garnka — nadal co najmniej 1 dzień.
  const tylkoSwieze = danie('tylkoSwieze', ['kolacja'], 500, 30, 4, 'neutralne', false, 0);
  const zeSwiezym = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [tylkoSwieze],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
    uwzglednijTrwalosc: true,
  });
  const pierwszySwiezy = zeSwiezym.wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('trwałość 0 dni ("tylko świeże") nadal daje co najmniej 1 dzień',
          pierwszySwiezy.dni.length === 1, JSON.stringify(pierwszySwiezy.dni));

  // Skalowalne danie + uwzglednijTrwalosc: trwałość ma wygrywać. Bez opcji
  // wariant skalowany zostaje na jeden dzień (każdy dzień inny cel), ale
  // z opcją ma się skopiować na tyle dni, ile wytrzyma w lodówce — ten sam
  // garnek, przeliczony raz pod cel pierwszego dnia.
  const dorszSkalowalny = danie('dorszSkalowalny', ['obiad'], 650, 42, 1, 'neutralne', true, 3);

  const skalowalnyBezOpcji = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [dorszSkalowalny],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
  });
  const pierwszySkalowalnyBezOpcji = skalowalnyBezOpcji.wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('skalowalne danie bez uwzglednijTrwalosc zostaje na jeden dzień',
          pierwszySkalowalnyBezOpcji.dni.length === 1, JSON.stringify(pierwszySkalowalnyBezOpcji.dni));
  sprawdz('skalowalne danie bez uwzglednijTrwalosc dalej ma ustawiony cel skalowania',
          pierwszySkalowalnyBezOpcji.celKcalDlaSkalowania !== null);

  const skalowalnyZOpcja = zaplanuj({
    dni: DNI, zajete: [], makroDni: new Map(),
    przepisy: [dorszSkalowalny],
    celKcal: 2000, celBialko: 140, losowo: BEZ_LOSU,
    uwzglednijTrwalosc: true,
  });
  const pierwszySkalowalnyZOpcja = skalowalnyZOpcja.wstawienia.find((w) => w.odData === DNI[0]);
  sprawdz('trwałość PRZEBIJA skalowanie: garnek kopiuje się na 3 dni mimo checkboxu skalowalny',
          pierwszySkalowalnyZOpcja.dni.length === 3, JSON.stringify(pierwszySkalowalnyZOpcja.dni));
  sprawdz('mimo priorytetu trwałości, danie nadal jest przeliczone (celKcalDlaSkalowania ustawione)',
          pierwszySkalowalnyZOpcja.celKcalDlaSkalowania !== null);
}

rmSync(kosz, { recursive: true, force: true });

console.log();
if (bledy.length) {
  console.log(`NIEUDANE: ${bledy.length}`);
  for (const b of bledy) console.log('  -', b);
  process.exit(1);
}
console.log('Wszystkie sprawdzenia przeszły.');
