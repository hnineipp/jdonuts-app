import 'package:flutter/material.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class FeaturePlaceholderSheet {
  const FeaturePlaceholderSheet._();

  static Future<void> show(
    BuildContext context, {
    required String title,
  }) {
    final l10n = AppLocalizations.of(context);

    return showModalBottomSheet<void>(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          height: 110,
          child: Center(
            child: Text(l10n.featureDemoPlaceholder(title)),
          ),
        ),
      ),
    );
  }
}
