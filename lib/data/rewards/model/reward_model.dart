class RewardModel {
  final String id;
  final String title;
  final String subtitle;
  final int points;

  RewardModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
    );
  }
}
