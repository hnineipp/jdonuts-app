import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class LocalDatabase {
  LocalDatabase._();

  static const int schemaVersion = 4;
  static const String _boxName = 'jd_donuts_v1';
  static const String _catalogAsset = 'assets/data/catalog.json';

  static late Box<dynamic> _box;

  static Future<void> initialize() async {
    await Hive.initFlutter();

    _box = await Hive.openBox<dynamic>(_boxName);

    final storedVersion =
        (_box.get('schema_version', defaultValue: 0) as num).toInt();

    final hasCatalog = _box.containsKey('catalog');

    debugPrint('===== DATABASE INITIALIZATION =====');
    debugPrint('Stored schema: $storedVersion');
    debugPrint('Current schema: $schemaVersion');
    debugPrint('Has catalog: $hasCatalog');

    if (storedVersion < schemaVersion || !hasCatalog) {
      await _migrateCatalog();
    }

    debugPrint('Database initialization completed.');
    debugPrint('===================================');
  }

  static Future<void> _migrateCatalog() async {
    debugPrint('Starting catalog migration...');

    // Read the latest bundled JSON.
    final raw = await rootBundle.loadString(_catalogAsset);

    final decoded = jsonDecode(raw);

    if (decoded is! Map) {
      throw const FormatException(
        'Invalid catalog JSON format.',
      );
    }

    final seedCatalog = Map<String, dynamic>.from(decoded);

    // Read existing catalog to preserve member information.
    Map<String, dynamic> existingCatalog = {};

    if (_box.containsKey('catalog')) {
      final existing = _box.get('catalog');

      if (existing is Map) {
        existingCatalog = Map<String, dynamic>.from(existing);
      }
    }

    // Latest bundled seed data becomes the source of truth.
    final updatedCatalog = <String, dynamic>{
      ...existingCatalog,
      ...seedCatalog,
    };

    // Preserve the existing member record.
    final existingMember = existingCatalog['member'];

    if (existingMember is Map) {
      updatedCatalog['member'] = Map<String, dynamic>.from(existingMember);
    }

    // Validate and update shop records.
    final shops = updatedCatalog['shops'];

    if (shops is! List) {
      throw const FormatException(
        'Catalog shops must be a list.',
      );
    }

    for (final shop in shops) {
      if (shop is Map) {
        debugPrint(
          'Shop migration: ${shop['name']} '
          '| Image: ${shop['image']}',
        );
      }
    }

    // Save catalog and version.
    await _box.put('catalog', updatedCatalog);
    await _box.put('schema_version', schemaVersion);

    debugPrint('Catalog migration completed successfully.');
  }

  static Box<dynamic> get box => _box;

  static Map<String, dynamic> get catalog {
    final value = _box.get('catalog');

    if (value is! Map) {
      throw StateError('Local catalog is unavailable.');
    }

    return Map<String, dynamic>.from(value);
  }
}
