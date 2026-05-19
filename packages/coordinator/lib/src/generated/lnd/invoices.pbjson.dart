//
//  Generated code. Do not modify.
//  source: lnd/invoices.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use lookupModifierDescriptor instead')
const LookupModifier$json = {
  '1': 'LookupModifier',
  '2': [
    {'1': 'DEFAULT', '2': 0},
    {'1': 'HTLC_SET_ONLY', '2': 1},
    {'1': 'HTLC_SET_BLANK', '2': 2},
  ],
};

/// Descriptor for `LookupModifier`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lookupModifierDescriptor = $convert.base64Decode(
    'Cg5Mb29rdXBNb2RpZmllchILCgdERUZBVUxUEAASEQoNSFRMQ19TRVRfT05MWRABEhIKDkhUTE'
    'NfU0VUX0JMQU5LEAI=');

@$core.Deprecated('Use cancelInvoiceMsgDescriptor instead')
const CancelInvoiceMsg$json = {
  '1': 'CancelInvoiceMsg',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
  ],
};

/// Descriptor for `CancelInvoiceMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoiceMsgDescriptor = $convert.base64Decode(
    'ChBDYW5jZWxJbnZvaWNlTXNnEiEKDHBheW1lbnRfaGFzaBgBIAEoDFILcGF5bWVudEhhc2g=');

@$core.Deprecated('Use cancelInvoiceRespDescriptor instead')
const CancelInvoiceResp$json = {
  '1': 'CancelInvoiceResp',
};

/// Descriptor for `CancelInvoiceResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cancelInvoiceRespDescriptor = $convert.base64Decode(
    'ChFDYW5jZWxJbnZvaWNlUmVzcA==');

@$core.Deprecated('Use addHoldInvoiceRequestDescriptor instead')
const AddHoldInvoiceRequest$json = {
  '1': 'AddHoldInvoiceRequest',
  '2': [
    {'1': 'memo', '3': 1, '4': 1, '5': 9, '10': 'memo'},
    {'1': 'hash', '3': 2, '4': 1, '5': 12, '10': 'hash'},
    {'1': 'value', '3': 3, '4': 1, '5': 3, '10': 'value'},
    {'1': 'value_msat', '3': 10, '4': 1, '5': 3, '10': 'valueMsat'},
    {'1': 'description_hash', '3': 4, '4': 1, '5': 12, '10': 'descriptionHash'},
    {'1': 'expiry', '3': 5, '4': 1, '5': 3, '10': 'expiry'},
    {'1': 'fallback_addr', '3': 6, '4': 1, '5': 9, '10': 'fallbackAddr'},
    {'1': 'cltv_expiry', '3': 7, '4': 1, '5': 4, '10': 'cltvExpiry'},
    {'1': 'route_hints', '3': 8, '4': 3, '5': 11, '6': '.lnrpc.RouteHint', '10': 'routeHints'},
    {'1': 'private', '3': 9, '4': 1, '5': 8, '10': 'private'},
  ],
};

/// Descriptor for `AddHoldInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addHoldInvoiceRequestDescriptor = $convert.base64Decode(
    'ChVBZGRIb2xkSW52b2ljZVJlcXVlc3QSEgoEbWVtbxgBIAEoCVIEbWVtbxISCgRoYXNoGAIgAS'
    'gMUgRoYXNoEhQKBXZhbHVlGAMgASgDUgV2YWx1ZRIdCgp2YWx1ZV9tc2F0GAogASgDUgl2YWx1'
    'ZU1zYXQSKQoQZGVzY3JpcHRpb25faGFzaBgEIAEoDFIPZGVzY3JpcHRpb25IYXNoEhYKBmV4cG'
    'lyeRgFIAEoA1IGZXhwaXJ5EiMKDWZhbGxiYWNrX2FkZHIYBiABKAlSDGZhbGxiYWNrQWRkchIf'
    'CgtjbHR2X2V4cGlyeRgHIAEoBFIKY2x0dkV4cGlyeRIxCgtyb3V0ZV9oaW50cxgIIAMoCzIQLm'
    'xucnBjLlJvdXRlSGludFIKcm91dGVIaW50cxIYCgdwcml2YXRlGAkgASgIUgdwcml2YXRl');

@$core.Deprecated('Use addHoldInvoiceRespDescriptor instead')
const AddHoldInvoiceResp$json = {
  '1': 'AddHoldInvoiceResp',
  '2': [
    {'1': 'payment_request', '3': 1, '4': 1, '5': 9, '10': 'paymentRequest'},
    {'1': 'add_index', '3': 2, '4': 1, '5': 4, '10': 'addIndex'},
    {'1': 'payment_addr', '3': 3, '4': 1, '5': 12, '10': 'paymentAddr'},
  ],
};

/// Descriptor for `AddHoldInvoiceResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addHoldInvoiceRespDescriptor = $convert.base64Decode(
    'ChJBZGRIb2xkSW52b2ljZVJlc3ASJwoPcGF5bWVudF9yZXF1ZXN0GAEgASgJUg5wYXltZW50Um'
    'VxdWVzdBIbCglhZGRfaW5kZXgYAiABKARSCGFkZEluZGV4EiEKDHBheW1lbnRfYWRkchgDIAEo'
    'DFILcGF5bWVudEFkZHI=');

@$core.Deprecated('Use settleInvoiceMsgDescriptor instead')
const SettleInvoiceMsg$json = {
  '1': 'SettleInvoiceMsg',
  '2': [
    {'1': 'preimage', '3': 1, '4': 1, '5': 12, '10': 'preimage'},
  ],
};

/// Descriptor for `SettleInvoiceMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settleInvoiceMsgDescriptor = $convert.base64Decode(
    'ChBTZXR0bGVJbnZvaWNlTXNnEhoKCHByZWltYWdlGAEgASgMUghwcmVpbWFnZQ==');

@$core.Deprecated('Use settleInvoiceRespDescriptor instead')
const SettleInvoiceResp$json = {
  '1': 'SettleInvoiceResp',
};

/// Descriptor for `SettleInvoiceResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List settleInvoiceRespDescriptor = $convert.base64Decode(
    'ChFTZXR0bGVJbnZvaWNlUmVzcA==');

@$core.Deprecated('Use subscribeSingleInvoiceRequestDescriptor instead')
const SubscribeSingleInvoiceRequest$json = {
  '1': 'SubscribeSingleInvoiceRequest',
  '2': [
    {'1': 'r_hash', '3': 2, '4': 1, '5': 12, '10': 'rHash'},
  ],
  '9': [
    {'1': 1, '2': 2},
  ],
};

/// Descriptor for `SubscribeSingleInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeSingleInvoiceRequestDescriptor = $convert.base64Decode(
    'Ch1TdWJzY3JpYmVTaW5nbGVJbnZvaWNlUmVxdWVzdBIVCgZyX2hhc2gYAiABKAxSBXJIYXNoSg'
    'QIARAC');

@$core.Deprecated('Use lookupInvoiceMsgDescriptor instead')
const LookupInvoiceMsg$json = {
  '1': 'LookupInvoiceMsg',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '9': 0, '10': 'paymentHash'},
    {'1': 'payment_addr', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'paymentAddr'},
    {'1': 'set_id', '3': 3, '4': 1, '5': 12, '9': 0, '10': 'setId'},
    {'1': 'lookup_modifier', '3': 4, '4': 1, '5': 14, '6': '.invoicesrpc.LookupModifier', '10': 'lookupModifier'},
  ],
  '8': [
    {'1': 'invoice_ref'},
  ],
};

/// Descriptor for `LookupInvoiceMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupInvoiceMsgDescriptor = $convert.base64Decode(
    'ChBMb29rdXBJbnZvaWNlTXNnEiMKDHBheW1lbnRfaGFzaBgBIAEoDEgAUgtwYXltZW50SGFzaB'
    'IjCgxwYXltZW50X2FkZHIYAiABKAxIAFILcGF5bWVudEFkZHISFwoGc2V0X2lkGAMgASgMSABS'
    'BXNldElkEkQKD2xvb2t1cF9tb2RpZmllchgEIAEoDjIbLmludm9pY2VzcnBjLkxvb2t1cE1vZG'
    'lmaWVyUg5sb29rdXBNb2RpZmllckINCgtpbnZvaWNlX3JlZg==');

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

@$core.Deprecated('Use htlcModifyRequestDescriptor instead')
const HtlcModifyRequest$json = {
  '1': 'HtlcModifyRequest',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 11, '6': '.lnrpc.Invoice', '10': 'invoice'},
    {'1': 'exit_htlc_circuit_key', '3': 2, '4': 1, '5': 11, '6': '.invoicesrpc.CircuitKey', '10': 'exitHtlcCircuitKey'},
    {'1': 'exit_htlc_amt', '3': 3, '4': 1, '5': 4, '10': 'exitHtlcAmt'},
    {'1': 'exit_htlc_expiry', '3': 4, '4': 1, '5': 13, '10': 'exitHtlcExpiry'},
    {'1': 'current_height', '3': 5, '4': 1, '5': 13, '10': 'currentHeight'},
    {'1': 'exit_htlc_wire_custom_records', '3': 6, '4': 3, '5': 11, '6': '.invoicesrpc.HtlcModifyRequest.ExitHtlcWireCustomRecordsEntry', '10': 'exitHtlcWireCustomRecords'},
  ],
  '3': [HtlcModifyRequest_ExitHtlcWireCustomRecordsEntry$json],
};

@$core.Deprecated('Use htlcModifyRequestDescriptor instead')
const HtlcModifyRequest_ExitHtlcWireCustomRecordsEntry$json = {
  '1': 'ExitHtlcWireCustomRecordsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 4, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `HtlcModifyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htlcModifyRequestDescriptor = $convert.base64Decode(
    'ChFIdGxjTW9kaWZ5UmVxdWVzdBIoCgdpbnZvaWNlGAEgASgLMg4ubG5ycGMuSW52b2ljZVIHaW'
    '52b2ljZRJKChVleGl0X2h0bGNfY2lyY3VpdF9rZXkYAiABKAsyFy5pbnZvaWNlc3JwYy5DaXJj'
    'dWl0S2V5UhJleGl0SHRsY0NpcmN1aXRLZXkSIgoNZXhpdF9odGxjX2FtdBgDIAEoBFILZXhpdE'
    'h0bGNBbXQSKAoQZXhpdF9odGxjX2V4cGlyeRgEIAEoDVIOZXhpdEh0bGNFeHBpcnkSJQoOY3Vy'
    'cmVudF9oZWlnaHQYBSABKA1SDWN1cnJlbnRIZWlnaHQSfwodZXhpdF9odGxjX3dpcmVfY3VzdG'
    '9tX3JlY29yZHMYBiADKAsyPS5pbnZvaWNlc3JwYy5IdGxjTW9kaWZ5UmVxdWVzdC5FeGl0SHRs'
    'Y1dpcmVDdXN0b21SZWNvcmRzRW50cnlSGWV4aXRIdGxjV2lyZUN1c3RvbVJlY29yZHMaTAoeRX'
    'hpdEh0bGNXaXJlQ3VzdG9tUmVjb3Jkc0VudHJ5EhAKA2tleRgBIAEoBFIDa2V5EhQKBXZhbHVl'
    'GAIgASgMUgV2YWx1ZToCOAE=');

@$core.Deprecated('Use htlcModifyResponseDescriptor instead')
const HtlcModifyResponse$json = {
  '1': 'HtlcModifyResponse',
  '2': [
    {'1': 'circuit_key', '3': 1, '4': 1, '5': 11, '6': '.invoicesrpc.CircuitKey', '10': 'circuitKey'},
    {'1': 'amt_paid', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amtPaid', '17': true},
    {'1': 'cancel_set', '3': 3, '4': 1, '5': 8, '10': 'cancelSet'},
  ],
  '8': [
    {'1': '_amt_paid'},
  ],
};

/// Descriptor for `HtlcModifyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List htlcModifyResponseDescriptor = $convert.base64Decode(
    'ChJIdGxjTW9kaWZ5UmVzcG9uc2USOAoLY2lyY3VpdF9rZXkYASABKAsyFy5pbnZvaWNlc3JwYy'
    '5DaXJjdWl0S2V5UgpjaXJjdWl0S2V5Eh4KCGFtdF9wYWlkGAIgASgESABSB2FtdFBhaWSIAQES'
    'HQoKY2FuY2VsX3NldBgDIAEoCFIJY2FuY2VsU2V0QgsKCV9hbXRfcGFpZA==');

