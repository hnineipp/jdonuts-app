import 'package:flutter/material.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: theme.extension<JDonutsThemeTokens>()!.heroHeight,
          color: theme.extension<JDonutsThemeTokens>()!.heroBackground,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
        const SizedBox(height: AppSpacing.xl),
        const _LoadingSection(cardCount: 2, cardHeight: 170),
        const _LoadingSection(cardCount: 2, cardHeight: 255),
        const _LoadingSection(cardCount: 2, cardHeight: 170),
      ],
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection({
    required this.cardCount,
    required this.cardHeight,
  });

  final int cardCount;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 160,
                height: 22,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: cardHeight,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              scrollDirection: Axis.horizontal,
              itemCount: cardCount,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.md),
              itemBuilder: (_, __) => Container(
                width: 170,
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
