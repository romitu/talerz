import { Ionicons } from '@expo/vector-icons';
import { DarkTheme, DefaultTheme, ThemeProvider } from '@react-navigation/native';
import { Tabs } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { ActivityIndicator, View } from 'react-native';
import 'react-native-reanimated';

import { EkranLogowania } from '@/components/ekran-logowania';
import { ThemedView } from '@/components/themed-view';
import { Colors, type Paleta } from '@/constants/theme';
import { useColorScheme } from '@/hooks/use-color-scheme';
import { DostawcaSesji, useSesja } from '@/lib/sesja';

/**
 * Układ główny. Najpierw sprawdza, kto jest zalogowany:
 *   * trwa sprawdzanie  -> kółko oczekiwania
 *   * nikt niezalogowany -> ekran logowania
 *   * ktoś zalogowany    -> cztery zakładki aplikacji
 */
export default function UkladGlowny() {
  const schemat = useColorScheme();
  const tryb = schemat === 'dark' ? 'dark' : 'light';

  return (
    <ThemeProvider value={tryb === 'dark' ? DarkTheme : DefaultTheme}>
      <DostawcaSesji>
        <BramkaSesji tryb={tryb} />
      </DostawcaSesji>
      <StatusBar style="auto" />
    </ThemeProvider>
  );
}

function BramkaSesji({ tryb }: { tryb: 'light' | 'dark' }) {
  const { sesja, ladowanie } = useSesja();
  const kolory = Colors[tryb];

  if (ladowanie) {
    return (
      <ThemedView style={{ flex: 1 }}>
        <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
          <ActivityIndicator size="large" color={kolory.accent} />
        </View>
      </ThemedView>
    );
  }

  if (!sesja) {
    return <EkranLogowania />;
  }

  return <Zakladki kolory={kolory} />;
}

function Zakladki({ kolory }: { kolory: Paleta }) {
  return (
    <Tabs
      screenOptions={{
        headerShown: false,
        tabBarActiveTintColor: kolory.accent,
        tabBarInactiveTintColor: kolory.textSecondary,
        tabBarStyle: {
          backgroundColor: kolory.backgroundElement,
          borderTopColor: kolory.border,
        },
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Plan',
          tabBarIcon: ({ color, size }) => <Ionicons name="today" size={size} color={color} />,
        }}
      />
      <Tabs.Screen
        name="przepisy"
        options={{
          title: 'Przepisy',
          tabBarIcon: ({ color, size }) => <Ionicons name="restaurant" size={size} color={color} />,
        }}
      />
      <Tabs.Screen
        name="spolecznosc"
        options={{
          title: 'Społeczność',
          tabBarIcon: ({ color, size }) => <Ionicons name="chatbubbles" size={size} color={color} />,
        }}
      />
      <Tabs.Screen
        name="profil"
        options={{
          title: 'Profil',
          tabBarIcon: ({ color, size }) => <Ionicons name="person" size={size} color={color} />,
        }}
      />

      {/* Ekrany otwierane z innych miejsc — nie pokazują się na pasku zakładek. */}
      <Tabs.Screen name="profil-formularz" options={{ href: null }} />
      <Tabs.Screen name="cele-formularz" options={{ href: null }} />
      <Tabs.Screen name="przepis-formularz" options={{ href: null }} />
      <Tabs.Screen name="skladniki" options={{ href: null }} />
      <Tabs.Screen name="zakupy" options={{ href: null }} />
    </Tabs>
  );
}
