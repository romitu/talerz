/**
 * Hasło: zmiana z poziomu aplikacji i odzyskiwanie przez link z maila.
 *
 * ZMIANA (zalogowany użytkownik, ekran Profil)
 * --------------------------------------------
 * Najpierw sprawdzamy obecne hasło, logując się nim jeszcze raz. Supabase
 * sam tego nie wymaga — `updateUser` przyjmie nowe hasło od każdego, kto ma
 * ważną sesję. A sesja trzyma się tygodniami, więc bez tego sprawdzenia
 * wystarczyłby cudzy, odblokowany telefon, żeby zabrać komuś konto.
 * Świeże zalogowanie spełnia też warunek „Secure password change” z panelu,
 * gdyby ktoś go kiedyś włączył.
 *
 * ODZYSKIWANIE (ekran logowania, „Nie pamiętam hasła”)
 * ----------------------------------------------------
 * Supabase wysyła maila z linkiem. Link otwiera wersję przeglądarkową
 * Talerza, która po adresie rozpoznaje, że to odzyskiwanie, i pokazuje
 * formularz nowego hasła zamiast aplikacji. Na telefonie link też prowadzi
 * do przeglądarki — nowe hasło działa potem wszędzie.
 *
 * W panelu Supabase (Authentication → URL Configuration) adres strony musi
 * być w „Site URL” albo w „Redirect URLs”, inaczej link wróci na Site URL.
 */

import { Platform } from 'react-native';

import i18n from './jezyk';
import { supabase } from './supabase';

/**
 * Czy stronę otwarto z linku resetu hasła — i czy link był jeszcze ważny.
 *
 * Czytamy adres OD RAZU przy wczytaniu modułu, bo klient Supabase zaraz go
 * przetworzy i wyczyści. Zdarzenie `PASSWORD_RECOVERY` z `onAuthStateChange`
 * też to mówi, ale potrafi przyjść, zanim ktokolwiek zacznie nasłuchiwać —
 * a wtedy przepada i użytkownik ląduje w aplikacji bez formularza.
 */
function odczytajAdres(): { reset: boolean; wygasl: boolean } {
  if (Platform.OS !== 'web' || typeof window === 'undefined') {
    return { reset: false, wygasl: false };
  }
  const parametry = new URLSearchParams(window.location.hash.replace(/^#/, ''));
  return {
    reset: parametry.get('type') === 'recovery',
    wygasl: parametry.get('error_code') === 'otp_expired',
  };
}

const adres = odczytajAdres();

/** Strona otwarta z linku resetu hasła — trzeba pokazać formularz nowego hasła. */
export const otwartoZLinkuResetu = adres.reset;

/** Link z maila był przeterminowany albo już użyty. */
export const linkResetuWygasl = adres.wygasl;

/** Tłumaczy komunikaty Supabase o logowaniu i hasłach na zrozumiały polski. */
export function komunikatLogowania(tresc: string): string {
  const m = tresc.toLowerCase();
  if (m.includes('invalid login credentials')) return i18n.t('logowanie.bladDanych');
  if (m.includes('email not confirmed')) return i18n.t('logowanie.bladNiepotwierdzony');
  if (m.includes('user already registered')) return i18n.t('logowanie.bladIstnieje');
  if (m.includes('should be different')) return i18n.t('haslo.bladTakieSamo');
  if (m.includes('password should be')) return i18n.t('logowanie.bladHaslo');
  if (m.includes('unable to validate email')) return i18n.t('logowanie.bladEmail');
  // Limit maili całego projektu (wbudowana poczta Supabase: kilka na godzinę),
  // nie tej jednej osoby — „odczekaj chwilę” byłoby tu nieprawdą.
  if (m.includes('email rate limit')) return i18n.t('haslo.bladLimitMaili');
  if (m.includes('rate limit') || m.includes('only request this after')) {
    return i18n.t('haslo.bladZaCzesto');
  }
  if (m.includes('network') || m.includes('fetch')) return i18n.t('logowanie.bladPolaczenia');
  return tresc;
}

/** Najkrótsze hasło, jakie przyjmuje Supabase przy domyślnych ustawieniach. */
export const MIN_DLUGOSC_HASLA = 6;

/**
 * Sprawdza formularz nowego hasła, zanim cokolwiek pójdzie do bazy.
 * Zwraca treść błędu albo `null`, gdy wszystko w porządku.
 */
export function sprawdzNoweHaslo(nowe: string, powtorzone: string): string | null {
  if (nowe.length < MIN_DLUGOSC_HASLA) return i18n.t('logowanie.bladHaslo');
  if (nowe !== powtorzone) return i18n.t('haslo.bladRozne');
  return null;
}

/** Zmiana hasła przez zalogowanego użytkownika — po sprawdzeniu obecnego. */
export async function zmienHaslo(email: string, obecne: string, nowe: string): Promise<void> {
  const { error: bladLogowania } = await supabase.auth.signInWithPassword({
    email,
    password: obecne,
  });
  if (bladLogowania) {
    // Złe obecne hasło to nie „zły e-mail lub hasło” — e-mail podaliśmy sami.
    if (bladLogowania.message.toLowerCase().includes('invalid login credentials')) {
      throw new Error(i18n.t('haslo.bladObecne'));
    }
    throw bladLogowania;
  }

  if (obecne === nowe) throw new Error(i18n.t('haslo.bladTakieSamo'));

  const { error } = await supabase.auth.updateUser({ password: nowe });
  if (error) throw error;
}

/** Ustawienie nowego hasła po wejściu z linku resetu — sesja już jest. */
export async function ustawNoweHaslo(nowe: string): Promise<void> {
  const { error } = await supabase.auth.updateUser({ password: nowe });
  if (error) throw error;
}

/** Opublikowana wersja przeglądarkowa — tu otwiera się link z maila. */
const ADRES_STRONY = 'https://romitu.github.io/talerz/';

/**
 * Adres, na który ma wrócić link z maila.
 *
 * Zawsze opublikowana strona — także z telefonu, który sam linku nie
 * obsłuży. Wyjątek: wersja lokalna przy programowaniu wraca do siebie.
 *
 * Adres był kiedyś wyliczany ze ścieżki bieżącej strony i porównywany
 * z `/Talerz`, a GitHub Pages podaje `/talerz` małą literą. Wychodził
 * z tego goły `https://romitu.github.io/`, którego Supabase nie ma na
 * liście dozwolonych, więc po cichu odsyłał na domyślny „Site URL”,
 * czyli `localhost` — i link z maila kończył się „witryna nieosiągalna”.
 */
function adresPowrotu(): string {
  if (Platform.OS === 'web' && typeof window !== 'undefined') {
    const { hostname, origin } = window.location;
    if (hostname === 'localhost' || hostname === '127.0.0.1') return origin + '/';
  }
  return ADRES_STRONY;
}

/** Wysyła maila z linkiem do ustawienia nowego hasła. */
export async function wyslijLinkResetu(email: string): Promise<void> {
  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: adresPowrotu(),
  });
  if (error) throw error;
}
