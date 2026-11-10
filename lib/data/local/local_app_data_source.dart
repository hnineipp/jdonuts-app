import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jd_donuts/core/storage/local_database.dart';

class LocalAppDataSource {
  Future<Map<String, dynamic>> readAppData() async {
    return Map<String, dynamic>.from(LocalDatabase.appData);
  }
}

final localAppDataSourceProvider = Provider<LocalAppDataSource>(
  (ref) => LocalAppDataSource(),
);
