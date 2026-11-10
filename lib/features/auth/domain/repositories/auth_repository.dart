abstract interface class AuthRepository {
  Future<bool> login(String phone);
  Future<void> register({
    required String phone,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  });
  Future<void> logout();
  Future<bool> hasRegisteredPhone(String phone);
}
