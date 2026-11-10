import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:jd_donuts/app/providers/app_providers.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';
import 'package:jd_donuts/core/theme/app_radius.dart';
import 'package:jd_donuts/core/theme/app_spacing.dart';
import 'package:jd_donuts/core/widgets/common_widgets.dart';
import 'package:jd_donuts/data/catalog/model/product_model.dart';
import 'package:jd_donuts/features/product/presentation/view_models/product_detail_view_model.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

part '../widgets/product_detail_header.dart';
part '../widgets/product_hero_card.dart';
part '../widgets/product_quantity_stepper.dart';
part '../widgets/product_description.dart';
part '../widgets/product_detail_loading.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;

  void _decreaseQuantity() {
    if (_quantity <= 1) return;
    setState(() => _quantity--);
  }

  void _increaseQuantity() {
    setState(() => _quantity++);
  }

  void _addToCart(ProductModel product) {
    final l10n = AppLocalizations.of(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            l10n.addedToCart(_quantity, product.name),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  Future<void> _refresh() {
    return ref.productDetailVM(widget.productId).refresh();
  }

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.productDetailState(widget.productId);
    final offlineAsync = ref.watch(isOfflineProvider);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: MediaQuery.textScalerOf(context).clamp(
          maxScaleFactor: 1.3,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.neutral100,
        body: SafeArea(
          child: productAsync.when(
            loading: () => const _ProductDetailLoading(),
            error: (error, stackTrace) => _ProductError(
              message: error is ProductNotFoundException
                  ? AppLocalizations.of(context).productNotFound
                  : AppLocalizations.of(context).productUnavailable,
              onBack: () => context.pop(),
              onRetry: error is ProductNotFoundException ? null : _refresh,
            ),
            data: (product) => _buildProductContent(
              product,
              offline: offlineAsync.valueOrNull ?? false,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductContent(
    ProductModel product, {
    required bool offline,
  }) {
    final price = product.priceMmk;
    final total = price * _quantity;

    final formattedPrice = NumberFormat('#,###').format(price);
    final formattedTotal = NumberFormat('#,###').format(total);

    return Column(
      children: [
        const _ProductDetailHeader(),
        if (offline) const OfflineBanner(),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final heroHeight =
                  (constraints.maxHeight * 0.61).clamp(320.0, 470.0);

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.sm,
                  AppSpacing.xl,
                  AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProductHeroCard(
                      product: product,
                      formattedPrice: formattedPrice,
                      heroHeight: heroHeight,
                      quantity: _quantity,
                      onDecrease: _decreaseQuantity,
                      onIncrease: _increaseQuantity,
                    ),
                    const SizedBox(height: AppSpacing.section),
                    _ProductDescription(
                      description: product.description,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              );
            },
          ),
        ),
        _ProductAddToCart(
          total: formattedTotal,
          onPressed: () => _addToCart(product),
        ),
      ],
    );
  }
}

class _ProductError extends StatelessWidget {
  const _ProductError({
    required this.message,
    required this.onBack,
    this.onRetry,
  });

  final String message;
  final VoidCallback onBack;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: Text(
                  AppLocalizations.of(context).retry,
                ),
              ),
            TextButton(
              onPressed: onBack,
              child: Text(
                MaterialLocalizations.of(context).backButtonTooltip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductAddToCart extends StatelessWidget {
  const _ProductAddToCart({
    required this.total,
    required this.onPressed,
  });

  final String total;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.sm,
          AppSpacing.xl,
          AppSpacing.lg,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: Material(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(AppRadius.lg * 3),
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(AppRadius.lg * 3),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          l10n.addToCart.toUpperCase(),
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.surface,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Container(
                      width: 1,
                      height: 24,
                      color: AppColors.surface.withValues(alpha: .65),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          '$total MMK',
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.surface,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
