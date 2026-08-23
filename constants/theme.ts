/**
 * Palety kolorów i wymiary aplikacji Talerz.
 *
 * Dwa niezależne wymiary
 * ----------------------
 *   1. STYL wybiera użytkownik. Trzy do wyboru, opisane niżej.
 *   2. JASNY / CIEMNY bierze się z ustawienia systemowego i przełącza sam.
 *
 * Każdy styl ma więc obie wersje. To celowe: ktoś, kto lubi zielony,
 * chce go i rano, i wieczorem — a nie musi wybierać między swoim kolorem
 * a tym, żeby ekran nie raził go w nocy.
 */

import { Platform } from 'react-native';

/** Style do wyboru. Kolejność jak na ekranie profilu. */
export const STYLE = ['porcelana', 'ziola', 'wyrazisty'] as const;
export type Styl = (typeof STYLE)[number];

export const OPIS_STYLU: Record<Styl, { nazwa: string; opis: string }> = {
  porcelana: {
    nazwa: 'Porcelana',
    opis: 'Ciepły papier i terakota. Spokojny, domyślny.',
  },
  ziola: {
    nazwa: 'Zioła',
    opis: 'Chłodna zieleń. Mniej kontrastu, łagodniejszy wieczorem.',
  },
  wyrazisty: {
    nazwa: 'Wyrazisty',
    opis: 'Mocny kontrast i widoczne ramki. Do czytania przepisu przy garnku.',
  },
};

/**
 * PORCELANA — pierwotna paleta Talerza.
 * Ciepłe biele jak porcelanowy talerz, terakota jako akcent.
 *
 * Akcent przyciemniony z #C2612F na #B05628. Pierwotny dawał na białej karcie
 * kontrast 4,16:1, czyli poniżej progu 4,5:1 z wytycznych WCAG dla zwykłego
 * tekstu — a akcentem pisane są ostrzeżenia o białku i komunikaty błędów,
 * więc akurat te zdania muszą być czytelne. Po zmianie 4,99:1.
 */
const porcelana = {
  light: {
    text: '#2B2118',
    textSecondary: '#7A6A58',
    background: '#FBF7F0',
    backgroundElement: '#FFFFFF',
    backgroundSelected: '#F2E5D5',
    accent: '#B05628',
    border: '#EADFD0',
  },
  dark: {
    text: '#F5EFE7',
    textSecondary: '#A99787',
    background: '#16130F',
    backgroundElement: '#221D17',
    backgroundSelected: '#332A20',
    accent: '#E8843F',
    border: '#33291F',
  },
} as const;

/**
 * ZIOŁA — chłodna zieleń.
 * Ten sam zielony, który był akcentem w starym planerze posiłków.
 * Niższy kontrast niż porcelana, więc mniej męczy przy dłuższym czytaniu.
 */
const ziola = {
  light: {
    text: '#1C2620',
    textSecondary: '#5F7268',
    background: '#F4F7F4',
    backgroundElement: '#FFFFFF',
    backgroundSelected: '#E2EDE4',
    accent: '#3F6B4A',
    border: '#D8E3D9',
  },
  dark: {
    text: '#E8F0E9',
    textSecondary: '#93A899',
    background: '#0F1512',
    backgroundElement: '#19211C',
    backgroundSelected: '#243028',
    accent: '#6FA97E',
    border: '#263029',
  },
} as const;

/**
 * WYRAZISTY — wysoki kontrast.
 *
 * Nie jest ozdobą, tylko odpowiedzią na konkretną sytuację: czytanie kroków
 * przepisu w kuchni, z pary nad garnkiem, w okularach do czytania i przy
 * świetle z okapu. Czerń na bieli, mocny akcent, ramki widoczne bez wpatrywania.
 *
 * Stąd też jedyne odstępstwo od reszty: `border` jest tu ciemny, a nie ledwo
 * widoczny. Kartę ma być widać jako kartę, a nie domyślać się jej granic.
 */
const wyrazisty = {
  light: {
    text: '#000000',
    textSecondary: '#3A3A3A',
    background: '#FFFFFF',
    backgroundElement: '#FFFFFF',
    backgroundSelected: '#FFE9B8',
    accent: '#A3001B',
    border: '#1A1A1A',
  },
  dark: {
    text: '#FFFFFF',
    textSecondary: '#D4D4D4',
    background: '#000000',
    backgroundElement: '#0E0E0E',
    backgroundSelected: '#3D3000',
    accent: '#FF7B7B',
    border: '#9A9A9A',
  },
} as const;

export const PALETY: Record<Styl, { light: Paleta; dark: Paleta }> = {
  porcelana,
  ziola,
  wyrazisty,
};

/**
 * Paleta domyślna. Zostaje jako `Colors`, bo używa jej układ nawigacji,
 * zanim wybór użytkownika zostanie wczytany z pamięci.
 */
export const Colors = porcelana;

export type ThemeColor = keyof typeof porcelana.light & keyof typeof porcelana.dark;

/** Zestaw kolorów jednego motywu — jasnego albo ciemnego. */
export type Paleta = { [K in ThemeColor]: string };

export const Fonts = Platform.select({
  ios: {
    sans: 'system-ui',
    serif: 'ui-serif',
    rounded: 'ui-rounded',
    mono: 'ui-monospace',
  },
  default: {
    sans: 'normal',
    serif: 'serif',
    rounded: 'normal',
    mono: 'monospace',
  },
  web: {
    sans: "system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif",
    serif: "Georgia, 'Times New Roman', serif",
    rounded: "system-ui, -apple-system, 'Segoe UI', Roboto, sans-serif",
    mono: "ui-monospace, 'Cascadia Code', Consolas, monospace",
  },
});

/** Jednostki odstępów — używamy ich zamiast wpisywania liczb w kodzie. */
export const Spacing = {
  half: 2,
  one: 4,
  two: 8,
  three: 16,
  four: 24,
  five: 32,
  six: 64,
} as const;

/** Maksymalna szerokość treści — żeby na dużym monitorze tekst nie rozjeżdżał się na cały ekran. */
export const MaxContentWidth = 760;

/**
 * Kolory identyfikujące trzy makroskładniki — te same na ekranie Makroskładniki
 * i w wyniku formularza Profilu. To identyfikacja grupy, nie akcent aplikacji,
 * więc — inaczej niż `Paleta` — jest jedna wersja, wspólna dla wszystkich
 * stylów i obu trybów jasny/ciemny.
 */
export const KOLOR_MAKRO = {
  bialko: '#3F8F5F',
  tluszcz: '#D98A20',
  wegle: '#3E7BC4',
} as const;
