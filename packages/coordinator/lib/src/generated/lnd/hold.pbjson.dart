//
//  Generated code. Do not modify.
//  source: lnd/hold.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use holdstateDescriptor instead')
const Holdstate$json = {
  '1': 'Holdstate',
  '2': [
    {'1': 'OPEN', '2': 0},
    {'1': 'SETTLED', '2': 1},
    {'1': 'CANCELED', '2': 2},
    {'1': 'ACCEPTED', '2': 3},
  ],
};

/// Descriptor for `Holdstate`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List holdstateDescriptor = $convert.base64Decode(
    'CglIb2xkc3RhdGUSCAoET1BFThAAEgsKB1NFVFRMRUQQARIMCghDQU5DRUxFRBACEgwKCEFDQ0'
    'VQVEVEEAM=');

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

@$core.Deprecated('Use holdInvoiceRequestDescriptor instead')
const HoldInvoiceRequest$json = {
  '1': 'HoldInvoiceRequest',
  '2': [
    {'1': 'amount_msat', '3': 10, '4': 1, '5': 11, '6': '.hold.Amount', '10': 'amountMsat'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '10': 'description'},
    {'1': 'label', '3': 3, '4': 1, '5': 9, '10': 'label'},
    {'1': 'expiry', '3': 7, '4': 1, '5': 4, '9': 0, '10': 'expiry', '17': true},
    {'1': 'fallbacks', '3': 4, '4': 3, '5': 9, '10': 'fallbacks'},
    {'1': 'preimage', '3': 5, '4': 1, '5': 12, '9': 1, '10': 'preimage', '17': true},
    {'1': 'cltv', '3': 6, '4': 1, '5': 13, '9': 2, '10': 'cltv', '17': true},
    {'1': 'exposeprivatechannels', '3': 8, '4': 3, '5': 9, '10': 'exposeprivatechannels'},
    {'1': 'deschashonly', '3': 9, '4': 1, '5': 8, '9': 3, '10': 'deschashonly', '17': true},
  ],
  '8': [
    {'1': '_expiry'},
    {'1': '_preimage'},
    {'1': '_cltv'},
    {'1': '_deschashonly'},
  ],
};

/// Descriptor for `HoldInvoiceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceRequestDescriptor = $convert.base64Decode(
    'ChJIb2xkSW52b2ljZVJlcXVlc3QSLQoLYW1vdW50X21zYXQYCiABKAsyDC5ob2xkLkFtb3VudF'
    'IKYW1vdW50TXNhdBIgCgtkZXNjcmlwdGlvbhgCIAEoCVILZGVzY3JpcHRpb24SFAoFbGFiZWwY'
    'AyABKAlSBWxhYmVsEhsKBmV4cGlyeRgHIAEoBEgAUgZleHBpcnmIAQESHAoJZmFsbGJhY2tzGA'
    'QgAygJUglmYWxsYmFja3MSHwoIcHJlaW1hZ2UYBSABKAxIAVIIcHJlaW1hZ2WIAQESFwoEY2x0'
    'dhgGIAEoDUgCUgRjbHR2iAEBEjQKFWV4cG9zZXByaXZhdGVjaGFubmVscxgIIAMoCVIVZXhwb3'
    'NlcHJpdmF0ZWNoYW5uZWxzEicKDGRlc2NoYXNob25seRgJIAEoCEgDUgxkZXNjaGFzaG9ubHmI'
    'AQFCCQoHX2V4cGlyeUILCglfcHJlaW1hZ2VCBwoFX2NsdHZCDwoNX2Rlc2NoYXNob25seQ==');

@$core.Deprecated('Use holdInvoiceResponseDescriptor instead')
const HoldInvoiceResponse$json = {
  '1': 'HoldInvoiceResponse',
  '2': [
    {'1': 'bolt11', '3': 1, '4': 1, '5': 9, '10': 'bolt11'},
    {'1': 'payment_hash', '3': 2, '4': 1, '5': 12, '10': 'paymentHash'},
    {'1': 'payment_secret', '3': 3, '4': 1, '5': 12, '10': 'paymentSecret'},
    {'1': 'expires_at', '3': 4, '4': 1, '5': 4, '10': 'expiresAt'},
    {'1': 'warning_capacity', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'warningCapacity', '17': true},
    {'1': 'warning_offline', '3': 6, '4': 1, '5': 9, '9': 1, '10': 'warningOffline', '17': true},
    {'1': 'warning_deadends', '3': 7, '4': 1, '5': 9, '9': 2, '10': 'warningDeadends', '17': true},
    {'1': 'warning_private_unused', '3': 8, '4': 1, '5': 9, '9': 3, '10': 'warningPrivateUnused', '17': true},
    {'1': 'warning_mpp', '3': 9, '4': 1, '5': 9, '9': 4, '10': 'warningMpp', '17': true},
    {'1': 'created_index', '3': 10, '4': 1, '5': 4, '9': 5, '10': 'createdIndex', '17': true},
  ],
  '8': [
    {'1': '_warning_capacity'},
    {'1': '_warning_offline'},
    {'1': '_warning_deadends'},
    {'1': '_warning_private_unused'},
    {'1': '_warning_mpp'},
    {'1': '_created_index'},
  ],
};

/// Descriptor for `HoldInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceResponseDescriptor = $convert.base64Decode(
    'ChNIb2xkSW52b2ljZVJlc3BvbnNlEhYKBmJvbHQxMRgBIAEoCVIGYm9sdDExEiEKDHBheW1lbn'
    'RfaGFzaBgCIAEoDFILcGF5bWVudEhhc2gSJQoOcGF5bWVudF9zZWNyZXQYAyABKAxSDXBheW1l'
    'bnRTZWNyZXQSHQoKZXhwaXJlc19hdBgEIAEoBFIJZXhwaXJlc0F0Ei4KEHdhcm5pbmdfY2FwYW'
    'NpdHkYBSABKAlIAFIPd2FybmluZ0NhcGFjaXR5iAEBEiwKD3dhcm5pbmdfb2ZmbGluZRgGIAEo'
    'CUgBUg53YXJuaW5nT2ZmbGluZYgBARIuChB3YXJuaW5nX2RlYWRlbmRzGAcgASgJSAJSD3dhcm'
    '5pbmdEZWFkZW5kc4gBARI5ChZ3YXJuaW5nX3ByaXZhdGVfdW51c2VkGAggASgJSANSFHdhcm5p'
    'bmdQcml2YXRlVW51c2VkiAEBEiQKC3dhcm5pbmdfbXBwGAkgASgJSARSCndhcm5pbmdNcHCIAQ'
    'ESKAoNY3JlYXRlZF9pbmRleBgKIAEoBEgFUgxjcmVhdGVkSW5kZXiIAQFCEwoRX3dhcm5pbmdf'
    'Y2FwYWNpdHlCEgoQX3dhcm5pbmdfb2ZmbGluZUITChFfd2FybmluZ19kZWFkZW5kc0IZChdfd2'
    'FybmluZ19wcml2YXRlX3VudXNlZEIOCgxfd2FybmluZ19tcHBCEAoOX2NyZWF0ZWRfaW5kZXg=');

@$core.Deprecated('Use holdInvoiceSettleRequestDescriptor instead')
const HoldInvoiceSettleRequest$json = {
  '1': 'HoldInvoiceSettleRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
  ],
};

/// Descriptor for `HoldInvoiceSettleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceSettleRequestDescriptor = $convert.base64Decode(
    'ChhIb2xkSW52b2ljZVNldHRsZVJlcXVlc3QSIQoMcGF5bWVudF9oYXNoGAEgASgMUgtwYXltZW'
    '50SGFzaA==');

@$core.Deprecated('Use holdInvoiceSettleResponseDescriptor instead')
const HoldInvoiceSettleResponse$json = {
  '1': 'HoldInvoiceSettleResponse',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.hold.Holdstate', '10': 'state'},
  ],
};

/// Descriptor for `HoldInvoiceSettleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceSettleResponseDescriptor = $convert.base64Decode(
    'ChlIb2xkSW52b2ljZVNldHRsZVJlc3BvbnNlEiUKBXN0YXRlGAEgASgOMg8uaG9sZC5Ib2xkc3'
    'RhdGVSBXN0YXRl');

@$core.Deprecated('Use holdInvoiceCancelRequestDescriptor instead')
const HoldInvoiceCancelRequest$json = {
  '1': 'HoldInvoiceCancelRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
  ],
};

/// Descriptor for `HoldInvoiceCancelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceCancelRequestDescriptor = $convert.base64Decode(
    'ChhIb2xkSW52b2ljZUNhbmNlbFJlcXVlc3QSIQoMcGF5bWVudF9oYXNoGAEgASgMUgtwYXltZW'
    '50SGFzaA==');

@$core.Deprecated('Use holdInvoiceCancelResponseDescriptor instead')
const HoldInvoiceCancelResponse$json = {
  '1': 'HoldInvoiceCancelResponse',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.hold.Holdstate', '10': 'state'},
  ],
};

/// Descriptor for `HoldInvoiceCancelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceCancelResponseDescriptor = $convert.base64Decode(
    'ChlIb2xkSW52b2ljZUNhbmNlbFJlc3BvbnNlEiUKBXN0YXRlGAEgASgOMg8uaG9sZC5Ib2xkc3'
    'RhdGVSBXN0YXRl');

@$core.Deprecated('Use holdInvoiceLookupRequestDescriptor instead')
const HoldInvoiceLookupRequest$json = {
  '1': 'HoldInvoiceLookupRequest',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 12, '10': 'paymentHash'},
  ],
};

/// Descriptor for `HoldInvoiceLookupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceLookupRequestDescriptor = $convert.base64Decode(
    'ChhIb2xkSW52b2ljZUxvb2t1cFJlcXVlc3QSIQoMcGF5bWVudF9oYXNoGAEgASgMUgtwYXltZW'
    '50SGFzaA==');

@$core.Deprecated('Use holdInvoiceLookupResponseDescriptor instead')
const HoldInvoiceLookupResponse$json = {
  '1': 'HoldInvoiceLookupResponse',
  '2': [
    {'1': 'state', '3': 1, '4': 1, '5': 14, '6': '.hold.Holdstate', '10': 'state'},
    {'1': 'htlc_expiry', '3': 2, '4': 1, '5': 13, '9': 0, '10': 'htlcExpiry', '17': true},
  ],
  '8': [
    {'1': '_htlc_expiry'},
  ],
};

/// Descriptor for `HoldInvoiceLookupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List holdInvoiceLookupResponseDescriptor = $convert.base64Decode(
    'ChlIb2xkSW52b2ljZUxvb2t1cFJlc3BvbnNlEiUKBXN0YXRlGAEgASgOMg8uaG9sZC5Ib2xkc3'
    'RhdGVSBXN0YXRlEiQKC2h0bGNfZXhwaXJ5GAIgASgNSABSCmh0bGNFeHBpcnmIAQFCDgoMX2h0'
    'bGNfZXhwaXJ5');

