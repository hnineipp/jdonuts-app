import 'package:jd_donuts/core/errors/app_failure.dart';
import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/store/domain/repositories/store_repository.dart';
import 'package:jd_donuts/data/store/domain/store_service.dart';

class StoreServiceImpl implements StoreService {
  const StoreServiceImpl(this._repository);

  final StoreRepository _repository;

  @override
  Future<Result<Map<String, dynamic>>> getStoreData() async {
    try {
      return Success(await _repository.loadStoreData());
    } catch (error, stackTrace) {
      return Failure(
        UnknownFailure(
          'Store data could not be loaded.',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> refresh() => _repository.refresh();
}
