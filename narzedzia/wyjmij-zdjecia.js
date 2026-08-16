/* ===========================================================================
   TALERZ — wyjęcie zdjęć ze starego planera
   ===========================================================================

   JAK UŻYĆ
   --------
   1. Otwórz w przeglądarce swój planer: https://romitu.github.io/dieta/
      Poczekaj, aż strona się wczyta i pokaże dania.

   2. Naciśnij F12. Otworzy się panel narzędzi. Przejdź na zakładkę
      "Console" (albo "Konsola").

   3. Chrome i Edge przy pierwszym wklejeniu każą wpisać "allow pasting"
      i nacisnąć Enter. To zabezpieczenie przed oszustami — tutaj jest
      nieszkodliwe, bo wklejasz własny kod.

   4. Skopiuj CAŁĄ zawartość tego pliku poniżej linii z gwiazdkami,
      wklej do konsoli i naciśnij Enter.

   5. Przeglądarka pobierze plik "zdjecia-planera.json".
      Wrzuć go do folderu projektu i daj mi znać.

   CO TO ROBI
   ----------
   Zagląda w dwa miejsca i skleja wynik:
     * do Twojej bazy Firebase — tam są zdjęcia dodane z telefonu,
     * do pamięci tej przeglądarki — tam są te dodane na tym komputerze.

   Jeśli któreś źródło zawiedzie, drugie i tak zadziała. Nic nie zmienia
   ani nie kasuje — tylko czyta i zapisuje plik na dysk.

   =========================================================================== */

(async () => {
  const wynik = {};
  const skad = {};

  // --- 1. z Firebase (zdjęcia z telefonu i z komputera) ---------------------
  try {
    const base = typeof fotoBase === 'function' ? fotoBase() : null;
    if (!base) {
      console.warn('Synchronizacja wyłączona — pomijam chmurę.');
    } else {
      const r = await fetch(base + '.json?_=' + Date.now(), { cache: 'no-store' });
      if (!r.ok) throw new Error('HTTP ' + r.status);
      const d = await r.json();
      if (d) {
        const poSlugu = new Map([...SLUG].map(([nazwa, slug]) => [slug, nazwa]));
        for (const [slug, url] of Object.entries(d)) {
          const nazwa = poSlugu.get(slug);
          if (nazwa && typeof url === 'string' && url.startsWith('data:')) {
            wynik[nazwa] = url;
            skad[nazwa] = 'chmura';
          }
        }
      }
    }
  } catch (e) {
    console.warn('Nie udało się pobrać z chmury:', e.message);
  }

  // --- 2. z pamięci tej przeglądarki ---------------------------------------
  try {
    const d = JSON.parse(localStorage.getItem('planer-foto-v1') || 'null');
    if (d) {
      for (const [nazwa, url] of Object.entries(d)) {
        if (typeof url === 'string' && url.startsWith('data:') && !wynik[nazwa]) {
          wynik[nazwa] = url;
          skad[nazwa] = 'ta przeglądarka';
        }
      }
    }
  } catch (e) {
    console.warn('Nie udało się odczytać pamięci przeglądarki:', e.message);
  }

  // --- 3. wynik -------------------------------------------------------------
  const nazwy = Object.keys(wynik).sort();
  if (nazwy.length === 0) {
    console.log('%cNie znalazłem żadnych zdjęć.', 'color:#C2612F;font-weight:bold');
    console.log('Ani w chmurze, ani w pamięci tej przeglądarki.');
    console.log('Sprawdź w Ustawieniach, czy adres bazy i klucz są wpisane.');
    return;
  }

  const tekst = JSON.stringify(wynik, null, 1);
  const mb = (tekst.length / 1024 / 1024).toFixed(2);

  const a = document.createElement('a');
  a.href = URL.createObjectURL(new Blob([tekst], { type: 'application/json' }));
  a.download = 'zdjecia-planera.json';
  document.body.appendChild(a);
  a.click();
  a.remove();

  console.log(`%cZapisano ${nazwy.length} zdjęć (${mb} MB) do pliku zdjecia-planera.json`,
    'color:#47694E;font-weight:bold');
  console.table(nazwy.map((n) => ({ danie: n, skąd: skad[n] })));

  const bezZdjecia = [...SLUG.keys()].filter((n) => !wynik[n]);
  if (bezZdjecia.length) {
    console.log(`Bez zdjęcia zostało ${bezZdjecia.length} dań:`);
    console.log(bezZdjecia.join('\n'));
  }
})();
