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
 * Ekran może podać inny domyślny, np. kafle na tablecie.
 */
const DOMYSLNY: WidokListy = 'miniatury';

/** Od tej szerokości okna ekran traktujemy jak tablet albo komputer. */
export const SZEROKOSC_TABLETU = 768;

function czyWidok(x: unknown): x is WidokListy {
  return WIDOKI_LISTY.some((w) => w.wartosc === x);
}

/**
 * `domyslny` obowiązuje, dopóki użytkownik sam czegoś nie wybierze. Nie jest
 * zapisywany — dzięki temu po obróceniu tabletu albo zwężeniu okna podąża
 * za szerokością, a wybór zrobiony ręcznie zostaje na stałe.
 */
export function useWidokListy(klucz: string, domyslny: WidokListy = DOMYSLNY) {
  const [wybrany, setWybrany] = useState<WidokListy | null>(null);
  const widok = wybrany ?? domyslny;

  useEffect(() => {
    let aktualny = true;
    AsyncStorage.getItem(klucz)
      .then((zapisany) => {
        if (aktualny && czyWidok(zapisany)) setWybrany(zapisany);
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
      setWybrany(nowy);
      AsyncStorage.setItem(klucz, nowy).catch(() => {
        // Nie udało się zapamiętać — widok i tak działa do końca sesji.
      });
    },
    [klucz]
  );

  return { widok, ustawWidok };
}
