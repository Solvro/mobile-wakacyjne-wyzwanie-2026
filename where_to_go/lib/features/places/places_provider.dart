import "package:riverpod_annotation/riverpod_annotation.dart";
import "place.dart";

part "places_provider.g.dart";

const List<Place> _initialPlaces = [
  Place(
    id: "1",
    title: "Lofoty, Norwegia",
    description: "Arktyczne krajobrazy i fiordy",
    imageUrl:
        "https://images.unsplash.com/photo-1517411032315-54ef2cb783bb?w=500&q=80",
  ),
  Place(
    id: "2",
    title: "Santorini, Grecja",
    description: "Białe miasteczka i błękitne kopuły",
    imageUrl:
        "https://images.unsplash.com/photo-1570077188670-e3a8d69ac5ff?w=500&q=80",
  ),
  Place(
    id: "3",
    title: "Kioto, Japonia",
    description: "Tradycja i kwitnące wiśnie",
    imageUrl:
        "https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?w=500&q=80",
  ),
  Place(
    id: "4",
    title: "Amalfi, Włochy",
    description: "Kolorowe klify i Morze Tyrreńskie",
    imageUrl:
        "https://images.unsplash.com/photo-1533105079780-92b9be482077?w=500&q=80",
  ),
  Place(
    id: "5",
    title: "Banff, Kanada",
    description: "Góry Skaliste i turkusowe jeziora",
    imageUrl:
        "https://images.unsplash.com/photo-1503614472-8c93d56e92ce?w=500&q=80",
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
