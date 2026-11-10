class ChallengeModel {
  final String id;
  final String title;
  final int progress;
  final int target;
  final String kind;
  final String image;
  final int points;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.progress,
    required this.target,
    required this.kind,
    required this.image,
    required this.points,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      target: (json['target'] as num?)?.toInt() ?? 0,
      kind: json['kind'] ?? '',
      image: json['image'] ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
    );
  }

  double get progressFraction {
    if (target <= 0) return 0;
    return (progress / target).clamp(0.0, 1.0).toDouble();
  }

  bool get isComplete => target > 0 && progress >= target;
}
