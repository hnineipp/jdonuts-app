import 'package:jd_donuts/data/local/local_app_data_source.dart';
import 'package:jd_donuts/data/rewards/domain/repositories/rewards_repository.dart';

class LocalRewardsRepository implements RewardsRepository {
  LocalRewardsRepository(this._dataSource);

  final LocalAppDataSource _dataSource;

  @override
  Future<Map<String, dynamic>> loadRewards() async {
    final appData = await _dataSource.readAppData();

    return <String, dynamic>{
      'member': appData['member'],
      'gifts': appData['gifts'] ?? const <dynamic>[],
      'challenges': appData['challenges'] ?? const <dynamic>[],
    };
  }

  @override
  Future<void> refresh() async {
    // Local database remains the source of truth.
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }
}
