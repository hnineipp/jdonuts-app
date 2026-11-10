part of '../screens/rewards_screen.dart';

class _RewardsPointsRing extends StatelessWidget {
  const _RewardsPointsRing({
    required this.points,
    required this.progress,
    required this.animation,
  });

  final int points;
  final double progress;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    final displayProgress = progress.clamp(0.0, 0.95).toDouble();

    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final animatedPoints = (points * animation.value).round();
        return CustomPaint(
          painter: _RewardsRingPainter(
            progress: displayProgress * animation.value,
          ),
          child: Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(42),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total points',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TweenAnimationBuilder<int>(
                        tween: IntTween(begin: 0, end: animatedPoints),
                        duration: AppMotion.duration(context, AppMotion.slow),
                        builder: (context, value, _) => Text(
                          _formatPoints(value),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String _formatPoints(int value) {
  final digits = value.toString();
  final result = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      result.write(',');
    }
    result.write(digits[i]);
  }
  return result.toString();
}

class _RewardsRingPainter extends CustomPainter {
  const _RewardsRingPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final shortest = math.min(size.width, size.height);
    final center = size.center(Offset.zero);
    final radius = shortest * .39;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final stroke = shortest * .135;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = AppColors.neutral150
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke,
    );

    if (progress > 0) {
      canvas.drawArc(
        rect,
        -math.pi / 2,
        math.pi * 2 * progress.clamp(0.0, 1.0),
        false,
        Paint()
          ..shader = const SweepGradient(
            colors: [
              AppColors.pinkLight,
              AppColors.primary,
              AppColors.pinkBright,
            ],
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..strokeCap = StrokeCap.round,
      );
    }

    final sprinkle = Paint()
      ..color = AppColors.pinkDecorative
      ..strokeWidth = math.max(2, stroke * .12)
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 20; i++) {
      final angle = i * math.pi * 2 / 20;
      final point = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      canvas.drawLine(
        point + const Offset(-2.5, -4),
        point + const Offset(2.5, 4),
        sprinkle,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RewardsRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
