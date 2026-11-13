import { router, useLocalSearchParams } from 'expo-router';
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
import { Wybor } from '@/components/wybor';
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
  zbudujPromptZmianyPrzepisu,
  type PrzepisJson,
} from '@/lib/przepis-json';
import { pobierzPelnyPrzepis, pobierzPrzepisy, pobierzWszystkiePelnePrzepisy } from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { pobierzSkladniki, ROLE_SKLADNIKA } from '@/lib/skladniki';
import { supabase } from '@/lib/supabase';

/**
 * Import / eksport przepisów — kreator „nowy przepis z AI” i kopia zapasowa.
 *
 * Kreator (dla każdego zalogowanego)
 * -----------------------------------
 *   1. sposób: na podstawie istniejącego przepisu albo od podstaw,
 *   2. tekst dla AI: prompt z katalogami (+ przepis wyjściowy przy sposobie 1),
 *   3. wklejona odpowiedź AI,
 *   4. podgląd z błędami i zapis jako NOWY, prywatny przepis.
 *
 * Kreator NIGDY nie nadpisuje istniejącego dania. Import rozpoznaje przepis
 * po nazwie, więc odpowiedź AI z nazwą oryginału zastąpiłaby oryginał —
 * w kroku 4 taka nazwa blokuje zapis, dopóki nie wpisze się innej.
 *
 * Kopia zapasowa (tylko moderator i administrator)
 * -------------------------------------------------
 * Eksport wszystkich przepisów do jednego pliku i wczytanie takiego pliku —
 * TU nadpisywanie po nazwie jest zamierzone, bo tak przywraca się kopię.
 *
 * Format, walidacja i dopasowanie do katalogów siedzą w `lib/przepis-json.ts`,
 * zapis w `lib/import-przepisow.ts`.
 */

type Sposob = '' | 'istniejacy' | 'nowy';

/** Klucz porównania nazw — taki sam jak unikalny indeks w bazie (migracja 0018). */
function kluczNazwy(nazwa: string): string {
  return nazwa.trim().replace(/\s+/g, ' ').toLowerCase();
}

/** Nazwa przepisu -> bezpieczny fragment nazwy pliku (bez polskich znaków, spacji, wielkości liter). */
function fragmentNazwyPliku(nazwa: string): string {
  const bezOgonkow = nazwa.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();
  return bezOgonkow.replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'przepis';
}

/** Pobranie/udostępnienie pliku tekstowego. */
async function zapiszPlik(
  tekst: string,
  nazwa: string,
  typ: string,
  poZapisie: (komunikat: string) => void
) {
  if (Platform.OS === 'web') {
    const url = URL.createObjectURL(new Blob([tekst], { type: `${typ};charset=utf-8` }));
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
      await Sharing.shareAsync(uri, { mimeType: typ, dialogTitle: i18n.t('importEksport.zapiszPlik') });
    } else {
      poZapisie(i18n.t('importEksport.zapisany', { uri }));
    }
  }
}

/**
 * Tekst do schowka. W przeglądarce wprost; na telefonie przez systemowe
 * „Udostępnij”, które ma „Kopiuj” i od razu pozwala wysłać tekst do czatu z AI.
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

/** Katalogi potrzebne do promptu i do sprawdzenia odpowiedzi. */
async function pobierzKatalogi() {
  const [skladniki, sprzet] = await Promise.all([pobierzSkladniki(), supabase.from('sprzet').select('nazwa')]);
  if (sprzet.error) throw sprzet.error;
  return { skladniki, sprzet: (sprzet.data ?? []).map((x) => x.nazwa as string) };
}

/** Wczytanie tekstu (odpowiedzi AI albo pliku kopii) i dopasowanie do przepisów w bazie. */
async function wczytajIPorownaj(tekst: string) {
  const [katalogi, istniejace] = await Promise.all([
    pobierzKatalogi(),
    supabase.from('przepisy').select('id, nazwa'),
  ]);
  if (istniejace.error) throw istniejace.error;
  const wczytane = wczytajJsonPrzepisow(tekst, { ...katalogi, role: ROLE_SKLADNIKA });
  const lista = (istniejace.data ?? []) as { id: string; nazwa: string }[];
  return {
    bledy: wczytane.bledy,
    pozycje: sklasyfikujPrzepisy(wczytane.przepisy, lista),
    istniejace: lista,
  };
}

/** Nagłówek kroku: „KROK 2 Z 4” i tytuł. */
function NaglowekKroku({ nr, tytul }: { nr: number; tytul: string }) {
  const { t } = useTranslation();
  return (
    <View style={styles.naglowekKroku}>
      <ThemedText type="smallBold" themeColor="accent">
        {t('importEksport.krok', { nr })}
      </ThemedText>
      <ThemedText type="subtitle">{tytul}</ThemedText>
    </View>
  );
}

export default function EkranImportEksportPrzepisow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();
  const motyw = useTheme();
  const { t } = useTranslation();
  const kontoId = sesja?.user.id;

  const [rola, setRola] = useState<string | null>(null);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);

  // --- krok 1 i 2 ---
  const [sposob, setSposob] = useState<Sposob>('');
  const [listaPrzepisow, setListaPrzepisow] = useState<{ id: string; nazwa: string }[]>([]);
  const [szukajPrzepisu, setSzukajPrzepisu] = useState('');
  const [wybranyPrzepisId, setWybranyPrzepisId] = useState<string | null>(null);
  const [przygotowanieZajete, setPrzygotowanieZajete] = useState(false);

  // --- krok 3 i 4 ---
  const [odpowiedz, setOdpowiedz] = useState('');
  const [sprawdzanie, setSprawdzanie] = useState(false);
  const [bledyOdpowiedzi, setBledyOdpowiedzi] = useState<BladImportu[]>([]);
  const [pozycje, setPozycje] = useState<PozycjaImportu[] | null>(null);
  const [istniejace, setIstniejace] = useState<{ id: string; nazwa: string }[]>([]);
  /** Nowe nazwy wpisane w kroku 4 — klucz to indeks pozycji. */
  const [noweNazwy, setNoweNazwy] = useState<Record<number, string>>({});
  const [zapisywanie, setZapisywanie] = useState(false);
  const [postep, setPostep] = useState<{ zrobione: number; razem: number } | null>(null);
  const [zapisane, setZapisane] = useState<{ id: string; nazwa: string }[] | null>(null);
  const [bledyZapisu, setBledyZapisu] = useState<BladImportu[]>([]);

  const mozeKopie = rola === 'moderator' || rola === 'administrator';

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

  // Rola tylko decyduje, czy pokazać kopię zapasową — błąd tutaj nie blokuje kreatora.
  useEffect(() => {
    if (!kontoId) return;
    supabase
      .from('konta')
      .select('rola')
      .eq('id', kontoId)
      .single()
      .then(({ data }) => setRola((data?.rola as string | undefined) ?? null));
  }, [kontoId]);

  const fraza = szukajPrzepisu.trim().toLowerCase();
  const przepisyPasujace = fraza
    ? listaPrzepisow.filter((p) => p.nazwa.toLowerCase().includes(fraza)).slice(0, 8)
    : [];
  const wybranyPrzepis = listaPrzepisow.find((p) => p.id === wybranyPrzepisId) ?? null;

  function wyczyscOdpowiedz() {
    setBledyOdpowiedzi([]);
    setPozycje(null);
    setNoweNazwy({});
    setPostep(null);
    setZapisane(null);
    setBledyZapisu([]);
  }

  function zacznijOdNowa() {
    setSposob('');
    setSzukajPrzepisu('');
    setWybranyPrzepisId(null);
    setOdpowiedz('');
    setBlad(null);
    setKomunikat(null);
    wyczyscOdpowiedz();
  }

  /** Krok 2: tekst dla AI — do schowka albo (przy istniejącym przepisie) do pliku. */
  async function przygotujDlaAi(cel: 'schowek' | 'plik') {
    setBlad(null);
    setKomunikat(null);
    setPrzygotowanieZajete(true);
    try {
      const katalogi = await pobierzKatalogi();
      let tekst: string;
      let nazwaWyjsciowa = 'przepis';
      if (sposob === 'istniejacy') {
        if (!wybranyPrzepisId) return;
        const pelny = await pobierzPelnyPrzepis(wybranyPrzepisId);
        nazwaWyjsciowa = pelny.nazwa;
        tekst = zbudujPromptZmianyPrzepisu(
          katalogi.skladniki,
          katalogi.sprzet,
          przepisDoJson(pelny, katalogi.skladniki)
        );
      } else {
        tekst = zbudujPromptPrzepisu(katalogi.skladniki, katalogi.sprzet);
      }

      if (cel === 'plik') {
        // Zwykły tekst, nie .json — w środku są zasady dla AI, a nie sam przepis.
        await zapiszPlik(
          tekst,
          `talerz-dla-ai-${fragmentNazwyPliku(nazwaWyjsciowa)}.txt`,
          'text/plain',
          setKomunikat
        );
      } else if ((await skopiujTekst(tekst)) === 'skopiowano') {
        setKomunikat(
          sposob === 'istniejacy' ? t('importEksport.skopiowanoDlaAi') : t('importEksport.skopiowanoInstrukcje')
        );
      }
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPrzygotowanieZajete(false);
    }
  }

  /** Krok 3 → 4: sprawdzenie wklejonej odpowiedzi. */
  async function sprawdzOdpowiedz() {
    setBlad(null);
    setKomunikat(null);
    wyczyscOdpowiedz();
    setSprawdzanie(true);
    try {
      const wynik = await wczytajIPorownaj(odpowiedz);
      setBledyOdpowiedzi(wynik.bledy);
      setPozycje(wynik.pozycje);
      setIstniejace(wynik.istniejace);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setSprawdzanie(false);
    }
  }

  const zajeteNazwy = new Set(istniejace.map((p) => kluczNazwy(p.nazwa)));

  /** Nazwa, pod którą przepis zostanie zapisany, i czy da się ją zapisać jako NOWY przepis. */
  function stanNazwy(i: number, p: PozycjaImportu) {
    const nazwa = (noweNazwy[i] ?? p.dane.nazwa).trim();
    const zajeta = zajeteNazwy.has(kluczNazwy(nazwa));
    const zlaDlugosc = nazwa.length < 3 || nazwa.length > 120;
    return { nazwa, zajeta, ok: !zajeta && !zlaDlugosc };
  }

  const wszystkieNazwyOk = (pozycje ?? []).every((p, i) => stanNazwy(i, p).ok);

  async function zapisz() {
    if (!pozycje || !sesja) return;
    setBlad(null);
    setZapisywanie(true);
    setPostep({ zrobione: 0, razem: pozycje.length });
    try {
      // Zawsze jako NOWE przepisy — kreator niczego nie nadpisuje.
      const doZapisu: PozycjaImportu[] = pozycje.map((p, i) => ({
        dane: { ...p.dane, nazwa: stanNazwy(i, p).nazwa },
        istniejacyId: null,
      }));
      const wynik = await zaimportujPrzepisy(doZapisu, sesja.user.id, (zrobione, razem) =>
        setPostep({ zrobione, razem })
      );
      setZapisane(wynik.zapisane);
      setBledyZapisu(wynik.bledy);
      setPozycje(null);
      if (wynik.bledy.length === 0) setOdpowiedz('');
      wczytajListePrzepisow();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZapisywanie(false);
    }
  }

  const krok2Gotowy = sposob === 'nowy' || (sposob === 'istniejacy' && wybranyPrzepisId !== null);
  const pokazKrok4 = pozycje !== null || bledyOdpowiedzi.length > 0 || zapisane !== null;

  return (
    <Ekran tytul={t('importEksport.tytul')} podtytul={t('importEksport.podtytul')}>
      <ThemedText type="small" themeColor="textSecondary">
        {t('importEksport.wstep')}
      </ThemedText>

      {/* --- KROK 1 ----------------------------------------------------- */}
      <Karta style={styles.grupa}>
        <NaglowekKroku nr={1} tytul={t('importEksport.krok1')} />
        <Wybor<Sposob>
          etykieta=""
          wybrana={sposob}
          onZmiana={(s) => {
            setSposob(s);
            setKomunikat(null);
            wyczyscOdpowiedz();
          }}
          opcje={[
            {
              wartosc: 'istniejacy',
              etykieta: t('importEksport.sposobIstniejacy'),
              opis: t('importEksport.sposobIstniejacyOpis'),
            },
            { wartosc: 'nowy', etykieta: t('importEksport.sposobNowy'), opis: t('importEksport.sposobNowyOpis') },
          ]}
        />
      </Karta>

      {/* --- KROK 2 ----------------------------------------------------- */}
      {sposob !== '' && (
        <Karta style={styles.grupa}>
          <NaglowekKroku nr={2} tytul={t('importEksport.krok2')} />

          {sposob === 'istniejacy' && (
            <>
              {wybranyPrzepis ? (
                <View style={styles.wybrany}>
                  <ThemedText type="smallBold" style={styles.wybranyNazwa}>
                    {wybranyPrzepis.nazwa}
                  </ThemedText>
                  <Przycisk
                    tytul={t('importEksport.zmienPrzepis')}
                    wariant="poboczny"
                    onPress={() => setWybranyPrzepisId(null)}
                  />
                </View>
              ) : (
                <>
                  <Pole
                    etykieta={t('importEksport.znajdzPrzepis')}
                    value={szukajPrzepisu}
                    onChangeText={setSzukajPrzepisu}
                    placeholder={t('importEksport.przyklad')}
                  />
                  {przepisyPasujace.length > 0 && (
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
                  {fraza !== '' && przepisyPasujace.length === 0 && (
                    <ThemedText type="small" themeColor="textSecondary">
                      {t('importEksport.brakPrzepisu', { fraza: szukajPrzepisu })}
                    </ThemedText>
                  )}
                </>
              )}
            </>
          )}

          {krok2Gotowy && (
            <>
              <ThemedText type="small" themeColor="textSecondary">
                {sposob === 'istniejacy' ? t('importEksport.krok2IstniejacyOpis') : t('importEksport.krok2NowyOpis')}
              </ThemedText>
              <Przycisk
                tytul={
                  sposob === 'istniejacy'
                    ? Platform.OS === 'web'
                      ? t('importEksport.kopiujDlaAi')
                      : t('importEksport.udostepnijDlaAi')
                    : Platform.OS === 'web'
                      ? t('importEksport.kopiujInstrukcje')
                      : t('importEksport.udostepnijInstrukcje')
                }
                ikona="copy-outline"
                onPress={() => przygotujDlaAi('schowek')}
                zajety={przygotowanieZajete}
              />
              {sposob === 'istniejacy' && (
                <Przycisk
                  tytul={t('importEksport.pobierzDlaAi')}
                  ikona="download-outline"
                  wariant="poboczny"
                  onPress={() => przygotujDlaAi('plik')}
                  wylaczony={przygotowanieZajete}
                />
              )}
            </>
          )}
        </Karta>
      )}

      {/* --- KROK 3 ----------------------------------------------------- */}
      {krok2Gotowy && (
        <Karta style={styles.grupa}>
          <NaglowekKroku nr={3} tytul={t('importEksport.krok3')} />
          <ThemedText type="small" themeColor="textSecondary">
            {t('importEksport.krok3Opis')}
          </ThemedText>
          <Pole
            etykieta={t('importEksport.wklejOdpowiedz')}
            value={odpowiedz}
            onChangeText={setOdpowiedz}
            placeholder={'{ "nazwa": "…", "skladniki": [ … ] }'}
            multiline
            autoCapitalize="none"
            autoCorrect={false}
            spellCheck={false}
            style={styles.poleJson}
          />
          <Przycisk
            tytul={t('importEksport.sprawdz')}
            onPress={sprawdzOdpowiedz}
            zajety={sprawdzanie}
            wylaczony={odpowiedz.trim() === ''}
          />
        </Karta>
      )}

      {/* --- KROK 4 ----------------------------------------------------- */}
      {krok2Gotowy && pokazKrok4 && (
        <Karta style={styles.grupa}>
          <NaglowekKroku nr={4} tytul={t('importEksport.krok4')} />

          {bledyOdpowiedzi.length > 0 && (
            <View style={styles.blok}>
              <ThemedText type="smallBold" themeColor="accent">
                {t('importEksport.daniaPominiete', { count: bledyOdpowiedzi.length })}
              </ThemedText>
              {bledyOdpowiedzi.map((b, i) => (
                <ThemedText key={i} type="small" themeColor="textSecondary">
                  {b.przepis ? t('importEksport.prefiksBledu', { nazwa: b.przepis }) : ''}
                  {b.tresc}
                </ThemedText>
              ))}
              <ThemedText type="small" themeColor="textSecondary">
                {t('importEksport.doPoprawyOpis')}
              </ThemedText>
            </View>
          )}

          {pozycje && pozycje.length > 0 && (
            <View style={styles.blok}>
              <ThemedText type="small" themeColor="textSecondary">
                {t('importEksport.krok4Opis')}
              </ThemedText>
              {pozycje.map((p, i) => {
                const stan = stanNazwy(i, p);
                const kolizjaZOryginalem = p.istniejacyId !== null;
                return (
                  <View key={i} style={[styles.podglad, { borderColor: motyw.border }]}>
                    <ThemedText type="smallBold">
                      {t('importEksport.podgladPrzepisu', {
                        nazwa: stan.nazwa,
                        skladniki: p.dane.skladniki.length,
                        kroki: p.dane.etapy.reduce((s, e) => s + e.kroki.length, 0),
                      })}
                    </ThemedText>
                    {kolizjaZOryginalem && (
                      <>
                        <ThemedText type="small" themeColor="accent">
                          {t('importEksport.takaSamaNazwa', { nazwa: p.dane.nazwa })}
                        </ThemedText>
                        <Pole
                          etykieta={t('importEksport.nowaNazwa')}
                          value={noweNazwy[i] ?? p.dane.nazwa}
                          onChangeText={(tekst) => setNoweNazwy((n) => ({ ...n, [i]: tekst }))}
                        />
                        {stan.zajeta && (
                          <ThemedText type="small" themeColor="accent">
                            {t('importEksport.zajetaNazwa')}
                          </ThemedText>
                        )}
                      </>
                    )}
                  </View>
                );
              })}
              <Przycisk
                tytul={
                  pozycje.length === 1
                    ? t('importEksport.zapiszPrzepis')
                    : t('importEksport.zapiszPrzepisy', { count: pozycje.length })
                }
                ikona="checkmark-circle-outline"
                onPress={zapisz}
                zajety={zapisywanie}
                wylaczony={!wszystkieNazwyOk}
              />
            </View>
          )}

          {pozycje && pozycje.length === 0 && bledyOdpowiedzi.length === 0 && (
            <ThemedText type="small" themeColor="textSecondary">
              {t('importEksport.brakPrzepisowWPliku')}
            </ThemedText>
          )}

          {postep && zapisywanie && (
            <ThemedText type="small" themeColor="textSecondary">
              {t('importEksport.postep', { zrobione: postep.zrobione, razem: postep.razem })}
            </ThemedText>
          )}

          {zapisane !== null && (
            <View style={styles.blok}>
              <ThemedText type="smallBold">{t('importEksport.zapisanoPrzepisy', { count: zapisane.length })}</ThemedText>
              {zapisane.map((z) => (
                <Przycisk
                  key={z.id}
                  tytul={t('importEksport.otworz', { nazwa: z.nazwa })}
                  ikona="open-outline"
                  onPress={() =>
                    router.push({
                      pathname: '/przepis',
                      params: { id: z.id, powrot: '/przepisy-import-eksport', tylkoCzytanie: '1' },
                    })
                  }
                />
              ))}
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
              <Przycisk tytul={t('importEksport.nastepny')} wariant="poboczny" onPress={zacznijOdNowa} />
            </View>
          )}
        </Karta>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        {t('importEksport.ostrzezenieAi')}
      </ThemedText>

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

      {sposob !== '' && zapisane === null && (
        <Przycisk tytul={t('importEksport.zacznijOdNowa')} wariant="poboczny" onPress={zacznijOdNowa} />
      )}

      {mozeKopie && <KopiaZapasowa />}

      <Przycisk tytul={t('wspolne.wroc')} wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

/**
 * Kopia zapasowa — tylko moderator i administrator (ekran pokazuje ją tylko im).
 *
 * W odróżnieniu od kreatora wczytanie kopii NADPISUJE przepisy o tej samej
 * nazwie — tak przywraca się stan z pliku.
 */
function KopiaZapasowa() {
  const { sesja } = useSesja();
  const { t } = useTranslation();

  const [eksportZajety, setEksportZajety] = useState(false);
  const [eksportSkladnikowZajety, setEksportSkladnikowZajety] = useState(false);
  const [zapisZajety, setZapisZajety] = useState(false);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  const [blad, setBlad] = useState<string | null>(null);
  const [nazwaPliku, setNazwaPliku] = useState<string | null>(null);
  const [bledyPliku, setBledyPliku] = useState<BladImportu[]>([]);
  const [pozycje, setPozycje] = useState<PozycjaImportu[] | null>(null);
  const [postep, setPostep] = useState<{ zrobione: number; razem: number } | null>(null);
  const [wynik, setWynik] = useState<{ zapisane: number; bledy: BladImportu[] } | null>(null);

  function wyczysc() {
    setNazwaPliku(null);
    setBledyPliku([]);
    setPozycje(null);
    setPostep(null);
    setWynik(null);
  }

  async function eksportujWszystkie() {
    setBlad(null);
    setKomunikat(null);
    setEksportZajety(true);
    try {
      const [pelne, skladniki] = await Promise.all([pobierzWszystkiePelnePrzepisy(), pobierzSkladniki()]);
      const jsony = pelne.map((p) => przepisDoJson(p, skladniki));
      const dzis = new Date().toISOString().slice(0, 10);
      await zapiszPlik(tekstJson(jsony), `talerz-przepisy-${dzis}.json`, 'application/json', setKomunikat);
      const ostrzezenie = ostrzezeniaEksportu(jsony);
      if (ostrzezenie) setBlad(ostrzezenie);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setEksportZajety(false);
    }
  }

  /**
   * Cały katalog składników jako JSON — kopia do wglądu i porównań. Wczytania
   * z powrotem celowo nie ma: katalog ma zostać zwarty, a zmiany idą przez
   * formularz składnika, gdzie pilnują ich te same sprawdzenia.
   */
  async function eksportujSkladniki() {
    setBlad(null);
    setKomunikat(null);
    setEksportSkladnikowZajety(true);
    try {
      const skladniki = await pobierzSkladniki();
      const dzis = new Date().toISOString().slice(0, 10);
      await zapiszPlik(
        JSON.stringify(skladniki, null, 2) + '\n',
        `talerz-skladniki-${dzis}.json`,
        'application/json',
        setKomunikat
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setEksportSkladnikowZajety(false);
    }
  }

  async function wybierzPlik() {
    setBlad(null);
    setKomunikat(null);
    wyczysc();
    try {
      const wybrany = await DocumentPicker.getDocumentAsync({
        // Telefony zgłaszają .json różnie — czasem jako zwykły tekst albo „dowolny plik”.
        type: ['application/json', 'text/plain', 'application/octet-stream'],
        copyToCacheDirectory: true,
      });
      if (wybrany.canceled || wybrany.assets.length === 0) return;
      const zasob = wybrany.assets[0];
      setNazwaPliku(zasob.name);
      const tekst =
        Platform.OS === 'web' && zasob.file ? await zasob.file.text() : await FileSystem.readAsStringAsync(zasob.uri);
      const wczytane = await wczytajIPorownaj(tekst);
      setBledyPliku(wczytane.bledy);
      setPozycje(wczytane.pozycje);
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  async function zapisz() {
    if (!pozycje || !sesja) return;
    setBlad(null);
    setZapisZajety(true);
    setPostep({ zrobione: 0, razem: pozycje.length });
    try {
      const w = await zaimportujPrzepisy(pozycje, sesja.user.id, (zrobione, razem) => setPostep({ zrobione, razem }));
      setWynik({ zapisane: w.zapisane.length, bledy: w.bledy });
      setPozycje(null);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZapisZajety(false);
    }
  }

  const doAktualizacji = pozycje?.filter((p) => p.istniejacyId !== null) ?? [];
  const doDodania = pozycje?.filter((p) => p.istniejacyId === null) ?? [];

  return (
    <Karta style={styles.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {t('importEksport.kopia')}
      </ThemedText>
      <ThemedText type="small" themeColor="textSecondary">
        {t('importEksport.kopiaOpis')}
      </ThemedText>

      <Przycisk
        tytul={t('importEksport.wszystkieJson')}
        ikona="download-outline"
        wariant="poboczny"
        onPress={eksportujWszystkie}
        zajety={eksportZajety}
      />
      <Przycisk
        tytul={t('importEksport.skladnikiJson')}
        ikona="download-outline"
        wariant="poboczny"
        onPress={eksportujSkladniki}
        zajety={eksportSkladnikowZajety}
      />

      <ThemedText type="small" themeColor="textSecondary">
        {t('importEksport.wczytajKopieOpis')}
      </ThemedText>
      <Przycisk tytul={t('importEksport.wczytajKopie')} ikona="cloud-upload-outline" wariant="poboczny" onPress={wybierzPlik} />

      {nazwaPliku && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.plik', { nazwa: nazwaPliku })}
        </ThemedText>
      )}

      {bledyPliku.length > 0 && (
        <View style={styles.blok}>
          <ThemedText type="smallBold" themeColor="accent">
            {t('importEksport.daniaPominiete', { count: bledyPliku.length })}
          </ThemedText>
          {bledyPliku.map((b, i) => (
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
            <ThemedText type="small" themeColor="accent">
              {t('importEksport.nadpisane', { nazwy: doAktualizacji.map((p) => p.dane.nazwa).join(', ') })}
            </ThemedText>
          )}
          <Przycisk
            tytul={t('importEksport.zapiszPrzepisy', { count: pozycje.length })}
            onPress={zapisz}
            zajety={zapisZajety}
          />
          <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={wyczysc} />
        </View>
      )}

      {pozycje && pozycje.length === 0 && bledyPliku.length === 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.brakPrzepisowWPliku')}
        </ThemedText>
      )}

      {postep && zapisZajety && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('importEksport.postep', { zrobione: postep.zrobione, razem: postep.razem })}
        </ThemedText>
      )}

      {wynik && (
        <View style={styles.blok}>
          <ThemedText type="smallBold">{t('importEksport.zapisanoPrzepisy', { count: wynik.zapisane })}</ThemedText>
          {wynik.bledy.length > 0 && (
            <>
              <ThemedText type="smallBold" themeColor="accent">
                {t('importEksport.nieZapisano', { ile: wynik.bledy.length })}
              </ThemedText>
              {wynik.bledy.map((b, i) => (
                <ThemedText key={i} type="small" themeColor="textSecondary">
                  {b.przepis ? t('importEksport.prefiksBledu', { nazwa: b.przepis }) : ''}
                  {b.tresc}
                </ThemedText>
              ))}
            </>
          )}
        </View>
      )}

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
    </Karta>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.three },
  blok: { gap: Spacing.two },
  naglowekKroku: { gap: 2 },
  wybrany: { flexDirection: 'row', alignItems: 'center', gap: Spacing.two, flexWrap: 'wrap' },
  wybranyNazwa: { flex: 1, minWidth: 160 },
  podglad: { borderWidth: 1, borderRadius: Spacing.two, padding: Spacing.two, gap: Spacing.two },
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
