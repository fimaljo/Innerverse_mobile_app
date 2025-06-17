// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

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
      worldIcon: fields[8] as IconData,
      worldIconTitle: fields[9] as String,
      title: fields[6] as String?,
      description: fields[7] as String?,
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

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
