import { supabase } from './supabase';

/**
 * Listy składników przypisane do konta — dwie tabele o tym samym kształcie
 * (`konto_id`, `skladnik_id`):
 *
 *   wykluczone_skladniki     – „Nie jemy” (migracja 0049): danie z takim
 *                              składnikiem nie trafia do planu w ogóle,
 *   chcemy_wiecej_skladniki  – „Chcemy więcej” (migracja 0051): danie z takim
 *                              składnikiem dostaje premię w automacie.
 *
 * Obie to trwałe reguły, a nie jednorazowe oznaczenie przepisów: które dania
 * zawierają dany składnik, liczy się przy każdym wczytaniu przepisów
 * (`pobierzPrzepisy`), więc nowy przepis z jajkiem albo czarnuszką łapie się
 * sam, bez niczyjej pomocy.
 */
export type ListaSkladnikowKonta = 'wykluczone_skladniki' | 'chcemy_wiecej_skladniki';

export type SkladnikNaLiscie = { skladnik_id: string; nazwa: string };

/** Lista zalogowanego konta — reguły w bazie i tak nie pokażą cudzych. */
export async function pobierzListe(lista: ListaSkladnikowKonta): Promise<SkladnikNaLiscie[]> {
  const { data, error } = await supabase.from(lista).select('skladnik_id, skladniki (nazwa)');
  if (error) throw error;

  return (data ?? [])
    .map((w) => ({
      skladnik_id: w.skladnik_id as string,
      nazwa: (w.skladniki as unknown as { nazwa: string } | null)?.nazwa ?? '',
    }))
    .sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl'));
}

/**
 * Mapa przepis → nazwy składników z listy, które zawiera. Przepisów bez
 * żadnego z nich w mapie nie ma.
 */
export async function przepisyZeSkladnikamiZListy(
  lista: ListaSkladnikowKonta
): Promise<Map<string, string[]>> {
  const naLiscie = await pobierzListe(lista);
  const mapa = new Map<string, string[]>();
  if (naLiscie.length === 0) return mapa;

  const nazwy = new Map(naLiscie.map((w) => [w.skladnik_id, w.nazwa]));
  const { data, error } = await supabase
    .from('przepis_skladniki')
    .select('przepis_id, skladnik_id')
    .in('skladnik_id', [...nazwy.keys()]);
  if (error) throw error;

  for (const ps of data ?? []) {
    const nazwa = nazwy.get(ps.skladnik_id as string);
    if (!nazwa) continue;
    const dotad = mapa.get(ps.przepis_id as string) ?? [];
    // Ten sam składnik dwa razy w przepisie (np. czosnek do sosu i do mięsa)
    // to wciąż jeden składnik z listy — inaczej premia liczyłaby go podwójnie.
    if (!dotad.includes(nazwa)) mapa.set(ps.przepis_id as string, [...dotad, nazwa]);
  }
  return mapa;
}

export async function ustawNaLiscie(
  lista: ListaSkladnikowKonta,
  kontoId: string,
  skladnikId: string,
  naLiscie: boolean
): Promise<void> {
  if (!naLiscie) {
    const { error } = await supabase
      .from(lista)
      .delete()
      .eq('konto_id', kontoId)
      .eq('skladnik_id', skladnikId);
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from(lista)
    .upsert({ konto_id: kontoId, skladnik_id: skladnikId }, { onConflict: 'konto_id,skladnik_id' });
  if (error) throw error;
}
