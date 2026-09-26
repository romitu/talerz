-- =============================================================================
--  TALERZ — prompt dla AI przygotowującego przepis
-- =============================================================================
--  Zwraca jedną komórkę z gotowym promptem: zasady, format JSON i AKTUALNE
--  listy składników i sprzętu z katalogów. Skopiuj ją do czatu z AI, dopisz
--  na końcu, jakie danie chcesz, a wynik zapisz w narzedzia/przepisy-ai/.
--
--  Listy są zamknięte: AI ma używać wyłącznie tych nazw. Katalog ma zostać
--  zwarty — bez „Noża” obok „Noża szefa kuchni”.
--
--  Wykonanie: SQL Editor w panelu Supabase.
-- =============================================================================

select concat_ws(E'\n',
  'Przygotuj przepis dla aplikacji Talerz jako JEDEN obiekt JSON, bez komentarzy i bez tekstu wokół.',
  '',
  'ZASADY',
  '1. Składniki i sprzęt wybieraj WYŁĄCZNIE z list poniżej. Nazwę przepisz znak w znak.',
  '2. Nie twórz nowych nazw ani wariantów (np. „Nóż” zamiast „Nóż szefa kuchni”). Jeśli czegoś',
  '   naprawdę brakuje, NIE wstawiaj tego do JSON-a — wypisz to osobno pod JSON-em w sekcji',
  '   „BRAKUJE W KATALOGU” z uzasadnieniem, dlaczego żadna pozycja z listy nie wystarcza.',
  '3. Jednostki: g, ml albo szt. Sztuki tylko przy składnikach oznaczonych [szt].',
  '4. Nie podawaj kalorii ani makroskładników — aplikacja liczy je ze składników.',
  '5. Każdy składnik występuje najwyżej raz; ilości tego samego składnika zsumuj.',
  '',
  'FORMAT',
  '{',
  '  "nazwa": "3-120 znaków",',
  '  "opis": "tekst",',
  '  "pory": ["sniadanie" | "obiad" | "kolacja" | "dodatek"],',
  '  "kuchnie": ["srodziemnomorska" | "azjatycka" | "polska" | "inna"],',
  '  "rodzaje": jeden albo dwa z ["zupa" | "salatka" | "makaron" | "kasza_ryz" | "gulasz_curry" | "z_piekarnika" | "kanapki" | "jajka" | "na_slodko"],',
  '  "porcjowanie": "waga" albo "sztuki",',
  '  "porcja_g": liczba całkowita 20-2000 — TYLKO przy "waga", równa masie składników / liczbie porcji,',
  '  "porcje": liczba całkowita 1-30 — TYLKO przy "sztuki",',
  '  "trwalosc_dni": 0-3 (0 = tylko na świeżo),',
  '  "czas_przygotowania_min": 1-1440 (praca przy blacie),',
  '  "czas_obrobki_min": 0-1440 (garnek, piekarnik; 0 = danie na zimno),',
  '  "sprzet": ["nazwy z listy SPRZĘT"],',
  '  "przechowywanie": "w czym trzymać, jak odgrzewać",',
  '  "mozna_mrozic": true albo false,',
  '  "ratunek": "co zrobić, gdy danie wyjdzie za słone, za rzadkie itp.",',
  '  "skladniki": [',
  '    { "nazwa": "z listy SKŁADNIKI", "ilosc": liczba, "jednostka": "g" | "ml" | "szt",',
  '      "stan": "np. posiekany drobno (opcjonalnie)", "zamiennik": "np. lub mintaj (opcjonalnie)" }',
  '  ],',
  '  "etapy": [',
  '    { "nazwa": "np. Przygotowanie", "minuty": liczba,',
  '      "kroki": [ { "tresc": "instrukcja", "sygnal": "po czym poznać, że się udało (opcjonalnie)",',
  '                   "uwaga": true (opcjonalnie, dla kroku, którego nie wolno przegapić) } ] }',
  '  ]',
  '}',
  '',
  'SKŁADNIKI',
  (select string_agg(
            '- ' || nazwa || case when masa_sztuki_g is not null
                                  then ' [szt, 1 szt = ' || round(masa_sztuki_g) || ' g]' else '' end,
            E'\n' order by nazwa)
     from skladniki),
  '',
  'SPRZĘT',
  (select string_agg('- ' || nazwa, E'\n' order by nazwa) from sprzet),
  '',
  'DANIE, KTÓRE MA POWSTAĆ:',
  ''
) as prompt;
