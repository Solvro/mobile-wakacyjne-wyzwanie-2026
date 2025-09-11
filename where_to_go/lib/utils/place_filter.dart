import "dart:core";

import "../models/place/place_response_dto.dart";

class PlaceFilter {
  static List<PlaceResponseDto> findPlaces(List<PlaceResponseDto> places,
      {required String searchQuery, required bool showFavourite}) {
    List<PlaceResponseDto> filteredPlaces = places;

    if (searchQuery.isNotEmpty) {
      filteredPlaces = places.where((place) {
        return place.name.toLowerCase().startsWith(searchQuery);
      }).toList();
    }

    if (showFavourite) {
      filteredPlaces = filteredPlaces.where((place) {
        return place.isFavourite;
      }).toList();
    }

    return filteredPlaces;
  }
}
