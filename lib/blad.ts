/**
 * Zamiana błędu na czytelny komunikat.
 *
 * Supabase nie zgłasza wyjątków — zwraca zwykłe obiekty z polami `message`,
 * `details`, `hint` i `code`. Przepuszczone przez String() dają bezużyteczne
 * „[object Object]”, dlatego rozpakowujemy je tutaj, w jednym miejscu.
 */

type BladBazy = {
  message?: string;
  details?: string;
  hint?: string;
  code?: string;
};

export function komunikatBledu(e: unknown): string {
  if (typeof e === 'string') return e;
  if (e instanceof Error) return e.message;

  if (e && typeof e === 'object') {
    const b = e as BladBazy;
    const czesci = [b.message, b.details, b.hint].filter(Boolean);
    if (czesci.length > 0) {
      return czesci.join(' — ') + (b.code ? ` (kod ${b.code})` : '');
    }
    try {
      return JSON.stringify(e);
    } catch {
      return 'Nieznany błąd.';
    }
  }

  return String(e);
}
