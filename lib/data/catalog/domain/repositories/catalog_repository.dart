abstract interface class CatalogRepository {
  Future<Map<String, dynamic>> loadCatalog();
  Future<void> refresh();
}
