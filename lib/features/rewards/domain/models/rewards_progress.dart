class RewardsProgress {
  const RewardsProgress._();

  static double fromPoints({
    required int points,
    required int pointsToNextTier,
  }) {
    if (points < 0 || pointsToNextTier < 0) {
      throw ArgumentError('Points cannot be negative.');
    }

    final target = points + pointsToNextTier;
    if (target == 0) return 0;

    return (points / target).clamp(0.0, 1.0).toDouble();
  }

  static double clampVisualProgress(
    double actualProgress, {
    double maximum = 0.95,
  }) {
    if (maximum < 0 || maximum > 1) {
      throw ArgumentError('Maximum must be between 0 and 1.');
    }

    return actualProgress.clamp(0.0, maximum).toDouble();
  }
}
