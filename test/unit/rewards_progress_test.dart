import 'package:flutter_test/flutter_test.dart';
import 'package:jd_donuts/features/rewards/domain/models/rewards_progress.dart';

void main() {
  group('RewardsProgress.fromPoints', () {
    test('calculates progress from accumulated and remaining points', () {
      final value = RewardsProgress.fromPoints(
        points: 680000,
        pointsToNextTier: 1290,
      );
      expect(value, closeTo(0.998105, 0.00001));
    });

    test('returns zero when both values are zero', () {
      expect(RewardsProgress.fromPoints(points: 0, pointsToNextTier: 0), 0);
    });

    test('returns one when no points remain', () {
      expect(RewardsProgress.fromPoints(points: 100, pointsToNextTier: 0), 1);
    });

    test('rejects negative points', () {
      expect(
        () => RewardsProgress.fromPoints(points: -1, pointsToNextTier: 10),
        throwsArgumentError,
      );
    });
  });

  group('RewardsProgress.clampVisualProgress', () {
    test('caps decorative ring without changing actual progress', () {
      expect(RewardsProgress.clampVisualProgress(0.998), 0.95);
      expect(0.998, closeTo(0.998, 0.000001));
    });

    test('does not change values below the cap', () {
      expect(RewardsProgress.clampVisualProgress(0.7), 0.7);
    });
  });
}
