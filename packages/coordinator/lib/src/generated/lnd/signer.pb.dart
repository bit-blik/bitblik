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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'signer.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'signer.pbenum.dart';

class KeyLocator extends $pb.GeneratedMessage {
  factory KeyLocator({
    $core.int? keyFamily,
    $core.int? keyIndex,
  }) {
    final $result = create();
    if (keyFamily != null) {
      $result.keyFamily = keyFamily;
    }
    if (keyIndex != null) {
      $result.keyIndex = keyIndex;
    }
    return $result;
  }
  KeyLocator._() : super();
  factory KeyLocator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyLocator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KeyLocator', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'keyFamily', $pb.PbFieldType.O3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'keyIndex', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyLocator clone() => KeyLocator()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyLocator copyWith(void Function(KeyLocator) updates) => super.copyWith((message) => updates(message as KeyLocator)) as KeyLocator;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyLocator create() => KeyLocator._();
  KeyLocator createEmptyInstance() => create();
  static $pb.PbList<KeyLocator> createRepeated() => $pb.PbList<KeyLocator>();
  @$core.pragma('dart2js:noInline')
  static KeyLocator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyLocator>(create);
  static KeyLocator? _defaultInstance;

  /// The family of key being identified.
  @$pb.TagNumber(1)
  $core.int get keyFamily => $_getIZ(0);
  @$pb.TagNumber(1)
  set keyFamily($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyFamily() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyFamily() => $_clearField(1);

  /// The precise index of the key being identified.
  @$pb.TagNumber(2)
  $core.int get keyIndex => $_getIZ(1);
  @$pb.TagNumber(2)
  set keyIndex($core.int v) { $_setSignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyIndex() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyIndex() => $_clearField(2);
}

class KeyDescriptor extends $pb.GeneratedMessage {
  factory KeyDescriptor({
    $core.List<$core.int>? rawKeyBytes,
    KeyLocator? keyLoc,
  }) {
    final $result = create();
    if (rawKeyBytes != null) {
      $result.rawKeyBytes = rawKeyBytes;
    }
    if (keyLoc != null) {
      $result.keyLoc = keyLoc;
    }
    return $result;
  }
  KeyDescriptor._() : super();
  factory KeyDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KeyDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'KeyDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rawKeyBytes', $pb.PbFieldType.OY)
    ..aOM<KeyLocator>(2, _omitFieldNames ? '' : 'keyLoc', subBuilder: KeyLocator.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KeyDescriptor clone() => KeyDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KeyDescriptor copyWith(void Function(KeyDescriptor) updates) => super.copyWith((message) => updates(message as KeyDescriptor)) as KeyDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyDescriptor create() => KeyDescriptor._();
  KeyDescriptor createEmptyInstance() => create();
  static $pb.PbList<KeyDescriptor> createRepeated() => $pb.PbList<KeyDescriptor>();
  @$core.pragma('dart2js:noInline')
  static KeyDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KeyDescriptor>(create);
  static KeyDescriptor? _defaultInstance;

  ///
  /// The raw bytes of the public key in the key pair being identified. Either
  /// this or the KeyLocator must be specified.
  @$pb.TagNumber(1)
  $core.List<$core.int> get rawKeyBytes => $_getN(0);
  @$pb.TagNumber(1)
  set rawKeyBytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRawKeyBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearRawKeyBytes() => $_clearField(1);

  ///
  /// The key locator that identifies which private key to use for signing.
  /// Either this or the raw bytes of the target public key must be specified.
  @$pb.TagNumber(2)
  KeyLocator get keyLoc => $_getN(1);
  @$pb.TagNumber(2)
  set keyLoc(KeyLocator v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyLoc() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyLoc() => $_clearField(2);
  @$pb.TagNumber(2)
  KeyLocator ensureKeyLoc() => $_ensure(1);
}

class TxOut extends $pb.GeneratedMessage {
  factory TxOut({
    $fixnum.Int64? value,
    $core.List<$core.int>? pkScript,
  }) {
    final $result = create();
    if (value != null) {
      $result.value = value;
    }
    if (pkScript != null) {
      $result.pkScript = pkScript;
    }
    return $result;
  }
  TxOut._() : super();
  factory TxOut.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TxOut.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TxOut', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'value')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'pkScript', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TxOut clone() => TxOut()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TxOut copyWith(void Function(TxOut) updates) => super.copyWith((message) => updates(message as TxOut)) as TxOut;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TxOut create() => TxOut._();
  TxOut createEmptyInstance() => create();
  static $pb.PbList<TxOut> createRepeated() => $pb.PbList<TxOut>();
  @$core.pragma('dart2js:noInline')
  static TxOut getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TxOut>(create);
  static TxOut? _defaultInstance;

  /// The value of the output being spent.
  @$pb.TagNumber(1)
  $fixnum.Int64 get value => $_getI64(0);
  @$pb.TagNumber(1)
  set value($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);

  /// The script of the output being spent.
  @$pb.TagNumber(2)
  $core.List<$core.int> get pkScript => $_getN(1);
  @$pb.TagNumber(2)
  set pkScript($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPkScript() => $_has(1);
  @$pb.TagNumber(2)
  void clearPkScript() => $_clearField(2);
}

class SignDescriptor extends $pb.GeneratedMessage {
  factory SignDescriptor({
    KeyDescriptor? keyDesc,
    $core.List<$core.int>? singleTweak,
    $core.List<$core.int>? doubleTweak,
    $core.List<$core.int>? witnessScript,
    TxOut? output,
    $core.int? sighash,
    $core.int? inputIndex,
    SignMethod? signMethod,
    $core.List<$core.int>? tapTweak,
  }) {
    final $result = create();
    if (keyDesc != null) {
      $result.keyDesc = keyDesc;
    }
    if (singleTweak != null) {
      $result.singleTweak = singleTweak;
    }
    if (doubleTweak != null) {
      $result.doubleTweak = doubleTweak;
    }
    if (witnessScript != null) {
      $result.witnessScript = witnessScript;
    }
    if (output != null) {
      $result.output = output;
    }
    if (sighash != null) {
      $result.sighash = sighash;
    }
    if (inputIndex != null) {
      $result.inputIndex = inputIndex;
    }
    if (signMethod != null) {
      $result.signMethod = signMethod;
    }
    if (tapTweak != null) {
      $result.tapTweak = tapTweak;
    }
    return $result;
  }
  SignDescriptor._() : super();
  factory SignDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..aOM<KeyDescriptor>(1, _omitFieldNames ? '' : 'keyDesc', subBuilder: KeyDescriptor.create)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'singleTweak', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'doubleTweak', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'witnessScript', $pb.PbFieldType.OY)
    ..aOM<TxOut>(5, _omitFieldNames ? '' : 'output', subBuilder: TxOut.create)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'sighash', $pb.PbFieldType.OU3)
    ..a<$core.int>(8, _omitFieldNames ? '' : 'inputIndex', $pb.PbFieldType.O3)
    ..e<SignMethod>(9, _omitFieldNames ? '' : 'signMethod', $pb.PbFieldType.OE, defaultOrMaker: SignMethod.SIGN_METHOD_WITNESS_V0, valueOf: SignMethod.valueOf, enumValues: SignMethod.values)
    ..a<$core.List<$core.int>>(10, _omitFieldNames ? '' : 'tapTweak', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignDescriptor clone() => SignDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignDescriptor copyWith(void Function(SignDescriptor) updates) => super.copyWith((message) => updates(message as SignDescriptor)) as SignDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignDescriptor create() => SignDescriptor._();
  SignDescriptor createEmptyInstance() => create();
  static $pb.PbList<SignDescriptor> createRepeated() => $pb.PbList<SignDescriptor>();
  @$core.pragma('dart2js:noInline')
  static SignDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignDescriptor>(create);
  static SignDescriptor? _defaultInstance;

  ///
  /// A descriptor that precisely describes *which* key to use for signing. This
  /// may provide the raw public key directly, or require the Signer to re-derive
  /// the key according to the populated derivation path.
  ///
  /// Note that if the key descriptor was obtained through walletrpc.DeriveKey,
  /// then the key locator MUST always be provided, since the derived keys are not
  /// persisted unlike with DeriveNextKey.
  @$pb.TagNumber(1)
  KeyDescriptor get keyDesc => $_getN(0);
  @$pb.TagNumber(1)
  set keyDesc(KeyDescriptor v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyDesc() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyDesc() => $_clearField(1);
  @$pb.TagNumber(1)
  KeyDescriptor ensureKeyDesc() => $_ensure(0);

  ///
  /// A scalar value that will be added to the private key corresponding to the
  /// above public key to obtain the private key to be used to sign this input.
  /// This value is typically derived via the following computation:
  ///
  ///  derivedKey = privkey + sha256(perCommitmentPoint || pubKey) mod N
  @$pb.TagNumber(2)
  $core.List<$core.int> get singleTweak => $_getN(1);
  @$pb.TagNumber(2)
  set singleTweak($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSingleTweak() => $_has(1);
  @$pb.TagNumber(2)
  void clearSingleTweak() => $_clearField(2);

  ///
  /// A private key that will be used in combination with its corresponding
  /// private key to derive the private key that is to be used to sign the target
  /// input. Within the Lightning protocol, this value is typically the
  /// commitment secret from a previously revoked commitment transaction. This
  /// value is in combination with two hash values, and the original private key
  /// to derive the private key to be used when signing.
  ///
  ///  k = (privKey*sha256(pubKey || tweakPub) +
  /// tweakPriv*sha256(tweakPub || pubKey)) mod N
  @$pb.TagNumber(3)
  $core.List<$core.int> get doubleTweak => $_getN(2);
  @$pb.TagNumber(3)
  set doubleTweak($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDoubleTweak() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleTweak() => $_clearField(3);

  ///
  /// The full script required to properly redeem the output. This field will
  /// only be populated if a p2tr, p2wsh or a p2sh output is being signed. If a
  /// taproot script path spend is being attempted, then this should be the raw
  /// leaf script.
  @$pb.TagNumber(4)
  $core.List<$core.int> get witnessScript => $_getN(3);
  @$pb.TagNumber(4)
  set witnessScript($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWitnessScript() => $_has(3);
  @$pb.TagNumber(4)
  void clearWitnessScript() => $_clearField(4);

  ///
  /// A description of the output being spent. The value and script MUST be
  /// provided.
  @$pb.TagNumber(5)
  TxOut get output => $_getN(4);
  @$pb.TagNumber(5)
  set output(TxOut v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasOutput() => $_has(4);
  @$pb.TagNumber(5)
  void clearOutput() => $_clearField(5);
  @$pb.TagNumber(5)
  TxOut ensureOutput() => $_ensure(4);

  ///
  /// The target sighash type that should be used when generating the final
  /// sighash, and signature.
  @$pb.TagNumber(7)
  $core.int get sighash => $_getIZ(5);
  @$pb.TagNumber(7)
  set sighash($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasSighash() => $_has(5);
  @$pb.TagNumber(7)
  void clearSighash() => $_clearField(7);

  ///
  /// The target input within the transaction that should be signed.
  @$pb.TagNumber(8)
  $core.int get inputIndex => $_getIZ(6);
  @$pb.TagNumber(8)
  set inputIndex($core.int v) { $_setSignedInt32(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasInputIndex() => $_has(6);
  @$pb.TagNumber(8)
  void clearInputIndex() => $_clearField(8);

  ///
  /// The sign method specifies how the input should be signed. Depending on the
  /// method, either the tap_tweak, witness_script or both need to be specified.
  /// Defaults to SegWit v0 signing to be backward compatible with older RPC
  /// clients.
  @$pb.TagNumber(9)
  SignMethod get signMethod => $_getN(7);
  @$pb.TagNumber(9)
  set signMethod(SignMethod v) { $_setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasSignMethod() => $_has(7);
  @$pb.TagNumber(9)
  void clearSignMethod() => $_clearField(9);

  ///
  /// The 32 byte input to the taproot tweak derivation that is used to derive
  /// the output key from an internal key: outputKey = internalKey +
  /// tagged_hash("tapTweak", internalKey || tapTweak).
  ///
  /// When doing a BIP 86 spend, this field can be an empty byte slice.
  ///
  /// When doing a normal key path spend, with the output key committing to an
  /// actual script root, then this field should be: the tapscript root hash.
  @$pb.TagNumber(10)
  $core.List<$core.int> get tapTweak => $_getN(8);
  @$pb.TagNumber(10)
  set tapTweak($core.List<$core.int> v) { $_setBytes(8, v); }
  @$pb.TagNumber(10)
  $core.bool hasTapTweak() => $_has(8);
  @$pb.TagNumber(10)
  void clearTapTweak() => $_clearField(10);
}

class SignReq extends $pb.GeneratedMessage {
  factory SignReq({
    $core.List<$core.int>? rawTxBytes,
    $core.Iterable<SignDescriptor>? signDescs,
    $core.Iterable<TxOut>? prevOutputs,
  }) {
    final $result = create();
    if (rawTxBytes != null) {
      $result.rawTxBytes = rawTxBytes;
    }
    if (signDescs != null) {
      $result.signDescs.addAll(signDescs);
    }
    if (prevOutputs != null) {
      $result.prevOutputs.addAll(prevOutputs);
    }
    return $result;
  }
  SignReq._() : super();
  factory SignReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rawTxBytes', $pb.PbFieldType.OY)
    ..pc<SignDescriptor>(2, _omitFieldNames ? '' : 'signDescs', $pb.PbFieldType.PM, subBuilder: SignDescriptor.create)
    ..pc<TxOut>(3, _omitFieldNames ? '' : 'prevOutputs', $pb.PbFieldType.PM, subBuilder: TxOut.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignReq clone() => SignReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignReq copyWith(void Function(SignReq) updates) => super.copyWith((message) => updates(message as SignReq)) as SignReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignReq create() => SignReq._();
  SignReq createEmptyInstance() => create();
  static $pb.PbList<SignReq> createRepeated() => $pb.PbList<SignReq>();
  @$core.pragma('dart2js:noInline')
  static SignReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignReq>(create);
  static SignReq? _defaultInstance;

  /// The raw bytes of the transaction to be signed.
  @$pb.TagNumber(1)
  $core.List<$core.int> get rawTxBytes => $_getN(0);
  @$pb.TagNumber(1)
  set rawTxBytes($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRawTxBytes() => $_has(0);
  @$pb.TagNumber(1)
  void clearRawTxBytes() => $_clearField(1);

  /// A set of sign descriptors, for each input to be signed.
  @$pb.TagNumber(2)
  $pb.PbList<SignDescriptor> get signDescs => $_getList(1);

  ///
  /// The full list of UTXO information for each of the inputs being spent. This
  /// is required when spending one or more taproot (SegWit v1) outputs.
  @$pb.TagNumber(3)
  $pb.PbList<TxOut> get prevOutputs => $_getList(2);
}

class SignResp extends $pb.GeneratedMessage {
  factory SignResp({
    $core.Iterable<$core.List<$core.int>>? rawSigs,
  }) {
    final $result = create();
    if (rawSigs != null) {
      $result.rawSigs.addAll(rawSigs);
    }
    return $result;
  }
  SignResp._() : super();
  factory SignResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'rawSigs', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignResp clone() => SignResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignResp copyWith(void Function(SignResp) updates) => super.copyWith((message) => updates(message as SignResp)) as SignResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignResp create() => SignResp._();
  SignResp createEmptyInstance() => create();
  static $pb.PbList<SignResp> createRepeated() => $pb.PbList<SignResp>();
  @$core.pragma('dart2js:noInline')
  static SignResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignResp>(create);
  static SignResp? _defaultInstance;

  ///
  /// A set of signatures realized in a fixed 64-byte format ordered in ascending
  /// input order.
  @$pb.TagNumber(1)
  $pb.PbList<$core.List<$core.int>> get rawSigs => $_getList(0);
}

class InputScript extends $pb.GeneratedMessage {
  factory InputScript({
    $core.Iterable<$core.List<$core.int>>? witness,
    $core.List<$core.int>? sigScript,
  }) {
    final $result = create();
    if (witness != null) {
      $result.witness.addAll(witness);
    }
    if (sigScript != null) {
      $result.sigScript = sigScript;
    }
    return $result;
  }
  InputScript._() : super();
  factory InputScript.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InputScript.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InputScript', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'witness', $pb.PbFieldType.PY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'sigScript', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InputScript clone() => InputScript()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InputScript copyWith(void Function(InputScript) updates) => super.copyWith((message) => updates(message as InputScript)) as InputScript;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InputScript create() => InputScript._();
  InputScript createEmptyInstance() => create();
  static $pb.PbList<InputScript> createRepeated() => $pb.PbList<InputScript>();
  @$core.pragma('dart2js:noInline')
  static InputScript getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputScript>(create);
  static InputScript? _defaultInstance;

  /// The serializes witness stack for the specified input.
  @$pb.TagNumber(1)
  $pb.PbList<$core.List<$core.int>> get witness => $_getList(0);

  ///
  /// The optional sig script for the specified witness that will only be set if
  /// the input specified is a nested p2sh witness program.
  @$pb.TagNumber(2)
  $core.List<$core.int> get sigScript => $_getN(1);
  @$pb.TagNumber(2)
  set sigScript($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSigScript() => $_has(1);
  @$pb.TagNumber(2)
  void clearSigScript() => $_clearField(2);
}

class InputScriptResp extends $pb.GeneratedMessage {
  factory InputScriptResp({
    $core.Iterable<InputScript>? inputScripts,
  }) {
    final $result = create();
    if (inputScripts != null) {
      $result.inputScripts.addAll(inputScripts);
    }
    return $result;
  }
  InputScriptResp._() : super();
  factory InputScriptResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InputScriptResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InputScriptResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..pc<InputScript>(1, _omitFieldNames ? '' : 'inputScripts', $pb.PbFieldType.PM, subBuilder: InputScript.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InputScriptResp clone() => InputScriptResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InputScriptResp copyWith(void Function(InputScriptResp) updates) => super.copyWith((message) => updates(message as InputScriptResp)) as InputScriptResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InputScriptResp create() => InputScriptResp._();
  InputScriptResp createEmptyInstance() => create();
  static $pb.PbList<InputScriptResp> createRepeated() => $pb.PbList<InputScriptResp>();
  @$core.pragma('dart2js:noInline')
  static InputScriptResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputScriptResp>(create);
  static InputScriptResp? _defaultInstance;

  /// The set of fully valid input scripts requested.
  @$pb.TagNumber(1)
  $pb.PbList<InputScript> get inputScripts => $_getList(0);
}

class SignMessageReq extends $pb.GeneratedMessage {
  factory SignMessageReq({
    $core.List<$core.int>? msg,
    KeyLocator? keyLoc,
    $core.bool? doubleHash,
    $core.bool? compactSig,
    $core.bool? schnorrSig,
    $core.List<$core.int>? schnorrSigTapTweak,
    $core.List<$core.int>? tag,
  }) {
    final $result = create();
    if (msg != null) {
      $result.msg = msg;
    }
    if (keyLoc != null) {
      $result.keyLoc = keyLoc;
    }
    if (doubleHash != null) {
      $result.doubleHash = doubleHash;
    }
    if (compactSig != null) {
      $result.compactSig = compactSig;
    }
    if (schnorrSig != null) {
      $result.schnorrSig = schnorrSig;
    }
    if (schnorrSigTapTweak != null) {
      $result.schnorrSigTapTweak = schnorrSigTapTweak;
    }
    if (tag != null) {
      $result.tag = tag;
    }
    return $result;
  }
  SignMessageReq._() : super();
  factory SignMessageReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignMessageReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignMessageReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'msg', $pb.PbFieldType.OY)
    ..aOM<KeyLocator>(2, _omitFieldNames ? '' : 'keyLoc', subBuilder: KeyLocator.create)
    ..aOB(3, _omitFieldNames ? '' : 'doubleHash')
    ..aOB(4, _omitFieldNames ? '' : 'compactSig')
    ..aOB(5, _omitFieldNames ? '' : 'schnorrSig')
    ..a<$core.List<$core.int>>(6, _omitFieldNames ? '' : 'schnorrSigTapTweak', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'tag', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignMessageReq clone() => SignMessageReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignMessageReq copyWith(void Function(SignMessageReq) updates) => super.copyWith((message) => updates(message as SignMessageReq)) as SignMessageReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignMessageReq create() => SignMessageReq._();
  SignMessageReq createEmptyInstance() => create();
  static $pb.PbList<SignMessageReq> createRepeated() => $pb.PbList<SignMessageReq>();
  @$core.pragma('dart2js:noInline')
  static SignMessageReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignMessageReq>(create);
  static SignMessageReq? _defaultInstance;

  ///
  /// The message to be signed. When using REST, this field must be encoded as
  /// base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get msg => $_getN(0);
  @$pb.TagNumber(1)
  set msg($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);

  /// The key locator that identifies which key to use for signing.
  @$pb.TagNumber(2)
  KeyLocator get keyLoc => $_getN(1);
  @$pb.TagNumber(2)
  set keyLoc(KeyLocator v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyLoc() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyLoc() => $_clearField(2);
  @$pb.TagNumber(2)
  KeyLocator ensureKeyLoc() => $_ensure(1);

  /// Double-SHA256 hash instead of just the default single round.
  @$pb.TagNumber(3)
  $core.bool get doubleHash => $_getBF(2);
  @$pb.TagNumber(3)
  set doubleHash($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDoubleHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearDoubleHash() => $_clearField(3);

  ///
  /// Use the compact (pubkey recoverable) format instead of the raw lnwire
  /// format. This option cannot be used with Schnorr signatures.
  @$pb.TagNumber(4)
  $core.bool get compactSig => $_getBF(3);
  @$pb.TagNumber(4)
  set compactSig($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCompactSig() => $_has(3);
  @$pb.TagNumber(4)
  void clearCompactSig() => $_clearField(4);

  ///
  /// Use Schnorr signature. This option cannot be used with compact format.
  @$pb.TagNumber(5)
  $core.bool get schnorrSig => $_getBF(4);
  @$pb.TagNumber(5)
  set schnorrSig($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSchnorrSig() => $_has(4);
  @$pb.TagNumber(5)
  void clearSchnorrSig() => $_clearField(5);

  ///
  /// The optional Taproot tweak bytes to apply to the private key before creating
  /// a Schnorr signature. The private key is tweaked as described in BIP-341:
  /// privKey + h_tapTweak(internalKey || tapTweak)
  @$pb.TagNumber(6)
  $core.List<$core.int> get schnorrSigTapTweak => $_getN(5);
  @$pb.TagNumber(6)
  set schnorrSigTapTweak($core.List<$core.int> v) { $_setBytes(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSchnorrSigTapTweak() => $_has(5);
  @$pb.TagNumber(6)
  void clearSchnorrSigTapTweak() => $_clearField(6);

  ///
  /// An optional tag that can be provided when taking a tagged hash of a
  /// message. This option can only be used when schnorr_sig is true.
  @$pb.TagNumber(7)
  $core.List<$core.int> get tag => $_getN(6);
  @$pb.TagNumber(7)
  set tag($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTag() => $_has(6);
  @$pb.TagNumber(7)
  void clearTag() => $_clearField(7);
}

class SignMessageResp extends $pb.GeneratedMessage {
  factory SignMessageResp({
    $core.List<$core.int>? signature,
  }) {
    final $result = create();
    if (signature != null) {
      $result.signature = signature;
    }
    return $result;
  }
  SignMessageResp._() : super();
  factory SignMessageResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignMessageResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignMessageResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignMessageResp clone() => SignMessageResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignMessageResp copyWith(void Function(SignMessageResp) updates) => super.copyWith((message) => updates(message as SignMessageResp)) as SignMessageResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignMessageResp create() => SignMessageResp._();
  SignMessageResp createEmptyInstance() => create();
  static $pb.PbList<SignMessageResp> createRepeated() => $pb.PbList<SignMessageResp>();
  @$core.pragma('dart2js:noInline')
  static SignMessageResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignMessageResp>(create);
  static SignMessageResp? _defaultInstance;

  ///
  /// The signature for the given message in the fixed-size LN wire format.
  @$pb.TagNumber(1)
  $core.List<$core.int> get signature => $_getN(0);
  @$pb.TagNumber(1)
  set signature($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);
}

class VerifyMessageReq extends $pb.GeneratedMessage {
  factory VerifyMessageReq({
    $core.List<$core.int>? msg,
    $core.List<$core.int>? signature,
    $core.List<$core.int>? pubkey,
    $core.bool? isSchnorrSig,
    $core.List<$core.int>? tag,
  }) {
    final $result = create();
    if (msg != null) {
      $result.msg = msg;
    }
    if (signature != null) {
      $result.signature = signature;
    }
    if (pubkey != null) {
      $result.pubkey = pubkey;
    }
    if (isSchnorrSig != null) {
      $result.isSchnorrSig = isSchnorrSig;
    }
    if (tag != null) {
      $result.tag = tag;
    }
    return $result;
  }
  VerifyMessageReq._() : super();
  factory VerifyMessageReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyMessageReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyMessageReq', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'msg', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'pubkey', $pb.PbFieldType.OY)
    ..aOB(4, _omitFieldNames ? '' : 'isSchnorrSig')
    ..a<$core.List<$core.int>>(5, _omitFieldNames ? '' : 'tag', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyMessageReq clone() => VerifyMessageReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyMessageReq copyWith(void Function(VerifyMessageReq) updates) => super.copyWith((message) => updates(message as VerifyMessageReq)) as VerifyMessageReq;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyMessageReq create() => VerifyMessageReq._();
  VerifyMessageReq createEmptyInstance() => create();
  static $pb.PbList<VerifyMessageReq> createRepeated() => $pb.PbList<VerifyMessageReq>();
  @$core.pragma('dart2js:noInline')
  static VerifyMessageReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyMessageReq>(create);
  static VerifyMessageReq? _defaultInstance;

  /// The message over which the signature is to be verified. When using
  /// REST, this field must be encoded as base64.
  @$pb.TagNumber(1)
  $core.List<$core.int> get msg => $_getN(0);
  @$pb.TagNumber(1)
  set msg($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsg() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsg() => $_clearField(1);

  ///
  /// The fixed-size LN wire encoded signature to be verified over the given
  /// message. When using REST, this field must be encoded as base64.
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);

  ///
  /// The public key the signature has to be valid for. When using REST, this
  /// field must be encoded as base64. If the is_schnorr_sig option is true, then
  /// the public key is expected to be in the 32-byte x-only serialization
  /// according to BIP-340.
  @$pb.TagNumber(3)
  $core.List<$core.int> get pubkey => $_getN(2);
  @$pb.TagNumber(3)
  set pubkey($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPubkey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPubkey() => $_clearField(3);

  ///
  /// Specifies if the signature is a Schnorr signature.
  @$pb.TagNumber(4)
  $core.bool get isSchnorrSig => $_getBF(3);
  @$pb.TagNumber(4)
  set isSchnorrSig($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsSchnorrSig() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsSchnorrSig() => $_clearField(4);

  ///
  /// An optional tag that can be provided when taking a tagged hash of a
  /// message. This option can only be used when is_schnorr_sig is true.
  @$pb.TagNumber(5)
  $core.List<$core.int> get tag => $_getN(4);
  @$pb.TagNumber(5)
  set tag($core.List<$core.int> v) { $_setBytes(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTag() => $_has(4);
  @$pb.TagNumber(5)
  void clearTag() => $_clearField(5);
}

class VerifyMessageResp extends $pb.GeneratedMessage {
  factory VerifyMessageResp({
    $core.bool? valid,
  }) {
    final $result = create();
    if (valid != null) {
      $result.valid = valid;
    }
    return $result;
  }
  VerifyMessageResp._() : super();
  factory VerifyMessageResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyMessageResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyMessageResp', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyMessageResp clone() => VerifyMessageResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyMessageResp copyWith(void Function(VerifyMessageResp) updates) => super.copyWith((message) => updates(message as VerifyMessageResp)) as VerifyMessageResp;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyMessageResp create() => VerifyMessageResp._();
  VerifyMessageResp createEmptyInstance() => create();
  static $pb.PbList<VerifyMessageResp> createRepeated() => $pb.PbList<VerifyMessageResp>();
  @$core.pragma('dart2js:noInline')
  static VerifyMessageResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyMessageResp>(create);
  static VerifyMessageResp? _defaultInstance;

  /// Whether the signature was valid over the given message.
  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);
}

class SharedKeyRequest extends $pb.GeneratedMessage {
  factory SharedKeyRequest({
    $core.List<$core.int>? ephemeralPubkey,
  @$core.Deprecated('This field is deprecated.')
    KeyLocator? keyLoc,
    KeyDescriptor? keyDesc,
  }) {
    final $result = create();
    if (ephemeralPubkey != null) {
      $result.ephemeralPubkey = ephemeralPubkey;
    }
    if (keyLoc != null) {
      // ignore: deprecated_member_use_from_same_package
      $result.keyLoc = keyLoc;
    }
    if (keyDesc != null) {
      $result.keyDesc = keyDesc;
    }
    return $result;
  }
  SharedKeyRequest._() : super();
  factory SharedKeyRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SharedKeyRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SharedKeyRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'ephemeralPubkey', $pb.PbFieldType.OY)
    ..aOM<KeyLocator>(2, _omitFieldNames ? '' : 'keyLoc', subBuilder: KeyLocator.create)
    ..aOM<KeyDescriptor>(3, _omitFieldNames ? '' : 'keyDesc', subBuilder: KeyDescriptor.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SharedKeyRequest clone() => SharedKeyRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SharedKeyRequest copyWith(void Function(SharedKeyRequest) updates) => super.copyWith((message) => updates(message as SharedKeyRequest)) as SharedKeyRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SharedKeyRequest create() => SharedKeyRequest._();
  SharedKeyRequest createEmptyInstance() => create();
  static $pb.PbList<SharedKeyRequest> createRepeated() => $pb.PbList<SharedKeyRequest>();
  @$core.pragma('dart2js:noInline')
  static SharedKeyRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SharedKeyRequest>(create);
  static SharedKeyRequest? _defaultInstance;

  /// The ephemeral public key to use for the DH key derivation.
  @$pb.TagNumber(1)
  $core.List<$core.int> get ephemeralPubkey => $_getN(0);
  @$pb.TagNumber(1)
  set ephemeralPubkey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEphemeralPubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearEphemeralPubkey() => $_clearField(1);

  ///
  /// Deprecated. The optional key locator of the local key that should be used.
  /// If this parameter is not set then the node's identity private key will be
  /// used.
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  KeyLocator get keyLoc => $_getN(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  set keyLoc(KeyLocator v) { $_setField(2, v); }
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  $core.bool hasKeyLoc() => $_has(1);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  void clearKeyLoc() => $_clearField(2);
  @$core.Deprecated('This field is deprecated.')
  @$pb.TagNumber(2)
  KeyLocator ensureKeyLoc() => $_ensure(1);

  ///
  /// A key descriptor describes the key used for performing ECDH. Either a key
  /// locator or a raw public key is expected, if neither is supplied, defaults to
  /// the node's identity private key.
  @$pb.TagNumber(3)
  KeyDescriptor get keyDesc => $_getN(2);
  @$pb.TagNumber(3)
  set keyDesc(KeyDescriptor v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasKeyDesc() => $_has(2);
  @$pb.TagNumber(3)
  void clearKeyDesc() => $_clearField(3);
  @$pb.TagNumber(3)
  KeyDescriptor ensureKeyDesc() => $_ensure(2);
}

class SharedKeyResponse extends $pb.GeneratedMessage {
  factory SharedKeyResponse({
    $core.List<$core.int>? sharedKey,
  }) {
    final $result = create();
    if (sharedKey != null) {
      $result.sharedKey = sharedKey;
    }
    return $result;
  }
  SharedKeyResponse._() : super();
  factory SharedKeyResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SharedKeyResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SharedKeyResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'sharedKey', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SharedKeyResponse clone() => SharedKeyResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SharedKeyResponse copyWith(void Function(SharedKeyResponse) updates) => super.copyWith((message) => updates(message as SharedKeyResponse)) as SharedKeyResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SharedKeyResponse create() => SharedKeyResponse._();
  SharedKeyResponse createEmptyInstance() => create();
  static $pb.PbList<SharedKeyResponse> createRepeated() => $pb.PbList<SharedKeyResponse>();
  @$core.pragma('dart2js:noInline')
  static SharedKeyResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SharedKeyResponse>(create);
  static SharedKeyResponse? _defaultInstance;

  /// The shared public key, hashed with sha256.
  @$pb.TagNumber(1)
  $core.List<$core.int> get sharedKey => $_getN(0);
  @$pb.TagNumber(1)
  set sharedKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSharedKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearSharedKey() => $_clearField(1);
}

class TweakDesc extends $pb.GeneratedMessage {
  factory TweakDesc({
    $core.List<$core.int>? tweak,
    $core.bool? isXOnly,
  }) {
    final $result = create();
    if (tweak != null) {
      $result.tweak = tweak;
    }
    if (isXOnly != null) {
      $result.isXOnly = isXOnly;
    }
    return $result;
  }
  TweakDesc._() : super();
  factory TweakDesc.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TweakDesc.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TweakDesc', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'tweak', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'isXOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TweakDesc clone() => TweakDesc()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TweakDesc copyWith(void Function(TweakDesc) updates) => super.copyWith((message) => updates(message as TweakDesc)) as TweakDesc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TweakDesc create() => TweakDesc._();
  TweakDesc createEmptyInstance() => create();
  static $pb.PbList<TweakDesc> createRepeated() => $pb.PbList<TweakDesc>();
  @$core.pragma('dart2js:noInline')
  static TweakDesc getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TweakDesc>(create);
  static TweakDesc? _defaultInstance;

  ///
  /// Tweak is the 32-byte value that will modify the public key.
  @$pb.TagNumber(1)
  $core.List<$core.int> get tweak => $_getN(0);
  @$pb.TagNumber(1)
  set tweak($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTweak() => $_has(0);
  @$pb.TagNumber(1)
  void clearTweak() => $_clearField(1);

  ///
  /// Specifies if the target key should be converted to an x-only public key
  /// before tweaking. If true, then the public key will be mapped to an x-only
  /// key before the tweaking operation is applied.
  @$pb.TagNumber(2)
  $core.bool get isXOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set isXOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsXOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsXOnly() => $_clearField(2);
}

class TaprootTweakDesc extends $pb.GeneratedMessage {
  factory TaprootTweakDesc({
    $core.List<$core.int>? scriptRoot,
    $core.bool? keySpendOnly,
  }) {
    final $result = create();
    if (scriptRoot != null) {
      $result.scriptRoot = scriptRoot;
    }
    if (keySpendOnly != null) {
      $result.keySpendOnly = keySpendOnly;
    }
    return $result;
  }
  TaprootTweakDesc._() : super();
  factory TaprootTweakDesc.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TaprootTweakDesc.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TaprootTweakDesc', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'scriptRoot', $pb.PbFieldType.OY)
    ..aOB(2, _omitFieldNames ? '' : 'keySpendOnly')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TaprootTweakDesc clone() => TaprootTweakDesc()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TaprootTweakDesc copyWith(void Function(TaprootTweakDesc) updates) => super.copyWith((message) => updates(message as TaprootTweakDesc)) as TaprootTweakDesc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TaprootTweakDesc create() => TaprootTweakDesc._();
  TaprootTweakDesc createEmptyInstance() => create();
  static $pb.PbList<TaprootTweakDesc> createRepeated() => $pb.PbList<TaprootTweakDesc>();
  @$core.pragma('dart2js:noInline')
  static TaprootTweakDesc getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TaprootTweakDesc>(create);
  static TaprootTweakDesc? _defaultInstance;

  ///
  /// The root hash of the tapscript tree if a script path is committed to. If
  /// the MuSig2 key put on chain doesn't also commit to a script path (BIP-0086
  /// key spend only), then this needs to be empty and the key_spend_only field
  /// below must be set to true. This is required because gRPC cannot
  /// differentiate between a zero-size byte slice and a nil byte slice (both
  /// would be serialized the same way). So the extra boolean is required.
  @$pb.TagNumber(1)
  $core.List<$core.int> get scriptRoot => $_getN(0);
  @$pb.TagNumber(1)
  set scriptRoot($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScriptRoot() => $_has(0);
  @$pb.TagNumber(1)
  void clearScriptRoot() => $_clearField(1);

  ///
  /// Indicates that the above script_root is expected to be empty because this
  /// is a BIP-0086 key spend only commitment where only the internal key is
  /// committed to instead of also including a script root hash.
  @$pb.TagNumber(2)
  $core.bool get keySpendOnly => $_getBF(1);
  @$pb.TagNumber(2)
  set keySpendOnly($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeySpendOnly() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeySpendOnly() => $_clearField(2);
}

class MuSig2CombineKeysRequest extends $pb.GeneratedMessage {
  factory MuSig2CombineKeysRequest({
    $core.Iterable<$core.List<$core.int>>? allSignerPubkeys,
    $core.Iterable<TweakDesc>? tweaks,
    TaprootTweakDesc? taprootTweak,
    MuSig2Version? version,
  }) {
    final $result = create();
    if (allSignerPubkeys != null) {
      $result.allSignerPubkeys.addAll(allSignerPubkeys);
    }
    if (tweaks != null) {
      $result.tweaks.addAll(tweaks);
    }
    if (taprootTweak != null) {
      $result.taprootTweak = taprootTweak;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  MuSig2CombineKeysRequest._() : super();
  factory MuSig2CombineKeysRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2CombineKeysRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2CombineKeysRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..p<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'allSignerPubkeys', $pb.PbFieldType.PY)
    ..pc<TweakDesc>(2, _omitFieldNames ? '' : 'tweaks', $pb.PbFieldType.PM, subBuilder: TweakDesc.create)
    ..aOM<TaprootTweakDesc>(3, _omitFieldNames ? '' : 'taprootTweak', subBuilder: TaprootTweakDesc.create)
    ..e<MuSig2Version>(4, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OE, defaultOrMaker: MuSig2Version.MUSIG2_VERSION_UNDEFINED, valueOf: MuSig2Version.valueOf, enumValues: MuSig2Version.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2CombineKeysRequest clone() => MuSig2CombineKeysRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2CombineKeysRequest copyWith(void Function(MuSig2CombineKeysRequest) updates) => super.copyWith((message) => updates(message as MuSig2CombineKeysRequest)) as MuSig2CombineKeysRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2CombineKeysRequest create() => MuSig2CombineKeysRequest._();
  MuSig2CombineKeysRequest createEmptyInstance() => create();
  static $pb.PbList<MuSig2CombineKeysRequest> createRepeated() => $pb.PbList<MuSig2CombineKeysRequest>();
  @$core.pragma('dart2js:noInline')
  static MuSig2CombineKeysRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2CombineKeysRequest>(create);
  static MuSig2CombineKeysRequest? _defaultInstance;

  ///
  /// A list of all public keys (serialized in 32-byte x-only format for v0.4.0
  /// and 33-byte compressed format for v1.0.0rc2!) participating in the signing
  /// session. The list will always be sorted lexicographically internally. This
  /// must include the local key which is described by the above key_loc.
  @$pb.TagNumber(1)
  $pb.PbList<$core.List<$core.int>> get allSignerPubkeys => $_getList(0);

  ///
  /// A series of optional generic tweaks to be applied to the aggregated
  /// public key.
  @$pb.TagNumber(2)
  $pb.PbList<TweakDesc> get tweaks => $_getList(1);

  ///
  /// An optional taproot specific tweak that must be specified if the MuSig2
  /// combined key will be used as the main taproot key of a taproot output
  /// on-chain.
  @$pb.TagNumber(3)
  TaprootTweakDesc get taprootTweak => $_getN(2);
  @$pb.TagNumber(3)
  set taprootTweak(TaprootTweakDesc v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTaprootTweak() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaprootTweak() => $_clearField(3);
  @$pb.TagNumber(3)
  TaprootTweakDesc ensureTaprootTweak() => $_ensure(2);

  ///
  /// The mandatory version of the MuSig2 BIP draft to use. This is necessary to
  /// differentiate between the changes that were made to the BIP while this
  /// experimental RPC was already released. Some of those changes affect how the
  /// combined key and nonces are created.
  @$pb.TagNumber(4)
  MuSig2Version get version => $_getN(3);
  @$pb.TagNumber(4)
  set version(MuSig2Version v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearVersion() => $_clearField(4);
}

class MuSig2CombineKeysResponse extends $pb.GeneratedMessage {
  factory MuSig2CombineKeysResponse({
    $core.List<$core.int>? combinedKey,
    $core.List<$core.int>? taprootInternalKey,
    MuSig2Version? version,
  }) {
    final $result = create();
    if (combinedKey != null) {
      $result.combinedKey = combinedKey;
    }
    if (taprootInternalKey != null) {
      $result.taprootInternalKey = taprootInternalKey;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  MuSig2CombineKeysResponse._() : super();
  factory MuSig2CombineKeysResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2CombineKeysResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2CombineKeysResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'combinedKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'taprootInternalKey', $pb.PbFieldType.OY)
    ..e<MuSig2Version>(4, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OE, defaultOrMaker: MuSig2Version.MUSIG2_VERSION_UNDEFINED, valueOf: MuSig2Version.valueOf, enumValues: MuSig2Version.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2CombineKeysResponse clone() => MuSig2CombineKeysResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2CombineKeysResponse copyWith(void Function(MuSig2CombineKeysResponse) updates) => super.copyWith((message) => updates(message as MuSig2CombineKeysResponse)) as MuSig2CombineKeysResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2CombineKeysResponse create() => MuSig2CombineKeysResponse._();
  MuSig2CombineKeysResponse createEmptyInstance() => create();
  static $pb.PbList<MuSig2CombineKeysResponse> createRepeated() => $pb.PbList<MuSig2CombineKeysResponse>();
  @$core.pragma('dart2js:noInline')
  static MuSig2CombineKeysResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2CombineKeysResponse>(create);
  static MuSig2CombineKeysResponse? _defaultInstance;

  ///
  /// The combined public key (in the 32-byte x-only format) with all tweaks
  /// applied to it. If a taproot tweak is specified, this corresponds to the
  /// taproot key that can be put into the on-chain output.
  @$pb.TagNumber(1)
  $core.List<$core.int> get combinedKey => $_getN(0);
  @$pb.TagNumber(1)
  set combinedKey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCombinedKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearCombinedKey() => $_clearField(1);

  ///
  /// The raw combined public key (in the 32-byte x-only format) before any tweaks
  /// are applied to it. If a taproot tweak is specified, this corresponds to the
  /// internal key that needs to be put into the witness if the script spend path
  /// is used.
  @$pb.TagNumber(2)
  $core.List<$core.int> get taprootInternalKey => $_getN(1);
  @$pb.TagNumber(2)
  set taprootInternalKey($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTaprootInternalKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearTaprootInternalKey() => $_clearField(2);

  ///
  /// The version of the MuSig2 BIP that was used to combine the keys.
  @$pb.TagNumber(4)
  MuSig2Version get version => $_getN(2);
  @$pb.TagNumber(4)
  set version(MuSig2Version v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(4)
  void clearVersion() => $_clearField(4);
}

class MuSig2SessionRequest extends $pb.GeneratedMessage {
  factory MuSig2SessionRequest({
    KeyLocator? keyLoc,
    $core.Iterable<$core.List<$core.int>>? allSignerPubkeys,
    $core.Iterable<$core.List<$core.int>>? otherSignerPublicNonces,
    $core.Iterable<TweakDesc>? tweaks,
    TaprootTweakDesc? taprootTweak,
    MuSig2Version? version,
    $core.List<$core.int>? pregeneratedLocalNonce,
  }) {
    final $result = create();
    if (keyLoc != null) {
      $result.keyLoc = keyLoc;
    }
    if (allSignerPubkeys != null) {
      $result.allSignerPubkeys.addAll(allSignerPubkeys);
    }
    if (otherSignerPublicNonces != null) {
      $result.otherSignerPublicNonces.addAll(otherSignerPublicNonces);
    }
    if (tweaks != null) {
      $result.tweaks.addAll(tweaks);
    }
    if (taprootTweak != null) {
      $result.taprootTweak = taprootTweak;
    }
    if (version != null) {
      $result.version = version;
    }
    if (pregeneratedLocalNonce != null) {
      $result.pregeneratedLocalNonce = pregeneratedLocalNonce;
    }
    return $result;
  }
  MuSig2SessionRequest._() : super();
  factory MuSig2SessionRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2SessionRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2SessionRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..aOM<KeyLocator>(1, _omitFieldNames ? '' : 'keyLoc', subBuilder: KeyLocator.create)
    ..p<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'allSignerPubkeys', $pb.PbFieldType.PY)
    ..p<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'otherSignerPublicNonces', $pb.PbFieldType.PY)
    ..pc<TweakDesc>(4, _omitFieldNames ? '' : 'tweaks', $pb.PbFieldType.PM, subBuilder: TweakDesc.create)
    ..aOM<TaprootTweakDesc>(5, _omitFieldNames ? '' : 'taprootTweak', subBuilder: TaprootTweakDesc.create)
    ..e<MuSig2Version>(6, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OE, defaultOrMaker: MuSig2Version.MUSIG2_VERSION_UNDEFINED, valueOf: MuSig2Version.valueOf, enumValues: MuSig2Version.values)
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'pregeneratedLocalNonce', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2SessionRequest clone() => MuSig2SessionRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2SessionRequest copyWith(void Function(MuSig2SessionRequest) updates) => super.copyWith((message) => updates(message as MuSig2SessionRequest)) as MuSig2SessionRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2SessionRequest create() => MuSig2SessionRequest._();
  MuSig2SessionRequest createEmptyInstance() => create();
  static $pb.PbList<MuSig2SessionRequest> createRepeated() => $pb.PbList<MuSig2SessionRequest>();
  @$core.pragma('dart2js:noInline')
  static MuSig2SessionRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2SessionRequest>(create);
  static MuSig2SessionRequest? _defaultInstance;

  ///
  /// The key locator that identifies which key to use for signing.
  @$pb.TagNumber(1)
  KeyLocator get keyLoc => $_getN(0);
  @$pb.TagNumber(1)
  set keyLoc(KeyLocator v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasKeyLoc() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyLoc() => $_clearField(1);
  @$pb.TagNumber(1)
  KeyLocator ensureKeyLoc() => $_ensure(0);

  ///
  /// A list of all public keys (serialized in 32-byte x-only format for v0.4.0
  /// and 33-byte compressed format for v1.0.0rc2!) participating in the signing
  /// session. The list will always be sorted lexicographically internally. This
  /// must include the local key which is described by the above key_loc.
  @$pb.TagNumber(2)
  $pb.PbList<$core.List<$core.int>> get allSignerPubkeys => $_getList(1);

  ///
  /// An optional list of all public nonces of other signing participants that
  /// might already be known.
  @$pb.TagNumber(3)
  $pb.PbList<$core.List<$core.int>> get otherSignerPublicNonces => $_getList(2);

  ///
  /// A series of optional generic tweaks to be applied to the aggregated
  /// public key.
  @$pb.TagNumber(4)
  $pb.PbList<TweakDesc> get tweaks => $_getList(3);

  ///
  /// An optional taproot specific tweak that must be specified if the MuSig2
  /// combined key will be used as the main taproot key of a taproot output
  /// on-chain.
  @$pb.TagNumber(5)
  TaprootTweakDesc get taprootTweak => $_getN(4);
  @$pb.TagNumber(5)
  set taprootTweak(TaprootTweakDesc v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTaprootTweak() => $_has(4);
  @$pb.TagNumber(5)
  void clearTaprootTweak() => $_clearField(5);
  @$pb.TagNumber(5)
  TaprootTweakDesc ensureTaprootTweak() => $_ensure(4);

  ///
  /// The mandatory version of the MuSig2 BIP draft to use. This is necessary to
  /// differentiate between the changes that were made to the BIP while this
  /// experimental RPC was already released. Some of those changes affect how the
  /// combined key and nonces are created.
  @$pb.TagNumber(6)
  MuSig2Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version(MuSig2Version v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);

  ///
  /// A set of pre generated secret local nonces to use in the musig2 session.
  /// This field is optional. This can be useful for protocols that need to send
  /// nonces ahead of time before the set of signer keys are known. This value
  /// MUST be 97 bytes and be the concatenation of two CSPRNG generated 32 byte
  /// values and local public key used for signing as specified in the key_loc
  /// field.
  @$pb.TagNumber(7)
  $core.List<$core.int> get pregeneratedLocalNonce => $_getN(6);
  @$pb.TagNumber(7)
  set pregeneratedLocalNonce($core.List<$core.int> v) { $_setBytes(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasPregeneratedLocalNonce() => $_has(6);
  @$pb.TagNumber(7)
  void clearPregeneratedLocalNonce() => $_clearField(7);
}

class MuSig2SessionResponse extends $pb.GeneratedMessage {
  factory MuSig2SessionResponse({
    $core.List<$core.int>? sessionId,
    $core.List<$core.int>? combinedKey,
    $core.List<$core.int>? taprootInternalKey,
    $core.List<$core.int>? localPublicNonces,
    $core.bool? haveAllNonces,
    MuSig2Version? version,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (combinedKey != null) {
      $result.combinedKey = combinedKey;
    }
    if (taprootInternalKey != null) {
      $result.taprootInternalKey = taprootInternalKey;
    }
    if (localPublicNonces != null) {
      $result.localPublicNonces = localPublicNonces;
    }
    if (haveAllNonces != null) {
      $result.haveAllNonces = haveAllNonces;
    }
    if (version != null) {
      $result.version = version;
    }
    return $result;
  }
  MuSig2SessionResponse._() : super();
  factory MuSig2SessionResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2SessionResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2SessionResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'sessionId', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'combinedKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'taprootInternalKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(4, _omitFieldNames ? '' : 'localPublicNonces', $pb.PbFieldType.OY)
    ..aOB(5, _omitFieldNames ? '' : 'haveAllNonces')
    ..e<MuSig2Version>(6, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OE, defaultOrMaker: MuSig2Version.MUSIG2_VERSION_UNDEFINED, valueOf: MuSig2Version.valueOf, enumValues: MuSig2Version.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2SessionResponse clone() => MuSig2SessionResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2SessionResponse copyWith(void Function(MuSig2SessionResponse) updates) => super.copyWith((message) => updates(message as MuSig2SessionResponse)) as MuSig2SessionResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2SessionResponse create() => MuSig2SessionResponse._();
  MuSig2SessionResponse createEmptyInstance() => create();
  static $pb.PbList<MuSig2SessionResponse> createRepeated() => $pb.PbList<MuSig2SessionResponse>();
  @$core.pragma('dart2js:noInline')
  static MuSig2SessionResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2SessionResponse>(create);
  static MuSig2SessionResponse? _defaultInstance;

  ///
  /// The unique ID that represents this signing session. A session can be used
  /// for producing a signature a single time. If the signing fails for any
  /// reason, a new session with the same participants needs to be created.
  @$pb.TagNumber(1)
  $core.List<$core.int> get sessionId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  ///
  /// The combined public key (in the 32-byte x-only format) with all tweaks
  /// applied to it. If a taproot tweak is specified, this corresponds to the
  /// taproot key that can be put into the on-chain output.
  @$pb.TagNumber(2)
  $core.List<$core.int> get combinedKey => $_getN(1);
  @$pb.TagNumber(2)
  set combinedKey($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCombinedKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearCombinedKey() => $_clearField(2);

  ///
  /// The raw combined public key (in the 32-byte x-only format) before any tweaks
  /// are applied to it. If a taproot tweak is specified, this corresponds to the
  /// internal key that needs to be put into the witness if the script spend path
  /// is used.
  @$pb.TagNumber(3)
  $core.List<$core.int> get taprootInternalKey => $_getN(2);
  @$pb.TagNumber(3)
  set taprootInternalKey($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTaprootInternalKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearTaprootInternalKey() => $_clearField(3);

  ///
  /// The two public nonces the local signer uses, combined into a single value
  /// of 66 bytes. Can be split into the two 33-byte points to get the individual
  /// nonces.
  @$pb.TagNumber(4)
  $core.List<$core.int> get localPublicNonces => $_getN(3);
  @$pb.TagNumber(4)
  set localPublicNonces($core.List<$core.int> v) { $_setBytes(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLocalPublicNonces() => $_has(3);
  @$pb.TagNumber(4)
  void clearLocalPublicNonces() => $_clearField(4);

  ///
  /// Indicates whether all nonces required to start the signing process are known
  /// now.
  @$pb.TagNumber(5)
  $core.bool get haveAllNonces => $_getBF(4);
  @$pb.TagNumber(5)
  set haveAllNonces($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHaveAllNonces() => $_has(4);
  @$pb.TagNumber(5)
  void clearHaveAllNonces() => $_clearField(5);

  ///
  /// The version of the MuSig2 BIP that was used to create the session.
  @$pb.TagNumber(6)
  MuSig2Version get version => $_getN(5);
  @$pb.TagNumber(6)
  set version(MuSig2Version v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearVersion() => $_clearField(6);
}

class MuSig2RegisterNoncesRequest extends $pb.GeneratedMessage {
  factory MuSig2RegisterNoncesRequest({
    $core.List<$core.int>? sessionId,
    $core.Iterable<$core.List<$core.int>>? otherSignerPublicNonces,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (otherSignerPublicNonces != null) {
      $result.otherSignerPublicNonces.addAll(otherSignerPublicNonces);
    }
    return $result;
  }
  MuSig2RegisterNoncesRequest._() : super();
  factory MuSig2RegisterNoncesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2RegisterNoncesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2RegisterNoncesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'sessionId', $pb.PbFieldType.OY)
    ..p<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'otherSignerPublicNonces', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2RegisterNoncesRequest clone() => MuSig2RegisterNoncesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2RegisterNoncesRequest copyWith(void Function(MuSig2RegisterNoncesRequest) updates) => super.copyWith((message) => updates(message as MuSig2RegisterNoncesRequest)) as MuSig2RegisterNoncesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2RegisterNoncesRequest create() => MuSig2RegisterNoncesRequest._();
  MuSig2RegisterNoncesRequest createEmptyInstance() => create();
  static $pb.PbList<MuSig2RegisterNoncesRequest> createRepeated() => $pb.PbList<MuSig2RegisterNoncesRequest>();
  @$core.pragma('dart2js:noInline')
  static MuSig2RegisterNoncesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2RegisterNoncesRequest>(create);
  static MuSig2RegisterNoncesRequest? _defaultInstance;

  ///
  /// The unique ID of the signing session those nonces should be registered with.
  @$pb.TagNumber(1)
  $core.List<$core.int> get sessionId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  ///
  /// A list of all public nonces of other signing participants that should be
  /// registered.
  @$pb.TagNumber(3)
  $pb.PbList<$core.List<$core.int>> get otherSignerPublicNonces => $_getList(1);
}

class MuSig2RegisterNoncesResponse extends $pb.GeneratedMessage {
  factory MuSig2RegisterNoncesResponse({
    $core.bool? haveAllNonces,
  }) {
    final $result = create();
    if (haveAllNonces != null) {
      $result.haveAllNonces = haveAllNonces;
    }
    return $result;
  }
  MuSig2RegisterNoncesResponse._() : super();
  factory MuSig2RegisterNoncesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2RegisterNoncesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2RegisterNoncesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'haveAllNonces')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2RegisterNoncesResponse clone() => MuSig2RegisterNoncesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2RegisterNoncesResponse copyWith(void Function(MuSig2RegisterNoncesResponse) updates) => super.copyWith((message) => updates(message as MuSig2RegisterNoncesResponse)) as MuSig2RegisterNoncesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2RegisterNoncesResponse create() => MuSig2RegisterNoncesResponse._();
  MuSig2RegisterNoncesResponse createEmptyInstance() => create();
  static $pb.PbList<MuSig2RegisterNoncesResponse> createRepeated() => $pb.PbList<MuSig2RegisterNoncesResponse>();
  @$core.pragma('dart2js:noInline')
  static MuSig2RegisterNoncesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2RegisterNoncesResponse>(create);
  static MuSig2RegisterNoncesResponse? _defaultInstance;

  ///
  /// Indicates whether all nonces required to start the signing process are known
  /// now.
  @$pb.TagNumber(1)
  $core.bool get haveAllNonces => $_getBF(0);
  @$pb.TagNumber(1)
  set haveAllNonces($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHaveAllNonces() => $_has(0);
  @$pb.TagNumber(1)
  void clearHaveAllNonces() => $_clearField(1);
}

class MuSig2SignRequest extends $pb.GeneratedMessage {
  factory MuSig2SignRequest({
    $core.List<$core.int>? sessionId,
    $core.List<$core.int>? messageDigest,
    $core.bool? cleanup,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (messageDigest != null) {
      $result.messageDigest = messageDigest;
    }
    if (cleanup != null) {
      $result.cleanup = cleanup;
    }
    return $result;
  }
  MuSig2SignRequest._() : super();
  factory MuSig2SignRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2SignRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2SignRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'sessionId', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'messageDigest', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'cleanup')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2SignRequest clone() => MuSig2SignRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2SignRequest copyWith(void Function(MuSig2SignRequest) updates) => super.copyWith((message) => updates(message as MuSig2SignRequest)) as MuSig2SignRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2SignRequest create() => MuSig2SignRequest._();
  MuSig2SignRequest createEmptyInstance() => create();
  static $pb.PbList<MuSig2SignRequest> createRepeated() => $pb.PbList<MuSig2SignRequest>();
  @$core.pragma('dart2js:noInline')
  static MuSig2SignRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2SignRequest>(create);
  static MuSig2SignRequest? _defaultInstance;

  ///
  /// The unique ID of the signing session to use for signing.
  @$pb.TagNumber(1)
  $core.List<$core.int> get sessionId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  ///
  /// The 32-byte SHA256 digest of the message to sign.
  @$pb.TagNumber(2)
  $core.List<$core.int> get messageDigest => $_getN(1);
  @$pb.TagNumber(2)
  set messageDigest($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMessageDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessageDigest() => $_clearField(2);

  ///
  /// Cleanup indicates that after signing, the session state can be cleaned up,
  /// since another participant is going to be responsible for combining the
  /// partial signatures.
  @$pb.TagNumber(3)
  $core.bool get cleanup => $_getBF(2);
  @$pb.TagNumber(3)
  set cleanup($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCleanup() => $_has(2);
  @$pb.TagNumber(3)
  void clearCleanup() => $_clearField(3);
}

class MuSig2SignResponse extends $pb.GeneratedMessage {
  factory MuSig2SignResponse({
    $core.List<$core.int>? localPartialSignature,
  }) {
    final $result = create();
    if (localPartialSignature != null) {
      $result.localPartialSignature = localPartialSignature;
    }
    return $result;
  }
  MuSig2SignResponse._() : super();
  factory MuSig2SignResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2SignResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2SignResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'localPartialSignature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2SignResponse clone() => MuSig2SignResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2SignResponse copyWith(void Function(MuSig2SignResponse) updates) => super.copyWith((message) => updates(message as MuSig2SignResponse)) as MuSig2SignResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2SignResponse create() => MuSig2SignResponse._();
  MuSig2SignResponse createEmptyInstance() => create();
  static $pb.PbList<MuSig2SignResponse> createRepeated() => $pb.PbList<MuSig2SignResponse>();
  @$core.pragma('dart2js:noInline')
  static MuSig2SignResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2SignResponse>(create);
  static MuSig2SignResponse? _defaultInstance;

  ///
  /// The partial signature created by the local signer.
  @$pb.TagNumber(1)
  $core.List<$core.int> get localPartialSignature => $_getN(0);
  @$pb.TagNumber(1)
  set localPartialSignature($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLocalPartialSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocalPartialSignature() => $_clearField(1);
}

class MuSig2CombineSigRequest extends $pb.GeneratedMessage {
  factory MuSig2CombineSigRequest({
    $core.List<$core.int>? sessionId,
    $core.Iterable<$core.List<$core.int>>? otherPartialSignatures,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    if (otherPartialSignatures != null) {
      $result.otherPartialSignatures.addAll(otherPartialSignatures);
    }
    return $result;
  }
  MuSig2CombineSigRequest._() : super();
  factory MuSig2CombineSigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2CombineSigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2CombineSigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'sessionId', $pb.PbFieldType.OY)
    ..p<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'otherPartialSignatures', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2CombineSigRequest clone() => MuSig2CombineSigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2CombineSigRequest copyWith(void Function(MuSig2CombineSigRequest) updates) => super.copyWith((message) => updates(message as MuSig2CombineSigRequest)) as MuSig2CombineSigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2CombineSigRequest create() => MuSig2CombineSigRequest._();
  MuSig2CombineSigRequest createEmptyInstance() => create();
  static $pb.PbList<MuSig2CombineSigRequest> createRepeated() => $pb.PbList<MuSig2CombineSigRequest>();
  @$core.pragma('dart2js:noInline')
  static MuSig2CombineSigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2CombineSigRequest>(create);
  static MuSig2CombineSigRequest? _defaultInstance;

  ///
  /// The unique ID of the signing session to combine the signatures for.
  @$pb.TagNumber(1)
  $core.List<$core.int> get sessionId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);

  ///
  /// The list of all other participants' partial signatures to add to the current
  /// session.
  @$pb.TagNumber(2)
  $pb.PbList<$core.List<$core.int>> get otherPartialSignatures => $_getList(1);
}

class MuSig2CombineSigResponse extends $pb.GeneratedMessage {
  factory MuSig2CombineSigResponse({
    $core.bool? haveAllSignatures,
    $core.List<$core.int>? finalSignature,
  }) {
    final $result = create();
    if (haveAllSignatures != null) {
      $result.haveAllSignatures = haveAllSignatures;
    }
    if (finalSignature != null) {
      $result.finalSignature = finalSignature;
    }
    return $result;
  }
  MuSig2CombineSigResponse._() : super();
  factory MuSig2CombineSigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2CombineSigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2CombineSigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'haveAllSignatures')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'finalSignature', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2CombineSigResponse clone() => MuSig2CombineSigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2CombineSigResponse copyWith(void Function(MuSig2CombineSigResponse) updates) => super.copyWith((message) => updates(message as MuSig2CombineSigResponse)) as MuSig2CombineSigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2CombineSigResponse create() => MuSig2CombineSigResponse._();
  MuSig2CombineSigResponse createEmptyInstance() => create();
  static $pb.PbList<MuSig2CombineSigResponse> createRepeated() => $pb.PbList<MuSig2CombineSigResponse>();
  @$core.pragma('dart2js:noInline')
  static MuSig2CombineSigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2CombineSigResponse>(create);
  static MuSig2CombineSigResponse? _defaultInstance;

  ///
  /// Indicates whether all partial signatures required to create a final, full
  /// signature are known yet. If this is true, then the final_signature field is
  /// set, otherwise it is empty.
  @$pb.TagNumber(1)
  $core.bool get haveAllSignatures => $_getBF(0);
  @$pb.TagNumber(1)
  set haveAllSignatures($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHaveAllSignatures() => $_has(0);
  @$pb.TagNumber(1)
  void clearHaveAllSignatures() => $_clearField(1);

  ///
  /// The final, full signature that is valid for the combined public key.
  @$pb.TagNumber(2)
  $core.List<$core.int> get finalSignature => $_getN(1);
  @$pb.TagNumber(2)
  set finalSignature($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFinalSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearFinalSignature() => $_clearField(2);
}

class MuSig2CleanupRequest extends $pb.GeneratedMessage {
  factory MuSig2CleanupRequest({
    $core.List<$core.int>? sessionId,
  }) {
    final $result = create();
    if (sessionId != null) {
      $result.sessionId = sessionId;
    }
    return $result;
  }
  MuSig2CleanupRequest._() : super();
  factory MuSig2CleanupRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2CleanupRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2CleanupRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'sessionId', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2CleanupRequest clone() => MuSig2CleanupRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2CleanupRequest copyWith(void Function(MuSig2CleanupRequest) updates) => super.copyWith((message) => updates(message as MuSig2CleanupRequest)) as MuSig2CleanupRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2CleanupRequest create() => MuSig2CleanupRequest._();
  MuSig2CleanupRequest createEmptyInstance() => create();
  static $pb.PbList<MuSig2CleanupRequest> createRepeated() => $pb.PbList<MuSig2CleanupRequest>();
  @$core.pragma('dart2js:noInline')
  static MuSig2CleanupRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2CleanupRequest>(create);
  static MuSig2CleanupRequest? _defaultInstance;

  ///
  /// The unique ID of the signing session that should be removed/cleaned up.
  @$pb.TagNumber(1)
  $core.List<$core.int> get sessionId => $_getN(0);
  @$pb.TagNumber(1)
  set sessionId($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class MuSig2CleanupResponse extends $pb.GeneratedMessage {
  factory MuSig2CleanupResponse() => create();
  MuSig2CleanupResponse._() : super();
  factory MuSig2CleanupResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MuSig2CleanupResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MuSig2CleanupResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'signrpc'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MuSig2CleanupResponse clone() => MuSig2CleanupResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MuSig2CleanupResponse copyWith(void Function(MuSig2CleanupResponse) updates) => super.copyWith((message) => updates(message as MuSig2CleanupResponse)) as MuSig2CleanupResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuSig2CleanupResponse create() => MuSig2CleanupResponse._();
  MuSig2CleanupResponse createEmptyInstance() => create();
  static $pb.PbList<MuSig2CleanupResponse> createRepeated() => $pb.PbList<MuSig2CleanupResponse>();
  @$core.pragma('dart2js:noInline')
  static MuSig2CleanupResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MuSig2CleanupResponse>(create);
  static MuSig2CleanupResponse? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
