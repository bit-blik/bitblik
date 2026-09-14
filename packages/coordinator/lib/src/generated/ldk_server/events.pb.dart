//
//  Generated code. Do not modify.
//  source: events.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'events.pbenum.dart';
import 'types.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'events.pbenum.dart';

enum EventEnvelope_Event {
  paymentReceived, 
  paymentSuccessful, 
  paymentFailed, 
  paymentForwarded, 
  paymentClaimable, 
  channelStateChanged, 
  notSet
}

/// EventEnvelope wraps different event types in a single message to be used by EventPublisher.
class EventEnvelope extends $pb.GeneratedMessage {
  factory EventEnvelope({
    PaymentReceived? paymentReceived,
    PaymentSuccessful? paymentSuccessful,
    PaymentFailed? paymentFailed,
    PaymentForwarded? paymentForwarded,
    PaymentClaimable? paymentClaimable,
    ChannelStateChanged? channelStateChanged,
  }) {
    final $result = create();
    if (paymentReceived != null) {
      $result.paymentReceived = paymentReceived;
    }
    if (paymentSuccessful != null) {
      $result.paymentSuccessful = paymentSuccessful;
    }
    if (paymentFailed != null) {
      $result.paymentFailed = paymentFailed;
    }
    if (paymentForwarded != null) {
      $result.paymentForwarded = paymentForwarded;
    }
    if (paymentClaimable != null) {
      $result.paymentClaimable = paymentClaimable;
    }
    if (channelStateChanged != null) {
      $result.channelStateChanged = channelStateChanged;
    }
    return $result;
  }
  EventEnvelope._() : super();
  factory EventEnvelope.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventEnvelope.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, EventEnvelope_Event> _EventEnvelope_EventByTag = {
    2 : EventEnvelope_Event.paymentReceived,
    3 : EventEnvelope_Event.paymentSuccessful,
    4 : EventEnvelope_Event.paymentFailed,
    6 : EventEnvelope_Event.paymentForwarded,
    7 : EventEnvelope_Event.paymentClaimable,
    8 : EventEnvelope_Event.channelStateChanged,
    0 : EventEnvelope_Event.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EventEnvelope', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 6, 7, 8])
    ..aOM<PaymentReceived>(2, _omitFieldNames ? '' : 'paymentReceived', subBuilder: PaymentReceived.create)
    ..aOM<PaymentSuccessful>(3, _omitFieldNames ? '' : 'paymentSuccessful', subBuilder: PaymentSuccessful.create)
    ..aOM<PaymentFailed>(4, _omitFieldNames ? '' : 'paymentFailed', subBuilder: PaymentFailed.create)
    ..aOM<PaymentForwarded>(6, _omitFieldNames ? '' : 'paymentForwarded', subBuilder: PaymentForwarded.create)
    ..aOM<PaymentClaimable>(7, _omitFieldNames ? '' : 'paymentClaimable', subBuilder: PaymentClaimable.create)
    ..aOM<ChannelStateChanged>(8, _omitFieldNames ? '' : 'channelStateChanged', subBuilder: ChannelStateChanged.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EventEnvelope clone() => EventEnvelope()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EventEnvelope copyWith(void Function(EventEnvelope) updates) => super.copyWith((message) => updates(message as EventEnvelope)) as EventEnvelope;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventEnvelope create() => EventEnvelope._();
  EventEnvelope createEmptyInstance() => create();
  static $pb.PbList<EventEnvelope> createRepeated() => $pb.PbList<EventEnvelope>();
  @$core.pragma('dart2js:noInline')
  static EventEnvelope getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventEnvelope>(create);
  static EventEnvelope? _defaultInstance;

  EventEnvelope_Event whichEvent() => _EventEnvelope_EventByTag[$_whichOneof(0)]!;
  void clearEvent() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(2)
  PaymentReceived get paymentReceived => $_getN(0);
  @$pb.TagNumber(2)
  set paymentReceived(PaymentReceived v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentReceived() => $_has(0);
  @$pb.TagNumber(2)
  void clearPaymentReceived() => $_clearField(2);
  @$pb.TagNumber(2)
  PaymentReceived ensurePaymentReceived() => $_ensure(0);

  @$pb.TagNumber(3)
  PaymentSuccessful get paymentSuccessful => $_getN(1);
  @$pb.TagNumber(3)
  set paymentSuccessful(PaymentSuccessful v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentSuccessful() => $_has(1);
  @$pb.TagNumber(3)
  void clearPaymentSuccessful() => $_clearField(3);
  @$pb.TagNumber(3)
  PaymentSuccessful ensurePaymentSuccessful() => $_ensure(1);

  @$pb.TagNumber(4)
  PaymentFailed get paymentFailed => $_getN(2);
  @$pb.TagNumber(4)
  set paymentFailed(PaymentFailed v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentFailed() => $_has(2);
  @$pb.TagNumber(4)
  void clearPaymentFailed() => $_clearField(4);
  @$pb.TagNumber(4)
  PaymentFailed ensurePaymentFailed() => $_ensure(2);

  @$pb.TagNumber(6)
  PaymentForwarded get paymentForwarded => $_getN(3);
  @$pb.TagNumber(6)
  set paymentForwarded(PaymentForwarded v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentForwarded() => $_has(3);
  @$pb.TagNumber(6)
  void clearPaymentForwarded() => $_clearField(6);
  @$pb.TagNumber(6)
  PaymentForwarded ensurePaymentForwarded() => $_ensure(3);

  @$pb.TagNumber(7)
  PaymentClaimable get paymentClaimable => $_getN(4);
  @$pb.TagNumber(7)
  set paymentClaimable(PaymentClaimable v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPaymentClaimable() => $_has(4);
  @$pb.TagNumber(7)
  void clearPaymentClaimable() => $_clearField(7);
  @$pb.TagNumber(7)
  PaymentClaimable ensurePaymentClaimable() => $_ensure(4);

  @$pb.TagNumber(8)
  ChannelStateChanged get channelStateChanged => $_getN(5);
  @$pb.TagNumber(8)
  set channelStateChanged(ChannelStateChanged v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasChannelStateChanged() => $_has(5);
  @$pb.TagNumber(8)
  void clearChannelStateChanged() => $_clearField(8);
  @$pb.TagNumber(8)
  ChannelStateChanged ensureChannelStateChanged() => $_ensure(5);
}

class CounterpartyForceClosedDetails extends $pb.GeneratedMessage {
  factory CounterpartyForceClosedDetails({
    $core.String? peerMsg,
  }) {
    final $result = create();
    if (peerMsg != null) {
      $result.peerMsg = peerMsg;
    }
    return $result;
  }
  CounterpartyForceClosedDetails._() : super();
  factory CounterpartyForceClosedDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CounterpartyForceClosedDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CounterpartyForceClosedDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'peerMsg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CounterpartyForceClosedDetails clone() => CounterpartyForceClosedDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CounterpartyForceClosedDetails copyWith(void Function(CounterpartyForceClosedDetails) updates) => super.copyWith((message) => updates(message as CounterpartyForceClosedDetails)) as CounterpartyForceClosedDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CounterpartyForceClosedDetails create() => CounterpartyForceClosedDetails._();
  CounterpartyForceClosedDetails createEmptyInstance() => create();
  static $pb.PbList<CounterpartyForceClosedDetails> createRepeated() => $pb.PbList<CounterpartyForceClosedDetails>();
  @$core.pragma('dart2js:noInline')
  static CounterpartyForceClosedDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CounterpartyForceClosedDetails>(create);
  static CounterpartyForceClosedDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get peerMsg => $_getSZ(0);
  @$pb.TagNumber(1)
  set peerMsg($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeerMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeerMsg() => $_clearField(1);
}

class HolderForceClosedDetails extends $pb.GeneratedMessage {
  factory HolderForceClosedDetails({
    $core.bool? broadcastedLatestTxn,
    $core.String? message,
  }) {
    final $result = create();
    if (broadcastedLatestTxn != null) {
      $result.broadcastedLatestTxn = broadcastedLatestTxn;
    }
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  HolderForceClosedDetails._() : super();
  factory HolderForceClosedDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HolderForceClosedDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HolderForceClosedDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'broadcastedLatestTxn')
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HolderForceClosedDetails clone() => HolderForceClosedDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HolderForceClosedDetails copyWith(void Function(HolderForceClosedDetails) updates) => super.copyWith((message) => updates(message as HolderForceClosedDetails)) as HolderForceClosedDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HolderForceClosedDetails create() => HolderForceClosedDetails._();
  HolderForceClosedDetails createEmptyInstance() => create();
  static $pb.PbList<HolderForceClosedDetails> createRepeated() => $pb.PbList<HolderForceClosedDetails>();
  @$core.pragma('dart2js:noInline')
  static HolderForceClosedDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HolderForceClosedDetails>(create);
  static HolderForceClosedDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get broadcastedLatestTxn => $_getBF(0);
  @$pb.TagNumber(1)
  set broadcastedLatestTxn($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBroadcastedLatestTxn() => $_has(0);
  @$pb.TagNumber(1)
  void clearBroadcastedLatestTxn() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);
}

class ProcessingErrorDetails extends $pb.GeneratedMessage {
  factory ProcessingErrorDetails({
    $core.String? err,
  }) {
    final $result = create();
    if (err != null) {
      $result.err = err;
    }
    return $result;
  }
  ProcessingErrorDetails._() : super();
  factory ProcessingErrorDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ProcessingErrorDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProcessingErrorDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'err')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ProcessingErrorDetails clone() => ProcessingErrorDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ProcessingErrorDetails copyWith(void Function(ProcessingErrorDetails) updates) => super.copyWith((message) => updates(message as ProcessingErrorDetails)) as ProcessingErrorDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProcessingErrorDetails create() => ProcessingErrorDetails._();
  ProcessingErrorDetails createEmptyInstance() => create();
  static $pb.PbList<ProcessingErrorDetails> createRepeated() => $pb.PbList<ProcessingErrorDetails>();
  @$core.pragma('dart2js:noInline')
  static ProcessingErrorDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProcessingErrorDetails>(create);
  static ProcessingErrorDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get err => $_getSZ(0);
  @$pb.TagNumber(1)
  set err($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasErr() => $_has(0);
  @$pb.TagNumber(1)
  void clearErr() => $_clearField(1);
}

class HtlcsTimedOutDetails extends $pb.GeneratedMessage {
  factory HtlcsTimedOutDetails({
    $core.String? paymentHash,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  HtlcsTimedOutDetails._() : super();
  factory HtlcsTimedOutDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HtlcsTimedOutDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HtlcsTimedOutDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentHash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HtlcsTimedOutDetails clone() => HtlcsTimedOutDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HtlcsTimedOutDetails copyWith(void Function(HtlcsTimedOutDetails) updates) => super.copyWith((message) => updates(message as HtlcsTimedOutDetails)) as HtlcsTimedOutDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HtlcsTimedOutDetails create() => HtlcsTimedOutDetails._();
  HtlcsTimedOutDetails createEmptyInstance() => create();
  static $pb.PbList<HtlcsTimedOutDetails> createRepeated() => $pb.PbList<HtlcsTimedOutDetails>();
  @$core.pragma('dart2js:noInline')
  static HtlcsTimedOutDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HtlcsTimedOutDetails>(create);
  static HtlcsTimedOutDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get paymentHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);
}

class PeerFeerateTooLowDetails extends $pb.GeneratedMessage {
  factory PeerFeerateTooLowDetails({
    $core.int? peerFeerateSatPerKw,
    $core.int? requiredFeerateSatPerKw,
  }) {
    final $result = create();
    if (peerFeerateSatPerKw != null) {
      $result.peerFeerateSatPerKw = peerFeerateSatPerKw;
    }
    if (requiredFeerateSatPerKw != null) {
      $result.requiredFeerateSatPerKw = requiredFeerateSatPerKw;
    }
    return $result;
  }
  PeerFeerateTooLowDetails._() : super();
  factory PeerFeerateTooLowDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PeerFeerateTooLowDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PeerFeerateTooLowDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'peerFeerateSatPerKw', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'requiredFeerateSatPerKw', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PeerFeerateTooLowDetails clone() => PeerFeerateTooLowDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PeerFeerateTooLowDetails copyWith(void Function(PeerFeerateTooLowDetails) updates) => super.copyWith((message) => updates(message as PeerFeerateTooLowDetails)) as PeerFeerateTooLowDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PeerFeerateTooLowDetails create() => PeerFeerateTooLowDetails._();
  PeerFeerateTooLowDetails createEmptyInstance() => create();
  static $pb.PbList<PeerFeerateTooLowDetails> createRepeated() => $pb.PbList<PeerFeerateTooLowDetails>();
  @$core.pragma('dart2js:noInline')
  static PeerFeerateTooLowDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PeerFeerateTooLowDetails>(create);
  static PeerFeerateTooLowDetails? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get peerFeerateSatPerKw => $_getIZ(0);
  @$pb.TagNumber(1)
  set peerFeerateSatPerKw($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPeerFeerateSatPerKw() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeerFeerateSatPerKw() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get requiredFeerateSatPerKw => $_getIZ(1);
  @$pb.TagNumber(2)
  set requiredFeerateSatPerKw($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRequiredFeerateSatPerKw() => $_has(1);
  @$pb.TagNumber(2)
  void clearRequiredFeerateSatPerKw() => $_clearField(2);
}

enum ChannelStateChangeReason_Details {
  counterpartyForceClosed, 
  holderForceClosed, 
  processingError, 
  htlcsTimedOut, 
  peerFeerateTooLow, 
  notSet
}

class ChannelStateChangeReason extends $pb.GeneratedMessage {
  factory ChannelStateChangeReason({
    ChannelStateChangeReasonKind? kind,
    $core.String? message,
    CounterpartyForceClosedDetails? counterpartyForceClosed,
    HolderForceClosedDetails? holderForceClosed,
    ProcessingErrorDetails? processingError,
    HtlcsTimedOutDetails? htlcsTimedOut,
    PeerFeerateTooLowDetails? peerFeerateTooLow,
  }) {
    final $result = create();
    if (kind != null) {
      $result.kind = kind;
    }
    if (message != null) {
      $result.message = message;
    }
    if (counterpartyForceClosed != null) {
      $result.counterpartyForceClosed = counterpartyForceClosed;
    }
    if (holderForceClosed != null) {
      $result.holderForceClosed = holderForceClosed;
    }
    if (processingError != null) {
      $result.processingError = processingError;
    }
    if (htlcsTimedOut != null) {
      $result.htlcsTimedOut = htlcsTimedOut;
    }
    if (peerFeerateTooLow != null) {
      $result.peerFeerateTooLow = peerFeerateTooLow;
    }
    return $result;
  }
  ChannelStateChangeReason._() : super();
  factory ChannelStateChangeReason.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelStateChangeReason.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ChannelStateChangeReason_Details> _ChannelStateChangeReason_DetailsByTag = {
    3 : ChannelStateChangeReason_Details.counterpartyForceClosed,
    4 : ChannelStateChangeReason_Details.holderForceClosed,
    5 : ChannelStateChangeReason_Details.processingError,
    6 : ChannelStateChangeReason_Details.htlcsTimedOut,
    7 : ChannelStateChangeReason_Details.peerFeerateTooLow,
    0 : ChannelStateChangeReason_Details.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelStateChangeReason', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6, 7])
    ..e<ChannelStateChangeReasonKind>(1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE, defaultOrMaker: ChannelStateChangeReasonKind.CHANNEL_STATE_CHANGE_REASON_KIND_UNSPECIFIED, valueOf: ChannelStateChangeReasonKind.valueOf, enumValues: ChannelStateChangeReasonKind.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aOM<CounterpartyForceClosedDetails>(3, _omitFieldNames ? '' : 'counterpartyForceClosed', subBuilder: CounterpartyForceClosedDetails.create)
    ..aOM<HolderForceClosedDetails>(4, _omitFieldNames ? '' : 'holderForceClosed', subBuilder: HolderForceClosedDetails.create)
    ..aOM<ProcessingErrorDetails>(5, _omitFieldNames ? '' : 'processingError', subBuilder: ProcessingErrorDetails.create)
    ..aOM<HtlcsTimedOutDetails>(6, _omitFieldNames ? '' : 'htlcsTimedOut', subBuilder: HtlcsTimedOutDetails.create)
    ..aOM<PeerFeerateTooLowDetails>(7, _omitFieldNames ? '' : 'peerFeerateTooLow', subBuilder: PeerFeerateTooLowDetails.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelStateChangeReason clone() => ChannelStateChangeReason()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelStateChangeReason copyWith(void Function(ChannelStateChangeReason) updates) => super.copyWith((message) => updates(message as ChannelStateChangeReason)) as ChannelStateChangeReason;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelStateChangeReason create() => ChannelStateChangeReason._();
  ChannelStateChangeReason createEmptyInstance() => create();
  static $pb.PbList<ChannelStateChangeReason> createRepeated() => $pb.PbList<ChannelStateChangeReason>();
  @$core.pragma('dart2js:noInline')
  static ChannelStateChangeReason getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelStateChangeReason>(create);
  static ChannelStateChangeReason? _defaultInstance;

  ChannelStateChangeReason_Details whichDetails() => _ChannelStateChangeReason_DetailsByTag[$_whichOneof(0)]!;
  void clearDetails() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  ChannelStateChangeReasonKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(ChannelStateChangeReasonKind v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  @$pb.TagNumber(3)
  CounterpartyForceClosedDetails get counterpartyForceClosed => $_getN(2);
  @$pb.TagNumber(3)
  set counterpartyForceClosed(CounterpartyForceClosedDetails v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCounterpartyForceClosed() => $_has(2);
  @$pb.TagNumber(3)
  void clearCounterpartyForceClosed() => $_clearField(3);
  @$pb.TagNumber(3)
  CounterpartyForceClosedDetails ensureCounterpartyForceClosed() => $_ensure(2);

  @$pb.TagNumber(4)
  HolderForceClosedDetails get holderForceClosed => $_getN(3);
  @$pb.TagNumber(4)
  set holderForceClosed(HolderForceClosedDetails v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasHolderForceClosed() => $_has(3);
  @$pb.TagNumber(4)
  void clearHolderForceClosed() => $_clearField(4);
  @$pb.TagNumber(4)
  HolderForceClosedDetails ensureHolderForceClosed() => $_ensure(3);

  @$pb.TagNumber(5)
  ProcessingErrorDetails get processingError => $_getN(4);
  @$pb.TagNumber(5)
  set processingError(ProcessingErrorDetails v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasProcessingError() => $_has(4);
  @$pb.TagNumber(5)
  void clearProcessingError() => $_clearField(5);
  @$pb.TagNumber(5)
  ProcessingErrorDetails ensureProcessingError() => $_ensure(4);

  @$pb.TagNumber(6)
  HtlcsTimedOutDetails get htlcsTimedOut => $_getN(5);
  @$pb.TagNumber(6)
  set htlcsTimedOut(HtlcsTimedOutDetails v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasHtlcsTimedOut() => $_has(5);
  @$pb.TagNumber(6)
  void clearHtlcsTimedOut() => $_clearField(6);
  @$pb.TagNumber(6)
  HtlcsTimedOutDetails ensureHtlcsTimedOut() => $_ensure(5);

  @$pb.TagNumber(7)
  PeerFeerateTooLowDetails get peerFeerateTooLow => $_getN(6);
  @$pb.TagNumber(7)
  set peerFeerateTooLow(PeerFeerateTooLowDetails v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasPeerFeerateTooLow() => $_has(6);
  @$pb.TagNumber(7)
  void clearPeerFeerateTooLow() => $_clearField(7);
  @$pb.TagNumber(7)
  PeerFeerateTooLowDetails ensurePeerFeerateTooLow() => $_ensure(6);
}

class ChannelStateChanged extends $pb.GeneratedMessage {
  factory ChannelStateChanged({
    $core.String? channelId,
    $core.String? userChannelId,
    $core.String? counterpartyNodeId,
    ChannelState? state,
    $core.String? fundingTxo,
    ChannelStateChangeReason? reason,
    ChannelClosureInitiator? closureInitiator,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (state != null) {
      $result.state = state;
    }
    if (fundingTxo != null) {
      $result.fundingTxo = fundingTxo;
    }
    if (reason != null) {
      $result.reason = reason;
    }
    if (closureInitiator != null) {
      $result.closureInitiator = closureInitiator;
    }
    return $result;
  }
  ChannelStateChanged._() : super();
  factory ChannelStateChanged.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelStateChanged.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelStateChanged', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(3, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..e<ChannelState>(4, _omitFieldNames ? '' : 'state', $pb.PbFieldType.OE, defaultOrMaker: ChannelState.CHANNEL_STATE_UNSPECIFIED, valueOf: ChannelState.valueOf, enumValues: ChannelState.values)
    ..aOS(5, _omitFieldNames ? '' : 'fundingTxo')
    ..aOM<ChannelStateChangeReason>(6, _omitFieldNames ? '' : 'reason', subBuilder: ChannelStateChangeReason.create)
    ..e<ChannelClosureInitiator>(7, _omitFieldNames ? '' : 'closureInitiator', $pb.PbFieldType.OE, defaultOrMaker: ChannelClosureInitiator.CHANNEL_CLOSURE_INITIATOR_UNSPECIFIED, valueOf: ChannelClosureInitiator.valueOf, enumValues: ChannelClosureInitiator.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelStateChanged clone() => ChannelStateChanged()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelStateChanged copyWith(void Function(ChannelStateChanged) updates) => super.copyWith((message) => updates(message as ChannelStateChanged)) as ChannelStateChanged;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelStateChanged create() => ChannelStateChanged._();
  ChannelStateChanged createEmptyInstance() => create();
  static $pb.PbList<ChannelStateChanged> createRepeated() => $pb.PbList<ChannelStateChanged>();
  @$core.pragma('dart2js:noInline')
  static ChannelStateChanged getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelStateChanged>(create);
  static ChannelStateChanged? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get userChannelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userChannelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserChannelId() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get counterpartyNodeId => $_getSZ(2);
  @$pb.TagNumber(3)
  set counterpartyNodeId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCounterpartyNodeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCounterpartyNodeId() => $_clearField(3);

  @$pb.TagNumber(4)
  ChannelState get state => $_getN(3);
  @$pb.TagNumber(4)
  set state(ChannelState v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasState() => $_has(3);
  @$pb.TagNumber(4)
  void clearState() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fundingTxo => $_getSZ(4);
  @$pb.TagNumber(5)
  set fundingTxo($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFundingTxo() => $_has(4);
  @$pb.TagNumber(5)
  void clearFundingTxo() => $_clearField(5);

  @$pb.TagNumber(6)
  ChannelStateChangeReason get reason => $_getN(5);
  @$pb.TagNumber(6)
  set reason(ChannelStateChangeReason v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasReason() => $_has(5);
  @$pb.TagNumber(6)
  void clearReason() => $_clearField(6);
  @$pb.TagNumber(6)
  ChannelStateChangeReason ensureReason() => $_ensure(5);

  @$pb.TagNumber(7)
  ChannelClosureInitiator get closureInitiator => $_getN(6);
  @$pb.TagNumber(7)
  set closureInitiator(ChannelClosureInitiator v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasClosureInitiator() => $_has(6);
  @$pb.TagNumber(7)
  void clearClosureInitiator() => $_clearField(7);
}

/// PaymentReceived indicates a payment has been received.
class PaymentReceived extends $pb.GeneratedMessage {
  factory PaymentReceived({
    $2.Payment? payment,
    $core.Iterable<$2.CustomTlvRecord>? customRecords,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    return $result;
  }
  PaymentReceived._() : super();
  factory PaymentReceived.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentReceived.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentReceived', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOM<$2.Payment>(1, _omitFieldNames ? '' : 'payment', subBuilder: $2.Payment.create)
    ..pc<$2.CustomTlvRecord>(2, _omitFieldNames ? '' : 'customRecords', $pb.PbFieldType.PM, subBuilder: $2.CustomTlvRecord.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentReceived clone() => PaymentReceived()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentReceived copyWith(void Function(PaymentReceived) updates) => super.copyWith((message) => updates(message as PaymentReceived)) as PaymentReceived;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentReceived create() => PaymentReceived._();
  PaymentReceived createEmptyInstance() => create();
  static $pb.PbList<PaymentReceived> createRepeated() => $pb.PbList<PaymentReceived>();
  @$core.pragma('dart2js:noInline')
  static PaymentReceived getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentReceived>(create);
  static PaymentReceived? _defaultInstance;

  /// The payment details for the payment in event.
  @$pb.TagNumber(1)
  $2.Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment($2.Payment v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Payment ensurePayment() => $_ensure(0);

  /// Custom TLV records attached to the incoming payment, if any.
  @$pb.TagNumber(2)
  $pb.PbList<$2.CustomTlvRecord> get customRecords => $_getList(1);
}

/// PaymentSuccessful indicates a sent payment was successful.
class PaymentSuccessful extends $pb.GeneratedMessage {
  factory PaymentSuccessful({
    $2.Payment? payment,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    return $result;
  }
  PaymentSuccessful._() : super();
  factory PaymentSuccessful.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentSuccessful.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentSuccessful', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOM<$2.Payment>(1, _omitFieldNames ? '' : 'payment', subBuilder: $2.Payment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentSuccessful clone() => PaymentSuccessful()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentSuccessful copyWith(void Function(PaymentSuccessful) updates) => super.copyWith((message) => updates(message as PaymentSuccessful)) as PaymentSuccessful;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentSuccessful create() => PaymentSuccessful._();
  PaymentSuccessful createEmptyInstance() => create();
  static $pb.PbList<PaymentSuccessful> createRepeated() => $pb.PbList<PaymentSuccessful>();
  @$core.pragma('dart2js:noInline')
  static PaymentSuccessful getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentSuccessful>(create);
  static PaymentSuccessful? _defaultInstance;

  /// The payment details for the payment in event.
  @$pb.TagNumber(1)
  $2.Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment($2.Payment v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Payment ensurePayment() => $_ensure(0);
}

/// PaymentFailed indicates a sent payment has failed.
class PaymentFailed extends $pb.GeneratedMessage {
  factory PaymentFailed({
    $2.Payment? payment,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    return $result;
  }
  PaymentFailed._() : super();
  factory PaymentFailed.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentFailed.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentFailed', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOM<$2.Payment>(1, _omitFieldNames ? '' : 'payment', subBuilder: $2.Payment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentFailed clone() => PaymentFailed()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentFailed copyWith(void Function(PaymentFailed) updates) => super.copyWith((message) => updates(message as PaymentFailed)) as PaymentFailed;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentFailed create() => PaymentFailed._();
  PaymentFailed createEmptyInstance() => create();
  static $pb.PbList<PaymentFailed> createRepeated() => $pb.PbList<PaymentFailed>();
  @$core.pragma('dart2js:noInline')
  static PaymentFailed getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentFailed>(create);
  static PaymentFailed? _defaultInstance;

  /// The payment details for the payment in event.
  @$pb.TagNumber(1)
  $2.Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment($2.Payment v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Payment ensurePayment() => $_ensure(0);
}

/// PaymentClaimable indicates a payment has arrived and is waiting to be manually claimed or failed.
/// This event is only emitted for payments created via `Bolt11ReceiveForHash`.
class PaymentClaimable extends $pb.GeneratedMessage {
  factory PaymentClaimable({
    $2.Payment? payment,
    $core.Iterable<$2.CustomTlvRecord>? customRecords,
    $core.int? claimDeadline,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    if (customRecords != null) {
      $result.customRecords.addAll(customRecords);
    }
    if (claimDeadline != null) {
      $result.claimDeadline = claimDeadline;
    }
    return $result;
  }
  PaymentClaimable._() : super();
  factory PaymentClaimable.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentClaimable.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentClaimable', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOM<$2.Payment>(1, _omitFieldNames ? '' : 'payment', subBuilder: $2.Payment.create)
    ..pc<$2.CustomTlvRecord>(2, _omitFieldNames ? '' : 'customRecords', $pb.PbFieldType.PM, subBuilder: $2.CustomTlvRecord.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'claimDeadline', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentClaimable clone() => PaymentClaimable()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentClaimable copyWith(void Function(PaymentClaimable) updates) => super.copyWith((message) => updates(message as PaymentClaimable)) as PaymentClaimable;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentClaimable create() => PaymentClaimable._();
  PaymentClaimable createEmptyInstance() => create();
  static $pb.PbList<PaymentClaimable> createRepeated() => $pb.PbList<PaymentClaimable>();
  @$core.pragma('dart2js:noInline')
  static PaymentClaimable getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentClaimable>(create);
  static PaymentClaimable? _defaultInstance;

  /// The payment details for the claimable payment.
  @$pb.TagNumber(1)
  $2.Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment($2.Payment v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Payment ensurePayment() => $_ensure(0);

  /// Custom TLV records attached to the claimable payment, if any.
  @$pb.TagNumber(2)
  $pb.PbList<$2.CustomTlvRecord> get customRecords => $_getList(1);

  /// The block height by which this payment must be claimed before it is failed back.
  @$pb.TagNumber(3)
  $core.int get claimDeadline => $_getIZ(2);
  @$pb.TagNumber(3)
  set claimDeadline($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasClaimDeadline() => $_has(2);
  @$pb.TagNumber(3)
  void clearClaimDeadline() => $_clearField(3);
}

/// PaymentForwarded indicates a payment was forwarded through the node.
class PaymentForwarded extends $pb.GeneratedMessage {
  factory PaymentForwarded({
    $2.ForwardedPayment? forwardedPayment,
  }) {
    final $result = create();
    if (forwardedPayment != null) {
      $result.forwardedPayment = forwardedPayment;
    }
    return $result;
  }
  PaymentForwarded._() : super();
  factory PaymentForwarded.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentForwarded.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentForwarded', package: const $pb.PackageName(_omitMessageNames ? '' : 'events'), createEmptyInstance: create)
    ..aOM<$2.ForwardedPayment>(1, _omitFieldNames ? '' : 'forwardedPayment', subBuilder: $2.ForwardedPayment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentForwarded clone() => PaymentForwarded()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentForwarded copyWith(void Function(PaymentForwarded) updates) => super.copyWith((message) => updates(message as PaymentForwarded)) as PaymentForwarded;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentForwarded create() => PaymentForwarded._();
  PaymentForwarded createEmptyInstance() => create();
  static $pb.PbList<PaymentForwarded> createRepeated() => $pb.PbList<PaymentForwarded>();
  @$core.pragma('dart2js:noInline')
  static PaymentForwarded getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentForwarded>(create);
  static PaymentForwarded? _defaultInstance;

  @$pb.TagNumber(1)
  $2.ForwardedPayment get forwardedPayment => $_getN(0);
  @$pb.TagNumber(1)
  set forwardedPayment($2.ForwardedPayment v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasForwardedPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearForwardedPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.ForwardedPayment ensureForwardedPayment() => $_ensure(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
