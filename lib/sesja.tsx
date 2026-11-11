/**
 * Sesja użytkownika — kto jest zalogowany.
 *
 * Udostępnia całej aplikacji informację o zalogowanej osobie i nasłuchuje
 * zmian: zalogowania, wylogowania, odświeżenia tokenu. Dzięki temu żaden
 * ekran nie musi sam pytać bazy, kto korzysta z aplikacji.
 *
 * Pilnuje też odzyskiwania hasła: po wejściu z linku resetu użytkownik ma
 * już sesję, ale zanim dostanie aplikację, musi ustawić nowe hasło.
 */

import type { Session } from '@supabase/supabase-js';
import { createContext, useContext, useEffect, useState, type ReactNode } from 'react';

import { otwartoZLinkuResetu } from './haslo';
import { supabase } from './supabase';

type StanSesji = {
  sesja: Session | null;
  ladowanie: boolean;
  /** Wejście z linku resetu — pokazać formularz nowego hasła zamiast aplikacji. */
  odzyskiwanieHasla: boolean;
  zakonczOdzyskiwanie: () => void;
};

const KontekstSesji = createContext<StanSesji>({
  sesja: null,
  ladowanie: true,
  odzyskiwanieHasla: false,
  zakonczOdzyskiwanie: () => {},
});

export function DostawcaSesji({ children }: { children: ReactNode }) {
  const [sesja, setSesja] = useState<Session | null>(null);
  const [ladowanie, setLadowanie] = useState(true);
  const [odzyskiwanieHasla, setOdzyskiwanieHasla] = useState(otwartoZLinkuResetu);

  useEffect(() => {
    // Sesja zapisana na urządzeniu — logowanie nie jest potrzebne przy każdym uruchomieniu.
    supabase.auth.getSession().then(({ data }) => {
      setSesja(data.session);
      setLadowanie(false);
    });

    const { data: nasluch } = supabase.auth.onAuthStateChange((zdarzenie, nowa) => {
      setSesja(nowa);
      if (zdarzenie === 'PASSWORD_RECOVERY') setOdzyskiwanieHasla(true);
      if (zdarzenie === 'SIGNED_OUT') setOdzyskiwanieHasla(false);
    });

    return () => nasluch.subscription.unsubscribe();
  }, []);

  return (
    <KontekstSesji.Provider
      value={{
        sesja,
        ladowanie,
        odzyskiwanieHasla,
        zakonczOdzyskiwanie: () => setOdzyskiwanieHasla(false),
      }}>
      {children}
    </KontekstSesji.Provider>
  );
}

export function useSesja() {
  return useContext(KontekstSesji);
}
