import 'package:jd_donuts/core/errors/app_failure.dart';
import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/rewards/domain/repositories/rewards_repository.dart';
import 'package:jd_donuts/data/rewards/domain/rewards_service.dart';

class RewardsServiceImpl implements RewardsService {
  const RewardsServiceImpl(this._repository);

  final RewardsRepository _repository;

  @override
  Future<Result<Map<String, dynamic>>> getRewards() async {
    try {
      return Success(await _repository.loadRewards());
    } catch (error, stackTrace) {
      return Failure(
        UnknownFailure(
          'Rewards data could not be loaded.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> refresh() => _repository.refresh();
}
