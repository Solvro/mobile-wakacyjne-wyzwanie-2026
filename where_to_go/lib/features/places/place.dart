import "package:freezed_annotation/freezed_annotation.dart";
import "package:where_to_go/core/api_paths.dart";

part "place.freezed.dart";
part "place.g.dart";

@freezed
abstract class Place with _$Place {
  const factory Place({int? id, required String name, required String description, required String imageUrl, @Default(false) bool isFavourite, String? ownerEmail}) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);
}

extension PlaceX on Place {
  String get fullImageUrl {
    return "${ApiPaths.baseUrl}/photos/$imageUrl";
  }
}
