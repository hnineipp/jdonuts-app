import 'package:jd_donuts/data/auth/data_sources/local_auth_data_source.dart';
import 'package:jd_donuts/data/auth/domain/repositories/auth_repository.dart';

class LocalAuthRepository implements AuthRepository {
  const LocalAuthRepository(this._dataSource);

  final LocalAuthDataSource _dataSource;

  @override
  Future<bool> hasRegisteredPhone(String phone) =>
      _dataSource.hasRegisteredPhone(phone);

  @override
  Future<bool> login(String phone) => _dataSource.login(phone);

  @override
  Future<void> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) =>
      _dataSource.register(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
      );

  @override
  Future<void> logout() => _dataSource.logout();
}
