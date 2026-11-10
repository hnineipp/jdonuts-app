import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/data/store/model/shop_model.dart';
import 'package:jd_donuts/features/home/presentation/widgets/nearby_shop_card.dart';
import 'package:jd_donuts/features/home/presentation/widgets/section_feedback.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class NearbyShopSection extends StatefulWidget {
  const NearbyShopSection({
    super.key,
    required this.shops,
    this.hasError = false,
    this.onRetry,
  });

  final List<ShopModel> shops;
  final bool hasError;
  final VoidCallback? onRetry;

  @override
  State<NearbyShopSection> createState() => _NearbyShopSectionState();
}

class _NearbyShopSectionState extends State<NearbyShopSection> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.84,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadius.xl),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      colors.secondary,
                      colors.secondaryContainer,
                      colors.tertiaryContainer,
                    ],
                  ),
                ),
                child: Image.asset(
                  'assets/images/nearby_shops_background.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),
            Positioned.fill(
              child: ColoredBox(
                color: colors.secondary.withValues(alpha: 0.10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpacing.xl,
                bottom: AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    child: Text(
                      l10n.nearYou,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colors.onSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    child: Text(
                      l10n.nearbyShopCount(
                        widget.shops.length.toString(),
                      ),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colors.onSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xl,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.xl,
                        vertical: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(
                          AppRadius.pill,
                        ),
                      ),
                      child: Text(
                        l10n.exploreNow.toUpperCase(),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: colors.secondary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  SizedBox(
                    height: 300,
                    child: _buildShopContent(
                      context,
                      colors,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopContent(
    BuildContext context,
    ColorScheme colors,
  ) {
    if (widget.hasError) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          alignment: Alignment.center,
          child: SectionError(
            onRetry: widget.onRetry,
            onDarkSurface: false,
          ),
        ),
      );
    }

    if (widget.shops.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          alignment: Alignment.center,
          child: SectionEmpty(
            message: AppLocalizations.of(context).noNearbyShops,
            onDarkSurface: false,
          ),
        ),
      );
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: widget.shops.length,
      padEnds: false,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.sm,
          ),
          child: NearbyShopCard(
            shop: widget.shops[index],
          ),
        );
      },
    );
  }
}
