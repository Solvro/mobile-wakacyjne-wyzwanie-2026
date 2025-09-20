class DreamPlace {
  final String id;
  final String name;
  final String description;
  final String assetPath;
  final bool isFavorite;

  const DreamPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.assetPath,
    this.isFavorite = false,
  });

  DreamPlace copyWith({
    String? id,
    String? name,
    String? description,
    String? assetPath,
    bool? isFavorite,
  }) {
    return DreamPlace(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      assetPath: assetPath ?? this.assetPath,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory DreamPlace.fromJson(Map<String, dynamic> json) {
    return DreamPlace(
      id: (json["id"] ?? "").toString(),
      name: json["name"] as String? ?? "",
      description: json["description"] as String? ?? "",
      assetPath: json["imageUrl"] as String? ?? json["photoUrl"] as String? ?? "",
      isFavorite: json["isFavorite"] as bool? ?? json["isFavourite"] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "imageUrl": assetPath,
      "isFavorite": isFavorite,
    };
  }
}
