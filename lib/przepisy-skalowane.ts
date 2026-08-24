/**
 * Zapis wyniku skalowania kalorycznego przepisu (migracja 0036).
 *
 * Sam rachunek — dobór współczynnika k i finalne ilości składników — liczy
 * `lib/skalowanie-kalorii.ts`, czysta funkcja bez dostępu do bazy. Ten plik
 * tylko bierze jej wynik i zapisuje go jako NOWY, osobny wariant, żeby
 * przepis źródłowy w katalogu został nietknięty — dokładnie tak, jak `partie`
 * jest osobnym bytem od `przepisy`.
 */

import { przeskalujPrzepis, type SkladnikPrzepisu } from './skalowanie-kalorii';
import type { PelnyPrzepis } from './przepisy';
import type { Skladnik } from './skladniki';
import { supabase } from './supabase';

export type WynikZapisuSkalowania = {
  id: string;
  /** Wartości CAŁEGO wariantu — reprezentuje jeden posiłek, bez dzielenia przez porcje. */
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  k: number;
  /** Czy cel był poza zasięgiem [K_MIN, K_MAX] — wariant został przy granicy. */
  kOgraniczone: boolean;
};

/**
 * Skaluje `przepis` pod `celKcal` i zapisuje wynik jako nowy wiersz
 * w `przepisy_skalowane` (+ zrzut ilości każdego składnika).
 *
 * Wymaga `przepis.skalowalny === true` — sprawdzane u WOŁAJĄCEGO (automat
 * decyduje, kogo o to pytać), tutaj nie powtarzamy tej kontroli, żeby funkcja
 * dała się użyć też z ekranu, gdzie użytkownik świadomie wybiera przepis
 * niezależnie od checkboxa.
 */
export async function utworzPrzeskalowanyPrzepis(opcje: {
  kontoId: string;
  przepis: PelnyPrzepis;
  /** Katalog składników — do wartości odżywczych i wartości bazowych rola/mozna_dzielic. */
  dostepneSkladniki: Skladnik[];
  celKcal: number;
}): Promise<WynikZapisuSkalowania> {
  const { kontoId, przepis, dostepneSkladniki, celKcal } = opcje;

  const skladnikiWedlugId = new Map(dostepneSkladniki.map((s) => [s.id, s]));

  const wejscie: SkladnikPrzepisu[] = przepis.skladniki.map((s) => {
    const bazowy = skladnikiWedlugId.get(s.skladnik_id);
    if (!bazowy) {
      throw new Error(
        `Składnik „${s.nazwa}” nie występuje już w katalogu składników — nie da się przeliczyć skalowania.`
      );
    }
    return {
      id: s.skladnik_id,
      rola: s.rola ?? bazowy.rola,
      moznaDzielic: s.mozna_dzielic ?? bazowy.mozna_dzielic,
      ilosc: s.ilosc,
      gramyNaJednostke: s.ilosc > 0 ? s.gramy / s.ilosc : 0,
      kcal_100g: bazowy.kcal_100g,
      bialko_100g: bazowy.bialko_100g,
      tluszcz_100g: bazowy.tluszcz_100g,
      wegle_100g: bazowy.wegle_100g,
    };
  });

  const wynik = przeskalujPrzepis(wejscie, celKcal);

  const { data: nowy, error: bladWstawienia } = await supabase
    .from('przepisy_skalowane')
    .insert({
      konto_id: kontoId,
      przepis_zrodlowy_id: przepis.id,
      wspolczynnik_k: wynik.k,
      cel_kcal: Math.max(1, Math.round(celKcal)),
    })
    .select('id')
    .single();
  if (bladWstawienia) throw bladWstawienia;

  // Kolejność `wynik.pozycje` jest tą samą kolejnością co `przepis.skladniki`
  // (przeskalujPrzepis mapuje wejście 1:1) — stąd zip po indeksie, bez szukania.
  const { error: bladSkladnikow } = await supabase.from('przepisy_skalowane_skladniki').insert(
    wynik.pozycje.map((p, i) => ({
      przepis_skalowany_id: nowy.id,
      skladnik_id: p.id,
      ilosc: p.iloscPoSkalowaniu,
      jednostka: przepis.skladniki[i].jednostka,
      gramy: p.gramyPoSkalowaniu,
    }))
  );
  if (bladSkladnikow) throw bladSkladnikow;

  return {
    id: nowy.id,
    kcal: Math.round(wynik.kcalRazem),
    bialko_g: Math.round(wynik.bialkoRazem * 10) / 10,
    tluszcz_g: Math.round(wynik.tluszczRazem * 10) / 10,
    wegle_g: Math.round(wynik.wegleRazem * 10) / 10,
    k: wynik.k,
    kOgraniczone: wynik.kOgraniczone,
  };
}

export type SkladnikSkalowany = {
  skladnik_id: string;
  ilosc: number;
  jednostka: 'g' | 'ml' | 'szt';
  gramy: number;
};

export type MakroSkalowanego = {
  kcal: number;
  bialko_g: number;
  tluszcz_g: number;
  wegle_g: number;
  blonnik_g: number;
  gramy_porcji: number;
};

export type PrzeskalowanyPrzepis = {
  id: string;
  przepis_zrodlowy_id: string;
  wspolczynnik_k: number;
  cel_kcal: number;
  skladniki: SkladnikSkalowany[];
  /** `null`, gdyby wariant miał zero składników — nie powinno się zdarzyć. */
  makro: MakroSkalowanego | null;
};

/**
 * Czyta zapisany wcześniej wariant skalowany — do ekranu realizacji i listy
 * zakupów, żeby pokazywały to, co FAKTYCZNIE wyszło z przeliczenia, a nie
 * bazowy przepis źródłowy.
 */
export async function pobierzPrzeskalowanyPrzepis(id: string): Promise<PrzeskalowanyPrzepis> {
  const [wynikGlowny, wynikSkladnikow, wynikMakro] = await Promise.all([
    supabase
      .from('przepisy_skalowane')
      .select('id, przepis_zrodlowy_id, wspolczynnik_k, cel_kcal')
      .eq('id', id)
      .single(),
    supabase
      .from('przepisy_skalowane_skladniki')
      .select('skladnik_id, ilosc, jednostka, gramy')
      .eq('przepis_skalowany_id', id),
    supabase
      .from('przepis_skalowany_makro')
      .select('kcal, bialko_g, tluszcz_g, wegle_g, blonnik_g, gramy_porcji')
      .eq('przepis_skalowany_id', id)
      .maybeSingle(),
  ]);

  if (wynikGlowny.error) throw wynikGlowny.error;
  if (wynikSkladnikow.error) throw wynikSkladnikow.error;
  if (wynikMakro.error) throw wynikMakro.error;

  return {
    id: wynikGlowny.data.id,
    przepis_zrodlowy_id: wynikGlowny.data.przepis_zrodlowy_id,
    wspolczynnik_k: Number(wynikGlowny.data.wspolczynnik_k),
    cel_kcal: wynikGlowny.data.cel_kcal,
    skladniki: (wynikSkladnikow.data ?? []).map((s) => ({
      skladnik_id: s.skladnik_id as string,
      ilosc: Number(s.ilosc),
      jednostka: s.jednostka as 'g' | 'ml' | 'szt',
      gramy: Number(s.gramy),
    })),
    makro: wynikMakro.data
      ? {
          kcal: Number(wynikMakro.data.kcal),
          bialko_g: Number(wynikMakro.data.bialko_g),
          tluszcz_g: Number(wynikMakro.data.tluszcz_g),
          wegle_g: Number(wynikMakro.data.wegle_g),
          blonnik_g: Number(wynikMakro.data.blonnik_g),
          gramy_porcji: Number(wynikMakro.data.gramy_porcji),
        }
      : null,
  };
}
