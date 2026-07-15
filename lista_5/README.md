# Lista 5 (Filtrowanie, sortowanie, wyszukiwanie i CRUD)

- Kontynuacja listy 4, to samo API.

## Formularz CREATE i dokończenie CRUD

Po liście 4 powinny być READ oraz UPDATE `isFavorite`. Dopełnij aplikację do pełnego CRUD:

1. **CREATE** — formularz tworzenia miejsca (`CreateDreamPlaceScreen` lub wspólny ekran create/edit).
    - Pola np. nazwa, opis; `imageUrl` możesz podać jako tekst / stały placeholder (upload zdjęć nie jest obowiązkowy).
    - Umieść wejście do formularza w nawigacji (FAB, AppBar, itd.).
    - Formularze: klasycznie ([dokumentacja](https://docs.flutter.dev/cookbook/forms/validation)) albo inną wybraną biblioteką.

2. **DELETE** — przycisk usuwający miejsce (lista lub szczegóły), albo slide-to-dismiss.

3. **EDIT** — ten sam formularz w trybach `CREATE` i `EDIT` + przycisk otwierający edycję danego miejsca.

4. Upewnij się, że tworzenie i edycja działają end-to-end z API.

## Filtrowanie

Filtry nie są w API — robimy je po stronie klienta.

1. **UI** — switch (lub podobny) „pokazuj tylko ulubione”.
2. **Stan** — lokalny albo globalny.
3. **Powiązanie z listą** — odfiltruj miejsca według flagi (provider albo bezpośrednio w UI).

## Wyszukiwanie

Wyszukiwanie po nazwie też po stronie klienta.

1. **UI** — `SearchBar` / `TextField` na ekranie głównym (np. w AppBar).
2. **Stan** — lokalny albo globalny.
3. **Filtrowanie po frazie** — np. provider `filteredPlaces` albo filtr w widgetcie.
4. Debouncing nie jest wymagany (wyszukiwanie lokalne).

## Sortowanie

Sortowanie jest w API — robimy je po stronie serwera.

1. W `DreamPlacesRepository` dodaj parametr lub metodę z sortowaniem (szczegóły w dokumentacji API).
2. Minimum: jedno pole, rosnąco / malejąco (np. nazwa).
3. W UI prosty przycisk przełączający kolejność + stan (lokalny lub globalny).
4. Spięcie stanu sortowania z fetchowaniem listy (np. family provider w Riverpod).

## Dla chętnych

- Upload zdjęcia na serwer (`PhotosRepository`) i tworzenie / edycja miejsca ze zdjęciem zamiast ręcznego `imageUrl`.
