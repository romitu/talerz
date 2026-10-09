// Klucze tłumaczeń sprawdzane przez TypeScript — `t('profil.brakProfilu')`
// z literówką nie przejdzie `npm run typecheck`.
import 'i18next';

import type pl from '@/lokalizacja/pl.json';

declare module 'i18next' {
  interface CustomTypeOptions {
    defaultNS: 'translation';
    resources: { translation: typeof pl };
  }
}
