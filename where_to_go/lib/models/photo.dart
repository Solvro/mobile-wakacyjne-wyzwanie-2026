// lib/models/photo.dart
import "package:freezed_annotation/freezed_annotation.dart";

part "photo.freezed.dart";
part "photo.g.dart";

@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    required String id,
    required String filename,
    required String originalName,
    required String mimeType,
    required int size,
    required String url,
    required DateTime createdAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}
