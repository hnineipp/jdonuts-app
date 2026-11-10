import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/store/providers/store_provider.dart';

import 'home_state.dart';

final homeViewModelProvider = AsyncNotifierProvider<HomeViewModel, HomeData>(
  HomeViewModel.new,
);

abstract interface class HomeViewModelContract {
  Future<void> refresh();

  Future<HomeData> loadHomeData();
}

extension HomeVMX on WidgetRef {
  AsyncValue<HomeData> get homeState => watch(homeViewModelProvider);

  HomeViewModelContract get homeVM => read(homeViewModelProvider.notifier);
}

class HomeViewModel extends AsyncNotifier<HomeData>
    implements HomeViewModelContract {
  @override
  Future<HomeData> build() => loadHomeData();

  @override
  Future<HomeData> loadHomeData() async {
    final result = await ref.read(storeServiceProvider).getStoreData();

    return switch (result) {
      Success<Map<String, dynamic>>(:final value) => HomeData.fromJson(value),
      Failure<Map<String, dynamic>>(:final failure) =>
        throw StateError(failure.message),
    };
  }

  @override
  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(storeServiceProvider).refresh();

      return loadHomeData();
    });
  }
}
