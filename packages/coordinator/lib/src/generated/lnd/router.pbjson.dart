//
//  Generated code. Do not modify.
//  source: lnd/router.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use failureDetailDescriptor instead')
const FailureDetail$json = {
  '1': 'FailureDetail',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'NO_DETAIL', '2': 1},
    {'1': 'ONION_DECODE', '2': 2},
    {'1': 'LINK_NOT_ELIGIBLE', '2': 3},
    {'1': 'ON_CHAIN_TIMEOUT', '2': 4},
    {'1': 'HTLC_EXCEEDS_MAX', '2': 5},
    {'1': 'INSUFFICIENT_BALANCE', '2': 6},
    {'1': 'INCOMPLETE_FORWARD', '2': 7},
    {'1': 'HTLC_ADD_FAILED', '2': 8},
    {'1': 'FORWARDS_DISABLED', '2': 9},
    {'1': 'INVOICE_CANCELED', '2': 10},
    {'1': 'INVOICE_UNDERPAID', '2': 11},
    {'1': 'INVOICE_EXPIRY_TOO_SOON', '2': 12},
    {'1': 'INVOICE_NOT_OPEN', '2': 13},
    {'1': 'MPP_INVOICE_TIMEOUT', '2': 14},
    {'1': 'ADDRESS_MISMATCH', '2': 15},
    {'1': 'SET_TOTAL_MISMATCH', '2': 16},
    {'1': 'SET_TOTAL_TOO_LOW', '2': 17},
    {'1': 'SET_OVERPAID', '2': 18},
    {'1': 'UNKNOWN_INVOICE', '2': 19},
    {'1': 'INVALID_KEYSEND', '2': 20},
    {'1': 'MPP_IN_PROGRESS', '2': 21},
    {'1': 'CIRCULAR_ROUTE', '2': 22},
  ],
};

/// Descriptor for `FailureDetail`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List failureDetailDescriptor = $convert.base64Decode(
    'Cg1GYWlsdXJlRGV0YWlsEgsKB1VOS05PV04QABINCglOT19ERVRBSUwQARIQCgxPTklPTl9ERU'
    'NPREUQAhIVChFMSU5LX05PVF9FTElHSUJMRRADEhQKEE9OX0NIQUlOX1RJTUVPVVQQBBIUChBI'
    'VExDX0VYQ0VFRFNfTUFYEAUSGAoUSU5TVUZGSUNJRU5UX0JBTEFOQ0UQBhIWChJJTkNPTVBMRV'
    'RFX0ZPUldBUkQQBxITCg9IVExDX0FERF9GQUlMRUQQCBIVChFGT1JXQVJEU19ESVNBQkxFRBAJ'
    'EhQKEElOVk9JQ0VfQ0FOQ0VMRUQQChIVChFJTlZPSUNFX1VOREVSUEFJRBALEhsKF0lOVk9JQ0'
    'VfRVhQSVJZX1RPT19TT09OEAwSFAoQSU5WT0lDRV9OT1RfT1BFThANEhcKE01QUF9JTlZPSUNF'
    'X1RJTUVPVVQQDhIUChBBRERSRVNTX01JU01BVENIEA8SFgoSU0VUX1RPVEFMX01JU01BVENIEB'
    'ASFQoRU0VUX1RPVEFMX1RPT19MT1cQERIQCgxTRVRfT1ZFUlBBSUQQEhITCg9VTktOT1dOX0lO'
    'Vk9JQ0UQExITCg9JTlZBTElEX0tFWVNFTkQQFBITCg9NUFBfSU5fUFJPR1JFU1MQFRISCg5DSV'
    'JDVUxBUl9ST1VURRAW');

@$core.Deprecated('Use paymentStateDescriptor instead')
const PaymentState$json = {
  '1': 'PaymentState',
  '2': [
    {'1': 'IN_FLIGHT', '2': 0},
    {'1': 'SUCCEEDED', '2': 1},
    {'1': 'FAILED_TIMEOUT', '2': 2},
    {'1': 'FAILED_NO_ROUTE', '2': 3},
    {'1': 'FAILED_ERROR', '2': 4},
    {'1': 'FAILED_INCORRECT_PAYMENT_DETAILS', '2': 5},
    {'1': 'FAILED_INSUFFICIENT_BALANCE', '2': 6},
  ],
};

/// Descriptor for `PaymentState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List paymentStateDescriptor = $convert.base64Decode(
    'CgxQYXltZW50U3RhdGUSDQoJSU5fRkxJR0hUEAASDQoJU1VDQ0VFREVEEAESEgoORkFJTEVEX1'
    'RJTUVPVVQQAhITCg9GQUlMRURfTk9fUk9VVEUQAxIQCgxGQUlMRURfRVJST1IQBBIkCiBGQUlM'
    'RURfSU5DT1JSRUNUX1BBWU1FTlRfREVUQUlMUxAFEh8KG0ZBSUxFRF9JTlNVRkZJQ0lFTlRfQk'
    'FMQU5DRRAG');

@$core.Deprecated('Use resolveHoldForwardActionDescriptor instead')
const ResolveHoldForwardAction$json = {
  '1': 'ResolveHoldForwardAction',
  '2': [
    {'1': 'SETTLE', '2': 0},
    {'1': 'FAIL', '2': 1},
    {'1': 'RESUME', '2': 2},
    {'1': 'RESUME_MODIFIED', '2': 3},
  ],
};

/// Descriptor for `ResolveHoldForwardAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List resolveHoldForwardActionDescriptor = $convert.base64Decode(
    'ChhSZXNvbHZlSG9sZEZvcndhcmRBY3Rpb24SCgoGU0VUVExFEAASCAoERkFJTBABEgoKBlJFU1'
    'VNRRACEhMKD1JFU1VNRV9NT0RJRklFRBAD');

@$core.Deprecated('Use chanStatusActionDescriptor instead')
const ChanStatusAction$json = {
  '1': 'ChanStatusAction',
  '2': [
    {'1': 'ENABLE', '2': 0},
    {'1': 'DISABLE', '2': 1},
    {'1': 'AUTO', '2': 2},
  ],
};

/// Descriptor for `ChanStatusAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List chanStatusActionDescriptor = $convert.base64Decode(
    'ChBDaGFuU3RhdHVzQWN0aW9uEgoKBkVOQUJMRRAAEgsKB0RJU0FCTEUQARIICgRBVVRPEAI=');

@$core.Deprecated('Use sendPaymentRequestDescriptor instead')
const SendPaymentRequest$json = {
  '1': 'SendPaymentRequest',
  '2': [
    {'1': 'dest', '3': 1, '4': 1, '5': 12, '10': 'dest'},
    {'1': 'amt', '3': 2, '4': 1, '5': 3, '10': 'amt'},
    {'1': 'payment_hash', '3': 3, '4': 1, '5': 12, '10': 'paymentHash'},
    {'1': 'final_cltv_delta', '3': 4, '4': 1, '5': 5, '10': 'finalCltvDelta'},
    {'1': 'payment_request', '3': 5, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'timeout_seconds', '3': 6, '4': 1, '5': 5, '10': 'timeoutSeconds'},
    {'1': 'fee_limit_sat', '3': 7, '4': 1, '5': 3, '10': 'feeLimitSat'},
    {
      '1': 'outgoing_chan_id',
      '3': 8,
      '4': 1,
      '5': 4,
      '8': {'3': true, '6': 1},
      '10': 'outgoingChanId',
    },
    {'1': 'cltv_limit', '3': 9, '4': 1, '5': 5, '10': 'cltvLimit'},
    {'1': 'route_hints', '3': 10, '4': 3, '5': 11, '6': '.lnrpc.RouteHint', '10': 'routeHints'},
    {'1': 'dest_custom_records', '3': 11, '4': 3, '5': 11, '6': '.routerrpc.SendPaymentRequest.DestCustomRecordsEntry', '10': 'destCustomRecords'},
    {'1': 'amt_msat', '3': 12, '4': 1, '5': 3, '10': 'amtMsat'},
    {'1': 'fee_limit_msat', '3': 13, '4': 1, '5': 3, '10': 'feeLimitMsat'},
    {'1': 'last_hop_pubkey', '3': 14, '4': 1, '5': 12, '10': 'lastHopPubkey'},
    {'1': 'allow_self_payment', '3': 15, '4': 1, '5': 8, '10': 'allowSelfPayment'},
    {'1': 'dest_features', '3': 16, '4': 3, '5': 14, '6': '.lnrpc.FeatureBit', '10': 'destFeatures'},
    {'1': 'max_parts', '3': 17, '4': 1, '5': 13, '10': 'maxParts'},
    {'1': 'no_inflight_updates', '3': 18, '4': 1, '5': 8, '10': 'noInflightUpdates'},
    {'1': 'outgoing_chan_ids', '3': 19, '4': 3, '5': 4, '10': 'outgoingChanIds'},
    {'1': 'payment_addr', '3': 20, '4': 1, '5': 12, '10': 'paymentAddr'},
    {'1': 'max_shard_size_msat', '3': 21, '4': 1, '5': 4, '10': 'maxShardSizeMsat'},
    {'1': 'amp', '3': 22, '4': 1, '5': 8, '10': 'amp'},
    {'1': 'time_pref', '3': 23, '4': 1, '5': 1, '10': 'timePref'},
    {'1': 'cancelable', '3': 24, '4': 1, '5': 8, '10': 'cancelable'},
    {'1': 'first_hop_custom_records', '3': 25, '4': 3, '5': 11, '6': '.routerrpc.SendPaymentRequest.FirstHopCustomRecordsEntry', '10': 'firstHopCustomRecords'},
  ],
  '3': [SendPaymentRequest_DestCustomRecordsEntry$json, SendPaymentRequest_FirstHopCustomRecordsEntry$json],
};

@$core.Deprecated('Use sendPaymentRequestDescriptor instead')
const SendPaymentRequest_DestCustomRecordsEntry$json = {
  '1': 'DestCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use sendPaymentRequestDescriptor instead')
const SendPaymentRequest_FirstHopCustomRecordsEntry$json = {
  '1': 'FirstHopCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SendPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendPaymentRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kUGF5bWVudFJlcXVlc3QSEgoEZGVzdBgBIAEoDFIEZGVzdBIQCgNhbXQYAiABKANSA2'
    'FtdBIhCgxwYXltZW50X2hhc2gYAyABKAxSC3BheW1lbnRIYXNoEigKEGZpbmFsX2NsdHZfZGVs'
    'dGEYBCABKAVSDmZpbmFsQ2x0dkRlbHRhEicKD3BheW1lbnRfcmVxdWVzdBgFIAEoCVIOcGF5bW'
    'VudFJlcXVlc3QSJwoPdGltZW91dF9zZWNvbmRzGAYgASgFUg50aW1lb3V0U2Vjb25kcxIiCg1m'
    'ZWVfbGltaXRfc2F0GAcgASgDUgtmZWVMaW1pdFNhdBIuChBvdXRnb2luZ19jaGFuX2lkGAggAS'
    'gEQgQYATABUg5vdXRnb2luZ0NoYW5JZBIdCgpjbHR2X2xpbWl0GAkgASgFUgljbHR2TGltaXQS'
    'MQoLcm91dGVfaGludHMYCiADKAsyEC5sbnJwYy5Sb3V0ZUhpbnRSCnJvdXRlSGludHMSZAoTZG'
    'VzdF9jdXN0b21fcmVjb3JkcxgLIAMoCzI0LnJvdXRlcnJwYy5TZW5kUGF5bWVudFJlcXVlc3Qu'
    'RGVzdEN1c3RvbVJlY29yZHNFbnRyeVIRZGVzdEN1c3RvbVJlY29yZHMSGQoIYW10X21zYXQYDC'
    'ABKANSB2FtdE1zYXQSJAoOZmVlX2xpbWl0X21zYXQYDSABKANSDGZlZUxpbWl0TXNhdBImCg9s'
    'YXN0X2hvcF9wdWJrZXkYDiABKAxSDWxhc3RIb3BQdWJrZXkSLAoSYWxsb3dfc2VsZl9wYXltZW'
    '50GA8gASgIUhBhbGxvd1NlbGZQYXltZW50EjYKDWRlc3RfZmVhdHVyZXMYECADKA4yES5sbnJw'
    'Yy5GZWF0dXJlQml0UgxkZXN0RmVhdHVyZXMSGwoJbWF4X3BhcnRzGBEgASgNUghtYXhQYXJ0cx'
    'IuChNub19pbmZsaWdodF91cGRhdGVzGBIgASgIUhFub0luZmxpZ2h0VXBkYXRlcxIqChFvdXRn'
    'b2luZ19jaGFuX2lkcxgTIAMoBFIPb3V0Z29pbmdDaGFuSWRzEiEKDHBheW1lbnRfYWRkchgUIA'
    'EoDFILcGF5bWVudEFkZHISLQoTbWF4X3NoYXJkX3NpemVfbXNhdBgVIAEoBFIQbWF4U2hhcmRT'
    'aXplTXNhdBIQCgNhbXAYFiABKAhSA2FtcBIbCgl0aW1lX3ByZWYYFyABKAFSCHRpbWVQcmVmEh'
    '4KCmNhbmNlbGFibGUYGCABKAhSCmNhbmNlbGFibGUScQoYZmlyc3RfaG9wX2N1c3RvbV9yZWNv'
    'cmRzGBkgAygLMjgucm91dGVycnBjLlNlbmRQYXltZW50UmVxdWVzdC5GaXJzdEhvcEN1c3RvbV'
    'JlY29yZHNFbnRyeVIVZmlyc3RIb3BDdXN0b21SZWNvcmRzGkQKFkRlc3RDdXN0b21SZWNvcmRz'
    'RW50cnkSEAoDa2V5GAEgASgEUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4ARpIChpGaX'
    'JzdEhvcEN1c3RvbVJlY29yZHNFbnRyeRIQCgNrZXkYASABKARSA2tleRIUCgV2YWx1ZRgCIAEo'
    'DFIFdmFsdWU6AjgB');

@$core.Deprecated('Use trackPaymentRequestDescriptor instead')
const TrackPaymentRequest$json = {
  '1': 'TrackPaymentRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
    {'1': 'no_inflight_updates', '3': 2, '4': 1, '5': 8, '10': 'noInflightUpdates'},
  ],
};

/// Descriptor for `TrackPaymentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackPaymentRequestDescriptor = $convert.base64Decode(
    'ChNUcmFja1BheW1lbnRSZXF1ZXN0EiEKDHBheW1lbnRfaGFzaBgBIAEoDFILcGF5bWVudEhhc2'
    'gSLgoTbm9faW5mbGlnaHRfdXBkYXRlcxgCIAEoCFIRbm9JbmZsaWdodFVwZGF0ZXM=');

@$core.Deprecated('Use trackPaymentsRequestDescriptor instead')
const TrackPaymentsRequest$json = {
  '1': 'TrackPaymentsRequest',
  '2': [
    {'1': 'no_inflight_updates', '3': 1, '4': 1, '5': 8, '10': 'noInflightUpdates'},
  ],
};

/// Descriptor for `TrackPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List trackPaymentsRequestDescriptor = $convert.base64Decode(
    'ChRUcmFja1BheW1lbnRzUmVxdWVzdBIuChNub19pbmZsaWdodF91cGRhdGVzGAEgASgIUhFub0'
    'luZmxpZ2h0VXBkYXRlcw==');

@$core.Deprecated('Use routeFeeRequestDescriptor instead')
const RouteFeeRequest$json = {
  '1': 'RouteFeeRequest',
  '2': [
    {'1': 'dest', '3': 1, '4': 1, '5': 12, '10': 'dest'},
    {'1': 'amt_sat', '3': 2, '4': 1, '5': 3, '10': 'amtSat'},
    {'1': 'payment_request', '3': 3, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'timeout', '3': 4, '4': 1, '5': 13, '10': 'timeout'},
  ],
};

/// Descriptor for `RouteFeeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeFeeRequestDescriptor = $convert.base64Decode(
    'Cg9Sb3V0ZUZlZVJlcXVlc3QSEgoEZGVzdBgBIAEoDFIEZGVzdBIXCgdhbXRfc2F0GAIgASgDUg'
    'ZhbXRTYXQSJwoPcGF5bWVudF9yZXF1ZXN0GAMgASgJUg5wYXltZW50UmVxdWVzdBIYCgd0aW1l'
    'b3V0GAQgASgNUgd0aW1lb3V0');

@$core.Deprecated('Use routeFeeResponseDescriptor instead')
const RouteFeeResponse$json = {
  '1': 'RouteFeeResponse',
  '2': [
    {'1': 'routing_fee_msat', '3': 1, '4': 1, '5': 3, '10': 'routingFeeMsat'},
    {'1': 'time_lock_delay', '3': 2, '4': 1, '5': 3, '10': 'timeLockDelay'},
    {'1': 'failure_reason', '3': 5, '4': 1, '5': 14, '6': '.lnrpc.PaymentFailureReason', '10': 'failureReason'},
  ],
};

/// Descriptor for `RouteFeeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List routeFeeResponseDescriptor = $convert.base64Decode(
    'ChBSb3V0ZUZlZVJlc3BvbnNlEigKEHJvdXRpbmdfZmVlX21zYXQYASABKANSDnJvdXRpbmdGZW'
    'VNc2F0EiYKD3RpbWVfbG9ja19kZWxheRgCIAEoA1INdGltZUxvY2tEZWxheRJCCg5mYWlsdXJl'
    'X3JlYXNvbhgFIAEoDjIbLmxucnBjLlBheW1lbnRGYWlsdXJlUmVhc29uUg1mYWlsdXJlUmVhc2'
    '9u');

@$core.Deprecated('Use sendToRouteRequestDescriptor instead')
const SendToRouteRequest$json = {
  '1': 'SendToRouteRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
    {'1': 'route', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Route', '10': 'route'},
    {'1': 'skip_temp_err', '3': 3, '4': 1, '5': 8, '10': 'skipTempErr'},
    {'1': 'first_hop_custom_records', '3': 4, '4': 3, '5': 11, '6': '.routerrpc.SendToRouteRequest.FirstHopCustomRecordsEntry', '10': 'firstHopCustomRecords'},
  ],
  '3': [SendToRouteRequest_FirstHopCustomRecordsEntry$json],
};

@$core.Deprecated('Use sendToRouteRequestDescriptor instead')
const SendToRouteRequest_FirstHopCustomRecordsEntry$json = {
  '1': 'FirstHopCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `SendToRouteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendToRouteRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kVG9Sb3V0ZVJlcXVlc3QSIQoMcGF5bWVudF9oYXNoGAEgASgMUgtwYXltZW50SGFzaB'
    'IiCgVyb3V0ZRgCIAEoCzIMLmxucnBjLlJvdXRlUgVyb3V0ZRIiCg1za2lwX3RlbXBfZXJyGAMg'
    'ASgIUgtza2lwVGVtcEVychJxChhmaXJzdF9ob3BfY3VzdG9tX3JlY29yZHMYBCADKAsyOC5yb3'
    'V0ZXJycGMuU2VuZFRvUm91dGVSZXF1ZXN0LkZpcnN0SG9wQ3VzdG9tUmVjb3Jkc0VudHJ5UhVm'
    'aXJzdEhvcEN1c3RvbVJlY29yZHMaSAoaRmlyc3RIb3BDdXN0b21SZWNvcmRzRW50cnkSEAoDa2'
    'V5GAEgASgEUgNrZXkSFAoFdmFsdWUYAiABKAxSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use sendToRouteResponseDescriptor instead')
const SendToRouteResponse$json = {
  '1': 'SendToRouteResponse',
  '2': [
    {'1': 'preimage', '3': 1, '4': 1, '5': 12, '10': 'preimage'},
    {'1': 'failure', '3': 2, '4': 1, '5': 11, '6': '.lnrpc.Failure', '10': 'failure'},
  ],
};

/// Descriptor for `SendToRouteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendToRouteResponseDescriptor = $convert.base64Decode(
    'ChNTZW5kVG9Sb3V0ZVJlc3BvbnNlEhoKCHByZWltYWdlGAEgASgMUghwcmVpbWFnZRIoCgdmYW'
    'lsdXJlGAIgASgLMg4ubG5ycGMuRmFpbHVyZVIHZmFpbHVyZQ==');

@$core.Deprecated('Use resetMissionControlRequestDescriptor instead')
const ResetMissionControlRequest$json = {
  '1': 'ResetMissionControlRequest',
};

/// Descriptor for `ResetMissionControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetMissionControlRequestDescriptor = $convert.base64Decode(
    'ChpSZXNldE1pc3Npb25Db250cm9sUmVxdWVzdA==');

@$core.Deprecated('Use resetMissionControlResponseDescriptor instead')
const ResetMissionControlResponse$json = {
  '1': 'ResetMissionControlResponse',
};

/// Descriptor for `ResetMissionControlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resetMissionControlResponseDescriptor = $convert.base64Decode(
    'ChtSZXNldE1pc3Npb25Db250cm9sUmVzcG9uc2U=');

@$core.Deprecated('Use queryMissionControlRequestDescriptor instead')
const QueryMissionControlRequest$json = {
  '1': 'QueryMissionControlRequest',
};

/// Descriptor for `QueryMissionControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryMissionControlRequestDescriptor = $convert.base64Decode(
    'ChpRdWVyeU1pc3Npb25Db250cm9sUmVxdWVzdA==');

@$core.Deprecated('Use queryMissionControlResponseDescriptor instead')
const QueryMissionControlResponse$json = {
  '1': 'QueryMissionControlResponse',
  '2': [
    {'1': 'pairs', '3': 2, '4': 3, '5': 11, '6': '.routerrpc.PairHistory', '10': 'pairs'},
  ],
  '9': [
    {'1': 1, '2': 2},
  ],
};

/// Descriptor for `QueryMissionControlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryMissionControlResponseDescriptor = $convert.base64Decode(
    'ChtRdWVyeU1pc3Npb25Db250cm9sUmVzcG9uc2USLAoFcGFpcnMYAiADKAsyFi5yb3V0ZXJycG'
    'MuUGFpckhpc3RvcnlSBXBhaXJzSgQIARAC');

@$core.Deprecated('Use xImportMissionControlRequestDescriptor instead')
const XImportMissionControlRequest$json = {
  '1': 'XImportMissionControlRequest',
  '2': [
    {'1': 'pairs', '3': 1, '4': 3, '5': 11, '6': '.routerrpc.PairHistory', '10': 'pairs'},
    {'1': 'force', '3': 2, '4': 1, '5': 8, '10': 'force'},
  ],
};

/// Descriptor for `XImportMissionControlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List xImportMissionControlRequestDescriptor = $convert.base64Decode(
    'ChxYSW1wb3J0TWlzc2lvbkNvbnRyb2xSZXF1ZXN0EiwKBXBhaXJzGAEgAygLMhYucm91dGVycn'
    'BjLlBhaXJIaXN0b3J5UgVwYWlycxIUCgVmb3JjZRgCIAEoCFIFZm9yY2U=');

@$core.Deprecated('Use xImportMissionControlResponseDescriptor instead')
const XImportMissionControlResponse$json = {
  '1': 'XImportMissionControlResponse',
};

/// Descriptor for `XImportMissionControlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List xImportMissionControlResponseDescriptor = $convert.base64Decode(
    'Ch1YSW1wb3J0TWlzc2lvbkNvbnRyb2xSZXNwb25zZQ==');

@$core.Deprecated('Use pairHistoryDescriptor instead')
const PairHistory$json = {
  '1': 'PairHistory',
  '2': [
    {'1': 'node_from', '3': 1, '4': 1, '5': 12, '10': 'nodeFrom'},
    {'1': 'node_to', '3': 2, '4': 1, '5': 12, '10': 'nodeTo'},
    {'1': 'history', '3': 7, '4': 1, '5': 11, '6': '.routerrpc.PairData', '10': 'history'},
  ],
  '9': [
    {'1': 3, '2': 4},
    {'1': 4, '2': 5},
    {'1': 5, '2': 6},
    {'1': 6, '2': 7},
  ],
};

/// Descriptor for `PairHistory`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pairHistoryDescriptor = $convert.base64Decode(
    'CgtQYWlySGlzdG9yeRIbCglub2RlX2Zyb20YASABKAxSCG5vZGVGcm9tEhcKB25vZGVfdG8YAi'
    'ABKAxSBm5vZGVUbxItCgdoaXN0b3J5GAcgASgLMhMucm91dGVycnBjLlBhaXJEYXRhUgdoaXN0'
    'b3J5SgQIAxAESgQIBBAFSgQIBRAGSgQIBhAH');

@$core.Deprecated('Use pairDataDescriptor instead')
const PairData$json = {
  '1': 'PairData',
  '2': [
    {'1': 'fail_time', '3': 1, '4': 1, '5': 3, '10': 'failTime'},
    {'1': 'fail_amt_sat', '3': 2, '4': 1, '5': 3, '10': 'failAmtSat'},
    {'1': 'fail_amt_msat', '3': 4, '4': 1, '5': 3, '10': 'failAmtMsat'},
    {'1': 'success_time', '3': 5, '4': 1, '5': 3, '10': 'successTime'},
    {'1': 'success_amt_sat', '3': 6, '4': 1, '5': 3, '10': 'successAmtSat'},
    {'1': 'success_amt_msat', '3': 7, '4': 1, '5': 3, '10': 'successAmtMsat'},
  ],
  '9': [
    {'1': 3, '2': 4},
  ],
};

/// Descriptor for `PairData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pairDataDescriptor = $convert.base64Decode(
    'CghQYWlyRGF0YRIbCglmYWlsX3RpbWUYASABKANSCGZhaWxUaW1lEiAKDGZhaWxfYW10X3NhdB'
    'gCIAEoA1IKZmFpbEFtdFNhdBIiCg1mYWlsX2FtdF9tc2F0GAQgASgDUgtmYWlsQW10TXNhdBIh'
    'CgxzdWNjZXNzX3RpbWUYBSABKANSC3N1Y2Nlc3NUaW1lEiYKD3N1Y2Nlc3NfYW10X3NhdBgGIA'
    'EoA1INc3VjY2Vzc0FtdFNhdBIoChBzdWNjZXNzX2FtdF9tc2F0GAcgASgDUg5zdWNjZXNzQW10'
    'TXNhdEoECAMQBA==');

@$core.Deprecated('Use getMissionControlConfigRequestDescriptor instead')
const GetMissionControlConfigRequest$json = {
  '1': 'GetMissionControlConfigRequest',
};

/// Descriptor for `GetMissionControlConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMissionControlConfigRequestDescriptor = $convert.base64Decode(
    'Ch5HZXRNaXNzaW9uQ29udHJvbENvbmZpZ1JlcXVlc3Q=');

@$core.Deprecated('Use getMissionControlConfigResponseDescriptor instead')
const GetMissionControlConfigResponse$json = {
  '1': 'GetMissionControlConfigResponse',
  '2': [
    {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.routerrpc.MissionControlConfig', '10': 'config'},
  ],
};

/// Descriptor for `GetMissionControlConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMissionControlConfigResponseDescriptor = $convert.base64Decode(
    'Ch9HZXRNaXNzaW9uQ29udHJvbENvbmZpZ1Jlc3BvbnNlEjcKBmNvbmZpZxgBIAEoCzIfLnJvdX'
    'RlcnJwYy5NaXNzaW9uQ29udHJvbENvbmZpZ1IGY29uZmln');

@$core.Deprecated('Use setMissionControlConfigRequestDescriptor instead')
const SetMissionControlConfigRequest$json = {
  '1': 'SetMissionControlConfigRequest',
  '2': [
    {'1': 'config', '3': 1, '4': 1, '5': 11, '6': '.routerrpc.MissionControlConfig', '10': 'config'},
  ],
};

/// Descriptor for `SetMissionControlConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setMissionControlConfigRequestDescriptor = $convert.base64Decode(
    'Ch5TZXRNaXNzaW9uQ29udHJvbENvbmZpZ1JlcXVlc3QSNwoGY29uZmlnGAEgASgLMh8ucm91dG'
    'VycnBjLk1pc3Npb25Db250cm9sQ29uZmlnUgZjb25maWc=');

@$core.Deprecated('Use setMissionControlConfigResponseDescriptor instead')
const SetMissionControlConfigResponse$json = {
  '1': 'SetMissionControlConfigResponse',
};

/// Descriptor for `SetMissionControlConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setMissionControlConfigResponseDescriptor = $convert.base64Decode(
    'Ch9TZXRNaXNzaW9uQ29udHJvbENvbmZpZ1Jlc3BvbnNl');

@$core.Deprecated('Use missionControlConfigDescriptor instead')
const MissionControlConfig$json = {
  '1': 'MissionControlConfig',
  '2': [
    {
      '1': 'half_life_seconds',
      '3': 1,
      '4': 1,
      '5': 4,
      '8': {'3': true},
      '10': 'halfLifeSeconds',
    },
    {
      '1': 'hop_probability',
      '3': 2,
      '4': 1,
      '5': 2,
      '8': {'3': true},
      '10': 'hopProbability',
    },
    {
      '1': 'weight',
      '3': 3,
      '4': 1,
      '5': 2,
      '8': {'3': true},
      '10': 'weight',
    },
    {'1': 'maximum_payment_results', '3': 4, '4': 1, '5': 13, '10': 'maximumPaymentResults'},
    {'1': 'minimum_failure_relax_interval', '3': 5, '4': 1, '5': 4, '10': 'minimumFailureRelaxInterval'},
    {'1': 'model', '3': 6, '4': 1, '5': 14, '6': '.routerrpc.MissionControlConfig.ProbabilityModel', '10': 'model'},
    {'1': 'apriori', '3': 7, '4': 1, '5': 11, '6': '.routerrpc.AprioriParameters', '9': 0, '10': 'apriori'},
    {'1': 'bimodal', '3': 8, '4': 1, '5': 11, '6': '.routerrpc.BimodalParameters', '9': 0, '10': 'bimodal'},
  ],
  '4': [MissionControlConfig_ProbabilityModel$json],
  '8': [
    {'1': 'EstimatorConfig'},
  ],
};

@$core.Deprecated('Use missionControlConfigDescriptor instead')
const MissionControlConfig_ProbabilityModel$json = {
  '1': 'ProbabilityModel',
  '2': [
    {'1': 'APRIORI', '2': 0},
    {'1': 'BIMODAL', '2': 1},
  ],
};

/// Descriptor for `MissionControlConfig`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List missionControlConfigDescriptor = $convert.base64Decode(
    'ChRNaXNzaW9uQ29udHJvbENvbmZpZxIuChFoYWxmX2xpZmVfc2Vjb25kcxgBIAEoBEICGAFSD2'
    'hhbGZMaWZlU2Vjb25kcxIrCg9ob3BfcHJvYmFiaWxpdHkYAiABKAJCAhgBUg5ob3BQcm9iYWJp'
    'bGl0eRIaCgZ3ZWlnaHQYAyABKAJCAhgBUgZ3ZWlnaHQSNgoXbWF4aW11bV9wYXltZW50X3Jlc3'
    'VsdHMYBCABKA1SFW1heGltdW1QYXltZW50UmVzdWx0cxJDCh5taW5pbXVtX2ZhaWx1cmVfcmVs'
    'YXhfaW50ZXJ2YWwYBSABKARSG21pbmltdW1GYWlsdXJlUmVsYXhJbnRlcnZhbBJGCgVtb2RlbB'
    'gGIAEoDjIwLnJvdXRlcnJwYy5NaXNzaW9uQ29udHJvbENvbmZpZy5Qcm9iYWJpbGl0eU1vZGVs'
    'UgVtb2RlbBI4CgdhcHJpb3JpGAcgASgLMhwucm91dGVycnBjLkFwcmlvcmlQYXJhbWV0ZXJzSA'
    'BSB2FwcmlvcmkSOAoHYmltb2RhbBgIIAEoCzIcLnJvdXRlcnJwYy5CaW1vZGFsUGFyYW1ldGVy'
    'c0gAUgdiaW1vZGFsIiwKEFByb2JhYmlsaXR5TW9kZWwSCwoHQVBSSU9SSRAAEgsKB0JJTU9EQU'
    'wQAUIRCg9Fc3RpbWF0b3JDb25maWc=');

@$core.Deprecated('Use bimodalParametersDescriptor instead')
const BimodalParameters$json = {
  '1': 'BimodalParameters',
  '2': [
    {'1': 'node_weight', '3': 1, '4': 1, '5': 1, '10': 'nodeWeight'},
    {'1': 'scale_msat', '3': 2, '4': 1, '5': 4, '10': 'scaleMsat'},
    {'1': 'decay_time', '3': 3, '4': 1, '5': 4, '10': 'decayTime'},
  ],
};

/// Descriptor for `BimodalParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bimodalParametersDescriptor = $convert.base64Decode(
    'ChFCaW1vZGFsUGFyYW1ldGVycxIfCgtub2RlX3dlaWdodBgBIAEoAVIKbm9kZVdlaWdodBIdCg'
    'pzY2FsZV9tc2F0GAIgASgEUglzY2FsZU1zYXQSHQoKZGVjYXlfdGltZRgDIAEoBFIJZGVjYXlU'
    'aW1l');

@$core.Deprecated('Use aprioriParametersDescriptor instead')
const AprioriParameters$json = {
  '1': 'AprioriParameters',
  '2': [
    {'1': 'half_life_seconds', '3': 1, '4': 1, '5': 4, '10': 'halfLifeSeconds'},
    {'1': 'hop_probability', '3': 2, '4': 1, '5': 1, '10': 'hopProbability'},
    {'1': 'weight', '3': 3, '4': 1, '5': 1, '10': 'weight'},
    {'1': 'capacity_fraction', '3': 4, '4': 1, '5': 1, '10': 'capacityFraction'},
  ],
};

/// Descriptor for `AprioriParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List aprioriParametersDescriptor = $convert.base64Decode(
    'ChFBcHJpb3JpUGFyYW1ldGVycxIqChFoYWxmX2xpZmVfc2Vjb25kcxgBIAEoBFIPaGFsZkxpZm'
    'VTZWNvbmRzEicKD2hvcF9wcm9iYWJpbGl0eRgCIAEoAVIOaG9wUHJvYmFiaWxpdHkSFgoGd2Vp'
    'Z2h0GAMgASgBUgZ3ZWlnaHQSKwoRY2FwYWNpdHlfZnJhY3Rpb24YBCABKAFSEGNhcGFjaXR5Rn'
    'JhY3Rpb24=');

@$core.Deprecated('Use queryProbabilityRequestDescriptor instead')
const QueryProbabilityRequest$json = {
  '1': 'QueryProbabilityRequest',
  '2': [
    {'1': 'from_node', '3': 1, '4': 1, '5': 12, '10': 'fromNode'},
    {'1': 'to_node', '3': 2, '4': 1, '5': 12, '10': 'toNode'},
    {'1': 'amt_msat', '3': 3, '4': 1, '5': 3, '10': 'amtMsat'},
  ],
};

/// Descriptor for `QueryProbabilityRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryProbabilityRequestDescriptor = $convert.base64Decode(
    'ChdRdWVyeVByb2JhYmlsaXR5UmVxdWVzdBIbCglmcm9tX25vZGUYASABKAxSCGZyb21Ob2RlEh'
    'cKB3RvX25vZGUYAiABKAxSBnRvTm9kZRIZCghhbXRfbXNhdBgDIAEoA1IHYW10TXNhdA==');

@$core.Deprecated('Use queryProbabilityResponseDescriptor instead')
const QueryProbabilityResponse$json = {
  '1': 'QueryProbabilityResponse',
  '2': [
    {'1': 'probability', '3': 1, '4': 1, '5': 1, '10': 'probability'},
    {'1': 'history', '3': 2, '4': 1, '5': 11, '6': '.routerrpc.PairData', '10': 'history'},
  ],
};

/// Descriptor for `QueryProbabilityResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryProbabilityResponseDescriptor = $convert.base64Decode(
    'ChhRdWVyeVByb2JhYmlsaXR5UmVzcG9uc2USIAoLcHJvYmFiaWxpdHkYASABKAFSC3Byb2JhYm'
    'lsaXR5Ei0KB2hpc3RvcnkYAiABKAsyEy5yb3V0ZXJycGMuUGFpckRhdGFSB2hpc3Rvcnk=');

@$core.Deprecated('Use buildRouteRequestDescriptor instead')
const BuildRouteRequest$json = {
  '1': 'BuildRouteRequest',
  '2': [
    {'1': 'amt_msat', '3': 1, '4': 1, '5': 3, '10': 'amtMsat'},
    {'1': 'final_cltv_delta', '3': 2, '4': 1, '5': 5, '10': 'finalCltvDelta'},
    {
      '1': 'outgoing_chan_id',
      '3': 3,
      '4': 1,
      '5': 4,
      '8': {'6': 1},
      '10': 'outgoingChanId',
    },
    {'1': 'hop_pubkeys', '3': 4, '4': 3, '5': 12, '10': 'hopPubkeys'},
    {'1': 'payment_addr', '3': 5, '4': 1, '5': 12, '10': 'paymentAddr'},
    {'1': 'first_hop_custom_records', '3': 6, '4': 3, '5': 11, '6': '.routerrpc.BuildRouteRequest.FirstHopCustomRecordsEntry', '10': 'firstHopCustomRecords'},
  ],
  '3': [BuildRouteRequest_FirstHopCustomRecordsEntry$json],
};

@$core.Deprecated('Use buildRouteRequestDescriptor instead')
const BuildRouteRequest_FirstHopCustomRecordsEntry$json = {
  '1': 'FirstHopCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `BuildRouteRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buildRouteRequestDescriptor = $convert.base64Decode(
    'ChFCdWlsZFJvdXRlUmVxdWVzdBIZCghhbXRfbXNhdBgBIAEoA1IHYW10TXNhdBIoChBmaW5hbF'
    '9jbHR2X2RlbHRhGAIgASgFUg5maW5hbENsdHZEZWx0YRIsChBvdXRnb2luZ19jaGFuX2lkGAMg'
    'ASgEQgIwAVIOb3V0Z29pbmdDaGFuSWQSHwoLaG9wX3B1YmtleXMYBCADKAxSCmhvcFB1YmtleX'
    'MSIQoMcGF5bWVudF9hZGRyGAUgASgMUgtwYXltZW50QWRkchJwChhmaXJzdF9ob3BfY3VzdG9t'
    'X3JlY29yZHMYBiADKAsyNy5yb3V0ZXJycGMuQnVpbGRSb3V0ZVJlcXVlc3QuRmlyc3RIb3BDdX'
    'N0b21SZWNvcmRzRW50cnlSFWZpcnN0SG9wQ3VzdG9tUmVjb3JkcxpIChpGaXJzdEhvcEN1c3Rv'
    'bVJlY29yZHNFbnRyeRIQCgNrZXkYASABKARSA2tleRIUCgV2YWx1ZRgCIAEoDFIFdmFsdWU6Aj'
    'gB');

@$core.Deprecated('Use buildRouteResponseDescriptor instead')
const BuildRouteResponse$json = {
  '1': 'BuildRouteResponse',
  '2': [
    {'1': 'route', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.Route', '10': 'route'},
  ],
};

/// Descriptor for `BuildRouteResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List buildRouteResponseDescriptor = $convert.base64Decode(
    'ChJCdWlsZFJvdXRlUmVzcG9uc2USIgoFcm91dGUYASABKAsyDC5sbnJwYy5Sb3V0ZVIFcm91dG'
    'U=');

@$core.Deprecated('Use subscribeHtlcEventsRequestDescriptor instead')
const SubscribeHtlcEventsRequest$json = {
  '1': 'SubscribeHtlcEventsRequest',
};

/// Descriptor for `SubscribeHtlcEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeHtlcEventsRequestDescriptor = $convert.base64Decode(
    'ChpTdWJzY3JpYmVIdGxjRXZlbnRzUmVxdWVzdA==');

@$core.Deprecated('Use htlcEventDescriptor instead')
const HtlcEvent$json = {
  '1': 'HtlcEvent',
  '2': [
    {'1': 'incoming_channel_id', '3': 1, '4': 1, '5': 4, '10': 'incomingChannelId'},
    {'1': 'outgoing_channel_id', '3': 2, '4': 1, '5': 4, '10': 'outgoingChannelId'},
    {'1': 'incoming_htlc_id', '3': 3, '4': 1, '5': 4, '10': 'incomingHtlcId'},
    {'1': 'outgoing_htlc_id', '3': 4, '4': 1, '5': 4, '10': 'outgoingHtlcId'},
    {'1': 'timestamp_ns', '3': 5, '4': 1, '5': 4, '10': 'timestampNs'},
    {'1': 'event_type', '3': 6, '4': 1, '5': 14, '6': '.routerrpc.HtlcEvent.EventType', '10': 'eventType'},
    {'1': 'forward_event', '3': 7, '4': 1, '5': 11, '6': '.routerrpc.ForwardEvent', '9': 0, '10': 'forwardEvent'},
    {'1': 'forward_fail_event', '3': 8, '4': 1, '5': 11, '6': '.routerrpc.ForwardFailEvent', '9': 0, '10': 'forwardFailEvent'},
    {'1': 'settle_event', '3': 9, '4': 1, '5': 11, '6': '.routerrpc.SettleEvent', '9': 0, '10': 'settleEvent'},
    {'1': 'link_fail_event', '3': 10, '4': 1, '5': 11, '6': '.routerrpc.LinkFailEvent', '9': 0, '10': 'linkFailEvent'},
    {'1': 'subscribed_event', '3': 11, '4': 1, '5': 11, '6': '.routerrpc.SubscribedEvent', '9': 0, '10': 'subscribedEvent'},
    {'1': 'final_htlc_event', '3': 12, '4': 1, '5': 11, '6': '.routerrpc.FinalHtlcEvent', '9': 0, '10': 'finalHtlcEvent'},
  ],
  '4': [HtlcEvent_EventType$json],
  '8': [
    {'1': 'event'},
  ],
};

@$core.Deprecated('Use htlcEventDescriptor instead')
const HtlcEvent_EventType$json = {
  '1': 'EventType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'SEND', '2': 1},
    {'1': 'RECEIVE', '2': 2},
    {'1': 'FORWARD', '2': 3},
  ],
};

/// Descriptor for `HtlcEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htlcEventDescriptor = $convert.base64Decode(
    'CglIdGxjRXZlbnQSLgoTaW5jb21pbmdfY2hhbm5lbF9pZBgBIAEoBFIRaW5jb21pbmdDaGFubm'
    'VsSWQSLgoTb3V0Z29pbmdfY2hhbm5lbF9pZBgCIAEoBFIRb3V0Z29pbmdDaGFubmVsSWQSKAoQ'
    'aW5jb21pbmdfaHRsY19pZBgDIAEoBFIOaW5jb21pbmdIdGxjSWQSKAoQb3V0Z29pbmdfaHRsY1'
    '9pZBgEIAEoBFIOb3V0Z29pbmdIdGxjSWQSIQoMdGltZXN0YW1wX25zGAUgASgEUgt0aW1lc3Rh'
    'bXBOcxI9CgpldmVudF90eXBlGAYgASgOMh4ucm91dGVycnBjLkh0bGNFdmVudC5FdmVudFR5cG'
    'VSCWV2ZW50VHlwZRI+Cg1mb3J3YXJkX2V2ZW50GAcgASgLMhcucm91dGVycnBjLkZvcndhcmRF'
    'dmVudEgAUgxmb3J3YXJkRXZlbnQSSwoSZm9yd2FyZF9mYWlsX2V2ZW50GAggASgLMhsucm91dG'
    'VycnBjLkZvcndhcmRGYWlsRXZlbnRIAFIQZm9yd2FyZEZhaWxFdmVudBI7CgxzZXR0bGVfZXZl'
    'bnQYCSABKAsyFi5yb3V0ZXJycGMuU2V0dGxlRXZlbnRIAFILc2V0dGxlRXZlbnQSQgoPbGlua1'
    '9mYWlsX2V2ZW50GAogASgLMhgucm91dGVycnBjLkxpbmtGYWlsRXZlbnRIAFINbGlua0ZhaWxF'
    'dmVudBJHChBzdWJzY3JpYmVkX2V2ZW50GAsgASgLMhoucm91dGVycnBjLlN1YnNjcmliZWRFdm'
    'VudEgAUg9zdWJzY3JpYmVkRXZlbnQSRQoQZmluYWxfaHRsY19ldmVudBgMIAEoCzIZLnJvdXRl'
    'cnJwYy5GaW5hbEh0bGNFdmVudEgAUg5maW5hbEh0bGNFdmVudCI8CglFdmVudFR5cGUSCwoHVU'
    '5LTk9XThAAEggKBFNFTkQQARILCgdSRUNFSVZFEAISCwoHRk9SV0FSRBADQgcKBWV2ZW50');

@$core.Deprecated('Use htlcInfoDescriptor instead')
const HtlcInfo$json = {
  '1': 'HtlcInfo',
  '2': [
    {'1': 'incoming_timelock', '3': 1, '4': 1, '5': 13, '10': 'incomingTimelock'},
    {'1': 'outgoing_timelock', '3': 2, '4': 1, '5': 13, '10': 'outgoingTimelock'},
    {'1': 'incoming_amt_msat', '3': 3, '4': 1, '5': 4, '10': 'incomingAmtMsat'},
    {'1': 'outgoing_amt_msat', '3': 4, '4': 1, '5': 4, '10': 'outgoingAmtMsat'},
  ],
};

/// Descriptor for `HtlcInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htlcInfoDescriptor = $convert.base64Decode(
    'CghIdGxjSW5mbxIrChFpbmNvbWluZ190aW1lbG9jaxgBIAEoDVIQaW5jb21pbmdUaW1lbG9jax'
    'IrChFvdXRnb2luZ190aW1lbG9jaxgCIAEoDVIQb3V0Z29pbmdUaW1lbG9jaxIqChFpbmNvbWlu'
    'Z19hbXRfbXNhdBgDIAEoBFIPaW5jb21pbmdBbXRNc2F0EioKEW91dGdvaW5nX2FtdF9tc2F0GA'
    'QgASgEUg9vdXRnb2luZ0FtdE1zYXQ=');

@$core.Deprecated('Use forwardEventDescriptor instead')
const ForwardEvent$json = {
  '1': 'ForwardEvent',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.routerrpc.HtlcInfo', '10': 'info'},
  ],
};

/// Descriptor for `ForwardEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardEventDescriptor = $convert.base64Decode(
    'CgxGb3J3YXJkRXZlbnQSJwoEaW5mbxgBIAEoCzITLnJvdXRlcnJwYy5IdGxjSW5mb1IEaW5mbw'
    '==');

@$core.Deprecated('Use forwardFailEventDescriptor instead')
const ForwardFailEvent$json = {
  '1': 'ForwardFailEvent',
};

/// Descriptor for `ForwardFailEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardFailEventDescriptor = $convert.base64Decode(
    'ChBGb3J3YXJkRmFpbEV2ZW50');

@$core.Deprecated('Use settleEventDescriptor instead')
const SettleEvent$json = {
  '1': 'SettleEvent',
  '2': [
    {'1': 'preimage', '3': 1, '4': 1, '5': 12, '10': 'preimage'},
  ],
};

/// Descriptor for `SettleEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settleEventDescriptor = $convert.base64Decode(
    'CgtTZXR0bGVFdmVudBIaCghwcmVpbWFnZRgBIAEoDFIIcHJlaW1hZ2U=');

@$core.Deprecated('Use finalHtlcEventDescriptor instead')
const FinalHtlcEvent$json = {
  '1': 'FinalHtlcEvent',
  '2': [
    {'1': 'settled', '3': 1, '4': 1, '5': 8, '10': 'settled'},
    {'1': 'offchain', '3': 2, '4': 1, '5': 8, '10': 'offchain'},
  ],
};

/// Descriptor for `FinalHtlcEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List finalHtlcEventDescriptor = $convert.base64Decode(
    'Cg5GaW5hbEh0bGNFdmVudBIYCgdzZXR0bGVkGAEgASgIUgdzZXR0bGVkEhoKCG9mZmNoYWluGA'
    'IgASgIUghvZmZjaGFpbg==');

@$core.Deprecated('Use subscribedEventDescriptor instead')
const SubscribedEvent$json = {
  '1': 'SubscribedEvent',
};

/// Descriptor for `SubscribedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribedEventDescriptor = $convert.base64Decode(
    'Cg9TdWJzY3JpYmVkRXZlbnQ=');

@$core.Deprecated('Use linkFailEventDescriptor instead')
const LinkFailEvent$json = {
  '1': 'LinkFailEvent',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 11, '6': '.routerrpc.HtlcInfo', '10': 'info'},
    {'1': 'wire_failure', '3': 2, '4': 1, '5': 14, '6': '.lnrpc.Failure.FailureCode', '10': 'wireFailure'},
    {'1': 'failure_detail', '3': 3, '4': 1, '5': 14, '6': '.routerrpc.FailureDetail', '10': 'failureDetail'},
    {'1': 'failure_string', '3': 4, '4': 1, '5': 9, '10': 'failureString'},
  ],
};

/// Descriptor for `LinkFailEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkFailEventDescriptor = $convert.base64Decode(
    'Cg1MaW5rRmFpbEV2ZW50EicKBGluZm8YASABKAsyEy5yb3V0ZXJycGMuSHRsY0luZm9SBGluZm'
    '8SPQoMd2lyZV9mYWlsdXJlGAIgASgOMhoubG5ycGMuRmFpbHVyZS5GYWlsdXJlQ29kZVILd2ly'
    'ZUZhaWx1cmUSPwoOZmFpbHVyZV9kZXRhaWwYAyABKA4yGC5yb3V0ZXJycGMuRmFpbHVyZURldG'
    'FpbFINZmFpbHVyZURldGFpbBIlCg5mYWlsdXJlX3N0cmluZxgEIAEoCVINZmFpbHVyZVN0cmlu'
    'Zw==');

@$core.Deprecated('Use paymentStatusDescriptor instead')
const PaymentStatus$json = {
  '1': 'PaymentStatus',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.routerrpc.PaymentState', '10': 'state'},
    {'1': 'preimage', '3': 2, '4': 1, '5': 12, '10': 'preimage'},
    {'1': 'htlcs', '3': 4, '4': 3, '5': 11, '6': '.lnrpc.HTLCAttempt', '10': 'htlcs'},
  ],
  '9': [
    {'1': 3, '2': 4},
  ],
};

/// Descriptor for `PaymentStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentStatusDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50U3RhdHVzEi0KBXN0YXRlGAEgASgOMhcucm91dGVycnBjLlBheW1lbnRTdGF0ZV'
    'IFc3RhdGUSGgoIcHJlaW1hZ2UYAiABKAxSCHByZWltYWdlEigKBWh0bGNzGAQgAygLMhIubG5y'
    'cGMuSFRMQ0F0dGVtcHRSBWh0bGNzSgQIAxAE');

@$core.Deprecated('Use circuitKeyDescriptor instead')
const CircuitKey$json = {
  '1': 'CircuitKey',
  '2': [
    {'1': 'chan_id', '3': 1, '4': 1, '5': 4, '10': 'chanId'},
    {'1': 'htlc_id', '3': 2, '4': 1, '5': 4, '10': 'htlcId'},
  ],
};

/// Descriptor for `CircuitKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List circuitKeyDescriptor = $convert.base64Decode(
    'CgpDaXJjdWl0S2V5EhcKB2NoYW5faWQYASABKARSBmNoYW5JZBIXCgdodGxjX2lkGAIgASgEUg'
    'ZodGxjSWQ=');

@$core.Deprecated('Use forwardHtlcInterceptRequestDescriptor instead')
const ForwardHtlcInterceptRequest$json = {
  '1': 'ForwardHtlcInterceptRequest',
  '2': [
    {'1': 'incoming_circuit_key', '3': 1, '4': 1, '5': 11, '6': '.routerrpc.CircuitKey', '10': 'incomingCircuitKey'},
    {'1': 'incoming_amount_msat', '3': 5, '4': 1, '5': 4, '10': 'incomingAmountMsat'},
    {'1': 'incoming_expiry', '3': 6, '4': 1, '5': 13, '10': 'incomingExpiry'},
    {'1': 'payment_hash', '3': 2, '4': 1, '5': 12, '10': 'paymentHash'},
    {'1': 'outgoing_requested_chan_id', '3': 7, '4': 1, '5': 4, '10': 'outgoingRequestedChanId'},
    {'1': 'outgoing_amount_msat', '3': 3, '4': 1, '5': 4, '10': 'outgoingAmountMsat'},
    {'1': 'outgoing_expiry', '3': 4, '4': 1, '5': 13, '10': 'outgoingExpiry'},
    {'1': 'custom_records', '3': 8, '4': 3, '5': 11, '6': '.routerrpc.ForwardHtlcInterceptRequest.CustomRecordsEntry', '10': 'customRecords'},
    {'1': 'onion_blob', '3': 9, '4': 1, '5': 12, '10': 'onionBlob'},
    {'1': 'auto_fail_height', '3': 10, '4': 1, '5': 5, '10': 'autoFailHeight'},
    {'1': 'in_wire_custom_records', '3': 11, '4': 3, '5': 11, '6': '.routerrpc.ForwardHtlcInterceptRequest.InWireCustomRecordsEntry', '10': 'inWireCustomRecords'},
  ],
  '3': [ForwardHtlcInterceptRequest_CustomRecordsEntry$json, ForwardHtlcInterceptRequest_InWireCustomRecordsEntry$json],
};

@$core.Deprecated('Use forwardHtlcInterceptRequestDescriptor instead')
const ForwardHtlcInterceptRequest_CustomRecordsEntry$json = {
  '1': 'CustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

@$core.Deprecated('Use forwardHtlcInterceptRequestDescriptor instead')
const ForwardHtlcInterceptRequest_InWireCustomRecordsEntry$json = {
  '1': 'InWireCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ForwardHtlcInterceptRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardHtlcInterceptRequestDescriptor = $convert.base64Decode(
    'ChtGb3J3YXJkSHRsY0ludGVyY2VwdFJlcXVlc3QSRwoUaW5jb21pbmdfY2lyY3VpdF9rZXkYAS'
    'ABKAsyFS5yb3V0ZXJycGMuQ2lyY3VpdEtleVISaW5jb21pbmdDaXJjdWl0S2V5EjAKFGluY29t'
    'aW5nX2Ftb3VudF9tc2F0GAUgASgEUhJpbmNvbWluZ0Ftb3VudE1zYXQSJwoPaW5jb21pbmdfZX'
    'hwaXJ5GAYgASgNUg5pbmNvbWluZ0V4cGlyeRIhCgxwYXltZW50X2hhc2gYAiABKAxSC3BheW1l'
    'bnRIYXNoEjsKGm91dGdvaW5nX3JlcXVlc3RlZF9jaGFuX2lkGAcgASgEUhdvdXRnb2luZ1JlcX'
    'Vlc3RlZENoYW5JZBIwChRvdXRnb2luZ19hbW91bnRfbXNhdBgDIAEoBFISb3V0Z29pbmdBbW91'
    'bnRNc2F0EicKD291dGdvaW5nX2V4cGlyeRgEIAEoDVIOb3V0Z29pbmdFeHBpcnkSYAoOY3VzdG'
    '9tX3JlY29yZHMYCCADKAsyOS5yb3V0ZXJycGMuRm9yd2FyZEh0bGNJbnRlcmNlcHRSZXF1ZXN0'
    'LkN1c3RvbVJlY29yZHNFbnRyeVINY3VzdG9tUmVjb3JkcxIdCgpvbmlvbl9ibG9iGAkgASgMUg'
    'lvbmlvbkJsb2ISKAoQYXV0b19mYWlsX2hlaWdodBgKIAEoBVIOYXV0b0ZhaWxIZWlnaHQSdAoW'
    'aW5fd2lyZV9jdXN0b21fcmVjb3JkcxgLIAMoCzI/LnJvdXRlcnJwYy5Gb3J3YXJkSHRsY0ludG'
    'VyY2VwdFJlcXVlc3QuSW5XaXJlQ3VzdG9tUmVjb3Jkc0VudHJ5UhNpbldpcmVDdXN0b21SZWNv'
    'cmRzGkAKEkN1c3RvbVJlY29yZHNFbnRyeRIQCgNrZXkYASABKARSA2tleRIUCgV2YWx1ZRgCIA'
    'EoDFIFdmFsdWU6AjgBGkYKGEluV2lyZUN1c3RvbVJlY29yZHNFbnRyeRIQCgNrZXkYASABKARS'
    'A2tleRIUCgV2YWx1ZRgCIAEoDFIFdmFsdWU6AjgB');

@$core.Deprecated('Use forwardHtlcInterceptResponseDescriptor instead')
const ForwardHtlcInterceptResponse$json = {
  '1': 'ForwardHtlcInterceptResponse',
  '2': [
    {'1': 'incoming_circuit_key', '3': 1, '4': 1, '5': 11, '6': '.routerrpc.CircuitKey', '10': 'incomingCircuitKey'},
    {'1': 'action', '3': 2, '4': 1, '5': 14, '6': '.routerrpc.ResolveHoldForwardAction', '10': 'action'},
    {'1': 'preimage', '3': 3, '4': 1, '5': 12, '10': 'preimage'},
    {'1': 'failure_message', '3': 4, '4': 1, '5': 12, '10': 'failureMessage'},
    {'1': 'failure_code', '3': 5, '4': 1, '5': 14, '6': '.lnrpc.Failure.FailureCode', '10': 'failureCode'},
    {'1': 'in_amount_msat', '3': 6, '4': 1, '5': 4, '10': 'inAmountMsat'},
    {'1': 'out_amount_msat', '3': 7, '4': 1, '5': 4, '10': 'outAmountMsat'},
    {'1': 'out_wire_custom_records', '3': 8, '4': 3, '5': 11, '6': '.routerrpc.ForwardHtlcInterceptResponse.OutWireCustomRecordsEntry', '10': 'outWireCustomRecords'},
  ],
  '3': [ForwardHtlcInterceptResponse_OutWireCustomRecordsEntry$json],
};

@$core.Deprecated('Use forwardHtlcInterceptResponseDescriptor instead')
const ForwardHtlcInterceptResponse_OutWireCustomRecordsEntry$json = {
  '1': 'OutWireCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ForwardHtlcInterceptResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardHtlcInterceptResponseDescriptor = $convert.base64Decode(
    'ChxGb3J3YXJkSHRsY0ludGVyY2VwdFJlc3BvbnNlEkcKFGluY29taW5nX2NpcmN1aXRfa2V5GA'
    'EgASgLMhUucm91dGVycnBjLkNpcmN1aXRLZXlSEmluY29taW5nQ2lyY3VpdEtleRI7CgZhY3Rp'
    'b24YAiABKA4yIy5yb3V0ZXJycGMuUmVzb2x2ZUhvbGRGb3J3YXJkQWN0aW9uUgZhY3Rpb24SGg'
    'oIcHJlaW1hZ2UYAyABKAxSCHByZWltYWdlEicKD2ZhaWx1cmVfbWVzc2FnZRgEIAEoDFIOZmFp'
    'bHVyZU1lc3NhZ2USPQoMZmFpbHVyZV9jb2RlGAUgASgOMhoubG5ycGMuRmFpbHVyZS5GYWlsdX'
    'JlQ29kZVILZmFpbHVyZUNvZGUSJAoOaW5fYW1vdW50X21zYXQYBiABKARSDGluQW1vdW50TXNh'
    'dBImCg9vdXRfYW1vdW50X21zYXQYByABKARSDW91dEFtb3VudE1zYXQSeAoXb3V0X3dpcmVfY3'
    'VzdG9tX3JlY29yZHMYCCADKAsyQS5yb3V0ZXJycGMuRm9yd2FyZEh0bGNJbnRlcmNlcHRSZXNw'
    'b25zZS5PdXRXaXJlQ3VzdG9tUmVjb3Jkc0VudHJ5UhRvdXRXaXJlQ3VzdG9tUmVjb3JkcxpHCh'
    'lPdXRXaXJlQ3VzdG9tUmVjb3Jkc0VudHJ5EhAKA2tleRgBIAEoBFIDa2V5EhQKBXZhbHVlGAIg'
    'ASgMUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use updateChanStatusRequestDescriptor instead')
const UpdateChanStatusRequest$json = {
  '1': 'UpdateChanStatusRequest',
  '2': [
    {'1': 'chan_point', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.ChannelPoint', '10': 'chanPoint'},
    {'1': 'action', '3': 2, '4': 1, '5': 14, '6': '.routerrpc.ChanStatusAction', '10': 'action'},
  ],
};

/// Descriptor for `UpdateChanStatusRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChanStatusRequestDescriptor = $convert.base64Decode(
    'ChdVcGRhdGVDaGFuU3RhdHVzUmVxdWVzdBIyCgpjaGFuX3BvaW50GAEgASgLMhMubG5ycGMuQ2'
    'hhbm5lbFBvaW50UgljaGFuUG9pbnQSMwoGYWN0aW9uGAIgASgOMhsucm91dGVycnBjLkNoYW5T'
    'dGF0dXNBY3Rpb25SBmFjdGlvbg==');

@$core.Deprecated('Use updateChanStatusResponseDescriptor instead')
const UpdateChanStatusResponse$json = {
  '1': 'UpdateChanStatusResponse',
};

/// Descriptor for `UpdateChanStatusResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChanStatusResponseDescriptor = $convert.base64Decode(
    'ChhVcGRhdGVDaGFuU3RhdHVzUmVzcG9uc2U=');

@$core.Deprecated('Use addAliasesRequestDescriptor instead')
const AddAliasesRequest$json = {
  '1': 'AddAliasesRequest',
  '2': [
    {'1': 'alias_maps', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.AliasMap', '10': 'aliasMaps'},
  ],
};

/// Descriptor for `AddAliasesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAliasesRequestDescriptor = $convert.base64Decode(
    'ChFBZGRBbGlhc2VzUmVxdWVzdBIuCgphbGlhc19tYXBzGAEgAygLMg8ubG5ycGMuQWxpYXNNYX'
    'BSCWFsaWFzTWFwcw==');

@$core.Deprecated('Use addAliasesResponseDescriptor instead')
const AddAliasesResponse$json = {
  '1': 'AddAliasesResponse',
  '2': [
    {'1': 'alias_maps', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.AliasMap', '10': 'aliasMaps'},
  ],
};

/// Descriptor for `AddAliasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addAliasesResponseDescriptor = $convert.base64Decode(
    'ChJBZGRBbGlhc2VzUmVzcG9uc2USLgoKYWxpYXNfbWFwcxgBIAMoCzIPLmxucnBjLkFsaWFzTW'
    'FwUglhbGlhc01hcHM=');

@$core.Deprecated('Use deleteAliasesRequestDescriptor instead')
const DeleteAliasesRequest$json = {
  '1': 'DeleteAliasesRequest',
  '2': [
    {'1': 'alias_maps', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.AliasMap', '10': 'aliasMaps'},
  ],
};

/// Descriptor for `DeleteAliasesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAliasesRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVBbGlhc2VzUmVxdWVzdBIuCgphbGlhc19tYXBzGAEgAygLMg8ubG5ycGMuQWxpYX'
    'NNYXBSCWFsaWFzTWFwcw==');

@$core.Deprecated('Use deleteAliasesResponseDescriptor instead')
const DeleteAliasesResponse$json = {
  '1': 'DeleteAliasesResponse',
  '2': [
    {'1': 'alias_maps', '3': 1, '4': 3, '5': 11, '6': '.lnrpc.AliasMap', '10': 'aliasMaps'},
  ],
};

/// Descriptor for `DeleteAliasesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAliasesResponseDescriptor = $convert.base64Decode(
    'ChVEZWxldGVBbGlhc2VzUmVzcG9uc2USLgoKYWxpYXNfbWFwcxgBIAMoCzIPLmxucnBjLkFsaW'
    'FzTWFwUglhbGlhc01hcHM=');

