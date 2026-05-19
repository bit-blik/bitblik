//
//  Generated code. Do not modify.
//  source: lnd/primitives.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ChannelSide extends $pb.ProtobufEnum {
  static const ChannelSide LOCAL = ChannelSide._(0, _omitEnumNames ? '' : 'LOCAL');
  static const ChannelSide REMOTE = ChannelSide._(1, _omitEnumNames ? '' : 'REMOTE');

  static const $core.List<ChannelSide> values = <ChannelSide> [
    LOCAL,
    REMOTE,
  ];

  static final $core.Map<$core.int, ChannelSide> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelSide? valueOf($core.int value) => _byValue[value];

  const ChannelSide._(super.v, super.n);
}

class ChannelState extends $pb.ProtobufEnum {
  static const ChannelState Openingd = ChannelState._(0, _omitEnumNames ? '' : 'Openingd');
  static const ChannelState ChanneldAwaitingLockin = ChannelState._(1, _omitEnumNames ? '' : 'ChanneldAwaitingLockin');
  static const ChannelState ChanneldNormal = ChannelState._(2, _omitEnumNames ? '' : 'ChanneldNormal');
  static const ChannelState ChanneldShuttingDown = ChannelState._(3, _omitEnumNames ? '' : 'ChanneldShuttingDown');
  static const ChannelState ClosingdSigexchange = ChannelState._(4, _omitEnumNames ? '' : 'ClosingdSigexchange');
  static const ChannelState ClosingdComplete = ChannelState._(5, _omitEnumNames ? '' : 'ClosingdComplete');
  static const ChannelState AwaitingUnilateral = ChannelState._(6, _omitEnumNames ? '' : 'AwaitingUnilateral');
  static const ChannelState FundingSpendSeen = ChannelState._(7, _omitEnumNames ? '' : 'FundingSpendSeen');
  static const ChannelState Onchain = ChannelState._(8, _omitEnumNames ? '' : 'Onchain');
  static const ChannelState DualopendOpenInit = ChannelState._(9, _omitEnumNames ? '' : 'DualopendOpenInit');
  static const ChannelState DualopendAwaitingLockin = ChannelState._(10, _omitEnumNames ? '' : 'DualopendAwaitingLockin');
  static const ChannelState ChanneldAwaitingSplice = ChannelState._(11, _omitEnumNames ? '' : 'ChanneldAwaitingSplice');

  static const $core.List<ChannelState> values = <ChannelState> [
    Openingd,
    ChanneldAwaitingLockin,
    ChanneldNormal,
    ChanneldShuttingDown,
    ClosingdSigexchange,
    ClosingdComplete,
    AwaitingUnilateral,
    FundingSpendSeen,
    Onchain,
    DualopendOpenInit,
    DualopendAwaitingLockin,
    ChanneldAwaitingSplice,
  ];

  static final $core.Map<$core.int, ChannelState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelState? valueOf($core.int value) => _byValue[value];

  const ChannelState._(super.v, super.n);
}

class HtlcState extends $pb.ProtobufEnum {
  static const HtlcState SentAddHtlc = HtlcState._(0, _omitEnumNames ? '' : 'SentAddHtlc');
  static const HtlcState SentAddCommit = HtlcState._(1, _omitEnumNames ? '' : 'SentAddCommit');
  static const HtlcState RcvdAddRevocation = HtlcState._(2, _omitEnumNames ? '' : 'RcvdAddRevocation');
  static const HtlcState RcvdAddAckCommit = HtlcState._(3, _omitEnumNames ? '' : 'RcvdAddAckCommit');
  static const HtlcState SentAddAckRevocation = HtlcState._(4, _omitEnumNames ? '' : 'SentAddAckRevocation');
  static const HtlcState RcvdAddAckRevocation = HtlcState._(5, _omitEnumNames ? '' : 'RcvdAddAckRevocation');
  static const HtlcState RcvdRemoveHtlc = HtlcState._(6, _omitEnumNames ? '' : 'RcvdRemoveHtlc');
  static const HtlcState RcvdRemoveCommit = HtlcState._(7, _omitEnumNames ? '' : 'RcvdRemoveCommit');
  static const HtlcState SentRemoveRevocation = HtlcState._(8, _omitEnumNames ? '' : 'SentRemoveRevocation');
  static const HtlcState SentRemoveAckCommit = HtlcState._(9, _omitEnumNames ? '' : 'SentRemoveAckCommit');
  static const HtlcState RcvdRemoveAckRevocation = HtlcState._(10, _omitEnumNames ? '' : 'RcvdRemoveAckRevocation');
  static const HtlcState RcvdAddHtlc = HtlcState._(11, _omitEnumNames ? '' : 'RcvdAddHtlc');
  static const HtlcState RcvdAddCommit = HtlcState._(12, _omitEnumNames ? '' : 'RcvdAddCommit');
  static const HtlcState SentAddRevocation = HtlcState._(13, _omitEnumNames ? '' : 'SentAddRevocation');
  static const HtlcState SentAddAckCommit = HtlcState._(14, _omitEnumNames ? '' : 'SentAddAckCommit');
  static const HtlcState SentRemoveHtlc = HtlcState._(15, _omitEnumNames ? '' : 'SentRemoveHtlc');
  static const HtlcState SentRemoveCommit = HtlcState._(16, _omitEnumNames ? '' : 'SentRemoveCommit');
  static const HtlcState RcvdRemoveRevocation = HtlcState._(17, _omitEnumNames ? '' : 'RcvdRemoveRevocation');
  static const HtlcState RcvdRemoveAckCommit = HtlcState._(18, _omitEnumNames ? '' : 'RcvdRemoveAckCommit');
  static const HtlcState SentRemoveAckRevocation = HtlcState._(19, _omitEnumNames ? '' : 'SentRemoveAckRevocation');

  static const $core.List<HtlcState> values = <HtlcState> [
    SentAddHtlc,
    SentAddCommit,
    RcvdAddRevocation,
    RcvdAddAckCommit,
    SentAddAckRevocation,
    RcvdAddAckRevocation,
    RcvdRemoveHtlc,
    RcvdRemoveCommit,
    SentRemoveRevocation,
    SentRemoveAckCommit,
    RcvdRemoveAckRevocation,
    RcvdAddHtlc,
    RcvdAddCommit,
    SentAddRevocation,
    SentAddAckCommit,
    SentRemoveHtlc,
    SentRemoveCommit,
    RcvdRemoveRevocation,
    RcvdRemoveAckCommit,
    SentRemoveAckRevocation,
  ];

  static final $core.Map<$core.int, HtlcState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HtlcState? valueOf($core.int value) => _byValue[value];

  const HtlcState._(super.v, super.n);
}

class ChannelTypeName extends $pb.ProtobufEnum {
  static const ChannelTypeName static_remotekey_even = ChannelTypeName._(0, _omitEnumNames ? '' : 'static_remotekey_even');
  static const ChannelTypeName anchor_outputs_even = ChannelTypeName._(1, _omitEnumNames ? '' : 'anchor_outputs_even');
  static const ChannelTypeName anchors_zero_fee_htlc_tx_even = ChannelTypeName._(2, _omitEnumNames ? '' : 'anchors_zero_fee_htlc_tx_even');
  static const ChannelTypeName scid_alias_even = ChannelTypeName._(3, _omitEnumNames ? '' : 'scid_alias_even');
  static const ChannelTypeName zeroconf_even = ChannelTypeName._(4, _omitEnumNames ? '' : 'zeroconf_even');

  static const $core.List<ChannelTypeName> values = <ChannelTypeName> [
    static_remotekey_even,
    anchor_outputs_even,
    anchors_zero_fee_htlc_tx_even,
    scid_alias_even,
    zeroconf_even,
  ];

  static final $core.Map<$core.int, ChannelTypeName> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChannelTypeName? valueOf($core.int value) => _byValue[value];

  const ChannelTypeName._(super.v, super.n);
}

class AutocleanSubsystem extends $pb.ProtobufEnum {
  static const AutocleanSubsystem SUCCEEDEDFORWARDS = AutocleanSubsystem._(0, _omitEnumNames ? '' : 'SUCCEEDEDFORWARDS');
  static const AutocleanSubsystem FAILEDFORWARDS = AutocleanSubsystem._(1, _omitEnumNames ? '' : 'FAILEDFORWARDS');
  static const AutocleanSubsystem SUCCEEDEDPAYS = AutocleanSubsystem._(2, _omitEnumNames ? '' : 'SUCCEEDEDPAYS');
  static const AutocleanSubsystem FAILEDPAYS = AutocleanSubsystem._(3, _omitEnumNames ? '' : 'FAILEDPAYS');
  static const AutocleanSubsystem PAIDINVOICES = AutocleanSubsystem._(4, _omitEnumNames ? '' : 'PAIDINVOICES');
  static const AutocleanSubsystem EXPIREDINVOICES = AutocleanSubsystem._(5, _omitEnumNames ? '' : 'EXPIREDINVOICES');

  static const $core.List<AutocleanSubsystem> values = <AutocleanSubsystem> [
    SUCCEEDEDFORWARDS,
    FAILEDFORWARDS,
    SUCCEEDEDPAYS,
    FAILEDPAYS,
    PAIDINVOICES,
    EXPIREDINVOICES,
  ];

  static final $core.Map<$core.int, AutocleanSubsystem> _byValue = $pb.ProtobufEnum.initByValue(values);
  static AutocleanSubsystem? valueOf($core.int value) => _byValue[value];

  const AutocleanSubsystem._(super.v, super.n);
}

class PluginSubcommand extends $pb.ProtobufEnum {
  static const PluginSubcommand START = PluginSubcommand._(0, _omitEnumNames ? '' : 'START');
  static const PluginSubcommand STOP = PluginSubcommand._(1, _omitEnumNames ? '' : 'STOP');
  static const PluginSubcommand RESCAN = PluginSubcommand._(2, _omitEnumNames ? '' : 'RESCAN');
  static const PluginSubcommand STARTDIR = PluginSubcommand._(3, _omitEnumNames ? '' : 'STARTDIR');
  static const PluginSubcommand LIST = PluginSubcommand._(4, _omitEnumNames ? '' : 'LIST');

  static const $core.List<PluginSubcommand> values = <PluginSubcommand> [
    START,
    STOP,
    RESCAN,
    STARTDIR,
    LIST,
  ];

  static final $core.Map<$core.int, PluginSubcommand> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PluginSubcommand? valueOf($core.int value) => _byValue[value];

  const PluginSubcommand._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
