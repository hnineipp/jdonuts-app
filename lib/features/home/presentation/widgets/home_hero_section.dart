import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/data/store/model/banner_model.dart';
import 'package:jd_donuts/data/store/model/member_model.dart';
import 'package:jd_donuts/features/home/presentation/widgets/member_header.dart';
import 'package:jd_donuts/features/home/presentation/widgets/promotional_banner_carousel.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({
    super.key,
    required this.member,
    required this.banners,
    required this.controller,
    required this.onBannerChanged,
    this.hasBannerError = false,
    this.onRetry,
  });

  final MemberModel member;
  final List<BannerModel> banners;
  final PageController controller;
  final ValueChanged<int> onBannerChanged;
  final bool hasBannerError;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<JDonutsThemeTokens>()!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 360;

        final heroHeight = compact ? tokens.heroHeight - 12 : tokens.heroHeight;

        final bannerTop = heroHeight * .435;

        return SizedBox(
          height: heroHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(tokens.heroRadius),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned.fill(
                  child: ColoredBox(
                    color: tokens.heroBackground,
                  ),
                ),
                const Positioned(
                  right: -24,
                  top: 38,
                  child: _HeroDecoration(),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: bannerTop,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          MemberHeader(
                            member: member,
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.only(
                              left: tokens.pageHorizontal - 1,
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth * .72,
                              ),
                              child: MemberTierProgress(
                                member: member,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PromotionalBannerCarousel(
                        banners: banners,
                        controller: controller,
                        onPageChanged: onBannerChanged,
                        hasError: hasBannerError,
                        onRetry: onRetry,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 39,
                  child: NotificationBadge(
                    member: member,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HeroDecoration extends StatelessWidget {
  const _HeroDecoration();

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<JDonutsThemeTokens>()!;
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 180,
      height: 150,
      decoration: BoxDecoration(
        color: tokens.heroDecoration,
        border: Border.all(
          color: colors.surface,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Center(
        child: Icon(
          Icons.star,
          size: 48,
          color: tokens.heroStar,
        ),
      ),
    );
  }
}
