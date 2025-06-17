import 'package:flutter/material.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';

final List<EmojiOption> emojiOptions = [
  const EmojiOption(
    riveAsset: 'positive',
    label: 'Positive',
    gradient: [Color(0xFFFFE680), Color(0xFFFFC31E)],
    particleColor: Colors.white,
  ),
  const EmojiOption(
    riveAsset: 'neutral',
    label: 'Neutral',
    gradient: [Color(0xFFF3E7FF), Color(0xFFD6B3FA)],
    particleColor: Colors.deepPurpleAccent,
  ),
  const EmojiOption(
    riveAsset: 'sad',
    label: 'Sad',
    gradient: [Color(0xFFFFD1E9), Color(0xFFFF8AC4)],
    particleColor: Colors.blueAccent, // bright blue for contrast
  ),
  const EmojiOption(
    riveAsset: 'angry',
    label: 'Angry',
    gradient: [Color(0xFFFFB3B3), Color(0xFFFF5555)],
    particleColor: Colors.black, // bold contrast for red background
  ),
  const EmojiOption(
    riveAsset: 'fearful',
    label: 'Fearful',
    gradient: [Color(0xFFF2D8FF), Color(0xFFD7A1F9)],
    particleColor: Colors.deepPurple, // dark purple stands out on light violet
  ),
];
