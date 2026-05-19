//
//  Generated code. Do not modify.
//  source: lnd/primitives.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use channelSideDescriptor instead')
const ChannelSide$json = {
  '1': 'ChannelSide',
  '2': [
    {'1': 'LOCAL', '2': 0},
    {'1': 'REMOTE', '2': 1},
  ],
};

/// Descriptor for `ChannelSide`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelSideDescriptor = $convert.base64Decode(
    'CgtDaGFubmVsU2lkZRIJCgVMT0NBTBAAEgoKBlJFTU9URRAB');

@$core.Deprecated('Use channelStateDescriptor instead')
const ChannelState$json = {
  '1': 'ChannelState',
  '2': [
    {'1': 'Openingd', '2': 0},
    {'1': 'ChanneldAwaitingLockin', '2': 1},
    {'1': 'ChanneldNormal', '2': 2},
    {'1': 'ChanneldShuttingDown', '2': 3},
    {'1': 'ClosingdSigexchange', '2': 4},
    {'1': 'ClosingdComplete', '2': 5},
    {'1': 'AwaitingUnilateral', '2': 6},
    {'1': 'FundingSpendSeen', '2': 7},
    {'1': 'Onchain', '2': 8},
    {'1': 'DualopendOpenInit', '2': 9},
    {'1': 'DualopendAwaitingLockin', '2': 10},
    {'1': 'ChanneldAwaitingSplice', '2': 11},
  ],
};

/// Descriptor for `ChannelState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelStateDescriptor = $convert.base64Decode(
    'CgxDaGFubmVsU3RhdGUSDAoIT3BlbmluZ2QQABIaChZDaGFubmVsZEF3YWl0aW5nTG9ja2luEA'
    'ESEgoOQ2hhbm5lbGROb3JtYWwQAhIYChRDaGFubmVsZFNodXR0aW5nRG93bhADEhcKE0Nsb3Np'
    'bmdkU2lnZXhjaGFuZ2UQBBIUChBDbG9zaW5nZENvbXBsZXRlEAUSFgoSQXdhaXRpbmdVbmlsYX'
    'RlcmFsEAYSFAoQRnVuZGluZ1NwZW5kU2VlbhAHEgsKB09uY2hhaW4QCBIVChFEdWFsb3BlbmRP'
    'cGVuSW5pdBAJEhsKF0R1YWxvcGVuZEF3YWl0aW5nTG9ja2luEAoSGgoWQ2hhbm5lbGRBd2FpdG'
    'luZ1NwbGljZRAL');

@$core.Deprecated('Use htlcStateDescriptor instead')
const HtlcState$json = {
  '1': 'HtlcState',
  '2': [
    {'1': 'SentAddHtlc', '2': 0},
    {'1': 'SentAddCommit', '2': 1},
    {'1': 'RcvdAddRevocation', '2': 2},
    {'1': 'RcvdAddAckCommit', '2': 3},
    {'1': 'SentAddAckRevocation', '2': 4},
    {'1': 'RcvdAddAckRevocation', '2': 5},
    {'1': 'RcvdRemoveHtlc', '2': 6},
    {'1': 'RcvdRemoveCommit', '2': 7},
    {'1': 'SentRemoveRevocation', '2': 8},
    {'1': 'SentRemoveAckCommit', '2': 9},
    {'1': 'RcvdRemoveAckRevocation', '2': 10},
    {'1': 'RcvdAddHtlc', '2': 11},
    {'1': 'RcvdAddCommit', '2': 12},
    {'1': 'SentAddRevocation', '2': 13},
    {'1': 'SentAddAckCommit', '2': 14},
    {'1': 'SentRemoveHtlc', '2': 15},
    {'1': 'SentRemoveCommit', '2': 16},
    {'1': 'RcvdRemoveRevocation', '2': 17},
    {'1': 'RcvdRemoveAckCommit', '2': 18},
    {'1': 'SentRemoveAckRevocation', '2': 19},
  ],
};

/// Descriptor for `HtlcState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List htlcStateDescriptor = $convert.base64Decode(
    'CglIdGxjU3RhdGUSDwoLU2VudEFkZEh0bGMQABIRCg1TZW50QWRkQ29tbWl0EAESFQoRUmN2ZE'
    'FkZFJldm9jYXRpb24QAhIUChBSY3ZkQWRkQWNrQ29tbWl0EAMSGAoUU2VudEFkZEFja1Jldm9j'
    'YXRpb24QBBIYChRSY3ZkQWRkQWNrUmV2b2NhdGlvbhAFEhIKDlJjdmRSZW1vdmVIdGxjEAYSFA'
    'oQUmN2ZFJlbW92ZUNvbW1pdBAHEhgKFFNlbnRSZW1vdmVSZXZvY2F0aW9uEAgSFwoTU2VudFJl'
    'bW92ZUFja0NvbW1pdBAJEhsKF1JjdmRSZW1vdmVBY2tSZXZvY2F0aW9uEAoSDwoLUmN2ZEFkZE'
    'h0bGMQCxIRCg1SY3ZkQWRkQ29tbWl0EAwSFQoRU2VudEFkZFJldm9jYXRpb24QDRIUChBTZW50'
    'QWRkQWNrQ29tbWl0EA4SEgoOU2VudFJlbW92ZUh0bGMQDxIUChBTZW50UmVtb3ZlQ29tbWl0EB'
    'ASGAoUUmN2ZFJlbW92ZVJldm9jYXRpb24QERIXChNSY3ZkUmVtb3ZlQWNrQ29tbWl0EBISGwoX'
    'U2VudFJlbW92ZUFja1Jldm9jYXRpb24QEw==');

@$core.Deprecated('Use channelTypeNameDescriptor instead')
const ChannelTypeName$json = {
  '1': 'ChannelTypeName',
  '2': [
    {'1': 'static_remotekey_even', '2': 0},
    {'1': 'anchor_outputs_even', '2': 1},
    {'1': 'anchors_zero_fee_htlc_tx_even', '2': 2},
    {'1': 'scid_alias_even', '2': 3},
    {'1': 'zeroconf_even', '2': 4},
  ],
};

/// Descriptor for `ChannelTypeName`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelTypeNameDescriptor = $convert.base64Decode(
    'Cg9DaGFubmVsVHlwZU5hbWUSGQoVc3RhdGljX3JlbW90ZWtleV9ldmVuEAASFwoTYW5jaG9yX2'
    '91dHB1dHNfZXZlbhABEiEKHWFuY2hvcnNfemVyb19mZWVfaHRsY190eF9ldmVuEAISEwoPc2Np'
    'ZF9hbGlhc19ldmVuEAMSEQoNemVyb2NvbmZfZXZlbhAE');

@$core.Deprecated('Use autocleanSubsystemDescriptor instead')
const AutocleanSubsystem$json = {
  '1': 'AutocleanSubsystem',
  '2': [
    {'1': 'SUCCEEDEDFORWARDS', '2': 0},
    {'1': 'FAILEDFORWARDS', '2': 1},
    {'1': 'SUCCEEDEDPAYS', '2': 2},
    {'1': 'FAILEDPAYS', '2': 3},
    {'1': 'PAIDINVOICES', '2': 4},
    {'1': 'EXPIREDINVOICES', '2': 5},
  ],
};

/// Descriptor for `AutocleanSubsystem`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List autocleanSubsystemDescriptor = $convert.base64Decode(
    'ChJBdXRvY2xlYW5TdWJzeXN0ZW0SFQoRU1VDQ0VFREVERk9SV0FSRFMQABISCg5GQUlMRURGT1'
    'JXQVJEUxABEhEKDVNVQ0NFRURFRFBBWVMQAhIOCgpGQUlMRURQQVlTEAMSEAoMUEFJRElOVk9J'
    'Q0VTEAQSEwoPRVhQSVJFRElOVk9JQ0VTEAU=');

@$core.Deprecated('Use pluginSubcommandDescriptor instead')
const PluginSubcommand$json = {
  '1': 'PluginSubcommand',
  '2': [
    {'1': 'START', '2': 0},
    {'1': 'STOP', '2': 1},
    {'1': 'RESCAN', '2': 2},
    {'1': 'STARTDIR', '2': 3},
    {'1': 'LIST', '2': 4},
  ],
};

/// Descriptor for `PluginSubcommand`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List pluginSubcommandDescriptor = $convert.base64Decode(
    'ChBQbHVnaW5TdWJjb21tYW5kEgkKBVNUQVJUEAASCAoEU1RPUBABEgoKBlJFU0NBThACEgwKCF'
    'NUQVJURElSEAMSCAoETElTVBAE');

@$core.Deprecated('Use amountDescriptor instead')
const Amount$json = {
  '1': 'Amount',
  '2': [
    {'1': 'msat', '3': 1, '4': 1, '5': 4, '10': 'msat'},
  ],
};

/// Descriptor for `Amount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List amountDescriptor = $convert.base64Decode(
    'CgZBbW91bnQSEgoEbXNhdBgBIAEoBFIEbXNhdA==');

@$core.Deprecated('Use amountOrAllDescriptor instead')
const AmountOrAll$json = {
  '1': 'AmountOrAll',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.cln.Amount', '9': 0, '10': 'amount'},
    {'1': 'all', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'all'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `AmountOrAll`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List amountOrAllDescriptor = $convert.base64Decode(
    'CgtBbW91bnRPckFsbBIlCgZhbW91bnQYASABKAsyCy5jbG4uQW1vdW50SABSBmFtb3VudBISCg'
    'NhbGwYAiABKAhIAFIDYWxsQgcKBXZhbHVl');

@$core.Deprecated('Use amountOrAnyDescriptor instead')
const AmountOrAny$json = {
  '1': 'AmountOrAny',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 11, '6': '.cln.Amount', '9': 0, '10': 'amount'},
    {'1': 'any', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'any'},
  ],
  '8': [
    {'1': 'value'},
  ],
};

/// Descriptor for `AmountOrAny`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List amountOrAnyDescriptor = $convert.base64Decode(
    'CgtBbW91bnRPckFueRIlCgZhbW91bnQYASABKAsyCy5jbG4uQW1vdW50SABSBmFtb3VudBISCg'
    'NhbnkYAiABKAhIAFIDYW55QgcKBXZhbHVl');

@$core.Deprecated('Use channelStateChangeCauseDescriptor instead')
const ChannelStateChangeCause$json = {
  '1': 'ChannelStateChangeCause',
};

/// Descriptor for `ChannelStateChangeCause`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelStateChangeCauseDescriptor = $convert.base64Decode(
    'ChdDaGFubmVsU3RhdGVDaGFuZ2VDYXVzZQ==');

@$core.Deprecated('Use outpointDescriptor instead')
const Outpoint$json = {
  '1': 'Outpoint',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 12, '10': 'txid'},
    {'1': 'outnum', '3': 2, '4': 1, '5': 13, '10': 'outnum'},
  ],
};

/// Descriptor for `Outpoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outpointDescriptor = $convert.base64Decode(
    'CghPdXRwb2ludBISCgR0eGlkGAEgASgMUgR0eGlkEhYKBm91dG51bRgCIAEoDVIGb3V0bnVt');

@$core.Deprecated('Use feerateDescriptor instead')
const Feerate$json = {
  '1': 'Feerate',
  '2': [
    {'1': 'slow', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'slow'},
    {'1': 'normal', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'normal'},
    {'1': 'urgent', '3': 3, '4': 1, '5': 8, '9': 0, '10': 'urgent'},
    {'1': 'perkb', '3': 4, '4': 1, '5': 13, '9': 0, '10': 'perkb'},
    {'1': 'perkw', '3': 5, '4': 1, '5': 13, '9': 0, '10': 'perkw'},
  ],
  '8': [
    {'1': 'style'},
  ],
};

/// Descriptor for `Feerate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feerateDescriptor = $convert.base64Decode(
    'CgdGZWVyYXRlEhQKBHNsb3cYASABKAhIAFIEc2xvdxIYCgZub3JtYWwYAiABKAhIAFIGbm9ybW'
    'FsEhgKBnVyZ2VudBgDIAEoCEgAUgZ1cmdlbnQSFgoFcGVya2IYBCABKA1IAFIFcGVya2ISFgoF'
    'cGVya3cYBSABKA1IAFIFcGVya3dCBwoFc3R5bGU=');

@$core.Deprecated('Use outputDescDescriptor instead')
const OutputDesc$json = {
  '1': 'OutputDesc',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    {'1': 'amount', '3': 2, '4': 1, '5': 11, '6': '.cln.Amount', '10': 'amount'},
  ],
};

/// Descriptor for `OutputDesc`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outputDescDescriptor = $convert.base64Decode(
    'CgpPdXRwdXREZXNjEhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3MSIwoGYW1vdW50GAIgASgLMg'
    'suY2xuLkFtb3VudFIGYW1vdW50');

@$core.Deprecated('Use routeHopDescriptor instead')
const RouteHop$json = {
  '1': 'RouteHop',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 12, '10': 'id'},
    {'1': 'scid', '3': 2, '4': 1, '5': 9, '10': 'scid'},
    {'1': 'feebase', '3': 3, '4': 1, '5': 11, '6': '.cln.Amount', '10': 'feebase'},
    {'1': 'feeprop', '3': 4, '4': 1, '5': 13, '10': 'feeprop'},
    {'1': 'expirydelta', '3': 5, '4': 1, '5': 13, '10': 'expirydelta'},
  ],
};

/// Descriptor for `RouteHop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeHopDescriptor = $convert.base64Decode(
    'CghSb3V0ZUhvcBIOCgJpZBgBIAEoDFICaWQSEgoEc2NpZBgCIAEoCVIEc2NpZBIlCgdmZWViYX'
    'NlGAMgASgLMgsuY2xuLkFtb3VudFIHZmVlYmFzZRIYCgdmZWVwcm9wGAQgASgNUgdmZWVwcm9w'
    'EiAKC2V4cGlyeWRlbHRhGAUgASgNUgtleHBpcnlkZWx0YQ==');

@$core.Deprecated('Use routehintDescriptor instead')
const Routehint$json = {
  '1': 'Routehint',
  '2': [
    {'1': 'hops', '3': 1, '4': 3, '5': 11, '6': '.cln.RouteHop', '10': 'hops'},
  ],
};

/// Descriptor for `Routehint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routehintDescriptor = $convert.base64Decode(
    'CglSb3V0ZWhpbnQSIQoEaG9wcxgBIAMoCzINLmNsbi5Sb3V0ZUhvcFIEaG9wcw==');

@$core.Deprecated('Use routehintListDescriptor instead')
const RoutehintList$json = {
  '1': 'RoutehintList',
  '2': [
    {'1': 'hints', '3': 2, '4': 3, '5': 11, '6': '.cln.Routehint', '10': 'hints'},
  ],
};

/// Descriptor for `RoutehintList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routehintListDescriptor = $convert.base64Decode(
    'Cg1Sb3V0ZWhpbnRMaXN0EiQKBWhpbnRzGAIgAygLMg4uY2xuLlJvdXRlaGludFIFaGludHM=');

@$core.Deprecated('Use decodeRouteHopDescriptor instead')
const DecodeRouteHop$json = {
  '1': 'DecodeRouteHop',
  '2': [
    {'1': 'pubkey', '3': 1, '4': 1, '5': 12, '10': 'pubkey'},
    {'1': 'short_channel_id', '3': 2, '4': 1, '5': 9, '10': 'shortChannelId'},
    {'1': 'fee_base_msat', '3': 3, '4': 1, '5': 11, '6': '.cln.Amount', '10': 'feeBaseMsat'},
    {'1': 'fee_proportional_millionths', '3': 4, '4': 1, '5': 13, '10': 'feeProportionalMillionths'},
    {'1': 'cltv_expiry_delta', '3': 5, '4': 1, '5': 13, '10': 'cltvExpiryDelta'},
  ],
};

/// Descriptor for `DecodeRouteHop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeRouteHopDescriptor = $convert.base64Decode(
    'Cg5EZWNvZGVSb3V0ZUhvcBIWCgZwdWJrZXkYASABKAxSBnB1YmtleRIoChBzaG9ydF9jaGFubm'
    'VsX2lkGAIgASgJUg5zaG9ydENoYW5uZWxJZBIvCg1mZWVfYmFzZV9tc2F0GAMgASgLMgsuY2xu'
    'LkFtb3VudFILZmVlQmFzZU1zYXQSPgobZmVlX3Byb3BvcnRpb25hbF9taWxsaW9udGhzGAQgAS'
    'gNUhlmZWVQcm9wb3J0aW9uYWxNaWxsaW9udGhzEioKEWNsdHZfZXhwaXJ5X2RlbHRhGAUgASgN'
    'Ug9jbHR2RXhwaXJ5RGVsdGE=');

@$core.Deprecated('Use decodeRoutehintDescriptor instead')
const DecodeRoutehint$json = {
  '1': 'DecodeRoutehint',
  '2': [
    {'1': 'hops', '3': 1, '4': 3, '5': 11, '6': '.cln.DecodeRouteHop', '10': 'hops'},
  ],
};

/// Descriptor for `DecodeRoutehint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeRoutehintDescriptor = $convert.base64Decode(
    'Cg9EZWNvZGVSb3V0ZWhpbnQSJwoEaG9wcxgBIAMoCzITLmNsbi5EZWNvZGVSb3V0ZUhvcFIEaG'
    '9wcw==');

@$core.Deprecated('Use decodeRoutehintListDescriptor instead')
const DecodeRoutehintList$json = {
  '1': 'DecodeRoutehintList',
  '2': [
    {'1': 'hints', '3': 2, '4': 3, '5': 11, '6': '.cln.DecodeRoutehint', '10': 'hints'},
  ],
};

/// Descriptor for `DecodeRoutehintList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeRoutehintListDescriptor = $convert.base64Decode(
    'ChNEZWNvZGVSb3V0ZWhpbnRMaXN0EioKBWhpbnRzGAIgAygLMhQuY2xuLkRlY29kZVJvdXRlaG'
    'ludFIFaGludHM=');

@$core.Deprecated('Use tlvEntryDescriptor instead')
const TlvEntry$json = {
  '1': 'TlvEntry',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 4, '10': 'type'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `TlvEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tlvEntryDescriptor = $convert.base64Decode(
    'CghUbHZFbnRyeRISCgR0eXBlGAEgASgEUgR0eXBlEhQKBXZhbHVlGAIgASgMUgV2YWx1ZQ==');

@$core.Deprecated('Use tlvStreamDescriptor instead')
const TlvStream$json = {
  '1': 'TlvStream',
  '2': [
    {'1': 'entries', '3': 1, '4': 3, '5': 11, '6': '.cln.TlvEntry', '10': 'entries'},
  ],
};

/// Descriptor for `TlvStream`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tlvStreamDescriptor = $convert.base64Decode(
    'CglUbHZTdHJlYW0SJwoHZW50cmllcxgBIAMoCzINLmNsbi5UbHZFbnRyeVIHZW50cmllcw==');

