import "package:flutter/material.dart";

class Feature {
  final String name;
  final IconData icon;

  const Feature(this.name, this.icon);

  static const all = [
    Feature("Plaża piasczysta", Icons.beach_access),
    Feature("Plaża kamienista", Icons.beach_access),
    Feature("Jedzenie", Icons.fastfood),
    Feature("Słońce", Icons.sunny),
    Feature("Życie nocne", Icons.nightlife),
    Feature("Duże miasto", Icons.location_city),
    Feature("Stolica", Icons.location_city),
    Feature("Nad rzeką", Icons.water),
    Feature("Góry", Icons.terrain),
    Feature("Park Narodowy", Icons.hiking),
    Feature("Narty", Icons.downhill_skiing),
  ];
}

class Place {
  final String id;
  final String title;
  final String homeImagePath;
  final String pageImagePath;
  final String pageTitle;
  final String description;
  final List<Feature> features;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.homeImagePath,
    required this.pageImagePath,
    required this.pageTitle,
    required this.description,
    required this.features,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      homeImagePath: homeImagePath,
      pageImagePath: pageImagePath,
      pageTitle: pageTitle,
      description: description,
      features: features,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
