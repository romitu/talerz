import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { StyleSheet, View, type ViewStyle } from 'react-native';

import { useTheme } from '@/hooks/use-theme';
import { adresZdjecia } from '@/lib/zdjecia';

/**
 * Miniatura zdjęcia przepisu w schemacie — kwadrat albo prostokąt o podanych
 * wymiarach. Bez zdjęcia (albo przy usuniętym przepisie) neutralne pole
 * z ikoną talerza, jak w wyborze dania (`components/wybor-dania.tsx`).
 */
export function MiniaturaPrzepisu({
  sciezka,
  szerokosc,
  wysokosc,
  style,
}: {
  sciezka: string | null | undefined;
  /** Liczba pikseli albo procent szerokości rodzica, np. '100%'. */
  szerokosc: number | `${number}%`;
  wysokosc: number;
  style?: ViewStyle;
}) {
  const motyw = useTheme();
  const adres = adresZdjecia(sciezka);

  return (
    <View
      style={[
        styles.ramka,
        { width: szerokosc, height: wysokosc, backgroundColor: motyw.backgroundSelected },
        style,
      ]}>
      {adres ? (
        <Image
          source={{ uri: adres }}
          style={StyleSheet.absoluteFill}
          contentFit="cover"
          transition={150}
          accessibilityIgnoresInvertColors
        />
      ) : (
        <Ionicons
          name="restaurant-outline"
          size={Math.max(12, Math.min(28, Math.round(wysokosc * 0.45)))}
          color={motyw.textSecondary}
        />
      )}
    </View>
  );
}

/**
 * Kilka miniatur dań obok siebie — podgląd schematu na liście. Nic nie
 * rysuje, gdy zdjęć nie ma: pusty rząd ikon talerza nic by nie mówił.
 */
export function PasekMiniatur({ zdjecia, rozmiar = 44 }: { zdjecia: string[]; rozmiar?: number }) {
  if (zdjecia.length === 0) return null;
  return (
    <View style={styles.pasek}>
      {zdjecia.map((z) => (
        <MiniaturaPrzepisu key={z} sciezka={z} szerokosc={rozmiar} wysokosc={rozmiar} />
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  pasek: {
    flexDirection: 'row',
    gap: 6,
  },
  ramka: {
    borderRadius: 8,
    overflow: 'hidden',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
