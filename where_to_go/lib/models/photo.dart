// lib/models/photo.dart
import "package:freezed_annotation/freezed_annotation.dart";

part "photo.freezed.dart";
part "photo.g.dart";

@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    required String id,
    required String
        filename, // backend wymaga 'imageUrl' do wysłania zdjęcia podczas tworzenia miejsca (POST /places) choć tak naprawdę wymaga samej nazwy pliku (błąd w nazewnictwie)
    required String originalName,
    required String mimeType,
    required int size,
    required String path,
    required DateTime createdAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
