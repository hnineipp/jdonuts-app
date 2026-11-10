part of '../screens/rewards_screen.dart';

class _RewardsLoadingView extends StatefulWidget {
  const _RewardsLoadingView();

  @override
  State<_RewardsLoadingView> createState() => _RewardsLoadingViewState();
}

class _RewardsLoadingViewState extends State<_RewardsLoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shimmer = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _shimmer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (context, _) {
        final color = Color.lerp(
          AppColors.neutral100,
          AppColors.neutral300,
          _shimmer.value,
        )!;
        Widget block(double height, {double? width}) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
              ),
            );

        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Expanded(child: block(28)),
                const SizedBox(width: 18),
                block(42, width: 100),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: block(240)),
                const SizedBox(width: 12),
                Expanded(child: block(240)),
              ],
            ),
            const SizedBox(height: 18),
            block(42, width: 230),
            const SizedBox(height: 16),
            for (var i = 0; i < 3; i++) ...[
              block(130),
              const SizedBox(height: 14),
            ],
          ],
        );
      },
    );
  }
}
