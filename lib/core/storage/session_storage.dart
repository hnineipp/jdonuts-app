import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionStorage {
  SessionStorage._();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String _sessionKey = 'jd_donuts_session';
  static bool isLoggedIn = false;
  static Future<void> initialize() async {
    isLoggedIn = await _storage.read(key: _sessionKey) == 'active';
  }

  static Future<void> save() async {
    await _storage.write(key: _sessionKey, value: 'active');
    isLoggedIn = true;
  }

  static Future<void> clear() async {
    await _storage.delete(key: _sessionKey);
    isLoggedIn = false;
  }
}
