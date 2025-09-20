import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "place.dart";

part "places_provider.g.dart";

const _initialPlaces = <Place>[
  Place(
    id: "1",
    title: "Manchester, Anglia",
    subtitle: "Miasto futbolu",
    imagePath: "assets/images/manchester.jpg",
    description: "• Piłka nożna\n• Architektura",
    backgroundColor: Color.fromARGB(255, 255, 0, 0),
    isFavorite: false,
  ),
  Place(
    id: "2",
    title: "Santorini, Grecja",
    subtitle: "Grecja",
    imagePath: "assets/images/santorini.jpg",
    description: "• Zachody słońca\n• Morze",
    backgroundColor: Color(0xFF1E88E5),
    isFavorite: false,
  ),
  Place(
    id: "3",
    title: "Barcelona, Hiszpania",
    subtitle: "Katalonia",
    imagePath: "assets/images/barcelona.jpg",
    description: "• FcBarcelona\n• Plaże i tapas",
    backgroundColor: Color.fromARGB(255, 255, 123, 0),
    isFavorite: false,
  ),
  Place(
    id: "4",
    title: "Rzym, Włochy",
    subtitle: "Makaron",
    imagePath: "assets/images/rzym.jpg",
    description: "• Koloseum\n• Pizza i espresso",
    backgroundColor: Color.fromARGB(255, 94, 255, 0),
    isFavorite: false,
  ),
  Place(
    id: "5",
    title: "Paryż, Francja",
    subtitle: "Wieża",
    imagePath: "assets/images/paryz.jpg",
    description: "• Wieża Eiffla\n• Korki",
    backgroundColor: Color.fromARGB(255, 0, 17, 255),
    isFavorite: false,
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

  void refresh() {
    state = List<Place>.from(_initialPlaces);
  }

  void add({
    required String title,
    String subtitle = "",
    String description = "",
    String? imagePath,
    Color backgroundColor = const Color(0xFFE0E0E0),
  }) {
    final path = (imagePath != null && imagePath.trim().isNotEmpty)
        ? imagePath.trim()
        : "https://picsum.photos/seed/${DateTime.now().millisecondsSinceEpoch}/800/600";

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final newPlace = Place(
      id: id,
      title: title,
      subtitle: subtitle,
      description: description,
      imagePath: path,
      backgroundColor: backgroundColor,
      isFavorite: false,
    );
    state = [...state, newPlace];
  }

  Place? byId(String id) {
    for (final p in state) {
      if (p.id == id) return p;
    }
    return null;
  }
}
