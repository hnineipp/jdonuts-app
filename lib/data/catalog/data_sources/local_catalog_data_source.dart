import 'package:jd_donuts/core/storage/local_database.dart';

class LocalCatalogDataSource {
  Future<Map<String, dynamic>> readCatalog() async => LocalDatabase.catalog;
}
