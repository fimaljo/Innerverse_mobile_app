import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/memory/domain/entities/world_icon.dart';

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
      icon: IconData(fields[1] as int, fontFamily: 'MaterialIcons'),
    );
  }

  @override
  void write(BinaryWriter writer, WorldIcon obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.icon.codePoint);
  }
}
