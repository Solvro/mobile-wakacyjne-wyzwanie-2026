// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DreamPlaceAdapter extends TypeAdapter<DreamPlace> {
  @override
  final int typeId = 0;

  @override
  DreamPlace read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DreamPlace(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      imageUrl: fields[3] as String,
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
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DreamPlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
