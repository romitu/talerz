import { Ionicons } from '@expo/vector-icons';
import { useFocusEffect } from 'expo-router';
import { useCallback, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Makro } from '@/components/makro';
import { Przycisk } from '@/components/przycisk';
import { TabelaWyboru } from '@/components/tabela-wyboru';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import {
  czyDzisiaj,
  dniPlanu,
  naDate,
  oznaczDzien,
  opisDnia,
  pobierzPlan,
  pobierzPozycje,
  PORY,
  przypiszPosilek,
  sumujDzien,
  usunPosilek,
  utworzPlan,
  zmienPorcje,
  type Plan,
  type PozycjaPlanu,
} from '@/lib/plan';
import { OPIS_PORY, pobierzPrzepisy, type PoraPosilku, type PrzepisZMakro } from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import { progBialkaNaPosilek } from '@/lib/zywienie';

type Cel = {
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number | null;
};

/** Miejsce w planie, do którego wybieramy przepis. */
type Wolne = { data: string; pora: PoraPosilku } | null;

export default function EkranPlanu() {
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [plan, setPlan] = useState<Plan | null>(null);
  const [pozycje, setPozycje] = useState<PozycjaPlanu[]>([]);
  const [przepisy, setPrzepisy] = useState<PrzepisZMakro[]>([]);
  const [cel, setCel] = useState<Cel | null>(null);
  const [wybierany, setWybierany] = useState<Wolne>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const [p, lista, wynikCelu] = await Promise.all([
        pobierzPlan(),
        pobierzPrzepisy(sesja?.user.id),
        supabase
          .from('cele')
          .select('kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g')
          .order('obowiazuje_od', { ascending: false })
          .limit(1)
          .maybeSingle(),
      ]);

      setPlan(p);
      setPrzepisy(lista);
      if (!wynikCelu.error) setCel(wynikCelu.data);
      setPozycje(p ? await pobierzPozycje(p.id) : []);
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [sesja?.user.id]);

  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

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
            dane={przepisy.filter((p) => p.pory.length === 0 || p.pory.includes(wybierany.pora))}
            klucz={(p) => p.id}
            tekstDoFiltra={(p) => p.nazwa}
            etykietaFiltra="Filtruj przepisy"
            placeholderFiltra="zupa, dorsz, owsianka…"
            wybrane={[]}
            onPrzelacz={(p) =>
              zDbem(async () => {
                if (plan) await przypiszPosilek(plan.id, wybierany.data, wybierany.pora, p.id);
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

        <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => setWybierany(null)} />
      </Ekran>
    );
  }

  const progBialka = cel ? progBialkaNaPosilek(cel.bialko_g) : null;

  return (
    <Ekran
      tytul="Plan dnia"
      podtytul={plan ? `${plan.dni} dni od ${opisDnia(plan.data_start)}` : undefined}>
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

      {plan &&
        dniPlanu(plan).map((data) => {
          const dzien = wedlugDnia.get(data) ?? [];
          const suma = sumujDzien(dzien);
          const dzisiaj = czyDzisiaj(data);
          const wszystkoZjedzone = dzien.length > 0 && dzien.every((p) => p.zjedzone);

          return (
            <Karta key={data} style={dzisiaj ? { borderWidth: 2, borderColor: motyw.accent } : undefined}>
              <View style={styles.naglowekDnia}>
                <ThemedText type="smallBold" themeColor={dzisiaj ? 'accent' : 'text'}>
                  {opisDnia(data)}
                  {dzisiaj ? ' · dzisiaj' : ''}
                </ThemedText>
                {dzien.length > 0 && (
                  <ThemedText type="small" themeColor="textSecondary">
                    {Math.round(suma.kcal)} kcal
                  </ThemedText>
                )}
              </View>

              {PORY.map((pora) => {
                const pozycja = dzien.find((p) => p.pora === pora);

                if (!pozycja) {
                  return (
                    <Pressable
                      key={pora}
                      onPress={() => setWybierany({ data, pora })}
                      style={({ pressed }) => [
                        styles.puste,
                        { borderColor: motyw.border },
                        pressed && styles.wcisniete,
                      ]}>
                      <Ionicons name="add-circle-outline" size={18} color={motyw.textSecondary} />
                      <ThemedText type="small" themeColor="textSecondary">
                        {OPIS_PORY[pora]} — wybierz przepis
                      </ThemedText>
                    </Pressable>
                  );
                }

                const zaMaloBialka =
                  progBialka !== null && pozycja.bialko_g * pozycja.porcje < progBialka;

                return (
                  <View key={pora} style={[styles.pozycja, { borderColor: motyw.border }]}>
                    <View style={styles.naglowekPozycji}>
                      <ThemedText type="small" themeColor="accent">
                        {OPIS_PORY[pora].toUpperCase()}
                      </ThemedText>
                      <Pressable
                        onPress={() => zDbem(() => usunPosilek(pozycja.id))}
                        hitSlop={8}
                        accessibilityLabel="Usuń posiłek">
                        <Ionicons name="close" size={16} color={motyw.textSecondary} />
                      </Pressable>
                    </View>

                    <ThemedText type="small">{pozycja.nazwa}</ThemedText>

                    <View style={styles.wierszPozycji}>
                      <Pressable
                        onPress={() =>
                          zDbem(() => zmienPorcje(pozycja.id, Math.max(1, pozycja.porcje - 1)))
                        }
                        hitSlop={6}>
                        <Ionicons name="remove-circle-outline" size={20} color={motyw.accent} />
                      </Pressable>

                      <ThemedText type="smallBold">{pozycja.porcje} porcji</ThemedText>

                      <Pressable
                        onPress={() =>
                          zDbem(() => zmienPorcje(pozycja.id, Math.min(5, pozycja.porcje + 1)))
                        }
                        hitSlop={6}>
                        <Ionicons name="add-circle-outline" size={20} color={motyw.accent} />
                      </Pressable>

                      <ThemedText type="small" themeColor="textSecondary" style={styles.makroPozycji}>
                        {Math.round(pozycja.kcal * pozycja.porcje)} kcal ·{' '}
                        {Math.round(pozycja.bialko_g * pozycja.porcje * 10) / 10} g białka
                      </ThemedText>
                    </View>

                    {zaMaloBialka && (
                      <ThemedText type="small" themeColor="accent">
                        Poniżej {progBialka} g białka — warto dołożyć porcję mięsa, ryby lub strączków.
                      </ThemedText>
                    )}
                  </View>
                );
              })}

              {dzien.length > 0 && (
                <>
                  <View style={styles.wierszMakro}>
                    <Makro etykieta="kalorie" wartosc={Math.round(suma.kcal)} jednostka="" cel={cel?.kcal} />
                    <Makro etykieta="białko" wartosc={Math.round(suma.bialko)} jednostka=" g" cel={cel?.bialko_g} />
                    <Makro etykieta="tłuszcz" wartosc={Math.round(suma.tluszcz)} jednostka=" g" cel={cel?.tluszcz_g} />
                    <Makro etykieta="węglow." wartosc={Math.round(suma.wegle)} jednostka=" g" cel={cel?.wegle_g} />
                    <Makro
                      etykieta="błonnik"
                      wartosc={Math.round(suma.blonnik)}
                      jednostka=" g"
                      cel={cel?.blonnik_g ?? undefined}
                    />
                  </View>

                  {/*
                    Zapisywanie przez wyjątek: jedno dotknięcie zamyka cały dzień.
                    Wpisywanie każdego posiłku osobno jest głównym powodem,
                    dla którego ludzie porzucają takie aplikacje.
                  */}
                  <Przycisk
                    tytul={wszystkoZjedzone ? 'Dzień potwierdzony — cofnij' : 'Poszło zgodnie z planem'}
                    wariant={wszystkoZjedzone ? 'poboczny' : 'glowny'}
                    onPress={() =>
                      zDbem(() => oznaczDzien(plan.id, data, !wszystkoZjedzone))
                    }
                  />
                </>
              )}
            </Karta>
          );
        })}
    </Ekran>
  );
}

const styles = StyleSheet.create({
  naglowekDnia: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
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
  wierszMakro: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
    paddingTop: Spacing.two,
  },
});
