/**
 * Automatyczne wypełnianie planu.
 *
 * Co ten plik robi, a czego nie
 * -----------------------------
 * Tu są WYŁĄCZNIE czyste funkcje: dostają stan planu i listę przepisów,
 * zwracają listę „co gdzie wstawić”. Nie dotykają bazy. Dzięki temu da się
 * je przetestować bez serwera — a przy doborze posiłków to nie jest luksus,
 * bo błąd w punktacji jest niewidoczny gołym okiem. Plan po prostu wychodzi
 * trochę gorszy i nikt nie wie dlaczego.
 *
 * Zapis do bazy robi `app/index.tsx`, wołając `dodajPartie` dla każdego wyniku.
 *
 * Jak działa dobór
 * ----------------
 * Idziemy dzień po dniu, w każdym dniu po kolei: śniadanie, obiad, kolacja.
 * Dla każdego wolnego miejsca liczymy, ILE BRAKUJE do celu dnia i dzielimy
 * to przez liczbę miejsc, które w tym dniu jeszcze zostały. Tak powstaje
 * „ile powinno mieć to jedno danie”. Potem każdemu kandydatowi wystawiamy
 * ocenę — im niższa, tym lepiej.
 *
 * Ocena składa się z czterech rzeczy:
 *
 *   1. KARA ZA KALORIE — odchylenie w obie strony. Za dużo jest tak samo
 *      niedobre jak za mało, bo cel kaloryczny to przedział, nie podłoga.
 *   2. KARA ZA BIAŁKO — tylko za niedobór. Białka nie ma sensu karać za
 *      nadmiar; przy tym celu to i tak rzadkość.
 *   3. PREMIA ZA PREFERENCJĘ — przesuwa lubiane dania w górę, ale nie
 *      unieważnia punktów 1 i 2. Danie lubiane, ale kompletnie nie na to
 *      miejsce, dalej przegra. „Nie proponuj” w ogóle tu nie dociera —
 *      patrz niżej.
 *   4. KARA ZA POWTÓRKĘ — im niedawniej dane danie było w planie, tym większa.
 *      Bez tego automat wstawiłby siedem razy ten sam ulubiony obiad.
 *
 * Na koniec dochodzi odrobina losowości. To ona sprawia, że przy przepisach
 * bez żadnej preferencji wynik nie jest zawsze identyczny — i że dwa dania
 * o zbliżonej ocenie wymieniają się miejscami między jednym a drugim
 * naciśnięciem przycisku.
 *
 * Preferencja jest WŁASNA, nie ogólna
 * ------------------------------------
 * Premia w punkcie 3 liczy się z preferencji KONTA, dla którego układany
 * jest plan — nie z tego, ile osób w ogóle polubiło dany przepis. Pierwsza
 * wersja tego pliku liczyła globalny licznik polubień, co przy jednym koncie
 * nie robiło różnicy, ale przy kilku kontach premiowałoby cudzy gust.
 *
 * „Nie proponuj” nie jest karą — jest wykluczeniem
 * --------------------------------------------------
 * Danie oznaczone jako „nie proponuj” nie dostaje gorszej oceny. W ogóle nie
 * wchodzi do listy kandydatów (`nadajeSieNa` odrzuca je na starcie). Gdyby to
 * była tylko duża kara, przy braku innych pasujących dań automat i tak by je
 * wstawił — a „nie proponuj” ma znaczyć NIGDY SAM, nie „tylko w ostateczności”.
 *
 * Świadome uproszczenie
 * ---------------------
 * Danie wstawione na trzy dni jest oceniane pod kątem PIERWSZEGO z nich.
 * Poprawne byłoby ocenianie wszystkich trzech naraz, ale to zmienia zadanie
 * z „wybierz najlepsze danie” w „ułóż optymalny tydzień” — a to już jest
 * problem, który potrafi liczyć się sekundami. Skutki uboczne tego skrótu
 * widać potem na paskach makro i poprawia się je ręcznie.
 */

import type { PoraPosilku, Preferencja } from './przepisy';

/** Kolejność wypełniania w obrębie dnia. */
export const PORY_AUTOMATU: PoraPosilku[] = ['sniadanie', 'obiad', 'kolacja'];

/** Co automat musi wiedzieć o przepisie. */
export type Kandydat = {
  id: string;
  nazwa: string;
  pory: PoraPosilku[];
  liczba_porcji_bazowych: number;
  kcal: number | null;
  bialko_g: number | null;
  /** Preferencja KONTA, dla którego układamy plan — nie popularność ogólna. */
  preferencja: Preferencja;
};

export type Miejsce = { data: string; pora: PoraPosilku };

/** Jedno gotowanie: przepis, pora i dni, na które się rozkłada. */
export type Wstawienie = {
  przepisId: string;
  nazwa: string;
  pora: PoraPosilku;
  odData: string;
  /** Kolejne dni objęte tym samym garnkiem. Pierwszy z nich to `odData`. */
  dni: string[];
};

export type WynikPlanowania = {
  wstawienia: Wstawienie[];
  /** Miejsca, których nie dało się wypełnić — brakło pasujących przepisów. */
  bezObsady: Miejsce[];
};

/** Premia dania oznaczonego jako „ulubione” — ma się pojawiać najczęściej. */
const WAGA_ULUBIONE = 1.2;

/** Premia dania oznaczonego jako „lubię” — to dawny, binarny „lajk”. */
const WAGA_LUBIE = 0.5;

/**
 * Premia za preferencję konta. „Neutralne” nie dostaje nic, a „nie_proponuj”
 * tu w ogóle nie dociera — `nadajeSieNa` odrzuca takie dania, zanim trafią
 * do oceny.
 */
function premiaZaPreferencje(preferencja: Preferencja): number {
  if (preferencja === 'ulubione') return WAGA_ULUBIONE;
  if (preferencja === 'lubie') return WAGA_LUBIE;
  return 0;
}

/** Kara za danie użyte poprzedniego dnia. Maleje z każdym dniem odstępu. */
const KARA_POWTORKI = 3;

/** Wielkość losowego zaburzenia oceny. */
const SZUM = 0.3;

/**
 * Widełki, poniżej których nie schodzimy przy dzieleniu.
 * Bez nich dzień prawie domknięty dawałby dzielenie przez wartość bliską zeru
 * i pojedyncza kaloria różnicy rozstrzygałaby o wyborze dania.
 */
const MIN_KCAL_ODNIESIENIA = 250;
const MIN_BIALKA_ODNIESIENIA = 12;

/**
 * Czy przepis nadaje się na tę porę JAKO DANIE GŁÓWNE.
 *
 * Różni się od `pasujeDoPory` z `lib/przepisy.ts` jedną rzeczą: dodatki się
 * nie liczą. Przy ręcznym wybieraniu sensownie jest pokazywać surówkę przy
 * każdym posiłku, bo dokładasz ją do czegoś. Automat wypełnia PUSTE miejsce,
 * więc sama sałatka z ciecierzycy nie może zostać całą kolacją.
 */
export function nadajeSieNa(k: Kandydat, pora: PoraPosilku): boolean {
  if (k.preferencja === 'nie_proponuj') return false;
  if (k.kcal === null) return false;
  if (k.pory.length === 0) return false;
  return k.pory.includes(pora);
}

/** Klucz miejsca w planie — używany do sprawdzania zajętości. */
function klucz(data: string, pora: PoraPosilku): string {
  return `${data}|${pora}`;
}

/**
 * Dni, na które realnie rozłoży się jedno gotowanie.
 *
 * Nie wystarczy wziąć liczby porcji bazowych przepisu. Kolejny dzień może już mieć coś
 * wpisanego ręcznie, a wtedy dołożenie tam drugiego dania byłoby cichym
 * nadpisaniem decyzji użytkownika. Bierzemy więc tylko dni KOLEJNE I WOLNE —
 * pierwsza przeszkoda kończy serię.
 */
export function dniGotowania(
  dni: string[],
  odIndeksu: number,
  pora: PoraPosilku,
  liczbaPorcjiBazowych: number,
  zajete: Set<string>
): string[] {
  const ile = Math.max(1, liczbaPorcjiBazowych);
  const wynik: string[] = [];

  for (let i = odIndeksu; i < dni.length && wynik.length < ile; i++) {
    if (zajete.has(klucz(dni[i], pora))) break;
    wynik.push(dni[i]);
  }

  return wynik;
}

type StanDnia = { kcal: number; bialko: number };

/**
 * Ocena kandydata na konkretne miejsce. Im mniej, tym lepiej.
 *
 * Wyciągnięte osobno, żeby dało się to sprawdzić testem bez budowania
 * całego planu.
 */
export function ocen(opcje: {
  kandydat: Kandydat;
  /** Ile kalorii powinno przypaść na to jedno miejsce. */
  docelowoKcal: number;
  /** Ile białka powinno przypaść na to jedno miejsce. */
  docelowoBialko: number;
  /** Numer dnia, w którym przepis był użyty ostatnio. `null` = jeszcze nie był. */
  ostatnioWDniu: number | null;
  /** Numer bieżącego dnia, liczony od zera. */
  dzien: number;
  szum: number;
}): number {
  const { kandydat, docelowoKcal, docelowoBialko, ostatnioWDniu, dzien, szum } = opcje;

  const kcal = kandydat.kcal ?? 0;
  const bialko = kandydat.bialko_g ?? 0;

  const odniesienieKcal = Math.max(docelowoKcal, MIN_KCAL_ODNIESIENIA);
  const odniesienieBialka = Math.max(docelowoBialko, MIN_BIALKA_ODNIESIENIA);

  const karaKcal = Math.abs(kcal - docelowoKcal) / odniesienieKcal;
  const karaBialka = Math.max(0, docelowoBialko - bialko) / odniesienieBialka;

  const premia = premiaZaPreferencje(kandydat.preferencja);

  const karaPowtorki =
    ostatnioWDniu === null ? 0 : KARA_POWTORKI / (1 + (dzien - ostatnioWDniu));

  return karaKcal + karaBialka - premia + karaPowtorki + szum;
}

/**
 * Układa plan na wolnych miejscach.
 *
 * Nie rusza niczego, co już stoi w planie — decyzja Romana: „tylko puste
 * miejsca”. Od zera służy osobny przycisk czyszczący.
 */
export function zaplanuj(opcje: {
  dni: string[];
  /** Miejsca już zajęte przez istniejące posiłki. */
  zajete: Miejsce[];
  /** Co już stoi w każdym dniu — po to, żeby dobierać resztę pod cel. */
  makroDni: Map<string, StanDnia>;
  przepisy: Kandydat[];
  /** Dzienny cel. `null` wyłącza dobór pod cel i zostawia sam ranking. */
  celKcal: number | null;
  celBialko: number | null;
  /** Wstrzykiwane, żeby test mógł podać wartość stałą. */
  losowo?: () => number;
}): WynikPlanowania {
  const { dni, zajete, makroDni, przepisy, celKcal, celBialko } = opcje;
  const losowo = opcje.losowo ?? Math.random;

  const zajeteKlucze = new Set(zajete.map((m) => klucz(m.data, m.pora)));
  const stan = new Map<string, StanDnia>();
  for (const d of dni) {
    stan.set(d, { ...(makroDni.get(d) ?? { kcal: 0, bialko: 0 }) });
  }

  const ostatnieUzycie = new Map<string, number>();
  const wstawienia: Wstawienie[] = [];
  const bezObsady: Miejsce[] = [];

  for (let i = 0; i < dni.length; i++) {
    const data = dni[i];

    for (const pora of PORY_AUTOMATU) {
      if (zajeteKlucze.has(klucz(data, pora))) continue;

      const kandydaci = przepisy.filter((k) => nadajeSieNa(k, pora));
      if (kandydaci.length === 0) {
        bezObsady.push({ data, pora });
        continue;
      }

      // Ile miejsc w tym dniu jeszcze czeka — razem z tym, które właśnie obsadzamy.
      const wolnychWDniu = PORY_AUTOMATU.filter(
        (p) => !zajeteKlucze.has(klucz(data, p))
      ).length;

      const teraz = stan.get(data) ?? { kcal: 0, bialko: 0 };
      const brakKcal = celKcal === null ? 0 : Math.max(0, celKcal - teraz.kcal);
      const brakBialka = celBialko === null ? 0 : Math.max(0, celBialko - teraz.bialko);

      const docelowoKcal = celKcal === null ? 0 : brakKcal / Math.max(1, wolnychWDniu);
      const docelowoBialko = celBialko === null ? 0 : brakBialka / Math.max(1, wolnychWDniu);

      let najlepszy = kandydaci[0];
      let najlepszaOcena = Infinity;

      for (const kandydat of kandydaci) {
        const wynik = ocen({
          kandydat,
          docelowoKcal,
          docelowoBialko,
          ostatnioWDniu: ostatnieUzycie.get(kandydat.id) ?? null,
          dzien: i,
          szum: losowo() * SZUM,
        });
        if (wynik < najlepszaOcena) {
          najlepszaOcena = wynik;
          najlepszy = kandydat;
        }
      }

      const objete = dniGotowania(dni, i, pora, najlepszy.liczba_porcji_bazowych, zajeteKlucze);
      if (objete.length === 0) continue; // nie powinno się zdarzyć: miejsce jest wolne

      wstawienia.push({
        przepisId: najlepszy.id,
        nazwa: najlepszy.nazwa,
        pora,
        odData: data,
        dni: objete,
      });

      for (const d of objete) {
        zajeteKlucze.add(klucz(d, pora));
        const s = stan.get(d);
        if (s) {
          s.kcal += najlepszy.kcal ?? 0;
          s.bialko += najlepszy.bialko_g ?? 0;
        }
      }
      ostatnieUzycie.set(najlepszy.id, i + objete.length - 1);
    }
  }

  return { wstawienia, bezObsady };
}

/**
 * Przenosi układ jednego tygodnia na drugi.
 *
 * Zachowuje GARNKI, a nie pojedyncze posiłki. Pozycje pochodzące z jednego
 * gotowania mają wspólne `partia_id`; gdyby przepisywać je pojedynczo,
 * barszcz rozłożony na trzy dni stałby się trzema osobnymi gotowaniami
 * i lista zakupów kazałaby kupić potrójną porcję mięsa.
 *
 * Pozycje bez `partia_id` (starsze wpisy) traktujemy jako osobne gotowania.
 */
export function powtorzTydzien(opcje: {
  /** Pozycje poprzedniego tygodnia. */
  zrodlo: {
    data: string;
    pora: PoraPosilku;
    przepis_id: string;
    nazwa: string;
    partia_id: string | null;
  }[];
  /** Pierwszy dzień poprzedniego tygodnia. */
  odDaty: string;
  /** Dni tygodnia docelowego. */
  dni: string[];
  /** Miejsca już zajęte w tygodniu docelowym. */
  zajete: Miejsce[];
}): WynikPlanowania {
  const { zrodlo, odDaty, dni, zajete } = opcje;

  const zajeteKlucze = new Set(zajete.map((m) => klucz(m.data, m.pora)));
  const start = Date.parse(odDaty);

  // Grupujemy po gotowaniu. Pozycje bez partii dostają własny, sztuczny klucz.
  const grupy = new Map<string, typeof zrodlo>();
  for (const p of zrodlo) {
    const g = p.partia_id ?? `sam:${p.data}|${p.pora}|${p.przepis_id}`;
    grupy.set(g, [...(grupy.get(g) ?? []), p]);
  }

  const wstawienia: Wstawienie[] = [];
  const bezObsady: Miejsce[] = [];

  for (const grupa of grupy.values()) {
    const posortowana = [...grupa].sort((a, b) => a.data.localeCompare(b.data));

    // Przesunięcie liczymy w dniach od początku tygodnia źródłowego.
    const objete: string[] = [];
    let kolizja = false;

    for (const p of posortowana) {
      const przesuniecie = Math.round((Date.parse(p.data) - start) / 86400000);
      const cel = dni[przesuniecie];
      if (!cel) {
        kolizja = true; // pozycja wypada poza krótszy tydzień docelowy
        continue;
      }
      if (zajeteKlucze.has(klucz(cel, p.pora))) {
        bezObsady.push({ data: cel, pora: p.pora });
        kolizja = true;
        continue;
      }
      objete.push(cel);
    }

    // Garnek przenosimy w całości albo wcale. Przeniesienie połowy oznaczałoby
    // ugotowanie trzech porcji i zaplanowanie dwóch — reszta poszłaby do kosza.
    if (kolizja || objete.length === 0) continue;

    wstawienia.push({
      przepisId: posortowana[0].przepis_id,
      nazwa: posortowana[0].nazwa,
      pora: posortowana[0].pora,
      odData: objete[0],
      dni: objete,
    });

    for (const d of objete) zajeteKlucze.add(klucz(d, posortowana[0].pora));
  }

  return { wstawienia, bezObsady };
}
