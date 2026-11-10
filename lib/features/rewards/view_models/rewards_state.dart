import 'package:jd_donuts/data/rewards/domain/models/rewards_progress.dart';
import 'package:jd_donuts/data/rewards/model/challenge_model.dart';
import 'package:jd_donuts/data/rewards/model/reward_model.dart';
import 'package:jd_donuts/data/store/model/member_model.dart';

class RewardsState {
  const RewardsState({
    required this.member,
    required this.points,
    required this.pointsToNextTier,
    required this.pointsProgress,
    required this.tierProgress,
    required this.challenges,
    required this.gifts,
  });

  final MemberModel member;
  final int points;
  final int pointsToNextTier;
  final double pointsProgress;
  final double tierProgress;
  final List<ChallengeModel> challenges;
  final List<RewardModel> gifts;

  String get memberTier => member.tier;
  String get nextTier => member.nextTier;

  factory RewardsState.fromJson(Map<String, dynamic> json) {
    final memberValue = json['member'];

    if (memberValue is! Map) {
      throw StateError(
        'Member profile is missing from Rewards data.',
      );
    }

    final memberJson = Map<String, dynamic>.from(memberValue);
    final member = MemberModel.fromJson(memberJson);

    final points = _toInt(memberJson['points']);
    final pointsToNextTier = member.pointsToNextTier;

    final calculatedProgress = RewardsProgress.fromPoints(
      points: points,
      pointsToNextTier: pointsToNextTier,
    );

    final challenges = _readList(
      json['challenges'],
      field: 'challenges',
    ).map(ChallengeModel.fromJson).toList(growable: false);

    final gifts = _readList(
      json['gifts'],
      field: 'gifts',
    ).map(RewardModel.fromJson).toList(growable: false);

    return RewardsState(
      member: member,
      points: points,
      pointsToNextTier: pointsToNextTier,
      pointsProgress: _toProgress(
        memberJson['pointsProgress'],
        fallback: calculatedProgress,
      ),
      tierProgress: _toProgress(
        memberJson['tierProgress'],
        fallback: calculatedProgress,
      ),
      challenges: challenges,
      gifts: gifts,
    );
  }

  static List<Map<String, dynamic>> _readList(
    dynamic value, {
    required String field,
  }) {
    if (value is! List) {
      throw StateError('Rewards $field must be a list.');
    }

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList(growable: false);
  }

  static int _toInt(dynamic value) {
    if (value is num) return value.toInt();

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toProgress(
    dynamic value, {
    required double fallback,
  }) {
    if (value is num) {
      return value.toDouble().clamp(0.0, 1.0).toDouble();
    }

    final parsed = double.tryParse(value?.toString() ?? '');

    return parsed?.clamp(0.0, 1.0).toDouble() ?? fallback;
  }
}
