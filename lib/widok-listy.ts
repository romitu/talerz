/**
 * Jak wyświetlać listę ze zdjęciami: kafle, wiersze z miniaturką albo sam
 * tekst. Wspólne dla listy zakupów i wyboru dania do planu, ale każdy ekran
 * pamięta swój wybór osobno — w pamięci urządzenia, jak styl aplikacji
 * (`lib/wyglad.tsx`). W sklepie z telefonem może pasować co innego niż przy
 * układaniu tygodnia przy komputerze.
 */

import AsyncStorage from '@react-native-async-storage/async-storage';
import { useCallback, useEffect, useState } from 'react';

export type WidokListy = 'kafle' | 'miniatury' | 'lista';

export const WIDOKI_LISTY: { wartosc: WidokListy; etykieta: string; ikona: 'grid-outline' | 'list-outline' | 'reorder-four-outline' }[] = [
  { wartosc: 'kafle', etykieta: 'Kafle', ikona: 'grid-outline' },
  { wartosc: 'miniatury', etykieta: 'Z miniaturką', ikona: 'list-outline' },
  { wartosc: 'lista', etykieta: 'Lista', ikona: 'reorder-four-outline' },
];

/** Klucze w pamięci urządzenia — po jednym na ekran. */
export const KLUCZ_WIDOKU_ZAKUPOW = 'talerz-widok-zakupow';
export const KLUCZ_WIDOKU_WYBORU_DANIA = 'talerz-widok-wyboru-dania';

/**
 * Domyślnie wiersze z miniaturką — mieszczą mniej więcej dwa razy więcej
 * pozycji na ekranie niż kafle, a obrazek nadal pomaga rozpoznać pozycję.
 */
const DOMYSLNY: WidokListy = 'miniatury';

function czyWidok(x: unknown): x is WidokListy {
  return WIDOKI_LISTY.some((w) => w.wartosc === x);
}

export function useWidokListy(klucz: string) {
  const [widok, setWidok] = useState<WidokListy>(DOMYSLNY);

  useEffect(() => {
    let aktualny = true;
    AsyncStorage.getItem(klucz)
      .then((zapisany) => {
        if (aktualny && czyWidok(zapisany)) setWidok(zapisany);
      })
      .catch(() => {
        // Brak dostępu do pamięci — zostaje widok domyślny.
      });
    return () => {
      aktualny = false;
    };
  }, [klucz]);

  const ustawWidok = useCallback(
    (nowy: WidokListy) => {
      setWidok(nowy);
      AsyncStorage.setItem(klucz, nowy).catch(() => {
        // Nie udało się zapamiętać — widok i tak działa do końca sesji.
      });
    },
    [klucz]
  );

  return { widok, ustawWidok };
}
