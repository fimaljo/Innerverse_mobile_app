import 'package:flutter/material.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/domain/entities/memory.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';
import 'package:uuid/uuid.dart';

/// Domain entity representing the data needed to create a memory
class MemoryCreationData {
  MemoryCreationData({
    required this.emojiOption,
    required this.emotionSliderValue,
    this.dateTime,
    this.time,
    this.title,
    this.description,
    this.worldIcons = const [],
    this.images,
  });

  EmojiOption emojiOption;
  double emotionSliderValue;
  DateTime? dateTime;
  TimeOfDay? time;
  String? title;
  String? description;
  List<WorldIconModel> worldIcons;
  List<String>? images;

  /// Creates a copy of this entity with the given fields replaced
  MemoryCreationData copyWith({
    EmojiOption? emojiOption,
    double? emotionSliderValue,
    DateTime? dateTime,
    TimeOfDay? time,
    String? title,
    String? description,
    List<WorldIconModel>? worldIcons,
    List<String>? images,
  }) {
    return MemoryCreationData(
      emojiOption: emojiOption ?? this.emojiOption,
      emotionSliderValue: emotionSliderValue ?? this.emotionSliderValue,
      dateTime: dateTime ?? this.dateTime,
      time: time ?? this.time,
      title: title ?? this.title,
      description: description ?? this.description,
      worldIcons: worldIcons ?? this.worldIcons,
      images: images ?? this.images,
    );
  }

  /// Converts this entity to a Memory domain entity
  Memory toMemory() {
    return Memory.fromEmojiOption(
      id: const Uuid().v4(),
      emojiOption: emojiOption,
      emotionSliderValue: emotionSliderValue,
      dateTime: dateTime ?? DateTime.now(),
      time: time ?? TimeOfDay.now(),
      title: title,
      description: description,
      worldIcons: worldIcons,
      images: images,
    );
  }

  /// Validates if the memory creation data is complete
  bool get isValid {
    return emojiOption != null &&
        emotionSliderValue >= 0 &&
        emotionSliderValue <= 10;
  }

  /// Gets the validation errors for this data
  List<String> get validationErrors {
    final errors = <String>[];

    if (emojiOption == null) {
      errors.add('Emoji option is required');
    }

    if (emotionSliderValue < 0 || emotionSliderValue > 10) {
      errors.add('Emotion value must be between 0 and 10');
    }

    return errors;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MemoryCreationData &&
        other.emojiOption == emojiOption &&
        other.emotionSliderValue == emotionSliderValue &&
        other.dateTime == dateTime &&
        other.time == time &&
        other.title == title &&
        other.description == description &&
        other.worldIcons == worldIcons &&
        other.images == images;
  }

  @override
  int get hashCode {
    return Object.hash(
      emojiOption,
      emotionSliderValue,
      dateTime,
      time,
      title,
      description,
      worldIcons,
      images,
    );
  }

  @override
  String toString() {
    return 'MemoryCreationData(emojiOption: $emojiOption, emotionSliderValue: $emotionSliderValue, dateTime: $dateTime, time: $time, title: $title, description: $description, worldIcons: $worldIcons, images: $images)';
  }
}
