import 'package:flutter/material.dart';

class AppMotion {
  AppMotion._();

  static const Duration fast = Duration(milliseconds: 180);
  static const Duration normal = Duration(milliseconds: 420);
  static const Duration slow = Duration(milliseconds: 720);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.decelerate;

  static Duration duration(BuildContext context, Duration value) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : value;

  static Widget fadeSlide({
    required Widget child,
    required Animation<double> animation,
    Offset begin = const Offset(0, 0.12),
  }) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: standard,
    );

    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: begin,
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }
}
