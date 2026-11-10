import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jd_donuts/data/auth/data_sources/local_auth_data_source.dart';

import 'app/app.dart';
import 'core/storage/local_database.dart';
import 'core/storage/session_storage.dart';

export 'app/app.dart' show JDonutsApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.initialize();

  await LocalAuthDataSource.initialize();

  await SessionStorage.initialize();
  runApp(const ProviderScope(child: JDonutsApp()));
}
