import "../../gen/assets.gen.dart";

class Place {
  final int id;
  final String title;
  final String description;
  final AssetGenImage photo;
  final bool isFavorite;

  Place(
      {required this.id, required this.title, required this.description, required this.photo, this.isFavorite = false});

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      photo: photo,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
