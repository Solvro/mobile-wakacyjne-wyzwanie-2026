// lib/models/dream_place.dart

import "package:freezed_annotation/freezed_annotation.dart";

part "dream_place.freezed.dart";
part "dream_place.g.dart";

@freezed
abstract class DreamPlace with _$DreamPlace {
  const factory DreamPlace({
    int? id,
    required String name,
    required String description,
    @JsonKey(name: "imageUrl")
    required String
        filename, // robie tak, gdyż backend wymaga 'imageUrl' choć tak naprawdę wymaga samej nazwy pliku (błąd w nazewnictwie)
    bool? isFavourite,
  }) = _DreamPlace;

  factory DreamPlace.fromJson(Map<String, dynamic> json) => _$DreamPlaceFromJson(json);

  const DreamPlace._();
  String get fullimageUrl => "https://backend-api.w.solvro.pl/photos/$filename";
}
