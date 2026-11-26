//
//  Generated code. Do not modify.
//  source: lndkrpc.proto
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

import 'lndkrpc.pb.dart' as $0;

export 'lndkrpc.pb.dart';

@$pb.GrpcServiceName('lndkrpc.Offers')
class OffersClient extends $grpc.Client {
  static final _$payOffer = $grpc.ClientMethod<$0.PayOfferRequest, $0.PayOfferResponse>(
      '/lndkrpc.Offers/PayOffer',
      ($0.PayOfferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayOfferResponse.fromBuffer(value));
  static final _$getInvoice = $grpc.ClientMethod<$0.GetInvoiceRequest, $0.GetInvoiceResponse>(
      '/lndkrpc.Offers/GetInvoice',
      ($0.GetInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetInvoiceResponse.fromBuffer(value));
  static final _$decodeInvoice = $grpc.ClientMethod<$0.DecodeInvoiceRequest, $0.Bolt12InvoiceContents>(
      '/lndkrpc.Offers/DecodeInvoice',
      ($0.DecodeInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt12InvoiceContents.fromBuffer(value));
  static final _$payInvoice = $grpc.ClientMethod<$0.PayInvoiceRequest, $0.PayInvoiceResponse>(
      '/lndkrpc.Offers/PayInvoice',
      ($0.PayInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.PayInvoiceResponse.fromBuffer(value));
  static final _$createOffer = $grpc.ClientMethod<$0.CreateOfferRequest, $0.CreateOfferResponse>(
      '/lndkrpc.Offers/CreateOffer',
      ($0.CreateOfferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CreateOfferResponse.fromBuffer(value));

  OffersClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.PayOfferResponse> payOffer($0.PayOfferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payOffer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetInvoiceResponse> getInvoice($0.GetInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt12InvoiceContents> decodeInvoice($0.DecodeInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$decodeInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.PayInvoiceResponse> payInvoice($0.PayInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$payInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.CreateOfferResponse> createOffer($0.CreateOfferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createOffer, request, options: options);
  }
}

@$pb.GrpcServiceName('lndkrpc.Offers')
abstract class OffersServiceBase extends $grpc.Service {
  $core.String get $name => 'lndkrpc.Offers';

  OffersServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.PayOfferRequest, $0.PayOfferResponse>(
        'PayOffer',
        payOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayOfferRequest.fromBuffer(value),
        ($0.PayOfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetInvoiceRequest, $0.GetInvoiceResponse>(
        'GetInvoice',
        getInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetInvoiceRequest.fromBuffer(value),
        ($0.GetInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DecodeInvoiceRequest, $0.Bolt12InvoiceContents>(
        'DecodeInvoice',
        decodeInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DecodeInvoiceRequest.fromBuffer(value),
        ($0.Bolt12InvoiceContents value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.PayInvoiceRequest, $0.PayInvoiceResponse>(
        'PayInvoice',
        payInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.PayInvoiceRequest.fromBuffer(value),
        ($0.PayInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateOfferRequest, $0.CreateOfferResponse>(
        'CreateOffer',
        createOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateOfferRequest.fromBuffer(value),
        ($0.CreateOfferResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.PayOfferResponse> payOffer_Pre($grpc.ServiceCall $call, $async.Future<$0.PayOfferRequest> $request) async {
    return payOffer($call, await $request);
  }

  $async.Future<$0.GetInvoiceResponse> getInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.GetInvoiceRequest> $request) async {
    return getInvoice($call, await $request);
  }

  $async.Future<$0.Bolt12InvoiceContents> decodeInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.DecodeInvoiceRequest> $request) async {
    return decodeInvoice($call, await $request);
  }

  $async.Future<$0.PayInvoiceResponse> payInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.PayInvoiceRequest> $request) async {
    return payInvoice($call, await $request);
  }

  $async.Future<$0.CreateOfferResponse> createOffer_Pre($grpc.ServiceCall $call, $async.Future<$0.CreateOfferRequest> $request) async {
    return createOffer($call, await $request);
  }

  $async.Future<$0.PayOfferResponse> payOffer($grpc.ServiceCall call, $0.PayOfferRequest request);
  $async.Future<$0.GetInvoiceResponse> getInvoice($grpc.ServiceCall call, $0.GetInvoiceRequest request);
  $async.Future<$0.Bolt12InvoiceContents> decodeInvoice($grpc.ServiceCall call, $0.DecodeInvoiceRequest request);
  $async.Future<$0.PayInvoiceResponse> payInvoice($grpc.ServiceCall call, $0.PayInvoiceRequest request);
  $async.Future<$0.CreateOfferResponse> createOffer($grpc.ServiceCall call, $0.CreateOfferRequest request);
}
