import { Ionicons } from '@expo/vector-icons';
import { router } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { FormularzSkladnika } from '@/components/formularz-skladnika';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { pobierzSkladniki, usunSkladnik, type Skladnik } from '@/lib/skladniki';

const OPIS_ZRODLA: Record<Skladnik['zrodlo'], string> = {
  usda: 'USDA',
  open_food_facts: 'Open Food Facts',
  wlasne: 'wpisane ręcznie',
};

export default function EkranSkladnikow() {
  const motyw = useTheme();

  const [skladniki, setSkladniki] = useState<Skladnik[]>([]);
  const [szukaj, setSzukaj] = useState('');
  const [edytowany, setEdytowany] = useState<Skladnik | null>(null);
  const [dodawanie, setDodawanie] = useState(false);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      setSkladniki(await pobierzSkladniki());
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, []);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  const widoczne = useMemo(() => {
    const fraza = szukaj.trim().toLowerCase();
    if (!fraza) return skladniki;
    return skladniki.filter(
      (s) =>
        s.nazwa.toLowerCase().includes(fraza) ||
        s.tagi.some((t) => t.toLowerCase().includes(fraza))
    );
  }, [skladniki, szukaj]);

  async function usun(s: Skladnik) {
    setBlad(null);
    try {
      await usunSkladnik(s.id);
      setSkladniki((p) => p.filter((x) => x.id !== s.id));
    } catch (e) {
      const tresc = komunikatBledu(e);
      setBlad(
        tresc.includes('violates foreign key')
          ? `Nie można usunąć „${s.nazwa}” — składnik jest używany w przepisie.`
          : tresc
      );
    }
  }

  if (edytowany || dodawanie) {
    return (
      <Ekran tytul={edytowany ? edytowany.nazwa : 'Nowy składnik'}>
        <FormularzSkladnika
          skladnik={edytowany ?? undefined}
          onZapisano={() => {
            setEdytowany(null);
            setDodawanie(false);
            pobierz();
          }}
          onAnuluj={() => {
            setEdytowany(null);
            setDodawanie(false);
          }}
        />
      </Ekran>
    );
  }

  return (
    <Ekran
      tytul="Składniki"
      podtytul={wczytywanie ? 'wczytywanie…' : `${skladniki.length} w bazie`}>
      <Pole
        etykieta="Szukaj po nazwie lub etykiecie"
        value={szukaj}
        onChangeText={setSzukaj}
        placeholder="dorsz, warzywo, orzechy…"
      />

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      <Przycisk tytul="Dodaj składnik" onPress={() => setDodawanie(true)} />

      {szukaj.trim() && (
        <ThemedText type="small" themeColor="textSecondary">
          Pasujących: {widoczne.length}
        </ThemedText>
      )}

      {widoczne.map((s) => (
        <Karta key={s.id}>
          <View style={styles.naglowek}>
            <ThemedText type="default" style={styles.nazwa}>
              {s.nazwa}
            </ThemedText>
            <Pressable onPress={() => usun(s)} hitSlop={8} accessibilityLabel={`Usuń ${s.nazwa}`}>
              <Ionicons name="trash-outline" size={18} color={motyw.textSecondary} />
            </Pressable>
          </View>

          <ThemedText type="small" themeColor="textSecondary">
            {s.kcal_100g} kcal · B {s.bialko_100g} g · T {s.tluszcz_100g} g · W {s.wegle_100g} g
            {'  (na 100 g)'}
          </ThemedText>

          <ThemedText type="small" themeColor="textSecondary">
            {OPIS_ZRODLA[s.zrodlo]}
            {s.nova ? ` · NOVA ${s.nova}` : ''}
            {s.gramatura_opakowania_g ? ` · opakowanie ${s.gramatura_opakowania_g} g` : ''}
            {s.cukry_wolne_100g > 0 ? ` · cukry wolne ${s.cukry_wolne_100g} g` : ''}
          </ThemedText>

          {s.tagi.length > 0 && (
            <ThemedText type="small" themeColor="textSecondary">
              {s.tagi.join(' · ')}
            </ThemedText>
          )}

          <Przycisk tytul="Edytuj" wariant="poboczny" onPress={() => setEdytowany(s)} />
        </Karta>
      ))}

      {!wczytywanie && widoczne.length === 0 && (
        <ThemedText type="small" themeColor="textSecondary">
          Nic nie pasuje do wpisanej frazy.
        </ThemedText>
      )}

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => router.back()} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  naglowek: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  nazwa: { flex: 1 },
});
