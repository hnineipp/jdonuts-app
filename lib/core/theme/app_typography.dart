import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppTypography {
  static TextTheme get textTheme => GoogleFonts.nunitoTextTheme().copyWith(
        headlineLarge: GoogleFonts.nunito(
          fontSize: 29,
          fontWeight: FontWeight.w800,
          color: AppColors.ink,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.nunito(
          fontSize: 23,
          fontWeight: FontWeight.w800,
          color: AppColors.ink,
        ),
        titleLarge: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: AppColors.ink,
        ),
        titleMedium: GoogleFonts.nunito(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        bodyMedium: GoogleFonts.nunito(fontSize: 14, color: AppColors.ink),
        bodySmall: GoogleFonts.nunito(fontSize: 12, color: AppColors.muted),
      );
}
