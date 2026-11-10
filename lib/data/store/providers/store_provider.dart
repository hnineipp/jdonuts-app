import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/local/local_app_data_source.dart';
import 'package:jd_donuts/data/store/domain/repositories/store_repository.dart';
import 'package:jd_donuts/data/store/domain/store_service.dart';
import 'package:jd_donuts/data/store/repositories/local_store_repository.dart';
import 'package:jd_donuts/data/store/services/store_service_impl.dart';

final storeRepositoryProvider = Provider<StoreRepository>(
  (ref) => LocalStoreRepository(ref.watch(localAppDataSourceProvider)),
);

final storeServiceProvider = Provider<StoreService>(
  (ref) => StoreServiceImpl(ref.watch(storeRepositoryProvider)),
);

final storeDataProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final result = await ref.watch(storeServiceProvider).getStoreData();
  return switch (result) {
    Success<Map<String, dynamic>>(:final value) => value,
    Failure<Map<String, dynamic>>(:final failure) =>
      throw StateError(failure.message),
  };
});
