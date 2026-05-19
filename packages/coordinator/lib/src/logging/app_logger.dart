import 'dart:async';
import 'dart:io';

import 'package:logging/logging.dart';

class AuditLogContext {
  const AuditLogContext({
    required this.action,
    this.offerId,
    this.metadata,
  });

  final String action;
  final String? offerId;
  final Map<String, dynamic>? metadata;
}

class AuditLogEntry {
  const AuditLogEntry({
    required this.message,
    required this.context,
  });

  final String message;
  final AuditLogContext context;

  @override
  String toString() => message;
}

class AppLogger {
  AppLogger._();

  static final RegExp _uuidLikePattern = RegExp(
    r'\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b',
  );

  static bool _initialized = false;
  static bool _isPersisting = false;
  static Future<void> Function({
    required String level,
    required String loggerName,
    required String message,
    required String action,
    String? offerId,
    String? error,
    String? stackTrace,
    Map<String, dynamic>? metadata,
  })? _auditSink;

  static void initialize({
    Future<void> Function({
      required String level,
      required String loggerName,
      required String message,
      required String action,
      String? offerId,
      String? error,
      String? stackTrace,
      Map<String, dynamic>? metadata,
    })? auditSink,
  }) {
    if (auditSink != null) {
      _auditSink = auditSink;
    }
    if (_initialized) {
      return;
    }

    _initialized = true;
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) async {
      _writeToStdout(record);
      await _persist(record);
    });
  }

  static Logger scoped(String name) => Logger(name);

  static void fine(
    String message, {
    String action = 'system.event',
    String? offerId,
    Map<String, dynamic>? metadata,
  }) {
    Logger.root.log(
      Level.FINE,
      AuditLogEntry(
        message: message,
        context: AuditLogContext(
          action: action,
          offerId: offerId,
          metadata: metadata,
        ),
      ),
    );
  }

  static void info(
    String message, {
    String action = 'system.event',
    String? offerId,
    Map<String, dynamic>? metadata,
  }) {
    final normalized = message.toLowerCase();
    final level = normalized.contains('error') ||
            normalized.contains('exception') ||
            normalized.contains('failed') ||
            normalized.contains('critical')
        ? Level.SEVERE
        : normalized.contains('warning')
            ? Level.WARNING
            : Level.INFO;
    Logger.root.log(
      level,
      AuditLogEntry(
        message: message,
        context: AuditLogContext(
          action: action,
          offerId: offerId,
          metadata: metadata,
        ),
      ),
    );
  }

  static void warning(
    String message, {
    String action = 'system.warning',
    String? offerId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    Logger.root.log(
      Level.WARNING,
      AuditLogEntry(
        message: message,
        context: AuditLogContext(
          action: action,
          offerId: offerId,
          metadata: metadata,
        ),
      ),
      error,
      stackTrace,
    );
  }

  static void severe(
    String message, {
    String action = 'system.error',
    String? offerId,
    Object? error,
    StackTrace? stackTrace,
    Map<String, dynamic>? metadata,
  }) {
    Logger.root.log(
      Level.SEVERE,
      AuditLogEntry(
        message: message,
        context: AuditLogContext(
          action: action,
          offerId: offerId,
          metadata: metadata,
        ),
      ),
      error,
      stackTrace,
    );
  }

  static String inferActionFromMessage(String message) {
    final normalized = message.toLowerCase();
    if (normalized.contains('status updated') ||
        normalized.contains('status:')) {
      return 'offer.status_change';
    }
    if (normalized.contains('maker ')) {
      return 'maker.action';
    }
    if (normalized.contains('taker ')) {
      return 'taker.action';
    }
    if (normalized.contains('timer') ||
        normalized.contains('timeout') ||
        normalized.contains('expired')) {
      return 'timer.action';
    }
    return 'system.event';
  }

  static String? inferOfferIdFromMessage(String message) {
    // Only infer IDs that look like UUIDs to avoid false positives such as
    // "offer check complete" being interpreted as offer_id="check".
    final match = _uuidLikePattern.firstMatch(message);
    return match?.group(0);
  }

  static String? normalizeOfferId(String? candidate) {
    if (candidate == null) {
      return null;
    }
    final trimmed = candidate.trim();
    if (trimmed.isEmpty) {
      return null;
    }
    return _uuidLikePattern.hasMatch(trimmed) ? trimmed : null;
  }

  static void _writeToStdout(LogRecord record) {
    final level = record.level.name.padRight(7);
    final loggerName = record.loggerName.isEmpty ? 'root' : record.loggerName;
    final time = record.time.toIso8601String();
    stdout.writeln('[$time] [$level] [$loggerName] ${record.message}');
    if (record.error != null) {
      stdout.writeln('  error: ${record.error}');
    }
    if (record.stackTrace != null) {
      stdout.writeln('  stackTrace: ${record.stackTrace}');
    }
  }

  static Future<void> _persist(LogRecord record) async {
    if (_isPersisting || _auditSink == null) {
      return;
    }

    final object = record.object;
    final context = object is AuditLogEntry ? object.context : null;
    final message = record.message;
    final offerId =
        normalizeOfferId(context?.offerId) ?? inferOfferIdFromMessage(message);
    final contextAction = context?.action;
    final action = contextAction == null || contextAction == 'system.event'
        ? inferActionFromMessage(message)
        : contextAction;

    try {
      _isPersisting = true;
      await _auditSink!(
        level: record.level.name,
        loggerName: record.loggerName,
        message: message,
        action: action,
        offerId: offerId,
        error: record.error?.toString(),
        stackTrace: record.stackTrace?.toString(),
        metadata: context?.metadata,
      );
    } catch (_) {
      // Never break main flow because of audit logging persistence failures.
    } finally {
      _isPersisting = false;
    }
  }
}
