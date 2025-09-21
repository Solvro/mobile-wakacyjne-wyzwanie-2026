import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
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

enum SortOrder { titleAsc, titleDesc }

@riverpod
class Places extends _$Places {
  SortOrder _order = SortOrder.titleAsc;
  SortOrder get order => _order;

  @override
  List<Place> build() {
    return _sorted(List<Place>.from(_initialPlaces), _order);
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
    state = _sorted([...state, newPlace], _order);
  }

  void update(
    String id, {
    String? title,
    String? subtitle,
    String? description,
    String? imagePath,
    Color? backgroundColor,
    bool? isFavorite,
  }) {
    final updated = [
      for (final p in state)
        if (p.id == id)
          Place(
            id: p.id,
            title: title ?? p.title,
            subtitle: subtitle ?? p.subtitle,
            description: description ?? p.description,
            imagePath: imagePath ?? p.imagePath,
            backgroundColor: backgroundColor ?? p.backgroundColor,
            isFavorite: isFavorite ?? p.isFavorite,
          )
        else
          p,
    ];
    state = _sorted(updated, _order);
  }

  void remove(String id) {
    state = [
      for (final p in state)
        if (p.id != id) p,
    ];
  }

  void toggleFavorite(String id) {
    final updated = [
      for (final p in state)
        if (p.id == id)
          Place(
            id: p.id,
            title: p.title,
            subtitle: p.subtitle,
            description: p.description,
            imagePath: p.imagePath,
            backgroundColor: p.backgroundColor,
            isFavorite: !p.isFavorite,
          )
        else
          p,
    ];
    state = _sorted(updated, _order);
  }

  void refresh() {
    state = _sorted(List<Place>.from(_initialPlaces), _order);
  }

  Place? byId(String id) {
    for (final p in state) {
      if (p.id == id) return p;
    }
    return null;
  }

  void setSortOrder(SortOrder order) {
    _order = order;
    state = _sorted(List<Place>.from(state), _order);
  }

  void toggleSortOrder() {
    setSortOrder(
      _order == SortOrder.titleAsc ? SortOrder.titleDesc : SortOrder.titleAsc,
    );
  }

  List<Place> _sorted(List<Place> input, SortOrder order) {
    input.sort((a, b) {
      final cmp = a.title.toLowerCase().compareTo(b.title.toLowerCase());
      return order == SortOrder.titleAsc ? cmp : -cmp;
    });
    return input;
  }
}

@riverpod
SortOrder sortOrder(Ref ref) {
  return ref.watch(placesProvider.notifier).order;
}
