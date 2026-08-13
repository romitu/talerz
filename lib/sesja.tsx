/**
 * Sesja użytkownika — kto jest zalogowany.
 *
 * Udostępnia całej aplikacji informację o zalogowanej osobie i nasłuchuje
 * zmian: zalogowania, wylogowania, odświeżenia tokenu. Dzięki temu żaden
 * ekran nie musi sam pytać bazy, kto korzysta z aplikacji.
 */

import type { Session } from '@supabase/supabase-js';
import { createContext, useContext, useEffect, useState, type ReactNode } from 'react';

import { supabase } from './supabase';

type StanSesji = {
  sesja: Session | null;
  ladowanie: boolean;
};

const KontekstSesji = createContext<StanSesji>({ sesja: null, ladowanie: true });

export function DostawcaSesji({ children }: { children: ReactNode }) {
  const [sesja, setSesja] = useState<Session | null>(null);
  const [ladowanie, setLadowanie] = useState(true);

  useEffect(() => {
    // Sesja zapisana na urządzeniu — logowanie nie jest potrzebne przy każdym uruchomieniu.
    supabase.auth.getSession().then(({ data }) => {
      setSesja(data.session);
      setLadowanie(false);
    });

    const { data: nasluch } = supabase.auth.onAuthStateChange((_zdarzenie, nowa) => {
      setSesja(nowa);
    });

    return () => nasluch.subscription.unsubscribe();
  }, []);

  return <KontekstSesji.Provider value={{ sesja, ladowanie }}>{children}</KontekstSesji.Provider>;
}

export function useSesja() {
  return useContext(KontekstSesji);
}
