import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/result.dart';
import '../../../../core/storage/session_storage.dart';
import '../../data/data_sources/local_auth_data_source.dart';
import '../../data/repositories/local_auth_repository.dart';
import '../../data/services/auth_service_impl.dart';
import '../../domain/auth_service.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

final localAuthDataSourceProvider = Provider<LocalAuthDataSource>(
  (ref) => LocalAuthDataSource(
    LocalAuthDataSource.box,
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => LocalAuthRepository(
    ref.watch(localAuthDataSourceProvider),
  ),
);

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthServiceImpl(
    ref.watch(authRepositoryProvider),
  ),
);

final authControllerProvider =
    NotifierProvider<_AuthViewModelImpl, bool>(_AuthViewModelImpl.new);

final registrationControllerProvider =
    NotifierProvider<_RegistrationViewModelImpl, RegistrationState>(
  _RegistrationViewModelImpl.new,
);

abstract interface class AuthViewModel {
  Future<bool> verifyLogin(String phone);
  Future<void> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  });
  Future<void> logout();
}

abstract interface class RegistrationViewModel {
  void setPhone(String value, {bool login = false});
  void setName(String first, String last);
  void setBirthDate(DateTime value);
  void setBirthDateDraft({
    required String month,
    required String day,
    required String year,
  });
  void setLoading(bool value);
  void setError(String? value);
  void reset();
}

extension AuthVMX on WidgetRef {
  bool get authState => watch(authControllerProvider);
  AuthViewModel get authVM => read(authControllerProvider.notifier);
  RegistrationState get registrationState =>
      watch(registrationControllerProvider);
  RegistrationViewModel get registrationVM =>
      read(registrationControllerProvider.notifier);
}

class _RegistrationViewModelImpl extends Notifier<RegistrationState>
    implements RegistrationViewModel {
  @override
  RegistrationState build() => const RegistrationState();

  @override
  void setPhone(String value, {bool login = false}) {
    state = state.copyWith(phone: value, isLogin: login, clearError: true);
  }

  @override
  void setName(String first, String last) {
    state = state.copyWith(
      firstName: first,
      lastName: last,
      clearError: true,
    );
  }

  @override
  void setBirthDate(DateTime value) {
    state = state.copyWith(dateOfBirth: value, clearError: true);
  }

  @override
  void setBirthDateDraft({
    required String month,
    required String day,
    required String year,
  }) {
    state = state.copyWith(
      birthMonth: month,
      birthDay: day,
      birthYear: year,
    );
  }

  @override
  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  @override
  void setError(String? value) {
    state = state.copyWith(error: value, isLoading: false);
  }

  @override
  void reset() => state = const RegistrationState();
}

class _AuthViewModelImpl extends Notifier<bool> implements AuthViewModel {
  @override
  bool build() => SessionStorage.isLoggedIn;

  @override
  Future<bool> verifyLogin(String phone) async {
    final result = await ref.read(authServiceProvider).verifyLogin(phone);
    switch (result) {
      case Success<bool>(value: true):
        await SessionStorage.save();
        ref.read(registrationControllerProvider.notifier).reset();
        state = true;
        return true;
      case Success<bool>():
        return false;
      case Failure<bool>(:final failure):
        throw StateError(failure.message);
    }
  }

  @override
  Future<void> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) async {
    final result = await ref.read(authServiceProvider).register(
          phone: phone,
          firstName: firstName,
          lastName: lastName,
          dateOfBirth: dateOfBirth,
        );
    if (result case Failure<void>(:final failure)) {
      throw StateError(failure.message);
    }
    await SessionStorage.save();

    ref.read(registrationControllerProvider.notifier).reset();
    state = true;
  }

  @override
  Future<void> logout() async {
    final result = await ref.read(authServiceProvider).logout();

    if (result case Failure<void>(:final failure)) {
      throw StateError(failure.message);
    }

    await SessionStorage.clear();

    ref.read(registrationControllerProvider.notifier).reset();

    state = false;
  }
}
