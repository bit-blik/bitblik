import 'package:shared_preferences/shared_preferences.dart';

/// Persists the exact coordinator-chat messages that were actually displayed.
///
/// Message ids are preferable to a timestamp cursor: a relay can deliver an
/// older message late, and that message must still become unread.
class DisputeReadStore {
  static const _keyPrefix = 'coordinator_console.read_messages.v1.';

  const DisputeReadStore();

  String _key(String coordinatorPubkey) =>
      '$_keyPrefix${coordinatorPubkey.trim().toLowerCase()}';

  Future<Set<String>> load(String coordinatorPubkey) async {
    if (coordinatorPubkey.trim().isEmpty) return <String>{};
    final preferences = await SharedPreferences.getInstance();
    return (preferences.getStringList(_key(coordinatorPubkey)) ?? const [])
        .where((id) => id.isNotEmpty)
        .toSet();
  }

  Future<void> save(
    String coordinatorPubkey,
    Iterable<String> messageIds,
  ) async {
    if (coordinatorPubkey.trim().isEmpty) return;
    final ids = messageIds.where((id) => id.isNotEmpty).toSet().toList()
      ..sort();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(_key(coordinatorPubkey), ids);
  }
}
