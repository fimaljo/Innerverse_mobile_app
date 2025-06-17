// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'world_icon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorldIconAdapter extends TypeAdapter<WorldIcon> {
  @override
  final int typeId = 3;

  @override
  WorldIcon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorldIcon(
      name: fields[0] as String,
      icon: fields[1] as IconData,
    );
  }

  @override
  void write(BinaryWriter writer, WorldIcon obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.icon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorldIconAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
