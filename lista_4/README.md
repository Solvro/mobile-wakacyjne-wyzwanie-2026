# Lista 4 (Pozyskiwanie danych z api i auth + formularz)

- Dzisiejszą listę robimy z przygotowaną przez sekcję backend API: [https://backend-api.w.solvro.pl/api](https://backend-api.w.solvro.pl/api)
- Potrzebujemy do niej jakiegoś klienta http, np. z paczki `dio`: [https://pub.dev/packages/dio](https://pub.dev/packages/dio). Trzeba ją zainstalować (lub podobną)
- **💡 Dodatkowa wskazówka**: Aby przetestować czy wszystko poprawnie się fetchuje, dodajcie sobie przykładowe dane za pomocą Swaggera dostępnego pod adresem API. To pomoże wam zweryfikować czy wasze implementacje działają poprawnie z rzeczywistymi danymi z serwera.

## Authentication

1. Stwórz `LocalAuthenticationRepository`, które ma za zadanie:
   - zapisywać access i refresh token
   - odczytywać access i refresh token
   - usuwać access i refresh token

w bezpieczny sposób i lokalnie na urządzeniu mobilnym (za pomocą keychain). Możesz użyć paczki typu: [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) lub podobnej.

2. Stwórz `RemoteAuthenticationRepository`, które ma za zadanie wysyłać żądania do API związane z authem:
   - logowanie
   - rejestracja
   - odświeżenie tokenu
3. Stwórz `AuthenticationRepository`, które wykorzystuje `LocalAuthenticationRepository` i `RemoteAuthenticationRepository` i ma metody, które:
   - odczytuje stan zalogowania (sprawdza i odczytuje token zapisany lokalnie. Niestety backend nie zwraca nam `expiredAt` tokenu, więc nie możemy w prosty sposób go tutaj odswiezyć ani sprawdzić czy nie jest przeterminowany)
   - loguje się (wysyła żądanie logowania do serwera i w przypadku sukcesu zapisuje tokeny lokalnie)
   - rejestruje się (wysyła żądanie rejestracji do serwera i w przypadku sukcesu zapisuje tokeny lokalnie)
   - wylogowuje się (usuwa tokeny lokalnie)
4. Udostępniaj stan zalogowania za pomocą rozwiązania do global state management (np. riverpod). `AuthenticationRepository` może od razu wykorzystywać jakieś rozwiązanie i udostępniać to bezpośrednio lub możesz stworzyć dodatkową warstwę w postaci `AuthProvidera`/`AuthNotifiera`
5. Stwórz singleton lub fabrykę (możesz wykorzystać np. `riverpoda` albo `get_it`) klienta http (np. z paczki `dio`), który ma wstrzyknięty token do headerów, jeśli user jest zalogowany. Będziemy wykorzystywać tego klienta wszędzie gdzie będziemy mieli potrzebę komunikować się z serwerem na endpointach, które wymagają zalogowania. Do stworzenia go wykorzystaj `AuthenticationRepository` albo `AuthProvider`/`AuthNotifiera`.
6. Niestety backend nie zwraca `expiredAt`, czyli timestampa wygaśnięcia access tokenu, więc flow odświeżania sesji jest jako **ZADANIE DLA CHĘTNYCH**. W tym przypadku (jak nie ma `expiredAt`) jedyną opcją jest zrobienie wrappera lub proxy na wysyłane żądania lub całego klienta http, który będzie odświeżał token i powtarzał żądania w razie odrzucenia aktualnego tokenu. Nie jest to jednak najoptymalniejsze ani najprostsze, więc nie jest obowiązkowe zadanie. W wersji obowiązkowej, można założyć, że refresh token się nie przeterminowuje.

## UI Logowania i Rejestracji

1. **Stwórz ekrany logowania i rejestracji** - dodaj widoki `LoginScreen` i `RegisterScreen` z odpowiednimi formularzami. Alternatywnie można zrobić jeden `AuthScreen` z dwoma trybami między którymi można się przełączać (stan lokalny prawdopodobnie).
2. **Formularze powinny zawierać**:
   - Login: pole email/username i hasło
   - Register: pola email, username, hasło i potwierdzenie hasła
3. **Integracja z AuthenticationRepository** - połączenie formularzy z metodami logowania/rejestracji z `AuthenticationRepository`
4. **Obsługa błędów** - wyświetlanie komunikatów o błędach logowania/rejestracji
5. **Nawigacja** - dodaj możliwość przełączania między ekranami logowania i rejestracji
6. **Stan aplikacji** - po udanym logowaniu użytkownik powinien zostać przekierowany do głównego ekranu aplikacji. Po wylogowaniu natomiast powinien zostać przeniesiony do ekranu logowania. Można to zrobić na wiele sposobów, możecie np. wyszukać sb w google "route guard go_router" albo cos w tym stylu.

## Integracja aktualnej aplikacji z API

Wymienimy naszą lokalną bazę danych z dream miejscami na serwerowe API. Jeśli wykorzystaliście Repository Pattern, powinno ograniczać się to tylko do wymiany implementacji kilku metod (i dorobieniu modeli jeśli do tej pory korzystaliście z tych bazodanowych).

1. Wymień implementacje metod w `DreamPlacesRepository` aby korzystały z naszego API. `DreamPlacesRepository` powinno umożliwiać: wczytywanie, dodawanie, aktualizowanie i usuwanie miejsc. Upewnij się, że funkcjonalności które działały na poprzedniej liście nadal działają (READ i UPDATE "isFavorite").
2. Usuńcie wszystkie pozostałości po waszej lokalnej bazie danych, chyba że gdzieś z nich korzystacie. (w tym odinstalujcie paczki)
3. Jeśli jeszcze nie posiadasz modelu `Place` lub `DreamPlace` to musicie go dorobić, lub jeśli posiadacie to musicie go przerobić, aby umożliwiał przynajmniej serializację z i do JSON. Najlepszą paczką do tego jest [freezed](https://pub.dev/packages/freezed). Można to też zaimplementować ręcznie w postaci factory konstruktora `fromJson` i metody `toJson` (freezed ma też inne bajery)

## Dodanie formularza CREATE

### Formularz (warstwa prezentacji + stan lokalny formularza)

1. Jeśli na poprzedniej liście jeszcze nie zaimplementowaliście formularza/widoku do tworzenia nowych miejsc, czas go dodać teraz.
2. Stwórzcie widok/formularz tworzenia `CreateDreamPlaceScreen` i umieście go gdzieś w aplikacji. Formularze w flutterze można zrobić na wiele sposobów:
   - klasycznie [https://docs.flutter.dev/cookbook/forms/validation](https://docs.flutter.dev/cookbook/forms/validation), [https://medium.com/@ugamakelechi501/understanding-flutter-forms-a-detailed-guide-for-beginner-1e797da9a610](https://medium.com/@ugamakelechi501/understanding-flutter-forms-a-detailed-guide-for-beginner-1e797da9a610)
   - flutter reactive forms (z opcjonalną generacją kodu): [https://pub.dev/packages/reactive_forms](https://pub.dev/packages/reactive_forms)
   - flutter form builder: [https://pub.dev/packages/flutter_form_builder](https://pub.dev/packages/flutter_form_builder)
   - jeśli ktoś lubi hooki: [https://pub.dev/packages/flutter_hook_form/example](https://pub.dev/packages/flutter_hook_form/example)
   - jeśli ktoś lubi BLoCa: [https://pub.dev/packages/flutter_form_bloc](https://pub.dev/packages/flutter_form_bloc)
   - i wiele wiele innych :))
3. Pamiętajcie żeby było to gdzieś dostępne w nawigacji np. jako floating action button, app bar action, zakładka w nav/top barze lub cokolwiek innego.

### Uploadowanie zdjęć

1. Stwórzcie `PhotosRepository`, które ma za zadanie uploadować zdjęcia na nasz serwer. Inne metody CRUD ze zdjęć nie będą nam potrzebne.
2. Stwórz `DreamPlaceService`, który będzie korzystać `PhotosRepository` i `DreamPlacesRepository` i będzie implementować metodę `createDreamPlaceWithPhoto`, która będzie najpierw uploadować zdjęcie a potem tworzyć obiekt "place" z tym zdjęciem.

### Spięcie formularza z serwerem

1. Korzystając `DreamPlaceService` zepnij akcję submitowania formularza z uploadowaniem zdjęcia i tworzeniem nowego obiektu typu "place" na serwerze.
