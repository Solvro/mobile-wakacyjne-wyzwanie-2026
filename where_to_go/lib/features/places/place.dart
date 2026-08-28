class Place {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.description,
    this.isFavorite = false,
  });

  Place copyWith({bool? isFavorite}) {
    return Place(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}