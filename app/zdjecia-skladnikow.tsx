import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { SiatkaKafli, ZnaczekZrodla } from '@/components/kafel-zakupu';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import type { ZrodloZdjecia } from '@/lib/zakupy';
import {
  adresZdjeciaSkladnika,
  BOK_ZDJECIA_SKLADNIKA,
  mozliwyWyborZdjecia,
  pobierzZdjeciaSkladnikow,
  usunPlikZdjeciaSkladnika,
  wybierzZdjecie,
  wyslijZdjecieSkladnika,
  zapiszZdjecieSkladnika,
  type ZdjecieSkladnika,
} from '@/lib/zdjecia';

/**
 * Zdjęcia składników — edytor grafik z listy zakupów.
 *
 * Hurtowe wgranie robi narzedzia/wgraj-zdjecia-skladnikow.mjs; ten ekran
 * służy do pojedynczych poprawek: wymiany zdjęcia, zmiany oznaczenia
 * „AI / własne” i usunięcia.
 *
 * Tylko moderator i administrator — zasobnik i kolumny zdjęcia chronią reguły
 * w bazie (migracja 0045). Sprawdzenie roli tutaj jest po to, żeby zamiast
 * błędu przy zapisie pokazać od razu, dlaczego nie da się nic zmienić.
 *
 * Zdjęcia wybiera się z przeglądarki (jak zdjęcia przepisów, patrz
 * lib/zdjecia.ts). Na telefonie da się zmienić oznaczenie i usunąć zdjęcie.
 */

type Filtr = 'wszystkie' | 'bez' | 'ai' | 'wlasne';

/** Nazwy filtrów są w tłumaczeniach: `zdjeciaSkladnikow.filtr.<klucz>`. */
const FILTRY: { klucz: Filtr }[] = [{ klucz: 'wszystkie' }, { klucz: 'bez' }, { klucz: 'ai' }, { klucz: 'wlasne' }];

function pasuje(s: ZdjecieSkladnika, filtr: Filtr): boolean {
  if (filtr === 'bez') return !s.zdjecie;
  if (filtr === 'ai' || filtr === 'wlasne') return !!s.zdjecie && s.zdjecie_zrodlo === filtr;
  return true;
}

/**
 * Ile kafli na stronę. Strony, a nie „pokaż więcej”: doklejanie kolejnych
 * porcji w końcu i tak wyświetliłoby wszystko naraz — przy 281 zdjęciach to
 * ok. 20 MB, a składników będzie przybywać. Na ekranie jest najwyżej 60.
 */
const NA_STRONE = 60;

export default function EkranZdjecSkladnikow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();
  const motyw = useTheme();
  const { t } = useTranslation();
  const przewijanie = useRef<ScrollView>(null);

  const [skladniki, setSkladniki] = useState<ZdjecieSkladnika[]>([]);
  const [szukaj, setSzukaj] = useState('');
  const [filtr, setFiltr] = useState<Filtr>('wszystkie');
  const [strona, setStrona] = useState(0);
  /** Pozycja siatki na ekranie — zmiana strony przewija do jej początku. */
  const [gornaSiatki, setGornaSiatki] = useState(0);
  const [wybranyId, setWybranyId] = useState<string | null>(null);
  const [pracuje, setPracuje] = useState(false);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  /** `null` dopóki rola się nie wczyta — wtedy NIE pokazujemy jeszcze odmowy. */
  const [rola, setRola] = useState<string | null>(null);
  const kontoId = sesja?.user.id;
  const jestModeratorem = rola === 'moderator' || rola === 'administrator';
  const moznaWybrac = mozliwyWyborZdjecia();

  useEffect(() => {
    if (!kontoId) return;
    supabase
      .from('konta')
      .select('rola')
      .eq('id', kontoId)
      .single()
      .then(({ data }) => setRola(data?.rola ?? 'uzytkownik'));
  }, [kontoId]);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      setSkladniki(await pobierzZdjeciaSkladnikow());
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, []);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  const liczby = useMemo(() => {
    const wynik: Record<Filtr, number> = { wszystkie: 0, bez: 0, ai: 0, wlasne: 0 };
    for (const s of skladniki) for (const f of FILTRY) if (pasuje(s, f.klucz)) wynik[f.klucz]++;
    return wynik;
  }, [skladniki]);

  const widoczne = useMemo(() => {
    const fraza = szukaj.trim().toLowerCase();
    return skladniki.filter(
      (s) => pasuje(s, filtr) && (!fraza || s.nazwa.toLowerCase().includes(fraza))
    );
  }, [skladniki, szukaj, filtr]);

  // Nowe wyszukiwanie albo filtr zaczyna od pierwszej strony.
  useEffect(() => setStrona(0), [szukaj, filtr]);

  const liczbaStron = Math.max(1, Math.ceil(widoczne.length / NA_STRONE));
  const biezaca = Math.min(strona, liczbaStron - 1);
  const naStronie = widoczne.slice(biezaca * NA_STRONE, (biezaca + 1) * NA_STRONE);

  function idzDoStrony(nowa: number) {
    setStrona(nowa);
    przewijanie.current?.scrollTo({ y: gornaSiatki, animated: false });
  }

  const stronicowanie =
    liczbaStron > 1 ? (
      <View style={styles.strony}>
        <Przycisk
          tytul={t('zdjeciaSkladnikow.poprzednia')}
          ikona="chevron-back"
          wariant="poboczny"
          onPress={() => idzDoStrony(biezaca - 1)}
          wylaczony={biezaca === 0}
          style={styles.przyciskStrony}
        />
        <ThemedText type="small" themeColor="textSecondary" style={styles.numerStrony}>
          {biezaca + 1} / {liczbaStron}
        </ThemedText>
        <Przycisk
          tytul={t('zdjeciaSkladnikow.nastepna')}
          ikona="chevron-forward"
          wariant="poboczny"
          onPress={() => idzDoStrony(biezaca + 1)}
          wylaczony={biezaca >= liczbaStron - 1}
          style={styles.przyciskStrony}
        />
      </View>
    ) : null;

  const wybrany = skladniki.find((s) => s.id === wybranyId) ?? null;

  function zmienLokalnie(id: string, zmiana: Partial<ZdjecieSkladnika>) {
    setSkladniki((lista) => lista.map((s) => (s.id === id ? { ...s, ...zmiana } : s)));
  }

  function otworz(id: string) {
    setBlad(null);
    setWybranyId(id);
    przewijanie.current?.scrollTo({ y: 0, animated: true });
  }

  /**
   * Nowe zdjęcie: najpierw plik, potem wiersz w bazie, na końcu kasujemy
   * stary plik. W tej kolejności przerwanie w połowie zostawia najwyżej
   * osierocony plik w zasobniku — nigdy składnik wskazujący na nieistniejący.
   *
   * Świeżo wgrane zdjęcie dostaje oznaczenie „własne” — to najczęstszy
   * przypadek przy pojedynczej wymianie. Przełącznik niżej zmienia je jednym
   * dotknięciem, gdyby to była grafika AI.
   */
  async function wymien(s: ZdjecieSkladnika) {
    setBlad(null);
    setPracuje(true);
    try {
      const wybrane = await wybierzZdjecie(BOK_ZDJECIA_SKLADNIKA);
      if (!wybrane) return;
      const sciezka = await wyslijZdjecieSkladnika(s.id, wybrane.dane);
      await zapiszZdjecieSkladnika(s.id, sciezka, 'wlasne');
      zmienLokalnie(s.id, { zdjecie: sciezka, zdjecie_zrodlo: 'wlasne' });
      if (s.zdjecie) usunPlikZdjeciaSkladnika(s.zdjecie);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  async function ustawZrodlo(s: ZdjecieSkladnika, zrodlo: ZrodloZdjecia) {
    if (!s.zdjecie || s.zdjecie_zrodlo === zrodlo) return;
    setBlad(null);
    const poprzednie = s.zdjecie_zrodlo;
    zmienLokalnie(s.id, { zdjecie_zrodlo: zrodlo });
    try {
      await zapiszZdjecieSkladnika(s.id, s.zdjecie, zrodlo);
    } catch (e) {
      zmienLokalnie(s.id, { zdjecie_zrodlo: poprzednie });
      setBlad(komunikatBledu(e));
    }
  }

  async function usun(s: ZdjecieSkladnika) {
    if (!s.zdjecie) return;
    setBlad(null);
    setPracuje(true);
    try {
      await zapiszZdjecieSkladnika(s.id, null, null);
      zmienLokalnie(s.id, { zdjecie: null, zdjecie_zrodlo: null });
      usunPlikZdjeciaSkladnika(s.zdjecie);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  if (rola !== null && !jestModeratorem) {
    return (
      <Ekran tytul={t('menu.zdjeciaSkladnikow')}>
        <Karta>
          <ThemedText type="default">{t('wspolne.tylkoModerator')}</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {t('zdjeciaSkladnikow.tylkoModeratorOpis')}
          </ThemedText>
        </Karta>
        <Przycisk tytul={t('wspolne.wroc')} wariant="poboczny" onPress={() => wroc(powrot, '/skladniki')} />
      </Ekran>
    );
  }

  const adresWybranego = adresZdjeciaSkladnika(wybrany?.zdjecie);

  return (
    <Ekran
      tytul={t('menu.zdjeciaSkladnikow')}
      podtytul={t('zdjeciaSkladnikow.podtytul')}
      refPrzewijania={przewijanie}>
      {wybrany && (
        <Karta>
          <View style={styles.naglowekPanelu}>
            <ThemedText type="subtitle" style={styles.nazwa}>
              {wybrany.nazwa}
            </ThemedText>
            <Pressable
              onPress={() => setWybranyId(null)}
              hitSlop={10}
              accessibilityRole="button"
              accessibilityLabel={t('zdjeciaSkladnikow.zamknij')}>
              <Ionicons name="close" size={22} color={motyw.textSecondary} />
            </Pressable>
          </View>

          <View style={[styles.podglad, { borderColor: motyw.border }]}>
            {adresWybranego ? (
              <Image source={{ uri: adresWybranego }} style={StyleSheet.absoluteFill} contentFit="cover" />
            ) : (
              <View style={styles.brak}>
                <Ionicons name="image-outline" size={40} color="#8a96a3" />
                <ThemedText style={styles.brakTekst}>{t('wspolne.brakZdjecia')}</ThemedText>
              </View>
            )}
            {pracuje && (
              <View style={styles.zaslona}>
                <ActivityIndicator color="#ffffff" />
              </View>
            )}
          </View>

          {wybrany.zdjecie && (
            <View style={styles.grupa}>
              <ThemedText type="smallBold" themeColor="textSecondary">
                {t('zdjeciePrzepisu.pochodzenie')}
              </ThemedText>
              <View style={styles.przelacznik}>
                {(['ai', 'wlasne'] as const).map((z) => {
                  const aktywny = wybrany.zdjecie_zrodlo === z;
                  return (
                    <Pressable
                      key={z}
                      onPress={() => ustawZrodlo(wybrany, z)}
                      accessibilityRole="radio"
                      accessibilityState={{ selected: aktywny }}
                      style={[
                        styles.opcja,
                        {
                          borderColor: aktywny ? motyw.accent : motyw.border,
                          backgroundColor: aktywny ? motyw.backgroundSelected : 'transparent',
                        },
                      ]}>
                      <ThemedText type="smallBold" themeColor={aktywny ? 'accent' : undefined}>
                        {t(`zrodloZdjecia.${z}.tytul`)}
                      </ThemedText>
                      <ThemedText type="small" themeColor="textSecondary">
                        {t(`zrodloZdjecia.${z}.opis`)}
                      </ThemedText>
                    </Pressable>
                  );
                })}
              </View>
            </View>
          )}

          <View style={styles.przyciski}>
            {moznaWybrac && (
              <View style={styles.przycisk}>
                <Przycisk
                  tytul={wybrany.zdjecie ? t('zdjeciePrzepisu.wymien') : t('zdjeciePrzepisu.dodaj')}
                  ikona="image-outline"
                  onPress={() => wymien(wybrany)}
                  zajety={pracuje}
                />
              </View>
            )}
            {wybrany.zdjecie && (
              <View style={styles.przycisk}>
                <Przycisk
                  tytul={t('zdjeciePrzepisu.usun')}
                  ikona="trash-outline"
                  wariant="poboczny"
                  onPress={() => usun(wybrany)}
                  wylaczony={pracuje}
                />
              </View>
            )}
          </View>

          <ThemedText type="small" themeColor="textSecondary">
            {moznaWybrac
              ? t('zdjeciaSkladnikow.wskazowka', { bok: BOK_ZDJECIA_SKLADNIKA })
              : t('zdjeciaSkladnikow.tylkoPrzegladarka')}
          </ThemedText>
        </Karta>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      <Karta>
        <Pole
          etykieta={t('nieJemy.szukaj')}
          value={szukaj}
          onChangeText={setSzukaj}
          placeholder={t('zdjeciaSkladnikow.przyklad')}
          autoCorrect={false}
        />
        <View style={styles.filtry}>
          {FILTRY.map((f) => {
            const aktywny = filtr === f.klucz;
            return (
              <Pressable
                key={f.klucz}
                onPress={() => setFiltr(f.klucz)}
                accessibilityRole="radio"
                accessibilityState={{ selected: aktywny }}
                style={[
                  styles.filtr,
                  {
                    borderColor: aktywny ? motyw.accent : motyw.border,
                    backgroundColor: aktywny ? motyw.backgroundSelected : 'transparent',
                  },
                ]}>
                <ThemedText type="small" themeColor={aktywny ? 'accent' : undefined}>
                  {t(`zdjeciaSkladnikow.filtr.${f.klucz}`)} ({liczby[f.klucz]})
                </ThemedText>
              </Pressable>
            );
          })}
        </View>
      </Karta>

      {wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('naglowekProfilu.wczytywanie')}
        </ThemedText>
      )}

      {!wczytywanie && widoczne.length === 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('zdjeciaSkladnikow.brakWynikow')}
        </ThemedText>
      )}

      <View onLayout={(e) => setGornaSiatki(e.nativeEvent.layout.y)}>{stronicowanie}</View>

      <SiatkaKafli>
        {naStronie.map((s) => {
          const adres = adresZdjeciaSkladnika(s.zdjecie);
          const aktywny = s.id === wybranyId;
          return (
            <Pressable
              key={s.id}
              onPress={() => otworz(s.id)}
              accessibilityRole="button"
              accessibilityLabel={t('zdjeciaSkladnikow.edytujZdjecie', { nazwa: s.nazwa })}
              style={({ pressed }) => [
                styles.kafel,
                {
                  backgroundColor: motyw.backgroundSelected,
                  borderColor: aktywny ? motyw.accent : 'transparent',
                },
                pressed && styles.wcisniety,
              ]}>
              <View style={styles.zdjecie}>
                {adres ? (
                  <Image
                    source={{ uri: adres }}
                    style={StyleSheet.absoluteFill}
                    contentFit="cover"
                    transition={150}
                  />
                ) : (
                  <View style={styles.brak}>
                    <Ionicons name="image-outline" size={26} color="#8a96a3" />
                    <ThemedText style={styles.brakTekst}>{t('wspolne.brakZdjecia')}</ThemedText>
                  </View>
                )}
                {s.zdjecie && s.zdjecie_zrodlo && <ZnaczekZrodla zrodlo={s.zdjecie_zrodlo} staly />}
              </View>
              <ThemedText type="small" style={styles.podpis} numberOfLines={3}>
                {s.nazwa}
              </ThemedText>
            </Pressable>
          );
        })}
      </SiatkaKafli>

      {stronicowanie}

      <Przycisk tytul={t('wspolne.wroc')} wariant="poboczny" onPress={() => wroc(powrot, '/skladniki')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  naglowekPanelu: { flexDirection: 'row', alignItems: 'flex-start', gap: Spacing.two },
  nazwa: { flex: 1 },
  podglad: {
    width: '100%',
    maxWidth: 320,
    aspectRatio: 1,
    alignSelf: 'center',
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
    backgroundColor: '#ffffff',
  },
  zaslona: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(0,0,0,0.35)',
  },
  grupa: { gap: Spacing.one },
  przelacznik: { flexDirection: 'row', gap: Spacing.two },
  opcja: { flex: 1, borderWidth: 1, borderRadius: Spacing.two, padding: Spacing.two, gap: 2 },
  przyciski: { flexDirection: 'row', flexWrap: 'wrap', gap: Spacing.two },
  przycisk: { flexGrow: 1, flexBasis: 140 },
  filtry: { flexDirection: 'row', flexWrap: 'wrap', gap: Spacing.one },
  filtr: {
    borderWidth: 1,
    borderRadius: 999,
    paddingHorizontal: Spacing.two,
    paddingVertical: Spacing.one,
  },
  kafel: { flex: 1, borderRadius: Spacing.two, borderWidth: 2, overflow: 'hidden' },
  wcisniety: { opacity: 0.8 },
  zdjecie: { aspectRatio: 1, backgroundColor: '#ffffff' },
  brak: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    gap: 4,
    backgroundColor: '#eef1f5',
  },
  brakTekst: { fontSize: 11, lineHeight: 14, color: '#8a96a3' },
  podpis: { paddingHorizontal: Spacing.two, paddingVertical: 6 },
  strony: { flexDirection: 'row', alignItems: 'center', gap: Spacing.two },
  przyciskStrony: { flex: 1 },
  numerStrony: { minWidth: 48, textAlign: 'center' },
});
