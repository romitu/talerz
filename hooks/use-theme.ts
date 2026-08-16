/**
 * Zwraca zestaw kolorów pasujący do wybranego stylu i aktualnego trybu.
 *
 * Styl wybiera użytkownik (Profil → Wygląd), tryb jasny/ciemny bierze się
 * z ustawień systemowych telefonu lub przeglądarki.
 */

import { PALETY } from '@/constants/theme';
import { useColorScheme } from '@/hooks/use-color-scheme';
import { useStyl } from '@/lib/wyglad';

export function useTheme() {
  const schemat = useColorScheme();
  const { styl } = useStyl();

  return PALETY[styl][schemat === 'dark' ? 'dark' : 'light'];
}
