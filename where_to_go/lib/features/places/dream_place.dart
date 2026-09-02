import 'package:hive/hive.dart';

part 'dream_place.g.dart';

@HiveType(typeId: 0)
class DreamPlace extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imagePath;

  @HiveField(4)
  bool isFavorite;

  DreamPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.isFavorite,
  });
}
