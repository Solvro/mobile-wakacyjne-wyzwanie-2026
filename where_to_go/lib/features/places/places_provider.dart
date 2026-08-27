import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "place.dart";

part 'places_provider.g.dart';

const _initialPlaces = [
  Place(
    id: "1",
    title: "Lagonisi, Grecja",
    homeImagePath: "assets/images/lagonisi.jpg",
    pageImagePath: "assets/images/lagonisi2.jpg",
    pageTitle: "Nadmorskie miasteczko Lagonisi",
    description: "Nadmorska dzielnica mieszkaniowa na Riwierze Ateńskiej i południowej części Kalyvia Thorikou we wschodniej Attyce.",
    features: [
      Feature("Plaża piasczysta", Icons.beach_access),
      Feature("Jedzenie", Icons.fastfood),
      Feature("Słońce", Icons.sunny),
    ],
  ),
  Place(
    id: "2",
    title: "Vodice, Chorwacja",
    homeImagePath: "assets/images/vodice.jpg",
    pageImagePath: "assets/images/vodice2.jpg",
    pageTitle: "Słoneczny kurort Vodice",
    description: "Miasto i port w Chorwacji, w żupanii szybenicko-knińskiej, siedziba miasta Vodice.",
    features: [
      Feature("Plaża kamienista", Icons.beach_access),
      Feature("Życie nocne", Icons.nightlife),
      Feature("Słońce", Icons.sunny),
    ],
  ),
  Place(
    id: "3",
    title: "Rimini, Włochy",
    homeImagePath: "assets/images/rimini2.jpg",
    pageImagePath: "assets/images/rimini.jpg",
    pageTitle: "Turystyczne Rimini",
    description: "Jedno z najpopularniejszych miast turystyczno-wypoczynkowych nad północnym Adriatykiem.",
    features: [
      Feature("Plaża piasczysta", Icons.beach_access),
      Feature("Życie nocne", Icons.nightlife),
      Feature("Słońce", Icons.sunny),
      Feature("Duże miasto", Icons.location_city),
    ],
  ),
  Place(
    id: "4",
    title: "Madryt, Hiszpania",
    homeImagePath: "assets/images/madryt.jpg",
    pageImagePath: "assets/images/madryt2.jpg",
    pageTitle: "Centrum Hiszpanii, Madryt",
    description: "Stolica i największe miasto Hiszpanii, położone w środkowej części kraju, nad rzeką Manzanares.",
    features: [
      Feature("Stolica", Icons.location_city),
      Feature("Życie nocne", Icons.nightlife),
      Feature("Nad rzeką", Icons.water),
    ],
  ),
  Place(
    id: "5",
    title: "Zakopane, Polska",
    homeImagePath: "assets/images/zakopane.jpg",
    pageImagePath: "assets/images/zakopane2.jpg",
    pageTitle: "Zimowa stolica, Zakopane",
    description: "Miasto w południowej Polsce, największa miejscowość w bezpośrednim otoczeniu Tatr, duży ośrodek sportów zimowych",
    features: [
      Feature("Góry", Icons.terrain),
      Feature("Park Narodowy", Icons.hiking),
      Feature("Narty", Icons.downhill_skiing),
    ],
  ),
];

@riverpod
class Places extends _$Places {
  @override
  List<Place> build() => _initialPlaces;

  void toggleFavorite(String id) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(isFavorite: !p.isFavorite) else p
    ]
  }
}