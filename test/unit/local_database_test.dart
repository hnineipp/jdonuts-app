// LocalDatabase currently uses static Hive state and rootBundle directly.
// Reliable first-launch/migration tests require injecting:
// 1) a Hive box (or a database adapter), and
// 2) a seed JSON loader.
//
// These tests document the current database contract. The integration
// verification steps are in TESTING_GUIDE.md.
import 'package:flutter_test/flutter_test.dart';
import 'package:jd_donuts/core/storage/local_database.dart';

void main() {
  test('database schema version is explicitly versioned', () {
    expect(LocalDatabase.schemaVersion, greaterThan(0));
  });
}
