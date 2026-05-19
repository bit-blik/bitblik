//
//  Generated code. Do not modify.
//  source: lnd/router.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'lightning.pb.dart' as $1;
import 'lightning.pbenum.dart' as $1;
import 'router.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'router.pbenum.dart';

class SendPaymentRequest extends $pb.GeneratedMessage {
  factory SendPaymentRequest({
    $core.List<$core.int>? dest,
    $fixnum.Int64? amt,
    $core.List<$core.int>? paymentHash,
    $core.int? finalCltvDelta,
    $core.String? paymentRequest,
    $core.int? timeoutSeconds,
    $fixnum.Int64? feeLimitSat,
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? outgoingChanId,
    $core.int? cltvLimit,
    $core.Iterable<$1.RouteHint>? routeHints,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? destCustomRecords,
    $fixnum.Int64? amtMsat,
    $fixnum.Int64? feeLimitMsat,
    $core.List<$core.int>? lastHopPubkey,
    $core.bool? allowSelfPayment,
    $core.Iterable<$1.FeatureBit>? destFeatures,
    $core.int? maxParts,
    $core.bool? noInflightUpdates,
    $core.Iterable<$fixnum.Int64>? outgoingChanIds,
    $core.List<$core.int>? paymentAddr,
    $fixnum.Int64? maxShardSizeMsat,
    $core.bool? amp,
    $core.double? timePref,
    $core.bool? cancelable,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? firstHopCustomRecords,
  }) {
    final $result = create();
    if (dest != null) {
      $result.dest = dest;
    }
    if (amt != null) {
      $result.amt = amt;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (finalCltvDelta != null) {
      $result.finalCltvDelta = finalCltvDelta;
    }
    if (paymentRequest != null) {
      $result.paymentRequest = paymentRequest;
    }
    if (timeoutSeconds != null) {
      $result.timeoutSeconds = timeoutSeconds;
    }
    if (feeLimitSat != null) {
      $result.feeLimitSat = feeLimitSat;
    }
    if (outgoingChanId != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.outgoingChanId = outgoingChanId;
    }
    if (cltvLimit != null) {
      $result.cltvLimit = cltvLimit;
    }
    if (routeHints != null) {
      $result.routeHints.addAll(routeHints);
    }
    if (destCustomRecords != null) {
      $result.destCustomRecords.addAll(destCustomRecords);
    }
    if (amtMsat != null) {
      $result.amtMsat = amtMsat;
    }
    if (feeLimitMsat != null) {
      $result.feeLimitMsat = feeLimitMsat;
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
    if (maxParts != null) {
      $result.maxParts = maxParts;
    }
    if (noInflightUpdates != null) {
      $result.noInflightUpdates = noInflightUpdates;
    }
    if (outgoingChanIds != null) {
      $result.outgoingChanIds.addAll(outgoingChanIds);
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    if (maxShardSizeMsat != null) {
      $result.maxShardSizeMsat = maxShardSizeMsat;
    }
    if (amp != null) {
      $result.amp = amp;
    }
    if (timePref != null) {
      $result.timePref = timePref;
    }
    if (cancelable != null) {
      $result.cancelable = cancelable;
    }
    if (firstHopCustomRecords != null) {
      $result.firstHopCustomRecords.addAll(firstHopCustomRecords);
    }
    return $result;
  }
  SendPaymentRequest._() : super();
  factory SendPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendPaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'dest', $pb.PbFieldType.OY)
    ..aInt64(2, _omitFieldNames ? '' : 'amt')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'finalCltvDelta', $pb.PbFieldType.O3)
    ..aOS(5, _omitFieldNames ? '' : 'paymentRequest')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'timeoutSeconds', $pb.PbFieldType.O3)
    ..aInt64(7, _omitFieldNames ? '' : 'feeLimitSat')
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'outgoingChanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(9, _omitFieldNames ? '' : 'cltvLimit', $pb.PbFieldType.O3)
    ..pc<$1.RouteHint>(10, _omitFieldNames ? '' : 'routeHints', $pb.PbFieldType.PM, subBuilder: $1.RouteHint.create)
    ..m<$fixnum.Int64, $core.List<$core.int>>(11, _omitFieldNames ? '' : 'destCustomRecords', entryClassName: 'SendPaymentRequest.DestCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
    ..aInt64(12, _omitFieldNames ? '' : 'amtMsat')
    ..aInt64(13, _omitFieldNames ? '' : 'feeLimitMsat')
    ..a<$core.List<$core.int>>(14, _omitFieldNames ? '' : 'lastHopPubkey', $pb.PbFieldType.OY)
    ..aOB(15, _omitFieldNames ? '' : 'allowSelfPayment')
    ..pc<$1.FeatureBit>(16, _omitFieldNames ? '' : 'destFeatures', $pb.PbFieldType.KE, valueOf: $1.FeatureBit.valueOf, enumValues: $1.FeatureBit.values, defaultEnumValue: $1.FeatureBit.DATALOSS_PROTECT_REQ)
    ..a<$core.int>(17, _omitFieldNames ? '' : 'maxParts', $pb.PbFieldType.OU3)
    ..aOB(18, _omitFieldNames ? '' : 'noInflightUpdates')
    ..p<$fixnum.Int64>(19, _omitFieldNames ? '' : 'outgoingChanIds', $pb.PbFieldType.KU6)
    ..a<$core.List<$core.int>>(20, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(21, _omitFieldNames ? '' : 'maxShardSizeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(22, _omitFieldNames ? '' : 'amp')
    ..a<$core.double>(23, _omitFieldNames ? '' : 'timePref', $pb.PbFieldType.OD)
    ..aOB(24, _omitFieldNames ? '' : 'cancelable')
    ..m<$fixnum.Int64, $core.List<$core.int>>(25, _omitFieldNames ? '' : 'firstHopCustomRecords', entryClassName: 'SendPaymentRequest.FirstHopCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendPaymentRequest clone() => SendPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendPaymentRequest copyWith(void Function(SendPaymentRequest) updates) => super.copyWith((message) => updates(message as SendPaymentRequest)) as SendPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendPaymentRequest create() => SendPaymentRequest._();
  SendPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<SendPaymentRequest> createRepeated() => $pb.PbList<SendPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static SendPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendPaymentRequest>(create);
  static SendPaymentRequest? _defaultInstance;

  /// The identity pubkey of the payment recipient
  @$pb.TagNumber(1)
  $core.List<$core.int> get dest => $_getN(0);
  @$pb.TagNumber(1)
  set dest($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDest() => $_has(0);
  @$pb.TagNumber(1)
  void clearDest() => $_clearField(1);

  ///
  /// Number of satoshis to send.
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

  /// The hash to use within the payment's HTLC
  @$pb.TagNumber(3)
  $core.List<$core.int> get paymentHash => $_getN(2);
  @$pb.TagNumber(3)
  set paymentHash($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentHash() => $_clearField(3);

  ///
  /// The CLTV delta from the current height that should be used to set the
  /// timelock for the final hop.
  @$pb.TagNumber(4)
  $core.int get finalCltvDelta => $_getIZ(3);
  @$pb.TagNumber(4)
  set finalCltvDelta($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFinalCltvDelta() => $_has(3);
  @$pb.TagNumber(4)
  void clearFinalCltvDelta() => $_clearField(4);

  ///
  /// A bare-bones invoice for a payment within the Lightning Network.  With the
  /// details of the invoice, the sender has all the data necessary to send a
  /// payment to the recipient. The amount in the payment request may be zero. In
  /// that case it is required to set the amt field as well. If no payment request
  /// is specified, the following fields are required: dest, amt and payment_hash.
  @$pb.TagNumber(5)
  $core.String get paymentRequest => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentRequest($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentRequest() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentRequest() => $_clearField(5);

  ///
  /// An optional limit, expressed in seconds, on the time to wait before
  /// attempting the first HTLC. Once HTLCs are in flight, the payment will
  /// not be aborted until the HTLCs are either settled or failed. If the field
  /// is not set or is explicitly set to zero, the default value of 60 seconds
  /// will be applied.
  @$pb.TagNumber(6)
  $core.int get timeoutSeconds => $_getIZ(5);
  @$pb.TagNumber(6)
  set timeoutSeconds($core.int v) { $_setSignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasTimeoutSeconds() => $_has(5);
  @$pb.TagNumber(6)
  void clearTimeoutSeconds() => $_clearField(6);

  ///
  /// The maximum number of satoshis that will be paid as a fee of the payment.
  /// If this field is left to the default value of 0, only zero-fee routes will
  /// be considered. This usually means single hop routes connecting directly to
  /// the destination. To send the payment without a fee limit, use max int here.
  ///
  /// The fields fee_limit_sat and fee_limit_msat are mutually exclusive.
  @$pb.TagNumber(7)
  $fixnum.Int64 get feeLimitSat => $_getI64(6);
  @$pb.TagNumber(7)
  set feeLimitSat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFeeLimitSat() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeeLimitSat() => $_clearField(7);

  ///
  /// Deprecated, use outgoing_chan_ids. The channel id of the channel that must
  /// be taken to the first hop. If zero, any channel may be used (unless
  /// outgoing_chan_ids are set).
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  $fixnum.Int64 get outgoingChanId => $_getI64(7);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  set outgoingChanId($fixnum.Int64 v) { $_setInt64(7, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  $core.bool hasOutgoingChanId() => $_has(7);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(8)
  void clearOutgoingChanId() => $_clearField(8);

  ///
  /// An optional maximum total time lock for the route. This should not
  /// exceed lnd's `--max-cltv-expiry` setting. If zero, then the value of
  /// `--max-cltv-expiry` is enforced.
  @$pb.TagNumber(9)
  $core.int get cltvLimit => $_getIZ(8);
  @$pb.TagNumber(9)
  set cltvLimit($core.int v) { $_setSignedInt32(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasCltvLimit() => $_has(8);
  @$pb.TagNumber(9)
  void clearCltvLimit() => $_clearField(9);

  ///
  /// Optional route hints to reach the destination through private channels.
  @$pb.TagNumber(10)
  $pb.PbList<$1.RouteHint> get routeHints => $_getList(9);

  ///
  /// An optional field that can be used to pass an arbitrary set of TLV records
  /// to a peer which understands the new records. This can be used to pass
  /// application specific data during the payment attempt. Record types are
  /// required to be in the custom range >= 65536. When using REST, the values
  /// must be encoded as base64.
  @$pb.TagNumber(11)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get destCustomRecords => $_getMap(10);

  ///
  /// Number of millisatoshis to send.
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
  /// The maximum number of millisatoshis that will be paid as a fee of the
  /// payment. If this field is left to the default value of 0, only zero-fee
  /// routes will be considered. This usually means single hop routes connecting
  /// directly to the destination. To send the payment without a fee limit, use
  /// max int here.
  ///
  /// The fields fee_limit_sat and fee_limit_msat are mutually exclusive.
  @$pb.TagNumber(13)
  $fixnum.Int64 get feeLimitMsat => $_getI64(12);
  @$pb.TagNumber(13)
  set feeLimitMsat($fixnum.Int64 v) { $_setInt64(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasFeeLimitMsat() => $_has(12);
  @$pb.TagNumber(13)
  void clearFeeLimitMsat() => $_clearField(13);

  ///
  /// The pubkey of the last hop of the route. If empty, any hop may be used.
  @$pb.TagNumber(14)
  $core.List<$core.int> get lastHopPubkey => $_getN(13);
  @$pb.TagNumber(14)
  set lastHopPubkey($core.List<$core.int> v) { $_setBytes(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasLastHopPubkey() => $_has(13);
  @$pb.TagNumber(14)
  void clearLastHopPubkey() => $_clearField(14);

  /// If set, circular payments to self are permitted.
  @$pb.TagNumber(15)
  $core.bool get allowSelfPayment => $_getBF(14);
  @$pb.TagNumber(15)
  set allowSelfPayment($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasAllowSelfPayment() => $_has(14);
  @$pb.TagNumber(15)
  void clearAllowSelfPayment() => $_clearField(15);

  ///
  /// Features assumed to be supported by the final node. All transitive feature
  /// dependencies must also be set properly. For a given feature bit pair, either
  /// optional or remote may be set, but not both. If this field is nil or empty,
  /// the router will try to load destination features from the graph as a
  /// fallback.
  @$pb.TagNumber(16)
  $pb.PbList<$1.FeatureBit> get destFeatures => $_getList(15);

  ///
  /// The maximum number of partial payments that may be use to complete the full
  /// amount.
  @$pb.TagNumber(17)
  $core.int get maxParts => $_getIZ(16);
  @$pb.TagNumber(17)
  set maxParts($core.int v) { $_setUnsignedInt32(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasMaxParts() => $_has(16);
  @$pb.TagNumber(17)
  void clearMaxParts() => $_clearField(17);

  ///
  /// If set, only the final payment update is streamed back. Intermediate updates
  /// that show which htlcs are still in flight are suppressed.
  @$pb.TagNumber(18)
  $core.bool get noInflightUpdates => $_getBF(17);
  @$pb.TagNumber(18)
  set noInflightUpdates($core.bool v) { $_setBool(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNoInflightUpdates() => $_has(17);
  @$pb.TagNumber(18)
  void clearNoInflightUpdates() => $_clearField(18);

  ///
  /// The channel ids of the channels are allowed for the first hop. If empty,
  /// any channel may be used.
  @$pb.TagNumber(19)
  $pb.PbList<$fixnum.Int64> get outgoingChanIds => $_getList(18);

  ///
  /// An optional payment addr to be included within the last hop of the route.
  /// This is also called payment secret in specifications (e.g. BOLT 11).
  @$pb.TagNumber(20)
  $core.List<$core.int> get paymentAddr => $_getN(19);
  @$pb.TagNumber(20)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasPaymentAddr() => $_has(19);
  @$pb.TagNumber(20)
  void clearPaymentAddr() => $_clearField(20);

  ///
  /// The largest payment split that should be attempted when making a payment if
  /// splitting is necessary. Setting this value will effectively cause lnd to
  /// split more aggressively, vs only when it thinks it needs to. Note that this
  /// value is in milli-satoshis.
  @$pb.TagNumber(21)
  $fixnum.Int64 get maxShardSizeMsat => $_getI64(20);
  @$pb.TagNumber(21)
  set maxShardSizeMsat($fixnum.Int64 v) { $_setInt64(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasMaxShardSizeMsat() => $_has(20);
  @$pb.TagNumber(21)
  void clearMaxShardSizeMsat() => $_clearField(21);

  ///
  /// If set, an AMP-payment will be attempted.
  @$pb.TagNumber(22)
  $core.bool get amp => $_getBF(21);
  @$pb.TagNumber(22)
  set amp($core.bool v) { $_setBool(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasAmp() => $_has(21);
  @$pb.TagNumber(22)
  void clearAmp() => $_clearField(22);

  ///
  /// The time preference for this payment. Set to -1 to optimize for fees
  /// only, to 1 to optimize for reliability only or a value inbetween for a mix.
  @$pb.TagNumber(23)
  $core.double get timePref => $_getN(22);
  @$pb.TagNumber(23)
  set timePref($core.double v) { $_setDouble(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasTimePref() => $_has(22);
  @$pb.TagNumber(23)
  void clearTimePref() => $_clearField(23);

  ///
  /// If set, the payment loop can be interrupted by manually canceling the
  /// payment context, even before the payment timeout is reached. Note that the
  /// payment may still succeed after cancellation, as in-flight attempts can
  /// still settle afterwards. Canceling will only prevent further attempts from
  /// being sent.
  @$pb.TagNumber(24)
  $core.bool get cancelable => $_getBF(23);
  @$pb.TagNumber(24)
  set cancelable($core.bool v) { $_setBool(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasCancelable() => $_has(23);
  @$pb.TagNumber(24)
  void clearCancelable() => $_clearField(24);

  ///
  /// An optional field that can be used to pass an arbitrary set of TLV records
  /// to the first hop peer of this payment. This can be used to pass application
  /// specific data during the payment attempt. Record types are required to be in
  /// the custom range >= 65536. When using REST, the values must be encoded as
  /// base64.
  @$pb.TagNumber(25)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get firstHopCustomRecords => $_getMap(24);
}

class TrackPaymentRequest extends $pb.GeneratedMessage {
  factory TrackPaymentRequest({
    $core.List<$core.int>? paymentHash,
    $core.bool? noInflightUpdates,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (noInflightUpdates != null) {
      $result.noInflightUpdates = noInflightUpdates;
    }
    return $result;
  }
  TrackPaymentRequest._() : super();
  factory TrackPaymentRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TrackPaymentRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TrackPaymentRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'noInflightUpdates')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TrackPaymentRequest clone() => TrackPaymentRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TrackPaymentRequest copyWith(void Function(TrackPaymentRequest) updates) => super.copyWith((message) => updates(message as TrackPaymentRequest)) as TrackPaymentRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackPaymentRequest create() => TrackPaymentRequest._();
  TrackPaymentRequest createEmptyInstance() => create();
  static $pb.PbList<TrackPaymentRequest> createRepeated() => $pb.PbList<TrackPaymentRequest>();
  @$core.pragma('dart2js:noInline')
  static TrackPaymentRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackPaymentRequest>(create);
  static TrackPaymentRequest? _defaultInstance;

  /// The hash of the payment to look up.
  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  ///
  /// If set, only the final payment update is streamed back. Intermediate updates
  /// that show which htlcs are still in flight are suppressed.
  @$pb.TagNumber(2)
  $core.bool get noInflightUpdates => $_getBF(1);
  @$pb.TagNumber(2)
  set noInflightUpdates($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNoInflightUpdates() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoInflightUpdates() => $_clearField(2);
}

class TrackPaymentsRequest extends $pb.GeneratedMessage {
  factory TrackPaymentsRequest({
    $core.bool? noInflightUpdates,
  }) {
    final $result = create();
    if (noInflightUpdates != null) {
      $result.noInflightUpdates = noInflightUpdates;
    }
    return $result;
  }
  TrackPaymentsRequest._() : super();
  factory TrackPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TrackPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TrackPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'noInflightUpdates')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TrackPaymentsRequest clone() => TrackPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TrackPaymentsRequest copyWith(void Function(TrackPaymentsRequest) updates) => super.copyWith((message) => updates(message as TrackPaymentsRequest)) as TrackPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TrackPaymentsRequest create() => TrackPaymentsRequest._();
  TrackPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<TrackPaymentsRequest> createRepeated() => $pb.PbList<TrackPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static TrackPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TrackPaymentsRequest>(create);
  static TrackPaymentsRequest? _defaultInstance;

  ///
  /// If set, only the final payment updates are streamed back. Intermediate
  /// updates that show which htlcs are still in flight are suppressed.
  @$pb.TagNumber(1)
  $core.bool get noInflightUpdates => $_getBF(0);
  @$pb.TagNumber(1)
  set noInflightUpdates($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNoInflightUpdates() => $_has(0);
  @$pb.TagNumber(1)
  void clearNoInflightUpdates() => $_clearField(1);
}

class RouteFeeRequest extends $pb.GeneratedMessage {
  factory RouteFeeRequest({
    $core.List<$core.int>? dest,
    $fixnum.Int64? amtSat,
    $core.String? paymentRequest,
    $core.int? timeout,
  }) {
    final $result = create();
    if (dest != null) {
      $result.dest = dest;
    }
    if (amtSat != null) {
      $result.amtSat = amtSat;
    }
    if (paymentRequest != null) {
      $result.paymentRequest = paymentRequest;
    }
    if (timeout != null) {
      $result.timeout = timeout;
    }
    return $result;
  }
  RouteFeeRequest._() : super();
  factory RouteFeeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteFeeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RouteFeeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'dest', $pb.PbFieldType.OY)
    ..aInt64(2, _omitFieldNames ? '' : 'amtSat')
    ..aOS(3, _omitFieldNames ? '' : 'paymentRequest')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'timeout', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteFeeRequest clone() => RouteFeeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteFeeRequest copyWith(void Function(RouteFeeRequest) updates) => super.copyWith((message) => updates(message as RouteFeeRequest)) as RouteFeeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteFeeRequest create() => RouteFeeRequest._();
  RouteFeeRequest createEmptyInstance() => create();
  static $pb.PbList<RouteFeeRequest> createRepeated() => $pb.PbList<RouteFeeRequest>();
  @$core.pragma('dart2js:noInline')
  static RouteFeeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteFeeRequest>(create);
  static RouteFeeRequest? _defaultInstance;

  ///
  /// The destination one wishes to obtain a routing fee quote to. If set, this
  /// parameter requires the amt_sat parameter also to be set. This parameter
  /// combination triggers a graph based routing fee estimation as opposed to a
  /// payment probe based estimate in case a payment request is provided. The
  /// graph based estimation is an algorithm that is executed on the in memory
  /// graph. Hence its runtime is significantly shorter than a payment probe
  /// estimation that sends out actual payments to the network.
  @$pb.TagNumber(1)
  $core.List<$core.int> get dest => $_getN(0);
  @$pb.TagNumber(1)
  set dest($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDest() => $_has(0);
  @$pb.TagNumber(1)
  void clearDest() => $_clearField(1);

  ///
  /// The amount one wishes to send to the target destination. It is only to be
  /// used in combination with the dest parameter.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amtSat => $_getI64(1);
  @$pb.TagNumber(2)
  set amtSat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmtSat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmtSat() => $_clearField(2);

  ///
  /// A payment request of the target node that the route fee request is intended
  /// for. Its parameters are input to probe payments that estimate routing fees.
  /// The timeout parameter can be specified to set a maximum time on the probing
  /// attempt. Cannot be used in combination with dest and amt_sat.
  @$pb.TagNumber(3)
  $core.String get paymentRequest => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentRequest($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentRequest() => $_clearField(3);

  ///
  /// A user preference of how long a probe payment should maximally be allowed to
  /// take, denoted in seconds. The probing payment loop is aborted if this
  /// timeout is reached. Note that the probing process itself can take longer
  /// than the timeout if the HTLC becomes delayed or stuck. Canceling the context
  /// of this call will not cancel the payment loop, the duration is only
  /// controlled by the timeout parameter.
  @$pb.TagNumber(4)
  $core.int get timeout => $_getIZ(3);
  @$pb.TagNumber(4)
  set timeout($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimeout() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimeout() => $_clearField(4);
}

class RouteFeeResponse extends $pb.GeneratedMessage {
  factory RouteFeeResponse({
    $fixnum.Int64? routingFeeMsat,
    $fixnum.Int64? timeLockDelay,
    $1.PaymentFailureReason? failureReason,
  }) {
    final $result = create();
    if (routingFeeMsat != null) {
      $result.routingFeeMsat = routingFeeMsat;
    }
    if (timeLockDelay != null) {
      $result.timeLockDelay = timeLockDelay;
    }
    if (failureReason != null) {
      $result.failureReason = failureReason;
    }
    return $result;
  }
  RouteFeeResponse._() : super();
  factory RouteFeeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteFeeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RouteFeeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'routingFeeMsat')
    ..aInt64(2, _omitFieldNames ? '' : 'timeLockDelay')
    ..e<$1.PaymentFailureReason>(5, _omitFieldNames ? '' : 'failureReason', $pb.PbFieldType.OE, defaultOrMaker: $1.PaymentFailureReason.FAILURE_REASON_NONE, valueOf: $1.PaymentFailureReason.valueOf, enumValues: $1.PaymentFailureReason.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteFeeResponse clone() => RouteFeeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteFeeResponse copyWith(void Function(RouteFeeResponse) updates) => super.copyWith((message) => updates(message as RouteFeeResponse)) as RouteFeeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteFeeResponse create() => RouteFeeResponse._();
  RouteFeeResponse createEmptyInstance() => create();
  static $pb.PbList<RouteFeeResponse> createRepeated() => $pb.PbList<RouteFeeResponse>();
  @$core.pragma('dart2js:noInline')
  static RouteFeeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteFeeResponse>(create);
  static RouteFeeResponse? _defaultInstance;

  ///
  /// A lower bound of the estimated fee to the target destination within the
  /// network, expressed in milli-satoshis.
  @$pb.TagNumber(1)
  $fixnum.Int64 get routingFeeMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set routingFeeMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoutingFeeMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoutingFeeMsat() => $_clearField(1);

  ///
  /// An estimate of the worst case time delay that can occur. Note that callers
  /// will still need to factor in the final CLTV delta of the last hop into this
  /// value.
  @$pb.TagNumber(2)
  $fixnum.Int64 get timeLockDelay => $_getI64(1);
  @$pb.TagNumber(2)
  set timeLockDelay($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTimeLockDelay() => $_has(1);
  @$pb.TagNumber(2)
  void clearTimeLockDelay() => $_clearField(2);

  ///
  /// An indication whether a probing payment succeeded or whether and why it
  /// failed. FAILURE_REASON_NONE indicates success.
  @$pb.TagNumber(5)
  $1.PaymentFailureReason get failureReason => $_getN(2);
  @$pb.TagNumber(5)
  set failureReason($1.PaymentFailureReason v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFailureReason() => $_has(2);
  @$pb.TagNumber(5)
  void clearFailureReason() => $_clearField(5);
}

class SendToRouteRequest extends $pb.GeneratedMessage {
  factory SendToRouteRequest({
    $core.List<$core.int>? paymentHash,
    $1.Route? route,
    $core.bool? skipTempErr,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? firstHopCustomRecords,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (route != null) {
      $result.route = route;
    }
    if (skipTempErr != null) {
      $result.skipTempErr = skipTempErr;
    }
    if (firstHopCustomRecords != null) {
      $result.firstHopCustomRecords.addAll(firstHopCustomRecords);
    }
    return $result;
  }
  SendToRouteRequest._() : super();
  factory SendToRouteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendToRouteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendToRouteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..aOM<$1.Route>(2, _omitFieldNames ? '' : 'route', subBuilder: $1.Route.create)
    ..aOB(3, _omitFieldNames ? '' : 'skipTempErr')
    ..m<$fixnum.Int64, $core.List<$core.int>>(4, _omitFieldNames ? '' : 'firstHopCustomRecords', entryClassName: 'SendToRouteRequest.FirstHopCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
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

  /// The payment hash to use for the HTLC.
  @$pb.TagNumber(1)
  $core.List<$core.int> get paymentHash => $_getN(0);
  @$pb.TagNumber(1)
  set paymentHash($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  /// Route that should be used to attempt to complete the payment.
  @$pb.TagNumber(2)
  $1.Route get route => $_getN(1);
  @$pb.TagNumber(2)
  set route($1.Route v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoute() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoute() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Route ensureRoute() => $_ensure(1);

  ///
  /// Whether the payment should be marked as failed when a temporary error is
  /// returned from the given route. Set it to true so the payment won't be
  /// failed unless a terminal error is occurred, such as payment timeout, no
  /// routes, incorrect payment details, or insufficient funds.
  @$pb.TagNumber(3)
  $core.bool get skipTempErr => $_getBF(2);
  @$pb.TagNumber(3)
  set skipTempErr($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSkipTempErr() => $_has(2);
  @$pb.TagNumber(3)
  void clearSkipTempErr() => $_clearField(3);

  ///
  /// An optional field that can be used to pass an arbitrary set of TLV records
  /// to the first hop peer of this payment. This can be used to pass application
  /// specific data during the payment attempt. Record types are required to be in
  /// the custom range >= 65536. When using REST, the values must be encoded as
  /// base64.
  @$pb.TagNumber(4)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get firstHopCustomRecords => $_getMap(3);
}

class SendToRouteResponse extends $pb.GeneratedMessage {
  factory SendToRouteResponse({
    $core.List<$core.int>? preimage,
    $1.Failure? failure,
  }) {
    final $result = create();
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (failure != null) {
      $result.failure = failure;
    }
    return $result;
  }
  SendToRouteResponse._() : super();
  factory SendToRouteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SendToRouteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SendToRouteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..aOM<$1.Failure>(2, _omitFieldNames ? '' : 'failure', subBuilder: $1.Failure.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SendToRouteResponse clone() => SendToRouteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SendToRouteResponse copyWith(void Function(SendToRouteResponse) updates) => super.copyWith((message) => updates(message as SendToRouteResponse)) as SendToRouteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SendToRouteResponse create() => SendToRouteResponse._();
  SendToRouteResponse createEmptyInstance() => create();
  static $pb.PbList<SendToRouteResponse> createRepeated() => $pb.PbList<SendToRouteResponse>();
  @$core.pragma('dart2js:noInline')
  static SendToRouteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendToRouteResponse>(create);
  static SendToRouteResponse? _defaultInstance;

  /// The preimage obtained by making the payment.
  @$pb.TagNumber(1)
  $core.List<$core.int> get preimage => $_getN(0);
  @$pb.TagNumber(1)
  set preimage($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPreimage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreimage() => $_clearField(1);

  /// The failure message in case the payment failed.
  @$pb.TagNumber(2)
  $1.Failure get failure => $_getN(1);
  @$pb.TagNumber(2)
  set failure($1.Failure v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailure() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Failure ensureFailure() => $_ensure(1);
}

class ResetMissionControlRequest extends $pb.GeneratedMessage {
  factory ResetMissionControlRequest() => create();
  ResetMissionControlRequest._() : super();
  factory ResetMissionControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetMissionControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResetMissionControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetMissionControlRequest clone() => ResetMissionControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetMissionControlRequest copyWith(void Function(ResetMissionControlRequest) updates) => super.copyWith((message) => updates(message as ResetMissionControlRequest)) as ResetMissionControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetMissionControlRequest create() => ResetMissionControlRequest._();
  ResetMissionControlRequest createEmptyInstance() => create();
  static $pb.PbList<ResetMissionControlRequest> createRepeated() => $pb.PbList<ResetMissionControlRequest>();
  @$core.pragma('dart2js:noInline')
  static ResetMissionControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetMissionControlRequest>(create);
  static ResetMissionControlRequest? _defaultInstance;
}

class ResetMissionControlResponse extends $pb.GeneratedMessage {
  factory ResetMissionControlResponse() => create();
  ResetMissionControlResponse._() : super();
  factory ResetMissionControlResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResetMissionControlResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResetMissionControlResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResetMissionControlResponse clone() => ResetMissionControlResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResetMissionControlResponse copyWith(void Function(ResetMissionControlResponse) updates) => super.copyWith((message) => updates(message as ResetMissionControlResponse)) as ResetMissionControlResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResetMissionControlResponse create() => ResetMissionControlResponse._();
  ResetMissionControlResponse createEmptyInstance() => create();
  static $pb.PbList<ResetMissionControlResponse> createRepeated() => $pb.PbList<ResetMissionControlResponse>();
  @$core.pragma('dart2js:noInline')
  static ResetMissionControlResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResetMissionControlResponse>(create);
  static ResetMissionControlResponse? _defaultInstance;
}

class QueryMissionControlRequest extends $pb.GeneratedMessage {
  factory QueryMissionControlRequest() => create();
  QueryMissionControlRequest._() : super();
  factory QueryMissionControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryMissionControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryMissionControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryMissionControlRequest clone() => QueryMissionControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryMissionControlRequest copyWith(void Function(QueryMissionControlRequest) updates) => super.copyWith((message) => updates(message as QueryMissionControlRequest)) as QueryMissionControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryMissionControlRequest create() => QueryMissionControlRequest._();
  QueryMissionControlRequest createEmptyInstance() => create();
  static $pb.PbList<QueryMissionControlRequest> createRepeated() => $pb.PbList<QueryMissionControlRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryMissionControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryMissionControlRequest>(create);
  static QueryMissionControlRequest? _defaultInstance;
}

/// QueryMissionControlResponse contains mission control state.
class QueryMissionControlResponse extends $pb.GeneratedMessage {
  factory QueryMissionControlResponse({
    $core.Iterable<PairHistory>? pairs,
  }) {
    final $result = create();
    if (pairs != null) {
      $result.pairs.addAll(pairs);
    }
    return $result;
  }
  QueryMissionControlResponse._() : super();
  factory QueryMissionControlResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryMissionControlResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryMissionControlResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..pc<PairHistory>(2, _omitFieldNames ? '' : 'pairs', $pb.PbFieldType.PM, subBuilder: PairHistory.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryMissionControlResponse clone() => QueryMissionControlResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryMissionControlResponse copyWith(void Function(QueryMissionControlResponse) updates) => super.copyWith((message) => updates(message as QueryMissionControlResponse)) as QueryMissionControlResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryMissionControlResponse create() => QueryMissionControlResponse._();
  QueryMissionControlResponse createEmptyInstance() => create();
  static $pb.PbList<QueryMissionControlResponse> createRepeated() => $pb.PbList<QueryMissionControlResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryMissionControlResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryMissionControlResponse>(create);
  static QueryMissionControlResponse? _defaultInstance;

  /// Node pair-level mission control state.
  @$pb.TagNumber(2)
  $pb.PbList<PairHistory> get pairs => $_getList(0);
}

class XImportMissionControlRequest extends $pb.GeneratedMessage {
  factory XImportMissionControlRequest({
    $core.Iterable<PairHistory>? pairs,
    $core.bool? force,
  }) {
    final $result = create();
    if (pairs != null) {
      $result.pairs.addAll(pairs);
    }
    if (force != null) {
      $result.force = force;
    }
    return $result;
  }
  XImportMissionControlRequest._() : super();
  factory XImportMissionControlRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory XImportMissionControlRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'XImportMissionControlRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..pc<PairHistory>(1, _omitFieldNames ? '' : 'pairs', $pb.PbFieldType.PM, subBuilder: PairHistory.create)
    ..aOB(2, _omitFieldNames ? '' : 'force')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  XImportMissionControlRequest clone() => XImportMissionControlRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  XImportMissionControlRequest copyWith(void Function(XImportMissionControlRequest) updates) => super.copyWith((message) => updates(message as XImportMissionControlRequest)) as XImportMissionControlRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static XImportMissionControlRequest create() => XImportMissionControlRequest._();
  XImportMissionControlRequest createEmptyInstance() => create();
  static $pb.PbList<XImportMissionControlRequest> createRepeated() => $pb.PbList<XImportMissionControlRequest>();
  @$core.pragma('dart2js:noInline')
  static XImportMissionControlRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<XImportMissionControlRequest>(create);
  static XImportMissionControlRequest? _defaultInstance;

  /// Node pair-level mission control state to be imported.
  @$pb.TagNumber(1)
  $pb.PbList<PairHistory> get pairs => $_getList(0);

  /// Whether to force override MC pair history. Note that even with force
  /// override the failure pair is imported before the success pair and both
  /// still clamp existing failure/success amounts.
  @$pb.TagNumber(2)
  $core.bool get force => $_getBF(1);
  @$pb.TagNumber(2)
  set force($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasForce() => $_has(1);
  @$pb.TagNumber(2)
  void clearForce() => $_clearField(2);
}

class XImportMissionControlResponse extends $pb.GeneratedMessage {
  factory XImportMissionControlResponse() => create();
  XImportMissionControlResponse._() : super();
  factory XImportMissionControlResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory XImportMissionControlResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'XImportMissionControlResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  XImportMissionControlResponse clone() => XImportMissionControlResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  XImportMissionControlResponse copyWith(void Function(XImportMissionControlResponse) updates) => super.copyWith((message) => updates(message as XImportMissionControlResponse)) as XImportMissionControlResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static XImportMissionControlResponse create() => XImportMissionControlResponse._();
  XImportMissionControlResponse createEmptyInstance() => create();
  static $pb.PbList<XImportMissionControlResponse> createRepeated() => $pb.PbList<XImportMissionControlResponse>();
  @$core.pragma('dart2js:noInline')
  static XImportMissionControlResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<XImportMissionControlResponse>(create);
  static XImportMissionControlResponse? _defaultInstance;
}

/// PairHistory contains the mission control state for a particular node pair.
class PairHistory extends $pb.GeneratedMessage {
  factory PairHistory({
    $core.List<$core.int>? nodeFrom,
    $core.List<$core.int>? nodeTo,
    PairData? history,
  }) {
    final $result = create();
    if (nodeFrom != null) {
      $result.nodeFrom = nodeFrom;
    }
    if (nodeTo != null) {
      $result.nodeTo = nodeTo;
    }
    if (history != null) {
      $result.history = history;
    }
    return $result;
  }
  PairHistory._() : super();
  factory PairHistory.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PairHistory.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PairHistory', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'nodeFrom', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'nodeTo', $pb.PbFieldType.OY)
    ..aOM<PairData>(7, _omitFieldNames ? '' : 'history', subBuilder: PairData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PairHistory clone() => PairHistory()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PairHistory copyWith(void Function(PairHistory) updates) => super.copyWith((message) => updates(message as PairHistory)) as PairHistory;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PairHistory create() => PairHistory._();
  PairHistory createEmptyInstance() => create();
  static $pb.PbList<PairHistory> createRepeated() => $pb.PbList<PairHistory>();
  @$core.pragma('dart2js:noInline')
  static PairHistory getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PairHistory>(create);
  static PairHistory? _defaultInstance;

  /// The source node pubkey of the pair.
  @$pb.TagNumber(1)
  $core.List<$core.int> get nodeFrom => $_getN(0);
  @$pb.TagNumber(1)
  set nodeFrom($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeFrom() => $_clearField(1);

  /// The destination node pubkey of the pair.
  @$pb.TagNumber(2)
  $core.List<$core.int> get nodeTo => $_getN(1);
  @$pb.TagNumber(2)
  set nodeTo($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNodeTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearNodeTo() => $_clearField(2);

  @$pb.TagNumber(7)
  PairData get history => $_getN(2);
  @$pb.TagNumber(7)
  set history(PairData v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasHistory() => $_has(2);
  @$pb.TagNumber(7)
  void clearHistory() => $_clearField(7);
  @$pb.TagNumber(7)
  PairData ensureHistory() => $_ensure(2);
}

class PairData extends $pb.GeneratedMessage {
  factory PairData({
    $fixnum.Int64? failTime,
    $fixnum.Int64? failAmtSat,
    $fixnum.Int64? failAmtMsat,
    $fixnum.Int64? successTime,
    $fixnum.Int64? successAmtSat,
    $fixnum.Int64? successAmtMsat,
  }) {
    final $result = create();
    if (failTime != null) {
      $result.failTime = failTime;
    }
    if (failAmtSat != null) {
      $result.failAmtSat = failAmtSat;
    }
    if (failAmtMsat != null) {
      $result.failAmtMsat = failAmtMsat;
    }
    if (successTime != null) {
      $result.successTime = successTime;
    }
    if (successAmtSat != null) {
      $result.successAmtSat = successAmtSat;
    }
    if (successAmtMsat != null) {
      $result.successAmtMsat = successAmtMsat;
    }
    return $result;
  }
  PairData._() : super();
  factory PairData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PairData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PairData', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'failTime')
    ..aInt64(2, _omitFieldNames ? '' : 'failAmtSat')
    ..aInt64(4, _omitFieldNames ? '' : 'failAmtMsat')
    ..aInt64(5, _omitFieldNames ? '' : 'successTime')
    ..aInt64(6, _omitFieldNames ? '' : 'successAmtSat')
    ..aInt64(7, _omitFieldNames ? '' : 'successAmtMsat')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PairData clone() => PairData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PairData copyWith(void Function(PairData) updates) => super.copyWith((message) => updates(message as PairData)) as PairData;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PairData create() => PairData._();
  PairData createEmptyInstance() => create();
  static $pb.PbList<PairData> createRepeated() => $pb.PbList<PairData>();
  @$core.pragma('dart2js:noInline')
  static PairData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PairData>(create);
  static PairData? _defaultInstance;

  /// Time of last failure.
  @$pb.TagNumber(1)
  $fixnum.Int64 get failTime => $_getI64(0);
  @$pb.TagNumber(1)
  set failTime($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFailTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearFailTime() => $_clearField(1);

  ///
  /// Lowest amount that failed to forward rounded to whole sats. This may be
  /// set to zero if the failure is independent of amount.
  @$pb.TagNumber(2)
  $fixnum.Int64 get failAmtSat => $_getI64(1);
  @$pb.TagNumber(2)
  set failAmtSat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFailAmtSat() => $_has(1);
  @$pb.TagNumber(2)
  void clearFailAmtSat() => $_clearField(2);

  ///
  /// Lowest amount that failed to forward in millisats. This may be
  /// set to zero if the failure is independent of amount.
  @$pb.TagNumber(4)
  $fixnum.Int64 get failAmtMsat => $_getI64(2);
  @$pb.TagNumber(4)
  set failAmtMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailAmtMsat() => $_has(2);
  @$pb.TagNumber(4)
  void clearFailAmtMsat() => $_clearField(4);

  /// Time of last success.
  @$pb.TagNumber(5)
  $fixnum.Int64 get successTime => $_getI64(3);
  @$pb.TagNumber(5)
  set successTime($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasSuccessTime() => $_has(3);
  @$pb.TagNumber(5)
  void clearSuccessTime() => $_clearField(5);

  /// Highest amount that we could successfully forward rounded to whole sats.
  @$pb.TagNumber(6)
  $fixnum.Int64 get successAmtSat => $_getI64(4);
  @$pb.TagNumber(6)
  set successAmtSat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasSuccessAmtSat() => $_has(4);
  @$pb.TagNumber(6)
  void clearSuccessAmtSat() => $_clearField(6);

  /// Highest amount that we could successfully forward in millisats.
  @$pb.TagNumber(7)
  $fixnum.Int64 get successAmtMsat => $_getI64(5);
  @$pb.TagNumber(7)
  set successAmtMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasSuccessAmtMsat() => $_has(5);
  @$pb.TagNumber(7)
  void clearSuccessAmtMsat() => $_clearField(7);
}

class GetMissionControlConfigRequest extends $pb.GeneratedMessage {
  factory GetMissionControlConfigRequest() => create();
  GetMissionControlConfigRequest._() : super();
  factory GetMissionControlConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMissionControlConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMissionControlConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMissionControlConfigRequest clone() => GetMissionControlConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMissionControlConfigRequest copyWith(void Function(GetMissionControlConfigRequest) updates) => super.copyWith((message) => updates(message as GetMissionControlConfigRequest)) as GetMissionControlConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMissionControlConfigRequest create() => GetMissionControlConfigRequest._();
  GetMissionControlConfigRequest createEmptyInstance() => create();
  static $pb.PbList<GetMissionControlConfigRequest> createRepeated() => $pb.PbList<GetMissionControlConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static GetMissionControlConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMissionControlConfigRequest>(create);
  static GetMissionControlConfigRequest? _defaultInstance;
}

class GetMissionControlConfigResponse extends $pb.GeneratedMessage {
  factory GetMissionControlConfigResponse({
    MissionControlConfig? config,
  }) {
    final $result = create();
    if (config != null) {
      $result.config = config;
    }
    return $result;
  }
  GetMissionControlConfigResponse._() : super();
  factory GetMissionControlConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetMissionControlConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetMissionControlConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<MissionControlConfig>(1, _omitFieldNames ? '' : 'config', subBuilder: MissionControlConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetMissionControlConfigResponse clone() => GetMissionControlConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetMissionControlConfigResponse copyWith(void Function(GetMissionControlConfigResponse) updates) => super.copyWith((message) => updates(message as GetMissionControlConfigResponse)) as GetMissionControlConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetMissionControlConfigResponse create() => GetMissionControlConfigResponse._();
  GetMissionControlConfigResponse createEmptyInstance() => create();
  static $pb.PbList<GetMissionControlConfigResponse> createRepeated() => $pb.PbList<GetMissionControlConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static GetMissionControlConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMissionControlConfigResponse>(create);
  static GetMissionControlConfigResponse? _defaultInstance;

  ///
  /// Mission control's currently active config.
  @$pb.TagNumber(1)
  MissionControlConfig get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(MissionControlConfig v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => $_clearField(1);
  @$pb.TagNumber(1)
  MissionControlConfig ensureConfig() => $_ensure(0);
}

class SetMissionControlConfigRequest extends $pb.GeneratedMessage {
  factory SetMissionControlConfigRequest({
    MissionControlConfig? config,
  }) {
    final $result = create();
    if (config != null) {
      $result.config = config;
    }
    return $result;
  }
  SetMissionControlConfigRequest._() : super();
  factory SetMissionControlConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetMissionControlConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetMissionControlConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<MissionControlConfig>(1, _omitFieldNames ? '' : 'config', subBuilder: MissionControlConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetMissionControlConfigRequest clone() => SetMissionControlConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetMissionControlConfigRequest copyWith(void Function(SetMissionControlConfigRequest) updates) => super.copyWith((message) => updates(message as SetMissionControlConfigRequest)) as SetMissionControlConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetMissionControlConfigRequest create() => SetMissionControlConfigRequest._();
  SetMissionControlConfigRequest createEmptyInstance() => create();
  static $pb.PbList<SetMissionControlConfigRequest> createRepeated() => $pb.PbList<SetMissionControlConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static SetMissionControlConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetMissionControlConfigRequest>(create);
  static SetMissionControlConfigRequest? _defaultInstance;

  ///
  /// The config to set for mission control. Note that all values *must* be set,
  /// because the full config will be applied.
  @$pb.TagNumber(1)
  MissionControlConfig get config => $_getN(0);
  @$pb.TagNumber(1)
  set config(MissionControlConfig v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfig() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfig() => $_clearField(1);
  @$pb.TagNumber(1)
  MissionControlConfig ensureConfig() => $_ensure(0);
}

class SetMissionControlConfigResponse extends $pb.GeneratedMessage {
  factory SetMissionControlConfigResponse() => create();
  SetMissionControlConfigResponse._() : super();
  factory SetMissionControlConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetMissionControlConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetMissionControlConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetMissionControlConfigResponse clone() => SetMissionControlConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetMissionControlConfigResponse copyWith(void Function(SetMissionControlConfigResponse) updates) => super.copyWith((message) => updates(message as SetMissionControlConfigResponse)) as SetMissionControlConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetMissionControlConfigResponse create() => SetMissionControlConfigResponse._();
  SetMissionControlConfigResponse createEmptyInstance() => create();
  static $pb.PbList<SetMissionControlConfigResponse> createRepeated() => $pb.PbList<SetMissionControlConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static SetMissionControlConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetMissionControlConfigResponse>(create);
  static SetMissionControlConfigResponse? _defaultInstance;
}

enum MissionControlConfig_EstimatorConfig {
  apriori, 
  bimodal, 
  notSet
}

class MissionControlConfig extends $pb.GeneratedMessage {
  factory MissionControlConfig({
  @$core.Deprecated('This field is deprecated.')
    $fixnum.Int64? halfLifeSeconds,
  @$core.Deprecated('This field is deprecated.')
    $core.double? hopProbability,
  @$core.Deprecated('This field is deprecated.')
    $core.double? weight,
    $core.int? maximumPaymentResults,
    $fixnum.Int64? minimumFailureRelaxInterval,
    MissionControlConfig_ProbabilityModel? model,
    AprioriParameters? apriori,
    BimodalParameters? bimodal,
  }) {
    final $result = create();
    if (halfLifeSeconds != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.halfLifeSeconds = halfLifeSeconds;
    }
    if (hopProbability != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.hopProbability = hopProbability;
    }
    if (weight != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.weight = weight;
    }
    if (maximumPaymentResults != null) {
      $result.maximumPaymentResults = maximumPaymentResults;
    }
    if (minimumFailureRelaxInterval != null) {
      $result.minimumFailureRelaxInterval = minimumFailureRelaxInterval;
    }
    if (model != null) {
      $result.model = model;
    }
    if (apriori != null) {
      $result.apriori = apriori;
    }
    if (bimodal != null) {
      $result.bimodal = bimodal;
    }
    return $result;
  }
  MissionControlConfig._() : super();
  factory MissionControlConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MissionControlConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, MissionControlConfig_EstimatorConfig> _MissionControlConfig_EstimatorConfigByTag = {
    7 : MissionControlConfig_EstimatorConfig.apriori,
    8 : MissionControlConfig_EstimatorConfig.bimodal,
    0 : MissionControlConfig_EstimatorConfig.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MissionControlConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..oo(0, [7, 8])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'halfLifeSeconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'hopProbability', $pb.PbFieldType.OF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'weight', $pb.PbFieldType.OF)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maximumPaymentResults', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'minimumFailureRelaxInterval', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<MissionControlConfig_ProbabilityModel>(6, _omitFieldNames ? '' : 'model', $pb.PbFieldType.OE, defaultOrMaker: MissionControlConfig_ProbabilityModel.APRIORI, valueOf: MissionControlConfig_ProbabilityModel.valueOf, enumValues: MissionControlConfig_ProbabilityModel.values)
    ..aOM<AprioriParameters>(7, _omitFieldNames ? '' : 'apriori', subBuilder: AprioriParameters.create)
    ..aOM<BimodalParameters>(8, _omitFieldNames ? '' : 'bimodal', subBuilder: BimodalParameters.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MissionControlConfig clone() => MissionControlConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MissionControlConfig copyWith(void Function(MissionControlConfig) updates) => super.copyWith((message) => updates(message as MissionControlConfig)) as MissionControlConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MissionControlConfig create() => MissionControlConfig._();
  MissionControlConfig createEmptyInstance() => create();
  static $pb.PbList<MissionControlConfig> createRepeated() => $pb.PbList<MissionControlConfig>();
  @$core.pragma('dart2js:noInline')
  static MissionControlConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MissionControlConfig>(create);
  static MissionControlConfig? _defaultInstance;

  MissionControlConfig_EstimatorConfig whichEstimatorConfig() => _MissionControlConfig_EstimatorConfigByTag[$_whichOneof(0)]!;
  void clearEstimatorConfig() => $_clearField($_whichOneof(0));

  ///
  /// Deprecated, use AprioriParameters. The amount of time mission control will
  /// take to restore a penalized node or channel back to 50% success probability,
  /// expressed in seconds. Setting this value to a higher value will penalize
  /// failures for longer, making mission control less likely to route through
  /// nodes and channels that we have previously recorded failures for.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $fixnum.Int64 get halfLifeSeconds => $_getI64(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  set halfLifeSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  $core.bool hasHalfLifeSeconds() => $_has(0);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(1)
  void clearHalfLifeSeconds() => $_clearField(1);

  ///
  /// Deprecated, use AprioriParameters. The probability of success mission
  /// control should assign to hop in a route where it has no other information
  /// available. Higher values will make mission control more willing to try hops
  /// that we have no information about, lower values will discourage trying these
  /// hops.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.double get hopProbability => $_getN(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set hopProbability($core.double v) { $_setFloat(1, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasHopProbability() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearHopProbability() => $_clearField(2);

  ///
  /// Deprecated, use AprioriParameters. The importance that mission control
  /// should place on historical results, expressed as a value in [0;1]. Setting
  /// this value to 1 will ignore all historical payments and just use the hop
  /// probability to assess the probability of success for each hop. A zero value
  /// ignores hop probability completely and relies entirely on historical
  /// results, unless none are available.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.double get weight => $_getN(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  set weight($core.double v) { $_setFloat(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  $core.bool hasWeight() => $_has(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(3)
  void clearWeight() => $_clearField(3);

  ///
  /// The maximum number of payment results that mission control will store.
  @$pb.TagNumber(4)
  $core.int get maximumPaymentResults => $_getIZ(3);
  @$pb.TagNumber(4)
  set maximumPaymentResults($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaximumPaymentResults() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaximumPaymentResults() => $_clearField(4);

  ///
  /// The minimum time that must have passed since the previously recorded failure
  /// before we raise the failure amount.
  @$pb.TagNumber(5)
  $fixnum.Int64 get minimumFailureRelaxInterval => $_getI64(4);
  @$pb.TagNumber(5)
  set minimumFailureRelaxInterval($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMinimumFailureRelaxInterval() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinimumFailureRelaxInterval() => $_clearField(5);

  ///
  /// ProbabilityModel defines which probability estimator should be used in
  /// pathfinding. Note that the bimodal estimator is experimental.
  @$pb.TagNumber(6)
  MissionControlConfig_ProbabilityModel get model => $_getN(5);
  @$pb.TagNumber(6)
  set model(MissionControlConfig_ProbabilityModel v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasModel() => $_has(5);
  @$pb.TagNumber(6)
  void clearModel() => $_clearField(6);

  @$pb.TagNumber(7)
  AprioriParameters get apriori => $_getN(6);
  @$pb.TagNumber(7)
  set apriori(AprioriParameters v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasApriori() => $_has(6);
  @$pb.TagNumber(7)
  void clearApriori() => $_clearField(7);
  @$pb.TagNumber(7)
  AprioriParameters ensureApriori() => $_ensure(6);

  @$pb.TagNumber(8)
  BimodalParameters get bimodal => $_getN(7);
  @$pb.TagNumber(8)
  set bimodal(BimodalParameters v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasBimodal() => $_has(7);
  @$pb.TagNumber(8)
  void clearBimodal() => $_clearField(8);
  @$pb.TagNumber(8)
  BimodalParameters ensureBimodal() => $_ensure(7);
}

class BimodalParameters extends $pb.GeneratedMessage {
  factory BimodalParameters({
    $core.double? nodeWeight,
    $fixnum.Int64? scaleMsat,
    $fixnum.Int64? decayTime,
  }) {
    final $result = create();
    if (nodeWeight != null) {
      $result.nodeWeight = nodeWeight;
    }
    if (scaleMsat != null) {
      $result.scaleMsat = scaleMsat;
    }
    if (decayTime != null) {
      $result.decayTime = decayTime;
    }
    return $result;
  }
  BimodalParameters._() : super();
  factory BimodalParameters.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BimodalParameters.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BimodalParameters', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'nodeWeight', $pb.PbFieldType.OD)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'scaleMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'decayTime', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BimodalParameters clone() => BimodalParameters()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BimodalParameters copyWith(void Function(BimodalParameters) updates) => super.copyWith((message) => updates(message as BimodalParameters)) as BimodalParameters;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BimodalParameters create() => BimodalParameters._();
  BimodalParameters createEmptyInstance() => create();
  static $pb.PbList<BimodalParameters> createRepeated() => $pb.PbList<BimodalParameters>();
  @$core.pragma('dart2js:noInline')
  static BimodalParameters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BimodalParameters>(create);
  static BimodalParameters? _defaultInstance;

  ///
  /// NodeWeight defines how strongly other previous forwardings on channels of a
  /// router should be taken into account when computing a channel's probability
  /// to route. The allowed values are in the range [0, 1], where a value of 0
  /// means that only direct information about a channel is taken into account.
  @$pb.TagNumber(1)
  $core.double get nodeWeight => $_getN(0);
  @$pb.TagNumber(1)
  set nodeWeight($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeWeight() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeWeight() => $_clearField(1);

  ///
  /// ScaleMsat describes the scale over which channels statistically have some
  /// liquidity left. The value determines how quickly the bimodal distribution
  /// drops off from the edges of a channel. A larger value (compared to typical
  /// channel capacities) means that the drop off is slow and that channel
  /// balances are distributed more uniformly. A small value leads to the
  /// assumption of very unbalanced channels.
  @$pb.TagNumber(2)
  $fixnum.Int64 get scaleMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set scaleMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScaleMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearScaleMsat() => $_clearField(2);

  ///
  /// DecayTime describes the information decay of knowledge about previous
  /// successes and failures in channels. The smaller the decay time, the quicker
  /// we forget about past forwardings.
  @$pb.TagNumber(3)
  $fixnum.Int64 get decayTime => $_getI64(2);
  @$pb.TagNumber(3)
  set decayTime($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDecayTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearDecayTime() => $_clearField(3);
}

class AprioriParameters extends $pb.GeneratedMessage {
  factory AprioriParameters({
    $fixnum.Int64? halfLifeSeconds,
    $core.double? hopProbability,
    $core.double? weight,
    $core.double? capacityFraction,
  }) {
    final $result = create();
    if (halfLifeSeconds != null) {
      $result.halfLifeSeconds = halfLifeSeconds;
    }
    if (hopProbability != null) {
      $result.hopProbability = hopProbability;
    }
    if (weight != null) {
      $result.weight = weight;
    }
    if (capacityFraction != null) {
      $result.capacityFraction = capacityFraction;
    }
    return $result;
  }
  AprioriParameters._() : super();
  factory AprioriParameters.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AprioriParameters.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AprioriParameters', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'halfLifeSeconds', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'hopProbability', $pb.PbFieldType.OD)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'weight', $pb.PbFieldType.OD)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'capacityFraction', $pb.PbFieldType.OD)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AprioriParameters clone() => AprioriParameters()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AprioriParameters copyWith(void Function(AprioriParameters) updates) => super.copyWith((message) => updates(message as AprioriParameters)) as AprioriParameters;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AprioriParameters create() => AprioriParameters._();
  AprioriParameters createEmptyInstance() => create();
  static $pb.PbList<AprioriParameters> createRepeated() => $pb.PbList<AprioriParameters>();
  @$core.pragma('dart2js:noInline')
  static AprioriParameters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AprioriParameters>(create);
  static AprioriParameters? _defaultInstance;

  ///
  /// The amount of time mission control will take to restore a penalized node
  /// or channel back to 50% success probability, expressed in seconds. Setting
  /// this value to a higher value will penalize failures for longer, making
  /// mission control less likely to route through nodes and channels that we
  /// have previously recorded failures for.
  @$pb.TagNumber(1)
  $fixnum.Int64 get halfLifeSeconds => $_getI64(0);
  @$pb.TagNumber(1)
  set halfLifeSeconds($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHalfLifeSeconds() => $_has(0);
  @$pb.TagNumber(1)
  void clearHalfLifeSeconds() => $_clearField(1);

  ///
  /// The probability of success mission control should assign to hop in a route
  /// where it has no other information available. Higher values will make mission
  /// control more willing to try hops that we have no information about, lower
  /// values will discourage trying these hops.
  @$pb.TagNumber(2)
  $core.double get hopProbability => $_getN(1);
  @$pb.TagNumber(2)
  set hopProbability($core.double v) { $_setDouble(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHopProbability() => $_has(1);
  @$pb.TagNumber(2)
  void clearHopProbability() => $_clearField(2);

  ///
  /// The importance that mission control should place on historical results,
  /// expressed as a value in [0;1]. Setting this value to 1 will ignore all
  /// historical payments and just use the hop probability to assess the
  /// probability of success for each hop. A zero value ignores hop probability
  /// completely and relies entirely on historical results, unless none are
  /// available.
  @$pb.TagNumber(3)
  $core.double get weight => $_getN(2);
  @$pb.TagNumber(3)
  set weight($core.double v) { $_setDouble(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearWeight() => $_clearField(3);

  ///
  /// The fraction of a channel's capacity that we consider to have liquidity. For
  /// amounts that come close to or exceed the fraction, an additional penalty is
  /// applied. A value of 1.0 disables the capacity factor. Allowed values are in
  /// [0.75, 1.0].
  @$pb.TagNumber(4)
  $core.double get capacityFraction => $_getN(3);
  @$pb.TagNumber(4)
  set capacityFraction($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCapacityFraction() => $_has(3);
  @$pb.TagNumber(4)
  void clearCapacityFraction() => $_clearField(4);
}

class QueryProbabilityRequest extends $pb.GeneratedMessage {
  factory QueryProbabilityRequest({
    $core.List<$core.int>? fromNode,
    $core.List<$core.int>? toNode,
    $fixnum.Int64? amtMsat,
  }) {
    final $result = create();
    if (fromNode != null) {
      $result.fromNode = fromNode;
    }
    if (toNode != null) {
      $result.toNode = toNode;
    }
    if (amtMsat != null) {
      $result.amtMsat = amtMsat;
    }
    return $result;
  }
  QueryProbabilityRequest._() : super();
  factory QueryProbabilityRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryProbabilityRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryProbabilityRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'fromNode', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'toNode', $pb.PbFieldType.OY)
    ..aInt64(3, _omitFieldNames ? '' : 'amtMsat')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryProbabilityRequest clone() => QueryProbabilityRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryProbabilityRequest copyWith(void Function(QueryProbabilityRequest) updates) => super.copyWith((message) => updates(message as QueryProbabilityRequest)) as QueryProbabilityRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryProbabilityRequest create() => QueryProbabilityRequest._();
  QueryProbabilityRequest createEmptyInstance() => create();
  static $pb.PbList<QueryProbabilityRequest> createRepeated() => $pb.PbList<QueryProbabilityRequest>();
  @$core.pragma('dart2js:noInline')
  static QueryProbabilityRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryProbabilityRequest>(create);
  static QueryProbabilityRequest? _defaultInstance;

  /// The source node pubkey of the pair.
  @$pb.TagNumber(1)
  $core.List<$core.int> get fromNode => $_getN(0);
  @$pb.TagNumber(1)
  set fromNode($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasFromNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromNode() => $_clearField(1);

  /// The destination node pubkey of the pair.
  @$pb.TagNumber(2)
  $core.List<$core.int> get toNode => $_getN(1);
  @$pb.TagNumber(2)
  set toNode($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasToNode() => $_has(1);
  @$pb.TagNumber(2)
  void clearToNode() => $_clearField(2);

  /// The amount for which to calculate a probability.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amtMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set amtMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmtMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmtMsat() => $_clearField(3);
}

class QueryProbabilityResponse extends $pb.GeneratedMessage {
  factory QueryProbabilityResponse({
    $core.double? probability,
    PairData? history,
  }) {
    final $result = create();
    if (probability != null) {
      $result.probability = probability;
    }
    if (history != null) {
      $result.history = history;
    }
    return $result;
  }
  QueryProbabilityResponse._() : super();
  factory QueryProbabilityResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory QueryProbabilityResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'QueryProbabilityResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'probability', $pb.PbFieldType.OD)
    ..aOM<PairData>(2, _omitFieldNames ? '' : 'history', subBuilder: PairData.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  QueryProbabilityResponse clone() => QueryProbabilityResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  QueryProbabilityResponse copyWith(void Function(QueryProbabilityResponse) updates) => super.copyWith((message) => updates(message as QueryProbabilityResponse)) as QueryProbabilityResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static QueryProbabilityResponse create() => QueryProbabilityResponse._();
  QueryProbabilityResponse createEmptyInstance() => create();
  static $pb.PbList<QueryProbabilityResponse> createRepeated() => $pb.PbList<QueryProbabilityResponse>();
  @$core.pragma('dart2js:noInline')
  static QueryProbabilityResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<QueryProbabilityResponse>(create);
  static QueryProbabilityResponse? _defaultInstance;

  /// The success probability for the requested pair.
  @$pb.TagNumber(1)
  $core.double get probability => $_getN(0);
  @$pb.TagNumber(1)
  set probability($core.double v) { $_setDouble(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasProbability() => $_has(0);
  @$pb.TagNumber(1)
  void clearProbability() => $_clearField(1);

  /// The historical data for the requested pair.
  @$pb.TagNumber(2)
  PairData get history => $_getN(1);
  @$pb.TagNumber(2)
  set history(PairData v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasHistory() => $_has(1);
  @$pb.TagNumber(2)
  void clearHistory() => $_clearField(2);
  @$pb.TagNumber(2)
  PairData ensureHistory() => $_ensure(1);
}

class BuildRouteRequest extends $pb.GeneratedMessage {
  factory BuildRouteRequest({
    $fixnum.Int64? amtMsat,
    $core.int? finalCltvDelta,
    $fixnum.Int64? outgoingChanId,
    $core.Iterable<$core.List<$core.int>>? hopPubkeys,
    $core.List<$core.int>? paymentAddr,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? firstHopCustomRecords,
  }) {
    final $result = create();
    if (amtMsat != null) {
      $result.amtMsat = amtMsat;
    }
    if (finalCltvDelta != null) {
      $result.finalCltvDelta = finalCltvDelta;
    }
    if (outgoingChanId != null) {
      $result.outgoingChanId = outgoingChanId;
    }
    if (hopPubkeys != null) {
      $result.hopPubkeys.addAll(hopPubkeys);
    }
    if (paymentAddr != null) {
      $result.paymentAddr = paymentAddr;
    }
    if (firstHopCustomRecords != null) {
      $result.firstHopCustomRecords.addAll(firstHopCustomRecords);
    }
    return $result;
  }
  BuildRouteRequest._() : super();
  factory BuildRouteRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuildRouteRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuildRouteRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'amtMsat')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'finalCltvDelta', $pb.PbFieldType.O3)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'outgoingChanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'hopPubkeys', $pb.PbFieldType.PY)
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'paymentAddr', $pb.PbFieldType.OY)
    ..m<$fixnum.Int64, $core.List<$core.int>>(6, _omitFieldNames ? '' : 'firstHopCustomRecords', entryClassName: 'BuildRouteRequest.FirstHopCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuildRouteRequest clone() => BuildRouteRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuildRouteRequest copyWith(void Function(BuildRouteRequest) updates) => super.copyWith((message) => updates(message as BuildRouteRequest)) as BuildRouteRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuildRouteRequest create() => BuildRouteRequest._();
  BuildRouteRequest createEmptyInstance() => create();
  static $pb.PbList<BuildRouteRequest> createRepeated() => $pb.PbList<BuildRouteRequest>();
  @$core.pragma('dart2js:noInline')
  static BuildRouteRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuildRouteRequest>(create);
  static BuildRouteRequest? _defaultInstance;

  ///
  /// The amount to send expressed in msat. If set to zero, the minimum routable
  /// amount is used.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amtMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set amtMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmtMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmtMsat() => $_clearField(1);

  ///
  /// CLTV delta from the current height that should be used for the timelock
  /// of the final hop
  @$pb.TagNumber(2)
  $core.int get finalCltvDelta => $_getIZ(1);
  @$pb.TagNumber(2)
  set finalCltvDelta($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFinalCltvDelta() => $_has(1);
  @$pb.TagNumber(2)
  void clearFinalCltvDelta() => $_clearField(2);

  ///
  /// The channel id of the channel that must be taken to the first hop. If zero,
  /// any channel may be used.
  @$pb.TagNumber(3)
  $fixnum.Int64 get outgoingChanId => $_getI64(2);
  @$pb.TagNumber(3)
  set outgoingChanId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutgoingChanId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutgoingChanId() => $_clearField(3);

  ///
  /// A list of hops that defines the route. This does not include the source hop
  /// pubkey.
  @$pb.TagNumber(4)
  $pb.PbList<$core.List<$core.int>> get hopPubkeys => $_getList(3);

  ///
  /// An optional payment addr to be included within the last hop of the route.
  /// This is also called payment secret in specifications (e.g. BOLT 11).
  @$pb.TagNumber(5)
  $core.List<$core.int> get paymentAddr => $_getN(4);
  @$pb.TagNumber(5)
  set paymentAddr($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentAddr() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentAddr() => $_clearField(5);

  ///
  /// An optional field that can be used to pass an arbitrary set of TLV records
  /// to the first hop peer of this payment. This can be used to pass application
  /// specific data during the payment attempt. Record types are required to be in
  /// the custom range >= 65536. When using REST, the values must be encoded as
  /// base64.
  @$pb.TagNumber(6)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get firstHopCustomRecords => $_getMap(5);
}

class BuildRouteResponse extends $pb.GeneratedMessage {
  factory BuildRouteResponse({
    $1.Route? route,
  }) {
    final $result = create();
    if (route != null) {
      $result.route = route;
    }
    return $result;
  }
  BuildRouteResponse._() : super();
  factory BuildRouteResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BuildRouteResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BuildRouteResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<$1.Route>(1, _omitFieldNames ? '' : 'route', subBuilder: $1.Route.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BuildRouteResponse clone() => BuildRouteResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BuildRouteResponse copyWith(void Function(BuildRouteResponse) updates) => super.copyWith((message) => updates(message as BuildRouteResponse)) as BuildRouteResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BuildRouteResponse create() => BuildRouteResponse._();
  BuildRouteResponse createEmptyInstance() => create();
  static $pb.PbList<BuildRouteResponse> createRepeated() => $pb.PbList<BuildRouteResponse>();
  @$core.pragma('dart2js:noInline')
  static BuildRouteResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BuildRouteResponse>(create);
  static BuildRouteResponse? _defaultInstance;

  ///
  /// Fully specified route that can be used to execute the payment.
  @$pb.TagNumber(1)
  $1.Route get route => $_getN(0);
  @$pb.TagNumber(1)
  set route($1.Route v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRoute() => $_has(0);
  @$pb.TagNumber(1)
  void clearRoute() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Route ensureRoute() => $_ensure(0);
}

class SubscribeHtlcEventsRequest extends $pb.GeneratedMessage {
  factory SubscribeHtlcEventsRequest() => create();
  SubscribeHtlcEventsRequest._() : super();
  factory SubscribeHtlcEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeHtlcEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeHtlcEventsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeHtlcEventsRequest clone() => SubscribeHtlcEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeHtlcEventsRequest copyWith(void Function(SubscribeHtlcEventsRequest) updates) => super.copyWith((message) => updates(message as SubscribeHtlcEventsRequest)) as SubscribeHtlcEventsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeHtlcEventsRequest create() => SubscribeHtlcEventsRequest._();
  SubscribeHtlcEventsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeHtlcEventsRequest> createRepeated() => $pb.PbList<SubscribeHtlcEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeHtlcEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeHtlcEventsRequest>(create);
  static SubscribeHtlcEventsRequest? _defaultInstance;
}

enum HtlcEvent_Event {
  forwardEvent, 
  forwardFailEvent, 
  settleEvent, 
  linkFailEvent, 
  subscribedEvent, 
  finalHtlcEvent, 
  notSet
}

///
/// HtlcEvent contains the htlc event that was processed. These are served on a
/// best-effort basis; events are not persisted, delivery is not guaranteed
/// (in the event of a crash in the switch, forward events may be lost) and
/// some events may be replayed upon restart. Events consumed from this package
/// should be de-duplicated by the htlc's unique combination of incoming and
/// outgoing channel id and htlc id. [EXPERIMENTAL]
class HtlcEvent extends $pb.GeneratedMessage {
  factory HtlcEvent({
    $fixnum.Int64? incomingChannelId,
    $fixnum.Int64? outgoingChannelId,
    $fixnum.Int64? incomingHtlcId,
    $fixnum.Int64? outgoingHtlcId,
    $fixnum.Int64? timestampNs,
    HtlcEvent_EventType? eventType,
    ForwardEvent? forwardEvent,
    ForwardFailEvent? forwardFailEvent,
    SettleEvent? settleEvent,
    LinkFailEvent? linkFailEvent,
    SubscribedEvent? subscribedEvent,
    FinalHtlcEvent? finalHtlcEvent,
  }) {
    final $result = create();
    if (incomingChannelId != null) {
      $result.incomingChannelId = incomingChannelId;
    }
    if (outgoingChannelId != null) {
      $result.outgoingChannelId = outgoingChannelId;
    }
    if (incomingHtlcId != null) {
      $result.incomingHtlcId = incomingHtlcId;
    }
    if (outgoingHtlcId != null) {
      $result.outgoingHtlcId = outgoingHtlcId;
    }
    if (timestampNs != null) {
      $result.timestampNs = timestampNs;
    }
    if (eventType != null) {
      $result.eventType = eventType;
    }
    if (forwardEvent != null) {
      $result.forwardEvent = forwardEvent;
    }
    if (forwardFailEvent != null) {
      $result.forwardFailEvent = forwardFailEvent;
    }
    if (settleEvent != null) {
      $result.settleEvent = settleEvent;
    }
    if (linkFailEvent != null) {
      $result.linkFailEvent = linkFailEvent;
    }
    if (subscribedEvent != null) {
      $result.subscribedEvent = subscribedEvent;
    }
    if (finalHtlcEvent != null) {
      $result.finalHtlcEvent = finalHtlcEvent;
    }
    return $result;
  }
  HtlcEvent._() : super();
  factory HtlcEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HtlcEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, HtlcEvent_Event> _HtlcEvent_EventByTag = {
    7 : HtlcEvent_Event.forwardEvent,
    8 : HtlcEvent_Event.forwardFailEvent,
    9 : HtlcEvent_Event.settleEvent,
    10 : HtlcEvent_Event.linkFailEvent,
    11 : HtlcEvent_Event.subscribedEvent,
    12 : HtlcEvent_Event.finalHtlcEvent,
    0 : HtlcEvent_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HtlcEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..oo(0, [7, 8, 9, 10, 11, 12])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'incomingChannelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'outgoingChannelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'incomingHtlcId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'outgoingHtlcId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'timestampNs', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<HtlcEvent_EventType>(6, _omitFieldNames ? '' : 'eventType', $pb.PbFieldType.OE, defaultOrMaker: HtlcEvent_EventType.UNKNOWN, valueOf: HtlcEvent_EventType.valueOf, enumValues: HtlcEvent_EventType.values)
    ..aOM<ForwardEvent>(7, _omitFieldNames ? '' : 'forwardEvent', subBuilder: ForwardEvent.create)
    ..aOM<ForwardFailEvent>(8, _omitFieldNames ? '' : 'forwardFailEvent', subBuilder: ForwardFailEvent.create)
    ..aOM<SettleEvent>(9, _omitFieldNames ? '' : 'settleEvent', subBuilder: SettleEvent.create)
    ..aOM<LinkFailEvent>(10, _omitFieldNames ? '' : 'linkFailEvent', subBuilder: LinkFailEvent.create)
    ..aOM<SubscribedEvent>(11, _omitFieldNames ? '' : 'subscribedEvent', subBuilder: SubscribedEvent.create)
    ..aOM<FinalHtlcEvent>(12, _omitFieldNames ? '' : 'finalHtlcEvent', subBuilder: FinalHtlcEvent.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HtlcEvent clone() => HtlcEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HtlcEvent copyWith(void Function(HtlcEvent) updates) => super.copyWith((message) => updates(message as HtlcEvent)) as HtlcEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HtlcEvent create() => HtlcEvent._();
  HtlcEvent createEmptyInstance() => create();
  static $pb.PbList<HtlcEvent> createRepeated() => $pb.PbList<HtlcEvent>();
  @$core.pragma('dart2js:noInline')
  static HtlcEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HtlcEvent>(create);
  static HtlcEvent? _defaultInstance;

  HtlcEvent_Event whichEvent() => _HtlcEvent_EventByTag[$_whichOneof(0)]!;
  void clearEvent() => $_clearField($_whichOneof(0));

  ///
  /// The short channel id that the incoming htlc arrived at our node on. This
  /// value is zero for sends.
  @$pb.TagNumber(1)
  $fixnum.Int64 get incomingChannelId => $_getI64(0);
  @$pb.TagNumber(1)
  set incomingChannelId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncomingChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomingChannelId() => $_clearField(1);

  ///
  /// The short channel id that the outgoing htlc left our node on. This value
  /// is zero for receives.
  @$pb.TagNumber(2)
  $fixnum.Int64 get outgoingChannelId => $_getI64(1);
  @$pb.TagNumber(2)
  set outgoingChannelId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutgoingChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutgoingChannelId() => $_clearField(2);

  ///
  /// Incoming id is the index of the incoming htlc in the incoming channel.
  /// This value is zero for sends.
  @$pb.TagNumber(3)
  $fixnum.Int64 get incomingHtlcId => $_getI64(2);
  @$pb.TagNumber(3)
  set incomingHtlcId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncomingHtlcId() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncomingHtlcId() => $_clearField(3);

  ///
  /// Outgoing id is the index of the outgoing htlc in the outgoing channel.
  /// This value is zero for receives.
  @$pb.TagNumber(4)
  $fixnum.Int64 get outgoingHtlcId => $_getI64(3);
  @$pb.TagNumber(4)
  set outgoingHtlcId($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutgoingHtlcId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutgoingHtlcId() => $_clearField(4);

  ///
  /// The time in unix nanoseconds that the event occurred.
  @$pb.TagNumber(5)
  $fixnum.Int64 get timestampNs => $_getI64(4);
  @$pb.TagNumber(5)
  set timestampNs($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestampNs() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestampNs() => $_clearField(5);

  ///
  /// The event type indicates whether the htlc was part of a send, receive or
  /// forward.
  @$pb.TagNumber(6)
  HtlcEvent_EventType get eventType => $_getN(5);
  @$pb.TagNumber(6)
  set eventType(HtlcEvent_EventType v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasEventType() => $_has(5);
  @$pb.TagNumber(6)
  void clearEventType() => $_clearField(6);

  @$pb.TagNumber(7)
  ForwardEvent get forwardEvent => $_getN(6);
  @$pb.TagNumber(7)
  set forwardEvent(ForwardEvent v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasForwardEvent() => $_has(6);
  @$pb.TagNumber(7)
  void clearForwardEvent() => $_clearField(7);
  @$pb.TagNumber(7)
  ForwardEvent ensureForwardEvent() => $_ensure(6);

  @$pb.TagNumber(8)
  ForwardFailEvent get forwardFailEvent => $_getN(7);
  @$pb.TagNumber(8)
  set forwardFailEvent(ForwardFailEvent v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasForwardFailEvent() => $_has(7);
  @$pb.TagNumber(8)
  void clearForwardFailEvent() => $_clearField(8);
  @$pb.TagNumber(8)
  ForwardFailEvent ensureForwardFailEvent() => $_ensure(7);

  @$pb.TagNumber(9)
  SettleEvent get settleEvent => $_getN(8);
  @$pb.TagNumber(9)
  set settleEvent(SettleEvent v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSettleEvent() => $_has(8);
  @$pb.TagNumber(9)
  void clearSettleEvent() => $_clearField(9);
  @$pb.TagNumber(9)
  SettleEvent ensureSettleEvent() => $_ensure(8);

  @$pb.TagNumber(10)
  LinkFailEvent get linkFailEvent => $_getN(9);
  @$pb.TagNumber(10)
  set linkFailEvent(LinkFailEvent v) { $_setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasLinkFailEvent() => $_has(9);
  @$pb.TagNumber(10)
  void clearLinkFailEvent() => $_clearField(10);
  @$pb.TagNumber(10)
  LinkFailEvent ensureLinkFailEvent() => $_ensure(9);

  @$pb.TagNumber(11)
  SubscribedEvent get subscribedEvent => $_getN(10);
  @$pb.TagNumber(11)
  set subscribedEvent(SubscribedEvent v) { $_setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasSubscribedEvent() => $_has(10);
  @$pb.TagNumber(11)
  void clearSubscribedEvent() => $_clearField(11);
  @$pb.TagNumber(11)
  SubscribedEvent ensureSubscribedEvent() => $_ensure(10);

  @$pb.TagNumber(12)
  FinalHtlcEvent get finalHtlcEvent => $_getN(11);
  @$pb.TagNumber(12)
  set finalHtlcEvent(FinalHtlcEvent v) { $_setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasFinalHtlcEvent() => $_has(11);
  @$pb.TagNumber(12)
  void clearFinalHtlcEvent() => $_clearField(12);
  @$pb.TagNumber(12)
  FinalHtlcEvent ensureFinalHtlcEvent() => $_ensure(11);
}

class HtlcInfo extends $pb.GeneratedMessage {
  factory HtlcInfo({
    $core.int? incomingTimelock,
    $core.int? outgoingTimelock,
    $fixnum.Int64? incomingAmtMsat,
    $fixnum.Int64? outgoingAmtMsat,
  }) {
    final $result = create();
    if (incomingTimelock != null) {
      $result.incomingTimelock = incomingTimelock;
    }
    if (outgoingTimelock != null) {
      $result.outgoingTimelock = outgoingTimelock;
    }
    if (incomingAmtMsat != null) {
      $result.incomingAmtMsat = incomingAmtMsat;
    }
    if (outgoingAmtMsat != null) {
      $result.outgoingAmtMsat = outgoingAmtMsat;
    }
    return $result;
  }
  HtlcInfo._() : super();
  factory HtlcInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HtlcInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HtlcInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'incomingTimelock', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'outgoingTimelock', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'incomingAmtMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'outgoingAmtMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HtlcInfo clone() => HtlcInfo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HtlcInfo copyWith(void Function(HtlcInfo) updates) => super.copyWith((message) => updates(message as HtlcInfo)) as HtlcInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HtlcInfo create() => HtlcInfo._();
  HtlcInfo createEmptyInstance() => create();
  static $pb.PbList<HtlcInfo> createRepeated() => $pb.PbList<HtlcInfo>();
  @$core.pragma('dart2js:noInline')
  static HtlcInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HtlcInfo>(create);
  static HtlcInfo? _defaultInstance;

  /// The timelock on the incoming htlc.
  @$pb.TagNumber(1)
  $core.int get incomingTimelock => $_getIZ(0);
  @$pb.TagNumber(1)
  set incomingTimelock($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncomingTimelock() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomingTimelock() => $_clearField(1);

  /// The timelock on the outgoing htlc.
  @$pb.TagNumber(2)
  $core.int get outgoingTimelock => $_getIZ(1);
  @$pb.TagNumber(2)
  set outgoingTimelock($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutgoingTimelock() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutgoingTimelock() => $_clearField(2);

  /// The amount of the incoming htlc.
  @$pb.TagNumber(3)
  $fixnum.Int64 get incomingAmtMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set incomingAmtMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncomingAmtMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncomingAmtMsat() => $_clearField(3);

  /// The amount of the outgoing htlc.
  @$pb.TagNumber(4)
  $fixnum.Int64 get outgoingAmtMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set outgoingAmtMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutgoingAmtMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutgoingAmtMsat() => $_clearField(4);
}

class ForwardEvent extends $pb.GeneratedMessage {
  factory ForwardEvent({
    HtlcInfo? info,
  }) {
    final $result = create();
    if (info != null) {
      $result.info = info;
    }
    return $result;
  }
  ForwardEvent._() : super();
  factory ForwardEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<HtlcInfo>(1, _omitFieldNames ? '' : 'info', subBuilder: HtlcInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardEvent clone() => ForwardEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardEvent copyWith(void Function(ForwardEvent) updates) => super.copyWith((message) => updates(message as ForwardEvent)) as ForwardEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardEvent create() => ForwardEvent._();
  ForwardEvent createEmptyInstance() => create();
  static $pb.PbList<ForwardEvent> createRepeated() => $pb.PbList<ForwardEvent>();
  @$core.pragma('dart2js:noInline')
  static ForwardEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardEvent>(create);
  static ForwardEvent? _defaultInstance;

  /// Info contains details about the htlc that was forwarded.
  @$pb.TagNumber(1)
  HtlcInfo get info => $_getN(0);
  @$pb.TagNumber(1)
  set info(HtlcInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  HtlcInfo ensureInfo() => $_ensure(0);
}

class ForwardFailEvent extends $pb.GeneratedMessage {
  factory ForwardFailEvent() => create();
  ForwardFailEvent._() : super();
  factory ForwardFailEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardFailEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardFailEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardFailEvent clone() => ForwardFailEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardFailEvent copyWith(void Function(ForwardFailEvent) updates) => super.copyWith((message) => updates(message as ForwardFailEvent)) as ForwardFailEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardFailEvent create() => ForwardFailEvent._();
  ForwardFailEvent createEmptyInstance() => create();
  static $pb.PbList<ForwardFailEvent> createRepeated() => $pb.PbList<ForwardFailEvent>();
  @$core.pragma('dart2js:noInline')
  static ForwardFailEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardFailEvent>(create);
  static ForwardFailEvent? _defaultInstance;
}

class SettleEvent extends $pb.GeneratedMessage {
  factory SettleEvent({
    $core.List<$core.int>? preimage,
  }) {
    final $result = create();
    if (preimage != null) {
      $result.preimage = preimage;
    }
    return $result;
  }
  SettleEvent._() : super();
  factory SettleEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SettleEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SettleEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SettleEvent clone() => SettleEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SettleEvent copyWith(void Function(SettleEvent) updates) => super.copyWith((message) => updates(message as SettleEvent)) as SettleEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SettleEvent create() => SettleEvent._();
  SettleEvent createEmptyInstance() => create();
  static $pb.PbList<SettleEvent> createRepeated() => $pb.PbList<SettleEvent>();
  @$core.pragma('dart2js:noInline')
  static SettleEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SettleEvent>(create);
  static SettleEvent? _defaultInstance;

  /// The revealed preimage.
  @$pb.TagNumber(1)
  $core.List<$core.int> get preimage => $_getN(0);
  @$pb.TagNumber(1)
  set preimage($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPreimage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreimage() => $_clearField(1);
}

class FinalHtlcEvent extends $pb.GeneratedMessage {
  factory FinalHtlcEvent({
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
  FinalHtlcEvent._() : super();
  factory FinalHtlcEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FinalHtlcEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FinalHtlcEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'settled')
    ..aOB(2, _omitFieldNames ? '' : 'offchain')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FinalHtlcEvent clone() => FinalHtlcEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FinalHtlcEvent copyWith(void Function(FinalHtlcEvent) updates) => super.copyWith((message) => updates(message as FinalHtlcEvent)) as FinalHtlcEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FinalHtlcEvent create() => FinalHtlcEvent._();
  FinalHtlcEvent createEmptyInstance() => create();
  static $pb.PbList<FinalHtlcEvent> createRepeated() => $pb.PbList<FinalHtlcEvent>();
  @$core.pragma('dart2js:noInline')
  static FinalHtlcEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FinalHtlcEvent>(create);
  static FinalHtlcEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get settled => $_getBF(0);
  @$pb.TagNumber(1)
  set settled($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSettled() => $_has(0);
  @$pb.TagNumber(1)
  void clearSettled() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get offchain => $_getBF(1);
  @$pb.TagNumber(2)
  set offchain($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOffchain() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffchain() => $_clearField(2);
}

class SubscribedEvent extends $pb.GeneratedMessage {
  factory SubscribedEvent() => create();
  SubscribedEvent._() : super();
  factory SubscribedEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribedEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribedEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribedEvent clone() => SubscribedEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribedEvent copyWith(void Function(SubscribedEvent) updates) => super.copyWith((message) => updates(message as SubscribedEvent)) as SubscribedEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribedEvent create() => SubscribedEvent._();
  SubscribedEvent createEmptyInstance() => create();
  static $pb.PbList<SubscribedEvent> createRepeated() => $pb.PbList<SubscribedEvent>();
  @$core.pragma('dart2js:noInline')
  static SubscribedEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribedEvent>(create);
  static SubscribedEvent? _defaultInstance;
}

class LinkFailEvent extends $pb.GeneratedMessage {
  factory LinkFailEvent({
    HtlcInfo? info,
    $1.Failure_FailureCode? wireFailure,
    FailureDetail? failureDetail,
    $core.String? failureString,
  }) {
    final $result = create();
    if (info != null) {
      $result.info = info;
    }
    if (wireFailure != null) {
      $result.wireFailure = wireFailure;
    }
    if (failureDetail != null) {
      $result.failureDetail = failureDetail;
    }
    if (failureString != null) {
      $result.failureString = failureString;
    }
    return $result;
  }
  LinkFailEvent._() : super();
  factory LinkFailEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LinkFailEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LinkFailEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<HtlcInfo>(1, _omitFieldNames ? '' : 'info', subBuilder: HtlcInfo.create)
    ..e<$1.Failure_FailureCode>(2, _omitFieldNames ? '' : 'wireFailure', $pb.PbFieldType.OE, defaultOrMaker: $1.Failure_FailureCode.RESERVED, valueOf: $1.Failure_FailureCode.valueOf, enumValues: $1.Failure_FailureCode.values)
    ..e<FailureDetail>(3, _omitFieldNames ? '' : 'failureDetail', $pb.PbFieldType.OE, defaultOrMaker: FailureDetail.UNKNOWN, valueOf: FailureDetail.valueOf, enumValues: FailureDetail.values)
    ..aOS(4, _omitFieldNames ? '' : 'failureString')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LinkFailEvent clone() => LinkFailEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LinkFailEvent copyWith(void Function(LinkFailEvent) updates) => super.copyWith((message) => updates(message as LinkFailEvent)) as LinkFailEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LinkFailEvent create() => LinkFailEvent._();
  LinkFailEvent createEmptyInstance() => create();
  static $pb.PbList<LinkFailEvent> createRepeated() => $pb.PbList<LinkFailEvent>();
  @$core.pragma('dart2js:noInline')
  static LinkFailEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LinkFailEvent>(create);
  static LinkFailEvent? _defaultInstance;

  /// Info contains details about the htlc that we failed.
  @$pb.TagNumber(1)
  HtlcInfo get info => $_getN(0);
  @$pb.TagNumber(1)
  set info(HtlcInfo v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => $_clearField(1);
  @$pb.TagNumber(1)
  HtlcInfo ensureInfo() => $_ensure(0);

  /// FailureCode is the BOLT error code for the failure.
  @$pb.TagNumber(2)
  $1.Failure_FailureCode get wireFailure => $_getN(1);
  @$pb.TagNumber(2)
  set wireFailure($1.Failure_FailureCode v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasWireFailure() => $_has(1);
  @$pb.TagNumber(2)
  void clearWireFailure() => $_clearField(2);

  ///
  /// FailureDetail provides additional information about the reason for the
  /// failure. This detail enriches the information provided by the wire message
  /// and may be 'no detail' if the wire message requires no additional metadata.
  @$pb.TagNumber(3)
  FailureDetail get failureDetail => $_getN(2);
  @$pb.TagNumber(3)
  set failureDetail(FailureDetail v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFailureDetail() => $_has(2);
  @$pb.TagNumber(3)
  void clearFailureDetail() => $_clearField(3);

  /// A string representation of the link failure.
  @$pb.TagNumber(4)
  $core.String get failureString => $_getSZ(3);
  @$pb.TagNumber(4)
  set failureString($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailureString() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailureString() => $_clearField(4);
}

class PaymentStatus extends $pb.GeneratedMessage {
  factory PaymentStatus({
    PaymentState? state,
    $core.List<$core.int>? preimage,
    $core.Iterable<$1.HTLCAttempt>? htlcs,
  }) {
    final $result = create();
    if (state != null) {
      $result.state = state;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (htlcs != null) {
      $result.htlcs.addAll(htlcs);
    }
    return $result;
  }
  PaymentStatus._() : super();
  factory PaymentStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..e<PaymentState>(1, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: PaymentState.IN_FLIGHT, valueOf: PaymentState.valueOf, enumValues: PaymentState.values)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..pc<$1.HTLCAttempt>(4, _omitFieldNames ? '' : 'htlcs', $pb.PbFieldType.PM, subBuilder: $1.HTLCAttempt.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentStatus clone() => PaymentStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentStatus copyWith(void Function(PaymentStatus) updates) => super.copyWith((message) => updates(message as PaymentStatus)) as PaymentStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentStatus create() => PaymentStatus._();
  PaymentStatus createEmptyInstance() => create();
  static $pb.PbList<PaymentStatus> createRepeated() => $pb.PbList<PaymentStatus>();
  @$core.pragma('dart2js:noInline')
  static PaymentStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentStatus>(create);
  static PaymentStatus? _defaultInstance;

  /// Current state the payment is in.
  @$pb.TagNumber(1)
  PaymentState get state => $_getN(0);
  @$pb.TagNumber(1)
  set state(PaymentState v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasState() => $_has(0);
  @$pb.TagNumber(1)
  void clearState() => $_clearField(1);

  ///
  /// The pre-image of the payment when state is SUCCEEDED.
  @$pb.TagNumber(2)
  $core.List<$core.int> get preimage => $_getN(1);
  @$pb.TagNumber(2)
  set preimage($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreimage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreimage() => $_clearField(2);

  ///
  /// The HTLCs made in attempt to settle the payment [EXPERIMENTAL].
  @$pb.TagNumber(4)
  $pb.PbList<$1.HTLCAttempt> get htlcs => $_getList(2);
}

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

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CircuitKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
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

  /// / The id of the channel that the is part of this circuit.
  @$pb.TagNumber(1)
  $fixnum.Int64 get chanId => $_getI64(0);
  @$pb.TagNumber(1)
  set chanId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanId() => $_clearField(1);

  /// / The index of the incoming htlc in the incoming channel.
  @$pb.TagNumber(2)
  $fixnum.Int64 get htlcId => $_getI64(1);
  @$pb.TagNumber(2)
  set htlcId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHtlcId() => $_has(1);
  @$pb.TagNumber(2)
  void clearHtlcId() => $_clearField(2);
}

class ForwardHtlcInterceptRequest extends $pb.GeneratedMessage {
  factory ForwardHtlcInterceptRequest({
    CircuitKey? incomingCircuitKey,
    $core.List<$core.int>? paymentHash,
    $fixnum.Int64? outgoingAmountMsat,
    $core.int? outgoingExpiry,
    $fixnum.Int64? incomingAmountMsat,
    $core.int? incomingExpiry,
    $fixnum.Int64? outgoingRequestedChanId,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? customRecords,
    $core.List<$core.int>? onionBlob,
    $core.int? autoFailHeight,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? inWireCustomRecords,
  }) {
    final $result = create();
    if (incomingCircuitKey != null) {
      $result.incomingCircuitKey = incomingCircuitKey;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (outgoingAmountMsat != null) {
      $result.outgoingAmountMsat = outgoingAmountMsat;
    }
    if (outgoingExpiry != null) {
      $result.outgoingExpiry = outgoingExpiry;
    }
    if (incomingAmountMsat != null) {
      $result.incomingAmountMsat = incomingAmountMsat;
    }
    if (incomingExpiry != null) {
      $result.incomingExpiry = incomingExpiry;
    }
    if (outgoingRequestedChanId != null) {
      $result.outgoingRequestedChanId = outgoingRequestedChanId;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    if (onionBlob != null) {
      $result.onionBlob = onionBlob;
    }
    if (autoFailHeight != null) {
      $result.autoFailHeight = autoFailHeight;
    }
    if (inWireCustomRecords != null) {
      $result.inWireCustomRecords.addAll(inWireCustomRecords);
    }
    return $result;
  }
  ForwardHtlcInterceptRequest._() : super();
  factory ForwardHtlcInterceptRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardHtlcInterceptRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardHtlcInterceptRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<CircuitKey>(1, _omitFieldNames ? '' : 'incomingCircuitKey', subBuilder: CircuitKey.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'paymentHash', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'outgoingAmountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'outgoingExpiry', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'incomingAmountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'incomingExpiry', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'outgoingRequestedChanId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..m<$fixnum.Int64, $core.List<$core.int>>(8, _omitFieldNames ? '' : 'customRecords', entryClassName: 'ForwardHtlcInterceptRequest.CustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
    ..a<$core.List<$core.int>>(9, _omitFieldNames ? '' : 'onionBlob', $pb.PbFieldType.OY)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'autoFailHeight', $pb.PbFieldType.O3)
    ..m<$fixnum.Int64, $core.List<$core.int>>(11, _omitFieldNames ? '' : 'inWireCustomRecords', entryClassName: 'ForwardHtlcInterceptRequest.InWireCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardHtlcInterceptRequest clone() => ForwardHtlcInterceptRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardHtlcInterceptRequest copyWith(void Function(ForwardHtlcInterceptRequest) updates) => super.copyWith((message) => updates(message as ForwardHtlcInterceptRequest)) as ForwardHtlcInterceptRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardHtlcInterceptRequest create() => ForwardHtlcInterceptRequest._();
  ForwardHtlcInterceptRequest createEmptyInstance() => create();
  static $pb.PbList<ForwardHtlcInterceptRequest> createRepeated() => $pb.PbList<ForwardHtlcInterceptRequest>();
  @$core.pragma('dart2js:noInline')
  static ForwardHtlcInterceptRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardHtlcInterceptRequest>(create);
  static ForwardHtlcInterceptRequest? _defaultInstance;

  ///
  /// The key of this forwarded htlc. It defines the incoming channel id and
  /// the index in this channel.
  @$pb.TagNumber(1)
  CircuitKey get incomingCircuitKey => $_getN(0);
  @$pb.TagNumber(1)
  set incomingCircuitKey(CircuitKey v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncomingCircuitKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomingCircuitKey() => $_clearField(1);
  @$pb.TagNumber(1)
  CircuitKey ensureIncomingCircuitKey() => $_ensure(0);

  ///
  /// The htlc payment hash. This value is not guaranteed to be unique per
  /// request.
  @$pb.TagNumber(2)
  $core.List<$core.int> get paymentHash => $_getN(1);
  @$pb.TagNumber(2)
  set paymentHash($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentHash() => $_clearField(2);

  /// The outgoing htlc amount.
  @$pb.TagNumber(3)
  $fixnum.Int64 get outgoingAmountMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set outgoingAmountMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasOutgoingAmountMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearOutgoingAmountMsat() => $_clearField(3);

  /// The outgoing htlc expiry.
  @$pb.TagNumber(4)
  $core.int get outgoingExpiry => $_getIZ(3);
  @$pb.TagNumber(4)
  set outgoingExpiry($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutgoingExpiry() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutgoingExpiry() => $_clearField(4);

  /// The incoming htlc amount.
  @$pb.TagNumber(5)
  $fixnum.Int64 get incomingAmountMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set incomingAmountMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncomingAmountMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncomingAmountMsat() => $_clearField(5);

  /// The incoming htlc expiry.
  @$pb.TagNumber(6)
  $core.int get incomingExpiry => $_getIZ(5);
  @$pb.TagNumber(6)
  set incomingExpiry($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIncomingExpiry() => $_has(5);
  @$pb.TagNumber(6)
  void clearIncomingExpiry() => $_clearField(6);

  /// The requested outgoing channel id for this forwarded htlc. Because of
  /// non-strict forwarding, this isn't necessarily the channel over which the
  /// packet will be forwarded eventually. A different channel to the same peer
  /// may be selected as well.
  @$pb.TagNumber(7)
  $fixnum.Int64 get outgoingRequestedChanId => $_getI64(6);
  @$pb.TagNumber(7)
  set outgoingRequestedChanId($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOutgoingRequestedChanId() => $_has(6);
  @$pb.TagNumber(7)
  void clearOutgoingRequestedChanId() => $_clearField(7);

  /// Any custom records that were present in the payload.
  @$pb.TagNumber(8)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get customRecords => $_getMap(7);

  /// The onion blob for the next hop
  @$pb.TagNumber(9)
  $core.List<$core.int> get onionBlob => $_getN(8);
  @$pb.TagNumber(9)
  set onionBlob($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasOnionBlob() => $_has(8);
  @$pb.TagNumber(9)
  void clearOnionBlob() => $_clearField(9);

  /// The block height at which this htlc will be auto-failed to prevent the
  /// channel from force-closing.
  @$pb.TagNumber(10)
  $core.int get autoFailHeight => $_getIZ(9);
  @$pb.TagNumber(10)
  set autoFailHeight($core.int v) { $_setSignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasAutoFailHeight() => $_has(9);
  @$pb.TagNumber(10)
  void clearAutoFailHeight() => $_clearField(10);

  /// The custom records of the peer's incoming p2p wire message.
  @$pb.TagNumber(11)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get inWireCustomRecords => $_getMap(10);
}

/// *
/// ForwardHtlcInterceptResponse enables the caller to resolve a previously hold
/// forward. The caller can choose either to:
/// - `Resume`: Execute the default behavior (usually forward).
/// - `ResumeModified`: Execute the default behavior (usually forward) with HTLC
/// field modifications.
/// - `Reject`: Fail the htlc backwards.
/// - `Settle`: Settle this htlc with a given preimage.
class ForwardHtlcInterceptResponse extends $pb.GeneratedMessage {
  factory ForwardHtlcInterceptResponse({
    CircuitKey? incomingCircuitKey,
    ResolveHoldForwardAction? action,
    $core.List<$core.int>? preimage,
    $core.List<$core.int>? failureMessage,
    $1.Failure_FailureCode? failureCode,
    $fixnum.Int64? inAmountMsat,
    $fixnum.Int64? outAmountMsat,
    $pb.PbMap<$fixnum.Int64, $core.List<$core.int>>? outWireCustomRecords,
  }) {
    final $result = create();
    if (incomingCircuitKey != null) {
      $result.incomingCircuitKey = incomingCircuitKey;
    }
    if (action != null) {
      $result.action = action;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (failureMessage != null) {
      $result.failureMessage = failureMessage;
    }
    if (failureCode != null) {
      $result.failureCode = failureCode;
    }
    if (inAmountMsat != null) {
      $result.inAmountMsat = inAmountMsat;
    }
    if (outAmountMsat != null) {
      $result.outAmountMsat = outAmountMsat;
    }
    if (outWireCustomRecords != null) {
      $result.outWireCustomRecords.addAll(outWireCustomRecords);
    }
    return $result;
  }
  ForwardHtlcInterceptResponse._() : super();
  factory ForwardHtlcInterceptResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardHtlcInterceptResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardHtlcInterceptResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<CircuitKey>(1, _omitFieldNames ? '' : 'incomingCircuitKey', subBuilder: CircuitKey.create)
    ..e<ResolveHoldForwardAction>(2, _omitFieldNames ? '' : 'action', $pb.PbFieldType.OE, defaultOrMaker: ResolveHoldForwardAction.SETTLE, valueOf: ResolveHoldForwardAction.valueOf, enumValues: ResolveHoldForwardAction.values)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'preimage', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'failureMessage', $pb.PbFieldType.OY)
    ..e<$1.Failure_FailureCode>(5, _omitFieldNames ? '' : 'failureCode', $pb.PbFieldType.OE, defaultOrMaker: $1.Failure_FailureCode.RESERVED, valueOf: $1.Failure_FailureCode.valueOf, enumValues: $1.Failure_FailureCode.values)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'inAmountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'outAmountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..m<$fixnum.Int64, $core.List<$core.int>>(8, _omitFieldNames ? '' : 'outWireCustomRecords', entryClassName: 'ForwardHtlcInterceptResponse.OutWireCustomRecordsEntry', keyFieldType: $pb.PbFieldType.OU6, valueFieldType: $pb.PbFieldType.OY, packageName: const $pb.PackageName('routerrpc'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardHtlcInterceptResponse clone() => ForwardHtlcInterceptResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardHtlcInterceptResponse copyWith(void Function(ForwardHtlcInterceptResponse) updates) => super.copyWith((message) => updates(message as ForwardHtlcInterceptResponse)) as ForwardHtlcInterceptResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardHtlcInterceptResponse create() => ForwardHtlcInterceptResponse._();
  ForwardHtlcInterceptResponse createEmptyInstance() => create();
  static $pb.PbList<ForwardHtlcInterceptResponse> createRepeated() => $pb.PbList<ForwardHtlcInterceptResponse>();
  @$core.pragma('dart2js:noInline')
  static ForwardHtlcInterceptResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardHtlcInterceptResponse>(create);
  static ForwardHtlcInterceptResponse? _defaultInstance;

  /// *
  /// The key of this forwarded htlc. It defines the incoming channel id and
  /// the index in this channel.
  @$pb.TagNumber(1)
  CircuitKey get incomingCircuitKey => $_getN(0);
  @$pb.TagNumber(1)
  set incomingCircuitKey(CircuitKey v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasIncomingCircuitKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearIncomingCircuitKey() => $_clearField(1);
  @$pb.TagNumber(1)
  CircuitKey ensureIncomingCircuitKey() => $_ensure(0);

  /// The resolve action for this intercepted htlc.
  @$pb.TagNumber(2)
  ResolveHoldForwardAction get action => $_getN(1);
  @$pb.TagNumber(2)
  set action(ResolveHoldForwardAction v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);

  /// The preimage in case the resolve action is Settle.
  @$pb.TagNumber(3)
  $core.List<$core.int> get preimage => $_getN(2);
  @$pb.TagNumber(3)
  set preimage($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPreimage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreimage() => $_clearField(3);

  ///  Encrypted failure message in case the resolve action is Fail.
  ///
  ///  If failure_message is specified, the failure_code field must be set
  ///  to zero.
  @$pb.TagNumber(4)
  $core.List<$core.int> get failureMessage => $_getN(3);
  @$pb.TagNumber(4)
  set failureMessage($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFailureMessage() => $_has(3);
  @$pb.TagNumber(4)
  void clearFailureMessage() => $_clearField(4);

  ///  Return the specified failure code in case the resolve action is Fail. The
  ///  message data fields are populated automatically.
  ///
  ///  If a non-zero failure_code is specified, failure_message must not be set.
  ///
  ///  For backwards-compatibility reasons, TEMPORARY_CHANNEL_FAILURE is the
  ///  default value for this field.
  @$pb.TagNumber(5)
  $1.Failure_FailureCode get failureCode => $_getN(4);
  @$pb.TagNumber(5)
  set failureCode($1.Failure_FailureCode v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasFailureCode() => $_has(4);
  @$pb.TagNumber(5)
  void clearFailureCode() => $_clearField(5);

  /// The amount that was set on the p2p wire message of the incoming HTLC.
  /// This field is ignored if the action is not RESUME_MODIFIED or the amount
  /// is zero.
  @$pb.TagNumber(6)
  $fixnum.Int64 get inAmountMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set inAmountMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasInAmountMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearInAmountMsat() => $_clearField(6);

  /// The amount to set on the p2p wire message of the resumed HTLC. This field
  /// is ignored if the action is not RESUME_MODIFIED or the amount is zero.
  @$pb.TagNumber(7)
  $fixnum.Int64 get outAmountMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set outAmountMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasOutAmountMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearOutAmountMsat() => $_clearField(7);

  ///  Any custom records that should be set on the p2p wire message message of
  ///  the resumed HTLC. This field is ignored if the action is not
  ///  RESUME_MODIFIED.
  ///
  ///  This map will merge with the existing set of custom records (if any),
  ///  replacing any conflicting types. Note that there currently is no support
  ///  for deleting existing custom records (they can only be replaced).
  @$pb.TagNumber(8)
  $pb.PbMap<$fixnum.Int64, $core.List<$core.int>> get outWireCustomRecords => $_getMap(7);
}

class UpdateChanStatusRequest extends $pb.GeneratedMessage {
  factory UpdateChanStatusRequest({
    $1.ChannelPoint? chanPoint,
    ChanStatusAction? action,
  }) {
    final $result = create();
    if (chanPoint != null) {
      $result.chanPoint = chanPoint;
    }
    if (action != null) {
      $result.action = action;
    }
    return $result;
  }
  UpdateChanStatusRequest._() : super();
  factory UpdateChanStatusRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateChanStatusRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateChanStatusRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..aOM<$1.ChannelPoint>(1, _omitFieldNames ? '' : 'chanPoint', subBuilder: $1.ChannelPoint.create)
    ..e<ChanStatusAction>(2, _omitFieldNames ? '' : 'action', $pb.PbFieldType.OE, defaultOrMaker: ChanStatusAction.ENABLE, valueOf: ChanStatusAction.valueOf, enumValues: ChanStatusAction.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateChanStatusRequest clone() => UpdateChanStatusRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateChanStatusRequest copyWith(void Function(UpdateChanStatusRequest) updates) => super.copyWith((message) => updates(message as UpdateChanStatusRequest)) as UpdateChanStatusRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChanStatusRequest create() => UpdateChanStatusRequest._();
  UpdateChanStatusRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateChanStatusRequest> createRepeated() => $pb.PbList<UpdateChanStatusRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateChanStatusRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateChanStatusRequest>(create);
  static UpdateChanStatusRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.ChannelPoint get chanPoint => $_getN(0);
  @$pb.TagNumber(1)
  set chanPoint($1.ChannelPoint v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChanPoint() => $_has(0);
  @$pb.TagNumber(1)
  void clearChanPoint() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.ChannelPoint ensureChanPoint() => $_ensure(0);

  @$pb.TagNumber(2)
  ChanStatusAction get action => $_getN(1);
  @$pb.TagNumber(2)
  set action(ChanStatusAction v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);
}

class UpdateChanStatusResponse extends $pb.GeneratedMessage {
  factory UpdateChanStatusResponse() => create();
  UpdateChanStatusResponse._() : super();
  factory UpdateChanStatusResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateChanStatusResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateChanStatusResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateChanStatusResponse clone() => UpdateChanStatusResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateChanStatusResponse copyWith(void Function(UpdateChanStatusResponse) updates) => super.copyWith((message) => updates(message as UpdateChanStatusResponse)) as UpdateChanStatusResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChanStatusResponse create() => UpdateChanStatusResponse._();
  UpdateChanStatusResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateChanStatusResponse> createRepeated() => $pb.PbList<UpdateChanStatusResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateChanStatusResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateChanStatusResponse>(create);
  static UpdateChanStatusResponse? _defaultInstance;
}

class AddAliasesRequest extends $pb.GeneratedMessage {
  factory AddAliasesRequest({
    $core.Iterable<$1.AliasMap>? aliasMaps,
  }) {
    final $result = create();
    if (aliasMaps != null) {
      $result.aliasMaps.addAll(aliasMaps);
    }
    return $result;
  }
  AddAliasesRequest._() : super();
  factory AddAliasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAliasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddAliasesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..pc<$1.AliasMap>(1, _omitFieldNames ? '' : 'aliasMaps', $pb.PbFieldType.PM, subBuilder: $1.AliasMap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAliasesRequest clone() => AddAliasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAliasesRequest copyWith(void Function(AddAliasesRequest) updates) => super.copyWith((message) => updates(message as AddAliasesRequest)) as AddAliasesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddAliasesRequest create() => AddAliasesRequest._();
  AddAliasesRequest createEmptyInstance() => create();
  static $pb.PbList<AddAliasesRequest> createRepeated() => $pb.PbList<AddAliasesRequest>();
  @$core.pragma('dart2js:noInline')
  static AddAliasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddAliasesRequest>(create);
  static AddAliasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.AliasMap> get aliasMaps => $_getList(0);
}

class AddAliasesResponse extends $pb.GeneratedMessage {
  factory AddAliasesResponse({
    $core.Iterable<$1.AliasMap>? aliasMaps,
  }) {
    final $result = create();
    if (aliasMaps != null) {
      $result.aliasMaps.addAll(aliasMaps);
    }
    return $result;
  }
  AddAliasesResponse._() : super();
  factory AddAliasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AddAliasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddAliasesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..pc<$1.AliasMap>(1, _omitFieldNames ? '' : 'aliasMaps', $pb.PbFieldType.PM, subBuilder: $1.AliasMap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AddAliasesResponse clone() => AddAliasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AddAliasesResponse copyWith(void Function(AddAliasesResponse) updates) => super.copyWith((message) => updates(message as AddAliasesResponse)) as AddAliasesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddAliasesResponse create() => AddAliasesResponse._();
  AddAliasesResponse createEmptyInstance() => create();
  static $pb.PbList<AddAliasesResponse> createRepeated() => $pb.PbList<AddAliasesResponse>();
  @$core.pragma('dart2js:noInline')
  static AddAliasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddAliasesResponse>(create);
  static AddAliasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.AliasMap> get aliasMaps => $_getList(0);
}

class DeleteAliasesRequest extends $pb.GeneratedMessage {
  factory DeleteAliasesRequest({
    $core.Iterable<$1.AliasMap>? aliasMaps,
  }) {
    final $result = create();
    if (aliasMaps != null) {
      $result.aliasMaps.addAll(aliasMaps);
    }
    return $result;
  }
  DeleteAliasesRequest._() : super();
  factory DeleteAliasesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAliasesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAliasesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..pc<$1.AliasMap>(1, _omitFieldNames ? '' : 'aliasMaps', $pb.PbFieldType.PM, subBuilder: $1.AliasMap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAliasesRequest clone() => DeleteAliasesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAliasesRequest copyWith(void Function(DeleteAliasesRequest) updates) => super.copyWith((message) => updates(message as DeleteAliasesRequest)) as DeleteAliasesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAliasesRequest create() => DeleteAliasesRequest._();
  DeleteAliasesRequest createEmptyInstance() => create();
  static $pb.PbList<DeleteAliasesRequest> createRepeated() => $pb.PbList<DeleteAliasesRequest>();
  @$core.pragma('dart2js:noInline')
  static DeleteAliasesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAliasesRequest>(create);
  static DeleteAliasesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.AliasMap> get aliasMaps => $_getList(0);
}

class DeleteAliasesResponse extends $pb.GeneratedMessage {
  factory DeleteAliasesResponse({
    $core.Iterable<$1.AliasMap>? aliasMaps,
  }) {
    final $result = create();
    if (aliasMaps != null) {
      $result.aliasMaps.addAll(aliasMaps);
    }
    return $result;
  }
  DeleteAliasesResponse._() : super();
  factory DeleteAliasesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DeleteAliasesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DeleteAliasesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'routerrpc'), createEmptyInstance: create)
    ..pc<$1.AliasMap>(1, _omitFieldNames ? '' : 'aliasMaps', $pb.PbFieldType.PM, subBuilder: $1.AliasMap.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DeleteAliasesResponse clone() => DeleteAliasesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DeleteAliasesResponse copyWith(void Function(DeleteAliasesResponse) updates) => super.copyWith((message) => updates(message as DeleteAliasesResponse)) as DeleteAliasesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DeleteAliasesResponse create() => DeleteAliasesResponse._();
  DeleteAliasesResponse createEmptyInstance() => create();
  static $pb.PbList<DeleteAliasesResponse> createRepeated() => $pb.PbList<DeleteAliasesResponse>();
  @$core.pragma('dart2js:noInline')
  static DeleteAliasesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DeleteAliasesResponse>(create);
  static DeleteAliasesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$1.AliasMap> get aliasMaps => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
