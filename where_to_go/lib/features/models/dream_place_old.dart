import "attraction.dart";

class DreamPlace {
  final String title;
  final String imagePath;
  final String placeName;
  final String description;
  final List<Attraction> attractions;

  const DreamPlace({
    required this.title,
    required this.imagePath,
    required this.placeName,
    required this.description,
    required this.attractions,
  });
}
