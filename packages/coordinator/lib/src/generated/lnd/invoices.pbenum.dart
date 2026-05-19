//
//  Generated code. Do not modify.
//  source: lnd/invoices.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LookupModifier extends $pb.ProtobufEnum {
  /// The default look up modifier, no look up behavior is changed.
  static const LookupModifier DEFAULT = LookupModifier._(0, _omitEnumNames ? '' : 'DEFAULT');
  ///
  /// Indicates that when a look up is done based on a set_id, then only that set
  /// of HTLCs related to that set ID should be returned.
  static const LookupModifier HTLC_SET_ONLY = LookupModifier._(1, _omitEnumNames ? '' : 'HTLC_SET_ONLY');
  ///
  /// Indicates that when a look up is done using a payment_addr, then no HTLCs
  /// related to the payment_addr should be returned. This is useful when one
  /// wants to be able to obtain the set of associated setIDs with a given
  /// invoice, then look up the sub-invoices "projected" by that set ID.
  static const LookupModifier HTLC_SET_BLANK = LookupModifier._(2, _omitEnumNames ? '' : 'HTLC_SET_BLANK');

  static const $core.List<LookupModifier> values = <LookupModifier> [
    DEFAULT,
    HTLC_SET_ONLY,
    HTLC_SET_BLANK,
  ];

  static final $core.Map<$core.int, LookupModifier> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LookupModifier? valueOf($core.int value) => _byValue[value];

  const LookupModifier._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
