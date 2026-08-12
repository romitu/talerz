import { Ionicons } from '@expo/vector-icons';
import { DarkTheme, DefaultTheme, ThemeProvider, Tabs } from 'expo-router';
import { useColorScheme } from 'react-native';

import { Colors } from '@/constants/theme';

/**
 * Główny układ aplikacji. Definiuje cztery zakładki na dole ekranu.
 * Nazwa każdej zakładki (`name`) musi odpowiadać nazwie pliku w katalogu src/app.
 */
export default function UkladGlowny() {
  const schemat = useColorScheme();
  const tryb = schemat === 'dark' ? 'dark' : 'light';
  const kolory = Colors[tryb];

  return (
    <ThemeProvider value={tryb === 'dark' ? DarkTheme : DefaultTheme}>
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
            tabBarIcon: ({ color, size }) => (
              <Ionicons name="restaurant" size={size} color={color} />
            ),
          }}
        />
        <Tabs.Screen
          name="spolecznosc"
          options={{
            title: 'Społeczność',
            tabBarIcon: ({ color, size }) => (
              <Ionicons name="chatbubbles" size={size} color={color} />
            ),
          }}
        />
        <Tabs.Screen
          name="profil"
          options={{
            title: 'Profil',
            tabBarIcon: ({ color, size }) => <Ionicons name="person" size={size} color={color} />,
          }}
        />
      </Tabs>
    </ThemeProvider>
  );
}
