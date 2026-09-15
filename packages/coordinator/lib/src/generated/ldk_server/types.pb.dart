//
//  Generated code. Do not modify.
//  source: types.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'types.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'types.pbenum.dart';

/// Represents a payment.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.PaymentDetails.html
class Payment extends $pb.GeneratedMessage {
  factory Payment({
    $core.String? paymentId,
    PaymentKind? kind,
    $fixnum.Int64? amountMsat,
    PaymentDirection? direction,
    PaymentStatus? status,
    $fixnum.Int64? latestUpdateTimestamp,
    $fixnum.Int64? feePaidMsat,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    if (kind != null) {
      $result.kind = kind;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    if (status != null) {
      $result.status = status;
    }
    if (latestUpdateTimestamp != null) {
      $result.latestUpdateTimestamp = latestUpdateTimestamp;
    }
    if (feePaidMsat != null) {
      $result.feePaidMsat = feePaidMsat;
    }
    return $result;
  }
  Payment._() : super();
  factory Payment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Payment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Payment', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..aOM<PaymentKind>(2, _omitFieldNames ? '' : 'kind', subBuilder: PaymentKind.create)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<PaymentDirection>(4, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: PaymentDirection.INBOUND, valueOf: PaymentDirection.valueOf, enumValues: PaymentDirection.values)
    ..e<PaymentStatus>(5, _omitFieldNames ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: PaymentStatus.PENDING, valueOf: PaymentStatus.valueOf, enumValues: PaymentStatus.values)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'latestUpdateTimestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'feePaidMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Payment clone() => Payment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Payment copyWith(void Function(Payment) updates) => super.copyWith((message) => updates(message as Payment)) as Payment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Payment create() => Payment._();
  Payment createEmptyInstance() => create();
  static $pb.PbList<Payment> createRepeated() => $pb.PbList<Payment>();
  @$core.pragma('dart2js:noInline')
  static Payment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Payment>(create);
  static Payment? _defaultInstance;

  /// An identifier used to uniquely identify a payment in hex-encoded form.
  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);

  /// The kind of the payment.
  @$pb.TagNumber(2)
  PaymentKind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(PaymentKind v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);
  @$pb.TagNumber(2)
  PaymentKind ensureKind() => $_ensure(1);

  /// The amount transferred.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMsat() => $_clearField(3);

  /// The direction of the payment.
  @$pb.TagNumber(4)
  PaymentDirection get direction => $_getN(3);
  @$pb.TagNumber(4)
  set direction(PaymentDirection v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasDirection() => $_has(3);
  @$pb.TagNumber(4)
  void clearDirection() => $_clearField(4);

  /// The status of the payment.
  @$pb.TagNumber(5)
  PaymentStatus get status => $_getN(4);
  @$pb.TagNumber(5)
  set status(PaymentStatus v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasStatus() => $_has(4);
  @$pb.TagNumber(5)
  void clearStatus() => $_clearField(5);

  /// The timestamp, in seconds since start of the UNIX epoch, when this entry was last updated.
  @$pb.TagNumber(6)
  $fixnum.Int64 get latestUpdateTimestamp => $_getI64(5);
  @$pb.TagNumber(6)
  set latestUpdateTimestamp($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasLatestUpdateTimestamp() => $_has(5);
  @$pb.TagNumber(6)
  void clearLatestUpdateTimestamp() => $_clearField(6);

  ///  The fees that were paid for this payment.
  ///
  ///  For Lightning payments, this will only be updated for outbound payments once they
  ///  succeeded.
  @$pb.TagNumber(7)
  $fixnum.Int64 get feePaidMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set feePaidMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFeePaidMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeePaidMsat() => $_clearField(7);
}

/// Options that control which BOLT 12 invoice fields a payer proof discloses.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.PayerProofOptions.html
class PayerProofOptions extends $pb.GeneratedMessage {
  factory PayerProofOptions({
    $core.String? note,
    $core.bool? includeOfferDescription,
    $core.bool? includeOfferIssuer,
    $core.bool? includeInvoiceAmount,
    $core.bool? includeInvoiceCreatedAt,
    $core.Iterable<$fixnum.Int64>? extraTlvTypes,
  }) {
    final $result = create();
    if (note != null) {
      $result.note = note;
    }
    if (includeOfferDescription != null) {
      $result.includeOfferDescription = includeOfferDescription;
    }
    if (includeOfferIssuer != null) {
      $result.includeOfferIssuer = includeOfferIssuer;
    }
    if (includeInvoiceAmount != null) {
      $result.includeInvoiceAmount = includeInvoiceAmount;
    }
    if (includeInvoiceCreatedAt != null) {
      $result.includeInvoiceCreatedAt = includeInvoiceCreatedAt;
    }
    if (extraTlvTypes != null) {
      $result.extraTlvTypes.addAll(extraTlvTypes);
    }
    return $result;
  }
  PayerProofOptions._() : super();
  factory PayerProofOptions.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PayerProofOptions.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PayerProofOptions', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'note')
    ..aOB(2, _omitFieldNames ? '' : 'includeOfferDescription')
    ..aOB(3, _omitFieldNames ? '' : 'includeOfferIssuer')
    ..aOB(4, _omitFieldNames ? '' : 'includeInvoiceAmount')
    ..aOB(5, _omitFieldNames ? '' : 'includeInvoiceCreatedAt')
    ..p<$fixnum.Int64>(6, _omitFieldNames ? '' : 'extraTlvTypes', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PayerProofOptions clone() => PayerProofOptions()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PayerProofOptions copyWith(void Function(PayerProofOptions) updates) => super.copyWith((message) => updates(message as PayerProofOptions)) as PayerProofOptions;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PayerProofOptions create() => PayerProofOptions._();
  PayerProofOptions createEmptyInstance() => create();
  static $pb.PbList<PayerProofOptions> createRepeated() => $pb.PbList<PayerProofOptions>();
  @$core.pragma('dart2js:noInline')
  static PayerProofOptions getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PayerProofOptions>(create);
  static PayerProofOptions? _defaultInstance;

  /// An optional note to attach to the payer proof itself.
  @$pb.TagNumber(1)
  $core.String get note => $_getSZ(0);
  @$pb.TagNumber(1)
  set note($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNote() => $_has(0);
  @$pb.TagNumber(1)
  void clearNote() => $_clearField(1);

  /// Whether to disclose the offer description.
  @$pb.TagNumber(2)
  $core.bool get includeOfferDescription => $_getBF(1);
  @$pb.TagNumber(2)
  set includeOfferDescription($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncludeOfferDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncludeOfferDescription() => $_clearField(2);

  /// Whether to disclose the offer issuer.
  @$pb.TagNumber(3)
  $core.bool get includeOfferIssuer => $_getBF(2);
  @$pb.TagNumber(3)
  set includeOfferIssuer($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIncludeOfferIssuer() => $_has(2);
  @$pb.TagNumber(3)
  void clearIncludeOfferIssuer() => $_clearField(3);

  /// Whether to disclose the invoice amount.
  @$pb.TagNumber(4)
  $core.bool get includeInvoiceAmount => $_getBF(3);
  @$pb.TagNumber(4)
  set includeInvoiceAmount($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIncludeInvoiceAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearIncludeInvoiceAmount() => $_clearField(4);

  /// Whether to disclose the invoice creation timestamp.
  @$pb.TagNumber(5)
  $core.bool get includeInvoiceCreatedAt => $_getBF(4);
  @$pb.TagNumber(5)
  set includeInvoiceCreatedAt($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIncludeInvoiceCreatedAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearIncludeInvoiceCreatedAt() => $_clearField(5);

  /// Additional TLV types to disclose, for fields not covered by the flags above.
  @$pb.TagNumber(6)
  $pb.PbList<$fixnum.Int64> get extraTlvTypes => $_getList(5);
}

enum PaymentKind_Kind {
  onchain, 
  bolt11, 
  bolt12Offer, 
  bolt12Refund, 
  spontaneous, 
  notSet
}

class PaymentKind extends $pb.GeneratedMessage {
  factory PaymentKind({
    Onchain? onchain,
    Bolt11? bolt11,
    Bolt12Offer? bolt12Offer,
    Bolt12Refund? bolt12Refund,
    Spontaneous? spontaneous,
  }) {
    final $result = create();
    if (onchain != null) {
      $result.onchain = onchain;
    }
    if (bolt11 != null) {
      $result.bolt11 = bolt11;
    }
    if (bolt12Offer != null) {
      $result.bolt12Offer = bolt12Offer;
    }
    if (bolt12Refund != null) {
      $result.bolt12Refund = bolt12Refund;
    }
    if (spontaneous != null) {
      $result.spontaneous = spontaneous;
    }
    return $result;
  }
  PaymentKind._() : super();
  factory PaymentKind.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PaymentKind.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, PaymentKind_Kind> _PaymentKind_KindByTag = {
    1 : PaymentKind_Kind.onchain,
    2 : PaymentKind_Kind.bolt11,
    3 : PaymentKind_Kind.bolt12Offer,
    4 : PaymentKind_Kind.bolt12Refund,
    5 : PaymentKind_Kind.spontaneous,
    0 : PaymentKind_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PaymentKind', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5])
    ..aOM<Onchain>(1, _omitFieldNames ? '' : 'onchain', subBuilder: Onchain.create)
    ..aOM<Bolt11>(2, _omitFieldNames ? '' : 'bolt11', subBuilder: Bolt11.create)
    ..aOM<Bolt12Offer>(3, _omitFieldNames ? '' : 'bolt12Offer', subBuilder: Bolt12Offer.create)
    ..aOM<Bolt12Refund>(4, _omitFieldNames ? '' : 'bolt12Refund', subBuilder: Bolt12Refund.create)
    ..aOM<Spontaneous>(5, _omitFieldNames ? '' : 'spontaneous', subBuilder: Spontaneous.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PaymentKind clone() => PaymentKind()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PaymentKind copyWith(void Function(PaymentKind) updates) => super.copyWith((message) => updates(message as PaymentKind)) as PaymentKind;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PaymentKind create() => PaymentKind._();
  PaymentKind createEmptyInstance() => create();
  static $pb.PbList<PaymentKind> createRepeated() => $pb.PbList<PaymentKind>();
  @$core.pragma('dart2js:noInline')
  static PaymentKind getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PaymentKind>(create);
  static PaymentKind? _defaultInstance;

  PaymentKind_Kind whichKind() => _PaymentKind_KindByTag[$_whichOneof(0)]!;
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Onchain get onchain => $_getN(0);
  @$pb.TagNumber(1)
  set onchain(Onchain v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasOnchain() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnchain() => $_clearField(1);
  @$pb.TagNumber(1)
  Onchain ensureOnchain() => $_ensure(0);

  @$pb.TagNumber(2)
  Bolt11 get bolt11 => $_getN(1);
  @$pb.TagNumber(2)
  set bolt11(Bolt11 v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBolt11() => $_has(1);
  @$pb.TagNumber(2)
  void clearBolt11() => $_clearField(2);
  @$pb.TagNumber(2)
  Bolt11 ensureBolt11() => $_ensure(1);

  @$pb.TagNumber(3)
  Bolt12Offer get bolt12Offer => $_getN(2);
  @$pb.TagNumber(3)
  set bolt12Offer(Bolt12Offer v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasBolt12Offer() => $_has(2);
  @$pb.TagNumber(3)
  void clearBolt12Offer() => $_clearField(3);
  @$pb.TagNumber(3)
  Bolt12Offer ensureBolt12Offer() => $_ensure(2);

  @$pb.TagNumber(4)
  Bolt12Refund get bolt12Refund => $_getN(3);
  @$pb.TagNumber(4)
  set bolt12Refund(Bolt12Refund v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasBolt12Refund() => $_has(3);
  @$pb.TagNumber(4)
  void clearBolt12Refund() => $_clearField(4);
  @$pb.TagNumber(4)
  Bolt12Refund ensureBolt12Refund() => $_ensure(3);

  @$pb.TagNumber(5)
  Spontaneous get spontaneous => $_getN(4);
  @$pb.TagNumber(5)
  set spontaneous(Spontaneous v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSpontaneous() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpontaneous() => $_clearField(5);
  @$pb.TagNumber(5)
  Spontaneous ensureSpontaneous() => $_ensure(4);
}

/// Represents an on-chain payment.
class Onchain extends $pb.GeneratedMessage {
  factory Onchain({
    $core.String? txid,
    ConfirmationStatus? status,
    TransactionType? txType,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    if (status != null) {
      $result.status = status;
    }
    if (txType != null) {
      $result.txType = txType;
    }
    return $result;
  }
  Onchain._() : super();
  factory Onchain.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Onchain.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Onchain', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txid')
    ..aOM<ConfirmationStatus>(2, _omitFieldNames ? '' : 'status', subBuilder: ConfirmationStatus.create)
    ..aOM<TransactionType>(3, _omitFieldNames ? '' : 'txType', subBuilder: TransactionType.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Onchain clone() => Onchain()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Onchain copyWith(void Function(Onchain) updates) => super.copyWith((message) => updates(message as Onchain)) as Onchain;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Onchain create() => Onchain._();
  Onchain createEmptyInstance() => create();
  static $pb.PbList<Onchain> createRepeated() => $pb.PbList<Onchain>();
  @$core.pragma('dart2js:noInline')
  static Onchain getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Onchain>(create);
  static Onchain? _defaultInstance;

  /// The transaction identifier of this payment.
  @$pb.TagNumber(1)
  $core.String get txid => $_getSZ(0);
  @$pb.TagNumber(1)
  set txid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);

  /// The confirmation status of this payment.
  @$pb.TagNumber(2)
  ConfirmationStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status(ConfirmationStatus v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
  @$pb.TagNumber(2)
  ConfirmationStatus ensureStatus() => $_ensure(1);

  ///  The classification of this transaction, as reported by LDK when it was broadcast.
  ///
  ///  Unset for plain on-chain sends, and for payments recorded before this classification was
  ///  tracked.
  @$pb.TagNumber(3)
  TransactionType get txType => $_getN(2);
  @$pb.TagNumber(3)
  set txType(TransactionType v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTxType() => $_has(2);
  @$pb.TagNumber(3)
  void clearTxType() => $_clearField(3);
  @$pb.TagNumber(3)
  TransactionType ensureTxType() => $_ensure(2);
}

/// A channel referenced by a TransactionType variant.
class TransactionChannel extends $pb.GeneratedMessage {
  factory TransactionChannel({
    $core.String? counterpartyNodeId,
    $core.String? channelId,
  }) {
    final $result = create();
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  TransactionChannel._() : super();
  factory TransactionChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransactionChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionChannel clone() => TransactionChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionChannel copyWith(void Function(TransactionChannel) updates) => super.copyWith((message) => updates(message as TransactionChannel)) as TransactionChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionChannel create() => TransactionChannel._();
  TransactionChannel createEmptyInstance() => create();
  static $pb.PbList<TransactionChannel> createRepeated() => $pb.PbList<TransactionChannel>();
  @$core.pragma('dart2js:noInline')
  static TransactionChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionChannel>(create);
  static TransactionChannel? _defaultInstance;

  /// The `node_id` of the channel counterparty.
  @$pb.TagNumber(1)
  $core.String get counterpartyNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set counterpartyNodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCounterpartyNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCounterpartyNodeId() => $_clearField(1);

  /// The ID of the channel.
  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);
}

enum TransactionType_Kind {
  funding, 
  cooperativeClose, 
  unilateralClose, 
  anchorBump, 
  claim, 
  sweep, 
  interactiveFunding, 
  notSet
}

/// The classification of an on-chain transaction, mirroring LDK Node's
/// `ldk_node::payment::TransactionType`.
class TransactionType extends $pb.GeneratedMessage {
  factory TransactionType({
    Funding? funding,
    CooperativeClose? cooperativeClose,
    UnilateralClose? unilateralClose,
    AnchorBump? anchorBump,
    Claim? claim,
    Sweep? sweep,
    InteractiveFunding? interactiveFunding,
  }) {
    final $result = create();
    if (funding != null) {
      $result.funding = funding;
    }
    if (cooperativeClose != null) {
      $result.cooperativeClose = cooperativeClose;
    }
    if (unilateralClose != null) {
      $result.unilateralClose = unilateralClose;
    }
    if (anchorBump != null) {
      $result.anchorBump = anchorBump;
    }
    if (claim != null) {
      $result.claim = claim;
    }
    if (sweep != null) {
      $result.sweep = sweep;
    }
    if (interactiveFunding != null) {
      $result.interactiveFunding = interactiveFunding;
    }
    return $result;
  }
  TransactionType._() : super();
  factory TransactionType.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TransactionType.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, TransactionType_Kind> _TransactionType_KindByTag = {
    1 : TransactionType_Kind.funding,
    2 : TransactionType_Kind.cooperativeClose,
    3 : TransactionType_Kind.unilateralClose,
    4 : TransactionType_Kind.anchorBump,
    5 : TransactionType_Kind.claim,
    6 : TransactionType_Kind.sweep,
    7 : TransactionType_Kind.interactiveFunding,
    0 : TransactionType_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransactionType', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOM<Funding>(1, _omitFieldNames ? '' : 'funding', subBuilder: Funding.create)
    ..aOM<CooperativeClose>(2, _omitFieldNames ? '' : 'cooperativeClose', subBuilder: CooperativeClose.create)
    ..aOM<UnilateralClose>(3, _omitFieldNames ? '' : 'unilateralClose', subBuilder: UnilateralClose.create)
    ..aOM<AnchorBump>(4, _omitFieldNames ? '' : 'anchorBump', subBuilder: AnchorBump.create)
    ..aOM<Claim>(5, _omitFieldNames ? '' : 'claim', subBuilder: Claim.create)
    ..aOM<Sweep>(6, _omitFieldNames ? '' : 'sweep', subBuilder: Sweep.create)
    ..aOM<InteractiveFunding>(7, _omitFieldNames ? '' : 'interactiveFunding', subBuilder: InteractiveFunding.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TransactionType clone() => TransactionType()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TransactionType copyWith(void Function(TransactionType) updates) => super.copyWith((message) => updates(message as TransactionType)) as TransactionType;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionType create() => TransactionType._();
  TransactionType createEmptyInstance() => create();
  static $pb.PbList<TransactionType> createRepeated() => $pb.PbList<TransactionType>();
  @$core.pragma('dart2js:noInline')
  static TransactionType getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionType>(create);
  static TransactionType? _defaultInstance;

  TransactionType_Kind whichKind() => _TransactionType_KindByTag[$_whichOneof(0)]!;
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Funding get funding => $_getN(0);
  @$pb.TagNumber(1)
  set funding(Funding v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasFunding() => $_has(0);
  @$pb.TagNumber(1)
  void clearFunding() => $_clearField(1);
  @$pb.TagNumber(1)
  Funding ensureFunding() => $_ensure(0);

  @$pb.TagNumber(2)
  CooperativeClose get cooperativeClose => $_getN(1);
  @$pb.TagNumber(2)
  set cooperativeClose(CooperativeClose v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCooperativeClose() => $_has(1);
  @$pb.TagNumber(2)
  void clearCooperativeClose() => $_clearField(2);
  @$pb.TagNumber(2)
  CooperativeClose ensureCooperativeClose() => $_ensure(1);

  @$pb.TagNumber(3)
  UnilateralClose get unilateralClose => $_getN(2);
  @$pb.TagNumber(3)
  set unilateralClose(UnilateralClose v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnilateralClose() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnilateralClose() => $_clearField(3);
  @$pb.TagNumber(3)
  UnilateralClose ensureUnilateralClose() => $_ensure(2);

  @$pb.TagNumber(4)
  AnchorBump get anchorBump => $_getN(3);
  @$pb.TagNumber(4)
  set anchorBump(AnchorBump v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAnchorBump() => $_has(3);
  @$pb.TagNumber(4)
  void clearAnchorBump() => $_clearField(4);
  @$pb.TagNumber(4)
  AnchorBump ensureAnchorBump() => $_ensure(3);

  @$pb.TagNumber(5)
  Claim get claim => $_getN(4);
  @$pb.TagNumber(5)
  set claim(Claim v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasClaim() => $_has(4);
  @$pb.TagNumber(5)
  void clearClaim() => $_clearField(5);
  @$pb.TagNumber(5)
  Claim ensureClaim() => $_ensure(4);

  @$pb.TagNumber(6)
  Sweep get sweep => $_getN(5);
  @$pb.TagNumber(6)
  set sweep(Sweep v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasSweep() => $_has(5);
  @$pb.TagNumber(6)
  void clearSweep() => $_clearField(6);
  @$pb.TagNumber(6)
  Sweep ensureSweep() => $_ensure(5);

  @$pb.TagNumber(7)
  InteractiveFunding get interactiveFunding => $_getN(6);
  @$pb.TagNumber(7)
  set interactiveFunding(InteractiveFunding v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasInteractiveFunding() => $_has(6);
  @$pb.TagNumber(7)
  void clearInteractiveFunding() => $_clearField(7);
  @$pb.TagNumber(7)
  InteractiveFunding ensureInteractiveFunding() => $_ensure(6);
}

/// A funding transaction establishing one or more new channels.
class Funding extends $pb.GeneratedMessage {
  factory Funding({
    $core.Iterable<TransactionChannel>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  Funding._() : super();
  factory Funding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Funding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Funding', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..pc<TransactionChannel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: TransactionChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Funding clone() => Funding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Funding copyWith(void Function(Funding) updates) => super.copyWith((message) => updates(message as Funding)) as Funding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Funding create() => Funding._();
  Funding createEmptyInstance() => create();
  static $pb.PbList<Funding> createRepeated() => $pb.PbList<Funding>();
  @$core.pragma('dart2js:noInline')
  static Funding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Funding>(create);
  static Funding? _defaultInstance;

  /// The channels being funded.
  @$pb.TagNumber(1)
  $pb.PbList<TransactionChannel> get channels => $_getList(0);
}

/// A transaction cooperatively closing a channel.
class CooperativeClose extends $pb.GeneratedMessage {
  factory CooperativeClose({
    $core.String? counterpartyNodeId,
    $core.String? channelId,
  }) {
    final $result = create();
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  CooperativeClose._() : super();
  factory CooperativeClose.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CooperativeClose.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CooperativeClose', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CooperativeClose clone() => CooperativeClose()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CooperativeClose copyWith(void Function(CooperativeClose) updates) => super.copyWith((message) => updates(message as CooperativeClose)) as CooperativeClose;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CooperativeClose create() => CooperativeClose._();
  CooperativeClose createEmptyInstance() => create();
  static $pb.PbList<CooperativeClose> createRepeated() => $pb.PbList<CooperativeClose>();
  @$core.pragma('dart2js:noInline')
  static CooperativeClose getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CooperativeClose>(create);
  static CooperativeClose? _defaultInstance;

  /// The `node_id` of the channel counterparty.
  @$pb.TagNumber(1)
  $core.String get counterpartyNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set counterpartyNodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCounterpartyNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCounterpartyNodeId() => $_clearField(1);

  /// The ID of the channel being closed.
  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);
}

/// A transaction force-closing a channel.
class UnilateralClose extends $pb.GeneratedMessage {
  factory UnilateralClose({
    $core.String? counterpartyNodeId,
    $core.String? channelId,
  }) {
    final $result = create();
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  UnilateralClose._() : super();
  factory UnilateralClose.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnilateralClose.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnilateralClose', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnilateralClose clone() => UnilateralClose()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnilateralClose copyWith(void Function(UnilateralClose) updates) => super.copyWith((message) => updates(message as UnilateralClose)) as UnilateralClose;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnilateralClose create() => UnilateralClose._();
  UnilateralClose createEmptyInstance() => create();
  static $pb.PbList<UnilateralClose> createRepeated() => $pb.PbList<UnilateralClose>();
  @$core.pragma('dart2js:noInline')
  static UnilateralClose getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnilateralClose>(create);
  static UnilateralClose? _defaultInstance;

  /// The `node_id` of the channel counterparty.
  @$pb.TagNumber(1)
  $core.String get counterpartyNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set counterpartyNodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCounterpartyNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCounterpartyNodeId() => $_clearField(1);

  /// The ID of the channel being force-closed.
  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);
}

/// An anchor transaction CPFP fee-bumping a closing transaction.
class AnchorBump extends $pb.GeneratedMessage {
  factory AnchorBump({
    $core.String? counterpartyNodeId,
    $core.String? channelId,
  }) {
    final $result = create();
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  AnchorBump._() : super();
  factory AnchorBump.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnchorBump.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AnchorBump', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnchorBump clone() => AnchorBump()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnchorBump copyWith(void Function(AnchorBump) updates) => super.copyWith((message) => updates(message as AnchorBump)) as AnchorBump;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AnchorBump create() => AnchorBump._();
  AnchorBump createEmptyInstance() => create();
  static $pb.PbList<AnchorBump> createRepeated() => $pb.PbList<AnchorBump>();
  @$core.pragma('dart2js:noInline')
  static AnchorBump getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnchorBump>(create);
  static AnchorBump? _defaultInstance;

  /// The `node_id` of the channel counterparty.
  @$pb.TagNumber(1)
  $core.String get counterpartyNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set counterpartyNodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCounterpartyNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCounterpartyNodeId() => $_clearField(1);

  /// The ID of the channel whose closing transaction is being fee-bumped.
  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);
}

/// A transaction resolving an output spendable by both us and our counterparty.
class Claim extends $pb.GeneratedMessage {
  factory Claim({
    $core.String? counterpartyNodeId,
    $core.String? channelId,
  }) {
    final $result = create();
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (channelId != null) {
      $result.channelId = channelId;
    }
    return $result;
  }
  Claim._() : super();
  factory Claim.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Claim.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Claim', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(2, _omitFieldNames ? '' : 'channelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Claim clone() => Claim()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Claim copyWith(void Function(Claim) updates) => super.copyWith((message) => updates(message as Claim)) as Claim;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Claim create() => Claim._();
  Claim createEmptyInstance() => create();
  static $pb.PbList<Claim> createRepeated() => $pb.PbList<Claim>();
  @$core.pragma('dart2js:noInline')
  static Claim getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Claim>(create);
  static Claim? _defaultInstance;

  /// The `node_id` of the channel counterparty.
  @$pb.TagNumber(1)
  $core.String get counterpartyNodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set counterpartyNodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCounterpartyNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearCounterpartyNodeId() => $_clearField(1);

  /// The ID of the channel from which outputs are being claimed.
  @$pb.TagNumber(2)
  $core.String get channelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set channelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChannelId() => $_clearField(2);
}

/// A transaction sweeping spendable outputs to the on-chain wallet.
class Sweep extends $pb.GeneratedMessage {
  factory Sweep({
    $core.Iterable<TransactionChannel>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  Sweep._() : super();
  factory Sweep.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Sweep.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Sweep', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..pc<TransactionChannel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: TransactionChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Sweep clone() => Sweep()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Sweep copyWith(void Function(Sweep) updates) => super.copyWith((message) => updates(message as Sweep)) as Sweep;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Sweep create() => Sweep._();
  Sweep createEmptyInstance() => create();
  static $pb.PbList<Sweep> createRepeated() => $pb.PbList<Sweep>();
  @$core.pragma('dart2js:noInline')
  static Sweep getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Sweep>(create);
  static Sweep? _defaultInstance;

  /// The channels from which outputs are being swept, if known.
  @$pb.TagNumber(1)
  $pb.PbList<TransactionChannel> get channels => $_getList(0);
}

/// An interactively-negotiated funding transaction: a splice, or (once supported) a V2
/// dual-funded channel open.
class InteractiveFunding extends $pb.GeneratedMessage {
  factory InteractiveFunding({
    $core.Iterable<TransactionChannel>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  InteractiveFunding._() : super();
  factory InteractiveFunding.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory InteractiveFunding.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'InteractiveFunding', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..pc<TransactionChannel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: TransactionChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  InteractiveFunding clone() => InteractiveFunding()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  InteractiveFunding copyWith(void Function(InteractiveFunding) updates) => super.copyWith((message) => updates(message as InteractiveFunding)) as InteractiveFunding;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InteractiveFunding create() => InteractiveFunding._();
  InteractiveFunding createEmptyInstance() => create();
  static $pb.PbList<InteractiveFunding> createRepeated() => $pb.PbList<InteractiveFunding>();
  @$core.pragma('dart2js:noInline')
  static InteractiveFunding getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InteractiveFunding>(create);
  static InteractiveFunding? _defaultInstance;

  /// The channels participating in the negotiation.
  @$pb.TagNumber(1)
  $pb.PbList<TransactionChannel> get channels => $_getList(0);
}

enum ConfirmationStatus_Status {
  confirmed, 
  unconfirmed, 
  notSet
}

class ConfirmationStatus extends $pb.GeneratedMessage {
  factory ConfirmationStatus({
    Confirmed? confirmed,
    Unconfirmed? unconfirmed,
  }) {
    final $result = create();
    if (confirmed != null) {
      $result.confirmed = confirmed;
    }
    if (unconfirmed != null) {
      $result.unconfirmed = unconfirmed;
    }
    return $result;
  }
  ConfirmationStatus._() : super();
  factory ConfirmationStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConfirmationStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ConfirmationStatus_Status> _ConfirmationStatus_StatusByTag = {
    1 : ConfirmationStatus_Status.confirmed,
    2 : ConfirmationStatus_Status.unconfirmed,
    0 : ConfirmationStatus_Status.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConfirmationStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<Confirmed>(1, _omitFieldNames ? '' : 'confirmed', subBuilder: Confirmed.create)
    ..aOM<Unconfirmed>(2, _omitFieldNames ? '' : 'unconfirmed', subBuilder: Unconfirmed.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConfirmationStatus clone() => ConfirmationStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConfirmationStatus copyWith(void Function(ConfirmationStatus) updates) => super.copyWith((message) => updates(message as ConfirmationStatus)) as ConfirmationStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConfirmationStatus create() => ConfirmationStatus._();
  ConfirmationStatus createEmptyInstance() => create();
  static $pb.PbList<ConfirmationStatus> createRepeated() => $pb.PbList<ConfirmationStatus>();
  @$core.pragma('dart2js:noInline')
  static ConfirmationStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConfirmationStatus>(create);
  static ConfirmationStatus? _defaultInstance;

  ConfirmationStatus_Status whichStatus() => _ConfirmationStatus_StatusByTag[$_whichOneof(0)]!;
  void clearStatus() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Confirmed get confirmed => $_getN(0);
  @$pb.TagNumber(1)
  set confirmed(Confirmed v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasConfirmed() => $_has(0);
  @$pb.TagNumber(1)
  void clearConfirmed() => $_clearField(1);
  @$pb.TagNumber(1)
  Confirmed ensureConfirmed() => $_ensure(0);

  @$pb.TagNumber(2)
  Unconfirmed get unconfirmed => $_getN(1);
  @$pb.TagNumber(2)
  set unconfirmed(Unconfirmed v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasUnconfirmed() => $_has(1);
  @$pb.TagNumber(2)
  void clearUnconfirmed() => $_clearField(2);
  @$pb.TagNumber(2)
  Unconfirmed ensureUnconfirmed() => $_ensure(1);
}

/// The on-chain transaction is confirmed in the best chain.
class Confirmed extends $pb.GeneratedMessage {
  factory Confirmed({
    $core.String? blockHash,
    $core.int? height,
    $fixnum.Int64? timestamp,
  }) {
    final $result = create();
    if (blockHash != null) {
      $result.blockHash = blockHash;
    }
    if (height != null) {
      $result.height = height;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  Confirmed._() : super();
  factory Confirmed.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Confirmed.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Confirmed', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'blockHash')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Confirmed clone() => Confirmed()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Confirmed copyWith(void Function(Confirmed) updates) => super.copyWith((message) => updates(message as Confirmed)) as Confirmed;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Confirmed create() => Confirmed._();
  Confirmed createEmptyInstance() => create();
  static $pb.PbList<Confirmed> createRepeated() => $pb.PbList<Confirmed>();
  @$core.pragma('dart2js:noInline')
  static Confirmed getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Confirmed>(create);
  static Confirmed? _defaultInstance;

  /// The hex representation of hash of the block in which the transaction was confirmed.
  @$pb.TagNumber(1)
  $core.String get blockHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set blockHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlockHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockHash() => $_clearField(1);

  /// The height under which the block was confirmed.
  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => $_clearField(2);

  /// The timestamp, in seconds since start of the UNIX epoch, when this entry was last updated.
  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);
}

/// The on-chain transaction is unconfirmed.
class Unconfirmed extends $pb.GeneratedMessage {
  factory Unconfirmed() => create();
  Unconfirmed._() : super();
  factory Unconfirmed.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Unconfirmed.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Unconfirmed', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Unconfirmed clone() => Unconfirmed()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Unconfirmed copyWith(void Function(Unconfirmed) updates) => super.copyWith((message) => updates(message as Unconfirmed)) as Unconfirmed;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Unconfirmed create() => Unconfirmed._();
  Unconfirmed createEmptyInstance() => create();
  static $pb.PbList<Unconfirmed> createRepeated() => $pb.PbList<Unconfirmed>();
  @$core.pragma('dart2js:noInline')
  static Unconfirmed getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Unconfirmed>(create);
  static Unconfirmed? _defaultInstance;
}

/// Represents a BOLT 11 payment.
class Bolt11 extends $pb.GeneratedMessage {
  factory Bolt11({
    $core.String? hash,
    $core.String? preimage,
    $core.List<$core.int>? secret,
    $fixnum.Int64? counterpartySkimmedFeeMsat,
  }) {
    final $result = create();
    if (hash != null) {
      $result.hash = hash;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (secret != null) {
      $result.secret = secret;
    }
    if (counterpartySkimmedFeeMsat != null) {
      $result.counterpartySkimmedFeeMsat = counterpartySkimmedFeeMsat;
    }
    return $result;
  }
  Bolt11._() : super();
  factory Bolt11.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..aOS(2, _omitFieldNames ? '' : 'preimage')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'secret', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'counterpartySkimmedFeeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11 clone() => Bolt11()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11 copyWith(void Function(Bolt11) updates) => super.copyWith((message) => updates(message as Bolt11)) as Bolt11;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11 create() => Bolt11._();
  Bolt11 createEmptyInstance() => create();
  static $pb.PbList<Bolt11> createRepeated() => $pb.PbList<Bolt11>();
  @$core.pragma('dart2js:noInline')
  static Bolt11 getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11>(create);
  static Bolt11? _defaultInstance;

  /// The payment hash, i.e., the hash of the preimage.
  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);

  /// The pre-image used by the payment.
  @$pb.TagNumber(2)
  $core.String get preimage => $_getSZ(1);
  @$pb.TagNumber(2)
  set preimage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreimage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreimage() => $_clearField(2);

  /// The secret used by the payment.
  @$pb.TagNumber(3)
  $core.List<$core.int> get secret => $_getN(2);
  @$pb.TagNumber(3)
  set secret($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecret() => $_clearField(3);

  ///  The value, in thousands of a satoshi, that was deducted from this payment as an extra
  ///  fee taken by our channel counterparty.
  ///
  ///  Will only ever be `Some` for inbound payments received via an [bLIP-52 / LSPS 2]
  ///  just-in-time channel, and only after the payment is observed; `None` otherwise.
  ///
  ///  [bLIP-52 / LSPS 2]: https://github.com/lightning/blips/blob/master/blip-0052.md
  @$pb.TagNumber(4)
  $fixnum.Int64 get counterpartySkimmedFeeMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set counterpartySkimmedFeeMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCounterpartySkimmedFeeMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearCounterpartySkimmedFeeMsat() => $_clearField(4);
}

/// Represents a BOLT 12 ‘offer’ payment, i.e., a payment for an Offer.
class Bolt12Offer extends $pb.GeneratedMessage {
  factory Bolt12Offer({
    $core.String? hash,
    $core.String? preimage,
    $core.List<$core.int>? secret,
    $core.String? offerId,
    $core.String? payerNote,
    $fixnum.Int64? quantity,
  }) {
    final $result = create();
    if (hash != null) {
      $result.hash = hash;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (secret != null) {
      $result.secret = secret;
    }
    if (offerId != null) {
      $result.offerId = offerId;
    }
    if (payerNote != null) {
      $result.payerNote = payerNote;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    return $result;
  }
  Bolt12Offer._() : super();
  factory Bolt12Offer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12Offer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12Offer', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..aOS(2, _omitFieldNames ? '' : 'preimage')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'secret', $pb.PbFieldType.OY)
    ..aOS(4, _omitFieldNames ? '' : 'offerId')
    ..aOS(5, _omitFieldNames ? '' : 'payerNote')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12Offer clone() => Bolt12Offer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12Offer copyWith(void Function(Bolt12Offer) updates) => super.copyWith((message) => updates(message as Bolt12Offer)) as Bolt12Offer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12Offer create() => Bolt12Offer._();
  Bolt12Offer createEmptyInstance() => create();
  static $pb.PbList<Bolt12Offer> createRepeated() => $pb.PbList<Bolt12Offer>();
  @$core.pragma('dart2js:noInline')
  static Bolt12Offer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12Offer>(create);
  static Bolt12Offer? _defaultInstance;

  /// The payment hash, i.e., the hash of the preimage.
  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);

  /// The pre-image used by the payment.
  @$pb.TagNumber(2)
  $core.String get preimage => $_getSZ(1);
  @$pb.TagNumber(2)
  set preimage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreimage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreimage() => $_clearField(2);

  /// The secret used by the payment.
  @$pb.TagNumber(3)
  $core.List<$core.int> get secret => $_getN(2);
  @$pb.TagNumber(3)
  set secret($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecret() => $_clearField(3);

  /// The hex-encoded ID of the offer this payment is for.
  @$pb.TagNumber(4)
  $core.String get offerId => $_getSZ(3);
  @$pb.TagNumber(4)
  set offerId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOfferId() => $_has(3);
  @$pb.TagNumber(4)
  void clearOfferId() => $_clearField(4);

  ///  The payer's note for the payment.
  ///  Truncated to [PAYER_NOTE_LIMIT](https://docs.rs/lightning/latest/lightning/offers/invoice_request/constant.PAYER_NOTE_LIMIT.html).
  ///
  ///  **Caution**: The `payer_note` field may come from an untrusted source. To prevent potential misuse,
  ///  all non-printable characters will be sanitized and replaced with safe characters.
  @$pb.TagNumber(5)
  $core.String get payerNote => $_getSZ(4);
  @$pb.TagNumber(5)
  set payerNote($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPayerNote() => $_has(4);
  @$pb.TagNumber(5)
  void clearPayerNote() => $_clearField(5);

  /// The quantity of an item requested in the offer.
  @$pb.TagNumber(6)
  $fixnum.Int64 get quantity => $_getI64(5);
  @$pb.TagNumber(6)
  set quantity($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(5);
  @$pb.TagNumber(6)
  void clearQuantity() => $_clearField(6);
}

/// Represents a BOLT 12 ‘refund’ payment, i.e., a payment for a Refund.
class Bolt12Refund extends $pb.GeneratedMessage {
  factory Bolt12Refund({
    $core.String? hash,
    $core.String? preimage,
    $core.List<$core.int>? secret,
    $core.String? payerNote,
    $fixnum.Int64? quantity,
  }) {
    final $result = create();
    if (hash != null) {
      $result.hash = hash;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    if (secret != null) {
      $result.secret = secret;
    }
    if (payerNote != null) {
      $result.payerNote = payerNote;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    return $result;
  }
  Bolt12Refund._() : super();
  factory Bolt12Refund.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12Refund.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12Refund', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..aOS(2, _omitFieldNames ? '' : 'preimage')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'secret', $pb.PbFieldType.OY)
    ..aOS(5, _omitFieldNames ? '' : 'payerNote')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12Refund clone() => Bolt12Refund()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12Refund copyWith(void Function(Bolt12Refund) updates) => super.copyWith((message) => updates(message as Bolt12Refund)) as Bolt12Refund;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12Refund create() => Bolt12Refund._();
  Bolt12Refund createEmptyInstance() => create();
  static $pb.PbList<Bolt12Refund> createRepeated() => $pb.PbList<Bolt12Refund>();
  @$core.pragma('dart2js:noInline')
  static Bolt12Refund getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12Refund>(create);
  static Bolt12Refund? _defaultInstance;

  /// The payment hash, i.e., the hash of the preimage.
  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);

  /// The pre-image used by the payment.
  @$pb.TagNumber(2)
  $core.String get preimage => $_getSZ(1);
  @$pb.TagNumber(2)
  set preimage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreimage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreimage() => $_clearField(2);

  /// The secret used by the payment.
  @$pb.TagNumber(3)
  $core.List<$core.int> get secret => $_getN(2);
  @$pb.TagNumber(3)
  set secret($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearSecret() => $_clearField(3);

  ///  The payer's note for the payment.
  ///  Truncated to [PAYER_NOTE_LIMIT](https://docs.rs/lightning/latest/lightning/offers/invoice_request/constant.PAYER_NOTE_LIMIT.html).
  ///
  ///  **Caution**: The `payer_note` field may come from an untrusted source. To prevent potential misuse,
  ///  all non-printable characters will be sanitized and replaced with safe characters.
  @$pb.TagNumber(5)
  $core.String get payerNote => $_getSZ(3);
  @$pb.TagNumber(5)
  set payerNote($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasPayerNote() => $_has(3);
  @$pb.TagNumber(5)
  void clearPayerNote() => $_clearField(5);

  /// The quantity of an item requested in the offer.
  @$pb.TagNumber(6)
  $fixnum.Int64 get quantity => $_getI64(4);
  @$pb.TagNumber(6)
  set quantity($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasQuantity() => $_has(4);
  @$pb.TagNumber(6)
  void clearQuantity() => $_clearField(6);
}

/// Represents a spontaneous (“keysend”) payment.
class Spontaneous extends $pb.GeneratedMessage {
  factory Spontaneous({
    $core.String? hash,
    $core.String? preimage,
  }) {
    final $result = create();
    if (hash != null) {
      $result.hash = hash;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    return $result;
  }
  Spontaneous._() : super();
  factory Spontaneous.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Spontaneous.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Spontaneous', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'hash')
    ..aOS(2, _omitFieldNames ? '' : 'preimage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Spontaneous clone() => Spontaneous()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Spontaneous copyWith(void Function(Spontaneous) updates) => super.copyWith((message) => updates(message as Spontaneous)) as Spontaneous;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Spontaneous create() => Spontaneous._();
  Spontaneous createEmptyInstance() => create();
  static $pb.PbList<Spontaneous> createRepeated() => $pb.PbList<Spontaneous>();
  @$core.pragma('dart2js:noInline')
  static Spontaneous getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Spontaneous>(create);
  static Spontaneous? _defaultInstance;

  /// The payment hash, i.e., the hash of the preimage.
  @$pb.TagNumber(1)
  $core.String get hash => $_getSZ(0);
  @$pb.TagNumber(1)
  set hash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);

  /// The pre-image used by the payment.
  @$pb.TagNumber(2)
  $core.String get preimage => $_getSZ(1);
  @$pb.TagNumber(2)
  set preimage($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPreimage() => $_has(1);
  @$pb.TagNumber(2)
  void clearPreimage() => $_clearField(2);
}

///  Limits applying to how much fee we allow an LSP to deduct from the payment amount.
///  See [`LdkChannelConfig::accept_underpaying_htlcs`] for more information.
///
///  [`LdkChannelConfig::accept_underpaying_htlcs`]: lightning::util::config::ChannelConfig::accept_underpaying_htlcs
class LSPFeeLimits extends $pb.GeneratedMessage {
  factory LSPFeeLimits({
    $fixnum.Int64? maxTotalOpeningFeeMsat,
    $fixnum.Int64? maxProportionalOpeningFeePpmMsat,
  }) {
    final $result = create();
    if (maxTotalOpeningFeeMsat != null) {
      $result.maxTotalOpeningFeeMsat = maxTotalOpeningFeeMsat;
    }
    if (maxProportionalOpeningFeePpmMsat != null) {
      $result.maxProportionalOpeningFeePpmMsat = maxProportionalOpeningFeePpmMsat;
    }
    return $result;
  }
  LSPFeeLimits._() : super();
  factory LSPFeeLimits.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LSPFeeLimits.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LSPFeeLimits', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'maxTotalOpeningFeeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'maxProportionalOpeningFeePpmMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LSPFeeLimits clone() => LSPFeeLimits()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LSPFeeLimits copyWith(void Function(LSPFeeLimits) updates) => super.copyWith((message) => updates(message as LSPFeeLimits)) as LSPFeeLimits;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LSPFeeLimits create() => LSPFeeLimits._();
  LSPFeeLimits createEmptyInstance() => create();
  static $pb.PbList<LSPFeeLimits> createRepeated() => $pb.PbList<LSPFeeLimits>();
  @$core.pragma('dart2js:noInline')
  static LSPFeeLimits getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LSPFeeLimits>(create);
  static LSPFeeLimits? _defaultInstance;

  /// The maximal total amount we allow any configured LSP withhold from us when forwarding the
  /// payment.
  @$pb.TagNumber(1)
  $fixnum.Int64 get maxTotalOpeningFeeMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set maxTotalOpeningFeeMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaxTotalOpeningFeeMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxTotalOpeningFeeMsat() => $_clearField(1);

  /// The maximal proportional fee, in parts-per-million millisatoshi, we allow any configured
  /// LSP withhold from us when forwarding the payment.
  @$pb.TagNumber(2)
  $fixnum.Int64 get maxProportionalOpeningFeePpmMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set maxProportionalOpeningFeePpmMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxProportionalOpeningFeePpmMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxProportionalOpeningFeePpmMsat() => $_clearField(2);
}

/// Identifies the channel and counterparty that an HTLC was processed with.
class HtlcLocator extends $pb.GeneratedMessage {
  factory HtlcLocator({
    $core.String? channelId,
    $core.String? userChannelId,
    $core.String? nodeId,
    $fixnum.Int64? amountMsat,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    return $result;
  }
  HtlcLocator._() : super();
  factory HtlcLocator.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HtlcLocator.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'HtlcLocator', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(3, _omitFieldNames ? '' : 'nodeId')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  HtlcLocator clone() => HtlcLocator()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  HtlcLocator copyWith(void Function(HtlcLocator) updates) => super.copyWith((message) => updates(message as HtlcLocator)) as HtlcLocator;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HtlcLocator create() => HtlcLocator._();
  HtlcLocator createEmptyInstance() => create();
  static $pb.PbList<HtlcLocator> createRepeated() => $pb.PbList<HtlcLocator>();
  @$core.pragma('dart2js:noInline')
  static HtlcLocator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HtlcLocator>(create);
  static HtlcLocator? _defaultInstance;

  /// The channel that the HTLC was sent or received on.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The `user_channel_id` for the channel.
  /// This can be unset for older serialized events or if the payment was settled on-chain.
  @$pb.TagNumber(2)
  $core.String get userChannelId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userChannelId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserChannelId() => $_clearField(2);

  /// The node id of the counterparty for this HTLC.
  /// This can be unset for older serialized events.
  @$pb.TagNumber(3)
  $core.String get nodeId => $_getSZ(2);
  @$pb.TagNumber(3)
  set nodeId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasNodeId() => $_has(2);
  @$pb.TagNumber(3)
  void clearNodeId() => $_clearField(3);

  /// The amount in millisatoshis of the HTLC that was sent or received, if known.
  /// This can be unset for events serialized by LDK Node v0.7.0 and prior,
  /// or forwarding records stored by LDK Server before this field was added.
  @$pb.TagNumber(4)
  $fixnum.Int64 get amountMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set amountMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountMsat() => $_clearField(4);
}

///  A forwarded payment through our node.
///
///  A forwarded payment can involve multiple incoming and outgoing HTLCs, e.g. when acting as a
///  trampoline router. The `prev_htlcs` and `next_htlcs` fields are the canonical representation of
///  the HTLCs associated with this forwarding event. Their indices do not imply pairwise
///  correspondence.
///
///  See more: https://docs.rs/ldk-node/latest/ldk_node/enum.Event.html#variant.PaymentForwarded
class ForwardedPayment extends $pb.GeneratedMessage {
  factory ForwardedPayment({
    $fixnum.Int64? totalFeeEarnedMsat,
    $fixnum.Int64? skimmedFeeMsat,
    $core.bool? claimFromOnchainTx,
    $fixnum.Int64? outboundAmountForwardedMsat,
    $core.Iterable<HtlcLocator>? prevHtlcs,
    $core.Iterable<HtlcLocator>? nextHtlcs,
  }) {
    final $result = create();
    if (totalFeeEarnedMsat != null) {
      $result.totalFeeEarnedMsat = totalFeeEarnedMsat;
    }
    if (skimmedFeeMsat != null) {
      $result.skimmedFeeMsat = skimmedFeeMsat;
    }
    if (claimFromOnchainTx != null) {
      $result.claimFromOnchainTx = claimFromOnchainTx;
    }
    if (outboundAmountForwardedMsat != null) {
      $result.outboundAmountForwardedMsat = outboundAmountForwardedMsat;
    }
    if (prevHtlcs != null) {
      $result.prevHtlcs.addAll(prevHtlcs);
    }
    if (nextHtlcs != null) {
      $result.nextHtlcs.addAll(nextHtlcs);
    }
    return $result;
  }
  ForwardedPayment._() : super();
  factory ForwardedPayment.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForwardedPayment.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForwardedPayment', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalFeeEarnedMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'skimmedFeeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(3, _omitFieldNames ? '' : 'claimFromOnchainTx')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'outboundAmountForwardedMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<HtlcLocator>(5, _omitFieldNames ? '' : 'prevHtlcs', $pb.PbFieldType.PM, subBuilder: HtlcLocator.create)
    ..pc<HtlcLocator>(6, _omitFieldNames ? '' : 'nextHtlcs', $pb.PbFieldType.PM, subBuilder: HtlcLocator.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForwardedPayment clone() => ForwardedPayment()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForwardedPayment copyWith(void Function(ForwardedPayment) updates) => super.copyWith((message) => updates(message as ForwardedPayment)) as ForwardedPayment;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForwardedPayment create() => ForwardedPayment._();
  ForwardedPayment createEmptyInstance() => create();
  static $pb.PbList<ForwardedPayment> createRepeated() => $pb.PbList<ForwardedPayment>();
  @$core.pragma('dart2js:noInline')
  static ForwardedPayment getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardedPayment>(create);
  static ForwardedPayment? _defaultInstance;

  ///  The total fee, in milli-satoshis, which was earned as a result of the payment.
  ///
  ///  Note that if we force-closed the channel over which we forwarded an HTLC while the HTLC was pending, the amount the
  ///  next hop claimed will have been rounded down to the nearest whole satoshi. Thus, the fee calculated here may be
  ///  higher than expected as we still claimed the full value in millisatoshis from the source.
  ///  In this case, `claim_from_onchain_tx` will be set.
  ///
  ///  If the channel which sent us the payment has been force-closed, we will claim the funds via an on-chain transaction.
  ///  In that case we do not yet know the on-chain transaction fees which we will spend and will instead set this to `None`.
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalFeeEarnedMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set totalFeeEarnedMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalFeeEarnedMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalFeeEarnedMsat() => $_clearField(1);

  ///  The share of the total fee, in milli-satoshis, which was withheld in addition to the forwarding fee.
  ///  This will only be set if we forwarded an intercepted HTLC with less than the expected amount. This means our
  ///  counterparty accepted to receive less than the invoice amount.
  ///
  ///  The caveat described above the `total_fee_earned_msat` field applies here as well.
  @$pb.TagNumber(2)
  $fixnum.Int64 get skimmedFeeMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set skimmedFeeMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSkimmedFeeMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearSkimmedFeeMsat() => $_clearField(2);

  /// If this is true, the forwarded HTLC was claimed by our counterparty via an on-chain transaction.
  @$pb.TagNumber(3)
  $core.bool get claimFromOnchainTx => $_getBF(2);
  @$pb.TagNumber(3)
  set claimFromOnchainTx($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasClaimFromOnchainTx() => $_has(2);
  @$pb.TagNumber(3)
  void clearClaimFromOnchainTx() => $_clearField(3);

  ///  The final amount forwarded, in milli-satoshis, after the fee is deducted.
  ///
  ///  The caveat described above the `total_fee_earned_msat` field applies here as well.
  @$pb.TagNumber(4)
  $fixnum.Int64 get outboundAmountForwardedMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set outboundAmountForwardedMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOutboundAmountForwardedMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearOutboundAmountForwardedMsat() => $_clearField(4);

  /// The set of incoming HTLCs forwarded to our node that will be claimed by this forward.
  /// This is the canonical incoming HTLC representation.
  @$pb.TagNumber(5)
  $pb.PbList<HtlcLocator> get prevHtlcs => $_getList(4);

  /// The set of outgoing HTLCs forwarded by our node that have been claimed by this forward.
  /// This is the canonical outgoing HTLC representation.
  @$pb.TagNumber(6)
  $pb.PbList<HtlcLocator> get nextHtlcs => $_getList(5);
}

class Channel extends $pb.GeneratedMessage {
  factory Channel({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    OutPoint? fundingTxo,
    $core.String? userChannelId,
    $fixnum.Int64? unspendablePunishmentReserve,
    $fixnum.Int64? channelValueSats,
    $core.int? feerateSatPer1000Weight,
    $fixnum.Int64? outboundCapacityMsat,
    $fixnum.Int64? inboundCapacityMsat,
    $core.int? confirmationsRequired,
    $core.int? confirmations,
    $core.bool? isOutbound,
    $core.bool? isChannelReady,
    $core.bool? isUsable,
    $core.bool? isAnnounced,
    ChannelConfig? channelConfig,
    $fixnum.Int64? nextOutboundHtlcLimitMsat,
    $fixnum.Int64? nextOutboundHtlcMinimumMsat,
    $core.int? forceCloseSpendDelay,
    $fixnum.Int64? counterpartyOutboundHtlcMinimumMsat,
    $fixnum.Int64? counterpartyOutboundHtlcMaximumMsat,
    $fixnum.Int64? counterpartyUnspendablePunishmentReserve,
    $core.int? counterpartyForwardingInfoFeeBaseMsat,
    $core.int? counterpartyForwardingInfoFeeProportionalMillionths,
    $core.int? counterpartyForwardingInfoCltvExpiryDelta,
    $fixnum.Int64? shortChannelId,
    $fixnum.Int64? outboundScidAlias,
    $fixnum.Int64? inboundScidAlias,
    $fixnum.Int64? inboundHtlcMinimumMsat,
    $fixnum.Int64? inboundHtlcMaximumMsat,
    ChannelShutdownState? channelShutdownState,
    ReserveType? reserveType,
    $pb.PbMap<$core.int, Feature>? channelType,
    $pb.PbMap<$core.int, Feature>? counterpartyFeatures,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (fundingTxo != null) {
      $result.fundingTxo = fundingTxo;
    }
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (unspendablePunishmentReserve != null) {
      $result.unspendablePunishmentReserve = unspendablePunishmentReserve;
    }
    if (channelValueSats != null) {
      $result.channelValueSats = channelValueSats;
    }
    if (feerateSatPer1000Weight != null) {
      $result.feerateSatPer1000Weight = feerateSatPer1000Weight;
    }
    if (outboundCapacityMsat != null) {
      $result.outboundCapacityMsat = outboundCapacityMsat;
    }
    if (inboundCapacityMsat != null) {
      $result.inboundCapacityMsat = inboundCapacityMsat;
    }
    if (confirmationsRequired != null) {
      $result.confirmationsRequired = confirmationsRequired;
    }
    if (confirmations != null) {
      $result.confirmations = confirmations;
    }
    if (isOutbound != null) {
      $result.isOutbound = isOutbound;
    }
    if (isChannelReady != null) {
      $result.isChannelReady = isChannelReady;
    }
    if (isUsable != null) {
      $result.isUsable = isUsable;
    }
    if (isAnnounced != null) {
      $result.isAnnounced = isAnnounced;
    }
    if (channelConfig != null) {
      $result.channelConfig = channelConfig;
    }
    if (nextOutboundHtlcLimitMsat != null) {
      $result.nextOutboundHtlcLimitMsat = nextOutboundHtlcLimitMsat;
    }
    if (nextOutboundHtlcMinimumMsat != null) {
      $result.nextOutboundHtlcMinimumMsat = nextOutboundHtlcMinimumMsat;
    }
    if (forceCloseSpendDelay != null) {
      $result.forceCloseSpendDelay = forceCloseSpendDelay;
    }
    if (counterpartyOutboundHtlcMinimumMsat != null) {
      $result.counterpartyOutboundHtlcMinimumMsat = counterpartyOutboundHtlcMinimumMsat;
    }
    if (counterpartyOutboundHtlcMaximumMsat != null) {
      $result.counterpartyOutboundHtlcMaximumMsat = counterpartyOutboundHtlcMaximumMsat;
    }
    if (counterpartyUnspendablePunishmentReserve != null) {
      $result.counterpartyUnspendablePunishmentReserve = counterpartyUnspendablePunishmentReserve;
    }
    if (counterpartyForwardingInfoFeeBaseMsat != null) {
      $result.counterpartyForwardingInfoFeeBaseMsat = counterpartyForwardingInfoFeeBaseMsat;
    }
    if (counterpartyForwardingInfoFeeProportionalMillionths != null) {
      $result.counterpartyForwardingInfoFeeProportionalMillionths = counterpartyForwardingInfoFeeProportionalMillionths;
    }
    if (counterpartyForwardingInfoCltvExpiryDelta != null) {
      $result.counterpartyForwardingInfoCltvExpiryDelta = counterpartyForwardingInfoCltvExpiryDelta;
    }
    if (shortChannelId != null) {
      $result.shortChannelId = shortChannelId;
    }
    if (outboundScidAlias != null) {
      $result.outboundScidAlias = outboundScidAlias;
    }
    if (inboundScidAlias != null) {
      $result.inboundScidAlias = inboundScidAlias;
    }
    if (inboundHtlcMinimumMsat != null) {
      $result.inboundHtlcMinimumMsat = inboundHtlcMinimumMsat;
    }
    if (inboundHtlcMaximumMsat != null) {
      $result.inboundHtlcMaximumMsat = inboundHtlcMaximumMsat;
    }
    if (channelShutdownState != null) {
      $result.channelShutdownState = channelShutdownState;
    }
    if (reserveType != null) {
      $result.reserveType = reserveType;
    }
    if (channelType != null) {
      $result.channelType.addAll(channelType);
    }
    if (counterpartyFeatures != null) {
      $result.counterpartyFeatures.addAll(counterpartyFeatures);
    }
    return $result;
  }
  Channel._() : super();
  factory Channel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Channel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Channel', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOM<OutPoint>(3, _omitFieldNames ? '' : 'fundingTxo', subBuilder: OutPoint.create)
    ..aOS(4, _omitFieldNames ? '' : 'userChannelId')
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'unspendablePunishmentReserve', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'channelValueSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(7, _omitFieldNames ? '' : 'feerateSatPer1000Weight', $pb.PbFieldType.OU3, protoName: 'feerate_sat_per_1000_weight')
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'outboundCapacityMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'inboundCapacityMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'confirmationsRequired', $pb.PbFieldType.OU3)
    ..a<$core.int>(11, _omitFieldNames ? '' : 'confirmations', $pb.PbFieldType.OU3)
    ..aOB(12, _omitFieldNames ? '' : 'isOutbound')
    ..aOB(13, _omitFieldNames ? '' : 'isChannelReady')
    ..aOB(14, _omitFieldNames ? '' : 'isUsable')
    ..aOB(15, _omitFieldNames ? '' : 'isAnnounced')
    ..aOM<ChannelConfig>(16, _omitFieldNames ? '' : 'channelConfig', subBuilder: ChannelConfig.create)
    ..a<$fixnum.Int64>(17, _omitFieldNames ? '' : 'nextOutboundHtlcLimitMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(18, _omitFieldNames ? '' : 'nextOutboundHtlcMinimumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(19, _omitFieldNames ? '' : 'forceCloseSpendDelay', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(20, _omitFieldNames ? '' : 'counterpartyOutboundHtlcMinimumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(21, _omitFieldNames ? '' : 'counterpartyOutboundHtlcMaximumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(22, _omitFieldNames ? '' : 'counterpartyUnspendablePunishmentReserve', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(23, _omitFieldNames ? '' : 'counterpartyForwardingInfoFeeBaseMsat', $pb.PbFieldType.OU3)
    ..a<$core.int>(24, _omitFieldNames ? '' : 'counterpartyForwardingInfoFeeProportionalMillionths', $pb.PbFieldType.OU3)
    ..a<$core.int>(25, _omitFieldNames ? '' : 'counterpartyForwardingInfoCltvExpiryDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(26, _omitFieldNames ? '' : 'shortChannelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(27, _omitFieldNames ? '' : 'outboundScidAlias', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(28, _omitFieldNames ? '' : 'inboundScidAlias', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(29, _omitFieldNames ? '' : 'inboundHtlcMinimumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(30, _omitFieldNames ? '' : 'inboundHtlcMaximumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<ChannelShutdownState>(31, _omitFieldNames ? '' : 'channelShutdownState', $pb.PbFieldType.OE, defaultOrMaker: ChannelShutdownState.CHANNEL_SHUTDOWN_STATE_UNSPECIFIED, valueOf: ChannelShutdownState.valueOf, enumValues: ChannelShutdownState.values)
    ..e<ReserveType>(32, _omitFieldNames ? '' : 'reserveType', $pb.PbFieldType.OE, defaultOrMaker: ReserveType.RESERVE_TYPE_UNSPECIFIED, valueOf: ReserveType.valueOf, enumValues: ReserveType.values)
    ..m<$core.int, Feature>(33, _omitFieldNames ? '' : 'channelType', entryClassName: 'Channel.ChannelTypeEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('types'))
    ..m<$core.int, Feature>(34, _omitFieldNames ? '' : 'counterpartyFeatures', entryClassName: 'Channel.CounterpartyFeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('types'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Channel clone() => Channel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Channel copyWith(void Function(Channel) updates) => super.copyWith((message) => updates(message as Channel)) as Channel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Channel create() => Channel._();
  Channel createEmptyInstance() => create();
  static $pb.PbList<Channel> createRepeated() => $pb.PbList<Channel>();
  @$core.pragma('dart2js:noInline')
  static Channel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Channel>(create);
  static Channel? _defaultInstance;

  ///  The channel ID (prior to funding transaction generation, this is a random 32-byte
  ///  identifier, afterwards this is the transaction ID of the funding transaction XOR the
  ///  funding transaction output).
  ///
  ///  Note that this means this value is *not* persistent - it can change once during the
  ///  lifetime of the channel.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The node ID of our the channel's remote counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The channel's funding transaction output, if we've negotiated the funding transaction with
  /// our counterparty already.
  @$pb.TagNumber(3)
  OutPoint get fundingTxo => $_getN(2);
  @$pb.TagNumber(3)
  set fundingTxo(OutPoint v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFundingTxo() => $_has(2);
  @$pb.TagNumber(3)
  void clearFundingTxo() => $_clearField(3);
  @$pb.TagNumber(3)
  OutPoint ensureFundingTxo() => $_ensure(2);

  /// The hex-encoded local `user_channel_id` of this channel.
  @$pb.TagNumber(4)
  $core.String get userChannelId => $_getSZ(3);
  @$pb.TagNumber(4)
  set userChannelId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasUserChannelId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserChannelId() => $_clearField(4);

  ///  The value, in satoshis, that must always be held as a reserve in the channel for us. This
  ///  value ensures that if we broadcast a revoked state, our counterparty can punish us by
  ///  claiming at least this value on chain.
  ///
  ///  This value is not included in [`outbound_capacity_msat`] as it can never be spent.
  ///
  ///  This value will be `None` for outbound channels until the counterparty accepts the channel.
  @$pb.TagNumber(5)
  $fixnum.Int64 get unspendablePunishmentReserve => $_getI64(4);
  @$pb.TagNumber(5)
  set unspendablePunishmentReserve($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnspendablePunishmentReserve() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnspendablePunishmentReserve() => $_clearField(5);

  /// The value, in satoshis, of this channel as it appears in the funding output.
  @$pb.TagNumber(6)
  $fixnum.Int64 get channelValueSats => $_getI64(5);
  @$pb.TagNumber(6)
  set channelValueSats($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasChannelValueSats() => $_has(5);
  @$pb.TagNumber(6)
  void clearChannelValueSats() => $_clearField(6);

  /// The currently negotiated fee rate denominated in satoshi per 1000 weight units,
  /// which is applied to commitment and HTLC transactions.
  @$pb.TagNumber(7)
  $core.int get feerateSatPer1000Weight => $_getIZ(6);
  @$pb.TagNumber(7)
  set feerateSatPer1000Weight($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFeerateSatPer1000Weight() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeerateSatPer1000Weight() => $_clearField(7);

  ///  The available outbound capacity for sending HTLCs to the remote peer.
  ///
  ///  The amount does not include any pending HTLCs which are not yet resolved (and, thus, whose
  ///  balance is not available for inclusion in new outbound HTLCs). This further does not include
  ///  any pending outgoing HTLCs which are awaiting some other resolution to be sent.
  @$pb.TagNumber(8)
  $fixnum.Int64 get outboundCapacityMsat => $_getI64(7);
  @$pb.TagNumber(8)
  set outboundCapacityMsat($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasOutboundCapacityMsat() => $_has(7);
  @$pb.TagNumber(8)
  void clearOutboundCapacityMsat() => $_clearField(8);

  ///  The available outbound capacity for sending HTLCs to the remote peer.
  ///
  ///  The amount does not include any pending HTLCs which are not yet resolved
  ///  (and, thus, whose balance is not available for inclusion in new inbound HTLCs). This further
  ///  does not include any pending outgoing HTLCs which are awaiting some other resolution to be
  ///  sent.
  @$pb.TagNumber(9)
  $fixnum.Int64 get inboundCapacityMsat => $_getI64(8);
  @$pb.TagNumber(9)
  set inboundCapacityMsat($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasInboundCapacityMsat() => $_has(8);
  @$pb.TagNumber(9)
  void clearInboundCapacityMsat() => $_clearField(9);

  ///  The number of required confirmations on the funding transactions before the funding is
  ///  considered "locked". The amount is selected by the channel fundee.
  ///
  ///  The value will be `None` for outbound channels until the counterparty accepts the channel.
  @$pb.TagNumber(10)
  $core.int get confirmationsRequired => $_getIZ(9);
  @$pb.TagNumber(10)
  set confirmationsRequired($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasConfirmationsRequired() => $_has(9);
  @$pb.TagNumber(10)
  void clearConfirmationsRequired() => $_clearField(10);

  /// The current number of confirmations on the funding transaction.
  @$pb.TagNumber(11)
  $core.int get confirmations => $_getIZ(10);
  @$pb.TagNumber(11)
  set confirmations($core.int v) { $_setUnsignedInt32(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasConfirmations() => $_has(10);
  @$pb.TagNumber(11)
  void clearConfirmations() => $_clearField(11);

  /// Is `true` if the channel was initiated (and therefore funded) by us.
  @$pb.TagNumber(12)
  $core.bool get isOutbound => $_getBF(11);
  @$pb.TagNumber(12)
  set isOutbound($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsOutbound() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsOutbound() => $_clearField(12);

  /// Is `true` if both parties have exchanged `channel_ready` messages, and the channel is
  /// not currently being shut down. Both parties exchange `channel_ready` messages upon
  /// independently verifying that the required confirmations count provided by
  /// `confirmations_required` has been reached.
  @$pb.TagNumber(13)
  $core.bool get isChannelReady => $_getBF(12);
  @$pb.TagNumber(13)
  set isChannelReady($core.bool v) { $_setBool(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasIsChannelReady() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsChannelReady() => $_clearField(13);

  ///  Is `true` if the channel (a) `channel_ready` messages have been exchanged, (b) the
  ///  peer is connected, and (c) the channel is not currently negotiating shutdown.
  ///
  ///  This is a strict superset of `is_channel_ready`.
  @$pb.TagNumber(14)
  $core.bool get isUsable => $_getBF(13);
  @$pb.TagNumber(14)
  set isUsable($core.bool v) { $_setBool(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasIsUsable() => $_has(13);
  @$pb.TagNumber(14)
  void clearIsUsable() => $_clearField(14);

  /// Is `true` if this channel is (or will be) publicly-announced
  @$pb.TagNumber(15)
  $core.bool get isAnnounced => $_getBF(14);
  @$pb.TagNumber(15)
  set isAnnounced($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasIsAnnounced() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsAnnounced() => $_clearField(15);

  /// Set of configurable parameters set by self that affect channel operation.
  @$pb.TagNumber(16)
  ChannelConfig get channelConfig => $_getN(15);
  @$pb.TagNumber(16)
  set channelConfig(ChannelConfig v) { $_setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasChannelConfig() => $_has(15);
  @$pb.TagNumber(16)
  void clearChannelConfig() => $_clearField(16);
  @$pb.TagNumber(16)
  ChannelConfig ensureChannelConfig() => $_ensure(15);

  /// The available outbound capacity for sending a single HTLC to the remote peer. This is
  /// similar to `outbound_capacity_msat` but it may be further restricted by
  /// the current state and per-HTLC limit(s). This is intended for use when routing, allowing us
  /// to use a limit as close as possible to the HTLC limit we can currently send.
  @$pb.TagNumber(17)
  $fixnum.Int64 get nextOutboundHtlcLimitMsat => $_getI64(16);
  @$pb.TagNumber(17)
  set nextOutboundHtlcLimitMsat($fixnum.Int64 v) { $_setInt64(16, v); }
  @$pb.TagNumber(17)
  $core.bool hasNextOutboundHtlcLimitMsat() => $_has(16);
  @$pb.TagNumber(17)
  void clearNextOutboundHtlcLimitMsat() => $_clearField(17);

  /// The minimum value for sending a single HTLC to the remote peer. This is the equivalent of
  /// `next_outbound_htlc_limit_msat` but represents a lower-bound, rather than
  /// an upper-bound. This is intended for use when routing, allowing us to ensure we pick a
  /// route which is valid.
  @$pb.TagNumber(18)
  $fixnum.Int64 get nextOutboundHtlcMinimumMsat => $_getI64(17);
  @$pb.TagNumber(18)
  set nextOutboundHtlcMinimumMsat($fixnum.Int64 v) { $_setInt64(17, v); }
  @$pb.TagNumber(18)
  $core.bool hasNextOutboundHtlcMinimumMsat() => $_has(17);
  @$pb.TagNumber(18)
  void clearNextOutboundHtlcMinimumMsat() => $_clearField(18);

  ///  The number of blocks (after our commitment transaction confirms) that we will need to wait
  ///  until we can claim our funds after we force-close the channel. During this time our
  ///  counterparty is allowed to punish us if we broadcasted a stale state. If our counterparty
  ///  force-closes the channel and broadcasts a commitment transaction we do not have to wait any
  ///  time to claim our non-HTLC-encumbered funds.
  ///
  ///  This value will be `None` for outbound channels until the counterparty accepts the channel.
  @$pb.TagNumber(19)
  $core.int get forceCloseSpendDelay => $_getIZ(18);
  @$pb.TagNumber(19)
  set forceCloseSpendDelay($core.int v) { $_setUnsignedInt32(18, v); }
  @$pb.TagNumber(19)
  $core.bool hasForceCloseSpendDelay() => $_has(18);
  @$pb.TagNumber(19)
  void clearForceCloseSpendDelay() => $_clearField(19);

  ///  The smallest value HTLC (in msat) the remote peer will accept, for this channel.
  ///
  ///  This field is only `None` before we have received either the `OpenChannel` or
  ///  `AcceptChannel` message from the remote peer.
  @$pb.TagNumber(20)
  $fixnum.Int64 get counterpartyOutboundHtlcMinimumMsat => $_getI64(19);
  @$pb.TagNumber(20)
  set counterpartyOutboundHtlcMinimumMsat($fixnum.Int64 v) { $_setInt64(19, v); }
  @$pb.TagNumber(20)
  $core.bool hasCounterpartyOutboundHtlcMinimumMsat() => $_has(19);
  @$pb.TagNumber(20)
  void clearCounterpartyOutboundHtlcMinimumMsat() => $_clearField(20);

  /// The largest value HTLC (in msat) the remote peer currently will accept, for this channel.
  @$pb.TagNumber(21)
  $fixnum.Int64 get counterpartyOutboundHtlcMaximumMsat => $_getI64(20);
  @$pb.TagNumber(21)
  set counterpartyOutboundHtlcMaximumMsat($fixnum.Int64 v) { $_setInt64(20, v); }
  @$pb.TagNumber(21)
  $core.bool hasCounterpartyOutboundHtlcMaximumMsat() => $_has(20);
  @$pb.TagNumber(21)
  void clearCounterpartyOutboundHtlcMaximumMsat() => $_clearField(21);

  ///  The value, in satoshis, that must always be held in the channel for our counterparty. This
  ///  value ensures that if our counterparty broadcasts a revoked state, we can punish them by
  ///  claiming at least this value on chain.
  ///
  ///  This value is not included in `inbound_capacity_msat` as it can never be spent.
  @$pb.TagNumber(22)
  $fixnum.Int64 get counterpartyUnspendablePunishmentReserve => $_getI64(21);
  @$pb.TagNumber(22)
  set counterpartyUnspendablePunishmentReserve($fixnum.Int64 v) { $_setInt64(21, v); }
  @$pb.TagNumber(22)
  $core.bool hasCounterpartyUnspendablePunishmentReserve() => $_has(21);
  @$pb.TagNumber(22)
  void clearCounterpartyUnspendablePunishmentReserve() => $_clearField(22);

  /// Base routing fee in millisatoshis.
  @$pb.TagNumber(23)
  $core.int get counterpartyForwardingInfoFeeBaseMsat => $_getIZ(22);
  @$pb.TagNumber(23)
  set counterpartyForwardingInfoFeeBaseMsat($core.int v) { $_setUnsignedInt32(22, v); }
  @$pb.TagNumber(23)
  $core.bool hasCounterpartyForwardingInfoFeeBaseMsat() => $_has(22);
  @$pb.TagNumber(23)
  void clearCounterpartyForwardingInfoFeeBaseMsat() => $_clearField(23);

  /// Proportional fee, in millionths of a satoshi the channel will charge per transferred satoshi.
  @$pb.TagNumber(24)
  $core.int get counterpartyForwardingInfoFeeProportionalMillionths => $_getIZ(23);
  @$pb.TagNumber(24)
  set counterpartyForwardingInfoFeeProportionalMillionths($core.int v) { $_setUnsignedInt32(23, v); }
  @$pb.TagNumber(24)
  $core.bool hasCounterpartyForwardingInfoFeeProportionalMillionths() => $_has(23);
  @$pb.TagNumber(24)
  void clearCounterpartyForwardingInfoFeeProportionalMillionths() => $_clearField(24);

  /// The minimum difference in CLTV expiry between an ingoing HTLC and its outgoing counterpart,
  /// such that the outgoing HTLC is forwardable to this counterparty.
  @$pb.TagNumber(25)
  $core.int get counterpartyForwardingInfoCltvExpiryDelta => $_getIZ(24);
  @$pb.TagNumber(25)
  set counterpartyForwardingInfoCltvExpiryDelta($core.int v) { $_setUnsignedInt32(24, v); }
  @$pb.TagNumber(25)
  $core.bool hasCounterpartyForwardingInfoCltvExpiryDelta() => $_has(24);
  @$pb.TagNumber(25)
  void clearCounterpartyForwardingInfoCltvExpiryDelta() => $_clearField(25);

  ///  The channel's `short_channel_id`, if we've negotiated the funding transaction with our
  ///  counterparty already and it's reached the required number of confirmations.
  ///
  ///  Note that if an inbound SCID alias is set, that will be used for invoices and inbound
  ///  payments instead of this value.
  @$pb.TagNumber(26)
  $fixnum.Int64 get shortChannelId => $_getI64(25);
  @$pb.TagNumber(26)
  set shortChannelId($fixnum.Int64 v) { $_setInt64(25, v); }
  @$pb.TagNumber(26)
  $core.bool hasShortChannelId() => $_has(25);
  @$pb.TagNumber(26)
  void clearShortChannelId() => $_clearField(26);

  /// An optional `short_channel_id` alias for this channel, randomly generated by us and usable
  /// in place of `short_channel_id` to reference the channel in outbound routes when the channel
  /// has not yet been confirmed.
  @$pb.TagNumber(27)
  $fixnum.Int64 get outboundScidAlias => $_getI64(26);
  @$pb.TagNumber(27)
  set outboundScidAlias($fixnum.Int64 v) { $_setInt64(26, v); }
  @$pb.TagNumber(27)
  $core.bool hasOutboundScidAlias() => $_has(26);
  @$pb.TagNumber(27)
  void clearOutboundScidAlias() => $_clearField(27);

  /// An optional `short_channel_id` alias for this channel, randomly generated by our
  /// counterparty and usable in place of `short_channel_id` in invoice route hints. Our
  /// counterparty will recognize the alias provided here in place of the `short_channel_id`
  /// when they see a payment to be routed to us.
  @$pb.TagNumber(28)
  $fixnum.Int64 get inboundScidAlias => $_getI64(27);
  @$pb.TagNumber(28)
  set inboundScidAlias($fixnum.Int64 v) { $_setInt64(27, v); }
  @$pb.TagNumber(28)
  $core.bool hasInboundScidAlias() => $_has(27);
  @$pb.TagNumber(28)
  void clearInboundScidAlias() => $_clearField(28);

  /// The smallest value HTLC (in msat) we will accept, for this channel.
  @$pb.TagNumber(29)
  $fixnum.Int64 get inboundHtlcMinimumMsat => $_getI64(28);
  @$pb.TagNumber(29)
  set inboundHtlcMinimumMsat($fixnum.Int64 v) { $_setInt64(28, v); }
  @$pb.TagNumber(29)
  $core.bool hasInboundHtlcMinimumMsat() => $_has(28);
  @$pb.TagNumber(29)
  void clearInboundHtlcMinimumMsat() => $_clearField(29);

  /// The largest value HTLC (in msat) we currently will accept, for this channel.
  @$pb.TagNumber(30)
  $fixnum.Int64 get inboundHtlcMaximumMsat => $_getI64(29);
  @$pb.TagNumber(30)
  set inboundHtlcMaximumMsat($fixnum.Int64 v) { $_setInt64(29, v); }
  @$pb.TagNumber(30)
  $core.bool hasInboundHtlcMaximumMsat() => $_has(29);
  @$pb.TagNumber(30)
  void clearInboundHtlcMaximumMsat() => $_clearField(30);

  ///  The current shutdown state of the channel, if any.
  ///
  ///  Will be unset for objects serialized with LDK Node v0.1 and earlier.
  @$pb.TagNumber(31)
  ChannelShutdownState get channelShutdownState => $_getN(30);
  @$pb.TagNumber(31)
  set channelShutdownState(ChannelShutdownState v) { $_setField(31, v); }
  @$pb.TagNumber(31)
  $core.bool hasChannelShutdownState() => $_has(30);
  @$pb.TagNumber(31)
  void clearChannelShutdownState() => $_clearField(31);

  ///  The type of on-chain reserve maintained for this channel.
  ///
  ///  Will be unset until channel negotiation has completed and determined whether this channel
  ///  uses anchor or legacy reserve behavior.
  @$pb.TagNumber(32)
  ReserveType get reserveType => $_getN(31);
  @$pb.TagNumber(32)
  set reserveType(ReserveType v) { $_setField(32, v); }
  @$pb.TagNumber(32)
  $core.bool hasReserveType() => $_has(31);
  @$pb.TagNumber(32)
  void clearReserveType() => $_clearField(32);

  /// The negotiated channel-type features, keyed by the signaled BOLT feature bit.
  /// This map is empty until channel negotiation determines the channel type.
  @$pb.TagNumber(33)
  $pb.PbMap<$core.int, Feature> get channelType => $_getMap(32);

  ///  The features our counterparty provided upon last connection, keyed by the signaled BOLT
  ///  feature bit.
  ///
  ///  Useful for routing, as it is the most up-to-date copy of the counterparty's features and
  ///  many routing-relevant features are present in the init context.
  @$pb.TagNumber(34)
  $pb.PbMap<$core.int, Feature> get counterpartyFeatures => $_getMap(33);
}

enum ChannelConfig_MaxDustHtlcExposure {
  fixedLimitMsat, 
  feeRateMultiplier, 
  notSet
}

/// ChannelConfig represents the configuration settings for a channel in a Lightning Network node.
/// See more: https://docs.rs/lightning/latest/lightning/util/config/struct.ChannelConfig.html
class ChannelConfig extends $pb.GeneratedMessage {
  factory ChannelConfig({
    $core.int? forwardingFeeProportionalMillionths,
    $core.int? forwardingFeeBaseMsat,
    $core.int? cltvExpiryDelta,
    $fixnum.Int64? forceCloseAvoidanceMaxFeeSatoshis,
    $core.bool? acceptUnderpayingHtlcs,
    $fixnum.Int64? fixedLimitMsat,
    $fixnum.Int64? feeRateMultiplier,
  }) {
    final $result = create();
    if (forwardingFeeProportionalMillionths != null) {
      $result.forwardingFeeProportionalMillionths = forwardingFeeProportionalMillionths;
    }
    if (forwardingFeeBaseMsat != null) {
      $result.forwardingFeeBaseMsat = forwardingFeeBaseMsat;
    }
    if (cltvExpiryDelta != null) {
      $result.cltvExpiryDelta = cltvExpiryDelta;
    }
    if (forceCloseAvoidanceMaxFeeSatoshis != null) {
      $result.forceCloseAvoidanceMaxFeeSatoshis = forceCloseAvoidanceMaxFeeSatoshis;
    }
    if (acceptUnderpayingHtlcs != null) {
      $result.acceptUnderpayingHtlcs = acceptUnderpayingHtlcs;
    }
    if (fixedLimitMsat != null) {
      $result.fixedLimitMsat = fixedLimitMsat;
    }
    if (feeRateMultiplier != null) {
      $result.feeRateMultiplier = feeRateMultiplier;
    }
    return $result;
  }
  ChannelConfig._() : super();
  factory ChannelConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ChannelConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, ChannelConfig_MaxDustHtlcExposure> _ChannelConfig_MaxDustHtlcExposureByTag = {
    6 : ChannelConfig_MaxDustHtlcExposure.fixedLimitMsat,
    7 : ChannelConfig_MaxDustHtlcExposure.feeRateMultiplier,
    0 : ChannelConfig_MaxDustHtlcExposure.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChannelConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [6, 7])
    ..a<$core.int>(1, _omitFieldNames ? '' : 'forwardingFeeProportionalMillionths', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'forwardingFeeBaseMsat', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'cltvExpiryDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'forceCloseAvoidanceMaxFeeSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(5, _omitFieldNames ? '' : 'acceptUnderpayingHtlcs')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'fixedLimitMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'feeRateMultiplier', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ChannelConfig clone() => ChannelConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ChannelConfig copyWith(void Function(ChannelConfig) updates) => super.copyWith((message) => updates(message as ChannelConfig)) as ChannelConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChannelConfig create() => ChannelConfig._();
  ChannelConfig createEmptyInstance() => create();
  static $pb.PbList<ChannelConfig> createRepeated() => $pb.PbList<ChannelConfig>();
  @$core.pragma('dart2js:noInline')
  static ChannelConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChannelConfig>(create);
  static ChannelConfig? _defaultInstance;

  ChannelConfig_MaxDustHtlcExposure whichMaxDustHtlcExposure() => _ChannelConfig_MaxDustHtlcExposureByTag[$_whichOneof(0)]!;
  void clearMaxDustHtlcExposure() => $_clearField($_whichOneof(0));

  /// Amount (in millionths of a satoshi) charged per satoshi for payments forwarded outbound
  /// over the channel.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/struct.ChannelConfig.html#structfield.forwarding_fee_proportional_millionths
  @$pb.TagNumber(1)
  $core.int get forwardingFeeProportionalMillionths => $_getIZ(0);
  @$pb.TagNumber(1)
  set forwardingFeeProportionalMillionths($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasForwardingFeeProportionalMillionths() => $_has(0);
  @$pb.TagNumber(1)
  void clearForwardingFeeProportionalMillionths() => $_clearField(1);

  /// Amount (in milli-satoshi) charged for payments forwarded outbound over the channel,
  /// in excess of forwarding_fee_proportional_millionths.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/struct.ChannelConfig.html#structfield.forwarding_fee_base_msat
  @$pb.TagNumber(2)
  $core.int get forwardingFeeBaseMsat => $_getIZ(1);
  @$pb.TagNumber(2)
  set forwardingFeeBaseMsat($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasForwardingFeeBaseMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearForwardingFeeBaseMsat() => $_clearField(2);

  /// The difference in the CLTV value between incoming HTLCs and an outbound HTLC forwarded
  /// over the channel this config applies to.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/struct.ChannelConfig.html#structfield.cltv_expiry_delta
  @$pb.TagNumber(3)
  $core.int get cltvExpiryDelta => $_getIZ(2);
  @$pb.TagNumber(3)
  set cltvExpiryDelta($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCltvExpiryDelta() => $_has(2);
  @$pb.TagNumber(3)
  void clearCltvExpiryDelta() => $_clearField(3);

  /// The maximum additional fee we’re willing to pay to avoid waiting for the counterparty’s
  /// to_self_delay to reclaim funds.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/struct.ChannelConfig.html#structfield.force_close_avoidance_max_fee_satoshis
  @$pb.TagNumber(4)
  $fixnum.Int64 get forceCloseAvoidanceMaxFeeSatoshis => $_getI64(3);
  @$pb.TagNumber(4)
  set forceCloseAvoidanceMaxFeeSatoshis($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasForceCloseAvoidanceMaxFeeSatoshis() => $_has(3);
  @$pb.TagNumber(4)
  void clearForceCloseAvoidanceMaxFeeSatoshis() => $_clearField(4);

  /// If set, allows this channel’s counterparty to skim an additional fee off this node’s
  /// inbound HTLCs. Useful for liquidity providers to offload on-chain channel costs to end users.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/struct.ChannelConfig.html#structfield.accept_underpaying_htlcs
  @$pb.TagNumber(5)
  $core.bool get acceptUnderpayingHtlcs => $_getBF(4);
  @$pb.TagNumber(5)
  set acceptUnderpayingHtlcs($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAcceptUnderpayingHtlcs() => $_has(4);
  @$pb.TagNumber(5)
  void clearAcceptUnderpayingHtlcs() => $_clearField(5);

  /// This sets a fixed limit on the total dust exposure in millisatoshis.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/enum.MaxDustHTLCExposure.html#variant.FixedLimitMsat
  @$pb.TagNumber(6)
  $fixnum.Int64 get fixedLimitMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set fixedLimitMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasFixedLimitMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearFixedLimitMsat() => $_clearField(6);

  /// This sets a multiplier on the ConfirmationTarget::OnChainSweep feerate (in sats/KW) to determine the maximum allowed dust exposure.
  /// See more: https://docs.rs/lightning/latest/lightning/util/config/enum.MaxDustHTLCExposure.html#variant.FeeRateMultiplier
  @$pb.TagNumber(7)
  $fixnum.Int64 get feeRateMultiplier => $_getI64(6);
  @$pb.TagNumber(7)
  set feeRateMultiplier($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFeeRateMultiplier() => $_has(6);
  @$pb.TagNumber(7)
  void clearFeeRateMultiplier() => $_clearField(7);
}

/// Represent a transaction outpoint.
class OutPoint extends $pb.GeneratedMessage {
  factory OutPoint({
    $core.String? txid,
    $core.int? vout,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    if (vout != null) {
      $result.vout = vout;
    }
    return $result;
  }
  OutPoint._() : super();
  factory OutPoint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OutPoint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OutPoint', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txid')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'vout', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OutPoint clone() => OutPoint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OutPoint copyWith(void Function(OutPoint) updates) => super.copyWith((message) => updates(message as OutPoint)) as OutPoint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OutPoint create() => OutPoint._();
  OutPoint createEmptyInstance() => create();
  static $pb.PbList<OutPoint> createRepeated() => $pb.PbList<OutPoint>();
  @$core.pragma('dart2js:noInline')
  static OutPoint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OutPoint>(create);
  static OutPoint? _defaultInstance;

  /// The referenced transaction's txid.
  @$pb.TagNumber(1)
  $core.String get txid => $_getSZ(0);
  @$pb.TagNumber(1)
  set txid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);

  /// The index of the referenced output in its transaction's vout.
  @$pb.TagNumber(2)
  $core.int get vout => $_getIZ(1);
  @$pb.TagNumber(2)
  set vout($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVout() => $_has(1);
  @$pb.TagNumber(2)
  void clearVout() => $_clearField(2);
}

class BestBlock extends $pb.GeneratedMessage {
  factory BestBlock({
    $core.String? blockHash,
    $core.int? height,
  }) {
    final $result = create();
    if (blockHash != null) {
      $result.blockHash = blockHash;
    }
    if (height != null) {
      $result.height = height;
    }
    return $result;
  }
  BestBlock._() : super();
  factory BestBlock.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BestBlock.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BestBlock', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'blockHash')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'height', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BestBlock clone() => BestBlock()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BestBlock copyWith(void Function(BestBlock) updates) => super.copyWith((message) => updates(message as BestBlock)) as BestBlock;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BestBlock create() => BestBlock._();
  BestBlock createEmptyInstance() => create();
  static $pb.PbList<BestBlock> createRepeated() => $pb.PbList<BestBlock>();
  @$core.pragma('dart2js:noInline')
  static BestBlock getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BestBlock>(create);
  static BestBlock? _defaultInstance;

  /// The block’s hash
  @$pb.TagNumber(1)
  $core.String get blockHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set blockHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBlockHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearBlockHash() => $_clearField(1);

  /// The height at which the block was confirmed.
  @$pb.TagNumber(2)
  $core.int get height => $_getIZ(1);
  @$pb.TagNumber(2)
  set height($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeight() => $_clearField(2);
}

enum LightningBalance_BalanceType {
  claimableOnChannelClose, 
  claimableAwaitingConfirmations, 
  contentiousClaimable, 
  maybeTimeoutClaimableHtlc, 
  maybePreimageClaimableHtlc, 
  counterpartyRevokedOutputClaimable, 
  notSet
}

/// Details about the status of a known Lightning balance.
class LightningBalance extends $pb.GeneratedMessage {
  factory LightningBalance({
    ClaimableOnChannelClose? claimableOnChannelClose,
    ClaimableAwaitingConfirmations? claimableAwaitingConfirmations,
    ContentiousClaimable? contentiousClaimable,
    MaybeTimeoutClaimableHTLC? maybeTimeoutClaimableHtlc,
    MaybePreimageClaimableHTLC? maybePreimageClaimableHtlc,
    CounterpartyRevokedOutputClaimable? counterpartyRevokedOutputClaimable,
  }) {
    final $result = create();
    if (claimableOnChannelClose != null) {
      $result.claimableOnChannelClose = claimableOnChannelClose;
    }
    if (claimableAwaitingConfirmations != null) {
      $result.claimableAwaitingConfirmations = claimableAwaitingConfirmations;
    }
    if (contentiousClaimable != null) {
      $result.contentiousClaimable = contentiousClaimable;
    }
    if (maybeTimeoutClaimableHtlc != null) {
      $result.maybeTimeoutClaimableHtlc = maybeTimeoutClaimableHtlc;
    }
    if (maybePreimageClaimableHtlc != null) {
      $result.maybePreimageClaimableHtlc = maybePreimageClaimableHtlc;
    }
    if (counterpartyRevokedOutputClaimable != null) {
      $result.counterpartyRevokedOutputClaimable = counterpartyRevokedOutputClaimable;
    }
    return $result;
  }
  LightningBalance._() : super();
  factory LightningBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LightningBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, LightningBalance_BalanceType> _LightningBalance_BalanceTypeByTag = {
    1 : LightningBalance_BalanceType.claimableOnChannelClose,
    2 : LightningBalance_BalanceType.claimableAwaitingConfirmations,
    3 : LightningBalance_BalanceType.contentiousClaimable,
    4 : LightningBalance_BalanceType.maybeTimeoutClaimableHtlc,
    5 : LightningBalance_BalanceType.maybePreimageClaimableHtlc,
    6 : LightningBalance_BalanceType.counterpartyRevokedOutputClaimable,
    0 : LightningBalance_BalanceType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LightningBalance', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOM<ClaimableOnChannelClose>(1, _omitFieldNames ? '' : 'claimableOnChannelClose', subBuilder: ClaimableOnChannelClose.create)
    ..aOM<ClaimableAwaitingConfirmations>(2, _omitFieldNames ? '' : 'claimableAwaitingConfirmations', subBuilder: ClaimableAwaitingConfirmations.create)
    ..aOM<ContentiousClaimable>(3, _omitFieldNames ? '' : 'contentiousClaimable', subBuilder: ContentiousClaimable.create)
    ..aOM<MaybeTimeoutClaimableHTLC>(4, _omitFieldNames ? '' : 'maybeTimeoutClaimableHtlc', subBuilder: MaybeTimeoutClaimableHTLC.create)
    ..aOM<MaybePreimageClaimableHTLC>(5, _omitFieldNames ? '' : 'maybePreimageClaimableHtlc', subBuilder: MaybePreimageClaimableHTLC.create)
    ..aOM<CounterpartyRevokedOutputClaimable>(6, _omitFieldNames ? '' : 'counterpartyRevokedOutputClaimable', subBuilder: CounterpartyRevokedOutputClaimable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LightningBalance clone() => LightningBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LightningBalance copyWith(void Function(LightningBalance) updates) => super.copyWith((message) => updates(message as LightningBalance)) as LightningBalance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LightningBalance create() => LightningBalance._();
  LightningBalance createEmptyInstance() => create();
  static $pb.PbList<LightningBalance> createRepeated() => $pb.PbList<LightningBalance>();
  @$core.pragma('dart2js:noInline')
  static LightningBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LightningBalance>(create);
  static LightningBalance? _defaultInstance;

  LightningBalance_BalanceType whichBalanceType() => _LightningBalance_BalanceTypeByTag[$_whichOneof(0)]!;
  void clearBalanceType() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  ClaimableOnChannelClose get claimableOnChannelClose => $_getN(0);
  @$pb.TagNumber(1)
  set claimableOnChannelClose(ClaimableOnChannelClose v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClaimableOnChannelClose() => $_has(0);
  @$pb.TagNumber(1)
  void clearClaimableOnChannelClose() => $_clearField(1);
  @$pb.TagNumber(1)
  ClaimableOnChannelClose ensureClaimableOnChannelClose() => $_ensure(0);

  @$pb.TagNumber(2)
  ClaimableAwaitingConfirmations get claimableAwaitingConfirmations => $_getN(1);
  @$pb.TagNumber(2)
  set claimableAwaitingConfirmations(ClaimableAwaitingConfirmations v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimableAwaitingConfirmations() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimableAwaitingConfirmations() => $_clearField(2);
  @$pb.TagNumber(2)
  ClaimableAwaitingConfirmations ensureClaimableAwaitingConfirmations() => $_ensure(1);

  @$pb.TagNumber(3)
  ContentiousClaimable get contentiousClaimable => $_getN(2);
  @$pb.TagNumber(3)
  set contentiousClaimable(ContentiousClaimable v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasContentiousClaimable() => $_has(2);
  @$pb.TagNumber(3)
  void clearContentiousClaimable() => $_clearField(3);
  @$pb.TagNumber(3)
  ContentiousClaimable ensureContentiousClaimable() => $_ensure(2);

  @$pb.TagNumber(4)
  MaybeTimeoutClaimableHTLC get maybeTimeoutClaimableHtlc => $_getN(3);
  @$pb.TagNumber(4)
  set maybeTimeoutClaimableHtlc(MaybeTimeoutClaimableHTLC v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaybeTimeoutClaimableHtlc() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaybeTimeoutClaimableHtlc() => $_clearField(4);
  @$pb.TagNumber(4)
  MaybeTimeoutClaimableHTLC ensureMaybeTimeoutClaimableHtlc() => $_ensure(3);

  @$pb.TagNumber(5)
  MaybePreimageClaimableHTLC get maybePreimageClaimableHtlc => $_getN(4);
  @$pb.TagNumber(5)
  set maybePreimageClaimableHtlc(MaybePreimageClaimableHTLC v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasMaybePreimageClaimableHtlc() => $_has(4);
  @$pb.TagNumber(5)
  void clearMaybePreimageClaimableHtlc() => $_clearField(5);
  @$pb.TagNumber(5)
  MaybePreimageClaimableHTLC ensureMaybePreimageClaimableHtlc() => $_ensure(4);

  @$pb.TagNumber(6)
  CounterpartyRevokedOutputClaimable get counterpartyRevokedOutputClaimable => $_getN(5);
  @$pb.TagNumber(6)
  set counterpartyRevokedOutputClaimable(CounterpartyRevokedOutputClaimable v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCounterpartyRevokedOutputClaimable() => $_has(5);
  @$pb.TagNumber(6)
  void clearCounterpartyRevokedOutputClaimable() => $_clearField(6);
  @$pb.TagNumber(6)
  CounterpartyRevokedOutputClaimable ensureCounterpartyRevokedOutputClaimable() => $_ensure(5);
}

/// The channel is not yet closed (or the commitment or closing transaction has not yet appeared in a block).
/// The given balance is claimable (less on-chain fees) if the channel is force-closed now.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.LightningBalance.html#variant.ClaimableOnChannelClose
class ClaimableOnChannelClose extends $pb.GeneratedMessage {
  factory ClaimableOnChannelClose({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? amountSatoshis,
    $fixnum.Int64? transactionFeeSatoshis,
    $fixnum.Int64? outboundPaymentHtlcRoundedMsat,
    $fixnum.Int64? outboundForwardedHtlcRoundedMsat,
    $fixnum.Int64? inboundClaimingHtlcRoundedMsat,
    $fixnum.Int64? inboundHtlcRoundedMsat,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    if (transactionFeeSatoshis != null) {
      $result.transactionFeeSatoshis = transactionFeeSatoshis;
    }
    if (outboundPaymentHtlcRoundedMsat != null) {
      $result.outboundPaymentHtlcRoundedMsat = outboundPaymentHtlcRoundedMsat;
    }
    if (outboundForwardedHtlcRoundedMsat != null) {
      $result.outboundForwardedHtlcRoundedMsat = outboundForwardedHtlcRoundedMsat;
    }
    if (inboundClaimingHtlcRoundedMsat != null) {
      $result.inboundClaimingHtlcRoundedMsat = inboundClaimingHtlcRoundedMsat;
    }
    if (inboundHtlcRoundedMsat != null) {
      $result.inboundHtlcRoundedMsat = inboundHtlcRoundedMsat;
    }
    return $result;
  }
  ClaimableOnChannelClose._() : super();
  factory ClaimableOnChannelClose.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClaimableOnChannelClose.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClaimableOnChannelClose', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'transactionFeeSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'outboundPaymentHtlcRoundedMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'outboundForwardedHtlcRoundedMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'inboundClaimingHtlcRoundedMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'inboundHtlcRoundedMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClaimableOnChannelClose clone() => ClaimableOnChannelClose()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClaimableOnChannelClose copyWith(void Function(ClaimableOnChannelClose) updates) => super.copyWith((message) => updates(message as ClaimableOnChannelClose)) as ClaimableOnChannelClose;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClaimableOnChannelClose create() => ClaimableOnChannelClose._();
  ClaimableOnChannelClose createEmptyInstance() => create();
  static $pb.PbList<ClaimableOnChannelClose> createRepeated() => $pb.PbList<ClaimableOnChannelClose>();
  @$core.pragma('dart2js:noInline')
  static ClaimableOnChannelClose getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClaimableOnChannelClose>(create);
  static ClaimableOnChannelClose? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of our channel counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The amount available to claim, in satoshis, excluding the on-chain fees which will be required to do so.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSatoshis() => $_clearField(3);

  ///  The transaction fee we pay for the closing commitment transaction.
  ///  This amount is not included in the `amount_satoshis` value.
  ///
  ///  Note that if this channel is inbound (and thus our counterparty pays the commitment transaction fee) this value
  ///  will be zero.
  @$pb.TagNumber(4)
  $fixnum.Int64 get transactionFeeSatoshis => $_getI64(3);
  @$pb.TagNumber(4)
  set transactionFeeSatoshis($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTransactionFeeSatoshis() => $_has(3);
  @$pb.TagNumber(4)
  void clearTransactionFeeSatoshis() => $_clearField(4);

  ///  The amount of millisatoshis which has been burned to fees from HTLCs which are outbound from us and are related to
  ///  a payment which was sent by us. This is the sum of the millisatoshis part of all HTLCs which are otherwise
  ///  represented by `LightningBalance::MaybeTimeoutClaimableHTLC` with their
  ///  `LightningBalance::MaybeTimeoutClaimableHTLC::outbound_payment` flag set, as well as any dust HTLCs which would
  ///  otherwise be represented the same.
  ///
  ///  This amount (rounded up to a whole satoshi value) will not be included in `amount_satoshis`.
  @$pb.TagNumber(5)
  $fixnum.Int64 get outboundPaymentHtlcRoundedMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set outboundPaymentHtlcRoundedMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasOutboundPaymentHtlcRoundedMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearOutboundPaymentHtlcRoundedMsat() => $_clearField(5);

  ///  The amount of millisatoshis which has been burned to fees from HTLCs which are outbound from us and are related to
  ///  a forwarded HTLC. This is the sum of the millisatoshis part of all HTLCs which are otherwise represented by
  ///  `LightningBalance::MaybeTimeoutClaimableHTLC` with their `LightningBalance::MaybeTimeoutClaimableHTLC::outbound_payment`
  ///  flag not set, as well as any dust HTLCs which would otherwise be represented the same.
  ///
  ///  This amount (rounded up to a whole satoshi value) will not be included in `amount_satoshis`.
  @$pb.TagNumber(6)
  $fixnum.Int64 get outboundForwardedHtlcRoundedMsat => $_getI64(5);
  @$pb.TagNumber(6)
  set outboundForwardedHtlcRoundedMsat($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOutboundForwardedHtlcRoundedMsat() => $_has(5);
  @$pb.TagNumber(6)
  void clearOutboundForwardedHtlcRoundedMsat() => $_clearField(6);

  ///  The amount of millisatoshis which has been burned to fees from HTLCs which are inbound to us and for which we know
  ///  the preimage. This is the sum of the millisatoshis part of all HTLCs which would be represented by
  ///  `LightningBalance::ContentiousClaimable` on channel close, but whose current value is included in `amount_satoshis`,
  ///  as well as any dust HTLCs which would otherwise be represented the same.
  ///
  ///  This amount (rounded up to a whole satoshi value) will not be included in `amount_satoshis`.
  @$pb.TagNumber(7)
  $fixnum.Int64 get inboundClaimingHtlcRoundedMsat => $_getI64(6);
  @$pb.TagNumber(7)
  set inboundClaimingHtlcRoundedMsat($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasInboundClaimingHtlcRoundedMsat() => $_has(6);
  @$pb.TagNumber(7)
  void clearInboundClaimingHtlcRoundedMsat() => $_clearField(7);

  ///  The amount of millisatoshis which has been burned to fees from HTLCs which are inbound to us and for which we do
  ///  not know the preimage. This is the sum of the millisatoshis part of all HTLCs which would be represented by
  ///  `LightningBalance::MaybePreimageClaimableHTLC` on channel close, as well as any dust HTLCs which would otherwise be
  ///  represented the same.
  ///
  ///  This amount (rounded up to a whole satoshi value) will not be included in the counterparty’s `amount_satoshis`.
  @$pb.TagNumber(8)
  $fixnum.Int64 get inboundHtlcRoundedMsat => $_getI64(7);
  @$pb.TagNumber(8)
  set inboundHtlcRoundedMsat($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasInboundHtlcRoundedMsat() => $_has(7);
  @$pb.TagNumber(8)
  void clearInboundHtlcRoundedMsat() => $_clearField(8);
}

/// The channel has been closed, and the given balance is ours but awaiting confirmations until we consider it spendable.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.LightningBalance.html#variant.ClaimableAwaitingConfirmations
class ClaimableAwaitingConfirmations extends $pb.GeneratedMessage {
  factory ClaimableAwaitingConfirmations({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? amountSatoshis,
    $core.int? confirmationHeight,
    BalanceSource? source,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    if (confirmationHeight != null) {
      $result.confirmationHeight = confirmationHeight;
    }
    if (source != null) {
      $result.source = source;
    }
    return $result;
  }
  ClaimableAwaitingConfirmations._() : super();
  factory ClaimableAwaitingConfirmations.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ClaimableAwaitingConfirmations.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ClaimableAwaitingConfirmations', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'confirmationHeight', $pb.PbFieldType.OU3)
    ..e<BalanceSource>(5, _omitFieldNames ? '' : 'source', $pb.PbFieldType.OE, defaultOrMaker: BalanceSource.HOLDER_FORCE_CLOSED, valueOf: BalanceSource.valueOf, enumValues: BalanceSource.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ClaimableAwaitingConfirmations clone() => ClaimableAwaitingConfirmations()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ClaimableAwaitingConfirmations copyWith(void Function(ClaimableAwaitingConfirmations) updates) => super.copyWith((message) => updates(message as ClaimableAwaitingConfirmations)) as ClaimableAwaitingConfirmations;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ClaimableAwaitingConfirmations create() => ClaimableAwaitingConfirmations._();
  ClaimableAwaitingConfirmations createEmptyInstance() => create();
  static $pb.PbList<ClaimableAwaitingConfirmations> createRepeated() => $pb.PbList<ClaimableAwaitingConfirmations>();
  @$core.pragma('dart2js:noInline')
  static ClaimableAwaitingConfirmations getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ClaimableAwaitingConfirmations>(create);
  static ClaimableAwaitingConfirmations? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of our channel counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The amount available to claim, in satoshis, possibly excluding the on-chain fees which were spent in broadcasting
  /// the transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSatoshis() => $_clearField(3);

  /// The height at which we start tracking it as  `SpendableOutput`.
  @$pb.TagNumber(4)
  $core.int get confirmationHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set confirmationHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfirmationHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfirmationHeight() => $_clearField(4);

  /// Whether this balance is a result of cooperative close, a force-close, or an HTLC.
  @$pb.TagNumber(5)
  BalanceSource get source => $_getN(4);
  @$pb.TagNumber(5)
  set source(BalanceSource v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => $_clearField(5);
}

///  The channel has been closed, and the given balance should be ours but awaiting spending transaction confirmation.
///  If the spending transaction does not confirm in time, it is possible our counterparty can take the funds by
///  broadcasting an HTLC timeout on-chain.
///
///  Once the spending transaction confirms, before it has reached enough confirmations to be considered safe from chain
///  reorganizations, the balance will instead be provided via `LightningBalance::ClaimableAwaitingConfirmations`.
///  See more: https://docs.rs/ldk-node/latest/ldk_node/enum.LightningBalance.html#variant.ContentiousClaimable
class ContentiousClaimable extends $pb.GeneratedMessage {
  factory ContentiousClaimable({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? amountSatoshis,
    $core.int? timeoutHeight,
    $core.String? paymentHash,
    $core.String? paymentPreimage,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    if (timeoutHeight != null) {
      $result.timeoutHeight = timeoutHeight;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentPreimage != null) {
      $result.paymentPreimage = paymentPreimage;
    }
    return $result;
  }
  ContentiousClaimable._() : super();
  factory ContentiousClaimable.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ContentiousClaimable.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ContentiousClaimable', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'timeoutHeight', $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'paymentHash')
    ..aOS(6, _omitFieldNames ? '' : 'paymentPreimage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ContentiousClaimable clone() => ContentiousClaimable()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ContentiousClaimable copyWith(void Function(ContentiousClaimable) updates) => super.copyWith((message) => updates(message as ContentiousClaimable)) as ContentiousClaimable;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ContentiousClaimable create() => ContentiousClaimable._();
  ContentiousClaimable createEmptyInstance() => create();
  static $pb.PbList<ContentiousClaimable> createRepeated() => $pb.PbList<ContentiousClaimable>();
  @$core.pragma('dart2js:noInline')
  static ContentiousClaimable getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContentiousClaimable>(create);
  static ContentiousClaimable? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of our channel counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The amount available to claim, in satoshis, excluding the on-chain fees which were spent in broadcasting
  /// the transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSatoshis() => $_clearField(3);

  /// The height at which the counterparty may be able to claim the balance if we have not done so.
  @$pb.TagNumber(4)
  $core.int get timeoutHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set timeoutHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimeoutHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimeoutHeight() => $_clearField(4);

  /// The payment hash that locks this HTLC.
  @$pb.TagNumber(5)
  $core.String get paymentHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentHash() => $_clearField(5);

  /// The preimage that can be used to claim this HTLC.
  @$pb.TagNumber(6)
  $core.String get paymentPreimage => $_getSZ(5);
  @$pb.TagNumber(6)
  set paymentPreimage($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasPaymentPreimage() => $_has(5);
  @$pb.TagNumber(6)
  void clearPaymentPreimage() => $_clearField(6);
}

/// HTLCs which we sent to our counterparty which are claimable after a timeout (less on-chain fees) if the counterparty
/// does not know the preimage for the HTLCs. These are somewhat likely to be claimed by our counterparty before we do.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.LightningBalance.html#variant.MaybeTimeoutClaimableHTLC
class MaybeTimeoutClaimableHTLC extends $pb.GeneratedMessage {
  factory MaybeTimeoutClaimableHTLC({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? amountSatoshis,
    $core.int? claimableHeight,
    $core.String? paymentHash,
    $core.bool? outboundPayment,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    if (claimableHeight != null) {
      $result.claimableHeight = claimableHeight;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (outboundPayment != null) {
      $result.outboundPayment = outboundPayment;
    }
    return $result;
  }
  MaybeTimeoutClaimableHTLC._() : super();
  factory MaybeTimeoutClaimableHTLC.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MaybeTimeoutClaimableHTLC.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MaybeTimeoutClaimableHTLC', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'claimableHeight', $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'paymentHash')
    ..aOB(6, _omitFieldNames ? '' : 'outboundPayment')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MaybeTimeoutClaimableHTLC clone() => MaybeTimeoutClaimableHTLC()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MaybeTimeoutClaimableHTLC copyWith(void Function(MaybeTimeoutClaimableHTLC) updates) => super.copyWith((message) => updates(message as MaybeTimeoutClaimableHTLC)) as MaybeTimeoutClaimableHTLC;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MaybeTimeoutClaimableHTLC create() => MaybeTimeoutClaimableHTLC._();
  MaybeTimeoutClaimableHTLC createEmptyInstance() => create();
  static $pb.PbList<MaybeTimeoutClaimableHTLC> createRepeated() => $pb.PbList<MaybeTimeoutClaimableHTLC>();
  @$core.pragma('dart2js:noInline')
  static MaybeTimeoutClaimableHTLC getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MaybeTimeoutClaimableHTLC>(create);
  static MaybeTimeoutClaimableHTLC? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of our channel counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The amount available to claim, in satoshis, excluding the on-chain fees which were spent in broadcasting
  /// the transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSatoshis() => $_clearField(3);

  /// The height at which we will be able to claim the balance if our counterparty has not done so.
  @$pb.TagNumber(4)
  $core.int get claimableHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set claimableHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasClaimableHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearClaimableHeight() => $_clearField(4);

  /// The payment hash whose preimage our counterparty needs to claim this HTLC.
  @$pb.TagNumber(5)
  $core.String get paymentHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentHash() => $_clearField(5);

  /// Indicates whether this HTLC represents a payment which was sent outbound from us.
  @$pb.TagNumber(6)
  $core.bool get outboundPayment => $_getBF(5);
  @$pb.TagNumber(6)
  set outboundPayment($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasOutboundPayment() => $_has(5);
  @$pb.TagNumber(6)
  void clearOutboundPayment() => $_clearField(6);
}

/// HTLCs which we received from our counterparty which are claimable with a preimage which we do not currently have.
/// This will only be claimable if we receive the preimage from the node to which we forwarded this HTLC before the
/// timeout.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.LightningBalance.html#variant.MaybePreimageClaimableHTLC
class MaybePreimageClaimableHTLC extends $pb.GeneratedMessage {
  factory MaybePreimageClaimableHTLC({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? amountSatoshis,
    $core.int? expiryHeight,
    $core.String? paymentHash,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    if (expiryHeight != null) {
      $result.expiryHeight = expiryHeight;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  MaybePreimageClaimableHTLC._() : super();
  factory MaybePreimageClaimableHTLC.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MaybePreimageClaimableHTLC.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MaybePreimageClaimableHTLC', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'expiryHeight', $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'paymentHash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MaybePreimageClaimableHTLC clone() => MaybePreimageClaimableHTLC()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MaybePreimageClaimableHTLC copyWith(void Function(MaybePreimageClaimableHTLC) updates) => super.copyWith((message) => updates(message as MaybePreimageClaimableHTLC)) as MaybePreimageClaimableHTLC;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MaybePreimageClaimableHTLC create() => MaybePreimageClaimableHTLC._();
  MaybePreimageClaimableHTLC createEmptyInstance() => create();
  static $pb.PbList<MaybePreimageClaimableHTLC> createRepeated() => $pb.PbList<MaybePreimageClaimableHTLC>();
  @$core.pragma('dart2js:noInline')
  static MaybePreimageClaimableHTLC getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MaybePreimageClaimableHTLC>(create);
  static MaybePreimageClaimableHTLC? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of our channel counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The amount available to claim, in satoshis, excluding the on-chain fees which were spent in broadcasting
  /// the transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSatoshis() => $_clearField(3);

  /// The height at which our counterparty will be able to claim the balance if we have not yet received the preimage and
  /// claimed it ourselves.
  @$pb.TagNumber(4)
  $core.int get expiryHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set expiryHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasExpiryHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearExpiryHeight() => $_clearField(4);

  /// The payment hash whose preimage we need to claim this HTLC.
  @$pb.TagNumber(5)
  $core.String get paymentHash => $_getSZ(4);
  @$pb.TagNumber(5)
  set paymentHash($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPaymentHash() => $_has(4);
  @$pb.TagNumber(5)
  void clearPaymentHash() => $_clearField(5);
}

///  The channel has been closed, and our counterparty broadcasted a revoked commitment transaction.
///
///  Thus, we’re able to claim all outputs in the commitment transaction, one of which has the following amount.
///
///  See more: https://docs.rs/ldk-node/latest/ldk_node/enum.LightningBalance.html#variant.CounterpartyRevokedOutputClaimable
class CounterpartyRevokedOutputClaimable extends $pb.GeneratedMessage {
  factory CounterpartyRevokedOutputClaimable({
    $core.String? channelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? amountSatoshis,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    return $result;
  }
  CounterpartyRevokedOutputClaimable._() : super();
  factory CounterpartyRevokedOutputClaimable.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CounterpartyRevokedOutputClaimable.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CounterpartyRevokedOutputClaimable', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CounterpartyRevokedOutputClaimable clone() => CounterpartyRevokedOutputClaimable()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CounterpartyRevokedOutputClaimable copyWith(void Function(CounterpartyRevokedOutputClaimable) updates) => super.copyWith((message) => updates(message as CounterpartyRevokedOutputClaimable)) as CounterpartyRevokedOutputClaimable;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CounterpartyRevokedOutputClaimable create() => CounterpartyRevokedOutputClaimable._();
  CounterpartyRevokedOutputClaimable createEmptyInstance() => create();
  static $pb.PbList<CounterpartyRevokedOutputClaimable> createRepeated() => $pb.PbList<CounterpartyRevokedOutputClaimable>();
  @$core.pragma('dart2js:noInline')
  static CounterpartyRevokedOutputClaimable getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CounterpartyRevokedOutputClaimable>(create);
  static CounterpartyRevokedOutputClaimable? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of our channel counterparty.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The amount, in satoshis, of the output which we can claim.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountSatoshis => $_getI64(2);
  @$pb.TagNumber(3)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountSatoshis() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountSatoshis() => $_clearField(3);
}

enum PendingSweepBalance_BalanceType {
  pendingBroadcast, 
  broadcastAwaitingConfirmation, 
  awaitingThresholdConfirmations, 
  notSet
}

/// Details about the status of a known balance currently being swept to our on-chain wallet.
class PendingSweepBalance extends $pb.GeneratedMessage {
  factory PendingSweepBalance({
    PendingBroadcast? pendingBroadcast,
    BroadcastAwaitingConfirmation? broadcastAwaitingConfirmation,
    AwaitingThresholdConfirmations? awaitingThresholdConfirmations,
  }) {
    final $result = create();
    if (pendingBroadcast != null) {
      $result.pendingBroadcast = pendingBroadcast;
    }
    if (broadcastAwaitingConfirmation != null) {
      $result.broadcastAwaitingConfirmation = broadcastAwaitingConfirmation;
    }
    if (awaitingThresholdConfirmations != null) {
      $result.awaitingThresholdConfirmations = awaitingThresholdConfirmations;
    }
    return $result;
  }
  PendingSweepBalance._() : super();
  factory PendingSweepBalance.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingSweepBalance.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, PendingSweepBalance_BalanceType> _PendingSweepBalance_BalanceTypeByTag = {
    1 : PendingSweepBalance_BalanceType.pendingBroadcast,
    2 : PendingSweepBalance_BalanceType.broadcastAwaitingConfirmation,
    3 : PendingSweepBalance_BalanceType.awaitingThresholdConfirmations,
    0 : PendingSweepBalance_BalanceType.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingSweepBalance', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOM<PendingBroadcast>(1, _omitFieldNames ? '' : 'pendingBroadcast', subBuilder: PendingBroadcast.create)
    ..aOM<BroadcastAwaitingConfirmation>(2, _omitFieldNames ? '' : 'broadcastAwaitingConfirmation', subBuilder: BroadcastAwaitingConfirmation.create)
    ..aOM<AwaitingThresholdConfirmations>(3, _omitFieldNames ? '' : 'awaitingThresholdConfirmations', subBuilder: AwaitingThresholdConfirmations.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingSweepBalance clone() => PendingSweepBalance()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingSweepBalance copyWith(void Function(PendingSweepBalance) updates) => super.copyWith((message) => updates(message as PendingSweepBalance)) as PendingSweepBalance;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingSweepBalance create() => PendingSweepBalance._();
  PendingSweepBalance createEmptyInstance() => create();
  static $pb.PbList<PendingSweepBalance> createRepeated() => $pb.PbList<PendingSweepBalance>();
  @$core.pragma('dart2js:noInline')
  static PendingSweepBalance getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingSweepBalance>(create);
  static PendingSweepBalance? _defaultInstance;

  PendingSweepBalance_BalanceType whichBalanceType() => _PendingSweepBalance_BalanceTypeByTag[$_whichOneof(0)]!;
  void clearBalanceType() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  PendingBroadcast get pendingBroadcast => $_getN(0);
  @$pb.TagNumber(1)
  set pendingBroadcast(PendingBroadcast v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPendingBroadcast() => $_has(0);
  @$pb.TagNumber(1)
  void clearPendingBroadcast() => $_clearField(1);
  @$pb.TagNumber(1)
  PendingBroadcast ensurePendingBroadcast() => $_ensure(0);

  @$pb.TagNumber(2)
  BroadcastAwaitingConfirmation get broadcastAwaitingConfirmation => $_getN(1);
  @$pb.TagNumber(2)
  set broadcastAwaitingConfirmation(BroadcastAwaitingConfirmation v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBroadcastAwaitingConfirmation() => $_has(1);
  @$pb.TagNumber(2)
  void clearBroadcastAwaitingConfirmation() => $_clearField(2);
  @$pb.TagNumber(2)
  BroadcastAwaitingConfirmation ensureBroadcastAwaitingConfirmation() => $_ensure(1);

  @$pb.TagNumber(3)
  AwaitingThresholdConfirmations get awaitingThresholdConfirmations => $_getN(2);
  @$pb.TagNumber(3)
  set awaitingThresholdConfirmations(AwaitingThresholdConfirmations v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAwaitingThresholdConfirmations() => $_has(2);
  @$pb.TagNumber(3)
  void clearAwaitingThresholdConfirmations() => $_clearField(3);
  @$pb.TagNumber(3)
  AwaitingThresholdConfirmations ensureAwaitingThresholdConfirmations() => $_ensure(2);
}

/// The spendable output is about to be swept, but a spending transaction has yet to be generated and broadcast.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.PendingSweepBalance.html#variant.PendingBroadcast
class PendingBroadcast extends $pb.GeneratedMessage {
  factory PendingBroadcast({
    $core.String? channelId,
    $fixnum.Int64? amountSatoshis,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    return $result;
  }
  PendingBroadcast._() : super();
  factory PendingBroadcast.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PendingBroadcast.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PendingBroadcast', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PendingBroadcast clone() => PendingBroadcast()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PendingBroadcast copyWith(void Function(PendingBroadcast) updates) => super.copyWith((message) => updates(message as PendingBroadcast)) as PendingBroadcast;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PendingBroadcast create() => PendingBroadcast._();
  PendingBroadcast createEmptyInstance() => create();
  static $pb.PbList<PendingBroadcast> createRepeated() => $pb.PbList<PendingBroadcast>();
  @$core.pragma('dart2js:noInline')
  static PendingBroadcast getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PendingBroadcast>(create);
  static PendingBroadcast? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The amount, in satoshis, of the output being swept.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountSatoshis => $_getI64(1);
  @$pb.TagNumber(2)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountSatoshis() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountSatoshis() => $_clearField(2);
}

/// A spending transaction has been generated and broadcast and is awaiting confirmation on-chain.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.PendingSweepBalance.html#variant.BroadcastAwaitingConfirmation
class BroadcastAwaitingConfirmation extends $pb.GeneratedMessage {
  factory BroadcastAwaitingConfirmation({
    $core.String? channelId,
    $core.int? latestBroadcastHeight,
    $core.String? latestSpendingTxid,
    $fixnum.Int64? amountSatoshis,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (latestBroadcastHeight != null) {
      $result.latestBroadcastHeight = latestBroadcastHeight;
    }
    if (latestSpendingTxid != null) {
      $result.latestSpendingTxid = latestSpendingTxid;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    return $result;
  }
  BroadcastAwaitingConfirmation._() : super();
  factory BroadcastAwaitingConfirmation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BroadcastAwaitingConfirmation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BroadcastAwaitingConfirmation', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'latestBroadcastHeight', $pb.PbFieldType.OU3)
    ..aOS(3, _omitFieldNames ? '' : 'latestSpendingTxid')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BroadcastAwaitingConfirmation clone() => BroadcastAwaitingConfirmation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BroadcastAwaitingConfirmation copyWith(void Function(BroadcastAwaitingConfirmation) updates) => super.copyWith((message) => updates(message as BroadcastAwaitingConfirmation)) as BroadcastAwaitingConfirmation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BroadcastAwaitingConfirmation create() => BroadcastAwaitingConfirmation._();
  BroadcastAwaitingConfirmation createEmptyInstance() => create();
  static $pb.PbList<BroadcastAwaitingConfirmation> createRepeated() => $pb.PbList<BroadcastAwaitingConfirmation>();
  @$core.pragma('dart2js:noInline')
  static BroadcastAwaitingConfirmation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BroadcastAwaitingConfirmation>(create);
  static BroadcastAwaitingConfirmation? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The best height when we last broadcast a transaction spending the output being swept.
  @$pb.TagNumber(2)
  $core.int get latestBroadcastHeight => $_getIZ(1);
  @$pb.TagNumber(2)
  set latestBroadcastHeight($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatestBroadcastHeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatestBroadcastHeight() => $_clearField(2);

  /// The identifier of the transaction spending the swept output we last broadcast.
  @$pb.TagNumber(3)
  $core.String get latestSpendingTxid => $_getSZ(2);
  @$pb.TagNumber(3)
  set latestSpendingTxid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLatestSpendingTxid() => $_has(2);
  @$pb.TagNumber(3)
  void clearLatestSpendingTxid() => $_clearField(3);

  /// The amount, in satoshis, of the output being swept.
  @$pb.TagNumber(4)
  $fixnum.Int64 get amountSatoshis => $_getI64(3);
  @$pb.TagNumber(4)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmountSatoshis() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmountSatoshis() => $_clearField(4);
}

///  A spending transaction has been confirmed on-chain and is awaiting threshold confirmations.
///
///  It will be considered irrevocably confirmed after reaching `ANTI_REORG_DELAY`.
///  See more: https://docs.rs/ldk-node/latest/ldk_node/enum.PendingSweepBalance.html#variant.AwaitingThresholdConfirmations
class AwaitingThresholdConfirmations extends $pb.GeneratedMessage {
  factory AwaitingThresholdConfirmations({
    $core.String? channelId,
    $core.String? latestSpendingTxid,
    $core.String? confirmationHash,
    $core.int? confirmationHeight,
    $fixnum.Int64? amountSatoshis,
  }) {
    final $result = create();
    if (channelId != null) {
      $result.channelId = channelId;
    }
    if (latestSpendingTxid != null) {
      $result.latestSpendingTxid = latestSpendingTxid;
    }
    if (confirmationHash != null) {
      $result.confirmationHash = confirmationHash;
    }
    if (confirmationHeight != null) {
      $result.confirmationHeight = confirmationHeight;
    }
    if (amountSatoshis != null) {
      $result.amountSatoshis = amountSatoshis;
    }
    return $result;
  }
  AwaitingThresholdConfirmations._() : super();
  factory AwaitingThresholdConfirmations.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AwaitingThresholdConfirmations.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AwaitingThresholdConfirmations', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'channelId')
    ..aOS(2, _omitFieldNames ? '' : 'latestSpendingTxid')
    ..aOS(3, _omitFieldNames ? '' : 'confirmationHash')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'confirmationHeight', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'amountSatoshis', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AwaitingThresholdConfirmations clone() => AwaitingThresholdConfirmations()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AwaitingThresholdConfirmations copyWith(void Function(AwaitingThresholdConfirmations) updates) => super.copyWith((message) => updates(message as AwaitingThresholdConfirmations)) as AwaitingThresholdConfirmations;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AwaitingThresholdConfirmations create() => AwaitingThresholdConfirmations._();
  AwaitingThresholdConfirmations createEmptyInstance() => create();
  static $pb.PbList<AwaitingThresholdConfirmations> createRepeated() => $pb.PbList<AwaitingThresholdConfirmations>();
  @$core.pragma('dart2js:noInline')
  static AwaitingThresholdConfirmations getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AwaitingThresholdConfirmations>(create);
  static AwaitingThresholdConfirmations? _defaultInstance;

  /// The identifier of the channel this balance belongs to.
  @$pb.TagNumber(1)
  $core.String get channelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set channelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannelId() => $_clearField(1);

  /// The identifier of the confirmed transaction spending the swept output.
  @$pb.TagNumber(2)
  $core.String get latestSpendingTxid => $_getSZ(1);
  @$pb.TagNumber(2)
  set latestSpendingTxid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLatestSpendingTxid() => $_has(1);
  @$pb.TagNumber(2)
  void clearLatestSpendingTxid() => $_clearField(2);

  /// The hash of the block in which the spending transaction was confirmed.
  @$pb.TagNumber(3)
  $core.String get confirmationHash => $_getSZ(2);
  @$pb.TagNumber(3)
  set confirmationHash($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConfirmationHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearConfirmationHash() => $_clearField(3);

  /// The height at which the spending transaction was confirmed.
  @$pb.TagNumber(4)
  $core.int get confirmationHeight => $_getIZ(3);
  @$pb.TagNumber(4)
  set confirmationHeight($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConfirmationHeight() => $_has(3);
  @$pb.TagNumber(4)
  void clearConfirmationHeight() => $_clearField(4);

  /// The amount, in satoshis, of the output being swept.
  @$pb.TagNumber(5)
  $fixnum.Int64 get amountSatoshis => $_getI64(4);
  @$pb.TagNumber(5)
  set amountSatoshis($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountSatoshis() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountSatoshis() => $_clearField(5);
}

enum Bolt11InvoiceDescription_Kind {
  direct, 
  hash, 
  notSet
}

class Bolt11InvoiceDescription extends $pb.GeneratedMessage {
  factory Bolt11InvoiceDescription({
    $core.String? direct,
    $core.String? hash,
  }) {
    final $result = create();
    if (direct != null) {
      $result.direct = direct;
    }
    if (hash != null) {
      $result.hash = hash;
    }
    return $result;
  }
  Bolt11InvoiceDescription._() : super();
  factory Bolt11InvoiceDescription.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11InvoiceDescription.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, Bolt11InvoiceDescription_Kind> _Bolt11InvoiceDescription_KindByTag = {
    1 : Bolt11InvoiceDescription_Kind.direct,
    2 : Bolt11InvoiceDescription_Kind.hash,
    0 : Bolt11InvoiceDescription_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11InvoiceDescription', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'direct')
    ..aOS(2, _omitFieldNames ? '' : 'hash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11InvoiceDescription clone() => Bolt11InvoiceDescription()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11InvoiceDescription copyWith(void Function(Bolt11InvoiceDescription) updates) => super.copyWith((message) => updates(message as Bolt11InvoiceDescription)) as Bolt11InvoiceDescription;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11InvoiceDescription create() => Bolt11InvoiceDescription._();
  Bolt11InvoiceDescription createEmptyInstance() => create();
  static $pb.PbList<Bolt11InvoiceDescription> createRepeated() => $pb.PbList<Bolt11InvoiceDescription>();
  @$core.pragma('dart2js:noInline')
  static Bolt11InvoiceDescription getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11InvoiceDescription>(create);
  static Bolt11InvoiceDescription? _defaultInstance;

  Bolt11InvoiceDescription_Kind whichKind() => _Bolt11InvoiceDescription_KindByTag[$_whichOneof(0)]!;
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get direct => $_getSZ(0);
  @$pb.TagNumber(1)
  set direct($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDirect() => $_has(0);
  @$pb.TagNumber(1)
  void clearDirect() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get hash => $_getSZ(1);
  @$pb.TagNumber(2)
  set hash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearHash() => $_clearField(2);
}

/// Configuration options for payment routing and pathfinding.
/// See https://docs.rs/lightning/0.2.0/lightning/routing/router/struct.RouteParametersConfig.html for more details on each field.
class RouteParametersConfig extends $pb.GeneratedMessage {
  factory RouteParametersConfig({
    $fixnum.Int64? maxTotalRoutingFeeMsat,
    $core.int? maxTotalCltvExpiryDelta,
    $core.int? maxPathCount,
    $core.int? maxChannelSaturationPowerOfHalf,
  }) {
    final $result = create();
    if (maxTotalRoutingFeeMsat != null) {
      $result.maxTotalRoutingFeeMsat = maxTotalRoutingFeeMsat;
    }
    if (maxTotalCltvExpiryDelta != null) {
      $result.maxTotalCltvExpiryDelta = maxTotalCltvExpiryDelta;
    }
    if (maxPathCount != null) {
      $result.maxPathCount = maxPathCount;
    }
    if (maxChannelSaturationPowerOfHalf != null) {
      $result.maxChannelSaturationPowerOfHalf = maxChannelSaturationPowerOfHalf;
    }
    return $result;
  }
  RouteParametersConfig._() : super();
  factory RouteParametersConfig.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RouteParametersConfig.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RouteParametersConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'maxTotalRoutingFeeMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'maxTotalCltvExpiryDelta', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'maxPathCount', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'maxChannelSaturationPowerOfHalf', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RouteParametersConfig clone() => RouteParametersConfig()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RouteParametersConfig copyWith(void Function(RouteParametersConfig) updates) => super.copyWith((message) => updates(message as RouteParametersConfig)) as RouteParametersConfig;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RouteParametersConfig create() => RouteParametersConfig._();
  RouteParametersConfig createEmptyInstance() => create();
  static $pb.PbList<RouteParametersConfig> createRepeated() => $pb.PbList<RouteParametersConfig>();
  @$core.pragma('dart2js:noInline')
  static RouteParametersConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RouteParametersConfig>(create);
  static RouteParametersConfig? _defaultInstance;

  /// The maximum total fees, in millisatoshi, that may accrue during route finding.
  /// Defaults to 1% of the payment amount + 50 sats
  @$pb.TagNumber(1)
  $fixnum.Int64 get maxTotalRoutingFeeMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set maxTotalRoutingFeeMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMaxTotalRoutingFeeMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearMaxTotalRoutingFeeMsat() => $_clearField(1);

  /// The maximum total CLTV delta we accept for the route.
  /// Defaults to 1008.
  @$pb.TagNumber(2)
  $core.int get maxTotalCltvExpiryDelta => $_getIZ(1);
  @$pb.TagNumber(2)
  set maxTotalCltvExpiryDelta($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMaxTotalCltvExpiryDelta() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxTotalCltvExpiryDelta() => $_clearField(2);

  /// The maximum number of paths that may be used by (MPP) payments.
  /// Defaults to 10.
  @$pb.TagNumber(3)
  $core.int get maxPathCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set maxPathCount($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxPathCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxPathCount() => $_clearField(3);

  /// Selects the maximum share of a channel's total capacity which will be
  /// sent over a channel, as a power of 1/2.
  /// Default value: 2
  @$pb.TagNumber(4)
  $core.int get maxChannelSaturationPowerOfHalf => $_getIZ(3);
  @$pb.TagNumber(4)
  set maxChannelSaturationPowerOfHalf($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxChannelSaturationPowerOfHalf() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxChannelSaturationPowerOfHalf() => $_clearField(4);
}

/// Routing fees for a channel as part of the network graph.
class GraphRoutingFees extends $pb.GeneratedMessage {
  factory GraphRoutingFees({
    $core.int? baseMsat,
    $core.int? proportionalMillionths,
  }) {
    final $result = create();
    if (baseMsat != null) {
      $result.baseMsat = baseMsat;
    }
    if (proportionalMillionths != null) {
      $result.proportionalMillionths = proportionalMillionths;
    }
    return $result;
  }
  GraphRoutingFees._() : super();
  factory GraphRoutingFees.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphRoutingFees.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphRoutingFees', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'baseMsat', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'proportionalMillionths', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphRoutingFees clone() => GraphRoutingFees()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphRoutingFees copyWith(void Function(GraphRoutingFees) updates) => super.copyWith((message) => updates(message as GraphRoutingFees)) as GraphRoutingFees;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphRoutingFees create() => GraphRoutingFees._();
  GraphRoutingFees createEmptyInstance() => create();
  static $pb.PbList<GraphRoutingFees> createRepeated() => $pb.PbList<GraphRoutingFees>();
  @$core.pragma('dart2js:noInline')
  static GraphRoutingFees getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphRoutingFees>(create);
  static GraphRoutingFees? _defaultInstance;

  /// Flat routing fee in millisatoshis.
  @$pb.TagNumber(1)
  $core.int get baseMsat => $_getIZ(0);
  @$pb.TagNumber(1)
  set baseMsat($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBaseMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearBaseMsat() => $_clearField(1);

  /// Liquidity-based routing fee in millionths of a routed amount.
  @$pb.TagNumber(2)
  $core.int get proportionalMillionths => $_getIZ(1);
  @$pb.TagNumber(2)
  set proportionalMillionths($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasProportionalMillionths() => $_has(1);
  @$pb.TagNumber(2)
  void clearProportionalMillionths() => $_clearField(2);
}

/// Details about one direction of a channel in the network graph,
/// as received within a `ChannelUpdate`.
class GraphChannelUpdate extends $pb.GeneratedMessage {
  factory GraphChannelUpdate({
    $core.int? lastUpdate,
    $core.bool? enabled,
    $core.int? cltvExpiryDelta,
    $fixnum.Int64? htlcMinimumMsat,
    $fixnum.Int64? htlcMaximumMsat,
    GraphRoutingFees? fees,
  }) {
    final $result = create();
    if (lastUpdate != null) {
      $result.lastUpdate = lastUpdate;
    }
    if (enabled != null) {
      $result.enabled = enabled;
    }
    if (cltvExpiryDelta != null) {
      $result.cltvExpiryDelta = cltvExpiryDelta;
    }
    if (htlcMinimumMsat != null) {
      $result.htlcMinimumMsat = htlcMinimumMsat;
    }
    if (htlcMaximumMsat != null) {
      $result.htlcMaximumMsat = htlcMaximumMsat;
    }
    if (fees != null) {
      $result.fees = fees;
    }
    return $result;
  }
  GraphChannelUpdate._() : super();
  factory GraphChannelUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphChannelUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphChannelUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'lastUpdate', $pb.PbFieldType.OU3)
    ..aOB(2, _omitFieldNames ? '' : 'enabled')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'cltvExpiryDelta', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'htlcMinimumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'htlcMaximumMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<GraphRoutingFees>(6, _omitFieldNames ? '' : 'fees', subBuilder: GraphRoutingFees.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphChannelUpdate clone() => GraphChannelUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphChannelUpdate copyWith(void Function(GraphChannelUpdate) updates) => super.copyWith((message) => updates(message as GraphChannelUpdate)) as GraphChannelUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphChannelUpdate create() => GraphChannelUpdate._();
  GraphChannelUpdate createEmptyInstance() => create();
  static $pb.PbList<GraphChannelUpdate> createRepeated() => $pb.PbList<GraphChannelUpdate>();
  @$core.pragma('dart2js:noInline')
  static GraphChannelUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphChannelUpdate>(create);
  static GraphChannelUpdate? _defaultInstance;

  /// When the last update to the channel direction was issued.
  /// Value is opaque, as set in the announcement.
  @$pb.TagNumber(1)
  $core.int get lastUpdate => $_getIZ(0);
  @$pb.TagNumber(1)
  set lastUpdate($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLastUpdate() => $_has(0);
  @$pb.TagNumber(1)
  void clearLastUpdate() => $_clearField(1);

  /// Whether the channel can be currently used for payments (in this one direction).
  @$pb.TagNumber(2)
  $core.bool get enabled => $_getBF(1);
  @$pb.TagNumber(2)
  set enabled($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnabled() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnabled() => $_clearField(2);

  /// The difference in CLTV values that you must have when routing through this channel.
  @$pb.TagNumber(3)
  $core.int get cltvExpiryDelta => $_getIZ(2);
  @$pb.TagNumber(3)
  set cltvExpiryDelta($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCltvExpiryDelta() => $_has(2);
  @$pb.TagNumber(3)
  void clearCltvExpiryDelta() => $_clearField(3);

  /// The minimum value, which must be relayed to the next hop via the channel.
  @$pb.TagNumber(4)
  $fixnum.Int64 get htlcMinimumMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set htlcMinimumMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHtlcMinimumMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearHtlcMinimumMsat() => $_clearField(4);

  /// The maximum value which may be relayed to the next hop via the channel.
  @$pb.TagNumber(5)
  $fixnum.Int64 get htlcMaximumMsat => $_getI64(4);
  @$pb.TagNumber(5)
  set htlcMaximumMsat($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasHtlcMaximumMsat() => $_has(4);
  @$pb.TagNumber(5)
  void clearHtlcMaximumMsat() => $_clearField(5);

  /// Fees charged when the channel is used for routing.
  @$pb.TagNumber(6)
  GraphRoutingFees get fees => $_getN(5);
  @$pb.TagNumber(6)
  set fees(GraphRoutingFees v) { $_setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFees() => $_has(5);
  @$pb.TagNumber(6)
  void clearFees() => $_clearField(6);
  @$pb.TagNumber(6)
  GraphRoutingFees ensureFees() => $_ensure(5);
}

/// Details about a channel in the network graph (both directions).
/// Received within a channel announcement.
class GraphChannel extends $pb.GeneratedMessage {
  factory GraphChannel({
    $core.String? nodeOne,
    $core.String? nodeTwo,
    $fixnum.Int64? capacitySats,
    GraphChannelUpdate? oneToTwo,
    GraphChannelUpdate? twoToOne,
  }) {
    final $result = create();
    if (nodeOne != null) {
      $result.nodeOne = nodeOne;
    }
    if (nodeTwo != null) {
      $result.nodeTwo = nodeTwo;
    }
    if (capacitySats != null) {
      $result.capacitySats = capacitySats;
    }
    if (oneToTwo != null) {
      $result.oneToTwo = oneToTwo;
    }
    if (twoToOne != null) {
      $result.twoToOne = twoToOne;
    }
    return $result;
  }
  GraphChannel._() : super();
  factory GraphChannel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphChannel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphChannel', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeOne')
    ..aOS(2, _omitFieldNames ? '' : 'nodeTwo')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'capacitySats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<GraphChannelUpdate>(4, _omitFieldNames ? '' : 'oneToTwo', subBuilder: GraphChannelUpdate.create)
    ..aOM<GraphChannelUpdate>(5, _omitFieldNames ? '' : 'twoToOne', subBuilder: GraphChannelUpdate.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphChannel clone() => GraphChannel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphChannel copyWith(void Function(GraphChannel) updates) => super.copyWith((message) => updates(message as GraphChannel)) as GraphChannel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphChannel create() => GraphChannel._();
  GraphChannel createEmptyInstance() => create();
  static $pb.PbList<GraphChannel> createRepeated() => $pb.PbList<GraphChannel>();
  @$core.pragma('dart2js:noInline')
  static GraphChannel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphChannel>(create);
  static GraphChannel? _defaultInstance;

  /// Source node of the first direction of the channel (hex-encoded public key).
  @$pb.TagNumber(1)
  $core.String get nodeOne => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeOne($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeOne() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeOne() => $_clearField(1);

  /// Source node of the second direction of the channel (hex-encoded public key).
  @$pb.TagNumber(2)
  $core.String get nodeTwo => $_getSZ(1);
  @$pb.TagNumber(2)
  set nodeTwo($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNodeTwo() => $_has(1);
  @$pb.TagNumber(2)
  void clearNodeTwo() => $_clearField(2);

  /// The channel capacity as seen on-chain, if chain lookup is available.
  @$pb.TagNumber(3)
  $fixnum.Int64 get capacitySats => $_getI64(2);
  @$pb.TagNumber(3)
  set capacitySats($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCapacitySats() => $_has(2);
  @$pb.TagNumber(3)
  void clearCapacitySats() => $_clearField(3);

  /// Details about the first direction of a channel.
  @$pb.TagNumber(4)
  GraphChannelUpdate get oneToTwo => $_getN(3);
  @$pb.TagNumber(4)
  set oneToTwo(GraphChannelUpdate v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasOneToTwo() => $_has(3);
  @$pb.TagNumber(4)
  void clearOneToTwo() => $_clearField(4);
  @$pb.TagNumber(4)
  GraphChannelUpdate ensureOneToTwo() => $_ensure(3);

  /// Details about the second direction of a channel.
  @$pb.TagNumber(5)
  GraphChannelUpdate get twoToOne => $_getN(4);
  @$pb.TagNumber(5)
  set twoToOne(GraphChannelUpdate v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTwoToOne() => $_has(4);
  @$pb.TagNumber(5)
  void clearTwoToOne() => $_clearField(5);
  @$pb.TagNumber(5)
  GraphChannelUpdate ensureTwoToOne() => $_ensure(4);
}

/// Information received in the latest node_announcement from this node.
class GraphNodeAnnouncement extends $pb.GeneratedMessage {
  factory GraphNodeAnnouncement({
    $core.int? lastUpdate,
    $core.String? alias,
    $core.String? rgb,
    $core.Iterable<$core.String>? addresses,
    $pb.PbMap<$core.int, Feature>? features,
  }) {
    final $result = create();
    if (lastUpdate != null) {
      $result.lastUpdate = lastUpdate;
    }
    if (alias != null) {
      $result.alias = alias;
    }
    if (rgb != null) {
      $result.rgb = rgb;
    }
    if (addresses != null) {
      $result.addresses.addAll(addresses);
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    return $result;
  }
  GraphNodeAnnouncement._() : super();
  factory GraphNodeAnnouncement.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphNodeAnnouncement.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphNodeAnnouncement', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'lastUpdate', $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'alias')
    ..aOS(3, _omitFieldNames ? '' : 'rgb')
    ..pPS(4, _omitFieldNames ? '' : 'addresses')
    ..m<$core.int, Feature>(5, _omitFieldNames ? '' : 'features', entryClassName: 'GraphNodeAnnouncement.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Feature.create, valueDefaultOrMaker: Feature.getDefault, packageName: const $pb.PackageName('types'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphNodeAnnouncement clone() => GraphNodeAnnouncement()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphNodeAnnouncement copyWith(void Function(GraphNodeAnnouncement) updates) => super.copyWith((message) => updates(message as GraphNodeAnnouncement)) as GraphNodeAnnouncement;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphNodeAnnouncement create() => GraphNodeAnnouncement._();
  GraphNodeAnnouncement createEmptyInstance() => create();
  static $pb.PbList<GraphNodeAnnouncement> createRepeated() => $pb.PbList<GraphNodeAnnouncement>();
  @$core.pragma('dart2js:noInline')
  static GraphNodeAnnouncement getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphNodeAnnouncement>(create);
  static GraphNodeAnnouncement? _defaultInstance;

  /// When the last known update to the node state was issued.
  /// Value is opaque, as set in the announcement.
  @$pb.TagNumber(1)
  $core.int get lastUpdate => $_getIZ(0);
  @$pb.TagNumber(1)
  set lastUpdate($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLastUpdate() => $_has(0);
  @$pb.TagNumber(1)
  void clearLastUpdate() => $_clearField(1);

  /// Moniker assigned to the node.
  /// May be invalid or malicious (eg control chars), should not be exposed to the user.
  @$pb.TagNumber(2)
  $core.String get alias => $_getSZ(1);
  @$pb.TagNumber(2)
  set alias($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlias() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlias() => $_clearField(2);

  /// Color assigned to the node as a hex-encoded RGB string, e.g. "ff0000".
  @$pb.TagNumber(3)
  $core.String get rgb => $_getSZ(2);
  @$pb.TagNumber(3)
  set rgb($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRgb() => $_has(2);
  @$pb.TagNumber(3)
  void clearRgb() => $_clearField(3);

  /// List of addresses on which this node is reachable.
  @$pb.TagNumber(4)
  $pb.PbList<$core.String> get addresses => $_getList(3);

  /// Features signaled in this node announcement, keyed by feature bit.
  @$pb.TagNumber(5)
  $pb.PbMap<$core.int, Feature> get features => $_getMap(4);
}

/// Details of a known Lightning peer.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.list_peers
class Peer extends $pb.GeneratedMessage {
  factory Peer({
    $core.String? nodeId,
    $core.String? address,
    $core.bool? isPersisted,
    $core.bool? isConnected,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (address != null) {
      $result.address = address;
    }
    if (isPersisted != null) {
      $result.isPersisted = isPersisted;
    }
    if (isConnected != null) {
      $result.isConnected = isConnected;
    }
    return $result;
  }
  Peer._() : super();
  factory Peer.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Peer.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Peer', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOB(3, _omitFieldNames ? '' : 'isPersisted')
    ..aOB(4, _omitFieldNames ? '' : 'isConnected')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Peer clone() => Peer()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Peer copyWith(void Function(Peer) updates) => super.copyWith((message) => updates(message as Peer)) as Peer;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Peer create() => Peer._();
  Peer createEmptyInstance() => create();
  static $pb.PbList<Peer> createRepeated() => $pb.PbList<Peer>();
  @$core.pragma('dart2js:noInline')
  static Peer getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Peer>(create);
  static Peer? _defaultInstance;

  /// The hex-encoded node ID of the peer.
  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);

  /// The network address of the peer.
  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);

  /// Indicates whether we'll try to reconnect to this peer after restarts.
  @$pb.TagNumber(3)
  $core.bool get isPersisted => $_getBF(2);
  @$pb.TagNumber(3)
  set isPersisted($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsPersisted() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsPersisted() => $_clearField(3);

  /// Indicates whether we currently have an active connection with the peer.
  @$pb.TagNumber(4)
  $core.bool get isConnected => $_getBF(3);
  @$pb.TagNumber(4)
  set isConnected($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIsConnected() => $_has(3);
  @$pb.TagNumber(4)
  void clearIsConnected() => $_clearField(4);
}

/// Details about a node in the network graph, known from the network announcement.
class GraphNode extends $pb.GeneratedMessage {
  factory GraphNode({
    $core.Iterable<$fixnum.Int64>? channels,
    GraphNodeAnnouncement? announcementInfo,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    if (announcementInfo != null) {
      $result.announcementInfo = announcementInfo;
    }
    return $result;
  }
  GraphNode._() : super();
  factory GraphNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphNode', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.KU6)
    ..aOM<GraphNodeAnnouncement>(2, _omitFieldNames ? '' : 'announcementInfo', subBuilder: GraphNodeAnnouncement.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphNode clone() => GraphNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphNode copyWith(void Function(GraphNode) updates) => super.copyWith((message) => updates(message as GraphNode)) as GraphNode;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphNode create() => GraphNode._();
  GraphNode createEmptyInstance() => create();
  static $pb.PbList<GraphNode> createRepeated() => $pb.PbList<GraphNode>();
  @$core.pragma('dart2js:noInline')
  static GraphNode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphNode>(create);
  static GraphNode? _defaultInstance;

  /// All valid channels a node has announced.
  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get channels => $_getList(0);

  /// More information about a node from node_announcement.
  /// Optional because we store a node entry after learning about it from
  /// a channel announcement, but before receiving a node announcement.
  @$pb.TagNumber(2)
  GraphNodeAnnouncement get announcementInfo => $_getN(1);
  @$pb.TagNumber(2)
  set announcementInfo(GraphNodeAnnouncement v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAnnouncementInfo() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnnouncementInfo() => $_clearField(2);
  @$pb.TagNumber(2)
  GraphNodeAnnouncement ensureAnnouncementInfo() => $_ensure(1);
}

/// Route hint for finding a path to the payee in a BOLT11 invoice.
class Bolt11RouteHint extends $pb.GeneratedMessage {
  factory Bolt11RouteHint({
    $core.Iterable<Bolt11HopHint>? hopHints,
  }) {
    final $result = create();
    if (hopHints != null) {
      $result.hopHints.addAll(hopHints);
    }
    return $result;
  }
  Bolt11RouteHint._() : super();
  factory Bolt11RouteHint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11RouteHint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11RouteHint', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..pc<Bolt11HopHint>(1, _omitFieldNames ? '' : 'hopHints', $pb.PbFieldType.PM, subBuilder: Bolt11HopHint.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11RouteHint clone() => Bolt11RouteHint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11RouteHint copyWith(void Function(Bolt11RouteHint) updates) => super.copyWith((message) => updates(message as Bolt11RouteHint)) as Bolt11RouteHint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11RouteHint create() => Bolt11RouteHint._();
  Bolt11RouteHint createEmptyInstance() => create();
  static $pb.PbList<Bolt11RouteHint> createRepeated() => $pb.PbList<Bolt11RouteHint>();
  @$core.pragma('dart2js:noInline')
  static Bolt11RouteHint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11RouteHint>(create);
  static Bolt11RouteHint? _defaultInstance;

  /// The hops in this route hint.
  @$pb.TagNumber(1)
  $pb.PbList<Bolt11HopHint> get hopHints => $_getList(0);
}

/// A hop in a BOLT11 route hint.
class Bolt11HopHint extends $pb.GeneratedMessage {
  factory Bolt11HopHint({
    $core.String? nodeId,
    $fixnum.Int64? shortChannelId,
    $core.int? feeBaseMsat,
    $core.int? feeProportionalMillionths,
    $core.int? cltvExpiryDelta,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
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
  Bolt11HopHint._() : super();
  factory Bolt11HopHint.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11HopHint.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11HopHint', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'shortChannelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'feeBaseMsat', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'feeProportionalMillionths', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'cltvExpiryDelta', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11HopHint clone() => Bolt11HopHint()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11HopHint copyWith(void Function(Bolt11HopHint) updates) => super.copyWith((message) => updates(message as Bolt11HopHint)) as Bolt11HopHint;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11HopHint create() => Bolt11HopHint._();
  Bolt11HopHint createEmptyInstance() => create();
  static $pb.PbList<Bolt11HopHint> createRepeated() => $pb.PbList<Bolt11HopHint>();
  @$core.pragma('dart2js:noInline')
  static Bolt11HopHint getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11HopHint>(create);
  static Bolt11HopHint? _defaultInstance;

  /// The hex-encoded public key of the node at this hop.
  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);

  /// The short channel ID.
  @$pb.TagNumber(2)
  $fixnum.Int64 get shortChannelId => $_getI64(1);
  @$pb.TagNumber(2)
  set shortChannelId($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasShortChannelId() => $_has(1);
  @$pb.TagNumber(2)
  void clearShortChannelId() => $_clearField(2);

  /// The base fee in millisatoshis charged for routing through this hop.
  @$pb.TagNumber(3)
  $core.int get feeBaseMsat => $_getIZ(2);
  @$pb.TagNumber(3)
  set feeBaseMsat($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFeeBaseMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearFeeBaseMsat() => $_clearField(3);

  /// Fee proportional millionths charged for routing through this hop.
  @$pb.TagNumber(4)
  $core.int get feeProportionalMillionths => $_getIZ(3);
  @$pb.TagNumber(4)
  set feeProportionalMillionths($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeProportionalMillionths() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeProportionalMillionths() => $_clearField(4);

  /// The CLTV expiry delta for this hop.
  @$pb.TagNumber(5)
  $core.int get cltvExpiryDelta => $_getIZ(4);
  @$pb.TagNumber(5)
  set cltvExpiryDelta($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCltvExpiryDelta() => $_has(4);
  @$pb.TagNumber(5)
  void clearCltvExpiryDelta() => $_clearField(5);
}

enum OfferAmount_Amount {
  bitcoinAmountMsats, 
  currencyAmount, 
  notSet
}

/// The amount specified in a BOLT12 offer.
class OfferAmount extends $pb.GeneratedMessage {
  factory OfferAmount({
    $fixnum.Int64? bitcoinAmountMsats,
    CurrencyAmount? currencyAmount,
  }) {
    final $result = create();
    if (bitcoinAmountMsats != null) {
      $result.bitcoinAmountMsats = bitcoinAmountMsats;
    }
    if (currencyAmount != null) {
      $result.currencyAmount = currencyAmount;
    }
    return $result;
  }
  OfferAmount._() : super();
  factory OfferAmount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OfferAmount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OfferAmount_Amount> _OfferAmount_AmountByTag = {
    1 : OfferAmount_Amount.bitcoinAmountMsats,
    2 : OfferAmount_Amount.currencyAmount,
    0 : OfferAmount_Amount.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OfferAmount', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'bitcoinAmountMsats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<CurrencyAmount>(2, _omitFieldNames ? '' : 'currencyAmount', subBuilder: CurrencyAmount.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OfferAmount clone() => OfferAmount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OfferAmount copyWith(void Function(OfferAmount) updates) => super.copyWith((message) => updates(message as OfferAmount)) as OfferAmount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OfferAmount create() => OfferAmount._();
  OfferAmount createEmptyInstance() => create();
  static $pb.PbList<OfferAmount> createRepeated() => $pb.PbList<OfferAmount>();
  @$core.pragma('dart2js:noInline')
  static OfferAmount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OfferAmount>(create);
  static OfferAmount? _defaultInstance;

  OfferAmount_Amount whichAmount() => _OfferAmount_AmountByTag[$_whichOneof(0)]!;
  void clearAmount() => $_clearField($_whichOneof(0));

  /// Amount in millisatoshis for Bitcoin payments.
  @$pb.TagNumber(1)
  $fixnum.Int64 get bitcoinAmountMsats => $_getI64(0);
  @$pb.TagNumber(1)
  set bitcoinAmountMsats($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBitcoinAmountMsats() => $_has(0);
  @$pb.TagNumber(1)
  void clearBitcoinAmountMsats() => $_clearField(1);

  /// Amount in a non-Bitcoin currency.
  @$pb.TagNumber(2)
  CurrencyAmount get currencyAmount => $_getN(1);
  @$pb.TagNumber(2)
  set currencyAmount(CurrencyAmount v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCurrencyAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearCurrencyAmount() => $_clearField(2);
  @$pb.TagNumber(2)
  CurrencyAmount ensureCurrencyAmount() => $_ensure(1);
}

/// A non-Bitcoin currency amount.
class CurrencyAmount extends $pb.GeneratedMessage {
  factory CurrencyAmount({
    $core.String? iso4217Code,
    $fixnum.Int64? amount,
  }) {
    final $result = create();
    if (iso4217Code != null) {
      $result.iso4217Code = iso4217Code;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    return $result;
  }
  CurrencyAmount._() : super();
  factory CurrencyAmount.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CurrencyAmount.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CurrencyAmount', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iso4217Code')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CurrencyAmount clone() => CurrencyAmount()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CurrencyAmount copyWith(void Function(CurrencyAmount) updates) => super.copyWith((message) => updates(message as CurrencyAmount)) as CurrencyAmount;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CurrencyAmount create() => CurrencyAmount._();
  CurrencyAmount createEmptyInstance() => create();
  static $pb.PbList<CurrencyAmount> createRepeated() => $pb.PbList<CurrencyAmount>();
  @$core.pragma('dart2js:noInline')
  static CurrencyAmount getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CurrencyAmount>(create);
  static CurrencyAmount? _defaultInstance;

  /// ISO 4217 currency code (e.g., "USD", "EUR").
  @$pb.TagNumber(1)
  $core.String get iso4217Code => $_getSZ(0);
  @$pb.TagNumber(1)
  set iso4217Code($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasIso4217Code() => $_has(0);
  @$pb.TagNumber(1)
  void clearIso4217Code() => $_clearField(1);

  /// The amount in the specified currency's minor unit.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amount => $_getI64(1);
  @$pb.TagNumber(2)
  set amount($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmount() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmount() => $_clearField(2);
}

enum OfferQuantity_Quantity {
  one, 
  bounded, 
  unbounded, 
  notSet
}

/// The quantity of items supported by a BOLT12 offer.
class OfferQuantity extends $pb.GeneratedMessage {
  factory OfferQuantity({
    $core.bool? one,
    $fixnum.Int64? bounded,
    $core.bool? unbounded,
  }) {
    final $result = create();
    if (one != null) {
      $result.one = one;
    }
    if (bounded != null) {
      $result.bounded = bounded;
    }
    if (unbounded != null) {
      $result.unbounded = unbounded;
    }
    return $result;
  }
  OfferQuantity._() : super();
  factory OfferQuantity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OfferQuantity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OfferQuantity_Quantity> _OfferQuantity_QuantityByTag = {
    1 : OfferQuantity_Quantity.one,
    2 : OfferQuantity_Quantity.bounded,
    3 : OfferQuantity_Quantity.unbounded,
    0 : OfferQuantity_Quantity.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OfferQuantity', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOB(1, _omitFieldNames ? '' : 'one')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'bounded', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOB(3, _omitFieldNames ? '' : 'unbounded')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OfferQuantity clone() => OfferQuantity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OfferQuantity copyWith(void Function(OfferQuantity) updates) => super.copyWith((message) => updates(message as OfferQuantity)) as OfferQuantity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OfferQuantity create() => OfferQuantity._();
  OfferQuantity createEmptyInstance() => create();
  static $pb.PbList<OfferQuantity> createRepeated() => $pb.PbList<OfferQuantity>();
  @$core.pragma('dart2js:noInline')
  static OfferQuantity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OfferQuantity>(create);
  static OfferQuantity? _defaultInstance;

  OfferQuantity_Quantity whichQuantity() => _OfferQuantity_QuantityByTag[$_whichOneof(0)]!;
  void clearQuantity() => $_clearField($_whichOneof(0));

  /// Only one item may be requested.
  @$pb.TagNumber(1)
  $core.bool get one => $_getBF(0);
  @$pb.TagNumber(1)
  set one($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOne() => $_has(0);
  @$pb.TagNumber(1)
  void clearOne() => $_clearField(1);

  /// Up to this many items may be requested.
  @$pb.TagNumber(2)
  $fixnum.Int64 get bounded => $_getI64(1);
  @$pb.TagNumber(2)
  set bounded($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBounded() => $_has(1);
  @$pb.TagNumber(2)
  void clearBounded() => $_clearField(2);

  /// Any number of items may be requested.
  @$pb.TagNumber(3)
  $core.bool get unbounded => $_getBF(2);
  @$pb.TagNumber(3)
  set unbounded($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUnbounded() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnbounded() => $_clearField(3);
}

enum BlindedPath_IntroductionNode {
  nodeId, 
  directedScid, 
  notSet
}

/// A blinded path to the offer recipient.
class BlindedPath extends $pb.GeneratedMessage {
  factory BlindedPath({
    $core.String? nodeId,
    DirectedShortChannelId? directedScid,
    $core.String? blindingPoint,
    $core.int? numHops,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (directedScid != null) {
      $result.directedScid = directedScid;
    }
    if (blindingPoint != null) {
      $result.blindingPoint = blindingPoint;
    }
    if (numHops != null) {
      $result.numHops = numHops;
    }
    return $result;
  }
  BlindedPath._() : super();
  factory BlindedPath.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory BlindedPath.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, BlindedPath_IntroductionNode> _BlindedPath_IntroductionNodeByTag = {
    1 : BlindedPath_IntroductionNode.nodeId,
    2 : BlindedPath_IntroductionNode.directedScid,
    0 : BlindedPath_IntroductionNode.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'BlindedPath', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..aOM<DirectedShortChannelId>(2, _omitFieldNames ? '' : 'directedScid', subBuilder: DirectedShortChannelId.create)
    ..aOS(3, _omitFieldNames ? '' : 'blindingPoint')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'numHops', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  BlindedPath clone() => BlindedPath()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  BlindedPath copyWith(void Function(BlindedPath) updates) => super.copyWith((message) => updates(message as BlindedPath)) as BlindedPath;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BlindedPath create() => BlindedPath._();
  BlindedPath createEmptyInstance() => create();
  static $pb.PbList<BlindedPath> createRepeated() => $pb.PbList<BlindedPath>();
  @$core.pragma('dart2js:noInline')
  static BlindedPath getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlindedPath>(create);
  static BlindedPath? _defaultInstance;

  BlindedPath_IntroductionNode whichIntroductionNode() => _BlindedPath_IntroductionNodeByTag[$_whichOneof(0)]!;
  void clearIntroductionNode() => $_clearField($_whichOneof(0));

  /// The hex-encoded public key of the introduction node.
  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);

  /// The directed short channel ID identifying the introduction node.
  @$pb.TagNumber(2)
  DirectedShortChannelId get directedScid => $_getN(1);
  @$pb.TagNumber(2)
  set directedScid(DirectedShortChannelId v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirectedScid() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirectedScid() => $_clearField(2);
  @$pb.TagNumber(2)
  DirectedShortChannelId ensureDirectedScid() => $_ensure(1);

  /// The hex-encoded blinding point.
  @$pb.TagNumber(3)
  $core.String get blindingPoint => $_getSZ(2);
  @$pb.TagNumber(3)
  set blindingPoint($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlindingPoint() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlindingPoint() => $_clearField(3);

  /// The number of blinded hops in the path.
  @$pb.TagNumber(4)
  $core.int get numHops => $_getIZ(3);
  @$pb.TagNumber(4)
  set numHops($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasNumHops() => $_has(3);
  @$pb.TagNumber(4)
  void clearNumHops() => $_clearField(4);
}

/// A short channel ID together with a direction byte identifying one of the
/// channel's two endpoints.
class DirectedShortChannelId extends $pb.GeneratedMessage {
  factory DirectedShortChannelId({
    $fixnum.Int64? scid,
    ChannelDirection? direction,
  }) {
    final $result = create();
    if (scid != null) {
      $result.scid = scid;
    }
    if (direction != null) {
      $result.direction = direction;
    }
    return $result;
  }
  DirectedShortChannelId._() : super();
  factory DirectedShortChannelId.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DirectedShortChannelId.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DirectedShortChannelId', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'scid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<ChannelDirection>(2, _omitFieldNames ? '' : 'direction', $pb.PbFieldType.OE, defaultOrMaker: ChannelDirection.NODE_ONE, valueOf: ChannelDirection.valueOf, enumValues: ChannelDirection.values)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DirectedShortChannelId clone() => DirectedShortChannelId()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DirectedShortChannelId copyWith(void Function(DirectedShortChannelId) updates) => super.copyWith((message) => updates(message as DirectedShortChannelId)) as DirectedShortChannelId;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DirectedShortChannelId create() => DirectedShortChannelId._();
  DirectedShortChannelId createEmptyInstance() => create();
  static $pb.PbList<DirectedShortChannelId> createRepeated() => $pb.PbList<DirectedShortChannelId>();
  @$core.pragma('dart2js:noInline')
  static DirectedShortChannelId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DirectedShortChannelId>(create);
  static DirectedShortChannelId? _defaultInstance;

  /// The short channel ID.
  @$pb.TagNumber(1)
  $fixnum.Int64 get scid => $_getI64(0);
  @$pb.TagNumber(1)
  set scid($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScid() => $_has(0);
  @$pb.TagNumber(1)
  void clearScid() => $_clearField(1);

  /// Which endpoint of the channel is being referred to.
  @$pb.TagNumber(2)
  ChannelDirection get direction => $_getN(1);
  @$pb.TagNumber(2)
  set direction(ChannelDirection v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirection() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirection() => $_clearField(2);
}

/// A feature advertised in a BOLT feature context.
class Feature extends $pb.GeneratedMessage {
  factory Feature({
    $core.String? name,
    $core.bool? isRequired,
  }) {
    final $result = create();
    if (name != null) {
      $result.name = name;
    }
    if (isRequired != null) {
      $result.isRequired = isRequired;
    }
    return $result;
  }
  Feature._() : super();
  factory Feature.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Feature.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Feature', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOB(2, _omitFieldNames ? '' : 'isRequired')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Feature clone() => Feature()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Feature copyWith(void Function(Feature) updates) => super.copyWith((message) => updates(message as Feature)) as Feature;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Feature create() => Feature._();
  Feature createEmptyInstance() => create();
  static $pb.PbList<Feature> createRepeated() => $pb.PbList<Feature>();
  @$core.pragma('dart2js:noInline')
  static Feature getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Feature>(create);
  static Feature? _defaultInstance;

  /// Human-readable feature name.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// Whether the signaled feature bit is required.
  @$pb.TagNumber(2)
  $core.bool get isRequired => $_getBF(1);
  @$pb.TagNumber(2)
  set isRequired($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsRequired() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsRequired() => $_clearField(2);
}

/// Custom TLV record attached to a payment.
class CustomTlvRecord extends $pb.GeneratedMessage {
  factory CustomTlvRecord({
    $fixnum.Int64? typeNum,
    $core.List<$core.int>? value,
  }) {
    final $result = create();
    if (typeNum != null) {
      $result.typeNum = typeNum;
    }
    if (value != null) {
      $result.value = value;
    }
    return $result;
  }
  CustomTlvRecord._() : super();
  factory CustomTlvRecord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CustomTlvRecord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CustomTlvRecord', package: const $pb.PackageName(_omitMessageNames ? '' : 'types'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'typeNum', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'value', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CustomTlvRecord clone() => CustomTlvRecord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CustomTlvRecord copyWith(void Function(CustomTlvRecord) updates) => super.copyWith((message) => updates(message as CustomTlvRecord)) as CustomTlvRecord;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CustomTlvRecord create() => CustomTlvRecord._();
  CustomTlvRecord createEmptyInstance() => create();
  static $pb.PbList<CustomTlvRecord> createRepeated() => $pb.PbList<CustomTlvRecord>();
  @$core.pragma('dart2js:noInline')
  static CustomTlvRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CustomTlvRecord>(create);
  static CustomTlvRecord? _defaultInstance;

  /// TLV type number.
  @$pb.TagNumber(1)
  $fixnum.Int64 get typeNum => $_getI64(0);
  @$pb.TagNumber(1)
  set typeNum($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTypeNum() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeNum() => $_clearField(1);

  /// Raw TLV value.
  @$pb.TagNumber(2)
  $core.List<$core.int> get value => $_getN(1);
  @$pb.TagNumber(2)
  set value($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
