import 'package:jd_donuts/core/errors/result.dart';

abstract interface class RewardsService {
  Future<Result<Map<String, dynamic>>> getRewards();
  Future<void> refresh();
}
