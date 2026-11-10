part of '../screens/product_detail_screen.dart';

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 76,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.help,
                color: AppColors.success,
                size: 19,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.whatsThis,
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.ink,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 1.5,
          height: 116,
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
          ),
          color: AppColors.surface,
        ),
        Expanded(
          child: Text(
            description,
            style: textTheme.bodyLarge?.copyWith(
              color: AppColors.muted,
              height: 1.55,
            ),
          ),
        ),
      ],
    );
  }
}
