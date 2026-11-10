part of '../screens/rewards_screen.dart';

class _RewardsTabs extends StatelessWidget {
  const _RewardsTabs({
    required this.showGifts,
    required this.onChanged,
  });

  final bool showGifts;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tab(
            context,
            'Eat more earn more',
            !showGifts,
            () => onChanged(false),
          ),
          _tab(context, 'Gift', showGifts, () => onChanged(true)),
        ],
      ),
    );
  }

  Widget _tab(
    BuildContext context,
    String label,
    bool active,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: AnimatedContainer(
        duration: AppMotion.normal,
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
        decoration: BoxDecoration(
          color: active ? AppColors.secondary : AppColors.transparent,
          borderRadius: BorderRadius.circular(26),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: active ? AppColors.surface : AppColors.ink,
            fontWeight: active ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
