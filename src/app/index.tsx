import { StyleSheet, View } from 'react-native';

import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { Makro } from '@/components/makro';
import { ThemedText } from '@/components/themed-text';
import { Spacing } from '@/constants/theme';
import { CEL_DNIA, MIN_BIALKO_NA_POSILEK, PLAN_DNIA, sumujMakro } from '@/data/plan';

/** Formatuje dzisiejszą datę po polsku, np. „środa, 12 sierpnia”. */
function dzisiaj() {
  return new Date().toLocaleDateString('pl-PL', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
  });
}

export default function EkranPlanu() {
  const suma = sumujMakro(PLAN_DNIA);

  return (
    <Ekran tytul="Plan dnia" podtytul={dzisiaj()}>
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          SUMA DNIA / CEL
        </ThemedText>
        <View style={styles.wierszMakro}>
          <Makro etykieta="kalorie" wartosc={suma.kcal} jednostka="" cel={CEL_DNIA.kcal} />
          <Makro etykieta="białko" wartosc={suma.bialko} jednostka=" g" cel={CEL_DNIA.bialko} />
          <Makro etykieta="tłuszcz" wartosc={suma.tluszcz} jednostka=" g" cel={CEL_DNIA.tluszcz} />
          <Makro etykieta="węglow." wartosc={suma.wegle} jednostka=" g" cel={CEL_DNIA.wegle} />
        </View>
      </Karta>

      {PLAN_DNIA.map((posilek) => {
        const zaMaloBialka = posilek.bialko < MIN_BIALKO_NA_POSILEK;

        return (
          <Karta key={posilek.id}>
            <ThemedText type="smallBold" themeColor="accent">
              {posilek.pora.toUpperCase()}
            </ThemedText>
            <ThemedText type="default">{posilek.nazwa}</ThemedText>

            <View style={styles.wierszMakro}>
              <Makro etykieta="kcal" wartosc={posilek.kcal} jednostka="" />
              <Makro etykieta="białko" wartosc={posilek.bialko} jednostka=" g" />
              <Makro etykieta="tłuszcz" wartosc={posilek.tluszcz} jednostka=" g" />
              <Makro etykieta="węglow." wartosc={posilek.wegle} jednostka=" g" />
            </View>

            <View style={styles.skladniki}>
              {posilek.skladniki.map((skladnik) => (
                <ThemedText key={skladnik} type="small" themeColor="textSecondary">
                  • {skladnik}
                </ThemedText>
              ))}
            </View>

            {zaMaloBialka ? (
              <ThemedText type="small" themeColor="accent">
                Poniżej {MIN_BIALKO_NA_POSILEK} g białka — warto dołożyć porcję mięsa lub ryby.
              </ThemedText>
            ) : null}
          </Karta>
        );
      })}

      <ThemedText type="small" themeColor="textSecondary" style={styles.stopka}>
        Posiłki są na razie wpisane na stałe w pliku src/data/plan.ts. W następnym kroku
        podłączymy bazę danych, żeby dało się je dodawać i zmieniać z poziomu aplikacji.
      </ThemedText>
    </Ekran>
  );
}

const styles = StyleSheet.create({
  wierszMakro: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
    paddingTop: Spacing.half,
  },
  skladniki: {
    paddingTop: Spacing.half,
    gap: Spacing.half,
  },
  stopka: {
    paddingTop: Spacing.two,
  },
});
