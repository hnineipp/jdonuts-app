part of '../auth_screens.dart';

class _AuthShell extends StatelessWidget {
  const _AuthShell({
    required this.child,
    this.progress = 0,
    this.complete = false,
  });
  final Widget child;
  final double progress;
  final bool complete;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.pinkBackground, AppColors.pinkSurfaceLight],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 16, 30, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (progress > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButtonTile(),
                        _ProgressRing(progress: progress, complete: complete),
                      ],
                    )
                  else
                    const SizedBox(height: 8),
                  const SizedBox(height: 26),
                  Expanded(child: child),
                  Gap(36.h),
                  const _LegalText(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _ProgressRing extends StatefulWidget {
  const _ProgressRing({
    required this.progress,
    this.complete = false,
  });

  final double progress;
  final bool complete;

  @override
  State<_ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<_ProgressRing> {
  double _previousProgress = 0;

  @override
  void initState() {
    super.initState();
    _previousProgress = widget.progress <= .25 ? 0 : widget.progress - .25;
  }

  @override
  void didUpdateWidget(covariant _ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    _previousProgress = oldWidget.progress;
  }

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.duration(
      context,
      AppMotion.normal,
    );

    final targetProgress = widget.complete ? 1.0 : widget.progress;

    return AnimatedContainer(
      duration: duration,
      curve: AppMotion.standard,
      width: widget.complete ? 32.w : 30.w,
      height: widget.complete ? 32.w : 30.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.complete ? AppColors.primary : Colors.transparent,
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: _previousProgress,
          end: targetProgress,
        ),
        duration: duration,
        curve: AppMotion.standard,
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (!widget.complete)
                Positioned.fill(
                  child: CustomPaint(
                    painter: ProgressCirclePainter(
                      progress: value,
                      complete: false,
                    ),
                  ),
                ),
              AnimatedScale(
                scale: widget.complete ? 1 : 0,
                duration: duration,
                curve: Curves.elasticOut,
                child: Icon(
                  Icons.check,
                  color: AppColors.surface,
                  size: 18.sp,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LegalText extends StatelessWidget {
  const _LegalText();
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Text.rich(
        TextSpan(
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.muted,
            height: 1.5,
          ),
          children: [
            TextSpan(text: '${l10n.legalNotice} '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => FeaturePlaceholderSheet.show(
                  context,
                  title: l10n.termsOfUse,
                ),
                child: Text(
                  l10n.termsOfUse,
                  style:
                      const TextStyle(color: AppColors.primary, fontSize: 12),
                ),
              ),
            ),
            TextSpan(text: ' ${l10n.andLabel} '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () => FeaturePlaceholderSheet.show(
                  context,
                  title: l10n.privacyPolicy,
                ),
                child: Text(
                  l10n.privacyPolicy,
                  style:
                      const TextStyle(color: AppColors.primary, fontSize: 12),
                ),
              ),
            ),
            const TextSpan(text: '.'),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
