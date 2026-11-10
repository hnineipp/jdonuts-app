class AuthValidators {
  AuthValidators._();

  static String normalizeMyanmarPhone(String input) {
    var digits = input.replaceAll(RegExp(r'[\s-]'), '');
    if (digits.startsWith('+95')) digits = digits.substring(3);
    if (digits.startsWith('0')) digits = digits.substring(1);
    return '+95$digits';
  }

  static bool isValidPhone(String input) {
    final normalized = normalizeMyanmarPhone(input);
    return RegExp(r'^\+959[0-9]{7,9}$').hasMatch(normalized);
  }

  static bool isValidOtp(String input) =>
      RegExp(r'^\d{6}$').hasMatch(input) && input == '123456';

  static bool isValidName(
    String input, {
    bool required = true,
  }) {
    final value = input.trim();

    if (value.isEmpty) return !required;

    if (value.runes.length > 50) return false;

    return RegExp(
      r'^[\p{L}\p{M} ]+$',
      unicode: true,
    ).hasMatch(value);
  }
}
