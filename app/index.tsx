import { Ionicons } from '@expo/vector-icons';
import { router, useFocusEffect } from 'expo-router';
import { useCallback, useMemo, useRef, useState } from 'react';
import { ActivityIndicator, Pressable, ScrollView, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { NaglowekPlanu } from '@/components/naglowek-planu';
import { Przycisk } from '@/components/przycisk';
import { TabelaWyboru } from '@/components/tabela-wyboru';
import { ThemedText } from '@/components/themed-text';
import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { powtorzTydzien, zaplanuj, type Wstawienie } from '@/lib/automat';
import {
  czyDzisiaj,
  dniPlanu,
  naDate,
  opisDnia,
  pobierzPlany,
  pobierzPoprzedniPlan,
  posprzatajStarePlany,
  pobierzPozycje,
  PORY,
  bialkoPosilku,
  dodajPartie,
  sumujDzien,
  usunPosilek,
  TYGODNI_HISTORII,
  ustawPrzepisSkalowanyPozycji,
  utworzPlan,
  usunPartie,
  wyczyscPlan,
  zmienDatePlanu,
  type Plan,
  type PozycjaPlanu,
} from '@/lib/plan';
import {
  OPIS_PORY,
  pasujeDoPory,
  pobierzPelnyPrzepis,
  pobierzPrzepisy,
  type PoraPosilku,
  type PrzepisZMakro,
} from '@/lib/przepisy';
import { utworzPrzeskalowanyPrzepis } from '@/lib/przepisy-skalowane';
import { celZywieniowyNASEM, type PalNasem } from '@/lib/nasem';
import { useSesja } from '@/lib/sesja';
import { pobierzSkladniki, type Skladnik } from '@/lib/skladniki';
import { supabase } from '@/lib/supabase';
import { wyczyscOdhaczenia } from '@/lib/zakupy';
import { wiekZDaty, type Plec, type TrybCelu } from '@/lib/zywienie';

type Cel = {
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number | null;
  prog_bialka_posilek: number | null;
};

type ProfilZCelem = {
  id: string;
  plec: Plec;
  data_urodzenia: string;
  wzrost_cm: number;
  aktywnosc: PalNasem;
  cele: {
    tryb: TrybCelu;
    bialko_procent: number;
    tluszcz_procent: number;
    wegle_procent: number;
    blonnik_g: number | null;
    prog_bialka_posilek: number | null;
  }[];
};

/** Miejsce w planie, do którego wybieramy przepis. */
type Wolne = { data: string; pora: PoraPosilku } | null;

/**
 * Jak daleko dzień jest od celu — zawsze liczbą, w obie strony.
 *
 * „Cel osiągnięty” nie mówi nic, czego nie widać po samych sumach. Liczba
 * mówi, ile jeszcze zostało miejsca albo o ile dzień wyszedł ponad plan,
 * a to jest odpowiedź na pytanie, które faktycznie się zadaje przy układaniu.
 */
function opisBilansu(
  suma: { bialko: number; kcal: number },
  cel: { bialko_g: number; kcal: number }
): string {
  const b = Math.round(suma.bialko - cel.bialko_g);
  const k = Math.round(suma.kcal - cel.kcal);

  const bialko =
    b === 0 ? 'Białko w punkt' : b < 0 ? `Brakuje ${-b} g białka` : `${b} g białka ponad cel`;

  const kalorie =
    k === 0 ? 'kalorie w punkt' : k < 0 ? `brakuje ${-k} kcal` : `${k} kcal ponad cel`;

  return `${bialko} · ${kalorie}`;
}

/** Odmiana słowa „dzień” w komunikatach — 1 = dzień, każda inna liczba = dni. */
function odmianaDni(n: number): string {
  return n === 1 ? 'dzień' : 'dni';
}

/** Ikona przy nazwie posiłku w karcie dnia. */
const IKONA_PORY: Record<PoraPosilku, keyof typeof Ionicons.glyphMap> = {
  sniadanie: 'sunny-outline',
  obiad: 'restaurant-outline',
  kolacja: 'moon-outline',
  dodatek: 'add-circle-outline',
};

/** Checkbox z opisem — pod „Wypełnij wolne miejsca", ustawienia automatu. */
function PrzelacznikAutomatu({
  zaznaczone,
  onZmiana,
  etykieta,
  opis,
  ikona,
}: {
  zaznaczone: boolean;
  onZmiana: (wartosc: boolean) => void;
  etykieta: string;
  opis: string;
  /** Ikona po prawej, w kółku — jak w karcie „Układanie tygodnia". */
  ikona: keyof typeof Ionicons.glyphMap;
}) {
  const motyw = useTheme();
  return (
    <Pressable
      onPress={() => onZmiana(!zaznaczone)}
      accessibilityRole="checkbox"
      accessibilityState={{ checked: zaznaczone }}
      style={({ pressed }) => [styles.checkboxWiersz, pressed && styles.wcisniete]}>
      <Ionicons
        name={zaznaczone ? 'checkbox' : 'square-outline'}
        size={20}
        color={zaznaczone ? motyw.accent : motyw.textSecondary}
      />
      <View style={styles.checkboxTresc}>
        <ThemedText type="small" themeColor={zaznaczone ? 'accent' : 'text'}>
          {etykieta}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {opis}
        </ThemedText>
      </View>
      <View style={[styles.ikonaKoloMala, { backgroundColor: motyw.backgroundSelected }]}>
        <Ionicons name={ikona} size={16} color={motyw.accent} />
      </View>
    </Pressable>
  );
}

export default function EkranPlanu() {
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [plan, setPlan] = useState<Plan | null>(null);
  const [pozycje, setPozycje] = useState<PozycjaPlanu[]>([]);
  const [przepisy, setPrzepisy] = useState<PrzepisZMakro[]>([]);
  const [cel, setCel] = useState<Cel | null>(null);
  const [osoby, setOsoby] = useState(1);
  const [wybierany, setWybierany] = useState<Wolne>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  /**
   * `null` oznacza „pokaż najnowszy”. Ustawiane tylko po założeniu nowego
   * tygodnia (patrz „Zacznij nowy tydzień od dzisiaj” niżej) — wybór
   * OGLĄDANEGO tygodnia z listy zniknął z ekranu jako niepotrzebny, więc
   * to jedyna droga, którą ta wartość się zmienia.
   */
  const [wybranyPlanId, setWybranyPlanId] = useState<string | null>(null);
  const [pracuje, setPracuje] = useState(false);
  const [czyscic, setCzyscic] = useState(false);
  const [komunikat, setKomunikat] = useState<string | null>(null);
  /** Checkboxy pod „Wypełnij wolne miejsca" — patrz `wypelnijAutomatem`. */
  const [skalujPoWypelnieniu, setSkalujPoWypelnieniu] = useState(true);
  const [uwzglednijTrwalosc, setUwzglednijTrwalosc] = useState(true);

  /*
    Powrót na to samo miejsce po wybraniu dania.

    Wybór przepisu podmienia CAŁĄ treść ekranu, więc po powrocie lista buduje
    się od nowa i zaczyna od góry. Przy dodawaniu obiadu w siódmym dniu
    oznaczało to przewijanie w dół za każdym razem.

    Trzy referencje zamiast stanu, bo żadna z nich nie ma prawa wywołać
    ponownego rysowania — to tylko notatki o tym, gdzie byliśmy.
  */
  const przewijanie = useRef<ScrollView>(null);
  const pozycja = useRef(0);
  const doPrzywrocenia = useRef(false);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);

    try {
      const [wszystkie, lista] = await Promise.all([pobierzPlany(), pobierzPrzepisy(sesja?.user.id)]);

      // Oglądany tydzień: wskazany ręcznie albo najnowszy. Gdy wskazany zniknął
      // (skasowany gdzie indziej), spadamy na najnowszy zamiast pokazywać pustkę.
      const p = wszystkie.find((x) => x.id === wybranyPlanId) ?? wszystkie[0] ?? null;

      setPlan(p);
      setPrzepisy(lista);
      setPozycje(p ? await pobierzPozycje(p.id) : []);
    } catch (e) {
      setBlad(komunikatBledu(e));
    }

    /*
      Liczba jedzących i bilans dnia liczą się z profili NIEZALEŻNIE od planu,
      we własnym bloku — inaczej awaria tutaj (zły pomiar wagi, brzegowy
      przypadek w wyliczeniu celu) chowałaby plan, który normalnie by się
      wczytał. Ta sama zasada co przy produktach dopisanych ręcznie w
      zakupach (patrz komentarz w `app/zakupy.tsx`).
    */
    try {
      // Liczba jedzących bierze się z profili — tyle porcji dziennie zejdzie z garnka.
      const wynikProfili = await supabase
        .from('profile')
        .select(
          'id, plec, data_urodzenia, wzrost_cm, aktywnosc, cele (tryb, bialko_procent, tluszcz_procent, wegle_procent, blonnik_g, prog_bialka_posilek)'
        )
        .order('kolejnosc')
        // `cele` trzyma pełną historię (jeden wiersz na obowiazuje_od) — bez
        // sortowania dołączona tablica wraca w dowolnej kolejności i
        // `cele[0]` (patrz niżej) potrafił złapać stary zapis, nie aktualny.
        .order('obowiazuje_od', { foreignTable: 'cele', ascending: false })
        .limit(1, { foreignTable: 'cele' });
      if (wynikProfili.error) throw wynikProfili.error;

      const listaProfili = (wynikProfili.data ?? []) as ProfilZCelem[];
      setOsoby(Math.max(1, listaProfili.length));

      // Bilans dnia liczy cel PIERWSZEGO profilu na koncie — apka nie ma
      // jeszcze pojęcia "dla kogo jest ten tydzień" przy kilku profilach.
      // Kcal i gramy liczą się na bieżąco z wagi/wzrostu/wieku/aktywności,
      // nie są zapisane jako liczba — dlatego zmiana wagi w profilu od razu
      // przesuwa bilans tutaj, bez osobnego zapisu celów.
      let noweCel: Cel | null = null;
      const pierwszy = listaProfili[0];
      const zapisanyCel = pierwszy?.cele?.[0];
      if (pierwszy && zapisanyCel) {
        const wynikWagi = await supabase
          .from('pomiary')
          .select('wartosc')
          .eq('profil_id', pierwszy.id)
          .eq('typ', 'waga')
          .order('data', { ascending: false })
          .limit(1)
          .maybeSingle();
        if (wynikWagi.error) throw wynikWagi.error;

        if (wynikWagi.data) {
          const wynik = celZywieniowyNASEM(
            pierwszy.plec,
            wiekZDaty(pierwszy.data_urodzenia),
            pierwszy.wzrost_cm,
            Number(wynikWagi.data.wartosc),
            pierwszy.aktywnosc,
            zapisanyCel.tryb,
            { bialko: zapisanyCel.bialko_procent, tluszcz: zapisanyCel.tluszcz_procent, wegle: zapisanyCel.wegle_procent }
          );
          noweCel = {
            kcal: wynik.kcal,
            bialko_g: wynik.bialko,
            tluszcz_g: wynik.tluszcz,
            wegle_g: wynik.wegle,
            blonnik_g: zapisanyCel.blonnik_g,
            prog_bialka_posilek: zapisanyCel.prog_bialka_posilek,
          };
        }
      }
      setCel(noweCel);
    } catch (e) {
      setBlad((poprzedni) => poprzedni ?? komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [sesja?.user.id, wybranyPlanId]);

  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

  /** Dni do wyboru jako początek planu: od dzisiaj przez dwa tygodnie. */
  const mozliweDaty = useMemo(() => {
    const dzis = new Date();
    return Array.from({ length: 14 }, (_, i) => {
      const d = new Date(dzis);
      d.setDate(dzis.getDate() + i);
      return naDate(d);
    });
  }, []);

  const wedlugDnia = useMemo(() => {
    const mapa = new Map<string, PozycjaPlanu[]>();
    for (const p of pozycje) {
      mapa.set(p.data, [...(mapa.get(p.data) ?? []), p]);
    }
    return mapa;
  }, [pozycje]);

  async function zDbem(operacja: () => Promise<void>) {
    setBlad(null);
    try {
      await operacja();
      await pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  /**
   * Zapisuje wynik automatu do bazy.
   *
   * Każde wstawienie to jedno GOTOWANIE, nie jeden posiłek — `dodajPartie`
   * rozkłada garnek na przekazane dni. Dlatego przekazujemy dokładnie te dni,
   * które automat wyliczył jako wolne i kolejne; bez tego funkcja policzyłaby
   * je sama z liczby porcji bazowych przepisu i weszłaby na miejsca zajęte ręcznie.
   *
   * Kolejność wstawiania ma znaczenie: idziemy po kolei, bo `kolejnosc` musi
   * rosnąć w obrębie posiłku.
   */
  async function zapiszWstawienia(cel: Plan, lista: Wstawienie[]) {
    if (!sesja) return;

    // Katalog składników trzeba tylko wtedy, gdy automat faktycznie wybrał
    // choć jedno danie skalowalne — nie ma sensu ściągać go za każdym razem.
    const potrzebujeSkalowania = lista.some((w) => w.celKcalDlaSkalowania !== null);
    const dostepneSkladniki = potrzebujeSkalowania ? await pobierzSkladniki() : [];

    for (const w of lista) {
      let przepisSkalowanyId: string | undefined;

      if (w.celKcalDlaSkalowania !== null) {
        const pelny = await pobierzPelnyPrzepis(w.przepisId);
        const wynik = await utworzPrzeskalowanyPrzepis({
          kontoId: sesja.user.id,
          przepis: pelny,
          dostepneSkladniki,
          celKcal: w.celKcalDlaSkalowania,
        });
        przepisSkalowanyId = wynik.id;
      }

      await dodajPartie({
        kontoId: sesja.user.id,
        planId: cel.id,
        odData: w.odData,
        pora: w.pora,
        przepisId: w.przepisId,
        kolejnosc: 1,
        osoby,
        liczbaPorcjiBazowych: w.dni.length,
        dostepneDni: w.dni,
        przepisSkalowanyId,
      });
    }
  }

  /** Zajęte miejsca i to, co już stoi w każdym dniu — wejście dla automatu. */
  function stanPlanu(dni: string[]) {
    const zajete = pozycje.map((p) => ({ data: p.data, pora: p.pora }));
    const makroDni = new Map(
      dni.map((d) => {
        const s = sumujDzien(pozycje.filter((p) => p.data === d));
        return [d, { kcal: s.kcal, bialko: s.bialko }];
      })
    );
    return { zajete, makroDni };
  }

  async function wypelnijAutomatem() {
    if (!plan) return;
    setKomunikat(null);
    setPracuje(true);
    try {
      const dni = dniPlanu(plan);
      const { zajete, makroDni } = stanPlanu(dni);

      const { wstawienia, bezObsady } = zaplanuj({
        dni,
        zajete,
        makroDni,
        przepisy,
        celKcal: cel?.kcal ?? null,
        celBialko: cel?.bialko_g ?? null,
        uwzglednijTrwalosc,
      });

      if (wstawienia.length === 0) {
        setKomunikat(
          bezObsady.length > 0
            ? 'Nie ma przepisów pasujących do pustych miejsc. Sprawdź, czy przepisy mają ustawioną kategorię.'
            : 'Wszystkie miejsca są już zajęte.'
        );
        return;
      }

      await zapiszWstawienia(plan, wstawienia);
      await pobierz();

      const posilkow = wstawienia.reduce((s, w) => s + w.dni.length, 0);
      let komunikatWypelnienia =
        `Dołożono ${posilkow} posiłków z ${wstawienia.length} gotowań.` +
        (bezObsady.length > 0 ? ` Bez obsady zostało ${bezObsady.length} miejsc.` : '');

      // Checkbox „Skaluj cały tydzień do celów" — dokłada drugi etap od razu
      // po wypełnieniu, zamiast zmuszać do osobnego kliknięcia przycisku niżej.
      if (skalujPoWypelnieniu && cel) {
        const { szczegoly, dniZmienione } = await przeliczSkalowalneWTygodniu();
        if (szczegoly.length > 0) {
          await pobierz();
          komunikatWypelnienia +=
            `\n\nPrzeliczono ${szczegoly.length} ${szczegoly.length === 1 ? 'danie' : 'dania'} ` +
            `w ${dniZmienione.size} ${odmianaDni(dniZmienione.size)}:\n` +
            szczegoly.join('\n');
        }
      }

      setKomunikat(komunikatWypelnienia);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  async function powtorzPoprzedni() {
    if (!plan) return;
    setKomunikat(null);
    setPracuje(true);
    try {
      const poprzedni = await pobierzPoprzedniPlan(plan.id);
      if (!poprzedni) {
        setKomunikat(
          'Nie ma wcześniejszego tygodnia do powtórzenia. Powstanie, gdy założysz kolejny.'
        );
        return;
      }

      const zrodlo = await pobierzPozycje(poprzedni.id);
      if (zrodlo.length === 0) {
        setKomunikat('Poprzedni tydzień był pusty — nie ma czego powtarzać.');
        return;
      }

      const dni = dniPlanu(plan);
      const { wstawienia, bezObsady } = powtorzTydzien({
        zrodlo,
        odDaty: poprzedni.data_start,
        dni,
        zajete: pozycje.map((p) => ({ data: p.data, pora: p.pora })),
      });

      if (wstawienia.length === 0) {
        setKomunikat('Wszystkie miejsca z poprzedniego tygodnia są już zajęte.');
        return;
      }

      await zapiszWstawienia(plan, wstawienia);
      await pobierz();

      // Komunikat liczy DNI, nie posiłków — to pytanie, na które faktycznie
      // ktoś chce znać odpowiedź: „ile dni tygodnia mam już z głowy".
      const dniWypelnione = new Set(wstawienia.flatMap((w) => w.dni)).size;
      setKomunikat(
        `Uzupełniono ${dniWypelnione} ${odmianaDni(dniWypelnione)} z tygodnia od ${opisDnia(poprzedni.data_start)}.` +
          (bezObsady.length > 0 ? ` Pominięto ${bezObsady.length} zajętych miejsc.` : '')
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  /**
   * Przelicza WSZYSTKIE dania oznaczone jako skalowalne w bieżącym tygodniu,
   * dzień po dniu, pod dzienny cel kaloryczny z profilu.
   *
   * Dania nieskalowalne w ogóle nie są ruszane — liczą się tylko do bilansu
   * dnia jako wartość stała. Reszta celu (cel minus to, co stałe) rozkłada
   * się równo między skalowalne dania TEGO dnia — jeśli jest ich kilka,
   * każde dostaje swój kawałek, a nie cały brakujący cel naraz.
   *
   * Działa niezależnie od tego, czy dane danie było już wcześniej
   * przeskalowane — zawsze liczy od nowa, z aktualnym celem.
   *
   * Czysta praca z bazą, bez `setKomunikat`/`setPracuje` — dzięki temu ta sama
   * logika służy zarówno osobnemu przyciskowi, jak i checkboxowi „Skaluj cały
   * tydzień do celów” pod „Wypełnij wolne miejsca”, gdzie komunikat musi się
   * złożyć z DWÓCH etapów (wypełnienie + skalowanie), nie nadpisywać się.
   * Wymaga `plan`, `sesja` i `cel` — sprawdza je WOŁAJĄCY.
   */
  async function przeliczSkalowalneWTygodniu(): Promise<{ szczegoly: string[]; dniZmienione: Set<string> }> {
    if (!plan || !sesja || !cel) return { szczegoly: [], dniZmienione: new Set() };

    const przepisyWedlugId = new Map(przepisy.map((p) => [p.id, p]));
    let dostepneSkladniki: Skladnik[] | null = null;
    const dniZmienione = new Set<string>();
    // Szczegóły do komunikatu — bez nich „przeliczono 3 dania” nie mówi,
    // czy któreś z nich trafiło w granicę [K_MIN, K_MAX] i nie dobiło do celu.
    const szczegoly: string[] = [];

    for (const data of dniPlanu(plan)) {
      const dniowe = pozycje.filter((p) => p.data === data);
      const skalowalne = dniowe.filter((p) => przepisyWedlugId.get(p.przepis_id)?.skalowalny);
      if (skalowalne.length === 0) continue;

      const stale = dniowe.filter((p) => !skalowalne.includes(p));
      const kcalStalych = stale.reduce((s, p) => s + p.kcal * p.porcje, 0);
      const docelowoNaSkalowalne = Math.max(0, cel.kcal - kcalStalych);
      const docelowoNaJedno = docelowoNaSkalowalne / skalowalne.length;

      if (!dostepneSkladniki) dostepneSkladniki = await pobierzSkladniki();

      for (const pozycja of skalowalne) {
        const celTegoDania = docelowoNaJedno / Math.max(1, pozycja.porcje);
        const pelny = await pobierzPelnyPrzepis(pozycja.przepis_id);
        const wynik = await utworzPrzeskalowanyPrzepis({
          kontoId: sesja.user.id,
          przepis: pelny,
          dostepneSkladniki,
          celKcal: celTegoDania,
        });
        await ustawPrzepisSkalowanyPozycji(pozycja.id, wynik.id);
        dniZmienione.add(data);

        szczegoly.push(
          `${pozycja.nazwa}: ${Math.round(pozycja.kcal)}→${wynik.kcal} kcal (cel ${Math.round(celTegoDania)})` +
            (wynik.kOgraniczone ? ' — trafiło w granicę skalowania, nie dobiło do celu' : '')
        );
      }
    }

    return { szczegoly, dniZmienione };
  }

  async function skalujCalyTydzien() {
    if (!plan || !sesja) return;
    if (!cel) {
      setKomunikat('Brak ustawionego celu kalorycznego w profilu — nie ma do czego skalować.');
      return;
    }

    setKomunikat(null);
    setPracuje(true);
    try {
      const { szczegoly, dniZmienione } = await przeliczSkalowalneWTygodniu();

      if (szczegoly.length === 0) {
        setKomunikat(
          'W tym tygodniu nie ma żadnego dania oznaczonego jako skalowalne — nie ma czego przeliczyć.'
        );
        return;
      }

      await pobierz();
      setKomunikat(
        `Przeliczono ${szczegoly.length} ${szczegoly.length === 1 ? 'danie' : 'dania'} ` +
          `w ${dniZmienione.size} ${odmianaDni(dniZmienione.size)}:\n` +
          szczegoly.join('\n')
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
  }

  // --- błąd wczytywania ---
  // Osobno od „brak planu” niżej — inaczej prawdziwa awaria (np. bazy) wyglądałaby
  // jak zaproszenie do założenia nowego tygodnia, choć plan istnieje i tylko się
  // nie wczytał.
  if (!wczytywanie && !plan && blad) {
    return (
      <Ekran tytul="Plan dnia">
        <Karta>
          <ThemedText type="small" themeColor="accent">
            Nie udało się wczytać: {blad}
          </ThemedText>
        </Karta>
      </Ekran>
    );
  }

  // --- brak planu ---
  if (!wczytywanie && !plan) {
    return (
      <Ekran tytul="Plan dnia" podtytul="Nie masz jeszcze planu">
        <Karta>
          <ThemedText type="default">Zacznijmy od tygodnia</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Plan obejmuje siedem dni po trzy posiłki. Do każdego miejsca przypiszesz przepis,
            a aplikacja zsumuje wartości i porówna je z Twoimi celami.
          </ThemedText>
          <Przycisk
            tytul="Utwórz plan od dzisiaj"
            onPress={() =>
              zDbem(async () => {
                if (sesja) await utworzPlan(sesja.user.id, naDate(new Date()));
              })
            }
          />
        </Karta>
      </Ekran>
    );
  }

  // --- wybór przepisu do konkretnego miejsca ---
  if (wybierany) {
    return (
      <Ekran
        pelnaSzerokosc
        tytul={OPIS_PORY[wybierany.pora]}
        podtytul={opisDnia(wybierany.data)}>
        {blad && (
          <Karta>
            <ThemedText type="small" themeColor="accent">
              {blad}
            </ThemedText>
          </Karta>
        )}

        <Karta>
          <TabelaWyboru
            dane={przepisy.filter((p) => pasujeDoPory(p.pory, wybierany.pora))}
            klucz={(p) => p.id}
            tekstDoFiltra={(p) => p.nazwa}
            etykietaFiltra="Filtruj przepisy"
            placeholderFiltra="zupa, dorsz, owsianka…"
            wybrane={[]}
            onPrzelacz={(p) =>
              zDbem(async () => {
                if (!plan || !sesja) return;
                const juz = pozycje.filter(
                  (x) => x.data === wybierany.data && x.pora === wybierany.pora
                ).length;
                await dodajPartie({
                  kontoId: sesja.user.id,
                  planId: plan.id,
                  odData: wybierany.data,
                  pora: wybierany.pora,
                  przepisId: p.id,
                  kolejnosc: juz + 1,
                  osoby,
                  // Ten sam checkbox „Uwzględnij ile dni wytrzyma w lodówce” co przy
                  // automacie (patrz `wypelnijAutomatem`) — inaczej ręczne wstawienie
                  // dania z ustawioną trwałością nigdy by jej nie uwzględniało.
                  liczbaPorcjiBazowych: uwzglednijTrwalosc
                    ? Math.max(1, p.trwalosc_dni)
                    : p.liczba_porcji_bazowych,
                  dostepneDni: dniPlanu(plan),
                });
                doPrzywrocenia.current = true;
                setWybierany(null);
              })
            }
            kolumny={[
              { tytul: 'Nazwa', elastyczna: true, wartosc: (p) => p.nazwa },
              { tytul: 'kcal', szerokosc: 60, liczba: true, wartosc: (p) => String(p.kcal ?? '—') },
              { tytul: 'białko', szerokosc: 64, liczba: true, wartosc: (p) => String(p.bialko_g ?? '—') },
              { tytul: 'porcja', szerokosc: 68, liczba: true, wartosc: (p) => (p.gramy_porcji ? `${p.gramy_porcji} g` : '—') },
            ]}
          />
        </Karta>

        {przepisy.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Baza przepisów jest pusta. Dodaj przepis w zakładce Przepisy.
          </ThemedText>
        )}

        <Przycisk
          tytul="Anuluj"
          wariant="poboczny"
          onPress={() => {
            doPrzywrocenia.current = true;
            setWybierany(null);
          }}
        />
      </Ekran>
    );
  }

  // Próg posiłkowy pochodzi z celów, a nie z dzielenia celu dziennego przez trzy.
  // Puste pole oznacza świadomą rezygnację z ostrzeżeń przy pojedynczych posiłkach.
  const progBialka = cel?.prog_bialka_posilek ?? null;

  return (
    <Ekran
      refPrzewijania={przewijanie}
      onScroll={(e) => {
        pozycja.current = e.nativeEvent.contentOffset.y;
      }}
      /*
        Przywracamy dopiero, gdy treść ma już swoją wysokość. Wcześniejsza próba
        nie ma dokąd przewinąć — lista jest jeszcze pusta i przewijanie kończy
        się na zerze, czyli dokładnie tam, skąd chcieliśmy uciec.
      */
      onContentSizeChange={(_, wysokosc) => {
        if (!doPrzywrocenia.current) return;
        if (wysokosc <= pozycja.current) return;
        doPrzywrocenia.current = false;
        przewijanie.current?.scrollTo({ y: pozycja.current, animated: false });
      }}
      tytul="Plan dnia"
      podtytul={wczytywanie ? 'wczytywanie…' : undefined}
      naglowekStaly={
        plan ? (
          <NaglowekPlanu
            plan={plan}
            osoby={osoby}
            mozliweDaty={mozliweDaty}
            onZmianaPierwszegoDnia={(d) => zDbem(() => zmienDatePlanu(plan.id, d))}
          />
        ) : undefined
      }>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      {wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          Wczytywanie…
        </ThemedText>
      )}

      {!cel && !wczytywanie && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            Nie masz ustalonych celów dziennych — nie będzie do czego porównywać sum.
            Ustawisz je w zakładce Profil.
          </ThemedText>
        </Karta>
      )}

      {plan && (
        <Karta style={styles.narzedzia}>
          <View style={styles.kartaNaglowek}>
            <View style={[styles.ikonaKolo, { backgroundColor: motyw.backgroundSelected }]}>
              <Ionicons name="layers-outline" size={26} color={motyw.accent} />
            </View>
            <ThemedText type="smallBold" themeColor="textSecondary">
              UKŁADANIE TYGODNIA
            </ThemedText>
          </View>

          <Pressable
            onPress={wypelnijAutomatem}
            disabled={pracuje || przepisy.length === 0}
            accessibilityRole="button"
            style={({ pressed }) => [
              styles.wypelnijPrzycisk,
              { backgroundColor: motyw.accent },
              (pressed || pracuje || przepisy.length === 0) && styles.wcisniete,
            ]}>
            {pracuje ? (
              <ActivityIndicator color="#fff" />
            ) : (
              <>
                <Ionicons name="sparkles-outline" size={26} color="#fff" />
                <View style={styles.wypelnijTresc}>
                  <ThemedText type="smallBold" style={styles.bialyTekst}>
                    Wypełnij wolne miejsca
                  </ThemedText>
                  <ThemedText type="small" style={[styles.bialyTekst, styles.wypelnijOpis]}>
                    Dobiera z ulubionych tak, żeby domknąć dzienne białko i kalorie.
                    Tego, co już wybrałeś, nie rusza.
                  </ThemedText>
                </View>
              </>
            )}
          </Pressable>

          <PrzelacznikAutomatu
            zaznaczone={skalujPoWypelnieniu}
            onZmiana={setSkalujPoWypelnieniu}
            etykieta="Skaluj cały tydzień do celów"
            opis="Od razu po wypełnieniu przelicza dania skalowalne pod dzienny cel — jak osobny przycisk niżej, tylko bez dodatkowego kliknięcia."
            ikona="trending-up-outline"
          />

          <PrzelacznikAutomatu
            zaznaczone={uwzglednijTrwalosc}
            onZmiana={setUwzglednijTrwalosc}
            etykieta="Uwzględnij ile dni wytrzyma w lodówce"
            opis="Kopiuje danie na tyle kolejnych dni, ile wytrzyma w lodówce, zamiast na jego liczbę porcji bazowych."
            ikona="archive-outline"
          />

          <View style={styles.akcjeSiatka}>
            <Przycisk
              tytul={pracuje ? 'Przeliczam…' : 'Skaluj cały tydzień do celów'}
              wariant="poboczny"
              ikona="stats-chart-outline"
              onPress={skalujCalyTydzien}
              zajety={pracuje}
              wylaczony={pracuje}
              style={styles.akcjaKafelek}
            />

            <Przycisk
              tytul="Powtórz poprzedni tydzień"
              wariant="poboczny"
              ikona="refresh-outline"
              onPress={powtorzPoprzedni}
              zajety={pracuje}
              wylaczony={pracuje}
              style={styles.akcjaKafelek}
            />

            <Przycisk
              tytul="Zacznij nowy tydzień od dzisiaj"
              wariant="poboczny"
              ikona="add-circle-outline"
              onPress={() =>
                zDbem(async () => {
                  if (!sesja) return;
                  const nowy = await utworzPlan(sesja.user.id, naDate(new Date()));
                  setWybranyPlanId(nowy.id);

                  // Sprzątamy przy zakładaniu nowego tygodnia, a nie przy każdym
                  // wejściu na ekran. To jedyny moment, w którym historia rośnie,
                  // więc jedyny, w którym trzeba coś przyciąć.
                  const usunietych = await posprzatajStarePlany();
                  if (usunietych > 0) {
                    setKomunikat(
                      `Trzymamy ${TYGODNI_HISTORII} ostatnich tygodni — starsze ` +
                        `${usunietych === 1 ? 'zniknął' : 'zniknęły'} (${usunietych}).`
                    );
                  }
                })
              }
              zajety={pracuje}
              style={styles.akcjaKafelek}
            />

            <Przycisk
              tytul="Wyczyść wszystko"
              wariant="poboczny"
              ikona="trash-outline"
              onPress={() => setCzyscic(true)}
              wylaczony={pozycje.length === 0 || pracuje}
              style={styles.akcjaKafelek}
            />
          </View>

          <ThemedText type="small" themeColor="textSecondary">
            Zakłada kolejny tydzień od dzisiaj. Poprzedni zostaje — to z niego bierze
            się „powtórz poprzedni tydzień”. Skalowanie przelicza dania oznaczone jako
            skalowalne tak, żeby każdy dzień celniej trafiał w dzienny cel kaloryczny.
          </ThemedText>

          {/*
            Czyszczenie kasuje nieodwracalnie i cały tydzień naraz, więc wymaga
            drugiego dotknięcia. Okienko systemowe odpada: na przeglądarce
            wygląda jak komunikat o błędzie, a na telefonie bywa blokowane.
          */}
          {czyscic && (
            <>
              <ThemedText type="small" themeColor="accent">
                Skasować wszystkie {pozycje.length} posiłków tego tygodnia razem
                z zaplanowanymi gotowaniami? Tego nie da się cofnąć.
              </ThemedText>
              <Przycisk
                tytul="Tak, wyczyść tydzień"
                onPress={() =>
                  zDbem(async () => {
                    await wyczyscPlan(plan.id);
                    // Odhaczenia są przypisane do planu, ale ten sam plan_id
                    // zostaje po wyczyszczeniu tygodnia — bez jawnego czyszczenia
                    // tu, ponowne wstawienie tych samych dań pokazywałoby stare
                    // ptaszki, choć nikt jeszcze nic nie odhaczył dla nowej treści.
                    if (sesja) await wyczyscOdhaczenia(sesja.user.id, plan.id);
                    setCzyscic(false);
                  })
                }
              />
              <Przycisk tytul="Zostaw" wariant="poboczny" onPress={() => setCzyscic(false)} />
            </>
          )}

          {komunikat && (
            <ThemedText type="small" themeColor="textSecondary">
              {komunikat}
            </ThemedText>
          )}
        </Karta>
      )}

      {plan &&
        dniPlanu(plan).map((data) => {
          const dzien = wedlugDnia.get(data) ?? [];
          const suma = sumujDzien(dzien);
          const dzisiaj = czyDzisiaj(data);

          // Licznik obsadzonych posiłków. Liczymy PORY, nie dania — obiad
          // złożony z zupy i drugiego dania to dalej jeden posiłek.
          const obsadzone = PORY.filter((p) => dzien.some((x) => x.pora === p)).length;
          const komplet = obsadzone === PORY.length;

          return (
            <Karta
              key={data}
              style={
                dzisiaj
                  ? { marginTop: Spacing.three, borderWidth: 2, borderColor: motyw.accent }
                  : { marginTop: Spacing.three }
              }>
              {/*
                Nagłówek dnia — samodzielna pigułka z ikoną, datą i licznikiem
                obsadzonych posiłków, oddzielona od kart posiłków poniżej.
              */}
              <View
                style={[
                  styles.dzienNaglowek,
                  {
                    backgroundColor: komplet ? motyw.backgroundSelected : motyw.background,
                    borderColor: motyw.border,
                  },
                ]}>
                <View style={styles.dzienNaglowekLewo}>
                  <View style={[styles.ikonaKoloDnia, { backgroundColor: motyw.backgroundElement }]}>
                    <Ionicons name="calendar-outline" size={22} color={motyw.accent} />
                  </View>
                  <ThemedText type="default" themeColor={dzisiaj ? 'accent' : 'text'}>
                    {opisDnia(data)}
                    {dzisiaj ? ' · dzisiaj' : ''}
                  </ThemedText>
                </View>

                <View style={styles.stanDnia}>
                  {/*
                    Licznik świeci akcentem, dopóki czegoś brakuje — to jest ta
                    informacja, na którą można zareagować. Dzień pełny gaśnie
                    do koloru pobocznego i dostaje ptaszka.
                  */}
                  <View style={styles.licznikPosilkow}>
                    {komplet && (
                      <View style={[styles.checkKoloMale, { backgroundColor: motyw.accent }]}>
                        <Ionicons name="checkmark" size={12} color="#fff" />
                      </View>
                    )}
                    <ThemedText
                      type="smallBold"
                      themeColor={komplet ? 'textSecondary' : 'accent'}>
                      {obsadzone}/{PORY.length}
                    </ThemedText>
                  </View>

                  {dzien.length > 0 && (
                    <ThemedText type="small" themeColor="textSecondary">
                      {Math.round(suma.kcal)} kcal
                    </ThemedText>
                  )}
                </View>
              </View>

              {PORY.map((pora) => {
                const dania = dzien
                  .filter((p) => p.pora === pora)
                  .sort((a, b) => a.kolejnosc - b.kolejnosc);

                // Próg białka dotyczy CAŁEGO posiłku, nie pojedynczego dania.
                // Porcja zupy nigdy go nie dobije — i nie musi, bo je się ją z czymś.
                const bialko = bialkoPosilku(dania);
                const zaMalo = progBialka !== null && dania.length > 0 && bialko < progBialka;

                return (
                  <View
                    key={pora}
                    style={[
                      styles.posilekKarta,
                      { borderColor: motyw.border, backgroundColor: motyw.backgroundElement },
                    ]}>
                    <View style={styles.posilekGlowny}>
                      <View style={[styles.posilekIkona, { backgroundColor: motyw.background }]}>
                        <Ionicons name={IKONA_PORY[pora]} size={26} color={motyw.accent} />
                      </View>

                      <View style={styles.posilekTresc}>
                        <ThemedText type="smallBold" themeColor="accent">
                          {OPIS_PORY[pora].toUpperCase()}
                        </ThemedText>

                        {dania.map((pozycja) => (
                          <View key={pozycja.id} style={styles.pozycja}>
                            {/*
                              Nazwa dania otwiera przepis do gotowania. To jest droga,
                              którą chodzi się najczęściej: stoisz w kuchni, patrzysz
                              w plan i chcesz zobaczyć, co i jak zrobić.
                            */}
                            <View style={styles.wierszNazwyDania}>
                              <Pressable
                                onPress={() => {
                                  // Ile porcji trzeba UGOTOWAĆ NARAZ dla tej partii: tyle dni,
                                  // ile pozycji dzieli ten sam partia_id, razy jedzący danego dnia.
                                  // Bez tego ekran przepisu pokazywałby bazową ilość składników,
                                  // nawet gdy garnek ma starczyć na kilka dni z rzędu.
                                  const dniPartii = pozycja.partia_id
                                    ? pozycje.filter((p) => p.partia_id === pozycja.partia_id).length
                                    : 1;
                                  router.push({
                                    pathname: '/przepis',
                                    params: {
                                      id: pozycja.przepis_id,
                                      powrot: '/',
                                      porcjeRazem: String(dniPartii * pozycja.porcje),
                                      ...(pozycja.przepis_skalowany_id
                                        ? { skalowany: pozycja.przepis_skalowany_id }
                                        : {}),
                                    },
                                  });
                                }}
                                accessibilityRole="link"
                                accessibilityLabel={`Otwórz przepis: ${pozycja.nazwa}`}
                                style={({ pressed }) => [styles.otworzPrzepis, pressed && styles.wcisniete]}>
                                <ThemedText type="small" style={styles.nazwaDania} numberOfLines={2}>
                                  {pozycja.nazwa}
                                  {dania.length > 1 ? ` · danie ${pozycja.kolejnosc}` : ''}
                                </ThemedText>
                                <Ionicons name="chevron-forward" size={18} color={motyw.textSecondary} />
                              </Pressable>

                              <View style={styles.akcjeDania}>
                                <Pressable
                                  onPress={() =>
                                    zDbem(() =>
                                      pozycja.partia_id
                                        ? usunPartie(pozycja.partia_id)
                                        : usunPosilek(pozycja.id)
                                    )
                                  }
                                  hitSlop={8}
                                  accessibilityLabel={
                                    pozycja.partia_id ? 'Usuń całą partię' : 'Usuń danie'
                                  }>
                                  <Ionicons name="close" size={18} color={motyw.textSecondary} />
                                </Pressable>
                              </View>
                            </View>

                            <View style={styles.wierszPozycji}>
                              {/*
                                Liczba porcji nie jest edytowalna z osobna — wynika z liczby
                                jedzących i rozkłada się na tyle dni, ile danie wytrzyma.
                                Zmiana pojedynczego dnia rozjechałaby się z garnkiem.
                              */}
                              <ThemedText type="smallBold">
                                {pozycja.porcje}{' '}
                                {pozycja.porcje === 1 ? 'porcja' : 'porcje'}
                              </ThemedText>

                              {pozycja.gramy_porcji > 0 && (
                                <ThemedText type="small" themeColor="textSecondary">
                                  {Math.round(pozycja.gramy_porcji * pozycja.porcje)} g
                                </ThemedText>
                              )}

                              <ThemedText type="small" themeColor="textSecondary">
                                {Math.round(pozycja.kcal * pozycja.porcje)} kcal{' · '}
                                {Math.round(pozycja.bialko_g * pozycja.porcje * 10) / 10} g białka
                              </ThemedText>
                            </View>
                          </View>
                        ))}
                      </View>
                    </View>

                    <Pressable
                      onPress={() => setWybierany({ data, pora })}
                      style={({ pressed }) => [
                        styles.puste,
                        { borderColor: motyw.border },
                        pressed && styles.wcisniete,
                      ]}>
                      <Ionicons name="add-circle-outline" size={18} color={motyw.textSecondary} />
                      <ThemedText type="small" themeColor="textSecondary">
                        {dania.length === 0
                          ? `${OPIS_PORY[pora]} — wybierz danie`
                          : `Dołóż danie do ${OPIS_PORY[pora].toLowerCase()}`}
                      </ThemedText>
                    </Pressable>

                    {zaMalo && (
                      <View
                        style={[
                          styles.infoBialko,
                          { backgroundColor: motyw.background, borderColor: motyw.border },
                        ]}>
                        <Ionicons name="leaf-outline" size={18} color={motyw.accent} />
                        <ThemedText
                          type="small"
                          themeColor="textSecondary"
                          style={styles.infoBialkoTekst}>
                          {OPIS_PORY[pora]}: {Math.round(bialko * 10) / 10} g białka,
                          próg {progBialka} g. Lekki posiłek — jeśli reszta dnia to nadrobi,
                          nic się nie dzieje.
                        </ThemedText>
                      </View>
                    )}
                  </View>
                );
              })}


              {dzien.length > 0 && (
                <View
                  style={[
                    styles.dzienPodsumowanie,
                    { backgroundColor: motyw.background, borderColor: motyw.border },
                  ]}>
                  <View style={styles.summarySiatka}>
                    {(
                      [
                        {
                          etykieta: 'kcal',
                          wartosc: Math.round(suma.kcal),
                          jednostka: '',
                          cel: cel?.kcal,
                          ikona: 'flame-outline' as const,
                          kolor: KOLOR_MAKRO.bialko,
                        },
                        {
                          etykieta: 'białko',
                          wartosc: Math.round(suma.bialko),
                          jednostka: ' g',
                          cel: cel?.bialko_g,
                          ikona: 'barbell-outline' as const,
                          kolor: KOLOR_MAKRO.bialko,
                        },
                        {
                          etykieta: 'tłuszcz',
                          wartosc: Math.round(suma.tluszcz),
                          jednostka: ' g',
                          cel: cel?.tluszcz_g,
                          ikona: 'water-outline' as const,
                          kolor: KOLOR_MAKRO.tluszcz,
                        },
                        {
                          etykieta: 'węgle',
                          wartosc: Math.round(suma.wegle),
                          jednostka: ' g',
                          cel: cel?.wegle_g,
                          ikona: 'nutrition-outline' as const,
                          kolor: KOLOR_MAKRO.wegle,
                        },
                        {
                          etykieta: 'błonnik',
                          wartosc: Math.round(suma.blonnik),
                          jednostka: ' g',
                          cel: cel?.blonnik_g ?? undefined,
                          ikona: 'leaf-outline' as const,
                          kolor: KOLOR_MAKRO.blonnik,
                        },
                      ]
                    ).map((p) => (
                      <View key={p.etykieta} style={styles.summaryPozycja}>
                        <View style={[styles.summaryIkona, { backgroundColor: `${p.kolor}22` }]}>
                          <Ionicons name={p.ikona} size={18} color={p.kolor} />
                        </View>
                        <View style={styles.summaryWartosci}>
                          <ThemedText type="smallBold" numberOfLines={1}>
                            {p.wartosc}
                            {p.jednostka}
                          </ThemedText>
                          {p.cel !== undefined && (
                            <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
                              z {p.cel}
                              {p.jednostka}
                            </ThemedText>
                          )}
                          <ThemedText type="small" themeColor="textSecondary" numberOfLines={1}>
                            {p.etykieta}
                          </ThemedText>
                        </View>
                      </View>
                    ))}
                  </View>

                  {/*
                    Najbardziej użyteczna liczba w całym ekranie: jak daleko dzień
                    jest od celu. ZAWSZE liczba, w obie strony.

                    Wcześniej przy niedoborze pisaliśmy ile brakuje, a przy nadwyżce
                    tylko „cel białkowy osiągnięty” — czyli po jednej stronie
                    informacja, po drugiej komunikat bez treści. Teraz „brakuje 23 g”
                    i „23 g ponad cel” to to samo zdanie z inną liczbą.
                  */}
                  {cel && (
                    <View
                      style={[styles.summaryStatus, { backgroundColor: motyw.backgroundSelected }]}>
                      <View
                        style={[
                          styles.checkKoloMale,
                          { backgroundColor: suma.bialko < cel.bialko_g ? motyw.accent : KOLOR_MAKRO.bialko },
                        ]}>
                        <Ionicons name="checkmark" size={12} color="#fff" />
                      </View>
                      <ThemedText
                        type="smallBold"
                        themeColor={suma.bialko < cel.bialko_g ? 'accent' : 'text'}>
                        {opisBilansu(suma, cel)}
                      </ThemedText>
                    </View>
                  )}
                </View>
              )}
            </Karta>
          );
        })}

      {/*
        Przycisku „Lista zakupów” tu nie ma celowo — zakupy mają własną zakładkę
        na dolnej wstążce. Jedno wejście zamiast dwóch: mniej do zapamiętania
        i widać je także wtedy, gdy plan jest pusty.
      */}
    </Ekran>
  );
}

const styles = StyleSheet.create({
  narzedzia: { gap: Spacing.two },
  checkboxWiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    paddingVertical: Spacing.one,
  },
  checkboxTresc: { flex: 1, gap: 2 },

  /* Nagłówek karty — ikona w kółku, jak przy „Lista zakupów". */
  kartaNaglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  ikonaKolo: {
    width: 52,
    height: 52,
    borderRadius: 26,
    alignItems: 'center',
    justifyContent: 'center',
  },
  ikonaKoloMala: {
    width: 32,
    height: 32,
    borderRadius: 16,
    alignItems: 'center',
    justifyContent: 'center',
  },

  /* Duży przycisk „Wypełnij wolne miejsca" — najważniejsza akcja karty. */
  wypelnijPrzycisk: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
    borderRadius: Spacing.three,
    padding: Spacing.three,
    minHeight: 72,
  },
  wypelnijTresc: { flex: 1, gap: Spacing.half },
  wypelnijOpis: { opacity: 0.9 },
  bialyTekst: { color: '#FFFFFF' },

  /* Przyciski akcji — po dwa w rzędzie, jak kafelki w makiecie. */
  akcjeSiatka: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  akcjaKafelek: {
    flexGrow: 1,
    flexBasis: '46%',
  },

  /* Nagłówek dnia — pigułka z ikoną, datą i licznikiem obsadzonych posiłków. */
  dzienNaglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    flexWrap: 'wrap',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.three,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
  },
  dzienNaglowekLewo: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  ikonaKoloDnia: {
    width: 40,
    height: 40,
    borderRadius: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  stanDnia: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  licznikPosilkow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  checkKoloMale: {
    width: 18,
    height: 18,
    borderRadius: 9,
    alignItems: 'center',
    justifyContent: 'center',
  },

  /* Karta jednego posiłku — ikona typu posiłku po lewej, dania po prawej. */
  posilekKarta: {
    borderWidth: 1,
    borderRadius: Spacing.three,
    padding: Spacing.three,
    gap: Spacing.two,
  },
  posilekGlowny: {
    flexDirection: 'row',
    gap: Spacing.three,
    alignItems: 'flex-start',
  },
  posilekIkona: {
    width: 48,
    height: 48,
    borderRadius: 24,
    alignItems: 'center',
    justifyContent: 'center',
  },
  posilekTresc: { flex: 1, gap: Spacing.two, minWidth: 0 },

  puste: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderWidth: 1,
    borderStyle: 'dashed',
    borderRadius: Spacing.two,
    padding: Spacing.two,
  },
  wcisniete: { opacity: 0.6 },
  pozycja: { gap: Spacing.one },
  wierszNazwyDania: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  akcjeDania: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  wierszPozycji: {
    flexDirection: 'row',
    alignItems: 'center',
    flexWrap: 'wrap',
    rowGap: Spacing.half,
    columnGap: Spacing.two,
  },
  otworzPrzepis: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.half,
  },
  nazwaDania: { flex: 1 },

  /* Ostrzeżenie o niskim białku posiłku — pigułka z ikoną, jak w makiecie. */
  infoBialko: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
  },
  infoBialkoTekst: { flex: 1 },

  /* Podsumowanie dnia — siatka makro z ikonami i pasek bilansu na dole. */
  dzienPodsumowanie: {
    borderWidth: 1,
    borderRadius: Spacing.three,
    padding: Spacing.three,
    gap: Spacing.two,
  },
  /*
    Zawsze w jednej linii, bez zawijania — jak `WierszMakro`. Szerokość
    kolumny jest UŁAMKIEM rzędu (100% / 5 pozycji), a odstęp robi wewnętrzny
    `paddingRight`, nie `gap` — `gap` doliczyłby się do stu procent
    zajmowanych przez kolumny i rząd znów by się zawinął.
  */
  summarySiatka: {
    flexDirection: 'row',
  },
  summaryPozycja: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: Spacing.one,
    width: '20%',
    minWidth: 0,
  },
  summaryIkona: {
    width: 28,
    height: 28,
    borderRadius: 14,
    alignItems: 'center',
    justifyContent: 'center',
    flex: 0,
  },
  summaryWartosci: { gap: 2, minWidth: 0 },
  summaryStatus: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderRadius: Spacing.two,
    paddingHorizontal: Spacing.two,
    paddingVertical: Spacing.one,
  },
});
