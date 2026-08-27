import "package:riverpod_annotation/riverpod_annotation.dart";
import "../../gen/assets.gen.dart";
import "../../models/place.dart";

part "places_provider.g.dart";

final _initialPlaces = [
  Place(
    id: "1",
    name: "Bangkok",
    country: "Bankok, Tajlandia",
    description: "Białe domki nad morzem",
    imagePath: Assets.images.bangkok,
  ),
  Place(
    id: "2",
    name: "Paris",
    country: "Paris, Francja",
    description: "Świątynie i ogrody",
    imagePath: Assets.images.paris,
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
