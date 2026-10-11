import { Text } from 'react-native';

import { ThemedText, type ThemedTextProps } from '@/components/themed-text';
import { rozbijFormatowanie } from '@/lib/formatowanie';

/**
 * ThemedText, który zamienia znaczniki `**…**`, `*…*` i `***…***` na
 * pogrubienie i kursywę. Wygląd bazowy (rozmiar, kolor) bez zmian —
 * zagnieżdżone `Text` dziedziczą go po rodzicu.
 */
export function TekstFormatowany({
  children,
  ...rest
}: Omit<ThemedTextProps, 'children'> & { children: string }) {
  return (
    <ThemedText {...rest}>
      {rozbijFormatowanie(children).map((f, i) =>
        f.pogrubienie || f.kursywa ? (
          <Text
            key={i}
            style={{
              fontWeight: f.pogrubienie ? 700 : undefined,
              fontStyle: f.kursywa ? 'italic' : undefined,
            }}>
            {f.tekst}
          </Text>
        ) : (
          f.tekst
        ),
      )}
    </ThemedText>
  );
}
