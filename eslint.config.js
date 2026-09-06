// https://docs.expo.dev/guides/using-eslint/
const { defineConfig } = require('eslint/config');
const expoConfig = require('eslint-config-expo/flat');

module.exports = defineConfig([
  expoConfig,
  {
    ignores: ['dist/*'],
  },
  {
    /*
      `eslint-plugin-react-hooks` v7 (przyszło z aktualizacją do SDK 57) włącza
      w "recommended" cały pakiet reguł Reactowego kompilatora, w tym
      `set-state-in-effect`. Ta reguła zakłada świat, w którym komponent
      przechodzi przez React Compiler — a `experiments.reactCompiler` w
      app.json jest u nas ustawione na `false`.

      Bez kompilatora reguła i tak łapie zwykły, poprawny wzorzec „pobierz dane
      przy zamontowaniu/wejściu na ekran": `useEffect(() => { pobierz(); },
      [pobierz])`, gdzie `pobierz` na starcie ustawia `wczytywanie`/`błąd`.
      Tak wygląda pobieranie danych w całej aplikacji (patrz komentarze przy
      `useFocusEffect` w np. `app/przepisy.tsx`) — przepisanie tego na wzorzec
      bez efektu wymagałoby biblioteki do pobierania danych (np. React Query),
      czego ten projekt nie używa. Wyłączone świadomie, nie przeoczone.
    */
    rules: {
      'react-hooks/set-state-in-effect': 'off',
    },
  },
]);
