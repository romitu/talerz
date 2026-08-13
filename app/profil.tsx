import { useCallback, useEffect, useState } from 'react';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { CEL_DNIA } from '@/data/plan';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';

type Profil = {
  id: string;
  imie: string;
  plec: string;
  data_urodzenia: string;
  wzrost_cm: number;
};

type Konto = {
  rola: string;
};

/** Wiek w pełnych latach na podstawie daty urodzenia. */
function wiek(dataUrodzenia: string): number {
  const urodziny = new Date(dataUrodzenia);
  const dzis = new Date();
  let lata = dzis.getFullYear() - urodziny.getFullYear();
  const miesiac = dzis.getMonth() - urodziny.getMonth();
  if (miesiac < 0 || (miesiac === 0 && dzis.getDate() < urodziny.getDate())) {
    lata -= 1;
  }
  return lata;
}

export default function EkranProfilu() {
  const { sesja } = useSesja();
  const [profile, setProfile] = useState<Profil[]>([]);
  const [konto, setKonto] = useState<Konto | null>(null);
  const [ladowanie, setLadowanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setLadowanie(true);
    setBlad(null);

    const [wynikProfili, wynikKonta] = await Promise.all([
      supabase.from('profile').select('id, imie, plec, data_urodzenia, wzrost_cm').order('kolejnosc'),
      supabase.from('konta').select('rola').single(),
    ]);

    if (wynikProfili.error) {
      setBlad(wynikProfili.error.message);
    } else {
      setProfile(wynikProfili.data ?? []);
    }

    if (!wynikKonta.error) {
      setKonto(wynikKonta.data);
    }

    setLadowanie(false);
  }, []);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  return (
    <Ekran tytul="Profil" podtytul={sesja?.user.email ?? undefined}>
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          KONTO
        </ThemedText>
        <ThemedText type="small">Adres: {sesja?.user.email}</ThemedText>
        <ThemedText type="small">Rola: {konto?.rola ?? 'wczytywanie…'}</ThemedText>
      </Karta>

      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          PROFILE ({profile.length} z 3)
        </ThemedText>

        {ladowanie && (
          <ThemedText type="small" themeColor="textSecondary">
            Wczytywanie z bazy…
          </ThemedText>
        )}

        {blad && (
          <ThemedText type="small" themeColor="accent">
            Nie udało się wczytać: {blad}
          </ThemedText>
        )}

        {!ladowanie && !blad && profile.length === 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Nie masz jeszcze żadnego profilu. Dodawanie profili powstanie w następnym kroku.
          </ThemedText>
        )}

        {profile.map((p) => (
          <View key={p.id} style={styles.wiersz}>
            <ThemedText type="small">
              {p.imie} — {wiek(p.data_urodzenia)} lat, {p.wzrost_cm} cm
            </ThemedText>
          </View>
        ))}

        <Przycisk tytul="Odśwież" wariant="poboczny" onPress={pobierz} zajety={ladowanie} />
      </Karta>

      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          CELE DZIENNE
        </ThemedText>
        <ThemedText type="small">Kalorie: {CEL_DNIA.kcal} kcal</ThemedText>
        <ThemedText type="small">Białko: {CEL_DNIA.bialko} g</ThemedText>
        <ThemedText type="small">Tłuszcz: {CEL_DNIA.tluszcz} g</ThemedText>
        <ThemedText type="small">Węglowodany: {CEL_DNIA.wegle} g</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Na razie wartości stałe. Wyliczanie z wieku, wzrostu i aktywności — następny krok.
        </ThemedText>
      </Karta>

      <Przycisk
        tytul="Wyloguj się"
        wariant="poboczny"
        onPress={() => supabase.auth.signOut()}
        style={styles.wyloguj}
      />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  wiersz: {
    paddingVertical: Spacing.half,
  },
  wyloguj: {
    marginTop: Spacing.two,
  },
});
