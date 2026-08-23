/**
 * Import i eksport przepisu w formacie „formularzowym” — jeden przepis na
 * arkusz, pola w tej samej kolejności co w ekranie Edycja przepisu, zamiast
 * płaskiej tabeli z wieloma kolumnami. Dokładnie taki układ, jaki Roman
 * ręcznie wypełnił w pliku Talerz_Import.xlsx. Eksport (`eksportujPrzepisFormularzowy`)
 * pisze zawsze DOKŁADNIE to, co import (`wczytajPlikFormularzowy`) potrafi
 * z powrotem wczytać — jeden przepis naraz, żeby dało się go wyeksportować,
 * poprawić ręcznie w Excelu i zaimportować z powrotem.
 *
 * Format jest ŚCIŚLE SEKWENCYJNY — etykiety w kolumnie A muszą wystąpić
 * dokładnie w tej kolejności, w jakiej pyta o nie formularz. To nie jest
 * płaski słownik klucz-wartość: sekcja SKŁADNIKI może mieć N wierszy, sekcja
 * POTRZEBNY SPRZĘT — N wierszy, a każdy ETAP — N kroków, więc parser czyta
 * arkusz jako automat stanowy, wiersz po wierszu, a nie po nazwach kolumn.
 *
 * Każdy arkusz w pliku to OSOBNY przepis (nazwa arkusza jest tylko etykietą
 * karty, treść identyfikuje przepis pole „Nazwa” w wierszu 1). Błąd w jednym
 * arkuszu odrzuca tylko ten przepis — reszta pliku wczytuje się normalnie,
 * tak samo jak w płaskim formacie (lib/import-eksport-przepisow.ts).
 *
 * Tabela SKŁADNIKI ma dwie kolumny nawiązujące do „Roli” i „Kwant.” z tabeli
 * wybranych składników w formularzu przepisu: obie nieobowiązkowe, puste pole
 * znaczy „weź wartość ze składnika”. „Waga jednej porcji” nie występuje wcale —
 * w formularzu to pole się wylicza, a nie wpisuje, więc liczymy je tak samo
 * tutaj: z sumy gramatur składników i „Liczby porcji bazowych”.
 */

import {
  bajtyDoBase64,
  KUCHNIA_WEDLUG_ETYKIETY,
  podzielListe,
  PORA_WEDLUG_ETYKIETY,
  PORCJOWANIE_WEDLUG_ETYKIETY,
  ROLA_SKLADNIKA_WEDLUG_ETYKIETY,
  tekstKomorki,
} from './import-eksport-wspolne';
import { OPIS_ROLI_SKLADNIKA, type RolaSkladnika, type Skladnik } from './skladniki';
import { OPIS_KUCHNI, OPIS_PORY, type Kuchnia, type PelnyPrzepis, type PoraPosilku } from './przepisy';
// Tylko typy — bez importu wartości, żeby nie zamknąć cyklu z import-eksport-przepisow.ts,
// który sam importuje wczytajPlikFormularzowy z tego pliku.
import type { BladImportu, EtapDoImportu, PrzepisDoImportu, SkladnikDoImportu } from './import-eksport-przepisow';
import type { Workbook, Worksheet } from 'exceljs';

type Wiersz = { numer: number; cele: string[] };

function wierszeArkusza(ws: Worksheet): Wiersz[] {
  const wynik: Wiersz[] = [];
  ws.eachRow({ includeEmpty: false }, (wiersz, numer) => {
    const cele: string[] = [];
    for (let c = 1; c <= ws.columnCount; c++) cele.push(tekstKomorki(wiersz.getCell(c).value).trim());
    wynik.push({ numer, cele });
  });
  return wynik;
}

/** Przerywa wczytywanie CAŁEGO arkusza — złapane raz, na samej górze. */
class BladArkusza extends Error {
  numerWiersza: number | null;
  constructor(numerWiersza: number | null, message: string) {
    super(message);
    this.numerWiersza = numerWiersza;
  }
}

/**
 * Kursor po niepustych wierszach arkusza.
 *
 * `oczekaj` pilnuje, że kolejny wiersz zaczyna się od dokładnie tej etykiety,
 * której w tym miejscu formularza się spodziewamy — inaczej mielibyśmy nie
 * strukturę, tylko zgadywankę. `pasuje` tylko SPRAWDZA, nie konsumuje —
 * używane do pętli o nieznanej z góry długości (składniki, kroki, etapy).
 */
class Kursor {
  private i = 0;
  private wiersze: Wiersz[];
  constructor(wiersze: Wiersz[]) {
    this.wiersze = wiersze;
  }

  private aktualny(): Wiersz | undefined {
    return this.wiersze[this.i];
  }

  pasuje(etykieta: string): boolean {
    return (this.aktualny()?.cele[0] ?? '') === etykieta;
  }

  pasujeWzorzec(wzorzec: RegExp): boolean {
    return wzorzec.test(this.aktualny()?.cele[0] ?? '');
  }

  /** Pobiera bieżący wiersz i przesuwa kursor — bez sprawdzania etykiety. */
  wez(): Wiersz {
    const w = this.aktualny();
    if (!w) throw new BladArkusza(null, 'Arkusz kończy się za wcześnie — brakuje dalszej treści formularza.');
    this.i++;
    return w;
  }

  /** Pobiera wiersz, sprawdzając, że kolumna A zawiera dokładnie `etykieta`. */
  oczekaj(etykieta: string): Wiersz {
    const w = this.wez();
    if (w.cele[0] !== etykieta) {
      throw new BladArkusza(
        w.numer,
        `oczekiwano etykiety „${etykieta}”, a jest „${w.cele[0] || '(pusto)'}”. Sprawdź, czy żaden wiersz formularza nie został przesunięty albo usunięty.`
      );
    }
    return w;
  }

  /** Wartość (druga kolumna) wiersza z oczekiwaną etykietą w pierwszej. */
  wartosc(etykieta: string): string {
    return this.oczekaj(etykieta).cele[1] ?? '';
  }

  /**
   * Jak `wartosc()`, ale wiersz wolno CAŁKOWICIE pominąć w arkuszu — nie tylko
   * zostawić z pustą wartością. Do pól oznaczonych w formularzu jako
   * „(nieobowiązkowe)”, które ludzie przy ręcznym wypełnianiu czasem po prostu
   * kasują, zamiast zostawiać puste.
   */
  wartoscOpcjonalna(etykieta: string): string {
    return this.pasuje(etykieta) ? (this.wez().cele[1] ?? '') : '';
  }
}

function liczbaZTekstu(tekst: string): number | null {
  const t = tekst.trim().replace(',', '.');
  if (t === '') return null;
  const n = Number(t);
  return Number.isFinite(n) ? n : null;
}

/** Wczytuje jeden arkusz w formacie formularzowym. Rzuca `BladArkusza` przy pierwszym niedopasowaniu. */
function wczytajPrzepisZKursora(k: Kursor, skladnikiWedlugNazwy: Map<string, Skladnik>): PrzepisDoImportu {
  const nazwa = k.wartosc('Nazwa').trim();
  if (nazwa.length < 3) {
    throw new BladArkusza(null, 'Pole „Nazwa” jest za krótkie (minimum 3 znaki).');
  }

  const opis = k.wartosc('Krótki opis').trim() || null;
  k.oczekaj('ZDJĘCIE'); // arkusz nie przenosi zdjęć — sam marker tylko przesuwa kursor

  const wierszMetryczki = k.oczekaj('METRYCZKA');
  const etykietaPorcjowania = (wierszMetryczki.cele[1] ?? '').trim().toLowerCase();
  const porcjowanie = PORCJOWANIE_WEDLUG_ETYKIETY.get(etykietaPorcjowania);
  if (!porcjowanie) {
    throw new BladArkusza(
      wierszMetryczki.numer,
      'obok „METRYCZKA” musi być „Na wagę” albo „Na sztuki” — to samo, co w formularzu przy „Jak dzielimy danie na porcje”.'
    );
  }

  // „Waga jednej porcji” nie jest tu wpisywana — w formularzu to pole wylicza
  // się samo (masa całej potrawy / liczba porcji bazowych) i nie da się go
  // ręcznie wypełnić, więc arkusz go w ogóle nie ma. Liczymy je niżej, dopiero
  // po wczytaniu składników (patrz koniec funkcji).
  let porcje = 1;
  if (porcjowanie === 'sztuki') {
    const w = k.oczekaj('Liczba porcji');
    const wartosc = liczbaZTekstu(w.cele[1] ?? '');
    if (wartosc === null || !Number.isInteger(wartosc) || wartosc < 1 || wartosc > 30) {
      throw new BladArkusza(w.numer, '„Liczba porcji” musi być liczbą całkowitą od 1 do 30.');
    }
    porcje = wartosc;
  }

  const wPorcjeBazowe = k.oczekaj('Liczba porcji bazowych');
  const liczbaPorcjiBazowych = liczbaZTekstu(wPorcjeBazowe.cele[1] ?? '');
  if (
    liczbaPorcjiBazowych === null ||
    !Number.isInteger(liczbaPorcjiBazowych) ||
    liczbaPorcjiBazowych < 1 ||
    liczbaPorcjiBazowych > 30
  ) {
    throw new BladArkusza(
      wPorcjeBazowe.numer,
      '„Liczba porcji bazowych” musi być liczbą całkowitą od 1 do 30.'
    );
  }

  const czasPrzygotowania = liczbaZTekstu(k.wartosc('Czas przygotowania'));
  const czasObrobki = liczbaZTekstu(k.wartosc('Czas obróbki'));

  const wierszKategorii = k.oczekaj('Kategoria');
  const pory: PoraPosilku[] = [];
  for (const e of podzielListe(wierszKategorii.cele[1] ?? '')) {
    const p = PORA_WEDLUG_ETYKIETY.get(e.toLowerCase());
    if (!p) throw new BladArkusza(wierszKategorii.numer, `nieznana kategoria „${e}”.`);
    pory.push(p);
  }

  const wierszKuchni = k.oczekaj('Kuchnia');
  const kuchnie: Kuchnia[] = [];
  for (const e of podzielListe(wierszKuchni.cele[1] ?? '')) {
    const kuch = KUCHNIA_WEDLUG_ETYKIETY.get(e.toLowerCase());
    if (!kuch) throw new BladArkusza(wierszKuchni.numer, `nieznana kuchnia „${e}”.`);
    kuchnie.push(kuch);
  }

  const wierszTrwalosci = k.oczekaj('Ile dni wytrzyma w lodówce');
  const tekstTrwalosci = (wierszTrwalosci.cele[1] ?? '').trim();
  const trwaloscDni = tekstTrwalosci === '' ? 0 : liczbaZTekstu(tekstTrwalosci);
  if (trwaloscDni === null || !Number.isInteger(trwaloscDni) || trwaloscDni < 0 || trwaloscDni > 3) {
    throw new BladArkusza(
      wierszTrwalosci.numer,
      '„Ile dni wytrzyma w lodówce” musi być liczbą całkowitą od 0 do 3 (albo puste, co znaczy 0).'
    );
  }

  // --- SKŁADNIKI (N wierszy) -------------------------------------------------
  k.oczekaj('Składnik'); // nagłówek tabeli składników
  const skladniki: SkladnikDoImportu[] = [];
  while (!k.pasuje('POTRZEBNY SPRZĘT')) {
    const w = k.wez();
    const nazwaSkladnika = (w.cele[1] ?? '').trim();
    if (!nazwaSkladnika) {
      throw new BladArkusza(w.numer, 'w tabeli składników brakuje nazwy składnika.');
    }
    const skladnik = skladnikiWedlugNazwy.get(kluczNazwyLokalny(nazwaSkladnika));
    if (!skladnik) {
      throw new BladArkusza(
        w.numer,
        `nieznany składnik „${nazwaSkladnika}”. Dodaj go najpierw w zakładce Składniki.`
      );
    }

    const ilosc = liczbaZTekstu(w.cele[2] ?? '');
    if (ilosc === null || ilosc <= 0) {
      throw new BladArkusza(w.numer, `„${nazwaSkladnika}”: ilość musi być liczbą większą od zera.`);
    }

    const jednostkaTekst = (w.cele[3] ?? '').trim().toLowerCase();
    if (jednostkaTekst !== 'g' && jednostkaTekst !== 'ml' && jednostkaTekst !== 'szt') {
      throw new BladArkusza(w.numer, `„${nazwaSkladnika}”: jednostka musi być „g”, „ml” albo „szt”.`);
    }
    if (jednostkaTekst === 'szt' && !skladnik.masa_sztuki_g) {
      throw new BladArkusza(
        w.numer,
        `„${skladnik.nazwa}” nie ma ustalonej masy sztuki — jednostka „szt” niedostępna.`
      );
    }
    const jednostka = jednostkaTekst as 'g' | 'ml' | 'szt';
    const gramy = jednostka === 'szt' ? ilosc * (skladnik.masa_sztuki_g ?? 0) : ilosc;

    // Kolumna 8 (H) to rola TEGO składnika W TYM przepisie, kolumna 9 (I) —
    // czy da się go podzielić. Obie nieobowiązkowe: puste pole znaczy „weź
    // wartość ze składnika” — dokładnie tak samo jak w formularzu przepisu,
    // gdzie dodanie składnika wypełnia je domyślnie jego własnymi wartościami.
    const etykietaRoli = (w.cele[7] ?? '').trim();
    let rola: RolaSkladnika | null = null;
    if (etykietaRoli) {
      const rolaWpisana = ROLA_SKLADNIKA_WEDLUG_ETYKIETY.get(etykietaRoli.toLowerCase());
      if (!rolaWpisana) {
        throw new BladArkusza(w.numer, `„${nazwaSkladnika}”: nieznana rola „${etykietaRoli}”.`);
      }
      rola = rolaWpisana;
    }

    const etykietaKwant = (w.cele[8] ?? '').trim().toLowerCase();
    let moznaDzielic: boolean | null = null;
    if (etykietaKwant === 'tak') moznaDzielic = true;
    else if (etykietaKwant === 'nie') moznaDzielic = false;
    else if (etykietaKwant) {
      throw new BladArkusza(w.numer, `„${nazwaSkladnika}”: „Kwant.” musi być „Tak” albo „Nie”.`);
    }

    skladniki.push({
      skladnik_id: skladnik.id,
      nazwa: skladnik.nazwa,
      ilosc,
      jednostka,
      gramy,
      // Kolumna 5 (E) jest zawsze pusta w tym formularzu — zarezerwowana,
      // nieużywana. „Stan” i „Zamiennik” są w kolumnach F i G.
      stan: (w.cele[5] ?? '').trim() || null,
      zamiennik: (w.cele[6] ?? '').trim() || null,
      opis_potoczny: null,
      rola,
      mozna_dzielic: moznaDzielic,
    });
  }
  if (skladniki.length === 0) {
    throw new BladArkusza(null, 'brak składników — bez nich nie da się policzyć makro.');
  }

  // „Waga jednej porcji” — patrz komentarz przy METRYCZCE. Ten sam rachunek
  // co w formularzu: masa całej potrawy podzielona przez liczbę porcji bazowych.
  const porcjaG =
    porcjowanie === 'waga'
      ? Math.round(skladniki.reduce((suma, s) => suma + s.gramy, 0) / liczbaPorcjiBazowych)
      : null;

  // --- POTRZEBNY SPRZĘT (N wierszy) ------------------------------------------
  k.oczekaj('POTRZEBNY SPRZĘT');
  const sprzet: string[] = [];
  while (!k.pasuje('ETAPY PRZYGOTOWANIA')) {
    const w = k.wez();
    const nazwaSprzetu = (w.cele[1] ?? '').trim();
    if (nazwaSprzetu) sprzet.push(nazwaSprzetu);
  }

  // --- ETAPY PRZYGOTOWANIA (N etapów, każdy z N krokami) ----------------------
  k.oczekaj('ETAPY PRZYGOTOWANIA');
  const etapy: EtapDoImportu[] = [];
  while (k.pasujeWzorzec(/^ETAP\s+\d+$/i)) {
    k.wez(); // sam nagłówek „ETAP N” niesie tylko numer porządkowy — kolejność bierzemy z pozycji w pliku

    const nazwaEtapu = k.wartosc('Nazwa etapu').trim();
    if (nazwaEtapu.length < 2) {
      throw new BladArkusza(null, `etap: nazwa etapu za krótka („${nazwaEtapu}”).`);
    }
    const minuty = liczbaZTekstu(k.wartosc('Czas etapu (min)'));

    const kroki: EtapDoImportu['kroki'] = [];
    while (k.pasujeWzorzec(/^Krok\s+\d+$/i)) {
      const wKrok = k.wez();
      const tresc = (wKrok.cele[1] ?? '').trim();
      if (!tresc) throw new BladArkusza(wKrok.numer, 'treść kroku jest pusta.');

      const sygnal = k.wartoscOpcjonalna('Po czym poznać, że gotowe (nieobowiązkowe)').trim() || null;
      kroki.push({ tresc, sygnal, uwaga: false });
    }

    etapy.push({ nazwa: nazwaEtapu, minuty, kroki });
  }

  // --- PRZECHOWYWANIE I WSKAZÓWKI ---------------------------------------------
  k.oczekaj('PRZECHOWYWANIE I WSKAZÓWKI');
  const przechowywanie = k.wartosc('Jak przechowywać').trim() || null;

  const mrozicTekst = k.wartosc('Czy nadaje się do mrożenia').trim().toLowerCase();
  const moznaMrozic = mrozicTekst === 'tak' ? true : mrozicTekst === 'nie' ? false : null;

  const ratunek = k.wartosc('Jak uratować danie w razie wpadki').trim() || null;

  return {
    nazwa,
    opis,
    pory,
    kuchnie,
    trwalosc_dni: trwaloscDni,
    porcjowanie,
    porcje,
    porcja_g: porcjaG,
    liczba_porcji_bazowych: liczbaPorcjiBazowych,
    czas_przygotowania_min: czasPrzygotowania,
    czas_obrobki_min: czasObrobki,
    sprzet,
    przechowywanie,
    mozna_mrozic: moznaMrozic,
    ratunek,
    skladniki,
    etapy,
  };
}

/** Ten sam klucz dopasowania nazw co w reszcie importu — skopiowany, żeby nie zależeć od kolejności eksportów modułu. */
function kluczNazwyLokalny(nazwa: string): string {
  return nazwa.trim().replace(/\s+/g, ' ').toLowerCase();
}

/** Nazwa arkusza nie może zawierać `: \ / ? * [ ]` i ma najwyżej 31 znaków. */
function nazwaArkusza(nazwaPrzepisu: string): string {
  const oczyszczona = nazwaPrzepisu.replace(/[:\\/?*[\]]/g, ' ').replace(/\s+/g, ' ').trim();
  return (oczyszczona || 'Przepis').slice(0, 31);
}

function etykietaTakNie(wartosc: boolean | null): string {
  return wartosc === null ? '' : wartosc ? 'Tak' : 'Nie';
}

/**
 * Eksportuje JEDEN przepis w tym samym formacie formularzowym, jaki rozumie
 * `wczytajPlikFormularzowy` — jeden arkusz, pola sekwencyjnie w kolejności
 * ekranu Edycja przepisu. Dzięki temu plik da się od razu poprawić ręcznie
 * w Excelu i zaimportować z powrotem.
 *
 * W przeciwieństwie do płaskiego eksportu (`eksportujPrzepisy`) rola
 * i kwantyzacja per składnik trafiają do pliku, a nie tylko wartości
 * odżywcze — bez tego reimport zresetowałby je z powrotem na wartości
 * ze składnika. `dostepneSkladniki` służy do wypełnienia Roli/Kwant.,
 * gdy przepis nie ma własnego nadpisania (migracja 0035) — wtedy w pliku
 * ląduje bieżąca wartość ze składnika, tak samo jak przy dodawaniu go
 * w formularzu.
 */
export async function eksportujPrzepisFormularzowy(
  p: PelnyPrzepis,
  dostepneSkladniki: Skladnik[]
): Promise<string> {
  // Import dynamiczny — patrz komentarz w eksportujPrzepisy (lib/import-eksport-przepisow.ts).
  const { Workbook } = await import('exceljs');
  const wb = new Workbook();
  wb.creator = 'Talerz';
  wb.created = new Date();

  const skladnikiWedlugId = new Map(dostepneSkladniki.map((s) => [s.id, s]));
  const arkusz = wb.addWorksheet(nazwaArkusza(p.nazwa));
  arkusz.getColumn(1).width = 40;
  arkusz.getColumn(2).width = 40;

  const wiersz = (...cele: (string | number)[]) => arkusz.addRow(cele);

  wiersz('Nazwa', p.nazwa);
  wiersz('Krótki opis', p.opis ?? '');
  wiersz('ZDJĘCIE'); // arkusz nie przenosi zdjęć — sam marker, bez wartości

  wiersz('METRYCZKA', p.porcjowanie === 'waga' ? 'Na wagę' : 'Na sztuki');
  if (p.porcjowanie === 'sztuki') wiersz('Liczba porcji', p.porcje);
  // „Waga jednej porcji” nie jest tu zapisywana — patrz komentarz w parserze:
  // to pole się wylicza, a nie wpisuje, więc go w formacie w ogóle nie ma.
  wiersz('Liczba porcji bazowych', p.liczba_porcji_bazowych);
  wiersz('Czas przygotowania', p.czas_przygotowania_min ?? '');
  wiersz('Czas obróbki', p.czas_obrobki_min ?? '');
  wiersz('Kategoria', p.pory.map((x) => OPIS_PORY[x]).join('; '));
  wiersz('Kuchnia', p.kuchnie.map((x) => OPIS_KUCHNI[x]).join('; '));
  wiersz('Ile dni wytrzyma w lodówce', p.trwalosc_dni);

  arkusz.addRow(['Składnik', 'Składnik', 'ilość', 'Jedn', '', 'Stan', 'Zamiennik', 'Rola', 'Kwant.']);
  p.skladniki.forEach((s, i) => {
    const bazowy = skladnikiWedlugId.get(s.skladnik_id);
    const rola = s.rola ?? bazowy?.rola ?? 'baza';
    const moznaDzielic = s.mozna_dzielic ?? bazowy?.mozna_dzielic ?? null;
    arkusz.addRow([
      i + 1,
      s.nazwa,
      s.ilosc,
      s.jednostka,
      '',
      s.stan ?? '',
      s.zamiennik ?? '',
      OPIS_ROLI_SKLADNIKA[rola],
      etykietaTakNie(moznaDzielic),
    ]);
  });

  wiersz('POTRZEBNY SPRZĘT');
  p.sprzet.forEach((nazwaSprzetu, i) => arkusz.addRow([i + 1, nazwaSprzetu]));

  wiersz('ETAPY PRZYGOTOWANIA');
  p.etapy.forEach((etap, i) => {
    wiersz(`ETAP ${i + 1}`);
    wiersz('Nazwa etapu', etap.nazwa);
    wiersz('Czas etapu (min)', etap.minuty ?? '');
    etap.kroki.forEach((krok, j) => {
      wiersz(`Krok ${j + 1}`, krok.tresc);
      wiersz('Po czym poznać, że gotowe (nieobowiązkowe)', krok.sygnal ?? '');
    });
  });

  wiersz('PRZECHOWYWANIE I WSKAZÓWKI');
  wiersz('Jak przechowywać', p.przechowywanie ?? '');
  wiersz('Czy nadaje się do mrożenia', etykietaTakNie(p.mozna_mrozic));
  wiersz('Jak uratować danie w razie wpadki', p.ratunek ?? '');

  const bufor = await wb.xlsx.writeBuffer();
  return bajtyDoBase64(new Uint8Array(bufor as ArrayBuffer));
}

/**
 * Wczytuje wszystkie arkusze pliku jako osobne przepisy w formacie
 * formularzowym. Arkusz, którego pierwszy niepusty wiersz nie zaczyna się
 * od „Nazwa”, jest cichy pomijany — to pozwala trzymać w tym samym pliku
 * arkusz „Instrukcja” albo inne notatki, bez traktowania ich jak przepis.
 */
export function wczytajPlikFormularzowy(
  wb: Workbook,
  dostepneSkladniki: Skladnik[]
): { przepisy: PrzepisDoImportu[]; bledy: BladImportu[] } {
  const skladnikiWedlugNazwy = new Map(dostepneSkladniki.map((s) => [kluczNazwyLokalny(s.nazwa), s]));
  const przepisy: PrzepisDoImportu[] = [];
  const bledy: BladImportu[] = [];
  const nazwyWPliku = new Set<string>();

  for (const ws of wb.worksheets) {
    const wiersze = wierszeArkusza(ws);
    if (wiersze.length === 0 || wiersze[0].cele[0] !== 'Nazwa') continue;

    try {
      const przepis = wczytajPrzepisZKursora(new Kursor(wiersze), skladnikiWedlugNazwy);
      const klucz = kluczNazwyLokalny(przepis.nazwa);
      if (nazwyWPliku.has(klucz)) {
        bledy.push({
          przepis: przepis.nazwa,
          tresc: `Arkusz „${ws.name}”: nazwa „${przepis.nazwa}” powtarza się w pliku — ta pozycja pominięta.`,
        });
        continue;
      }
      nazwyWPliku.add(klucz);
      przepisy.push(przepis);
    } catch (e) {
      if (e instanceof BladArkusza) {
        bledy.push({
          przepis: null,
          tresc: `Arkusz „${ws.name}”${e.numerWiersza !== null ? `, wiersz ${e.numerWiersza}` : ''}: ${e.message}`,
        });
      } else {
        throw e;
      }
    }
  }

  return { przepisy, bledy };
}
