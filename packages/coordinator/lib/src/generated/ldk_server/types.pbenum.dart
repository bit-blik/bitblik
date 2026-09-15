//
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// Represents the direction of a payment.
class PaymentDirection extends $pb.ProtobufEnum {
  /// The payment is inbound.
  static const PaymentDirection INBOUND = PaymentDirection._(0, _omitEnumNames ? '' : 'INBOUND');
  /// The payment is outbound.
  static const PaymentDirection OUTBOUND = PaymentDirection._(1, _omitEnumNames ? '' : 'OUTBOUND');

  static const $core.List<PaymentDirection> values = <PaymentDirection> [
    INBOUND,
    OUTBOUND,
  ];

  static final $core.Map<$core.int, PaymentDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentDirection? valueOf($core.int value) => _byValue[value];

  const PaymentDirection._(super.v, super.n);
}

/// Represents the current status of a payment.
class PaymentStatus extends $pb.ProtobufEnum {
  /// The payment is still pending.
  static const PaymentStatus PENDING = PaymentStatus._(0, _omitEnumNames ? '' : 'PENDING');
  /// The payment succeeded.
  static const PaymentStatus SUCCEEDED = PaymentStatus._(1, _omitEnumNames ? '' : 'SUCCEEDED');
  /// The payment failed.
  static const PaymentStatus FAILED = PaymentStatus._(2, _omitEnumNames ? '' : 'FAILED');

  static const $core.List<PaymentStatus> values = <PaymentStatus> [
    PENDING,
    SUCCEEDED,
    FAILED,
  ];

  static final $core.Map<$core.int, PaymentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentStatus? valueOf($core.int value) => _byValue[value];

  const PaymentStatus._(super.v, super.n);
}

/// The Bitcoin network the node is running on.
class Network extends $pb.ProtobufEnum {
  /// Mainnet Bitcoin.
  static const Network BITCOIN = Network._(0, _omitEnumNames ? '' : 'BITCOIN');
  /// Bitcoin's testnet (testnet3) network.
  static const Network TESTNET = Network._(1, _omitEnumNames ? '' : 'TESTNET');
  /// Bitcoin's testnet4 network.
  static const Network TESTNET4 = Network._(2, _omitEnumNames ? '' : 'TESTNET4');
  /// Bitcoin's signet network.
  static const Network SIGNET = Network._(3, _omitEnumNames ? '' : 'SIGNET');
  /// Bitcoin's regtest network.
  static const Network REGTEST = Network._(4, _omitEnumNames ? '' : 'REGTEST');

  static const $core.List<Network> values = <Network> [
    BITCOIN,
    TESTNET,
    TESTNET4,
    SIGNET,
    REGTEST,
  ];

  static final $core.Map<$core.int, Network> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Network? valueOf($core.int value) => _byValue[value];

  const Network._(super.v, super.n);
}

/// ChannelShutdownState mirrors LDK's `lightning::ln::channel_state::ChannelShutdownState`,
/// indicating how far along a channel is in the cooperative close process.
class ChannelShutdownState extends $pb.ProtobufEnum {
  static const ChannelShutdownState CHANNEL_SHUTDOWN_STATE_UNSPECIFIED = ChannelShutdownState._(0, _omitEnumNames ? '' : 'CHANNEL_SHUTDOWN_STATE_UNSPECIFIED');
  /// Channel has not sent or received a shutdown message.
  static const ChannelShutdownState CHANNEL_SHUTDOWN_STATE_NOT_SHUTTING_DOWN = ChannelShutdownState._(1, _omitEnumNames ? '' : 'CHANNEL_SHUTDOWN_STATE_NOT_SHUTTING_DOWN');
  /// Local node has sent a shutdown message for this channel.
  static const ChannelShutdownState CHANNEL_SHUTDOWN_STATE_SHUTDOWN_INITIATED = ChannelShutdownState._(2, _omitEnumNames ? '' : 'CHANNEL_SHUTDOWN_STATE_SHUTDOWN_INITIATED');
  /// Shutdown message exchanges have concluded and the channels are in the midst of
  /// resolving all existing open HTLCs before closing can continue.
  static const ChannelShutdownState CHANNEL_SHUTDOWN_STATE_RESOLVING_HTLCS = ChannelShutdownState._(3, _omitEnumNames ? '' : 'CHANNEL_SHUTDOWN_STATE_RESOLVING_HTLCS');
  /// All HTLCs have been resolved, nodes are currently negotiating channel close onchain fee
  /// rates.
  static const ChannelShutdownState CHANNEL_SHUTDOWN_STATE_NEGOTIATING_CLOSING_FEE = ChannelShutdownState._(4, _omitEnumNames ? '' : 'CHANNEL_SHUTDOWN_STATE_NEGOTIATING_CLOSING_FEE');
  /// We've successfully negotiated a closing_signed dance. At this point the channel is about
  /// to be dropped.
  static const ChannelShutdownState CHANNEL_SHUTDOWN_STATE_SHUTDOWN_COMPLETE = ChannelShutdownState._(5, _omitEnumNames ? '' : 'CHANNEL_SHUTDOWN_STATE_SHUTDOWN_COMPLETE');

  static const $core.List<ChannelShutdownState> values = <ChannelShutdownState> [
    CHANNEL_SHUTDOWN_STATE_UNSPECIFIED,
    CHANNEL_SHUTDOWN_STATE_NOT_SHUTTING_DOWN,
    CHANNEL_SHUTDOWN_STATE_SHUTDOWN_INITIATED,
    CHANNEL_SHUTDOWN_STATE_RESOLVING_HTLCS,
    CHANNEL_SHUTDOWN_STATE_NEGOTIATING_CLOSING_FEE,
    CHANNEL_SHUTDOWN_STATE_SHUTDOWN_COMPLETE,
  ];

  static final $core.Map<$core.int, ChannelShutdownState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelShutdownState? valueOf($core.int value) => _byValue[value];

  const ChannelShutdownState._(super.v, super.n);
}

/// ReserveType mirrors LDK Node's `ReserveType`, indicating the kind of on-chain reserve
/// maintained for a channel, if any has been determined yet.
class ReserveType extends $pb.ProtobufEnum {
  static const ReserveType RESERVE_TYPE_UNSPECIFIED = ReserveType._(0, _omitEnumNames ? '' : 'RESERVE_TYPE_UNSPECIFIED');
  /// An anchor outputs channel where we maintain a per-channel on-chain reserve for fee
  /// bumping force-close transactions.
  static const ReserveType RESERVE_TYPE_ADAPTIVE = ReserveType._(1, _omitEnumNames ? '' : 'RESERVE_TYPE_ADAPTIVE');
  /// An anchor outputs channel where we do not maintain any reserve, because the counterparty
  /// is in our trusted_peers_no_reserve list.
  static const ReserveType RESERVE_TYPE_TRUSTED_PEERS_NO_RESERVE = ReserveType._(2, _omitEnumNames ? '' : 'RESERVE_TYPE_TRUSTED_PEERS_NO_RESERVE');
  /// A legacy (pre-anchor) channel using only option_static_remotekey.
  static const ReserveType RESERVE_TYPE_LEGACY = ReserveType._(3, _omitEnumNames ? '' : 'RESERVE_TYPE_LEGACY');

  static const $core.List<ReserveType> values = <ReserveType> [
    RESERVE_TYPE_UNSPECIFIED,
    RESERVE_TYPE_ADAPTIVE,
    RESERVE_TYPE_TRUSTED_PEERS_NO_RESERVE,
    RESERVE_TYPE_LEGACY,
  ];

  static final $core.Map<$core.int, ReserveType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ReserveType? valueOf($core.int value) => _byValue[value];

  const ReserveType._(super.v, super.n);
}

/// Indicates whether the balance is derived from a cooperative close, a force-close (for holder or counterparty),
/// or whether it is for an HTLC.
class BalanceSource extends $pb.ProtobufEnum {
  /// The channel was force closed by the holder.
  static const BalanceSource HOLDER_FORCE_CLOSED = BalanceSource._(0, _omitEnumNames ? '' : 'HOLDER_FORCE_CLOSED');
  /// The channel was force closed by the counterparty.
  static const BalanceSource COUNTERPARTY_FORCE_CLOSED = BalanceSource._(1, _omitEnumNames ? '' : 'COUNTERPARTY_FORCE_CLOSED');
  /// The channel was cooperatively closed.
  static const BalanceSource COOP_CLOSE = BalanceSource._(2, _omitEnumNames ? '' : 'COOP_CLOSE');
  /// This balance is the result of an HTLC.
  static const BalanceSource HTLC = BalanceSource._(3, _omitEnumNames ? '' : 'HTLC');

  static const $core.List<BalanceSource> values = <BalanceSource> [
    HOLDER_FORCE_CLOSED,
    COUNTERPARTY_FORCE_CLOSED,
    COOP_CLOSE,
    HTLC,
  ];

  static final $core.Map<$core.int, BalanceSource> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BalanceSource? valueOf($core.int value) => _byValue[value];

  const BalanceSource._(super.v, super.n);
}

/// Identifies one of the two endpoints of a channel, by lexicographic order of
/// node ids.
class ChannelDirection extends $pb.ProtobufEnum {
  /// The endpoint whose node id is lexicographically smaller.
  static const ChannelDirection NODE_ONE = ChannelDirection._(0, _omitEnumNames ? '' : 'NODE_ONE');
  /// The endpoint whose node id is lexicographically greater.
  static const ChannelDirection NODE_TWO = ChannelDirection._(1, _omitEnumNames ? '' : 'NODE_TWO');

  static const $core.List<ChannelDirection> values = <ChannelDirection> [
    NODE_ONE,
    NODE_TWO,
  ];

  static final $core.Map<$core.int, ChannelDirection> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelDirection? valueOf($core.int value) => _byValue[value];

  const ChannelDirection._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
