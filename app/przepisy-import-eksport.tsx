import { useLocalSearchParams } from 'expo-router';
import * as DocumentPicker from 'expo-document-picker';
import * as FileSystem from 'expo-file-system/legacy';
import * as Sharing from 'expo-sharing';
import { useState } from 'react';
import { Platform, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { komunikatBledu } from '@/lib/blad';
import {
  eksportujPrzepisy,
  sklasyfikujPrzepisy,
  wczytajPlikPrzepisow,
  zaimportujPrzepisy,
  type BladImportu,
  type PozycjaImportu,
} from '@/lib/import-eksport-przepisow';
import {
  eksportujSkladniki,
  sklasyfikujSkladniki,
  wczytajPlikSkladnikow,
  zaimportujSkladniki,
  type BladImportuSkladnika,
  type PozycjaImportuSkladnika,
} from '@/lib/import-eksport-skladnikow';
import { bezPrefiksuDataUrl } from '@/lib/import-eksport-wspolne';
import { wroc } from '@/lib/nawigacja';
import { pobierzWszystkiePelnePrzepisy } from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { pobierzSkladniki } from '@/lib/skladniki';
import { supabase } from '@/lib/supabase';

/**
 * Import i eksport przepisów przez plik Excel.
 *
 * Zasady dopasowania i walidacji siedzą w `lib/import-eksport-przepisow.ts` —
 * tu jest tylko ekran: wybór pliku, podgląd tego, co się zaimportuje, i wynik.
 *
 * Ekran nie sprawdza roli — tak samo jak `uzytkownicy.tsx`. Eksport pokaże
 * tyle przepisów, ile pozwolą zobaczyć reguły dostępu w bazie, a zapis
 * cudzego albo publicznego przepisu bez uprawnień moderatora skończy się
 * zwykłym błędem z bazy, widocznym niżej przy tym konkretnym daniu.
 */

const TYP_PLIKU_XLSX = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';

function nazwaPlikuEksportu(prefiks: string): string {
  const dzis = new Date().toISOString().slice(0, 10);
  return `talerz-${prefiks}-${dzis}.xlsx`;
}

/** Pobranie/udostępnienie już zbudowanego pliku .xlsx — identyczne dla przepisów i składników. */
async function zapiszPlikXlsx(base64: string, nazwa: string, poZapisie: (komunikat: string) => void) {
  if (Platform.OS === 'web') {
    // Na webie nie ma katalogu plików ani udostępniania — zwykłe pobranie
    // przez tymczasowy link załatwia sprawę.
    const a = document.createElement('a');
    a.href = `data:${TYP_PLIKU_XLSX};base64,${base64}`;
    a.download = nazwa;
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    poZapisie(`Pobrano plik ${nazwa}.`);
  } else {
    const uri = FileSystem.cacheDirectory + nazwa;
    await FileSystem.writeAsStringAsync(uri, base64, {
      encoding: FileSystem.EncodingType.Base64,
    });

    if (await Sharing.isAvailableAsync()) {
      await Sharing.shareAsync(uri, { mimeType: TYP_PLIKU_XLSX, dialogTitle: 'Zapisz plik' });
    } else {
      poZapisie(`Plik zapisany: ${uri}`);
    }
  }
}

export default function EkranImportEksportPrzepisow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();

  const [eksportZajety, setEksportZajety] = useState(false);
  const [importZajety, setImportZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);

  const [nazwaPliku, setNazwaPliku] = useState<string | null>(null);
  const [bledyParsowania, setBledyParsowania] = useState<BladImportu[]>([]);
  const [pozycje, setPozycje] = useState<PozycjaImportu[] | null>(null);
  const [postep, setPostep] = useState<{ zrobione: number; razem: number } | null>(null);
  const [bledyZapisu, setBledyZapisu] = useState<BladImportu[]>([]);
  const [zaimportowano, setZaimportowano] = useState<number | null>(null);

  const [eksportZajetySkladniki, setEksportZajetySkladniki] = useState(false);
  const [importZajetySkladniki, setImportZajetySkladniki] = useState(false);
  const [bladSkladniki, setBladSkladniki] = useState<string | null>(null);
  const [komunikatSkladniki, setKomunikatSkladniki] = useState<string | null>(null);

  const [nazwaPlikuSkladnikow, setNazwaPlikuSkladnikow] = useState<string | null>(null);
  const [bledyParsowaniaSkladnikow, setBledyParsowaniaSkladnikow] = useState<BladImportuSkladnika[]>([]);
  const [pozycjeSkladnikow, setPozycjeSkladnikow] = useState<PozycjaImportuSkladnika[] | null>(null);
  const [postepSkladnikow, setPostepSkladnikow] = useState<{ zrobione: number; razem: number } | null>(
    null
  );
  const [bledyZapisuSkladnikow, setBledyZapisuSkladnikow] = useState<BladImportuSkladnika[]>([]);
  const [zaimportowanoSkladnikow, setZaimportowanoSkladnikow] = useState<number | null>(null);

  async function eksportuj() {
    setBlad(null);
    setKomunikat(null);
    setEksportZajety(true);
    try {
      const przepisy = await pobierzWszystkiePelnePrzepisy();
      if (przepisy.length === 0) {
        setBlad('Baza przepisów jest pusta — nie ma czego eksportować.');
        return;
      }

      const base64 = await eksportujPrzepisy(przepisy);
      await zapiszPlikXlsx(base64, nazwaPlikuEksportu('przepisy'), setKomunikat);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setEksportZajety(false);
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

  async function wybierzPlik() {
    setBlad(null);
    setKomunikat(null);
    wyczyscImport();

    try {
      const wynik = await DocumentPicker.getDocumentAsync({
        type: [TYP_PLIKU_XLSX, 'application/vnd.ms-excel'],
        copyToCacheDirectory: true,
        base64: true,
      });
      if (wynik.canceled || wynik.assets.length === 0) return;

      const zasob = wynik.assets[0];
      setNazwaPliku(zasob.name);

      const base64 =
        Platform.OS === 'web'
          ? bezPrefiksuDataUrl(zasob.base64 ?? '')
          : await FileSystem.readAsStringAsync(zasob.uri, {
              encoding: FileSystem.EncodingType.Base64,
            });

      if (!base64) {
        setBlad('Nie udało się odczytać pliku.');
        return;
      }

      // Katalog składników i lista już istniejących przepisów — potrzebne
      // razem, żeby wiedzieć, co jest korektą, a co nowym daniem.
      const [dostepneSkladniki, istniejacePrzepisy] = await Promise.all([
        pobierzSkladniki(),
        supabase.from('przepisy').select('id, nazwa'),
      ]);
      if (istniejacePrzepisy.error) throw istniejacePrzepisy.error;

      const wczytane = await wczytajPlikPrzepisow(base64, dostepneSkladniki);
      setBledyParsowania(wczytane.bledy);
      setPozycje(sklasyfikujPrzepisy(wczytane.przepisy, istniejacePrzepisy.data ?? []));
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
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
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setImportZajety(false);
    }
  }

  const doAktualizacji = pozycje?.filter((p) => p.istniejacyId !== null) ?? [];
  const doDodania = pozycje?.filter((p) => p.istniejacyId === null) ?? [];

  async function eksportujSkladnikiPlik() {
    setBladSkladniki(null);
    setKomunikatSkladniki(null);
    setEksportZajetySkladniki(true);
    try {
      const skladniki = await pobierzSkladniki();
      if (skladniki.length === 0) {
        setBladSkladniki('Katalog składników jest pusty — nie ma czego eksportować.');
        return;
      }

      const base64 = await eksportujSkladniki(skladniki);
      await zapiszPlikXlsx(base64, nazwaPlikuEksportu('skladniki'), setKomunikatSkladniki);
    } catch (e) {
      setBladSkladniki(komunikatBledu(e));
    } finally {
      setEksportZajetySkladniki(false);
    }
  }

  function wyczyscImportSkladnikow() {
    setNazwaPlikuSkladnikow(null);
    setBledyParsowaniaSkladnikow([]);
    setPozycjeSkladnikow(null);
    setPostepSkladnikow(null);
    setBledyZapisuSkladnikow([]);
    setZaimportowanoSkladnikow(null);
  }

  async function wybierzPlikSkladnikow() {
    setBladSkladniki(null);
    setKomunikatSkladniki(null);
    wyczyscImportSkladnikow();

    try {
      const wynik = await DocumentPicker.getDocumentAsync({
        type: [TYP_PLIKU_XLSX, 'application/vnd.ms-excel'],
        copyToCacheDirectory: true,
        base64: true,
      });
      if (wynik.canceled || wynik.assets.length === 0) return;

      const zasob = wynik.assets[0];
      setNazwaPlikuSkladnikow(zasob.name);

      const base64 =
        Platform.OS === 'web'
          ? bezPrefiksuDataUrl(zasob.base64 ?? '')
          : await FileSystem.readAsStringAsync(zasob.uri, {
              encoding: FileSystem.EncodingType.Base64,
            });

      if (!base64) {
        setBladSkladniki('Nie udało się odczytać pliku.');
        return;
      }

      const istniejaceSkladniki = await supabase.from('skladniki').select('id, nazwa');
      if (istniejaceSkladniki.error) throw istniejaceSkladniki.error;

      const wczytane = await wczytajPlikSkladnikow(base64);
      setBledyParsowaniaSkladnikow(wczytane.bledy);
      setPozycjeSkladnikow(sklasyfikujSkladniki(wczytane.skladniki, istniejaceSkladniki.data ?? []));
    } catch (e) {
      setBladSkladniki(komunikatBledu(e));
    }
  }

  async function potwierdzImportSkladnikow() {
    if (!pozycjeSkladnikow) return;
    setBladSkladniki(null);
    setImportZajetySkladniki(true);
    setPostepSkladnikow({ zrobione: 0, razem: pozycjeSkladnikow.length });

    try {
      const { bledy } = await zaimportujSkladniki(pozycjeSkladnikow, (zrobione, razem) =>
        setPostepSkladnikow({ zrobione, razem })
      );
      setZaimportowanoSkladnikow(pozycjeSkladnikow.length - bledy.length);
      setBledyZapisuSkladnikow(bledy);
      setPozycjeSkladnikow(null);
    } catch (e) {
      setBladSkladniki(komunikatBledu(e));
    } finally {
      setImportZajetySkladniki(false);
    }
  }

  const doAktualizacjiSkladnikow = pozycjeSkladnikow?.filter((p) => p.istniejacyId !== null) ?? [];
  const doDodaniaSkladnikow = pozycjeSkladnikow?.filter((p) => p.istniejacyId === null) ?? [];

  return (
    <Ekran
      tytul="Import / eksport przepisów i składników"
      podtytul="Plik Excel — kopia zapasowa albo masowa edycja poza aplikacją">
      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          EKSPORT PRZEPISÓW
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Zapisuje przepisy do jednego pliku .xlsx: osobny arkusz na nagłówek dania,
          składniki, etapy i kroki, plus arkusz z instrukcją formatu.
        </ThemedText>
        <Przycisk tytul="Eksportuj do pliku Excel" onPress={eksportuj} zajety={eksportZajety} />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          IMPORT PRZEPISÓW
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Przepis rozpoznawany jest PO NAZWIE, bez względu na wielkość liter. Identyczna
          nazwa zastępuje treść istniejącego dania — to korekta, nie duplikat. Nowa nazwa
          zakłada nowy, prywatny przepis. Zdjęcia i stanu publikacji import nie rusza.
        </ThemedText>

        <Przycisk tytul="Wybierz plik Excel" wariant="poboczny" onPress={wybierzPlik} />

        {nazwaPliku && (
          <ThemedText type="small" themeColor="textSecondary">
            Plik: {nazwaPliku}
          </ThemedText>
        )}

        {bledyParsowania.length > 0 && (
          <View style={styles.blok}>
            <ThemedText type="smallBold" themeColor="accent">
              {bledyParsowania.length}{' '}
              {bledyParsowania.length === 1 ? 'danie pominięte' : 'dań pominiętych'} — błędy
              w pliku
            </ThemedText>
            {bledyParsowania.map((b, i) => (
              <ThemedText key={i} type="small" themeColor="textSecondary">
                {b.przepis ? `„${b.przepis}”: ` : ''}
                {b.tresc}
              </ThemedText>
            ))}
          </View>
        )}

        {pozycje && pozycje.length > 0 && (
          <View style={styles.blok}>
            <ThemedText type="small" themeColor="textSecondary">
              Gotowe do zapisania: {doDodania.length} nowych, {doAktualizacji.length} korekt
              istniejących.
            </ThemedText>
            {doAktualizacji.length > 0 && (
              <ThemedText type="small" themeColor="textSecondary">
                Zostaną nadpisane: {doAktualizacji.map((p) => p.dane.nazwa).join(', ')}
              </ThemedText>
            )}
            <Przycisk
              tytul={`Zapisz ${pozycje.length} ${pozycje.length === 1 ? 'przepis' : 'przepisów'}`}
              onPress={potwierdzImport}
              zajety={importZajety}
            />
            <Przycisk tytul="Anuluj" wariant="poboczny" onPress={wyczyscImport} />
          </View>
        )}

        {pozycje && pozycje.length === 0 && bledyParsowania.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Plik nie zawiera żadnego przepisu.
          </ThemedText>
        )}

        {postep && importZajety && (
          <ThemedText type="small" themeColor="textSecondary">
            Zapisywanie: {postep.zrobione} / {postep.razem}
          </ThemedText>
        )}

        {zaimportowano !== null && (
          <View style={styles.blok}>
            <ThemedText type="smallBold">
              Zapisano {zaimportowano} {zaimportowano === 1 ? 'przepis' : 'przepisów'}.
            </ThemedText>
            {bledyZapisu.length > 0 && (
              <>
                <ThemedText type="smallBold" themeColor="accent">
                  Nie udało się zapisać {bledyZapisu.length}:
                </ThemedText>
                {bledyZapisu.map((b, i) => (
                  <ThemedText key={i} type="small" themeColor="textSecondary">
                    {b.przepis ? `„${b.przepis}”: ` : ''}
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

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          EKSPORT SKŁADNIKÓW
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Zapisuje cały katalog składników — wartości odżywcze na 100 g, źródło i tagi —
          do jednego pliku .xlsx z arkuszem instrukcji.
        </ThemedText>
        <Przycisk
          tytul="Eksportuj do pliku Excel"
          onPress={eksportujSkladnikiPlik}
          zajety={eksportZajetySkladniki}
        />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          IMPORT SKŁADNIKÓW
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Składnik rozpoznawany jest PO NAZWIE, bez względu na wielkość liter. Identyczna
          nazwa aktualizuje wartości odżywcze istniejącego składnika. Nowa nazwa zakłada
          nowy składnik.
        </ThemedText>

        <Przycisk tytul="Wybierz plik Excel" wariant="poboczny" onPress={wybierzPlikSkladnikow} />

        {nazwaPlikuSkladnikow && (
          <ThemedText type="small" themeColor="textSecondary">
            Plik: {nazwaPlikuSkladnikow}
          </ThemedText>
        )}

        {bledyParsowaniaSkladnikow.length > 0 && (
          <View style={styles.blok}>
            <ThemedText type="smallBold" themeColor="accent">
              {bledyParsowaniaSkladnikow.length}{' '}
              {bledyParsowaniaSkladnikow.length === 1 ? 'składnik pominięty' : 'składników pominiętych'}{' '}
              — błędy w pliku
            </ThemedText>
            {bledyParsowaniaSkladnikow.map((b, i) => (
              <ThemedText key={i} type="small" themeColor="textSecondary">
                {b.skladnik ? `„${b.skladnik}”: ` : ''}
                {b.tresc}
              </ThemedText>
            ))}
          </View>
        )}

        {pozycjeSkladnikow && pozycjeSkladnikow.length > 0 && (
          <View style={styles.blok}>
            <ThemedText type="small" themeColor="textSecondary">
              Gotowe do zapisania: {doDodaniaSkladnikow.length} nowych,{' '}
              {doAktualizacjiSkladnikow.length} aktualizacji istniejących.
            </ThemedText>
            {doAktualizacjiSkladnikow.length > 0 && (
              <ThemedText type="small" themeColor="textSecondary">
                Zostaną nadpisane: {doAktualizacjiSkladnikow.map((p) => p.dane.nazwa).join(', ')}
              </ThemedText>
            )}
            <Przycisk
              tytul={`Zapisz ${pozycjeSkladnikow.length} ${
                pozycjeSkladnikow.length === 1 ? 'składnik' : 'składników'
              }`}
              onPress={potwierdzImportSkladnikow}
              zajety={importZajetySkladniki}
            />
            <Przycisk tytul="Anuluj" wariant="poboczny" onPress={wyczyscImportSkladnikow} />
          </View>
        )}

        {pozycjeSkladnikow &&
          pozycjeSkladnikow.length === 0 &&
          bledyParsowaniaSkladnikow.length === 0 && (
            <ThemedText type="small" themeColor="textSecondary">
              Plik nie zawiera żadnego składnika.
            </ThemedText>
          )}

        {postepSkladnikow && importZajetySkladniki && (
          <ThemedText type="small" themeColor="textSecondary">
            Zapisywanie: {postepSkladnikow.zrobione} / {postepSkladnikow.razem}
          </ThemedText>
        )}

        {zaimportowanoSkladnikow !== null && (
          <View style={styles.blok}>
            <ThemedText type="smallBold">
              Zapisano {zaimportowanoSkladnikow}{' '}
              {zaimportowanoSkladnikow === 1 ? 'składnik' : 'składników'}.
            </ThemedText>
            {bledyZapisuSkladnikow.length > 0 && (
              <>
                <ThemedText type="smallBold" themeColor="accent">
                  Nie udało się zapisać {bledyZapisuSkladnikow.length}:
                </ThemedText>
                {bledyZapisuSkladnikow.map((b, i) => (
                  <ThemedText key={i} type="small" themeColor="textSecondary">
                    {b.skladnik ? `„${b.skladnik}”: ` : ''}
                    {b.tresc}
                  </ThemedText>
                ))}
              </>
            )}
          </View>
        )}
      </Karta>

      {komunikatSkladniki && (
        <ThemedText type="small" themeColor="textSecondary">
          {komunikatSkladniki}
        </ThemedText>
      )}
      {bladSkladniki && (
        <ThemedText type="small" themeColor="accent">
          {bladSkladniki}
        </ThemedText>
      )}

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.three },
  blok: { gap: Spacing.one },
});
