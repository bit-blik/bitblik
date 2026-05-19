//
//  Generated code. Do not modify.
//  source: lnd/primitives.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'primitives.pbenum.dart';

class Amount extends $pb.GeneratedMessage {
  factory Amount({
    $fixnum.Int64? msat,
  }) {
    final $result = create();
    if (msat != null) {
      $result.msat = msat;
    }
    return $result;
  }
  Amount._() : super();
  factory Amount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Amount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Amount', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'msat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Amount clone() => Amount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Amount copyWith(void Function(Amount) updates) => super.copyWith((message) => updates(message as Amount)) as Amount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Amount create() => Amount._();
  Amount createEmptyInstance() => create();
  static $pb.PbList<Amount> createRepeated() => $pb.PbList<Amount>();
  @$core.pragma('dart2js:noInline')
  static Amount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Amount>(create);
  static Amount? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get msat => $_getI64(0);
  @$pb.TagNumber(1)
  set msat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearMsat() => $_clearField(1);
}

enum AmountOrAll_Value {
  amount, 
  all, 
  notSet
}

class AmountOrAll extends $pb.GeneratedMessage {
  factory AmountOrAll({
    Amount? amount,
    $core.bool? all,
  }) {
    final $result = create();
    if (amount != null) {
      $result.amount = amount;
    }
    if (all != null) {
      $result.all = all;
    }
    return $result;
  }
  AmountOrAll._() : super();
  factory AmountOrAll.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AmountOrAll.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, AmountOrAll_Value> _AmountOrAll_ValueByTag = {
    1 : AmountOrAll_Value.amount,
    2 : AmountOrAll_Value.all,
    0 : AmountOrAll_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AmountOrAll', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Amount>(1, _omitFieldNames ? '' : 'amount', subBuilder: Amount.create)
    ..aOB(2, _omitFieldNames ? '' : 'all')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AmountOrAll clone() => AmountOrAll()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AmountOrAll copyWith(void Function(AmountOrAll) updates) => super.copyWith((message) => updates(message as AmountOrAll)) as AmountOrAll;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AmountOrAll create() => AmountOrAll._();
  AmountOrAll createEmptyInstance() => create();
  static $pb.PbList<AmountOrAll> createRepeated() => $pb.PbList<AmountOrAll>();
  @$core.pragma('dart2js:noInline')
  static AmountOrAll getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AmountOrAll>(create);
  static AmountOrAll? _defaultInstance;

  AmountOrAll_Value whichValue() => _AmountOrAll_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Amount get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount(Amount v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);
  @$pb.TagNumber(1)
  Amount ensureAmount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get all => $_getBF(1);
  @$pb.TagNumber(2)
  set all($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAll() => $_has(1);
  @$pb.TagNumber(2)
  void clearAll() => $_clearField(2);
}

enum AmountOrAny_Value {
  amount, 
  any, 
  notSet
}

class AmountOrAny extends $pb.GeneratedMessage {
  factory AmountOrAny({
    Amount? amount,
    $core.bool? any,
  }) {
    final $result = create();
    if (amount != null) {
      $result.amount = amount;
    }
    if (any != null) {
      $result.any = any;
    }
    return $result;
  }
  AmountOrAny._() : super();
  factory AmountOrAny.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AmountOrAny.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, AmountOrAny_Value> _AmountOrAny_ValueByTag = {
    1 : AmountOrAny_Value.amount,
    2 : AmountOrAny_Value.any,
    0 : AmountOrAny_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AmountOrAny', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Amount>(1, _omitFieldNames ? '' : 'amount', subBuilder: Amount.create)
    ..aOB(2, _omitFieldNames ? '' : 'any')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AmountOrAny clone() => AmountOrAny()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AmountOrAny copyWith(void Function(AmountOrAny) updates) => super.copyWith((message) => updates(message as AmountOrAny)) as AmountOrAny;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AmountOrAny create() => AmountOrAny._();
  AmountOrAny createEmptyInstance() => create();
  static $pb.PbList<AmountOrAny> createRepeated() => $pb.PbList<AmountOrAny>();
  @$core.pragma('dart2js:noInline')
  static AmountOrAny getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AmountOrAny>(create);
  static AmountOrAny? _defaultInstance;

  AmountOrAny_Value whichValue() => _AmountOrAny_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Amount get amount => $_getN(0);
  @$pb.TagNumber(1)
  set amount(Amount v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmount() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmount() => $_clearField(1);
  @$pb.TagNumber(1)
  Amount ensureAmount() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get any => $_getBF(1);
  @$pb.TagNumber(2)
  set any($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAny() => $_has(1);
  @$pb.TagNumber(2)
  void clearAny() => $_clearField(2);
}

class ChannelStateChangeCause extends $pb.GeneratedMessage {
  factory ChannelStateChangeCause() => create();
  ChannelStateChangeCause._() : super();
  factory ChannelStateChangeCause.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelStateChangeCause.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelStateChangeCause', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelStateChangeCause clone() => ChannelStateChangeCause()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelStateChangeCause copyWith(void Function(ChannelStateChangeCause) updates) => super.copyWith((message) => updates(message as ChannelStateChangeCause)) as ChannelStateChangeCause;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelStateChangeCause create() => ChannelStateChangeCause._();
  ChannelStateChangeCause createEmptyInstance() => create();
  static $pb.PbList<ChannelStateChangeCause> createRepeated() => $pb.PbList<ChannelStateChangeCause>();
  @$core.pragma('dart2js:noInline')
  static ChannelStateChangeCause getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelStateChangeCause>(create);
  static ChannelStateChangeCause? _defaultInstance;
}

class Outpoint extends $pb.GeneratedMessage {
  factory Outpoint({
    $core.List<$core.int>? txid,
    $core.int? outnum,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    if (outnum != null) {
      $result.outnum = outnum;
    }
    return $result;
  }
  Outpoint._() : super();
  factory Outpoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Outpoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Outpoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'txid', $pb.PbFieldType.OY)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'outnum', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Outpoint clone() => Outpoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Outpoint copyWith(void Function(Outpoint) updates) => super.copyWith((message) => updates(message as Outpoint)) as Outpoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Outpoint create() => Outpoint._();
  Outpoint createEmptyInstance() => create();
  static $pb.PbList<Outpoint> createRepeated() => $pb.PbList<Outpoint>();
  @$core.pragma('dart2js:noInline')
  static Outpoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Outpoint>(create);
  static Outpoint? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get txid => $_getN(0);
  @$pb.TagNumber(1)
  set txid($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get outnum => $_getIZ(1);
  @$pb.TagNumber(2)
  set outnum($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOutnum() => $_has(1);
  @$pb.TagNumber(2)
  void clearOutnum() => $_clearField(2);
}

enum Feerate_Style {
  slow, 
  normal, 
  urgent, 
  perkb, 
  perkw, 
  notSet
}

class Feerate extends $pb.GeneratedMessage {
  factory Feerate({
    $core.bool? slow,
    $core.bool? normal,
    $core.bool? urgent,
    $core.int? perkb,
    $core.int? perkw,
  }) {
    final $result = create();
    if (slow != null) {
      $result.slow = slow;
    }
    if (normal != null) {
      $result.normal = normal;
    }
    if (urgent != null) {
      $result.urgent = urgent;
    }
    if (perkb != null) {
      $result.perkb = perkb;
    }
    if (perkw != null) {
      $result.perkw = perkw;
    }
    return $result;
  }
  Feerate._() : super();
  factory Feerate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Feerate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Feerate_Style> _Feerate_StyleByTag = {
    1 : Feerate_Style.slow,
    2 : Feerate_Style.normal,
    3 : Feerate_Style.urgent,
    4 : Feerate_Style.perkb,
    5 : Feerate_Style.perkw,
    0 : Feerate_Style.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Feerate', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOB(1, _omitFieldNames ? '' : 'slow')
    ..aOB(2, _omitFieldNames ? '' : 'normal')
    ..aOB(3, _omitFieldNames ? '' : 'urgent')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'perkb', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'perkw', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Feerate clone() => Feerate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Feerate copyWith(void Function(Feerate) updates) => super.copyWith((message) => updates(message as Feerate)) as Feerate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feerate create() => Feerate._();
  Feerate createEmptyInstance() => create();
  static $pb.PbList<Feerate> createRepeated() => $pb.PbList<Feerate>();
  @$core.pragma('dart2js:noInline')
  static Feerate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feerate>(create);
  static Feerate? _defaultInstance;

  Feerate_Style whichStyle() => _Feerate_StyleByTag[$_whichOneof(0)]!;
  void clearStyle() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.bool get slow => $_getBF(0);
  @$pb.TagNumber(1)
  set slow($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSlow() => $_has(0);
  @$pb.TagNumber(1)
  void clearSlow() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get normal => $_getBF(1);
  @$pb.TagNumber(2)
  set normal($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNormal() => $_has(1);
  @$pb.TagNumber(2)
  void clearNormal() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get urgent => $_getBF(2);
  @$pb.TagNumber(3)
  set urgent($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUrgent() => $_has(2);
  @$pb.TagNumber(3)
  void clearUrgent() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get perkb => $_getIZ(3);
  @$pb.TagNumber(4)
  set perkb($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPerkb() => $_has(3);
  @$pb.TagNumber(4)
  void clearPerkb() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get perkw => $_getIZ(4);
  @$pb.TagNumber(5)
  set perkw($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPerkw() => $_has(4);
  @$pb.TagNumber(5)
  void clearPerkw() => $_clearField(5);
}

class OutputDesc extends $pb.GeneratedMessage {
  factory OutputDesc({
    $core.String? address,
    Amount? amount,
  }) {
    final $result = create();
    if (address != null) {
      $result.address = address;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  OutputDesc._() : super();
  factory OutputDesc.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OutputDesc.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OutputDesc', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..aOM<Amount>(2, _omitFieldNames ? '' : 'amount', subBuilder: Amount.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OutputDesc clone() => OutputDesc()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OutputDesc copyWith(void Function(OutputDesc) updates) => super.copyWith((message) => updates(message as OutputDesc)) as OutputDesc;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OutputDesc create() => OutputDesc._();
  OutputDesc createEmptyInstance() => create();
  static $pb.PbList<OutputDesc> createRepeated() => $pb.PbList<OutputDesc>();
  @$core.pragma('dart2js:noInline')
  static OutputDesc getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutputDesc>(create);
  static OutputDesc? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  Amount get amount => $_getN(1);
  @$pb.TagNumber(2)
  set amount(Amount v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
  @$pb.TagNumber(2)
  Amount ensureAmount() => $_ensure(1);
}

class RouteHop extends $pb.GeneratedMessage {
  factory RouteHop({
    $core.List<$core.int>? id,
    $core.String? scid,
    Amount? feebase,
    $core.int? feeprop,
    $core.int? expirydelta,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (scid != null) {
      $result.scid = scid;
    }
    if (feebase != null) {
      $result.feebase = feebase;
    }
    if (feeprop != null) {
      $result.feeprop = feeprop;
    }
    if (expirydelta != null) {
      $result.expirydelta = expirydelta;
    }
    return $result;
  }
  RouteHop._() : super();
  factory RouteHop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteHop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RouteHop', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'scid')
    ..aOM<Amount>(3, _omitFieldNames ? '' : 'feebase', subBuilder: Amount.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'feeprop', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'expirydelta', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteHop clone() => RouteHop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteHop copyWith(void Function(RouteHop) updates) => super.copyWith((message) => updates(message as RouteHop)) as RouteHop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteHop create() => RouteHop._();
  RouteHop createEmptyInstance() => create();
  static $pb.PbList<RouteHop> createRepeated() => $pb.PbList<RouteHop>();
  @$core.pragma('dart2js:noInline')
  static RouteHop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteHop>(create);
  static RouteHop? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get id => $_getN(0);
  @$pb.TagNumber(1)
  set id($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get scid => $_getSZ(1);
  @$pb.TagNumber(2)
  set scid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasScid() => $_has(1);
  @$pb.TagNumber(2)
  void clearScid() => $_clearField(2);

  @$pb.TagNumber(3)
  Amount get feebase => $_getN(2);
  @$pb.TagNumber(3)
  set feebase(Amount v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeebase() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeebase() => $_clearField(3);
  @$pb.TagNumber(3)
  Amount ensureFeebase() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get feeprop => $_getIZ(3);
  @$pb.TagNumber(4)
  set feeprop($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeprop() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeprop() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get expirydelta => $_getIZ(4);
  @$pb.TagNumber(5)
  set expirydelta($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpirydelta() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpirydelta() => $_clearField(5);
}

class Routehint extends $pb.GeneratedMessage {
  factory Routehint({
    $core.Iterable<RouteHop>? hops,
  }) {
    final $result = create();
    if (hops != null) {
      $result.hops.addAll(hops);
    }
    return $result;
  }
  Routehint._() : super();
  factory Routehint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Routehint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Routehint', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..pc<RouteHop>(1, _omitFieldNames ? '' : 'hops', $pb.PbFieldType.PM, subBuilder: RouteHop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Routehint clone() => Routehint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Routehint copyWith(void Function(Routehint) updates) => super.copyWith((message) => updates(message as Routehint)) as Routehint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Routehint create() => Routehint._();
  Routehint createEmptyInstance() => create();
  static $pb.PbList<Routehint> createRepeated() => $pb.PbList<Routehint>();
  @$core.pragma('dart2js:noInline')
  static Routehint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Routehint>(create);
  static Routehint? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<RouteHop> get hops => $_getList(0);
}

class RoutehintList extends $pb.GeneratedMessage {
  factory RoutehintList({
    $core.Iterable<Routehint>? hints,
  }) {
    final $result = create();
    if (hints != null) {
      $result.hints.addAll(hints);
    }
    return $result;
  }
  RoutehintList._() : super();
  factory RoutehintList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoutehintList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RoutehintList', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..pc<Routehint>(2, _omitFieldNames ? '' : 'hints', $pb.PbFieldType.PM, subBuilder: Routehint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoutehintList clone() => RoutehintList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoutehintList copyWith(void Function(RoutehintList) updates) => super.copyWith((message) => updates(message as RoutehintList)) as RoutehintList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RoutehintList create() => RoutehintList._();
  RoutehintList createEmptyInstance() => create();
  static $pb.PbList<RoutehintList> createRepeated() => $pb.PbList<RoutehintList>();
  @$core.pragma('dart2js:noInline')
  static RoutehintList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoutehintList>(create);
  static RoutehintList? _defaultInstance;

  @$pb.TagNumber(2)
  $pb.PbList<Routehint> get hints => $_getList(0);
}

class DecodeRouteHop extends $pb.GeneratedMessage {
  factory DecodeRouteHop({
    $core.List<$core.int>? pubkey,
    $core.String? shortChannelId,
    Amount? feeBaseMsat,
    $core.int? feeProportionalMillionths,
    $core.int? cltvExpiryDelta,
  }) {
    final $result = create();
    if (pubkey != null) {
      $result.pubkey = pubkey;
    }
    if (shortChannelId != null) {
      $result.shortChannelId = shortChannelId;
    }
    if (feeBaseMsat != null) {
      $result.feeBaseMsat = feeBaseMsat;
    }
    if (feeProportionalMillionths != null) {
      $result.feeProportionalMillionths = feeProportionalMillionths;
    }
    if (cltvExpiryDelta != null) {
      $result.cltvExpiryDelta = cltvExpiryDelta;
    }
    return $result;
  }
  DecodeRouteHop._() : super();
  factory DecodeRouteHop.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeRouteHop.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeRouteHop', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'pubkey', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'shortChannelId')
    ..aOM<Amount>(3, _omitFieldNames ? '' : 'feeBaseMsat', subBuilder: Amount.create)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'feeProportionalMillionths', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'cltvExpiryDelta', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeRouteHop clone() => DecodeRouteHop()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeRouteHop copyWith(void Function(DecodeRouteHop) updates) => super.copyWith((message) => updates(message as DecodeRouteHop)) as DecodeRouteHop;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeRouteHop create() => DecodeRouteHop._();
  DecodeRouteHop createEmptyInstance() => create();
  static $pb.PbList<DecodeRouteHop> createRepeated() => $pb.PbList<DecodeRouteHop>();
  @$core.pragma('dart2js:noInline')
  static DecodeRouteHop getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeRouteHop>(create);
  static DecodeRouteHop? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get pubkey => $_getN(0);
  @$pb.TagNumber(1)
  set pubkey($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPubkey() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get shortChannelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set shortChannelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasShortChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearShortChannelId() => $_clearField(2);

  @$pb.TagNumber(3)
  Amount get feeBaseMsat => $_getN(2);
  @$pb.TagNumber(3)
  set feeBaseMsat(Amount v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeeBaseMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeBaseMsat() => $_clearField(3);
  @$pb.TagNumber(3)
  Amount ensureFeeBaseMsat() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get feeProportionalMillionths => $_getIZ(3);
  @$pb.TagNumber(4)
  set feeProportionalMillionths($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeProportionalMillionths() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeProportionalMillionths() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get cltvExpiryDelta => $_getIZ(4);
  @$pb.TagNumber(5)
  set cltvExpiryDelta($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCltvExpiryDelta() => $_has(4);
  @$pb.TagNumber(5)
  void clearCltvExpiryDelta() => $_clearField(5);
}

class DecodeRoutehint extends $pb.GeneratedMessage {
  factory DecodeRoutehint({
    $core.Iterable<DecodeRouteHop>? hops,
  }) {
    final $result = create();
    if (hops != null) {
      $result.hops.addAll(hops);
    }
    return $result;
  }
  DecodeRoutehint._() : super();
  factory DecodeRoutehint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeRoutehint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeRoutehint', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..pc<DecodeRouteHop>(1, _omitFieldNames ? '' : 'hops', $pb.PbFieldType.PM, subBuilder: DecodeRouteHop.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeRoutehint clone() => DecodeRoutehint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeRoutehint copyWith(void Function(DecodeRoutehint) updates) => super.copyWith((message) => updates(message as DecodeRoutehint)) as DecodeRoutehint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeRoutehint create() => DecodeRoutehint._();
  DecodeRoutehint createEmptyInstance() => create();
  static $pb.PbList<DecodeRoutehint> createRepeated() => $pb.PbList<DecodeRoutehint>();
  @$core.pragma('dart2js:noInline')
  static DecodeRoutehint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeRoutehint>(create);
  static DecodeRoutehint? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<DecodeRouteHop> get hops => $_getList(0);
}

class DecodeRoutehintList extends $pb.GeneratedMessage {
  factory DecodeRoutehintList({
    $core.Iterable<DecodeRoutehint>? hints,
  }) {
    final $result = create();
    if (hints != null) {
      $result.hints.addAll(hints);
    }
    return $result;
  }
  DecodeRoutehintList._() : super();
  factory DecodeRoutehintList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeRoutehintList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeRoutehintList', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..pc<DecodeRoutehint>(2, _omitFieldNames ? '' : 'hints', $pb.PbFieldType.PM, subBuilder: DecodeRoutehint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeRoutehintList clone() => DecodeRoutehintList()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeRoutehintList copyWith(void Function(DecodeRoutehintList) updates) => super.copyWith((message) => updates(message as DecodeRoutehintList)) as DecodeRoutehintList;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeRoutehintList create() => DecodeRoutehintList._();
  DecodeRoutehintList createEmptyInstance() => create();
  static $pb.PbList<DecodeRoutehintList> createRepeated() => $pb.PbList<DecodeRoutehintList>();
  @$core.pragma('dart2js:noInline')
  static DecodeRoutehintList getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeRoutehintList>(create);
  static DecodeRoutehintList? _defaultInstance;

  @$pb.TagNumber(2)
  $pb.PbList<DecodeRoutehint> get hints => $_getList(0);
}

class TlvEntry extends $pb.GeneratedMessage {
  factory TlvEntry({
    $fixnum.Int64? type,
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  TlvEntry._() : super();
  factory TlvEntry.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TlvEntry.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TlvEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TlvEntry clone() => TlvEntry()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TlvEntry copyWith(void Function(TlvEntry) updates) => super.copyWith((message) => updates(message as TlvEntry)) as TlvEntry;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TlvEntry create() => TlvEntry._();
  TlvEntry createEmptyInstance() => create();
  static $pb.PbList<TlvEntry> createRepeated() => $pb.PbList<TlvEntry>();
  @$core.pragma('dart2js:noInline')
  static TlvEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TlvEntry>(create);
  static TlvEntry? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get type => $_getI64(0);
  @$pb.TagNumber(1)
  set type($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class TlvStream extends $pb.GeneratedMessage {
  factory TlvStream({
    $core.Iterable<TlvEntry>? entries,
  }) {
    final $result = create();
    if (entries != null) {
      $result.entries.addAll(entries);
    }
    return $result;
  }
  TlvStream._() : super();
  factory TlvStream.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TlvStream.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TlvStream', package: const $pb.PackageName(_omitMessageNames ? '' : 'cln'), createEmptyInstance: create)
    ..pc<TlvEntry>(1, _omitFieldNames ? '' : 'entries', $pb.PbFieldType.PM, subBuilder: TlvEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TlvStream clone() => TlvStream()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TlvStream copyWith(void Function(TlvStream) updates) => super.copyWith((message) => updates(message as TlvStream)) as TlvStream;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TlvStream create() => TlvStream._();
  TlvStream createEmptyInstance() => create();
  static $pb.PbList<TlvStream> createRepeated() => $pb.PbList<TlvStream>();
  @$core.pragma('dart2js:noInline')
  static TlvStream getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TlvStream>(create);
  static TlvStream? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<TlvEntry> get entries => $_getList(0);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
