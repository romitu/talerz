/**
 * Połączenie z bazą danych Supabase.
 *
 * Adres i klucz pochodzą z pliku .env w głównym katalogu projektu.
 * Przedrostek EXPO_PUBLIC_ oznacza, że wartość trafia do aplikacji na telefonie —
 * i tak ma być. Klucz `anon` jest publiczny z założenia, a bezpieczeństwo
 * zapewniają reguły dostępu po stronie bazy, nie ukrywanie klucza.
 *
 * Klucz `service_role` NIGDY nie trafia do tego pliku ani nigdzie w kodzie
 * aplikacji — omija wszystkie reguły dostępu.
 */

import AsyncStorage from '@react-native-async-storage/async-storage';
import { createClient } from '@supabase/supabase-js';
import { Platform } from 'react-native';
import 'react-native-url-polyfill/auto';

/**
 * Wartość zmiennej albo `null`, gdy jej nie ma.
 *
 * Pusty napis liczy się jako brak i to jest tu sedno. Metro PODSTAWIA wartości
 * `process.env.EXPO_PUBLIC_*` w kodzie już przy budowaniu — a gdy zmiennej nie
 * ma, wstawia PUSTY NAPIS, nie `undefined`. Zapis `adres ?? 'zapasowy'` tego nie
 * łapie, bo `??` reaguje wyłącznie na `null` i `undefined`.
 *
 * Objawiło się to dopiero przy budowaniu na serwerze, gdzie nie ma pliku `.env`:
 * zabezpieczenie wyglądało na działające, a `createClient('')` wywracał całą
 * budowę komunikatem „supabaseUrl is required”. Na komputerze, gdzie `.env`
 * jest, nie dało się tego zobaczyć.
 */
function zmienna(wartosc: string | undefined): string | null {
  const w = (wartosc ?? '').trim();
  return w.length > 0 ? w : null;
}

const adres = zmienna(process.env.EXPO_PUBLIC_SUPABASE_URL);
const klucz = zmienna(process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY);

/** Czy aplikacja ma komplet danych do połączenia z bazą. */
export const baza_skonfigurowana = adres !== null && klucz !== null;

if (!baza_skonfigurowana) {
  console.warn(
    'Brak danych połączenia z bazą. Na komputerze: utwórz plik .env według wzoru ' +
      'z .env.example i uruchom ponownie komendą npx.cmd expo start --clear. ' +
      'Przy budowaniu na serwerze: sprawdź sekrety EXPO_PUBLIC_SUPABASE_URL ' +
      'i EXPO_PUBLIC_SUPABASE_ANON_KEY w ustawieniach repozytorium.'
  );
}

// Adres zapasowy musi być poprawnym adresem — inaczej `createClient` rzuca
// wyjątkiem i aplikacja nie wstaje wcale, zamiast pokazać czytelny komunikat
// na ekranie logowania.
export const supabase = createClient(adres ?? 'https://brak.supabase.co', klucz ?? 'brak', {
  auth: {
    // Na telefonie sesję trzymamy w pamięci urządzenia, w przeglądarce robi to sama przeglądarka.
    storage: Platform.OS === 'web' ? undefined : AsyncStorage,
    autoRefreshToken: true,
    persistSession: true,
    // Wykrywanie sesji z adresu URL ma sens tylko w przeglądarce.
    detectSessionInUrl: Platform.OS === 'web',
  },
});
