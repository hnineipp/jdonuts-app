import 'package:flutter/material.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';

class SectionEmpty extends StatelessWidget {
  const SectionEmpty({
    super.key,
    required this.message,
    this.onDarkSurface = false,
  });

  final String message;
  final bool onDarkSurface;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foreground = onDarkSurface
        ? AppColors.white70
        : theme.colorScheme.onSurfaceVariant;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(color: foreground),
        ),
      ),
    );
  }
}

class SectionError extends StatelessWidget {
  const SectionError({
    super.key,
    this.onRetry,
    this.onDarkSurface = false,
  });

  final VoidCallback? onRetry;
  final bool onDarkSurface;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final foreground =
        onDarkSurface ? AppColors.white70 : colors.onSurfaceVariant;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context).sectionLoadError,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: foreground),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context).homeRetry),
          ),
        ],
      ),
    );
  }
}
