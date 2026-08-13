import { router } from 'expo-router';
import { useState } from 'react';
import { StyleSheet } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { Wybor } from '@/components/wybor';
import { Spacing } from '@/constants/theme';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';
import {
  AKTYWNOSC,
  przemianaPodstawowa,
  wiekZDaty,
  zapotrzebowanie,
  type Plec,
  type PoziomAktywnosci,
} from '@/lib/zywienie';

/** Zamienia przecinek na kropkę i zwraca liczbę albo null. */
function liczba(tekst: string): number | null {
  const t = tekst.replace(',', '.').trim();
  if (!t) return null;
  const n = Number(t);
  return Number.isFinite(n) ? n : null;
}

/** Sprawdza zapis daty w formacie RRRR-MM-DD. */
function poprawnaData(tekst: string): boolean {
  if (!/^\d{4}-\d{2}-\d{2}$/.test(tekst)) return false;
  const d = new Date(tekst);
  return !Number.isNaN(d.getTime());
}

export default function FormularzProfilu() {
  const { sesja } = useSesja();

  const [imie, setImie] = useState('');
  const [plec, setPlec] = useState<Plec>('M');
  const [dataUrodzenia, setDataUrodzenia] = useState('');
  const [wzrost, setWzrost] = useState('');
  const [waga, setWaga] = useState('');
  const [talia, setTalia] = useState('');
  const [aktywnosc, setAktywnosc] = useState<PoziomAktywnosci>('umiarkowany');

  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const wzrostL = liczba(wzrost);
  const wagaL = liczba(waga);
  const wiek = poprawnaData(dataUrodzenia) ? wiekZDaty(dataUrodzenia) : null;

  const komplet = Boolean(imie.trim() && wiek !== null && wzrostL && wagaL);

  // Podgląd wyliczeń pojawia się dopiero, gdy jest z czego liczyć.
  const podglad =
    komplet && wiek !== null && wzrostL && wagaL
      ? {
          przemiana: przemianaPodstawowa(plec, wagaL, wzrostL, wiek),
          zapotrzebowanie: zapotrzebowanie(plec, wagaL, wzrostL, wiek, aktywnosc),
        }
      : null;

  async function zapisz() {
    setBlad(null);

    if (!sesja) {
      setBlad('Brak zalogowanego użytkownika.');
      return;
    }
    if (!poprawnaData(dataUrodzenia)) {
      setBlad('Data urodzenia musi mieć postać RRRR-MM-DD, na przykład 1967-01-15.');
      return;
    }
    if (wiek !== null && wiek < 18) {
      setBlad('Talerz jest przeznaczony wyłącznie dla osób pełnoletnich.');
      return;
    }
    if (!wzrostL || wzrostL < 120 || wzrostL > 230) {
      setBlad('Wzrost podaj w centymetrach, w zakresie 120–230.');
      return;
    }
    if (!wagaL || wagaL < 30 || wagaL > 300) {
      setBlad('Wagę podaj w kilogramach, w zakresie 30–300.');
      return;
    }

    setZajety(true);
    try {
      const { data: profil, error: bladProfilu } = await supabase
        .from('profile')
        .insert({
          konto_id: sesja.user.id,
          imie: imie.trim(),
          plec,
          data_urodzenia: dataUrodzenia,
          wzrost_cm: Math.round(wzrostL),
          aktywnosc,
        })
        .select('id')
        .single();

      if (bladProfilu) throw bladProfilu;

      // Waga i obwód talii to pomiary, nie cechy stałe — trafiają do osobnej tabeli.
      const pomiary = [{ profil_id: profil.id, typ: 'waga', wartosc: wagaL }];
      const taliaL = liczba(talia);
      if (taliaL) {
        pomiary.push({ profil_id: profil.id, typ: 'talia', wartosc: taliaL });
      }

      const { error: bladPomiaru } = await supabase.from('pomiary').insert(pomiary);
      if (bladPomiaru) throw bladPomiaru;

      router.back();
    } catch (e) {
      const tresc = komunikatBledu(e);
      setBlad(
        tresc.includes('najwyżej 3 profile')
          ? 'Konto może mieć najwyżej 3 profile.'
          : tresc.includes('pełnoletnich')
            ? 'Talerz jest przeznaczony wyłącznie dla osób pełnoletnich.'
            : tresc
      );
    } finally {
      setZajety(false);
    }
  }

  return (
    <Ekran tytul="Nowy profil" podtytul="Dane potrzebne do wyliczenia zapotrzebowania">
      <Karta style={styles.formularz}>
        <Pole etykieta="Imię" value={imie} onChangeText={setImie} placeholder="Roman" />

        <Wybor
          etykieta="Płeć"
          wybrana={plec}
          onZmiana={setPlec}
          opcje={[
            { wartosc: 'M', etykieta: 'Mężczyzna' },
            { wartosc: 'K', etykieta: 'Kobieta' },
          ]}
        />

        <Pole
          etykieta="Data urodzenia (RRRR-MM-DD)"
          value={dataUrodzenia}
          onChangeText={setDataUrodzenia}
          placeholder="1967-01-15"
          inputMode="numeric"
        />

        <Pole
          etykieta="Wzrost (cm)"
          value={wzrost}
          onChangeText={setWzrost}
          placeholder="189"
          inputMode="numeric"
        />

        <Pole
          etykieta="Waga (kg)"
          value={waga}
          onChangeText={setWaga}
          placeholder="90"
          inputMode="decimal"
        />

        <Pole
          etykieta="Obwód talii (cm) — nieobowiązkowy"
          value={talia}
          onChangeText={setTalia}
          placeholder="98"
          inputMode="decimal"
        />
      </Karta>

      <Karta>
        <Wybor
          etykieta="Poziom aktywności"
          wybrana={aktywnosc}
          onZmiana={setAktywnosc}
          opcje={(Object.keys(AKTYWNOSC) as PoziomAktywnosci[]).map((k) => ({
            wartosc: k,
            etykieta: k.replace('_', ' '),
            opis: AKTYWNOSC[k].opis,
          }))}
        />
      </Karta>

      {podglad && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            WYLICZENIE
          </ThemedText>
          <ThemedText type="small">
            Przemiana podstawowa: {podglad.przemiana} kcal
          </ThemedText>
          <ThemedText type="small">
            Zapotrzebowanie dzienne: {podglad.zapotrzebowanie} kcal
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Przemiana podstawowa to energia zużywana w spoczynku — poniżej tej wartości
            aplikacja nie pozwoli ustawić celu.
          </ThemedText>
        </Karta>
      )}

      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      <Przycisk tytul="Zapisz profil" onPress={zapisz} zajety={zajety} wylaczony={!komplet} />
      <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => router.back()} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  formularz: { gap: Spacing.three },
});
