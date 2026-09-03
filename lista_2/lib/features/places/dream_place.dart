import 'package:hive/hive.dart';

part 'dream_place.g.dart';

@HiveType(typeId: 0)
class DreamPlace extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String imageUrl;

  @HiveField(4)
  bool isFavorite;

  //kostruktor 
  DreamPlace({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isFavorite,
  });
}