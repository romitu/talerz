import { Ionicons } from '@expo/vector-icons';
import { useFocusEffect, useLocalSearchParams } from 'expo-router';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { Pressable, StyleSheet, TextInput, View } from 'react-native';

import { komunikatBledu } from '@/lib/blad';
import { wroc } from '@/lib/nawigacja';
import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { KomorkaEdytowalna } from '@/components/komorka-edytowalna';
import { KomorkaWyboru } from '@/components/komorka-wyboru';
import { WierszMakro } from '@/components/wiersz-makro';
import { Pole } from '@/components/pole';
import { Przycisk } from '@/components/przycisk';
import { ThemedText } from '@/components/themed-text';
import { FormularzSkladnika } from '@/components/formularz-skladnika';
import { TabelaWyboru } from '@/components/tabela-wyboru';
import { Wybor } from '@/components/wybor';
import { WyborWielo } from '@/components/wybor-wielo';
import { ZdjeciePrzepisu } from '@/components/zdjecie-przepisu';
import { Spacing } from '@/constants/theme';
import { useTheme } from '@/hooks/use-theme';
import { ROLA_SKLADNIKA_WEDLUG_ETYKIETY } from '@/lib/import-eksport-wspolne';
import {
  KATEGORIE,
  OPIS_KUCHNI,
  OPIS_PORY,
  opisTrwalosci,
  pobierzPelnyPrzepis,
  wyczyscTrescPrzepisu,
  wycofajZgloszenie,
  zglosDoPublikacji,
  type Kuchnia,
  type PoraPosilku,
  type Widocznosc,
} from '@/lib/przepisy';
import {
  OPIS_ROLI_SKLADNIKA,
  pobierzSkladniki,
  pobierzUzycia,
  ROLE_SKLADNIKA,
  sprawdzSkladnik,
  zapiszSkladnik,
  type RolaSkladnika,
  type Skladnik,
  type UzycieSkladnika,
} from '@/lib/skladniki';
import { useSesja } from '@/lib/sesja';
import { supabase } from '@/lib/supabase';

/** Opcje komórki-wyboru dla roli — jak na ekranie Składniki. */
const OPCJE_ROLI = ROLE_SKLADNIKA.map((r) => ({ wartosc: r, etykieta: OPIS_ROLI_SKLADNIKA[r] }));

/** Opcje komórki-wyboru dla kwantyzacji — nieobowiązkowa, więc `null` znaczy „nie wybrano”. */
const OPCJE_MOZNA_DZIELIC: { wartosc: 'nie' | 'tak'; etykieta: string }[] = [
  { wartosc: 'nie', etykieta: 'Nie można podzielić' },
  { wartosc: 'tak', etykieta: 'Można podzielić' },
];

type Jednostka = 'g' | 'ml' | 'szt';

type WybranySkladnik = {
  skladnik: Skladnik;
  /** Ilość w jednostce widocznej dla użytkownika. */
  ilosc: string;
  jednostka: Jednostka;
  stan: string;
  zamiennik: string;
  opisPotoczny: string;
  /** Rola TEGO składnika W TYM przepisie — domyślnie z katalogu, tu zmienialna tylko lokalnie. */
  rola: RolaSkladnika;
  /** Kwantyzacja TEGO składnika W TYM przepisie — jw. Puste = nie ustawiono. */
  moznaDzielic: '' | 'nie' | 'tak';
};

/** Wartości domyślne pól roli/kwantyzacji przy dodaniu składnika do przepisu. */
function domyslneRolaIKwant(s: Skladnik): Pick<WybranySkladnik, 'rola' | 'moznaDzielic'> {
  return {
    rola: s.rola,
    moznaDzielic: s.mozna_dzielic === null || s.mozna_dzielic === undefined ? '' : s.mozna_dzielic ? 'tak' : 'nie',
  };
}

/**
 * Masa w gramach — podstawa wszystkich wyliczeń.
 *
 * Przy sztukach mnożymy liczbę przez masę jednej sztuki zapisaną przy składniku.
 * Mililitry traktujemy jak gramy: przy zupach, mleku i śmietanie gęstość jest
 * na tyle bliska wodzie, że różnica ginie w zaokrągleniach.
 */
function gramyZe(w: WybranySkladnik): number {
  const n = Number(String(w.ilosc).replace(',', '.').trim());
  if (!Number.isFinite(n) || n <= 0) return 0;
  if (w.jednostka === 'szt') return n * (w.skladnik.masa_sztuki_g ?? 0);
  return n;
}

/** Jednostki dostępne dla danego składnika. */
function jednostkiDla(s: Skladnik): Jednostka[] {
  return s.masa_sztuki_g ? ['g', 'ml', 'szt'] : ['g', 'ml'];
}

type Krok = { tresc: string; sygnal: string; uwaga: boolean };

type Etap = {
  nazwa: string;
  minuty: string;
  kroki: Krok[];
};

function liczba(tekst: string): number {
  const n = Number(String(tekst).replace(',', '.').trim());
  return Number.isFinite(n) && n > 0 ? n : 0;
}

export default function FormularzPrzepisu() {
  const { id: edytowanyId, powrot } = useLocalSearchParams<{ id?: string; powrot?: string }>();
  const tryb = edytowanyId ? 'edycja' : 'nowy';
  const { sesja } = useSesja();
  const motyw = useTheme();

  const [dostepne, setDostepne] = useState<Skladnik[]>([]);
  const [wybrane, setWybrane] = useState<WybranySkladnik[]>([]);
  const [uzyciaSkladnikow, setUzyciaSkladnikow] = useState<Map<string, UzycieSkladnika>>(new Map());
  const [trybEdycjiSkladnikow, setTrybEdycjiSkladnikow] = useState(false);

  const [nazwa, setNazwa] = useState('');
  const [opis, setOpis] = useState('');
  const [pory, setPory] = useState<PoraPosilku[]>([]);
  const [kuchnie, setKuchnie] = useState<Kuchnia[]>(['srodziemnomorska']);
  const [trwalosc, setTrwalosc] = useState<'0' | '1' | '2' | '3'>('0');
  const [porcjeBazowe, setPorcjeBazowe] = useState('0');
  const [porcjowanie, setPorcjowanie] = useState<'waga' | 'sztuki'>('sztuki');
  const [porcje, setPorcje] = useState('');
  const [czasPrzygotowania, setCzasPrzygotowania] = useState('');
  const [czasObrobki, setCzasObrobki] = useState('');
  const [sprzet, setSprzet] = useState<string[]>([]);
  const [katalogSprzetu, setKatalogSprzetu] = useState<
    { id: string; nazwa: string; rodzaj: string; w_przepisach: number; przepisy: string[] }[]
  >([]);
  const [sprzetDoUsuniecia, setSprzetDoUsuniecia] = useState<{
    id: string;
    nazwa: string;
    w_przepisach: number;
    przepisy: string[];
  } | null>(null);
  const [nowySprzet, setNowySprzet] = useState('');
  const [przechowywanie, setPrzechowywanie] = useState('');
  const [moznaMrozic, setMoznaMrozic] = useState<'tak' | 'nie' | 'nie wiem'>('nie wiem');
  /** Czy automat wolno automatycznie skalować ten przepis kalorycznie (migracja 0036). */
  const [skalowalny, setSkalowalny] = useState(false);
  const [ratunek, setRatunek] = useState('');
  const [zdjecie, setZdjecie] = useState<string | null>(null);

  /** Zgoda autora na upublicznienie. Sam stan w bazie zmienia dopiero zapis. */
  const [doPublikacji, setDoPublikacji] = useState(false);
  /** Stan przepisu w bazie w chwili wczytania — do rozpoznania, co się zmieniło. */
  const [widocznosc, setWidocznosc] = useState<Widocznosc>('prywatna');
  const [powodOdrzucenia, setPowodOdrzucenia] = useState<string | null>(null);
  const [etapy, setEtapy] = useState<Etap[]>([]);

  const [dodawanieSkladnika, setDodawanieSkladnika] = useState(false);
  const [zajety, setZajety] = useState(false);
  const [blad, setBlad] = useState<string | null>(null);

  const wczytajSkladniki = useCallback(async () => {
    try {
      const [lista, mapa] = await Promise.all([pobierzSkladniki(), pobierzUzycia()]);
      setDostepne(lista);
      setUzyciaSkladnikow(mapa);
    } catch (e) {
      setBlad(komunikatBledu(e));
    }
  }, []);

  const liczbaUzycSkladnika = useCallback(
    (id: string) => uzyciaSkladnikow.get(id)?.przepisy.length ?? 0,
    [uzyciaSkladnikow]
  );

  /** Tekst komórki w tabeli składników — te same reguły co na ekranie Składniki. */
  function wartoscKomorkiSkladnika(s: Skladnik, klucz: string): string {
    if (klucz === 'rola') return OPIS_ROLI_SKLADNIKA[s.rola];
    if (klucz === 'mozna_dzielic') {
      if (s.mozna_dzielic === null || s.mozna_dzielic === undefined) return '';
      return s.mozna_dzielic ? 'tak' : 'nie';
    }
    if (klucz === 'uzycia') {
      const n = liczbaUzycSkladnika(s.id);
      return n === 0 ? '' : String(n);
    }
    const w = (s as unknown as Record<string, number | null>)[klucz];
    if (w === null || w === undefined) return '';
    return String(w);
  }

  /**
   * Zapis pojedynczej komórki parametrów składnika, bez opuszczania formularza przepisu.
   *
   * Ten sam wzorzec co na ekranie Składniki: zmiana trafia najpierw na ekran,
   * a dopiero potem do bazy; przy odmowie bazy wraca poprzednia wartość.
   * Zmieniony składnik trzeba też podmienić w `wybrane`, bo tam trzyma się
   * jego własna kopia, użyta do liczenia makro.
   */
  async function zapiszKomorkeSkladnika(skladnik: Skladnik, pole: keyof Skladnik, tekst: string) {
    setBlad(null);

    const liczbowe = pole !== 'nazwa' && pole !== 'rola' && pole !== 'mozna_dzielic';
    let wartosc: string | number | boolean | null;

    if (pole === 'rola') {
      const rolaWpisana = ROLA_SKLADNIKA_WEDLUG_ETYKIETY.get(tekst.trim().toLowerCase());
      if (!rolaWpisana) {
        setBlad(
          `Rola musi być jedną z: ${ROLE_SKLADNIKA.map((r) => OPIS_ROLI_SKLADNIKA[r]).join(', ')}.`
        );
        return;
      }
      wartosc = rolaWpisana;
    } else if (pole === 'mozna_dzielic') {
      wartosc = tekst === 'tak' ? true : tekst === 'nie' ? false : null;
    } else if (liczbowe) {
      const t = tekst.replace(',', '.').trim();
      if (t === '' || t === '—') {
        wartosc = pole === 'nova' || pole === 'gramatura_opakowania_g' ? null : 0;
      } else {
        const n = Number(t);
        if (!Number.isFinite(n)) {
          setBlad(`„${tekst}” nie jest liczbą.`);
          return;
        }
        wartosc = n;
      }
    } else {
      wartosc = tekst.trim();
    }

    const poprzedni = skladnik;
    const zmieniony = { ...skladnik, [pole]: wartosc } as Skladnik;

    const problemy = sprawdzSkladnik(zmieniony);
    if (problemy.length > 0) {
      setBlad(problemy[0]);
      return;
    }

    setDostepne((p) => p.map((x) => (x.id === skladnik.id ? zmieniony : x)));
    setWybrane((p) => p.map((w) => (w.skladnik.id === skladnik.id ? { ...w, skladnik: zmieniony } : w)));

    try {
      const { id, ...dane } = zmieniony;
      await zapiszSkladnik(dane, id);
    } catch (e) {
      setDostepne((p) => p.map((x) => (x.id === skladnik.id ? poprzedni : x)));
      setWybrane((p) =>
        p.map((w) => (w.skladnik.id === skladnik.id ? { ...w, skladnik: poprzedni } : w))
      );
      setBlad(komunikatBledu(e));
    }
  }

  const wczytajSprzet = useCallback(async () => {
    // Widok sprzet_uzycie dokłada informację, w ilu przepisach sprzęt występuje.
    // Bez niej nie da się bezpiecznie zaproponować usunięcia.
    const { data, error } = await supabase
      .from('sprzet_uzycie')
      .select('id, nazwa, rodzaj, w_przepisach, przepisy')
      .order('nazwa');
    if (error) setBlad(komunikatBledu(error));
    else setKatalogSprzetu(data ?? []);
  }, []);

  // Odświeżenie po każdym powrocie na ekran — składniki mogły zostać dodane
  // gdzie indziej, a lista wczytana raz przy wejściu byłaby nieaktualna.
  useFocusEffect(
    useCallback(() => {
      wczytajSkladniki();
      wczytajSprzet();
    }, [wczytajSkladniki, wczytajSprzet])
  );

  // Wczytanie edytowanego przepisu — dopiero gdy baza składników jest gotowa,
  // bo pozycje przepisu odwołują się do niej po identyfikatorze.
  const [wczytanyId, setWczytanyId] = useState<string | null>(null);

  /**
   * Przywraca formularz do stanu wyjściowego.
   *
   * Ekran nie znika z pamięci po powrocie, więc bez wyczyszczenia „Dodaj przepis”
   * otwierałby się z treścią ostatnio edytowanego dania.
   */
  const wyczyscFormularz = useCallback(() => {
    setNazwa('');
    setOpis('');
    setPory([]);
    setKuchnie(['srodziemnomorska']);
    setTrwalosc('0');
    setPorcjeBazowe('0');
    setPorcjowanie('sztuki');
    setPorcje('');
    setCzasPrzygotowania('');
    setCzasObrobki('');
    setSprzet([]);
    setPrzechowywanie('');
    setMoznaMrozic('nie wiem');
    setSkalowalny(false);
    setRatunek('');
    setZdjecie(null);
    setDoPublikacji(false);
    setWidocznosc('prywatna');
    setPowodOdrzucenia(null);
    setWybrane([]);
    setEtapy([]);
    setNowySprzet('');
    setDodawanieSkladnika(false);
    setBlad(null);
    setWczytanyId(null);
  }, []);

  // Wejście w tryb tworzenia po wcześniejszej edycji — zaczynamy od czystej karty.
  useEffect(() => {
    if (!edytowanyId && wczytanyId !== null) wyczyscFormularz();
  }, [edytowanyId, wczytanyId, wyczyscFormularz]);

  useEffect(() => {
    if (!edytowanyId || dostepne.length === 0 || wczytanyId === edytowanyId) return;

    (async () => {
      try {
        const p = await pobierzPelnyPrzepis(edytowanyId);
        setNazwa(p.nazwa);
        setOpis(p.opis ?? '');
        setPory(p.pory);
        setKuchnie(p.kuchnie);
        setTrwalosc(String(p.trwalosc_dni) as '0' | '1' | '2' | '3');
        setPorcjeBazowe(String(p.liczba_porcji_bazowych));
        setPorcjowanie(p.porcjowanie);
        setPorcje(String(p.porcje));
        setCzasPrzygotowania(p.czas_przygotowania_min ? String(p.czas_przygotowania_min) : '');
        setCzasObrobki(p.czas_obrobki_min ? String(p.czas_obrobki_min) : '');
        setSprzet(p.sprzet ?? []);
        setPrzechowywanie(p.przechowywanie ?? '');
        setMoznaMrozic(p.mozna_mrozic === null ? 'nie wiem' : p.mozna_mrozic ? 'tak' : 'nie');
        setSkalowalny(p.skalowalny);
        setRatunek(p.ratunek ?? '');
        setZdjecie(p.zdjecie ?? null);
        setWidocznosc(p.widocznosc);
        setDoPublikacji(p.widocznosc !== 'prywatna');
        setPowodOdrzucenia(p.powod_odrzucenia ?? null);

        setWybrane(
          p.skladniki
            .map((x) => {
              const skladnik = dostepne.find((d) => d.id === x.skladnik_id);
              if (!skladnik) return null;
              return {
                skladnik,
                ilosc: String(x.ilosc),
                jednostka: x.jednostka,
                stan: x.stan ?? '',
                zamiennik: x.zamiennik ?? '',
                opisPotoczny: x.opis_potoczny ?? '',
                rola: x.rola ?? skladnik.rola,
                moznaDzielic:
                  (x.mozna_dzielic ?? skladnik.mozna_dzielic) === null ||
                  (x.mozna_dzielic ?? skladnik.mozna_dzielic) === undefined
                    ? ''
                    : (x.mozna_dzielic ?? skladnik.mozna_dzielic)
                      ? 'tak'
                      : 'nie',
              } as WybranySkladnik;
            })
            .filter((x): x is WybranySkladnik => x !== null)
        );

        setEtapy(
          p.etapy.map((e) => ({
            nazwa: e.nazwa,
            minuty: e.minuty ? String(e.minuty) : '',
            kroki: e.kroki.map((k) => ({
              tresc: k.tresc,
              sygnal: k.sygnal ?? '',
              uwaga: k.uwaga,
            })),
          }))
        );

        setWczytanyId(edytowanyId);
      } catch (e) {
        setBlad(komunikatBledu(e));
      }
    })();
  }, [edytowanyId, dostepne, wczytanyId]);


  // Makro liczone na żywo, tak samo jak potem policzy je baza.
  const makro = useMemo(() => {
    return wybrane.reduce(
      (suma, w) => {
        const g = gramyZe(w) / 100;
        return {
          kcal: suma.kcal + w.skladnik.kcal_100g * g,
          bialko: suma.bialko + w.skladnik.bialko_100g * g,
          tluszcz: suma.tluszcz + w.skladnik.tluszcz_100g * g,
          wegle: suma.wegle + w.skladnik.wegle_100g * g,
          cukryWolne: suma.cukryWolne + w.skladnik.cukry_wolne_100g * g,
          nova: Math.max(suma.nova, w.skladnik.nova ?? 0),
        };
      },
      { kcal: 0, bialko: 0, tluszcz: 0, wegle: 0, cukryWolne: 0, nova: 0 }
    );
  }, [wybrane]);

  const masaCalosci = wybrane.reduce((s, w) => s + gramyZe(w), 0);

  const wybraneId = useMemo(() => wybrane.map((w) => w.skladnik.id), [wybrane]);

  const sprzetId = useMemo(
    () => katalogSprzetu.filter((x) => sprzet.includes(x.nazwa)).map((x) => x.id),
    [katalogSprzetu, sprzet]
  );

  const przelaczSprzet = useCallback((x: { nazwa: string }) => {
    setSprzet((p) => (p.includes(x.nazwa) ? p.filter((n) => n !== x.nazwa) : [...p, x.nazwa]));
  }, []);

  /**
   * Liczba porcji zależy od sposobu porcjowania.
   * Przy wadze bierzemy liczbę porcji bazowych wprost; przy sztukach —
   * podaną liczbę sztuk.
   */
  const liczbaPorcji =
    porcjowanie === 'waga'
      ? Math.max(1, Math.round(liczba(porcjeBazowe)) || 1)
      : Math.max(1, Math.round(liczba(porcje)) || 1);

  /**
   * Waga jednej porcji przy porcjowaniu wagowym już się nie wpisuje —
   * wynika z podzielenia masy całej potrawy przez liczbę porcji bazowych.
   */
  const wagaPorcjiWyliczona = porcjowanie === 'waga' ? masaCalosci / liczbaPorcji : null;

  /** Czy podano wartość odpowiadającą wybranemu sposobowi porcjowania. */
  const podanoPorcjowanie = porcjowanie === 'waga' ? liczba(porcjeBazowe) > 0 : liczba(porcje) > 0;


  const makroPorcji = {
    kcal: makro.kcal / liczbaPorcji,
    bialko: makro.bialko / liczbaPorcji,
    tluszcz: makro.tluszcz / liczbaPorcji,
    wegle: makro.wegle / liczbaPorcji,
    cukryWolne: makro.cukryWolne / liczbaPorcji,
    gramy: masaCalosci / liczbaPorcji,
  };

  const komplet =
    nazwa.trim().length >= 3 &&
    podanoPorcjowanie &&
    wybrane.length > 0 &&
    wybrane.every((w) => gramyZe(w) > 0);

  const dodajSkladnik = useCallback((s: Skladnik) => {
    setWybrane((p) => [
      ...p,
      {
        skladnik: s,
        ilosc: '',
        jednostka: 'g',
        stan: '',
        zamiennik: '',
        opisPotoczny: '',
        ...domyslneRolaIKwant(s),
      },
    ]);
  }, []);

  /**
   * Przełączenie składnika liczone z aktualnego stanu, a nie z domknięcia.
   *
   * Odczyt `wybrane` wewnątrz funkcji przekazywanej do komponentu potomnego
   * potrafi zwrócić wartość sprzed zmiany. Zapis funkcyjny widzi zawsze
   * bieżący stan, więc dodawanie i usuwanie nie rozjeżdża się z ekranem.
   */
  const przelaczSkladnik = useCallback((s: Skladnik) => {
    setWybrane((poprzednie) => {
      const juz = poprzednie.some((w) => w.skladnik.id === s.id);
      const nowy: WybranySkladnik = {
        skladnik: s,
        ilosc: '',
        jednostka: 'g',
        stan: '',
        zamiennik: '',
        opisPotoczny: '',
        ...domyslneRolaIKwant(s),
      };
      const wynik = juz ? poprzednie.filter((w) => w.skladnik.id !== s.id) : [...poprzednie, nowy];
      return wynik;
    });
  }, []);

  const zmienSkladnik = useCallback((id: string, zmiana: Partial<WybranySkladnik>) => {
    setWybrane((p) => p.map((w) => (w.skladnik.id === id ? { ...w, ...zmiana } : w)));
  }, []);


  /** Wstawia etap na wskazanej pozycji. Bez argumentu — na końcu. */
  function wstawEtap(poIndeksie?: number) {
    const pusty: Etap = { nazwa: '', minuty: '', kroki: [] };
    setEtapy((p) => {
      if (poIndeksie === undefined) return [...p, pusty];
      const nowe = [...p];
      nowe.splice(poIndeksie + 1, 0, pusty);
      return nowe;
    });
  }

  function zmienEtap(indeks: number, pole: 'nazwa' | 'minuty', wartosc: string) {
    setEtapy((p) => p.map((e, i) => (i === indeks ? { ...e, [pole]: wartosc } : e)));
  }

  function usunEtap(indeks: number) {
    setEtapy((p) => p.filter((_, i) => i !== indeks));
  }

  function przesunEtap(indeks: number, oIle: number) {
    setEtapy((p) => {
      const cel = indeks + oIle;
      if (cel < 0 || cel >= p.length) return p;
      const nowe = [...p];
      [nowe[indeks], nowe[cel]] = [nowe[cel], nowe[indeks]];
      return nowe;
    });
  }

  /**
   * Wstawia krok na wskazanej pozycji. Bez drugiego argumentu — na końcu etapu.
   *
   * Dopisywanie wyłącznie na końcu zmuszało do przepisywania całej instrukcji,
   * gdy okazało się, że czegoś brakuje w środku.
   */
  function wstawKrok(indeksEtapu: number, poIndeksie?: number) {
    const pusty: Krok = { tresc: '', sygnal: '', uwaga: false };
    setEtapy((p) =>
      p.map((e, i) => {
        if (i !== indeksEtapu) return e;
        if (poIndeksie === undefined) return { ...e, kroki: [...e.kroki, pusty] };
        const kroki = [...e.kroki];
        kroki.splice(poIndeksie + 1, 0, pusty);
        return { ...e, kroki };
      })
    );
  }

  function przesunKrok(indeksEtapu: number, indeksKroku: number, oIle: number) {
    setEtapy((p) =>
      p.map((e, i) => {
        if (i !== indeksEtapu) return e;
        const cel = indeksKroku + oIle;
        if (cel < 0 || cel >= e.kroki.length) return e;
        const kroki = [...e.kroki];
        [kroki[indeksKroku], kroki[cel]] = [kroki[cel], kroki[indeksKroku]];
        return { ...e, kroki };
      })
    );
  }

  function zmienKrok(indeksEtapu: number, indeksKroku: number, zmiana: Partial<Krok>) {
    setEtapy((p) =>
      p.map((e, i) =>
        i === indeksEtapu
          ? { ...e, kroki: e.kroki.map((k, j) => (j === indeksKroku ? { ...k, ...zmiana } : k)) }
          : e
      )
    );
  }

  function usunKrok(indeksEtapu: number, indeksKroku: number) {
    setEtapy((p) =>
      p.map((e, i) =>
        i === indeksEtapu ? { ...e, kroki: e.kroki.filter((_, j) => j !== indeksKroku) } : e
      )
    );
  }

  /** Suma czasów etapów — górne oszacowanie, bo etapy potrafią się nakładać. */
  const czasRazem = etapy.reduce((suma, e) => suma + liczba(e.minuty), 0);

  async function zapisz() {
    setBlad(null);
    if (!sesja) {
      setBlad('Brak zalogowanego użytkownika.');
      return;
    }

    setZajety(true);
    try {
      const dane = {
          nazwa: nazwa.trim(),
          opis: opis.trim() || null,
          pory,
          kuchnie,
          trwalosc_dni: Number(trwalosc),
          liczba_porcji_bazowych: Math.round(liczba(porcjeBazowe)),
          porcjowanie,
          porcje: porcjowanie === 'sztuki' ? Math.round(liczbaPorcji) : 1,
          porcja_g: porcjowanie === 'waga' ? Math.round(wagaPorcjiWyliczona ?? 0) : null,
          czas_przygotowania_min: liczba(czasPrzygotowania) || null,
          czas_obrobki_min: liczba(czasObrobki) || null,
          sprzet,
          przechowywanie: przechowywanie.trim() || null,
          mozna_mrozic: moznaMrozic === 'nie wiem' ? null : moznaMrozic === 'tak',
          ratunek: ratunek.trim() || null,
          zdjecie,
          skalowalny,
      };

      let przepisId: string;

      if (edytowanyId) {
        // Edycja: aktualizujemy nagłówek, a treść wstawiamy od nowa.
        const { error } = await supabase.from('przepisy').update(dane).eq('id', edytowanyId);
        if (error) throw error;
        await wyczyscTrescPrzepisu(edytowanyId);
        przepisId = edytowanyId;
      } else {
        const { data, error } = await supabase
          .from('przepisy')
          .insert({ ...dane, autor_id: sesja.user.id, widocznosc: 'prywatna' })
          .select('id')
          .single();
        if (error) throw error;
        przepisId = data.id;
      }

      const przepis = { id: przepisId };

      const { error: bladSkladnikow } = await supabase.from('przepis_skladniki').insert(
        wybrane.map((w, i) => ({
          przepis_id: przepis.id,
          skladnik_id: w.skladnik.id,
          gramy: gramyZe(w),
          ilosc: liczba(w.ilosc),
          jednostka: w.jednostka,
          stan: w.stan.trim() || null,
          zamiennik: w.zamiennik.trim() || null,
          opis_potoczny: w.opisPotoczny.trim() || null,
          kolejnosc: i + 1,
          rola: w.rola,
          mozna_dzielic: w.moznaDzielic === '' ? null : w.moznaDzielic === 'tak',
        }))
      );
      if (bladSkladnikow) throw bladSkladnikow;

      // Etapy zapisujemy razem, żeby poznać ich identyfikatory,
      // a dopiero potem kroki przypisane do każdego z nich.
      const doZapisu = etapy.filter((e) => e.nazwa.trim());

      if (doZapisu.length > 0) {
        const { data: zapisaneEtapy, error: bladEtapow } = await supabase
          .from('etapy')
          .insert(
            doZapisu.map((e, i) => ({
              przepis_id: przepis.id,
              kolejnosc: i + 1,
              nazwa: e.nazwa.trim(),
              minuty: liczba(e.minuty) || null,
            }))
          )
          .select('id, kolejnosc');
        if (bladEtapow) throw bladEtapow;

        const wedlugKolejnosci = new Map(
          (zapisaneEtapy ?? []).map((e) => [e.kolejnosc as number, e.id as string])
        );

        const krokiDoZapisu = doZapisu.flatMap((e, i) =>
          e.kroki
            .filter((k) => k.tresc.trim())
            .map((k, j) => ({
              etap_id: wedlugKolejnosci.get(i + 1)!,
              kolejnosc: j + 1,
              tresc: k.tresc.trim(),
              sygnal: k.sygnal.trim() || null,
              uwaga: k.uwaga,
            }))
        );

        if (krokiDoZapisu.length > 0) {
          const { error: bladKrokow } = await supabase.from('kroki').insert(krokiDoZapisu);
          if (bladKrokow) throw bladKrokow;
        }
      }

      /*
        Zgłoszenie ustawiamy OSOBNYM zapytaniem, po zapisaniu treści.

        Nie da się inaczej: przy nowym przepisie identyfikator powstaje dopiero
        przy wstawieniu, a wyzwalacz w bazie przepuszcza wyłącznie przejścia
        prywatna ↔ zgloszona — więc wstawienie od razu jako „zgłoszony”
        zostałoby odrzucone.

        Kolejność też nie jest przypadkowa: najpierw treść, potem zgłoszenie.
        Moderator ma zobaczyć to, co autor faktycznie zapisał.
      */
      if (doPublikacji && widocznosc === 'prywatna') {
        await zglosDoPublikacji(przepisId);
      } else if (!doPublikacji && widocznosc === 'zgloszona') {
        await wycofajZgloszenie(przepisId);
      }

      wyczyscFormularz();
      wroc(powrot, '/przepisy');
    } catch (e) {
      setBlad(komunikatBledu(e));
    } finally {
      setZajety(false);
    }
  }

  return (
    <Ekran
      pelnaSzerokosc
      tytul={tryb === 'edycja' ? 'Edycja przepisu' : 'Nowy przepis'}
      podtytul={tryb === 'edycja' ? nazwa || undefined : 'Makro policzy się ze składników'}>
      <Karta style={styles.grupa}>
        <Pole etykieta="Nazwa" value={nazwa} onChangeText={setNazwa} placeholder="Dorsz z kaszą gryczaną" />
        <Pole
          etykieta="Krótki opis"
          value={opis}
          onChangeText={setOpis}
          placeholder="Pieczony w piekarniku, warzywa na jednej blasze"
          multiline
        />

        <ZdjeciePrzepisu nazwaPrzepisu={nazwa} zdjecie={zdjecie} onZmiana={setZdjecie} />

        <ThemedText type="smallBold" themeColor="textSecondary">
          METRYCZKA
        </ThemedText>

        <Wybor
          etykieta="Jak dzielimy danie na porcje"
          wybrana={porcjowanie}
          onZmiana={setPorcjowanie}
          opcje={[
            {
              wartosc: 'sztuki',
              etykieta: 'Na sztuki',
              opis: 'kotlety, naleśniki, muffiny — podajesz liczbę',
            },
            {
              wartosc: 'waga',
              etykieta: 'Na wagę',
              opis: 'zupy, gulasze, sosy — podajesz wagę jednej porcji',
            },
          ]}
        />

        {[
          porcjowanie === 'sztuki'
            ? {
                etykieta: 'Liczba porcji',
                wartosc: porcje,
                ustaw: setPorcje,
                jednostka: 'sztuk',
                podpowiedz: 'np. 4',
                edytowalne: true,
              }
            : {
                etykieta: 'Waga jednej porcji',
                wartosc: wagaPorcjiWyliczona ? String(Math.round(wagaPorcjiWyliczona)) : '',
                ustaw: () => {},
                jednostka: 'g',
                podpowiedz: '—',
                edytowalne: false,
              },
          {
            etykieta: 'Liczba porcji bazowych',
            wartosc: porcjeBazowe,
            ustaw: setPorcjeBazowe,
            jednostka: 'porcji',
            podpowiedz: 'np. 4',
            edytowalne: true,
          },
          {
            etykieta: 'Czas przygotowania',
            wartosc: czasPrzygotowania,
            ustaw: setCzasPrzygotowania,
            jednostka: 'min',
            podpowiedz: 'np. 20',
            edytowalne: true,
          },
          {
            etykieta: 'Czas obróbki',
            wartosc: czasObrobki,
            ustaw: setCzasObrobki,
            jednostka: 'min',
            podpowiedz: 'np. 50',
            edytowalne: true,
          },
        ].map((w) => (
          <View key={w.etykieta} style={[styles.wierszMetryczki, { borderColor: motyw.border }]}>
            <ThemedText type="small" style={styles.etykietaMetryczki}>
              {w.etykieta}
            </ThemedText>
            <TextInput
              value={w.wartosc}
              onChangeText={w.ustaw}
              editable={w.edytowalne}
              inputMode="numeric"
              placeholder={w.podpowiedz}
              placeholderTextColor={motyw.textSecondary}
              style={[
                styles.poleMetryczki,
                { color: motyw.text, borderColor: motyw.border, backgroundColor: motyw.backgroundElement },
                !w.edytowalne && { opacity: 0.6 },
              ]}
            />
            <ThemedText type="small" themeColor="textSecondary" style={styles.jednostkaMetryczki}>
              {w.jednostka}
            </ThemedText>
          </View>
        ))}

        {porcjowanie === 'waga' && (
          <ThemedText type="small" themeColor="textSecondary">
            Waga jednej porcji wynika z podzielenia masy całej potrawy przez liczbę porcji bazowych —
            nie wpisuje się jej ręcznie.
          </ThemedText>
        )}

        {wybrane.length > 0 && podanoPorcjowanie && (
          <ThemedText type="small" themeColor="textSecondary">
            {porcjowanie === 'waga'
              ? `Z ${Math.round(masaCalosci)} g wychodzi ${liczbaPorcji} porcji po około ${Math.round(wagaPorcjiWyliczona ?? 0)} g.`
              : `Z ${Math.round(masaCalosci)} g wychodzi ${liczbaPorcji} porcji po około ${Math.round(masaCalosci / liczbaPorcji)} g.`}
          </ThemedText>
        )}

        <ThemedText type="small" themeColor="textSecondary">
          Przy daniach dzielonych na wagę podajesz liczbę porcji bazowych, a waga
          jednej porcji wychodzi z rachunku: masa całej potrawy podzielona przez tę liczbę.
        </ThemedText>

        <Pressable
          onPress={() => setSkalowalny((x) => !x)}
          accessibilityRole="checkbox"
          accessibilityState={{ checked: skalowalny }}
          style={({ pressed }) => [
            styles.zgoda,
            { borderColor: skalowalny ? motyw.accent : motyw.border },
            pressed && styles.wcisniety,
          ]}>
          <Ionicons
            name={skalowalny ? 'checkbox' : 'square-outline'}
            size={22}
            color={skalowalny ? motyw.accent : motyw.textSecondary}
          />
          <View style={styles.trescZgody}>
            <ThemedText type="default" themeColor={skalowalny ? 'accent' : 'text'}>
              Można skalować kalorycznie
            </ThemedText>
            <ThemedText type="small" themeColor="textSecondary">
              Dla dań o elastycznej wielkości — sałatka, kanapka „na kromkę". Automat
              wypełniający plan wolno mu wtedy dokładać albo ujmować składników, żeby
              dobić do celu kalorycznego posiłku, zamiast wstawiać przepis zawsze
              w bazowym rozmiarze.
            </ThemedText>
          </View>
        </Pressable>
      </Karta>
      <Karta style={styles.grupa}>
        <WyborWielo
          etykieta="Kategoria"
          wybrane={pory}
          onZmiana={setPory}
          opcje={KATEGORIE.map((k) => ({
            wartosc: k,
            etykieta: OPIS_PORY[k],
          }))}
        />
        <ThemedText type="small" themeColor="textSecondary">
          Można zaznaczyć kilka — zupa bywa i obiadem, i kolacją. „Dodatek” to coś,
          co dokładasz do posiłku: grillowana pierś, surówka, sałatka z ciecierzycy.
          Dodatki pojawiają się przy wyborze dania do każdego posiłku.
        </ThemedText>
        <WyborWielo
          etykieta="Kuchnia"
          wybrane={kuchnie}
          onZmiana={setKuchnie}
          opcje={(Object.keys(OPIS_KUCHNI) as Kuchnia[]).map((k) => ({
            wartosc: k,
            etykieta: OPIS_KUCHNI[k],
          }))}
        />
        <Wybor
          etykieta="Ile dni wytrzyma w lodówce"
          wybrana={trwalosc}
          onZmiana={setTrwalosc}
          opcje={[
            { wartosc: '0', etykieta: opisTrwalosci(0), opis: 'jajecznica, sałatki, dania z grilla' },
            { wartosc: '1', etykieta: opisTrwalosci(1), opis: 'dania delikatne, z dużą ilością nabiału' },
            { wartosc: '2', etykieta: opisTrwalosci(2), opis: 'dania rybne, zupy lekkie' },
            { wartosc: '3', etykieta: opisTrwalosci(3), opis: 'zupy, gulasze, kasze i strączki' },
          ]}
        />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          SKŁADNIKI W PRZEPISIE ({wybrane.length})
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Odfiltruj listę i dotknij wiersza albo znaku plus. Wiersz rozwinie się
          i poprosi o ilość.
        </ThemedText>

        {dostepne.length === 0 ? (
          <ThemedText type="small" themeColor="accent">
            Baza składników jest pusta albo nie udało się jej wczytać. Sprawdź, czy
            wszystkie migracje z katalogu supabase/migrations zostały wykonane —
            zwłaszcza 0004_blonnik.sql, bez którego odczyt składników zwraca błąd.
          </ThemedText>
        ) : (
          <ThemedText type="small" themeColor="textSecondary">
            Do wyboru: {dostepne.length} składników w bazie. W przepisie: {wybrane.length}.
          </ThemedText>
        )}

        <View style={styles.przyciskiSkladnikow}>
          <Przycisk
            tytul="Odśwież listę składników"
            wariant="poboczny"
            onPress={wczytajSkladniki}
          />
          <Przycisk
            tytul={
              trybEdycjiSkladnikow
                ? 'Zakończ edycję parametrów bazowych'
                : 'Edytuj parametry składników - bazowe'
            }
            wariant="poboczny"
            onPress={() => setTrybEdycjiSkladnikow((p) => !p)}
          />
        </View>

        {trybEdycjiSkladnikow && (
          <ThemedText type="small" themeColor="textSecondary">
            Komórki są teraz polami do wpisywania — zmiana trafia od razu do bazy i dotyczy
            składnika wszędzie, nie tylko w tym przepisie. Dodawanie do przepisu działa dalej
            znakiem plus po lewej. Rolę i kwantyzację TYLKO dla tego przepisu zmienisz niżej,
            w tabeli wybranych składników.
          </ThemedText>
        )}

        <TabelaWyboru
          dane={dostepne}
          klucz={(s) => s.id}
          tekstDoFiltra={(s) => `${s.nazwa} ${s.tagi.join(' ')}`}
          etykietaFiltra="Filtruj składniki po nazwie lub etykiecie"
          placeholderFiltra="dorsz, ryba, warzywo…"
          wybrane={wybraneId}
          onPrzelacz={przelaczSkladnik}
          trybEdycji={trybEdycjiSkladnikow}
          kolumny={[
            { tytul: 'Nazwa', elastyczna: true, wartosc: (s) => s.nazwa },
            {
              tytul: 'kcal',
              szerokosc: 56,
              liczba: true,
              wartosc: (s) => String(s.kcal_100g),
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'kcal_100g')}
                  szerokosc={56}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'kcal_100g', nowa)}
                />
              ),
            },
            {
              tytul: 'B',
              szerokosc: 48,
              liczba: true,
              wartosc: (s) => String(s.bialko_100g),
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'bialko_100g')}
                  szerokosc={48}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'bialko_100g', nowa)}
                />
              ),
            },
            {
              tytul: 'T',
              szerokosc: 48,
              liczba: true,
              wartosc: (s) => String(s.tluszcz_100g),
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'tluszcz_100g')}
                  szerokosc={48}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'tluszcz_100g', nowa)}
                />
              ),
            },
            {
              tytul: 'W',
              szerokosc: 48,
              liczba: true,
              wartosc: (s) => String(s.wegle_100g),
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'wegle_100g')}
                  szerokosc={48}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'wegle_100g', nowa)}
                />
              ),
            },
            {
              tytul: 'błonnik',
              szerokosc: 60,
              liczba: true,
              wartosc: (s) => String(s.blonnik_100g),
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'blonnik_100g')}
                  szerokosc={60}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'blonnik_100g', nowa)}
                />
              ),
            },
            {
              tytul: 'c. wolne',
              szerokosc: 66,
              liczba: true,
              wartosc: (s) => String(s.cukry_wolne_100g),
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'cukry_wolne_100g')}
                  szerokosc={66}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'cukry_wolne_100g', nowa)}
                />
              ),
            },
            {
              tytul: 'NOVA',
              szerokosc: 54,
              liczba: true,
              wartosc: (s) => wartoscKomorkiSkladnika(s, 'nova') || '—',
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'nova')}
                  szerokosc={54}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'nova', nowa)}
                />
              ),
            },
            {
              tytul: 'opak.',
              szerokosc: 58,
              liczba: true,
              wartosc: (s) => wartoscKomorkiSkladnika(s, 'gramatura_opakowania_g') || '—',
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'gramatura_opakowania_g')}
                  szerokosc={58}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'gramatura_opakowania_g', nowa)}
                />
              ),
            },
            {
              tytul: 'szt. waży',
              szerokosc: 66,
              liczba: true,
              wartosc: (s) => wartoscKomorkiSkladnika(s, 'masa_sztuki_g') || '—',
              komorka: (s) => (
                <KomorkaEdytowalna
                  wartosc={wartoscKomorkiSkladnika(s, 'masa_sztuki_g')}
                  szerokosc={66}
                  liczba
                  edytowalna
                  onZapisz={(nowa) => zapiszKomorkeSkladnika(s, 'masa_sztuki_g', nowa)}
                />
              ),
            },
            {
              tytul: 'kwant.',
              szerokosc: 62,
              wartosc: (s) => wartoscKomorkiSkladnika(s, 'mozna_dzielic') || '—',
              komorka: (s) => {
                const wybrana =
                  s.mozna_dzielic === null || s.mozna_dzielic === undefined
                    ? null
                    : s.mozna_dzielic
                      ? 'tak'
                      : 'nie';
                return (
                  <KomorkaWyboru
                    wartosc={wybrana}
                    etykieta={wartoscKomorkiSkladnika(s, 'mozna_dzielic') || '—'}
                    opcje={OPCJE_MOZNA_DZIELIC}
                    szerokosc={62}
                    edytowalna
                    onWybierz={(nowa) => zapiszKomorkeSkladnika(s, 'mozna_dzielic', nowa)}
                  />
                );
              },
            },
            {
              tytul: 'rola',
              szerokosc: 90,
              wartosc: (s) => OPIS_ROLI_SKLADNIKA[s.rola],
              komorka: (s) => (
                <KomorkaWyboru
                  wartosc={s.rola}
                  etykieta={OPIS_ROLI_SKLADNIKA[s.rola]}
                  opcje={OPCJE_ROLI}
                  szerokosc={90}
                  edytowalna
                  onWybierz={(nowa) => zapiszKomorkeSkladnika(s, 'rola', nowa)}
                />
              ),
            },
            {
              tytul: 'w daniach',
              szerokosc: 72,
              liczba: true,
              wartosc: (s) => wartoscKomorkiSkladnika(s, 'uzycia') || '—',
            },
          ]}
          poWyborze={
            wybrane.length > 0 ? (
              <View style={[styles.tabelaWybranych, { borderColor: motyw.border }]}>
                <View style={[styles.wierszWybranego, styles.naglowekWybranych, { borderColor: motyw.border }]}>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolNazwa}>
                    Składnik
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolIlosc}>
                    Ilość
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolJednostka}>
                    Jedn.
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolGramy}>
                    = gramy
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolStan}>
                    Stan
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolStan}>
                    Zamiennik
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolRola}>
                    Rola
                  </ThemedText>
                  <ThemedText type="smallBold" themeColor="textSecondary" style={styles.kolKwant}>
                    Kwant.
                  </ThemedText>
                  <View style={styles.kolUsun} />
                </View>

                {wybrane.map((w, i) => {
                  const dostepneJedn = jednostkiDla(w.skladnik);
                  return (
                    <View
                      key={w.skladnik.id}
                      style={[
                        styles.wierszWybranego,
                        {
                          borderColor: motyw.border,
                          backgroundColor: i % 2 === 0 ? motyw.backgroundElement : motyw.background,
                        },
                      ]}>
                      <ThemedText type="small" style={styles.kolNazwa} numberOfLines={2}>
                        {i + 1}. {w.skladnik.nazwa}
                      </ThemedText>

                      <View style={styles.kolIlosc}>
                        <TextInput
                          value={w.ilosc}
                          onChangeText={(t) => zmienSkladnik(w.skladnik.id, { ilosc: t })}
                          inputMode="decimal"
                          placeholder="0"
                          placeholderTextColor={motyw.textSecondary}
                          style={[
                            styles.polePozycji,
                            { color: motyw.text, borderColor: motyw.border },
                          ]}
                        />
                      </View>

                      {/* Jednostka przełączana dotknięciem — sztuki tylko tam, gdzie znamy masę jednej. */}
                      <Pressable
                        onPress={() => {
                          const next =
                            dostepneJedn[(dostepneJedn.indexOf(w.jednostka) + 1) % dostepneJedn.length];
                          zmienSkladnik(w.skladnik.id, { jednostka: next });
                        }}
                        style={styles.kolJednostka}>
                        <ThemedText type="smallBold" themeColor="accent">
                          {w.jednostka}
                        </ThemedText>
                      </Pressable>

                      <ThemedText type="small" themeColor="textSecondary" style={styles.kolGramy}>
                        {gramyZe(w) ? `${Math.round(gramyZe(w) * 10) / 10} g` : '—'}
                      </ThemedText>

                      <View style={styles.kolStan}>
                        <TextInput
                          value={w.stan}
                          onChangeText={(t) => zmienSkladnik(w.skladnik.id, { stan: t })}
                          placeholder="obrana, starta"
                          placeholderTextColor={motyw.textSecondary}
                          style={[
                            styles.polePozycji,
                            { color: motyw.text, borderColor: motyw.border, textAlign: 'left' },
                          ]}
                        />
                      </View>

                      <View style={styles.kolStan}>
                        <TextInput
                          value={w.zamiennik}
                          onChangeText={(t) => zmienSkladnik(w.skladnik.id, { zamiennik: t })}
                          placeholder="lub…"
                          placeholderTextColor={motyw.textSecondary}
                          style={[
                            styles.polePozycji,
                            { color: motyw.text, borderColor: motyw.border, textAlign: 'left' },
                          ]}
                        />
                      </View>

                      <KomorkaWyboru
                        wartosc={w.rola}
                        etykieta={OPIS_ROLI_SKLADNIKA[w.rola]}
                        opcje={OPCJE_ROLI}
                        szerokosc={100}
                        edytowalna
                        onWybierz={(nowa) => zmienSkladnik(w.skladnik.id, { rola: nowa })}
                      />

                      <KomorkaWyboru
                        wartosc={w.moznaDzielic === '' ? null : w.moznaDzielic}
                        etykieta={w.moznaDzielic === 'tak' ? 'tak' : w.moznaDzielic === 'nie' ? 'nie' : '—'}
                        opcje={OPCJE_MOZNA_DZIELIC}
                        szerokosc={90}
                        edytowalna
                        onWybierz={(nowa) => zmienSkladnik(w.skladnik.id, { moznaDzielic: nowa })}
                      />

                      <Pressable
                        onPress={() => przelaczSkladnik(w.skladnik)}
                        hitSlop={8}
                        accessibilityLabel={`Usuń ${w.skladnik.nazwa}`}
                        style={styles.kolUsun}>
                        <Ionicons name="close" size={16} color={motyw.textSecondary} />
                      </Pressable>
                    </View>
                  );
                })}
              </View>
            ) : null
          }
          stopka={(fraza) =>
            dodawanieSkladnika ? (
              <View style={styles.okienko}>
                <ThemedText type="small" themeColor="textSecondary">
                  Przepis pozostaje wpisany — po zapisaniu składnik od razu do niego wejdzie.
                </ThemedText>
                <FormularzSkladnika
                  nazwaPoczatkowa={fraza}
                  onZapisano={(nowy) => {
                    setDostepne((p) => [...p, nowy].sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl')));
                    dodajSkladnik(nowy);
                    setDodawanieSkladnika(false);
                  }}
                  onAnuluj={() => setDodawanieSkladnika(false)}
                />
              </View>
            ) : (
              <Przycisk
                tytul={fraza ? `Nie ma „${fraza}”? Dodaj do bazy` : 'Brakuje składnika? Dodaj go'}
                wariant="poboczny"
                onPress={() => setDodawanieSkladnika(true)}
              />
            )
          }
        />
      </Karta>
      {wybrane.length > 0 && (
        <Karta>
          <ThemedText type="smallBold" themeColor="textSecondary">
            NA JEDNĄ PORCJĘ ({Math.round(makroPorcji.gramy)} g)
          </ThemedText>
          <WierszMakro
            pozycje={[
              { etykieta: 'kcal', wartosc: Math.round(makroPorcji.kcal), jednostka: '' },
              { etykieta: 'białko', wartosc: Math.round(makroPorcji.bialko * 10) / 10, jednostka: ' g' },
              { etykieta: 'tłuszcz', wartosc: Math.round(makroPorcji.tluszcz * 10) / 10, jednostka: ' g' },
              { etykieta: 'węgle', wartosc: Math.round(makroPorcji.wegle * 10) / 10, jednostka: ' g' },
            ]}
          />

          <ThemedText type="small" themeColor="textSecondary">
            Cała potrawa: {Math.round(masaCalosci)} g, {Math.round(makro.kcal)} kcal,{' '}
            {Math.round(makro.bialko * 10) / 10} g białka
          </ThemedText>

          {makroPorcji.cukryWolne > 0 && (
            <ThemedText type="small" themeColor="textSecondary">
              Cukry wolne w porcji: {Math.round(makroPorcji.cukryWolne * 10) / 10} g
            </ThemedText>
          )}
          {makro.nova >= 4 && (
            <ThemedText type="small" themeColor="accent">
              Przepis zawiera składnik wysoko przetworzony (NOVA 4). Talerz takich nie promuje.
            </ThemedText>
          )}
        </Karta>
      )}
      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          POTRZEBNY SPRZĘT ({sprzet.length})
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Zapobiega szukaniu blendera w połowie gotowania.
        </ThemedText>

        {sprzetDoUsuniecia && (
          <Karta>
            {sprzetDoUsuniecia.w_przepisach > 0 ? (
              <>
                <ThemedText type="smallBold" themeColor="accent">
                  „{sprzetDoUsuniecia.nazwa}” jest używany
                </ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  Występuje w {sprzetDoUsuniecia.w_przepisach}{' '}
                  {sprzetDoUsuniecia.w_przepisach === 1 ? 'przepisie' : 'przepisach'}:
                </ThemedText>
                {sprzetDoUsuniecia.przepisy.map((n) => (
                  <ThemedText key={n} type="small">
                    • {n}
                  </ThemedText>
                ))}

                {/*
                  Sama informacja „usuń go stamtąd” nie wystarcza — trzeba by
                  otwierać każdy przepis po kolei. Robimy to jednym ruchem.
                */}
                <Przycisk
                  tytul="Usuń z tych przepisów i skasuj"
                  onPress={async () => {
                    setBlad(null);
                    try {
                      const { data: uzywajace, error: bladOdczytu } = await supabase
                        .from('przepisy')
                        .select('id, sprzet')
                        .contains('sprzet', [sprzetDoUsuniecia.nazwa]);
                      if (bladOdczytu) throw bladOdczytu;

                      for (const przepis of uzywajace ?? []) {
                        const bez = (przepis.sprzet as string[]).filter(
                          (x) => x !== sprzetDoUsuniecia.nazwa
                        );
                        const { error } = await supabase
                          .from('przepisy')
                          .update({ sprzet: bez })
                          .eq('id', przepis.id);
                        if (error) throw error;
                      }

                      const { error: bladUsuniecia } = await supabase
                        .from('sprzet')
                        .delete()
                        .eq('id', sprzetDoUsuniecia.id);
                      if (bladUsuniecia) throw bladUsuniecia;

                      setSprzet((p) => p.filter((n) => n !== sprzetDoUsuniecia.nazwa));
                      setSprzetDoUsuniecia(null);
                      wczytajSprzet();
                    } catch (e) {
                      setBlad(komunikatBledu(e));
                    }
                  }}
                />
                <Przycisk
                  tytul="Zostaw"
                  wariant="poboczny"
                  onPress={() => setSprzetDoUsuniecia(null)}
                />
              </>
            ) : (
              <>
                <ThemedText type="smallBold">
                  Usunąć „{sprzetDoUsuniecia.nazwa}” z katalogu?
                </ThemedText>
                <ThemedText type="small" themeColor="textSecondary">
                  Nie występuje w żadnym przepisie. Tej operacji nie da się cofnąć.
                </ThemedText>
                <Przycisk
                  tytul="Usuń"
                  onPress={async () => {
                    const { error } = await supabase
                      .from('sprzet')
                      .delete()
                      .eq('id', sprzetDoUsuniecia.id);
                    if (error) {
                      setBlad(komunikatBledu(error));
                      return;
                    }
                    // Gdyby był zaznaczony w tym przepisie, znika też z wyboru.
                    setSprzet((p) => p.filter((n) => n !== sprzetDoUsuniecia.nazwa));
                    setSprzetDoUsuniecia(null);
                    wczytajSprzet();
                  }}
                />
                <Przycisk
                  tytul="Anuluj"
                  wariant="poboczny"
                  onPress={() => setSprzetDoUsuniecia(null)}
                />
              </>
            )}
          </Karta>
        )}

        <TabelaWyboru
          dane={katalogSprzetu}
          klucz={(x) => x.id}
          tekstDoFiltra={(x) => `${x.nazwa} ${x.rodzaj}`}
          etykietaFiltra="Filtruj sprzęt"
          placeholderFiltra="garnek, tarka, piekarnik…"
          wysokosc={220}
          wybrane={sprzetId}
          onPrzelacz={przelaczSprzet}
          kolumny={[
            { tytul: 'Nazwa', elastyczna: true, wartosc: (x) => x.nazwa },
            { tytul: 'Rodzaj', szerokosc: 110, wartosc: (x) => x.rodzaj },
            {
              tytul: 'w przepisach',
              szerokosc: 90,
              liczba: true,
              wartosc: (x) => (x.w_przepisach === 0 ? '—' : String(x.w_przepisach)),
            },
          ]}
          akcjaWiersza={(x) => (
            <Pressable
              onPress={() => setSprzetDoUsuniecia(x)}
              hitSlop={8}
              accessibilityLabel={`Usuń ${x.nazwa} z katalogu`}
              style={styles.usunSprzet}>
              <Ionicons
                name="trash-outline"
                size={16}
                color={x.w_przepisach === 0 ? motyw.textSecondary : motyw.accent}
              />
            </Pressable>
          )}
          stopka={(fraza) => (
            <View style={styles.dopisywanieSprzetu}>
              <Pole
                etykieta="Nie ma na liście? Dopisz do katalogu"
                value={nowySprzet || fraza}
                onChangeText={setNowySprzet}
                placeholder="szybkowar 6 l"
              />
              <Przycisk
                tytul="Dopisz sprzęt"
                wariant="poboczny"
                onPress={async () => {
                  const nazwa = (nowySprzet || fraza).trim().replace(/\s+/g, ' ');
                  if (!nazwa) return;

                  // Jeśli taka pozycja już jest — tylko ją zaznaczamy.
                  // Katalog rozróżniał wielkość liter, więc „Deska” i „deska”
                  // tworzyły dwa wpisy tego samego narzędzia.
                  const istniejacy = katalogSprzetu.find(
                    (x) => x.nazwa.toLowerCase() === nazwa.toLowerCase()
                  );
                  if (istniejacy) {
                    setSprzet((p) =>
                      p.includes(istniejacy.nazwa) ? p : [...p, istniejacy.nazwa]
                    );
                    setNowySprzet('');
                    return;
                  }

                  const { data, error } = await supabase
                    .from('sprzet')
                    .insert({ nazwa })
                    .select('id, nazwa, rodzaj')
                    .single();
                  if (error) {
                    setBlad(komunikatBledu(error));
                    return;
                  }
                  setKatalogSprzetu((p) =>
                    [...p, { ...data, w_przepisach: 0, przepisy: [] }].sort((a, b) =>
                      a.nazwa.localeCompare(b.nazwa, 'pl')
                    )
                  );
                  setSprzet((p) => [...p, data.nazwa]);
                  setNowySprzet('');
                }}
              />
            </View>
          )}
        />
      </Karta>

      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          ETAPY PRZYGOTOWANIA
        </ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Każdy etap ma nazwę, czas i własne kroki — na przykład „Gotowanie wywaru, 45 minut”.
          Krok można oznaczyć jako uwagę, gdy ostrzega przed pomyłką.
        </ThemedText>

        {etapy.map((etap, i) => (
          <View key={i} style={[styles.etap, { borderColor: motyw.border }]}>
            <View style={styles.naglowekEtapu}>
              <ThemedText type="smallBold" themeColor="accent">
                ETAP {i + 1}
              </ThemedText>

              <View style={styles.przyciskiEtapu}>
                <Pressable
                  onPress={() => przesunEtap(i, -1)}
                  disabled={i === 0}
                  hitSlop={6}
                  accessibilityLabel="Przesuń etap wyżej">
                  <Ionicons
                    name="arrow-up"
                    size={18}
                    color={i === 0 ? motyw.border : motyw.textSecondary}
                  />
                </Pressable>
                <Pressable
                  onPress={() => przesunEtap(i, 1)}
                  disabled={i === etapy.length - 1}
                  hitSlop={6}
                  accessibilityLabel="Przesuń etap niżej">
                  <Ionicons
                    name="arrow-down"
                    size={18}
                    color={i === etapy.length - 1 ? motyw.border : motyw.textSecondary}
                  />
                </Pressable>
                <Pressable
                  onPress={() => wstawEtap(i)}
                  hitSlop={6}
                  accessibilityLabel="Wstaw etap poniżej">
                  <Ionicons name="add-circle-outline" size={18} color={motyw.accent} />
                </Pressable>

                <Pressable onPress={() => usunEtap(i)} hitSlop={6} accessibilityLabel="Usuń etap">
                  <Ionicons name="trash-outline" size={18} color={motyw.textSecondary} />
                </Pressable>
              </View>
            </View>

            <Pole
              etykieta="Nazwa etapu"
              value={etap.nazwa}
              onChangeText={(t) => zmienEtap(i, 'nazwa', t)}
              placeholder="Gotowanie wywaru"
            />
            <Pole
              etykieta="Czas etapu (min)"
              value={etap.minuty}
              onChangeText={(t) => zmienEtap(i, 'minuty', t)}
              inputMode="numeric"
              placeholder="45"
            />

            {etap.kroki.map((krok, j) => (
              <View key={j} style={styles.krok}>
                <View style={styles.naglowekKroku}>
                  <ThemedText type="small" themeColor="textSecondary">
                    Krok {j + 1}
                  </ThemedText>

                  <Pressable
                    onPress={() => przesunKrok(i, j, -1)}
                    disabled={j === 0}
                    hitSlop={6}
                    accessibilityLabel="Przesuń krok wyżej">
                    <Ionicons
                      name="arrow-up"
                      size={15}
                      color={j === 0 ? motyw.border : motyw.textSecondary}
                    />
                  </Pressable>

                  <Pressable
                    onPress={() => przesunKrok(i, j, 1)}
                    disabled={j === etap.kroki.length - 1}
                    hitSlop={6}
                    accessibilityLabel="Przesuń krok niżej">
                    <Ionicons
                      name="arrow-down"
                      size={15}
                      color={j === etap.kroki.length - 1 ? motyw.border : motyw.textSecondary}
                    />
                  </Pressable>

                  <Pressable
                    onPress={() => wstawKrok(i, j)}
                    hitSlop={6}
                    accessibilityLabel="Wstaw krok poniżej">
                    <Ionicons name="add-circle-outline" size={16} color={motyw.accent} />
                  </Pressable>

                  <Pressable
                    onPress={() => zmienKrok(i, j, { uwaga: !krok.uwaga })}
                    hitSlop={6}
                    accessibilityRole="checkbox"
                    accessibilityState={{ checked: krok.uwaga }}
                    style={styles.przelacznikUwagi}>
                    <Ionicons
                      name={krok.uwaga ? 'warning' : 'warning-outline'}
                      size={16}
                      color={krok.uwaga ? motyw.accent : motyw.textSecondary}
                    />
                    <ThemedText type="small" themeColor={krok.uwaga ? 'accent' : 'textSecondary'}>
                      uwaga
                    </ThemedText>
                  </Pressable>

                  <Pressable onPress={() => usunKrok(i, j)} hitSlop={6} accessibilityLabel="Usuń krok">
                    <Ionicons name="close" size={16} color={motyw.textSecondary} />
                  </Pressable>
                </View>

                <Pole
                  etykieta=""
                  value={krok.tresc}
                  onChangeText={(t) => zmienKrok(i, j, { tresc: t })}
                  placeholder="Doprowadź do wrzenia i zbierz szumowiny"
                  multiline
                />
                <Pole
                  etykieta="Po czym poznać, że gotowe (nieobowiązkowe)"
                  value={krok.sygnal}
                  onChangeText={(t) => zmienKrok(i, j, { sygnal: t })}
                  placeholder="aż ziemniaki będą miękkie"
                />
              </View>
            ))}

            <Przycisk tytul="Dodaj krok na końcu" wariant="poboczny" onPress={() => wstawKrok(i)} />
          </View>
        ))}

        <Przycisk
          tytul={etapy.length === 0 ? 'Dodaj pierwszy etap' : 'Dodaj etap na końcu'}
          wariant="poboczny"
          onPress={() => wstawEtap()}
        />

        {czasRazem > 0 && (
          <ThemedText type="small" themeColor="textSecondary">
            Czas wszystkich etapów: {czasRazem} min. Jeśli etapy się nakładają („w międzyczasie”),
            faktyczny czas będzie krótszy.
          </ThemedText>
        )}
      </Karta>
      <Karta style={styles.grupa}>
        <ThemedText type="smallBold" themeColor="textSecondary">
          PRZECHOWYWANIE I WSKAZÓWKI
        </ThemedText>

        <Pole
          etykieta="Jak przechowywać"
          value={przechowywanie}
          onChangeText={setPrzechowywanie}
          placeholder="W lodówce w zamkniętym pojemniku, odgrzewać pod przykryciem"
          multiline
        />

        <Wybor
          etykieta="Czy nadaje się do mrożenia"
          wybrana={moznaMrozic}
          onZmiana={setMoznaMrozic}
          opcje={[
            { wartosc: 'tak', etykieta: 'Tak' },
            { wartosc: 'nie', etykieta: 'Nie' },
            { wartosc: 'nie wiem', etykieta: 'Nie wiem' },
          ]}
        />

        <Pole
          etykieta="Jak uratować danie w razie wpadki"
          value={ratunek}
          onChangeText={setRatunek}
          placeholder="Za kwaśne — dodaj ziemniaka i pogotuj. Za słone — dolej wody i śmietany."
          multiline
        />
      </Karta>


      {blad && (
        <ThemedText type="small" themeColor="accent">
          {blad}
        </ThemedText>
      )}

      {/*
        Zgoda na publikację jest ŚWIADOMYM ptaszkiem, nie domyślnym ustawieniem.
        Przepis to własna praca autora — nikt nie powinien odkryć po fakcie,
        że jego danie stoi w otwartym katalogu.
      */}
      {widocznosc !== 'publiczna' && (
        <Karta style={styles.grupa}>
          <ThemedText type="smallBold" themeColor="textSecondary">
            PUBLIKACJA
          </ThemedText>

          {powodOdrzucenia && (
            <View style={[styles.uwagaModeratora, { borderLeftColor: motyw.accent }]}>
              <ThemedText type="smallBold" themeColor="accent">
                Moderator odesłał przepis do poprawki
              </ThemedText>
              <ThemedText type="small">{powodOdrzucenia}</ThemedText>
            </View>
          )}

          <Pressable
            onPress={() => setDoPublikacji((x) => !x)}
            accessibilityRole="checkbox"
            accessibilityState={{ checked: doPublikacji }}
            style={({ pressed }) => [
              styles.zgoda,
              { borderColor: doPublikacji ? motyw.accent : motyw.border },
              pressed && styles.wcisniety,
            ]}>
            <Ionicons
              name={doPublikacji ? 'checkbox' : 'square-outline'}
              size={22}
              color={doPublikacji ? motyw.accent : motyw.textSecondary}
            />
            <View style={styles.trescZgody}>
              <ThemedText type="default" themeColor={doPublikacji ? 'accent' : 'text'}>
                Zgadzam się na upublicznienie tego przepisu
              </ThemedText>
              <ThemedText type="small" themeColor="textSecondary">
                Po zapisaniu trafi do moderatora. Zatwierdzony stanie się widoczny dla
                wszystkich i od tej chwili zmieni go już tylko moderator. Do tego czasu
                możesz wycofać zgłoszenie, odznaczając to pole.
              </ThemedText>
            </View>
          </Pressable>

          {widocznosc === 'zgloszona' && (
            <ThemedText type="small" themeColor="textSecondary">
              Przepis czeka na rozpatrzenie.
            </ThemedText>
          )}
        </Karta>
      )}

      {widocznosc === 'publiczna' && (
        <Karta>
          <ThemedText type="small" themeColor="textSecondary">
            Przepis jest publiczny — widzą go wszyscy. Zmiany w opublikowanym przepisie
            wprowadza moderator.
          </ThemedText>
        </Karta>
      )}

      <ThemedText type="small" themeColor="textSecondary">
        {tryb === 'edycja'
          ? 'Zmiany nadpiszą dotychczasową treść przepisu.'
          : 'Przepis zapisze się jako prywatny.'} Publikacja wymaga zgłoszenia i zatwierdzenia.
      </ThemedText>

      <Przycisk
        tytul={tryb === 'edycja' ? 'Zapisz zmiany' : 'Zapisz przepis'}
        onPress={zapisz}
        zajety={zajety}
        wylaczony={!komplet}
      />
      <Przycisk tytul="Anuluj" wariant="poboczny" onPress={() => wroc(powrot, '/przepisy')} />
    </Ekran>
  );
}

const styles = StyleSheet.create({
  grupa: { gap: Spacing.three },
  przyciskiSkladnikow: { flexDirection: 'row', flexWrap: 'wrap', gap: Spacing.two },
  zgoda: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: Spacing.two,
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
  },
  trescZgody: { flex: 1, gap: Spacing.one },
  uwagaModeratora: {
    borderLeftWidth: 3,
    paddingLeft: Spacing.two,
    paddingVertical: Spacing.one,
    gap: Spacing.one,
  },
  lista: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  podpowiedz: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    padding: Spacing.two,
    borderBottomWidth: 1,
  },
  trescPodpowiedzi: { flex: 1, gap: 2 },
  wcisniety: { opacity: 0.7 },
  skladnik: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
  },
  naglowekSkladnika: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  nazwaSkladnika: { flex: 1 },
  wiersz: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.two,
    paddingTop: Spacing.half,
  },
  etap: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    padding: Spacing.two,
    gap: Spacing.two,
  },
  naglowekEtapu: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  przyciskiEtapu: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.three,
  },
  krok: {
    gap: Spacing.one,
    paddingTop: Spacing.one,
  },
  naglowekKroku: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    gap: Spacing.two,
  },
  przelacznikUwagi: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.one,
    marginLeft: 'auto',
  },
  wierszMetryczki: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.two,
    borderBottomWidth: 1,
    paddingVertical: Spacing.one,
  },
  etykietaMetryczki: { flex: 1 },
  poleMetryczki: {
    width: 90,
    borderWidth: 1,
    borderRadius: Spacing.one,
    paddingHorizontal: Spacing.two,
    paddingVertical: 4,
    fontSize: 15,
    textAlign: 'right',
    minHeight: 34,
  },
  jednostkaMetryczki: { width: 48 },
  dopisywanieSprzetu: { gap: Spacing.two, paddingTop: Spacing.two },
  usunSprzet: {
    width: 34,
    alignItems: 'center',
    justifyContent: 'center',
    alignSelf: 'stretch',
  },
  tabelaWybranych: {
    borderWidth: 1,
    borderRadius: Spacing.two,
    overflow: 'hidden',
  },
  wierszWybranego: {
    flexDirection: 'row',
    alignItems: 'center',
    borderBottomWidth: 1,
    paddingHorizontal: Spacing.one,
    paddingVertical: Spacing.one,
    gap: Spacing.one,
    minHeight: 42,
  },
  naglowekWybranych: { borderBottomWidth: 2 },
  kolNazwa: { flex: 3, paddingHorizontal: Spacing.one },
  kolIlosc: { width: 70 },
  kolJednostka: { width: 44, alignItems: 'center', justifyContent: 'center' },
  kolGramy: { width: 72, textAlign: 'right' },
  kolStan: { flex: 2 },
  kolRola: { width: 100 },
  kolKwant: { width: 90 },
  kolUsun: { width: 32, alignItems: 'center', justifyContent: 'center' },
  polePozycji: {
    borderWidth: 1,
    borderRadius: Spacing.one,
    paddingHorizontal: Spacing.one,
    paddingVertical: 2,
    fontSize: 14,
    minHeight: 30,
    textAlign: 'right',
  },
  okienko: {
    gap: Spacing.two,
    paddingTop: Spacing.two,
  },
});
