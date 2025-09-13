class PhotoModel {
  final String id;
  final String fileName;
  final String originalName;
  final String mimeType;
  final int size;
  final String path;
  final DateTime createdAt;

  const PhotoModel({
    required this.id,
    required this.fileName,
    required this.originalName,
    required this.mimeType,
    required this.size,
    required this.path,
    required this.createdAt,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json["id"] as String,
      fileName: json["filename"] as String,
      originalName: json["originalName"] as String,
      mimeType: json["mimeType"] as String,
      size: json["size"] as int,
      path: json["path"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
    );
  }
}
