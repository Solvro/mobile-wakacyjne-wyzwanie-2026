import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../gen/assets.gen.dart";
import "../../models/place.dart";
import "../../models/place_feature.dart";

part "places_provider.g.dart";

final _initalPlaces = [
  Place(
    id: "1",
    title: "🇨🇾 Pafos, Cypr",
    descriptionTitle: "Nadmorskie miasteczko na Cyprze",
    description: "Piękne widoki, malownicze plaże i urokliwe ulice",
    image: Assets.images.pafos,
    features: [
      const PlaceFeature(Icons.wb_sunny, "Słońce"),
      const PlaceFeature(Icons.beach_access, "Plaże"),
      const PlaceFeature(Icons.restaurant, "Jedzenie"),
    ],
  ),
  Place(
    id: "2",
    title: "🇮🇹 Rzym, Włochy",
    descriptionTitle: "Antyczne miasto pełne zabytków",
    description: "Wiele znalezisk archeologicznych, centrum kultury",
    image: Assets.images.rzym,
    features: [
      const PlaceFeature(Icons.local_fire_department, "Gladiatorzy"),
      const PlaceFeature(Icons.dinner_dining, "Wyśmienite dania"),
      const PlaceFeature(Icons.local_see, "Mnóstwo atrakcji"),
    ],
  ),
  Place(
    id: "3",
    title: "🇪🇸 Barcelona, Hiszpania",
    descriptionTitle: "Stolica katalońskiego modernizmu",
    description: "Niezwykła architektura Gaudiego, piaszczyste plaże i tętniąca życiem ulica La Rambla.",
    image: Assets.images.barcelona,
    features: [
      const PlaceFeature(Icons.beach_access, "Plaża"),
      const PlaceFeature(Icons.architecture, "Architektura"),
      const PlaceFeature(Icons.palette, "Sztuka"),
    ],
  ),
  Place(
    id: "4",
    title: "🇲🇩 Kiszyniów, Mołdawia",
    descriptionTitle: "Najbardziej zielona stolica Europy",
    description: "Spokojne miasto z licznymi parkami, brutalistyczną architekturą i słynnymi winiarniami w okolicy.",
    image: Assets.images.kiszyniow,
    features: [
      const PlaceFeature(Icons.park, "Parki"),
      const PlaceFeature(Icons.wine_bar, "Wino"),
      const PlaceFeature(Icons.church, "Zabytki"),
    ],
  ),
  Place(
    id: "5",
    title: "🇫🇷 Nicea, Francja",
    descriptionTitle: "Perła Lazurowego Wybrzeża",
    description: "Elegancka promenada Anglików, błękitne morze i urokliwe stare miasto Vieux Nice.",
    image: Assets.images.nicea,
    features: [
      const PlaceFeature(Icons.sailing, "Morze"),
      const PlaceFeature(Icons.shopping_bag, "Butiki"),
      const PlaceFeature(Icons.wb_sunny, "Pogoda"),
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initalPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
