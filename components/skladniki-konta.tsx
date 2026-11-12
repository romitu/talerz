import { Ionicons } from '@expo/vector-icons';
import { useEffect, useState, type ComponentProps } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { Przycisk } from './przycisk';
import { TabelaWyboru } from './tabela-wyboru';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { komunikatBledu } from '@/lib/blad';
import { pobierzSkladniki, type Skladnik } from '@/lib/skladniki';
import {
  pobierzListe,
  ustawNaLiscie,
  type ListaSkladnikowKonta,
  type SkladnikNaLiscie,
} from '@/lib/skladniki-konta';

/**
 * Sekcje „Nie jemy” (migracja 0049) i „Chcemy więcej” (migracja 0051) na
 * ekranie Profilu. Obie wyglądają i działają tak samo — różnią się tabelą,
 * ikoną i tekstami, a skutek w planie liczy już `lib/automat.ts`.
 *
 * Lista dotyczy całego konta, nie jednej osoby: garnek jest wspólny.
 *
 * Pełna lista składników wczytuje się dopiero po rozwinięciu wyboru — większość
 * wejść na Profil nie ma nic wspólnego z tymi listami.
 */
function SkladnikiKonta({
  kontoId,
  lista,
  teksty,
  ikona,
}: {
  kontoId: string | undefined;
  lista: ListaSkladnikowKonta;
  /** Prefiks kluczy w `lokalizacja/pl.json`, np. `nieJemy`. */
  teksty: 'nieJemy' | 'chcemyWiecej';
  ikona: ComponentProps<typeof Ionicons>['name'];
}) {
  const motyw = useTheme();
  const { t } = useTranslation();
  const [naLiscie, setNaLiscie] = useState<SkladnikNaLiscie[]>([]);
  const [skladniki, setSkladniki] = useState<Skladnik[] | null>(null);
  const [wybieranie, setWybieranie] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  useEffect(() => {
    if (!kontoId) return;
    pobierzListe(lista)
      .then(setNaLiscie)
      .catch((e) => setBlad(komunikatBledu(e)));
  }, [kontoId, lista]);

  async function otworzWybor() {
    setWybieranie(true);
    if (skladniki) return;
    try {
      setSkladniki(await pobierzSkladniki());
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }

  async function przelacz(skladnikId: string, nazwa: string) {
    if (!kontoId) return;
    setBlad(null);
    const nowy = !naLiscie.some((w) => w.skladnik_id === skladnikId);
    const poprzednie = naLiscie;

    // Zmiana widoczna od razu, zanim baza potwierdzi.
    setNaLiscie(
      nowy
        ? [...naLiscie, { skladnik_id: skladnikId, nazwa }].sort((a, b) =>
            a.nazwa.localeCompare(b.nazwa, 'pl')
          )
        : naLiscie.filter((w) => w.skladnik_id !== skladnikId)
    );

    try {
      await ustawNaLiscie(lista, kontoId, skladnikId, nowy);
    } catch (e) {
      setBlad(komunikatBledu(e));
      setNaLiscie(poprzednie); // nie udało się — wracamy do stanu sprzed dotknięcia
    }
  }

  return (
    <Karta>
      <View style={styles.naglowek}>
        <Ionicons name={ikona} size={18} color={motyw.accent} />
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t(`${teksty}.naglowek`)}
        </ThemedText>
      </View>
      <ThemedText type="small" themeColor="textSecondary">
        {t(`${teksty}.opis`)}
      </ThemedText>

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      {naLiscie.length === 0 ? (
        <ThemedText type="small">{t(`${teksty}.pusto`)}</ThemedText>
      ) : (
        <View style={styles.pigulki}>
          {naLiscie.map((w) => (
            <Pressable
              key={w.skladnik_id}
              onPress={() => przelacz(w.skladnik_id, w.nazwa)}
              accessibilityRole="button"
              accessibilityLabel={t(`${teksty}.usunZListy`, { nazwa: w.nazwa })}
              style={({ pressed }) => [
                styles.pigulka,
                { backgroundColor: motyw.backgroundSelected },
                pressed && styles.wcisniety,
              ]}>
              <ThemedText type="small">{w.nazwa}</ThemedText>
              <Ionicons name="close" size={14} color={motyw.textSecondary} />
            </Pressable>
          ))}
        </View>
      )}

      {wybieranie ? (
        <>
          {skladniki ? (
            <TabelaWyboru
              dane={skladniki}
              klucz={(s) => s.id}
              tekstDoFiltra={(s) => `${s.nazwa} ${s.tagi.join(' ')}`}
              etykietaFiltra={t(`${teksty}.szukaj`)}
              placeholderFiltra={t(`${teksty}.przyklad`)}
              wybrane={naLiscie.map((w) => w.skladnik_id)}
              onPrzelacz={(s) => przelacz(s.id, s.nazwa)}
              kolumny={[{ tytul: t('wspolne.nazwa'), elastyczna: true, wartosc: (s) => s.nazwa }]}
            />
          ) : (
            <ThemedText type="small" themeColor="textSecondary">
              {t(`${teksty}.wczytywanie`)}
            </ThemedText>
          )}
          <Przycisk tytul={t('wspolne.gotowe')} wariant="poboczny" onPress={() => setWybieranie(false)} />
        </>
      ) : (
        <Przycisk
          tytul={t(`${teksty}.dodaj`)}
          ikona="add-circle-outline"
          wariant="poboczny"
          onPress={otworzWybor}
        />
      )}
    </Karta>
  );
}

/** Składniki, których konto nie je — dania z nimi nie trafiają do planu. */
export function NieJemy({ kontoId }: { kontoId: string | undefined }) {
  return (
    <SkladnikiKonta kontoId={kontoId} lista="wykluczone_skladniki" teksty="nieJemy" ikona="ban-outline" />
  );
}

/** Składniki, które konto chce jeść częściej — automat daje takim daniom premię. */
export function ChcemyWiecej({ kontoId }: { kontoId: string | undefined }) {
  return (
    <SkladnikiKonta
      kontoId={kontoId}
      lista="chcemy_wiecej_skladniki"
      teksty="chcemyWiecej"
      ikona="leaf-outline"
    />
  );
}

const styles = StyleSheet.create({
  naglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
  },
  pigulki: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.one,
  },
  pigulka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.half,
    paddingHorizontal: Spacing.two,
    paddingVertical: Spacing.half,
    borderRadius: Spacing.three,
  },
  wcisniety: { opacity: 0.7 },
});
