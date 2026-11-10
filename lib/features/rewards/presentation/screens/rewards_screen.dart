import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jd_donuts/core/motion/motion.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';
import 'package:jd_donuts/data/rewards/model/challenge_model.dart';
import 'package:jd_donuts/data/rewards/model/reward_model.dart';
import 'package:jd_donuts/features/rewards/view_models/rewards_state.dart';
import 'package:jd_donuts/features/rewards/view_models/rewards_view_model.dart';

part '../widgets/rewards_header.dart';
part '../widgets/rewards_tier_ladder.dart';
part '../widgets/rewards_points_ring.dart';
part '../widgets/rewards_tabs.dart';
part '../widgets/rewards_challenge_card.dart';
part '../widgets/rewards_gift_card.dart';
part '../widgets/rewards_loading_view.dart';

class RewardsScreen extends ConsumerStatefulWidget {
  const RewardsScreen({super.key});

  @override
  ConsumerState<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends ConsumerState<RewardsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _entryAnimation;
  bool _showGifts = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: AppMotion.slow,
    );
    _entryAnimation = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _entryController.value = 1;
    } else if (_entryController.value == 0 && !_entryController.isAnimating) {
      _entryController.forward();
    }
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  Future<void> _refresh() => ref.rewardsVM.refresh();

  @override
  Widget build(BuildContext context) {
    final state = ref.rewardsState;

    return SafeArea(
      child: state.when(
        loading: () => const _RewardsLoadingView(),
        error: (error, stack) => _RewardsErrorView(onRetry: _refresh),
        data: (data) => _buildRewards(context, data),
      ),
    );
  }

  Widget _buildRewards(BuildContext context, RewardsState data) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        children: [
          _RewardsHeader(
            animation: _entryAnimation,
            badgeCount: data.gifts.length,
          ),
          Expanded(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: _RewardsTierLadder(
                              currentTier: data.memberTier,
                              nextTier: data.nextTier,
                              pointsToNext: data.pointsToNextTier,
                              tierProgress: data.tierProgress,
                              animation: _entryAnimation,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 6,
                            child: _RewardsPointsRing(
                              points: data.points,
                              progress: data.pointsProgress,
                              animation: _entryAnimation,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.neutral100,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: _RewardsTabs(
                        showGifts: _showGifts,
                        onChanged: (value) {
                          if (_showGifts == value) return;
                          setState(() => _showGifts = value);
                        },
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 320),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, .06),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: _showGifts
                          ? _buildGiftList(data.gifts)
                          : _buildChallengeList(data.challenges),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeList(List<ChallengeModel> challenges) {
    return Column(
      key: const ValueKey('challenge-list'),
      children: [
        for (var index = 0; index < challenges.length; index++)
          _StaggeredEntry(
            animation: _entryAnimation,
            index: index,
            key: ValueKey('challenge-${challenges[index].id}'),
            child: _RewardsChallengeCard(
              challenge: challenges[index],
            ),
          ),
      ],
    );
  }

  Widget _buildGiftList(List<RewardModel> gifts) {
    return Column(
      key: const ValueKey('gift-list'),
      children: [
        for (var index = 0; index < gifts.length; index++)
          _StaggeredEntry(
            animation: _entryAnimation,
            index: index,
            key: ValueKey('gift-${gifts[index].id}'),
            child: _RewardsGiftCard(gift: gifts[index]),
          ),
      ],
    );
  }
}

class _RewardsErrorView extends StatelessWidget {
  const _RewardsErrorView({required this.onRetry});

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
              'Rewards are unavailable.',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaggeredEntry extends StatelessWidget {
  const _StaggeredEntry({
    super.key,
    required this.animation,
    required this.index,
    required this.child,
  });

  final Animation<double> animation;
  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final start = (index * .13).clamp(0.0, .65);
        final t = Curves.easeOutCubic.transform(
          ((animation.value - start) / .35).clamp(0.0, 1.0),
        );
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 22 * (1 - t)),
            child: child,
          ),
        );
      },
    );
  }
}
