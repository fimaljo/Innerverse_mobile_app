// lib/core/themes/color_scheme.dart
import 'package:flutter/material.dart';

class AppColorScheme {
  AppColorScheme._();

  // Emotional Colors for Worlds
  static const Color loveColor = Color(0xFFFF6B9D);
  static const Color familyColor = Color(0xFF4ECDC4);
  static const Color friendshipColor = Color(0xFFFFBE0B);
  static const Color happinessColor = Color(0xFFFCE38A);
  static const Color sadnessColor = Color(0xFF95E1D3);
  static const Color peaceColor = Color(0xFFB8E6B8);
  static const Color angerColor = Color(0xFFFF6B6B);
  static const Color fearColor = Color(0xFF9B59B6);

  // Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6C5CE7),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE8E5FF),
    onPrimaryContainer: Color(0xFF1F0054),
    secondary: Color(0xFFFF7675),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFFFE4E4),
    onSecondaryContainer: Color(0xFF5A0000),
    tertiary: Color(0xFF00CEC9),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFB8F5F2),
    onTertiaryContainer: Color(0xFF003B3A),
    error: Color(0xFFE74C3C),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFE4E1),
    onErrorContainer: Color(0xFF5A0A00),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1C1B1E),
    surfaceContainerHighest: Color(0xFFF3F0F7),
    onSurfaceVariant: Color(0xFF46454A),
    outline: Color(0xFF77757A),
    outlineVariant: Color(0xFFC7C5CA),
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4F0F7),
    inversePrimary: Color(0xFFCDC2FF),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );

  // Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFCDC2FF),
    onPrimary: Color(0xFF351A79),
    primaryContainer: Color(0xFF4D3A91),
    onPrimaryContainer: Color(0xFFE8E5FF),
    secondary: Color(0xFFFFB3B3),
    onSecondary: Color(0xFF5A0000),
    secondaryContainer: Color(0xFF7D2D2D),
    onSecondaryContainer: Color(0xFFFFE4E4),
    tertiary: Color(0xFF4DFFFC),
    onTertiary: Color(0xFF003B3A),
    tertiaryContainer: Color(0xFF005755),
    onTertiaryContainer: Color(0xFFB8F5F2),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF121212),
    onSurface: Color(0xFFE5E1E6),
    surfaceContainerHighest: Color(0xFF46454A),
    onSurfaceVariant: Color(0xFFC7C5CA),
    outline: Color(0xFF918F94),
    outlineVariant: Color(0xFF46454A),
    inverseSurface: Color(0xFFE5E1E6),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: Color(0xFF6C5CE7),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
  );
}
