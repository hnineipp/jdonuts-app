part of '../screens/rewards_screen.dart';

class _RewardsHeader extends StatelessWidget {
  const _RewardsHeader({
    required this.animation,
    required this.badgeCount,
  });

  final Animation<double> animation;
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 0, 14),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'J’ Donuts Rewards',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          ScaleTransition(
            scale: CurvedAnimation(
              parent: animation,
              curve: Curves.elasticOut,
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(18, 11, 10, 11),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Rewards',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: AppColors.surface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 11,
                    backgroundColor: AppColors.surface,
                    child: Text(
                      '$badgeCount',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.ink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
