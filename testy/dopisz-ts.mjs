/**
 * Pozwala testom wczytać pliki z `lib/`, które importują się nawzajem bez
 * rozszerzenia (`from './skalowanie-kalorii'`) — tak jak lubi Metro, a nie
 * lubi Node. Brakujące `.ts` dopisujemy przy rozwiązywaniu ścieżki.
 *
 *     node --experimental-strip-types --import ./testy/dopisz-ts.mjs testy/<plik>.ts
 */
import { registerHooks } from 'node:module';

registerHooks({
  resolve(specifier, context, nextResolve) {
    try {
      return nextResolve(specifier, context);
    } catch (blad) {
      if (blad?.code !== 'ERR_MODULE_NOT_FOUND' || !specifier.startsWith('.')) throw blad;
      return nextResolve(`${specifier}.ts`, context);
    }
  },
});
