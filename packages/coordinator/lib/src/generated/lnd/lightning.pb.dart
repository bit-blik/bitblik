//
//  Generated code. Do not modify.
//  source: lnd/lightning.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'lightning.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'lightning.pbenum.dart';

class LookupHtlcResolutionRequest extends $pb.GeneratedMessage {
  factory LookupHtlcResolutionRequest({
    $fixnum.Int64? chanId,
    $fixnum.Int64? htlcIndex,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (htlcIndex != null) {
      $result.htlcIndex = htlcIndex;
    }
    return $result;
  }
  LookupHtlcResolutionRequest._() : super();
  factory LookupHtlcResolutionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupHtlcResolutionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupHtlcResolutionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'htlcIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupHtlcResolutionRequest clone() => LookupHtlcResolutionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupHtlcResolutionRequest copyWith(void Function(LookupHtlcResolutionRequest) updates) => super.copyWith((message) => updates(message as LookupHtlcResolutionRequest)) as LookupHtlcResolutionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupHtlcResolutionRequest create() => LookupHtlcResolutionRequest._();
  LookupHtlcResolutionRequest createEmptyInstance() => create();
  static $pb.PbList<LookupHtlcResolutionRequest> createRepeated() => $pb.PbList<LookupHtlcResolutionRequest>();
  @$core.pragma('dart2js:noInline')
  static LookupHtlcResolutionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupHtlcResolutionRequest>(create);
  static LookupHtlcResolutionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get htlcIndex => $_getI64(1);
  @$pb.TagNumber(2)
  set htlcIndex($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHtlcIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearHtlcIndex() => $_clearField(2);
}

class LookupHtlcResolutionResponse extends $pb.GeneratedMessage {
  factory LookupHtlcResolutionResponse({
    $core.bool? settled,
    $core.bool? offchain,
  }) {
    final $result = create();
    if (settled != null) {
      $result.settled = settled;
    }
    if (offchain != null) {
      $result.offchain = offchain;
    }
    return $result;
  }
  LookupHtlcResolutionResponse._() : super();
  factory LookupHtlcResolutionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LookupHtlcResolutionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LookupHtlcResolutionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'settled')
    ..aOB(2, _omitFieldNames ? '' : 'offchain')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LookupHtlcResolutionResponse clone() => LookupHtlcResolutionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LookupHtlcResolutionResponse copyWith(void Function(LookupHtlcResolutionResponse) updates) => super.copyWith((message) => updates(message as LookupHtlcResolutionResponse)) as LookupHtlcResolutionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LookupHtlcResolutionResponse create() => LookupHtlcResolutionResponse._();
  LookupHtlcResolutionResponse createEmptyInstance() => create();
  static $pb.PbList<LookupHtlcResolutionResponse> createRepeated() => $pb.PbList<LookupHtlcResolutionResponse>();
  @$core.pragma('dart2js:noInline')
  static LookupHtlcResolutionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LookupHtlcResolutionResponse>(create);
  static LookupHtlcResolutionResponse? _defaultInstance;

  /// Settled is true is the htlc was settled. If false, the htlc was failed.
  @$pb.TagNumber(1)
  $core.bool get settled => $_getBF(0);
  @$pb.TagNumber(1)
  set settled($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSettled() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettled() => $_clearField(1);

  /// Offchain indicates whether the htlc was resolved off-chain or on-chain.
  @$pb.TagNumber(2)
  $core.bool get offchain => $_getBF(1);
  @$pb.TagNumber(2)
  set offchain($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffchain() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffchain() => $_clearField(2);
}

class SubscribeCustomMessagesRequest extends $pb.GeneratedMessage {
  factory SubscribeCustomMessagesRequest() => create();
  SubscribeCustomMessagesRequest._() : super();
  factory SubscribeCustomMessagesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeCustomMessagesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeCustomMessagesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeCustomMessagesRequest clone() => SubscribeCustomMessagesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeCustomMessagesRequest copyWith(void Function(SubscribeCustomMessagesRequest) updates) => super.copyWith((message) => updates(message as SubscribeCustomMessagesRequest)) as SubscribeCustomMessagesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeCustomMessagesRequest create() => SubscribeCustomMessagesRequest._();
  SubscribeCustomMessagesRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeCustomMessagesRequest> createRepeated() => $pb.PbList<SubscribeCustomMessagesRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeCustomMessagesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeCustomMessagesRequest>(create);
  static SubscribeCustomMessagesRequest? _defaultInstance;
}

class CustomMessage extends $pb.GeneratedMessage {
  factory CustomMessage({
    $core.List<$core.int>? peer,
    $core.int? type,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (peer != null) {
      $result.peer = peer;
    }
    if (type != null) {
      $result.type = type;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  CustomMessage._() : super();
  factory CustomMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'peer', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomMessage clone() => CustomMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomMessage copyWith(void Function(CustomMessage) updates) => super.copyWith((message) => updates(message as CustomMessage)) as CustomMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomMessage create() => CustomMessage._();
  CustomMessage createEmptyInstance() => create();
  static $pb.PbList<CustomMessage> createRepeated() => $pb.PbList<CustomMessage>();
  @$core.pragma('dart2js:noInline')
  static CustomMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomMessage>(create);
  static CustomMessage? _defaultInstance;

  /// Peer from which the message originates
  @$pb.TagNumber(1)
  $core.List<$core.int> get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);

  /// Message type. This value will be in the custom range (>= 32768).
  @$pb.TagNumber(2)
  $core.int get type => $_getIZ(1);
  @$pb.TagNumber(2)
  set type($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  /// Raw message data
  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
}

class SendCustomMessageRequest extends $pb.GeneratedMessage {
  factory SendCustomMessageRequest({
    $core.List<$core.int>? peer,
    $core.int? type,
    $core.List<$core.int>? data,
  }) {
    final $result = create();
    if (peer != null) {
      $result.peer = peer;
    }
    if (type != null) {
      $result.type = type;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  SendCustomMessageRequest._() : super();
  factory SendCustomMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendCustomMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendCustomMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'peer', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendCustomMessageRequest clone() => SendCustomMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendCustomMessageRequest copyWith(void Function(SendCustomMessageRequest) updates) => super.copyWith((message) => updates(message as SendCustomMessageRequest)) as SendCustomMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendCustomMessageRequest create() => SendCustomMessageRequest._();
  SendCustomMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SendCustomMessageRequest> createRepeated() => $pb.PbList<SendCustomMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SendCustomMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCustomMessageRequest>(create);
  static SendCustomMessageRequest? _defaultInstance;

  /// Peer to send the message to
  @$pb.TagNumber(1)
  $core.List<$core.int> get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);

  /// Message type. This value needs to be in the custom range (>= 32768).
  /// To send a type < custom range, lnd needs to be compiled with the `dev`
  /// build tag, and the message type to override should be specified in lnd's
  /// experimental protocol configuration.
  @$pb.TagNumber(2)
  $core.int get type => $_getIZ(1);
  @$pb.TagNumber(2)
  set type($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  /// Raw message data.
  @$pb.TagNumber(3)
  $core.List<$core.int> get data => $_getN(2);
  @$pb.TagNumber(3)
  set data($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasData() => $_has(2);
  @$pb.TagNumber(3)
  void clearData() => $_clearField(3);
}

class SendCustomMessageResponse extends $pb.GeneratedMessage {
  factory SendCustomMessageResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  SendCustomMessageResponse._() : super();
  factory SendCustomMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendCustomMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendCustomMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendCustomMessageResponse clone() => SendCustomMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendCustomMessageResponse copyWith(void Function(SendCustomMessageResponse) updates) => super.copyWith((message) => updates(message as SendCustomMessageResponse)) as SendCustomMessageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendCustomMessageResponse create() => SendCustomMessageResponse._();
  SendCustomMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SendCustomMessageResponse> createRepeated() => $pb.PbList<SendCustomMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SendCustomMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCustomMessageResponse>(create);
  static SendCustomMessageResponse? _defaultInstance;

  /// The status of the send operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class Utxo extends $pb.GeneratedMessage {
  factory Utxo({
    AddressType? addressType,
    $core.String? address,
    $fixnum.Int64? amountSat,
    $core.String? pkScript,
    OutPoint? outpoint,
    $fixnum.Int64? confirmations,
  }) {
    final $result = create();
    if (addressType != null) {
      $result.addressType = addressType;
    }
    if (address != null) {
      $result.address = address;
    }
    if (amountSat != null) {
      $result.amountSat = amountSat;
    }
    if (pkScript != null) {
      $result.pkScript = pkScript;
    }
    if (outpoint != null) {
      $result.outpoint = outpoint;
    }
    if (confirmations != null) {
      $result.confirmations = confirmations;
    }
    return $result;
  }
  Utxo._() : super();
  factory Utxo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Utxo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Utxo', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<AddressType>(1, _omitFieldNames ? '' : 'addressType', $pb.PbFieldType.OE, defaultOrMaker: AddressType.WITNESS_PUBKEY_HASH, valueOf: AddressType.valueOf, enumValues: AddressType.values)
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aInt64(3, _omitFieldNames ? '' : 'amountSat')
    ..aOS(4, _omitFieldNames ? '' : 'pkScript')
    ..aOM<OutPoint>(5, _omitFieldNames ? '' : 'outpoint', subBuilder: OutPoint.create)
    ..aInt64(6, _omitFieldNames ? '' : 'confirmations')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Utxo clone() => Utxo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Utxo copyWith(void Function(Utxo) updates) => super.copyWith((message) => updates(message as Utxo)) as Utxo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Utxo create() => Utxo._();
  Utxo createEmptyInstance() => create();
  static $pb.PbList<Utxo> createRepeated() => $pb.PbList<Utxo>();
  @$core.pragma('dart2js:noInline')
  static Utxo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Utxo>(create);
  static Utxo? _defaultInstance;

  /// The type of address
  @$pb.TagNumber(1)
  AddressType get addressType => $_getN(0);
  @$pb.TagNumber(1)
  set addressType(AddressType v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddressType() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddressType() => $_clearField(1);

  /// The address
  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);

  /// The value of the unspent coin in satoshis
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSat => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSat() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSat() => $_clearField(3);

  /// The pkscript in hex
  @$pb.TagNumber(4)
  $core.String get pkScript => $_getSZ(3);
  @$pb.TagNumber(4)
  set pkScript($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPkScript() => $_has(3);
  @$pb.TagNumber(4)
  void clearPkScript() => $_clearField(4);

  /// The outpoint in format txid:n
  @$pb.TagNumber(5)
  OutPoint get outpoint => $_getN(4);
  @$pb.TagNumber(5)
  set outpoint(OutPoint v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOutpoint() => $_has(4);
  @$pb.TagNumber(5)
  void clearOutpoint() => $_clearField(5);
  @$pb.TagNumber(5)
  OutPoint ensureOutpoint() => $_ensure(4);

  /// The number of confirmations for the Utxo
  @$pb.TagNumber(6)
  $fixnum.Int64 get confirmations => $_getI64(5);
  @$pb.TagNumber(6)
  set confirmations($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasConfirmations() => $_has(5);
  @$pb.TagNumber(6)
  void clearConfirmations() => $_clearField(6);
}

class OutputDetail extends $pb.GeneratedMessage {
  factory OutputDetail({
    OutputScriptType? outputType,
    $core.String? address,
    $core.String? pkScript,
    $fixnum.Int64? outputIndex,
    $fixnum.Int64? amount,
    $core.bool? isOurAddress,
  }) {
    final $result = create();
    if (outputType != null) {
      $result.outputType = outputType;
    }
    if (address != null) {
      $result.address = address;
    }
    if (pkScript != null) {
      $result.pkScript = pkScript;
    }
    if (outputIndex != null) {
      $result.outputIndex = outputIndex;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (isOurAddress != null) {
      $result.isOurAddress = isOurAddress;
    }
    return $result;
  }
  OutputDetail._() : super();
  factory OutputDetail.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OutputDetail.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OutputDetail', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<OutputScriptType>(1, _omitFieldNames ? '' : 'outputType', $pb.PbFieldType.OE, defaultOrMaker: OutputScriptType.SCRIPT_TYPE_PUBKEY_HASH, valueOf: OutputScriptType.valueOf, enumValues: OutputScriptType.values)
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOS(3, _omitFieldNames ? '' : 'pkScript')
    ..aInt64(4, _omitFieldNames ? '' : 'outputIndex')
    ..aInt64(5, _omitFieldNames ? '' : 'amount')
    ..aOB(6, _omitFieldNames ? '' : 'isOurAddress')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OutputDetail clone() => OutputDetail()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OutputDetail copyWith(void Function(OutputDetail) updates) => super.copyWith((message) => updates(message as OutputDetail)) as OutputDetail;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OutputDetail create() => OutputDetail._();
  OutputDetail createEmptyInstance() => create();
  static $pb.PbList<OutputDetail> createRepeated() => $pb.PbList<OutputDetail>();
  @$core.pragma('dart2js:noInline')
  static OutputDetail getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutputDetail>(create);
  static OutputDetail? _defaultInstance;

  /// The type of the output
  @$pb.TagNumber(1)
  OutputScriptType get outputType => $_getN(0);
  @$pb.TagNumber(1)
  set outputType(OutputScriptType v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutputType() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutputType() => $_clearField(1);

  /// The address
  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);

  /// The pkscript in hex
  @$pb.TagNumber(3)
  $core.String get pkScript => $_getSZ(2);
  @$pb.TagNumber(3)
  set pkScript($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPkScript() => $_has(2);
  @$pb.TagNumber(3)
  void clearPkScript() => $_clearField(3);

  /// The output index used in the raw transaction
  @$pb.TagNumber(4)
  $fixnum.Int64 get outputIndex => $_getI64(3);
  @$pb.TagNumber(4)
  set outputIndex($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutputIndex() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutputIndex() => $_clearField(4);

  /// The value of the output coin in satoshis
  @$pb.TagNumber(5)
  $fixnum.Int64 get amount => $_getI64(4);
  @$pb.TagNumber(5)
  set amount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmount() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmount() => $_clearField(5);

  /// Denotes if the output is controlled by the internal wallet
  @$pb.TagNumber(6)
  $core.bool get isOurAddress => $_getBF(5);
  @$pb.TagNumber(6)
  set isOurAddress($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsOurAddress() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsOurAddress() => $_clearField(6);
}

class Transaction extends $pb.GeneratedMessage {
  factory Transaction({
    $core.String? txHash,
    $fixnum.Int64? amount,
    $core.int? numConfirmations,
    $core.String? blockHash,
    $core.int? blockHeight,
    $fixnum.Int64? timeStamp,
    $fixnum.Int64? totalFees,
  @$core.Deprecated('This field is deprecated.')
    $core.Iterable<$core.String>? destAddresses,
    $core.String? rawTxHex,
    $core.String? label,
    $core.Iterable<OutputDetail>? outputDetails,
    $core.Iterable<PreviousOutPoint>? previousOutpoints,
  }) {
    final $result = create();
    if (txHash != null) {
      $result.txHash = txHash;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (numConfirmations != null) {
      $result.numConfirmations = numConfirmations;
    }
    if (blockHash != null) {
      $result.blockHash = blockHash;
    }
    if (blockHeight != null) {
      $result.blockHeight = blockHeight;
    }
    if (timeStamp != null) {
      $result.timeStamp = timeStamp;
    }
    if (totalFees != null) {
      $result.totalFees = totalFees;
    }
    if (destAddresses != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.destAddresses.addAll(destAddresses);
    }
    if (rawTxHex != null) {
      $result.rawTxHex = rawTxHex;
    }
    if (label != null) {
      $result.label = label;
    }
    if (outputDetails != null) {
      $result.outputDetails.addAll(outputDetails);
    }
    if (previousOutpoints != null) {
      $result.previousOutpoints.addAll(previousOutpoints);
    }
    return $result;
  }
  Transaction._() : super();
  factory Transaction.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Transaction.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Transaction', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txHash')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'numConfirmations', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'blockHash')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'blockHeight', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'timeStamp')
    ..aInt64(7, _omitFieldNames ? '' : 'totalFees')
    ..pPS(8, _omitFieldNames ? '' : 'destAddresses')
    ..aOS(9, _omitFieldNames ? '' : 'rawTxHex')
    ..aOS(10, _omitFieldNames ? '' : 'label')
    ..pc<OutputDetail>(11, _omitFieldNames ? '' : 'outputDetails', $pb.PbFieldType.PM, subBuilder: OutputDetail.create)
    ..pc<PreviousOutPoint>(12, _omitFieldNames ? '' : 'previousOutpoints', $pb.PbFieldType.PM, subBuilder: PreviousOutPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Transaction clone() => Transaction()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Transaction copyWith(void Function(Transaction) updates) => super.copyWith((message) => updates(message as Transaction)) as Transaction;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Transaction create() => Transaction._();
  Transaction createEmptyInstance() => create();
  static $pb.PbList<Transaction> createRepeated() => $pb.PbList<Transaction>();
  @$core.pragma('dart2js:noInline')
  static Transaction getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Transaction>(create);
  static Transaction? _defaultInstance;

  /// The transaction hash
  @$pb.TagNumber(1)
  $core.String get txHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set txHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxHash() => $_clearField(1);

  /// The transaction amount, denominated in satoshis
  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  /// The number of confirmations
  @$pb.TagNumber(3)
  $core.int get numConfirmations => $_getIZ(2);
  @$pb.TagNumber(3)
  set numConfirmations($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumConfirmations() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumConfirmations() => $_clearField(3);

  /// The hash of the block this transaction was included in
  @$pb.TagNumber(4)
  $core.String get blockHash => $_getSZ(3);
  @$pb.TagNumber(4)
  set blockHash($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBlockHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearBlockHash() => $_clearField(4);

  /// The height of the block this transaction was included in
  @$pb.TagNumber(5)
  $core.int get blockHeight => $_getIZ(4);
  @$pb.TagNumber(5)
  set blockHeight($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBlockHeight() => $_has(4);
  @$pb.TagNumber(5)
  void clearBlockHeight() => $_clearField(5);

  /// Timestamp of this transaction
  @$pb.TagNumber(6)
  $fixnum.Int64 get timeStamp => $_getI64(5);
  @$pb.TagNumber(6)
  set timeStamp($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimeStamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimeStamp() => $_clearField(6);

  /// Fees paid for this transaction
  @$pb.TagNumber(7)
  $fixnum.Int64 get totalFees => $_getI64(6);
  @$pb.TagNumber(7)
  set totalFees($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTotalFees() => $_has(6);
  @$pb.TagNumber(7)
  void clearTotalFees() => $_clearField(7);

  /// Addresses that received funds for this transaction. Deprecated as it is
  /// now incorporated in the output_details field.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get destAddresses => $_getList(7);

  /// The raw transaction hex.
  @$pb.TagNumber(9)
  $core.String get rawTxHex => $_getSZ(8);
  @$pb.TagNumber(9)
  set rawTxHex($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasRawTxHex() => $_has(8);
  @$pb.TagNumber(9)
  void clearRawTxHex() => $_clearField(9);

  /// A label that was optionally set on transaction broadcast.
  @$pb.TagNumber(10)
  $core.String get label => $_getSZ(9);
  @$pb.TagNumber(10)
  set label($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasLabel() => $_has(9);
  @$pb.TagNumber(10)
  void clearLabel() => $_clearField(10);

  /// Outputs that received funds for this transaction
  @$pb.TagNumber(11)
  $pb.PbList<OutputDetail> get outputDetails => $_getList(10);

  /// PreviousOutpoints/Inputs of this transaction.
  @$pb.TagNumber(12)
  $pb.PbList<PreviousOutPoint> get previousOutpoints => $_getList(11);
}

class GetTransactionsRequest extends $pb.GeneratedMessage {
  factory GetTransactionsRequest({
    $core.int? startHeight,
    $core.int? endHeight,
    $core.String? account,
    $core.int? indexOffset,
    $core.int? maxTransactions,
  }) {
    final $result = create();
    if (startHeight != null) {
      $result.startHeight = startHeight;
    }
    if (endHeight != null) {
      $result.endHeight = endHeight;
    }
    if (account != null) {
      $result.account = account;
    }
    if (indexOffset != null) {
      $result.indexOffset = indexOffset;
    }
    if (maxTransactions != null) {
      $result.maxTransactions = maxTransactions;
    }
    return $result;
  }
  GetTransactionsRequest._() : super();
  factory GetTransactionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetTransactionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetTransactionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'startHeight', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'endHeight', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'account')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'indexOffset', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'maxTransactions', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest clone() => GetTransactionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetTransactionsRequest copyWith(void Function(GetTransactionsRequest) updates) => super.copyWith((message) => updates(message as GetTransactionsRequest)) as GetTransactionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest create() => GetTransactionsRequest._();
  GetTransactionsRequest createEmptyInstance() => create();
  static $pb.PbList<GetTransactionsRequest> createRepeated() => $pb.PbList<GetTransactionsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetTransactionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetTransactionsRequest>(create);
  static GetTransactionsRequest? _defaultInstance;

  ///
  /// The height from which to list transactions, inclusive. If this value is
  /// greater than end_height, transactions will be read in reverse.
  @$pb.TagNumber(1)
  $core.int get startHeight => $_getIZ(0);
  @$pb.TagNumber(1)
  set startHeight($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartHeight() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartHeight() => $_clearField(1);

  ///
  /// The height until which to list transactions, inclusive. To include
  /// unconfirmed transactions, this value should be set to -1, which will
  /// return transactions from start_height until the current chain tip and
  /// unconfirmed transactions. If no end_height is provided, the call will
  /// default to this option.
  @$pb.TagNumber(2)
  $core.int get endHeight => $_getIZ(1);
  @$pb.TagNumber(2)
  set endHeight($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndHeight() => $_clearField(2);

  /// An optional filter to only include transactions relevant to an account.
  @$pb.TagNumber(3)
  $core.String get account => $_getSZ(2);
  @$pb.TagNumber(3)
  set account($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);

  ///
  /// The index of a transaction that will be used in a query to determine which
  /// transaction should be returned in the response.
  @$pb.TagNumber(4)
  $core.int get indexOffset => $_getIZ(3);
  @$pb.TagNumber(4)
  set indexOffset($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIndexOffset() => $_has(3);
  @$pb.TagNumber(4)
  void clearIndexOffset() => $_clearField(4);

  ///
  /// The maximal number of transactions returned in the response to this query.
  /// This value should be set to 0 to return all transactions.
  @$pb.TagNumber(5)
  $core.int get maxTransactions => $_getIZ(4);
  @$pb.TagNumber(5)
  set maxTransactions($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaxTransactions() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaxTransactions() => $_clearField(5);
}

class TransactionDetails extends $pb.GeneratedMessage {
  factory TransactionDetails({
    $core.Iterable<Transaction>? transactions,
    $fixnum.Int64? lastIndex,
    $fixnum.Int64? firstIndex,
  }) {
    final $result = create();
    if (transactions != null) {
      $result.transactions.addAll(transactions);
    }
    if (lastIndex != null) {
      $result.lastIndex = lastIndex;
    }
    if (firstIndex != null) {
      $result.firstIndex = firstIndex;
    }
    return $result;
  }
  TransactionDetails._() : super();
  factory TransactionDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransactionDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Transaction>(1, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: Transaction.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'lastIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'firstIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionDetails clone() => TransactionDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionDetails copyWith(void Function(TransactionDetails) updates) => super.copyWith((message) => updates(message as TransactionDetails)) as TransactionDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionDetails create() => TransactionDetails._();
  TransactionDetails createEmptyInstance() => create();
  static $pb.PbList<TransactionDetails> createRepeated() => $pb.PbList<TransactionDetails>();
  @$core.pragma('dart2js:noInline')
  static TransactionDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionDetails>(create);
  static TransactionDetails? _defaultInstance;

  /// The list of transactions relevant to the wallet.
  @$pb.TagNumber(1)
  $pb.PbList<Transaction> get transactions => $_getList(0);

  ///
  /// The index of the last item in the set of returned transactions. This can be
  /// used to seek further, pagination style.
  @$pb.TagNumber(2)
  $fixnum.Int64 get lastIndex => $_getI64(1);
  @$pb.TagNumber(2)
  set lastIndex($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastIndex() => $_clearField(2);

  ///
  /// The index of the last item in the set of returned transactions. This can be
  /// used to seek backwards, pagination style.
  @$pb.TagNumber(3)
  $fixnum.Int64 get firstIndex => $_getI64(2);
  @$pb.TagNumber(3)
  set firstIndex($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstIndex() => $_clearField(3);
}

enum FeeLimit_Limit {
  fixed, 
  percent, 
  fixedMsat, 
  notSet
}

class FeeLimit extends $pb.GeneratedMessage {
  factory FeeLimit({
    $fixnum.Int64? fixed,
    $fixnum.Int64? percent,
    $fixnum.Int64? fixedMsat,
  }) {
    final $result = create();
    if (fixed != null) {
      $result.fixed = fixed;
    }
    if (percent != null) {
      $result.percent = percent;
    }
    if (fixedMsat != null) {
      $result.fixedMsat = fixedMsat;
    }
    return $result;
  }
  FeeLimit._() : super();
  factory FeeLimit.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeeLimit.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, FeeLimit_Limit> _FeeLimit_LimitByTag = {
    1 : FeeLimit_Limit.fixed,
    2 : FeeLimit_Limit.percent,
    3 : FeeLimit_Limit.fixedMsat,
    0 : FeeLimit_Limit.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeeLimit', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aInt64(1, _omitFieldNames ? '' : 'fixed')
    ..aInt64(2, _omitFieldNames ? '' : 'percent')
    ..aInt64(3, _omitFieldNames ? '' : 'fixedMsat')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeeLimit clone() => FeeLimit()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeeLimit copyWith(void Function(FeeLimit) updates) => super.copyWith((message) => updates(message as FeeLimit)) as FeeLimit;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeLimit create() => FeeLimit._();
  FeeLimit createEmptyInstance() => create();
  static $pb.PbList<FeeLimit> createRepeated() => $pb.PbList<FeeLimit>();
  @$core.pragma('dart2js:noInline')
  static FeeLimit getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeeLimit>(create);
  static FeeLimit? _defaultInstance;

  FeeLimit_Limit whichLimit() => _FeeLimit_LimitByTag[$_whichOneof(0)]!;
  void clearLimit() => $_clearField($_whichOneof(0));

  ///
  /// The fee limit expressed as a fixed amount of satoshis.
  ///
  /// The fields fixed and fixed_msat are mutually exclusive.
  @$pb.TagNumber(1)
  $fixnum.Int64 get fixed => $_getI64(0);
  @$pb.TagNumber(1)
  set fixed($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFixed() => $_has(0);
  @$pb.TagNumber(1)
  void clearFixed() => $_clearField(1);

  /// The fee limit expressed as a percentage of the payment amount.
  @$pb.TagNumber(2)
  $fixnum.Int64 get percent => $_getI64(1);
  @$pb.TagNumber(2)
  set percent($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPercent() => $_has(1);
  @$pb.TagNumber(2)
  void clearPercent() => $_clearField(2);

  ///
  /// The fee limit expressed as a fixed amount of millisatoshis.
  ///
  /// The fields fixed and fixed_msat are mutually exclusive.
  @$pb.TagNumber(3)
  $fixnum.Int64 get fixedMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set fixedMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFixedMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFixedMsat() => $_clearField(3);
}

class SendRequest extends $pb.GeneratedMessage {
  factory SendRequest({
    $core.List<$core.int>? dest,
  @$core.Deprecated('This field is deprecated.')
    $core.String? destString,
    $fixnum.Int64? amt,
    $core.List<$core.int>? paymentHash,
  @$core.Deprecated('This field is deprecated.')
    $core.String? paymentHashString,
    $core.String? paymentRequest,
    $core.int? finalCltvDelta,
    FeeLimit? feeLimit,
    $fixnum.Int64? outgoingChanId,
    $core.int? cltvLimit,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? destCustomRecords,
    $fixnum.Int64? amtMsat,
    $core.List<$core.int>? lastHopPubkey,
    $core.bool? allowSelfPayment,
    $core.Iterable<FeatureBit>? destFeatures,
    $core.List<$core.int>? paymentAddr,
  }) {
    final $result = create();
    if (dest != null) {
      $result.dest = dest;
    }
    if (destString != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.destString = destString;
    }
    if (amt != null) {
      $result.amt = amt;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentHashString != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.paymentHashString = paymentHashString;
    }
    if (paymentRequest != null) {
      $result.paymentRequest = paymentRequest;
    }
    if (finalCltvDelta != null) {
      $result.finalCltvDelta = finalCltvDelta;
    }
    if (feeLimit != null) {
      $result.feeLimit = feeLimit;
    }
    if (outgoingChanId != null) {
      $result.outgoingChanId = outgoingChanId;
    }
    if (cltvLimit != null) {
      $result.cltvLimit = cltvLimit;
    }
    if (destCustomRecords != null) {
      $result.destCustomRecords.addAll(destCustomRecords);
    }
    if (amtMsat != null) {
      $result.amtMsat = amtMsat;
    }
    if (lastHopPubkey != null) {
      $result.lastHopPubkey = lastHopPubkey;
    }
    if (allowSelfPayment != null) {
      $result.allowSelfPayment = allowSelfPayment;
    }
    if (destFeatures != null) {
      $result.destFeatures.addAll(destFeatures);
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    return $result;
  }
  SendRequest._() : super();
  factory SendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'dest', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'destString')
    ..aInt64(3, _omitFieldNames ? '' : 'amt')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..aOS(5, _omitFieldNames ? '' : 'paymentHashString')
    ..aOS(6, _omitFieldNames ? '' : 'paymentRequest')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'finalCltvDelta', $pb.PbFieldType.O3)
    ..aOM<FeeLimit>(8, _omitFieldNames ? '' : 'feeLimit', subBuilder: FeeLimit.create)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'outgoingChanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'cltvLimit', $pb.PbFieldType.OU3)
    ..m<$fixnum.Int64, $core.List<$core.int>>(11, _omitFieldNames ? '' : 'destCustomRecords', entryClassName: 'SendRequest.DestCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..aInt64(12, _omitFieldNames ? '' : 'amtMsat')
    ..a<$core.List<$core.int>>(13, _omitFieldNames ? '' : 'lastHopPubkey', $pb.PbFieldType.OY)
    ..aOB(14, _omitFieldNames ? '' : 'allowSelfPayment')
    ..pc<FeatureBit>(15, _omitFieldNames ? '' : 'destFeatures', $pb.PbFieldType.KE, valueOf: FeatureBit.valueOf, enumValues: FeatureBit.values, defaultEnumValue: FeatureBit.DATALOSS_PROTECT_REQ)
    ..a<$core.List<$core.int>>(16, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendRequest clone() => SendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendRequest copyWith(void Function(SendRequest) updates) => super.copyWith((message) => updates(message as SendRequest)) as SendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendRequest create() => SendRequest._();
  SendRequest createEmptyInstance() => create();
  static $pb.PbList<SendRequest> createRepeated() => $pb.PbList<SendRequest>();
  @$core.pragma('dart2js:noInline')
  static SendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendRequest>(create);
  static SendRequest? _defaultInstance;

  ///
  /// The identity pubkey of the payment recipient. When using REST, this field
  /// must be encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get dest => $_getN(0);
  @$pb.TagNumber(1)
  set dest($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDest() => $_has(0);
  @$pb.TagNumber(1)
  void clearDest() => $_clearField(1);

  ///
  /// The hex-encoded identity pubkey of the payment recipient. Deprecated now
  /// that the REST gateway supports base64 encoding of bytes fields.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.String get destString => $_getSZ(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set destString($core.String v) { $_setString(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasDestString() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearDestString() => $_clearField(2);

  ///
  /// The amount to send expressed in satoshis.
  ///
  /// The fields amt and amt_msat are mutually exclusive.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amt => $_getI64(2);
  @$pb.TagNumber(3)
  set amt($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmt() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmt() => $_clearField(3);

  ///
  /// The hash to use within the payment's HTLC. When using REST, this field
  /// must be encoded as base64.
  @$pb.TagNumber(4)
  $core.List<$core.int> get paymentHash => $_getN(3);
  @$pb.TagNumber(4)
  set paymentHash($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentHash() => $_clearField(4);

  ///
  /// The hex-encoded hash to use within the payment's HTLC. Deprecated now
  /// that the REST gateway supports base64 encoding of bytes fields.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $core.String get paymentHashString => $_getSZ(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  set paymentHashString($core.String v) { $_setString(4, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $core.bool hasPaymentHashString() => $_has(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  void clearPaymentHashString() => $_clearField(5);

  ///
  /// A bare-bones invoice for a payment within the Lightning Network. With the
  /// details of the invoice, the sender has all the data necessary to send a
  /// payment to the recipient.
  @$pb.TagNumber(6)
  $core.String get paymentRequest => $_getSZ(5);
  @$pb.TagNumber(6)
  set paymentRequest($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentRequest() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentRequest() => $_clearField(6);

  ///
  /// The CLTV delta from the current height that should be used to set the
  /// timelock for the final hop.
  @$pb.TagNumber(7)
  $core.int get finalCltvDelta => $_getIZ(6);
  @$pb.TagNumber(7)
  set finalCltvDelta($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFinalCltvDelta() => $_has(6);
  @$pb.TagNumber(7)
  void clearFinalCltvDelta() => $_clearField(7);

  ///
  /// The maximum number of satoshis that will be paid as a fee of the payment.
  /// This value can be represented either as a percentage of the amount being
  /// sent, or as a fixed amount of the maximum fee the user is willing the pay to
  /// send the payment. If not specified, lnd will use a default value of 100%
  /// fees for small amounts (<=1k sat) or 5% fees for larger amounts.
  @$pb.TagNumber(8)
  FeeLimit get feeLimit => $_getN(7);
  @$pb.TagNumber(8)
  set feeLimit(FeeLimit v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasFeeLimit() => $_has(7);
  @$pb.TagNumber(8)
  void clearFeeLimit() => $_clearField(8);
  @$pb.TagNumber(8)
  FeeLimit ensureFeeLimit() => $_ensure(7);

  ///
  /// The channel id of the channel that must be taken to the first hop. If zero,
  /// any channel may be used.
  @$pb.TagNumber(9)
  $fixnum.Int64 get outgoingChanId => $_getI64(8);
  @$pb.TagNumber(9)
  set outgoingChanId($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasOutgoingChanId() => $_has(8);
  @$pb.TagNumber(9)
  void clearOutgoingChanId() => $_clearField(9);

  ///
  /// An optional maximum total time lock for the route. This should not exceed
  /// lnd's `--max-cltv-expiry` setting. If zero, then the value of
  /// `--max-cltv-expiry` is enforced.
  @$pb.TagNumber(10)
  $core.int get cltvLimit => $_getIZ(9);
  @$pb.TagNumber(10)
  set cltvLimit($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasCltvLimit() => $_has(9);
  @$pb.TagNumber(10)
  void clearCltvLimit() => $_clearField(10);

  ///
  /// An optional field that can be used to pass an arbitrary set of TLV records
  /// to a peer which understands the new records. This can be used to pass
  /// application specific data during the payment attempt. Record types are
  /// required to be in the custom range >= 65536. When using REST, the values
  /// must be encoded as base64.
  @$pb.TagNumber(11)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get destCustomRecords => $_getMap(10);

  ///
  /// The amount to send expressed in millisatoshis.
  ///
  /// The fields amt and amt_msat are mutually exclusive.
  @$pb.TagNumber(12)
  $fixnum.Int64 get amtMsat => $_getI64(11);
  @$pb.TagNumber(12)
  set amtMsat($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasAmtMsat() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmtMsat() => $_clearField(12);

  ///
  /// The pubkey of the last hop of the route. If empty, any hop may be used.
  @$pb.TagNumber(13)
  $core.List<$core.int> get lastHopPubkey => $_getN(12);
  @$pb.TagNumber(13)
  set lastHopPubkey($core.List<$core.int> v) { $_setBytes(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasLastHopPubkey() => $_has(12);
  @$pb.TagNumber(13)
  void clearLastHopPubkey() => $_clearField(13);

  /// If set, circular payments to self are permitted.
  @$pb.TagNumber(14)
  $core.bool get allowSelfPayment => $_getBF(13);
  @$pb.TagNumber(14)
  set allowSelfPayment($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasAllowSelfPayment() => $_has(13);
  @$pb.TagNumber(14)
  void clearAllowSelfPayment() => $_clearField(14);

  ///
  /// Features assumed to be supported by the final node. All transitive feature
  /// dependencies must also be set properly. For a given feature bit pair, either
  /// optional or remote may be set, but not both. If this field is nil or empty,
  /// the router will try to load destination features from the graph as a
  /// fallback.
  @$pb.TagNumber(15)
  $pb.PbList<FeatureBit> get destFeatures => $_getList(14);

  ///
  /// The payment address of the generated invoice.  This is also called
  /// payment secret in specifications (e.g. BOLT 11).
  @$pb.TagNumber(16)
  $core.List<$core.int> get paymentAddr => $_getN(15);
  @$pb.TagNumber(16)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasPaymentAddr() => $_has(15);
  @$pb.TagNumber(16)
  void clearPaymentAddr() => $_clearField(16);
}

class SendResponse extends $pb.GeneratedMessage {
  factory SendResponse({
    $core.String? paymentError,
    $core.List<$core.int>? paymentPreimage,
    Route? paymentRoute,
    $core.List<$core.int>? paymentHash,
  }) {
    final $result = create();
    if (paymentError != null) {
      $result.paymentError = paymentError;
    }
    if (paymentPreimage != null) {
      $result.paymentPreimage = paymentPreimage;
    }
    if (paymentRoute != null) {
      $result.paymentRoute = paymentRoute;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  SendResponse._() : super();
  factory SendResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentError')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'paymentPreimage', $pb.PbFieldType.OY)
    ..aOM<Route>(3, _omitFieldNames ? '' : 'paymentRoute', subBuilder: Route.create)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendResponse clone() => SendResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendResponse copyWith(void Function(SendResponse) updates) => super.copyWith((message) => updates(message as SendResponse)) as SendResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendResponse create() => SendResponse._();
  SendResponse createEmptyInstance() => create();
  static $pb.PbList<SendResponse> createRepeated() => $pb.PbList<SendResponse>();
  @$core.pragma('dart2js:noInline')
  static SendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendResponse>(create);
  static SendResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentError => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentError($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentError() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentError() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get paymentPreimage => $_getN(1);
  @$pb.TagNumber(2)
  set paymentPreimage($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentPreimage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentPreimage() => $_clearField(2);

  @$pb.TagNumber(3)
  Route get paymentRoute => $_getN(2);
  @$pb.TagNumber(3)
  set paymentRoute(Route v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentRoute() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentRoute() => $_clearField(3);
  @$pb.TagNumber(3)
  Route ensurePaymentRoute() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.List<$core.int> get paymentHash => $_getN(3);
  @$pb.TagNumber(4)
  set paymentHash($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentHash() => $_clearField(4);
}

class SendToRouteRequest extends $pb.GeneratedMessage {
  factory SendToRouteRequest({
    $core.List<$core.int>? paymentHash,
  @$core.Deprecated('This field is deprecated.')
    $core.String? paymentHashString,
    Route? route,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentHashString != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.paymentHashString = paymentHashString;
    }
    if (route != null) {
      $result.route = route;
    }
    return $result;
  }
  SendToRouteRequest._() : super();
  factory SendToRouteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendToRouteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendToRouteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'paymentHashString')
    ..aOM<Route>(4, _omitFieldNames ? '' : 'route', subBuilder: Route.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendToRouteRequest clone() => SendToRouteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendToRouteRequest copyWith(void Function(SendToRouteRequest) updates) => super.copyWith((message) => updates(message as SendToRouteRequest)) as SendToRouteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendToRouteRequest create() => SendToRouteRequest._();
  SendToRouteRequest createEmptyInstance() => create();
  static $pb.PbList<SendToRouteRequest> createRepeated() => $pb.PbList<SendToRouteRequest>();
  @$core.pragma('dart2js:noInline')
  static SendToRouteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendToRouteRequest>(create);
  static SendToRouteRequest? _defaultInstance;

  ///
  /// The payment hash to use for the HTLC. When using REST, this field must be
  /// encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  ///
  /// An optional hex-encoded payment hash to be used for the HTLC. Deprecated now
  /// that the REST gateway supports base64 encoding of bytes fields.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.String get paymentHashString => $_getSZ(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set paymentHashString($core.String v) { $_setString(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasPaymentHashString() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearPaymentHashString() => $_clearField(2);

  /// Route that should be used to attempt to complete the payment.
  @$pb.TagNumber(4)
  Route get route => $_getN(2);
  @$pb.TagNumber(4)
  set route(Route v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRoute() => $_has(2);
  @$pb.TagNumber(4)
  void clearRoute() => $_clearField(4);
  @$pb.TagNumber(4)
  Route ensureRoute() => $_ensure(2);
}

class ChannelAcceptRequest extends $pb.GeneratedMessage {
  factory ChannelAcceptRequest({
    $core.List<$core.int>? nodePubkey,
    $core.List<$core.int>? chainHash,
    $core.List<$core.int>? pendingChanId,
    $fixnum.Int64? fundingAmt,
    $fixnum.Int64? pushAmt,
    $fixnum.Int64? dustLimit,
    $fixnum.Int64? maxValueInFlight,
    $fixnum.Int64? channelReserve,
    $fixnum.Int64? minHtlc,
    $fixnum.Int64? feePerKw,
    $core.int? csvDelay,
    $core.int? maxAcceptedHtlcs,
    $core.int? channelFlags,
    CommitmentType? commitmentType,
    $core.bool? wantsZeroConf,
    $core.bool? wantsScidAlias,
  }) {
    final $result = create();
    if (nodePubkey != null) {
      $result.nodePubkey = nodePubkey;
    }
    if (chainHash != null) {
      $result.chainHash = chainHash;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (fundingAmt != null) {
      $result.fundingAmt = fundingAmt;
    }
    if (pushAmt != null) {
      $result.pushAmt = pushAmt;
    }
    if (dustLimit != null) {
      $result.dustLimit = dustLimit;
    }
    if (maxValueInFlight != null) {
      $result.maxValueInFlight = maxValueInFlight;
    }
    if (channelReserve != null) {
      $result.channelReserve = channelReserve;
    }
    if (minHtlc != null) {
      $result.minHtlc = minHtlc;
    }
    if (feePerKw != null) {
      $result.feePerKw = feePerKw;
    }
    if (csvDelay != null) {
      $result.csvDelay = csvDelay;
    }
    if (maxAcceptedHtlcs != null) {
      $result.maxAcceptedHtlcs = maxAcceptedHtlcs;
    }
    if (channelFlags != null) {
      $result.channelFlags = channelFlags;
    }
    if (commitmentType != null) {
      $result.commitmentType = commitmentType;
    }
    if (wantsZeroConf != null) {
      $result.wantsZeroConf = wantsZeroConf;
    }
    if (wantsScidAlias != null) {
      $result.wantsScidAlias = wantsScidAlias;
    }
    return $result;
  }
  ChannelAcceptRequest._() : super();
  factory ChannelAcceptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelAcceptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelAcceptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'nodePubkey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'chainHash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'fundingAmt', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'pushAmt', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'dustLimit', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'maxValueInFlight', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'channelReserve', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'minHtlc', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'feePerKw', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'csvDelay', $pb.PbFieldType.OU3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'maxAcceptedHtlcs', $pb.PbFieldType.OU3)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'channelFlags', $pb.PbFieldType.OU3)
    ..e<CommitmentType>(14, _omitFieldNames ? '' : 'commitmentType', $pb.PbFieldType.OE, defaultOrMaker: CommitmentType.UNKNOWN_COMMITMENT_TYPE, valueOf: CommitmentType.valueOf, enumValues: CommitmentType.values)
    ..aOB(15, _omitFieldNames ? '' : 'wantsZeroConf')
    ..aOB(16, _omitFieldNames ? '' : 'wantsScidAlias')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelAcceptRequest clone() => ChannelAcceptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelAcceptRequest copyWith(void Function(ChannelAcceptRequest) updates) => super.copyWith((message) => updates(message as ChannelAcceptRequest)) as ChannelAcceptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelAcceptRequest create() => ChannelAcceptRequest._();
  ChannelAcceptRequest createEmptyInstance() => create();
  static $pb.PbList<ChannelAcceptRequest> createRepeated() => $pb.PbList<ChannelAcceptRequest>();
  @$core.pragma('dart2js:noInline')
  static ChannelAcceptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelAcceptRequest>(create);
  static ChannelAcceptRequest? _defaultInstance;

  /// The pubkey of the node that wishes to open an inbound channel.
  @$pb.TagNumber(1)
  $core.List<$core.int> get nodePubkey => $_getN(0);
  @$pb.TagNumber(1)
  set nodePubkey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodePubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodePubkey() => $_clearField(1);

  /// The hash of the genesis block that the proposed channel resides in.
  @$pb.TagNumber(2)
  $core.List<$core.int> get chainHash => $_getN(1);
  @$pb.TagNumber(2)
  set chainHash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChainHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearChainHash() => $_clearField(2);

  /// The pending channel id.
  @$pb.TagNumber(3)
  $core.List<$core.int> get pendingChanId => $_getN(2);
  @$pb.TagNumber(3)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPendingChanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingChanId() => $_clearField(3);

  /// The funding amount in satoshis that initiator wishes to use in the
  /// channel.
  @$pb.TagNumber(4)
  $fixnum.Int64 get fundingAmt => $_getI64(3);
  @$pb.TagNumber(4)
  set fundingAmt($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFundingAmt() => $_has(3);
  @$pb.TagNumber(4)
  void clearFundingAmt() => $_clearField(4);

  /// The push amount of the proposed channel in millisatoshis.
  @$pb.TagNumber(5)
  $fixnum.Int64 get pushAmt => $_getI64(4);
  @$pb.TagNumber(5)
  set pushAmt($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPushAmt() => $_has(4);
  @$pb.TagNumber(5)
  void clearPushAmt() => $_clearField(5);

  /// The dust limit of the initiator's commitment tx.
  @$pb.TagNumber(6)
  $fixnum.Int64 get dustLimit => $_getI64(5);
  @$pb.TagNumber(6)
  set dustLimit($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDustLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearDustLimit() => $_clearField(6);

  /// The maximum amount of coins in millisatoshis that can be pending in this
  /// channel.
  @$pb.TagNumber(7)
  $fixnum.Int64 get maxValueInFlight => $_getI64(6);
  @$pb.TagNumber(7)
  set maxValueInFlight($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxValueInFlight() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxValueInFlight() => $_clearField(7);

  /// The minimum amount of satoshis the initiator requires us to have at all
  /// times.
  @$pb.TagNumber(8)
  $fixnum.Int64 get channelReserve => $_getI64(7);
  @$pb.TagNumber(8)
  set channelReserve($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasChannelReserve() => $_has(7);
  @$pb.TagNumber(8)
  void clearChannelReserve() => $_clearField(8);

  /// The smallest HTLC in millisatoshis that the initiator will accept.
  @$pb.TagNumber(9)
  $fixnum.Int64 get minHtlc => $_getI64(8);
  @$pb.TagNumber(9)
  set minHtlc($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinHtlc() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinHtlc() => $_clearField(9);

  /// The initial fee rate that the initiator suggests for both commitment
  /// transactions.
  @$pb.TagNumber(10)
  $fixnum.Int64 get feePerKw => $_getI64(9);
  @$pb.TagNumber(10)
  set feePerKw($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasFeePerKw() => $_has(9);
  @$pb.TagNumber(10)
  void clearFeePerKw() => $_clearField(10);

  ///
  /// The number of blocks to use for the relative time lock in the pay-to-self
  /// output of both commitment transactions.
  @$pb.TagNumber(11)
  $core.int get csvDelay => $_getIZ(10);
  @$pb.TagNumber(11)
  set csvDelay($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCsvDelay() => $_has(10);
  @$pb.TagNumber(11)
  void clearCsvDelay() => $_clearField(11);

  /// The total number of incoming HTLC's that the initiator will accept.
  @$pb.TagNumber(12)
  $core.int get maxAcceptedHtlcs => $_getIZ(11);
  @$pb.TagNumber(12)
  set maxAcceptedHtlcs($core.int v) { $_setUnsignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMaxAcceptedHtlcs() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaxAcceptedHtlcs() => $_clearField(12);

  /// A bit-field which the initiator uses to specify proposed channel
  /// behavior.
  @$pb.TagNumber(13)
  $core.int get channelFlags => $_getIZ(12);
  @$pb.TagNumber(13)
  set channelFlags($core.int v) { $_setUnsignedInt32(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasChannelFlags() => $_has(12);
  @$pb.TagNumber(13)
  void clearChannelFlags() => $_clearField(13);

  /// The commitment type the initiator wishes to use for the proposed channel.
  @$pb.TagNumber(14)
  CommitmentType get commitmentType => $_getN(13);
  @$pb.TagNumber(14)
  set commitmentType(CommitmentType v) { $_setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasCommitmentType() => $_has(13);
  @$pb.TagNumber(14)
  void clearCommitmentType() => $_clearField(14);

  /// Whether the initiator wants to open a zero-conf channel via the channel
  /// type.
  @$pb.TagNumber(15)
  $core.bool get wantsZeroConf => $_getBF(14);
  @$pb.TagNumber(15)
  set wantsZeroConf($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasWantsZeroConf() => $_has(14);
  @$pb.TagNumber(15)
  void clearWantsZeroConf() => $_clearField(15);

  /// Whether the initiator wants to use the scid-alias channel type. This is
  /// separate from the feature bit.
  @$pb.TagNumber(16)
  $core.bool get wantsScidAlias => $_getBF(15);
  @$pb.TagNumber(16)
  set wantsScidAlias($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasWantsScidAlias() => $_has(15);
  @$pb.TagNumber(16)
  void clearWantsScidAlias() => $_clearField(16);
}

class ChannelAcceptResponse extends $pb.GeneratedMessage {
  factory ChannelAcceptResponse({
    $core.bool? accept,
    $core.List<$core.int>? pendingChanId,
    $core.String? error,
    $core.String? upfrontShutdown,
    $core.int? csvDelay,
    $fixnum.Int64? reserveSat,
    $fixnum.Int64? inFlightMaxMsat,
    $core.int? maxHtlcCount,
    $fixnum.Int64? minHtlcIn,
    $core.int? minAcceptDepth,
    $core.bool? zeroConf,
  }) {
    final $result = create();
    if (accept != null) {
      $result.accept = accept;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (error != null) {
      $result.error = error;
    }
    if (upfrontShutdown != null) {
      $result.upfrontShutdown = upfrontShutdown;
    }
    if (csvDelay != null) {
      $result.csvDelay = csvDelay;
    }
    if (reserveSat != null) {
      $result.reserveSat = reserveSat;
    }
    if (inFlightMaxMsat != null) {
      $result.inFlightMaxMsat = inFlightMaxMsat;
    }
    if (maxHtlcCount != null) {
      $result.maxHtlcCount = maxHtlcCount;
    }
    if (minHtlcIn != null) {
      $result.minHtlcIn = minHtlcIn;
    }
    if (minAcceptDepth != null) {
      $result.minAcceptDepth = minAcceptDepth;
    }
    if (zeroConf != null) {
      $result.zeroConf = zeroConf;
    }
    return $result;
  }
  ChannelAcceptResponse._() : super();
  factory ChannelAcceptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelAcceptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelAcceptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'accept')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..aOS(4, _omitFieldNames ? '' : 'upfrontShutdown')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'csvDelay', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'reserveSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'inFlightMaxMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'maxHtlcCount', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'minHtlcIn', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'minAcceptDepth', $pb.PbFieldType.OU3)
    ..aOB(11, _omitFieldNames ? '' : 'zeroConf')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelAcceptResponse clone() => ChannelAcceptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelAcceptResponse copyWith(void Function(ChannelAcceptResponse) updates) => super.copyWith((message) => updates(message as ChannelAcceptResponse)) as ChannelAcceptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelAcceptResponse create() => ChannelAcceptResponse._();
  ChannelAcceptResponse createEmptyInstance() => create();
  static $pb.PbList<ChannelAcceptResponse> createRepeated() => $pb.PbList<ChannelAcceptResponse>();
  @$core.pragma('dart2js:noInline')
  static ChannelAcceptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelAcceptResponse>(create);
  static ChannelAcceptResponse? _defaultInstance;

  /// Whether or not the client accepts the channel.
  @$pb.TagNumber(1)
  $core.bool get accept => $_getBF(0);
  @$pb.TagNumber(1)
  set accept($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccept() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccept() => $_clearField(1);

  /// The pending channel id to which this response applies.
  @$pb.TagNumber(2)
  $core.List<$core.int> get pendingChanId => $_getN(1);
  @$pb.TagNumber(2)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingChanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingChanId() => $_clearField(2);

  ///
  /// An optional error to send the initiating party to indicate why the channel
  /// was rejected. This field *should not* contain sensitive information, it will
  /// be sent to the initiating party. This field should only be set if accept is
  /// false, the channel will be rejected if an error is set with accept=true
  /// because the meaning of this response is ambiguous. Limited to 500
  /// characters.
  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);

  ///
  /// The upfront shutdown address to use if the initiating peer supports option
  /// upfront shutdown script (see ListPeers for the features supported). Note
  /// that the channel open will fail if this value is set for a peer that does
  /// not support this feature bit.
  @$pb.TagNumber(4)
  $core.String get upfrontShutdown => $_getSZ(3);
  @$pb.TagNumber(4)
  set upfrontShutdown($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUpfrontShutdown() => $_has(3);
  @$pb.TagNumber(4)
  void clearUpfrontShutdown() => $_clearField(4);

  ///
  /// The csv delay (in blocks) that we require for the remote party.
  @$pb.TagNumber(5)
  $core.int get csvDelay => $_getIZ(4);
  @$pb.TagNumber(5)
  set csvDelay($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCsvDelay() => $_has(4);
  @$pb.TagNumber(5)
  void clearCsvDelay() => $_clearField(5);

  ///
  /// The reserve amount in satoshis that we require the remote peer to adhere to.
  /// We require that the remote peer always have some reserve amount allocated to
  /// them so that there is always a disincentive to broadcast old state (if they
  /// hold 0 sats on their side of the channel, there is nothing to lose).
  @$pb.TagNumber(6)
  $fixnum.Int64 get reserveSat => $_getI64(5);
  @$pb.TagNumber(6)
  set reserveSat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReserveSat() => $_has(5);
  @$pb.TagNumber(6)
  void clearReserveSat() => $_clearField(6);

  ///
  /// The maximum amount of funds in millisatoshis that we allow the remote peer
  /// to have in outstanding htlcs.
  @$pb.TagNumber(7)
  $fixnum.Int64 get inFlightMaxMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set inFlightMaxMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInFlightMaxMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearInFlightMaxMsat() => $_clearField(7);

  ///
  /// The maximum number of htlcs that the remote peer can offer us.
  @$pb.TagNumber(8)
  $core.int get maxHtlcCount => $_getIZ(7);
  @$pb.TagNumber(8)
  set maxHtlcCount($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMaxHtlcCount() => $_has(7);
  @$pb.TagNumber(8)
  void clearMaxHtlcCount() => $_clearField(8);

  ///
  /// The minimum value in millisatoshis for incoming htlcs on the channel.
  @$pb.TagNumber(9)
  $fixnum.Int64 get minHtlcIn => $_getI64(8);
  @$pb.TagNumber(9)
  set minHtlcIn($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinHtlcIn() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinHtlcIn() => $_clearField(9);

  ///
  /// The number of confirmations we require before we consider the channel open.
  @$pb.TagNumber(10)
  $core.int get minAcceptDepth => $_getIZ(9);
  @$pb.TagNumber(10)
  set minAcceptDepth($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMinAcceptDepth() => $_has(9);
  @$pb.TagNumber(10)
  void clearMinAcceptDepth() => $_clearField(10);

  ///
  /// Whether the responder wants this to be a zero-conf channel. This will fail
  /// if either side does not have the scid-alias feature bit set. The minimum
  /// depth field must be zero if this is true.
  @$pb.TagNumber(11)
  $core.bool get zeroConf => $_getBF(10);
  @$pb.TagNumber(11)
  set zeroConf($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasZeroConf() => $_has(10);
  @$pb.TagNumber(11)
  void clearZeroConf() => $_clearField(11);
}

enum ChannelPoint_FundingTxid {
  fundingTxidBytes, 
  fundingTxidStr, 
  notSet
}

class ChannelPoint extends $pb.GeneratedMessage {
  factory ChannelPoint({
    $core.List<$core.int>? fundingTxidBytes,
    $core.String? fundingTxidStr,
    $core.int? outputIndex,
  }) {
    final $result = create();
    if (fundingTxidBytes != null) {
      $result.fundingTxidBytes = fundingTxidBytes;
    }
    if (fundingTxidStr != null) {
      $result.fundingTxidStr = fundingTxidStr;
    }
    if (outputIndex != null) {
      $result.outputIndex = outputIndex;
    }
    return $result;
  }
  ChannelPoint._() : super();
  factory ChannelPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ChannelPoint_FundingTxid> _ChannelPoint_FundingTxidByTag = {
    1 : ChannelPoint_FundingTxid.fundingTxidBytes,
    2 : ChannelPoint_FundingTxid.fundingTxidStr,
    0 : ChannelPoint_FundingTxid.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'fundingTxidBytes', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'fundingTxidStr')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'outputIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelPoint clone() => ChannelPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelPoint copyWith(void Function(ChannelPoint) updates) => super.copyWith((message) => updates(message as ChannelPoint)) as ChannelPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelPoint create() => ChannelPoint._();
  ChannelPoint createEmptyInstance() => create();
  static $pb.PbList<ChannelPoint> createRepeated() => $pb.PbList<ChannelPoint>();
  @$core.pragma('dart2js:noInline')
  static ChannelPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelPoint>(create);
  static ChannelPoint? _defaultInstance;

  ChannelPoint_FundingTxid whichFundingTxid() => _ChannelPoint_FundingTxidByTag[$_whichOneof(0)]!;
  void clearFundingTxid() => $_clearField($_whichOneof(0));

  ///
  /// Txid of the funding transaction. When using REST, this field must be
  /// encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get fundingTxidBytes => $_getN(0);
  @$pb.TagNumber(1)
  set fundingTxidBytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFundingTxidBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundingTxidBytes() => $_clearField(1);

  ///
  /// Hex-encoded string representing the byte-reversed hash of the funding
  /// transaction.
  @$pb.TagNumber(2)
  $core.String get fundingTxidStr => $_getSZ(1);
  @$pb.TagNumber(2)
  set fundingTxidStr($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFundingTxidStr() => $_has(1);
  @$pb.TagNumber(2)
  void clearFundingTxidStr() => $_clearField(2);

  /// The index of the output of the funding transaction
  @$pb.TagNumber(3)
  $core.int get outputIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set outputIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutputIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutputIndex() => $_clearField(3);
}

class OutPoint extends $pb.GeneratedMessage {
  factory OutPoint({
    $core.List<$core.int>? txidBytes,
    $core.String? txidStr,
    $core.int? outputIndex,
  }) {
    final $result = create();
    if (txidBytes != null) {
      $result.txidBytes = txidBytes;
    }
    if (txidStr != null) {
      $result.txidStr = txidStr;
    }
    if (outputIndex != null) {
      $result.outputIndex = outputIndex;
    }
    return $result;
  }
  OutPoint._() : super();
  factory OutPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OutPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OutPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'txidBytes', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'txidStr')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'outputIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OutPoint clone() => OutPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OutPoint copyWith(void Function(OutPoint) updates) => super.copyWith((message) => updates(message as OutPoint)) as OutPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OutPoint create() => OutPoint._();
  OutPoint createEmptyInstance() => create();
  static $pb.PbList<OutPoint> createRepeated() => $pb.PbList<OutPoint>();
  @$core.pragma('dart2js:noInline')
  static OutPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutPoint>(create);
  static OutPoint? _defaultInstance;

  /// Raw bytes representing the transaction id.
  @$pb.TagNumber(1)
  $core.List<$core.int> get txidBytes => $_getN(0);
  @$pb.TagNumber(1)
  set txidBytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxidBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxidBytes() => $_clearField(1);

  /// Reversed, hex-encoded string representing the transaction id.
  @$pb.TagNumber(2)
  $core.String get txidStr => $_getSZ(1);
  @$pb.TagNumber(2)
  set txidStr($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTxidStr() => $_has(1);
  @$pb.TagNumber(2)
  void clearTxidStr() => $_clearField(2);

  /// The index of the output on the transaction.
  @$pb.TagNumber(3)
  $core.int get outputIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set outputIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutputIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutputIndex() => $_clearField(3);
}

class PreviousOutPoint extends $pb.GeneratedMessage {
  factory PreviousOutPoint({
    $core.String? outpoint,
    $core.bool? isOurOutput,
  }) {
    final $result = create();
    if (outpoint != null) {
      $result.outpoint = outpoint;
    }
    if (isOurOutput != null) {
      $result.isOurOutput = isOurOutput;
    }
    return $result;
  }
  PreviousOutPoint._() : super();
  factory PreviousOutPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PreviousOutPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PreviousOutPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'outpoint')
    ..aOB(2, _omitFieldNames ? '' : 'isOurOutput')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PreviousOutPoint clone() => PreviousOutPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PreviousOutPoint copyWith(void Function(PreviousOutPoint) updates) => super.copyWith((message) => updates(message as PreviousOutPoint)) as PreviousOutPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PreviousOutPoint create() => PreviousOutPoint._();
  PreviousOutPoint createEmptyInstance() => create();
  static $pb.PbList<PreviousOutPoint> createRepeated() => $pb.PbList<PreviousOutPoint>();
  @$core.pragma('dart2js:noInline')
  static PreviousOutPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PreviousOutPoint>(create);
  static PreviousOutPoint? _defaultInstance;

  /// The outpoint in format txid:n.
  @$pb.TagNumber(1)
  $core.String get outpoint => $_getSZ(0);
  @$pb.TagNumber(1)
  set outpoint($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutpoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutpoint() => $_clearField(1);

  /// Denotes if the outpoint is controlled by the internal wallet.
  /// The flag will only detect p2wkh, np2wkh and p2tr inputs as its own.
  @$pb.TagNumber(2)
  $core.bool get isOurOutput => $_getBF(1);
  @$pb.TagNumber(2)
  set isOurOutput($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsOurOutput() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsOurOutput() => $_clearField(2);
}

class LightningAddress extends $pb.GeneratedMessage {
  factory LightningAddress({
    $core.String? pubkey,
    $core.String? host,
  }) {
    final $result = create();
    if (pubkey != null) {
      $result.pubkey = pubkey;
    }
    if (host != null) {
      $result.host = host;
    }
    return $result;
  }
  LightningAddress._() : super();
  factory LightningAddress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightningAddress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LightningAddress', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubkey')
    ..aOS(2, _omitFieldNames ? '' : 'host')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LightningAddress clone() => LightningAddress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LightningAddress copyWith(void Function(LightningAddress) updates) => super.copyWith((message) => updates(message as LightningAddress)) as LightningAddress;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LightningAddress create() => LightningAddress._();
  LightningAddress createEmptyInstance() => create();
  static $pb.PbList<LightningAddress> createRepeated() => $pb.PbList<LightningAddress>();
  @$core.pragma('dart2js:noInline')
  static LightningAddress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LightningAddress>(create);
  static LightningAddress? _defaultInstance;

  /// The identity pubkey of the Lightning node.
  @$pb.TagNumber(1)
  $core.String get pubkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubkey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubkey() => $_clearField(1);

  /// The network location of the lightning node, e.g. `69.69.69.69:1337` or
  /// `localhost:10011`.
  @$pb.TagNumber(2)
  $core.String get host => $_getSZ(1);
  @$pb.TagNumber(2)
  set host($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHost() => $_has(1);
  @$pb.TagNumber(2)
  void clearHost() => $_clearField(2);
}

class EstimateFeeRequest extends $pb.GeneratedMessage {
  factory EstimateFeeRequest({
    $pb.PbMap<$core.String, $fixnum.Int64>? addrToAmount,
    $core.int? targetConf,
    $core.int? minConfs,
    $core.bool? spendUnconfirmed,
    CoinSelectionStrategy? coinSelectionStrategy,
  }) {
    final $result = create();
    if (addrToAmount != null) {
      $result.addrToAmount.addAll(addrToAmount);
    }
    if (targetConf != null) {
      $result.targetConf = targetConf;
    }
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    if (spendUnconfirmed != null) {
      $result.spendUnconfirmed = spendUnconfirmed;
    }
    if (coinSelectionStrategy != null) {
      $result.coinSelectionStrategy = coinSelectionStrategy;
    }
    return $result;
  }
  EstimateFeeRequest._() : super();
  factory EstimateFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EstimateFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EstimateFeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..m<$core.String, $fixnum.Int64>(1, _omitFieldNames ? '' : 'AddrToAmount', protoName: 'AddrToAmount', entryClassName: 'EstimateFeeRequest.AddrToAmountEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O6, packageName: const $pb.PackageName('lnrpc'))
    ..a<$core.int>(2, _omitFieldNames ? '' : 'targetConf', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..aOB(4, _omitFieldNames ? '' : 'spendUnconfirmed')
    ..e<CoinSelectionStrategy>(5, _omitFieldNames ? '' : 'coinSelectionStrategy', $pb.PbFieldType.OE, defaultOrMaker: CoinSelectionStrategy.STRATEGY_USE_GLOBAL_CONFIG, valueOf: CoinSelectionStrategy.valueOf, enumValues: CoinSelectionStrategy.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EstimateFeeRequest clone() => EstimateFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EstimateFeeRequest copyWith(void Function(EstimateFeeRequest) updates) => super.copyWith((message) => updates(message as EstimateFeeRequest)) as EstimateFeeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EstimateFeeRequest create() => EstimateFeeRequest._();
  EstimateFeeRequest createEmptyInstance() => create();
  static $pb.PbList<EstimateFeeRequest> createRepeated() => $pb.PbList<EstimateFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static EstimateFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EstimateFeeRequest>(create);
  static EstimateFeeRequest? _defaultInstance;

  /// The map from addresses to amounts for the transaction.
  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $fixnum.Int64> get addrToAmount => $_getMap(0);

  /// The target number of blocks that this transaction should be confirmed
  /// by.
  @$pb.TagNumber(2)
  $core.int get targetConf => $_getIZ(1);
  @$pb.TagNumber(2)
  set targetConf($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetConf() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetConf() => $_clearField(2);

  /// The minimum number of confirmations each one of your outputs used for
  /// the transaction must satisfy.
  @$pb.TagNumber(3)
  $core.int get minConfs => $_getIZ(2);
  @$pb.TagNumber(3)
  set minConfs($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMinConfs() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinConfs() => $_clearField(3);

  /// Whether unconfirmed outputs should be used as inputs for the transaction.
  @$pb.TagNumber(4)
  $core.bool get spendUnconfirmed => $_getBF(3);
  @$pb.TagNumber(4)
  set spendUnconfirmed($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSpendUnconfirmed() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpendUnconfirmed() => $_clearField(4);

  /// The strategy to use for selecting coins during fees estimation.
  @$pb.TagNumber(5)
  CoinSelectionStrategy get coinSelectionStrategy => $_getN(4);
  @$pb.TagNumber(5)
  set coinSelectionStrategy(CoinSelectionStrategy v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasCoinSelectionStrategy() => $_has(4);
  @$pb.TagNumber(5)
  void clearCoinSelectionStrategy() => $_clearField(5);
}

class EstimateFeeResponse extends $pb.GeneratedMessage {
  factory EstimateFeeResponse({
    $fixnum.Int64? feeSat,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? feerateSatPerByte,
    $fixnum.Int64? satPerVbyte,
  }) {
    final $result = create();
    if (feeSat != null) {
      $result.feeSat = feeSat;
    }
    if (feerateSatPerByte != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.feerateSatPerByte = feerateSatPerByte;
    }
    if (satPerVbyte != null) {
      $result.satPerVbyte = satPerVbyte;
    }
    return $result;
  }
  EstimateFeeResponse._() : super();
  factory EstimateFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EstimateFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EstimateFeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'feeSat')
    ..aInt64(2, _omitFieldNames ? '' : 'feerateSatPerByte')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'satPerVbyte', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EstimateFeeResponse clone() => EstimateFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EstimateFeeResponse copyWith(void Function(EstimateFeeResponse) updates) => super.copyWith((message) => updates(message as EstimateFeeResponse)) as EstimateFeeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EstimateFeeResponse create() => EstimateFeeResponse._();
  EstimateFeeResponse createEmptyInstance() => create();
  static $pb.PbList<EstimateFeeResponse> createRepeated() => $pb.PbList<EstimateFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static EstimateFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EstimateFeeResponse>(create);
  static EstimateFeeResponse? _defaultInstance;

  /// The total fee in satoshis.
  @$pb.TagNumber(1)
  $fixnum.Int64 get feeSat => $_getI64(0);
  @$pb.TagNumber(1)
  set feeSat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFeeSat() => $_has(0);
  @$pb.TagNumber(1)
  void clearFeeSat() => $_clearField(1);

  /// Deprecated, use sat_per_vbyte.
  /// The fee rate in satoshi/vbyte.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $fixnum.Int64 get feerateSatPerByte => $_getI64(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set feerateSatPerByte($fixnum.Int64 v) { $_setInt64(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasFeerateSatPerByte() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearFeerateSatPerByte() => $_clearField(2);

  /// The fee rate in satoshi/vbyte.
  @$pb.TagNumber(3)
  $fixnum.Int64 get satPerVbyte => $_getI64(2);
  @$pb.TagNumber(3)
  set satPerVbyte($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSatPerVbyte() => $_has(2);
  @$pb.TagNumber(3)
  void clearSatPerVbyte() => $_clearField(3);
}

class SendManyRequest extends $pb.GeneratedMessage {
  factory SendManyRequest({
    $pb.PbMap<$core.String, $fixnum.Int64>? addrToAmount,
    $core.int? targetConf,
    $fixnum.Int64? satPerVbyte,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? satPerByte,
    $core.String? label,
    $core.int? minConfs,
    $core.bool? spendUnconfirmed,
    CoinSelectionStrategy? coinSelectionStrategy,
  }) {
    final $result = create();
    if (addrToAmount != null) {
      $result.addrToAmount.addAll(addrToAmount);
    }
    if (targetConf != null) {
      $result.targetConf = targetConf;
    }
    if (satPerVbyte != null) {
      $result.satPerVbyte = satPerVbyte;
    }
    if (satPerByte != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.satPerByte = satPerByte;
    }
    if (label != null) {
      $result.label = label;
    }
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    if (spendUnconfirmed != null) {
      $result.spendUnconfirmed = spendUnconfirmed;
    }
    if (coinSelectionStrategy != null) {
      $result.coinSelectionStrategy = coinSelectionStrategy;
    }
    return $result;
  }
  SendManyRequest._() : super();
  factory SendManyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendManyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendManyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..m<$core.String, $fixnum.Int64>(1, _omitFieldNames ? '' : 'AddrToAmount', protoName: 'AddrToAmount', entryClassName: 'SendManyRequest.AddrToAmountEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.O6, packageName: const $pb.PackageName('lnrpc'))
    ..a<$core.int>(3, _omitFieldNames ? '' : 'targetConf', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'satPerVbyte', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(5, _omitFieldNames ? '' : 'satPerByte')
    ..aOS(6, _omitFieldNames ? '' : 'label')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..aOB(8, _omitFieldNames ? '' : 'spendUnconfirmed')
    ..e<CoinSelectionStrategy>(9, _omitFieldNames ? '' : 'coinSelectionStrategy', $pb.PbFieldType.OE, defaultOrMaker: CoinSelectionStrategy.STRATEGY_USE_GLOBAL_CONFIG, valueOf: CoinSelectionStrategy.valueOf, enumValues: CoinSelectionStrategy.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendManyRequest clone() => SendManyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendManyRequest copyWith(void Function(SendManyRequest) updates) => super.copyWith((message) => updates(message as SendManyRequest)) as SendManyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendManyRequest create() => SendManyRequest._();
  SendManyRequest createEmptyInstance() => create();
  static $pb.PbList<SendManyRequest> createRepeated() => $pb.PbList<SendManyRequest>();
  @$core.pragma('dart2js:noInline')
  static SendManyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendManyRequest>(create);
  static SendManyRequest? _defaultInstance;

  /// The map from addresses to amounts
  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $fixnum.Int64> get addrToAmount => $_getMap(0);

  /// The target number of blocks that this transaction should be confirmed
  /// by.
  @$pb.TagNumber(3)
  $core.int get targetConf => $_getIZ(1);
  @$pb.TagNumber(3)
  set targetConf($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetConf() => $_has(1);
  @$pb.TagNumber(3)
  void clearTargetConf() => $_clearField(3);

  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// transaction.
  @$pb.TagNumber(4)
  $fixnum.Int64 get satPerVbyte => $_getI64(2);
  @$pb.TagNumber(4)
  set satPerVbyte($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasSatPerVbyte() => $_has(2);
  @$pb.TagNumber(4)
  void clearSatPerVbyte() => $_clearField(4);

  /// Deprecated, use sat_per_vbyte.
  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// transaction.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $fixnum.Int64 get satPerByte => $_getI64(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  set satPerByte($fixnum.Int64 v) { $_setInt64(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $core.bool hasSatPerByte() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  void clearSatPerByte() => $_clearField(5);

  /// An optional label for the transaction, limited to 500 characters.
  @$pb.TagNumber(6)
  $core.String get label => $_getSZ(4);
  @$pb.TagNumber(6)
  set label($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasLabel() => $_has(4);
  @$pb.TagNumber(6)
  void clearLabel() => $_clearField(6);

  /// The minimum number of confirmations each one of your outputs used for
  /// the transaction must satisfy.
  @$pb.TagNumber(7)
  $core.int get minConfs => $_getIZ(5);
  @$pb.TagNumber(7)
  set minConfs($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinConfs() => $_has(5);
  @$pb.TagNumber(7)
  void clearMinConfs() => $_clearField(7);

  /// Whether unconfirmed outputs should be used as inputs for the transaction.
  @$pb.TagNumber(8)
  $core.bool get spendUnconfirmed => $_getBF(6);
  @$pb.TagNumber(8)
  set spendUnconfirmed($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasSpendUnconfirmed() => $_has(6);
  @$pb.TagNumber(8)
  void clearSpendUnconfirmed() => $_clearField(8);

  /// The strategy to use for selecting coins during sending many requests.
  @$pb.TagNumber(9)
  CoinSelectionStrategy get coinSelectionStrategy => $_getN(7);
  @$pb.TagNumber(9)
  set coinSelectionStrategy(CoinSelectionStrategy v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCoinSelectionStrategy() => $_has(7);
  @$pb.TagNumber(9)
  void clearCoinSelectionStrategy() => $_clearField(9);
}

class SendManyResponse extends $pb.GeneratedMessage {
  factory SendManyResponse({
    $core.String? txid,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    return $result;
  }
  SendManyResponse._() : super();
  factory SendManyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendManyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendManyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendManyResponse clone() => SendManyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendManyResponse copyWith(void Function(SendManyResponse) updates) => super.copyWith((message) => updates(message as SendManyResponse)) as SendManyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendManyResponse create() => SendManyResponse._();
  SendManyResponse createEmptyInstance() => create();
  static $pb.PbList<SendManyResponse> createRepeated() => $pb.PbList<SendManyResponse>();
  @$core.pragma('dart2js:noInline')
  static SendManyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendManyResponse>(create);
  static SendManyResponse? _defaultInstance;

  /// The id of the transaction
  @$pb.TagNumber(1)
  $core.String get txid => $_getSZ(0);
  @$pb.TagNumber(1)
  set txid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);
}

class SendCoinsRequest extends $pb.GeneratedMessage {
  factory SendCoinsRequest({
    $core.String? addr,
    $fixnum.Int64? amount,
    $core.int? targetConf,
    $fixnum.Int64? satPerVbyte,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? satPerByte,
    $core.bool? sendAll,
    $core.String? label,
    $core.int? minConfs,
    $core.bool? spendUnconfirmed,
    CoinSelectionStrategy? coinSelectionStrategy,
    $core.Iterable<OutPoint>? outpoints,
  }) {
    final $result = create();
    if (addr != null) {
      $result.addr = addr;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (targetConf != null) {
      $result.targetConf = targetConf;
    }
    if (satPerVbyte != null) {
      $result.satPerVbyte = satPerVbyte;
    }
    if (satPerByte != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.satPerByte = satPerByte;
    }
    if (sendAll != null) {
      $result.sendAll = sendAll;
    }
    if (label != null) {
      $result.label = label;
    }
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    if (spendUnconfirmed != null) {
      $result.spendUnconfirmed = spendUnconfirmed;
    }
    if (coinSelectionStrategy != null) {
      $result.coinSelectionStrategy = coinSelectionStrategy;
    }
    if (outpoints != null) {
      $result.outpoints.addAll(outpoints);
    }
    return $result;
  }
  SendCoinsRequest._() : super();
  factory SendCoinsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendCoinsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendCoinsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'addr')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'targetConf', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'satPerVbyte', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(5, _omitFieldNames ? '' : 'satPerByte')
    ..aOB(6, _omitFieldNames ? '' : 'sendAll')
    ..aOS(7, _omitFieldNames ? '' : 'label')
    ..a<$core.int>(8, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..aOB(9, _omitFieldNames ? '' : 'spendUnconfirmed')
    ..e<CoinSelectionStrategy>(10, _omitFieldNames ? '' : 'coinSelectionStrategy', $pb.PbFieldType.OE, defaultOrMaker: CoinSelectionStrategy.STRATEGY_USE_GLOBAL_CONFIG, valueOf: CoinSelectionStrategy.valueOf, enumValues: CoinSelectionStrategy.values)
    ..pc<OutPoint>(11, _omitFieldNames ? '' : 'outpoints', $pb.PbFieldType.PM, subBuilder: OutPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendCoinsRequest clone() => SendCoinsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendCoinsRequest copyWith(void Function(SendCoinsRequest) updates) => super.copyWith((message) => updates(message as SendCoinsRequest)) as SendCoinsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendCoinsRequest create() => SendCoinsRequest._();
  SendCoinsRequest createEmptyInstance() => create();
  static $pb.PbList<SendCoinsRequest> createRepeated() => $pb.PbList<SendCoinsRequest>();
  @$core.pragma('dart2js:noInline')
  static SendCoinsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCoinsRequest>(create);
  static SendCoinsRequest? _defaultInstance;

  /// The address to send coins to
  @$pb.TagNumber(1)
  $core.String get addr => $_getSZ(0);
  @$pb.TagNumber(1)
  set addr($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddr() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddr() => $_clearField(1);

  /// The amount in satoshis to send
  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  /// The target number of blocks that this transaction should be confirmed
  /// by.
  @$pb.TagNumber(3)
  $core.int get targetConf => $_getIZ(2);
  @$pb.TagNumber(3)
  set targetConf($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetConf() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetConf() => $_clearField(3);

  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// transaction.
  @$pb.TagNumber(4)
  $fixnum.Int64 get satPerVbyte => $_getI64(3);
  @$pb.TagNumber(4)
  set satPerVbyte($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSatPerVbyte() => $_has(3);
  @$pb.TagNumber(4)
  void clearSatPerVbyte() => $_clearField(4);

  /// Deprecated, use sat_per_vbyte.
  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// transaction.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $fixnum.Int64 get satPerByte => $_getI64(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  set satPerByte($fixnum.Int64 v) { $_setInt64(4, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $core.bool hasSatPerByte() => $_has(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  void clearSatPerByte() => $_clearField(5);

  ///
  /// If set, the amount field should be unset. It indicates lnd will send all
  /// wallet coins or all selected coins to the specified address.
  @$pb.TagNumber(6)
  $core.bool get sendAll => $_getBF(5);
  @$pb.TagNumber(6)
  set sendAll($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSendAll() => $_has(5);
  @$pb.TagNumber(6)
  void clearSendAll() => $_clearField(6);

  /// An optional label for the transaction, limited to 500 characters.
  @$pb.TagNumber(7)
  $core.String get label => $_getSZ(6);
  @$pb.TagNumber(7)
  set label($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLabel() => $_has(6);
  @$pb.TagNumber(7)
  void clearLabel() => $_clearField(7);

  /// The minimum number of confirmations each one of your outputs used for
  /// the transaction must satisfy.
  @$pb.TagNumber(8)
  $core.int get minConfs => $_getIZ(7);
  @$pb.TagNumber(8)
  set minConfs($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinConfs() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinConfs() => $_clearField(8);

  /// Whether unconfirmed outputs should be used as inputs for the transaction.
  @$pb.TagNumber(9)
  $core.bool get spendUnconfirmed => $_getBF(8);
  @$pb.TagNumber(9)
  set spendUnconfirmed($core.bool v) { $_setBool(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSpendUnconfirmed() => $_has(8);
  @$pb.TagNumber(9)
  void clearSpendUnconfirmed() => $_clearField(9);

  /// The strategy to use for selecting coins.
  @$pb.TagNumber(10)
  CoinSelectionStrategy get coinSelectionStrategy => $_getN(9);
  @$pb.TagNumber(10)
  set coinSelectionStrategy(CoinSelectionStrategy v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCoinSelectionStrategy() => $_has(9);
  @$pb.TagNumber(10)
  void clearCoinSelectionStrategy() => $_clearField(10);

  /// A list of selected outpoints as inputs for the transaction.
  @$pb.TagNumber(11)
  $pb.PbList<OutPoint> get outpoints => $_getList(10);
}

class SendCoinsResponse extends $pb.GeneratedMessage {
  factory SendCoinsResponse({
    $core.String? txid,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    return $result;
  }
  SendCoinsResponse._() : super();
  factory SendCoinsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendCoinsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendCoinsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendCoinsResponse clone() => SendCoinsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendCoinsResponse copyWith(void Function(SendCoinsResponse) updates) => super.copyWith((message) => updates(message as SendCoinsResponse)) as SendCoinsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendCoinsResponse create() => SendCoinsResponse._();
  SendCoinsResponse createEmptyInstance() => create();
  static $pb.PbList<SendCoinsResponse> createRepeated() => $pb.PbList<SendCoinsResponse>();
  @$core.pragma('dart2js:noInline')
  static SendCoinsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCoinsResponse>(create);
  static SendCoinsResponse? _defaultInstance;

  /// The transaction ID of the transaction
  @$pb.TagNumber(1)
  $core.String get txid => $_getSZ(0);
  @$pb.TagNumber(1)
  set txid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);
}

class ListUnspentRequest extends $pb.GeneratedMessage {
  factory ListUnspentRequest({
    $core.int? minConfs,
    $core.int? maxConfs,
    $core.String? account,
  }) {
    final $result = create();
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    if (maxConfs != null) {
      $result.maxConfs = maxConfs;
    }
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  ListUnspentRequest._() : super();
  factory ListUnspentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListUnspentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListUnspentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'maxConfs', $pb.PbFieldType.O3)
    ..aOS(3, _omitFieldNames ? '' : 'account')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListUnspentRequest clone() => ListUnspentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListUnspentRequest copyWith(void Function(ListUnspentRequest) updates) => super.copyWith((message) => updates(message as ListUnspentRequest)) as ListUnspentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUnspentRequest create() => ListUnspentRequest._();
  ListUnspentRequest createEmptyInstance() => create();
  static $pb.PbList<ListUnspentRequest> createRepeated() => $pb.PbList<ListUnspentRequest>();
  @$core.pragma('dart2js:noInline')
  static ListUnspentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListUnspentRequest>(create);
  static ListUnspentRequest? _defaultInstance;

  /// The minimum number of confirmations to be included.
  @$pb.TagNumber(1)
  $core.int get minConfs => $_getIZ(0);
  @$pb.TagNumber(1)
  set minConfs($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinConfs() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinConfs() => $_clearField(1);

  /// The maximum number of confirmations to be included.
  @$pb.TagNumber(2)
  $core.int get maxConfs => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxConfs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxConfs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxConfs() => $_clearField(2);

  /// An optional filter to only include outputs belonging to an account.
  @$pb.TagNumber(3)
  $core.String get account => $_getSZ(2);
  @$pb.TagNumber(3)
  set account($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAccount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccount() => $_clearField(3);
}

class ListUnspentResponse extends $pb.GeneratedMessage {
  factory ListUnspentResponse({
    $core.Iterable<Utxo>? utxos,
  }) {
    final $result = create();
    if (utxos != null) {
      $result.utxos.addAll(utxos);
    }
    return $result;
  }
  ListUnspentResponse._() : super();
  factory ListUnspentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListUnspentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListUnspentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Utxo>(1, _omitFieldNames ? '' : 'utxos', $pb.PbFieldType.PM, subBuilder: Utxo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListUnspentResponse clone() => ListUnspentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListUnspentResponse copyWith(void Function(ListUnspentResponse) updates) => super.copyWith((message) => updates(message as ListUnspentResponse)) as ListUnspentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListUnspentResponse create() => ListUnspentResponse._();
  ListUnspentResponse createEmptyInstance() => create();
  static $pb.PbList<ListUnspentResponse> createRepeated() => $pb.PbList<ListUnspentResponse>();
  @$core.pragma('dart2js:noInline')
  static ListUnspentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListUnspentResponse>(create);
  static ListUnspentResponse? _defaultInstance;

  /// A list of utxos
  @$pb.TagNumber(1)
  $pb.PbList<Utxo> get utxos => $_getList(0);
}

class NewAddressRequest extends $pb.GeneratedMessage {
  factory NewAddressRequest({
    AddressType? type,
    $core.String? account,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (account != null) {
      $result.account = account;
    }
    return $result;
  }
  NewAddressRequest._() : super();
  factory NewAddressRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewAddressRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NewAddressRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<AddressType>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: AddressType.WITNESS_PUBKEY_HASH, valueOf: AddressType.valueOf, enumValues: AddressType.values)
    ..aOS(2, _omitFieldNames ? '' : 'account')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NewAddressRequest clone() => NewAddressRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NewAddressRequest copyWith(void Function(NewAddressRequest) updates) => super.copyWith((message) => updates(message as NewAddressRequest)) as NewAddressRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewAddressRequest create() => NewAddressRequest._();
  NewAddressRequest createEmptyInstance() => create();
  static $pb.PbList<NewAddressRequest> createRepeated() => $pb.PbList<NewAddressRequest>();
  @$core.pragma('dart2js:noInline')
  static NewAddressRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewAddressRequest>(create);
  static NewAddressRequest? _defaultInstance;

  /// The type of address to generate.
  @$pb.TagNumber(1)
  AddressType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(AddressType v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  ///
  /// The name of the account to generate a new address for. If empty, the
  /// default wallet account is used.
  @$pb.TagNumber(2)
  $core.String get account => $_getSZ(1);
  @$pb.TagNumber(2)
  set account($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccount() => $_clearField(2);
}

class NewAddressResponse extends $pb.GeneratedMessage {
  factory NewAddressResponse({
    $core.String? address,
  }) {
    final $result = create();
    if (address != null) {
      $result.address = address;
    }
    return $result;
  }
  NewAddressResponse._() : super();
  factory NewAddressResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NewAddressResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NewAddressResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NewAddressResponse clone() => NewAddressResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NewAddressResponse copyWith(void Function(NewAddressResponse) updates) => super.copyWith((message) => updates(message as NewAddressResponse)) as NewAddressResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewAddressResponse create() => NewAddressResponse._();
  NewAddressResponse createEmptyInstance() => create();
  static $pb.PbList<NewAddressResponse> createRepeated() => $pb.PbList<NewAddressResponse>();
  @$core.pragma('dart2js:noInline')
  static NewAddressResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NewAddressResponse>(create);
  static NewAddressResponse? _defaultInstance;

  /// The newly generated wallet address
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);
}

class SignMessageRequest extends $pb.GeneratedMessage {
  factory SignMessageRequest({
    $core.List<$core.int>? msg,
    $core.bool? singleHash,
  }) {
    final $result = create();
    if (msg != null) {
      $result.msg = msg;
    }
    if (singleHash != null) {
      $result.singleHash = singleHash;
    }
    return $result;
  }
  SignMessageRequest._() : super();
  factory SignMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'msg', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'singleHash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignMessageRequest clone() => SignMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignMessageRequest copyWith(void Function(SignMessageRequest) updates) => super.copyWith((message) => updates(message as SignMessageRequest)) as SignMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignMessageRequest create() => SignMessageRequest._();
  SignMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SignMessageRequest> createRepeated() => $pb.PbList<SignMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SignMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignMessageRequest>(create);
  static SignMessageRequest? _defaultInstance;

  ///
  /// The message to be signed. When using REST, this field must be encoded as
  /// base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get msg => $_getN(0);
  @$pb.TagNumber(1)
  set msg($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);

  ///
  /// Instead of the default double-SHA256 hashing of the message before signing,
  /// only use one round of hashing instead.
  @$pb.TagNumber(2)
  $core.bool get singleHash => $_getBF(1);
  @$pb.TagNumber(2)
  set singleHash($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSingleHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearSingleHash() => $_clearField(2);
}

class SignMessageResponse extends $pb.GeneratedMessage {
  factory SignMessageResponse({
    $core.String? signature,
  }) {
    final $result = create();
    if (signature != null) {
      $result.signature = signature;
    }
    return $result;
  }
  SignMessageResponse._() : super();
  factory SignMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignMessageResponse clone() => SignMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignMessageResponse copyWith(void Function(SignMessageResponse) updates) => super.copyWith((message) => updates(message as SignMessageResponse)) as SignMessageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignMessageResponse create() => SignMessageResponse._();
  SignMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SignMessageResponse> createRepeated() => $pb.PbList<SignMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SignMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignMessageResponse>(create);
  static SignMessageResponse? _defaultInstance;

  /// The signature for the given message
  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);
}

class VerifyMessageRequest extends $pb.GeneratedMessage {
  factory VerifyMessageRequest({
    $core.List<$core.int>? msg,
    $core.String? signature,
  }) {
    final $result = create();
    if (msg != null) {
      $result.msg = msg;
    }
    if (signature != null) {
      $result.signature = signature;
    }
    return $result;
  }
  VerifyMessageRequest._() : super();
  factory VerifyMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'msg', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyMessageRequest clone() => VerifyMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyMessageRequest copyWith(void Function(VerifyMessageRequest) updates) => super.copyWith((message) => updates(message as VerifyMessageRequest)) as VerifyMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyMessageRequest create() => VerifyMessageRequest._();
  VerifyMessageRequest createEmptyInstance() => create();
  static $pb.PbList<VerifyMessageRequest> createRepeated() => $pb.PbList<VerifyMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifyMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyMessageRequest>(create);
  static VerifyMessageRequest? _defaultInstance;

  ///
  /// The message over which the signature is to be verified. When using REST,
  /// this field must be encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get msg => $_getN(0);
  @$pb.TagNumber(1)
  set msg($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);

  /// The signature to be verified over the given message
  @$pb.TagNumber(2)
  $core.String get signature => $_getSZ(1);
  @$pb.TagNumber(2)
  set signature($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
}

class VerifyMessageResponse extends $pb.GeneratedMessage {
  factory VerifyMessageResponse({
    $core.bool? valid,
    $core.String? pubkey,
  }) {
    final $result = create();
    if (valid != null) {
      $result.valid = valid;
    }
    if (pubkey != null) {
      $result.pubkey = pubkey;
    }
    return $result;
  }
  VerifyMessageResponse._() : super();
  factory VerifyMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..aOS(2, _omitFieldNames ? '' : 'pubkey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyMessageResponse clone() => VerifyMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyMessageResponse copyWith(void Function(VerifyMessageResponse) updates) => super.copyWith((message) => updates(message as VerifyMessageResponse)) as VerifyMessageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyMessageResponse create() => VerifyMessageResponse._();
  VerifyMessageResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyMessageResponse> createRepeated() => $pb.PbList<VerifyMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyMessageResponse>(create);
  static VerifyMessageResponse? _defaultInstance;

  /// Whether the signature was valid over the given message
  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);

  /// The pubkey recovered from the signature
  @$pb.TagNumber(2)
  $core.String get pubkey => $_getSZ(1);
  @$pb.TagNumber(2)
  set pubkey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPubkey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPubkey() => $_clearField(2);
}

class ConnectPeerRequest extends $pb.GeneratedMessage {
  factory ConnectPeerRequest({
    LightningAddress? addr,
    $core.bool? perm,
    $fixnum.Int64? timeout,
  }) {
    final $result = create();
    if (addr != null) {
      $result.addr = addr;
    }
    if (perm != null) {
      $result.perm = perm;
    }
    if (timeout != null) {
      $result.timeout = timeout;
    }
    return $result;
  }
  ConnectPeerRequest._() : super();
  factory ConnectPeerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectPeerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectPeerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<LightningAddress>(1, _omitFieldNames ? '' : 'addr', subBuilder: LightningAddress.create)
    ..aOB(2, _omitFieldNames ? '' : 'perm')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'timeout', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectPeerRequest clone() => ConnectPeerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectPeerRequest copyWith(void Function(ConnectPeerRequest) updates) => super.copyWith((message) => updates(message as ConnectPeerRequest)) as ConnectPeerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectPeerRequest create() => ConnectPeerRequest._();
  ConnectPeerRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectPeerRequest> createRepeated() => $pb.PbList<ConnectPeerRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectPeerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectPeerRequest>(create);
  static ConnectPeerRequest? _defaultInstance;

  ///
  /// Lightning address of the peer to connect to.
  @$pb.TagNumber(1)
  LightningAddress get addr => $_getN(0);
  @$pb.TagNumber(1)
  set addr(LightningAddress v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddr() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddr() => $_clearField(1);
  @$pb.TagNumber(1)
  LightningAddress ensureAddr() => $_ensure(0);

  ///
  /// If set, the daemon will attempt to persistently connect to the target
  /// peer. Otherwise, the call will be synchronous.
  @$pb.TagNumber(2)
  $core.bool get perm => $_getBF(1);
  @$pb.TagNumber(2)
  set perm($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPerm() => $_has(1);
  @$pb.TagNumber(2)
  void clearPerm() => $_clearField(2);

  ///
  /// The connection timeout value (in seconds) for this request. It won't affect
  /// other requests.
  @$pb.TagNumber(3)
  $fixnum.Int64 get timeout => $_getI64(2);
  @$pb.TagNumber(3)
  set timeout($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimeout() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeout() => $_clearField(3);
}

class ConnectPeerResponse extends $pb.GeneratedMessage {
  factory ConnectPeerResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  ConnectPeerResponse._() : super();
  factory ConnectPeerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectPeerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectPeerResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectPeerResponse clone() => ConnectPeerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectPeerResponse copyWith(void Function(ConnectPeerResponse) updates) => super.copyWith((message) => updates(message as ConnectPeerResponse)) as ConnectPeerResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectPeerResponse create() => ConnectPeerResponse._();
  ConnectPeerResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectPeerResponse> createRepeated() => $pb.PbList<ConnectPeerResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectPeerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectPeerResponse>(create);
  static ConnectPeerResponse? _defaultInstance;

  /// The status of the connect operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class DisconnectPeerRequest extends $pb.GeneratedMessage {
  factory DisconnectPeerRequest({
    $core.String? pubKey,
  }) {
    final $result = create();
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    return $result;
  }
  DisconnectPeerRequest._() : super();
  factory DisconnectPeerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectPeerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectPeerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectPeerRequest clone() => DisconnectPeerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectPeerRequest copyWith(void Function(DisconnectPeerRequest) updates) => super.copyWith((message) => updates(message as DisconnectPeerRequest)) as DisconnectPeerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectPeerRequest create() => DisconnectPeerRequest._();
  DisconnectPeerRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectPeerRequest> createRepeated() => $pb.PbList<DisconnectPeerRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectPeerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectPeerRequest>(create);
  static DisconnectPeerRequest? _defaultInstance;

  /// The pubkey of the node to disconnect from
  @$pb.TagNumber(1)
  $core.String get pubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => $_clearField(1);
}

class DisconnectPeerResponse extends $pb.GeneratedMessage {
  factory DisconnectPeerResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  DisconnectPeerResponse._() : super();
  factory DisconnectPeerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectPeerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectPeerResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectPeerResponse clone() => DisconnectPeerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectPeerResponse copyWith(void Function(DisconnectPeerResponse) updates) => super.copyWith((message) => updates(message as DisconnectPeerResponse)) as DisconnectPeerResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectPeerResponse create() => DisconnectPeerResponse._();
  DisconnectPeerResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectPeerResponse> createRepeated() => $pb.PbList<DisconnectPeerResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectPeerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectPeerResponse>(create);
  static DisconnectPeerResponse? _defaultInstance;

  /// The status of the disconnect operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class HTLC extends $pb.GeneratedMessage {
  factory HTLC({
    $core.bool? incoming,
    $fixnum.Int64? amount,
    $core.List<$core.int>? hashLock,
    $core.int? expirationHeight,
    $fixnum.Int64? htlcIndex,
    $fixnum.Int64? forwardingChannel,
    $fixnum.Int64? forwardingHtlcIndex,
    $core.bool? lockedIn,
  }) {
    final $result = create();
    if (incoming != null) {
      $result.incoming = incoming;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (hashLock != null) {
      $result.hashLock = hashLock;
    }
    if (expirationHeight != null) {
      $result.expirationHeight = expirationHeight;
    }
    if (htlcIndex != null) {
      $result.htlcIndex = htlcIndex;
    }
    if (forwardingChannel != null) {
      $result.forwardingChannel = forwardingChannel;
    }
    if (forwardingHtlcIndex != null) {
      $result.forwardingHtlcIndex = forwardingHtlcIndex;
    }
    if (lockedIn != null) {
      $result.lockedIn = lockedIn;
    }
    return $result;
  }
  HTLC._() : super();
  factory HTLC.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HTLC.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HTLC', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'incoming')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'hashLock', $pb.PbFieldType.OY)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'expirationHeight', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'htlcIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'forwardingChannel', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'forwardingHtlcIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(8, _omitFieldNames ? '' : 'lockedIn')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HTLC clone() => HTLC()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HTLC copyWith(void Function(HTLC) updates) => super.copyWith((message) => updates(message as HTLC)) as HTLC;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HTLC create() => HTLC._();
  HTLC createEmptyInstance() => create();
  static $pb.PbList<HTLC> createRepeated() => $pb.PbList<HTLC>();
  @$core.pragma('dart2js:noInline')
  static HTLC getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HTLC>(create);
  static HTLC? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get incoming => $_getBF(0);
  @$pb.TagNumber(1)
  set incoming($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncoming() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncoming() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get hashLock => $_getN(2);
  @$pb.TagNumber(3)
  set hashLock($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHashLock() => $_has(2);
  @$pb.TagNumber(3)
  void clearHashLock() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get expirationHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set expirationHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpirationHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpirationHeight() => $_clearField(4);

  /// Index identifying the htlc on the channel.
  @$pb.TagNumber(5)
  $fixnum.Int64 get htlcIndex => $_getI64(4);
  @$pb.TagNumber(5)
  set htlcIndex($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHtlcIndex() => $_has(4);
  @$pb.TagNumber(5)
  void clearHtlcIndex() => $_clearField(5);

  /// If this HTLC is involved in a forwarding operation, this field indicates
  /// the forwarding channel. For an outgoing htlc, it is the incoming channel.
  /// For an incoming htlc, it is the outgoing channel. When the htlc
  /// originates from this node or this node is the final destination,
  /// forwarding_channel will be zero. The forwarding channel will also be zero
  /// for htlcs that need to be forwarded but don't have a forwarding decision
  /// persisted yet.
  @$pb.TagNumber(6)
  $fixnum.Int64 get forwardingChannel => $_getI64(5);
  @$pb.TagNumber(6)
  set forwardingChannel($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasForwardingChannel() => $_has(5);
  @$pb.TagNumber(6)
  void clearForwardingChannel() => $_clearField(6);

  /// Index identifying the htlc on the forwarding channel.
  @$pb.TagNumber(7)
  $fixnum.Int64 get forwardingHtlcIndex => $_getI64(6);
  @$pb.TagNumber(7)
  set forwardingHtlcIndex($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasForwardingHtlcIndex() => $_has(6);
  @$pb.TagNumber(7)
  void clearForwardingHtlcIndex() => $_clearField(7);

  ///
  /// Whether the HTLC is locked in. An HTLC is considered locked in when the
  /// remote party has sent us the `revoke_and_ack` to irrevocably commit this
  /// HTLC.
  @$pb.TagNumber(8)
  $core.bool get lockedIn => $_getBF(7);
  @$pb.TagNumber(8)
  set lockedIn($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLockedIn() => $_has(7);
  @$pb.TagNumber(8)
  void clearLockedIn() => $_clearField(8);
}

class ChannelConstraints extends $pb.GeneratedMessage {
  factory ChannelConstraints({
    $core.int? csvDelay,
    $fixnum.Int64? chanReserveSat,
    $fixnum.Int64? dustLimitSat,
    $fixnum.Int64? maxPendingAmtMsat,
    $fixnum.Int64? minHtlcMsat,
    $core.int? maxAcceptedHtlcs,
  }) {
    final $result = create();
    if (csvDelay != null) {
      $result.csvDelay = csvDelay;
    }
    if (chanReserveSat != null) {
      $result.chanReserveSat = chanReserveSat;
    }
    if (dustLimitSat != null) {
      $result.dustLimitSat = dustLimitSat;
    }
    if (maxPendingAmtMsat != null) {
      $result.maxPendingAmtMsat = maxPendingAmtMsat;
    }
    if (minHtlcMsat != null) {
      $result.minHtlcMsat = minHtlcMsat;
    }
    if (maxAcceptedHtlcs != null) {
      $result.maxAcceptedHtlcs = maxAcceptedHtlcs;
    }
    return $result;
  }
  ChannelConstraints._() : super();
  factory ChannelConstraints.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelConstraints.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelConstraints', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'csvDelay', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'chanReserveSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'dustLimitSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'maxPendingAmtMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'minHtlcMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'maxAcceptedHtlcs', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelConstraints clone() => ChannelConstraints()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelConstraints copyWith(void Function(ChannelConstraints) updates) => super.copyWith((message) => updates(message as ChannelConstraints)) as ChannelConstraints;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelConstraints create() => ChannelConstraints._();
  ChannelConstraints createEmptyInstance() => create();
  static $pb.PbList<ChannelConstraints> createRepeated() => $pb.PbList<ChannelConstraints>();
  @$core.pragma('dart2js:noInline')
  static ChannelConstraints getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelConstraints>(create);
  static ChannelConstraints? _defaultInstance;

  ///
  /// The CSV delay expressed in relative blocks. If the channel is force closed,
  /// we will need to wait for this many blocks before we can regain our funds.
  @$pb.TagNumber(1)
  $core.int get csvDelay => $_getIZ(0);
  @$pb.TagNumber(1)
  set csvDelay($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCsvDelay() => $_has(0);
  @$pb.TagNumber(1)
  void clearCsvDelay() => $_clearField(1);

  /// The minimum satoshis this node is required to reserve in its balance.
  @$pb.TagNumber(2)
  $fixnum.Int64 get chanReserveSat => $_getI64(1);
  @$pb.TagNumber(2)
  set chanReserveSat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanReserveSat() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanReserveSat() => $_clearField(2);

  /// The dust limit (in satoshis) of the initiator's commitment tx.
  @$pb.TagNumber(3)
  $fixnum.Int64 get dustLimitSat => $_getI64(2);
  @$pb.TagNumber(3)
  set dustLimitSat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDustLimitSat() => $_has(2);
  @$pb.TagNumber(3)
  void clearDustLimitSat() => $_clearField(3);

  /// The maximum amount of coins in millisatoshis that can be pending in this
  /// channel.
  @$pb.TagNumber(4)
  $fixnum.Int64 get maxPendingAmtMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set maxPendingAmtMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxPendingAmtMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxPendingAmtMsat() => $_clearField(4);

  /// The smallest HTLC in millisatoshis that the initiator will accept.
  @$pb.TagNumber(5)
  $fixnum.Int64 get minHtlcMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set minHtlcMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMinHtlcMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinHtlcMsat() => $_clearField(5);

  /// The total number of incoming HTLC's that the initiator will accept.
  @$pb.TagNumber(6)
  $core.int get maxAcceptedHtlcs => $_getIZ(5);
  @$pb.TagNumber(6)
  set maxAcceptedHtlcs($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxAcceptedHtlcs() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxAcceptedHtlcs() => $_clearField(6);
}

class Channel extends $pb.GeneratedMessage {
  factory Channel({
    $core.bool? active,
    $core.String? remotePubkey,
    $core.String? channelPoint,
    $fixnum.Int64? chanId,
    $fixnum.Int64? capacity,
    $fixnum.Int64? localBalance,
    $fixnum.Int64? remoteBalance,
    $fixnum.Int64? commitFee,
    $fixnum.Int64? commitWeight,
    $fixnum.Int64? feePerKw,
    $fixnum.Int64? unsettledBalance,
    $fixnum.Int64? totalSatoshisSent,
    $fixnum.Int64? totalSatoshisReceived,
    $fixnum.Int64? numUpdates,
    $core.Iterable<HTLC>? pendingHtlcs,
  @$core.Deprecated('This field is deprecated.')
    $core.int? csvDelay,
    $core.bool? private,
    $core.bool? initiator,
    $core.String? chanStatusFlags,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? localChanReserveSat,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? remoteChanReserveSat,
  @$core.Deprecated('This field is deprecated.')
    $core.bool? staticRemoteKey,
    $fixnum.Int64? lifetime,
    $fixnum.Int64? uptime,
    $core.String? closeAddress,
    CommitmentType? commitmentType,
    $fixnum.Int64? pushAmountSat,
    $core.int? thawHeight,
    ChannelConstraints? localConstraints,
    ChannelConstraints? remoteConstraints,
    $core.Iterable<$fixnum.Int64>? aliasScids,
    $core.bool? zeroConf,
    $fixnum.Int64? zeroConfConfirmedScid,
    $core.String? peerAlias,
    $fixnum.Int64? peerScidAlias,
    $core.String? memo,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (active != null) {
      $result.active = active;
    }
    if (remotePubkey != null) {
      $result.remotePubkey = remotePubkey;
    }
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (capacity != null) {
      $result.capacity = capacity;
    }
    if (localBalance != null) {
      $result.localBalance = localBalance;
    }
    if (remoteBalance != null) {
      $result.remoteBalance = remoteBalance;
    }
    if (commitFee != null) {
      $result.commitFee = commitFee;
    }
    if (commitWeight != null) {
      $result.commitWeight = commitWeight;
    }
    if (feePerKw != null) {
      $result.feePerKw = feePerKw;
    }
    if (unsettledBalance != null) {
      $result.unsettledBalance = unsettledBalance;
    }
    if (totalSatoshisSent != null) {
      $result.totalSatoshisSent = totalSatoshisSent;
    }
    if (totalSatoshisReceived != null) {
      $result.totalSatoshisReceived = totalSatoshisReceived;
    }
    if (numUpdates != null) {
      $result.numUpdates = numUpdates;
    }
    if (pendingHtlcs != null) {
      $result.pendingHtlcs.addAll(pendingHtlcs);
    }
    if (csvDelay != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.csvDelay = csvDelay;
    }
    if (private != null) {
      $result.private = private;
    }
    if (initiator != null) {
      $result.initiator = initiator;
    }
    if (chanStatusFlags != null) {
      $result.chanStatusFlags = chanStatusFlags;
    }
    if (localChanReserveSat != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.localChanReserveSat = localChanReserveSat;
    }
    if (remoteChanReserveSat != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.remoteChanReserveSat = remoteChanReserveSat;
    }
    if (staticRemoteKey != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.staticRemoteKey = staticRemoteKey;
    }
    if (lifetime != null) {
      $result.lifetime = lifetime;
    }
    if (uptime != null) {
      $result.uptime = uptime;
    }
    if (closeAddress != null) {
      $result.closeAddress = closeAddress;
    }
    if (commitmentType != null) {
      $result.commitmentType = commitmentType;
    }
    if (pushAmountSat != null) {
      $result.pushAmountSat = pushAmountSat;
    }
    if (thawHeight != null) {
      $result.thawHeight = thawHeight;
    }
    if (localConstraints != null) {
      $result.localConstraints = localConstraints;
    }
    if (remoteConstraints != null) {
      $result.remoteConstraints = remoteConstraints;
    }
    if (aliasScids != null) {
      $result.aliasScids.addAll(aliasScids);
    }
    if (zeroConf != null) {
      $result.zeroConf = zeroConf;
    }
    if (zeroConfConfirmedScid != null) {
      $result.zeroConfConfirmedScid = zeroConfConfirmedScid;
    }
    if (peerAlias != null) {
      $result.peerAlias = peerAlias;
    }
    if (peerScidAlias != null) {
      $result.peerScidAlias = peerScidAlias;
    }
    if (memo != null) {
      $result.memo = memo;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  Channel._() : super();
  factory Channel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Channel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Channel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'active')
    ..aOS(2, _omitFieldNames ? '' : 'remotePubkey')
    ..aOS(3, _omitFieldNames ? '' : 'channelPoint')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(5, _omitFieldNames ? '' : 'capacity')
    ..aInt64(6, _omitFieldNames ? '' : 'localBalance')
    ..aInt64(7, _omitFieldNames ? '' : 'remoteBalance')
    ..aInt64(8, _omitFieldNames ? '' : 'commitFee')
    ..aInt64(9, _omitFieldNames ? '' : 'commitWeight')
    ..aInt64(10, _omitFieldNames ? '' : 'feePerKw')
    ..aInt64(11, _omitFieldNames ? '' : 'unsettledBalance')
    ..aInt64(12, _omitFieldNames ? '' : 'totalSatoshisSent')
    ..aInt64(13, _omitFieldNames ? '' : 'totalSatoshisReceived')
    ..a<$fixnum.Int64>(14, _omitFieldNames ? '' : 'numUpdates', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<HTLC>(15, _omitFieldNames ? '' : 'pendingHtlcs', $pb.PbFieldType.PM, subBuilder: HTLC.create)
    ..a<$core.int>(16, _omitFieldNames ? '' : 'csvDelay', $pb.PbFieldType.OU3)
    ..aOB(17, _omitFieldNames ? '' : 'private')
    ..aOB(18, _omitFieldNames ? '' : 'initiator')
    ..aOS(19, _omitFieldNames ? '' : 'chanStatusFlags')
    ..aInt64(20, _omitFieldNames ? '' : 'localChanReserveSat')
    ..aInt64(21, _omitFieldNames ? '' : 'remoteChanReserveSat')
    ..aOB(22, _omitFieldNames ? '' : 'staticRemoteKey')
    ..aInt64(23, _omitFieldNames ? '' : 'lifetime')
    ..aInt64(24, _omitFieldNames ? '' : 'uptime')
    ..aOS(25, _omitFieldNames ? '' : 'closeAddress')
    ..e<CommitmentType>(26, _omitFieldNames ? '' : 'commitmentType', $pb.PbFieldType.OE, defaultOrMaker: CommitmentType.UNKNOWN_COMMITMENT_TYPE, valueOf: CommitmentType.valueOf, enumValues: CommitmentType.values)
    ..a<$fixnum.Int64>(27, _omitFieldNames ? '' : 'pushAmountSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(28, _omitFieldNames ? '' : 'thawHeight', $pb.PbFieldType.OU3)
    ..aOM<ChannelConstraints>(29, _omitFieldNames ? '' : 'localConstraints', subBuilder: ChannelConstraints.create)
    ..aOM<ChannelConstraints>(30, _omitFieldNames ? '' : 'remoteConstraints', subBuilder: ChannelConstraints.create)
    ..p<$fixnum.Int64>(31, _omitFieldNames ? '' : 'aliasScids', $pb.PbFieldType.KU6)
    ..aOB(32, _omitFieldNames ? '' : 'zeroConf')
    ..a<$fixnum.Int64>(33, _omitFieldNames ? '' : 'zeroConfConfirmedScid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(34, _omitFieldNames ? '' : 'peerAlias')
    ..a<$fixnum.Int64>(35, _omitFieldNames ? '' : 'peerScidAlias', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(36, _omitFieldNames ? '' : 'memo')
    ..a<$core.List<$core.int>>(37, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Channel clone() => Channel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Channel copyWith(void Function(Channel) updates) => super.copyWith((message) => updates(message as Channel)) as Channel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Channel create() => Channel._();
  Channel createEmptyInstance() => create();
  static $pb.PbList<Channel> createRepeated() => $pb.PbList<Channel>();
  @$core.pragma('dart2js:noInline')
  static Channel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Channel>(create);
  static Channel? _defaultInstance;

  /// Whether this channel is active or not
  @$pb.TagNumber(1)
  $core.bool get active => $_getBF(0);
  @$pb.TagNumber(1)
  set active($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActive() => $_has(0);
  @$pb.TagNumber(1)
  void clearActive() => $_clearField(1);

  /// The identity pubkey of the remote node
  @$pb.TagNumber(2)
  $core.String get remotePubkey => $_getSZ(1);
  @$pb.TagNumber(2)
  set remotePubkey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRemotePubkey() => $_has(1);
  @$pb.TagNumber(2)
  void clearRemotePubkey() => $_clearField(2);

  ///
  /// The outpoint (txid:index) of the funding transaction. With this value, Bob
  /// will be able to generate a signature for Alice's version of the commitment
  /// transaction.
  @$pb.TagNumber(3)
  $core.String get channelPoint => $_getSZ(2);
  @$pb.TagNumber(3)
  set channelPoint($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelPoint() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelPoint() => $_clearField(3);

  ///
  /// The unique channel ID for the channel. The first 3 bytes are the block
  /// height, the next 3 the index within the block, and the last 2 bytes are the
  /// output index for the channel.
  @$pb.TagNumber(4)
  $fixnum.Int64 get chanId => $_getI64(3);
  @$pb.TagNumber(4)
  set chanId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasChanId() => $_has(3);
  @$pb.TagNumber(4)
  void clearChanId() => $_clearField(4);

  /// The total amount of funds held in this channel
  @$pb.TagNumber(5)
  $fixnum.Int64 get capacity => $_getI64(4);
  @$pb.TagNumber(5)
  set capacity($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCapacity() => $_has(4);
  @$pb.TagNumber(5)
  void clearCapacity() => $_clearField(5);

  /// This node's current balance in this channel
  @$pb.TagNumber(6)
  $fixnum.Int64 get localBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set localBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLocalBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearLocalBalance() => $_clearField(6);

  /// The counterparty's current balance in this channel
  @$pb.TagNumber(7)
  $fixnum.Int64 get remoteBalance => $_getI64(6);
  @$pb.TagNumber(7)
  set remoteBalance($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRemoteBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemoteBalance() => $_clearField(7);

  ///
  /// The amount calculated to be paid in fees for the current set of commitment
  /// transactions. The fee amount is persisted with the channel in order to
  /// allow the fee amount to be removed and recalculated with each channel state
  /// update, including updates that happen after a system restart.
  @$pb.TagNumber(8)
  $fixnum.Int64 get commitFee => $_getI64(7);
  @$pb.TagNumber(8)
  set commitFee($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCommitFee() => $_has(7);
  @$pb.TagNumber(8)
  void clearCommitFee() => $_clearField(8);

  /// The weight of the commitment transaction
  @$pb.TagNumber(9)
  $fixnum.Int64 get commitWeight => $_getI64(8);
  @$pb.TagNumber(9)
  set commitWeight($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCommitWeight() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommitWeight() => $_clearField(9);

  ///
  /// The required number of satoshis per kilo-weight that the requester will pay
  /// at all times, for both the funding transaction and commitment transaction.
  /// This value can later be updated once the channel is open.
  @$pb.TagNumber(10)
  $fixnum.Int64 get feePerKw => $_getI64(9);
  @$pb.TagNumber(10)
  set feePerKw($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasFeePerKw() => $_has(9);
  @$pb.TagNumber(10)
  void clearFeePerKw() => $_clearField(10);

  /// The unsettled balance in this channel
  @$pb.TagNumber(11)
  $fixnum.Int64 get unsettledBalance => $_getI64(10);
  @$pb.TagNumber(11)
  set unsettledBalance($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUnsettledBalance() => $_has(10);
  @$pb.TagNumber(11)
  void clearUnsettledBalance() => $_clearField(11);

  ///
  /// The total number of satoshis we've sent within this channel.
  @$pb.TagNumber(12)
  $fixnum.Int64 get totalSatoshisSent => $_getI64(11);
  @$pb.TagNumber(12)
  set totalSatoshisSent($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTotalSatoshisSent() => $_has(11);
  @$pb.TagNumber(12)
  void clearTotalSatoshisSent() => $_clearField(12);

  ///
  /// The total number of satoshis we've received within this channel.
  @$pb.TagNumber(13)
  $fixnum.Int64 get totalSatoshisReceived => $_getI64(12);
  @$pb.TagNumber(13)
  set totalSatoshisReceived($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasTotalSatoshisReceived() => $_has(12);
  @$pb.TagNumber(13)
  void clearTotalSatoshisReceived() => $_clearField(13);

  ///
  /// The total number of updates conducted within this channel.
  @$pb.TagNumber(14)
  $fixnum.Int64 get numUpdates => $_getI64(13);
  @$pb.TagNumber(14)
  set numUpdates($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasNumUpdates() => $_has(13);
  @$pb.TagNumber(14)
  void clearNumUpdates() => $_clearField(14);

  ///
  /// The list of active, uncleared HTLCs currently pending within the channel.
  @$pb.TagNumber(15)
  $pb.PbList<HTLC> get pendingHtlcs => $_getList(14);

  ///
  /// Deprecated. The CSV delay expressed in relative blocks. If the channel is
  /// force closed, we will need to wait for this many blocks before we can regain
  /// our funds.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  $core.int get csvDelay => $_getIZ(15);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  set csvDelay($core.int v) { $_setUnsignedInt32(15, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  $core.bool hasCsvDelay() => $_has(15);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(16)
  void clearCsvDelay() => $_clearField(16);

  /// Whether this channel is advertised to the network or not.
  @$pb.TagNumber(17)
  $core.bool get private => $_getBF(16);
  @$pb.TagNumber(17)
  set private($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasPrivate() => $_has(16);
  @$pb.TagNumber(17)
  void clearPrivate() => $_clearField(17);

  /// True if we were the ones that created the channel.
  @$pb.TagNumber(18)
  $core.bool get initiator => $_getBF(17);
  @$pb.TagNumber(18)
  set initiator($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasInitiator() => $_has(17);
  @$pb.TagNumber(18)
  void clearInitiator() => $_clearField(18);

  /// A set of flags showing the current state of the channel.
  @$pb.TagNumber(19)
  $core.String get chanStatusFlags => $_getSZ(18);
  @$pb.TagNumber(19)
  set chanStatusFlags($core.String v) { $_setString(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasChanStatusFlags() => $_has(18);
  @$pb.TagNumber(19)
  void clearChanStatusFlags() => $_clearField(19);

  /// Deprecated. The minimum satoshis this node is required to reserve in its
  /// balance.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  $fixnum.Int64 get localChanReserveSat => $_getI64(19);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  set localChanReserveSat($fixnum.Int64 v) { $_setInt64(19, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  $core.bool hasLocalChanReserveSat() => $_has(19);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(20)
  void clearLocalChanReserveSat() => $_clearField(20);

  ///
  /// Deprecated. The minimum satoshis the other node is required to reserve in
  /// its balance.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(21)
  $fixnum.Int64 get remoteChanReserveSat => $_getI64(20);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(21)
  set remoteChanReserveSat($fixnum.Int64 v) { $_setInt64(20, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(21)
  $core.bool hasRemoteChanReserveSat() => $_has(20);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(21)
  void clearRemoteChanReserveSat() => $_clearField(21);

  /// Deprecated. Use commitment_type.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(22)
  $core.bool get staticRemoteKey => $_getBF(21);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(22)
  set staticRemoteKey($core.bool v) { $_setBool(21, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(22)
  $core.bool hasStaticRemoteKey() => $_has(21);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(22)
  void clearStaticRemoteKey() => $_clearField(22);

  ///
  /// The number of seconds that the channel has been monitored by the channel
  /// scoring system. Scores are currently not persisted, so this value may be
  /// less than the lifetime of the channel [EXPERIMENTAL].
  @$pb.TagNumber(23)
  $fixnum.Int64 get lifetime => $_getI64(22);
  @$pb.TagNumber(23)
  set lifetime($fixnum.Int64 v) { $_setInt64(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasLifetime() => $_has(22);
  @$pb.TagNumber(23)
  void clearLifetime() => $_clearField(23);

  ///
  /// The number of seconds that the remote peer has been observed as being online
  /// by the channel scoring system over the lifetime of the channel
  /// [EXPERIMENTAL].
  @$pb.TagNumber(24)
  $fixnum.Int64 get uptime => $_getI64(23);
  @$pb.TagNumber(24)
  set uptime($fixnum.Int64 v) { $_setInt64(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasUptime() => $_has(23);
  @$pb.TagNumber(24)
  void clearUptime() => $_clearField(24);

  ///
  /// Close address is the address that we will enforce payout to on cooperative
  /// close if the channel was opened utilizing option upfront shutdown. This
  /// value can be set on channel open by setting close_address in an open channel
  /// request. If this value is not set, you can still choose a payout address by
  /// cooperatively closing with the delivery_address field set.
  @$pb.TagNumber(25)
  $core.String get closeAddress => $_getSZ(24);
  @$pb.TagNumber(25)
  set closeAddress($core.String v) { $_setString(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasCloseAddress() => $_has(24);
  @$pb.TagNumber(25)
  void clearCloseAddress() => $_clearField(25);

  /// The commitment type used by this channel.
  @$pb.TagNumber(26)
  CommitmentType get commitmentType => $_getN(25);
  @$pb.TagNumber(26)
  set commitmentType(CommitmentType v) { $_setField(26, v); }
  @$pb.TagNumber(26)
  $core.bool hasCommitmentType() => $_has(25);
  @$pb.TagNumber(26)
  void clearCommitmentType() => $_clearField(26);

  ///
  /// The amount that the initiator of the channel optionally pushed to the remote
  /// party on channel open. This amount will be zero if the channel initiator did
  /// not push any funds to the remote peer. If the initiator field is true, we
  /// pushed this amount to our peer, if it is false, the remote peer pushed this
  /// amount to us.
  @$pb.TagNumber(27)
  $fixnum.Int64 get pushAmountSat => $_getI64(26);
  @$pb.TagNumber(27)
  set pushAmountSat($fixnum.Int64 v) { $_setInt64(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasPushAmountSat() => $_has(26);
  @$pb.TagNumber(27)
  void clearPushAmountSat() => $_clearField(27);

  ///
  /// This uint32 indicates if this channel is to be considered 'frozen'. A
  /// frozen channel doest not allow a cooperative channel close by the
  /// initiator. The thaw_height is the height that this restriction stops
  /// applying to the channel. This field is optional, not setting it or using a
  /// value of zero will mean the channel has no additional restrictions. The
  /// height can be interpreted in two ways: as a relative height if the value is
  /// less than 500,000, or as an absolute height otherwise.
  @$pb.TagNumber(28)
  $core.int get thawHeight => $_getIZ(27);
  @$pb.TagNumber(28)
  set thawHeight($core.int v) { $_setUnsignedInt32(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasThawHeight() => $_has(27);
  @$pb.TagNumber(28)
  void clearThawHeight() => $_clearField(28);

  /// List constraints for the local node.
  @$pb.TagNumber(29)
  ChannelConstraints get localConstraints => $_getN(28);
  @$pb.TagNumber(29)
  set localConstraints(ChannelConstraints v) { $_setField(29, v); }
  @$pb.TagNumber(29)
  $core.bool hasLocalConstraints() => $_has(28);
  @$pb.TagNumber(29)
  void clearLocalConstraints() => $_clearField(29);
  @$pb.TagNumber(29)
  ChannelConstraints ensureLocalConstraints() => $_ensure(28);

  /// List constraints for the remote node.
  @$pb.TagNumber(30)
  ChannelConstraints get remoteConstraints => $_getN(29);
  @$pb.TagNumber(30)
  set remoteConstraints(ChannelConstraints v) { $_setField(30, v); }
  @$pb.TagNumber(30)
  $core.bool hasRemoteConstraints() => $_has(29);
  @$pb.TagNumber(30)
  void clearRemoteConstraints() => $_clearField(30);
  @$pb.TagNumber(30)
  ChannelConstraints ensureRemoteConstraints() => $_ensure(29);

  ///
  /// This lists out the set of alias short channel ids that exist for a channel.
  /// This may be empty.
  @$pb.TagNumber(31)
  $pb.PbList<$fixnum.Int64> get aliasScids => $_getList(30);

  /// Whether or not this is a zero-conf channel.
  @$pb.TagNumber(32)
  $core.bool get zeroConf => $_getBF(31);
  @$pb.TagNumber(32)
  set zeroConf($core.bool v) { $_setBool(31, v); }
  @$pb.TagNumber(32)
  $core.bool hasZeroConf() => $_has(31);
  @$pb.TagNumber(32)
  void clearZeroConf() => $_clearField(32);

  /// This is the confirmed / on-chain zero-conf SCID.
  @$pb.TagNumber(33)
  $fixnum.Int64 get zeroConfConfirmedScid => $_getI64(32);
  @$pb.TagNumber(33)
  set zeroConfConfirmedScid($fixnum.Int64 v) { $_setInt64(32, v); }
  @$pb.TagNumber(33)
  $core.bool hasZeroConfConfirmedScid() => $_has(32);
  @$pb.TagNumber(33)
  void clearZeroConfConfirmedScid() => $_clearField(33);

  /// The configured alias name of our peer.
  @$pb.TagNumber(34)
  $core.String get peerAlias => $_getSZ(33);
  @$pb.TagNumber(34)
  set peerAlias($core.String v) { $_setString(33, v); }
  @$pb.TagNumber(34)
  $core.bool hasPeerAlias() => $_has(33);
  @$pb.TagNumber(34)
  void clearPeerAlias() => $_clearField(34);

  /// This is the peer SCID alias.
  @$pb.TagNumber(35)
  $fixnum.Int64 get peerScidAlias => $_getI64(34);
  @$pb.TagNumber(35)
  set peerScidAlias($fixnum.Int64 v) { $_setInt64(34, v); }
  @$pb.TagNumber(35)
  $core.bool hasPeerScidAlias() => $_has(34);
  @$pb.TagNumber(35)
  void clearPeerScidAlias() => $_clearField(35);

  ///
  /// An optional note-to-self to go along with the channel containing some
  /// useful information. This is only ever stored locally and in no way impacts
  /// the channel's operation.
  @$pb.TagNumber(36)
  $core.String get memo => $_getSZ(35);
  @$pb.TagNumber(36)
  set memo($core.String v) { $_setString(35, v); }
  @$pb.TagNumber(36)
  $core.bool hasMemo() => $_has(35);
  @$pb.TagNumber(36)
  void clearMemo() => $_clearField(36);

  ///
  /// Custom channel data that might be populated in custom channels.
  @$pb.TagNumber(37)
  $core.List<$core.int> get customChannelData => $_getN(36);
  @$pb.TagNumber(37)
  set customChannelData($core.List<$core.int> v) { $_setBytes(36, v); }
  @$pb.TagNumber(37)
  $core.bool hasCustomChannelData() => $_has(36);
  @$pb.TagNumber(37)
  void clearCustomChannelData() => $_clearField(37);
}

class ListChannelsRequest extends $pb.GeneratedMessage {
  factory ListChannelsRequest({
    $core.bool? activeOnly,
    $core.bool? inactiveOnly,
    $core.bool? publicOnly,
    $core.bool? privateOnly,
    $core.List<$core.int>? peer,
    $core.bool? peerAliasLookup,
  }) {
    final $result = create();
    if (activeOnly != null) {
      $result.activeOnly = activeOnly;
    }
    if (inactiveOnly != null) {
      $result.inactiveOnly = inactiveOnly;
    }
    if (publicOnly != null) {
      $result.publicOnly = publicOnly;
    }
    if (privateOnly != null) {
      $result.privateOnly = privateOnly;
    }
    if (peer != null) {
      $result.peer = peer;
    }
    if (peerAliasLookup != null) {
      $result.peerAliasLookup = peerAliasLookup;
    }
    return $result;
  }
  ListChannelsRequest._() : super();
  factory ListChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'activeOnly')
    ..aOB(2, _omitFieldNames ? '' : 'inactiveOnly')
    ..aOB(3, _omitFieldNames ? '' : 'publicOnly')
    ..aOB(4, _omitFieldNames ? '' : 'privateOnly')
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'peer', $pb.PbFieldType.OY)
    ..aOB(6, _omitFieldNames ? '' : 'peerAliasLookup')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListChannelsRequest clone() => ListChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListChannelsRequest copyWith(void Function(ListChannelsRequest) updates) => super.copyWith((message) => updates(message as ListChannelsRequest)) as ListChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChannelsRequest create() => ListChannelsRequest._();
  ListChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<ListChannelsRequest> createRepeated() => $pb.PbList<ListChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChannelsRequest>(create);
  static ListChannelsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get activeOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set activeOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasActiveOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearActiveOnly() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get inactiveOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set inactiveOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInactiveOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearInactiveOnly() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get publicOnly => $_getBF(2);
  @$pb.TagNumber(3)
  set publicOnly($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicOnly() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicOnly() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get privateOnly => $_getBF(3);
  @$pb.TagNumber(4)
  set privateOnly($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPrivateOnly() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrivateOnly() => $_clearField(4);

  ///
  /// Filters the response for channels with a target peer's pubkey. If peer is
  /// empty, all channels will be returned.
  @$pb.TagNumber(5)
  $core.List<$core.int> get peer => $_getN(4);
  @$pb.TagNumber(5)
  set peer($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeer() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeer() => $_clearField(5);

  /// Informs the server if the peer alias lookup per channel should be
  /// enabled. It is turned off by default in order to avoid degradation of
  /// performance for existing clients.
  @$pb.TagNumber(6)
  $core.bool get peerAliasLookup => $_getBF(5);
  @$pb.TagNumber(6)
  set peerAliasLookup($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPeerAliasLookup() => $_has(5);
  @$pb.TagNumber(6)
  void clearPeerAliasLookup() => $_clearField(6);
}

class ListChannelsResponse extends $pb.GeneratedMessage {
  factory ListChannelsResponse({
    $core.Iterable<Channel>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  ListChannelsResponse._() : super();
  factory ListChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Channel>(11, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: Channel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListChannelsResponse clone() => ListChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListChannelsResponse copyWith(void Function(ListChannelsResponse) updates) => super.copyWith((message) => updates(message as ListChannelsResponse)) as ListChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChannelsResponse create() => ListChannelsResponse._();
  ListChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<ListChannelsResponse> createRepeated() => $pb.PbList<ListChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChannelsResponse>(create);
  static ListChannelsResponse? _defaultInstance;

  /// The list of active channels
  @$pb.TagNumber(11)
  $pb.PbList<Channel> get channels => $_getList(0);
}

class AliasMap extends $pb.GeneratedMessage {
  factory AliasMap({
    $fixnum.Int64? baseScid,
    $core.Iterable<$fixnum.Int64>? aliases,
  }) {
    final $result = create();
    if (baseScid != null) {
      $result.baseScid = baseScid;
    }
    if (aliases != null) {
      $result.aliases.addAll(aliases);
    }
    return $result;
  }
  AliasMap._() : super();
  factory AliasMap.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AliasMap.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AliasMap', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'baseScid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'aliases', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AliasMap clone() => AliasMap()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AliasMap copyWith(void Function(AliasMap) updates) => super.copyWith((message) => updates(message as AliasMap)) as AliasMap;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AliasMap create() => AliasMap._();
  AliasMap createEmptyInstance() => create();
  static $pb.PbList<AliasMap> createRepeated() => $pb.PbList<AliasMap>();
  @$core.pragma('dart2js:noInline')
  static AliasMap getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AliasMap>(create);
  static AliasMap? _defaultInstance;

  ///
  /// For non-zero-conf channels, this is the confirmed SCID. Otherwise, this is
  /// the first assigned "base" alias.
  @$pb.TagNumber(1)
  $fixnum.Int64 get baseScid => $_getI64(0);
  @$pb.TagNumber(1)
  set baseScid($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBaseScid() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseScid() => $_clearField(1);

  /// The set of all aliases stored for the base SCID.
  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get aliases => $_getList(1);
}

class ListAliasesRequest extends $pb.GeneratedMessage {
  factory ListAliasesRequest() => create();
  ListAliasesRequest._() : super();
  factory ListAliasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListAliasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListAliasesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListAliasesRequest clone() => ListAliasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListAliasesRequest copyWith(void Function(ListAliasesRequest) updates) => super.copyWith((message) => updates(message as ListAliasesRequest)) as ListAliasesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAliasesRequest create() => ListAliasesRequest._();
  ListAliasesRequest createEmptyInstance() => create();
  static $pb.PbList<ListAliasesRequest> createRepeated() => $pb.PbList<ListAliasesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListAliasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAliasesRequest>(create);
  static ListAliasesRequest? _defaultInstance;
}

class ListAliasesResponse extends $pb.GeneratedMessage {
  factory ListAliasesResponse({
    $core.Iterable<AliasMap>? aliasMaps,
  }) {
    final $result = create();
    if (aliasMaps != null) {
      $result.aliasMaps.addAll(aliasMaps);
    }
    return $result;
  }
  ListAliasesResponse._() : super();
  factory ListAliasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListAliasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListAliasesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<AliasMap>(1, _omitFieldNames ? '' : 'aliasMaps', $pb.PbFieldType.PM, subBuilder: AliasMap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListAliasesResponse clone() => ListAliasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListAliasesResponse copyWith(void Function(ListAliasesResponse) updates) => super.copyWith((message) => updates(message as ListAliasesResponse)) as ListAliasesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListAliasesResponse create() => ListAliasesResponse._();
  ListAliasesResponse createEmptyInstance() => create();
  static $pb.PbList<ListAliasesResponse> createRepeated() => $pb.PbList<ListAliasesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListAliasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListAliasesResponse>(create);
  static ListAliasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<AliasMap> get aliasMaps => $_getList(0);
}

class ChannelCloseSummary extends $pb.GeneratedMessage {
  factory ChannelCloseSummary({
    $core.String? channelPoint,
    $fixnum.Int64? chanId,
    $core.String? chainHash,
    $core.String? closingTxHash,
    $core.String? remotePubkey,
    $fixnum.Int64? capacity,
    $core.int? closeHeight,
    $fixnum.Int64? settledBalance,
    $fixnum.Int64? timeLockedBalance,
    ChannelCloseSummary_ClosureType? closeType,
    Initiator? openInitiator,
    Initiator? closeInitiator,
    $core.Iterable<Resolution>? resolutions,
    $core.Iterable<$fixnum.Int64>? aliasScids,
    $fixnum.Int64? zeroConfConfirmedScid,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (chainHash != null) {
      $result.chainHash = chainHash;
    }
    if (closingTxHash != null) {
      $result.closingTxHash = closingTxHash;
    }
    if (remotePubkey != null) {
      $result.remotePubkey = remotePubkey;
    }
    if (capacity != null) {
      $result.capacity = capacity;
    }
    if (closeHeight != null) {
      $result.closeHeight = closeHeight;
    }
    if (settledBalance != null) {
      $result.settledBalance = settledBalance;
    }
    if (timeLockedBalance != null) {
      $result.timeLockedBalance = timeLockedBalance;
    }
    if (closeType != null) {
      $result.closeType = closeType;
    }
    if (openInitiator != null) {
      $result.openInitiator = openInitiator;
    }
    if (closeInitiator != null) {
      $result.closeInitiator = closeInitiator;
    }
    if (resolutions != null) {
      $result.resolutions.addAll(resolutions);
    }
    if (aliasScids != null) {
      $result.aliasScids.addAll(aliasScids);
    }
    if (zeroConfConfirmedScid != null) {
      $result.zeroConfConfirmedScid = zeroConfConfirmedScid;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  ChannelCloseSummary._() : super();
  factory ChannelCloseSummary.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelCloseSummary.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelCloseSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelPoint')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'chainHash')
    ..aOS(4, _omitFieldNames ? '' : 'closingTxHash')
    ..aOS(5, _omitFieldNames ? '' : 'remotePubkey')
    ..aInt64(6, _omitFieldNames ? '' : 'capacity')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'closeHeight', $pb.PbFieldType.OU3)
    ..aInt64(8, _omitFieldNames ? '' : 'settledBalance')
    ..aInt64(9, _omitFieldNames ? '' : 'timeLockedBalance')
    ..e<ChannelCloseSummary_ClosureType>(10, _omitFieldNames ? '' : 'closeType', $pb.PbFieldType.OE, defaultOrMaker: ChannelCloseSummary_ClosureType.COOPERATIVE_CLOSE, valueOf: ChannelCloseSummary_ClosureType.valueOf, enumValues: ChannelCloseSummary_ClosureType.values)
    ..e<Initiator>(11, _omitFieldNames ? '' : 'openInitiator', $pb.PbFieldType.OE, defaultOrMaker: Initiator.INITIATOR_UNKNOWN, valueOf: Initiator.valueOf, enumValues: Initiator.values)
    ..e<Initiator>(12, _omitFieldNames ? '' : 'closeInitiator', $pb.PbFieldType.OE, defaultOrMaker: Initiator.INITIATOR_UNKNOWN, valueOf: Initiator.valueOf, enumValues: Initiator.values)
    ..pc<Resolution>(13, _omitFieldNames ? '' : 'resolutions', $pb.PbFieldType.PM, subBuilder: Resolution.create)
    ..p<$fixnum.Int64>(14, _omitFieldNames ? '' : 'aliasScids', $pb.PbFieldType.KU6)
    ..a<$fixnum.Int64>(15, _omitFieldNames ? '' : 'zeroConfConfirmedScid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(16, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelCloseSummary clone() => ChannelCloseSummary()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelCloseSummary copyWith(void Function(ChannelCloseSummary) updates) => super.copyWith((message) => updates(message as ChannelCloseSummary)) as ChannelCloseSummary;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelCloseSummary create() => ChannelCloseSummary._();
  ChannelCloseSummary createEmptyInstance() => create();
  static $pb.PbList<ChannelCloseSummary> createRepeated() => $pb.PbList<ChannelCloseSummary>();
  @$core.pragma('dart2js:noInline')
  static ChannelCloseSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelCloseSummary>(create);
  static ChannelCloseSummary? _defaultInstance;

  /// The outpoint (txid:index) of the funding transaction.
  @$pb.TagNumber(1)
  $core.String get channelPoint => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelPoint($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelPoint() => $_clearField(1);

  /// The unique channel ID for the channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get chanId => $_getI64(1);
  @$pb.TagNumber(2)
  set chanId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanId() => $_clearField(2);

  /// The hash of the genesis block that this channel resides within.
  @$pb.TagNumber(3)
  $core.String get chainHash => $_getSZ(2);
  @$pb.TagNumber(3)
  set chainHash($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChainHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearChainHash() => $_clearField(3);

  /// The txid of the transaction which ultimately closed this channel.
  @$pb.TagNumber(4)
  $core.String get closingTxHash => $_getSZ(3);
  @$pb.TagNumber(4)
  set closingTxHash($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasClosingTxHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearClosingTxHash() => $_clearField(4);

  /// Public key of the remote peer that we formerly had a channel with.
  @$pb.TagNumber(5)
  $core.String get remotePubkey => $_getSZ(4);
  @$pb.TagNumber(5)
  set remotePubkey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRemotePubkey() => $_has(4);
  @$pb.TagNumber(5)
  void clearRemotePubkey() => $_clearField(5);

  /// Total capacity of the channel.
  @$pb.TagNumber(6)
  $fixnum.Int64 get capacity => $_getI64(5);
  @$pb.TagNumber(6)
  set capacity($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCapacity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCapacity() => $_clearField(6);

  /// Height at which the funding transaction was spent.
  @$pb.TagNumber(7)
  $core.int get closeHeight => $_getIZ(6);
  @$pb.TagNumber(7)
  set closeHeight($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCloseHeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearCloseHeight() => $_clearField(7);

  /// Settled balance at the time of channel closure
  @$pb.TagNumber(8)
  $fixnum.Int64 get settledBalance => $_getI64(7);
  @$pb.TagNumber(8)
  set settledBalance($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSettledBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearSettledBalance() => $_clearField(8);

  /// The sum of all the time-locked outputs at the time of channel closure
  @$pb.TagNumber(9)
  $fixnum.Int64 get timeLockedBalance => $_getI64(8);
  @$pb.TagNumber(9)
  set timeLockedBalance($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTimeLockedBalance() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimeLockedBalance() => $_clearField(9);

  /// Details on how the channel was closed.
  @$pb.TagNumber(10)
  ChannelCloseSummary_ClosureType get closeType => $_getN(9);
  @$pb.TagNumber(10)
  set closeType(ChannelCloseSummary_ClosureType v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCloseType() => $_has(9);
  @$pb.TagNumber(10)
  void clearCloseType() => $_clearField(10);

  ///
  /// Open initiator is the party that initiated opening the channel. Note that
  /// this value may be unknown if the channel was closed before we migrated to
  /// store open channel information after close.
  @$pb.TagNumber(11)
  Initiator get openInitiator => $_getN(10);
  @$pb.TagNumber(11)
  set openInitiator(Initiator v) { $_setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasOpenInitiator() => $_has(10);
  @$pb.TagNumber(11)
  void clearOpenInitiator() => $_clearField(11);

  ///
  /// Close initiator indicates which party initiated the close. This value will
  /// be unknown for channels that were cooperatively closed before we started
  /// tracking cooperative close initiators. Note that this indicates which party
  /// initiated a close, and it is possible for both to initiate cooperative or
  /// force closes, although only one party's close will be confirmed on chain.
  @$pb.TagNumber(12)
  Initiator get closeInitiator => $_getN(11);
  @$pb.TagNumber(12)
  set closeInitiator(Initiator v) { $_setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasCloseInitiator() => $_has(11);
  @$pb.TagNumber(12)
  void clearCloseInitiator() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbList<Resolution> get resolutions => $_getList(12);

  ///
  /// This lists out the set of alias short channel ids that existed for the
  /// closed channel. This may be empty.
  @$pb.TagNumber(14)
  $pb.PbList<$fixnum.Int64> get aliasScids => $_getList(13);

  /// The confirmed SCID for a zero-conf channel.
  @$pb.TagNumber(15)
  $fixnum.Int64 get zeroConfConfirmedScid => $_getI64(14);
  @$pb.TagNumber(15)
  set zeroConfConfirmedScid($fixnum.Int64 v) { $_setInt64(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasZeroConfConfirmedScid() => $_has(14);
  @$pb.TagNumber(15)
  void clearZeroConfConfirmedScid() => $_clearField(15);

  /// The TLV encoded custom channel data records for this output, which might
  /// be set for custom channels.
  @$pb.TagNumber(16)
  $core.List<$core.int> get customChannelData => $_getN(15);
  @$pb.TagNumber(16)
  set customChannelData($core.List<$core.int> v) { $_setBytes(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasCustomChannelData() => $_has(15);
  @$pb.TagNumber(16)
  void clearCustomChannelData() => $_clearField(16);
}

class Resolution extends $pb.GeneratedMessage {
  factory Resolution({
    ResolutionType? resolutionType,
    ResolutionOutcome? outcome,
    OutPoint? outpoint,
    $fixnum.Int64? amountSat,
    $core.String? sweepTxid,
  }) {
    final $result = create();
    if (resolutionType != null) {
      $result.resolutionType = resolutionType;
    }
    if (outcome != null) {
      $result.outcome = outcome;
    }
    if (outpoint != null) {
      $result.outpoint = outpoint;
    }
    if (amountSat != null) {
      $result.amountSat = amountSat;
    }
    if (sweepTxid != null) {
      $result.sweepTxid = sweepTxid;
    }
    return $result;
  }
  Resolution._() : super();
  factory Resolution.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Resolution.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Resolution', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<ResolutionType>(1, _omitFieldNames ? '' : 'resolutionType', $pb.PbFieldType.OE, defaultOrMaker: ResolutionType.TYPE_UNKNOWN, valueOf: ResolutionType.valueOf, enumValues: ResolutionType.values)
    ..e<ResolutionOutcome>(2, _omitFieldNames ? '' : 'outcome', $pb.PbFieldType.OE, defaultOrMaker: ResolutionOutcome.OUTCOME_UNKNOWN, valueOf: ResolutionOutcome.valueOf, enumValues: ResolutionOutcome.values)
    ..aOM<OutPoint>(3, _omitFieldNames ? '' : 'outpoint', subBuilder: OutPoint.create)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'amountSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(5, _omitFieldNames ? '' : 'sweepTxid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Resolution clone() => Resolution()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Resolution copyWith(void Function(Resolution) updates) => super.copyWith((message) => updates(message as Resolution)) as Resolution;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Resolution create() => Resolution._();
  Resolution createEmptyInstance() => create();
  static $pb.PbList<Resolution> createRepeated() => $pb.PbList<Resolution>();
  @$core.pragma('dart2js:noInline')
  static Resolution getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Resolution>(create);
  static Resolution? _defaultInstance;

  /// The type of output we are resolving.
  @$pb.TagNumber(1)
  ResolutionType get resolutionType => $_getN(0);
  @$pb.TagNumber(1)
  set resolutionType(ResolutionType v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasResolutionType() => $_has(0);
  @$pb.TagNumber(1)
  void clearResolutionType() => $_clearField(1);

  /// The outcome of our on chain action that resolved the outpoint.
  @$pb.TagNumber(2)
  ResolutionOutcome get outcome => $_getN(1);
  @$pb.TagNumber(2)
  set outcome(ResolutionOutcome v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutcome() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutcome() => $_clearField(2);

  /// The outpoint that was spent by the resolution.
  @$pb.TagNumber(3)
  OutPoint get outpoint => $_getN(2);
  @$pb.TagNumber(3)
  set outpoint(OutPoint v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutpoint() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutpoint() => $_clearField(3);
  @$pb.TagNumber(3)
  OutPoint ensureOutpoint() => $_ensure(2);

  /// The amount that was claimed by the resolution.
  @$pb.TagNumber(4)
  $fixnum.Int64 get amountSat => $_getI64(3);
  @$pb.TagNumber(4)
  set amountSat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountSat() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountSat() => $_clearField(4);

  /// The hex-encoded transaction ID of the sweep transaction that spent the
  /// output.
  @$pb.TagNumber(5)
  $core.String get sweepTxid => $_getSZ(4);
  @$pb.TagNumber(5)
  set sweepTxid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSweepTxid() => $_has(4);
  @$pb.TagNumber(5)
  void clearSweepTxid() => $_clearField(5);
}

class ClosedChannelsRequest extends $pb.GeneratedMessage {
  factory ClosedChannelsRequest({
    $core.bool? cooperative,
    $core.bool? localForce,
    $core.bool? remoteForce,
    $core.bool? breach,
    $core.bool? fundingCanceled,
    $core.bool? abandoned,
  }) {
    final $result = create();
    if (cooperative != null) {
      $result.cooperative = cooperative;
    }
    if (localForce != null) {
      $result.localForce = localForce;
    }
    if (remoteForce != null) {
      $result.remoteForce = remoteForce;
    }
    if (breach != null) {
      $result.breach = breach;
    }
    if (fundingCanceled != null) {
      $result.fundingCanceled = fundingCanceled;
    }
    if (abandoned != null) {
      $result.abandoned = abandoned;
    }
    return $result;
  }
  ClosedChannelsRequest._() : super();
  factory ClosedChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClosedChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClosedChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'cooperative')
    ..aOB(2, _omitFieldNames ? '' : 'localForce')
    ..aOB(3, _omitFieldNames ? '' : 'remoteForce')
    ..aOB(4, _omitFieldNames ? '' : 'breach')
    ..aOB(5, _omitFieldNames ? '' : 'fundingCanceled')
    ..aOB(6, _omitFieldNames ? '' : 'abandoned')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClosedChannelsRequest clone() => ClosedChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClosedChannelsRequest copyWith(void Function(ClosedChannelsRequest) updates) => super.copyWith((message) => updates(message as ClosedChannelsRequest)) as ClosedChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClosedChannelsRequest create() => ClosedChannelsRequest._();
  ClosedChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<ClosedChannelsRequest> createRepeated() => $pb.PbList<ClosedChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static ClosedChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClosedChannelsRequest>(create);
  static ClosedChannelsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get cooperative => $_getBF(0);
  @$pb.TagNumber(1)
  set cooperative($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCooperative() => $_has(0);
  @$pb.TagNumber(1)
  void clearCooperative() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get localForce => $_getBF(1);
  @$pb.TagNumber(2)
  set localForce($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocalForce() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocalForce() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get remoteForce => $_getBF(2);
  @$pb.TagNumber(3)
  set remoteForce($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemoteForce() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemoteForce() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get breach => $_getBF(3);
  @$pb.TagNumber(4)
  set breach($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasBreach() => $_has(3);
  @$pb.TagNumber(4)
  void clearBreach() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get fundingCanceled => $_getBF(4);
  @$pb.TagNumber(5)
  set fundingCanceled($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFundingCanceled() => $_has(4);
  @$pb.TagNumber(5)
  void clearFundingCanceled() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get abandoned => $_getBF(5);
  @$pb.TagNumber(6)
  set abandoned($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAbandoned() => $_has(5);
  @$pb.TagNumber(6)
  void clearAbandoned() => $_clearField(6);
}

class ClosedChannelsResponse extends $pb.GeneratedMessage {
  factory ClosedChannelsResponse({
    $core.Iterable<ChannelCloseSummary>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  ClosedChannelsResponse._() : super();
  factory ClosedChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClosedChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClosedChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<ChannelCloseSummary>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: ChannelCloseSummary.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClosedChannelsResponse clone() => ClosedChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClosedChannelsResponse copyWith(void Function(ClosedChannelsResponse) updates) => super.copyWith((message) => updates(message as ClosedChannelsResponse)) as ClosedChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClosedChannelsResponse create() => ClosedChannelsResponse._();
  ClosedChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<ClosedChannelsResponse> createRepeated() => $pb.PbList<ClosedChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static ClosedChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClosedChannelsResponse>(create);
  static ClosedChannelsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ChannelCloseSummary> get channels => $_getList(0);
}

class Peer extends $pb.GeneratedMessage {
  factory Peer({
    $core.String? pubKey,
    $core.String? address,
    $fixnum.Int64? bytesSent,
    $fixnum.Int64? bytesRecv,
    $fixnum.Int64? satSent,
    $fixnum.Int64? satRecv,
    $core.bool? inbound,
    $fixnum.Int64? pingTime,
    Peer_SyncType? syncType,
    $pb.PbMap<$core.int, Feature>? features,
    $core.Iterable<TimestampedError>? errors,
    $core.int? flapCount,
    $fixnum.Int64? lastFlapNs,
    $core.List<$core.int>? lastPingPayload,
  }) {
    final $result = create();
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    if (address != null) {
      $result.address = address;
    }
    if (bytesSent != null) {
      $result.bytesSent = bytesSent;
    }
    if (bytesRecv != null) {
      $result.bytesRecv = bytesRecv;
    }
    if (satSent != null) {
      $result.satSent = satSent;
    }
    if (satRecv != null) {
      $result.satRecv = satRecv;
    }
    if (inbound != null) {
      $result.inbound = inbound;
    }
    if (pingTime != null) {
      $result.pingTime = pingTime;
    }
    if (syncType != null) {
      $result.syncType = syncType;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (errors != null) {
      $result.errors.addAll(errors);
    }
    if (flapCount != null) {
      $result.flapCount = flapCount;
    }
    if (lastFlapNs != null) {
      $result.lastFlapNs = lastFlapNs;
    }
    if (lastPingPayload != null) {
      $result.lastPingPayload = lastPingPayload;
    }
    return $result;
  }
  Peer._() : super();
  factory Peer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Peer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Peer', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubKey')
    ..aOS(3, _omitFieldNames ? '' : 'address')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'bytesSent', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'bytesRecv', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(6, _omitFieldNames ? '' : 'satSent')
    ..aInt64(7, _omitFieldNames ? '' : 'satRecv')
    ..aOB(8, _omitFieldNames ? '' : 'inbound')
    ..aInt64(9, _omitFieldNames ? '' : 'pingTime')
    ..e<Peer_SyncType>(10, _omitFieldNames ? '' : 'syncType', $pb.PbFieldType.OE, defaultOrMaker: Peer_SyncType.UNKNOWN_SYNC, valueOf: Peer_SyncType.valueOf, enumValues: Peer_SyncType.values)
    ..m<$core.int, Feature>(11, _omitFieldNames ? '' : 'features', entryClassName: 'Peer.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..pc<TimestampedError>(12, _omitFieldNames ? '' : 'errors', $pb.PbFieldType.PM, subBuilder: TimestampedError.create)
    ..a<$core.int>(13, _omitFieldNames ? '' : 'flapCount', $pb.PbFieldType.O3)
    ..aInt64(14, _omitFieldNames ? '' : 'lastFlapNs')
    ..a<$core.List<$core.int>>(15, _omitFieldNames ? '' : 'lastPingPayload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Peer clone() => Peer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Peer copyWith(void Function(Peer) updates) => super.copyWith((message) => updates(message as Peer)) as Peer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Peer create() => Peer._();
  Peer createEmptyInstance() => create();
  static $pb.PbList<Peer> createRepeated() => $pb.PbList<Peer>();
  @$core.pragma('dart2js:noInline')
  static Peer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Peer>(create);
  static Peer? _defaultInstance;

  /// The identity pubkey of the peer
  @$pb.TagNumber(1)
  $core.String get pubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => $_clearField(1);

  /// Network address of the peer; eg `127.0.0.1:10011`
  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(3)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(3)
  void clearAddress() => $_clearField(3);

  /// Bytes of data transmitted to this peer
  @$pb.TagNumber(4)
  $fixnum.Int64 get bytesSent => $_getI64(2);
  @$pb.TagNumber(4)
  set bytesSent($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasBytesSent() => $_has(2);
  @$pb.TagNumber(4)
  void clearBytesSent() => $_clearField(4);

  /// Bytes of data transmitted from this peer
  @$pb.TagNumber(5)
  $fixnum.Int64 get bytesRecv => $_getI64(3);
  @$pb.TagNumber(5)
  set bytesRecv($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasBytesRecv() => $_has(3);
  @$pb.TagNumber(5)
  void clearBytesRecv() => $_clearField(5);

  /// Satoshis sent to this peer
  @$pb.TagNumber(6)
  $fixnum.Int64 get satSent => $_getI64(4);
  @$pb.TagNumber(6)
  set satSent($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasSatSent() => $_has(4);
  @$pb.TagNumber(6)
  void clearSatSent() => $_clearField(6);

  /// Satoshis received from this peer
  @$pb.TagNumber(7)
  $fixnum.Int64 get satRecv => $_getI64(5);
  @$pb.TagNumber(7)
  set satRecv($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasSatRecv() => $_has(5);
  @$pb.TagNumber(7)
  void clearSatRecv() => $_clearField(7);

  /// A channel is inbound if the counterparty initiated the channel
  @$pb.TagNumber(8)
  $core.bool get inbound => $_getBF(6);
  @$pb.TagNumber(8)
  set inbound($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasInbound() => $_has(6);
  @$pb.TagNumber(8)
  void clearInbound() => $_clearField(8);

  /// Ping time to this peer
  @$pb.TagNumber(9)
  $fixnum.Int64 get pingTime => $_getI64(7);
  @$pb.TagNumber(9)
  set pingTime($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasPingTime() => $_has(7);
  @$pb.TagNumber(9)
  void clearPingTime() => $_clearField(9);

  /// The type of sync we are currently performing with this peer.
  @$pb.TagNumber(10)
  Peer_SyncType get syncType => $_getN(8);
  @$pb.TagNumber(10)
  set syncType(Peer_SyncType v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasSyncType() => $_has(8);
  @$pb.TagNumber(10)
  void clearSyncType() => $_clearField(10);

  /// Features advertised by the remote peer in their init message.
  @$pb.TagNumber(11)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(9);

  ///
  /// The latest errors received from our peer with timestamps, limited to the 10
  /// most recent errors. These errors are tracked across peer connections, but
  /// are not persisted across lnd restarts. Note that these errors are only
  /// stored for peers that we have channels open with, to prevent peers from
  /// spamming us with errors at no cost.
  @$pb.TagNumber(12)
  $pb.PbList<TimestampedError> get errors => $_getList(10);

  ///
  /// The number of times we have recorded this peer going offline or coming
  /// online, recorded across restarts. Note that this value is decreased over
  /// time if the peer has not recently flapped, so that we can forgive peers
  /// with historically high flap counts.
  @$pb.TagNumber(13)
  $core.int get flapCount => $_getIZ(11);
  @$pb.TagNumber(13)
  set flapCount($core.int v) { $_setSignedInt32(11, v); }
  @$pb.TagNumber(13)
  $core.bool hasFlapCount() => $_has(11);
  @$pb.TagNumber(13)
  void clearFlapCount() => $_clearField(13);

  ///
  /// The timestamp of the last flap we observed for this peer. If this value is
  /// zero, we have not observed any flaps for this peer.
  @$pb.TagNumber(14)
  $fixnum.Int64 get lastFlapNs => $_getI64(12);
  @$pb.TagNumber(14)
  set lastFlapNs($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(14)
  $core.bool hasLastFlapNs() => $_has(12);
  @$pb.TagNumber(14)
  void clearLastFlapNs() => $_clearField(14);

  ///
  /// The last ping payload the peer has sent to us.
  @$pb.TagNumber(15)
  $core.List<$core.int> get lastPingPayload => $_getN(13);
  @$pb.TagNumber(15)
  set lastPingPayload($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(15)
  $core.bool hasLastPingPayload() => $_has(13);
  @$pb.TagNumber(15)
  void clearLastPingPayload() => $_clearField(15);
}

class TimestampedError extends $pb.GeneratedMessage {
  factory TimestampedError({
    $fixnum.Int64? timestamp,
    $core.String? error,
  }) {
    final $result = create();
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (error != null) {
      $result.error = error;
    }
    return $result;
  }
  TimestampedError._() : super();
  factory TimestampedError.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimestampedError.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimestampedError', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'error')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimestampedError clone() => TimestampedError()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimestampedError copyWith(void Function(TimestampedError) updates) => super.copyWith((message) => updates(message as TimestampedError)) as TimestampedError;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimestampedError create() => TimestampedError._();
  TimestampedError createEmptyInstance() => create();
  static $pb.PbList<TimestampedError> createRepeated() => $pb.PbList<TimestampedError>();
  @$core.pragma('dart2js:noInline')
  static TimestampedError getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimestampedError>(create);
  static TimestampedError? _defaultInstance;

  /// The unix timestamp in seconds when the error occurred.
  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);

  /// The string representation of the error sent by our peer.
  @$pb.TagNumber(2)
  $core.String get error => $_getSZ(1);
  @$pb.TagNumber(2)
  set error($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
}

class ListPeersRequest extends $pb.GeneratedMessage {
  factory ListPeersRequest({
    $core.bool? latestError,
  }) {
    final $result = create();
    if (latestError != null) {
      $result.latestError = latestError;
    }
    return $result;
  }
  ListPeersRequest._() : super();
  factory ListPeersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPeersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPeersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'latestError')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPeersRequest clone() => ListPeersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPeersRequest copyWith(void Function(ListPeersRequest) updates) => super.copyWith((message) => updates(message as ListPeersRequest)) as ListPeersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPeersRequest create() => ListPeersRequest._();
  ListPeersRequest createEmptyInstance() => create();
  static $pb.PbList<ListPeersRequest> createRepeated() => $pb.PbList<ListPeersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPeersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPeersRequest>(create);
  static ListPeersRequest? _defaultInstance;

  ///
  /// If true, only the last error that our peer sent us will be returned with
  /// the peer's information, rather than the full set of historic errors we have
  /// stored.
  @$pb.TagNumber(1)
  $core.bool get latestError => $_getBF(0);
  @$pb.TagNumber(1)
  set latestError($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatestError() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatestError() => $_clearField(1);
}

class ListPeersResponse extends $pb.GeneratedMessage {
  factory ListPeersResponse({
    $core.Iterable<Peer>? peers,
  }) {
    final $result = create();
    if (peers != null) {
      $result.peers.addAll(peers);
    }
    return $result;
  }
  ListPeersResponse._() : super();
  factory ListPeersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPeersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPeersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Peer>(1, _omitFieldNames ? '' : 'peers', $pb.PbFieldType.PM, subBuilder: Peer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPeersResponse clone() => ListPeersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPeersResponse copyWith(void Function(ListPeersResponse) updates) => super.copyWith((message) => updates(message as ListPeersResponse)) as ListPeersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPeersResponse create() => ListPeersResponse._();
  ListPeersResponse createEmptyInstance() => create();
  static $pb.PbList<ListPeersResponse> createRepeated() => $pb.PbList<ListPeersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPeersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPeersResponse>(create);
  static ListPeersResponse? _defaultInstance;

  /// The list of currently connected peers
  @$pb.TagNumber(1)
  $pb.PbList<Peer> get peers => $_getList(0);
}

class PeerEventSubscription extends $pb.GeneratedMessage {
  factory PeerEventSubscription() => create();
  PeerEventSubscription._() : super();
  factory PeerEventSubscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PeerEventSubscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PeerEventSubscription', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PeerEventSubscription clone() => PeerEventSubscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PeerEventSubscription copyWith(void Function(PeerEventSubscription) updates) => super.copyWith((message) => updates(message as PeerEventSubscription)) as PeerEventSubscription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PeerEventSubscription create() => PeerEventSubscription._();
  PeerEventSubscription createEmptyInstance() => create();
  static $pb.PbList<PeerEventSubscription> createRepeated() => $pb.PbList<PeerEventSubscription>();
  @$core.pragma('dart2js:noInline')
  static PeerEventSubscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PeerEventSubscription>(create);
  static PeerEventSubscription? _defaultInstance;
}

class PeerEvent extends $pb.GeneratedMessage {
  factory PeerEvent({
    $core.String? pubKey,
    PeerEvent_EventType? type,
  }) {
    final $result = create();
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    if (type != null) {
      $result.type = type;
    }
    return $result;
  }
  PeerEvent._() : super();
  factory PeerEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PeerEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PeerEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubKey')
    ..e<PeerEvent_EventType>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: PeerEvent_EventType.PEER_ONLINE, valueOf: PeerEvent_EventType.valueOf, enumValues: PeerEvent_EventType.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PeerEvent clone() => PeerEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PeerEvent copyWith(void Function(PeerEvent) updates) => super.copyWith((message) => updates(message as PeerEvent)) as PeerEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PeerEvent create() => PeerEvent._();
  PeerEvent createEmptyInstance() => create();
  static $pb.PbList<PeerEvent> createRepeated() => $pb.PbList<PeerEvent>();
  @$core.pragma('dart2js:noInline')
  static PeerEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PeerEvent>(create);
  static PeerEvent? _defaultInstance;

  /// The identity pubkey of the peer.
  @$pb.TagNumber(1)
  $core.String get pubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => $_clearField(1);

  @$pb.TagNumber(2)
  PeerEvent_EventType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(PeerEvent_EventType v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);
}

class GetInfoRequest extends $pb.GeneratedMessage {
  factory GetInfoRequest() => create();
  GetInfoRequest._() : super();
  factory GetInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInfoRequest clone() => GetInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInfoRequest copyWith(void Function(GetInfoRequest) updates) => super.copyWith((message) => updates(message as GetInfoRequest)) as GetInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInfoRequest create() => GetInfoRequest._();
  GetInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetInfoRequest> createRepeated() => $pb.PbList<GetInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInfoRequest>(create);
  static GetInfoRequest? _defaultInstance;
}

class GetInfoResponse extends $pb.GeneratedMessage {
  factory GetInfoResponse({
    $core.String? identityPubkey,
    $core.String? alias,
    $core.int? numPendingChannels,
    $core.int? numActiveChannels,
    $core.int? numPeers,
    $core.int? blockHeight,
    $core.String? blockHash,
    $core.bool? syncedToChain,
  @$core.Deprecated('This field is deprecated.')
    $core.bool? testnet,
    $core.Iterable<$core.String>? uris,
    $fixnum.Int64? bestHeaderTimestamp,
    $core.String? version,
    $core.int? numInactiveChannels,
    $core.Iterable<Chain>? chains,
    $core.String? color,
    $core.bool? syncedToGraph,
    $pb.PbMap<$core.int, Feature>? features,
    $core.String? commitHash,
    $core.bool? requireHtlcInterceptor,
    $core.bool? storeFinalHtlcResolutions,
  }) {
    final $result = create();
    if (identityPubkey != null) {
      $result.identityPubkey = identityPubkey;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    if (numPendingChannels != null) {
      $result.numPendingChannels = numPendingChannels;
    }
    if (numActiveChannels != null) {
      $result.numActiveChannels = numActiveChannels;
    }
    if (numPeers != null) {
      $result.numPeers = numPeers;
    }
    if (blockHeight != null) {
      $result.blockHeight = blockHeight;
    }
    if (blockHash != null) {
      $result.blockHash = blockHash;
    }
    if (syncedToChain != null) {
      $result.syncedToChain = syncedToChain;
    }
    if (testnet != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.testnet = testnet;
    }
    if (uris != null) {
      $result.uris.addAll(uris);
    }
    if (bestHeaderTimestamp != null) {
      $result.bestHeaderTimestamp = bestHeaderTimestamp;
    }
    if (version != null) {
      $result.version = version;
    }
    if (numInactiveChannels != null) {
      $result.numInactiveChannels = numInactiveChannels;
    }
    if (chains != null) {
      $result.chains.addAll(chains);
    }
    if (color != null) {
      $result.color = color;
    }
    if (syncedToGraph != null) {
      $result.syncedToGraph = syncedToGraph;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (commitHash != null) {
      $result.commitHash = commitHash;
    }
    if (requireHtlcInterceptor != null) {
      $result.requireHtlcInterceptor = requireHtlcInterceptor;
    }
    if (storeFinalHtlcResolutions != null) {
      $result.storeFinalHtlcResolutions = storeFinalHtlcResolutions;
    }
    return $result;
  }
  GetInfoResponse._() : super();
  factory GetInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'identityPubkey')
    ..aOS(2, _omitFieldNames ? '' : 'alias')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'numPendingChannels', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'numActiveChannels', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'numPeers', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'blockHeight', $pb.PbFieldType.OU3)
    ..aOS(8, _omitFieldNames ? '' : 'blockHash')
    ..aOB(9, _omitFieldNames ? '' : 'syncedToChain')
    ..aOB(10, _omitFieldNames ? '' : 'testnet')
    ..pPS(12, _omitFieldNames ? '' : 'uris')
    ..aInt64(13, _omitFieldNames ? '' : 'bestHeaderTimestamp')
    ..aOS(14, _omitFieldNames ? '' : 'version')
    ..a<$core.int>(15, _omitFieldNames ? '' : 'numInactiveChannels', $pb.PbFieldType.OU3)
    ..pc<Chain>(16, _omitFieldNames ? '' : 'chains', $pb.PbFieldType.PM, subBuilder: Chain.create)
    ..aOS(17, _omitFieldNames ? '' : 'color')
    ..aOB(18, _omitFieldNames ? '' : 'syncedToGraph')
    ..m<$core.int, Feature>(19, _omitFieldNames ? '' : 'features', entryClassName: 'GetInfoResponse.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..aOS(20, _omitFieldNames ? '' : 'commitHash')
    ..aOB(21, _omitFieldNames ? '' : 'requireHtlcInterceptor')
    ..aOB(22, _omitFieldNames ? '' : 'storeFinalHtlcResolutions')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetInfoResponse clone() => GetInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetInfoResponse copyWith(void Function(GetInfoResponse) updates) => super.copyWith((message) => updates(message as GetInfoResponse)) as GetInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetInfoResponse create() => GetInfoResponse._();
  GetInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetInfoResponse> createRepeated() => $pb.PbList<GetInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetInfoResponse>(create);
  static GetInfoResponse? _defaultInstance;

  /// The identity pubkey of the current node.
  @$pb.TagNumber(1)
  $core.String get identityPubkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set identityPubkey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIdentityPubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearIdentityPubkey() => $_clearField(1);

  /// If applicable, the alias of the current node, e.g. "bob"
  @$pb.TagNumber(2)
  $core.String get alias => $_getSZ(1);
  @$pb.TagNumber(2)
  set alias($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlias() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlias() => $_clearField(2);

  /// Number of pending channels
  @$pb.TagNumber(3)
  $core.int get numPendingChannels => $_getIZ(2);
  @$pb.TagNumber(3)
  set numPendingChannels($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumPendingChannels() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumPendingChannels() => $_clearField(3);

  /// Number of active channels
  @$pb.TagNumber(4)
  $core.int get numActiveChannels => $_getIZ(3);
  @$pb.TagNumber(4)
  set numActiveChannels($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumActiveChannels() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumActiveChannels() => $_clearField(4);

  /// Number of peers
  @$pb.TagNumber(5)
  $core.int get numPeers => $_getIZ(4);
  @$pb.TagNumber(5)
  set numPeers($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumPeers() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumPeers() => $_clearField(5);

  /// The node's current view of the height of the best block
  @$pb.TagNumber(6)
  $core.int get blockHeight => $_getIZ(5);
  @$pb.TagNumber(6)
  set blockHeight($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasBlockHeight() => $_has(5);
  @$pb.TagNumber(6)
  void clearBlockHeight() => $_clearField(6);

  /// The node's current view of the hash of the best block
  @$pb.TagNumber(8)
  $core.String get blockHash => $_getSZ(6);
  @$pb.TagNumber(8)
  set blockHash($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasBlockHash() => $_has(6);
  @$pb.TagNumber(8)
  void clearBlockHash() => $_clearField(8);

  /// Whether the wallet's view is synced to the main chain
  @$pb.TagNumber(9)
  $core.bool get syncedToChain => $_getBF(7);
  @$pb.TagNumber(9)
  set syncedToChain($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasSyncedToChain() => $_has(7);
  @$pb.TagNumber(9)
  void clearSyncedToChain() => $_clearField(9);

  ///
  /// Whether the current node is connected to testnet or testnet4. This field is
  /// deprecated and the network field should be used instead.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  $core.bool get testnet => $_getBF(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  set testnet($core.bool v) { $_setBool(8, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  $core.bool hasTestnet() => $_has(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(10)
  void clearTestnet() => $_clearField(10);

  /// The URIs of the current node.
  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get uris => $_getList(9);

  /// Timestamp of the block best known to the wallet
  @$pb.TagNumber(13)
  $fixnum.Int64 get bestHeaderTimestamp => $_getI64(10);
  @$pb.TagNumber(13)
  set bestHeaderTimestamp($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(13)
  $core.bool hasBestHeaderTimestamp() => $_has(10);
  @$pb.TagNumber(13)
  void clearBestHeaderTimestamp() => $_clearField(13);

  /// The version of the LND software that the node is running.
  @$pb.TagNumber(14)
  $core.String get version => $_getSZ(11);
  @$pb.TagNumber(14)
  set version($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(14)
  $core.bool hasVersion() => $_has(11);
  @$pb.TagNumber(14)
  void clearVersion() => $_clearField(14);

  /// Number of inactive channels
  @$pb.TagNumber(15)
  $core.int get numInactiveChannels => $_getIZ(12);
  @$pb.TagNumber(15)
  set numInactiveChannels($core.int v) { $_setUnsignedInt32(12, v); }
  @$pb.TagNumber(15)
  $core.bool hasNumInactiveChannels() => $_has(12);
  @$pb.TagNumber(15)
  void clearNumInactiveChannels() => $_clearField(15);

  ///
  /// A list of active chains the node is connected to. This will only
  /// ever contain a single entry since LND will only ever have a single
  /// chain backend during its lifetime.
  @$pb.TagNumber(16)
  $pb.PbList<Chain> get chains => $_getList(13);

  /// The color of the current node in hex code format
  @$pb.TagNumber(17)
  $core.String get color => $_getSZ(14);
  @$pb.TagNumber(17)
  set color($core.String v) { $_setString(14, v); }
  @$pb.TagNumber(17)
  $core.bool hasColor() => $_has(14);
  @$pb.TagNumber(17)
  void clearColor() => $_clearField(17);

  /// Whether we consider ourselves synced with the public channel graph.
  @$pb.TagNumber(18)
  $core.bool get syncedToGraph => $_getBF(15);
  @$pb.TagNumber(18)
  set syncedToGraph($core.bool v) { $_setBool(15, v); }
  @$pb.TagNumber(18)
  $core.bool hasSyncedToGraph() => $_has(15);
  @$pb.TagNumber(18)
  void clearSyncedToGraph() => $_clearField(18);

  ///
  /// Features that our node has advertised in our init message, node
  /// announcements and invoices.
  @$pb.TagNumber(19)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(16);

  /// The SHA1 commit hash that the daemon is compiled with.
  @$pb.TagNumber(20)
  $core.String get commitHash => $_getSZ(17);
  @$pb.TagNumber(20)
  set commitHash($core.String v) { $_setString(17, v); }
  @$pb.TagNumber(20)
  $core.bool hasCommitHash() => $_has(17);
  @$pb.TagNumber(20)
  void clearCommitHash() => $_clearField(20);

  ///
  /// Indicates whether the HTLC interceptor API is in always-on mode.
  @$pb.TagNumber(21)
  $core.bool get requireHtlcInterceptor => $_getBF(18);
  @$pb.TagNumber(21)
  set requireHtlcInterceptor($core.bool v) { $_setBool(18, v); }
  @$pb.TagNumber(21)
  $core.bool hasRequireHtlcInterceptor() => $_has(18);
  @$pb.TagNumber(21)
  void clearRequireHtlcInterceptor() => $_clearField(21);

  /// Indicates whether final htlc resolutions are stored on disk.
  @$pb.TagNumber(22)
  $core.bool get storeFinalHtlcResolutions => $_getBF(19);
  @$pb.TagNumber(22)
  set storeFinalHtlcResolutions($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(22)
  $core.bool hasStoreFinalHtlcResolutions() => $_has(19);
  @$pb.TagNumber(22)
  void clearStoreFinalHtlcResolutions() => $_clearField(22);
}

class GetDebugInfoRequest extends $pb.GeneratedMessage {
  factory GetDebugInfoRequest() => create();
  GetDebugInfoRequest._() : super();
  factory GetDebugInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDebugInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDebugInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDebugInfoRequest clone() => GetDebugInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDebugInfoRequest copyWith(void Function(GetDebugInfoRequest) updates) => super.copyWith((message) => updates(message as GetDebugInfoRequest)) as GetDebugInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDebugInfoRequest create() => GetDebugInfoRequest._();
  GetDebugInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetDebugInfoRequest> createRepeated() => $pb.PbList<GetDebugInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetDebugInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDebugInfoRequest>(create);
  static GetDebugInfoRequest? _defaultInstance;
}

class GetDebugInfoResponse extends $pb.GeneratedMessage {
  factory GetDebugInfoResponse({
    $pb.PbMap<$core.String, $core.String>? config,
    $core.Iterable<$core.String>? log,
  }) {
    final $result = create();
    if (config != null) {
      $result.config.addAll(config);
    }
    if (log != null) {
      $result.log.addAll(log);
    }
    return $result;
  }
  GetDebugInfoResponse._() : super();
  factory GetDebugInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetDebugInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetDebugInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..m<$core.String, $core.String>(1, _omitFieldNames ? '' : 'config', entryClassName: 'GetDebugInfoResponse.ConfigEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('lnrpc'))
    ..pPS(2, _omitFieldNames ? '' : 'log')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetDebugInfoResponse clone() => GetDebugInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetDebugInfoResponse copyWith(void Function(GetDebugInfoResponse) updates) => super.copyWith((message) => updates(message as GetDebugInfoResponse)) as GetDebugInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetDebugInfoResponse create() => GetDebugInfoResponse._();
  GetDebugInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetDebugInfoResponse> createRepeated() => $pb.PbList<GetDebugInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetDebugInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetDebugInfoResponse>(create);
  static GetDebugInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, $core.String> get config => $_getMap(0);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get log => $_getList(1);
}

class GetRecoveryInfoRequest extends $pb.GeneratedMessage {
  factory GetRecoveryInfoRequest() => create();
  GetRecoveryInfoRequest._() : super();
  factory GetRecoveryInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecoveryInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecoveryInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecoveryInfoRequest clone() => GetRecoveryInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecoveryInfoRequest copyWith(void Function(GetRecoveryInfoRequest) updates) => super.copyWith((message) => updates(message as GetRecoveryInfoRequest)) as GetRecoveryInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecoveryInfoRequest create() => GetRecoveryInfoRequest._();
  GetRecoveryInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetRecoveryInfoRequest> createRepeated() => $pb.PbList<GetRecoveryInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetRecoveryInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecoveryInfoRequest>(create);
  static GetRecoveryInfoRequest? _defaultInstance;
}

class GetRecoveryInfoResponse extends $pb.GeneratedMessage {
  factory GetRecoveryInfoResponse({
    $core.bool? recoveryMode,
    $core.bool? recoveryFinished,
    $core.double? progress,
  }) {
    final $result = create();
    if (recoveryMode != null) {
      $result.recoveryMode = recoveryMode;
    }
    if (recoveryFinished != null) {
      $result.recoveryFinished = recoveryFinished;
    }
    if (progress != null) {
      $result.progress = progress;
    }
    return $result;
  }
  GetRecoveryInfoResponse._() : super();
  factory GetRecoveryInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetRecoveryInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetRecoveryInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'recoveryMode')
    ..aOB(2, _omitFieldNames ? '' : 'recoveryFinished')
    ..a<$core.double>(3, _omitFieldNames ? '' : 'progress', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetRecoveryInfoResponse clone() => GetRecoveryInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetRecoveryInfoResponse copyWith(void Function(GetRecoveryInfoResponse) updates) => super.copyWith((message) => updates(message as GetRecoveryInfoResponse)) as GetRecoveryInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetRecoveryInfoResponse create() => GetRecoveryInfoResponse._();
  GetRecoveryInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetRecoveryInfoResponse> createRepeated() => $pb.PbList<GetRecoveryInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetRecoveryInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetRecoveryInfoResponse>(create);
  static GetRecoveryInfoResponse? _defaultInstance;

  /// Whether the wallet is in recovery mode
  @$pb.TagNumber(1)
  $core.bool get recoveryMode => $_getBF(0);
  @$pb.TagNumber(1)
  set recoveryMode($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRecoveryMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearRecoveryMode() => $_clearField(1);

  /// Whether the wallet recovery progress is finished
  @$pb.TagNumber(2)
  $core.bool get recoveryFinished => $_getBF(1);
  @$pb.TagNumber(2)
  set recoveryFinished($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRecoveryFinished() => $_has(1);
  @$pb.TagNumber(2)
  void clearRecoveryFinished() => $_clearField(2);

  /// The recovery progress, ranging from 0 to 1.
  @$pb.TagNumber(3)
  $core.double get progress => $_getN(2);
  @$pb.TagNumber(3)
  set progress($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProgress() => $_has(2);
  @$pb.TagNumber(3)
  void clearProgress() => $_clearField(3);
}

class Chain extends $pb.GeneratedMessage {
  factory Chain({
  @$core.Deprecated('This field is deprecated.')
    $core.String? chain,
    $core.String? network,
  }) {
    final $result = create();
    if (chain != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.chain = chain;
    }
    if (network != null) {
      $result.network = network;
    }
    return $result;
  }
  Chain._() : super();
  factory Chain.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chain.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Chain', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'chain')
    ..aOS(2, _omitFieldNames ? '' : 'network')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Chain clone() => Chain()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Chain copyWith(void Function(Chain) updates) => super.copyWith((message) => updates(message as Chain)) as Chain;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Chain create() => Chain._();
  Chain createEmptyInstance() => create();
  static $pb.PbList<Chain> createRepeated() => $pb.PbList<Chain>();
  @$core.pragma('dart2js:noInline')
  static Chain getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chain>(create);
  static Chain? _defaultInstance;

  /// Deprecated. The chain is now always assumed to be bitcoin.
  /// The blockchain the node is on (must be bitcoin)
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get chain => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set chain($core.String v) { $_setString(0, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasChain() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearChain() => $_clearField(1);

  /// The network the node is on (eg regtest, testnet, mainnet)
  @$pb.TagNumber(2)
  $core.String get network => $_getSZ(1);
  @$pb.TagNumber(2)
  set network($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNetwork() => $_has(1);
  @$pb.TagNumber(2)
  void clearNetwork() => $_clearField(2);
}

class ConfirmationUpdate extends $pb.GeneratedMessage {
  factory ConfirmationUpdate({
    $core.List<$core.int>? blockSha,
    $core.int? blockHeight,
    $core.int? numConfsLeft,
  }) {
    final $result = create();
    if (blockSha != null) {
      $result.blockSha = blockSha;
    }
    if (blockHeight != null) {
      $result.blockHeight = blockHeight;
    }
    if (numConfsLeft != null) {
      $result.numConfsLeft = numConfsLeft;
    }
    return $result;
  }
  ConfirmationUpdate._() : super();
  factory ConfirmationUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfirmationUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConfirmationUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'blockSha', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'blockHeight', $pb.PbFieldType.O3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'numConfsLeft', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfirmationUpdate clone() => ConfirmationUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfirmationUpdate copyWith(void Function(ConfirmationUpdate) updates) => super.copyWith((message) => updates(message as ConfirmationUpdate)) as ConfirmationUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmationUpdate create() => ConfirmationUpdate._();
  ConfirmationUpdate createEmptyInstance() => create();
  static $pb.PbList<ConfirmationUpdate> createRepeated() => $pb.PbList<ConfirmationUpdate>();
  @$core.pragma('dart2js:noInline')
  static ConfirmationUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfirmationUpdate>(create);
  static ConfirmationUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get blockSha => $_getN(0);
  @$pb.TagNumber(1)
  set blockSha($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlockSha() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockSha() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get blockHeight => $_getIZ(1);
  @$pb.TagNumber(2)
  set blockHeight($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBlockHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlockHeight() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get numConfsLeft => $_getIZ(2);
  @$pb.TagNumber(3)
  set numConfsLeft($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumConfsLeft() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumConfsLeft() => $_clearField(3);
}

class ChannelOpenUpdate extends $pb.GeneratedMessage {
  factory ChannelOpenUpdate({
    ChannelPoint? channelPoint,
  }) {
    final $result = create();
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    return $result;
  }
  ChannelOpenUpdate._() : super();
  factory ChannelOpenUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelOpenUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelOpenUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<ChannelPoint>(1, _omitFieldNames ? '' : 'channelPoint', subBuilder: ChannelPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelOpenUpdate clone() => ChannelOpenUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelOpenUpdate copyWith(void Function(ChannelOpenUpdate) updates) => super.copyWith((message) => updates(message as ChannelOpenUpdate)) as ChannelOpenUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelOpenUpdate create() => ChannelOpenUpdate._();
  ChannelOpenUpdate createEmptyInstance() => create();
  static $pb.PbList<ChannelOpenUpdate> createRepeated() => $pb.PbList<ChannelOpenUpdate>();
  @$core.pragma('dart2js:noInline')
  static ChannelOpenUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelOpenUpdate>(create);
  static ChannelOpenUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  ChannelPoint get channelPoint => $_getN(0);
  @$pb.TagNumber(1)
  set channelPoint(ChannelPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelPoint() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelPoint ensureChannelPoint() => $_ensure(0);
}

class CloseOutput extends $pb.GeneratedMessage {
  factory CloseOutput({
    $fixnum.Int64? amountSat,
    $core.List<$core.int>? pkScript,
    $core.bool? isLocal,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (amountSat != null) {
      $result.amountSat = amountSat;
    }
    if (pkScript != null) {
      $result.pkScript = pkScript;
    }
    if (isLocal != null) {
      $result.isLocal = isLocal;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  CloseOutput._() : super();
  factory CloseOutput.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseOutput.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseOutput', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amountSat')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'pkScript', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'isLocal')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseOutput clone() => CloseOutput()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseOutput copyWith(void Function(CloseOutput) updates) => super.copyWith((message) => updates(message as CloseOutput)) as CloseOutput;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseOutput create() => CloseOutput._();
  CloseOutput createEmptyInstance() => create();
  static $pb.PbList<CloseOutput> createRepeated() => $pb.PbList<CloseOutput>();
  @$core.pragma('dart2js:noInline')
  static CloseOutput getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseOutput>(create);
  static CloseOutput? _defaultInstance;

  /// The amount in satoshi of this close output. This amount is the final
  /// commitment balance of the channel and the actual amount paid out on chain
  /// might be smaller due to subtracted fees.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amountSat => $_getI64(0);
  @$pb.TagNumber(1)
  set amountSat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmountSat() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountSat() => $_clearField(1);

  /// The pkScript of the close output.
  @$pb.TagNumber(2)
  $core.List<$core.int> get pkScript => $_getN(1);
  @$pb.TagNumber(2)
  set pkScript($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPkScript() => $_has(1);
  @$pb.TagNumber(2)
  void clearPkScript() => $_clearField(2);

  /// Whether this output is for the local or remote node.
  @$pb.TagNumber(3)
  $core.bool get isLocal => $_getBF(2);
  @$pb.TagNumber(3)
  set isLocal($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsLocal() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsLocal() => $_clearField(3);

  /// The TLV encoded custom channel data records for this output, which might
  /// be set for custom channels.
  @$pb.TagNumber(4)
  $core.List<$core.int> get customChannelData => $_getN(3);
  @$pb.TagNumber(4)
  set customChannelData($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCustomChannelData() => $_has(3);
  @$pb.TagNumber(4)
  void clearCustomChannelData() => $_clearField(4);
}

class ChannelCloseUpdate extends $pb.GeneratedMessage {
  factory ChannelCloseUpdate({
    $core.List<$core.int>? closingTxid,
    $core.bool? success,
    CloseOutput? localCloseOutput,
    CloseOutput? remoteCloseOutput,
    $core.Iterable<CloseOutput>? additionalOutputs,
  }) {
    final $result = create();
    if (closingTxid != null) {
      $result.closingTxid = closingTxid;
    }
    if (success != null) {
      $result.success = success;
    }
    if (localCloseOutput != null) {
      $result.localCloseOutput = localCloseOutput;
    }
    if (remoteCloseOutput != null) {
      $result.remoteCloseOutput = remoteCloseOutput;
    }
    if (additionalOutputs != null) {
      $result.additionalOutputs.addAll(additionalOutputs);
    }
    return $result;
  }
  ChannelCloseUpdate._() : super();
  factory ChannelCloseUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelCloseUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelCloseUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'closingTxid', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'success')
    ..aOM<CloseOutput>(3, _omitFieldNames ? '' : 'localCloseOutput', subBuilder: CloseOutput.create)
    ..aOM<CloseOutput>(4, _omitFieldNames ? '' : 'remoteCloseOutput', subBuilder: CloseOutput.create)
    ..pc<CloseOutput>(5, _omitFieldNames ? '' : 'additionalOutputs', $pb.PbFieldType.PM, subBuilder: CloseOutput.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelCloseUpdate clone() => ChannelCloseUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelCloseUpdate copyWith(void Function(ChannelCloseUpdate) updates) => super.copyWith((message) => updates(message as ChannelCloseUpdate)) as ChannelCloseUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelCloseUpdate create() => ChannelCloseUpdate._();
  ChannelCloseUpdate createEmptyInstance() => create();
  static $pb.PbList<ChannelCloseUpdate> createRepeated() => $pb.PbList<ChannelCloseUpdate>();
  @$core.pragma('dart2js:noInline')
  static ChannelCloseUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelCloseUpdate>(create);
  static ChannelCloseUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get closingTxid => $_getN(0);
  @$pb.TagNumber(1)
  set closingTxid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasClosingTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearClosingTxid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get success => $_getBF(1);
  @$pb.TagNumber(2)
  set success($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccess() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccess() => $_clearField(2);

  /// The local channel close output. If the local channel balance was dust to
  /// begin with, this output will not be set.
  @$pb.TagNumber(3)
  CloseOutput get localCloseOutput => $_getN(2);
  @$pb.TagNumber(3)
  set localCloseOutput(CloseOutput v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocalCloseOutput() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocalCloseOutput() => $_clearField(3);
  @$pb.TagNumber(3)
  CloseOutput ensureLocalCloseOutput() => $_ensure(2);

  /// The remote channel close output. If the remote channel balance was dust
  /// to begin with, this output will not be set.
  @$pb.TagNumber(4)
  CloseOutput get remoteCloseOutput => $_getN(3);
  @$pb.TagNumber(4)
  set remoteCloseOutput(CloseOutput v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRemoteCloseOutput() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemoteCloseOutput() => $_clearField(4);
  @$pb.TagNumber(4)
  CloseOutput ensureRemoteCloseOutput() => $_ensure(3);

  /// Any additional outputs that might be added for custom channel types.
  @$pb.TagNumber(5)
  $pb.PbList<CloseOutput> get additionalOutputs => $_getList(4);
}

class CloseChannelRequest extends $pb.GeneratedMessage {
  factory CloseChannelRequest({
    ChannelPoint? channelPoint,
    $core.bool? force,
    $core.int? targetConf,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? satPerByte,
    $core.String? deliveryAddress,
    $fixnum.Int64? satPerVbyte,
    $fixnum.Int64? maxFeePerVbyte,
    $core.bool? noWait,
  }) {
    final $result = create();
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    if (force != null) {
      $result.force = force;
    }
    if (targetConf != null) {
      $result.targetConf = targetConf;
    }
    if (satPerByte != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.satPerByte = satPerByte;
    }
    if (deliveryAddress != null) {
      $result.deliveryAddress = deliveryAddress;
    }
    if (satPerVbyte != null) {
      $result.satPerVbyte = satPerVbyte;
    }
    if (maxFeePerVbyte != null) {
      $result.maxFeePerVbyte = maxFeePerVbyte;
    }
    if (noWait != null) {
      $result.noWait = noWait;
    }
    return $result;
  }
  CloseChannelRequest._() : super();
  factory CloseChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<ChannelPoint>(1, _omitFieldNames ? '' : 'channelPoint', subBuilder: ChannelPoint.create)
    ..aOB(2, _omitFieldNames ? '' : 'force')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'targetConf', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'satPerByte')
    ..aOS(5, _omitFieldNames ? '' : 'deliveryAddress')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'satPerVbyte', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'maxFeePerVbyte', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(8, _omitFieldNames ? '' : 'noWait')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseChannelRequest clone() => CloseChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseChannelRequest copyWith(void Function(CloseChannelRequest) updates) => super.copyWith((message) => updates(message as CloseChannelRequest)) as CloseChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseChannelRequest create() => CloseChannelRequest._();
  CloseChannelRequest createEmptyInstance() => create();
  static $pb.PbList<CloseChannelRequest> createRepeated() => $pb.PbList<CloseChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseChannelRequest>(create);
  static CloseChannelRequest? _defaultInstance;

  ///
  /// The outpoint (txid:index) of the funding transaction. With this value, Bob
  /// will be able to generate a signature for Alice's version of the commitment
  /// transaction.
  @$pb.TagNumber(1)
  ChannelPoint get channelPoint => $_getN(0);
  @$pb.TagNumber(1)
  set channelPoint(ChannelPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelPoint() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelPoint ensureChannelPoint() => $_ensure(0);

  /// If true, then the channel will be closed forcibly. This means the
  /// current commitment transaction will be signed and broadcast.
  @$pb.TagNumber(2)
  $core.bool get force => $_getBF(1);
  @$pb.TagNumber(2)
  set force($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasForce() => $_has(1);
  @$pb.TagNumber(2)
  void clearForce() => $_clearField(2);

  /// The target number of blocks that the closure transaction should be
  /// confirmed by.
  @$pb.TagNumber(3)
  $core.int get targetConf => $_getIZ(2);
  @$pb.TagNumber(3)
  set targetConf($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetConf() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetConf() => $_clearField(3);

  /// Deprecated, use sat_per_vbyte.
  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// closure transaction.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $fixnum.Int64 get satPerByte => $_getI64(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  set satPerByte($fixnum.Int64 v) { $_setInt64(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool hasSatPerByte() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  void clearSatPerByte() => $_clearField(4);

  ///
  /// An optional address to send funds to in the case of a cooperative close.
  /// If the channel was opened with an upfront shutdown script and this field
  /// is set, the request to close will fail because the channel must pay out
  /// to the upfront shutdown addresss.
  @$pb.TagNumber(5)
  $core.String get deliveryAddress => $_getSZ(4);
  @$pb.TagNumber(5)
  set deliveryAddress($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDeliveryAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeliveryAddress() => $_clearField(5);

  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// closure transaction.
  @$pb.TagNumber(6)
  $fixnum.Int64 get satPerVbyte => $_getI64(5);
  @$pb.TagNumber(6)
  set satPerVbyte($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSatPerVbyte() => $_has(5);
  @$pb.TagNumber(6)
  void clearSatPerVbyte() => $_clearField(6);

  ///  The maximum fee rate the closer is willing to pay.
  ///
  ///  NOTE: This field is only respected if we're the initiator of the channel.
  @$pb.TagNumber(7)
  $fixnum.Int64 get maxFeePerVbyte => $_getI64(6);
  @$pb.TagNumber(7)
  set maxFeePerVbyte($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMaxFeePerVbyte() => $_has(6);
  @$pb.TagNumber(7)
  void clearMaxFeePerVbyte() => $_clearField(7);

  /// If true, then the rpc call will not block while it awaits a closing txid
  /// to be broadcasted to the mempool. To obtain the closing tx one has to
  /// listen to the stream for the particular updates. Moreover if a coop close
  /// is specified and this flag is set to true the coop closing flow will be
  /// initiated even if HTLCs are active on the channel. The channel will wait
  /// until all HTLCs are resolved and then start the coop closing process. The
  /// channel will be disabled in the meantime and will disallow any new HTLCs.
  @$pb.TagNumber(8)
  $core.bool get noWait => $_getBF(7);
  @$pb.TagNumber(8)
  set noWait($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasNoWait() => $_has(7);
  @$pb.TagNumber(8)
  void clearNoWait() => $_clearField(8);
}

enum CloseStatusUpdate_Update {
  closePending, 
  chanClose, 
  closeInstant, 
  notSet
}

class CloseStatusUpdate extends $pb.GeneratedMessage {
  factory CloseStatusUpdate({
    PendingUpdate? closePending,
    ChannelCloseUpdate? chanClose,
    InstantUpdate? closeInstant,
  }) {
    final $result = create();
    if (closePending != null) {
      $result.closePending = closePending;
    }
    if (chanClose != null) {
      $result.chanClose = chanClose;
    }
    if (closeInstant != null) {
      $result.closeInstant = closeInstant;
    }
    return $result;
  }
  CloseStatusUpdate._() : super();
  factory CloseStatusUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseStatusUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CloseStatusUpdate_Update> _CloseStatusUpdate_UpdateByTag = {
    1 : CloseStatusUpdate_Update.closePending,
    3 : CloseStatusUpdate_Update.chanClose,
    4 : CloseStatusUpdate_Update.closeInstant,
    0 : CloseStatusUpdate_Update.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseStatusUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 3, 4])
    ..aOM<PendingUpdate>(1, _omitFieldNames ? '' : 'closePending', subBuilder: PendingUpdate.create)
    ..aOM<ChannelCloseUpdate>(3, _omitFieldNames ? '' : 'chanClose', subBuilder: ChannelCloseUpdate.create)
    ..aOM<InstantUpdate>(4, _omitFieldNames ? '' : 'closeInstant', subBuilder: InstantUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseStatusUpdate clone() => CloseStatusUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseStatusUpdate copyWith(void Function(CloseStatusUpdate) updates) => super.copyWith((message) => updates(message as CloseStatusUpdate)) as CloseStatusUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseStatusUpdate create() => CloseStatusUpdate._();
  CloseStatusUpdate createEmptyInstance() => create();
  static $pb.PbList<CloseStatusUpdate> createRepeated() => $pb.PbList<CloseStatusUpdate>();
  @$core.pragma('dart2js:noInline')
  static CloseStatusUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseStatusUpdate>(create);
  static CloseStatusUpdate? _defaultInstance;

  CloseStatusUpdate_Update whichUpdate() => _CloseStatusUpdate_UpdateByTag[$_whichOneof(0)]!;
  void clearUpdate() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PendingUpdate get closePending => $_getN(0);
  @$pb.TagNumber(1)
  set closePending(PendingUpdate v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClosePending() => $_has(0);
  @$pb.TagNumber(1)
  void clearClosePending() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingUpdate ensureClosePending() => $_ensure(0);

  @$pb.TagNumber(3)
  ChannelCloseUpdate get chanClose => $_getN(1);
  @$pb.TagNumber(3)
  set chanClose(ChannelCloseUpdate v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasChanClose() => $_has(1);
  @$pb.TagNumber(3)
  void clearChanClose() => $_clearField(3);
  @$pb.TagNumber(3)
  ChannelCloseUpdate ensureChanClose() => $_ensure(1);

  @$pb.TagNumber(4)
  InstantUpdate get closeInstant => $_getN(2);
  @$pb.TagNumber(4)
  set closeInstant(InstantUpdate v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCloseInstant() => $_has(2);
  @$pb.TagNumber(4)
  void clearCloseInstant() => $_clearField(4);
  @$pb.TagNumber(4)
  InstantUpdate ensureCloseInstant() => $_ensure(2);
}

class PendingUpdate extends $pb.GeneratedMessage {
  factory PendingUpdate({
    $core.List<$core.int>? txid,
    $core.int? outputIndex,
    $fixnum.Int64? feePerVbyte,
    $core.bool? localCloseTx,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    if (outputIndex != null) {
      $result.outputIndex = outputIndex;
    }
    if (feePerVbyte != null) {
      $result.feePerVbyte = feePerVbyte;
    }
    if (localCloseTx != null) {
      $result.localCloseTx = localCloseTx;
    }
    return $result;
  }
  PendingUpdate._() : super();
  factory PendingUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'txid', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'outputIndex', $pb.PbFieldType.OU3)
    ..aInt64(3, _omitFieldNames ? '' : 'feePerVbyte')
    ..aOB(4, _omitFieldNames ? '' : 'localCloseTx')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingUpdate clone() => PendingUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingUpdate copyWith(void Function(PendingUpdate) updates) => super.copyWith((message) => updates(message as PendingUpdate)) as PendingUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingUpdate create() => PendingUpdate._();
  PendingUpdate createEmptyInstance() => create();
  static $pb.PbList<PendingUpdate> createRepeated() => $pb.PbList<PendingUpdate>();
  @$core.pragma('dart2js:noInline')
  static PendingUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingUpdate>(create);
  static PendingUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get txid => $_getN(0);
  @$pb.TagNumber(1)
  set txid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get outputIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set outputIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutputIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutputIndex() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get feePerVbyte => $_getI64(2);
  @$pb.TagNumber(3)
  set feePerVbyte($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeePerVbyte() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePerVbyte() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get localCloseTx => $_getBF(3);
  @$pb.TagNumber(4)
  set localCloseTx($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocalCloseTx() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocalCloseTx() => $_clearField(4);
}

class InstantUpdate extends $pb.GeneratedMessage {
  factory InstantUpdate({
    $core.int? numPendingHtlcs,
  }) {
    final $result = create();
    if (numPendingHtlcs != null) {
      $result.numPendingHtlcs = numPendingHtlcs;
    }
    return $result;
  }
  InstantUpdate._() : super();
  factory InstantUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InstantUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InstantUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'numPendingHtlcs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InstantUpdate clone() => InstantUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InstantUpdate copyWith(void Function(InstantUpdate) updates) => super.copyWith((message) => updates(message as InstantUpdate)) as InstantUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InstantUpdate create() => InstantUpdate._();
  InstantUpdate createEmptyInstance() => create();
  static $pb.PbList<InstantUpdate> createRepeated() => $pb.PbList<InstantUpdate>();
  @$core.pragma('dart2js:noInline')
  static InstantUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InstantUpdate>(create);
  static InstantUpdate? _defaultInstance;

  /// The number of pending HTLCs that are currently active on the channel.
  /// These HTLCs need to be resolved before the channel can be closed
  /// cooperatively.
  @$pb.TagNumber(1)
  $core.int get numPendingHtlcs => $_getIZ(0);
  @$pb.TagNumber(1)
  set numPendingHtlcs($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNumPendingHtlcs() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumPendingHtlcs() => $_clearField(1);
}

class ReadyForPsbtFunding extends $pb.GeneratedMessage {
  factory ReadyForPsbtFunding({
    $core.String? fundingAddress,
    $fixnum.Int64? fundingAmount,
    $core.List<$core.int>? psbt,
  }) {
    final $result = create();
    if (fundingAddress != null) {
      $result.fundingAddress = fundingAddress;
    }
    if (fundingAmount != null) {
      $result.fundingAmount = fundingAmount;
    }
    if (psbt != null) {
      $result.psbt = psbt;
    }
    return $result;
  }
  ReadyForPsbtFunding._() : super();
  factory ReadyForPsbtFunding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ReadyForPsbtFunding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ReadyForPsbtFunding', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fundingAddress')
    ..aInt64(2, _omitFieldNames ? '' : 'fundingAmount')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'psbt', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ReadyForPsbtFunding clone() => ReadyForPsbtFunding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ReadyForPsbtFunding copyWith(void Function(ReadyForPsbtFunding) updates) => super.copyWith((message) => updates(message as ReadyForPsbtFunding)) as ReadyForPsbtFunding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReadyForPsbtFunding create() => ReadyForPsbtFunding._();
  ReadyForPsbtFunding createEmptyInstance() => create();
  static $pb.PbList<ReadyForPsbtFunding> createRepeated() => $pb.PbList<ReadyForPsbtFunding>();
  @$core.pragma('dart2js:noInline')
  static ReadyForPsbtFunding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReadyForPsbtFunding>(create);
  static ReadyForPsbtFunding? _defaultInstance;

  ///
  /// The P2WSH address of the channel funding multisig address that the below
  /// specified amount in satoshis needs to be sent to.
  @$pb.TagNumber(1)
  $core.String get fundingAddress => $_getSZ(0);
  @$pb.TagNumber(1)
  set fundingAddress($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFundingAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundingAddress() => $_clearField(1);

  ///
  /// The exact amount in satoshis that needs to be sent to the above address to
  /// fund the pending channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get fundingAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set fundingAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFundingAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearFundingAmount() => $_clearField(2);

  ///
  /// A raw PSBT that contains the pending channel output. If a base PSBT was
  /// provided in the PsbtShim, this is the base PSBT with one additional output.
  /// If no base PSBT was specified, this is an otherwise empty PSBT with exactly
  /// one output.
  @$pb.TagNumber(3)
  $core.List<$core.int> get psbt => $_getN(2);
  @$pb.TagNumber(3)
  set psbt($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPsbt() => $_has(2);
  @$pb.TagNumber(3)
  void clearPsbt() => $_clearField(3);
}

class BatchOpenChannelRequest extends $pb.GeneratedMessage {
  factory BatchOpenChannelRequest({
    $core.Iterable<BatchOpenChannel>? channels,
    $core.int? targetConf,
    $fixnum.Int64? satPerVbyte,
    $core.int? minConfs,
    $core.bool? spendUnconfirmed,
    $core.String? label,
    CoinSelectionStrategy? coinSelectionStrategy,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    if (targetConf != null) {
      $result.targetConf = targetConf;
    }
    if (satPerVbyte != null) {
      $result.satPerVbyte = satPerVbyte;
    }
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    if (spendUnconfirmed != null) {
      $result.spendUnconfirmed = spendUnconfirmed;
    }
    if (label != null) {
      $result.label = label;
    }
    if (coinSelectionStrategy != null) {
      $result.coinSelectionStrategy = coinSelectionStrategy;
    }
    return $result;
  }
  BatchOpenChannelRequest._() : super();
  factory BatchOpenChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchOpenChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchOpenChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<BatchOpenChannel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: BatchOpenChannel.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'targetConf', $pb.PbFieldType.O3)
    ..aInt64(3, _omitFieldNames ? '' : 'satPerVbyte')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..aOB(5, _omitFieldNames ? '' : 'spendUnconfirmed')
    ..aOS(6, _omitFieldNames ? '' : 'label')
    ..e<CoinSelectionStrategy>(7, _omitFieldNames ? '' : 'coinSelectionStrategy', $pb.PbFieldType.OE, defaultOrMaker: CoinSelectionStrategy.STRATEGY_USE_GLOBAL_CONFIG, valueOf: CoinSelectionStrategy.valueOf, enumValues: CoinSelectionStrategy.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchOpenChannelRequest clone() => BatchOpenChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchOpenChannelRequest copyWith(void Function(BatchOpenChannelRequest) updates) => super.copyWith((message) => updates(message as BatchOpenChannelRequest)) as BatchOpenChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchOpenChannelRequest create() => BatchOpenChannelRequest._();
  BatchOpenChannelRequest createEmptyInstance() => create();
  static $pb.PbList<BatchOpenChannelRequest> createRepeated() => $pb.PbList<BatchOpenChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static BatchOpenChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchOpenChannelRequest>(create);
  static BatchOpenChannelRequest? _defaultInstance;

  /// The list of channels to open.
  @$pb.TagNumber(1)
  $pb.PbList<BatchOpenChannel> get channels => $_getList(0);

  /// The target number of blocks that the funding transaction should be
  /// confirmed by.
  @$pb.TagNumber(2)
  $core.int get targetConf => $_getIZ(1);
  @$pb.TagNumber(2)
  set targetConf($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTargetConf() => $_has(1);
  @$pb.TagNumber(2)
  void clearTargetConf() => $_clearField(2);

  /// A manual fee rate set in sat/vByte that should be used when crafting the
  /// funding transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get satPerVbyte => $_getI64(2);
  @$pb.TagNumber(3)
  set satPerVbyte($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSatPerVbyte() => $_has(2);
  @$pb.TagNumber(3)
  void clearSatPerVbyte() => $_clearField(3);

  /// The minimum number of confirmations each one of your outputs used for
  /// the funding transaction must satisfy.
  @$pb.TagNumber(4)
  $core.int get minConfs => $_getIZ(3);
  @$pb.TagNumber(4)
  set minConfs($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMinConfs() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinConfs() => $_clearField(4);

  /// Whether unconfirmed outputs should be used as inputs for the funding
  /// transaction.
  @$pb.TagNumber(5)
  $core.bool get spendUnconfirmed => $_getBF(4);
  @$pb.TagNumber(5)
  set spendUnconfirmed($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSpendUnconfirmed() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpendUnconfirmed() => $_clearField(5);

  /// An optional label for the batch transaction, limited to 500 characters.
  @$pb.TagNumber(6)
  $core.String get label => $_getSZ(5);
  @$pb.TagNumber(6)
  set label($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLabel() => $_has(5);
  @$pb.TagNumber(6)
  void clearLabel() => $_clearField(6);

  /// The strategy to use for selecting coins during batch opening channels.
  @$pb.TagNumber(7)
  CoinSelectionStrategy get coinSelectionStrategy => $_getN(6);
  @$pb.TagNumber(7)
  set coinSelectionStrategy(CoinSelectionStrategy v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCoinSelectionStrategy() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoinSelectionStrategy() => $_clearField(7);
}

class BatchOpenChannel extends $pb.GeneratedMessage {
  factory BatchOpenChannel({
    $core.List<$core.int>? nodePubkey,
    $fixnum.Int64? localFundingAmount,
    $fixnum.Int64? pushSat,
    $core.bool? private,
    $fixnum.Int64? minHtlcMsat,
    $core.int? remoteCsvDelay,
    $core.String? closeAddress,
    $core.List<$core.int>? pendingChanId,
    CommitmentType? commitmentType,
    $fixnum.Int64? remoteMaxValueInFlightMsat,
    $core.int? remoteMaxHtlcs,
    $core.int? maxLocalCsv,
    $core.bool? zeroConf,
    $core.bool? scidAlias,
    $fixnum.Int64? baseFee,
    $fixnum.Int64? feeRate,
    $core.bool? useBaseFee,
    $core.bool? useFeeRate,
    $fixnum.Int64? remoteChanReserveSat,
    $core.String? memo,
  }) {
    final $result = create();
    if (nodePubkey != null) {
      $result.nodePubkey = nodePubkey;
    }
    if (localFundingAmount != null) {
      $result.localFundingAmount = localFundingAmount;
    }
    if (pushSat != null) {
      $result.pushSat = pushSat;
    }
    if (private != null) {
      $result.private = private;
    }
    if (minHtlcMsat != null) {
      $result.minHtlcMsat = minHtlcMsat;
    }
    if (remoteCsvDelay != null) {
      $result.remoteCsvDelay = remoteCsvDelay;
    }
    if (closeAddress != null) {
      $result.closeAddress = closeAddress;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (commitmentType != null) {
      $result.commitmentType = commitmentType;
    }
    if (remoteMaxValueInFlightMsat != null) {
      $result.remoteMaxValueInFlightMsat = remoteMaxValueInFlightMsat;
    }
    if (remoteMaxHtlcs != null) {
      $result.remoteMaxHtlcs = remoteMaxHtlcs;
    }
    if (maxLocalCsv != null) {
      $result.maxLocalCsv = maxLocalCsv;
    }
    if (zeroConf != null) {
      $result.zeroConf = zeroConf;
    }
    if (scidAlias != null) {
      $result.scidAlias = scidAlias;
    }
    if (baseFee != null) {
      $result.baseFee = baseFee;
    }
    if (feeRate != null) {
      $result.feeRate = feeRate;
    }
    if (useBaseFee != null) {
      $result.useBaseFee = useBaseFee;
    }
    if (useFeeRate != null) {
      $result.useFeeRate = useFeeRate;
    }
    if (remoteChanReserveSat != null) {
      $result.remoteChanReserveSat = remoteChanReserveSat;
    }
    if (memo != null) {
      $result.memo = memo;
    }
    return $result;
  }
  BatchOpenChannel._() : super();
  factory BatchOpenChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchOpenChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchOpenChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'nodePubkey', $pb.PbFieldType.OY)
    ..aInt64(2, _omitFieldNames ? '' : 'localFundingAmount')
    ..aInt64(3, _omitFieldNames ? '' : 'pushSat')
    ..aOB(4, _omitFieldNames ? '' : 'private')
    ..aInt64(5, _omitFieldNames ? '' : 'minHtlcMsat')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'remoteCsvDelay', $pb.PbFieldType.OU3)
    ..aOS(7, _omitFieldNames ? '' : 'closeAddress')
    ..a<$core.List<$core.int>>(8, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..e<CommitmentType>(9, _omitFieldNames ? '' : 'commitmentType', $pb.PbFieldType.OE, defaultOrMaker: CommitmentType.UNKNOWN_COMMITMENT_TYPE, valueOf: CommitmentType.valueOf, enumValues: CommitmentType.values)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'remoteMaxValueInFlightMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'remoteMaxHtlcs', $pb.PbFieldType.OU3)
    ..a<$core.int>(12, _omitFieldNames ? '' : 'maxLocalCsv', $pb.PbFieldType.OU3)
    ..aOB(13, _omitFieldNames ? '' : 'zeroConf')
    ..aOB(14, _omitFieldNames ? '' : 'scidAlias')
    ..a<$fixnum.Int64>(15, _omitFieldNames ? '' : 'baseFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(16, _omitFieldNames ? '' : 'feeRate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(17, _omitFieldNames ? '' : 'useBaseFee')
    ..aOB(18, _omitFieldNames ? '' : 'useFeeRate')
    ..a<$fixnum.Int64>(19, _omitFieldNames ? '' : 'remoteChanReserveSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(20, _omitFieldNames ? '' : 'memo')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchOpenChannel clone() => BatchOpenChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchOpenChannel copyWith(void Function(BatchOpenChannel) updates) => super.copyWith((message) => updates(message as BatchOpenChannel)) as BatchOpenChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchOpenChannel create() => BatchOpenChannel._();
  BatchOpenChannel createEmptyInstance() => create();
  static $pb.PbList<BatchOpenChannel> createRepeated() => $pb.PbList<BatchOpenChannel>();
  @$core.pragma('dart2js:noInline')
  static BatchOpenChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchOpenChannel>(create);
  static BatchOpenChannel? _defaultInstance;

  /// The pubkey of the node to open a channel with. When using REST, this
  /// field must be encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get nodePubkey => $_getN(0);
  @$pb.TagNumber(1)
  set nodePubkey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodePubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodePubkey() => $_clearField(1);

  /// The number of satoshis the wallet should commit to the channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get localFundingAmount => $_getI64(1);
  @$pb.TagNumber(2)
  set localFundingAmount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLocalFundingAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocalFundingAmount() => $_clearField(2);

  /// The number of satoshis to push to the remote side as part of the initial
  /// commitment state.
  @$pb.TagNumber(3)
  $fixnum.Int64 get pushSat => $_getI64(2);
  @$pb.TagNumber(3)
  set pushSat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPushSat() => $_has(2);
  @$pb.TagNumber(3)
  void clearPushSat() => $_clearField(3);

  /// Whether this channel should be private, not announced to the greater
  /// network.
  @$pb.TagNumber(4)
  $core.bool get private => $_getBF(3);
  @$pb.TagNumber(4)
  set private($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPrivate() => $_has(3);
  @$pb.TagNumber(4)
  void clearPrivate() => $_clearField(4);

  /// The minimum value in millisatoshi we will require for incoming HTLCs on
  /// the channel.
  @$pb.TagNumber(5)
  $fixnum.Int64 get minHtlcMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set minHtlcMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMinHtlcMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinHtlcMsat() => $_clearField(5);

  /// The delay we require on the remote's commitment transaction. If this is
  /// not set, it will be scaled automatically with the channel size.
  @$pb.TagNumber(6)
  $core.int get remoteCsvDelay => $_getIZ(5);
  @$pb.TagNumber(6)
  set remoteCsvDelay($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRemoteCsvDelay() => $_has(5);
  @$pb.TagNumber(6)
  void clearRemoteCsvDelay() => $_clearField(6);

  ///
  /// Close address is an optional address which specifies the address to which
  /// funds should be paid out to upon cooperative close. This field may only be
  /// set if the peer supports the option upfront feature bit (call listpeers
  /// to check). The remote peer will only accept cooperative closes to this
  /// address if it is set.
  ///
  /// Note: If this value is set on channel creation, you will *not* be able to
  /// cooperatively close out to a different address.
  @$pb.TagNumber(7)
  $core.String get closeAddress => $_getSZ(6);
  @$pb.TagNumber(7)
  set closeAddress($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCloseAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearCloseAddress() => $_clearField(7);

  ///
  /// An optional, unique identifier of 32 random bytes that will be used as the
  /// pending channel ID to identify the channel while it is in the pre-pending
  /// state.
  @$pb.TagNumber(8)
  $core.List<$core.int> get pendingChanId => $_getN(7);
  @$pb.TagNumber(8)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPendingChanId() => $_has(7);
  @$pb.TagNumber(8)
  void clearPendingChanId() => $_clearField(8);

  ///
  /// The explicit commitment type to use. Note this field will only be used if
  /// the remote peer supports explicit channel negotiation.
  @$pb.TagNumber(9)
  CommitmentType get commitmentType => $_getN(8);
  @$pb.TagNumber(9)
  set commitmentType(CommitmentType v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCommitmentType() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommitmentType() => $_clearField(9);

  ///
  /// The maximum amount of coins in millisatoshi that can be pending within
  /// the channel. It only applies to the remote party.
  @$pb.TagNumber(10)
  $fixnum.Int64 get remoteMaxValueInFlightMsat => $_getI64(9);
  @$pb.TagNumber(10)
  set remoteMaxValueInFlightMsat($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRemoteMaxValueInFlightMsat() => $_has(9);
  @$pb.TagNumber(10)
  void clearRemoteMaxValueInFlightMsat() => $_clearField(10);

  ///
  /// The maximum number of concurrent HTLCs we will allow the remote party to add
  /// to the commitment transaction.
  @$pb.TagNumber(11)
  $core.int get remoteMaxHtlcs => $_getIZ(10);
  @$pb.TagNumber(11)
  set remoteMaxHtlcs($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasRemoteMaxHtlcs() => $_has(10);
  @$pb.TagNumber(11)
  void clearRemoteMaxHtlcs() => $_clearField(11);

  ///
  /// Max local csv is the maximum csv delay we will allow for our own commitment
  /// transaction.
  @$pb.TagNumber(12)
  $core.int get maxLocalCsv => $_getIZ(11);
  @$pb.TagNumber(12)
  set maxLocalCsv($core.int v) { $_setUnsignedInt32(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasMaxLocalCsv() => $_has(11);
  @$pb.TagNumber(12)
  void clearMaxLocalCsv() => $_clearField(12);

  ///
  /// If this is true, then a zero-conf channel open will be attempted.
  @$pb.TagNumber(13)
  $core.bool get zeroConf => $_getBF(12);
  @$pb.TagNumber(13)
  set zeroConf($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasZeroConf() => $_has(12);
  @$pb.TagNumber(13)
  void clearZeroConf() => $_clearField(13);

  ///
  /// If this is true, then an option-scid-alias channel-type open will be
  /// attempted.
  @$pb.TagNumber(14)
  $core.bool get scidAlias => $_getBF(13);
  @$pb.TagNumber(14)
  set scidAlias($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasScidAlias() => $_has(13);
  @$pb.TagNumber(14)
  void clearScidAlias() => $_clearField(14);

  ///
  /// The base fee charged regardless of the number of milli-satoshis sent.
  @$pb.TagNumber(15)
  $fixnum.Int64 get baseFee => $_getI64(14);
  @$pb.TagNumber(15)
  set baseFee($fixnum.Int64 v) { $_setInt64(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasBaseFee() => $_has(14);
  @$pb.TagNumber(15)
  void clearBaseFee() => $_clearField(15);

  ///
  /// The fee rate in ppm (parts per million) that will be charged in
  /// proportion of the value of each forwarded HTLC.
  @$pb.TagNumber(16)
  $fixnum.Int64 get feeRate => $_getI64(15);
  @$pb.TagNumber(16)
  set feeRate($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasFeeRate() => $_has(15);
  @$pb.TagNumber(16)
  void clearFeeRate() => $_clearField(16);

  ///
  /// If use_base_fee is true the open channel announcement will update the
  /// channel base fee with the value specified in base_fee. In the case of
  /// a base_fee of 0 use_base_fee is needed downstream to distinguish whether
  /// to use the default base fee value specified in the config or 0.
  @$pb.TagNumber(17)
  $core.bool get useBaseFee => $_getBF(16);
  @$pb.TagNumber(17)
  set useBaseFee($core.bool v) { $_setBool(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasUseBaseFee() => $_has(16);
  @$pb.TagNumber(17)
  void clearUseBaseFee() => $_clearField(17);

  ///
  /// If use_fee_rate is true the open channel announcement will update the
  /// channel fee rate with the value specified in fee_rate. In the case of
  /// a fee_rate of 0 use_fee_rate is needed downstream to distinguish whether
  /// to use the default fee rate value specified in the config or 0.
  @$pb.TagNumber(18)
  $core.bool get useFeeRate => $_getBF(17);
  @$pb.TagNumber(18)
  set useFeeRate($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasUseFeeRate() => $_has(17);
  @$pb.TagNumber(18)
  void clearUseFeeRate() => $_clearField(18);

  ///
  /// The number of satoshis we require the remote peer to reserve. This value,
  /// if specified, must be above the dust limit and below 20% of the channel
  /// capacity.
  @$pb.TagNumber(19)
  $fixnum.Int64 get remoteChanReserveSat => $_getI64(18);
  @$pb.TagNumber(19)
  set remoteChanReserveSat($fixnum.Int64 v) { $_setInt64(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasRemoteChanReserveSat() => $_has(18);
  @$pb.TagNumber(19)
  void clearRemoteChanReserveSat() => $_clearField(19);

  ///
  /// An optional note-to-self to go along with the channel containing some
  /// useful information. This is only ever stored locally and in no way impacts
  /// the channel's operation.
  @$pb.TagNumber(20)
  $core.String get memo => $_getSZ(19);
  @$pb.TagNumber(20)
  set memo($core.String v) { $_setString(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasMemo() => $_has(19);
  @$pb.TagNumber(20)
  void clearMemo() => $_clearField(20);
}

class BatchOpenChannelResponse extends $pb.GeneratedMessage {
  factory BatchOpenChannelResponse({
    $core.Iterable<PendingUpdate>? pendingChannels,
  }) {
    final $result = create();
    if (pendingChannels != null) {
      $result.pendingChannels.addAll(pendingChannels);
    }
    return $result;
  }
  BatchOpenChannelResponse._() : super();
  factory BatchOpenChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BatchOpenChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BatchOpenChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<PendingUpdate>(1, _omitFieldNames ? '' : 'pendingChannels', $pb.PbFieldType.PM, subBuilder: PendingUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BatchOpenChannelResponse clone() => BatchOpenChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BatchOpenChannelResponse copyWith(void Function(BatchOpenChannelResponse) updates) => super.copyWith((message) => updates(message as BatchOpenChannelResponse)) as BatchOpenChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BatchOpenChannelResponse create() => BatchOpenChannelResponse._();
  BatchOpenChannelResponse createEmptyInstance() => create();
  static $pb.PbList<BatchOpenChannelResponse> createRepeated() => $pb.PbList<BatchOpenChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static BatchOpenChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BatchOpenChannelResponse>(create);
  static BatchOpenChannelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PendingUpdate> get pendingChannels => $_getList(0);
}

class OpenChannelRequest extends $pb.GeneratedMessage {
  factory OpenChannelRequest({
    $fixnum.Int64? satPerVbyte,
    $core.List<$core.int>? nodePubkey,
  @$core.Deprecated('This field is deprecated.')
    $core.String? nodePubkeyString,
    $fixnum.Int64? localFundingAmount,
    $fixnum.Int64? pushSat,
    $core.int? targetConf,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? satPerByte,
    $core.bool? private,
    $fixnum.Int64? minHtlcMsat,
    $core.int? remoteCsvDelay,
    $core.int? minConfs,
    $core.bool? spendUnconfirmed,
    $core.String? closeAddress,
    FundingShim? fundingShim,
    $fixnum.Int64? remoteMaxValueInFlightMsat,
    $core.int? remoteMaxHtlcs,
    $core.int? maxLocalCsv,
    CommitmentType? commitmentType,
    $core.bool? zeroConf,
    $core.bool? scidAlias,
    $fixnum.Int64? baseFee,
    $fixnum.Int64? feeRate,
    $core.bool? useBaseFee,
    $core.bool? useFeeRate,
    $fixnum.Int64? remoteChanReserveSat,
    $core.bool? fundMax,
    $core.String? memo,
    $core.Iterable<OutPoint>? outpoints,
  }) {
    final $result = create();
    if (satPerVbyte != null) {
      $result.satPerVbyte = satPerVbyte;
    }
    if (nodePubkey != null) {
      $result.nodePubkey = nodePubkey;
    }
    if (nodePubkeyString != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.nodePubkeyString = nodePubkeyString;
    }
    if (localFundingAmount != null) {
      $result.localFundingAmount = localFundingAmount;
    }
    if (pushSat != null) {
      $result.pushSat = pushSat;
    }
    if (targetConf != null) {
      $result.targetConf = targetConf;
    }
    if (satPerByte != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.satPerByte = satPerByte;
    }
    if (private != null) {
      $result.private = private;
    }
    if (minHtlcMsat != null) {
      $result.minHtlcMsat = minHtlcMsat;
    }
    if (remoteCsvDelay != null) {
      $result.remoteCsvDelay = remoteCsvDelay;
    }
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    if (spendUnconfirmed != null) {
      $result.spendUnconfirmed = spendUnconfirmed;
    }
    if (closeAddress != null) {
      $result.closeAddress = closeAddress;
    }
    if (fundingShim != null) {
      $result.fundingShim = fundingShim;
    }
    if (remoteMaxValueInFlightMsat != null) {
      $result.remoteMaxValueInFlightMsat = remoteMaxValueInFlightMsat;
    }
    if (remoteMaxHtlcs != null) {
      $result.remoteMaxHtlcs = remoteMaxHtlcs;
    }
    if (maxLocalCsv != null) {
      $result.maxLocalCsv = maxLocalCsv;
    }
    if (commitmentType != null) {
      $result.commitmentType = commitmentType;
    }
    if (zeroConf != null) {
      $result.zeroConf = zeroConf;
    }
    if (scidAlias != null) {
      $result.scidAlias = scidAlias;
    }
    if (baseFee != null) {
      $result.baseFee = baseFee;
    }
    if (feeRate != null) {
      $result.feeRate = feeRate;
    }
    if (useBaseFee != null) {
      $result.useBaseFee = useBaseFee;
    }
    if (useFeeRate != null) {
      $result.useFeeRate = useFeeRate;
    }
    if (remoteChanReserveSat != null) {
      $result.remoteChanReserveSat = remoteChanReserveSat;
    }
    if (fundMax != null) {
      $result.fundMax = fundMax;
    }
    if (memo != null) {
      $result.memo = memo;
    }
    if (outpoints != null) {
      $result.outpoints.addAll(outpoints);
    }
    return $result;
  }
  OpenChannelRequest._() : super();
  factory OpenChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'satPerVbyte', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'nodePubkey', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'nodePubkeyString')
    ..aInt64(4, _omitFieldNames ? '' : 'localFundingAmount')
    ..aInt64(5, _omitFieldNames ? '' : 'pushSat')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'targetConf', $pb.PbFieldType.O3)
    ..aInt64(7, _omitFieldNames ? '' : 'satPerByte')
    ..aOB(8, _omitFieldNames ? '' : 'private')
    ..aInt64(9, _omitFieldNames ? '' : 'minHtlcMsat')
    ..a<$core.int>(10, _omitFieldNames ? '' : 'remoteCsvDelay', $pb.PbFieldType.OU3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..aOB(12, _omitFieldNames ? '' : 'spendUnconfirmed')
    ..aOS(13, _omitFieldNames ? '' : 'closeAddress')
    ..aOM<FundingShim>(14, _omitFieldNames ? '' : 'fundingShim', subBuilder: FundingShim.create)
    ..a<$fixnum.Int64>(15, _omitFieldNames ? '' : 'remoteMaxValueInFlightMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(16, _omitFieldNames ? '' : 'remoteMaxHtlcs', $pb.PbFieldType.OU3)
    ..a<$core.int>(17, _omitFieldNames ? '' : 'maxLocalCsv', $pb.PbFieldType.OU3)
    ..e<CommitmentType>(18, _omitFieldNames ? '' : 'commitmentType', $pb.PbFieldType.OE, defaultOrMaker: CommitmentType.UNKNOWN_COMMITMENT_TYPE, valueOf: CommitmentType.valueOf, enumValues: CommitmentType.values)
    ..aOB(19, _omitFieldNames ? '' : 'zeroConf')
    ..aOB(20, _omitFieldNames ? '' : 'scidAlias')
    ..a<$fixnum.Int64>(21, _omitFieldNames ? '' : 'baseFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(22, _omitFieldNames ? '' : 'feeRate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(23, _omitFieldNames ? '' : 'useBaseFee')
    ..aOB(24, _omitFieldNames ? '' : 'useFeeRate')
    ..a<$fixnum.Int64>(25, _omitFieldNames ? '' : 'remoteChanReserveSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(26, _omitFieldNames ? '' : 'fundMax')
    ..aOS(27, _omitFieldNames ? '' : 'memo')
    ..pc<OutPoint>(28, _omitFieldNames ? '' : 'outpoints', $pb.PbFieldType.PM, subBuilder: OutPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenChannelRequest clone() => OpenChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenChannelRequest copyWith(void Function(OpenChannelRequest) updates) => super.copyWith((message) => updates(message as OpenChannelRequest)) as OpenChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenChannelRequest create() => OpenChannelRequest._();
  OpenChannelRequest createEmptyInstance() => create();
  static $pb.PbList<OpenChannelRequest> createRepeated() => $pb.PbList<OpenChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static OpenChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenChannelRequest>(create);
  static OpenChannelRequest? _defaultInstance;

  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// funding transaction.
  @$pb.TagNumber(1)
  $fixnum.Int64 get satPerVbyte => $_getI64(0);
  @$pb.TagNumber(1)
  set satPerVbyte($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSatPerVbyte() => $_has(0);
  @$pb.TagNumber(1)
  void clearSatPerVbyte() => $_clearField(1);

  ///
  /// The pubkey of the node to open a channel with. When using REST, this field
  /// must be encoded as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get nodePubkey => $_getN(1);
  @$pb.TagNumber(2)
  set nodePubkey($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNodePubkey() => $_has(1);
  @$pb.TagNumber(2)
  void clearNodePubkey() => $_clearField(2);

  ///
  /// The hex encoded pubkey of the node to open a channel with. Deprecated now
  /// that the REST gateway supports base64 encoding of bytes fields.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.String get nodePubkeyString => $_getSZ(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set nodePubkeyString($core.String v) { $_setString(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasNodePubkeyString() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearNodePubkeyString() => $_clearField(3);

  /// The number of satoshis the wallet should commit to the channel
  @$pb.TagNumber(4)
  $fixnum.Int64 get localFundingAmount => $_getI64(3);
  @$pb.TagNumber(4)
  set localFundingAmount($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocalFundingAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocalFundingAmount() => $_clearField(4);

  /// The number of satoshis to push to the remote side as part of the initial
  /// commitment state
  @$pb.TagNumber(5)
  $fixnum.Int64 get pushSat => $_getI64(4);
  @$pb.TagNumber(5)
  set pushSat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPushSat() => $_has(4);
  @$pb.TagNumber(5)
  void clearPushSat() => $_clearField(5);

  /// The target number of blocks that the funding transaction should be
  /// confirmed by.
  @$pb.TagNumber(6)
  $core.int get targetConf => $_getIZ(5);
  @$pb.TagNumber(6)
  set targetConf($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTargetConf() => $_has(5);
  @$pb.TagNumber(6)
  void clearTargetConf() => $_clearField(6);

  /// Deprecated, use sat_per_vbyte.
  /// A manual fee rate set in sat/vbyte that should be used when crafting the
  /// funding transaction.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $fixnum.Int64 get satPerByte => $_getI64(6);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  set satPerByte($fixnum.Int64 v) { $_setInt64(6, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $core.bool hasSatPerByte() => $_has(6);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  void clearSatPerByte() => $_clearField(7);

  /// Whether this channel should be private, not announced to the greater
  /// network.
  @$pb.TagNumber(8)
  $core.bool get private => $_getBF(7);
  @$pb.TagNumber(8)
  set private($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPrivate() => $_has(7);
  @$pb.TagNumber(8)
  void clearPrivate() => $_clearField(8);

  /// The minimum value in millisatoshi we will require for incoming HTLCs on
  /// the channel.
  @$pb.TagNumber(9)
  $fixnum.Int64 get minHtlcMsat => $_getI64(8);
  @$pb.TagNumber(9)
  set minHtlcMsat($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMinHtlcMsat() => $_has(8);
  @$pb.TagNumber(9)
  void clearMinHtlcMsat() => $_clearField(9);

  /// The delay we require on the remote's commitment transaction. If this is
  /// not set, it will be scaled automatically with the channel size.
  @$pb.TagNumber(10)
  $core.int get remoteCsvDelay => $_getIZ(9);
  @$pb.TagNumber(10)
  set remoteCsvDelay($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasRemoteCsvDelay() => $_has(9);
  @$pb.TagNumber(10)
  void clearRemoteCsvDelay() => $_clearField(10);

  /// The minimum number of confirmations each one of your outputs used for
  /// the funding transaction must satisfy.
  @$pb.TagNumber(11)
  $core.int get minConfs => $_getIZ(10);
  @$pb.TagNumber(11)
  set minConfs($core.int v) { $_setSignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMinConfs() => $_has(10);
  @$pb.TagNumber(11)
  void clearMinConfs() => $_clearField(11);

  /// Whether unconfirmed outputs should be used as inputs for the funding
  /// transaction.
  @$pb.TagNumber(12)
  $core.bool get spendUnconfirmed => $_getBF(11);
  @$pb.TagNumber(12)
  set spendUnconfirmed($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasSpendUnconfirmed() => $_has(11);
  @$pb.TagNumber(12)
  void clearSpendUnconfirmed() => $_clearField(12);

  ///
  /// Close address is an optional address which specifies the address to which
  /// funds should be paid out to upon cooperative close. This field may only be
  /// set if the peer supports the option upfront feature bit (call listpeers
  /// to check). The remote peer will only accept cooperative closes to this
  /// address if it is set.
  ///
  /// Note: If this value is set on channel creation, you will *not* be able to
  /// cooperatively close out to a different address.
  @$pb.TagNumber(13)
  $core.String get closeAddress => $_getSZ(12);
  @$pb.TagNumber(13)
  set closeAddress($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasCloseAddress() => $_has(12);
  @$pb.TagNumber(13)
  void clearCloseAddress() => $_clearField(13);

  ///
  /// Funding shims are an optional argument that allow the caller to intercept
  /// certain funding functionality. For example, a shim can be provided to use a
  /// particular key for the commitment key (ideally cold) rather than use one
  /// that is generated by the wallet as normal, or signal that signing will be
  /// carried out in an interactive manner (PSBT based).
  @$pb.TagNumber(14)
  FundingShim get fundingShim => $_getN(13);
  @$pb.TagNumber(14)
  set fundingShim(FundingShim v) { $_setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasFundingShim() => $_has(13);
  @$pb.TagNumber(14)
  void clearFundingShim() => $_clearField(14);
  @$pb.TagNumber(14)
  FundingShim ensureFundingShim() => $_ensure(13);

  ///
  /// The maximum amount of coins in millisatoshi that can be pending within
  /// the channel. It only applies to the remote party.
  @$pb.TagNumber(15)
  $fixnum.Int64 get remoteMaxValueInFlightMsat => $_getI64(14);
  @$pb.TagNumber(15)
  set remoteMaxValueInFlightMsat($fixnum.Int64 v) { $_setInt64(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasRemoteMaxValueInFlightMsat() => $_has(14);
  @$pb.TagNumber(15)
  void clearRemoteMaxValueInFlightMsat() => $_clearField(15);

  ///
  /// The maximum number of concurrent HTLCs we will allow the remote party to add
  /// to the commitment transaction.
  @$pb.TagNumber(16)
  $core.int get remoteMaxHtlcs => $_getIZ(15);
  @$pb.TagNumber(16)
  set remoteMaxHtlcs($core.int v) { $_setUnsignedInt32(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasRemoteMaxHtlcs() => $_has(15);
  @$pb.TagNumber(16)
  void clearRemoteMaxHtlcs() => $_clearField(16);

  ///
  /// Max local csv is the maximum csv delay we will allow for our own commitment
  /// transaction.
  @$pb.TagNumber(17)
  $core.int get maxLocalCsv => $_getIZ(16);
  @$pb.TagNumber(17)
  set maxLocalCsv($core.int v) { $_setUnsignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasMaxLocalCsv() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaxLocalCsv() => $_clearField(17);

  ///
  /// The explicit commitment type to use. Note this field will only be used if
  /// the remote peer supports explicit channel negotiation.
  @$pb.TagNumber(18)
  CommitmentType get commitmentType => $_getN(17);
  @$pb.TagNumber(18)
  set commitmentType(CommitmentType v) { $_setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasCommitmentType() => $_has(17);
  @$pb.TagNumber(18)
  void clearCommitmentType() => $_clearField(18);

  ///
  /// If this is true, then a zero-conf channel open will be attempted.
  @$pb.TagNumber(19)
  $core.bool get zeroConf => $_getBF(18);
  @$pb.TagNumber(19)
  set zeroConf($core.bool v) { $_setBool(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasZeroConf() => $_has(18);
  @$pb.TagNumber(19)
  void clearZeroConf() => $_clearField(19);

  ///
  /// If this is true, then an option-scid-alias channel-type open will be
  /// attempted.
  @$pb.TagNumber(20)
  $core.bool get scidAlias => $_getBF(19);
  @$pb.TagNumber(20)
  set scidAlias($core.bool v) { $_setBool(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasScidAlias() => $_has(19);
  @$pb.TagNumber(20)
  void clearScidAlias() => $_clearField(20);

  ///
  /// The base fee charged regardless of the number of milli-satoshis sent.
  @$pb.TagNumber(21)
  $fixnum.Int64 get baseFee => $_getI64(20);
  @$pb.TagNumber(21)
  set baseFee($fixnum.Int64 v) { $_setInt64(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasBaseFee() => $_has(20);
  @$pb.TagNumber(21)
  void clearBaseFee() => $_clearField(21);

  ///
  /// The fee rate in ppm (parts per million) that will be charged in
  /// proportion of the value of each forwarded HTLC.
  @$pb.TagNumber(22)
  $fixnum.Int64 get feeRate => $_getI64(21);
  @$pb.TagNumber(22)
  set feeRate($fixnum.Int64 v) { $_setInt64(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasFeeRate() => $_has(21);
  @$pb.TagNumber(22)
  void clearFeeRate() => $_clearField(22);

  ///
  /// If use_base_fee is true the open channel announcement will update the
  /// channel base fee with the value specified in base_fee. In the case of
  /// a base_fee of 0 use_base_fee is needed downstream to distinguish whether
  /// to use the default base fee value specified in the config or 0.
  @$pb.TagNumber(23)
  $core.bool get useBaseFee => $_getBF(22);
  @$pb.TagNumber(23)
  set useBaseFee($core.bool v) { $_setBool(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasUseBaseFee() => $_has(22);
  @$pb.TagNumber(23)
  void clearUseBaseFee() => $_clearField(23);

  ///
  /// If use_fee_rate is true the open channel announcement will update the
  /// channel fee rate with the value specified in fee_rate. In the case of
  /// a fee_rate of 0 use_fee_rate is needed downstream to distinguish whether
  /// to use the default fee rate value specified in the config or 0.
  @$pb.TagNumber(24)
  $core.bool get useFeeRate => $_getBF(23);
  @$pb.TagNumber(24)
  set useFeeRate($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasUseFeeRate() => $_has(23);
  @$pb.TagNumber(24)
  void clearUseFeeRate() => $_clearField(24);

  ///
  /// The number of satoshis we require the remote peer to reserve. This value,
  /// if specified, must be above the dust limit and below 20% of the channel
  /// capacity.
  @$pb.TagNumber(25)
  $fixnum.Int64 get remoteChanReserveSat => $_getI64(24);
  @$pb.TagNumber(25)
  set remoteChanReserveSat($fixnum.Int64 v) { $_setInt64(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasRemoteChanReserveSat() => $_has(24);
  @$pb.TagNumber(25)
  void clearRemoteChanReserveSat() => $_clearField(25);

  ///
  /// If set, then lnd will attempt to commit all the coins under control of the
  /// internal wallet to open the channel, and the LocalFundingAmount field must
  /// be zero and is ignored.
  @$pb.TagNumber(26)
  $core.bool get fundMax => $_getBF(25);
  @$pb.TagNumber(26)
  set fundMax($core.bool v) { $_setBool(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasFundMax() => $_has(25);
  @$pb.TagNumber(26)
  void clearFundMax() => $_clearField(26);

  ///
  /// An optional note-to-self to go along with the channel containing some
  /// useful information. This is only ever stored locally and in no way impacts
  /// the channel's operation.
  @$pb.TagNumber(27)
  $core.String get memo => $_getSZ(26);
  @$pb.TagNumber(27)
  set memo($core.String v) { $_setString(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasMemo() => $_has(26);
  @$pb.TagNumber(27)
  void clearMemo() => $_clearField(27);

  ///
  /// A list of selected outpoints that are allocated for channel funding.
  @$pb.TagNumber(28)
  $pb.PbList<OutPoint> get outpoints => $_getList(27);
}

enum OpenStatusUpdate_Update {
  chanPending, 
  chanOpen, 
  psbtFund, 
  notSet
}

class OpenStatusUpdate extends $pb.GeneratedMessage {
  factory OpenStatusUpdate({
    PendingUpdate? chanPending,
    ChannelOpenUpdate? chanOpen,
    $core.List<$core.int>? pendingChanId,
    ReadyForPsbtFunding? psbtFund,
  }) {
    final $result = create();
    if (chanPending != null) {
      $result.chanPending = chanPending;
    }
    if (chanOpen != null) {
      $result.chanOpen = chanOpen;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (psbtFund != null) {
      $result.psbtFund = psbtFund;
    }
    return $result;
  }
  OpenStatusUpdate._() : super();
  factory OpenStatusUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenStatusUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OpenStatusUpdate_Update> _OpenStatusUpdate_UpdateByTag = {
    1 : OpenStatusUpdate_Update.chanPending,
    3 : OpenStatusUpdate_Update.chanOpen,
    5 : OpenStatusUpdate_Update.psbtFund,
    0 : OpenStatusUpdate_Update.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenStatusUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 3, 5])
    ..aOM<PendingUpdate>(1, _omitFieldNames ? '' : 'chanPending', subBuilder: PendingUpdate.create)
    ..aOM<ChannelOpenUpdate>(3, _omitFieldNames ? '' : 'chanOpen', subBuilder: ChannelOpenUpdate.create)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..aOM<ReadyForPsbtFunding>(5, _omitFieldNames ? '' : 'psbtFund', subBuilder: ReadyForPsbtFunding.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenStatusUpdate clone() => OpenStatusUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenStatusUpdate copyWith(void Function(OpenStatusUpdate) updates) => super.copyWith((message) => updates(message as OpenStatusUpdate)) as OpenStatusUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenStatusUpdate create() => OpenStatusUpdate._();
  OpenStatusUpdate createEmptyInstance() => create();
  static $pb.PbList<OpenStatusUpdate> createRepeated() => $pb.PbList<OpenStatusUpdate>();
  @$core.pragma('dart2js:noInline')
  static OpenStatusUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenStatusUpdate>(create);
  static OpenStatusUpdate? _defaultInstance;

  OpenStatusUpdate_Update whichUpdate() => _OpenStatusUpdate_UpdateByTag[$_whichOneof(0)]!;
  void clearUpdate() => $_clearField($_whichOneof(0));

  ///
  /// Signals that the channel is now fully negotiated and the funding
  /// transaction published.
  @$pb.TagNumber(1)
  PendingUpdate get chanPending => $_getN(0);
  @$pb.TagNumber(1)
  set chanPending(PendingUpdate v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanPending() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanPending() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingUpdate ensureChanPending() => $_ensure(0);

  ///
  /// Signals that the channel's funding transaction has now reached the
  /// required number of confirmations on chain and can be used.
  @$pb.TagNumber(3)
  ChannelOpenUpdate get chanOpen => $_getN(1);
  @$pb.TagNumber(3)
  set chanOpen(ChannelOpenUpdate v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasChanOpen() => $_has(1);
  @$pb.TagNumber(3)
  void clearChanOpen() => $_clearField(3);
  @$pb.TagNumber(3)
  ChannelOpenUpdate ensureChanOpen() => $_ensure(1);

  ///
  /// The pending channel ID of the created channel. This value may be used to
  /// further the funding flow manually via the FundingStateStep method.
  @$pb.TagNumber(4)
  $core.List<$core.int> get pendingChanId => $_getN(2);
  @$pb.TagNumber(4)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasPendingChanId() => $_has(2);
  @$pb.TagNumber(4)
  void clearPendingChanId() => $_clearField(4);

  ///
  /// Signals that the funding process has been suspended and the construction
  /// of a PSBT that funds the channel PK script is now required.
  @$pb.TagNumber(5)
  ReadyForPsbtFunding get psbtFund => $_getN(3);
  @$pb.TagNumber(5)
  set psbtFund(ReadyForPsbtFunding v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasPsbtFund() => $_has(3);
  @$pb.TagNumber(5)
  void clearPsbtFund() => $_clearField(5);
  @$pb.TagNumber(5)
  ReadyForPsbtFunding ensurePsbtFund() => $_ensure(3);
}

class KeyLocator extends $pb.GeneratedMessage {
  factory KeyLocator({
    $core.int? keyFamily,
    $core.int? keyIndex,
  }) {
    final $result = create();
    if (keyFamily != null) {
      $result.keyFamily = keyFamily;
    }
    if (keyIndex != null) {
      $result.keyIndex = keyIndex;
    }
    return $result;
  }
  KeyLocator._() : super();
  factory KeyLocator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyLocator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KeyLocator', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'keyFamily', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'keyIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyLocator clone() => KeyLocator()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyLocator copyWith(void Function(KeyLocator) updates) => super.copyWith((message) => updates(message as KeyLocator)) as KeyLocator;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyLocator create() => KeyLocator._();
  KeyLocator createEmptyInstance() => create();
  static $pb.PbList<KeyLocator> createRepeated() => $pb.PbList<KeyLocator>();
  @$core.pragma('dart2js:noInline')
  static KeyLocator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyLocator>(create);
  static KeyLocator? _defaultInstance;

  /// The family of key being identified.
  @$pb.TagNumber(1)
  $core.int get keyFamily => $_getIZ(0);
  @$pb.TagNumber(1)
  set keyFamily($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyFamily() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyFamily() => $_clearField(1);

  /// The precise index of the key being identified.
  @$pb.TagNumber(2)
  $core.int get keyIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set keyIndex($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyIndex() => $_clearField(2);
}

class KeyDescriptor extends $pb.GeneratedMessage {
  factory KeyDescriptor({
    $core.List<$core.int>? rawKeyBytes,
    KeyLocator? keyLoc,
  }) {
    final $result = create();
    if (rawKeyBytes != null) {
      $result.rawKeyBytes = rawKeyBytes;
    }
    if (keyLoc != null) {
      $result.keyLoc = keyLoc;
    }
    return $result;
  }
  KeyDescriptor._() : super();
  factory KeyDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KeyDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rawKeyBytes', $pb.PbFieldType.OY)
    ..aOM<KeyLocator>(2, _omitFieldNames ? '' : 'keyLoc', subBuilder: KeyLocator.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyDescriptor clone() => KeyDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyDescriptor copyWith(void Function(KeyDescriptor) updates) => super.copyWith((message) => updates(message as KeyDescriptor)) as KeyDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyDescriptor create() => KeyDescriptor._();
  KeyDescriptor createEmptyInstance() => create();
  static $pb.PbList<KeyDescriptor> createRepeated() => $pb.PbList<KeyDescriptor>();
  @$core.pragma('dart2js:noInline')
  static KeyDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyDescriptor>(create);
  static KeyDescriptor? _defaultInstance;

  ///
  /// The raw bytes of the key being identified.
  @$pb.TagNumber(1)
  $core.List<$core.int> get rawKeyBytes => $_getN(0);
  @$pb.TagNumber(1)
  set rawKeyBytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRawKeyBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearRawKeyBytes() => $_clearField(1);

  ///
  /// The key locator that identifies which key to use for signing.
  @$pb.TagNumber(2)
  KeyLocator get keyLoc => $_getN(1);
  @$pb.TagNumber(2)
  set keyLoc(KeyLocator v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyLoc() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyLoc() => $_clearField(2);
  @$pb.TagNumber(2)
  KeyLocator ensureKeyLoc() => $_ensure(1);
}

class ChanPointShim extends $pb.GeneratedMessage {
  factory ChanPointShim({
    $fixnum.Int64? amt,
    ChannelPoint? chanPoint,
    KeyDescriptor? localKey,
    $core.List<$core.int>? remoteKey,
    $core.List<$core.int>? pendingChanId,
    $core.int? thawHeight,
    $core.bool? musig2,
  }) {
    final $result = create();
    if (amt != null) {
      $result.amt = amt;
    }
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    if (localKey != null) {
      $result.localKey = localKey;
    }
    if (remoteKey != null) {
      $result.remoteKey = remoteKey;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (thawHeight != null) {
      $result.thawHeight = thawHeight;
    }
    if (musig2 != null) {
      $result.musig2 = musig2;
    }
    return $result;
  }
  ChanPointShim._() : super();
  factory ChanPointShim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChanPointShim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChanPointShim', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amt')
    ..aOM<ChannelPoint>(2, _omitFieldNames ? '' : 'chanPoint', subBuilder: ChannelPoint.create)
    ..aOM<KeyDescriptor>(3, _omitFieldNames ? '' : 'localKey', subBuilder: KeyDescriptor.create)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'remoteKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'thawHeight', $pb.PbFieldType.OU3)
    ..aOB(7, _omitFieldNames ? '' : 'musig2')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChanPointShim clone() => ChanPointShim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChanPointShim copyWith(void Function(ChanPointShim) updates) => super.copyWith((message) => updates(message as ChanPointShim)) as ChanPointShim;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChanPointShim create() => ChanPointShim._();
  ChanPointShim createEmptyInstance() => create();
  static $pb.PbList<ChanPointShim> createRepeated() => $pb.PbList<ChanPointShim>();
  @$core.pragma('dart2js:noInline')
  static ChanPointShim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChanPointShim>(create);
  static ChanPointShim? _defaultInstance;

  ///
  /// The size of the pre-crafted output to be used as the channel point for this
  /// channel funding.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amt => $_getI64(0);
  @$pb.TagNumber(1)
  set amt($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmt() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmt() => $_clearField(1);

  /// The target channel point to refrence in created commitment transactions.
  @$pb.TagNumber(2)
  ChannelPoint get chanPoint => $_getN(1);
  @$pb.TagNumber(2)
  set chanPoint(ChannelPoint v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanPoint() => $_clearField(2);
  @$pb.TagNumber(2)
  ChannelPoint ensureChanPoint() => $_ensure(1);

  /// Our local key to use when creating the multi-sig output.
  @$pb.TagNumber(3)
  KeyDescriptor get localKey => $_getN(2);
  @$pb.TagNumber(3)
  set localKey(KeyDescriptor v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocalKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocalKey() => $_clearField(3);
  @$pb.TagNumber(3)
  KeyDescriptor ensureLocalKey() => $_ensure(2);

  /// The key of the remote party to use when creating the multi-sig output.
  @$pb.TagNumber(4)
  $core.List<$core.int> get remoteKey => $_getN(3);
  @$pb.TagNumber(4)
  set remoteKey($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRemoteKey() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemoteKey() => $_clearField(4);

  ///
  /// If non-zero, then this will be used as the pending channel ID on the wire
  /// protocol to initate the funding request. This is an optional field, and
  /// should only be set if the responder is already expecting a specific pending
  /// channel ID.
  @$pb.TagNumber(5)
  $core.List<$core.int> get pendingChanId => $_getN(4);
  @$pb.TagNumber(5)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPendingChanId() => $_has(4);
  @$pb.TagNumber(5)
  void clearPendingChanId() => $_clearField(5);

  ///
  /// This uint32 indicates if this channel is to be considered 'frozen'. A frozen
  /// channel does not allow a cooperative channel close by the initiator. The
  /// thaw_height is the height that this restriction stops applying to the
  /// channel. The height can be interpreted in two ways: as a relative height if
  /// the value is less than 500,000, or as an absolute height otherwise.
  @$pb.TagNumber(6)
  $core.int get thawHeight => $_getIZ(5);
  @$pb.TagNumber(6)
  set thawHeight($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasThawHeight() => $_has(5);
  @$pb.TagNumber(6)
  void clearThawHeight() => $_clearField(6);

  ///
  /// Indicates that the funding output is using a MuSig2 multi-sig output.
  @$pb.TagNumber(7)
  $core.bool get musig2 => $_getBF(6);
  @$pb.TagNumber(7)
  set musig2($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMusig2() => $_has(6);
  @$pb.TagNumber(7)
  void clearMusig2() => $_clearField(7);
}

class PsbtShim extends $pb.GeneratedMessage {
  factory PsbtShim({
    $core.List<$core.int>? pendingChanId,
    $core.List<$core.int>? basePsbt,
    $core.bool? noPublish,
  }) {
    final $result = create();
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (basePsbt != null) {
      $result.basePsbt = basePsbt;
    }
    if (noPublish != null) {
      $result.noPublish = noPublish;
    }
    return $result;
  }
  PsbtShim._() : super();
  factory PsbtShim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PsbtShim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PsbtShim', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'basePsbt', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'noPublish')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PsbtShim clone() => PsbtShim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PsbtShim copyWith(void Function(PsbtShim) updates) => super.copyWith((message) => updates(message as PsbtShim)) as PsbtShim;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PsbtShim create() => PsbtShim._();
  PsbtShim createEmptyInstance() => create();
  static $pb.PbList<PsbtShim> createRepeated() => $pb.PbList<PsbtShim>();
  @$core.pragma('dart2js:noInline')
  static PsbtShim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PsbtShim>(create);
  static PsbtShim? _defaultInstance;

  ///
  /// A unique identifier of 32 random bytes that will be used as the pending
  /// channel ID to identify the PSBT state machine when interacting with it and
  /// on the wire protocol to initiate the funding request.
  @$pb.TagNumber(1)
  $core.List<$core.int> get pendingChanId => $_getN(0);
  @$pb.TagNumber(1)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPendingChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPendingChanId() => $_clearField(1);

  ///
  /// An optional base PSBT the new channel output will be added to. If this is
  /// non-empty, it must be a binary serialized PSBT.
  @$pb.TagNumber(2)
  $core.List<$core.int> get basePsbt => $_getN(1);
  @$pb.TagNumber(2)
  set basePsbt($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBasePsbt() => $_has(1);
  @$pb.TagNumber(2)
  void clearBasePsbt() => $_clearField(2);

  ///
  /// If a channel should be part of a batch (multiple channel openings in one
  /// transaction), it can be dangerous if the whole batch transaction is
  /// published too early before all channel opening negotiations are completed.
  /// This flag prevents this particular channel from broadcasting the transaction
  /// after the negotiation with the remote peer. In a batch of channel openings
  /// this flag should be set to true for every channel but the very last.
  @$pb.TagNumber(3)
  $core.bool get noPublish => $_getBF(2);
  @$pb.TagNumber(3)
  set noPublish($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNoPublish() => $_has(2);
  @$pb.TagNumber(3)
  void clearNoPublish() => $_clearField(3);
}

enum FundingShim_Shim {
  chanPointShim, 
  psbtShim, 
  notSet
}

class FundingShim extends $pb.GeneratedMessage {
  factory FundingShim({
    ChanPointShim? chanPointShim,
    PsbtShim? psbtShim,
  }) {
    final $result = create();
    if (chanPointShim != null) {
      $result.chanPointShim = chanPointShim;
    }
    if (psbtShim != null) {
      $result.psbtShim = psbtShim;
    }
    return $result;
  }
  FundingShim._() : super();
  factory FundingShim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FundingShim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, FundingShim_Shim> _FundingShim_ShimByTag = {
    1 : FundingShim_Shim.chanPointShim,
    2 : FundingShim_Shim.psbtShim,
    0 : FundingShim_Shim.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundingShim', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<ChanPointShim>(1, _omitFieldNames ? '' : 'chanPointShim', subBuilder: ChanPointShim.create)
    ..aOM<PsbtShim>(2, _omitFieldNames ? '' : 'psbtShim', subBuilder: PsbtShim.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FundingShim clone() => FundingShim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FundingShim copyWith(void Function(FundingShim) updates) => super.copyWith((message) => updates(message as FundingShim)) as FundingShim;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundingShim create() => FundingShim._();
  FundingShim createEmptyInstance() => create();
  static $pb.PbList<FundingShim> createRepeated() => $pb.PbList<FundingShim>();
  @$core.pragma('dart2js:noInline')
  static FundingShim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundingShim>(create);
  static FundingShim? _defaultInstance;

  FundingShim_Shim whichShim() => _FundingShim_ShimByTag[$_whichOneof(0)]!;
  void clearShim() => $_clearField($_whichOneof(0));

  ///
  /// A channel shim where the channel point was fully constructed outside
  /// of lnd's wallet and the transaction might already be published.
  @$pb.TagNumber(1)
  ChanPointShim get chanPointShim => $_getN(0);
  @$pb.TagNumber(1)
  set chanPointShim(ChanPointShim v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanPointShim() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanPointShim() => $_clearField(1);
  @$pb.TagNumber(1)
  ChanPointShim ensureChanPointShim() => $_ensure(0);

  ///
  /// A channel shim that uses a PSBT to fund and sign the channel funding
  /// transaction.
  @$pb.TagNumber(2)
  PsbtShim get psbtShim => $_getN(1);
  @$pb.TagNumber(2)
  set psbtShim(PsbtShim v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPsbtShim() => $_has(1);
  @$pb.TagNumber(2)
  void clearPsbtShim() => $_clearField(2);
  @$pb.TagNumber(2)
  PsbtShim ensurePsbtShim() => $_ensure(1);
}

class FundingShimCancel extends $pb.GeneratedMessage {
  factory FundingShimCancel({
    $core.List<$core.int>? pendingChanId,
  }) {
    final $result = create();
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    return $result;
  }
  FundingShimCancel._() : super();
  factory FundingShimCancel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FundingShimCancel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundingShimCancel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FundingShimCancel clone() => FundingShimCancel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FundingShimCancel copyWith(void Function(FundingShimCancel) updates) => super.copyWith((message) => updates(message as FundingShimCancel)) as FundingShimCancel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundingShimCancel create() => FundingShimCancel._();
  FundingShimCancel createEmptyInstance() => create();
  static $pb.PbList<FundingShimCancel> createRepeated() => $pb.PbList<FundingShimCancel>();
  @$core.pragma('dart2js:noInline')
  static FundingShimCancel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundingShimCancel>(create);
  static FundingShimCancel? _defaultInstance;

  /// The pending channel ID of the channel to cancel the funding shim for.
  @$pb.TagNumber(1)
  $core.List<$core.int> get pendingChanId => $_getN(0);
  @$pb.TagNumber(1)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPendingChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPendingChanId() => $_clearField(1);
}

class FundingPsbtVerify extends $pb.GeneratedMessage {
  factory FundingPsbtVerify({
    $core.List<$core.int>? fundedPsbt,
    $core.List<$core.int>? pendingChanId,
    $core.bool? skipFinalize,
  }) {
    final $result = create();
    if (fundedPsbt != null) {
      $result.fundedPsbt = fundedPsbt;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (skipFinalize != null) {
      $result.skipFinalize = skipFinalize;
    }
    return $result;
  }
  FundingPsbtVerify._() : super();
  factory FundingPsbtVerify.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FundingPsbtVerify.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundingPsbtVerify', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'fundedPsbt', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'skipFinalize')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FundingPsbtVerify clone() => FundingPsbtVerify()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FundingPsbtVerify copyWith(void Function(FundingPsbtVerify) updates) => super.copyWith((message) => updates(message as FundingPsbtVerify)) as FundingPsbtVerify;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundingPsbtVerify create() => FundingPsbtVerify._();
  FundingPsbtVerify createEmptyInstance() => create();
  static $pb.PbList<FundingPsbtVerify> createRepeated() => $pb.PbList<FundingPsbtVerify>();
  @$core.pragma('dart2js:noInline')
  static FundingPsbtVerify getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundingPsbtVerify>(create);
  static FundingPsbtVerify? _defaultInstance;

  ///
  /// The funded but not yet signed PSBT that sends the exact channel capacity
  /// amount to the PK script returned in the open channel message in a previous
  /// step.
  @$pb.TagNumber(1)
  $core.List<$core.int> get fundedPsbt => $_getN(0);
  @$pb.TagNumber(1)
  set fundedPsbt($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFundedPsbt() => $_has(0);
  @$pb.TagNumber(1)
  void clearFundedPsbt() => $_clearField(1);

  /// The pending channel ID of the channel to get the PSBT for.
  @$pb.TagNumber(2)
  $core.List<$core.int> get pendingChanId => $_getN(1);
  @$pb.TagNumber(2)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingChanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingChanId() => $_clearField(2);

  ///
  /// Can only be used if the no_publish flag was set to true in the OpenChannel
  /// call meaning that the caller is solely responsible for publishing the final
  /// funding transaction. If skip_finalize is set to true then lnd will not wait
  /// for a FundingPsbtFinalize state step and instead assumes that a transaction
  /// with the same TXID as the passed in PSBT will eventually confirm.
  /// IT IS ABSOLUTELY IMPERATIVE that the TXID of the transaction that is
  /// eventually published does have the _same TXID_ as the verified PSBT. That
  /// means no inputs or outputs can change, only signatures can be added. If the
  /// TXID changes between this call and the publish step then the channel will
  /// never be created and the funds will be in limbo.
  @$pb.TagNumber(3)
  $core.bool get skipFinalize => $_getBF(2);
  @$pb.TagNumber(3)
  set skipFinalize($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSkipFinalize() => $_has(2);
  @$pb.TagNumber(3)
  void clearSkipFinalize() => $_clearField(3);
}

class FundingPsbtFinalize extends $pb.GeneratedMessage {
  factory FundingPsbtFinalize({
    $core.List<$core.int>? signedPsbt,
    $core.List<$core.int>? pendingChanId,
    $core.List<$core.int>? finalRawTx,
  }) {
    final $result = create();
    if (signedPsbt != null) {
      $result.signedPsbt = signedPsbt;
    }
    if (pendingChanId != null) {
      $result.pendingChanId = pendingChanId;
    }
    if (finalRawTx != null) {
      $result.finalRawTx = finalRawTx;
    }
    return $result;
  }
  FundingPsbtFinalize._() : super();
  factory FundingPsbtFinalize.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FundingPsbtFinalize.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundingPsbtFinalize', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'signedPsbt', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'pendingChanId', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'finalRawTx', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FundingPsbtFinalize clone() => FundingPsbtFinalize()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FundingPsbtFinalize copyWith(void Function(FundingPsbtFinalize) updates) => super.copyWith((message) => updates(message as FundingPsbtFinalize)) as FundingPsbtFinalize;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundingPsbtFinalize create() => FundingPsbtFinalize._();
  FundingPsbtFinalize createEmptyInstance() => create();
  static $pb.PbList<FundingPsbtFinalize> createRepeated() => $pb.PbList<FundingPsbtFinalize>();
  @$core.pragma('dart2js:noInline')
  static FundingPsbtFinalize getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundingPsbtFinalize>(create);
  static FundingPsbtFinalize? _defaultInstance;

  ///
  /// The funded PSBT that contains all witness data to send the exact channel
  /// capacity amount to the PK script returned in the open channel message in a
  /// previous step. Cannot be set at the same time as final_raw_tx.
  @$pb.TagNumber(1)
  $core.List<$core.int> get signedPsbt => $_getN(0);
  @$pb.TagNumber(1)
  set signedPsbt($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignedPsbt() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignedPsbt() => $_clearField(1);

  /// The pending channel ID of the channel to get the PSBT for.
  @$pb.TagNumber(2)
  $core.List<$core.int> get pendingChanId => $_getN(1);
  @$pb.TagNumber(2)
  set pendingChanId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingChanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingChanId() => $_clearField(2);

  ///
  /// As an alternative to the signed PSBT with all witness data, the final raw
  /// wire format transaction can also be specified directly. Cannot be set at the
  /// same time as signed_psbt.
  @$pb.TagNumber(3)
  $core.List<$core.int> get finalRawTx => $_getN(2);
  @$pb.TagNumber(3)
  set finalRawTx($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFinalRawTx() => $_has(2);
  @$pb.TagNumber(3)
  void clearFinalRawTx() => $_clearField(3);
}

enum FundingTransitionMsg_Trigger {
  shimRegister, 
  shimCancel, 
  psbtVerify, 
  psbtFinalize, 
  notSet
}

class FundingTransitionMsg extends $pb.GeneratedMessage {
  factory FundingTransitionMsg({
    FundingShim? shimRegister,
    FundingShimCancel? shimCancel,
    FundingPsbtVerify? psbtVerify,
    FundingPsbtFinalize? psbtFinalize,
  }) {
    final $result = create();
    if (shimRegister != null) {
      $result.shimRegister = shimRegister;
    }
    if (shimCancel != null) {
      $result.shimCancel = shimCancel;
    }
    if (psbtVerify != null) {
      $result.psbtVerify = psbtVerify;
    }
    if (psbtFinalize != null) {
      $result.psbtFinalize = psbtFinalize;
    }
    return $result;
  }
  FundingTransitionMsg._() : super();
  factory FundingTransitionMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FundingTransitionMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, FundingTransitionMsg_Trigger> _FundingTransitionMsg_TriggerByTag = {
    1 : FundingTransitionMsg_Trigger.shimRegister,
    2 : FundingTransitionMsg_Trigger.shimCancel,
    3 : FundingTransitionMsg_Trigger.psbtVerify,
    4 : FundingTransitionMsg_Trigger.psbtFinalize,
    0 : FundingTransitionMsg_Trigger.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundingTransitionMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<FundingShim>(1, _omitFieldNames ? '' : 'shimRegister', subBuilder: FundingShim.create)
    ..aOM<FundingShimCancel>(2, _omitFieldNames ? '' : 'shimCancel', subBuilder: FundingShimCancel.create)
    ..aOM<FundingPsbtVerify>(3, _omitFieldNames ? '' : 'psbtVerify', subBuilder: FundingPsbtVerify.create)
    ..aOM<FundingPsbtFinalize>(4, _omitFieldNames ? '' : 'psbtFinalize', subBuilder: FundingPsbtFinalize.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FundingTransitionMsg clone() => FundingTransitionMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FundingTransitionMsg copyWith(void Function(FundingTransitionMsg) updates) => super.copyWith((message) => updates(message as FundingTransitionMsg)) as FundingTransitionMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundingTransitionMsg create() => FundingTransitionMsg._();
  FundingTransitionMsg createEmptyInstance() => create();
  static $pb.PbList<FundingTransitionMsg> createRepeated() => $pb.PbList<FundingTransitionMsg>();
  @$core.pragma('dart2js:noInline')
  static FundingTransitionMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundingTransitionMsg>(create);
  static FundingTransitionMsg? _defaultInstance;

  FundingTransitionMsg_Trigger whichTrigger() => _FundingTransitionMsg_TriggerByTag[$_whichOneof(0)]!;
  void clearTrigger() => $_clearField($_whichOneof(0));

  ///
  /// The funding shim to register. This should be used before any
  /// channel funding has began by the remote party, as it is intended as a
  /// preparatory step for the full channel funding.
  @$pb.TagNumber(1)
  FundingShim get shimRegister => $_getN(0);
  @$pb.TagNumber(1)
  set shimRegister(FundingShim v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShimRegister() => $_has(0);
  @$pb.TagNumber(1)
  void clearShimRegister() => $_clearField(1);
  @$pb.TagNumber(1)
  FundingShim ensureShimRegister() => $_ensure(0);

  /// Used to cancel an existing registered funding shim.
  @$pb.TagNumber(2)
  FundingShimCancel get shimCancel => $_getN(1);
  @$pb.TagNumber(2)
  set shimCancel(FundingShimCancel v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasShimCancel() => $_has(1);
  @$pb.TagNumber(2)
  void clearShimCancel() => $_clearField(2);
  @$pb.TagNumber(2)
  FundingShimCancel ensureShimCancel() => $_ensure(1);

  ///
  /// Used to continue a funding flow that was initiated to be executed
  /// through a PSBT. This step verifies that the PSBT contains the correct
  /// outputs to fund the channel.
  @$pb.TagNumber(3)
  FundingPsbtVerify get psbtVerify => $_getN(2);
  @$pb.TagNumber(3)
  set psbtVerify(FundingPsbtVerify v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPsbtVerify() => $_has(2);
  @$pb.TagNumber(3)
  void clearPsbtVerify() => $_clearField(3);
  @$pb.TagNumber(3)
  FundingPsbtVerify ensurePsbtVerify() => $_ensure(2);

  ///
  /// Used to continue a funding flow that was initiated to be executed
  /// through a PSBT. This step finalizes the funded and signed PSBT, finishes
  /// negotiation with the peer and finally publishes the resulting funding
  /// transaction.
  @$pb.TagNumber(4)
  FundingPsbtFinalize get psbtFinalize => $_getN(3);
  @$pb.TagNumber(4)
  set psbtFinalize(FundingPsbtFinalize v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPsbtFinalize() => $_has(3);
  @$pb.TagNumber(4)
  void clearPsbtFinalize() => $_clearField(4);
  @$pb.TagNumber(4)
  FundingPsbtFinalize ensurePsbtFinalize() => $_ensure(3);
}

class FundingStateStepResp extends $pb.GeneratedMessage {
  factory FundingStateStepResp() => create();
  FundingStateStepResp._() : super();
  factory FundingStateStepResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FundingStateStepResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FundingStateStepResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FundingStateStepResp clone() => FundingStateStepResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FundingStateStepResp copyWith(void Function(FundingStateStepResp) updates) => super.copyWith((message) => updates(message as FundingStateStepResp)) as FundingStateStepResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FundingStateStepResp create() => FundingStateStepResp._();
  FundingStateStepResp createEmptyInstance() => create();
  static $pb.PbList<FundingStateStepResp> createRepeated() => $pb.PbList<FundingStateStepResp>();
  @$core.pragma('dart2js:noInline')
  static FundingStateStepResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FundingStateStepResp>(create);
  static FundingStateStepResp? _defaultInstance;
}

class PendingHTLC extends $pb.GeneratedMessage {
  factory PendingHTLC({
    $core.bool? incoming,
    $fixnum.Int64? amount,
    $core.String? outpoint,
    $core.int? maturityHeight,
    $core.int? blocksTilMaturity,
    $core.int? stage,
  }) {
    final $result = create();
    if (incoming != null) {
      $result.incoming = incoming;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (outpoint != null) {
      $result.outpoint = outpoint;
    }
    if (maturityHeight != null) {
      $result.maturityHeight = maturityHeight;
    }
    if (blocksTilMaturity != null) {
      $result.blocksTilMaturity = blocksTilMaturity;
    }
    if (stage != null) {
      $result.stage = stage;
    }
    return $result;
  }
  PendingHTLC._() : super();
  factory PendingHTLC.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingHTLC.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingHTLC', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'incoming')
    ..aInt64(2, _omitFieldNames ? '' : 'amount')
    ..aOS(3, _omitFieldNames ? '' : 'outpoint')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maturityHeight', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'blocksTilMaturity', $pb.PbFieldType.O3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'stage', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingHTLC clone() => PendingHTLC()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingHTLC copyWith(void Function(PendingHTLC) updates) => super.copyWith((message) => updates(message as PendingHTLC)) as PendingHTLC;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingHTLC create() => PendingHTLC._();
  PendingHTLC createEmptyInstance() => create();
  static $pb.PbList<PendingHTLC> createRepeated() => $pb.PbList<PendingHTLC>();
  @$core.pragma('dart2js:noInline')
  static PendingHTLC getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingHTLC>(create);
  static PendingHTLC? _defaultInstance;

  /// The direction within the channel that the htlc was sent
  @$pb.TagNumber(1)
  $core.bool get incoming => $_getBF(0);
  @$pb.TagNumber(1)
  set incoming($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncoming() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncoming() => $_clearField(1);

  /// The total value of the htlc
  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);

  /// The final output to be swept back to the user's wallet
  @$pb.TagNumber(3)
  $core.String get outpoint => $_getSZ(2);
  @$pb.TagNumber(3)
  set outpoint($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutpoint() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutpoint() => $_clearField(3);

  /// The next block height at which we can spend the current stage
  @$pb.TagNumber(4)
  $core.int get maturityHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set maturityHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaturityHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaturityHeight() => $_clearField(4);

  ///
  /// The number of blocks remaining until the current stage can be swept.
  /// Negative values indicate how many blocks have passed since becoming
  /// mature.
  @$pb.TagNumber(5)
  $core.int get blocksTilMaturity => $_getIZ(4);
  @$pb.TagNumber(5)
  set blocksTilMaturity($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBlocksTilMaturity() => $_has(4);
  @$pb.TagNumber(5)
  void clearBlocksTilMaturity() => $_clearField(5);

  /// Indicates whether the htlc is in its first or second stage of recovery
  @$pb.TagNumber(6)
  $core.int get stage => $_getIZ(5);
  @$pb.TagNumber(6)
  set stage($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasStage() => $_has(5);
  @$pb.TagNumber(6)
  void clearStage() => $_clearField(6);
}

class PendingChannelsRequest extends $pb.GeneratedMessage {
  factory PendingChannelsRequest({
    $core.bool? includeRawTx,
  }) {
    final $result = create();
    if (includeRawTx != null) {
      $result.includeRawTx = includeRawTx;
    }
    return $result;
  }
  PendingChannelsRequest._() : super();
  factory PendingChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'includeRawTx')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsRequest clone() => PendingChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsRequest copyWith(void Function(PendingChannelsRequest) updates) => super.copyWith((message) => updates(message as PendingChannelsRequest)) as PendingChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsRequest create() => PendingChannelsRequest._();
  PendingChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsRequest> createRepeated() => $pb.PbList<PendingChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsRequest>(create);
  static PendingChannelsRequest? _defaultInstance;

  /// Indicates whether to include the raw transaction hex for
  /// waiting_close_channels.
  @$pb.TagNumber(1)
  $core.bool get includeRawTx => $_getBF(0);
  @$pb.TagNumber(1)
  set includeRawTx($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncludeRawTx() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludeRawTx() => $_clearField(1);
}

class PendingChannelsResponse_PendingChannel extends $pb.GeneratedMessage {
  factory PendingChannelsResponse_PendingChannel({
    $core.String? remoteNodePub,
    $core.String? channelPoint,
    $fixnum.Int64? capacity,
    $fixnum.Int64? localBalance,
    $fixnum.Int64? remoteBalance,
    $fixnum.Int64? localChanReserveSat,
    $fixnum.Int64? remoteChanReserveSat,
    Initiator? initiator,
    CommitmentType? commitmentType,
    $fixnum.Int64? numForwardingPackages,
    $core.String? chanStatusFlags,
    $core.bool? private,
    $core.String? memo,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (remoteNodePub != null) {
      $result.remoteNodePub = remoteNodePub;
    }
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    if (capacity != null) {
      $result.capacity = capacity;
    }
    if (localBalance != null) {
      $result.localBalance = localBalance;
    }
    if (remoteBalance != null) {
      $result.remoteBalance = remoteBalance;
    }
    if (localChanReserveSat != null) {
      $result.localChanReserveSat = localChanReserveSat;
    }
    if (remoteChanReserveSat != null) {
      $result.remoteChanReserveSat = remoteChanReserveSat;
    }
    if (initiator != null) {
      $result.initiator = initiator;
    }
    if (commitmentType != null) {
      $result.commitmentType = commitmentType;
    }
    if (numForwardingPackages != null) {
      $result.numForwardingPackages = numForwardingPackages;
    }
    if (chanStatusFlags != null) {
      $result.chanStatusFlags = chanStatusFlags;
    }
    if (private != null) {
      $result.private = private;
    }
    if (memo != null) {
      $result.memo = memo;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  PendingChannelsResponse_PendingChannel._() : super();
  factory PendingChannelsResponse_PendingChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse_PendingChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse.PendingChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'remoteNodePub')
    ..aOS(2, _omitFieldNames ? '' : 'channelPoint')
    ..aInt64(3, _omitFieldNames ? '' : 'capacity')
    ..aInt64(4, _omitFieldNames ? '' : 'localBalance')
    ..aInt64(5, _omitFieldNames ? '' : 'remoteBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'localChanReserveSat')
    ..aInt64(7, _omitFieldNames ? '' : 'remoteChanReserveSat')
    ..e<Initiator>(8, _omitFieldNames ? '' : 'initiator', $pb.PbFieldType.OE, defaultOrMaker: Initiator.INITIATOR_UNKNOWN, valueOf: Initiator.valueOf, enumValues: Initiator.values)
    ..e<CommitmentType>(9, _omitFieldNames ? '' : 'commitmentType', $pb.PbFieldType.OE, defaultOrMaker: CommitmentType.UNKNOWN_COMMITMENT_TYPE, valueOf: CommitmentType.valueOf, enumValues: CommitmentType.values)
    ..aInt64(10, _omitFieldNames ? '' : 'numForwardingPackages')
    ..aOS(11, _omitFieldNames ? '' : 'chanStatusFlags')
    ..aOB(12, _omitFieldNames ? '' : 'private')
    ..aOS(13, _omitFieldNames ? '' : 'memo')
    ..a<$core.List<$core.int>>(34, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_PendingChannel clone() => PendingChannelsResponse_PendingChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_PendingChannel copyWith(void Function(PendingChannelsResponse_PendingChannel) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse_PendingChannel)) as PendingChannelsResponse_PendingChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_PendingChannel create() => PendingChannelsResponse_PendingChannel._();
  PendingChannelsResponse_PendingChannel createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse_PendingChannel> createRepeated() => $pb.PbList<PendingChannelsResponse_PendingChannel>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_PendingChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse_PendingChannel>(create);
  static PendingChannelsResponse_PendingChannel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get remoteNodePub => $_getSZ(0);
  @$pb.TagNumber(1)
  set remoteNodePub($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRemoteNodePub() => $_has(0);
  @$pb.TagNumber(1)
  void clearRemoteNodePub() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get channelPoint => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelPoint($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelPoint() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get capacity => $_getI64(2);
  @$pb.TagNumber(3)
  set capacity($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCapacity() => $_has(2);
  @$pb.TagNumber(3)
  void clearCapacity() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get localBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set localBalance($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocalBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocalBalance() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get remoteBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set remoteBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRemoteBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearRemoteBalance() => $_clearField(5);

  /// The minimum satoshis this node is required to reserve in its
  /// balance.
  @$pb.TagNumber(6)
  $fixnum.Int64 get localChanReserveSat => $_getI64(5);
  @$pb.TagNumber(6)
  set localChanReserveSat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLocalChanReserveSat() => $_has(5);
  @$pb.TagNumber(6)
  void clearLocalChanReserveSat() => $_clearField(6);

  ///
  /// The minimum satoshis the other node is required to reserve in its
  /// balance.
  @$pb.TagNumber(7)
  $fixnum.Int64 get remoteChanReserveSat => $_getI64(6);
  @$pb.TagNumber(7)
  set remoteChanReserveSat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasRemoteChanReserveSat() => $_has(6);
  @$pb.TagNumber(7)
  void clearRemoteChanReserveSat() => $_clearField(7);

  /// The party that initiated opening the channel.
  @$pb.TagNumber(8)
  Initiator get initiator => $_getN(7);
  @$pb.TagNumber(8)
  set initiator(Initiator v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasInitiator() => $_has(7);
  @$pb.TagNumber(8)
  void clearInitiator() => $_clearField(8);

  /// The commitment type used by this channel.
  @$pb.TagNumber(9)
  CommitmentType get commitmentType => $_getN(8);
  @$pb.TagNumber(9)
  set commitmentType(CommitmentType v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasCommitmentType() => $_has(8);
  @$pb.TagNumber(9)
  void clearCommitmentType() => $_clearField(9);

  /// Total number of forwarding packages created in this channel.
  @$pb.TagNumber(10)
  $fixnum.Int64 get numForwardingPackages => $_getI64(9);
  @$pb.TagNumber(10)
  set numForwardingPackages($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasNumForwardingPackages() => $_has(9);
  @$pb.TagNumber(10)
  void clearNumForwardingPackages() => $_clearField(10);

  /// A set of flags showing the current state of the channel.
  @$pb.TagNumber(11)
  $core.String get chanStatusFlags => $_getSZ(10);
  @$pb.TagNumber(11)
  set chanStatusFlags($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasChanStatusFlags() => $_has(10);
  @$pb.TagNumber(11)
  void clearChanStatusFlags() => $_clearField(11);

  /// Whether this channel is advertised to the network or not.
  @$pb.TagNumber(12)
  $core.bool get private => $_getBF(11);
  @$pb.TagNumber(12)
  set private($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasPrivate() => $_has(11);
  @$pb.TagNumber(12)
  void clearPrivate() => $_clearField(12);

  ///
  /// An optional note-to-self to go along with the channel containing some
  /// useful information. This is only ever stored locally and in no way
  /// impacts the channel's operation.
  @$pb.TagNumber(13)
  $core.String get memo => $_getSZ(12);
  @$pb.TagNumber(13)
  set memo($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMemo() => $_has(12);
  @$pb.TagNumber(13)
  void clearMemo() => $_clearField(13);

  ///
  /// Custom channel data that might be populated in custom channels.
  @$pb.TagNumber(34)
  $core.List<$core.int> get customChannelData => $_getN(13);
  @$pb.TagNumber(34)
  set customChannelData($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(34)
  $core.bool hasCustomChannelData() => $_has(13);
  @$pb.TagNumber(34)
  void clearCustomChannelData() => $_clearField(34);
}

class PendingChannelsResponse_PendingOpenChannel extends $pb.GeneratedMessage {
  factory PendingChannelsResponse_PendingOpenChannel({
    PendingChannelsResponse_PendingChannel? channel,
    $core.int? fundingExpiryBlocks,
    $fixnum.Int64? commitFee,
    $fixnum.Int64? commitWeight,
    $fixnum.Int64? feePerKw,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (fundingExpiryBlocks != null) {
      $result.fundingExpiryBlocks = fundingExpiryBlocks;
    }
    if (commitFee != null) {
      $result.commitFee = commitFee;
    }
    if (commitWeight != null) {
      $result.commitWeight = commitWeight;
    }
    if (feePerKw != null) {
      $result.feePerKw = feePerKw;
    }
    return $result;
  }
  PendingChannelsResponse_PendingOpenChannel._() : super();
  factory PendingChannelsResponse_PendingOpenChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse_PendingOpenChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse.PendingOpenChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<PendingChannelsResponse_PendingChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: PendingChannelsResponse_PendingChannel.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'fundingExpiryBlocks', $pb.PbFieldType.O3)
    ..aInt64(4, _omitFieldNames ? '' : 'commitFee')
    ..aInt64(5, _omitFieldNames ? '' : 'commitWeight')
    ..aInt64(6, _omitFieldNames ? '' : 'feePerKw')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_PendingOpenChannel clone() => PendingChannelsResponse_PendingOpenChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_PendingOpenChannel copyWith(void Function(PendingChannelsResponse_PendingOpenChannel) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse_PendingOpenChannel)) as PendingChannelsResponse_PendingOpenChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_PendingOpenChannel create() => PendingChannelsResponse_PendingOpenChannel._();
  PendingChannelsResponse_PendingOpenChannel createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse_PendingOpenChannel> createRepeated() => $pb.PbList<PendingChannelsResponse_PendingOpenChannel>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_PendingOpenChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse_PendingOpenChannel>(create);
  static PendingChannelsResponse_PendingOpenChannel? _defaultInstance;

  /// The pending channel
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(PendingChannelsResponse_PendingChannel v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel ensureChannel() => $_ensure(0);

  /// The number of blocks until the funding transaction is considered
  /// expired. If this value gets close to zero, there is a risk that the
  /// channel funding will be canceled by the channel responder. The
  /// channel should be fee bumped using CPFP (see walletrpc.BumpFee) to
  /// ensure that the channel confirms in time. Otherwise a force-close
  /// will be necessary if the channel confirms after the funding
  /// transaction expires. A negative value means the channel responder has
  /// very likely canceled the funding and the channel will never become
  /// fully operational.
  @$pb.TagNumber(3)
  $core.int get fundingExpiryBlocks => $_getIZ(1);
  @$pb.TagNumber(3)
  set fundingExpiryBlocks($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasFundingExpiryBlocks() => $_has(1);
  @$pb.TagNumber(3)
  void clearFundingExpiryBlocks() => $_clearField(3);

  ///
  /// The amount calculated to be paid in fees for the current set of
  /// commitment transactions. The fee amount is persisted with the channel
  /// in order to allow the fee amount to be removed and recalculated with
  /// each channel state update, including updates that happen after a system
  /// restart.
  @$pb.TagNumber(4)
  $fixnum.Int64 get commitFee => $_getI64(2);
  @$pb.TagNumber(4)
  set commitFee($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasCommitFee() => $_has(2);
  @$pb.TagNumber(4)
  void clearCommitFee() => $_clearField(4);

  /// The weight of the commitment transaction
  @$pb.TagNumber(5)
  $fixnum.Int64 get commitWeight => $_getI64(3);
  @$pb.TagNumber(5)
  set commitWeight($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasCommitWeight() => $_has(3);
  @$pb.TagNumber(5)
  void clearCommitWeight() => $_clearField(5);

  ///
  /// The required number of satoshis per kilo-weight that the requester will
  /// pay at all times, for both the funding transaction and commitment
  /// transaction. This value can later be updated once the channel is open.
  @$pb.TagNumber(6)
  $fixnum.Int64 get feePerKw => $_getI64(4);
  @$pb.TagNumber(6)
  set feePerKw($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasFeePerKw() => $_has(4);
  @$pb.TagNumber(6)
  void clearFeePerKw() => $_clearField(6);
}

class PendingChannelsResponse_WaitingCloseChannel extends $pb.GeneratedMessage {
  factory PendingChannelsResponse_WaitingCloseChannel({
    PendingChannelsResponse_PendingChannel? channel,
    $fixnum.Int64? limboBalance,
    PendingChannelsResponse_Commitments? commitments,
    $core.String? closingTxid,
    $core.String? closingTxHex,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (limboBalance != null) {
      $result.limboBalance = limboBalance;
    }
    if (commitments != null) {
      $result.commitments = commitments;
    }
    if (closingTxid != null) {
      $result.closingTxid = closingTxid;
    }
    if (closingTxHex != null) {
      $result.closingTxHex = closingTxHex;
    }
    return $result;
  }
  PendingChannelsResponse_WaitingCloseChannel._() : super();
  factory PendingChannelsResponse_WaitingCloseChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse_WaitingCloseChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse.WaitingCloseChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<PendingChannelsResponse_PendingChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: PendingChannelsResponse_PendingChannel.create)
    ..aInt64(2, _omitFieldNames ? '' : 'limboBalance')
    ..aOM<PendingChannelsResponse_Commitments>(3, _omitFieldNames ? '' : 'commitments', subBuilder: PendingChannelsResponse_Commitments.create)
    ..aOS(4, _omitFieldNames ? '' : 'closingTxid')
    ..aOS(5, _omitFieldNames ? '' : 'closingTxHex')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_WaitingCloseChannel clone() => PendingChannelsResponse_WaitingCloseChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_WaitingCloseChannel copyWith(void Function(PendingChannelsResponse_WaitingCloseChannel) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse_WaitingCloseChannel)) as PendingChannelsResponse_WaitingCloseChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_WaitingCloseChannel create() => PendingChannelsResponse_WaitingCloseChannel._();
  PendingChannelsResponse_WaitingCloseChannel createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse_WaitingCloseChannel> createRepeated() => $pb.PbList<PendingChannelsResponse_WaitingCloseChannel>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_WaitingCloseChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse_WaitingCloseChannel>(create);
  static PendingChannelsResponse_WaitingCloseChannel? _defaultInstance;

  /// The pending channel waiting for closing tx to confirm
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(PendingChannelsResponse_PendingChannel v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel ensureChannel() => $_ensure(0);

  /// The balance in satoshis encumbered in this channel
  @$pb.TagNumber(2)
  $fixnum.Int64 get limboBalance => $_getI64(1);
  @$pb.TagNumber(2)
  set limboBalance($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLimboBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimboBalance() => $_clearField(2);

  ///
  /// A list of valid commitment transactions. Any of these can confirm at
  /// this point.
  @$pb.TagNumber(3)
  PendingChannelsResponse_Commitments get commitments => $_getN(2);
  @$pb.TagNumber(3)
  set commitments(PendingChannelsResponse_Commitments v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCommitments() => $_has(2);
  @$pb.TagNumber(3)
  void clearCommitments() => $_clearField(3);
  @$pb.TagNumber(3)
  PendingChannelsResponse_Commitments ensureCommitments() => $_ensure(2);

  /// The transaction id of the closing transaction
  @$pb.TagNumber(4)
  $core.String get closingTxid => $_getSZ(3);
  @$pb.TagNumber(4)
  set closingTxid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasClosingTxid() => $_has(3);
  @$pb.TagNumber(4)
  void clearClosingTxid() => $_clearField(4);

  /// The raw hex encoded bytes of the closing transaction. Included if
  /// include_raw_tx in the request is true.
  @$pb.TagNumber(5)
  $core.String get closingTxHex => $_getSZ(4);
  @$pb.TagNumber(5)
  set closingTxHex($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasClosingTxHex() => $_has(4);
  @$pb.TagNumber(5)
  void clearClosingTxHex() => $_clearField(5);
}

class PendingChannelsResponse_Commitments extends $pb.GeneratedMessage {
  factory PendingChannelsResponse_Commitments({
    $core.String? localTxid,
    $core.String? remoteTxid,
    $core.String? remotePendingTxid,
    $fixnum.Int64? localCommitFeeSat,
    $fixnum.Int64? remoteCommitFeeSat,
    $fixnum.Int64? remotePendingCommitFeeSat,
  }) {
    final $result = create();
    if (localTxid != null) {
      $result.localTxid = localTxid;
    }
    if (remoteTxid != null) {
      $result.remoteTxid = remoteTxid;
    }
    if (remotePendingTxid != null) {
      $result.remotePendingTxid = remotePendingTxid;
    }
    if (localCommitFeeSat != null) {
      $result.localCommitFeeSat = localCommitFeeSat;
    }
    if (remoteCommitFeeSat != null) {
      $result.remoteCommitFeeSat = remoteCommitFeeSat;
    }
    if (remotePendingCommitFeeSat != null) {
      $result.remotePendingCommitFeeSat = remotePendingCommitFeeSat;
    }
    return $result;
  }
  PendingChannelsResponse_Commitments._() : super();
  factory PendingChannelsResponse_Commitments.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse_Commitments.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse.Commitments', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'localTxid')
    ..aOS(2, _omitFieldNames ? '' : 'remoteTxid')
    ..aOS(3, _omitFieldNames ? '' : 'remotePendingTxid')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'localCommitFeeSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'remoteCommitFeeSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'remotePendingCommitFeeSat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_Commitments clone() => PendingChannelsResponse_Commitments()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_Commitments copyWith(void Function(PendingChannelsResponse_Commitments) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse_Commitments)) as PendingChannelsResponse_Commitments;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_Commitments create() => PendingChannelsResponse_Commitments._();
  PendingChannelsResponse_Commitments createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse_Commitments> createRepeated() => $pb.PbList<PendingChannelsResponse_Commitments>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_Commitments getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse_Commitments>(create);
  static PendingChannelsResponse_Commitments? _defaultInstance;

  /// Hash of the local version of the commitment tx.
  @$pb.TagNumber(1)
  $core.String get localTxid => $_getSZ(0);
  @$pb.TagNumber(1)
  set localTxid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocalTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocalTxid() => $_clearField(1);

  /// Hash of the remote version of the commitment tx.
  @$pb.TagNumber(2)
  $core.String get remoteTxid => $_getSZ(1);
  @$pb.TagNumber(2)
  set remoteTxid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRemoteTxid() => $_has(1);
  @$pb.TagNumber(2)
  void clearRemoteTxid() => $_clearField(2);

  /// Hash of the remote pending version of the commitment tx.
  @$pb.TagNumber(3)
  $core.String get remotePendingTxid => $_getSZ(2);
  @$pb.TagNumber(3)
  set remotePendingTxid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRemotePendingTxid() => $_has(2);
  @$pb.TagNumber(3)
  void clearRemotePendingTxid() => $_clearField(3);

  ///
  /// The amount in satoshis calculated to be paid in fees for the local
  /// commitment.
  @$pb.TagNumber(4)
  $fixnum.Int64 get localCommitFeeSat => $_getI64(3);
  @$pb.TagNumber(4)
  set localCommitFeeSat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocalCommitFeeSat() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocalCommitFeeSat() => $_clearField(4);

  ///
  /// The amount in satoshis calculated to be paid in fees for the remote
  /// commitment.
  @$pb.TagNumber(5)
  $fixnum.Int64 get remoteCommitFeeSat => $_getI64(4);
  @$pb.TagNumber(5)
  set remoteCommitFeeSat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRemoteCommitFeeSat() => $_has(4);
  @$pb.TagNumber(5)
  void clearRemoteCommitFeeSat() => $_clearField(5);

  ///
  /// The amount in satoshis calculated to be paid in fees for the remote
  /// pending commitment.
  @$pb.TagNumber(6)
  $fixnum.Int64 get remotePendingCommitFeeSat => $_getI64(5);
  @$pb.TagNumber(6)
  set remotePendingCommitFeeSat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRemotePendingCommitFeeSat() => $_has(5);
  @$pb.TagNumber(6)
  void clearRemotePendingCommitFeeSat() => $_clearField(6);
}

class PendingChannelsResponse_ClosedChannel extends $pb.GeneratedMessage {
  factory PendingChannelsResponse_ClosedChannel({
    PendingChannelsResponse_PendingChannel? channel,
    $core.String? closingTxid,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (closingTxid != null) {
      $result.closingTxid = closingTxid;
    }
    return $result;
  }
  PendingChannelsResponse_ClosedChannel._() : super();
  factory PendingChannelsResponse_ClosedChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse_ClosedChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse.ClosedChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<PendingChannelsResponse_PendingChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: PendingChannelsResponse_PendingChannel.create)
    ..aOS(2, _omitFieldNames ? '' : 'closingTxid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_ClosedChannel clone() => PendingChannelsResponse_ClosedChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_ClosedChannel copyWith(void Function(PendingChannelsResponse_ClosedChannel) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse_ClosedChannel)) as PendingChannelsResponse_ClosedChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_ClosedChannel create() => PendingChannelsResponse_ClosedChannel._();
  PendingChannelsResponse_ClosedChannel createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse_ClosedChannel> createRepeated() => $pb.PbList<PendingChannelsResponse_ClosedChannel>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_ClosedChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse_ClosedChannel>(create);
  static PendingChannelsResponse_ClosedChannel? _defaultInstance;

  /// The pending channel to be closed
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(PendingChannelsResponse_PendingChannel v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel ensureChannel() => $_ensure(0);

  /// The transaction id of the closing transaction
  @$pb.TagNumber(2)
  $core.String get closingTxid => $_getSZ(1);
  @$pb.TagNumber(2)
  set closingTxid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClosingTxid() => $_has(1);
  @$pb.TagNumber(2)
  void clearClosingTxid() => $_clearField(2);
}

class PendingChannelsResponse_ForceClosedChannel extends $pb.GeneratedMessage {
  factory PendingChannelsResponse_ForceClosedChannel({
    PendingChannelsResponse_PendingChannel? channel,
    $core.String? closingTxid,
    $fixnum.Int64? limboBalance,
    $core.int? maturityHeight,
    $core.int? blocksTilMaturity,
    $fixnum.Int64? recoveredBalance,
    $core.Iterable<PendingHTLC>? pendingHtlcs,
    PendingChannelsResponse_ForceClosedChannel_AnchorState? anchor,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    if (closingTxid != null) {
      $result.closingTxid = closingTxid;
    }
    if (limboBalance != null) {
      $result.limboBalance = limboBalance;
    }
    if (maturityHeight != null) {
      $result.maturityHeight = maturityHeight;
    }
    if (blocksTilMaturity != null) {
      $result.blocksTilMaturity = blocksTilMaturity;
    }
    if (recoveredBalance != null) {
      $result.recoveredBalance = recoveredBalance;
    }
    if (pendingHtlcs != null) {
      $result.pendingHtlcs.addAll(pendingHtlcs);
    }
    if (anchor != null) {
      $result.anchor = anchor;
    }
    return $result;
  }
  PendingChannelsResponse_ForceClosedChannel._() : super();
  factory PendingChannelsResponse_ForceClosedChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse_ForceClosedChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse.ForceClosedChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<PendingChannelsResponse_PendingChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: PendingChannelsResponse_PendingChannel.create)
    ..aOS(2, _omitFieldNames ? '' : 'closingTxid')
    ..aInt64(3, _omitFieldNames ? '' : 'limboBalance')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maturityHeight', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'blocksTilMaturity', $pb.PbFieldType.O3)
    ..aInt64(6, _omitFieldNames ? '' : 'recoveredBalance')
    ..pc<PendingHTLC>(8, _omitFieldNames ? '' : 'pendingHtlcs', $pb.PbFieldType.PM, subBuilder: PendingHTLC.create)
    ..e<PendingChannelsResponse_ForceClosedChannel_AnchorState>(9, _omitFieldNames ? '' : 'anchor', $pb.PbFieldType.OE, defaultOrMaker: PendingChannelsResponse_ForceClosedChannel_AnchorState.LIMBO, valueOf: PendingChannelsResponse_ForceClosedChannel_AnchorState.valueOf, enumValues: PendingChannelsResponse_ForceClosedChannel_AnchorState.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_ForceClosedChannel clone() => PendingChannelsResponse_ForceClosedChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse_ForceClosedChannel copyWith(void Function(PendingChannelsResponse_ForceClosedChannel) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse_ForceClosedChannel)) as PendingChannelsResponse_ForceClosedChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_ForceClosedChannel create() => PendingChannelsResponse_ForceClosedChannel._();
  PendingChannelsResponse_ForceClosedChannel createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse_ForceClosedChannel> createRepeated() => $pb.PbList<PendingChannelsResponse_ForceClosedChannel>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse_ForceClosedChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse_ForceClosedChannel>(create);
  static PendingChannelsResponse_ForceClosedChannel? _defaultInstance;

  /// The pending channel to be force closed
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel(PendingChannelsResponse_PendingChannel v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingChannelsResponse_PendingChannel ensureChannel() => $_ensure(0);

  /// The transaction id of the closing transaction
  @$pb.TagNumber(2)
  $core.String get closingTxid => $_getSZ(1);
  @$pb.TagNumber(2)
  set closingTxid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClosingTxid() => $_has(1);
  @$pb.TagNumber(2)
  void clearClosingTxid() => $_clearField(2);

  /// The balance in satoshis encumbered in this pending channel
  @$pb.TagNumber(3)
  $fixnum.Int64 get limboBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set limboBalance($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLimboBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimboBalance() => $_clearField(3);

  /// The height at which funds can be swept into the wallet
  @$pb.TagNumber(4)
  $core.int get maturityHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set maturityHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaturityHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaturityHeight() => $_clearField(4);

  ///
  /// Remaining # of blocks until the commitment output can be swept.
  /// Negative values indicate how many blocks have passed since becoming
  /// mature.
  @$pb.TagNumber(5)
  $core.int get blocksTilMaturity => $_getIZ(4);
  @$pb.TagNumber(5)
  set blocksTilMaturity($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasBlocksTilMaturity() => $_has(4);
  @$pb.TagNumber(5)
  void clearBlocksTilMaturity() => $_clearField(5);

  /// The total value of funds successfully recovered from this channel
  @$pb.TagNumber(6)
  $fixnum.Int64 get recoveredBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set recoveredBalance($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecoveredBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecoveredBalance() => $_clearField(6);

  @$pb.TagNumber(8)
  $pb.PbList<PendingHTLC> get pendingHtlcs => $_getList(6);

  @$pb.TagNumber(9)
  PendingChannelsResponse_ForceClosedChannel_AnchorState get anchor => $_getN(7);
  @$pb.TagNumber(9)
  set anchor(PendingChannelsResponse_ForceClosedChannel_AnchorState v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasAnchor() => $_has(7);
  @$pb.TagNumber(9)
  void clearAnchor() => $_clearField(9);
}

class PendingChannelsResponse extends $pb.GeneratedMessage {
  factory PendingChannelsResponse({
    $fixnum.Int64? totalLimboBalance,
    $core.Iterable<PendingChannelsResponse_PendingOpenChannel>? pendingOpenChannels,
  @$core.Deprecated('This field is deprecated.')
    $core.Iterable<PendingChannelsResponse_ClosedChannel>? pendingClosingChannels,
    $core.Iterable<PendingChannelsResponse_ForceClosedChannel>? pendingForceClosingChannels,
    $core.Iterable<PendingChannelsResponse_WaitingCloseChannel>? waitingCloseChannels,
  }) {
    final $result = create();
    if (totalLimboBalance != null) {
      $result.totalLimboBalance = totalLimboBalance;
    }
    if (pendingOpenChannels != null) {
      $result.pendingOpenChannels.addAll(pendingOpenChannels);
    }
    if (pendingClosingChannels != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.pendingClosingChannels.addAll(pendingClosingChannels);
    }
    if (pendingForceClosingChannels != null) {
      $result.pendingForceClosingChannels.addAll(pendingForceClosingChannels);
    }
    if (waitingCloseChannels != null) {
      $result.waitingCloseChannels.addAll(waitingCloseChannels);
    }
    return $result;
  }
  PendingChannelsResponse._() : super();
  factory PendingChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'totalLimboBalance')
    ..pc<PendingChannelsResponse_PendingOpenChannel>(2, _omitFieldNames ? '' : 'pendingOpenChannels', $pb.PbFieldType.PM, subBuilder: PendingChannelsResponse_PendingOpenChannel.create)
    ..pc<PendingChannelsResponse_ClosedChannel>(3, _omitFieldNames ? '' : 'pendingClosingChannels', $pb.PbFieldType.PM, subBuilder: PendingChannelsResponse_ClosedChannel.create)
    ..pc<PendingChannelsResponse_ForceClosedChannel>(4, _omitFieldNames ? '' : 'pendingForceClosingChannels', $pb.PbFieldType.PM, subBuilder: PendingChannelsResponse_ForceClosedChannel.create)
    ..pc<PendingChannelsResponse_WaitingCloseChannel>(5, _omitFieldNames ? '' : 'waitingCloseChannels', $pb.PbFieldType.PM, subBuilder: PendingChannelsResponse_WaitingCloseChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse clone() => PendingChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingChannelsResponse copyWith(void Function(PendingChannelsResponse) updates) => super.copyWith((message) => updates(message as PendingChannelsResponse)) as PendingChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse create() => PendingChannelsResponse._();
  PendingChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<PendingChannelsResponse> createRepeated() => $pb.PbList<PendingChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static PendingChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingChannelsResponse>(create);
  static PendingChannelsResponse? _defaultInstance;

  /// The balance in satoshis encumbered in pending channels
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalLimboBalance => $_getI64(0);
  @$pb.TagNumber(1)
  set totalLimboBalance($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalLimboBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalLimboBalance() => $_clearField(1);

  /// Channels pending opening
  @$pb.TagNumber(2)
  $pb.PbList<PendingChannelsResponse_PendingOpenChannel> get pendingOpenChannels => $_getList(1);

  ///
  /// Deprecated: Channels pending closing previously contained cooperatively
  /// closed channels with a single confirmation. These channels are now
  /// considered closed from the time we see them on chain.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $pb.PbList<PendingChannelsResponse_ClosedChannel> get pendingClosingChannels => $_getList(2);

  /// Channels pending force closing
  @$pb.TagNumber(4)
  $pb.PbList<PendingChannelsResponse_ForceClosedChannel> get pendingForceClosingChannels => $_getList(3);

  /// Channels waiting for closing tx to confirm
  @$pb.TagNumber(5)
  $pb.PbList<PendingChannelsResponse_WaitingCloseChannel> get waitingCloseChannels => $_getList(4);
}

class ChannelEventSubscription extends $pb.GeneratedMessage {
  factory ChannelEventSubscription() => create();
  ChannelEventSubscription._() : super();
  factory ChannelEventSubscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelEventSubscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelEventSubscription', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelEventSubscription clone() => ChannelEventSubscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelEventSubscription copyWith(void Function(ChannelEventSubscription) updates) => super.copyWith((message) => updates(message as ChannelEventSubscription)) as ChannelEventSubscription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelEventSubscription create() => ChannelEventSubscription._();
  ChannelEventSubscription createEmptyInstance() => create();
  static $pb.PbList<ChannelEventSubscription> createRepeated() => $pb.PbList<ChannelEventSubscription>();
  @$core.pragma('dart2js:noInline')
  static ChannelEventSubscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelEventSubscription>(create);
  static ChannelEventSubscription? _defaultInstance;
}

enum ChannelEventUpdate_Channel {
  openChannel, 
  closedChannel, 
  activeChannel, 
  inactiveChannel, 
  pendingOpenChannel, 
  fullyResolvedChannel, 
  notSet
}

class ChannelEventUpdate extends $pb.GeneratedMessage {
  factory ChannelEventUpdate({
    Channel? openChannel,
    ChannelCloseSummary? closedChannel,
    ChannelPoint? activeChannel,
    ChannelPoint? inactiveChannel,
    ChannelEventUpdate_UpdateType? type,
    PendingUpdate? pendingOpenChannel,
    ChannelPoint? fullyResolvedChannel,
  }) {
    final $result = create();
    if (openChannel != null) {
      $result.openChannel = openChannel;
    }
    if (closedChannel != null) {
      $result.closedChannel = closedChannel;
    }
    if (activeChannel != null) {
      $result.activeChannel = activeChannel;
    }
    if (inactiveChannel != null) {
      $result.inactiveChannel = inactiveChannel;
    }
    if (type != null) {
      $result.type = type;
    }
    if (pendingOpenChannel != null) {
      $result.pendingOpenChannel = pendingOpenChannel;
    }
    if (fullyResolvedChannel != null) {
      $result.fullyResolvedChannel = fullyResolvedChannel;
    }
    return $result;
  }
  ChannelEventUpdate._() : super();
  factory ChannelEventUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelEventUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ChannelEventUpdate_Channel> _ChannelEventUpdate_ChannelByTag = {
    1 : ChannelEventUpdate_Channel.openChannel,
    2 : ChannelEventUpdate_Channel.closedChannel,
    3 : ChannelEventUpdate_Channel.activeChannel,
    4 : ChannelEventUpdate_Channel.inactiveChannel,
    6 : ChannelEventUpdate_Channel.pendingOpenChannel,
    7 : ChannelEventUpdate_Channel.fullyResolvedChannel,
    0 : ChannelEventUpdate_Channel.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelEventUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 6, 7])
    ..aOM<Channel>(1, _omitFieldNames ? '' : 'openChannel', subBuilder: Channel.create)
    ..aOM<ChannelCloseSummary>(2, _omitFieldNames ? '' : 'closedChannel', subBuilder: ChannelCloseSummary.create)
    ..aOM<ChannelPoint>(3, _omitFieldNames ? '' : 'activeChannel', subBuilder: ChannelPoint.create)
    ..aOM<ChannelPoint>(4, _omitFieldNames ? '' : 'inactiveChannel', subBuilder: ChannelPoint.create)
    ..e<ChannelEventUpdate_UpdateType>(5, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: ChannelEventUpdate_UpdateType.OPEN_CHANNEL, valueOf: ChannelEventUpdate_UpdateType.valueOf, enumValues: ChannelEventUpdate_UpdateType.values)
    ..aOM<PendingUpdate>(6, _omitFieldNames ? '' : 'pendingOpenChannel', subBuilder: PendingUpdate.create)
    ..aOM<ChannelPoint>(7, _omitFieldNames ? '' : 'fullyResolvedChannel', subBuilder: ChannelPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelEventUpdate clone() => ChannelEventUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelEventUpdate copyWith(void Function(ChannelEventUpdate) updates) => super.copyWith((message) => updates(message as ChannelEventUpdate)) as ChannelEventUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelEventUpdate create() => ChannelEventUpdate._();
  ChannelEventUpdate createEmptyInstance() => create();
  static $pb.PbList<ChannelEventUpdate> createRepeated() => $pb.PbList<ChannelEventUpdate>();
  @$core.pragma('dart2js:noInline')
  static ChannelEventUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelEventUpdate>(create);
  static ChannelEventUpdate? _defaultInstance;

  ChannelEventUpdate_Channel whichChannel() => _ChannelEventUpdate_ChannelByTag[$_whichOneof(0)]!;
  void clearChannel() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Channel get openChannel => $_getN(0);
  @$pb.TagNumber(1)
  set openChannel(Channel v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOpenChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearOpenChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  Channel ensureOpenChannel() => $_ensure(0);

  @$pb.TagNumber(2)
  ChannelCloseSummary get closedChannel => $_getN(1);
  @$pb.TagNumber(2)
  set closedChannel(ChannelCloseSummary v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasClosedChannel() => $_has(1);
  @$pb.TagNumber(2)
  void clearClosedChannel() => $_clearField(2);
  @$pb.TagNumber(2)
  ChannelCloseSummary ensureClosedChannel() => $_ensure(1);

  @$pb.TagNumber(3)
  ChannelPoint get activeChannel => $_getN(2);
  @$pb.TagNumber(3)
  set activeChannel(ChannelPoint v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasActiveChannel() => $_has(2);
  @$pb.TagNumber(3)
  void clearActiveChannel() => $_clearField(3);
  @$pb.TagNumber(3)
  ChannelPoint ensureActiveChannel() => $_ensure(2);

  @$pb.TagNumber(4)
  ChannelPoint get inactiveChannel => $_getN(3);
  @$pb.TagNumber(4)
  set inactiveChannel(ChannelPoint v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasInactiveChannel() => $_has(3);
  @$pb.TagNumber(4)
  void clearInactiveChannel() => $_clearField(4);
  @$pb.TagNumber(4)
  ChannelPoint ensureInactiveChannel() => $_ensure(3);

  @$pb.TagNumber(5)
  ChannelEventUpdate_UpdateType get type => $_getN(4);
  @$pb.TagNumber(5)
  set type(ChannelEventUpdate_UpdateType v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => $_clearField(5);

  @$pb.TagNumber(6)
  PendingUpdate get pendingOpenChannel => $_getN(5);
  @$pb.TagNumber(6)
  set pendingOpenChannel(PendingUpdate v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPendingOpenChannel() => $_has(5);
  @$pb.TagNumber(6)
  void clearPendingOpenChannel() => $_clearField(6);
  @$pb.TagNumber(6)
  PendingUpdate ensurePendingOpenChannel() => $_ensure(5);

  @$pb.TagNumber(7)
  ChannelPoint get fullyResolvedChannel => $_getN(6);
  @$pb.TagNumber(7)
  set fullyResolvedChannel(ChannelPoint v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasFullyResolvedChannel() => $_has(6);
  @$pb.TagNumber(7)
  void clearFullyResolvedChannel() => $_clearField(7);
  @$pb.TagNumber(7)
  ChannelPoint ensureFullyResolvedChannel() => $_ensure(6);
}

class WalletAccountBalance extends $pb.GeneratedMessage {
  factory WalletAccountBalance({
    $fixnum.Int64? confirmedBalance,
    $fixnum.Int64? unconfirmedBalance,
  }) {
    final $result = create();
    if (confirmedBalance != null) {
      $result.confirmedBalance = confirmedBalance;
    }
    if (unconfirmedBalance != null) {
      $result.unconfirmedBalance = unconfirmedBalance;
    }
    return $result;
  }
  WalletAccountBalance._() : super();
  factory WalletAccountBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WalletAccountBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WalletAccountBalance', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'confirmedBalance')
    ..aInt64(2, _omitFieldNames ? '' : 'unconfirmedBalance')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WalletAccountBalance clone() => WalletAccountBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WalletAccountBalance copyWith(void Function(WalletAccountBalance) updates) => super.copyWith((message) => updates(message as WalletAccountBalance)) as WalletAccountBalance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WalletAccountBalance create() => WalletAccountBalance._();
  WalletAccountBalance createEmptyInstance() => create();
  static $pb.PbList<WalletAccountBalance> createRepeated() => $pb.PbList<WalletAccountBalance>();
  @$core.pragma('dart2js:noInline')
  static WalletAccountBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WalletAccountBalance>(create);
  static WalletAccountBalance? _defaultInstance;

  /// The confirmed balance of the account (with >= 1 confirmations).
  @$pb.TagNumber(1)
  $fixnum.Int64 get confirmedBalance => $_getI64(0);
  @$pb.TagNumber(1)
  set confirmedBalance($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfirmedBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfirmedBalance() => $_clearField(1);

  /// The unconfirmed balance of the account (with 0 confirmations).
  @$pb.TagNumber(2)
  $fixnum.Int64 get unconfirmedBalance => $_getI64(1);
  @$pb.TagNumber(2)
  set unconfirmedBalance($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUnconfirmedBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnconfirmedBalance() => $_clearField(2);
}

class WalletBalanceRequest extends $pb.GeneratedMessage {
  factory WalletBalanceRequest({
    $core.String? account,
    $core.int? minConfs,
  }) {
    final $result = create();
    if (account != null) {
      $result.account = account;
    }
    if (minConfs != null) {
      $result.minConfs = minConfs;
    }
    return $result;
  }
  WalletBalanceRequest._() : super();
  factory WalletBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WalletBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WalletBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'account')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'minConfs', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WalletBalanceRequest clone() => WalletBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WalletBalanceRequest copyWith(void Function(WalletBalanceRequest) updates) => super.copyWith((message) => updates(message as WalletBalanceRequest)) as WalletBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WalletBalanceRequest create() => WalletBalanceRequest._();
  WalletBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<WalletBalanceRequest> createRepeated() => $pb.PbList<WalletBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static WalletBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WalletBalanceRequest>(create);
  static WalletBalanceRequest? _defaultInstance;

  /// The wallet account the balance is shown for.
  /// If this is not specified, the balance of the "default" account is shown.
  @$pb.TagNumber(1)
  $core.String get account => $_getSZ(0);
  @$pb.TagNumber(1)
  set account($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAccount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAccount() => $_clearField(1);

  /// The minimum number of confirmations each one of your outputs used for the
  /// funding transaction must satisfy. If this is not specified, the default
  /// value of 1 is used.
  @$pb.TagNumber(2)
  $core.int get minConfs => $_getIZ(1);
  @$pb.TagNumber(2)
  set minConfs($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMinConfs() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinConfs() => $_clearField(2);
}

class WalletBalanceResponse extends $pb.GeneratedMessage {
  factory WalletBalanceResponse({
    $fixnum.Int64? totalBalance,
    $fixnum.Int64? confirmedBalance,
    $fixnum.Int64? unconfirmedBalance,
    $pb.PbMap<$core.String, WalletAccountBalance>? accountBalance,
    $fixnum.Int64? lockedBalance,
    $fixnum.Int64? reservedBalanceAnchorChan,
  }) {
    final $result = create();
    if (totalBalance != null) {
      $result.totalBalance = totalBalance;
    }
    if (confirmedBalance != null) {
      $result.confirmedBalance = confirmedBalance;
    }
    if (unconfirmedBalance != null) {
      $result.unconfirmedBalance = unconfirmedBalance;
    }
    if (accountBalance != null) {
      $result.accountBalance.addAll(accountBalance);
    }
    if (lockedBalance != null) {
      $result.lockedBalance = lockedBalance;
    }
    if (reservedBalanceAnchorChan != null) {
      $result.reservedBalanceAnchorChan = reservedBalanceAnchorChan;
    }
    return $result;
  }
  WalletBalanceResponse._() : super();
  factory WalletBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WalletBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WalletBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'totalBalance')
    ..aInt64(2, _omitFieldNames ? '' : 'confirmedBalance')
    ..aInt64(3, _omitFieldNames ? '' : 'unconfirmedBalance')
    ..m<$core.String, WalletAccountBalance>(4, _omitFieldNames ? '' : 'accountBalance', entryClassName: 'WalletBalanceResponse.AccountBalanceEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: WalletAccountBalance.create, valueDefaultOrMaker: WalletAccountBalance.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..aInt64(5, _omitFieldNames ? '' : 'lockedBalance')
    ..aInt64(6, _omitFieldNames ? '' : 'reservedBalanceAnchorChan')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WalletBalanceResponse clone() => WalletBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WalletBalanceResponse copyWith(void Function(WalletBalanceResponse) updates) => super.copyWith((message) => updates(message as WalletBalanceResponse)) as WalletBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WalletBalanceResponse create() => WalletBalanceResponse._();
  WalletBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<WalletBalanceResponse> createRepeated() => $pb.PbList<WalletBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static WalletBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WalletBalanceResponse>(create);
  static WalletBalanceResponse? _defaultInstance;

  /// The balance of the wallet
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalBalance => $_getI64(0);
  @$pb.TagNumber(1)
  set totalBalance($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalBalance() => $_clearField(1);

  /// The confirmed balance of a wallet(with >= 1 confirmations)
  @$pb.TagNumber(2)
  $fixnum.Int64 get confirmedBalance => $_getI64(1);
  @$pb.TagNumber(2)
  set confirmedBalance($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConfirmedBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearConfirmedBalance() => $_clearField(2);

  /// The unconfirmed balance of a wallet(with 0 confirmations)
  @$pb.TagNumber(3)
  $fixnum.Int64 get unconfirmedBalance => $_getI64(2);
  @$pb.TagNumber(3)
  set unconfirmedBalance($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnconfirmedBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnconfirmedBalance() => $_clearField(3);

  /// A mapping of each wallet account's name to its balance.
  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, WalletAccountBalance> get accountBalance => $_getMap(3);

  /// The total amount of wallet UTXOs held in outputs that are locked for
  /// other usage.
  @$pb.TagNumber(5)
  $fixnum.Int64 get lockedBalance => $_getI64(4);
  @$pb.TagNumber(5)
  set lockedBalance($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasLockedBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearLockedBalance() => $_clearField(5);

  /// The amount of reserve required.
  @$pb.TagNumber(6)
  $fixnum.Int64 get reservedBalanceAnchorChan => $_getI64(5);
  @$pb.TagNumber(6)
  set reservedBalanceAnchorChan($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasReservedBalanceAnchorChan() => $_has(5);
  @$pb.TagNumber(6)
  void clearReservedBalanceAnchorChan() => $_clearField(6);
}

class Amount extends $pb.GeneratedMessage {
  factory Amount({
    $fixnum.Int64? sat,
    $fixnum.Int64? msat,
  }) {
    final $result = create();
    if (sat != null) {
      $result.sat = sat;
    }
    if (msat != null) {
      $result.msat = msat;
    }
    return $result;
  }
  Amount._() : super();
  factory Amount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Amount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Amount', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'sat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'msat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
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

  /// Value denominated in satoshis.
  @$pb.TagNumber(1)
  $fixnum.Int64 get sat => $_getI64(0);
  @$pb.TagNumber(1)
  set sat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSat() => $_has(0);
  @$pb.TagNumber(1)
  void clearSat() => $_clearField(1);

  /// Value denominated in milli-satoshis.
  @$pb.TagNumber(2)
  $fixnum.Int64 get msat => $_getI64(1);
  @$pb.TagNumber(2)
  set msat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearMsat() => $_clearField(2);
}

class ChannelBalanceRequest extends $pb.GeneratedMessage {
  factory ChannelBalanceRequest() => create();
  ChannelBalanceRequest._() : super();
  factory ChannelBalanceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelBalanceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelBalanceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelBalanceRequest clone() => ChannelBalanceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelBalanceRequest copyWith(void Function(ChannelBalanceRequest) updates) => super.copyWith((message) => updates(message as ChannelBalanceRequest)) as ChannelBalanceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelBalanceRequest create() => ChannelBalanceRequest._();
  ChannelBalanceRequest createEmptyInstance() => create();
  static $pb.PbList<ChannelBalanceRequest> createRepeated() => $pb.PbList<ChannelBalanceRequest>();
  @$core.pragma('dart2js:noInline')
  static ChannelBalanceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelBalanceRequest>(create);
  static ChannelBalanceRequest? _defaultInstance;
}

class ChannelBalanceResponse extends $pb.GeneratedMessage {
  factory ChannelBalanceResponse({
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? balance,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? pendingOpenBalance,
    Amount? localBalance,
    Amount? remoteBalance,
    Amount? unsettledLocalBalance,
    Amount? unsettledRemoteBalance,
    Amount? pendingOpenLocalBalance,
    Amount? pendingOpenRemoteBalance,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (balance != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.balance = balance;
    }
    if (pendingOpenBalance != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.pendingOpenBalance = pendingOpenBalance;
    }
    if (localBalance != null) {
      $result.localBalance = localBalance;
    }
    if (remoteBalance != null) {
      $result.remoteBalance = remoteBalance;
    }
    if (unsettledLocalBalance != null) {
      $result.unsettledLocalBalance = unsettledLocalBalance;
    }
    if (unsettledRemoteBalance != null) {
      $result.unsettledRemoteBalance = unsettledRemoteBalance;
    }
    if (pendingOpenLocalBalance != null) {
      $result.pendingOpenLocalBalance = pendingOpenLocalBalance;
    }
    if (pendingOpenRemoteBalance != null) {
      $result.pendingOpenRemoteBalance = pendingOpenRemoteBalance;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  ChannelBalanceResponse._() : super();
  factory ChannelBalanceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelBalanceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelBalanceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'balance')
    ..aInt64(2, _omitFieldNames ? '' : 'pendingOpenBalance')
    ..aOM<Amount>(3, _omitFieldNames ? '' : 'localBalance', subBuilder: Amount.create)
    ..aOM<Amount>(4, _omitFieldNames ? '' : 'remoteBalance', subBuilder: Amount.create)
    ..aOM<Amount>(5, _omitFieldNames ? '' : 'unsettledLocalBalance', subBuilder: Amount.create)
    ..aOM<Amount>(6, _omitFieldNames ? '' : 'unsettledRemoteBalance', subBuilder: Amount.create)
    ..aOM<Amount>(7, _omitFieldNames ? '' : 'pendingOpenLocalBalance', subBuilder: Amount.create)
    ..aOM<Amount>(8, _omitFieldNames ? '' : 'pendingOpenRemoteBalance', subBuilder: Amount.create)
    ..a<$core.List<$core.int>>(9, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelBalanceResponse clone() => ChannelBalanceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelBalanceResponse copyWith(void Function(ChannelBalanceResponse) updates) => super.copyWith((message) => updates(message as ChannelBalanceResponse)) as ChannelBalanceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelBalanceResponse create() => ChannelBalanceResponse._();
  ChannelBalanceResponse createEmptyInstance() => create();
  static $pb.PbList<ChannelBalanceResponse> createRepeated() => $pb.PbList<ChannelBalanceResponse>();
  @$core.pragma('dart2js:noInline')
  static ChannelBalanceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelBalanceResponse>(create);
  static ChannelBalanceResponse? _defaultInstance;

  /// Deprecated. Sum of channels balances denominated in satoshis
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $fixnum.Int64 get balance => $_getI64(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set balance($fixnum.Int64 v) { $_setInt64(0, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearBalance() => $_clearField(1);

  /// Deprecated. Sum of channels pending balances denominated in satoshis
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $fixnum.Int64 get pendingOpenBalance => $_getI64(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set pendingOpenBalance($fixnum.Int64 v) { $_setInt64(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasPendingOpenBalance() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearPendingOpenBalance() => $_clearField(2);

  /// Sum of channels local balances.
  @$pb.TagNumber(3)
  Amount get localBalance => $_getN(2);
  @$pb.TagNumber(3)
  set localBalance(Amount v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLocalBalance() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocalBalance() => $_clearField(3);
  @$pb.TagNumber(3)
  Amount ensureLocalBalance() => $_ensure(2);

  /// Sum of channels remote balances.
  @$pb.TagNumber(4)
  Amount get remoteBalance => $_getN(3);
  @$pb.TagNumber(4)
  set remoteBalance(Amount v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRemoteBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemoteBalance() => $_clearField(4);
  @$pb.TagNumber(4)
  Amount ensureRemoteBalance() => $_ensure(3);

  /// Sum of channels local unsettled balances.
  @$pb.TagNumber(5)
  Amount get unsettledLocalBalance => $_getN(4);
  @$pb.TagNumber(5)
  set unsettledLocalBalance(Amount v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnsettledLocalBalance() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnsettledLocalBalance() => $_clearField(5);
  @$pb.TagNumber(5)
  Amount ensureUnsettledLocalBalance() => $_ensure(4);

  /// Sum of channels remote unsettled balances.
  @$pb.TagNumber(6)
  Amount get unsettledRemoteBalance => $_getN(5);
  @$pb.TagNumber(6)
  set unsettledRemoteBalance(Amount v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasUnsettledRemoteBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearUnsettledRemoteBalance() => $_clearField(6);
  @$pb.TagNumber(6)
  Amount ensureUnsettledRemoteBalance() => $_ensure(5);

  /// Sum of channels pending local balances.
  @$pb.TagNumber(7)
  Amount get pendingOpenLocalBalance => $_getN(6);
  @$pb.TagNumber(7)
  set pendingOpenLocalBalance(Amount v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPendingOpenLocalBalance() => $_has(6);
  @$pb.TagNumber(7)
  void clearPendingOpenLocalBalance() => $_clearField(7);
  @$pb.TagNumber(7)
  Amount ensurePendingOpenLocalBalance() => $_ensure(6);

  /// Sum of channels pending remote balances.
  @$pb.TagNumber(8)
  Amount get pendingOpenRemoteBalance => $_getN(7);
  @$pb.TagNumber(8)
  set pendingOpenRemoteBalance(Amount v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasPendingOpenRemoteBalance() => $_has(7);
  @$pb.TagNumber(8)
  void clearPendingOpenRemoteBalance() => $_clearField(8);
  @$pb.TagNumber(8)
  Amount ensurePendingOpenRemoteBalance() => $_ensure(7);

  ///
  /// Custom channel data that might be populated if there are custom channels
  /// present.
  @$pb.TagNumber(9)
  $core.List<$core.int> get customChannelData => $_getN(8);
  @$pb.TagNumber(9)
  set customChannelData($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCustomChannelData() => $_has(8);
  @$pb.TagNumber(9)
  void clearCustomChannelData() => $_clearField(9);
}

class QueryRoutesRequest extends $pb.GeneratedMessage {
  factory QueryRoutesRequest({
    $core.String? pubKey,
    $fixnum.Int64? amt,
    $core.int? finalCltvDelta,
    FeeLimit? feeLimit,
    $core.Iterable<$core.List<$core.int>>? ignoredNodes,
  @$core.Deprecated('This field is deprecated.')
    $core.Iterable<EdgeLocator>? ignoredEdges,
    $core.String? sourcePubKey,
    $core.bool? useMissionControl,
    $core.Iterable<NodePair>? ignoredPairs,
    $core.int? cltvLimit,
    $fixnum.Int64? amtMsat,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? destCustomRecords,
    $fixnum.Int64? outgoingChanId,
    $core.List<$core.int>? lastHopPubkey,
    $core.Iterable<RouteHint>? routeHints,
    $core.Iterable<FeatureBit>? destFeatures,
    $core.double? timePref,
    $core.Iterable<BlindedPaymentPath>? blindedPaymentPaths,
  }) {
    final $result = create();
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    if (amt != null) {
      $result.amt = amt;
    }
    if (finalCltvDelta != null) {
      $result.finalCltvDelta = finalCltvDelta;
    }
    if (feeLimit != null) {
      $result.feeLimit = feeLimit;
    }
    if (ignoredNodes != null) {
      $result.ignoredNodes.addAll(ignoredNodes);
    }
    if (ignoredEdges != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.ignoredEdges.addAll(ignoredEdges);
    }
    if (sourcePubKey != null) {
      $result.sourcePubKey = sourcePubKey;
    }
    if (useMissionControl != null) {
      $result.useMissionControl = useMissionControl;
    }
    if (ignoredPairs != null) {
      $result.ignoredPairs.addAll(ignoredPairs);
    }
    if (cltvLimit != null) {
      $result.cltvLimit = cltvLimit;
    }
    if (amtMsat != null) {
      $result.amtMsat = amtMsat;
    }
    if (destCustomRecords != null) {
      $result.destCustomRecords.addAll(destCustomRecords);
    }
    if (outgoingChanId != null) {
      $result.outgoingChanId = outgoingChanId;
    }
    if (lastHopPubkey != null) {
      $result.lastHopPubkey = lastHopPubkey;
    }
    if (routeHints != null) {
      $result.routeHints.addAll(routeHints);
    }
    if (destFeatures != null) {
      $result.destFeatures.addAll(destFeatures);
    }
    if (timePref != null) {
      $result.timePref = timePref;
    }
    if (blindedPaymentPaths != null) {
      $result.blindedPaymentPaths.addAll(blindedPaymentPaths);
    }
    return $result;
  }
  QueryRoutesRequest._() : super();
  factory QueryRoutesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryRoutesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryRoutesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubKey')
    ..aInt64(2, _omitFieldNames ? '' : 'amt')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'finalCltvDelta', $pb.PbFieldType.O3)
    ..aOM<FeeLimit>(5, _omitFieldNames ? '' : 'feeLimit', subBuilder: FeeLimit.create)
    ..p<$core.List<$core.int>>(6, _omitFieldNames ? '' : 'ignoredNodes', $pb.PbFieldType.PY)
    ..pc<EdgeLocator>(7, _omitFieldNames ? '' : 'ignoredEdges', $pb.PbFieldType.PM, subBuilder: EdgeLocator.create)
    ..aOS(8, _omitFieldNames ? '' : 'sourcePubKey')
    ..aOB(9, _omitFieldNames ? '' : 'useMissionControl')
    ..pc<NodePair>(10, _omitFieldNames ? '' : 'ignoredPairs', $pb.PbFieldType.PM, subBuilder: NodePair.create)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'cltvLimit', $pb.PbFieldType.OU3)
    ..aInt64(12, _omitFieldNames ? '' : 'amtMsat')
    ..m<$fixnum.Int64, $core.List<$core.int>>(13, _omitFieldNames ? '' : 'destCustomRecords', entryClassName: 'QueryRoutesRequest.DestCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..a<$fixnum.Int64>(14, _omitFieldNames ? '' : 'outgoingChanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(15, _omitFieldNames ? '' : 'lastHopPubkey', $pb.PbFieldType.OY)
    ..pc<RouteHint>(16, _omitFieldNames ? '' : 'routeHints', $pb.PbFieldType.PM, subBuilder: RouteHint.create)
    ..pc<FeatureBit>(17, _omitFieldNames ? '' : 'destFeatures', $pb.PbFieldType.KE, valueOf: FeatureBit.valueOf, enumValues: FeatureBit.values, defaultEnumValue: FeatureBit.DATALOSS_PROTECT_REQ)
    ..a<$core.double>(18, _omitFieldNames ? '' : 'timePref', $pb.PbFieldType.OD)
    ..pc<BlindedPaymentPath>(19, _omitFieldNames ? '' : 'blindedPaymentPaths', $pb.PbFieldType.PM, subBuilder: BlindedPaymentPath.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryRoutesRequest clone() => QueryRoutesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryRoutesRequest copyWith(void Function(QueryRoutesRequest) updates) => super.copyWith((message) => updates(message as QueryRoutesRequest)) as QueryRoutesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryRoutesRequest create() => QueryRoutesRequest._();
  QueryRoutesRequest createEmptyInstance() => create();
  static $pb.PbList<QueryRoutesRequest> createRepeated() => $pb.PbList<QueryRoutesRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryRoutesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryRoutesRequest>(create);
  static QueryRoutesRequest? _defaultInstance;

  /// The 33-byte hex-encoded public key for the payment destination
  @$pb.TagNumber(1)
  $core.String get pubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => $_clearField(1);

  ///
  /// The amount to send expressed in satoshis.
  ///
  /// The fields amt and amt_msat are mutually exclusive.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amt => $_getI64(1);
  @$pb.TagNumber(2)
  set amt($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmt() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmt() => $_clearField(2);

  ///
  /// An optional CLTV delta from the current height that should be used for the
  /// timelock of the final hop. Note that unlike SendPayment, QueryRoutes does
  /// not add any additional block padding on top of final_ctlv_delta. This
  /// padding of a few blocks needs to be added manually or otherwise failures may
  /// happen when a block comes in while the payment is in flight.
  ///
  /// Note: must not be set if making a payment to a blinded path (delta is
  /// set by the aggregate parameters provided by blinded_payment_paths)
  @$pb.TagNumber(4)
  $core.int get finalCltvDelta => $_getIZ(2);
  @$pb.TagNumber(4)
  set finalCltvDelta($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasFinalCltvDelta() => $_has(2);
  @$pb.TagNumber(4)
  void clearFinalCltvDelta() => $_clearField(4);

  ///
  /// The maximum number of satoshis that will be paid as a fee of the payment.
  /// This value can be represented either as a percentage of the amount being
  /// sent, or as a fixed amount of the maximum fee the user is willing the pay to
  /// send the payment. If not specified, lnd will use a default value of 100%
  /// fees for small amounts (<=1k sat) or 5% fees for larger amounts.
  @$pb.TagNumber(5)
  FeeLimit get feeLimit => $_getN(3);
  @$pb.TagNumber(5)
  set feeLimit(FeeLimit v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFeeLimit() => $_has(3);
  @$pb.TagNumber(5)
  void clearFeeLimit() => $_clearField(5);
  @$pb.TagNumber(5)
  FeeLimit ensureFeeLimit() => $_ensure(3);

  ///
  /// A list of nodes to ignore during path finding. When using REST, these fields
  /// must be encoded as base64.
  @$pb.TagNumber(6)
  $pb.PbList<$core.List<$core.int>> get ignoredNodes => $_getList(4);

  ///
  /// Deprecated. A list of edges to ignore during path finding.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(7)
  $pb.PbList<EdgeLocator> get ignoredEdges => $_getList(5);

  ///
  /// The source node where the request route should originated from. If empty,
  /// self is assumed.
  @$pb.TagNumber(8)
  $core.String get sourcePubKey => $_getSZ(6);
  @$pb.TagNumber(8)
  set sourcePubKey($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasSourcePubKey() => $_has(6);
  @$pb.TagNumber(8)
  void clearSourcePubKey() => $_clearField(8);

  ///
  /// If set to true, edge probabilities from mission control will be used to get
  /// the optimal route.
  @$pb.TagNumber(9)
  $core.bool get useMissionControl => $_getBF(7);
  @$pb.TagNumber(9)
  set useMissionControl($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasUseMissionControl() => $_has(7);
  @$pb.TagNumber(9)
  void clearUseMissionControl() => $_clearField(9);

  ///
  /// A list of directed node pairs that will be ignored during path finding.
  @$pb.TagNumber(10)
  $pb.PbList<NodePair> get ignoredPairs => $_getList(8);

  ///
  /// An optional maximum total time lock for the route. If the source is empty or
  /// ourselves, this should not exceed lnd's `--max-cltv-expiry` setting. If
  /// zero, then the value of `--max-cltv-expiry` is used as the limit.
  @$pb.TagNumber(11)
  $core.int get cltvLimit => $_getIZ(9);
  @$pb.TagNumber(11)
  set cltvLimit($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasCltvLimit() => $_has(9);
  @$pb.TagNumber(11)
  void clearCltvLimit() => $_clearField(11);

  ///
  /// The amount to send expressed in millisatoshis.
  ///
  /// The fields amt and amt_msat are mutually exclusive.
  @$pb.TagNumber(12)
  $fixnum.Int64 get amtMsat => $_getI64(10);
  @$pb.TagNumber(12)
  set amtMsat($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasAmtMsat() => $_has(10);
  @$pb.TagNumber(12)
  void clearAmtMsat() => $_clearField(12);

  ///
  /// An optional field that can be used to pass an arbitrary set of TLV records
  /// to a peer which understands the new records. This can be used to pass
  /// application specific data during the payment attempt. If the destination
  /// does not support the specified records, an error will be returned.
  /// Record types are required to be in the custom range >= 65536. When using
  /// REST, the values must be encoded as base64.
  @$pb.TagNumber(13)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get destCustomRecords => $_getMap(11);

  ///
  /// The channel id of the channel that must be taken to the first hop. If zero,
  /// any channel may be used.
  @$pb.TagNumber(14)
  $fixnum.Int64 get outgoingChanId => $_getI64(12);
  @$pb.TagNumber(14)
  set outgoingChanId($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(14)
  $core.bool hasOutgoingChanId() => $_has(12);
  @$pb.TagNumber(14)
  void clearOutgoingChanId() => $_clearField(14);

  ///
  /// The pubkey of the last hop of the route. If empty, any hop may be used.
  @$pb.TagNumber(15)
  $core.List<$core.int> get lastHopPubkey => $_getN(13);
  @$pb.TagNumber(15)
  set lastHopPubkey($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(15)
  $core.bool hasLastHopPubkey() => $_has(13);
  @$pb.TagNumber(15)
  void clearLastHopPubkey() => $_clearField(15);

  ///
  /// Optional route hints to reach the destination through private channels.
  @$pb.TagNumber(16)
  $pb.PbList<RouteHint> get routeHints => $_getList(14);

  ///
  /// Features assumed to be supported by the final node. All transitive feature
  /// dependencies must also be set properly. For a given feature bit pair, either
  /// optional or remote may be set, but not both. If this field is nil or empty,
  /// the router will try to load destination features from the graph as a
  /// fallback.
  ///
  /// Note: must not be set if making a payment to a blinded route (features
  /// are provided in blinded_payment_paths).
  @$pb.TagNumber(17)
  $pb.PbList<FeatureBit> get destFeatures => $_getList(15);

  ///
  /// The time preference for this payment. Set to -1 to optimize for fees
  /// only, to 1 to optimize for reliability only or a value inbetween for a mix.
  @$pb.TagNumber(18)
  $core.double get timePref => $_getN(16);
  @$pb.TagNumber(18)
  set timePref($core.double v) { $_setDouble(16, v); }
  @$pb.TagNumber(18)
  $core.bool hasTimePref() => $_has(16);
  @$pb.TagNumber(18)
  void clearTimePref() => $_clearField(18);

  ///
  /// An optional blinded path(s) to reach the destination. Note that the
  /// introduction node must be provided as the first hop in the route.
  @$pb.TagNumber(19)
  $pb.PbList<BlindedPaymentPath> get blindedPaymentPaths => $_getList(17);
}

class NodePair extends $pb.GeneratedMessage {
  factory NodePair({
    $core.List<$core.int>? from,
    $core.List<$core.int>? to,
  }) {
    final $result = create();
    if (from != null) {
      $result.from = from;
    }
    if (to != null) {
      $result.to = to;
    }
    return $result;
  }
  NodePair._() : super();
  factory NodePair.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodePair.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodePair', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'from', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'to', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodePair clone() => NodePair()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodePair copyWith(void Function(NodePair) updates) => super.copyWith((message) => updates(message as NodePair)) as NodePair;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodePair create() => NodePair._();
  NodePair createEmptyInstance() => create();
  static $pb.PbList<NodePair> createRepeated() => $pb.PbList<NodePair>();
  @$core.pragma('dart2js:noInline')
  static NodePair getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodePair>(create);
  static NodePair? _defaultInstance;

  ///
  /// The sending node of the pair. When using REST, this field must be encoded as
  /// base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get from => $_getN(0);
  @$pb.TagNumber(1)
  set from($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearFrom() => $_clearField(1);

  ///
  /// The receiving node of the pair. When using REST, this field must be encoded
  /// as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get to => $_getN(1);
  @$pb.TagNumber(2)
  set to($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearTo() => $_clearField(2);
}

class EdgeLocator extends $pb.GeneratedMessage {
  factory EdgeLocator({
    $fixnum.Int64? channelId,
    $core.bool? directionReverse,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (directionReverse != null) {
      $result.directionReverse = directionReverse;
    }
    return $result;
  }
  EdgeLocator._() : super();
  factory EdgeLocator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EdgeLocator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EdgeLocator', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'channelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(2, _omitFieldNames ? '' : 'directionReverse')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EdgeLocator clone() => EdgeLocator()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EdgeLocator copyWith(void Function(EdgeLocator) updates) => super.copyWith((message) => updates(message as EdgeLocator)) as EdgeLocator;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EdgeLocator create() => EdgeLocator._();
  EdgeLocator createEmptyInstance() => create();
  static $pb.PbList<EdgeLocator> createRepeated() => $pb.PbList<EdgeLocator>();
  @$core.pragma('dart2js:noInline')
  static EdgeLocator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EdgeLocator>(create);
  static EdgeLocator? _defaultInstance;

  /// The short channel id of this edge.
  @$pb.TagNumber(1)
  $fixnum.Int64 get channelId => $_getI64(0);
  @$pb.TagNumber(1)
  set channelId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  ///
  /// The direction of this edge. If direction_reverse is false, the direction
  /// of this edge is from the channel endpoint with the lexicographically smaller
  /// pub key to the endpoint with the larger pub key. If direction_reverse is
  /// is true, the edge goes the other way.
  @$pb.TagNumber(2)
  $core.bool get directionReverse => $_getBF(1);
  @$pb.TagNumber(2)
  set directionReverse($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirectionReverse() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirectionReverse() => $_clearField(2);
}

class QueryRoutesResponse extends $pb.GeneratedMessage {
  factory QueryRoutesResponse({
    $core.Iterable<Route>? routes,
    $core.double? successProb,
  }) {
    final $result = create();
    if (routes != null) {
      $result.routes.addAll(routes);
    }
    if (successProb != null) {
      $result.successProb = successProb;
    }
    return $result;
  }
  QueryRoutesResponse._() : super();
  factory QueryRoutesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryRoutesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryRoutesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Route>(1, _omitFieldNames ? '' : 'routes', $pb.PbFieldType.PM, subBuilder: Route.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'successProb', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryRoutesResponse clone() => QueryRoutesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryRoutesResponse copyWith(void Function(QueryRoutesResponse) updates) => super.copyWith((message) => updates(message as QueryRoutesResponse)) as QueryRoutesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryRoutesResponse create() => QueryRoutesResponse._();
  QueryRoutesResponse createEmptyInstance() => create();
  static $pb.PbList<QueryRoutesResponse> createRepeated() => $pb.PbList<QueryRoutesResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryRoutesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryRoutesResponse>(create);
  static QueryRoutesResponse? _defaultInstance;

  ///
  /// The route that results from the path finding operation. This is still a
  /// repeated field to retain backwards compatibility.
  @$pb.TagNumber(1)
  $pb.PbList<Route> get routes => $_getList(0);

  ///
  /// The success probability of the returned route based on the current mission
  /// control state. [EXPERIMENTAL]
  @$pb.TagNumber(2)
  $core.double get successProb => $_getN(1);
  @$pb.TagNumber(2)
  set successProb($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessProb() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessProb() => $_clearField(2);
}

class Hop extends $pb.GeneratedMessage {
  factory Hop({
    $fixnum.Int64? chanId,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? chanCapacity,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? amtToForward,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? fee,
    $core.int? expiry,
    $fixnum.Int64? amtToForwardMsat,
    $fixnum.Int64? feeMsat,
    $core.String? pubKey,
  @$core.Deprecated('This field is deprecated.')
    $core.bool? tlvPayload,
    MPPRecord? mppRecord,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? customRecords,
    AMPRecord? ampRecord,
    $core.List<$core.int>? metadata,
    $core.List<$core.int>? blindingPoint,
    $core.List<$core.int>? encryptedData,
    $fixnum.Int64? totalAmtMsat,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (chanCapacity != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.chanCapacity = chanCapacity;
    }
    if (amtToForward != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.amtToForward = amtToForward;
    }
    if (fee != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.fee = fee;
    }
    if (expiry != null) {
      $result.expiry = expiry;
    }
    if (amtToForwardMsat != null) {
      $result.amtToForwardMsat = amtToForwardMsat;
    }
    if (feeMsat != null) {
      $result.feeMsat = feeMsat;
    }
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    if (tlvPayload != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.tlvPayload = tlvPayload;
    }
    if (mppRecord != null) {
      $result.mppRecord = mppRecord;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    if (ampRecord != null) {
      $result.ampRecord = ampRecord;
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (blindingPoint != null) {
      $result.blindingPoint = blindingPoint;
    }
    if (encryptedData != null) {
      $result.encryptedData = encryptedData;
    }
    if (totalAmtMsat != null) {
      $result.totalAmtMsat = totalAmtMsat;
    }
    return $result;
  }
  Hop._() : super();
  factory Hop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Hop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Hop', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(2, _omitFieldNames ? '' : 'chanCapacity')
    ..aInt64(3, _omitFieldNames ? '' : 'amtToForward')
    ..aInt64(4, _omitFieldNames ? '' : 'fee')
    ..a<$core.int>(5, _omitFieldNames ? '' : 'expiry', $pb.PbFieldType.OU3)
    ..aInt64(6, _omitFieldNames ? '' : 'amtToForwardMsat')
    ..aInt64(7, _omitFieldNames ? '' : 'feeMsat')
    ..aOS(8, _omitFieldNames ? '' : 'pubKey')
    ..aOB(9, _omitFieldNames ? '' : 'tlvPayload')
    ..aOM<MPPRecord>(10, _omitFieldNames ? '' : 'mppRecord', subBuilder: MPPRecord.create)
    ..m<$fixnum.Int64, $core.List<$core.int>>(11, _omitFieldNames ? '' : 'customRecords', entryClassName: 'Hop.CustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..aOM<AMPRecord>(12, _omitFieldNames ? '' : 'ampRecord', subBuilder: AMPRecord.create)
    ..a<$core.List<$core.int>>(13, _omitFieldNames ? '' : 'metadata', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(14, _omitFieldNames ? '' : 'blindingPoint', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(15, _omitFieldNames ? '' : 'encryptedData', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(16, _omitFieldNames ? '' : 'totalAmtMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Hop clone() => Hop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Hop copyWith(void Function(Hop) updates) => super.copyWith((message) => updates(message as Hop)) as Hop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Hop create() => Hop._();
  Hop createEmptyInstance() => create();
  static $pb.PbList<Hop> createRepeated() => $pb.PbList<Hop>();
  @$core.pragma('dart2js:noInline')
  static Hop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Hop>(create);
  static Hop? _defaultInstance;

  ///
  /// The unique channel ID for the channel. The first 3 bytes are the block
  /// height, the next 3 the index within the block, and the last 2 bytes are the
  /// output index for the channel.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $fixnum.Int64 get chanCapacity => $_getI64(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set chanCapacity($fixnum.Int64 v) { $_setInt64(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasChanCapacity() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearChanCapacity() => $_clearField(2);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $fixnum.Int64 get amtToForward => $_getI64(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set amtToForward($fixnum.Int64 v) { $_setInt64(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasAmtToForward() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearAmtToForward() => $_clearField(3);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $fixnum.Int64 get fee => $_getI64(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  set fee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  $core.bool hasFee() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(4)
  void clearFee() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get expiry => $_getIZ(4);
  @$pb.TagNumber(5)
  set expiry($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiry() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiry() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get amtToForwardMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set amtToForwardMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmtToForwardMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmtToForwardMsat() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get feeMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set feeMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFeeMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeeMsat() => $_clearField(7);

  ///
  /// An optional public key of the hop. If the public key is given, the payment
  /// can be executed without relying on a copy of the channel graph.
  @$pb.TagNumber(8)
  $core.String get pubKey => $_getSZ(7);
  @$pb.TagNumber(8)
  set pubKey($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasPubKey() => $_has(7);
  @$pb.TagNumber(8)
  void clearPubKey() => $_clearField(8);

  ///
  /// If set to true, then this hop will be encoded using the new variable length
  /// TLV format. Note that if any custom tlv_records below are specified, then
  /// this field MUST be set to true for them to be encoded properly.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  $core.bool get tlvPayload => $_getBF(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  set tlvPayload($core.bool v) { $_setBool(8, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  $core.bool hasTlvPayload() => $_has(8);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(9)
  void clearTlvPayload() => $_clearField(9);

  ///
  /// An optional TLV record that signals the use of an MPP payment. If present,
  /// the receiver will enforce that the same mpp_record is included in the final
  /// hop payload of all non-zero payments in the HTLC set. If empty, a regular
  /// single-shot payment is or was attempted.
  @$pb.TagNumber(10)
  MPPRecord get mppRecord => $_getN(9);
  @$pb.TagNumber(10)
  set mppRecord(MPPRecord v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasMppRecord() => $_has(9);
  @$pb.TagNumber(10)
  void clearMppRecord() => $_clearField(10);
  @$pb.TagNumber(10)
  MPPRecord ensureMppRecord() => $_ensure(9);

  ///
  /// An optional set of key-value TLV records. This is useful within the context
  /// of the SendToRoute call as it allows callers to specify arbitrary K-V pairs
  /// to drop off at each hop within the onion.
  @$pb.TagNumber(11)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get customRecords => $_getMap(10);

  ///
  /// An optional TLV record that signals the use of an AMP payment. If present,
  /// the receiver will treat all received payments including the same
  /// (payment_addr, set_id) pair  as being part of one logical payment. The
  /// payment will be settled by XORing the root_share's together and deriving the
  /// child hashes and preimages according to BOLT XX. Must be used in conjunction
  /// with mpp_record.
  @$pb.TagNumber(12)
  AMPRecord get ampRecord => $_getN(11);
  @$pb.TagNumber(12)
  set ampRecord(AMPRecord v) { $_setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasAmpRecord() => $_has(11);
  @$pb.TagNumber(12)
  void clearAmpRecord() => $_clearField(12);
  @$pb.TagNumber(12)
  AMPRecord ensureAmpRecord() => $_ensure(11);

  /// The payment metadata to send along with the payment to the payee.
  @$pb.TagNumber(13)
  $core.List<$core.int> get metadata => $_getN(12);
  @$pb.TagNumber(13)
  set metadata($core.List<$core.int> v) { $_setBytes(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearMetadata() => $_clearField(13);

  ///
  /// Blinding point is an optional blinding point included for introduction
  /// nodes in blinded paths. This field is mandatory for hops that represents
  /// the introduction point in a blinded path.
  @$pb.TagNumber(14)
  $core.List<$core.int> get blindingPoint => $_getN(13);
  @$pb.TagNumber(14)
  set blindingPoint($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasBlindingPoint() => $_has(13);
  @$pb.TagNumber(14)
  void clearBlindingPoint() => $_clearField(14);

  ///
  /// Encrypted data is a receiver-produced blob of data that provides hops
  /// in a blinded route with forwarding data. As this data is encrypted by
  /// the recipient, we will not be able to parse it - it is essentially an
  /// arbitrary blob of data from our node's perspective. This field is
  /// mandatory for all hops in a blinded path, including the introduction
  /// node.
  @$pb.TagNumber(15)
  $core.List<$core.int> get encryptedData => $_getN(14);
  @$pb.TagNumber(15)
  set encryptedData($core.List<$core.int> v) { $_setBytes(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasEncryptedData() => $_has(14);
  @$pb.TagNumber(15)
  void clearEncryptedData() => $_clearField(15);

  ///
  /// The total amount that is sent to the recipient (possibly across multiple
  /// HTLCs), as specified by the sender when making a payment to a blinded path.
  /// This value is only set in the final hop payload of a blinded payment. This
  /// value is analogous to the MPPRecord that is used for regular (non-blinded)
  /// MPP payments.
  @$pb.TagNumber(16)
  $fixnum.Int64 get totalAmtMsat => $_getI64(15);
  @$pb.TagNumber(16)
  set totalAmtMsat($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(16)
  $core.bool hasTotalAmtMsat() => $_has(15);
  @$pb.TagNumber(16)
  void clearTotalAmtMsat() => $_clearField(16);
}

class MPPRecord extends $pb.GeneratedMessage {
  factory MPPRecord({
    $fixnum.Int64? totalAmtMsat,
    $core.List<$core.int>? paymentAddr,
  }) {
    final $result = create();
    if (totalAmtMsat != null) {
      $result.totalAmtMsat = totalAmtMsat;
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    return $result;
  }
  MPPRecord._() : super();
  factory MPPRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MPPRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MPPRecord', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aInt64(10, _omitFieldNames ? '' : 'totalAmtMsat')
    ..a<$core.List<$core.int>>(11, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MPPRecord clone() => MPPRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MPPRecord copyWith(void Function(MPPRecord) updates) => super.copyWith((message) => updates(message as MPPRecord)) as MPPRecord;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MPPRecord create() => MPPRecord._();
  MPPRecord createEmptyInstance() => create();
  static $pb.PbList<MPPRecord> createRepeated() => $pb.PbList<MPPRecord>();
  @$core.pragma('dart2js:noInline')
  static MPPRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MPPRecord>(create);
  static MPPRecord? _defaultInstance;

  ///
  /// The total amount in milli-satoshis being sent as part of a larger multi-path
  /// payment. The caller is responsible for ensuring subpayments to the same node
  /// and payment_hash sum exactly to total_amt_msat. The same
  /// total_amt_msat must be used on all subpayments.
  @$pb.TagNumber(10)
  $fixnum.Int64 get totalAmtMsat => $_getI64(0);
  @$pb.TagNumber(10)
  set totalAmtMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(10)
  $core.bool hasTotalAmtMsat() => $_has(0);
  @$pb.TagNumber(10)
  void clearTotalAmtMsat() => $_clearField(10);

  ///
  /// A unique, random identifier used to authenticate the sender as the intended
  /// payer of a multi-path payment. The payment_addr must be the same for all
  /// subpayments, and match the payment_addr provided in the receiver's invoice.
  /// The same payment_addr must be used on all subpayments. This is also called
  /// payment secret in specifications (e.g. BOLT 11).
  @$pb.TagNumber(11)
  $core.List<$core.int> get paymentAddr => $_getN(1);
  @$pb.TagNumber(11)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentAddr() => $_has(1);
  @$pb.TagNumber(11)
  void clearPaymentAddr() => $_clearField(11);
}

class AMPRecord extends $pb.GeneratedMessage {
  factory AMPRecord({
    $core.List<$core.int>? rootShare,
    $core.List<$core.int>? setId,
    $core.int? childIndex,
  }) {
    final $result = create();
    if (rootShare != null) {
      $result.rootShare = rootShare;
    }
    if (setId != null) {
      $result.setId = setId;
    }
    if (childIndex != null) {
      $result.childIndex = childIndex;
    }
    return $result;
  }
  AMPRecord._() : super();
  factory AMPRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AMPRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AMPRecord', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rootShare', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'setId', $pb.PbFieldType.OY)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'childIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AMPRecord clone() => AMPRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AMPRecord copyWith(void Function(AMPRecord) updates) => super.copyWith((message) => updates(message as AMPRecord)) as AMPRecord;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AMPRecord create() => AMPRecord._();
  AMPRecord createEmptyInstance() => create();
  static $pb.PbList<AMPRecord> createRepeated() => $pb.PbList<AMPRecord>();
  @$core.pragma('dart2js:noInline')
  static AMPRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AMPRecord>(create);
  static AMPRecord? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get rootShare => $_getN(0);
  @$pb.TagNumber(1)
  set rootShare($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRootShare() => $_has(0);
  @$pb.TagNumber(1)
  void clearRootShare() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get setId => $_getN(1);
  @$pb.TagNumber(2)
  set setId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get childIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set childIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChildIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearChildIndex() => $_clearField(3);
}

///
/// A path through the channel graph which runs over one or more channels in
/// succession. This struct carries all the information required to craft the
/// Sphinx onion packet, and send the payment along the first hop in the path. A
/// route is only selected as valid if all the channels have sufficient capacity to
/// carry the initial payment amount after fees are accounted for.
class Route extends $pb.GeneratedMessage {
  factory Route({
    $core.int? totalTimeLock,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? totalFees,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? totalAmt,
    $core.Iterable<Hop>? hops,
    $fixnum.Int64? totalFeesMsat,
    $fixnum.Int64? totalAmtMsat,
    $fixnum.Int64? firstHopAmountMsat,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (totalTimeLock != null) {
      $result.totalTimeLock = totalTimeLock;
    }
    if (totalFees != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.totalFees = totalFees;
    }
    if (totalAmt != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.totalAmt = totalAmt;
    }
    if (hops != null) {
      $result.hops.addAll(hops);
    }
    if (totalFeesMsat != null) {
      $result.totalFeesMsat = totalFeesMsat;
    }
    if (totalAmtMsat != null) {
      $result.totalAmtMsat = totalAmtMsat;
    }
    if (firstHopAmountMsat != null) {
      $result.firstHopAmountMsat = firstHopAmountMsat;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  Route._() : super();
  factory Route.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Route.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Route', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'totalTimeLock', $pb.PbFieldType.OU3)
    ..aInt64(2, _omitFieldNames ? '' : 'totalFees')
    ..aInt64(3, _omitFieldNames ? '' : 'totalAmt')
    ..pc<Hop>(4, _omitFieldNames ? '' : 'hops', $pb.PbFieldType.PM, subBuilder: Hop.create)
    ..aInt64(5, _omitFieldNames ? '' : 'totalFeesMsat')
    ..aInt64(6, _omitFieldNames ? '' : 'totalAmtMsat')
    ..aInt64(7, _omitFieldNames ? '' : 'firstHopAmountMsat')
    ..a<$core.List<$core.int>>(8, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Route clone() => Route()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Route copyWith(void Function(Route) updates) => super.copyWith((message) => updates(message as Route)) as Route;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Route create() => Route._();
  Route createEmptyInstance() => create();
  static $pb.PbList<Route> createRepeated() => $pb.PbList<Route>();
  @$core.pragma('dart2js:noInline')
  static Route getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Route>(create);
  static Route? _defaultInstance;

  ///
  /// The cumulative (final) time lock across the entire route. This is the CLTV
  /// value that should be extended to the first hop in the route. All other hops
  /// will decrement the time-lock as advertised, leaving enough time for all
  /// hops to wait for or present the payment preimage to complete the payment.
  @$pb.TagNumber(1)
  $core.int get totalTimeLock => $_getIZ(0);
  @$pb.TagNumber(1)
  set totalTimeLock($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalTimeLock() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalTimeLock() => $_clearField(1);

  ///
  /// The sum of the fees paid at each hop within the final route. In the case
  /// of a one-hop payment, this value will be zero as we don't need to pay a fee
  /// to ourselves.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $fixnum.Int64 get totalFees => $_getI64(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set totalFees($fixnum.Int64 v) { $_setInt64(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasTotalFees() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearTotalFees() => $_clearField(2);

  ///
  /// The total amount of funds required to complete a payment over this route.
  /// This value includes the cumulative fees at each hop. As a result, the HTLC
  /// extended to the first-hop in the route will need to have at least this many
  /// satoshis, otherwise the route will fail at an intermediate node due to an
  /// insufficient amount of fees.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $fixnum.Int64 get totalAmt => $_getI64(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set totalAmt($fixnum.Int64 v) { $_setInt64(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasTotalAmt() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearTotalAmt() => $_clearField(3);

  ///
  /// Contains details concerning the specific forwarding details at each hop.
  @$pb.TagNumber(4)
  $pb.PbList<Hop> get hops => $_getList(3);

  ///
  /// The total fees in millisatoshis.
  @$pb.TagNumber(5)
  $fixnum.Int64 get totalFeesMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set totalFeesMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTotalFeesMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalFeesMsat() => $_clearField(5);

  ///
  /// The total amount in millisatoshis.
  @$pb.TagNumber(6)
  $fixnum.Int64 get totalAmtMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set totalAmtMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalAmtMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalAmtMsat() => $_clearField(6);

  ///
  /// The actual on-chain amount that was sent out to the first hop. This value is
  /// only different from the total_amt_msat field if this is a custom channel
  /// payment and the value transported in the HTLC is different from the BTC
  /// amount in the HTLC. If this value is zero, then this is an old payment that
  /// didn't have this value yet and can be ignored.
  @$pb.TagNumber(7)
  $fixnum.Int64 get firstHopAmountMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set firstHopAmountMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFirstHopAmountMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearFirstHopAmountMsat() => $_clearField(7);

  ///
  /// Custom channel data that might be populated in custom channels.
  @$pb.TagNumber(8)
  $core.List<$core.int> get customChannelData => $_getN(7);
  @$pb.TagNumber(8)
  set customChannelData($core.List<$core.int> v) { $_setBytes(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasCustomChannelData() => $_has(7);
  @$pb.TagNumber(8)
  void clearCustomChannelData() => $_clearField(8);
}

class NodeInfoRequest extends $pb.GeneratedMessage {
  factory NodeInfoRequest({
    $core.String? pubKey,
    $core.bool? includeChannels,
  }) {
    final $result = create();
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    if (includeChannels != null) {
      $result.includeChannels = includeChannels;
    }
    return $result;
  }
  NodeInfoRequest._() : super();
  factory NodeInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'pubKey')
    ..aOB(2, _omitFieldNames ? '' : 'includeChannels')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeInfoRequest clone() => NodeInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeInfoRequest copyWith(void Function(NodeInfoRequest) updates) => super.copyWith((message) => updates(message as NodeInfoRequest)) as NodeInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeInfoRequest create() => NodeInfoRequest._();
  NodeInfoRequest createEmptyInstance() => create();
  static $pb.PbList<NodeInfoRequest> createRepeated() => $pb.PbList<NodeInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static NodeInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeInfoRequest>(create);
  static NodeInfoRequest? _defaultInstance;

  /// The 33-byte hex-encoded compressed public of the target node
  @$pb.TagNumber(1)
  $core.String get pubKey => $_getSZ(0);
  @$pb.TagNumber(1)
  set pubKey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubKey() => $_clearField(1);

  /// If true, will include all known channels associated with the node.
  @$pb.TagNumber(2)
  $core.bool get includeChannels => $_getBF(1);
  @$pb.TagNumber(2)
  set includeChannels($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncludeChannels() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeChannels() => $_clearField(2);
}

class NodeInfo extends $pb.GeneratedMessage {
  factory NodeInfo({
    LightningNode? node,
    $core.int? numChannels,
    $fixnum.Int64? totalCapacity,
    $core.Iterable<ChannelEdge>? channels,
  }) {
    final $result = create();
    if (node != null) {
      $result.node = node;
    }
    if (numChannels != null) {
      $result.numChannels = numChannels;
    }
    if (totalCapacity != null) {
      $result.totalCapacity = totalCapacity;
    }
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  NodeInfo._() : super();
  factory NodeInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<LightningNode>(1, _omitFieldNames ? '' : 'node', subBuilder: LightningNode.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'numChannels', $pb.PbFieldType.OU3)
    ..aInt64(3, _omitFieldNames ? '' : 'totalCapacity')
    ..pc<ChannelEdge>(4, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: ChannelEdge.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeInfo clone() => NodeInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeInfo copyWith(void Function(NodeInfo) updates) => super.copyWith((message) => updates(message as NodeInfo)) as NodeInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeInfo create() => NodeInfo._();
  NodeInfo createEmptyInstance() => create();
  static $pb.PbList<NodeInfo> createRepeated() => $pb.PbList<NodeInfo>();
  @$core.pragma('dart2js:noInline')
  static NodeInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeInfo>(create);
  static NodeInfo? _defaultInstance;

  ///
  /// An individual vertex/node within the channel graph. A node is
  /// connected to other nodes by one or more channel edges emanating from it. As
  /// the graph is directed, a node will also have an incoming edge attached to
  /// it for each outgoing edge.
  @$pb.TagNumber(1)
  LightningNode get node => $_getN(0);
  @$pb.TagNumber(1)
  set node(LightningNode v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearNode() => $_clearField(1);
  @$pb.TagNumber(1)
  LightningNode ensureNode() => $_ensure(0);

  /// The total number of channels for the node.
  @$pb.TagNumber(2)
  $core.int get numChannels => $_getIZ(1);
  @$pb.TagNumber(2)
  set numChannels($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumChannels() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumChannels() => $_clearField(2);

  /// The sum of all channels capacity for the node, denominated in satoshis.
  @$pb.TagNumber(3)
  $fixnum.Int64 get totalCapacity => $_getI64(2);
  @$pb.TagNumber(3)
  set totalCapacity($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalCapacity() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalCapacity() => $_clearField(3);

  /// A list of all public channels for the node.
  @$pb.TagNumber(4)
  $pb.PbList<ChannelEdge> get channels => $_getList(3);
}

///
/// An individual vertex/node within the channel graph. A node is
/// connected to other nodes by one or more channel edges emanating from it. As the
/// graph is directed, a node will also have an incoming edge attached to it for
/// each outgoing edge.
class LightningNode extends $pb.GeneratedMessage {
  factory LightningNode({
    $core.int? lastUpdate,
    $core.String? pubKey,
    $core.String? alias,
    $core.Iterable<NodeAddress>? addresses,
    $core.String? color,
    $pb.PbMap<$core.int, Feature>? features,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? customRecords,
  }) {
    final $result = create();
    if (lastUpdate != null) {
      $result.lastUpdate = lastUpdate;
    }
    if (pubKey != null) {
      $result.pubKey = pubKey;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    if (addresses != null) {
      $result.addresses.addAll(addresses);
    }
    if (color != null) {
      $result.color = color;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    return $result;
  }
  LightningNode._() : super();
  factory LightningNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightningNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LightningNode', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'lastUpdate', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'pubKey')
    ..aOS(3, _omitFieldNames ? '' : 'alias')
    ..pc<NodeAddress>(4, _omitFieldNames ? '' : 'addresses', $pb.PbFieldType.PM, subBuilder: NodeAddress.create)
    ..aOS(5, _omitFieldNames ? '' : 'color')
    ..m<$core.int, Feature>(6, _omitFieldNames ? '' : 'features', entryClassName: 'LightningNode.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..m<$fixnum.Int64, $core.List<$core.int>>(7, _omitFieldNames ? '' : 'customRecords', entryClassName: 'LightningNode.CustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LightningNode clone() => LightningNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LightningNode copyWith(void Function(LightningNode) updates) => super.copyWith((message) => updates(message as LightningNode)) as LightningNode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LightningNode create() => LightningNode._();
  LightningNode createEmptyInstance() => create();
  static $pb.PbList<LightningNode> createRepeated() => $pb.PbList<LightningNode>();
  @$core.pragma('dart2js:noInline')
  static LightningNode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LightningNode>(create);
  static LightningNode? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get lastUpdate => $_getIZ(0);
  @$pb.TagNumber(1)
  set lastUpdate($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLastUpdate() => $_has(0);
  @$pb.TagNumber(1)
  void clearLastUpdate() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get pubKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set pubKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPubKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPubKey() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get alias => $_getSZ(2);
  @$pb.TagNumber(3)
  set alias($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAlias() => $_has(2);
  @$pb.TagNumber(3)
  void clearAlias() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbList<NodeAddress> get addresses => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get color => $_getSZ(4);
  @$pb.TagNumber(5)
  set color($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearColor() => $_clearField(5);

  @$pb.TagNumber(6)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(5);

  /// Custom node announcement tlv records.
  @$pb.TagNumber(7)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get customRecords => $_getMap(6);
}

class NodeAddress extends $pb.GeneratedMessage {
  factory NodeAddress({
    $core.String? network,
    $core.String? addr,
  }) {
    final $result = create();
    if (network != null) {
      $result.network = network;
    }
    if (addr != null) {
      $result.addr = addr;
    }
    return $result;
  }
  NodeAddress._() : super();
  factory NodeAddress.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeAddress.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeAddress', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'network')
    ..aOS(2, _omitFieldNames ? '' : 'addr')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeAddress clone() => NodeAddress()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeAddress copyWith(void Function(NodeAddress) updates) => super.copyWith((message) => updates(message as NodeAddress)) as NodeAddress;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeAddress create() => NodeAddress._();
  NodeAddress createEmptyInstance() => create();
  static $pb.PbList<NodeAddress> createRepeated() => $pb.PbList<NodeAddress>();
  @$core.pragma('dart2js:noInline')
  static NodeAddress getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeAddress>(create);
  static NodeAddress? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get network => $_getSZ(0);
  @$pb.TagNumber(1)
  set network($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNetwork() => $_has(0);
  @$pb.TagNumber(1)
  void clearNetwork() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get addr => $_getSZ(1);
  @$pb.TagNumber(2)
  set addr($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddr() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddr() => $_clearField(2);
}

class RoutingPolicy extends $pb.GeneratedMessage {
  factory RoutingPolicy({
    $core.int? timeLockDelta,
    $fixnum.Int64? minHtlc,
    $fixnum.Int64? feeBaseMsat,
    $fixnum.Int64? feeRateMilliMsat,
    $core.bool? disabled,
    $fixnum.Int64? maxHtlcMsat,
    $core.int? lastUpdate,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? customRecords,
    $core.int? inboundFeeBaseMsat,
    $core.int? inboundFeeRateMilliMsat,
  }) {
    final $result = create();
    if (timeLockDelta != null) {
      $result.timeLockDelta = timeLockDelta;
    }
    if (minHtlc != null) {
      $result.minHtlc = minHtlc;
    }
    if (feeBaseMsat != null) {
      $result.feeBaseMsat = feeBaseMsat;
    }
    if (feeRateMilliMsat != null) {
      $result.feeRateMilliMsat = feeRateMilliMsat;
    }
    if (disabled != null) {
      $result.disabled = disabled;
    }
    if (maxHtlcMsat != null) {
      $result.maxHtlcMsat = maxHtlcMsat;
    }
    if (lastUpdate != null) {
      $result.lastUpdate = lastUpdate;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    if (inboundFeeBaseMsat != null) {
      $result.inboundFeeBaseMsat = inboundFeeBaseMsat;
    }
    if (inboundFeeRateMilliMsat != null) {
      $result.inboundFeeRateMilliMsat = inboundFeeRateMilliMsat;
    }
    return $result;
  }
  RoutingPolicy._() : super();
  factory RoutingPolicy.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoutingPolicy.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoutingPolicy', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'timeLockDelta', $pb.PbFieldType.OU3)
    ..aInt64(2, _omitFieldNames ? '' : 'minHtlc')
    ..aInt64(3, _omitFieldNames ? '' : 'feeBaseMsat')
    ..aInt64(4, _omitFieldNames ? '' : 'feeRateMilliMsat')
    ..aOB(5, _omitFieldNames ? '' : 'disabled')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'maxHtlcMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'lastUpdate', $pb.PbFieldType.OU3)
    ..m<$fixnum.Int64, $core.List<$core.int>>(8, _omitFieldNames ? '' : 'customRecords', entryClassName: 'RoutingPolicy.CustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..a<$core.int>(9, _omitFieldNames ? '' : 'inboundFeeBaseMsat', $pb.PbFieldType.O3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'inboundFeeRateMilliMsat', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoutingPolicy clone() => RoutingPolicy()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoutingPolicy copyWith(void Function(RoutingPolicy) updates) => super.copyWith((message) => updates(message as RoutingPolicy)) as RoutingPolicy;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoutingPolicy create() => RoutingPolicy._();
  RoutingPolicy createEmptyInstance() => create();
  static $pb.PbList<RoutingPolicy> createRepeated() => $pb.PbList<RoutingPolicy>();
  @$core.pragma('dart2js:noInline')
  static RoutingPolicy getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoutingPolicy>(create);
  static RoutingPolicy? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get timeLockDelta => $_getIZ(0);
  @$pb.TagNumber(1)
  set timeLockDelta($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTimeLockDelta() => $_has(0);
  @$pb.TagNumber(1)
  void clearTimeLockDelta() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get minHtlc => $_getI64(1);
  @$pb.TagNumber(2)
  set minHtlc($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMinHtlc() => $_has(1);
  @$pb.TagNumber(2)
  void clearMinHtlc() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get feeBaseMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set feeBaseMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeeBaseMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeBaseMsat() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get feeRateMilliMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set feeRateMilliMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeRateMilliMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeRateMilliMsat() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.bool get disabled => $_getBF(4);
  @$pb.TagNumber(5)
  set disabled($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDisabled() => $_has(4);
  @$pb.TagNumber(5)
  void clearDisabled() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get maxHtlcMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set maxHtlcMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxHtlcMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxHtlcMsat() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get lastUpdate => $_getIZ(6);
  @$pb.TagNumber(7)
  set lastUpdate($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasLastUpdate() => $_has(6);
  @$pb.TagNumber(7)
  void clearLastUpdate() => $_clearField(7);

  /// Custom channel update tlv records.
  @$pb.TagNumber(8)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get customRecords => $_getMap(7);

  @$pb.TagNumber(9)
  $core.int get inboundFeeBaseMsat => $_getIZ(8);
  @$pb.TagNumber(9)
  set inboundFeeBaseMsat($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasInboundFeeBaseMsat() => $_has(8);
  @$pb.TagNumber(9)
  void clearInboundFeeBaseMsat() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.int get inboundFeeRateMilliMsat => $_getIZ(9);
  @$pb.TagNumber(10)
  set inboundFeeRateMilliMsat($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasInboundFeeRateMilliMsat() => $_has(9);
  @$pb.TagNumber(10)
  void clearInboundFeeRateMilliMsat() => $_clearField(10);
}

///
/// A fully authenticated channel along with all its unique attributes.
/// Once an authenticated channel announcement has been processed on the network,
/// then an instance of ChannelEdgeInfo encapsulating the channels attributes is
/// stored. The other portions relevant to routing policy of a channel are stored
/// within a ChannelEdgePolicy for each direction of the channel.
class ChannelEdge extends $pb.GeneratedMessage {
  factory ChannelEdge({
    $fixnum.Int64? channelId,
    $core.String? chanPoint,
  @$core.Deprecated('This field is deprecated.')
    $core.int? lastUpdate,
    $core.String? node1Pub,
    $core.String? node2Pub,
    $fixnum.Int64? capacity,
    RoutingPolicy? node1Policy,
    RoutingPolicy? node2Policy,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? customRecords,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    if (lastUpdate != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.lastUpdate = lastUpdate;
    }
    if (node1Pub != null) {
      $result.node1Pub = node1Pub;
    }
    if (node2Pub != null) {
      $result.node2Pub = node2Pub;
    }
    if (capacity != null) {
      $result.capacity = capacity;
    }
    if (node1Policy != null) {
      $result.node1Policy = node1Policy;
    }
    if (node2Policy != null) {
      $result.node2Policy = node2Policy;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    return $result;
  }
  ChannelEdge._() : super();
  factory ChannelEdge.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelEdge.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelEdge', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'channelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'chanPoint')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'lastUpdate', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'node1Pub')
    ..aOS(5, _omitFieldNames ? '' : 'node2Pub')
    ..aInt64(6, _omitFieldNames ? '' : 'capacity')
    ..aOM<RoutingPolicy>(7, _omitFieldNames ? '' : 'node1Policy', subBuilder: RoutingPolicy.create)
    ..aOM<RoutingPolicy>(8, _omitFieldNames ? '' : 'node2Policy', subBuilder: RoutingPolicy.create)
    ..m<$fixnum.Int64, $core.List<$core.int>>(9, _omitFieldNames ? '' : 'customRecords', entryClassName: 'ChannelEdge.CustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelEdge clone() => ChannelEdge()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelEdge copyWith(void Function(ChannelEdge) updates) => super.copyWith((message) => updates(message as ChannelEdge)) as ChannelEdge;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelEdge create() => ChannelEdge._();
  ChannelEdge createEmptyInstance() => create();
  static $pb.PbList<ChannelEdge> createRepeated() => $pb.PbList<ChannelEdge>();
  @$core.pragma('dart2js:noInline')
  static ChannelEdge getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelEdge>(create);
  static ChannelEdge? _defaultInstance;

  ///
  /// The unique channel ID for the channel. The first 3 bytes are the block
  /// height, the next 3 the index within the block, and the last 2 bytes are the
  /// output index for the channel.
  @$pb.TagNumber(1)
  $fixnum.Int64 get channelId => $_getI64(0);
  @$pb.TagNumber(1)
  set channelId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get chanPoint => $_getSZ(1);
  @$pb.TagNumber(2)
  set chanPoint($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanPoint() => $_clearField(2);

  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.int get lastUpdate => $_getIZ(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set lastUpdate($core.int v) { $_setUnsignedInt32(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasLastUpdate() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearLastUpdate() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get node1Pub => $_getSZ(3);
  @$pb.TagNumber(4)
  set node1Pub($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNode1Pub() => $_has(3);
  @$pb.TagNumber(4)
  void clearNode1Pub() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get node2Pub => $_getSZ(4);
  @$pb.TagNumber(5)
  set node2Pub($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNode2Pub() => $_has(4);
  @$pb.TagNumber(5)
  void clearNode2Pub() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get capacity => $_getI64(5);
  @$pb.TagNumber(6)
  set capacity($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCapacity() => $_has(5);
  @$pb.TagNumber(6)
  void clearCapacity() => $_clearField(6);

  @$pb.TagNumber(7)
  RoutingPolicy get node1Policy => $_getN(6);
  @$pb.TagNumber(7)
  set node1Policy(RoutingPolicy v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasNode1Policy() => $_has(6);
  @$pb.TagNumber(7)
  void clearNode1Policy() => $_clearField(7);
  @$pb.TagNumber(7)
  RoutingPolicy ensureNode1Policy() => $_ensure(6);

  @$pb.TagNumber(8)
  RoutingPolicy get node2Policy => $_getN(7);
  @$pb.TagNumber(8)
  set node2Policy(RoutingPolicy v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasNode2Policy() => $_has(7);
  @$pb.TagNumber(8)
  void clearNode2Policy() => $_clearField(8);
  @$pb.TagNumber(8)
  RoutingPolicy ensureNode2Policy() => $_ensure(7);

  /// Custom channel announcement tlv records.
  @$pb.TagNumber(9)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get customRecords => $_getMap(8);
}

class ChannelGraphRequest extends $pb.GeneratedMessage {
  factory ChannelGraphRequest({
    $core.bool? includeUnannounced,
  }) {
    final $result = create();
    if (includeUnannounced != null) {
      $result.includeUnannounced = includeUnannounced;
    }
    return $result;
  }
  ChannelGraphRequest._() : super();
  factory ChannelGraphRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelGraphRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelGraphRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'includeUnannounced')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelGraphRequest clone() => ChannelGraphRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelGraphRequest copyWith(void Function(ChannelGraphRequest) updates) => super.copyWith((message) => updates(message as ChannelGraphRequest)) as ChannelGraphRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelGraphRequest create() => ChannelGraphRequest._();
  ChannelGraphRequest createEmptyInstance() => create();
  static $pb.PbList<ChannelGraphRequest> createRepeated() => $pb.PbList<ChannelGraphRequest>();
  @$core.pragma('dart2js:noInline')
  static ChannelGraphRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelGraphRequest>(create);
  static ChannelGraphRequest? _defaultInstance;

  ///
  /// Whether unannounced channels are included in the response or not. If set,
  /// unannounced channels are included. Unannounced channels are both private
  /// channels, and public channels that are not yet announced to the network.
  @$pb.TagNumber(1)
  $core.bool get includeUnannounced => $_getBF(0);
  @$pb.TagNumber(1)
  set includeUnannounced($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncludeUnannounced() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludeUnannounced() => $_clearField(1);
}

/// Returns a new instance of the directed channel graph.
class ChannelGraph extends $pb.GeneratedMessage {
  factory ChannelGraph({
    $core.Iterable<LightningNode>? nodes,
    $core.Iterable<ChannelEdge>? edges,
  }) {
    final $result = create();
    if (nodes != null) {
      $result.nodes.addAll(nodes);
    }
    if (edges != null) {
      $result.edges.addAll(edges);
    }
    return $result;
  }
  ChannelGraph._() : super();
  factory ChannelGraph.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelGraph.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelGraph', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<LightningNode>(1, _omitFieldNames ? '' : 'nodes', $pb.PbFieldType.PM, subBuilder: LightningNode.create)
    ..pc<ChannelEdge>(2, _omitFieldNames ? '' : 'edges', $pb.PbFieldType.PM, subBuilder: ChannelEdge.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelGraph clone() => ChannelGraph()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelGraph copyWith(void Function(ChannelGraph) updates) => super.copyWith((message) => updates(message as ChannelGraph)) as ChannelGraph;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelGraph create() => ChannelGraph._();
  ChannelGraph createEmptyInstance() => create();
  static $pb.PbList<ChannelGraph> createRepeated() => $pb.PbList<ChannelGraph>();
  @$core.pragma('dart2js:noInline')
  static ChannelGraph getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelGraph>(create);
  static ChannelGraph? _defaultInstance;

  /// The list of `LightningNode`s in this channel graph
  @$pb.TagNumber(1)
  $pb.PbList<LightningNode> get nodes => $_getList(0);

  /// The list of `ChannelEdge`s in this channel graph
  @$pb.TagNumber(2)
  $pb.PbList<ChannelEdge> get edges => $_getList(1);
}

class NodeMetricsRequest extends $pb.GeneratedMessage {
  factory NodeMetricsRequest({
    $core.Iterable<NodeMetricType>? types,
  }) {
    final $result = create();
    if (types != null) {
      $result.types.addAll(types);
    }
    return $result;
  }
  NodeMetricsRequest._() : super();
  factory NodeMetricsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeMetricsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeMetricsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<NodeMetricType>(1, _omitFieldNames ? '' : 'types', $pb.PbFieldType.KE, valueOf: NodeMetricType.valueOf, enumValues: NodeMetricType.values, defaultEnumValue: NodeMetricType.UNKNOWN)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeMetricsRequest clone() => NodeMetricsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeMetricsRequest copyWith(void Function(NodeMetricsRequest) updates) => super.copyWith((message) => updates(message as NodeMetricsRequest)) as NodeMetricsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeMetricsRequest create() => NodeMetricsRequest._();
  NodeMetricsRequest createEmptyInstance() => create();
  static $pb.PbList<NodeMetricsRequest> createRepeated() => $pb.PbList<NodeMetricsRequest>();
  @$core.pragma('dart2js:noInline')
  static NodeMetricsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeMetricsRequest>(create);
  static NodeMetricsRequest? _defaultInstance;

  /// The requested node metrics.
  @$pb.TagNumber(1)
  $pb.PbList<NodeMetricType> get types => $_getList(0);
}

class NodeMetricsResponse extends $pb.GeneratedMessage {
  factory NodeMetricsResponse({
    $pb.PbMap<$core.String, FloatMetric>? betweennessCentrality,
  }) {
    final $result = create();
    if (betweennessCentrality != null) {
      $result.betweennessCentrality.addAll(betweennessCentrality);
    }
    return $result;
  }
  NodeMetricsResponse._() : super();
  factory NodeMetricsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeMetricsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeMetricsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..m<$core.String, FloatMetric>(1, _omitFieldNames ? '' : 'betweennessCentrality', entryClassName: 'NodeMetricsResponse.BetweennessCentralityEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: FloatMetric.create, valueDefaultOrMaker: FloatMetric.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeMetricsResponse clone() => NodeMetricsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeMetricsResponse copyWith(void Function(NodeMetricsResponse) updates) => super.copyWith((message) => updates(message as NodeMetricsResponse)) as NodeMetricsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeMetricsResponse create() => NodeMetricsResponse._();
  NodeMetricsResponse createEmptyInstance() => create();
  static $pb.PbList<NodeMetricsResponse> createRepeated() => $pb.PbList<NodeMetricsResponse>();
  @$core.pragma('dart2js:noInline')
  static NodeMetricsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeMetricsResponse>(create);
  static NodeMetricsResponse? _defaultInstance;

  ///
  /// Betweenness centrality is the sum of the ratio of shortest paths that pass
  /// through the node for each pair of nodes in the graph (not counting paths
  /// starting or ending at this node).
  /// Map of node pubkey to betweenness centrality of the node. Normalized
  /// values are in the [0,1] closed interval.
  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, FloatMetric> get betweennessCentrality => $_getMap(0);
}

class FloatMetric extends $pb.GeneratedMessage {
  factory FloatMetric({
    $core.double? value,
    $core.double? normalizedValue,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (normalizedValue != null) {
      $result.normalizedValue = normalizedValue;
    }
    return $result;
  }
  FloatMetric._() : super();
  factory FloatMetric.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FloatMetric.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FloatMetric', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OD)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'normalizedValue', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FloatMetric clone() => FloatMetric()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FloatMetric copyWith(void Function(FloatMetric) updates) => super.copyWith((message) => updates(message as FloatMetric)) as FloatMetric;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FloatMetric create() => FloatMetric._();
  FloatMetric createEmptyInstance() => create();
  static $pb.PbList<FloatMetric> createRepeated() => $pb.PbList<FloatMetric>();
  @$core.pragma('dart2js:noInline')
  static FloatMetric getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FloatMetric>(create);
  static FloatMetric? _defaultInstance;

  /// Arbitrary float value.
  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);

  /// The value normalized to [0,1] or [-1,1].
  @$pb.TagNumber(2)
  $core.double get normalizedValue => $_getN(1);
  @$pb.TagNumber(2)
  set normalizedValue($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNormalizedValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearNormalizedValue() => $_clearField(2);
}

class ChanInfoRequest extends $pb.GeneratedMessage {
  factory ChanInfoRequest({
    $fixnum.Int64? chanId,
    $core.String? chanPoint,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    return $result;
  }
  ChanInfoRequest._() : super();
  factory ChanInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChanInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChanInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'chanPoint')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChanInfoRequest clone() => ChanInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChanInfoRequest copyWith(void Function(ChanInfoRequest) updates) => super.copyWith((message) => updates(message as ChanInfoRequest)) as ChanInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChanInfoRequest create() => ChanInfoRequest._();
  ChanInfoRequest createEmptyInstance() => create();
  static $pb.PbList<ChanInfoRequest> createRepeated() => $pb.PbList<ChanInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static ChanInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChanInfoRequest>(create);
  static ChanInfoRequest? _defaultInstance;

  ///
  /// The unique channel ID for the channel. The first 3 bytes are the block
  /// height, the next 3 the index within the block, and the last 2 bytes are the
  /// output index for the channel.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  /// The channel point of the channel in format funding_txid:output_index. If
  /// chan_id is specified, this field is ignored.
  @$pb.TagNumber(2)
  $core.String get chanPoint => $_getSZ(1);
  @$pb.TagNumber(2)
  set chanPoint($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanPoint() => $_clearField(2);
}

class NetworkInfoRequest extends $pb.GeneratedMessage {
  factory NetworkInfoRequest() => create();
  NetworkInfoRequest._() : super();
  factory NetworkInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NetworkInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NetworkInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NetworkInfoRequest clone() => NetworkInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NetworkInfoRequest copyWith(void Function(NetworkInfoRequest) updates) => super.copyWith((message) => updates(message as NetworkInfoRequest)) as NetworkInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NetworkInfoRequest create() => NetworkInfoRequest._();
  NetworkInfoRequest createEmptyInstance() => create();
  static $pb.PbList<NetworkInfoRequest> createRepeated() => $pb.PbList<NetworkInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static NetworkInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NetworkInfoRequest>(create);
  static NetworkInfoRequest? _defaultInstance;
}

class NetworkInfo extends $pb.GeneratedMessage {
  factory NetworkInfo({
    $core.int? graphDiameter,
    $core.double? avgOutDegree,
    $core.int? maxOutDegree,
    $core.int? numNodes,
    $core.int? numChannels,
    $fixnum.Int64? totalNetworkCapacity,
    $core.double? avgChannelSize,
    $fixnum.Int64? minChannelSize,
    $fixnum.Int64? maxChannelSize,
    $fixnum.Int64? medianChannelSizeSat,
    $fixnum.Int64? numZombieChans,
  }) {
    final $result = create();
    if (graphDiameter != null) {
      $result.graphDiameter = graphDiameter;
    }
    if (avgOutDegree != null) {
      $result.avgOutDegree = avgOutDegree;
    }
    if (maxOutDegree != null) {
      $result.maxOutDegree = maxOutDegree;
    }
    if (numNodes != null) {
      $result.numNodes = numNodes;
    }
    if (numChannels != null) {
      $result.numChannels = numChannels;
    }
    if (totalNetworkCapacity != null) {
      $result.totalNetworkCapacity = totalNetworkCapacity;
    }
    if (avgChannelSize != null) {
      $result.avgChannelSize = avgChannelSize;
    }
    if (minChannelSize != null) {
      $result.minChannelSize = minChannelSize;
    }
    if (maxChannelSize != null) {
      $result.maxChannelSize = maxChannelSize;
    }
    if (medianChannelSizeSat != null) {
      $result.medianChannelSizeSat = medianChannelSizeSat;
    }
    if (numZombieChans != null) {
      $result.numZombieChans = numZombieChans;
    }
    return $result;
  }
  NetworkInfo._() : super();
  factory NetworkInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NetworkInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NetworkInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'graphDiameter', $pb.PbFieldType.OU3)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'avgOutDegree', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'maxOutDegree', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'numNodes', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'numChannels', $pb.PbFieldType.OU3)
    ..aInt64(6, _omitFieldNames ? '' : 'totalNetworkCapacity')
    ..a<$core.double>(7, _omitFieldNames ? '' : 'avgChannelSize', $pb.PbFieldType.OD)
    ..aInt64(8, _omitFieldNames ? '' : 'minChannelSize')
    ..aInt64(9, _omitFieldNames ? '' : 'maxChannelSize')
    ..aInt64(10, _omitFieldNames ? '' : 'medianChannelSizeSat')
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'numZombieChans', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NetworkInfo clone() => NetworkInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NetworkInfo copyWith(void Function(NetworkInfo) updates) => super.copyWith((message) => updates(message as NetworkInfo)) as NetworkInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NetworkInfo create() => NetworkInfo._();
  NetworkInfo createEmptyInstance() => create();
  static $pb.PbList<NetworkInfo> createRepeated() => $pb.PbList<NetworkInfo>();
  @$core.pragma('dart2js:noInline')
  static NetworkInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NetworkInfo>(create);
  static NetworkInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get graphDiameter => $_getIZ(0);
  @$pb.TagNumber(1)
  set graphDiameter($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGraphDiameter() => $_has(0);
  @$pb.TagNumber(1)
  void clearGraphDiameter() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get avgOutDegree => $_getN(1);
  @$pb.TagNumber(2)
  set avgOutDegree($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAvgOutDegree() => $_has(1);
  @$pb.TagNumber(2)
  void clearAvgOutDegree() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get maxOutDegree => $_getIZ(2);
  @$pb.TagNumber(3)
  set maxOutDegree($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxOutDegree() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxOutDegree() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get numNodes => $_getIZ(3);
  @$pb.TagNumber(4)
  set numNodes($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumNodes() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumNodes() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get numChannels => $_getIZ(4);
  @$pb.TagNumber(5)
  set numChannels($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumChannels() => $_has(4);
  @$pb.TagNumber(5)
  void clearNumChannels() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get totalNetworkCapacity => $_getI64(5);
  @$pb.TagNumber(6)
  set totalNetworkCapacity($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTotalNetworkCapacity() => $_has(5);
  @$pb.TagNumber(6)
  void clearTotalNetworkCapacity() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get avgChannelSize => $_getN(6);
  @$pb.TagNumber(7)
  set avgChannelSize($core.double v) { $_setDouble(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAvgChannelSize() => $_has(6);
  @$pb.TagNumber(7)
  void clearAvgChannelSize() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get minChannelSize => $_getI64(7);
  @$pb.TagNumber(8)
  set minChannelSize($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinChannelSize() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinChannelSize() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get maxChannelSize => $_getI64(8);
  @$pb.TagNumber(9)
  set maxChannelSize($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasMaxChannelSize() => $_has(8);
  @$pb.TagNumber(9)
  void clearMaxChannelSize() => $_clearField(9);

  @$pb.TagNumber(10)
  $fixnum.Int64 get medianChannelSizeSat => $_getI64(9);
  @$pb.TagNumber(10)
  set medianChannelSizeSat($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMedianChannelSizeSat() => $_has(9);
  @$pb.TagNumber(10)
  void clearMedianChannelSizeSat() => $_clearField(10);

  /// The number of edges marked as zombies.
  @$pb.TagNumber(11)
  $fixnum.Int64 get numZombieChans => $_getI64(10);
  @$pb.TagNumber(11)
  set numZombieChans($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasNumZombieChans() => $_has(10);
  @$pb.TagNumber(11)
  void clearNumZombieChans() => $_clearField(11);
}

class StopRequest extends $pb.GeneratedMessage {
  factory StopRequest() => create();
  StopRequest._() : super();
  factory StopRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StopRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StopRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StopRequest clone() => StopRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StopRequest copyWith(void Function(StopRequest) updates) => super.copyWith((message) => updates(message as StopRequest)) as StopRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopRequest create() => StopRequest._();
  StopRequest createEmptyInstance() => create();
  static $pb.PbList<StopRequest> createRepeated() => $pb.PbList<StopRequest>();
  @$core.pragma('dart2js:noInline')
  static StopRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StopRequest>(create);
  static StopRequest? _defaultInstance;
}

class StopResponse extends $pb.GeneratedMessage {
  factory StopResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  StopResponse._() : super();
  factory StopResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StopResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StopResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StopResponse clone() => StopResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StopResponse copyWith(void Function(StopResponse) updates) => super.copyWith((message) => updates(message as StopResponse)) as StopResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopResponse create() => StopResponse._();
  StopResponse createEmptyInstance() => create();
  static $pb.PbList<StopResponse> createRepeated() => $pb.PbList<StopResponse>();
  @$core.pragma('dart2js:noInline')
  static StopResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StopResponse>(create);
  static StopResponse? _defaultInstance;

  /// The status of the stop operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class GraphTopologySubscription extends $pb.GeneratedMessage {
  factory GraphTopologySubscription() => create();
  GraphTopologySubscription._() : super();
  factory GraphTopologySubscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphTopologySubscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphTopologySubscription', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphTopologySubscription clone() => GraphTopologySubscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphTopologySubscription copyWith(void Function(GraphTopologySubscription) updates) => super.copyWith((message) => updates(message as GraphTopologySubscription)) as GraphTopologySubscription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphTopologySubscription create() => GraphTopologySubscription._();
  GraphTopologySubscription createEmptyInstance() => create();
  static $pb.PbList<GraphTopologySubscription> createRepeated() => $pb.PbList<GraphTopologySubscription>();
  @$core.pragma('dart2js:noInline')
  static GraphTopologySubscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphTopologySubscription>(create);
  static GraphTopologySubscription? _defaultInstance;
}

class GraphTopologyUpdate extends $pb.GeneratedMessage {
  factory GraphTopologyUpdate({
    $core.Iterable<NodeUpdate>? nodeUpdates,
    $core.Iterable<ChannelEdgeUpdate>? channelUpdates,
    $core.Iterable<ClosedChannelUpdate>? closedChans,
  }) {
    final $result = create();
    if (nodeUpdates != null) {
      $result.nodeUpdates.addAll(nodeUpdates);
    }
    if (channelUpdates != null) {
      $result.channelUpdates.addAll(channelUpdates);
    }
    if (closedChans != null) {
      $result.closedChans.addAll(closedChans);
    }
    return $result;
  }
  GraphTopologyUpdate._() : super();
  factory GraphTopologyUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphTopologyUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphTopologyUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<NodeUpdate>(1, _omitFieldNames ? '' : 'nodeUpdates', $pb.PbFieldType.PM, subBuilder: NodeUpdate.create)
    ..pc<ChannelEdgeUpdate>(2, _omitFieldNames ? '' : 'channelUpdates', $pb.PbFieldType.PM, subBuilder: ChannelEdgeUpdate.create)
    ..pc<ClosedChannelUpdate>(3, _omitFieldNames ? '' : 'closedChans', $pb.PbFieldType.PM, subBuilder: ClosedChannelUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphTopologyUpdate clone() => GraphTopologyUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphTopologyUpdate copyWith(void Function(GraphTopologyUpdate) updates) => super.copyWith((message) => updates(message as GraphTopologyUpdate)) as GraphTopologyUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphTopologyUpdate create() => GraphTopologyUpdate._();
  GraphTopologyUpdate createEmptyInstance() => create();
  static $pb.PbList<GraphTopologyUpdate> createRepeated() => $pb.PbList<GraphTopologyUpdate>();
  @$core.pragma('dart2js:noInline')
  static GraphTopologyUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphTopologyUpdate>(create);
  static GraphTopologyUpdate? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<NodeUpdate> get nodeUpdates => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<ChannelEdgeUpdate> get channelUpdates => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<ClosedChannelUpdate> get closedChans => $_getList(2);
}

class NodeUpdate extends $pb.GeneratedMessage {
  factory NodeUpdate({
  @$core.Deprecated('This field is deprecated.')
    $core.Iterable<$core.String>? addresses,
    $core.String? identityKey,
  @$core.Deprecated('This field is deprecated.')
    $core.List<$core.int>? globalFeatures,
    $core.String? alias,
    $core.String? color,
    $pb.PbMap<$core.int, Feature>? features,
    $core.Iterable<NodeAddress>? nodeAddresses,
  }) {
    final $result = create();
    if (addresses != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.addresses.addAll(addresses);
    }
    if (identityKey != null) {
      $result.identityKey = identityKey;
    }
    if (globalFeatures != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.globalFeatures = globalFeatures;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    if (color != null) {
      $result.color = color;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (nodeAddresses != null) {
      $result.nodeAddresses.addAll(nodeAddresses);
    }
    return $result;
  }
  NodeUpdate._() : super();
  factory NodeUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NodeUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'NodeUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'addresses')
    ..aOS(2, _omitFieldNames ? '' : 'identityKey')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'globalFeatures', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'alias')
    ..aOS(5, _omitFieldNames ? '' : 'color')
    ..m<$core.int, Feature>(6, _omitFieldNames ? '' : 'features', entryClassName: 'NodeUpdate.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..pc<NodeAddress>(7, _omitFieldNames ? '' : 'nodeAddresses', $pb.PbFieldType.PM, subBuilder: NodeAddress.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NodeUpdate clone() => NodeUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NodeUpdate copyWith(void Function(NodeUpdate) updates) => super.copyWith((message) => updates(message as NodeUpdate)) as NodeUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NodeUpdate create() => NodeUpdate._();
  NodeUpdate createEmptyInstance() => create();
  static $pb.PbList<NodeUpdate> createRepeated() => $pb.PbList<NodeUpdate>();
  @$core.pragma('dart2js:noInline')
  static NodeUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NodeUpdate>(create);
  static NodeUpdate? _defaultInstance;

  ///
  /// Deprecated, use node_addresses.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get addresses => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get identityKey => $_getSZ(1);
  @$pb.TagNumber(2)
  set identityKey($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIdentityKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearIdentityKey() => $_clearField(2);

  ///
  /// Deprecated, use features.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.List<$core.int> get globalFeatures => $_getN(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set globalFeatures($core.List<$core.int> v) { $_setBytes(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasGlobalFeatures() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearGlobalFeatures() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get alias => $_getSZ(3);
  @$pb.TagNumber(4)
  set alias($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAlias() => $_has(3);
  @$pb.TagNumber(4)
  void clearAlias() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get color => $_getSZ(4);
  @$pb.TagNumber(5)
  set color($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasColor() => $_has(4);
  @$pb.TagNumber(5)
  void clearColor() => $_clearField(5);

  ///
  /// Features that the node has advertised in the init message, node
  /// announcements and invoices.
  @$pb.TagNumber(6)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(5);

  @$pb.TagNumber(7)
  $pb.PbList<NodeAddress> get nodeAddresses => $_getList(6);
}

class ChannelEdgeUpdate extends $pb.GeneratedMessage {
  factory ChannelEdgeUpdate({
    $fixnum.Int64? chanId,
    ChannelPoint? chanPoint,
    $fixnum.Int64? capacity,
    RoutingPolicy? routingPolicy,
    $core.String? advertisingNode,
    $core.String? connectingNode,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    if (capacity != null) {
      $result.capacity = capacity;
    }
    if (routingPolicy != null) {
      $result.routingPolicy = routingPolicy;
    }
    if (advertisingNode != null) {
      $result.advertisingNode = advertisingNode;
    }
    if (connectingNode != null) {
      $result.connectingNode = connectingNode;
    }
    return $result;
  }
  ChannelEdgeUpdate._() : super();
  factory ChannelEdgeUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelEdgeUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelEdgeUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<ChannelPoint>(2, _omitFieldNames ? '' : 'chanPoint', subBuilder: ChannelPoint.create)
    ..aInt64(3, _omitFieldNames ? '' : 'capacity')
    ..aOM<RoutingPolicy>(4, _omitFieldNames ? '' : 'routingPolicy', subBuilder: RoutingPolicy.create)
    ..aOS(5, _omitFieldNames ? '' : 'advertisingNode')
    ..aOS(6, _omitFieldNames ? '' : 'connectingNode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelEdgeUpdate clone() => ChannelEdgeUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelEdgeUpdate copyWith(void Function(ChannelEdgeUpdate) updates) => super.copyWith((message) => updates(message as ChannelEdgeUpdate)) as ChannelEdgeUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelEdgeUpdate create() => ChannelEdgeUpdate._();
  ChannelEdgeUpdate createEmptyInstance() => create();
  static $pb.PbList<ChannelEdgeUpdate> createRepeated() => $pb.PbList<ChannelEdgeUpdate>();
  @$core.pragma('dart2js:noInline')
  static ChannelEdgeUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelEdgeUpdate>(create);
  static ChannelEdgeUpdate? _defaultInstance;

  ///
  /// The unique channel ID for the channel. The first 3 bytes are the block
  /// height, the next 3 the index within the block, and the last 2 bytes are the
  /// output index for the channel.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  @$pb.TagNumber(2)
  ChannelPoint get chanPoint => $_getN(1);
  @$pb.TagNumber(2)
  set chanPoint(ChannelPoint v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanPoint() => $_clearField(2);
  @$pb.TagNumber(2)
  ChannelPoint ensureChanPoint() => $_ensure(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get capacity => $_getI64(2);
  @$pb.TagNumber(3)
  set capacity($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCapacity() => $_has(2);
  @$pb.TagNumber(3)
  void clearCapacity() => $_clearField(3);

  @$pb.TagNumber(4)
  RoutingPolicy get routingPolicy => $_getN(3);
  @$pb.TagNumber(4)
  set routingPolicy(RoutingPolicy v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasRoutingPolicy() => $_has(3);
  @$pb.TagNumber(4)
  void clearRoutingPolicy() => $_clearField(4);
  @$pb.TagNumber(4)
  RoutingPolicy ensureRoutingPolicy() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get advertisingNode => $_getSZ(4);
  @$pb.TagNumber(5)
  set advertisingNode($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAdvertisingNode() => $_has(4);
  @$pb.TagNumber(5)
  void clearAdvertisingNode() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get connectingNode => $_getSZ(5);
  @$pb.TagNumber(6)
  set connectingNode($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasConnectingNode() => $_has(5);
  @$pb.TagNumber(6)
  void clearConnectingNode() => $_clearField(6);
}

class ClosedChannelUpdate extends $pb.GeneratedMessage {
  factory ClosedChannelUpdate({
    $fixnum.Int64? chanId,
    $fixnum.Int64? capacity,
    $core.int? closedHeight,
    ChannelPoint? chanPoint,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (capacity != null) {
      $result.capacity = capacity;
    }
    if (closedHeight != null) {
      $result.closedHeight = closedHeight;
    }
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    return $result;
  }
  ClosedChannelUpdate._() : super();
  factory ClosedChannelUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClosedChannelUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClosedChannelUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(2, _omitFieldNames ? '' : 'capacity')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'closedHeight', $pb.PbFieldType.OU3)
    ..aOM<ChannelPoint>(4, _omitFieldNames ? '' : 'chanPoint', subBuilder: ChannelPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClosedChannelUpdate clone() => ClosedChannelUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClosedChannelUpdate copyWith(void Function(ClosedChannelUpdate) updates) => super.copyWith((message) => updates(message as ClosedChannelUpdate)) as ClosedChannelUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClosedChannelUpdate create() => ClosedChannelUpdate._();
  ClosedChannelUpdate createEmptyInstance() => create();
  static $pb.PbList<ClosedChannelUpdate> createRepeated() => $pb.PbList<ClosedChannelUpdate>();
  @$core.pragma('dart2js:noInline')
  static ClosedChannelUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClosedChannelUpdate>(create);
  static ClosedChannelUpdate? _defaultInstance;

  ///
  /// The unique channel ID for the channel. The first 3 bytes are the block
  /// height, the next 3 the index within the block, and the last 2 bytes are the
  /// output index for the channel.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get capacity => $_getI64(1);
  @$pb.TagNumber(2)
  set capacity($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCapacity() => $_has(1);
  @$pb.TagNumber(2)
  void clearCapacity() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get closedHeight => $_getIZ(2);
  @$pb.TagNumber(3)
  set closedHeight($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasClosedHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearClosedHeight() => $_clearField(3);

  @$pb.TagNumber(4)
  ChannelPoint get chanPoint => $_getN(3);
  @$pb.TagNumber(4)
  set chanPoint(ChannelPoint v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasChanPoint() => $_has(3);
  @$pb.TagNumber(4)
  void clearChanPoint() => $_clearField(4);
  @$pb.TagNumber(4)
  ChannelPoint ensureChanPoint() => $_ensure(3);
}

class HopHint extends $pb.GeneratedMessage {
  factory HopHint({
    $core.String? nodeId,
    $fixnum.Int64? chanId,
    $core.int? feeBaseMsat,
    $core.int? feeProportionalMillionths,
    $core.int? cltvExpiryDelta,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (feeBaseMsat != null) {
      $result.feeBaseMsat = feeBaseMsat;
    }
    if (feeProportionalMillionths != null) {
      $result.feeProportionalMillionths = feeProportionalMillionths;
    }
    if (cltvExpiryDelta != null) {
      $result.cltvExpiryDelta = cltvExpiryDelta;
    }
    return $result;
  }
  HopHint._() : super();
  factory HopHint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HopHint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HopHint', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'feeBaseMsat', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'feeProportionalMillionths', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'cltvExpiryDelta', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HopHint clone() => HopHint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HopHint copyWith(void Function(HopHint) updates) => super.copyWith((message) => updates(message as HopHint)) as HopHint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HopHint create() => HopHint._();
  HopHint createEmptyInstance() => create();
  static $pb.PbList<HopHint> createRepeated() => $pb.PbList<HopHint>();
  @$core.pragma('dart2js:noInline')
  static HopHint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HopHint>(create);
  static HopHint? _defaultInstance;

  /// The public key of the node at the start of the channel.
  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);

  /// The unique identifier of the channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get chanId => $_getI64(1);
  @$pb.TagNumber(2)
  set chanId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanId() => $_clearField(2);

  /// The base fee of the channel denominated in millisatoshis.
  @$pb.TagNumber(3)
  $core.int get feeBaseMsat => $_getIZ(2);
  @$pb.TagNumber(3)
  set feeBaseMsat($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeeBaseMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeBaseMsat() => $_clearField(3);

  ///
  /// The fee rate of the channel for sending one satoshi across it denominated in
  /// millionths of a satoshi.
  @$pb.TagNumber(4)
  $core.int get feeProportionalMillionths => $_getIZ(3);
  @$pb.TagNumber(4)
  set feeProportionalMillionths($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeProportionalMillionths() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeProportionalMillionths() => $_clearField(4);

  /// The time-lock delta of the channel.
  @$pb.TagNumber(5)
  $core.int get cltvExpiryDelta => $_getIZ(4);
  @$pb.TagNumber(5)
  set cltvExpiryDelta($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCltvExpiryDelta() => $_has(4);
  @$pb.TagNumber(5)
  void clearCltvExpiryDelta() => $_clearField(5);
}

class SetID extends $pb.GeneratedMessage {
  factory SetID({
    $core.List<$core.int>? setId,
  }) {
    final $result = create();
    if (setId != null) {
      $result.setId = setId;
    }
    return $result;
  }
  SetID._() : super();
  factory SetID.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetID.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetID', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'setId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetID clone() => SetID()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetID copyWith(void Function(SetID) updates) => super.copyWith((message) => updates(message as SetID)) as SetID;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetID create() => SetID._();
  SetID createEmptyInstance() => create();
  static $pb.PbList<SetID> createRepeated() => $pb.PbList<SetID>();
  @$core.pragma('dart2js:noInline')
  static SetID getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetID>(create);
  static SetID? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get setId => $_getN(0);
  @$pb.TagNumber(1)
  set setId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSetId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSetId() => $_clearField(1);
}

class RouteHint extends $pb.GeneratedMessage {
  factory RouteHint({
    $core.Iterable<HopHint>? hopHints,
  }) {
    final $result = create();
    if (hopHints != null) {
      $result.hopHints.addAll(hopHints);
    }
    return $result;
  }
  RouteHint._() : super();
  factory RouteHint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteHint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RouteHint', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<HopHint>(1, _omitFieldNames ? '' : 'hopHints', $pb.PbFieldType.PM, subBuilder: HopHint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteHint clone() => RouteHint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteHint copyWith(void Function(RouteHint) updates) => super.copyWith((message) => updates(message as RouteHint)) as RouteHint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteHint create() => RouteHint._();
  RouteHint createEmptyInstance() => create();
  static $pb.PbList<RouteHint> createRepeated() => $pb.PbList<RouteHint>();
  @$core.pragma('dart2js:noInline')
  static RouteHint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteHint>(create);
  static RouteHint? _defaultInstance;

  ///
  /// A list of hop hints that when chained together can assist in reaching a
  /// specific destination.
  @$pb.TagNumber(1)
  $pb.PbList<HopHint> get hopHints => $_getList(0);
}

class BlindedPaymentPath extends $pb.GeneratedMessage {
  factory BlindedPaymentPath({
    BlindedPath? blindedPath,
    $fixnum.Int64? baseFeeMsat,
    $core.int? proportionalFeeRate,
    $core.int? totalCltvDelta,
    $fixnum.Int64? htlcMinMsat,
    $fixnum.Int64? htlcMaxMsat,
    $core.Iterable<FeatureBit>? features,
  }) {
    final $result = create();
    if (blindedPath != null) {
      $result.blindedPath = blindedPath;
    }
    if (baseFeeMsat != null) {
      $result.baseFeeMsat = baseFeeMsat;
    }
    if (proportionalFeeRate != null) {
      $result.proportionalFeeRate = proportionalFeeRate;
    }
    if (totalCltvDelta != null) {
      $result.totalCltvDelta = totalCltvDelta;
    }
    if (htlcMinMsat != null) {
      $result.htlcMinMsat = htlcMinMsat;
    }
    if (htlcMaxMsat != null) {
      $result.htlcMaxMsat = htlcMaxMsat;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    return $result;
  }
  BlindedPaymentPath._() : super();
  factory BlindedPaymentPath.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedPaymentPath.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedPaymentPath', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<BlindedPath>(1, _omitFieldNames ? '' : 'blindedPath', subBuilder: BlindedPath.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'baseFeeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'proportionalFeeRate', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'totalCltvDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'htlcMinMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'htlcMaxMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<FeatureBit>(7, _omitFieldNames ? '' : 'features', $pb.PbFieldType.KE, valueOf: FeatureBit.valueOf, enumValues: FeatureBit.values, defaultEnumValue: FeatureBit.DATALOSS_PROTECT_REQ)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlindedPaymentPath clone() => BlindedPaymentPath()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlindedPaymentPath copyWith(void Function(BlindedPaymentPath) updates) => super.copyWith((message) => updates(message as BlindedPaymentPath)) as BlindedPaymentPath;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlindedPaymentPath create() => BlindedPaymentPath._();
  BlindedPaymentPath createEmptyInstance() => create();
  static $pb.PbList<BlindedPaymentPath> createRepeated() => $pb.PbList<BlindedPaymentPath>();
  @$core.pragma('dart2js:noInline')
  static BlindedPaymentPath getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlindedPaymentPath>(create);
  static BlindedPaymentPath? _defaultInstance;

  /// The blinded path to send the payment to.
  @$pb.TagNumber(1)
  BlindedPath get blindedPath => $_getN(0);
  @$pb.TagNumber(1)
  set blindedPath(BlindedPath v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlindedPath() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlindedPath() => $_clearField(1);
  @$pb.TagNumber(1)
  BlindedPath ensureBlindedPath() => $_ensure(0);

  /// The base fee for the blinded path provided, expressed in msat.
  @$pb.TagNumber(2)
  $fixnum.Int64 get baseFeeMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set baseFeeMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBaseFeeMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseFeeMsat() => $_clearField(2);

  ///
  /// The proportional fee for the blinded path provided, expressed in parts
  /// per million.
  @$pb.TagNumber(3)
  $core.int get proportionalFeeRate => $_getIZ(2);
  @$pb.TagNumber(3)
  set proportionalFeeRate($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasProportionalFeeRate() => $_has(2);
  @$pb.TagNumber(3)
  void clearProportionalFeeRate() => $_clearField(3);

  ///
  /// The total CLTV delta for the blinded path provided, including the
  /// final CLTV delta for the receiving node.
  @$pb.TagNumber(4)
  $core.int get totalCltvDelta => $_getIZ(3);
  @$pb.TagNumber(4)
  set totalCltvDelta($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalCltvDelta() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalCltvDelta() => $_clearField(4);

  ///
  /// The minimum hltc size that may be sent over the blinded path, expressed
  /// in msat.
  @$pb.TagNumber(5)
  $fixnum.Int64 get htlcMinMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set htlcMinMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHtlcMinMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearHtlcMinMsat() => $_clearField(5);

  ///
  /// The maximum htlc size that may be sent over the blinded path, expressed
  /// in msat.
  @$pb.TagNumber(6)
  $fixnum.Int64 get htlcMaxMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set htlcMaxMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasHtlcMaxMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearHtlcMaxMsat() => $_clearField(6);

  /// The feature bits for the route.
  @$pb.TagNumber(7)
  $pb.PbList<FeatureBit> get features => $_getList(6);
}

class BlindedPath extends $pb.GeneratedMessage {
  factory BlindedPath({
    $core.List<$core.int>? introductionNode,
    $core.List<$core.int>? blindingPoint,
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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedPath', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'introductionNode', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'blindingPoint', $pb.PbFieldType.OY)
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

  /// The unblinded pubkey of the introduction node for the route.
  @$pb.TagNumber(1)
  $core.List<$core.int> get introductionNode => $_getN(0);
  @$pb.TagNumber(1)
  set introductionNode($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIntroductionNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearIntroductionNode() => $_clearField(1);

  /// The ephemeral pubkey used by nodes in the blinded route.
  @$pb.TagNumber(2)
  $core.List<$core.int> get blindingPoint => $_getN(1);
  @$pb.TagNumber(2)
  set blindingPoint($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBlindingPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearBlindingPoint() => $_clearField(2);

  ///
  /// A set of blinded node keys and data blobs for the blinded portion of the
  /// route. Note that the first hop is expected to be the introduction node,
  /// so the route is always expected to have at least one hop.
  @$pb.TagNumber(3)
  $pb.PbList<BlindedHop> get blindedHops => $_getList(2);
}

class BlindedHop extends $pb.GeneratedMessage {
  factory BlindedHop({
    $core.List<$core.int>? blindedNode,
    $core.List<$core.int>? encryptedData,
  }) {
    final $result = create();
    if (blindedNode != null) {
      $result.blindedNode = blindedNode;
    }
    if (encryptedData != null) {
      $result.encryptedData = encryptedData;
    }
    return $result;
  }
  BlindedHop._() : super();
  factory BlindedHop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedHop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedHop', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'blindedNode', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'encryptedData', $pb.PbFieldType.OY)
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

  /// The blinded public key of the node.
  @$pb.TagNumber(1)
  $core.List<$core.int> get blindedNode => $_getN(0);
  @$pb.TagNumber(1)
  set blindedNode($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlindedNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlindedNode() => $_clearField(1);

  /// An encrypted blob of data provided to the blinded node.
  @$pb.TagNumber(2)
  $core.List<$core.int> get encryptedData => $_getN(1);
  @$pb.TagNumber(2)
  set encryptedData($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEncryptedData() => $_has(1);
  @$pb.TagNumber(2)
  void clearEncryptedData() => $_clearField(2);
}

class AMPInvoiceState extends $pb.GeneratedMessage {
  factory AMPInvoiceState({
    InvoiceHTLCState? state,
    $fixnum.Int64? settleIndex,
    $fixnum.Int64? settleTime,
    $fixnum.Int64? amtPaidMsat,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    if (settleIndex != null) {
      $result.settleIndex = settleIndex;
    }
    if (settleTime != null) {
      $result.settleTime = settleTime;
    }
    if (amtPaidMsat != null) {
      $result.amtPaidMsat = amtPaidMsat;
    }
    return $result;
  }
  AMPInvoiceState._() : super();
  factory AMPInvoiceState.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AMPInvoiceState.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AMPInvoiceState', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<InvoiceHTLCState>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: InvoiceHTLCState.ACCEPTED, valueOf: InvoiceHTLCState.valueOf, enumValues: InvoiceHTLCState.values)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'settleIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(3, _omitFieldNames ? '' : 'settleTime')
    ..aInt64(5, _omitFieldNames ? '' : 'amtPaidMsat')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AMPInvoiceState clone() => AMPInvoiceState()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AMPInvoiceState copyWith(void Function(AMPInvoiceState) updates) => super.copyWith((message) => updates(message as AMPInvoiceState)) as AMPInvoiceState;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AMPInvoiceState create() => AMPInvoiceState._();
  AMPInvoiceState createEmptyInstance() => create();
  static $pb.PbList<AMPInvoiceState> createRepeated() => $pb.PbList<AMPInvoiceState>();
  @$core.pragma('dart2js:noInline')
  static AMPInvoiceState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AMPInvoiceState>(create);
  static AMPInvoiceState? _defaultInstance;

  /// The state the HTLCs associated with this setID are in.
  @$pb.TagNumber(1)
  InvoiceHTLCState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(InvoiceHTLCState v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  /// The settle index of this HTLC set, if the invoice state is settled.
  @$pb.TagNumber(2)
  $fixnum.Int64 get settleIndex => $_getI64(1);
  @$pb.TagNumber(2)
  set settleIndex($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSettleIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearSettleIndex() => $_clearField(2);

  /// The time this HTLC set was settled expressed in unix epoch.
  @$pb.TagNumber(3)
  $fixnum.Int64 get settleTime => $_getI64(2);
  @$pb.TagNumber(3)
  set settleTime($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSettleTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearSettleTime() => $_clearField(3);

  /// The total amount paid for the sub-invoice expressed in milli satoshis.
  @$pb.TagNumber(5)
  $fixnum.Int64 get amtPaidMsat => $_getI64(3);
  @$pb.TagNumber(5)
  set amtPaidMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmtPaidMsat() => $_has(3);
  @$pb.TagNumber(5)
  void clearAmtPaidMsat() => $_clearField(5);
}

class Invoice extends $pb.GeneratedMessage {
  factory Invoice({
    $core.String? memo,
    $core.List<$core.int>? rPreimage,
    $core.List<$core.int>? rHash,
    $fixnum.Int64? value,
  @$core.Deprecated('This field is deprecated.')
    $core.bool? settled,
    $fixnum.Int64? creationDate,
    $fixnum.Int64? settleDate,
    $core.String? paymentRequest,
    $core.List<$core.int>? descriptionHash,
    $fixnum.Int64? expiry,
    $core.String? fallbackAddr,
    $fixnum.Int64? cltvExpiry,
    $core.Iterable<RouteHint>? routeHints,
    $core.bool? private,
    $fixnum.Int64? addIndex,
    $fixnum.Int64? settleIndex,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? amtPaid,
    $fixnum.Int64? amtPaidSat,
    $fixnum.Int64? amtPaidMsat,
    Invoice_InvoiceState? state,
    $core.Iterable<InvoiceHTLC>? htlcs,
    $fixnum.Int64? valueMsat,
    $pb.PbMap<$core.int, Feature>? features,
    $core.bool? isKeysend,
    $core.List<$core.int>? paymentAddr,
    $core.bool? isAmp,
    $pb.PbMap<$core.String, AMPInvoiceState>? ampInvoiceState,
    $core.bool? isBlinded,
    BlindedPathConfig? blindedPathConfig,
  }) {
    final $result = create();
    if (memo != null) {
      $result.memo = memo;
    }
    if (rPreimage != null) {
      $result.rPreimage = rPreimage;
    }
    if (rHash != null) {
      $result.rHash = rHash;
    }
    if (value != null) {
      $result.value = value;
    }
    if (settled != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.settled = settled;
    }
    if (creationDate != null) {
      $result.creationDate = creationDate;
    }
    if (settleDate != null) {
      $result.settleDate = settleDate;
    }
    if (paymentRequest != null) {
      $result.paymentRequest = paymentRequest;
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
    if (addIndex != null) {
      $result.addIndex = addIndex;
    }
    if (settleIndex != null) {
      $result.settleIndex = settleIndex;
    }
    if (amtPaid != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.amtPaid = amtPaid;
    }
    if (amtPaidSat != null) {
      $result.amtPaidSat = amtPaidSat;
    }
    if (amtPaidMsat != null) {
      $result.amtPaidMsat = amtPaidMsat;
    }
    if (state != null) {
      $result.state = state;
    }
    if (htlcs != null) {
      $result.htlcs.addAll(htlcs);
    }
    if (valueMsat != null) {
      $result.valueMsat = valueMsat;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (isKeysend != null) {
      $result.isKeysend = isKeysend;
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    if (isAmp != null) {
      $result.isAmp = isAmp;
    }
    if (ampInvoiceState != null) {
      $result.ampInvoiceState.addAll(ampInvoiceState);
    }
    if (isBlinded != null) {
      $result.isBlinded = isBlinded;
    }
    if (blindedPathConfig != null) {
      $result.blindedPathConfig = blindedPathConfig;
    }
    return $result;
  }
  Invoice._() : super();
  factory Invoice.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invoice.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Invoice', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'memo')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'rPreimage', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'rHash', $pb.PbFieldType.OY)
    ..aInt64(5, _omitFieldNames ? '' : 'value')
    ..aOB(6, _omitFieldNames ? '' : 'settled')
    ..aInt64(7, _omitFieldNames ? '' : 'creationDate')
    ..aInt64(8, _omitFieldNames ? '' : 'settleDate')
    ..aOS(9, _omitFieldNames ? '' : 'paymentRequest')
    ..a<$core.List<$core.int>>(10, _omitFieldNames ? '' : 'descriptionHash', $pb.PbFieldType.OY)
    ..aInt64(11, _omitFieldNames ? '' : 'expiry')
    ..aOS(12, _omitFieldNames ? '' : 'fallbackAddr')
    ..a<$fixnum.Int64>(13, _omitFieldNames ? '' : 'cltvExpiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<RouteHint>(14, _omitFieldNames ? '' : 'routeHints', $pb.PbFieldType.PM, subBuilder: RouteHint.create)
    ..aOB(15, _omitFieldNames ? '' : 'private')
    ..a<$fixnum.Int64>(16, _omitFieldNames ? '' : 'addIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(17, _omitFieldNames ? '' : 'settleIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(18, _omitFieldNames ? '' : 'amtPaid')
    ..aInt64(19, _omitFieldNames ? '' : 'amtPaidSat')
    ..aInt64(20, _omitFieldNames ? '' : 'amtPaidMsat')
    ..e<Invoice_InvoiceState>(21, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: Invoice_InvoiceState.OPEN, valueOf: Invoice_InvoiceState.valueOf, enumValues: Invoice_InvoiceState.values)
    ..pc<InvoiceHTLC>(22, _omitFieldNames ? '' : 'htlcs', $pb.PbFieldType.PM, subBuilder: InvoiceHTLC.create)
    ..aInt64(23, _omitFieldNames ? '' : 'valueMsat')
    ..m<$core.int, Feature>(24, _omitFieldNames ? '' : 'features', entryClassName: 'Invoice.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..aOB(25, _omitFieldNames ? '' : 'isKeysend')
    ..a<$core.List<$core.int>>(26, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..aOB(27, _omitFieldNames ? '' : 'isAmp')
    ..m<$core.String, AMPInvoiceState>(28, _omitFieldNames ? '' : 'ampInvoiceState', entryClassName: 'Invoice.AmpInvoiceStateEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: AMPInvoiceState.create, valueDefaultOrMaker: AMPInvoiceState.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..aOB(29, _omitFieldNames ? '' : 'isBlinded')
    ..aOM<BlindedPathConfig>(30, _omitFieldNames ? '' : 'blindedPathConfig', subBuilder: BlindedPathConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invoice clone() => Invoice()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invoice copyWith(void Function(Invoice) updates) => super.copyWith((message) => updates(message as Invoice)) as Invoice;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Invoice create() => Invoice._();
  Invoice createEmptyInstance() => create();
  static $pb.PbList<Invoice> createRepeated() => $pb.PbList<Invoice>();
  @$core.pragma('dart2js:noInline')
  static Invoice getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invoice>(create);
  static Invoice? _defaultInstance;

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

  ///
  /// The hex-encoded preimage (32 byte) which will allow settling an incoming
  /// HTLC payable to this preimage. When using REST, this field must be encoded
  /// as base64.
  @$pb.TagNumber(3)
  $core.List<$core.int> get rPreimage => $_getN(1);
  @$pb.TagNumber(3)
  set rPreimage($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasRPreimage() => $_has(1);
  @$pb.TagNumber(3)
  void clearRPreimage() => $_clearField(3);

  ///
  /// The hash of the preimage. When using REST, this field must be encoded as
  /// base64.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(4)
  $core.List<$core.int> get rHash => $_getN(2);
  @$pb.TagNumber(4)
  set rHash($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasRHash() => $_has(2);
  @$pb.TagNumber(4)
  void clearRHash() => $_clearField(4);

  ///
  /// The value of this invoice in satoshis
  ///
  /// The fields value and value_msat are mutually exclusive.
  @$pb.TagNumber(5)
  $fixnum.Int64 get value => $_getI64(3);
  @$pb.TagNumber(5)
  set value($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasValue() => $_has(3);
  @$pb.TagNumber(5)
  void clearValue() => $_clearField(5);

  ///
  /// Whether this invoice has been fulfilled.
  ///
  /// The field is deprecated. Use the state field instead (compare to SETTLED).
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  $core.bool get settled => $_getBF(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  set settled($core.bool v) { $_setBool(4, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  $core.bool hasSettled() => $_has(4);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(6)
  void clearSettled() => $_clearField(6);

  ///
  /// When this invoice was created.
  /// Measured in seconds since the unix epoch.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(7)
  $fixnum.Int64 get creationDate => $_getI64(5);
  @$pb.TagNumber(7)
  set creationDate($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreationDate() => $_has(5);
  @$pb.TagNumber(7)
  void clearCreationDate() => $_clearField(7);

  ///
  /// When this invoice was settled.
  /// Measured in seconds since the unix epoch.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(8)
  $fixnum.Int64 get settleDate => $_getI64(6);
  @$pb.TagNumber(8)
  set settleDate($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasSettleDate() => $_has(6);
  @$pb.TagNumber(8)
  void clearSettleDate() => $_clearField(8);

  ///
  /// A bare-bones invoice for a payment within the Lightning Network. With the
  /// details of the invoice, the sender has all the data necessary to send a
  /// payment to the recipient.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(9)
  $core.String get paymentRequest => $_getSZ(7);
  @$pb.TagNumber(9)
  set paymentRequest($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaymentRequest() => $_has(7);
  @$pb.TagNumber(9)
  void clearPaymentRequest() => $_clearField(9);

  ///
  /// Hash (SHA-256) of a description of the payment. Used if the description of
  /// payment (memo) is too long to naturally fit within the description field
  /// of an encoded payment request. When using REST, this field must be encoded
  /// as base64.
  @$pb.TagNumber(10)
  $core.List<$core.int> get descriptionHash => $_getN(8);
  @$pb.TagNumber(10)
  set descriptionHash($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasDescriptionHash() => $_has(8);
  @$pb.TagNumber(10)
  void clearDescriptionHash() => $_clearField(10);

  /// Payment request expiry time in seconds. Default is 86400 (24 hours).
  @$pb.TagNumber(11)
  $fixnum.Int64 get expiry => $_getI64(9);
  @$pb.TagNumber(11)
  set expiry($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasExpiry() => $_has(9);
  @$pb.TagNumber(11)
  void clearExpiry() => $_clearField(11);

  /// Fallback on-chain address.
  @$pb.TagNumber(12)
  $core.String get fallbackAddr => $_getSZ(10);
  @$pb.TagNumber(12)
  set fallbackAddr($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasFallbackAddr() => $_has(10);
  @$pb.TagNumber(12)
  void clearFallbackAddr() => $_clearField(12);

  /// Delta to use for the time-lock of the CLTV extended to the final hop.
  @$pb.TagNumber(13)
  $fixnum.Int64 get cltvExpiry => $_getI64(11);
  @$pb.TagNumber(13)
  set cltvExpiry($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(13)
  $core.bool hasCltvExpiry() => $_has(11);
  @$pb.TagNumber(13)
  void clearCltvExpiry() => $_clearField(13);

  ///
  /// Route hints that can each be individually used to assist in reaching the
  /// invoice's destination.
  @$pb.TagNumber(14)
  $pb.PbList<RouteHint> get routeHints => $_getList(12);

  /// Whether this invoice should include routing hints for private channels.
  /// Note: When enabled, if value and value_msat are zero, a large number of
  /// hints with these channels can be included, which might not be desirable.
  @$pb.TagNumber(15)
  $core.bool get private => $_getBF(13);
  @$pb.TagNumber(15)
  set private($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(15)
  $core.bool hasPrivate() => $_has(13);
  @$pb.TagNumber(15)
  void clearPrivate() => $_clearField(15);

  ///
  /// The "add" index of this invoice. Each newly created invoice will increment
  /// this index making it monotonically increasing. Callers to the
  /// SubscribeInvoices call can use this to instantly get notified of all added
  /// invoices with an add_index greater than this one.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(16)
  $fixnum.Int64 get addIndex => $_getI64(14);
  @$pb.TagNumber(16)
  set addIndex($fixnum.Int64 v) { $_setInt64(14, v); }
  @$pb.TagNumber(16)
  $core.bool hasAddIndex() => $_has(14);
  @$pb.TagNumber(16)
  void clearAddIndex() => $_clearField(16);

  ///
  /// The "settle" index of this invoice. Each newly settled invoice will
  /// increment this index making it monotonically increasing. Callers to the
  /// SubscribeInvoices call can use this to instantly get notified of all
  /// settled invoices with an settle_index greater than this one.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(17)
  $fixnum.Int64 get settleIndex => $_getI64(15);
  @$pb.TagNumber(17)
  set settleIndex($fixnum.Int64 v) { $_setInt64(15, v); }
  @$pb.TagNumber(17)
  $core.bool hasSettleIndex() => $_has(15);
  @$pb.TagNumber(17)
  void clearSettleIndex() => $_clearField(17);

  /// Deprecated, use amt_paid_sat or amt_paid_msat.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(18)
  $fixnum.Int64 get amtPaid => $_getI64(16);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(18)
  set amtPaid($fixnum.Int64 v) { $_setInt64(16, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(18)
  $core.bool hasAmtPaid() => $_has(16);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(18)
  void clearAmtPaid() => $_clearField(18);

  ///
  /// The amount that was accepted for this invoice, in satoshis. This will ONLY
  /// be set if this invoice has been settled or accepted. We provide this field
  /// as if the invoice was created with a zero value, then we need to record what
  /// amount was ultimately accepted. Additionally, it's possible that the sender
  /// paid MORE that was specified in the original invoice. So we'll record that
  /// here as well.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(19)
  $fixnum.Int64 get amtPaidSat => $_getI64(17);
  @$pb.TagNumber(19)
  set amtPaidSat($fixnum.Int64 v) { $_setInt64(17, v); }
  @$pb.TagNumber(19)
  $core.bool hasAmtPaidSat() => $_has(17);
  @$pb.TagNumber(19)
  void clearAmtPaidSat() => $_clearField(19);

  ///
  /// The amount that was accepted for this invoice, in millisatoshis. This will
  /// ONLY be set if this invoice has been settled or accepted. We provide this
  /// field as if the invoice was created with a zero value, then we need to
  /// record what amount was ultimately accepted. Additionally, it's possible that
  /// the sender paid MORE that was specified in the original invoice. So we'll
  /// record that here as well.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(20)
  $fixnum.Int64 get amtPaidMsat => $_getI64(18);
  @$pb.TagNumber(20)
  set amtPaidMsat($fixnum.Int64 v) { $_setInt64(18, v); }
  @$pb.TagNumber(20)
  $core.bool hasAmtPaidMsat() => $_has(18);
  @$pb.TagNumber(20)
  void clearAmtPaidMsat() => $_clearField(20);

  ///
  /// The state the invoice is in.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(21)
  Invoice_InvoiceState get state => $_getN(19);
  @$pb.TagNumber(21)
  set state(Invoice_InvoiceState v) { $_setField(21, v); }
  @$pb.TagNumber(21)
  $core.bool hasState() => $_has(19);
  @$pb.TagNumber(21)
  void clearState() => $_clearField(21);

  ///
  /// List of HTLCs paying to this invoice [EXPERIMENTAL].
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(22)
  $pb.PbList<InvoiceHTLC> get htlcs => $_getList(20);

  ///
  /// The value of this invoice in millisatoshis
  ///
  /// The fields value and value_msat are mutually exclusive.
  @$pb.TagNumber(23)
  $fixnum.Int64 get valueMsat => $_getI64(21);
  @$pb.TagNumber(23)
  set valueMsat($fixnum.Int64 v) { $_setInt64(21, v); }
  @$pb.TagNumber(23)
  $core.bool hasValueMsat() => $_has(21);
  @$pb.TagNumber(23)
  void clearValueMsat() => $_clearField(23);

  ///
  /// List of features advertised on the invoice.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(24)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(22);

  ///
  /// Indicates if this invoice was a spontaneous payment that arrived via keysend
  /// [EXPERIMENTAL].
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(25)
  $core.bool get isKeysend => $_getBF(23);
  @$pb.TagNumber(25)
  set isKeysend($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(25)
  $core.bool hasIsKeysend() => $_has(23);
  @$pb.TagNumber(25)
  void clearIsKeysend() => $_clearField(25);

  ///
  /// The payment address of this invoice. This is also called payment secret in
  /// specifications (e.g. BOLT 11). This value will be used in MPP payments, and
  /// also for newer invoices that always require the MPP payload for added
  /// end-to-end security.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(26)
  $core.List<$core.int> get paymentAddr => $_getN(24);
  @$pb.TagNumber(26)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(24, v); }
  @$pb.TagNumber(26)
  $core.bool hasPaymentAddr() => $_has(24);
  @$pb.TagNumber(26)
  void clearPaymentAddr() => $_clearField(26);

  ///
  /// Signals whether or not this is an AMP invoice.
  @$pb.TagNumber(27)
  $core.bool get isAmp => $_getBF(25);
  @$pb.TagNumber(27)
  set isAmp($core.bool v) { $_setBool(25, v); }
  @$pb.TagNumber(27)
  $core.bool hasIsAmp() => $_has(25);
  @$pb.TagNumber(27)
  void clearIsAmp() => $_clearField(27);

  ///
  /// [EXPERIMENTAL]:
  ///
  /// Maps a 32-byte hex-encoded set ID to the sub-invoice AMP state for the
  /// given set ID. This field is always populated for AMP invoices, and can be
  /// used along side LookupInvoice to obtain the HTLC information related to a
  /// given sub-invoice.
  /// Note: Output only, don't specify for creating an invoice.
  @$pb.TagNumber(28)
  $pb.PbMap<$core.String, AMPInvoiceState> get ampInvoiceState => $_getMap(26);

  ///
  /// Signals that the invoice should include blinded paths to hide the true
  /// identity of the recipient.
  @$pb.TagNumber(29)
  $core.bool get isBlinded => $_getBF(27);
  @$pb.TagNumber(29)
  set isBlinded($core.bool v) { $_setBool(27, v); }
  @$pb.TagNumber(29)
  $core.bool hasIsBlinded() => $_has(27);
  @$pb.TagNumber(29)
  void clearIsBlinded() => $_clearField(29);

  ///
  /// Config values to use when creating blinded paths for this invoice. These
  /// can be used to override the defaults config values provided in by the
  /// global config. This field is only used if is_blinded is true.
  @$pb.TagNumber(30)
  BlindedPathConfig get blindedPathConfig => $_getN(28);
  @$pb.TagNumber(30)
  set blindedPathConfig(BlindedPathConfig v) { $_setField(30, v); }
  @$pb.TagNumber(30)
  $core.bool hasBlindedPathConfig() => $_has(28);
  @$pb.TagNumber(30)
  void clearBlindedPathConfig() => $_clearField(30);
  @$pb.TagNumber(30)
  BlindedPathConfig ensureBlindedPathConfig() => $_ensure(28);
}

class BlindedPathConfig extends $pb.GeneratedMessage {
  factory BlindedPathConfig({
    $core.int? minNumRealHops,
    $core.int? numHops,
    $core.int? maxNumPaths,
    $core.Iterable<$core.List<$core.int>>? nodeOmissionList,
  }) {
    final $result = create();
    if (minNumRealHops != null) {
      $result.minNumRealHops = minNumRealHops;
    }
    if (numHops != null) {
      $result.numHops = numHops;
    }
    if (maxNumPaths != null) {
      $result.maxNumPaths = maxNumPaths;
    }
    if (nodeOmissionList != null) {
      $result.nodeOmissionList.addAll(nodeOmissionList);
    }
    return $result;
  }
  BlindedPathConfig._() : super();
  factory BlindedPathConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedPathConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedPathConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'minNumRealHops', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'numHops', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'maxNumPaths', $pb.PbFieldType.OU3)
    ..p<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'nodeOmissionList', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlindedPathConfig clone() => BlindedPathConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlindedPathConfig copyWith(void Function(BlindedPathConfig) updates) => super.copyWith((message) => updates(message as BlindedPathConfig)) as BlindedPathConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlindedPathConfig create() => BlindedPathConfig._();
  BlindedPathConfig createEmptyInstance() => create();
  static $pb.PbList<BlindedPathConfig> createRepeated() => $pb.PbList<BlindedPathConfig>();
  @$core.pragma('dart2js:noInline')
  static BlindedPathConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlindedPathConfig>(create);
  static BlindedPathConfig? _defaultInstance;

  ///
  /// The minimum number of real hops to include in a blinded path. This doesn't
  /// include our node, so if the minimum is 1, then the path will contain at
  /// minimum our node along with an introduction node hop. If it is zero then
  /// the shortest path will use our node as an introduction node.
  @$pb.TagNumber(1)
  $core.int get minNumRealHops => $_getIZ(0);
  @$pb.TagNumber(1)
  set minNumRealHops($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMinNumRealHops() => $_has(0);
  @$pb.TagNumber(1)
  void clearMinNumRealHops() => $_clearField(1);

  ///
  /// The number of hops to include in a blinded path. This doesn't include our
  /// node, so if it is 1, then the path will contain our node along with an
  /// introduction node or dummy node hop. If paths shorter than NumHops is
  /// found, then they will be padded using dummy hops.
  @$pb.TagNumber(2)
  $core.int get numHops => $_getIZ(1);
  @$pb.TagNumber(2)
  set numHops($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNumHops() => $_has(1);
  @$pb.TagNumber(2)
  void clearNumHops() => $_clearField(2);

  ///
  /// The maximum number of blinded paths to select and add to an invoice.
  @$pb.TagNumber(3)
  $core.int get maxNumPaths => $_getIZ(2);
  @$pb.TagNumber(3)
  set maxNumPaths($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxNumPaths() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxNumPaths() => $_clearField(3);

  ///
  /// A list of node IDs of nodes that should not be used in any of our generated
  /// blinded paths.
  @$pb.TagNumber(4)
  $pb.PbList<$core.List<$core.int>> get nodeOmissionList => $_getList(3);
}

/// Details of an HTLC that paid to an invoice
class InvoiceHTLC extends $pb.GeneratedMessage {
  factory InvoiceHTLC({
    $fixnum.Int64? chanId,
    $fixnum.Int64? htlcIndex,
    $fixnum.Int64? amtMsat,
    $core.int? acceptHeight,
    $fixnum.Int64? acceptTime,
    $fixnum.Int64? resolveTime,
    $core.int? expiryHeight,
    InvoiceHTLCState? state,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? customRecords,
    $fixnum.Int64? mppTotalAmtMsat,
    AMP? amp,
    $core.List<$core.int>? customChannelData,
  }) {
    final $result = create();
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (htlcIndex != null) {
      $result.htlcIndex = htlcIndex;
    }
    if (amtMsat != null) {
      $result.amtMsat = amtMsat;
    }
    if (acceptHeight != null) {
      $result.acceptHeight = acceptHeight;
    }
    if (acceptTime != null) {
      $result.acceptTime = acceptTime;
    }
    if (resolveTime != null) {
      $result.resolveTime = resolveTime;
    }
    if (expiryHeight != null) {
      $result.expiryHeight = expiryHeight;
    }
    if (state != null) {
      $result.state = state;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    if (mppTotalAmtMsat != null) {
      $result.mppTotalAmtMsat = mppTotalAmtMsat;
    }
    if (amp != null) {
      $result.amp = amp;
    }
    if (customChannelData != null) {
      $result.customChannelData = customChannelData;
    }
    return $result;
  }
  InvoiceHTLC._() : super();
  factory InvoiceHTLC.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceHTLC.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceHTLC', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'htlcIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amtMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'acceptHeight', $pb.PbFieldType.O3)
    ..aInt64(5, _omitFieldNames ? '' : 'acceptTime')
    ..aInt64(6, _omitFieldNames ? '' : 'resolveTime')
    ..a<$core.int>(7, _omitFieldNames ? '' : 'expiryHeight', $pb.PbFieldType.O3)
    ..e<InvoiceHTLCState>(8, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: InvoiceHTLCState.ACCEPTED, valueOf: InvoiceHTLCState.valueOf, enumValues: InvoiceHTLCState.values)
    ..m<$fixnum.Int64, $core.List<$core.int>>(9, _omitFieldNames ? '' : 'customRecords', entryClassName: 'InvoiceHTLC.CustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'mppTotalAmtMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<AMP>(11, _omitFieldNames ? '' : 'amp', subBuilder: AMP.create)
    ..a<$core.List<$core.int>>(12, _omitFieldNames ? '' : 'customChannelData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceHTLC clone() => InvoiceHTLC()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceHTLC copyWith(void Function(InvoiceHTLC) updates) => super.copyWith((message) => updates(message as InvoiceHTLC)) as InvoiceHTLC;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceHTLC create() => InvoiceHTLC._();
  InvoiceHTLC createEmptyInstance() => create();
  static $pb.PbList<InvoiceHTLC> createRepeated() => $pb.PbList<InvoiceHTLC>();
  @$core.pragma('dart2js:noInline')
  static InvoiceHTLC getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceHTLC>(create);
  static InvoiceHTLC? _defaultInstance;

  /// Short channel id over which the htlc was received.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  /// Index identifying the htlc on the channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get htlcIndex => $_getI64(1);
  @$pb.TagNumber(2)
  set htlcIndex($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHtlcIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearHtlcIndex() => $_clearField(2);

  /// The amount of the htlc in msat.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amtMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set amtMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmtMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmtMsat() => $_clearField(3);

  /// Block height at which this htlc was accepted.
  @$pb.TagNumber(4)
  $core.int get acceptHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set acceptHeight($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAcceptHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearAcceptHeight() => $_clearField(4);

  /// Time at which this htlc was accepted.
  @$pb.TagNumber(5)
  $fixnum.Int64 get acceptTime => $_getI64(4);
  @$pb.TagNumber(5)
  set acceptTime($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAcceptTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearAcceptTime() => $_clearField(5);

  /// Time at which this htlc was settled or canceled.
  @$pb.TagNumber(6)
  $fixnum.Int64 get resolveTime => $_getI64(5);
  @$pb.TagNumber(6)
  set resolveTime($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasResolveTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearResolveTime() => $_clearField(6);

  /// Block height at which this htlc expires.
  @$pb.TagNumber(7)
  $core.int get expiryHeight => $_getIZ(6);
  @$pb.TagNumber(7)
  set expiryHeight($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasExpiryHeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearExpiryHeight() => $_clearField(7);

  /// Current state the htlc is in.
  @$pb.TagNumber(8)
  InvoiceHTLCState get state => $_getN(7);
  @$pb.TagNumber(8)
  set state(InvoiceHTLCState v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasState() => $_has(7);
  @$pb.TagNumber(8)
  void clearState() => $_clearField(8);

  /// Custom tlv records.
  @$pb.TagNumber(9)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get customRecords => $_getMap(8);

  /// The total amount of the mpp payment in msat.
  @$pb.TagNumber(10)
  $fixnum.Int64 get mppTotalAmtMsat => $_getI64(9);
  @$pb.TagNumber(10)
  set mppTotalAmtMsat($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMppTotalAmtMsat() => $_has(9);
  @$pb.TagNumber(10)
  void clearMppTotalAmtMsat() => $_clearField(10);

  /// Details relevant to AMP HTLCs, only populated if this is an AMP HTLC.
  @$pb.TagNumber(11)
  AMP get amp => $_getN(10);
  @$pb.TagNumber(11)
  set amp(AMP v) { $_setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasAmp() => $_has(10);
  @$pb.TagNumber(11)
  void clearAmp() => $_clearField(11);
  @$pb.TagNumber(11)
  AMP ensureAmp() => $_ensure(10);

  ///
  /// Custom channel data that might be populated in custom channels.
  @$pb.TagNumber(12)
  $core.List<$core.int> get customChannelData => $_getN(11);
  @$pb.TagNumber(12)
  set customChannelData($core.List<$core.int> v) { $_setBytes(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCustomChannelData() => $_has(11);
  @$pb.TagNumber(12)
  void clearCustomChannelData() => $_clearField(12);
}

/// Details specific to AMP HTLCs.
class AMP extends $pb.GeneratedMessage {
  factory AMP({
    $core.List<$core.int>? rootShare,
    $core.List<$core.int>? setId,
    $core.int? childIndex,
    $core.List<$core.int>? hash,
    $core.List<$core.int>? preimage,
  }) {
    final $result = create();
    if (rootShare != null) {
      $result.rootShare = rootShare;
    }
    if (setId != null) {
      $result.setId = setId;
    }
    if (childIndex != null) {
      $result.childIndex = childIndex;
    }
    if (hash != null) {
      $result.hash = hash;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    return $result;
  }
  AMP._() : super();
  factory AMP.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AMP.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AMP', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rootShare', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'setId', $pb.PbFieldType.OY)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'childIndex', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'hash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AMP clone() => AMP()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AMP copyWith(void Function(AMP) updates) => super.copyWith((message) => updates(message as AMP)) as AMP;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AMP create() => AMP._();
  AMP createEmptyInstance() => create();
  static $pb.PbList<AMP> createRepeated() => $pb.PbList<AMP>();
  @$core.pragma('dart2js:noInline')
  static AMP getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AMP>(create);
  static AMP? _defaultInstance;

  /// An n-of-n secret share of the root seed from which child payment hashes
  /// and preimages are derived.
  @$pb.TagNumber(1)
  $core.List<$core.int> get rootShare => $_getN(0);
  @$pb.TagNumber(1)
  set rootShare($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRootShare() => $_has(0);
  @$pb.TagNumber(1)
  void clearRootShare() => $_clearField(1);

  /// An identifier for the HTLC set that this HTLC belongs to.
  @$pb.TagNumber(2)
  $core.List<$core.int> get setId => $_getN(1);
  @$pb.TagNumber(2)
  set setId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSetId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSetId() => $_clearField(2);

  /// A nonce used to randomize the child preimage and child hash from a given
  /// root_share.
  @$pb.TagNumber(3)
  $core.int get childIndex => $_getIZ(2);
  @$pb.TagNumber(3)
  set childIndex($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChildIndex() => $_has(2);
  @$pb.TagNumber(3)
  void clearChildIndex() => $_clearField(3);

  /// The payment hash of the AMP HTLC.
  @$pb.TagNumber(4)
  $core.List<$core.int> get hash => $_getN(3);
  @$pb.TagNumber(4)
  set hash($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearHash() => $_clearField(4);

  /// The preimage used to settle this AMP htlc. This field will only be
  /// populated if the invoice is in InvoiceState_ACCEPTED or
  /// InvoiceState_SETTLED.
  @$pb.TagNumber(5)
  $core.List<$core.int> get preimage => $_getN(4);
  @$pb.TagNumber(5)
  set preimage($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPreimage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPreimage() => $_clearField(5);
}

class AddInvoiceResponse extends $pb.GeneratedMessage {
  factory AddInvoiceResponse({
    $core.List<$core.int>? rHash,
    $core.String? paymentRequest,
    $fixnum.Int64? addIndex,
    $core.List<$core.int>? paymentAddr,
  }) {
    final $result = create();
    if (rHash != null) {
      $result.rHash = rHash;
    }
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
  AddInvoiceResponse._() : super();
  factory AddInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rHash', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'paymentRequest')
    ..a<$fixnum.Int64>(16, _omitFieldNames ? '' : 'addIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(17, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddInvoiceResponse clone() => AddInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddInvoiceResponse copyWith(void Function(AddInvoiceResponse) updates) => super.copyWith((message) => updates(message as AddInvoiceResponse)) as AddInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddInvoiceResponse create() => AddInvoiceResponse._();
  AddInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<AddInvoiceResponse> createRepeated() => $pb.PbList<AddInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static AddInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddInvoiceResponse>(create);
  static AddInvoiceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get rHash => $_getN(0);
  @$pb.TagNumber(1)
  set rHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearRHash() => $_clearField(1);

  ///
  /// A bare-bones invoice for a payment within the Lightning Network. With the
  /// details of the invoice, the sender has all the data necessary to send a
  /// payment to the recipient.
  @$pb.TagNumber(2)
  $core.String get paymentRequest => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentRequest($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentRequest() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentRequest() => $_clearField(2);

  ///
  /// The "add" index of this invoice. Each newly created invoice will increment
  /// this index making it monotonically increasing. Callers to the
  /// SubscribeInvoices call can use this to instantly get notified of all added
  /// invoices with an add_index greater than this one.
  @$pb.TagNumber(16)
  $fixnum.Int64 get addIndex => $_getI64(2);
  @$pb.TagNumber(16)
  set addIndex($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(16)
  $core.bool hasAddIndex() => $_has(2);
  @$pb.TagNumber(16)
  void clearAddIndex() => $_clearField(16);

  ///
  /// The payment address of the generated invoice. This is also called
  /// payment secret in specifications (e.g. BOLT 11). This value should be used
  /// in all payments for this invoice as we require it for end to end security.
  @$pb.TagNumber(17)
  $core.List<$core.int> get paymentAddr => $_getN(3);
  @$pb.TagNumber(17)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(17)
  $core.bool hasPaymentAddr() => $_has(3);
  @$pb.TagNumber(17)
  void clearPaymentAddr() => $_clearField(17);
}

class PaymentHash extends $pb.GeneratedMessage {
  factory PaymentHash({
  @$core.Deprecated('This field is deprecated.')
    $core.String? rHashStr,
    $core.List<$core.int>? rHash,
  }) {
    final $result = create();
    if (rHashStr != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.rHashStr = rHashStr;
    }
    if (rHash != null) {
      $result.rHash = rHash;
    }
    return $result;
  }
  PaymentHash._() : super();
  factory PaymentHash.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentHash.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentHash', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'rHashStr')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'rHash', $pb.PbFieldType.OY)
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

  ///
  /// The hex-encoded payment hash of the invoice to be looked up. The passed
  /// payment hash must be exactly 32 bytes, otherwise an error is returned.
  /// Deprecated now that the REST gateway supports base64 encoding of bytes
  /// fields.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.String get rHashStr => $_getSZ(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set rHashStr($core.String v) { $_setString(0, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasRHashStr() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearRHashStr() => $_clearField(1);

  ///
  /// The payment hash of the invoice to be looked up. When using REST, this field
  /// must be encoded as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get rHash => $_getN(1);
  @$pb.TagNumber(2)
  set rHash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearRHash() => $_clearField(2);
}

class ListInvoiceRequest extends $pb.GeneratedMessage {
  factory ListInvoiceRequest({
    $core.bool? pendingOnly,
    $fixnum.Int64? indexOffset,
    $fixnum.Int64? numMaxInvoices,
    $core.bool? reversed,
    $fixnum.Int64? creationDateStart,
    $fixnum.Int64? creationDateEnd,
  }) {
    final $result = create();
    if (pendingOnly != null) {
      $result.pendingOnly = pendingOnly;
    }
    if (indexOffset != null) {
      $result.indexOffset = indexOffset;
    }
    if (numMaxInvoices != null) {
      $result.numMaxInvoices = numMaxInvoices;
    }
    if (reversed != null) {
      $result.reversed = reversed;
    }
    if (creationDateStart != null) {
      $result.creationDateStart = creationDateStart;
    }
    if (creationDateEnd != null) {
      $result.creationDateEnd = creationDateEnd;
    }
    return $result;
  }
  ListInvoiceRequest._() : super();
  factory ListInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'pendingOnly')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'indexOffset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'numMaxInvoices', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(6, _omitFieldNames ? '' : 'reversed')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'creationDateStart', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'creationDateEnd', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListInvoiceRequest clone() => ListInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListInvoiceRequest copyWith(void Function(ListInvoiceRequest) updates) => super.copyWith((message) => updates(message as ListInvoiceRequest)) as ListInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInvoiceRequest create() => ListInvoiceRequest._();
  ListInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<ListInvoiceRequest> createRepeated() => $pb.PbList<ListInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static ListInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInvoiceRequest>(create);
  static ListInvoiceRequest? _defaultInstance;

  ///
  /// If set, only invoices that are not settled and not canceled will be returned
  /// in the response.
  @$pb.TagNumber(1)
  $core.bool get pendingOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set pendingOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPendingOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearPendingOnly() => $_clearField(1);

  ///
  /// The index of an invoice that will be used as either the start or end of a
  /// query to determine which invoices should be returned in the response.
  @$pb.TagNumber(4)
  $fixnum.Int64 get indexOffset => $_getI64(1);
  @$pb.TagNumber(4)
  set indexOffset($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(4)
  $core.bool hasIndexOffset() => $_has(1);
  @$pb.TagNumber(4)
  void clearIndexOffset() => $_clearField(4);

  /// The max number of invoices to return in the response to this query.
  @$pb.TagNumber(5)
  $fixnum.Int64 get numMaxInvoices => $_getI64(2);
  @$pb.TagNumber(5)
  set numMaxInvoices($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(5)
  $core.bool hasNumMaxInvoices() => $_has(2);
  @$pb.TagNumber(5)
  void clearNumMaxInvoices() => $_clearField(5);

  ///
  /// If set, the invoices returned will result from seeking backwards from the
  /// specified index offset. This can be used to paginate backwards.
  @$pb.TagNumber(6)
  $core.bool get reversed => $_getBF(3);
  @$pb.TagNumber(6)
  set reversed($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(6)
  $core.bool hasReversed() => $_has(3);
  @$pb.TagNumber(6)
  void clearReversed() => $_clearField(6);

  /// If set, returns all invoices with a creation date greater than or equal
  /// to it. Measured in seconds since the unix epoch.
  @$pb.TagNumber(7)
  $fixnum.Int64 get creationDateStart => $_getI64(4);
  @$pb.TagNumber(7)
  set creationDateStart($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreationDateStart() => $_has(4);
  @$pb.TagNumber(7)
  void clearCreationDateStart() => $_clearField(7);

  /// If set, returns all invoices with a creation date less than or equal to
  /// it. Measured in seconds since the unix epoch.
  @$pb.TagNumber(8)
  $fixnum.Int64 get creationDateEnd => $_getI64(5);
  @$pb.TagNumber(8)
  set creationDateEnd($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(8)
  $core.bool hasCreationDateEnd() => $_has(5);
  @$pb.TagNumber(8)
  void clearCreationDateEnd() => $_clearField(8);
}

class ListInvoiceResponse extends $pb.GeneratedMessage {
  factory ListInvoiceResponse({
    $core.Iterable<Invoice>? invoices,
    $fixnum.Int64? lastIndexOffset,
    $fixnum.Int64? firstIndexOffset,
  }) {
    final $result = create();
    if (invoices != null) {
      $result.invoices.addAll(invoices);
    }
    if (lastIndexOffset != null) {
      $result.lastIndexOffset = lastIndexOffset;
    }
    if (firstIndexOffset != null) {
      $result.firstIndexOffset = firstIndexOffset;
    }
    return $result;
  }
  ListInvoiceResponse._() : super();
  factory ListInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Invoice>(1, _omitFieldNames ? '' : 'invoices', $pb.PbFieldType.PM, subBuilder: Invoice.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'lastIndexOffset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'firstIndexOffset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListInvoiceResponse clone() => ListInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListInvoiceResponse copyWith(void Function(ListInvoiceResponse) updates) => super.copyWith((message) => updates(message as ListInvoiceResponse)) as ListInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListInvoiceResponse create() => ListInvoiceResponse._();
  ListInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<ListInvoiceResponse> createRepeated() => $pb.PbList<ListInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static ListInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListInvoiceResponse>(create);
  static ListInvoiceResponse? _defaultInstance;

  ///
  /// A list of invoices from the time slice of the time series specified in the
  /// request.
  @$pb.TagNumber(1)
  $pb.PbList<Invoice> get invoices => $_getList(0);

  ///
  /// The index of the last item in the set of returned invoices. This can be used
  /// to seek further, pagination style.
  @$pb.TagNumber(2)
  $fixnum.Int64 get lastIndexOffset => $_getI64(1);
  @$pb.TagNumber(2)
  set lastIndexOffset($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastIndexOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastIndexOffset() => $_clearField(2);

  ///
  /// The index of the last item in the set of returned invoices. This can be used
  /// to seek backwards, pagination style.
  @$pb.TagNumber(3)
  $fixnum.Int64 get firstIndexOffset => $_getI64(2);
  @$pb.TagNumber(3)
  set firstIndexOffset($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFirstIndexOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstIndexOffset() => $_clearField(3);
}

class InvoiceSubscription extends $pb.GeneratedMessage {
  factory InvoiceSubscription({
    $fixnum.Int64? addIndex,
    $fixnum.Int64? settleIndex,
  }) {
    final $result = create();
    if (addIndex != null) {
      $result.addIndex = addIndex;
    }
    if (settleIndex != null) {
      $result.settleIndex = settleIndex;
    }
    return $result;
  }
  InvoiceSubscription._() : super();
  factory InvoiceSubscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InvoiceSubscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InvoiceSubscription', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'addIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'settleIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InvoiceSubscription clone() => InvoiceSubscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InvoiceSubscription copyWith(void Function(InvoiceSubscription) updates) => super.copyWith((message) => updates(message as InvoiceSubscription)) as InvoiceSubscription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InvoiceSubscription create() => InvoiceSubscription._();
  InvoiceSubscription createEmptyInstance() => create();
  static $pb.PbList<InvoiceSubscription> createRepeated() => $pb.PbList<InvoiceSubscription>();
  @$core.pragma('dart2js:noInline')
  static InvoiceSubscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InvoiceSubscription>(create);
  static InvoiceSubscription? _defaultInstance;

  ///
  /// If specified (non-zero), then we'll first start by sending out
  /// notifications for all added indexes with an add_index greater than this
  /// value. This allows callers to catch up on any events they missed while they
  /// weren't connected to the streaming RPC.
  @$pb.TagNumber(1)
  $fixnum.Int64 get addIndex => $_getI64(0);
  @$pb.TagNumber(1)
  set addIndex($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddIndex() => $_clearField(1);

  ///
  /// If specified (non-zero), then we'll first start by sending out
  /// notifications for all settled indexes with an settle_index greater than
  /// this value. This allows callers to catch up on any events they missed while
  /// they weren't connected to the streaming RPC.
  @$pb.TagNumber(2)
  $fixnum.Int64 get settleIndex => $_getI64(1);
  @$pb.TagNumber(2)
  set settleIndex($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSettleIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearSettleIndex() => $_clearField(2);
}

class Payment extends $pb.GeneratedMessage {
  factory Payment({
    $core.String? paymentHash,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? value,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? creationDate,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? fee,
    $core.String? paymentPreimage,
    $fixnum.Int64? valueSat,
    $fixnum.Int64? valueMsat,
    $core.String? paymentRequest,
    Payment_PaymentStatus? status,
    $fixnum.Int64? feeSat,
    $fixnum.Int64? feeMsat,
    $fixnum.Int64? creationTimeNs,
    $core.Iterable<HTLCAttempt>? htlcs,
    $fixnum.Int64? paymentIndex,
    PaymentFailureReason? failureReason,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? firstHopCustomRecords,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (value != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.value = value;
    }
    if (creationDate != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.creationDate = creationDate;
    }
    if (fee != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.fee = fee;
    }
    if (paymentPreimage != null) {
      $result.paymentPreimage = paymentPreimage;
    }
    if (valueSat != null) {
      $result.valueSat = valueSat;
    }
    if (valueMsat != null) {
      $result.valueMsat = valueMsat;
    }
    if (paymentRequest != null) {
      $result.paymentRequest = paymentRequest;
    }
    if (status != null) {
      $result.status = status;
    }
    if (feeSat != null) {
      $result.feeSat = feeSat;
    }
    if (feeMsat != null) {
      $result.feeMsat = feeMsat;
    }
    if (creationTimeNs != null) {
      $result.creationTimeNs = creationTimeNs;
    }
    if (htlcs != null) {
      $result.htlcs.addAll(htlcs);
    }
    if (paymentIndex != null) {
      $result.paymentIndex = paymentIndex;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    if (firstHopCustomRecords != null) {
      $result.firstHopCustomRecords.addAll(firstHopCustomRecords);
    }
    return $result;
  }
  Payment._() : super();
  factory Payment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Payment', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentHash')
    ..aInt64(2, _omitFieldNames ? '' : 'value')
    ..aInt64(3, _omitFieldNames ? '' : 'creationDate')
    ..aInt64(5, _omitFieldNames ? '' : 'fee')
    ..aOS(6, _omitFieldNames ? '' : 'paymentPreimage')
    ..aInt64(7, _omitFieldNames ? '' : 'valueSat')
    ..aInt64(8, _omitFieldNames ? '' : 'valueMsat')
    ..aOS(9, _omitFieldNames ? '' : 'paymentRequest')
    ..e<Payment_PaymentStatus>(10, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Payment_PaymentStatus.UNKNOWN, valueOf: Payment_PaymentStatus.valueOf, enumValues: Payment_PaymentStatus.values)
    ..aInt64(11, _omitFieldNames ? '' : 'feeSat')
    ..aInt64(12, _omitFieldNames ? '' : 'feeMsat')
    ..aInt64(13, _omitFieldNames ? '' : 'creationTimeNs')
    ..pc<HTLCAttempt>(14, _omitFieldNames ? '' : 'htlcs', $pb.PbFieldType.PM, subBuilder: HTLCAttempt.create)
    ..a<$fixnum.Int64>(15, _omitFieldNames ? '' : 'paymentIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<PaymentFailureReason>(16, _omitFieldNames ? '' : 'failureReason', $pb.PbFieldType.OE, defaultOrMaker: PaymentFailureReason.FAILURE_REASON_NONE, valueOf: PaymentFailureReason.valueOf, enumValues: PaymentFailureReason.values)
    ..m<$fixnum.Int64, $core.List<$core.int>>(17, _omitFieldNames ? '' : 'firstHopCustomRecords', entryClassName: 'Payment.FirstHopCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('lnrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payment clone() => Payment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payment copyWith(void Function(Payment) updates) => super.copyWith((message) => updates(message as Payment)) as Payment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Payment create() => Payment._();
  Payment createEmptyInstance() => create();
  static $pb.PbList<Payment> createRepeated() => $pb.PbList<Payment>();
  @$core.pragma('dart2js:noInline')
  static Payment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payment>(create);
  static Payment? _defaultInstance;

  /// The payment hash
  @$pb.TagNumber(1)
  $core.String get paymentHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  /// Deprecated, use value_sat or value_msat.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $fixnum.Int64 get value => $_getI64(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set value($fixnum.Int64 v) { $_setInt64(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);

  /// Deprecated, use creation_time_ns
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $fixnum.Int64 get creationDate => $_getI64(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set creationDate($fixnum.Int64 v) { $_setInt64(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasCreationDate() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearCreationDate() => $_clearField(3);

  /// Deprecated, use fee_sat or fee_msat.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $fixnum.Int64 get fee => $_getI64(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  set fee($fixnum.Int64 v) { $_setInt64(3, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  $core.bool hasFee() => $_has(3);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(5)
  void clearFee() => $_clearField(5);

  /// The payment preimage
  @$pb.TagNumber(6)
  $core.String get paymentPreimage => $_getSZ(4);
  @$pb.TagNumber(6)
  set paymentPreimage($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentPreimage() => $_has(4);
  @$pb.TagNumber(6)
  void clearPaymentPreimage() => $_clearField(6);

  /// The value of the payment in satoshis
  @$pb.TagNumber(7)
  $fixnum.Int64 get valueSat => $_getI64(5);
  @$pb.TagNumber(7)
  set valueSat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasValueSat() => $_has(5);
  @$pb.TagNumber(7)
  void clearValueSat() => $_clearField(7);

  /// The value of the payment in milli-satoshis
  @$pb.TagNumber(8)
  $fixnum.Int64 get valueMsat => $_getI64(6);
  @$pb.TagNumber(8)
  set valueMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasValueMsat() => $_has(6);
  @$pb.TagNumber(8)
  void clearValueMsat() => $_clearField(8);

  /// The optional payment request being fulfilled.
  @$pb.TagNumber(9)
  $core.String get paymentRequest => $_getSZ(7);
  @$pb.TagNumber(9)
  set paymentRequest($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaymentRequest() => $_has(7);
  @$pb.TagNumber(9)
  void clearPaymentRequest() => $_clearField(9);

  /// The status of the payment.
  @$pb.TagNumber(10)
  Payment_PaymentStatus get status => $_getN(8);
  @$pb.TagNumber(10)
  set status(Payment_PaymentStatus v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasStatus() => $_has(8);
  @$pb.TagNumber(10)
  void clearStatus() => $_clearField(10);

  /// The fee paid for this payment in satoshis
  @$pb.TagNumber(11)
  $fixnum.Int64 get feeSat => $_getI64(9);
  @$pb.TagNumber(11)
  set feeSat($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasFeeSat() => $_has(9);
  @$pb.TagNumber(11)
  void clearFeeSat() => $_clearField(11);

  /// The fee paid for this payment in milli-satoshis
  @$pb.TagNumber(12)
  $fixnum.Int64 get feeMsat => $_getI64(10);
  @$pb.TagNumber(12)
  set feeMsat($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasFeeMsat() => $_has(10);
  @$pb.TagNumber(12)
  void clearFeeMsat() => $_clearField(12);

  /// The time in UNIX nanoseconds at which the payment was created.
  @$pb.TagNumber(13)
  $fixnum.Int64 get creationTimeNs => $_getI64(11);
  @$pb.TagNumber(13)
  set creationTimeNs($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(13)
  $core.bool hasCreationTimeNs() => $_has(11);
  @$pb.TagNumber(13)
  void clearCreationTimeNs() => $_clearField(13);

  /// The HTLCs made in attempt to settle the payment.
  @$pb.TagNumber(14)
  $pb.PbList<HTLCAttempt> get htlcs => $_getList(12);

  ///
  /// The creation index of this payment. Each payment can be uniquely identified
  /// by this index, which may not strictly increment by 1 for payments made in
  /// older versions of lnd.
  @$pb.TagNumber(15)
  $fixnum.Int64 get paymentIndex => $_getI64(13);
  @$pb.TagNumber(15)
  set paymentIndex($fixnum.Int64 v) { $_setInt64(13, v); }
  @$pb.TagNumber(15)
  $core.bool hasPaymentIndex() => $_has(13);
  @$pb.TagNumber(15)
  void clearPaymentIndex() => $_clearField(15);

  @$pb.TagNumber(16)
  PaymentFailureReason get failureReason => $_getN(14);
  @$pb.TagNumber(16)
  set failureReason(PaymentFailureReason v) { $_setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasFailureReason() => $_has(14);
  @$pb.TagNumber(16)
  void clearFailureReason() => $_clearField(16);

  ///
  /// The custom TLV records that were sent to the first hop as part of the HTLC
  /// wire message for this payment.
  @$pb.TagNumber(17)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get firstHopCustomRecords => $_getMap(15);
}

class HTLCAttempt extends $pb.GeneratedMessage {
  factory HTLCAttempt({
    HTLCAttempt_HTLCStatus? status,
    Route? route,
    $fixnum.Int64? attemptTimeNs,
    $fixnum.Int64? resolveTimeNs,
    Failure? failure,
    $core.List<$core.int>? preimage,
    $fixnum.Int64? attemptId,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    if (route != null) {
      $result.route = route;
    }
    if (attemptTimeNs != null) {
      $result.attemptTimeNs = attemptTimeNs;
    }
    if (resolveTimeNs != null) {
      $result.resolveTimeNs = resolveTimeNs;
    }
    if (failure != null) {
      $result.failure = failure;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (attemptId != null) {
      $result.attemptId = attemptId;
    }
    return $result;
  }
  HTLCAttempt._() : super();
  factory HTLCAttempt.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HTLCAttempt.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HTLCAttempt', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<HTLCAttempt_HTLCStatus>(1, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: HTLCAttempt_HTLCStatus.IN_FLIGHT, valueOf: HTLCAttempt_HTLCStatus.valueOf, enumValues: HTLCAttempt_HTLCStatus.values)
    ..aOM<Route>(2, _omitFieldNames ? '' : 'route', subBuilder: Route.create)
    ..aInt64(3, _omitFieldNames ? '' : 'attemptTimeNs')
    ..aInt64(4, _omitFieldNames ? '' : 'resolveTimeNs')
    ..aOM<Failure>(5, _omitFieldNames ? '' : 'failure', subBuilder: Failure.create)
    ..a<$core.List<$core.int>>(6, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'attemptId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HTLCAttempt clone() => HTLCAttempt()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HTLCAttempt copyWith(void Function(HTLCAttempt) updates) => super.copyWith((message) => updates(message as HTLCAttempt)) as HTLCAttempt;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HTLCAttempt create() => HTLCAttempt._();
  HTLCAttempt createEmptyInstance() => create();
  static $pb.PbList<HTLCAttempt> createRepeated() => $pb.PbList<HTLCAttempt>();
  @$core.pragma('dart2js:noInline')
  static HTLCAttempt getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HTLCAttempt>(create);
  static HTLCAttempt? _defaultInstance;

  /// The status of the HTLC.
  @$pb.TagNumber(1)
  HTLCAttempt_HTLCStatus get status => $_getN(0);
  @$pb.TagNumber(1)
  set status(HTLCAttempt_HTLCStatus v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);

  /// The route taken by this HTLC.
  @$pb.TagNumber(2)
  Route get route => $_getN(1);
  @$pb.TagNumber(2)
  set route(Route v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoute() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoute() => $_clearField(2);
  @$pb.TagNumber(2)
  Route ensureRoute() => $_ensure(1);

  /// The time in UNIX nanoseconds at which this HTLC was sent.
  @$pb.TagNumber(3)
  $fixnum.Int64 get attemptTimeNs => $_getI64(2);
  @$pb.TagNumber(3)
  set attemptTimeNs($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAttemptTimeNs() => $_has(2);
  @$pb.TagNumber(3)
  void clearAttemptTimeNs() => $_clearField(3);

  ///
  /// The time in UNIX nanoseconds at which this HTLC was settled or failed.
  /// This value will not be set if the HTLC is still IN_FLIGHT.
  @$pb.TagNumber(4)
  $fixnum.Int64 get resolveTimeNs => $_getI64(3);
  @$pb.TagNumber(4)
  set resolveTimeNs($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasResolveTimeNs() => $_has(3);
  @$pb.TagNumber(4)
  void clearResolveTimeNs() => $_clearField(4);

  /// Detailed htlc failure info.
  @$pb.TagNumber(5)
  Failure get failure => $_getN(4);
  @$pb.TagNumber(5)
  set failure(Failure v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFailure() => $_has(4);
  @$pb.TagNumber(5)
  void clearFailure() => $_clearField(5);
  @$pb.TagNumber(5)
  Failure ensureFailure() => $_ensure(4);

  /// The preimage that was used to settle the HTLC.
  @$pb.TagNumber(6)
  $core.List<$core.int> get preimage => $_getN(5);
  @$pb.TagNumber(6)
  set preimage($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPreimage() => $_has(5);
  @$pb.TagNumber(6)
  void clearPreimage() => $_clearField(6);

  /// The unique ID that is used for this attempt.
  @$pb.TagNumber(7)
  $fixnum.Int64 get attemptId => $_getI64(6);
  @$pb.TagNumber(7)
  set attemptId($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAttemptId() => $_has(6);
  @$pb.TagNumber(7)
  void clearAttemptId() => $_clearField(7);
}

class ListPaymentsRequest extends $pb.GeneratedMessage {
  factory ListPaymentsRequest({
    $core.bool? includeIncomplete,
    $fixnum.Int64? indexOffset,
    $fixnum.Int64? maxPayments,
    $core.bool? reversed,
    $core.bool? countTotalPayments,
    $fixnum.Int64? creationDateStart,
    $fixnum.Int64? creationDateEnd,
  }) {
    final $result = create();
    if (includeIncomplete != null) {
      $result.includeIncomplete = includeIncomplete;
    }
    if (indexOffset != null) {
      $result.indexOffset = indexOffset;
    }
    if (maxPayments != null) {
      $result.maxPayments = maxPayments;
    }
    if (reversed != null) {
      $result.reversed = reversed;
    }
    if (countTotalPayments != null) {
      $result.countTotalPayments = countTotalPayments;
    }
    if (creationDateStart != null) {
      $result.creationDateStart = creationDateStart;
    }
    if (creationDateEnd != null) {
      $result.creationDateEnd = creationDateEnd;
    }
    return $result;
  }
  ListPaymentsRequest._() : super();
  factory ListPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'includeIncomplete')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'indexOffset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'maxPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(4, _omitFieldNames ? '' : 'reversed')
    ..aOB(5, _omitFieldNames ? '' : 'countTotalPayments')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'creationDateStart', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'creationDateEnd', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaymentsRequest clone() => ListPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaymentsRequest copyWith(void Function(ListPaymentsRequest) updates) => super.copyWith((message) => updates(message as ListPaymentsRequest)) as ListPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaymentsRequest create() => ListPaymentsRequest._();
  ListPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPaymentsRequest> createRepeated() => $pb.PbList<ListPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPaymentsRequest>(create);
  static ListPaymentsRequest? _defaultInstance;

  ///
  /// If true, then return payments that have not yet fully completed. This means
  /// that pending payments, as well as failed payments will show up if this
  /// field is set to true. This flag doesn't change the meaning of the indices,
  /// which are tied to individual payments.
  @$pb.TagNumber(1)
  $core.bool get includeIncomplete => $_getBF(0);
  @$pb.TagNumber(1)
  set includeIncomplete($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncludeIncomplete() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncludeIncomplete() => $_clearField(1);

  ///
  /// The index of a payment that will be used as either the start or end of a
  /// query to determine which payments should be returned in the response. The
  /// index_offset is exclusive. In the case of a zero index_offset, the query
  /// will start with the oldest payment when paginating forwards, or will end
  /// with the most recent payment when paginating backwards.
  @$pb.TagNumber(2)
  $fixnum.Int64 get indexOffset => $_getI64(1);
  @$pb.TagNumber(2)
  set indexOffset($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIndexOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndexOffset() => $_clearField(2);

  /// The maximal number of payments returned in the response to this query.
  @$pb.TagNumber(3)
  $fixnum.Int64 get maxPayments => $_getI64(2);
  @$pb.TagNumber(3)
  set maxPayments($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxPayments() => $_clearField(3);

  ///
  /// If set, the payments returned will result from seeking backwards from the
  /// specified index offset. This can be used to paginate backwards. The order
  /// of the returned payments is always oldest first (ascending index order).
  @$pb.TagNumber(4)
  $core.bool get reversed => $_getBF(3);
  @$pb.TagNumber(4)
  set reversed($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasReversed() => $_has(3);
  @$pb.TagNumber(4)
  void clearReversed() => $_clearField(4);

  ///
  /// If set, all payments (complete and incomplete, independent of the
  /// max_payments parameter) will be counted. Note that setting this to true will
  /// increase the run time of the call significantly on systems that have a lot
  /// of payments, as all of them have to be iterated through to be counted.
  @$pb.TagNumber(5)
  $core.bool get countTotalPayments => $_getBF(4);
  @$pb.TagNumber(5)
  set countTotalPayments($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCountTotalPayments() => $_has(4);
  @$pb.TagNumber(5)
  void clearCountTotalPayments() => $_clearField(5);

  /// If set, returns all payments with a creation date greater than or equal
  /// to it. Measured in seconds since the unix epoch.
  @$pb.TagNumber(6)
  $fixnum.Int64 get creationDateStart => $_getI64(5);
  @$pb.TagNumber(6)
  set creationDateStart($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasCreationDateStart() => $_has(5);
  @$pb.TagNumber(6)
  void clearCreationDateStart() => $_clearField(6);

  /// If set, returns all payments with a creation date less than or equal to
  /// it. Measured in seconds since the unix epoch.
  @$pb.TagNumber(7)
  $fixnum.Int64 get creationDateEnd => $_getI64(6);
  @$pb.TagNumber(7)
  set creationDateEnd($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasCreationDateEnd() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreationDateEnd() => $_clearField(7);
}

class ListPaymentsResponse extends $pb.GeneratedMessage {
  factory ListPaymentsResponse({
    $core.Iterable<Payment>? payments,
    $fixnum.Int64? firstIndexOffset,
    $fixnum.Int64? lastIndexOffset,
    $fixnum.Int64? totalNumPayments,
  }) {
    final $result = create();
    if (payments != null) {
      $result.payments.addAll(payments);
    }
    if (firstIndexOffset != null) {
      $result.firstIndexOffset = firstIndexOffset;
    }
    if (lastIndexOffset != null) {
      $result.lastIndexOffset = lastIndexOffset;
    }
    if (totalNumPayments != null) {
      $result.totalNumPayments = totalNumPayments;
    }
    return $result;
  }
  ListPaymentsResponse._() : super();
  factory ListPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<Payment>(1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: Payment.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'firstIndexOffset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'lastIndexOffset', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'totalNumPayments', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaymentsResponse clone() => ListPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaymentsResponse copyWith(void Function(ListPaymentsResponse) updates) => super.copyWith((message) => updates(message as ListPaymentsResponse)) as ListPaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaymentsResponse create() => ListPaymentsResponse._();
  ListPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPaymentsResponse> createRepeated() => $pb.PbList<ListPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPaymentsResponse>(create);
  static ListPaymentsResponse? _defaultInstance;

  /// The list of payments
  @$pb.TagNumber(1)
  $pb.PbList<Payment> get payments => $_getList(0);

  ///
  /// The index of the first item in the set of returned payments. This can be
  /// used as the index_offset to continue seeking backwards in the next request.
  @$pb.TagNumber(2)
  $fixnum.Int64 get firstIndexOffset => $_getI64(1);
  @$pb.TagNumber(2)
  set firstIndexOffset($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFirstIndexOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstIndexOffset() => $_clearField(2);

  ///
  /// The index of the last item in the set of returned payments. This can be used
  /// as the index_offset to continue seeking forwards in the next request.
  @$pb.TagNumber(3)
  $fixnum.Int64 get lastIndexOffset => $_getI64(2);
  @$pb.TagNumber(3)
  set lastIndexOffset($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLastIndexOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastIndexOffset() => $_clearField(3);

  ///
  /// Will only be set if count_total_payments in the request was set. Represents
  /// the total number of payments (complete and incomplete, independent of the
  /// number of payments requested in the query) currently present in the payments
  /// database.
  @$pb.TagNumber(4)
  $fixnum.Int64 get totalNumPayments => $_getI64(3);
  @$pb.TagNumber(4)
  set totalNumPayments($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalNumPayments() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalNumPayments() => $_clearField(4);
}

class DeletePaymentRequest extends $pb.GeneratedMessage {
  factory DeletePaymentRequest({
    $core.List<$core.int>? paymentHash,
    $core.bool? failedHtlcsOnly,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (failedHtlcsOnly != null) {
      $result.failedHtlcsOnly = failedHtlcsOnly;
    }
    return $result;
  }
  DeletePaymentRequest._() : super();
  factory DeletePaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeletePaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'failedHtlcsOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletePaymentRequest clone() => DeletePaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletePaymentRequest copyWith(void Function(DeletePaymentRequest) updates) => super.copyWith((message) => updates(message as DeletePaymentRequest)) as DeletePaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePaymentRequest create() => DeletePaymentRequest._();
  DeletePaymentRequest createEmptyInstance() => create();
  static $pb.PbList<DeletePaymentRequest> createRepeated() => $pb.PbList<DeletePaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static DeletePaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeletePaymentRequest>(create);
  static DeletePaymentRequest? _defaultInstance;

  /// Payment hash to delete.
  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  ///
  /// Only delete failed HTLCs from the payment, not the payment itself.
  @$pb.TagNumber(2)
  $core.bool get failedHtlcsOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set failedHtlcsOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFailedHtlcsOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailedHtlcsOnly() => $_clearField(2);
}

class DeleteAllPaymentsRequest extends $pb.GeneratedMessage {
  factory DeleteAllPaymentsRequest({
    $core.bool? failedPaymentsOnly,
    $core.bool? failedHtlcsOnly,
    $core.bool? allPayments,
  }) {
    final $result = create();
    if (failedPaymentsOnly != null) {
      $result.failedPaymentsOnly = failedPaymentsOnly;
    }
    if (failedHtlcsOnly != null) {
      $result.failedHtlcsOnly = failedHtlcsOnly;
    }
    if (allPayments != null) {
      $result.allPayments = allPayments;
    }
    return $result;
  }
  DeleteAllPaymentsRequest._() : super();
  factory DeleteAllPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAllPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAllPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'failedPaymentsOnly')
    ..aOB(2, _omitFieldNames ? '' : 'failedHtlcsOnly')
    ..aOB(3, _omitFieldNames ? '' : 'allPayments')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAllPaymentsRequest clone() => DeleteAllPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAllPaymentsRequest copyWith(void Function(DeleteAllPaymentsRequest) updates) => super.copyWith((message) => updates(message as DeleteAllPaymentsRequest)) as DeleteAllPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAllPaymentsRequest create() => DeleteAllPaymentsRequest._();
  DeleteAllPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAllPaymentsRequest> createRepeated() => $pb.PbList<DeleteAllPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAllPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAllPaymentsRequest>(create);
  static DeleteAllPaymentsRequest? _defaultInstance;

  /// Only delete failed payments.
  @$pb.TagNumber(1)
  $core.bool get failedPaymentsOnly => $_getBF(0);
  @$pb.TagNumber(1)
  set failedPaymentsOnly($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFailedPaymentsOnly() => $_has(0);
  @$pb.TagNumber(1)
  void clearFailedPaymentsOnly() => $_clearField(1);

  ///
  /// Only delete failed HTLCs from payments, not the payment itself.
  @$pb.TagNumber(2)
  $core.bool get failedHtlcsOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set failedHtlcsOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFailedHtlcsOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailedHtlcsOnly() => $_clearField(2);

  /// Delete all payments. NOTE: Using this option requires careful
  /// consideration as it is a destructive operation.
  @$pb.TagNumber(3)
  $core.bool get allPayments => $_getBF(2);
  @$pb.TagNumber(3)
  set allPayments($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAllPayments() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllPayments() => $_clearField(3);
}

class DeletePaymentResponse extends $pb.GeneratedMessage {
  factory DeletePaymentResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  DeletePaymentResponse._() : super();
  factory DeletePaymentResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeletePaymentResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeletePaymentResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeletePaymentResponse clone() => DeletePaymentResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeletePaymentResponse copyWith(void Function(DeletePaymentResponse) updates) => super.copyWith((message) => updates(message as DeletePaymentResponse)) as DeletePaymentResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeletePaymentResponse create() => DeletePaymentResponse._();
  DeletePaymentResponse createEmptyInstance() => create();
  static $pb.PbList<DeletePaymentResponse> createRepeated() => $pb.PbList<DeletePaymentResponse>();
  @$core.pragma('dart2js:noInline')
  static DeletePaymentResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeletePaymentResponse>(create);
  static DeletePaymentResponse? _defaultInstance;

  /// The status of the delete operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class DeleteAllPaymentsResponse extends $pb.GeneratedMessage {
  factory DeleteAllPaymentsResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  DeleteAllPaymentsResponse._() : super();
  factory DeleteAllPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAllPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAllPaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAllPaymentsResponse clone() => DeleteAllPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAllPaymentsResponse copyWith(void Function(DeleteAllPaymentsResponse) updates) => super.copyWith((message) => updates(message as DeleteAllPaymentsResponse)) as DeleteAllPaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAllPaymentsResponse create() => DeleteAllPaymentsResponse._();
  DeleteAllPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAllPaymentsResponse> createRepeated() => $pb.PbList<DeleteAllPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAllPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAllPaymentsResponse>(create);
  static DeleteAllPaymentsResponse? _defaultInstance;

  /// The status of the delete operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class AbandonChannelRequest extends $pb.GeneratedMessage {
  factory AbandonChannelRequest({
    ChannelPoint? channelPoint,
    $core.bool? pendingFundingShimOnly,
    $core.bool? iKnowWhatIAmDoing,
  }) {
    final $result = create();
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    if (pendingFundingShimOnly != null) {
      $result.pendingFundingShimOnly = pendingFundingShimOnly;
    }
    if (iKnowWhatIAmDoing != null) {
      $result.iKnowWhatIAmDoing = iKnowWhatIAmDoing;
    }
    return $result;
  }
  AbandonChannelRequest._() : super();
  factory AbandonChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AbandonChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AbandonChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<ChannelPoint>(1, _omitFieldNames ? '' : 'channelPoint', subBuilder: ChannelPoint.create)
    ..aOB(2, _omitFieldNames ? '' : 'pendingFundingShimOnly')
    ..aOB(3, _omitFieldNames ? '' : 'iKnowWhatIAmDoing')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AbandonChannelRequest clone() => AbandonChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AbandonChannelRequest copyWith(void Function(AbandonChannelRequest) updates) => super.copyWith((message) => updates(message as AbandonChannelRequest)) as AbandonChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AbandonChannelRequest create() => AbandonChannelRequest._();
  AbandonChannelRequest createEmptyInstance() => create();
  static $pb.PbList<AbandonChannelRequest> createRepeated() => $pb.PbList<AbandonChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static AbandonChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AbandonChannelRequest>(create);
  static AbandonChannelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  ChannelPoint get channelPoint => $_getN(0);
  @$pb.TagNumber(1)
  set channelPoint(ChannelPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelPoint() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelPoint ensureChannelPoint() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get pendingFundingShimOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set pendingFundingShimOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPendingFundingShimOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearPendingFundingShimOnly() => $_clearField(2);

  ///
  /// Override the requirement for being in dev mode by setting this to true and
  /// confirming the user knows what they are doing and this is a potential foot
  /// gun to lose funds if used on active channels.
  @$pb.TagNumber(3)
  $core.bool get iKnowWhatIAmDoing => $_getBF(2);
  @$pb.TagNumber(3)
  set iKnowWhatIAmDoing($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIKnowWhatIAmDoing() => $_has(2);
  @$pb.TagNumber(3)
  void clearIKnowWhatIAmDoing() => $_clearField(3);
}

class AbandonChannelResponse extends $pb.GeneratedMessage {
  factory AbandonChannelResponse({
    $core.String? status,
  }) {
    final $result = create();
    if (status != null) {
      $result.status = status;
    }
    return $result;
  }
  AbandonChannelResponse._() : super();
  factory AbandonChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AbandonChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AbandonChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AbandonChannelResponse clone() => AbandonChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AbandonChannelResponse copyWith(void Function(AbandonChannelResponse) updates) => super.copyWith((message) => updates(message as AbandonChannelResponse)) as AbandonChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AbandonChannelResponse create() => AbandonChannelResponse._();
  AbandonChannelResponse createEmptyInstance() => create();
  static $pb.PbList<AbandonChannelResponse> createRepeated() => $pb.PbList<AbandonChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static AbandonChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AbandonChannelResponse>(create);
  static AbandonChannelResponse? _defaultInstance;

  /// The status of the abandon operation.
  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => $_clearField(1);
}

class DebugLevelRequest extends $pb.GeneratedMessage {
  factory DebugLevelRequest({
    $core.bool? show,
    $core.String? levelSpec,
  }) {
    final $result = create();
    if (show != null) {
      $result.show = show;
    }
    if (levelSpec != null) {
      $result.levelSpec = levelSpec;
    }
    return $result;
  }
  DebugLevelRequest._() : super();
  factory DebugLevelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DebugLevelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DebugLevelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'show')
    ..aOS(2, _omitFieldNames ? '' : 'levelSpec')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DebugLevelRequest clone() => DebugLevelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DebugLevelRequest copyWith(void Function(DebugLevelRequest) updates) => super.copyWith((message) => updates(message as DebugLevelRequest)) as DebugLevelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebugLevelRequest create() => DebugLevelRequest._();
  DebugLevelRequest createEmptyInstance() => create();
  static $pb.PbList<DebugLevelRequest> createRepeated() => $pb.PbList<DebugLevelRequest>();
  @$core.pragma('dart2js:noInline')
  static DebugLevelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebugLevelRequest>(create);
  static DebugLevelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get show => $_getBF(0);
  @$pb.TagNumber(1)
  set show($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShow() => $_has(0);
  @$pb.TagNumber(1)
  void clearShow() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get levelSpec => $_getSZ(1);
  @$pb.TagNumber(2)
  set levelSpec($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLevelSpec() => $_has(1);
  @$pb.TagNumber(2)
  void clearLevelSpec() => $_clearField(2);
}

class DebugLevelResponse extends $pb.GeneratedMessage {
  factory DebugLevelResponse({
    $core.String? subSystems,
  }) {
    final $result = create();
    if (subSystems != null) {
      $result.subSystems = subSystems;
    }
    return $result;
  }
  DebugLevelResponse._() : super();
  factory DebugLevelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DebugLevelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DebugLevelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'subSystems')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DebugLevelResponse clone() => DebugLevelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DebugLevelResponse copyWith(void Function(DebugLevelResponse) updates) => super.copyWith((message) => updates(message as DebugLevelResponse)) as DebugLevelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DebugLevelResponse create() => DebugLevelResponse._();
  DebugLevelResponse createEmptyInstance() => create();
  static $pb.PbList<DebugLevelResponse> createRepeated() => $pb.PbList<DebugLevelResponse>();
  @$core.pragma('dart2js:noInline')
  static DebugLevelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DebugLevelResponse>(create);
  static DebugLevelResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get subSystems => $_getSZ(0);
  @$pb.TagNumber(1)
  set subSystems($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSubSystems() => $_has(0);
  @$pb.TagNumber(1)
  void clearSubSystems() => $_clearField(1);
}

class PayReqString extends $pb.GeneratedMessage {
  factory PayReqString({
    $core.String? payReq,
  }) {
    final $result = create();
    if (payReq != null) {
      $result.payReq = payReq;
    }
    return $result;
  }
  PayReqString._() : super();
  factory PayReqString.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayReqString.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayReqString', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'payReq')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayReqString clone() => PayReqString()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayReqString copyWith(void Function(PayReqString) updates) => super.copyWith((message) => updates(message as PayReqString)) as PayReqString;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayReqString create() => PayReqString._();
  PayReqString createEmptyInstance() => create();
  static $pb.PbList<PayReqString> createRepeated() => $pb.PbList<PayReqString>();
  @$core.pragma('dart2js:noInline')
  static PayReqString getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayReqString>(create);
  static PayReqString? _defaultInstance;

  /// The payment request string to be decoded
  @$pb.TagNumber(1)
  $core.String get payReq => $_getSZ(0);
  @$pb.TagNumber(1)
  set payReq($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayReq() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayReq() => $_clearField(1);
}

class PayReq extends $pb.GeneratedMessage {
  factory PayReq({
    $core.String? destination,
    $core.String? paymentHash,
    $fixnum.Int64? numSatoshis,
    $fixnum.Int64? timestamp,
    $fixnum.Int64? expiry,
    $core.String? description,
    $core.String? descriptionHash,
    $core.String? fallbackAddr,
    $fixnum.Int64? cltvExpiry,
    $core.Iterable<RouteHint>? routeHints,
    $core.List<$core.int>? paymentAddr,
    $fixnum.Int64? numMsat,
    $pb.PbMap<$core.int, Feature>? features,
    $core.Iterable<BlindedPaymentPath>? blindedPaths,
  }) {
    final $result = create();
    if (destination != null) {
      $result.destination = destination;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (numSatoshis != null) {
      $result.numSatoshis = numSatoshis;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (expiry != null) {
      $result.expiry = expiry;
    }
    if (description != null) {
      $result.description = description;
    }
    if (descriptionHash != null) {
      $result.descriptionHash = descriptionHash;
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
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    if (numMsat != null) {
      $result.numMsat = numMsat;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (blindedPaths != null) {
      $result.blindedPaths.addAll(blindedPaths);
    }
    return $result;
  }
  PayReq._() : super();
  factory PayReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destination')
    ..aOS(2, _omitFieldNames ? '' : 'paymentHash')
    ..aInt64(3, _omitFieldNames ? '' : 'numSatoshis')
    ..aInt64(4, _omitFieldNames ? '' : 'timestamp')
    ..aInt64(5, _omitFieldNames ? '' : 'expiry')
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'descriptionHash')
    ..aOS(8, _omitFieldNames ? '' : 'fallbackAddr')
    ..aInt64(9, _omitFieldNames ? '' : 'cltvExpiry')
    ..pc<RouteHint>(10, _omitFieldNames ? '' : 'routeHints', $pb.PbFieldType.PM, subBuilder: RouteHint.create)
    ..a<$core.List<$core.int>>(11, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..aInt64(12, _omitFieldNames ? '' : 'numMsat')
    ..m<$core.int, Feature>(13, _omitFieldNames ? '' : 'features', entryClassName: 'PayReq.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..pc<BlindedPaymentPath>(14, _omitFieldNames ? '' : 'blindedPaths', $pb.PbFieldType.PM, subBuilder: BlindedPaymentPath.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayReq clone() => PayReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayReq copyWith(void Function(PayReq) updates) => super.copyWith((message) => updates(message as PayReq)) as PayReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayReq create() => PayReq._();
  PayReq createEmptyInstance() => create();
  static $pb.PbList<PayReq> createRepeated() => $pb.PbList<PayReq>();
  @$core.pragma('dart2js:noInline')
  static PayReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayReq>(create);
  static PayReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get destination => $_getSZ(0);
  @$pb.TagNumber(1)
  set destination($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDestination() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestination() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get paymentHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get numSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set numSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNumSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearNumSatoshis() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiry => $_getI64(4);
  @$pb.TagNumber(5)
  set expiry($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiry() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiry() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get descriptionHash => $_getSZ(6);
  @$pb.TagNumber(7)
  set descriptionHash($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDescriptionHash() => $_has(6);
  @$pb.TagNumber(7)
  void clearDescriptionHash() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get fallbackAddr => $_getSZ(7);
  @$pb.TagNumber(8)
  set fallbackAddr($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFallbackAddr() => $_has(7);
  @$pb.TagNumber(8)
  void clearFallbackAddr() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get cltvExpiry => $_getI64(8);
  @$pb.TagNumber(9)
  set cltvExpiry($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCltvExpiry() => $_has(8);
  @$pb.TagNumber(9)
  void clearCltvExpiry() => $_clearField(9);

  @$pb.TagNumber(10)
  $pb.PbList<RouteHint> get routeHints => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<$core.int> get paymentAddr => $_getN(10);
  @$pb.TagNumber(11)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasPaymentAddr() => $_has(10);
  @$pb.TagNumber(11)
  void clearPaymentAddr() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get numMsat => $_getI64(11);
  @$pb.TagNumber(12)
  set numMsat($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasNumMsat() => $_has(11);
  @$pb.TagNumber(12)
  void clearNumMsat() => $_clearField(12);

  @$pb.TagNumber(13)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(12);

  @$pb.TagNumber(14)
  $pb.PbList<BlindedPaymentPath> get blindedPaths => $_getList(13);
}

class Feature extends $pb.GeneratedMessage {
  factory Feature({
    $core.String? name,
    $core.bool? isRequired,
    $core.bool? isKnown,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (isRequired != null) {
      $result.isRequired = isRequired;
    }
    if (isKnown != null) {
      $result.isKnown = isKnown;
    }
    return $result;
  }
  Feature._() : super();
  factory Feature.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Feature.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Feature', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(2, _omitFieldNames ? '' : 'name')
    ..aOB(3, _omitFieldNames ? '' : 'isRequired')
    ..aOB(4, _omitFieldNames ? '' : 'isKnown')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Feature clone() => Feature()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Feature copyWith(void Function(Feature) updates) => super.copyWith((message) => updates(message as Feature)) as Feature;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(2)
  void clearName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isRequired => $_getBF(1);
  @$pb.TagNumber(3)
  set isRequired($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsRequired() => $_has(1);
  @$pb.TagNumber(3)
  void clearIsRequired() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get isKnown => $_getBF(2);
  @$pb.TagNumber(4)
  set isKnown($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsKnown() => $_has(2);
  @$pb.TagNumber(4)
  void clearIsKnown() => $_clearField(4);
}

class FeeReportRequest extends $pb.GeneratedMessage {
  factory FeeReportRequest() => create();
  FeeReportRequest._() : super();
  factory FeeReportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeeReportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeeReportRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeeReportRequest clone() => FeeReportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeeReportRequest copyWith(void Function(FeeReportRequest) updates) => super.copyWith((message) => updates(message as FeeReportRequest)) as FeeReportRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeReportRequest create() => FeeReportRequest._();
  FeeReportRequest createEmptyInstance() => create();
  static $pb.PbList<FeeReportRequest> createRepeated() => $pb.PbList<FeeReportRequest>();
  @$core.pragma('dart2js:noInline')
  static FeeReportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeeReportRequest>(create);
  static FeeReportRequest? _defaultInstance;
}

class ChannelFeeReport extends $pb.GeneratedMessage {
  factory ChannelFeeReport({
    $core.String? channelPoint,
    $fixnum.Int64? baseFeeMsat,
    $fixnum.Int64? feePerMil,
    $core.double? feeRate,
    $fixnum.Int64? chanId,
    $core.int? inboundBaseFeeMsat,
    $core.int? inboundFeePerMil,
  }) {
    final $result = create();
    if (channelPoint != null) {
      $result.channelPoint = channelPoint;
    }
    if (baseFeeMsat != null) {
      $result.baseFeeMsat = baseFeeMsat;
    }
    if (feePerMil != null) {
      $result.feePerMil = feePerMil;
    }
    if (feeRate != null) {
      $result.feeRate = feeRate;
    }
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (inboundBaseFeeMsat != null) {
      $result.inboundBaseFeeMsat = inboundBaseFeeMsat;
    }
    if (inboundFeePerMil != null) {
      $result.inboundFeePerMil = inboundFeePerMil;
    }
    return $result;
  }
  ChannelFeeReport._() : super();
  factory ChannelFeeReport.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelFeeReport.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelFeeReport', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelPoint')
    ..aInt64(2, _omitFieldNames ? '' : 'baseFeeMsat')
    ..aInt64(3, _omitFieldNames ? '' : 'feePerMil')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'feeRate', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'inboundBaseFeeMsat', $pb.PbFieldType.O3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'inboundFeePerMil', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelFeeReport clone() => ChannelFeeReport()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelFeeReport copyWith(void Function(ChannelFeeReport) updates) => super.copyWith((message) => updates(message as ChannelFeeReport)) as ChannelFeeReport;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelFeeReport create() => ChannelFeeReport._();
  ChannelFeeReport createEmptyInstance() => create();
  static $pb.PbList<ChannelFeeReport> createRepeated() => $pb.PbList<ChannelFeeReport>();
  @$core.pragma('dart2js:noInline')
  static ChannelFeeReport getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelFeeReport>(create);
  static ChannelFeeReport? _defaultInstance;

  /// The channel that this fee report belongs to.
  @$pb.TagNumber(1)
  $core.String get channelPoint => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelPoint($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelPoint() => $_clearField(1);

  /// The base fee charged regardless of the number of milli-satoshis sent.
  @$pb.TagNumber(2)
  $fixnum.Int64 get baseFeeMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set baseFeeMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBaseFeeMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearBaseFeeMsat() => $_clearField(2);

  /// The amount charged per milli-satoshis transferred expressed in
  /// millionths of a satoshi.
  @$pb.TagNumber(3)
  $fixnum.Int64 get feePerMil => $_getI64(2);
  @$pb.TagNumber(3)
  set feePerMil($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeePerMil() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeePerMil() => $_clearField(3);

  /// The effective fee rate in milli-satoshis. Computed by dividing the
  /// fee_per_mil value by 1 million.
  @$pb.TagNumber(4)
  $core.double get feeRate => $_getN(3);
  @$pb.TagNumber(4)
  set feeRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeRate() => $_clearField(4);

  /// The short channel id that this fee report belongs to.
  @$pb.TagNumber(5)
  $fixnum.Int64 get chanId => $_getI64(4);
  @$pb.TagNumber(5)
  set chanId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChanId() => $_has(4);
  @$pb.TagNumber(5)
  void clearChanId() => $_clearField(5);

  /// The base fee charged regardless of the number of milli-satoshis sent.
  @$pb.TagNumber(6)
  $core.int get inboundBaseFeeMsat => $_getIZ(5);
  @$pb.TagNumber(6)
  set inboundBaseFeeMsat($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInboundBaseFeeMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearInboundBaseFeeMsat() => $_clearField(6);

  /// The amount charged per milli-satoshis transferred expressed in
  /// millionths of a satoshi.
  @$pb.TagNumber(7)
  $core.int get inboundFeePerMil => $_getIZ(6);
  @$pb.TagNumber(7)
  set inboundFeePerMil($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInboundFeePerMil() => $_has(6);
  @$pb.TagNumber(7)
  void clearInboundFeePerMil() => $_clearField(7);
}

class FeeReportResponse extends $pb.GeneratedMessage {
  factory FeeReportResponse({
    $core.Iterable<ChannelFeeReport>? channelFees,
    $fixnum.Int64? dayFeeSum,
    $fixnum.Int64? weekFeeSum,
    $fixnum.Int64? monthFeeSum,
  }) {
    final $result = create();
    if (channelFees != null) {
      $result.channelFees.addAll(channelFees);
    }
    if (dayFeeSum != null) {
      $result.dayFeeSum = dayFeeSum;
    }
    if (weekFeeSum != null) {
      $result.weekFeeSum = weekFeeSum;
    }
    if (monthFeeSum != null) {
      $result.monthFeeSum = monthFeeSum;
    }
    return $result;
  }
  FeeReportResponse._() : super();
  factory FeeReportResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeeReportResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeeReportResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<ChannelFeeReport>(1, _omitFieldNames ? '' : 'channelFees', $pb.PbFieldType.PM, subBuilder: ChannelFeeReport.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'dayFeeSum', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'weekFeeSum', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'monthFeeSum', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeeReportResponse clone() => FeeReportResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeeReportResponse copyWith(void Function(FeeReportResponse) updates) => super.copyWith((message) => updates(message as FeeReportResponse)) as FeeReportResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeeReportResponse create() => FeeReportResponse._();
  FeeReportResponse createEmptyInstance() => create();
  static $pb.PbList<FeeReportResponse> createRepeated() => $pb.PbList<FeeReportResponse>();
  @$core.pragma('dart2js:noInline')
  static FeeReportResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeeReportResponse>(create);
  static FeeReportResponse? _defaultInstance;

  /// An array of channel fee reports which describes the current fee schedule
  /// for each channel.
  @$pb.TagNumber(1)
  $pb.PbList<ChannelFeeReport> get channelFees => $_getList(0);

  /// The total amount of fee revenue (in satoshis) the switch has collected
  /// over the past 24 hrs.
  @$pb.TagNumber(2)
  $fixnum.Int64 get dayFeeSum => $_getI64(1);
  @$pb.TagNumber(2)
  set dayFeeSum($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDayFeeSum() => $_has(1);
  @$pb.TagNumber(2)
  void clearDayFeeSum() => $_clearField(2);

  /// The total amount of fee revenue (in satoshis) the switch has collected
  /// over the past 1 week.
  @$pb.TagNumber(3)
  $fixnum.Int64 get weekFeeSum => $_getI64(2);
  @$pb.TagNumber(3)
  set weekFeeSum($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWeekFeeSum() => $_has(2);
  @$pb.TagNumber(3)
  void clearWeekFeeSum() => $_clearField(3);

  /// The total amount of fee revenue (in satoshis) the switch has collected
  /// over the past 1 month.
  @$pb.TagNumber(4)
  $fixnum.Int64 get monthFeeSum => $_getI64(3);
  @$pb.TagNumber(4)
  set monthFeeSum($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMonthFeeSum() => $_has(3);
  @$pb.TagNumber(4)
  void clearMonthFeeSum() => $_clearField(4);
}

class InboundFee extends $pb.GeneratedMessage {
  factory InboundFee({
    $core.int? baseFeeMsat,
    $core.int? feeRatePpm,
  }) {
    final $result = create();
    if (baseFeeMsat != null) {
      $result.baseFeeMsat = baseFeeMsat;
    }
    if (feeRatePpm != null) {
      $result.feeRatePpm = feeRatePpm;
    }
    return $result;
  }
  InboundFee._() : super();
  factory InboundFee.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InboundFee.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InboundFee', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'baseFeeMsat', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'feeRatePpm', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InboundFee clone() => InboundFee()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InboundFee copyWith(void Function(InboundFee) updates) => super.copyWith((message) => updates(message as InboundFee)) as InboundFee;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InboundFee create() => InboundFee._();
  InboundFee createEmptyInstance() => create();
  static $pb.PbList<InboundFee> createRepeated() => $pb.PbList<InboundFee>();
  @$core.pragma('dart2js:noInline')
  static InboundFee getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InboundFee>(create);
  static InboundFee? _defaultInstance;

  /// The inbound base fee charged regardless of the number of milli-satoshis
  /// received in the channel. By default, only negative values are accepted.
  @$pb.TagNumber(1)
  $core.int get baseFeeMsat => $_getIZ(0);
  @$pb.TagNumber(1)
  set baseFeeMsat($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBaseFeeMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseFeeMsat() => $_clearField(1);

  /// The effective inbound fee rate in micro-satoshis (parts per million).
  /// By default, only negative values are accepted.
  @$pb.TagNumber(2)
  $core.int get feeRatePpm => $_getIZ(1);
  @$pb.TagNumber(2)
  set feeRatePpm($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFeeRatePpm() => $_has(1);
  @$pb.TagNumber(2)
  void clearFeeRatePpm() => $_clearField(2);
}

enum PolicyUpdateRequest_Scope {
  global, 
  chanPoint, 
  notSet
}

class PolicyUpdateRequest extends $pb.GeneratedMessage {
  factory PolicyUpdateRequest({
    $core.bool? global,
    ChannelPoint? chanPoint,
    $fixnum.Int64? baseFeeMsat,
    $core.double? feeRate,
    $core.int? timeLockDelta,
    $fixnum.Int64? maxHtlcMsat,
    $fixnum.Int64? minHtlcMsat,
    $core.bool? minHtlcMsatSpecified,
    $core.int? feeRatePpm,
    InboundFee? inboundFee,
    $core.bool? createMissingEdge,
  }) {
    final $result = create();
    if (global != null) {
      $result.global = global;
    }
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    if (baseFeeMsat != null) {
      $result.baseFeeMsat = baseFeeMsat;
    }
    if (feeRate != null) {
      $result.feeRate = feeRate;
    }
    if (timeLockDelta != null) {
      $result.timeLockDelta = timeLockDelta;
    }
    if (maxHtlcMsat != null) {
      $result.maxHtlcMsat = maxHtlcMsat;
    }
    if (minHtlcMsat != null) {
      $result.minHtlcMsat = minHtlcMsat;
    }
    if (minHtlcMsatSpecified != null) {
      $result.minHtlcMsatSpecified = minHtlcMsatSpecified;
    }
    if (feeRatePpm != null) {
      $result.feeRatePpm = feeRatePpm;
    }
    if (inboundFee != null) {
      $result.inboundFee = inboundFee;
    }
    if (createMissingEdge != null) {
      $result.createMissingEdge = createMissingEdge;
    }
    return $result;
  }
  PolicyUpdateRequest._() : super();
  factory PolicyUpdateRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PolicyUpdateRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, PolicyUpdateRequest_Scope> _PolicyUpdateRequest_ScopeByTag = {
    1 : PolicyUpdateRequest_Scope.global,
    2 : PolicyUpdateRequest_Scope.chanPoint,
    0 : PolicyUpdateRequest_Scope.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PolicyUpdateRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOB(1, _omitFieldNames ? '' : 'global')
    ..aOM<ChannelPoint>(2, _omitFieldNames ? '' : 'chanPoint', subBuilder: ChannelPoint.create)
    ..aInt64(3, _omitFieldNames ? '' : 'baseFeeMsat')
    ..a<$core.double>(4, _omitFieldNames ? '' : 'feeRate', $pb.PbFieldType.OD)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'timeLockDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'maxHtlcMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'minHtlcMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(8, _omitFieldNames ? '' : 'minHtlcMsatSpecified')
    ..a<$core.int>(9, _omitFieldNames ? '' : 'feeRatePpm', $pb.PbFieldType.OU3)
    ..aOM<InboundFee>(10, _omitFieldNames ? '' : 'inboundFee', subBuilder: InboundFee.create)
    ..aOB(11, _omitFieldNames ? '' : 'createMissingEdge')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PolicyUpdateRequest clone() => PolicyUpdateRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PolicyUpdateRequest copyWith(void Function(PolicyUpdateRequest) updates) => super.copyWith((message) => updates(message as PolicyUpdateRequest)) as PolicyUpdateRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicyUpdateRequest create() => PolicyUpdateRequest._();
  PolicyUpdateRequest createEmptyInstance() => create();
  static $pb.PbList<PolicyUpdateRequest> createRepeated() => $pb.PbList<PolicyUpdateRequest>();
  @$core.pragma('dart2js:noInline')
  static PolicyUpdateRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PolicyUpdateRequest>(create);
  static PolicyUpdateRequest? _defaultInstance;

  PolicyUpdateRequest_Scope whichScope() => _PolicyUpdateRequest_ScopeByTag[$_whichOneof(0)]!;
  void clearScope() => $_clearField($_whichOneof(0));

  /// If set, then this update applies to all currently active channels.
  @$pb.TagNumber(1)
  $core.bool get global => $_getBF(0);
  @$pb.TagNumber(1)
  set global($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGlobal() => $_has(0);
  @$pb.TagNumber(1)
  void clearGlobal() => $_clearField(1);

  /// If set, this update will target a specific channel.
  @$pb.TagNumber(2)
  ChannelPoint get chanPoint => $_getN(1);
  @$pb.TagNumber(2)
  set chanPoint(ChannelPoint v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanPoint() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanPoint() => $_clearField(2);
  @$pb.TagNumber(2)
  ChannelPoint ensureChanPoint() => $_ensure(1);

  /// The base fee charged regardless of the number of milli-satoshis sent.
  @$pb.TagNumber(3)
  $fixnum.Int64 get baseFeeMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set baseFeeMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBaseFeeMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearBaseFeeMsat() => $_clearField(3);

  /// The effective fee rate in milli-satoshis. The precision of this value
  /// goes up to 6 decimal places, so 1e-6.
  @$pb.TagNumber(4)
  $core.double get feeRate => $_getN(3);
  @$pb.TagNumber(4)
  set feeRate($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeRate() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeRate() => $_clearField(4);

  /// The required timelock delta for HTLCs forwarded over the channel.
  @$pb.TagNumber(5)
  $core.int get timeLockDelta => $_getIZ(4);
  @$pb.TagNumber(5)
  set timeLockDelta($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimeLockDelta() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimeLockDelta() => $_clearField(5);

  /// If set, the maximum HTLC size in milli-satoshis. If unset, the maximum
  /// HTLC will be unchanged.
  @$pb.TagNumber(6)
  $fixnum.Int64 get maxHtlcMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set maxHtlcMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMaxHtlcMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearMaxHtlcMsat() => $_clearField(6);

  /// The minimum HTLC size in milli-satoshis. Only applied if
  /// min_htlc_msat_specified is true.
  @$pb.TagNumber(7)
  $fixnum.Int64 get minHtlcMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set minHtlcMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMinHtlcMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearMinHtlcMsat() => $_clearField(7);

  /// If true, min_htlc_msat is applied.
  @$pb.TagNumber(8)
  $core.bool get minHtlcMsatSpecified => $_getBF(7);
  @$pb.TagNumber(8)
  set minHtlcMsatSpecified($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinHtlcMsatSpecified() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinHtlcMsatSpecified() => $_clearField(8);

  /// The effective fee rate in micro-satoshis (parts per million).
  @$pb.TagNumber(9)
  $core.int get feeRatePpm => $_getIZ(8);
  @$pb.TagNumber(9)
  set feeRatePpm($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFeeRatePpm() => $_has(8);
  @$pb.TagNumber(9)
  void clearFeeRatePpm() => $_clearField(9);

  /// Optional inbound fee. If unset, the previously set value will be
  /// retained [EXPERIMENTAL].
  @$pb.TagNumber(10)
  InboundFee get inboundFee => $_getN(9);
  @$pb.TagNumber(10)
  set inboundFee(InboundFee v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasInboundFee() => $_has(9);
  @$pb.TagNumber(10)
  void clearInboundFee() => $_clearField(10);
  @$pb.TagNumber(10)
  InboundFee ensureInboundFee() => $_ensure(9);

  /// Under unknown circumstances a channel can exist with a missing edge in
  /// the graph database. This can cause an 'edge not found' error when calling
  /// `getchaninfo` and/or cause the default channel policy to be used during
  /// forwards. Setting this flag will recreate the edge if not found, allowing
  /// updating this channel policy and fixing the missing edge problem for this
  /// channel permanently. For fields not set in this command, the default
  /// policy will be created.
  @$pb.TagNumber(11)
  $core.bool get createMissingEdge => $_getBF(10);
  @$pb.TagNumber(11)
  set createMissingEdge($core.bool v) { $_setBool(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasCreateMissingEdge() => $_has(10);
  @$pb.TagNumber(11)
  void clearCreateMissingEdge() => $_clearField(11);
}

class FailedUpdate extends $pb.GeneratedMessage {
  factory FailedUpdate({
    OutPoint? outpoint,
    UpdateFailure? reason,
    $core.String? updateError,
  }) {
    final $result = create();
    if (outpoint != null) {
      $result.outpoint = outpoint;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (updateError != null) {
      $result.updateError = updateError;
    }
    return $result;
  }
  FailedUpdate._() : super();
  factory FailedUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FailedUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FailedUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<OutPoint>(1, _omitFieldNames ? '' : 'outpoint', subBuilder: OutPoint.create)
    ..e<UpdateFailure>(2, _omitFieldNames ? '' : 'reason', $pb.PbFieldType.OE, defaultOrMaker: UpdateFailure.UPDATE_FAILURE_UNKNOWN, valueOf: UpdateFailure.valueOf, enumValues: UpdateFailure.values)
    ..aOS(3, _omitFieldNames ? '' : 'updateError')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FailedUpdate clone() => FailedUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FailedUpdate copyWith(void Function(FailedUpdate) updates) => super.copyWith((message) => updates(message as FailedUpdate)) as FailedUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FailedUpdate create() => FailedUpdate._();
  FailedUpdate createEmptyInstance() => create();
  static $pb.PbList<FailedUpdate> createRepeated() => $pb.PbList<FailedUpdate>();
  @$core.pragma('dart2js:noInline')
  static FailedUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FailedUpdate>(create);
  static FailedUpdate? _defaultInstance;

  /// The outpoint in format txid:n
  @$pb.TagNumber(1)
  OutPoint get outpoint => $_getN(0);
  @$pb.TagNumber(1)
  set outpoint(OutPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOutpoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearOutpoint() => $_clearField(1);
  @$pb.TagNumber(1)
  OutPoint ensureOutpoint() => $_ensure(0);

  /// Reason for the policy update failure.
  @$pb.TagNumber(2)
  UpdateFailure get reason => $_getN(1);
  @$pb.TagNumber(2)
  set reason(UpdateFailure v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);

  /// A string representation of the policy update error.
  @$pb.TagNumber(3)
  $core.String get updateError => $_getSZ(2);
  @$pb.TagNumber(3)
  set updateError($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUpdateError() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdateError() => $_clearField(3);
}

class PolicyUpdateResponse extends $pb.GeneratedMessage {
  factory PolicyUpdateResponse({
    $core.Iterable<FailedUpdate>? failedUpdates,
  }) {
    final $result = create();
    if (failedUpdates != null) {
      $result.failedUpdates.addAll(failedUpdates);
    }
    return $result;
  }
  PolicyUpdateResponse._() : super();
  factory PolicyUpdateResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PolicyUpdateResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PolicyUpdateResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<FailedUpdate>(1, _omitFieldNames ? '' : 'failedUpdates', $pb.PbFieldType.PM, subBuilder: FailedUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PolicyUpdateResponse clone() => PolicyUpdateResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PolicyUpdateResponse copyWith(void Function(PolicyUpdateResponse) updates) => super.copyWith((message) => updates(message as PolicyUpdateResponse)) as PolicyUpdateResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PolicyUpdateResponse create() => PolicyUpdateResponse._();
  PolicyUpdateResponse createEmptyInstance() => create();
  static $pb.PbList<PolicyUpdateResponse> createRepeated() => $pb.PbList<PolicyUpdateResponse>();
  @$core.pragma('dart2js:noInline')
  static PolicyUpdateResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PolicyUpdateResponse>(create);
  static PolicyUpdateResponse? _defaultInstance;

  /// List of failed policy updates.
  @$pb.TagNumber(1)
  $pb.PbList<FailedUpdate> get failedUpdates => $_getList(0);
}

class ForwardingHistoryRequest extends $pb.GeneratedMessage {
  factory ForwardingHistoryRequest({
    $fixnum.Int64? startTime,
    $fixnum.Int64? endTime,
    $core.int? indexOffset,
    $core.int? numMaxEvents,
    $core.bool? peerAliasLookup,
  }) {
    final $result = create();
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (endTime != null) {
      $result.endTime = endTime;
    }
    if (indexOffset != null) {
      $result.indexOffset = indexOffset;
    }
    if (numMaxEvents != null) {
      $result.numMaxEvents = numMaxEvents;
    }
    if (peerAliasLookup != null) {
      $result.peerAliasLookup = peerAliasLookup;
    }
    return $result;
  }
  ForwardingHistoryRequest._() : super();
  factory ForwardingHistoryRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardingHistoryRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardingHistoryRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'startTime', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'endTime', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'indexOffset', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'numMaxEvents', $pb.PbFieldType.OU3)
    ..aOB(5, _omitFieldNames ? '' : 'peerAliasLookup')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardingHistoryRequest clone() => ForwardingHistoryRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardingHistoryRequest copyWith(void Function(ForwardingHistoryRequest) updates) => super.copyWith((message) => updates(message as ForwardingHistoryRequest)) as ForwardingHistoryRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardingHistoryRequest create() => ForwardingHistoryRequest._();
  ForwardingHistoryRequest createEmptyInstance() => create();
  static $pb.PbList<ForwardingHistoryRequest> createRepeated() => $pb.PbList<ForwardingHistoryRequest>();
  @$core.pragma('dart2js:noInline')
  static ForwardingHistoryRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardingHistoryRequest>(create);
  static ForwardingHistoryRequest? _defaultInstance;

  /// Start time is the starting point of the forwarding history request. All
  /// records beyond this point will be included, respecting the end time, and
  /// the index offset.
  @$pb.TagNumber(1)
  $fixnum.Int64 get startTime => $_getI64(0);
  @$pb.TagNumber(1)
  set startTime($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStartTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartTime() => $_clearField(1);

  /// End time is the end point of the forwarding history request. The
  /// response will carry at most 50k records between the start time and the
  /// end time. The index offset can be used to implement pagination.
  @$pb.TagNumber(2)
  $fixnum.Int64 get endTime => $_getI64(1);
  @$pb.TagNumber(2)
  set endTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEndTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndTime() => $_clearField(2);

  /// Index offset is the offset in the time series to start at. As each
  /// response can only contain 50k records, callers can use this to skip
  /// around within a packed time series.
  @$pb.TagNumber(3)
  $core.int get indexOffset => $_getIZ(2);
  @$pb.TagNumber(3)
  set indexOffset($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIndexOffset() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndexOffset() => $_clearField(3);

  /// The max number of events to return in the response to this query.
  @$pb.TagNumber(4)
  $core.int get numMaxEvents => $_getIZ(3);
  @$pb.TagNumber(4)
  set numMaxEvents($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumMaxEvents() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumMaxEvents() => $_clearField(4);

  /// Informs the server if the peer alias should be looked up for each
  /// forwarding event.
  @$pb.TagNumber(5)
  $core.bool get peerAliasLookup => $_getBF(4);
  @$pb.TagNumber(5)
  set peerAliasLookup($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPeerAliasLookup() => $_has(4);
  @$pb.TagNumber(5)
  void clearPeerAliasLookup() => $_clearField(5);
}

class ForwardingEvent extends $pb.GeneratedMessage {
  factory ForwardingEvent({
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? timestamp,
    $fixnum.Int64? chanIdIn,
    $fixnum.Int64? chanIdOut,
    $fixnum.Int64? amtIn,
    $fixnum.Int64? amtOut,
    $fixnum.Int64? fee,
    $fixnum.Int64? feeMsat,
    $fixnum.Int64? amtInMsat,
    $fixnum.Int64? amtOutMsat,
    $fixnum.Int64? timestampNs,
    $core.String? peerAliasIn,
    $core.String? peerAliasOut,
  }) {
    final $result = create();
    if (timestamp != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.timestamp = timestamp;
    }
    if (chanIdIn != null) {
      $result.chanIdIn = chanIdIn;
    }
    if (chanIdOut != null) {
      $result.chanIdOut = chanIdOut;
    }
    if (amtIn != null) {
      $result.amtIn = amtIn;
    }
    if (amtOut != null) {
      $result.amtOut = amtOut;
    }
    if (fee != null) {
      $result.fee = fee;
    }
    if (feeMsat != null) {
      $result.feeMsat = feeMsat;
    }
    if (amtInMsat != null) {
      $result.amtInMsat = amtInMsat;
    }
    if (amtOutMsat != null) {
      $result.amtOutMsat = amtOutMsat;
    }
    if (timestampNs != null) {
      $result.timestampNs = timestampNs;
    }
    if (peerAliasIn != null) {
      $result.peerAliasIn = peerAliasIn;
    }
    if (peerAliasOut != null) {
      $result.peerAliasOut = peerAliasOut;
    }
    return $result;
  }
  ForwardingEvent._() : super();
  factory ForwardingEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardingEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardingEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'chanIdIn', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'chanIdOut', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'amtIn', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'amtOut', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'fee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'feeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'amtInMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'amtOutMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'timestampNs', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(12, _omitFieldNames ? '' : 'peerAliasIn')
    ..aOS(13, _omitFieldNames ? '' : 'peerAliasOut')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardingEvent clone() => ForwardingEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardingEvent copyWith(void Function(ForwardingEvent) updates) => super.copyWith((message) => updates(message as ForwardingEvent)) as ForwardingEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardingEvent create() => ForwardingEvent._();
  ForwardingEvent createEmptyInstance() => create();
  static $pb.PbList<ForwardingEvent> createRepeated() => $pb.PbList<ForwardingEvent>();
  @$core.pragma('dart2js:noInline')
  static ForwardingEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardingEvent>(create);
  static ForwardingEvent? _defaultInstance;

  /// Timestamp is the time (unix epoch offset) that this circuit was
  /// completed. Deprecated by timestamp_ns.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $fixnum.Int64 get timestamp => $_getI64(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set timestamp($fixnum.Int64 v) { $_setInt64(0, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasTimestamp() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearTimestamp() => $_clearField(1);

  /// The incoming channel ID that carried the HTLC that created the circuit.
  @$pb.TagNumber(2)
  $fixnum.Int64 get chanIdIn => $_getI64(1);
  @$pb.TagNumber(2)
  set chanIdIn($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanIdIn() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanIdIn() => $_clearField(2);

  /// The outgoing channel ID that carried the preimage that completed the
  /// circuit.
  @$pb.TagNumber(4)
  $fixnum.Int64 get chanIdOut => $_getI64(2);
  @$pb.TagNumber(4)
  set chanIdOut($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasChanIdOut() => $_has(2);
  @$pb.TagNumber(4)
  void clearChanIdOut() => $_clearField(4);

  /// The total amount (in satoshis) of the incoming HTLC that created half
  /// the circuit.
  @$pb.TagNumber(5)
  $fixnum.Int64 get amtIn => $_getI64(3);
  @$pb.TagNumber(5)
  set amtIn($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmtIn() => $_has(3);
  @$pb.TagNumber(5)
  void clearAmtIn() => $_clearField(5);

  /// The total amount (in satoshis) of the outgoing HTLC that created the
  /// second half of the circuit.
  @$pb.TagNumber(6)
  $fixnum.Int64 get amtOut => $_getI64(4);
  @$pb.TagNumber(6)
  set amtOut($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmtOut() => $_has(4);
  @$pb.TagNumber(6)
  void clearAmtOut() => $_clearField(6);

  /// The total fee (in satoshis) that this payment circuit carried.
  @$pb.TagNumber(7)
  $fixnum.Int64 get fee => $_getI64(5);
  @$pb.TagNumber(7)
  set fee($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasFee() => $_has(5);
  @$pb.TagNumber(7)
  void clearFee() => $_clearField(7);

  /// The total fee (in milli-satoshis) that this payment circuit carried.
  @$pb.TagNumber(8)
  $fixnum.Int64 get feeMsat => $_getI64(6);
  @$pb.TagNumber(8)
  set feeMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasFeeMsat() => $_has(6);
  @$pb.TagNumber(8)
  void clearFeeMsat() => $_clearField(8);

  /// The total amount (in milli-satoshis) of the incoming HTLC that created
  /// half the circuit.
  @$pb.TagNumber(9)
  $fixnum.Int64 get amtInMsat => $_getI64(7);
  @$pb.TagNumber(9)
  set amtInMsat($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasAmtInMsat() => $_has(7);
  @$pb.TagNumber(9)
  void clearAmtInMsat() => $_clearField(9);

  /// The total amount (in milli-satoshis) of the outgoing HTLC that created
  /// the second half of the circuit.
  @$pb.TagNumber(10)
  $fixnum.Int64 get amtOutMsat => $_getI64(8);
  @$pb.TagNumber(10)
  set amtOutMsat($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasAmtOutMsat() => $_has(8);
  @$pb.TagNumber(10)
  void clearAmtOutMsat() => $_clearField(10);

  /// The number of nanoseconds elapsed since January 1, 1970 UTC when this
  /// circuit was completed.
  @$pb.TagNumber(11)
  $fixnum.Int64 get timestampNs => $_getI64(9);
  @$pb.TagNumber(11)
  set timestampNs($fixnum.Int64 v) { $_setInt64(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasTimestampNs() => $_has(9);
  @$pb.TagNumber(11)
  void clearTimestampNs() => $_clearField(11);

  /// The peer alias of the incoming channel.
  @$pb.TagNumber(12)
  $core.String get peerAliasIn => $_getSZ(10);
  @$pb.TagNumber(12)
  set peerAliasIn($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(12)
  $core.bool hasPeerAliasIn() => $_has(10);
  @$pb.TagNumber(12)
  void clearPeerAliasIn() => $_clearField(12);

  /// The peer alias of the outgoing channel.
  @$pb.TagNumber(13)
  $core.String get peerAliasOut => $_getSZ(11);
  @$pb.TagNumber(13)
  set peerAliasOut($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(13)
  $core.bool hasPeerAliasOut() => $_has(11);
  @$pb.TagNumber(13)
  void clearPeerAliasOut() => $_clearField(13);
}

class ForwardingHistoryResponse extends $pb.GeneratedMessage {
  factory ForwardingHistoryResponse({
    $core.Iterable<ForwardingEvent>? forwardingEvents,
    $core.int? lastOffsetIndex,
  }) {
    final $result = create();
    if (forwardingEvents != null) {
      $result.forwardingEvents.addAll(forwardingEvents);
    }
    if (lastOffsetIndex != null) {
      $result.lastOffsetIndex = lastOffsetIndex;
    }
    return $result;
  }
  ForwardingHistoryResponse._() : super();
  factory ForwardingHistoryResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardingHistoryResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardingHistoryResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<ForwardingEvent>(1, _omitFieldNames ? '' : 'forwardingEvents', $pb.PbFieldType.PM, subBuilder: ForwardingEvent.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'lastOffsetIndex', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardingHistoryResponse clone() => ForwardingHistoryResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardingHistoryResponse copyWith(void Function(ForwardingHistoryResponse) updates) => super.copyWith((message) => updates(message as ForwardingHistoryResponse)) as ForwardingHistoryResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardingHistoryResponse create() => ForwardingHistoryResponse._();
  ForwardingHistoryResponse createEmptyInstance() => create();
  static $pb.PbList<ForwardingHistoryResponse> createRepeated() => $pb.PbList<ForwardingHistoryResponse>();
  @$core.pragma('dart2js:noInline')
  static ForwardingHistoryResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardingHistoryResponse>(create);
  static ForwardingHistoryResponse? _defaultInstance;

  /// A list of forwarding events from the time slice of the time series
  /// specified in the request.
  @$pb.TagNumber(1)
  $pb.PbList<ForwardingEvent> get forwardingEvents => $_getList(0);

  /// The index of the last time in the set of returned forwarding events. Can
  /// be used to seek further, pagination style.
  @$pb.TagNumber(2)
  $core.int get lastOffsetIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set lastOffsetIndex($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastOffsetIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastOffsetIndex() => $_clearField(2);
}

class ExportChannelBackupRequest extends $pb.GeneratedMessage {
  factory ExportChannelBackupRequest({
    ChannelPoint? chanPoint,
  }) {
    final $result = create();
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    return $result;
  }
  ExportChannelBackupRequest._() : super();
  factory ExportChannelBackupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportChannelBackupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportChannelBackupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<ChannelPoint>(1, _omitFieldNames ? '' : 'chanPoint', subBuilder: ChannelPoint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportChannelBackupRequest clone() => ExportChannelBackupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportChannelBackupRequest copyWith(void Function(ExportChannelBackupRequest) updates) => super.copyWith((message) => updates(message as ExportChannelBackupRequest)) as ExportChannelBackupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportChannelBackupRequest create() => ExportChannelBackupRequest._();
  ExportChannelBackupRequest createEmptyInstance() => create();
  static $pb.PbList<ExportChannelBackupRequest> createRepeated() => $pb.PbList<ExportChannelBackupRequest>();
  @$core.pragma('dart2js:noInline')
  static ExportChannelBackupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportChannelBackupRequest>(create);
  static ExportChannelBackupRequest? _defaultInstance;

  /// The target channel point to obtain a back up for.
  @$pb.TagNumber(1)
  ChannelPoint get chanPoint => $_getN(0);
  @$pb.TagNumber(1)
  set chanPoint(ChannelPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanPoint() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelPoint ensureChanPoint() => $_ensure(0);
}

class ChannelBackup extends $pb.GeneratedMessage {
  factory ChannelBackup({
    ChannelPoint? chanPoint,
    $core.List<$core.int>? chanBackup,
  }) {
    final $result = create();
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    if (chanBackup != null) {
      $result.chanBackup = chanBackup;
    }
    return $result;
  }
  ChannelBackup._() : super();
  factory ChannelBackup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelBackup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelBackup', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<ChannelPoint>(1, _omitFieldNames ? '' : 'chanPoint', subBuilder: ChannelPoint.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'chanBackup', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelBackup clone() => ChannelBackup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelBackup copyWith(void Function(ChannelBackup) updates) => super.copyWith((message) => updates(message as ChannelBackup)) as ChannelBackup;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelBackup create() => ChannelBackup._();
  ChannelBackup createEmptyInstance() => create();
  static $pb.PbList<ChannelBackup> createRepeated() => $pb.PbList<ChannelBackup>();
  @$core.pragma('dart2js:noInline')
  static ChannelBackup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelBackup>(create);
  static ChannelBackup? _defaultInstance;

  ///
  /// Identifies the channel that this backup belongs to.
  @$pb.TagNumber(1)
  ChannelPoint get chanPoint => $_getN(0);
  @$pb.TagNumber(1)
  set chanPoint(ChannelPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanPoint() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelPoint ensureChanPoint() => $_ensure(0);

  ///
  /// Is an encrypted single-chan backup. this can be passed to
  /// RestoreChannelBackups, or the WalletUnlocker Init and Unlock methods in
  /// order to trigger the recovery protocol. When using REST, this field must be
  /// encoded as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get chanBackup => $_getN(1);
  @$pb.TagNumber(2)
  set chanBackup($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChanBackup() => $_has(1);
  @$pb.TagNumber(2)
  void clearChanBackup() => $_clearField(2);
}

class MultiChanBackup extends $pb.GeneratedMessage {
  factory MultiChanBackup({
    $core.Iterable<ChannelPoint>? chanPoints,
    $core.List<$core.int>? multiChanBackup,
  }) {
    final $result = create();
    if (chanPoints != null) {
      $result.chanPoints.addAll(chanPoints);
    }
    if (multiChanBackup != null) {
      $result.multiChanBackup = multiChanBackup;
    }
    return $result;
  }
  MultiChanBackup._() : super();
  factory MultiChanBackup.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MultiChanBackup.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MultiChanBackup', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<ChannelPoint>(1, _omitFieldNames ? '' : 'chanPoints', $pb.PbFieldType.PM, subBuilder: ChannelPoint.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'multiChanBackup', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MultiChanBackup clone() => MultiChanBackup()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MultiChanBackup copyWith(void Function(MultiChanBackup) updates) => super.copyWith((message) => updates(message as MultiChanBackup)) as MultiChanBackup;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultiChanBackup create() => MultiChanBackup._();
  MultiChanBackup createEmptyInstance() => create();
  static $pb.PbList<MultiChanBackup> createRepeated() => $pb.PbList<MultiChanBackup>();
  @$core.pragma('dart2js:noInline')
  static MultiChanBackup getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MultiChanBackup>(create);
  static MultiChanBackup? _defaultInstance;

  ///
  /// Is the set of all channels that are included in this multi-channel backup.
  @$pb.TagNumber(1)
  $pb.PbList<ChannelPoint> get chanPoints => $_getList(0);

  ///
  /// A single encrypted blob containing all the static channel backups of the
  /// channel listed above. This can be stored as a single file or blob, and
  /// safely be replaced with any prior/future versions. When using REST, this
  /// field must be encoded as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get multiChanBackup => $_getN(1);
  @$pb.TagNumber(2)
  set multiChanBackup($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMultiChanBackup() => $_has(1);
  @$pb.TagNumber(2)
  void clearMultiChanBackup() => $_clearField(2);
}

class ChanBackupExportRequest extends $pb.GeneratedMessage {
  factory ChanBackupExportRequest() => create();
  ChanBackupExportRequest._() : super();
  factory ChanBackupExportRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChanBackupExportRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChanBackupExportRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChanBackupExportRequest clone() => ChanBackupExportRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChanBackupExportRequest copyWith(void Function(ChanBackupExportRequest) updates) => super.copyWith((message) => updates(message as ChanBackupExportRequest)) as ChanBackupExportRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChanBackupExportRequest create() => ChanBackupExportRequest._();
  ChanBackupExportRequest createEmptyInstance() => create();
  static $pb.PbList<ChanBackupExportRequest> createRepeated() => $pb.PbList<ChanBackupExportRequest>();
  @$core.pragma('dart2js:noInline')
  static ChanBackupExportRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChanBackupExportRequest>(create);
  static ChanBackupExportRequest? _defaultInstance;
}

class ChanBackupSnapshot extends $pb.GeneratedMessage {
  factory ChanBackupSnapshot({
    ChannelBackups? singleChanBackups,
    MultiChanBackup? multiChanBackup,
  }) {
    final $result = create();
    if (singleChanBackups != null) {
      $result.singleChanBackups = singleChanBackups;
    }
    if (multiChanBackup != null) {
      $result.multiChanBackup = multiChanBackup;
    }
    return $result;
  }
  ChanBackupSnapshot._() : super();
  factory ChanBackupSnapshot.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChanBackupSnapshot.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChanBackupSnapshot', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOM<ChannelBackups>(1, _omitFieldNames ? '' : 'singleChanBackups', subBuilder: ChannelBackups.create)
    ..aOM<MultiChanBackup>(2, _omitFieldNames ? '' : 'multiChanBackup', subBuilder: MultiChanBackup.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChanBackupSnapshot clone() => ChanBackupSnapshot()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChanBackupSnapshot copyWith(void Function(ChanBackupSnapshot) updates) => super.copyWith((message) => updates(message as ChanBackupSnapshot)) as ChanBackupSnapshot;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChanBackupSnapshot create() => ChanBackupSnapshot._();
  ChanBackupSnapshot createEmptyInstance() => create();
  static $pb.PbList<ChanBackupSnapshot> createRepeated() => $pb.PbList<ChanBackupSnapshot>();
  @$core.pragma('dart2js:noInline')
  static ChanBackupSnapshot getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChanBackupSnapshot>(create);
  static ChanBackupSnapshot? _defaultInstance;

  ///
  /// The set of new channels that have been added since the last channel backup
  /// snapshot was requested.
  @$pb.TagNumber(1)
  ChannelBackups get singleChanBackups => $_getN(0);
  @$pb.TagNumber(1)
  set singleChanBackups(ChannelBackups v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasSingleChanBackups() => $_has(0);
  @$pb.TagNumber(1)
  void clearSingleChanBackups() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelBackups ensureSingleChanBackups() => $_ensure(0);

  ///
  /// A multi-channel backup that covers all open channels currently known to
  /// lnd.
  @$pb.TagNumber(2)
  MultiChanBackup get multiChanBackup => $_getN(1);
  @$pb.TagNumber(2)
  set multiChanBackup(MultiChanBackup v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasMultiChanBackup() => $_has(1);
  @$pb.TagNumber(2)
  void clearMultiChanBackup() => $_clearField(2);
  @$pb.TagNumber(2)
  MultiChanBackup ensureMultiChanBackup() => $_ensure(1);
}

class ChannelBackups extends $pb.GeneratedMessage {
  factory ChannelBackups({
    $core.Iterable<ChannelBackup>? chanBackups,
  }) {
    final $result = create();
    if (chanBackups != null) {
      $result.chanBackups.addAll(chanBackups);
    }
    return $result;
  }
  ChannelBackups._() : super();
  factory ChannelBackups.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelBackups.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelBackups', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<ChannelBackup>(1, _omitFieldNames ? '' : 'chanBackups', $pb.PbFieldType.PM, subBuilder: ChannelBackup.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelBackups clone() => ChannelBackups()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelBackups copyWith(void Function(ChannelBackups) updates) => super.copyWith((message) => updates(message as ChannelBackups)) as ChannelBackups;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelBackups create() => ChannelBackups._();
  ChannelBackups createEmptyInstance() => create();
  static $pb.PbList<ChannelBackups> createRepeated() => $pb.PbList<ChannelBackups>();
  @$core.pragma('dart2js:noInline')
  static ChannelBackups getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelBackups>(create);
  static ChannelBackups? _defaultInstance;

  ///
  /// A set of single-chan static channel backups.
  @$pb.TagNumber(1)
  $pb.PbList<ChannelBackup> get chanBackups => $_getList(0);
}

enum RestoreChanBackupRequest_Backup {
  chanBackups, 
  multiChanBackup, 
  notSet
}

class RestoreChanBackupRequest extends $pb.GeneratedMessage {
  factory RestoreChanBackupRequest({
    ChannelBackups? chanBackups,
    $core.List<$core.int>? multiChanBackup,
  }) {
    final $result = create();
    if (chanBackups != null) {
      $result.chanBackups = chanBackups;
    }
    if (multiChanBackup != null) {
      $result.multiChanBackup = multiChanBackup;
    }
    return $result;
  }
  RestoreChanBackupRequest._() : super();
  factory RestoreChanBackupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestoreChanBackupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RestoreChanBackupRequest_Backup> _RestoreChanBackupRequest_BackupByTag = {
    1 : RestoreChanBackupRequest_Backup.chanBackups,
    2 : RestoreChanBackupRequest_Backup.multiChanBackup,
    0 : RestoreChanBackupRequest_Backup.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RestoreChanBackupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<ChannelBackups>(1, _omitFieldNames ? '' : 'chanBackups', subBuilder: ChannelBackups.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'multiChanBackup', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RestoreChanBackupRequest clone() => RestoreChanBackupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RestoreChanBackupRequest copyWith(void Function(RestoreChanBackupRequest) updates) => super.copyWith((message) => updates(message as RestoreChanBackupRequest)) as RestoreChanBackupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RestoreChanBackupRequest create() => RestoreChanBackupRequest._();
  RestoreChanBackupRequest createEmptyInstance() => create();
  static $pb.PbList<RestoreChanBackupRequest> createRepeated() => $pb.PbList<RestoreChanBackupRequest>();
  @$core.pragma('dart2js:noInline')
  static RestoreChanBackupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestoreChanBackupRequest>(create);
  static RestoreChanBackupRequest? _defaultInstance;

  RestoreChanBackupRequest_Backup whichBackup() => _RestoreChanBackupRequest_BackupByTag[$_whichOneof(0)]!;
  void clearBackup() => $_clearField($_whichOneof(0));

  ///
  /// The channels to restore as a list of channel/backup pairs.
  @$pb.TagNumber(1)
  ChannelBackups get chanBackups => $_getN(0);
  @$pb.TagNumber(1)
  set chanBackups(ChannelBackups v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanBackups() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanBackups() => $_clearField(1);
  @$pb.TagNumber(1)
  ChannelBackups ensureChanBackups() => $_ensure(0);

  ///
  /// The channels to restore in the packed multi backup format. When using
  /// REST, this field must be encoded as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get multiChanBackup => $_getN(1);
  @$pb.TagNumber(2)
  set multiChanBackup($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMultiChanBackup() => $_has(1);
  @$pb.TagNumber(2)
  void clearMultiChanBackup() => $_clearField(2);
}

class RestoreBackupResponse extends $pb.GeneratedMessage {
  factory RestoreBackupResponse({
    $core.int? numRestored,
  }) {
    final $result = create();
    if (numRestored != null) {
      $result.numRestored = numRestored;
    }
    return $result;
  }
  RestoreBackupResponse._() : super();
  factory RestoreBackupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RestoreBackupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RestoreBackupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'numRestored', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RestoreBackupResponse clone() => RestoreBackupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RestoreBackupResponse copyWith(void Function(RestoreBackupResponse) updates) => super.copyWith((message) => updates(message as RestoreBackupResponse)) as RestoreBackupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RestoreBackupResponse create() => RestoreBackupResponse._();
  RestoreBackupResponse createEmptyInstance() => create();
  static $pb.PbList<RestoreBackupResponse> createRepeated() => $pb.PbList<RestoreBackupResponse>();
  @$core.pragma('dart2js:noInline')
  static RestoreBackupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RestoreBackupResponse>(create);
  static RestoreBackupResponse? _defaultInstance;

  /// The number of channels successfully restored.
  @$pb.TagNumber(1)
  $core.int get numRestored => $_getIZ(0);
  @$pb.TagNumber(1)
  set numRestored($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNumRestored() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumRestored() => $_clearField(1);
}

class ChannelBackupSubscription extends $pb.GeneratedMessage {
  factory ChannelBackupSubscription() => create();
  ChannelBackupSubscription._() : super();
  factory ChannelBackupSubscription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelBackupSubscription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelBackupSubscription', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelBackupSubscription clone() => ChannelBackupSubscription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelBackupSubscription copyWith(void Function(ChannelBackupSubscription) updates) => super.copyWith((message) => updates(message as ChannelBackupSubscription)) as ChannelBackupSubscription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelBackupSubscription create() => ChannelBackupSubscription._();
  ChannelBackupSubscription createEmptyInstance() => create();
  static $pb.PbList<ChannelBackupSubscription> createRepeated() => $pb.PbList<ChannelBackupSubscription>();
  @$core.pragma('dart2js:noInline')
  static ChannelBackupSubscription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelBackupSubscription>(create);
  static ChannelBackupSubscription? _defaultInstance;
}

class VerifyChanBackupResponse extends $pb.GeneratedMessage {
  factory VerifyChanBackupResponse({
    $core.Iterable<$core.String>? chanPoints,
  }) {
    final $result = create();
    if (chanPoints != null) {
      $result.chanPoints.addAll(chanPoints);
    }
    return $result;
  }
  VerifyChanBackupResponse._() : super();
  factory VerifyChanBackupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyChanBackupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyChanBackupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'chanPoints')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyChanBackupResponse clone() => VerifyChanBackupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyChanBackupResponse copyWith(void Function(VerifyChanBackupResponse) updates) => super.copyWith((message) => updates(message as VerifyChanBackupResponse)) as VerifyChanBackupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyChanBackupResponse create() => VerifyChanBackupResponse._();
  VerifyChanBackupResponse createEmptyInstance() => create();
  static $pb.PbList<VerifyChanBackupResponse> createRepeated() => $pb.PbList<VerifyChanBackupResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifyChanBackupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyChanBackupResponse>(create);
  static VerifyChanBackupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get chanPoints => $_getList(0);
}

class MacaroonPermission extends $pb.GeneratedMessage {
  factory MacaroonPermission({
    $core.String? entity,
    $core.String? action,
  }) {
    final $result = create();
    if (entity != null) {
      $result.entity = entity;
    }
    if (action != null) {
      $result.action = action;
    }
    return $result;
  }
  MacaroonPermission._() : super();
  factory MacaroonPermission.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MacaroonPermission.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MacaroonPermission', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'entity')
    ..aOS(2, _omitFieldNames ? '' : 'action')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MacaroonPermission clone() => MacaroonPermission()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MacaroonPermission copyWith(void Function(MacaroonPermission) updates) => super.copyWith((message) => updates(message as MacaroonPermission)) as MacaroonPermission;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MacaroonPermission create() => MacaroonPermission._();
  MacaroonPermission createEmptyInstance() => create();
  static $pb.PbList<MacaroonPermission> createRepeated() => $pb.PbList<MacaroonPermission>();
  @$core.pragma('dart2js:noInline')
  static MacaroonPermission getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MacaroonPermission>(create);
  static MacaroonPermission? _defaultInstance;

  /// The entity a permission grants access to.
  @$pb.TagNumber(1)
  $core.String get entity => $_getSZ(0);
  @$pb.TagNumber(1)
  set entity($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);

  /// The action that is granted.
  @$pb.TagNumber(2)
  $core.String get action => $_getSZ(1);
  @$pb.TagNumber(2)
  set action($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);
}

class BakeMacaroonRequest extends $pb.GeneratedMessage {
  factory BakeMacaroonRequest({
    $core.Iterable<MacaroonPermission>? permissions,
    $fixnum.Int64? rootKeyId,
    $core.bool? allowExternalPermissions,
  }) {
    final $result = create();
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    if (rootKeyId != null) {
      $result.rootKeyId = rootKeyId;
    }
    if (allowExternalPermissions != null) {
      $result.allowExternalPermissions = allowExternalPermissions;
    }
    return $result;
  }
  BakeMacaroonRequest._() : super();
  factory BakeMacaroonRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BakeMacaroonRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BakeMacaroonRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<MacaroonPermission>(1, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: MacaroonPermission.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'rootKeyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(3, _omitFieldNames ? '' : 'allowExternalPermissions')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BakeMacaroonRequest clone() => BakeMacaroonRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BakeMacaroonRequest copyWith(void Function(BakeMacaroonRequest) updates) => super.copyWith((message) => updates(message as BakeMacaroonRequest)) as BakeMacaroonRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BakeMacaroonRequest create() => BakeMacaroonRequest._();
  BakeMacaroonRequest createEmptyInstance() => create();
  static $pb.PbList<BakeMacaroonRequest> createRepeated() => $pb.PbList<BakeMacaroonRequest>();
  @$core.pragma('dart2js:noInline')
  static BakeMacaroonRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BakeMacaroonRequest>(create);
  static BakeMacaroonRequest? _defaultInstance;

  /// The list of permissions the new macaroon should grant.
  @$pb.TagNumber(1)
  $pb.PbList<MacaroonPermission> get permissions => $_getList(0);

  /// The root key ID used to create the macaroon, must be a positive integer.
  @$pb.TagNumber(2)
  $fixnum.Int64 get rootKeyId => $_getI64(1);
  @$pb.TagNumber(2)
  set rootKeyId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRootKeyId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRootKeyId() => $_clearField(2);

  ///
  /// Informs the RPC on whether to allow external permissions that LND is not
  /// aware of.
  @$pb.TagNumber(3)
  $core.bool get allowExternalPermissions => $_getBF(2);
  @$pb.TagNumber(3)
  set allowExternalPermissions($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAllowExternalPermissions() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllowExternalPermissions() => $_clearField(3);
}

class BakeMacaroonResponse extends $pb.GeneratedMessage {
  factory BakeMacaroonResponse({
    $core.String? macaroon,
  }) {
    final $result = create();
    if (macaroon != null) {
      $result.macaroon = macaroon;
    }
    return $result;
  }
  BakeMacaroonResponse._() : super();
  factory BakeMacaroonResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BakeMacaroonResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BakeMacaroonResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'macaroon')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BakeMacaroonResponse clone() => BakeMacaroonResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BakeMacaroonResponse copyWith(void Function(BakeMacaroonResponse) updates) => super.copyWith((message) => updates(message as BakeMacaroonResponse)) as BakeMacaroonResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BakeMacaroonResponse create() => BakeMacaroonResponse._();
  BakeMacaroonResponse createEmptyInstance() => create();
  static $pb.PbList<BakeMacaroonResponse> createRepeated() => $pb.PbList<BakeMacaroonResponse>();
  @$core.pragma('dart2js:noInline')
  static BakeMacaroonResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BakeMacaroonResponse>(create);
  static BakeMacaroonResponse? _defaultInstance;

  /// The hex encoded macaroon, serialized in binary format.
  @$pb.TagNumber(1)
  $core.String get macaroon => $_getSZ(0);
  @$pb.TagNumber(1)
  set macaroon($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMacaroon() => $_has(0);
  @$pb.TagNumber(1)
  void clearMacaroon() => $_clearField(1);
}

class ListMacaroonIDsRequest extends $pb.GeneratedMessage {
  factory ListMacaroonIDsRequest() => create();
  ListMacaroonIDsRequest._() : super();
  factory ListMacaroonIDsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMacaroonIDsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListMacaroonIDsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMacaroonIDsRequest clone() => ListMacaroonIDsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMacaroonIDsRequest copyWith(void Function(ListMacaroonIDsRequest) updates) => super.copyWith((message) => updates(message as ListMacaroonIDsRequest)) as ListMacaroonIDsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMacaroonIDsRequest create() => ListMacaroonIDsRequest._();
  ListMacaroonIDsRequest createEmptyInstance() => create();
  static $pb.PbList<ListMacaroonIDsRequest> createRepeated() => $pb.PbList<ListMacaroonIDsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMacaroonIDsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMacaroonIDsRequest>(create);
  static ListMacaroonIDsRequest? _defaultInstance;
}

class ListMacaroonIDsResponse extends $pb.GeneratedMessage {
  factory ListMacaroonIDsResponse({
    $core.Iterable<$fixnum.Int64>? rootKeyIds,
  }) {
    final $result = create();
    if (rootKeyIds != null) {
      $result.rootKeyIds.addAll(rootKeyIds);
    }
    return $result;
  }
  ListMacaroonIDsResponse._() : super();
  factory ListMacaroonIDsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMacaroonIDsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListMacaroonIDsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'rootKeyIds', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMacaroonIDsResponse clone() => ListMacaroonIDsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMacaroonIDsResponse copyWith(void Function(ListMacaroonIDsResponse) updates) => super.copyWith((message) => updates(message as ListMacaroonIDsResponse)) as ListMacaroonIDsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListMacaroonIDsResponse create() => ListMacaroonIDsResponse._();
  ListMacaroonIDsResponse createEmptyInstance() => create();
  static $pb.PbList<ListMacaroonIDsResponse> createRepeated() => $pb.PbList<ListMacaroonIDsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListMacaroonIDsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMacaroonIDsResponse>(create);
  static ListMacaroonIDsResponse? _defaultInstance;

  /// The list of root key IDs that are in use.
  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get rootKeyIds => $_getList(0);
}

class DeleteMacaroonIDRequest extends $pb.GeneratedMessage {
  factory DeleteMacaroonIDRequest({
    $fixnum.Int64? rootKeyId,
  }) {
    final $result = create();
    if (rootKeyId != null) {
      $result.rootKeyId = rootKeyId;
    }
    return $result;
  }
  DeleteMacaroonIDRequest._() : super();
  factory DeleteMacaroonIDRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteMacaroonIDRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteMacaroonIDRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'rootKeyId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteMacaroonIDRequest clone() => DeleteMacaroonIDRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteMacaroonIDRequest copyWith(void Function(DeleteMacaroonIDRequest) updates) => super.copyWith((message) => updates(message as DeleteMacaroonIDRequest)) as DeleteMacaroonIDRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteMacaroonIDRequest create() => DeleteMacaroonIDRequest._();
  DeleteMacaroonIDRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteMacaroonIDRequest> createRepeated() => $pb.PbList<DeleteMacaroonIDRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteMacaroonIDRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteMacaroonIDRequest>(create);
  static DeleteMacaroonIDRequest? _defaultInstance;

  /// The root key ID to be removed.
  @$pb.TagNumber(1)
  $fixnum.Int64 get rootKeyId => $_getI64(0);
  @$pb.TagNumber(1)
  set rootKeyId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRootKeyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRootKeyId() => $_clearField(1);
}

class DeleteMacaroonIDResponse extends $pb.GeneratedMessage {
  factory DeleteMacaroonIDResponse({
    $core.bool? deleted,
  }) {
    final $result = create();
    if (deleted != null) {
      $result.deleted = deleted;
    }
    return $result;
  }
  DeleteMacaroonIDResponse._() : super();
  factory DeleteMacaroonIDResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteMacaroonIDResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteMacaroonIDResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'deleted')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteMacaroonIDResponse clone() => DeleteMacaroonIDResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteMacaroonIDResponse copyWith(void Function(DeleteMacaroonIDResponse) updates) => super.copyWith((message) => updates(message as DeleteMacaroonIDResponse)) as DeleteMacaroonIDResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteMacaroonIDResponse create() => DeleteMacaroonIDResponse._();
  DeleteMacaroonIDResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteMacaroonIDResponse> createRepeated() => $pb.PbList<DeleteMacaroonIDResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteMacaroonIDResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteMacaroonIDResponse>(create);
  static DeleteMacaroonIDResponse? _defaultInstance;

  /// A boolean indicates that the deletion is successful.
  @$pb.TagNumber(1)
  $core.bool get deleted => $_getBF(0);
  @$pb.TagNumber(1)
  set deleted($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDeleted() => $_has(0);
  @$pb.TagNumber(1)
  void clearDeleted() => $_clearField(1);
}

class MacaroonPermissionList extends $pb.GeneratedMessage {
  factory MacaroonPermissionList({
    $core.Iterable<MacaroonPermission>? permissions,
  }) {
    final $result = create();
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    return $result;
  }
  MacaroonPermissionList._() : super();
  factory MacaroonPermissionList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MacaroonPermissionList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MacaroonPermissionList', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..pc<MacaroonPermission>(1, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: MacaroonPermission.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MacaroonPermissionList clone() => MacaroonPermissionList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MacaroonPermissionList copyWith(void Function(MacaroonPermissionList) updates) => super.copyWith((message) => updates(message as MacaroonPermissionList)) as MacaroonPermissionList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MacaroonPermissionList create() => MacaroonPermissionList._();
  MacaroonPermissionList createEmptyInstance() => create();
  static $pb.PbList<MacaroonPermissionList> createRepeated() => $pb.PbList<MacaroonPermissionList>();
  @$core.pragma('dart2js:noInline')
  static MacaroonPermissionList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MacaroonPermissionList>(create);
  static MacaroonPermissionList? _defaultInstance;

  /// A list of macaroon permissions.
  @$pb.TagNumber(1)
  $pb.PbList<MacaroonPermission> get permissions => $_getList(0);
}

class ListPermissionsRequest extends $pb.GeneratedMessage {
  factory ListPermissionsRequest() => create();
  ListPermissionsRequest._() : super();
  factory ListPermissionsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPermissionsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPermissionsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPermissionsRequest clone() => ListPermissionsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPermissionsRequest copyWith(void Function(ListPermissionsRequest) updates) => super.copyWith((message) => updates(message as ListPermissionsRequest)) as ListPermissionsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPermissionsRequest create() => ListPermissionsRequest._();
  ListPermissionsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPermissionsRequest> createRepeated() => $pb.PbList<ListPermissionsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPermissionsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPermissionsRequest>(create);
  static ListPermissionsRequest? _defaultInstance;
}

class ListPermissionsResponse extends $pb.GeneratedMessage {
  factory ListPermissionsResponse({
    $pb.PbMap<$core.String, MacaroonPermissionList>? methodPermissions,
  }) {
    final $result = create();
    if (methodPermissions != null) {
      $result.methodPermissions.addAll(methodPermissions);
    }
    return $result;
  }
  ListPermissionsResponse._() : super();
  factory ListPermissionsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPermissionsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPermissionsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..m<$core.String, MacaroonPermissionList>(1, _omitFieldNames ? '' : 'methodPermissions', entryClassName: 'ListPermissionsResponse.MethodPermissionsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OM, valueCreator: MacaroonPermissionList.create, valueDefaultOrMaker: MacaroonPermissionList.getDefault, packageName: const $pb.PackageName('lnrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPermissionsResponse clone() => ListPermissionsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPermissionsResponse copyWith(void Function(ListPermissionsResponse) updates) => super.copyWith((message) => updates(message as ListPermissionsResponse)) as ListPermissionsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPermissionsResponse create() => ListPermissionsResponse._();
  ListPermissionsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPermissionsResponse> createRepeated() => $pb.PbList<ListPermissionsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPermissionsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPermissionsResponse>(create);
  static ListPermissionsResponse? _defaultInstance;

  ///
  /// A map between all RPC method URIs and their required macaroon permissions to
  /// access them.
  @$pb.TagNumber(1)
  $pb.PbMap<$core.String, MacaroonPermissionList> get methodPermissions => $_getMap(0);
}

class Failure extends $pb.GeneratedMessage {
  factory Failure({
    Failure_FailureCode? code,
    ChannelUpdate? channelUpdate,
    $fixnum.Int64? htlcMsat,
    $core.List<$core.int>? onionSha256,
    $core.int? cltvExpiry,
    $core.int? flags,
    $core.int? failureSourceIndex,
    $core.int? height,
  }) {
    final $result = create();
    if (code != null) {
      $result.code = code;
    }
    if (channelUpdate != null) {
      $result.channelUpdate = channelUpdate;
    }
    if (htlcMsat != null) {
      $result.htlcMsat = htlcMsat;
    }
    if (onionSha256 != null) {
      $result.onionSha256 = onionSha256;
    }
    if (cltvExpiry != null) {
      $result.cltvExpiry = cltvExpiry;
    }
    if (flags != null) {
      $result.flags = flags;
    }
    if (failureSourceIndex != null) {
      $result.failureSourceIndex = failureSourceIndex;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  Failure._() : super();
  factory Failure.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Failure.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Failure', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..e<Failure_FailureCode>(1, _omitFieldNames ? '' : 'code', $pb.PbFieldType.OE, defaultOrMaker: Failure_FailureCode.RESERVED, valueOf: Failure_FailureCode.valueOf, enumValues: Failure_FailureCode.values)
    ..aOM<ChannelUpdate>(3, _omitFieldNames ? '' : 'channelUpdate', subBuilder: ChannelUpdate.create)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'htlcMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'onionSha256', $pb.PbFieldType.OY, protoName: 'onion_sha_256')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'cltvExpiry', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'flags', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'failureSourceIndex', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Failure clone() => Failure()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Failure copyWith(void Function(Failure) updates) => super.copyWith((message) => updates(message as Failure)) as Failure;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Failure create() => Failure._();
  Failure createEmptyInstance() => create();
  static $pb.PbList<Failure> createRepeated() => $pb.PbList<Failure>();
  @$core.pragma('dart2js:noInline')
  static Failure getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Failure>(create);
  static Failure? _defaultInstance;

  /// Failure code as defined in the Lightning spec
  @$pb.TagNumber(1)
  Failure_FailureCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(Failure_FailureCode v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  /// An optional channel update message.
  @$pb.TagNumber(3)
  ChannelUpdate get channelUpdate => $_getN(1);
  @$pb.TagNumber(3)
  set channelUpdate(ChannelUpdate v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelUpdate() => $_has(1);
  @$pb.TagNumber(3)
  void clearChannelUpdate() => $_clearField(3);
  @$pb.TagNumber(3)
  ChannelUpdate ensureChannelUpdate() => $_ensure(1);

  /// A failure type-dependent htlc value.
  @$pb.TagNumber(4)
  $fixnum.Int64 get htlcMsat => $_getI64(2);
  @$pb.TagNumber(4)
  set htlcMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasHtlcMsat() => $_has(2);
  @$pb.TagNumber(4)
  void clearHtlcMsat() => $_clearField(4);

  /// The sha256 sum of the onion payload.
  @$pb.TagNumber(5)
  $core.List<$core.int> get onionSha256 => $_getN(3);
  @$pb.TagNumber(5)
  set onionSha256($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasOnionSha256() => $_has(3);
  @$pb.TagNumber(5)
  void clearOnionSha256() => $_clearField(5);

  /// A failure type-dependent cltv expiry value.
  @$pb.TagNumber(6)
  $core.int get cltvExpiry => $_getIZ(4);
  @$pb.TagNumber(6)
  set cltvExpiry($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasCltvExpiry() => $_has(4);
  @$pb.TagNumber(6)
  void clearCltvExpiry() => $_clearField(6);

  /// A failure type-dependent flags value.
  @$pb.TagNumber(7)
  $core.int get flags => $_getIZ(5);
  @$pb.TagNumber(7)
  set flags($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasFlags() => $_has(5);
  @$pb.TagNumber(7)
  void clearFlags() => $_clearField(7);

  ///
  /// The position in the path of the intermediate or final node that generated
  /// the failure message. Position zero is the sender node.
  @$pb.TagNumber(8)
  $core.int get failureSourceIndex => $_getIZ(6);
  @$pb.TagNumber(8)
  set failureSourceIndex($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasFailureSourceIndex() => $_has(6);
  @$pb.TagNumber(8)
  void clearFailureSourceIndex() => $_clearField(8);

  /// A failure type-dependent block height.
  @$pb.TagNumber(9)
  $core.int get height => $_getIZ(7);
  @$pb.TagNumber(9)
  set height($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasHeight() => $_has(7);
  @$pb.TagNumber(9)
  void clearHeight() => $_clearField(9);
}

class ChannelUpdate extends $pb.GeneratedMessage {
  factory ChannelUpdate({
    $core.List<$core.int>? signature,
    $core.List<$core.int>? chainHash,
    $fixnum.Int64? chanId,
    $core.int? timestamp,
    $core.int? channelFlags,
    $core.int? timeLockDelta,
    $fixnum.Int64? htlcMinimumMsat,
    $core.int? baseFee,
    $core.int? feeRate,
    $core.int? messageFlags,
    $fixnum.Int64? htlcMaximumMsat,
    $core.List<$core.int>? extraOpaqueData,
  }) {
    final $result = create();
    if (signature != null) {
      $result.signature = signature;
    }
    if (chainHash != null) {
      $result.chainHash = chainHash;
    }
    if (chanId != null) {
      $result.chanId = chanId;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (channelFlags != null) {
      $result.channelFlags = channelFlags;
    }
    if (timeLockDelta != null) {
      $result.timeLockDelta = timeLockDelta;
    }
    if (htlcMinimumMsat != null) {
      $result.htlcMinimumMsat = htlcMinimumMsat;
    }
    if (baseFee != null) {
      $result.baseFee = baseFee;
    }
    if (feeRate != null) {
      $result.feeRate = feeRate;
    }
    if (messageFlags != null) {
      $result.messageFlags = messageFlags;
    }
    if (htlcMaximumMsat != null) {
      $result.htlcMaximumMsat = htlcMaximumMsat;
    }
    if (extraOpaqueData != null) {
      $result.extraOpaqueData = extraOpaqueData;
    }
    return $result;
  }
  ChannelUpdate._() : super();
  factory ChannelUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'chainHash', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'chanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'channelFlags', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'timeLockDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'htlcMinimumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'baseFee', $pb.PbFieldType.OU3)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'feeRate', $pb.PbFieldType.OU3)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'messageFlags', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'htlcMaximumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(12, _omitFieldNames ? '' : 'extraOpaqueData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelUpdate clone() => ChannelUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelUpdate copyWith(void Function(ChannelUpdate) updates) => super.copyWith((message) => updates(message as ChannelUpdate)) as ChannelUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelUpdate create() => ChannelUpdate._();
  ChannelUpdate createEmptyInstance() => create();
  static $pb.PbList<ChannelUpdate> createRepeated() => $pb.PbList<ChannelUpdate>();
  @$core.pragma('dart2js:noInline')
  static ChannelUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelUpdate>(create);
  static ChannelUpdate? _defaultInstance;

  ///
  /// The signature that validates the announced data and proves the ownership
  /// of node id.
  @$pb.TagNumber(1)
  $core.List<$core.int> get signature => $_getN(0);
  @$pb.TagNumber(1)
  set signature($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);

  ///
  /// The target chain that this channel was opened within. This value
  /// should be the genesis hash of the target chain. Along with the short
  /// channel ID, this uniquely identifies the channel globally in a
  /// blockchain.
  @$pb.TagNumber(2)
  $core.List<$core.int> get chainHash => $_getN(1);
  @$pb.TagNumber(2)
  set chainHash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChainHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearChainHash() => $_clearField(2);

  ///
  /// The unique description of the funding transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get chanId => $_getI64(2);
  @$pb.TagNumber(3)
  set chanId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearChanId() => $_clearField(3);

  ///
  /// A timestamp that allows ordering in the case of multiple announcements.
  /// We should ignore the message if timestamp is not greater than the
  /// last-received.
  @$pb.TagNumber(4)
  $core.int get timestamp => $_getIZ(3);
  @$pb.TagNumber(4)
  set timestamp($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);

  ///
  /// The bitfield that describes additional meta-data concerning how the
  /// update is to be interpreted. Currently, the least-significant bit must be
  /// set to 0 if the creating node corresponds to the first node in the
  /// previously sent channel announcement and 1 otherwise. If the second bit
  /// is set, then the channel is set to be disabled.
  @$pb.TagNumber(5)
  $core.int get channelFlags => $_getIZ(4);
  @$pb.TagNumber(5)
  set channelFlags($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasChannelFlags() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelFlags() => $_clearField(5);

  ///
  /// The minimum number of blocks this node requires to be added to the expiry
  /// of HTLCs. This is a security parameter determined by the node operator.
  /// This value represents the required gap between the time locks of the
  /// incoming and outgoing HTLC's set to this node.
  @$pb.TagNumber(6)
  $core.int get timeLockDelta => $_getIZ(5);
  @$pb.TagNumber(6)
  set timeLockDelta($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimeLockDelta() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimeLockDelta() => $_clearField(6);

  ///
  /// The minimum HTLC value which will be accepted.
  @$pb.TagNumber(7)
  $fixnum.Int64 get htlcMinimumMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set htlcMinimumMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasHtlcMinimumMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearHtlcMinimumMsat() => $_clearField(7);

  ///
  /// The base fee that must be used for incoming HTLC's to this particular
  /// channel. This value will be tacked onto the required for a payment
  /// independent of the size of the payment.
  @$pb.TagNumber(8)
  $core.int get baseFee => $_getIZ(7);
  @$pb.TagNumber(8)
  set baseFee($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBaseFee() => $_has(7);
  @$pb.TagNumber(8)
  void clearBaseFee() => $_clearField(8);

  ///
  /// The fee rate that will be charged per millionth of a satoshi.
  @$pb.TagNumber(9)
  $core.int get feeRate => $_getIZ(8);
  @$pb.TagNumber(9)
  set feeRate($core.int v) { $_setUnsignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasFeeRate() => $_has(8);
  @$pb.TagNumber(9)
  void clearFeeRate() => $_clearField(9);

  ///
  /// The bitfield that describes whether optional fields are present in this
  /// update. Currently, the least-significant bit must be set to 1 if the
  /// optional field MaxHtlc is present.
  @$pb.TagNumber(10)
  $core.int get messageFlags => $_getIZ(9);
  @$pb.TagNumber(10)
  set messageFlags($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasMessageFlags() => $_has(9);
  @$pb.TagNumber(10)
  void clearMessageFlags() => $_clearField(10);

  ///
  /// The maximum HTLC value which will be accepted.
  @$pb.TagNumber(11)
  $fixnum.Int64 get htlcMaximumMsat => $_getI64(10);
  @$pb.TagNumber(11)
  set htlcMaximumMsat($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasHtlcMaximumMsat() => $_has(10);
  @$pb.TagNumber(11)
  void clearHtlcMaximumMsat() => $_clearField(11);

  ///
  /// The set of data that was appended to this message, some of which we may
  /// not actually know how to iterate or parse. By holding onto this data, we
  /// ensure that we're able to properly validate the set of signatures that
  /// cover these new fields, and ensure we're able to make upgrades to the
  /// network in a forwards compatible manner.
  @$pb.TagNumber(12)
  $core.List<$core.int> get extraOpaqueData => $_getN(11);
  @$pb.TagNumber(12)
  set extraOpaqueData($core.List<$core.int> v) { $_setBytes(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasExtraOpaqueData() => $_has(11);
  @$pb.TagNumber(12)
  void clearExtraOpaqueData() => $_clearField(12);
}

class MacaroonId extends $pb.GeneratedMessage {
  factory MacaroonId({
    $core.List<$core.int>? nonce,
    $core.List<$core.int>? storageId,
    $core.Iterable<Op>? ops,
  }) {
    final $result = create();
    if (nonce != null) {
      $result.nonce = nonce;
    }
    if (storageId != null) {
      $result.storageId = storageId;
    }
    if (ops != null) {
      $result.ops.addAll(ops);
    }
    return $result;
  }
  MacaroonId._() : super();
  factory MacaroonId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MacaroonId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MacaroonId', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'nonce', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'storageId', $pb.PbFieldType.OY, protoName: 'storageId')
    ..pc<Op>(3, _omitFieldNames ? '' : 'ops', $pb.PbFieldType.PM, subBuilder: Op.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MacaroonId clone() => MacaroonId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MacaroonId copyWith(void Function(MacaroonId) updates) => super.copyWith((message) => updates(message as MacaroonId)) as MacaroonId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MacaroonId create() => MacaroonId._();
  MacaroonId createEmptyInstance() => create();
  static $pb.PbList<MacaroonId> createRepeated() => $pb.PbList<MacaroonId>();
  @$core.pragma('dart2js:noInline')
  static MacaroonId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MacaroonId>(create);
  static MacaroonId? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get nonce => $_getN(0);
  @$pb.TagNumber(1)
  set nonce($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNonce() => $_has(0);
  @$pb.TagNumber(1)
  void clearNonce() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get storageId => $_getN(1);
  @$pb.TagNumber(2)
  set storageId($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStorageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStorageId() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<Op> get ops => $_getList(2);
}

class Op extends $pb.GeneratedMessage {
  factory Op({
    $core.String? entity,
    $core.Iterable<$core.String>? actions,
  }) {
    final $result = create();
    if (entity != null) {
      $result.entity = entity;
    }
    if (actions != null) {
      $result.actions.addAll(actions);
    }
    return $result;
  }
  Op._() : super();
  factory Op.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Op.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Op', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'entity')
    ..pPS(2, _omitFieldNames ? '' : 'actions')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Op clone() => Op()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Op copyWith(void Function(Op) updates) => super.copyWith((message) => updates(message as Op)) as Op;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Op create() => Op._();
  Op createEmptyInstance() => create();
  static $pb.PbList<Op> createRepeated() => $pb.PbList<Op>();
  @$core.pragma('dart2js:noInline')
  static Op getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Op>(create);
  static Op? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get entity => $_getSZ(0);
  @$pb.TagNumber(1)
  set entity($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEntity() => $_has(0);
  @$pb.TagNumber(1)
  void clearEntity() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get actions => $_getList(1);
}

class CheckMacPermRequest extends $pb.GeneratedMessage {
  factory CheckMacPermRequest({
    $core.List<$core.int>? macaroon,
    $core.Iterable<MacaroonPermission>? permissions,
    $core.String? fullMethod,
  }) {
    final $result = create();
    if (macaroon != null) {
      $result.macaroon = macaroon;
    }
    if (permissions != null) {
      $result.permissions.addAll(permissions);
    }
    if (fullMethod != null) {
      $result.fullMethod = fullMethod;
    }
    return $result;
  }
  CheckMacPermRequest._() : super();
  factory CheckMacPermRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckMacPermRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckMacPermRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'macaroon', $pb.PbFieldType.OY)
    ..pc<MacaroonPermission>(2, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.PM, subBuilder: MacaroonPermission.create)
    ..aOS(3, _omitFieldNames ? '' : 'fullMethod', protoName: 'fullMethod')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckMacPermRequest clone() => CheckMacPermRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckMacPermRequest copyWith(void Function(CheckMacPermRequest) updates) => super.copyWith((message) => updates(message as CheckMacPermRequest)) as CheckMacPermRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckMacPermRequest create() => CheckMacPermRequest._();
  CheckMacPermRequest createEmptyInstance() => create();
  static $pb.PbList<CheckMacPermRequest> createRepeated() => $pb.PbList<CheckMacPermRequest>();
  @$core.pragma('dart2js:noInline')
  static CheckMacPermRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckMacPermRequest>(create);
  static CheckMacPermRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get macaroon => $_getN(0);
  @$pb.TagNumber(1)
  set macaroon($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMacaroon() => $_has(0);
  @$pb.TagNumber(1)
  void clearMacaroon() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<MacaroonPermission> get permissions => $_getList(1);

  @$pb.TagNumber(3)
  $core.String get fullMethod => $_getSZ(2);
  @$pb.TagNumber(3)
  set fullMethod($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFullMethod() => $_has(2);
  @$pb.TagNumber(3)
  void clearFullMethod() => $_clearField(3);
}

class CheckMacPermResponse extends $pb.GeneratedMessage {
  factory CheckMacPermResponse({
    $core.bool? valid,
  }) {
    final $result = create();
    if (valid != null) {
      $result.valid = valid;
    }
    return $result;
  }
  CheckMacPermResponse._() : super();
  factory CheckMacPermResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CheckMacPermResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckMacPermResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CheckMacPermResponse clone() => CheckMacPermResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CheckMacPermResponse copyWith(void Function(CheckMacPermResponse) updates) => super.copyWith((message) => updates(message as CheckMacPermResponse)) as CheckMacPermResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckMacPermResponse create() => CheckMacPermResponse._();
  CheckMacPermResponse createEmptyInstance() => create();
  static $pb.PbList<CheckMacPermResponse> createRepeated() => $pb.PbList<CheckMacPermResponse>();
  @$core.pragma('dart2js:noInline')
  static CheckMacPermResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckMacPermResponse>(create);
  static CheckMacPermResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);
}

enum RPCMiddlewareRequest_InterceptType {
  streamAuth, 
  request, 
  response, 
  regComplete, 
  notSet
}

class RPCMiddlewareRequest extends $pb.GeneratedMessage {
  factory RPCMiddlewareRequest({
    $fixnum.Int64? requestId,
    $core.List<$core.int>? rawMacaroon,
    $core.String? customCaveatCondition,
    StreamAuth? streamAuth,
    RPCMessage? request,
    RPCMessage? response,
    $fixnum.Int64? msgId,
    $core.bool? regComplete,
  }) {
    final $result = create();
    if (requestId != null) {
      $result.requestId = requestId;
    }
    if (rawMacaroon != null) {
      $result.rawMacaroon = rawMacaroon;
    }
    if (customCaveatCondition != null) {
      $result.customCaveatCondition = customCaveatCondition;
    }
    if (streamAuth != null) {
      $result.streamAuth = streamAuth;
    }
    if (request != null) {
      $result.request = request;
    }
    if (response != null) {
      $result.response = response;
    }
    if (msgId != null) {
      $result.msgId = msgId;
    }
    if (regComplete != null) {
      $result.regComplete = regComplete;
    }
    return $result;
  }
  RPCMiddlewareRequest._() : super();
  factory RPCMiddlewareRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RPCMiddlewareRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RPCMiddlewareRequest_InterceptType> _RPCMiddlewareRequest_InterceptTypeByTag = {
    4 : RPCMiddlewareRequest_InterceptType.streamAuth,
    5 : RPCMiddlewareRequest_InterceptType.request,
    6 : RPCMiddlewareRequest_InterceptType.response,
    8 : RPCMiddlewareRequest_InterceptType.regComplete,
    0 : RPCMiddlewareRequest_InterceptType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RPCMiddlewareRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 8])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'requestId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'rawMacaroon', $pb.PbFieldType.OY)
    ..aOS(3, _omitFieldNames ? '' : 'customCaveatCondition')
    ..aOM<StreamAuth>(4, _omitFieldNames ? '' : 'streamAuth', subBuilder: StreamAuth.create)
    ..aOM<RPCMessage>(5, _omitFieldNames ? '' : 'request', subBuilder: RPCMessage.create)
    ..aOM<RPCMessage>(6, _omitFieldNames ? '' : 'response', subBuilder: RPCMessage.create)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'msgId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(8, _omitFieldNames ? '' : 'regComplete')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RPCMiddlewareRequest clone() => RPCMiddlewareRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RPCMiddlewareRequest copyWith(void Function(RPCMiddlewareRequest) updates) => super.copyWith((message) => updates(message as RPCMiddlewareRequest)) as RPCMiddlewareRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RPCMiddlewareRequest create() => RPCMiddlewareRequest._();
  RPCMiddlewareRequest createEmptyInstance() => create();
  static $pb.PbList<RPCMiddlewareRequest> createRepeated() => $pb.PbList<RPCMiddlewareRequest>();
  @$core.pragma('dart2js:noInline')
  static RPCMiddlewareRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RPCMiddlewareRequest>(create);
  static RPCMiddlewareRequest? _defaultInstance;

  RPCMiddlewareRequest_InterceptType whichInterceptType() => _RPCMiddlewareRequest_InterceptTypeByTag[$_whichOneof(0)]!;
  void clearInterceptType() => $_clearField($_whichOneof(0));

  ///
  /// The unique ID of the intercepted original gRPC request. Useful for mapping
  /// request to response when implementing full duplex message interception. For
  /// streaming requests, this will be the same ID for all incoming and outgoing
  /// middleware intercept messages of the _same_ stream.
  @$pb.TagNumber(1)
  $fixnum.Int64 get requestId => $_getI64(0);
  @$pb.TagNumber(1)
  set requestId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRequestId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequestId() => $_clearField(1);

  ///
  /// The raw bytes of the complete macaroon as sent by the gRPC client in the
  /// original request. This might be empty for a request that doesn't require
  /// macaroons such as the wallet unlocker RPCs.
  @$pb.TagNumber(2)
  $core.List<$core.int> get rawMacaroon => $_getN(1);
  @$pb.TagNumber(2)
  set rawMacaroon($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRawMacaroon() => $_has(1);
  @$pb.TagNumber(2)
  void clearRawMacaroon() => $_clearField(2);

  ///
  /// The parsed condition of the macaroon's custom caveat for convenient access.
  /// This field only contains the value of the custom caveat that the handling
  /// middleware has registered itself for. The condition _must_ be validated for
  /// messages of intercept_type stream_auth and request!
  @$pb.TagNumber(3)
  $core.String get customCaveatCondition => $_getSZ(2);
  @$pb.TagNumber(3)
  set customCaveatCondition($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCustomCaveatCondition() => $_has(2);
  @$pb.TagNumber(3)
  void clearCustomCaveatCondition() => $_clearField(3);

  ///
  /// Intercept stream authentication: each new streaming RPC call that is
  /// initiated against lnd and contains the middleware's custom macaroon
  /// caveat can be approved or denied based upon the macaroon in the stream
  /// header. This message will only be sent for streaming RPCs, unary RPCs
  /// must handle the macaroon authentication in the request interception to
  /// avoid an additional message round trip between lnd and the middleware.
  @$pb.TagNumber(4)
  StreamAuth get streamAuth => $_getN(3);
  @$pb.TagNumber(4)
  set streamAuth(StreamAuth v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStreamAuth() => $_has(3);
  @$pb.TagNumber(4)
  void clearStreamAuth() => $_clearField(4);
  @$pb.TagNumber(4)
  StreamAuth ensureStreamAuth() => $_ensure(3);

  ///
  /// Intercept incoming gRPC client request message: all incoming messages,
  /// both on streaming and unary RPCs, are forwarded to the middleware for
  /// inspection. For unary RPC messages the middleware is also expected to
  /// validate the custom macaroon caveat of the request.
  @$pb.TagNumber(5)
  RPCMessage get request => $_getN(4);
  @$pb.TagNumber(5)
  set request(RPCMessage v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRequest() => $_has(4);
  @$pb.TagNumber(5)
  void clearRequest() => $_clearField(5);
  @$pb.TagNumber(5)
  RPCMessage ensureRequest() => $_ensure(4);

  ///
  /// Intercept outgoing gRPC response message: all outgoing messages, both on
  /// streaming and unary RPCs, are forwarded to the middleware for inspection
  /// and amendment. The response in this message is the original response as
  /// it was generated by the main RPC server. It can either be accepted
  /// (=forwarded to the client), replaced/overwritten with a new message of
  /// the same type, or replaced by an error message.
  @$pb.TagNumber(6)
  RPCMessage get response => $_getN(5);
  @$pb.TagNumber(6)
  set response(RPCMessage v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasResponse() => $_has(5);
  @$pb.TagNumber(6)
  void clearResponse() => $_clearField(6);
  @$pb.TagNumber(6)
  RPCMessage ensureResponse() => $_ensure(5);

  ///
  /// The unique message ID of this middleware intercept message. There can be
  /// multiple middleware intercept messages per single gRPC request (one for the
  /// incoming request and one for the outgoing response) or gRPC stream (one for
  /// each incoming message and one for each outgoing response). This message ID
  /// must be referenced when responding (accepting/rejecting/modifying) to an
  /// intercept message.
  @$pb.TagNumber(7)
  $fixnum.Int64 get msgId => $_getI64(6);
  @$pb.TagNumber(7)
  set msgId($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMsgId() => $_has(6);
  @$pb.TagNumber(7)
  void clearMsgId() => $_clearField(7);

  ///
  /// This is used to indicate to the client that the server has successfully
  /// registered the interceptor. This is only used in the very first message
  /// that the server sends to the client after the client sends the server
  /// the middleware registration message.
  @$pb.TagNumber(8)
  $core.bool get regComplete => $_getBF(7);
  @$pb.TagNumber(8)
  set regComplete($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasRegComplete() => $_has(7);
  @$pb.TagNumber(8)
  void clearRegComplete() => $_clearField(8);
}

class StreamAuth extends $pb.GeneratedMessage {
  factory StreamAuth({
    $core.String? methodFullUri,
  }) {
    final $result = create();
    if (methodFullUri != null) {
      $result.methodFullUri = methodFullUri;
    }
    return $result;
  }
  StreamAuth._() : super();
  factory StreamAuth.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StreamAuth.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StreamAuth', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'methodFullUri')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StreamAuth clone() => StreamAuth()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StreamAuth copyWith(void Function(StreamAuth) updates) => super.copyWith((message) => updates(message as StreamAuth)) as StreamAuth;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StreamAuth create() => StreamAuth._();
  StreamAuth createEmptyInstance() => create();
  static $pb.PbList<StreamAuth> createRepeated() => $pb.PbList<StreamAuth>();
  @$core.pragma('dart2js:noInline')
  static StreamAuth getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StreamAuth>(create);
  static StreamAuth? _defaultInstance;

  ///
  /// The full URI (in the format /<rpcpackage>.<ServiceName>/MethodName, for
  /// example /lnrpc.Lightning/GetInfo) of the streaming RPC method that was just
  /// established.
  @$pb.TagNumber(1)
  $core.String get methodFullUri => $_getSZ(0);
  @$pb.TagNumber(1)
  set methodFullUri($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethodFullUri() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethodFullUri() => $_clearField(1);
}

class RPCMessage extends $pb.GeneratedMessage {
  factory RPCMessage({
    $core.String? methodFullUri,
    $core.bool? streamRpc,
    $core.String? typeName,
    $core.List<$core.int>? serialized,
    $core.bool? isError,
  }) {
    final $result = create();
    if (methodFullUri != null) {
      $result.methodFullUri = methodFullUri;
    }
    if (streamRpc != null) {
      $result.streamRpc = streamRpc;
    }
    if (typeName != null) {
      $result.typeName = typeName;
    }
    if (serialized != null) {
      $result.serialized = serialized;
    }
    if (isError != null) {
      $result.isError = isError;
    }
    return $result;
  }
  RPCMessage._() : super();
  factory RPCMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RPCMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RPCMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'methodFullUri')
    ..aOB(2, _omitFieldNames ? '' : 'streamRpc')
    ..aOS(3, _omitFieldNames ? '' : 'typeName')
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'serialized', $pb.PbFieldType.OY)
    ..aOB(5, _omitFieldNames ? '' : 'isError')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RPCMessage clone() => RPCMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RPCMessage copyWith(void Function(RPCMessage) updates) => super.copyWith((message) => updates(message as RPCMessage)) as RPCMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RPCMessage create() => RPCMessage._();
  RPCMessage createEmptyInstance() => create();
  static $pb.PbList<RPCMessage> createRepeated() => $pb.PbList<RPCMessage>();
  @$core.pragma('dart2js:noInline')
  static RPCMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RPCMessage>(create);
  static RPCMessage? _defaultInstance;

  ///
  /// The full URI (in the format /<rpcpackage>.<ServiceName>/MethodName, for
  /// example /lnrpc.Lightning/GetInfo) of the RPC method the message was sent
  /// to/from.
  @$pb.TagNumber(1)
  $core.String get methodFullUri => $_getSZ(0);
  @$pb.TagNumber(1)
  set methodFullUri($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMethodFullUri() => $_has(0);
  @$pb.TagNumber(1)
  void clearMethodFullUri() => $_clearField(1);

  ///
  /// Indicates whether the message was sent over a streaming RPC method or not.
  @$pb.TagNumber(2)
  $core.bool get streamRpc => $_getBF(1);
  @$pb.TagNumber(2)
  set streamRpc($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStreamRpc() => $_has(1);
  @$pb.TagNumber(2)
  void clearStreamRpc() => $_clearField(2);

  ///
  /// The full canonical gRPC name of the message type (in the format
  /// <rpcpackage>.TypeName, for example lnrpc.GetInfoRequest). In case of an
  /// error being returned from lnd, this simply contains the string "error".
  @$pb.TagNumber(3)
  $core.String get typeName => $_getSZ(2);
  @$pb.TagNumber(3)
  set typeName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTypeName() => $_has(2);
  @$pb.TagNumber(3)
  void clearTypeName() => $_clearField(3);

  ///
  /// The full content of the gRPC message, serialized in the binary protobuf
  /// format.
  @$pb.TagNumber(4)
  $core.List<$core.int> get serialized => $_getN(3);
  @$pb.TagNumber(4)
  set serialized($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSerialized() => $_has(3);
  @$pb.TagNumber(4)
  void clearSerialized() => $_clearField(4);

  ///
  /// Indicates that the response from lnd was an error, not a gRPC response. If
  /// this is set to true then the type_name contains the string "error" and
  /// serialized contains the error string.
  @$pb.TagNumber(5)
  $core.bool get isError => $_getBF(4);
  @$pb.TagNumber(5)
  set isError($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsError() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsError() => $_clearField(5);
}

enum RPCMiddlewareResponse_MiddlewareMessage {
  register, 
  feedback, 
  notSet
}

class RPCMiddlewareResponse extends $pb.GeneratedMessage {
  factory RPCMiddlewareResponse({
    $fixnum.Int64? refMsgId,
    MiddlewareRegistration? register,
    InterceptFeedback? feedback,
  }) {
    final $result = create();
    if (refMsgId != null) {
      $result.refMsgId = refMsgId;
    }
    if (register != null) {
      $result.register = register;
    }
    if (feedback != null) {
      $result.feedback = feedback;
    }
    return $result;
  }
  RPCMiddlewareResponse._() : super();
  factory RPCMiddlewareResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RPCMiddlewareResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, RPCMiddlewareResponse_MiddlewareMessage> _RPCMiddlewareResponse_MiddlewareMessageByTag = {
    2 : RPCMiddlewareResponse_MiddlewareMessage.register,
    3 : RPCMiddlewareResponse_MiddlewareMessage.feedback,
    0 : RPCMiddlewareResponse_MiddlewareMessage.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RPCMiddlewareResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'refMsgId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MiddlewareRegistration>(2, _omitFieldNames ? '' : 'register', subBuilder: MiddlewareRegistration.create)
    ..aOM<InterceptFeedback>(3, _omitFieldNames ? '' : 'feedback', subBuilder: InterceptFeedback.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RPCMiddlewareResponse clone() => RPCMiddlewareResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RPCMiddlewareResponse copyWith(void Function(RPCMiddlewareResponse) updates) => super.copyWith((message) => updates(message as RPCMiddlewareResponse)) as RPCMiddlewareResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RPCMiddlewareResponse create() => RPCMiddlewareResponse._();
  RPCMiddlewareResponse createEmptyInstance() => create();
  static $pb.PbList<RPCMiddlewareResponse> createRepeated() => $pb.PbList<RPCMiddlewareResponse>();
  @$core.pragma('dart2js:noInline')
  static RPCMiddlewareResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RPCMiddlewareResponse>(create);
  static RPCMiddlewareResponse? _defaultInstance;

  RPCMiddlewareResponse_MiddlewareMessage whichMiddlewareMessage() => _RPCMiddlewareResponse_MiddlewareMessageByTag[$_whichOneof(0)]!;
  void clearMiddlewareMessage() => $_clearField($_whichOneof(0));

  ///
  /// The request message ID this response refers to. Must always be set when
  /// giving feedback to an intercept but is ignored for the initial registration
  /// message.
  @$pb.TagNumber(1)
  $fixnum.Int64 get refMsgId => $_getI64(0);
  @$pb.TagNumber(1)
  set refMsgId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRefMsgId() => $_has(0);
  @$pb.TagNumber(1)
  void clearRefMsgId() => $_clearField(1);

  ///
  /// The registration message identifies the middleware that's being
  /// registered in lnd. The registration message must be sent immediately
  /// after initiating the RegisterRpcMiddleware stream, otherwise lnd will
  /// time out the attempt and terminate the request. NOTE: The middleware
  /// will only receive interception messages for requests that contain a
  /// macaroon with the custom caveat that the middleware declares it is
  /// responsible for handling in the registration message! As a security
  /// measure, _no_ middleware can intercept requests made with _unencumbered_
  /// macaroons!
  @$pb.TagNumber(2)
  MiddlewareRegistration get register => $_getN(1);
  @$pb.TagNumber(2)
  set register(MiddlewareRegistration v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRegister() => $_has(1);
  @$pb.TagNumber(2)
  void clearRegister() => $_clearField(2);
  @$pb.TagNumber(2)
  MiddlewareRegistration ensureRegister() => $_ensure(1);

  ///
  /// The middleware received an interception request and gives feedback to
  /// it. The request_id indicates what message the feedback refers to.
  @$pb.TagNumber(3)
  InterceptFeedback get feedback => $_getN(2);
  @$pb.TagNumber(3)
  set feedback(InterceptFeedback v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeedback() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeedback() => $_clearField(3);
  @$pb.TagNumber(3)
  InterceptFeedback ensureFeedback() => $_ensure(2);
}

class MiddlewareRegistration extends $pb.GeneratedMessage {
  factory MiddlewareRegistration({
    $core.String? middlewareName,
    $core.String? customMacaroonCaveatName,
    $core.bool? readOnlyMode,
  }) {
    final $result = create();
    if (middlewareName != null) {
      $result.middlewareName = middlewareName;
    }
    if (customMacaroonCaveatName != null) {
      $result.customMacaroonCaveatName = customMacaroonCaveatName;
    }
    if (readOnlyMode != null) {
      $result.readOnlyMode = readOnlyMode;
    }
    return $result;
  }
  MiddlewareRegistration._() : super();
  factory MiddlewareRegistration.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MiddlewareRegistration.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MiddlewareRegistration', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'middlewareName')
    ..aOS(2, _omitFieldNames ? '' : 'customMacaroonCaveatName')
    ..aOB(3, _omitFieldNames ? '' : 'readOnlyMode')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MiddlewareRegistration clone() => MiddlewareRegistration()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MiddlewareRegistration copyWith(void Function(MiddlewareRegistration) updates) => super.copyWith((message) => updates(message as MiddlewareRegistration)) as MiddlewareRegistration;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MiddlewareRegistration create() => MiddlewareRegistration._();
  MiddlewareRegistration createEmptyInstance() => create();
  static $pb.PbList<MiddlewareRegistration> createRepeated() => $pb.PbList<MiddlewareRegistration>();
  @$core.pragma('dart2js:noInline')
  static MiddlewareRegistration getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MiddlewareRegistration>(create);
  static MiddlewareRegistration? _defaultInstance;

  ///
  /// The name of the middleware to register. The name should be as informative
  /// as possible and is logged on registration.
  @$pb.TagNumber(1)
  $core.String get middlewareName => $_getSZ(0);
  @$pb.TagNumber(1)
  set middlewareName($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMiddlewareName() => $_has(0);
  @$pb.TagNumber(1)
  void clearMiddlewareName() => $_clearField(1);

  ///
  /// The name of the custom macaroon caveat that this middleware is responsible
  /// for. Only requests/responses that contain a macaroon with the registered
  /// custom caveat are forwarded for interception to the middleware. The
  /// exception being the read-only mode: All requests/responses are forwarded to
  /// a middleware that requests read-only access but such a middleware won't be
  /// allowed to _alter_ responses. As a security measure, _no_ middleware can
  /// change responses to requests made with _unencumbered_ macaroons!
  /// NOTE: Cannot be used at the same time as read_only_mode.
  @$pb.TagNumber(2)
  $core.String get customMacaroonCaveatName => $_getSZ(1);
  @$pb.TagNumber(2)
  set customMacaroonCaveatName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCustomMacaroonCaveatName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCustomMacaroonCaveatName() => $_clearField(2);

  ///
  /// Instead of defining a custom macaroon caveat name a middleware can register
  /// itself for read-only access only. In that mode all requests/responses are
  /// forwarded to the middleware but the middleware isn't allowed to alter any of
  /// the responses.
  /// NOTE: Cannot be used at the same time as custom_macaroon_caveat_name.
  @$pb.TagNumber(3)
  $core.bool get readOnlyMode => $_getBF(2);
  @$pb.TagNumber(3)
  set readOnlyMode($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReadOnlyMode() => $_has(2);
  @$pb.TagNumber(3)
  void clearReadOnlyMode() => $_clearField(3);
}

class InterceptFeedback extends $pb.GeneratedMessage {
  factory InterceptFeedback({
    $core.String? error,
    $core.bool? replaceResponse,
    $core.List<$core.int>? replacementSerialized,
  }) {
    final $result = create();
    if (error != null) {
      $result.error = error;
    }
    if (replaceResponse != null) {
      $result.replaceResponse = replaceResponse;
    }
    if (replacementSerialized != null) {
      $result.replacementSerialized = replacementSerialized;
    }
    return $result;
  }
  InterceptFeedback._() : super();
  factory InterceptFeedback.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InterceptFeedback.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InterceptFeedback', package: const $pb.PackageName(_omitMessageNames ? '' : 'lnrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'error')
    ..aOB(2, _omitFieldNames ? '' : 'replaceResponse')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'replacementSerialized', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InterceptFeedback clone() => InterceptFeedback()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InterceptFeedback copyWith(void Function(InterceptFeedback) updates) => super.copyWith((message) => updates(message as InterceptFeedback)) as InterceptFeedback;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InterceptFeedback create() => InterceptFeedback._();
  InterceptFeedback createEmptyInstance() => create();
  static $pb.PbList<InterceptFeedback> createRepeated() => $pb.PbList<InterceptFeedback>();
  @$core.pragma('dart2js:noInline')
  static InterceptFeedback getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InterceptFeedback>(create);
  static InterceptFeedback? _defaultInstance;

  ///
  /// The error to return to the user. If this is non-empty, the incoming gRPC
  /// stream/request is aborted and the error is returned to the gRPC client. If
  /// this value is empty, it means the middleware accepts the stream/request/
  /// response and the processing of it can continue.
  @$pb.TagNumber(1)
  $core.String get error => $_getSZ(0);
  @$pb.TagNumber(1)
  set error($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasError() => $_has(0);
  @$pb.TagNumber(1)
  void clearError() => $_clearField(1);

  ///
  /// A boolean indicating that the gRPC message should be replaced/overwritten.
  /// This boolean is needed because in protobuf an empty message is serialized as
  /// a 0-length or nil byte slice and we wouldn't be able to distinguish between
  /// an empty replacement message and the "don't replace anything" case.
  @$pb.TagNumber(2)
  $core.bool get replaceResponse => $_getBF(1);
  @$pb.TagNumber(2)
  set replaceResponse($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasReplaceResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearReplaceResponse() => $_clearField(2);

  ///
  /// If the replace_response field is set to true, this field must contain the
  /// binary serialized gRPC message in the protobuf format.
  @$pb.TagNumber(3)
  $core.List<$core.int> get replacementSerialized => $_getN(2);
  @$pb.TagNumber(3)
  set replacementSerialized($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasReplacementSerialized() => $_has(2);
  @$pb.TagNumber(3)
  void clearReplacementSerialized() => $_clearField(3);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
