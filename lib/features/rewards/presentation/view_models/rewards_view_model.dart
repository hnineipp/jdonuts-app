import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/catalog/providers/catalog_provider.dart';

import 'rewards_state.dart';

final rewardsViewModelProvider =
    AsyncNotifierProvider<RewardsViewModel, RewardsState>(
  RewardsViewModel.new,
);

abstract interface class RewardsViewModelContract {
  Future<void> refresh();
}

extension RewardsVMX on WidgetRef {
  AsyncValue<RewardsState> get rewardsState =>
      watch(rewardsViewModelProvider);

  RewardsViewModelContract get rewardsVM =>
      read(rewardsViewModelProvider.notifier);
}

class RewardsViewModel extends AsyncNotifier<RewardsState>
    implements RewardsViewModelContract {
  @override
  Future<RewardsState> build() => loadRewards();

  Future<RewardsState> loadRewards() async {
    final result = await ref.read(catalogServiceProvider).getCatalog();

    return switch (result) {
      Success<Map<String, dynamic>>(:final value) =>
        RewardsState.fromCatalog(value),
      Failure<Map<String, dynamic>>(:final failure) =>
        throw StateError(failure.message),
    };
  }

  @override
  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(catalogServiceProvider).refresh();
      return loadRewards();
    });
  }
}
