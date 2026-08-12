/**
 * Tymczasowa lista przepisów. Docelowo trafi do tabeli `przepisy` w Supabase,
 * a polubienia do osobnej tabeli `polubienia`.
 */

export type Przepis = {
  id: string;
  nazwa: string;
  opis: string;
  kcal: number;
  bialko: number;
  czasMinut: number;
  polubienia: number;
};

export const PRZEPISY: Przepis[] = [
  {
    id: 'p1',
    nazwa: 'Dorsz MSC z kaszą gryczaną',
    opis: 'Pieczony w piekarniku, warzywa na jednej blasze. Wychodzi na 3 dni.',
    kcal: 824,
    bialko: 55,
    czasMinut: 35,
    polubienia: 12,
  },
  {
    id: 'p2',
    nazwa: 'Kurczak w curry Panang',
    opis: 'Cook4Me, 12 minut pod ciśnieniem. Pasta Mae Ploy, mleko kokosowe.',
    kcal: 780,
    bialko: 48,
    czasMinut: 25,
    polubienia: 8,
  },
  {
    id: 'p3',
    nazwa: 'Owsianka z jogurtem greckim',
    opis: 'Nocna owsianka — wieczorem zalewasz, rano gotowe.',
    kcal: 656,
    bialko: 38,
    czasMinut: 5,
    polubienia: 21,
  },
  {
    id: 'p4',
    nazwa: 'Gulasz z indyka z ciecierzycą',
    opis: 'Batch cooking na 3 porcje. Dobrze znosi odgrzewanie.',
    kcal: 690,
    bialko: 52,
    czasMinut: 40,
    polubienia: 5,
  },
];
