import { Ionicons } from '@expo/vector-icons';
import { router, useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { dniPlanu, opisDnia, pobierzPlan, type Plan } from '@/lib/plan';
import { dzialDla, DZIALY, pobierzListeZakupow, type PozycjaZakupow } from '@/lib/zakupy';

/** Zaokrąglenie do wygodnej postaci: 1250 g → „1,25 kg”. */
function opisIlosci(gramy: number): string {
  if (gramy >= 1000) return `${(gramy / 1000).toFixed(2).replace('.', ',')} kg`;
  return `${gramy} g`;
}

export default function EkranZakupow() {
  const { dni } = useLocalSearchParams<{ dni?: string }>();
  const motyw = useTheme();

  const [plan, setPlan] = useState<Plan | null>(null);
  const [pozycje, setPozycje] = useState<PozycjaZakupow[]>([]);
  const [kupione, setKupione] = useState<Set<string>>(new Set());
  const [zakres, setZakres] = useState(Number(dni) || 7);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const p = await pobierzPlan();
      setPlan(p);
      if (!p) {
        setPozycje([]);
        return;
      }
      const dniListy = dniPlanu(p).slice(0, zakres);
      setPozycje(
        await pobierzListeZakupow(p.id, dniListy[0], dniListy[dniListy.length - 1])
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, [zakres]);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  const wedlugDzialow = useMemo(() => {
    const mapa = new Map<string, PozycjaZakupow[]>();
    for (const p of pozycje) {
      const dzial = dzialDla(p.tagi);
      mapa.set(dzial, [...(mapa.get(dzial) ?? []), p]);
    }
    return mapa;
  }, [pozycje]);

  const doKupienia = pozycje.filter((p) => !kupione.has(p.skladnik_id)).length;
  const resztyRazem = pozycje.reduce((s, p) => s + (p.reszta_g ?? 0), 0);

  function przelacz(id: string) {
    setKupione((p) => {
      const n = new Set(p);
      if (n.has(id)) n.delete(id);
      else n.add(id);
      return n;
    });
  }

  return (
    <Ekran
      tytul="Lista zakupów"
      podtytul={
        wczytywanie
          ? 'wczytywanie…'
          : plan
            ? `${zakres} dni od ${opisDnia(plan.data_start)} · zostało ${doKupienia} pozycji`
            : undefined
      }>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      <View style={styles.zakres}>
        {[3, 7].map((n) => (
          <Przycisk
            key={n}
            tytul={`${n} dni`}
            wariant={zakres === n ? 'glowny' : 'poboczny'}
            onPress={() => setZakres(n)}
            style={styles.przyciskZakresu}
          />
        ))}
      </View>

      {!wczytywanie && pozycje.length === 0 && (
        <Karta>
          <ThemedText type="default">Nie ma czego kupować</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Lista powstaje z posiłków wpisanych do planu. Przypisz przepisy do dni,
            a składniki zbiorą się tutaj same.
          </ThemedText>
        </Karta>
      )}

      {DZIALY.map((dzial) => {
        const wDziale = wedlugDzialow.get(dzial.nazwa);
        if (!wDziale || wDziale.length === 0) return null;

        return (
          <Karta key={dzial.nazwa}>
            <ThemedText type="smallBold" themeColor="textSecondary">
              {dzial.nazwa.toUpperCase()}
            </ThemedText>

            {wDziale.map((p) => {
              const odhaczony = kupione.has(p.skladnik_id);

              return (
                <Pressable
                  key={p.skladnik_id}
                  onPress={() => przelacz(p.skladnik_id)}
                  style={({ pressed }) => [
                    styles.pozycja,
                    { borderColor: motyw.border },
                    pressed && styles.wcisnieta,
                  ]}>
                  <Ionicons
                    name={odhaczony ? 'checkbox' : 'square-outline'}
                    size={20}
                    color={odhaczony ? motyw.accent : motyw.textSecondary}
                  />

                  <View style={styles.trescPozycji}>
                    <ThemedText
                      type={odhaczony ? 'small' : 'smallBold'}
                      themeColor={odhaczony ? 'textSecondary' : 'text'}>
                      {p.nazwa} — {opisIlosci(p.gramy)}
                    </ThemedText>

                    {p.opakowan !== null && (
                      <ThemedText type="small" themeColor="textSecondary">
                        {p.opakowan}{' '}
                        {p.opakowan === 1 ? 'opakowanie' : 'opakowania'} po {p.opakowanie_g} g
                        {p.reszta_g ? ` · zostanie ${p.reszta_g} g` : ' · bez reszty'}
                      </ThemedText>
                    )}

                    <ThemedText type="small" themeColor="textSecondary">
                      {p.dania.join(', ')}
                    </ThemedText>
                  </View>
                </Pressable>
              );
            })}
          </Karta>
        );
      })}

      {resztyRazem > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            RESZTKI Z OPAKOWAŃ
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Po ugotowaniu wszystkiego z listy zostanie około {opisIlosci(resztyRazem)} produktów.
            To one najczęściej lądują w koszu — warto dobrać przepis, który je zużyje.
          </ThemedText>
        </Karta>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        Odhaczenia działają tylko w tej sesji — lista wynika z planu, więc po zmianie
        posiłków przeliczy się od nowa.
      </ThemedText>

      <Przycisk tytul="Wróć do planu" wariant="poboczny" onPress={() => router.back()} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  zakres: { flexDirection: 'row', gap: Spacing.two },
  przyciskZakresu: { flex: 1 },
  pozycja: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
  },
  trescPozycji: { flex: 1, gap: 2 },
  wcisnieta: { opacity: 0.7 },
});
