/**
 * Wyliczenia żywieniowe.
 *
 * Wszystko, co przelicza liczby, siedzi w tym jednym pliku — osobno od ekranów.
 * Dzięki temu da się to przetestować bez uruchamiania aplikacji, a wzory
 * stoją w jednym miejscu, zamiast być rozsiane po interfejsie.
 *
 * Źródła:
 *   * przemiana podstawowa — wzór Mifflina-St Jeora. Zostaje tu wyłącznie jako
 *     dolna granica bezpieczeństwa dla celu redukcyjnego (patrz lib/nasem.ts) —
 *     samo zapotrzebowanie dzienne liczy już NASEM (patrz niżej).
 *   * zapotrzebowanie dzienne i cel kaloryczny — równania NASEM 2023
 *     (Dietary Reference Intakes for Energy), w lib/nasem.ts. Zastąpiły
 *     dawny wzór „przemiana razy mnożnik aktywności” z tego pliku.
 *   * zakresy makroskładników — AMDR (białko 10-35%, tłuszcz 20-35%, węglowodany 45-65%)
 *
 * UWAGA: współczynniki białka na kilogram masy ciała celowo NIE są tu wpisane.
 * Wymagają odczytania z Norm żywienia dla populacji Polski (NIZP-PZH, 2024).
 * Do tego czasu cel białkowy ustawia użytkownik ręcznie, a aplikacja go pilnuje.
 */

export type Plec = 'K' | 'M';

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

export type TrybCelu = 'redukcja' | 'utrzymanie';

/** Umiarkowany deficyt na redukcję — nie mniej niż przemiana podstawowa. */
export const DEFICYT_REDUKCJI_KCAL = 400;

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

/**
 * Odwrotność `wiekZDaty()`: zamienia wiek w latach na datę urodzenia.
 *
 * Formularz profilu pyta wprost o wiek, nie o datę urodzenia — ale baza
 * i tak przechowuje datę, żeby wiek dało się liczyć NA BIEŻĄCO zamiast
 * zamrażać go w chwili zapisu (ten sam powód co przy celu kalorycznym,
 * patrz migracja 0026). Sztuczka: data „dzisiaj minus N lat” ma zawsze
 * dokładnie taki wiek dzisiaj, a za rok — poprawnie — o jeden więcej,
 * mimo że nie znamy prawdziwego dnia urodzin.
 */
export function dataUrodzeniaZWieku(wiekLat: number, dzisiaj = new Date()): string {
  const rok = dzisiaj.getFullYear() - wiekLat;
  const miesiac = String(dzisiaj.getMonth() + 1).padStart(2, '0');
  const dzien = String(dzisiaj.getDate()).padStart(2, '0');
  return `${rok}-${miesiac}-${dzien}`;
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
};

/**
 * Sprawdza cele według zasady: blokujemy niebezpieczeństwo, nie nietypowość.
 *
 * Blokady dotyczą wyłącznie wartości realnie groźnych. Wyjście poza zakresy
 * AMDR celowo NIE jest tu sprawdzane — plan wysokobiałkowy potrafi mieć
 * węglowodany poniżej dolnej granicy i nie jest przez to niebezpieczny.
 */
export function oceniaCele(makro: Makro, przemiana: number, zapotrzebowanieDzienne: number): Ocena {
  const blokady: string[] = [];
  const kcal = kcalZMakro(makro.bialko, makro.tluszcz, makro.wegle);
  const udzialy = udzialyProcentowe(makro);

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

  return { blokady };
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
