//
//  Generated code. Do not modify.
//  source: lnd/hold.proto
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

import 'hold.pb.dart' as $0;

export 'hold.pb.dart';

@$pb.GrpcServiceName('hold.Hold')
class HoldClient extends $grpc.Client {
  static final _$holdInvoice = $grpc.ClientMethod<$0.HoldInvoiceRequest, $0.HoldInvoiceResponse>(
      '/hold.Hold/HoldInvoice',
      ($0.HoldInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HoldInvoiceResponse.fromBuffer(value));
  static final _$holdInvoiceSettle = $grpc.ClientMethod<$0.HoldInvoiceSettleRequest, $0.HoldInvoiceSettleResponse>(
      '/hold.Hold/HoldInvoiceSettle',
      ($0.HoldInvoiceSettleRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HoldInvoiceSettleResponse.fromBuffer(value));
  static final _$holdInvoiceCancel = $grpc.ClientMethod<$0.HoldInvoiceCancelRequest, $0.HoldInvoiceCancelResponse>(
      '/hold.Hold/HoldInvoiceCancel',
      ($0.HoldInvoiceCancelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HoldInvoiceCancelResponse.fromBuffer(value));
  static final _$holdInvoiceLookup = $grpc.ClientMethod<$0.HoldInvoiceLookupRequest, $0.HoldInvoiceLookupResponse>(
      '/hold.Hold/HoldInvoiceLookup',
      ($0.HoldInvoiceLookupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.HoldInvoiceLookupResponse.fromBuffer(value));

  HoldClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.HoldInvoiceResponse> holdInvoice($0.HoldInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$holdInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.HoldInvoiceSettleResponse> holdInvoiceSettle($0.HoldInvoiceSettleRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$holdInvoiceSettle, request, options: options);
  }

  $grpc.ResponseFuture<$0.HoldInvoiceCancelResponse> holdInvoiceCancel($0.HoldInvoiceCancelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$holdInvoiceCancel, request, options: options);
  }

  $grpc.ResponseFuture<$0.HoldInvoiceLookupResponse> holdInvoiceLookup($0.HoldInvoiceLookupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$holdInvoiceLookup, request, options: options);
  }
}

@$pb.GrpcServiceName('hold.Hold')
abstract class HoldServiceBase extends $grpc.Service {
  $core.String get $name => 'hold.Hold';

  HoldServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HoldInvoiceRequest, $0.HoldInvoiceResponse>(
        'HoldInvoice',
        holdInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HoldInvoiceRequest.fromBuffer(value),
        ($0.HoldInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HoldInvoiceSettleRequest, $0.HoldInvoiceSettleResponse>(
        'HoldInvoiceSettle',
        holdInvoiceSettle_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HoldInvoiceSettleRequest.fromBuffer(value),
        ($0.HoldInvoiceSettleResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HoldInvoiceCancelRequest, $0.HoldInvoiceCancelResponse>(
        'HoldInvoiceCancel',
        holdInvoiceCancel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HoldInvoiceCancelRequest.fromBuffer(value),
        ($0.HoldInvoiceCancelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HoldInvoiceLookupRequest, $0.HoldInvoiceLookupResponse>(
        'HoldInvoiceLookup',
        holdInvoiceLookup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HoldInvoiceLookupRequest.fromBuffer(value),
        ($0.HoldInvoiceLookupResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HoldInvoiceResponse> holdInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.HoldInvoiceRequest> $request) async {
    return holdInvoice($call, await $request);
  }

  $async.Future<$0.HoldInvoiceSettleResponse> holdInvoiceSettle_Pre($grpc.ServiceCall $call, $async.Future<$0.HoldInvoiceSettleRequest> $request) async {
    return holdInvoiceSettle($call, await $request);
  }

  $async.Future<$0.HoldInvoiceCancelResponse> holdInvoiceCancel_Pre($grpc.ServiceCall $call, $async.Future<$0.HoldInvoiceCancelRequest> $request) async {
    return holdInvoiceCancel($call, await $request);
  }

  $async.Future<$0.HoldInvoiceLookupResponse> holdInvoiceLookup_Pre($grpc.ServiceCall $call, $async.Future<$0.HoldInvoiceLookupRequest> $request) async {
    return holdInvoiceLookup($call, await $request);
  }

  $async.Future<$0.HoldInvoiceResponse> holdInvoice($grpc.ServiceCall call, $0.HoldInvoiceRequest request);
  $async.Future<$0.HoldInvoiceSettleResponse> holdInvoiceSettle($grpc.ServiceCall call, $0.HoldInvoiceSettleRequest request);
  $async.Future<$0.HoldInvoiceCancelResponse> holdInvoiceCancel($grpc.ServiceCall call, $0.HoldInvoiceCancelRequest request);
  $async.Future<$0.HoldInvoiceLookupResponse> holdInvoiceLookup($grpc.ServiceCall call, $0.HoldInvoiceLookupRequest request);
}
