import { router, useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import { StyleSheet } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { WierszMakro } from '@/components/wiersz-makro';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { WyborStylu } from '@/components/wybor-stylu';
import { Spacing } from '@/constants/theme';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import { wiekZDaty } from '@/lib/zywienie';

type Cel = {
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number | null;
  prog_bialka_posilek: number | null;
};

type Profil = {
  id: string;
  imie: string;
  data_urodzenia: string;
  wzrost_cm: number;
  cele: Cel[];
};

export default function EkranProfilu() {
  const { sesja } = useSesja();
  const [profile, setProfile] = useState<Profil[]>([]);
  const [rola, setRola] = useState<string | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);

    const [wynikProfili, wynikKonta] = await Promise.all([
      supabase
        .from('profile')
        .select('id, imie, data_urodzenia, wzrost_cm, cele (kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, prog_bialka_posilek)')
        .order('kolejnosc'),
      supabase.from('konta').select('rola').single(),
    ]);

    if (wynikProfili.error) setBlad(wynikProfili.error.message);
    else setProfile((wynikProfili.data ?? []) as Profil[]);

    if (!wynikKonta.error) setRola(wynikKonta.data.rola);

    setWczytywanie(false);
  }, []);

  // Odświeżenie po powrocie z formularza — inaczej lista byłaby nieaktualna.
  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

  return (
    <Ekran tytul="Profil" podtytul={sesja?.user.email ?? undefined}>
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          KONTO
        </ThemedText>
        <ThemedText type="small">Adres: {sesja?.user.email}</ThemedText>
        <ThemedText type="small">Rola: {rola ?? 'wczytywanie…'}</ThemedText>
      </Karta>

      {wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          Wczytywanie z bazy…
        </ThemedText>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            Nie udało się wczytać: {blad}
          </ThemedText>
        </Karta>
      )}

      {!wczytywanie && profile.length === 0 && (
        <Karta>
          <ThemedText type="default">Nie masz jeszcze profilu</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Profil zawiera dane potrzebne do wyliczenia zapotrzebowania: wiek, wzrost, wagę
            i poziom aktywności. Bez niego plan dnia nie ma do czego się odnieść.
          </ThemedText>
        </Karta>
      )}

      {profile.map((p) => {
        const cel = p.cele?.[0];
        return (
          <Karta key={p.id}>
            <ThemedText type="default">{p.imie}</ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {wiekZDaty(p.data_urodzenia)} lat · {p.wzrost_cm} cm
            </ThemedText>

            {cel ? (
              <>
                <WierszMakro
                  pozycje={[
                    { etykieta: 'kcal', wartosc: cel.kcal, jednostka: '' },
                    { etykieta: 'białko', wartosc: cel.bialko_g, jednostka: ' g' },
                    { etykieta: 'tłuszcz', wartosc: cel.tluszcz_g, jednostka: ' g' },
                    { etykieta: 'węgle', wartosc: cel.wegle_g, jednostka: ' g' },
                  ]}
                />
                <ThemedText type="small" themeColor="textSecondary">
                  {cel.prog_bialka_posilek
                    ? `Próg białka na posiłek: ${cel.prog_bialka_posilek} g`
                    : 'Bez progu posiłkowego'}
                  {cel.blonnik_g ? ` · błonnik: ${cel.blonnik_g} g dziennie` : ''}
                </ThemedText>
              </>
            ) : (
              <ThemedText type="small" themeColor="accent">
                Brak ustalonych celów dziennych.
              </ThemedText>
            )}

            <Przycisk
              tytul={cel ? 'Zmień cele' : 'Ustal cele'}
              wariant="poboczny"
              onPress={() => router.push({ pathname: '/cele-formularz', params: { profil: p.id, powrot: '/profil' } })}
            />
          </Karta>
        );
      })}

      {profile.length < 3 && (
        <Przycisk tytul="Dodaj profil" onPress={() => router.push({ pathname: '/profil-formularz', params: { powrot: '/profil' } })} />
      )}

      <Karta>
        <WyborStylu />
      </Karta>

      {/*
        Zarządzanie kontami widzi tylko administrator. Ukrycie przycisku nie
        jest zabezpieczeniem — tym są reguły dostępu w bazie — ale przycisk
        prowadzący do ekranu, na którym i tak nic nie widać, tylko myli.
      */}
      {rola === 'administrator' && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            ADMINISTRACJA
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Wyłączanie i przywracanie dostępu. Konta zakłada się w panelu Supabase.
          </ThemedText>
          <Przycisk
            tytul="Użytkownicy"
            wariant="poboczny"
            onPress={() =>
              router.push({ pathname: '/uzytkownicy', params: { powrot: '/profil' } })
            }
          />
        </Karta>
      )}

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
  wyloguj: {
    marginTop: Spacing.four,
  },
});
