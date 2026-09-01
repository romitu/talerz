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

import { K_MAX, K_MIN } from './skalowanie-kalorii';
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
  /** Checkbox na przepisie (migracja 0036) — wolno automatowi rozciągać go pod cel kaloryczny? */
  skalowalny: boolean;
  /** Ile dni danie wytrzyma w lodówce — patrz `uwzglednijTrwalosc` w `zaplanuj`. */
  trwalosc_dni: number;
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
  /**
   * Ustawione, gdy danie zostało wybrane jako skalowalne — cel kaloryczny,
   * pod który TEN konkretny posiłek trzeba jeszcze przeliczyć i zapisać jako
   * wariant (patrz `lib/przepisy-skalowane.ts`). `null` = wstawiamy przepis
   * w bazowym rozmiarze, bez żadnego przeliczania.
   */
  celKcalDlaSkalowania: number | null;
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
 * Ile dni gotujemy na zapas.
 *
 * Danie może leżeć w lodówce kilka dni (`trwalosc_dni`), ale im więcej osób
 * je razem, tym mniej dni warto gotować na zapas — inaczej z jednego
 * gotowania wyszłoby absurdalnie dużo jedzenia (np. 4 osoby × 4 dni = 16
 * porcji naraz).
 *
 * Dlatego liczbę dni ucinamy tak, żeby łączna liczba porcji z jednego
 * gotowania (`osoby × dni`) nie przekroczyła tego limitu. Danie nigdy nie
 * jest przez to odrzucane — zawsze da się ugotować przynajmniej na jeden
 * dzień, bo limit jest ustawiony na tyle wysoko (≥ maksymalna liczba osób
 * na koncie), że nawet dla największej możliwej liczby osób starczy miejsca
 * na co najmniej jeden dzień. Efekt: dla 1-2 osób gotujemy na kilka dni
 * naraz, dla 3-4 osób — tylko na dziś.
 */
const LIMIT_PORCJI = 4;

/**
 * Ile dni faktycznie gotować na zapas — `trwalosc_dni` ucięte tak, żeby
 * `osoby × dni` nie przekroczyło `LIMIT_PORCJI`. Współdzielone przez automat
 * (`zaplanuj`) i ręczne wstawianie dania z checkboxem „uwzględnij trwałość”
 * (`app/index.tsx`), żeby oba działały tak samo.
 */
export function dniZLimitem(trwaloscDni: number, osoby: number): number {
  const dniWLimicie = Math.max(1, Math.floor(LIMIT_PORCJI / Math.max(1, osoby)));
  return Math.max(1, Math.min(trwaloscDni, dniWLimicie));
}

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
 * Kara za odchylenie wartości kandydata (kcal albo białko) od celu.
 *
 * Danie skalowalne (checkbox na przepisie, migracja 0036) da się rozciągnąć
 * w zakresie [K_MIN, K_MAX] razy jego bazowa wartość — jeśli cel mieści się
 * w tym zakresie, kara wynosi zero, bo `lib/skalowanie-kalorii.ts` i tak
 * dobierze k tak, żeby w niego trafić. Poza zakresem liczy się odległość do
 * NAJBLIŻSZEJ osiągalnej granicy, nie do samej wartości bazowej — inaczej
 * skalowalna „kromka” przegrywałaby z daniem, którego w ogóle nie da się
 * dociągnąć.
 *
 * `tylkoNiedobor` odtwarza dawne zachowanie kary za białko: nadmiar nie karze,
 * więc przy skalowalnym daniu liczy się wyłącznie górna granica zasięgu.
 */
function karaOdchylenia(
  wartosc: number,
  cel: number,
  odniesienie: number,
  skalowalny: boolean,
  tylkoNiedobor: boolean
): number {
  if (!skalowalny || wartosc <= 0) {
    return tylkoNiedobor ? Math.max(0, cel - wartosc) / odniesienie : Math.abs(wartosc - cel) / odniesienie;
  }

  const dolna = wartosc * K_MIN;
  const gorna = wartosc * K_MAX;

  if (tylkoNiedobor) return Math.max(0, cel - gorna) / odniesienie;
  if (cel < dolna) return (dolna - cel) / odniesienie;
  if (cel > gorna) return (cel - gorna) / odniesienie;
  return 0;
}

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

  const karaKcal = karaOdchylenia(kcal, docelowoKcal, odniesienieKcal, kandydat.skalowalny, false);
  const karaBialka = karaOdchylenia(bialko, docelowoBialko, odniesienieBialka, kandydat.skalowalny, true);

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
  /**
   * Rozkłada garnek na tyle kolejnych dni, ile danie wytrzyma w lodówce
   * (`trwalosc_dni`), zamiast na jego liczbę porcji bazowych — „wytrzyma
   * 3 dni” ma znaczyć „kopiuj ten obiad na 3 kolejne dni”. Domyślnie
   * wyłączone — dawne zachowanie (tylko liczba porcji bazowych).
   */
  uwzglednijTrwalosc?: boolean;
  /** Ile osób je z tego samego garnka — patrz `LIMIT_PORCJI`. Domyślnie 1. */
  osoby?: number;
  /** Wstrzykiwane, żeby test mógł podać wartość stałą. */
  losowo?: () => number;
}): WynikPlanowania {
  const { dni, zajete, makroDni, przepisy, celKcal, celBialko, uwzglednijTrwalosc = false, osoby = 1 } = opcje;
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

      // TRWAŁOŚĆ ma pierwszeństwo przed skalowaniem: gdy `uwzglednijTrwalosc`
      // jest włączone, „wytrzyma 3 dni w lodówce” ma znaczyć „kopiuj ten
      // posiłek na 3 kolejne dni” NAWET jeśli danie jest skalowalne — garnek
      // ugotowany raz i przeliczony pod cel pierwszego dnia dalej jest tym
      // samym garnkiem drugiego i trzeciego dnia, tylko zjadanym z lodówki.
      // Bez `uwzglednijTrwalosc` wariant skalowany zostaje na jeden posiłek
      // (każdy dzień ma inny cel, więc nie ma go z czym kopiować), w
      // przeciwnym razie liczba porcji bazowych decyduje jak dawniej.
      const uzyjSkalowania = najlepszy.skalowalny && (najlepszy.kcal ?? 0) > 0;
      const liczbaDni = uwzglednijTrwalosc
        ? dniZLimitem(najlepszy.trwalosc_dni, osoby)
        : uzyjSkalowania
          ? 1
          : najlepszy.liczba_porcji_bazowych;
      const objete = dniGotowania(dni, i, pora, liczbaDni, zajeteKlucze);
      if (objete.length === 0) continue; // nie powinno się zdarzyć: miejsce jest wolne

      // Do bieżącego bilansu dnia liczymy nie bazową wartość dania, tylko to,
      // co po skalowaniu realnie wyjdzie — ograniczone do [K_MIN, K_MAX], tak
      // samo jak zrobi to `lib/skalowanie-kalorii.ts` przy faktycznym zapisie.
      // Białko skalujemy proporcjonalnie do kalorii — dokładną wartość policzy
      // dopiero silnik, to tylko bilans wewnątrz automatu.
      let kcalWstawienia = najlepszy.kcal ?? 0;
      let bialkoWstawienia = najlepszy.bialko_g ?? 0;
      let celKcalDlaSkalowania: number | null = null;

      if (uzyjSkalowania) {
        const bazowyKcal = najlepszy.kcal ?? 0;
        const dolna = bazowyKcal * K_MIN;
        const gorna = bazowyKcal * K_MAX;
        const celOgraniczony = Math.min(gorna, Math.max(dolna, docelowoKcal));
        celKcalDlaSkalowania = celOgraniczony;
        kcalWstawienia = celOgraniczony;
        bialkoWstawienia = (najlepszy.bialko_g ?? 0) * (celOgraniczony / bazowyKcal);
      }

      wstawienia.push({
        przepisId: najlepszy.id,
        nazwa: najlepszy.nazwa,
        pora,
        odData: data,
        dni: objete,
        celKcalDlaSkalowania,
      });

      for (const d of objete) {
        zajeteKlucze.add(klucz(d, pora));
        const s = stan.get(d);
        if (s) {
          s.kcal += kcalWstawienia;
          s.bialko += bialkoWstawienia;
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
      // Powtórka tygodnia wstawia przepis w bazowym rozmiarze, nawet jeśli
      // źródłowy posiłek był wariantem skalowanym — przeliczanie pod (inny)
      // dzienny bilans docelowego tygodnia to osobna sprawa, tu jej nie ma.
      celKcalDlaSkalowania: null,
    });

    for (const d of objete) zajeteKlucze.add(klucz(d, posortowana[0].pora));
  }

  return { wstawienia, bezObsady };
}
