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
    @HiveField(8) @WorldIconModelConverter() required WorldIconModel worldIcon,
    @HiveField(6) String? title,
    @HiveField(7) String? description,
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
