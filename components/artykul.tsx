import { Ionicons } from '@expo/vector-icons';
import { useRef } from 'react';
import { Pressable, ScrollView, StyleSheet, View, type LayoutChangeEvent } from 'react-native';

import { Karta } from './karta';
import { ThemedText } from './themed-text';
import { ThemedView } from './themed-view';

import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/**
 * Klocki ekranów „czytanych” — Podstawa żywieniowa przepisów i Dlaczego Talerz.
 *
 * Oba ekrany to dłuższy tekst, a nie formularz. Sam akapit pod akapitem czyta
 * się źle i wygląda jak wydrukowana kartka, dlatego treść rozbijamy na
 * powtarzalne elementy: nagłówek z ikoną, pasek sekcji na górze, kafle,
 * numerowaną oś kroków i wyróżnione zdania. Trzymamy je tutaj, żeby oba ekrany
 * (a w razie potrzeby kolejne) wyglądały tak samo i nie kopiowały tych samych
 * stu linii stylów.
 *
 * Kolory biorą się z akcentu wybranego stylu — miękkie tła robimy dopisując do
 * niego przezroczystość dwucyfrowym sufiksem szesnastkowym (`${akcent}14`),
 * tak samo jak w kaflach wyniku. Dzięki temu ekran wygląda spójnie w każdym
 * z trzech stylów i w trybie ciemnym, bez osobnej palety.
 */

export type Ikona = keyof typeof Ionicons.glyphMap;

/* ------------------------------------------------------------------ */
/* Pasek sekcji                                                        */
/* ------------------------------------------------------------------ */

export type PozycjaPaska = { id: string; skrot: string };

/**
 * Przewijanie do sekcji z paska na górze ekranu.
 *
 * Zwraca to, co ekran musi wpiąć: referencję do `Ekran`, zapisywanie pozycji
 * każdej sekcji i skok do wybranej.
 */
export function useNawigacjaSekcji() {
  const przewijanie = useRef<ScrollView>(null);
  const pozycje = useRef<Record<string, number>>({});

  function zapiszUklad(id: string) {
    return (e: LayoutChangeEvent) => {
      pozycje.current[id] = e.nativeEvent.layout.y;
    };
  }

  function przewinDo(id: string) {
    const y = pozycje.current[id];
    if (y != null) {
      przewijanie.current?.scrollTo({ y: Math.max(y - Spacing.three, 0), animated: true });
    }
  }

  return { przewijanie, zapiszUklad, przewinDo };
}

export function PasekSekcji({
  pozycje,
  onWybor,
}: {
  pozycje: PozycjaPaska[];
  onWybor: (id: string) => void;
}) {
  const motyw = useTheme();

  return (
    <ThemedView type="backgroundElement" style={[styles.pasek, { borderColor: motyw.border }]}>
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        contentContainerStyle={styles.paskiZawartosc}>
        {pozycje.map((p, i) => (
          <Pressable
            key={p.id}
            onPress={() => onWybor(p.id)}
            accessibilityRole="button"
            style={[styles.chip, { borderColor: motyw.border, backgroundColor: motyw.background }]}>
            <View style={[styles.chipNumer, { backgroundColor: `${motyw.accent}1c` }]}>
              <ThemedText style={[styles.chipNumerTekst, { color: motyw.accent }]}>
                {i + 1}
              </ThemedText>
            </View>
            <ThemedText style={styles.chipTekst} themeColor="textSecondary" numberOfLines={1}>
              {p.skrot}
            </ThemedText>
          </Pressable>
        ))}
      </ScrollView>
    </ThemedView>
  );
}

/* ------------------------------------------------------------------ */
/* Nagłówek ekranu                                                     */
/* ------------------------------------------------------------------ */

export function HeroArtykulu({
  ikona,
  odznaka,
  tytul,
  lead,
}: {
  ikona: Ikona;
  odznaka: string;
  tytul: string;
  lead: string;
}) {
  const motyw = useTheme();

  return (
    <View style={styles.hero}>
      <View style={[styles.heroIkona, { backgroundColor: `${motyw.accent}1c` }]}>
        <Ionicons name={ikona} size={30} color={motyw.accent} />
      </View>
      <View style={[styles.heroOdznaka, { borderColor: motyw.border }]}>
        <View style={[styles.heroOdznakaKropka, { backgroundColor: motyw.accent }]} />
        <ThemedText type="small" themeColor="textSecondary" style={styles.heroOdznakaTekst}>
          {odznaka.toUpperCase()}
        </ThemedText>
      </View>
      <ThemedText style={styles.heroTytul}>{tytul}</ThemedText>
      <ThemedText type="small" themeColor="textSecondary" style={styles.heroLead}>
        {lead}
      </ThemedText>
    </View>
  );
}

/** Trzy krótkie hasła pod nagłówkiem — po jednym w pigułce z ikoną. */
export function PigulkiHero({ pozycje }: { pozycje: { ikona: Ikona; tekst: string }[] }) {
  const motyw = useTheme();

  return (
    <View style={styles.pigulki}>
      {pozycje.map((p) => (
        <View
          key={p.tekst}
          style={[styles.pigulka, { borderColor: motyw.border, backgroundColor: `${motyw.accent}0F` }]}>
          <Ionicons name={p.ikona} size={14} color={motyw.accent} />
          <ThemedText style={styles.pigulkaTekst} themeColor="textSecondary" numberOfLines={1}>
            {p.tekst}
          </ThemedText>
        </View>
      ))}
    </View>
  );
}

/* ------------------------------------------------------------------ */
/* Nagłówek sekcji                                                     */
/* ------------------------------------------------------------------ */

export function NaglowekSekcji({
  nadtytul,
  tytul,
  onUklad,
}: {
  nadtytul: string;
  tytul: string;
  onUklad?: (e: LayoutChangeEvent) => void;
}) {
  const motyw = useTheme();

  return (
    <View onLayout={onUklad} style={styles.naglowekSekcji}>
      <View style={styles.nadtytulWiersz}>
        <View style={[styles.kreska, { backgroundColor: motyw.accent }]} />
        <ThemedText style={[styles.nadtytul, { color: motyw.accent }]}>
          {nadtytul.toUpperCase()}
        </ThemedText>
      </View>
      <ThemedText style={styles.tytulSekcji}>{tytul}</ThemedText>
    </View>
  );
}

/* ------------------------------------------------------------------ */
/* Wyróżnienia                                                         */
/* ------------------------------------------------------------------ */

/** Zdanie, które ma zostać w głowie — na miękkim tle akcentu, na środku. */
export function Wyroznienie({ tekst, podtekst }: { tekst: string; podtekst?: string }) {
  const motyw = useTheme();

  return (
    <View
      style={[
        styles.wyroznienie,
        { backgroundColor: `${motyw.accent}14`, borderColor: `${motyw.accent}33` },
      ]}>
      <ThemedText style={[styles.wyroznienieTekst, { color: motyw.accent }]}>{tekst}</ThemedText>
      {podtekst ? (
        <ThemedText type="small" themeColor="textSecondary" style={styles.wysrodkowany}>
          {podtekst}
        </ThemedText>
      ) : null}
    </View>
  );
}

/** To samo, ale z wielkim cudzysłowem — dla jednej myśli przewodniej sekcji. */
export function Cytat({ tekst, podtekst }: { tekst: string; podtekst?: string }) {
  const motyw = useTheme();

  return (
    <View
      style={[
        styles.cytat,
        { backgroundColor: `${motyw.accent}14`, borderColor: `${motyw.accent}33` },
      ]}>
      <Ionicons
        name="chatbox-ellipses"
        size={92}
        color={`${motyw.accent}12`}
        style={styles.cytatZnak}
      />
      <ThemedText style={[styles.cytatTekst, { color: motyw.accent }]}>{tekst}</ThemedText>
      {podtekst ? (
        <ThemedText type="small" themeColor="textSecondary">
          {podtekst}
        </ThemedText>
      ) : null}
    </View>
  );
}

/** Uwaga na marginesie — karta z paskiem akcentu z lewej. */
export function Uwaga({ tytul, tekst }: { tytul: string; tekst: string }) {
  const motyw = useTheme();

  return (
    <Karta style={{ ...styles.uwaga, borderLeftColor: motyw.accent }}>
      <View style={styles.uwagaNaglowek}>
        <Ionicons name="information-circle" size={18} color={motyw.accent} />
        <ThemedText type="smallBold" style={{ color: motyw.accent }}>
          {tytul}
        </ThemedText>
      </View>
      <ThemedText type="small" themeColor="textSecondary">
        {tekst}
      </ThemedText>
    </Karta>
  );
}

/* ------------------------------------------------------------------ */
/* Listy i kafle                                                       */
/* ------------------------------------------------------------------ */

export type Punkt = { tytul: string; opis?: string };

/**
 * Lista „za” i „przeciw”.
 *
 * `wariant` decyduje o znaczku i kolorze: `tak` to ptaszek w akcencie,
 * `nie` — krzyżyk w kolorze drugoplanowym, żeby druga lista nie krzyczała
 * mocniej niż ta właściwa.
 */
export function ListaPunktow({
  pozycje,
  wariant,
}: {
  pozycje: Punkt[];
  wariant: 'tak' | 'nie';
}) {
  const motyw = useTheme();
  const kolor = wariant === 'tak' ? motyw.accent : motyw.textSecondary;

  return (
    <View style={styles.lista}>
      {pozycje.map((p, i) => (
        <View
          key={p.tytul}
          style={[
            styles.wierszPunktu,
            i > 0 && { borderTopWidth: StyleSheet.hairlineWidth, borderTopColor: motyw.border },
          ]}>
          <View style={[styles.znaczek, { backgroundColor: `${kolor}1c` }]}>
            <Ionicons name={wariant === 'tak' ? 'checkmark' : 'close'} size={14} color={kolor} />
          </View>
          <View style={styles.trescPunktu}>
            <ThemedText type="smallBold">{p.tytul}</ThemedText>
            {p.opis ? (
              <ThemedText type="small" themeColor="textSecondary">
                {p.opis}
              </ThemedText>
            ) : null}
          </View>
        </View>
      ))}
    </View>
  );
}

export type Kafel = { ikona: Ikona; tytul: string; opis: string };

/** Kafle po dwa w rzędzie — na wąskim ekranie zawijają się do jednego. */
export function SiatkaKafli({ kafle }: { kafle: Kafel[] }) {
  const motyw = useTheme();

  return (
    <View style={styles.siatka}>
      {kafle.map((k) => (
        <ThemedView
          key={k.tytul}
          type="backgroundElement"
          style={[styles.kafel, { borderColor: motyw.border }]}>
          <View style={[styles.kafelIkona, { backgroundColor: `${motyw.accent}1c` }]}>
            <Ionicons name={k.ikona} size={20} color={motyw.accent} />
          </View>
          <ThemedText type="smallBold">{k.tytul}</ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            {k.opis}
          </ThemedText>
        </ThemedView>
      ))}
    </View>
  );
}

/** Wiersz z ikoną w kółku, tytułem i opisem — dla list z „charakterem”. */
export function WierszZIkona({ ikona, tytul, opis }: Kafel) {
  const motyw = useTheme();

  return (
    <View style={styles.wierszIkony}>
      <View style={[styles.kolkoIkony, { backgroundColor: `${motyw.accent}1c` }]}>
        <Ionicons name={ikona} size={20} color={motyw.accent} />
      </View>
      <View style={styles.trescPunktu}>
        <ThemedText type="smallBold">{tytul}</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          {opis}
        </ThemedText>
      </View>
    </View>
  );
}

/* ------------------------------------------------------------------ */
/* Oś kroków                                                           */
/* ------------------------------------------------------------------ */

export type Krok = { tytul: string; opis: string };

/**
 * Numerowana oś — kółko z numerem i pionowa kreska prowadząca do następnego
 * kroku. Kolejność jest tu treścią, więc widać ją od razu, bez czytania.
 */
export function OsKrokow({ kroki }: { kroki: Krok[] }) {
  const motyw = useTheme();

  return (
    <View>
      {kroki.map((k, i) => (
        <View key={k.tytul} style={styles.krok}>
          <View style={styles.krokLewa}>
            <View style={[styles.krokNumer, { backgroundColor: `${motyw.accent}1c` }]}>
              <ThemedText style={[styles.krokNumerTekst, { color: motyw.accent }]}>
                {String(i + 1).padStart(2, '0')}
              </ThemedText>
            </View>
            {i < kroki.length - 1 ? (
              <View style={[styles.krokKreska, { backgroundColor: motyw.border }]} />
            ) : null}
          </View>
          <View style={[styles.krokTresc, i < kroki.length - 1 && styles.krokOdstep]}>
            <ThemedText type="smallBold">{k.tytul}</ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              {k.opis}
            </ThemedText>
          </View>
        </View>
      ))}
    </View>
  );
}

/* ------------------------------------------------------------------ */
/* Stopka ze źródłami                                                  */
/* ------------------------------------------------------------------ */

export function Zrodla({ pozycje }: { pozycje: string[] }) {
  const motyw = useTheme();

  return (
    <View style={[styles.zrodla, { borderColor: motyw.border }]}>
      <View style={styles.zrodlaNaglowek}>
        <Ionicons name="library-outline" size={16} color={motyw.textSecondary} />
        <ThemedText style={styles.nadtytul} themeColor="textSecondary">
          PODSTAWA
        </ThemedText>
      </View>
      {pozycje.map((p) => (
        <ThemedText key={p} type="small" themeColor="textSecondary" style={styles.zrodloTekst}>
          {p}
        </ThemedText>
      ))}
    </View>
  );
}

const styles = StyleSheet.create({
  pasek: {
    borderBottomWidth: StyleSheet.hairlineWidth,
    paddingVertical: Spacing.two,
  },
  paskiZawartosc: {
    flexDirection: 'row',
    flexWrap: 'nowrap',
    paddingHorizontal: Spacing.three,
    gap: Spacing.one,
  },
  chip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: 6,
    paddingHorizontal: Spacing.two,
    borderRadius: 999,
    borderWidth: StyleSheet.hairlineWidth,
  },
  chipNumer: {
    width: 16,
    height: 16,
    borderRadius: 8,
    alignItems: 'center',
    justifyContent: 'center',
  },
  chipNumerTekst: {
    fontSize: 10,
    fontWeight: '700',
    lineHeight: 12,
  },
  chipTekst: {
    fontSize: 12,
  },
  hero: {
    alignItems: 'center',
    paddingTop: Spacing.four,
    paddingBottom: Spacing.two,
    gap: Spacing.one,
  },
  heroIkona: {
    width: 60,
    height: 60,
    borderRadius: 30,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: Spacing.two,
  },
  heroOdznaka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderWidth: StyleSheet.hairlineWidth,
    borderRadius: 999,
    paddingVertical: 5,
    paddingHorizontal: Spacing.three,
  },
  heroOdznakaKropka: {
    width: 6,
    height: 6,
    borderRadius: 3,
  },
  heroOdznakaTekst: {
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 0.6,
    textAlign: 'center',
  },
  heroTytul: {
    marginTop: Spacing.three,
    fontSize: 30,
    lineHeight: 36,
    fontWeight: '700',
    letterSpacing: -0.6,
    textAlign: 'center',
  },
  heroLead: {
    textAlign: 'center',
    marginTop: Spacing.two,
  },
  pigulki: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    gap: Spacing.one,
  },
  pigulka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    paddingVertical: 6,
    paddingHorizontal: Spacing.two,
    borderRadius: 999,
    borderWidth: StyleSheet.hairlineWidth,
  },
  pigulkaTekst: {
    fontSize: 12,
  },
  naglowekSekcji: {
    gap: Spacing.one,
    paddingTop: Spacing.two,
  },
  nadtytulWiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  kreska: {
    width: 18,
    height: 2,
    borderRadius: 1,
  },
  nadtytul: {
    fontSize: 11,
    fontWeight: '700',
    letterSpacing: 0.8,
  },
  tytulSekcji: {
    fontSize: 21,
    lineHeight: 27,
    fontWeight: '700',
    letterSpacing: -0.3,
  },
  wyroznienie: {
    borderRadius: Spacing.three,
    borderWidth: StyleSheet.hairlineWidth,
    padding: Spacing.three,
    gap: Spacing.two,
    alignItems: 'center',
  },
  wyroznienieTekst: {
    fontSize: 17,
    lineHeight: 24,
    fontWeight: '700',
    textAlign: 'center',
  },
  wysrodkowany: {
    textAlign: 'center',
  },
  cytat: {
    borderRadius: Spacing.three,
    borderWidth: StyleSheet.hairlineWidth,
    padding: Spacing.four,
    gap: Spacing.two,
    overflow: 'hidden',
  },
  cytatZnak: {
    position: 'absolute',
    right: -14,
    bottom: -22,
  },
  cytatTekst: {
    fontSize: 22,
    lineHeight: 29,
    fontWeight: '700',
    letterSpacing: -0.4,
  },
  uwaga: {
    borderLeftWidth: 4,
  },
  uwagaNaglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  lista: {
    gap: 0,
  },
  wierszPunktu: {
    flexDirection: 'row',
    gap: Spacing.three,
    alignItems: 'flex-start',
    paddingVertical: Spacing.two,
  },
  znaczek: {
    width: 22,
    height: 22,
    borderRadius: 11,
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 1,
  },
  trescPunktu: {
    flex: 1,
    gap: 1,
  },
  siatka: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  kafel: {
    flexBasis: 150,
    flexGrow: 1,
    borderRadius: Spacing.three,
    borderWidth: StyleSheet.hairlineWidth,
    padding: Spacing.three,
    gap: Spacing.one,
  },
  kafelIkona: {
    width: 38,
    height: 38,
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: Spacing.two,
  },
  wierszIkony: {
    flexDirection: 'row',
    gap: Spacing.three,
    alignItems: 'flex-start',
  },
  kolkoIkony: {
    width: 38,
    height: 38,
    borderRadius: 19,
    alignItems: 'center',
    justifyContent: 'center',
  },
  krok: {
    flexDirection: 'row',
    gap: Spacing.three,
  },
  krokLewa: {
    alignItems: 'center',
  },
  krokNumer: {
    width: 34,
    height: 34,
    borderRadius: 17,
    alignItems: 'center',
    justifyContent: 'center',
  },
  krokNumerTekst: {
    fontSize: 12,
    fontWeight: '700',
    lineHeight: 16,
  },
  krokKreska: {
    flex: 1,
    width: 2,
    marginVertical: Spacing.one,
  },
  krokTresc: {
    flex: 1,
    gap: 1,
    paddingTop: Spacing.one,
  },
  krokOdstep: {
    paddingBottom: Spacing.three,
  },
  zrodla: {
    borderTopWidth: StyleSheet.hairlineWidth,
    paddingTop: Spacing.three,
    gap: Spacing.one,
  },
  zrodlaNaglowek: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    marginBottom: Spacing.one,
  },
  zrodloTekst: {
    fontSize: 12,
    lineHeight: 18,
  },
});
