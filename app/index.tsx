import { Ionicons } from '@expo/vector-icons';
import { router, useFocusEffect } from 'expo-router';
import { useCallback, useMemo, useRef, useState } from 'react';
import { Pressable, ScrollView, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ListaRozwijana } from '@/components/lista-rozwijana';
import { WierszMakro } from '@/components/wiersz-makro';
import { Przycisk } from '@/components/przycisk';
import { TabelaWyboru } from '@/components/tabela-wyboru';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
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
  pobierzPrzepisy,
  type PoraPosilku,
  type PrzepisZMakro,
} from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';

type Cel = {
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number | null;
  prog_bialka_posilek: number | null;
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

  /** Wszystkie tygodnie konta — do przełączania i do powtarzania układu. */
  const [plany, setPlany] = useState<Plan[]>([]);
  /** `null` oznacza „pokaż najnowszy”. */
  const [wybranyPlanId, setWybranyPlanId] = useState<string | null>(null);
  const [pracuje, setPracuje] = useState(false);
  const [czyscic, setCzyscic] = useState(false);
  const [komunikat, setKomunikat] = useState<string | null>(null);

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
      const [wszystkie, lista, wynikCelu, wynikProfili] = await Promise.all([
        pobierzPlany(),
        pobierzPrzepisy(sesja?.user.id),
        supabase
          .from('cele')
          .select('kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, prog_bialka_posilek')
          .order('obowiazuje_od', { ascending: false })
          .limit(1)
          .maybeSingle(),
        // Liczba jedzących bierze się z profili — tyle porcji dziennie zejdzie z garnka.
        supabase.from('profile').select('id'),
      ]);

      setOsoby(Math.max(1, wynikProfili.data?.length ?? 1));

      // Oglądany tydzień: wskazany ręcznie albo najnowszy. Gdy wskazany zniknął
      // (skasowany gdzie indziej), spadamy na najnowszy zamiast pokazywać pustkę.
      const p = wszystkie.find((x) => x.id === wybranyPlanId) ?? wszystkie[0] ?? null;

      setPlany(wszystkie);
      setPlan(p);
      setPrzepisy(lista);
      if (!wynikCelu.error) setCel(wynikCelu.data);
      setPozycje(p ? await pobierzPozycje(p.id) : []);
    } catch (e) {
      setBlad(komunikatBledu(e));
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
   * je sama z trwałości przepisu i weszłaby na miejsca zajęte ręcznie.
   *
   * Kolejność wstawiania ma znaczenie: idziemy po kolei, bo `kolejnosc` musi
   * rosnąć w obrębie posiłku.
   */
  async function zapiszWstawienia(cel: Plan, lista: Wstawienie[]) {
    if (!sesja) return;
    for (const w of lista) {
      await dodajPartie({
        kontoId: sesja.user.id,
        planId: cel.id,
        odData: w.odData,
        pora: w.pora,
        przepisId: w.przepisId,
        kolejnosc: 1,
        osoby,
        trwaloscDni: w.dni.length,
        dostepneDni: w.dni,
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
      setKomunikat(
        `Dołożono ${posilkow} posiłków z ${wstawienia.length} gotowań.` +
          (bezObsady.length > 0 ? ` Bez obsady zostało ${bezObsady.length} miejsc.` : '')
      );
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

      const posilkow = wstawienia.reduce((s, w) => s + w.dni.length, 0);
      setKomunikat(
        `Przeniesiono ${posilkow} posiłków z tygodnia od ${opisDnia(poprzedni.data_start)}.` +
          (bezObsady.length > 0 ? ` Pominięto ${bezObsady.length} zajętych miejsc.` : '')
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setPracuje(false);
    }
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
                  trwaloscDni: p.trwalosc_dni,
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
      podtytul={
        plan
          ? `${plan.dni} dni · ${osoby} ${osoby === 1 ? 'osoba' : 'osoby'}`
          : undefined
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
        <Karta>
          <ListaRozwijana
            etykieta="PIERWSZY DZIEŃ PLANU"
            wybrana={plan.data_start}
            onZmiana={(d) => zDbem(() => zmienDatePlanu(plan.id, d))}
            opcje={mozliweDaty.map((d) => ({
              wartosc: d,
              etykieta: opisDnia(d),
              opis: czyDzisiaj(d) ? 'dzisiaj' : undefined,
            }))}
          />
          <ThemedText type="small" themeColor="textSecondary">
            Pozostałe dni ułożą się od niego. Posiłki zostają przy swoich datach.
          </ThemedText>

          {/*
            Przełącznik tygodni pokazuje się dopiero, gdy jest co przełączać.
            Przy pierwszym tygodniu byłby polem z jedną pozycją.
          */}
          {plany.length > 1 && (
            <ListaRozwijana
              etykieta="OGLĄDANY TYDZIEŃ"
              wybrana={plan.id}
              onZmiana={(id) => setWybranyPlanId(id)}
              opcje={plany.map((p) => ({
                wartosc: p.id,
                etykieta: `od ${opisDnia(p.data_start)}`,
                opis: p.id === plany[0].id ? 'najnowszy' : undefined,
              }))}
            />
          )}
        </Karta>
      )}

      {plan && (
        <Karta style={styles.narzedzia}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            UKŁADANIE TYGODNIA
          </ThemedText>

          <Przycisk
            tytul={pracuje ? 'Układam…' : 'Wypełnij wolne miejsca'}
            onPress={wypelnijAutomatem}
            zajety={pracuje}
            wylaczony={pracuje || przepisy.length === 0}
          />
          <ThemedText type="small" themeColor="textSecondary">
            Dobiera z ulubionych tak, żeby domknąć dzienne białko i kalorie. Tego, co
            już wybrałeś, nie rusza — od zera służy czyszczenie poniżej.
          </ThemedText>

          <Przycisk
            tytul="Powtórz poprzedni tydzień"
            wariant="poboczny"
            onPress={powtorzPoprzedni}
            zajety={pracuje}
            wylaczony={pracuje}
          />

          <Przycisk
            tytul="Zacznij nowy tydzień od dzisiaj"
            wariant="poboczny"
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
          />
          <ThemedText type="small" themeColor="textSecondary">
            Zakłada kolejny tydzień od dzisiaj. Poprzedni zostaje — to z niego bierze
            się „powtórz poprzedni tydzień”.
          </ThemedText>

          {/*
            Czyszczenie kasuje nieodwracalnie i cały tydzień naraz, więc wymaga
            drugiego dotknięcia. Okienko systemowe odpada: na przeglądarce
            wygląda jak komunikat o błędzie, a na telefonie bywa blokowane.
          */}
          {czyscic ? (
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
                    setCzyscic(false);
                  })
                }
              />
              <Przycisk tytul="Zostaw" wariant="poboczny" onPress={() => setCzyscic(false)} />
            </>
          ) : (
            <Przycisk
              tytul="Wyczyść wszystko"
              wariant="poboczny"
              onPress={() => setCzyscic(true)}
              wylaczony={pozycje.length === 0 || pracuje}
            />
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
                Pasek nagłówka rozciąga się na całą szerokość karty — stąd ujemne
                marginesy, które znoszą jej wewnętrzny odstęp. To on oddziela
                dni od siebie podczas przewijania; wcześniej nagłówek był zwykłym
                wierszem tekstu i granica dnia dawała się rozpoznać dopiero po
                przeczytaniu daty.
              */}
              <View
                style={[
                  styles.pasekDnia,
                  {
                    backgroundColor: komplet ? motyw.backgroundSelected : motyw.background,
                    borderBottomColor: motyw.border,
                  },
                ]}>
                <ThemedText type="smallBold" themeColor={dzisiaj ? 'accent' : 'text'}>
                  {opisDnia(data)}
                  {dzisiaj ? ' · dzisiaj' : ''}
                </ThemedText>

                <View style={styles.stanDnia}>
                  {/*
                    Licznik świeci akcentem, dopóki czegoś brakuje — to jest ta
                    informacja, na którą można zareagować. Dzień pełny gaśnie
                    do koloru pobocznego i dostaje ptaszka.
                  */}
                  <View style={styles.licznikPosilkow}>
                    {komplet && (
                      <Ionicons name="checkmark-circle" size={14} color={motyw.textSecondary} />
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
                  <View key={pora} style={styles.posilek}>
                    {dania.map((pozycja) => (
                      <View key={pozycja.id} style={[styles.pozycja, { borderColor: motyw.border }]}>
                        <View style={styles.naglowekPozycji}>
                          <ThemedText type="small" themeColor="accent">
                            {OPIS_PORY[pora].toUpperCase()}
                            {dania.length > 1 ? ` · danie ${pozycja.kolejnosc}` : ''}
                          </ThemedText>
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
                            <Ionicons name="close" size={16} color={motyw.textSecondary} />
                          </Pressable>
                        </View>

                        {/*
                          Nazwa dania otwiera przepis do gotowania. To jest droga,
                          którą chodzi się najczęściej: stoisz w kuchni, patrzysz
                          w plan i chcesz zobaczyć, co i jak zrobić.
                        */}
                        <Pressable
                          onPress={() =>
                            router.push({
                              pathname: '/przepis',
                              params: { id: pozycja.przepis_id, powrot: '/' },
                            })
                          }
                          accessibilityRole="link"
                          accessibilityLabel={`Otwórz przepis: ${pozycja.nazwa}`}
                          style={({ pressed }) => [styles.otworzPrzepis, pressed && styles.wcisniete]}>
                          <ThemedText type="small" style={styles.nazwaDania}>
                            {pozycja.nazwa}
                          </ThemedText>
                          <Ionicons name="chevron-forward" size={16} color={motyw.textSecondary} />
                        </Pressable>

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

                          <ThemedText
                            type="small"
                            themeColor="textSecondary"
                            style={styles.makroPozycji}>
                            {Math.round(pozycja.kcal * pozycja.porcje)} kcal{' · '}
                            {Math.round(pozycja.bialko_g * pozycja.porcje * 10) / 10} g białka
                          </ThemedText>
                        </View>
                      </View>
                    ))}

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
                      <ThemedText type="small" themeColor="accent">
                        {OPIS_PORY[pora]}: {Math.round(bialko * 10) / 10} g białka,
                        próg {progBialka} g. Lekki posiłek — jeśli reszta dnia to nadrobi,
                        nic się nie dzieje.
                      </ThemedText>
                    )}
                  </View>
                );
              })}


              {dzien.length > 0 && (
                <>
                  <WierszMakro
                    pozycje={[
                      { etykieta: 'kcal', wartosc: Math.round(suma.kcal), jednostka: '', cel: cel?.kcal },
                      { etykieta: 'białko', wartosc: Math.round(suma.bialko), jednostka: ' g', cel: cel?.bialko_g },
                      { etykieta: 'tłuszcz', wartosc: Math.round(suma.tluszcz), jednostka: ' g', cel: cel?.tluszcz_g },
                      { etykieta: 'węgle', wartosc: Math.round(suma.wegle), jednostka: ' g', cel: cel?.wegle_g },
                      { etykieta: 'błonnik', wartosc: Math.round(suma.blonnik), jednostka: ' g', cel: cel?.blonnik_g ?? undefined },
                    ]}
                  />

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
                      style={[
                        styles.bilans,
                        {
                          borderLeftColor:
                            suma.bialko < cel.bialko_g ? motyw.accent : motyw.border,
                          backgroundColor: motyw.background,
                        },
                      ]}>
                      <ThemedText
                        type="smallBold"
                        themeColor={suma.bialko < cel.bialko_g ? 'accent' : 'text'}>
                        {opisBilansu(suma, cel)}
                      </ThemedText>
                    </View>
                  )}

                </>
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

  /*
    Pasek nagłówka dnia. Ujemne marginesy znoszą wewnętrzny odstęp karty,
    żeby tło paska sięgało jej krawędzi — inaczej byłby prostokątem
    pływającym w środku i nie czytałby się jako granica dnia.
  */
  pasekDnia: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
    marginTop: -Spacing.three,
    marginHorizontal: -Spacing.three,
    marginBottom: Spacing.one,
    paddingHorizontal: Spacing.three,
    paddingVertical: Spacing.two,
    borderTopLeftRadius: Spacing.three,
    borderTopRightRadius: Spacing.three,
    borderBottomWidth: 1,
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

  /* Bilans dnia — pasek z lewą krawędzią, żeby odciąć go od zwykłych zdań. */
  bilans: {
    borderLeftWidth: 3,
    paddingLeft: Spacing.two,
    paddingVertical: Spacing.one,
    borderRadius: 0,
  },
  posilek: {
    gap: Spacing.one,
    paddingBottom: Spacing.two,
  },
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
  pozycja: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.one,
  },
  naglowekPozycji: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  wierszPozycji: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  makroPozycji: { marginLeft: 'auto' },
  otworzPrzepis: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.half,
  },
  nazwaDania: { flex: 1 },
});
