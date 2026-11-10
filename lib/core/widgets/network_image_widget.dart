import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          placeholder: (_, __) => Container(
            width: width,
            height: height,
            color: AppColors.palePink,
            alignment: Alignment.center,
            child: const _ImageLoadingShimmer(),
          ),
          errorWidget: (_, __, ___) => Container(
            width: width,
            height: height,
            color: AppColors.palePink,
            alignment: Alignment.center,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.broken_image_outlined, color: AppColors.primary),
                SizedBox(height: 4),
                Text('Image unavailable', style: TextStyle(fontSize: 10, color: AppColors.muted)),
              ],
            ),
          ),
        ),
      );
}


class _ImageLoadingShimmer extends StatefulWidget {
  const _ImageLoadingShimmer();

  @override
  State<_ImageLoadingShimmer> createState() => _ImageLoadingShimmerState();
}

class _ImageLoadingShimmerState extends State<_ImageLoadingShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => ColoredBox(
          color: Color.lerp(AppColors.palePink, AppColors.neutral100, _controller.value)!,
        ),
      );
}
