import 'package:jd_donuts/core/errors/result.dart';

abstract interface class StoreService {
  Future<Result<Map<String, dynamic>>> getStoreData();
  Future<void> refresh();
}
