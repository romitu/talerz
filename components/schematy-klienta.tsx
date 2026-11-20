import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import {
  cofnijUdostepnienie,
  pobierzSchematy,
  pobierzSchematyKlienta,
  udostepnijSchemat,
  type Schemat,
  type SchematKlienta,
} from '@/lib/schematy';
import { useSesja } from '@/lib/sesja';

/**
 * Karta w panelu dietetyka: schematy udostępnione temu klientowi i własne
 * schematy dietetyka do udostępnienia (migracja 0056).
 *
 * Dietetyk niczego nie wstawia klientowi do planu — udostępnia propozycję,
 * a klient sam decyduje, kiedy ją zastosować (zakładka Plan).
 */
export function SchematyKlienta({ profilId }: { profilId: string }) {
  const { t } = useTranslation();
  const motyw = useTheme();
  const { sesja } = useSesja();
  const kontoId = sesja?.user.id;

  const [udostepnione, setUdostepnione] = useState<SchematKlienta[] | null>(null);
  const [wlasne, setWlasne] = useState<Schemat[]>([]);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  const [zajety, setZajety] = useState(false);
  // Własny błąd zamiast zgłaszania wyżej: funkcja z rodzica zmieniałaby się
  // przy każdym renderze i wczytywanie kręciłoby się w kółko.
  const [blad, setBlad] = useState<string | null>(null);

  const wczytaj = useCallback(async () => {
    if (!kontoId) return;
    try {
      const [u, w] = await Promise.all([pobierzSchematyKlienta(profilId), pobierzSchematy(kontoId)]);
      setUdostepnione(u);
      setWlasne(w);
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }, [kontoId, profilId]);

  useEffect(() => {
    wczytaj();
  }, [wczytaj]);

  async function udostepnij(s: Schemat) {
    setZajety(true);
    setKomunikat(null);
    setBlad(null);
    try {
      const niewidoczne = await udostepnijSchemat(s.id, profilId);
      await wczytaj();
      setKomunikat(
        t('schematy.udostepniono', { nazwa: s.nazwa }) +
          (niewidoczne > 0 ? ` ${t('schematy.prywatneDlaKlienta', { count: niewidoczne })}` : '')
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  async function cofnij(s: SchematKlienta) {
    setZajety(true);
    setKomunikat(null);
    setBlad(null);
    try {
      await cofnijUdostepnienie(s.schemat_id, profilId);
      await wczytaj();
      setKomunikat(t('schematy.cofnieto', { nazwa: s.nazwa }));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  const juzUdostepnione = new Set((udostepnione ?? []).map((s) => s.schemat_id));
  const doUdostepnienia = wlasne.filter((s) => !juzUdostepnione.has(s.id));

  return (
    <Karta style={styles.odstep}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {t('schematy.dlaKlienta')}
      </ThemedText>
      <ThemedText type="small" themeColor="textSecondary">
        {t('schematy.dlaKlientaOpis')}
      </ThemedText>

      {udostepnione === null ? (
        <ActivityIndicator color={motyw.accent} />
      ) : (
        <>
          {udostepnione.length === 0 ? (
            <ThemedText type="small">{t('schematy.brakUdostepnionych')}</ThemedText>
          ) : (
            udostepnione.map((s) => (
              <View key={s.schemat_id} style={[styles.wiersz, { borderColor: motyw.border }]}>
                <View style={styles.tresc}>
                  <ThemedText type="smallBold">{s.nazwa}</ThemedText>
                  <ThemedText type="small" themeColor="textSecondary">
                    {t('plan.dni', { count: s.dni })}
                  </ThemedText>
                </View>
                <Przycisk tytul={t('schematy.cofnij')} wariant="poboczny" onPress={() => cofnij(s)} wylaczony={zajety} />
              </View>
            ))
          )}

          <ThemedText type="small" themeColor="textSecondary">
            {wlasne.length === 0 ? t('schematy.brakWlasnych') : t('schematy.mojeDoUdostepnienia')}
          </ThemedText>
          {doUdostepnienia.map((s) => (
            <View key={s.id} style={[styles.wiersz, { borderColor: motyw.border }]}>
              <View style={styles.tresc}>
                <ThemedText type="smallBold">{s.nazwa}</ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  {t('plan.dni', { count: s.dni })} · {t('plan.dania', { count: s.liczbaDan })}
                </ThemedText>
              </View>
              <Przycisk
                tytul={t('schematy.udostepnij')}
                ikona="share-outline"
                onPress={() => udostepnij(s)}
                wylaczony={zajety}
              />
            </View>
          ))}
        </>
      )}

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      {komunikat && (
        <ThemedText type="small" themeColor="textSecondary">
          {komunikat}
        </ThemedText>
      )}
    </Karta>
  );
}

const styles = StyleSheet.create({
  odstep: {
    gap: Spacing.two,
  },
  wiersz: {
    borderTopWidth: StyleSheet.hairlineWidth,
    paddingTop: Spacing.two,
    flexDirection: 'row',
    flexWrap: 'wrap',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  tresc: {
    flexGrow: 1,
    flexShrink: 1,
    gap: Spacing.half,
  },
});
