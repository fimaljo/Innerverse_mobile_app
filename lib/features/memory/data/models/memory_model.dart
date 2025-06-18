import 'package:flutter/material.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';

class MemoryModel extends Memory {
  MemoryModel({
    required super.id,
    required super.emojiLabel,
    required super.riveAsset,
    required super.emotionSliderValue,
    required super.dateTime,
    required super.time,
    required super.worldIcon,
    required super.worldIconTitle,
    super.title,
    super.description,
  });
  factory MemoryModel.fromEntity(Memory memory) {
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

  factory MemoryModel.fromJson(Map<String, dynamic> json) {
    return MemoryModel(
      id: json['id'] as String,
      emojiLabel: json['emojiLabel'] as String,
      riveAsset: json['riveAsset'] as String,
      emotionSliderValue: json['emotionSliderValue'] as double,
      dateTime: DateTime.parse(json['dateTime'] as String),
      time: TimeOfDay(
        hour: json['timeHour'] as int,
        minute: json['timeMinute'] as int,
      ),
      worldIcon: IconData(
        json['worldIconCodePoint'] as int,
        fontFamily: json['worldIconFontFamily'] as String,
        fontPackage: json['worldIconFontPackage'] as String?,
      ),
      worldIconTitle: json['worldIconTitle'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emojiLabel': emojiLabel,
      'riveAsset': riveAsset,
      'emotionSliderValue': emotionSliderValue,
      'dateTime': dateTime.toIso8601String(),
      'timeHour': time.hour,
      'timeMinute': time.minute,
      'worldIconCodePoint': worldIcon.codePoint,
      'worldIconFontFamily': worldIcon.fontFamily,
      'worldIconFontPackage': worldIcon.fontPackage,
      'worldIconTitle': worldIconTitle,
      'title': title,
      'description': description,
    };
  }
}
