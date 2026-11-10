import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jd_donuts/data/local/local_app_data_source.dart';
import 'package:jd_donuts/data/rewards/domain/repositories/rewards_repository.dart';
import 'package:jd_donuts/data/rewards/domain/rewards_service.dart';
import 'package:jd_donuts/data/rewards/repositories/local_rewards_repository.dart';
import 'package:jd_donuts/data/rewards/services/rewards_service_impl.dart';

final rewardsRepositoryProvider = Provider<RewardsRepository>(
  (ref) => LocalRewardsRepository(ref.watch(localAppDataSourceProvider)),
);

final rewardsServiceProvider = Provider<RewardsService>(
  (ref) => RewardsServiceImpl(ref.watch(rewardsRepositoryProvider)),
);
