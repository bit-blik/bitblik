//
//  Generated code. Do not modify.
//  source: api.proto
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

import 'api.pb.dart' as $0;
import 'events.pb.dart' as $1;

export 'api.pb.dart';

@$pb.GrpcServiceName('api.LightningNode')
class LightningNodeClient extends $grpc.Client {
  static final _$getNodeInfo = $grpc.ClientMethod<$0.GetNodeInfoRequest, $0.GetNodeInfoResponse>(
      '/api.LightningNode/GetNodeInfo',
      ($0.GetNodeInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetNodeInfoResponse.fromBuffer(value));
  static final _$getBalances = $grpc.ClientMethod<$0.GetBalancesRequest, $0.GetBalancesResponse>(
      '/api.LightningNode/GetBalances',
      ($0.GetBalancesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetBalancesResponse.fromBuffer(value));
  static final _$onchainReceive = $grpc.ClientMethod<$0.OnchainReceiveRequest, $0.OnchainReceiveResponse>(
      '/api.LightningNode/OnchainReceive',
      ($0.OnchainReceiveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.OnchainReceiveResponse.fromBuffer(value));
  static final _$onchainSend = $grpc.ClientMethod<$0.OnchainSendRequest, $0.OnchainSendResponse>(
      '/api.LightningNode/OnchainSend',
      ($0.OnchainSendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.OnchainSendResponse.fromBuffer(value));
  static final _$bolt11Receive = $grpc.ClientMethod<$0.Bolt11ReceiveRequest, $0.Bolt11ReceiveResponse>(
      '/api.LightningNode/Bolt11Receive',
      ($0.Bolt11ReceiveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11ReceiveResponse.fromBuffer(value));
  static final _$bolt11ReceiveForHash = $grpc.ClientMethod<$0.Bolt11ReceiveForHashRequest, $0.Bolt11ReceiveForHashResponse>(
      '/api.LightningNode/Bolt11ReceiveForHash',
      ($0.Bolt11ReceiveForHashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11ReceiveForHashResponse.fromBuffer(value));
  static final _$bolt11ClaimForHash = $grpc.ClientMethod<$0.Bolt11ClaimForHashRequest, $0.Bolt11ClaimForHashResponse>(
      '/api.LightningNode/Bolt11ClaimForHash',
      ($0.Bolt11ClaimForHashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11ClaimForHashResponse.fromBuffer(value));
  static final _$bolt11FailForHash = $grpc.ClientMethod<$0.Bolt11FailForHashRequest, $0.Bolt11FailForHashResponse>(
      '/api.LightningNode/Bolt11FailForHash',
      ($0.Bolt11FailForHashRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11FailForHashResponse.fromBuffer(value));
  static final _$bolt11ReceiveViaJitChannel = $grpc.ClientMethod<$0.Bolt11ReceiveViaJitChannelRequest, $0.Bolt11ReceiveViaJitChannelResponse>(
      '/api.LightningNode/Bolt11ReceiveViaJitChannel',
      ($0.Bolt11ReceiveViaJitChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11ReceiveViaJitChannelResponse.fromBuffer(value));
  static final _$bolt11ReceiveVariableAmountViaJitChannel = $grpc.ClientMethod<$0.Bolt11ReceiveVariableAmountViaJitChannelRequest, $0.Bolt11ReceiveVariableAmountViaJitChannelResponse>(
      '/api.LightningNode/Bolt11ReceiveVariableAmountViaJitChannel',
      ($0.Bolt11ReceiveVariableAmountViaJitChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11ReceiveVariableAmountViaJitChannelResponse.fromBuffer(value));
  static final _$bolt11Send = $grpc.ClientMethod<$0.Bolt11SendRequest, $0.Bolt11SendResponse>(
      '/api.LightningNode/Bolt11Send',
      ($0.Bolt11SendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11SendResponse.fromBuffer(value));
  static final _$bolt11SendUnderpaying = $grpc.ClientMethod<$0.Bolt11SendUnderpayingRequest, $0.Bolt11SendUnderpayingResponse>(
      '/api.LightningNode/Bolt11SendUnderpaying',
      ($0.Bolt11SendUnderpayingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt11SendUnderpayingResponse.fromBuffer(value));
  static final _$bolt12Receive = $grpc.ClientMethod<$0.Bolt12ReceiveRequest, $0.Bolt12ReceiveResponse>(
      '/api.LightningNode/Bolt12Receive',
      ($0.Bolt12ReceiveRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt12ReceiveResponse.fromBuffer(value));
  static final _$bolt12Send = $grpc.ClientMethod<$0.Bolt12SendRequest, $0.Bolt12SendResponse>(
      '/api.LightningNode/Bolt12Send',
      ($0.Bolt12SendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Bolt12SendResponse.fromBuffer(value));
  static final _$spontaneousSend = $grpc.ClientMethod<$0.SpontaneousSendRequest, $0.SpontaneousSendResponse>(
      '/api.LightningNode/SpontaneousSend',
      ($0.SpontaneousSendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SpontaneousSendResponse.fromBuffer(value));
  static final _$openChannel = $grpc.ClientMethod<$0.OpenChannelRequest, $0.OpenChannelResponse>(
      '/api.LightningNode/OpenChannel',
      ($0.OpenChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.OpenChannelResponse.fromBuffer(value));
  static final _$spliceIn = $grpc.ClientMethod<$0.SpliceInRequest, $0.SpliceInResponse>(
      '/api.LightningNode/SpliceIn',
      ($0.SpliceInRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SpliceInResponse.fromBuffer(value));
  static final _$spliceOut = $grpc.ClientMethod<$0.SpliceOutRequest, $0.SpliceOutResponse>(
      '/api.LightningNode/SpliceOut',
      ($0.SpliceOutRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SpliceOutResponse.fromBuffer(value));
  static final _$updateChannelConfig = $grpc.ClientMethod<$0.UpdateChannelConfigRequest, $0.UpdateChannelConfigResponse>(
      '/api.LightningNode/UpdateChannelConfig',
      ($0.UpdateChannelConfigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UpdateChannelConfigResponse.fromBuffer(value));
  static final _$closeChannel = $grpc.ClientMethod<$0.CloseChannelRequest, $0.CloseChannelResponse>(
      '/api.LightningNode/CloseChannel',
      ($0.CloseChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CloseChannelResponse.fromBuffer(value));
  static final _$forceCloseChannel = $grpc.ClientMethod<$0.ForceCloseChannelRequest, $0.ForceCloseChannelResponse>(
      '/api.LightningNode/ForceCloseChannel',
      ($0.ForceCloseChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ForceCloseChannelResponse.fromBuffer(value));
  static final _$listChannels = $grpc.ClientMethod<$0.ListChannelsRequest, $0.ListChannelsResponse>(
      '/api.LightningNode/ListChannels',
      ($0.ListChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListChannelsResponse.fromBuffer(value));
  static final _$getPaymentDetails = $grpc.ClientMethod<$0.GetPaymentDetailsRequest, $0.GetPaymentDetailsResponse>(
      '/api.LightningNode/GetPaymentDetails',
      ($0.GetPaymentDetailsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetPaymentDetailsResponse.fromBuffer(value));
  static final _$listPayments = $grpc.ClientMethod<$0.ListPaymentsRequest, $0.ListPaymentsResponse>(
      '/api.LightningNode/ListPayments',
      ($0.ListPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListPaymentsResponse.fromBuffer(value));
  static final _$listForwardedPayments = $grpc.ClientMethod<$0.ListForwardedPaymentsRequest, $0.ListForwardedPaymentsResponse>(
      '/api.LightningNode/ListForwardedPayments',
      ($0.ListForwardedPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListForwardedPaymentsResponse.fromBuffer(value));
  static final _$connectPeer = $grpc.ClientMethod<$0.ConnectPeerRequest, $0.ConnectPeerResponse>(
      '/api.LightningNode/ConnectPeer',
      ($0.ConnectPeerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ConnectPeerResponse.fromBuffer(value));
  static final _$disconnectPeer = $grpc.ClientMethod<$0.DisconnectPeerRequest, $0.DisconnectPeerResponse>(
      '/api.LightningNode/DisconnectPeer',
      ($0.DisconnectPeerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DisconnectPeerResponse.fromBuffer(value));
  static final _$listPeers = $grpc.ClientMethod<$0.ListPeersRequest, $0.ListPeersResponse>(
      '/api.LightningNode/ListPeers',
      ($0.ListPeersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ListPeersResponse.fromBuffer(value));
  static final _$signMessage = $grpc.ClientMethod<$0.SignMessageRequest, $0.SignMessageResponse>(
      '/api.LightningNode/SignMessage',
      ($0.SignMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SignMessageResponse.fromBuffer(value));
  static final _$verifySignature = $grpc.ClientMethod<$0.VerifySignatureRequest, $0.VerifySignatureResponse>(
      '/api.LightningNode/VerifySignature',
      ($0.VerifySignatureRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.VerifySignatureResponse.fromBuffer(value));
  static final _$exportPathfindingScores = $grpc.ClientMethod<$0.ExportPathfindingScoresRequest, $0.ExportPathfindingScoresResponse>(
      '/api.LightningNode/ExportPathfindingScores',
      ($0.ExportPathfindingScoresRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ExportPathfindingScoresResponse.fromBuffer(value));
  static final _$unifiedSend = $grpc.ClientMethod<$0.UnifiedSendRequest, $0.UnifiedSendResponse>(
      '/api.LightningNode/UnifiedSend',
      ($0.UnifiedSendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UnifiedSendResponse.fromBuffer(value));
  static final _$decodeInvoice = $grpc.ClientMethod<$0.DecodeInvoiceRequest, $0.DecodeInvoiceResponse>(
      '/api.LightningNode/DecodeInvoice',
      ($0.DecodeInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DecodeInvoiceResponse.fromBuffer(value));
  static final _$decodeOffer = $grpc.ClientMethod<$0.DecodeOfferRequest, $0.DecodeOfferResponse>(
      '/api.LightningNode/DecodeOffer',
      ($0.DecodeOfferRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DecodeOfferResponse.fromBuffer(value));
  static final _$graphListChannels = $grpc.ClientMethod<$0.GraphListChannelsRequest, $0.GraphListChannelsResponse>(
      '/api.LightningNode/GraphListChannels',
      ($0.GraphListChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GraphListChannelsResponse.fromBuffer(value));
  static final _$graphGetChannel = $grpc.ClientMethod<$0.GraphGetChannelRequest, $0.GraphGetChannelResponse>(
      '/api.LightningNode/GraphGetChannel',
      ($0.GraphGetChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GraphGetChannelResponse.fromBuffer(value));
  static final _$graphListNodes = $grpc.ClientMethod<$0.GraphListNodesRequest, $0.GraphListNodesResponse>(
      '/api.LightningNode/GraphListNodes',
      ($0.GraphListNodesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GraphListNodesResponse.fromBuffer(value));
  static final _$graphGetNode = $grpc.ClientMethod<$0.GraphGetNodeRequest, $0.GraphGetNodeResponse>(
      '/api.LightningNode/GraphGetNode',
      ($0.GraphGetNodeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GraphGetNodeResponse.fromBuffer(value));
  static final _$subscribeEvents = $grpc.ClientMethod<$0.SubscribeEventsRequest, $1.EventEnvelope>(
      '/api.LightningNode/SubscribeEvents',
      ($0.SubscribeEventsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.EventEnvelope.fromBuffer(value));

  LightningNodeClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetNodeInfoResponse> getNodeInfo($0.GetNodeInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodeInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetBalancesResponse> getBalances($0.GetBalancesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getBalances, request, options: options);
  }

  $grpc.ResponseFuture<$0.OnchainReceiveResponse> onchainReceive($0.OnchainReceiveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$onchainReceive, request, options: options);
  }

  $grpc.ResponseFuture<$0.OnchainSendResponse> onchainSend($0.OnchainSendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$onchainSend, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11ReceiveResponse> bolt11Receive($0.Bolt11ReceiveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11Receive, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash($0.Bolt11ReceiveForHashRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11ReceiveForHash, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11ClaimForHashResponse> bolt11ClaimForHash($0.Bolt11ClaimForHashRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11ClaimForHash, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11FailForHashResponse> bolt11FailForHash($0.Bolt11FailForHashRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11FailForHash, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11ReceiveViaJitChannelResponse> bolt11ReceiveViaJitChannel($0.Bolt11ReceiveViaJitChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11ReceiveViaJitChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11ReceiveVariableAmountViaJitChannelResponse> bolt11ReceiveVariableAmountViaJitChannel($0.Bolt11ReceiveVariableAmountViaJitChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11ReceiveVariableAmountViaJitChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11SendResponse> bolt11Send($0.Bolt11SendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11Send, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt11SendUnderpayingResponse> bolt11SendUnderpaying($0.Bolt11SendUnderpayingRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt11SendUnderpaying, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt12ReceiveResponse> bolt12Receive($0.Bolt12ReceiveRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt12Receive, request, options: options);
  }

  $grpc.ResponseFuture<$0.Bolt12SendResponse> bolt12Send($0.Bolt12SendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bolt12Send, request, options: options);
  }

  $grpc.ResponseFuture<$0.SpontaneousSendResponse> spontaneousSend($0.SpontaneousSendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$spontaneousSend, request, options: options);
  }

  $grpc.ResponseFuture<$0.OpenChannelResponse> openChannel($0.OpenChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$openChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.SpliceInResponse> spliceIn($0.SpliceInRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$spliceIn, request, options: options);
  }

  $grpc.ResponseFuture<$0.SpliceOutResponse> spliceOut($0.SpliceOutRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$spliceOut, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateChannelConfigResponse> updateChannelConfig($0.UpdateChannelConfigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateChannelConfig, request, options: options);
  }

  $grpc.ResponseFuture<$0.CloseChannelResponse> closeChannel($0.CloseChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closeChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.ForceCloseChannelResponse> forceCloseChannel($0.ForceCloseChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forceCloseChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListChannelsResponse> listChannels($0.ListChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listChannels, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetPaymentDetailsResponse> getPaymentDetails($0.GetPaymentDetailsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getPaymentDetails, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPaymentsResponse> listPayments($0.ListPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListForwardedPaymentsResponse> listForwardedPayments($0.ListForwardedPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listForwardedPayments, request, options: options);
  }

  $grpc.ResponseFuture<$0.ConnectPeerResponse> connectPeer($0.ConnectPeerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectPeer, request, options: options);
  }

  $grpc.ResponseFuture<$0.DisconnectPeerResponse> disconnectPeer($0.DisconnectPeerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectPeer, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListPeersResponse> listPeers($0.ListPeersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPeers, request, options: options);
  }

  $grpc.ResponseFuture<$0.SignMessageResponse> signMessage($0.SignMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signMessage, request, options: options);
  }

  $grpc.ResponseFuture<$0.VerifySignatureResponse> verifySignature($0.VerifySignatureRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifySignature, request, options: options);
  }

  $grpc.ResponseFuture<$0.ExportPathfindingScoresResponse> exportPathfindingScores($0.ExportPathfindingScoresRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exportPathfindingScores, request, options: options);
  }

  $grpc.ResponseFuture<$0.UnifiedSendResponse> unifiedSend($0.UnifiedSendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$unifiedSend, request, options: options);
  }

  $grpc.ResponseFuture<$0.DecodeInvoiceResponse> decodeInvoice($0.DecodeInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$decodeInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$0.DecodeOfferResponse> decodeOffer($0.DecodeOfferRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$decodeOffer, request, options: options);
  }

  $grpc.ResponseFuture<$0.GraphListChannelsResponse> graphListChannels($0.GraphListChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$graphListChannels, request, options: options);
  }

  $grpc.ResponseFuture<$0.GraphGetChannelResponse> graphGetChannel($0.GraphGetChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$graphGetChannel, request, options: options);
  }

  $grpc.ResponseFuture<$0.GraphListNodesResponse> graphListNodes($0.GraphListNodesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$graphListNodes, request, options: options);
  }

  $grpc.ResponseFuture<$0.GraphGetNodeResponse> graphGetNode($0.GraphGetNodeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$graphGetNode, request, options: options);
  }

  $grpc.ResponseStream<$1.EventEnvelope> subscribeEvents($0.SubscribeEventsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeEvents, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('api.LightningNode')
abstract class LightningNodeServiceBase extends $grpc.Service {
  $core.String get $name => 'api.LightningNode';

  LightningNodeServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetNodeInfoRequest, $0.GetNodeInfoResponse>(
        'GetNodeInfo',
        getNodeInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetNodeInfoRequest.fromBuffer(value),
        ($0.GetNodeInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetBalancesRequest, $0.GetBalancesResponse>(
        'GetBalances',
        getBalances_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetBalancesRequest.fromBuffer(value),
        ($0.GetBalancesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OnchainReceiveRequest, $0.OnchainReceiveResponse>(
        'OnchainReceive',
        onchainReceive_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.OnchainReceiveRequest.fromBuffer(value),
        ($0.OnchainReceiveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OnchainSendRequest, $0.OnchainSendResponse>(
        'OnchainSend',
        onchainSend_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.OnchainSendRequest.fromBuffer(value),
        ($0.OnchainSendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11ReceiveRequest, $0.Bolt11ReceiveResponse>(
        'Bolt11Receive',
        bolt11Receive_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11ReceiveRequest.fromBuffer(value),
        ($0.Bolt11ReceiveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11ReceiveForHashRequest, $0.Bolt11ReceiveForHashResponse>(
        'Bolt11ReceiveForHash',
        bolt11ReceiveForHash_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11ReceiveForHashRequest.fromBuffer(value),
        ($0.Bolt11ReceiveForHashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11ClaimForHashRequest, $0.Bolt11ClaimForHashResponse>(
        'Bolt11ClaimForHash',
        bolt11ClaimForHash_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11ClaimForHashRequest.fromBuffer(value),
        ($0.Bolt11ClaimForHashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11FailForHashRequest, $0.Bolt11FailForHashResponse>(
        'Bolt11FailForHash',
        bolt11FailForHash_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11FailForHashRequest.fromBuffer(value),
        ($0.Bolt11FailForHashResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11ReceiveViaJitChannelRequest, $0.Bolt11ReceiveViaJitChannelResponse>(
        'Bolt11ReceiveViaJitChannel',
        bolt11ReceiveViaJitChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11ReceiveViaJitChannelRequest.fromBuffer(value),
        ($0.Bolt11ReceiveViaJitChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11ReceiveVariableAmountViaJitChannelRequest, $0.Bolt11ReceiveVariableAmountViaJitChannelResponse>(
        'Bolt11ReceiveVariableAmountViaJitChannel',
        bolt11ReceiveVariableAmountViaJitChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11ReceiveVariableAmountViaJitChannelRequest.fromBuffer(value),
        ($0.Bolt11ReceiveVariableAmountViaJitChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11SendRequest, $0.Bolt11SendResponse>(
        'Bolt11Send',
        bolt11Send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11SendRequest.fromBuffer(value),
        ($0.Bolt11SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt11SendUnderpayingRequest, $0.Bolt11SendUnderpayingResponse>(
        'Bolt11SendUnderpaying',
        bolt11SendUnderpaying_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt11SendUnderpayingRequest.fromBuffer(value),
        ($0.Bolt11SendUnderpayingResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt12ReceiveRequest, $0.Bolt12ReceiveResponse>(
        'Bolt12Receive',
        bolt12Receive_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt12ReceiveRequest.fromBuffer(value),
        ($0.Bolt12ReceiveResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Bolt12SendRequest, $0.Bolt12SendResponse>(
        'Bolt12Send',
        bolt12Send_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Bolt12SendRequest.fromBuffer(value),
        ($0.Bolt12SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SpontaneousSendRequest, $0.SpontaneousSendResponse>(
        'SpontaneousSend',
        spontaneousSend_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SpontaneousSendRequest.fromBuffer(value),
        ($0.SpontaneousSendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.OpenChannelRequest, $0.OpenChannelResponse>(
        'OpenChannel',
        openChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.OpenChannelRequest.fromBuffer(value),
        ($0.OpenChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SpliceInRequest, $0.SpliceInResponse>(
        'SpliceIn',
        spliceIn_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SpliceInRequest.fromBuffer(value),
        ($0.SpliceInResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SpliceOutRequest, $0.SpliceOutResponse>(
        'SpliceOut',
        spliceOut_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SpliceOutRequest.fromBuffer(value),
        ($0.SpliceOutResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateChannelConfigRequest, $0.UpdateChannelConfigResponse>(
        'UpdateChannelConfig',
        updateChannelConfig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateChannelConfigRequest.fromBuffer(value),
        ($0.UpdateChannelConfigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CloseChannelRequest, $0.CloseChannelResponse>(
        'CloseChannel',
        closeChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CloseChannelRequest.fromBuffer(value),
        ($0.CloseChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ForceCloseChannelRequest, $0.ForceCloseChannelResponse>(
        'ForceCloseChannel',
        forceCloseChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ForceCloseChannelRequest.fromBuffer(value),
        ($0.ForceCloseChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListChannelsRequest, $0.ListChannelsResponse>(
        'ListChannels',
        listChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListChannelsRequest.fromBuffer(value),
        ($0.ListChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetPaymentDetailsRequest, $0.GetPaymentDetailsResponse>(
        'GetPaymentDetails',
        getPaymentDetails_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetPaymentDetailsRequest.fromBuffer(value),
        ($0.GetPaymentDetailsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListPaymentsRequest, $0.ListPaymentsResponse>(
        'ListPayments',
        listPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListPaymentsRequest.fromBuffer(value),
        ($0.ListPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListForwardedPaymentsRequest, $0.ListForwardedPaymentsResponse>(
        'ListForwardedPayments',
        listForwardedPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListForwardedPaymentsRequest.fromBuffer(value),
        ($0.ListForwardedPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ConnectPeerRequest, $0.ConnectPeerResponse>(
        'ConnectPeer',
        connectPeer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ConnectPeerRequest.fromBuffer(value),
        ($0.ConnectPeerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DisconnectPeerRequest, $0.DisconnectPeerResponse>(
        'DisconnectPeer',
        disconnectPeer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DisconnectPeerRequest.fromBuffer(value),
        ($0.DisconnectPeerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListPeersRequest, $0.ListPeersResponse>(
        'ListPeers',
        listPeers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListPeersRequest.fromBuffer(value),
        ($0.ListPeersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SignMessageRequest, $0.SignMessageResponse>(
        'SignMessage',
        signMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SignMessageRequest.fromBuffer(value),
        ($0.SignMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.VerifySignatureRequest, $0.VerifySignatureResponse>(
        'VerifySignature',
        verifySignature_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.VerifySignatureRequest.fromBuffer(value),
        ($0.VerifySignatureResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExportPathfindingScoresRequest, $0.ExportPathfindingScoresResponse>(
        'ExportPathfindingScores',
        exportPathfindingScores_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExportPathfindingScoresRequest.fromBuffer(value),
        ($0.ExportPathfindingScoresResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UnifiedSendRequest, $0.UnifiedSendResponse>(
        'UnifiedSend',
        unifiedSend_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UnifiedSendRequest.fromBuffer(value),
        ($0.UnifiedSendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DecodeInvoiceRequest, $0.DecodeInvoiceResponse>(
        'DecodeInvoice',
        decodeInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DecodeInvoiceRequest.fromBuffer(value),
        ($0.DecodeInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DecodeOfferRequest, $0.DecodeOfferResponse>(
        'DecodeOffer',
        decodeOffer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DecodeOfferRequest.fromBuffer(value),
        ($0.DecodeOfferResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GraphListChannelsRequest, $0.GraphListChannelsResponse>(
        'GraphListChannels',
        graphListChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GraphListChannelsRequest.fromBuffer(value),
        ($0.GraphListChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GraphGetChannelRequest, $0.GraphGetChannelResponse>(
        'GraphGetChannel',
        graphGetChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GraphGetChannelRequest.fromBuffer(value),
        ($0.GraphGetChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GraphListNodesRequest, $0.GraphListNodesResponse>(
        'GraphListNodes',
        graphListNodes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GraphListNodesRequest.fromBuffer(value),
        ($0.GraphListNodesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GraphGetNodeRequest, $0.GraphGetNodeResponse>(
        'GraphGetNode',
        graphGetNode_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GraphGetNodeRequest.fromBuffer(value),
        ($0.GraphGetNodeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SubscribeEventsRequest, $1.EventEnvelope>(
        'SubscribeEvents',
        subscribeEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.SubscribeEventsRequest.fromBuffer(value),
        ($1.EventEnvelope value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetNodeInfoResponse> getNodeInfo_Pre($grpc.ServiceCall $call, $async.Future<$0.GetNodeInfoRequest> $request) async {
    return getNodeInfo($call, await $request);
  }

  $async.Future<$0.GetBalancesResponse> getBalances_Pre($grpc.ServiceCall $call, $async.Future<$0.GetBalancesRequest> $request) async {
    return getBalances($call, await $request);
  }

  $async.Future<$0.OnchainReceiveResponse> onchainReceive_Pre($grpc.ServiceCall $call, $async.Future<$0.OnchainReceiveRequest> $request) async {
    return onchainReceive($call, await $request);
  }

  $async.Future<$0.OnchainSendResponse> onchainSend_Pre($grpc.ServiceCall $call, $async.Future<$0.OnchainSendRequest> $request) async {
    return onchainSend($call, await $request);
  }

  $async.Future<$0.Bolt11ReceiveResponse> bolt11Receive_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11ReceiveRequest> $request) async {
    return bolt11Receive($call, await $request);
  }

  $async.Future<$0.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11ReceiveForHashRequest> $request) async {
    return bolt11ReceiveForHash($call, await $request);
  }

  $async.Future<$0.Bolt11ClaimForHashResponse> bolt11ClaimForHash_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11ClaimForHashRequest> $request) async {
    return bolt11ClaimForHash($call, await $request);
  }

  $async.Future<$0.Bolt11FailForHashResponse> bolt11FailForHash_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11FailForHashRequest> $request) async {
    return bolt11FailForHash($call, await $request);
  }

  $async.Future<$0.Bolt11ReceiveViaJitChannelResponse> bolt11ReceiveViaJitChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11ReceiveViaJitChannelRequest> $request) async {
    return bolt11ReceiveViaJitChannel($call, await $request);
  }

  $async.Future<$0.Bolt11ReceiveVariableAmountViaJitChannelResponse> bolt11ReceiveVariableAmountViaJitChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11ReceiveVariableAmountViaJitChannelRequest> $request) async {
    return bolt11ReceiveVariableAmountViaJitChannel($call, await $request);
  }

  $async.Future<$0.Bolt11SendResponse> bolt11Send_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11SendRequest> $request) async {
    return bolt11Send($call, await $request);
  }

  $async.Future<$0.Bolt11SendUnderpayingResponse> bolt11SendUnderpaying_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt11SendUnderpayingRequest> $request) async {
    return bolt11SendUnderpaying($call, await $request);
  }

  $async.Future<$0.Bolt12ReceiveResponse> bolt12Receive_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt12ReceiveRequest> $request) async {
    return bolt12Receive($call, await $request);
  }

  $async.Future<$0.Bolt12SendResponse> bolt12Send_Pre($grpc.ServiceCall $call, $async.Future<$0.Bolt12SendRequest> $request) async {
    return bolt12Send($call, await $request);
  }

  $async.Future<$0.SpontaneousSendResponse> spontaneousSend_Pre($grpc.ServiceCall $call, $async.Future<$0.SpontaneousSendRequest> $request) async {
    return spontaneousSend($call, await $request);
  }

  $async.Future<$0.OpenChannelResponse> openChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.OpenChannelRequest> $request) async {
    return openChannel($call, await $request);
  }

  $async.Future<$0.SpliceInResponse> spliceIn_Pre($grpc.ServiceCall $call, $async.Future<$0.SpliceInRequest> $request) async {
    return spliceIn($call, await $request);
  }

  $async.Future<$0.SpliceOutResponse> spliceOut_Pre($grpc.ServiceCall $call, $async.Future<$0.SpliceOutRequest> $request) async {
    return spliceOut($call, await $request);
  }

  $async.Future<$0.UpdateChannelConfigResponse> updateChannelConfig_Pre($grpc.ServiceCall $call, $async.Future<$0.UpdateChannelConfigRequest> $request) async {
    return updateChannelConfig($call, await $request);
  }

  $async.Future<$0.CloseChannelResponse> closeChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.CloseChannelRequest> $request) async {
    return closeChannel($call, await $request);
  }

  $async.Future<$0.ForceCloseChannelResponse> forceCloseChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.ForceCloseChannelRequest> $request) async {
    return forceCloseChannel($call, await $request);
  }

  $async.Future<$0.ListChannelsResponse> listChannels_Pre($grpc.ServiceCall $call, $async.Future<$0.ListChannelsRequest> $request) async {
    return listChannels($call, await $request);
  }

  $async.Future<$0.GetPaymentDetailsResponse> getPaymentDetails_Pre($grpc.ServiceCall $call, $async.Future<$0.GetPaymentDetailsRequest> $request) async {
    return getPaymentDetails($call, await $request);
  }

  $async.Future<$0.ListPaymentsResponse> listPayments_Pre($grpc.ServiceCall $call, $async.Future<$0.ListPaymentsRequest> $request) async {
    return listPayments($call, await $request);
  }

  $async.Future<$0.ListForwardedPaymentsResponse> listForwardedPayments_Pre($grpc.ServiceCall $call, $async.Future<$0.ListForwardedPaymentsRequest> $request) async {
    return listForwardedPayments($call, await $request);
  }

  $async.Future<$0.ConnectPeerResponse> connectPeer_Pre($grpc.ServiceCall $call, $async.Future<$0.ConnectPeerRequest> $request) async {
    return connectPeer($call, await $request);
  }

  $async.Future<$0.DisconnectPeerResponse> disconnectPeer_Pre($grpc.ServiceCall $call, $async.Future<$0.DisconnectPeerRequest> $request) async {
    return disconnectPeer($call, await $request);
  }

  $async.Future<$0.ListPeersResponse> listPeers_Pre($grpc.ServiceCall $call, $async.Future<$0.ListPeersRequest> $request) async {
    return listPeers($call, await $request);
  }

  $async.Future<$0.SignMessageResponse> signMessage_Pre($grpc.ServiceCall $call, $async.Future<$0.SignMessageRequest> $request) async {
    return signMessage($call, await $request);
  }

  $async.Future<$0.VerifySignatureResponse> verifySignature_Pre($grpc.ServiceCall $call, $async.Future<$0.VerifySignatureRequest> $request) async {
    return verifySignature($call, await $request);
  }

  $async.Future<$0.ExportPathfindingScoresResponse> exportPathfindingScores_Pre($grpc.ServiceCall $call, $async.Future<$0.ExportPathfindingScoresRequest> $request) async {
    return exportPathfindingScores($call, await $request);
  }

  $async.Future<$0.UnifiedSendResponse> unifiedSend_Pre($grpc.ServiceCall $call, $async.Future<$0.UnifiedSendRequest> $request) async {
    return unifiedSend($call, await $request);
  }

  $async.Future<$0.DecodeInvoiceResponse> decodeInvoice_Pre($grpc.ServiceCall $call, $async.Future<$0.DecodeInvoiceRequest> $request) async {
    return decodeInvoice($call, await $request);
  }

  $async.Future<$0.DecodeOfferResponse> decodeOffer_Pre($grpc.ServiceCall $call, $async.Future<$0.DecodeOfferRequest> $request) async {
    return decodeOffer($call, await $request);
  }

  $async.Future<$0.GraphListChannelsResponse> graphListChannels_Pre($grpc.ServiceCall $call, $async.Future<$0.GraphListChannelsRequest> $request) async {
    return graphListChannels($call, await $request);
  }

  $async.Future<$0.GraphGetChannelResponse> graphGetChannel_Pre($grpc.ServiceCall $call, $async.Future<$0.GraphGetChannelRequest> $request) async {
    return graphGetChannel($call, await $request);
  }

  $async.Future<$0.GraphListNodesResponse> graphListNodes_Pre($grpc.ServiceCall $call, $async.Future<$0.GraphListNodesRequest> $request) async {
    return graphListNodes($call, await $request);
  }

  $async.Future<$0.GraphGetNodeResponse> graphGetNode_Pre($grpc.ServiceCall $call, $async.Future<$0.GraphGetNodeRequest> $request) async {
    return graphGetNode($call, await $request);
  }

  $async.Stream<$1.EventEnvelope> subscribeEvents_Pre($grpc.ServiceCall $call, $async.Future<$0.SubscribeEventsRequest> $request) async* {
    yield* subscribeEvents($call, await $request);
  }

  $async.Future<$0.GetNodeInfoResponse> getNodeInfo($grpc.ServiceCall call, $0.GetNodeInfoRequest request);
  $async.Future<$0.GetBalancesResponse> getBalances($grpc.ServiceCall call, $0.GetBalancesRequest request);
  $async.Future<$0.OnchainReceiveResponse> onchainReceive($grpc.ServiceCall call, $0.OnchainReceiveRequest request);
  $async.Future<$0.OnchainSendResponse> onchainSend($grpc.ServiceCall call, $0.OnchainSendRequest request);
  $async.Future<$0.Bolt11ReceiveResponse> bolt11Receive($grpc.ServiceCall call, $0.Bolt11ReceiveRequest request);
  $async.Future<$0.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash($grpc.ServiceCall call, $0.Bolt11ReceiveForHashRequest request);
  $async.Future<$0.Bolt11ClaimForHashResponse> bolt11ClaimForHash($grpc.ServiceCall call, $0.Bolt11ClaimForHashRequest request);
  $async.Future<$0.Bolt11FailForHashResponse> bolt11FailForHash($grpc.ServiceCall call, $0.Bolt11FailForHashRequest request);
  $async.Future<$0.Bolt11ReceiveViaJitChannelResponse> bolt11ReceiveViaJitChannel($grpc.ServiceCall call, $0.Bolt11ReceiveViaJitChannelRequest request);
  $async.Future<$0.Bolt11ReceiveVariableAmountViaJitChannelResponse> bolt11ReceiveVariableAmountViaJitChannel($grpc.ServiceCall call, $0.Bolt11ReceiveVariableAmountViaJitChannelRequest request);
  $async.Future<$0.Bolt11SendResponse> bolt11Send($grpc.ServiceCall call, $0.Bolt11SendRequest request);
  $async.Future<$0.Bolt11SendUnderpayingResponse> bolt11SendUnderpaying($grpc.ServiceCall call, $0.Bolt11SendUnderpayingRequest request);
  $async.Future<$0.Bolt12ReceiveResponse> bolt12Receive($grpc.ServiceCall call, $0.Bolt12ReceiveRequest request);
  $async.Future<$0.Bolt12SendResponse> bolt12Send($grpc.ServiceCall call, $0.Bolt12SendRequest request);
  $async.Future<$0.SpontaneousSendResponse> spontaneousSend($grpc.ServiceCall call, $0.SpontaneousSendRequest request);
  $async.Future<$0.OpenChannelResponse> openChannel($grpc.ServiceCall call, $0.OpenChannelRequest request);
  $async.Future<$0.SpliceInResponse> spliceIn($grpc.ServiceCall call, $0.SpliceInRequest request);
  $async.Future<$0.SpliceOutResponse> spliceOut($grpc.ServiceCall call, $0.SpliceOutRequest request);
  $async.Future<$0.UpdateChannelConfigResponse> updateChannelConfig($grpc.ServiceCall call, $0.UpdateChannelConfigRequest request);
  $async.Future<$0.CloseChannelResponse> closeChannel($grpc.ServiceCall call, $0.CloseChannelRequest request);
  $async.Future<$0.ForceCloseChannelResponse> forceCloseChannel($grpc.ServiceCall call, $0.ForceCloseChannelRequest request);
  $async.Future<$0.ListChannelsResponse> listChannels($grpc.ServiceCall call, $0.ListChannelsRequest request);
  $async.Future<$0.GetPaymentDetailsResponse> getPaymentDetails($grpc.ServiceCall call, $0.GetPaymentDetailsRequest request);
  $async.Future<$0.ListPaymentsResponse> listPayments($grpc.ServiceCall call, $0.ListPaymentsRequest request);
  $async.Future<$0.ListForwardedPaymentsResponse> listForwardedPayments($grpc.ServiceCall call, $0.ListForwardedPaymentsRequest request);
  $async.Future<$0.ConnectPeerResponse> connectPeer($grpc.ServiceCall call, $0.ConnectPeerRequest request);
  $async.Future<$0.DisconnectPeerResponse> disconnectPeer($grpc.ServiceCall call, $0.DisconnectPeerRequest request);
  $async.Future<$0.ListPeersResponse> listPeers($grpc.ServiceCall call, $0.ListPeersRequest request);
  $async.Future<$0.SignMessageResponse> signMessage($grpc.ServiceCall call, $0.SignMessageRequest request);
  $async.Future<$0.VerifySignatureResponse> verifySignature($grpc.ServiceCall call, $0.VerifySignatureRequest request);
  $async.Future<$0.ExportPathfindingScoresResponse> exportPathfindingScores($grpc.ServiceCall call, $0.ExportPathfindingScoresRequest request);
  $async.Future<$0.UnifiedSendResponse> unifiedSend($grpc.ServiceCall call, $0.UnifiedSendRequest request);
  $async.Future<$0.DecodeInvoiceResponse> decodeInvoice($grpc.ServiceCall call, $0.DecodeInvoiceRequest request);
  $async.Future<$0.DecodeOfferResponse> decodeOffer($grpc.ServiceCall call, $0.DecodeOfferRequest request);
  $async.Future<$0.GraphListChannelsResponse> graphListChannels($grpc.ServiceCall call, $0.GraphListChannelsRequest request);
  $async.Future<$0.GraphGetChannelResponse> graphGetChannel($grpc.ServiceCall call, $0.GraphGetChannelRequest request);
  $async.Future<$0.GraphListNodesResponse> graphListNodes($grpc.ServiceCall call, $0.GraphListNodesRequest request);
  $async.Future<$0.GraphGetNodeResponse> graphGetNode($grpc.ServiceCall call, $0.GraphGetNodeRequest request);
  $async.Stream<$1.EventEnvelope> subscribeEvents($grpc.ServiceCall call, $0.SubscribeEventsRequest request);
}
