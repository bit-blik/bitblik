//
//  Generated code. Do not modify.
//  source: lnd/invoices.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'invoices.pbenum.dart';
import 'lightning.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'invoices.pbenum.dart';

class CancelInvoiceMsg extends $pb.GeneratedMessage {
  factory CancelInvoiceMsg({
    $core.List<$core.int>? paymentHash,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  CancelInvoiceMsg._() : super();
  factory CancelInvoiceMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoiceMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInvoiceMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoiceMsg clone() => CancelInvoiceMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoiceMsg copyWith(void Function(CancelInvoiceMsg) updates) => super.copyWith((message) => updates(message as CancelInvoiceMsg)) as CancelInvoiceMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInvoiceMsg create() => CancelInvoiceMsg._();
  CancelInvoiceMsg createEmptyInstance() => create();
  static $pb.PbList<CancelInvoiceMsg> createRepeated() => $pb.PbList<CancelInvoiceMsg>();
  @$core.pragma('dart2js:noInline')
  static CancelInvoiceMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInvoiceMsg>(create);
  static CancelInvoiceMsg? _defaultInstance;

  /// Hash corresponding to the (hold) invoice to cancel. When using
  /// REST, this field must be encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);
}

class CancelInvoiceResp extends $pb.GeneratedMessage {
  factory CancelInvoiceResp() => create();
  CancelInvoiceResp._() : super();
  factory CancelInvoiceResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CancelInvoiceResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CancelInvoiceResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CancelInvoiceResp clone() => CancelInvoiceResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CancelInvoiceResp copyWith(void Function(CancelInvoiceResp) updates) => super.copyWith((message) => updates(message as CancelInvoiceResp)) as CancelInvoiceResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CancelInvoiceResp create() => CancelInvoiceResp._();
  CancelInvoiceResp createEmptyInstance() => create();
  static $pb.PbList<CancelInvoiceResp> createRepeated() => $pb.PbList<CancelInvoiceResp>();
  @$core.pragma('dart2js:noInline')
  static CancelInvoiceResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CancelInvoiceResp>(create);
  static CancelInvoiceResp? _defaultInstance;
}

class AddHoldInvoiceRequest extends $pb.GeneratedMessage {
  factory AddHoldInvoiceRequest({
    $core.String? memo,
    $core.List<$core.int>? hash,
    $fixnum.Int64? value,
    $core.List<$core.int>? descriptionHash,
    $fixnum.Int64? expiry,
    $core.String? fallbackAddr,
    $fixnum.Int64? cltvExpiry,
    $core.Iterable<$1.RouteHint>? routeHints,
    $core.bool? private,
    $fixnum.Int64? valueMsat,
  }) {
    final $result = create();
    if (memo != null) {
      $result.memo = memo;
    }
    if (hash != null) {
      $result.hash = hash;
    }
    if (value != null) {
      $result.value = value;
    }
    if (descriptionHash != null) {
      $result.descriptionHash = descriptionHash;
    }
    if (expiry != null) {
      $result.expiry = expiry;
    }
    if (fallbackAddr != null) {
      $result.fallbackAddr = fallbackAddr;
    }
    if (cltvExpiry != null) {
      $result.cltvExpiry = cltvExpiry;
    }
    if (routeHints != null) {
      $result.routeHints.addAll(routeHints);
    }
    if (private != null) {
      $result.private = private;
    }
    if (valueMsat != null) {
      $result.valueMsat = valueMsat;
    }
    return $result;
  }
  AddHoldInvoiceRequest._() : super();
  factory AddHoldInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddHoldInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddHoldInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'memo')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'hash', $pb.PbFieldType.OY)
    ..aInt64(3, _omitFieldNames ? '' : 'value')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'descriptionHash', $pb.PbFieldType.OY)
    ..aInt64(5, _omitFieldNames ? '' : 'expiry')
    ..aOS(6, _omitFieldNames ? '' : 'fallbackAddr')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'cltvExpiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<$1.RouteHint>(8, _omitFieldNames ? '' : 'routeHints', $pb.PbFieldType.PM, subBuilder: $1.RouteHint.create)
    ..aOB(9, _omitFieldNames ? '' : 'private')
    ..aInt64(10, _omitFieldNames ? '' : 'valueMsat')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddHoldInvoiceRequest clone() => AddHoldInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddHoldInvoiceRequest copyWith(void Function(AddHoldInvoiceRequest) updates) => super.copyWith((message) => updates(message as AddHoldInvoiceRequest)) as AddHoldInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddHoldInvoiceRequest create() => AddHoldInvoiceRequest._();
  AddHoldInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<AddHoldInvoiceRequest> createRepeated() => $pb.PbList<AddHoldInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static AddHoldInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddHoldInvoiceRequest>(create);
  static AddHoldInvoiceRequest? _defaultInstance;

  ///
  /// An optional memo to attach along with the invoice. Used for record keeping
  /// purposes for the invoice's creator, and will also be set in the description
  /// field of the encoded payment request if the description_hash field is not
  /// being used.
  @$pb.TagNumber(1)
  $core.String get memo => $_getSZ(0);
  @$pb.TagNumber(1)
  set memo($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMemo() => $_has(0);
  @$pb.TagNumber(1)
  void clearMemo() => $_clearField(1);

  /// The hash of the preimage
  @$pb.TagNumber(2)
  $core.List<$core.int> get hash => $_getN(1);
  @$pb.TagNumber(2)
  set hash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearHash() => $_clearField(2);

  ///
  /// The value of this invoice in satoshis
  ///
  /// The fields value and value_msat are mutually exclusive.
  @$pb.TagNumber(3)
  $fixnum.Int64 get value => $_getI64(2);
  @$pb.TagNumber(3)
  set value($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasValue() => $_has(2);
  @$pb.TagNumber(3)
  void clearValue() => $_clearField(3);

  ///
  /// Hash (SHA-256) of a description of the payment. Used if the description of
  /// payment (memo) is too long to naturally fit within the description field
  /// of an encoded payment request.
  @$pb.TagNumber(4)
  $core.List<$core.int> get descriptionHash => $_getN(3);
  @$pb.TagNumber(4)
  set descriptionHash($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescriptionHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescriptionHash() => $_clearField(4);

  /// Payment request expiry time in seconds. Default is 86400 (24 hours).
  @$pb.TagNumber(5)
  $fixnum.Int64 get expiry => $_getI64(4);
  @$pb.TagNumber(5)
  set expiry($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiry() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiry() => $_clearField(5);

  /// Fallback on-chain address.
  @$pb.TagNumber(6)
  $core.String get fallbackAddr => $_getSZ(5);
  @$pb.TagNumber(6)
  set fallbackAddr($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFallbackAddr() => $_has(5);
  @$pb.TagNumber(6)
  void clearFallbackAddr() => $_clearField(6);

  /// Delta to use for the time-lock of the CLTV extended to the final hop.
  @$pb.TagNumber(7)
  $fixnum.Int64 get cltvExpiry => $_getI64(6);
  @$pb.TagNumber(7)
  set cltvExpiry($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCltvExpiry() => $_has(6);
  @$pb.TagNumber(7)
  void clearCltvExpiry() => $_clearField(7);

  ///
  /// Route hints that can each be individually used to assist in reaching the
  /// invoice's destination.
  @$pb.TagNumber(8)
  $pb.PbList<$1.RouteHint> get routeHints => $_getList(7);

  /// Whether this invoice should include routing hints for private channels.
  @$pb.TagNumber(9)
  $core.bool get private => $_getBF(8);
  @$pb.TagNumber(9)
  set private($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPrivate() => $_has(8);
  @$pb.TagNumber(9)
  void clearPrivate() => $_clearField(9);

  ///
  /// The value of this invoice in millisatoshis
  ///
  /// The fields value and value_msat are mutually exclusive.
  @$pb.TagNumber(10)
  $fixnum.Int64 get valueMsat => $_getI64(9);
  @$pb.TagNumber(10)
  set valueMsat($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasValueMsat() => $_has(9);
  @$pb.TagNumber(10)
  void clearValueMsat() => $_clearField(10);
}

class AddHoldInvoiceResp extends $pb.GeneratedMessage {
  factory AddHoldInvoiceResp({
    $core.String? paymentRequest,
    $fixnum.Int64? addIndex,
    $core.List<$core.int>? paymentAddr,
  }) {
    final $result = create();
    if (paymentRequest != null) {
      $result.paymentRequest = paymentRequest;
    }
    if (addIndex != null) {
      $result.addIndex = addIndex;
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    return $result;
  }
  AddHoldInvoiceResp._() : super();
  factory AddHoldInvoiceResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddHoldInvoiceResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddHoldInvoiceResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentRequest')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'addIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddHoldInvoiceResp clone() => AddHoldInvoiceResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddHoldInvoiceResp copyWith(void Function(AddHoldInvoiceResp) updates) => super.copyWith((message) => updates(message as AddHoldInvoiceResp)) as AddHoldInvoiceResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddHoldInvoiceResp create() => AddHoldInvoiceResp._();
  AddHoldInvoiceResp createEmptyInstance() => create();
  static $pb.PbList<AddHoldInvoiceResp> createRepeated() => $pb.PbList<AddHoldInvoiceResp>();
  @$core.pragma('dart2js:noInline')
  static AddHoldInvoiceResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddHoldInvoiceResp>(create);
  static AddHoldInvoiceResp? _defaultInstance;

  ///
  /// A bare-bones invoice for a payment within the Lightning Network. With the
  /// details of the invoice, the sender has all the data necessary to send a
  /// payment to the recipient.
  @$pb.TagNumber(1)
  $core.String get paymentRequest => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentRequest($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentRequest() => $_clearField(1);

  ///
  /// The "add" index of this invoice. Each newly created invoice will increment
  /// this index making it monotonically increasing. Callers to the
  /// SubscribeInvoices call can use this to instantly get notified of all added
  /// invoices with an add_index greater than this one.
  @$pb.TagNumber(2)
  $fixnum.Int64 get addIndex => $_getI64(1);
  @$pb.TagNumber(2)
  set addIndex($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddIndex() => $_clearField(2);

  ///
  /// The payment address of the generated invoice. This is also called
  /// the payment secret in specifications (e.g. BOLT 11). This value should
  /// be used in all payments for this invoice as we require it for end to end
  /// security.
  @$pb.TagNumber(3)
  $core.List<$core.int> get paymentAddr => $_getN(2);
  @$pb.TagNumber(3)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentAddr() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentAddr() => $_clearField(3);
}

class SettleInvoiceMsg extends $pb.GeneratedMessage {
  factory SettleInvoiceMsg({
    $core.List<$core.int>? preimage,
  }) {
    final $result = create();
    if (preimage != null) {
      $result.preimage = preimage;
    }
    return $result;
  }
  SettleInvoiceMsg._() : super();
  factory SettleInvoiceMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettleInvoiceMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SettleInvoiceMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettleInvoiceMsg clone() => SettleInvoiceMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettleInvoiceMsg copyWith(void Function(SettleInvoiceMsg) updates) => super.copyWith((message) => updates(message as SettleInvoiceMsg)) as SettleInvoiceMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SettleInvoiceMsg create() => SettleInvoiceMsg._();
  SettleInvoiceMsg createEmptyInstance() => create();
  static $pb.PbList<SettleInvoiceMsg> createRepeated() => $pb.PbList<SettleInvoiceMsg>();
  @$core.pragma('dart2js:noInline')
  static SettleInvoiceMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettleInvoiceMsg>(create);
  static SettleInvoiceMsg? _defaultInstance;

  /// Externally discovered pre-image that should be used to settle the hold
  /// invoice.
  @$pb.TagNumber(1)
  $core.List<$core.int> get preimage => $_getN(0);
  @$pb.TagNumber(1)
  set preimage($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPreimage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreimage() => $_clearField(1);
}

class SettleInvoiceResp extends $pb.GeneratedMessage {
  factory SettleInvoiceResp() => create();
  SettleInvoiceResp._() : super();
  factory SettleInvoiceResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettleInvoiceResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SettleInvoiceResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettleInvoiceResp clone() => SettleInvoiceResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettleInvoiceResp copyWith(void Function(SettleInvoiceResp) updates) => super.copyWith((message) => updates(message as SettleInvoiceResp)) as SettleInvoiceResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SettleInvoiceResp create() => SettleInvoiceResp._();
  SettleInvoiceResp createEmptyInstance() => create();
  static $pb.PbList<SettleInvoiceResp> createRepeated() => $pb.PbList<SettleInvoiceResp>();
  @$core.pragma('dart2js:noInline')
  static SettleInvoiceResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettleInvoiceResp>(create);
  static SettleInvoiceResp? _defaultInstance;
}

class SubscribeSingleInvoiceRequest extends $pb.GeneratedMessage {
  factory SubscribeSingleInvoiceRequest({
    $core.List<$core.int>? rHash,
  }) {
    final $result = create();
    if (rHash != null) {
      $result.rHash = rHash;
    }
    return $result;
  }
  SubscribeSingleInvoiceRequest._() : super();
  factory SubscribeSingleInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeSingleInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeSingleInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'rHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeSingleInvoiceRequest clone() => SubscribeSingleInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeSingleInvoiceRequest copyWith(void Function(SubscribeSingleInvoiceRequest) updates) => super.copyWith((message) => updates(message as SubscribeSingleInvoiceRequest)) as SubscribeSingleInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeSingleInvoiceRequest create() => SubscribeSingleInvoiceRequest._();
  SubscribeSingleInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeSingleInvoiceRequest> createRepeated() => $pb.PbList<SubscribeSingleInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeSingleInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeSingleInvoiceRequest>(create);
  static SubscribeSingleInvoiceRequest? _defaultInstance;

  /// Hash corresponding to the (hold) invoice to subscribe to. When using
  /// REST, this field must be encoded as base64url.
  @$pb.TagNumber(2)
  $core.List<$core.int> get rHash => $_getN(0);
  @$pb.TagNumber(2)
  set rHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasRHash() => $_has(0);
  @$pb.TagNumber(2)
  void clearRHash() => $_clearField(2);
}

enum LookupInvoiceMsg_InvoiceRef {
  paymentHash, 
  paymentAddr, 
  setId, 
  notSet
}

class LookupInvoiceMsg extends $pb.GeneratedMessage {
  factory LookupInvoiceMsg({
    $core.List<$core.int>? paymentHash,
    $core.List<$core.int>? paymentAddr,
    $core.List<$core.int>? setId,
    LookupModifier? lookupModifier,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    if (setId != null) {
      $result.setId = setId;
    }
    if (lookupModifier != null) {
      $result.lookupModifier = lookupModifier;
    }
    return $result;
  }
  LookupInvoiceMsg._() : super();
  factory LookupInvoiceMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupInvoiceMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, LookupInvoiceMsg_InvoiceRef> _LookupInvoiceMsg_InvoiceRefByTag = {
    1 : LookupInvoiceMsg_InvoiceRef.paymentHash,
    2 : LookupInvoiceMsg_InvoiceRef.paymentAddr,
    3 : LookupInvoiceMsg_InvoiceRef.setId,
    0 : LookupInvoiceMsg_InvoiceRef.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupInvoiceMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'setId', $pb.PbFieldType.OY)
    ..e<LookupModifier>(4, _omitFieldNames ? '' : 'lookupModifier', $pb.PbFieldType.OE, defaultOrMaker: LookupModifier.DEFAULT, valueOf: LookupModifier.valueOf, enumValues: LookupModifier.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupInvoiceMsg clone() => LookupInvoiceMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupInvoiceMsg copyWith(void Function(LookupInvoiceMsg) updates) => super.copyWith((message) => updates(message as LookupInvoiceMsg)) as LookupInvoiceMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupInvoiceMsg create() => LookupInvoiceMsg._();
  LookupInvoiceMsg createEmptyInstance() => create();
  static $pb.PbList<LookupInvoiceMsg> createRepeated() => $pb.PbList<LookupInvoiceMsg>();
  @$core.pragma('dart2js:noInline')
  static LookupInvoiceMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupInvoiceMsg>(create);
  static LookupInvoiceMsg? _defaultInstance;

  LookupInvoiceMsg_InvoiceRef whichInvoiceRef() => _LookupInvoiceMsg_InvoiceRefByTag[$_whichOneof(0)]!;
  void clearInvoiceRef() => $_clearField($_whichOneof(0));

  /// When using REST, this field must be encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get paymentAddr => $_getN(1);
  @$pb.TagNumber(2)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentAddr() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentAddr() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get setId => $_getN(2);
  @$pb.TagNumber(3)
  set setId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSetId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSetId() => $_clearField(3);

  @$pb.TagNumber(4)
  LookupModifier get lookupModifier => $_getN(3);
  @$pb.TagNumber(4)
  set lookupModifier(LookupModifier v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasLookupModifier() => $_has(3);
  @$pb.TagNumber(4)
  void clearLookupModifier() => $_clearField(4);
}

/// CircuitKey is a unique identifier for an HTLC.
class CircuitKey extends $pb.GeneratedMessage {
  factory CircuitKey({
    $fixnum.Int64? chanId,
    $fixnum.Int64? htlcId,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (htlcId != null) {
      $result.htlcId = htlcId;
    }
    return $result;
  }
  CircuitKey._() : super();
  factory CircuitKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CircuitKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CircuitKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'htlcId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CircuitKey clone() => CircuitKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CircuitKey copyWith(void Function(CircuitKey) updates) => super.copyWith((message) => updates(message as CircuitKey)) as CircuitKey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CircuitKey create() => CircuitKey._();
  CircuitKey createEmptyInstance() => create();
  static $pb.PbList<CircuitKey> createRepeated() => $pb.PbList<CircuitKey>();
  @$core.pragma('dart2js:noInline')
  static CircuitKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CircuitKey>(create);
  static CircuitKey? _defaultInstance;

  /// The id of the channel that the is part of this circuit.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  /// The index of the incoming htlc in the incoming channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get htlcId => $_getI64(1);
  @$pb.TagNumber(2)
  set htlcId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHtlcId() => $_has(1);
  @$pb.TagNumber(2)
  void clearHtlcId() => $_clearField(2);
}

class HtlcModifyRequest extends $pb.GeneratedMessage {
  factory HtlcModifyRequest({
    $1.Invoice? invoice,
    CircuitKey? exitHtlcCircuitKey,
    $fixnum.Int64? exitHtlcAmt,
    $core.int? exitHtlcExpiry,
    $core.int? currentHeight,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? exitHtlcWireCustomRecords,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (exitHtlcCircuitKey != null) {
      $result.exitHtlcCircuitKey = exitHtlcCircuitKey;
    }
    if (exitHtlcAmt != null) {
      $result.exitHtlcAmt = exitHtlcAmt;
    }
    if (exitHtlcExpiry != null) {
      $result.exitHtlcExpiry = exitHtlcExpiry;
    }
    if (currentHeight != null) {
      $result.currentHeight = currentHeight;
    }
    if (exitHtlcWireCustomRecords != null) {
      $result.exitHtlcWireCustomRecords.addAll(exitHtlcWireCustomRecords);
    }
    return $result;
  }
  HtlcModifyRequest._() : super();
  factory HtlcModifyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HtlcModifyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HtlcModifyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..aOM<$1.Invoice>(1, _omitFieldNames ? '' : 'invoice', subBuilder: $1.Invoice.create)
    ..aOM<CircuitKey>(2, _omitFieldNames ? '' : 'exitHtlcCircuitKey', subBuilder: CircuitKey.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'exitHtlcAmt', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'exitHtlcExpiry', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'currentHeight', $pb.PbFieldType.OU3)
    ..m<$fixnum.Int64, $core.List<$core.int>>(6, _omitFieldNames ? '' : 'exitHtlcWireCustomRecords', entryClassName: 'HtlcModifyRequest.ExitHtlcWireCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('invoicesrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HtlcModifyRequest clone() => HtlcModifyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HtlcModifyRequest copyWith(void Function(HtlcModifyRequest) updates) => super.copyWith((message) => updates(message as HtlcModifyRequest)) as HtlcModifyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HtlcModifyRequest create() => HtlcModifyRequest._();
  HtlcModifyRequest createEmptyInstance() => create();
  static $pb.PbList<HtlcModifyRequest> createRepeated() => $pb.PbList<HtlcModifyRequest>();
  @$core.pragma('dart2js:noInline')
  static HtlcModifyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HtlcModifyRequest>(create);
  static HtlcModifyRequest? _defaultInstance;

  /// The invoice the intercepted HTLC is attempting to settle. The HTLCs in
  /// the invoice are only HTLCs that have already been accepted or settled,
  /// not including the current intercepted HTLC.
  @$pb.TagNumber(1)
  $1.Invoice get invoice => $_getN(0);
  @$pb.TagNumber(1)
  set invoice($1.Invoice v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Invoice ensureInvoice() => $_ensure(0);

  /// The unique identifier of the HTLC of this intercepted HTLC.
  @$pb.TagNumber(2)
  CircuitKey get exitHtlcCircuitKey => $_getN(1);
  @$pb.TagNumber(2)
  set exitHtlcCircuitKey(CircuitKey v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasExitHtlcCircuitKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearExitHtlcCircuitKey() => $_clearField(2);
  @$pb.TagNumber(2)
  CircuitKey ensureExitHtlcCircuitKey() => $_ensure(1);

  /// The amount in milli-satoshi that the exit HTLC is attempting to pay.
  @$pb.TagNumber(3)
  $fixnum.Int64 get exitHtlcAmt => $_getI64(2);
  @$pb.TagNumber(3)
  set exitHtlcAmt($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExitHtlcAmt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExitHtlcAmt() => $_clearField(3);

  /// The absolute expiry height of the exit HTLC.
  @$pb.TagNumber(4)
  $core.int get exitHtlcExpiry => $_getIZ(3);
  @$pb.TagNumber(4)
  set exitHtlcExpiry($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExitHtlcExpiry() => $_has(3);
  @$pb.TagNumber(4)
  void clearExitHtlcExpiry() => $_clearField(4);

  /// The current block height.
  @$pb.TagNumber(5)
  $core.int get currentHeight => $_getIZ(4);
  @$pb.TagNumber(5)
  set currentHeight($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCurrentHeight() => $_has(4);
  @$pb.TagNumber(5)
  void clearCurrentHeight() => $_clearField(5);

  /// The wire message custom records of the exit HTLC.
  @$pb.TagNumber(6)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get exitHtlcWireCustomRecords => $_getMap(5);
}

class HtlcModifyResponse extends $pb.GeneratedMessage {
  factory HtlcModifyResponse({
    CircuitKey? circuitKey,
    $fixnum.Int64? amtPaid,
    $core.bool? cancelSet,
  }) {
    final $result = create();
    if (circuitKey != null) {
      $result.circuitKey = circuitKey;
    }
    if (amtPaid != null) {
      $result.amtPaid = amtPaid;
    }
    if (cancelSet != null) {
      $result.cancelSet = cancelSet;
    }
    return $result;
  }
  HtlcModifyResponse._() : super();
  factory HtlcModifyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HtlcModifyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HtlcModifyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'invoicesrpc'), createEmptyInstance: create)
    ..aOM<CircuitKey>(1, _omitFieldNames ? '' : 'circuitKey', subBuilder: CircuitKey.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amtPaid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(3, _omitFieldNames ? '' : 'cancelSet')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HtlcModifyResponse clone() => HtlcModifyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HtlcModifyResponse copyWith(void Function(HtlcModifyResponse) updates) => super.copyWith((message) => updates(message as HtlcModifyResponse)) as HtlcModifyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HtlcModifyResponse create() => HtlcModifyResponse._();
  HtlcModifyResponse createEmptyInstance() => create();
  static $pb.PbList<HtlcModifyResponse> createRepeated() => $pb.PbList<HtlcModifyResponse>();
  @$core.pragma('dart2js:noInline')
  static HtlcModifyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HtlcModifyResponse>(create);
  static HtlcModifyResponse? _defaultInstance;

  /// The circuit key of the HTLC that the client wants to modify.
  @$pb.TagNumber(1)
  CircuitKey get circuitKey => $_getN(0);
  @$pb.TagNumber(1)
  set circuitKey(CircuitKey v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCircuitKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearCircuitKey() => $_clearField(1);
  @$pb.TagNumber(1)
  CircuitKey ensureCircuitKey() => $_ensure(0);

  /// The modified amount in milli-satoshi that the exit HTLC is paying. This
  /// value can be different from the actual on-chain HTLC amount, in case the
  /// HTLC carries other valuable items, as can be the case with custom channel
  /// types.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amtPaid => $_getI64(1);
  @$pb.TagNumber(2)
  set amtPaid($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmtPaid() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmtPaid() => $_clearField(2);

  /// This flag indicates whether the HTLCs associated with the invoices should
  /// be cancelled. The interceptor client may set this field if some
  /// unexpected behavior is encountered. Setting this will ignore the amt_paid
  /// field.
  @$pb.TagNumber(3)
  $core.bool get cancelSet => $_getBF(2);
  @$pb.TagNumber(3)
  set cancelSet($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCancelSet() => $_has(2);
  @$pb.TagNumber(3)
  void clearCancelSet() => $_clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
