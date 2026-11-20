import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, StyleSheet, View } from 'react-native';

import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { opisDnia, type Plan, type PozycjaPlanu } from '@/lib/plan';
import { NazwaSchematuZajeta, pobierzSchematy, usunSchemat, zapiszSchemat, type Schemat } from '@/lib/schematy';
import { schematZPlanu } from '@/lib/schematy-uklad';

type Props = {
  kontoId: string;
  plan: Plan;
  pozycje: PozycjaPlanu[];
  /** Inna operacja na planie w toku — przyciski czekają. */
  pracuje: boolean;
  /** Przenosi schemat na bieżący tydzień (logika w `app/index.tsx`). */
  onZastosuj: (schemat: Schemat) => Promise<void>;
  onKomunikat: (tekst: string | null) => void;
  onBlad: (tekst: string | null) => void;
};

/**
 * Schematy tygodnia na karcie „Układanie tygodnia”: zapis bieżącego tygodnia
 * jako schematu i zastosowanie zapisanego schematu do bieżącego tygodnia.
 *
 * Wszystko w karcie, bez okienek systemowych — z tego samego powodu co
 * potwierdzenie „Wyczyść wszystko”.
 */
export function SchematyPlanu({ kontoId, plan, pozycje, pracuje, onZastosuj, onKomunikat, onBlad }: Props) {
  const { t } = useTranslation();
  const motyw = useTheme();

  const [tryb, setTryb] = useState<'zapis' | 'lista' | null>(null);
  const [nazwa, setNazwa] = useState('');
  const [schematy, setSchematy] = useState<Schemat[] | null>(null);
  const [doUsuniecia, setDoUsuniecia] = useState<Schemat | null>(null);
  const [zajety, setZajety] = useState(false);

  const blokada = pracuje || zajety;

  async function wczytaj() {
    try {
      setSchematy(await pobierzSchematy());
    } catch (e) {
      onBlad(komunikatBledu(e));
    }
  }

  function otworzZapis() {
    onKomunikat(null);
    setNazwa(t('schematy.domyslnaNazwa', { data: opisDnia(plan.data_start) }));
    setTryb(tryb === 'zapis' ? null : 'zapis');
  }

  function otworzListe() {
    onKomunikat(null);
    setDoUsuniecia(null);
    if (tryb === 'lista') {
      setTryb(null);
      return;
    }
    setTryb('lista');
    setSchematy(null);
    wczytaj();
  }

  async function zapisz() {
    if (!nazwa.trim()) {
      onKomunikat(t('schematy.podajNazwe'));
      return;
    }
    setZajety(true);
    onBlad(null);
    try {
      const zapisany = await zapiszSchemat({
        kontoId,
        nazwa,
        dni: plan.dni,
        pozycje: schematZPlanu(pozycje, plan.data_start, plan.dni),
      });
      setTryb(null);
      onKomunikat(
        t('schematy.zapisano', { nazwa: zapisany.nazwa, dania: t('plan.dania', { count: zapisany.liczbaDan }) })
      );
    } catch (e) {
      if (e instanceof NazwaSchematuZajeta) onKomunikat(t('schematy.nazwaZajeta', { nazwa: nazwa.trim() }));
      else onBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  async function zastosuj(s: Schemat) {
    setTryb(null);
    await onZastosuj(s);
  }

  async function usun(s: Schemat) {
    setZajety(true);
    onBlad(null);
    try {
      await usunSchemat(s.id);
      setDoUsuniecia(null);
      onKomunikat(t('schematy.usunieto', { nazwa: s.nazwa }));
      await wczytaj();
    } catch (e) {
      onBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  return (
    <View style={styles.grupa}>
      <View style={styles.siatka}>
        <Przycisk
          tytul={t('schematy.zapiszTydzien')}
          wariant="poboczny"
          ikona="bookmark-outline"
          onPress={otworzZapis}
          wylaczony={pozycje.length === 0 || blokada}
          style={styles.kafelek}
        />
        <Przycisk
          tytul={t('schematy.zastosuj')}
          wariant="poboczny"
          ikona="copy-outline"
          onPress={otworzListe}
          wylaczony={blokada}
          style={styles.kafelek}
        />
      </View>

      {tryb === 'zapis' && (
        <View style={styles.panel}>
          <Pole
            etykieta={t('schematy.nazwa')}
            value={nazwa}
            onChangeText={setNazwa}
            maxLength={80}
            onSubmitEditing={zapisz}
          />
          <ThemedText type="small" themeColor="textSecondary">
            {t('schematy.zapisOpis')}
          </ThemedText>
          <Przycisk tytul={t('schematy.zapisz')} onPress={zapisz} zajety={zajety} wylaczony={blokada} />
          <Przycisk tytul={t('uzytkownicy.zostaw')} wariant="poboczny" onPress={() => setTryb(null)} />
        </View>
      )}

      {tryb === 'lista' && (
        <View style={styles.panel}>
          {schematy === null ? (
            <ActivityIndicator color={motyw.accent} />
          ) : schematy.length === 0 ? (
            <ThemedText type="small" themeColor="textSecondary">
              {t('schematy.brak')}
            </ThemedText>
          ) : (
            schematy.map((s) => (
              <View key={s.id} style={[styles.wiersz, { borderColor: motyw.border }]}>
                <View style={styles.wierszTresc}>
                  <ThemedText type="smallBold">{s.nazwa}</ThemedText>
                  <ThemedText type="small" themeColor="textSecondary">
                    {t('plan.dni', { count: s.dni })} · {t('plan.dania', { count: s.liczbaDan })}
                  </ThemedText>
                </View>

                {doUsuniecia?.id === s.id ? (
                  <View style={styles.potwierdzenie}>
                    <ThemedText type="small" themeColor="accent">
                      {t('schematy.usunPytanie', { nazwa: s.nazwa })}
                    </ThemedText>
                    <Przycisk tytul={t('schematy.takUsun')} onPress={() => usun(s)} zajety={zajety} />
                    <Przycisk
                      tytul={t('uzytkownicy.zostaw')}
                      wariant="poboczny"
                      onPress={() => setDoUsuniecia(null)}
                    />
                  </View>
                ) : (
                  <View style={styles.wierszAkcje}>
                    <Przycisk
                      tytul={t('schematy.zastosujTen')}
                      onPress={() => zastosuj(s)}
                      wylaczony={blokada}
                    />
                    <Pressable
                      onPress={() => setDoUsuniecia(s)}
                      disabled={blokada}
                      accessibilityRole="button"
                      accessibilityLabel={t('schematy.usun', { nazwa: s.nazwa })}
                      hitSlop={8}
                      style={({ pressed }) => [styles.kosz, pressed && styles.wcisniete]}>
                      <Ionicons name="trash-outline" size={22} color={motyw.textSecondary} />
                    </Pressable>
                  </View>
                )}
              </View>
            ))
          )}
          <Przycisk
            tytul={t('schematy.zarzadzaj')}
            wariant="poboczny"
            ikona="create-outline"
            onPress={() => router.push('/schematy')}
          />
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  grupa: {
    gap: Spacing.two,
  },
  siatka: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  kafelek: {
    flexGrow: 1,
    flexBasis: '46%',
  },
  panel: {
    gap: Spacing.two,
  },
  wiersz: {
    borderTopWidth: StyleSheet.hairlineWidth,
    paddingTop: Spacing.two,
    gap: Spacing.two,
  },
  wierszTresc: {
    gap: Spacing.half,
  },
  wierszAkcje: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  potwierdzenie: {
    gap: Spacing.two,
  },
  kosz: {
    padding: Spacing.one,
  },
  wcisniete: {
    opacity: 0.6,
  },
});
