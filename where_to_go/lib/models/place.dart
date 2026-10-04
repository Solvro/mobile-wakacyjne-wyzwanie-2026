import "../gen/assets.gen.dart";
import "place_feature.dart";

class Place {
  final int id;
  final String title;
  final String descriptionTitle;
  final String description;
  final List<PlaceFeature> features;
  final AssetGenImage image;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.descriptionTitle,
    required this.description,
    required this.features,
    required this.image,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      descriptionTitle: descriptionTitle,
      description: description,
      features: features,
      image: image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json["id"] as int,
      title: json["name"] as String,
      descriptionTitle: json["name"] as String,
      description: (json["description"] as String?) ?? "",
      features: const [], // Features usually don't come from this simple API, filled locally in PlacesProvider
      image: AssetGenImage((json["imageUrl"] as String?) ?? ""),
      isFavorite: (json["isFavourite"] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": title, "description": description, "imageUrl": image.path, "isFavourite": isFavorite};
  }
}
