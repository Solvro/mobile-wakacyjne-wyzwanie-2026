import "package:flutter/material.dart";

class Place {
  final String id;
  final String title;
  final String imagePath;
  final String locationTitle;
  final String description;
  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final String iconText1;
  final String iconText2;
  final String iconText3;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.locationTitle,
    required this.description,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.iconText1,
    required this.iconText2,
    required this.iconText3,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      imagePath: imagePath,
      locationTitle: locationTitle,
      description: description,
      icon1: icon1,
      icon2: icon2,
      icon3: icon3,
      iconText1: iconText1,
      iconText2: iconText2,
      iconText3: iconText3,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
