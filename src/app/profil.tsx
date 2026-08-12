import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';
import { CEL_DNIA } from '@/data/plan';

export default function EkranProfilu() {
  return (
    <Ekran tytul="Profil" podtytul="Twoje cele i konto">
      <Karta>
        <ThemedText type="smallBold" themeColor="textSecondary">
          CELE DZIENNE
        </ThemedText>
        <ThemedText type="small">Kalorie: {CEL_DNIA.kcal} kcal</ThemedText>
        <ThemedText type="small">Białko: {CEL_DNIA.bialko} g</ThemedText>
        <ThemedText type="small">Tłuszcz: {CEL_DNIA.tluszcz} g</ThemedText>
        <ThemedText type="small">Węglowodany: {CEL_DNIA.wegle} g</ThemedText>
      </Karta>

      <Karta>
        <ThemedText type="default">Logowanie — w przygotowaniu</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Konto przez e-mail, Google i Apple. Dzięki temu plan i przepisy będą dostępne
          zarówno na telefonie, jak i w przeglądarce.
        </ThemedText>
      </Karta>
    </Ekran>
  );
}
