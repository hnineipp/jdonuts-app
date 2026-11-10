import '../../../core/errors/result.dart';

abstract interface class AuthService {
  Future<Result<bool>> verifyLogin(String phone);
  Future<Result<void>> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  });
  Future<Result<void>> logout();
}
