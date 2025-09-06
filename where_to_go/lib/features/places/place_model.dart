class PlaceModel {
  final int id;
  final String name;
  final String description;
  final bool isFavorite;
  //final List<PlaceFeature> features;
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

  PlaceModel copyWith({bool? isFavorite}) {
    return PlaceModel(
      id: id,
      name: name,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
      ownerEmail: ownerEmail,
      imageUrl: imageUrl,
    );
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json["id"] as int,
      name: json["name"] as String,
      description: json["description"] as String,
      imageUrl: json["imageUrl"] as String? ?? "",
      isFavorite: json["isFavorite"] as bool? ?? false,
      ownerEmail: json["ownerEmail"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "imageUrl": imageUrl,
      "isFavorite": isFavorite,
    };
  }
}
