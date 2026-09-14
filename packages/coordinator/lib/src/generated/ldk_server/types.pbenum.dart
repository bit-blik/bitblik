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
