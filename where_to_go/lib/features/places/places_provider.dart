import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'place.dart';

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(
    id: '1',
    name: 'Białe miasteczko Oia',
    imagePath: 'assets/images/Wymarzone_miej.jpg',
    description:
        'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
  ),
  Place(
    id: '2',
    name: 'Czarne miasteczko Oia',
    imagePath: 'assets/images/Wymarzone_miej.jpg',
    description:
        'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
  ),
  Place(
    id: '3',
    name: 'Zielone miasteczko Oia',
    imagePath: 'assets/images/Wymarzone_miej.jpg',
    description:
        'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
  ),
  Place(
    id: '4',
    name: 'Czerwone miasteczko Oia',
    imagePath: 'assets/images/Wymarzone_miej.jpg',
    description:
        'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
  ),
  Place(
    id: '5',
    name: 'Żółte miasteczko Oia',
    imagePath: 'assets/images/Wymarzone_miej.jpg',
    description:
        'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggle(String id) {
    state = [
      for (final place in state)
        if (place.id == id)
          place.copyWith(isFavorite: !place.isFavorite)
        else
          place,
    ];
  }
}
