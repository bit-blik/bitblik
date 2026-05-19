//
//  Generated code. Do not modify.
//  source: lnd/hold.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Holdstate extends $pb.ProtobufEnum {
  static const Holdstate OPEN = Holdstate._(0, _omitEnumNames ? '' : 'OPEN');
  static const Holdstate SETTLED = Holdstate._(1, _omitEnumNames ? '' : 'SETTLED');
  static const Holdstate CANCELED = Holdstate._(2, _omitEnumNames ? '' : 'CANCELED');
  static const Holdstate ACCEPTED = Holdstate._(3, _omitEnumNames ? '' : 'ACCEPTED');

  static const $core.List<Holdstate> values = <Holdstate> [
    OPEN,
    SETTLED,
    CANCELED,
    ACCEPTED,
  ];

  static final $core.Map<$core.int, Holdstate> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Holdstate? valueOf($core.int value) => _byValue[value];

  const Holdstate._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
