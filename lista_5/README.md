# Lista 5 (Filtrowanie, sortowanie, wyszukiwanie i dokończenie CRUD-a)

- Całość listy robimy na podstawie kodu z listy 4 oraz tego samego API.

## Filtrowanie

Filtry nie są dostępne w tym API, więc zaimplementujemy to w pełni po stronie klienta (po stronie naszej aplikacji)

1. **Dodaj switch** - albo inny prosty element UI, który pozwoli nam włączać filtr "pokazuj tylko ulubione"

2. **Dodaj zarządzanie stanem** - zdecyduj czy ta flaga to w naszej aplikacji stan globalny czy lokalny i go w ten sposób zaimplementuj.

3. **Filtruj na podstawie tego flitru** - Zepnij stan z tym co widzimy na liście miejsc na ekranie. Można to filtrowanie wydzielić do jakiejś innej warstwy np. jako osobny provider riverpodowy, albo odfiltrować bezpośrednio w UI (jeśli zdecydowaliście się na stan lokalny).

## Wyszukiwanie

Wyszukanie po nazwie również nie jest dostępne w API, więc zaimplementujemy to po stronie klienta.

1. **Dodaj pole wyszukiwania** - w głównym ekranie dodaj `SearchBar` lub `TextField` z ikoną wyszukiwania. Na przykład do app bara.

2. **Dodaj zarządzanie stanem** - zdecyduj czy wyszukana fraza to w naszej aplikacji stan globalny czy lokalny i go w ten sposób zaimplementuj.

3. **Użyj szukanej frazy do filtrowania** - Jeżeli twoja fraza to stan globalny, to możesz np. dodać riverpodowy provider `filteredPlaces` który będzie zależeć od pełnej kolekcji miejsc oraz wyszukanej frazy i dokonywać filtrowania po nazwie. Jeśli twoja fraza to stan lokalny, to filtrowania można dokonać bezpośrednio w widgetcie.

4. Jeżeli wyszukanie odbywało się po stronie serwera, to musielibyśmy dodać jeszcze debouncing, ale tutaj nie powinien być potrzebny.

## Sortowanie

Sortowanie udostępnia nam API, więc zrobimy je po stronie serwera.

1. Należy dodać w `DreamPlacesRepository` repository parametr albo dodatkową metodę do fetchowania miejsc z określonym sortowaniem. Sposób na sortowanie należy sprawdzić w dokumentacji API.

2. Jako wymagane minimum wystarczy wybrać jedno pole i dodać możliwość sortowania rosnąco lub malejąco po nim (np. nazwa miejsca).

3. Wybór kolejności sortowania należy w jakiś prosty sposób zaimplementować w UI np. za pomocą buttona, który "toggluje" kolejność sortowania. Przechowuj to jako jakiś stan (zdecyduj się czy to stan globalny czy lokalny).

4. Należy spiąć stan naszego sortowania z tym jaka metoda w repozytorium pobiera nam miejsca do wyświetlenia na liście miejsc. Przykładowo można to zrobić za pomocą family providera z riverpoda, który jako argument przyjmuje kolejność sortowania, lub jeśli stan kolejności sortowania jest globalny, to provider z listą miejsc może po prostu zależeć od stanu kolejności sortowania.

## Dokończenie CRUDA

Po liscie 4 powinnismy mieć READ, CREATE i ewentualnie UPDATE ale tylko `isFavorite`. Należy teraz do dopełnić naszą apkę do pełnego CRUDa, przez:  
    - dodanie buttona, który usuwa nasze wymarzone miejsce (na liscie lub w widoku szczegółowym). Alternatywnie można zrobić "slide to dismiss" zamiast buttona.
    - przerobienie naszego formularza z listy 4, aby obsługiwać dwa tryby: `EDIT` lub `CREATE` i pozwalał za równo na dodawanie nowych jak i edytowanie istniejących elementów w zależności od tego co chcemy zrobić.
    - Dodanie buttona który otwiera nasz formularz w trybie edycji danego miejsca.
    - Sprawdźcie czy button do tworzenia z poprzedniej listy nadal działa!
