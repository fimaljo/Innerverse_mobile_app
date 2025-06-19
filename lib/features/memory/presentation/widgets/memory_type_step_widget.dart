import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/domain/entities/memory_creation_data.dart';
import 'package:innerverse/features/memory/presentation/widgets/emotion_slider_widget.dart';
import 'package:innerverse/features/memory/presentation/widgets/emoji_selector_widget.dart';

class MemoryTypeStepWidget extends StatelessWidget {
  const MemoryTypeStepWidget({
    super.key,
    required this.speed,
    required this.selectedIndex,
    required this.selectedEmoji,
    required this.onSpeedChanged,
    required this.onNextPressed,
    required this.onEmojiSelected,
    required this.memoryData,
    required this.bounceAnimation,
  });

  final double speed;
  final int selectedIndex;
  final EmojiOption selectedEmoji;
  final void Function(double) onSpeedChanged;
  final VoidCallback onNextPressed;
  final void Function(int index, {bool fromBottom}) onEmojiSelected;
  final MemoryCreationData memoryData;
  final Animation<double> bounceAnimation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              EmojiSelectorWidget(
                selectedIndex: selectedIndex,
                onEmojiSelected: (index) {
                  onEmojiSelected(index, fromBottom: true);
                  memoryData.emojiOption = emojiOptions[index];
                },
                bounceAnimation: bounceAnimation,
              ),
              const SizedBox(height: 20),
              Text(
                'How does \nthis memory feel?',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: EmotionSliderWidget(
            selectedEmoji: selectedEmoji,
            onChanged: (value) {
              onSpeedChanged(value);
              memoryData.emotionSliderValue = value;
            },
            onNextPressed: onNextPressed,
            initialValue: memoryData.emotionSliderValue,
          ),
        ),
      ],
    );
  }
}
