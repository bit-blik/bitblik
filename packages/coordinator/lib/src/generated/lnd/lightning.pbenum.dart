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

import 'package:protobuf/protobuf.dart' as $pb;

class OutputScriptType extends $pb.ProtobufEnum {
  static const OutputScriptType SCRIPT_TYPE_PUBKEY_HASH = OutputScriptType._(0, _omitEnumNames ? '' : 'SCRIPT_TYPE_PUBKEY_HASH');
  static const OutputScriptType SCRIPT_TYPE_SCRIPT_HASH = OutputScriptType._(1, _omitEnumNames ? '' : 'SCRIPT_TYPE_SCRIPT_HASH');
  static const OutputScriptType SCRIPT_TYPE_WITNESS_V0_PUBKEY_HASH = OutputScriptType._(2, _omitEnumNames ? '' : 'SCRIPT_TYPE_WITNESS_V0_PUBKEY_HASH');
  static const OutputScriptType SCRIPT_TYPE_WITNESS_V0_SCRIPT_HASH = OutputScriptType._(3, _omitEnumNames ? '' : 'SCRIPT_TYPE_WITNESS_V0_SCRIPT_HASH');
  static const OutputScriptType SCRIPT_TYPE_PUBKEY = OutputScriptType._(4, _omitEnumNames ? '' : 'SCRIPT_TYPE_PUBKEY');
  static const OutputScriptType SCRIPT_TYPE_MULTISIG = OutputScriptType._(5, _omitEnumNames ? '' : 'SCRIPT_TYPE_MULTISIG');
  static const OutputScriptType SCRIPT_TYPE_NULLDATA = OutputScriptType._(6, _omitEnumNames ? '' : 'SCRIPT_TYPE_NULLDATA');
  static const OutputScriptType SCRIPT_TYPE_NON_STANDARD = OutputScriptType._(7, _omitEnumNames ? '' : 'SCRIPT_TYPE_NON_STANDARD');
  static const OutputScriptType SCRIPT_TYPE_WITNESS_UNKNOWN = OutputScriptType._(8, _omitEnumNames ? '' : 'SCRIPT_TYPE_WITNESS_UNKNOWN');
  static const OutputScriptType SCRIPT_TYPE_WITNESS_V1_TAPROOT = OutputScriptType._(9, _omitEnumNames ? '' : 'SCRIPT_TYPE_WITNESS_V1_TAPROOT');

  static const $core.List<OutputScriptType> values = <OutputScriptType> [
    SCRIPT_TYPE_PUBKEY_HASH,
    SCRIPT_TYPE_SCRIPT_HASH,
    SCRIPT_TYPE_WITNESS_V0_PUBKEY_HASH,
    SCRIPT_TYPE_WITNESS_V0_SCRIPT_HASH,
    SCRIPT_TYPE_PUBKEY,
    SCRIPT_TYPE_MULTISIG,
    SCRIPT_TYPE_NULLDATA,
    SCRIPT_TYPE_NON_STANDARD,
    SCRIPT_TYPE_WITNESS_UNKNOWN,
    SCRIPT_TYPE_WITNESS_V1_TAPROOT,
  ];

  static final $core.Map<$core.int, OutputScriptType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OutputScriptType? valueOf($core.int value) => _byValue[value];

  const OutputScriptType._(super.v, super.n);
}

class CoinSelectionStrategy extends $pb.ProtobufEnum {
  /// Use the coin selection strategy defined in the global configuration
  /// (lnd.conf).
  static const CoinSelectionStrategy STRATEGY_USE_GLOBAL_CONFIG = CoinSelectionStrategy._(0, _omitEnumNames ? '' : 'STRATEGY_USE_GLOBAL_CONFIG');
  /// Select the largest available coins first during coin selection.
  static const CoinSelectionStrategy STRATEGY_LARGEST = CoinSelectionStrategy._(1, _omitEnumNames ? '' : 'STRATEGY_LARGEST');
  /// Randomly select the available coins during coin selection.
  static const CoinSelectionStrategy STRATEGY_RANDOM = CoinSelectionStrategy._(2, _omitEnumNames ? '' : 'STRATEGY_RANDOM');

  static const $core.List<CoinSelectionStrategy> values = <CoinSelectionStrategy> [
    STRATEGY_USE_GLOBAL_CONFIG,
    STRATEGY_LARGEST,
    STRATEGY_RANDOM,
  ];

  static final $core.Map<$core.int, CoinSelectionStrategy> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CoinSelectionStrategy? valueOf($core.int value) => _byValue[value];

  const CoinSelectionStrategy._(super.v, super.n);
}

///
/// `AddressType` has to be one of:
///
/// - `p2wkh`: Pay to witness key hash (`WITNESS_PUBKEY_HASH` = 0)
/// - `np2wkh`: Pay to nested witness key hash (`NESTED_PUBKEY_HASH` = 1)
/// - `p2tr`: Pay to taproot pubkey (`TAPROOT_PUBKEY` = 4)
class AddressType extends $pb.ProtobufEnum {
  static const AddressType WITNESS_PUBKEY_HASH = AddressType._(0, _omitEnumNames ? '' : 'WITNESS_PUBKEY_HASH');
  static const AddressType NESTED_PUBKEY_HASH = AddressType._(1, _omitEnumNames ? '' : 'NESTED_PUBKEY_HASH');
  static const AddressType UNUSED_WITNESS_PUBKEY_HASH = AddressType._(2, _omitEnumNames ? '' : 'UNUSED_WITNESS_PUBKEY_HASH');
  static const AddressType UNUSED_NESTED_PUBKEY_HASH = AddressType._(3, _omitEnumNames ? '' : 'UNUSED_NESTED_PUBKEY_HASH');
  static const AddressType TAPROOT_PUBKEY = AddressType._(4, _omitEnumNames ? '' : 'TAPROOT_PUBKEY');
  static const AddressType UNUSED_TAPROOT_PUBKEY = AddressType._(5, _omitEnumNames ? '' : 'UNUSED_TAPROOT_PUBKEY');

  static const $core.List<AddressType> values = <AddressType> [
    WITNESS_PUBKEY_HASH,
    NESTED_PUBKEY_HASH,
    UNUSED_WITNESS_PUBKEY_HASH,
    UNUSED_NESTED_PUBKEY_HASH,
    TAPROOT_PUBKEY,
    UNUSED_TAPROOT_PUBKEY,
  ];

  static final $core.Map<$core.int, AddressType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AddressType? valueOf($core.int value) => _byValue[value];

  const AddressType._(super.v, super.n);
}

class CommitmentType extends $pb.ProtobufEnum {
  ///
  /// Returned when the commitment type isn't known or unavailable.
  static const CommitmentType UNKNOWN_COMMITMENT_TYPE = CommitmentType._(0, _omitEnumNames ? '' : 'UNKNOWN_COMMITMENT_TYPE');
  ///
  /// A channel using the legacy commitment format having tweaked to_remote
  /// keys.
  static const CommitmentType LEGACY = CommitmentType._(1, _omitEnumNames ? '' : 'LEGACY');
  ///
  /// A channel that uses the modern commitment format where the key in the
  /// output of the remote party does not change each state. This makes back
  /// up and recovery easier as when the channel is closed, the funds go
  /// directly to that key.
  static const CommitmentType STATIC_REMOTE_KEY = CommitmentType._(2, _omitEnumNames ? '' : 'STATIC_REMOTE_KEY');
  ///
  /// A channel that uses a commitment format that has anchor outputs on the
  /// commitments, allowing fee bumping after a force close transaction has
  /// been broadcast.
  static const CommitmentType ANCHORS = CommitmentType._(3, _omitEnumNames ? '' : 'ANCHORS');
  ///
  /// A channel that uses a commitment type that builds upon the anchors
  /// commitment format, but in addition requires a CLTV clause to spend outputs
  /// paying to the channel initiator. This is intended for use on leased channels
  /// to guarantee that the channel initiator has no incentives to close a leased
  /// channel before its maturity date.
  static const CommitmentType SCRIPT_ENFORCED_LEASE = CommitmentType._(4, _omitEnumNames ? '' : 'SCRIPT_ENFORCED_LEASE');
  ///
  /// A channel that uses musig2 for the funding output, and the new tapscript
  /// features where relevant.
  static const CommitmentType SIMPLE_TAPROOT = CommitmentType._(5, _omitEnumNames ? '' : 'SIMPLE_TAPROOT');
  ///
  /// Identical to the SIMPLE_TAPROOT channel type, but with extra functionality.
  /// This channel type also commits to additional meta data in the tapscript
  /// leaves for the scripts in a channel.
  static const CommitmentType SIMPLE_TAPROOT_OVERLAY = CommitmentType._(6, _omitEnumNames ? '' : 'SIMPLE_TAPROOT_OVERLAY');

  static const $core.List<CommitmentType> values = <CommitmentType> [
    UNKNOWN_COMMITMENT_TYPE,
    LEGACY,
    STATIC_REMOTE_KEY,
    ANCHORS,
    SCRIPT_ENFORCED_LEASE,
    SIMPLE_TAPROOT,
    SIMPLE_TAPROOT_OVERLAY,
  ];

  static final $core.Map<$core.int, CommitmentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CommitmentType? valueOf($core.int value) => _byValue[value];

  const CommitmentType._(super.v, super.n);
}

class Initiator extends $pb.ProtobufEnum {
  static const Initiator INITIATOR_UNKNOWN = Initiator._(0, _omitEnumNames ? '' : 'INITIATOR_UNKNOWN');
  static const Initiator INITIATOR_LOCAL = Initiator._(1, _omitEnumNames ? '' : 'INITIATOR_LOCAL');
  static const Initiator INITIATOR_REMOTE = Initiator._(2, _omitEnumNames ? '' : 'INITIATOR_REMOTE');
  static const Initiator INITIATOR_BOTH = Initiator._(3, _omitEnumNames ? '' : 'INITIATOR_BOTH');

  static const $core.List<Initiator> values = <Initiator> [
    INITIATOR_UNKNOWN,
    INITIATOR_LOCAL,
    INITIATOR_REMOTE,
    INITIATOR_BOTH,
  ];

  static final $core.Map<$core.int, Initiator> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Initiator? valueOf($core.int value) => _byValue[value];

  const Initiator._(super.v, super.n);
}

class ResolutionType extends $pb.ProtobufEnum {
  static const ResolutionType TYPE_UNKNOWN = ResolutionType._(0, _omitEnumNames ? '' : 'TYPE_UNKNOWN');
  /// We resolved an anchor output.
  static const ResolutionType ANCHOR = ResolutionType._(1, _omitEnumNames ? '' : 'ANCHOR');
  ///
  /// We are resolving an incoming htlc on chain. This if this htlc is
  /// claimed, we swept the incoming htlc with the preimage. If it is timed
  /// out, our peer swept the timeout path.
  static const ResolutionType INCOMING_HTLC = ResolutionType._(2, _omitEnumNames ? '' : 'INCOMING_HTLC');
  ///
  /// We are resolving an outgoing htlc on chain. If this htlc is claimed,
  /// the remote party swept the htlc with the preimage. If it is timed out,
  /// we swept it with the timeout path.
  static const ResolutionType OUTGOING_HTLC = ResolutionType._(3, _omitEnumNames ? '' : 'OUTGOING_HTLC');
  /// We force closed and need to sweep our time locked commitment output.
  static const ResolutionType COMMIT = ResolutionType._(4, _omitEnumNames ? '' : 'COMMIT');

  static const $core.List<ResolutionType> values = <ResolutionType> [
    TYPE_UNKNOWN,
    ANCHOR,
    INCOMING_HTLC,
    OUTGOING_HTLC,
    COMMIT,
  ];

  static final $core.Map<$core.int, ResolutionType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ResolutionType? valueOf($core.int value) => _byValue[value];

  const ResolutionType._(super.v, super.n);
}

class ResolutionOutcome extends $pb.ProtobufEnum {
  /// Outcome unknown.
  static const ResolutionOutcome OUTCOME_UNKNOWN = ResolutionOutcome._(0, _omitEnumNames ? '' : 'OUTCOME_UNKNOWN');
  /// An output was claimed on chain.
  static const ResolutionOutcome CLAIMED = ResolutionOutcome._(1, _omitEnumNames ? '' : 'CLAIMED');
  /// An output was left unclaimed on chain.
  static const ResolutionOutcome UNCLAIMED = ResolutionOutcome._(2, _omitEnumNames ? '' : 'UNCLAIMED');
  ///
  /// ResolverOutcomeAbandoned indicates that an output that we did not
  /// claim on chain, for example an anchor that we did not sweep and a
  /// third party claimed on chain, or a htlc that we could not decode
  /// so left unclaimed.
  static const ResolutionOutcome ABANDONED = ResolutionOutcome._(3, _omitEnumNames ? '' : 'ABANDONED');
  ///
  /// If we force closed our channel, our htlcs need to be claimed in two
  /// stages. This outcome represents the broadcast of a timeout or success
  /// transaction for this two stage htlc claim.
  static const ResolutionOutcome FIRST_STAGE = ResolutionOutcome._(4, _omitEnumNames ? '' : 'FIRST_STAGE');
  /// A htlc was timed out on chain.
  static const ResolutionOutcome TIMEOUT = ResolutionOutcome._(5, _omitEnumNames ? '' : 'TIMEOUT');

  static const $core.List<ResolutionOutcome> values = <ResolutionOutcome> [
    OUTCOME_UNKNOWN,
    CLAIMED,
    UNCLAIMED,
    ABANDONED,
    FIRST_STAGE,
    TIMEOUT,
  ];

  static final $core.Map<$core.int, ResolutionOutcome> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ResolutionOutcome? valueOf($core.int value) => _byValue[value];

  const ResolutionOutcome._(super.v, super.n);
}

class NodeMetricType extends $pb.ProtobufEnum {
  static const NodeMetricType UNKNOWN = NodeMetricType._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const NodeMetricType BETWEENNESS_CENTRALITY = NodeMetricType._(1, _omitEnumNames ? '' : 'BETWEENNESS_CENTRALITY');

  static const $core.List<NodeMetricType> values = <NodeMetricType> [
    UNKNOWN,
    BETWEENNESS_CENTRALITY,
  ];

  static final $core.Map<$core.int, NodeMetricType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NodeMetricType? valueOf($core.int value) => _byValue[value];

  const NodeMetricType._(super.v, super.n);
}

class InvoiceHTLCState extends $pb.ProtobufEnum {
  static const InvoiceHTLCState ACCEPTED = InvoiceHTLCState._(0, _omitEnumNames ? '' : 'ACCEPTED');
  static const InvoiceHTLCState SETTLED = InvoiceHTLCState._(1, _omitEnumNames ? '' : 'SETTLED');
  static const InvoiceHTLCState CANCELED = InvoiceHTLCState._(2, _omitEnumNames ? '' : 'CANCELED');

  static const $core.List<InvoiceHTLCState> values = <InvoiceHTLCState> [
    ACCEPTED,
    SETTLED,
    CANCELED,
  ];

  static final $core.Map<$core.int, InvoiceHTLCState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InvoiceHTLCState? valueOf($core.int value) => _byValue[value];

  const InvoiceHTLCState._(super.v, super.n);
}

class PaymentFailureReason extends $pb.ProtobufEnum {
  ///
  /// Payment isn't failed (yet).
  static const PaymentFailureReason FAILURE_REASON_NONE = PaymentFailureReason._(0, _omitEnumNames ? '' : 'FAILURE_REASON_NONE');
  ///
  /// There are more routes to try, but the payment timeout was exceeded.
  static const PaymentFailureReason FAILURE_REASON_TIMEOUT = PaymentFailureReason._(1, _omitEnumNames ? '' : 'FAILURE_REASON_TIMEOUT');
  ///
  /// All possible routes were tried and failed permanently. Or were no
  /// routes to the destination at all.
  static const PaymentFailureReason FAILURE_REASON_NO_ROUTE = PaymentFailureReason._(2, _omitEnumNames ? '' : 'FAILURE_REASON_NO_ROUTE');
  ///
  /// A non-recoverable error has occured.
  static const PaymentFailureReason FAILURE_REASON_ERROR = PaymentFailureReason._(3, _omitEnumNames ? '' : 'FAILURE_REASON_ERROR');
  ///
  /// Payment details incorrect (unknown hash, invalid amt or
  /// invalid final cltv delta)
  static const PaymentFailureReason FAILURE_REASON_INCORRECT_PAYMENT_DETAILS = PaymentFailureReason._(4, _omitEnumNames ? '' : 'FAILURE_REASON_INCORRECT_PAYMENT_DETAILS');
  ///
  /// Insufficient local balance.
  static const PaymentFailureReason FAILURE_REASON_INSUFFICIENT_BALANCE = PaymentFailureReason._(5, _omitEnumNames ? '' : 'FAILURE_REASON_INSUFFICIENT_BALANCE');
  ///
  /// The payment was canceled.
  static const PaymentFailureReason FAILURE_REASON_CANCELED = PaymentFailureReason._(6, _omitEnumNames ? '' : 'FAILURE_REASON_CANCELED');

  static const $core.List<PaymentFailureReason> values = <PaymentFailureReason> [
    FAILURE_REASON_NONE,
    FAILURE_REASON_TIMEOUT,
    FAILURE_REASON_NO_ROUTE,
    FAILURE_REASON_ERROR,
    FAILURE_REASON_INCORRECT_PAYMENT_DETAILS,
    FAILURE_REASON_INSUFFICIENT_BALANCE,
    FAILURE_REASON_CANCELED,
  ];

  static final $core.Map<$core.int, PaymentFailureReason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentFailureReason? valueOf($core.int value) => _byValue[value];

  const PaymentFailureReason._(super.v, super.n);
}

class FeatureBit extends $pb.ProtobufEnum {
  static const FeatureBit DATALOSS_PROTECT_REQ = FeatureBit._(0, _omitEnumNames ? '' : 'DATALOSS_PROTECT_REQ');
  static const FeatureBit DATALOSS_PROTECT_OPT = FeatureBit._(1, _omitEnumNames ? '' : 'DATALOSS_PROTECT_OPT');
  static const FeatureBit INITIAL_ROUING_SYNC = FeatureBit._(3, _omitEnumNames ? '' : 'INITIAL_ROUING_SYNC');
  static const FeatureBit UPFRONT_SHUTDOWN_SCRIPT_REQ = FeatureBit._(4, _omitEnumNames ? '' : 'UPFRONT_SHUTDOWN_SCRIPT_REQ');
  static const FeatureBit UPFRONT_SHUTDOWN_SCRIPT_OPT = FeatureBit._(5, _omitEnumNames ? '' : 'UPFRONT_SHUTDOWN_SCRIPT_OPT');
  static const FeatureBit GOSSIP_QUERIES_REQ = FeatureBit._(6, _omitEnumNames ? '' : 'GOSSIP_QUERIES_REQ');
  static const FeatureBit GOSSIP_QUERIES_OPT = FeatureBit._(7, _omitEnumNames ? '' : 'GOSSIP_QUERIES_OPT');
  static const FeatureBit TLV_ONION_REQ = FeatureBit._(8, _omitEnumNames ? '' : 'TLV_ONION_REQ');
  static const FeatureBit TLV_ONION_OPT = FeatureBit._(9, _omitEnumNames ? '' : 'TLV_ONION_OPT');
  static const FeatureBit EXT_GOSSIP_QUERIES_REQ = FeatureBit._(10, _omitEnumNames ? '' : 'EXT_GOSSIP_QUERIES_REQ');
  static const FeatureBit EXT_GOSSIP_QUERIES_OPT = FeatureBit._(11, _omitEnumNames ? '' : 'EXT_GOSSIP_QUERIES_OPT');
  static const FeatureBit STATIC_REMOTE_KEY_REQ = FeatureBit._(12, _omitEnumNames ? '' : 'STATIC_REMOTE_KEY_REQ');
  static const FeatureBit STATIC_REMOTE_KEY_OPT = FeatureBit._(13, _omitEnumNames ? '' : 'STATIC_REMOTE_KEY_OPT');
  static const FeatureBit PAYMENT_ADDR_REQ = FeatureBit._(14, _omitEnumNames ? '' : 'PAYMENT_ADDR_REQ');
  static const FeatureBit PAYMENT_ADDR_OPT = FeatureBit._(15, _omitEnumNames ? '' : 'PAYMENT_ADDR_OPT');
  static const FeatureBit MPP_REQ = FeatureBit._(16, _omitEnumNames ? '' : 'MPP_REQ');
  static const FeatureBit MPP_OPT = FeatureBit._(17, _omitEnumNames ? '' : 'MPP_OPT');
  static const FeatureBit WUMBO_CHANNELS_REQ = FeatureBit._(18, _omitEnumNames ? '' : 'WUMBO_CHANNELS_REQ');
  static const FeatureBit WUMBO_CHANNELS_OPT = FeatureBit._(19, _omitEnumNames ? '' : 'WUMBO_CHANNELS_OPT');
  static const FeatureBit ANCHORS_REQ = FeatureBit._(20, _omitEnumNames ? '' : 'ANCHORS_REQ');
  static const FeatureBit ANCHORS_OPT = FeatureBit._(21, _omitEnumNames ? '' : 'ANCHORS_OPT');
  static const FeatureBit ANCHORS_ZERO_FEE_HTLC_REQ = FeatureBit._(22, _omitEnumNames ? '' : 'ANCHORS_ZERO_FEE_HTLC_REQ');
  static const FeatureBit ANCHORS_ZERO_FEE_HTLC_OPT = FeatureBit._(23, _omitEnumNames ? '' : 'ANCHORS_ZERO_FEE_HTLC_OPT');
  static const FeatureBit ROUTE_BLINDING_REQUIRED = FeatureBit._(24, _omitEnumNames ? '' : 'ROUTE_BLINDING_REQUIRED');
  static const FeatureBit ROUTE_BLINDING_OPTIONAL = FeatureBit._(25, _omitEnumNames ? '' : 'ROUTE_BLINDING_OPTIONAL');
  static const FeatureBit AMP_REQ = FeatureBit._(30, _omitEnumNames ? '' : 'AMP_REQ');
  static const FeatureBit AMP_OPT = FeatureBit._(31, _omitEnumNames ? '' : 'AMP_OPT');

  static const $core.List<FeatureBit> values = <FeatureBit> [
    DATALOSS_PROTECT_REQ,
    DATALOSS_PROTECT_OPT,
    INITIAL_ROUING_SYNC,
    UPFRONT_SHUTDOWN_SCRIPT_REQ,
    UPFRONT_SHUTDOWN_SCRIPT_OPT,
    GOSSIP_QUERIES_REQ,
    GOSSIP_QUERIES_OPT,
    TLV_ONION_REQ,
    TLV_ONION_OPT,
    EXT_GOSSIP_QUERIES_REQ,
    EXT_GOSSIP_QUERIES_OPT,
    STATIC_REMOTE_KEY_REQ,
    STATIC_REMOTE_KEY_OPT,
    PAYMENT_ADDR_REQ,
    PAYMENT_ADDR_OPT,
    MPP_REQ,
    MPP_OPT,
    WUMBO_CHANNELS_REQ,
    WUMBO_CHANNELS_OPT,
    ANCHORS_REQ,
    ANCHORS_OPT,
    ANCHORS_ZERO_FEE_HTLC_REQ,
    ANCHORS_ZERO_FEE_HTLC_OPT,
    ROUTE_BLINDING_REQUIRED,
    ROUTE_BLINDING_OPTIONAL,
    AMP_REQ,
    AMP_OPT,
  ];

  static final $core.Map<$core.int, FeatureBit> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FeatureBit? valueOf($core.int value) => _byValue[value];

  const FeatureBit._(super.v, super.n);
}

class UpdateFailure extends $pb.ProtobufEnum {
  static const UpdateFailure UPDATE_FAILURE_UNKNOWN = UpdateFailure._(0, _omitEnumNames ? '' : 'UPDATE_FAILURE_UNKNOWN');
  static const UpdateFailure UPDATE_FAILURE_PENDING = UpdateFailure._(1, _omitEnumNames ? '' : 'UPDATE_FAILURE_PENDING');
  static const UpdateFailure UPDATE_FAILURE_NOT_FOUND = UpdateFailure._(2, _omitEnumNames ? '' : 'UPDATE_FAILURE_NOT_FOUND');
  static const UpdateFailure UPDATE_FAILURE_INTERNAL_ERR = UpdateFailure._(3, _omitEnumNames ? '' : 'UPDATE_FAILURE_INTERNAL_ERR');
  static const UpdateFailure UPDATE_FAILURE_INVALID_PARAMETER = UpdateFailure._(4, _omitEnumNames ? '' : 'UPDATE_FAILURE_INVALID_PARAMETER');

  static const $core.List<UpdateFailure> values = <UpdateFailure> [
    UPDATE_FAILURE_UNKNOWN,
    UPDATE_FAILURE_PENDING,
    UPDATE_FAILURE_NOT_FOUND,
    UPDATE_FAILURE_INTERNAL_ERR,
    UPDATE_FAILURE_INVALID_PARAMETER,
  ];

  static final $core.Map<$core.int, UpdateFailure> _byValue = $pb.ProtobufEnum.initByValue(values);
  static UpdateFailure? valueOf($core.int value) => _byValue[value];

  const UpdateFailure._(super.v, super.n);
}

class ChannelCloseSummary_ClosureType extends $pb.ProtobufEnum {
  static const ChannelCloseSummary_ClosureType COOPERATIVE_CLOSE = ChannelCloseSummary_ClosureType._(0, _omitEnumNames ? '' : 'COOPERATIVE_CLOSE');
  static const ChannelCloseSummary_ClosureType LOCAL_FORCE_CLOSE = ChannelCloseSummary_ClosureType._(1, _omitEnumNames ? '' : 'LOCAL_FORCE_CLOSE');
  static const ChannelCloseSummary_ClosureType REMOTE_FORCE_CLOSE = ChannelCloseSummary_ClosureType._(2, _omitEnumNames ? '' : 'REMOTE_FORCE_CLOSE');
  static const ChannelCloseSummary_ClosureType BREACH_CLOSE = ChannelCloseSummary_ClosureType._(3, _omitEnumNames ? '' : 'BREACH_CLOSE');
  static const ChannelCloseSummary_ClosureType FUNDING_CANCELED = ChannelCloseSummary_ClosureType._(4, _omitEnumNames ? '' : 'FUNDING_CANCELED');
  static const ChannelCloseSummary_ClosureType ABANDONED = ChannelCloseSummary_ClosureType._(5, _omitEnumNames ? '' : 'ABANDONED');

  static const $core.List<ChannelCloseSummary_ClosureType> values = <ChannelCloseSummary_ClosureType> [
    COOPERATIVE_CLOSE,
    LOCAL_FORCE_CLOSE,
    REMOTE_FORCE_CLOSE,
    BREACH_CLOSE,
    FUNDING_CANCELED,
    ABANDONED,
  ];

  static final $core.Map<$core.int, ChannelCloseSummary_ClosureType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelCloseSummary_ClosureType? valueOf($core.int value) => _byValue[value];

  const ChannelCloseSummary_ClosureType._(super.v, super.n);
}

class Peer_SyncType extends $pb.ProtobufEnum {
  ///
  /// Denotes that we cannot determine the peer's current sync type.
  static const Peer_SyncType UNKNOWN_SYNC = Peer_SyncType._(0, _omitEnumNames ? '' : 'UNKNOWN_SYNC');
  ///
  /// Denotes that we are actively receiving new graph updates from the peer.
  static const Peer_SyncType ACTIVE_SYNC = Peer_SyncType._(1, _omitEnumNames ? '' : 'ACTIVE_SYNC');
  ///
  /// Denotes that we are not receiving new graph updates from the peer.
  static const Peer_SyncType PASSIVE_SYNC = Peer_SyncType._(2, _omitEnumNames ? '' : 'PASSIVE_SYNC');
  ///
  /// Denotes that this peer is pinned into an active sync.
  static const Peer_SyncType PINNED_SYNC = Peer_SyncType._(3, _omitEnumNames ? '' : 'PINNED_SYNC');

  static const $core.List<Peer_SyncType> values = <Peer_SyncType> [
    UNKNOWN_SYNC,
    ACTIVE_SYNC,
    PASSIVE_SYNC,
    PINNED_SYNC,
  ];

  static final $core.Map<$core.int, Peer_SyncType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Peer_SyncType? valueOf($core.int value) => _byValue[value];

  const Peer_SyncType._(super.v, super.n);
}

class PeerEvent_EventType extends $pb.ProtobufEnum {
  static const PeerEvent_EventType PEER_ONLINE = PeerEvent_EventType._(0, _omitEnumNames ? '' : 'PEER_ONLINE');
  static const PeerEvent_EventType PEER_OFFLINE = PeerEvent_EventType._(1, _omitEnumNames ? '' : 'PEER_OFFLINE');

  static const $core.List<PeerEvent_EventType> values = <PeerEvent_EventType> [
    PEER_ONLINE,
    PEER_OFFLINE,
  ];

  static final $core.Map<$core.int, PeerEvent_EventType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PeerEvent_EventType? valueOf($core.int value) => _byValue[value];

  const PeerEvent_EventType._(super.v, super.n);
}

///
/// There are three resolution states for the anchor:
/// limbo, lost and recovered. Derive the current state
/// from the limbo and recovered balances.
class PendingChannelsResponse_ForceClosedChannel_AnchorState extends $pb.ProtobufEnum {
  /// The recovered_balance is zero and limbo_balance is non-zero.
  static const PendingChannelsResponse_ForceClosedChannel_AnchorState LIMBO = PendingChannelsResponse_ForceClosedChannel_AnchorState._(0, _omitEnumNames ? '' : 'LIMBO');
  /// The recovered_balance is non-zero.
  static const PendingChannelsResponse_ForceClosedChannel_AnchorState RECOVERED = PendingChannelsResponse_ForceClosedChannel_AnchorState._(1, _omitEnumNames ? '' : 'RECOVERED');
  /// A state that is neither LIMBO nor RECOVERED.
  static const PendingChannelsResponse_ForceClosedChannel_AnchorState LOST = PendingChannelsResponse_ForceClosedChannel_AnchorState._(2, _omitEnumNames ? '' : 'LOST');

  static const $core.List<PendingChannelsResponse_ForceClosedChannel_AnchorState> values = <PendingChannelsResponse_ForceClosedChannel_AnchorState> [
    LIMBO,
    RECOVERED,
    LOST,
  ];

  static final $core.Map<$core.int, PendingChannelsResponse_ForceClosedChannel_AnchorState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PendingChannelsResponse_ForceClosedChannel_AnchorState? valueOf($core.int value) => _byValue[value];

  const PendingChannelsResponse_ForceClosedChannel_AnchorState._(super.v, super.n);
}

class ChannelEventUpdate_UpdateType extends $pb.ProtobufEnum {
  static const ChannelEventUpdate_UpdateType OPEN_CHANNEL = ChannelEventUpdate_UpdateType._(0, _omitEnumNames ? '' : 'OPEN_CHANNEL');
  static const ChannelEventUpdate_UpdateType CLOSED_CHANNEL = ChannelEventUpdate_UpdateType._(1, _omitEnumNames ? '' : 'CLOSED_CHANNEL');
  static const ChannelEventUpdate_UpdateType ACTIVE_CHANNEL = ChannelEventUpdate_UpdateType._(2, _omitEnumNames ? '' : 'ACTIVE_CHANNEL');
  static const ChannelEventUpdate_UpdateType INACTIVE_CHANNEL = ChannelEventUpdate_UpdateType._(3, _omitEnumNames ? '' : 'INACTIVE_CHANNEL');
  static const ChannelEventUpdate_UpdateType PENDING_OPEN_CHANNEL = ChannelEventUpdate_UpdateType._(4, _omitEnumNames ? '' : 'PENDING_OPEN_CHANNEL');
  static const ChannelEventUpdate_UpdateType FULLY_RESOLVED_CHANNEL = ChannelEventUpdate_UpdateType._(5, _omitEnumNames ? '' : 'FULLY_RESOLVED_CHANNEL');

  static const $core.List<ChannelEventUpdate_UpdateType> values = <ChannelEventUpdate_UpdateType> [
    OPEN_CHANNEL,
    CLOSED_CHANNEL,
    ACTIVE_CHANNEL,
    INACTIVE_CHANNEL,
    PENDING_OPEN_CHANNEL,
    FULLY_RESOLVED_CHANNEL,
  ];

  static final $core.Map<$core.int, ChannelEventUpdate_UpdateType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelEventUpdate_UpdateType? valueOf($core.int value) => _byValue[value];

  const ChannelEventUpdate_UpdateType._(super.v, super.n);
}

class Invoice_InvoiceState extends $pb.ProtobufEnum {
  static const Invoice_InvoiceState OPEN = Invoice_InvoiceState._(0, _omitEnumNames ? '' : 'OPEN');
  static const Invoice_InvoiceState SETTLED = Invoice_InvoiceState._(1, _omitEnumNames ? '' : 'SETTLED');
  static const Invoice_InvoiceState CANCELED = Invoice_InvoiceState._(2, _omitEnumNames ? '' : 'CANCELED');
  static const Invoice_InvoiceState ACCEPTED = Invoice_InvoiceState._(3, _omitEnumNames ? '' : 'ACCEPTED');

  static const $core.List<Invoice_InvoiceState> values = <Invoice_InvoiceState> [
    OPEN,
    SETTLED,
    CANCELED,
    ACCEPTED,
  ];

  static final $core.Map<$core.int, Invoice_InvoiceState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Invoice_InvoiceState? valueOf($core.int value) => _byValue[value];

  const Invoice_InvoiceState._(super.v, super.n);
}

class Payment_PaymentStatus extends $pb.ProtobufEnum {
  /// Deprecated. This status will never be returned.
  @$core.Deprecated('This enum value is deprecated')
  static const Payment_PaymentStatus UNKNOWN = Payment_PaymentStatus._(0, _omitEnumNames ? '' : 'UNKNOWN');
  /// Payment has inflight HTLCs.
  static const Payment_PaymentStatus IN_FLIGHT = Payment_PaymentStatus._(1, _omitEnumNames ? '' : 'IN_FLIGHT');
  /// Payment is settled.
  static const Payment_PaymentStatus SUCCEEDED = Payment_PaymentStatus._(2, _omitEnumNames ? '' : 'SUCCEEDED');
  /// Payment is failed.
  static const Payment_PaymentStatus FAILED = Payment_PaymentStatus._(3, _omitEnumNames ? '' : 'FAILED');
  /// Payment is created and has not attempted any HTLCs.
  static const Payment_PaymentStatus INITIATED = Payment_PaymentStatus._(4, _omitEnumNames ? '' : 'INITIATED');

  static const $core.List<Payment_PaymentStatus> values = <Payment_PaymentStatus> [
    UNKNOWN,
    IN_FLIGHT,
    SUCCEEDED,
    FAILED,
    INITIATED,
  ];

  static final $core.Map<$core.int, Payment_PaymentStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Payment_PaymentStatus? valueOf($core.int value) => _byValue[value];

  const Payment_PaymentStatus._(super.v, super.n);
}

class HTLCAttempt_HTLCStatus extends $pb.ProtobufEnum {
  static const HTLCAttempt_HTLCStatus IN_FLIGHT = HTLCAttempt_HTLCStatus._(0, _omitEnumNames ? '' : 'IN_FLIGHT');
  static const HTLCAttempt_HTLCStatus SUCCEEDED = HTLCAttempt_HTLCStatus._(1, _omitEnumNames ? '' : 'SUCCEEDED');
  static const HTLCAttempt_HTLCStatus FAILED = HTLCAttempt_HTLCStatus._(2, _omitEnumNames ? '' : 'FAILED');

  static const $core.List<HTLCAttempt_HTLCStatus> values = <HTLCAttempt_HTLCStatus> [
    IN_FLIGHT,
    SUCCEEDED,
    FAILED,
  ];

  static final $core.Map<$core.int, HTLCAttempt_HTLCStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HTLCAttempt_HTLCStatus? valueOf($core.int value) => _byValue[value];

  const HTLCAttempt_HTLCStatus._(super.v, super.n);
}

class Failure_FailureCode extends $pb.ProtobufEnum {
  ///
  /// The numbers assigned in this enumeration match the failure codes as
  /// defined in BOLT #4. Because protobuf 3 requires enums to start with 0,
  /// a RESERVED value is added.
  static const Failure_FailureCode RESERVED = Failure_FailureCode._(0, _omitEnumNames ? '' : 'RESERVED');
  static const Failure_FailureCode INCORRECT_OR_UNKNOWN_PAYMENT_DETAILS = Failure_FailureCode._(1, _omitEnumNames ? '' : 'INCORRECT_OR_UNKNOWN_PAYMENT_DETAILS');
  static const Failure_FailureCode INCORRECT_PAYMENT_AMOUNT = Failure_FailureCode._(2, _omitEnumNames ? '' : 'INCORRECT_PAYMENT_AMOUNT');
  static const Failure_FailureCode FINAL_INCORRECT_CLTV_EXPIRY = Failure_FailureCode._(3, _omitEnumNames ? '' : 'FINAL_INCORRECT_CLTV_EXPIRY');
  static const Failure_FailureCode FINAL_INCORRECT_HTLC_AMOUNT = Failure_FailureCode._(4, _omitEnumNames ? '' : 'FINAL_INCORRECT_HTLC_AMOUNT');
  static const Failure_FailureCode FINAL_EXPIRY_TOO_SOON = Failure_FailureCode._(5, _omitEnumNames ? '' : 'FINAL_EXPIRY_TOO_SOON');
  static const Failure_FailureCode INVALID_REALM = Failure_FailureCode._(6, _omitEnumNames ? '' : 'INVALID_REALM');
  static const Failure_FailureCode EXPIRY_TOO_SOON = Failure_FailureCode._(7, _omitEnumNames ? '' : 'EXPIRY_TOO_SOON');
  static const Failure_FailureCode INVALID_ONION_VERSION = Failure_FailureCode._(8, _omitEnumNames ? '' : 'INVALID_ONION_VERSION');
  static const Failure_FailureCode INVALID_ONION_HMAC = Failure_FailureCode._(9, _omitEnumNames ? '' : 'INVALID_ONION_HMAC');
  static const Failure_FailureCode INVALID_ONION_KEY = Failure_FailureCode._(10, _omitEnumNames ? '' : 'INVALID_ONION_KEY');
  static const Failure_FailureCode AMOUNT_BELOW_MINIMUM = Failure_FailureCode._(11, _omitEnumNames ? '' : 'AMOUNT_BELOW_MINIMUM');
  static const Failure_FailureCode FEE_INSUFFICIENT = Failure_FailureCode._(12, _omitEnumNames ? '' : 'FEE_INSUFFICIENT');
  static const Failure_FailureCode INCORRECT_CLTV_EXPIRY = Failure_FailureCode._(13, _omitEnumNames ? '' : 'INCORRECT_CLTV_EXPIRY');
  static const Failure_FailureCode CHANNEL_DISABLED = Failure_FailureCode._(14, _omitEnumNames ? '' : 'CHANNEL_DISABLED');
  static const Failure_FailureCode TEMPORARY_CHANNEL_FAILURE = Failure_FailureCode._(15, _omitEnumNames ? '' : 'TEMPORARY_CHANNEL_FAILURE');
  static const Failure_FailureCode REQUIRED_NODE_FEATURE_MISSING = Failure_FailureCode._(16, _omitEnumNames ? '' : 'REQUIRED_NODE_FEATURE_MISSING');
  static const Failure_FailureCode REQUIRED_CHANNEL_FEATURE_MISSING = Failure_FailureCode._(17, _omitEnumNames ? '' : 'REQUIRED_CHANNEL_FEATURE_MISSING');
  static const Failure_FailureCode UNKNOWN_NEXT_PEER = Failure_FailureCode._(18, _omitEnumNames ? '' : 'UNKNOWN_NEXT_PEER');
  static const Failure_FailureCode TEMPORARY_NODE_FAILURE = Failure_FailureCode._(19, _omitEnumNames ? '' : 'TEMPORARY_NODE_FAILURE');
  static const Failure_FailureCode PERMANENT_NODE_FAILURE = Failure_FailureCode._(20, _omitEnumNames ? '' : 'PERMANENT_NODE_FAILURE');
  static const Failure_FailureCode PERMANENT_CHANNEL_FAILURE = Failure_FailureCode._(21, _omitEnumNames ? '' : 'PERMANENT_CHANNEL_FAILURE');
  static const Failure_FailureCode EXPIRY_TOO_FAR = Failure_FailureCode._(22, _omitEnumNames ? '' : 'EXPIRY_TOO_FAR');
  static const Failure_FailureCode MPP_TIMEOUT = Failure_FailureCode._(23, _omitEnumNames ? '' : 'MPP_TIMEOUT');
  static const Failure_FailureCode INVALID_ONION_PAYLOAD = Failure_FailureCode._(24, _omitEnumNames ? '' : 'INVALID_ONION_PAYLOAD');
  static const Failure_FailureCode INVALID_ONION_BLINDING = Failure_FailureCode._(25, _omitEnumNames ? '' : 'INVALID_ONION_BLINDING');
  ///
  /// An internal error occurred.
  static const Failure_FailureCode INTERNAL_FAILURE = Failure_FailureCode._(997, _omitEnumNames ? '' : 'INTERNAL_FAILURE');
  ///
  /// The error source is known, but the failure itself couldn't be decoded.
  static const Failure_FailureCode UNKNOWN_FAILURE = Failure_FailureCode._(998, _omitEnumNames ? '' : 'UNKNOWN_FAILURE');
  ///
  /// An unreadable failure result is returned if the received failure message
  /// cannot be decrypted. In that case the error source is unknown.
  static const Failure_FailureCode UNREADABLE_FAILURE = Failure_FailureCode._(999, _omitEnumNames ? '' : 'UNREADABLE_FAILURE');

  static const $core.List<Failure_FailureCode> values = <Failure_FailureCode> [
    RESERVED,
    INCORRECT_OR_UNKNOWN_PAYMENT_DETAILS,
    INCORRECT_PAYMENT_AMOUNT,
    FINAL_INCORRECT_CLTV_EXPIRY,
    FINAL_INCORRECT_HTLC_AMOUNT,
    FINAL_EXPIRY_TOO_SOON,
    INVALID_REALM,
    EXPIRY_TOO_SOON,
    INVALID_ONION_VERSION,
    INVALID_ONION_HMAC,
    INVALID_ONION_KEY,
    AMOUNT_BELOW_MINIMUM,
    FEE_INSUFFICIENT,
    INCORRECT_CLTV_EXPIRY,
    CHANNEL_DISABLED,
    TEMPORARY_CHANNEL_FAILURE,
    REQUIRED_NODE_FEATURE_MISSING,
    REQUIRED_CHANNEL_FEATURE_MISSING,
    UNKNOWN_NEXT_PEER,
    TEMPORARY_NODE_FAILURE,
    PERMANENT_NODE_FAILURE,
    PERMANENT_CHANNEL_FAILURE,
    EXPIRY_TOO_FAR,
    MPP_TIMEOUT,
    INVALID_ONION_PAYLOAD,
    INVALID_ONION_BLINDING,
    INTERNAL_FAILURE,
    UNKNOWN_FAILURE,
    UNREADABLE_FAILURE,
  ];

  static final $core.Map<$core.int, Failure_FailureCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Failure_FailureCode? valueOf($core.int value) => _byValue[value];

  const Failure_FailureCode._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
