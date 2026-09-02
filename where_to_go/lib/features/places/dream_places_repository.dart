import 'package:hive/hive.dart';
import 'dream_place.dart';

class DreamPlacesRepository {
  final Box<DreamPlace> _box;

  DreamPlacesRepository(this._box);

  List<DreamPlace> getAllPlaces() {
    return _box.values.toList();
  }

  Future<void> toggleFavorite(String id) async {
    final place = _box.get(id);
    if (place != null) {
      place.isFavorite = !place.isFavorite;
      await place.save();
    }
  }

  Future<void> seedDatabase() async {
    if (_box.isNotEmpty) return;

    final initialPlaces = [
      DreamPlace(
        id: '1',
        name: 'Białe miasteczko Oia',
        imagePath: 'assets/images/Wymarzone_miej.jpg',
        description:
            'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
        isFavorite: false,
      ),
      DreamPlace(
        id: '2',
        name: 'Czarne miasteczko Oia',
        imagePath: 'assets/images/Wymarzone_miej.jpg',
        description:
            'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
        isFavorite: false,
      ),
      DreamPlace(
        id: '3',
        name: 'Zielone miasteczko Oia',
        imagePath: 'assets/images/Wymarzone_miej.jpg',
        description:
            'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
        isFavorite: false,
      ),
      DreamPlace(
        id: '4',
        name: 'Czerwone miasteczko Oia',
        imagePath: 'assets/images/Wymarzone_miej.jpg',
        description:
            'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
        isFavorite: false,
      ),
      DreamPlace(
        id: '5',
        name: 'Żółte miasteczko Oia',
        imagePath: 'assets/images/Wymarzone_miej.jpg',
        description:
            'Miejsce, w którym czas zwalnia, a każdy zachód słońca wygląda jak wycięty z pocztówki.',
        isFavorite: false,
      ),
    ];

    for (final place in initialPlaces) {
      await _box.put(place.id, place);
    }
  }
}
