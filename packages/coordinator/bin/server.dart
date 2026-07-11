import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/nostr_service.dart';
import 'package:bitblik_coordinator/src/diagnostics/memory_profiler.dart';
import 'package:bitblik_coordinator/src/diagnostics/prometheus_exporter.dart';
import 'package:bitblik_coordinator/src/logging/app_logger.dart';

Future<void> main(List<String> args) async {
  // Run everything inside a guarded zone so an uncaught ASYNC error — e.g. the
  // ndk relay manager throwing from a reconnect/resubscribe timer callback,
  // which is outside any try/catch — is logged instead of terminating the
  // coordinator process.
  runZonedGuarded(() async {
    await _runCoordinator(args);
  }, (error, stack) {
    AppLogger.warning(
      'Uncaught async error — coordinator kept alive: $error',
      action: 'system.uncaught',
      error: error,
      stackTrace: stack,
    );
  });
}

Future<void> _runCoordinator(List<String> args) async {
  AppLogger.initialize();
  // --- Configuration ---
  // Load environment variables from .env file and platform environment
  var env = DotEnv(includePlatformEnvironment: true)..load();

  AppLogger.info('=== Configuration ===');
  AppLogger.info('DB_HOST: ${env['DB_HOST'] ?? 'localhost'}');
  AppLogger.info('DB_PORT: ${env['DB_PORT'] ?? '5432'}');
  AppLogger.info('DB: ${env['DB'] ?? 'bitblik'}');
  AppLogger.info('DB_USER: ${env['DB_USER'] ?? 'postgres'}');
  AppLogger.info(
      'DB_PASSWORD: ${env['DB_PASSWORD']?.isNotEmpty == true ? "[SET]" : "[NOT SET]"}');
  AppLogger.info('LND_HOST: ${env['LND_HOST'] ?? 'localhost'}');
  AppLogger.info('LND_PORT: ${env['LND_PORT'] ?? '10009'}');
  AppLogger.info('LND_CERT_PATH: ${env['LND_CERT_PATH'] ?? 'tls.cert'}');
  AppLogger.info(
      'LND_MACAROON_PATH: ${env['LND_MACAROON_PATH'] ?? 'admin.macaroon'}');
  AppLogger.info(
      'SIMPLEX_GROUP: ${env['SIMPLEX_GROUP'] ?? 'Bitblik new offers'}');
  AppLogger.info(
      'NOSTR_PRIVATE_KEY: ${env['NOSTR_PRIVATE_KEY']?.isNotEmpty == true ? "[SET]" : "[NOT SET]"}');
  AppLogger.info(
      'NOSTR_RELAYS: ${env['NOSTR_RELAYS'] ?? 'wss://nos.lol,wss://relay.primal.net,wss://offchain.pub'}');
  AppLogger.info('====================');

  // --- Service Initialization ---
  final dbService = DatabaseService();
  AppLogger.initialize(auditSink: dbService.insertAuditLog);
  CoordinatorService? coordinatorService; // Nullable initially
  NostrService? nostrService; // Nullable initially
  MemoryProfiler? memoryProfiler;
  PrometheusExporter? prometheusExporter;

  try {
    // Connect to Database
    await dbService.connect();

    coordinatorService = CoordinatorService(dbService);
    // Initialize Nostr Service (replaces HTTP API)
    final relays = env['NOSTR_RELAYS']?.split(',') ??
        [
          'wss://relay.damus.io',
          'wss://nos.lol',
          'wss://relay.primal.net',
          'wss://offchain.pub'
        ];

    nostrService = NostrService(
      coordinatorService,
      relays: relays,
    );
    await coordinatorService.init();

    // FLOW_MODE generic records every offer transition in offer_state_history,
    // which supersedes the log_audit trail — so persist state history and stop
    // persisting log_audit in that mode.
    final generic = coordinatorService.isGenericFlow;
    dbService.recordStateHistory = generic;
    // AppLogger.setAuditPersistenceEnabled(!generic);
    // AppLogger.info(
    //     'Flow mode: ${generic ? 'generic (offer_state_history on, log_audit off)' : 'enum (log_audit on)'}',
    //     action: 'system.startup');

    await nostrService.init(privateKey: env['NOSTR_PRIVATE_KEY'] ?? '');

    // Set the Nostr service in the coordinator service for status updates
    coordinatorService.setNostrService(nostrService);

    memoryProfiler = MemoryProfiler(
      coordinatorService: coordinatorService,
      nostrService: nostrService,
      interval: Duration(
        seconds:
            int.tryParse(env['MEMORY_PROFILING_INTERVAL_SECONDS'] ?? '') ?? 30,
      ),
    );

    final memoryProfilingEnabled =
        (env['MEMORY_PROFILING'] ?? '').toLowerCase() == '1' ||
            (env['MEMORY_PROFILING'] ?? '').toLowerCase() == 'true';
    if (memoryProfilingEnabled) {
      memoryProfiler.start();
    }

    final metricsPort = int.tryParse(
      env['PROMETHEUS_PORT'] ?? env['METRICS_PORT'] ?? '',
    );
    if (metricsPort != null && metricsPort > 0) {
      final host = InternetAddress.tryParse(
            env['PROMETHEUS_HOST'] ?? env['METRICS_HOST'] ?? '',
          ) ??
          InternetAddress.anyIPv4;
      final scrapeCacheSeconds = int.tryParse(
            env['PROMETHEUS_SCRAPE_CACHE_SECONDS'] ??
                env['METRICS_SCRAPE_CACHE_SECONDS'] ??
                '',
          ) ??
          5;
      prometheusExporter = PrometheusExporter(
        memoryProfiler: memoryProfiler,
        host: host,
        port: metricsPort,
        scrapeCacheTtl: Duration(seconds: scrapeCacheSeconds),
      );
      await prometheusExporter.start();
    }

    await coordinatorService.doInitialCheckStatuses();

    // Rebroadcast offers from last hours if NostrService is available.
    // Runs unawaited: events are spaced a minute apart to stay under shared-IP
    // relay rate limits, so this can take a while and must not block startup.
    try {
      final offers = await dbService.getOffersFromLastHours();
      AppLogger.info(
          'Found ${offers.length} offers from last hours to rebroadcast');
      unawaited(nostrService.rebroadcastOffers(offers));
    } catch (e) {
      AppLogger.info('Error during rebroadcast of last hours offers: $e');
    }

    AppLogger.info(
        '✅ Coordinator running on Nostr with relays: ${nostrService.workingRelays} (env seed: $relays)');
    AppLogger.info(
        '✅ Coordinator pubkey: ${nostrService.coordinatorPubkey ?? 'Unknown'}');

    // --- Graceful Shutdown ---
    // Listen for termination signals
    ProcessSignal.sigint.watch().listen((signal) async {
      AppLogger.info('\nReceived SIGINT, shutting down...');
      await memoryProfiler?.emitManualSnapshot('sigint');
      await prometheusExporter?.stop();
      await memoryProfiler?.stop();
      await coordinatorService?.shutdown();
      await nostrService?.disconnect(); // Disconnect from Nostr
      await dbService.disconnect(); // Disconnect from DB
      AppLogger.info('Shutdown complete.');
      exit(0);
    });

    ProcessSignal.sigterm.watch().listen((signal) async {
      AppLogger.info('\nReceived SIGTERM, shutting down...');
      await memoryProfiler?.emitManualSnapshot('sigterm');
      await prometheusExporter?.stop();
      await memoryProfiler?.stop();
      await coordinatorService?.shutdown();
      await nostrService?.disconnect();
      await dbService.disconnect();
      AppLogger.info('Shutdown complete.');
      exit(0);
    });

    // Keep the process running
    await _keepAlive();
  } catch (e) {
    AppLogger.info('❌ Error during server startup: $e');
    // Attempt cleanup even on startup error
    await memoryProfiler?.stop();
    await prometheusExporter?.stop();
    await coordinatorService?.shutdown();
    await nostrService?.disconnect();
    await dbService.disconnect();
    exit(1);
  }
}

/// Keep the process alive by listening to stdin
Future<void> _keepAlive() async {
  AppLogger.info('Coordinator is running. Press Ctrl+C to stop.');

  // Listen to stdin to keep the process alive
  await for (final line in stdin
      .transform(const SystemEncoding().decoder)
      .transform(const LineSplitter())) {
    if (line.toLowerCase() == 'quit' || line.toLowerCase() == 'exit') {
      AppLogger.info('Shutting down...');
      exit(0);
    } else if (line.toLowerCase() == 'status') {
      AppLogger.info('Coordinator is running normally.');
    } else if (line.toLowerCase() == 'help') {
      AppLogger.info('Available commands:');
      AppLogger.info('  status - Show coordinator status');
      AppLogger.info('  quit/exit - Shutdown coordinator');
      AppLogger.info('  help - Show this help message');
    }
  }
}
