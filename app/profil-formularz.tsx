import { Ionicons } from '@expo/vector-icons';
import { useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { Ekran } from '@/components/ekran';
import { KafleWyniku } from '@/components/kafle-wyniku';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { calkowityWydatekNASEM, celZywieniowyNASEM, OPIS_PAL, type PalNasem } from '@/lib/nasem';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import {
  DEFICYT_REDUKCJI_KCAL,
  dataUrodzeniaZWieku,
  oceniaCele,
  podpowiedzBlonnika,
  podpowiedzProguBialka,
  przemianaPodstawowa,
  wiekZDaty,
  wskazowkaWodna,
  type Plec,
  type TrybCelu,
} from '@/lib/zywienie';

/**
 * Edytuj profil — przeprojektowany wg makiety „Ustal Swoje Cele RB.html”.
 *
 * Użytkownik wpisuje WYŁĄCZNIE to, co ma makieta: płeć, wiek, wzrost, wagę,
 * jeden z czterech poziomów aktywności NASEM i tryb celu. Kcal i makra liczy
 * lib/nasem.ts — nie ma tu już ręcznego ustawiania proporcji makro (zawsze
 * domyślne 25/30/45, jak w bibliotece), błonnika ani progu białka na posiłek
 * — te dwa ostatnie zapisują się automatycznie z podpowiedzi, bo ekran Plan
 * dalej ich potrzebuje do pokazywania postępu.
 *
 * Imię zostaje, mimo że go nie ma w makiecie — baza go wymaga (`profile.imie
 * not null`) i bez niego lista kilku profili na koncie byłaby nie do
 * odróżnienia.
 *
 * Wiek zamiast daty urodzenia: pole pyta wprost o wiek, ale baza dalej
 * przechowuje datę (`dataUrodzeniaZWieku` w lib/zywienie.ts) — inaczej wiek
 * zamroziłby się w dniu zapisu, tak jak kiedyś kcal (patrz migracja 0026).
 *
 * Obwód talii i ręczne proporcje makro, które miał poprzedni formularz,
 * zniknęły — makieta ich nie przewiduje. Waga została, bo bez niej nie da
 * się nic policzyć.
 */

type Profil = {
  id: string;
  imie: string;
  plec: Plec;
  data_urodzenia: string;
  wzrost_cm: number;
  aktywnosc: PalNasem;
};

type ZapisanyCel = {
  tryb: TrybCelu;
};

/** Zamienia przecinek na kropkę i zwraca liczbę albo null. */
function liczba(tekst: string): number | null {
  const t = tekst.replace(',', '.').trim();
  if (!t) return null;
  const n = Number(t);
  return Number.isFinite(n) ? n : null;
}

/** Płeć jako dwa przyciski obok siebie, nie lista — jak w makiecie. */
function SegmentPlci({ wartosc, onZmiana }: { wartosc: Plec; onZmiana: (p: Plec) => void }) {
  const motyw = useTheme();
  const opcje: { wartosc: Plec; etykieta: string; ikona: 'female' | 'male' }[] = [
    { wartosc: 'K', etykieta: 'Kobieta', ikona: 'female' },
    { wartosc: 'M', etykieta: 'Mężczyzna', ikona: 'male' },
  ];

  return (
    <View style={styleWyboru.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        Płeć
      </ThemedText>
      <View style={[styleWyboru.segmenty, { borderColor: motyw.border }]}>
        {opcje.map((o, i) => {
          const aktywna = o.wartosc === wartosc;
          return (
            <Pressable
              key={o.wartosc}
              onPress={() => onZmiana(o.wartosc)}
              accessibilityRole="radio"
              accessibilityState={{ selected: aktywna }}
              style={[
                styleWyboru.segment,
                i > 0 && { borderLeftWidth: 1, borderLeftColor: motyw.border },
                aktywna && { backgroundColor: motyw.backgroundSelected },
              ]}>
              <Ionicons name={o.ikona} size={18} color={aktywna ? motyw.accent : motyw.textSecondary} />
              <ThemedText type={aktywna ? 'smallBold' : 'small'} themeColor={aktywna ? 'accent' : 'text'}>
                {o.etykieta}
              </ThemedText>
            </Pressable>
          );
        })}
      </View>
    </View>
  );
}

const IKONY_PAL: Record<PalNasem, keyof typeof Ionicons.glyphMap> = {
  nieaktywny: 'body-outline',
  malo_aktywny: 'walk-outline',
  aktywny: 'bicycle-outline',
  bardzo_aktywny: 'barbell-outline',
};

/** Cztery kafle aktywności w siatce 2x2 — jak w makiecie, zamiast listy. */
function SiatkaAktywnosci({ wartosc, onZmiana }: { wartosc: PalNasem; onZmiana: (p: PalNasem) => void }) {
  const motyw = useTheme();

  return (
    <View style={styleWyboru.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        Aktywność
      </ThemedText>
      <View style={styleWyboru.siatka}>
        {(Object.keys(OPIS_PAL) as PalNasem[]).map((k) => {
          const aktywna = k === wartosc;
          return (
            <Pressable
              key={k}
              onPress={() => onZmiana(k)}
              accessibilityRole="radio"
              accessibilityState={{ selected: aktywna }}
              accessibilityLabel={`${OPIS_PAL[k].nazwa}. ${OPIS_PAL[k].opis}`}
              style={[
                styleWyboru.kafelAktywnosci,
                {
                  borderColor: aktywna ? motyw.accent : motyw.border,
                  backgroundColor: aktywna ? motyw.backgroundSelected : motyw.backgroundElement,
                },
              ]}>
              <Ionicons name={IKONY_PAL[k]} size={26} color={aktywna ? motyw.accent : motyw.textSecondary} />
              <ThemedText type={aktywna ? 'smallBold' : 'small'} themeColor={aktywna ? 'accent' : 'text'}>
                {OPIS_PAL[k].nazwa}
              </ThemedText>
            </Pressable>
          );
        })}
      </View>
    </View>
  );
}

/** Dwie karty celu obok siebie, z ptaszkiem na aktywnej — jak w makiecie. */
function KartyCelu({
  wartosc,
  onZmiana,
  opisRedukcji,
}: {
  wartosc: TrybCelu;
  onZmiana: (t: TrybCelu) => void;
  opisRedukcji: string;
}) {
  const motyw = useTheme();
  const opcje: { wartosc: TrybCelu; tytul: string; opis: string; ikona: keyof typeof Ionicons.glyphMap }[] = [
    {
      wartosc: 'utrzymanie',
      tytul: 'Utrzymanie wagi',
      opis: 'Cel = pełne zapotrzebowanie dzienne, bez deficytu.',
      ikona: 'shield-checkmark-outline',
    },
    { wartosc: 'redukcja', tytul: 'Redukcja wagi', opis: opisRedukcji, ikona: 'trending-down-outline' },
  ];

  return (
    <View style={styleWyboru.grupa}>
      <ThemedText type="smallBold" themeColor="textSecondary">
        Cel
      </ThemedText>
      <View style={styleWyboru.karyCelu}>
        {opcje.map((o) => {
          const aktywna = o.wartosc === wartosc;
          return (
            <Pressable
              key={o.wartosc}
              onPress={() => onZmiana(o.wartosc)}
              accessibilityRole="radio"
              accessibilityState={{ selected: aktywna }}
              style={[
                styleWyboru.kartaCelu,
                {
                  borderColor: aktywna ? motyw.accent : motyw.border,
                  backgroundColor: aktywna ? motyw.backgroundSelected : motyw.backgroundElement,
                },
              ]}>
              {aktywna && (
                <Ionicons name="checkmark-circle" size={18} color={motyw.accent} style={styleWyboru.ptaszekCelu} />
              )}
              <Ionicons name={o.ikona} size={28} color={aktywna ? motyw.accent : motyw.textSecondary} />
              <View style={styleWyboru.opisCelu}>
                <ThemedText type={aktywna ? 'smallBold' : 'small'} themeColor={aktywna ? 'accent' : 'text'}>
                  {o.tytul}
                </ThemedText>
                <ThemedText type="small" themeColor="textSecondary" style={styleWyboru.tekstCelu}>
                  {o.opis}
                </ThemedText>
              </View>
            </Pressable>
          );
        })}
      </View>
    </View>
  );
}


export default function FormularzProfilu() {
  const { profil: profilId, powrot } = useLocalSearchParams<{ profil?: string; powrot?: string }>();
  const { sesja } = useSesja();
  const trybEdycji = Boolean(profilId);

  const [imie, setImie] = useState('');
  const [plec, setPlec] = useState<Plec>('M');
  const [wiek, setWiek] = useState('');
  const [wzrost, setWzrost] = useState('');
  const [waga, setWaga] = useState('');
  const [aktywnosc, setAktywnosc] = useState<PalNasem>('aktywny');
  const [celeTryb, setCeleTryb] = useState<TrybCelu>('utrzymanie');

  const [wczytywanie, setWczytywanie] = useState(trybEdycji);
  const [nieZnaleziono, setNieZnaleziono] = useState(false);
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    if (!profilId) return;
    setWczytywanie(true);

    const [wynikProfilu, wynikWagi, wynikCelu] = await Promise.all([
      supabase
        .from('profile')
        .select('id, imie, plec, data_urodzenia, wzrost_cm, aktywnosc')
        .eq('id', profilId)
        .single(),
      supabase
        .from('pomiary')
        .select('wartosc')
        .eq('profil_id', profilId)
        .eq('typ', 'waga')
        .order('data', { ascending: false })
        .limit(1)
        .maybeSingle(),
      supabase.from('cele').select('tryb').eq('profil_id', profilId).order('obowiazuje_od', { ascending: false }).limit(1).maybeSingle(),
    ]);

    if (wynikProfilu.error || !wynikProfilu.data) {
      setNieZnaleziono(true);
    } else {
      const p = wynikProfilu.data as Profil;
      setImie(p.imie);
      setPlec(p.plec);
      setWiek(String(wiekZDaty(p.data_urodzenia)));
      setWzrost(String(p.wzrost_cm));
      setAktywnosc(p.aktywnosc);
    }

    if (wynikWagi.data) setWaga(String(wynikWagi.data.wartosc));
    if (wynikCelu.data) setCeleTryb((wynikCelu.data as ZapisanyCel).tryb);

    setWczytywanie(false);
  }, [profilId]);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  const wiekL = liczba(wiek);
  const wzrostL = liczba(wzrost);
  const wagaL = liczba(waga);

  const komplet = Boolean(imie.trim() && wiekL !== null && wzrostL && wagaL);

  // Kcal i gramy liczą się na bieżąco z pól formularza — podgląd jest zawsze
  // aktualny, nawet zanim cokolwiek zapiszesz, i nigdy nie jest zamrożoną
  // liczbą z chwili zapisu.
  const podglad =
    komplet && wiekL !== null && wzrostL && wagaL
      ? {
          przemiana: przemianaPodstawowa(plec, wagaL, wzrostL, wiekL),
          zapotrzebowanie: calkowityWydatekNASEM(plec, wiekL, wzrostL, wagaL, aktywnosc),
        }
      : null;

  const cel =
    podglad && wiekL !== null && wzrostL && wagaL
      ? celZywieniowyNASEM(plec, wiekL, wzrostL, wagaL, aktywnosc, celeTryb)
      : null;
  const ocena = podglad && cel ? oceniaCele(cel, podglad.przemiana, podglad.zapotrzebowanie) : null;

  const wolnoZapisac = komplet && (ocena?.blokady.length ?? 1) === 0;

  const deficyt = podglad ? Math.min(DEFICYT_REDUKCJI_KCAL, podglad.zapotrzebowanie - podglad.przemiana) : null;
  const opisRedukcji =
    deficyt !== null
      ? `Cel = zapotrzebowanie minus ${deficyt} kcal (nie mniej niż przemiana podstawowa).`
      : 'Cel = zapotrzebowanie minus deficyt (nie mniej niż przemiana podstawowa).';

  async function zapisz() {
    setBlad(null);

    if (!sesja) {
      setBlad('Brak zalogowanego użytkownika.');
      return;
    }
    if (!imie.trim()) {
      setBlad('Podaj imię — odróżnia profile na tym samym koncie.');
      return;
    }
    if (wiekL === null || wiekL < 18 || wiekL > 120) {
      setBlad('Wiek podaj w pełnych latach, w zakresie 18–120. Talerz jest przeznaczony wyłącznie dla osób pełnoletnich.');
      return;
    }
    if (!wzrostL || wzrostL < 120 || wzrostL > 230) {
      setBlad('Wzrost podaj w centymetrach, w zakresie 120–230.');
      return;
    }
    if (!wagaL || wagaL < 30 || wagaL > 300) {
      setBlad('Wagę podaj w kilogramach, w zakresie 30–300.');
      return;
    }
    if (ocena && ocena.blokady.length > 0) {
      setBlad(ocena.blokady[0]);
      return;
    }
    if (!cel) return;

    setZajety(true);
    try {
      const dzis = new Date().toISOString().slice(0, 10);
      const dataUrodzenia = dataUrodzeniaZWieku(wiekL);
      let idProfilu: string;

      if (trybEdycji) {
        idProfilu = profilId as string;

        const { error: bladProfilu } = await supabase
          .from('profile')
          .update({
            imie: imie.trim(),
            plec,
            data_urodzenia: dataUrodzenia,
            wzrost_cm: Math.round(wzrostL),
            aktywnosc,
          })
          .eq('id', idProfilu);
        if (bladProfilu) throw bladProfilu;

        // Waga to pomiar z datą — zapis tego samego dnia nadpisuje dzisiejszy
        // wpis zamiast tworzyć duplikat (unikalność po dacie).
        const { error: bladPomiaru } = await supabase
          .from('pomiary')
          .upsert([{ profil_id: idProfilu, typ: 'waga', wartosc: wagaL, data: dzis }], {
            onConflict: 'profil_id,typ,data',
          });
        if (bladPomiaru) throw bladPomiaru;
      } else {
        const { data: profil, error: bladProfilu } = await supabase
          .from('profile')
          .insert({
            konto_id: sesja.user.id,
            imie: imie.trim(),
            plec,
            data_urodzenia: dataUrodzenia,
            wzrost_cm: Math.round(wzrostL),
            aktywnosc,
          })
          .select('id')
          .single();
        if (bladProfilu) throw bladProfilu;
        idProfilu = profil.id;

        const { error: bladPomiaru } = await supabase
          .from('pomiary')
          .insert([{ profil_id: idProfilu, typ: 'waga', wartosc: wagaL }]);
        if (bladPomiaru) throw bladPomiaru;
      }

      const { error: bladCelu } = await supabase.from('cele').upsert(
        {
          profil_id: idProfilu,
          obowiazuje_od: dzis,
          tryb: celeTryb,
          // Proporcje makro nie są już ręcznie ustawiane — zawsze domyślne
          // 25/30/45, jak w lib/nasem.ts. Błonnik i próg białka na posiłek
          // zapisują się z podpowiedzi, bo ekran Plan dalej z nich korzysta.
          bialko_procent: 25,
          tluszcz_procent: 30,
          wegle_procent: 45,
          blonnik_g: podpowiedzBlonnika(cel.kcal),
          prog_bialka_posilek: podpowiedzProguBialka(wagaL),
        },
        { onConflict: 'profil_id,obowiazuje_od' }
      );
      if (bladCelu) throw bladCelu;

      wroc(powrot, '/profil');
    } catch (e) {
      const tresc = komunikatBledu(e);
      setBlad(
        tresc.includes('najwyżej 3 profile')
          ? 'Konto może mieć najwyżej 3 profile.'
          : tresc.includes('pełnoletnich')
            ? 'Talerz jest przeznaczony wyłącznie dla osób pełnoletnich.'
            : tresc
      );
    } finally {
      setZajety(false);
    }
  }

  if (wczytywanie) {
    return (
      <Ekran tytul="Profil">
        <ThemedText type="small" themeColor="textSecondary">
          Wczytywanie…
        </ThemedText>
      </Ekran>
    );
  }

  if (nieZnaleziono) {
    return (
      <Ekran tytul="Profil">
        <Karta>
          <ThemedText type="small" themeColor="accent">
            Nie znaleziono profilu.
          </ThemedText>
        </Karta>
        <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/profil')} />
      </Ekran>
    );
  }

  return (
    <Ekran
      tytul={trybEdycji ? 'Edytuj profil' : 'Nowy profil'}
      podtytul="Podaj kilka informacji, a wyliczymy Twoje dzienne kalorie i makroskładniki.">
      <Karta style={styles.formularz}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          DANE PODSTAWOWE
        </ThemedText>

        <Pole etykieta="Imię" value={imie} onChangeText={setImie} placeholder="Roman" />

        <SegmentPlci wartosc={plec} onZmiana={setPlec} />

        <View style={styles.wierszPol}>
          <View style={styles.pole3}>
            <Pole etykieta="Wiek (lat)" value={wiek} onChangeText={setWiek} placeholder="59" inputMode="numeric" />
          </View>
          <View style={styles.pole3}>
            <Pole etykieta="Wzrost (cm)" value={wzrost} onChangeText={setWzrost} placeholder="189" inputMode="numeric" />
          </View>
          <View style={styles.pole3}>
            <Pole etykieta="Waga (kg)" value={waga} onChangeText={setWaga} placeholder="90" inputMode="decimal" />
          </View>
        </View>
      </Karta>

      <Karta>
        <SiatkaAktywnosci wartosc={aktywnosc} onZmiana={setAktywnosc} />
      </Karta>

      <Karta>
        <KartyCelu wartosc={celeTryb} onZmiana={setCeleTryb} opisRedukcji={opisRedukcji} />
      </Karta>

      {cel && podglad && (
        <Karta style={styles.kartaWyniku}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            TWÓJ WYNIK
          </ThemedText>
          <KafleWyniku cel={cel} />
          <ThemedText type="small" themeColor="textSecondary">
            Na podstawie płci, wieku, wzrostu, wagi, aktywności i celu — wg równań NASEM 2023
            (Dietary Reference Intakes for Energy). Przemiana podstawowa: {podglad.przemiana} kcal
            · zapotrzebowanie dzienne: {podglad.zapotrzebowanie} kcal.
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Automatycznie zapisze się też próg białka na posiłek ({podpowiedzProguBialka(wagaL!)} g)
            i cel błonnikowy ({podpowiedzBlonnika(cel.kcal)} g dziennie) — widoczne w zakładce Plan.
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Płyny: około {(wskazowkaWodna(wagaL!) / 1000).toFixed(1).replace('.', ',')} l dziennie
            (30 ml na kilogram). To wskazówka, nie cel.
          </ThemedText>
        </Karta>
      )}

      {ocena && ocena.blokady.length > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="accent">
            NIE MOŻNA ZAPISAĆ
          </ThemedText>
          {ocena.blokady.map((tresc) => (
            <ThemedText key={tresc} type="small">
              {tresc}
            </ThemedText>
          ))}
        </Karta>
      )}


      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <Przycisk tytul="Oblicz i zapisz cele" onPress={zapisz} zajety={zajety} wylaczony={!wolnoZapisac} />
      <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => wroc(powrot, '/profil')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  formularz: { gap: Spacing.three },
  kartaWyniku: { gap: Spacing.two },
  wierszPol: {
    flexDirection: 'row',
    gap: Spacing.two,
  },
  pole3: {
    flex: 1,
  },
});

const styleWyboru = StyleSheet.create({
  grupa: { gap: Spacing.one },
  segmenty: {
    flexDirection: 'row',
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  segment: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.three,
  },
  siatka: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  kafelAktywnosci: {
    flexBasis: '47%',
    flexGrow: 1,
    borderWidth: 1,
    borderRadius: Spacing.two,
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.three,
    paddingHorizontal: Spacing.two,
  },
  karyCelu: {
    flexDirection: 'row',
    gap: Spacing.two,
  },
  kartaCelu: {
    flex: 1,
    alignItems: 'center',
    gap: Spacing.one,
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.three,
    position: 'relative',
  },
  ptaszekCelu: {
    position: 'absolute',
    top: Spacing.two,
    right: Spacing.two,
  },
  opisCelu: {
    alignItems: 'center',
    gap: 2,
  },
  tekstCelu: {
    textAlign: 'center',
  },
});
