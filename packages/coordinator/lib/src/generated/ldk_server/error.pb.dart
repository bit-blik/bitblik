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

import 'error.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'error.pbenum.dart';

/// When HttpStatusCode is not ok (200), the response `content` contains a serialized `ErrorResponse`
/// with the relevant ErrorCode and `message`
class ErrorResponse extends $pb.GeneratedMessage {
  factory ErrorResponse({
    $core.String? message,
    ErrorCode? errorCode,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (errorCode != null) {
      $result.errorCode = errorCode;
    }
    return $result;
  }
  ErrorResponse._() : super();
  factory ErrorResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ErrorResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ErrorResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'error'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..e<ErrorCode>(2, _omitFieldNames ? '' : 'errorCode', $pb.PbFieldType.OE, defaultOrMaker: ErrorCode.UNKNOWN_ERROR, valueOf: ErrorCode.valueOf, enumValues: ErrorCode.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ErrorResponse clone() => ErrorResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ErrorResponse copyWith(void Function(ErrorResponse) updates) => super.copyWith((message) => updates(message as ErrorResponse)) as ErrorResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ErrorResponse create() => ErrorResponse._();
  ErrorResponse createEmptyInstance() => create();
  static $pb.PbList<ErrorResponse> createRepeated() => $pb.PbList<ErrorResponse>();
  @$core.pragma('dart2js:noInline')
  static ErrorResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ErrorResponse>(create);
  static ErrorResponse? _defaultInstance;

  /// The error message containing a generic description of the error condition in English.
  /// It is intended for a human audience only and should not be parsed to extract any information
  /// programmatically. Client-side code may use it for logging only.
  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  ///  The error code uniquely identifying an error condition.
  ///  It is meant to be read and understood programmatically by code that detects/handles errors by
  ///  type.
  ///
  ///  **Caution**: If a new type of `error_code` is introduced in the `ErrorCode` enum, `error_code` field will be set to
  ///  `UnknownError`.
  @$pb.TagNumber(2)
  ErrorCode get errorCode => $_getN(1);
  @$pb.TagNumber(2)
  set errorCode(ErrorCode v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasErrorCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearErrorCode() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
