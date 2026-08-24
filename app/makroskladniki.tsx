import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';
import { KOLOR_MAKRO, Spacing } from '@/constants/theme';

/**
 * Makroskładniki — podstawa wg aktualnych zaleceń USA.
 *
 * Układ przeniesiony z makiety `Makroskładniki.html` od Romana: krótkie
 * wprowadzenie, trzy makroskładniki, wyróżniony zakres białka z Dietary
 * Guidelines, AMDR w trzech grupach wiekowych (zamiast poprzednich
 * jedenastu grup wiek/płeć — AMDR w tych przedziałach i tak się nie różni
 * między płciami) i lista praktycznych wskazówek zamiast grafiki talerza.
 */

type Zakres = readonly [number, number];

type GrupaWiekowa = {
  wiek: string;
  bialko: Zakres;
  tluszcz: Zakres;
  wegle: Zakres;
};

const GRUPY: GrupaWiekowa[] = [
  { wiek: '1–3 lata', bialko: [5, 20], tluszcz: [30, 40], wegle: [45, 65] },
  { wiek: '4–18 lat', bialko: [10, 30], tluszcz: [25, 35], wegle: [45, 65] },
  { wiek: 'Dorośli — 19 lat i więcej', bialko: [10, 35], tluszcz: [20, 35], wegle: [45, 65] },
];

const WSKAZOWKI = [
  'wartościowe źródła białka w każdym posiłku,',
  'różnorodne warzywa i owoce,',
  'produkty pełnoziarniste bogate w błonnik,',
  'tłuszcze pochodzące głównie z pełnowartościowych produktów,',
  'ograniczanie żywności wysoko przetworzonej i rafinowanych węglowodanów.',
];

function TypMakro({
  etykieta,
  kolor,
  opis,
}: {
  etykieta: string;
  kolor: string;
  opis: string;
}) {
  return (
    <Karta>
      <View style={styles.naglowekTypu}>
        <View style={[styles.kropka, { backgroundColor: kolor }]} />
        <ThemedText type="smallBold" style={{ color: kolor }}>
          {etykieta}
        </ThemedText>
      </View>
      <ThemedText type="small" themeColor="textSecondary">
        {opis}
      </ThemedText>
    </Karta>
  );
}

function ChipAmdr({ etykieta, kolor, zakres }: { etykieta: string; kolor: string; zakres: Zakres }) {
  return (
    <View style={[styles.chip, { backgroundColor: `${kolor}1F` }]}>
      <ThemedText type="small" style={{ color: kolor }}>
        {etykieta}
      </ThemedText>
      <ThemedText type="smallBold" style={[styles.chipWartosc, { color: kolor }]}>
        {zakres[0]}–{zakres[1]}%
      </ThemedText>
    </View>
  );
}

function KartaGrupy({ grupa }: { grupa: GrupaWiekowa }) {
  return (
    <Karta>
      <ThemedText type="smallBold">{grupa.wiek}</ThemedText>
      <View style={styles.chipy}>
        <ChipAmdr etykieta="Białko" kolor={KOLOR_MAKRO.bialko} zakres={grupa.bialko} />
        <ChipAmdr etykieta="Tłuszcz" kolor={KOLOR_MAKRO.tluszcz} zakres={grupa.tluszcz} />
        <ChipAmdr etykieta="Węglowodany" kolor={KOLOR_MAKRO.wegle} zakres={grupa.wegle} />
      </View>
    </Karta>
  );
}

export default function EkranMakroskladnikow() {
  return (
    <Ekran tytul="Makroskładniki" podtytul="Zakresy AMDR oraz aktualne zalecenia żywieniowe USA">
      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          <ThemedText type="smallBold" themeColor="accent">
            AMDR — Acceptable Macronutrient Distribution Ranges{' '}
          </ThemedText>
          określa, jaka część całkowitej energii może pochodzić z białka, tłuszczu
          i węglowodanów. AMDR jest zakresem procentowym — nie jest indywidualnym celem
          spożycia w gramach.
        </ThemedText>
      </Karta>

      <TypMakro
        etykieta="Białko"
        kolor={KOLOR_MAKRO.bialko}
        opis="Dostarcza aminokwasów potrzebnych m.in. do budowy i utrzymania tkanek, w tym mięśni."
      />
      <TypMakro
        etykieta="Tłuszcz"
        kolor={KOLOR_MAKRO.tluszcz}
        opis="Jest potrzebny m.in. do budowy błon komórkowych i wchłaniania witamin A, D, E i K."
      />
      <TypMakro
        etykieta="Węglowodany"
        kolor={KOLOR_MAKRO.wegle}
        opis="Są ważnym źródłem energii. Warto wybierać przede wszystkim produkty mało przetworzone i bogate w błonnik."
      />

      <Karta style={{ ...styles.kartaBialka, backgroundColor: `${KOLOR_MAKRO.bialko}14` }}>
        <View style={styles.wartoscBialka}>
          <ThemedText type="title" style={[styles.liczbaBialka, { color: KOLOR_MAKRO.bialko }]}>
            1,2–1,6
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            g/kg masy ciała / dobę
          </ThemedText>
        </View>
        <View style={styles.opisBialka}>
          <ThemedText type="smallBold" style={{ color: KOLOR_MAKRO.bialko }}>
            Białko w Dietary Guidelines for Americans 2025–2030
          </ThemedText>
          <ThemedText type="small" themeColor="textSecondary">
            Aktualne zalecenia USA wskazują na priorytetowe uwzględnianie wartościowych źródeł
            białka w posiłkach. Podany zakres należy dostosować do indywidualnego zapotrzebowania
            energetycznego.
          </ThemedText>
        </View>
      </Karta>

      <ThemedText type="smallBold" themeColor="textSecondary">
        ZAKRESY AMDR WG WIEKU
      </ThemedText>

      {GRUPY.map((g) => (
        <KartaGrupy key={g.wiek} grupa={g} />
      ))}

      <Karta style={{ ...styles.kartaStarsi, borderLeftColor: KOLOR_MAKRO.bialko }}>
        <ThemedText type="smallBold" style={{ color: KOLOR_MAKRO.bialko }}>
          Starsze osoby dorosłe
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Zakres AMDR pozostaje taki sam jak u pozostałych dorosłych. Z wiekiem szczególnego
          znaczenia nabiera odpowiednia ilość białka i wybór wartościowych jego źródeł, ponieważ
          zapotrzebowanie energetyczne może się zmniejszać, podczas gdy potrzeba dostarczenia
          białka pozostaje wysoka.
        </ThemedText>
      </Karta>

      <ThemedText type="smallBold" themeColor="textSecondary">
        JAK PRZEŁOŻYĆ TO NA CODZIENNE JEDZENIE?
      </ThemedText>

      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          Aktualne Dietary Guidelines for Americans 2025–2030 kładą nacisk przede wszystkim na:
        </ThemedText>
        <View style={styles.lista}>
          {WSKAZOWKI.map((w) => (
            <View key={w} style={styles.pozycjaListy}>
              <ThemedText type="small" style={{ color: KOLOR_MAKRO.bialko }}>
                •
              </ThemedText>
              <ThemedText type="small" style={styles.tekstListy}>
                {w}
              </ThemedText>
            </View>
          ))}
        </View>
      </Karta>

      <Karta>
        <ThemedText type="small" themeColor="textSecondary">
          <ThemedText type="smallBold" themeColor="accent">
            Ważne:{' '}
          </ThemedText>
          AMDR i cel białka w g/kg opisują dwie różne rzeczy. AMDR określa procent energii
          z makroskładników, natomiast wartość g/kg służy do określenia ilości białka względem
          masy ciała.
        </ThemedText>
      </Karta>

      <ThemedText type="small" themeColor="textSecondary">
        Podstawa: Dietary Reference Intakes — Acceptable Macronutrient Distribution Ranges (AMDR);
        Dietary Guidelines for Americans 2025–2030, USDA/HHS, 2026.
      </ThemedText>
    </Ekran>
  );
}

const styles = StyleSheet.create({
  naglowekTypu: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
  },
  kropka: {
    width: 10,
    height: 10,
    borderRadius: 5,
  },
  kartaBialka: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  wartoscBialka: {
    alignItems: 'center',
    gap: 2,
  },
  liczbaBialka: {
    fontSize: 25,
    lineHeight: 28,
  },
  opisBialka: {
    flex: 1,
    gap: Spacing.half,
  },
  chipy: {
    flexDirection: 'row',
    gap: Spacing.two,
  },
  chip: {
    flex: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: 2,
  },
  chipWartosc: {
    fontSize: 16,
  },
  kartaStarsi: {
    borderLeftWidth: 4,
  },
  lista: {
    gap: Spacing.one,
  },
  pozycjaListy: {
    flexDirection: 'row',
    gap: Spacing.two,
  },
  tekstListy: {
    flex: 1,
  },
});
