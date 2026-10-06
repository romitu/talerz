import { supabase } from './supabase';

/**
 * Składniki, których konto nie je (migracja 0049, tabela `wykluczone_skladniki`).
 *
 * To trwała reguła, a nie jednorazowe oznaczenie przepisów: które dania
 * odpadają, liczy się przy każdym wczytaniu przepisów (`pobierzPrzepisy`),
 * więc nowy przepis z jajkiem odpada sam, bez niczyjej pomocy.
 */
export type WykluczonySkladnik = { skladnik_id: string; nazwa: string };

/** Wykluczenia zalogowanego konta — reguły w bazie i tak nie pokażą cudzych. */
export async function pobierzWykluczone(): Promise<WykluczonySkladnik[]> {
  const { data, error } = await supabase
    .from('wykluczone_skladniki')
    .select('skladnik_id, skladniki (nazwa)');
  if (error) throw error;

  return (data ?? [])
    .map((w) => ({
      skladnik_id: w.skladnik_id as string,
      nazwa: (w.skladniki as unknown as { nazwa: string } | null)?.nazwa ?? '',
    }))
    .sort((a, b) => a.nazwa.localeCompare(b.nazwa, 'pl'));
}

/**
 * Mapa przepis → nazwy wykluczonych składników, które zawiera. Przepisów
 * „czystych” w mapie nie ma.
 */
export async function przepisyZWykluczonymi(): Promise<Map<string, string[]>> {
  const wykluczone = await pobierzWykluczone();
  const mapa = new Map<string, string[]>();
  if (wykluczone.length === 0) return mapa;

  const nazwy = new Map(wykluczone.map((w) => [w.skladnik_id, w.nazwa]));
  const { data, error } = await supabase
    .from('przepis_skladniki')
    .select('przepis_id, skladnik_id')
    .in('skladnik_id', [...nazwy.keys()]);
  if (error) throw error;

  for (const ps of data ?? []) {
    const nazwa = nazwy.get(ps.skladnik_id as string);
    if (!nazwa) continue;
    mapa.set(ps.przepis_id as string, [...(mapa.get(ps.przepis_id as string) ?? []), nazwa]);
  }
  return mapa;
}

export async function ustawWykluczony(
  kontoId: string,
  skladnikId: string,
  wykluczony: boolean
): Promise<void> {
  if (!wykluczony) {
    const { error } = await supabase
      .from('wykluczone_skladniki')
      .delete()
      .eq('konto_id', kontoId)
      .eq('skladnik_id', skladnikId);
    if (error) throw error;
    return;
  }

  const { error } = await supabase
    .from('wykluczone_skladniki')
    .upsert(
      { konto_id: kontoId, skladnik_id: skladnikId },
      { onConflict: 'konto_id,skladnik_id' }
    );
  if (error) throw error;
}
