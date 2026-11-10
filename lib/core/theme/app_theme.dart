import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_typography.dart';

// Single import point for the app's semantic design tokens.
export 'app_colors.dart';
export 'app_spacing.dart';
export 'app_radius.dart';
export 'app_typography.dart';

/// Home and shared layout tokens consumed through Theme.of(context).
@immutable
class JDonutsThemeTokens extends ThemeExtension<JDonutsThemeTokens> {
  const JDonutsThemeTokens({
    required this.heroBackground,
    required this.heroDecoration,
    required this.heroStar,
    required this.memberRing,
    required this.bannerCyanStart,
    required this.bannerCyanEnd,
    required this.sprinkle,
    this.pageHorizontal = 20,
    this.heroHeight = 344,
    this.bannerHeight = 178,
    this.heroRadius = 28,
    this.bannerRadius = 20,
    this.memberAvatarRadius = 30,
  });

  final Color heroBackground;
  final Color heroDecoration;
  final Color heroStar;
  final Color memberRing;
  final Color bannerCyanStart;
  final Color bannerCyanEnd;
  final Color sprinkle;
  final double pageHorizontal;
  final double heroHeight;
  final double bannerHeight;
  final double heroRadius;
  final double bannerRadius;
  final double memberAvatarRadius;

  @override
  JDonutsThemeTokens copyWith({
    Color? heroBackground, Color? heroDecoration, Color? heroStar,
    Color? memberRing, Color? bannerCyanStart, Color? bannerCyanEnd,
    Color? sprinkle, double? pageHorizontal, double? heroHeight,
    double? bannerHeight, double? heroRadius, double? bannerRadius,
    double? memberAvatarRadius,
  }) => JDonutsThemeTokens(
    heroBackground: heroBackground ?? this.heroBackground,
    heroDecoration: heroDecoration ?? this.heroDecoration,
    heroStar: heroStar ?? this.heroStar,
    memberRing: memberRing ?? this.memberRing,
    bannerCyanStart: bannerCyanStart ?? this.bannerCyanStart,
    bannerCyanEnd: bannerCyanEnd ?? this.bannerCyanEnd,
    sprinkle: sprinkle ?? this.sprinkle,
    pageHorizontal: pageHorizontal ?? this.pageHorizontal,
    heroHeight: heroHeight ?? this.heroHeight,
    bannerHeight: bannerHeight ?? this.bannerHeight,
    heroRadius: heroRadius ?? this.heroRadius,
    bannerRadius: bannerRadius ?? this.bannerRadius,
    memberAvatarRadius: memberAvatarRadius ?? this.memberAvatarRadius,
  );

  @override
  JDonutsThemeTokens lerp(ThemeExtension<JDonutsThemeTokens>? other, double t) {
    if (other is! JDonutsThemeTokens) return this;
    return JDonutsThemeTokens(
      heroBackground: Color.lerp(heroBackground, other.heroBackground, t)!,
      heroDecoration: Color.lerp(heroDecoration, other.heroDecoration, t)!,
      heroStar: Color.lerp(heroStar, other.heroStar, t)!,
      memberRing: Color.lerp(memberRing, other.memberRing, t)!,
      bannerCyanStart: Color.lerp(bannerCyanStart, other.bannerCyanStart, t)!,
      bannerCyanEnd: Color.lerp(bannerCyanEnd, other.bannerCyanEnd, t)!,
      sprinkle: Color.lerp(sprinkle, other.sprinkle, t)!,
      pageHorizontal: pageHorizontal + (other.pageHorizontal - pageHorizontal) * t,
      heroHeight: heroHeight + (other.heroHeight - heroHeight) * t,
      bannerHeight: bannerHeight + (other.bannerHeight - bannerHeight) * t,
      heroRadius: heroRadius + (other.heroRadius - heroRadius) * t,
      bannerRadius: bannerRadius + (other.bannerRadius - bannerRadius) * t,
      memberAvatarRadius: memberAvatarRadius + (other.memberAvatarRadius - memberAvatarRadius) * t,
    );
  }
}


abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        textTheme: AppTypography.textTheme,
        extensions: const <ThemeExtension<dynamic>>[
          JDonutsThemeTokens(
            heroBackground: Color(0xFFFFEBDD),
            heroDecoration: Color(0xFFFFF5EB),
            heroStar: Color(0xFFB7A89A),
            memberRing: Color(0xFFFFC66C),
            bannerCyanStart: Color(0xFF48C8E1),
            bannerCyanEnd: Color(0xFF64D8E9),
            sprinkle: Color(0x21FFFFFF),
          ),
        ],
        dividerColor: AppColors.divider,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
          border: _inputBorder(),
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(color: AppColors.secondary, width: 1.5),
          errorBorder: _inputBorder(color: AppColors.error),
          focusedErrorBorder: _inputBorder(color: AppColors.error, width: 1.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.surface,
            disabledBackgroundColor: AppColors.secondary.withValues(alpha: .45),
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

  static OutlineInputBorder _inputBorder({Color? color, double width = 0}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: color == null
            ? BorderSide.none
            : BorderSide(color: color, width: width),
      );
}
