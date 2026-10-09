/**
 * Język aplikacji: napisy, odmiana przez liczby, formatowanie liczb i dat.
 *
 * Jak dodać napis
 * ---------------
 * Tekst trafia do `lokalizacja/pl.json`, a w kodzie ekranu zostaje klucz:
 *
 *     const { t } = useTranslation();
 *     <ThemedText>{t('profil.brakProfilu')}</ThemedText>
 *
 * Literówka w kluczu wychodzi przy `npm run typecheck` (typy w
 * `types/i18next.d.ts` biorą klucze z pl.json).
 *
 * Odmiana przez liczby — „1 rok / 2 lata / 5 lat” — to warianty klucza
 * z końcówkami _one, _few, _many, _other. Wybiera je `t('wspolne.lata',
 * { count: n })` według reguł danego języka; ręcznych warunków `n === 1`
 * nie piszemy, bo w każdym języku reguły są inne.
 *
 * Jak dodać język
 * ---------------
 * 1. Plik `lokalizacja/<kod>.json` z tymi samymi kluczami co pl.json.
 * 2. Wpis w `JEZYKI` i w `resources` poniżej.
 * Wybór języka w profilu pojawi się sam, gdy języków będzie więcej niż jeden.
 *
 * Dlaczego w pamięci urządzenia, a nie w bazie
 * --------------------------------------------
 * Z tego samego powodu co styl (lib/wyglad.tsx): ekran logowania też musi
 * mówić właściwym językiem, a wtedy nie ma jeszcze czyjego ustawienia odczytać.
 */

// Reguły odmiany przez liczby (Intl.PluralRules). Silnik JavaScriptu na
// telefonie nie zawsze je ma — wtedy „22 lata” wyszłoby jako „22 lat”.
// Biblioteka podkłada własne tylko tam, gdzie wbudowanych brakuje.
import 'intl-pluralrules';

import AsyncStorage from '@react-native-async-storage/async-storage';
import { getLocales } from 'expo-localization';
import { createInstance } from 'i18next';
import { initReactI18next } from 'react-i18next';

import pl from '@/lokalizacja/pl.json';

/** Języki, które aplikacja zna. Nazwa zawsze we własnym języku — „English”, nie „angielski”. */
export const JEZYKI = [{ kod: 'pl', nazwa: 'Polski' }] as const;

export type Jezyk = (typeof JEZYKI)[number]['kod'];

const KLUCZ = 'talerz-jezyk';
const DOMYSLNY: Jezyk = 'pl';

function czyJezyk(x: unknown): x is Jezyk {
  return JEZYKI.some((j) => j.kod === x);
}

/** Język telefonu, o ile go znamy — inaczej polski. */
function jezykUrzadzenia(): Jezyk {
  const kod = getLocales()[0]?.languageCode;
  return czyJezyk(kod) ? kod : DOMYSLNY;
}

// Tłumaczenia są wbudowane w aplikację, więc start jest natychmiastowy —
// bez czekania na sieć i bez mignięcia tekstu w złym języku.
const i18n = createInstance();

i18n.use(initReactI18next).init({
  resources: { pl: { translation: pl } },
  lng: jezykUrzadzenia(),
  fallbackLng: DOMYSLNY,
  initAsync: false,
  // React sam zabezpiecza tekst; podwójne escapowanie zamieniłoby „&” w „&amp;”.
  interpolation: { escapeValue: false },
});

// Wybór zapisany wcześniej ma pierwszeństwo przed językiem telefonu.
AsyncStorage.getItem(KLUCZ)
  .then((zapisany) => {
    if (czyJezyk(zapisany) && zapisany !== i18n.language) i18n.changeLanguage(zapisany);
  })
  .catch(() => {
    // Brak dostępu do pamięci nie może wywrócić aplikacji — zostaje język telefonu.
  });

export function ustawJezyk(nowy: Jezyk) {
  i18n.changeLanguage(nowy);
  AsyncStorage.setItem(KLUCZ, nowy).catch(() => {
    // Nie udało się zapamiętać — język i tak działa do końca sesji.
  });
}

/** Bieżący język, np. do `toLocaleDateString`. */
export function jezyk(): Jezyk {
  return czyJezyk(i18n.language) ? i18n.language : DOMYSLNY;
}

/**
 * Liczba z separatorem dziesiętnym właściwym dla języka: „1,25” albo „1.25”.
 *
 * `miejsca` to najwięcej cyfr po przecinku; `stale` wymusza dokładnie tyle
 * (1 → „1,00”). Bez grupowania tysięcy — „12500 g” czyta się w kuchni
 * łatwiej niż „12 500 g”.
 *
 * Ekrany, które nie używają `useTranslation`, nie odświeżą się same po
 * zmianie języka — dopiero przy następnym wejściu. Język zmienia się raz,
 * w profilu, więc to wystarcza.
 */
export function liczbaNaTekst(x: number, miejsca = 2, stale = false): string {
  return new Intl.NumberFormat(jezyk(), {
    minimumFractionDigits: stale ? miejsca : 0,
    maximumFractionDigits: miejsca,
    useGrouping: false,
  }).format(x);
}

/** Data według zwyczaju języka; bez opcji — krótka, np. „9.10.2026”. */
export function data(d: Date | string, opcje?: Intl.DateTimeFormatOptions): string {
  return new Date(d).toLocaleDateString(jezyk(), opcje);
}

export default i18n;
