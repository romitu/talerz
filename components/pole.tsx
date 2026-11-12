import { Ionicons } from '@expo/vector-icons';
import { useState, type Ref } from 'react';
import { useTranslation } from 'react-i18next';
import {
  Pressable,
  StyleSheet,
  TextInput,
  View,
  type TextInputInstance,
  type TextInputProps,
} from 'react-native';

import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

type PoleProps = TextInputProps & {
  etykieta: string;
  /** Do przeniesienia kursora z innego pola. */
  ref?: Ref<TextInputInstance>;
  /**
   * Pole hasła: znaki ukryte, z przyciskiem oka, który pokazuje wpisany tekst.
   * Zastępuje `secureTextEntry` — bez podglądu trudno ocenić, co się wpisało.
   */
  haslo?: boolean;
};

/** Pole tekstowe z podpisem, dopasowane do jasnego i ciemnego motywu. */
export function Pole({ etykieta, style, haslo = false, ...reszta }: PoleProps) {
  const motyw = useTheme();
  const { t } = useTranslation();
  const [widoczne, setWidoczne] = useState(false);

  return (
    <View style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {etykieta}
      </ThemedText>
      <View>
        <TextInput
          placeholderTextColor={motyw.textSecondary}
          style={[
            styles.pole,
            {
              color: motyw.text,
              backgroundColor: motyw.backgroundElement,
              borderColor: motyw.border,
            },
            haslo && styles.miejsceNaOko,
            style,
          ]}
          {...reszta}
          secureTextEntry={haslo ? !widoczne : reszta.secureTextEntry}
        />
        {haslo && (
          <Pressable
            onPress={() => setWidoczne((p) => !p)}
            hitSlop={8}
            accessibilityRole="button"
            accessibilityLabel={widoczne ? t('pole.ukryjHaslo') : t('pole.pokazHaslo')}
            style={styles.oko}>
            <Ionicons
              name={widoczne ? 'eye-off-outline' : 'eye-outline'}
              size={20}
              color={motyw.textSecondary}
            />
          </Pressable>
        )}
      </View>
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
  miejsceNaOko: {
    paddingRight: 44,
  },
  oko: {
    position: 'absolute',
    right: Spacing.two,
    top: 0,
    bottom: 0,
    justifyContent: 'center',
  },
});
