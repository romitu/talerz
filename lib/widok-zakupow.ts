/**
 * Jak wyświetlać listę zakupów: kafle ze zdjęciami, wiersze z miniaturką
 * albo sam tekst. Pamiętane w pamięci urządzenia, jak styl aplikacji
 * (`lib/wyglad.tsx`) — w sklepie z telefonem może pasować co innego niż
 * przy komputerze.
 */

import AsyncStorage from '@react-native-async-storage/async-storage';
import { useCallback, useEffect, useState } from 'react';

export type WidokZakupow = 'kafle' | 'miniatury' | 'lista';

export const WIDOKI_ZAKUPOW: { wartosc: WidokZakupow; etykieta: string; ikona: 'grid-outline' | 'list-outline' | 'reorder-four-outline' }[] = [
  { wartosc: 'kafle', etykieta: 'Kafle', ikona: 'grid-outline' },
  { wartosc: 'miniatury', etykieta: 'Z miniaturką', ikona: 'list-outline' },
  { wartosc: 'lista', etykieta: 'Lista', ikona: 'reorder-four-outline' },
];

const KLUCZ = 'talerz-widok-zakupow';

/**
 * Domyślnie wiersze z miniaturką — mieszczą mniej więcej dwa razy więcej
 * pozycji na ekranie niż kafle, a obrazek nadal pomaga przy nietypowych
 * produktach.
 */
const DOMYSLNY: WidokZakupow = 'miniatury';

function czyWidok(x: unknown): x is WidokZakupow {
  return WIDOKI_ZAKUPOW.some((w) => w.wartosc === x);
}

export function useWidokZakupow() {
  const [widok, setWidok] = useState<WidokZakupow>(DOMYSLNY);

  useEffect(() => {
    let aktualny = true;
    AsyncStorage.getItem(KLUCZ)
      .then((zapisany) => {
        if (aktualny && czyWidok(zapisany)) setWidok(zapisany);
      })
      .catch(() => {
        // Brak dostępu do pamięci — zostaje widok domyślny.
      });
    return () => {
      aktualny = false;
    };
  }, []);

  const ustawWidok = useCallback((nowy: WidokZakupow) => {
    setWidok(nowy);
    AsyncStorage.setItem(KLUCZ, nowy).catch(() => {
      // Nie udało się zapamiętać — widok i tak działa do końca sesji.
    });
  }, []);

  return { widok, ustawWidok };
}
