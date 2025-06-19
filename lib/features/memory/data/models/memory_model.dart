import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

part 'memory_model.freezed.dart';
part 'memory_model.g.dart';

@freezed
@HiveType(typeId: 6)
class MemoryModel with _$MemoryModel {
  const factory MemoryModel({
    @HiveField(0) required String id,
    @HiveField(1) required String emojiLabel,
    @HiveField(2) required String riveAsset,
    @HiveField(3) required double emotionSliderValue,
    @HiveField(4) required DateTime dateTime,
    @HiveField(5) @TimeOfDayConverter() required TimeOfDay time,
    @HiveField(8)
    @WorldIconModelListConverter()
    required List<WorldIconModel> worldIcons,
    @HiveField(6) String? title,
    @HiveField(7) String? description,
    @HiveField(9) List<String>? images,
  }) = _MemoryModel;
  factory MemoryModel.fromJson(Map<String, dynamic> json) =>
      _$MemoryModelFromJson(json);
}

class TimeOfDayConverter
    implements JsonConverter<TimeOfDay, Map<String, dynamic>> {
  const TimeOfDayConverter();

  @override
  TimeOfDay fromJson(Map<String, dynamic> json) {
    return TimeOfDay(
      hour: json['hour'] as int,
      minute: json['minute'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson(TimeOfDay time) {
    return {
      'hour': time.hour,
      'minute': time.minute,
    };
  }
}

class WorldIconModelConverter
    implements JsonConverter<WorldIconModel, Map<String, dynamic>> {
  const WorldIconModelConverter();

  @override
  WorldIconModel fromJson(Map<String, dynamic> json) {
    return WorldIconModel(
      id: json['id'] as String,
      name: json['name'] as String,
      icon: IconData(
        json['icon']['codePoint'] as int,
        fontFamily: json['icon']['fontFamily'] as String,
        fontPackage: json['icon']['fontPackage'] as String?,
      ),
    );
  }

  @override
  Map<String, dynamic> toJson(WorldIconModel model) {
    return {
      'id': model.id,
      'name': model.name,
      'icon': {
        'codePoint': model.icon.codePoint,
        'fontFamily': model.icon.fontFamily,
        'fontPackage': model.icon.fontPackage,
      },
    };
  }
}

class WorldIconModelListConverter
    implements JsonConverter<List<WorldIconModel>, List<Map<String, dynamic>>> {
  const WorldIconModelListConverter();

  @override
  List<WorldIconModel> fromJson(List<Map<String, dynamic>> json) {
    return json
        .map((item) => WorldIconModel(
              id: item['id'] as String,
              name: item['name'] as String,
              icon: IconData(
                item['icon']['codePoint'] as int,
                fontFamily: item['icon']['fontFamily'] as String,
                fontPackage: item['icon']['fontPackage'] as String?,
              ),
            ))
        .toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<WorldIconModel> models) {
    return models
        .map((model) => {
              'id': model.id,
              'name': model.name,
              'icon': {
                'codePoint': model.icon.codePoint,
                'fontFamily': model.icon.fontFamily,
                'fontPackage': model.icon.fontPackage,
              },
            })
        .toList();
  }
}

class IconDataConverter
    implements JsonConverter<IconData, Map<String, dynamic>> {
  const IconDataConverter();

  @override
  IconData fromJson(Map<String, dynamic> json) {
    return IconData(
      json['codePoint'] as int,
      fontFamily: json['fontFamily'] as String,
      fontPackage: json['fontPackage'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson(IconData icon) {
    return {
      'codePoint': icon.codePoint,
      'fontFamily': icon.fontFamily,
      'fontPackage': icon.fontPackage,
    };
  }
}

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
