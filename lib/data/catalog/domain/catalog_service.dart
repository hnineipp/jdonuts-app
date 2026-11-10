import 'package:jd_donuts/core/errors/result.dart';

abstract interface class CatalogService {
  Future<Result<Map<String, dynamic>>> getCatalog();
  Future<void> refresh();
}
