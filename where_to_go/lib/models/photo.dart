// lib/models/photo.dart
class Photo {
  final String id;
  final String filename;
  final String originalName;
  final String mimeType;
  final int size;
  final String path;
  final DateTime createdAt;

  Photo({
    required this.id,
    required this.filename,
    required this.originalName,
    required this.mimeType,
    required this.size,
    required this.path,
    required this.createdAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json["id"] as String,
      filename: json["filename"] as String,
      originalName: json["originalName"] as String,
      mimeType: json["mimeType"] as String,
      size: json["size"] as int,
      path: json["path"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "filename": filename,
      "originalName": originalName,
      "mimeType": mimeType,
      "size": size,
      "path": path,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
