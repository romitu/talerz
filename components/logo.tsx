import { StyleSheet, Text, View } from 'react-native';

import { useTheme } from '@/hooks/use-theme';

/**
 * Znak Talerza — ten sam co w nagłówku strony mojtalerz.com: talerz widziany
 * z góry (dwa koncentryczne kółka) i słowo „talerz” małymi literami, grubo,
 * ciasno składane.
 *
 * Rysowany ramkami, nie obrazkiem: przyjmuje kolor akcentu bieżącego stylu,
 * więc w ciemnym trybie i w innych stylach wygląda poprawnie bez osobnych plików.
 */
export function Logo({ rozmiar = 40 }: { rozmiar?: number }) {
  const motyw = useTheme();
  const kolko = rozmiar * 1.05;

  return (
    <View style={styles.rzad} accessibilityRole="header" accessibilityLabel="Talerz">
      <View
        style={[
          styles.talerz,
          { width: kolko, height: kolko, borderRadius: kolko / 2, borderColor: motyw.accent },
        ]}>
        <View
          style={[
            styles.srodek,
            {
              borderColor: motyw.accent,
              borderRadius: kolko / 2,
              margin: kolko * 0.16,
            },
          ]}
        />
      </View>
      <Text
        style={[
          styles.napis,
          { color: motyw.text, fontSize: rozmiar, letterSpacing: -rozmiar * 0.05 },
        ]}>
        talerz
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  rzad: { flexDirection: 'row', alignItems: 'center', gap: 12 },
  talerz: { borderWidth: 2 },
  srodek: { flex: 1, borderWidth: 1 },
  napis: { fontWeight: 800 },
});
