import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/core/widgets/network_image_widget.dart';
import 'package:jd_donuts/data/store/model/shop_model.dart';

class NearbyShopCard extends StatelessWidget {
  const NearbyShopCard({
    super.key,
    required this.shop,
  });

  final ShopModel shop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final imagePath = shop.image;

    return Container(
      margin: const EdgeInsets.only(right: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: SizedBox(
              width: double.infinity,
              height: 142.h,
              child: imagePath.startsWith('http')
                  ? AppNetworkImage(
                      imageUrl: imagePath,
                      fit: BoxFit.cover,
                    )
                  : imagePath.isNotEmpty
                      ? Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const _ShopImagePlaceholder(),
                        )
                      : const _ShopImagePlaceholder(),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            shop.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            shop.address,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Order Online',
            style: theme.textTheme.titleSmall?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopImagePlaceholder extends StatelessWidget {
  const _ShopImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.storefront_rounded,
          size: 48,
          color: colors.secondary,
        ),
      ),
    );
  }
}
