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
    required String path,
    required DateTime createdAt,
  }) = _Photo;
  const Photo._();

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  /// 🔹 Pełny URL (z path + backend URL)
  String get url => "https://backend-api.w.solvro.pl$path";
}
