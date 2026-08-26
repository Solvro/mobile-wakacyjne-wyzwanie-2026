class Place {
  final String id;
  final String name;
  final String imagePath;
  final String description;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.description,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      name: name,
      imagePath: imagePath,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
