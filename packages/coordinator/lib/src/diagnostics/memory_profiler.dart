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
        'smaps_categories_kb': await _readSmapsCategoriesKb(),
        'smaps_top_regions': await _readSmapsTopRegions(),
        'fd_counts': await _readFdCounts(),
        'sockstat': await _readSockstat(),
        'cgroup_memory': await _readCgroupMemory(),
        'cgroup_memory_stat': await _readCgroupMemoryStat(),
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

  Future<Map<String, int>> _readSmapsCategoriesKb() async {
    final file = File('/proc/self/smaps');
    if (!await file.exists()) return const {};

    final out = <String, int>{
      'anonymous_private_dirty': 0,
      'anonymous_private_clean': 0,
      'file_private_dirty': 0,
      'file_private_clean': 0,
      'heap_private_dirty': 0,
      'heap_private_clean': 0,
      'stack_private_dirty': 0,
      'stack_private_clean': 0,
      'shared_private_dirty': 0,
      'shared_private_clean': 0,
    };

    String currentName = '';
    await for (final rawLine in file
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      if (_looksLikeSmapsHeader(rawLine)) {
        currentName = _extractSmapsName(rawLine);
        continue;
      }

      final colon = rawLine.indexOf(':');
      if (colon <= 0) continue;
      final key = rawLine.substring(0, colon);
      if (key != 'Private_Dirty' && key != 'Private_Clean') continue;
      final kb = _parseLeadingInt(rawLine.substring(colon + 1));
      if (kb == null) continue;

      final suffix = key == 'Private_Dirty' ? 'dirty' : 'clean';
      final bucket = switch (_classifySmapsRegion(currentName)) {
        _SmapsRegionClass.heap => 'heap_private_$suffix',
        _SmapsRegionClass.stack => 'stack_private_$suffix',
        _SmapsRegionClass.file => 'file_private_$suffix',
        _SmapsRegionClass.shared => 'shared_private_$suffix',
        _SmapsRegionClass.anonymous => 'anonymous_private_$suffix',
      };
      out[bucket] = (out[bucket] ?? 0) + kb;
    }

    return out;
  }

  Future<List<Map<String, Object>>> _readSmapsTopRegions() async {
    final file = File('/proc/self/smaps');
    if (!await file.exists()) return const [];

    final regions = <_SmapsRegionStat>[];
    _SmapsRegionStat? current;

    await for (final rawLine in file
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter())) {
      if (_looksLikeSmapsHeader(rawLine)) {
        if (current != null) {
          regions.add(current);
        }
        current = _SmapsRegionStat(
          name: _extractSmapsName(rawLine),
          category: _classifySmapsRegion(_extractSmapsName(rawLine)).name,
        );
        continue;
      }

      final region = current;
      if (region == null) continue;

      final colon = rawLine.indexOf(':');
      if (colon <= 0) continue;
      final key = rawLine.substring(0, colon);
      final kb = _parseLeadingInt(rawLine.substring(colon + 1));
      if (kb == null) continue;

      switch (key) {
        case 'Size':
          region.sizeKb = kb;
        case 'Rss':
          region.rssKb = kb;
        case 'Private_Dirty':
          region.privateDirtyKb = kb;
        case 'Private_Clean':
          region.privateCleanKb = kb;
      }
    }

    if (current != null) {
      regions.add(current);
    }

    regions.sort((a, b) {
      final dirty = b.privateDirtyKb.compareTo(a.privateDirtyKb);
      if (dirty != 0) return dirty;
      return b.rssKb.compareTo(a.rssKb);
    });

    return regions
        .where((region) =>
            region.privateDirtyKb >= 512 ||
            region.rssKb >= 1024 ||
            region.category != _SmapsRegionClass.file.name)
        .take(8)
        .map((region) => region.toJson())
        .toList(growable: false);
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

  Future<Map<String, int>> _readSockstat() async {
    final file = File('/proc/net/sockstat');
    if (!await file.exists()) return const {};

    final out = <String, int>{};
    for (final line in await file.readAsLines()) {
      final parts = line.split(RegExp(r'\s+'));
      if (parts.isEmpty) continue;

      if (parts.first == 'sockets:' && parts.length >= 3) {
        final used = int.tryParse(parts[2]);
        if (used != null) out['sockets_used'] = used;
        continue;
      }

      if (parts.first == 'TCP:' ||
          parts.first == 'UDP:' ||
          parts.first == 'RAW:') {
        final prefix =
            parts.first.substring(0, parts.first.length - 1).toLowerCase();
        for (var i = 1; i + 1 < parts.length; i += 2) {
          final value = int.tryParse(parts[i + 1]);
          if (value != null) {
            out['${prefix}_${parts[i].toLowerCase()}'] = value;
          }
        }
      }
    }
    return out;
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

  Future<Map<String, int>> _readCgroupMemoryStat() async {
    final candidates = [
      '/sys/fs/cgroup/memory.stat',
      '/sys/fs/cgroup/memory/memory.stat',
    ];

    File? file;
    for (final path in candidates) {
      final candidate = File(path);
      if (await candidate.exists()) {
        file = candidate;
        break;
      }
    }
    if (file == null) return const {};

    const interestingKeys = {
      'anon',
      'file',
      'kernel',
      'kernel_stack',
      'pagetables',
      'percpu',
      'sock',
      'slab',
      'slab_reclaimable',
      'slab_unreclaimable',
      'file_mapped',
      'file_dirty',
      'file_writeback',
      'anon_thp',
      'inactive_anon',
      'active_anon',
      'inactive_file',
      'active_file',
    };

    final out = <String, int>{};
    for (final line in await file.readAsLines()) {
      final parts = line.split(RegExp(r'\s+'));
      if (parts.length != 2) continue;
      if (!interestingKeys.contains(parts[0])) continue;
      final value = int.tryParse(parts[1]);
      if (value != null) out[parts[0]] = value;
    }
    return out;
  }

  bool _looksLikeSmapsHeader(String line) {
    return RegExp(r'^[0-9a-fA-F]+-[0-9a-fA-F]+\s').hasMatch(line);
  }

  String _extractSmapsName(String line) {
    final match = RegExp(
      r'^[0-9a-fA-F]+-[0-9a-fA-F]+\s+\S+\s+\S+\s+\S+\s+\S+\s*(.*)$',
    ).firstMatch(line);
    final tail = match?.group(1)?.trim() ?? '';
    return tail.isEmpty ? '[anonymous]' : tail;
  }

  int? _parseLeadingInt(String text) {
    final match = RegExp(r'(\d+)').firstMatch(text);
    return match == null ? null : int.tryParse(match.group(1)!);
  }

  _SmapsRegionClass _classifySmapsRegion(String name) {
    if (name == '[heap]') return _SmapsRegionClass.heap;
    if (name.startsWith('[stack')) return _SmapsRegionClass.stack;
    if (name == '[vdso]' ||
        name == '[vvar]' ||
        name == '[vsyscall]' ||
        name == '[vectors]') {
      return _SmapsRegionClass.shared;
    }
    if (name.startsWith('/')) return _SmapsRegionClass.file;
    return _SmapsRegionClass.anonymous;
  }
}

enum _SmapsRegionClass {
  anonymous,
  file,
  heap,
  shared,
  stack,
}

final class _SmapsRegionStat {
  _SmapsRegionStat({required this.name, required this.category});

  final String name;
  final String category;
  int sizeKb = 0;
  int rssKb = 0;
  int privateDirtyKb = 0;
  int privateCleanKb = 0;

  Map<String, Object> toJson() {
    return {
      'name': name,
      'category': category,
      'size_kb': sizeKb,
      'rss_kb': rssKb,
      'private_dirty_kb': privateDirtyKb,
      'private_clean_kb': privateCleanKb,
    };
  }
}
