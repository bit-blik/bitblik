import '../models/coordinator_record.dart';

/// Persistence interface for the coordinator registry.
///
/// Implementations live in the host package: app stores into
/// SharedPreferences, cli stores into a JSON file.
abstract class CoordinatorStore {
  Future<List<CoordinatorRecord>> load();

  Future<void> save(List<CoordinatorRecord> records);

  Future<bool> loadBootstrapCompleted(String paymentSystemId) async => false;

  Future<void> saveBootstrapCompleted(
    String paymentSystemId,
    bool value,
  ) async {}
}
