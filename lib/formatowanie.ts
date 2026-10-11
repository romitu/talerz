/**
 * Proste formatowanie tekstu przepisu znacznikami jak w Markdownie:
 * `**pogrubienie**`, `*kursywa*`, `***pogrubiona kursywa***`.
 *
 * W bazie i w formularzu tekst trzyma gwiazdki; ekrany pokazują go już
 * sformatowanego (komponent `TekstFormatowany`), a wyszukiwanie porównuje
 * tekst bez znaczników (`bezZnacznikow`).
 *
 * Znacznik działa tylko w parze i tylko „przyklejony” do treści — samotna
 * gwiazdka czy „2 * 3” zostają zwykłym tekstem.
 */

export type Fragment = { tekst: string; pogrubienie: boolean; kursywa: boolean };

const ZNACZNIK =
  /\*\*\*(?!\s)(.+?)(?<!\s)\*\*\*|\*\*(?!\s)(.+?)(?<!\s)\*\*|\*(?![\s*])(.+?)(?<![\s*])\*(?!\*)/gs;

export function rozbijFormatowanie(
  tekst: string,
  pogrubienie = false,
  kursywa = false,
): Fragment[] {
  const wynik: Fragment[] = [];
  let od = 0;
  for (const m of tekst.matchAll(ZNACZNIK)) {
    if (m.index > od) wynik.push({ tekst: tekst.slice(od, m.index), pogrubienie, kursywa });
    if (m[1] !== undefined) wynik.push(...rozbijFormatowanie(m[1], true, true));
    else if (m[2] !== undefined) wynik.push(...rozbijFormatowanie(m[2], true, kursywa));
    else wynik.push(...rozbijFormatowanie(m[3], pogrubienie, true));
    od = m.index + m[0].length;
  }
  if (od < tekst.length) wynik.push({ tekst: tekst.slice(od), pogrubienie, kursywa });
  return wynik;
}

export function bezZnacznikow(tekst: string): string {
  return rozbijFormatowanie(tekst)
    .map((f) => f.tekst)
    .join('');
}
