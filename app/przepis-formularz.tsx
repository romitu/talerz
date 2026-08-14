import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Makro } from '@/components/makro';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { FormularzSkladnika } from '@/components/formularz-skladnika';
import { Wybor } from '@/components/wybor';
import { WyborWielo } from '@/components/wybor-wielo';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { OPIS_KUCHNI, OPIS_PORY, opisTrwalosci, type Kuchnia, type PoraPosilku } from '@/lib/przepisy';
import { pobierzSkladniki, type Skladnik } from '@/lib/skladniki';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';

type WybranySkladnik = {
  skladnik: Skladnik;
  gramy: string;
  opisPotoczny: string;
};

type Krok = { tresc: string; uwaga: boolean };

type Etap = {
  nazwa: string;
  minuty: string;
  kroki: Krok[];
};

function liczba(tekst: string): number {
  const n = Number(String(tekst).replace(',', '.').trim());
  return Number.isFinite(n) && n > 0 ? n : 0;
}

export default function FormularzPrzepisu() {
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [dostepne, setDostepne] = useState<Skladnik[]>([]);
  const [szukaj, setSzukaj] = useState('');
  const [wybrane, setWybrane] = useState<WybranySkladnik[]>([]);

  const [nazwa, setNazwa] = useState('');
  const [opis, setOpis] = useState('');
  const [pory, setPory] = useState<PoraPosilku[]>([]);
  const [kuchnie, setKuchnie] = useState<Kuchnia[]>(['srodziemnomorska']);
  const [trwalosc, setTrwalosc] = useState<'0' | '1' | '2' | '3'>('0');
  const [czas, setCzas] = useState('');
  const [etapy, setEtapy] = useState<Etap[]>([]);

  const [pokazWszystkie, setPokazWszystkie] = useState(false);
  const [dodawanieSkladnika, setDodawanieSkladnika] = useState(false);
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const wczytajSkladniki = useCallback(async () => {
    try {
      setDostepne(await pobierzSkladniki());
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }, []);

  useEffect(() => {
    wczytajSkladniki();
  }, [wczytajSkladniki]);

  const podpowiedzi = useMemo(() => {
    const fraza = szukaj.trim().toLowerCase();
    const juzWybrane = new Set(wybrane.map((w) => w.skladnik.id));
    const wolne = dostepne.filter((s) => !juzWybrane.has(s.id));

    // Puste pole i włączony podgląd — pokazujemy całą bazę, żeby dało się
    // przewinąć i wybrać, gdy nie pamięta się nazwy.
    if (!fraza) return pokazWszystkie ? wolne : [];

    return wolne
      .filter(
        (s) =>
          s.nazwa.toLowerCase().includes(fraza) ||
          s.tagi.some((t) => t.toLowerCase().includes(fraza))
      )
      .slice(0, 12);
  }, [szukaj, dostepne, wybrane, pokazWszystkie]);

  // Makro liczone na żywo, tak samo jak potem policzy je baza.
  const makro = useMemo(() => {
    return wybrane.reduce(
      (suma, w) => {
        const g = liczba(w.gramy) / 100;
        return {
          kcal: suma.kcal + w.skladnik.kcal_100g * g,
          bialko: suma.bialko + w.skladnik.bialko_100g * g,
          tluszcz: suma.tluszcz + w.skladnik.tluszcz_100g * g,
          wegle: suma.wegle + w.skladnik.wegle_100g * g,
          cukryWolne: suma.cukryWolne + w.skladnik.cukry_wolne_100g * g,
          nova: Math.max(suma.nova, w.skladnik.nova ?? 0),
        };
      },
      { kcal: 0, bialko: 0, tluszcz: 0, wegle: 0, cukryWolne: 0, nova: 0 }
    );
  }, [wybrane]);

  const komplet =
    nazwa.trim().length >= 3 && wybrane.length > 0 && wybrane.every((w) => liczba(w.gramy) > 0);

  function dodajSkladnik(s: Skladnik) {
    setWybrane((p) => [...p, { skladnik: s, gramy: '', opisPotoczny: '' }]);
    setSzukaj('');
  }

  function zmienGramy(id: string, wartosc: string) {
    setWybrane((p) => p.map((w) => (w.skladnik.id === id ? { ...w, gramy: wartosc } : w)));
  }

  function zmienOpis(id: string, wartosc: string) {
    setWybrane((p) => p.map((w) => (w.skladnik.id === id ? { ...w, opisPotoczny: wartosc } : w)));
  }

  function usunSkladnik(id: string) {
    setWybrane((p) => p.filter((w) => w.skladnik.id !== id));
  }

  function dodajEtap() {
    setEtapy((p) => [...p, { nazwa: '', minuty: '', kroki: [] }]);
  }

  function zmienEtap(indeks: number, pole: 'nazwa' | 'minuty', wartosc: string) {
    setEtapy((p) => p.map((e, i) => (i === indeks ? { ...e, [pole]: wartosc } : e)));
  }

  function usunEtap(indeks: number) {
    setEtapy((p) => p.filter((_, i) => i !== indeks));
  }

  function przesunEtap(indeks: number, oIle: number) {
    setEtapy((p) => {
      const cel = indeks + oIle;
      if (cel < 0 || cel >= p.length) return p;
      const nowe = [...p];
      [nowe[indeks], nowe[cel]] = [nowe[cel], nowe[indeks]];
      return nowe;
    });
  }

  function dodajKrok(indeksEtapu: number) {
    setEtapy((p) =>
      p.map((e, i) => (i === indeksEtapu ? { ...e, kroki: [...e.kroki, { tresc: '', uwaga: false }] } : e))
    );
  }

  function zmienKrok(indeksEtapu: number, indeksKroku: number, zmiana: Partial<Krok>) {
    setEtapy((p) =>
      p.map((e, i) =>
        i === indeksEtapu
          ? { ...e, kroki: e.kroki.map((k, j) => (j === indeksKroku ? { ...k, ...zmiana } : k)) }
          : e
      )
    );
  }

  function usunKrok(indeksEtapu: number, indeksKroku: number) {
    setEtapy((p) =>
      p.map((e, i) =>
        i === indeksEtapu ? { ...e, kroki: e.kroki.filter((_, j) => j !== indeksKroku) } : e
      )
    );
  }

  /** Suma czasów etapów — górne oszacowanie, bo etapy potrafią się nakładać. */
  const czasRazem = etapy.reduce((suma, e) => suma + liczba(e.minuty), 0);

  async function zapisz() {
    setBlad(null);
    if (!sesja) {
      setBlad('Brak zalogowanego użytkownika.');
      return;
    }

    setZajety(true);
    try {
      const { data: przepis, error: bladPrzepisu } = await supabase
        .from('przepisy')
        .insert({
          nazwa: nazwa.trim(),
          opis: opis.trim() || null,
          pory,
          kuchnie,
          trwalosc_dni: Number(trwalosc),
          czas_minut: liczba(czas) || null,
          autor_id: sesja.user.id,
          widocznosc: 'prywatna',
        })
        .select('id')
        .single();
      if (bladPrzepisu) throw bladPrzepisu;

      const { error: bladSkladnikow } = await supabase.from('przepis_skladniki').insert(
        wybrane.map((w, i) => ({
          przepis_id: przepis.id,
          skladnik_id: w.skladnik.id,
          gramy: liczba(w.gramy),
          opis_potoczny: w.opisPotoczny.trim() || null,
          kolejnosc: i + 1,
        }))
      );
      if (bladSkladnikow) throw bladSkladnikow;

      // Etapy zapisujemy razem, żeby poznać ich identyfikatory,
      // a dopiero potem kroki przypisane do każdego z nich.
      const doZapisu = etapy.filter((e) => e.nazwa.trim());

      if (doZapisu.length > 0) {
        const { data: zapisaneEtapy, error: bladEtapow } = await supabase
          .from('etapy')
          .insert(
            doZapisu.map((e, i) => ({
              przepis_id: przepis.id,
              kolejnosc: i + 1,
              nazwa: e.nazwa.trim(),
              minuty: liczba(e.minuty) || null,
            }))
          )
          .select('id, kolejnosc');
        if (bladEtapow) throw bladEtapow;

        const wedlugKolejnosci = new Map(
          (zapisaneEtapy ?? []).map((e) => [e.kolejnosc as number, e.id as string])
        );

        const krokiDoZapisu = doZapisu.flatMap((e, i) =>
          e.kroki
            .filter((k) => k.tresc.trim())
            .map((k, j) => ({
              etap_id: wedlugKolejnosci.get(i + 1)!,
              kolejnosc: j + 1,
              tresc: k.tresc.trim(),
              uwaga: k.uwaga,
            }))
        );

        if (krokiDoZapisu.length > 0) {
          const { error: bladKrokow } = await supabase.from('kroki').insert(krokiDoZapisu);
          if (bladKrokow) throw bladKrokow;
        }
      }

      router.back();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  return (
    <Ekran tytul="Nowy przepis" podtytul="Makro policzy się ze składników">
      <Karta style={styles.grupa}>
        <Pole etykieta="Nazwa" value={nazwa} onChangeText={setNazwa} placeholder="Dorsz z kaszą gryczaną" />
        <Pole
          etykieta="Krótki opis"
          value={opis}
          onChangeText={setOpis}
          placeholder="Pieczony w piekarniku, warzywa na jednej blasze"
          multiline
        />
        <Pole etykieta="Czas przygotowania (min)" value={czas} onChangeText={setCzas} inputMode="numeric" placeholder="35" />
      </Karta>

      <Karta style={styles.grupa}>
        <WyborWielo
          etykieta="Pora posiłku"
          wybrane={pory}
          onZmiana={setPory}
          opcje={(Object.keys(OPIS_PORY) as PoraPosilku[]).map((k) => ({
            wartosc: k,
            etykieta: OPIS_PORY[k],
          }))}
        />
        <WyborWielo
          etykieta="Kuchnia"
          wybrane={kuchnie}
          onZmiana={setKuchnie}
          opcje={(Object.keys(OPIS_KUCHNI) as Kuchnia[]).map((k) => ({
            wartosc: k,
            etykieta: OPIS_KUCHNI[k],
          }))}
        />
        <Wybor
          etykieta="Ile dni wytrzyma w lodówce"
          wybrana={trwalosc}
          onZmiana={setTrwalosc}
          opcje={[
            { wartosc: '0', etykieta: opisTrwalosci(0), opis: 'jajecznica, sałatki, dania z grilla' },
            { wartosc: '1', etykieta: opisTrwalosci(1), opis: 'dania delikatne, z dużą ilością nabiału' },
            { wartosc: '2', etykieta: opisTrwalosci(2), opis: 'dania rybne, zupy lekkie' },
            { wartosc: '3', etykieta: opisTrwalosci(3), opis: 'zupy, gulasze, kasze i strączki' },
          ]}
        />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          SKŁADNIKI
        </ThemedText>

        <ThemedText type="small" themeColor="textSecondary">
          Krok 1: znajdź składnik i dotknij go, żeby dodać. Krok 2: wpisz, ile gramów
          wchodzi w skład dania.
        </ThemedText>

        <Pole
          etykieta="Wyszukaj składnik"
          value={szukaj}
          onChangeText={(t) => {
            setSzukaj(t);
            if (t) setPokazWszystkie(false);
          }}
          placeholder="dorsz, kasza, ryba, warzywo…"
        />

        {!szukaj.trim() && (
          <Przycisk
            tytul={
              pokazWszystkie
                ? 'Ukryj listę'
                : `Nie pamiętasz nazwy? Pokaż wszystkie (${dostepne.length})`
            }
            wariant="poboczny"
            onPress={() => setPokazWszystkie((p) => !p)}
          />
        )}

        {podpowiedzi.length > 0 && (
          <View style={[styles.lista, { borderColor: motyw.border }]}>
            {podpowiedzi.map((s) => (
              <Pressable
                key={s.id}
                onPress={() => dodajSkladnik(s)}
                accessibilityRole="button"
                accessibilityLabel={`Dodaj ${s.nazwa} do przepisu`}
                style={({ pressed }) => [
                  styles.podpowiedz,
                  { borderColor: motyw.border },
                  pressed && styles.wcisniety,
                ]}>
                <Ionicons name="add-circle-outline" size={20} color={motyw.accent} />
                <View style={styles.trescPodpowiedzi}>
                  <ThemedText type="small">{s.nazwa}</ThemedText>
                  <ThemedText type="small" themeColor="textSecondary">
                    {s.kcal_100g} kcal · {s.bialko_100g} g białka / 100 g
                  </ThemedText>
                </View>
              </Pressable>
            ))}
          </View>
        )}

        {szukaj.trim() && podpowiedzi.length === 0 && !dodawanieSkladnika && (
          <ThemedText type="small" themeColor="textSecondary">
            Nic takiego nie ma w bazie — możesz dodać poniżej.
          </ThemedText>
        )}

        {/*
          Dodawanie składnika odbywa się TUTAJ, bez opuszczania ekranu.
          Przejście na inny ekran wyczyściłoby wszystko, co już wpisano
          w przepisie — nazwę, pozostałe składniki i kroki.
        */}
        {!dodawanieSkladnika && (
          <Przycisk
            tytul={szukaj.trim() ? `Dodaj „${szukaj.trim()}” do bazy` : 'Brakuje składnika? Dodaj go'}
            wariant="poboczny"
            onPress={() => setDodawanieSkladnika(true)}
          />
        )}

        {dodawanieSkladnika && (
          <View style={styles.okienko}>
            <ThemedText type="small" themeColor="textSecondary">
              Przepis pozostaje wpisany — po zapisaniu składnik od razu do niego wejdzie.
            </ThemedText>

            <FormularzSkladnika
              nazwaPoczatkowa={szukaj.trim()}
              onZapisano={(nowy) => {
                setDostepne((p) => [...p, nowy].sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl')));
                setWybrane((p) => [...p, { skladnik: nowy, gramy: '', opisPotoczny: '' }]);
                setDodawanieSkladnika(false);
                setSzukaj('');
              }}
              onAnuluj={() => setDodawanieSkladnika(false)}
            />
          </View>
        )}

        {wybrane.length > 0 && (
          <ThemedText type="smallBold" themeColor="textSecondary">
            W TYM DANIU ({wybrane.length})
          </ThemedText>
        )}

        {wybrane.map((w) => (
          <View key={w.skladnik.id} style={[styles.skladnik, { borderColor: motyw.border }]}>
            <View style={styles.naglowekSkladnika}>
              <ThemedText type="small" style={styles.nazwaSkladnika}>
                {w.skladnik.nazwa}
              </ThemedText>
              <Pressable
                onPress={() => usunSkladnik(w.skladnik.id)}
                accessibilityLabel={`Usuń ${w.skladnik.nazwa}`}
                hitSlop={8}>
                <Ionicons name="close" size={18} color={motyw.textSecondary} />
              </Pressable>
            </View>

            <Pole
              etykieta="Gramy"
              value={w.gramy}
              onChangeText={(t) => zmienGramy(w.skladnik.id, t)}
              inputMode="numeric"
              placeholder="200"
            />
            <Pole
              etykieta="Zapis dla człowieka (nieobowiązkowy)"
              value={w.opisPotoczny}
              onChangeText={(t) => zmienOpis(w.skladnik.id, t)}
              placeholder="1 marchewka (ok. 70 g)"
            />
          </View>
        ))}
      </Karta>

      {wybrane.length > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            MAKRO CAŁEGO DANIA
          </ThemedText>
          <View style={styles.wiersz}>
            <Makro etykieta="kcal" wartosc={Math.round(makro.kcal)} jednostka="" />
            <Makro etykieta="białko" wartosc={Math.round(makro.bialko * 10) / 10} jednostka=" g" />
            <Makro etykieta="tłuszcz" wartosc={Math.round(makro.tluszcz * 10) / 10} jednostka=" g" />
            <Makro etykieta="węglow." wartosc={Math.round(makro.wegle * 10) / 10} jednostka=" g" />
          </View>
          {makro.cukryWolne > 0 && (
            <ThemedText type="small" themeColor="textSecondary">
              Cukry wolne: {Math.round(makro.cukryWolne * 10) / 10} g
            </ThemedText>
          )}
          {makro.nova >= 4 && (
            <ThemedText type="small" themeColor="accent">
              Przepis zawiera składnik wysoko przetworzony (NOVA 4). Talerz takich nie promuje.
            </ThemedText>
          )}
        </Karta>
      )}

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          ETAPY PRZYGOTOWANIA
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Każdy etap ma nazwę, czas i własne kroki — na przykład „Gotowanie wywaru, 45 minut”.
          Krok można oznaczyć jako uwagę, gdy ostrzega przed pomyłką.
        </ThemedText>

        {etapy.map((etap, i) => (
          <View key={i} style={[styles.etap, { borderColor: motyw.border }]}>
            <View style={styles.naglowekEtapu}>
              <ThemedText type="smallBold" themeColor="accent">
                ETAP {i + 1}
              </ThemedText>

              <View style={styles.przyciskiEtapu}>
                <Pressable
                  onPress={() => przesunEtap(i, -1)}
                  disabled={i === 0}
                  hitSlop={6}
                  accessibilityLabel="Przesuń etap wyżej">
                  <Ionicons
                    name="arrow-up"
                    size={18}
                    color={i === 0 ? motyw.border : motyw.textSecondary}
                  />
                </Pressable>
                <Pressable
                  onPress={() => przesunEtap(i, 1)}
                  disabled={i === etapy.length - 1}
                  hitSlop={6}
                  accessibilityLabel="Przesuń etap niżej">
                  <Ionicons
                    name="arrow-down"
                    size={18}
                    color={i === etapy.length - 1 ? motyw.border : motyw.textSecondary}
                  />
                </Pressable>
                <Pressable onPress={() => usunEtap(i)} hitSlop={6} accessibilityLabel="Usuń etap">
                  <Ionicons name="trash-outline" size={18} color={motyw.textSecondary} />
                </Pressable>
              </View>
            </View>

            <Pole
              etykieta="Nazwa etapu"
              value={etap.nazwa}
              onChangeText={(t) => zmienEtap(i, 'nazwa', t)}
              placeholder="Gotowanie wywaru"
            />
            <Pole
              etykieta="Czas etapu (min)"
              value={etap.minuty}
              onChangeText={(t) => zmienEtap(i, 'minuty', t)}
              inputMode="numeric"
              placeholder="45"
            />

            {etap.kroki.map((krok, j) => (
              <View key={j} style={styles.krok}>
                <View style={styles.naglowekKroku}>
                  <ThemedText type="small" themeColor="textSecondary">
                    Krok {j + 1}
                  </ThemedText>

                  <Pressable
                    onPress={() => zmienKrok(i, j, { uwaga: !krok.uwaga })}
                    hitSlop={6}
                    accessibilityRole="checkbox"
                    accessibilityState={{ checked: krok.uwaga }}
                    style={styles.przelacznikUwagi}>
                    <Ionicons
                      name={krok.uwaga ? 'warning' : 'warning-outline'}
                      size={16}
                      color={krok.uwaga ? motyw.accent : motyw.textSecondary}
                    />
                    <ThemedText type="small" themeColor={krok.uwaga ? 'accent' : 'textSecondary'}>
                      uwaga
                    </ThemedText>
                  </Pressable>

                  <Pressable onPress={() => usunKrok(i, j)} hitSlop={6} accessibilityLabel="Usuń krok">
                    <Ionicons name="close" size={16} color={motyw.textSecondary} />
                  </Pressable>
                </View>

                <Pole
                  etykieta=""
                  value={krok.tresc}
                  onChangeText={(t) => zmienKrok(i, j, { tresc: t })}
                  placeholder="Doprowadź do wrzenia i zbierz szumowiny"
                  multiline
                />
              </View>
            ))}

            <Przycisk tytul="Dodaj krok" wariant="poboczny" onPress={() => dodajKrok(i)} />
          </View>
        ))}

        <Przycisk
          tytul={etapy.length === 0 ? 'Dodaj pierwszy etap' : 'Dodaj kolejny etap'}
          wariant="poboczny"
          onPress={dodajEtap}
        />

        {czasRazem > 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Czas wszystkich etapów: {czasRazem} min. Jeśli etapy się nakładają („w międzyczasie”),
            faktyczny czas będzie krótszy.
          </ThemedText>
        )}
      </Karta>

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        Przepis zapisze się jako prywatny. Publikacja wymaga zgłoszenia i zatwierdzenia.
      </ThemedText>

      <Przycisk tytul="Zapisz przepis" onPress={zapisz} zajety={zajety} wylaczony={!komplet} />
      <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => router.back()} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.three },
  lista: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  podpowiedz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    padding: Spacing.two,
    borderBottomWidth: 1,
  },
  trescPodpowiedzi: { flex: 1, gap: 2 },
  wcisniety: { opacity: 0.7 },
  skladnik: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
  },
  naglowekSkladnika: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  nazwaSkladnika: { flex: 1 },
  wiersz: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
    paddingTop: Spacing.half,
  },
  etap: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
  },
  naglowekEtapu: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  przyciskiEtapu: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  krok: {
    gap: Spacing.one,
    paddingTop: Spacing.one,
  },
  naglowekKroku: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  przelacznikUwagi: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    marginLeft: 'auto',
  },
  okienko: {
    gap: Spacing.two,
    paddingTop: Spacing.two,
  },
});
