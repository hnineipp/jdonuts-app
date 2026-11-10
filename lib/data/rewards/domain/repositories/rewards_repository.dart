abstract interface class RewardsRepository {
  Future<Map<String, dynamic>> loadRewards();
  Future<void> refresh();
}
