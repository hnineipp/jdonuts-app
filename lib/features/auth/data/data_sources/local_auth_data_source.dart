import 'package:hive_ce_flutter/hive_flutter.dart';

class LocalAuthDataSource {
  const LocalAuthDataSource(this._box);

  static const String boxName = 'jd_donuts_auth_v1';
  static const String _usersKey = 'registered_users';

  final Box<dynamic> _box;

  static Future<void> initialize() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<dynamic>(boxName);
    }
  }

  static Box<dynamic> get box => Hive.box<dynamic>(boxName);

  List<Map<String, dynamic>> get _users {
    final stored = _box.get(_usersKey, defaultValue: <dynamic>[]);

    if (stored is! List) return [];

    return stored
        .whereType<Map>()
        .map((user) => Map<String, dynamic>.from(user))
        .toList();
  }

  Future<bool> hasRegisteredPhone(String phone) async {
    return _users.any((user) => user['phone'] == phone);
  }

  Future<bool> login(String phone) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    return hasRegisteredPhone(phone);
  }

  Future<void> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final users = _users;

    if (users.any((user) => user['phone'] == phone)) return;

    users.add({
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'dob': dateOfBirth.toIso8601String(),
    });

    await _box.put(_usersKey, users);
  }

  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }
}
