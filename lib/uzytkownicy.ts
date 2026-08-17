/**
 * Konta użytkowników — odczyt i włączanie/wyłączanie.
 *
 * Czego tu nie ma
 * ---------------
 * Kasowania. Usunięcie użytkownika w Supabase wymaga klucza `service_role`,
 * a ten omija wszystkie reguły dostępu i nie może znaleźć się w aplikacji
 * działającej w przeglądarce — klucz w opublikowanej stronie jest jawny.
 *
 * Wyłączenie daje w praktyce to samo: człowiek traci dostęp do wszystkiego,
 * a dane zostają, więc przywrócenie jest jednym dotknięciem. Właściwą blokadę
 * trzyma baza (migracja 0023), nie ten plik — tutaj jest tylko wygodne
 * wywołanie.
 */

import { supabase } from './supabase';

export type KontoUzytkownika = {
  id: string;
  email: string | null;
  rola: 'uzytkownik' | 'moderator' | 'administrator';
  aktywne: boolean;
  wylaczone_kiedy: string | null;
  utworzono: string;
};

export const OPIS_ROLI: Record<KontoUzytkownika['rola'], string> = {
  uzytkownik: 'użytkownik',
  moderator: 'moderator przepisów',
  administrator: 'administrator',
};

export function opisRoli(rola: KontoUzytkownika['rola']): string {
  return OPIS_ROLI[rola] ?? String(rola);
}

/**
 * Wszystkie konta — dla administratora.
 *
 * Zwykły użytkownik dostanie tu wyłącznie własny wiersz i to nie jest usterka,
 * tylko reguła dostępu robiąca swoje. Ekran zarządzania i tak pokazuje się
 * jedynie administratorowi, ale gdyby ktoś dobrał się do niego inną drogą,
 * baza nie pokaże mu cudzych kont.
 */
export async function pobierzKonta(): Promise<KontoUzytkownika[]> {
  const { data, error } = await supabase
    .from('konta')
    .select('id, email, rola, aktywne, wylaczone_kiedy, utworzono')
    .order('utworzono');

  if (error) throw error;
  return data ?? [];
}

/**
 * Włącza albo wyłącza konto.
 *
 * Komunikaty z bazy tłumaczymy na polski, bo dwa z nich użytkownik zobaczy
 * naprawdę: próbę wyłączenia samego siebie i próbę zmiany bez uprawnień.
 */
export async function ustawAktywnosc(kontoId: string, aktywne: boolean) {
  const { error } = await supabase.from('konta').update({ aktywne }).eq('id', kontoId);

  if (error) {
    if (error.message.includes('własnego konta')) {
      throw new Error(
        'Nie da się wyłączyć własnego konta — przy jednym administratorze nie miałby kto go włączyć z powrotem.'
      );
    }
    if (error.code === '42501') {
      throw new Error('Włączanie i wyłączanie kont wymaga uprawnień administratora.');
    }
    throw error;
  }
}

/**
 * Czy MOJE konto jest czynne.
 *
 * Pytamy o własny wiersz, bo tylko on jest widoczny dla wyłączonego konta —
 * reguła odczytu `konta` celowo nie sprawdza aktywności. Gdyby sprawdzała,
 * aplikacja nie miałaby skąd wiedzieć, że ma pokazać komunikat o wyłączeniu,
 * i użytkownik chodziłby po pustych ekranach.
 *
 * `null` oznacza „nie wiem” — na przykład przy zerwanym połączeniu. Wtedy
 * NIE wylogowujemy: brak sieci nie może wyglądać jak odebrany dostęp.
 */
export async function czyMojeKontoCzynne(kontoId: string): Promise<boolean | null> {
  const { data, error } = await supabase
    .from('konta')
    .select('aktywne')
    .eq('id', kontoId)
    .maybeSingle();

  if (error) return null;
  if (!data) return null;
  return data.aktywne;
}

/**
 * Nadaje albo odbiera rolę moderatora przepisów.
 *
 * Granice pilnuje baza (migracja 0024), nie ten kod: rolę zmienia wyłącznie
 * administrator, wyłącznie między użytkownikiem a moderatorem, nigdy własną,
 * i nigdy na administratora. Tutaj tłumaczymy tylko komunikaty na polski.
 */
export async function ustawRole(kontoId: string, rola: 'uzytkownik' | 'moderator') {
  const { error } = await supabase.from('konta').update({ rola }).eq('id', kontoId);

  if (error) {
    if (error.message.includes('Własnej roli')) {
      throw new Error('Własnej roli nie da się zmienić — to zabezpieczenie przed odebraniem sobie dostępu.');
    }
    if (error.message.includes('administratora nadaje')) {
      throw new Error('Rolę administratora nadaje się wyłącznie w panelu Supabase.');
    }
    if (error.code === '42501') {
      throw new Error('Zmiana roli wymaga uprawnień administratora.');
    }
    throw error;
  }
}
