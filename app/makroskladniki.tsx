import { Ionicons } from '@expo/vector-icons';
import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';
import { KOLOR_MAKRO, Spacing } from '@/constants/theme';

/**
 * Makroskładniki — podstawa wg aktualnych zaleceń USA.
 *
 * Treść i liczby przeniesione bez zmian z materiału źródłowego (AMDR —
 * Acceptable Macronutrient Distribution Ranges, Dietary Guidelines for
 * Americans). Oryginał był stroną HTML z szeroką tabelą — na telefonie
 * tabela z ośmioma kolumnami wymagałaby przewijania w bok, więc każdy
 * wiersz wieku/płci jest tu osobną kartą, jak wszędzie indziej w Talerzu.
 */

type Zakres = readonly [number, number];

type GrupaWiekowa = {
  wiek: string;
  plec: string;
  plecIkona?: 'female' | 'male';
  bialko: Zakres;
  tluszcz: Zakres;
  wegle: Zakres;
  dlaczego: string;
};

const GRUPY: GrupaWiekowa[] = [
  {
    wiek: '1–3 lata',
    plec: 'Dziewczynki i chłopcy',
    bialko: [5, 20],
    tluszcz: [30, 40],
    wegle: [45, 65],
    dlaczego: 'Szybki wzrost i rozwój układu nerwowego. Małe dzieci mają większe zapotrzebowanie na energię z tłuszczu.',
  },
  {
    wiek: '4–8 lat',
    plec: 'Dziewczynki i chłopcy',
    bialko: [10, 30],
    tluszcz: [25, 35],
    wegle: [45, 65],
    dlaczego: 'Organizm nadal intensywnie rośnie, ale proporcje makroskładników zbliżają się do zakresów stosowanych u starszych dzieci.',
  },
  {
    wiek: '9–13 lat',
    plec: 'Dziewczynki i chłopcy',
    bialko: [10, 30],
    tluszcz: [25, 35],
    wegle: [45, 65],
    dlaczego: 'Okres wzrostu i dużej aktywności. Potrzebna jest odpowiednia ilość energii oraz składników budulcowych.',
  },
  {
    wiek: '14–18 lat',
    plec: 'Dziewczęta',
    plecIkona: 'female',
    bialko: [10, 30],
    tluszcz: [25, 35],
    wegle: [45, 65],
    dlaczego: 'Dojrzewanie i dalszy wzrost wymagają odpowiedniej podaży energii, białka oraz dobrej jakości tłuszczów.',
  },
  {
    wiek: '14–18 lat',
    plec: 'Chłopcy',
    plecIkona: 'male',
    bialko: [10, 30],
    tluszcz: [25, 35],
    wegle: [45, 65],
    dlaczego: 'Dojrzewanie i dalszy wzrost wymagają odpowiedniej podaży energii, białka oraz dobrej jakości tłuszczów.',
  },
  {
    wiek: '19–30 lat',
    plec: 'Kobiety',
    plecIkona: 'female',
    bialko: [10, 35],
    tluszcz: [20, 35],
    wegle: [45, 65],
    dlaczego:
      'U dorosłych zakres jest szerszy. Płeć wpływa bardziej na całkowite zapotrzebowanie energetyczne i ilości w gramach niż na zakres procentowy.',
  },
  {
    wiek: '19–30 lat',
    plec: 'Mężczyźni',
    plecIkona: 'male',
    bialko: [10, 35],
    tluszcz: [20, 35],
    wegle: [45, 65],
    dlaczego:
      'U dorosłych zakres jest szerszy. Płeć wpływa bardziej na całkowite zapotrzebowanie energetyczne i ilości w gramach niż na zakres procentowy.',
  },
  {
    wiek: '31–50 lat',
    plec: 'Kobiety',
    plecIkona: 'female',
    bialko: [10, 35],
    tluszcz: [20, 35],
    wegle: [45, 65],
    dlaczego: 'Zakresy pozostają takie same. Znaczenia nabiera całkowita ilość energii, aktywność oraz jakość wybieranych produktów.',
  },
  {
    wiek: '31–50 lat',
    plec: 'Mężczyźni',
    plecIkona: 'male',
    bialko: [10, 35],
    tluszcz: [20, 35],
    wegle: [45, 65],
    dlaczego: 'Zakresy pozostają takie same. Znaczenia nabiera całkowita ilość energii, aktywność oraz jakość wybieranych produktów.',
  },
  {
    wiek: '51+',
    plec: 'Kobiety',
    plecIkona: 'female',
    bialko: [10, 35],
    tluszcz: [20, 35],
    wegle: [45, 65],
    dlaczego:
      'Zakres procentowy pozostaje podobny jak u młodszych dorosłych. Rośnie znaczenie odpowiedniej podaży i jakości białka dla utrzymania mięśni.',
  },
  {
    wiek: '51+',
    plec: 'Mężczyźni',
    plecIkona: 'male',
    bialko: [10, 35],
    tluszcz: [20, 35],
    wegle: [45, 65],
    dlaczego:
      'Zakres procentowy pozostaje podobny jak u młodszych dorosłych. Rośnie znaczenie odpowiedniej podaży i jakości białka dla utrzymania mięśni.',
  },
];

function WierszZakresu({ etykieta, kolor, zakres }: { etykieta: string; kolor: string; zakres: Zakres }) {
  return (
    <View style={styles.zakresWiersz}>
      <View style={[styles.kropka, { backgroundColor: kolor }]} />
      <ThemedText type="small" themeColor="textSecondary" style={styles.zakresEtykieta}>
        {etykieta}
      </ThemedText>
      <ThemedText type="smallBold">
        {zakres[0]}–{zakres[1]}%
      </ThemedText>
    </View>
  );
}

function KartaGrupy({ grupa }: { grupa: GrupaWiekowa }) {
  return (
    <Karta>
      <View style={styles.naglowekGrupy}>
        <Ionicons name={grupa.plecIkona ?? 'people-outline'} size={18} color={KOLOR_MAKRO.bialko} />
        <ThemedText type="smallBold">
          {grupa.wiek} · {grupa.plec}
        </ThemedText>
      </View>
      <WierszZakresu etykieta="Białko" kolor={KOLOR_MAKRO.bialko} zakres={grupa.bialko} />
      <WierszZakresu etykieta="Tłuszcz" kolor={KOLOR_MAKRO.tluszcz} zakres={grupa.tluszcz} />
      <WierszZakresu etykieta="Węglowodany" kolor={KOLOR_MAKRO.wegle} zakres={grupa.wegle} />
      <ThemedText type="small" themeColor="textSecondary">
        {grupa.dlaczego}
      </ThemedText>
    </Karta>
  );
}

export default function EkranMakroskladnikow() {
  return (
    <Ekran
      tytul="Makroskładniki"
      podtytul="Podstawa wg aktualnych zaleceń USA">
      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          Zakresy przedstawiają udział energii pochodzącej z białka, tłuszczu i węglowodanów.
          Podstawą są <ThemedText type="smallBold" themeColor="accent">AMDR — Acceptable Macronutrient
          Distribution Ranges</ThemedText>. MyPlate pokazuje natomiast, jak te zalecenia przełożyć
          na rzeczywisty sposób komponowania posiłków.
        </ThemedText>
      </Karta>

      <Karta style={styles.kartaOpisu}>
        <Ionicons name="body-outline" size={28} color={KOLOR_MAKRO.bialko} />
        <View style={styles.opisTresc}>
          <ThemedText type="smallBold" style={{ color: KOLOR_MAKRO.bialko }}>
            Białko
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Buduje i odbudowuje tkanki, uczestniczy w utrzymaniu mięśni, produkcji enzymów
            i wielu innych procesach organizmu.
          </ThemedText>
        </View>
      </Karta>

      <Karta style={styles.kartaOpisu}>
        <Ionicons name="water-outline" size={28} color={KOLOR_MAKRO.tluszcz} />
        <View style={styles.opisTresc}>
          <ThemedText type="smallBold" style={{ color: KOLOR_MAKRO.tluszcz }}>
            Tłuszcz
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Potrzebny jest m.in. do budowy błon komórkowych, funkcjonowania układu nerwowego
            i wchłaniania witamin A, D, E i K.
          </ThemedText>
        </View>
      </Karta>

      <Karta style={styles.kartaOpisu}>
        <Ionicons name="leaf-outline" size={28} color={KOLOR_MAKRO.wegle} />
        <View style={styles.opisTresc}>
          <ThemedText type="smallBold" style={{ color: KOLOR_MAKRO.wegle }}>
            Węglowodany
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Są ważnym źródłem energii. Preferowane powinny być produkty mało przetworzone
            i naturalnie bogate w błonnik.
          </ThemedText>
        </View>
      </Karta>

      <Karta style={styles.kartaTalerza}>
        <View style={styles.talerz}>
          <View style={[styles.cwiartka, styles.cwiartkaLewaGora, { backgroundColor: '#67AD53' }]} />
          <View style={[styles.cwiartka, styles.cwiartkaPrawaGora, { backgroundColor: '#D84747' }]} />
          <View style={[styles.cwiartka, styles.cwiartkaLewaDol, { backgroundColor: '#ECA037' }]} />
          <View style={[styles.cwiartka, styles.cwiartkaPrawaDol, { backgroundColor: '#7456A3' }]} />
        </View>
        <View style={styles.talerzTresc}>
          <ThemedText type="smallBold" style={{ color: KOLOR_MAKRO.bialko }}>
            Jak to połączyć z MyPlate?
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            • ok. 1/2 talerza: warzywa i owoce{'\n'}
            • ok. 1/4 talerza: produkty zbożowe, najlepiej pełnoziarniste{'\n'}
            • ok. 1/4 talerza: źródła białka{'\n'}
            • osobno: nabiał lub jego odpowiednik
          </ThemedText>
        </View>
      </Karta>

      <ThemedText type="smallBold" themeColor="textSecondary">
        ZAKRESY WG WIEKU I PŁCI
      </ThemedText>

      {GRUPY.map((g) => (
        <KartaGrupy key={`${g.wiek}-${g.plec}`} grupa={g} />
      ))}

      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          <ThemedText type="smallBold" themeColor="accent">Podstawa: </ThemedText>
          Acceptable Macronutrient Distribution Ranges (AMDR) wykorzystywane w amerykańskich
          Dietary Reference Intakes oraz Dietary Guidelines for Americans. Zakres oznacza procent
          całkowitej energii pochodzącej z danego makroskładnika.
        </ThemedText>
      </Karta>

      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          <ThemedText type="smallBold" themeColor="accent">Ważne: </ThemedText>
          MyPlate i AMDR pełnią różne funkcje. MyPlate pokazuje sposób komponowania posiłku,
          natomiast AMDR określa procentowy udział energii z białka, tłuszczu i węglowodanów.
        </ThemedText>
      </Karta>
    </Ekran>
  );
}

const styles = StyleSheet.create({
  naglowekGrupy: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  zakresWiersz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  kropka: {
    width: 10,
    height: 10,
    borderRadius: 5,
  },
  zakresEtykieta: {
    flex: 1,
  },
  kartaOpisu: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.three,
  },
  opisTresc: {
    flex: 1,
    gap: Spacing.half,
  },
  kartaTalerza: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  talerz: {
    width: 88,
    height: 88,
    borderRadius: 44,
    overflow: 'hidden',
  },
  cwiartka: {
    position: 'absolute',
    width: '50%',
    height: '50%',
  },
  cwiartkaLewaGora: { left: 0, top: 0 },
  cwiartkaPrawaGora: { right: 0, top: 0 },
  cwiartkaLewaDol: { left: 0, bottom: 0 },
  cwiartkaPrawaDol: { right: 0, bottom: 0 },
  talerzTresc: {
    flex: 1,
    gap: Spacing.half,
  },
});
