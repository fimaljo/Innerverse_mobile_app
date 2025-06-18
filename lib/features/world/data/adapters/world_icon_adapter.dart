import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

class WorldIconAdapter extends TypeAdapter<WorldIconModel> {
  @override
  final int typeId = 3;

  @override
  WorldIconModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorldIconModel(
      id: fields[0] as String,
      name: fields[1] as String,
      icon: IconData(
        fields[2] as int,
        fontFamily: fields[3] as String?,
        fontPackage: fields[4] as String?,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, WorldIconModel obj) {
    writer
      ..writeByte(5) // Total number of fields
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.icon.codePoint)
      ..writeByte(3)
      ..write(obj.icon.fontFamily)
      ..writeByte(4)
      ..write(obj.icon.fontPackage);
  }
}
