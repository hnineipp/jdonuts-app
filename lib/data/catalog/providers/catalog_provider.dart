import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/catalog/data_sources/local_catalog_data_source.dart';
import 'package:jd_donuts/data/catalog/domain/catalog_service.dart';
import 'package:jd_donuts/data/catalog/domain/repositories/catalog_repository.dart';
import 'package:jd_donuts/data/catalog/repositories/local_catalog_repository.dart';
import 'package:jd_donuts/data/catalog/services/catalog_service_impl.dart';

final localCatalogDataSourceProvider = Provider<LocalCatalogDataSource>(
  (ref) => LocalCatalogDataSource(),
);

final catalogRepositoryProvider = Provider<CatalogRepository>(
  (ref) => LocalCatalogRepository(ref.watch(localCatalogDataSourceProvider)),
);

final catalogServiceProvider = Provider<CatalogService>(
  (ref) => CatalogServiceImpl(ref.watch(catalogRepositoryProvider)),
);

/// One local Hive-backed catalog shared by Home, Product and Rewards.
final catalogProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final result = await ref.watch(catalogServiceProvider).getCatalog();
  return switch (result) {
    Success<Map<String, dynamic>>(:final value) => value,
    Failure<Map<String, dynamic>>(:final failure) => throw StateError(failure.message),
  };
});
