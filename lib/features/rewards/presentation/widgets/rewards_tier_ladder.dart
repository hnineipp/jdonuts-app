part of '../screens/rewards_screen.dart';

class _RewardsTierLadder extends StatelessWidget {
  const _RewardsTierLadder({
    required this.currentTier,
    required this.nextTier,
    required this.pointsToNext,
    required this.tierProgress,
    required this.animation,
  });

  final String currentTier;
  final String nextTier;
  final int pointsToNext;
  final double tierProgress;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tiers = <({String name, String initial, String caption, Color color})>[];
    // Include Bronze only when it is the member's actual current tier.
    // Silver, Gold and Platinum remain in the required order.
    if (currentTier.toLowerCase() == 'bronze') {
      tiers.add((
        name: 'Bronze',
        initial: 'B',
        caption: 'You’re here now',
        color: AppColors.bronze,
      ));
    }
    tiers.addAll([
      (name: 'Silver', initial: 'S', caption: currentTier == 'Silver'
          ? 'You’re here now' : 'Silver member', color: AppColors.silver),
      (name: 'Gold', initial: 'G', caption: currentTier == 'Gold'
          ? 'You’re here now'
          : '$pointsToNext pts Remaining\nto become $nextTier', color: AppColors.gold),
      (name: 'Platinum', initial: 'P', caption: currentTier == 'Platinum'
          ? 'You’re here now' : 'You’ll be here soon', color: AppColors.cyanBright),
    ]);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final currentIndex = tiers.indexWhere(
          (tier) => tier.name.toLowerCase() == currentTier.toLowerCase(),
        );
        final nextIndex = tiers.indexWhere(
          (tier) => tier.name.toLowerCase() == nextTier.toLowerCase(),
        );
        return Column(
          children: List.generate(tiers.length, (index) {
            final tier = tiers[index];
            final active = index == currentIndex;
            // Fill completed tier segments, then animate the final segment
            // leading to the member's actual nextTier from the local record.
            final lineProgress = nextIndex > currentIndex &&
                    index >= currentIndex && index < nextIndex
                ? (index < nextIndex - 1
                    ? 1.0
                    : (tierProgress * animation.value).clamp(0.0, 1.0))
                : index < currentIndex
                    ? 1.0
                    : 0.0;
            return Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 42,
                    child: Column(
                      children: [
                        Container(
                          width: 38,
                          height: 42,
                          decoration: BoxDecoration(
                            color: tier.color.withValues(
                              alpha: active ? .34 : .15,
                            ),
                            borderRadius: BorderRadius.circular(13),
                            border: Border.all(
                              color: tier.color,
                              width: active ? 2.2 : 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              tier.initial,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: tier.color,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        if (index < tiers.length - 1)
                          Expanded(
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  width: 2,
                                  color: AppColors.neutral200,
                                ),
                                FractionallySizedBox(
                                  heightFactor: lineProgress,
                                  child: Container(
                                    width: 2,
                                    color: tier.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tier.name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          tier.caption,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.labelSmall?.copyWith(
                            height: 1.25,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
