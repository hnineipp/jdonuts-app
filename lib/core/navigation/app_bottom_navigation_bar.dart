import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:jd_donuts/core/theme/app_colors.dart';
import 'package:jd_donuts/core/theme/app_radius.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  static const double _barHeight = 68;
  static const double _activeItemHeight = 48;
  static const double _inactiveItemSize = 46;
  static const double _iconSize = 25;

  static const List<_NavigationItem> _items = [
    _NavigationItem(
      icon: Icons.home_outlined,
      route: '/home',
      labelKey: 'home',
    ),
    _NavigationItem(
      icon: Icons.workspace_premium_outlined,
      route: '/rewards',
      labelKey: 'rewards',
    ),
    _NavigationItem(
      icon: Icons.account_circle_outlined,
      route: '/placeholder/Account',
      labelKey: 'account',
    ),
    _NavigationItem(
      icon: Icons.account_balance_wallet_outlined,
      route: '/placeholder/Wallet',
      labelKey: 'wallet',
    ),
    _NavigationItem(
      icon: Icons.settings_outlined,
      route: '/placeholder/Settings',
      labelKey: 'settings',
    ),
  ];

  String _getLabel(AppLocalizations l10n, String key) {
    switch (key) {
      case 'home':
        return l10n.home;
      case 'rewards':
        return l10n.rewards;
      case 'account':
        return l10n.account;
      case 'wallet':
        return l10n.wallet;
      case 'settings':
        return l10n.settings;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final currentPath = GoRouterState.of(context).uri.path.toLowerCase();

    final activeIndex = switch (currentPath) {
      '/home' => 0,
      '/rewards' => 1,
      '/placeholder/account' => 2,
      '/placeholder/wallet' => 3,
      '/placeholder/settings' => 4,
      _ => currentIndex,
    };

    final safeIndex = activeIndex.clamp(0, _items.length - 1);
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;

    return SizedBox(
      height: _barHeight + bottomInset,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colors.secondary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          border: Border.all(
            color: colors.surface,
            width: 2,
          ),
        ),
        child: SizedBox(
          height: _barHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final flexValues = List<int>.generate(
                _items.length,
                (index) => index == safeIndex ? 180 : 100,
              );

              return Row(
                children: List.generate(_items.length, (index) {
                  final item = _items[index];
                  final isActive = index == safeIndex;

                  final label = _getLabel(
                    AppLocalizations.of(context),
                    item.labelKey,
                  );

                  return Expanded(
                    flex: flexValues[index],
                    child: Padding(
                      // Moves the complete navigation item.
                      padding: EdgeInsets.only(
                        left: index == 0 ? 12 : 6,
                        top: 8,
                        right: 12,
                        bottom: 8,
                      ),
                      child: Center(
                        child: Semantics(
                          button: true,
                          selected: isActive,
                          label: label,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (!isActive) {
                                context.go(item.route);
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOutCubic,
                              width: double.infinity,
                              height: isActive
                                  ? _activeItemHeight
                                  : _inactiveItemSize,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? colors.primary
                                    : AppColors.transparent,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.pill,
                                ),
                                border: isActive
                                    ? Border.all(
                                        color: colors.surface,
                                        width: 1.5,
                                      )
                                    : null,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    item.icon,
                                    size: _iconSize,
                                    color: colors.surface,
                                  ),
                                  if (isActive) ...[
                                    const SizedBox(width: 2),
                                    Flexible(
                                      child: Text(
                                        label,
                                        maxLines: 1,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: colors.surface,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({
    required this.icon,
    required this.route,
    required this.labelKey,
  });

  final IconData icon;
  final String route;
  final String labelKey;
}
