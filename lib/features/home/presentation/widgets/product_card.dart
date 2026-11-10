import 'package:flutter/material.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/data/catalog/model/product_model.dart';
import 'package:jd_donuts/core/widgets/common_widgets.dart';
import 'package:jd_donuts/features/home/presentation/widgets/product_section.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.style,
    required this.onTap,
  });

  final ProductModel product;
  final ProductSectionStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final discount =
        product.homeDiscountPercent ?? product.discountPercent;

    final isSeasonal = style == ProductSectionStyle.seasonal;
    final isPopular = style == ProductSectionStyle.popular;

    final width = isSeasonal ? 255.0 : 170.0;
    final imageHeight = isPopular ? 220.0 : 170.0;

    final productName = style == ProductSectionStyle.orderAgain
        ? product.orderAgainTitle ?? product.name
        : product.name;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              child: SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Hero(
                          tag: 'product-${product.id}',
                          child: AppImage(
                            product.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    if (discount != null)
                      Positioned(
                        right: AppSpacing.md,
                        bottom: AppSpacing.md,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .discountOff(discount.toString()),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
