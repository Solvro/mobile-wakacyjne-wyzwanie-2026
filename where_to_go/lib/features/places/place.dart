class Place {
  final String id;
  final String title;
  final String imagePath;
  final String description;
  final String weather;
  final String temperature;
  final String wind;
  final List<String> activities;
  final bool isFavorite;

  const Place({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.weather,
    required this.temperature,
    required this.wind,
    required this.activities,
    this.isFavorite = false,
  });

  Place copyWith({
    String? id,
    String? title,
    String? imagePath,
    String? description,
    String? weather,
    String? temperature,
    String? wind,
    List<String>? activities,
    bool? isFavorite,
  }) {
    return Place(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      weather: weather ?? this.weather,
      temperature: temperature ?? this.temperature,
      wind: wind ?? this.wind,
      activities: activities ?? this.activities,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
