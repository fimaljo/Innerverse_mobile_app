import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';

part 'memory.g.dart';

@HiveType(typeId: 0)
class Memory extends HiveObject {
  Memory({
    required this.id,
    required this.emojiLabel,
    required this.riveAsset,
    required this.emotionSliderValue,
    required this.dateTime,
    required this.time,
    required this.worldIcon,
    required this.worldIconTitle,
    this.title,
    this.description,
  });

  factory Memory.fromEmojiOption({
    required String id,
    required EmojiOption emojiOption,
    required double emotionSliderValue,
    required DateTime dateTime,
    required TimeOfDay time,
    required IconData worldIcon,
    required String worldIconTitle,
    String? title,
    String? description,
  }) {
    return Memory(
      id: id,
      emojiLabel: emojiOption.label,
      riveAsset: emojiOption.riveAsset,
      emotionSliderValue: emotionSliderValue,
      dateTime: dateTime,
      time: time,
      title: title,
      description: description,
      worldIcon: worldIcon,
      worldIconTitle: worldIconTitle,
    );
  }
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String emojiLabel;

  @HiveField(2)
  final String riveAsset;

  @HiveField(3)
  final double emotionSliderValue;

  @HiveField(4)
  final DateTime dateTime;

  @HiveField(5)
  final TimeOfDay time;

  @HiveField(6)
  final String? title;

  @HiveField(7)
  final String? description;

  @HiveField(8)
  final IconData worldIcon;

  @HiveField(9)
  final String worldIconTitle;

  EmojiOption get emojiOption => EmojiOption(
    riveAsset: riveAsset,
    label: emojiLabel,
    gradient: [],
    particleColor: Colors.white,
  );
}
