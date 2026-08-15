import { useState } from 'react';
import { StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';

import { Spacing } from '@/constants/theme';
import { komunikatBledu } from '@/lib/blad';
import {
  ostrzezenieOKaloriach,
  sprawdzSkladnik,
  zapiszSkladnik,
  type DaneSkladnika,
  type Skladnik,
} from '@/lib/skladniki';

type FormularzSkladnikaProps = {
  /** Podany — formularz edytuje istniejący składnik. Pominięty — dodaje nowy. */
  skladnik?: Skladnik;
  /** Nazwa wpisana wcześniej w wyszukiwarce, wstawiana od razu w pole nazwy. */
  nazwaPoczatkowa?: string;
  onZapisano: (skladnik: Skladnik) => void;
  onAnuluj: () => void;
};

function naLiczbe(tekst: string): number {
  const n = Number(String(tekst).replace(',', '.').trim());
  return Number.isFinite(n) ? n : NaN;
}

function naTekst(wartosc: number | null | undefined): string {
  return wartosc === null || wartosc === undefined ? '' : String(wartosc);
}

/**
 * Formularz jednego składnika.
 *
 * Ten sam komponent obsługuje ekran zarządzania składnikami i okienko
 * wewnątrz formularza przepisu — dzięki temu zasady sprawdzania są w obu
 * miejscach identyczne i nie rozjadą się z czasem.
 */
export function FormularzSkladnika({
  skladnik,
  nazwaPoczatkowa,
  onZapisano,
  onAnuluj,
}: FormularzSkladnikaProps) {
  const [nazwa, setNazwa] = useState(skladnik?.nazwa ?? nazwaPoczatkowa ?? '');
  const [kcal, setKcal] = useState(naTekst(skladnik?.kcal_100g));
  const [bialko, setBialko] = useState(naTekst(skladnik?.bialko_100g));
  const [tluszcz, setTluszcz] = useState(naTekst(skladnik?.tluszcz_100g));
  const [wegle, setWegle] = useState(naTekst(skladnik?.wegle_100g));
  const [blonnik, setBlonnik] = useState(naTekst(skladnik?.blonnik_100g));
  const [cukryOgolem, setCukryOgolem] = useState(naTekst(skladnik?.cukry_ogolem_100g));
  const [cukryWolne, setCukryWolne] = useState(naTekst(skladnik?.cukry_wolne_100g));
  const [nova, setNova] = useState(naTekst(skladnik?.nova));
  const [opakowanie, setOpakowanie] = useState(naTekst(skladnik?.gramatura_opakowania_g));
  const [masaSztuki, setMasaSztuki] = useState(naTekst(skladnik?.masa_sztuki_g));
  const [tagi, setTagi] = useState((skladnik?.tagi ?? []).join(', '));

  const [zajety, setZajety] = useState(false);
  const [bledy, setBledy] = useState<string[]>([]);

  const dane: DaneSkladnika = {
    nazwa: nazwa.trim(),
    zrodlo: skladnik?.zrodlo ?? 'wlasne',
    kcal_100g: naLiczbe(kcal),
    bialko_100g: naLiczbe(bialko),
    tluszcz_100g: naLiczbe(tluszcz),
    wegle_100g: naLiczbe(wegle),
    blonnik_100g: blonnik.trim() ? naLiczbe(blonnik) : 0,
    cukry_ogolem_100g: cukryOgolem.trim() ? naLiczbe(cukryOgolem) : 0,
    cukry_wolne_100g: cukryWolne.trim() ? naLiczbe(cukryWolne) : 0,
    nova: nova.trim() ? naLiczbe(nova) : null,
    gramatura_opakowania_g: opakowanie.trim() ? Math.round(naLiczbe(opakowanie)) : null,
    masa_sztuki_g: masaSztuki.trim() ? naLiczbe(masaSztuki) : null,
    tagi: tagi
      .split(',')
      .map((t) => t.trim())
      .filter(Boolean),
  };

  const ostrzezenie = ostrzezenieOKaloriach(dane);

  async function zapisz() {
    const problemy = sprawdzSkladnik(dane);
    if (problemy.length > 0) {
      setBledy(problemy);
      return;
    }

    setBledy([]);
    setZajety(true);
    try {
      onZapisano(await zapiszSkladnik(dane, skladnik?.id));
    } catch (e) {
      setBledy([komunikatBledu(e)]);
    } finally {
      setZajety(false);
    }
  }

  return (
    <View style={styles.calosc}>
      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {skladnik ? 'EDYCJA SKŁADNIKA' : 'NOWY SKŁADNIK'}
        </ThemedText>

        <Pole etykieta="Nazwa" value={nazwa} onChangeText={setNazwa} placeholder="Kasza jaglana, sucha" />

        <ThemedText type="small" themeColor="textSecondary">
          Wartości podaj zawsze na 100 g produktu — tak jak na etykiecie.
        </ThemedText>

        <Pole etykieta="Kalorie (kcal / 100 g)" value={kcal} onChangeText={setKcal} inputMode="decimal" placeholder="378" />
        <Pole etykieta="Białko (g / 100 g)" value={bialko} onChangeText={setBialko} inputMode="decimal" placeholder="11" />
        <Pole etykieta="Tłuszcz (g / 100 g)" value={tluszcz} onChangeText={setTluszcz} inputMode="decimal" placeholder="4.2" />
        <Pole etykieta="Węglowodany (g / 100 g)" value={wegle} onChangeText={setWegle} inputMode="decimal" placeholder="71" />
        <Pole etykieta="Błonnik (g / 100 g)" value={blonnik} onChangeText={setBlonnik} inputMode="decimal" placeholder="10" />
        <ThemedText type="small" themeColor="textSecondary">
          Błonnik zawiera się w węglowodanach, więc nie może ich przekraczać. Na etykiecie
          bywa podany osobno, pod pozycją „w tym błonnik”.
        </ThemedText>
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          CUKRY
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Etykieta podaje „w tym cukry” — to cukry ogółem, razem z tymi z owoców i mleka.
          Jako wolne wpisz tylko dodane oraz te z miodu, syropów i soków. Przy surowcach
          zostaw zero.
        </ThemedText>

        <Pole etykieta="Cukry ogółem (g / 100 g)" value={cukryOgolem} onChangeText={setCukryOgolem} inputMode="decimal" placeholder="0" />
        <Pole etykieta="Cukry wolne (g / 100 g)" value={cukryWolne} onChangeText={setCukryWolne} inputMode="decimal" placeholder="0" />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          POZOSTAŁE
        </ThemedText>

        <Pole
          etykieta="Grupa NOVA (1–4, nieobowiązkowa)"
          value={nova}
          onChangeText={setNova}
          inputMode="numeric"
          placeholder="1"
        />
        <ThemedText type="small" themeColor="textSecondary">
          1 — surowe, 2 — składniki kuchenne (oliwa, miód), 3 — przetworzone (ser, chleb),
          4 — wysoko przetworzone.
        </ThemedText>

        <Pole
          etykieta="Gramatura opakowania (g, nieobowiązkowa)"
          value={opakowanie}
          onChangeText={setOpakowanie}
          inputMode="numeric"
          placeholder="400"
        />
        <Pole
          etykieta="Ile waży jedna sztuka (g, nieobowiązkowe)"
          value={masaSztuki}
          onChangeText={setMasaSztuki}
          inputMode="decimal"
          placeholder="55"
        />
        <ThemedText type="small" themeColor="textSecondary">
          Wypełnij, jeśli składnik odmierza się w sztukach: jajko 55 g, liść laurowy 0,2 g,
          ząbek czosnku 5 g. Wtedy w przepisie można podać „2 szt”, a aplikacja przeliczy
          to na gramy.
        </ThemedText>

        <Pole
          etykieta="Etykiety, oddzielone przecinkami"
          value={tagi}
          onChangeText={setTagi}
          placeholder="zboze, gluten"
        />
        <ThemedText type="small" themeColor="textSecondary">
          Etykiety służą preferencjom żywieniowym. Nie są filtrem alergenów.
        </ThemedText>
      </Karta>

      {ostrzezenie && (
        <Karta>
          <ThemedText type="small" themeColor="accent">
            {ostrzezenie}
          </ThemedText>
        </Karta>
      )}

      {bledy.length > 0 && (
        <Karta>
          {bledy.map((b) => (
            <ThemedText key={b} type="small" themeColor="accent">
              {b}
            </ThemedText>
          ))}
        </Karta>
      )}

      <Przycisk tytul={skladnik ? 'Zapisz zmiany' : 'Dodaj składnik'} onPress={zapisz} zajety={zajety} />
      <Przycisk tytul="Anuluj" wariant="poboczny" onPress={onAnuluj} />
    </View>
  );
}

const styles = StyleSheet.create({
  calosc: { gap: Spacing.three },
  grupa: { gap: Spacing.three },
});
