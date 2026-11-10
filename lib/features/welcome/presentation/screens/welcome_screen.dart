import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;

            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: screenHeight * 0.76,
                  child: const _WelcomeCollage(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: screenHeight * 0.20,
                  height: screenHeight * 0.36,
                  child: IgnorePointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withValues(alpha: 0),
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withValues(alpha: 0.85),
                            Theme.of(context).scaffoldBackgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  right: 20.w,
                  bottom: screenHeight * 0.180,
                  child: MotionEntrance(
                    delay: const Duration(milliseconds: 750),
                    offset: const Offset(0, 0.5),
                    child: Text(
                      "Welcome to the\nworld of J'donuts",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                ),
                Positioned(
                  left: 22.w,
                  right: 22.w,
                  bottom: 30.h,
                  child: MotionEntrance(
                    delay: const Duration(milliseconds: 950),
                    child: PrimaryButton(
                      label: "Let's explore",
                      onPressed: () => context.go('/home'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _WelcomeCollage extends StatelessWidget {
  const _WelcomeCollage();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 44.w) / 2;
        final cardHeight = cardWidth * 1.45;
        final columnGap = 14.w;

        return ClipRect(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                top: 12,
                width: cardWidth,
                child: Column(
                  children: [
                    MotionEntrance(
                      delay: const Duration(milliseconds: 100),
                      offset: const Offset(-0.3, 0),
                      child: _WelcomeTile(
                        height: cardHeight,
                        image: 'assets/images/donut_coconut.png',
                        color: AppColors.cyanPale,
                        rotation: -0.16,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    MotionEntrance(
                      delay: const Duration(milliseconds: 250),
                      offset: const Offset(-0.3, 0),
                      child: _WelcomeTile(
                        height: cardHeight,
                        image: 'assets/images/donut_strawberry.png',
                        color: AppColors.orangePale,
                        rotation: 0.10,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: cardWidth + columnGap + 22.w,
                top: 55.h,
                width: cardWidth,
                child: Column(
                  children: [
                    MotionEntrance(
                      delay: const Duration(milliseconds: 400),
                      offset: const Offset(0.3, 0),
                      child: _WelcomeTile(
                        height: cardHeight,
                        image: 'assets/images/donut_box.png',
                        color: AppColors.pinkPale,
                        rotation: -0.12,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    MotionEntrance(
                      delay: const Duration(milliseconds: 550),
                      offset: const Offset(0.3, 0),
                      child: _WelcomeTile(
                        height: cardHeight,
                        image: 'assets/images/coffee.png',
                        color: AppColors.lavenderPale,
                        rotation: 0.12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _WelcomeTile extends StatelessWidget {
  const _WelcomeTile({
    required this.height,
    required this.image,
    required this.color,
    required this.rotation,
  });

  final double height;
  final String image;
  final Color color;
  final double rotation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        height: height,
        width: double.infinity,
        color: color,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned.fill(
              child: _WelcomeDecoration(),
            ),
            Transform.rotate(
              angle: rotation,
              child: Image.asset(
                image,
                width: double.infinity,
                height: height * 0.75,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeDecoration extends StatelessWidget {
  const _WelcomeDecoration();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WelcomeDecorationPainter(),
    );
  }
}

class _WelcomeDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.24)
      ..strokeWidth = 9;

    for (var i = 0; i < 18; i++) {
      final x = (i * 37.0) % size.width;
      final y = (i * 53.0) % size.height;

      canvas.drawCircle(
        Offset(x, y),
        3,
        dotPaint,
      );
    }

    canvas.drawLine(
      Offset(size.width * 0.1, size.height * 0.2),
      Offset(size.width * 0.4, size.height * 0.1),
      linePaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.75, size.height * 0.7),
      Offset(size.width * 0.9, size.height * 0.9),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
