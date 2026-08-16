// Kontrast wg WCAG 2.1. Próg AA: 4,5:1 dla zwykłego tekstu.
// Palety czytamy z pliku tekstowo — `import` ciągnie za sobą react-native,
// którego Node nie umie wczytać bez budowania.
import { readFileSync } from 'node:fs';
const zrodlo = readFileSync('constants/theme.ts', 'utf8');

function paleta(nazwa, tryb) {
  const blok = zrodlo.slice(zrodlo.indexOf(`const ${nazwa} = {`));
  const czesc = blok.slice(blok.indexOf(`${tryb}: {`));
  const wynik = {};
  for (const m of czesc.slice(0, czesc.indexOf('},')).matchAll(/(\w+): '(#[0-9A-Fa-f]{6})'/g))
    wynik[m[1]] = m[2];
  return wynik;
}
const kanal = (c) => { const s = c / 255; return s <= 0.03928 ? s / 12.92 : Math.pow((s + 0.055) / 1.055, 2.4); };
const jasnosc = (hex) => { const n = parseInt(hex.slice(1), 16);
  return 0.2126 * kanal((n >> 16) & 255) + 0.7152 * kanal((n >> 8) & 255) + 0.0722 * kanal(n & 255); };
const kontrast = (a, b) => { const [x, y] = [jasnosc(a), jasnosc(b)].sort((p, q) => q - p); return (x + 0.05) / (y + 0.05); };

const NAZWY = { porcelana: 'Porcelana', ziola: 'Zioła', wyrazisty: 'Wyrazisty' };
let zle = 0;
for (const s of ['porcelana', 'ziola', 'wyrazisty']) {
  console.log('\n=== ' + NAZWY[s] + ' ===');
  for (const tryb of ['light', 'dark']) {
    const p = paleta(s, tryb);
    for (const [co, a, b] of [
      ['tekst na tle',            p.text,          p.background],
      ['tekst na karcie',         p.text,          p.backgroundElement],
      ['tekst pomocniczy na tle', p.textSecondary, p.background],
      ['tekst pomocniczy/karta',  p.textSecondary, p.backgroundElement],
      ['akcent na karcie',        p.accent,        p.backgroundElement],
      ['tekst na zaznaczeniu',    p.text,          p.backgroundSelected],
    ]) {
      const k = kontrast(a, b);
      const ok = k >= 4.5;
      if (!ok) zle++;
      console.log(`  ${ok ? 'ok  ' : 'ZLE '} ${tryb.padEnd(5)} ${co.padEnd(26)} ${k.toFixed(2)}:1`);
    }
  }
}
console.log('\nPoniżej progu AA (4,5:1): ' + zle);
