class PlaceModel {
  final int id;
  final String name;
  final String description;
  final bool isFavorite;
  final String imageUrl;
  final String ownerEmail;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.description,
    this.isFavorite = false,
    required this.ownerEmail,
    required this.imageUrl,
  });

  PlaceModel copyWith({
    int? id,
    String? name,
    String? description,
    bool? isFavorite,
    String? ownerEmail,
    String? imageUrl,
  }) {
    return PlaceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json["id"] as int,
      name: json["name"] as String,
      description: json["description"] as String,
      imageUrl: json["imageUrl"] as String? ?? "",
      isFavorite: (json["isFavorite"] ?? json["isFavourite"]) as bool? ?? false,
      ownerEmail: json["ownerEmail"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "isFavourite": isFavorite,
    };
  }
}