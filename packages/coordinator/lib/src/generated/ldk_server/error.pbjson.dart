//
//  Generated code. Do not modify.
//  source: error.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use errorCodeDescriptor instead')
const ErrorCode$json = {
  '1': 'ErrorCode',
  '2': [
    {'1': 'UNKNOWN_ERROR', '2': 0},
    {'1': 'INVALID_REQUEST_ERROR', '2': 1},
    {'1': 'AUTH_ERROR', '2': 2},
    {'1': 'LIGHTNING_ERROR', '2': 3},
    {'1': 'INTERNAL_SERVER_ERROR', '2': 4},
  ],
};

/// Descriptor for `ErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorCodeDescriptor = $convert.base64Decode(
    'CglFcnJvckNvZGUSEQoNVU5LTk9XTl9FUlJPUhAAEhkKFUlOVkFMSURfUkVRVUVTVF9FUlJPUh'
    'ABEg4KCkFVVEhfRVJST1IQAhITCg9MSUdIVE5JTkdfRVJST1IQAxIZChVJTlRFUk5BTF9TRVJW'
    'RVJfRVJST1IQBA==');

@$core.Deprecated('Use errorResponseDescriptor instead')
const ErrorResponse$json = {
  '1': 'ErrorResponse',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
    {'1': 'error_code', '3': 2, '4': 1, '5': 14, '6': '.error.ErrorCode', '10': 'errorCode'},
  ],
};

/// Descriptor for `ErrorResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorResponseDescriptor = $convert.base64Decode(
    'Cg1FcnJvclJlc3BvbnNlEhgKB21lc3NhZ2UYASABKAlSB21lc3NhZ2USLwoKZXJyb3JfY29kZR'
    'gCIAEoDjIQLmVycm9yLkVycm9yQ29kZVIJZXJyb3JDb2Rl');

