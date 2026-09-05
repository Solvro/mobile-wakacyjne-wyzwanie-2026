import "../gen/assets.gen.dart";
import "place_feature.dart";

class Place {
  final String id;
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
}
