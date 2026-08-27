import "../gen/assets.gen.dart";

class Place {
  final String id;
  final String name;
  final String country;
  final String description;
  final AssetGenImage imagePath;
  final bool isFavorite;

  Place({
    required this.id,
    required this.name,
    required this.country,
    required this.description,
    required this.imagePath,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      name: name,
      country: country,
      description: description,
      imagePath: imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
