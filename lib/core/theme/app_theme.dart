import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';
import 'app_theme_tokens.dart';

export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_radius.dart';
export 'app_typography.dart';
export 'app_theme_tokens.dart';

abstract final class AppTheme {
  // J'Donuts custom design tokens
  static const JDonutsThemeTokens tokens = JDonutsThemeTokens(
    heroBackground: Color(0xFFFFEBDD),
    heroDecoration: Color(0xFFFFF5EB),
    heroStar: Color(0xFFB7A89A),
    memberRing: Color(0xFFFFC66C),
    bannerCyanStart: Color(0xFF48C8E1),
    bannerCyanEnd: Color(0xFF64D8E9),
    sprinkle: Color(0x21FFFFFF),
  );

  // Light theme
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),
    textTheme: AppTypography.textTheme,
    extensions: const [
      tokens,
    ],
    dividerColor: AppColors.divider,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: _inputBorder(),
      enabledBorder: _inputBorder(),
      focusedBorder: _inputBorder(
        color: AppColors.secondary,
        width: 1.5,
      ),
      errorBorder: _inputBorder(
        color: AppColors.error,
      ),
      focusedErrorBorder: _inputBorder(
        color: AppColors.error,
        width: 1.5,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.surface,
        disabledBackgroundColor: AppColors.secondary.withValues(alpha: 0.45),
        elevation: 0,
        shape: const StadiumBorder(),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
    ),
  );

  static OutlineInputBorder _inputBorder({
    Color? color,
    double width = 0,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: color == null
          ? BorderSide.none
          : BorderSide(
              color: color,
              width: width,
            ),
    );
  }
}
