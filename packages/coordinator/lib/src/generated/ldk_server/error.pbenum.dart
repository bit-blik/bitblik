//
//  Generated code. Do not modify.
//  source: error.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorCode extends $pb.ProtobufEnum {
  ///  Will never be used as `error_code` by server.
  ///
  ///  **Caution**: If a new type of `error_code` is introduced in the `ErrorCode` enum, `error_code` field will be set to
  ///  `UnknownError`.
  static const ErrorCode UNKNOWN_ERROR = ErrorCode._(0, _omitEnumNames ? '' : 'UNKNOWN_ERROR');
  /// Used in the following cases:
  ///   - The request was missing a required argument.
  ///   - The specified argument was invalid, incomplete or in the wrong format.
  ///   - The request body of api cannot be deserialized into corresponding protobuf object.
  ///   - The request does not follow api contract.
  static const ErrorCode INVALID_REQUEST_ERROR = ErrorCode._(1, _omitEnumNames ? '' : 'INVALID_REQUEST_ERROR');
  /// Used when authentication fails or in case of an unauthorized request.
  static const ErrorCode AUTH_ERROR = ErrorCode._(2, _omitEnumNames ? '' : 'AUTH_ERROR');
  /// Used to represent an error while doing a Lightning operation.
  static const ErrorCode LIGHTNING_ERROR = ErrorCode._(3, _omitEnumNames ? '' : 'LIGHTNING_ERROR');
  /// Used when an internal server error occurred. The client is probably at no fault.
  static const ErrorCode INTERNAL_SERVER_ERROR = ErrorCode._(4, _omitEnumNames ? '' : 'INTERNAL_SERVER_ERROR');

  static const $core.List<ErrorCode> values = <ErrorCode> [
    UNKNOWN_ERROR,
    INVALID_REQUEST_ERROR,
    AUTH_ERROR,
    LIGHTNING_ERROR,
    INTERNAL_SERVER_ERROR,
  ];

  static final $core.Map<$core.int, ErrorCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ErrorCode? valueOf($core.int value) => _byValue[value];

  const ErrorCode._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
