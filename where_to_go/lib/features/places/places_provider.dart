import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'place.dart';

part 'places_provider.g.dart';

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() {
    return [
      Place(
        id: '1',
        title: 'West End Theatre, Londyn',
        description: 'Serce londyńskiego życia teatralnego! West End to ponad 40 teatrów z najsłynniejszymi musicalami świata.',
      ),
      Place(
        id: '2',
        title: 'Santorini, Grecja',
        description: 'Białe domki nad morzem, błękitne kopuły i niesamowite zachody słońca.',
      ),
      Place(
        id: '3',
        title: 'Kioto, Japonia',
        description: 'Świątynie, ogrody zen i kwitnące wiśnie w historycznej stolicy Japonii.',
      ),
    ];
  }

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}