/**
 * Paleta kolorów i wymiary aplikacji Talerz.
 *
 * Każdy kolor ma wersję jasną i ciemną — aplikacja sama przełącza się
 * zgodnie z ustawieniem systemowym telefonu lub przeglądarki.
 */

import { Platform } from 'react-native';

export const Colors = {
  light: {
    text: '#2B2118',
    textSecondary: '#7A6A58',
    background: '#FBF7F0',
    backgroundElement: '#FFFFFF',
    backgroundSelected: '#F2E5D5',
    accent: '#C2612F',
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

export type ThemeColor = keyof typeof Colors.light & keyof typeof Colors.dark;

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
