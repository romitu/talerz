import { Ionicons } from '@expo/vector-icons';
import { useTranslation } from 'react-i18next';
import { StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

export type KrokStartu = {
  tytul: string;
  opis: string;
  zrobiony: boolean;
  /** Przycisk przy PIERWSZYM niezrobionym kroku — dalsze czekają na swoją kolej. */
  akcja?: { tytul: string; onPress: () => void; zajety?: boolean };
};

/**
 * „Pierwsze kroki” — lista nad planem dla nowego konta.
 *
 * Dlaczego lista, a nie kreator
 * -----------------------------
 * Kreator z kilkoma ekranami trzeba przejść naraz, a kto go zamknie w połowie,
 * zostaje z pustą aplikacją i bez podpowiedzi. Lista nie blokuje niczego,
 * a każdy krok prowadzi do istniejącego ekranu — nie ma drugiej wersji
 * formularza profilu tylko dla nowych.
 *
 * Stan kroków liczy wołający Z DANYCH (jest profil z celem? jest plan?), a nie
 * z flagi „przeszedł kreator”. Dzięki temu lista znika sama, gdy wszystko jest
 * zrobione, i nie ma czego osobno zapisywać ani pilnować.
 */
export function PierwszeKroki({ kroki, stopka }: { kroki: KrokStartu[]; stopka?: string }) {
  const motyw = useTheme();
  const { t } = useTranslation();
  const zrobione = kroki.filter((k) => k.zrobiony).length;
  const biezacy = kroki.findIndex((k) => !k.zrobiony);

  return (
    <Karta style={styles.karta}>
      <View style={styles.naglowek}>
        <Ionicons name="flag-outline" size={20} color={motyw.accent} />
        <ThemedText type="smallBold" themeColor="textSecondary" style={styles.tytul}>
          {t('pierwszeKroki.naglowek')}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('pierwszeKroki.postep', { zrobione, wszystkie: kroki.length })}
        </ThemedText>
      </View>

      {kroki.map((k, i) => {
        const aktywny = i === biezacy;
        return (
          <View key={k.tytul} style={styles.krok}>
            <Ionicons
              name={k.zrobiony ? 'checkmark-circle' : aktywny ? 'arrow-forward-circle' : 'ellipse-outline'}
              size={24}
              color={k.zrobiony || aktywny ? motyw.accent : motyw.textSecondary}
            />
            <View style={styles.tresc}>
              <ThemedText
                type={aktywny ? 'smallBold' : 'small'}
                themeColor={k.zrobiony ? 'textSecondary' : undefined}
                style={k.zrobiony ? styles.przekreslony : undefined}>
                {i + 1}. {k.tytul}
              </ThemedText>
              {aktywny && (
                <>
                  <ThemedText type="small" themeColor="textSecondary">
                    {k.opis}
                  </ThemedText>
                  {k.akcja && (
                    <Przycisk
                      tytul={k.akcja.tytul}
                      onPress={k.akcja.onPress}
                      zajety={k.akcja.zajety}
                    />
                  )}
                </>
              )}
            </View>
          </View>
        );
      })}

      {stopka && (
        <ThemedText type="small" themeColor="textSecondary">
          {stopka}
        </ThemedText>
      )}
    </Karta>
  );
}

const styles = StyleSheet.create({
  karta: { gap: Spacing.three },
  naglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  tytul: { flex: 1 },
  krok: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
  },
  tresc: {
    flex: 1,
    gap: Spacing.two,
  },
  przekreslony: { textDecorationLine: 'line-through' },
});
