import { Ionicons } from '@expo/vector-icons';
import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, StyleSheet, View } from 'react-native';

import { ThemedText } from './themed-text';

import { useTheme } from '@/hooks/use-theme';
import type { Widocznosc } from '@/lib/przepisy';

const IKONA: Record<Widocznosc, keyof typeof Ionicons.glyphMap> = {
  publiczna: 'earth',
  prywatna: 'lock-closed-outline',
  zgloszona: 'hourglass-outline',
};

/**
 * Znaczek widoczności przepisu (publiczny / prywatny / zgłoszony).
 *
 * Działa jak `ZnaczekZrodla` z kafla zakupów: na stałe widać tylko ikonę,
 * opis pokazuje dymek po najechaniu myszką albo po dotknięciu (na telefonie
 * chowa się sam po chwili).
 *
 * `onPrzelacz` — moderator przełącza publiczny/prywatny dotknięciem; dymek
 * pokazuje się wtedy tylko po najechaniu, bo dotknięcie zmienia status.
 *
 * `naZdjeciu` — w prawym górnym rogu zdjęcia, na jasnym półprzezroczystym
 * tle, żeby był czytelny na każdym zdjęciu. Bez zdjęcia stoi przy nazwie.
 */
export function ZnaczekWidocznosci({
  widocznosc,
  onPrzelacz,
  naZdjeciu = false,
}: {
  widocznosc: Widocznosc;
  onPrzelacz?: () => void;
  naZdjeciu?: boolean;
}) {
  const { t } = useTranslation();
  const motyw = useTheme();
  const [widoczny, setWidoczny] = useState(false);

  useEffect(() => {
    if (!widoczny) return;
    const minutnik = setTimeout(() => setWidoczny(false), 2500);
    return () => clearTimeout(minutnik);
  }, [widoczny]);

  const tytul = t(`widocznoscOpis.${widocznosc}.tytul`);
  const opis = t(`widocznoscOpis.${widocznosc}.opis`);
  const kolor = widocznosc === 'publiczna' ? motyw.accent : '#4b514e';

  return (
    <View style={naZdjeciu ? styles.rogZdjecia : styles.przyNazwie}>
      {widoczny && (
        <View style={styles.dymek} pointerEvents="none">
          <ThemedText style={styles.dymekTytul}>{tytul}</ThemedText>
          <ThemedText style={styles.dymekOpis}>{opis}</ThemedText>
          {onPrzelacz && <ThemedText style={styles.dymekOpis}>{t('widocznoscOpis.zmien')}</ThemedText>}
        </View>
      )}
      <Pressable
        onPress={onPrzelacz ?? (() => setWidoczny((w) => !w))}
        onHoverIn={() => setWidoczny(true)}
        onHoverOut={() => setWidoczny(false)}
        hitSlop={6}
        accessibilityRole="button"
        accessibilityLabel={onPrzelacz ? `${tytul}. ${t('widocznoscOpis.zmien')}` : tytul}
        style={({ pressed }) => [styles.znaczek, pressed && styles.wcisniety]}>
        <Ionicons name={IKONA[widocznosc]} size={12} color={kolor} />
      </Pressable>
    </View>
  );
}

const styles = StyleSheet.create({
  rogZdjecia: {
    position: 'absolute',
    top: 6,
    right: 6,
  },
  przyNazwie: {},
  // Ten sam rozmiar i tło co `ZnaczekZrodla` w lewym dolnym rogu zdjęcia.
  znaczek: {
    minWidth: 24,
    height: 20,
    paddingHorizontal: 5,
    borderRadius: 4,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'rgba(255,255,255,0.75)',
  },
  wcisniety: { opacity: 0.6 },
  dymek: {
    position: 'absolute',
    top: 26,
    right: 0,
    width: 200,
    padding: 6,
    borderRadius: 6,
    backgroundColor: '#ffffff',
    boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
    zIndex: 10,
  },
  dymekTytul: { fontSize: 12, lineHeight: 15, fontWeight: '600', color: '#203047' },
  dymekOpis: { fontSize: 10, lineHeight: 13, color: '#596675' },
});
