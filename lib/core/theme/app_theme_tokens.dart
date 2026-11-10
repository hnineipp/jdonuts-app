import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

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

  // Custom colors
  final Color heroBackground;
  final Color heroDecoration;
  final Color heroStar;
  final Color memberRing;
  final Color bannerCyanStart;
  final Color bannerCyanEnd;
  final Color sprinkle;

  // Custom dimensions
  final double pageHorizontal;
  final double heroHeight;
  final double bannerHeight;
  final double heroRadius;
  final double bannerRadius;
  final double memberAvatarRadius;

  @override
  JDonutsThemeTokens copyWith({
    Color? heroBackground,
    Color? heroDecoration,
    Color? heroStar,
    Color? memberRing,
    Color? bannerCyanStart,
    Color? bannerCyanEnd,
    Color? sprinkle,
    double? pageHorizontal,
    double? heroHeight,
    double? bannerHeight,
    double? heroRadius,
    double? bannerRadius,
    double? memberAvatarRadius,
  }) {
    return JDonutsThemeTokens(
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
  }

  @override
  JDonutsThemeTokens lerp(
    covariant ThemeExtension<JDonutsThemeTokens>? other,
    double t,
  ) {
    if (other is! JDonutsThemeTokens) return this;

    return JDonutsThemeTokens(
      heroBackground: Color.lerp(
        heroBackground,
        other.heroBackground,
        t,
      )!,
      heroDecoration: Color.lerp(
        heroDecoration,
        other.heroDecoration,
        t,
      )!,
      heroStar: Color.lerp(heroStar, other.heroStar, t)!,
      memberRing: Color.lerp(memberRing, other.memberRing, t)!,
      bannerCyanStart: Color.lerp(
        bannerCyanStart,
        other.bannerCyanStart,
        t,
      )!,
      bannerCyanEnd: Color.lerp(
        bannerCyanEnd,
        other.bannerCyanEnd,
        t,
      )!,
      sprinkle: Color.lerp(sprinkle, other.sprinkle, t)!,
      pageHorizontal: lerpDouble(
        pageHorizontal,
        other.pageHorizontal,
        t,
      )!,
      heroHeight: lerpDouble(heroHeight, other.heroHeight, t)!,
      bannerHeight: lerpDouble(
        bannerHeight,
        other.bannerHeight,
        t,
      )!,
      heroRadius: lerpDouble(heroRadius, other.heroRadius, t)!,
      bannerRadius: lerpDouble(
        bannerRadius,
        other.bannerRadius,
        t,
      )!,
      memberAvatarRadius: lerpDouble(
        memberAvatarRadius,
        other.memberAvatarRadius,
        t,
      )!,
    );
  }
}
