import 'package:flutter_test/flutter_test.dart';
import 'package:jd_donuts/features/auth/domain/validators/auth_validators.dart';

void main() {
  group('Myanmar phone normalization', () {
    test('normalizes a leading zero', () {
      expect(AuthValidators.normalizeMyanmarPhone('09254135592'), '+959254135592');
    });

    test('removes spaces and dashes', () {
      expect(AuthValidators.normalizeMyanmarPhone('09 254-135 592'), '+959254135592');
    });

    test('preserves an existing +95 country code', () {
      expect(AuthValidators.normalizeMyanmarPhone('+95 9 254 135 592'), '+959254135592');
    });

    test('accepts valid normalized Myanmar mobile numbers', () {
      expect(AuthValidators.isValidPhone('09 254-135 592'), isTrue);
      expect(AuthValidators.isValidPhone('+959254135592'), isTrue);
    });

    test('rejects invalid phone numbers', () {
      expect(AuthValidators.isValidPhone('09123'), isFalse);
      expect(AuthValidators.isValidPhone('abc'), isFalse);
    });
  });

  group('OTP validation', () {
    test('accepts the demo OTP', () => expect(AuthValidators.isValidOtp('123456'), isTrue));
    test('rejects incorrect OTP', () => expect(AuthValidators.isValidOtp('123457'), isFalse));
    test('rejects incomplete OTP', () => expect(AuthValidators.isValidOtp('12345'), isFalse));
  });

  group('Name validation', () {
    test('requires first name', () {
      expect(AuthValidators.isValidName('Hnin Ei'), isTrue);
      expect(AuthValidators.isValidName(''), isFalse);
    });
    test('allows optional empty last name', () {
      expect(AuthValidators.isValidName('', required: false), isTrue);
    });
    test('accepts Myanmar script', () => expect(AuthValidators.isValidName('မေမြတ်'), isTrue));
    test('rejects numbers', () => expect(AuthValidators.isValidName('Hnin123'), isFalse));
    test('trims whitespace', () => expect(AuthValidators.isValidName('  Hnin  '), isTrue));
    test('rejects names over 50 characters', () {
      expect(AuthValidators.isValidName(List.filled(51, 'A').join()), isFalse);
    });
  });
}
