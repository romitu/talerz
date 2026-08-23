import { useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useState } from 'react';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { pobierzRoleSkladnikow, zapiszWzorRoli, type RolaSkladnika } from '@/lib/role-skladnikow';

/**
 * Role składników — edycja wzorów skalowania.
 *
 * Odpowiednik prototypu ROLE_RB.html, tylko zapisujący do bazy zamiast
 * do localStorage przeglądarki — dzięki temu wzór widzą i edytują wszyscy,
 * nie tylko osoba, która akurat otworzyła tę konkretną przeglądarkę.
 *
 * Ról jest stałe siedem (migracja 0031) i ten ekran ich nie dodaje ani nie
 * usuwa — edytowalny jest wyłącznie „Wzór”. Reszta kolumn to dokumentacja,
 * po co dana rola istnieje i kiedy jej użyć.
 */

/** Wzory z chwili wczytania danej roli — do wykrycia niezapisanej zmiany. */
function domyslneWzory(role: RolaSkladnika[]): Record<string, string> {
  return Object.fromEntries(role.map((r) => [r.klucz, r.wzor]));
}

export default function EkranRoleSkladnikow() {
  const { powrot } = useLocalSearchParams<{ powrot?: string }>();

  const [role, setRole] = useState<RolaSkladnika[]>([]);
  const [wzory, setWzory] = useState<Record<string, string>>({});
  const [wczytywanie, setWczytywanie] = useState(true);
  const [zapisywanie, setZapisywanie] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);
  const [status, setStatus] = useState<string | null>(null);

  const pobierz = useCallback(async () => {
    setWczytywanie(true);
    setBlad(null);
    try {
      const dane = await pobierzRoleSkladnikow();
      setRole(dane);
      setWzory(domyslneWzory(dane));
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setWczytywanie(false);
    }
  }, []);

  useEffect(() => {
    pobierz();
  }, [pobierz]);

  const zmieniono = role.some((r) => (wzory[r.klucz] ?? '').trim() !== r.wzor);

  async function zapisz() {
    setBlad(null);
    setStatus(null);
    setZapisywanie(true);
    try {
      const doZapisania = role.filter((r) => (wzory[r.klucz] ?? '').trim() !== r.wzor);
      for (const r of doZapisania) {
        await zapiszWzorRoli(r.klucz, wzory[r.klucz]);
      }
      await pobierz();
      setStatus(
        doZapisania.length === 0
          ? 'Nie było żadnych zmian do zapisania.'
          : `Zapisano ${doZapisania.length} ${doZapisania.length === 1 ? 'wzór' : 'wzory'}.`
      );
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZapisywanie(false);
    }
  }

  /** Cofa niezapisane zmiany w polach do wartości sprzed edycji — nie zapisuje ich. */
  function cofnijZmiany() {
    setWzory(domyslneWzory(role));
    setStatus(null);
    setBlad(null);
  }

  return (
    <Ekran
      tytul="Role składników"
      podtytul="Sposób skalowania składników przy zmianie liczby porcji">
      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          <ThemedText type="smallBold" themeColor="accent">Założenie: </ThemedText>
          k = liczba porcji przygotowywanych / liczba porcji bazowych. Dla zmniejszania
          przepisu można przyjąć skalowanie liniowe. Kwantyzacja jest osobną cechą
          składnika i nie wynika z roli.
        </ThemedText>
      </Karta>

      {wczytywanie && (
        <ThemedText type="small" themeColor="textSecondary">
          wczytywanie…
        </ThemedText>
      )}

      {blad && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {blad}
          </ThemedText>
        </Karta>
      )}

      {role.map((r) => (
        <Karta key={r.klucz} style={styles.grupa}>
          <View>
            <ThemedText type="smallBold">{r.etykieta}</ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {r.opis_roli}
            </ThemedText>
          </View>

          <Pole
            etykieta="Wzór"
            value={wzory[r.klucz] ?? ''}
            onChangeText={(t) => setWzory((p) => ({ ...p, [r.klucz]: t }))}
            multiline
          />

          <ThemedText type="small" themeColor="textSecondary">
            <ThemedText type="smallBold" themeColor="textSecondary">Kiedy używać: </ThemedText>
            {r.kiedy_uzywac}
          </ThemedText>

          {r.przyklady.length > 0 && (
            <View style={styles.przyklady}>
              {r.przyklady.map((p) => {
                const dwukropek = p.indexOf(': ');
                const lead = dwukropek >= 0 ? p.slice(0, dwukropek) : null;
                const reszta = dwukropek >= 0 ? p.slice(dwukropek + 1) : p;
                return (
                  <ThemedText key={p} type="small" themeColor="textSecondary">
                    •{' '}
                    {lead && <ThemedText type="smallBold" themeColor="textSecondary">{lead}: </ThemedText>}
                    {reszta}
                  </ThemedText>
                );
              })}
            </View>
          )}
        </Karta>
      ))}

      {status && (
        <ThemedText type="small" themeColor="textSecondary">
          {status}
        </ThemedText>
      )}

      <Przycisk
        tytul="Cofnij niezapisane zmiany"
        wariant="poboczny"
        onPress={cofnijZmiany}
        wylaczony={!zmieniono || zapisywanie}
      />
      <Przycisk
        tytul="Zapisz wzory"
        onPress={zapisz}
        zajety={zapisywanie}
        wylaczony={!zmieniono || wczytywanie}
      />

      <ThemedText type="small" themeColor="textSecondary">
        Zapis wymaga uprawnień moderatora — pozostałym osobom baza odmówi z odpowiednim
        komunikatem.
      </ThemedText>

      <Przycisk tytul="Wróć" wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.two },
  przyklady: { gap: Spacing.one },
});
