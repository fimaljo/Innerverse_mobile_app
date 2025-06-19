import 'package:flutter/material.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/world/data/models/world_icon_model.dart';

class Memory {
  Memory({
    required this.id,
    required this.emojiLabel,
    required this.riveAsset,
    required this.emotionSliderValue,
    required this.dateTime,
    required this.time,
    required this.worldIcons,
    this.title,
    this.description,
    this.images,
  });

  factory Memory.fromEmojiOption({
    required String id,
    required EmojiOption emojiOption,
    required double emotionSliderValue,
    required DateTime dateTime,
    required TimeOfDay time,
    required List<WorldIconModel> worldIcons,
    String? title,
    String? description,
    List<String>? images,
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
      worldIcons: worldIcons,
      images: images,
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
  final List<WorldIconModel> worldIcons;
  final List<String>? images;

  // Backward compatibility getters
  IconData get worldIcon =>
      worldIcons.isNotEmpty ? worldIcons.first.icon : Icons.star;
  String get worldIconTitle =>
      worldIcons.isNotEmpty ? worldIcons.first.name : 'Default';

  EmojiOption get emojiOption => EmojiOption(
        riveAsset: riveAsset,
        label: emojiLabel,
        gradient: [],
        particleColor: Colors.white,
      );
}
