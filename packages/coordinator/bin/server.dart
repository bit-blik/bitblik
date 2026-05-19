import 'dart:convert';
import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/lnd_service.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/nostr_service.dart';
import 'package:bitblik_coordinator/src/logging/app_logger.dart';

Future<void> main(List<String> args) async {
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
  final lndService = LndService();
  CoordinatorService? coordinatorService; // Nullable initially
  NostrService? nostrService; // Nullable initially

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

    await nostrService.init(privateKey: env['NOSTR_PRIVATE_KEY'] ?? '');

    // Set the Nostr service in the coordinator service for status updates
    coordinatorService.setNostrService(nostrService);

    await coordinatorService.doInitialCheckStatuses();

    // Rebroadcast offers from last hours if NostrService is available
    try {
      final offers = await dbService.getOffersFromLastHours();
      AppLogger.info(
          'Found ${offers.length} offers from last 24 hours to rebroadcast');
      await nostrService.rebroadcastOffers(offers);
    } catch (e) {
      AppLogger.info('Error during rebroadcast of last 24 hours offers: $e');
    }

    AppLogger.info('✅ Coordinator running on Nostr with relays: $relays');
    AppLogger.info(
        '✅ Coordinator pubkey: ${nostrService.coordinatorPubkey ?? 'Unknown'}');

    // --- Graceful Shutdown ---
    // Listen for termination signals
    ProcessSignal.sigint.watch().listen((signal) async {
      AppLogger.info('\nReceived SIGINT, shutting down...');
      await nostrService?.disconnect(); // Disconnect from Nostr
      await lndService.disconnect(); // Disconnect from LND
      await dbService.disconnect(); // Disconnect from DB
      AppLogger.info('Shutdown complete.');
      exit(0);
    });

    ProcessSignal.sigterm.watch().listen((signal) async {
      AppLogger.info('\nReceived SIGTERM, shutting down...');
      await nostrService?.disconnect();
      await lndService.disconnect();
      await dbService.disconnect();
      AppLogger.info('Shutdown complete.');
      exit(0);
    });

    // Keep the process running
    await _keepAlive();
  } catch (e) {
    AppLogger.info('❌ Error during server startup: $e');
    // Attempt cleanup even on startup error
    await nostrService?.disconnect();
    await lndService.disconnect();
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
