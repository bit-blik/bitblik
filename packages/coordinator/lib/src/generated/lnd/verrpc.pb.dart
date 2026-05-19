//
//  Generated code. Do not modify.
//  source: lnd/verrpc.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class VersionRequest extends $pb.GeneratedMessage {
  factory VersionRequest() => create();
  VersionRequest._() : super();
  factory VersionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VersionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VersionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'verrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VersionRequest clone() => VersionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VersionRequest copyWith(void Function(VersionRequest) updates) => super.copyWith((message) => updates(message as VersionRequest)) as VersionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VersionRequest create() => VersionRequest._();
  VersionRequest createEmptyInstance() => create();
  static $pb.PbList<VersionRequest> createRepeated() => $pb.PbList<VersionRequest>();
  @$core.pragma('dart2js:noInline')
  static VersionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VersionRequest>(create);
  static VersionRequest? _defaultInstance;
}

class Version extends $pb.GeneratedMessage {
  factory Version({
    $core.String? commit,
    $core.String? commitHash,
    $core.String? version,
    $core.int? appMajor,
    $core.int? appMinor,
    $core.int? appPatch,
    $core.String? appPreRelease,
    $core.Iterable<$core.String>? buildTags,
    $core.String? goVersion,
  }) {
    final $result = create();
    if (commit != null) {
      $result.commit = commit;
    }
    if (commitHash != null) {
      $result.commitHash = commitHash;
    }
    if (version != null) {
      $result.version = version;
    }
    if (appMajor != null) {
      $result.appMajor = appMajor;
    }
    if (appMinor != null) {
      $result.appMinor = appMinor;
    }
    if (appPatch != null) {
      $result.appPatch = appPatch;
    }
    if (appPreRelease != null) {
      $result.appPreRelease = appPreRelease;
    }
    if (buildTags != null) {
      $result.buildTags.addAll(buildTags);
    }
    if (goVersion != null) {
      $result.goVersion = goVersion;
    }
    return $result;
  }
  Version._() : super();
  factory Version.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Version.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Version', package: const $pb.PackageName(_omitMessageNames ? '' : 'verrpc'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'commit')
    ..aOS(2, _omitFieldNames ? '' : 'commitHash')
    ..aOS(3, _omitFieldNames ? '' : 'version')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'appMajor', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'appMinor', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'appPatch', $pb.PbFieldType.OU3)
    ..aOS(7, _omitFieldNames ? '' : 'appPreRelease')
    ..pPS(8, _omitFieldNames ? '' : 'buildTags')
    ..aOS(9, _omitFieldNames ? '' : 'goVersion')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Version clone() => Version()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Version copyWith(void Function(Version) updates) => super.copyWith((message) => updates(message as Version)) as Version;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Version create() => Version._();
  Version createEmptyInstance() => create();
  static $pb.PbList<Version> createRepeated() => $pb.PbList<Version>();
  @$core.pragma('dart2js:noInline')
  static Version getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Version>(create);
  static Version? _defaultInstance;

  /// A verbose description of the daemon's commit.
  @$pb.TagNumber(1)
  $core.String get commit => $_getSZ(0);
  @$pb.TagNumber(1)
  set commit($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCommit() => $_has(0);
  @$pb.TagNumber(1)
  void clearCommit() => $_clearField(1);

  /// The SHA1 commit hash that the daemon is compiled with.
  @$pb.TagNumber(2)
  $core.String get commitHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set commitHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCommitHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommitHash() => $_clearField(2);

  /// The semantic version.
  @$pb.TagNumber(3)
  $core.String get version => $_getSZ(2);
  @$pb.TagNumber(3)
  set version($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  /// The major application version.
  @$pb.TagNumber(4)
  $core.int get appMajor => $_getIZ(3);
  @$pb.TagNumber(4)
  set appMajor($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAppMajor() => $_has(3);
  @$pb.TagNumber(4)
  void clearAppMajor() => $_clearField(4);

  /// The minor application version.
  @$pb.TagNumber(5)
  $core.int get appMinor => $_getIZ(4);
  @$pb.TagNumber(5)
  set appMinor($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAppMinor() => $_has(4);
  @$pb.TagNumber(5)
  void clearAppMinor() => $_clearField(5);

  /// The application patch number.
  @$pb.TagNumber(6)
  $core.int get appPatch => $_getIZ(5);
  @$pb.TagNumber(6)
  set appPatch($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAppPatch() => $_has(5);
  @$pb.TagNumber(6)
  void clearAppPatch() => $_clearField(6);

  /// The application pre-release modifier, possibly empty.
  @$pb.TagNumber(7)
  $core.String get appPreRelease => $_getSZ(6);
  @$pb.TagNumber(7)
  set appPreRelease($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasAppPreRelease() => $_has(6);
  @$pb.TagNumber(7)
  void clearAppPreRelease() => $_clearField(7);

  /// The list of build tags that were supplied during compilation.
  @$pb.TagNumber(8)
  $pb.PbList<$core.String> get buildTags => $_getList(7);

  /// The version of go that compiled the executable.
  @$pb.TagNumber(9)
  $core.String get goVersion => $_getSZ(8);
  @$pb.TagNumber(9)
  set goVersion($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasGoVersion() => $_has(8);
  @$pb.TagNumber(9)
  void clearGoVersion() => $_clearField(9);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
