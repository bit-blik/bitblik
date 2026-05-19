//
//  Generated code. Do not modify.
//  source: lnd/invoices.proto
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

import 'invoices.pb.dart' as $2;
import 'lightning.pb.dart' as $1;

export 'invoices.pb.dart';

@$pb.GrpcServiceName('invoicesrpc.Invoices')
class InvoicesClient extends $grpc.Client {
  static final _$subscribeSingleInvoice = $grpc.ClientMethod<$2.SubscribeSingleInvoiceRequest, $1.Invoice>(
      '/invoicesrpc.Invoices/SubscribeSingleInvoice',
      ($2.SubscribeSingleInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Invoice.fromBuffer(value));
  static final _$cancelInvoice = $grpc.ClientMethod<$2.CancelInvoiceMsg, $2.CancelInvoiceResp>(
      '/invoicesrpc.Invoices/CancelInvoice',
      ($2.CancelInvoiceMsg value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.CancelInvoiceResp.fromBuffer(value));
  static final _$addHoldInvoice = $grpc.ClientMethod<$2.AddHoldInvoiceRequest, $2.AddHoldInvoiceResp>(
      '/invoicesrpc.Invoices/AddHoldInvoice',
      ($2.AddHoldInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.AddHoldInvoiceResp.fromBuffer(value));
  static final _$settleInvoice = $grpc.ClientMethod<$2.SettleInvoiceMsg, $2.SettleInvoiceResp>(
      '/invoicesrpc.Invoices/SettleInvoice',
      ($2.SettleInvoiceMsg value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.SettleInvoiceResp.fromBuffer(value));
  static final _$lookupInvoiceV2 = $grpc.ClientMethod<$2.LookupInvoiceMsg, $1.Invoice>(
      '/invoicesrpc.Invoices/LookupInvoiceV2',
      ($2.LookupInvoiceMsg value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Invoice.fromBuffer(value));
  static final _$htlcModifier = $grpc.ClientMethod<$2.HtlcModifyResponse, $2.HtlcModifyRequest>(
      '/invoicesrpc.Invoices/HtlcModifier',
      ($2.HtlcModifyResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $2.HtlcModifyRequest.fromBuffer(value));

  InvoicesClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$1.Invoice> subscribeSingleInvoice($2.SubscribeSingleInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeSingleInvoice, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$2.CancelInvoiceResp> cancelInvoice($2.CancelInvoiceMsg request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$2.AddHoldInvoiceResp> addHoldInvoice($2.AddHoldInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addHoldInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$2.SettleInvoiceResp> settleInvoice($2.SettleInvoiceMsg request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$settleInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$1.Invoice> lookupInvoiceV2($2.LookupInvoiceMsg request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupInvoiceV2, request, options: options);
  }

  $grpc.ResponseStream<$2.HtlcModifyRequest> htlcModifier($async.Stream<$2.HtlcModifyResponse> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$htlcModifier, request, options: options);
  }
}

@$pb.GrpcServiceName('invoicesrpc.Invoices')
abstract class InvoicesServiceBase extends $grpc.Service {
  $core.String get $name => 'invoicesrpc.Invoices';

  InvoicesServiceBase() {
    $addMethod($grpc.ServiceMethod<$2.SubscribeSingleInvoiceRequest, $1.Invoice>(
        'SubscribeSingleInvoice',
        subscribeSingleInvoice_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $2.SubscribeSingleInvoiceRequest.fromBuffer(value),
        ($1.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.CancelInvoiceMsg, $2.CancelInvoiceResp>(
        'CancelInvoice',
        cancelInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.CancelInvoiceMsg.fromBuffer(value),
        ($2.CancelInvoiceResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.AddHoldInvoiceRequest, $2.AddHoldInvoiceResp>(
        'AddHoldInvoice',
        addHoldInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.AddHoldInvoiceRequest.fromBuffer(value),
        ($2.AddHoldInvoiceResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.SettleInvoiceMsg, $2.SettleInvoiceResp>(
        'SettleInvoice',
        settleInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.SettleInvoiceMsg.fromBuffer(value),
        ($2.SettleInvoiceResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.LookupInvoiceMsg, $1.Invoice>(
        'LookupInvoiceV2',
        lookupInvoiceV2_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.LookupInvoiceMsg.fromBuffer(value),
        ($1.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.HtlcModifyResponse, $2.HtlcModifyRequest>(
        'HtlcModifier',
        htlcModifier,
        true,
        true,
        ($core.List<$core.int> value) => $2.HtlcModifyResponse.fromBuffer(value),
        ($2.HtlcModifyRequest value) => value.writeToBuffer()));
  }

  $async.Stream<$1.Invoice> subscribeSingleInvoice_Pre($grpc.ServiceCall $call, $async.Future<$2.SubscribeSingleInvoiceRequest> $request) async* {
    yield* subscribeSingleInvoice($call, await $request);
  }

  $async.Future<$2.CancelInvoiceResp> cancelInvoice_Pre($grpc.ServiceCall $call, $async.Future<$2.CancelInvoiceMsg> $request) async {
    return cancelInvoice($call, await $request);
  }

  $async.Future<$2.AddHoldInvoiceResp> addHoldInvoice_Pre($grpc.ServiceCall $call, $async.Future<$2.AddHoldInvoiceRequest> $request) async {
    return addHoldInvoice($call, await $request);
  }

  $async.Future<$2.SettleInvoiceResp> settleInvoice_Pre($grpc.ServiceCall $call, $async.Future<$2.SettleInvoiceMsg> $request) async {
    return settleInvoice($call, await $request);
  }

  $async.Future<$1.Invoice> lookupInvoiceV2_Pre($grpc.ServiceCall $call, $async.Future<$2.LookupInvoiceMsg> $request) async {
    return lookupInvoiceV2($call, await $request);
  }

  $async.Stream<$1.Invoice> subscribeSingleInvoice($grpc.ServiceCall call, $2.SubscribeSingleInvoiceRequest request);
  $async.Future<$2.CancelInvoiceResp> cancelInvoice($grpc.ServiceCall call, $2.CancelInvoiceMsg request);
  $async.Future<$2.AddHoldInvoiceResp> addHoldInvoice($grpc.ServiceCall call, $2.AddHoldInvoiceRequest request);
  $async.Future<$2.SettleInvoiceResp> settleInvoice($grpc.ServiceCall call, $2.SettleInvoiceMsg request);
  $async.Future<$1.Invoice> lookupInvoiceV2($grpc.ServiceCall call, $2.LookupInvoiceMsg request);
  $async.Stream<$2.HtlcModifyRequest> htlcModifier($grpc.ServiceCall call, $async.Stream<$2.HtlcModifyResponse> request);
}
