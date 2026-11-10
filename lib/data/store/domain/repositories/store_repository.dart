abstract interface class StoreRepository {
  Future<Map<String, dynamic>> loadStoreData();
  Future<void> refresh();
}
