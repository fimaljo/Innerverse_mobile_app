import 'package:flutter/material.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';

class Memory {
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

  final String id;
  final String emojiLabel;
  final String riveAsset;
  final double emotionSliderValue;
  final DateTime dateTime;
  final TimeOfDay time;
  final String? title;
  final String? description;
  final IconData worldIcon;
  final String worldIconTitle;

  EmojiOption get emojiOption => EmojiOption(
    riveAsset: riveAsset,
    label: emojiLabel,
    gradient: [],
    particleColor: Colors.white,
  );
}
