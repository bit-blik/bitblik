//
//  Generated code. Do not modify.
//  source: lnd/router.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class FailureDetail extends $pb.ProtobufEnum {
  static const FailureDetail UNKNOWN = FailureDetail._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const FailureDetail NO_DETAIL = FailureDetail._(1, _omitEnumNames ? '' : 'NO_DETAIL');
  static const FailureDetail ONION_DECODE = FailureDetail._(2, _omitEnumNames ? '' : 'ONION_DECODE');
  static const FailureDetail LINK_NOT_ELIGIBLE = FailureDetail._(3, _omitEnumNames ? '' : 'LINK_NOT_ELIGIBLE');
  static const FailureDetail ON_CHAIN_TIMEOUT = FailureDetail._(4, _omitEnumNames ? '' : 'ON_CHAIN_TIMEOUT');
  static const FailureDetail HTLC_EXCEEDS_MAX = FailureDetail._(5, _omitEnumNames ? '' : 'HTLC_EXCEEDS_MAX');
  static const FailureDetail INSUFFICIENT_BALANCE = FailureDetail._(6, _omitEnumNames ? '' : 'INSUFFICIENT_BALANCE');
  static const FailureDetail INCOMPLETE_FORWARD = FailureDetail._(7, _omitEnumNames ? '' : 'INCOMPLETE_FORWARD');
  static const FailureDetail HTLC_ADD_FAILED = FailureDetail._(8, _omitEnumNames ? '' : 'HTLC_ADD_FAILED');
  static const FailureDetail FORWARDS_DISABLED = FailureDetail._(9, _omitEnumNames ? '' : 'FORWARDS_DISABLED');
  static const FailureDetail INVOICE_CANCELED = FailureDetail._(10, _omitEnumNames ? '' : 'INVOICE_CANCELED');
  static const FailureDetail INVOICE_UNDERPAID = FailureDetail._(11, _omitEnumNames ? '' : 'INVOICE_UNDERPAID');
  static const FailureDetail INVOICE_EXPIRY_TOO_SOON = FailureDetail._(12, _omitEnumNames ? '' : 'INVOICE_EXPIRY_TOO_SOON');
  static const FailureDetail INVOICE_NOT_OPEN = FailureDetail._(13, _omitEnumNames ? '' : 'INVOICE_NOT_OPEN');
  static const FailureDetail MPP_INVOICE_TIMEOUT = FailureDetail._(14, _omitEnumNames ? '' : 'MPP_INVOICE_TIMEOUT');
  static const FailureDetail ADDRESS_MISMATCH = FailureDetail._(15, _omitEnumNames ? '' : 'ADDRESS_MISMATCH');
  static const FailureDetail SET_TOTAL_MISMATCH = FailureDetail._(16, _omitEnumNames ? '' : 'SET_TOTAL_MISMATCH');
  static const FailureDetail SET_TOTAL_TOO_LOW = FailureDetail._(17, _omitEnumNames ? '' : 'SET_TOTAL_TOO_LOW');
  static const FailureDetail SET_OVERPAID = FailureDetail._(18, _omitEnumNames ? '' : 'SET_OVERPAID');
  static const FailureDetail UNKNOWN_INVOICE = FailureDetail._(19, _omitEnumNames ? '' : 'UNKNOWN_INVOICE');
  static const FailureDetail INVALID_KEYSEND = FailureDetail._(20, _omitEnumNames ? '' : 'INVALID_KEYSEND');
  static const FailureDetail MPP_IN_PROGRESS = FailureDetail._(21, _omitEnumNames ? '' : 'MPP_IN_PROGRESS');
  static const FailureDetail CIRCULAR_ROUTE = FailureDetail._(22, _omitEnumNames ? '' : 'CIRCULAR_ROUTE');

  static const $core.List<FailureDetail> values = <FailureDetail> [
    UNKNOWN,
    NO_DETAIL,
    ONION_DECODE,
    LINK_NOT_ELIGIBLE,
    ON_CHAIN_TIMEOUT,
    HTLC_EXCEEDS_MAX,
    INSUFFICIENT_BALANCE,
    INCOMPLETE_FORWARD,
    HTLC_ADD_FAILED,
    FORWARDS_DISABLED,
    INVOICE_CANCELED,
    INVOICE_UNDERPAID,
    INVOICE_EXPIRY_TOO_SOON,
    INVOICE_NOT_OPEN,
    MPP_INVOICE_TIMEOUT,
    ADDRESS_MISMATCH,
    SET_TOTAL_MISMATCH,
    SET_TOTAL_TOO_LOW,
    SET_OVERPAID,
    UNKNOWN_INVOICE,
    INVALID_KEYSEND,
    MPP_IN_PROGRESS,
    CIRCULAR_ROUTE,
  ];

  static final $core.Map<$core.int, FailureDetail> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FailureDetail? valueOf($core.int value) => _byValue[value];

  const FailureDetail._(super.v, super.n);
}

class PaymentState extends $pb.ProtobufEnum {
  ///
  /// Payment is still in flight.
  static const PaymentState IN_FLIGHT = PaymentState._(0, _omitEnumNames ? '' : 'IN_FLIGHT');
  ///
  /// Payment completed successfully.
  static const PaymentState SUCCEEDED = PaymentState._(1, _omitEnumNames ? '' : 'SUCCEEDED');
  ///
  /// There are more routes to try, but the payment timeout was exceeded.
  static const PaymentState FAILED_TIMEOUT = PaymentState._(2, _omitEnumNames ? '' : 'FAILED_TIMEOUT');
  ///
  /// All possible routes were tried and failed permanently. Or were no
  /// routes to the destination at all.
  static const PaymentState FAILED_NO_ROUTE = PaymentState._(3, _omitEnumNames ? '' : 'FAILED_NO_ROUTE');
  ///
  /// A non-recoverable error has occurred.
  static const PaymentState FAILED_ERROR = PaymentState._(4, _omitEnumNames ? '' : 'FAILED_ERROR');
  ///
  /// Payment details incorrect (unknown hash, invalid amt or
  /// invalid final cltv delta)
  static const PaymentState FAILED_INCORRECT_PAYMENT_DETAILS = PaymentState._(5, _omitEnumNames ? '' : 'FAILED_INCORRECT_PAYMENT_DETAILS');
  ///
  /// Insufficient local balance.
  static const PaymentState FAILED_INSUFFICIENT_BALANCE = PaymentState._(6, _omitEnumNames ? '' : 'FAILED_INSUFFICIENT_BALANCE');

  static const $core.List<PaymentState> values = <PaymentState> [
    IN_FLIGHT,
    SUCCEEDED,
    FAILED_TIMEOUT,
    FAILED_NO_ROUTE,
    FAILED_ERROR,
    FAILED_INCORRECT_PAYMENT_DETAILS,
    FAILED_INSUFFICIENT_BALANCE,
  ];

  static final $core.Map<$core.int, PaymentState> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PaymentState? valueOf($core.int value) => _byValue[value];

  const PaymentState._(super.v, super.n);
}

class ResolveHoldForwardAction extends $pb.ProtobufEnum {
  /// SETTLE is an action that is used to settle an HTLC instead of forwarding
  /// it.
  static const ResolveHoldForwardAction SETTLE = ResolveHoldForwardAction._(0, _omitEnumNames ? '' : 'SETTLE');
  /// FAIL is an action that is used to fail an HTLC backwards.
  static const ResolveHoldForwardAction FAIL = ResolveHoldForwardAction._(1, _omitEnumNames ? '' : 'FAIL');
  /// RESUME is an action that is used to resume a forward HTLC.
  static const ResolveHoldForwardAction RESUME = ResolveHoldForwardAction._(2, _omitEnumNames ? '' : 'RESUME');
  /// RESUME_MODIFIED is an action that is used to resume a hold forward HTLC
  /// with modifications specified during interception.
  static const ResolveHoldForwardAction RESUME_MODIFIED = ResolveHoldForwardAction._(3, _omitEnumNames ? '' : 'RESUME_MODIFIED');

  static const $core.List<ResolveHoldForwardAction> values = <ResolveHoldForwardAction> [
    SETTLE,
    FAIL,
    RESUME,
    RESUME_MODIFIED,
  ];

  static final $core.Map<$core.int, ResolveHoldForwardAction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ResolveHoldForwardAction? valueOf($core.int value) => _byValue[value];

  const ResolveHoldForwardAction._(super.v, super.n);
}

class ChanStatusAction extends $pb.ProtobufEnum {
  static const ChanStatusAction ENABLE = ChanStatusAction._(0, _omitEnumNames ? '' : 'ENABLE');
  static const ChanStatusAction DISABLE = ChanStatusAction._(1, _omitEnumNames ? '' : 'DISABLE');
  static const ChanStatusAction AUTO = ChanStatusAction._(2, _omitEnumNames ? '' : 'AUTO');

  static const $core.List<ChanStatusAction> values = <ChanStatusAction> [
    ENABLE,
    DISABLE,
    AUTO,
  ];

  static final $core.Map<$core.int, ChanStatusAction> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ChanStatusAction? valueOf($core.int value) => _byValue[value];

  const ChanStatusAction._(super.v, super.n);
}

class MissionControlConfig_ProbabilityModel extends $pb.ProtobufEnum {
  static const MissionControlConfig_ProbabilityModel APRIORI = MissionControlConfig_ProbabilityModel._(0, _omitEnumNames ? '' : 'APRIORI');
  static const MissionControlConfig_ProbabilityModel BIMODAL = MissionControlConfig_ProbabilityModel._(1, _omitEnumNames ? '' : 'BIMODAL');

  static const $core.List<MissionControlConfig_ProbabilityModel> values = <MissionControlConfig_ProbabilityModel> [
    APRIORI,
    BIMODAL,
  ];

  static final $core.Map<$core.int, MissionControlConfig_ProbabilityModel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MissionControlConfig_ProbabilityModel? valueOf($core.int value) => _byValue[value];

  const MissionControlConfig_ProbabilityModel._(super.v, super.n);
}

class HtlcEvent_EventType extends $pb.ProtobufEnum {
  static const HtlcEvent_EventType UNKNOWN = HtlcEvent_EventType._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const HtlcEvent_EventType SEND = HtlcEvent_EventType._(1, _omitEnumNames ? '' : 'SEND');
  static const HtlcEvent_EventType RECEIVE = HtlcEvent_EventType._(2, _omitEnumNames ? '' : 'RECEIVE');
  static const HtlcEvent_EventType FORWARD = HtlcEvent_EventType._(3, _omitEnumNames ? '' : 'FORWARD');

  static const $core.List<HtlcEvent_EventType> values = <HtlcEvent_EventType> [
    UNKNOWN,
    SEND,
    RECEIVE,
    FORWARD,
  ];

  static final $core.Map<$core.int, HtlcEvent_EventType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HtlcEvent_EventType? valueOf($core.int value) => _byValue[value];

  const HtlcEvent_EventType._(super.v, super.n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
