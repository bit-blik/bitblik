//
//  Generated code. Do not modify.
//  source: lnd/signer.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use signMethodDescriptor instead')
const SignMethod$json = {
  '1': 'SignMethod',
  '2': [
    {'1': 'SIGN_METHOD_WITNESS_V0', '2': 0},
    {'1': 'SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086', '2': 1},
    {'1': 'SIGN_METHOD_TAPROOT_KEY_SPEND', '2': 2},
    {'1': 'SIGN_METHOD_TAPROOT_SCRIPT_SPEND', '2': 3},
  ],
};

/// Descriptor for `SignMethod`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signMethodDescriptor = $convert.base64Decode(
    'CgpTaWduTWV0aG9kEhoKFlNJR05fTUVUSE9EX1dJVE5FU1NfVjAQABIpCiVTSUdOX01FVEhPRF'
    '9UQVBST09UX0tFWV9TUEVORF9CSVAwMDg2EAESIQodU0lHTl9NRVRIT0RfVEFQUk9PVF9LRVlf'
    'U1BFTkQQAhIkCiBTSUdOX01FVEhPRF9UQVBST09UX1NDUklQVF9TUEVORBAD');

@$core.Deprecated('Use muSig2VersionDescriptor instead')
const MuSig2Version$json = {
  '1': 'MuSig2Version',
  '2': [
    {'1': 'MUSIG2_VERSION_UNDEFINED', '2': 0},
    {'1': 'MUSIG2_VERSION_V040', '2': 1},
    {'1': 'MUSIG2_VERSION_V100RC2', '2': 2},
  ],
};

/// Descriptor for `MuSig2Version`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List muSig2VersionDescriptor = $convert.base64Decode(
    'Cg1NdVNpZzJWZXJzaW9uEhwKGE1VU0lHMl9WRVJTSU9OX1VOREVGSU5FRBAAEhcKE01VU0lHMl'
    '9WRVJTSU9OX1YwNDAQARIaChZNVVNJRzJfVkVSU0lPTl9WMTAwUkMyEAI=');

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
    {'1': 'key_loc', '3': 2, '4': 1, '5': 11, '6': '.signrpc.KeyLocator', '10': 'keyLoc'},
  ],
};

/// Descriptor for `KeyDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyDescriptorDescriptor = $convert.base64Decode(
    'Cg1LZXlEZXNjcmlwdG9yEiIKDXJhd19rZXlfYnl0ZXMYASABKAxSC3Jhd0tleUJ5dGVzEiwKB2'
    'tleV9sb2MYAiABKAsyEy5zaWducnBjLktleUxvY2F0b3JSBmtleUxvYw==');

@$core.Deprecated('Use txOutDescriptor instead')
const TxOut$json = {
  '1': 'TxOut',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 3, '10': 'value'},
    {'1': 'pk_script', '3': 2, '4': 1, '5': 12, '10': 'pkScript'},
  ],
};

/// Descriptor for `TxOut`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List txOutDescriptor = $convert.base64Decode(
    'CgVUeE91dBIUCgV2YWx1ZRgBIAEoA1IFdmFsdWUSGwoJcGtfc2NyaXB0GAIgASgMUghwa1Njcm'
    'lwdA==');

@$core.Deprecated('Use signDescriptorDescriptor instead')
const SignDescriptor$json = {
  '1': 'SignDescriptor',
  '2': [
    {'1': 'key_desc', '3': 1, '4': 1, '5': 11, '6': '.signrpc.KeyDescriptor', '10': 'keyDesc'},
    {'1': 'single_tweak', '3': 2, '4': 1, '5': 12, '10': 'singleTweak'},
    {'1': 'double_tweak', '3': 3, '4': 1, '5': 12, '10': 'doubleTweak'},
    {'1': 'tap_tweak', '3': 10, '4': 1, '5': 12, '10': 'tapTweak'},
    {'1': 'witness_script', '3': 4, '4': 1, '5': 12, '10': 'witnessScript'},
    {'1': 'output', '3': 5, '4': 1, '5': 11, '6': '.signrpc.TxOut', '10': 'output'},
    {'1': 'sighash', '3': 7, '4': 1, '5': 13, '10': 'sighash'},
    {'1': 'input_index', '3': 8, '4': 1, '5': 5, '10': 'inputIndex'},
    {'1': 'sign_method', '3': 9, '4': 1, '5': 14, '6': '.signrpc.SignMethod', '10': 'signMethod'},
  ],
};

/// Descriptor for `SignDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signDescriptorDescriptor = $convert.base64Decode(
    'Cg5TaWduRGVzY3JpcHRvchIxCghrZXlfZGVzYxgBIAEoCzIWLnNpZ25ycGMuS2V5RGVzY3JpcH'
    'RvclIHa2V5RGVzYxIhCgxzaW5nbGVfdHdlYWsYAiABKAxSC3NpbmdsZVR3ZWFrEiEKDGRvdWJs'
    'ZV90d2VhaxgDIAEoDFILZG91YmxlVHdlYWsSGwoJdGFwX3R3ZWFrGAogASgMUgh0YXBUd2Vhax'
    'IlCg53aXRuZXNzX3NjcmlwdBgEIAEoDFINd2l0bmVzc1NjcmlwdBImCgZvdXRwdXQYBSABKAsy'
    'Di5zaWducnBjLlR4T3V0UgZvdXRwdXQSGAoHc2lnaGFzaBgHIAEoDVIHc2lnaGFzaBIfCgtpbn'
    'B1dF9pbmRleBgIIAEoBVIKaW5wdXRJbmRleBI0CgtzaWduX21ldGhvZBgJIAEoDjITLnNpZ25y'
    'cGMuU2lnbk1ldGhvZFIKc2lnbk1ldGhvZA==');

@$core.Deprecated('Use signReqDescriptor instead')
const SignReq$json = {
  '1': 'SignReq',
  '2': [
    {'1': 'raw_tx_bytes', '3': 1, '4': 1, '5': 12, '10': 'rawTxBytes'},
    {'1': 'sign_descs', '3': 2, '4': 3, '5': 11, '6': '.signrpc.SignDescriptor', '10': 'signDescs'},
    {'1': 'prev_outputs', '3': 3, '4': 3, '5': 11, '6': '.signrpc.TxOut', '10': 'prevOutputs'},
  ],
};

/// Descriptor for `SignReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signReqDescriptor = $convert.base64Decode(
    'CgdTaWduUmVxEiAKDHJhd190eF9ieXRlcxgBIAEoDFIKcmF3VHhCeXRlcxI2CgpzaWduX2Rlc2'
    'NzGAIgAygLMhcuc2lnbnJwYy5TaWduRGVzY3JpcHRvclIJc2lnbkRlc2NzEjEKDHByZXZfb3V0'
    'cHV0cxgDIAMoCzIOLnNpZ25ycGMuVHhPdXRSC3ByZXZPdXRwdXRz');

@$core.Deprecated('Use signRespDescriptor instead')
const SignResp$json = {
  '1': 'SignResp',
  '2': [
    {'1': 'raw_sigs', '3': 1, '4': 3, '5': 12, '10': 'rawSigs'},
  ],
};

/// Descriptor for `SignResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signRespDescriptor = $convert.base64Decode(
    'CghTaWduUmVzcBIZCghyYXdfc2lncxgBIAMoDFIHcmF3U2lncw==');

@$core.Deprecated('Use inputScriptDescriptor instead')
const InputScript$json = {
  '1': 'InputScript',
  '2': [
    {'1': 'witness', '3': 1, '4': 3, '5': 12, '10': 'witness'},
    {'1': 'sig_script', '3': 2, '4': 1, '5': 12, '10': 'sigScript'},
  ],
};

/// Descriptor for `InputScript`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputScriptDescriptor = $convert.base64Decode(
    'CgtJbnB1dFNjcmlwdBIYCgd3aXRuZXNzGAEgAygMUgd3aXRuZXNzEh0KCnNpZ19zY3JpcHQYAi'
    'ABKAxSCXNpZ1NjcmlwdA==');

@$core.Deprecated('Use inputScriptRespDescriptor instead')
const InputScriptResp$json = {
  '1': 'InputScriptResp',
  '2': [
    {'1': 'input_scripts', '3': 1, '4': 3, '5': 11, '6': '.signrpc.InputScript', '10': 'inputScripts'},
  ],
};

/// Descriptor for `InputScriptResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputScriptRespDescriptor = $convert.base64Decode(
    'Cg9JbnB1dFNjcmlwdFJlc3ASOQoNaW5wdXRfc2NyaXB0cxgBIAMoCzIULnNpZ25ycGMuSW5wdX'
    'RTY3JpcHRSDGlucHV0U2NyaXB0cw==');

@$core.Deprecated('Use signMessageReqDescriptor instead')
const SignMessageReq$json = {
  '1': 'SignMessageReq',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 12, '10': 'msg'},
    {'1': 'key_loc', '3': 2, '4': 1, '5': 11, '6': '.signrpc.KeyLocator', '10': 'keyLoc'},
    {'1': 'double_hash', '3': 3, '4': 1, '5': 8, '10': 'doubleHash'},
    {'1': 'compact_sig', '3': 4, '4': 1, '5': 8, '10': 'compactSig'},
    {'1': 'schnorr_sig', '3': 5, '4': 1, '5': 8, '10': 'schnorrSig'},
    {'1': 'schnorr_sig_tap_tweak', '3': 6, '4': 1, '5': 12, '10': 'schnorrSigTapTweak'},
    {'1': 'tag', '3': 7, '4': 1, '5': 12, '10': 'tag'},
  ],
};

/// Descriptor for `SignMessageReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signMessageReqDescriptor = $convert.base64Decode(
    'Cg5TaWduTWVzc2FnZVJlcRIQCgNtc2cYASABKAxSA21zZxIsCgdrZXlfbG9jGAIgASgLMhMuc2'
    'lnbnJwYy5LZXlMb2NhdG9yUgZrZXlMb2MSHwoLZG91YmxlX2hhc2gYAyABKAhSCmRvdWJsZUhh'
    'c2gSHwoLY29tcGFjdF9zaWcYBCABKAhSCmNvbXBhY3RTaWcSHwoLc2Nobm9ycl9zaWcYBSABKA'
    'hSCnNjaG5vcnJTaWcSMQoVc2Nobm9ycl9zaWdfdGFwX3R3ZWFrGAYgASgMUhJzY2hub3JyU2ln'
    'VGFwVHdlYWsSEAoDdGFnGAcgASgMUgN0YWc=');

@$core.Deprecated('Use signMessageRespDescriptor instead')
const SignMessageResp$json = {
  '1': 'SignMessageResp',
  '2': [
    {'1': 'signature', '3': 1, '4': 1, '5': 12, '10': 'signature'},
  ],
};

/// Descriptor for `SignMessageResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signMessageRespDescriptor = $convert.base64Decode(
    'Cg9TaWduTWVzc2FnZVJlc3ASHAoJc2lnbmF0dXJlGAEgASgMUglzaWduYXR1cmU=');

@$core.Deprecated('Use verifyMessageReqDescriptor instead')
const VerifyMessageReq$json = {
  '1': 'VerifyMessageReq',
  '2': [
    {'1': 'msg', '3': 1, '4': 1, '5': 12, '10': 'msg'},
    {'1': 'signature', '3': 2, '4': 1, '5': 12, '10': 'signature'},
    {'1': 'pubkey', '3': 3, '4': 1, '5': 12, '10': 'pubkey'},
    {'1': 'is_schnorr_sig', '3': 4, '4': 1, '5': 8, '10': 'isSchnorrSig'},
    {'1': 'tag', '3': 5, '4': 1, '5': 12, '10': 'tag'},
  ],
};

/// Descriptor for `VerifyMessageReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyMessageReqDescriptor = $convert.base64Decode(
    'ChBWZXJpZnlNZXNzYWdlUmVxEhAKA21zZxgBIAEoDFIDbXNnEhwKCXNpZ25hdHVyZRgCIAEoDF'
    'IJc2lnbmF0dXJlEhYKBnB1YmtleRgDIAEoDFIGcHVia2V5EiQKDmlzX3NjaG5vcnJfc2lnGAQg'
    'ASgIUgxpc1NjaG5vcnJTaWcSEAoDdGFnGAUgASgMUgN0YWc=');

@$core.Deprecated('Use verifyMessageRespDescriptor instead')
const VerifyMessageResp$json = {
  '1': 'VerifyMessageResp',
  '2': [
    {'1': 'valid', '3': 1, '4': 1, '5': 8, '10': 'valid'},
  ],
};

/// Descriptor for `VerifyMessageResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyMessageRespDescriptor = $convert.base64Decode(
    'ChFWZXJpZnlNZXNzYWdlUmVzcBIUCgV2YWxpZBgBIAEoCFIFdmFsaWQ=');

@$core.Deprecated('Use sharedKeyRequestDescriptor instead')
const SharedKeyRequest$json = {
  '1': 'SharedKeyRequest',
  '2': [
    {'1': 'ephemeral_pubkey', '3': 1, '4': 1, '5': 12, '10': 'ephemeralPubkey'},
    {
      '1': 'key_loc',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.signrpc.KeyLocator',
      '8': {'3': true},
      '10': 'keyLoc',
    },
    {'1': 'key_desc', '3': 3, '4': 1, '5': 11, '6': '.signrpc.KeyDescriptor', '10': 'keyDesc'},
  ],
};

/// Descriptor for `SharedKeyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sharedKeyRequestDescriptor = $convert.base64Decode(
    'ChBTaGFyZWRLZXlSZXF1ZXN0EikKEGVwaGVtZXJhbF9wdWJrZXkYASABKAxSD2VwaGVtZXJhbF'
    'B1YmtleRIwCgdrZXlfbG9jGAIgASgLMhMuc2lnbnJwYy5LZXlMb2NhdG9yQgIYAVIGa2V5TG9j'
    'EjEKCGtleV9kZXNjGAMgASgLMhYuc2lnbnJwYy5LZXlEZXNjcmlwdG9yUgdrZXlEZXNj');

@$core.Deprecated('Use sharedKeyResponseDescriptor instead')
const SharedKeyResponse$json = {
  '1': 'SharedKeyResponse',
  '2': [
    {'1': 'shared_key', '3': 1, '4': 1, '5': 12, '10': 'sharedKey'},
  ],
};

/// Descriptor for `SharedKeyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sharedKeyResponseDescriptor = $convert.base64Decode(
    'ChFTaGFyZWRLZXlSZXNwb25zZRIdCgpzaGFyZWRfa2V5GAEgASgMUglzaGFyZWRLZXk=');

@$core.Deprecated('Use tweakDescDescriptor instead')
const TweakDesc$json = {
  '1': 'TweakDesc',
  '2': [
    {'1': 'tweak', '3': 1, '4': 1, '5': 12, '10': 'tweak'},
    {'1': 'is_x_only', '3': 2, '4': 1, '5': 8, '10': 'isXOnly'},
  ],
};

/// Descriptor for `TweakDesc`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tweakDescDescriptor = $convert.base64Decode(
    'CglUd2Vha0Rlc2MSFAoFdHdlYWsYASABKAxSBXR3ZWFrEhoKCWlzX3hfb25seRgCIAEoCFIHaX'
    'NYT25seQ==');

@$core.Deprecated('Use taprootTweakDescDescriptor instead')
const TaprootTweakDesc$json = {
  '1': 'TaprootTweakDesc',
  '2': [
    {'1': 'script_root', '3': 1, '4': 1, '5': 12, '10': 'scriptRoot'},
    {'1': 'key_spend_only', '3': 2, '4': 1, '5': 8, '10': 'keySpendOnly'},
  ],
};

/// Descriptor for `TaprootTweakDesc`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List taprootTweakDescDescriptor = $convert.base64Decode(
    'ChBUYXByb290VHdlYWtEZXNjEh8KC3NjcmlwdF9yb290GAEgASgMUgpzY3JpcHRSb290EiQKDm'
    'tleV9zcGVuZF9vbmx5GAIgASgIUgxrZXlTcGVuZE9ubHk=');

@$core.Deprecated('Use muSig2CombineKeysRequestDescriptor instead')
const MuSig2CombineKeysRequest$json = {
  '1': 'MuSig2CombineKeysRequest',
  '2': [
    {'1': 'all_signer_pubkeys', '3': 1, '4': 3, '5': 12, '10': 'allSignerPubkeys'},
    {'1': 'tweaks', '3': 2, '4': 3, '5': 11, '6': '.signrpc.TweakDesc', '10': 'tweaks'},
    {'1': 'taproot_tweak', '3': 3, '4': 1, '5': 11, '6': '.signrpc.TaprootTweakDesc', '10': 'taprootTweak'},
    {'1': 'version', '3': 4, '4': 1, '5': 14, '6': '.signrpc.MuSig2Version', '10': 'version'},
  ],
};

/// Descriptor for `MuSig2CombineKeysRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2CombineKeysRequestDescriptor = $convert.base64Decode(
    'ChhNdVNpZzJDb21iaW5lS2V5c1JlcXVlc3QSLAoSYWxsX3NpZ25lcl9wdWJrZXlzGAEgAygMUh'
    'BhbGxTaWduZXJQdWJrZXlzEioKBnR3ZWFrcxgCIAMoCzISLnNpZ25ycGMuVHdlYWtEZXNjUgZ0'
    'd2Vha3MSPgoNdGFwcm9vdF90d2VhaxgDIAEoCzIZLnNpZ25ycGMuVGFwcm9vdFR3ZWFrRGVzY1'
    'IMdGFwcm9vdFR3ZWFrEjAKB3ZlcnNpb24YBCABKA4yFi5zaWducnBjLk11U2lnMlZlcnNpb25S'
    'B3ZlcnNpb24=');

@$core.Deprecated('Use muSig2CombineKeysResponseDescriptor instead')
const MuSig2CombineKeysResponse$json = {
  '1': 'MuSig2CombineKeysResponse',
  '2': [
    {'1': 'combined_key', '3': 1, '4': 1, '5': 12, '10': 'combinedKey'},
    {'1': 'taproot_internal_key', '3': 2, '4': 1, '5': 12, '10': 'taprootInternalKey'},
    {'1': 'version', '3': 4, '4': 1, '5': 14, '6': '.signrpc.MuSig2Version', '10': 'version'},
  ],
};

/// Descriptor for `MuSig2CombineKeysResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2CombineKeysResponseDescriptor = $convert.base64Decode(
    'ChlNdVNpZzJDb21iaW5lS2V5c1Jlc3BvbnNlEiEKDGNvbWJpbmVkX2tleRgBIAEoDFILY29tYm'
    'luZWRLZXkSMAoUdGFwcm9vdF9pbnRlcm5hbF9rZXkYAiABKAxSEnRhcHJvb3RJbnRlcm5hbEtl'
    'eRIwCgd2ZXJzaW9uGAQgASgOMhYuc2lnbnJwYy5NdVNpZzJWZXJzaW9uUgd2ZXJzaW9u');

@$core.Deprecated('Use muSig2SessionRequestDescriptor instead')
const MuSig2SessionRequest$json = {
  '1': 'MuSig2SessionRequest',
  '2': [
    {'1': 'key_loc', '3': 1, '4': 1, '5': 11, '6': '.signrpc.KeyLocator', '10': 'keyLoc'},
    {'1': 'all_signer_pubkeys', '3': 2, '4': 3, '5': 12, '10': 'allSignerPubkeys'},
    {'1': 'other_signer_public_nonces', '3': 3, '4': 3, '5': 12, '10': 'otherSignerPublicNonces'},
    {'1': 'tweaks', '3': 4, '4': 3, '5': 11, '6': '.signrpc.TweakDesc', '10': 'tweaks'},
    {'1': 'taproot_tweak', '3': 5, '4': 1, '5': 11, '6': '.signrpc.TaprootTweakDesc', '10': 'taprootTweak'},
    {'1': 'version', '3': 6, '4': 1, '5': 14, '6': '.signrpc.MuSig2Version', '10': 'version'},
    {'1': 'pregenerated_local_nonce', '3': 7, '4': 1, '5': 12, '10': 'pregeneratedLocalNonce'},
  ],
};

/// Descriptor for `MuSig2SessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2SessionRequestDescriptor = $convert.base64Decode(
    'ChRNdVNpZzJTZXNzaW9uUmVxdWVzdBIsCgdrZXlfbG9jGAEgASgLMhMuc2lnbnJwYy5LZXlMb2'
    'NhdG9yUgZrZXlMb2MSLAoSYWxsX3NpZ25lcl9wdWJrZXlzGAIgAygMUhBhbGxTaWduZXJQdWJr'
    'ZXlzEjsKGm90aGVyX3NpZ25lcl9wdWJsaWNfbm9uY2VzGAMgAygMUhdvdGhlclNpZ25lclB1Ym'
    'xpY05vbmNlcxIqCgZ0d2Vha3MYBCADKAsyEi5zaWducnBjLlR3ZWFrRGVzY1IGdHdlYWtzEj4K'
    'DXRhcHJvb3RfdHdlYWsYBSABKAsyGS5zaWducnBjLlRhcHJvb3RUd2Vha0Rlc2NSDHRhcHJvb3'
    'RUd2VhaxIwCgd2ZXJzaW9uGAYgASgOMhYuc2lnbnJwYy5NdVNpZzJWZXJzaW9uUgd2ZXJzaW9u'
    'EjgKGHByZWdlbmVyYXRlZF9sb2NhbF9ub25jZRgHIAEoDFIWcHJlZ2VuZXJhdGVkTG9jYWxOb2'
    '5jZQ==');

@$core.Deprecated('Use muSig2SessionResponseDescriptor instead')
const MuSig2SessionResponse$json = {
  '1': 'MuSig2SessionResponse',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 12, '10': 'sessionId'},
    {'1': 'combined_key', '3': 2, '4': 1, '5': 12, '10': 'combinedKey'},
    {'1': 'taproot_internal_key', '3': 3, '4': 1, '5': 12, '10': 'taprootInternalKey'},
    {'1': 'local_public_nonces', '3': 4, '4': 1, '5': 12, '10': 'localPublicNonces'},
    {'1': 'have_all_nonces', '3': 5, '4': 1, '5': 8, '10': 'haveAllNonces'},
    {'1': 'version', '3': 6, '4': 1, '5': 14, '6': '.signrpc.MuSig2Version', '10': 'version'},
  ],
};

/// Descriptor for `MuSig2SessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2SessionResponseDescriptor = $convert.base64Decode(
    'ChVNdVNpZzJTZXNzaW9uUmVzcG9uc2USHQoKc2Vzc2lvbl9pZBgBIAEoDFIJc2Vzc2lvbklkEi'
    'EKDGNvbWJpbmVkX2tleRgCIAEoDFILY29tYmluZWRLZXkSMAoUdGFwcm9vdF9pbnRlcm5hbF9r'
    'ZXkYAyABKAxSEnRhcHJvb3RJbnRlcm5hbEtleRIuChNsb2NhbF9wdWJsaWNfbm9uY2VzGAQgAS'
    'gMUhFsb2NhbFB1YmxpY05vbmNlcxImCg9oYXZlX2FsbF9ub25jZXMYBSABKAhSDWhhdmVBbGxO'
    'b25jZXMSMAoHdmVyc2lvbhgGIAEoDjIWLnNpZ25ycGMuTXVTaWcyVmVyc2lvblIHdmVyc2lvbg'
    '==');

@$core.Deprecated('Use muSig2RegisterNoncesRequestDescriptor instead')
const MuSig2RegisterNoncesRequest$json = {
  '1': 'MuSig2RegisterNoncesRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 12, '10': 'sessionId'},
    {'1': 'other_signer_public_nonces', '3': 3, '4': 3, '5': 12, '10': 'otherSignerPublicNonces'},
  ],
};

/// Descriptor for `MuSig2RegisterNoncesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2RegisterNoncesRequestDescriptor = $convert.base64Decode(
    'ChtNdVNpZzJSZWdpc3Rlck5vbmNlc1JlcXVlc3QSHQoKc2Vzc2lvbl9pZBgBIAEoDFIJc2Vzc2'
    'lvbklkEjsKGm90aGVyX3NpZ25lcl9wdWJsaWNfbm9uY2VzGAMgAygMUhdvdGhlclNpZ25lclB1'
    'YmxpY05vbmNlcw==');

@$core.Deprecated('Use muSig2RegisterNoncesResponseDescriptor instead')
const MuSig2RegisterNoncesResponse$json = {
  '1': 'MuSig2RegisterNoncesResponse',
  '2': [
    {'1': 'have_all_nonces', '3': 1, '4': 1, '5': 8, '10': 'haveAllNonces'},
  ],
};

/// Descriptor for `MuSig2RegisterNoncesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2RegisterNoncesResponseDescriptor = $convert.base64Decode(
    'ChxNdVNpZzJSZWdpc3Rlck5vbmNlc1Jlc3BvbnNlEiYKD2hhdmVfYWxsX25vbmNlcxgBIAEoCF'
    'INaGF2ZUFsbE5vbmNlcw==');

@$core.Deprecated('Use muSig2SignRequestDescriptor instead')
const MuSig2SignRequest$json = {
  '1': 'MuSig2SignRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 12, '10': 'sessionId'},
    {'1': 'message_digest', '3': 2, '4': 1, '5': 12, '10': 'messageDigest'},
    {'1': 'cleanup', '3': 3, '4': 1, '5': 8, '10': 'cleanup'},
  ],
};

/// Descriptor for `MuSig2SignRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2SignRequestDescriptor = $convert.base64Decode(
    'ChFNdVNpZzJTaWduUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgMUglzZXNzaW9uSWQSJQoObW'
    'Vzc2FnZV9kaWdlc3QYAiABKAxSDW1lc3NhZ2VEaWdlc3QSGAoHY2xlYW51cBgDIAEoCFIHY2xl'
    'YW51cA==');

@$core.Deprecated('Use muSig2SignResponseDescriptor instead')
const MuSig2SignResponse$json = {
  '1': 'MuSig2SignResponse',
  '2': [
    {'1': 'local_partial_signature', '3': 1, '4': 1, '5': 12, '10': 'localPartialSignature'},
  ],
};

/// Descriptor for `MuSig2SignResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2SignResponseDescriptor = $convert.base64Decode(
    'ChJNdVNpZzJTaWduUmVzcG9uc2USNgoXbG9jYWxfcGFydGlhbF9zaWduYXR1cmUYASABKAxSFW'
    'xvY2FsUGFydGlhbFNpZ25hdHVyZQ==');

@$core.Deprecated('Use muSig2CombineSigRequestDescriptor instead')
const MuSig2CombineSigRequest$json = {
  '1': 'MuSig2CombineSigRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 12, '10': 'sessionId'},
    {'1': 'other_partial_signatures', '3': 2, '4': 3, '5': 12, '10': 'otherPartialSignatures'},
  ],
};

/// Descriptor for `MuSig2CombineSigRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2CombineSigRequestDescriptor = $convert.base64Decode(
    'ChdNdVNpZzJDb21iaW5lU2lnUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgMUglzZXNzaW9uSW'
    'QSOAoYb3RoZXJfcGFydGlhbF9zaWduYXR1cmVzGAIgAygMUhZvdGhlclBhcnRpYWxTaWduYXR1'
    'cmVz');

@$core.Deprecated('Use muSig2CombineSigResponseDescriptor instead')
const MuSig2CombineSigResponse$json = {
  '1': 'MuSig2CombineSigResponse',
  '2': [
    {'1': 'have_all_signatures', '3': 1, '4': 1, '5': 8, '10': 'haveAllSignatures'},
    {'1': 'final_signature', '3': 2, '4': 1, '5': 12, '10': 'finalSignature'},
  ],
};

/// Descriptor for `MuSig2CombineSigResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2CombineSigResponseDescriptor = $convert.base64Decode(
    'ChhNdVNpZzJDb21iaW5lU2lnUmVzcG9uc2USLgoTaGF2ZV9hbGxfc2lnbmF0dXJlcxgBIAEoCF'
    'IRaGF2ZUFsbFNpZ25hdHVyZXMSJwoPZmluYWxfc2lnbmF0dXJlGAIgASgMUg5maW5hbFNpZ25h'
    'dHVyZQ==');

@$core.Deprecated('Use muSig2CleanupRequestDescriptor instead')
const MuSig2CleanupRequest$json = {
  '1': 'MuSig2CleanupRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 12, '10': 'sessionId'},
  ],
};

/// Descriptor for `MuSig2CleanupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2CleanupRequestDescriptor = $convert.base64Decode(
    'ChRNdVNpZzJDbGVhbnVwUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgMUglzZXNzaW9uSWQ=');

@$core.Deprecated('Use muSig2CleanupResponseDescriptor instead')
const MuSig2CleanupResponse$json = {
  '1': 'MuSig2CleanupResponse',
};

/// Descriptor for `MuSig2CleanupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muSig2CleanupResponseDescriptor = $convert.base64Decode(
    'ChVNdVNpZzJDbGVhbnVwUmVzcG9uc2U=');

