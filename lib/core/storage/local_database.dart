import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class LocalDatabase {
  LocalDatabase._();

  static const int schemaVersion = 5;

  static const String _boxName = 'jd_donuts_v1';
  static const String _appDataAsset = 'assets/data/app_data.json';

  static const String _appDataKey = 'app_data';
  static const String _legacyCatalogKey = 'catalog';

  static late Box<dynamic> _box;

  static Future<void> initialize() async {
    await Hive.initFlutter();

    _box = await Hive.openBox<dynamic>(_boxName);

    final storedVersion =
        (_box.get('schema_version', defaultValue: 0) as num).toInt();

    final hasAppData = _box.containsKey(_appDataKey);

    debugPrint('===== DATABASE INITIALIZATION =====');
    debugPrint('Stored schema: $storedVersion');
    debugPrint('Current schema: $schemaVersion');
    debugPrint('Has app data: $hasAppData');

    if (storedVersion < schemaVersion || !hasAppData) {
      await _migrateAppData();
    }

    debugPrint('Database initialization completed.');
    debugPrint('===================================');
  }

  static Future<void> _migrateAppData() async {
    debugPrint('Starting app data migration...');

    final raw = await rootBundle.loadString(_appDataAsset);
    final decoded = jsonDecode(raw);

    if (decoded is! Map) {
      throw const FormatException(
        'Invalid app data JSON format.',
      );
    }

    final seedData = Map<String, dynamic>.from(decoded);

    final existing = _box.get(_appDataKey) ?? _box.get(_legacyCatalogKey);

    Map<String, dynamic> existingData = {};

    if (existing is Map) {
      existingData = Map<String, dynamic>.from(existing);
    }

    final updatedData = <String, dynamic>{
      ...existingData,
      ...seedData,
    };

    final existingMember = existingData['member'];

    if (existingMember is Map) {
      updatedData['member'] = Map<String, dynamic>.from(existingMember);
    }

    final shops = updatedData['shops'];

    if (shops is! List) {
      throw const FormatException(
        'App data shops must be a list.',
      );
    }

    for (final shop in shops) {
      if (shop is Map) {
        debugPrint(
          'Shop: ${shop['name']} | Image: ${shop['image']}',
        );
      }
    }

    await _box.put(_appDataKey, updatedData);
    await _box.put('schema_version', schemaVersion);

    // Remove legacy key after successful migration.
    if (_box.containsKey(_legacyCatalogKey)) {
      await _box.delete(_legacyCatalogKey);
    }

    debugPrint('App data migration completed successfully.');
  }

  static Box<dynamic> get box => _box;

  static Map<String, dynamic> get appData {
    final value = _box.get(_appDataKey);

    if (value is! Map) {
      throw StateError('Local app data is unavailable.');
    }

    return Map<String, dynamic>.from(value);
  }
}
