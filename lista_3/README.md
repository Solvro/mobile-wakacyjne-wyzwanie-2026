# Lista 3 (Dane lokalne i motyw)

## 1. Wprowadzenie

- Do tej pory dane (np. stan ulubionych) były tylko w pamięci RAM — po zamknięciu aplikacji znikają.
- Na tej liście zapiszemy dane trwale na urządzeniu: **shared_preferences** (proste ustawienia) oraz lokalną bazę danych (np. [isar](https://pub.dev/packages/isar), [hive](https://pub.dev/packages/hive) lub [drift](https://pub.dev/packages/drift)).

## 2. SharedPreferences

- **shared_preferences** przechowuje proste pary klucz-wartość: [dokumentacja](https://pub.dev/packages/shared_preferences).
- Nadaje się do ustawień użytkownika, motywu czy flag true/false.

2.1 Zainstaluj shared preferences: [https://pub.dev/packages/shared_preferences](https://pub.dev/packages/shared_preferences)

2.2 Stwórz `LocalThemeRepository`, które będzie przechowywać wybór użytkownika co do jasnego albo ciemnego motywu. Możliwe opcje:
        - jasny
        - ciemny
        - nie wybrany (domyślne ustawienie z urządzenia)

Możesz to zaimplementować za pomocą nullable flagi `bool?`, albo 3-opcjowego `enuma` (lub 2-opcjowego enuma który jest nullable). Zapisuj dane w shared preferences. **Użyj repository pattern**. Potrzebujesz odczytu i zmiany ustawienia.

## 3. Motyw jasny / ciemny

3.1 Ustaw `themeMode` na podstawie zapisanego wyboru, lub gdy nie jest wybrany — z ustawień urządzenia (`MediaQuery.platformBrightnessOf`). Użyj `LocalThemeRepository` oraz state management (np. riverpod).

3.2 Zdefiniuj jasny i ciemny theme według uznania.

3.3 Dodaj w UI opcję wyboru motywu (np. switch, checkbox lub button).

## 4. Lokalna baza danych

4.1 Wybierz bazę danych:
    - [isar](https://pub.dev/packages/isar) — NoSQL
    - [hive](https://pub.dev/packages/hive) — NoSQL
    - [drift](https://pub.dev/packages/drift) — SQL
    Generacja kodu jest mile widziana, ale nieobowiązkowa.

4.2 Dodaj kolekcję/tabelę/model `DreamPlace` z polami:
    - id
    - nazwa (`name`)
    - krótki opis (`description`)
    - url zdjęcia (`imageUrl`)
    - czy ulubione (`isFavourite`)

4.3 Stwórz `DreamPlacesRepository` z metodami potrzebnymi na tej liście:
    - wczytywanie wszystkich miejsc (READ)
    - aktualizacja flagi ulubionego (UPDATE `isFavourite`)

    Pełny CRUD (CREATE / DELETE / UPDATE innych pól) **nie jest wymagany** — pojawi się na późniejszych listach. **Użyj repository pattern**.

4.4 Podłącz UI z list 1 i 2 do lokalnego źródła danych: wyświetlaj miejsca i zapisuj stan ulubionego w bazie.

4.5 W UI nie musisz dodawać CREATE / DELETE. Żeby mieć co wyświetlać, **zaseeduj** bazę przykładowymi danymi (ręcznie, w `main`, albo np. przez [Isar Inspector](https://github.com/isar/isar?tab=readme-ov-file#isar-database-inspector)).

Przykład seedu (Drift), który można wywołać w `main`:

```dart
  Future<void> seedDatabase() async {
    final existingPlaces = await (select(dreamPlaces)).get();
    if (existingPlaces.isNotEmpty) {
      return;
    }

    final samplePlaces = [
      DreamPlacesCompanion.insert(
        name: 'Paryż',
        isFavorite: const Value(true),
        imageUrl: 'https://example.com/paris.jpg',
      ),
      DreamPlacesCompanion.insert(
        name: 'Tokio',
        isFavorite: const Value(false),
        imageUrl: 'https://example.com/tokyo.jpg',
      ),
      DreamPlacesCompanion.insert(
        name: 'Nowy Jork',
        isFavorite: const Value(true),
        imageUrl: 'https://example.com/nyc.jpg',
      ),
      DreamPlacesCompanion.insert(
        name: 'Rzym',
        isFavorite: const Value(false),
        imageUrl: 'https://example.com/rome.jpg',
      ),
      DreamPlacesCompanion.insert(
        name: 'Sydney',
        isFavorite: const Value(true),
        imageUrl: 'https://example.com/sydney.jpg',
      ),
    ];

    await batch((batch) {
      batch.insertAll(dreamPlaces, samplePlaces);
    });
  }
```

Seed służy tylko do testowania — możesz poprosić LLM o pomoc przy dopasowaniu go do wybranej bazy.
