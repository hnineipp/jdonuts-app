import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/core/widgets/common_widgets.dart';
import 'package:jd_donuts/data/store/model/banner_model.dart';
import 'package:jd_donuts/features/home/presentation/widgets/section_feedback.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class PromotionalBannerCarousel extends StatelessWidget {
  const PromotionalBannerCarousel({
    super.key,
    required this.banners,
    required this.controller,
    required this.onPageChanged,
    this.hasError = false,
    this.onRetry,
  });

  final List<BannerModel> banners;
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final bool hasError;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return SectionError(onRetry: onRetry);
    }

    if (banners.isEmpty) {
      return SectionEmpty(
        message: AppLocalizations.of(context).noPromotionsAvailable,
      );
    }

    return PageView.builder(
      controller: controller,
      padEnds: false,
      itemCount: banners.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        return PromotionalBannerCard(
          banner: banners[index],
        );
      },
    );
  }
}

class PromotionalBannerCard extends StatelessWidget {
  const PromotionalBannerCard({
    super.key,
    required this.banner,
  });

  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = theme.extension<JDonutsThemeTokens>()!;

    final isCyan = banner.id == 'b2';

    return Container(
      margin: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.sm,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(tokens.bannerRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isCyan
              ? [
                  tokens.bannerCyanStart,
                  tokens.bannerCyanEnd,
                ]
              : [
                  AppColors.bannerPurpleStart,
                  AppColors.bannerPurpleEnd,
                ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _BannerSprinklesPainter(
                AppColors.white70.withValues(alpha: .18),
              ),
            ),
          ),

          // Banner image.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: .98,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: AppImage(
                    banner.image,
                    width: 210.w,
                    height: 75.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Banner content.
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      border: Border.all(
                        color: AppColors.surface,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppRadius.pill,
                      ),
                    ),
                    child: Text(
                      banner.badge,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.surface,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      banner.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.surface,
                        height: 1.1,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerSprinklesPainter extends CustomPainter {
  const _BannerSprinklesPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    for (var index = 0; index < 13; index++) {
      final x = (index * 47.0) % size.width;
      final y = (index * 31.0) % size.height;

      canvas.drawLine(
        Offset(x, y),
        Offset(x + 12, y + 10),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _BannerSprinklesPainter oldDelegate,
  ) {
    return oldDelegate.color != color;
  }
}
