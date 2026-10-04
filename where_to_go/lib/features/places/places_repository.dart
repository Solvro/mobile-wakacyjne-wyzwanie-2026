import 'package:dio/dio.dart';
import 'package:where_to_go/features/places/place.dart';
import '../../core/api_paths.dart';

class PlacesRepository {
  PlacesRepository(this._dio);

  final Dio _dio;

  Future<List<Place>> initializePlaces() async {
    try {
      List<Place> returnPlaces = [];
      final response = await _dio.get(ApiPaths.places);
      final numberOfPlaces = response.data["total"];
      if(numberOfPlaces == 0) {
        for (Place place in _initialPlaces) {
          final response = await _dio.post(ApiPaths.places, data: place.toJson());
          returnPlaces.add(place.copyWith(id: response.data["id"], ownerEmail: response.data["ownerEmail"]));
        }
      }
      else {
        for (final place in response.data["results"]) {
          returnPlaces.add(Place.fromJson(place));
        }
      }
      return returnPlaces;
    } on DioException catch(e) {
      throw Exception(e.response?.statusCode);
    }
  }

  Future<Map<String, dynamic>> uploadPlace(Place place) async {
    try {
      final response = await _dio.post(ApiPaths.places, data: place.toJson());
      return response.data;
    } on DioException catch(e) {
      throw Exception(e.response?.statusCode);
    }
  }

  Future<void> updateFavourite(Place place) async {
    try{
      await _dio.put(ApiPaths.placeById(place.id), data: place.copyWith(isFavourite: !place.isFavourite).toJson());
    } on DioException catch(e) {
      throw Exception(e.response?.statusCode);
    }
  }
}

const _initialPlaces = [
  const Place(
    name: "Lagonisi, Grecja",
    imageUrl: "3a3ca7d2-e485-416f-9dd2-a5201a6d2d13.jpg",
    description: "Nadmorska dzielnica mieszkaniowa na Riwierze Ateńskiej i południowej części Kalyvia Thorikou we wschodniej Attyce.",
  ),
  const Place(
    name: "Vodice, Chorwacja",
    imageUrl: "cd154bc9-d751-4463-9641-3505f3c2045d.jpg",
    description: "Miasto i port w Chorwacji, w żupanii szybenicko-knińskiej, siedziba miasta Vodice.",
  ),
  const Place(
    name: "Tokio, Japonia",
    imageUrl: "01e57e38-0f7e-4ee1-9837-f5ff1e6b1d8d.jpg",
    description: "Stolica i największe miasto Japonii, położone na południowo-wschodnim wybrzeżu Honsiu i zarazem największy obszar metropolitalny na świecie.",
  ),
  const Place(
    name: "Madryt, Hiszpania",
    imageUrl: "dc5427ab-981b-49c3-a734-c5904c34f022.jpg",
    description: "Stolica i największe miasto Hiszpanii, położone w środkowej części kraju, nad rzeką Manzanares.",
  ),
  const Place(
    name: "Zakopane, Polska",
    imageUrl: "c431ba87-04ad-4b0b-8d85-a3eccf5f388f.jpg",
    description: "Miasto w południowej Polsce, największa miejscowość w bezpośrednim otoczeniu Tatr, duży ośrodek sportów zimowych",
  ),
];
