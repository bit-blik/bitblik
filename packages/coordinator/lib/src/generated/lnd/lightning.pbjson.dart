//
//  Generated code. Do not modify.
//  source: lnd/lightning.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use outputScriptTypeDescriptor instead')
const OutputScriptType$json = {
  '1': 'OutputScriptType',
  '2': [
    {'1': 'SCRIPT_TYPE_PUBKEY_HASH', '2': 0},
    {'1': 'SCRIPT_TYPE_SCRIPT_HASH', '2': 1},
    {'1': 'SCRIPT_TYPE_WITNESS_V0_PUBKEY_HASH', '2': 2},
    {'1': 'SCRIPT_TYPE_WITNESS_V0_SCRIPT_HASH', '2': 3},
    {'1': 'SCRIPT_TYPE_PUBKEY', '2': 4},
    {'1': 'SCRIPT_TYPE_MULTISIG', '2': 5},
    {'1': 'SCRIPT_TYPE_NULLDATA', '2': 6},
    {'1': 'SCRIPT_TYPE_NON_STANDARD', '2': 7},
    {'1': 'SCRIPT_TYPE_WITNESS_UNKNOWN', '2': 8},
    {'1': 'SCRIPT_TYPE_WITNESS_V1_TAPROOT', '2': 9},
  ],
};

/// Descriptor for `OutputScriptType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List outputScriptTypeDescriptor = $convert.base64Decode(
    'ChBPdXRwdXRTY3JpcHRUeXBlEhsKF1NDUklQVF9UWVBFX1BVQktFWV9IQVNIEAASGwoXU0NSSV'
    'BUX1RZUEVfU0NSSVBUX0hBU0gQARImCiJTQ1JJUFRfVFlQRV9XSVRORVNTX1YwX1BVQktFWV9I'
    'QVNIEAISJgoiU0NSSVBUX1RZUEVfV0lUTkVTU19WMF9TQ1JJUFRfSEFTSBADEhYKElNDUklQVF'
    '9UWVBFX1BVQktFWRAEEhgKFFNDUklQVF9UWVBFX01VTFRJU0lHEAUSGAoUU0NSSVBUX1RZUEVf'
    'TlVMTERBVEEQBhIcChhTQ1JJUFRfVFlQRV9OT05fU1RBTkRBUkQQBxIfChtTQ1JJUFRfVFlQRV'
    '9XSVRORVNTX1VOS05PV04QCBIiCh5TQ1JJUFRfVFlQRV9XSVRORVNTX1YxX1RBUFJPT1QQCQ==');

@$core.Deprecated('Use coinSelectionStrategyDescriptor instead')
const CoinSelectionStrategy$json = {
  '1': 'CoinSelectionStrategy',
  '2': [
    {'1': 'STRATEGY_USE_GLOBAL_CONFIG', '2': 0},
    {'1': 'STRATEGY_LARGEST', '2': 1},
    {'1': 'STRATEGY_RANDOM', '2': 2},
  ],
};

/// Descriptor for `CoinSelectionStrategy`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List coinSelectionStrategyDescriptor = $convert.base64Decode(
    'ChVDb2luU2VsZWN0aW9uU3RyYXRlZ3kSHgoaU1RSQVRFR1lfVVNFX0dMT0JBTF9DT05GSUcQAB'
    'IUChBTVFJBVEVHWV9MQVJHRVNUEAESEwoPU1RSQVRFR1lfUkFORE9NEAI=');

@$core.Deprecated('Use addressTypeDescriptor instead')
const AddressType$json = {
  '1': 'AddressType',
  '2': [
    {'1': 'WITNESS_PUBKEY_HASH', '2': 0},
    {'1': 'NESTED_PUBKEY_HASH', '2': 1},
    {'1': 'UNUSED_WITNESS_PUBKEY_HASH', '2': 2},
    {'1': 'UNUSED_NESTED_PUBKEY_HASH', '2': 3},
    {'1': 'TAPROOT_PUBKEY', '2': 4},
    {'1': 'UNUSED_TAPROOT_PUBKEY', '2': 5},
  ],
};

/// Descriptor for `AddressType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List addressTypeDescriptor = $convert.base64Decode(
    'CgtBZGRyZXNzVHlwZRIXChNXSVRORVNTX1BVQktFWV9IQVNIEAASFgoSTkVTVEVEX1BVQktFWV'
    '9IQVNIEAESHgoaVU5VU0VEX1dJVE5FU1NfUFVCS0VZX0hBU0gQAhIdChlVTlVTRURfTkVTVEVE'
    'X1BVQktFWV9IQVNIEAMSEgoOVEFQUk9PVF9QVUJLRVkQBBIZChVVTlVTRURfVEFQUk9PVF9QVU'
    'JLRVkQBQ==');

@$core.Deprecated('Use commitmentTypeDescriptor instead')
const CommitmentType$json = {
  '1': 'CommitmentType',
  '2': [
    {'1': 'UNKNOWN_COMMITMENT_TYPE', '2': 0},
    {'1': 'LEGACY', '2': 1},
    {'1': 'STATIC_REMOTE_KEY', '2': 2},
    {'1': 'ANCHORS', '2': 3},
    {'1': 'SCRIPT_ENFORCED_LEASE', '2': 4},
    {'1': 'SIMPLE_TAPROOT', '2': 5},
    {'1': 'SIMPLE_TAPROOT_OVERLAY', '2': 6},
  ],
};

/// Descriptor for `CommitmentType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List commitmentTypeDescriptor = $convert.base64Decode(
    'Cg5Db21taXRtZW50VHlwZRIbChdVTktOT1dOX0NPTU1JVE1FTlRfVFlQRRAAEgoKBkxFR0FDWR'
    'ABEhUKEVNUQVRJQ19SRU1PVEVfS0VZEAISCwoHQU5DSE9SUxADEhkKFVNDUklQVF9FTkZPUkNF'
    'RF9MRUFTRRAEEhIKDlNJTVBMRV9UQVBST09UEAUSGgoWU0lNUExFX1RBUFJPT1RfT1ZFUkxBWR'
    'AG');

@$core.Deprecated('Use initiatorDescriptor instead')
const Initiator$json = {
  '1': 'Initiator',
  '2': [
    {'1': 'INITIATOR_UNKNOWN', '2': 0},
    {'1': 'INITIATOR_LOCAL', '2': 1},
    {'1': 'INITIATOR_REMOTE', '2': 2},
    {'1': 'INITIATOR_BOTH', '2': 3},
  ],
};

/// Descriptor for `Initiator`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List initiatorDescriptor = $convert.base64Decode(
    'CglJbml0aWF0b3ISFQoRSU5JVElBVE9SX1VOS05PV04QABITCg9JTklUSUFUT1JfTE9DQUwQAR'
    'IUChBJTklUSUFUT1JfUkVNT1RFEAISEgoOSU5JVElBVE9SX0JPVEgQAw==');

@$core.Deprecated('Use resolutionTypeDescriptor instead')
const ResolutionType$json = {
  '1': 'ResolutionType',
  '2': [
    {'1': 'TYPE_UNKNOWN', '2': 0},
    {'1': 'ANCHOR', '2': 1},
    {'1': 'INCOMING_HTLC', '2': 2},
    {'1': 'OUTGOING_HTLC', '2': 3},
    {'1': 'COMMIT', '2': 4},
  ],
};

/// Descriptor for `ResolutionType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List resolutionTypeDescriptor = $convert.base64Decode(
    'Cg5SZXNvbHV0aW9uVHlwZRIQCgxUWVBFX1VOS05PV04QABIKCgZBTkNIT1IQARIRCg1JTkNPTU'
    'lOR19IVExDEAISEQoNT1VUR09JTkdfSFRMQxADEgoKBkNPTU1JVBAE');

@$core.Deprecated('Use resolutionOutcomeDescriptor instead')
const ResolutionOutcome$json = {
  '1': 'ResolutionOutcome',
  '2': [
    {'1': 'OUTCOME_UNKNOWN', '2': 0},
    {'1': 'CLAIMED', '2': 1},
    {'1': 'UNCLAIMED', '2': 2},
    {'1': 'ABANDONED', '2': 3},
    {'1': 'FIRST_STAGE', '2': 4},
    {'1': 'TIMEOUT', '2': 5},
  ],
};

/// Descriptor for `ResolutionOutcome`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List resolutionOutcomeDescriptor = $convert.base64Decode(
    'ChFSZXNvbHV0aW9uT3V0Y29tZRITCg9PVVRDT01FX1VOS05PV04QABILCgdDTEFJTUVEEAESDQ'
    'oJVU5DTEFJTUVEEAISDQoJQUJBTkRPTkVEEAMSDwoLRklSU1RfU1RBR0UQBBILCgdUSU1FT1VU'
    'EAU=');

@$core.Deprecated('Use nodeMetricTypeDescriptor instead')
const NodeMetricType$json = {
  '1': 'NodeMetricType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'BETWEENNESS_CENTRALITY', '2': 1},
  ],
};

/// Descriptor for `NodeMetricType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List nodeMetricTypeDescriptor = $convert.base64Decode(
    'Cg5Ob2RlTWV0cmljVHlwZRILCgdVTktOT1dOEAASGgoWQkVUV0VFTk5FU1NfQ0VOVFJBTElUWR'
    'AB');

@$core.Deprecated('Use invoiceHTLCStateDescriptor instead')
const InvoiceHTLCState$json = {
  '1': 'InvoiceHTLCState',
  '2': [
    {'1': 'ACCEPTED', '2': 0},
    {'1': 'SETTLED', '2': 1},
    {'1': 'CANCELED', '2': 2},
  ],
};

/// Descriptor for `InvoiceHTLCState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List invoiceHTLCStateDescriptor = $convert.base64Decode(
    'ChBJbnZvaWNlSFRMQ1N0YXRlEgwKCEFDQ0VQVEVEEAASCwoHU0VUVExFRBABEgwKCENBTkNFTE'
    'VEEAI=');

@$core.Deprecated('Use paymentFailureReasonDescriptor instead')
const PaymentFailureReason$json = {
  '1': 'PaymentFailureReason',
  '2': [
    {'1': 'FAILURE_REASON_NONE', '2': 0},
    {'1': 'FAILURE_REASON_TIMEOUT', '2': 1},
    {'1': 'FAILURE_REASON_NO_ROUTE', '2': 2},
    {'1': 'FAILURE_REASON_ERROR', '2': 3},
    {'1': 'FAILURE_REASON_INCORRECT_PAYMENT_DETAILS', '2': 4},
    {'1': 'FAILURE_REASON_INSUFFICIENT_BALANCE', '2': 5},
    {'1': 'FAILURE_REASON_CANCELED', '2': 6},
  ],
};

/// Descriptor for `PaymentFailureReason`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentFailureReasonDescriptor = $convert.base64Decode(
    'ChRQYXltZW50RmFpbHVyZVJlYXNvbhIXChNGQUlMVVJFX1JFQVNPTl9OT05FEAASGgoWRkFJTF'
    'VSRV9SRUFTT05fVElNRU9VVBABEhsKF0ZBSUxVUkVfUkVBU09OX05PX1JPVVRFEAISGAoURkFJ'
    'TFVSRV9SRUFTT05fRVJST1IQAxIsCihGQUlMVVJFX1JFQVNPTl9JTkNPUlJFQ1RfUEFZTUVOVF'
    '9ERVRBSUxTEAQSJwojRkFJTFVSRV9SRUFTT05fSU5TVUZGSUNJRU5UX0JBTEFOQ0UQBRIbChdG'
    'QUlMVVJFX1JFQVNPTl9DQU5DRUxFRBAG');

@$core.Deprecated('Use featureBitDescriptor instead')
const FeatureBit$json = {
  '1': 'FeatureBit',
  '2': [
    {'1': 'DATALOSS_PROTECT_REQ', '2': 0},
    {'1': 'DATALOSS_PROTECT_OPT', '2': 1},
    {'1': 'INITIAL_ROUING_SYNC', '2': 3},
    {'1': 'UPFRONT_SHUTDOWN_SCRIPT_REQ', '2': 4},
    {'1': 'UPFRONT_SHUTDOWN_SCRIPT_OPT', '2': 5},
    {'1': 'GOSSIP_QUERIES_REQ', '2': 6},
    {'1': 'GOSSIP_QUERIES_OPT', '2': 7},
    {'1': 'TLV_ONION_REQ', '2': 8},
    {'1': 'TLV_ONION_OPT', '2': 9},
    {'1': 'EXT_GOSSIP_QUERIES_REQ', '2': 10},
    {'1': 'EXT_GOSSIP_QUERIES_OPT', '2': 11},
    {'1': 'STATIC_REMOTE_KEY_REQ', '2': 12},
    {'1': 'STATIC_REMOTE_KEY_OPT', '2': 13},
    {'1': 'PAYMENT_ADDR_REQ', '2': 14},
    {'1': 'PAYMENT_ADDR_OPT', '2': 15},
    {'1': 'MPP_REQ', '2': 16},
    {'1': 'MPP_OPT', '2': 17},
    {'1': 'WUMBO_CHANNELS_REQ', '2': 18},
    {'1': 'WUMBO_CHANNELS_OPT', '2': 19},
    {'1': 'ANCHORS_REQ', '2': 20},
    {'1': 'ANCHORS_OPT', '2': 21},
    {'1': 'ANCHORS_ZERO_FEE_HTLC_REQ', '2': 22},
    {'1': 'ANCHORS_ZERO_FEE_HTLC_OPT', '2': 23},
    {'1': 'ROUTE_BLINDING_REQUIRED', '2': 24},
    {'1': 'ROUTE_BLINDING_OPTIONAL', '2': 25},
    {'1': 'AMP_REQ', '2': 30},
    {'1': 'AMP_OPT', '2': 31},
  ],
};

/// Descriptor for `FeatureBit`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List featureBitDescriptor = $convert.base64Decode(
    'CgpGZWF0dXJlQml0EhgKFERBVEFMT1NTX1BST1RFQ1RfUkVREAASGAoUREFUQUxPU1NfUFJPVE'
    'VDVF9PUFQQARIXChNJTklUSUFMX1JPVUlOR19TWU5DEAMSHwobVVBGUk9OVF9TSFVURE9XTl9T'
    'Q1JJUFRfUkVREAQSHwobVVBGUk9OVF9TSFVURE9XTl9TQ1JJUFRfT1BUEAUSFgoSR09TU0lQX1'
    'FVRVJJRVNfUkVREAYSFgoSR09TU0lQX1FVRVJJRVNfT1BUEAcSEQoNVExWX09OSU9OX1JFURAI'
    'EhEKDVRMVl9PTklPTl9PUFQQCRIaChZFWFRfR09TU0lQX1FVRVJJRVNfUkVREAoSGgoWRVhUX0'
    'dPU1NJUF9RVUVSSUVTX09QVBALEhkKFVNUQVRJQ19SRU1PVEVfS0VZX1JFURAMEhkKFVNUQVRJ'
    'Q19SRU1PVEVfS0VZX09QVBANEhQKEFBBWU1FTlRfQUREUl9SRVEQDhIUChBQQVlNRU5UX0FERF'
    'JfT1BUEA8SCwoHTVBQX1JFURAQEgsKB01QUF9PUFQQERIWChJXVU1CT19DSEFOTkVMU19SRVEQ'
    'EhIWChJXVU1CT19DSEFOTkVMU19PUFQQExIPCgtBTkNIT1JTX1JFURAUEg8KC0FOQ0hPUlNfT1'
    'BUEBUSHQoZQU5DSE9SU19aRVJPX0ZFRV9IVExDX1JFURAWEh0KGUFOQ0hPUlNfWkVST19GRUVf'
    'SFRMQ19PUFQQFxIbChdST1VURV9CTElORElOR19SRVFVSVJFRBAYEhsKF1JPVVRFX0JMSU5ESU'
    '5HX09QVElPTkFMEBkSCwoHQU1QX1JFURAeEgsKB0FNUF9PUFQQHw==');

@$core.Deprecated('Use updateFailureDescriptor instead')
const UpdateFailure$json = {
  '1': 'UpdateFailure',
  '2': [
    {'1': 'UPDATE_FAILURE_UNKNOWN', '2': 0},
    {'1': 'UPDATE_FAILURE_PENDING', '2': 1},
    {'1': 'UPDATE_FAILURE_NOT_FOUND', '2': 2},
    {'1': 'UPDATE_FAILURE_INTERNAL_ERR', '2': 3},
    {'1': 'UPDATE_FAILURE_INVALID_PARAMETER', '2': 4},
  ],
};

/// Descriptor for `UpdateFailure`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List updateFailureDescriptor = $convert.base64Decode(
    'Cg1VcGRhdGVGYWlsdXJlEhoKFlVQREFURV9GQUlMVVJFX1VOS05PV04QABIaChZVUERBVEVfRk'
    'FJTFVSRV9QRU5ESU5HEAESHAoYVVBEQVRFX0ZBSUxVUkVfTk9UX0ZPVU5EEAISHwobVVBEQVRF'
    'X0ZBSUxVUkVfSU5URVJOQUxfRVJSEAMSJAogVVBEQVRFX0ZBSUxVUkVfSU5WQUxJRF9QQVJBTU'
    'VURVIQBA==');

@$core.Deprecated('Use lookupHtlcResolutionRequestDescriptor instead')
const LookupHtlcResolutionRequest$json = {
  '1': 'LookupHtlcResolutionRequest',
  '2': [
    {'1': 'chan_id', '3': 1, '4': 1, '5': 4, '10': 'chanId'},
    {'1': 'htlc_index', '3': 2, '4': 1, '5': 4, '10': 'htlcIndex'},
  ],
};

/// Descriptor for `LookupHtlcResolutionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupHtlcResolutionRequestDescriptor = $convert.base64Decode(
    'ChtMb29rdXBIdGxjUmVzb2x1dGlvblJlcXVlc3QSFwoHY2hhbl9pZBgBIAEoBFIGY2hhbklkEh'
    '0KCmh0bGNfaW5kZXgYAiABKARSCWh0bGNJbmRleA==');

@$core.Deprecated('Use lookupHtlcResolutionResponseDescriptor instead')
const LookupHtlcResolutionResponse$json = {
  '1': 'LookupHtlcResolutionResponse',
  '2': [
    {'1': 'settled', '3': 1, '4': 1, '5': 8, '10': 'settled'},
    {'1': 'offchain', '3': 2, '4': 1, '5': 8, '10': 'offchain'},
  ],
};

/// Descriptor for `LookupHtlcResolutionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupHtlcResolutionResponseDescriptor = $convert.base64Decode(
    'ChxMb29rdXBIdGxjUmVzb2x1dGlvblJlc3BvbnNlEhgKB3NldHRsZWQYASABKAhSB3NldHRsZW'
    'QSGgoIb2ZmY2hhaW4YAiABKAhSCG9mZmNoYWlu');

@$core.Deprecated('Use subscribeCustomMessagesRequestDescriptor instead')
const SubscribeCustomMessagesRequest$json = {
  '1': 'SubscribeCustomMessagesRequest',
};

/// Descriptor for `SubscribeCustomMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeCustomMessagesRequestDescriptor = $convert.base64Decode(
    'Ch5TdWJzY3JpYmVDdXN0b21NZXNzYWdlc1JlcXVlc3Q=');

@$core.Deprecated('Use customMessageDescriptor instead')
const CustomMessage$json = {
  '1': 'CustomMessage',
  '2': [
    {'1': 'peer', '3': 1, '4': 1, '5': 12, '10': 'peer'},
    {'1': 'type', '3': 2, '4': 1, '5': 13, '10': 'type'},
    {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `CustomMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List customMessageDescriptor = $convert.base64Decode(
    'Cg1DdXN0b21NZXNzYWdlEhIKBHBlZXIYASABKAxSBHBlZXISEgoEdHlwZRgCIAEoDVIEdHlwZR'
    'ISCgRkYXRhGAMgASgMUgRkYXRh');

@$core.Deprecated('Use sendCustomMessageRequestDescriptor instead')
const SendCustomMessageRequest$json = {
  '1': 'SendCustomMessageRequest',
  '2': [
    {'1': 'peer', '3': 1, '4': 1, '5': 12, '10': 'peer'},
    {'1': 'type', '3': 2, '4': 1, '5': 13, '10': 'type'},
    {'1': 'data', '3': 3, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `SendCustomMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCustomMessageRequestDescriptor = $convert.base64Decode(
    'ChhTZW5kQ3VzdG9tTWVzc2FnZVJlcXVlc3QSEgoEcGVlchgBIAEoDFIEcGVlchISCgR0eXBlGA'
    'IgASgNUgR0eXBlEhIKBGRhdGEYAyABKAxSBGRhdGE=');

@$core.Deprecated('Use sendCustomMessageResponseDescriptor instead')
const SendCustomMessageResponse$json = {
  '1': 'SendCustomMessageResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `SendCustomMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCustomMessageResponseDescriptor = $convert.base64Decode(
    'ChlTZW5kQ3VzdG9tTWVzc2FnZVJlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use utxoDescriptor instead')
const Utxo$json = {
  '1': 'Utxo',
  '2': [
    {'1': 'address_type', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.AddressType', '10': 'addressType'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'amount_sat', '3': 3, '4': 1, '5': 3, '10': 'amountSat'},
    {'1': 'pk_script', '3': 4, '4': 1, '5': 9, '10': 'pkScript'},
    {'1': 'outpoint', '3': 5, '4': 1, '5': 11, '6': '.lnrpc.OutPoint', '10': 'outpoint'},
    {'1': 'confirmations', '3': 6, '4': 1, '5': 3, '10': 'confirmations'},
  ],
};

/// Descriptor for `Utxo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List utxoDescriptor = $convert.base64Decode(
    'CgRVdHhvEjUKDGFkZHJlc3NfdHlwZRgBIAEoDjISLmxucnBjLkFkZHJlc3NUeXBlUgthZGRyZX'
    'NzVHlwZRIYCgdhZGRyZXNzGAIgASgJUgdhZGRyZXNzEh0KCmFtb3VudF9zYXQYAyABKANSCWFt'
    'b3VudFNhdBIbCglwa19zY3JpcHQYBCABKAlSCHBrU2NyaXB0EisKCG91dHBvaW50GAUgASgLMg'
    '8ubG5ycGMuT3V0UG9pbnRSCG91dHBvaW50EiQKDWNvbmZpcm1hdGlvbnMYBiABKANSDWNvbmZp'
    'cm1hdGlvbnM=');

@$core.Deprecated('Use outputDetailDescriptor instead')
const OutputDetail$json = {
  '1': 'OutputDetail',
  '2': [
    {'1': 'output_type', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.OutputScriptType', '10': 'outputType'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'pk_script', '3': 3, '4': 1, '5': 9, '10': 'pkScript'},
    {'1': 'output_index', '3': 4, '4': 1, '5': 3, '10': 'outputIndex'},
    {'1': 'amount', '3': 5, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'is_our_address', '3': 6, '4': 1, '5': 8, '10': 'isOurAddress'},
  ],
};

/// Descriptor for `OutputDetail`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outputDetailDescriptor = $convert.base64Decode(
    'CgxPdXRwdXREZXRhaWwSOAoLb3V0cHV0X3R5cGUYASABKA4yFy5sbnJwYy5PdXRwdXRTY3JpcH'
    'RUeXBlUgpvdXRwdXRUeXBlEhgKB2FkZHJlc3MYAiABKAlSB2FkZHJlc3MSGwoJcGtfc2NyaXB0'
    'GAMgASgJUghwa1NjcmlwdBIhCgxvdXRwdXRfaW5kZXgYBCABKANSC291dHB1dEluZGV4EhYKBm'
    'Ftb3VudBgFIAEoA1IGYW1vdW50EiQKDmlzX291cl9hZGRyZXNzGAYgASgIUgxpc091ckFkZHJl'
    'c3M=');

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
  '2': [
    {'1': 'tx_hash', '3': 1, '4': 1, '5': 9, '10': 'txHash'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'num_confirmations', '3': 3, '4': 1, '5': 5, '10': 'numConfirmations'},
    {'1': 'block_hash', '3': 4, '4': 1, '5': 9, '10': 'blockHash'},
    {'1': 'block_height', '3': 5, '4': 1, '5': 5, '10': 'blockHeight'},
    {'1': 'time_stamp', '3': 6, '4': 1, '5': 3, '10': 'timeStamp'},
    {'1': 'total_fees', '3': 7, '4': 1, '5': 3, '10': 'totalFees'},
    {
      '1': 'dest_addresses',
      '3': 8,
      '4': 3,
      '5': 9,
      '8': {'3': true},
      '10': 'destAddresses',
    },
    {'1': 'output_details', '3': 11, '4': 3, '5': 11, '6': '.lnrpc.OutputDetail', '10': 'outputDetails'},
    {'1': 'raw_tx_hex', '3': 9, '4': 1, '5': 9, '10': 'rawTxHex'},
    {'1': 'label', '3': 10, '4': 1, '5': 9, '10': 'label'},
    {'1': 'previous_outpoints', '3': 12, '4': 3, '5': 11, '6': '.lnrpc.PreviousOutPoint', '10': 'previousOutpoints'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhIXCgd0eF9oYXNoGAEgASgJUgZ0eEhhc2gSFgoGYW1vdW50GAIgASgDUg'
    'ZhbW91bnQSKwoRbnVtX2NvbmZpcm1hdGlvbnMYAyABKAVSEG51bUNvbmZpcm1hdGlvbnMSHQoK'
    'YmxvY2tfaGFzaBgEIAEoCVIJYmxvY2tIYXNoEiEKDGJsb2NrX2hlaWdodBgFIAEoBVILYmxvY2'
    'tIZWlnaHQSHQoKdGltZV9zdGFtcBgGIAEoA1IJdGltZVN0YW1wEh0KCnRvdGFsX2ZlZXMYByAB'
    'KANSCXRvdGFsRmVlcxIpCg5kZXN0X2FkZHJlc3NlcxgIIAMoCUICGAFSDWRlc3RBZGRyZXNzZX'
    'MSOgoOb3V0cHV0X2RldGFpbHMYCyADKAsyEy5sbnJwYy5PdXRwdXREZXRhaWxSDW91dHB1dERl'
    'dGFpbHMSHAoKcmF3X3R4X2hleBgJIAEoCVIIcmF3VHhIZXgSFAoFbGFiZWwYCiABKAlSBWxhYm'
    'VsEkYKEnByZXZpb3VzX291dHBvaW50cxgMIAMoCzIXLmxucnBjLlByZXZpb3VzT3V0UG9pbnRS'
    'EXByZXZpb3VzT3V0cG9pbnRz');

@$core.Deprecated('Use getTransactionsRequestDescriptor instead')
const GetTransactionsRequest$json = {
  '1': 'GetTransactionsRequest',
  '2': [
    {'1': 'start_height', '3': 1, '4': 1, '5': 5, '10': 'startHeight'},
    {'1': 'end_height', '3': 2, '4': 1, '5': 5, '10': 'endHeight'},
    {'1': 'account', '3': 3, '4': 1, '5': 9, '10': 'account'},
    {'1': 'index_offset', '3': 4, '4': 1, '5': 13, '10': 'indexOffset'},
    {'1': 'max_transactions', '3': 5, '4': 1, '5': 13, '10': 'maxTransactions'},
  ],
};

/// Descriptor for `GetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionsRequestDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2FjdGlvbnNSZXF1ZXN0EiEKDHN0YXJ0X2hlaWdodBgBIAEoBVILc3RhcnRIZW'
    'lnaHQSHQoKZW5kX2hlaWdodBgCIAEoBVIJZW5kSGVpZ2h0EhgKB2FjY291bnQYAyABKAlSB2Fj'
    'Y291bnQSIQoMaW5kZXhfb2Zmc2V0GAQgASgNUgtpbmRleE9mZnNldBIpChBtYXhfdHJhbnNhY3'
    'Rpb25zGAUgASgNUg9tYXhUcmFuc2FjdGlvbnM=');

@$core.Deprecated('Use transactionDetailsDescriptor instead')
const TransactionDetails$json = {
  '1': 'TransactionDetails',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.Transaction', '10': 'transactions'},
    {'1': 'last_index', '3': 2, '4': 1, '5': 4, '10': 'lastIndex'},
    {'1': 'first_index', '3': 3, '4': 1, '5': 4, '10': 'firstIndex'},
  ],
};

/// Descriptor for `TransactionDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDetailsDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvbkRldGFpbHMSNgoMdHJhbnNhY3Rpb25zGAEgAygLMhIubG5ycGMuVHJhbn'
    'NhY3Rpb25SDHRyYW5zYWN0aW9ucxIdCgpsYXN0X2luZGV4GAIgASgEUglsYXN0SW5kZXgSHwoL'
    'Zmlyc3RfaW5kZXgYAyABKARSCmZpcnN0SW5kZXg=');

@$core.Deprecated('Use feeLimitDescriptor instead')
const FeeLimit$json = {
  '1': 'FeeLimit',
  '2': [
    {'1': 'fixed', '3': 1, '4': 1, '5': 3, '9': 0, '10': 'fixed'},
    {'1': 'fixed_msat', '3': 3, '4': 1, '5': 3, '9': 0, '10': 'fixedMsat'},
    {'1': 'percent', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'percent'},
  ],
  '8': [
    {'1': 'limit'},
  ],
};

/// Descriptor for `FeeLimit`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeLimitDescriptor = $convert.base64Decode(
    'CghGZWVMaW1pdBIWCgVmaXhlZBgBIAEoA0gAUgVmaXhlZBIfCgpmaXhlZF9tc2F0GAMgASgDSA'
    'BSCWZpeGVkTXNhdBIaCgdwZXJjZW50GAIgASgDSABSB3BlcmNlbnRCBwoFbGltaXQ=');

@$core.Deprecated('Use sendRequestDescriptor instead')
const SendRequest$json = {
  '1': 'SendRequest',
  '2': [
    {'1': 'dest', '3': 1, '4': 1, '5': 12, '10': 'dest'},
    {
      '1': 'dest_string',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'destString',
    },
    {'1': 'amt', '3': 3, '4': 1, '5': 3, '10': 'amt'},
    {'1': 'amt_msat', '3': 12, '4': 1, '5': 3, '10': 'amtMsat'},
    {'1': 'payment_hash', '3': 4, '4': 1, '5': 12, '10': 'paymentHash'},
    {
      '1': 'payment_hash_string',
      '3': 5,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'paymentHashString',
    },
    {'1': 'payment_request', '3': 6, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'final_cltv_delta', '3': 7, '4': 1, '5': 5, '10': 'finalCltvDelta'},
    {'1': 'fee_limit', '3': 8, '4': 1, '5': 11, '6': '.lnrpc.FeeLimit', '10': 'feeLimit'},
    {
      '1': 'outgoing_chan_id',
      '3': 9,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'outgoingChanId',
    },
    {'1': 'last_hop_pubkey', '3': 13, '4': 1, '5': 12, '10': 'lastHopPubkey'},
    {'1': 'cltv_limit', '3': 10, '4': 1, '5': 13, '10': 'cltvLimit'},
    {'1': 'dest_custom_records', '3': 11, '4': 3, '5': 11, '6': '.lnrpc.SendRequest.DestCustomRecordsEntry', '10': 'destCustomRecords'},
    {'1': 'allow_self_payment', '3': 14, '4': 1, '5': 8, '10': 'allowSelfPayment'},
    {'1': 'dest_features', '3': 15, '4': 3, '5': 14, '6': '.lnrpc.FeatureBit', '10': 'destFeatures'},
    {'1': 'payment_addr', '3': 16, '4': 1, '5': 12, '10': 'paymentAddr'},
  ],
  '3': [SendRequest_DestCustomRecordsEntry$json],
};

@$core.Deprecated('Use sendRequestDescriptor instead')
const SendRequest_DestCustomRecordsEntry$json = {
  '1': 'DestCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendRequestDescriptor = $convert.base64Decode(
    'CgtTZW5kUmVxdWVzdBISCgRkZXN0GAEgASgMUgRkZXN0EiMKC2Rlc3Rfc3RyaW5nGAIgASgJQg'
    'IYAVIKZGVzdFN0cmluZxIQCgNhbXQYAyABKANSA2FtdBIZCghhbXRfbXNhdBgMIAEoA1IHYW10'
    'TXNhdBIhCgxwYXltZW50X2hhc2gYBCABKAxSC3BheW1lbnRIYXNoEjIKE3BheW1lbnRfaGFzaF'
    '9zdHJpbmcYBSABKAlCAhgBUhFwYXltZW50SGFzaFN0cmluZxInCg9wYXltZW50X3JlcXVlc3QY'
    'BiABKAlSDnBheW1lbnRSZXF1ZXN0EigKEGZpbmFsX2NsdHZfZGVsdGEYByABKAVSDmZpbmFsQ2'
    'x0dkRlbHRhEiwKCWZlZV9saW1pdBgIIAEoCzIPLmxucnBjLkZlZUxpbWl0UghmZWVMaW1pdBIs'
    'ChBvdXRnb2luZ19jaGFuX2lkGAkgASgEQgIwAVIOb3V0Z29pbmdDaGFuSWQSJgoPbGFzdF9ob3'
    'BfcHVia2V5GA0gASgMUg1sYXN0SG9wUHVia2V5Eh0KCmNsdHZfbGltaXQYCiABKA1SCWNsdHZM'
    'aW1pdBJZChNkZXN0X2N1c3RvbV9yZWNvcmRzGAsgAygLMikubG5ycGMuU2VuZFJlcXVlc3QuRG'
    'VzdEN1c3RvbVJlY29yZHNFbnRyeVIRZGVzdEN1c3RvbVJlY29yZHMSLAoSYWxsb3dfc2VsZl9w'
    'YXltZW50GA4gASgIUhBhbGxvd1NlbGZQYXltZW50EjYKDWRlc3RfZmVhdHVyZXMYDyADKA4yES'
    '5sbnJwYy5GZWF0dXJlQml0UgxkZXN0RmVhdHVyZXMSIQoMcGF5bWVudF9hZGRyGBAgASgMUgtw'
    'YXltZW50QWRkchpEChZEZXN0Q3VzdG9tUmVjb3Jkc0VudHJ5EhAKA2tleRgBIAEoBFIDa2V5Eh'
    'QKBXZhbHVlGAIgASgMUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use sendResponseDescriptor instead')
const SendResponse$json = {
  '1': 'SendResponse',
  '2': [
    {'1': 'payment_error', '3': 1, '4': 1, '5': 9, '10': 'paymentError'},
    {'1': 'payment_preimage', '3': 2, '4': 1, '5': 12, '10': 'paymentPreimage'},
    {'1': 'payment_route', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.Route', '10': 'paymentRoute'},
    {'1': 'payment_hash', '3': 4, '4': 1, '5': 12, '10': 'paymentHash'},
  ],
};

/// Descriptor for `SendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendResponseDescriptor = $convert.base64Decode(
    'CgxTZW5kUmVzcG9uc2USIwoNcGF5bWVudF9lcnJvchgBIAEoCVIMcGF5bWVudEVycm9yEikKEH'
    'BheW1lbnRfcHJlaW1hZ2UYAiABKAxSD3BheW1lbnRQcmVpbWFnZRIxCg1wYXltZW50X3JvdXRl'
    'GAMgASgLMgwubG5ycGMuUm91dGVSDHBheW1lbnRSb3V0ZRIhCgxwYXltZW50X2hhc2gYBCABKA'
    'xSC3BheW1lbnRIYXNo');

@$core.Deprecated('Use sendToRouteRequestDescriptor instead')
const SendToRouteRequest$json = {
  '1': 'SendToRouteRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
    {
      '1': 'payment_hash_string',
      '3': 2,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'paymentHashString',
    },
    {'1': 'route', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.Route', '10': 'route'},
  ],
  '9': [
    {'1': 3, '2': 4},
  ],
};

/// Descriptor for `SendToRouteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendToRouteRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kVG9Sb3V0ZVJlcXVlc3QSIQoMcGF5bWVudF9oYXNoGAEgASgMUgtwYXltZW50SGFzaB'
    'IyChNwYXltZW50X2hhc2hfc3RyaW5nGAIgASgJQgIYAVIRcGF5bWVudEhhc2hTdHJpbmcSIgoF'
    'cm91dGUYBCABKAsyDC5sbnJwYy5Sb3V0ZVIFcm91dGVKBAgDEAQ=');

@$core.Deprecated('Use channelAcceptRequestDescriptor instead')
const ChannelAcceptRequest$json = {
  '1': 'ChannelAcceptRequest',
  '2': [
    {'1': 'node_pubkey', '3': 1, '4': 1, '5': 12, '10': 'nodePubkey'},
    {'1': 'chain_hash', '3': 2, '4': 1, '5': 12, '10': 'chainHash'},
    {'1': 'pending_chan_id', '3': 3, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'funding_amt', '3': 4, '4': 1, '5': 4, '10': 'fundingAmt'},
    {'1': 'push_amt', '3': 5, '4': 1, '5': 4, '10': 'pushAmt'},
    {'1': 'dust_limit', '3': 6, '4': 1, '5': 4, '10': 'dustLimit'},
    {'1': 'max_value_in_flight', '3': 7, '4': 1, '5': 4, '10': 'maxValueInFlight'},
    {'1': 'channel_reserve', '3': 8, '4': 1, '5': 4, '10': 'channelReserve'},
    {'1': 'min_htlc', '3': 9, '4': 1, '5': 4, '10': 'minHtlc'},
    {'1': 'fee_per_kw', '3': 10, '4': 1, '5': 4, '10': 'feePerKw'},
    {'1': 'csv_delay', '3': 11, '4': 1, '5': 13, '10': 'csvDelay'},
    {'1': 'max_accepted_htlcs', '3': 12, '4': 1, '5': 13, '10': 'maxAcceptedHtlcs'},
    {'1': 'channel_flags', '3': 13, '4': 1, '5': 13, '10': 'channelFlags'},
    {'1': 'commitment_type', '3': 14, '4': 1, '5': 14, '6': '.lnrpc.CommitmentType', '10': 'commitmentType'},
    {'1': 'wants_zero_conf', '3': 15, '4': 1, '5': 8, '10': 'wantsZeroConf'},
    {'1': 'wants_scid_alias', '3': 16, '4': 1, '5': 8, '10': 'wantsScidAlias'},
  ],
};

/// Descriptor for `ChannelAcceptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelAcceptRequestDescriptor = $convert.base64Decode(
    'ChRDaGFubmVsQWNjZXB0UmVxdWVzdBIfCgtub2RlX3B1YmtleRgBIAEoDFIKbm9kZVB1YmtleR'
    'IdCgpjaGFpbl9oYXNoGAIgASgMUgljaGFpbkhhc2gSJgoPcGVuZGluZ19jaGFuX2lkGAMgASgM'
    'Ug1wZW5kaW5nQ2hhbklkEh8KC2Z1bmRpbmdfYW10GAQgASgEUgpmdW5kaW5nQW10EhkKCHB1c2'
    'hfYW10GAUgASgEUgdwdXNoQW10Eh0KCmR1c3RfbGltaXQYBiABKARSCWR1c3RMaW1pdBItChNt'
    'YXhfdmFsdWVfaW5fZmxpZ2h0GAcgASgEUhBtYXhWYWx1ZUluRmxpZ2h0EicKD2NoYW5uZWxfcm'
    'VzZXJ2ZRgIIAEoBFIOY2hhbm5lbFJlc2VydmUSGQoIbWluX2h0bGMYCSABKARSB21pbkh0bGMS'
    'HAoKZmVlX3Blcl9rdxgKIAEoBFIIZmVlUGVyS3cSGwoJY3N2X2RlbGF5GAsgASgNUghjc3ZEZW'
    'xheRIsChJtYXhfYWNjZXB0ZWRfaHRsY3MYDCABKA1SEG1heEFjY2VwdGVkSHRsY3MSIwoNY2hh'
    'bm5lbF9mbGFncxgNIAEoDVIMY2hhbm5lbEZsYWdzEj4KD2NvbW1pdG1lbnRfdHlwZRgOIAEoDj'
    'IVLmxucnBjLkNvbW1pdG1lbnRUeXBlUg5jb21taXRtZW50VHlwZRImCg93YW50c196ZXJvX2Nv'
    'bmYYDyABKAhSDXdhbnRzWmVyb0NvbmYSKAoQd2FudHNfc2NpZF9hbGlhcxgQIAEoCFIOd2FudH'
    'NTY2lkQWxpYXM=');

@$core.Deprecated('Use channelAcceptResponseDescriptor instead')
const ChannelAcceptResponse$json = {
  '1': 'ChannelAcceptResponse',
  '2': [
    {'1': 'accept', '3': 1, '4': 1, '5': 8, '10': 'accept'},
    {'1': 'pending_chan_id', '3': 2, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
    {'1': 'upfront_shutdown', '3': 4, '4': 1, '5': 9, '10': 'upfrontShutdown'},
    {'1': 'csv_delay', '3': 5, '4': 1, '5': 13, '10': 'csvDelay'},
    {'1': 'reserve_sat', '3': 6, '4': 1, '5': 4, '10': 'reserveSat'},
    {'1': 'in_flight_max_msat', '3': 7, '4': 1, '5': 4, '10': 'inFlightMaxMsat'},
    {'1': 'max_htlc_count', '3': 8, '4': 1, '5': 13, '10': 'maxHtlcCount'},
    {'1': 'min_htlc_in', '3': 9, '4': 1, '5': 4, '10': 'minHtlcIn'},
    {'1': 'min_accept_depth', '3': 10, '4': 1, '5': 13, '10': 'minAcceptDepth'},
    {'1': 'zero_conf', '3': 11, '4': 1, '5': 8, '10': 'zeroConf'},
  ],
};

/// Descriptor for `ChannelAcceptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelAcceptResponseDescriptor = $convert.base64Decode(
    'ChVDaGFubmVsQWNjZXB0UmVzcG9uc2USFgoGYWNjZXB0GAEgASgIUgZhY2NlcHQSJgoPcGVuZG'
    'luZ19jaGFuX2lkGAIgASgMUg1wZW5kaW5nQ2hhbklkEhQKBWVycm9yGAMgASgJUgVlcnJvchIp'
    'ChB1cGZyb250X3NodXRkb3duGAQgASgJUg91cGZyb250U2h1dGRvd24SGwoJY3N2X2RlbGF5GA'
    'UgASgNUghjc3ZEZWxheRIfCgtyZXNlcnZlX3NhdBgGIAEoBFIKcmVzZXJ2ZVNhdBIrChJpbl9m'
    'bGlnaHRfbWF4X21zYXQYByABKARSD2luRmxpZ2h0TWF4TXNhdBIkCg5tYXhfaHRsY19jb3VudB'
    'gIIAEoDVIMbWF4SHRsY0NvdW50Eh4KC21pbl9odGxjX2luGAkgASgEUgltaW5IdGxjSW4SKAoQ'
    'bWluX2FjY2VwdF9kZXB0aBgKIAEoDVIObWluQWNjZXB0RGVwdGgSGwoJemVyb19jb25mGAsgAS'
    'gIUgh6ZXJvQ29uZg==');

@$core.Deprecated('Use channelPointDescriptor instead')
const ChannelPoint$json = {
  '1': 'ChannelPoint',
  '2': [
    {'1': 'funding_txid_bytes', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'fundingTxidBytes'},
    {'1': 'funding_txid_str', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'fundingTxidStr'},
    {'1': 'output_index', '3': 3, '4': 1, '5': 13, '10': 'outputIndex'},
  ],
  '8': [
    {'1': 'funding_txid'},
  ],
};

/// Descriptor for `ChannelPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelPointDescriptor = $convert.base64Decode(
    'CgxDaGFubmVsUG9pbnQSLgoSZnVuZGluZ190eGlkX2J5dGVzGAEgASgMSABSEGZ1bmRpbmdUeG'
    'lkQnl0ZXMSKgoQZnVuZGluZ190eGlkX3N0chgCIAEoCUgAUg5mdW5kaW5nVHhpZFN0chIhCgxv'
    'dXRwdXRfaW5kZXgYAyABKA1SC291dHB1dEluZGV4Qg4KDGZ1bmRpbmdfdHhpZA==');

@$core.Deprecated('Use outPointDescriptor instead')
const OutPoint$json = {
  '1': 'OutPoint',
  '2': [
    {'1': 'txid_bytes', '3': 1, '4': 1, '5': 12, '10': 'txidBytes'},
    {'1': 'txid_str', '3': 2, '4': 1, '5': 9, '10': 'txidStr'},
    {'1': 'output_index', '3': 3, '4': 1, '5': 13, '10': 'outputIndex'},
  ],
};

/// Descriptor for `OutPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List outPointDescriptor = $convert.base64Decode(
    'CghPdXRQb2ludBIdCgp0eGlkX2J5dGVzGAEgASgMUgl0eGlkQnl0ZXMSGQoIdHhpZF9zdHIYAi'
    'ABKAlSB3R4aWRTdHISIQoMb3V0cHV0X2luZGV4GAMgASgNUgtvdXRwdXRJbmRleA==');

@$core.Deprecated('Use previousOutPointDescriptor instead')
const PreviousOutPoint$json = {
  '1': 'PreviousOutPoint',
  '2': [
    {'1': 'outpoint', '3': 1, '4': 1, '5': 9, '10': 'outpoint'},
    {'1': 'is_our_output', '3': 2, '4': 1, '5': 8, '10': 'isOurOutput'},
  ],
};

/// Descriptor for `PreviousOutPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List previousOutPointDescriptor = $convert.base64Decode(
    'ChBQcmV2aW91c091dFBvaW50EhoKCG91dHBvaW50GAEgASgJUghvdXRwb2ludBIiCg1pc19vdX'
    'Jfb3V0cHV0GAIgASgIUgtpc091ck91dHB1dA==');

@$core.Deprecated('Use lightningAddressDescriptor instead')
const LightningAddress$json = {
  '1': 'LightningAddress',
  '2': [
    {'1': 'pubkey', '3': 1, '4': 1, '5': 9, '10': 'pubkey'},
    {'1': 'host', '3': 2, '4': 1, '5': 9, '10': 'host'},
  ],
};

/// Descriptor for `LightningAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lightningAddressDescriptor = $convert.base64Decode(
    'ChBMaWdodG5pbmdBZGRyZXNzEhYKBnB1YmtleRgBIAEoCVIGcHVia2V5EhIKBGhvc3QYAiABKA'
    'lSBGhvc3Q=');

@$core.Deprecated('Use estimateFeeRequestDescriptor instead')
const EstimateFeeRequest$json = {
  '1': 'EstimateFeeRequest',
  '2': [
    {'1': 'AddrToAmount', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.EstimateFeeRequest.AddrToAmountEntry', '10': 'AddrToAmount'},
    {'1': 'target_conf', '3': 2, '4': 1, '5': 5, '10': 'targetConf'},
    {'1': 'min_confs', '3': 3, '4': 1, '5': 5, '10': 'minConfs'},
    {'1': 'spend_unconfirmed', '3': 4, '4': 1, '5': 8, '10': 'spendUnconfirmed'},
    {'1': 'coin_selection_strategy', '3': 5, '4': 1, '5': 14, '6': '.lnrpc.CoinSelectionStrategy', '10': 'coinSelectionStrategy'},
  ],
  '3': [EstimateFeeRequest_AddrToAmountEntry$json],
};

@$core.Deprecated('Use estimateFeeRequestDescriptor instead')
const EstimateFeeRequest_AddrToAmountEntry$json = {
  '1': 'AddrToAmountEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `EstimateFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List estimateFeeRequestDescriptor = $convert.base64Decode(
    'ChJFc3RpbWF0ZUZlZVJlcXVlc3QSTwoMQWRkclRvQW1vdW50GAEgAygLMisubG5ycGMuRXN0aW'
    '1hdGVGZWVSZXF1ZXN0LkFkZHJUb0Ftb3VudEVudHJ5UgxBZGRyVG9BbW91bnQSHwoLdGFyZ2V0'
    'X2NvbmYYAiABKAVSCnRhcmdldENvbmYSGwoJbWluX2NvbmZzGAMgASgFUghtaW5Db25mcxIrCh'
    'FzcGVuZF91bmNvbmZpcm1lZBgEIAEoCFIQc3BlbmRVbmNvbmZpcm1lZBJUChdjb2luX3NlbGVj'
    'dGlvbl9zdHJhdGVneRgFIAEoDjIcLmxucnBjLkNvaW5TZWxlY3Rpb25TdHJhdGVneVIVY29pbl'
    'NlbGVjdGlvblN0cmF0ZWd5Gj8KEUFkZHJUb0Ftb3VudEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5'
    'EhQKBXZhbHVlGAIgASgDUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use estimateFeeResponseDescriptor instead')
const EstimateFeeResponse$json = {
  '1': 'EstimateFeeResponse',
  '2': [
    {'1': 'fee_sat', '3': 1, '4': 1, '5': 3, '10': 'feeSat'},
    {
      '1': 'feerate_sat_per_byte',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'feerateSatPerByte',
    },
    {'1': 'sat_per_vbyte', '3': 3, '4': 1, '5': 4, '10': 'satPerVbyte'},
  ],
};

/// Descriptor for `EstimateFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List estimateFeeResponseDescriptor = $convert.base64Decode(
    'ChNFc3RpbWF0ZUZlZVJlc3BvbnNlEhcKB2ZlZV9zYXQYASABKANSBmZlZVNhdBIzChRmZWVyYX'
    'RlX3NhdF9wZXJfYnl0ZRgCIAEoA0ICGAFSEWZlZXJhdGVTYXRQZXJCeXRlEiIKDXNhdF9wZXJf'
    'dmJ5dGUYAyABKARSC3NhdFBlclZieXRl');

@$core.Deprecated('Use sendManyRequestDescriptor instead')
const SendManyRequest$json = {
  '1': 'SendManyRequest',
  '2': [
    {'1': 'AddrToAmount', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.SendManyRequest.AddrToAmountEntry', '10': 'AddrToAmount'},
    {'1': 'target_conf', '3': 3, '4': 1, '5': 5, '10': 'targetConf'},
    {'1': 'sat_per_vbyte', '3': 4, '4': 1, '5': 4, '10': 'satPerVbyte'},
    {
      '1': 'sat_per_byte',
      '3': 5,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'satPerByte',
    },
    {'1': 'label', '3': 6, '4': 1, '5': 9, '10': 'label'},
    {'1': 'min_confs', '3': 7, '4': 1, '5': 5, '10': 'minConfs'},
    {'1': 'spend_unconfirmed', '3': 8, '4': 1, '5': 8, '10': 'spendUnconfirmed'},
    {'1': 'coin_selection_strategy', '3': 9, '4': 1, '5': 14, '6': '.lnrpc.CoinSelectionStrategy', '10': 'coinSelectionStrategy'},
  ],
  '3': [SendManyRequest_AddrToAmountEntry$json],
};

@$core.Deprecated('Use sendManyRequestDescriptor instead')
const SendManyRequest_AddrToAmountEntry$json = {
  '1': 'AddrToAmountEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 3, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SendManyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendManyRequestDescriptor = $convert.base64Decode(
    'Cg9TZW5kTWFueVJlcXVlc3QSTAoMQWRkclRvQW1vdW50GAEgAygLMigubG5ycGMuU2VuZE1hbn'
    'lSZXF1ZXN0LkFkZHJUb0Ftb3VudEVudHJ5UgxBZGRyVG9BbW91bnQSHwoLdGFyZ2V0X2NvbmYY'
    'AyABKAVSCnRhcmdldENvbmYSIgoNc2F0X3Blcl92Ynl0ZRgEIAEoBFILc2F0UGVyVmJ5dGUSJA'
    'oMc2F0X3Blcl9ieXRlGAUgASgDQgIYAVIKc2F0UGVyQnl0ZRIUCgVsYWJlbBgGIAEoCVIFbGFi'
    'ZWwSGwoJbWluX2NvbmZzGAcgASgFUghtaW5Db25mcxIrChFzcGVuZF91bmNvbmZpcm1lZBgIIA'
    'EoCFIQc3BlbmRVbmNvbmZpcm1lZBJUChdjb2luX3NlbGVjdGlvbl9zdHJhdGVneRgJIAEoDjIc'
    'LmxucnBjLkNvaW5TZWxlY3Rpb25TdHJhdGVneVIVY29pblNlbGVjdGlvblN0cmF0ZWd5Gj8KEU'
    'FkZHJUb0Ftb3VudEVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgDUgV2YWx1'
    'ZToCOAE=');

@$core.Deprecated('Use sendManyResponseDescriptor instead')
const SendManyResponse$json = {
  '1': 'SendManyResponse',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 9, '10': 'txid'},
  ],
};

/// Descriptor for `SendManyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendManyResponseDescriptor = $convert.base64Decode(
    'ChBTZW5kTWFueVJlc3BvbnNlEhIKBHR4aWQYASABKAlSBHR4aWQ=');

@$core.Deprecated('Use sendCoinsRequestDescriptor instead')
const SendCoinsRequest$json = {
  '1': 'SendCoinsRequest',
  '2': [
    {'1': 'addr', '3': 1, '4': 1, '5': 9, '10': 'addr'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'target_conf', '3': 3, '4': 1, '5': 5, '10': 'targetConf'},
    {'1': 'sat_per_vbyte', '3': 4, '4': 1, '5': 4, '10': 'satPerVbyte'},
    {
      '1': 'sat_per_byte',
      '3': 5,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'satPerByte',
    },
    {'1': 'send_all', '3': 6, '4': 1, '5': 8, '10': 'sendAll'},
    {'1': 'label', '3': 7, '4': 1, '5': 9, '10': 'label'},
    {'1': 'min_confs', '3': 8, '4': 1, '5': 5, '10': 'minConfs'},
    {'1': 'spend_unconfirmed', '3': 9, '4': 1, '5': 8, '10': 'spendUnconfirmed'},
    {'1': 'coin_selection_strategy', '3': 10, '4': 1, '5': 14, '6': '.lnrpc.CoinSelectionStrategy', '10': 'coinSelectionStrategy'},
    {'1': 'outpoints', '3': 11, '4': 3, '5': 11, '6': '.lnrpc.OutPoint', '10': 'outpoints'},
  ],
};

/// Descriptor for `SendCoinsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCoinsRequestDescriptor = $convert.base64Decode(
    'ChBTZW5kQ29pbnNSZXF1ZXN0EhIKBGFkZHIYASABKAlSBGFkZHISFgoGYW1vdW50GAIgASgDUg'
    'ZhbW91bnQSHwoLdGFyZ2V0X2NvbmYYAyABKAVSCnRhcmdldENvbmYSIgoNc2F0X3Blcl92Ynl0'
    'ZRgEIAEoBFILc2F0UGVyVmJ5dGUSJAoMc2F0X3Blcl9ieXRlGAUgASgDQgIYAVIKc2F0UGVyQn'
    'l0ZRIZCghzZW5kX2FsbBgGIAEoCFIHc2VuZEFsbBIUCgVsYWJlbBgHIAEoCVIFbGFiZWwSGwoJ'
    'bWluX2NvbmZzGAggASgFUghtaW5Db25mcxIrChFzcGVuZF91bmNvbmZpcm1lZBgJIAEoCFIQc3'
    'BlbmRVbmNvbmZpcm1lZBJUChdjb2luX3NlbGVjdGlvbl9zdHJhdGVneRgKIAEoDjIcLmxucnBj'
    'LkNvaW5TZWxlY3Rpb25TdHJhdGVneVIVY29pblNlbGVjdGlvblN0cmF0ZWd5Ei0KCW91dHBvaW'
    '50cxgLIAMoCzIPLmxucnBjLk91dFBvaW50UglvdXRwb2ludHM=');

@$core.Deprecated('Use sendCoinsResponseDescriptor instead')
const SendCoinsResponse$json = {
  '1': 'SendCoinsResponse',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 9, '10': 'txid'},
  ],
};

/// Descriptor for `SendCoinsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCoinsResponseDescriptor = $convert.base64Decode(
    'ChFTZW5kQ29pbnNSZXNwb25zZRISCgR0eGlkGAEgASgJUgR0eGlk');

@$core.Deprecated('Use listUnspentRequestDescriptor instead')
const ListUnspentRequest$json = {
  '1': 'ListUnspentRequest',
  '2': [
    {'1': 'min_confs', '3': 1, '4': 1, '5': 5, '10': 'minConfs'},
    {'1': 'max_confs', '3': 2, '4': 1, '5': 5, '10': 'maxConfs'},
    {'1': 'account', '3': 3, '4': 1, '5': 9, '10': 'account'},
  ],
};

/// Descriptor for `ListUnspentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUnspentRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0VW5zcGVudFJlcXVlc3QSGwoJbWluX2NvbmZzGAEgASgFUghtaW5Db25mcxIbCgltYX'
    'hfY29uZnMYAiABKAVSCG1heENvbmZzEhgKB2FjY291bnQYAyABKAlSB2FjY291bnQ=');

@$core.Deprecated('Use listUnspentResponseDescriptor instead')
const ListUnspentResponse$json = {
  '1': 'ListUnspentResponse',
  '2': [
    {'1': 'utxos', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.Utxo', '10': 'utxos'},
  ],
};

/// Descriptor for `ListUnspentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listUnspentResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0VW5zcGVudFJlc3BvbnNlEiEKBXV0eG9zGAEgAygLMgsubG5ycGMuVXR4b1IFdXR4b3'
    'M=');

@$core.Deprecated('Use newAddressRequestDescriptor instead')
const NewAddressRequest$json = {
  '1': 'NewAddressRequest',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.AddressType', '10': 'type'},
    {'1': 'account', '3': 2, '4': 1, '5': 9, '10': 'account'},
  ],
};

/// Descriptor for `NewAddressRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newAddressRequestDescriptor = $convert.base64Decode(
    'ChFOZXdBZGRyZXNzUmVxdWVzdBImCgR0eXBlGAEgASgOMhIubG5ycGMuQWRkcmVzc1R5cGVSBH'
    'R5cGUSGAoHYWNjb3VudBgCIAEoCVIHYWNjb3VudA==');

@$core.Deprecated('Use newAddressResponseDescriptor instead')
const NewAddressResponse$json = {
  '1': 'NewAddressResponse',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `NewAddressResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newAddressResponseDescriptor = $convert.base64Decode(
    'ChJOZXdBZGRyZXNzUmVzcG9uc2USGAoHYWRkcmVzcxgBIAEoCVIHYWRkcmVzcw==');

@$core.Deprecated('Use signMessageRequestDescriptor instead')
const SignMessageRequest$json = {
  '1': 'SignMessageRequest',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 12, '10': 'msg'},
    {'1': 'single_hash', '3': 2, '4': 1, '5': 8, '10': 'singleHash'},
  ],
};

/// Descriptor for `SignMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signMessageRequestDescriptor = $convert.base64Decode(
    'ChJTaWduTWVzc2FnZVJlcXVlc3QSEAoDbXNnGAEgASgMUgNtc2cSHwoLc2luZ2xlX2hhc2gYAi'
    'ABKAhSCnNpbmdsZUhhc2g=');

@$core.Deprecated('Use signMessageResponseDescriptor instead')
const SignMessageResponse$json = {
  '1': 'SignMessageResponse',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `SignMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signMessageResponseDescriptor = $convert.base64Decode(
    'ChNTaWduTWVzc2FnZVJlc3BvbnNlEhwKCXNpZ25hdHVyZRgBIAEoCVIJc2lnbmF0dXJl');

@$core.Deprecated('Use verifyMessageRequestDescriptor instead')
const VerifyMessageRequest$json = {
  '1': 'VerifyMessageRequest',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 12, '10': 'msg'},
    {'1': 'signature', '3': 2, '4': 1, '5': 9, '10': 'signature'},
  ],
};

/// Descriptor for `VerifyMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyMessageRequestDescriptor = $convert.base64Decode(
    'ChRWZXJpZnlNZXNzYWdlUmVxdWVzdBIQCgNtc2cYASABKAxSA21zZxIcCglzaWduYXR1cmUYAi'
    'ABKAlSCXNpZ25hdHVyZQ==');

@$core.Deprecated('Use verifyMessageResponseDescriptor instead')
const VerifyMessageResponse$json = {
  '1': 'VerifyMessageResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
    {'1': 'pubkey', '3': 2, '4': 1, '5': 9, '10': 'pubkey'},
  ],
};

/// Descriptor for `VerifyMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyMessageResponseDescriptor = $convert.base64Decode(
    'ChVWZXJpZnlNZXNzYWdlUmVzcG9uc2USFAoFdmFsaWQYASABKAhSBXZhbGlkEhYKBnB1YmtleR'
    'gCIAEoCVIGcHVia2V5');

@$core.Deprecated('Use connectPeerRequestDescriptor instead')
const ConnectPeerRequest$json = {
  '1': 'ConnectPeerRequest',
  '2': [
    {'1': 'addr', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.LightningAddress', '10': 'addr'},
    {'1': 'perm', '3': 2, '4': 1, '5': 8, '10': 'perm'},
    {'1': 'timeout', '3': 3, '4': 1, '5': 4, '10': 'timeout'},
  ],
};

/// Descriptor for `ConnectPeerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectPeerRequestDescriptor = $convert.base64Decode(
    'ChJDb25uZWN0UGVlclJlcXVlc3QSKwoEYWRkchgBIAEoCzIXLmxucnBjLkxpZ2h0bmluZ0FkZH'
    'Jlc3NSBGFkZHISEgoEcGVybRgCIAEoCFIEcGVybRIYCgd0aW1lb3V0GAMgASgEUgd0aW1lb3V0');

@$core.Deprecated('Use connectPeerResponseDescriptor instead')
const ConnectPeerResponse$json = {
  '1': 'ConnectPeerResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `ConnectPeerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectPeerResponseDescriptor = $convert.base64Decode(
    'ChNDb25uZWN0UGVlclJlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use disconnectPeerRequestDescriptor instead')
const DisconnectPeerRequest$json = {
  '1': 'DisconnectPeerRequest',
  '2': [
    {'1': 'pub_key', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
  ],
};

/// Descriptor for `DisconnectPeerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectPeerRequestDescriptor = $convert.base64Decode(
    'ChVEaXNjb25uZWN0UGVlclJlcXVlc3QSFwoHcHViX2tleRgBIAEoCVIGcHViS2V5');

@$core.Deprecated('Use disconnectPeerResponseDescriptor instead')
const DisconnectPeerResponse$json = {
  '1': 'DisconnectPeerResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `DisconnectPeerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectPeerResponseDescriptor = $convert.base64Decode(
    'ChZEaXNjb25uZWN0UGVlclJlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use hTLCDescriptor instead')
const HTLC$json = {
  '1': 'HTLC',
  '2': [
    {'1': 'incoming', '3': 1, '4': 1, '5': 8, '10': 'incoming'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'hash_lock', '3': 3, '4': 1, '5': 12, '10': 'hashLock'},
    {'1': 'expiration_height', '3': 4, '4': 1, '5': 13, '10': 'expirationHeight'},
    {'1': 'htlc_index', '3': 5, '4': 1, '5': 4, '10': 'htlcIndex'},
    {'1': 'forwarding_channel', '3': 6, '4': 1, '5': 4, '10': 'forwardingChannel'},
    {'1': 'forwarding_htlc_index', '3': 7, '4': 1, '5': 4, '10': 'forwardingHtlcIndex'},
    {'1': 'locked_in', '3': 8, '4': 1, '5': 8, '10': 'lockedIn'},
  ],
};

/// Descriptor for `HTLC`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hTLCDescriptor = $convert.base64Decode(
    'CgRIVExDEhoKCGluY29taW5nGAEgASgIUghpbmNvbWluZxIWCgZhbW91bnQYAiABKANSBmFtb3'
    'VudBIbCgloYXNoX2xvY2sYAyABKAxSCGhhc2hMb2NrEisKEWV4cGlyYXRpb25faGVpZ2h0GAQg'
    'ASgNUhBleHBpcmF0aW9uSGVpZ2h0Eh0KCmh0bGNfaW5kZXgYBSABKARSCWh0bGNJbmRleBItCh'
    'Jmb3J3YXJkaW5nX2NoYW5uZWwYBiABKARSEWZvcndhcmRpbmdDaGFubmVsEjIKFWZvcndhcmRp'
    'bmdfaHRsY19pbmRleBgHIAEoBFITZm9yd2FyZGluZ0h0bGNJbmRleBIbCglsb2NrZWRfaW4YCC'
    'ABKAhSCGxvY2tlZElu');

@$core.Deprecated('Use channelConstraintsDescriptor instead')
const ChannelConstraints$json = {
  '1': 'ChannelConstraints',
  '2': [
    {'1': 'csv_delay', '3': 1, '4': 1, '5': 13, '10': 'csvDelay'},
    {'1': 'chan_reserve_sat', '3': 2, '4': 1, '5': 4, '10': 'chanReserveSat'},
    {'1': 'dust_limit_sat', '3': 3, '4': 1, '5': 4, '10': 'dustLimitSat'},
    {'1': 'max_pending_amt_msat', '3': 4, '4': 1, '5': 4, '10': 'maxPendingAmtMsat'},
    {'1': 'min_htlc_msat', '3': 5, '4': 1, '5': 4, '10': 'minHtlcMsat'},
    {'1': 'max_accepted_htlcs', '3': 6, '4': 1, '5': 13, '10': 'maxAcceptedHtlcs'},
  ],
};

/// Descriptor for `ChannelConstraints`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelConstraintsDescriptor = $convert.base64Decode(
    'ChJDaGFubmVsQ29uc3RyYWludHMSGwoJY3N2X2RlbGF5GAEgASgNUghjc3ZEZWxheRIoChBjaG'
    'FuX3Jlc2VydmVfc2F0GAIgASgEUg5jaGFuUmVzZXJ2ZVNhdBIkCg5kdXN0X2xpbWl0X3NhdBgD'
    'IAEoBFIMZHVzdExpbWl0U2F0Ei8KFG1heF9wZW5kaW5nX2FtdF9tc2F0GAQgASgEUhFtYXhQZW'
    '5kaW5nQW10TXNhdBIiCg1taW5faHRsY19tc2F0GAUgASgEUgttaW5IdGxjTXNhdBIsChJtYXhf'
    'YWNjZXB0ZWRfaHRsY3MYBiABKA1SEG1heEFjY2VwdGVkSHRsY3M=');

@$core.Deprecated('Use channelDescriptor instead')
const Channel$json = {
  '1': 'Channel',
  '2': [
    {'1': 'active', '3': 1, '4': 1, '5': 8, '10': 'active'},
    {'1': 'remote_pubkey', '3': 2, '4': 1, '5': 9, '10': 'remotePubkey'},
    {'1': 'channel_point', '3': 3, '4': 1, '5': 9, '10': 'channelPoint'},
    {
      '1': 'chan_id',
      '3': 4,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'capacity', '3': 5, '4': 1, '5': 3, '10': 'capacity'},
    {'1': 'local_balance', '3': 6, '4': 1, '5': 3, '10': 'localBalance'},
    {'1': 'remote_balance', '3': 7, '4': 1, '5': 3, '10': 'remoteBalance'},
    {'1': 'commit_fee', '3': 8, '4': 1, '5': 3, '10': 'commitFee'},
    {'1': 'commit_weight', '3': 9, '4': 1, '5': 3, '10': 'commitWeight'},
    {'1': 'fee_per_kw', '3': 10, '4': 1, '5': 3, '10': 'feePerKw'},
    {'1': 'unsettled_balance', '3': 11, '4': 1, '5': 3, '10': 'unsettledBalance'},
    {'1': 'total_satoshis_sent', '3': 12, '4': 1, '5': 3, '10': 'totalSatoshisSent'},
    {'1': 'total_satoshis_received', '3': 13, '4': 1, '5': 3, '10': 'totalSatoshisReceived'},
    {'1': 'num_updates', '3': 14, '4': 1, '5': 4, '10': 'numUpdates'},
    {'1': 'pending_htlcs', '3': 15, '4': 3, '5': 11, '6': '.lnrpc.HTLC', '10': 'pendingHtlcs'},
    {
      '1': 'csv_delay',
      '3': 16,
      '4': 1,
      '5': 13,
      '8': {'3': true},
      '10': 'csvDelay',
    },
    {'1': 'private', '3': 17, '4': 1, '5': 8, '10': 'private'},
    {'1': 'initiator', '3': 18, '4': 1, '5': 8, '10': 'initiator'},
    {'1': 'chan_status_flags', '3': 19, '4': 1, '5': 9, '10': 'chanStatusFlags'},
    {
      '1': 'local_chan_reserve_sat',
      '3': 20,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'localChanReserveSat',
    },
    {
      '1': 'remote_chan_reserve_sat',
      '3': 21,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'remoteChanReserveSat',
    },
    {
      '1': 'static_remote_key',
      '3': 22,
      '4': 1,
      '5': 8,
      '8': {'3': true},
      '10': 'staticRemoteKey',
    },
    {'1': 'commitment_type', '3': 26, '4': 1, '5': 14, '6': '.lnrpc.CommitmentType', '10': 'commitmentType'},
    {'1': 'lifetime', '3': 23, '4': 1, '5': 3, '10': 'lifetime'},
    {'1': 'uptime', '3': 24, '4': 1, '5': 3, '10': 'uptime'},
    {'1': 'close_address', '3': 25, '4': 1, '5': 9, '10': 'closeAddress'},
    {'1': 'push_amount_sat', '3': 27, '4': 1, '5': 4, '10': 'pushAmountSat'},
    {'1': 'thaw_height', '3': 28, '4': 1, '5': 13, '10': 'thawHeight'},
    {'1': 'local_constraints', '3': 29, '4': 1, '5': 11, '6': '.lnrpc.ChannelConstraints', '10': 'localConstraints'},
    {'1': 'remote_constraints', '3': 30, '4': 1, '5': 11, '6': '.lnrpc.ChannelConstraints', '10': 'remoteConstraints'},
    {'1': 'alias_scids', '3': 31, '4': 3, '5': 4, '10': 'aliasScids'},
    {'1': 'zero_conf', '3': 32, '4': 1, '5': 8, '10': 'zeroConf'},
    {'1': 'zero_conf_confirmed_scid', '3': 33, '4': 1, '5': 4, '10': 'zeroConfConfirmedScid'},
    {'1': 'peer_alias', '3': 34, '4': 1, '5': 9, '10': 'peerAlias'},
    {
      '1': 'peer_scid_alias',
      '3': 35,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'peerScidAlias',
    },
    {'1': 'memo', '3': 36, '4': 1, '5': 9, '10': 'memo'},
    {'1': 'custom_channel_data', '3': 37, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
};

/// Descriptor for `Channel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelDescriptor = $convert.base64Decode(
    'CgdDaGFubmVsEhYKBmFjdGl2ZRgBIAEoCFIGYWN0aXZlEiMKDXJlbW90ZV9wdWJrZXkYAiABKA'
    'lSDHJlbW90ZVB1YmtleRIjCg1jaGFubmVsX3BvaW50GAMgASgJUgxjaGFubmVsUG9pbnQSGwoH'
    'Y2hhbl9pZBgEIAEoBEICMAFSBmNoYW5JZBIaCghjYXBhY2l0eRgFIAEoA1IIY2FwYWNpdHkSIw'
    'oNbG9jYWxfYmFsYW5jZRgGIAEoA1IMbG9jYWxCYWxhbmNlEiUKDnJlbW90ZV9iYWxhbmNlGAcg'
    'ASgDUg1yZW1vdGVCYWxhbmNlEh0KCmNvbW1pdF9mZWUYCCABKANSCWNvbW1pdEZlZRIjCg1jb2'
    '1taXRfd2VpZ2h0GAkgASgDUgxjb21taXRXZWlnaHQSHAoKZmVlX3Blcl9rdxgKIAEoA1IIZmVl'
    'UGVyS3cSKwoRdW5zZXR0bGVkX2JhbGFuY2UYCyABKANSEHVuc2V0dGxlZEJhbGFuY2USLgoTdG'
    '90YWxfc2F0b3NoaXNfc2VudBgMIAEoA1IRdG90YWxTYXRvc2hpc1NlbnQSNgoXdG90YWxfc2F0'
    'b3NoaXNfcmVjZWl2ZWQYDSABKANSFXRvdGFsU2F0b3NoaXNSZWNlaXZlZBIfCgtudW1fdXBkYX'
    'RlcxgOIAEoBFIKbnVtVXBkYXRlcxIwCg1wZW5kaW5nX2h0bGNzGA8gAygLMgsubG5ycGMuSFRM'
    'Q1IMcGVuZGluZ0h0bGNzEh8KCWNzdl9kZWxheRgQIAEoDUICGAFSCGNzdkRlbGF5EhgKB3ByaX'
    'ZhdGUYESABKAhSB3ByaXZhdGUSHAoJaW5pdGlhdG9yGBIgASgIUglpbml0aWF0b3ISKgoRY2hh'
    'bl9zdGF0dXNfZmxhZ3MYEyABKAlSD2NoYW5TdGF0dXNGbGFncxI3ChZsb2NhbF9jaGFuX3Jlc2'
    'VydmVfc2F0GBQgASgDQgIYAVITbG9jYWxDaGFuUmVzZXJ2ZVNhdBI5ChdyZW1vdGVfY2hhbl9y'
    'ZXNlcnZlX3NhdBgVIAEoA0ICGAFSFHJlbW90ZUNoYW5SZXNlcnZlU2F0Ei4KEXN0YXRpY19yZW'
    '1vdGVfa2V5GBYgASgIQgIYAVIPc3RhdGljUmVtb3RlS2V5Ej4KD2NvbW1pdG1lbnRfdHlwZRga'
    'IAEoDjIVLmxucnBjLkNvbW1pdG1lbnRUeXBlUg5jb21taXRtZW50VHlwZRIaCghsaWZldGltZR'
    'gXIAEoA1IIbGlmZXRpbWUSFgoGdXB0aW1lGBggASgDUgZ1cHRpbWUSIwoNY2xvc2VfYWRkcmVz'
    'cxgZIAEoCVIMY2xvc2VBZGRyZXNzEiYKD3B1c2hfYW1vdW50X3NhdBgbIAEoBFINcHVzaEFtb3'
    'VudFNhdBIfCgt0aGF3X2hlaWdodBgcIAEoDVIKdGhhd0hlaWdodBJGChFsb2NhbF9jb25zdHJh'
    'aW50cxgdIAEoCzIZLmxucnBjLkNoYW5uZWxDb25zdHJhaW50c1IQbG9jYWxDb25zdHJhaW50cx'
    'JIChJyZW1vdGVfY29uc3RyYWludHMYHiABKAsyGS5sbnJwYy5DaGFubmVsQ29uc3RyYWludHNS'
    'EXJlbW90ZUNvbnN0cmFpbnRzEh8KC2FsaWFzX3NjaWRzGB8gAygEUgphbGlhc1NjaWRzEhsKCX'
    'plcm9fY29uZhggIAEoCFIIemVyb0NvbmYSNwoYemVyb19jb25mX2NvbmZpcm1lZF9zY2lkGCEg'
    'ASgEUhV6ZXJvQ29uZkNvbmZpcm1lZFNjaWQSHQoKcGVlcl9hbGlhcxgiIAEoCVIJcGVlckFsaW'
    'FzEioKD3BlZXJfc2NpZF9hbGlhcxgjIAEoBEICMAFSDXBlZXJTY2lkQWxpYXMSEgoEbWVtbxgk'
    'IAEoCVIEbWVtbxIuChNjdXN0b21fY2hhbm5lbF9kYXRhGCUgASgMUhFjdXN0b21DaGFubmVsRG'
    'F0YQ==');

@$core.Deprecated('Use listChannelsRequestDescriptor instead')
const ListChannelsRequest$json = {
  '1': 'ListChannelsRequest',
  '2': [
    {'1': 'active_only', '3': 1, '4': 1, '5': 8, '10': 'activeOnly'},
    {'1': 'inactive_only', '3': 2, '4': 1, '5': 8, '10': 'inactiveOnly'},
    {'1': 'public_only', '3': 3, '4': 1, '5': 8, '10': 'publicOnly'},
    {'1': 'private_only', '3': 4, '4': 1, '5': 8, '10': 'privateOnly'},
    {'1': 'peer', '3': 5, '4': 1, '5': 12, '10': 'peer'},
    {'1': 'peer_alias_lookup', '3': 6, '4': 1, '5': 8, '10': 'peerAliasLookup'},
  ],
};

/// Descriptor for `ListChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChannelsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0Q2hhbm5lbHNSZXF1ZXN0Eh8KC2FjdGl2ZV9vbmx5GAEgASgIUgphY3RpdmVPbmx5Ei'
    'MKDWluYWN0aXZlX29ubHkYAiABKAhSDGluYWN0aXZlT25seRIfCgtwdWJsaWNfb25seRgDIAEo'
    'CFIKcHVibGljT25seRIhCgxwcml2YXRlX29ubHkYBCABKAhSC3ByaXZhdGVPbmx5EhIKBHBlZX'
    'IYBSABKAxSBHBlZXISKgoRcGVlcl9hbGlhc19sb29rdXAYBiABKAhSD3BlZXJBbGlhc0xvb2t1'
    'cA==');

@$core.Deprecated('Use listChannelsResponseDescriptor instead')
const ListChannelsResponse$json = {
  '1': 'ListChannelsResponse',
  '2': [
    {'1': 'channels', '3': 11, '4': 3, '5': 11, '6': '.lnrpc.Channel', '10': 'channels'},
  ],
};

/// Descriptor for `ListChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChannelsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0Q2hhbm5lbHNSZXNwb25zZRIqCghjaGFubmVscxgLIAMoCzIOLmxucnBjLkNoYW5uZW'
    'xSCGNoYW5uZWxz');

@$core.Deprecated('Use aliasMapDescriptor instead')
const AliasMap$json = {
  '1': 'AliasMap',
  '2': [
    {'1': 'base_scid', '3': 1, '4': 1, '5': 4, '10': 'baseScid'},
    {'1': 'aliases', '3': 2, '4': 3, '5': 4, '10': 'aliases'},
  ],
};

/// Descriptor for `AliasMap`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aliasMapDescriptor = $convert.base64Decode(
    'CghBbGlhc01hcBIbCgliYXNlX3NjaWQYASABKARSCGJhc2VTY2lkEhgKB2FsaWFzZXMYAiADKA'
    'RSB2FsaWFzZXM=');

@$core.Deprecated('Use listAliasesRequestDescriptor instead')
const ListAliasesRequest$json = {
  '1': 'ListAliasesRequest',
};

/// Descriptor for `ListAliasesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAliasesRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0QWxpYXNlc1JlcXVlc3Q=');

@$core.Deprecated('Use listAliasesResponseDescriptor instead')
const ListAliasesResponse$json = {
  '1': 'ListAliasesResponse',
  '2': [
    {'1': 'alias_maps', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.AliasMap', '10': 'aliasMaps'},
  ],
};

/// Descriptor for `ListAliasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listAliasesResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0QWxpYXNlc1Jlc3BvbnNlEi4KCmFsaWFzX21hcHMYASADKAsyDy5sbnJwYy5BbGlhc0'
    '1hcFIJYWxpYXNNYXBz');

@$core.Deprecated('Use channelCloseSummaryDescriptor instead')
const ChannelCloseSummary$json = {
  '1': 'ChannelCloseSummary',
  '2': [
    {'1': 'channel_point', '3': 1, '4': 1, '5': 9, '10': 'channelPoint'},
    {
      '1': 'chan_id',
      '3': 2,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'chain_hash', '3': 3, '4': 1, '5': 9, '10': 'chainHash'},
    {'1': 'closing_tx_hash', '3': 4, '4': 1, '5': 9, '10': 'closingTxHash'},
    {'1': 'remote_pubkey', '3': 5, '4': 1, '5': 9, '10': 'remotePubkey'},
    {'1': 'capacity', '3': 6, '4': 1, '5': 3, '10': 'capacity'},
    {'1': 'close_height', '3': 7, '4': 1, '5': 13, '10': 'closeHeight'},
    {'1': 'settled_balance', '3': 8, '4': 1, '5': 3, '10': 'settledBalance'},
    {'1': 'time_locked_balance', '3': 9, '4': 1, '5': 3, '10': 'timeLockedBalance'},
    {'1': 'close_type', '3': 10, '4': 1, '5': 14, '6': '.lnrpc.ChannelCloseSummary.ClosureType', '10': 'closeType'},
    {'1': 'open_initiator', '3': 11, '4': 1, '5': 14, '6': '.lnrpc.Initiator', '10': 'openInitiator'},
    {'1': 'close_initiator', '3': 12, '4': 1, '5': 14, '6': '.lnrpc.Initiator', '10': 'closeInitiator'},
    {'1': 'resolutions', '3': 13, '4': 3, '5': 11, '6': '.lnrpc.Resolution', '10': 'resolutions'},
    {'1': 'alias_scids', '3': 14, '4': 3, '5': 4, '10': 'aliasScids'},
    {
      '1': 'zero_conf_confirmed_scid',
      '3': 15,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'zeroConfConfirmedScid',
    },
    {'1': 'custom_channel_data', '3': 16, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
  '4': [ChannelCloseSummary_ClosureType$json],
};

@$core.Deprecated('Use channelCloseSummaryDescriptor instead')
const ChannelCloseSummary_ClosureType$json = {
  '1': 'ClosureType',
  '2': [
    {'1': 'COOPERATIVE_CLOSE', '2': 0},
    {'1': 'LOCAL_FORCE_CLOSE', '2': 1},
    {'1': 'REMOTE_FORCE_CLOSE', '2': 2},
    {'1': 'BREACH_CLOSE', '2': 3},
    {'1': 'FUNDING_CANCELED', '2': 4},
    {'1': 'ABANDONED', '2': 5},
  ],
};

/// Descriptor for `ChannelCloseSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelCloseSummaryDescriptor = $convert.base64Decode(
    'ChNDaGFubmVsQ2xvc2VTdW1tYXJ5EiMKDWNoYW5uZWxfcG9pbnQYASABKAlSDGNoYW5uZWxQb2'
    'ludBIbCgdjaGFuX2lkGAIgASgEQgIwAVIGY2hhbklkEh0KCmNoYWluX2hhc2gYAyABKAlSCWNo'
    'YWluSGFzaBImCg9jbG9zaW5nX3R4X2hhc2gYBCABKAlSDWNsb3NpbmdUeEhhc2gSIwoNcmVtb3'
    'RlX3B1YmtleRgFIAEoCVIMcmVtb3RlUHVia2V5EhoKCGNhcGFjaXR5GAYgASgDUghjYXBhY2l0'
    'eRIhCgxjbG9zZV9oZWlnaHQYByABKA1SC2Nsb3NlSGVpZ2h0EicKD3NldHRsZWRfYmFsYW5jZR'
    'gIIAEoA1IOc2V0dGxlZEJhbGFuY2USLgoTdGltZV9sb2NrZWRfYmFsYW5jZRgJIAEoA1IRdGlt'
    'ZUxvY2tlZEJhbGFuY2USRQoKY2xvc2VfdHlwZRgKIAEoDjImLmxucnBjLkNoYW5uZWxDbG9zZV'
    'N1bW1hcnkuQ2xvc3VyZVR5cGVSCWNsb3NlVHlwZRI3Cg5vcGVuX2luaXRpYXRvchgLIAEoDjIQ'
    'LmxucnBjLkluaXRpYXRvclINb3BlbkluaXRpYXRvchI5Cg9jbG9zZV9pbml0aWF0b3IYDCABKA'
    '4yEC5sbnJwYy5Jbml0aWF0b3JSDmNsb3NlSW5pdGlhdG9yEjMKC3Jlc29sdXRpb25zGA0gAygL'
    'MhEubG5ycGMuUmVzb2x1dGlvblILcmVzb2x1dGlvbnMSHwoLYWxpYXNfc2NpZHMYDiADKARSCm'
    'FsaWFzU2NpZHMSOwoYemVyb19jb25mX2NvbmZpcm1lZF9zY2lkGA8gASgEQgIwAVIVemVyb0Nv'
    'bmZDb25maXJtZWRTY2lkEi4KE2N1c3RvbV9jaGFubmVsX2RhdGEYECABKAxSEWN1c3RvbUNoYW'
    '5uZWxEYXRhIooBCgtDbG9zdXJlVHlwZRIVChFDT09QRVJBVElWRV9DTE9TRRAAEhUKEUxPQ0FM'
    'X0ZPUkNFX0NMT1NFEAESFgoSUkVNT1RFX0ZPUkNFX0NMT1NFEAISEAoMQlJFQUNIX0NMT1NFEA'
    'MSFAoQRlVORElOR19DQU5DRUxFRBAEEg0KCUFCQU5ET05FRBAF');

@$core.Deprecated('Use resolutionDescriptor instead')
const Resolution$json = {
  '1': 'Resolution',
  '2': [
    {'1': 'resolution_type', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.ResolutionType', '10': 'resolutionType'},
    {'1': 'outcome', '3': 2, '4': 1, '5': 14, '6': '.lnrpc.ResolutionOutcome', '10': 'outcome'},
    {'1': 'outpoint', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.OutPoint', '10': 'outpoint'},
    {'1': 'amount_sat', '3': 4, '4': 1, '5': 4, '10': 'amountSat'},
    {'1': 'sweep_txid', '3': 5, '4': 1, '5': 9, '10': 'sweepTxid'},
  ],
};

/// Descriptor for `Resolution`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolutionDescriptor = $convert.base64Decode(
    'CgpSZXNvbHV0aW9uEj4KD3Jlc29sdXRpb25fdHlwZRgBIAEoDjIVLmxucnBjLlJlc29sdXRpb2'
    '5UeXBlUg5yZXNvbHV0aW9uVHlwZRIyCgdvdXRjb21lGAIgASgOMhgubG5ycGMuUmVzb2x1dGlv'
    'bk91dGNvbWVSB291dGNvbWUSKwoIb3V0cG9pbnQYAyABKAsyDy5sbnJwYy5PdXRQb2ludFIIb3'
    'V0cG9pbnQSHQoKYW1vdW50X3NhdBgEIAEoBFIJYW1vdW50U2F0Eh0KCnN3ZWVwX3R4aWQYBSAB'
    'KAlSCXN3ZWVwVHhpZA==');

@$core.Deprecated('Use closedChannelsRequestDescriptor instead')
const ClosedChannelsRequest$json = {
  '1': 'ClosedChannelsRequest',
  '2': [
    {'1': 'cooperative', '3': 1, '4': 1, '5': 8, '10': 'cooperative'},
    {'1': 'local_force', '3': 2, '4': 1, '5': 8, '10': 'localForce'},
    {'1': 'remote_force', '3': 3, '4': 1, '5': 8, '10': 'remoteForce'},
    {'1': 'breach', '3': 4, '4': 1, '5': 8, '10': 'breach'},
    {'1': 'funding_canceled', '3': 5, '4': 1, '5': 8, '10': 'fundingCanceled'},
    {'1': 'abandoned', '3': 6, '4': 1, '5': 8, '10': 'abandoned'},
  ],
};

/// Descriptor for `ClosedChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closedChannelsRequestDescriptor = $convert.base64Decode(
    'ChVDbG9zZWRDaGFubmVsc1JlcXVlc3QSIAoLY29vcGVyYXRpdmUYASABKAhSC2Nvb3BlcmF0aX'
    'ZlEh8KC2xvY2FsX2ZvcmNlGAIgASgIUgpsb2NhbEZvcmNlEiEKDHJlbW90ZV9mb3JjZRgDIAEo'
    'CFILcmVtb3RlRm9yY2USFgoGYnJlYWNoGAQgASgIUgZicmVhY2gSKQoQZnVuZGluZ19jYW5jZW'
    'xlZBgFIAEoCFIPZnVuZGluZ0NhbmNlbGVkEhwKCWFiYW5kb25lZBgGIAEoCFIJYWJhbmRvbmVk');

@$core.Deprecated('Use closedChannelsResponseDescriptor instead')
const ClosedChannelsResponse$json = {
  '1': 'ClosedChannelsResponse',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.ChannelCloseSummary', '10': 'channels'},
  ],
};

/// Descriptor for `ClosedChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closedChannelsResponseDescriptor = $convert.base64Decode(
    'ChZDbG9zZWRDaGFubmVsc1Jlc3BvbnNlEjYKCGNoYW5uZWxzGAEgAygLMhoubG5ycGMuQ2hhbm'
    '5lbENsb3NlU3VtbWFyeVIIY2hhbm5lbHM=');

@$core.Deprecated('Use peerDescriptor instead')
const Peer$json = {
  '1': 'Peer',
  '2': [
    {'1': 'pub_key', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
    {'1': 'address', '3': 3, '4': 1, '5': 9, '10': 'address'},
    {'1': 'bytes_sent', '3': 4, '4': 1, '5': 4, '10': 'bytesSent'},
    {'1': 'bytes_recv', '3': 5, '4': 1, '5': 4, '10': 'bytesRecv'},
    {'1': 'sat_sent', '3': 6, '4': 1, '5': 3, '10': 'satSent'},
    {'1': 'sat_recv', '3': 7, '4': 1, '5': 3, '10': 'satRecv'},
    {'1': 'inbound', '3': 8, '4': 1, '5': 8, '10': 'inbound'},
    {'1': 'ping_time', '3': 9, '4': 1, '5': 3, '10': 'pingTime'},
    {'1': 'sync_type', '3': 10, '4': 1, '5': 14, '6': '.lnrpc.Peer.SyncType', '10': 'syncType'},
    {'1': 'features', '3': 11, '4': 3, '5': 11, '6': '.lnrpc.Peer.FeaturesEntry', '10': 'features'},
    {'1': 'errors', '3': 12, '4': 3, '5': 11, '6': '.lnrpc.TimestampedError', '10': 'errors'},
    {'1': 'flap_count', '3': 13, '4': 1, '5': 5, '10': 'flapCount'},
    {'1': 'last_flap_ns', '3': 14, '4': 1, '5': 3, '10': 'lastFlapNs'},
    {'1': 'last_ping_payload', '3': 15, '4': 1, '5': 12, '10': 'lastPingPayload'},
  ],
  '3': [Peer_FeaturesEntry$json],
  '4': [Peer_SyncType$json],
};

@$core.Deprecated('Use peerDescriptor instead')
const Peer_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use peerDescriptor instead')
const Peer_SyncType$json = {
  '1': 'SyncType',
  '2': [
    {'1': 'UNKNOWN_SYNC', '2': 0},
    {'1': 'ACTIVE_SYNC', '2': 1},
    {'1': 'PASSIVE_SYNC', '2': 2},
    {'1': 'PINNED_SYNC', '2': 3},
  ],
};

/// Descriptor for `Peer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerDescriptor = $convert.base64Decode(
    'CgRQZWVyEhcKB3B1Yl9rZXkYASABKAlSBnB1YktleRIYCgdhZGRyZXNzGAMgASgJUgdhZGRyZX'
    'NzEh0KCmJ5dGVzX3NlbnQYBCABKARSCWJ5dGVzU2VudBIdCgpieXRlc19yZWN2GAUgASgEUgli'
    'eXRlc1JlY3YSGQoIc2F0X3NlbnQYBiABKANSB3NhdFNlbnQSGQoIc2F0X3JlY3YYByABKANSB3'
    'NhdFJlY3YSGAoHaW5ib3VuZBgIIAEoCFIHaW5ib3VuZBIbCglwaW5nX3RpbWUYCSABKANSCHBp'
    'bmdUaW1lEjEKCXN5bmNfdHlwZRgKIAEoDjIULmxucnBjLlBlZXIuU3luY1R5cGVSCHN5bmNUeX'
    'BlEjUKCGZlYXR1cmVzGAsgAygLMhkubG5ycGMuUGVlci5GZWF0dXJlc0VudHJ5UghmZWF0dXJl'
    'cxIvCgZlcnJvcnMYDCADKAsyFy5sbnJwYy5UaW1lc3RhbXBlZEVycm9yUgZlcnJvcnMSHQoKZm'
    'xhcF9jb3VudBgNIAEoBVIJZmxhcENvdW50EiAKDGxhc3RfZmxhcF9ucxgOIAEoA1IKbGFzdEZs'
    'YXBOcxIqChFsYXN0X3BpbmdfcGF5bG9hZBgPIAEoDFIPbGFzdFBpbmdQYXlsb2FkGksKDUZlYX'
    'R1cmVzRW50cnkSEAoDa2V5GAEgASgNUgNrZXkSJAoFdmFsdWUYAiABKAsyDi5sbnJwYy5GZWF0'
    'dXJlUgV2YWx1ZToCOAEiUAoIU3luY1R5cGUSEAoMVU5LTk9XTl9TWU5DEAASDwoLQUNUSVZFX1'
    'NZTkMQARIQCgxQQVNTSVZFX1NZTkMQAhIPCgtQSU5ORURfU1lOQxAD');

@$core.Deprecated('Use timestampedErrorDescriptor instead')
const TimestampedError$json = {
  '1': 'TimestampedError',
  '2': [
    {'1': 'timestamp', '3': 1, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'error', '3': 2, '4': 1, '5': 9, '10': 'error'},
  ],
};

/// Descriptor for `TimestampedError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timestampedErrorDescriptor = $convert.base64Decode(
    'ChBUaW1lc3RhbXBlZEVycm9yEhwKCXRpbWVzdGFtcBgBIAEoBFIJdGltZXN0YW1wEhQKBWVycm'
    '9yGAIgASgJUgVlcnJvcg==');

@$core.Deprecated('Use listPeersRequestDescriptor instead')
const ListPeersRequest$json = {
  '1': 'ListPeersRequest',
  '2': [
    {'1': 'latest_error', '3': 1, '4': 1, '5': 8, '10': 'latestError'},
  ],
};

/// Descriptor for `ListPeersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPeersRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0UGVlcnNSZXF1ZXN0EiEKDGxhdGVzdF9lcnJvchgBIAEoCFILbGF0ZXN0RXJyb3I=');

@$core.Deprecated('Use listPeersResponseDescriptor instead')
const ListPeersResponse$json = {
  '1': 'ListPeersResponse',
  '2': [
    {'1': 'peers', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.Peer', '10': 'peers'},
  ],
};

/// Descriptor for `ListPeersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPeersResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0UGVlcnNSZXNwb25zZRIhCgVwZWVycxgBIAMoCzILLmxucnBjLlBlZXJSBXBlZXJz');

@$core.Deprecated('Use peerEventSubscriptionDescriptor instead')
const PeerEventSubscription$json = {
  '1': 'PeerEventSubscription',
};

/// Descriptor for `PeerEventSubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerEventSubscriptionDescriptor = $convert.base64Decode(
    'ChVQZWVyRXZlbnRTdWJzY3JpcHRpb24=');

@$core.Deprecated('Use peerEventDescriptor instead')
const PeerEvent$json = {
  '1': 'PeerEvent',
  '2': [
    {'1': 'pub_key', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.lnrpc.PeerEvent.EventType', '10': 'type'},
  ],
  '4': [PeerEvent_EventType$json],
};

@$core.Deprecated('Use peerEventDescriptor instead')
const PeerEvent_EventType$json = {
  '1': 'EventType',
  '2': [
    {'1': 'PEER_ONLINE', '2': 0},
    {'1': 'PEER_OFFLINE', '2': 1},
  ],
};

/// Descriptor for `PeerEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerEventDescriptor = $convert.base64Decode(
    'CglQZWVyRXZlbnQSFwoHcHViX2tleRgBIAEoCVIGcHViS2V5Ei4KBHR5cGUYAiABKA4yGi5sbn'
    'JwYy5QZWVyRXZlbnQuRXZlbnRUeXBlUgR0eXBlIi4KCUV2ZW50VHlwZRIPCgtQRUVSX09OTElO'
    'RRAAEhAKDFBFRVJfT0ZGTElORRAB');

@$core.Deprecated('Use getInfoRequestDescriptor instead')
const GetInfoRequest$json = {
  '1': 'GetInfoRequest',
};

/// Descriptor for `GetInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInfoRequestDescriptor = $convert.base64Decode(
    'Cg5HZXRJbmZvUmVxdWVzdA==');

@$core.Deprecated('Use getInfoResponseDescriptor instead')
const GetInfoResponse$json = {
  '1': 'GetInfoResponse',
  '2': [
    {'1': 'version', '3': 14, '4': 1, '5': 9, '10': 'version'},
    {'1': 'commit_hash', '3': 20, '4': 1, '5': 9, '10': 'commitHash'},
    {'1': 'identity_pubkey', '3': 1, '4': 1, '5': 9, '10': 'identityPubkey'},
    {'1': 'alias', '3': 2, '4': 1, '5': 9, '10': 'alias'},
    {'1': 'color', '3': 17, '4': 1, '5': 9, '10': 'color'},
    {'1': 'num_pending_channels', '3': 3, '4': 1, '5': 13, '10': 'numPendingChannels'},
    {'1': 'num_active_channels', '3': 4, '4': 1, '5': 13, '10': 'numActiveChannels'},
    {'1': 'num_inactive_channels', '3': 15, '4': 1, '5': 13, '10': 'numInactiveChannels'},
    {'1': 'num_peers', '3': 5, '4': 1, '5': 13, '10': 'numPeers'},
    {'1': 'block_height', '3': 6, '4': 1, '5': 13, '10': 'blockHeight'},
    {'1': 'block_hash', '3': 8, '4': 1, '5': 9, '10': 'blockHash'},
    {'1': 'best_header_timestamp', '3': 13, '4': 1, '5': 3, '10': 'bestHeaderTimestamp'},
    {'1': 'synced_to_chain', '3': 9, '4': 1, '5': 8, '10': 'syncedToChain'},
    {'1': 'synced_to_graph', '3': 18, '4': 1, '5': 8, '10': 'syncedToGraph'},
    {
      '1': 'testnet',
      '3': 10,
      '4': 1,
      '5': 8,
      '8': {'3': true},
      '10': 'testnet',
    },
    {'1': 'chains', '3': 16, '4': 3, '5': 11, '6': '.lnrpc.Chain', '10': 'chains'},
    {'1': 'uris', '3': 12, '4': 3, '5': 9, '10': 'uris'},
    {'1': 'features', '3': 19, '4': 3, '5': 11, '6': '.lnrpc.GetInfoResponse.FeaturesEntry', '10': 'features'},
    {'1': 'require_htlc_interceptor', '3': 21, '4': 1, '5': 8, '10': 'requireHtlcInterceptor'},
    {'1': 'store_final_htlc_resolutions', '3': 22, '4': 1, '5': 8, '10': 'storeFinalHtlcResolutions'},
  ],
  '3': [GetInfoResponse_FeaturesEntry$json],
  '9': [
    {'1': 11, '2': 12},
  ],
};

@$core.Deprecated('Use getInfoResponseDescriptor instead')
const GetInfoResponse_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInfoResponseDescriptor = $convert.base64Decode(
    'Cg9HZXRJbmZvUmVzcG9uc2USGAoHdmVyc2lvbhgOIAEoCVIHdmVyc2lvbhIfCgtjb21taXRfaG'
    'FzaBgUIAEoCVIKY29tbWl0SGFzaBInCg9pZGVudGl0eV9wdWJrZXkYASABKAlSDmlkZW50aXR5'
    'UHVia2V5EhQKBWFsaWFzGAIgASgJUgVhbGlhcxIUCgVjb2xvchgRIAEoCVIFY29sb3ISMAoUbn'
    'VtX3BlbmRpbmdfY2hhbm5lbHMYAyABKA1SEm51bVBlbmRpbmdDaGFubmVscxIuChNudW1fYWN0'
    'aXZlX2NoYW5uZWxzGAQgASgNUhFudW1BY3RpdmVDaGFubmVscxIyChVudW1faW5hY3RpdmVfY2'
    'hhbm5lbHMYDyABKA1SE251bUluYWN0aXZlQ2hhbm5lbHMSGwoJbnVtX3BlZXJzGAUgASgNUghu'
    'dW1QZWVycxIhCgxibG9ja19oZWlnaHQYBiABKA1SC2Jsb2NrSGVpZ2h0Eh0KCmJsb2NrX2hhc2'
    'gYCCABKAlSCWJsb2NrSGFzaBIyChViZXN0X2hlYWRlcl90aW1lc3RhbXAYDSABKANSE2Jlc3RI'
    'ZWFkZXJUaW1lc3RhbXASJgoPc3luY2VkX3RvX2NoYWluGAkgASgIUg1zeW5jZWRUb0NoYWluEi'
    'YKD3N5bmNlZF90b19ncmFwaBgSIAEoCFINc3luY2VkVG9HcmFwaBIcCgd0ZXN0bmV0GAogASgI'
    'QgIYAVIHdGVzdG5ldBIkCgZjaGFpbnMYECADKAsyDC5sbnJwYy5DaGFpblIGY2hhaW5zEhIKBH'
    'VyaXMYDCADKAlSBHVyaXMSQAoIZmVhdHVyZXMYEyADKAsyJC5sbnJwYy5HZXRJbmZvUmVzcG9u'
    'c2UuRmVhdHVyZXNFbnRyeVIIZmVhdHVyZXMSOAoYcmVxdWlyZV9odGxjX2ludGVyY2VwdG9yGB'
    'UgASgIUhZyZXF1aXJlSHRsY0ludGVyY2VwdG9yEj8KHHN0b3JlX2ZpbmFsX2h0bGNfcmVzb2x1'
    'dGlvbnMYFiABKAhSGXN0b3JlRmluYWxIdGxjUmVzb2x1dGlvbnMaSwoNRmVhdHVyZXNFbnRyeR'
    'IQCgNrZXkYASABKA1SA2tleRIkCgV2YWx1ZRgCIAEoCzIOLmxucnBjLkZlYXR1cmVSBXZhbHVl'
    'OgI4AUoECAsQDA==');

@$core.Deprecated('Use getDebugInfoRequestDescriptor instead')
const GetDebugInfoRequest$json = {
  '1': 'GetDebugInfoRequest',
};

/// Descriptor for `GetDebugInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDebugInfoRequestDescriptor = $convert.base64Decode(
    'ChNHZXREZWJ1Z0luZm9SZXF1ZXN0');

@$core.Deprecated('Use getDebugInfoResponseDescriptor instead')
const GetDebugInfoResponse$json = {
  '1': 'GetDebugInfoResponse',
  '2': [
    {'1': 'config', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.GetDebugInfoResponse.ConfigEntry', '10': 'config'},
    {'1': 'log', '3': 2, '4': 3, '5': 9, '10': 'log'},
  ],
  '3': [GetDebugInfoResponse_ConfigEntry$json],
};

@$core.Deprecated('Use getDebugInfoResponseDescriptor instead')
const GetDebugInfoResponse_ConfigEntry$json = {
  '1': 'ConfigEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetDebugInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDebugInfoResponseDescriptor = $convert.base64Decode(
    'ChRHZXREZWJ1Z0luZm9SZXNwb25zZRI/CgZjb25maWcYASADKAsyJy5sbnJwYy5HZXREZWJ1Z0'
    'luZm9SZXNwb25zZS5Db25maWdFbnRyeVIGY29uZmlnEhAKA2xvZxgCIAMoCVIDbG9nGjkKC0Nv'
    'bmZpZ0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use getRecoveryInfoRequestDescriptor instead')
const GetRecoveryInfoRequest$json = {
  '1': 'GetRecoveryInfoRequest',
};

/// Descriptor for `GetRecoveryInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecoveryInfoRequestDescriptor = $convert.base64Decode(
    'ChZHZXRSZWNvdmVyeUluZm9SZXF1ZXN0');

@$core.Deprecated('Use getRecoveryInfoResponseDescriptor instead')
const GetRecoveryInfoResponse$json = {
  '1': 'GetRecoveryInfoResponse',
  '2': [
    {'1': 'recovery_mode', '3': 1, '4': 1, '5': 8, '10': 'recoveryMode'},
    {'1': 'recovery_finished', '3': 2, '4': 1, '5': 8, '10': 'recoveryFinished'},
    {'1': 'progress', '3': 3, '4': 1, '5': 1, '10': 'progress'},
  ],
};

/// Descriptor for `GetRecoveryInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getRecoveryInfoResponseDescriptor = $convert.base64Decode(
    'ChdHZXRSZWNvdmVyeUluZm9SZXNwb25zZRIjCg1yZWNvdmVyeV9tb2RlGAEgASgIUgxyZWNvdm'
    'VyeU1vZGUSKwoRcmVjb3ZlcnlfZmluaXNoZWQYAiABKAhSEHJlY292ZXJ5RmluaXNoZWQSGgoI'
    'cHJvZ3Jlc3MYAyABKAFSCHByb2dyZXNz');

@$core.Deprecated('Use chainDescriptor instead')
const Chain$json = {
  '1': 'Chain',
  '2': [
    {
      '1': 'chain',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'chain',
    },
    {'1': 'network', '3': 2, '4': 1, '5': 9, '10': 'network'},
  ],
};

/// Descriptor for `Chain`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chainDescriptor = $convert.base64Decode(
    'CgVDaGFpbhIYCgVjaGFpbhgBIAEoCUICGAFSBWNoYWluEhgKB25ldHdvcmsYAiABKAlSB25ldH'
    'dvcms=');

@$core.Deprecated('Use confirmationUpdateDescriptor instead')
const ConfirmationUpdate$json = {
  '1': 'ConfirmationUpdate',
  '2': [
    {'1': 'block_sha', '3': 1, '4': 1, '5': 12, '10': 'blockSha'},
    {'1': 'block_height', '3': 2, '4': 1, '5': 5, '10': 'blockHeight'},
    {'1': 'num_confs_left', '3': 3, '4': 1, '5': 13, '10': 'numConfsLeft'},
  ],
};

/// Descriptor for `ConfirmationUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List confirmationUpdateDescriptor = $convert.base64Decode(
    'ChJDb25maXJtYXRpb25VcGRhdGUSGwoJYmxvY2tfc2hhGAEgASgMUghibG9ja1NoYRIhCgxibG'
    '9ja19oZWlnaHQYAiABKAVSC2Jsb2NrSGVpZ2h0EiQKDm51bV9jb25mc19sZWZ0GAMgASgNUgxu'
    'dW1Db25mc0xlZnQ=');

@$core.Deprecated('Use channelOpenUpdateDescriptor instead')
const ChannelOpenUpdate$json = {
  '1': 'ChannelOpenUpdate',
  '2': [
    {'1': 'channel_point', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'channelPoint'},
  ],
};

/// Descriptor for `ChannelOpenUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelOpenUpdateDescriptor = $convert.base64Decode(
    'ChFDaGFubmVsT3BlblVwZGF0ZRI4Cg1jaGFubmVsX3BvaW50GAEgASgLMhMubG5ycGMuQ2hhbm'
    '5lbFBvaW50UgxjaGFubmVsUG9pbnQ=');

@$core.Deprecated('Use closeOutputDescriptor instead')
const CloseOutput$json = {
  '1': 'CloseOutput',
  '2': [
    {'1': 'amount_sat', '3': 1, '4': 1, '5': 3, '10': 'amountSat'},
    {'1': 'pk_script', '3': 2, '4': 1, '5': 12, '10': 'pkScript'},
    {'1': 'is_local', '3': 3, '4': 1, '5': 8, '10': 'isLocal'},
    {'1': 'custom_channel_data', '3': 4, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
};

/// Descriptor for `CloseOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeOutputDescriptor = $convert.base64Decode(
    'CgtDbG9zZU91dHB1dBIdCgphbW91bnRfc2F0GAEgASgDUglhbW91bnRTYXQSGwoJcGtfc2NyaX'
    'B0GAIgASgMUghwa1NjcmlwdBIZCghpc19sb2NhbBgDIAEoCFIHaXNMb2NhbBIuChNjdXN0b21f'
    'Y2hhbm5lbF9kYXRhGAQgASgMUhFjdXN0b21DaGFubmVsRGF0YQ==');

@$core.Deprecated('Use channelCloseUpdateDescriptor instead')
const ChannelCloseUpdate$json = {
  '1': 'ChannelCloseUpdate',
  '2': [
    {'1': 'closing_txid', '3': 1, '4': 1, '5': 12, '10': 'closingTxid'},
    {'1': 'success', '3': 2, '4': 1, '5': 8, '10': 'success'},
    {'1': 'local_close_output', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.CloseOutput', '10': 'localCloseOutput'},
    {'1': 'remote_close_output', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.CloseOutput', '10': 'remoteCloseOutput'},
    {'1': 'additional_outputs', '3': 5, '4': 3, '5': 11, '6': '.lnrpc.CloseOutput', '10': 'additionalOutputs'},
  ],
};

/// Descriptor for `ChannelCloseUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelCloseUpdateDescriptor = $convert.base64Decode(
    'ChJDaGFubmVsQ2xvc2VVcGRhdGUSIQoMY2xvc2luZ190eGlkGAEgASgMUgtjbG9zaW5nVHhpZB'
    'IYCgdzdWNjZXNzGAIgASgIUgdzdWNjZXNzEkAKEmxvY2FsX2Nsb3NlX291dHB1dBgDIAEoCzIS'
    'LmxucnBjLkNsb3NlT3V0cHV0UhBsb2NhbENsb3NlT3V0cHV0EkIKE3JlbW90ZV9jbG9zZV9vdX'
    'RwdXQYBCABKAsyEi5sbnJwYy5DbG9zZU91dHB1dFIRcmVtb3RlQ2xvc2VPdXRwdXQSQQoSYWRk'
    'aXRpb25hbF9vdXRwdXRzGAUgAygLMhIubG5ycGMuQ2xvc2VPdXRwdXRSEWFkZGl0aW9uYWxPdX'
    'RwdXRz');

@$core.Deprecated('Use closeChannelRequestDescriptor instead')
const CloseChannelRequest$json = {
  '1': 'CloseChannelRequest',
  '2': [
    {'1': 'channel_point', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'channelPoint'},
    {'1': 'force', '3': 2, '4': 1, '5': 8, '10': 'force'},
    {'1': 'target_conf', '3': 3, '4': 1, '5': 5, '10': 'targetConf'},
    {
      '1': 'sat_per_byte',
      '3': 4,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'satPerByte',
    },
    {'1': 'delivery_address', '3': 5, '4': 1, '5': 9, '10': 'deliveryAddress'},
    {'1': 'sat_per_vbyte', '3': 6, '4': 1, '5': 4, '10': 'satPerVbyte'},
    {'1': 'max_fee_per_vbyte', '3': 7, '4': 1, '5': 4, '10': 'maxFeePerVbyte'},
    {'1': 'no_wait', '3': 8, '4': 1, '5': 8, '10': 'noWait'},
  ],
};

/// Descriptor for `CloseChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeChannelRequestDescriptor = $convert.base64Decode(
    'ChNDbG9zZUNoYW5uZWxSZXF1ZXN0EjgKDWNoYW5uZWxfcG9pbnQYASABKAsyEy5sbnJwYy5DaG'
    'FubmVsUG9pbnRSDGNoYW5uZWxQb2ludBIUCgVmb3JjZRgCIAEoCFIFZm9yY2USHwoLdGFyZ2V0'
    'X2NvbmYYAyABKAVSCnRhcmdldENvbmYSJAoMc2F0X3Blcl9ieXRlGAQgASgDQgIYAVIKc2F0UG'
    'VyQnl0ZRIpChBkZWxpdmVyeV9hZGRyZXNzGAUgASgJUg9kZWxpdmVyeUFkZHJlc3MSIgoNc2F0'
    'X3Blcl92Ynl0ZRgGIAEoBFILc2F0UGVyVmJ5dGUSKQoRbWF4X2ZlZV9wZXJfdmJ5dGUYByABKA'
    'RSDm1heEZlZVBlclZieXRlEhcKB25vX3dhaXQYCCABKAhSBm5vV2FpdA==');

@$core.Deprecated('Use closeStatusUpdateDescriptor instead')
const CloseStatusUpdate$json = {
  '1': 'CloseStatusUpdate',
  '2': [
    {'1': 'close_pending', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.PendingUpdate', '9': 0, '10': 'closePending'},
    {'1': 'chan_close', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.ChannelCloseUpdate', '9': 0, '10': 'chanClose'},
    {'1': 'close_instant', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.InstantUpdate', '9': 0, '10': 'closeInstant'},
  ],
  '8': [
    {'1': 'update'},
  ],
};

/// Descriptor for `CloseStatusUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeStatusUpdateDescriptor = $convert.base64Decode(
    'ChFDbG9zZVN0YXR1c1VwZGF0ZRI7Cg1jbG9zZV9wZW5kaW5nGAEgASgLMhQubG5ycGMuUGVuZG'
    'luZ1VwZGF0ZUgAUgxjbG9zZVBlbmRpbmcSOgoKY2hhbl9jbG9zZRgDIAEoCzIZLmxucnBjLkNo'
    'YW5uZWxDbG9zZVVwZGF0ZUgAUgljaGFuQ2xvc2USOwoNY2xvc2VfaW5zdGFudBgEIAEoCzIULm'
    'xucnBjLkluc3RhbnRVcGRhdGVIAFIMY2xvc2VJbnN0YW50QggKBnVwZGF0ZQ==');

@$core.Deprecated('Use pendingUpdateDescriptor instead')
const PendingUpdate$json = {
  '1': 'PendingUpdate',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 12, '10': 'txid'},
    {'1': 'output_index', '3': 2, '4': 1, '5': 13, '10': 'outputIndex'},
    {'1': 'fee_per_vbyte', '3': 3, '4': 1, '5': 3, '10': 'feePerVbyte'},
    {'1': 'local_close_tx', '3': 4, '4': 1, '5': 8, '10': 'localCloseTx'},
  ],
};

/// Descriptor for `PendingUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingUpdateDescriptor = $convert.base64Decode(
    'Cg1QZW5kaW5nVXBkYXRlEhIKBHR4aWQYASABKAxSBHR4aWQSIQoMb3V0cHV0X2luZGV4GAIgAS'
    'gNUgtvdXRwdXRJbmRleBIiCg1mZWVfcGVyX3ZieXRlGAMgASgDUgtmZWVQZXJWYnl0ZRIkCg5s'
    'b2NhbF9jbG9zZV90eBgEIAEoCFIMbG9jYWxDbG9zZVR4');

@$core.Deprecated('Use instantUpdateDescriptor instead')
const InstantUpdate$json = {
  '1': 'InstantUpdate',
  '2': [
    {'1': 'num_pending_htlcs', '3': 1, '4': 1, '5': 5, '10': 'numPendingHtlcs'},
  ],
};

/// Descriptor for `InstantUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List instantUpdateDescriptor = $convert.base64Decode(
    'Cg1JbnN0YW50VXBkYXRlEioKEW51bV9wZW5kaW5nX2h0bGNzGAEgASgFUg9udW1QZW5kaW5nSH'
    'RsY3M=');

@$core.Deprecated('Use readyForPsbtFundingDescriptor instead')
const ReadyForPsbtFunding$json = {
  '1': 'ReadyForPsbtFunding',
  '2': [
    {'1': 'funding_address', '3': 1, '4': 1, '5': 9, '10': 'fundingAddress'},
    {'1': 'funding_amount', '3': 2, '4': 1, '5': 3, '10': 'fundingAmount'},
    {'1': 'psbt', '3': 3, '4': 1, '5': 12, '10': 'psbt'},
  ],
};

/// Descriptor for `ReadyForPsbtFunding`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readyForPsbtFundingDescriptor = $convert.base64Decode(
    'ChNSZWFkeUZvclBzYnRGdW5kaW5nEicKD2Z1bmRpbmdfYWRkcmVzcxgBIAEoCVIOZnVuZGluZ0'
    'FkZHJlc3MSJQoOZnVuZGluZ19hbW91bnQYAiABKANSDWZ1bmRpbmdBbW91bnQSEgoEcHNidBgD'
    'IAEoDFIEcHNidA==');

@$core.Deprecated('Use batchOpenChannelRequestDescriptor instead')
const BatchOpenChannelRequest$json = {
  '1': 'BatchOpenChannelRequest',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.BatchOpenChannel', '10': 'channels'},
    {'1': 'target_conf', '3': 2, '4': 1, '5': 5, '10': 'targetConf'},
    {'1': 'sat_per_vbyte', '3': 3, '4': 1, '5': 3, '10': 'satPerVbyte'},
    {'1': 'min_confs', '3': 4, '4': 1, '5': 5, '10': 'minConfs'},
    {'1': 'spend_unconfirmed', '3': 5, '4': 1, '5': 8, '10': 'spendUnconfirmed'},
    {'1': 'label', '3': 6, '4': 1, '5': 9, '10': 'label'},
    {'1': 'coin_selection_strategy', '3': 7, '4': 1, '5': 14, '6': '.lnrpc.CoinSelectionStrategy', '10': 'coinSelectionStrategy'},
  ],
};

/// Descriptor for `BatchOpenChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchOpenChannelRequestDescriptor = $convert.base64Decode(
    'ChdCYXRjaE9wZW5DaGFubmVsUmVxdWVzdBIzCghjaGFubmVscxgBIAMoCzIXLmxucnBjLkJhdG'
    'NoT3BlbkNoYW5uZWxSCGNoYW5uZWxzEh8KC3RhcmdldF9jb25mGAIgASgFUgp0YXJnZXRDb25m'
    'EiIKDXNhdF9wZXJfdmJ5dGUYAyABKANSC3NhdFBlclZieXRlEhsKCW1pbl9jb25mcxgEIAEoBV'
    'IIbWluQ29uZnMSKwoRc3BlbmRfdW5jb25maXJtZWQYBSABKAhSEHNwZW5kVW5jb25maXJtZWQS'
    'FAoFbGFiZWwYBiABKAlSBWxhYmVsElQKF2NvaW5fc2VsZWN0aW9uX3N0cmF0ZWd5GAcgASgOMh'
    'wubG5ycGMuQ29pblNlbGVjdGlvblN0cmF0ZWd5UhVjb2luU2VsZWN0aW9uU3RyYXRlZ3k=');

@$core.Deprecated('Use batchOpenChannelDescriptor instead')
const BatchOpenChannel$json = {
  '1': 'BatchOpenChannel',
  '2': [
    {'1': 'node_pubkey', '3': 1, '4': 1, '5': 12, '10': 'nodePubkey'},
    {'1': 'local_funding_amount', '3': 2, '4': 1, '5': 3, '10': 'localFundingAmount'},
    {'1': 'push_sat', '3': 3, '4': 1, '5': 3, '10': 'pushSat'},
    {'1': 'private', '3': 4, '4': 1, '5': 8, '10': 'private'},
    {'1': 'min_htlc_msat', '3': 5, '4': 1, '5': 3, '10': 'minHtlcMsat'},
    {'1': 'remote_csv_delay', '3': 6, '4': 1, '5': 13, '10': 'remoteCsvDelay'},
    {'1': 'close_address', '3': 7, '4': 1, '5': 9, '10': 'closeAddress'},
    {'1': 'pending_chan_id', '3': 8, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'commitment_type', '3': 9, '4': 1, '5': 14, '6': '.lnrpc.CommitmentType', '10': 'commitmentType'},
    {'1': 'remote_max_value_in_flight_msat', '3': 10, '4': 1, '5': 4, '10': 'remoteMaxValueInFlightMsat'},
    {'1': 'remote_max_htlcs', '3': 11, '4': 1, '5': 13, '10': 'remoteMaxHtlcs'},
    {'1': 'max_local_csv', '3': 12, '4': 1, '5': 13, '10': 'maxLocalCsv'},
    {'1': 'zero_conf', '3': 13, '4': 1, '5': 8, '10': 'zeroConf'},
    {'1': 'scid_alias', '3': 14, '4': 1, '5': 8, '10': 'scidAlias'},
    {'1': 'base_fee', '3': 15, '4': 1, '5': 4, '10': 'baseFee'},
    {'1': 'fee_rate', '3': 16, '4': 1, '5': 4, '10': 'feeRate'},
    {'1': 'use_base_fee', '3': 17, '4': 1, '5': 8, '10': 'useBaseFee'},
    {'1': 'use_fee_rate', '3': 18, '4': 1, '5': 8, '10': 'useFeeRate'},
    {'1': 'remote_chan_reserve_sat', '3': 19, '4': 1, '5': 4, '10': 'remoteChanReserveSat'},
    {'1': 'memo', '3': 20, '4': 1, '5': 9, '10': 'memo'},
  ],
};

/// Descriptor for `BatchOpenChannel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchOpenChannelDescriptor = $convert.base64Decode(
    'ChBCYXRjaE9wZW5DaGFubmVsEh8KC25vZGVfcHVia2V5GAEgASgMUgpub2RlUHVia2V5EjAKFG'
    'xvY2FsX2Z1bmRpbmdfYW1vdW50GAIgASgDUhJsb2NhbEZ1bmRpbmdBbW91bnQSGQoIcHVzaF9z'
    'YXQYAyABKANSB3B1c2hTYXQSGAoHcHJpdmF0ZRgEIAEoCFIHcHJpdmF0ZRIiCg1taW5faHRsY1'
    '9tc2F0GAUgASgDUgttaW5IdGxjTXNhdBIoChByZW1vdGVfY3N2X2RlbGF5GAYgASgNUg5yZW1v'
    'dGVDc3ZEZWxheRIjCg1jbG9zZV9hZGRyZXNzGAcgASgJUgxjbG9zZUFkZHJlc3MSJgoPcGVuZG'
    'luZ19jaGFuX2lkGAggASgMUg1wZW5kaW5nQ2hhbklkEj4KD2NvbW1pdG1lbnRfdHlwZRgJIAEo'
    'DjIVLmxucnBjLkNvbW1pdG1lbnRUeXBlUg5jb21taXRtZW50VHlwZRJDCh9yZW1vdGVfbWF4X3'
    'ZhbHVlX2luX2ZsaWdodF9tc2F0GAogASgEUhpyZW1vdGVNYXhWYWx1ZUluRmxpZ2h0TXNhdBIo'
    'ChByZW1vdGVfbWF4X2h0bGNzGAsgASgNUg5yZW1vdGVNYXhIdGxjcxIiCg1tYXhfbG9jYWxfY3'
    'N2GAwgASgNUgttYXhMb2NhbENzdhIbCgl6ZXJvX2NvbmYYDSABKAhSCHplcm9Db25mEh0KCnNj'
    'aWRfYWxpYXMYDiABKAhSCXNjaWRBbGlhcxIZCghiYXNlX2ZlZRgPIAEoBFIHYmFzZUZlZRIZCg'
    'hmZWVfcmF0ZRgQIAEoBFIHZmVlUmF0ZRIgCgx1c2VfYmFzZV9mZWUYESABKAhSCnVzZUJhc2VG'
    'ZWUSIAoMdXNlX2ZlZV9yYXRlGBIgASgIUgp1c2VGZWVSYXRlEjUKF3JlbW90ZV9jaGFuX3Jlc2'
    'VydmVfc2F0GBMgASgEUhRyZW1vdGVDaGFuUmVzZXJ2ZVNhdBISCgRtZW1vGBQgASgJUgRtZW1v');

@$core.Deprecated('Use batchOpenChannelResponseDescriptor instead')
const BatchOpenChannelResponse$json = {
  '1': 'BatchOpenChannelResponse',
  '2': [
    {'1': 'pending_channels', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.PendingUpdate', '10': 'pendingChannels'},
  ],
};

/// Descriptor for `BatchOpenChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchOpenChannelResponseDescriptor = $convert.base64Decode(
    'ChhCYXRjaE9wZW5DaGFubmVsUmVzcG9uc2USPwoQcGVuZGluZ19jaGFubmVscxgBIAMoCzIULm'
    'xucnBjLlBlbmRpbmdVcGRhdGVSD3BlbmRpbmdDaGFubmVscw==');

@$core.Deprecated('Use openChannelRequestDescriptor instead')
const OpenChannelRequest$json = {
  '1': 'OpenChannelRequest',
  '2': [
    {'1': 'sat_per_vbyte', '3': 1, '4': 1, '5': 4, '10': 'satPerVbyte'},
    {'1': 'node_pubkey', '3': 2, '4': 1, '5': 12, '10': 'nodePubkey'},
    {
      '1': 'node_pubkey_string',
      '3': 3,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'nodePubkeyString',
    },
    {'1': 'local_funding_amount', '3': 4, '4': 1, '5': 3, '10': 'localFundingAmount'},
    {'1': 'push_sat', '3': 5, '4': 1, '5': 3, '10': 'pushSat'},
    {'1': 'target_conf', '3': 6, '4': 1, '5': 5, '10': 'targetConf'},
    {
      '1': 'sat_per_byte',
      '3': 7,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'satPerByte',
    },
    {'1': 'private', '3': 8, '4': 1, '5': 8, '10': 'private'},
    {'1': 'min_htlc_msat', '3': 9, '4': 1, '5': 3, '10': 'minHtlcMsat'},
    {'1': 'remote_csv_delay', '3': 10, '4': 1, '5': 13, '10': 'remoteCsvDelay'},
    {'1': 'min_confs', '3': 11, '4': 1, '5': 5, '10': 'minConfs'},
    {'1': 'spend_unconfirmed', '3': 12, '4': 1, '5': 8, '10': 'spendUnconfirmed'},
    {'1': 'close_address', '3': 13, '4': 1, '5': 9, '10': 'closeAddress'},
    {'1': 'funding_shim', '3': 14, '4': 1, '5': 11, '6': '.lnrpc.FundingShim', '10': 'fundingShim'},
    {'1': 'remote_max_value_in_flight_msat', '3': 15, '4': 1, '5': 4, '10': 'remoteMaxValueInFlightMsat'},
    {'1': 'remote_max_htlcs', '3': 16, '4': 1, '5': 13, '10': 'remoteMaxHtlcs'},
    {'1': 'max_local_csv', '3': 17, '4': 1, '5': 13, '10': 'maxLocalCsv'},
    {'1': 'commitment_type', '3': 18, '4': 1, '5': 14, '6': '.lnrpc.CommitmentType', '10': 'commitmentType'},
    {'1': 'zero_conf', '3': 19, '4': 1, '5': 8, '10': 'zeroConf'},
    {'1': 'scid_alias', '3': 20, '4': 1, '5': 8, '10': 'scidAlias'},
    {'1': 'base_fee', '3': 21, '4': 1, '5': 4, '10': 'baseFee'},
    {'1': 'fee_rate', '3': 22, '4': 1, '5': 4, '10': 'feeRate'},
    {'1': 'use_base_fee', '3': 23, '4': 1, '5': 8, '10': 'useBaseFee'},
    {'1': 'use_fee_rate', '3': 24, '4': 1, '5': 8, '10': 'useFeeRate'},
    {'1': 'remote_chan_reserve_sat', '3': 25, '4': 1, '5': 4, '10': 'remoteChanReserveSat'},
    {'1': 'fund_max', '3': 26, '4': 1, '5': 8, '10': 'fundMax'},
    {'1': 'memo', '3': 27, '4': 1, '5': 9, '10': 'memo'},
    {'1': 'outpoints', '3': 28, '4': 3, '5': 11, '6': '.lnrpc.OutPoint', '10': 'outpoints'},
  ],
};

/// Descriptor for `OpenChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openChannelRequestDescriptor = $convert.base64Decode(
    'ChJPcGVuQ2hhbm5lbFJlcXVlc3QSIgoNc2F0X3Blcl92Ynl0ZRgBIAEoBFILc2F0UGVyVmJ5dG'
    'USHwoLbm9kZV9wdWJrZXkYAiABKAxSCm5vZGVQdWJrZXkSMAoSbm9kZV9wdWJrZXlfc3RyaW5n'
    'GAMgASgJQgIYAVIQbm9kZVB1YmtleVN0cmluZxIwChRsb2NhbF9mdW5kaW5nX2Ftb3VudBgEIA'
    'EoA1ISbG9jYWxGdW5kaW5nQW1vdW50EhkKCHB1c2hfc2F0GAUgASgDUgdwdXNoU2F0Eh8KC3Rh'
    'cmdldF9jb25mGAYgASgFUgp0YXJnZXRDb25mEiQKDHNhdF9wZXJfYnl0ZRgHIAEoA0ICGAFSCn'
    'NhdFBlckJ5dGUSGAoHcHJpdmF0ZRgIIAEoCFIHcHJpdmF0ZRIiCg1taW5faHRsY19tc2F0GAkg'
    'ASgDUgttaW5IdGxjTXNhdBIoChByZW1vdGVfY3N2X2RlbGF5GAogASgNUg5yZW1vdGVDc3ZEZW'
    'xheRIbCgltaW5fY29uZnMYCyABKAVSCG1pbkNvbmZzEisKEXNwZW5kX3VuY29uZmlybWVkGAwg'
    'ASgIUhBzcGVuZFVuY29uZmlybWVkEiMKDWNsb3NlX2FkZHJlc3MYDSABKAlSDGNsb3NlQWRkcm'
    'VzcxI1CgxmdW5kaW5nX3NoaW0YDiABKAsyEi5sbnJwYy5GdW5kaW5nU2hpbVILZnVuZGluZ1No'
    'aW0SQwofcmVtb3RlX21heF92YWx1ZV9pbl9mbGlnaHRfbXNhdBgPIAEoBFIacmVtb3RlTWF4Vm'
    'FsdWVJbkZsaWdodE1zYXQSKAoQcmVtb3RlX21heF9odGxjcxgQIAEoDVIOcmVtb3RlTWF4SHRs'
    'Y3MSIgoNbWF4X2xvY2FsX2NzdhgRIAEoDVILbWF4TG9jYWxDc3YSPgoPY29tbWl0bWVudF90eX'
    'BlGBIgASgOMhUubG5ycGMuQ29tbWl0bWVudFR5cGVSDmNvbW1pdG1lbnRUeXBlEhsKCXplcm9f'
    'Y29uZhgTIAEoCFIIemVyb0NvbmYSHQoKc2NpZF9hbGlhcxgUIAEoCFIJc2NpZEFsaWFzEhkKCG'
    'Jhc2VfZmVlGBUgASgEUgdiYXNlRmVlEhkKCGZlZV9yYXRlGBYgASgEUgdmZWVSYXRlEiAKDHVz'
    'ZV9iYXNlX2ZlZRgXIAEoCFIKdXNlQmFzZUZlZRIgCgx1c2VfZmVlX3JhdGUYGCABKAhSCnVzZU'
    'ZlZVJhdGUSNQoXcmVtb3RlX2NoYW5fcmVzZXJ2ZV9zYXQYGSABKARSFHJlbW90ZUNoYW5SZXNl'
    'cnZlU2F0EhkKCGZ1bmRfbWF4GBogASgIUgdmdW5kTWF4EhIKBG1lbW8YGyABKAlSBG1lbW8SLQ'
    'oJb3V0cG9pbnRzGBwgAygLMg8ubG5ycGMuT3V0UG9pbnRSCW91dHBvaW50cw==');

@$core.Deprecated('Use openStatusUpdateDescriptor instead')
const OpenStatusUpdate$json = {
  '1': 'OpenStatusUpdate',
  '2': [
    {'1': 'chan_pending', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.PendingUpdate', '9': 0, '10': 'chanPending'},
    {'1': 'chan_open', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.ChannelOpenUpdate', '9': 0, '10': 'chanOpen'},
    {'1': 'psbt_fund', '3': 5, '4': 1, '5': 11, '6': '.lnrpc.ReadyForPsbtFunding', '9': 0, '10': 'psbtFund'},
    {'1': 'pending_chan_id', '3': 4, '4': 1, '5': 12, '10': 'pendingChanId'},
  ],
  '8': [
    {'1': 'update'},
  ],
};

/// Descriptor for `OpenStatusUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openStatusUpdateDescriptor = $convert.base64Decode(
    'ChBPcGVuU3RhdHVzVXBkYXRlEjkKDGNoYW5fcGVuZGluZxgBIAEoCzIULmxucnBjLlBlbmRpbm'
    'dVcGRhdGVIAFILY2hhblBlbmRpbmcSNwoJY2hhbl9vcGVuGAMgASgLMhgubG5ycGMuQ2hhbm5l'
    'bE9wZW5VcGRhdGVIAFIIY2hhbk9wZW4SOQoJcHNidF9mdW5kGAUgASgLMhoubG5ycGMuUmVhZH'
    'lGb3JQc2J0RnVuZGluZ0gAUghwc2J0RnVuZBImCg9wZW5kaW5nX2NoYW5faWQYBCABKAxSDXBl'
    'bmRpbmdDaGFuSWRCCAoGdXBkYXRl');

@$core.Deprecated('Use keyLocatorDescriptor instead')
const KeyLocator$json = {
  '1': 'KeyLocator',
  '2': [
    {'1': 'key_family', '3': 1, '4': 1, '5': 5, '10': 'keyFamily'},
    {'1': 'key_index', '3': 2, '4': 1, '5': 5, '10': 'keyIndex'},
  ],
};

/// Descriptor for `KeyLocator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyLocatorDescriptor = $convert.base64Decode(
    'CgpLZXlMb2NhdG9yEh0KCmtleV9mYW1pbHkYASABKAVSCWtleUZhbWlseRIbCglrZXlfaW5kZX'
    'gYAiABKAVSCGtleUluZGV4');

@$core.Deprecated('Use keyDescriptorDescriptor instead')
const KeyDescriptor$json = {
  '1': 'KeyDescriptor',
  '2': [
    {'1': 'raw_key_bytes', '3': 1, '4': 1, '5': 12, '10': 'rawKeyBytes'},
    {'1': 'key_loc', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.KeyLocator', '10': 'keyLoc'},
  ],
};

/// Descriptor for `KeyDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyDescriptorDescriptor = $convert.base64Decode(
    'Cg1LZXlEZXNjcmlwdG9yEiIKDXJhd19rZXlfYnl0ZXMYASABKAxSC3Jhd0tleUJ5dGVzEioKB2'
    'tleV9sb2MYAiABKAsyES5sbnJwYy5LZXlMb2NhdG9yUgZrZXlMb2M=');

@$core.Deprecated('Use chanPointShimDescriptor instead')
const ChanPointShim$json = {
  '1': 'ChanPointShim',
  '2': [
    {'1': 'amt', '3': 1, '4': 1, '5': 3, '10': 'amt'},
    {'1': 'chan_point', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoint'},
    {'1': 'local_key', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.KeyDescriptor', '10': 'localKey'},
    {'1': 'remote_key', '3': 4, '4': 1, '5': 12, '10': 'remoteKey'},
    {'1': 'pending_chan_id', '3': 5, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'thaw_height', '3': 6, '4': 1, '5': 13, '10': 'thawHeight'},
    {'1': 'musig2', '3': 7, '4': 1, '5': 8, '10': 'musig2'},
  ],
};

/// Descriptor for `ChanPointShim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chanPointShimDescriptor = $convert.base64Decode(
    'Cg1DaGFuUG9pbnRTaGltEhAKA2FtdBgBIAEoA1IDYW10EjIKCmNoYW5fcG9pbnQYAiABKAsyEy'
    '5sbnJwYy5DaGFubmVsUG9pbnRSCWNoYW5Qb2ludBIxCglsb2NhbF9rZXkYAyABKAsyFC5sbnJw'
    'Yy5LZXlEZXNjcmlwdG9yUghsb2NhbEtleRIdCgpyZW1vdGVfa2V5GAQgASgMUglyZW1vdGVLZX'
    'kSJgoPcGVuZGluZ19jaGFuX2lkGAUgASgMUg1wZW5kaW5nQ2hhbklkEh8KC3RoYXdfaGVpZ2h0'
    'GAYgASgNUgp0aGF3SGVpZ2h0EhYKBm11c2lnMhgHIAEoCFIGbXVzaWcy');

@$core.Deprecated('Use psbtShimDescriptor instead')
const PsbtShim$json = {
  '1': 'PsbtShim',
  '2': [
    {'1': 'pending_chan_id', '3': 1, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'base_psbt', '3': 2, '4': 1, '5': 12, '10': 'basePsbt'},
    {'1': 'no_publish', '3': 3, '4': 1, '5': 8, '10': 'noPublish'},
  ],
};

/// Descriptor for `PsbtShim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List psbtShimDescriptor = $convert.base64Decode(
    'CghQc2J0U2hpbRImCg9wZW5kaW5nX2NoYW5faWQYASABKAxSDXBlbmRpbmdDaGFuSWQSGwoJYm'
    'FzZV9wc2J0GAIgASgMUghiYXNlUHNidBIdCgpub19wdWJsaXNoGAMgASgIUglub1B1Ymxpc2g=');

@$core.Deprecated('Use fundingShimDescriptor instead')
const FundingShim$json = {
  '1': 'FundingShim',
  '2': [
    {'1': 'chan_point_shim', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChanPointShim', '9': 0, '10': 'chanPointShim'},
    {'1': 'psbt_shim', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.PsbtShim', '9': 0, '10': 'psbtShim'},
  ],
  '8': [
    {'1': 'shim'},
  ],
};

/// Descriptor for `FundingShim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingShimDescriptor = $convert.base64Decode(
    'CgtGdW5kaW5nU2hpbRI+Cg9jaGFuX3BvaW50X3NoaW0YASABKAsyFC5sbnJwYy5DaGFuUG9pbn'
    'RTaGltSABSDWNoYW5Qb2ludFNoaW0SLgoJcHNidF9zaGltGAIgASgLMg8ubG5ycGMuUHNidFNo'
    'aW1IAFIIcHNidFNoaW1CBgoEc2hpbQ==');

@$core.Deprecated('Use fundingShimCancelDescriptor instead')
const FundingShimCancel$json = {
  '1': 'FundingShimCancel',
  '2': [
    {'1': 'pending_chan_id', '3': 1, '4': 1, '5': 12, '10': 'pendingChanId'},
  ],
};

/// Descriptor for `FundingShimCancel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingShimCancelDescriptor = $convert.base64Decode(
    'ChFGdW5kaW5nU2hpbUNhbmNlbBImCg9wZW5kaW5nX2NoYW5faWQYASABKAxSDXBlbmRpbmdDaG'
    'FuSWQ=');

@$core.Deprecated('Use fundingPsbtVerifyDescriptor instead')
const FundingPsbtVerify$json = {
  '1': 'FundingPsbtVerify',
  '2': [
    {'1': 'funded_psbt', '3': 1, '4': 1, '5': 12, '10': 'fundedPsbt'},
    {'1': 'pending_chan_id', '3': 2, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'skip_finalize', '3': 3, '4': 1, '5': 8, '10': 'skipFinalize'},
  ],
};

/// Descriptor for `FundingPsbtVerify`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingPsbtVerifyDescriptor = $convert.base64Decode(
    'ChFGdW5kaW5nUHNidFZlcmlmeRIfCgtmdW5kZWRfcHNidBgBIAEoDFIKZnVuZGVkUHNidBImCg'
    '9wZW5kaW5nX2NoYW5faWQYAiABKAxSDXBlbmRpbmdDaGFuSWQSIwoNc2tpcF9maW5hbGl6ZRgD'
    'IAEoCFIMc2tpcEZpbmFsaXpl');

@$core.Deprecated('Use fundingPsbtFinalizeDescriptor instead')
const FundingPsbtFinalize$json = {
  '1': 'FundingPsbtFinalize',
  '2': [
    {'1': 'signed_psbt', '3': 1, '4': 1, '5': 12, '10': 'signedPsbt'},
    {'1': 'pending_chan_id', '3': 2, '4': 1, '5': 12, '10': 'pendingChanId'},
    {'1': 'final_raw_tx', '3': 3, '4': 1, '5': 12, '10': 'finalRawTx'},
  ],
};

/// Descriptor for `FundingPsbtFinalize`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingPsbtFinalizeDescriptor = $convert.base64Decode(
    'ChNGdW5kaW5nUHNidEZpbmFsaXplEh8KC3NpZ25lZF9wc2J0GAEgASgMUgpzaWduZWRQc2J0Ei'
    'YKD3BlbmRpbmdfY2hhbl9pZBgCIAEoDFINcGVuZGluZ0NoYW5JZBIgCgxmaW5hbF9yYXdfdHgY'
    'AyABKAxSCmZpbmFsUmF3VHg=');

@$core.Deprecated('Use fundingTransitionMsgDescriptor instead')
const FundingTransitionMsg$json = {
  '1': 'FundingTransitionMsg',
  '2': [
    {'1': 'shim_register', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.FundingShim', '9': 0, '10': 'shimRegister'},
    {'1': 'shim_cancel', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.FundingShimCancel', '9': 0, '10': 'shimCancel'},
    {'1': 'psbt_verify', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.FundingPsbtVerify', '9': 0, '10': 'psbtVerify'},
    {'1': 'psbt_finalize', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.FundingPsbtFinalize', '9': 0, '10': 'psbtFinalize'},
  ],
  '8': [
    {'1': 'trigger'},
  ],
};

/// Descriptor for `FundingTransitionMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingTransitionMsgDescriptor = $convert.base64Decode(
    'ChRGdW5kaW5nVHJhbnNpdGlvbk1zZxI5Cg1zaGltX3JlZ2lzdGVyGAEgASgLMhIubG5ycGMuRn'
    'VuZGluZ1NoaW1IAFIMc2hpbVJlZ2lzdGVyEjsKC3NoaW1fY2FuY2VsGAIgASgLMhgubG5ycGMu'
    'RnVuZGluZ1NoaW1DYW5jZWxIAFIKc2hpbUNhbmNlbBI7Cgtwc2J0X3ZlcmlmeRgDIAEoCzIYLm'
    'xucnBjLkZ1bmRpbmdQc2J0VmVyaWZ5SABSCnBzYnRWZXJpZnkSQQoNcHNidF9maW5hbGl6ZRgE'
    'IAEoCzIaLmxucnBjLkZ1bmRpbmdQc2J0RmluYWxpemVIAFIMcHNidEZpbmFsaXplQgkKB3RyaW'
    'dnZXI=');

@$core.Deprecated('Use fundingStateStepRespDescriptor instead')
const FundingStateStepResp$json = {
  '1': 'FundingStateStepResp',
};

/// Descriptor for `FundingStateStepResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundingStateStepRespDescriptor = $convert.base64Decode(
    'ChRGdW5kaW5nU3RhdGVTdGVwUmVzcA==');

@$core.Deprecated('Use pendingHTLCDescriptor instead')
const PendingHTLC$json = {
  '1': 'PendingHTLC',
  '2': [
    {'1': 'incoming', '3': 1, '4': 1, '5': 8, '10': 'incoming'},
    {'1': 'amount', '3': 2, '4': 1, '5': 3, '10': 'amount'},
    {'1': 'outpoint', '3': 3, '4': 1, '5': 9, '10': 'outpoint'},
    {'1': 'maturity_height', '3': 4, '4': 1, '5': 13, '10': 'maturityHeight'},
    {'1': 'blocks_til_maturity', '3': 5, '4': 1, '5': 5, '10': 'blocksTilMaturity'},
    {'1': 'stage', '3': 6, '4': 1, '5': 13, '10': 'stage'},
  ],
};

/// Descriptor for `PendingHTLC`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingHTLCDescriptor = $convert.base64Decode(
    'CgtQZW5kaW5nSFRMQxIaCghpbmNvbWluZxgBIAEoCFIIaW5jb21pbmcSFgoGYW1vdW50GAIgAS'
    'gDUgZhbW91bnQSGgoIb3V0cG9pbnQYAyABKAlSCG91dHBvaW50EicKD21hdHVyaXR5X2hlaWdo'
    'dBgEIAEoDVIObWF0dXJpdHlIZWlnaHQSLgoTYmxvY2tzX3RpbF9tYXR1cml0eRgFIAEoBVIRYm'
    'xvY2tzVGlsTWF0dXJpdHkSFAoFc3RhZ2UYBiABKA1SBXN0YWdl');

@$core.Deprecated('Use pendingChannelsRequestDescriptor instead')
const PendingChannelsRequest$json = {
  '1': 'PendingChannelsRequest',
  '2': [
    {'1': 'include_raw_tx', '3': 1, '4': 1, '5': 8, '10': 'includeRawTx'},
  ],
};

/// Descriptor for `PendingChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingChannelsRequestDescriptor = $convert.base64Decode(
    'ChZQZW5kaW5nQ2hhbm5lbHNSZXF1ZXN0EiQKDmluY2x1ZGVfcmF3X3R4GAEgASgIUgxpbmNsdW'
    'RlUmF3VHg=');

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse$json = {
  '1': 'PendingChannelsResponse',
  '2': [
    {'1': 'total_limbo_balance', '3': 1, '4': 1, '5': 3, '10': 'totalLimboBalance'},
    {'1': 'pending_open_channels', '3': 2, '4': 3, '5': 11, '6': '.lnrpc.PendingChannelsResponse.PendingOpenChannel', '10': 'pendingOpenChannels'},
    {
      '1': 'pending_closing_channels',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.lnrpc.PendingChannelsResponse.ClosedChannel',
      '8': {'3': true},
      '10': 'pendingClosingChannels',
    },
    {'1': 'pending_force_closing_channels', '3': 4, '4': 3, '5': 11, '6': '.lnrpc.PendingChannelsResponse.ForceClosedChannel', '10': 'pendingForceClosingChannels'},
    {'1': 'waiting_close_channels', '3': 5, '4': 3, '5': 11, '6': '.lnrpc.PendingChannelsResponse.WaitingCloseChannel', '10': 'waitingCloseChannels'},
  ],
  '3': [PendingChannelsResponse_PendingChannel$json, PendingChannelsResponse_PendingOpenChannel$json, PendingChannelsResponse_WaitingCloseChannel$json, PendingChannelsResponse_Commitments$json, PendingChannelsResponse_ClosedChannel$json, PendingChannelsResponse_ForceClosedChannel$json],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_PendingChannel$json = {
  '1': 'PendingChannel',
  '2': [
    {'1': 'remote_node_pub', '3': 1, '4': 1, '5': 9, '10': 'remoteNodePub'},
    {'1': 'channel_point', '3': 2, '4': 1, '5': 9, '10': 'channelPoint'},
    {'1': 'capacity', '3': 3, '4': 1, '5': 3, '10': 'capacity'},
    {'1': 'local_balance', '3': 4, '4': 1, '5': 3, '10': 'localBalance'},
    {'1': 'remote_balance', '3': 5, '4': 1, '5': 3, '10': 'remoteBalance'},
    {'1': 'local_chan_reserve_sat', '3': 6, '4': 1, '5': 3, '10': 'localChanReserveSat'},
    {'1': 'remote_chan_reserve_sat', '3': 7, '4': 1, '5': 3, '10': 'remoteChanReserveSat'},
    {'1': 'initiator', '3': 8, '4': 1, '5': 14, '6': '.lnrpc.Initiator', '10': 'initiator'},
    {'1': 'commitment_type', '3': 9, '4': 1, '5': 14, '6': '.lnrpc.CommitmentType', '10': 'commitmentType'},
    {'1': 'num_forwarding_packages', '3': 10, '4': 1, '5': 3, '10': 'numForwardingPackages'},
    {'1': 'chan_status_flags', '3': 11, '4': 1, '5': 9, '10': 'chanStatusFlags'},
    {'1': 'private', '3': 12, '4': 1, '5': 8, '10': 'private'},
    {'1': 'memo', '3': 13, '4': 1, '5': 9, '10': 'memo'},
    {'1': 'custom_channel_data', '3': 34, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_PendingOpenChannel$json = {
  '1': 'PendingOpenChannel',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.PendingChannelsResponse.PendingChannel', '10': 'channel'},
    {'1': 'commit_fee', '3': 4, '4': 1, '5': 3, '10': 'commitFee'},
    {'1': 'commit_weight', '3': 5, '4': 1, '5': 3, '10': 'commitWeight'},
    {'1': 'fee_per_kw', '3': 6, '4': 1, '5': 3, '10': 'feePerKw'},
    {'1': 'funding_expiry_blocks', '3': 3, '4': 1, '5': 5, '10': 'fundingExpiryBlocks'},
  ],
  '9': [
    {'1': 2, '2': 3},
  ],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_WaitingCloseChannel$json = {
  '1': 'WaitingCloseChannel',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.PendingChannelsResponse.PendingChannel', '10': 'channel'},
    {'1': 'limbo_balance', '3': 2, '4': 1, '5': 3, '10': 'limboBalance'},
    {'1': 'commitments', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.PendingChannelsResponse.Commitments', '10': 'commitments'},
    {'1': 'closing_txid', '3': 4, '4': 1, '5': 9, '10': 'closingTxid'},
    {'1': 'closing_tx_hex', '3': 5, '4': 1, '5': 9, '10': 'closingTxHex'},
  ],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_Commitments$json = {
  '1': 'Commitments',
  '2': [
    {'1': 'local_txid', '3': 1, '4': 1, '5': 9, '10': 'localTxid'},
    {'1': 'remote_txid', '3': 2, '4': 1, '5': 9, '10': 'remoteTxid'},
    {'1': 'remote_pending_txid', '3': 3, '4': 1, '5': 9, '10': 'remotePendingTxid'},
    {'1': 'local_commit_fee_sat', '3': 4, '4': 1, '5': 4, '10': 'localCommitFeeSat'},
    {'1': 'remote_commit_fee_sat', '3': 5, '4': 1, '5': 4, '10': 'remoteCommitFeeSat'},
    {'1': 'remote_pending_commit_fee_sat', '3': 6, '4': 1, '5': 4, '10': 'remotePendingCommitFeeSat'},
  ],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_ClosedChannel$json = {
  '1': 'ClosedChannel',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.PendingChannelsResponse.PendingChannel', '10': 'channel'},
    {'1': 'closing_txid', '3': 2, '4': 1, '5': 9, '10': 'closingTxid'},
  ],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_ForceClosedChannel$json = {
  '1': 'ForceClosedChannel',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.PendingChannelsResponse.PendingChannel', '10': 'channel'},
    {'1': 'closing_txid', '3': 2, '4': 1, '5': 9, '10': 'closingTxid'},
    {'1': 'limbo_balance', '3': 3, '4': 1, '5': 3, '10': 'limboBalance'},
    {'1': 'maturity_height', '3': 4, '4': 1, '5': 13, '10': 'maturityHeight'},
    {'1': 'blocks_til_maturity', '3': 5, '4': 1, '5': 5, '10': 'blocksTilMaturity'},
    {'1': 'recovered_balance', '3': 6, '4': 1, '5': 3, '10': 'recoveredBalance'},
    {'1': 'pending_htlcs', '3': 8, '4': 3, '5': 11, '6': '.lnrpc.PendingHTLC', '10': 'pendingHtlcs'},
    {'1': 'anchor', '3': 9, '4': 1, '5': 14, '6': '.lnrpc.PendingChannelsResponse.ForceClosedChannel.AnchorState', '10': 'anchor'},
  ],
  '4': [PendingChannelsResponse_ForceClosedChannel_AnchorState$json],
};

@$core.Deprecated('Use pendingChannelsResponseDescriptor instead')
const PendingChannelsResponse_ForceClosedChannel_AnchorState$json = {
  '1': 'AnchorState',
  '2': [
    {'1': 'LIMBO', '2': 0},
    {'1': 'RECOVERED', '2': 1},
    {'1': 'LOST', '2': 2},
  ],
};

/// Descriptor for `PendingChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pendingChannelsResponseDescriptor = $convert.base64Decode(
    'ChdQZW5kaW5nQ2hhbm5lbHNSZXNwb25zZRIuChN0b3RhbF9saW1ib19iYWxhbmNlGAEgASgDUh'
    'F0b3RhbExpbWJvQmFsYW5jZRJlChVwZW5kaW5nX29wZW5fY2hhbm5lbHMYAiADKAsyMS5sbnJw'
    'Yy5QZW5kaW5nQ2hhbm5lbHNSZXNwb25zZS5QZW5kaW5nT3BlbkNoYW5uZWxSE3BlbmRpbmdPcG'
    'VuQ2hhbm5lbHMSagoYcGVuZGluZ19jbG9zaW5nX2NoYW5uZWxzGAMgAygLMiwubG5ycGMuUGVu'
    'ZGluZ0NoYW5uZWxzUmVzcG9uc2UuQ2xvc2VkQ2hhbm5lbEICGAFSFnBlbmRpbmdDbG9zaW5nQ2'
    'hhbm5lbHMSdgoecGVuZGluZ19mb3JjZV9jbG9zaW5nX2NoYW5uZWxzGAQgAygLMjEubG5ycGMu'
    'UGVuZGluZ0NoYW5uZWxzUmVzcG9uc2UuRm9yY2VDbG9zZWRDaGFubmVsUhtwZW5kaW5nRm9yY2'
    'VDbG9zaW5nQ2hhbm5lbHMSaAoWd2FpdGluZ19jbG9zZV9jaGFubmVscxgFIAMoCzIyLmxucnBj'
    'LlBlbmRpbmdDaGFubmVsc1Jlc3BvbnNlLldhaXRpbmdDbG9zZUNoYW5uZWxSFHdhaXRpbmdDbG'
    '9zZUNoYW5uZWxzGuMECg5QZW5kaW5nQ2hhbm5lbBImCg9yZW1vdGVfbm9kZV9wdWIYASABKAlS'
    'DXJlbW90ZU5vZGVQdWISIwoNY2hhbm5lbF9wb2ludBgCIAEoCVIMY2hhbm5lbFBvaW50EhoKCG'
    'NhcGFjaXR5GAMgASgDUghjYXBhY2l0eRIjCg1sb2NhbF9iYWxhbmNlGAQgASgDUgxsb2NhbEJh'
    'bGFuY2USJQoOcmVtb3RlX2JhbGFuY2UYBSABKANSDXJlbW90ZUJhbGFuY2USMwoWbG9jYWxfY2'
    'hhbl9yZXNlcnZlX3NhdBgGIAEoA1ITbG9jYWxDaGFuUmVzZXJ2ZVNhdBI1ChdyZW1vdGVfY2hh'
    'bl9yZXNlcnZlX3NhdBgHIAEoA1IUcmVtb3RlQ2hhblJlc2VydmVTYXQSLgoJaW5pdGlhdG9yGA'
    'ggASgOMhAubG5ycGMuSW5pdGlhdG9yUglpbml0aWF0b3ISPgoPY29tbWl0bWVudF90eXBlGAkg'
    'ASgOMhUubG5ycGMuQ29tbWl0bWVudFR5cGVSDmNvbW1pdG1lbnRUeXBlEjYKF251bV9mb3J3YX'
    'JkaW5nX3BhY2thZ2VzGAogASgDUhVudW1Gb3J3YXJkaW5nUGFja2FnZXMSKgoRY2hhbl9zdGF0'
    'dXNfZmxhZ3MYCyABKAlSD2NoYW5TdGF0dXNGbGFncxIYCgdwcml2YXRlGAwgASgIUgdwcml2YX'
    'RlEhIKBG1lbW8YDSABKAlSBG1lbW8SLgoTY3VzdG9tX2NoYW5uZWxfZGF0YRgiIAEoDFIRY3Vz'
    'dG9tQ2hhbm5lbERhdGEa+QEKElBlbmRpbmdPcGVuQ2hhbm5lbBJHCgdjaGFubmVsGAEgASgLMi'
    '0ubG5ycGMuUGVuZGluZ0NoYW5uZWxzUmVzcG9uc2UuUGVuZGluZ0NoYW5uZWxSB2NoYW5uZWwS'
    'HQoKY29tbWl0X2ZlZRgEIAEoA1IJY29tbWl0RmVlEiMKDWNvbW1pdF93ZWlnaHQYBSABKANSDG'
    'NvbW1pdFdlaWdodBIcCgpmZWVfcGVyX2t3GAYgASgDUghmZWVQZXJLdxIyChVmdW5kaW5nX2V4'
    'cGlyeV9ibG9ja3MYAyABKAVSE2Z1bmRpbmdFeHBpcnlCbG9ja3NKBAgCEAMamgIKE1dhaXRpbm'
    'dDbG9zZUNoYW5uZWwSRwoHY2hhbm5lbBgBIAEoCzItLmxucnBjLlBlbmRpbmdDaGFubmVsc1Jl'
    'c3BvbnNlLlBlbmRpbmdDaGFubmVsUgdjaGFubmVsEiMKDWxpbWJvX2JhbGFuY2UYAiABKANSDG'
    'xpbWJvQmFsYW5jZRJMCgtjb21taXRtZW50cxgDIAEoCzIqLmxucnBjLlBlbmRpbmdDaGFubmVs'
    'c1Jlc3BvbnNlLkNvbW1pdG1lbnRzUgtjb21taXRtZW50cxIhCgxjbG9zaW5nX3R4aWQYBCABKA'
    'lSC2Nsb3NpbmdUeGlkEiQKDmNsb3NpbmdfdHhfaGV4GAUgASgJUgxjbG9zaW5nVHhIZXgaowIK'
    'C0NvbW1pdG1lbnRzEh0KCmxvY2FsX3R4aWQYASABKAlSCWxvY2FsVHhpZBIfCgtyZW1vdGVfdH'
    'hpZBgCIAEoCVIKcmVtb3RlVHhpZBIuChNyZW1vdGVfcGVuZGluZ190eGlkGAMgASgJUhFyZW1v'
    'dGVQZW5kaW5nVHhpZBIvChRsb2NhbF9jb21taXRfZmVlX3NhdBgEIAEoBFIRbG9jYWxDb21taX'
    'RGZWVTYXQSMQoVcmVtb3RlX2NvbW1pdF9mZWVfc2F0GAUgASgEUhJyZW1vdGVDb21taXRGZWVT'
    'YXQSQAodcmVtb3RlX3BlbmRpbmdfY29tbWl0X2ZlZV9zYXQYBiABKARSGXJlbW90ZVBlbmRpbm'
    'dDb21taXRGZWVTYXQaewoNQ2xvc2VkQ2hhbm5lbBJHCgdjaGFubmVsGAEgASgLMi0ubG5ycGMu'
    'UGVuZGluZ0NoYW5uZWxzUmVzcG9uc2UuUGVuZGluZ0NoYW5uZWxSB2NoYW5uZWwSIQoMY2xvc2'
    'luZ190eGlkGAIgASgJUgtjbG9zaW5nVHhpZBruAwoSRm9yY2VDbG9zZWRDaGFubmVsEkcKB2No'
    'YW5uZWwYASABKAsyLS5sbnJwYy5QZW5kaW5nQ2hhbm5lbHNSZXNwb25zZS5QZW5kaW5nQ2hhbm'
    '5lbFIHY2hhbm5lbBIhCgxjbG9zaW5nX3R4aWQYAiABKAlSC2Nsb3NpbmdUeGlkEiMKDWxpbWJv'
    'X2JhbGFuY2UYAyABKANSDGxpbWJvQmFsYW5jZRInCg9tYXR1cml0eV9oZWlnaHQYBCABKA1SDm'
    '1hdHVyaXR5SGVpZ2h0Ei4KE2Jsb2Nrc190aWxfbWF0dXJpdHkYBSABKAVSEWJsb2Nrc1RpbE1h'
    'dHVyaXR5EisKEXJlY292ZXJlZF9iYWxhbmNlGAYgASgDUhByZWNvdmVyZWRCYWxhbmNlEjcKDX'
    'BlbmRpbmdfaHRsY3MYCCADKAsyEi5sbnJwYy5QZW5kaW5nSFRMQ1IMcGVuZGluZ0h0bGNzElUK'
    'BmFuY2hvchgJIAEoDjI9LmxucnBjLlBlbmRpbmdDaGFubmVsc1Jlc3BvbnNlLkZvcmNlQ2xvc2'
    'VkQ2hhbm5lbC5BbmNob3JTdGF0ZVIGYW5jaG9yIjEKC0FuY2hvclN0YXRlEgkKBUxJTUJPEAAS'
    'DQoJUkVDT1ZFUkVEEAESCAoETE9TVBAC');

@$core.Deprecated('Use channelEventSubscriptionDescriptor instead')
const ChannelEventSubscription$json = {
  '1': 'ChannelEventSubscription',
};

/// Descriptor for `ChannelEventSubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelEventSubscriptionDescriptor = $convert.base64Decode(
    'ChhDaGFubmVsRXZlbnRTdWJzY3JpcHRpb24=');

@$core.Deprecated('Use channelEventUpdateDescriptor instead')
const ChannelEventUpdate$json = {
  '1': 'ChannelEventUpdate',
  '2': [
    {'1': 'open_channel', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.Channel', '9': 0, '10': 'openChannel'},
    {'1': 'closed_channel', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.ChannelCloseSummary', '9': 0, '10': 'closedChannel'},
    {'1': 'active_channel', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '9': 0, '10': 'activeChannel'},
    {'1': 'inactive_channel', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '9': 0, '10': 'inactiveChannel'},
    {'1': 'pending_open_channel', '3': 6, '4': 1, '5': 11, '6': '.lnrpc.PendingUpdate', '9': 0, '10': 'pendingOpenChannel'},
    {'1': 'fully_resolved_channel', '3': 7, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '9': 0, '10': 'fullyResolvedChannel'},
    {'1': 'type', '3': 5, '4': 1, '5': 14, '6': '.lnrpc.ChannelEventUpdate.UpdateType', '10': 'type'},
  ],
  '4': [ChannelEventUpdate_UpdateType$json],
  '8': [
    {'1': 'channel'},
  ],
};

@$core.Deprecated('Use channelEventUpdateDescriptor instead')
const ChannelEventUpdate_UpdateType$json = {
  '1': 'UpdateType',
  '2': [
    {'1': 'OPEN_CHANNEL', '2': 0},
    {'1': 'CLOSED_CHANNEL', '2': 1},
    {'1': 'ACTIVE_CHANNEL', '2': 2},
    {'1': 'INACTIVE_CHANNEL', '2': 3},
    {'1': 'PENDING_OPEN_CHANNEL', '2': 4},
    {'1': 'FULLY_RESOLVED_CHANNEL', '2': 5},
  ],
};

/// Descriptor for `ChannelEventUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelEventUpdateDescriptor = $convert.base64Decode(
    'ChJDaGFubmVsRXZlbnRVcGRhdGUSMwoMb3Blbl9jaGFubmVsGAEgASgLMg4ubG5ycGMuQ2hhbm'
    '5lbEgAUgtvcGVuQ2hhbm5lbBJDCg5jbG9zZWRfY2hhbm5lbBgCIAEoCzIaLmxucnBjLkNoYW5u'
    'ZWxDbG9zZVN1bW1hcnlIAFINY2xvc2VkQ2hhbm5lbBI8Cg5hY3RpdmVfY2hhbm5lbBgDIAEoCz'
    'ITLmxucnBjLkNoYW5uZWxQb2ludEgAUg1hY3RpdmVDaGFubmVsEkAKEGluYWN0aXZlX2NoYW5u'
    'ZWwYBCABKAsyEy5sbnJwYy5DaGFubmVsUG9pbnRIAFIPaW5hY3RpdmVDaGFubmVsEkgKFHBlbm'
    'Rpbmdfb3Blbl9jaGFubmVsGAYgASgLMhQubG5ycGMuUGVuZGluZ1VwZGF0ZUgAUhJwZW5kaW5n'
    'T3BlbkNoYW5uZWwSSwoWZnVsbHlfcmVzb2x2ZWRfY2hhbm5lbBgHIAEoCzITLmxucnBjLkNoYW'
    '5uZWxQb2ludEgAUhRmdWxseVJlc29sdmVkQ2hhbm5lbBI4CgR0eXBlGAUgASgOMiQubG5ycGMu'
    'Q2hhbm5lbEV2ZW50VXBkYXRlLlVwZGF0ZVR5cGVSBHR5cGUikgEKClVwZGF0ZVR5cGUSEAoMT1'
    'BFTl9DSEFOTkVMEAASEgoOQ0xPU0VEX0NIQU5ORUwQARISCg5BQ1RJVkVfQ0hBTk5FTBACEhQK'
    'EElOQUNUSVZFX0NIQU5ORUwQAxIYChRQRU5ESU5HX09QRU5fQ0hBTk5FTBAEEhoKFkZVTExZX1'
    'JFU09MVkVEX0NIQU5ORUwQBUIJCgdjaGFubmVs');

@$core.Deprecated('Use walletAccountBalanceDescriptor instead')
const WalletAccountBalance$json = {
  '1': 'WalletAccountBalance',
  '2': [
    {'1': 'confirmed_balance', '3': 1, '4': 1, '5': 3, '10': 'confirmedBalance'},
    {'1': 'unconfirmed_balance', '3': 2, '4': 1, '5': 3, '10': 'unconfirmedBalance'},
  ],
};

/// Descriptor for `WalletAccountBalance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletAccountBalanceDescriptor = $convert.base64Decode(
    'ChRXYWxsZXRBY2NvdW50QmFsYW5jZRIrChFjb25maXJtZWRfYmFsYW5jZRgBIAEoA1IQY29uZm'
    'lybWVkQmFsYW5jZRIvChN1bmNvbmZpcm1lZF9iYWxhbmNlGAIgASgDUhJ1bmNvbmZpcm1lZEJh'
    'bGFuY2U=');

@$core.Deprecated('Use walletBalanceRequestDescriptor instead')
const WalletBalanceRequest$json = {
  '1': 'WalletBalanceRequest',
  '2': [
    {'1': 'account', '3': 1, '4': 1, '5': 9, '10': 'account'},
    {'1': 'min_confs', '3': 2, '4': 1, '5': 5, '10': 'minConfs'},
  ],
};

/// Descriptor for `WalletBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletBalanceRequestDescriptor = $convert.base64Decode(
    'ChRXYWxsZXRCYWxhbmNlUmVxdWVzdBIYCgdhY2NvdW50GAEgASgJUgdhY2NvdW50EhsKCW1pbl'
    '9jb25mcxgCIAEoBVIIbWluQ29uZnM=');

@$core.Deprecated('Use walletBalanceResponseDescriptor instead')
const WalletBalanceResponse$json = {
  '1': 'WalletBalanceResponse',
  '2': [
    {'1': 'total_balance', '3': 1, '4': 1, '5': 3, '10': 'totalBalance'},
    {'1': 'confirmed_balance', '3': 2, '4': 1, '5': 3, '10': 'confirmedBalance'},
    {'1': 'unconfirmed_balance', '3': 3, '4': 1, '5': 3, '10': 'unconfirmedBalance'},
    {'1': 'locked_balance', '3': 5, '4': 1, '5': 3, '10': 'lockedBalance'},
    {'1': 'reserved_balance_anchor_chan', '3': 6, '4': 1, '5': 3, '10': 'reservedBalanceAnchorChan'},
    {'1': 'account_balance', '3': 4, '4': 3, '5': 11, '6': '.lnrpc.WalletBalanceResponse.AccountBalanceEntry', '10': 'accountBalance'},
  ],
  '3': [WalletBalanceResponse_AccountBalanceEntry$json],
};

@$core.Deprecated('Use walletBalanceResponseDescriptor instead')
const WalletBalanceResponse_AccountBalanceEntry$json = {
  '1': 'AccountBalanceEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.WalletAccountBalance', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `WalletBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List walletBalanceResponseDescriptor = $convert.base64Decode(
    'ChVXYWxsZXRCYWxhbmNlUmVzcG9uc2USIwoNdG90YWxfYmFsYW5jZRgBIAEoA1IMdG90YWxCYW'
    'xhbmNlEisKEWNvbmZpcm1lZF9iYWxhbmNlGAIgASgDUhBjb25maXJtZWRCYWxhbmNlEi8KE3Vu'
    'Y29uZmlybWVkX2JhbGFuY2UYAyABKANSEnVuY29uZmlybWVkQmFsYW5jZRIlCg5sb2NrZWRfYm'
    'FsYW5jZRgFIAEoA1INbG9ja2VkQmFsYW5jZRI/ChxyZXNlcnZlZF9iYWxhbmNlX2FuY2hvcl9j'
    'aGFuGAYgASgDUhlyZXNlcnZlZEJhbGFuY2VBbmNob3JDaGFuElkKD2FjY291bnRfYmFsYW5jZR'
    'gEIAMoCzIwLmxucnBjLldhbGxldEJhbGFuY2VSZXNwb25zZS5BY2NvdW50QmFsYW5jZUVudHJ5'
    'Ug5hY2NvdW50QmFsYW5jZRpeChNBY2NvdW50QmFsYW5jZUVudHJ5EhAKA2tleRgBIAEoCVIDa2'
    'V5EjEKBXZhbHVlGAIgASgLMhsubG5ycGMuV2FsbGV0QWNjb3VudEJhbGFuY2VSBXZhbHVlOgI4'
    'AQ==');

@$core.Deprecated('Use amountDescriptor instead')
const Amount$json = {
  '1': 'Amount',
  '2': [
    {'1': 'sat', '3': 1, '4': 1, '5': 4, '10': 'sat'},
    {'1': 'msat', '3': 2, '4': 1, '5': 4, '10': 'msat'},
  ],
};

/// Descriptor for `Amount`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List amountDescriptor = $convert.base64Decode(
    'CgZBbW91bnQSEAoDc2F0GAEgASgEUgNzYXQSEgoEbXNhdBgCIAEoBFIEbXNhdA==');

@$core.Deprecated('Use channelBalanceRequestDescriptor instead')
const ChannelBalanceRequest$json = {
  '1': 'ChannelBalanceRequest',
};

/// Descriptor for `ChannelBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelBalanceRequestDescriptor = $convert.base64Decode(
    'ChVDaGFubmVsQmFsYW5jZVJlcXVlc3Q=');

@$core.Deprecated('Use channelBalanceResponseDescriptor instead')
const ChannelBalanceResponse$json = {
  '1': 'ChannelBalanceResponse',
  '2': [
    {
      '1': 'balance',
      '3': 1,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'balance',
    },
    {
      '1': 'pending_open_balance',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'pendingOpenBalance',
    },
    {'1': 'local_balance', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.Amount', '10': 'localBalance'},
    {'1': 'remote_balance', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.Amount', '10': 'remoteBalance'},
    {'1': 'unsettled_local_balance', '3': 5, '4': 1, '5': 11, '6': '.lnrpc.Amount', '10': 'unsettledLocalBalance'},
    {'1': 'unsettled_remote_balance', '3': 6, '4': 1, '5': 11, '6': '.lnrpc.Amount', '10': 'unsettledRemoteBalance'},
    {'1': 'pending_open_local_balance', '3': 7, '4': 1, '5': 11, '6': '.lnrpc.Amount', '10': 'pendingOpenLocalBalance'},
    {'1': 'pending_open_remote_balance', '3': 8, '4': 1, '5': 11, '6': '.lnrpc.Amount', '10': 'pendingOpenRemoteBalance'},
    {'1': 'custom_channel_data', '3': 9, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
};

/// Descriptor for `ChannelBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelBalanceResponseDescriptor = $convert.base64Decode(
    'ChZDaGFubmVsQmFsYW5jZVJlc3BvbnNlEhwKB2JhbGFuY2UYASABKANCAhgBUgdiYWxhbmNlEj'
    'QKFHBlbmRpbmdfb3Blbl9iYWxhbmNlGAIgASgDQgIYAVIScGVuZGluZ09wZW5CYWxhbmNlEjIK'
    'DWxvY2FsX2JhbGFuY2UYAyABKAsyDS5sbnJwYy5BbW91bnRSDGxvY2FsQmFsYW5jZRI0Cg5yZW'
    '1vdGVfYmFsYW5jZRgEIAEoCzINLmxucnBjLkFtb3VudFINcmVtb3RlQmFsYW5jZRJFChd1bnNl'
    'dHRsZWRfbG9jYWxfYmFsYW5jZRgFIAEoCzINLmxucnBjLkFtb3VudFIVdW5zZXR0bGVkTG9jYW'
    'xCYWxhbmNlEkcKGHVuc2V0dGxlZF9yZW1vdGVfYmFsYW5jZRgGIAEoCzINLmxucnBjLkFtb3Vu'
    'dFIWdW5zZXR0bGVkUmVtb3RlQmFsYW5jZRJKChpwZW5kaW5nX29wZW5fbG9jYWxfYmFsYW5jZR'
    'gHIAEoCzINLmxucnBjLkFtb3VudFIXcGVuZGluZ09wZW5Mb2NhbEJhbGFuY2USTAobcGVuZGlu'
    'Z19vcGVuX3JlbW90ZV9iYWxhbmNlGAggASgLMg0ubG5ycGMuQW1vdW50UhhwZW5kaW5nT3Blbl'
    'JlbW90ZUJhbGFuY2USLgoTY3VzdG9tX2NoYW5uZWxfZGF0YRgJIAEoDFIRY3VzdG9tQ2hhbm5l'
    'bERhdGE=');

@$core.Deprecated('Use queryRoutesRequestDescriptor instead')
const QueryRoutesRequest$json = {
  '1': 'QueryRoutesRequest',
  '2': [
    {'1': 'pub_key', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
    {'1': 'amt', '3': 2, '4': 1, '5': 3, '10': 'amt'},
    {'1': 'amt_msat', '3': 12, '4': 1, '5': 3, '10': 'amtMsat'},
    {'1': 'final_cltv_delta', '3': 4, '4': 1, '5': 5, '10': 'finalCltvDelta'},
    {'1': 'fee_limit', '3': 5, '4': 1, '5': 11, '6': '.lnrpc.FeeLimit', '10': 'feeLimit'},
    {'1': 'ignored_nodes', '3': 6, '4': 3, '5': 12, '10': 'ignoredNodes'},
    {
      '1': 'ignored_edges',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.lnrpc.EdgeLocator',
      '8': {'3': true},
      '10': 'ignoredEdges',
    },
    {'1': 'source_pub_key', '3': 8, '4': 1, '5': 9, '10': 'sourcePubKey'},
    {'1': 'use_mission_control', '3': 9, '4': 1, '5': 8, '10': 'useMissionControl'},
    {'1': 'ignored_pairs', '3': 10, '4': 3, '5': 11, '6': '.lnrpc.NodePair', '10': 'ignoredPairs'},
    {'1': 'cltv_limit', '3': 11, '4': 1, '5': 13, '10': 'cltvLimit'},
    {'1': 'dest_custom_records', '3': 13, '4': 3, '5': 11, '6': '.lnrpc.QueryRoutesRequest.DestCustomRecordsEntry', '10': 'destCustomRecords'},
    {
      '1': 'outgoing_chan_id',
      '3': 14,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'outgoingChanId',
    },
    {'1': 'last_hop_pubkey', '3': 15, '4': 1, '5': 12, '10': 'lastHopPubkey'},
    {'1': 'route_hints', '3': 16, '4': 3, '5': 11, '6': '.lnrpc.RouteHint', '10': 'routeHints'},
    {'1': 'blinded_payment_paths', '3': 19, '4': 3, '5': 11, '6': '.lnrpc.BlindedPaymentPath', '10': 'blindedPaymentPaths'},
    {'1': 'dest_features', '3': 17, '4': 3, '5': 14, '6': '.lnrpc.FeatureBit', '10': 'destFeatures'},
    {'1': 'time_pref', '3': 18, '4': 1, '5': 1, '10': 'timePref'},
  ],
  '3': [QueryRoutesRequest_DestCustomRecordsEntry$json],
  '9': [
    {'1': 3, '2': 4},
  ],
};

@$core.Deprecated('Use queryRoutesRequestDescriptor instead')
const QueryRoutesRequest_DestCustomRecordsEntry$json = {
  '1': 'DestCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `QueryRoutesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryRoutesRequestDescriptor = $convert.base64Decode(
    'ChJRdWVyeVJvdXRlc1JlcXVlc3QSFwoHcHViX2tleRgBIAEoCVIGcHViS2V5EhAKA2FtdBgCIA'
    'EoA1IDYW10EhkKCGFtdF9tc2F0GAwgASgDUgdhbXRNc2F0EigKEGZpbmFsX2NsdHZfZGVsdGEY'
    'BCABKAVSDmZpbmFsQ2x0dkRlbHRhEiwKCWZlZV9saW1pdBgFIAEoCzIPLmxucnBjLkZlZUxpbW'
    'l0UghmZWVMaW1pdBIjCg1pZ25vcmVkX25vZGVzGAYgAygMUgxpZ25vcmVkTm9kZXMSOwoNaWdu'
    'b3JlZF9lZGdlcxgHIAMoCzISLmxucnBjLkVkZ2VMb2NhdG9yQgIYAVIMaWdub3JlZEVkZ2VzEi'
    'QKDnNvdXJjZV9wdWJfa2V5GAggASgJUgxzb3VyY2VQdWJLZXkSLgoTdXNlX21pc3Npb25fY29u'
    'dHJvbBgJIAEoCFIRdXNlTWlzc2lvbkNvbnRyb2wSNAoNaWdub3JlZF9wYWlycxgKIAMoCzIPLm'
    'xucnBjLk5vZGVQYWlyUgxpZ25vcmVkUGFpcnMSHQoKY2x0dl9saW1pdBgLIAEoDVIJY2x0dkxp'
    'bWl0EmAKE2Rlc3RfY3VzdG9tX3JlY29yZHMYDSADKAsyMC5sbnJwYy5RdWVyeVJvdXRlc1JlcX'
    'Vlc3QuRGVzdEN1c3RvbVJlY29yZHNFbnRyeVIRZGVzdEN1c3RvbVJlY29yZHMSLAoQb3V0Z29p'
    'bmdfY2hhbl9pZBgOIAEoBEICMAFSDm91dGdvaW5nQ2hhbklkEiYKD2xhc3RfaG9wX3B1YmtleR'
    'gPIAEoDFINbGFzdEhvcFB1YmtleRIxCgtyb3V0ZV9oaW50cxgQIAMoCzIQLmxucnBjLlJvdXRl'
    'SGludFIKcm91dGVIaW50cxJNChVibGluZGVkX3BheW1lbnRfcGF0aHMYEyADKAsyGS5sbnJwYy'
    '5CbGluZGVkUGF5bWVudFBhdGhSE2JsaW5kZWRQYXltZW50UGF0aHMSNgoNZGVzdF9mZWF0dXJl'
    'cxgRIAMoDjIRLmxucnBjLkZlYXR1cmVCaXRSDGRlc3RGZWF0dXJlcxIbCgl0aW1lX3ByZWYYEi'
    'ABKAFSCHRpbWVQcmVmGkQKFkRlc3RDdXN0b21SZWNvcmRzRW50cnkSEAoDa2V5GAEgASgEUgNr'
    'ZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4AUoECAMQBA==');

@$core.Deprecated('Use nodePairDescriptor instead')
const NodePair$json = {
  '1': 'NodePair',
  '2': [
    {'1': 'from', '3': 1, '4': 1, '5': 12, '10': 'from'},
    {'1': 'to', '3': 2, '4': 1, '5': 12, '10': 'to'},
  ],
};

/// Descriptor for `NodePair`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodePairDescriptor = $convert.base64Decode(
    'CghOb2RlUGFpchISCgRmcm9tGAEgASgMUgRmcm9tEg4KAnRvGAIgASgMUgJ0bw==');

@$core.Deprecated('Use edgeLocatorDescriptor instead')
const EdgeLocator$json = {
  '1': 'EdgeLocator',
  '2': [
    {
      '1': 'channel_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'channelId',
    },
    {'1': 'direction_reverse', '3': 2, '4': 1, '5': 8, '10': 'directionReverse'},
  ],
};

/// Descriptor for `EdgeLocator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List edgeLocatorDescriptor = $convert.base64Decode(
    'CgtFZGdlTG9jYXRvchIhCgpjaGFubmVsX2lkGAEgASgEQgIwAVIJY2hhbm5lbElkEisKEWRpcm'
    'VjdGlvbl9yZXZlcnNlGAIgASgIUhBkaXJlY3Rpb25SZXZlcnNl');

@$core.Deprecated('Use queryRoutesResponseDescriptor instead')
const QueryRoutesResponse$json = {
  '1': 'QueryRoutesResponse',
  '2': [
    {'1': 'routes', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.Route', '10': 'routes'},
    {'1': 'success_prob', '3': 2, '4': 1, '5': 1, '10': 'successProb'},
  ],
};

/// Descriptor for `QueryRoutesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryRoutesResponseDescriptor = $convert.base64Decode(
    'ChNRdWVyeVJvdXRlc1Jlc3BvbnNlEiQKBnJvdXRlcxgBIAMoCzIMLmxucnBjLlJvdXRlUgZyb3'
    'V0ZXMSIQoMc3VjY2Vzc19wcm9iGAIgASgBUgtzdWNjZXNzUHJvYg==');

@$core.Deprecated('Use hopDescriptor instead')
const Hop$json = {
  '1': 'Hop',
  '2': [
    {
      '1': 'chan_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {
      '1': 'chan_capacity',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'chanCapacity',
    },
    {
      '1': 'amt_to_forward',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'amtToForward',
    },
    {
      '1': 'fee',
      '3': 4,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'fee',
    },
    {'1': 'expiry', '3': 5, '4': 1, '5': 13, '10': 'expiry'},
    {'1': 'amt_to_forward_msat', '3': 6, '4': 1, '5': 3, '10': 'amtToForwardMsat'},
    {'1': 'fee_msat', '3': 7, '4': 1, '5': 3, '10': 'feeMsat'},
    {'1': 'pub_key', '3': 8, '4': 1, '5': 9, '10': 'pubKey'},
    {
      '1': 'tlv_payload',
      '3': 9,
      '4': 1,
      '5': 8,
      '8': {'3': true},
      '10': 'tlvPayload',
    },
    {'1': 'mpp_record', '3': 10, '4': 1, '5': 11, '6': '.lnrpc.MPPRecord', '10': 'mppRecord'},
    {'1': 'amp_record', '3': 12, '4': 1, '5': 11, '6': '.lnrpc.AMPRecord', '10': 'ampRecord'},
    {'1': 'custom_records', '3': 11, '4': 3, '5': 11, '6': '.lnrpc.Hop.CustomRecordsEntry', '10': 'customRecords'},
    {'1': 'metadata', '3': 13, '4': 1, '5': 12, '10': 'metadata'},
    {'1': 'blinding_point', '3': 14, '4': 1, '5': 12, '10': 'blindingPoint'},
    {'1': 'encrypted_data', '3': 15, '4': 1, '5': 12, '10': 'encryptedData'},
    {'1': 'total_amt_msat', '3': 16, '4': 1, '5': 4, '10': 'totalAmtMsat'},
  ],
  '3': [Hop_CustomRecordsEntry$json],
};

@$core.Deprecated('Use hopDescriptor instead')
const Hop_CustomRecordsEntry$json = {
  '1': 'CustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Hop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hopDescriptor = $convert.base64Decode(
    'CgNIb3ASGwoHY2hhbl9pZBgBIAEoBEICMAFSBmNoYW5JZBInCg1jaGFuX2NhcGFjaXR5GAIgAS'
    'gDQgIYAVIMY2hhbkNhcGFjaXR5EigKDmFtdF90b19mb3J3YXJkGAMgASgDQgIYAVIMYW10VG9G'
    'b3J3YXJkEhQKA2ZlZRgEIAEoA0ICGAFSA2ZlZRIWCgZleHBpcnkYBSABKA1SBmV4cGlyeRItCh'
    'NhbXRfdG9fZm9yd2FyZF9tc2F0GAYgASgDUhBhbXRUb0ZvcndhcmRNc2F0EhkKCGZlZV9tc2F0'
    'GAcgASgDUgdmZWVNc2F0EhcKB3B1Yl9rZXkYCCABKAlSBnB1YktleRIjCgt0bHZfcGF5bG9hZB'
    'gJIAEoCEICGAFSCnRsdlBheWxvYWQSLwoKbXBwX3JlY29yZBgKIAEoCzIQLmxucnBjLk1QUFJl'
    'Y29yZFIJbXBwUmVjb3JkEi8KCmFtcF9yZWNvcmQYDCABKAsyEC5sbnJwYy5BTVBSZWNvcmRSCW'
    'FtcFJlY29yZBJECg5jdXN0b21fcmVjb3JkcxgLIAMoCzIdLmxucnBjLkhvcC5DdXN0b21SZWNv'
    'cmRzRW50cnlSDWN1c3RvbVJlY29yZHMSGgoIbWV0YWRhdGEYDSABKAxSCG1ldGFkYXRhEiUKDm'
    'JsaW5kaW5nX3BvaW50GA4gASgMUg1ibGluZGluZ1BvaW50EiUKDmVuY3J5cHRlZF9kYXRhGA8g'
    'ASgMUg1lbmNyeXB0ZWREYXRhEiQKDnRvdGFsX2FtdF9tc2F0GBAgASgEUgx0b3RhbEFtdE1zYX'
    'QaQAoSQ3VzdG9tUmVjb3Jkc0VudHJ5EhAKA2tleRgBIAEoBFIDa2V5EhQKBXZhbHVlGAIgASgM'
    'UgV2YWx1ZToCOAE=');

@$core.Deprecated('Use mPPRecordDescriptor instead')
const MPPRecord$json = {
  '1': 'MPPRecord',
  '2': [
    {'1': 'payment_addr', '3': 11, '4': 1, '5': 12, '10': 'paymentAddr'},
    {'1': 'total_amt_msat', '3': 10, '4': 1, '5': 3, '10': 'totalAmtMsat'},
  ],
};

/// Descriptor for `MPPRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mPPRecordDescriptor = $convert.base64Decode(
    'CglNUFBSZWNvcmQSIQoMcGF5bWVudF9hZGRyGAsgASgMUgtwYXltZW50QWRkchIkCg50b3RhbF'
    '9hbXRfbXNhdBgKIAEoA1IMdG90YWxBbXRNc2F0');

@$core.Deprecated('Use aMPRecordDescriptor instead')
const AMPRecord$json = {
  '1': 'AMPRecord',
  '2': [
    {'1': 'root_share', '3': 1, '4': 1, '5': 12, '10': 'rootShare'},
    {'1': 'set_id', '3': 2, '4': 1, '5': 12, '10': 'setId'},
    {'1': 'child_index', '3': 3, '4': 1, '5': 13, '10': 'childIndex'},
  ],
};

/// Descriptor for `AMPRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aMPRecordDescriptor = $convert.base64Decode(
    'CglBTVBSZWNvcmQSHQoKcm9vdF9zaGFyZRgBIAEoDFIJcm9vdFNoYXJlEhUKBnNldF9pZBgCIA'
    'EoDFIFc2V0SWQSHwoLY2hpbGRfaW5kZXgYAyABKA1SCmNoaWxkSW5kZXg=');

@$core.Deprecated('Use routeDescriptor instead')
const Route$json = {
  '1': 'Route',
  '2': [
    {'1': 'total_time_lock', '3': 1, '4': 1, '5': 13, '10': 'totalTimeLock'},
    {
      '1': 'total_fees',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'totalFees',
    },
    {
      '1': 'total_amt',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'totalAmt',
    },
    {'1': 'hops', '3': 4, '4': 3, '5': 11, '6': '.lnrpc.Hop', '10': 'hops'},
    {'1': 'total_fees_msat', '3': 5, '4': 1, '5': 3, '10': 'totalFeesMsat'},
    {'1': 'total_amt_msat', '3': 6, '4': 1, '5': 3, '10': 'totalAmtMsat'},
    {'1': 'first_hop_amount_msat', '3': 7, '4': 1, '5': 3, '10': 'firstHopAmountMsat'},
    {'1': 'custom_channel_data', '3': 8, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
};

/// Descriptor for `Route`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeDescriptor = $convert.base64Decode(
    'CgVSb3V0ZRImCg90b3RhbF90aW1lX2xvY2sYASABKA1SDXRvdGFsVGltZUxvY2sSIQoKdG90YW'
    'xfZmVlcxgCIAEoA0ICGAFSCXRvdGFsRmVlcxIfCgl0b3RhbF9hbXQYAyABKANCAhgBUgh0b3Rh'
    'bEFtdBIeCgRob3BzGAQgAygLMgoubG5ycGMuSG9wUgRob3BzEiYKD3RvdGFsX2ZlZXNfbXNhdB'
    'gFIAEoA1INdG90YWxGZWVzTXNhdBIkCg50b3RhbF9hbXRfbXNhdBgGIAEoA1IMdG90YWxBbXRN'
    'c2F0EjEKFWZpcnN0X2hvcF9hbW91bnRfbXNhdBgHIAEoA1ISZmlyc3RIb3BBbW91bnRNc2F0Ei'
    '4KE2N1c3RvbV9jaGFubmVsX2RhdGEYCCABKAxSEWN1c3RvbUNoYW5uZWxEYXRh');

@$core.Deprecated('Use nodeInfoRequestDescriptor instead')
const NodeInfoRequest$json = {
  '1': 'NodeInfoRequest',
  '2': [
    {'1': 'pub_key', '3': 1, '4': 1, '5': 9, '10': 'pubKey'},
    {'1': 'include_channels', '3': 2, '4': 1, '5': 8, '10': 'includeChannels'},
  ],
};

/// Descriptor for `NodeInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeInfoRequestDescriptor = $convert.base64Decode(
    'Cg9Ob2RlSW5mb1JlcXVlc3QSFwoHcHViX2tleRgBIAEoCVIGcHViS2V5EikKEGluY2x1ZGVfY2'
    'hhbm5lbHMYAiABKAhSD2luY2x1ZGVDaGFubmVscw==');

@$core.Deprecated('Use nodeInfoDescriptor instead')
const NodeInfo$json = {
  '1': 'NodeInfo',
  '2': [
    {'1': 'node', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.LightningNode', '10': 'node'},
    {'1': 'num_channels', '3': 2, '4': 1, '5': 13, '10': 'numChannels'},
    {'1': 'total_capacity', '3': 3, '4': 1, '5': 3, '10': 'totalCapacity'},
    {'1': 'channels', '3': 4, '4': 3, '5': 11, '6': '.lnrpc.ChannelEdge', '10': 'channels'},
  ],
};

/// Descriptor for `NodeInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeInfoDescriptor = $convert.base64Decode(
    'CghOb2RlSW5mbxIoCgRub2RlGAEgASgLMhQubG5ycGMuTGlnaHRuaW5nTm9kZVIEbm9kZRIhCg'
    'xudW1fY2hhbm5lbHMYAiABKA1SC251bUNoYW5uZWxzEiUKDnRvdGFsX2NhcGFjaXR5GAMgASgD'
    'Ug10b3RhbENhcGFjaXR5Ei4KCGNoYW5uZWxzGAQgAygLMhIubG5ycGMuQ2hhbm5lbEVkZ2VSCG'
    'NoYW5uZWxz');

@$core.Deprecated('Use lightningNodeDescriptor instead')
const LightningNode$json = {
  '1': 'LightningNode',
  '2': [
    {'1': 'last_update', '3': 1, '4': 1, '5': 13, '10': 'lastUpdate'},
    {'1': 'pub_key', '3': 2, '4': 1, '5': 9, '10': 'pubKey'},
    {'1': 'alias', '3': 3, '4': 1, '5': 9, '10': 'alias'},
    {'1': 'addresses', '3': 4, '4': 3, '5': 11, '6': '.lnrpc.NodeAddress', '10': 'addresses'},
    {'1': 'color', '3': 5, '4': 1, '5': 9, '10': 'color'},
    {'1': 'features', '3': 6, '4': 3, '5': 11, '6': '.lnrpc.LightningNode.FeaturesEntry', '10': 'features'},
    {'1': 'custom_records', '3': 7, '4': 3, '5': 11, '6': '.lnrpc.LightningNode.CustomRecordsEntry', '10': 'customRecords'},
  ],
  '3': [LightningNode_FeaturesEntry$json, LightningNode_CustomRecordsEntry$json],
};

@$core.Deprecated('Use lightningNodeDescriptor instead')
const LightningNode_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use lightningNodeDescriptor instead')
const LightningNode_CustomRecordsEntry$json = {
  '1': 'CustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `LightningNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lightningNodeDescriptor = $convert.base64Decode(
    'Cg1MaWdodG5pbmdOb2RlEh8KC2xhc3RfdXBkYXRlGAEgASgNUgpsYXN0VXBkYXRlEhcKB3B1Yl'
    '9rZXkYAiABKAlSBnB1YktleRIUCgVhbGlhcxgDIAEoCVIFYWxpYXMSMAoJYWRkcmVzc2VzGAQg'
    'AygLMhIubG5ycGMuTm9kZUFkZHJlc3NSCWFkZHJlc3NlcxIUCgVjb2xvchgFIAEoCVIFY29sb3'
    'ISPgoIZmVhdHVyZXMYBiADKAsyIi5sbnJwYy5MaWdodG5pbmdOb2RlLkZlYXR1cmVzRW50cnlS'
    'CGZlYXR1cmVzEk4KDmN1c3RvbV9yZWNvcmRzGAcgAygLMicubG5ycGMuTGlnaHRuaW5nTm9kZS'
    '5DdXN0b21SZWNvcmRzRW50cnlSDWN1c3RvbVJlY29yZHMaSwoNRmVhdHVyZXNFbnRyeRIQCgNr'
    'ZXkYASABKA1SA2tleRIkCgV2YWx1ZRgCIAEoCzIOLmxucnBjLkZlYXR1cmVSBXZhbHVlOgI4AR'
    'pAChJDdXN0b21SZWNvcmRzRW50cnkSEAoDa2V5GAEgASgEUgNrZXkSFAoFdmFsdWUYAiABKAxS'
    'BXZhbHVlOgI4AQ==');

@$core.Deprecated('Use nodeAddressDescriptor instead')
const NodeAddress$json = {
  '1': 'NodeAddress',
  '2': [
    {'1': 'network', '3': 1, '4': 1, '5': 9, '10': 'network'},
    {'1': 'addr', '3': 2, '4': 1, '5': 9, '10': 'addr'},
  ],
};

/// Descriptor for `NodeAddress`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeAddressDescriptor = $convert.base64Decode(
    'CgtOb2RlQWRkcmVzcxIYCgduZXR3b3JrGAEgASgJUgduZXR3b3JrEhIKBGFkZHIYAiABKAlSBG'
    'FkZHI=');

@$core.Deprecated('Use routingPolicyDescriptor instead')
const RoutingPolicy$json = {
  '1': 'RoutingPolicy',
  '2': [
    {'1': 'time_lock_delta', '3': 1, '4': 1, '5': 13, '10': 'timeLockDelta'},
    {'1': 'min_htlc', '3': 2, '4': 1, '5': 3, '10': 'minHtlc'},
    {'1': 'fee_base_msat', '3': 3, '4': 1, '5': 3, '10': 'feeBaseMsat'},
    {'1': 'fee_rate_milli_msat', '3': 4, '4': 1, '5': 3, '10': 'feeRateMilliMsat'},
    {'1': 'disabled', '3': 5, '4': 1, '5': 8, '10': 'disabled'},
    {'1': 'max_htlc_msat', '3': 6, '4': 1, '5': 4, '10': 'maxHtlcMsat'},
    {'1': 'last_update', '3': 7, '4': 1, '5': 13, '10': 'lastUpdate'},
    {'1': 'custom_records', '3': 8, '4': 3, '5': 11, '6': '.lnrpc.RoutingPolicy.CustomRecordsEntry', '10': 'customRecords'},
    {'1': 'inbound_fee_base_msat', '3': 9, '4': 1, '5': 5, '10': 'inboundFeeBaseMsat'},
    {'1': 'inbound_fee_rate_milli_msat', '3': 10, '4': 1, '5': 5, '10': 'inboundFeeRateMilliMsat'},
  ],
  '3': [RoutingPolicy_CustomRecordsEntry$json],
};

@$core.Deprecated('Use routingPolicyDescriptor instead')
const RoutingPolicy_CustomRecordsEntry$json = {
  '1': 'CustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `RoutingPolicy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routingPolicyDescriptor = $convert.base64Decode(
    'Cg1Sb3V0aW5nUG9saWN5EiYKD3RpbWVfbG9ja19kZWx0YRgBIAEoDVINdGltZUxvY2tEZWx0YR'
    'IZCghtaW5faHRsYxgCIAEoA1IHbWluSHRsYxIiCg1mZWVfYmFzZV9tc2F0GAMgASgDUgtmZWVC'
    'YXNlTXNhdBItChNmZWVfcmF0ZV9taWxsaV9tc2F0GAQgASgDUhBmZWVSYXRlTWlsbGlNc2F0Eh'
    'oKCGRpc2FibGVkGAUgASgIUghkaXNhYmxlZBIiCg1tYXhfaHRsY19tc2F0GAYgASgEUgttYXhI'
    'dGxjTXNhdBIfCgtsYXN0X3VwZGF0ZRgHIAEoDVIKbGFzdFVwZGF0ZRJOCg5jdXN0b21fcmVjb3'
    'JkcxgIIAMoCzInLmxucnBjLlJvdXRpbmdQb2xpY3kuQ3VzdG9tUmVjb3Jkc0VudHJ5Ug1jdXN0'
    'b21SZWNvcmRzEjEKFWluYm91bmRfZmVlX2Jhc2VfbXNhdBgJIAEoBVISaW5ib3VuZEZlZUJhc2'
    'VNc2F0EjwKG2luYm91bmRfZmVlX3JhdGVfbWlsbGlfbXNhdBgKIAEoBVIXaW5ib3VuZEZlZVJh'
    'dGVNaWxsaU1zYXQaQAoSQ3VzdG9tUmVjb3Jkc0VudHJ5EhAKA2tleRgBIAEoBFIDa2V5EhQKBX'
    'ZhbHVlGAIgASgMUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use channelEdgeDescriptor instead')
const ChannelEdge$json = {
  '1': 'ChannelEdge',
  '2': [
    {
      '1': 'channel_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'channelId',
    },
    {'1': 'chan_point', '3': 2, '4': 1, '5': 9, '10': 'chanPoint'},
    {
      '1': 'last_update',
      '3': 3,
      '4': 1,
      '5': 13,
      '8': {'3': true},
      '10': 'lastUpdate',
    },
    {'1': 'node1_pub', '3': 4, '4': 1, '5': 9, '10': 'node1Pub'},
    {'1': 'node2_pub', '3': 5, '4': 1, '5': 9, '10': 'node2Pub'},
    {'1': 'capacity', '3': 6, '4': 1, '5': 3, '10': 'capacity'},
    {'1': 'node1_policy', '3': 7, '4': 1, '5': 11, '6': '.lnrpc.RoutingPolicy', '10': 'node1Policy'},
    {'1': 'node2_policy', '3': 8, '4': 1, '5': 11, '6': '.lnrpc.RoutingPolicy', '10': 'node2Policy'},
    {'1': 'custom_records', '3': 9, '4': 3, '5': 11, '6': '.lnrpc.ChannelEdge.CustomRecordsEntry', '10': 'customRecords'},
  ],
  '3': [ChannelEdge_CustomRecordsEntry$json],
};

@$core.Deprecated('Use channelEdgeDescriptor instead')
const ChannelEdge_CustomRecordsEntry$json = {
  '1': 'CustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ChannelEdge`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelEdgeDescriptor = $convert.base64Decode(
    'CgtDaGFubmVsRWRnZRIhCgpjaGFubmVsX2lkGAEgASgEQgIwAVIJY2hhbm5lbElkEh0KCmNoYW'
    '5fcG9pbnQYAiABKAlSCWNoYW5Qb2ludBIjCgtsYXN0X3VwZGF0ZRgDIAEoDUICGAFSCmxhc3RV'
    'cGRhdGUSGwoJbm9kZTFfcHViGAQgASgJUghub2RlMVB1YhIbCglub2RlMl9wdWIYBSABKAlSCG'
    '5vZGUyUHViEhoKCGNhcGFjaXR5GAYgASgDUghjYXBhY2l0eRI3Cgxub2RlMV9wb2xpY3kYByAB'
    'KAsyFC5sbnJwYy5Sb3V0aW5nUG9saWN5Ugtub2RlMVBvbGljeRI3Cgxub2RlMl9wb2xpY3kYCC'
    'ABKAsyFC5sbnJwYy5Sb3V0aW5nUG9saWN5Ugtub2RlMlBvbGljeRJMCg5jdXN0b21fcmVjb3Jk'
    'cxgJIAMoCzIlLmxucnBjLkNoYW5uZWxFZGdlLkN1c3RvbVJlY29yZHNFbnRyeVINY3VzdG9tUm'
    'Vjb3JkcxpAChJDdXN0b21SZWNvcmRzRW50cnkSEAoDa2V5GAEgASgEUgNrZXkSFAoFdmFsdWUY'
    'AiABKAxSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use channelGraphRequestDescriptor instead')
const ChannelGraphRequest$json = {
  '1': 'ChannelGraphRequest',
  '2': [
    {'1': 'include_unannounced', '3': 1, '4': 1, '5': 8, '10': 'includeUnannounced'},
  ],
};

/// Descriptor for `ChannelGraphRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelGraphRequestDescriptor = $convert.base64Decode(
    'ChNDaGFubmVsR3JhcGhSZXF1ZXN0Ei8KE2luY2x1ZGVfdW5hbm5vdW5jZWQYASABKAhSEmluY2'
    'x1ZGVVbmFubm91bmNlZA==');

@$core.Deprecated('Use channelGraphDescriptor instead')
const ChannelGraph$json = {
  '1': 'ChannelGraph',
  '2': [
    {'1': 'nodes', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.LightningNode', '10': 'nodes'},
    {'1': 'edges', '3': 2, '4': 3, '5': 11, '6': '.lnrpc.ChannelEdge', '10': 'edges'},
  ],
};

/// Descriptor for `ChannelGraph`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelGraphDescriptor = $convert.base64Decode(
    'CgxDaGFubmVsR3JhcGgSKgoFbm9kZXMYASADKAsyFC5sbnJwYy5MaWdodG5pbmdOb2RlUgVub2'
    'RlcxIoCgVlZGdlcxgCIAMoCzISLmxucnBjLkNoYW5uZWxFZGdlUgVlZGdlcw==');

@$core.Deprecated('Use nodeMetricsRequestDescriptor instead')
const NodeMetricsRequest$json = {
  '1': 'NodeMetricsRequest',
  '2': [
    {'1': 'types', '3': 1, '4': 3, '5': 14, '6': '.lnrpc.NodeMetricType', '10': 'types'},
  ],
};

/// Descriptor for `NodeMetricsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeMetricsRequestDescriptor = $convert.base64Decode(
    'ChJOb2RlTWV0cmljc1JlcXVlc3QSKwoFdHlwZXMYASADKA4yFS5sbnJwYy5Ob2RlTWV0cmljVH'
    'lwZVIFdHlwZXM=');

@$core.Deprecated('Use nodeMetricsResponseDescriptor instead')
const NodeMetricsResponse$json = {
  '1': 'NodeMetricsResponse',
  '2': [
    {'1': 'betweenness_centrality', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.NodeMetricsResponse.BetweennessCentralityEntry', '10': 'betweennessCentrality'},
  ],
  '3': [NodeMetricsResponse_BetweennessCentralityEntry$json],
};

@$core.Deprecated('Use nodeMetricsResponseDescriptor instead')
const NodeMetricsResponse_BetweennessCentralityEntry$json = {
  '1': 'BetweennessCentralityEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.FloatMetric', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NodeMetricsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeMetricsResponseDescriptor = $convert.base64Decode(
    'ChNOb2RlTWV0cmljc1Jlc3BvbnNlEmwKFmJldHdlZW5uZXNzX2NlbnRyYWxpdHkYASADKAsyNS'
    '5sbnJwYy5Ob2RlTWV0cmljc1Jlc3BvbnNlLkJldHdlZW5uZXNzQ2VudHJhbGl0eUVudHJ5UhVi'
    'ZXR3ZWVubmVzc0NlbnRyYWxpdHkaXAoaQmV0d2Vlbm5lc3NDZW50cmFsaXR5RW50cnkSEAoDa2'
    'V5GAEgASgJUgNrZXkSKAoFdmFsdWUYAiABKAsyEi5sbnJwYy5GbG9hdE1ldHJpY1IFdmFsdWU6'
    'AjgB');

@$core.Deprecated('Use floatMetricDescriptor instead')
const FloatMetric$json = {
  '1': 'FloatMetric',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
    {'1': 'normalized_value', '3': 2, '4': 1, '5': 1, '10': 'normalizedValue'},
  ],
};

/// Descriptor for `FloatMetric`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List floatMetricDescriptor = $convert.base64Decode(
    'CgtGbG9hdE1ldHJpYxIUCgV2YWx1ZRgBIAEoAVIFdmFsdWUSKQoQbm9ybWFsaXplZF92YWx1ZR'
    'gCIAEoAVIPbm9ybWFsaXplZFZhbHVl');

@$core.Deprecated('Use chanInfoRequestDescriptor instead')
const ChanInfoRequest$json = {
  '1': 'ChanInfoRequest',
  '2': [
    {
      '1': 'chan_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'chan_point', '3': 2, '4': 1, '5': 9, '10': 'chanPoint'},
  ],
};

/// Descriptor for `ChanInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chanInfoRequestDescriptor = $convert.base64Decode(
    'Cg9DaGFuSW5mb1JlcXVlc3QSGwoHY2hhbl9pZBgBIAEoBEICMAFSBmNoYW5JZBIdCgpjaGFuX3'
    'BvaW50GAIgASgJUgljaGFuUG9pbnQ=');

@$core.Deprecated('Use networkInfoRequestDescriptor instead')
const NetworkInfoRequest$json = {
  '1': 'NetworkInfoRequest',
};

/// Descriptor for `NetworkInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List networkInfoRequestDescriptor = $convert.base64Decode(
    'ChJOZXR3b3JrSW5mb1JlcXVlc3Q=');

@$core.Deprecated('Use networkInfoDescriptor instead')
const NetworkInfo$json = {
  '1': 'NetworkInfo',
  '2': [
    {'1': 'graph_diameter', '3': 1, '4': 1, '5': 13, '10': 'graphDiameter'},
    {'1': 'avg_out_degree', '3': 2, '4': 1, '5': 1, '10': 'avgOutDegree'},
    {'1': 'max_out_degree', '3': 3, '4': 1, '5': 13, '10': 'maxOutDegree'},
    {'1': 'num_nodes', '3': 4, '4': 1, '5': 13, '10': 'numNodes'},
    {'1': 'num_channels', '3': 5, '4': 1, '5': 13, '10': 'numChannels'},
    {'1': 'total_network_capacity', '3': 6, '4': 1, '5': 3, '10': 'totalNetworkCapacity'},
    {'1': 'avg_channel_size', '3': 7, '4': 1, '5': 1, '10': 'avgChannelSize'},
    {'1': 'min_channel_size', '3': 8, '4': 1, '5': 3, '10': 'minChannelSize'},
    {'1': 'max_channel_size', '3': 9, '4': 1, '5': 3, '10': 'maxChannelSize'},
    {'1': 'median_channel_size_sat', '3': 10, '4': 1, '5': 3, '10': 'medianChannelSizeSat'},
    {'1': 'num_zombie_chans', '3': 11, '4': 1, '5': 4, '10': 'numZombieChans'},
  ],
};

/// Descriptor for `NetworkInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List networkInfoDescriptor = $convert.base64Decode(
    'CgtOZXR3b3JrSW5mbxIlCg5ncmFwaF9kaWFtZXRlchgBIAEoDVINZ3JhcGhEaWFtZXRlchIkCg'
    '5hdmdfb3V0X2RlZ3JlZRgCIAEoAVIMYXZnT3V0RGVncmVlEiQKDm1heF9vdXRfZGVncmVlGAMg'
    'ASgNUgxtYXhPdXREZWdyZWUSGwoJbnVtX25vZGVzGAQgASgNUghudW1Ob2RlcxIhCgxudW1fY2'
    'hhbm5lbHMYBSABKA1SC251bUNoYW5uZWxzEjQKFnRvdGFsX25ldHdvcmtfY2FwYWNpdHkYBiAB'
    'KANSFHRvdGFsTmV0d29ya0NhcGFjaXR5EigKEGF2Z19jaGFubmVsX3NpemUYByABKAFSDmF2Z0'
    'NoYW5uZWxTaXplEigKEG1pbl9jaGFubmVsX3NpemUYCCABKANSDm1pbkNoYW5uZWxTaXplEigK'
    'EG1heF9jaGFubmVsX3NpemUYCSABKANSDm1heENoYW5uZWxTaXplEjUKF21lZGlhbl9jaGFubm'
    'VsX3NpemVfc2F0GAogASgDUhRtZWRpYW5DaGFubmVsU2l6ZVNhdBIoChBudW1fem9tYmllX2No'
    'YW5zGAsgASgEUg5udW1ab21iaWVDaGFucw==');

@$core.Deprecated('Use stopRequestDescriptor instead')
const StopRequest$json = {
  '1': 'StopRequest',
};

/// Descriptor for `StopRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopRequestDescriptor = $convert.base64Decode(
    'CgtTdG9wUmVxdWVzdA==');

@$core.Deprecated('Use stopResponseDescriptor instead')
const StopResponse$json = {
  '1': 'StopResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `StopResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stopResponseDescriptor = $convert.base64Decode(
    'CgxTdG9wUmVzcG9uc2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use graphTopologySubscriptionDescriptor instead')
const GraphTopologySubscription$json = {
  '1': 'GraphTopologySubscription',
};

/// Descriptor for `GraphTopologySubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphTopologySubscriptionDescriptor = $convert.base64Decode(
    'ChlHcmFwaFRvcG9sb2d5U3Vic2NyaXB0aW9u');

@$core.Deprecated('Use graphTopologyUpdateDescriptor instead')
const GraphTopologyUpdate$json = {
  '1': 'GraphTopologyUpdate',
  '2': [
    {'1': 'node_updates', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.NodeUpdate', '10': 'nodeUpdates'},
    {'1': 'channel_updates', '3': 2, '4': 3, '5': 11, '6': '.lnrpc.ChannelEdgeUpdate', '10': 'channelUpdates'},
    {'1': 'closed_chans', '3': 3, '4': 3, '5': 11, '6': '.lnrpc.ClosedChannelUpdate', '10': 'closedChans'},
  ],
};

/// Descriptor for `GraphTopologyUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphTopologyUpdateDescriptor = $convert.base64Decode(
    'ChNHcmFwaFRvcG9sb2d5VXBkYXRlEjQKDG5vZGVfdXBkYXRlcxgBIAMoCzIRLmxucnBjLk5vZG'
    'VVcGRhdGVSC25vZGVVcGRhdGVzEkEKD2NoYW5uZWxfdXBkYXRlcxgCIAMoCzIYLmxucnBjLkNo'
    'YW5uZWxFZGdlVXBkYXRlUg5jaGFubmVsVXBkYXRlcxI9CgxjbG9zZWRfY2hhbnMYAyADKAsyGi'
    '5sbnJwYy5DbG9zZWRDaGFubmVsVXBkYXRlUgtjbG9zZWRDaGFucw==');

@$core.Deprecated('Use nodeUpdateDescriptor instead')
const NodeUpdate$json = {
  '1': 'NodeUpdate',
  '2': [
    {
      '1': 'addresses',
      '3': 1,
      '4': 3,
      '5': 9,
      '8': {'3': true},
      '10': 'addresses',
    },
    {'1': 'identity_key', '3': 2, '4': 1, '5': 9, '10': 'identityKey'},
    {
      '1': 'global_features',
      '3': 3,
      '4': 1,
      '5': 12,
      '8': {'3': true},
      '10': 'globalFeatures',
    },
    {'1': 'alias', '3': 4, '4': 1, '5': 9, '10': 'alias'},
    {'1': 'color', '3': 5, '4': 1, '5': 9, '10': 'color'},
    {'1': 'node_addresses', '3': 7, '4': 3, '5': 11, '6': '.lnrpc.NodeAddress', '10': 'nodeAddresses'},
    {'1': 'features', '3': 6, '4': 3, '5': 11, '6': '.lnrpc.NodeUpdate.FeaturesEntry', '10': 'features'},
  ],
  '3': [NodeUpdate_FeaturesEntry$json],
};

@$core.Deprecated('Use nodeUpdateDescriptor instead')
const NodeUpdate_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NodeUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeUpdateDescriptor = $convert.base64Decode(
    'CgpOb2RlVXBkYXRlEiAKCWFkZHJlc3NlcxgBIAMoCUICGAFSCWFkZHJlc3NlcxIhCgxpZGVudG'
    'l0eV9rZXkYAiABKAlSC2lkZW50aXR5S2V5EisKD2dsb2JhbF9mZWF0dXJlcxgDIAEoDEICGAFS'
    'Dmdsb2JhbEZlYXR1cmVzEhQKBWFsaWFzGAQgASgJUgVhbGlhcxIUCgVjb2xvchgFIAEoCVIFY2'
    '9sb3ISOQoObm9kZV9hZGRyZXNzZXMYByADKAsyEi5sbnJwYy5Ob2RlQWRkcmVzc1INbm9kZUFk'
    'ZHJlc3NlcxI7CghmZWF0dXJlcxgGIAMoCzIfLmxucnBjLk5vZGVVcGRhdGUuRmVhdHVyZXNFbn'
    'RyeVIIZmVhdHVyZXMaSwoNRmVhdHVyZXNFbnRyeRIQCgNrZXkYASABKA1SA2tleRIkCgV2YWx1'
    'ZRgCIAEoCzIOLmxucnBjLkZlYXR1cmVSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use channelEdgeUpdateDescriptor instead')
const ChannelEdgeUpdate$json = {
  '1': 'ChannelEdgeUpdate',
  '2': [
    {
      '1': 'chan_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'chan_point', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoint'},
    {'1': 'capacity', '3': 3, '4': 1, '5': 3, '10': 'capacity'},
    {'1': 'routing_policy', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.RoutingPolicy', '10': 'routingPolicy'},
    {'1': 'advertising_node', '3': 5, '4': 1, '5': 9, '10': 'advertisingNode'},
    {'1': 'connecting_node', '3': 6, '4': 1, '5': 9, '10': 'connectingNode'},
  ],
};

/// Descriptor for `ChannelEdgeUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelEdgeUpdateDescriptor = $convert.base64Decode(
    'ChFDaGFubmVsRWRnZVVwZGF0ZRIbCgdjaGFuX2lkGAEgASgEQgIwAVIGY2hhbklkEjIKCmNoYW'
    '5fcG9pbnQYAiABKAsyEy5sbnJwYy5DaGFubmVsUG9pbnRSCWNoYW5Qb2ludBIaCghjYXBhY2l0'
    'eRgDIAEoA1IIY2FwYWNpdHkSOwoOcm91dGluZ19wb2xpY3kYBCABKAsyFC5sbnJwYy5Sb3V0aW'
    '5nUG9saWN5Ug1yb3V0aW5nUG9saWN5EikKEGFkdmVydGlzaW5nX25vZGUYBSABKAlSD2FkdmVy'
    'dGlzaW5nTm9kZRInCg9jb25uZWN0aW5nX25vZGUYBiABKAlSDmNvbm5lY3RpbmdOb2Rl');

@$core.Deprecated('Use closedChannelUpdateDescriptor instead')
const ClosedChannelUpdate$json = {
  '1': 'ClosedChannelUpdate',
  '2': [
    {
      '1': 'chan_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'capacity', '3': 2, '4': 1, '5': 3, '10': 'capacity'},
    {'1': 'closed_height', '3': 3, '4': 1, '5': 13, '10': 'closedHeight'},
    {'1': 'chan_point', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoint'},
  ],
};

/// Descriptor for `ClosedChannelUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closedChannelUpdateDescriptor = $convert.base64Decode(
    'ChNDbG9zZWRDaGFubmVsVXBkYXRlEhsKB2NoYW5faWQYASABKARCAjABUgZjaGFuSWQSGgoIY2'
    'FwYWNpdHkYAiABKANSCGNhcGFjaXR5EiMKDWNsb3NlZF9oZWlnaHQYAyABKA1SDGNsb3NlZEhl'
    'aWdodBIyCgpjaGFuX3BvaW50GAQgASgLMhMubG5ycGMuQ2hhbm5lbFBvaW50UgljaGFuUG9pbn'
    'Q=');

@$core.Deprecated('Use hopHintDescriptor instead')
const HopHint$json = {
  '1': 'HopHint',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '10': 'nodeId'},
    {
      '1': 'chan_id',
      '3': 2,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'fee_base_msat', '3': 3, '4': 1, '5': 13, '10': 'feeBaseMsat'},
    {'1': 'fee_proportional_millionths', '3': 4, '4': 1, '5': 13, '10': 'feeProportionalMillionths'},
    {'1': 'cltv_expiry_delta', '3': 5, '4': 1, '5': 13, '10': 'cltvExpiryDelta'},
  ],
};

/// Descriptor for `HopHint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hopHintDescriptor = $convert.base64Decode(
    'CgdIb3BIaW50EhcKB25vZGVfaWQYASABKAlSBm5vZGVJZBIbCgdjaGFuX2lkGAIgASgEQgIwAV'
    'IGY2hhbklkEiIKDWZlZV9iYXNlX21zYXQYAyABKA1SC2ZlZUJhc2VNc2F0Ej4KG2ZlZV9wcm9w'
    'b3J0aW9uYWxfbWlsbGlvbnRocxgEIAEoDVIZZmVlUHJvcG9ydGlvbmFsTWlsbGlvbnRocxIqCh'
    'FjbHR2X2V4cGlyeV9kZWx0YRgFIAEoDVIPY2x0dkV4cGlyeURlbHRh');

@$core.Deprecated('Use setIDDescriptor instead')
const SetID$json = {
  '1': 'SetID',
  '2': [
    {'1': 'set_id', '3': 1, '4': 1, '5': 12, '10': 'setId'},
  ],
};

/// Descriptor for `SetID`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setIDDescriptor = $convert.base64Decode(
    'CgVTZXRJRBIVCgZzZXRfaWQYASABKAxSBXNldElk');

@$core.Deprecated('Use routeHintDescriptor instead')
const RouteHint$json = {
  '1': 'RouteHint',
  '2': [
    {'1': 'hop_hints', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.HopHint', '10': 'hopHints'},
  ],
};

/// Descriptor for `RouteHint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeHintDescriptor = $convert.base64Decode(
    'CglSb3V0ZUhpbnQSKwoJaG9wX2hpbnRzGAEgAygLMg4ubG5ycGMuSG9wSGludFIIaG9wSGludH'
    'M=');

@$core.Deprecated('Use blindedPaymentPathDescriptor instead')
const BlindedPaymentPath$json = {
  '1': 'BlindedPaymentPath',
  '2': [
    {'1': 'blinded_path', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.BlindedPath', '10': 'blindedPath'},
    {'1': 'base_fee_msat', '3': 2, '4': 1, '5': 4, '10': 'baseFeeMsat'},
    {'1': 'proportional_fee_rate', '3': 3, '4': 1, '5': 13, '10': 'proportionalFeeRate'},
    {'1': 'total_cltv_delta', '3': 4, '4': 1, '5': 13, '10': 'totalCltvDelta'},
    {'1': 'htlc_min_msat', '3': 5, '4': 1, '5': 4, '10': 'htlcMinMsat'},
    {'1': 'htlc_max_msat', '3': 6, '4': 1, '5': 4, '10': 'htlcMaxMsat'},
    {'1': 'features', '3': 7, '4': 3, '5': 14, '6': '.lnrpc.FeatureBit', '10': 'features'},
  ],
};

/// Descriptor for `BlindedPaymentPath`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedPaymentPathDescriptor = $convert.base64Decode(
    'ChJCbGluZGVkUGF5bWVudFBhdGgSNQoMYmxpbmRlZF9wYXRoGAEgASgLMhIubG5ycGMuQmxpbm'
    'RlZFBhdGhSC2JsaW5kZWRQYXRoEiIKDWJhc2VfZmVlX21zYXQYAiABKARSC2Jhc2VGZWVNc2F0'
    'EjIKFXByb3BvcnRpb25hbF9mZWVfcmF0ZRgDIAEoDVITcHJvcG9ydGlvbmFsRmVlUmF0ZRIoCh'
    'B0b3RhbF9jbHR2X2RlbHRhGAQgASgNUg50b3RhbENsdHZEZWx0YRIiCg1odGxjX21pbl9tc2F0'
    'GAUgASgEUgtodGxjTWluTXNhdBIiCg1odGxjX21heF9tc2F0GAYgASgEUgtodGxjTWF4TXNhdB'
    'ItCghmZWF0dXJlcxgHIAMoDjIRLmxucnBjLkZlYXR1cmVCaXRSCGZlYXR1cmVz');

@$core.Deprecated('Use blindedPathDescriptor instead')
const BlindedPath$json = {
  '1': 'BlindedPath',
  '2': [
    {'1': 'introduction_node', '3': 1, '4': 1, '5': 12, '10': 'introductionNode'},
    {'1': 'blinding_point', '3': 2, '4': 1, '5': 12, '10': 'blindingPoint'},
    {'1': 'blinded_hops', '3': 3, '4': 3, '5': 11, '6': '.lnrpc.BlindedHop', '10': 'blindedHops'},
  ],
};

/// Descriptor for `BlindedPath`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedPathDescriptor = $convert.base64Decode(
    'CgtCbGluZGVkUGF0aBIrChFpbnRyb2R1Y3Rpb25fbm9kZRgBIAEoDFIQaW50cm9kdWN0aW9uTm'
    '9kZRIlCg5ibGluZGluZ19wb2ludBgCIAEoDFINYmxpbmRpbmdQb2ludBI0CgxibGluZGVkX2hv'
    'cHMYAyADKAsyES5sbnJwYy5CbGluZGVkSG9wUgtibGluZGVkSG9wcw==');

@$core.Deprecated('Use blindedHopDescriptor instead')
const BlindedHop$json = {
  '1': 'BlindedHop',
  '2': [
    {'1': 'blinded_node', '3': 1, '4': 1, '5': 12, '10': 'blindedNode'},
    {'1': 'encrypted_data', '3': 2, '4': 1, '5': 12, '10': 'encryptedData'},
  ],
};

/// Descriptor for `BlindedHop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedHopDescriptor = $convert.base64Decode(
    'CgpCbGluZGVkSG9wEiEKDGJsaW5kZWRfbm9kZRgBIAEoDFILYmxpbmRlZE5vZGUSJQoOZW5jcn'
    'lwdGVkX2RhdGEYAiABKAxSDWVuY3J5cHRlZERhdGE=');

@$core.Deprecated('Use aMPInvoiceStateDescriptor instead')
const AMPInvoiceState$json = {
  '1': 'AMPInvoiceState',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.InvoiceHTLCState', '10': 'state'},
    {'1': 'settle_index', '3': 2, '4': 1, '5': 4, '10': 'settleIndex'},
    {'1': 'settle_time', '3': 3, '4': 1, '5': 3, '10': 'settleTime'},
    {'1': 'amt_paid_msat', '3': 5, '4': 1, '5': 3, '10': 'amtPaidMsat'},
  ],
};

/// Descriptor for `AMPInvoiceState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aMPInvoiceStateDescriptor = $convert.base64Decode(
    'Cg9BTVBJbnZvaWNlU3RhdGUSLQoFc3RhdGUYASABKA4yFy5sbnJwYy5JbnZvaWNlSFRMQ1N0YX'
    'RlUgVzdGF0ZRIhCgxzZXR0bGVfaW5kZXgYAiABKARSC3NldHRsZUluZGV4Eh8KC3NldHRsZV90'
    'aW1lGAMgASgDUgpzZXR0bGVUaW1lEiIKDWFtdF9wYWlkX21zYXQYBSABKANSC2FtdFBhaWRNc2'
    'F0');

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice$json = {
  '1': 'Invoice',
  '2': [
    {'1': 'memo', '3': 1, '4': 1, '5': 9, '10': 'memo'},
    {'1': 'r_preimage', '3': 3, '4': 1, '5': 12, '10': 'rPreimage'},
    {'1': 'r_hash', '3': 4, '4': 1, '5': 12, '10': 'rHash'},
    {'1': 'value', '3': 5, '4': 1, '5': 3, '10': 'value'},
    {'1': 'value_msat', '3': 23, '4': 1, '5': 3, '10': 'valueMsat'},
    {
      '1': 'settled',
      '3': 6,
      '4': 1,
      '5': 8,
      '8': {'3': true},
      '10': 'settled',
    },
    {'1': 'creation_date', '3': 7, '4': 1, '5': 3, '10': 'creationDate'},
    {'1': 'settle_date', '3': 8, '4': 1, '5': 3, '10': 'settleDate'},
    {'1': 'payment_request', '3': 9, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'description_hash', '3': 10, '4': 1, '5': 12, '10': 'descriptionHash'},
    {'1': 'expiry', '3': 11, '4': 1, '5': 3, '10': 'expiry'},
    {'1': 'fallback_addr', '3': 12, '4': 1, '5': 9, '10': 'fallbackAddr'},
    {'1': 'cltv_expiry', '3': 13, '4': 1, '5': 4, '10': 'cltvExpiry'},
    {'1': 'route_hints', '3': 14, '4': 3, '5': 11, '6': '.lnrpc.RouteHint', '10': 'routeHints'},
    {'1': 'private', '3': 15, '4': 1, '5': 8, '10': 'private'},
    {'1': 'add_index', '3': 16, '4': 1, '5': 4, '10': 'addIndex'},
    {'1': 'settle_index', '3': 17, '4': 1, '5': 4, '10': 'settleIndex'},
    {
      '1': 'amt_paid',
      '3': 18,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'amtPaid',
    },
    {'1': 'amt_paid_sat', '3': 19, '4': 1, '5': 3, '10': 'amtPaidSat'},
    {'1': 'amt_paid_msat', '3': 20, '4': 1, '5': 3, '10': 'amtPaidMsat'},
    {'1': 'state', '3': 21, '4': 1, '5': 14, '6': '.lnrpc.Invoice.InvoiceState', '10': 'state'},
    {'1': 'htlcs', '3': 22, '4': 3, '5': 11, '6': '.lnrpc.InvoiceHTLC', '10': 'htlcs'},
    {'1': 'features', '3': 24, '4': 3, '5': 11, '6': '.lnrpc.Invoice.FeaturesEntry', '10': 'features'},
    {'1': 'is_keysend', '3': 25, '4': 1, '5': 8, '10': 'isKeysend'},
    {'1': 'payment_addr', '3': 26, '4': 1, '5': 12, '10': 'paymentAddr'},
    {'1': 'is_amp', '3': 27, '4': 1, '5': 8, '10': 'isAmp'},
    {'1': 'amp_invoice_state', '3': 28, '4': 3, '5': 11, '6': '.lnrpc.Invoice.AmpInvoiceStateEntry', '10': 'ampInvoiceState'},
    {'1': 'is_blinded', '3': 29, '4': 1, '5': 8, '10': 'isBlinded'},
    {'1': 'blinded_path_config', '3': 30, '4': 1, '5': 11, '6': '.lnrpc.BlindedPathConfig', '10': 'blindedPathConfig'},
  ],
  '3': [Invoice_FeaturesEntry$json, Invoice_AmpInvoiceStateEntry$json],
  '4': [Invoice_InvoiceState$json],
  '9': [
    {'1': 2, '2': 3},
  ],
};

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice_AmpInvoiceStateEntry$json = {
  '1': 'AmpInvoiceStateEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.AMPInvoiceState', '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use invoiceDescriptor instead')
const Invoice_InvoiceState$json = {
  '1': 'InvoiceState',
  '2': [
    {'1': 'OPEN', '2': 0},
    {'1': 'SETTLED', '2': 1},
    {'1': 'CANCELED', '2': 2},
    {'1': 'ACCEPTED', '2': 3},
  ],
};

/// Descriptor for `Invoice`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceDescriptor = $convert.base64Decode(
    'CgdJbnZvaWNlEhIKBG1lbW8YASABKAlSBG1lbW8SHQoKcl9wcmVpbWFnZRgDIAEoDFIJclByZW'
    'ltYWdlEhUKBnJfaGFzaBgEIAEoDFIFckhhc2gSFAoFdmFsdWUYBSABKANSBXZhbHVlEh0KCnZh'
    'bHVlX21zYXQYFyABKANSCXZhbHVlTXNhdBIcCgdzZXR0bGVkGAYgASgIQgIYAVIHc2V0dGxlZB'
    'IjCg1jcmVhdGlvbl9kYXRlGAcgASgDUgxjcmVhdGlvbkRhdGUSHwoLc2V0dGxlX2RhdGUYCCAB'
    'KANSCnNldHRsZURhdGUSJwoPcGF5bWVudF9yZXF1ZXN0GAkgASgJUg5wYXltZW50UmVxdWVzdB'
    'IpChBkZXNjcmlwdGlvbl9oYXNoGAogASgMUg9kZXNjcmlwdGlvbkhhc2gSFgoGZXhwaXJ5GAsg'
    'ASgDUgZleHBpcnkSIwoNZmFsbGJhY2tfYWRkchgMIAEoCVIMZmFsbGJhY2tBZGRyEh8KC2NsdH'
    'ZfZXhwaXJ5GA0gASgEUgpjbHR2RXhwaXJ5EjEKC3JvdXRlX2hpbnRzGA4gAygLMhAubG5ycGMu'
    'Um91dGVIaW50Ugpyb3V0ZUhpbnRzEhgKB3ByaXZhdGUYDyABKAhSB3ByaXZhdGUSGwoJYWRkX2'
    'luZGV4GBAgASgEUghhZGRJbmRleBIhCgxzZXR0bGVfaW5kZXgYESABKARSC3NldHRsZUluZGV4'
    'Eh0KCGFtdF9wYWlkGBIgASgDQgIYAVIHYW10UGFpZBIgCgxhbXRfcGFpZF9zYXQYEyABKANSCm'
    'FtdFBhaWRTYXQSIgoNYW10X3BhaWRfbXNhdBgUIAEoA1ILYW10UGFpZE1zYXQSMQoFc3RhdGUY'
    'FSABKA4yGy5sbnJwYy5JbnZvaWNlLkludm9pY2VTdGF0ZVIFc3RhdGUSKAoFaHRsY3MYFiADKA'
    'syEi5sbnJwYy5JbnZvaWNlSFRMQ1IFaHRsY3MSOAoIZmVhdHVyZXMYGCADKAsyHC5sbnJwYy5J'
    'bnZvaWNlLkZlYXR1cmVzRW50cnlSCGZlYXR1cmVzEh0KCmlzX2tleXNlbmQYGSABKAhSCWlzS2'
    'V5c2VuZBIhCgxwYXltZW50X2FkZHIYGiABKAxSC3BheW1lbnRBZGRyEhUKBmlzX2FtcBgbIAEo'
    'CFIFaXNBbXASTwoRYW1wX2ludm9pY2Vfc3RhdGUYHCADKAsyIy5sbnJwYy5JbnZvaWNlLkFtcE'
    'ludm9pY2VTdGF0ZUVudHJ5Ug9hbXBJbnZvaWNlU3RhdGUSHQoKaXNfYmxpbmRlZBgdIAEoCFIJ'
    'aXNCbGluZGVkEkgKE2JsaW5kZWRfcGF0aF9jb25maWcYHiABKAsyGC5sbnJwYy5CbGluZGVkUG'
    'F0aENvbmZpZ1IRYmxpbmRlZFBhdGhDb25maWcaSwoNRmVhdHVyZXNFbnRyeRIQCgNrZXkYASAB'
    'KA1SA2tleRIkCgV2YWx1ZRgCIAEoCzIOLmxucnBjLkZlYXR1cmVSBXZhbHVlOgI4ARpaChRBbX'
    'BJbnZvaWNlU3RhdGVFbnRyeRIQCgNrZXkYASABKAlSA2tleRIsCgV2YWx1ZRgCIAEoCzIWLmxu'
    'cnBjLkFNUEludm9pY2VTdGF0ZVIFdmFsdWU6AjgBIkEKDEludm9pY2VTdGF0ZRIICgRPUEVOEA'
    'ASCwoHU0VUVExFRBABEgwKCENBTkNFTEVEEAISDAoIQUNDRVBURUQQA0oECAIQAw==');

@$core.Deprecated('Use blindedPathConfigDescriptor instead')
const BlindedPathConfig$json = {
  '1': 'BlindedPathConfig',
  '2': [
    {'1': 'min_num_real_hops', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'minNumRealHops', '17': true},
    {'1': 'num_hops', '3': 2, '4': 1, '5': 13, '9': 1, '10': 'numHops', '17': true},
    {'1': 'max_num_paths', '3': 3, '4': 1, '5': 13, '9': 2, '10': 'maxNumPaths', '17': true},
    {'1': 'node_omission_list', '3': 4, '4': 3, '5': 12, '10': 'nodeOmissionList'},
  ],
  '8': [
    {'1': '_min_num_real_hops'},
    {'1': '_num_hops'},
    {'1': '_max_num_paths'},
  ],
};

/// Descriptor for `BlindedPathConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedPathConfigDescriptor = $convert.base64Decode(
    'ChFCbGluZGVkUGF0aENvbmZpZxIuChFtaW5fbnVtX3JlYWxfaG9wcxgBIAEoDUgAUg5taW5OdW'
    '1SZWFsSG9wc4gBARIeCghudW1faG9wcxgCIAEoDUgBUgdudW1Ib3BziAEBEicKDW1heF9udW1f'
    'cGF0aHMYAyABKA1IAlILbWF4TnVtUGF0aHOIAQESLAoSbm9kZV9vbWlzc2lvbl9saXN0GAQgAy'
    'gMUhBub2RlT21pc3Npb25MaXN0QhQKEl9taW5fbnVtX3JlYWxfaG9wc0ILCglfbnVtX2hvcHNC'
    'EAoOX21heF9udW1fcGF0aHM=');

@$core.Deprecated('Use invoiceHTLCDescriptor instead')
const InvoiceHTLC$json = {
  '1': 'InvoiceHTLC',
  '2': [
    {
      '1': 'chan_id',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'htlc_index', '3': 2, '4': 1, '5': 4, '10': 'htlcIndex'},
    {'1': 'amt_msat', '3': 3, '4': 1, '5': 4, '10': 'amtMsat'},
    {'1': 'accept_height', '3': 4, '4': 1, '5': 5, '10': 'acceptHeight'},
    {'1': 'accept_time', '3': 5, '4': 1, '5': 3, '10': 'acceptTime'},
    {'1': 'resolve_time', '3': 6, '4': 1, '5': 3, '10': 'resolveTime'},
    {'1': 'expiry_height', '3': 7, '4': 1, '5': 5, '10': 'expiryHeight'},
    {'1': 'state', '3': 8, '4': 1, '5': 14, '6': '.lnrpc.InvoiceHTLCState', '10': 'state'},
    {'1': 'custom_records', '3': 9, '4': 3, '5': 11, '6': '.lnrpc.InvoiceHTLC.CustomRecordsEntry', '10': 'customRecords'},
    {'1': 'mpp_total_amt_msat', '3': 10, '4': 1, '5': 4, '10': 'mppTotalAmtMsat'},
    {'1': 'amp', '3': 11, '4': 1, '5': 11, '6': '.lnrpc.AMP', '10': 'amp'},
    {'1': 'custom_channel_data', '3': 12, '4': 1, '5': 12, '10': 'customChannelData'},
  ],
  '3': [InvoiceHTLC_CustomRecordsEntry$json],
};

@$core.Deprecated('Use invoiceHTLCDescriptor instead')
const InvoiceHTLC_CustomRecordsEntry$json = {
  '1': 'CustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `InvoiceHTLC`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceHTLCDescriptor = $convert.base64Decode(
    'CgtJbnZvaWNlSFRMQxIbCgdjaGFuX2lkGAEgASgEQgIwAVIGY2hhbklkEh0KCmh0bGNfaW5kZX'
    'gYAiABKARSCWh0bGNJbmRleBIZCghhbXRfbXNhdBgDIAEoBFIHYW10TXNhdBIjCg1hY2NlcHRf'
    'aGVpZ2h0GAQgASgFUgxhY2NlcHRIZWlnaHQSHwoLYWNjZXB0X3RpbWUYBSABKANSCmFjY2VwdF'
    'RpbWUSIQoMcmVzb2x2ZV90aW1lGAYgASgDUgtyZXNvbHZlVGltZRIjCg1leHBpcnlfaGVpZ2h0'
    'GAcgASgFUgxleHBpcnlIZWlnaHQSLQoFc3RhdGUYCCABKA4yFy5sbnJwYy5JbnZvaWNlSFRMQ1'
    'N0YXRlUgVzdGF0ZRJMCg5jdXN0b21fcmVjb3JkcxgJIAMoCzIlLmxucnBjLkludm9pY2VIVExD'
    'LkN1c3RvbVJlY29yZHNFbnRyeVINY3VzdG9tUmVjb3JkcxIrChJtcHBfdG90YWxfYW10X21zYX'
    'QYCiABKARSD21wcFRvdGFsQW10TXNhdBIcCgNhbXAYCyABKAsyCi5sbnJwYy5BTVBSA2FtcBIu'
    'ChNjdXN0b21fY2hhbm5lbF9kYXRhGAwgASgMUhFjdXN0b21DaGFubmVsRGF0YRpAChJDdXN0b2'
    '1SZWNvcmRzRW50cnkSEAoDa2V5GAEgASgEUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4'
    'AQ==');

@$core.Deprecated('Use aMPDescriptor instead')
const AMP$json = {
  '1': 'AMP',
  '2': [
    {'1': 'root_share', '3': 1, '4': 1, '5': 12, '10': 'rootShare'},
    {'1': 'set_id', '3': 2, '4': 1, '5': 12, '10': 'setId'},
    {'1': 'child_index', '3': 3, '4': 1, '5': 13, '10': 'childIndex'},
    {'1': 'hash', '3': 4, '4': 1, '5': 12, '10': 'hash'},
    {'1': 'preimage', '3': 5, '4': 1, '5': 12, '10': 'preimage'},
  ],
};

/// Descriptor for `AMP`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aMPDescriptor = $convert.base64Decode(
    'CgNBTVASHQoKcm9vdF9zaGFyZRgBIAEoDFIJcm9vdFNoYXJlEhUKBnNldF9pZBgCIAEoDFIFc2'
    'V0SWQSHwoLY2hpbGRfaW5kZXgYAyABKA1SCmNoaWxkSW5kZXgSEgoEaGFzaBgEIAEoDFIEaGFz'
    'aBIaCghwcmVpbWFnZRgFIAEoDFIIcHJlaW1hZ2U=');

@$core.Deprecated('Use addInvoiceResponseDescriptor instead')
const AddInvoiceResponse$json = {
  '1': 'AddInvoiceResponse',
  '2': [
    {'1': 'r_hash', '3': 1, '4': 1, '5': 12, '10': 'rHash'},
    {'1': 'payment_request', '3': 2, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'add_index', '3': 16, '4': 1, '5': 4, '10': 'addIndex'},
    {'1': 'payment_addr', '3': 17, '4': 1, '5': 12, '10': 'paymentAddr'},
  ],
};

/// Descriptor for `AddInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addInvoiceResponseDescriptor = $convert.base64Decode(
    'ChJBZGRJbnZvaWNlUmVzcG9uc2USFQoGcl9oYXNoGAEgASgMUgVySGFzaBInCg9wYXltZW50X3'
    'JlcXVlc3QYAiABKAlSDnBheW1lbnRSZXF1ZXN0EhsKCWFkZF9pbmRleBgQIAEoBFIIYWRkSW5k'
    'ZXgSIQoMcGF5bWVudF9hZGRyGBEgASgMUgtwYXltZW50QWRkcg==');

@$core.Deprecated('Use paymentHashDescriptor instead')
const PaymentHash$json = {
  '1': 'PaymentHash',
  '2': [
    {
      '1': 'r_hash_str',
      '3': 1,
      '4': 1,
      '5': 9,
      '8': {'3': true},
      '10': 'rHashStr',
    },
    {'1': 'r_hash', '3': 2, '4': 1, '5': 12, '10': 'rHash'},
  ],
};

/// Descriptor for `PaymentHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentHashDescriptor = $convert.base64Decode(
    'CgtQYXltZW50SGFzaBIgCgpyX2hhc2hfc3RyGAEgASgJQgIYAVIIckhhc2hTdHISFQoGcl9oYX'
    'NoGAIgASgMUgVySGFzaA==');

@$core.Deprecated('Use listInvoiceRequestDescriptor instead')
const ListInvoiceRequest$json = {
  '1': 'ListInvoiceRequest',
  '2': [
    {'1': 'pending_only', '3': 1, '4': 1, '5': 8, '10': 'pendingOnly'},
    {'1': 'index_offset', '3': 4, '4': 1, '5': 4, '10': 'indexOffset'},
    {'1': 'num_max_invoices', '3': 5, '4': 1, '5': 4, '10': 'numMaxInvoices'},
    {'1': 'reversed', '3': 6, '4': 1, '5': 8, '10': 'reversed'},
    {'1': 'creation_date_start', '3': 7, '4': 1, '5': 4, '10': 'creationDateStart'},
    {'1': 'creation_date_end', '3': 8, '4': 1, '5': 4, '10': 'creationDateEnd'},
  ],
};

/// Descriptor for `ListInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInvoiceRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0SW52b2ljZVJlcXVlc3QSIQoMcGVuZGluZ19vbmx5GAEgASgIUgtwZW5kaW5nT25seR'
    'IhCgxpbmRleF9vZmZzZXQYBCABKARSC2luZGV4T2Zmc2V0EigKEG51bV9tYXhfaW52b2ljZXMY'
    'BSABKARSDm51bU1heEludm9pY2VzEhoKCHJldmVyc2VkGAYgASgIUghyZXZlcnNlZBIuChNjcm'
    'VhdGlvbl9kYXRlX3N0YXJ0GAcgASgEUhFjcmVhdGlvbkRhdGVTdGFydBIqChFjcmVhdGlvbl9k'
    'YXRlX2VuZBgIIAEoBFIPY3JlYXRpb25EYXRlRW5k');

@$core.Deprecated('Use listInvoiceResponseDescriptor instead')
const ListInvoiceResponse$json = {
  '1': 'ListInvoiceResponse',
  '2': [
    {'1': 'invoices', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.Invoice', '10': 'invoices'},
    {'1': 'last_index_offset', '3': 2, '4': 1, '5': 4, '10': 'lastIndexOffset'},
    {'1': 'first_index_offset', '3': 3, '4': 1, '5': 4, '10': 'firstIndexOffset'},
  ],
};

/// Descriptor for `ListInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listInvoiceResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0SW52b2ljZVJlc3BvbnNlEioKCGludm9pY2VzGAEgAygLMg4ubG5ycGMuSW52b2ljZV'
    'IIaW52b2ljZXMSKgoRbGFzdF9pbmRleF9vZmZzZXQYAiABKARSD2xhc3RJbmRleE9mZnNldBIs'
    'ChJmaXJzdF9pbmRleF9vZmZzZXQYAyABKARSEGZpcnN0SW5kZXhPZmZzZXQ=');

@$core.Deprecated('Use invoiceSubscriptionDescriptor instead')
const InvoiceSubscription$json = {
  '1': 'InvoiceSubscription',
  '2': [
    {'1': 'add_index', '3': 1, '4': 1, '5': 4, '10': 'addIndex'},
    {'1': 'settle_index', '3': 2, '4': 1, '5': 4, '10': 'settleIndex'},
  ],
};

/// Descriptor for `InvoiceSubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List invoiceSubscriptionDescriptor = $convert.base64Decode(
    'ChNJbnZvaWNlU3Vic2NyaXB0aW9uEhsKCWFkZF9pbmRleBgBIAEoBFIIYWRkSW5kZXgSIQoMc2'
    'V0dGxlX2luZGV4GAIgASgEUgtzZXR0bGVJbmRleA==');

@$core.Deprecated('Use paymentDescriptor instead')
const Payment$json = {
  '1': 'Payment',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 9, '10': 'paymentHash'},
    {
      '1': 'value',
      '3': 2,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'value',
    },
    {
      '1': 'creation_date',
      '3': 3,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'creationDate',
    },
    {
      '1': 'fee',
      '3': 5,
      '4': 1,
      '5': 3,
      '8': {'3': true},
      '10': 'fee',
    },
    {'1': 'payment_preimage', '3': 6, '4': 1, '5': 9, '10': 'paymentPreimage'},
    {'1': 'value_sat', '3': 7, '4': 1, '5': 3, '10': 'valueSat'},
    {'1': 'value_msat', '3': 8, '4': 1, '5': 3, '10': 'valueMsat'},
    {'1': 'payment_request', '3': 9, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'status', '3': 10, '4': 1, '5': 14, '6': '.lnrpc.Payment.PaymentStatus', '10': 'status'},
    {'1': 'fee_sat', '3': 11, '4': 1, '5': 3, '10': 'feeSat'},
    {'1': 'fee_msat', '3': 12, '4': 1, '5': 3, '10': 'feeMsat'},
    {'1': 'creation_time_ns', '3': 13, '4': 1, '5': 3, '10': 'creationTimeNs'},
    {'1': 'htlcs', '3': 14, '4': 3, '5': 11, '6': '.lnrpc.HTLCAttempt', '10': 'htlcs'},
    {'1': 'payment_index', '3': 15, '4': 1, '5': 4, '10': 'paymentIndex'},
    {'1': 'failure_reason', '3': 16, '4': 1, '5': 14, '6': '.lnrpc.PaymentFailureReason', '10': 'failureReason'},
    {'1': 'first_hop_custom_records', '3': 17, '4': 3, '5': 11, '6': '.lnrpc.Payment.FirstHopCustomRecordsEntry', '10': 'firstHopCustomRecords'},
  ],
  '3': [Payment_FirstHopCustomRecordsEntry$json],
  '4': [Payment_PaymentStatus$json],
  '9': [
    {'1': 4, '2': 5},
  ],
};

@$core.Deprecated('Use paymentDescriptor instead')
const Payment_FirstHopCustomRecordsEntry$json = {
  '1': 'FirstHopCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use paymentDescriptor instead')
const Payment_PaymentStatus$json = {
  '1': 'PaymentStatus',
  '2': [
    {
      '1': 'UNKNOWN',
      '2': 0,
      '3': {'1': true},
    },
    {'1': 'IN_FLIGHT', '2': 1},
    {'1': 'SUCCEEDED', '2': 2},
    {'1': 'FAILED', '2': 3},
    {'1': 'INITIATED', '2': 4},
  ],
};

/// Descriptor for `Payment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentDescriptor = $convert.base64Decode(
    'CgdQYXltZW50EiEKDHBheW1lbnRfaGFzaBgBIAEoCVILcGF5bWVudEhhc2gSGAoFdmFsdWUYAi'
    'ABKANCAhgBUgV2YWx1ZRInCg1jcmVhdGlvbl9kYXRlGAMgASgDQgIYAVIMY3JlYXRpb25EYXRl'
    'EhQKA2ZlZRgFIAEoA0ICGAFSA2ZlZRIpChBwYXltZW50X3ByZWltYWdlGAYgASgJUg9wYXltZW'
    '50UHJlaW1hZ2USGwoJdmFsdWVfc2F0GAcgASgDUgh2YWx1ZVNhdBIdCgp2YWx1ZV9tc2F0GAgg'
    'ASgDUgl2YWx1ZU1zYXQSJwoPcGF5bWVudF9yZXF1ZXN0GAkgASgJUg5wYXltZW50UmVxdWVzdB'
    'I0CgZzdGF0dXMYCiABKA4yHC5sbnJwYy5QYXltZW50LlBheW1lbnRTdGF0dXNSBnN0YXR1cxIX'
    'CgdmZWVfc2F0GAsgASgDUgZmZWVTYXQSGQoIZmVlX21zYXQYDCABKANSB2ZlZU1zYXQSKAoQY3'
    'JlYXRpb25fdGltZV9ucxgNIAEoA1IOY3JlYXRpb25UaW1lTnMSKAoFaHRsY3MYDiADKAsyEi5s'
    'bnJwYy5IVExDQXR0ZW1wdFIFaHRsY3MSIwoNcGF5bWVudF9pbmRleBgPIAEoBFIMcGF5bWVudE'
    'luZGV4EkIKDmZhaWx1cmVfcmVhc29uGBAgASgOMhsubG5ycGMuUGF5bWVudEZhaWx1cmVSZWFz'
    'b25SDWZhaWx1cmVSZWFzb24SYgoYZmlyc3RfaG9wX2N1c3RvbV9yZWNvcmRzGBEgAygLMikubG'
    '5ycGMuUGF5bWVudC5GaXJzdEhvcEN1c3RvbVJlY29yZHNFbnRyeVIVZmlyc3RIb3BDdXN0b21S'
    'ZWNvcmRzGkgKGkZpcnN0SG9wQ3VzdG9tUmVjb3Jkc0VudHJ5EhAKA2tleRgBIAEoBFIDa2V5Eh'
    'QKBXZhbHVlGAIgASgMUgV2YWx1ZToCOAEiWQoNUGF5bWVudFN0YXR1cxIPCgdVTktOT1dOEAAa'
    'AggBEg0KCUlOX0ZMSUdIVBABEg0KCVNVQ0NFRURFRBACEgoKBkZBSUxFRBADEg0KCUlOSVRJQV'
    'RFRBAESgQIBBAF');

@$core.Deprecated('Use hTLCAttemptDescriptor instead')
const HTLCAttempt$json = {
  '1': 'HTLCAttempt',
  '2': [
    {'1': 'attempt_id', '3': 7, '4': 1, '5': 4, '10': 'attemptId'},
    {'1': 'status', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.HTLCAttempt.HTLCStatus', '10': 'status'},
    {'1': 'route', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Route', '10': 'route'},
    {'1': 'attempt_time_ns', '3': 3, '4': 1, '5': 3, '10': 'attemptTimeNs'},
    {'1': 'resolve_time_ns', '3': 4, '4': 1, '5': 3, '10': 'resolveTimeNs'},
    {'1': 'failure', '3': 5, '4': 1, '5': 11, '6': '.lnrpc.Failure', '10': 'failure'},
    {'1': 'preimage', '3': 6, '4': 1, '5': 12, '10': 'preimage'},
  ],
  '4': [HTLCAttempt_HTLCStatus$json],
};

@$core.Deprecated('Use hTLCAttemptDescriptor instead')
const HTLCAttempt_HTLCStatus$json = {
  '1': 'HTLCStatus',
  '2': [
    {'1': 'IN_FLIGHT', '2': 0},
    {'1': 'SUCCEEDED', '2': 1},
    {'1': 'FAILED', '2': 2},
  ],
};

/// Descriptor for `HTLCAttempt`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List hTLCAttemptDescriptor = $convert.base64Decode(
    'CgtIVExDQXR0ZW1wdBIdCgphdHRlbXB0X2lkGAcgASgEUglhdHRlbXB0SWQSNQoGc3RhdHVzGA'
    'EgASgOMh0ubG5ycGMuSFRMQ0F0dGVtcHQuSFRMQ1N0YXR1c1IGc3RhdHVzEiIKBXJvdXRlGAIg'
    'ASgLMgwubG5ycGMuUm91dGVSBXJvdXRlEiYKD2F0dGVtcHRfdGltZV9ucxgDIAEoA1INYXR0ZW'
    '1wdFRpbWVOcxImCg9yZXNvbHZlX3RpbWVfbnMYBCABKANSDXJlc29sdmVUaW1lTnMSKAoHZmFp'
    'bHVyZRgFIAEoCzIOLmxucnBjLkZhaWx1cmVSB2ZhaWx1cmUSGgoIcHJlaW1hZ2UYBiABKAxSCH'
    'ByZWltYWdlIjYKCkhUTENTdGF0dXMSDQoJSU5fRkxJR0hUEAASDQoJU1VDQ0VFREVEEAESCgoG'
    'RkFJTEVEEAI=');

@$core.Deprecated('Use listPaymentsRequestDescriptor instead')
const ListPaymentsRequest$json = {
  '1': 'ListPaymentsRequest',
  '2': [
    {'1': 'include_incomplete', '3': 1, '4': 1, '5': 8, '10': 'includeIncomplete'},
    {'1': 'index_offset', '3': 2, '4': 1, '5': 4, '10': 'indexOffset'},
    {'1': 'max_payments', '3': 3, '4': 1, '5': 4, '10': 'maxPayments'},
    {'1': 'reversed', '3': 4, '4': 1, '5': 8, '10': 'reversed'},
    {'1': 'count_total_payments', '3': 5, '4': 1, '5': 8, '10': 'countTotalPayments'},
    {'1': 'creation_date_start', '3': 6, '4': 1, '5': 4, '10': 'creationDateStart'},
    {'1': 'creation_date_end', '3': 7, '4': 1, '5': 4, '10': 'creationDateEnd'},
  ],
};

/// Descriptor for `ListPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaymentsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0UGF5bWVudHNSZXF1ZXN0Ei0KEmluY2x1ZGVfaW5jb21wbGV0ZRgBIAEoCFIRaW5jbH'
    'VkZUluY29tcGxldGUSIQoMaW5kZXhfb2Zmc2V0GAIgASgEUgtpbmRleE9mZnNldBIhCgxtYXhf'
    'cGF5bWVudHMYAyABKARSC21heFBheW1lbnRzEhoKCHJldmVyc2VkGAQgASgIUghyZXZlcnNlZB'
    'IwChRjb3VudF90b3RhbF9wYXltZW50cxgFIAEoCFISY291bnRUb3RhbFBheW1lbnRzEi4KE2Ny'
    'ZWF0aW9uX2RhdGVfc3RhcnQYBiABKARSEWNyZWF0aW9uRGF0ZVN0YXJ0EioKEWNyZWF0aW9uX2'
    'RhdGVfZW5kGAcgASgEUg9jcmVhdGlvbkRhdGVFbmQ=');

@$core.Deprecated('Use listPaymentsResponseDescriptor instead')
const ListPaymentsResponse$json = {
  '1': 'ListPaymentsResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.Payment', '10': 'payments'},
    {'1': 'first_index_offset', '3': 2, '4': 1, '5': 4, '10': 'firstIndexOffset'},
    {'1': 'last_index_offset', '3': 3, '4': 1, '5': 4, '10': 'lastIndexOffset'},
    {'1': 'total_num_payments', '3': 4, '4': 1, '5': 4, '10': 'totalNumPayments'},
  ],
};

/// Descriptor for `ListPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaymentsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UGF5bWVudHNSZXNwb25zZRIqCghwYXltZW50cxgBIAMoCzIOLmxucnBjLlBheW1lbn'
    'RSCHBheW1lbnRzEiwKEmZpcnN0X2luZGV4X29mZnNldBgCIAEoBFIQZmlyc3RJbmRleE9mZnNl'
    'dBIqChFsYXN0X2luZGV4X29mZnNldBgDIAEoBFIPbGFzdEluZGV4T2Zmc2V0EiwKEnRvdGFsX2'
    '51bV9wYXltZW50cxgEIAEoBFIQdG90YWxOdW1QYXltZW50cw==');

@$core.Deprecated('Use deletePaymentRequestDescriptor instead')
const DeletePaymentRequest$json = {
  '1': 'DeletePaymentRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
    {'1': 'failed_htlcs_only', '3': 2, '4': 1, '5': 8, '10': 'failedHtlcsOnly'},
  ],
};

/// Descriptor for `DeletePaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePaymentRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVQYXltZW50UmVxdWVzdBIhCgxwYXltZW50X2hhc2gYASABKAxSC3BheW1lbnRIYX'
    'NoEioKEWZhaWxlZF9odGxjc19vbmx5GAIgASgIUg9mYWlsZWRIdGxjc09ubHk=');

@$core.Deprecated('Use deleteAllPaymentsRequestDescriptor instead')
const DeleteAllPaymentsRequest$json = {
  '1': 'DeleteAllPaymentsRequest',
  '2': [
    {'1': 'failed_payments_only', '3': 1, '4': 1, '5': 8, '10': 'failedPaymentsOnly'},
    {'1': 'failed_htlcs_only', '3': 2, '4': 1, '5': 8, '10': 'failedHtlcsOnly'},
    {'1': 'all_payments', '3': 3, '4': 1, '5': 8, '10': 'allPayments'},
  ],
};

/// Descriptor for `DeleteAllPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAllPaymentsRequestDescriptor = $convert.base64Decode(
    'ChhEZWxldGVBbGxQYXltZW50c1JlcXVlc3QSMAoUZmFpbGVkX3BheW1lbnRzX29ubHkYASABKA'
    'hSEmZhaWxlZFBheW1lbnRzT25seRIqChFmYWlsZWRfaHRsY3Nfb25seRgCIAEoCFIPZmFpbGVk'
    'SHRsY3NPbmx5EiEKDGFsbF9wYXltZW50cxgDIAEoCFILYWxsUGF5bWVudHM=');

@$core.Deprecated('Use deletePaymentResponseDescriptor instead')
const DeletePaymentResponse$json = {
  '1': 'DeletePaymentResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `DeletePaymentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deletePaymentResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVQYXltZW50UmVzcG9uc2USFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use deleteAllPaymentsResponseDescriptor instead')
const DeleteAllPaymentsResponse$json = {
  '1': 'DeleteAllPaymentsResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `DeleteAllPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAllPaymentsResponseDescriptor = $convert.base64Decode(
    'ChlEZWxldGVBbGxQYXltZW50c1Jlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use abandonChannelRequestDescriptor instead')
const AbandonChannelRequest$json = {
  '1': 'AbandonChannelRequest',
  '2': [
    {'1': 'channel_point', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'channelPoint'},
    {'1': 'pending_funding_shim_only', '3': 2, '4': 1, '5': 8, '10': 'pendingFundingShimOnly'},
    {'1': 'i_know_what_i_am_doing', '3': 3, '4': 1, '5': 8, '10': 'iKnowWhatIAmDoing'},
  ],
};

/// Descriptor for `AbandonChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List abandonChannelRequestDescriptor = $convert.base64Decode(
    'ChVBYmFuZG9uQ2hhbm5lbFJlcXVlc3QSOAoNY2hhbm5lbF9wb2ludBgBIAEoCzITLmxucnBjLk'
    'NoYW5uZWxQb2ludFIMY2hhbm5lbFBvaW50EjkKGXBlbmRpbmdfZnVuZGluZ19zaGltX29ubHkY'
    'AiABKAhSFnBlbmRpbmdGdW5kaW5nU2hpbU9ubHkSMQoWaV9rbm93X3doYXRfaV9hbV9kb2luZx'
    'gDIAEoCFIRaUtub3dXaGF0SUFtRG9pbmc=');

@$core.Deprecated('Use abandonChannelResponseDescriptor instead')
const AbandonChannelResponse$json = {
  '1': 'AbandonChannelResponse',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `AbandonChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List abandonChannelResponseDescriptor = $convert.base64Decode(
    'ChZBYmFuZG9uQ2hhbm5lbFJlc3BvbnNlEhYKBnN0YXR1cxgBIAEoCVIGc3RhdHVz');

@$core.Deprecated('Use debugLevelRequestDescriptor instead')
const DebugLevelRequest$json = {
  '1': 'DebugLevelRequest',
  '2': [
    {'1': 'show', '3': 1, '4': 1, '5': 8, '10': 'show'},
    {'1': 'level_spec', '3': 2, '4': 1, '5': 9, '10': 'levelSpec'},
  ],
};

/// Descriptor for `DebugLevelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debugLevelRequestDescriptor = $convert.base64Decode(
    'ChFEZWJ1Z0xldmVsUmVxdWVzdBISCgRzaG93GAEgASgIUgRzaG93Eh0KCmxldmVsX3NwZWMYAi'
    'ABKAlSCWxldmVsU3BlYw==');

@$core.Deprecated('Use debugLevelResponseDescriptor instead')
const DebugLevelResponse$json = {
  '1': 'DebugLevelResponse',
  '2': [
    {'1': 'sub_systems', '3': 1, '4': 1, '5': 9, '10': 'subSystems'},
  ],
};

/// Descriptor for `DebugLevelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List debugLevelResponseDescriptor = $convert.base64Decode(
    'ChJEZWJ1Z0xldmVsUmVzcG9uc2USHwoLc3ViX3N5c3RlbXMYASABKAlSCnN1YlN5c3RlbXM=');

@$core.Deprecated('Use payReqStringDescriptor instead')
const PayReqString$json = {
  '1': 'PayReqString',
  '2': [
    {'1': 'pay_req', '3': 1, '4': 1, '5': 9, '10': 'payReq'},
  ],
};

/// Descriptor for `PayReqString`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payReqStringDescriptor = $convert.base64Decode(
    'CgxQYXlSZXFTdHJpbmcSFwoHcGF5X3JlcRgBIAEoCVIGcGF5UmVx');

@$core.Deprecated('Use payReqDescriptor instead')
const PayReq$json = {
  '1': 'PayReq',
  '2': [
    {'1': 'destination', '3': 1, '4': 1, '5': 9, '10': 'destination'},
    {'1': 'payment_hash', '3': 2, '4': 1, '5': 9, '10': 'paymentHash'},
    {'1': 'num_satoshis', '3': 3, '4': 1, '5': 3, '10': 'numSatoshis'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 3, '10': 'timestamp'},
    {'1': 'expiry', '3': 5, '4': 1, '5': 3, '10': 'expiry'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '10': 'description'},
    {'1': 'description_hash', '3': 7, '4': 1, '5': 9, '10': 'descriptionHash'},
    {'1': 'fallback_addr', '3': 8, '4': 1, '5': 9, '10': 'fallbackAddr'},
    {'1': 'cltv_expiry', '3': 9, '4': 1, '5': 3, '10': 'cltvExpiry'},
    {'1': 'route_hints', '3': 10, '4': 3, '5': 11, '6': '.lnrpc.RouteHint', '10': 'routeHints'},
    {'1': 'payment_addr', '3': 11, '4': 1, '5': 12, '10': 'paymentAddr'},
    {'1': 'num_msat', '3': 12, '4': 1, '5': 3, '10': 'numMsat'},
    {'1': 'features', '3': 13, '4': 3, '5': 11, '6': '.lnrpc.PayReq.FeaturesEntry', '10': 'features'},
    {'1': 'blinded_paths', '3': 14, '4': 3, '5': 11, '6': '.lnrpc.BlindedPaymentPath', '10': 'blindedPaths'},
  ],
  '3': [PayReq_FeaturesEntry$json],
};

@$core.Deprecated('Use payReqDescriptor instead')
const PayReq_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `PayReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payReqDescriptor = $convert.base64Decode(
    'CgZQYXlSZXESIAoLZGVzdGluYXRpb24YASABKAlSC2Rlc3RpbmF0aW9uEiEKDHBheW1lbnRfaG'
    'FzaBgCIAEoCVILcGF5bWVudEhhc2gSIQoMbnVtX3NhdG9zaGlzGAMgASgDUgtudW1TYXRvc2hp'
    'cxIcCgl0aW1lc3RhbXAYBCABKANSCXRpbWVzdGFtcBIWCgZleHBpcnkYBSABKANSBmV4cGlyeR'
    'IgCgtkZXNjcmlwdGlvbhgGIAEoCVILZGVzY3JpcHRpb24SKQoQZGVzY3JpcHRpb25faGFzaBgH'
    'IAEoCVIPZGVzY3JpcHRpb25IYXNoEiMKDWZhbGxiYWNrX2FkZHIYCCABKAlSDGZhbGxiYWNrQW'
    'RkchIfCgtjbHR2X2V4cGlyeRgJIAEoA1IKY2x0dkV4cGlyeRIxCgtyb3V0ZV9oaW50cxgKIAMo'
    'CzIQLmxucnBjLlJvdXRlSGludFIKcm91dGVIaW50cxIhCgxwYXltZW50X2FkZHIYCyABKAxSC3'
    'BheW1lbnRBZGRyEhkKCG51bV9tc2F0GAwgASgDUgdudW1Nc2F0EjcKCGZlYXR1cmVzGA0gAygL'
    'MhsubG5ycGMuUGF5UmVxLkZlYXR1cmVzRW50cnlSCGZlYXR1cmVzEj4KDWJsaW5kZWRfcGF0aH'
    'MYDiADKAsyGS5sbnJwYy5CbGluZGVkUGF5bWVudFBhdGhSDGJsaW5kZWRQYXRocxpLCg1GZWF0'
    'dXJlc0VudHJ5EhAKA2tleRgBIAEoDVIDa2V5EiQKBXZhbHVlGAIgASgLMg4ubG5ycGMuRmVhdH'
    'VyZVIFdmFsdWU6AjgB');

@$core.Deprecated('Use featureDescriptor instead')
const Feature$json = {
  '1': 'Feature',
  '2': [
    {'1': 'name', '3': 2, '4': 1, '5': 9, '10': 'name'},
    {'1': 'is_required', '3': 3, '4': 1, '5': 8, '10': 'isRequired'},
    {'1': 'is_known', '3': 4, '4': 1, '5': 8, '10': 'isKnown'},
  ],
};

/// Descriptor for `Feature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List featureDescriptor = $convert.base64Decode(
    'CgdGZWF0dXJlEhIKBG5hbWUYAiABKAlSBG5hbWUSHwoLaXNfcmVxdWlyZWQYAyABKAhSCmlzUm'
    'VxdWlyZWQSGQoIaXNfa25vd24YBCABKAhSB2lzS25vd24=');

@$core.Deprecated('Use feeReportRequestDescriptor instead')
const FeeReportRequest$json = {
  '1': 'FeeReportRequest',
};

/// Descriptor for `FeeReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeReportRequestDescriptor = $convert.base64Decode(
    'ChBGZWVSZXBvcnRSZXF1ZXN0');

@$core.Deprecated('Use channelFeeReportDescriptor instead')
const ChannelFeeReport$json = {
  '1': 'ChannelFeeReport',
  '2': [
    {
      '1': 'chan_id',
      '3': 5,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'channel_point', '3': 1, '4': 1, '5': 9, '10': 'channelPoint'},
    {'1': 'base_fee_msat', '3': 2, '4': 1, '5': 3, '10': 'baseFeeMsat'},
    {'1': 'fee_per_mil', '3': 3, '4': 1, '5': 3, '10': 'feePerMil'},
    {'1': 'fee_rate', '3': 4, '4': 1, '5': 1, '10': 'feeRate'},
    {'1': 'inbound_base_fee_msat', '3': 6, '4': 1, '5': 5, '10': 'inboundBaseFeeMsat'},
    {'1': 'inbound_fee_per_mil', '3': 7, '4': 1, '5': 5, '10': 'inboundFeePerMil'},
  ],
};

/// Descriptor for `ChannelFeeReport`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelFeeReportDescriptor = $convert.base64Decode(
    'ChBDaGFubmVsRmVlUmVwb3J0EhsKB2NoYW5faWQYBSABKARCAjABUgZjaGFuSWQSIwoNY2hhbm'
    '5lbF9wb2ludBgBIAEoCVIMY2hhbm5lbFBvaW50EiIKDWJhc2VfZmVlX21zYXQYAiABKANSC2Jh'
    'c2VGZWVNc2F0Eh4KC2ZlZV9wZXJfbWlsGAMgASgDUglmZWVQZXJNaWwSGQoIZmVlX3JhdGUYBC'
    'ABKAFSB2ZlZVJhdGUSMQoVaW5ib3VuZF9iYXNlX2ZlZV9tc2F0GAYgASgFUhJpbmJvdW5kQmFz'
    'ZUZlZU1zYXQSLQoTaW5ib3VuZF9mZWVfcGVyX21pbBgHIAEoBVIQaW5ib3VuZEZlZVBlck1pbA'
    '==');

@$core.Deprecated('Use feeReportResponseDescriptor instead')
const FeeReportResponse$json = {
  '1': 'FeeReportResponse',
  '2': [
    {'1': 'channel_fees', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.ChannelFeeReport', '10': 'channelFees'},
    {'1': 'day_fee_sum', '3': 2, '4': 1, '5': 4, '10': 'dayFeeSum'},
    {'1': 'week_fee_sum', '3': 3, '4': 1, '5': 4, '10': 'weekFeeSum'},
    {'1': 'month_fee_sum', '3': 4, '4': 1, '5': 4, '10': 'monthFeeSum'},
  ],
};

/// Descriptor for `FeeReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feeReportResponseDescriptor = $convert.base64Decode(
    'ChFGZWVSZXBvcnRSZXNwb25zZRI6CgxjaGFubmVsX2ZlZXMYASADKAsyFy5sbnJwYy5DaGFubm'
    'VsRmVlUmVwb3J0UgtjaGFubmVsRmVlcxIeCgtkYXlfZmVlX3N1bRgCIAEoBFIJZGF5RmVlU3Vt'
    'EiAKDHdlZWtfZmVlX3N1bRgDIAEoBFIKd2Vla0ZlZVN1bRIiCg1tb250aF9mZWVfc3VtGAQgAS'
    'gEUgttb250aEZlZVN1bQ==');

@$core.Deprecated('Use inboundFeeDescriptor instead')
const InboundFee$json = {
  '1': 'InboundFee',
  '2': [
    {'1': 'base_fee_msat', '3': 1, '4': 1, '5': 5, '10': 'baseFeeMsat'},
    {'1': 'fee_rate_ppm', '3': 2, '4': 1, '5': 5, '10': 'feeRatePpm'},
  ],
};

/// Descriptor for `InboundFee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inboundFeeDescriptor = $convert.base64Decode(
    'CgpJbmJvdW5kRmVlEiIKDWJhc2VfZmVlX21zYXQYASABKAVSC2Jhc2VGZWVNc2F0EiAKDGZlZV'
    '9yYXRlX3BwbRgCIAEoBVIKZmVlUmF0ZVBwbQ==');

@$core.Deprecated('Use policyUpdateRequestDescriptor instead')
const PolicyUpdateRequest$json = {
  '1': 'PolicyUpdateRequest',
  '2': [
    {'1': 'global', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'global'},
    {'1': 'chan_point', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '9': 0, '10': 'chanPoint'},
    {'1': 'base_fee_msat', '3': 3, '4': 1, '5': 3, '10': 'baseFeeMsat'},
    {'1': 'fee_rate', '3': 4, '4': 1, '5': 1, '10': 'feeRate'},
    {'1': 'fee_rate_ppm', '3': 9, '4': 1, '5': 13, '10': 'feeRatePpm'},
    {'1': 'time_lock_delta', '3': 5, '4': 1, '5': 13, '10': 'timeLockDelta'},
    {'1': 'max_htlc_msat', '3': 6, '4': 1, '5': 4, '10': 'maxHtlcMsat'},
    {'1': 'min_htlc_msat', '3': 7, '4': 1, '5': 4, '10': 'minHtlcMsat'},
    {'1': 'min_htlc_msat_specified', '3': 8, '4': 1, '5': 8, '10': 'minHtlcMsatSpecified'},
    {'1': 'inbound_fee', '3': 10, '4': 1, '5': 11, '6': '.lnrpc.InboundFee', '10': 'inboundFee'},
    {'1': 'create_missing_edge', '3': 11, '4': 1, '5': 8, '10': 'createMissingEdge'},
  ],
  '8': [
    {'1': 'scope'},
  ],
};

/// Descriptor for `PolicyUpdateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyUpdateRequestDescriptor = $convert.base64Decode(
    'ChNQb2xpY3lVcGRhdGVSZXF1ZXN0EhgKBmdsb2JhbBgBIAEoCEgAUgZnbG9iYWwSNAoKY2hhbl'
    '9wb2ludBgCIAEoCzITLmxucnBjLkNoYW5uZWxQb2ludEgAUgljaGFuUG9pbnQSIgoNYmFzZV9m'
    'ZWVfbXNhdBgDIAEoA1ILYmFzZUZlZU1zYXQSGQoIZmVlX3JhdGUYBCABKAFSB2ZlZVJhdGUSIA'
    'oMZmVlX3JhdGVfcHBtGAkgASgNUgpmZWVSYXRlUHBtEiYKD3RpbWVfbG9ja19kZWx0YRgFIAEo'
    'DVINdGltZUxvY2tEZWx0YRIiCg1tYXhfaHRsY19tc2F0GAYgASgEUgttYXhIdGxjTXNhdBIiCg'
    '1taW5faHRsY19tc2F0GAcgASgEUgttaW5IdGxjTXNhdBI1ChdtaW5faHRsY19tc2F0X3NwZWNp'
    'ZmllZBgIIAEoCFIUbWluSHRsY01zYXRTcGVjaWZpZWQSMgoLaW5ib3VuZF9mZWUYCiABKAsyES'
    '5sbnJwYy5JbmJvdW5kRmVlUgppbmJvdW5kRmVlEi4KE2NyZWF0ZV9taXNzaW5nX2VkZ2UYCyAB'
    'KAhSEWNyZWF0ZU1pc3NpbmdFZGdlQgcKBXNjb3Bl');

@$core.Deprecated('Use failedUpdateDescriptor instead')
const FailedUpdate$json = {
  '1': 'FailedUpdate',
  '2': [
    {'1': 'outpoint', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.OutPoint', '10': 'outpoint'},
    {'1': 'reason', '3': 2, '4': 1, '5': 14, '6': '.lnrpc.UpdateFailure', '10': 'reason'},
    {'1': 'update_error', '3': 3, '4': 1, '5': 9, '10': 'updateError'},
  ],
};

/// Descriptor for `FailedUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failedUpdateDescriptor = $convert.base64Decode(
    'CgxGYWlsZWRVcGRhdGUSKwoIb3V0cG9pbnQYASABKAsyDy5sbnJwYy5PdXRQb2ludFIIb3V0cG'
    '9pbnQSLAoGcmVhc29uGAIgASgOMhQubG5ycGMuVXBkYXRlRmFpbHVyZVIGcmVhc29uEiEKDHVw'
    'ZGF0ZV9lcnJvchgDIAEoCVILdXBkYXRlRXJyb3I=');

@$core.Deprecated('Use policyUpdateResponseDescriptor instead')
const PolicyUpdateResponse$json = {
  '1': 'PolicyUpdateResponse',
  '2': [
    {'1': 'failed_updates', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.FailedUpdate', '10': 'failedUpdates'},
  ],
};

/// Descriptor for `PolicyUpdateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List policyUpdateResponseDescriptor = $convert.base64Decode(
    'ChRQb2xpY3lVcGRhdGVSZXNwb25zZRI6Cg5mYWlsZWRfdXBkYXRlcxgBIAMoCzITLmxucnBjLk'
    'ZhaWxlZFVwZGF0ZVINZmFpbGVkVXBkYXRlcw==');

@$core.Deprecated('Use forwardingHistoryRequestDescriptor instead')
const ForwardingHistoryRequest$json = {
  '1': 'ForwardingHistoryRequest',
  '2': [
    {'1': 'start_time', '3': 1, '4': 1, '5': 4, '10': 'startTime'},
    {'1': 'end_time', '3': 2, '4': 1, '5': 4, '10': 'endTime'},
    {'1': 'index_offset', '3': 3, '4': 1, '5': 13, '10': 'indexOffset'},
    {'1': 'num_max_events', '3': 4, '4': 1, '5': 13, '10': 'numMaxEvents'},
    {'1': 'peer_alias_lookup', '3': 5, '4': 1, '5': 8, '10': 'peerAliasLookup'},
  ],
};

/// Descriptor for `ForwardingHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardingHistoryRequestDescriptor = $convert.base64Decode(
    'ChhGb3J3YXJkaW5nSGlzdG9yeVJlcXVlc3QSHQoKc3RhcnRfdGltZRgBIAEoBFIJc3RhcnRUaW'
    '1lEhkKCGVuZF90aW1lGAIgASgEUgdlbmRUaW1lEiEKDGluZGV4X29mZnNldBgDIAEoDVILaW5k'
    'ZXhPZmZzZXQSJAoObnVtX21heF9ldmVudHMYBCABKA1SDG51bU1heEV2ZW50cxIqChFwZWVyX2'
    'FsaWFzX2xvb2t1cBgFIAEoCFIPcGVlckFsaWFzTG9va3Vw');

@$core.Deprecated('Use forwardingEventDescriptor instead')
const ForwardingEvent$json = {
  '1': 'ForwardingEvent',
  '2': [
    {
      '1': 'timestamp',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'3': true},
      '10': 'timestamp',
    },
    {
      '1': 'chan_id_in',
      '3': 2,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanIdIn',
    },
    {
      '1': 'chan_id_out',
      '3': 4,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanIdOut',
    },
    {'1': 'amt_in', '3': 5, '4': 1, '5': 4, '10': 'amtIn'},
    {'1': 'amt_out', '3': 6, '4': 1, '5': 4, '10': 'amtOut'},
    {'1': 'fee', '3': 7, '4': 1, '5': 4, '10': 'fee'},
    {'1': 'fee_msat', '3': 8, '4': 1, '5': 4, '10': 'feeMsat'},
    {'1': 'amt_in_msat', '3': 9, '4': 1, '5': 4, '10': 'amtInMsat'},
    {'1': 'amt_out_msat', '3': 10, '4': 1, '5': 4, '10': 'amtOutMsat'},
    {'1': 'timestamp_ns', '3': 11, '4': 1, '5': 4, '10': 'timestampNs'},
    {'1': 'peer_alias_in', '3': 12, '4': 1, '5': 9, '10': 'peerAliasIn'},
    {'1': 'peer_alias_out', '3': 13, '4': 1, '5': 9, '10': 'peerAliasOut'},
  ],
};

/// Descriptor for `ForwardingEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardingEventDescriptor = $convert.base64Decode(
    'Cg9Gb3J3YXJkaW5nRXZlbnQSIAoJdGltZXN0YW1wGAEgASgEQgIYAVIJdGltZXN0YW1wEiAKCm'
    'NoYW5faWRfaW4YAiABKARCAjABUghjaGFuSWRJbhIiCgtjaGFuX2lkX291dBgEIAEoBEICMAFS'
    'CWNoYW5JZE91dBIVCgZhbXRfaW4YBSABKARSBWFtdEluEhcKB2FtdF9vdXQYBiABKARSBmFtdE'
    '91dBIQCgNmZWUYByABKARSA2ZlZRIZCghmZWVfbXNhdBgIIAEoBFIHZmVlTXNhdBIeCgthbXRf'
    'aW5fbXNhdBgJIAEoBFIJYW10SW5Nc2F0EiAKDGFtdF9vdXRfbXNhdBgKIAEoBFIKYW10T3V0TX'
    'NhdBIhCgx0aW1lc3RhbXBfbnMYCyABKARSC3RpbWVzdGFtcE5zEiIKDXBlZXJfYWxpYXNfaW4Y'
    'DCABKAlSC3BlZXJBbGlhc0luEiQKDnBlZXJfYWxpYXNfb3V0GA0gASgJUgxwZWVyQWxpYXNPdX'
    'Q=');

@$core.Deprecated('Use forwardingHistoryResponseDescriptor instead')
const ForwardingHistoryResponse$json = {
  '1': 'ForwardingHistoryResponse',
  '2': [
    {'1': 'forwarding_events', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.ForwardingEvent', '10': 'forwardingEvents'},
    {'1': 'last_offset_index', '3': 2, '4': 1, '5': 13, '10': 'lastOffsetIndex'},
  ],
};

/// Descriptor for `ForwardingHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardingHistoryResponseDescriptor = $convert.base64Decode(
    'ChlGb3J3YXJkaW5nSGlzdG9yeVJlc3BvbnNlEkMKEWZvcndhcmRpbmdfZXZlbnRzGAEgAygLMh'
    'YubG5ycGMuRm9yd2FyZGluZ0V2ZW50UhBmb3J3YXJkaW5nRXZlbnRzEioKEWxhc3Rfb2Zmc2V0'
    'X2luZGV4GAIgASgNUg9sYXN0T2Zmc2V0SW5kZXg=');

@$core.Deprecated('Use exportChannelBackupRequestDescriptor instead')
const ExportChannelBackupRequest$json = {
  '1': 'ExportChannelBackupRequest',
  '2': [
    {'1': 'chan_point', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoint'},
  ],
};

/// Descriptor for `ExportChannelBackupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportChannelBackupRequestDescriptor = $convert.base64Decode(
    'ChpFeHBvcnRDaGFubmVsQmFja3VwUmVxdWVzdBIyCgpjaGFuX3BvaW50GAEgASgLMhMubG5ycG'
    'MuQ2hhbm5lbFBvaW50UgljaGFuUG9pbnQ=');

@$core.Deprecated('Use channelBackupDescriptor instead')
const ChannelBackup$json = {
  '1': 'ChannelBackup',
  '2': [
    {'1': 'chan_point', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoint'},
    {'1': 'chan_backup', '3': 2, '4': 1, '5': 12, '10': 'chanBackup'},
  ],
};

/// Descriptor for `ChannelBackup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelBackupDescriptor = $convert.base64Decode(
    'Cg1DaGFubmVsQmFja3VwEjIKCmNoYW5fcG9pbnQYASABKAsyEy5sbnJwYy5DaGFubmVsUG9pbn'
    'RSCWNoYW5Qb2ludBIfCgtjaGFuX2JhY2t1cBgCIAEoDFIKY2hhbkJhY2t1cA==');

@$core.Deprecated('Use multiChanBackupDescriptor instead')
const MultiChanBackup$json = {
  '1': 'MultiChanBackup',
  '2': [
    {'1': 'chan_points', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoints'},
    {'1': 'multi_chan_backup', '3': 2, '4': 1, '5': 12, '10': 'multiChanBackup'},
  ],
};

/// Descriptor for `MultiChanBackup`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multiChanBackupDescriptor = $convert.base64Decode(
    'Cg9NdWx0aUNoYW5CYWNrdXASNAoLY2hhbl9wb2ludHMYASADKAsyEy5sbnJwYy5DaGFubmVsUG'
    '9pbnRSCmNoYW5Qb2ludHMSKgoRbXVsdGlfY2hhbl9iYWNrdXAYAiABKAxSD211bHRpQ2hhbkJh'
    'Y2t1cA==');

@$core.Deprecated('Use chanBackupExportRequestDescriptor instead')
const ChanBackupExportRequest$json = {
  '1': 'ChanBackupExportRequest',
};

/// Descriptor for `ChanBackupExportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chanBackupExportRequestDescriptor = $convert.base64Decode(
    'ChdDaGFuQmFja3VwRXhwb3J0UmVxdWVzdA==');

@$core.Deprecated('Use chanBackupSnapshotDescriptor instead')
const ChanBackupSnapshot$json = {
  '1': 'ChanBackupSnapshot',
  '2': [
    {'1': 'single_chan_backups', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelBackups', '10': 'singleChanBackups'},
    {'1': 'multi_chan_backup', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.MultiChanBackup', '10': 'multiChanBackup'},
  ],
};

/// Descriptor for `ChanBackupSnapshot`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chanBackupSnapshotDescriptor = $convert.base64Decode(
    'ChJDaGFuQmFja3VwU25hcHNob3QSRQoTc2luZ2xlX2NoYW5fYmFja3VwcxgBIAEoCzIVLmxucn'
    'BjLkNoYW5uZWxCYWNrdXBzUhFzaW5nbGVDaGFuQmFja3VwcxJCChFtdWx0aV9jaGFuX2JhY2t1'
    'cBgCIAEoCzIWLmxucnBjLk11bHRpQ2hhbkJhY2t1cFIPbXVsdGlDaGFuQmFja3Vw');

@$core.Deprecated('Use channelBackupsDescriptor instead')
const ChannelBackups$json = {
  '1': 'ChannelBackups',
  '2': [
    {'1': 'chan_backups', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.ChannelBackup', '10': 'chanBackups'},
  ],
};

/// Descriptor for `ChannelBackups`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelBackupsDescriptor = $convert.base64Decode(
    'Cg5DaGFubmVsQmFja3VwcxI3CgxjaGFuX2JhY2t1cHMYASADKAsyFC5sbnJwYy5DaGFubmVsQm'
    'Fja3VwUgtjaGFuQmFja3Vwcw==');

@$core.Deprecated('Use restoreChanBackupRequestDescriptor instead')
const RestoreChanBackupRequest$json = {
  '1': 'RestoreChanBackupRequest',
  '2': [
    {'1': 'chan_backups', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelBackups', '9': 0, '10': 'chanBackups'},
    {'1': 'multi_chan_backup', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'multiChanBackup'},
  ],
  '8': [
    {'1': 'backup'},
  ],
};

/// Descriptor for `RestoreChanBackupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreChanBackupRequestDescriptor = $convert.base64Decode(
    'ChhSZXN0b3JlQ2hhbkJhY2t1cFJlcXVlc3QSOgoMY2hhbl9iYWNrdXBzGAEgASgLMhUubG5ycG'
    'MuQ2hhbm5lbEJhY2t1cHNIAFILY2hhbkJhY2t1cHMSLAoRbXVsdGlfY2hhbl9iYWNrdXAYAiAB'
    'KAxIAFIPbXVsdGlDaGFuQmFja3VwQggKBmJhY2t1cA==');

@$core.Deprecated('Use restoreBackupResponseDescriptor instead')
const RestoreBackupResponse$json = {
  '1': 'RestoreBackupResponse',
  '2': [
    {'1': 'num_restored', '3': 1, '4': 1, '5': 13, '10': 'numRestored'},
  ],
};

/// Descriptor for `RestoreBackupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List restoreBackupResponseDescriptor = $convert.base64Decode(
    'ChVSZXN0b3JlQmFja3VwUmVzcG9uc2USIQoMbnVtX3Jlc3RvcmVkGAEgASgNUgtudW1SZXN0b3'
    'JlZA==');

@$core.Deprecated('Use channelBackupSubscriptionDescriptor instead')
const ChannelBackupSubscription$json = {
  '1': 'ChannelBackupSubscription',
};

/// Descriptor for `ChannelBackupSubscription`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelBackupSubscriptionDescriptor = $convert.base64Decode(
    'ChlDaGFubmVsQmFja3VwU3Vic2NyaXB0aW9u');

@$core.Deprecated('Use verifyChanBackupResponseDescriptor instead')
const VerifyChanBackupResponse$json = {
  '1': 'VerifyChanBackupResponse',
  '2': [
    {'1': 'chan_points', '3': 1, '4': 3, '5': 9, '10': 'chanPoints'},
  ],
};

/// Descriptor for `VerifyChanBackupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyChanBackupResponseDescriptor = $convert.base64Decode(
    'ChhWZXJpZnlDaGFuQmFja3VwUmVzcG9uc2USHwoLY2hhbl9wb2ludHMYASADKAlSCmNoYW5Qb2'
    'ludHM=');

@$core.Deprecated('Use macaroonPermissionDescriptor instead')
const MacaroonPermission$json = {
  '1': 'MacaroonPermission',
  '2': [
    {'1': 'entity', '3': 1, '4': 1, '5': 9, '10': 'entity'},
    {'1': 'action', '3': 2, '4': 1, '5': 9, '10': 'action'},
  ],
};

/// Descriptor for `MacaroonPermission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List macaroonPermissionDescriptor = $convert.base64Decode(
    'ChJNYWNhcm9vblBlcm1pc3Npb24SFgoGZW50aXR5GAEgASgJUgZlbnRpdHkSFgoGYWN0aW9uGA'
    'IgASgJUgZhY3Rpb24=');

@$core.Deprecated('Use bakeMacaroonRequestDescriptor instead')
const BakeMacaroonRequest$json = {
  '1': 'BakeMacaroonRequest',
  '2': [
    {'1': 'permissions', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.MacaroonPermission', '10': 'permissions'},
    {'1': 'root_key_id', '3': 2, '4': 1, '5': 4, '10': 'rootKeyId'},
    {'1': 'allow_external_permissions', '3': 3, '4': 1, '5': 8, '10': 'allowExternalPermissions'},
  ],
};

/// Descriptor for `BakeMacaroonRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakeMacaroonRequestDescriptor = $convert.base64Decode(
    'ChNCYWtlTWFjYXJvb25SZXF1ZXN0EjsKC3Blcm1pc3Npb25zGAEgAygLMhkubG5ycGMuTWFjYX'
    'Jvb25QZXJtaXNzaW9uUgtwZXJtaXNzaW9ucxIeCgtyb290X2tleV9pZBgCIAEoBFIJcm9vdEtl'
    'eUlkEjwKGmFsbG93X2V4dGVybmFsX3Blcm1pc3Npb25zGAMgASgIUhhhbGxvd0V4dGVybmFsUG'
    'VybWlzc2lvbnM=');

@$core.Deprecated('Use bakeMacaroonResponseDescriptor instead')
const BakeMacaroonResponse$json = {
  '1': 'BakeMacaroonResponse',
  '2': [
    {'1': 'macaroon', '3': 1, '4': 1, '5': 9, '10': 'macaroon'},
  ],
};

/// Descriptor for `BakeMacaroonResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bakeMacaroonResponseDescriptor = $convert.base64Decode(
    'ChRCYWtlTWFjYXJvb25SZXNwb25zZRIaCghtYWNhcm9vbhgBIAEoCVIIbWFjYXJvb24=');

@$core.Deprecated('Use listMacaroonIDsRequestDescriptor instead')
const ListMacaroonIDsRequest$json = {
  '1': 'ListMacaroonIDsRequest',
};

/// Descriptor for `ListMacaroonIDsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMacaroonIDsRequestDescriptor = $convert.base64Decode(
    'ChZMaXN0TWFjYXJvb25JRHNSZXF1ZXN0');

@$core.Deprecated('Use listMacaroonIDsResponseDescriptor instead')
const ListMacaroonIDsResponse$json = {
  '1': 'ListMacaroonIDsResponse',
  '2': [
    {'1': 'root_key_ids', '3': 1, '4': 3, '5': 4, '10': 'rootKeyIds'},
  ],
};

/// Descriptor for `ListMacaroonIDsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMacaroonIDsResponseDescriptor = $convert.base64Decode(
    'ChdMaXN0TWFjYXJvb25JRHNSZXNwb25zZRIgCgxyb290X2tleV9pZHMYASADKARSCnJvb3RLZX'
    'lJZHM=');

@$core.Deprecated('Use deleteMacaroonIDRequestDescriptor instead')
const DeleteMacaroonIDRequest$json = {
  '1': 'DeleteMacaroonIDRequest',
  '2': [
    {'1': 'root_key_id', '3': 1, '4': 1, '5': 4, '10': 'rootKeyId'},
  ],
};

/// Descriptor for `DeleteMacaroonIDRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMacaroonIDRequestDescriptor = $convert.base64Decode(
    'ChdEZWxldGVNYWNhcm9vbklEUmVxdWVzdBIeCgtyb290X2tleV9pZBgBIAEoBFIJcm9vdEtleU'
    'lk');

@$core.Deprecated('Use deleteMacaroonIDResponseDescriptor instead')
const DeleteMacaroonIDResponse$json = {
  '1': 'DeleteMacaroonIDResponse',
  '2': [
    {'1': 'deleted', '3': 1, '4': 1, '5': 8, '10': 'deleted'},
  ],
};

/// Descriptor for `DeleteMacaroonIDResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMacaroonIDResponseDescriptor = $convert.base64Decode(
    'ChhEZWxldGVNYWNhcm9vbklEUmVzcG9uc2USGAoHZGVsZXRlZBgBIAEoCFIHZGVsZXRlZA==');

@$core.Deprecated('Use macaroonPermissionListDescriptor instead')
const MacaroonPermissionList$json = {
  '1': 'MacaroonPermissionList',
  '2': [
    {'1': 'permissions', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.MacaroonPermission', '10': 'permissions'},
  ],
};

/// Descriptor for `MacaroonPermissionList`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List macaroonPermissionListDescriptor = $convert.base64Decode(
    'ChZNYWNhcm9vblBlcm1pc3Npb25MaXN0EjsKC3Blcm1pc3Npb25zGAEgAygLMhkubG5ycGMuTW'
    'FjYXJvb25QZXJtaXNzaW9uUgtwZXJtaXNzaW9ucw==');

@$core.Deprecated('Use listPermissionsRequestDescriptor instead')
const ListPermissionsRequest$json = {
  '1': 'ListPermissionsRequest',
};

/// Descriptor for `ListPermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPermissionsRequestDescriptor = $convert.base64Decode(
    'ChZMaXN0UGVybWlzc2lvbnNSZXF1ZXN0');

@$core.Deprecated('Use listPermissionsResponseDescriptor instead')
const ListPermissionsResponse$json = {
  '1': 'ListPermissionsResponse',
  '2': [
    {'1': 'method_permissions', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.ListPermissionsResponse.MethodPermissionsEntry', '10': 'methodPermissions'},
  ],
  '3': [ListPermissionsResponse_MethodPermissionsEntry$json],
};

@$core.Deprecated('Use listPermissionsResponseDescriptor instead')
const ListPermissionsResponse_MethodPermissionsEntry$json = {
  '1': 'MethodPermissionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.MacaroonPermissionList', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ListPermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPermissionsResponseDescriptor = $convert.base64Decode(
    'ChdMaXN0UGVybWlzc2lvbnNSZXNwb25zZRJkChJtZXRob2RfcGVybWlzc2lvbnMYASADKAsyNS'
    '5sbnJwYy5MaXN0UGVybWlzc2lvbnNSZXNwb25zZS5NZXRob2RQZXJtaXNzaW9uc0VudHJ5UhFt'
    'ZXRob2RQZXJtaXNzaW9ucxpjChZNZXRob2RQZXJtaXNzaW9uc0VudHJ5EhAKA2tleRgBIAEoCV'
    'IDa2V5EjMKBXZhbHVlGAIgASgLMh0ubG5ycGMuTWFjYXJvb25QZXJtaXNzaW9uTGlzdFIFdmFs'
    'dWU6AjgB');

@$core.Deprecated('Use failureDescriptor instead')
const Failure$json = {
  '1': 'Failure',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 14, '6': '.lnrpc.Failure.FailureCode', '10': 'code'},
    {'1': 'channel_update', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.ChannelUpdate', '10': 'channelUpdate'},
    {'1': 'htlc_msat', '3': 4, '4': 1, '5': 4, '10': 'htlcMsat'},
    {'1': 'onion_sha_256', '3': 5, '4': 1, '5': 12, '10': 'onionSha256'},
    {'1': 'cltv_expiry', '3': 6, '4': 1, '5': 13, '10': 'cltvExpiry'},
    {'1': 'flags', '3': 7, '4': 1, '5': 13, '10': 'flags'},
    {'1': 'failure_source_index', '3': 8, '4': 1, '5': 13, '10': 'failureSourceIndex'},
    {'1': 'height', '3': 9, '4': 1, '5': 13, '10': 'height'},
  ],
  '4': [Failure_FailureCode$json],
  '9': [
    {'1': 2, '2': 3},
  ],
};

@$core.Deprecated('Use failureDescriptor instead')
const Failure_FailureCode$json = {
  '1': 'FailureCode',
  '2': [
    {'1': 'RESERVED', '2': 0},
    {'1': 'INCORRECT_OR_UNKNOWN_PAYMENT_DETAILS', '2': 1},
    {'1': 'INCORRECT_PAYMENT_AMOUNT', '2': 2},
    {'1': 'FINAL_INCORRECT_CLTV_EXPIRY', '2': 3},
    {'1': 'FINAL_INCORRECT_HTLC_AMOUNT', '2': 4},
    {'1': 'FINAL_EXPIRY_TOO_SOON', '2': 5},
    {'1': 'INVALID_REALM', '2': 6},
    {'1': 'EXPIRY_TOO_SOON', '2': 7},
    {'1': 'INVALID_ONION_VERSION', '2': 8},
    {'1': 'INVALID_ONION_HMAC', '2': 9},
    {'1': 'INVALID_ONION_KEY', '2': 10},
    {'1': 'AMOUNT_BELOW_MINIMUM', '2': 11},
    {'1': 'FEE_INSUFFICIENT', '2': 12},
    {'1': 'INCORRECT_CLTV_EXPIRY', '2': 13},
    {'1': 'CHANNEL_DISABLED', '2': 14},
    {'1': 'TEMPORARY_CHANNEL_FAILURE', '2': 15},
    {'1': 'REQUIRED_NODE_FEATURE_MISSING', '2': 16},
    {'1': 'REQUIRED_CHANNEL_FEATURE_MISSING', '2': 17},
    {'1': 'UNKNOWN_NEXT_PEER', '2': 18},
    {'1': 'TEMPORARY_NODE_FAILURE', '2': 19},
    {'1': 'PERMANENT_NODE_FAILURE', '2': 20},
    {'1': 'PERMANENT_CHANNEL_FAILURE', '2': 21},
    {'1': 'EXPIRY_TOO_FAR', '2': 22},
    {'1': 'MPP_TIMEOUT', '2': 23},
    {'1': 'INVALID_ONION_PAYLOAD', '2': 24},
    {'1': 'INVALID_ONION_BLINDING', '2': 25},
    {'1': 'INTERNAL_FAILURE', '2': 997},
    {'1': 'UNKNOWN_FAILURE', '2': 998},
    {'1': 'UNREADABLE_FAILURE', '2': 999},
  ],
};

/// Descriptor for `Failure`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List failureDescriptor = $convert.base64Decode(
    'CgdGYWlsdXJlEi4KBGNvZGUYASABKA4yGi5sbnJwYy5GYWlsdXJlLkZhaWx1cmVDb2RlUgRjb2'
    'RlEjsKDmNoYW5uZWxfdXBkYXRlGAMgASgLMhQubG5ycGMuQ2hhbm5lbFVwZGF0ZVINY2hhbm5l'
    'bFVwZGF0ZRIbCglodGxjX21zYXQYBCABKARSCGh0bGNNc2F0EiIKDW9uaW9uX3NoYV8yNTYYBS'
    'ABKAxSC29uaW9uU2hhMjU2Eh8KC2NsdHZfZXhwaXJ5GAYgASgNUgpjbHR2RXhwaXJ5EhQKBWZs'
    'YWdzGAcgASgNUgVmbGFncxIwChRmYWlsdXJlX3NvdXJjZV9pbmRleBgIIAEoDVISZmFpbHVyZV'
    'NvdXJjZUluZGV4EhYKBmhlaWdodBgJIAEoDVIGaGVpZ2h0IosGCgtGYWlsdXJlQ29kZRIMCghS'
    'RVNFUlZFRBAAEigKJElOQ09SUkVDVF9PUl9VTktOT1dOX1BBWU1FTlRfREVUQUlMUxABEhwKGE'
    'lOQ09SUkVDVF9QQVlNRU5UX0FNT1VOVBACEh8KG0ZJTkFMX0lOQ09SUkVDVF9DTFRWX0VYUElS'
    'WRADEh8KG0ZJTkFMX0lOQ09SUkVDVF9IVExDX0FNT1VOVBAEEhkKFUZJTkFMX0VYUElSWV9UT0'
    '9fU09PThAFEhEKDUlOVkFMSURfUkVBTE0QBhITCg9FWFBJUllfVE9PX1NPT04QBxIZChVJTlZB'
    'TElEX09OSU9OX1ZFUlNJT04QCBIWChJJTlZBTElEX09OSU9OX0hNQUMQCRIVChFJTlZBTElEX0'
    '9OSU9OX0tFWRAKEhgKFEFNT1VOVF9CRUxPV19NSU5JTVVNEAsSFAoQRkVFX0lOU1VGRklDSUVO'
    'VBAMEhkKFUlOQ09SUkVDVF9DTFRWX0VYUElSWRANEhQKEENIQU5ORUxfRElTQUJMRUQQDhIdCh'
    'lURU1QT1JBUllfQ0hBTk5FTF9GQUlMVVJFEA8SIQodUkVRVUlSRURfTk9ERV9GRUFUVVJFX01J'
    'U1NJTkcQEBIkCiBSRVFVSVJFRF9DSEFOTkVMX0ZFQVRVUkVfTUlTU0lORxAREhUKEVVOS05PV0'
    '5fTkVYVF9QRUVSEBISGgoWVEVNUE9SQVJZX05PREVfRkFJTFVSRRATEhoKFlBFUk1BTkVOVF9O'
    'T0RFX0ZBSUxVUkUQFBIdChlQRVJNQU5FTlRfQ0hBTk5FTF9GQUlMVVJFEBUSEgoORVhQSVJZX1'
    'RPT19GQVIQFhIPCgtNUFBfVElNRU9VVBAXEhkKFUlOVkFMSURfT05JT05fUEFZTE9BRBAYEhoK'
    'FklOVkFMSURfT05JT05fQkxJTkRJTkcQGRIVChBJTlRFUk5BTF9GQUlMVVJFEOUHEhQKD1VOS0'
    '5PV05fRkFJTFVSRRDmBxIXChJVTlJFQURBQkxFX0ZBSUxVUkUQ5wdKBAgCEAM=');

@$core.Deprecated('Use channelUpdateDescriptor instead')
const ChannelUpdate$json = {
  '1': 'ChannelUpdate',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 12, '10': 'signature'},
    {'1': 'chain_hash', '3': 2, '4': 1, '5': 12, '10': 'chainHash'},
    {
      '1': 'chan_id',
      '3': 3,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'chanId',
    },
    {'1': 'timestamp', '3': 4, '4': 1, '5': 13, '10': 'timestamp'},
    {'1': 'message_flags', '3': 10, '4': 1, '5': 13, '10': 'messageFlags'},
    {'1': 'channel_flags', '3': 5, '4': 1, '5': 13, '10': 'channelFlags'},
    {'1': 'time_lock_delta', '3': 6, '4': 1, '5': 13, '10': 'timeLockDelta'},
    {'1': 'htlc_minimum_msat', '3': 7, '4': 1, '5': 4, '10': 'htlcMinimumMsat'},
    {'1': 'base_fee', '3': 8, '4': 1, '5': 13, '10': 'baseFee'},
    {'1': 'fee_rate', '3': 9, '4': 1, '5': 13, '10': 'feeRate'},
    {'1': 'htlc_maximum_msat', '3': 11, '4': 1, '5': 4, '10': 'htlcMaximumMsat'},
    {'1': 'extra_opaque_data', '3': 12, '4': 1, '5': 12, '10': 'extraOpaqueData'},
  ],
};

/// Descriptor for `ChannelUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelUpdateDescriptor = $convert.base64Decode(
    'Cg1DaGFubmVsVXBkYXRlEhwKCXNpZ25hdHVyZRgBIAEoDFIJc2lnbmF0dXJlEh0KCmNoYWluX2'
    'hhc2gYAiABKAxSCWNoYWluSGFzaBIbCgdjaGFuX2lkGAMgASgEQgIwAVIGY2hhbklkEhwKCXRp'
    'bWVzdGFtcBgEIAEoDVIJdGltZXN0YW1wEiMKDW1lc3NhZ2VfZmxhZ3MYCiABKA1SDG1lc3NhZ2'
    'VGbGFncxIjCg1jaGFubmVsX2ZsYWdzGAUgASgNUgxjaGFubmVsRmxhZ3MSJgoPdGltZV9sb2Nr'
    'X2RlbHRhGAYgASgNUg10aW1lTG9ja0RlbHRhEioKEWh0bGNfbWluaW11bV9tc2F0GAcgASgEUg'
    '9odGxjTWluaW11bU1zYXQSGQoIYmFzZV9mZWUYCCABKA1SB2Jhc2VGZWUSGQoIZmVlX3JhdGUY'
    'CSABKA1SB2ZlZVJhdGUSKgoRaHRsY19tYXhpbXVtX21zYXQYCyABKARSD2h0bGNNYXhpbXVtTX'
    'NhdBIqChFleHRyYV9vcGFxdWVfZGF0YRgMIAEoDFIPZXh0cmFPcGFxdWVEYXRh');

@$core.Deprecated('Use macaroonIdDescriptor instead')
const MacaroonId$json = {
  '1': 'MacaroonId',
  '2': [
    {'1': 'nonce', '3': 1, '4': 1, '5': 12, '10': 'nonce'},
    {'1': 'storageId', '3': 2, '4': 1, '5': 12, '10': 'storageId'},
    {'1': 'ops', '3': 3, '4': 3, '5': 11, '6': '.lnrpc.Op', '10': 'ops'},
  ],
};

/// Descriptor for `MacaroonId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List macaroonIdDescriptor = $convert.base64Decode(
    'CgpNYWNhcm9vbklkEhQKBW5vbmNlGAEgASgMUgVub25jZRIcCglzdG9yYWdlSWQYAiABKAxSCX'
    'N0b3JhZ2VJZBIbCgNvcHMYAyADKAsyCS5sbnJwYy5PcFIDb3Bz');

@$core.Deprecated('Use opDescriptor instead')
const Op$json = {
  '1': 'Op',
  '2': [
    {'1': 'entity', '3': 1, '4': 1, '5': 9, '10': 'entity'},
    {'1': 'actions', '3': 2, '4': 3, '5': 9, '10': 'actions'},
  ],
};

/// Descriptor for `Op`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List opDescriptor = $convert.base64Decode(
    'CgJPcBIWCgZlbnRpdHkYASABKAlSBmVudGl0eRIYCgdhY3Rpb25zGAIgAygJUgdhY3Rpb25z');

@$core.Deprecated('Use checkMacPermRequestDescriptor instead')
const CheckMacPermRequest$json = {
  '1': 'CheckMacPermRequest',
  '2': [
    {'1': 'macaroon', '3': 1, '4': 1, '5': 12, '10': 'macaroon'},
    {'1': 'permissions', '3': 2, '4': 3, '5': 11, '6': '.lnrpc.MacaroonPermission', '10': 'permissions'},
    {'1': 'fullMethod', '3': 3, '4': 1, '5': 9, '10': 'fullMethod'},
  ],
};

/// Descriptor for `CheckMacPermRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMacPermRequestDescriptor = $convert.base64Decode(
    'ChNDaGVja01hY1Blcm1SZXF1ZXN0EhoKCG1hY2Fyb29uGAEgASgMUghtYWNhcm9vbhI7CgtwZX'
    'JtaXNzaW9ucxgCIAMoCzIZLmxucnBjLk1hY2Fyb29uUGVybWlzc2lvblILcGVybWlzc2lvbnMS'
    'HgoKZnVsbE1ldGhvZBgDIAEoCVIKZnVsbE1ldGhvZA==');

@$core.Deprecated('Use checkMacPermResponseDescriptor instead')
const CheckMacPermResponse$json = {
  '1': 'CheckMacPermResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
  ],
};

/// Descriptor for `CheckMacPermResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkMacPermResponseDescriptor = $convert.base64Decode(
    'ChRDaGVja01hY1Blcm1SZXNwb25zZRIUCgV2YWxpZBgBIAEoCFIFdmFsaWQ=');

@$core.Deprecated('Use rPCMiddlewareRequestDescriptor instead')
const RPCMiddlewareRequest$json = {
  '1': 'RPCMiddlewareRequest',
  '2': [
    {'1': 'request_id', '3': 1, '4': 1, '5': 4, '10': 'requestId'},
    {'1': 'raw_macaroon', '3': 2, '4': 1, '5': 12, '10': 'rawMacaroon'},
    {'1': 'custom_caveat_condition', '3': 3, '4': 1, '5': 9, '10': 'customCaveatCondition'},
    {'1': 'stream_auth', '3': 4, '4': 1, '5': 11, '6': '.lnrpc.StreamAuth', '9': 0, '10': 'streamAuth'},
    {'1': 'request', '3': 5, '4': 1, '5': 11, '6': '.lnrpc.RPCMessage', '9': 0, '10': 'request'},
    {'1': 'response', '3': 6, '4': 1, '5': 11, '6': '.lnrpc.RPCMessage', '9': 0, '10': 'response'},
    {'1': 'reg_complete', '3': 8, '4': 1, '5': 8, '9': 0, '10': 'regComplete'},
    {'1': 'msg_id', '3': 7, '4': 1, '5': 4, '10': 'msgId'},
  ],
  '8': [
    {'1': 'intercept_type'},
  ],
};

/// Descriptor for `RPCMiddlewareRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rPCMiddlewareRequestDescriptor = $convert.base64Decode(
    'ChRSUENNaWRkbGV3YXJlUmVxdWVzdBIdCgpyZXF1ZXN0X2lkGAEgASgEUglyZXF1ZXN0SWQSIQ'
    'oMcmF3X21hY2Fyb29uGAIgASgMUgtyYXdNYWNhcm9vbhI2ChdjdXN0b21fY2F2ZWF0X2NvbmRp'
    'dGlvbhgDIAEoCVIVY3VzdG9tQ2F2ZWF0Q29uZGl0aW9uEjQKC3N0cmVhbV9hdXRoGAQgASgLMh'
    'EubG5ycGMuU3RyZWFtQXV0aEgAUgpzdHJlYW1BdXRoEi0KB3JlcXVlc3QYBSABKAsyES5sbnJw'
    'Yy5SUENNZXNzYWdlSABSB3JlcXVlc3QSLwoIcmVzcG9uc2UYBiABKAsyES5sbnJwYy5SUENNZX'
    'NzYWdlSABSCHJlc3BvbnNlEiMKDHJlZ19jb21wbGV0ZRgIIAEoCEgAUgtyZWdDb21wbGV0ZRIV'
    'CgZtc2dfaWQYByABKARSBW1zZ0lkQhAKDmludGVyY2VwdF90eXBl');

@$core.Deprecated('Use streamAuthDescriptor instead')
const StreamAuth$json = {
  '1': 'StreamAuth',
  '2': [
    {'1': 'method_full_uri', '3': 1, '4': 1, '5': 9, '10': 'methodFullUri'},
  ],
};

/// Descriptor for `StreamAuth`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamAuthDescriptor = $convert.base64Decode(
    'CgpTdHJlYW1BdXRoEiYKD21ldGhvZF9mdWxsX3VyaRgBIAEoCVINbWV0aG9kRnVsbFVyaQ==');

@$core.Deprecated('Use rPCMessageDescriptor instead')
const RPCMessage$json = {
  '1': 'RPCMessage',
  '2': [
    {'1': 'method_full_uri', '3': 1, '4': 1, '5': 9, '10': 'methodFullUri'},
    {'1': 'stream_rpc', '3': 2, '4': 1, '5': 8, '10': 'streamRpc'},
    {'1': 'type_name', '3': 3, '4': 1, '5': 9, '10': 'typeName'},
    {'1': 'serialized', '3': 4, '4': 1, '5': 12, '10': 'serialized'},
    {'1': 'is_error', '3': 5, '4': 1, '5': 8, '10': 'isError'},
  ],
};

/// Descriptor for `RPCMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rPCMessageDescriptor = $convert.base64Decode(
    'CgpSUENNZXNzYWdlEiYKD21ldGhvZF9mdWxsX3VyaRgBIAEoCVINbWV0aG9kRnVsbFVyaRIdCg'
    'pzdHJlYW1fcnBjGAIgASgIUglzdHJlYW1ScGMSGwoJdHlwZV9uYW1lGAMgASgJUgh0eXBlTmFt'
    'ZRIeCgpzZXJpYWxpemVkGAQgASgMUgpzZXJpYWxpemVkEhkKCGlzX2Vycm9yGAUgASgIUgdpc0'
    'Vycm9y');

@$core.Deprecated('Use rPCMiddlewareResponseDescriptor instead')
const RPCMiddlewareResponse$json = {
  '1': 'RPCMiddlewareResponse',
  '2': [
    {'1': 'ref_msg_id', '3': 1, '4': 1, '5': 4, '10': 'refMsgId'},
    {'1': 'register', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.MiddlewareRegistration', '9': 0, '10': 'register'},
    {'1': 'feedback', '3': 3, '4': 1, '5': 11, '6': '.lnrpc.InterceptFeedback', '9': 0, '10': 'feedback'},
  ],
  '8': [
    {'1': 'middleware_message'},
  ],
};

/// Descriptor for `RPCMiddlewareResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rPCMiddlewareResponseDescriptor = $convert.base64Decode(
    'ChVSUENNaWRkbGV3YXJlUmVzcG9uc2USHAoKcmVmX21zZ19pZBgBIAEoBFIIcmVmTXNnSWQSOw'
    'oIcmVnaXN0ZXIYAiABKAsyHS5sbnJwYy5NaWRkbGV3YXJlUmVnaXN0cmF0aW9uSABSCHJlZ2lz'
    'dGVyEjYKCGZlZWRiYWNrGAMgASgLMhgubG5ycGMuSW50ZXJjZXB0RmVlZGJhY2tIAFIIZmVlZG'
    'JhY2tCFAoSbWlkZGxld2FyZV9tZXNzYWdl');

@$core.Deprecated('Use middlewareRegistrationDescriptor instead')
const MiddlewareRegistration$json = {
  '1': 'MiddlewareRegistration',
  '2': [
    {'1': 'middleware_name', '3': 1, '4': 1, '5': 9, '10': 'middlewareName'},
    {'1': 'custom_macaroon_caveat_name', '3': 2, '4': 1, '5': 9, '10': 'customMacaroonCaveatName'},
    {'1': 'read_only_mode', '3': 3, '4': 1, '5': 8, '10': 'readOnlyMode'},
  ],
};

/// Descriptor for `MiddlewareRegistration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List middlewareRegistrationDescriptor = $convert.base64Decode(
    'ChZNaWRkbGV3YXJlUmVnaXN0cmF0aW9uEicKD21pZGRsZXdhcmVfbmFtZRgBIAEoCVIObWlkZG'
    'xld2FyZU5hbWUSPQobY3VzdG9tX21hY2Fyb29uX2NhdmVhdF9uYW1lGAIgASgJUhhjdXN0b21N'
    'YWNhcm9vbkNhdmVhdE5hbWUSJAoOcmVhZF9vbmx5X21vZGUYAyABKAhSDHJlYWRPbmx5TW9kZQ'
    '==');

@$core.Deprecated('Use interceptFeedbackDescriptor instead')
const InterceptFeedback$json = {
  '1': 'InterceptFeedback',
  '2': [
    {'1': 'error', '3': 1, '4': 1, '5': 9, '10': 'error'},
    {'1': 'replace_response', '3': 2, '4': 1, '5': 8, '10': 'replaceResponse'},
    {'1': 'replacement_serialized', '3': 3, '4': 1, '5': 12, '10': 'replacementSerialized'},
  ],
};

/// Descriptor for `InterceptFeedback`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List interceptFeedbackDescriptor = $convert.base64Decode(
    'ChFJbnRlcmNlcHRGZWVkYmFjaxIUCgVlcnJvchgBIAEoCVIFZXJyb3ISKQoQcmVwbGFjZV9yZX'
    'Nwb25zZRgCIAEoCFIPcmVwbGFjZVJlc3BvbnNlEjUKFnJlcGxhY2VtZW50X3NlcmlhbGl6ZWQY'
    'AyABKAxSFXJlcGxhY2VtZW50U2VyaWFsaXplZA==');

