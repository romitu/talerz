/**
 * Tymczasowe dane planu dnia.
 *
 * Na tym etapie posiłki są wpisane na sztywno w kodzie. W kolejnym kroku
 * zastąpimy ten plik zapytaniami do bazy danych Supabase — układ ekranów
 * pozostanie taki sam, zmieni się tylko źródło danych.
 */

export type Makro = {
  kcal: number;
  bialko: number;
  tluszcz: number;
  wegle: number;
};

export type Posilek = Makro & {
  id: string;
  pora: string;
  nazwa: string;
  skladniki: string[];
};

/** Dzienne cele Romana: 142 g białka, 82 g tłuszczu, 246 g węglowodanów. */
export const CEL_DNIA: Makro = {
  kcal: 2290,
  bialko: 142,
  tluszcz: 82,
  wegle: 246,
};

/** Minimalna ilość białka na jeden posiłek — poniżej tej wartości ekran pokazuje ostrzeżenie. */
export const MIN_BIALKO_NA_POSILEK = 35;

export const PLAN_DNIA: Posilek[] = [
  {
    id: 'sniadanie',
    pora: 'Śniadanie',
    nazwa: 'Owsianka z jogurtem greckim, borówkami i orzechami włoskimi',
    skladniki: ['80 g płatków owsianych', '200 g jogurtu greckiego', '100 g borówek', '20 g orzechów włoskich'],
    kcal: 656,
    bialko: 38,
    tluszcz: 24,
    wegle: 72,
  },
  {
    id: 'obiad',
    pora: 'Obiad',
    nazwa: 'Dorsz MSC pieczony z kaszą gryczaną i warzywami',
    skladniki: ['200 g dorsza MSC', '80 g kaszy gryczanej', '250 g warzyw', '15 ml oliwy'],
    kcal: 824,
    bialko: 55,
    tluszcz: 28,
    wegle: 88,
  },
  {
    id: 'kolacja',
    pora: 'Kolacja',
    nazwa: 'Kurczak z grilla, bulgur i sałatka z pomidorów',
    skladniki: ['180 g piersi z kurczaka', '70 g bulguru', '200 g pomidorów', '15 ml oliwy'],
    kcal: 810,
    bialko: 49,
    tluszcz: 30,
    wegle: 86,
  },
];

/** Sumuje makroskładniki wszystkich posiłków w planie. */
export function sumujMakro(posilki: Posilek[]): Makro {
  return posilki.reduce<Makro>(
    (suma, p) => ({
      kcal: suma.kcal + p.kcal,
      bialko: suma.bialko + p.bialko,
      tluszcz: suma.tluszcz + p.tluszcz,
      wegle: suma.wegle + p.wegle,
    }),
    { kcal: 0, bialko: 0, tluszcz: 0, wegle: 0 }
  );
}
