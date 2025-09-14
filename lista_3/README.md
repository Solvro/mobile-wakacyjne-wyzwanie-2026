# Lista 3 (Przechowywanie danych lokalnie + dark/light theme)

## 1. Problem: Dane znikają po restarcie aplikacji

- Do tej pory wszystkie nasze dane (np. stan ulubionych) były przechowywane tylko w pamięci RAM. Gdy użytkownik zamknie aplikację, wszystkie informacje znikają.
- W prawdziwych aplikacjach chcemy, aby preferencje użytkownika, ulubione miejsca czy ustawienia były zapisane na urządzeniu w pamięci trwałej.
- Flutter oferuje kilka rozwiązań do przechowywania danych lokalnie. Poznamy **shared_preferences** dla prostych danych oraz wybraną bardziej rozbudowaną bazę danych (np. [isar](https://pub.dev/packages/isar), [hive](https://pub.dev/packages/hive) lub [drift](https://pub.dev/packages/drift))

## 2. SharedPreferences - Proste dane konfiguracyjne

- **shared_preferences** to paczka do przechowywania prostych par klucz-wartość (podobnie jak `localStorage` w przeglądarce).[https://pub.dev/packages/shared_preferences](https://pub.dev/packages/shared_preferences)
- Idealnie nadaje się do zapisywania ustawień użytkownika, preferencji motywu czy prostych flag true/false.

2.1 Zainstaluj shared preferences [https://pub.dev/packages/shared_preferences](https://pub.dev/packages/shared_preferences)  

2.2 Stwórz `LocalThemeRepository`, które będzie przechowywać wybór użytkownika co do jasnego albo ciemnego motywu. Możliwe opcje do przechowywania to:  
        - jasny  
        - ciemny  
        - nie wybrany (będziemy wczytywać domyślne ustawienia z urządzenia)  
        
Możesz to zaimplementować za pomocą nullable flagi `bool?` (nullable boolean), albo 3 opcjowego `enuma` (lub 2 opcjowego enuma który jest nullable). Zapisuj te dane za pomocą shared preferences. **Pamiętaj żeby wykorzystać repository pattern**. Musimy mieć opcję zarówno odczytania ustawienia, jak i jego zmiany.  

## 3. Dark/Light Theme

3.1 Ustaw `themeMode` na podstawie zapisanego wyboru w shared preferensach, lub gdy nie jest wybrany to zczytuj ustawienie z ustawień urządzenia (`MediaQuery.platformBrightnessOf`). Użyj `LocalThemeRepository` oraz wybranego rozwiązania state management (np. riverpod). Zastanów się, czy jest to stan lokalny czy globalny?  

3.2 Zdefiniuj jasny i ciemny theme według uznania.  

3.3 Dodaj w wybrany sposób do UI opcję wyboru jasnego albo ciemnego motywu (np. switch, checkbox lub zwykły button).  

## 4. Bazy danych - zaawansowane przechowywanie danych

4.1 Wybierz bazę danych swojego wyboru:  
    - [isar](https://pub.dev/packages/isar) - NoSQLowa baza danych  
    - [hive](https://pub.dev/packages/hive) - poprzednia baza twórcy isara, ale nadal dość szeroko używana.  
    - [drift](https://pub.dev/packages/drift) - popularna baza SQL   
    Są też inne. Polecam wybrać jakąś wersję z generacją kodu (ale nie jest to wymóg) i która wam pasuje wizulanie i filozoficznie do tego zastosowania (np. NoSQL vs SQL)  
    
4.2 Dodaj kolekcję/tabelę/model `DreamPlace` który będzie przechowywać następujące dane:  
    - id  
    - nazwa miejsca (`name`)  
    - krótki opis (`description`)  
    - zdjęcie - url do hostowanego gdzies w internecie zdjęcia (`imageUrl`)  
    - czy ulubione - true/false (`isFavourite`)  
    
4.3 Stwórz `DreamPlacesRepository`, które będzie wczytywać, dodawać, aktualizować i usuwać zapisane miejsca z bazy danych. **Skorzystaj z repository pattern**.  

4.4 Korzystając z `DreamPlacesRepository` i wybranego rozwiązania state management (zastanów się czy to stan lokalny czy globalny), podepnij interfejs graficzny z list 1 i 2 do tego lokalnego źródła danych. W szczególności wyświetlaj (READ) zapisane miejsca i zapisuj/aktualizuj (UPDATE) stan "czy ulubiony" w bazie danych.  

4.5 Nie musisz jeszcze dodawać opcji dodawania (CREATE), usuwania (DELETE) ani aktulizowania innych pól niż "czy ulubiony" w interfejsie graficznym (ale dodaj już wszystkie metody CRUD do `DreamPlacesRepository`). Możesz to zrobić, ale wymagane to będzie dopiero na 5. liście. Jeśli nie dodasz opcji CREATE to musisz w dowolny sposób "zaseedować" bazę danych, czyli w sztuczny ręczny lub półautomatyczny sposób dodać przykładowe dane do bazy danych - aby mieć co wyświetlać.  

Przykład seedu (w drifcie), który można wywołać w `main`, aby móc testować naszą aplikację bez dodawania pełnej funkcjonalności CREATE. W Isarze można też to po prostu wyklikać to za pomocą [Isar Inspectora](https://github.com/isar/isar?tab=readme-ov-file#isar-database-inspector) w pełni ręcznie i przyjaźnie.  

```dart
  Future<void> seedDatabase() async {
    // Sprawdź czy baza jest już zaseedowana
    final existingPlaces = await (select(dreamPlaces)).get();
    if (existingPlaces.isNotEmpty) {
      // Baza już ma dane, nie seeduj ponownie
      return;
    }
    
    // Dane do zaseedowania
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
    
    // Zapisz dane do bazy
    await batch((batch) {
      batch.insertAll(dreamPlaces, samplePlaces);
    });
    
    print('Drift database seeded with ${samplePlaces.length} places');
  }
```

W tym punkcie możesz też poprosić o pomoc LLMa. Sam podpunkt z seedowaniem ma umożliwić przetestowanie poprzednich punktów, a nie jest standardowym elementem mobile developmentu.
