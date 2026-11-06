/**
 * Dietetyk i jego klienci — wywołania funkcji bazy z migracji 0050.
 *
 * Dlaczego wszystko przez `rpc`, a nie zwykłe zapytania
 * -----------------------------------------------------
 * Reguły dostępu do planów, profili i pomiarów pokazują wyłącznie WŁASNE
 * wiersze, a ekrany aplikacji na tym polegają (nie filtrują po koncie).
 * Dane klientów dietetyk dostaje więc tylko przez funkcje, które same
 * sprawdzają zgodę — nigdy przez poszerzenie reguł.
 */

import i18n from './jezyk';
import { supabase } from './supabase';
import type { PalNasem } from './nasem';
import type { PoraPosilku } from './przepisy';
import type { Plec, TrybCelu } from './zywienie';

export type KodDietetyka = { kod: string; nazwa: string | null };

export type KlientNaLiscie = {
  profil_id: string;
  imie: string;
  plec: Plec;
  data_urodzenia: string;
  wzrost_cm: number;
  aktywnosc: PalNasem;
  waga: number | null;
  data_wagi: string | null;
  od: string;
};

export type CelKlienta = {
  obowiazuje_od: string;
  tryb: TrybCelu;
  bialko_procent: number;
  tluszcz_procent: number;
  wegle_procent: number;
  blonnik_g: number | null;
  prog_bialka_posilek: number | null;
  kcal_ustalone: number | null;
  od_dietetyka: boolean;
};

export type PozycjaPlanuKlienta = {
  data: string;
  pora: PoraPosilku;
  nazwa: string;
  zjedzone: boolean;
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number;
};

export type DaneKlienta = {
  profil: {
    id: string;
    imie: string;
    plec: Plec;
    data_urodzenia: string;
    wzrost_cm: number;
    aktywnosc: PalNasem;
    liczba_osob: number;
  };
  pomiary: { typ: 'waga' | 'talia'; wartosc: number; data: string }[];
  /** Od najnowszego. */
  cele: CelKlienta[];
  wykluczone: string[];
  plan: { data_start: string; dni: number; pozycje: PozycjaPlanuKlienta[] } | null;
};

export type MojDietetyk = {
  profil_id: string;
  dietetyk_id: string;
  nazwa: string | null;
  email: string | null;
  od: string;
};

/** Komunikaty z funkcji bazy po polsku już są — tłumaczymy tylko brak migracji. */
function blad(e: { message: string; code?: string }): Error {
  if (e.code === 'PGRST202' || e.message.includes('Could not find the function')) {
    return new Error(i18n.t('dietetyk.brakMigracji'));
  }
  return new Error(e.message);
}

// ---------------------------------------------------------------------------
//  Strona dietetyka
// ---------------------------------------------------------------------------

export async function pobierzMojKod(): Promise<KodDietetyka> {
  const { data, error } = await supabase.rpc('dietetyk_moj_kod');
  if (error) throw blad(error);
  const wiersz = (data as KodDietetyka[] | null)?.[0];
  if (!wiersz) throw new Error(i18n.t('dietetyk.brakKodu'));
  return wiersz;
}

export async function zmienKod(): Promise<string> {
  const { data, error } = await supabase.rpc('dietetyk_zmien_kod');
  if (error) throw blad(error);
  return data as string;
}

/** Nazwa, którą klient widzi zamiast adresu e-mail. Pusta = adres e-mail. */
export async function ustawNazweDietetyka(kontoId: string, nazwa: string) {
  const czysta = nazwa.trim();
  const { error } = await supabase
    .from('dietetycy')
    .update({ nazwa: czysta.length > 0 ? czysta : null })
    .eq('konto_id', kontoId);
  if (error) throw blad(error);
}

export async function pobierzKlientow(): Promise<KlientNaLiscie[]> {
  const { data, error } = await supabase.rpc('dietetyk_klienci');
  if (error) throw blad(error);
  return ((data ?? []) as KlientNaLiscie[]).map((k) => ({
    ...k,
    waga: k.waga === null ? null : Number(k.waga),
  }));
}

export async function pobierzKlienta(profilId: string): Promise<DaneKlienta> {
  const { data, error } = await supabase.rpc('dietetyk_klient', { p_profil: profilId });
  if (error) throw blad(error);
  const d = data as DaneKlienta;
  return {
    ...d,
    pomiary: d.pomiary.map((p) => ({ ...p, wartosc: Number(p.wartosc) })),
    plan: d.plan
      ? {
          ...d.plan,
          pozycje: d.plan.pozycje.map((p) => ({
            ...p,
            kcal: Number(p.kcal),
            bialko_g: Number(p.bialko_g),
            tluszcz_g: Number(p.tluszcz_g),
            wegle_g: Number(p.wegle_g),
            blonnik_g: Number(p.blonnik_g),
          })),
        }
      : null,
  };
}

export async function ustawCelKlienta(
  profilId: string,
  cel: {
    tryb: TrybCelu;
    bialko_procent: number;
    tluszcz_procent: number;
    wegle_procent: number;
    kcal_ustalone: number | null;
  }
) {
  const { error } = await supabase.rpc('dietetyk_ustaw_cel', {
    p_profil: profilId,
    p_tryb: cel.tryb,
    p_bialko_procent: cel.bialko_procent,
    p_tluszcz_procent: cel.tluszcz_procent,
    p_wegle_procent: cel.wegle_procent,
    p_kcal_ustalone: cel.kcal_ustalone,
  });
  if (error) throw blad(error);
}

// ---------------------------------------------------------------------------
//  Wspólne — zakończenie współpracy przez dowolną stronę
// ---------------------------------------------------------------------------

/**
 * Usuwa powiązanie profilu z dietetykiem. Reguła w bazie wpuszcza tu obie
 * strony: właściciela profilu i dietetyka.
 */
export async function zakonczWspolprace(profilId: string) {
  const { error } = await supabase.from('dietetyk_podopieczni').delete().eq('profil_id', profilId);
  if (error) throw blad(error);
}

// ---------------------------------------------------------------------------
//  Strona klienta
// ---------------------------------------------------------------------------

export async function polaczZDietetykiem(kod: string, profilId: string): Promise<string> {
  const { data, error } = await supabase.rpc('polacz_z_dietetykiem', { p_kod: kod, p_profil: profilId });
  if (error) throw blad(error);
  return data as string;
}

export async function pobierzMoichDietetykow(): Promise<MojDietetyk[]> {
  const { data, error } = await supabase.rpc('moi_dietetycy');
  if (error) throw blad(error);
  return (data ?? []) as MojDietetyk[];
}

/** Co pokazać jako „kto”: nazwa, a gdy jej nie ma — adres e-mail. */
export function podpisDietetyka(d: { nazwa: string | null; email: string | null }): string {
  return d.nazwa ?? d.email ?? i18n.t('dietetyk.bezNazwy');
}
