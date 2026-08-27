import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "place.dart";

part "places_provider.g.dart";

const _initialPlaces = [
  Place(
    id: "1",
    title: "Koszalin, Polska",
    imagePath: "assets/images/koszalin.jpg",
    locationTitle: "Katedra",
    description:
        "Katedra Niepokalanego Poczęcia Najświętszej Maryi Panny w Koszalinie.",
    icon1: Icons.location_on,
    icon2: Icons.account_balance,
    icon3: Icons.local_grocery_store,
    iconText1: "Centrum",
    iconText2: "Zabytek",
    iconText3: "Darmowe",
  ),
  Place(
    id: "2",
    title: "Mielno, Polska",
    imagePath: "assets/images/mielno.jpg",
    locationTitle: "Plaża",
    description:
        "Mielno słynie z piaszcystych plaż, drogich gofrów i zimnego Bałtyku",
    icon1: Icons.beach_access,
    icon2: Icons.local_dining,
    icon3: Icons.wb_sunny,
    iconText1: "Plaża",
    iconText2: "Restauracje",
    iconText3: "Słonecznie",
  ),
  Place(
    id: "3",
    title: "Kłodzko, Polska",
    imagePath: "assets/images/klodzko.jpg",
    locationTitle: "Most w Kłodzku",
    description: "Most w Kłodzku to zabytkowy most przekraczający rzekę.",
    icon1: Icons.location_city,
    icon2: Icons.history,
    icon3: Icons.visibility,
    iconText1: "Miasto",
    iconText2: "Historia",
    iconText3: "Widok",
  ),
  Place(
    id: "4",
    title: "Gąski, Polska",
    imagePath: "assets/images/gaski.jpg",
    locationTitle: "Latarnia Morska",
    description:
        "Latarnia Morska w Gąskach to zabytkowa latarnia morska położona nad Morzem Bałtyckim.",
    icon1: Icons.landscape,
    icon2: Icons.lightbulb,
    icon3: Icons.photo_camera,
    iconText1: "Widok",
    iconText2: "Latarnia",
    iconText3: "Fotogeniczne",
  ),
  Place(
    id: "5",
    title: "Białogard, Polska",
    imagePath: "assets/images/bialogard.jpg",
    locationTitle: "Rynek",
    description:
        "Rynek w Białogardzie to centralny plac miasta, otoczony zabytkowymi kamienicami.",
    icon1: Icons.store,
    icon2: Icons.local_cafe,
    icon3: Icons.directions_walk,
    iconText1: "Sklepy",
    iconText2: "Kawiarnie",
    iconText3: "Spacer",
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggle(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p,
    ];
  }
}
