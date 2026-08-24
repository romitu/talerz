import AsyncStorage from '@react-native-async-storage/async-storage';
import { Ionicons } from '@expo/vector-icons';
import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useRef, useState } from 'react';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { useSesja } from '@/lib/sesja';
import {
  opisRoli,
  pobierzKonta,
  ustawAktywnosc,
  ustawRole,
  type KontoUzytkownika,
} from '@/lib/uzytkownicy';


/**
 * Zarządzanie kontami — widoczne tylko dla administratora.
 *
 * Czego tu NIE MA i dlaczego
 * --------------------------
 * Nie ma kasowania kont. Usunięcie użytkownika z Supabase wymaga klucza
 * `service_role`, a ten omija wszystkie zabezpieczenia i nie może trafić do
 * aplikacji działającej w przeglądarce — klucz w opublikowanej stronie jest
 * jawny dla każdego.
 *
 * Zamiast tego konto się WYŁĄCZA. W praktyce daje to to samo: człowiek traci
 * dostęp do wszystkiego, a dane zostają nietknięte, więc przywrócenie to jedno
 * dotknięcie zamiast zakładania konta od nowa i odtwarzania planów.
 *
 * Rola moderatora nadaje się stąd, rola administratora nie. Ta pierwsza jest
 * potrzebna na co dzień — bez moderatora nie ma kto zatwierdzać przepisów.
 * Ta druga zdarza się raz na rok, a przejęta sesja administratora nie może
 * wtedy narobić kolejnych administratorów, którzy zostaliby w bazie nawet
 * po zmianie hasła.
 */

/**
 * Kiedy administrator ostatnio otworzył ten ekran — na TYM urządzeniu.
 *
 * Rejestracja jest teraz otwarta (patrz `ekran-logowania.tsx`) i zatwierdza
 * się sama, więc jedynym śladem nowego konta jest ten ekran. Zamiast e-maila
 * czy powiadomienia push — których apka nie wysyła — próg w pamięci telefonu
 * mówi, co przybyło od ostatniej wizyty. To celowo lokalne, nie w bazie: na
 * dwóch urządzeniach administrator i tak dostanie osobny baner na każdym.
 */
const KLUCZ_OSTATNIEJ_WIZYTY = 'talerz-uzytkownicy-ostatnia-wizyta';

export default function EkranUzytkownikow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [konta, setKonta] = useState<KontoUzytkownika[]>([]);
  const [wczytywanie, setWczytywanie] = useState(true);
  const [blad, setBlad] = useState<string | null>(null);
  const [pytanie, setPytanie] = useState<string | null>(null);

  /**
   * Próg poprzedniej wizyty. `null` = pierwsze uruchomienie tej funkcji na tym
   * telefonie — wtedy nic nie oznaczamy jako nowe, żeby nie podświetlić od razu
   * całej dotychczasowej listy kont.
   */
  const progRef = useRef<string | null>(null);
  const [nowe, setNowe] = useState<Set<string>>(new Set());

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const lista = await pobierzKonta();
      setKonta(lista);
      if (progRef.current) {
        setNowe(new Set(lista.filter((k) => k.utworzono > progRef.current!).map((k) => k.id)));
      }
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, []);

  useFocusEffect(
    useCallback(() => {
      // Próg czytamy PRZED zapisem nowego — inaczej porównywalibyśmy „teraz”
      // z „teraz” i nic nigdy nie wyszłoby jako nowe.
      AsyncStorage.getItem(KLUCZ_OSTATNIEJ_WIZYTY)
        .then((zapisany) => {
          progRef.current = zapisany;
          AsyncStorage.setItem(KLUCZ_OSTATNIEJ_WIZYTY, new Date().toISOString()).catch(() => {});
        })
        .catch(() => {
          progRef.current = null;
        })
        .finally(() => {
          pobierz();
        });
    }, [pobierz])
  );

  async function zmienRole(konto: KontoUzytkownika) {
    setBlad(null);
    try {
      await ustawRole(konto.id, konto.rola === 'moderator' ? 'uzytkownik' : 'moderator');
      await pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  async function przelacz(konto: KontoUzytkownika, aktywne: boolean) {
    setBlad(null);
    try {
      await ustawAktywnosc(konto.id, aktywne);
      setPytanie(null);
      await pobierz();
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  const czynnych = konta.filter((k) => k.aktywne).length;

  return (
    <Ekran
      tytul="Użytkownicy"
      podtytul={
        wczytywanie ? 'wczytywanie…' : `${konta.length} kont, w tym ${czynnych} czynnych`
      }>
      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      {/*
        Jedyny ślad po tym, że ktoś sam się zarejestrował — apka nie wysyła
        e-maila ani push. Baner znika po kolejnej wizycie na tym urządzeniu.
      */}
      {nowe.size > 0 && (
        <Karta style={{ borderWidth: 2, borderColor: motyw.accent }}>
          <ThemedText type="smallBold" themeColor="accent">
            {nowe.size} {nowe.size === 1 ? 'nowe konto' : 'nowych kont'} od ostatniej wizyty
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Zarejestrowały się same i są od razu czynne. Podświetlone niżej — sprawdź
            i w razie czego wyłącz.
          </ThemedText>
        </Karta>
      )}

      {konta.map((k) => {
        const toJa = k.id === sesja?.user.id;
        const pytamy = pytanie === k.id;
        const jestNowe = nowe.has(k.id);

        return (
          <Karta key={k.id} style={jestNowe ? { borderWidth: 2, borderColor: motyw.accent } : undefined}>
            <View style={styles.naglowek}>
              <View style={styles.tozsamosc}>
                <ThemedText type="default" themeColor={k.aktywne ? 'text' : 'textSecondary'}>
                  {k.email ?? 'konto bez adresu'}
                </ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  {opisRoli(k.rola)}
                  {toJa ? ' · to Ty' : ''}
                  {jestNowe ? ' · nowe' : ''}
                </ThemedText>
              </View>

              <View style={styles.stan}>
                <Ionicons
                  name={k.aktywne ? 'checkmark-circle' : 'close-circle'}
                  size={18}
                  color={k.aktywne ? motyw.textSecondary : motyw.accent}
                />
                <ThemedText type="smallBold" themeColor={k.aktywne ? 'textSecondary' : 'accent'}>
                  {k.aktywne ? 'czynne' : 'wyłączone'}
                </ThemedText>
              </View>
            </View>

            {!k.aktywne && k.wylaczone_kiedy && (
              <ThemedText type="small" themeColor="textSecondary">
                Wyłączone {new Date(k.wylaczone_kiedy).toLocaleDateString('pl-PL')}
              </ThemedText>
            )}

            {/*
              Roli administratora nie ma tu wcale — ani do nadania, ani do
              odebrania. To jedyna rola, którą można nadać wyłącznie w panelu.
            */}
            {k.rola !== 'administrator' && !toJa && (
              <Przycisk
                tytul={
                  k.rola === 'moderator'
                    ? 'Odbierz rolę moderatora'
                    : 'Uczyń moderatorem przepisów'
                }
                wariant="poboczny"
                onPress={() => zmienRole(k)}
              />
            )}

            {/*
              Administrator nie wyłącza sam siebie — baza też tego pilnuje
              (migracja 0023), ale przycisk, który zawsze kończy się błędem,
              jest gorszy niż brak przycisku.
            */}
            {toJa ? (
              <ThemedText type="small" themeColor="textSecondary">
                Własnego konta nie da się wyłączyć. Przy jednym administratorze byłoby to
                zatrzaśnięcie drzwi z kluczem w środku.
              </ThemedText>
            ) : k.aktywne ? (
              pytamy ? (
                <>
                  <ThemedText type="small" themeColor="accent">
                    Wyłączyć konto {k.email}? Straci dostęp do wszystkiego przy najbliższym
                    uruchomieniu aplikacji. Dane zostaną nietknięte i wrócą po włączeniu.
                  </ThemedText>
                  <Przycisk tytul="Tak, wyłącz" onPress={() => przelacz(k, false)} />
                  <Przycisk tytul="Zostaw" wariant="poboczny" onPress={() => setPytanie(null)} />
                </>
              ) : (
                <Przycisk
                  tytul="Wyłącz konto"
                  wariant="poboczny"
                  onPress={() => setPytanie(k.id)}
                />
              )
            ) : (
              <Przycisk tytul="Włącz z powrotem" onPress={() => przelacz(k, true)} />
            )}
          </Karta>
        );
      })}

      {!wczytywanie && konta.length === 0 && (
        <Karta>
          <ThemedText type="default">Nie widzę żadnych kont</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Ten ekran jest dla administratora. Jeśli jesteś zalogowany jako ktoś inny,
            baza pokaże wyłącznie Twoje własne konto.
          </ThemedText>
        </Karta>
      )}

      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          CO DAJE ROLA MODERATORA
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Moderator zatwierdza przepisy zgłoszone do publikacji, może je poprawiać
          po opublikowaniu i zarządza wspólną bazą składników. Nie ma dostępu do
          cudzych planów, celów ani list zakupów — te zostają prywatne.
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Rolę administratora nadaje się wyłącznie w panelu Supabase. Zdarza się to raz
          na rok, a trzymanie jej poza aplikacją oznacza, że nawet przejęta sesja
          administratora nie zrobi kolejnego administratora.
        </ThemedText>
      </Karta>

      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          Rejestracja jest otwarta — każdy z linkiem do aplikacji może sam założyć konto,
          bez Twojej zgody. Nowe konto jest od razu czynne, z rolą zwykłego użytkownika.
          Baner na górze tego ekranu pokazuje, co przybyło od Twojej ostatniej wizyty —
          to jedyne powiadomienie, jakie dostajesz; sprawdź się tu od czasu do czasu.
        </ThemedText>
      </Karta>

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/profil')} />
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
  tozsamosc: { flex: 1, gap: 2 },
  stan: { flexDirection: 'row', alignItems: 'center', gap: Spacing.one },
});
