import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_donuts/core/motion/motion.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.enabled = true,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool loading;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.duration(context, AppMotion.fast);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: Listener(
        onPointerDown: (_) {
          if (widget.enabled && !widget.loading) {
            setState(() => _pressed = true);
          }
        },
        onPointerUp: (_) => setState(() => _pressed = false),
        onPointerCancel: (_) => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: _pressed ? 0.96 : 1,
          duration: duration,
          curve: AppMotion.standard,
          child: ElevatedButton(
            onPressed:
                widget.enabled && !widget.loading ? widget.onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: AppColors.surface,
              disabledBackgroundColor:
                  AppColors.secondary.withValues(alpha: .45),
              elevation: 0,
              shape: const StadiumBorder(),
            ),
            child: AnimatedSwitcher(
              duration: AppMotion.duration(context, AppMotion.fast),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              ),
              child: widget.loading
                  ? const SizedBox.square(
                      key: ValueKey('loading'),
                      dimension: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.surface,
                      ),
                    )
                  : Text(
                      widget.label.toUpperCase(),
                      key: const ValueKey('label'),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                        letterSpacing: .7,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class BackButtonTile extends StatelessWidget {
  const BackButtonTile({super.key, this.onPressed});
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onPressed ?? () => Navigator.maybePop(context),
          borderRadius: BorderRadius.circular(10),
          child: const SizedBox(
            width: 42,
            height: 42,
            child: Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      );
}

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        color: AppColors.offlineBackground,
        child: Text(
          AppLocalizations.of(context).offlineMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.offlineForeground,
          ),
        ),
      );
}

class AppImage extends StatelessWidget {
  const AppImage(
    this.path, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) => Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => Container(
          width: width,
          color: AppColors.palePink,
          alignment: Alignment.center,
          child: const Icon(
            Icons.bakery_dining,
            color: AppColors.primary,
            size: 36,
          ),
        ),
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.title, {super.key, this.trailing});
  final String title;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          if (trailing != null) trailing!,
        ],
      );
}

class MotionEntrance extends StatefulWidget {
  const MotionEntrance({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppMotion.normal,
    this.offset = const Offset(0, 0.15),
    this.scale = false,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final bool scale;

  @override
  State<MotionEntrance> createState() => _MotionEntranceState();
}

class _MotionEntranceState extends State<MotionEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _delayTimer;

  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _opacity = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.standard,
    );

    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(_opacity);

    _scale = Tween<double>(
      begin: widget.scale ? 0.85 : 1,
      end: 1,
    ).animate(_opacity);

    _delayTimer = Timer(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.duration(context, widget.duration);

    if (duration == Duration.zero) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: Offset(
              _slide.value.dx * 40,
              _slide.value.dy * 40,
            ),
            child: Transform.scale(
              scale: _scale.value,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
