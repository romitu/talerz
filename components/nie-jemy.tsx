import { Ionicons } from '@expo/vector-icons';
import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { Przycisk } from './przycisk';
import { TabelaWyboru } from './tabela-wyboru';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { pobierzSkladniki, type Skladnik } from '@/lib/skladniki';
import {
  pobierzWykluczone,
  ustawWykluczony,
  type WykluczonySkladnik,
} from '@/lib/wykluczenia';

/**
 * Sekcja „Nie jemy” na ekranie Profilu — składniki, których to konto nie je
 * (migracja 0049).
 *
 * Wykluczenie dotyczy całego konta, nie jednej osoby: garnek jest wspólny,
 * więc danie z jajkiem odpada z planu wszystkich, jeśli ktokolwiek jajek nie je.
 *
 * Pełna lista składników wczytuje się dopiero po rozwinięciu wyboru — większość
 * wejść na Profil nie ma nic wspólnego z wykluczeniami.
 */
export function NieJemy({ kontoId }: { kontoId: string | undefined }) {
  const motyw = useTheme();
  const { t } = useTranslation();
  const [wykluczone, setWykluczone] = useState<WykluczonySkladnik[]>([]);
  const [skladniki, setSkladniki] = useState<Skladnik[] | null>(null);
  const [wybieranie, setWybieranie] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  useEffect(() => {
    if (!kontoId) return;
    pobierzWykluczone()
      .then(setWykluczone)
      .catch((e) => setBlad(komunikatBledu(e)));
  }, [kontoId]);

  async function otworzWybor() {
    setWybieranie(true);
    if (skladniki) return;
    try {
      setSkladniki(await pobierzSkladniki());
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  async function przelacz(skladnikId: string, nazwa: string) {
    if (!kontoId) return;
    setBlad(null);
    const nowy = !wykluczone.some((w) => w.skladnik_id === skladnikId);
    const poprzednie = wykluczone;

    // Zmiana widoczna od razu, zanim baza potwierdzi.
    setWykluczone(
      nowy
        ? [...wykluczone, { skladnik_id: skladnikId, nazwa }].sort((a, b) =>
            a.nazwa.localeCompare(b.nazwa, 'pl')
          )
        : wykluczone.filter((w) => w.skladnik_id !== skladnikId)
    );

    try {
      await ustawWykluczony(kontoId, skladnikId, nowy);
    } catch (e) {
      setBlad(komunikatBledu(e));
      setWykluczone(poprzednie); // nie udało się — wracamy do stanu sprzed dotknięcia
    }
  }

  return (
    <Karta>
      <View style={styles.naglowek}>
        <Ionicons name="ban-outline" size={18} color={motyw.accent} />
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('nieJemy.naglowek')}
        </ThemedText>
      </View>
      <ThemedText type="small" themeColor="textSecondary">
        {t('nieJemy.opis')}
      </ThemedText>

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      {wykluczone.length === 0 ? (
        <ThemedText type="small">{t('nieJemy.pusto')}</ThemedText>
      ) : (
        <View style={styles.pigulki}>
          {wykluczone.map((w) => (
            <Pressable
              key={w.skladnik_id}
              onPress={() => przelacz(w.skladnik_id, w.nazwa)}
              accessibilityRole="button"
              accessibilityLabel={t('nieJemy.usunZWykluczonych', { nazwa: w.nazwa })}
              style={({ pressed }) => [
                styles.pigulka,
                { backgroundColor: motyw.backgroundSelected },
                pressed && styles.wcisniety,
              ]}>
              <ThemedText type="small">{w.nazwa}</ThemedText>
              <Ionicons name="close" size={14} color={motyw.textSecondary} />
            </Pressable>
          ))}
        </View>
      )}

      {wybieranie ? (
        <>
          {skladniki ? (
            <TabelaWyboru
              dane={skladniki}
              klucz={(s) => s.id}
              tekstDoFiltra={(s) => `${s.nazwa} ${s.tagi.join(' ')}`}
              etykietaFiltra={t('nieJemy.szukaj')}
              placeholderFiltra={t('nieJemy.przyklad')}
              wybrane={wykluczone.map((w) => w.skladnik_id)}
              onPrzelacz={(s) => przelacz(s.id, s.nazwa)}
              kolumny={[{ tytul: t('wspolne.nazwa'), elastyczna: true, wartosc: (s) => s.nazwa }]}
            />
          ) : (
            <ThemedText type="small" themeColor="textSecondary">
              {t('nieJemy.wczytywanie')}
            </ThemedText>
          )}
          <Przycisk tytul={t('wspolne.gotowe')} wariant="poboczny" onPress={() => setWybieranie(false)} />
        </>
      ) : (
        <Przycisk
          tytul={t('nieJemy.dodaj')}
          ikona="add-circle-outline"
          wariant="poboczny"
          onPress={otworzWybor}
        />
      )}
    </Karta>
  );
}

const styles = StyleSheet.create({
  naglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  pigulki: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
  },
  pigulka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.half,
    paddingHorizontal: Spacing.two,
    paddingVertical: Spacing.half,
    borderRadius: Spacing.three,
  },
  wcisniety: { opacity: 0.7 },
});
