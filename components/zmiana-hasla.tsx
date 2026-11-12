import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { StyleSheet } from 'react-native';

import { Karta } from './karta';
import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { komunikatBledu } from '@/lib/blad';
import {
  komunikatLogowania,
  sprawdzNoweHaslo,
  ustawNoweHaslo,
  zmienHaslo,
  MIN_DLUGOSC_HASLA,
} from '@/lib/haslo';

type Props =
  | {
      /** Zalogowany użytkownik zmienia hasło w Profilu — musi podać obecne. */
      tryb: 'zmiana';
      email: string;
    }
  | {
      /** Wejście z linku resetu — obecnego hasła nikt nie pamięta. */
      tryb: 'odzyskiwanie';
      onGotowe: () => void;
    };

/**
 * Formularz hasła. W Profilu zwinięty do jednego przycisku, żeby trzy pola
 * nie wisiały na ekranie, z którego korzysta się do zupełnie czego innego.
 */
export function ZmianaHasla(props: Props) {
  const { t } = useTranslation();
  const odzyskiwanie = props.tryb === 'odzyskiwanie';
  const [rozwiniete, setRozwiniete] = useState(odzyskiwanie);
  const [obecne, setObecne] = useState('');
  const [nowe, setNowe] = useState('');
  const [powtorzone, setPowtorzone] = useState('');
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [zmienione, setZmienione] = useState(false);

  function wyczysc() {
    setObecne('');
    setNowe('');
    setPowtorzone('');
    setBlad(null);
  }

  async function zapisz() {
    setBlad(null);
    if (!odzyskiwanie && !obecne) {
      setBlad(t('haslo.podajObecne'));
      return;
    }
    const bladFormularza = sprawdzNoweHaslo(nowe, powtorzone);
    if (bladFormularza) {
      setBlad(bladFormularza);
      return;
    }

    setZajety(true);
    try {
      if (props.tryb === 'odzyskiwanie') {
        await ustawNoweHaslo(nowe);
        props.onGotowe();
        return;
      }
      await zmienHaslo(props.email, obecne, nowe);
      wyczysc();
      setRozwiniete(false);
      setZmienione(true);
    } catch (e) {
      setBlad(komunikatLogowania(komunikatBledu(e)));
    } finally {
      setZajety(false);
    }
  }

  if (!rozwiniete) {
    return (
      <Karta style={styles.karta}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('haslo.naglowek')}
        </ThemedText>
        {zmienione && (
          <ThemedText type="small" themeColor="textSecondary">
            {t('haslo.zmienione')}
          </ThemedText>
        )}
        <Przycisk
          tytul={t('haslo.zmien')}
          ikona="key-outline"
          wariant="poboczny"
          onPress={() => {
            setZmienione(false);
            setRozwiniete(true);
          }}
        />
      </Karta>
    );
  }

  return (
    <Karta style={styles.karta}>
      <ThemedText
        type={odzyskiwanie ? 'default' : 'smallBold'}
        themeColor={odzyskiwanie ? undefined : 'textSecondary'}>
        {odzyskiwanie ? t('haslo.ustawNoweTytul') : t('haslo.naglowek')}
      </ThemedText>
      {odzyskiwanie && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('haslo.ustawNoweOpis')}
        </ThemedText>
      )}

      {!odzyskiwanie && (
        <Pole
          etykieta={t('haslo.obecne')}
          value={obecne}
          onChangeText={setObecne}
          haslo
          autoCapitalize="none"
          autoComplete="current-password"
        />
      )}
      <Pole
        etykieta={t('haslo.nowe')}
        value={nowe}
        onChangeText={setNowe}
        haslo
        autoCapitalize="none"
        autoComplete="new-password"
        placeholder={t('haslo.minZnakow', { liczba: MIN_DLUGOSC_HASLA })}
      />
      <Pole
        etykieta={t('haslo.powtorz')}
        value={powtorzone}
        onChangeText={setPowtorzone}
        haslo
        autoCapitalize="none"
        autoComplete="new-password"
        onSubmitEditing={zapisz}
      />

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <Przycisk tytul={t('haslo.zapisz')} onPress={zapisz} zajety={zajety} />
      {!odzyskiwanie && (
        <Przycisk
          tytul={t('haslo.anuluj')}
          wariant="poboczny"
          onPress={() => {
            wyczysc();
            setRozwiniete(false);
          }}
          wylaczony={zajety}
        />
      )}
    </Karta>
  );
}

const styles = StyleSheet.create({
  karta: {
    gap: Spacing.three,
  },
});
