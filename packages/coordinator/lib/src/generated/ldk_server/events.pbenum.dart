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

class ChannelState extends $pb.ProtobufEnum {
  static const ChannelState CHANNEL_STATE_UNSPECIFIED = ChannelState._(0, _omitEnumNames ? '' : 'CHANNEL_STATE_UNSPECIFIED');
  static const ChannelState CHANNEL_STATE_PENDING = ChannelState._(1, _omitEnumNames ? '' : 'CHANNEL_STATE_PENDING');
  static const ChannelState CHANNEL_STATE_READY = ChannelState._(2, _omitEnumNames ? '' : 'CHANNEL_STATE_READY');
  static const ChannelState CHANNEL_STATE_OPEN_FAILED = ChannelState._(3, _omitEnumNames ? '' : 'CHANNEL_STATE_OPEN_FAILED');
  static const ChannelState CHANNEL_STATE_CLOSED = ChannelState._(4, _omitEnumNames ? '' : 'CHANNEL_STATE_CLOSED');

  static const $core.List<ChannelState> values = <ChannelState> [
    CHANNEL_STATE_UNSPECIFIED,
    CHANNEL_STATE_PENDING,
    CHANNEL_STATE_READY,
    CHANNEL_STATE_OPEN_FAILED,
    CHANNEL_STATE_CLOSED,
  ];

  static final $core.Map<$core.int, ChannelState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelState? valueOf($core.int value) => _byValue[value];

  const ChannelState._(super.v, super.n);
}

class ChannelClosureInitiator extends $pb.ProtobufEnum {
  static const ChannelClosureInitiator CHANNEL_CLOSURE_INITIATOR_UNSPECIFIED = ChannelClosureInitiator._(0, _omitEnumNames ? '' : 'CHANNEL_CLOSURE_INITIATOR_UNSPECIFIED');
  static const ChannelClosureInitiator CHANNEL_CLOSURE_INITIATOR_LOCAL = ChannelClosureInitiator._(1, _omitEnumNames ? '' : 'CHANNEL_CLOSURE_INITIATOR_LOCAL');
  static const ChannelClosureInitiator CHANNEL_CLOSURE_INITIATOR_REMOTE = ChannelClosureInitiator._(2, _omitEnumNames ? '' : 'CHANNEL_CLOSURE_INITIATOR_REMOTE');
  static const ChannelClosureInitiator CHANNEL_CLOSURE_INITIATOR_UNKNOWN = ChannelClosureInitiator._(3, _omitEnumNames ? '' : 'CHANNEL_CLOSURE_INITIATOR_UNKNOWN');

  static const $core.List<ChannelClosureInitiator> values = <ChannelClosureInitiator> [
    CHANNEL_CLOSURE_INITIATOR_UNSPECIFIED,
    CHANNEL_CLOSURE_INITIATOR_LOCAL,
    CHANNEL_CLOSURE_INITIATOR_REMOTE,
    CHANNEL_CLOSURE_INITIATOR_UNKNOWN,
  ];

  static final $core.Map<$core.int, ChannelClosureInitiator> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelClosureInitiator? valueOf($core.int value) => _byValue[value];

  const ChannelClosureInitiator._(super.v, super.n);
}

class ChannelStateChangeReasonKind extends $pb.ProtobufEnum {
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_UNSPECIFIED = ChannelStateChangeReasonKind._(0, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_UNSPECIFIED');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_FORCE_CLOSED = ChannelStateChangeReasonKind._(1, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_FORCE_CLOSED');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_HOLDER_FORCE_CLOSED = ChannelStateChangeReasonKind._(2, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_HOLDER_FORCE_CLOSED');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_LEGACY_COOPERATIVE_CLOSURE = ChannelStateChangeReasonKind._(3, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_LEGACY_COOPERATIVE_CLOSURE');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_INITIATED_COOPERATIVE_CLOSURE = ChannelStateChangeReasonKind._(4, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_INITIATED_COOPERATIVE_CLOSURE');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_INITIATED_COOPERATIVE_CLOSURE = ChannelStateChangeReasonKind._(5, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_INITIATED_COOPERATIVE_CLOSURE');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_COMMITMENT_TX_CONFIRMED = ChannelStateChangeReasonKind._(6, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_COMMITMENT_TX_CONFIRMED');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_TIMED_OUT = ChannelStateChangeReasonKind._(7, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_TIMED_OUT');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_PROCESSING_ERROR = ChannelStateChangeReasonKind._(8, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_PROCESSING_ERROR');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_DISCONNECTED_PEER = ChannelStateChangeReasonKind._(9, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_DISCONNECTED_PEER');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_OUTDATED_CHANNEL_MANAGER = ChannelStateChangeReasonKind._(10, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_OUTDATED_CHANNEL_MANAGER');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_COOP_CLOSED_UNFUNDED_CHANNEL = ChannelStateChangeReasonKind._(11, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_COOP_CLOSED_UNFUNDED_CHANNEL');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_COOP_CLOSED_UNFUNDED_CHANNEL = ChannelStateChangeReasonKind._(12, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_COOP_CLOSED_UNFUNDED_CHANNEL');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_BATCH_CLOSURE = ChannelStateChangeReasonKind._(13, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_BATCH_CLOSURE');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_HTLCS_TIMED_OUT = ChannelStateChangeReasonKind._(14, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_HTLCS_TIMED_OUT');
  static const ChannelStateChangeReasonKind CHANNEL_STATE_CHANGE_REASON_KIND_PEER_FEERATE_TOO_LOW = ChannelStateChangeReasonKind._(15, _omitEnumNames ? '' : 'CHANNEL_STATE_CHANGE_REASON_KIND_PEER_FEERATE_TOO_LOW');

  static const $core.List<ChannelStateChangeReasonKind> values = <ChannelStateChangeReasonKind> [
    CHANNEL_STATE_CHANGE_REASON_KIND_UNSPECIFIED,
    CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_FORCE_CLOSED,
    CHANNEL_STATE_CHANGE_REASON_KIND_HOLDER_FORCE_CLOSED,
    CHANNEL_STATE_CHANGE_REASON_KIND_LEGACY_COOPERATIVE_CLOSURE,
    CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_INITIATED_COOPERATIVE_CLOSURE,
    CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_INITIATED_COOPERATIVE_CLOSURE,
    CHANNEL_STATE_CHANGE_REASON_KIND_COMMITMENT_TX_CONFIRMED,
    CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_TIMED_OUT,
    CHANNEL_STATE_CHANGE_REASON_KIND_PROCESSING_ERROR,
    CHANNEL_STATE_CHANGE_REASON_KIND_DISCONNECTED_PEER,
    CHANNEL_STATE_CHANGE_REASON_KIND_OUTDATED_CHANNEL_MANAGER,
    CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_COOP_CLOSED_UNFUNDED_CHANNEL,
    CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_COOP_CLOSED_UNFUNDED_CHANNEL,
    CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_BATCH_CLOSURE,
    CHANNEL_STATE_CHANGE_REASON_KIND_HTLCS_TIMED_OUT,
    CHANNEL_STATE_CHANGE_REASON_KIND_PEER_FEERATE_TOO_LOW,
  ];

  static final $core.Map<$core.int, ChannelStateChangeReasonKind> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelStateChangeReasonKind? valueOf($core.int value) => _byValue[value];

  const ChannelStateChangeReasonKind._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
