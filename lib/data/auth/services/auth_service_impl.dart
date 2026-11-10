import 'package:jd_donuts/core/errors/app_failure.dart';
import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/auth/domain/auth_service.dart';
import 'package:jd_donuts/data/auth/domain/repositories/auth_repository.dart';

class AuthServiceImpl implements AuthService {
  const AuthServiceImpl(this._repository);

  final AuthRepository _repository;

  @override
  Future<Result<bool>> verifyLogin(String phone) async {
    try {
      return Success(await _repository.login(phone));
    } catch (error, stackTrace) {
      return Failure(
        StorageFailure(
          'Unable to sign in. Please try again.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) async {
    try {
      await _repository.register(
        phone: phone,
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
      );
      return const Success<void>(null);
    } catch (error, stackTrace) {
      return Failure(
        StorageFailure(
          'Unable to create your account. Please try again.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _repository.logout();
      return const Success<void>(null);
    } catch (error, stackTrace) {
      return Failure(
        StorageFailure(
          'Unable to sign out. Please try again.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}
