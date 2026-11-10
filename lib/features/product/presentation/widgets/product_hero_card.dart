part of '../screens/product_detail_screen.dart';

class _ProductHeroCard extends StatelessWidget {
  const _ProductHeroCard({
    required this.product,
    required this.formattedPrice,
    required this.heroHeight,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final ProductModel product;
  final String formattedPrice;
  final double heroHeight;
  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: heroHeight + AppSpacing.xxxl,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: AppSpacing.lg,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(
                  AppRadius.lg * 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.code,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                      if (product.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accent,
                            borderRadius: BorderRadius.circular(
                              AppRadius.md,
                            ),
                          ),
                          child: Text(
                            l10n.newBadge,
                            style: textTheme.labelLarge?.copyWith(
                              color: AppColors.surface,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '$formattedPrice MMK',
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: Center(
                      child: Hero(
                        tag: 'product-${product.id}',
                        child: AppImage(
                          product.image,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(
              child: _ProductQuantityStepper(
                quantity: quantity,
                onDecrease: onDecrease,
                onIncrease: onIncrease,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
