import 'package:flutter/material.dart';
import 'app_theme.dart';

/// Backwards-compatible aliases. Prefer AppColors, AppSpacing and AppTheme.
@Deprecated('Use AppColors, AppSpacing and AppTheme instead.')
abstract final class AppResources {
  static const Color pink = AppColors.primary;
  static const Color cyan = AppColors.secondary;
  static const Color orange = AppColors.accent;
  static const Color ink = AppColors.ink;
  static const Color muted = AppColors.muted;
  static const Color canvas = AppColors.canvas;
  static const Color palePink = AppColors.palePink;
  static const Color surface = AppColors.surface;
  static const double radius = 18;
  static const EdgeInsets pagePadding = AppSpacing.page;
  static ThemeData get lightTheme => AppTheme.light;
}
