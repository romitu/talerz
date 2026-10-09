import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { StyleSheet, View } from 'react-native';

import { Karta } from './karta';
import { Pole } from './pole';
import { Przycisk } from './przycisk';
import { ThemedText } from './themed-text';
import { Wybor } from './wybor';

import { Spacing } from '@/constants/theme';
import { komunikatBledu } from '@/lib/blad';
import {
  ostrzezenieOKaloriach,
  ROLE_SKLADNIKA,
  sprawdzSkladnik,
  zapiszSkladnik,
  type DaneSkladnika,
  type RolaSkladnika,
  type Skladnik,
} from '@/lib/skladniki';

// Nazwy i opisy ról są w tłumaczeniach: `rolaSkladnika.<rola>.nazwa` / `.opis`.

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
  const { t } = useTranslation();
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
  const [moznaDzielic, setMoznaDzielic] = useState<'' | 'nie' | 'tak'>(
    skladnik?.mozna_dzielic === null || skladnik?.mozna_dzielic === undefined
      ? ''
      : skladnik.mozna_dzielic
        ? 'tak'
        : 'nie'
  );
  const [rola, setRola] = useState<RolaSkladnika>(skladnik?.rola ?? 'baza');
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
    mozna_dzielic: moznaDzielic === '' ? null : moznaDzielic === 'tak',
    rola,
    tagi: tagi
      .split(',')
      .map((x) => x.trim())
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
          {skladnik ? t('formularzSkladnika.edycja') : t('formularzSkladnika.nowy')}
        </ThemedText>

        <Pole etykieta={t('wspolne.nazwa')} value={nazwa} onChangeText={setNazwa} placeholder={t('formularzSkladnika.przykladNazwy')} />

        <ThemedText type="small" themeColor="textSecondary">
          {t('formularzSkladnika.na100g')}
        </ThemedText>

        <Pole etykieta={t('formularzSkladnika.kcal')} value={kcal} onChangeText={setKcal} inputMode="decimal" placeholder="378" />
        <Pole etykieta={t('formularzSkladnika.bialko')} value={bialko} onChangeText={setBialko} inputMode="decimal" placeholder="11" />
        <Pole etykieta={t('formularzSkladnika.tluszcz')} value={tluszcz} onChangeText={setTluszcz} inputMode="decimal" placeholder="4.2" />
        <Pole etykieta={t('formularzSkladnika.wegle')} value={wegle} onChangeText={setWegle} inputMode="decimal" placeholder="71" />
        <Pole etykieta={t('formularzSkladnika.blonnik')} value={blonnik} onChangeText={setBlonnik} inputMode="decimal" placeholder="10" />
        <ThemedText type="small" themeColor="textSecondary">
          {t('formularzSkladnika.blonnikOpis')}
        </ThemedText>
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('formularzSkladnika.cukry')}
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {t('formularzSkladnika.cukryOpis')}
        </ThemedText>

        <Pole etykieta={t('formularzSkladnika.cukryOgolem')} value={cukryOgolem} onChangeText={setCukryOgolem} inputMode="decimal" placeholder="0" />
        <Pole etykieta={t('formularzSkladnika.cukryWolne')} value={cukryWolne} onChangeText={setCukryWolne} inputMode="decimal" placeholder="0" />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          {t('formularzSkladnika.pozostale')}
        </ThemedText>

        <Pole
          etykieta={t('formularzSkladnika.nova')}
          value={nova}
          onChangeText={setNova}
          inputMode="numeric"
          placeholder="1"
        />
        <ThemedText type="small" themeColor="textSecondary">
          {t('formularzSkladnika.novaOpis')}
        </ThemedText>

        <Pole
          etykieta={t('formularzSkladnika.opakowanie')}
          value={opakowanie}
          onChangeText={setOpakowanie}
          inputMode="numeric"
          placeholder="400"
        />
        <Pole
          etykieta={t('formularzSkladnika.sztuka')}
          value={masaSztuki}
          onChangeText={setMasaSztuki}
          inputMode="decimal"
          placeholder="55"
        />
        <ThemedText type="small" themeColor="textSecondary">
          {t('formularzSkladnika.sztukaOpis')}
        </ThemedText>

        <Wybor
          etykieta={t('formularzSkladnika.rola')}
          wybrana={rola}
          onZmiana={setRola}
          opcje={ROLE_SKLADNIKA.map((r) => ({
            wartosc: r,
            etykieta: t(`rolaSkladnika.${r}.nazwa`),
            opis: t(`rolaSkladnika.${r}.opis`),
          }))}
        />

        <Wybor
          etykieta={t('formularzSkladnika.kwantyzacja')}
          wybrana={moznaDzielic}
          onZmiana={setMoznaDzielic}
          opcje={[
            { wartosc: 'nie', etykieta: t('formularzSkladnika.niepodzielny') },
            { wartosc: 'tak', etykieta: t('formularzSkladnika.podzielny') },
          ]}
        />

        <Pole
          etykieta={t('formularzSkladnika.tagi')}
          value={tagi}
          onChangeText={setTagi}
          placeholder={t('formularzSkladnika.przykladTagow')}
        />
        <ThemedText type="small" themeColor="textSecondary">
          {t('formularzSkladnika.tagiOpis')}
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

      <Przycisk tytul={skladnik ? t('wspolne.zapiszZmiany') : t('nieJemy.dodaj')} onPress={zapisz} zajety={zajety} />
      <Przycisk tytul={t('wspolne.anuluj')} wariant="poboczny" onPress={onAnuluj} />
    </View>
  );
}

const styles = StyleSheet.create({
  calosc: { gap: Spacing.three },
  grupa: { gap: Spacing.three },
});
