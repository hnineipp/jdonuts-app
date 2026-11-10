class ChallengeProgress {
  const ChallengeProgress({
    required this.completed,
    required this.target,
  })  : assert(target > 0),
        assert(completed >= 0),
        assert(completed <= target);

  final int completed;
  final int target;

  double get fraction => (completed / target).clamp(0.0, 1.0).toDouble();

  bool get isComplete => completed >= target;

  String get label => '$completed/$target';
}
