//
//  Generated code. Do not modify.
//  source: lnd/signer.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SignMethod extends $pb.ProtobufEnum {
  ///
  /// Specifies that a SegWit v0 (p2wkh, np2wkh, p2wsh) input script should be
  /// signed.
  static const SignMethod SIGN_METHOD_WITNESS_V0 = SignMethod._(0, _omitEnumNames ? '' : 'SIGN_METHOD_WITNESS_V0');
  ///
  /// Specifies that a SegWit v1 (p2tr) input should be signed by using the
  /// BIP0086 method (commit to internal key only).
  static const SignMethod SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086 = SignMethod._(1, _omitEnumNames ? '' : 'SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086');
  ///
  /// Specifies that a SegWit v1 (p2tr) input should be signed by using a given
  /// taproot hash to commit to in addition to the internal key.
  static const SignMethod SIGN_METHOD_TAPROOT_KEY_SPEND = SignMethod._(2, _omitEnumNames ? '' : 'SIGN_METHOD_TAPROOT_KEY_SPEND');
  ///
  /// Specifies that a SegWit v1 (p2tr) input should be spent using the script
  /// path and that a specific leaf script should be signed for.
  static const SignMethod SIGN_METHOD_TAPROOT_SCRIPT_SPEND = SignMethod._(3, _omitEnumNames ? '' : 'SIGN_METHOD_TAPROOT_SCRIPT_SPEND');

  static const $core.List<SignMethod> values = <SignMethod> [
    SIGN_METHOD_WITNESS_V0,
    SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086,
    SIGN_METHOD_TAPROOT_KEY_SPEND,
    SIGN_METHOD_TAPROOT_SCRIPT_SPEND,
  ];

  static final $core.Map<$core.int, SignMethod> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SignMethod? valueOf($core.int value) => _byValue[value];

  const SignMethod._(super.v, super.n);
}

class MuSig2Version extends $pb.ProtobufEnum {
  ///
  /// The default value on the RPC is zero for enums so we need to represent an
  /// invalid/undefined version by default to make sure clients upgrade their
  /// software to set the version explicitly.
  static const MuSig2Version MUSIG2_VERSION_UNDEFINED = MuSig2Version._(0, _omitEnumNames ? '' : 'MUSIG2_VERSION_UNDEFINED');
  ///
  /// The version of MuSig2 that lnd 0.15.x shipped with, which corresponds to the
  /// version v0.4.0 of the MuSig2 BIP draft.
  static const MuSig2Version MUSIG2_VERSION_V040 = MuSig2Version._(1, _omitEnumNames ? '' : 'MUSIG2_VERSION_V040');
  ///
  /// The current version of MuSig2 which corresponds to the version v1.0.0rc2 of
  /// the MuSig2 BIP draft.
  static const MuSig2Version MUSIG2_VERSION_V100RC2 = MuSig2Version._(2, _omitEnumNames ? '' : 'MUSIG2_VERSION_V100RC2');

  static const $core.List<MuSig2Version> values = <MuSig2Version> [
    MUSIG2_VERSION_UNDEFINED,
    MUSIG2_VERSION_V040,
    MUSIG2_VERSION_V100RC2,
  ];

  static final $core.Map<$core.int, MuSig2Version> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MuSig2Version? valueOf($core.int value) => _byValue[value];

  const MuSig2Version._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
