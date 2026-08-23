/**
 * Zapotrzebowanie energetyczne wg równań NASEM (2023).
 *
 * Zastępuje dawny wzór Mifflina-St Jeora (przemiana podstawowa razy
 * współczynnik aktywności), który wcześniej liczył zapotrzebowanie w całej
 * aplikacji. National Academies of Sciences, Engineering, and Medicine
 * opublikowały w 2023 roku równania przewidujące CAŁKOWITY wydatek
 * energetyczny (TEE) wprost, bez tego pośredniego kroku. Pochodzą z tabeli
 * 5-5 raportu „Dietary Reference Intakes for Energy” (2023) i są osobne dla
 * każdej płci i każdego z czterech poziomów aktywności fizycznej (PAL) —
 * stąd własny, czteroelementowy typ `PalNasem` w tym pliku (odpowiada
 * czterem wartościom kolumny `profile.aktywnosc`, patrz migracja 0027).
 *
 * Źródło: National Academies of Sciences, Engineering, and Medicine,
 * Dietary Reference Intakes for Energy (2023), rozdział 5, tabela 5-5.
 * https://www.nationalacademies.org/read/26818/chapter/7
 */

import { DEFICYT_REDUKCJI_KCAL, KCAL_NA_GRAM, przemianaPodstawowa, type Makro, type Plec, type TrybCelu } from './zywienie.ts';

export type PalNasem = 'nieaktywny' | 'malo_aktywny' | 'aktywny' | 'bardzo_aktywny';

/** Etykiety i opisy czterech poziomów aktywności — do wyboru na ekranie Profil. */
export const OPIS_PAL: Record<PalNasem, { nazwa: string; opis: string }> = {
  nieaktywny: { nazwa: 'Siedzący', opis: 'Praca siedząca, brak regularnego ruchu.' },
  malo_aktywny: { nazwa: 'Lekka', opis: 'Codzienny spacer albo lekkie ćwiczenia 1–3 razy w tygodniu.' },
  aktywny: { nazwa: 'Umiarkowana', opis: 'Regularne ćwiczenia, kilka razy w tygodniu.' },
  bardzo_aktywny: { nazwa: 'Wysoka', opis: 'Praca fizyczna albo intensywne treningi niemal codziennie.' },
};

type Wspolczynniki = { stala: number; wiek: number; wzrost: number; waga: number };

const WSPOLCZYNNIKI: Record<Plec, Record<PalNasem, Wspolczynniki>> = {
  M: {
    nieaktywny: { stala: 753.07, wiek: -10.83, wzrost: 6.5, waga: 14.1 },
    malo_aktywny: { stala: 581.47, wiek: -10.83, wzrost: 8.3, waga: 14.94 },
    aktywny: { stala: 1004.82, wiek: -10.83, wzrost: 6.52, waga: 15.91 },
    bardzo_aktywny: { stala: -517.88, wiek: -10.83, wzrost: 15.61, waga: 19.11 },
  },
  K: {
    nieaktywny: { stala: 584.9, wiek: -7.01, wzrost: 5.72, waga: 11.71 },
    malo_aktywny: { stala: 575.77, wiek: -7.01, wzrost: 6.6, waga: 12.14 },
    aktywny: { stala: 710.25, wiek: -7.01, wzrost: 6.54, waga: 12.34 },
    bardzo_aktywny: { stala: 511.83, wiek: -7.01, wzrost: 9.07, waga: 12.56 },
  },
};

/**
 * Całkowity wydatek energetyczny (TEE) wg równań NASEM 2023.
 *
 * To NIE jest przemiana podstawowa pomnożona przez współczynnik — cztery
 * liczby (stała, wiek, wzrost, waga) są dopasowane osobno dla każdego PAL
 * i dają wynik bezpośrednio.
 */
export function calkowityWydatekNASEM(
  plec: Plec,
  wiekLat: number,
  wzrostCm: number,
  wagaKg: number,
  pal: PalNasem
): number {
  const w = WSPOLCZYNNIKI[plec][pal];
  return Math.round(w.stala + w.wiek * wiekLat + w.wzrost * wzrostCm + w.waga * wagaKg);
}

/**
 * Cel kaloryczny i makra wg TEE z równań NASEM.
 *
 * Tryb i logika deficytu są takie same jak w dawnym Mifflinowym wzorze:
 * redukcja odejmuje `DEFICYT_REDUKCJI_KCAL`, ale nigdy nie schodzi poniżej
 * przemiany podstawowej (liczonej wzorem Mifflina-St Jeora — NASEM nie
 * podaje osobno BMR, tylko od razu TEE, więc do tej JEDNEJ granicy
 * bezpieczeństwa nadal używamy sprawdzonego wzoru).
 *
 * Domyślny podział makro (25/30/45) to ten sam punkt startowy, jaki
 * ekran Profil proponuje w formularzu — użytkownik może go nadpisać.
 */
export function celZywieniowyNASEM(
  plec: Plec,
  wiekLat: number,
  wzrostCm: number,
  wagaKg: number,
  pal: PalNasem,
  tryb: TrybCelu,
  udzialy: { bialko: number; tluszcz: number; wegle: number } = { bialko: 25, tluszcz: 30, wegle: 45 }
): Makro {
  const tee = calkowityWydatekNASEM(plec, wiekLat, wzrostCm, wagaKg, pal);
  const przemiana = przemianaPodstawowa(plec, wagaKg, wzrostCm, wiekLat);
  const kcal = tryb === 'redukcja' ? Math.max(przemiana, tee - DEFICYT_REDUKCJI_KCAL) : tee;

  return {
    kcal,
    bialko: Math.round((kcal * udzialy.bialko) / 100 / KCAL_NA_GRAM.bialko),
    tluszcz: Math.round((kcal * udzialy.tluszcz) / 100 / KCAL_NA_GRAM.tluszcz),
    wegle: Math.round((kcal * udzialy.wegle) / 100 / KCAL_NA_GRAM.wegle),
  };
}
