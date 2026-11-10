import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jd_donuts/data/auth/data_sources/local_auth_data_source.dart';
import 'package:jd_donuts/data/auth/domain/auth_service.dart';
import 'package:jd_donuts/data/auth/domain/repositories/auth_repository.dart';
import 'package:jd_donuts/data/auth/repositories/local_auth_repository.dart';
import 'package:jd_donuts/data/auth/services/auth_service_impl.dart';

final localAuthDataSourceProvider = Provider<LocalAuthDataSource>(
  (ref) => LocalAuthDataSource(
    LocalAuthDataSource.box,
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => LocalAuthRepository(
    ref.watch(localAuthDataSourceProvider),
  ),
);

final authServiceProvider = Provider<AuthService>(
  (ref) => AuthServiceImpl(
    ref.watch(authRepositoryProvider),
  ),
);
