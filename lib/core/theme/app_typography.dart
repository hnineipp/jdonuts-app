import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTypography {
  static const double displayLargeSize = 32;
  static const double headlineLargeSize = 28;
  static const double headlineMediumSize = 24;
  static const double titleLargeSize = 20;
  static const double titleMediumSize = 18;
  static const double bodyLargeSize = 16;
  static const double bodyMediumSize = 14;
  static const double bodySmallSize = 12;
  static const double labelSmallSize = 10;

  static final TextTheme textTheme = GoogleFonts.nunitoTextTheme().copyWith(
    displayLarge: GoogleFonts.nunito(
      fontSize: displayLargeSize,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
    headlineLarge: GoogleFonts.nunito(
      fontSize: headlineLargeSize,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
      height: 1.15,
    ),
    headlineMedium: GoogleFonts.nunito(
      fontSize: headlineMediumSize,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
    titleLarge: GoogleFonts.nunito(
      fontSize: titleLargeSize,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
    ),
    titleMedium: GoogleFonts.nunito(
      fontSize: titleMediumSize,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    bodyLarge: GoogleFonts.nunito(
      fontSize: bodyLargeSize,
      color: AppColors.ink,
    ),
    bodyMedium: GoogleFonts.nunito(
      fontSize: bodyMediumSize,
      color: AppColors.ink,
    ),
    bodySmall: GoogleFonts.nunito(
      fontSize: bodySmallSize,
      color: AppColors.muted,
    ),
    labelSmall: GoogleFonts.nunito(
      fontSize: labelSmallSize,
      fontWeight: FontWeight.w600,
      color: AppColors.muted,
    ),
  );
}
