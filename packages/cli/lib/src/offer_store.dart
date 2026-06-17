import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:sembast/sembast_io.dart';

import 'cli_context.dart';

class OfferStore {
  final Database _db;
  final _store = StoreRef<String, Map<String, Object?>>.main();

  OfferStore._(this._db);

  /// Opens the per-market offer database. The directory is keyed by the payment
  /// system's brand (e.g. `bitblik` for BLIK, `bitway` for MB WAY) so markets
  /// never share offers. Defaults to [activePaymentSystem].
  static Future<OfferStore> open({PaymentSystem? paymentSystem}) async {
    final ps = paymentSystem ?? activePaymentSystem;
    final home = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        '.';
    final dir = Directory('$home/.config/${ps.brandName.toLowerCase()}');
    if (!dir.existsSync()) dir.createSync(recursive: true);
    final db = await databaseFactoryIo.openDatabase('${dir.path}/offers.db');
    return OfferStore._(db);
  }

  Future<void> upsert(Offer offer) =>
      _store.record(offer.holdInvoicePaymentHash!).put(_db, _toRecord(offer));

  Future<void> delete(String paymentHash) =>
      _store.record(paymentHash).delete(_db);

  Future<Offer?> get(String paymentHash) async {
    final r = await _store.record(paymentHash).get(_db);
    return r == null ? null : Offer.fromJson(Map<String, dynamic>.from(r));
  }

  Future<List<Offer>> all({OfferStatus? status}) async {
    final finder = status == null
        ? null
        : Finder(filter: Filter.equals('status', status.name));
    final records = await _store.find(_db, finder: finder);
    return records
        .map((r) => Offer.fromJson(Map<String, dynamic>.from(r.value)))
        .toList();
  }

  Future<void> close() => _db.close();

  static Map<String, Object?> _toRecord(Offer o) {
    final json = o.toJson();
    return json.map((k, v) => MapEntry(k, v as Object?));
  }
}
