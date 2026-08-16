# Lista 4 (API i autentykacja)

- API: [https://backend-api.w.solvro.pl/api](https://backend-api.w.solvro.pl/api)
- Klient HTTP, np. `dio`: [https://pub.dev/packages/dio](https://pub.dev/packages/dio) — zainstaluj go (lub podobny).
- Wskazówka: przykładowe dane możesz dodać przez Swagger pod adresem API, żeby łatwiej testować fetchowanie.

## Autentykacja

Nie musisz rozbijać tego na trzy osobne repozytoria — wystarczy prosta struktura (np. jedna klasa auth + lokalny zapis tokenów, albo local + remote bez dodatkowej fasady).

1. Zapisuj, odczytuj i usuwaj access (oraz opcjonalnie refresh) token lokalnie w bezpieczny sposób (keychain). Możesz użyć [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) lub podobnej paczki.

2. Zaimplementuj `AuthenticationRepository` (lub równoważną warstwę) z metodami:
    - odczyt stanu zalogowania (czy jest zapisany token lokalnie; backend nie zwraca `expiredAt`, więc nie sprawdzamy wygaśnięcia)
    - logowanie (request do API → przy sukcesie zapis tokenów)
    - rejestracja (request do API → przy sukcesie zapis tokenów)
    - wylogowanie (usunięcie tokenów lokalnie)

3. Udostępniaj stan zalogowania przez global state management (np. riverpod) — bezpośrednio z repozytorium albo przez `AuthProvider` / `AuthNotifier`.

4. Skonfiguruj klienta HTTP (np. Dio jako singleton/fabryka przez riverpod lub `get_it`) z access tokenem w headerach, gdy użytkownik jest zalogowany. Tego klienta używaj do endpointów wymagających auth.

5. **Dla chętnych:** odświeżanie sesji przy 401 (backend nie zwraca `expiredAt`). W wersji obowiązkowej możesz założyć, że token nie wygasa w trakcie pracy z aplikacją.

## UI logowania i rejestracji

1. **Ekrany auth** — `LoginScreen` i `RegisterScreen`, albo jeden `AuthScreen` z dwoma trybami.
2. **Pola formularzy**:
   - Login: email/username i hasło
   - Register: email, username, hasło (potwierdzenie hasła opcjonalne)
3. **Integracja** — podłącz formularze do `AuthenticationRepository`.
4. **Błędy** — wyświetlaj komunikaty przy nieudanym logowaniu/rejestracji.
5. **Przełączanie** — możliwość przejścia między logowaniem a rejestracją.
6. **Nawigacja po auth** — po logowaniu → ekran główny, po wylogowaniu → ekran logowania (np. route guard w go_router).

## Integracja z API

Zamieniamy lokalną bazę miejsc na API. Przy Repository Pattern zwykle wystarczy wymienić implementację metod (i ewentualnie dopracować modele).

1. Podmień `DreamPlacesRepository`, żeby korzystało z API. Na tej liście **wymagane** są:
    - wczytywanie listy miejsc (READ)
    - aktualizacja ulubionego (UPDATE `isFavorite`)

    Metody CREATE / DELETE / pełny UPDATE możesz dodać już teraz albo zostawić na listę 5 — ważne, żeby lista i ulubione działały jak wcześniej.

2. Usunięcie lokalnej bazy i odinstalowanie paczek **nie jest obowiązkowe** na tej liście. Możesz zostawić stary kod nieużywany albo posprzątać — jak wygodniej. Pełne sprzątanie możesz dokończyć później.

3. Model `Place` / `DreamPlace` musi umieć serializację JSON (`fromJson` / `toJson`). Możesz to napisać ręcznie albo użyć [freezed](https://pub.dev/packages/freezed).

## Dla chętnych

- Formularz CREATE nowego miejsca
- Upload zdjęcia (`PhotosRepository`) i tworzenie miejsca ze zdjęciem
