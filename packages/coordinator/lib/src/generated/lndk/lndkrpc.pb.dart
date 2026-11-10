//
//  Generated code. Do not modify.
//  source: lndkrpc.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'lndkrpc.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'lndkrpc.pbenum.dart';

class PayOfferRequest extends $pb.GeneratedMessage {
  factory PayOfferRequest({
    $core.String? offer,
    $fixnum.Int64? amount,
    $core.String? payerNote,
    $core.int? responseInvoiceTimeout,
    $core.int? feeLimit,
    $core.int? feeLimitPercent,
  }) {
    final $result = create();
    if (offer != null) {
      $result.offer = offer;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (payerNote != null) {
      $result.payerNote = payerNote;
    }
    if (responseInvoiceTimeout != null) {
      $result.responseInvoiceTimeout = responseInvoiceTimeout;
    }
    if (feeLimit != null) {
      $result.feeLimit = feeLimit;
    }
    if (feeLimitPercent != null) {
      $result.feeLimitPercent = feeLimitPercent;
    }
    return $result;
  }
  PayOfferRequest._() : super();
  factory PayOfferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayOfferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayOfferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offer')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'payerNote')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'responseInvoiceTimeout', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'feeLimit', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'feeLimitPercent', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayOfferRequest clone() => PayOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayOfferRequest copyWith(void Function(PayOfferRequest) updates) => super.copyWith((message) => updates(message as PayOfferRequest)) as PayOfferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayOfferRequest create() => PayOfferRequest._();
  PayOfferRequest createEmptyInstance() => create();
  static $pb.PbList<PayOfferRequest> createRepeated() => $pb.PbList<PayOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static PayOfferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayOfferRequest>(create);
  static PayOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offer => $_getSZ(0);
  @$pb.TagNumber(1)
  set offer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerNote => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerNote($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerNote() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get responseInvoiceTimeout => $_getIZ(3);
  @$pb.TagNumber(4)
  set responseInvoiceTimeout($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponseInvoiceTimeout() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseInvoiceTimeout() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get feeLimit => $_getIZ(4);
  @$pb.TagNumber(5)
  set feeLimit($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFeeLimit() => $_has(4);
  @$pb.TagNumber(5)
  void clearFeeLimit() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get feeLimitPercent => $_getIZ(5);
  @$pb.TagNumber(6)
  set feeLimitPercent($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFeeLimitPercent() => $_has(5);
  @$pb.TagNumber(6)
  void clearFeeLimitPercent() => $_clearField(6);
}

class PayOfferResponse extends $pb.GeneratedMessage {
  factory PayOfferResponse({
    $core.String? paymentPreimage,
  }) {
    final $result = create();
    if (paymentPreimage != null) {
      $result.paymentPreimage = paymentPreimage;
    }
    return $result;
  }
  PayOfferResponse._() : super();
  factory PayOfferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayOfferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayOfferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'paymentPreimage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayOfferResponse clone() => PayOfferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayOfferResponse copyWith(void Function(PayOfferResponse) updates) => super.copyWith((message) => updates(message as PayOfferResponse)) as PayOfferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayOfferResponse create() => PayOfferResponse._();
  PayOfferResponse createEmptyInstance() => create();
  static $pb.PbList<PayOfferResponse> createRepeated() => $pb.PbList<PayOfferResponse>();
  @$core.pragma('dart2js:noInline')
  static PayOfferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayOfferResponse>(create);
  static PayOfferResponse? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get paymentPreimage => $_getSZ(0);
  @$pb.TagNumber(2)
  set paymentPreimage($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentPreimage() => $_has(0);
  @$pb.TagNumber(2)
  void clearPaymentPreimage() => $_clearField(2);
}

class GetInvoiceRequest extends $pb.GeneratedMessage {
  factory GetInvoiceRequest({
    $core.String? offer,
    $fixnum.Int64? amount,
    $core.String? payerNote,
    $core.int? responseInvoiceTimeout,
  }) {
    final $result = create();
    if (offer != null) {
      $result.offer = offer;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (payerNote != null) {
      $result.payerNote = payerNote;
    }
    if (responseInvoiceTimeout != null) {
      $result.responseInvoiceTimeout = responseInvoiceTimeout;
    }
    return $result;
  }
  GetInvoiceRequest._() : super();
  factory GetInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offer')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'payerNote')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'responseInvoiceTimeout', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceRequest clone() => GetInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceRequest copyWith(void Function(GetInvoiceRequest) updates) => super.copyWith((message) => updates(message as GetInvoiceRequest)) as GetInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceRequest create() => GetInvoiceRequest._();
  GetInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceRequest> createRepeated() => $pb.PbList<GetInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceRequest>(create);
  static GetInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offer => $_getSZ(0);
  @$pb.TagNumber(1)
  set offer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get payerNote => $_getSZ(2);
  @$pb.TagNumber(3)
  set payerNote($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPayerNote() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayerNote() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get responseInvoiceTimeout => $_getIZ(3);
  @$pb.TagNumber(4)
  set responseInvoiceTimeout($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResponseInvoiceTimeout() => $_has(3);
  @$pb.TagNumber(4)
  void clearResponseInvoiceTimeout() => $_clearField(4);
}

class DecodeInvoiceRequest extends $pb.GeneratedMessage {
  factory DecodeInvoiceRequest({
    $core.String? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  DecodeInvoiceRequest._() : super();
  factory DecodeInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeInvoiceRequest clone() => DecodeInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeInvoiceRequest copyWith(void Function(DecodeInvoiceRequest) updates) => super.copyWith((message) => updates(message as DecodeInvoiceRequest)) as DecodeInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeInvoiceRequest create() => DecodeInvoiceRequest._();
  DecodeInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<DecodeInvoiceRequest> createRepeated() => $pb.PbList<DecodeInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DecodeInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeInvoiceRequest>(create);
  static DecodeInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
}

class GetInvoiceResponse extends $pb.GeneratedMessage {
  factory GetInvoiceResponse({
    $core.String? invoiceHexStr,
    Bolt12InvoiceContents? invoiceContents,
  }) {
    final $result = create();
    if (invoiceHexStr != null) {
      $result.invoiceHexStr = invoiceHexStr;
    }
    if (invoiceContents != null) {
      $result.invoiceContents = invoiceContents;
    }
    return $result;
  }
  GetInvoiceResponse._() : super();
  factory GetInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoiceHexStr')
    ..aOM<Bolt12InvoiceContents>(2, _omitFieldNames ? '' : 'invoiceContents', subBuilder: Bolt12InvoiceContents.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInvoiceResponse clone() => GetInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInvoiceResponse copyWith(void Function(GetInvoiceResponse) updates) => super.copyWith((message) => updates(message as GetInvoiceResponse)) as GetInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInvoiceResponse create() => GetInvoiceResponse._();
  GetInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<GetInvoiceResponse> createRepeated() => $pb.PbList<GetInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInvoiceResponse>(create);
  static GetInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoiceHexStr => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoiceHexStr($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoiceHexStr() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoiceHexStr() => $_clearField(1);

  @$pb.TagNumber(2)
  Bolt12InvoiceContents get invoiceContents => $_getN(1);
  @$pb.TagNumber(2)
  set invoiceContents(Bolt12InvoiceContents v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvoiceContents() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvoiceContents() => $_clearField(2);
  @$pb.TagNumber(2)
  Bolt12InvoiceContents ensureInvoiceContents() => $_ensure(1);
}

class PayInvoiceRequest extends $pb.GeneratedMessage {
  factory PayInvoiceRequest({
    $core.String? invoice,
    $fixnum.Int64? amount,
    $core.int? feeLimit,
    $core.int? feeLimitPercent,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (feeLimit != null) {
      $result.feeLimit = feeLimit;
    }
    if (feeLimitPercent != null) {
      $result.feeLimitPercent = feeLimitPercent;
    }
    return $result;
  }
  PayInvoiceRequest._() : super();
  factory PayInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'feeLimit', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'feeLimitPercent', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceRequest clone() => PayInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceRequest copyWith(void Function(PayInvoiceRequest) updates) => super.copyWith((message) => updates(message as PayInvoiceRequest)) as PayInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayInvoiceRequest create() => PayInvoiceRequest._();
  PayInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<PayInvoiceRequest> createRepeated() => $pb.PbList<PayInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static PayInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInvoiceRequest>(create);
  static PayInvoiceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get feeLimit => $_getIZ(2);
  @$pb.TagNumber(3)
  set feeLimit($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeeLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeLimit() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get feeLimitPercent => $_getIZ(3);
  @$pb.TagNumber(4)
  set feeLimitPercent($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeLimitPercent() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeLimitPercent() => $_clearField(4);
}

class PayInvoiceResponse extends $pb.GeneratedMessage {
  factory PayInvoiceResponse({
    $core.String? paymentPreimage,
  }) {
    final $result = create();
    if (paymentPreimage != null) {
      $result.paymentPreimage = paymentPreimage;
    }
    return $result;
  }
  PayInvoiceResponse._() : super();
  factory PayInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentPreimage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayInvoiceResponse clone() => PayInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayInvoiceResponse copyWith(void Function(PayInvoiceResponse) updates) => super.copyWith((message) => updates(message as PayInvoiceResponse)) as PayInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayInvoiceResponse create() => PayInvoiceResponse._();
  PayInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<PayInvoiceResponse> createRepeated() => $pb.PbList<PayInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static PayInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayInvoiceResponse>(create);
  static PayInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentPreimage => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentPreimage($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentPreimage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentPreimage() => $_clearField(1);
}

class Bolt12InvoiceContents extends $pb.GeneratedMessage {
  factory Bolt12InvoiceContents({
    $core.String? chain,
    $fixnum.Int64? quantity,
    $fixnum.Int64? amountMsats,
    $core.String? description,
    PaymentHash? paymentHash,
    $core.Iterable<PaymentPaths>? paymentPaths,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? relativeExpiry,
    PublicKey? nodeId,
    $core.String? signature,
    $core.Iterable<FeatureBit>? features,
    $core.String? payerNote,
  }) {
    final $result = create();
    if (chain != null) {
      $result.chain = chain;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (amountMsats != null) {
      $result.amountMsats = amountMsats;
    }
    if (description != null) {
      $result.description = description;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentPaths != null) {
      $result.paymentPaths.addAll(paymentPaths);
    }
    if (createdAt != null) {
      $result.createdAt = createdAt;
    }
    if (relativeExpiry != null) {
      $result.relativeExpiry = relativeExpiry;
    }
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (signature != null) {
      $result.signature = signature;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (payerNote != null) {
      $result.payerNote = payerNote;
    }
    return $result;
  }
  Bolt12InvoiceContents._() : super();
  factory Bolt12InvoiceContents.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12InvoiceContents.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12InvoiceContents', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chain')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountMsats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'description')
    ..aOM<PaymentHash>(5, _omitFieldNames ? '' : 'paymentHash', subBuilder: PaymentHash.create)
    ..pc<PaymentPaths>(6, _omitFieldNames ? '' : 'paymentPaths', $pb.PbFieldType.PM, subBuilder: PaymentPaths.create)
    ..aInt64(7, _omitFieldNames ? '' : 'createdAt')
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'relativeExpiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<PublicKey>(9, _omitFieldNames ? '' : 'nodeId', subBuilder: PublicKey.create)
    ..aOS(10, _omitFieldNames ? '' : 'signature')
    ..pc<FeatureBit>(11, _omitFieldNames ? '' : 'features', $pb.PbFieldType.KE, valueOf: FeatureBit.valueOf, enumValues: FeatureBit.values, defaultEnumValue: FeatureBit.DATALOSS_PROTECT_REQ)
    ..aOS(12, _omitFieldNames ? '' : 'payerNote')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12InvoiceContents clone() => Bolt12InvoiceContents()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12InvoiceContents copyWith(void Function(Bolt12InvoiceContents) updates) => super.copyWith((message) => updates(message as Bolt12InvoiceContents)) as Bolt12InvoiceContents;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12InvoiceContents create() => Bolt12InvoiceContents._();
  Bolt12InvoiceContents createEmptyInstance() => create();
  static $pb.PbList<Bolt12InvoiceContents> createRepeated() => $pb.PbList<Bolt12InvoiceContents>();
  @$core.pragma('dart2js:noInline')
  static Bolt12InvoiceContents getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12InvoiceContents>(create);
  static Bolt12InvoiceContents? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get chain => $_getSZ(0);
  @$pb.TagNumber(1)
  set chain($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChain() => $_has(0);
  @$pb.TagNumber(1)
  void clearChain() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get quantity => $_getI64(1);
  @$pb.TagNumber(2)
  set quantity($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuantity() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuantity() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMsats => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMsats($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountMsats() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMsats() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(4)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(4)
  void clearDescription() => $_clearField(4);

  @$pb.TagNumber(5)
  PaymentHash get paymentHash => $_getN(4);
  @$pb.TagNumber(5)
  set paymentHash(PaymentHash v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentHash() => $_clearField(5);
  @$pb.TagNumber(5)
  PaymentHash ensurePaymentHash() => $_ensure(4);

  @$pb.TagNumber(6)
  $pb.PbList<PaymentPaths> get paymentPaths => $_getList(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createdAt => $_getI64(6);
  @$pb.TagNumber(7)
  set createdAt($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get relativeExpiry => $_getI64(7);
  @$pb.TagNumber(8)
  set relativeExpiry($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRelativeExpiry() => $_has(7);
  @$pb.TagNumber(8)
  void clearRelativeExpiry() => $_clearField(8);

  @$pb.TagNumber(9)
  PublicKey get nodeId => $_getN(8);
  @$pb.TagNumber(9)
  set nodeId(PublicKey v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasNodeId() => $_has(8);
  @$pb.TagNumber(9)
  void clearNodeId() => $_clearField(9);
  @$pb.TagNumber(9)
  PublicKey ensureNodeId() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get signature => $_getSZ(9);
  @$pb.TagNumber(10)
  set signature($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasSignature() => $_has(9);
  @$pb.TagNumber(10)
  void clearSignature() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<FeatureBit> get features => $_getList(10);

  @$pb.TagNumber(12)
  $core.String get payerNote => $_getSZ(11);
  @$pb.TagNumber(12)
  set payerNote($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPayerNote() => $_has(11);
  @$pb.TagNumber(12)
  void clearPayerNote() => $_clearField(12);
}

class PaymentHash extends $pb.GeneratedMessage {
  factory PaymentHash({
    $core.List<$core.int>? hash,
  }) {
    final $result = create();
    if (hash != null) {
      $result.hash = hash;
    }
    return $result;
  }
  PaymentHash._() : super();
  factory PaymentHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentHash', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'hash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentHash clone() => PaymentHash()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentHash copyWith(void Function(PaymentHash) updates) => super.copyWith((message) => updates(message as PaymentHash)) as PaymentHash;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentHash create() => PaymentHash._();
  PaymentHash createEmptyInstance() => create();
  static $pb.PbList<PaymentHash> createRepeated() => $pb.PbList<PaymentHash>();
  @$core.pragma('dart2js:noInline')
  static PaymentHash getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentHash>(create);
  static PaymentHash? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get hash => $_getN(0);
  @$pb.TagNumber(1)
  set hash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);
}

class PublicKey extends $pb.GeneratedMessage {
  factory PublicKey({
    $core.List<$core.int>? key,
  }) {
    final $result = create();
    if (key != null) {
      $result.key = key;
    }
    return $result;
  }
  PublicKey._() : super();
  factory PublicKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PublicKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'key', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicKey clone() => PublicKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicKey copyWith(void Function(PublicKey) updates) => super.copyWith((message) => updates(message as PublicKey)) as PublicKey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PublicKey create() => PublicKey._();
  PublicKey createEmptyInstance() => create();
  static $pb.PbList<PublicKey> createRepeated() => $pb.PbList<PublicKey>();
  @$core.pragma('dart2js:noInline')
  static PublicKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicKey>(create);
  static PublicKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get key => $_getN(0);
  @$pb.TagNumber(1)
  set key($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

class BlindedPayInfo extends $pb.GeneratedMessage {
  factory BlindedPayInfo({
    $core.int? feeBaseMsat,
    $core.int? feeProportionalMillionths,
    $core.int? cltvExpiryDelta,
    $fixnum.Int64? htlcMinimumMsat,
    $fixnum.Int64? htlcMaximumMsat,
    $core.Iterable<FeatureBit>? features,
  }) {
    final $result = create();
    if (feeBaseMsat != null) {
      $result.feeBaseMsat = feeBaseMsat;
    }
    if (feeProportionalMillionths != null) {
      $result.feeProportionalMillionths = feeProportionalMillionths;
    }
    if (cltvExpiryDelta != null) {
      $result.cltvExpiryDelta = cltvExpiryDelta;
    }
    if (htlcMinimumMsat != null) {
      $result.htlcMinimumMsat = htlcMinimumMsat;
    }
    if (htlcMaximumMsat != null) {
      $result.htlcMaximumMsat = htlcMaximumMsat;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    return $result;
  }
  BlindedPayInfo._() : super();
  factory BlindedPayInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedPayInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedPayInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'feeBaseMsat', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'feeProportionalMillionths', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'cltvExpiryDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'htlcMinimumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'htlcMaximumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<FeatureBit>(6, _omitFieldNames ? '' : 'features', $pb.PbFieldType.KE, valueOf: FeatureBit.valueOf, enumValues: FeatureBit.values, defaultEnumValue: FeatureBit.DATALOSS_PROTECT_REQ)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlindedPayInfo clone() => BlindedPayInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlindedPayInfo copyWith(void Function(BlindedPayInfo) updates) => super.copyWith((message) => updates(message as BlindedPayInfo)) as BlindedPayInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlindedPayInfo create() => BlindedPayInfo._();
  BlindedPayInfo createEmptyInstance() => create();
  static $pb.PbList<BlindedPayInfo> createRepeated() => $pb.PbList<BlindedPayInfo>();
  @$core.pragma('dart2js:noInline')
  static BlindedPayInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlindedPayInfo>(create);
  static BlindedPayInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get feeBaseMsat => $_getIZ(0);
  @$pb.TagNumber(1)
  set feeBaseMsat($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFeeBaseMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeeBaseMsat() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get feeProportionalMillionths => $_getIZ(1);
  @$pb.TagNumber(2)
  set feeProportionalMillionths($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFeeProportionalMillionths() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeeProportionalMillionths() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get cltvExpiryDelta => $_getIZ(2);
  @$pb.TagNumber(3)
  set cltvExpiryDelta($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCltvExpiryDelta() => $_has(2);
  @$pb.TagNumber(3)
  void clearCltvExpiryDelta() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get htlcMinimumMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set htlcMinimumMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHtlcMinimumMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearHtlcMinimumMsat() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get htlcMaximumMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set htlcMaximumMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHtlcMaximumMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearHtlcMaximumMsat() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbList<FeatureBit> get features => $_getList(5);
}

class BlindedHop extends $pb.GeneratedMessage {
  factory BlindedHop({
    PublicKey? blindedNodeId,
    $core.List<$core.int>? encryptedPayload,
  }) {
    final $result = create();
    if (blindedNodeId != null) {
      $result.blindedNodeId = blindedNodeId;
    }
    if (encryptedPayload != null) {
      $result.encryptedPayload = encryptedPayload;
    }
    return $result;
  }
  BlindedHop._() : super();
  factory BlindedHop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedHop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedHop', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'blindedNodeId', subBuilder: PublicKey.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'encryptedPayload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlindedHop clone() => BlindedHop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlindedHop copyWith(void Function(BlindedHop) updates) => super.copyWith((message) => updates(message as BlindedHop)) as BlindedHop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlindedHop create() => BlindedHop._();
  BlindedHop createEmptyInstance() => create();
  static $pb.PbList<BlindedHop> createRepeated() => $pb.PbList<BlindedHop>();
  @$core.pragma('dart2js:noInline')
  static BlindedHop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlindedHop>(create);
  static BlindedHop? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get blindedNodeId => $_getN(0);
  @$pb.TagNumber(1)
  set blindedNodeId(PublicKey v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlindedNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlindedNodeId() => $_clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensureBlindedNodeId() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.List<$core.int> get encryptedPayload => $_getN(1);
  @$pb.TagNumber(2)
  set encryptedPayload($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEncryptedPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearEncryptedPayload() => $_clearField(2);
}

class BlindedPath extends $pb.GeneratedMessage {
  factory BlindedPath({
    IntroductionNode? introductionNode,
    PublicKey? blindingPoint,
    $core.Iterable<BlindedHop>? blindedHops,
  }) {
    final $result = create();
    if (introductionNode != null) {
      $result.introductionNode = introductionNode;
    }
    if (blindingPoint != null) {
      $result.blindingPoint = blindingPoint;
    }
    if (blindedHops != null) {
      $result.blindedHops.addAll(blindedHops);
    }
    return $result;
  }
  BlindedPath._() : super();
  factory BlindedPath.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedPath.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedPath', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOM<IntroductionNode>(1, _omitFieldNames ? '' : 'introductionNode', subBuilder: IntroductionNode.create)
    ..aOM<PublicKey>(2, _omitFieldNames ? '' : 'blindingPoint', subBuilder: PublicKey.create)
    ..pc<BlindedHop>(3, _omitFieldNames ? '' : 'blindedHops', $pb.PbFieldType.PM, subBuilder: BlindedHop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlindedPath clone() => BlindedPath()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlindedPath copyWith(void Function(BlindedPath) updates) => super.copyWith((message) => updates(message as BlindedPath)) as BlindedPath;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlindedPath create() => BlindedPath._();
  BlindedPath createEmptyInstance() => create();
  static $pb.PbList<BlindedPath> createRepeated() => $pb.PbList<BlindedPath>();
  @$core.pragma('dart2js:noInline')
  static BlindedPath getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlindedPath>(create);
  static BlindedPath? _defaultInstance;

  @$pb.TagNumber(1)
  IntroductionNode get introductionNode => $_getN(0);
  @$pb.TagNumber(1)
  set introductionNode(IntroductionNode v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIntroductionNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearIntroductionNode() => $_clearField(1);
  @$pb.TagNumber(1)
  IntroductionNode ensureIntroductionNode() => $_ensure(0);

  @$pb.TagNumber(2)
  PublicKey get blindingPoint => $_getN(1);
  @$pb.TagNumber(2)
  set blindingPoint(PublicKey v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBlindingPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlindingPoint() => $_clearField(2);
  @$pb.TagNumber(2)
  PublicKey ensureBlindingPoint() => $_ensure(1);

  @$pb.TagNumber(3)
  $pb.PbList<BlindedHop> get blindedHops => $_getList(2);
}

class PaymentPaths extends $pb.GeneratedMessage {
  factory PaymentPaths({
    BlindedPayInfo? blindedPayInfo,
    BlindedPath? blindedPath,
  }) {
    final $result = create();
    if (blindedPayInfo != null) {
      $result.blindedPayInfo = blindedPayInfo;
    }
    if (blindedPath != null) {
      $result.blindedPath = blindedPath;
    }
    return $result;
  }
  PaymentPaths._() : super();
  factory PaymentPaths.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentPaths.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentPaths', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOM<BlindedPayInfo>(1, _omitFieldNames ? '' : 'blindedPayInfo', subBuilder: BlindedPayInfo.create)
    ..aOM<BlindedPath>(2, _omitFieldNames ? '' : 'blindedPath', subBuilder: BlindedPath.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentPaths clone() => PaymentPaths()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentPaths copyWith(void Function(PaymentPaths) updates) => super.copyWith((message) => updates(message as PaymentPaths)) as PaymentPaths;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentPaths create() => PaymentPaths._();
  PaymentPaths createEmptyInstance() => create();
  static $pb.PbList<PaymentPaths> createRepeated() => $pb.PbList<PaymentPaths>();
  @$core.pragma('dart2js:noInline')
  static PaymentPaths getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentPaths>(create);
  static PaymentPaths? _defaultInstance;

  @$pb.TagNumber(1)
  BlindedPayInfo get blindedPayInfo => $_getN(0);
  @$pb.TagNumber(1)
  set blindedPayInfo(BlindedPayInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlindedPayInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlindedPayInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  BlindedPayInfo ensureBlindedPayInfo() => $_ensure(0);

  @$pb.TagNumber(2)
  BlindedPath get blindedPath => $_getN(1);
  @$pb.TagNumber(2)
  set blindedPath(BlindedPath v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBlindedPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlindedPath() => $_clearField(2);
  @$pb.TagNumber(2)
  BlindedPath ensureBlindedPath() => $_ensure(1);
}

class IntroductionNode extends $pb.GeneratedMessage {
  factory IntroductionNode({
    PublicKey? nodeId,
    DirectedShortChannelId? directedShortChannelId,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (directedShortChannelId != null) {
      $result.directedShortChannelId = directedShortChannelId;
    }
    return $result;
  }
  IntroductionNode._() : super();
  factory IntroductionNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory IntroductionNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'IntroductionNode', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOM<PublicKey>(1, _omitFieldNames ? '' : 'nodeId', subBuilder: PublicKey.create)
    ..aOM<DirectedShortChannelId>(2, _omitFieldNames ? '' : 'directedShortChannelId', subBuilder: DirectedShortChannelId.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  IntroductionNode clone() => IntroductionNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  IntroductionNode copyWith(void Function(IntroductionNode) updates) => super.copyWith((message) => updates(message as IntroductionNode)) as IntroductionNode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IntroductionNode create() => IntroductionNode._();
  IntroductionNode createEmptyInstance() => create();
  static $pb.PbList<IntroductionNode> createRepeated() => $pb.PbList<IntroductionNode>();
  @$core.pragma('dart2js:noInline')
  static IntroductionNode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<IntroductionNode>(create);
  static IntroductionNode? _defaultInstance;

  @$pb.TagNumber(1)
  PublicKey get nodeId => $_getN(0);
  @$pb.TagNumber(1)
  set nodeId(PublicKey v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);
  @$pb.TagNumber(1)
  PublicKey ensureNodeId() => $_ensure(0);

  @$pb.TagNumber(2)
  DirectedShortChannelId get directedShortChannelId => $_getN(1);
  @$pb.TagNumber(2)
  set directedShortChannelId(DirectedShortChannelId v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirectedShortChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirectedShortChannelId() => $_clearField(2);
  @$pb.TagNumber(2)
  DirectedShortChannelId ensureDirectedShortChannelId() => $_ensure(1);
}

class DirectedShortChannelId extends $pb.GeneratedMessage {
  factory DirectedShortChannelId({
    Direction? direction,
    $fixnum.Int64? scid,
  }) {
    final $result = create();
    if (direction != null) {
      $result.direction = direction;
    }
    if (scid != null) {
      $result.scid = scid;
    }
    return $result;
  }
  DirectedShortChannelId._() : super();
  factory DirectedShortChannelId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DirectedShortChannelId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DirectedShortChannelId', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..e<Direction>(1, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: Direction.NODE_ONE, valueOf: Direction.valueOf, enumValues: Direction.values)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'scid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DirectedShortChannelId clone() => DirectedShortChannelId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DirectedShortChannelId copyWith(void Function(DirectedShortChannelId) updates) => super.copyWith((message) => updates(message as DirectedShortChannelId)) as DirectedShortChannelId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DirectedShortChannelId create() => DirectedShortChannelId._();
  DirectedShortChannelId createEmptyInstance() => create();
  static $pb.PbList<DirectedShortChannelId> createRepeated() => $pb.PbList<DirectedShortChannelId>();
  @$core.pragma('dart2js:noInline')
  static DirectedShortChannelId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DirectedShortChannelId>(create);
  static DirectedShortChannelId? _defaultInstance;

  @$pb.TagNumber(1)
  Direction get direction => $_getN(0);
  @$pb.TagNumber(1)
  set direction(Direction v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDirection() => $_has(0);
  @$pb.TagNumber(1)
  void clearDirection() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get scid => $_getI64(1);
  @$pb.TagNumber(2)
  set scid($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScid() => $_has(1);
  @$pb.TagNumber(2)
  void clearScid() => $_clearField(2);
}

class CreateOfferRequest extends $pb.GeneratedMessage {
  factory CreateOfferRequest({
    $fixnum.Int64? amount,
    $core.String? description,
    $core.String? issuer,
    $fixnum.Int64? quantity,
    $fixnum.Int64? expiry,
  }) {
    final $result = create();
    if (amount != null) {
      $result.amount = amount;
    }
    if (description != null) {
      $result.description = description;
    }
    if (issuer != null) {
      $result.issuer = issuer;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (expiry != null) {
      $result.expiry = expiry;
    }
    return $result;
  }
  CreateOfferRequest._() : super();
  factory CreateOfferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOfferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateOfferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'issuer')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'expiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOfferRequest clone() => CreateOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOfferRequest copyWith(void Function(CreateOfferRequest) updates) => super.copyWith((message) => updates(message as CreateOfferRequest)) as CreateOfferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOfferRequest create() => CreateOfferRequest._();
  CreateOfferRequest createEmptyInstance() => create();
  static $pb.PbList<CreateOfferRequest> createRepeated() => $pb.PbList<CreateOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateOfferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOfferRequest>(create);
  static CreateOfferRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get amount => $_getI64(0);
  @$pb.TagNumber(1)
  set amount($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get issuer => $_getSZ(2);
  @$pb.TagNumber(3)
  set issuer($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIssuer() => $_has(2);
  @$pb.TagNumber(3)
  void clearIssuer() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get quantity => $_getI64(3);
  @$pb.TagNumber(4)
  set quantity($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiry => $_getI64(4);
  @$pb.TagNumber(5)
  set expiry($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiry() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiry() => $_clearField(5);
}

class CreateOfferResponse extends $pb.GeneratedMessage {
  factory CreateOfferResponse({
    $core.String? offer,
  }) {
    final $result = create();
    if (offer != null) {
      $result.offer = offer;
    }
    return $result;
  }
  CreateOfferResponse._() : super();
  factory CreateOfferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateOfferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateOfferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lndkrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offer')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateOfferResponse clone() => CreateOfferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateOfferResponse copyWith(void Function(CreateOfferResponse) updates) => super.copyWith((message) => updates(message as CreateOfferResponse)) as CreateOfferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateOfferResponse create() => CreateOfferResponse._();
  CreateOfferResponse createEmptyInstance() => create();
  static $pb.PbList<CreateOfferResponse> createRepeated() => $pb.PbList<CreateOfferResponse>();
  @$core.pragma('dart2js:noInline')
  static CreateOfferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateOfferResponse>(create);
  static CreateOfferResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get offer => $_getSZ(0);
  @$pb.TagNumber(1)
  set offer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
