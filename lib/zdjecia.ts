/**
 * Zdjęcia przepisów — wybór pliku, zmniejszenie i wysyłka do Supabase Storage.
 *
 * Dlaczego bez dodatkowej biblioteki
 * ----------------------------------
 * Wybór pliku i zmniejszenie obrazu robimy tym, co przeglądarka ma sama:
 * `<input type="file">` i `<canvas>`. Bez `expo-image-picker`, bez
 * `expo-image-manipulator`.
 *
 * Powód jest praktyczny: każda biblioteka natywna musi mieć wersję dokładnie
 * pasującą do wersji Expo, inaczej aplikacja przestaje się uruchamiać
 * w Expo Go. Jedna zależność mniej to jedna rzecz mniej, która może paść
 * przy aktualizacji.
 *
 * Na telefonie (Expo Go) ten kod nie zadziała i tak jest napisany — funkcja
 * `wybierzZdjecie` zwraca wtedy `null`, a ekran pokazuje, że zdjęcia dodaje
 * się z przeglądarki. Gdy zdjęcia z aparatu staną się potrzebne, dokładamy
 * `expo-image-picker` i podmieniamy jedną funkcję.
 *
 * Dlaczego zmniejszamy przed wysłaniem
 * ------------------------------------
 * Telefon robi zdjęcie ważące 4 MB. W przepisie widać je w miniaturze
 * o szerokości kilkuset pikseli. Wysyłanie oryginału to marnowanie transferu
 * użytkownika i miejsca w zasobniku — a przy liczniku darmowego Supabase
 * to realny koszt. Zasobnik ma zresztą twardy limit 2 MB na plik.
 */

import { Platform } from 'react-native';

import type { ZrodloZdjecia } from './zakupy';
import { supabase } from './supabase';

export const ZASOBNIK = 'zdjecia-przepisow';

/** Najdłuższy bok po zmniejszeniu. Miniatura na liście ma 120 px, podgląd ok. 700. */
const MAKS_PIKSELI = 1024;

/** Jakość zapisu JPEG. 0,8 to granica, poniżej której widać artefakty na jedzeniu. */
const JAKOSC = 0.8;

export type WybraneZdjecie = {
  /** Gotowy plik do wysłania — już zmniejszony. */
  dane: Blob;
  /** Adres do podglądu przed wysłaniem. */
  podglad: string;
};

/** Czy w tym środowisku da się wybrać zdjęcie. */
export function mozliwyWyborZdjecia(): boolean {
  return Platform.OS === 'web' && typeof document !== 'undefined';
}

/**
 * Otwiera okno wyboru pliku i zwraca zmniejszony obraz.
 * `null` oznacza: użytkownik zrezygnował albo środowisko tego nie potrafi.
 */
export function wybierzZdjecie(kwadrat?: number): Promise<WybraneZdjecie | null> {
  if (!mozliwyWyborZdjecia()) return Promise.resolve(null);

  return new Promise((rozwiaz) => {
    const pole = document.createElement('input');
    pole.type = 'file';
    pole.accept = 'image/*';

    // Bez tego okno wyboru na części przeglądarek w ogóle się nie otwiera.
    pole.style.display = 'none';
    document.body.appendChild(pole);

    let rozstrzygniete = false;
    const zakoncz = (wynik: WybraneZdjecie | null) => {
      if (rozstrzygniete) return;
      rozstrzygniete = true;
      pole.remove();
      rozwiaz(wynik);
    };

    pole.onchange = async () => {
      const plik = pole.files?.[0];
      if (!plik) return zakoncz(null);
      try {
        zakoncz(await zmniejsz(plik, kwadrat));
      } catch {
        zakoncz(null);
      }
    };

    // Gdy użytkownik zamknie okno bez wyboru, `change` nie przychodzi wcale.
    // Bez tego obietnica wisiałaby w nieskończoność, a przycisk zostałby
    // zablokowany na „wczytywanie”.
    pole.oncancel = () => zakoncz(null);

    pole.click();
  });
}

/**
 * Zmniejsza obraz do MAKS_PIKSELI na dłuższym boku i zapisuje jako JPEG.
 *
 * Z `kwadrat` przycina środek do kwadratu o tym boku — tak jak kafle na
 * liście zakupów, które zawsze są kwadratowe.
 */
export async function zmniejsz(plik: Blob, kwadrat?: number): Promise<WybraneZdjecie> {
  const obraz = await wczytajObraz(plik);

  const plotno = document.createElement('canvas');
  const pedzel = plotno.getContext('2d');
  if (!pedzel) throw new Error('Przeglądarka nie udostępnia rysowania na płótnie.');

  if (kwadrat) {
    const bok = Math.min(obraz.width, obraz.height);
    plotno.width = plotno.height = Math.min(kwadrat, bok);
    // Białe tło pod przezroczystym PNG — JPEG nie ma przezroczystości i dałby czerń.
    pedzel.fillStyle = '#ffffff';
    pedzel.fillRect(0, 0, plotno.width, plotno.height);
    pedzel.drawImage(
      obraz,
      (obraz.width - bok) / 2,
      (obraz.height - bok) / 2,
      bok,
      bok,
      0,
      0,
      plotno.width,
      plotno.height
    );
  } else {
    const skala = Math.min(1, MAKS_PIKSELI / Math.max(obraz.width, obraz.height));
    plotno.width = Math.round(obraz.width * skala);
    plotno.height = Math.round(obraz.height * skala);
    pedzel.drawImage(obraz, 0, 0, plotno.width, plotno.height);
  }

  const dane = await new Promise<Blob | null>((r) => plotno.toBlob(r, 'image/jpeg', JAKOSC));
  if (!dane) throw new Error('Nie udało się przetworzyć obrazu.');

  return { dane, podglad: plotno.toDataURL('image/jpeg', JAKOSC) };
}

function wczytajObraz(plik: Blob): Promise<HTMLImageElement> {
  return new Promise((rozwiaz, odrzuc) => {
    const adres = URL.createObjectURL(plik);
    const obraz = new Image();
    obraz.onload = () => {
      URL.revokeObjectURL(adres);
      rozwiaz(obraz);
    };
    obraz.onerror = () => {
      URL.revokeObjectURL(adres);
      odrzuc(new Error('To nie jest obraz, który przeglądarka umie otworzyć.'));
    };
    obraz.src = adres;
  });
}

/**
 * Rdzeń nazwy pliku w zasobniku, wyprowadzony z nazwy przepisu. Bez polskich
 * znaków i spacji — Storage ich nie lubi. Ta sama zasada co w
 * narzedzia/wgraj-zdjecia.mjs, żeby zdjęcia przeniesione ze starego planera
 * dało się rozpoznać po nazwie.
 */
function rdzenNazwy(nazwaPrzepisu: string): string {
  return (
    nazwaPrzepisu
      .normalize('NFD')
      .replace(/[̀-ͯ]/g, '')
      .replace(/ł/g, 'l')
      .replace(/Ł/g, 'L')
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '') || 'przepis'
  );
}

/**
 * Nazwa pliku dla nowego wgrania — z unikalnym znacznikiem czasu.
 *
 * Bez znacznika kolejne wgranie zdjęcia dla tego samego przepisu trafiało
 * pod dokładnie ten sam adres, a `expo-image` i CDN Supabase pamiętają
 * odpowiedź pod danym adresem — więc po wymianie zdjęcia i tak widać było
 * stare, zbuforowane. Unikalna nazwa = nowy adres = brak szans na stary cache.
 */
export function nazwaPliku(nazwaPrzepisu: string): string {
  return `${rdzenNazwy(nazwaPrzepisu)}-${Date.now()}.jpg`;
}

/**
 * Publiczny adres zdjęcia składnika (lista zakupów) albo `null`.
 *
 * Osobny zasobnik niż przepisy — migracja 0045. Każda wymiana zdjęcia daje
 * nową ścieżkę, więc nie trafia na stary cache.
 */
export function adresZdjeciaSkladnika(sciezka: string | null | undefined): string | null {
  if (!sciezka) return null;
  const { data } = supabase.storage.from(ZASOBNIK_SKLADNIKOW).getPublicUrl(sciezka);
  return data.publicUrl ?? null;
}

/** Publiczny adres zdjęcia albo `null`, gdy przepis go nie ma. */
export function adresZdjecia(sciezka: string | null | undefined): string | null {
  if (!sciezka) return null;
  const { data } = supabase.storage.from(ZASOBNIK).getPublicUrl(sciezka);
  return data.publicUrl ?? null;
}

/**
 * Wysyła zdjęcie i zwraca ścieżkę do zapisania w `przepisy.zdjecie`.
 *
 * Stary plik pod poprzednią ścieżką trzeba skasować osobno przez
 * `usunZdjecie` — ta funkcja tylko wysyła nowy, pod nową, unikalną nazwą.
 */
export async function wyslijZdjecie(nazwaPrzepisu: string, dane: Blob): Promise<string> {
  const plik = nazwaPliku(nazwaPrzepisu);
  const { error } = await supabase.storage
    .from(ZASOBNIK)
    .upload(plik, dane, { contentType: 'image/jpeg', upsert: true });
  if (error) throw error;
  return plik;
}

/**
 * Kasuje plik z zasobnika.
 *
 * Błąd celowo pomijamy. Jeśli plik już nie istnieje albo sieć zawiodła,
 * ważniejsze jest, żeby przepis przestał go pokazywać — osierocony plik
 * w zasobniku nikomu nie szkodzi, a zablokowane „Usuń zdjęcie” tak.
 */
export async function usunZdjecie(sciezka: string): Promise<void> {
  try {
    await supabase.storage.from(ZASOBNIK).remove([sciezka]);
  } catch {
    // pomijamy świadomie — patrz komentarz wyżej
  }
}

// =============================================================================
//  ZDJĘCIA SKŁADNIKÓW (lista zakupów, migracja 0045)
// =============================================================================

export const ZASOBNIK_SKLADNIKOW = 'zdjecia-skladnikow';

/** Bok kwadratu zdjęcia składnika — ten sam, co w narzedzia/wgraj-zdjecia-skladnikow.mjs. */
export const BOK_ZDJECIA_SKLADNIKA = 480;

export type ZdjecieSkladnika = {
  id: string;
  nazwa: string;
  zdjecie: string | null;
  zdjecie_zrodlo: ZrodloZdjecia | null;
};

/** Wszystkie składniki ze swoimi zdjęciami — dla edytora zdjęć. */
export async function pobierzZdjeciaSkladnikow(): Promise<ZdjecieSkladnika[]> {
  const { data, error } = await supabase
    .from('skladniki')
    .select('id, nazwa, zdjecie, zdjecie_zrodlo')
    .order('nazwa');
  if (error) throw error;
  return (data ?? []) as ZdjecieSkladnika[];
}

/**
 * Wysyła plik i zwraca jego ścieżkę. Nazwa to id składnika + znacznik czasu:
 * zmiana nazwy składnika nie gubi zdjęcia, a każda wymiana daje nowy adres,
 * więc telefon nie pokaże starego obrazka z pamięci podręcznej.
 */
export async function wyslijZdjecieSkladnika(skladnikId: string, dane: Blob): Promise<string> {
  const plik = `${skladnikId}-${Date.now()}.jpg`;
  const { error } = await supabase.storage
    .from(ZASOBNIK_SKLADNIKOW)
    .upload(plik, dane, { contentType: 'image/jpeg', cacheControl: '31536000' });
  if (error) throw error;
  return plik;
}

/** Zapisuje w składniku ścieżkę zdjęcia i jego pochodzenie (oba null = brak zdjęcia). */
export async function zapiszZdjecieSkladnika(
  skladnikId: string,
  zdjecie: string | null,
  zrodlo: ZrodloZdjecia | null
): Promise<void> {
  const { error } = await supabase
    .from('skladniki')
    .update({ zdjecie, zdjecie_zrodlo: zdjecie ? zrodlo : null })
    .eq('id', skladnikId);
  if (error) throw error;
}

/** Kasuje plik z zasobnika. Błąd pomijamy z tego samego powodu co w `usunZdjecie`. */
export async function usunPlikZdjeciaSkladnika(sciezka: string): Promise<void> {
  try {
    await supabase.storage.from(ZASOBNIK_SKLADNIKOW).remove([sciezka]);
  } catch {
    // pomijamy świadomie — osierocony plik nikomu nie szkodzi
  }
}
