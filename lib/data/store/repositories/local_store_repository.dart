import 'package:jd_donuts/data/local/local_app_data_source.dart';
import 'package:jd_donuts/data/store/domain/repositories/store_repository.dart';

class LocalStoreRepository implements StoreRepository {
  LocalStoreRepository(this._dataSource);

  final LocalAppDataSource _dataSource;

  @override
  Future<Map<String, dynamic>> loadStoreData() => _dataSource.readAppData();

  @override
  Future<void> refresh() async {
    // Local database remains the source of truth until remote sync is added.
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
