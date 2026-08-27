import "package:flutter/material.dart";

class Feature {
  final String name;
  final IconData icon;

  const Feature(this.name, this.icon);
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
