### Lista 1 (Podstawy Fluttera)

1. **Scaffold i AppBar**
Scaffold stanowi podstawową strukturę ekranu w Material Design.
    - W `lib/main.dart` usuń domyślny kod i stwórz własny `StatelessWidget` o nazwie `DreamPlaceScreen`.
    - W metodzie `build` zwróć `Scaffold`. Ustaw jego `backgroundColor` według uznania.
    - Dodaj `AppBar` z tytułem (`title`) zawierającym nazwę Twojego wymarzonego miejsca, np. `Text('Santorini, Grecja')`.
    - Na samej górze dodaj z powrotem main z material appem:

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

2. **Image i zasoby lokalne**
    Dodamy zdjęcie miejsca jako lokalny zasób aplikacji.
    - Znajdź w internecie zdjęcie swojego wymarzonego miejsca i zapisz je w folderze `assets/images/`.
    - Otwórz plik `pubspec.yaml` i "poinformuj" Fluttera o nowym folderze. W sekcji `flutter` odkomentuj i zmodyfikuj wpis `assets:`, dodając tam ścieżkę do swojego pliku np. `assets/images/santorini.jpg`
    - W `body` Twojego `Scaffold` umieść `Column`. Jako pierwsze dziecko (na liście `children`) dodaj widżet `Image.asset()`, podając ścieżkę do swojego zdjęcia. Użyj właściwości `fit: BoxFit.cover`, aby obraz ładnie wypełnił dostępną przestrzeń.
    - Na razie wystarczy ścieżka jako string, np. `Image.asset('assets/images/santorini.jpg')`.

3. **Padding, Column, Text i TextStyle**
    - Pod zdjęciem umieścimy tytuł i krótki opis miejsca.
    - Bezpośrednio pod Image.asset() w Column dodaj widżet Padding. Doda on "oddech" wokół naszego bloku tekstowego. Ustaw padding: const EdgeInsets.all(16.0).
    - Jako dziecko Padding wstaw Column, który pozwoli ułożyć teksty jeden pod drugim. Ustaw w nim crossAxisAlignment: CrossAxisAlignment.start, aby teksty były wyrównane do lewej.
    - Wewnątrz tego Column dodaj:
        - Text z nazwą miejsca (np. "Białe miasteczko Oia"), używając TextStyle do powiększenia czcionki i pogrubienia.
        - SizedBox(height: 8) dla stworzenia małego odstępu.
        - Text z chwytliwym, jednozdaniowym opisem.

4. **Row i Icon**
    - Przedstawimy atrakcje miejsca za pomocą ikon ułożonych w rzędzie.
    - Pod widżetem Padding dodaj Row. Ustaw mainAxisAlignment: MainAxisAlignment.spaceEvenly, aby równomiernie rozłożyć elementy na całej szerokości.
    - Wewnątrz Row umieść 3-4 widżety, z których każdy będzie Columnem.
    - Każdy z tych wewnętrznych Columnów powinien zawierać Icon (np. Icons.wb_sunny, Icons.beach_access, Icons.restaurant) oraz pod spodem Text z opisem (np. "Słońce", "Plaże", "Jedzenie").

5. **StatefulWidget i IconButton**
    - W AppBarze dodamy przycisk "ulubione", którego stan będzie można zmieniać.
    - Konwersja na StatefulWidget: Kliknij na nazwę klasy DreamPlaceScreen, użyj skrótu Ctrl + . (lub Cmd + .) i wybierz "Convert to StatefulWidget".
    - Dodanie stanu: W nowo powstałej klasie _DreamPlaceScreenState dodaj zmienną stanu: bool _isFavorited = false;.
    - Funkcja zmiany stanu: Stwórz metodę, która będzie zmieniać wartość _isFavorited i odświeżać interfejs za pomocą setState:
    - Dodanie przycisku: W AppBar dodaj właściwość actions. Jest to lista widżetów po prawej stronie tytułu. Umieść tam IconButton.
    - W onPressed wywołaj funkcję _toggleFavorite.
    - W icon użyj operatora warunkowego, aby wyświetlić inną ikonę w zależności od stanu _isFavorite.

6. **Parametryzacja widgetu**
    - Zastanów się jak użyć tego widgetu ponownie tylko z innymi danymi (bez przepisywania go od początku)
    - Jeśli ci się udał pierwszy krok spróbuj stworzyć widok na którym jest 5 kafelków ze zdjęciem oraz nazwą miejsca (rozważyłbym użycie widgeta ListView oraz ListTile) i każdy [przekierowuje](https://docs.flutter.dev/ui/navigation) do ekranu szczegółowego z innymi danymi, który wcześniej stworzyłeś.
    - Uruchom aplikację na emulatorze i sprawdź, czy wszystko działa poprawnie.

### Dla chętnych

7. **Generowanie ścieżek do assets** (`flutter_gen_runner`)
    - Ścieżka jako string ma wady: brak bezpieczeństwa typów, brak podpowiedzi IDE, trudniejszy refactoring.
    - Zgodnie z instrukcjami na [pub.dev/packages/flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner) dodaj paczkę, wygeneruj ścieżki i użyj wygenerowanej klasy `Assets` zamiast surowego stringa.

8. **Dopracowanie UI**
    - Spójna paleta kolorów, odstępy, czytelne `TextStyle`.
    - Zaokrąglone krawędzie / cienie, jeśli pasują do stylu.
    - Responsywność na różnych rozdzielczościach.
    - (opcjonalnie) animacje przejścia (`PageRouteBuilder`, `Hero`).
