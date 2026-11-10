//
//  Generated code. Do not modify.
//  source: lndkrpc.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use directionDescriptor instead')
const Direction$json = {
  '1': 'Direction',
  '2': [
    {'1': 'NODE_ONE', '2': 0},
    {'1': 'NODE_TWO', '2': 1},
  ],
};

/// Descriptor for `Direction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List directionDescriptor = $convert.base64Decode(
    'CglEaXJlY3Rpb24SDAoITk9ERV9PTkUQABIMCghOT0RFX1RXTxAB');

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

@$core.Deprecated('Use payOfferRequestDescriptor instead')
const PayOfferRequest$json = {
  '1': 'PayOfferRequest',
  '2': [
    {'1': 'offer', '3': 1, '4': 1, '5': 9, '10': 'offer'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amount', '17': true},
    {'1': 'payer_note', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'payerNote', '17': true},
    {'1': 'response_invoice_timeout', '3': 4, '4': 1, '5': 13, '9': 2, '10': 'responseInvoiceTimeout', '17': true},
    {'1': 'fee_limit', '3': 5, '4': 1, '5': 13, '9': 3, '10': 'feeLimit', '17': true},
    {'1': 'fee_limit_percent', '3': 6, '4': 1, '5': 13, '9': 4, '10': 'feeLimitPercent', '17': true},
  ],
  '8': [
    {'1': '_amount'},
    {'1': '_payer_note'},
    {'1': '_response_invoice_timeout'},
    {'1': '_fee_limit'},
    {'1': '_fee_limit_percent'},
  ],
};

/// Descriptor for `PayOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payOfferRequestDescriptor = $convert.base64Decode(
    'Cg9QYXlPZmZlclJlcXVlc3QSFAoFb2ZmZXIYASABKAlSBW9mZmVyEhsKBmFtb3VudBgCIAEoBE'
    'gAUgZhbW91bnSIAQESIgoKcGF5ZXJfbm90ZRgDIAEoCUgBUglwYXllck5vdGWIAQESPQoYcmVz'
    'cG9uc2VfaW52b2ljZV90aW1lb3V0GAQgASgNSAJSFnJlc3BvbnNlSW52b2ljZVRpbWVvdXSIAQ'
    'ESIAoJZmVlX2xpbWl0GAUgASgNSANSCGZlZUxpbWl0iAEBEi8KEWZlZV9saW1pdF9wZXJjZW50'
    'GAYgASgNSARSD2ZlZUxpbWl0UGVyY2VudIgBAUIJCgdfYW1vdW50Qg0KC19wYXllcl9ub3RlQh'
    'sKGV9yZXNwb25zZV9pbnZvaWNlX3RpbWVvdXRCDAoKX2ZlZV9saW1pdEIUChJfZmVlX2xpbWl0'
    'X3BlcmNlbnQ=');

@$core.Deprecated('Use payOfferResponseDescriptor instead')
const PayOfferResponse$json = {
  '1': 'PayOfferResponse',
  '2': [
    {'1': 'payment_preimage', '3': 2, '4': 1, '5': 9, '10': 'paymentPreimage'},
  ],
};

/// Descriptor for `PayOfferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payOfferResponseDescriptor = $convert.base64Decode(
    'ChBQYXlPZmZlclJlc3BvbnNlEikKEHBheW1lbnRfcHJlaW1hZ2UYAiABKAlSD3BheW1lbnRQcm'
    'VpbWFnZQ==');

@$core.Deprecated('Use getInvoiceRequestDescriptor instead')
const GetInvoiceRequest$json = {
  '1': 'GetInvoiceRequest',
  '2': [
    {'1': 'offer', '3': 1, '4': 1, '5': 9, '10': 'offer'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amount', '17': true},
    {'1': 'payer_note', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'payerNote', '17': true},
    {'1': 'response_invoice_timeout', '3': 4, '4': 1, '5': 13, '9': 2, '10': 'responseInvoiceTimeout', '17': true},
  ],
  '8': [
    {'1': '_amount'},
    {'1': '_payer_note'},
    {'1': '_response_invoice_timeout'},
  ],
};

/// Descriptor for `GetInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceRequestDescriptor = $convert.base64Decode(
    'ChFHZXRJbnZvaWNlUmVxdWVzdBIUCgVvZmZlchgBIAEoCVIFb2ZmZXISGwoGYW1vdW50GAIgAS'
    'gESABSBmFtb3VudIgBARIiCgpwYXllcl9ub3RlGAMgASgJSAFSCXBheWVyTm90ZYgBARI9Chhy'
    'ZXNwb25zZV9pbnZvaWNlX3RpbWVvdXQYBCABKA1IAlIWcmVzcG9uc2VJbnZvaWNlVGltZW91dI'
    'gBAUIJCgdfYW1vdW50Qg0KC19wYXllcl9ub3RlQhsKGV9yZXNwb25zZV9pbnZvaWNlX3RpbWVv'
    'dXQ=');

@$core.Deprecated('Use decodeInvoiceRequestDescriptor instead')
const DecodeInvoiceRequest$json = {
  '1': 'DecodeInvoiceRequest',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
  ],
};

/// Descriptor for `DecodeInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeInvoiceRequestDescriptor = $convert.base64Decode(
    'ChREZWNvZGVJbnZvaWNlUmVxdWVzdBIYCgdpbnZvaWNlGAEgASgJUgdpbnZvaWNl');

@$core.Deprecated('Use getInvoiceResponseDescriptor instead')
const GetInvoiceResponse$json = {
  '1': 'GetInvoiceResponse',
  '2': [
    {'1': 'invoice_hex_str', '3': 1, '4': 1, '5': 9, '10': 'invoiceHexStr'},
    {'1': 'invoice_contents', '3': 2, '4': 1, '5': 11, '6': '.lndkrpc.Bolt12InvoiceContents', '10': 'invoiceContents'},
  ],
};

/// Descriptor for `GetInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getInvoiceResponseDescriptor = $convert.base64Decode(
    'ChJHZXRJbnZvaWNlUmVzcG9uc2USJgoPaW52b2ljZV9oZXhfc3RyGAEgASgJUg1pbnZvaWNlSG'
    'V4U3RyEkkKEGludm9pY2VfY29udGVudHMYAiABKAsyHi5sbmRrcnBjLkJvbHQxMkludm9pY2VD'
    'b250ZW50c1IPaW52b2ljZUNvbnRlbnRz');

@$core.Deprecated('Use payInvoiceRequestDescriptor instead')
const PayInvoiceRequest$json = {
  '1': 'PayInvoiceRequest',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
    {'1': 'amount', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amount', '17': true},
    {'1': 'fee_limit', '3': 3, '4': 1, '5': 13, '9': 1, '10': 'feeLimit', '17': true},
    {'1': 'fee_limit_percent', '3': 4, '4': 1, '5': 13, '9': 2, '10': 'feeLimitPercent', '17': true},
  ],
  '8': [
    {'1': '_amount'},
    {'1': '_fee_limit'},
    {'1': '_fee_limit_percent'},
  ],
};

/// Descriptor for `PayInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInvoiceRequestDescriptor = $convert.base64Decode(
    'ChFQYXlJbnZvaWNlUmVxdWVzdBIYCgdpbnZvaWNlGAEgASgJUgdpbnZvaWNlEhsKBmFtb3VudB'
    'gCIAEoBEgAUgZhbW91bnSIAQESIAoJZmVlX2xpbWl0GAMgASgNSAFSCGZlZUxpbWl0iAEBEi8K'
    'EWZlZV9saW1pdF9wZXJjZW50GAQgASgNSAJSD2ZlZUxpbWl0UGVyY2VudIgBAUIJCgdfYW1vdW'
    '50QgwKCl9mZWVfbGltaXRCFAoSX2ZlZV9saW1pdF9wZXJjZW50');

@$core.Deprecated('Use payInvoiceResponseDescriptor instead')
const PayInvoiceResponse$json = {
  '1': 'PayInvoiceResponse',
  '2': [
    {'1': 'payment_preimage', '3': 1, '4': 1, '5': 9, '10': 'paymentPreimage'},
  ],
};

/// Descriptor for `PayInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List payInvoiceResponseDescriptor = $convert.base64Decode(
    'ChJQYXlJbnZvaWNlUmVzcG9uc2USKQoQcGF5bWVudF9wcmVpbWFnZRgBIAEoCVIPcGF5bWVudF'
    'ByZWltYWdl');

@$core.Deprecated('Use bolt12InvoiceContentsDescriptor instead')
const Bolt12InvoiceContents$json = {
  '1': 'Bolt12InvoiceContents',
  '2': [
    {'1': 'chain', '3': 1, '4': 1, '5': 9, '10': 'chain'},
    {'1': 'quantity', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'quantity', '17': true},
    {'1': 'amount_msats', '3': 3, '4': 1, '5': 4, '10': 'amountMsats'},
    {'1': 'description', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'description', '17': true},
    {'1': 'payment_hash', '3': 5, '4': 1, '5': 11, '6': '.lndkrpc.PaymentHash', '10': 'paymentHash'},
    {'1': 'payment_paths', '3': 6, '4': 3, '5': 11, '6': '.lndkrpc.PaymentPaths', '10': 'paymentPaths'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'relative_expiry', '3': 8, '4': 1, '5': 4, '10': 'relativeExpiry'},
    {'1': 'node_id', '3': 9, '4': 1, '5': 11, '6': '.lndkrpc.PublicKey', '10': 'nodeId'},
    {'1': 'signature', '3': 10, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'features', '3': 11, '4': 3, '5': 14, '6': '.lndkrpc.FeatureBit', '10': 'features'},
    {'1': 'payer_note', '3': 12, '4': 1, '5': 9, '9': 2, '10': 'payerNote', '17': true},
  ],
  '8': [
    {'1': '_quantity'},
    {'1': '_description'},
    {'1': '_payer_note'},
  ],
};

/// Descriptor for `Bolt12InvoiceContents`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12InvoiceContentsDescriptor = $convert.base64Decode(
    'ChVCb2x0MTJJbnZvaWNlQ29udGVudHMSFAoFY2hhaW4YASABKAlSBWNoYWluEh8KCHF1YW50aX'
    'R5GAIgASgESABSCHF1YW50aXR5iAEBEiEKDGFtb3VudF9tc2F0cxgDIAEoBFILYW1vdW50TXNh'
    'dHMSJQoLZGVzY3JpcHRpb24YBCABKAlIAVILZGVzY3JpcHRpb26IAQESNwoMcGF5bWVudF9oYX'
    'NoGAUgASgLMhQubG5ka3JwYy5QYXltZW50SGFzaFILcGF5bWVudEhhc2gSOgoNcGF5bWVudF9w'
    'YXRocxgGIAMoCzIVLmxuZGtycGMuUGF5bWVudFBhdGhzUgxwYXltZW50UGF0aHMSHQoKY3JlYX'
    'RlZF9hdBgHIAEoA1IJY3JlYXRlZEF0EicKD3JlbGF0aXZlX2V4cGlyeRgIIAEoBFIOcmVsYXRp'
    'dmVFeHBpcnkSKwoHbm9kZV9pZBgJIAEoCzISLmxuZGtycGMuUHVibGljS2V5UgZub2RlSWQSHA'
    'oJc2lnbmF0dXJlGAogASgJUglzaWduYXR1cmUSLwoIZmVhdHVyZXMYCyADKA4yEy5sbmRrcnBj'
    'LkZlYXR1cmVCaXRSCGZlYXR1cmVzEiIKCnBheWVyX25vdGUYDCABKAlIAlIJcGF5ZXJOb3RliA'
    'EBQgsKCV9xdWFudGl0eUIOCgxfZGVzY3JpcHRpb25CDQoLX3BheWVyX25vdGU=');

@$core.Deprecated('Use paymentHashDescriptor instead')
const PaymentHash$json = {
  '1': 'PaymentHash',
  '2': [
    {'1': 'hash', '3': 1, '4': 1, '5': 12, '10': 'hash'},
  ],
};

/// Descriptor for `PaymentHash`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentHashDescriptor = $convert.base64Decode(
    'CgtQYXltZW50SGFzaBISCgRoYXNoGAEgASgMUgRoYXNo');

@$core.Deprecated('Use publicKeyDescriptor instead')
const PublicKey$json = {
  '1': 'PublicKey',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 12, '10': 'key'},
  ],
};

/// Descriptor for `PublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicKeyDescriptor = $convert.base64Decode(
    'CglQdWJsaWNLZXkSEAoDa2V5GAEgASgMUgNrZXk=');

@$core.Deprecated('Use blindedPayInfoDescriptor instead')
const BlindedPayInfo$json = {
  '1': 'BlindedPayInfo',
  '2': [
    {'1': 'fee_base_msat', '3': 1, '4': 1, '5': 13, '10': 'feeBaseMsat'},
    {'1': 'fee_proportional_millionths', '3': 2, '4': 1, '5': 13, '10': 'feeProportionalMillionths'},
    {'1': 'cltv_expiry_delta', '3': 3, '4': 1, '5': 13, '10': 'cltvExpiryDelta'},
    {'1': 'htlc_minimum_msat', '3': 4, '4': 1, '5': 4, '10': 'htlcMinimumMsat'},
    {'1': 'htlc_maximum_msat', '3': 5, '4': 1, '5': 4, '10': 'htlcMaximumMsat'},
    {'1': 'features', '3': 6, '4': 3, '5': 14, '6': '.lndkrpc.FeatureBit', '10': 'features'},
  ],
};

/// Descriptor for `BlindedPayInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedPayInfoDescriptor = $convert.base64Decode(
    'Cg5CbGluZGVkUGF5SW5mbxIiCg1mZWVfYmFzZV9tc2F0GAEgASgNUgtmZWVCYXNlTXNhdBI+Ch'
    'tmZWVfcHJvcG9ydGlvbmFsX21pbGxpb250aHMYAiABKA1SGWZlZVByb3BvcnRpb25hbE1pbGxp'
    'b250aHMSKgoRY2x0dl9leHBpcnlfZGVsdGEYAyABKA1SD2NsdHZFeHBpcnlEZWx0YRIqChFodG'
    'xjX21pbmltdW1fbXNhdBgEIAEoBFIPaHRsY01pbmltdW1Nc2F0EioKEWh0bGNfbWF4aW11bV9t'
    'c2F0GAUgASgEUg9odGxjTWF4aW11bU1zYXQSLwoIZmVhdHVyZXMYBiADKA4yEy5sbmRrcnBjLk'
    'ZlYXR1cmVCaXRSCGZlYXR1cmVz');

@$core.Deprecated('Use blindedHopDescriptor instead')
const BlindedHop$json = {
  '1': 'BlindedHop',
  '2': [
    {'1': 'blinded_node_id', '3': 1, '4': 1, '5': 11, '6': '.lndkrpc.PublicKey', '10': 'blindedNodeId'},
    {'1': 'encrypted_payload', '3': 2, '4': 1, '5': 12, '10': 'encryptedPayload'},
  ],
};

/// Descriptor for `BlindedHop`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedHopDescriptor = $convert.base64Decode(
    'CgpCbGluZGVkSG9wEjoKD2JsaW5kZWRfbm9kZV9pZBgBIAEoCzISLmxuZGtycGMuUHVibGljS2'
    'V5Ug1ibGluZGVkTm9kZUlkEisKEWVuY3J5cHRlZF9wYXlsb2FkGAIgASgMUhBlbmNyeXB0ZWRQ'
    'YXlsb2Fk');

@$core.Deprecated('Use blindedPathDescriptor instead')
const BlindedPath$json = {
  '1': 'BlindedPath',
  '2': [
    {'1': 'introduction_node', '3': 1, '4': 1, '5': 11, '6': '.lndkrpc.IntroductionNode', '10': 'introductionNode'},
    {'1': 'blinding_point', '3': 2, '4': 1, '5': 11, '6': '.lndkrpc.PublicKey', '10': 'blindingPoint'},
    {'1': 'blinded_hops', '3': 3, '4': 3, '5': 11, '6': '.lndkrpc.BlindedHop', '10': 'blindedHops'},
  ],
};

/// Descriptor for `BlindedPath`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blindedPathDescriptor = $convert.base64Decode(
    'CgtCbGluZGVkUGF0aBJGChFpbnRyb2R1Y3Rpb25fbm9kZRgBIAEoCzIZLmxuZGtycGMuSW50cm'
    '9kdWN0aW9uTm9kZVIQaW50cm9kdWN0aW9uTm9kZRI5Cg5ibGluZGluZ19wb2ludBgCIAEoCzIS'
    'LmxuZGtycGMuUHVibGljS2V5Ug1ibGluZGluZ1BvaW50EjYKDGJsaW5kZWRfaG9wcxgDIAMoCz'
    'ITLmxuZGtycGMuQmxpbmRlZEhvcFILYmxpbmRlZEhvcHM=');

@$core.Deprecated('Use paymentPathsDescriptor instead')
const PaymentPaths$json = {
  '1': 'PaymentPaths',
  '2': [
    {'1': 'blinded_pay_info', '3': 1, '4': 1, '5': 11, '6': '.lndkrpc.BlindedPayInfo', '10': 'blindedPayInfo'},
    {'1': 'blinded_path', '3': 2, '4': 1, '5': 11, '6': '.lndkrpc.BlindedPath', '10': 'blindedPath'},
  ],
};

/// Descriptor for `PaymentPaths`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List paymentPathsDescriptor = $convert.base64Decode(
    'CgxQYXltZW50UGF0aHMSQQoQYmxpbmRlZF9wYXlfaW5mbxgBIAEoCzIXLmxuZGtycGMuQmxpbm'
    'RlZFBheUluZm9SDmJsaW5kZWRQYXlJbmZvEjcKDGJsaW5kZWRfcGF0aBgCIAEoCzIULmxuZGty'
    'cGMuQmxpbmRlZFBhdGhSC2JsaW5kZWRQYXRo');

@$core.Deprecated('Use introductionNodeDescriptor instead')
const IntroductionNode$json = {
  '1': 'IntroductionNode',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 11, '6': '.lndkrpc.PublicKey', '9': 0, '10': 'nodeId', '17': true},
    {'1': 'directed_short_channel_id', '3': 2, '4': 1, '5': 11, '6': '.lndkrpc.DirectedShortChannelId', '9': 1, '10': 'directedShortChannelId', '17': true},
  ],
  '8': [
    {'1': '_node_id'},
    {'1': '_directed_short_channel_id'},
  ],
};

/// Descriptor for `IntroductionNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List introductionNodeDescriptor = $convert.base64Decode(
    'ChBJbnRyb2R1Y3Rpb25Ob2RlEjAKB25vZGVfaWQYASABKAsyEi5sbmRrcnBjLlB1YmxpY0tleU'
    'gAUgZub2RlSWSIAQESXwoZZGlyZWN0ZWRfc2hvcnRfY2hhbm5lbF9pZBgCIAEoCzIfLmxuZGty'
    'cGMuRGlyZWN0ZWRTaG9ydENoYW5uZWxJZEgBUhZkaXJlY3RlZFNob3J0Q2hhbm5lbElkiAEBQg'
    'oKCF9ub2RlX2lkQhwKGl9kaXJlY3RlZF9zaG9ydF9jaGFubmVsX2lk');

@$core.Deprecated('Use directedShortChannelIdDescriptor instead')
const DirectedShortChannelId$json = {
  '1': 'DirectedShortChannelId',
  '2': [
    {'1': 'direction', '3': 1, '4': 1, '5': 14, '6': '.lndkrpc.Direction', '10': 'direction'},
    {'1': 'scid', '3': 2, '4': 1, '5': 4, '10': 'scid'},
  ],
};

/// Descriptor for `DirectedShortChannelId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List directedShortChannelIdDescriptor = $convert.base64Decode(
    'ChZEaXJlY3RlZFNob3J0Q2hhbm5lbElkEjAKCWRpcmVjdGlvbhgBIAEoDjISLmxuZGtycGMuRG'
    'lyZWN0aW9uUglkaXJlY3Rpb24SEgoEc2NpZBgCIAEoBFIEc2NpZA==');

@$core.Deprecated('Use createOfferRequestDescriptor instead')
const CreateOfferRequest$json = {
  '1': 'CreateOfferRequest',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'amount', '17': true},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'description', '17': true},
    {'1': 'issuer', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'issuer', '17': true},
    {'1': 'quantity', '3': 4, '4': 1, '5': 4, '9': 3, '10': 'quantity', '17': true},
    {'1': 'expiry', '3': 5, '4': 1, '5': 4, '9': 4, '10': 'expiry', '17': true},
  ],
  '8': [
    {'1': '_amount'},
    {'1': '_description'},
    {'1': '_issuer'},
    {'1': '_quantity'},
    {'1': '_expiry'},
  ],
};

/// Descriptor for `CreateOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOfferRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVPZmZlclJlcXVlc3QSGwoGYW1vdW50GAEgASgESABSBmFtb3VudIgBARIlCgtkZX'
    'NjcmlwdGlvbhgCIAEoCUgBUgtkZXNjcmlwdGlvbogBARIbCgZpc3N1ZXIYAyABKAlIAlIGaXNz'
    'dWVyiAEBEh8KCHF1YW50aXR5GAQgASgESANSCHF1YW50aXR5iAEBEhsKBmV4cGlyeRgFIAEoBE'
    'gEUgZleHBpcnmIAQFCCQoHX2Ftb3VudEIOCgxfZGVzY3JpcHRpb25CCQoHX2lzc3VlckILCglf'
    'cXVhbnRpdHlCCQoHX2V4cGlyeQ==');

@$core.Deprecated('Use createOfferResponseDescriptor instead')
const CreateOfferResponse$json = {
  '1': 'CreateOfferResponse',
  '2': [
    {'1': 'offer', '3': 1, '4': 1, '5': 9, '10': 'offer'},
  ],
};

/// Descriptor for `CreateOfferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createOfferResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVPZmZlclJlc3BvbnNlEhQKBW9mZmVyGAEgASgJUgVvZmZlcg==');

