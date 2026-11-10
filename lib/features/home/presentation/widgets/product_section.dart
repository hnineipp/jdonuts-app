import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/data/store/model/product_model.dart';
import 'package:jd_donuts/features/home/presentation/widgets/product_card.dart';
import 'package:jd_donuts/features/home/presentation/widgets/section_feedback.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

enum ProductSectionStyle { seasonal, popular, orderAgain }

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
    required this.title,
    required this.products,
    required this.onProductTap,
    required this.style,
    this.hasError = false,
    this.onRetry,
  });

  final String title;
  final List<ProductModel> products;
  final void Function(ProductModel product, String heroTag) onProductTap;
  final ProductSectionStyle style;
  final bool hasError;
  final VoidCallback? onRetry;

  double _sectionHeight(double textScale) {
    final base = switch (style) {
      ProductSectionStyle.seasonal => 200.h,
      ProductSectionStyle.popular => 290..h,
      ProductSectionStyle.orderAgain => 230.h,
    };
    return base + ((textScale - 1).clamp(0, .3) * 42);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textScale = MediaQuery.textScalerOf(context).scale(1);
    final height = _sectionHeight(textScale);

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: height,
            child: hasError
                ? SectionError(onRetry: onRetry)
                : products.isEmpty
                    ? SectionEmpty(
                        message:
                            AppLocalizations.of(context).noProductsAvailableYet,
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.xxl,
                        ),
                        itemCount: products.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(width: AppSpacing.lg),
                        itemBuilder: (context, index) => ProductCard(
                          product: products[index],
                          style: style,
                          onTap: (heroTag) => onProductTap(
                            products[index],
                            heroTag,
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
