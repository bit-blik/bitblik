import 'dart:async';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

import '../logging/app_logger.dart';
import 'memory_profiler.dart';

class PrometheusExporter {
  PrometheusExporter({
    required MemoryProfiler memoryProfiler,
    InternetAddress? host,
    required int port,
    Duration scrapeCacheTtl = const Duration(seconds: 5),
  })  : _memoryProfiler = memoryProfiler,
        _host = host ?? InternetAddress.anyIPv4,
        _port = port,
        _scrapeCacheTtl = scrapeCacheTtl;

  final MemoryProfiler _memoryProfiler;
  final InternetAddress _host;
  final int _port;
  final Duration _scrapeCacheTtl;

  HttpServer? _server;
  DateTime? _lastScrapeAt;
  String? _lastScrapeBody;

  Future<void> start() async {
    if (_server != null) return;

    final router = Router()
      ..get('/healthz', (Request request) => Response.ok('ok\n'))
      ..get('/metrics', _handleMetrics);

    _server = await shelf_io.serve(
      const Pipeline().addMiddleware(logRequests()).addHandler(router.call),
      _host,
      _port,
    );

    AppLogger.info(
      'Prometheus exporter listening on http://${_server!.address.address}:${_server!.port}/metrics',
      action: 'system.metrics',
    );
  }

  Future<void> stop() async {
    final server = _server;
    _server = null;
    await server?.close(force: true);
  }

  Future<Response> _handleMetrics(Request request) async {
    try {
      final now = DateTime.now().toUtc();
      final cachedBody = _lastScrapeBody;
      final lastScrapeAt = _lastScrapeAt;
      final body = cachedBody != null &&
              lastScrapeAt != null &&
              now.difference(lastScrapeAt) < _scrapeCacheTtl
          ? cachedBody
          : await _collectMetricsBody(now);
      return Response.ok(
        body,
        headers: {HttpHeaders.contentTypeHeader: 'text/plain; version=0.0.4'},
      );
    } catch (e, st) {
      AppLogger.warning(
        'Failed to build Prometheus metrics payload: $e',
        action: 'system.metrics',
        error: e,
        stackTrace: st,
      );
      return Response.internalServerError(body: 'metrics collection failed\n');
    }
  }

  Future<String> _collectMetricsBody(DateTime now) async {
    final snapshot = await _memoryProfiler.collectSnapshot(reason: 'scrape');
    final body = _PrometheusFormatter().formatSnapshot(snapshot);
    _lastScrapeAt = now;
    _lastScrapeBody = body;
    return body;
  }
}

class _PrometheusFormatter {
  final StringBuffer _buffer = StringBuffer();
  final Set<String> _declaredMetrics = <String>{};

  String formatSnapshot(Map<String, dynamic> snapshot) {
    _writeSnapshot(snapshot);
    return _buffer.toString();
  }

  void _writeSnapshot(Map<String, dynamic> snapshot) {
    gauge(
      'bitblik_process_rss_bytes',
      'Resident set size of the coordinator process in bytes.',
      _asNum(snapshot['rss_bytes']),
    );

    _writeProcStatus(snapshot['proc_status'] as Map<String, dynamic>?);
    _writeCgroup(snapshot['cgroup_memory'] as Map<String, dynamic>?);
    _writeCgroupStat(snapshot['cgroup_memory_stat'] as Map<String, dynamic>?);
    _writeSmaps(snapshot['smaps_rollup_kb'] as Map<String, dynamic>?);
    _writeSmapsCategories(
        snapshot['smaps_categories_kb'] as Map<String, dynamic>?);
    _writeFdCounts(snapshot['fd_counts'] as Map<String, dynamic>?);
    _writeSockstat(snapshot['sockstat'] as Map<String, dynamic>?);
    _writeProcessSocketSummary(
        snapshot['process_socket_summary'] as Map<String, dynamic>?);
    _writeCoordinator(snapshot['coordinator'] as Map<String, dynamic>?);
    _writeNostr(snapshot['nostr'] as Map<String, dynamic>?);
  }

  void _writeProcStatus(Map<String, dynamic>? procStatus) {
    if (procStatus == null) return;

    gauge(
      'bitblik_proc_vmrss_kilobytes',
      'VmRSS from /proc/self/status in kilobytes.',
      _parseKbString(procStatus['VmRSS']),
    );
    gauge(
      'bitblik_proc_rss_anon_kilobytes',
      'RssAnon from /proc/self/status in kilobytes.',
      _parseKbString(procStatus['RssAnon']),
    );
    gauge(
      'bitblik_proc_rss_file_kilobytes',
      'RssFile from /proc/self/status in kilobytes.',
      _parseKbString(procStatus['RssFile']),
    );
    gauge(
      'bitblik_proc_vmswap_kilobytes',
      'VmSwap from /proc/self/status in kilobytes.',
      _parseKbString(procStatus['VmSwap']),
    );
    gauge(
      'bitblik_process_threads',
      'Thread count from /proc/self/status.',
      _parseIntString(procStatus['Threads']),
    );
  }

  void _writeCgroup(Map<String, dynamic>? cgroup) {
    if (cgroup == null) return;
    gauge(
      'bitblik_cgroup_memory_current_bytes',
      'Current cgroup memory usage in bytes.',
      _asNum(cgroup['current_bytes']),
    );
    gauge(
      'bitblik_cgroup_memory_peak_bytes',
      'Peak cgroup memory usage in bytes.',
      _asNum(cgroup['peak_bytes']),
    );
    gauge(
      'bitblik_cgroup_memory_swap_current_bytes',
      'Current cgroup swap usage in bytes.',
      _asNum(cgroup['swap_current_bytes']),
    );
  }

  void _writeCgroupStat(Map<String, dynamic>? stats) {
    if (stats == null) return;
    for (final entry in stats.entries) {
      gauge(
        'bitblik_cgroup_memory_stat_bytes',
        'Selected cgroup memory.stat fields in bytes.',
        _asNum(entry.value),
        labels: {'field': entry.key},
      );
    }
  }

  void _writeSmaps(Map<String, dynamic>? smaps) {
    if (smaps == null) return;
    for (final entry in smaps.entries) {
      gauge(
        'bitblik_smaps_rollup_kilobytes',
        'Selected /proc/self/smaps_rollup fields in kilobytes.',
        _asNum(entry.value),
        labels: {'field': entry.key},
      );
    }
  }

  void _writeSmapsCategories(Map<String, dynamic>? categories) {
    if (categories == null) return;
    for (final entry in categories.entries) {
      gauge(
        'bitblik_smaps_category_kilobytes',
        'Aggregated /proc/self/smaps category totals in kilobytes.',
        _asNum(entry.value),
        labels: {'category': entry.key},
      );
    }
  }

  void _writeFdCounts(Map<String, dynamic>? fdCounts) {
    if (fdCounts == null) return;
    for (final entry in fdCounts.entries) {
      gauge(
        'bitblik_process_fds',
        'Open file descriptor counts by class.',
        _asNum(entry.value),
        labels: {'kind': entry.key},
      );
    }
  }

  void _writeSockstat(Map<String, dynamic>? sockstat) {
    if (sockstat == null) return;
    for (final entry in sockstat.entries) {
      gauge(
        'bitblik_sockstat',
        'Selected /proc/net/sockstat values.',
        _asNum(entry.value),
        labels: {'field': entry.key},
      );
    }
  }

  void _writeProcessSocketSummary(Map<String, dynamic>? summary) {
    if (summary == null) return;
    gauge(
      'bitblik_process_socket_fd_count',
      'Socket file descriptors currently opened by the coordinator process.',
      _asNum(summary['socket_fd_count']),
    );
    gauge(
      'bitblik_process_unmapped_socket_fd_count',
      'Socket file descriptors that did not match /proc/net/tcp or tcp6.',
      _asNum(summary['unmapped_socket_fd_count']),
    );

    final stateCounts = summary['tcp_state_counts'];
    if (stateCounts is Map) {
      for (final entry in stateCounts.entries) {
        gauge(
          'bitblik_process_tcp_connections',
          'Coordinator process TCP connections by state.',
          _asNum(entry.value),
          labels: {'state': entry.key.toString()},
        );
      }
    }

    final remoteCounts = summary['tcp_remote_endpoints'];
    if (remoteCounts is Map) {
      for (final entry in remoteCounts.entries) {
        gauge(
          'bitblik_process_tcp_remote_endpoints',
          'Coordinator process TCP connections by remote endpoint.',
          _asNum(entry.value),
          labels: {'remote': entry.key.toString()},
        );
      }
    }
  }

  void _writeCoordinator(Map<String, dynamic>? coordinator) {
    if (coordinator == null) return;

    gauge(
      'bitblik_coordinator_pending_offers',
      'Number of pending offers tracked in memory.',
      _asNum(coordinator['pending_offers']),
    );
    gauge(
      'bitblik_coordinator_invoice_subscriptions',
      'Number of active invoice subscriptions.',
      _asNum(coordinator['invoice_subscriptions']),
    );
    gauge(
      'bitblik_coordinator_pending_offer_timeouts',
      'Number of active pending-offer timeout timers.',
      _asNum(coordinator['pending_offer_timeouts']),
    );
    gauge(
      'bitblik_coordinator_status_republish_timers',
      'Number of active status republish timers.',
      _asNum(coordinator['status_republish_timers']),
    );
    gauge(
      'bitblik_coordinator_cached_rates',
      'Number of cached exchange rates.',
      _asNum(coordinator['cached_rates']),
    );
    gauge(
      'bitblik_coordinator_matrix_initialized',
      'Whether the Matrix client is initialized (1 or 0).',
      _asBoolNum(coordinator['matrix_initialized']),
    );
    gauge(
      'bitblik_coordinator_telegram_configured',
      'Whether Telegram is configured (1 or 0).',
      _asBoolNum(coordinator['telegram_configured']),
    );
  }

  void _writeNostr(Map<String, dynamic>? nostr) {
    if (nostr == null) return;

    gauge(
      'bitblik_nostr_request_subscription_active',
      'Whether the Nostr request subscription exists (1 or 0).',
      _asBoolNum(nostr['request_subscription_active']),
    );
    gauge(
      'bitblik_nostr_request_listener_active',
      'Whether the Dart listener over the Nostr request subscription exists (1 or 0).',
      _asBoolNum(nostr['request_listener_active']),
    );
    gauge(
      'bitblik_nostr_relay_refresh_timer_active',
      'Whether the relay refresh timer is active (1 or 0).',
      _asBoolNum(nostr['relay_refresh_timer_active']),
    );
    gauge(
      'bitblik_nostr_relay_grace_timer_active',
      'Whether the relay grace timer is active (1 or 0).',
      _asBoolNum(nostr['relay_grace_timer_active']),
    );

    counter(
      'bitblik_nostr_requests_received_total',
      'Total Nostr RPC requests received.',
      _asNum(nostr['requests_received']),
    );
    counter(
      'bitblik_nostr_responses_sent_total',
      'Total Nostr RPC responses sent.',
      _asNum(nostr['responses_sent']),
    );
    counter(
      'bitblik_nostr_response_errors_total',
      'Total Nostr RPC response send errors.',
      _asNum(nostr['response_errors']),
    );

    final rpcCounts = nostr['rpc_method_counts'];
    if (rpcCounts is Map) {
      for (final entry in rpcCounts.entries) {
        counter(
          'bitblik_nostr_rpc_method_total',
          'Total Nostr RPC requests by method.',
          _asNum(entry.value),
          labels: {'method': entry.key.toString()},
        );
      }
    }

    gauge(
      'bitblik_nostr_cache_event_count',
      'Number of cached Nostr events.',
      _asNum(nostr['cache_event_count']),
    );
    gauge(
      'bitblik_nostr_cache_event_source_count',
      'Number of cached Nostr event sources.',
      _asNum(nostr['cache_event_source_count']),
    );
    gauge(
      'bitblik_nostr_cache_delivery_record_count',
      'Number of Nostr delivery records tracked in cache.',
      _asNum(nostr['cache_delivery_record_count']),
    );

    final deliveryCounts = nostr['cache_delivery_status_counts'];
    if (deliveryCounts is Map) {
      for (final entry in deliveryCounts.entries) {
        gauge(
          'bitblik_nostr_cache_delivery_status_count',
          'Nostr cache delivery records by status.',
          _asNum(entry.value),
          labels: {'status': entry.key.toString()},
        );
      }
    }

    final eventKindCounts = nostr['cache_event_kind_counts'];
    if (eventKindCounts is Map) {
      for (final entry in eventKindCounts.entries) {
        gauge(
          'bitblik_nostr_cache_event_kind_count',
          'Nostr cache events by event kind.',
          _asNum(entry.value),
          labels: {'kind': entry.key.toString()},
        );
      }
    }

    final ndk = nostr['ndk_runtime'];
    if (ndk is Map<String, dynamic>) {
      for (final entry in ndk.entries) {
        final value = entry.value;
        if (value is bool) {
          gauge(
            'bitblik_ndk_runtime',
            'NDK runtime state values.',
            _asBoolNum(value),
            labels: {'field': entry.key},
          );
        } else if (value is num) {
          gauge(
            'bitblik_ndk_runtime',
            'NDK runtime state values.',
            value,
            labels: {'field': entry.key},
          );
        } else if (value is Map) {
          for (final nested in value.entries) {
            gauge(
              'bitblik_ndk_runtime_nested',
              'Nested NDK runtime state values.',
              _asNum(nested.value),
              labels: {
                'field': entry.key,
                'key': nested.key.toString(),
              },
            );
          }
        }
      }
    }
  }

  void gauge(
    String name,
    String help,
    num value, {
    Map<String, String> labels = const {},
  }) {
    _declareMetric(name, help, 'gauge');
    _buffer.writeln('${_sample(name, labels)} ${_formatValue(value)}');
  }

  void counter(
    String name,
    String help,
    num value, {
    Map<String, String> labels = const {},
  }) {
    _declareMetric(name, help, 'counter');
    _buffer.writeln('${_sample(name, labels)} ${_formatValue(value)}');
  }

  void _declareMetric(String name, String help, String type) {
    if (_declaredMetrics.add(name)) {
      _buffer.writeln('# HELP $name ${_escapeHelp(help)}');
      _buffer.writeln('# TYPE $name $type');
    }
  }

  String _sample(String name, Map<String, String> labels) {
    if (labels.isEmpty) return name;
    final encoded = labels.entries
        .map((entry) => '${entry.key}="${_escapeLabelValue(entry.value)}"')
        .join(',');
    return '$name{$encoded}';
  }

  String _escapeHelp(String value) =>
      value.replaceAll(r'\', r'\\').replaceAll('\n', r'\n');

  String _escapeLabelValue(String value) => value
      .replaceAll(r'\', r'\\')
      .replaceAll('\n', r'\n')
      .replaceAll('"', r'\"');

  String _formatValue(num value) {
    if (value is int) return value.toString();
    return value.toString();
  }

  num _asNum(Object? value) {
    if (value is num) return value;
    if (value is String) {
      return num.tryParse(value) ?? 0;
    }
    return 0;
  }

  num _asBoolNum(Object? value) => value == true ? 1 : 0;

  num _parseKbString(Object? value) {
    if (value is! String) return 0;
    final match = RegExp(r'(\d+)').firstMatch(value);
    return match == null ? 0 : int.parse(match.group(1)!);
  }

  num _parseIntString(Object? value) {
    if (value is num) return value;
    if (value is! String) return 0;
    return int.tryParse(value) ?? 0;
  }
}
