// lib/core/themes/app_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:innerverse/core/themes/color_scheme.dart';
import 'package:innerverse/core/themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  // Light Theme
  static ThemeData get lightTheme {
    const colorScheme = AppColorScheme.lightColorScheme;
    final textTheme = AppTextTheme.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: _appBarTheme(colorScheme, textTheme, Brightness.dark),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme, textTheme),
      textButtonTheme: _textButtonTheme(colorScheme, textTheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme, textTheme),
      floatingActionButtonTheme: _fabTheme(colorScheme),
      bottomNavigationBarTheme: _bottomNavTheme(colorScheme, textTheme),
      chipTheme: _chipTheme(colorScheme, textTheme),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    const colorScheme = AppColorScheme.darkColorScheme;
    final textTheme = AppTextTheme.darkTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      appBarTheme: _appBarTheme(colorScheme, textTheme, Brightness.light),
      elevatedButtonTheme: _elevatedButtonTheme(colorScheme, textTheme),
      textButtonTheme: _textButtonTheme(colorScheme, textTheme),
      inputDecorationTheme: _inputDecorationTheme(colorScheme, textTheme),
      floatingActionButtonTheme: _fabTheme(colorScheme),
      bottomNavigationBarTheme: _bottomNavTheme(colorScheme, textTheme),
      chipTheme: _chipTheme(colorScheme, textTheme),
    );
  }

  // ======= THEME HELPERS =======

  static AppBarTheme _appBarTheme(
    ColorScheme scheme,
    TextTheme textTheme,
    Brightness statusBarIconBrightness,
  ) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusBarIconBrightness,
      ),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        foregroundColor: scheme.primary,
        textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: scheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: scheme.outline.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: scheme.error),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: scheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }

  static FloatingActionButtonThemeData _fabTheme(ColorScheme scheme) {
    return FloatingActionButtonThemeData(
      backgroundColor: scheme.primary,
      foregroundColor: scheme.onPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  static BottomNavigationBarThemeData _bottomNavTheme(
    ColorScheme scheme,
    TextTheme textTheme,
  ) {
    return BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: scheme.surface,
      selectedItemColor: scheme.primary,
      unselectedItemColor: scheme.onSurface..withValues(alpha: 0.6),
      selectedLabelStyle: textTheme.labelSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: textTheme.labelSmall,
      elevation: 8,
    );
  }

  static ChipThemeData _chipTheme(ColorScheme scheme, TextTheme textTheme) {
    return ChipThemeData(
      backgroundColor: scheme.surfaceContainerHighest,
      selectedColor: scheme.primary,
      labelStyle: textTheme.labelMedium,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
