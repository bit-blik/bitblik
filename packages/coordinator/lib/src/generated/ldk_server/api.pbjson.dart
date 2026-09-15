//
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getNodeInfoRequestDescriptor instead')
const GetNodeInfoRequest$json = {
  '1': 'GetNodeInfoRequest',
};

/// Descriptor for `GetNodeInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNodeInfoRequestDescriptor = $convert.base64Decode(
    'ChJHZXROb2RlSW5mb1JlcXVlc3Q=');

@$core.Deprecated('Use getNodeInfoResponseDescriptor instead')
const GetNodeInfoResponse$json = {
  '1': 'GetNodeInfoResponse',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '10': 'nodeId'},
    {'1': 'current_best_block', '3': 3, '4': 1, '5': 11, '6': '.types.BestBlock', '10': 'currentBestBlock'},
    {'1': 'latest_lightning_wallet_sync_timestamp', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'latestLightningWalletSyncTimestamp', '17': true},
    {'1': 'latest_onchain_wallet_sync_timestamp', '3': 5, '4': 1, '5': 4, '9': 1, '10': 'latestOnchainWalletSyncTimestamp', '17': true},
    {'1': 'latest_fee_rate_cache_update_timestamp', '3': 6, '4': 1, '5': 4, '9': 2, '10': 'latestFeeRateCacheUpdateTimestamp', '17': true},
    {'1': 'latest_rgs_snapshot_timestamp', '3': 7, '4': 1, '5': 4, '9': 3, '10': 'latestRgsSnapshotTimestamp', '17': true},
    {'1': 'latest_node_announcement_broadcast_timestamp', '3': 8, '4': 1, '5': 4, '9': 4, '10': 'latestNodeAnnouncementBroadcastTimestamp', '17': true},
    {'1': 'listening_addresses', '3': 9, '4': 3, '5': 9, '10': 'listeningAddresses'},
    {'1': 'announcement_addresses', '3': 10, '4': 3, '5': 9, '10': 'announcementAddresses'},
    {'1': 'node_alias', '3': 11, '4': 1, '5': 9, '9': 5, '10': 'nodeAlias', '17': true},
    {'1': 'node_uris', '3': 12, '4': 3, '5': 9, '10': 'nodeUris'},
    {'1': 'network', '3': 13, '4': 1, '5': 14, '6': '.types.Network', '10': 'network'},
    {'1': 'features', '3': 14, '4': 3, '5': 11, '6': '.api.GetNodeInfoResponse.FeaturesEntry', '10': 'features'},
    {'1': 'latest_pathfinding_scores_sync_timestamp', '3': 15, '4': 1, '5': 4, '9': 6, '10': 'latestPathfindingScoresSyncTimestamp', '17': true},
  ],
  '3': [GetNodeInfoResponse_FeaturesEntry$json],
  '8': [
    {'1': '_latest_lightning_wallet_sync_timestamp'},
    {'1': '_latest_onchain_wallet_sync_timestamp'},
    {'1': '_latest_fee_rate_cache_update_timestamp'},
    {'1': '_latest_rgs_snapshot_timestamp'},
    {'1': '_latest_node_announcement_broadcast_timestamp'},
    {'1': '_node_alias'},
    {'1': '_latest_pathfinding_scores_sync_timestamp'},
  ],
};

@$core.Deprecated('Use getNodeInfoResponseDescriptor instead')
const GetNodeInfoResponse_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.types.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `GetNodeInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getNodeInfoResponseDescriptor = $convert.base64Decode(
    'ChNHZXROb2RlSW5mb1Jlc3BvbnNlEhcKB25vZGVfaWQYASABKAlSBm5vZGVJZBI+ChJjdXJyZW'
    '50X2Jlc3RfYmxvY2sYAyABKAsyEC50eXBlcy5CZXN0QmxvY2tSEGN1cnJlbnRCZXN0QmxvY2sS'
    'VwombGF0ZXN0X2xpZ2h0bmluZ193YWxsZXRfc3luY190aW1lc3RhbXAYBCABKARIAFIibGF0ZX'
    'N0TGlnaHRuaW5nV2FsbGV0U3luY1RpbWVzdGFtcIgBARJTCiRsYXRlc3Rfb25jaGFpbl93YWxs'
    'ZXRfc3luY190aW1lc3RhbXAYBSABKARIAVIgbGF0ZXN0T25jaGFpbldhbGxldFN5bmNUaW1lc3'
    'RhbXCIAQESVgombGF0ZXN0X2ZlZV9yYXRlX2NhY2hlX3VwZGF0ZV90aW1lc3RhbXAYBiABKARI'
    'AlIhbGF0ZXN0RmVlUmF0ZUNhY2hlVXBkYXRlVGltZXN0YW1wiAEBEkYKHWxhdGVzdF9yZ3Nfc2'
    '5hcHNob3RfdGltZXN0YW1wGAcgASgESANSGmxhdGVzdFJnc1NuYXBzaG90VGltZXN0YW1wiAEB'
    'EmMKLGxhdGVzdF9ub2RlX2Fubm91bmNlbWVudF9icm9hZGNhc3RfdGltZXN0YW1wGAggASgESA'
    'RSKGxhdGVzdE5vZGVBbm5vdW5jZW1lbnRCcm9hZGNhc3RUaW1lc3RhbXCIAQESLwoTbGlzdGVu'
    'aW5nX2FkZHJlc3NlcxgJIAMoCVISbGlzdGVuaW5nQWRkcmVzc2VzEjUKFmFubm91bmNlbWVudF'
    '9hZGRyZXNzZXMYCiADKAlSFWFubm91bmNlbWVudEFkZHJlc3NlcxIiCgpub2RlX2FsaWFzGAsg'
    'ASgJSAVSCW5vZGVBbGlhc4gBARIbCglub2RlX3VyaXMYDCADKAlSCG5vZGVVcmlzEigKB25ldH'
    'dvcmsYDSABKA4yDi50eXBlcy5OZXR3b3JrUgduZXR3b3JrEkIKCGZlYXR1cmVzGA4gAygLMiYu'
    'YXBpLkdldE5vZGVJbmZvUmVzcG9uc2UuRmVhdHVyZXNFbnRyeVIIZmVhdHVyZXMSWwoobGF0ZX'
    'N0X3BhdGhmaW5kaW5nX3Njb3Jlc19zeW5jX3RpbWVzdGFtcBgPIAEoBEgGUiRsYXRlc3RQYXRo'
    'ZmluZGluZ1Njb3Jlc1N5bmNUaW1lc3RhbXCIAQEaSwoNRmVhdHVyZXNFbnRyeRIQCgNrZXkYAS'
    'ABKA1SA2tleRIkCgV2YWx1ZRgCIAEoCzIOLnR5cGVzLkZlYXR1cmVSBXZhbHVlOgI4AUIpCidf'
    'bGF0ZXN0X2xpZ2h0bmluZ193YWxsZXRfc3luY190aW1lc3RhbXBCJwolX2xhdGVzdF9vbmNoYW'
    'luX3dhbGxldF9zeW5jX3RpbWVzdGFtcEIpCidfbGF0ZXN0X2ZlZV9yYXRlX2NhY2hlX3VwZGF0'
    'ZV90aW1lc3RhbXBCIAoeX2xhdGVzdF9yZ3Nfc25hcHNob3RfdGltZXN0YW1wQi8KLV9sYXRlc3'
    'Rfbm9kZV9hbm5vdW5jZW1lbnRfYnJvYWRjYXN0X3RpbWVzdGFtcEINCgtfbm9kZV9hbGlhc0Ir'
    'CilfbGF0ZXN0X3BhdGhmaW5kaW5nX3Njb3Jlc19zeW5jX3RpbWVzdGFtcA==');

@$core.Deprecated('Use onchainReceiveRequestDescriptor instead')
const OnchainReceiveRequest$json = {
  '1': 'OnchainReceiveRequest',
};

/// Descriptor for `OnchainReceiveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onchainReceiveRequestDescriptor = $convert.base64Decode(
    'ChVPbmNoYWluUmVjZWl2ZVJlcXVlc3Q=');

@$core.Deprecated('Use onchainReceiveResponseDescriptor instead')
const OnchainReceiveResponse$json = {
  '1': 'OnchainReceiveResponse',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `OnchainReceiveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onchainReceiveResponseDescriptor = $convert.base64Decode(
    'ChZPbmNoYWluUmVjZWl2ZVJlc3BvbnNlEhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3M=');

@$core.Deprecated('Use onchainSendRequestDescriptor instead')
const OnchainSendRequest$json = {
  '1': 'OnchainSendRequest',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
    {'1': 'amount_sats', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amountSats'},
    {'1': 'all_funds', '3': 3, '4': 1, '5': 11, '6': '.api.AllFunds', '9': 0, '10': 'allFunds'},
    {'1': 'fee_rate_sat_per_vb', '3': 4, '4': 1, '5': 4, '9': 1, '10': 'feeRateSatPerVb', '17': true},
  ],
  '8': [
    {'1': 'amount'},
    {'1': '_fee_rate_sat_per_vb'},
  ],
};

/// Descriptor for `OnchainSendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onchainSendRequestDescriptor = $convert.base64Decode(
    'ChJPbmNoYWluU2VuZFJlcXVlc3QSGAoHYWRkcmVzcxgBIAEoCVIHYWRkcmVzcxIhCgthbW91bn'
    'Rfc2F0cxgCIAEoBEgAUgphbW91bnRTYXRzEiwKCWFsbF9mdW5kcxgDIAEoCzINLmFwaS5BbGxG'
    'dW5kc0gAUghhbGxGdW5kcxIxChNmZWVfcmF0ZV9zYXRfcGVyX3ZiGAQgASgESAFSD2ZlZVJhdG'
    'VTYXRQZXJWYogBAUIICgZhbW91bnRCFgoUX2ZlZV9yYXRlX3NhdF9wZXJfdmI=');

@$core.Deprecated('Use onchainSendResponseDescriptor instead')
const OnchainSendResponse$json = {
  '1': 'OnchainSendResponse',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 9, '10': 'txid'},
  ],
};

/// Descriptor for `OnchainSendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onchainSendResponseDescriptor = $convert.base64Decode(
    'ChNPbmNoYWluU2VuZFJlc3BvbnNlEhIKBHR4aWQYASABKAlSBHR4aWQ=');

@$core.Deprecated('Use bolt11ReceiveRequestDescriptor instead')
const Bolt11ReceiveRequest$json = {
  '1': 'Bolt11ReceiveRequest',
  '2': [
    {'1': 'amount_msat', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'description', '3': 2, '4': 1, '5': 11, '6': '.types.Bolt11InvoiceDescription', '10': 'description'},
    {'1': 'expiry_secs', '3': 3, '4': 1, '5': 13, '10': 'expirySecs'},
  ],
  '8': [
    {'1': '_amount_msat'},
  ],
};

/// Descriptor for `Bolt11ReceiveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveRequestDescriptor = $convert.base64Decode(
    'ChRCb2x0MTFSZWNlaXZlUmVxdWVzdBIkCgthbW91bnRfbXNhdBgBIAEoBEgAUgphbW91bnRNc2'
    'F0iAEBEkEKC2Rlc2NyaXB0aW9uGAIgASgLMh8udHlwZXMuQm9sdDExSW52b2ljZURlc2NyaXB0'
    'aW9uUgtkZXNjcmlwdGlvbhIfCgtleHBpcnlfc2VjcxgDIAEoDVIKZXhwaXJ5U2Vjc0IOCgxfYW'
    '1vdW50X21zYXQ=');

@$core.Deprecated('Use bolt11ReceiveResponseDescriptor instead')
const Bolt11ReceiveResponse$json = {
  '1': 'Bolt11ReceiveResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
    {'1': 'payment_hash', '3': 2, '4': 1, '5': 9, '10': 'paymentHash'},
    {'1': 'payment_secret', '3': 3, '4': 1, '5': 9, '10': 'paymentSecret'},
  ],
};

/// Descriptor for `Bolt11ReceiveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveResponseDescriptor = $convert.base64Decode(
    'ChVCb2x0MTFSZWNlaXZlUmVzcG9uc2USGAoHaW52b2ljZRgBIAEoCVIHaW52b2ljZRIhCgxwYX'
    'ltZW50X2hhc2gYAiABKAlSC3BheW1lbnRIYXNoEiUKDnBheW1lbnRfc2VjcmV0GAMgASgJUg1w'
    'YXltZW50U2VjcmV0');

@$core.Deprecated('Use bolt11ReceiveForHashRequestDescriptor instead')
const Bolt11ReceiveForHashRequest$json = {
  '1': 'Bolt11ReceiveForHashRequest',
  '2': [
    {'1': 'amount_msat', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'description', '3': 2, '4': 1, '5': 11, '6': '.types.Bolt11InvoiceDescription', '10': 'description'},
    {'1': 'expiry_secs', '3': 3, '4': 1, '5': 13, '10': 'expirySecs'},
    {'1': 'payment_hash', '3': 4, '4': 1, '5': 9, '10': 'paymentHash'},
  ],
  '8': [
    {'1': '_amount_msat'},
  ],
};

/// Descriptor for `Bolt11ReceiveForHashRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveForHashRequestDescriptor = $convert.base64Decode(
    'ChtCb2x0MTFSZWNlaXZlRm9ySGFzaFJlcXVlc3QSJAoLYW1vdW50X21zYXQYASABKARIAFIKYW'
    '1vdW50TXNhdIgBARJBCgtkZXNjcmlwdGlvbhgCIAEoCzIfLnR5cGVzLkJvbHQxMUludm9pY2VE'
    'ZXNjcmlwdGlvblILZGVzY3JpcHRpb24SHwoLZXhwaXJ5X3NlY3MYAyABKA1SCmV4cGlyeVNlY3'
    'MSIQoMcGF5bWVudF9oYXNoGAQgASgJUgtwYXltZW50SGFzaEIOCgxfYW1vdW50X21zYXQ=');

@$core.Deprecated('Use bolt11ReceiveForHashResponseDescriptor instead')
const Bolt11ReceiveForHashResponse$json = {
  '1': 'Bolt11ReceiveForHashResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
  ],
};

/// Descriptor for `Bolt11ReceiveForHashResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveForHashResponseDescriptor = $convert.base64Decode(
    'ChxCb2x0MTFSZWNlaXZlRm9ySGFzaFJlc3BvbnNlEhgKB2ludm9pY2UYASABKAlSB2ludm9pY2'
    'U=');

@$core.Deprecated('Use bolt11ClaimForIdRequestDescriptor instead')
const Bolt11ClaimForIdRequest$json = {
  '1': 'Bolt11ClaimForIdRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'claimable_amount_msat', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'claimableAmountMsat', '17': true},
    {'1': 'preimage', '3': 3, '4': 1, '5': 9, '10': 'preimage'},
  ],
  '8': [
    {'1': '_claimable_amount_msat'},
  ],
};

/// Descriptor for `Bolt11ClaimForIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ClaimForIdRequestDescriptor = $convert.base64Decode(
    'ChdCb2x0MTFDbGFpbUZvcklkUmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SW'
    'QSNwoVY2xhaW1hYmxlX2Ftb3VudF9tc2F0GAIgASgESABSE2NsYWltYWJsZUFtb3VudE1zYXSI'
    'AQESGgoIcHJlaW1hZ2UYAyABKAlSCHByZWltYWdlQhgKFl9jbGFpbWFibGVfYW1vdW50X21zYX'
    'Q=');

@$core.Deprecated('Use bolt11ClaimForIdResponseDescriptor instead')
const Bolt11ClaimForIdResponse$json = {
  '1': 'Bolt11ClaimForIdResponse',
};

/// Descriptor for `Bolt11ClaimForIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ClaimForIdResponseDescriptor = $convert.base64Decode(
    'ChhCb2x0MTFDbGFpbUZvcklkUmVzcG9uc2U=');

@$core.Deprecated('Use bolt11FailForIdRequestDescriptor instead')
const Bolt11FailForIdRequest$json = {
  '1': 'Bolt11FailForIdRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `Bolt11FailForIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11FailForIdRequestDescriptor = $convert.base64Decode(
    'ChZCb2x0MTFGYWlsRm9ySWRSZXF1ZXN0Eh0KCnBheW1lbnRfaWQYASABKAlSCXBheW1lbnRJZA'
    '==');

@$core.Deprecated('Use bolt11FailForIdResponseDescriptor instead')
const Bolt11FailForIdResponse$json = {
  '1': 'Bolt11FailForIdResponse',
};

/// Descriptor for `Bolt11FailForIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11FailForIdResponseDescriptor = $convert.base64Decode(
    'ChdCb2x0MTFGYWlsRm9ySWRSZXNwb25zZQ==');

@$core.Deprecated('Use bolt11ReceiveViaJitChannelRequestDescriptor instead')
const Bolt11ReceiveViaJitChannelRequest$json = {
  '1': 'Bolt11ReceiveViaJitChannelRequest',
  '2': [
    {'1': 'amount_msat', '3': 1, '4': 1, '5': 4, '10': 'amountMsat'},
    {'1': 'description', '3': 2, '4': 1, '5': 11, '6': '.types.Bolt11InvoiceDescription', '10': 'description'},
    {'1': 'expiry_secs', '3': 3, '4': 1, '5': 13, '10': 'expirySecs'},
    {'1': 'max_total_lsp_fee_limit_msat', '3': 4, '4': 1, '5': 4, '9': 0, '10': 'maxTotalLspFeeLimitMsat', '17': true},
  ],
  '8': [
    {'1': '_max_total_lsp_fee_limit_msat'},
  ],
};

/// Descriptor for `Bolt11ReceiveViaJitChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveViaJitChannelRequestDescriptor = $convert.base64Decode(
    'CiFCb2x0MTFSZWNlaXZlVmlhSml0Q2hhbm5lbFJlcXVlc3QSHwoLYW1vdW50X21zYXQYASABKA'
    'RSCmFtb3VudE1zYXQSQQoLZGVzY3JpcHRpb24YAiABKAsyHy50eXBlcy5Cb2x0MTFJbnZvaWNl'
    'RGVzY3JpcHRpb25SC2Rlc2NyaXB0aW9uEh8KC2V4cGlyeV9zZWNzGAMgASgNUgpleHBpcnlTZW'
    'NzEkIKHG1heF90b3RhbF9sc3BfZmVlX2xpbWl0X21zYXQYBCABKARIAFIXbWF4VG90YWxMc3BG'
    'ZWVMaW1pdE1zYXSIAQFCHwodX21heF90b3RhbF9sc3BfZmVlX2xpbWl0X21zYXQ=');

@$core.Deprecated('Use bolt11ReceiveViaJitChannelResponseDescriptor instead')
const Bolt11ReceiveViaJitChannelResponse$json = {
  '1': 'Bolt11ReceiveViaJitChannelResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
  ],
};

/// Descriptor for `Bolt11ReceiveViaJitChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveViaJitChannelResponseDescriptor = $convert.base64Decode(
    'CiJCb2x0MTFSZWNlaXZlVmlhSml0Q2hhbm5lbFJlc3BvbnNlEhgKB2ludm9pY2UYASABKAlSB2'
    'ludm9pY2U=');

@$core.Deprecated('Use bolt11ReceiveVariableAmountViaJitChannelRequestDescriptor instead')
const Bolt11ReceiveVariableAmountViaJitChannelRequest$json = {
  '1': 'Bolt11ReceiveVariableAmountViaJitChannelRequest',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 11, '6': '.types.Bolt11InvoiceDescription', '10': 'description'},
    {'1': 'expiry_secs', '3': 2, '4': 1, '5': 13, '10': 'expirySecs'},
    {'1': 'max_proportional_lsp_fee_limit_ppm_msat', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'maxProportionalLspFeeLimitPpmMsat', '17': true},
  ],
  '8': [
    {'1': '_max_proportional_lsp_fee_limit_ppm_msat'},
  ],
};

/// Descriptor for `Bolt11ReceiveVariableAmountViaJitChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveVariableAmountViaJitChannelRequestDescriptor = $convert.base64Decode(
    'Ci9Cb2x0MTFSZWNlaXZlVmFyaWFibGVBbW91bnRWaWFKaXRDaGFubmVsUmVxdWVzdBJBCgtkZX'
    'NjcmlwdGlvbhgBIAEoCzIfLnR5cGVzLkJvbHQxMUludm9pY2VEZXNjcmlwdGlvblILZGVzY3Jp'
    'cHRpb24SHwoLZXhwaXJ5X3NlY3MYAiABKA1SCmV4cGlyeVNlY3MSVwonbWF4X3Byb3BvcnRpb2'
    '5hbF9sc3BfZmVlX2xpbWl0X3BwbV9tc2F0GAMgASgESABSIW1heFByb3BvcnRpb25hbExzcEZl'
    'ZUxpbWl0UHBtTXNhdIgBAUIqCihfbWF4X3Byb3BvcnRpb25hbF9sc3BfZmVlX2xpbWl0X3BwbV'
    '9tc2F0');

@$core.Deprecated('Use bolt11ReceiveVariableAmountViaJitChannelResponseDescriptor instead')
const Bolt11ReceiveVariableAmountViaJitChannelResponse$json = {
  '1': 'Bolt11ReceiveVariableAmountViaJitChannelResponse',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
  ],
};

/// Descriptor for `Bolt11ReceiveVariableAmountViaJitChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11ReceiveVariableAmountViaJitChannelResponseDescriptor = $convert.base64Decode(
    'CjBCb2x0MTFSZWNlaXZlVmFyaWFibGVBbW91bnRWaWFKaXRDaGFubmVsUmVzcG9uc2USGAoHaW'
    '52b2ljZRgBIAEoCVIHaW52b2ljZQ==');

@$core.Deprecated('Use bolt11SendRequestDescriptor instead')
const Bolt11SendRequest$json = {
  '1': 'Bolt11SendRequest',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
    {'1': 'amount_msat', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'route_parameters', '3': 3, '4': 1, '5': 11, '6': '.types.RouteParametersConfig', '9': 1, '10': 'routeParameters', '17': true},
  ],
  '8': [
    {'1': '_amount_msat'},
    {'1': '_route_parameters'},
  ],
};

/// Descriptor for `Bolt11SendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11SendRequestDescriptor = $convert.base64Decode(
    'ChFCb2x0MTFTZW5kUmVxdWVzdBIYCgdpbnZvaWNlGAEgASgJUgdpbnZvaWNlEiQKC2Ftb3VudF'
    '9tc2F0GAIgASgESABSCmFtb3VudE1zYXSIAQESTAoQcm91dGVfcGFyYW1ldGVycxgDIAEoCzIc'
    'LnR5cGVzLlJvdXRlUGFyYW1ldGVyc0NvbmZpZ0gBUg9yb3V0ZVBhcmFtZXRlcnOIAQFCDgoMX2'
    'Ftb3VudF9tc2F0QhMKEV9yb3V0ZV9wYXJhbWV0ZXJz');

@$core.Deprecated('Use bolt11SendResponseDescriptor instead')
const Bolt11SendResponse$json = {
  '1': 'Bolt11SendResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `Bolt11SendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11SendResponseDescriptor = $convert.base64Decode(
    'ChJCb2x0MTFTZW5kUmVzcG9uc2USHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElk');

@$core.Deprecated('Use bolt11SendUnderpayingRequestDescriptor instead')
const Bolt11SendUnderpayingRequest$json = {
  '1': 'Bolt11SendUnderpayingRequest',
  '2': [
    {'1': 'invoice', '3': 1, '4': 1, '5': 9, '10': 'invoice'},
    {'1': 'amount_msat', '3': 2, '4': 1, '5': 4, '10': 'amountMsat'},
    {'1': 'route_parameters', '3': 3, '4': 1, '5': 11, '6': '.types.RouteParametersConfig', '9': 0, '10': 'routeParameters', '17': true},
  ],
  '8': [
    {'1': '_route_parameters'},
  ],
};

/// Descriptor for `Bolt11SendUnderpayingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11SendUnderpayingRequestDescriptor = $convert.base64Decode(
    'ChxCb2x0MTFTZW5kVW5kZXJwYXlpbmdSZXF1ZXN0EhgKB2ludm9pY2UYASABKAlSB2ludm9pY2'
    'USHwoLYW1vdW50X21zYXQYAiABKARSCmFtb3VudE1zYXQSTAoQcm91dGVfcGFyYW1ldGVycxgD'
    'IAEoCzIcLnR5cGVzLlJvdXRlUGFyYW1ldGVyc0NvbmZpZ0gAUg9yb3V0ZVBhcmFtZXRlcnOIAQ'
    'FCEwoRX3JvdXRlX3BhcmFtZXRlcnM=');

@$core.Deprecated('Use bolt11SendUnderpayingResponseDescriptor instead')
const Bolt11SendUnderpayingResponse$json = {
  '1': 'Bolt11SendUnderpayingResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `Bolt11SendUnderpayingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt11SendUnderpayingResponseDescriptor = $convert.base64Decode(
    'Ch1Cb2x0MTFTZW5kVW5kZXJwYXlpbmdSZXNwb25zZRIdCgpwYXltZW50X2lkGAEgASgJUglwYX'
    'ltZW50SWQ=');

@$core.Deprecated('Use bolt12ReceiveRequestDescriptor instead')
const Bolt12ReceiveRequest$json = {
  '1': 'Bolt12ReceiveRequest',
  '2': [
    {'1': 'description', '3': 1, '4': 1, '5': 9, '10': 'description'},
    {'1': 'amount_msat', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'expiry_secs', '3': 3, '4': 1, '5': 13, '9': 1, '10': 'expirySecs', '17': true},
    {'1': 'quantity', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'quantity', '17': true},
  ],
  '8': [
    {'1': '_amount_msat'},
    {'1': '_expiry_secs'},
    {'1': '_quantity'},
  ],
};

/// Descriptor for `Bolt12ReceiveRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12ReceiveRequestDescriptor = $convert.base64Decode(
    'ChRCb2x0MTJSZWNlaXZlUmVxdWVzdBIgCgtkZXNjcmlwdGlvbhgBIAEoCVILZGVzY3JpcHRpb2'
    '4SJAoLYW1vdW50X21zYXQYAiABKARIAFIKYW1vdW50TXNhdIgBARIkCgtleHBpcnlfc2VjcxgD'
    'IAEoDUgBUgpleHBpcnlTZWNziAEBEh8KCHF1YW50aXR5GAQgASgESAJSCHF1YW50aXR5iAEBQg'
    '4KDF9hbW91bnRfbXNhdEIOCgxfZXhwaXJ5X3NlY3NCCwoJX3F1YW50aXR5');

@$core.Deprecated('Use bolt12ReceiveResponseDescriptor instead')
const Bolt12ReceiveResponse$json = {
  '1': 'Bolt12ReceiveResponse',
  '2': [
    {'1': 'offer', '3': 1, '4': 1, '5': 9, '10': 'offer'},
    {'1': 'offer_id', '3': 2, '4': 1, '5': 9, '10': 'offerId'},
  ],
};

/// Descriptor for `Bolt12ReceiveResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12ReceiveResponseDescriptor = $convert.base64Decode(
    'ChVCb2x0MTJSZWNlaXZlUmVzcG9uc2USFAoFb2ZmZXIYASABKAlSBW9mZmVyEhkKCG9mZmVyX2'
    'lkGAIgASgJUgdvZmZlcklk');

@$core.Deprecated('Use bolt12SendRequestDescriptor instead')
const Bolt12SendRequest$json = {
  '1': 'Bolt12SendRequest',
  '2': [
    {'1': 'offer', '3': 1, '4': 1, '5': 9, '10': 'offer'},
    {'1': 'amount_msat', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'quantity', '3': 3, '4': 1, '5': 4, '9': 1, '10': 'quantity', '17': true},
    {'1': 'payer_note', '3': 4, '4': 1, '5': 9, '9': 2, '10': 'payerNote', '17': true},
    {'1': 'route_parameters', '3': 5, '4': 1, '5': 11, '6': '.types.RouteParametersConfig', '9': 3, '10': 'routeParameters', '17': true},
  ],
  '8': [
    {'1': '_amount_msat'},
    {'1': '_quantity'},
    {'1': '_payer_note'},
    {'1': '_route_parameters'},
  ],
};

/// Descriptor for `Bolt12SendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12SendRequestDescriptor = $convert.base64Decode(
    'ChFCb2x0MTJTZW5kUmVxdWVzdBIUCgVvZmZlchgBIAEoCVIFb2ZmZXISJAoLYW1vdW50X21zYX'
    'QYAiABKARIAFIKYW1vdW50TXNhdIgBARIfCghxdWFudGl0eRgDIAEoBEgBUghxdWFudGl0eYgB'
    'ARIiCgpwYXllcl9ub3RlGAQgASgJSAJSCXBheWVyTm90ZYgBARJMChByb3V0ZV9wYXJhbWV0ZX'
    'JzGAUgASgLMhwudHlwZXMuUm91dGVQYXJhbWV0ZXJzQ29uZmlnSANSD3JvdXRlUGFyYW1ldGVy'
    'c4gBAUIOCgxfYW1vdW50X21zYXRCCwoJX3F1YW50aXR5Qg0KC19wYXllcl9ub3RlQhMKEV9yb3'
    'V0ZV9wYXJhbWV0ZXJz');

@$core.Deprecated('Use bolt12SendResponseDescriptor instead')
const Bolt12SendResponse$json = {
  '1': 'Bolt12SendResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `Bolt12SendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12SendResponseDescriptor = $convert.base64Decode(
    'ChJCb2x0MTJTZW5kUmVzcG9uc2USHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudElk');

@$core.Deprecated('Use bolt12SendRefundRequestDescriptor instead')
const Bolt12SendRefundRequest$json = {
  '1': 'Bolt12SendRefundRequest',
  '2': [
    {'1': 'amount_msat', '3': 1, '4': 1, '5': 4, '10': 'amountMsat'},
    {'1': 'expiry_secs', '3': 2, '4': 1, '5': 13, '10': 'expirySecs'},
    {'1': 'quantity', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'quantity', '17': true},
    {'1': 'payer_note', '3': 4, '4': 1, '5': 9, '9': 1, '10': 'payerNote', '17': true},
    {'1': 'route_parameters', '3': 5, '4': 1, '5': 11, '6': '.types.RouteParametersConfig', '9': 2, '10': 'routeParameters', '17': true},
  ],
  '8': [
    {'1': '_quantity'},
    {'1': '_payer_note'},
    {'1': '_route_parameters'},
  ],
};

/// Descriptor for `Bolt12SendRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12SendRefundRequestDescriptor = $convert.base64Decode(
    'ChdCb2x0MTJTZW5kUmVmdW5kUmVxdWVzdBIfCgthbW91bnRfbXNhdBgBIAEoBFIKYW1vdW50TX'
    'NhdBIfCgtleHBpcnlfc2VjcxgCIAEoDVIKZXhwaXJ5U2VjcxIfCghxdWFudGl0eRgDIAEoBEgA'
    'UghxdWFudGl0eYgBARIiCgpwYXllcl9ub3RlGAQgASgJSAFSCXBheWVyTm90ZYgBARJMChByb3'
    'V0ZV9wYXJhbWV0ZXJzGAUgASgLMhwudHlwZXMuUm91dGVQYXJhbWV0ZXJzQ29uZmlnSAJSD3Jv'
    'dXRlUGFyYW1ldGVyc4gBAUILCglfcXVhbnRpdHlCDQoLX3BheWVyX25vdGVCEwoRX3JvdXRlX3'
    'BhcmFtZXRlcnM=');

@$core.Deprecated('Use bolt12SendRefundResponseDescriptor instead')
const Bolt12SendRefundResponse$json = {
  '1': 'Bolt12SendRefundResponse',
  '2': [
    {'1': 'refund', '3': 1, '4': 1, '5': 9, '10': 'refund'},
  ],
};

/// Descriptor for `Bolt12SendRefundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12SendRefundResponseDescriptor = $convert.base64Decode(
    'ChhCb2x0MTJTZW5kUmVmdW5kUmVzcG9uc2USFgoGcmVmdW5kGAEgASgJUgZyZWZ1bmQ=');

@$core.Deprecated('Use bolt12ReceiveRefundRequestDescriptor instead')
const Bolt12ReceiveRefundRequest$json = {
  '1': 'Bolt12ReceiveRefundRequest',
  '2': [
    {'1': 'refund', '3': 1, '4': 1, '5': 9, '10': 'refund'},
  ],
};

/// Descriptor for `Bolt12ReceiveRefundRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12ReceiveRefundRequestDescriptor = $convert.base64Decode(
    'ChpCb2x0MTJSZWNlaXZlUmVmdW5kUmVxdWVzdBIWCgZyZWZ1bmQYASABKAlSBnJlZnVuZA==');

@$core.Deprecated('Use bolt12ReceiveRefundResponseDescriptor instead')
const Bolt12ReceiveRefundResponse$json = {
  '1': 'Bolt12ReceiveRefundResponse',
  '2': [
    {'1': 'payment_hash', '3': 1, '4': 1, '5': 9, '10': 'paymentHash'},
  ],
};

/// Descriptor for `Bolt12ReceiveRefundResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12ReceiveRefundResponseDescriptor = $convert.base64Decode(
    'ChtCb2x0MTJSZWNlaXZlUmVmdW5kUmVzcG9uc2USIQoMcGF5bWVudF9oYXNoGAEgASgJUgtwYX'
    'ltZW50SGFzaA==');

@$core.Deprecated('Use bolt12CreatePayerProofRequestDescriptor instead')
const Bolt12CreatePayerProofRequest$json = {
  '1': 'Bolt12CreatePayerProofRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
    {'1': 'payment_preimage', '3': 2, '4': 1, '5': 9, '10': 'paymentPreimage'},
    {'1': 'invoice', '3': 3, '4': 1, '5': 9, '10': 'invoice'},
    {'1': 'options', '3': 4, '4': 1, '5': 11, '6': '.types.PayerProofOptions', '9': 0, '10': 'options', '17': true},
  ],
  '8': [
    {'1': '_options'},
  ],
};

/// Descriptor for `Bolt12CreatePayerProofRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12CreatePayerProofRequestDescriptor = $convert.base64Decode(
    'Ch1Cb2x0MTJDcmVhdGVQYXllclByb29mUmVxdWVzdBIdCgpwYXltZW50X2lkGAEgASgJUglwYX'
    'ltZW50SWQSKQoQcGF5bWVudF9wcmVpbWFnZRgCIAEoCVIPcGF5bWVudFByZWltYWdlEhgKB2lu'
    'dm9pY2UYAyABKAlSB2ludm9pY2USNwoHb3B0aW9ucxgEIAEoCzIYLnR5cGVzLlBheWVyUHJvb2'
    'ZPcHRpb25zSABSB29wdGlvbnOIAQFCCgoIX29wdGlvbnM=');

@$core.Deprecated('Use bolt12CreatePayerProofResponseDescriptor instead')
const Bolt12CreatePayerProofResponse$json = {
  '1': 'Bolt12CreatePayerProofResponse',
  '2': [
    {'1': 'payer_proof', '3': 1, '4': 1, '5': 9, '10': 'payerProof'},
  ],
};

/// Descriptor for `Bolt12CreatePayerProofResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bolt12CreatePayerProofResponseDescriptor = $convert.base64Decode(
    'Ch5Cb2x0MTJDcmVhdGVQYXllclByb29mUmVzcG9uc2USHwoLcGF5ZXJfcHJvb2YYASABKAlSCn'
    'BheWVyUHJvb2Y=');

@$core.Deprecated('Use spontaneousSendRequestDescriptor instead')
const SpontaneousSendRequest$json = {
  '1': 'SpontaneousSendRequest',
  '2': [
    {'1': 'amount_msat', '3': 1, '4': 1, '5': 4, '10': 'amountMsat'},
    {'1': 'node_id', '3': 2, '4': 1, '5': 9, '10': 'nodeId'},
    {'1': 'route_parameters', '3': 3, '4': 1, '5': 11, '6': '.types.RouteParametersConfig', '9': 0, '10': 'routeParameters', '17': true},
    {'1': 'custom_tlvs', '3': 4, '4': 3, '5': 11, '6': '.types.CustomTlvRecord', '10': 'customTlvs'},
    {'1': 'preimage', '3': 5, '4': 1, '5': 9, '9': 1, '10': 'preimage', '17': true},
  ],
  '8': [
    {'1': '_route_parameters'},
    {'1': '_preimage'},
  ],
};

/// Descriptor for `SpontaneousSendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spontaneousSendRequestDescriptor = $convert.base64Decode(
    'ChZTcG9udGFuZW91c1NlbmRSZXF1ZXN0Eh8KC2Ftb3VudF9tc2F0GAEgASgEUgphbW91bnRNc2'
    'F0EhcKB25vZGVfaWQYAiABKAlSBm5vZGVJZBJMChByb3V0ZV9wYXJhbWV0ZXJzGAMgASgLMhwu'
    'dHlwZXMuUm91dGVQYXJhbWV0ZXJzQ29uZmlnSABSD3JvdXRlUGFyYW1ldGVyc4gBARI3CgtjdX'
    'N0b21fdGx2cxgEIAMoCzIWLnR5cGVzLkN1c3RvbVRsdlJlY29yZFIKY3VzdG9tVGx2cxIfCghw'
    'cmVpbWFnZRgFIAEoCUgBUghwcmVpbWFnZYgBAUITChFfcm91dGVfcGFyYW1ldGVyc0ILCglfcH'
    'JlaW1hZ2U=');

@$core.Deprecated('Use spontaneousSendResponseDescriptor instead')
const SpontaneousSendResponse$json = {
  '1': 'SpontaneousSendResponse',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `SpontaneousSendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spontaneousSendResponseDescriptor = $convert.base64Decode(
    'ChdTcG9udGFuZW91c1NlbmRSZXNwb25zZRIdCgpwYXltZW50X2lkGAEgASgJUglwYXltZW50SW'
    'Q=');

@$core.Deprecated('Use allFundsDescriptor instead')
const AllFunds$json = {
  '1': 'AllFunds',
};

/// Descriptor for `AllFunds`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allFundsDescriptor = $convert.base64Decode(
    'CghBbGxGdW5kcw==');

@$core.Deprecated('Use openChannelRequestDescriptor instead')
const OpenChannelRequest$json = {
  '1': 'OpenChannelRequest',
  '2': [
    {'1': 'node_pubkey', '3': 1, '4': 1, '5': 9, '10': 'nodePubkey'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'channel_amount_sats', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'channelAmountSats'},
    {'1': 'all_funds', '3': 8, '4': 1, '5': 11, '6': '.api.AllFunds', '9': 0, '10': 'allFunds'},
    {'1': 'push_to_counterparty_msat', '3': 4, '4': 1, '5': 4, '9': 1, '10': 'pushToCounterpartyMsat', '17': true},
    {'1': 'channel_config', '3': 5, '4': 1, '5': 11, '6': '.types.ChannelConfig', '9': 2, '10': 'channelConfig', '17': true},
    {'1': 'announce_channel', '3': 6, '4': 1, '5': 8, '10': 'announceChannel'},
    {'1': 'disable_counterparty_reserve', '3': 7, '4': 1, '5': 8, '10': 'disableCounterpartyReserve'},
  ],
  '8': [
    {'1': 'amount'},
    {'1': '_push_to_counterparty_msat'},
    {'1': '_channel_config'},
  ],
};

/// Descriptor for `OpenChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openChannelRequestDescriptor = $convert.base64Decode(
    'ChJPcGVuQ2hhbm5lbFJlcXVlc3QSHwoLbm9kZV9wdWJrZXkYASABKAlSCm5vZGVQdWJrZXkSGA'
    'oHYWRkcmVzcxgCIAEoCVIHYWRkcmVzcxIwChNjaGFubmVsX2Ftb3VudF9zYXRzGAMgASgESABS'
    'EWNoYW5uZWxBbW91bnRTYXRzEiwKCWFsbF9mdW5kcxgIIAEoCzINLmFwaS5BbGxGdW5kc0gAUg'
    'hhbGxGdW5kcxI+ChlwdXNoX3RvX2NvdW50ZXJwYXJ0eV9tc2F0GAQgASgESAFSFnB1c2hUb0Nv'
    'dW50ZXJwYXJ0eU1zYXSIAQESQAoOY2hhbm5lbF9jb25maWcYBSABKAsyFC50eXBlcy5DaGFubm'
    'VsQ29uZmlnSAJSDWNoYW5uZWxDb25maWeIAQESKQoQYW5ub3VuY2VfY2hhbm5lbBgGIAEoCFIP'
    'YW5ub3VuY2VDaGFubmVsEkAKHGRpc2FibGVfY291bnRlcnBhcnR5X3Jlc2VydmUYByABKAhSGm'
    'Rpc2FibGVDb3VudGVycGFydHlSZXNlcnZlQggKBmFtb3VudEIcChpfcHVzaF90b19jb3VudGVy'
    'cGFydHlfbXNhdEIRCg9fY2hhbm5lbF9jb25maWc=');

@$core.Deprecated('Use openChannelResponseDescriptor instead')
const OpenChannelResponse$json = {
  '1': 'OpenChannelResponse',
  '2': [
    {'1': 'user_channel_id', '3': 1, '4': 1, '5': 9, '10': 'userChannelId'},
  ],
};

/// Descriptor for `OpenChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openChannelResponseDescriptor = $convert.base64Decode(
    'ChNPcGVuQ2hhbm5lbFJlc3BvbnNlEiYKD3VzZXJfY2hhbm5lbF9pZBgBIAEoCVINdXNlckNoYW'
    '5uZWxJZA==');

@$core.Deprecated('Use spliceInRequestDescriptor instead')
const SpliceInRequest$json = {
  '1': 'SpliceInRequest',
  '2': [
    {'1': 'user_channel_id', '3': 1, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'splice_amount_sats', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'spliceAmountSats'},
    {'1': 'all_funds', '3': 4, '4': 1, '5': 11, '6': '.api.AllFunds', '9': 0, '10': 'allFunds'},
  ],
  '8': [
    {'1': 'amount'},
  ],
};

/// Descriptor for `SpliceInRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spliceInRequestDescriptor = $convert.base64Decode(
    'Cg9TcGxpY2VJblJlcXVlc3QSJgoPdXNlcl9jaGFubmVsX2lkGAEgASgJUg11c2VyQ2hhbm5lbE'
    'lkEjAKFGNvdW50ZXJwYXJ0eV9ub2RlX2lkGAIgASgJUhJjb3VudGVycGFydHlOb2RlSWQSLgoS'
    'c3BsaWNlX2Ftb3VudF9zYXRzGAMgASgESABSEHNwbGljZUFtb3VudFNhdHMSLAoJYWxsX2Z1bm'
    'RzGAQgASgLMg0uYXBpLkFsbEZ1bmRzSABSCGFsbEZ1bmRzQggKBmFtb3VudA==');

@$core.Deprecated('Use spliceInResponseDescriptor instead')
const SpliceInResponse$json = {
  '1': 'SpliceInResponse',
};

/// Descriptor for `SpliceInResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spliceInResponseDescriptor = $convert.base64Decode(
    'ChBTcGxpY2VJblJlc3BvbnNl');

@$core.Deprecated('Use spliceOutRequestDescriptor instead')
const SpliceOutRequest$json = {
  '1': 'SpliceOutRequest',
  '2': [
    {'1': 'user_channel_id', '3': 1, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'address', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'address', '17': true},
    {'1': 'splice_amount_sats', '3': 4, '4': 1, '5': 4, '10': 'spliceAmountSats'},
  ],
  '8': [
    {'1': '_address'},
  ],
};

/// Descriptor for `SpliceOutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spliceOutRequestDescriptor = $convert.base64Decode(
    'ChBTcGxpY2VPdXRSZXF1ZXN0EiYKD3VzZXJfY2hhbm5lbF9pZBgBIAEoCVINdXNlckNoYW5uZW'
    'xJZBIwChRjb3VudGVycGFydHlfbm9kZV9pZBgCIAEoCVISY291bnRlcnBhcnR5Tm9kZUlkEh0K'
    'B2FkZHJlc3MYAyABKAlIAFIHYWRkcmVzc4gBARIsChJzcGxpY2VfYW1vdW50X3NhdHMYBCABKA'
    'RSEHNwbGljZUFtb3VudFNhdHNCCgoIX2FkZHJlc3M=');

@$core.Deprecated('Use spliceOutResponseDescriptor instead')
const SpliceOutResponse$json = {
  '1': 'SpliceOutResponse',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `SpliceOutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List spliceOutResponseDescriptor = $convert.base64Decode(
    'ChFTcGxpY2VPdXRSZXNwb25zZRIYCgdhZGRyZXNzGAEgASgJUgdhZGRyZXNz');

@$core.Deprecated('Use updateChannelConfigRequestDescriptor instead')
const UpdateChannelConfigRequest$json = {
  '1': 'UpdateChannelConfigRequest',
  '2': [
    {'1': 'user_channel_id', '3': 1, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'channel_config', '3': 3, '4': 1, '5': 11, '6': '.types.ChannelConfig', '10': 'channelConfig'},
  ],
};

/// Descriptor for `UpdateChannelConfigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChannelConfigRequestDescriptor = $convert.base64Decode(
    'ChpVcGRhdGVDaGFubmVsQ29uZmlnUmVxdWVzdBImCg91c2VyX2NoYW5uZWxfaWQYASABKAlSDX'
    'VzZXJDaGFubmVsSWQSMAoUY291bnRlcnBhcnR5X25vZGVfaWQYAiABKAlSEmNvdW50ZXJwYXJ0'
    'eU5vZGVJZBI7Cg5jaGFubmVsX2NvbmZpZxgDIAEoCzIULnR5cGVzLkNoYW5uZWxDb25maWdSDW'
    'NoYW5uZWxDb25maWc=');

@$core.Deprecated('Use updateChannelConfigResponseDescriptor instead')
const UpdateChannelConfigResponse$json = {
  '1': 'UpdateChannelConfigResponse',
};

/// Descriptor for `UpdateChannelConfigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChannelConfigResponseDescriptor = $convert.base64Decode(
    'ChtVcGRhdGVDaGFubmVsQ29uZmlnUmVzcG9uc2U=');

@$core.Deprecated('Use closeChannelRequestDescriptor instead')
const CloseChannelRequest$json = {
  '1': 'CloseChannelRequest',
  '2': [
    {'1': 'user_channel_id', '3': 1, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
  ],
};

/// Descriptor for `CloseChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeChannelRequestDescriptor = $convert.base64Decode(
    'ChNDbG9zZUNoYW5uZWxSZXF1ZXN0EiYKD3VzZXJfY2hhbm5lbF9pZBgBIAEoCVINdXNlckNoYW'
    '5uZWxJZBIwChRjb3VudGVycGFydHlfbm9kZV9pZBgCIAEoCVISY291bnRlcnBhcnR5Tm9kZUlk');

@$core.Deprecated('Use closeChannelResponseDescriptor instead')
const CloseChannelResponse$json = {
  '1': 'CloseChannelResponse',
};

/// Descriptor for `CloseChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List closeChannelResponseDescriptor = $convert.base64Decode(
    'ChRDbG9zZUNoYW5uZWxSZXNwb25zZQ==');

@$core.Deprecated('Use forceCloseChannelRequestDescriptor instead')
const ForceCloseChannelRequest$json = {
  '1': 'ForceCloseChannelRequest',
  '2': [
    {'1': 'user_channel_id', '3': 1, '4': 1, '5': 9, '10': 'userChannelId'},
    {'1': 'counterparty_node_id', '3': 2, '4': 1, '5': 9, '10': 'counterpartyNodeId'},
    {'1': 'force_close_reason', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'forceCloseReason', '17': true},
  ],
  '8': [
    {'1': '_force_close_reason'},
  ],
};

/// Descriptor for `ForceCloseChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forceCloseChannelRequestDescriptor = $convert.base64Decode(
    'ChhGb3JjZUNsb3NlQ2hhbm5lbFJlcXVlc3QSJgoPdXNlcl9jaGFubmVsX2lkGAEgASgJUg11c2'
    'VyQ2hhbm5lbElkEjAKFGNvdW50ZXJwYXJ0eV9ub2RlX2lkGAIgASgJUhJjb3VudGVycGFydHlO'
    'b2RlSWQSMQoSZm9yY2VfY2xvc2VfcmVhc29uGAMgASgJSABSEGZvcmNlQ2xvc2VSZWFzb26IAQ'
    'FCFQoTX2ZvcmNlX2Nsb3NlX3JlYXNvbg==');

@$core.Deprecated('Use forceCloseChannelResponseDescriptor instead')
const ForceCloseChannelResponse$json = {
  '1': 'ForceCloseChannelResponse',
};

/// Descriptor for `ForceCloseChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forceCloseChannelResponseDescriptor = $convert.base64Decode(
    'ChlGb3JjZUNsb3NlQ2hhbm5lbFJlc3BvbnNl');

@$core.Deprecated('Use listChannelsRequestDescriptor instead')
const ListChannelsRequest$json = {
  '1': 'ListChannelsRequest',
};

/// Descriptor for `ListChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChannelsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0Q2hhbm5lbHNSZXF1ZXN0');

@$core.Deprecated('Use listChannelsResponseDescriptor instead')
const ListChannelsResponse$json = {
  '1': 'ListChannelsResponse',
  '2': [
    {'1': 'channels', '3': 1, '4': 3, '5': 11, '6': '.types.Channel', '10': 'channels'},
  ],
};

/// Descriptor for `ListChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listChannelsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0Q2hhbm5lbHNSZXNwb25zZRIqCghjaGFubmVscxgBIAMoCzIOLnR5cGVzLkNoYW5uZW'
    'xSCGNoYW5uZWxz');

@$core.Deprecated('Use getPaymentDetailsRequestDescriptor instead')
const GetPaymentDetailsRequest$json = {
  '1': 'GetPaymentDetailsRequest',
  '2': [
    {'1': 'payment_id', '3': 1, '4': 1, '5': 9, '10': 'paymentId'},
  ],
};

/// Descriptor for `GetPaymentDetailsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentDetailsRequestDescriptor = $convert.base64Decode(
    'ChhHZXRQYXltZW50RGV0YWlsc1JlcXVlc3QSHQoKcGF5bWVudF9pZBgBIAEoCVIJcGF5bWVudE'
    'lk');

@$core.Deprecated('Use getPaymentDetailsResponseDescriptor instead')
const GetPaymentDetailsResponse$json = {
  '1': 'GetPaymentDetailsResponse',
  '2': [
    {'1': 'payment', '3': 1, '4': 1, '5': 11, '6': '.types.Payment', '10': 'payment'},
  ],
};

/// Descriptor for `GetPaymentDetailsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPaymentDetailsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRQYXltZW50RGV0YWlsc1Jlc3BvbnNlEigKB3BheW1lbnQYASABKAsyDi50eXBlcy5QYX'
    'ltZW50UgdwYXltZW50');

@$core.Deprecated('Use listPaymentsRequestDescriptor instead')
const ListPaymentsRequest$json = {
  '1': 'ListPaymentsRequest',
  '2': [
    {'1': 'page_token', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'pageToken', '17': true},
  ],
  '8': [
    {'1': '_page_token'},
  ],
};

/// Descriptor for `ListPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaymentsRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0UGF5bWVudHNSZXF1ZXN0EiIKCnBhZ2VfdG9rZW4YASABKAlIAFIJcGFnZVRva2VuiA'
    'EBQg0KC19wYWdlX3Rva2Vu');

@$core.Deprecated('Use listPaymentsResponseDescriptor instead')
const ListPaymentsResponse$json = {
  '1': 'ListPaymentsResponse',
  '2': [
    {'1': 'payments', '3': 1, '4': 3, '5': 11, '6': '.types.Payment', '10': 'payments'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'nextPageToken', '17': true},
  ],
  '8': [
    {'1': '_next_page_token'},
  ],
};

/// Descriptor for `ListPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPaymentsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0UGF5bWVudHNSZXNwb25zZRIqCghwYXltZW50cxgBIAMoCzIOLnR5cGVzLlBheW1lbn'
    'RSCHBheW1lbnRzEisKD25leHRfcGFnZV90b2tlbhgCIAEoCUgAUg1uZXh0UGFnZVRva2VuiAEB'
    'QhIKEF9uZXh0X3BhZ2VfdG9rZW4=');

@$core.Deprecated('Use listForwardedPaymentsRequestDescriptor instead')
const ListForwardedPaymentsRequest$json = {
  '1': 'ListForwardedPaymentsRequest',
  '2': [
    {'1': 'page_token', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'pageToken', '17': true},
  ],
  '8': [
    {'1': '_page_token'},
  ],
};

/// Descriptor for `ListForwardedPaymentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listForwardedPaymentsRequestDescriptor = $convert.base64Decode(
    'ChxMaXN0Rm9yd2FyZGVkUGF5bWVudHNSZXF1ZXN0EiIKCnBhZ2VfdG9rZW4YASABKAlIAFIJcG'
    'FnZVRva2VuiAEBQg0KC19wYWdlX3Rva2Vu');

@$core.Deprecated('Use listForwardedPaymentsResponseDescriptor instead')
const ListForwardedPaymentsResponse$json = {
  '1': 'ListForwardedPaymentsResponse',
  '2': [
    {'1': 'forwarded_payments', '3': 1, '4': 3, '5': 11, '6': '.types.ForwardedPayment', '10': 'forwardedPayments'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'nextPageToken', '17': true},
  ],
  '8': [
    {'1': '_next_page_token'},
  ],
};

/// Descriptor for `ListForwardedPaymentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listForwardedPaymentsResponseDescriptor = $convert.base64Decode(
    'Ch1MaXN0Rm9yd2FyZGVkUGF5bWVudHNSZXNwb25zZRJGChJmb3J3YXJkZWRfcGF5bWVudHMYAS'
    'ADKAsyFy50eXBlcy5Gb3J3YXJkZWRQYXltZW50UhFmb3J3YXJkZWRQYXltZW50cxIrCg9uZXh0'
    'X3BhZ2VfdG9rZW4YAiABKAlIAFINbmV4dFBhZ2VUb2tlbogBAUISChBfbmV4dF9wYWdlX3Rva2'
    'Vu');

@$core.Deprecated('Use signMessageRequestDescriptor instead')
const SignMessageRequest$json = {
  '1': 'SignMessageRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 12, '10': 'message'},
  ],
};

/// Descriptor for `SignMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signMessageRequestDescriptor = $convert.base64Decode(
    'ChJTaWduTWVzc2FnZVJlcXVlc3QSGAoHbWVzc2FnZRgBIAEoDFIHbWVzc2FnZQ==');

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

@$core.Deprecated('Use verifySignatureRequestDescriptor instead')
const VerifySignatureRequest$json = {
  '1': 'VerifySignatureRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 12, '10': 'message'},
    {'1': 'signature', '3': 2, '4': 1, '5': 9, '10': 'signature'},
    {'1': 'public_key', '3': 3, '4': 1, '5': 9, '10': 'publicKey'},
  ],
};

/// Descriptor for `VerifySignatureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySignatureRequestDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlTaWduYXR1cmVSZXF1ZXN0EhgKB21lc3NhZ2UYASABKAxSB21lc3NhZ2USHAoJc2'
    'lnbmF0dXJlGAIgASgJUglzaWduYXR1cmUSHQoKcHVibGljX2tleRgDIAEoCVIJcHVibGljS2V5');

@$core.Deprecated('Use verifySignatureResponseDescriptor instead')
const VerifySignatureResponse$json = {
  '1': 'VerifySignatureResponse',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
  ],
};

/// Descriptor for `VerifySignatureResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySignatureResponseDescriptor = $convert.base64Decode(
    'ChdWZXJpZnlTaWduYXR1cmVSZXNwb25zZRIUCgV2YWxpZBgBIAEoCFIFdmFsaWQ=');

@$core.Deprecated('Use exportPathfindingScoresRequestDescriptor instead')
const ExportPathfindingScoresRequest$json = {
  '1': 'ExportPathfindingScoresRequest',
};

/// Descriptor for `ExportPathfindingScoresRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportPathfindingScoresRequestDescriptor = $convert.base64Decode(
    'Ch5FeHBvcnRQYXRoZmluZGluZ1Njb3Jlc1JlcXVlc3Q=');

@$core.Deprecated('Use exportPathfindingScoresResponseDescriptor instead')
const ExportPathfindingScoresResponse$json = {
  '1': 'ExportPathfindingScoresResponse',
  '2': [
    {'1': 'scores', '3': 1, '4': 1, '5': 12, '10': 'scores'},
  ],
};

/// Descriptor for `ExportPathfindingScoresResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exportPathfindingScoresResponseDescriptor = $convert.base64Decode(
    'Ch9FeHBvcnRQYXRoZmluZGluZ1Njb3Jlc1Jlc3BvbnNlEhYKBnNjb3JlcxgBIAEoDFIGc2Nvcm'
    'Vz');

@$core.Deprecated('Use getBalancesRequestDescriptor instead')
const GetBalancesRequest$json = {
  '1': 'GetBalancesRequest',
};

/// Descriptor for `GetBalancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalancesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRCYWxhbmNlc1JlcXVlc3Q=');

@$core.Deprecated('Use getBalancesResponseDescriptor instead')
const GetBalancesResponse$json = {
  '1': 'GetBalancesResponse',
  '2': [
    {'1': 'total_onchain_balance_sats', '3': 1, '4': 1, '5': 4, '10': 'totalOnchainBalanceSats'},
    {'1': 'spendable_onchain_balance_sats', '3': 2, '4': 1, '5': 4, '10': 'spendableOnchainBalanceSats'},
    {'1': 'total_anchor_channels_reserve_sats', '3': 3, '4': 1, '5': 4, '10': 'totalAnchorChannelsReserveSats'},
    {'1': 'total_lightning_balance_sats', '3': 4, '4': 1, '5': 4, '10': 'totalLightningBalanceSats'},
    {'1': 'lightning_balances', '3': 5, '4': 3, '5': 11, '6': '.types.LightningBalance', '10': 'lightningBalances'},
    {'1': 'pending_balances_from_channel_closures', '3': 6, '4': 3, '5': 11, '6': '.types.PendingSweepBalance', '10': 'pendingBalancesFromChannelClosures'},
  ],
};

/// Descriptor for `GetBalancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalancesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRCYWxhbmNlc1Jlc3BvbnNlEjsKGnRvdGFsX29uY2hhaW5fYmFsYW5jZV9zYXRzGAEgAS'
    'gEUhd0b3RhbE9uY2hhaW5CYWxhbmNlU2F0cxJDCh5zcGVuZGFibGVfb25jaGFpbl9iYWxhbmNl'
    'X3NhdHMYAiABKARSG3NwZW5kYWJsZU9uY2hhaW5CYWxhbmNlU2F0cxJKCiJ0b3RhbF9hbmNob3'
    'JfY2hhbm5lbHNfcmVzZXJ2ZV9zYXRzGAMgASgEUh50b3RhbEFuY2hvckNoYW5uZWxzUmVzZXJ2'
    'ZVNhdHMSPwocdG90YWxfbGlnaHRuaW5nX2JhbGFuY2Vfc2F0cxgEIAEoBFIZdG90YWxMaWdodG'
    '5pbmdCYWxhbmNlU2F0cxJGChJsaWdodG5pbmdfYmFsYW5jZXMYBSADKAsyFy50eXBlcy5MaWdo'
    'dG5pbmdCYWxhbmNlUhFsaWdodG5pbmdCYWxhbmNlcxJuCiZwZW5kaW5nX2JhbGFuY2VzX2Zyb2'
    '1fY2hhbm5lbF9jbG9zdXJlcxgGIAMoCzIaLnR5cGVzLlBlbmRpbmdTd2VlcEJhbGFuY2VSInBl'
    'bmRpbmdCYWxhbmNlc0Zyb21DaGFubmVsQ2xvc3VyZXM=');

@$core.Deprecated('Use connectPeerRequestDescriptor instead')
const ConnectPeerRequest$json = {
  '1': 'ConnectPeerRequest',
  '2': [
    {'1': 'node_pubkey', '3': 1, '4': 1, '5': 9, '10': 'nodePubkey'},
    {'1': 'address', '3': 2, '4': 1, '5': 9, '10': 'address'},
    {'1': 'persist', '3': 3, '4': 1, '5': 8, '10': 'persist'},
  ],
};

/// Descriptor for `ConnectPeerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectPeerRequestDescriptor = $convert.base64Decode(
    'ChJDb25uZWN0UGVlclJlcXVlc3QSHwoLbm9kZV9wdWJrZXkYASABKAlSCm5vZGVQdWJrZXkSGA'
    'oHYWRkcmVzcxgCIAEoCVIHYWRkcmVzcxIYCgdwZXJzaXN0GAMgASgIUgdwZXJzaXN0');

@$core.Deprecated('Use connectPeerResponseDescriptor instead')
const ConnectPeerResponse$json = {
  '1': 'ConnectPeerResponse',
};

/// Descriptor for `ConnectPeerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectPeerResponseDescriptor = $convert.base64Decode(
    'ChNDb25uZWN0UGVlclJlc3BvbnNl');

@$core.Deprecated('Use disconnectPeerRequestDescriptor instead')
const DisconnectPeerRequest$json = {
  '1': 'DisconnectPeerRequest',
  '2': [
    {'1': 'node_pubkey', '3': 1, '4': 1, '5': 9, '10': 'nodePubkey'},
  ],
};

/// Descriptor for `DisconnectPeerRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectPeerRequestDescriptor = $convert.base64Decode(
    'ChVEaXNjb25uZWN0UGVlclJlcXVlc3QSHwoLbm9kZV9wdWJrZXkYASABKAlSCm5vZGVQdWJrZX'
    'k=');

@$core.Deprecated('Use disconnectPeerResponseDescriptor instead')
const DisconnectPeerResponse$json = {
  '1': 'DisconnectPeerResponse',
};

/// Descriptor for `DisconnectPeerResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List disconnectPeerResponseDescriptor = $convert.base64Decode(
    'ChZEaXNjb25uZWN0UGVlclJlc3BvbnNl');

@$core.Deprecated('Use listPeersRequestDescriptor instead')
const ListPeersRequest$json = {
  '1': 'ListPeersRequest',
};

/// Descriptor for `ListPeersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPeersRequestDescriptor = $convert.base64Decode(
    'ChBMaXN0UGVlcnNSZXF1ZXN0');

@$core.Deprecated('Use listPeersResponseDescriptor instead')
const ListPeersResponse$json = {
  '1': 'ListPeersResponse',
  '2': [
    {'1': 'peers', '3': 1, '4': 3, '5': 11, '6': '.types.Peer', '10': 'peers'},
  ],
};

/// Descriptor for `ListPeersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPeersResponseDescriptor = $convert.base64Decode(
    'ChFMaXN0UGVlcnNSZXNwb25zZRIhCgVwZWVycxgBIAMoCzILLnR5cGVzLlBlZXJSBXBlZXJz');

@$core.Deprecated('Use graphListChannelsRequestDescriptor instead')
const GraphListChannelsRequest$json = {
  '1': 'GraphListChannelsRequest',
};

/// Descriptor for `GraphListChannelsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphListChannelsRequestDescriptor = $convert.base64Decode(
    'ChhHcmFwaExpc3RDaGFubmVsc1JlcXVlc3Q=');

@$core.Deprecated('Use graphListChannelsResponseDescriptor instead')
const GraphListChannelsResponse$json = {
  '1': 'GraphListChannelsResponse',
  '2': [
    {'1': 'short_channel_ids', '3': 1, '4': 3, '5': 4, '10': 'shortChannelIds'},
  ],
};

/// Descriptor for `GraphListChannelsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphListChannelsResponseDescriptor = $convert.base64Decode(
    'ChlHcmFwaExpc3RDaGFubmVsc1Jlc3BvbnNlEioKEXNob3J0X2NoYW5uZWxfaWRzGAEgAygEUg'
    '9zaG9ydENoYW5uZWxJZHM=');

@$core.Deprecated('Use graphGetChannelRequestDescriptor instead')
const GraphGetChannelRequest$json = {
  '1': 'GraphGetChannelRequest',
  '2': [
    {'1': 'short_channel_id', '3': 1, '4': 1, '5': 4, '10': 'shortChannelId'},
  ],
};

/// Descriptor for `GraphGetChannelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphGetChannelRequestDescriptor = $convert.base64Decode(
    'ChZHcmFwaEdldENoYW5uZWxSZXF1ZXN0EigKEHNob3J0X2NoYW5uZWxfaWQYASABKARSDnNob3'
    'J0Q2hhbm5lbElk');

@$core.Deprecated('Use graphGetChannelResponseDescriptor instead')
const GraphGetChannelResponse$json = {
  '1': 'GraphGetChannelResponse',
  '2': [
    {'1': 'channel', '3': 1, '4': 1, '5': 11, '6': '.types.GraphChannel', '10': 'channel'},
  ],
};

/// Descriptor for `GraphGetChannelResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphGetChannelResponseDescriptor = $convert.base64Decode(
    'ChdHcmFwaEdldENoYW5uZWxSZXNwb25zZRItCgdjaGFubmVsGAEgASgLMhMudHlwZXMuR3JhcG'
    'hDaGFubmVsUgdjaGFubmVs');

@$core.Deprecated('Use graphListNodesRequestDescriptor instead')
const GraphListNodesRequest$json = {
  '1': 'GraphListNodesRequest',
};

/// Descriptor for `GraphListNodesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphListNodesRequestDescriptor = $convert.base64Decode(
    'ChVHcmFwaExpc3ROb2Rlc1JlcXVlc3Q=');

@$core.Deprecated('Use graphListNodesResponseDescriptor instead')
const GraphListNodesResponse$json = {
  '1': 'GraphListNodesResponse',
  '2': [
    {'1': 'node_ids', '3': 1, '4': 3, '5': 9, '10': 'nodeIds'},
  ],
};

/// Descriptor for `GraphListNodesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphListNodesResponseDescriptor = $convert.base64Decode(
    'ChZHcmFwaExpc3ROb2Rlc1Jlc3BvbnNlEhkKCG5vZGVfaWRzGAEgAygJUgdub2RlSWRz');

@$core.Deprecated('Use unifiedSendRequestDescriptor instead')
const UnifiedSendRequest$json = {
  '1': 'UnifiedSendRequest',
  '2': [
    {'1': 'uri', '3': 1, '4': 1, '5': 9, '10': 'uri'},
    {'1': 'amount_msat', '3': 2, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'route_parameters', '3': 3, '4': 1, '5': 11, '6': '.types.RouteParametersConfig', '9': 1, '10': 'routeParameters', '17': true},
  ],
  '8': [
    {'1': '_amount_msat'},
    {'1': '_route_parameters'},
  ],
};

/// Descriptor for `UnifiedSendRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unifiedSendRequestDescriptor = $convert.base64Decode(
    'ChJVbmlmaWVkU2VuZFJlcXVlc3QSEAoDdXJpGAEgASgJUgN1cmkSJAoLYW1vdW50X21zYXQYAi'
    'ABKARIAFIKYW1vdW50TXNhdIgBARJMChByb3V0ZV9wYXJhbWV0ZXJzGAMgASgLMhwudHlwZXMu'
    'Um91dGVQYXJhbWV0ZXJzQ29uZmlnSAFSD3JvdXRlUGFyYW1ldGVyc4gBAUIOCgxfYW1vdW50X2'
    '1zYXRCEwoRX3JvdXRlX3BhcmFtZXRlcnM=');

@$core.Deprecated('Use unifiedSendResponseDescriptor instead')
const UnifiedSendResponse$json = {
  '1': 'UnifiedSendResponse',
  '2': [
    {'1': 'txid', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'txid'},
    {'1': 'bolt11_payment_id', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'bolt11PaymentId'},
    {'1': 'bolt12_payment_id', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'bolt12PaymentId'},
  ],
  '8': [
    {'1': 'payment_result'},
  ],
};

/// Descriptor for `UnifiedSendResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unifiedSendResponseDescriptor = $convert.base64Decode(
    'ChNVbmlmaWVkU2VuZFJlc3BvbnNlEhQKBHR4aWQYASABKAlIAFIEdHhpZBIsChFib2x0MTFfcG'
    'F5bWVudF9pZBgCIAEoCUgAUg9ib2x0MTFQYXltZW50SWQSLAoRYm9sdDEyX3BheW1lbnRfaWQY'
    'AyABKAlIAFIPYm9sdDEyUGF5bWVudElkQhAKDnBheW1lbnRfcmVzdWx0');

@$core.Deprecated('Use graphGetNodeRequestDescriptor instead')
const GraphGetNodeRequest$json = {
  '1': 'GraphGetNodeRequest',
  '2': [
    {'1': 'node_id', '3': 1, '4': 1, '5': 9, '10': 'nodeId'},
  ],
};

/// Descriptor for `GraphGetNodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphGetNodeRequestDescriptor = $convert.base64Decode(
    'ChNHcmFwaEdldE5vZGVSZXF1ZXN0EhcKB25vZGVfaWQYASABKAlSBm5vZGVJZA==');

@$core.Deprecated('Use graphGetNodeResponseDescriptor instead')
const GraphGetNodeResponse$json = {
  '1': 'GraphGetNodeResponse',
  '2': [
    {'1': 'node', '3': 1, '4': 1, '5': 11, '6': '.types.GraphNode', '10': 'node'},
  ],
};

/// Descriptor for `GraphGetNodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List graphGetNodeResponseDescriptor = $convert.base64Decode(
    'ChRHcmFwaEdldE5vZGVSZXNwb25zZRIkCgRub2RlGAEgASgLMhAudHlwZXMuR3JhcGhOb2RlUg'
    'Rub2Rl');

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

@$core.Deprecated('Use decodeInvoiceResponseDescriptor instead')
const DecodeInvoiceResponse$json = {
  '1': 'DecodeInvoiceResponse',
  '2': [
    {'1': 'destination', '3': 1, '4': 1, '5': 9, '10': 'destination'},
    {'1': 'payment_hash', '3': 2, '4': 1, '5': 9, '10': 'paymentHash'},
    {'1': 'amount_msat', '3': 3, '4': 1, '5': 4, '9': 0, '10': 'amountMsat', '17': true},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'expiry', '3': 5, '4': 1, '5': 4, '10': 'expiry'},
    {'1': 'description', '3': 6, '4': 1, '5': 9, '9': 1, '10': 'description', '17': true},
    {'1': 'description_hash', '3': 14, '4': 1, '5': 9, '9': 2, '10': 'descriptionHash', '17': true},
    {'1': 'fallback_address', '3': 7, '4': 1, '5': 9, '9': 3, '10': 'fallbackAddress', '17': true},
    {'1': 'min_final_cltv_expiry_delta', '3': 8, '4': 1, '5': 4, '10': 'minFinalCltvExpiryDelta'},
    {'1': 'payment_secret', '3': 9, '4': 1, '5': 9, '10': 'paymentSecret'},
    {'1': 'route_hints', '3': 10, '4': 3, '5': 11, '6': '.types.Bolt11RouteHint', '10': 'routeHints'},
    {'1': 'features', '3': 11, '4': 3, '5': 11, '6': '.api.DecodeInvoiceResponse.FeaturesEntry', '10': 'features'},
    {'1': 'currency', '3': 12, '4': 1, '5': 9, '10': 'currency'},
    {'1': 'payment_metadata', '3': 13, '4': 1, '5': 9, '9': 4, '10': 'paymentMetadata', '17': true},
    {'1': 'is_expired', '3': 15, '4': 1, '5': 8, '10': 'isExpired'},
  ],
  '3': [DecodeInvoiceResponse_FeaturesEntry$json],
  '8': [
    {'1': '_amount_msat'},
    {'1': '_description'},
    {'1': '_description_hash'},
    {'1': '_fallback_address'},
    {'1': '_payment_metadata'},
  ],
};

@$core.Deprecated('Use decodeInvoiceResponseDescriptor instead')
const DecodeInvoiceResponse_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.types.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DecodeInvoiceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeInvoiceResponseDescriptor = $convert.base64Decode(
    'ChVEZWNvZGVJbnZvaWNlUmVzcG9uc2USIAoLZGVzdGluYXRpb24YASABKAlSC2Rlc3RpbmF0aW'
    '9uEiEKDHBheW1lbnRfaGFzaBgCIAEoCVILcGF5bWVudEhhc2gSJAoLYW1vdW50X21zYXQYAyAB'
    'KARIAFIKYW1vdW50TXNhdIgBARIcCgl0aW1lc3RhbXAYBCABKARSCXRpbWVzdGFtcBIWCgZleH'
    'BpcnkYBSABKARSBmV4cGlyeRIlCgtkZXNjcmlwdGlvbhgGIAEoCUgBUgtkZXNjcmlwdGlvbogB'
    'ARIuChBkZXNjcmlwdGlvbl9oYXNoGA4gASgJSAJSD2Rlc2NyaXB0aW9uSGFzaIgBARIuChBmYW'
    'xsYmFja19hZGRyZXNzGAcgASgJSANSD2ZhbGxiYWNrQWRkcmVzc4gBARI8ChttaW5fZmluYWxf'
    'Y2x0dl9leHBpcnlfZGVsdGEYCCABKARSF21pbkZpbmFsQ2x0dkV4cGlyeURlbHRhEiUKDnBheW'
    '1lbnRfc2VjcmV0GAkgASgJUg1wYXltZW50U2VjcmV0EjcKC3JvdXRlX2hpbnRzGAogAygLMhYu'
    'dHlwZXMuQm9sdDExUm91dGVIaW50Ugpyb3V0ZUhpbnRzEkQKCGZlYXR1cmVzGAsgAygLMiguYX'
    'BpLkRlY29kZUludm9pY2VSZXNwb25zZS5GZWF0dXJlc0VudHJ5UghmZWF0dXJlcxIaCghjdXJy'
    'ZW5jeRgMIAEoCVIIY3VycmVuY3kSLgoQcGF5bWVudF9tZXRhZGF0YRgNIAEoCUgEUg9wYXltZW'
    '50TWV0YWRhdGGIAQESHQoKaXNfZXhwaXJlZBgPIAEoCFIJaXNFeHBpcmVkGksKDUZlYXR1cmVz'
    'RW50cnkSEAoDa2V5GAEgASgNUgNrZXkSJAoFdmFsdWUYAiABKAsyDi50eXBlcy5GZWF0dXJlUg'
    'V2YWx1ZToCOAFCDgoMX2Ftb3VudF9tc2F0Qg4KDF9kZXNjcmlwdGlvbkITChFfZGVzY3JpcHRp'
    'b25faGFzaEITChFfZmFsbGJhY2tfYWRkcmVzc0ITChFfcGF5bWVudF9tZXRhZGF0YQ==');

@$core.Deprecated('Use decodeOfferRequestDescriptor instead')
const DecodeOfferRequest$json = {
  '1': 'DecodeOfferRequest',
  '2': [
    {'1': 'offer', '3': 1, '4': 1, '5': 9, '10': 'offer'},
  ],
};

/// Descriptor for `DecodeOfferRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeOfferRequestDescriptor = $convert.base64Decode(
    'ChJEZWNvZGVPZmZlclJlcXVlc3QSFAoFb2ZmZXIYASABKAlSBW9mZmVy');

@$core.Deprecated('Use decodeOfferResponseDescriptor instead')
const DecodeOfferResponse$json = {
  '1': 'DecodeOfferResponse',
  '2': [
    {'1': 'offer_id', '3': 1, '4': 1, '5': 9, '10': 'offerId'},
    {'1': 'description', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'description', '17': true},
    {'1': 'issuer', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'issuer', '17': true},
    {'1': 'amount', '3': 4, '4': 1, '5': 11, '6': '.types.OfferAmount', '10': 'amount'},
    {'1': 'issuer_signing_pubkey', '3': 5, '4': 1, '5': 9, '9': 2, '10': 'issuerSigningPubkey', '17': true},
    {'1': 'absolute_expiry', '3': 6, '4': 1, '5': 4, '9': 3, '10': 'absoluteExpiry', '17': true},
    {'1': 'quantity', '3': 7, '4': 1, '5': 11, '6': '.types.OfferQuantity', '10': 'quantity'},
    {'1': 'paths', '3': 8, '4': 3, '5': 11, '6': '.types.BlindedPath', '10': 'paths'},
    {'1': 'features', '3': 9, '4': 3, '5': 11, '6': '.api.DecodeOfferResponse.FeaturesEntry', '10': 'features'},
    {'1': 'chains', '3': 10, '4': 3, '5': 9, '10': 'chains'},
    {'1': 'metadata', '3': 11, '4': 1, '5': 9, '9': 4, '10': 'metadata', '17': true},
    {'1': 'is_expired', '3': 12, '4': 1, '5': 8, '10': 'isExpired'},
  ],
  '3': [DecodeOfferResponse_FeaturesEntry$json],
  '8': [
    {'1': '_description'},
    {'1': '_issuer'},
    {'1': '_issuer_signing_pubkey'},
    {'1': '_absolute_expiry'},
    {'1': '_metadata'},
  ],
};

@$core.Deprecated('Use decodeOfferResponseDescriptor instead')
const DecodeOfferResponse_FeaturesEntry$json = {
  '1': 'FeaturesEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 13, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.types.Feature', '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `DecodeOfferResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List decodeOfferResponseDescriptor = $convert.base64Decode(
    'ChNEZWNvZGVPZmZlclJlc3BvbnNlEhkKCG9mZmVyX2lkGAEgASgJUgdvZmZlcklkEiUKC2Rlc2'
    'NyaXB0aW9uGAIgASgJSABSC2Rlc2NyaXB0aW9uiAEBEhsKBmlzc3VlchgDIAEoCUgBUgZpc3N1'
    'ZXKIAQESKgoGYW1vdW50GAQgASgLMhIudHlwZXMuT2ZmZXJBbW91bnRSBmFtb3VudBI3ChVpc3'
    'N1ZXJfc2lnbmluZ19wdWJrZXkYBSABKAlIAlITaXNzdWVyU2lnbmluZ1B1YmtleYgBARIsCg9h'
    'YnNvbHV0ZV9leHBpcnkYBiABKARIA1IOYWJzb2x1dGVFeHBpcnmIAQESMAoIcXVhbnRpdHkYBy'
    'ABKAsyFC50eXBlcy5PZmZlclF1YW50aXR5UghxdWFudGl0eRIoCgVwYXRocxgIIAMoCzISLnR5'
    'cGVzLkJsaW5kZWRQYXRoUgVwYXRocxJCCghmZWF0dXJlcxgJIAMoCzImLmFwaS5EZWNvZGVPZm'
    'ZlclJlc3BvbnNlLkZlYXR1cmVzRW50cnlSCGZlYXR1cmVzEhYKBmNoYWlucxgKIAMoCVIGY2hh'
    'aW5zEh8KCG1ldGFkYXRhGAsgASgJSARSCG1ldGFkYXRhiAEBEh0KCmlzX2V4cGlyZWQYDCABKA'
    'hSCWlzRXhwaXJlZBpLCg1GZWF0dXJlc0VudHJ5EhAKA2tleRgBIAEoDVIDa2V5EiQKBXZhbHVl'
    'GAIgASgLMg4udHlwZXMuRmVhdHVyZVIFdmFsdWU6AjgBQg4KDF9kZXNjcmlwdGlvbkIJCgdfaX'
    'NzdWVyQhgKFl9pc3N1ZXJfc2lnbmluZ19wdWJrZXlCEgoQX2Fic29sdXRlX2V4cGlyeUILCglf'
    'bWV0YWRhdGE=');

@$core.Deprecated('Use subscribeEventsRequestDescriptor instead')
const SubscribeEventsRequest$json = {
  '1': 'SubscribeEventsRequest',
};

/// Descriptor for `SubscribeEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeEventsRequestDescriptor = $convert.base64Decode(
    'ChZTdWJzY3JpYmVFdmVudHNSZXF1ZXN0');

