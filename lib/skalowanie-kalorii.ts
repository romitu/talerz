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
 *
 * Granice porcji (ustalone 2026-09-28)
 * ------------------------------------
 * Skalowanie ma dopasować danie do celu, ale nie może zrobić z porcji absurdu.
 * Dlatego liczymy zawsze na JEDNEJ PORCJI BAZOWEJ (masa przepisu podzielona
 * przez liczbę porcji — wołający dzieli ilości, zanim tu trafią), a k to
 * mnożnik tej porcji:
 *
 *  - k ≥ 1 — porcja nigdy nie maleje poniżej bazowej. Skalowanie tylko DOKŁADA,
 *    gdy brakuje kalorii; nadmiaru nie koryguje.
 *  - porcja rośnie najwyżej o połowę (`WZROST_MAX`) i nie ponad limit gramów
 *    posiłku (`LIMIT_PORCJI_G`) — liczy się to, co ostrzejsze.
 *  - danie, które już bazowo przekracza limit (barszcz ~1065 g na obiad),
 *    nie rośnie wcale — ale też nie jest przycinane do limitu.
 *
 * Granica masy dotyczy prawdziwych gramów po przeliczeniu ról (przyprawy
 * i tłuszcz rosną wolniej), a nie samego k. Zaokrąglenie składników w sztukach
 * może ją przekroczyć o część jednej sztuki.
 */

import type { PoraPosilku } from './przepisy';
import type { RolaSkladnika } from './skladniki';

/** Porcja może urosnąć najwyżej o tyle względem bazowej (wagowo). */
export const WZROST_MAX = 1.5;

/**
 * Największa porcja jednego dania na danym posiłku, w gramach (ml liczymy
 * jak gramy). Dotyczy KAŻDEGO dania osobno — obiad z dodatkiem może mieć
 * razem więcej. Przepis z kategorią „dodatek” ma limit dodatku, niezależnie
 * od posiłku, przy którym stoi.
 */
export const LIMIT_PORCJI_G: Record<PoraPosilku, number> = {
  sniadanie: 600,
  obiad: 900,
  kolacja: 600,
  dodatek: 600,
};

/** Limit gramów dla dania na danym posiłku — patrz `LIMIT_PORCJI_G`. */
export function limitPorcjiG(pora: PoraPosilku, poryPrzepisu: PoraPosilku[]): number {
  return LIMIT_PORCJI_G[poryPrzepisu.includes('dodatek') ? 'dodatek' : pora];
}

/**
 * Najcięższa dopuszczalna porcja: bazowa razy `WZROST_MAX`, ale nie ponad
 * limit posiłku — i nigdy mniej niż sama porcja bazowa.
 */
export function gornaMasaPorcji(masaPorcji: number, limitG: number): number {
  return Math.max(masaPorcji, Math.min(masaPorcji * WZROST_MAX, limitG));
}

/**
 * Techniczny sufit poszukiwania k. Prawdziwą granicę wyznacza masa porcji —
 * ten sufit tylko zamyka połowienie przedziału, gdy przepis ma prawie samą
 * wodę i przyprawy (ich ilość nie rośnie z k).
 */
const K_SUFIT = 10;

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
  /** Ilość w JEDNEJ porcji bazowej, w jednostce widocznej użytkownikowi (g/ml/szt). */
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
  /** Wybrany mnożnik porcji bazowej — od 1 do granicy masy. */
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

/** Masa porcji w gramach przy DOKŁADNYM (niezaokrąglonym) współczynniku k. */
export function masaPrzySkali(skladniki: SkladnikPrzepisu[], k: number): number {
  return skladniki.reduce((suma, s) => suma + mnoznikRoli(s.rola, k) * s.ilosc * s.gramyNaJednostke, 0);
}

/**
 * Największe k, przy którym porcja nie przekracza `masaMax` gramów.
 * Masa od k jest niemalejąca, więc wystarcza połowienie przedziału. Porcja
 * już bazowo cięższa od granicy daje k = 1 — nie rośnie, ale nie jest ścinana.
 */
export function kDlaMasy(skladniki: SkladnikPrzepisu[], masaMax: number): number {
  if (masaPrzySkali(skladniki, 1) >= masaMax) return 1;
  if (masaPrzySkali(skladniki, K_SUFIT) <= masaMax) return K_SUFIT;

  let dolna = 1;
  let gorna = K_SUFIT;
  for (let i = 0; i < 50; i++) {
    const srodek = (dolna + gorna) / 2;
    if (masaPrzySkali(skladniki, srodek) <= masaMax) dolna = srodek;
    else gorna = srodek;
  }
  return dolna;
}

/**
 * Szuka k w [1, kMax], przy którym `kcalPrzySkali` trafia w `celKcal`.
 *
 * Funkcja kalorii od k jest ciągła i niemalejąca (każdy mnożnik roli rośnie
 * wraz z k), więc połowienie przedziału zawsze zbiega — 50 iteracji to
 * precyzja dużo poniżej jednej kalorii, kosztem kilkudziesięciu mnożeń.
 * Gdy cel leży poza zasięgiem, zwracamy granicę i flagę `ograniczone` —
 * reszta różnicy zostaje w bilansie dnia jako brak (albo nadmiar, gdy cel
 * jest poniżej porcji bazowej: porcji nie zmniejszamy).
 */
export function dobierzWspolczynnik(
  skladniki: SkladnikPrzepisu[],
  celKcal: number,
  kMax: number
): { k: number; ograniczone: boolean } {
  const kcalMin = kcalPrzySkali(skladniki, 1);
  const kcalMax = kcalPrzySkali(skladniki, kMax);

  if (celKcal <= kcalMin) return { k: 1, ograniczone: celKcal < kcalMin };
  if (celKcal >= kcalMax) return { k: kMax, ograniczone: celKcal > kcalMax };

  let dolna = 1;
  let gorna = kMax;
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
 * Zaokrąglamy tylko składniki, które w porcji bazowej są CAŁE. Porcja z garnka
 * na kilka osób ma np. 1,5 jajka — to nie jest jajko do rozbicia, tylko udział
 * w garnku, który gotuje się w całości. Zaokrąglenie takiej porcji do 2
 * zamieniłoby 3 jajka w garnku w 4.
 *
 * `masaMax` — najcięższa dopuszczalna porcja w gramach, patrz `gornaMasaPorcji`.
 */
export function przeskalujPrzepis(
  skladniki: SkladnikPrzepisu[],
  celKcal: number,
  masaMax: number
): WynikSkalowania {
  const { k, ograniczone } = dobierzWspolczynnik(skladniki, celKcal, kDlaMasy(skladniki, masaMax));

  const pozycje: PozycjaPoSkalowaniu[] = skladniki.map((s) => {
    let iloscPoSkalowaniu = s.ilosc * mnoznikRoli(s.rola, k);

    if (s.moznaDzielic === false && Math.abs(s.ilosc - Math.round(s.ilosc)) < 1e-9) {
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
