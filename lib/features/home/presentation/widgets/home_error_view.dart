import 'package:flutter/material.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class HomeErrorView extends StatelessWidget {
  const HomeErrorView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 42,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context).homeError,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: onRetry,
              child: Text(AppLocalizations.of(context).homeRetry),
            ),
          ],
        ),
      ),
    );
  }
}
