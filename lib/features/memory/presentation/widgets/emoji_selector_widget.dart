import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart' as rive;
import 'package:innerverse/core/constants/emoji_options.dart';
import 'package:innerverse/features/memory/domain/entities/emoji_option.dart';
import 'package:innerverse/features/memory/presentation/constants/memory_creation_constants.dart';

/// Widget for selecting emoji options in memory creation
class EmojiSelectorWidget extends StatelessWidget {
  const EmojiSelectorWidget({
    required this.selectedIndex,
    required this.onEmojiSelected,
    required this.bounceAnimation,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onEmojiSelected;
  final Animation<double> bounceAnimation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(emojiOptions.length, (index) {
        final isActive = index == selectedIndex;
        return GestureDetector(
          onTap: () {
            onEmojiSelected(index);
            HapticFeedback.lightImpact();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: MemoryCreationConstants.emojiSpacing,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isActive)
                  Container(
                    height: MemoryCreationConstants.emojiSelectorActiveSize,
                    width: MemoryCreationConstants.emojiSelectorActiveSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                  ),
                Container(
                  height: MemoryCreationConstants.emojiSelectorSize,
                  width: MemoryCreationConstants.emojiSelectorSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: emojiOptions[index].gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      width: isActive ? 1 : 0.5,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

/// Widget for displaying the selected emoji with animation
class EmojiDisplayWidget extends StatelessWidget {
  const EmojiDisplayWidget({
    required this.selectedEmoji,
    required this.bounceAnimation,
    super.key,
  });

  final EmojiOption selectedEmoji;
  final Animation<double> bounceAnimation;

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: bounceAnimation,
      child: Transform.translate(
        offset: const Offset(0, -20),
        child: rive.RiveAnimation.asset(
          'assets/rive/innerverse3.riv',
          artboard: selectedEmoji.riveAsset,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
