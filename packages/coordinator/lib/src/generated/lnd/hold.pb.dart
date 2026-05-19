//
//  Generated code. Do not modify.
//  source: lnd/hold.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'hold.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'hold.pbenum.dart';

class Amount extends $pb.GeneratedMessage {
  factory Amount({
    $fixnum.Int64? msat,
  }) {
    final $result = create();
    if (msat != null) {
      $result.msat = msat;
    }
    return $result;
  }
  Amount._() : super();
  factory Amount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Amount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Amount', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'msat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Amount clone() => Amount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Amount copyWith(void Function(Amount) updates) => super.copyWith((message) => updates(message as Amount)) as Amount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Amount create() => Amount._();
  Amount createEmptyInstance() => create();
  static $pb.PbList<Amount> createRepeated() => $pb.PbList<Amount>();
  @$core.pragma('dart2js:noInline')
  static Amount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Amount>(create);
  static Amount? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get msat => $_getI64(0);
  @$pb.TagNumber(1)
  set msat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsat() => $_clearField(1);
}

class HoldInvoiceRequest extends $pb.GeneratedMessage {
  factory HoldInvoiceRequest({
    $core.String? description,
    $core.String? label,
    $core.Iterable<$core.String>? fallbacks,
    $core.List<$core.int>? preimage,
    $core.int? cltv,
    $fixnum.Int64? expiry,
    $core.Iterable<$core.String>? exposeprivatechannels,
    $core.bool? deschashonly,
    Amount? amountMsat,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (label != null) {
      $result.label = label;
    }
    if (fallbacks != null) {
      $result.fallbacks.addAll(fallbacks);
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (cltv != null) {
      $result.cltv = cltv;
    }
    if (expiry != null) {
      $result.expiry = expiry;
    }
    if (exposeprivatechannels != null) {
      $result.exposeprivatechannels.addAll(exposeprivatechannels);
    }
    if (deschashonly != null) {
      $result.deschashonly = deschashonly;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    return $result;
  }
  HoldInvoiceRequest._() : super();
  factory HoldInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'label')
    ..pPS(4, _omitFieldNames ? '' : 'fallbacks')
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'cltv', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'expiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(8, _omitFieldNames ? '' : 'exposeprivatechannels')
    ..aOB(9, _omitFieldNames ? '' : 'deschashonly')
    ..aOM<Amount>(10, _omitFieldNames ? '' : 'amountMsat', subBuilder: Amount.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceRequest clone() => HoldInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceRequest copyWith(void Function(HoldInvoiceRequest) updates) => super.copyWith((message) => updates(message as HoldInvoiceRequest)) as HoldInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceRequest create() => HoldInvoiceRequest._();
  HoldInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceRequest> createRepeated() => $pb.PbList<HoldInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceRequest>(create);
  static HoldInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(3)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(3)
  void clearLabel() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get fallbacks => $_getList(2);

  @$pb.TagNumber(5)
  $core.List<$core.int> get preimage => $_getN(3);
  @$pb.TagNumber(5)
  set preimage($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasPreimage() => $_has(3);
  @$pb.TagNumber(5)
  void clearPreimage() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get cltv => $_getIZ(4);
  @$pb.TagNumber(6)
  set cltv($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasCltv() => $_has(4);
  @$pb.TagNumber(6)
  void clearCltv() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get expiry => $_getI64(5);
  @$pb.TagNumber(7)
  set expiry($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpiry() => $_has(5);
  @$pb.TagNumber(7)
  void clearExpiry() => $_clearField(7);

  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get exposeprivatechannels => $_getList(6);

  @$pb.TagNumber(9)
  $core.bool get deschashonly => $_getBF(7);
  @$pb.TagNumber(9)
  set deschashonly($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasDeschashonly() => $_has(7);
  @$pb.TagNumber(9)
  void clearDeschashonly() => $_clearField(9);

  @$pb.TagNumber(10)
  Amount get amountMsat => $_getN(8);
  @$pb.TagNumber(10)
  set amountMsat(Amount v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasAmountMsat() => $_has(8);
  @$pb.TagNumber(10)
  void clearAmountMsat() => $_clearField(10);
  @$pb.TagNumber(10)
  Amount ensureAmountMsat() => $_ensure(8);
}

class HoldInvoiceResponse extends $pb.GeneratedMessage {
  factory HoldInvoiceResponse({
    $core.String? bolt11,
    $core.List<$core.int>? paymentHash,
    $core.List<$core.int>? paymentSecret,
    $fixnum.Int64? expiresAt,
    $core.String? warningCapacity,
    $core.String? warningOffline,
    $core.String? warningDeadends,
    $core.String? warningPrivateUnused,
    $core.String? warningMpp,
    $fixnum.Int64? createdIndex,
  }) {
    final $result = create();
    if (bolt11 != null) {
      $result.bolt11 = bolt11;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentSecret != null) {
      $result.paymentSecret = paymentSecret;
    }
    if (expiresAt != null) {
      $result.expiresAt = expiresAt;
    }
    if (warningCapacity != null) {
      $result.warningCapacity = warningCapacity;
    }
    if (warningOffline != null) {
      $result.warningOffline = warningOffline;
    }
    if (warningDeadends != null) {
      $result.warningDeadends = warningDeadends;
    }
    if (warningPrivateUnused != null) {
      $result.warningPrivateUnused = warningPrivateUnused;
    }
    if (warningMpp != null) {
      $result.warningMpp = warningMpp;
    }
    if (createdIndex != null) {
      $result.createdIndex = createdIndex;
    }
    return $result;
  }
  HoldInvoiceResponse._() : super();
  factory HoldInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'bolt11')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'paymentSecret', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'expiresAt', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'warningCapacity')
    ..aOS(6, _omitFieldNames ? '' : 'warningOffline')
    ..aOS(7, _omitFieldNames ? '' : 'warningDeadends')
    ..aOS(8, _omitFieldNames ? '' : 'warningPrivateUnused')
    ..aOS(9, _omitFieldNames ? '' : 'warningMpp')
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'createdIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceResponse clone() => HoldInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceResponse copyWith(void Function(HoldInvoiceResponse) updates) => super.copyWith((message) => updates(message as HoldInvoiceResponse)) as HoldInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceResponse create() => HoldInvoiceResponse._();
  HoldInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceResponse> createRepeated() => $pb.PbList<HoldInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceResponse>(create);
  static HoldInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get bolt11 => $_getSZ(0);
  @$pb.TagNumber(1)
  set bolt11($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBolt11() => $_has(0);
  @$pb.TagNumber(1)
  void clearBolt11() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get paymentHash => $_getN(1);
  @$pb.TagNumber(2)
  set paymentHash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get paymentSecret => $_getN(2);
  @$pb.TagNumber(3)
  set paymentSecret($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentSecret() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get expiresAt => $_getI64(3);
  @$pb.TagNumber(4)
  set expiresAt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiresAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiresAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get warningCapacity => $_getSZ(4);
  @$pb.TagNumber(5)
  set warningCapacity($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasWarningCapacity() => $_has(4);
  @$pb.TagNumber(5)
  void clearWarningCapacity() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get warningOffline => $_getSZ(5);
  @$pb.TagNumber(6)
  set warningOffline($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasWarningOffline() => $_has(5);
  @$pb.TagNumber(6)
  void clearWarningOffline() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get warningDeadends => $_getSZ(6);
  @$pb.TagNumber(7)
  set warningDeadends($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWarningDeadends() => $_has(6);
  @$pb.TagNumber(7)
  void clearWarningDeadends() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get warningPrivateUnused => $_getSZ(7);
  @$pb.TagNumber(8)
  set warningPrivateUnused($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasWarningPrivateUnused() => $_has(7);
  @$pb.TagNumber(8)
  void clearWarningPrivateUnused() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get warningMpp => $_getSZ(8);
  @$pb.TagNumber(9)
  set warningMpp($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasWarningMpp() => $_has(8);
  @$pb.TagNumber(9)
  void clearWarningMpp() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get createdIndex => $_getI64(9);
  @$pb.TagNumber(10)
  set createdIndex($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedIndex() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedIndex() => $_clearField(10);
}

class HoldInvoiceSettleRequest extends $pb.GeneratedMessage {
  factory HoldInvoiceSettleRequest({
    $core.List<$core.int>? paymentHash,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  HoldInvoiceSettleRequest._() : super();
  factory HoldInvoiceSettleRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceSettleRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceSettleRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceSettleRequest clone() => HoldInvoiceSettleRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceSettleRequest copyWith(void Function(HoldInvoiceSettleRequest) updates) => super.copyWith((message) => updates(message as HoldInvoiceSettleRequest)) as HoldInvoiceSettleRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceSettleRequest create() => HoldInvoiceSettleRequest._();
  HoldInvoiceSettleRequest createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceSettleRequest> createRepeated() => $pb.PbList<HoldInvoiceSettleRequest>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceSettleRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceSettleRequest>(create);
  static HoldInvoiceSettleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);
}

class HoldInvoiceSettleResponse extends $pb.GeneratedMessage {
  factory HoldInvoiceSettleResponse({
    Holdstate? state,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  HoldInvoiceSettleResponse._() : super();
  factory HoldInvoiceSettleResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceSettleResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceSettleResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..e<Holdstate>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: Holdstate.OPEN, valueOf: Holdstate.valueOf, enumValues: Holdstate.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceSettleResponse clone() => HoldInvoiceSettleResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceSettleResponse copyWith(void Function(HoldInvoiceSettleResponse) updates) => super.copyWith((message) => updates(message as HoldInvoiceSettleResponse)) as HoldInvoiceSettleResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceSettleResponse create() => HoldInvoiceSettleResponse._();
  HoldInvoiceSettleResponse createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceSettleResponse> createRepeated() => $pb.PbList<HoldInvoiceSettleResponse>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceSettleResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceSettleResponse>(create);
  static HoldInvoiceSettleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Holdstate get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(Holdstate v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
}

class HoldInvoiceCancelRequest extends $pb.GeneratedMessage {
  factory HoldInvoiceCancelRequest({
    $core.List<$core.int>? paymentHash,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  HoldInvoiceCancelRequest._() : super();
  factory HoldInvoiceCancelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceCancelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceCancelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceCancelRequest clone() => HoldInvoiceCancelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceCancelRequest copyWith(void Function(HoldInvoiceCancelRequest) updates) => super.copyWith((message) => updates(message as HoldInvoiceCancelRequest)) as HoldInvoiceCancelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceCancelRequest create() => HoldInvoiceCancelRequest._();
  HoldInvoiceCancelRequest createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceCancelRequest> createRepeated() => $pb.PbList<HoldInvoiceCancelRequest>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceCancelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceCancelRequest>(create);
  static HoldInvoiceCancelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);
}

class HoldInvoiceCancelResponse extends $pb.GeneratedMessage {
  factory HoldInvoiceCancelResponse({
    Holdstate? state,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    return $result;
  }
  HoldInvoiceCancelResponse._() : super();
  factory HoldInvoiceCancelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceCancelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceCancelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..e<Holdstate>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: Holdstate.OPEN, valueOf: Holdstate.valueOf, enumValues: Holdstate.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceCancelResponse clone() => HoldInvoiceCancelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceCancelResponse copyWith(void Function(HoldInvoiceCancelResponse) updates) => super.copyWith((message) => updates(message as HoldInvoiceCancelResponse)) as HoldInvoiceCancelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceCancelResponse create() => HoldInvoiceCancelResponse._();
  HoldInvoiceCancelResponse createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceCancelResponse> createRepeated() => $pb.PbList<HoldInvoiceCancelResponse>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceCancelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceCancelResponse>(create);
  static HoldInvoiceCancelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Holdstate get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(Holdstate v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);
}

class HoldInvoiceLookupRequest extends $pb.GeneratedMessage {
  factory HoldInvoiceLookupRequest({
    $core.List<$core.int>? paymentHash,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  HoldInvoiceLookupRequest._() : super();
  factory HoldInvoiceLookupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceLookupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceLookupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceLookupRequest clone() => HoldInvoiceLookupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceLookupRequest copyWith(void Function(HoldInvoiceLookupRequest) updates) => super.copyWith((message) => updates(message as HoldInvoiceLookupRequest)) as HoldInvoiceLookupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceLookupRequest create() => HoldInvoiceLookupRequest._();
  HoldInvoiceLookupRequest createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceLookupRequest> createRepeated() => $pb.PbList<HoldInvoiceLookupRequest>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceLookupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceLookupRequest>(create);
  static HoldInvoiceLookupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);
}

class HoldInvoiceLookupResponse extends $pb.GeneratedMessage {
  factory HoldInvoiceLookupResponse({
    Holdstate? state,
    $core.int? htlcExpiry,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    if (htlcExpiry != null) {
      $result.htlcExpiry = htlcExpiry;
    }
    return $result;
  }
  HoldInvoiceLookupResponse._() : super();
  factory HoldInvoiceLookupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HoldInvoiceLookupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HoldInvoiceLookupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'hold'), createEmptyInstance: create)
    ..e<Holdstate>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: Holdstate.OPEN, valueOf: Holdstate.valueOf, enumValues: Holdstate.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'htlcExpiry', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HoldInvoiceLookupResponse clone() => HoldInvoiceLookupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HoldInvoiceLookupResponse copyWith(void Function(HoldInvoiceLookupResponse) updates) => super.copyWith((message) => updates(message as HoldInvoiceLookupResponse)) as HoldInvoiceLookupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HoldInvoiceLookupResponse create() => HoldInvoiceLookupResponse._();
  HoldInvoiceLookupResponse createEmptyInstance() => create();
  static $pb.PbList<HoldInvoiceLookupResponse> createRepeated() => $pb.PbList<HoldInvoiceLookupResponse>();
  @$core.pragma('dart2js:noInline')
  static HoldInvoiceLookupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HoldInvoiceLookupResponse>(create);
  static HoldInvoiceLookupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Holdstate get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(Holdstate v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get htlcExpiry => $_getIZ(1);
  @$pb.TagNumber(2)
  set htlcExpiry($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHtlcExpiry() => $_has(1);
  @$pb.TagNumber(2)
  void clearHtlcExpiry() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
