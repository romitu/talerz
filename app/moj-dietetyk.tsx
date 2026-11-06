import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { komunikatBledu } from '@/lib/blad';
import {
  pobierzMoichDietetykow,
  podpisDietetyka,
  polaczZDietetykiem,
  zakonczWspolprace,
  type MojDietetyk,
} from '@/lib/dietetyk';
import { data } from '@/lib/jezyk';
import { wroc } from '@/lib/nawigacja';
import { supabase } from '@/lib/supabase';

/**
 * Mój dietetyk — strona KLIENTA.
 *
 * Zgoda jest per profil: konto może mieć kilka osób, a dietetyk jednej z nich
 * nie ma czego szukać w danych pozostałych. Klient wpisuje kod dietetyka
 * przy wybranej osobie i w każdej chwili może dostęp odwołać — baza odbiera
 * go natychmiast (migracja 0050).
 */

type ProfilKrotko = { id: string; imie: string };

export default function EkranMojegoDietetyka() {
  const { t } = useTranslation();
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const [profile, setProfile] = useState<ProfilKrotko[]>([]);
  const [dietetycy, setDietetycy] = useState<MojDietetyk[]>([]);
  const [kody, setKody] = useState<Record<string, string>>({});
  const [pytanie, setPytanie] = useState<string | null>(null);
  const [zajety, setZajety] = useState<string | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const [wynikProfili, lista] = await Promise.all([
        supabase.from('profile').select('id, imie').order('kolejnosc'),
        pobierzMoichDietetykow(),
      ]);
      if (wynikProfili.error) throw wynikProfili.error;
      setProfile((wynikProfili.data ?? []) as ProfilKrotko[]);
      setDietetycy(lista);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, []);

  useFocusEffect(
    useCallback(() => {
      setKomunikat(null);
      pobierz();
    }, [pobierz])
  );

  async function polacz(profil: ProfilKrotko) {
    const kod = (kody[profil.id] ?? '').trim();
    if (kod.length !== 6) {
      setBlad(t('mojDietetyk.zlyKod'));
      return;
    }
    setBlad(null);
    setKomunikat(null);
    setZajety(profil.id);
    try {
      const nazwa = await polaczZDietetykiem(kod, profil.id);
      setKody((k) => ({ ...k, [profil.id]: '' }));
      setKomunikat(t('mojDietetyk.polaczono', { imie: profil.imie, nazwa }));
      await pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(null);
    }
  }

  async function odwolaj(profil: ProfilKrotko) {
    setBlad(null);
    setKomunikat(null);
    setZajety(profil.id);
    try {
      await zakonczWspolprace(profil.id);
      setPytanie(null);
      setKomunikat(t('mojDietetyk.odwolano', { imie: profil.imie }));
      await pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(null);
    }
  }

  return (
    <Ekran tytul={t('mojDietetyk.tytul')} podtytul={t('mojDietetyk.podtytul')}>
      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          {t('mojDietetyk.jakToDziala')}
        </ThemedText>
      </Karta>

      {wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('wspolne.wczytywanie')}
        </ThemedText>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      {komunikat && (
        <Karta>
          <ThemedText type="smallBold">{komunikat}</ThemedText>
        </Karta>
      )}

      {!wczytywanie && profile.length === 0 && (
        <Karta>
          <ThemedText type="default">{t('mojDietetyk.brakProfili')}</ThemedText>
        </Karta>
      )}

      {profile.map((p) => {
        const dietetyk = dietetycy.find((d) => d.profil_id === p.id);
        return (
          <Karta key={p.id} style={styles.karta}>
            <ThemedText type="subtitle">{p.imie}</ThemedText>

            {dietetyk ? (
              <>
                <View style={styles.wiersz}>
                  <ThemedText type="smallBold">{podpisDietetyka(dietetyk)}</ThemedText>
                  <ThemedText type="small" themeColor="textSecondary">
                    {t('mojDietetyk.od', { data: data(dietetyk.od) })}
                  </ThemedText>
                </View>
                <ThemedText type="small" themeColor="textSecondary">
                  {t('mojDietetyk.coWidzi')}
                </ThemedText>
                {pytanie === p.id ? (
                  <>
                    <ThemedText type="small" themeColor="accent">
                      {t('mojDietetyk.odwolajPytanie', { nazwa: podpisDietetyka(dietetyk), imie: p.imie })}
                    </ThemedText>
                    <Przycisk
                      tytul={t('mojDietetyk.takOdwolaj')}
                      onPress={() => odwolaj(p)}
                      zajety={zajety === p.id}
                    />
                    <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={() => setPytanie(null)} />
                  </>
                ) : (
                  <Przycisk
                    tytul={t('mojDietetyk.odwolaj')}
                    ikona="close-circle-outline"
                    wariant="poboczny"
                    onPress={() => setPytanie(p.id)}
                  />
                )}
              </>
            ) : (
              <>
                <ThemedText type="small" themeColor="textSecondary">
                  {t('mojDietetyk.brakDietetyka')}
                </ThemedText>
                <Pole
                  etykieta={t('mojDietetyk.kod')}
                  value={kody[p.id] ?? ''}
                  onChangeText={(tekst) =>
                    setKody((k) => ({ ...k, [p.id]: tekst.toUpperCase().replace(/[^A-Z0-9]/g, '').slice(0, 6) }))
                  }
                  placeholder="K7M2QX"
                  autoCapitalize="characters"
                  autoCorrect={false}
                />
                <Przycisk
                  tytul={t('mojDietetyk.polacz')}
                  ikona="link-outline"
                  onPress={() => polacz(p)}
                  zajety={zajety === p.id}
                  wylaczony={(kody[p.id] ?? '').length !== 6}
                />
              </>
            )}
          </Karta>
        );
      })}

      <Przycisk tytul={t('wspolne.wroc')} wariant="poboczny" onPress={() => wroc(powrot, '/profil')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  karta: { gap: Spacing.three },
  wiersz: { gap: 2 },
});
