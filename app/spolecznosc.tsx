import { Ekran } from '@/components/ekran';
import { Karta } from '@/components/karta';
import { ThemedText } from '@/components/themed-text';

export default function EkranSpolecznosci() {
  return (
    <Ekran tytul="Społeczność" podtytul="Czat i przepisy innych użytkowników">
      <Karta>
        <ThemedText type="default">Czat — w przygotowaniu</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Wiadomości będą pojawiać się natychmiast u wszystkich uczestników, bez odświeżania
          ekranu. Wymaga podłączenia bazy danych i kont użytkowników.
        </ThemedText>
      </Karta>

      <Karta>
        <ThemedText type="default">Zanim to uruchomimy</ThemedText>
        <ThemedText type="small" themeColor="textSecondary">
          Aplikacja publiczna z czatem i danymi o zdrowiu wymaga polityki prywatności,
          zgód RODO i sposobu zgłaszania nadużyć. Sklepy Google i Apple sprawdzają to
          przed dopuszczeniem aplikacji. Przygotujemy te dokumenty razem z kodem.
        </ThemedText>
      </Karta>
    </Ekran>
  );
}
