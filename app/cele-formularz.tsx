import { router, useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Makro } from '@/components/makro';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { supabase } from '@/lib/supabase';
import {
  kcalZMakro,
  oceniaCele,
  progBialkaNaPosilek,
  przemianaPodstawowa,
  udzialyProcentowe,
  wiekZDaty,
  zapotrzebowanie,
  type Plec,
  type PoziomAktywnosci,
} from '@/lib/zywienie';

type Profil = {
  id: string;
  imie: string;
  plec: Plec;
  data_urodzenia: string;
  wzrost_cm: number;
  aktywnosc: PoziomAktywnosci;
};

function liczba(tekst: string): number {
  const n = Number(tekst.replace(',', '.').trim());
  return Number.isFinite(n) && n >= 0 ? n : 0;
}

export default function FormularzCelow() {
  const { profil: profilId } = useLocalSearchParams<{ profil: string }>();

  const [profil, setProfil] = useState<Profil | null>(null);
  const [waga, setWaga] = useState<number | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);

  const [bialko, setBialko] = useState('');
  const [tluszcz, setTluszcz] = useState('');
  const [wegle, setWegle] = useState('');

  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    if (!profilId) return;
    setWczytywanie(true);

    const [wynikProfilu, wynikWagi] = await Promise.all([
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
    ]);

    if (wynikProfilu.error) setBlad(wynikProfilu.error.message);
    else setProfil(wynikProfilu.data as Profil);

    if (wynikWagi.data) setWaga(Number(wynikWagi.data.wartosc));

    setWczytywanie(false);
  }, [profilId]);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  if (wczytywanie) {
    return (
      <Ekran tytul="Cele dzienne">
        <ThemedText type="small" themeColor="textSecondary">
          Wczytywanie…
        </ThemedText>
      </Ekran>
    );
  }

  if (!profil || waga === null) {
    return (
      <Ekran tytul="Cele dzienne">
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {!profil ? 'Nie znaleziono profilu.' : 'Brak zapisanej wagi — bez niej nie da się policzyć zapotrzebowania.'}
          </ThemedText>
        </Karta>
        <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => router.back()} />
      </Ekran>
    );
  }

  const wiek = wiekZDaty(profil.data_urodzenia);
  const przemiana = przemianaPodstawowa(profil.plec, waga, profil.wzrost_cm, wiek);
  const zapotrzeb = zapotrzebowanie(profil.plec, waga, profil.wzrost_cm, wiek, profil.aktywnosc);

  const b = liczba(bialko);
  const t = liczba(tluszcz);
  const w = liczba(wegle);
  const kcal = kcalZMakro(b, t, w);
  const cokolwiek = b > 0 || t > 0 || w > 0;

  const udzialy = udzialyProcentowe({ kcal, bialko: b, tluszcz: t, wegle: w });
  const ocena = oceniaCele({ kcal, bialko: b, tluszcz: t, wegle: w }, przemiana, zapotrzeb);
  const wolnoZapisac = cokolwiek && ocena.blokady.length === 0;

  /** Wypełnia pola propozycją: zapotrzebowanie minus umiarkowany deficyt, podział w środku AMDR. */
  function zaproponuj() {
    const cel = Math.max(przemiana, zapotrzeb - 400);
    const bialkoG = Math.round((cel * 0.25) / 4);
    const tluszczG = Math.round((cel * 0.3) / 9);
    const wegleG = Math.round((cel * 0.45) / 4);
    setBialko(String(bialkoG));
    setTluszcz(String(tluszczG));
    setWegle(String(wegleG));
  }

  async function zapisz() {
    setBlad(null);
    setZajety(true);
    try {
      const { error } = await supabase.from('cele').upsert(
        {
          profil_id: profil!.id,
          obowiazuje_od: new Date().toISOString().slice(0, 10),
          kcal,
          bialko_g: Math.round(b),
          tluszcz_g: Math.round(t),
          wegle_g: Math.round(w),
        },
        { onConflict: 'profil_id,obowiazuje_od' }
      );
      if (error) throw error;
      router.back();
    } catch (e) {
      setBlad(e instanceof Error ? e.message : String(e));
    } finally {
      setZajety(false);
    }
  }

  return (
    <Ekran tytul="Cele dzienne" podtytul={`${profil.imie}, ${wiek} lat, ${waga} kg`}>
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          PUNKT ODNIESIENIA
        </ThemedText>
        <ThemedText type="small">Przemiana podstawowa: {przemiana} kcal</ThemedText>
        <ThemedText type="small">Zapotrzebowanie dzienne: {zapotrzeb} kcal</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Deficyt do 1000 kcal dziennie oznacza chudnięcie około 1 kg tygodniowo. Większego
          aplikacja nie pozwoli ustawić.
        </ThemedText>
      </Karta>

      <Karta style={styles.formularz}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          MAKROSKŁADNIKI W GRAMACH
        </ThemedText>

        <Pole etykieta="Białko (g)" value={bialko} onChangeText={setBialko} inputMode="numeric" placeholder="142" />
        <Pole etykieta="Tłuszcz (g)" value={tluszcz} onChangeText={setTluszcz} inputMode="numeric" placeholder="82" />
        <Pole etykieta="Węglowodany (g)" value={wegle} onChangeText={setWegle} inputMode="numeric" placeholder="246" />

        <Przycisk tytul="Podpowiedz wartości" wariant="poboczny" onPress={zaproponuj} />
      </Karta>

      {cokolwiek && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            WYNIK
          </ThemedText>
          <View style={styles.wiersz}>
            <Makro etykieta="kalorie" wartosc={kcal} jednostka="" cel={zapotrzeb} />
            <Makro etykieta="białko" wartosc={udzialy.bialko} jednostka="%" />
            <Makro etykieta="tłuszcz" wartosc={udzialy.tluszcz} jednostka="%" />
            <Makro etykieta="węglow." wartosc={udzialy.wegle} jednostka="%" />
          </View>
          <ThemedText type="small" themeColor="textSecondary">
            Próg białka na posiłek: {progBialkaNaPosilek(b)} g
          </ThemedText>
        </Karta>
      )}

      {ocena.blokady.length > 0 && (
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

      {ocena.ostrzezenia.length > 0 && ocena.blokady.length === 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            DO ROZWAŻENIA
          </ThemedText>
          {ocena.ostrzezenia.map((tresc) => (
            <ThemedText key={tresc} type="small" themeColor="textSecondary">
              {tresc}
            </ThemedText>
          ))}
          <ThemedText type="small" themeColor="textSecondary">
            To odstępstwa od zaleceń, nie zagrożenie. Zapisanie jest możliwe.
          </ThemedText>
        </Karta>
      )}

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <Przycisk tytul="Zapisz cele" onPress={zapisz} zajety={zajety} wylaczony={!wolnoZapisac} />
      <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => router.back()} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  formularz: { gap: Spacing.three },
  wiersz: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
    paddingTop: Spacing.half,
  },
});
