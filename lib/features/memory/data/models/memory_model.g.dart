// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoryModelAdapter extends TypeAdapter<MemoryModel> {
  @override
  final int typeId = 6;

  @override
  MemoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryModel(
      id: fields[0] as String,
      emojiLabel: fields[1] as String,
      riveAsset: fields[2] as String,
      emotionSliderValue: fields[3] as double,
      dateTime: fields[4] as DateTime,
      time: fields[5] as TimeOfDay,
      worldIcons: (fields[8] as List).cast<WorldIconModel>(),
      title: fields[6] as String?,
      description: fields[7] as String?,
      images: (fields[9] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MemoryModel obj) {
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
      ..writeByte(8)
      ..write(obj.worldIcons)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoryModelImpl _$$MemoryModelImplFromJson(Map<String, dynamic> json) =>
    _$MemoryModelImpl(
      id: json['id'] as String,
      emojiLabel: json['emojiLabel'] as String,
      riveAsset: json['riveAsset'] as String,
      emotionSliderValue: (json['emotionSliderValue'] as num).toDouble(),
      dateTime: DateTime.parse(json['dateTime'] as String),
      time: const TimeOfDayConverter()
          .fromJson(json['time'] as Map<String, dynamic>),
      worldIcons: const WorldIconModelListConverter()
          .fromJson(json['worldIcons'] as List<Map<String, dynamic>>),
      title: json['title'] as String?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$MemoryModelImplToJson(_$MemoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'emojiLabel': instance.emojiLabel,
      'riveAsset': instance.riveAsset,
      'emotionSliderValue': instance.emotionSliderValue,
      'dateTime': instance.dateTime.toIso8601String(),
      'time': const TimeOfDayConverter().toJson(instance.time),
      'worldIcons':
          const WorldIconModelListConverter().toJson(instance.worldIcons),
      'title': instance.title,
      'description': instance.description,
      'images': instance.images,
    };
