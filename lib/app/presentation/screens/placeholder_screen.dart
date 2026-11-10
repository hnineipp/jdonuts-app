import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';

import 'package:jd_donuts/features/auth/view_models/auth_view_model.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class PlaceholderScreen extends ConsumerStatefulWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  ConsumerState<PlaceholderScreen> createState() => _PlaceholderScreenState();
}

class _PlaceholderScreenState extends ConsumerState<PlaceholderScreen> {
  bool _isLoggingOut = false;
  String? _error;

  bool get _isSettings => widget.title.toLowerCase() == 'settings';

  Future<bool> _confirmLogout() async {
    final l10n = AppLocalizations.of(context);

    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(l10n.logoutConfirmationTitle),
            content: Text(l10n.logoutConfirmationMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(l10n.logout),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _handleLogout() async {
    if (_isLoggingOut) return;

    final confirmed = await _confirmLogout();
    if (!confirmed || !mounted) return;

    setState(() {
      _isLoggingOut = true;
      _error = null;
    });

    try {
      await ref.authVM.logout();
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isLoggingOut = false;
        _error = AppLocalizations.of(context).logoutFailed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.canvas,
        elevation: 0,
        centerTitle: true,
        title: Text(_isSettings ? l10n.settings : widget.title),
      ),
      body: _isSettings
          ? ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                      color: theme.colorScheme.error,
                    ),
                    title: Text(
                      l10n.logout,
                      style: theme.textTheme.titleMedium,
                    ),
                    subtitle: Text(l10n.logoutConfirmationMessage),
                    trailing: _isLoggingOut
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : OutlinedButton(
                            onPressed: _handleLogout,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.error,
                              backgroundColor: AppColors.error,
                              side: const BorderSide(
                                color: AppColors.error,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 10,
                              ),
                            ),
                            child: Text(
                              l10n.logout,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.surface,
                              ),
                            ),
                          ),
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ],
              ],
            )
          : Center(
              child: Text(
                '${widget.title} is a demo placeholder.',
                style: TextStyle(
                  fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
    );
  }
}
