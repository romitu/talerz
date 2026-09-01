import { Ionicons } from '@expo/vector-icons';
import { Image } from 'expo-image';
import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { RozkladPosilku, type UdzialOsoby } from '@/components/rozklad-posilku';
import { WierszMakro } from '@/components/wiersz-makro';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { celZywieniowyNASEM, type PalNasem } from '@/lib/nasem';
import { wroc } from '@/lib/nawigacja';
import {
  czasRazem,
  opisTrwalosci,
  pobierzPelnyPrzepis,
  pobierzPrzepisy,
  type PelnyPrzepis,
  type PrzepisZMakro,
} from '@/lib/przepisy';
import { pobierzPrzeskalowanyPrzepis, type PrzeskalowanyPrzepis } from '@/lib/przepisy-skalowane';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import { adresZdjecia } from '@/lib/zdjecia';
import { wiekZDaty, type Plec, type TrybCelu } from '@/lib/zywienie';

type ProfilZCelem = {
  id: string;
  imie: string;
  plec: Plec;
  data_urodzenia: string;
  wzrost_cm: number;
  aktywnosc: PalNasem;
  cele: {
    tryb: TrybCelu;
    bialko_procent: number;
    tluszcz_procent: number;
    wegle_procent: number;
  }[];
};

/**
 * Przepis do czytania przy garnku.
 *
 * Czym się różni od formularza
 * ----------------------------
 * Formularz służy do wpisywania i ma pola, przyciski i tabele. Ten ekran
 * służy do gotowania: duże kroki, gramatury pod ręką, żadnych elementów,
 * które da się przypadkiem nacisnąć mokrą dłonią.
 *
 * Dwie decyzje wynikają wprost z tego, że stoisz przy kuchence
 * ------------------------------------------------------------
 *   * Kroki można odhaczać. Odchodzisz do lodówki, wracasz i wiesz, gdzie
 *     byłeś. Odhaczenia siedzą tylko w pamięci ekranu — nie trafiają do bazy,
 *     bo dotyczą tego jednego gotowania, nie przepisu.
 *
 *   * Składniki i sprzęt są NAD krokami. Zanim zaczniesz, chcesz wiedzieć,
 *     czy masz wszystko i czy trzeba wyjąć blender.
 */
export default function EkranPrzepisu() {
  const { id, skalowany, powrot, porcjeRazem } = useLocalSearchParams<{
    id: string;
    /** Ustawione, gdy wchodzimy z planu na konkretny przeskalowany wariant (migracja 0036). */
    skalowany?: string;
    powrot?: string;
    /**
     * Ile porcji trzeba ugotować NARAZ dla tej konkretnej partii z planu —
     * dni, na które rozłożono garnek, razy jedzący. Ustawione tylko przy
     * wejściu z planu (patrz `app/index.tsx`); przy wejściu z katalogu
     * przepisów go nie ma i pokazujemy ilości bazowe, jak dawniej.
     */
    porcjeRazem?: string;
  }>();
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [przepis, setPrzepis] = useState<PelnyPrzepis | null>(null);
  const [makro, setMakro] = useState<PrzepisZMakro | null>(null);
  const [wariant, setWariant] = useState<PrzeskalowanyPrzepis | null>(null);
  const [zrobione, setZrobione] = useState<Set<string>>(new Set());
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);
  const [udzialyOsob, setUdzialyOsob] = useState<
    Omit<UdzialOsoby, 'kcal' | 'bialko_g' | 'tluszcz_g' | 'wegle_g' | 'blonnik_g'>[] | null
  >(null);

  const pobierz = useCallback(async () => {
    if (!id) return;
    setWczytywanie(true);
    setBlad(null);
    try {
      const [pelny, wszystkie, przeskalowany] = await Promise.all([
        pobierzPelnyPrzepis(id),
        pobierzPrzepisy(sesja?.user.id),
        skalowany ? pobierzPrzeskalowanyPrzepis(skalowany) : Promise.resolve(null),
      ]);
      setPrzepis(pelny);
      setMakro(wszystkie.find((p) => p.id === id) ?? null);
      setWariant(przeskalowany);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [id, skalowany, sesja?.user.id]);

  /*
    Udział każdej osoby w tym posiłku — niezależny blok, we własnym
    try/catch, tak jak liczenie jedzących w `app/index.tsx`: awaria tutaj
    (brak wagi, brzegowy przypadek w wyliczeniu celu) nie ma prawa schować
    samego przepisu, po który ktoś tu wszedł.
  */
  const pobierzUdzialy = useCallback(async () => {
    try {
      const wynikProfili = await supabase
        .from('profile')
        .select('id, imie, plec, data_urodzenia, wzrost_cm, aktywnosc, cele (tryb, bialko_procent, tluszcz_procent, wegle_procent)')
        .order('kolejnosc')
        .order('obowiazuje_od', { foreignTable: 'cele', ascending: false })
        .limit(1, { foreignTable: 'cele' });
      if (wynikProfili.error) throw wynikProfili.error;

      const listaProfili = (wynikProfili.data ?? []) as ProfilZCelem[];
      if (listaProfili.length < 2) {
        setUdzialyOsob(null);
        return;
      }

      const zCelami = (
        await Promise.all(
          listaProfili.map(async (p) => {
            const zapis = p.cele?.[0];
            if (!zapis) return null;
            const wynikWagi = await supabase
              .from('pomiary')
              .select('wartosc')
              .eq('profil_id', p.id)
              .eq('typ', 'waga')
              .order('data', { ascending: false })
              .limit(1)
              .maybeSingle();
            if (wynikWagi.error || !wynikWagi.data) return null;

            const cel = celZywieniowyNASEM(
              p.plec,
              wiekZDaty(p.data_urodzenia),
              p.wzrost_cm,
              Number(wynikWagi.data.wartosc),
              p.aktywnosc,
              zapis.tryb,
              { bialko: zapis.bialko_procent, tluszcz: zapis.tluszcz_procent, wegle: zapis.wegle_procent }
            );
            return { id: p.id, imie: p.imie, kcal: cel.kcal };
          })
        )
      ).filter((x): x is { id: string; imie: string; kcal: number } => x !== null);

      const sumaKcal = zCelami.reduce((s, o) => s + o.kcal, 0);
      if (zCelami.length < 2 || sumaKcal <= 0) {
        setUdzialyOsob(null);
        return;
      }

      setUdzialyOsob(zCelami.map((o) => ({ id: o.id, imie: o.imie, udzial: o.kcal / sumaKcal })));
    } catch {
      setUdzialyOsob(null);
    }
  }, []);

  useFocusEffect(
    useCallback(() => {
      pobierz();
      pobierzUdzialy();
    }, [pobierz, pobierzUdzialy])
  );

  function przelacz(klucz: string) {
    setZrobione((poprzednie) => {
      const nowe = new Set(poprzednie);
      if (nowe.has(klucz)) nowe.delete(klucz);
      else nowe.add(klucz);
      return nowe;
    });
  }

  if (wczytywanie) {
    return (
      <Ekran tytul="Przepis">
        <ThemedText type="small" themeColor="textSecondary">
          Wczytywanie…
        </ThemedText>
      </Ekran>
    );
  }

  if (blad || !przepis) {
    return (
      <Ekran tytul="Przepis">
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad ?? 'Nie znaleziono przepisu.'}
          </ThemedText>
        </Karta>
        <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/')} />
      </Ekran>
    );
  }

  const zdjecie = adresZdjecia(przepis.zdjecie);
  const czas = czasRazem(przepis.czas_przygotowania_min, przepis.czas_obrobki_min);
  const krokowRazem = przepis.etapy.reduce((s, e) => s + e.kroki.length, 0);

  // Ten posiłek w planie jest wariantem skalowanym (migracja 0036) — pokazujemy
  // ilości, jakie FAKTYCZNIE wyszły z przeliczenia, nie bazowy przepis
  // źródłowy. Etapy, sprzęt i reszta treści zostają z przepisu — skalowanie
  // dotyczy wyłącznie ilości składników.
  const wariantSkladnikow = wariant ? new Map(wariant.skladniki.map((s) => [s.skladnik_id, s])) : null;

  // Ile razy więcej niż bazowa ilość trzeba ugotować dla TEJ partii z planu —
  // np. „wytrzyma 3 dni w lodówce” przy 1 osobie i przepisie bazowanym na
  // 1 porcji daje mnożnik ×3.
  //
  // Wariant skalowany (migracja 0036) potrzebuje INNEGO wzoru niż zwykłe
  // danie: jego ilości w bazie reprezentują już dokładnie JEDNĄ porcję (jedną
  // osobę, jeden posiłek) — `celKcal` w automacie to cel na osobę, nie na całą
  // partię, patrz `zapiszWstawienia` w `app/index.tsx`. Dzielenie przez
  // `porcje_wyliczone` (bazowa liczba porcji ZWYKŁEGO przepisu) byłoby więc
  // błędne; mnożnik to po prostu `porcjeRazem` wprost.
  const mnoznikPorcji = wariant
    ? Number(porcjeRazem ?? 1) || 1
    : porcjeRazem && makro?.porcje_wyliczone
      ? Number(porcjeRazem) / makro.porcje_wyliczone
      : 1;
  const skalujPorcje = Math.abs(mnoznikPorcji - 1) > 0.01;

  const skladnikiDoPokazania = wariantSkladnikow
    ? przepis.skladniki.map((s) => {
        const nadpisany = wariantSkladnikow.get(s.skladnik_id);
        return nadpisany
          ? {
              ...s,
              ilosc: nadpisany.ilosc * mnoznikPorcji,
              jednostka: nadpisany.jednostka,
              gramy: nadpisany.gramy * mnoznikPorcji,
            }
          : s;
      })
    : skalujPorcje
      ? przepis.skladniki.map((s) => ({
          ...s,
          ilosc: s.ilosc * mnoznikPorcji,
          gramy: s.gramy * mnoznikPorcji,
        }))
      : przepis.skladniki;

  const makroDoPokazania = wariant?.makro
    ? {
        kcal: wariant.makro.kcal,
        bialko_g: wariant.makro.bialko_g,
        tluszcz_g: wariant.makro.tluszcz_g,
        wegle_g: wariant.makro.wegle_g,
        blonnik_g: wariant.makro.blonnik_g,
        porcje_wyliczone: null as number | null,
        gramy_calosc: null as number | null,
      }
    : makro;

  // Ile z TEJ porcji zjada każda osoba — jedna „porcja" w planie odpowiada
  // jednemu profilowi (patrz `porcje: osoby` w `zapiszWstawienia`,
  // `app/index.tsx`), więc razem wszyscy zjadają `makroDoPokazania` pomnożone
  // przez liczbę osób z udziałem. To dzielimy dalej proporcjonalnie do
  // dziennego zapotrzebowania, zamiast po równo.
  const kcalNaPorcje = makroDoPokazania?.kcal;
  const rozkladPosilku =
    udzialyOsob && kcalNaPorcje != null
      ? udzialyOsob.map((o) => ({
          ...o,
          kcal: Math.round(kcalNaPorcje * udzialyOsob.length * o.udzial),
          bialko_g: Math.round((makroDoPokazania!.bialko_g ?? 0) * udzialyOsob.length * o.udzial),
          tluszcz_g: Math.round((makroDoPokazania!.tluszcz_g ?? 0) * udzialyOsob.length * o.udzial),
          wegle_g: Math.round((makroDoPokazania!.wegle_g ?? 0) * udzialyOsob.length * o.udzial),
          blonnik_g: Math.round((makroDoPokazania!.blonnik_g ?? 0) * udzialyOsob.length * o.udzial),
        }))
      : null;

  return (
    <Ekran
      tytul={przepis.nazwa}
      podtytul={[
        czas ? `${czas} min` : null,
        wariant?.makro
          ? `porcja ${Math.round(wariant.makro.gramy_porcji)} g (przeliczona)`
          : przepis.porcja_g
            ? `porcja ${przepis.porcja_g} g`
            : null,
        opisTrwalosci(makro?.trwalosc_dni ?? przepis.trwalosc_dni),
      ]
        .filter(Boolean)
        .join(' · ')}>
      {rozkladPosilku && rozkladPosilku.length > 1 && <RozkladPosilku osoby={rozkladPosilku} />}

      {zdjecie && (
        <Image source={{ uri: zdjecie }} style={styles.zdjecie} contentFit="cover" transition={150} />
      )}

      {przepis.opis && (
        <Karta>
          <ThemedText type="small" themeColor="textSecondary">
            {przepis.opis}
          </ThemedText>
        </Karta>
      )}

      {wariant && (
        <Karta>
          <ThemedText type="smallBold" themeColor="accent">
            PRZELICZONE DLA TEGO POSIŁKU
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Ilości na osobę są przeskalowane pod cel {wariant.cel_kcal} kcal (współczynnik ×
            {Math.round(wariant.wspolczynnik_k * 100) / 100}) — inne niż w katalogu przepisów.
          </ThemedText>
        </Karta>
      )}

      {skalujPorcje && (
        <Karta>
          <ThemedText type="smallBold" themeColor="accent">
            PRZELICZONE NA CAŁĄ PARTIĘ
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {wariant
              ? `Ten garnek ma starczyć na ${Math.round(Number(porcjeRazem ?? 0) * 10) / 10} porcji (osoby × dni w lodówce) — ilości niżej są przemnożone ×${Math.round(mnoznikPorcji * 100) / 100} względem jednej porcji wyżej.`
              : `Ten garnek ma starczyć na ${Math.round(Number(porcjeRazem ?? 0) * 10) / 10} porcji zamiast ${makro?.porcje_wyliczone} bazowych — ilości niżej są przemnożone ×${Math.round(mnoznikPorcji * 100) / 100}.`}
          </ThemedText>
        </Karta>
      )}

      {makroDoPokazania?.kcal != null && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {wariant ? 'TEN POSIŁEK' : 'NA PORCJĘ'}
          </ThemedText>
          <WierszMakro
            pozycje={[
              { etykieta: 'kcal', wartosc: makroDoPokazania.kcal, jednostka: '' },
              { etykieta: 'białko', wartosc: makroDoPokazania.bialko_g ?? 0, jednostka: ' g' },
              { etykieta: 'tłuszcz', wartosc: makroDoPokazania.tluszcz_g ?? 0, jednostka: ' g' },
              { etykieta: 'węgle', wartosc: makroDoPokazania.wegle_g ?? 0, jednostka: ' g' },
              { etykieta: 'błonnik', wartosc: makroDoPokazania.blonnik_g ?? 0, jednostka: ' g' },
            ]}
          />
          {makroDoPokazania.porcje_wyliczone && (
            <ThemedText type="small" themeColor="textSecondary">
              Z całego garnka wychodzi {Math.round(makroDoPokazania.porcje_wyliczone * 10) / 10} porcji
              {makroDoPokazania.gramy_calosc ? ` (${makroDoPokazania.gramy_calosc} g razem)` : ''}.
            </ThemedText>
          )}
        </Karta>
      )}

      {/* --- sprzęt: zanim zaczniesz ------------------------------------- */}
      {przepis.sprzet.length > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            WYJMIJ Z SZAFKI
          </ThemedText>
          <ThemedText type="default">{przepis.sprzet.join(' · ')}</ThemedText>
        </Karta>
      )}

      {/* --- składniki ---------------------------------------------------- */}
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          SKŁADNIKI ({skladnikiDoPokazania.length})
        </ThemedText>
        {skladnikiDoPokazania.map((s) => {
          const klucz = `s:${s.skladnik_id}`;
          const odhaczony = zrobione.has(klucz);
          return (
            <Pressable
              key={klucz}
              onPress={() => przelacz(klucz)}
              accessibilityRole="checkbox"
              accessibilityState={{ checked: odhaczony }}
              style={({ pressed }) => [styles.pozycja, pressed && styles.wcisniete]}>
              <Ionicons
                name={odhaczony ? 'checkbox' : 'square-outline'}
                size={20}
                color={odhaczony ? motyw.accent : motyw.textSecondary}
              />
              <View style={styles.trescPozycji}>
                <ThemedText
                  type="default"
                  themeColor={odhaczony ? 'textSecondary' : 'text'}>
                  {s.nazwa}
                </ThemedText>
                {(s.stan || s.zamiennik) && (
                  <ThemedText type="small" themeColor="textSecondary">
                    {[s.stan, s.zamiennik].filter(Boolean).join(' · ')}
                  </ThemedText>
                )}
              </View>
              <ThemedText type="smallBold" themeColor="textSecondary" style={styles.ilosc}>
                {opisIlosci(s)}
              </ThemedText>
            </Pressable>
          );
        })}
      </Karta>

      {/* --- etapy i kroki ------------------------------------------------ */}
      {przepis.etapy.map((etap, ie) => (
        <Karta key={`e${ie}`}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {etap.nazwa.toUpperCase()}
            {etap.minuty ? ` · ${etap.minuty} min` : ''}
          </ThemedText>
          {etap.kroki.map((krok, ik) => {
            const klucz = `k:${ie}:${ik}`;
            const odhaczony = zrobione.has(klucz);
            return (
              <Pressable
                key={klucz}
                onPress={() => przelacz(klucz)}
                accessibilityRole="checkbox"
                accessibilityState={{ checked: odhaczony }}
                style={({ pressed }) => [styles.krok, pressed && styles.wcisniete]}>
                <Ionicons
                  name={odhaczony ? 'checkmark-circle' : 'ellipse-outline'}
                  size={24}
                  color={odhaczony ? motyw.accent : motyw.textSecondary}
                />
                <View style={styles.trescPozycji}>
                  <ThemedText
                    type="default"
                    themeColor={odhaczony ? 'textSecondary' : 'text'}>
                    {krok.tresc}
                  </ThemedText>
                  {krok.sygnal && (
                    <ThemedText type="small" themeColor="textSecondary">
                      Po czym poznać: {krok.sygnal}
                    </ThemedText>
                  )}
                  {krok.uwaga && (
                    <ThemedText type="smallBold" themeColor="accent">
                      Uwaga — tego kroku nie pomijaj.
                    </ThemedText>
                  )}
                </View>
              </Pressable>
            );
          })}
        </Karta>
      ))}

      {/* --- po ugotowaniu ------------------------------------------------ */}
      {(przepis.przechowywanie || przepis.mozna_mrozic !== null) && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            PO UGOTOWANIU
          </ThemedText>
          {przepis.przechowywanie && (
            <ThemedText type="default">{przepis.przechowywanie}</ThemedText>
          )}
          <ThemedText type="small" themeColor="textSecondary">
            {przepis.mozna_mrozic ? 'Można mrozić.' : 'Nie nadaje się do mrożenia.'}
          </ThemedText>
        </Karta>
      )}

      {przepis.ratunek && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            GDY COŚ PÓJDZIE NIE TAK
          </ThemedText>
          <ThemedText type="default">{przepis.ratunek}</ThemedText>
        </Karta>
      )}

      {zrobione.size > 0 && (
        <Przycisk
          tytul={`Odznacz wszystko (${zrobione.size} z ${skladnikiDoPokazania.length + krokowRazem})`}
          wariant="poboczny"
          onPress={() => setZrobione(new Set())}
        />
      )}

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/')} />
    </Ekran>
  );
}

/**
 * Ilość tak, jak się ją odmierza.
 *
 * Przy sztukach pokazujemy jedno i drugie: „2 szt (140 g)”. Przy garnku
 * bierzesz dwie marchewki, ale gdy chcesz odważyć — masz gramy pod ręką.
 */
export function opisIlosci(s: {
  ilosc: number;
  jednostka: 'g' | 'ml' | 'szt';
  gramy: number;
}): string {
  const liczba = (x: number) =>
    (Math.round(x * 100) / 100).toString().replace('.', ',');

  if (s.jednostka === 'szt') return `${liczba(s.ilosc)} szt (${liczba(s.gramy)} g)`;
  return `${liczba(s.ilosc)} ${s.jednostka}`;
}

const styles = StyleSheet.create({
  zdjecie: {
    width: '100%',
    aspectRatio: 16 / 9,
    borderRadius: Spacing.two,
  },
  pozycja: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    paddingVertical: Spacing.one,
  },
  krok: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    paddingVertical: Spacing.two,
  },
  trescPozycji: { flex: 1, gap: 2 },
  ilosc: { minWidth: 96, textAlign: 'right' },
  wcisniete: { opacity: 0.6 },
});
