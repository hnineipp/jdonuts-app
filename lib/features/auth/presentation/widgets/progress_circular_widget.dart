import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';

class ProgressCirclePainter extends CustomPainter {
  final double progress;
  final bool complete;

  ProgressCirclePainter({
    required this.progress,
    required this.complete,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 7.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    // Background: Blue when incomplete, pink when complete.
    final backgroundPaint = Paint()
      ..color = complete
          ? AppColors.primary
          : AppColors.secondary.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Pink progress
    if (!complete && progress > 0) {
      final progressPaint = Paint()
        ..color = AppColors.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        rect,
        -math.pi / 2,
        2 * math.pi * progress.clamp(0.0, 1.0),
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ProgressCirclePainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.complete != complete;
  }
}
