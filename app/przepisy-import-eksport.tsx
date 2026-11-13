import { useLocalSearchParams } from 'expo-router';
import * as DocumentPicker from 'expo-document-picker';
import * as FileSystem from 'expo-file-system/legacy';
import * as Sharing from 'expo-sharing';
import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Platform, Pressable, Share, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import {
  sklasyfikujPrzepisy,
  zaimportujPrzepisy,
  type BladImportu,
  type PozycjaImportu,
} from '@/lib/import-przepisow';
import i18n from '@/lib/jezyk';
import { wroc } from '@/lib/nawigacja';
import {
  przepisDoJson,
  sprawdzPrzepis,
  tekstJson,
  wczytajJsonPrzepisow,
  zbudujPromptPrzepisu,
  type PrzepisJson,
} from '@/lib/przepis-json';
import { pobierzPelnyPrzepis, pobierzPrzepisy, pobierzWszystkiePelnePrzepisy } from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { pobierzSkladniki, ROLE_SKLADNIKA } from '@/lib/skladniki';
import { supabase } from '@/lib/supabase';

/**
 * Import i eksport przepisów jako JSON — przez plik albo schowek. Tu też
 * powstaje prompt, z którym dowolny czat z AI przygotuje przepis w tym samym
 * formacie.
 *
 * Format, walidacja i dopasowanie do katalogów siedzą w `lib/przepis-json.ts`,
 * zapis w `lib/import-przepisow.ts` — tu jest tylko ekran: wybór, podgląd
 * tego, co się zaimportuje, i wynik.
 *
 * Ekran nie sprawdza roli — tak samo jak `uzytkownicy.tsx`. Eksport pokaże
 * tyle przepisów, ile pozwolą zobaczyć reguły dostępu w bazie, a zapis
 * cudzego albo publicznego przepisu bez uprawnień moderatora skończy się
 * zwykłym błędem z bazy, widocznym niżej przy tym konkretnym daniu.
 */

/** Nazwa przepisu -> bezpieczny fragment nazwy pliku (bez polskich znaków, spacji, wielkości liter). */
function fragmentNazwyPliku(nazwa: string): string {
  const bezOgonkow = nazwa.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();
  return bezOgonkow.replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'przepis';
}

/** Pobranie/udostępnienie pliku tekstowego (JSON). */
async function zapiszPlik(tekst: string, nazwa: string, poZapisie: (komunikat: string) => void) {
  if (Platform.OS === 'web') {
    const url = URL.createObjectURL(new Blob([tekst], { type: 'application/json;charset=utf-8' }));
    const a = document.createElement('a');
    a.href = url;
    a.download = nazwa;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
    poZapisie(i18n.t('importEksport.pobrano', { nazwa }));
  } else {
    const uri = FileSystem.cacheDirectory + nazwa;
    await FileSystem.writeAsStringAsync(uri, tekst);
    if (await Sharing.isAvailableAsync()) {
      await Sharing.shareAsync(uri, { mimeType: 'application/json', dialogTitle: i18n.t('importEksport.zapiszPlik') });
    } else {
      poZapisie(i18n.t('importEksport.zapisany', { uri }));
    }
  }
}

/**
 * Tekst do schowka. W przeglądarce wprost; na telefonie przez systemowe
 * „Udostępnij”, które ma „Kopiuj” i od razu pozwala wysłać tekst do czatu z AI
 * — bez dokładania do aplikacji osobnego modułu schowka.
 */
async function skopiujTekst(tekst: string): Promise<'skopiowano' | 'udostepniono'> {
  if (Platform.OS === 'web') {
    await navigator.clipboard.writeText(tekst);
    return 'skopiowano';
  }
  await Share.share({ message: tekst });
  return 'udostepniono';
}

/** Czego import nie przyjmie z powrotem — do pokazania przy eksporcie, zanim ktoś liczy na kopię. */
function ostrzezeniaEksportu(przepisy: PrzepisJson[]): string | null {
  const zle = przepisy
    .map((p) => ({ nazwa: p.nazwa, bledy: sprawdzPrzepis(JSON.parse(JSON.stringify(p))) }))
    .filter((x) => x.bledy.length > 0);
  if (zle.length === 0) return null;
  return i18n.t('importEksport.ostrzezenieEksportu', {
    lista: zle.map((x) => `„${x.nazwa}” (${x.bledy.join('; ')})`).join(', '),
  });
}

export default function EkranImportEksportPrzepisow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();
  const motyw = useTheme();
  const { t } = useTranslation();

  const [eksportZajety, setEksportZajety] = useState(false);
  const [importZajety, setImportZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);

  const [listaPrzepisow, setListaPrzepisow] = useState<{ id: string; nazwa: string }[]>([]);
  const [szukajPrzepisu, setSzukajPrzepisu] = useState('');
  const [wybranyPrzepisId, setWybranyPrzepisId] = useState<string | null>(null);

  const [eksportWszystkichZajety, setEksportWszystkichZajety] = useState(false);
  const [promptZajety, setPromptZajety] = useState(false);
  const [wklejonyJson, setWklejonyJson] = useState('');

  const [nazwaPliku, setNazwaPliku] = useState<string | null>(null);
  const [bledyParsowania, setBledyParsowania] = useState<BladImportu[]>([]);
  const [pozycje, setPozycje] = useState<PozycjaImportu[] | null>(null);
  const [postep, setPostep] = useState<{ zrobione: number; razem: number } | null>(null);
  const [bledyZapisu, setBledyZapisu] = useState<BladImportu[]>([]);
  const [zaimportowano, setZaimportowano] = useState<number | null>(null);

  const kontoId = sesja?.user.id;
  const wczytajListePrzepisow = useCallback(async () => {
    try {
      const przepisy = await pobierzPrzepisy(kontoId);
      setListaPrzepisow(przepisy.map((p) => ({ id: p.id, nazwa: p.nazwa })));
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }, [kontoId]);

  useEffect(() => {
    wczytajListePrzepisow();
  }, [wczytajListePrzepisow]);

  const fraza = szukajPrzepisu.trim().toLowerCase();
  const przepisyPasujace = fraza
    ? listaPrzepisow.filter((p) => p.nazwa.toLowerCase().includes(fraza)).slice(0, 8)
    : [];
  const wybranyPrzepis = listaPrzepisow.find((p) => p.id === wybranyPrzepisId) ?? null;

  /** Jeden przepis jako JSON: do pliku albo do schowka. */
  async function eksportujJson(cel: 'plik' | 'schowek') {
    if (!wybranyPrzepisId) return;
    setBlad(null);
    setKomunikat(null);
    setEksportZajety(true);
    try {
      const [pelny, skladniki] = await Promise.all([
        pobierzPelnyPrzepis(wybranyPrzepisId),
        pobierzSkladniki(),
      ]);
      const json = przepisDoJson(pelny, skladniki);
      const ostrzezenie = ostrzezeniaEksportu([json]);
      if (cel === 'plik') {
        await zapiszPlik(
          tekstJson([json]),
          `talerz-przepis-${fragmentNazwyPliku(pelny.nazwa)}.json`,
          setKomunikat
        );
      } else if ((await skopiujTekst(tekstJson([json]))) === 'skopiowano') {
        setKomunikat(t('importEksport.skopiowanoJson', { nazwa: pelny.nazwa }));
      }
      if (ostrzezenie) setBlad(ostrzezenie);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setEksportZajety(false);
    }
  }

  /** Wszystkie przepisy widoczne temu kontu w jednym pliku — kopia zapasowa. */
  async function eksportujWszystkieJson() {
    setBlad(null);
    setKomunikat(null);
    setEksportWszystkichZajety(true);
    try {
      const [pelne, skladniki] = await Promise.all([pobierzWszystkiePelnePrzepisy(), pobierzSkladniki()]);
      const jsony = pelne.map((p) => przepisDoJson(p, skladniki));
      const dzis = new Date().toISOString().slice(0, 10);
      await zapiszPlik(tekstJson(jsony), `talerz-przepisy-${dzis}.json`, setKomunikat);
      const ostrzezenie = ostrzezeniaEksportu(jsony);
      if (ostrzezenie) setBlad(ostrzezenie);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setEksportWszystkichZajety(false);
    }
  }

  /** Prompt z aktualnymi katalogami — do wklejenia w czat z AI. */
  async function skopiujPrompt() {
    setBlad(null);
    setKomunikat(null);
    setPromptZajety(true);
    try {
      const [skladniki, sprzet] = await Promise.all([
        pobierzSkladniki(),
        supabase.from('sprzet').select('nazwa'),
      ]);
      if (sprzet.error) throw sprzet.error;
      const prompt = zbudujPromptPrzepisu(
        skladniki,
        (sprzet.data ?? []).map((x) => x.nazwa as string)
      );
      if ((await skopiujTekst(prompt)) === 'skopiowano') setKomunikat(t('importEksport.skopiowanoPrompt'));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPromptZajety(false);
    }
  }

  /** Wspólny koniec dla wklejonego tekstu i pliku: sprawdzenie z katalogami i podgląd. */
  async function pokazPodglad(tekst: string) {
    const [skladniki, sprzet, istniejacePrzepisy] = await Promise.all([
      pobierzSkladniki(),
      supabase.from('sprzet').select('nazwa'),
      supabase.from('przepisy').select('id, nazwa'),
    ]);
    if (sprzet.error) throw sprzet.error;
    if (istniejacePrzepisy.error) throw istniejacePrzepisy.error;

    const wczytane = wczytajJsonPrzepisow(tekst, {
      skladniki,
      sprzet: (sprzet.data ?? []).map((x) => x.nazwa as string),
      role: ROLE_SKLADNIKA,
    });
    setBledyParsowania(wczytane.bledy);
    setPozycje(sklasyfikujPrzepisy(wczytane.przepisy, istniejacePrzepisy.data ?? []));
  }

  async function sprawdzWklejony() {
    setBlad(null);
    setKomunikat(null);
    wyczyscImport();
    try {
      await pokazPodglad(wklejonyJson);
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  async function wybierzPlik() {
    setBlad(null);
    setKomunikat(null);
    wyczyscImport();

    try {
      const wynik = await DocumentPicker.getDocumentAsync({
        // Telefony zgłaszają .json różnie — czasem jako zwykły tekst albo „dowolny plik”.
        type: ['application/json', 'text/plain', 'application/octet-stream'],
        copyToCacheDirectory: true,
      });
      if (wynik.canceled || wynik.assets.length === 0) return;

      const zasob = wynik.assets[0];
      setNazwaPliku(zasob.name);

      const tekst =
        Platform.OS === 'web' && zasob.file
          ? await zasob.file.text()
          : await FileSystem.readAsStringAsync(zasob.uri);

      await pokazPodglad(tekst);
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  function wyczyscImport() {
    setNazwaPliku(null);
    setBledyParsowania([]);
    setPozycje(null);
    setPostep(null);
    setBledyZapisu([]);
    setZaimportowano(null);
  }

  async function potwierdzImport() {
    if (!pozycje || !sesja) return;
    setBlad(null);
    setImportZajety(true);
    setPostep({ zrobione: 0, razem: pozycje.length });

    try {
      const { bledy } = await zaimportujPrzepisy(pozycje, sesja.user.id, (zrobione, razem) =>
        setPostep({ zrobione, razem })
      );
      setZaimportowano(pozycje.length - bledy.length);
      setBledyZapisu(bledy);
      setPozycje(null);
      // Zapisany tekst nie powinien kusić do drugiego kliknięcia.
      if (bledy.length === 0) setWklejonyJson('');
      wczytajListePrzepisow();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setImportZajety(false);
    }
  }

  const doAktualizacji = pozycje?.filter((p) => p.istniejacyId !== null) ?? [];
  const doDodania = pozycje?.filter((p) => p.istniejacyId === null) ?? [];

  return (
    <Ekran
      tytul={t('importEksport.tytul')}
      podtytul={t('importEksport.podtytul')}>
      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('importEksport.eksportPrzepisu')}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.eksportPrzepisuOpis')}
        </ThemedText>

        <Pole
          etykieta={t('importEksport.znajdzPrzepis')}
          value={wybranyPrzepis ? wybranyPrzepis.nazwa : szukajPrzepisu}
          onChangeText={(tekst) => {
            setSzukajPrzepisu(tekst);
            setWybranyPrzepisId(null);
          }}
          placeholder={t('importEksport.przyklad')}
        />

        {!wybranyPrzepisId && przepisyPasujace.length > 0 && (
          <View style={[styles.listaPrzepisow, { borderColor: motyw.border }]}>
            {przepisyPasujace.map((p) => (
              <Pressable
                key={p.id}
                onPress={() => {
                  setWybranyPrzepisId(p.id);
                  setSzukajPrzepisu('');
                }}
                style={({ pressed }) => [
                  styles.pozycjaListy,
                  { borderColor: motyw.border },
                  pressed && styles.wcisnieta,
                ]}>
                <ThemedText type="small">{p.nazwa}</ThemedText>
              </Pressable>
            ))}
          </View>
        )}

        {!wybranyPrzepisId && fraza !== '' && przepisyPasujace.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            {t('importEksport.brakPrzepisu', { fraza: szukajPrzepisu })}
          </ThemedText>
        )}

        <Przycisk
          tytul={t('importEksport.pobierzJson')}
          onPress={() => eksportujJson('plik')}
          zajety={eksportZajety}
          wylaczony={!wybranyPrzepisId}
        />
        <Przycisk
          tytul={Platform.OS === 'web' ? t('importEksport.kopiujJson') : t('importEksport.udostepnijJson')}
          wariant="poboczny"
          onPress={() => eksportujJson('schowek')}
          wylaczony={!wybranyPrzepisId || eksportZajety}
        />

        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.wszystkieOpis')}
        </ThemedText>
        <Przycisk
          tytul={t('importEksport.wszystkieJson')}
          wariant="poboczny"
          onPress={eksportujWszystkieJson}
          zajety={eksportWszystkichZajety}
        />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('importEksport.przepisZAi')}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.przepisZAiOpis')}
        </ThemedText>
        <Przycisk
          tytul={Platform.OS === 'web' ? t('importEksport.kopiujPrompt') : t('importEksport.udostepnijPrompt')}
          onPress={skopiujPrompt}
          zajety={promptZajety}
        />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('importEksport.importPrzepisow')}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.importPrzepisowOpis')}
        </ThemedText>

        <Pole
          etykieta={t('importEksport.wklejJson')}
          value={wklejonyJson}
          onChangeText={setWklejonyJson}
          placeholder={'{ "nazwa": "…", "skladniki": [ … ] }'}
          multiline
          autoCapitalize="none"
          autoCorrect={false}
          spellCheck={false}
          style={styles.poleJson}
        />
        <Przycisk
          tytul={t('importEksport.sprawdzWklejony')}
          onPress={sprawdzWklejony}
          wylaczony={wklejonyJson.trim() === ''}
        />
        <Przycisk tytul={t('importEksport.wybierzPlikJson')} wariant="poboczny" onPress={wybierzPlik} />

        {nazwaPliku && (
          <ThemedText type="small" themeColor="textSecondary">
            {t('importEksport.plik', { nazwa: nazwaPliku })}
          </ThemedText>
        )}

        {bledyParsowania.length > 0 && (
          <View style={styles.blok}>
            <ThemedText type="smallBold" themeColor="accent">
              {t('importEksport.daniaPominiete', { count: bledyParsowania.length })}
            </ThemedText>
            {bledyParsowania.map((b, i) => (
              <ThemedText key={i} type="small" themeColor="textSecondary">
                {b.przepis ? t('importEksport.prefiksBledu', { nazwa: b.przepis }) : ''}
                {b.tresc}
              </ThemedText>
            ))}
          </View>
        )}

        {pozycje && pozycje.length > 0 && (
          <View style={styles.blok}>
            <ThemedText type="small" themeColor="textSecondary">
              {t('importEksport.gotowePrzepisy', { nowe: doDodania.length, korekty: doAktualizacji.length })}
            </ThemedText>
            {doAktualizacji.length > 0 && (
              <ThemedText type="small" themeColor="textSecondary">
                {t('importEksport.nadpisane', { nazwy: doAktualizacji.map((p) => p.dane.nazwa).join(', ') })}
              </ThemedText>
            )}
            <Przycisk
              tytul={t('importEksport.zapiszPrzepisy', { count: pozycje.length })}
              onPress={potwierdzImport}
              zajety={importZajety}
            />
            <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={wyczyscImport} />
          </View>
        )}

        {pozycje && pozycje.length === 0 && bledyParsowania.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            {t('importEksport.brakPrzepisowWPliku')}
          </ThemedText>
        )}

        {postep && importZajety && (
          <ThemedText type="small" themeColor="textSecondary">
            {t('importEksport.postep', { zrobione: postep.zrobione, razem: postep.razem })}
          </ThemedText>
        )}

        {zaimportowano !== null && (
          <View style={styles.blok}>
            <ThemedText type="smallBold">
              {t('importEksport.zapisanoPrzepisy', { count: zaimportowano })}
            </ThemedText>
            {bledyZapisu.length > 0 && (
              <>
                <ThemedText type="smallBold" themeColor="accent">
                  {t('importEksport.nieZapisano', { ile: bledyZapisu.length })}
                </ThemedText>
                {bledyZapisu.map((b, i) => (
                  <ThemedText key={i} type="small" themeColor="textSecondary">
                    {b.przepis ? t('importEksport.prefiksBledu', { nazwa: b.przepis }) : ''}
                    {b.tresc}
                  </ThemedText>
                ))}
              </>
            )}
          </View>
        )}
      </Karta>

      {komunikat && (
        <ThemedText type="small" themeColor="textSecondary">
          {komunikat}
        </ThemedText>
      )}
      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <Przycisk tytul={t('wspolne.wroc')} wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.three },
  blok: { gap: Spacing.one },
  poleJson: {
    minHeight: 140,
    maxHeight: 320,
    textAlignVertical: 'top',
    fontFamily: Platform.select({ ios: 'Menlo', default: 'monospace' }),
  },
  listaPrzepisow: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  pozycjaListy: {
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
    borderBottomWidth: 1,
  },
  wcisnieta: { opacity: 0.7 },
});
