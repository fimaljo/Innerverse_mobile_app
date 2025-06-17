import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/memory/data/models/memory_model.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';

class MemoryAdapter extends TypeAdapter<Memory> {
  @override
  final int typeId = 0;

  @override
  Memory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Memory(
      id: fields[0] as String,
      emojiLabel: fields[1] as String,
      riveAsset: fields[2] as String,
      emotionSliderValue: fields[3] as double,
      dateTime: fields[4] as DateTime,
      time: fields[5] as TimeOfDay,
      title: fields[6] as String?,
      description: fields[7] as String?,
      worldIcon: fields[8] as IconData,
      worldIconTitle: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Memory obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.emojiLabel)
      ..writeByte(2)
      ..write(obj.riveAsset)
      ..writeByte(3)
      ..write(obj.emotionSliderValue)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.worldIcon)
      ..writeByte(9)
      ..write(obj.worldIconTitle);
  }
}

/// Helper class for mapping between domain and data models
class MemoryMapper {
  static MemoryModel toModel(Memory memory) {
    return MemoryModel(
      id: memory.id,
      emojiLabel: memory.emojiLabel,
      riveAsset: memory.riveAsset,
      emotionSliderValue: memory.emotionSliderValue,
      dateTime: memory.dateTime,
      time: memory.time,
      worldIcon: memory.worldIcon,
      worldIconTitle: memory.worldIconTitle,
      title: memory.title,
      description: memory.description,
    );
  }

  static Memory toEntity(MemoryModel model) {
    return Memory(
      id: model.id,
      emojiLabel: model.emojiLabel,
      riveAsset: model.riveAsset,
      emotionSliderValue: model.emotionSliderValue,
      dateTime: model.dateTime,
      time: model.time,
      worldIcon: model.worldIcon,
      worldIconTitle: model.worldIconTitle,
      title: model.title,
      description: model.description,
    );
  }
}
