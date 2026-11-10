import 'package:jd_donuts/core/errors/app_failure.dart';
import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/catalog/domain/catalog_service.dart';
import 'package:jd_donuts/data/catalog/domain/repositories/catalog_repository.dart';

class CatalogServiceImpl implements CatalogService {
  const CatalogServiceImpl(this._repository);
  final CatalogRepository _repository;

  @override
  Future<Result<Map<String, dynamic>>> getCatalog() async {
    try {
      return Success(await _repository.loadCatalog());
    } catch (error, stackTrace) {
      return Failure(UnknownFailure('Catalog could not be loaded.', cause: error, stackTrace: stackTrace));
    }
  }

  @override
  Future<void> refresh() => _repository.refresh();
}
