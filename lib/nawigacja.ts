/**
 * Powrót z ekranu szczegółowego.
 *
 * Dlaczego nie zwykłe `router.back()`
 * -----------------------------------
 * Cała aplikacja to jeden nawigator ZAKŁADEK. Ekrany takie jak formularz
 * przepisu czy lista składników też są zakładkami — tylko ukrytymi przez
 * `href: null`. A nawigator zakładek nie prowadzi stosu tak jak nawigator
 * stosowy: nie ma czegoś takiego jak „poprzedni ekran na wierzchu”.
 *
 * Skutek był taki, że „wstecz” po zapisaniu przepisu wyrzucało na Plan dnia
 * zamiast na listę przepisów. Ustawienie `backBehavior="history"` w układzie
 * głównym poprawia zachowanie przycisku wstecz w przeglądarce i na Androidzie,
 * ale nie chcemy od niego zależeć w miejscach, gdzie i tak DOKŁADNIE WIEMY,
 * skąd użytkownik przyszedł.
 *
 * Dlatego ekran otwierający przekazuje parametr `powrot`, a tutaj po prostu
 * tam wracamy. Żadnego zgadywania z historii.
 *
 * `replace`, a nie `push`
 * -----------------------
 * Formularz ma zniknąć z historii. Inaczej przycisk wstecz w przeglądarce
 * wracałby do formularza już zapisanego przepisu i pokazywał go tak, jakby
 * dało się go jeszcze raz zapisać.
 */

import { router, type Href } from 'expo-router';

/**
 * @param powrot   ścieżka przekazana przez ekran otwierający (parametr `powrot`)
 * @param zapasowa dokąd iść, gdy ekran otwarto bezpośrednio z adresu
 */
export function wroc(powrot: string | string[] | undefined, zapasowa: Href) {
  // Parametry z adresu potrafią przyjść jako tablica, gdy klucz powtórzy się
  // w zapytaniu. Bierzemy pierwszą wartość i tyle.
  const cel = Array.isArray(powrot) ? powrot[0] : powrot;

  // Przyjmujemy wyłącznie ścieżki wewnętrzne. Parametr adresu jest daną
  // wejściową jak każda inna — bez tego dałoby się podstawić obcy adres.
  if (typeof cel === 'string' && cel.startsWith('/') && !cel.startsWith('//')) {
    router.replace(cel as Href);
    return;
  }

  router.replace(zapasowa);
}
