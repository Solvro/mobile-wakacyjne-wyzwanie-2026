import "package:riverpod_annotation/riverpod_annotation.dart";
import "place_model.dart";

part "places_provider.g.dart";

const _initialPlaces = [
  PlaceModel(
    id: 1,
    name: "Snowdin",
    description: "Here lives THE GREAT PAPYRUS",
    ownerEmail: "papyrus@snowdin.com",
    imageUrl: "https://example.com/snowdin.jpg",
  ),
  PlaceModel(
    id: 2,
    name: "Zakopane",
    description: "Big snowy mountains",
    ownerEmail: "owner@example.com",
    imageUrl: "https://example.com/zakopane.jpg",
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<PlaceModel> build() => _initialPlaces;

  void toggleFavorite(String id) {
    final int intId = int.parse(id);
    state = [
      for (final p in state)
        if (p.id == intId) p.copyWith(isFavorite: !p.isFavorite) else p
    ];
  }
}
