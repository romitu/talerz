/**
 * Wyliczenia żywieniowe.
 *
 * Wszystko, co przelicza liczby, siedzi w tym jednym pliku — osobno od ekranów.
 * Dzięki temu da się to przetestować bez uruchamiania aplikacji, a wzory
 * stoją w jednym miejscu, zamiast być rozsiane po interfejsie.
 *
 * Źródła:
 *   * przemiana podstawowa — wzór Mifflina-St Jeora
 *   * zakresy makroskładników — AMDR (białko 10-35%, tłuszcz 20-35%, węglowodany 45-65%)
 *
 * UWAGA: współczynniki białka na kilogram masy ciała celowo NIE są tu wpisane.
 * Wymagają odczytania z Norm żywienia dla populacji Polski (NIZP-PZH, 2024).
 * Do tego czasu cel białkowy ustawia użytkownik ręcznie, a aplikacja go pilnuje.
 */

export type Plec = 'K' | 'M';

export type PoziomAktywnosci = 'siedzacy' | 'lekki' | 'umiarkowany' | 'duzy' | 'bardzo_duzy';

export type Makro = {
  kcal: number;
  bialko: number;
  tluszcz: number;
  wegle: number;
};

/** Zalecenia dotyczące błonnika — różnią się między źródłami, więc podajemy wszystkie. */
export const BLONNIK = {
  /** Gramy na każde 1000 kcal — podstawa podpowiedzi. */
  naTysiacKcal: 14,
  /** EFSA: wartość wystarczająca dla dorosłych. */
  efsaDorosli: 25,
  /** EFSA: dopuszczalne obniżenie u osób starszych. */
  efsaStarsi: 20,
  /** WHO. */
  whoOd: 27,
  whoDo: 40,
} as const;

/**
 * Podpowiadany cel błonnikowy: 14 g na każde 1000 kcal.
 *
 * Skaluje się z zapotrzebowaniem, więc osoba jedząca 1600 kcal i osoba jedząca
 * 2800 kcal nie dostaną tej samej liczby. Wartość jest podpowiedzią —
 * użytkownik może ją nadpisać.
 */
export function podpowiedzBlonnika(kcal: number): number {
  return Math.round((kcal / 1000) * BLONNIK.naTysiacKcal);
}

/**
 * Orientacyjne dzienne zapotrzebowanie na płyny, w mililitrach.
 *
 * Przyjmujemy 30 ml na kilogram masy ciała. To WSKAZÓWKA, nie cel —
 * aplikacja nie liczy wypitej wody, bo nie pochodzi ona z przepisów.
 *
 * Zapotrzebowanie rośnie przy wysiłku i upale, a przy chorobach nerek i serca
 * bywa ograniczane przez lekarza. Dlatego pokazujemy je z zastrzeżeniem.
 */
export function wskazowkaWodna(wagaKg: number): number {
  return Math.round((wagaKg * 30) / 100) * 100;
}

/** Ile kalorii daje gram każdego składnika. */
export const KCAL_NA_GRAM = { bialko: 4, tluszcz: 9, wegle: 4 } as const;

/** Zakresy AMDR — udział w energii dziennej. */
export const AMDR = {
  bialko: { min: 10, max: 35 },
  tluszcz: { min: 20, max: 35 },
  wegle: { min: 45, max: 65 },
} as const;

export const AKTYWNOSC: Record<PoziomAktywnosci, { mnoznik: number; opis: string }> = {
  siedzacy: { mnoznik: 1.2, opis: 'praca siedząca, brak ćwiczeń' },
  lekki: { mnoznik: 1.375, opis: 'lekkie ćwiczenia 1–3 razy w tygodniu' },
  umiarkowany: { mnoznik: 1.55, opis: 'ćwiczenia 3–5 razy w tygodniu' },
  duzy: { mnoznik: 1.725, opis: 'ćwiczenia 6–7 razy w tygodniu' },
  bardzo_duzy: { mnoznik: 1.9, opis: 'praca fizyczna lub dwa treningi dziennie' },
};

/** Największy dopuszczalny deficyt dzienny — około 1 kg tygodniowo. */
export const MAKS_DEFICYT_KCAL = 1000;

/**
 * Przemiana podstawowa według wzoru Mifflina-St Jeora.
 * Tyle energii organizm zużywa w spoczynku — poniżej tej wartości nie schodzimy.
 */
export function przemianaPodstawowa(
  plec: Plec,
  wagaKg: number,
  wzrostCm: number,
  wiekLat: number
): number {
  return Math.round(przemianaDokladna(plec, wagaKg, wzrostCm, wiekLat));
}

/**
 * Ta sama przemiana, ale bez zaokrąglenia.
 *
 * Używana wewnętrznie do dalszych obliczeń: zaokrąglenie przed pomnożeniem
 * przez współczynnik aktywności gubi ułamek i przesuwa wynik o kilka kalorii.
 */
function przemianaDokladna(
  plec: Plec,
  wagaKg: number,
  wzrostCm: number,
  wiekLat: number
): number {
  const podstawa = 10 * wagaKg + 6.25 * wzrostCm - 5 * wiekLat;
  return podstawa + (plec === 'M' ? 5 : -161);
}

/** Całkowite zapotrzebowanie: przemiana podstawowa razy współczynnik aktywności. */
export function zapotrzebowanie(
  plec: Plec,
  wagaKg: number,
  wzrostCm: number,
  wiekLat: number,
  aktywnosc: PoziomAktywnosci
): number {
  return Math.round(przemianaDokladna(plec, wagaKg, wzrostCm, wiekLat) * AKTYWNOSC[aktywnosc].mnoznik);
}

/** Wiek w pełnych latach. */
export function wiekZDaty(dataUrodzenia: string, dzisiaj = new Date()): number {
  const urodziny = new Date(dataUrodzenia);
  let lata = dzisiaj.getFullYear() - urodziny.getFullYear();
  const miesiac = dzisiaj.getMonth() - urodziny.getMonth();
  if (miesiac < 0 || (miesiac === 0 && dzisiaj.getDate() < urodziny.getDate())) {
    lata -= 1;
  }
  return lata;
}

/** Kalorie pochodzące z podanych gramatur makroskładników. */
export function kcalZMakro(bialko: number, tluszcz: number, wegle: number): number {
  return Math.round(
    bialko * KCAL_NA_GRAM.bialko + tluszcz * KCAL_NA_GRAM.tluszcz + wegle * KCAL_NA_GRAM.wegle
  );
}

/** Udział procentowy każdego makroskładnika w energii dziennej. */
export function udzialyProcentowe(makro: Makro) {
  const suma = kcalZMakro(makro.bialko, makro.tluszcz, makro.wegle) || 1;
  return {
    bialko: Math.round((makro.bialko * KCAL_NA_GRAM.bialko * 1000) / suma) / 10,
    tluszcz: Math.round((makro.tluszcz * KCAL_NA_GRAM.tluszcz * 1000) / suma) / 10,
    wegle: Math.round((makro.wegle * KCAL_NA_GRAM.wegle * 1000) / suma) / 10,
  };
}

export type Ocena = {
  /** Powody, dla których celów NIE wolno zapisać. */
  blokady: string[];
  /** Odstępstwa od zaleceń — można je świadomie zaakceptować. */
  ostrzezenia: string[];
};

/**
 * Sprawdza cele według zasady: blokujemy niebezpieczeństwo, nie nietypowość.
 *
 * Blokady dotyczą wartości realnie groźnych. Wyjście poza zakresy AMDR jest
 * jedynie ostrzeżeniem — plan wysokobiałkowy potrafi mieć węglowodany poniżej
 * dolnej granicy i nie jest przez to niebezpieczny.
 */
export function oceniaCele(makro: Makro, przemiana: number, zapotrzebowanieDzienne: number): Ocena {
  const blokady: string[] = [];
  const ostrzezenia: string[] = [];
  const kcal = kcalZMakro(makro.bialko, makro.tluszcz, makro.wegle);
  const udzialy = udzialyProcentowe(makro);

  // --- blokady twarde ---
  if (kcal < przemiana) {
    blokady.push(
      `Cel ${kcal} kcal jest poniżej przemiany podstawowej (${przemiana} kcal). ` +
        'Tyle energii organizm zużywa w samym spoczynku.'
    );
  }

  const deficyt = zapotrzebowanieDzienne - kcal;
  if (deficyt > MAKS_DEFICYT_KCAL) {
    blokady.push(
      `Deficyt ${deficyt} kcal dziennie oznacza chudnięcie szybsze niż 1 kg tygodniowo. ` +
        `Największy dopuszczalny to ${MAKS_DEFICYT_KCAL} kcal.`
    );
  }

  if (udzialy.bialko > AMDR.bialko.max) {
    blokady.push(
      `Białko stanowi ${udzialy.bialko}% energii, powyżej górnej granicy ${AMDR.bialko.max}%.`
    );
  }

  // --- ostrzeżenia miękkie ---
  const sprawdzZakres = (nazwa: string, udzial: number, zakres: { min: number; max: number }) => {
    if (udzial < zakres.min) {
      ostrzezenia.push(
        `${nazwa}: ${udzial}% energii, poniżej zalecanego zakresu ${zakres.min}–${zakres.max}%.`
      );
    } else if (udzial > zakres.max) {
      ostrzezenia.push(
        `${nazwa}: ${udzial}% energii, powyżej zalecanego zakresu ${zakres.min}–${zakres.max}%.`
      );
    }
  };

  sprawdzZakres('Białko', udzialy.bialko, AMDR.bialko);
  sprawdzZakres('Tłuszcz', udzialy.tluszcz, AMDR.tluszcz);
  sprawdzZakres('Węglowodany', udzialy.wegle, AMDR.wegle);

  if (deficyt < -300) {
    ostrzezenia.push(
      `Cel przekracza zapotrzebowanie o ${Math.abs(deficyt)} kcal — to nadwyżka, nie redukcja.`
    );
  }

  return { blokady, ostrzezenia };
}

/** Ocena spożycia błonnika względem celu — informacja, nigdy blokada. */
export function ocenaBlonnika(zjedzone: number, cel: number | null): string | null {
  if (!cel || cel <= 0) return null;

  const brakuje = cel - zjedzone;
  if (brakuje <= 0) return null;

  return `Do celu błonnikowego brakuje ${Math.round(brakuje)} g. Strączki, kasze i warzywa uzupełnią go najszybciej.`;
}

/**
 * Podpowiadany próg białka na posiłek: około 0,4 g na kilogram masy ciała.
 *
 * To NIE jest cel dzienny podzielony przez trzy. Dzielenie zakłada, że każdy
 * posiłek wnosi tyle samo, a tak się nie je — śniadanie bywa lżejsze, obiad
 * cięższy. Chodzi o coś innego: o wartość, poniżej której posiłek przestaje
 * pobudzać syntezę białek. Po pięćdziesiątce ma to większe znaczenie niż
 * u młodszych.
 *
 * Wartość wymaga potwierdzenia w Normach żywienia dla populacji Polski (2024)
 * przed uznaniem jej za wiążącą.
 */
export function podpowiedzProguBialka(wagaKg: number): number {
  return Math.round(wagaKg * 0.4);
}
