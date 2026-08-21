import { Ionicons } from '@expo/vector-icons';
import { DarkTheme, DefaultTheme, ThemeProvider } from '@react-navigation/native';
import { Tabs } from 'expo-router';
import { StatusBar } from 'expo-status-bar';
import { useCallback, useEffect, useState } from 'react';
import { ActivityIndicator, View } from 'react-native';
import 'react-native-reanimated';

import { EkranLogowania } from '@/components/ekran-logowania';
import { EkranPowitalny } from '@/components/ekran-powitalny';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { ThemedView } from '@/components/themed-view';
import { PALETY, type Paleta } from '@/constants/theme';
import { useColorScheme } from '@/hooks/use-color-scheme';
import { DostawcaSesji, useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import { czyMojeKontoCzynne } from '@/lib/uzytkownicy';
import { DostawcaWygladu, useStyl } from '@/lib/wyglad';

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
    // Dostawca wyglądu obejmuje wszystko — także ekran logowania, bo wybrany
    // styl ma działać od pierwszej sekundy, jeszcze przed zalogowaniem.
    <DostawcaWygladu>
      <ThemeProvider value={tryb === 'dark' ? DarkTheme : DefaultTheme}>
        <DostawcaSesji>
          <BramkaSesji tryb={tryb} />
        </DostawcaSesji>
        <StatusBar style="auto" />
      </ThemeProvider>
    </DostawcaWygladu>
  );
}

function BramkaSesji({ tryb }: { tryb: 'light' | 'dark' }) {
  const { sesja, ladowanie } = useSesja();
  const { styl } = useStyl();
  const kolory = PALETY[styl][tryb];

  /*
    Powitanie pokazujemy po KAŻDYM zalogowaniu.

    Stan trzymamy tutaj, a nie w pamięci urządzenia, i to jest cała sztuczka:
    komponent żyje tak długo jak otwarta aplikacja, więc odhaczone powitanie
    zostaje odhaczone do końca pracy, a wraca przy następnym uruchomieniu
    albo po wylogowaniu. Zapisywanie tego gdziekolwiek dałoby dokładnie
    odwrotny skutek do zamierzonego.
  */
  const [powitanie, setPowitanie] = useState(true);

  /*
    Konto mogło zostać wyłączone już PO zalogowaniu.

    Sesja trzyma się tygodniami, więc bez tego sprawdzenia wyłączony użytkownik
    chodziłby po aplikacji, w której wszystko jest puste — plan bez dni, zakupy
    bez pozycji, profil bez profilu — i nie miałby jak się domyślić dlaczego.
    Reguły dostępu w bazie już go blokują; tu chodzi wyłącznie o to, żeby
    powiedzieć mu, co się stało.

    `null` znaczy „nie wiem” i wtedy NIE wylogowujemy. Zerwane połączenie nie
    może wyglądać jak odebrany dostęp.
  */
  const [wylaczone, setWylaczone] = useState(false);
  const kontoId = sesja?.user.id;

  useEffect(() => {
    if (!kontoId) {
      setWylaczone(false);
      return;
    }
    let aktualne = true;
    czyMojeKontoCzynne(kontoId).then((czynne) => {
      if (aktualne && czynne === false) setWylaczone(true);
    });
    return () => {
      aktualne = false;
    };
  }, [kontoId]);

  const wyloguj = useCallback(() => {
    setWylaczone(false);
    supabase.auth.signOut();
  }, []);

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

  if (wylaczone) {
    return (
      <ThemedView style={{ flex: 1, justifyContent: 'center', padding: 24 }}>
        <Karta>
          <ThemedText type="subtitle" themeColor="accent">
            To konto zostało wyłączone
          </ThemedText>
          <ThemedText type="default">
            Dostęp do Talerza został wstrzymany przez administratora. Twoje dane —
            plany, przepisy i listy zakupów — są nietknięte i wrócą, gdy konto
            zostanie włączone z powrotem.
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Hasło jest poprawne, więc nie ma potrzeby go zmieniać ani zakładać nowego
            konta. Skontaktuj się z administratorem.
          </ThemedText>
          <Przycisk tytul="Wyloguj się" onPress={wyloguj} />
        </Karta>
      </ThemedView>
    );
  }

  if (powitanie) {
    return <EkranPowitalny onDalej={() => setPowitanie(false)} />;
  }

  return <Zakladki kolory={kolory} />;
}

function Zakladki({ kolory }: { kolory: Paleta }) {
  return (
    <Tabs
      /*
        Powrót ma wracać tam, skąd przyszedłeś.

        Domyślnie („firstRoute”) każde cofnięcie skacze na PIERWSZĄ zakładkę,
        czyli na Plan dnia. Dlatego po zapisaniu przepisu ekran lądował na
        planie zamiast na liście przepisów — a to samo dotyczyło składników,
        celów i podglądu przepisu w kuchni.

        „history” pilnuje kolejności odwiedzin: z formularza wracasz na listę,
        z listy tam, gdzie byłeś przed nią.
      */
      backBehavior="history"
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
        name="zakupy"
        options={{
          title: 'Zakupy',
          tabBarIcon: ({ color, size }) => <Ionicons name="cart" size={size} color={color} />,
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
        name="instrukcja"
        options={{
          title: 'Instrukcja',
          tabBarIcon: ({ color, size }) => <Ionicons name="help-circle" size={size} color={color} />,
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
      <Tabs.Screen name="przepis" options={{ href: null }} />
      <Tabs.Screen name="uzytkownicy" options={{ href: null }} />
    </Tabs>
  );
}
