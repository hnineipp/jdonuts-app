class MemberModel {
  final String name;
  final String photo;
  final String tier;
  final int pointsToNextTier;
  final String nextTier;
  final int notifications;

  MemberModel({
    required this.name,
    required this.photo,
    required this.tier,
    required this.pointsToNextTier,
    required this.nextTier,
    required this.notifications,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
      tier: json['tier'] ?? '',
      pointsToNextTier: (json['pointsToNextTier'] as num?)?.toInt() ?? 0,
      nextTier: json['nextTier'] ?? 'Gold',
      notifications: (json['notifications'] as num?)?.toInt() ?? 0,
    );
  }
}
