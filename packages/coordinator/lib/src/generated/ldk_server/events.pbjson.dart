//
//  Generated code. Do not modify.
//  source: events.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use channelStateDescriptor instead')
const ChannelState$json = {
  '1': 'ChannelState',
  '2': [
    {'1': 'CHANNEL_STATE_UNSPECIFIED', '2': 0},
    {'1': 'CHANNEL_STATE_PENDING', '2': 1},
    {'1': 'CHANNEL_STATE_READY', '2': 2},
    {'1': 'CHANNEL_STATE_OPEN_FAILED', '2': 3},
    {'1': 'CHANNEL_STATE_CLOSED', '2': 4},
  ],
};

/// Descriptor for `ChannelState`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelStateDescriptor = $convert.base64Decode(
    'CgxDaGFubmVsU3RhdGUSHQoZQ0hBTk5FTF9TVEFURV9VTlNQRUNJRklFRBAAEhkKFUNIQU5ORU'
    'xfU1RBVEVfUEVORElORxABEhcKE0NIQU5ORUxfU1RBVEVfUkVBRFkQAhIdChlDSEFOTkVMX1NU'
    'QVRFX09QRU5fRkFJTEVEEAMSGAoUQ0hBTk5FTF9TVEFURV9DTE9TRUQQBA==');

@$core.Deprecated('Use channelClosureInitiatorDescriptor instead')
const ChannelClosureInitiator$json = {
  '1': 'ChannelClosureInitiator',
  '2': [
    {'1': 'CHANNEL_CLOSURE_INITIATOR_UNSPECIFIED', '2': 0},
    {'1': 'CHANNEL_CLOSURE_INITIATOR_LOCAL', '2': 1},
    {'1': 'CHANNEL_CLOSURE_INITIATOR_REMOTE', '2': 2},
    {'1': 'CHANNEL_CLOSURE_INITIATOR_UNKNOWN', '2': 3},
  ],
};

/// Descriptor for `ChannelClosureInitiator`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelClosureInitiatorDescriptor = $convert.base64Decode(
    'ChdDaGFubmVsQ2xvc3VyZUluaXRpYXRvchIpCiVDSEFOTkVMX0NMT1NVUkVfSU5JVElBVE9SX1'
    'VOU1BFQ0lGSUVEEAASIwofQ0hBTk5FTF9DTE9TVVJFX0lOSVRJQVRPUl9MT0NBTBABEiQKIENI'
    'QU5ORUxfQ0xPU1VSRV9JTklUSUFUT1JfUkVNT1RFEAISJQohQ0hBTk5FTF9DTE9TVVJFX0lOSV'
    'RJQVRPUl9VTktOT1dOEAM=');

@$core.Deprecated('Use channelStateChangeReasonKindDescriptor instead')
const ChannelStateChangeReasonKind$json = {
  '1': 'ChannelStateChangeReasonKind',
  '2': [
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_UNSPECIFIED', '2': 0},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_FORCE_CLOSED', '2': 1},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_HOLDER_FORCE_CLOSED', '2': 2},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_LEGACY_COOPERATIVE_CLOSURE', '2': 3},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_INITIATED_COOPERATIVE_CLOSURE', '2': 4},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_INITIATED_COOPERATIVE_CLOSURE', '2': 5},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_COMMITMENT_TX_CONFIRMED', '2': 6},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_TIMED_OUT', '2': 7},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_PROCESSING_ERROR', '2': 8},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_DISCONNECTED_PEER', '2': 9},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_OUTDATED_CHANNEL_MANAGER', '2': 10},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_COUNTERPARTY_COOP_CLOSED_UNFUNDED_CHANNEL', '2': 11},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_LOCALLY_COOP_CLOSED_UNFUNDED_CHANNEL', '2': 12},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_FUNDING_BATCH_CLOSURE', '2': 13},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_HTLCS_TIMED_OUT', '2': 14},
    {'1': 'CHANNEL_STATE_CHANGE_REASON_KIND_PEER_FEERATE_TOO_LOW', '2': 15},
  ],
};

/// Descriptor for `ChannelStateChangeReasonKind`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List channelStateChangeReasonKindDescriptor = $convert.base64Decode(
    'ChxDaGFubmVsU3RhdGVDaGFuZ2VSZWFzb25LaW5kEjAKLENIQU5ORUxfU1RBVEVfQ0hBTkdFX1'
    'JFQVNPTl9LSU5EX1VOU1BFQ0lGSUVEEAASPgo6Q0hBTk5FTF9TVEFURV9DSEFOR0VfUkVBU09O'
    'X0tJTkRfQ09VTlRFUlBBUlRZX0ZPUkNFX0NMT1NFRBABEjgKNENIQU5ORUxfU1RBVEVfQ0hBTk'
    'dFX1JFQVNPTl9LSU5EX0hPTERFUl9GT1JDRV9DTE9TRUQQAhI/CjtDSEFOTkVMX1NUQVRFX0NI'
    'QU5HRV9SRUFTT05fS0lORF9MRUdBQ1lfQ09PUEVSQVRJVkVfQ0xPU1VSRRADEk8KS0NIQU5ORU'
    'xfU1RBVEVfQ0hBTkdFX1JFQVNPTl9LSU5EX0NPVU5URVJQQVJUWV9JTklUSUFURURfQ09PUEVS'
    'QVRJVkVfQ0xPU1VSRRAEEkoKRkNIQU5ORUxfU1RBVEVfQ0hBTkdFX1JFQVNPTl9LSU5EX0xPQ0'
    'FMTFlfSU5JVElBVEVEX0NPT1BFUkFUSVZFX0NMT1NVUkUQBRI8CjhDSEFOTkVMX1NUQVRFX0NI'
    'QU5HRV9SRUFTT05fS0lORF9DT01NSVRNRU5UX1RYX0NPTkZJUk1FRBAGEjYKMkNIQU5ORUxfU1'
    'RBVEVfQ0hBTkdFX1JFQVNPTl9LSU5EX0ZVTkRJTkdfVElNRURfT1VUEAcSNQoxQ0hBTk5FTF9T'
    'VEFURV9DSEFOR0VfUkVBU09OX0tJTkRfUFJPQ0VTU0lOR19FUlJPUhAIEjYKMkNIQU5ORUxfU1'
    'RBVEVfQ0hBTkdFX1JFQVNPTl9LSU5EX0RJU0NPTk5FQ1RFRF9QRUVSEAkSPQo5Q0hBTk5FTF9T'
    'VEFURV9DSEFOR0VfUkVBU09OX0tJTkRfT1VUREFURURfQ0hBTk5FTF9NQU5BR0VSEAoSTgpKQ0'
    'hBTk5FTF9TVEFURV9DSEFOR0VfUkVBU09OX0tJTkRfQ09VTlRFUlBBUlRZX0NPT1BfQ0xPU0VE'
    'X1VORlVOREVEX0NIQU5ORUwQCxJJCkVDSEFOTkVMX1NUQVRFX0NIQU5HRV9SRUFTT05fS0lORF'
    '9MT0NBTExZX0NPT1BfQ0xPU0VEX1VORlVOREVEX0NIQU5ORUwQDBI6CjZDSEFOTkVMX1NUQVRF'
    'X0NIQU5HRV9SRUFTT05fS0lORF9GVU5ESU5HX0JBVENIX0NMT1NVUkUQDRI0CjBDSEFOTkVMX1'
    'NUQVRFX0NIQU5HRV9SRUFTT05fS0lORF9IVExDU19USU1FRF9PVVQQDhI5CjVDSEFOTkVMX1NU'
    'QVRFX0NIQU5HRV9SRUFTT05fS0lORF9QRUVSX0ZFRVJBVEVfVE9PX0xPVxAP');

@$core.Deprecated('Use eventEnvelopeDescriptor instead')
const EventEnvelope$json = {
  '1': 'EventEnvelope',
  '2': [
    {'1': 'payment_received', '3': 2, '4': 1, '5': 11, '6': '.events.PaymentReceived', '9': 0, '10': 'paymentReceived'},
    {'1': 'payment_successful', '3': 3, '4': 1, '5': 11, '6': '.events.PaymentSuccessful', '9': 0, '10': 'paymentSuccessful'},
    {'1': 'payment_failed', '3': 4, '4': 1, '5': 11, '6': '.events.PaymentFailed', '9': 0, '10': 'paymentFailed'},
    {'1': 'payment_forwarded', '3': 6, '4': 1, '5': 11, '6': '.events.PaymentForwarded', '9': 0, '10': 'paymentForwarded'},
    {'1': 'payment_claimable', '3': 7, '4': 1, '5': 11, '6': '.events.PaymentClaimable', '9': 0, '10': 'paymentClaimable'},
    {'1': 'channel_state_changed', '3': 8, '4': 1, '5': 11, '6': '.events.ChannelStateChanged', '9': 0, '10': 'channelStateChanged'},
  ],
  '8': [
    {'1': 'event'},
  ],
};

/// Descriptor for `EventEnvelope`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventEnvelopeDescriptor = $convert.base64Decode(
    'Cg1FdmVudEVudmVsb3BlEkQKEHBheW1lbnRfcmVjZWl2ZWQYAiABKAsyFy5ldmVudHMuUGF5bW'
    'VudFJlY2VpdmVkSABSD3BheW1lbnRSZWNlaXZlZBJKChJwYXltZW50X3N1Y2Nlc3NmdWwYAyAB'
    'KAsyGS5ldmVudHMuUGF5bWVudFN1Y2Nlc3NmdWxIAFIRcGF5bWVudFN1Y2Nlc3NmdWwSPgoOcG'
    'F5bWVudF9mYWlsZWQYBCABKAsyFS5ldmVudHMuUGF5bWVudEZhaWxlZEgAUg1wYXltZW50RmFp'
    'bGVkEkcKEXBheW1lbnRfZm9yd2FyZGVkGAYgASgLMhguZXZlbnRzLlBheW1lbnRGb3J3YXJkZW'
    'RIAFIQcGF5bWVudEZvcndhcmRlZBJHChFwYXltZW50X2NsYWltYWJsZRgHIAEoCzIYLmV2ZW50'
    'cy5QYXltZW50Q2xhaW1hYmxlSABSEHBheW1lbnRDbGFpbWFibGUSUQoVY2hhbm5lbF9zdGF0ZV'
    '9jaGFuZ2VkGAggASgLMhsuZXZlbnRzLkNoYW5uZWxTdGF0ZUNoYW5nZWRIAFITY2hhbm5lbFN0'
    'YXRlQ2hhbmdlZEIHCgVldmVudA==');

@$core.Deprecated('Use counterpartyForceClosedDetailsDescriptor instead')
const CounterpartyForceClosedDetails$json = {
  '1': 'CounterpartyForceClosedDetails',
  '2': [
    {'1': 'peer_msg', '3': 1, '4': 1, '5': 9, '10': 'peerMsg'},
  ],
};

/// Descriptor for `CounterpartyForceClosedDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List counterpartyForceClosedDetailsDescriptor = $convert.base64Decode(
    'Ch5Db3VudGVycGFydHlGb3JjZUNsb3NlZERldGFpbHMSGQoIcGVlcl9tc2cYASABKAlSB3BlZX'
    'JNc2c=');

@$core.Deprecated('Use holderForceClosedDetailsDescriptor instead')
const HolderForceClosedDetails$json = {
  '1': 'HolderForceClosedDetails',
  '2': [
    {'1': 'broadcasted_latest_txn', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'broadcastedLatestTxn', '17': true},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
  ],
  '8': [
    {'1': '_broadcasted_latest_txn'},
  ],
};

/// Descriptor for `HolderForceClosedDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holderForceClosedDetailsDescriptor = $convert.base64Decode(
    'ChhIb2xkZXJGb3JjZUNsb3NlZERldGFpbHMSOQoWYnJvYWRjYXN0ZWRfbGF0ZXN0X3R4bhgBIA'
    'EoCEgAUhRicm9hZGNhc3RlZExhdGVzdFR4bogBARIYCgdtZXNzYWdlGAIgASgJUgdtZXNzYWdl'
    'QhkKF19icm9hZGNhc3RlZF9sYXRlc3RfdHhu');

@$core.Deprecated('Use processingErrorDetailsDescriptor instead')
const ProcessingErrorDetails$json = {
  '1': 'ProcessingErrorDetails',
  '2': [
    {'1': 'err', '3': 1, '4': 1, '5': 9, '10': 'err'},
  ],
};

/// Descriptor for `ProcessingErrorDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List processingErrorDetailsDescriptor = $convert.base64Decode(
    'ChZQcm9jZXNzaW5nRXJyb3JEZXRhaWxzEhAKA2VychgBIAEoCVIDZXJy');

@$core.Deprecated('Use htlcsTimedOutDetailsDescriptor instead')
const HtlcsTimedOutDetails$json = {
  '1': 'HtlcsTimedOutDetails',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'paymentHash', '17': true},
  ],
  '8': [
    {'1': '_payment_hash'},
  ],
};

/// Descriptor for `HtlcsTimedOutDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htlcsTimedOutDetailsDescriptor = $convert.base64Decode(
    'ChRIdGxjc1RpbWVkT3V0RGV0YWlscxImCgxwYXltZW50X2hhc2gYASABKAlIAFILcGF5bWVudE'
    'hhc2iIAQFCDwoNX3BheW1lbnRfaGFzaA==');

@$core.Deprecated('Use peerFeerateTooLowDetailsDescriptor instead')
const PeerFeerateTooLowDetails$json = {
  '1': 'PeerFeerateTooLowDetails',
  '2': [
    {'1': 'peer_feerate_sat_per_kw', '3': 1, '4': 1, '5': 13, '10': 'peerFeerateSatPerKw'},
    {'1': 'required_feerate_sat_per_kw', '3': 2, '4': 1, '5': 13, '10': 'requiredFeerateSatPerKw'},
  ],
};

/// Descriptor for `PeerFeerateTooLowDetails`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerFeerateTooLowDetailsDescriptor = $convert.base64Decode(
    'ChhQZWVyRmVlcmF0ZVRvb0xvd0RldGFpbHMSNAoXcGVlcl9mZWVyYXRlX3NhdF9wZXJfa3cYAS'
    'ABKA1SE3BlZXJGZWVyYXRlU2F0UGVyS3cSPAobcmVxdWlyZWRfZmVlcmF0ZV9zYXRfcGVyX2t3'
    'GAIgASgNUhdyZXF1aXJlZEZlZXJhdGVTYXRQZXJLdw==');

@$core.Deprecated('Use channelStateChangeReasonDescriptor instead')
const ChannelStateChangeReason$json = {
  '1': 'ChannelStateChangeReason',
  '2': [
    {'1': 'kind', '3': 1, '4': 1, '5': 14, '6': '.events.ChannelStateChangeReasonKind', '10': 'kind'},
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {'1': 'counterparty_force_closed', '3': 3, '4': 1, '5': 11, '6': '.events.CounterpartyForceClosedDetails', '9': 0, '10': 'counterpartyForceClosed'},
    {'1': 'holder_force_closed', '3': 4, '4': 1, '5': 11, '6': '.events.HolderForceClosedDetails', '9': 0, '10': 'holderForceClosed'},
    {'1': 'processing_error', '3': 5, '4': 1, '5': 11, '6': '.events.ProcessingErrorDetails', '9': 0, '10': 'processingError'},
    {'1': 'htlcs_timed_out', '3': 6, '4': 1, '5': 11, '6': '.events.HtlcsTimedOutDetails', '9': 0, '10': 'htlcsTimedOut'},
    {'1': 'peer_feerate_too_low', '3': 7, '4': 1, '5': 11, '6': '.events.PeerFeerateTooLowDetails', '9': 0, '10': 'peerFeerateTooLow'},
  ],
  '8': [
    {'1': 'details'},
  ],
};

/// Descriptor for `ChannelStateChangeReason`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelStateChangeReasonDescriptor = $convert.base64Decode(
    'ChhDaGFubmVsU3RhdGVDaGFuZ2VSZWFzb24SOAoEa2luZBgBIAEoDjIkLmV2ZW50cy5DaGFubm'
    'VsU3RhdGVDaGFuZ2VSZWFzb25LaW5kUgRraW5kEhgKB21lc3NhZ2UYAiABKAlSB21lc3NhZ2US'
    'ZAoZY291bnRlcnBhcnR5X2ZvcmNlX2Nsb3NlZBgDIAEoCzImLmV2ZW50cy5Db3VudGVycGFydH'
    'lGb3JjZUNsb3NlZERldGFpbHNIAFIXY291bnRlcnBhcnR5Rm9yY2VDbG9zZWQSUgoTaG9sZGVy'
    'X2ZvcmNlX2Nsb3NlZBgEIAEoCzIgLmV2ZW50cy5Ib2xkZXJGb3JjZUNsb3NlZERldGFpbHNIAF'
    'IRaG9sZGVyRm9yY2VDbG9zZWQSSwoQcHJvY2Vzc2luZ19lcnJvchgFIAEoCzIeLmV2ZW50cy5Q'
    'cm9jZXNzaW5nRXJyb3JEZXRhaWxzSABSD3Byb2Nlc3NpbmdFcnJvchJGCg9odGxjc190aW1lZF'
    '9vdXQYBiABKAsyHC5ldmVudHMuSHRsY3NUaW1lZE91dERldGFpbHNIAFINaHRsY3NUaW1lZE91'
    'dBJTChRwZWVyX2ZlZXJhdGVfdG9vX2xvdxgHIAEoCzIgLmV2ZW50cy5QZWVyRmVlcmF0ZVRvb0'
    'xvd0RldGFpbHNIAFIRcGVlckZlZXJhdGVUb29Mb3dCCQoHZGV0YWlscw==');

@$core.Deprecated('Use channelStateChangedDescriptor instead')
const ChannelStateChanged$json = {
  '1': 'ChannelStateChanged',
  '2': [
    {'1': 'channel_id', '3': 1, '4': 1, '5': 9, '10': 'channelId'},
    {'1': 'user_channel_id', '3': 2, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'counterparty_node_id', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'counterpartyNodeId', '17': true},
    {'1': 'state', '3': 4, '4': 1, '5': 14, '6': '.events.ChannelState', '10': 'state'},
    {'1': 'funding_txo', '3': 5, '4': 1, '5': 9, '9': 1, '10': 'fundingTxo', '17': true},
    {'1': 'reason', '3': 6, '4': 1, '5': 11, '6': '.events.ChannelStateChangeReason', '9': 2, '10': 'reason', '17': true},
    {'1': 'closure_initiator', '3': 7, '4': 1, '5': 14, '6': '.events.ChannelClosureInitiator', '10': 'closureInitiator'},
  ],
  '8': [
    {'1': '_counterparty_node_id'},
    {'1': '_funding_txo'},
    {'1': '_reason'},
  ],
};

/// Descriptor for `ChannelStateChanged`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List channelStateChangedDescriptor = $convert.base64Decode(
    'ChNDaGFubmVsU3RhdGVDaGFuZ2VkEh0KCmNoYW5uZWxfaWQYASABKAlSCWNoYW5uZWxJZBImCg'
    '91c2VyX2NoYW5uZWxfaWQYAiABKAlSDXVzZXJDaGFubmVsSWQSNQoUY291bnRlcnBhcnR5X25v'
    'ZGVfaWQYAyABKAlIAFISY291bnRlcnBhcnR5Tm9kZUlkiAEBEioKBXN0YXRlGAQgASgOMhQuZX'
    'ZlbnRzLkNoYW5uZWxTdGF0ZVIFc3RhdGUSJAoLZnVuZGluZ190eG8YBSABKAlIAVIKZnVuZGlu'
    'Z1R4b4gBARI9CgZyZWFzb24YBiABKAsyIC5ldmVudHMuQ2hhbm5lbFN0YXRlQ2hhbmdlUmVhc2'
    '9uSAJSBnJlYXNvbogBARJMChFjbG9zdXJlX2luaXRpYXRvchgHIAEoDjIfLmV2ZW50cy5DaGFu'
    'bmVsQ2xvc3VyZUluaXRpYXRvclIQY2xvc3VyZUluaXRpYXRvckIXChVfY291bnRlcnBhcnR5X2'
    '5vZGVfaWRCDgoMX2Z1bmRpbmdfdHhvQgkKB19yZWFzb24=');

@$core.Deprecated('Use paymentReceivedDescriptor instead')
const PaymentReceived$json = {
  '1': 'PaymentReceived',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.types.Payment', '10': 'payment'},
    {'1': 'custom_records', '3': 2, '4': 3, '5': 11, '6': '.types.CustomTlvRecord', '10': 'customRecords'},
  ],
};

/// Descriptor for `PaymentReceived`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentReceivedDescriptor = $convert.base64Decode(
    'Cg9QYXltZW50UmVjZWl2ZWQSKAoHcGF5bWVudBgBIAEoCzIOLnR5cGVzLlBheW1lbnRSB3BheW'
    '1lbnQSPQoOY3VzdG9tX3JlY29yZHMYAiADKAsyFi50eXBlcy5DdXN0b21UbHZSZWNvcmRSDWN1'
    'c3RvbVJlY29yZHM=');

@$core.Deprecated('Use paymentSuccessfulDescriptor instead')
const PaymentSuccessful$json = {
  '1': 'PaymentSuccessful',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.types.Payment', '10': 'payment'},
  ],
};

/// Descriptor for `PaymentSuccessful`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentSuccessfulDescriptor = $convert.base64Decode(
    'ChFQYXltZW50U3VjY2Vzc2Z1bBIoCgdwYXltZW50GAEgASgLMg4udHlwZXMuUGF5bWVudFIHcG'
    'F5bWVudA==');

@$core.Deprecated('Use paymentFailedDescriptor instead')
const PaymentFailed$json = {
  '1': 'PaymentFailed',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.types.Payment', '10': 'payment'},
  ],
};

/// Descriptor for `PaymentFailed`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentFailedDescriptor = $convert.base64Decode(
    'Cg1QYXltZW50RmFpbGVkEigKB3BheW1lbnQYASABKAsyDi50eXBlcy5QYXltZW50UgdwYXltZW'
    '50');

@$core.Deprecated('Use paymentClaimableDescriptor instead')
const PaymentClaimable$json = {
  '1': 'PaymentClaimable',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.types.Payment', '10': 'payment'},
    {'1': 'custom_records', '3': 2, '4': 3, '5': 11, '6': '.types.CustomTlvRecord', '10': 'customRecords'},
    {'1': 'claim_deadline', '3': 3, '4': 1, '5': 13, '9': 0, '10': 'claimDeadline', '17': true},
  ],
  '8': [
    {'1': '_claim_deadline'},
  ],
};

/// Descriptor for `PaymentClaimable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentClaimableDescriptor = $convert.base64Decode(
    'ChBQYXltZW50Q2xhaW1hYmxlEigKB3BheW1lbnQYASABKAsyDi50eXBlcy5QYXltZW50UgdwYX'
    'ltZW50Ej0KDmN1c3RvbV9yZWNvcmRzGAIgAygLMhYudHlwZXMuQ3VzdG9tVGx2UmVjb3JkUg1j'
    'dXN0b21SZWNvcmRzEioKDmNsYWltX2RlYWRsaW5lGAMgASgNSABSDWNsYWltRGVhZGxpbmWIAQ'
    'FCEQoPX2NsYWltX2RlYWRsaW5l');

@$core.Deprecated('Use paymentForwardedDescriptor instead')
const PaymentForwarded$json = {
  '1': 'PaymentForwarded',
  '2': [
    {'1': 'forwarded_payment', '3': 1, '4': 1, '5': 11, '6': '.types.ForwardedPayment', '10': 'forwardedPayment'},
  ],
};

/// Descriptor for `PaymentForwarded`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentForwardedDescriptor = $convert.base64Decode(
    'ChBQYXltZW50Rm9yd2FyZGVkEkQKEWZvcndhcmRlZF9wYXltZW50GAEgASgLMhcudHlwZXMuRm'
    '9yd2FyZGVkUGF5bWVudFIQZm9yd2FyZGVkUGF5bWVudA==');

