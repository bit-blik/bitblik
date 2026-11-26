//
//  Generated code. Do not modify.
//  source: lndkrpc.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Direction extends $pb.ProtobufEnum {
  static const Direction NODE_ONE = Direction._(0, _omitEnumNames ? '' : 'NODE_ONE');
  static const Direction NODE_TWO = Direction._(1, _omitEnumNames ? '' : 'NODE_TWO');

  static const $core.List<Direction> values = <Direction> [
    NODE_ONE,
    NODE_TWO,
  ];

  static final $core.Map<$core.int, Direction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Direction? valueOf($core.int value) => _byValue[value];

  const Direction._(super.v, super.n);
}

class FeatureBit extends $pb.ProtobufEnum {
  static const FeatureBit DATALOSS_PROTECT_REQ = FeatureBit._(0, _omitEnumNames ? '' : 'DATALOSS_PROTECT_REQ');
  static const FeatureBit DATALOSS_PROTECT_OPT = FeatureBit._(1, _omitEnumNames ? '' : 'DATALOSS_PROTECT_OPT');
  static const FeatureBit INITIAL_ROUING_SYNC = FeatureBit._(3, _omitEnumNames ? '' : 'INITIAL_ROUING_SYNC');
  static const FeatureBit UPFRONT_SHUTDOWN_SCRIPT_REQ = FeatureBit._(4, _omitEnumNames ? '' : 'UPFRONT_SHUTDOWN_SCRIPT_REQ');
  static const FeatureBit UPFRONT_SHUTDOWN_SCRIPT_OPT = FeatureBit._(5, _omitEnumNames ? '' : 'UPFRONT_SHUTDOWN_SCRIPT_OPT');
  static const FeatureBit GOSSIP_QUERIES_REQ = FeatureBit._(6, _omitEnumNames ? '' : 'GOSSIP_QUERIES_REQ');
  static const FeatureBit GOSSIP_QUERIES_OPT = FeatureBit._(7, _omitEnumNames ? '' : 'GOSSIP_QUERIES_OPT');
  static const FeatureBit TLV_ONION_REQ = FeatureBit._(8, _omitEnumNames ? '' : 'TLV_ONION_REQ');
  static const FeatureBit TLV_ONION_OPT = FeatureBit._(9, _omitEnumNames ? '' : 'TLV_ONION_OPT');
  static const FeatureBit EXT_GOSSIP_QUERIES_REQ = FeatureBit._(10, _omitEnumNames ? '' : 'EXT_GOSSIP_QUERIES_REQ');
  static const FeatureBit EXT_GOSSIP_QUERIES_OPT = FeatureBit._(11, _omitEnumNames ? '' : 'EXT_GOSSIP_QUERIES_OPT');
  static const FeatureBit STATIC_REMOTE_KEY_REQ = FeatureBit._(12, _omitEnumNames ? '' : 'STATIC_REMOTE_KEY_REQ');
  static const FeatureBit STATIC_REMOTE_KEY_OPT = FeatureBit._(13, _omitEnumNames ? '' : 'STATIC_REMOTE_KEY_OPT');
  static const FeatureBit PAYMENT_ADDR_REQ = FeatureBit._(14, _omitEnumNames ? '' : 'PAYMENT_ADDR_REQ');
  static const FeatureBit PAYMENT_ADDR_OPT = FeatureBit._(15, _omitEnumNames ? '' : 'PAYMENT_ADDR_OPT');
  static const FeatureBit MPP_REQ = FeatureBit._(16, _omitEnumNames ? '' : 'MPP_REQ');
  static const FeatureBit MPP_OPT = FeatureBit._(17, _omitEnumNames ? '' : 'MPP_OPT');
  static const FeatureBit WUMBO_CHANNELS_REQ = FeatureBit._(18, _omitEnumNames ? '' : 'WUMBO_CHANNELS_REQ');
  static const FeatureBit WUMBO_CHANNELS_OPT = FeatureBit._(19, _omitEnumNames ? '' : 'WUMBO_CHANNELS_OPT');
  static const FeatureBit ANCHORS_REQ = FeatureBit._(20, _omitEnumNames ? '' : 'ANCHORS_REQ');
  static const FeatureBit ANCHORS_OPT = FeatureBit._(21, _omitEnumNames ? '' : 'ANCHORS_OPT');
  static const FeatureBit ANCHORS_ZERO_FEE_HTLC_REQ = FeatureBit._(22, _omitEnumNames ? '' : 'ANCHORS_ZERO_FEE_HTLC_REQ');
  static const FeatureBit ANCHORS_ZERO_FEE_HTLC_OPT = FeatureBit._(23, _omitEnumNames ? '' : 'ANCHORS_ZERO_FEE_HTLC_OPT');
  static const FeatureBit ROUTE_BLINDING_REQUIRED = FeatureBit._(24, _omitEnumNames ? '' : 'ROUTE_BLINDING_REQUIRED');
  static const FeatureBit ROUTE_BLINDING_OPTIONAL = FeatureBit._(25, _omitEnumNames ? '' : 'ROUTE_BLINDING_OPTIONAL');
  static const FeatureBit AMP_REQ = FeatureBit._(30, _omitEnumNames ? '' : 'AMP_REQ');
  static const FeatureBit AMP_OPT = FeatureBit._(31, _omitEnumNames ? '' : 'AMP_OPT');

  static const $core.List<FeatureBit> values = <FeatureBit> [
    DATALOSS_PROTECT_REQ,
    DATALOSS_PROTECT_OPT,
    INITIAL_ROUING_SYNC,
    UPFRONT_SHUTDOWN_SCRIPT_REQ,
    UPFRONT_SHUTDOWN_SCRIPT_OPT,
    GOSSIP_QUERIES_REQ,
    GOSSIP_QUERIES_OPT,
    TLV_ONION_REQ,
    TLV_ONION_OPT,
    EXT_GOSSIP_QUERIES_REQ,
    EXT_GOSSIP_QUERIES_OPT,
    STATIC_REMOTE_KEY_REQ,
    STATIC_REMOTE_KEY_OPT,
    PAYMENT_ADDR_REQ,
    PAYMENT_ADDR_OPT,
    MPP_REQ,
    MPP_OPT,
    WUMBO_CHANNELS_REQ,
    WUMBO_CHANNELS_OPT,
    ANCHORS_REQ,
    ANCHORS_OPT,
    ANCHORS_ZERO_FEE_HTLC_REQ,
    ANCHORS_ZERO_FEE_HTLC_OPT,
    ROUTE_BLINDING_REQUIRED,
    ROUTE_BLINDING_OPTIONAL,
    AMP_REQ,
    AMP_OPT,
  ];

  static final $core.Map<$core.int, FeatureBit> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FeatureBit? valueOf($core.int value) => _byValue[value];

  const FeatureBit._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
