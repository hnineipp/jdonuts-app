part of '../screens/rewards_screen.dart';

class _RewardsChallengeCard extends StatefulWidget {
  const _RewardsChallengeCard({required this.challenge});

  final ChallengeModel challenge;

  @override
  State<_RewardsChallengeCard> createState() => _RewardsChallengeCardState();
}

class _RewardsChallengeCardState extends State<_RewardsChallengeCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _attention = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 850),
  );

  @override
  void initState() {
    super.initState();
    if (widget.challenge.isComplete) {
      _attention.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _attention.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final challenge = widget.challenge;
    final progress = challenge.progress < 0 ? 0 : challenge.progress;
    final target = math.max(1, challenge.target);
    final ratio = challenge.progressFraction;
    final complete = challenge.isComplete;
    final coffee = challenge.kind == 'coffee';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 112,
            height: 112,
            child: Stack(
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: ratio),
                  duration: const Duration(milliseconds: 950),
                  curve: Curves.easeOutCubic,
                  builder: (context, animatedProgress, _) => coffee
                      ? CustomPaint(
                          size: const Size(104, 104),
                          painter: _RewardsChallengeArcPainter(
                            progress: animatedProgress,
                          ),
                        )
                      : _RewardsDonutProgress(progress: animatedProgress),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.82, end: 1),
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeOutBack,
                    builder: (context, scale, child) => Transform.scale(
                      scale: scale,
                      child: child,
                    ),
                    child: challenge.image.isNotEmpty
                        ? Image.asset(
                            challenge.image,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) =>
                                _challengeFallback(coffee),
                          )
                        : _challengeFallback(coffee),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text('$progress/$target', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 10),
                Row(
                  children: [
                    AnimatedBuilder(
                      animation: _attention,
                      builder: (context, child) => Transform.scale(
                        scale: complete ? 1 + (_attention.value * .045) : 1,
                        child: child,
                      ),
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                complete
                                    ? 'Challenge completed!'
                                    : 'Keep going to complete this challenge.',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(24),
                        child: AnimatedContainer(
                          duration: AppMotion.normal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: complete
                                ? AppColors.secondary
                                : AppColors.neutral250,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            'EARN',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: complete
                                  ? AppColors.surface
                                  : AppColors.muted,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        '${challenge.points} pts',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _challengeFallback(bool coffee) => Icon(
        coffee ? Icons.local_cafe_rounded : Icons.donut_large_rounded,
        size: 42,
        color: coffee ? AppColors.accent : AppColors.primary,
      );
}

class _RewardsDonutProgress extends StatelessWidget {
  const _RewardsDonutProgress({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: _RewardsDonutQuarterPainter(progress: progress),
    );
  }
}

class _RewardsDonutQuarterPainter extends CustomPainter {
  const _RewardsDonutQuarterPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13;
    canvas.drawArc(
      rect.deflate(7),
      0,
      math.pi * 2,
      false,
      base..color = AppColors.neutral200,
    );

    const quarterSweep = math.pi / 2;
    const gap = 0.075;
    final completed = progress.clamp(0.0, 1.0) * 4;
    for (var quarter = 0; quarter < 4; quarter++) {
      final filled = (completed - quarter).clamp(0.0, 1.0);
      if (filled <= 0) continue;
      final start = -math.pi / 2 + quarter * quarterSweep + gap / 2;
      final sweep = (quarterSweep - gap) * filled;
      canvas.drawArc(
        rect.deflate(7),
        start,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 13
          ..strokeCap = StrokeCap.butt
          ..color = AppColors.pinkBright,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RewardsDonutQuarterPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _RewardsChallengeArcPainter extends CustomPainter {
  const _RewardsChallengeArcPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawArc(
      rect.deflate(7),
      math.pi * .75,
      math.pi * 1.5,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..color = AppColors.neutral200,
    );
    if (progress > 0) {
      canvas.drawArc(
        rect.deflate(7),
        math.pi * .75,
        math.pi * 1.5 * progress.clamp(0.0, 1.0),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round
          ..color = AppColors.accent,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RewardsChallengeArcPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
