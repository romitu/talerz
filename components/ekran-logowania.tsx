import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { KeyboardAvoidingView, Platform, ScrollView, StyleSheet, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { Karta } from './karta';
import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { komunikatBledu } from '@/lib/blad';
import i18n from '@/lib/jezyk';
import { MaxContentWidth, Spacing } from '@/constants/theme';
import { baza_skonfigurowana, supabase } from '@/lib/supabase';

type Tryb = 'logowanie' | 'rejestracja';

/**
 * Czy pokazywać zakładanie konta.
 *
 * Rejestracja jest otwarta — każdy z linkiem do aplikacji może założyć sobie
 * konto sam, bez zgody administratora. Nowe konto trafia do bazy od razu
 * jako aktywne, z rolą zwykłego użytkownika (trigger `konto_po_rejestracji`,
 * migracja 0001 i 0023) — nie ma tu żadnego ręcznego zatwierdzania.
 * Administrator widzi je na ekranie „Użytkownicy” (patrz baner nowych kont
 * od ostatniej wizyty) i w razie czego może je wyłączyć.
 *
 * Warunek: w Supabase musi być włączone „Allow new users to sign up"
 * (Authentication → Sign In / Providers) — bez tego ta stała nic nie da,
 * `signUp` niżej i tak skończy się błędem z panelu.
 *
 * Żeby to cofnąć, wystarczy przestawić tę jedną stałą z powrotem na `false`
 * (i wyłączyć rejestrację w panelu) — sam kod rejestracji zostaje na miejscu.
 */
const REJESTRACJA_OTWARTA = true;

/** Tłumaczy komunikaty Supabase na zrozumiały polski. */
function komunikat(tresc: string): string {
  const m = tresc.toLowerCase();
  if (m.includes('invalid login credentials')) return i18n.t('logowanie.bladDanych');
  if (m.includes('email not confirmed')) return i18n.t('logowanie.bladNiepotwierdzony');
  if (m.includes('user already registered')) return i18n.t('logowanie.bladIstnieje');
  if (m.includes('password should be')) return i18n.t('logowanie.bladHaslo');
  if (m.includes('unable to validate email')) return i18n.t('logowanie.bladEmail');
  if (m.includes('network') || m.includes('fetch')) return i18n.t('logowanie.bladPolaczenia');
  return tresc;
}

export function EkranLogowania() {
  const { t } = useTranslation();
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
      setBlad(t('logowanie.podajDane'));
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
          setInformacja(t('logowanie.kontoZalozone'));
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
      setBlad(komunikat(komunikatBledu(e)));
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
                {t('logowanie.slogan')}
              </ThemedText>
            </View>

            {!baza_skonfigurowana && (
              <Karta>
                <ThemedText type="smallBold" themeColor="accent">
                  {t('logowanie.brakBazy')}
                </ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  {t('logowanie.brakBazyOpis')}
                </ThemedText>
              </Karta>
            )}

            <Karta style={styles.formularz}>
              <ThemedText type="default">
                {rejestracja ? t('logowanie.zalozKonto') : t('logowanie.zaloguj')}
              </ThemedText>

              <Pole
                etykieta={t('logowanie.email')}
                value={email}
                onChangeText={setEmail}
                autoCapitalize="none"
                autoComplete="email"
                keyboardType="email-address"
                inputMode="email"
                placeholder={t('logowanie.przykladEmail')}
              />

              <Pole
                etykieta={t('logowanie.hasloPole')}
                value={haslo}
                onChangeText={setHaslo}
                secureTextEntry
                autoCapitalize="none"
                autoComplete={rejestracja ? 'new-password' : 'current-password'}
                placeholder={rejestracja ? t('logowanie.min6') : ''}
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
                tytul={rejestracja ? t('logowanie.zalozKonto') : t('logowanie.zaloguj')}
                onPress={wyslij}
                zajety={zajety}
                wylaczony={!baza_skonfigurowana}
              />

              {REJESTRACJA_OTWARTA ? (
                <Przycisk
                  tytul={rejestracja ? t('logowanie.mamKonto') : t('logowanie.nieMamKonta')}
                  wariant="poboczny"
                  onPress={() => {
                    setTryb(rejestracja ? 'logowanie' : 'rejestracja');
                    setBlad(null);
                    setInformacja(null);
                  }}
                />
              ) : (
                <ThemedText type="small" themeColor="textSecondary">
                  {t('logowanie.rejestracjaZamknieta')}
                </ThemedText>
              )}
            </Karta>

            <ThemedText type="small" themeColor="textSecondary" style={styles.stopka}>
              {t('logowanie.stopka')}
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
