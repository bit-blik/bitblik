//
//  Generated code. Do not modify.
//  source: lnd/router.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'lightning.pb.dart' as $1;
import 'router.pb.dart' as $4;

export 'router.pb.dart';

@$pb.GrpcServiceName('routerrpc.Router')
class RouterClient extends $grpc.Client {
  static final _$sendPaymentV2 = $grpc.ClientMethod<$4.SendPaymentRequest, $1.Payment>(
      '/routerrpc.Router/SendPaymentV2',
      ($4.SendPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Payment.fromBuffer(value));
  static final _$trackPaymentV2 = $grpc.ClientMethod<$4.TrackPaymentRequest, $1.Payment>(
      '/routerrpc.Router/TrackPaymentV2',
      ($4.TrackPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Payment.fromBuffer(value));
  static final _$trackPayments = $grpc.ClientMethod<$4.TrackPaymentsRequest, $1.Payment>(
      '/routerrpc.Router/TrackPayments',
      ($4.TrackPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Payment.fromBuffer(value));
  static final _$estimateRouteFee = $grpc.ClientMethod<$4.RouteFeeRequest, $4.RouteFeeResponse>(
      '/routerrpc.Router/EstimateRouteFee',
      ($4.RouteFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.RouteFeeResponse.fromBuffer(value));
  static final _$sendToRoute = $grpc.ClientMethod<$4.SendToRouteRequest, $4.SendToRouteResponse>(
      '/routerrpc.Router/SendToRoute',
      ($4.SendToRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.SendToRouteResponse.fromBuffer(value));
  static final _$sendToRouteV2 = $grpc.ClientMethod<$4.SendToRouteRequest, $1.HTLCAttempt>(
      '/routerrpc.Router/SendToRouteV2',
      ($4.SendToRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.HTLCAttempt.fromBuffer(value));
  static final _$resetMissionControl = $grpc.ClientMethod<$4.ResetMissionControlRequest, $4.ResetMissionControlResponse>(
      '/routerrpc.Router/ResetMissionControl',
      ($4.ResetMissionControlRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.ResetMissionControlResponse.fromBuffer(value));
  static final _$queryMissionControl = $grpc.ClientMethod<$4.QueryMissionControlRequest, $4.QueryMissionControlResponse>(
      '/routerrpc.Router/QueryMissionControl',
      ($4.QueryMissionControlRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.QueryMissionControlResponse.fromBuffer(value));
  static final _$xImportMissionControl = $grpc.ClientMethod<$4.XImportMissionControlRequest, $4.XImportMissionControlResponse>(
      '/routerrpc.Router/XImportMissionControl',
      ($4.XImportMissionControlRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.XImportMissionControlResponse.fromBuffer(value));
  static final _$getMissionControlConfig = $grpc.ClientMethod<$4.GetMissionControlConfigRequest, $4.GetMissionControlConfigResponse>(
      '/routerrpc.Router/GetMissionControlConfig',
      ($4.GetMissionControlConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.GetMissionControlConfigResponse.fromBuffer(value));
  static final _$setMissionControlConfig = $grpc.ClientMethod<$4.SetMissionControlConfigRequest, $4.SetMissionControlConfigResponse>(
      '/routerrpc.Router/SetMissionControlConfig',
      ($4.SetMissionControlConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.SetMissionControlConfigResponse.fromBuffer(value));
  static final _$queryProbability = $grpc.ClientMethod<$4.QueryProbabilityRequest, $4.QueryProbabilityResponse>(
      '/routerrpc.Router/QueryProbability',
      ($4.QueryProbabilityRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.QueryProbabilityResponse.fromBuffer(value));
  static final _$buildRoute = $grpc.ClientMethod<$4.BuildRouteRequest, $4.BuildRouteResponse>(
      '/routerrpc.Router/BuildRoute',
      ($4.BuildRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.BuildRouteResponse.fromBuffer(value));
  static final _$subscribeHtlcEvents = $grpc.ClientMethod<$4.SubscribeHtlcEventsRequest, $4.HtlcEvent>(
      '/routerrpc.Router/SubscribeHtlcEvents',
      ($4.SubscribeHtlcEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.HtlcEvent.fromBuffer(value));
  static final _$sendPayment = $grpc.ClientMethod<$4.SendPaymentRequest, $4.PaymentStatus>(
      '/routerrpc.Router/SendPayment',
      ($4.SendPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.PaymentStatus.fromBuffer(value));
  static final _$trackPayment = $grpc.ClientMethod<$4.TrackPaymentRequest, $4.PaymentStatus>(
      '/routerrpc.Router/TrackPayment',
      ($4.TrackPaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.PaymentStatus.fromBuffer(value));
  static final _$htlcInterceptor = $grpc.ClientMethod<$4.ForwardHtlcInterceptResponse, $4.ForwardHtlcInterceptRequest>(
      '/routerrpc.Router/HtlcInterceptor',
      ($4.ForwardHtlcInterceptResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.ForwardHtlcInterceptRequest.fromBuffer(value));
  static final _$updateChanStatus = $grpc.ClientMethod<$4.UpdateChanStatusRequest, $4.UpdateChanStatusResponse>(
      '/routerrpc.Router/UpdateChanStatus',
      ($4.UpdateChanStatusRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.UpdateChanStatusResponse.fromBuffer(value));
  static final _$xAddLocalChanAliases = $grpc.ClientMethod<$4.AddAliasesRequest, $4.AddAliasesResponse>(
      '/routerrpc.Router/XAddLocalChanAliases',
      ($4.AddAliasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.AddAliasesResponse.fromBuffer(value));
  static final _$xDeleteLocalChanAliases = $grpc.ClientMethod<$4.DeleteAliasesRequest, $4.DeleteAliasesResponse>(
      '/routerrpc.Router/XDeleteLocalChanAliases',
      ($4.DeleteAliasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.DeleteAliasesResponse.fromBuffer(value));

  RouterClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$1.Payment> sendPaymentV2($4.SendPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendPaymentV2, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.Payment> trackPaymentV2($4.TrackPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$trackPaymentV2, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$1.Payment> trackPayments($4.TrackPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$trackPayments, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$4.RouteFeeResponse> estimateRouteFee($4.RouteFeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$estimateRouteFee, request, options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseFuture<$4.SendToRouteResponse> sendToRoute($4.SendToRouteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendToRoute, request, options: options);
  }

  $grpc.ResponseFuture<$1.HTLCAttempt> sendToRouteV2($4.SendToRouteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendToRouteV2, request, options: options);
  }

  $grpc.ResponseFuture<$4.ResetMissionControlResponse> resetMissionControl($4.ResetMissionControlRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$resetMissionControl, request, options: options);
  }

  $grpc.ResponseFuture<$4.QueryMissionControlResponse> queryMissionControl($4.QueryMissionControlRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$queryMissionControl, request, options: options);
  }

  $grpc.ResponseFuture<$4.XImportMissionControlResponse> xImportMissionControl($4.XImportMissionControlRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$xImportMissionControl, request, options: options);
  }

  $grpc.ResponseFuture<$4.GetMissionControlConfigResponse> getMissionControlConfig($4.GetMissionControlConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getMissionControlConfig, request, options: options);
  }

  $grpc.ResponseFuture<$4.SetMissionControlConfigResponse> setMissionControlConfig($4.SetMissionControlConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$setMissionControlConfig, request, options: options);
  }

  $grpc.ResponseFuture<$4.QueryProbabilityResponse> queryProbability($4.QueryProbabilityRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$queryProbability, request, options: options);
  }

  $grpc.ResponseFuture<$4.BuildRouteResponse> buildRoute($4.BuildRouteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$buildRoute, request, options: options);
  }

  $grpc.ResponseStream<$4.HtlcEvent> subscribeHtlcEvents($4.SubscribeHtlcEventsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeHtlcEvents, $async.Stream.fromIterable([request]), options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseStream<$4.PaymentStatus> sendPayment($4.SendPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendPayment, $async.Stream.fromIterable([request]), options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseStream<$4.PaymentStatus> trackPayment($4.TrackPaymentRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$trackPayment, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseStream<$4.ForwardHtlcInterceptRequest> htlcInterceptor($async.Stream<$4.ForwardHtlcInterceptResponse> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$htlcInterceptor, request, options: options);
  }

  $grpc.ResponseFuture<$4.UpdateChanStatusResponse> updateChanStatus($4.UpdateChanStatusRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateChanStatus, request, options: options);
  }

  $grpc.ResponseFuture<$4.AddAliasesResponse> xAddLocalChanAliases($4.AddAliasesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$xAddLocalChanAliases, request, options: options);
  }

  $grpc.ResponseFuture<$4.DeleteAliasesResponse> xDeleteLocalChanAliases($4.DeleteAliasesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$xDeleteLocalChanAliases, request, options: options);
  }
}

@$pb.GrpcServiceName('routerrpc.Router')
abstract class RouterServiceBase extends $grpc.Service {
  $core.String get $name => 'routerrpc.Router';

  RouterServiceBase() {
    $addMethod($grpc.ServiceMethod<$4.SendPaymentRequest, $1.Payment>(
        'SendPaymentV2',
        sendPaymentV2_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.SendPaymentRequest.fromBuffer(value),
        ($1.Payment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.TrackPaymentRequest, $1.Payment>(
        'TrackPaymentV2',
        trackPaymentV2_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.TrackPaymentRequest.fromBuffer(value),
        ($1.Payment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.TrackPaymentsRequest, $1.Payment>(
        'TrackPayments',
        trackPayments_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.TrackPaymentsRequest.fromBuffer(value),
        ($1.Payment value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.RouteFeeRequest, $4.RouteFeeResponse>(
        'EstimateRouteFee',
        estimateRouteFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.RouteFeeRequest.fromBuffer(value),
        ($4.RouteFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SendToRouteRequest, $4.SendToRouteResponse>(
        'SendToRoute',
        sendToRoute_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SendToRouteRequest.fromBuffer(value),
        ($4.SendToRouteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SendToRouteRequest, $1.HTLCAttempt>(
        'SendToRouteV2',
        sendToRouteV2_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SendToRouteRequest.fromBuffer(value),
        ($1.HTLCAttempt value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ResetMissionControlRequest, $4.ResetMissionControlResponse>(
        'ResetMissionControl',
        resetMissionControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.ResetMissionControlRequest.fromBuffer(value),
        ($4.ResetMissionControlResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.QueryMissionControlRequest, $4.QueryMissionControlResponse>(
        'QueryMissionControl',
        queryMissionControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.QueryMissionControlRequest.fromBuffer(value),
        ($4.QueryMissionControlResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.XImportMissionControlRequest, $4.XImportMissionControlResponse>(
        'XImportMissionControl',
        xImportMissionControl_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.XImportMissionControlRequest.fromBuffer(value),
        ($4.XImportMissionControlResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.GetMissionControlConfigRequest, $4.GetMissionControlConfigResponse>(
        'GetMissionControlConfig',
        getMissionControlConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.GetMissionControlConfigRequest.fromBuffer(value),
        ($4.GetMissionControlConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SetMissionControlConfigRequest, $4.SetMissionControlConfigResponse>(
        'SetMissionControlConfig',
        setMissionControlConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.SetMissionControlConfigRequest.fromBuffer(value),
        ($4.SetMissionControlConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.QueryProbabilityRequest, $4.QueryProbabilityResponse>(
        'QueryProbability',
        queryProbability_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.QueryProbabilityRequest.fromBuffer(value),
        ($4.QueryProbabilityResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.BuildRouteRequest, $4.BuildRouteResponse>(
        'BuildRoute',
        buildRoute_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.BuildRouteRequest.fromBuffer(value),
        ($4.BuildRouteResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SubscribeHtlcEventsRequest, $4.HtlcEvent>(
        'SubscribeHtlcEvents',
        subscribeHtlcEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.SubscribeHtlcEventsRequest.fromBuffer(value),
        ($4.HtlcEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.SendPaymentRequest, $4.PaymentStatus>(
        'SendPayment',
        sendPayment_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.SendPaymentRequest.fromBuffer(value),
        ($4.PaymentStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.TrackPaymentRequest, $4.PaymentStatus>(
        'TrackPayment',
        trackPayment_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $4.TrackPaymentRequest.fromBuffer(value),
        ($4.PaymentStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.ForwardHtlcInterceptResponse, $4.ForwardHtlcInterceptRequest>(
        'HtlcInterceptor',
        htlcInterceptor,
        true,
        true,
        ($core.List<$core.int> value) => $4.ForwardHtlcInterceptResponse.fromBuffer(value),
        ($4.ForwardHtlcInterceptRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.UpdateChanStatusRequest, $4.UpdateChanStatusResponse>(
        'UpdateChanStatus',
        updateChanStatus_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.UpdateChanStatusRequest.fromBuffer(value),
        ($4.UpdateChanStatusResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.AddAliasesRequest, $4.AddAliasesResponse>(
        'XAddLocalChanAliases',
        xAddLocalChanAliases_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.AddAliasesRequest.fromBuffer(value),
        ($4.AddAliasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.DeleteAliasesRequest, $4.DeleteAliasesResponse>(
        'XDeleteLocalChanAliases',
        xDeleteLocalChanAliases_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.DeleteAliasesRequest.fromBuffer(value),
        ($4.DeleteAliasesResponse value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Payment> sendPaymentV2_Pre($grpc.ServiceCall $call, $async.Future<$4.SendPaymentRequest> $request) async* {
    yield* sendPaymentV2($call, await $request);
  }

  $async.Stream<$1.Payment> trackPaymentV2_Pre($grpc.ServiceCall $call, $async.Future<$4.TrackPaymentRequest> $request) async* {
    yield* trackPaymentV2($call, await $request);
  }

  $async.Stream<$1.Payment> trackPayments_Pre($grpc.ServiceCall $call, $async.Future<$4.TrackPaymentsRequest> $request) async* {
    yield* trackPayments($call, await $request);
  }

  $async.Future<$4.RouteFeeResponse> estimateRouteFee_Pre($grpc.ServiceCall $call, $async.Future<$4.RouteFeeRequest> $request) async {
    return estimateRouteFee($call, await $request);
  }

  $async.Future<$4.SendToRouteResponse> sendToRoute_Pre($grpc.ServiceCall $call, $async.Future<$4.SendToRouteRequest> $request) async {
    return sendToRoute($call, await $request);
  }

  $async.Future<$1.HTLCAttempt> sendToRouteV2_Pre($grpc.ServiceCall $call, $async.Future<$4.SendToRouteRequest> $request) async {
    return sendToRouteV2($call, await $request);
  }

  $async.Future<$4.ResetMissionControlResponse> resetMissionControl_Pre($grpc.ServiceCall $call, $async.Future<$4.ResetMissionControlRequest> $request) async {
    return resetMissionControl($call, await $request);
  }

  $async.Future<$4.QueryMissionControlResponse> queryMissionControl_Pre($grpc.ServiceCall $call, $async.Future<$4.QueryMissionControlRequest> $request) async {
    return queryMissionControl($call, await $request);
  }

  $async.Future<$4.XImportMissionControlResponse> xImportMissionControl_Pre($grpc.ServiceCall $call, $async.Future<$4.XImportMissionControlRequest> $request) async {
    return xImportMissionControl($call, await $request);
  }

  $async.Future<$4.GetMissionControlConfigResponse> getMissionControlConfig_Pre($grpc.ServiceCall $call, $async.Future<$4.GetMissionControlConfigRequest> $request) async {
    return getMissionControlConfig($call, await $request);
  }

  $async.Future<$4.SetMissionControlConfigResponse> setMissionControlConfig_Pre($grpc.ServiceCall $call, $async.Future<$4.SetMissionControlConfigRequest> $request) async {
    return setMissionControlConfig($call, await $request);
  }

  $async.Future<$4.QueryProbabilityResponse> queryProbability_Pre($grpc.ServiceCall $call, $async.Future<$4.QueryProbabilityRequest> $request) async {
    return queryProbability($call, await $request);
  }

  $async.Future<$4.BuildRouteResponse> buildRoute_Pre($grpc.ServiceCall $call, $async.Future<$4.BuildRouteRequest> $request) async {
    return buildRoute($call, await $request);
  }

  $async.Stream<$4.HtlcEvent> subscribeHtlcEvents_Pre($grpc.ServiceCall $call, $async.Future<$4.SubscribeHtlcEventsRequest> $request) async* {
    yield* subscribeHtlcEvents($call, await $request);
  }

  $async.Stream<$4.PaymentStatus> sendPayment_Pre($grpc.ServiceCall $call, $async.Future<$4.SendPaymentRequest> $request) async* {
    yield* sendPayment($call, await $request);
  }

  $async.Stream<$4.PaymentStatus> trackPayment_Pre($grpc.ServiceCall $call, $async.Future<$4.TrackPaymentRequest> $request) async* {
    yield* trackPayment($call, await $request);
  }

  $async.Future<$4.UpdateChanStatusResponse> updateChanStatus_Pre($grpc.ServiceCall $call, $async.Future<$4.UpdateChanStatusRequest> $request) async {
    return updateChanStatus($call, await $request);
  }

  $async.Future<$4.AddAliasesResponse> xAddLocalChanAliases_Pre($grpc.ServiceCall $call, $async.Future<$4.AddAliasesRequest> $request) async {
    return xAddLocalChanAliases($call, await $request);
  }

  $async.Future<$4.DeleteAliasesResponse> xDeleteLocalChanAliases_Pre($grpc.ServiceCall $call, $async.Future<$4.DeleteAliasesRequest> $request) async {
    return xDeleteLocalChanAliases($call, await $request);
  }

  $async.Stream<$1.Payment> sendPaymentV2($grpc.ServiceCall call, $4.SendPaymentRequest request);
  $async.Stream<$1.Payment> trackPaymentV2($grpc.ServiceCall call, $4.TrackPaymentRequest request);
  $async.Stream<$1.Payment> trackPayments($grpc.ServiceCall call, $4.TrackPaymentsRequest request);
  $async.Future<$4.RouteFeeResponse> estimateRouteFee($grpc.ServiceCall call, $4.RouteFeeRequest request);
  $async.Future<$4.SendToRouteResponse> sendToRoute($grpc.ServiceCall call, $4.SendToRouteRequest request);
  $async.Future<$1.HTLCAttempt> sendToRouteV2($grpc.ServiceCall call, $4.SendToRouteRequest request);
  $async.Future<$4.ResetMissionControlResponse> resetMissionControl($grpc.ServiceCall call, $4.ResetMissionControlRequest request);
  $async.Future<$4.QueryMissionControlResponse> queryMissionControl($grpc.ServiceCall call, $4.QueryMissionControlRequest request);
  $async.Future<$4.XImportMissionControlResponse> xImportMissionControl($grpc.ServiceCall call, $4.XImportMissionControlRequest request);
  $async.Future<$4.GetMissionControlConfigResponse> getMissionControlConfig($grpc.ServiceCall call, $4.GetMissionControlConfigRequest request);
  $async.Future<$4.SetMissionControlConfigResponse> setMissionControlConfig($grpc.ServiceCall call, $4.SetMissionControlConfigRequest request);
  $async.Future<$4.QueryProbabilityResponse> queryProbability($grpc.ServiceCall call, $4.QueryProbabilityRequest request);
  $async.Future<$4.BuildRouteResponse> buildRoute($grpc.ServiceCall call, $4.BuildRouteRequest request);
  $async.Stream<$4.HtlcEvent> subscribeHtlcEvents($grpc.ServiceCall call, $4.SubscribeHtlcEventsRequest request);
  $async.Stream<$4.PaymentStatus> sendPayment($grpc.ServiceCall call, $4.SendPaymentRequest request);
  $async.Stream<$4.PaymentStatus> trackPayment($grpc.ServiceCall call, $4.TrackPaymentRequest request);
  $async.Stream<$4.ForwardHtlcInterceptRequest> htlcInterceptor($grpc.ServiceCall call, $async.Stream<$4.ForwardHtlcInterceptResponse> request);
  $async.Future<$4.UpdateChanStatusResponse> updateChanStatus($grpc.ServiceCall call, $4.UpdateChanStatusRequest request);
  $async.Future<$4.AddAliasesResponse> xAddLocalChanAliases($grpc.ServiceCall call, $4.AddAliasesRequest request);
  $async.Future<$4.DeleteAliasesResponse> xDeleteLocalChanAliases($grpc.ServiceCall call, $4.DeleteAliasesRequest request);
}
