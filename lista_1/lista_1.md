### Lista 1 (Zapoznanie z podstawowymi funkcjonalnościami frameworka)

1.  **Płótno dla marzeń (Scaffold i AppBar)**
    Każdy obraz potrzebuje płótna. W naszej aplikacji będzie nim Scaffold, który stanowi podstawową strukturę ekranu w Material Design. - W `lib/main.dart` usuń domyślny kod i stwórz własny `StatelessWidget` o nazwie `DreamPlaceScreen`. - W metodzie `build` zwróć `Scaffold`. Ustaw jego `backgroundColor` według uznania. - Dodaj `AppBar` z tytułem (`title`) zawierającym nazwę Twojego wymarzonego miejsca, np. `Text('Santorini, Grecja')`. - Na samej górze dodaj z powrotem main z material appem:

        ```dart
        import "package:flutter/material.dart";

        void main() {
        runApp(const MyApp());
        }

        class MyApp extends StatelessWidget {
            const MyApp({super.key});

            @override
            Widget build(BuildContext context) {
                return MaterialApp(
                    home: DreamPlaceScreen(),
                );
            }
        }
        ```

        - przetestuj aplikację na urządzeniu lub emulatorze

2.  **Obraz wart tysiąca słów (Image i zasoby lokalne)**
    Wizytówka miejsca musi mieć zjawiskowe zdjęcie! Nauczymy się, jak dodawać obrazy, które są częścią naszej aplikacji.

    - Znajdź w internecie zdjęcie swojego wymarzonego miejsca i zapisz je w folderze `assets/images/`.
    - Otwórz plik `pubspec.yaml` i "poinformuj" Fluttera o nowym folderze. W sekcji `flutter` odkomentuj i zmodyfikuj wpis `assets:`, dodając tam ścieżkę do swojego pliku np. `assets/images/santorini.jpg`
    - W `body` Twojego `Scaffold` umieść `Column`. Jako pierwsze dziecko (na liście `children`) dodaj widżet `Image.asset()`, podając ścieżkę do swojego zdjęcia. Użyj właściwości `fit: BoxFit.cover`, aby obraz ładnie wypełnił dostępną przestrzeń.
    - Pamiętaj, że podana ścieżka do obrazka (np. `'assets/images/santorini.jpg'`) jest zwykłym tekstem — stringiem. To coś, czego staramy się unikać w programowaniu z kilku powodów:
      - **Brak bezpieczeństwa typów** – jeśli zrobisz literówkę w ścieżce (np. `'santorini.jpg'`), kompilator niczego nie zauważy. Aplikacja zbuduje się poprawnie, a błąd zauważysz dopiero w czasie działania programu (np. pusty widok lub błąd ładowania).
      - **Brak podpowiedzi składni** – IDE nie zna zawartości folderu `assets`, więc nie zaproponuje poprawnych ścieżek podczas pisania kodu.
      - **Utrudniony refactoring** – gdy przeniesiesz plik do innego folderu, musisz ręcznie poprawić wszystkie miejsca, gdzie użyta była stara ścieżka.
    - Rozwiązanie? Generowanie kodu! Użyjemy popularnej paczki, która automatycznie przeskanuje nasz folder assets i stworzy specjalną klasę z bezpiecznymi, statycznymi odwołaniami do wszystkich naszych zasobów.
    - Zgodnie z instrukcjami na tej [stronie](https://pub.dev/packages/flutter_gen_runner) dodaj paczkę, zapoznaj się z dokumentacją i wygeneruj scieżki do plików. Teraz możesz dodać scieżkę do pliku za pomocą wygenerowanej klasy Assets. Możesz też skorzystać z prezentacji z wykładu.

3.  **Serce Informacji (Padding, Column, Text i TextStyle)**

    - Pod zdjęciem umieścimy najważniejsze informacje: tytuł i krótki opis, który zachęci do odwiedzin.
    - Bezpośrednio pod Image.asset() w Column dodaj widżet Padding. Doda on "oddech" wokół naszego bloku tekstowego. Ustaw padding: const EdgeInsets.all(16.0).
    - Jako dziecko Padding wstaw Column, który pozwoli ułożyć teksty jeden pod drugim. Ustaw w nim crossAxisAlignment: CrossAxisAlignment.start, aby teksty były wyrównane do lewej.
    - Wewnątrz tego Column dodaj:
      - Text z nazwą miejsca (np. "Białe miasteczko Oia"), używając TextStyle do powiększenia czcionki i pogrubienia.
      - SizedBox(height: 8) dla stworzenia małego odstępu.
      - Text z chwytliwym, jednozdaniowym opisem.

4.  **Wakacyjne Atrakcje w Pigułce (Row i Icon)**

    - Przedstawmy graficznie główne atrakcje miejsca za pomocą ikon. Row idealnie nadaje się do układania elementów obok siebie.
    - Pod widżetem Padding dodaj Row. Ustaw mainAxisAlignment: MainAxisAlignment.spaceEvenly, aby równomiernie rozłożyć elementy na całej szerokości.
    - Wewnątrz Row umieść 3-4 widżety, z których każdy będzie Columnem.
    - Każdy z tych wewnętrznych Columnów powinien zawierać Icon (np. Icons.wb_sunny, Icons.beach_access, Icons.restaurant) oraz pod spodem Text z opisem (np. "Słońce", "Plaże", "Jedzenie").

5.  **Ożywiamy naszą Aplikację! (StatefulWidget i IconButton)**

    - Na koniec dodajmy trochę życia! Umieścimy w AppBarze przycisk "ulubione", którego stan będzie można zmieniać.
    - Konwersja na StatefulWidget: Kliknij na nazwę klasy DreamPlaceScreen, użyj skrótu Ctrl + . (lub Cmd + .) i wybierz "Convert to StatefulWidget".
    - Dodanie stanu: W nowo powstałej klasie \_DreamPlaceScreenState dodaj zmienną stanu: bool_isFavorited = false;.
    - Funkcja zmiany stanu: Stwórz metodę, która będzie zmieniać wartość \_isFavorited i odświeżać interfejs za pomocą setState:
    - Dodanie przycisku: W AppBar dodaj właściwość actions. Jest to lista widżetów po prawej stronie tytułu. Umieść tam IconButton.
    - W onPressed wywołaj funkcję \_toggleFavorite.
    - W icon użyj operatora warunkowego, aby wyświetlić inną ikonę w zależności od stanu \_isFavorite.

6.  **Parametryzacja widgetu**

    - Zastanów się jak użyć tego widgetu ponownie tylko z innymi danymi (bez przepisywania go od początku)
    - Jeśli ci się udał pierwszy krok spróbuj stworzyć widok na którym jest 5 kafelków ze zdjęciem oraz nazwą miejsca (rozwazyłbym uzycie widgeta ListView oraz do ListTiles) i każdy [przekierowuje](https://docs.flutter.dev/ui/navigation) do ekranu szczegółowego z innymi danymi, który wcześniej stworzyłeś.

7.  **Ostatnie szlify (Dopracowanie interfejsu użytkownika)**
    - Zadbaj o estetykę i spójność wizualną aplikacji:
    - Zastosuj konsekwentną paletę kolorów.
    - Upewnij się, że wszystkie marginesy i odstępy (padding, margin, SizedBox) są odpowiednio dobrane i nie sprawiają wrażenia przypadkowych.
    - Dostosuj czcionki (TextStyle), aby nagłówki, opisy i etykiety były czytelne i estetyczne.
    - Użyj zaokrąglonych krawędzi (BorderRadius) oraz cieni (BoxShadow) dla kontenerów, jeśli pasuje to do stylistyki aplikacji.
    - Jeśli lista miejsc jest przewijalna, zadbaj o płynne przewijanie (ListView) i wizualne oddzielenie kafelków (np. Card, Divider, Padding).
    - Sprawdź responsywność – czy aplikacja dobrze wygląda na różnych rozdzielczościach ekranów.
    - (dla chętnych) Rozważ dodanie animacji lub efektów przejścia (PageRouteBuilder, Hero) przy nawigacji do ekranu szczegółowego.
    - Na koniec uruchom aplikację na emulatorze i upewnij się, że wszystko działa płynnie i bez błędów – to właśnie te detale tworzą wyjątkową jakość aplikacji.
