import { Ionicons } from '@expo/vector-icons';
import { useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';
import { Colors, Spacing } from '@/constants/theme';
import { PRZEPISY } from '@/data/przepisy';

import { useColorScheme } from 'react-native';

export default function EkranPrzepisow() {
  const schemat = useColorScheme();
  const kolory = Colors[schemat === 'dark' ? 'dark' : 'light'];

  // Zbiór identyfikatorów polubionych przepisów.
  // Na razie żyje tylko w pamięci — po zamknięciu aplikacji znika.
  // Po podłączeniu Supabase polubienia trafią do bazy i będą widoczne dla wszystkich.
  const [polubione, setPolubione] = useState<Set<string>>(new Set());

  function przelaczPolubienie(id: string) {
    setPolubione((poprzednie) => {
      const nowe = new Set(poprzednie);
      if (nowe.has(id)) {
        nowe.delete(id);
      } else {
        nowe.add(id);
      }
      return nowe;
    });
  }

  return (
    <Ekran tytul="Przepisy" podtytul={`${PRZEPISY.length} przepisy w bazie`}>
      {PRZEPISY.map((przepis) => {
        const czyPolubiony = polubione.has(przepis.id);

        return (
          <Karta key={przepis.id}>
            <ThemedText type="default">{przepis.nazwa}</ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {przepis.opis}
            </ThemedText>

            <View style={styles.stopkaKarty}>
              <ThemedText type="small" themeColor="textSecondary">
                {przepis.kcal} kcal · {przepis.bialko} g białka · {przepis.czasMinut} min
              </ThemedText>

              <Pressable
                onPress={() => przelaczPolubienie(przepis.id)}
                accessibilityRole="button"
                accessibilityLabel={czyPolubiony ? 'Cofnij polubienie' : 'Polub przepis'}
                style={({ pressed }) => [styles.przyciskLajk, pressed && styles.wcisniety]}>
                <Ionicons
                  name={czyPolubiony ? 'heart' : 'heart-outline'}
                  size={20}
                  color={czyPolubiony ? kolory.accent : kolory.textSecondary}
                />
                <ThemedText type="small" themeColor={czyPolubiony ? 'accent' : 'textSecondary'}>
                  {przepis.polubienia + (czyPolubiony ? 1 : 0)}
                </ThemedText>
              </Pressable>
            </View>
          </Karta>
        );
      })}

      <ThemedText type="small" themeColor="textSecondary" style={styles.stopka}>
        Serduszka działają tylko w tej sesji. Trwałe polubienia i przepisy od innych
        użytkowników pojawią się po podłączeniu bazy danych.
      </ThemedText>
    </Ekran>
  );
}

const styles = StyleSheet.create({
  stopkaKarty: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
    paddingTop: Spacing.one,
  },
  przyciskLajk: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  wcisniety: {
    opacity: 0.6,
  },
  stopka: {
    paddingTop: Spacing.two,
  },
});
