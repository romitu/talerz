import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Makro } from '@/components/makro';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Wybor } from '@/components/wybor';
import { WyborWielo } from '@/components/wybor-wielo';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { OPIS_KUCHNI, OPIS_PORY, opisTrwalosci, type Kuchnia, type PoraPosilku } from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';

type Skladnik = {
  id: string;
  nazwa: string;
  kcal_100g: number;
  bialko_100g: number;
  tluszcz_100g: number;
  wegle_100g: number;
  cukry_wolne_100g: number;
  nova: number | null;
};

type WybranySkladnik = {
  skladnik: Skladnik;
  gramy: string;
  opisPotoczny: string;
};

type Krok = { etap: 'przygotowanie' | 'wykonanie'; tresc: string };

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
  const [kroki, setKroki] = useState<Krok[]>([]);
  const [nowyKrok, setNowyKrok] = useState('');
  const [etapKroku, setEtapKroku] = useState<'przygotowanie' | 'wykonanie'>('przygotowanie');

  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierzSkladniki = useCallback(async () => {
    const { data, error } = await supabase
      .from('skladniki')
      .select('id, nazwa, kcal_100g, bialko_100g, tluszcz_100g, wegle_100g, cukry_wolne_100g, nova')
      .order('nazwa');
    if (error) setBlad(error.message);
    else setDostepne((data ?? []) as Skladnik[]);
  }, []);

  useEffect(() => {
    pobierzSkladniki();
  }, [pobierzSkladniki]);

  const podpowiedzi = useMemo(() => {
    const fraza = szukaj.trim().toLowerCase();
    if (fraza.length < 2) return [];
    const juzWybrane = new Set(wybrane.map((w) => w.skladnik.id));
    return dostepne
      .filter((s) => !juzWybrane.has(s.id) && s.nazwa.toLowerCase().includes(fraza))
      .slice(0, 6);
  }, [szukaj, dostepne, wybrane]);

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

  function dodajKrok() {
    if (!nowyKrok.trim()) return;
    setKroki((p) => [...p, { etap: etapKroku, tresc: nowyKrok.trim() }]);
    setNowyKrok('');
  }

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

      if (kroki.length > 0) {
        const numeracja = { przygotowanie: 0, wykonanie: 0 };
        const { error: bladKrokow } = await supabase.from('kroki').insert(
          kroki.map((k) => {
            numeracja[k.etap] += 1;
            return {
              przepis_id: przepis.id,
              etap: k.etap,
              kolejnosc: numeracja[k.etap],
              tresc: k.tresc,
            };
          })
        );
        if (bladKrokow) throw bladKrokow;
      }

      router.back();
    } catch (e) {
      setBlad(e instanceof Error ? e.message : String(e));
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

        <Pole
          etykieta="Szukaj w bazie"
          value={szukaj}
          onChangeText={setSzukaj}
          placeholder="dorsz, kasza, oliwa…"
        />

        {podpowiedzi.map((s) => (
          <Pressable
            key={s.id}
            onPress={() => dodajSkladnik(s)}
            style={({ pressed }) => [
              styles.podpowiedz,
              { borderColor: motyw.border, backgroundColor: motyw.background },
              pressed && styles.wcisniety,
            ]}>
            <ThemedText type="small">{s.nazwa}</ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {s.kcal_100g} kcal / 100 g
            </ThemedText>
          </Pressable>
        ))}

        {szukaj.trim().length >= 2 && podpowiedzi.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Nic nie znaleziono. Składnik trzeba najpierw dodać do bazy.
          </ThemedText>
        )}

        {wybrane.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Bez składników nie ma z czego policzyć makro.
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
          KROKI
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Najpierw wszystko przygotuj, potem gotuj — to układ, który odróżnia Talerz od
          przepisów z internetu.
        </ThemedText>

        {kroki.map((k, i) => (
          <View key={`${k.etap}-${i}`} style={styles.krok}>
            <ThemedText type="small" themeColor={k.etap === 'przygotowanie' ? 'accent' : 'text'}>
              {k.etap === 'przygotowanie' ? 'PRZYGOTOWANIE' : 'WYKONANIE'}
            </ThemedText>
            <ThemedText type="small">{k.tresc}</ThemedText>
          </View>
        ))}

        <Wybor
          etykieta="Etap"
          wybrana={etapKroku}
          onZmiana={setEtapKroku}
          opcje={[
            { wartosc: 'przygotowanie', etykieta: 'Przygotowanie' },
            { wartosc: 'wykonanie', etykieta: 'Wykonanie' },
          ]}
        />
        <Pole
          etykieta="Treść kroku"
          value={nowyKrok}
          onChangeText={setNowyKrok}
          placeholder="Rozgrzej piekarnik do 200 stopni"
          multiline
        />
        <Przycisk tytul="Dodaj krok" wariant="poboczny" onPress={dodajKrok} />
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
  podpowiedz: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: 2,
  },
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
  krok: {
    gap: 2,
    paddingVertical: Spacing.one,
  },
});
