import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

class WorldIconModelListAdapter extends TypeAdapter<List<WorldIconModel>> {
  @override
  final int typeId = 10; // Use a unique type ID

  @override
  List<WorldIconModel> read(BinaryReader reader) {
    final length = reader.readInt();
    return List.generate(length, (index) {
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
    });
  }

  @override
  void write(BinaryWriter writer, List<WorldIconModel> obj) {
    writer.writeInt(obj.length);
    for (final item in obj) {
      writer
        ..writeByte(5) // Total number of fields
        ..writeByte(0)
        ..write(item.id)
        ..writeByte(1)
        ..write(item.name)
        ..writeByte(2)
        ..write(item.icon.codePoint)
        ..writeByte(3)
        ..write(item.icon.fontFamily)
        ..writeByte(4)
        ..write(item.icon.fontPackage);
    }
  }
}
