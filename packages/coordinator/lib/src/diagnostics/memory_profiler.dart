import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../logging/app_logger.dart';
import '../services/coordinator_service.dart';
import '../services/nostr_service.dart';

class MemoryProfiler {
  MemoryProfiler({
    required CoordinatorService coordinatorService,
    required NostrService? nostrService,
    required Duration interval,
  })  : _coordinatorService = coordinatorService,
        _nostrService = nostrService,
        _interval = interval;

  final CoordinatorService _coordinatorService;
  final NostrService? _nostrService;
  final Duration _interval;

  Timer? _timer;

  void start() {
    _timer?.cancel();
    _emitSnapshot(reason: 'startup');
    _timer = Timer.periodic(_interval, (_) {
      _emitSnapshot(reason: 'periodic');
    });
  }

  Future<void> stop() async {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> emitManualSnapshot(String reason) async {
    await _emitSnapshot(reason: reason);
  }

  Future<void> _emitSnapshot({required String reason}) async {
    try {
      final snapshot = <String, dynamic>{
        'reason': reason,
        'pid': pid,
        'rss_bytes': ProcessInfo.currentRss,
        'proc_status': await _readProcStatus(),
        'proc_statm_pages': await _readProcStatmPages(),
        'smaps_rollup_kb': await _readSmapsRollupKb(),
        'fd_counts': await _readFdCounts(),
        'cgroup_memory': await _readCgroupMemory(),
        'coordinator': _coordinatorService.debugSnapshot(),
        'nostr': _nostrService?.debugSnapshot(),
      };
      AppLogger.info(
        'MEMORY_SNAPSHOT ${jsonEncode(snapshot)}',
        action: 'system.memory_snapshot',
      );
    } catch (e, st) {
      AppLogger.warning(
        'Failed to emit memory snapshot: $e',
        action: 'system.memory_snapshot',
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<Map<String, String>> _readProcStatus() async {
    final file = File('/proc/self/status');
    if (!await file.exists()) return const {};

    final out = <String, String>{};
    for (final line in await file.readAsLines()) {
      final idx = line.indexOf(':');
      if (idx <= 0) continue;
      final key = line.substring(0, idx);
      if (key == 'VmRSS' ||
          key == 'VmSize' ||
          key == 'VmSwap' ||
          key == 'RssAnon' ||
          key == 'RssFile' ||
          key == 'RssShmem' ||
          key == 'Threads') {
        out[key] = line.substring(idx + 1).trim();
      }
    }
    return out;
  }

  Future<Map<String, int>> _readSmapsRollupKb() async {
    final file = File('/proc/self/smaps_rollup');
    if (!await file.exists()) return const {};

    final out = <String, int>{};
    for (final line in await file.readAsLines()) {
      final parts = line.split(':');
      if (parts.length < 2) continue;
      final key = parts.first.trim();
      if (key != 'Rss' &&
          key != 'Pss' &&
          key != 'Private_Clean' &&
          key != 'Private_Dirty' &&
          key != 'Shared_Clean' &&
          key != 'Shared_Dirty') {
        continue;
      }
      final match = RegExp(r'(\d+)').firstMatch(parts[1]);
      if (match != null) {
        out[key] = int.parse(match.group(1)!);
      }
    }
    return out;
  }

  Future<Map<String, int>> _readProcStatmPages() async {
    final file = File('/proc/self/statm');
    if (!await file.exists()) return const {};

    final text = (await file.readAsString()).trim();
    final parts = text.split(RegExp(r'\s+'));
    if (parts.length < 7) return const {};

    int parseAt(int index) => int.tryParse(parts[index]) ?? 0;
    return {
      'size': parseAt(0),
      'resident': parseAt(1),
      'shared': parseAt(2),
      'text': parseAt(3),
      'lib': parseAt(4),
      'data': parseAt(5),
      'dt': parseAt(6),
    };
  }

  Future<Map<String, int>> _readFdCounts() async {
    final dir = Directory('/proc/self/fd');
    if (!await dir.exists()) return const {};

    var total = 0;
    var sockets = 0;
    var pipes = 0;
    var anonInodes = 0;
    await for (final entity in dir.list(followLinks: false)) {
      total++;
      try {
        final target = await Link(entity.path).target();
        if (target.startsWith('socket:')) {
          sockets++;
        } else if (target.startsWith('pipe:')) {
          pipes++;
        } else if (target.startsWith('anon_inode:')) {
          anonInodes++;
        }
      } catch (_) {
        // File descriptors can disappear while iterating; ignore races.
      }
    }

    return {
      'total': total,
      'sockets': sockets,
      'pipes': pipes,
      'anon_inodes': anonInodes,
    };
  }

  Future<Map<String, int>> _readCgroupMemory() async {
    Future<int?> readFirstInt(String path) async {
      final file = File(path);
      if (!await file.exists()) return null;
      final text = (await file.readAsString()).trim();
      final value = int.tryParse(text);
      return value;
    }

    final current = await readFirstInt('/sys/fs/cgroup/memory.current') ??
        await readFirstInt('/sys/fs/cgroup/memory/memory.usage_in_bytes');
    final peak = await readFirstInt('/sys/fs/cgroup/memory.peak') ??
        await readFirstInt('/sys/fs/cgroup/memory.max_usage_in_bytes');
    final swapCurrent = await readFirstInt(
            '/sys/fs/cgroup/memory.swap.current') ??
        await readFirstInt('/sys/fs/cgroup/memory/memory.memsw.usage_in_bytes');

    final out = <String, int>{};
    if (current != null) out['current_bytes'] = current;
    if (peak != null) out['peak_bytes'] = peak;
    if (swapCurrent != null) out['swap_current_bytes'] = swapCurrent;
    return out;
  }
}
