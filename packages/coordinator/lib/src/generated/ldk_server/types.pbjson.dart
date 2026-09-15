//
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use paymentDirectionDescriptor instead')
const PaymentDirection$json = {
  '1': 'PaymentDirection',
  '2': [
    {'1': 'INBOUND', '2': 0},
    {'1': 'OUTBOUND', '2': 1},
  ],
};

/// Descriptor for `PaymentDirection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentDirectionDescriptor = $convert.base64Decode(
    'ChBQYXltZW50RGlyZWN0aW9uEgsKB0lOQk9VTkQQABIMCghPVVRCT1VORBAB');

@$core.Deprecated('Use paymentStatusDescriptor instead')
const PaymentStatus$json = {
  '1': 'PaymentStatus',
  '2': [
    {'1': 'PENDING', '2': 0},
    {'1': 'SUCCEEDED', '2': 1},
    {'1': 'FAILED', '2': 2},
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50U3RhdHVzEgsKB1BFTkRJTkcQABINCglTVUNDRUVERUQQARIKCgZGQUlMRUQQAg'
    '==');

@$core.Deprecated('Use networkDescriptor instead')
const Network$json = {
  '1': 'Network',
  '2': [
    {'1': 'BITCOIN', '2': 0},
    {'1': 'TESTNET', '2': 1},
    {'1': 'TESTNET4', '2': 2},
    {'1': 'SIGNET', '2': 3},
    {'1': 'REGTEST', '2': 4},
  ],
};

/// Descriptor for `Network`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List networkDescriptor = $convert.base64Decode(
    'CgdOZXR3b3JrEgsKB0JJVENPSU4QABILCgdURVNUTkVUEAESDAoIVEVTVE5FVDQQAhIKCgZTSU'
    'dORVQQAxILCgdSRUdURVNUEAQ=');

@$core.Deprecated('Use channelShutdownStateDescriptor instead')
const ChannelShutdownState$json = {
  '1': 'ChannelShutdownState',
  '2': [
    {'1': 'CHANNEL_SHUTDOWN_STATE_UNSPECIFIED', '2': 0},
    {'1': 'CHANNEL_SHUTDOWN_STATE_NOT_SHUTTING_DOWN', '2': 1},
    {'1': 'CHANNEL_SHUTDOWN_STATE_SHUTDOWN_INITIATED', '2': 2},
    {'1': 'CHANNEL_SHUTDOWN_STATE_RESOLVING_HTLCS', '2': 3},
    {'1': 'CHANNEL_SHUTDOWN_STATE_NEGOTIATING_CLOSING_FEE', '2': 4},
    {'1': 'CHANNEL_SHUTDOWN_STATE_SHUTDOWN_COMPLETE', '2': 5},
  ],
};

/// Descriptor for `ChannelShutdownState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelShutdownStateDescriptor = $convert.base64Decode(
    'ChRDaGFubmVsU2h1dGRvd25TdGF0ZRImCiJDSEFOTkVMX1NIVVRET1dOX1NUQVRFX1VOU1BFQ0'
    'lGSUVEEAASLAooQ0hBTk5FTF9TSFVURE9XTl9TVEFURV9OT1RfU0hVVFRJTkdfRE9XThABEi0K'
    'KUNIQU5ORUxfU0hVVERPV05fU1RBVEVfU0hVVERPV05fSU5JVElBVEVEEAISKgomQ0hBTk5FTF'
    '9TSFVURE9XTl9TVEFURV9SRVNPTFZJTkdfSFRMQ1MQAxIyCi5DSEFOTkVMX1NIVVRET1dOX1NU'
    'QVRFX05FR09USUFUSU5HX0NMT1NJTkdfRkVFEAQSLAooQ0hBTk5FTF9TSFVURE9XTl9TVEFURV'
    '9TSFVURE9XTl9DT01QTEVURRAF');

@$core.Deprecated('Use reserveTypeDescriptor instead')
const ReserveType$json = {
  '1': 'ReserveType',
  '2': [
    {'1': 'RESERVE_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'RESERVE_TYPE_ADAPTIVE', '2': 1},
    {'1': 'RESERVE_TYPE_TRUSTED_PEERS_NO_RESERVE', '2': 2},
    {'1': 'RESERVE_TYPE_LEGACY', '2': 3},
  ],
};

/// Descriptor for `ReserveType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List reserveTypeDescriptor = $convert.base64Decode(
    'CgtSZXNlcnZlVHlwZRIcChhSRVNFUlZFX1RZUEVfVU5TUEVDSUZJRUQQABIZChVSRVNFUlZFX1'
    'RZUEVfQURBUFRJVkUQARIpCiVSRVNFUlZFX1RZUEVfVFJVU1RFRF9QRUVSU19OT19SRVNFUlZF'
    'EAISFwoTUkVTRVJWRV9UWVBFX0xFR0FDWRAD');

@$core.Deprecated('Use balanceSourceDescriptor instead')
const BalanceSource$json = {
  '1': 'BalanceSource',
  '2': [
    {'1': 'HOLDER_FORCE_CLOSED', '2': 0},
    {'1': 'COUNTERPARTY_FORCE_CLOSED', '2': 1},
    {'1': 'COOP_CLOSE', '2': 2},
    {'1': 'HTLC', '2': 3},
  ],
};

/// Descriptor for `BalanceSource`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List balanceSourceDescriptor = $convert.base64Decode(
    'Cg1CYWxhbmNlU291cmNlEhcKE0hPTERFUl9GT1JDRV9DTE9TRUQQABIdChlDT1VOVEVSUEFSVF'
    'lfRk9SQ0VfQ0xPU0VEEAESDgoKQ09PUF9DTE9TRRACEggKBEhUTEMQAw==');

@$core.Deprecated('Use channelDirectionDescriptor instead')
const ChannelDirection$json = {
  '1': 'ChannelDirection',
  '2': [
    {'1': 'NODE_ONE', '2': 0},
    {'1': 'NODE_TWO', '2': 1},
  ],
};

/// Descriptor for `ChannelDirection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelDirectionDescriptor = $convert.base64Decode(
    'ChBDaGFubmVsRGlyZWN0aW9uEgwKCE5PREVfT05FEAASDAoITk9ERV9UV08QAQ==');

@$core.Deprecated('Use paymentDescriptor instead')
const Payment$json = {
  '1': 'Payment',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'kind', '3': 2, '4': 1, '5': 11, '6': '.types.PaymentKind', '10': 'kind'},
    {'1': 'amount_msat', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'fee_paid_msat', '3': 7, '4': 1, '5': 4, '9': 1, '10': 'feePaidMsat', '17': true},
    {'1': 'direction', '3': 4, '4': 1, '5': 14, '6': '.types.PaymentDirection', '10': 'direction'},
    {'1': 'status', '3': 5, '4': 1, '5': 14, '6': '.types.PaymentStatus', '10': 'status'},
    {'1': 'latest_update_timestamp', '3': 6, '4': 1, '5': 4, '10': 'latestUpdateTimestamp'},
  ],
  '8': [
    {'1': '_amount_msat'},
    {'1': '_fee_paid_msat'},
  ],
};

/// Descriptor for `Payment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDescriptor = $convert.base64Decode(
    'CgdQYXltZW50Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZBImCgRraW5kGAIgASgLMh'
    'IudHlwZXMuUGF5bWVudEtpbmRSBGtpbmQSJAoLYW1vdW50X21zYXQYAyABKARIAFIKYW1vdW50'
    'TXNhdIgBARInCg1mZWVfcGFpZF9tc2F0GAcgASgESAFSC2ZlZVBhaWRNc2F0iAEBEjUKCWRpcm'
    'VjdGlvbhgEIAEoDjIXLnR5cGVzLlBheW1lbnREaXJlY3Rpb25SCWRpcmVjdGlvbhIsCgZzdGF0'
    'dXMYBSABKA4yFC50eXBlcy5QYXltZW50U3RhdHVzUgZzdGF0dXMSNgoXbGF0ZXN0X3VwZGF0ZV'
    '90aW1lc3RhbXAYBiABKARSFWxhdGVzdFVwZGF0ZVRpbWVzdGFtcEIOCgxfYW1vdW50X21zYXRC'
    'EAoOX2ZlZV9wYWlkX21zYXQ=');

@$core.Deprecated('Use payerProofOptionsDescriptor instead')
const PayerProofOptions$json = {
  '1': 'PayerProofOptions',
  '2': [
    {'1': 'note', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'note', '17': true},
    {'1': 'include_offer_description', '3': 2, '4': 1, '5': 8, '10': 'includeOfferDescription'},
    {'1': 'include_offer_issuer', '3': 3, '4': 1, '5': 8, '10': 'includeOfferIssuer'},
    {'1': 'include_invoice_amount', '3': 4, '4': 1, '5': 8, '10': 'includeInvoiceAmount'},
    {'1': 'include_invoice_created_at', '3': 5, '4': 1, '5': 8, '10': 'includeInvoiceCreatedAt'},
    {'1': 'extra_tlv_types', '3': 6, '4': 3, '5': 4, '10': 'extraTlvTypes'},
  ],
  '8': [
    {'1': '_note'},
  ],
};

/// Descriptor for `PayerProofOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payerProofOptionsDescriptor = $convert.base64Decode(
    'ChFQYXllclByb29mT3B0aW9ucxIXCgRub3RlGAEgASgJSABSBG5vdGWIAQESOgoZaW5jbHVkZV'
    '9vZmZlcl9kZXNjcmlwdGlvbhgCIAEoCFIXaW5jbHVkZU9mZmVyRGVzY3JpcHRpb24SMAoUaW5j'
    'bHVkZV9vZmZlcl9pc3N1ZXIYAyABKAhSEmluY2x1ZGVPZmZlcklzc3VlchI0ChZpbmNsdWRlX2'
    'ludm9pY2VfYW1vdW50GAQgASgIUhRpbmNsdWRlSW52b2ljZUFtb3VudBI7ChppbmNsdWRlX2lu'
    'dm9pY2VfY3JlYXRlZF9hdBgFIAEoCFIXaW5jbHVkZUludm9pY2VDcmVhdGVkQXQSJgoPZXh0cm'
    'FfdGx2X3R5cGVzGAYgAygEUg1leHRyYVRsdlR5cGVzQgcKBV9ub3Rl');

@$core.Deprecated('Use paymentKindDescriptor instead')
const PaymentKind$json = {
  '1': 'PaymentKind',
  '2': [
    {'1': 'onchain', '3': 1, '4': 1, '5': 11, '6': '.types.Onchain', '9': 0, '10': 'onchain'},
    {'1': 'bolt11', '3': 2, '4': 1, '5': 11, '6': '.types.Bolt11', '9': 0, '10': 'bolt11'},
    {'1': 'bolt12_offer', '3': 3, '4': 1, '5': 11, '6': '.types.Bolt12Offer', '9': 0, '10': 'bolt12Offer'},
    {'1': 'bolt12_refund', '3': 4, '4': 1, '5': 11, '6': '.types.Bolt12Refund', '9': 0, '10': 'bolt12Refund'},
    {'1': 'spontaneous', '3': 5, '4': 1, '5': 11, '6': '.types.Spontaneous', '9': 0, '10': 'spontaneous'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `PaymentKind`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentKindDescriptor = $convert.base64Decode(
    'CgtQYXltZW50S2luZBIqCgdvbmNoYWluGAEgASgLMg4udHlwZXMuT25jaGFpbkgAUgdvbmNoYW'
    'luEicKBmJvbHQxMRgCIAEoCzINLnR5cGVzLkJvbHQxMUgAUgZib2x0MTESNwoMYm9sdDEyX29m'
    'ZmVyGAMgASgLMhIudHlwZXMuQm9sdDEyT2ZmZXJIAFILYm9sdDEyT2ZmZXISOgoNYm9sdDEyX3'
    'JlZnVuZBgEIAEoCzITLnR5cGVzLkJvbHQxMlJlZnVuZEgAUgxib2x0MTJSZWZ1bmQSNgoLc3Bv'
    'bnRhbmVvdXMYBSABKAsyEi50eXBlcy5TcG9udGFuZW91c0gAUgtzcG9udGFuZW91c0IGCgRraW'
    '5k');

@$core.Deprecated('Use onchainDescriptor instead')
const Onchain$json = {
  '1': 'Onchain',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 9, '10': 'txid'},
    {'1': 'status', '3': 2, '4': 1, '5': 11, '6': '.types.ConfirmationStatus', '10': 'status'},
    {'1': 'tx_type', '3': 3, '4': 1, '5': 11, '6': '.types.TransactionType', '9': 0, '10': 'txType', '17': true},
  ],
  '8': [
    {'1': '_tx_type'},
  ],
};

/// Descriptor for `Onchain`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onchainDescriptor = $convert.base64Decode(
    'CgdPbmNoYWluEhIKBHR4aWQYASABKAlSBHR4aWQSMQoGc3RhdHVzGAIgASgLMhkudHlwZXMuQ2'
    '9uZmlybWF0aW9uU3RhdHVzUgZzdGF0dXMSNAoHdHhfdHlwZRgDIAEoCzIWLnR5cGVzLlRyYW5z'
    'YWN0aW9uVHlwZUgAUgZ0eFR5cGWIAQFCCgoIX3R4X3R5cGU=');

@$core.Deprecated('Use transactionChannelDescriptor instead')
const TransactionChannel$json = {
  '1': 'TransactionChannel',
  '2': [
    {'1': 'counterparty_node_id', '3': 1, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `TransactionChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionChannelDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvbkNoYW5uZWwSMAoUY291bnRlcnBhcnR5X25vZGVfaWQYASABKAlSEmNvdW'
    '50ZXJwYXJ0eU5vZGVJZBIdCgpjaGFubmVsX2lkGAIgASgJUgljaGFubmVsSWQ=');

@$core.Deprecated('Use transactionTypeDescriptor instead')
const TransactionType$json = {
  '1': 'TransactionType',
  '2': [
    {'1': 'funding', '3': 1, '4': 1, '5': 11, '6': '.types.Funding', '9': 0, '10': 'funding'},
    {'1': 'cooperative_close', '3': 2, '4': 1, '5': 11, '6': '.types.CooperativeClose', '9': 0, '10': 'cooperativeClose'},
    {'1': 'unilateral_close', '3': 3, '4': 1, '5': 11, '6': '.types.UnilateralClose', '9': 0, '10': 'unilateralClose'},
    {'1': 'anchor_bump', '3': 4, '4': 1, '5': 11, '6': '.types.AnchorBump', '9': 0, '10': 'anchorBump'},
    {'1': 'claim', '3': 5, '4': 1, '5': 11, '6': '.types.Claim', '9': 0, '10': 'claim'},
    {'1': 'sweep', '3': 6, '4': 1, '5': 11, '6': '.types.Sweep', '9': 0, '10': 'sweep'},
    {'1': 'interactive_funding', '3': 7, '4': 1, '5': 11, '6': '.types.InteractiveFunding', '9': 0, '10': 'interactiveFunding'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `TransactionType`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionTypeDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvblR5cGUSKgoHZnVuZGluZxgBIAEoCzIOLnR5cGVzLkZ1bmRpbmdIAFIHZn'
    'VuZGluZxJGChFjb29wZXJhdGl2ZV9jbG9zZRgCIAEoCzIXLnR5cGVzLkNvb3BlcmF0aXZlQ2xv'
    'c2VIAFIQY29vcGVyYXRpdmVDbG9zZRJDChB1bmlsYXRlcmFsX2Nsb3NlGAMgASgLMhYudHlwZX'
    'MuVW5pbGF0ZXJhbENsb3NlSABSD3VuaWxhdGVyYWxDbG9zZRI0CgthbmNob3JfYnVtcBgEIAEo'
    'CzIRLnR5cGVzLkFuY2hvckJ1bXBIAFIKYW5jaG9yQnVtcBIkCgVjbGFpbRgFIAEoCzIMLnR5cG'
    'VzLkNsYWltSABSBWNsYWltEiQKBXN3ZWVwGAYgASgLMgwudHlwZXMuU3dlZXBIAFIFc3dlZXAS'
    'TAoTaW50ZXJhY3RpdmVfZnVuZGluZxgHIAEoCzIZLnR5cGVzLkludGVyYWN0aXZlRnVuZGluZ0'
    'gAUhJpbnRlcmFjdGl2ZUZ1bmRpbmdCBgoEa2luZA==');

@$core.Deprecated('Use fundingDescriptor instead')
const Funding$json = {
  '1': 'Funding',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.types.TransactionChannel', '10': 'channels'},
  ],
};

/// Descriptor for `Funding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingDescriptor = $convert.base64Decode(
    'CgdGdW5kaW5nEjUKCGNoYW5uZWxzGAEgAygLMhkudHlwZXMuVHJhbnNhY3Rpb25DaGFubmVsUg'
    'hjaGFubmVscw==');

@$core.Deprecated('Use cooperativeCloseDescriptor instead')
const CooperativeClose$json = {
  '1': 'CooperativeClose',
  '2': [
    {'1': 'counterparty_node_id', '3': 1, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `CooperativeClose`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cooperativeCloseDescriptor = $convert.base64Decode(
    'ChBDb29wZXJhdGl2ZUNsb3NlEjAKFGNvdW50ZXJwYXJ0eV9ub2RlX2lkGAEgASgJUhJjb3VudG'
    'VycGFydHlOb2RlSWQSHQoKY2hhbm5lbF9pZBgCIAEoCVIJY2hhbm5lbElk');

@$core.Deprecated('Use unilateralCloseDescriptor instead')
const UnilateralClose$json = {
  '1': 'UnilateralClose',
  '2': [
    {'1': 'counterparty_node_id', '3': 1, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `UnilateralClose`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unilateralCloseDescriptor = $convert.base64Decode(
    'Cg9VbmlsYXRlcmFsQ2xvc2USMAoUY291bnRlcnBhcnR5X25vZGVfaWQYASABKAlSEmNvdW50ZX'
    'JwYXJ0eU5vZGVJZBIdCgpjaGFubmVsX2lkGAIgASgJUgljaGFubmVsSWQ=');

@$core.Deprecated('Use anchorBumpDescriptor instead')
const AnchorBump$json = {
  '1': 'AnchorBump',
  '2': [
    {'1': 'counterparty_node_id', '3': 1, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `AnchorBump`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List anchorBumpDescriptor = $convert.base64Decode(
    'CgpBbmNob3JCdW1wEjAKFGNvdW50ZXJwYXJ0eV9ub2RlX2lkGAEgASgJUhJjb3VudGVycGFydH'
    'lOb2RlSWQSHQoKY2hhbm5lbF9pZBgCIAEoCVIJY2hhbm5lbElk');

@$core.Deprecated('Use claimDescriptor instead')
const Claim$json = {
  '1': 'Claim',
  '2': [
    {'1': 'counterparty_node_id', '3': 1, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'channel_id', '3': 2, '4': 1, '5': 9, '10': 'channelId'},
  ],
};

/// Descriptor for `Claim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimDescriptor = $convert.base64Decode(
    'CgVDbGFpbRIwChRjb3VudGVycGFydHlfbm9kZV9pZBgBIAEoCVISY291bnRlcnBhcnR5Tm9kZU'
    'lkEh0KCmNoYW5uZWxfaWQYAiABKAlSCWNoYW5uZWxJZA==');

@$core.Deprecated('Use sweepDescriptor instead')
const Sweep$json = {
  '1': 'Sweep',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.types.TransactionChannel', '10': 'channels'},
  ],
};

/// Descriptor for `Sweep`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sweepDescriptor = $convert.base64Decode(
    'CgVTd2VlcBI1CghjaGFubmVscxgBIAMoCzIZLnR5cGVzLlRyYW5zYWN0aW9uQ2hhbm5lbFIIY2'
    'hhbm5lbHM=');

@$core.Deprecated('Use interactiveFundingDescriptor instead')
const InteractiveFunding$json = {
  '1': 'InteractiveFunding',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.types.TransactionChannel', '10': 'channels'},
  ],
};

/// Descriptor for `InteractiveFunding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List interactiveFundingDescriptor = $convert.base64Decode(
    'ChJJbnRlcmFjdGl2ZUZ1bmRpbmcSNQoIY2hhbm5lbHMYASADKAsyGS50eXBlcy5UcmFuc2FjdG'
    'lvbkNoYW5uZWxSCGNoYW5uZWxz');

@$core.Deprecated('Use confirmationStatusDescriptor instead')
const ConfirmationStatus$json = {
  '1': 'ConfirmationStatus',
  '2': [
    {'1': 'confirmed', '3': 1, '4': 1, '5': 11, '6': '.types.Confirmed', '9': 0, '10': 'confirmed'},
    {'1': 'unconfirmed', '3': 2, '4': 1, '5': 11, '6': '.types.Unconfirmed', '9': 0, '10': 'unconfirmed'},
  ],
  '8': [
    {'1': 'status'},
  ],
};

/// Descriptor for `ConfirmationStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmationStatusDescriptor = $convert.base64Decode(
    'ChJDb25maXJtYXRpb25TdGF0dXMSMAoJY29uZmlybWVkGAEgASgLMhAudHlwZXMuQ29uZmlybW'
    'VkSABSCWNvbmZpcm1lZBI2Cgt1bmNvbmZpcm1lZBgCIAEoCzISLnR5cGVzLlVuY29uZmlybWVk'
    'SABSC3VuY29uZmlybWVkQggKBnN0YXR1cw==');

@$core.Deprecated('Use confirmedDescriptor instead')
const Confirmed$json = {
  '1': 'Confirmed',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 9, '10': 'blockHash'},
    {'1': 'height', '3': 2, '4': 1, '5': 13, '10': 'height'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 4, '10': 'timestamp'},
  ],
};

/// Descriptor for `Confirmed`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmedDescriptor = $convert.base64Decode(
    'CglDb25maXJtZWQSHQoKYmxvY2tfaGFzaBgBIAEoCVIJYmxvY2tIYXNoEhYKBmhlaWdodBgCIA'
    'EoDVIGaGVpZ2h0EhwKCXRpbWVzdGFtcBgDIAEoBFIJdGltZXN0YW1w');

@$core.Deprecated('Use unconfirmedDescriptor instead')
const Unconfirmed$json = {
  '1': 'Unconfirmed',
};

/// Descriptor for `Unconfirmed`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unconfirmedDescriptor = $convert.base64Decode(
    'CgtVbmNvbmZpcm1lZA==');

@$core.Deprecated('Use bolt11Descriptor instead')
const Bolt11$json = {
  '1': 'Bolt11',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '10': 'hash'},
    {'1': 'preimage', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'preimage', '17': true},
    {'1': 'secret', '3': 3, '4': 1, '5': 12, '9': 1, '10': 'secret', '17': true},
    {'1': 'counterparty_skimmed_fee_msat', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'counterpartySkimmedFeeMsat', '17': true},
  ],
  '8': [
    {'1': '_preimage'},
    {'1': '_secret'},
    {'1': '_counterparty_skimmed_fee_msat'},
  ],
};

/// Descriptor for `Bolt11`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11Descriptor = $convert.base64Decode(
    'CgZCb2x0MTESEgoEaGFzaBgBIAEoCVIEaGFzaBIfCghwcmVpbWFnZRgCIAEoCUgAUghwcmVpbW'
    'FnZYgBARIbCgZzZWNyZXQYAyABKAxIAVIGc2VjcmV0iAEBEkYKHWNvdW50ZXJwYXJ0eV9za2lt'
    'bWVkX2ZlZV9tc2F0GAQgASgESAJSGmNvdW50ZXJwYXJ0eVNraW1tZWRGZWVNc2F0iAEBQgsKCV'
    '9wcmVpbWFnZUIJCgdfc2VjcmV0QiAKHl9jb3VudGVycGFydHlfc2tpbW1lZF9mZWVfbXNhdA==');

@$core.Deprecated('Use bolt12OfferDescriptor instead')
const Bolt12Offer$json = {
  '1': 'Bolt12Offer',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'hash', '17': true},
    {'1': 'preimage', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'preimage', '17': true},
    {'1': 'secret', '3': 3, '4': 1, '5': 12, '9': 2, '10': 'secret', '17': true},
    {'1': 'offer_id', '3': 4, '4': 1, '5': 9, '10': 'offerId'},
    {'1': 'payer_note', '3': 5, '4': 1, '5': 9, '9': 3, '10': 'payerNote', '17': true},
    {'1': 'quantity', '3': 6, '4': 1, '5': 4, '9': 4, '10': 'quantity', '17': true},
  ],
  '8': [
    {'1': '_hash'},
    {'1': '_preimage'},
    {'1': '_secret'},
    {'1': '_payer_note'},
    {'1': '_quantity'},
  ],
};

/// Descriptor for `Bolt12Offer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12OfferDescriptor = $convert.base64Decode(
    'CgtCb2x0MTJPZmZlchIXCgRoYXNoGAEgASgJSABSBGhhc2iIAQESHwoIcHJlaW1hZ2UYAiABKA'
    'lIAVIIcHJlaW1hZ2WIAQESGwoGc2VjcmV0GAMgASgMSAJSBnNlY3JldIgBARIZCghvZmZlcl9p'
    'ZBgEIAEoCVIHb2ZmZXJJZBIiCgpwYXllcl9ub3RlGAUgASgJSANSCXBheWVyTm90ZYgBARIfCg'
    'hxdWFudGl0eRgGIAEoBEgEUghxdWFudGl0eYgBAUIHCgVfaGFzaEILCglfcHJlaW1hZ2VCCQoH'
    'X3NlY3JldEINCgtfcGF5ZXJfbm90ZUILCglfcXVhbnRpdHk=');

@$core.Deprecated('Use bolt12RefundDescriptor instead')
const Bolt12Refund$json = {
  '1': 'Bolt12Refund',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'hash', '17': true},
    {'1': 'preimage', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'preimage', '17': true},
    {'1': 'secret', '3': 3, '4': 1, '5': 12, '9': 2, '10': 'secret', '17': true},
    {'1': 'payer_note', '3': 5, '4': 1, '5': 9, '9': 3, '10': 'payerNote', '17': true},
    {'1': 'quantity', '3': 6, '4': 1, '5': 4, '9': 4, '10': 'quantity', '17': true},
  ],
  '8': [
    {'1': '_hash'},
    {'1': '_preimage'},
    {'1': '_secret'},
    {'1': '_payer_note'},
    {'1': '_quantity'},
  ],
};

/// Descriptor for `Bolt12Refund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12RefundDescriptor = $convert.base64Decode(
    'CgxCb2x0MTJSZWZ1bmQSFwoEaGFzaBgBIAEoCUgAUgRoYXNoiAEBEh8KCHByZWltYWdlGAIgAS'
    'gJSAFSCHByZWltYWdliAEBEhsKBnNlY3JldBgDIAEoDEgCUgZzZWNyZXSIAQESIgoKcGF5ZXJf'
    'bm90ZRgFIAEoCUgDUglwYXllck5vdGWIAQESHwoIcXVhbnRpdHkYBiABKARIBFIIcXVhbnRpdH'
    'mIAQFCBwoFX2hhc2hCCwoJX3ByZWltYWdlQgkKB19zZWNyZXRCDQoLX3BheWVyX25vdGVCCwoJ'
    'X3F1YW50aXR5');

@$core.Deprecated('Use spontaneousDescriptor instead')
const Spontaneous$json = {
  '1': 'Spontaneous',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 9, '10': 'hash'},
    {'1': 'preimage', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'preimage', '17': true},
  ],
  '8': [
    {'1': '_preimage'},
  ],
};

/// Descriptor for `Spontaneous`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spontaneousDescriptor = $convert.base64Decode(
    'CgtTcG9udGFuZW91cxISCgRoYXNoGAEgASgJUgRoYXNoEh8KCHByZWltYWdlGAIgASgJSABSCH'
    'ByZWltYWdliAEBQgsKCV9wcmVpbWFnZQ==');

@$core.Deprecated('Use lSPFeeLimitsDescriptor instead')
const LSPFeeLimits$json = {
  '1': 'LSPFeeLimits',
  '2': [
    {'1': 'max_total_opening_fee_msat', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'maxTotalOpeningFeeMsat', '17': true},
    {'1': 'max_proportional_opening_fee_ppm_msat', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'maxProportionalOpeningFeePpmMsat', '17': true},
  ],
  '8': [
    {'1': '_max_total_opening_fee_msat'},
    {'1': '_max_proportional_opening_fee_ppm_msat'},
  ],
};

/// Descriptor for `LSPFeeLimits`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lSPFeeLimitsDescriptor = $convert.base64Decode(
    'CgxMU1BGZWVMaW1pdHMSPwoabWF4X3RvdGFsX29wZW5pbmdfZmVlX21zYXQYASABKARIAFIWbW'
    'F4VG90YWxPcGVuaW5nRmVlTXNhdIgBARJUCiVtYXhfcHJvcG9ydGlvbmFsX29wZW5pbmdfZmVl'
    'X3BwbV9tc2F0GAIgASgESAFSIG1heFByb3BvcnRpb25hbE9wZW5pbmdGZWVQcG1Nc2F0iAEBQh'
    '0KG19tYXhfdG90YWxfb3BlbmluZ19mZWVfbXNhdEIoCiZfbWF4X3Byb3BvcnRpb25hbF9vcGVu'
    'aW5nX2ZlZV9wcG1fbXNhdA==');

@$core.Deprecated('Use htlcLocatorDescriptor instead')
const HtlcLocator$json = {
  '1': 'HtlcLocator',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'user_channel_id', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'userChannelId', '17': true},
    {'1': 'node_id', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'nodeId', '17': true},
    {'1': 'amount_msat', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'amountMsat', '17': true},
  ],
  '8': [
    {'1': '_user_channel_id'},
    {'1': '_node_id'},
    {'1': '_amount_msat'},
  ],
};

/// Descriptor for `HtlcLocator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htlcLocatorDescriptor = $convert.base64Decode(
    'CgtIdGxjTG9jYXRvchIdCgpjaGFubmVsX2lkGAEgASgJUgljaGFubmVsSWQSKwoPdXNlcl9jaG'
    'FubmVsX2lkGAIgASgJSABSDXVzZXJDaGFubmVsSWSIAQESHAoHbm9kZV9pZBgDIAEoCUgBUgZu'
    'b2RlSWSIAQESJAoLYW1vdW50X21zYXQYBCABKARIAlIKYW1vdW50TXNhdIgBAUISChBfdXNlcl'
    '9jaGFubmVsX2lkQgoKCF9ub2RlX2lkQg4KDF9hbW91bnRfbXNhdA==');

@$core.Deprecated('Use forwardedPaymentDescriptor instead')
const ForwardedPayment$json = {
  '1': 'ForwardedPayment',
  '2': [
    {'1': 'total_fee_earned_msat', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'totalFeeEarnedMsat', '17': true},
    {'1': 'skimmed_fee_msat', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'skimmedFeeMsat', '17': true},
    {'1': 'claim_from_onchain_tx', '3': 3, '4': 1, '5': 8, '10': 'claimFromOnchainTx'},
    {'1': 'outbound_amount_forwarded_msat', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'outboundAmountForwardedMsat', '17': true},
    {'1': 'prev_htlcs', '3': 5, '4': 3, '5': 11, '6': '.types.HtlcLocator', '10': 'prevHtlcs'},
    {'1': 'next_htlcs', '3': 6, '4': 3, '5': 11, '6': '.types.HtlcLocator', '10': 'nextHtlcs'},
  ],
  '8': [
    {'1': '_total_fee_earned_msat'},
    {'1': '_skimmed_fee_msat'},
    {'1': '_outbound_amount_forwarded_msat'},
  ],
};

/// Descriptor for `ForwardedPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardedPaymentDescriptor = $convert.base64Decode(
    'ChBGb3J3YXJkZWRQYXltZW50EjYKFXRvdGFsX2ZlZV9lYXJuZWRfbXNhdBgBIAEoBEgAUhJ0b3'
    'RhbEZlZUVhcm5lZE1zYXSIAQESLQoQc2tpbW1lZF9mZWVfbXNhdBgCIAEoBEgBUg5za2ltbWVk'
    'RmVlTXNhdIgBARIxChVjbGFpbV9mcm9tX29uY2hhaW5fdHgYAyABKAhSEmNsYWltRnJvbU9uY2'
    'hhaW5UeBJICh5vdXRib3VuZF9hbW91bnRfZm9yd2FyZGVkX21zYXQYBCABKARIAlIbb3V0Ym91'
    'bmRBbW91bnRGb3J3YXJkZWRNc2F0iAEBEjEKCnByZXZfaHRsY3MYBSADKAsyEi50eXBlcy5IdG'
    'xjTG9jYXRvclIJcHJldkh0bGNzEjEKCm5leHRfaHRsY3MYBiADKAsyEi50eXBlcy5IdGxjTG9j'
    'YXRvclIJbmV4dEh0bGNzQhgKFl90b3RhbF9mZWVfZWFybmVkX21zYXRCEwoRX3NraW1tZWRfZm'
    'VlX21zYXRCIQofX291dGJvdW5kX2Ftb3VudF9mb3J3YXJkZWRfbXNhdA==');

@$core.Deprecated('Use channelDescriptor instead')
const Channel$json = {
  '1': 'Channel',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'funding_txo', '3': 3, '4': 1, '5': 11, '6': '.types.OutPoint', '9': 0, '10': 'fundingTxo', '17': true},
    {'1': 'user_channel_id', '3': 4, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'unspendable_punishment_reserve', '3': 5, '4': 1, '5': 4, '9': 1, '10': 'unspendablePunishmentReserve', '17': true},
    {'1': 'channel_value_sats', '3': 6, '4': 1, '5': 4, '10': 'channelValueSats'},
    {'1': 'feerate_sat_per_1000_weight', '3': 7, '4': 1, '5': 13, '10': 'feerateSatPer1000Weight'},
    {'1': 'outbound_capacity_msat', '3': 8, '4': 1, '5': 4, '10': 'outboundCapacityMsat'},
    {'1': 'inbound_capacity_msat', '3': 9, '4': 1, '5': 4, '10': 'inboundCapacityMsat'},
    {'1': 'confirmations_required', '3': 10, '4': 1, '5': 13, '9': 2, '10': 'confirmationsRequired', '17': true},
    {'1': 'confirmations', '3': 11, '4': 1, '5': 13, '9': 3, '10': 'confirmations', '17': true},
    {'1': 'is_outbound', '3': 12, '4': 1, '5': 8, '10': 'isOutbound'},
    {'1': 'is_channel_ready', '3': 13, '4': 1, '5': 8, '10': 'isChannelReady'},
    {'1': 'is_usable', '3': 14, '4': 1, '5': 8, '10': 'isUsable'},
    {'1': 'is_announced', '3': 15, '4': 1, '5': 8, '10': 'isAnnounced'},
    {'1': 'channel_config', '3': 16, '4': 1, '5': 11, '6': '.types.ChannelConfig', '10': 'channelConfig'},
    {'1': 'next_outbound_htlc_limit_msat', '3': 17, '4': 1, '5': 4, '10': 'nextOutboundHtlcLimitMsat'},
    {'1': 'next_outbound_htlc_minimum_msat', '3': 18, '4': 1, '5': 4, '10': 'nextOutboundHtlcMinimumMsat'},
    {'1': 'force_close_spend_delay', '3': 19, '4': 1, '5': 13, '9': 4, '10': 'forceCloseSpendDelay', '17': true},
    {'1': 'counterparty_outbound_htlc_minimum_msat', '3': 20, '4': 1, '5': 4, '9': 5, '10': 'counterpartyOutboundHtlcMinimumMsat', '17': true},
    {'1': 'counterparty_outbound_htlc_maximum_msat', '3': 21, '4': 1, '5': 4, '9': 6, '10': 'counterpartyOutboundHtlcMaximumMsat', '17': true},
    {'1': 'counterparty_unspendable_punishment_reserve', '3': 22, '4': 1, '5': 4, '10': 'counterpartyUnspendablePunishmentReserve'},
    {'1': 'counterparty_forwarding_info_fee_base_msat', '3': 23, '4': 1, '5': 13, '9': 7, '10': 'counterpartyForwardingInfoFeeBaseMsat', '17': true},
    {'1': 'counterparty_forwarding_info_fee_proportional_millionths', '3': 24, '4': 1, '5': 13, '9': 8, '10': 'counterpartyForwardingInfoFeeProportionalMillionths', '17': true},
    {'1': 'counterparty_forwarding_info_cltv_expiry_delta', '3': 25, '4': 1, '5': 13, '9': 9, '10': 'counterpartyForwardingInfoCltvExpiryDelta', '17': true},
    {'1': 'short_channel_id', '3': 26, '4': 1, '5': 4, '9': 10, '10': 'shortChannelId', '17': true},
    {'1': 'outbound_scid_alias', '3': 27, '4': 1, '5': 4, '9': 11, '10': 'outboundScidAlias', '17': true},
    {'1': 'inbound_scid_alias', '3': 28, '4': 1, '5': 4, '9': 12, '10': 'inboundScidAlias', '17': true},
    {'1': 'inbound_htlc_minimum_msat', '3': 29, '4': 1, '5': 4, '10': 'inboundHtlcMinimumMsat'},
    {'1': 'inbound_htlc_maximum_msat', '3': 30, '4': 1, '5': 4, '9': 13, '10': 'inboundHtlcMaximumMsat', '17': true},
    {'1': 'channel_shutdown_state', '3': 31, '4': 1, '5': 14, '6': '.types.ChannelShutdownState', '9': 14, '10': 'channelShutdownState', '17': true},
    {'1': 'reserve_type', '3': 32, '4': 1, '5': 14, '6': '.types.ReserveType', '9': 15, '10': 'reserveType', '17': true},
    {'1': 'channel_type', '3': 33, '4': 3, '5': 11, '6': '.types.Channel.ChannelTypeEntry', '10': 'channelType'},
    {'1': 'counterparty_features', '3': 34, '4': 3, '5': 11, '6': '.types.Channel.CounterpartyFeaturesEntry', '10': 'counterpartyFeatures'},
  ],
  '3': [Channel_ChannelTypeEntry$json, Channel_CounterpartyFeaturesEntry$json],
  '8': [
    {'1': '_funding_txo'},
    {'1': '_unspendable_punishment_reserve'},
    {'1': '_confirmations_required'},
    {'1': '_confirmations'},
    {'1': '_force_close_spend_delay'},
    {'1': '_counterparty_outbound_htlc_minimum_msat'},
    {'1': '_counterparty_outbound_htlc_maximum_msat'},
    {'1': '_counterparty_forwarding_info_fee_base_msat'},
    {'1': '_counterparty_forwarding_info_fee_proportional_millionths'},
    {'1': '_counterparty_forwarding_info_cltv_expiry_delta'},
    {'1': '_short_channel_id'},
    {'1': '_outbound_scid_alias'},
    {'1': '_inbound_scid_alias'},
    {'1': '_inbound_htlc_maximum_msat'},
    {'1': '_channel_shutdown_state'},
    {'1': '_reserve_type'},
  ],
};

@$core.Deprecated('Use channelDescriptor instead')
const Channel_ChannelTypeEntry$json = {
  '1': 'ChannelTypeEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.types.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use channelDescriptor instead')
const Channel_CounterpartyFeaturesEntry$json = {
  '1': 'CounterpartyFeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.types.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Channel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelDescriptor = $convert.base64Decode(
    'CgdDaGFubmVsEh0KCmNoYW5uZWxfaWQYASABKAlSCWNoYW5uZWxJZBIwChRjb3VudGVycGFydH'
    'lfbm9kZV9pZBgCIAEoCVISY291bnRlcnBhcnR5Tm9kZUlkEjUKC2Z1bmRpbmdfdHhvGAMgASgL'
    'Mg8udHlwZXMuT3V0UG9pbnRIAFIKZnVuZGluZ1R4b4gBARImCg91c2VyX2NoYW5uZWxfaWQYBC'
    'ABKAlSDXVzZXJDaGFubmVsSWQSSQoedW5zcGVuZGFibGVfcHVuaXNobWVudF9yZXNlcnZlGAUg'
    'ASgESAFSHHVuc3BlbmRhYmxlUHVuaXNobWVudFJlc2VydmWIAQESLAoSY2hhbm5lbF92YWx1ZV'
    '9zYXRzGAYgASgEUhBjaGFubmVsVmFsdWVTYXRzEjwKG2ZlZXJhdGVfc2F0X3Blcl8xMDAwX3dl'
    'aWdodBgHIAEoDVIXZmVlcmF0ZVNhdFBlcjEwMDBXZWlnaHQSNAoWb3V0Ym91bmRfY2FwYWNpdH'
    'lfbXNhdBgIIAEoBFIUb3V0Ym91bmRDYXBhY2l0eU1zYXQSMgoVaW5ib3VuZF9jYXBhY2l0eV9t'
    'c2F0GAkgASgEUhNpbmJvdW5kQ2FwYWNpdHlNc2F0EjoKFmNvbmZpcm1hdGlvbnNfcmVxdWlyZW'
    'QYCiABKA1IAlIVY29uZmlybWF0aW9uc1JlcXVpcmVkiAEBEikKDWNvbmZpcm1hdGlvbnMYCyAB'
    'KA1IA1INY29uZmlybWF0aW9uc4gBARIfCgtpc19vdXRib3VuZBgMIAEoCFIKaXNPdXRib3VuZB'
    'IoChBpc19jaGFubmVsX3JlYWR5GA0gASgIUg5pc0NoYW5uZWxSZWFkeRIbCglpc191c2FibGUY'
    'DiABKAhSCGlzVXNhYmxlEiEKDGlzX2Fubm91bmNlZBgPIAEoCFILaXNBbm5vdW5jZWQSOwoOY2'
    'hhbm5lbF9jb25maWcYECABKAsyFC50eXBlcy5DaGFubmVsQ29uZmlnUg1jaGFubmVsQ29uZmln'
    'EkAKHW5leHRfb3V0Ym91bmRfaHRsY19saW1pdF9tc2F0GBEgASgEUhluZXh0T3V0Ym91bmRIdG'
    'xjTGltaXRNc2F0EkQKH25leHRfb3V0Ym91bmRfaHRsY19taW5pbXVtX21zYXQYEiABKARSG25l'
    'eHRPdXRib3VuZEh0bGNNaW5pbXVtTXNhdBI6Chdmb3JjZV9jbG9zZV9zcGVuZF9kZWxheRgTIA'
    'EoDUgEUhRmb3JjZUNsb3NlU3BlbmREZWxheYgBARJZCidjb3VudGVycGFydHlfb3V0Ym91bmRf'
    'aHRsY19taW5pbXVtX21zYXQYFCABKARIBVIjY291bnRlcnBhcnR5T3V0Ym91bmRIdGxjTWluaW'
    '11bU1zYXSIAQESWQonY291bnRlcnBhcnR5X291dGJvdW5kX2h0bGNfbWF4aW11bV9tc2F0GBUg'
    'ASgESAZSI2NvdW50ZXJwYXJ0eU91dGJvdW5kSHRsY01heGltdW1Nc2F0iAEBEl0KK2NvdW50ZX'
    'JwYXJ0eV91bnNwZW5kYWJsZV9wdW5pc2htZW50X3Jlc2VydmUYFiABKARSKGNvdW50ZXJwYXJ0'
    'eVVuc3BlbmRhYmxlUHVuaXNobWVudFJlc2VydmUSXgoqY291bnRlcnBhcnR5X2ZvcndhcmRpbm'
    'dfaW5mb19mZWVfYmFzZV9tc2F0GBcgASgNSAdSJWNvdW50ZXJwYXJ0eUZvcndhcmRpbmdJbmZv'
    'RmVlQmFzZU1zYXSIAQESego4Y291bnRlcnBhcnR5X2ZvcndhcmRpbmdfaW5mb19mZWVfcHJvcG'
    '9ydGlvbmFsX21pbGxpb250aHMYGCABKA1ICFIzY291bnRlcnBhcnR5Rm9yd2FyZGluZ0luZm9G'
    'ZWVQcm9wb3J0aW9uYWxNaWxsaW9udGhziAEBEmYKLmNvdW50ZXJwYXJ0eV9mb3J3YXJkaW5nX2'
    'luZm9fY2x0dl9leHBpcnlfZGVsdGEYGSABKA1ICVIpY291bnRlcnBhcnR5Rm9yd2FyZGluZ0lu'
    'Zm9DbHR2RXhwaXJ5RGVsdGGIAQESLQoQc2hvcnRfY2hhbm5lbF9pZBgaIAEoBEgKUg5zaG9ydE'
    'NoYW5uZWxJZIgBARIzChNvdXRib3VuZF9zY2lkX2FsaWFzGBsgASgESAtSEW91dGJvdW5kU2Np'
    'ZEFsaWFziAEBEjEKEmluYm91bmRfc2NpZF9hbGlhcxgcIAEoBEgMUhBpbmJvdW5kU2NpZEFsaW'
    'FziAEBEjkKGWluYm91bmRfaHRsY19taW5pbXVtX21zYXQYHSABKARSFmluYm91bmRIdGxjTWlu'
    'aW11bU1zYXQSPgoZaW5ib3VuZF9odGxjX21heGltdW1fbXNhdBgeIAEoBEgNUhZpbmJvdW5kSH'
    'RsY01heGltdW1Nc2F0iAEBElYKFmNoYW5uZWxfc2h1dGRvd25fc3RhdGUYHyABKA4yGy50eXBl'
    'cy5DaGFubmVsU2h1dGRvd25TdGF0ZUgOUhRjaGFubmVsU2h1dGRvd25TdGF0ZYgBARI6CgxyZX'
    'NlcnZlX3R5cGUYICABKA4yEi50eXBlcy5SZXNlcnZlVHlwZUgPUgtyZXNlcnZlVHlwZYgBARJC'
    'CgxjaGFubmVsX3R5cGUYISADKAsyHy50eXBlcy5DaGFubmVsLkNoYW5uZWxUeXBlRW50cnlSC2'
    'NoYW5uZWxUeXBlEl0KFWNvdW50ZXJwYXJ0eV9mZWF0dXJlcxgiIAMoCzIoLnR5cGVzLkNoYW5u'
    'ZWwuQ291bnRlcnBhcnR5RmVhdHVyZXNFbnRyeVIUY291bnRlcnBhcnR5RmVhdHVyZXMaTgoQQ2'
    'hhbm5lbFR5cGVFbnRyeRIQCgNrZXkYASABKA1SA2tleRIkCgV2YWx1ZRgCIAEoCzIOLnR5cGVz'
    'LkZlYXR1cmVSBXZhbHVlOgI4ARpXChlDb3VudGVycGFydHlGZWF0dXJlc0VudHJ5EhAKA2tleR'
    'gBIAEoDVIDa2V5EiQKBXZhbHVlGAIgASgLMg4udHlwZXMuRmVhdHVyZVIFdmFsdWU6AjgBQg4K'
    'DF9mdW5kaW5nX3R4b0IhCh9fdW5zcGVuZGFibGVfcHVuaXNobWVudF9yZXNlcnZlQhkKF19jb2'
    '5maXJtYXRpb25zX3JlcXVpcmVkQhAKDl9jb25maXJtYXRpb25zQhoKGF9mb3JjZV9jbG9zZV9z'
    'cGVuZF9kZWxheUIqCihfY291bnRlcnBhcnR5X291dGJvdW5kX2h0bGNfbWluaW11bV9tc2F0Qi'
    'oKKF9jb3VudGVycGFydHlfb3V0Ym91bmRfaHRsY19tYXhpbXVtX21zYXRCLQorX2NvdW50ZXJw'
    'YXJ0eV9mb3J3YXJkaW5nX2luZm9fZmVlX2Jhc2VfbXNhdEI7CjlfY291bnRlcnBhcnR5X2Zvcn'
    'dhcmRpbmdfaW5mb19mZWVfcHJvcG9ydGlvbmFsX21pbGxpb250aHNCMQovX2NvdW50ZXJwYXJ0'
    'eV9mb3J3YXJkaW5nX2luZm9fY2x0dl9leHBpcnlfZGVsdGFCEwoRX3Nob3J0X2NoYW5uZWxfaW'
    'RCFgoUX291dGJvdW5kX3NjaWRfYWxpYXNCFQoTX2luYm91bmRfc2NpZF9hbGlhc0IcChpfaW5i'
    'b3VuZF9odGxjX21heGltdW1fbXNhdEIZChdfY2hhbm5lbF9zaHV0ZG93bl9zdGF0ZUIPCg1fcm'
    'VzZXJ2ZV90eXBl');

@$core.Deprecated('Use channelConfigDescriptor instead')
const ChannelConfig$json = {
  '1': 'ChannelConfig',
  '2': [
    {'1': 'forwarding_fee_proportional_millionths', '3': 1, '4': 1, '5': 13, '9': 1, '10': 'forwardingFeeProportionalMillionths', '17': true},
    {'1': 'forwarding_fee_base_msat', '3': 2, '4': 1, '5': 13, '9': 2, '10': 'forwardingFeeBaseMsat', '17': true},
    {'1': 'cltv_expiry_delta', '3': 3, '4': 1, '5': 13, '9': 3, '10': 'cltvExpiryDelta', '17': true},
    {'1': 'force_close_avoidance_max_fee_satoshis', '3': 4, '4': 1, '5': 4, '9': 4, '10': 'forceCloseAvoidanceMaxFeeSatoshis', '17': true},
    {'1': 'accept_underpaying_htlcs', '3': 5, '4': 1, '5': 8, '9': 5, '10': 'acceptUnderpayingHtlcs', '17': true},
    {'1': 'fixed_limit_msat', '3': 6, '4': 1, '5': 4, '9': 0, '10': 'fixedLimitMsat'},
    {'1': 'fee_rate_multiplier', '3': 7, '4': 1, '5': 4, '9': 0, '10': 'feeRateMultiplier'},
  ],
  '8': [
    {'1': 'max_dust_htlc_exposure'},
    {'1': '_forwarding_fee_proportional_millionths'},
    {'1': '_forwarding_fee_base_msat'},
    {'1': '_cltv_expiry_delta'},
    {'1': '_force_close_avoidance_max_fee_satoshis'},
    {'1': '_accept_underpaying_htlcs'},
  ],
};

/// Descriptor for `ChannelConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelConfigDescriptor = $convert.base64Decode(
    'Cg1DaGFubmVsQ29uZmlnElgKJmZvcndhcmRpbmdfZmVlX3Byb3BvcnRpb25hbF9taWxsaW9udG'
    'hzGAEgASgNSAFSI2ZvcndhcmRpbmdGZWVQcm9wb3J0aW9uYWxNaWxsaW9udGhziAEBEjwKGGZv'
    'cndhcmRpbmdfZmVlX2Jhc2VfbXNhdBgCIAEoDUgCUhVmb3J3YXJkaW5nRmVlQmFzZU1zYXSIAQ'
    'ESLwoRY2x0dl9leHBpcnlfZGVsdGEYAyABKA1IA1IPY2x0dkV4cGlyeURlbHRhiAEBElYKJmZv'
    'cmNlX2Nsb3NlX2F2b2lkYW5jZV9tYXhfZmVlX3NhdG9zaGlzGAQgASgESARSIWZvcmNlQ2xvc2'
    'VBdm9pZGFuY2VNYXhGZWVTYXRvc2hpc4gBARI9ChhhY2NlcHRfdW5kZXJwYXlpbmdfaHRsY3MY'
    'BSABKAhIBVIWYWNjZXB0VW5kZXJwYXlpbmdIdGxjc4gBARIqChBmaXhlZF9saW1pdF9tc2F0GA'
    'YgASgESABSDmZpeGVkTGltaXRNc2F0EjAKE2ZlZV9yYXRlX211bHRpcGxpZXIYByABKARIAFIR'
    'ZmVlUmF0ZU11bHRpcGxpZXJCGAoWbWF4X2R1c3RfaHRsY19leHBvc3VyZUIpCidfZm9yd2FyZG'
    'luZ19mZWVfcHJvcG9ydGlvbmFsX21pbGxpb250aHNCGwoZX2ZvcndhcmRpbmdfZmVlX2Jhc2Vf'
    'bXNhdEIUChJfY2x0dl9leHBpcnlfZGVsdGFCKQonX2ZvcmNlX2Nsb3NlX2F2b2lkYW5jZV9tYX'
    'hfZmVlX3NhdG9zaGlzQhsKGV9hY2NlcHRfdW5kZXJwYXlpbmdfaHRsY3M=');

@$core.Deprecated('Use outPointDescriptor instead')
const OutPoint$json = {
  '1': 'OutPoint',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 9, '10': 'txid'},
    {'1': 'vout', '3': 2, '4': 1, '5': 13, '10': 'vout'},
  ],
};

/// Descriptor for `OutPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outPointDescriptor = $convert.base64Decode(
    'CghPdXRQb2ludBISCgR0eGlkGAEgASgJUgR0eGlkEhIKBHZvdXQYAiABKA1SBHZvdXQ=');

@$core.Deprecated('Use bestBlockDescriptor instead')
const BestBlock$json = {
  '1': 'BestBlock',
  '2': [
    {'1': 'block_hash', '3': 1, '4': 1, '5': 9, '10': 'blockHash'},
    {'1': 'height', '3': 2, '4': 1, '5': 13, '10': 'height'},
  ],
};

/// Descriptor for `BestBlock`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bestBlockDescriptor = $convert.base64Decode(
    'CglCZXN0QmxvY2sSHQoKYmxvY2tfaGFzaBgBIAEoCVIJYmxvY2tIYXNoEhYKBmhlaWdodBgCIA'
    'EoDVIGaGVpZ2h0');

@$core.Deprecated('Use lightningBalanceDescriptor instead')
const LightningBalance$json = {
  '1': 'LightningBalance',
  '2': [
    {'1': 'claimable_on_channel_close', '3': 1, '4': 1, '5': 11, '6': '.types.ClaimableOnChannelClose', '9': 0, '10': 'claimableOnChannelClose'},
    {'1': 'claimable_awaiting_confirmations', '3': 2, '4': 1, '5': 11, '6': '.types.ClaimableAwaitingConfirmations', '9': 0, '10': 'claimableAwaitingConfirmations'},
    {'1': 'contentious_claimable', '3': 3, '4': 1, '5': 11, '6': '.types.ContentiousClaimable', '9': 0, '10': 'contentiousClaimable'},
    {'1': 'maybe_timeout_claimable_htlc', '3': 4, '4': 1, '5': 11, '6': '.types.MaybeTimeoutClaimableHTLC', '9': 0, '10': 'maybeTimeoutClaimableHtlc'},
    {'1': 'maybe_preimage_claimable_htlc', '3': 5, '4': 1, '5': 11, '6': '.types.MaybePreimageClaimableHTLC', '9': 0, '10': 'maybePreimageClaimableHtlc'},
    {'1': 'counterparty_revoked_output_claimable', '3': 6, '4': 1, '5': 11, '6': '.types.CounterpartyRevokedOutputClaimable', '9': 0, '10': 'counterpartyRevokedOutputClaimable'},
  ],
  '8': [
    {'1': 'balance_type'},
  ],
};

/// Descriptor for `LightningBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lightningBalanceDescriptor = $convert.base64Decode(
    'ChBMaWdodG5pbmdCYWxhbmNlEl0KGmNsYWltYWJsZV9vbl9jaGFubmVsX2Nsb3NlGAEgASgLMh'
    '4udHlwZXMuQ2xhaW1hYmxlT25DaGFubmVsQ2xvc2VIAFIXY2xhaW1hYmxlT25DaGFubmVsQ2xv'
    'c2UScQogY2xhaW1hYmxlX2F3YWl0aW5nX2NvbmZpcm1hdGlvbnMYAiABKAsyJS50eXBlcy5DbG'
    'FpbWFibGVBd2FpdGluZ0NvbmZpcm1hdGlvbnNIAFIeY2xhaW1hYmxlQXdhaXRpbmdDb25maXJt'
    'YXRpb25zElIKFWNvbnRlbnRpb3VzX2NsYWltYWJsZRgDIAEoCzIbLnR5cGVzLkNvbnRlbnRpb3'
    'VzQ2xhaW1hYmxlSABSFGNvbnRlbnRpb3VzQ2xhaW1hYmxlEmMKHG1heWJlX3RpbWVvdXRfY2xh'
    'aW1hYmxlX2h0bGMYBCABKAsyIC50eXBlcy5NYXliZVRpbWVvdXRDbGFpbWFibGVIVExDSABSGW'
    '1heWJlVGltZW91dENsYWltYWJsZUh0bGMSZgodbWF5YmVfcHJlaW1hZ2VfY2xhaW1hYmxlX2h0'
    'bGMYBSABKAsyIS50eXBlcy5NYXliZVByZWltYWdlQ2xhaW1hYmxlSFRMQ0gAUhptYXliZVByZW'
    'ltYWdlQ2xhaW1hYmxlSHRsYxJ+CiVjb3VudGVycGFydHlfcmV2b2tlZF9vdXRwdXRfY2xhaW1h'
    'YmxlGAYgASgLMikudHlwZXMuQ291bnRlcnBhcnR5UmV2b2tlZE91dHB1dENsYWltYWJsZUgAUi'
    'Jjb3VudGVycGFydHlSZXZva2VkT3V0cHV0Q2xhaW1hYmxlQg4KDGJhbGFuY2VfdHlwZQ==');

@$core.Deprecated('Use claimableOnChannelCloseDescriptor instead')
const ClaimableOnChannelClose$json = {
  '1': 'ClaimableOnChannelClose',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'amount_satoshis', '3': 3, '4': 1, '5': 4, '10': 'amountSatoshis'},
    {'1': 'transaction_fee_satoshis', '3': 4, '4': 1, '5': 4, '10': 'transactionFeeSatoshis'},
    {'1': 'outbound_payment_htlc_rounded_msat', '3': 5, '4': 1, '5': 4, '10': 'outboundPaymentHtlcRoundedMsat'},
    {'1': 'outbound_forwarded_htlc_rounded_msat', '3': 6, '4': 1, '5': 4, '10': 'outboundForwardedHtlcRoundedMsat'},
    {'1': 'inbound_claiming_htlc_rounded_msat', '3': 7, '4': 1, '5': 4, '10': 'inboundClaimingHtlcRoundedMsat'},
    {'1': 'inbound_htlc_rounded_msat', '3': 8, '4': 1, '5': 4, '10': 'inboundHtlcRoundedMsat'},
  ],
};

/// Descriptor for `ClaimableOnChannelClose`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimableOnChannelCloseDescriptor = $convert.base64Decode(
    'ChdDbGFpbWFibGVPbkNoYW5uZWxDbG9zZRIdCgpjaGFubmVsX2lkGAEgASgJUgljaGFubmVsSW'
    'QSMAoUY291bnRlcnBhcnR5X25vZGVfaWQYAiABKAlSEmNvdW50ZXJwYXJ0eU5vZGVJZBInCg9h'
    'bW91bnRfc2F0b3NoaXMYAyABKARSDmFtb3VudFNhdG9zaGlzEjgKGHRyYW5zYWN0aW9uX2ZlZV'
    '9zYXRvc2hpcxgEIAEoBFIWdHJhbnNhY3Rpb25GZWVTYXRvc2hpcxJKCiJvdXRib3VuZF9wYXlt'
    'ZW50X2h0bGNfcm91bmRlZF9tc2F0GAUgASgEUh5vdXRib3VuZFBheW1lbnRIdGxjUm91bmRlZE'
    '1zYXQSTgokb3V0Ym91bmRfZm9yd2FyZGVkX2h0bGNfcm91bmRlZF9tc2F0GAYgASgEUiBvdXRi'
    'b3VuZEZvcndhcmRlZEh0bGNSb3VuZGVkTXNhdBJKCiJpbmJvdW5kX2NsYWltaW5nX2h0bGNfcm'
    '91bmRlZF9tc2F0GAcgASgEUh5pbmJvdW5kQ2xhaW1pbmdIdGxjUm91bmRlZE1zYXQSOQoZaW5i'
    'b3VuZF9odGxjX3JvdW5kZWRfbXNhdBgIIAEoBFIWaW5ib3VuZEh0bGNSb3VuZGVkTXNhdA==');

@$core.Deprecated('Use claimableAwaitingConfirmationsDescriptor instead')
const ClaimableAwaitingConfirmations$json = {
  '1': 'ClaimableAwaitingConfirmations',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'amount_satoshis', '3': 3, '4': 1, '5': 4, '10': 'amountSatoshis'},
    {'1': 'confirmation_height', '3': 4, '4': 1, '5': 13, '10': 'confirmationHeight'},
    {'1': 'source', '3': 5, '4': 1, '5': 14, '6': '.types.BalanceSource', '10': 'source'},
  ],
};

/// Descriptor for `ClaimableAwaitingConfirmations`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List claimableAwaitingConfirmationsDescriptor = $convert.base64Decode(
    'Ch5DbGFpbWFibGVBd2FpdGluZ0NvbmZpcm1hdGlvbnMSHQoKY2hhbm5lbF9pZBgBIAEoCVIJY2'
    'hhbm5lbElkEjAKFGNvdW50ZXJwYXJ0eV9ub2RlX2lkGAIgASgJUhJjb3VudGVycGFydHlOb2Rl'
    'SWQSJwoPYW1vdW50X3NhdG9zaGlzGAMgASgEUg5hbW91bnRTYXRvc2hpcxIvChNjb25maXJtYX'
    'Rpb25faGVpZ2h0GAQgASgNUhJjb25maXJtYXRpb25IZWlnaHQSLAoGc291cmNlGAUgASgOMhQu'
    'dHlwZXMuQmFsYW5jZVNvdXJjZVIGc291cmNl');

@$core.Deprecated('Use contentiousClaimableDescriptor instead')
const ContentiousClaimable$json = {
  '1': 'ContentiousClaimable',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'amount_satoshis', '3': 3, '4': 1, '5': 4, '10': 'amountSatoshis'},
    {'1': 'timeout_height', '3': 4, '4': 1, '5': 13, '10': 'timeoutHeight'},
    {'1': 'payment_hash', '3': 5, '4': 1, '5': 9, '10': 'paymentHash'},
    {'1': 'payment_preimage', '3': 6, '4': 1, '5': 9, '10': 'paymentPreimage'},
  ],
};

/// Descriptor for `ContentiousClaimable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contentiousClaimableDescriptor = $convert.base64Decode(
    'ChRDb250ZW50aW91c0NsYWltYWJsZRIdCgpjaGFubmVsX2lkGAEgASgJUgljaGFubmVsSWQSMA'
    'oUY291bnRlcnBhcnR5X25vZGVfaWQYAiABKAlSEmNvdW50ZXJwYXJ0eU5vZGVJZBInCg9hbW91'
    'bnRfc2F0b3NoaXMYAyABKARSDmFtb3VudFNhdG9zaGlzEiUKDnRpbWVvdXRfaGVpZ2h0GAQgAS'
    'gNUg10aW1lb3V0SGVpZ2h0EiEKDHBheW1lbnRfaGFzaBgFIAEoCVILcGF5bWVudEhhc2gSKQoQ'
    'cGF5bWVudF9wcmVpbWFnZRgGIAEoCVIPcGF5bWVudFByZWltYWdl');

@$core.Deprecated('Use maybeTimeoutClaimableHTLCDescriptor instead')
const MaybeTimeoutClaimableHTLC$json = {
  '1': 'MaybeTimeoutClaimableHTLC',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'amount_satoshis', '3': 3, '4': 1, '5': 4, '10': 'amountSatoshis'},
    {'1': 'claimable_height', '3': 4, '4': 1, '5': 13, '10': 'claimableHeight'},
    {'1': 'payment_hash', '3': 5, '4': 1, '5': 9, '10': 'paymentHash'},
    {'1': 'outbound_payment', '3': 6, '4': 1, '5': 8, '10': 'outboundPayment'},
  ],
};

/// Descriptor for `MaybeTimeoutClaimableHTLC`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List maybeTimeoutClaimableHTLCDescriptor = $convert.base64Decode(
    'ChlNYXliZVRpbWVvdXRDbGFpbWFibGVIVExDEh0KCmNoYW5uZWxfaWQYASABKAlSCWNoYW5uZW'
    'xJZBIwChRjb3VudGVycGFydHlfbm9kZV9pZBgCIAEoCVISY291bnRlcnBhcnR5Tm9kZUlkEicK'
    'D2Ftb3VudF9zYXRvc2hpcxgDIAEoBFIOYW1vdW50U2F0b3NoaXMSKQoQY2xhaW1hYmxlX2hlaW'
    'dodBgEIAEoDVIPY2xhaW1hYmxlSGVpZ2h0EiEKDHBheW1lbnRfaGFzaBgFIAEoCVILcGF5bWVu'
    'dEhhc2gSKQoQb3V0Ym91bmRfcGF5bWVudBgGIAEoCFIPb3V0Ym91bmRQYXltZW50');

@$core.Deprecated('Use maybePreimageClaimableHTLCDescriptor instead')
const MaybePreimageClaimableHTLC$json = {
  '1': 'MaybePreimageClaimableHTLC',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'amount_satoshis', '3': 3, '4': 1, '5': 4, '10': 'amountSatoshis'},
    {'1': 'expiry_height', '3': 4, '4': 1, '5': 13, '10': 'expiryHeight'},
    {'1': 'payment_hash', '3': 5, '4': 1, '5': 9, '10': 'paymentHash'},
  ],
};

/// Descriptor for `MaybePreimageClaimableHTLC`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List maybePreimageClaimableHTLCDescriptor = $convert.base64Decode(
    'ChpNYXliZVByZWltYWdlQ2xhaW1hYmxlSFRMQxIdCgpjaGFubmVsX2lkGAEgASgJUgljaGFubm'
    'VsSWQSMAoUY291bnRlcnBhcnR5X25vZGVfaWQYAiABKAlSEmNvdW50ZXJwYXJ0eU5vZGVJZBIn'
    'Cg9hbW91bnRfc2F0b3NoaXMYAyABKARSDmFtb3VudFNhdG9zaGlzEiMKDWV4cGlyeV9oZWlnaH'
    'QYBCABKA1SDGV4cGlyeUhlaWdodBIhCgxwYXltZW50X2hhc2gYBSABKAlSC3BheW1lbnRIYXNo');

@$core.Deprecated('Use counterpartyRevokedOutputClaimableDescriptor instead')
const CounterpartyRevokedOutputClaimable$json = {
  '1': 'CounterpartyRevokedOutputClaimable',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'amount_satoshis', '3': 3, '4': 1, '5': 4, '10': 'amountSatoshis'},
  ],
};

/// Descriptor for `CounterpartyRevokedOutputClaimable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List counterpartyRevokedOutputClaimableDescriptor = $convert.base64Decode(
    'CiJDb3VudGVycGFydHlSZXZva2VkT3V0cHV0Q2xhaW1hYmxlEh0KCmNoYW5uZWxfaWQYASABKA'
    'lSCWNoYW5uZWxJZBIwChRjb3VudGVycGFydHlfbm9kZV9pZBgCIAEoCVISY291bnRlcnBhcnR5'
    'Tm9kZUlkEicKD2Ftb3VudF9zYXRvc2hpcxgDIAEoBFIOYW1vdW50U2F0b3NoaXM=');

@$core.Deprecated('Use pendingSweepBalanceDescriptor instead')
const PendingSweepBalance$json = {
  '1': 'PendingSweepBalance',
  '2': [
    {'1': 'pending_broadcast', '3': 1, '4': 1, '5': 11, '6': '.types.PendingBroadcast', '9': 0, '10': 'pendingBroadcast'},
    {'1': 'broadcast_awaiting_confirmation', '3': 2, '4': 1, '5': 11, '6': '.types.BroadcastAwaitingConfirmation', '9': 0, '10': 'broadcastAwaitingConfirmation'},
    {'1': 'awaiting_threshold_confirmations', '3': 3, '4': 1, '5': 11, '6': '.types.AwaitingThresholdConfirmations', '9': 0, '10': 'awaitingThresholdConfirmations'},
  ],
  '8': [
    {'1': 'balance_type'},
  ],
};

/// Descriptor for `PendingSweepBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingSweepBalanceDescriptor = $convert.base64Decode(
    'ChNQZW5kaW5nU3dlZXBCYWxhbmNlEkYKEXBlbmRpbmdfYnJvYWRjYXN0GAEgASgLMhcudHlwZX'
    'MuUGVuZGluZ0Jyb2FkY2FzdEgAUhBwZW5kaW5nQnJvYWRjYXN0Em4KH2Jyb2FkY2FzdF9hd2Fp'
    'dGluZ19jb25maXJtYXRpb24YAiABKAsyJC50eXBlcy5Ccm9hZGNhc3RBd2FpdGluZ0NvbmZpcm'
    '1hdGlvbkgAUh1icm9hZGNhc3RBd2FpdGluZ0NvbmZpcm1hdGlvbhJxCiBhd2FpdGluZ190aHJl'
    'c2hvbGRfY29uZmlybWF0aW9ucxgDIAEoCzIlLnR5cGVzLkF3YWl0aW5nVGhyZXNob2xkQ29uZm'
    'lybWF0aW9uc0gAUh5hd2FpdGluZ1RocmVzaG9sZENvbmZpcm1hdGlvbnNCDgoMYmFsYW5jZV90'
    'eXBl');

@$core.Deprecated('Use pendingBroadcastDescriptor instead')
const PendingBroadcast$json = {
  '1': 'PendingBroadcast',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'channelId', '17': true},
    {'1': 'amount_satoshis', '3': 2, '4': 1, '5': 4, '10': 'amountSatoshis'},
  ],
  '8': [
    {'1': '_channel_id'},
  ],
};

/// Descriptor for `PendingBroadcast`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingBroadcastDescriptor = $convert.base64Decode(
    'ChBQZW5kaW5nQnJvYWRjYXN0EiIKCmNoYW5uZWxfaWQYASABKAlIAFIJY2hhbm5lbElkiAEBEi'
    'cKD2Ftb3VudF9zYXRvc2hpcxgCIAEoBFIOYW1vdW50U2F0b3NoaXNCDQoLX2NoYW5uZWxfaWQ=');

@$core.Deprecated('Use broadcastAwaitingConfirmationDescriptor instead')
const BroadcastAwaitingConfirmation$json = {
  '1': 'BroadcastAwaitingConfirmation',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'channelId', '17': true},
    {'1': 'latest_broadcast_height', '3': 2, '4': 1, '5': 13, '10': 'latestBroadcastHeight'},
    {'1': 'latest_spending_txid', '3': 3, '4': 1, '5': 9, '10': 'latestSpendingTxid'},
    {'1': 'amount_satoshis', '3': 4, '4': 1, '5': 4, '10': 'amountSatoshis'},
  ],
  '8': [
    {'1': '_channel_id'},
  ],
};

/// Descriptor for `BroadcastAwaitingConfirmation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List broadcastAwaitingConfirmationDescriptor = $convert.base64Decode(
    'Ch1Ccm9hZGNhc3RBd2FpdGluZ0NvbmZpcm1hdGlvbhIiCgpjaGFubmVsX2lkGAEgASgJSABSCW'
    'NoYW5uZWxJZIgBARI2ChdsYXRlc3RfYnJvYWRjYXN0X2hlaWdodBgCIAEoDVIVbGF0ZXN0QnJv'
    'YWRjYXN0SGVpZ2h0EjAKFGxhdGVzdF9zcGVuZGluZ190eGlkGAMgASgJUhJsYXRlc3RTcGVuZG'
    'luZ1R4aWQSJwoPYW1vdW50X3NhdG9zaGlzGAQgASgEUg5hbW91bnRTYXRvc2hpc0INCgtfY2hh'
    'bm5lbF9pZA==');

@$core.Deprecated('Use awaitingThresholdConfirmationsDescriptor instead')
const AwaitingThresholdConfirmations$json = {
  '1': 'AwaitingThresholdConfirmations',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'channelId', '17': true},
    {'1': 'latest_spending_txid', '3': 2, '4': 1, '5': 9, '10': 'latestSpendingTxid'},
    {'1': 'confirmation_hash', '3': 3, '4': 1, '5': 9, '10': 'confirmationHash'},
    {'1': 'confirmation_height', '3': 4, '4': 1, '5': 13, '10': 'confirmationHeight'},
    {'1': 'amount_satoshis', '3': 5, '4': 1, '5': 4, '10': 'amountSatoshis'},
  ],
  '8': [
    {'1': '_channel_id'},
  ],
};

/// Descriptor for `AwaitingThresholdConfirmations`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List awaitingThresholdConfirmationsDescriptor = $convert.base64Decode(
    'Ch5Bd2FpdGluZ1RocmVzaG9sZENvbmZpcm1hdGlvbnMSIgoKY2hhbm5lbF9pZBgBIAEoCUgAUg'
    'ljaGFubmVsSWSIAQESMAoUbGF0ZXN0X3NwZW5kaW5nX3R4aWQYAiABKAlSEmxhdGVzdFNwZW5k'
    'aW5nVHhpZBIrChFjb25maXJtYXRpb25faGFzaBgDIAEoCVIQY29uZmlybWF0aW9uSGFzaBIvCh'
    'Njb25maXJtYXRpb25faGVpZ2h0GAQgASgNUhJjb25maXJtYXRpb25IZWlnaHQSJwoPYW1vdW50'
    'X3NhdG9zaGlzGAUgASgEUg5hbW91bnRTYXRvc2hpc0INCgtfY2hhbm5lbF9pZA==');

@$core.Deprecated('Use bolt11InvoiceDescriptionDescriptor instead')
const Bolt11InvoiceDescription$json = {
  '1': 'Bolt11InvoiceDescription',
  '2': [
    {'1': 'direct', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'direct'},
    {'1': 'hash', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'hash'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Bolt11InvoiceDescription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11InvoiceDescriptionDescriptor = $convert.base64Decode(
    'ChhCb2x0MTFJbnZvaWNlRGVzY3JpcHRpb24SGAoGZGlyZWN0GAEgASgJSABSBmRpcmVjdBIUCg'
    'RoYXNoGAIgASgJSABSBGhhc2hCBgoEa2luZA==');

@$core.Deprecated('Use routeParametersConfigDescriptor instead')
const RouteParametersConfig$json = {
  '1': 'RouteParametersConfig',
  '2': [
    {'1': 'max_total_routing_fee_msat', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'maxTotalRoutingFeeMsat', '17': true},
    {'1': 'max_total_cltv_expiry_delta', '3': 2, '4': 1, '5': 13, '10': 'maxTotalCltvExpiryDelta'},
    {'1': 'max_path_count', '3': 3, '4': 1, '5': 13, '10': 'maxPathCount'},
    {'1': 'max_channel_saturation_power_of_half', '3': 4, '4': 1, '5': 13, '10': 'maxChannelSaturationPowerOfHalf'},
  ],
  '8': [
    {'1': '_max_total_routing_fee_msat'},
  ],
};

/// Descriptor for `RouteParametersConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeParametersConfigDescriptor = $convert.base64Decode(
    'ChVSb3V0ZVBhcmFtZXRlcnNDb25maWcSPwoabWF4X3RvdGFsX3JvdXRpbmdfZmVlX21zYXQYAS'
    'ABKARIAFIWbWF4VG90YWxSb3V0aW5nRmVlTXNhdIgBARI8ChttYXhfdG90YWxfY2x0dl9leHBp'
    'cnlfZGVsdGEYAiABKA1SF21heFRvdGFsQ2x0dkV4cGlyeURlbHRhEiQKDm1heF9wYXRoX2NvdW'
    '50GAMgASgNUgxtYXhQYXRoQ291bnQSTQokbWF4X2NoYW5uZWxfc2F0dXJhdGlvbl9wb3dlcl9v'
    'Zl9oYWxmGAQgASgNUh9tYXhDaGFubmVsU2F0dXJhdGlvblBvd2VyT2ZIYWxmQh0KG19tYXhfdG'
    '90YWxfcm91dGluZ19mZWVfbXNhdA==');

@$core.Deprecated('Use graphRoutingFeesDescriptor instead')
const GraphRoutingFees$json = {
  '1': 'GraphRoutingFees',
  '2': [
    {'1': 'base_msat', '3': 1, '4': 1, '5': 13, '10': 'baseMsat'},
    {'1': 'proportional_millionths', '3': 2, '4': 1, '5': 13, '10': 'proportionalMillionths'},
  ],
};

/// Descriptor for `GraphRoutingFees`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphRoutingFeesDescriptor = $convert.base64Decode(
    'ChBHcmFwaFJvdXRpbmdGZWVzEhsKCWJhc2VfbXNhdBgBIAEoDVIIYmFzZU1zYXQSNwoXcHJvcG'
    '9ydGlvbmFsX21pbGxpb250aHMYAiABKA1SFnByb3BvcnRpb25hbE1pbGxpb250aHM=');

@$core.Deprecated('Use graphChannelUpdateDescriptor instead')
const GraphChannelUpdate$json = {
  '1': 'GraphChannelUpdate',
  '2': [
    {'1': 'last_update', '3': 1, '4': 1, '5': 13, '10': 'lastUpdate'},
    {'1': 'enabled', '3': 2, '4': 1, '5': 8, '10': 'enabled'},
    {'1': 'cltv_expiry_delta', '3': 3, '4': 1, '5': 13, '10': 'cltvExpiryDelta'},
    {'1': 'htlc_minimum_msat', '3': 4, '4': 1, '5': 4, '10': 'htlcMinimumMsat'},
    {'1': 'htlc_maximum_msat', '3': 5, '4': 1, '5': 4, '10': 'htlcMaximumMsat'},
    {'1': 'fees', '3': 6, '4': 1, '5': 11, '6': '.types.GraphRoutingFees', '10': 'fees'},
  ],
};

/// Descriptor for `GraphChannelUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphChannelUpdateDescriptor = $convert.base64Decode(
    'ChJHcmFwaENoYW5uZWxVcGRhdGUSHwoLbGFzdF91cGRhdGUYASABKA1SCmxhc3RVcGRhdGUSGA'
    'oHZW5hYmxlZBgCIAEoCFIHZW5hYmxlZBIqChFjbHR2X2V4cGlyeV9kZWx0YRgDIAEoDVIPY2x0'
    'dkV4cGlyeURlbHRhEioKEWh0bGNfbWluaW11bV9tc2F0GAQgASgEUg9odGxjTWluaW11bU1zYX'
    'QSKgoRaHRsY19tYXhpbXVtX21zYXQYBSABKARSD2h0bGNNYXhpbXVtTXNhdBIrCgRmZWVzGAYg'
    'ASgLMhcudHlwZXMuR3JhcGhSb3V0aW5nRmVlc1IEZmVlcw==');

@$core.Deprecated('Use graphChannelDescriptor instead')
const GraphChannel$json = {
  '1': 'GraphChannel',
  '2': [
    {'1': 'node_one', '3': 1, '4': 1, '5': 9, '10': 'nodeOne'},
    {'1': 'node_two', '3': 2, '4': 1, '5': 9, '10': 'nodeTwo'},
    {'1': 'capacity_sats', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'capacitySats', '17': true},
    {'1': 'one_to_two', '3': 4, '4': 1, '5': 11, '6': '.types.GraphChannelUpdate', '10': 'oneToTwo'},
    {'1': 'two_to_one', '3': 5, '4': 1, '5': 11, '6': '.types.GraphChannelUpdate', '10': 'twoToOne'},
  ],
  '8': [
    {'1': '_capacity_sats'},
  ],
};

/// Descriptor for `GraphChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphChannelDescriptor = $convert.base64Decode(
    'CgxHcmFwaENoYW5uZWwSGQoIbm9kZV9vbmUYASABKAlSB25vZGVPbmUSGQoIbm9kZV90d28YAi'
    'ABKAlSB25vZGVUd28SKAoNY2FwYWNpdHlfc2F0cxgDIAEoBEgAUgxjYXBhY2l0eVNhdHOIAQES'
    'NwoKb25lX3RvX3R3bxgEIAEoCzIZLnR5cGVzLkdyYXBoQ2hhbm5lbFVwZGF0ZVIIb25lVG9Ud2'
    '8SNwoKdHdvX3RvX29uZRgFIAEoCzIZLnR5cGVzLkdyYXBoQ2hhbm5lbFVwZGF0ZVIIdHdvVG9P'
    'bmVCEAoOX2NhcGFjaXR5X3NhdHM=');

@$core.Deprecated('Use graphNodeAnnouncementDescriptor instead')
const GraphNodeAnnouncement$json = {
  '1': 'GraphNodeAnnouncement',
  '2': [
    {'1': 'last_update', '3': 1, '4': 1, '5': 13, '10': 'lastUpdate'},
    {'1': 'alias', '3': 2, '4': 1, '5': 9, '10': 'alias'},
    {'1': 'rgb', '3': 3, '4': 1, '5': 9, '10': 'rgb'},
    {'1': 'addresses', '3': 4, '4': 3, '5': 9, '10': 'addresses'},
    {'1': 'features', '3': 5, '4': 3, '5': 11, '6': '.types.GraphNodeAnnouncement.FeaturesEntry', '10': 'features'},
  ],
  '3': [GraphNodeAnnouncement_FeaturesEntry$json],
};

@$core.Deprecated('Use graphNodeAnnouncementDescriptor instead')
const GraphNodeAnnouncement_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.types.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GraphNodeAnnouncement`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphNodeAnnouncementDescriptor = $convert.base64Decode(
    'ChVHcmFwaE5vZGVBbm5vdW5jZW1lbnQSHwoLbGFzdF91cGRhdGUYASABKA1SCmxhc3RVcGRhdG'
    'USFAoFYWxpYXMYAiABKAlSBWFsaWFzEhAKA3JnYhgDIAEoCVIDcmdiEhwKCWFkZHJlc3NlcxgE'
    'IAMoCVIJYWRkcmVzc2VzEkYKCGZlYXR1cmVzGAUgAygLMioudHlwZXMuR3JhcGhOb2RlQW5ub3'
    'VuY2VtZW50LkZlYXR1cmVzRW50cnlSCGZlYXR1cmVzGksKDUZlYXR1cmVzRW50cnkSEAoDa2V5'
    'GAEgASgNUgNrZXkSJAoFdmFsdWUYAiABKAsyDi50eXBlcy5GZWF0dXJlUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use peerDescriptor instead')
const Peer$json = {
  '1': 'Peer',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '10': 'nodeId'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'is_persisted', '3': 3, '4': 1, '5': 8, '10': 'isPersisted'},
    {'1': 'is_connected', '3': 4, '4': 1, '5': 8, '10': 'isConnected'},
  ],
};

/// Descriptor for `Peer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerDescriptor = $convert.base64Decode(
    'CgRQZWVyEhcKB25vZGVfaWQYASABKAlSBm5vZGVJZBIYCgdhZGRyZXNzGAIgASgJUgdhZGRyZX'
    'NzEiEKDGlzX3BlcnNpc3RlZBgDIAEoCFILaXNQZXJzaXN0ZWQSIQoMaXNfY29ubmVjdGVkGAQg'
    'ASgIUgtpc0Nvbm5lY3RlZA==');

@$core.Deprecated('Use graphNodeDescriptor instead')
const GraphNode$json = {
  '1': 'GraphNode',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 4, '10': 'channels'},
    {'1': 'announcement_info', '3': 2, '4': 1, '5': 11, '6': '.types.GraphNodeAnnouncement', '10': 'announcementInfo'},
  ],
};

/// Descriptor for `GraphNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphNodeDescriptor = $convert.base64Decode(
    'CglHcmFwaE5vZGUSGgoIY2hhbm5lbHMYASADKARSCGNoYW5uZWxzEkkKEWFubm91bmNlbWVudF'
    '9pbmZvGAIgASgLMhwudHlwZXMuR3JhcGhOb2RlQW5ub3VuY2VtZW50UhBhbm5vdW5jZW1lbnRJ'
    'bmZv');

@$core.Deprecated('Use bolt11RouteHintDescriptor instead')
const Bolt11RouteHint$json = {
  '1': 'Bolt11RouteHint',
  '2': [
    {'1': 'hop_hints', '3': 1, '4': 3, '5': 11, '6': '.types.Bolt11HopHint', '10': 'hopHints'},
  ],
};

/// Descriptor for `Bolt11RouteHint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11RouteHintDescriptor = $convert.base64Decode(
    'Cg9Cb2x0MTFSb3V0ZUhpbnQSMQoJaG9wX2hpbnRzGAEgAygLMhQudHlwZXMuQm9sdDExSG9wSG'
    'ludFIIaG9wSGludHM=');

@$core.Deprecated('Use bolt11HopHintDescriptor instead')
const Bolt11HopHint$json = {
  '1': 'Bolt11HopHint',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '10': 'nodeId'},
    {'1': 'short_channel_id', '3': 2, '4': 1, '5': 4, '10': 'shortChannelId'},
    {'1': 'fee_base_msat', '3': 3, '4': 1, '5': 13, '10': 'feeBaseMsat'},
    {'1': 'fee_proportional_millionths', '3': 4, '4': 1, '5': 13, '10': 'feeProportionalMillionths'},
    {'1': 'cltv_expiry_delta', '3': 5, '4': 1, '5': 13, '10': 'cltvExpiryDelta'},
  ],
};

/// Descriptor for `Bolt11HopHint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11HopHintDescriptor = $convert.base64Decode(
    'Cg1Cb2x0MTFIb3BIaW50EhcKB25vZGVfaWQYASABKAlSBm5vZGVJZBIoChBzaG9ydF9jaGFubm'
    'VsX2lkGAIgASgEUg5zaG9ydENoYW5uZWxJZBIiCg1mZWVfYmFzZV9tc2F0GAMgASgNUgtmZWVC'
    'YXNlTXNhdBI+ChtmZWVfcHJvcG9ydGlvbmFsX21pbGxpb250aHMYBCABKA1SGWZlZVByb3Bvcn'
    'Rpb25hbE1pbGxpb250aHMSKgoRY2x0dl9leHBpcnlfZGVsdGEYBSABKA1SD2NsdHZFeHBpcnlE'
    'ZWx0YQ==');

@$core.Deprecated('Use offerAmountDescriptor instead')
const OfferAmount$json = {
  '1': 'OfferAmount',
  '2': [
    {'1': 'bitcoin_amount_msats', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'bitcoinAmountMsats'},
    {'1': 'currency_amount', '3': 2, '4': 1, '5': 11, '6': '.types.CurrencyAmount', '9': 0, '10': 'currencyAmount'},
  ],
  '8': [
    {'1': 'amount'},
  ],
};

/// Descriptor for `OfferAmount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offerAmountDescriptor = $convert.base64Decode(
    'CgtPZmZlckFtb3VudBIyChRiaXRjb2luX2Ftb3VudF9tc2F0cxgBIAEoBEgAUhJiaXRjb2luQW'
    '1vdW50TXNhdHMSQAoPY3VycmVuY3lfYW1vdW50GAIgASgLMhUudHlwZXMuQ3VycmVuY3lBbW91'
    'bnRIAFIOY3VycmVuY3lBbW91bnRCCAoGYW1vdW50');

@$core.Deprecated('Use currencyAmountDescriptor instead')
const CurrencyAmount$json = {
  '1': 'CurrencyAmount',
  '2': [
    {'1': 'iso4217_code', '3': 1, '4': 1, '5': 9, '10': 'iso4217Code'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '10': 'amount'},
  ],
};

/// Descriptor for `CurrencyAmount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List currencyAmountDescriptor = $convert.base64Decode(
    'Cg5DdXJyZW5jeUFtb3VudBIhCgxpc280MjE3X2NvZGUYASABKAlSC2lzbzQyMTdDb2RlEhYKBm'
    'Ftb3VudBgCIAEoBFIGYW1vdW50');

@$core.Deprecated('Use offerQuantityDescriptor instead')
const OfferQuantity$json = {
  '1': 'OfferQuantity',
  '2': [
    {'1': 'one', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'one'},
    {'1': 'bounded', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'bounded'},
    {'1': 'unbounded', '3': 3, '4': 1, '5': 8, '9': 0, '10': 'unbounded'},
  ],
  '8': [
    {'1': 'quantity'},
  ],
};

/// Descriptor for `OfferQuantity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List offerQuantityDescriptor = $convert.base64Decode(
    'Cg1PZmZlclF1YW50aXR5EhIKA29uZRgBIAEoCEgAUgNvbmUSGgoHYm91bmRlZBgCIAEoBEgAUg'
    'dib3VuZGVkEh4KCXVuYm91bmRlZBgDIAEoCEgAUgl1bmJvdW5kZWRCCgoIcXVhbnRpdHk=');

@$core.Deprecated('Use blindedPathDescriptor instead')
const BlindedPath$json = {
  '1': 'BlindedPath',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'nodeId'},
    {'1': 'directed_scid', '3': 2, '4': 1, '5': 11, '6': '.types.DirectedShortChannelId', '9': 0, '10': 'directedScid'},
    {'1': 'blinding_point', '3': 3, '4': 1, '5': 9, '10': 'blindingPoint'},
    {'1': 'num_hops', '3': 4, '4': 1, '5': 13, '10': 'numHops'},
  ],
  '8': [
    {'1': 'introduction_node'},
  ],
};

/// Descriptor for `BlindedPath`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedPathDescriptor = $convert.base64Decode(
    'CgtCbGluZGVkUGF0aBIZCgdub2RlX2lkGAEgASgJSABSBm5vZGVJZBJECg1kaXJlY3RlZF9zY2'
    'lkGAIgASgLMh0udHlwZXMuRGlyZWN0ZWRTaG9ydENoYW5uZWxJZEgAUgxkaXJlY3RlZFNjaWQS'
    'JQoOYmxpbmRpbmdfcG9pbnQYAyABKAlSDWJsaW5kaW5nUG9pbnQSGQoIbnVtX2hvcHMYBCABKA'
    '1SB251bUhvcHNCEwoRaW50cm9kdWN0aW9uX25vZGU=');

@$core.Deprecated('Use directedShortChannelIdDescriptor instead')
const DirectedShortChannelId$json = {
  '1': 'DirectedShortChannelId',
  '2': [
    {'1': 'scid', '3': 1, '4': 1, '5': 4, '10': 'scid'},
    {'1': 'direction', '3': 2, '4': 1, '5': 14, '6': '.types.ChannelDirection', '10': 'direction'},
  ],
};

/// Descriptor for `DirectedShortChannelId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directedShortChannelIdDescriptor = $convert.base64Decode(
    'ChZEaXJlY3RlZFNob3J0Q2hhbm5lbElkEhIKBHNjaWQYASABKARSBHNjaWQSNQoJZGlyZWN0aW'
    '9uGAIgASgOMhcudHlwZXMuQ2hhbm5lbERpcmVjdGlvblIJZGlyZWN0aW9u');

@$core.Deprecated('Use featureDescriptor instead')
const Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    {'1': 'is_required', '3': 2, '4': 1, '5': 8, '10': 'isRequired'},
  ],
};

/// Descriptor for `Feature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List featureDescriptor = $convert.base64Decode(
    'CgdGZWF0dXJlEhIKBG5hbWUYASABKAlSBG5hbWUSHwoLaXNfcmVxdWlyZWQYAiABKAhSCmlzUm'
    'VxdWlyZWQ=');

@$core.Deprecated('Use customTlvRecordDescriptor instead')
const CustomTlvRecord$json = {
  '1': 'CustomTlvRecord',
  '2': [
    {'1': 'type_num', '3': 1, '4': 1, '5': 4, '10': 'typeNum'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
};

/// Descriptor for `CustomTlvRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customTlvRecordDescriptor = $convert.base64Decode(
    'Cg9DdXN0b21UbHZSZWNvcmQSGQoIdHlwZV9udW0YASABKARSB3R5cGVOdW0SFAoFdmFsdWUYAi'
    'ABKAxSBXZhbHVl');

