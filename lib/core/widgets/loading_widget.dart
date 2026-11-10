import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.primary),
            if (message != null) ...[
              const SizedBox(height: 12),
              Text(message!, textAlign: TextAlign.center),
            ],
          ],
        ),
      );
}
