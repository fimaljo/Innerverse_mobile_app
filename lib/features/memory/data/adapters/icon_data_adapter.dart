import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final int typeId = 2; // Make sure this doesn't conflict with other adapters

  @override
  IconData read(BinaryReader reader) {
    final codePoint = reader.readInt();
    final fontFamily = reader.readString();
    final fontPackage = reader.readString();
    final matchTextDirection = reader.readBool();
    return IconData(
      codePoint,
      fontFamily: fontFamily,
      fontPackage: fontPackage,
      matchTextDirection: matchTextDirection,
    );
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    writer
      ..writeInt(obj.codePoint)
      ..writeString(obj.fontFamily ?? '')
      ..writeString(obj.fontPackage ?? '')
      ..writeBool(obj.matchTextDirection);
  }
}
