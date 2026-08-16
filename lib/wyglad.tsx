/**
 * Wybrany styl aplikacji — pamiętany między uruchomieniami.
 *
 * Dlaczego w pamięci urządzenia, a nie w bazie
 * --------------------------------------------
 * Styl to cecha URZĄDZENIA, nie konta. Na telefonie w kuchni możesz chcieć
 * „Wyrazisty”, a na komputerze przy planowaniu „Porcelanę”. Trzymanie tego
 * w bazie wymuszałoby jeden wybór na oba.
 *
 * Poza tym wybór ma działać natychmiast po otwarciu aplikacji, jeszcze przed
 * zalogowaniem — a wtedy nie ma czyjego ustawienia odczytać.
 */

import AsyncStorage from '@react-native-async-storage/async-storage';
import { createContext, useCallback, useContext, useEffect, useState } from 'react';

import { STYLE, type Styl } from '@/constants/theme';

const KLUCZ = 'talerz-styl';

type Kontekst = {
  styl: Styl;
  ustawStyl: (nowy: Styl) => void;
  /** Czy odczyt z pamięci już się zakończył. */
  wczytany: boolean;
};

const KontekstWygladu = createContext<Kontekst>({
  styl: 'porcelana',
  ustawStyl: () => {},
  wczytany: false,
});

function czyStyl(x: unknown): x is Styl {
  return typeof x === 'string' && (STYLE as readonly string[]).includes(x);
}

export function DostawcaWygladu({ children }: { children: React.ReactNode }) {
  const [styl, setStyl] = useState<Styl>('porcelana');
  const [wczytany, setWczytany] = useState(false);

  useEffect(() => {
    let aktualny = true;
    AsyncStorage.getItem(KLUCZ)
      .then((zapisany) => {
        if (!aktualny) return;
        if (czyStyl(zapisany)) setStyl(zapisany);
      })
      .catch(() => {
        // Brak dostępu do pamięci nie może wywrócić aplikacji — zostaje domyślny.
      })
      .finally(() => {
        if (aktualny) setWczytany(true);
      });
    return () => {
      aktualny = false;
    };
  }, []);

  const ustawStyl = useCallback((nowy: Styl) => {
    // Najpierw ekran, potem zapis. Przełączenie ma być natychmiastowe,
    // a zapis do pamięci trwa kilkadziesiąt milisekund.
    setStyl(nowy);
    AsyncStorage.setItem(KLUCZ, nowy).catch(() => {
      // Nie udało się zapamiętać — styl i tak działa do końca sesji.
    });
  }, []);

  return (
    <KontekstWygladu.Provider value={{ styl, ustawStyl, wczytany }}>
      {children}
    </KontekstWygladu.Provider>
  );
}

export function useStyl() {
  return useContext(KontekstWygladu);
}
