import 'package:flutter/material.dart';

/// Constants for memory creation UI
class MemoryCreationConstants {
  const MemoryCreationConstants._();

  // Animation durations
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);
  static const Duration bounceAnimationDuration = Duration(milliseconds: 1000);
  static const Duration keyboardAnimationDuration = Duration(milliseconds: 500);
  static const Duration debounceDuration = Duration(milliseconds: 500);

  // Animation curves
  static const Curve pageTransitionCurve = Curves.easeInOut;
  static const Curve bounceAnimationCurve = Curves.elasticOut;
  static const Curve keyboardAnimationCurve = Curves.easeInOut;

  // UI dimensions
  static const double emojiSelectorSize = 40.0;
  static const double emojiSelectorActiveSize = 48.0;
  static const double closeButtonSize = 48.0;
  static const double navigationButtonHeight = 80.0;
  static const double navigationButtonWidth = 70.0;
  static const double worldIconSize = 28.0;
  static const double worldIconContainerSize = 60.0;
  static const double imagePickerSize = 80.0;
  static const double sliderThumbRadius = 8.0;

  // Spacing
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 20.0;
  static const double emojiSpacing = 4.0;
  static const double worldIconSpacing = 12.0;
  static const double imageSpacing = 8.0;

  // Border radius
  static const double defaultBorderRadius = 12.0;
  static const double largeBorderRadius = 30.0;
  static const double circularBorderRadius = 50.0;

  // Particle animation
  static const double minParticleSpeed = 0.0;
  static const double maxParticleSpeed = 200.0;
  static const double minParticleRadius = 2.0;
  static const double maxParticleRadius = 5.0;
  static const int maxParticleCount = 300;
  static const double maxParticleOpacity = 0.3;

  // Slider configuration
  static const double minEmotionValue = 0.0;
  static const double maxEmotionValue = 10.0;
  static const double defaultEmotionValue = 5.0;

  // Image picker
  static const int maxImageCount = 10;
  static const String imageFileExtension = '.jpg';

  // Date picker
  static const int maxPastYears = 5;
  static const int maxFutureYears = 0;

  // Text limits
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxWorldNameLength = 50;

  // Available icons for world creation
  static const List<String> availableWorldIcons = [
    'star',
    'favorite',
    'home',
    'person',
    'music_note',
    'ac_unit',
    'cake',
    'beach_access',
    'book',
    'camera_alt',
    'flight',
    'flag',
    'lightbulb',
    'mood',
    'phone',
  ];

  // Error messages
  static const String emojiRequiredError = 'Emoji option is required';
  static const String emotionValueError =
      'Emotion value must be between 0 and 10';
  static const String futureTimeError = 'Future time not allowed';
  static const String invalidDataError = 'Invalid data provided';
  static const String storageError = 'Failed to save data';
  static const String unexpectedError = 'An unexpected error occurred';

  // Success messages
  static const String memorySavedSuccess = 'Memory saved successfully';
  static const String draftSavedSuccess = 'Draft saved successfully';
}
