class RegistrationState {
  const RegistrationState({
    this.phone = '',
    this.firstName = '',
    this.lastName = '',
    this.dateOfBirth,
    this.isLogin = false,
    this.birthMonth = '',
    this.birthDay = '',
    this.birthYear = '',
    this.isLoading = false,
    this.error,
  });
  final String phone;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final bool isLogin;
  final String birthMonth;
  final String birthDay;
  final String birthYear;
  final bool isLoading;
  final String? error;

  RegistrationState copyWith({
    String? phone,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    bool clearDateOfBirth = false,
    bool? isLogin,
    String? birthMonth,
    String? birthDay,
    String? birthYear,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) =>
      RegistrationState(
        phone: phone ?? this.phone,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        dateOfBirth:
            clearDateOfBirth ? null : (dateOfBirth ?? this.dateOfBirth),
        isLogin: isLogin ?? this.isLogin,
        birthMonth: birthMonth ?? this.birthMonth,
        birthDay: birthDay ?? this.birthDay,
        birthYear: birthYear ?? this.birthYear,
        isLoading: isLoading ?? this.isLoading,
        error: clearError ? null : (error ?? this.error),
      );
}
