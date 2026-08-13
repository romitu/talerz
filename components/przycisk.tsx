import { ActivityIndicator, Pressable, StyleSheet, type ViewStyle } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type PrzyciskProps = {
  tytul: string;
  onPress: () => void;
  wariant?: 'glowny' | 'poboczny';
  zajety?: boolean;
  wylaczony?: boolean;
  style?: ViewStyle;
};

export function Przycisk({
  tytul,
  onPress,
  wariant = 'glowny',
  zajety = false,
  wylaczony = false,
  style,
}: PrzyciskProps) {
  const motyw = useTheme();
  const glowny = wariant === 'glowny';
  const nieczynny = wylaczony || zajety;

  return (
    <Pressable
      onPress={onPress}
      disabled={nieczynny}
      accessibilityRole="button"
      style={({ pressed }) => [
        styles.przycisk,
        {
          backgroundColor: glowny ? motyw.accent : 'transparent',
          borderColor: motyw.accent,
          borderWidth: glowny ? 0 : 1,
        },
        pressed && styles.wcisniety,
        nieczynny && styles.nieczynny,
        style,
      ]}>
      {zajety ? (
        <ActivityIndicator color={glowny ? '#FFFFFF' : motyw.accent} />
      ) : (
        <ThemedText type="smallBold" style={{ color: glowny ? '#FFFFFF' : motyw.accent }}>
          {tytul}
        </ThemedText>
      )}
    </Pressable>
  );
}

const styles = StyleSheet.create({
  przycisk: {
    borderRadius: Spacing.two,
    paddingVertical: Spacing.three,
    paddingHorizontal: Spacing.four,
    alignItems: 'center',
    justifyContent: 'center',
    minHeight: 48,
  },
  wcisniety: {
    opacity: 0.75,
  },
  nieczynny: {
    opacity: 0.5,
  },
});
