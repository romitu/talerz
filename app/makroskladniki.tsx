import { StyleSheet, View } from 'react-native';

import {
  HeroArtykulu,
  Kafel,
  ListaPunktow,
  NaglowekSekcji,
  PasekSekcji,
  Punkt,
  SiatkaKafli,
  useNawigacjaSekcji,
  Uwaga,
  Wyroznienie,
  Zrodla,
} from '@/components/artykul';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';
import { KOLOR_MAKRO, Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';

/**
 * Podstawa żywieniowa przepisów — treść zsynchronizowana z makietą
 * `Podstawa żywieniowa przepisów.html` od Romana, złożona z klocków
 * z `components/artykul.tsx` (te same, co „Dlaczego Talerz”).
 *
 * Ekran odpowiada na jedno pytanie: skąd biorą się dania w Talerzu. Dlatego
 * dwie listy — co preferujemy i czego unikamy — stoją naprzeciw siebie jako
 * ptaszki i krzyżyki, a nie jako dwa nieodróżnialne akapity.
 */

const SEKCJE = [
  { id: 'podstawa', skrot: 'Podstawa' },
  { id: 'wybory', skrot: 'Wybory' },
  { id: 'danie', skrot: 'Danie' },
  { id: 'makro', skrot: 'Makro' },
];

const PREFEROWANE: Punkt[] = [
  {
    tytul: 'Wartościowe źródła białka',
    opis: 'mięso, ryby, jaja, nabiał, rośliny strączkowe, orzechy i nasiona',
  },
  { tytul: 'Warzywa i owoce', opis: 'w możliwie naturalnej postaci' },
  { tytul: 'Produkty pełnoziarniste', opis: 'i inne źródła błonnika' },
  {
    tytul: 'Tłuszcze z pełnowartościowych produktów',
    opis: 'a nie dodane przy okazji przetwarzania',
  },
  {
    tytul: 'Krótki i prosty skład',
    opis: 'produkty, z których da się przygotować zwykły domowy posiłek',
  },
];

const UNIKANE: Punkt[] = [
  { tytul: 'Żywność wysoko przetworzona' },
  { tytul: 'Produkty z dużą ilością cukrów dodanych' },
  { tytul: 'Słodzone napoje' },
  {
    tytul: 'Produkty rafinowane',
    opis: 'będące głównie źródłem szybko dostępnych węglowodanów',
  },
  {
    tytul: 'Gotowce do zastąpienia',
    opis: 'wszystko, co łatwo złożyć z prostszych składników',
  },
];

const OCENA_DANIA: Kafel[] = [
  { ikona: 'flame-outline', tytul: 'Energia i białko', opis: 'posiłek dostarcza ich odpowiednią ilość' },
  { ikona: 'leaf-outline', tytul: 'Warzywa', opis: 'lub inne wartościowe składniki' },
  { ikona: 'nutrition-outline', tytul: 'Błonnik', opis: 'traktowany jako osobny cel, nie efekt uboczny' },
  { ikona: 'cart-outline', tytul: 'Zwykłe produkty', opis: 'da się je kupić przy okazji normalnych zakupów' },
  { ikona: 'today-outline', tytul: 'Codzienność', opis: 'nadaje się do normalnego, powtarzalnego jedzenia' },
];

const MAKRO_CHIPY = [
  { etykieta: 'Białko', kolor: KOLOR_MAKRO.bialko },
  { etykieta: 'Tłuszcz', kolor: KOLOR_MAKRO.tluszcz },
  { etykieta: 'Węglowodany', kolor: KOLOR_MAKRO.wegle },
];

export default function EkranPodstawyZywieniowej() {
  const motyw = useTheme();
  const { przewijanie, zapiszUklad, przewinDo } = useNawigacjaSekcji();

  return (
    <Ekran
      tytul="Podstawa żywieniowa przepisów"
      refPrzewijania={przewijanie}
      naglowekStaly={<PasekSekcji pozycje={SEKCJE} onWybor={przewinDo} />}>
      <HeroArtykulu
        ikona="restaurant"
        odznaka="Podstawa żywieniowa"
        tytul="Na jakich zasadach dobierane są dania i składniki"
        lead="Przepisy i baza składników w Talerzu nie zostały zbudowane wyłącznie na podstawie kalorii i makroskładników. Punktem wyjścia są aktualne zalecenia żywieniowe oraz wyniki badań dotyczących sposobu odżywiania i zdrowia."
      />

      <NaglowekSekcji
        nadtytul="Na czym opierają się dania"
        tytul="Aktualne zalecenia, nie sama tabela wartości odżywczych."
        onUklad={zapiszUklad('podstawa')}
      />
      <Karta>
        <View style={[styles.odznakaZrodla, { backgroundColor: `${motyw.accent}14` }]}>
          <ThemedText type="smallBold" style={[styles.odznakaTekst, { color: motyw.accent }]}>
            DIETARY GUIDELINES FOR AMERICANS 2025–2030
          </ThemedText>
        </View>
        <ThemedText type="small" themeColor="textSecondary">
          Jedną z głównych podstaw są wytyczne opracowane przez USDA i HHS. Aktualna edycja kładzie
          nacisk przede wszystkim na pełnowartościową, możliwie mało przetworzoną żywność oraz
          ograniczanie produktów wysoko przetworzonych, cukrów dodanych i rafinowanych
          węglowodanów.
        </ThemedText>
      </Karta>

      <NaglowekSekcji
        nadtytul="Wybory przy budowaniu bazy"
        tytul="Co trafia do przepisów, a co zostaje poza nimi."
        onUklad={zapiszUklad('wybory')}
      />
      <Karta>
        <ThemedText type="smallBold" themeColor="accent" style={styles.tytulListy}>
          PREFERUJEMY
        </ThemedText>
        <ListaPunktow pozycje={PREFEROWANE} wariant="tak" />
      </Karta>
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary" style={styles.tytulListy}>
          STARAMY SIĘ UNIKAĆ
        </ThemedText>
        <ListaPunktow pozycje={UNIKANE} wariant="nie" />
      </Karta>
      <Uwaga
        tytul="To nie jest lista produktów zakazanych"
        tekst="Liczy się cały sposób odżywiania i to, co jemy regularnie. Aktualne zalecenia żywieniowe również traktują dietę jako całościowy wzorzec, a nie listę obowiązkowych konkretnych posiłków."
      />

      <NaglowekSekcji
        nadtytul="Dobre danie"
        tytul="Danie ma być nie tylko „zdrowe na papierze”."
        onUklad={zapiszUklad('danie')}
      />
      <ThemedText type="small" themeColor="textSecondary">
        Przy tworzeniu przepisów bierzemy pod uwagę również to, czy posiłek:
      </ThemedText>
      <SiatkaKafli kafle={OCENA_DANIA} />
      <ThemedText type="small" themeColor="textSecondary">
        Talerz nie ma tworzyć idealnej diety laboratoryjnej. Ma pomagać przez większość dni
        wybierać proste, sycące i wartościowe posiłki, które rzeczywiście chce się ugotować
        i zjeść.
      </ThemedText>

      <NaglowekSekcji
        nadtytul="Kalorie i makroskładniki"
        tytul="Liczby pomagają dobrać porcję, nie ocenić produkt."
        onUklad={zapiszUklad('makro')}
      />
      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          Przy bilansowaniu posiłków wykorzystywane są również Dietary Reference Intakes (DRI)
          opracowane przez National Academies oraz zakresy AMDR — Acceptable Macronutrient
          Distribution Ranges.
        </ThemedText>
        <View style={styles.chipy}>
          {MAKRO_CHIPY.map((c) => (
            <View key={c.etykieta} style={[styles.chip, { backgroundColor: `${c.kolor}1F` }]}>
              <View style={[styles.kropka, { backgroundColor: c.kolor }]} />
              <ThemedText type="smallBold" style={[styles.chipTekst, { color: c.kolor }]}>
                {c.etykieta}
              </ThemedText>
            </View>
          ))}
        </View>
        <ThemedText type="small" themeColor="textSecondary">
          AMDR określają zakres udziału poszczególnych makroskładników w całkowitej energii diety.
          Aktualne zalecenia dodatkowo zwracają uwagę na odpowiednią podaż białka i wartościowe
          jego źródła.
        </ThemedText>
      </Karta>

      <Wyroznienie
        tekst="Najpierw wybieramy dobre jedzenie. Dopiero później dopasowujemy jego ilość do potrzeb konkretnej osoby."
        podtekst="Kalorie, białko, tłuszcz i węglowodany pomagają określić porcję. Nie powinny jednak decydować o jakości produktu."
      />

      <Zrodla
        pozycje={[
          'Dietary Guidelines for Americans 2025–2030, USDA/HHS',
          'Dietary Reference Intakes, National Academies of Sciences, Engineering, and Medicine',
          'USDA Nutrition Evidence Systematic Review',
        ]}
      />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  odznakaZrodla: {
    alignSelf: 'flex-start',
    borderRadius: 999,
    paddingVertical: 6,
    paddingHorizontal: Spacing.three,
  },
  odznakaTekst: {
    fontSize: 11,
    letterSpacing: 0.6,
  },
  tytulListy: {
    fontSize: 11,
    letterSpacing: 0.8,
  },
  chipy: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
  },
  chip: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    borderRadius: 999,
    paddingVertical: 6,
    paddingHorizontal: Spacing.two,
  },
  kropka: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  chipTekst: {
    fontSize: 12,
  },
});
