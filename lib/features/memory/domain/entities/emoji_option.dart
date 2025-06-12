import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'emoji_option.freezed.dart';

@freezed
class EmojiOption with _$EmojiOption {
  const factory EmojiOption({
    required String id,
    required String label,
    required List<Color> gradient,
    required Color particleColor,
  }) = _EmojiOption;
}
