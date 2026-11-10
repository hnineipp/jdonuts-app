import 'package:flutter_test/flutter_test.dart';
import 'package:jd_donuts/features/rewards/domain/models/challenge_progress.dart';

void main() {
  group('ChallengeProgress', () {
    test('0/4 has zero progress and is incomplete', () {
      const value = ChallengeProgress(completed: 0, target: 4);
      expect(value.fraction, 0);
      expect(value.label, '0/4');
      expect(value.isComplete, isFalse);
    });

    test('1/4 has one quarter progress', () {
      const value = ChallengeProgress(completed: 1, target: 4);
      expect(value.fraction, 0.25);
      expect(value.label, '1/4');
      expect(value.isComplete, isFalse);
    });

    test('4/4 is complete', () {
      const value = ChallengeProgress(completed: 4, target: 4);
      expect(value.fraction, 1);
      expect(value.label, '4/4');
      expect(value.isComplete, isTrue);
    });

    test('9/12 has three quarter progress', () {
      const value = ChallengeProgress(completed: 9, target: 12);
      expect(value.fraction, 0.75);
      expect(value.label, '9/12');
      expect(value.isComplete, isFalse);
    });

    test('rejects progress greater than target', () {
      expect(
        () => ChallengeProgress(completed: 5, target: 4),
        throwsAssertionError,
      );
    });
  });
}
