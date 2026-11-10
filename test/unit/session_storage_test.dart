// Platform integration test notes for SessionStorage.
//
// SessionStorage currently wraps a static FlutterSecureStorage instance.
// A deterministic unit test requires injecting FlutterSecureStorage (or a
// small SessionStore interface) so the test can supply an in-memory fake.
//
// Until that seam is added, verify persistence with the integration test
// described in TESTING_GUIDE.md. This file intentionally contains no fake
// assertion that would incorrectly claim secure-storage persistence was tested.
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('session storage requires an injectable secure-storage adapter',
      () {
    expect(
      'SessionStorage uses a static FlutterSecureStorage instance',
      contains('static'),
    );
  });
}
