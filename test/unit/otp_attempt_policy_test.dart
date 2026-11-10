import 'package:flutter_test/flutter_test.dart';
import 'package:jd_donuts/data/auth/domain/otp_attempt_policy.dart';

void main() {
  group('OtpAttemptPolicy', () {
    test('does not lock before three incorrect attempts', () {
      final policy = OtpAttemptPolicy();
      expect(policy.recordIncorrectAttempt(), isFalse);
      expect(policy.recordIncorrectAttempt(), isFalse);
      expect(policy.attempts, 2);
      expect(policy.isLocked, isFalse);
    });

    test('locks on the third incorrect attempt', () {
      final policy = OtpAttemptPolicy();
      policy.recordIncorrectAttempt();
      policy.recordIncorrectAttempt();
      expect(policy.recordIncorrectAttempt(), isTrue);
      expect(policy.isLocked, isTrue);
      expect(policy.attempts, 3);
    });

    test('does not increase attempts after lock', () {
      final policy = OtpAttemptPolicy();
      for (var i = 0; i < 4; i++) {
        policy.recordIncorrectAttempt();
      }
      expect(policy.attempts, 3);
    });

    test('resets attempts when resend is accepted', () {
      final policy = OtpAttemptPolicy();
      policy.recordIncorrectAttempt();
      policy.recordIncorrectAttempt();
      policy.recordIncorrectAttempt();
      policy.reset();
      expect(policy.attempts, 0);
      expect(policy.isLocked, isFalse);
    });
  });
}
