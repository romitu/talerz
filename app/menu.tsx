/**
 * Zakładka „Więcej” (zębatka) nigdy się nie otwiera — `tabPress` w app/_layout.tsx
 * zawsze go przechwytuje i zamiast nawigacji rozwija menu nad paskiem zakładek.
 *
 * Ten plik istnieje wyłącznie po to, żeby expo-router miał do czego przypiąć
 * `Tabs.Screen name="menu"`. Gdyby ktoś trafił tu bezpośrednio z adresu
 * (np. wpisując /menu ręcznie), po prostu wraca na Plan.
 */
import { Redirect } from 'expo-router';

export default function EkranMenu() {
  return <Redirect href="/" />;
}
