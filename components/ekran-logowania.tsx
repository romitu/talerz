import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { KeyboardAvoidingView, Platform, ScrollView, StyleSheet, View } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';

import { Karta } from './karta';
import { Logo } from './logo';
import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { komunikatBledu } from '@/lib/blad';
import i18n from '@/lib/jezyk';
import { MaxContentWidth, Spacing } from '@/constants/theme';
import { komunikatLogowania, linkResetuWygasl, wyslijLinkResetu } from '@/lib/haslo';
import { baza_skonfigurowana, supabase } from '@/lib/supabase';

type Tryb = 'logowanie' | 'rejestracja' | 'reset';

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

export function EkranLogowania() {
  const { t } = useTranslation();
  const [tryb, setTryb] = useState<Tryb>('logowanie');
  const [email, setEmail] = useState('');
  const [haslo, setHaslo] = useState('');
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(
    linkResetuWygasl ? i18n.t('haslo.linkWygasl') : null
  );
  const [informacja, setInformacja] = useState<string | null>(null);

  const rejestracja = tryb === 'rejestracja';
  const reset = tryb === 'reset';

  function przelacz(nowy: Tryb) {
    setTryb(nowy);
    setBlad(null);
    setInformacja(null);
  }

  /*
    Ten sam komunikat niezależnie od tego, czy konto istnieje — inaczej
    formularz zdradzałby każdemu, kto ma konto w Talerzu. Supabase zresztą
    też nie mówi, czy wysłał maila.
  */
  async function wyslijReset() {
    setBlad(null);
    setInformacja(null);
    if (!email.trim()) {
      setBlad(t('haslo.podajEmail'));
      return;
    }
    setZajety(true);
    try {
      await wyslijLinkResetu(email.trim());
      setInformacja(t('haslo.linkWyslany'));
    } catch (e) {
      setBlad(komunikatLogowania(komunikatBledu(e)));
    } finally {
      setZajety(false);
    }
  }

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
      setBlad(komunikatLogowania(komunikatBledu(e)));
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
              <Logo rozmiar={40} />
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
                {reset
                  ? t('haslo.resetTytul')
                  : rejestracja
                    ? t('logowanie.zalozKonto')
                    : t('logowanie.zaloguj')}
              </ThemedText>

              {reset && (
                <ThemedText type="small" themeColor="textSecondary">
                  {t('haslo.resetOpis')}
                </ThemedText>
              )}

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

              {!reset && (
                <Pole
                  etykieta={t('logowanie.hasloPole')}
                  value={haslo}
                  onChangeText={setHaslo}
                  haslo
                  autoCapitalize="none"
                  autoComplete={rejestracja ? 'new-password' : 'current-password'}
                  placeholder={rejestracja ? t('logowanie.min6') : ''}
                />
              )}

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
                tytul={
                  reset
                    ? t('haslo.wyslijLink')
                    : rejestracja
                      ? t('logowanie.zalozKonto')
                      : t('logowanie.zaloguj')
                }
                onPress={reset ? wyslijReset : wyslij}
                zajety={zajety}
                wylaczony={!baza_skonfigurowana}
              />

              {tryb === 'logowanie' && (
                <Przycisk
                  tytul={t('haslo.niePamietam')}
                  wariant="poboczny"
                  onPress={() => przelacz('reset')}
                />
              )}

              {reset ? (
                <Przycisk
                  tytul={t('haslo.wrocDoLogowania')}
                  wariant="poboczny"
                  onPress={() => przelacz('logowanie')}
                />
              ) : REJESTRACJA_OTWARTA ? (
                <Przycisk
                  tytul={rejestracja ? t('logowanie.mamKonto') : t('logowanie.nieMamKonta')}
                  wariant="poboczny"
                  onPress={() => przelacz(rejestracja ? 'logowanie' : 'rejestracja')}
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
