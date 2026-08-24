/**
 * Skalowanie przepisu do zadanej liczby kalorii.
 *
 * Odwraca kierunek zwykłego skalowania porcji: zamiast wyliczać kalorie
 * z liczby porcji (k = porcje_docelowe / porcje_bazowe), tutaj szukamy
 * takiego k, przy którym suma kalorii przepisu trafia w podany cel —
 * "grając" ilościami składników zgodnie z ich rolą (patrz ekran
 * „Role składników” i `lib/role-skladnikow.ts` — tam żyje TREŚĆ wzorów,
 * tutaj ich WYKONANIE).
 *
 * Założenia ustalone wspólnie z Romanem:
 *  - proporcje makro (białko/tłuszcz/węgle) NIE są osobno pilnowane —
 *    wynikają same z tego, że główne makro niesie rola „baza” (skaluje się
 *    liniowo razem z k), a role z tłumieniem (doprawienie, aromat, smażenie,
 *    duszenie) z założenia mają mały udział kaloryczny. Przy k bliskim 1
 *    dryf proporcji jest znikomy.
 *  - po zaokrągleniu składników z `mozna_dzielic = false` do liczby całkowitej
 *    dopuszczamy odchylenie od celu — nie ma dociągania innym składnikiem.
 *  - k ma stałe, globalne granice (nie per przepis) — patrz `K_MIN`/`K_MAX`.
 */

import type { RolaSkladnika } from './skladniki';

/** Dolna granica mnożnika — przepis nie kurczy się poniżej jednej czwartej. */
export const K_MIN = 0.25;
/** Górna granica mnożnika — przepis nie rośnie ponad czterokrotność. */
export const K_MAX = 4;

/**
 * Wykładnik tłumienia przy k > 1, per rola — liczby wprost z tabeli
 * „Role składników” (migracja 0031). `null` = „bez automatycznego
 * skalowania”: ilość zostaje taka, jak w przepisie bazowym, niezależnie od k.
 */
const WYKLADNIK: Record<RolaSkladnika, number | null> = {
  baza: 1,
  doprawienie: 0.85,
  aromat: 0.75,
  smazenie: 0.67,
  duszenie: 0.85,
  woda: null,
  do_smaku: null,
};

/**
 * Mnożnik ilości składnika o danej roli przy współczynniku k.
 *
 * Dla k ≤ 1 wszystkie role (poza „bez skalowania”) rosną/maleją liniowo —
 * tłumienie dotyczy wyłącznie ROŚNIĘCIA (k > 1), zgodnie z opisem każdej roli.
 */
export function mnoznikRoli(rola: RolaSkladnika, k: number): number {
  const wykladnik = WYKLADNIK[rola];
  if (wykladnik === null) return 1;
  if (k <= 1) return k;
  return k ** wykladnik;
}

export type SkladnikPrzepisu = {
  /** Identyfikator składnika — tylko do rozpoznania pozycji w wyniku. */
  id: string;
  rola: RolaSkladnika;
  /** `null` traktujemy jak „nie ustalono” — nie wymuszamy zaokrąglenia. */
  moznaDzielic: boolean | null;
  /** Ilość w przepisie bazowym, w jednostce widocznej użytkownikowi (g/ml/szt). */
  ilosc: number;
  /** Ile gramów odpowiada jednej jednostce `ilosc` — 1 dla g/ml, masa sztuki dla szt. */
  gramyNaJednostke: number;
  kcal_100g: number;
  bialko_100g: number;
  tluszcz_100g: number;
  wegle_100g: number;
};

export type PozycjaPoSkalowaniu = SkladnikPrzepisu & {
  iloscPoSkalowaniu: number;
  gramyPoSkalowaniu: number;
  kcal: number;
  bialko: number;
  tluszcz: number;
  wegle: number;
};

export type WynikSkalowania = {
  /** Wybrany współczynnik — po ograniczeniu do [K_MIN, K_MAX]. */
  k: number;
  /** Czy k trafił w granicę zamiast w dokładny cel — cel był poza zasięgiem. */
  kOgraniczone: boolean;
  pozycje: PozycjaPoSkalowaniu[];
  celKcal: number;
  kcalRazem: number;
  bialkoRazem: number;
  tluszczRazem: number;
  wegleRazem: number;
  /** Różnica po zaokrągleniach (kcalRazem - celKcal) — dodatnia = ponad cel. */
  odchylenieKcal: number;
};

/** Suma kalorii przepisu przy DOKŁADNYM (niezaokrąglonym) współczynniku k. */
function kcalPrzySkali(skladniki: SkladnikPrzepisu[], k: number): number {
  return skladniki.reduce(
    (suma, s) => suma + (mnoznikRoli(s.rola, k) * s.ilosc * s.gramyNaJednostke * s.kcal_100g) / 100,
    0
  );
}

/**
 * Szuka k w [K_MIN, K_MAX], przy którym `kcalPrzySkali` trafia w `celKcal`.
 *
 * Funkcja kalorii od k jest ciągła i niemalejąca (każdy mnożnik roli rośnie
 * wraz z k), więc połowienie przedziału zawsze zbiega — 50 iteracji to
 * precyzja dużo poniżej jednej kalorii, kosztem kilkudziesięciu mnożeń.
 * Gdy cel leży poza zasięgiem nawet przy granicznym k, zwracamy tę granicę
 * i flagę `ograniczone` — reszta różnicy zostaje jako odchylenie (patrz
 * `przeskalujPrzepis`), zgodnie z ustaleniem: nie łamiemy granic k.
 */
export function dobierzWspolczynnik(
  skladniki: SkladnikPrzepisu[],
  celKcal: number
): { k: number; ograniczone: boolean } {
  const kcalMin = kcalPrzySkali(skladniki, K_MIN);
  const kcalMax = kcalPrzySkali(skladniki, K_MAX);

  if (celKcal <= kcalMin) return { k: K_MIN, ograniczone: true };
  if (celKcal >= kcalMax) return { k: K_MAX, ograniczone: true };

  let dolna = K_MIN;
  let gorna = K_MAX;
  for (let i = 0; i < 50; i++) {
    const srodek = (dolna + gorna) / 2;
    if (kcalPrzySkali(skladniki, srodek) < celKcal) dolna = srodek;
    else gorna = srodek;
  }
  return { k: (dolna + gorna) / 2, ograniczone: false };
}

/**
 * Przelicza cały przepis pod zadany cel kaloryczny: dobiera k, a potem
 * liczy finalne ilości — z zaokrągleniem do całości tam, gdzie składnik
 * tego wymaga (`moznaDzielic === false`).
 *
 * Zaokrąglenie do zera całkiem kasowałoby ze przepisu składnik, który w nim
 * pierwotnie był (np. przy dużym skurczeniu przepisu) — zostawiamy wtedy
 * minimum jedną jednostkę, żeby przepis się nie „rozpadł”.
 */
export function przeskalujPrzepis(skladniki: SkladnikPrzepisu[], celKcal: number): WynikSkalowania {
  const { k, ograniczone } = dobierzWspolczynnik(skladniki, celKcal);

  const pozycje: PozycjaPoSkalowaniu[] = skladniki.map((s) => {
    let iloscPoSkalowaniu = s.ilosc * mnoznikRoli(s.rola, k);

    if (s.moznaDzielic === false) {
      iloscPoSkalowaniu = Math.round(iloscPoSkalowaniu);
      if (iloscPoSkalowaniu <= 0 && s.ilosc > 0) iloscPoSkalowaniu = 1;
    }

    const gramyPoSkalowaniu = iloscPoSkalowaniu * s.gramyNaJednostke;
    const g = gramyPoSkalowaniu / 100;

    return {
      ...s,
      iloscPoSkalowaniu,
      gramyPoSkalowaniu,
      kcal: g * s.kcal_100g,
      bialko: g * s.bialko_100g,
      tluszcz: g * s.tluszcz_100g,
      wegle: g * s.wegle_100g,
    };
  });

  const suma = (f: (p: PozycjaPoSkalowaniu) => number) => pozycje.reduce((s, p) => s + f(p), 0);
  const kcalRazem = suma((p) => p.kcal);

  return {
    k,
    kOgraniczone: ograniczone,
    pozycje,
    celKcal,
    kcalRazem,
    bialkoRazem: suma((p) => p.bialko),
    tluszczRazem: suma((p) => p.tluszcz),
    wegleRazem: suma((p) => p.wegle),
    odchylenieKcal: kcalRazem - celKcal,
  };
}
