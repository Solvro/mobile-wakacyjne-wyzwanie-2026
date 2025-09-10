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
    required String imageUrl,
    bool? isFavourite,
  }) = _DreamPlace;
  const DreamPlace._();

  factory DreamPlace.fromJson(Map<String, dynamic> json) => _$DreamPlaceFromJson(json);

  // Pełny URL do obrazka – używamy tylko w UI
  String get url => "https://backend-api.w.solvro.pl/photos/$imageUrl";
}
