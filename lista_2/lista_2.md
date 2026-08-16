## Lista 2 (Zarządzanie stanem aplikacji i routing)

W pierwszej liście ożywiliśmy naszą aplikację za pomocą `StatefulWidget`. To dobra metoda na lokalny stan, ale ma pewne ograniczenia i czasem jest trochę "ciężka" w użyciu. W tej części wprowadzimy nowocześniejsze podejście do stanu — **Flutter Hooks** — które pozwala pisać bardziej zwięzły i czytelny kod.

Następnie zajmiemy się problemem globalnego stanu, czyli tego, który chcemy udostępnić w wielu miejscach aplikacji. Poznamy **Riverpod** do zarządzania globalnym stanem oraz **GoRouter** do deklaratywnego routing’u.


### Teoria — Hooki we Flutterze

**Dlaczego hooki?**

* Pozwalają zarządzać stanem w `HookWidget` bez tworzenia osobnej klasy stanu (`StatefulWidget`).
* Kod jest krótszy i bardziej czytelny.
* Dostępne są gotowe hooki, np. `useEffect`, `useAnimationController`, `useTextEditingController`.

**Podstawy użycia:**

* Importujemy pakiet `flutter_hooks`.
* Zamiast `StatefulWidget` tworzymy `HookWidget`.
* Stan przechowujemy np. w `useState()`.

### 1. Zadanie do wykonania

1. Dodaj do pliku `pubspec.yaml` zależność:

   ```yaml
   dependencies:
     flutter_hooks: <najnowsza_wersja>
   ```
2. W ekranie `DreamPlaceScreen`:

   * Zmień go na `HookWidget`.
   * Utwórz stan `isFavorited` za pomocą `useState(false)`.
   * Dodaj ikonę serca w `AppBar`, która po kliknięciu:

     * przełącza `isFavorited` między `true` a `false`
     * zmienia ikonę między `Icons.favorite` a `Icons.favorite_border`
     * ustawia kolor na czerwony, gdy jest ulubione.
3. Resztę ekranu (`body`) pozostaw bez zmian.

### Problem: "Prop Drilling" (przekazywanie stanu przez wiele widgetów)

* Gdy nasza aplikacja rośnie, często potrzebujemy udostępnić stan wielu widgetom.
* Przekazywanie przez wiele warstw widgetów danych i funkcji staje się uciążliwe i utrudnia konserwację.

###  Historyczne rozwiązanie: `InheritedWidget`

* Flutter oferuje `InheritedWidget` do udostępniania danych całemu poddrzewu widgetów.
* Mechanizm ten stosowany jest np. w `Theme.of(context)` czy `MediaQuery.of(context)`.
* Jest jednak dość skomplikowany w użyciu — wymaga napisania dodatkowego kodu (statyczna metoda `of`, `updateShouldNotify`).
* Dla prostych przypadków jest to ok, ale przy bardziej skomplikowanych stanach i wielu providerach staje się trudny do utrzymania.

### 2. Zadanie do wykonania

* Dla chętnych - zaimplementować rozwiązanie zarządzania stanem za pomocą `InheritedWidget`

### Nowoczesne zarządzanie stanem: Riverpod

#### Czym jest Riverpod?

* Riverpod to nowoczesny, bezpieczny i elastyczny system zarządzania stanem.
* Działa globalnie i pozwala na łatwy dostęp i modyfikację stanu z dowolnego miejsca aplikacji — bez przekazywania przez widgety.

### 3. Zadanie do wykoniania

**Zamień dotychczasowy spsób zarządzania stanem na riverpod**

Konfiguracja i działanie bibliteki szczegółowo opisana w dokumentacji [Riverpod](https://riverpod.dev/docs/introduction/getting_started)

* Częsty błąd - pamiętaj aby owinąć aplikacje w `ProviderScope`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
```
Jeśli tego nie zrobisz wszystkie następne wykonane kroki nie będą działać poprawnie.

#### Refaktoryzacja stanu ulubionych do Riverpoda

* Stwórz plik `lib/features/favorite/favorite_provider.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_provider.g.dart';

@riverpod
class Favorite extends _$Favorite {
  @override
  bool build() {
    return false; // stan początkowy
  }

  void toggle() { // metoda pozwaląca zmienić stan providera
    state = !state;
  }
}
```

* Uruchom generator kodu:

```bash
flutter pub run build_runner build -d
```

* W `dream_place_screen.dart` użyj `ConsumerWidget` i providera:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/favorite/favorite_provider.dart';

class DreamPlaceScreen extends ConsumerWidget {
  const DreamPlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorited = ref.watch(favoriteProvider); // obserwujemy stan providera, przy jego zmianie metoda build widgeta uruchomi się jeszcze raz odświerzając nam ui z nowym jej stanem

    return Scaffold(
      appBar: AppBar(
        title: const Text('Santorini, Grecja'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(favoriteProvider.notifier).toggle(); // tutaj odczytujemy jednorazowo stan notifiera ponieważ nie chcemy nasłuchiwać zmian na obiekcie do zarządzania stanem
            },
            icon: Icon(
              isFavorited ? Icons.favorite : Icons.favorite_border,
              color: isFavorited ? Colors.red : null,
            ),
          ),
        ],
      ),
      // reszta body...
    );
  }
}
```

### 4. Globalny stan i nawigacja z GoRouter

* Riverpod świetnie działa z routingiem, a do nawigacji użyjemy **go\_router** — narzędzia rekomendowanego przez zespół Fluttera.


#### 4.1. Model i źródło danych z Riverpod (code generation)

Zamiast trzymać dane „na sztywno” w ekranie, stworzymy model i globalne źródło danych.

* Stwórz model `Place`:

```dart
class Place {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
```

* Stwórz plik `lib/features/places/places_provider.dart`:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'place.dart';

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(id: '1', title: 'Santorini, Grecja', description: 'Białe domki nad morzem'),
  Place(id: '2', title: 'Kioto, Japonia', description: 'Świątynie i ogrody'),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
```

Uruchom generator kodu:

```bash
dart run build_runner build -d
```

Teraz masz automatycznie wygenerowany `placesProvider`.

#### 4.2. Konfiguracja `go_router`

W pliku `lib/app_router.dart`:

```dart
final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '${DetailsScreen.route}/:id', // dynamiczny parametr
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return DetailsScreen(id: id);
      },
    ),
  ],
);
```

### 4.3. Ekran główny i nawigacja

Na ekranie głównym ustaw callback kliknięcia w kafelek na 

```dart
GoRouter.of(context).push("${DetailsScreen.route}/$id");
```

aby przekierować do strony z detalami miejsca.

### 4.4 Wykorzystaj provider

Na obu ekranach zaobserwuj wygenerowany placesProvider oraz użyj metody `toggle(String id)` aby zmienić jego stan w ekranie szczegółów.

### 4.5. Uruchom i sprawdź

1. Uruchom aplikację.
2. Na ekranie głównym widać listę miejsc z ikonami serca.
3. Kliknij miejsce → przejście do szczegółów.
4. Kliknij serce w szczegółach → powrót do listy pokaże zaktualizowany stan.

### Podsumowanie

* **Hooki** — prostszy lokalny stan.
* **Prop drilling** — problem rozwiązany przez providery.
* **InheritedWidget** — historyczne rozwiązanie, dziś raczej rzadziej stosowane.
* **Riverpod** (z code generation) — nowoczesny globalny stan z automatycznie generowanymi providerami.
* **GoRouter** — deklaratywna nawigacja, współpracuje z Riverpod.
* **Model + provider** - aplikacja działa na prawdziwych danych i stan zsynchronizowany między ekranami.

