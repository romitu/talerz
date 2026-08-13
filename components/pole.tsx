import { StyleSheet, TextInput, View, type TextInputProps } from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type PoleProps = TextInputProps & {
  etykieta: string;
};

/** Pole tekstowe z podpisem, dopasowane do jasnego i ciemnego motywu. */
export function Pole({ etykieta, style, ...reszta }: PoleProps) {
  const motyw = useTheme();

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {etykieta}
      </ThemedText>
      <TextInput
        placeholderTextColor={motyw.textSecondary}
        style={[
          styles.pole,
          {
            color: motyw.text,
            backgroundColor: motyw.backgroundElement,
            borderColor: motyw.border,
          },
          style,
        ]}
        {...reszta}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: {
    gap: Spacing.one,
  },
  pole: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
    fontSize: 16,
    minHeight: 46,
  },
});
