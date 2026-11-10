part of '../screens/product_detail_screen.dart';

class _ProductDetailHeader extends StatelessWidget {
  const _ProductDetailHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          IconButton(
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              color: AppColors.ink,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
