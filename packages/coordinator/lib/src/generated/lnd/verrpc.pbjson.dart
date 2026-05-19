//
//  Generated code. Do not modify.
//  source: lnd/verrpc.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use versionRequestDescriptor instead')
const VersionRequest$json = {
  '1': 'VersionRequest',
};

/// Descriptor for `VersionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionRequestDescriptor = $convert.base64Decode(
    'Cg5WZXJzaW9uUmVxdWVzdA==');

@$core.Deprecated('Use versionDescriptor instead')
const Version$json = {
  '1': 'Version',
  '2': [
    {'1': 'commit', '3': 1, '4': 1, '5': 9, '10': 'commit'},
    {'1': 'commit_hash', '3': 2, '4': 1, '5': 9, '10': 'commitHash'},
    {'1': 'version', '3': 3, '4': 1, '5': 9, '10': 'version'},
    {'1': 'app_major', '3': 4, '4': 1, '5': 13, '10': 'appMajor'},
    {'1': 'app_minor', '3': 5, '4': 1, '5': 13, '10': 'appMinor'},
    {'1': 'app_patch', '3': 6, '4': 1, '5': 13, '10': 'appPatch'},
    {'1': 'app_pre_release', '3': 7, '4': 1, '5': 9, '10': 'appPreRelease'},
    {'1': 'build_tags', '3': 8, '4': 3, '5': 9, '10': 'buildTags'},
    {'1': 'go_version', '3': 9, '4': 1, '5': 9, '10': 'goVersion'},
  ],
};

/// Descriptor for `Version`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionDescriptor = $convert.base64Decode(
    'CgdWZXJzaW9uEhYKBmNvbW1pdBgBIAEoCVIGY29tbWl0Eh8KC2NvbW1pdF9oYXNoGAIgASgJUg'
    'pjb21taXRIYXNoEhgKB3ZlcnNpb24YAyABKAlSB3ZlcnNpb24SGwoJYXBwX21ham9yGAQgASgN'
    'UghhcHBNYWpvchIbCglhcHBfbWlub3IYBSABKA1SCGFwcE1pbm9yEhsKCWFwcF9wYXRjaBgGIA'
    'EoDVIIYXBwUGF0Y2gSJgoPYXBwX3ByZV9yZWxlYXNlGAcgASgJUg1hcHBQcmVSZWxlYXNlEh0K'
    'CmJ1aWxkX3RhZ3MYCCADKAlSCWJ1aWxkVGFncxIdCgpnb192ZXJzaW9uGAkgASgJUglnb1Zlcn'
    'Npb24=');

