import { useState } from 'react';
import { KeyboardAvoidingView, Platform, ScrollView, StyleSheet, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { Karta } from './karta';
import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { MaxContentWidth, Spacing } from '@/constants/theme';
import { baza_skonfigurowana, supabase } from '@/lib/supabase';

type Tryb = 'logowanie' | 'rejestracja';

/** Tłumaczy komunikaty Supabase na zrozumiały polski. */
function komunikat(tresc: string): string {
  const t = tresc.toLowerCase();
  if (t.includes('invalid login credentials')) return 'Nieprawidłowy adres e-mail lub hasło.';
  if (t.includes('email not confirmed')) return 'Potwierdź adres e-mail — sprawdź skrzynkę.';
  if (t.includes('user already registered')) return 'Konto o tym adresie już istnieje.';
  if (t.includes('password should be')) return 'Hasło musi mieć co najmniej 6 znaków.';
  if (t.includes('unable to validate email')) return 'Adres e-mail wygląda na nieprawidłowy.';
  if (t.includes('network') || t.includes('fetch')) return 'Brak połączenia z bazą danych.';
  return tresc;
}

export function EkranLogowania() {
  const [tryb, setTryb] = useState<Tryb>('logowanie');
  const [email, setEmail] = useState('');
  const [haslo, setHaslo] = useState('');
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [informacja, setInformacja] = useState<string | null>(null);

  const rejestracja = tryb === 'rejestracja';

  async function wyslij() {
    setBlad(null);
    setInformacja(null);

    if (!email.trim() || !haslo) {
      setBlad('Podaj adres e-mail i hasło.');
      return;
    }

    setZajety(true);
    try {
      if (rejestracja) {
        const { data, error } = await supabase.auth.signUp({
          email: email.trim(),
          password: haslo,
        });
        if (error) throw error;

        // Gdy w Supabase włączone jest potwierdzanie adresu, sesja nie powstaje od razu.
        if (!data.session) {
          setInformacja('Konto założone. Otwórz link potwierdzający, który wysłaliśmy na podany adres.');
          setTryb('logowanie');
        }
      } else {
        const { error } = await supabase.auth.signInWithPassword({
          email: email.trim(),
          password: haslo,
        });
        if (error) throw error;
      }
    } catch (e) {
      setBlad(komunikat(e instanceof Error ? e.message : String(e)));
    } finally {
      setZajety(false);
    }
  }

  return (
    <ThemedView style={styles.tlo}>
      <SafeAreaView style={styles.obszar}>
        <KeyboardAvoidingView
          behavior={Platform.OS === 'ios' ? 'padding' : undefined}
          style={styles.obszar}>
          <ScrollView contentContainerStyle={styles.zawartosc} keyboardShouldPersistTaps="handled">
            <View style={styles.naglowek}>
              <ThemedText type="title">Talerz</ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                Gotujesz raz, jesz trzy dni
              </ThemedText>
            </View>

            {!baza_skonfigurowana && (
              <Karta>
                <ThemedText type="smallBold" themeColor="accent">
                  Brak połączenia z bazą
                </ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  Utwórz plik .env według wzoru z .env.example i uruchom ponownie komendą
                  npx.cmd expo start --clear
                </ThemedText>
              </Karta>
            )}

            <Karta style={styles.formularz}>
              <ThemedText type="default">
                {rejestracja ? 'Załóż konto' : 'Zaloguj się'}
              </ThemedText>

              <Pole
                etykieta="Adres e-mail"
                value={email}
                onChangeText={setEmail}
                autoCapitalize="none"
                autoComplete="email"
                keyboardType="email-address"
                inputMode="email"
                placeholder="jan@przyklad.pl"
              />

              <Pole
                etykieta="Hasło"
                value={haslo}
                onChangeText={setHaslo}
                secureTextEntry
                autoCapitalize="none"
                autoComplete={rejestracja ? 'new-password' : 'current-password'}
                placeholder={rejestracja ? 'co najmniej 6 znaków' : ''}
              />

              {blad && (
                <ThemedText type="small" themeColor="accent">
                  {blad}
                </ThemedText>
              )}

              {informacja && (
                <ThemedText type="small" themeColor="textSecondary">
                  {informacja}
                </ThemedText>
              )}

              <Przycisk
                tytul={rejestracja ? 'Załóż konto' : 'Zaloguj się'}
                onPress={wyslij}
                zajety={zajety}
                wylaczony={!baza_skonfigurowana}
              />

              <Przycisk
                tytul={rejestracja ? 'Mam już konto' : 'Nie mam jeszcze konta'}
                wariant="poboczny"
                onPress={() => {
                  setTryb(rejestracja ? 'logowanie' : 'rejestracja');
                  setBlad(null);
                  setInformacja(null);
                }}
              />
            </Karta>

            <ThemedText type="small" themeColor="textSecondary" style={styles.stopka}>
              Talerz jest przeznaczony wyłącznie dla osób pełnoletnich i nie udziela porad
              medycznych.
            </ThemedText>
          </ScrollView>
        </KeyboardAvoidingView>
      </SafeAreaView>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  tlo: { flex: 1 },
  obszar: { flex: 1 },
  zawartosc: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: Spacing.three,
    gap: Spacing.three,
    width: '100%',
    maxWidth: MaxContentWidth,
    alignSelf: 'center',
  },
  naglowek: {
    alignItems: 'center',
    gap: Spacing.one,
    paddingBottom: Spacing.three,
  },
  formularz: {
    gap: Spacing.three,
  },
  stopka: {
    textAlign: 'center',
    paddingTop: Spacing.two,
  },
});
