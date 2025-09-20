import "package:hive/hive.dart";
import "dreamplace.dart";

class DreamPlaceAdapter extends TypeAdapter<DreamPlace> {
  @override
  final typeId = 1;

  @override
  DreamPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return DreamPlace(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      assetPath: fields[3] as String,
      isFavorite: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DreamPlace obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.assetPath)
      ..writeByte(4)
      ..write(obj.isFavorite);
  }
}
