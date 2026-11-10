import 'package:flutter/material.dart';
import 'package:jd_donuts/core/theme/app_theme.dart';
import 'package:jd_donuts/core/widgets/common_widgets.dart';
import 'package:jd_donuts/data/store/model/member_model.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';

class MemberHeader extends StatelessWidget {
  const MemberHeader({super.key, required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    final tokens = Theme.of(context).extension<JDonutsThemeTokens>()!;
    final theme = Theme.of(context);
    final compact = MediaQuery.sizeOf(context).width < 360;
    final avatarRadius =
        compact ? tokens.memberAvatarRadius - 4 : tokens.memberAvatarRadius;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        tokens.pageHorizontal,
        10,
        tokens.pageHorizontal,
        0,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: ClipOval(
                child: AppImage(
                  member.photo,
                  width: avatarRadius * 2,
                  height: avatarRadius * 2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontSize: compact ? 24 : 26,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  AppLocalizations.of(context).memberTier(member.tier),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          SizedBox(width: compact ? 54 : 64),
        ],
      ),
    );
  }
}

class MemberTierProgress extends StatelessWidget {
  const MemberTierProgress({super.key, required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final points = member.pointsToNextTier.toString();
    final nextTier = member.nextTier;
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 30),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        l10n.pointsLeftToTier(points, nextTier),
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodySmall,
      ),
    );
  }
}

class NotificationBadge extends StatelessWidget {
  const NotificationBadge({super.key, required this.member});

  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    final count = member.notifications.toString();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Semantics(
      label: AppLocalizations.of(context).notificationCount(count),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.sm,
          AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(AppRadius.xl),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.notifications_none,
                color: AppColors.surface, size: 23),
            const SizedBox(width: AppSpacing.xs),
            Container(
              constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
              child: Text(
                count,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
