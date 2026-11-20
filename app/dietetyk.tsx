import { Ionicons } from '@expo/vector-icons';
import { useFocusEffect } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, useWindowDimensions, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { KafleWyniku } from '@/components/kafle-wyniku';
import { Karta } from '@/components/karta';
import { SchematyKlienta } from '@/components/schematy-klienta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import {
  pobierzKlienta,
  pobierzKlientow,
  pobierzMojKod,
  ustawCelKlienta,
  ustawNazweDietetyka,
  zakonczWspolprace,
  zmienKod,
  type DaneKlienta,
  type KlientNaLiscie,
  type KodDietetyka,
  type PozycjaPlanuKlienta,
} from '@/lib/dietetyk';
import { data, liczbaNaTekst } from '@/lib/jezyk';
import { calkowityWydatekNASEM, celZywieniowyNASEM } from '@/lib/nasem';
import { opisDnia, PORY, sumujDzien } from '@/lib/plan';
import { useSesja } from '@/lib/sesja';
import { przemianaPodstawowa, wiekZDaty, type TrybCelu } from '@/lib/zywienie';

/**
 * Panel dietetyka — lista klientów i szczegóły jednego z nich.
 *
 * Dane klientów przychodzą WYŁĄCZNIE przez funkcje bazy z migracji 0050
 * (lib/dietetyk.ts). Dietetyk widzi profil, pomiary, cele, najnowszy tydzień
 * planu i wykluczone składniki; zmienić może tylko cel.
 *
 * Układ: na szerokim ekranie (komputer w gabinecie) dwie kolumny — lista po
 * lewej, klient po prawej. Na wąskim jedno pod drugim: najpierw lista,
 * po wybraniu klienta jego karta z przyciskiem powrotu.
 */

const SZEROKI = 900;

export default function PanelDietetyka() {
  const { t } = useTranslation();
  const { sesja } = useSesja();
  const motyw = useTheme();
  const { width } = useWindowDimensions();
  const szeroki = width >= SZEROKI;

  const [kod, setKod] = useState<KodDietetyka | null>(null);
  const [nazwa, setNazwa] = useState('');
  const [klienci, setKlienci] = useState<KlientNaLiscie[]>([]);
  const [wybrany, setWybrany] = useState<string | null>(null);
  const [dane, setDane] = useState<DaneKlienta | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [wczytywanieKlienta, setWczytywanieKlienta] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  const [pytanieOKod, setPytanieOKod] = useState(false);

  const pobierzListe = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const [mojKod, lista] = await Promise.all([pobierzMojKod(), pobierzKlientow()]);
      setKod(mojKod);
      setNazwa(mojKod.nazwa ?? '');
      setKlienci(lista);
      // Klient, który odwołał zgodę, znika — nie zostawiamy jego karty na ekranie.
      setWybrany((w) => (w && lista.some((k) => k.profil_id === w) ? w : szeroki ? (lista[0]?.profil_id ?? null) : null));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [szeroki]);

  useFocusEffect(
    useCallback(() => {
      pobierzListe();
    }, [pobierzListe])
  );

  const pobierzWybranego = useCallback(async () => {
    if (!wybrany) {
      setDane(null);
      return;
    }
    setWczytywanieKlienta(true);
    try {
      setDane(await pobierzKlienta(wybrany));
    } catch (e) {
      setDane(null);
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanieKlienta(false);
    }
  }, [wybrany]);

  useEffect(() => {
    pobierzWybranego();
  }, [pobierzWybranego]);

  async function zapiszNazwe() {
    if (!sesja) return;
    setBlad(null);
    try {
      await ustawNazweDietetyka(sesja.user.id, nazwa);
      setKomunikat(t('dietetyk.nazwaZapisana'));
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  async function nowyKod() {
    setBlad(null);
    try {
      const nowy = await zmienKod();
      setKod((k) => (k ? { ...k, kod: nowy } : { kod: nowy, nazwa: null }));
      setPytanieOKod(false);
      setKomunikat(t('dietetyk.kodZmieniony'));
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  const lista = (
    <View style={styles.kolumna}>
      <Karta style={styles.odstep}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('dietetyk.twojKod')}
        </ThemedText>
        <ThemedText type="subtitle" style={styles.kod} selectable>
          {kod?.kod ?? '······'}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('dietetyk.kodOpis')}
        </ThemedText>
        {pytanieOKod ? (
          <>
            <ThemedText type="small" themeColor="accent">
              {t('dietetyk.nowyKodPytanie')}
            </ThemedText>
            <Przycisk tytul={t('dietetyk.nowyKodTak')} onPress={nowyKod} />
            <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={() => setPytanieOKod(false)} />
          </>
        ) : (
          <Przycisk
            tytul={t('dietetyk.nowyKod')}
            ikona="refresh"
            wariant="poboczny"
            onPress={() => setPytanieOKod(true)}
          />
        )}
        <Pole
          etykieta={t('dietetyk.nazwa')}
          value={nazwa}
          onChangeText={setNazwa}
          placeholder={sesja?.user.email ?? ''}
          maxLength={80}
        />
        <Przycisk tytul={t('dietetyk.zapiszNazwe')} wariant="poboczny" onPress={zapiszNazwe} />
      </Karta>

      <ThemedText type="smallBold" themeColor="textSecondary" style={styles.naglowekListy}>
        {t('dietetyk.klienci', { count: klienci.length })}
      </ThemedText>

      {!wczytywanie && klienci.length === 0 && (
        <Karta>
          <ThemedText type="default">{t('dietetyk.brakKlientow')}</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {t('dietetyk.brakKlientowOpis')}
          </ThemedText>
        </Karta>
      )}

      {klienci.map((k) => {
        const aktywny = k.profil_id === wybrany;
        return (
          <Pressable
            key={k.profil_id}
            accessibilityRole="button"
            accessibilityState={{ selected: aktywny }}
            onPress={() => {
              setKomunikat(null);
              setWybrany(k.profil_id);
            }}
            style={({ pressed }) => [
              styles.klient,
              {
                backgroundColor: aktywny ? motyw.backgroundSelected : motyw.backgroundElement,
                borderColor: aktywny ? motyw.accent : motyw.border,
              },
              pressed && { opacity: 0.8 },
            ]}>
            <View style={[styles.inicjal, { backgroundColor: `${motyw.accent}1F` }]}>
              <ThemedText type="smallBold" themeColor="accent">
                {k.imie.slice(0, 1).toUpperCase()}
              </ThemedText>
            </View>
            <View style={styles.flex}>
              <ThemedText type="default">{k.imie}</ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                {t('wspolne.lata', { count: wiekZDaty(k.data_urodzenia) })}
                {k.waga !== null ? ` · ${liczbaNaTekst(k.waga, 1)} kg` : ''}
                {k.data_wagi ? ` · ${data(k.data_wagi, { day: 'numeric', month: 'short' })}` : ''}
              </ThemedText>
            </View>
            <Ionicons name="chevron-forward" size={18} color={motyw.textSecondary} />
          </Pressable>
        );
      })}
    </View>
  );

  const szczegoly = (
    <View style={[styles.kolumna, szeroki && styles.kolumnaSzeroka]}>
      {!szeroki && (
        <Przycisk
          tytul={t('dietetyk.wrocDoListy')}
          ikona="arrow-back"
          wariant="poboczny"
          onPress={() => setWybrany(null)}
        />
      )}
      {wczytywanieKlienta && !dane && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('wspolne.wczytywanie')}
        </ThemedText>
      )}
      {dane && (
        <KartaKlienta
          key={dane.profil.id}
          dane={dane}
          onZapisano={() => {
            setKomunikat(t('dietetyk.celZapisany', { imie: dane.profil.imie }));
            pobierzWybranego();
          }}
          onZakonczono={() => {
            setKomunikat(t('dietetyk.zakonczono', { imie: dane.profil.imie }));
            setWybrany(null);
            pobierzListe();
          }}
          onBlad={setBlad}
        />
      )}
      {!dane && !wczytywanieKlienta && szeroki && klienci.length > 0 && (
        <Karta>
          <ThemedText type="small" themeColor="textSecondary">
            {t('dietetyk.wybierzKlienta')}
          </ThemedText>
        </Karta>
      )}
    </View>
  );

  return (
    <Ekran tytul={t('dietetyk.tytul')} podtytul={t('dietetyk.podtytul')} pelnaSzerokosc={szeroki}>
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

      {szeroki ? (
        <View style={styles.dwieKolumny}>
          <View style={styles.lewa}>{lista}</View>
          <View style={styles.prawa}>{szczegoly}</View>
        </View>
      ) : wybrany ? (
        szczegoly
      ) : (
        lista
      )}
    </Ekran>
  );
}

// ---------------------------------------------------------------------------
//  Karta jednego klienta
// ---------------------------------------------------------------------------

function liczba(tekst: string): number | null {
  const t = tekst.replace(',', '.').trim();
  if (!t) return null;
  const n = Number(t);
  return Number.isFinite(n) ? n : null;
}

function KartaKlienta({
  dane,
  onZapisano,
  onZakonczono,
  onBlad,
}: {
  dane: DaneKlienta;
  onZapisano: () => void;
  onZakonczono: () => void;
  onBlad: (b: string | null) => void;
}) {
  const { t } = useTranslation();
  const motyw = useTheme();
  const { profil } = dane;
  const wiek = wiekZDaty(profil.data_urodzenia);
  const wagi = dane.pomiary.filter((p) => p.typ === 'waga');
  const talie = dane.pomiary.filter((p) => p.typ === 'talia');
  const waga = wagi.length > 0 ? wagi[wagi.length - 1].wartosc : null;
  const obecny = dane.cele[0] ?? null;

  // Formularz celu startuje od obecnego celu klienta.
  const [tryb, setTryb] = useState<TrybCelu>(obecny?.tryb ?? 'utrzymanie');
  const [bialko, setBialko] = useState(String(obecny?.bialko_procent ?? 25));
  const [tluszcz, setTluszcz] = useState(String(obecny?.tluszcz_procent ?? 30));
  const [wegle, setWegle] = useState(String(obecny?.wegle_procent ?? 45));
  const [kcal, setKcal] = useState(obecny?.kcal_ustalone ? String(obecny.kcal_ustalone) : '');
  const [zajety, setZajety] = useState(false);
  const [pytanieOKoniec, setPytanieOKoniec] = useState(false);

  const b = liczba(bialko);
  const tl = liczba(tluszcz);
  const w = liczba(wegle);
  const k = liczba(kcal);
  const sumaProcent = (b ?? 0) + (tl ?? 0) + (w ?? 0);
  const kcalPoprawne = kcal.trim() === '' || (k !== null && k >= 800 && k <= 6000);
  const procentyPoprawne = b !== null && tl !== null && w !== null && sumaProcent === 100;

  const celObecny =
    obecny && waga
      ? celZywieniowyNASEM(
          profil.plec,
          wiek,
          profil.wzrost_cm,
          waga,
          profil.aktywnosc,
          obecny.tryb,
          { bialko: obecny.bialko_procent, tluszcz: obecny.tluszcz_procent, wegle: obecny.wegle_procent },
          obecny.kcal_ustalone
        )
      : null;

  const podglad =
    waga && procentyPoprawne && kcalPoprawne
      ? celZywieniowyNASEM(
          profil.plec,
          wiek,
          profil.wzrost_cm,
          waga,
          profil.aktywnosc,
          tryb,
          { bialko: b!, tluszcz: tl!, wegle: w! },
          kcal.trim() === '' ? null : Math.round(k!)
        )
      : null;

  const przemiana = waga ? przemianaPodstawowa(profil.plec, waga, profil.wzrost_cm, wiek) : null;
  const zapotrzebowanie = waga
    ? calkowityWydatekNASEM(profil.plec, wiek, profil.wzrost_cm, waga, profil.aktywnosc)
    : null;

  async function zapisz() {
    if (!procentyPoprawne || !kcalPoprawne) return;
    onBlad(null);
    setZajety(true);
    try {
      await ustawCelKlienta(profil.id, {
        tryb,
        bialko_procent: Math.round(b!),
        tluszcz_procent: Math.round(tl!),
        wegle_procent: Math.round(w!),
        kcal_ustalone: kcal.trim() === '' ? null : Math.round(k!),
      });
      onZapisano();
    } catch (e) {
      onBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  async function zakoncz() {
    onBlad(null);
    try {
      await zakonczWspolprace(profil.id);
      onZakonczono();
    } catch (e) {
      onBlad(komunikatBledu(e));
    }
  }

  return (
    <>
      <Karta style={styles.odstep}>
        <ThemedText type="subtitle">{profil.imie}</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {profil.plec === 'K' ? t('dietetyk.kobieta') : t('dietetyk.mezczyzna')} ·{' '}
          {t('wspolne.lata', { count: wiek })} · {profil.wzrost_cm} cm
          {waga ? ` · ${liczbaNaTekst(waga, 1)} kg` : ''}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('dietetyk.aktywnosc', { poziom: t(`pal.${profil.aktywnosc}.nazwa`) })}
          {profil.liczba_osob > 1 ? ` · ${t('dietetyk.osobWDomu', { count: profil.liczba_osob })}` : ''}
        </ThemedText>
        {przemiana && zapotrzebowanie && (
          <ThemedText type="small" themeColor="textSecondary">
            {t('dietetyk.wzor', { przemiana, zapotrzebowanie })}
          </ThemedText>
        )}
      </Karta>

      <Karta style={styles.odstep}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('dietetyk.celObecny')}
        </ThemedText>
        {celObecny ? (
          <>
            <KafleWyniku cel={celObecny} />
            <ThemedText type="small" themeColor="textSecondary">
              {obecny!.kcal_ustalone ? t('dietetyk.kcalUstalone') : t('dietetyk.kcalZeWzoru')} ·{' '}
              {obecny!.tryb === 'redukcja' ? t('profil.trybRedukcja') : t('profil.trybUtrzymanie')} ·{' '}
              {obecny!.bialko_procent}/{obecny!.tluszcz_procent}/{obecny!.wegle_procent}% ·{' '}
              {obecny!.od_dietetyka ? t('dietetyk.ustawionyPrzezDietetyka') : t('dietetyk.ustawionyPrzezKlienta')} ·{' '}
              {t('dietetyk.od', { data: data(obecny!.obowiazuje_od) })}
            </ThemedText>
          </>
        ) : (
          <ThemedText type="small" themeColor="accent">
            {waga ? t('dietetyk.brakCelu') : t('dietetyk.brakWagi')}
          </ThemedText>
        )}
      </Karta>

      <Karta style={styles.odstep}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('dietetyk.ustawCel')}
        </ThemedText>
        <View style={styles.rzad}>
          {(['utrzymanie', 'redukcja'] as const).map((tr) => (
            <Przycisk
              key={tr}
              tytul={tr === 'redukcja' ? t('profil.trybRedukcja') : t('profil.trybUtrzymanie')}
              wariant={tryb === tr ? 'glowny' : 'poboczny'}
              onPress={() => setTryb(tr)}
              style={styles.flex}
            />
          ))}
        </View>
        <Pole
          etykieta={t('dietetyk.kcalPole')}
          value={kcal}
          onChangeText={setKcal}
          placeholder={t('dietetyk.kcalPodpowiedz')}
          inputMode="numeric"
        />
        <View style={styles.rzad}>
          <View style={styles.flex}>
            <Pole etykieta={t('dietetyk.bialkoProcent')} value={bialko} onChangeText={setBialko} inputMode="numeric" />
          </View>
          <View style={styles.flex}>
            <Pole etykieta={t('dietetyk.tluszczProcent')} value={tluszcz} onChangeText={setTluszcz} inputMode="numeric" />
          </View>
          <View style={styles.flex}>
            <Pole etykieta={t('dietetyk.wegleProcent')} value={wegle} onChangeText={setWegle} inputMode="numeric" />
          </View>
        </View>
        {!procentyPoprawne && (
          <ThemedText type="small" themeColor="accent">
            {t('dietetyk.sumaProcent', { suma: sumaProcent })}
          </ThemedText>
        )}
        {!kcalPoprawne && (
          <ThemedText type="small" themeColor="accent">
            {t('dietetyk.zleKcal')}
          </ThemedText>
        )}
        {podglad && (
          <>
            <KafleWyniku cel={podglad} />
            {przemiana && podglad.kcal < przemiana && (
              <ThemedText type="small" themeColor="accent">
                {t('dietetyk.ponizejPrzemiany', { przemiana })}
              </ThemedText>
            )}
          </>
        )}
        <Przycisk
          tytul={t('dietetyk.zapiszCel')}
          ikona="checkmark"
          onPress={zapisz}
          zajety={zajety}
          wylaczony={!procentyPoprawne || !kcalPoprawne}
        />
        <ThemedText type="small" themeColor="textSecondary">
          {t('dietetyk.zapiszCelOpis')}
        </ThemedText>
      </Karta>

      <TydzienKlienta plan={dane.plan} cel={celObecny} />

      <Karta style={styles.odstep}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('dietetyk.pomiary')}
        </ThemedText>
        {wagi.length === 0 && talie.length === 0 ? (
          <ThemedText type="small" themeColor="textSecondary">
            {t('dietetyk.brakPomiarow')}
          </ThemedText>
        ) : (
          <>
            {wagi.length > 1 && (
              <ThemedText type="small">
                {t('dietetyk.zmianaWagi', {
                  zmiana: liczbaNaTekst(wagi[wagi.length - 1].wartosc - wagi[0].wartosc, 1),
                  od: data(wagi[0].data),
                })}
              </ThemedText>
            )}
            {[...dane.pomiary].reverse().slice(0, 10).map((p) => (
              <View key={`${p.typ}-${p.data}`} style={styles.wierszPomiaru}>
                <ThemedText type="small" themeColor="textSecondary">
                  {data(p.data)}
                </ThemedText>
                <ThemedText type="small">
                  {p.typ === 'waga' ? t('dietetyk.waga') : t('dietetyk.talia')}: {liczbaNaTekst(p.wartosc, 1)}{' '}
                  {p.typ === 'waga' ? 'kg' : 'cm'}
                </ThemedText>
              </View>
            ))}
          </>
        )}
      </Karta>

      <Karta style={styles.odstep}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('dietetyk.wykluczone')}
        </ThemedText>
        <ThemedText type="small">
          {dane.wykluczone.length > 0 ? dane.wykluczone.join(', ') : t('dietetyk.brakWykluczen')}
        </ThemedText>
      </Karta>

      <SchematyKlienta profilId={profil.id} />

      <Karta style={styles.odstep}>
        {pytanieOKoniec ? (
          <>
            <ThemedText type="small" themeColor="accent">
              {t('dietetyk.zakonczPytanie', { imie: profil.imie })}
            </ThemedText>
            <Przycisk tytul={t('dietetyk.zakonczTak')} onPress={zakoncz} />
            <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={() => setPytanieOKoniec(false)} />
          </>
        ) : (
          <Przycisk
            tytul={t('dietetyk.zakoncz')}
            ikona="close-circle-outline"
            wariant="poboczny"
            onPress={() => setPytanieOKoniec(true)}
          />
        )}
        <ThemedText type="small" themeColor="textSecondary" style={{ color: motyw.textSecondary }}>
          {t('dietetyk.zakonczOpis')}
        </ThemedText>
      </Karta>
    </>
  );
}

// ---------------------------------------------------------------------------
//  Tydzień planu klienta
// ---------------------------------------------------------------------------

function TydzienKlienta({
  plan,
  cel,
}: {
  plan: DaneKlienta['plan'];
  cel: { kcal: number; bialko: number; tluszcz: number; wegle: number } | null;
}) {
  const { t } = useTranslation();
  const motyw = useTheme();

  const dni = useMemo(() => {
    if (!plan) return [];
    const start = new Date(plan.data_start);
    return Array.from({ length: plan.dni }, (_, i) => {
      const d = new Date(start);
      d.setDate(d.getDate() + i);
      return d.toISOString().slice(0, 10);
    });
  }, [plan]);

  if (!plan) {
    return (
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('dietetyk.plan')}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('dietetyk.brakPlanu')}
        </ThemedText>
      </Karta>
    );
  }

  return (
    <Karta style={styles.odstep}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        {t('dietetyk.planOd', { data: data(plan.data_start) })}
      </ThemedText>
      <ThemedText type="small" themeColor="textSecondary">
        {t('dietetyk.planOpis')}
      </ThemedText>
      {dni.map((dzien) => {
        const pozycje = plan.pozycje.filter((p) => p.data === dzien);
        // Ta sama suma co na ekranie Plan (jeden talerz na pozycję).
        const suma = sumujDzien(pozycje);
        const roznica = cel ? Math.round(suma.kcal - cel.kcal) : null;
        return (
          <View key={dzien} style={[styles.dzien, { borderColor: motyw.border }]}>
            <View style={styles.naglowekDnia}>
              <ThemedText type="smallBold" style={styles.flex}>
                {opisDnia(dzien)}
              </ThemedText>
              {pozycje.length > 0 && (
                <ThemedText type="small" themeColor={roznica !== null && Math.abs(roznica) > 150 ? 'accent' : 'textSecondary'}>
                  {Math.round(suma.kcal)} kcal
                  {cel ? ` / ${cel.kcal}` : ''}
                </ThemedText>
              )}
            </View>
            {pozycje.length === 0 ? (
              <ThemedText type="small" themeColor="textSecondary">
                {t('dietetyk.pustyDzien')}
              </ThemedText>
            ) : (
              <>
                {[...PORY, 'dodatek' as const].map((pora) =>
                  pozycje
                    .filter((p) => p.pora === pora)
                    .map((p: PozycjaPlanuKlienta, i) => (
                      <View key={`${pora}-${i}`} style={styles.posilek}>
                        <ThemedText type="small" themeColor="textSecondary" style={styles.pora}>
                          {t(`pora.${pora}`)}
                        </ThemedText>
                        <ThemedText type="small" style={styles.flex}>
                          {p.nazwa}
                          {p.zjedzone ? ' ✓' : ''}
                        </ThemedText>
                        <ThemedText type="small" themeColor="textSecondary">
                          {Math.round(p.kcal)}
                        </ThemedText>
                      </View>
                    ))
                )}
                <ThemedText type="small" themeColor="textSecondary">
                  <ThemedText type="small" style={{ color: KOLOR_MAKRO.bialko }}>
                    B {Math.round(suma.bialko)}
                    {cel ? `/${cel.bialko}` : ''} g
                  </ThemedText>
                  {'  '}
                  <ThemedText type="small" style={{ color: KOLOR_MAKRO.tluszcz }}>
                    T {Math.round(suma.tluszcz)}
                    {cel ? `/${cel.tluszcz}` : ''} g
                  </ThemedText>
                  {'  '}
                  <ThemedText type="small" style={{ color: KOLOR_MAKRO.wegle }}>
                    W {Math.round(suma.wegle)}
                    {cel ? `/${cel.wegle}` : ''} g
                  </ThemedText>
                </ThemedText>
              </>
            )}
          </View>
        );
      })}
    </Karta>
  );
}

const styles = StyleSheet.create({
  dwieKolumny: { flexDirection: 'row', alignItems: 'flex-start', gap: Spacing.four },
  lewa: { width: 340 },
  prawa: { flex: 1, minWidth: 0 },
  kolumna: { gap: Spacing.three },
  kolumnaSzeroka: { maxWidth: 820 },
  odstep: { gap: Spacing.two },
  kod: { letterSpacing: 6 },
  naglowekListy: { marginTop: Spacing.two },
  klient: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
    padding: Spacing.three,
    borderWidth: 1,
    borderRadius: 12,
  },
  inicjal: { width: 40, height: 40, borderRadius: 20, alignItems: 'center', justifyContent: 'center' },
  flex: { flex: 1 },
  rzad: { flexDirection: 'row', gap: Spacing.two },
  wierszPomiaru: { flexDirection: 'row', justifyContent: 'space-between', gap: Spacing.two },
  dzien: { borderTopWidth: 1, paddingTop: Spacing.two, gap: Spacing.one },
  naglowekDnia: { flexDirection: 'row', alignItems: 'center', gap: Spacing.two },
  posilek: { flexDirection: 'row', gap: Spacing.two, alignItems: 'baseline' },
  pora: { width: 84 },
});
