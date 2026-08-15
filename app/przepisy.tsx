import { Ionicons } from '@expo/vector-icons';
import { router, useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import { Pressable, StyleSheet, View } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Makro } from '@/components/makro';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import {
  czasRazem,
  OPIS_KUCHNI,
  OPIS_PORY,
  opisTrwalosci,
  pobierzPrzepisy,
  przelaczPolubienie,
  type PrzepisZMakro,
} from '@/lib/przepisy';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';

export default function EkranPrzepisow() {
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [przepisy, setPrzepisy] = useState<PrzepisZMakro[]>([]);
  const [rola, setRola] = useState<string | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);

    // Rola pobierana niezależnie od przepisów. Gdyby lista się nie wczytała,
    // przycisk dodawania i tak ma się pojawić — inaczej jeden błąd ukrywa drugą rzecz.
    supabase
      .from('konta')
      .select('rola')
      .single()
      .then(({ data, error }) => {
        if (!error && data) setRola(data.rola);
      });

    try {
      setPrzepisy(await pobierzPrzepisy(sesja?.user.id));
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

  async function lajk(p: PrzepisZMakro) {
    if (!sesja) return;

    // Zmiana widoczna od razu, zanim baza potwierdzi — inaczej serce reaguje z opóźnieniem.
    setPrzepisy((poprzednie) =>
      poprzednie.map((x) =>
        x.id === p.id
          ? { ...x, polubiony: !x.polubiony, polubienia: x.polubienia + (x.polubiony ? -1 : 1) }
          : x
      )
    );

    try {
      await przelaczPolubienie(p.id, sesja.user.id, p.polubiony);
    } catch {
      pobierz(); // nie udało się — wracamy do stanu z bazy
    }
  }

  const mozeDodawac = rola === 'moderator' || rola === 'administrator';

  return (
    <Ekran
      tytul="Przepisy"
      podtytul={wczytywanie ? 'wczytywanie…' : `${przepisy.length} w bazie`}>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            Nie udało się wczytać: {blad}
          </ThemedText>
        </Karta>
      )}

      {!wczytywanie && przepisy.length === 0 && (
        <Karta>
          <ThemedText type="default">Baza przepisów jest pusta</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Składniki są już wczytane, więc makro policzy się samo — wystarczy podać, ile
            czego wchodzi w skład dania.
          </ThemedText>
        </Karta>
      )}

      {przepisy.map((p) => (
        <Karta key={p.id}>
          <View style={styles.naglowek}>
            <ThemedText type="default" style={styles.nazwa}>
              {p.nazwa}
            </ThemedText>
            {p.widocznosc !== 'publiczna' && (
              <ThemedText type="small" themeColor="textSecondary">
                {p.widocznosc === 'prywatna' ? 'prywatny' : 'zgłoszony'}
              </ThemedText>
            )}
          </View>

          {p.opis && (
            <ThemedText type="small" themeColor="textSecondary">
              {p.opis}
            </ThemedText>
          )}

          <ThemedText type="small" themeColor="textSecondary">
            {p.pory.map((x) => OPIS_PORY[x]).join(', ') || 'bez pory'}
            {' · '}
            {p.kuchnie.map((x) => OPIS_KUCHNI[x]).join(', ')}
            {(() => {
              const razem = czasRazem(p.czas_przygotowania_min, p.czas_obrobki_min);
              return razem ? ` · ${razem} min` : '';
            })()}
            {' · '}
            {opisTrwalosci(p.trwalosc_dni)}
            {p.mozna_mrozic ? ' · można mrozić' : ''}
          </ThemedText>

          {p.kcal !== null ? (
            <>
              <ThemedText type="smallBold" themeColor="textSecondary">
                NA PORCJĘ
                {p.gramy_porcji ? ` (${p.gramy_porcji} g)` : ''}
                {p.porcje_wyliczone ? ` · z ${p.porcje_wyliczone} porcji` : ''}
              </ThemedText>
              <View style={styles.wiersz}>
                <Makro etykieta="kcal" wartosc={p.kcal} jednostka="" />
                <Makro etykieta="białko" wartosc={p.bialko_g ?? 0} jednostka=" g" />
                <Makro etykieta="tłuszcz" wartosc={p.tluszcz_g ?? 0} jednostka=" g" />
                <Makro etykieta="węglow." wartosc={p.wegle_g ?? 0} jednostka=" g" />
              </View>
              {p.kcal_calosc !== null && (
                <ThemedText type="small" themeColor="textSecondary">
                  Cała potrawa: {p.gramy_calosc ? `${p.gramy_calosc} g, ` : ''}
                  {p.kcal_calosc} kcal, {p.bialko_g_calosc} g białka
                </ThemedText>
              )}
            </>
          ) : (
            <ThemedText type="small" themeColor="accent">
              Brak składników — nie ma z czego policzyć makro.
            </ThemedText>
          )}

          <View style={styles.stopka}>
            {p.cukry_wolne_g !== null && p.cukry_wolne_g > 0 && (
              <ThemedText type="small" themeColor="textSecondary">
                cukry wolne: {p.cukry_wolne_g} g
              </ThemedText>
            )}

            {(mozeDodawac || (p.autor_id === sesja?.user.id && p.widocznosc === 'prywatna')) && (
              <Pressable
                onPress={() => router.push({ pathname: '/przepis-formularz', params: { id: p.id } })}
                hitSlop={8}
                accessibilityLabel={`Edytuj ${p.nazwa}`}
                style={styles.edytuj}>
                <Ionicons name="create-outline" size={18} color={motyw.textSecondary} />
              </Pressable>
            )}

            <Pressable
              onPress={() => lajk(p)}
              accessibilityRole="button"
              accessibilityLabel={p.polubiony ? 'Cofnij polubienie' : 'Polub przepis'}
              style={({ pressed }) => [styles.lajk, pressed && styles.wcisniety]}>
              <Ionicons
                name={p.polubiony ? 'heart' : 'heart-outline'}
                size={20}
                color={p.polubiony ? motyw.accent : motyw.textSecondary}
              />
              <ThemedText type="small" themeColor={p.polubiony ? 'accent' : 'textSecondary'}>
                {p.polubienia}
              </ThemedText>
            </Pressable>
          </View>
        </Karta>
      ))}

      {mozeDodawac && (
        <>
          <Przycisk tytul="Dodaj przepis" onPress={() => router.push('/przepis-formularz')} />
          <Przycisk
            tytul="Składniki"
            wariant="poboczny"
            onPress={() => router.push('/skladniki')}
          />
        </>
      )}

      {!mozeDodawac && !wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          Dodawanie przepisów wymaga uprawnień moderatora.
        </ThemedText>
      )}
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
  wiersz: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
    paddingTop: Spacing.half,
  },
  stopka: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
    paddingTop: Spacing.one,
  },
  edytuj: {
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
    marginLeft: 'auto',
  },
  lajk: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: Spacing.one,
    paddingHorizontal: Spacing.two,
  },
  wcisniety: { opacity: 0.6 },
});
