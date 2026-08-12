/**
 * Zwraca zestaw kolorów pasujący do aktualnego trybu (jasny / ciemny).
 * Tryb bierze się z ustawień systemowych telefonu lub przeglądarki.
 */

import { Colors } from '@/constants/theme';
import { useColorScheme } from '@/hooks/use-color-scheme';

export function useTheme() {
  const schemat = useColorScheme();

  return Colors[schemat === 'dark' ? 'dark' : 'light'];
}
