import { Ionicons } from '@expo/vector-icons';
import { router, useFocusEffect } from 'expo-router';
import { useCallback, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { KafleWyniku } from '@/components/kafle-wyniku';
import { Karta } from '@/components/karta';
import { NaglowekProfilu } from '@/components/naglowek-profilu';
import { NieJemy } from '@/components/nie-jemy';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { WyborJezyka } from '@/components/wybor-jezyka';
import { WyborStylu } from '@/components/wybor-stylu';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { celZywieniowyNASEM, type PalNasem } from '@/lib/nasem';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import { wiekZDaty, type Plec, type TrybCelu } from '@/lib/zywienie';

type Cel = {
  tryb: TrybCelu;
  bialko_procent: number;
  tluszcz_procent: number;
  wegle_procent: number;
  blonnik_g: number | null;
  prog_bialka_posilek: number | null;
};

type Profil = {
  id: string;
  imie: string;
  plec: Plec;
  data_urodzenia: string;
  wzrost_cm: number;
  aktywnosc: PalNasem;
  cele: Cel[];
};

export default function EkranProfilu() {
  const { sesja } = useSesja();
  const motyw = useTheme();
  const { t } = useTranslation();
  const [profile, setProfile] = useState<Profil[]>([]);
  const [wagi, setWagi] = useState<Record<string, number>>({});
  const [rola, setRola] = useState<string | null>(null);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);
  const [doUsuniecia, setDoUsuniecia] = useState<Profil | null>(null);
  const [usuwanie, setUsuwanie] = useState(false);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);

    const [wynikProfili, wynikKonta] = await Promise.all([
      supabase
        .from('profile')
        .select(
          'id, imie, plec, data_urodzenia, wzrost_cm, aktywnosc, cele (tryb, bialko_procent, tluszcz_procent, wegle_procent, blonnik_g, prog_bialka_posilek)'
        )
        .order('kolejnosc')
        // `cele` trzyma PEŁNĄ historię (jeden wiersz na obowiazuje_od) — bez
        // sortowania dołączona tablica wraca w dowolnej kolejności i `cele[0]`
        // (patrz niżej) potrafił złapać stary zapis zamiast aktualnego.
        .order('obowiazuje_od', { foreignTable: 'cele', ascending: false })
        .limit(1, { foreignTable: 'cele' }),
      supabase.from('konta').select('rola').eq('id', sesja?.user.id).single(),
    ]);

    if (wynikProfili.error) setBlad(wynikProfili.error.message);
    else {
      const lista = (wynikProfili.data ?? []) as Profil[];
      setProfile(lista);

      // Waga to jedyna rzecz, której nie ma w powyższym zapytaniu — a bez niej
      // nie da się policzyć celu, który ma być zawsze aktualny, nie zamrożony.
      const wynikiWag = await Promise.all(
        lista.map((p) =>
          supabase
            .from('pomiary')
            .select('wartosc')
            .eq('profil_id', p.id)
            .eq('typ', 'waga')
            .order('data', { ascending: false })
            .limit(1)
            .maybeSingle()
        )
      );
      const mapa: Record<string, number> = {};
      lista.forEach((p, i) => {
        const w = wynikiWag[i].data;
        if (w) mapa[p.id] = Number(w.wartosc);
      });
      setWagi(mapa);
    }

    if (wynikKonta.error) setBlad((poprzedni) => poprzedni ?? wynikKonta.error.message);
    else setRola(wynikKonta.data.rola);

    setWczytywanie(false);
  }, [sesja?.user.id]);

  // Odświeżenie po powrocie z formularza — inaczej lista byłaby nieaktualna.
  useFocusEffect(
    useCallback(() => {
      pobierz();
    }, [pobierz])
  );

  // Usunięcie profilu kasuje kaskadowo jego cele i pomiary (waga, talia) —
  // to jedyne tabele, które się do niego odwołują.
  async function usunProfil(id: string) {
    setUsuwanie(true);
    setBlad(null);
    try {
      const { error } = await supabase.from('profile').delete().eq('id', id);
      if (error) throw error;
      setDoUsuniecia(null);
      pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setUsuwanie(false);
    }
  }

  return (
    <Ekran
      tytul={t('profil.tytul')}
      podtytul={sesja?.user.email ?? undefined}
      naglowekStaly={<NaglowekProfilu email={sesja?.user.email} rola={rola} />}>
      {wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          {t('wspolne.wczytywanie')}
        </ThemedText>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {t('wspolne.bladWczytania', { blad })}
          </ThemedText>
        </Karta>
      )}

      {!wczytywanie && profile.length === 0 && (
        <Karta>
          <ThemedText type="default">{t('profil.brakProfilu')}</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {t('profil.brakProfiluOpis')}
          </ThemedText>
        </Karta>
      )}

      {profile.map((p) => {
        const zapis = p.cele?.[0];
        const waga = wagi[p.id];
        // Kcal i gramy liczą się na bieżąco z wagi/wzrostu/wieku/aktywności —
        // ta karta nigdy nie pokazuje zamrożonej liczby z chwili zapisu.
        const cel =
          zapis && waga
            ? celZywieniowyNASEM(
                p.plec,
                wiekZDaty(p.data_urodzenia),
                p.wzrost_cm,
                waga,
                p.aktywnosc,
                zapis.tryb,
                { bialko: zapis.bialko_procent, tluszcz: zapis.tluszcz_procent, wegle: zapis.wegle_procent }
              )
            : null;

        return (
          <Karta key={p.id} style={styles.kartaProfilu}>
            <View style={styles.naglowekProfilu}>
              <View style={[styles.awatar, { backgroundColor: `${motyw.accent}1F` }]}>
                <Ionicons name={p.plec === 'K' ? 'woman' : 'man'} size={34} color={motyw.accent} />
              </View>
              <View>
                <ThemedText type="subtitle">{p.imie}</ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  {t('wspolne.lata', { count: wiekZDaty(p.data_urodzenia) })} · {p.wzrost_cm} cm
                </ThemedText>
              </View>
            </View>

            {cel ? (
              <>
                <KafleWyniku cel={cel} />

                <View style={[styles.pigulka, { backgroundColor: motyw.backgroundSelected }]}>
                  <View
                    style={[
                      styles.pigulkaIkona,
                      { backgroundColor: zapis!.prog_bialka_posilek ? motyw.accent : motyw.border },
                    ]}>
                    <Ionicons name="checkmark" size={13} color="#FFFFFF" />
                  </View>
                  <ThemedText type="small" themeColor="accent" style={styles.tekstPigulki}>
                    {zapis!.prog_bialka_posilek
                      ? t('profil.progBialka', { gramy: zapis!.prog_bialka_posilek })
                      : t('profil.bezProgu')}
                    {zapis!.blonnik_g ? ` · ${t('profil.blonnik', { gramy: zapis!.blonnik_g })}` : ''}
                    {' · '}
                    {zapis!.tryb === 'redukcja' ? t('profil.trybRedukcja') : t('profil.trybUtrzymanie')}
                  </ThemedText>
                </View>
              </>
            ) : (
              <ThemedText type="small" themeColor="accent">
                {zapis ? t('profil.brakWagi') : t('profil.brakCelow')}
              </ThemedText>
            )}

            <View style={styles.akcjeProfilu}>
              <Przycisk
                tytul={t('profil.edytuj')}
                ikona="pencil-outline"
                onPress={() => router.push({ pathname: '/profil-formularz', params: { profil: p.id, powrot: '/profil' } })}
                style={styles.akcjaProfilu}
              />
              <Przycisk
                tytul={t('profil.usunProfil')}
                ikona="trash-outline"
                wariant="poboczny"
                onPress={() => setDoUsuniecia(p)}
                style={styles.akcjaProfilu}
              />
            </View>
          </Karta>
        );
      })}

      {/* Okno potwierdzenia — usunięcie kasuje też cele i pomiary tego profilu. */}
      {doUsuniecia && (
        <Karta>
          <ThemedText type="smallBold">{t('profil.usunPytanie', { imie: doUsuniecia.imie })}</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {t('profil.usunOstrzezenie')}
          </ThemedText>
          <Przycisk tytul={t('wspolne.usun')} ikona="trash-outline" onPress={() => usunProfil(doUsuniecia.id)} zajety={usuwanie} />
          <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={() => setDoUsuniecia(null)} wylaczony={usuwanie} />
        </Karta>
      )}

      {profile.length < 4 && (
        <Przycisk
          tytul={t('profil.dodaj')}
          ikona="add-circle-outline"
          onPress={() => router.push({ pathname: '/profil-formularz', params: { powrot: '/profil' } })}
        />
      )}

      <NieJemy kontoId={sesja?.user.id} />

      <Karta>
        <WyborStylu />
      </Karta>

      <WyborJezyka />

      {/*
        Zarządzanie kontami widzi tylko administrator. Ukrycie przycisku nie
        jest zabezpieczeniem — tym są reguły dostępu w bazie — ale przycisk
        prowadzący do ekranu, na którym i tak nic nie widać, tylko myli.
      */}
      {rola === 'administrator' && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            {t('profil.administracja')}
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {t('profil.administracjaOpis')}
          </ThemedText>
          <Przycisk
            tytul={t('profil.uzytkownicy')}
            wariant="poboczny"
            onPress={() =>
              router.push({ pathname: '/uzytkownicy', params: { powrot: '/profil' } })
            }
          />
        </Karta>
      )}

      <Przycisk
        tytul={t('profil.wyloguj')}
        ikona="log-out-outline"
        wariant="poboczny"
        onPress={() => supabase.auth.signOut()}
        style={styles.wyloguj}
      />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  kartaProfilu: {
    gap: Spacing.three,
  },
  naglowekProfilu: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  awatar: {
    width: 64,
    height: 64,
    borderRadius: 32,
    alignItems: 'center',
    justifyContent: 'center',
  },
  pigulka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderRadius: Spacing.two,
    paddingVertical: Spacing.two,
    paddingHorizontal: Spacing.three,
  },
  pigulkaIkona: {
    width: 22,
    height: 22,
    borderRadius: 11,
    alignItems: 'center',
    justifyContent: 'center',
  },
  tekstPigulki: {
    flex: 1,
  },
  akcjeProfilu: {
    flexDirection: 'row',
    gap: Spacing.two,
  },
  akcjaProfilu: {
    flex: 1,
  },
  wyloguj: {
    marginTop: Spacing.four,
  },
});
