import 'package:jd_donuts/data/catalog/domain/repositories/catalog_repository.dart';
import 'package:jd_donuts/data/catalog/data_sources/local_catalog_data_source.dart';

class LocalCatalogRepository implements CatalogRepository {
  LocalCatalogRepository(this._dataSource);

  final LocalCatalogDataSource _dataSource;

  @override
  Future<Map<String, dynamic>> loadCatalog() => _dataSource.readCatalog();

  @override
  Future<void> refresh() async {
    // Hive remains the UI source of truth.
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
