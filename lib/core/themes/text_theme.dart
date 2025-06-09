// lib/core/themes/text_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme get lightTextTheme => _baseTextTheme(Colors.black87);
  static TextTheme get darkTextTheme => _baseTextTheme(Colors.white70);

  static TextTheme _baseTextTheme(Color textColor) {
    return GoogleFonts.interTextTheme().copyWith(
      // Display Styles
      displayLarge: GoogleFonts.inter(
        fontSize: 57.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        color: textColor,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: textColor,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: textColor,
      ),

      // Headline Styles
      headlineLarge: GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: textColor,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: textColor,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: textColor,
      ),

      // Title Styles
      titleLarge: GoogleFonts.inter(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        color: textColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: textColor,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: textColor,
      ),

      // Label Styles
      labelLarge: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        color: textColor,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: textColor,
      ),

      // Body Styles
      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: textColor,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: textColor,
      ),
    );
  }
}
