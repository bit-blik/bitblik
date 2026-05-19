//
//  Generated code. Do not modify.
//  source: lnd/lightning.proto
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

export 'lightning.pb.dart';

@$pb.GrpcServiceName('lnrpc.Lightning')
class LightningClient extends $grpc.Client {
  static final _$walletBalance = $grpc.ClientMethod<$1.WalletBalanceRequest, $1.WalletBalanceResponse>(
      '/lnrpc.Lightning/WalletBalance',
      ($1.WalletBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.WalletBalanceResponse.fromBuffer(value));
  static final _$channelBalance = $grpc.ClientMethod<$1.ChannelBalanceRequest, $1.ChannelBalanceResponse>(
      '/lnrpc.Lightning/ChannelBalance',
      ($1.ChannelBalanceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelBalanceResponse.fromBuffer(value));
  static final _$getTransactions = $grpc.ClientMethod<$1.GetTransactionsRequest, $1.TransactionDetails>(
      '/lnrpc.Lightning/GetTransactions',
      ($1.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.TransactionDetails.fromBuffer(value));
  static final _$estimateFee = $grpc.ClientMethod<$1.EstimateFeeRequest, $1.EstimateFeeResponse>(
      '/lnrpc.Lightning/EstimateFee',
      ($1.EstimateFeeRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.EstimateFeeResponse.fromBuffer(value));
  static final _$sendCoins = $grpc.ClientMethod<$1.SendCoinsRequest, $1.SendCoinsResponse>(
      '/lnrpc.Lightning/SendCoins',
      ($1.SendCoinsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendCoinsResponse.fromBuffer(value));
  static final _$listUnspent = $grpc.ClientMethod<$1.ListUnspentRequest, $1.ListUnspentResponse>(
      '/lnrpc.Lightning/ListUnspent',
      ($1.ListUnspentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListUnspentResponse.fromBuffer(value));
  static final _$subscribeTransactions = $grpc.ClientMethod<$1.GetTransactionsRequest, $1.Transaction>(
      '/lnrpc.Lightning/SubscribeTransactions',
      ($1.GetTransactionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Transaction.fromBuffer(value));
  static final _$sendMany = $grpc.ClientMethod<$1.SendManyRequest, $1.SendManyResponse>(
      '/lnrpc.Lightning/SendMany',
      ($1.SendManyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendManyResponse.fromBuffer(value));
  static final _$newAddress = $grpc.ClientMethod<$1.NewAddressRequest, $1.NewAddressResponse>(
      '/lnrpc.Lightning/NewAddress',
      ($1.NewAddressRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NewAddressResponse.fromBuffer(value));
  static final _$signMessage = $grpc.ClientMethod<$1.SignMessageRequest, $1.SignMessageResponse>(
      '/lnrpc.Lightning/SignMessage',
      ($1.SignMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SignMessageResponse.fromBuffer(value));
  static final _$verifyMessage = $grpc.ClientMethod<$1.VerifyMessageRequest, $1.VerifyMessageResponse>(
      '/lnrpc.Lightning/VerifyMessage',
      ($1.VerifyMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.VerifyMessageResponse.fromBuffer(value));
  static final _$connectPeer = $grpc.ClientMethod<$1.ConnectPeerRequest, $1.ConnectPeerResponse>(
      '/lnrpc.Lightning/ConnectPeer',
      ($1.ConnectPeerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ConnectPeerResponse.fromBuffer(value));
  static final _$disconnectPeer = $grpc.ClientMethod<$1.DisconnectPeerRequest, $1.DisconnectPeerResponse>(
      '/lnrpc.Lightning/DisconnectPeer',
      ($1.DisconnectPeerRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DisconnectPeerResponse.fromBuffer(value));
  static final _$listPeers = $grpc.ClientMethod<$1.ListPeersRequest, $1.ListPeersResponse>(
      '/lnrpc.Lightning/ListPeers',
      ($1.ListPeersRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListPeersResponse.fromBuffer(value));
  static final _$subscribePeerEvents = $grpc.ClientMethod<$1.PeerEventSubscription, $1.PeerEvent>(
      '/lnrpc.Lightning/SubscribePeerEvents',
      ($1.PeerEventSubscription value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PeerEvent.fromBuffer(value));
  static final _$getInfo = $grpc.ClientMethod<$1.GetInfoRequest, $1.GetInfoResponse>(
      '/lnrpc.Lightning/GetInfo',
      ($1.GetInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetInfoResponse.fromBuffer(value));
  static final _$getDebugInfo = $grpc.ClientMethod<$1.GetDebugInfoRequest, $1.GetDebugInfoResponse>(
      '/lnrpc.Lightning/GetDebugInfo',
      ($1.GetDebugInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetDebugInfoResponse.fromBuffer(value));
  static final _$getRecoveryInfo = $grpc.ClientMethod<$1.GetRecoveryInfoRequest, $1.GetRecoveryInfoResponse>(
      '/lnrpc.Lightning/GetRecoveryInfo',
      ($1.GetRecoveryInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GetRecoveryInfoResponse.fromBuffer(value));
  static final _$pendingChannels = $grpc.ClientMethod<$1.PendingChannelsRequest, $1.PendingChannelsResponse>(
      '/lnrpc.Lightning/PendingChannels',
      ($1.PendingChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PendingChannelsResponse.fromBuffer(value));
  static final _$listChannels = $grpc.ClientMethod<$1.ListChannelsRequest, $1.ListChannelsResponse>(
      '/lnrpc.Lightning/ListChannels',
      ($1.ListChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListChannelsResponse.fromBuffer(value));
  static final _$subscribeChannelEvents = $grpc.ClientMethod<$1.ChannelEventSubscription, $1.ChannelEventUpdate>(
      '/lnrpc.Lightning/SubscribeChannelEvents',
      ($1.ChannelEventSubscription value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelEventUpdate.fromBuffer(value));
  static final _$closedChannels = $grpc.ClientMethod<$1.ClosedChannelsRequest, $1.ClosedChannelsResponse>(
      '/lnrpc.Lightning/ClosedChannels',
      ($1.ClosedChannelsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ClosedChannelsResponse.fromBuffer(value));
  static final _$openChannelSync = $grpc.ClientMethod<$1.OpenChannelRequest, $1.ChannelPoint>(
      '/lnrpc.Lightning/OpenChannelSync',
      ($1.OpenChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelPoint.fromBuffer(value));
  static final _$openChannel = $grpc.ClientMethod<$1.OpenChannelRequest, $1.OpenStatusUpdate>(
      '/lnrpc.Lightning/OpenChannel',
      ($1.OpenChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.OpenStatusUpdate.fromBuffer(value));
  static final _$batchOpenChannel = $grpc.ClientMethod<$1.BatchOpenChannelRequest, $1.BatchOpenChannelResponse>(
      '/lnrpc.Lightning/BatchOpenChannel',
      ($1.BatchOpenChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BatchOpenChannelResponse.fromBuffer(value));
  static final _$fundingStateStep = $grpc.ClientMethod<$1.FundingTransitionMsg, $1.FundingStateStepResp>(
      '/lnrpc.Lightning/FundingStateStep',
      ($1.FundingTransitionMsg value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FundingStateStepResp.fromBuffer(value));
  static final _$channelAcceptor = $grpc.ClientMethod<$1.ChannelAcceptResponse, $1.ChannelAcceptRequest>(
      '/lnrpc.Lightning/ChannelAcceptor',
      ($1.ChannelAcceptResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelAcceptRequest.fromBuffer(value));
  static final _$closeChannel = $grpc.ClientMethod<$1.CloseChannelRequest, $1.CloseStatusUpdate>(
      '/lnrpc.Lightning/CloseChannel',
      ($1.CloseChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CloseStatusUpdate.fromBuffer(value));
  static final _$abandonChannel = $grpc.ClientMethod<$1.AbandonChannelRequest, $1.AbandonChannelResponse>(
      '/lnrpc.Lightning/AbandonChannel',
      ($1.AbandonChannelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AbandonChannelResponse.fromBuffer(value));
  static final _$sendPayment = $grpc.ClientMethod<$1.SendRequest, $1.SendResponse>(
      '/lnrpc.Lightning/SendPayment',
      ($1.SendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendResponse.fromBuffer(value));
  static final _$sendPaymentSync = $grpc.ClientMethod<$1.SendRequest, $1.SendResponse>(
      '/lnrpc.Lightning/SendPaymentSync',
      ($1.SendRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendResponse.fromBuffer(value));
  static final _$sendToRoute = $grpc.ClientMethod<$1.SendToRouteRequest, $1.SendResponse>(
      '/lnrpc.Lightning/SendToRoute',
      ($1.SendToRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendResponse.fromBuffer(value));
  static final _$sendToRouteSync = $grpc.ClientMethod<$1.SendToRouteRequest, $1.SendResponse>(
      '/lnrpc.Lightning/SendToRouteSync',
      ($1.SendToRouteRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendResponse.fromBuffer(value));
  static final _$addInvoice = $grpc.ClientMethod<$1.Invoice, $1.AddInvoiceResponse>(
      '/lnrpc.Lightning/AddInvoice',
      ($1.Invoice value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.AddInvoiceResponse.fromBuffer(value));
  static final _$listInvoices = $grpc.ClientMethod<$1.ListInvoiceRequest, $1.ListInvoiceResponse>(
      '/lnrpc.Lightning/ListInvoices',
      ($1.ListInvoiceRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListInvoiceResponse.fromBuffer(value));
  static final _$lookupInvoice = $grpc.ClientMethod<$1.PaymentHash, $1.Invoice>(
      '/lnrpc.Lightning/LookupInvoice',
      ($1.PaymentHash value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Invoice.fromBuffer(value));
  static final _$subscribeInvoices = $grpc.ClientMethod<$1.InvoiceSubscription, $1.Invoice>(
      '/lnrpc.Lightning/SubscribeInvoices',
      ($1.InvoiceSubscription value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Invoice.fromBuffer(value));
  static final _$decodePayReq = $grpc.ClientMethod<$1.PayReqString, $1.PayReq>(
      '/lnrpc.Lightning/DecodePayReq',
      ($1.PayReqString value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PayReq.fromBuffer(value));
  static final _$listPayments = $grpc.ClientMethod<$1.ListPaymentsRequest, $1.ListPaymentsResponse>(
      '/lnrpc.Lightning/ListPayments',
      ($1.ListPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListPaymentsResponse.fromBuffer(value));
  static final _$deletePayment = $grpc.ClientMethod<$1.DeletePaymentRequest, $1.DeletePaymentResponse>(
      '/lnrpc.Lightning/DeletePayment',
      ($1.DeletePaymentRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DeletePaymentResponse.fromBuffer(value));
  static final _$deleteAllPayments = $grpc.ClientMethod<$1.DeleteAllPaymentsRequest, $1.DeleteAllPaymentsResponse>(
      '/lnrpc.Lightning/DeleteAllPayments',
      ($1.DeleteAllPaymentsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DeleteAllPaymentsResponse.fromBuffer(value));
  static final _$describeGraph = $grpc.ClientMethod<$1.ChannelGraphRequest, $1.ChannelGraph>(
      '/lnrpc.Lightning/DescribeGraph',
      ($1.ChannelGraphRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelGraph.fromBuffer(value));
  static final _$getNodeMetrics = $grpc.ClientMethod<$1.NodeMetricsRequest, $1.NodeMetricsResponse>(
      '/lnrpc.Lightning/GetNodeMetrics',
      ($1.NodeMetricsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NodeMetricsResponse.fromBuffer(value));
  static final _$getChanInfo = $grpc.ClientMethod<$1.ChanInfoRequest, $1.ChannelEdge>(
      '/lnrpc.Lightning/GetChanInfo',
      ($1.ChanInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelEdge.fromBuffer(value));
  static final _$getNodeInfo = $grpc.ClientMethod<$1.NodeInfoRequest, $1.NodeInfo>(
      '/lnrpc.Lightning/GetNodeInfo',
      ($1.NodeInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NodeInfo.fromBuffer(value));
  static final _$queryRoutes = $grpc.ClientMethod<$1.QueryRoutesRequest, $1.QueryRoutesResponse>(
      '/lnrpc.Lightning/QueryRoutes',
      ($1.QueryRoutesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.QueryRoutesResponse.fromBuffer(value));
  static final _$getNetworkInfo = $grpc.ClientMethod<$1.NetworkInfoRequest, $1.NetworkInfo>(
      '/lnrpc.Lightning/GetNetworkInfo',
      ($1.NetworkInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.NetworkInfo.fromBuffer(value));
  static final _$stopDaemon = $grpc.ClientMethod<$1.StopRequest, $1.StopResponse>(
      '/lnrpc.Lightning/StopDaemon',
      ($1.StopRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.StopResponse.fromBuffer(value));
  static final _$subscribeChannelGraph = $grpc.ClientMethod<$1.GraphTopologySubscription, $1.GraphTopologyUpdate>(
      '/lnrpc.Lightning/SubscribeChannelGraph',
      ($1.GraphTopologySubscription value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.GraphTopologyUpdate.fromBuffer(value));
  static final _$debugLevel = $grpc.ClientMethod<$1.DebugLevelRequest, $1.DebugLevelResponse>(
      '/lnrpc.Lightning/DebugLevel',
      ($1.DebugLevelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DebugLevelResponse.fromBuffer(value));
  static final _$feeReport = $grpc.ClientMethod<$1.FeeReportRequest, $1.FeeReportResponse>(
      '/lnrpc.Lightning/FeeReport',
      ($1.FeeReportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.FeeReportResponse.fromBuffer(value));
  static final _$updateChannelPolicy = $grpc.ClientMethod<$1.PolicyUpdateRequest, $1.PolicyUpdateResponse>(
      '/lnrpc.Lightning/UpdateChannelPolicy',
      ($1.PolicyUpdateRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PolicyUpdateResponse.fromBuffer(value));
  static final _$forwardingHistory = $grpc.ClientMethod<$1.ForwardingHistoryRequest, $1.ForwardingHistoryResponse>(
      '/lnrpc.Lightning/ForwardingHistory',
      ($1.ForwardingHistoryRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ForwardingHistoryResponse.fromBuffer(value));
  static final _$exportChannelBackup = $grpc.ClientMethod<$1.ExportChannelBackupRequest, $1.ChannelBackup>(
      '/lnrpc.Lightning/ExportChannelBackup',
      ($1.ExportChannelBackupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChannelBackup.fromBuffer(value));
  static final _$exportAllChannelBackups = $grpc.ClientMethod<$1.ChanBackupExportRequest, $1.ChanBackupSnapshot>(
      '/lnrpc.Lightning/ExportAllChannelBackups',
      ($1.ChanBackupExportRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChanBackupSnapshot.fromBuffer(value));
  static final _$verifyChanBackup = $grpc.ClientMethod<$1.ChanBackupSnapshot, $1.VerifyChanBackupResponse>(
      '/lnrpc.Lightning/VerifyChanBackup',
      ($1.ChanBackupSnapshot value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.VerifyChanBackupResponse.fromBuffer(value));
  static final _$restoreChannelBackups = $grpc.ClientMethod<$1.RestoreChanBackupRequest, $1.RestoreBackupResponse>(
      '/lnrpc.Lightning/RestoreChannelBackups',
      ($1.RestoreChanBackupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RestoreBackupResponse.fromBuffer(value));
  static final _$subscribeChannelBackups = $grpc.ClientMethod<$1.ChannelBackupSubscription, $1.ChanBackupSnapshot>(
      '/lnrpc.Lightning/SubscribeChannelBackups',
      ($1.ChannelBackupSubscription value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ChanBackupSnapshot.fromBuffer(value));
  static final _$bakeMacaroon = $grpc.ClientMethod<$1.BakeMacaroonRequest, $1.BakeMacaroonResponse>(
      '/lnrpc.Lightning/BakeMacaroon',
      ($1.BakeMacaroonRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.BakeMacaroonResponse.fromBuffer(value));
  static final _$listMacaroonIDs = $grpc.ClientMethod<$1.ListMacaroonIDsRequest, $1.ListMacaroonIDsResponse>(
      '/lnrpc.Lightning/ListMacaroonIDs',
      ($1.ListMacaroonIDsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListMacaroonIDsResponse.fromBuffer(value));
  static final _$deleteMacaroonID = $grpc.ClientMethod<$1.DeleteMacaroonIDRequest, $1.DeleteMacaroonIDResponse>(
      '/lnrpc.Lightning/DeleteMacaroonID',
      ($1.DeleteMacaroonIDRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.DeleteMacaroonIDResponse.fromBuffer(value));
  static final _$listPermissions = $grpc.ClientMethod<$1.ListPermissionsRequest, $1.ListPermissionsResponse>(
      '/lnrpc.Lightning/ListPermissions',
      ($1.ListPermissionsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListPermissionsResponse.fromBuffer(value));
  static final _$checkMacaroonPermissions = $grpc.ClientMethod<$1.CheckMacPermRequest, $1.CheckMacPermResponse>(
      '/lnrpc.Lightning/CheckMacaroonPermissions',
      ($1.CheckMacPermRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CheckMacPermResponse.fromBuffer(value));
  static final _$registerRPCMiddleware = $grpc.ClientMethod<$1.RPCMiddlewareResponse, $1.RPCMiddlewareRequest>(
      '/lnrpc.Lightning/RegisterRPCMiddleware',
      ($1.RPCMiddlewareResponse value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.RPCMiddlewareRequest.fromBuffer(value));
  static final _$sendCustomMessage = $grpc.ClientMethod<$1.SendCustomMessageRequest, $1.SendCustomMessageResponse>(
      '/lnrpc.Lightning/SendCustomMessage',
      ($1.SendCustomMessageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.SendCustomMessageResponse.fromBuffer(value));
  static final _$subscribeCustomMessages = $grpc.ClientMethod<$1.SubscribeCustomMessagesRequest, $1.CustomMessage>(
      '/lnrpc.Lightning/SubscribeCustomMessages',
      ($1.SubscribeCustomMessagesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.CustomMessage.fromBuffer(value));
  static final _$listAliases = $grpc.ClientMethod<$1.ListAliasesRequest, $1.ListAliasesResponse>(
      '/lnrpc.Lightning/ListAliases',
      ($1.ListAliasesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.ListAliasesResponse.fromBuffer(value));
  static final _$lookupHtlcResolution = $grpc.ClientMethod<$1.LookupHtlcResolutionRequest, $1.LookupHtlcResolutionResponse>(
      '/lnrpc.Lightning/LookupHtlcResolution',
      ($1.LookupHtlcResolutionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.LookupHtlcResolutionResponse.fromBuffer(value));

  LightningClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.WalletBalanceResponse> walletBalance($1.WalletBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$walletBalance, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChannelBalanceResponse> channelBalance($1.ChannelBalanceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$channelBalance, request, options: options);
  }

  $grpc.ResponseFuture<$1.TransactionDetails> getTransactions($1.GetTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getTransactions, request, options: options);
  }

  $grpc.ResponseFuture<$1.EstimateFeeResponse> estimateFee($1.EstimateFeeRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$estimateFee, request, options: options);
  }

  $grpc.ResponseFuture<$1.SendCoinsResponse> sendCoins($1.SendCoinsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendCoins, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListUnspentResponse> listUnspent($1.ListUnspentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listUnspent, request, options: options);
  }

  $grpc.ResponseStream<$1.Transaction> subscribeTransactions($1.GetTransactionsRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeTransactions, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.SendManyResponse> sendMany($1.SendManyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendMany, request, options: options);
  }

  $grpc.ResponseFuture<$1.NewAddressResponse> newAddress($1.NewAddressRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$newAddress, request, options: options);
  }

  $grpc.ResponseFuture<$1.SignMessageResponse> signMessage($1.SignMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signMessage, request, options: options);
  }

  $grpc.ResponseFuture<$1.VerifyMessageResponse> verifyMessage($1.VerifyMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyMessage, request, options: options);
  }

  $grpc.ResponseFuture<$1.ConnectPeerResponse> connectPeer($1.ConnectPeerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$connectPeer, request, options: options);
  }

  $grpc.ResponseFuture<$1.DisconnectPeerResponse> disconnectPeer($1.DisconnectPeerRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$disconnectPeer, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListPeersResponse> listPeers($1.ListPeersRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPeers, request, options: options);
  }

  $grpc.ResponseStream<$1.PeerEvent> subscribePeerEvents($1.PeerEventSubscription request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribePeerEvents, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.GetInfoResponse> getInfo($1.GetInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetDebugInfoResponse> getDebugInfo($1.GetDebugInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDebugInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.GetRecoveryInfoResponse> getRecoveryInfo($1.GetRecoveryInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecoveryInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.PendingChannelsResponse> pendingChannels($1.PendingChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pendingChannels, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListChannelsResponse> listChannels($1.ListChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listChannels, request, options: options);
  }

  $grpc.ResponseStream<$1.ChannelEventUpdate> subscribeChannelEvents($1.ChannelEventSubscription request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeChannelEvents, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.ClosedChannelsResponse> closedChannels($1.ClosedChannelsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$closedChannels, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChannelPoint> openChannelSync($1.OpenChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$openChannelSync, request, options: options);
  }

  $grpc.ResponseStream<$1.OpenStatusUpdate> openChannel($1.OpenChannelRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$openChannel, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.BatchOpenChannelResponse> batchOpenChannel($1.BatchOpenChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$batchOpenChannel, request, options: options);
  }

  $grpc.ResponseFuture<$1.FundingStateStepResp> fundingStateStep($1.FundingTransitionMsg request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fundingStateStep, request, options: options);
  }

  $grpc.ResponseStream<$1.ChannelAcceptRequest> channelAcceptor($async.Stream<$1.ChannelAcceptResponse> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$channelAcceptor, request, options: options);
  }

  $grpc.ResponseStream<$1.CloseStatusUpdate> closeChannel($1.CloseChannelRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$closeChannel, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.AbandonChannelResponse> abandonChannel($1.AbandonChannelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$abandonChannel, request, options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseStream<$1.SendResponse> sendPayment($async.Stream<$1.SendRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendPayment, request, options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseFuture<$1.SendResponse> sendPaymentSync($1.SendRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendPaymentSync, request, options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseStream<$1.SendResponse> sendToRoute($async.Stream<$1.SendToRouteRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$sendToRoute, request, options: options);
  }

  @$core.Deprecated('This method is deprecated')
  $grpc.ResponseFuture<$1.SendResponse> sendToRouteSync($1.SendToRouteRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendToRouteSync, request, options: options);
  }

  $grpc.ResponseFuture<$1.AddInvoiceResponse> addInvoice($1.Invoice request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addInvoice, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListInvoiceResponse> listInvoices($1.ListInvoiceRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listInvoices, request, options: options);
  }

  $grpc.ResponseFuture<$1.Invoice> lookupInvoice($1.PaymentHash request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupInvoice, request, options: options);
  }

  $grpc.ResponseStream<$1.Invoice> subscribeInvoices($1.InvoiceSubscription request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeInvoices, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.PayReq> decodePayReq($1.PayReqString request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$decodePayReq, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListPaymentsResponse> listPayments($1.ListPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPayments, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeletePaymentResponse> deletePayment($1.DeletePaymentRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deletePayment, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteAllPaymentsResponse> deleteAllPayments($1.DeleteAllPaymentsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAllPayments, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChannelGraph> describeGraph($1.ChannelGraphRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$describeGraph, request, options: options);
  }

  $grpc.ResponseFuture<$1.NodeMetricsResponse> getNodeMetrics($1.NodeMetricsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodeMetrics, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChannelEdge> getChanInfo($1.ChanInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getChanInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.NodeInfo> getNodeInfo($1.NodeInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNodeInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.QueryRoutesResponse> queryRoutes($1.QueryRoutesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$queryRoutes, request, options: options);
  }

  $grpc.ResponseFuture<$1.NetworkInfo> getNetworkInfo($1.NetworkInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getNetworkInfo, request, options: options);
  }

  $grpc.ResponseFuture<$1.StopResponse> stopDaemon($1.StopRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$stopDaemon, request, options: options);
  }

  $grpc.ResponseStream<$1.GraphTopologyUpdate> subscribeChannelGraph($1.GraphTopologySubscription request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeChannelGraph, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.DebugLevelResponse> debugLevel($1.DebugLevelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$debugLevel, request, options: options);
  }

  $grpc.ResponseFuture<$1.FeeReportResponse> feeReport($1.FeeReportRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$feeReport, request, options: options);
  }

  $grpc.ResponseFuture<$1.PolicyUpdateResponse> updateChannelPolicy($1.PolicyUpdateRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateChannelPolicy, request, options: options);
  }

  $grpc.ResponseFuture<$1.ForwardingHistoryResponse> forwardingHistory($1.ForwardingHistoryRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$forwardingHistory, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChannelBackup> exportChannelBackup($1.ExportChannelBackupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exportChannelBackup, request, options: options);
  }

  $grpc.ResponseFuture<$1.ChanBackupSnapshot> exportAllChannelBackups($1.ChanBackupExportRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$exportAllChannelBackups, request, options: options);
  }

  $grpc.ResponseFuture<$1.VerifyChanBackupResponse> verifyChanBackup($1.ChanBackupSnapshot request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyChanBackup, request, options: options);
  }

  $grpc.ResponseFuture<$1.RestoreBackupResponse> restoreChannelBackups($1.RestoreChanBackupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$restoreChannelBackups, request, options: options);
  }

  $grpc.ResponseStream<$1.ChanBackupSnapshot> subscribeChannelBackups($1.ChannelBackupSubscription request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeChannelBackups, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.BakeMacaroonResponse> bakeMacaroon($1.BakeMacaroonRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$bakeMacaroon, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListMacaroonIDsResponse> listMacaroonIDs($1.ListMacaroonIDsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMacaroonIDs, request, options: options);
  }

  $grpc.ResponseFuture<$1.DeleteMacaroonIDResponse> deleteMacaroonID($1.DeleteMacaroonIDRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteMacaroonID, request, options: options);
  }

  $grpc.ResponseFuture<$1.ListPermissionsResponse> listPermissions($1.ListPermissionsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listPermissions, request, options: options);
  }

  $grpc.ResponseFuture<$1.CheckMacPermResponse> checkMacaroonPermissions($1.CheckMacPermRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$checkMacaroonPermissions, request, options: options);
  }

  $grpc.ResponseStream<$1.RPCMiddlewareRequest> registerRPCMiddleware($async.Stream<$1.RPCMiddlewareResponse> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$registerRPCMiddleware, request, options: options);
  }

  $grpc.ResponseFuture<$1.SendCustomMessageResponse> sendCustomMessage($1.SendCustomMessageRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$sendCustomMessage, request, options: options);
  }

  $grpc.ResponseStream<$1.CustomMessage> subscribeCustomMessages($1.SubscribeCustomMessagesRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$subscribeCustomMessages, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$1.ListAliasesResponse> listAliases($1.ListAliasesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listAliases, request, options: options);
  }

  $grpc.ResponseFuture<$1.LookupHtlcResolutionResponse> lookupHtlcResolution($1.LookupHtlcResolutionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$lookupHtlcResolution, request, options: options);
  }
}

@$pb.GrpcServiceName('lnrpc.Lightning')
abstract class LightningServiceBase extends $grpc.Service {
  $core.String get $name => 'lnrpc.Lightning';

  LightningServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.WalletBalanceRequest, $1.WalletBalanceResponse>(
        'WalletBalance',
        walletBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.WalletBalanceRequest.fromBuffer(value),
        ($1.WalletBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChannelBalanceRequest, $1.ChannelBalanceResponse>(
        'ChannelBalance',
        channelBalance_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChannelBalanceRequest.fromBuffer(value),
        ($1.ChannelBalanceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetTransactionsRequest, $1.TransactionDetails>(
        'GetTransactions',
        getTransactions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetTransactionsRequest.fromBuffer(value),
        ($1.TransactionDetails value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.EstimateFeeRequest, $1.EstimateFeeResponse>(
        'EstimateFee',
        estimateFee_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.EstimateFeeRequest.fromBuffer(value),
        ($1.EstimateFeeResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendCoinsRequest, $1.SendCoinsResponse>(
        'SendCoins',
        sendCoins_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SendCoinsRequest.fromBuffer(value),
        ($1.SendCoinsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListUnspentRequest, $1.ListUnspentResponse>(
        'ListUnspent',
        listUnspent_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListUnspentRequest.fromBuffer(value),
        ($1.ListUnspentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetTransactionsRequest, $1.Transaction>(
        'SubscribeTransactions',
        subscribeTransactions_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.GetTransactionsRequest.fromBuffer(value),
        ($1.Transaction value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendManyRequest, $1.SendManyResponse>(
        'SendMany',
        sendMany_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SendManyRequest.fromBuffer(value),
        ($1.SendManyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.NewAddressRequest, $1.NewAddressResponse>(
        'NewAddress',
        newAddress_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NewAddressRequest.fromBuffer(value),
        ($1.NewAddressResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SignMessageRequest, $1.SignMessageResponse>(
        'SignMessage',
        signMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SignMessageRequest.fromBuffer(value),
        ($1.SignMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.VerifyMessageRequest, $1.VerifyMessageResponse>(
        'VerifyMessage',
        verifyMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.VerifyMessageRequest.fromBuffer(value),
        ($1.VerifyMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ConnectPeerRequest, $1.ConnectPeerResponse>(
        'ConnectPeer',
        connectPeer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ConnectPeerRequest.fromBuffer(value),
        ($1.ConnectPeerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DisconnectPeerRequest, $1.DisconnectPeerResponse>(
        'DisconnectPeer',
        disconnectPeer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DisconnectPeerRequest.fromBuffer(value),
        ($1.DisconnectPeerResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListPeersRequest, $1.ListPeersResponse>(
        'ListPeers',
        listPeers_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListPeersRequest.fromBuffer(value),
        ($1.ListPeersResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PeerEventSubscription, $1.PeerEvent>(
        'SubscribePeerEvents',
        subscribePeerEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.PeerEventSubscription.fromBuffer(value),
        ($1.PeerEvent value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetInfoRequest, $1.GetInfoResponse>(
        'GetInfo',
        getInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetInfoRequest.fromBuffer(value),
        ($1.GetInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetDebugInfoRequest, $1.GetDebugInfoResponse>(
        'GetDebugInfo',
        getDebugInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetDebugInfoRequest.fromBuffer(value),
        ($1.GetDebugInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GetRecoveryInfoRequest, $1.GetRecoveryInfoResponse>(
        'GetRecoveryInfo',
        getRecoveryInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.GetRecoveryInfoRequest.fromBuffer(value),
        ($1.GetRecoveryInfoResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PendingChannelsRequest, $1.PendingChannelsResponse>(
        'PendingChannels',
        pendingChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PendingChannelsRequest.fromBuffer(value),
        ($1.PendingChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListChannelsRequest, $1.ListChannelsResponse>(
        'ListChannels',
        listChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListChannelsRequest.fromBuffer(value),
        ($1.ListChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChannelEventSubscription, $1.ChannelEventUpdate>(
        'SubscribeChannelEvents',
        subscribeChannelEvents_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.ChannelEventSubscription.fromBuffer(value),
        ($1.ChannelEventUpdate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ClosedChannelsRequest, $1.ClosedChannelsResponse>(
        'ClosedChannels',
        closedChannels_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ClosedChannelsRequest.fromBuffer(value),
        ($1.ClosedChannelsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.OpenChannelRequest, $1.ChannelPoint>(
        'OpenChannelSync',
        openChannelSync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.OpenChannelRequest.fromBuffer(value),
        ($1.ChannelPoint value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.OpenChannelRequest, $1.OpenStatusUpdate>(
        'OpenChannel',
        openChannel_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.OpenChannelRequest.fromBuffer(value),
        ($1.OpenStatusUpdate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BatchOpenChannelRequest, $1.BatchOpenChannelResponse>(
        'BatchOpenChannel',
        batchOpenChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BatchOpenChannelRequest.fromBuffer(value),
        ($1.BatchOpenChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FundingTransitionMsg, $1.FundingStateStepResp>(
        'FundingStateStep',
        fundingStateStep_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FundingTransitionMsg.fromBuffer(value),
        ($1.FundingStateStepResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChannelAcceptResponse, $1.ChannelAcceptRequest>(
        'ChannelAcceptor',
        channelAcceptor,
        true,
        true,
        ($core.List<$core.int> value) => $1.ChannelAcceptResponse.fromBuffer(value),
        ($1.ChannelAcceptRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CloseChannelRequest, $1.CloseStatusUpdate>(
        'CloseChannel',
        closeChannel_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.CloseChannelRequest.fromBuffer(value),
        ($1.CloseStatusUpdate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.AbandonChannelRequest, $1.AbandonChannelResponse>(
        'AbandonChannel',
        abandonChannel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.AbandonChannelRequest.fromBuffer(value),
        ($1.AbandonChannelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendRequest, $1.SendResponse>(
        'SendPayment',
        sendPayment,
        true,
        true,
        ($core.List<$core.int> value) => $1.SendRequest.fromBuffer(value),
        ($1.SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendRequest, $1.SendResponse>(
        'SendPaymentSync',
        sendPaymentSync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SendRequest.fromBuffer(value),
        ($1.SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendToRouteRequest, $1.SendResponse>(
        'SendToRoute',
        sendToRoute,
        true,
        true,
        ($core.List<$core.int> value) => $1.SendToRouteRequest.fromBuffer(value),
        ($1.SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendToRouteRequest, $1.SendResponse>(
        'SendToRouteSync',
        sendToRouteSync_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SendToRouteRequest.fromBuffer(value),
        ($1.SendResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.Invoice, $1.AddInvoiceResponse>(
        'AddInvoice',
        addInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.Invoice.fromBuffer(value),
        ($1.AddInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListInvoiceRequest, $1.ListInvoiceResponse>(
        'ListInvoices',
        listInvoices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListInvoiceRequest.fromBuffer(value),
        ($1.ListInvoiceResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PaymentHash, $1.Invoice>(
        'LookupInvoice',
        lookupInvoice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PaymentHash.fromBuffer(value),
        ($1.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.InvoiceSubscription, $1.Invoice>(
        'SubscribeInvoices',
        subscribeInvoices_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.InvoiceSubscription.fromBuffer(value),
        ($1.Invoice value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PayReqString, $1.PayReq>(
        'DecodePayReq',
        decodePayReq_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PayReqString.fromBuffer(value),
        ($1.PayReq value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListPaymentsRequest, $1.ListPaymentsResponse>(
        'ListPayments',
        listPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListPaymentsRequest.fromBuffer(value),
        ($1.ListPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeletePaymentRequest, $1.DeletePaymentResponse>(
        'DeletePayment',
        deletePayment_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DeletePaymentRequest.fromBuffer(value),
        ($1.DeletePaymentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteAllPaymentsRequest, $1.DeleteAllPaymentsResponse>(
        'DeleteAllPayments',
        deleteAllPayments_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DeleteAllPaymentsRequest.fromBuffer(value),
        ($1.DeleteAllPaymentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChannelGraphRequest, $1.ChannelGraph>(
        'DescribeGraph',
        describeGraph_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChannelGraphRequest.fromBuffer(value),
        ($1.ChannelGraph value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.NodeMetricsRequest, $1.NodeMetricsResponse>(
        'GetNodeMetrics',
        getNodeMetrics_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NodeMetricsRequest.fromBuffer(value),
        ($1.NodeMetricsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChanInfoRequest, $1.ChannelEdge>(
        'GetChanInfo',
        getChanInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChanInfoRequest.fromBuffer(value),
        ($1.ChannelEdge value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.NodeInfoRequest, $1.NodeInfo>(
        'GetNodeInfo',
        getNodeInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NodeInfoRequest.fromBuffer(value),
        ($1.NodeInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.QueryRoutesRequest, $1.QueryRoutesResponse>(
        'QueryRoutes',
        queryRoutes_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.QueryRoutesRequest.fromBuffer(value),
        ($1.QueryRoutesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.NetworkInfoRequest, $1.NetworkInfo>(
        'GetNetworkInfo',
        getNetworkInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.NetworkInfoRequest.fromBuffer(value),
        ($1.NetworkInfo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.StopRequest, $1.StopResponse>(
        'StopDaemon',
        stopDaemon_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.StopRequest.fromBuffer(value),
        ($1.StopResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.GraphTopologySubscription, $1.GraphTopologyUpdate>(
        'SubscribeChannelGraph',
        subscribeChannelGraph_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.GraphTopologySubscription.fromBuffer(value),
        ($1.GraphTopologyUpdate value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DebugLevelRequest, $1.DebugLevelResponse>(
        'DebugLevel',
        debugLevel_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DebugLevelRequest.fromBuffer(value),
        ($1.DebugLevelResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.FeeReportRequest, $1.FeeReportResponse>(
        'FeeReport',
        feeReport_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.FeeReportRequest.fromBuffer(value),
        ($1.FeeReportResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.PolicyUpdateRequest, $1.PolicyUpdateResponse>(
        'UpdateChannelPolicy',
        updateChannelPolicy_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PolicyUpdateRequest.fromBuffer(value),
        ($1.PolicyUpdateResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ForwardingHistoryRequest, $1.ForwardingHistoryResponse>(
        'ForwardingHistory',
        forwardingHistory_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ForwardingHistoryRequest.fromBuffer(value),
        ($1.ForwardingHistoryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ExportChannelBackupRequest, $1.ChannelBackup>(
        'ExportChannelBackup',
        exportChannelBackup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ExportChannelBackupRequest.fromBuffer(value),
        ($1.ChannelBackup value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChanBackupExportRequest, $1.ChanBackupSnapshot>(
        'ExportAllChannelBackups',
        exportAllChannelBackups_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChanBackupExportRequest.fromBuffer(value),
        ($1.ChanBackupSnapshot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChanBackupSnapshot, $1.VerifyChanBackupResponse>(
        'VerifyChanBackup',
        verifyChanBackup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ChanBackupSnapshot.fromBuffer(value),
        ($1.VerifyChanBackupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RestoreChanBackupRequest, $1.RestoreBackupResponse>(
        'RestoreChannelBackups',
        restoreChannelBackups_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.RestoreChanBackupRequest.fromBuffer(value),
        ($1.RestoreBackupResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ChannelBackupSubscription, $1.ChanBackupSnapshot>(
        'SubscribeChannelBackups',
        subscribeChannelBackups_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.ChannelBackupSubscription.fromBuffer(value),
        ($1.ChanBackupSnapshot value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.BakeMacaroonRequest, $1.BakeMacaroonResponse>(
        'BakeMacaroon',
        bakeMacaroon_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.BakeMacaroonRequest.fromBuffer(value),
        ($1.BakeMacaroonResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListMacaroonIDsRequest, $1.ListMacaroonIDsResponse>(
        'ListMacaroonIDs',
        listMacaroonIDs_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListMacaroonIDsRequest.fromBuffer(value),
        ($1.ListMacaroonIDsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.DeleteMacaroonIDRequest, $1.DeleteMacaroonIDResponse>(
        'DeleteMacaroonID',
        deleteMacaroonID_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.DeleteMacaroonIDRequest.fromBuffer(value),
        ($1.DeleteMacaroonIDResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListPermissionsRequest, $1.ListPermissionsResponse>(
        'ListPermissions',
        listPermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListPermissionsRequest.fromBuffer(value),
        ($1.ListPermissionsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.CheckMacPermRequest, $1.CheckMacPermResponse>(
        'CheckMacaroonPermissions',
        checkMacaroonPermissions_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.CheckMacPermRequest.fromBuffer(value),
        ($1.CheckMacPermResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.RPCMiddlewareResponse, $1.RPCMiddlewareRequest>(
        'RegisterRPCMiddleware',
        registerRPCMiddleware,
        true,
        true,
        ($core.List<$core.int> value) => $1.RPCMiddlewareResponse.fromBuffer(value),
        ($1.RPCMiddlewareRequest value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SendCustomMessageRequest, $1.SendCustomMessageResponse>(
        'SendCustomMessage',
        sendCustomMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.SendCustomMessageRequest.fromBuffer(value),
        ($1.SendCustomMessageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.SubscribeCustomMessagesRequest, $1.CustomMessage>(
        'SubscribeCustomMessages',
        subscribeCustomMessages_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $1.SubscribeCustomMessagesRequest.fromBuffer(value),
        ($1.CustomMessage value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.ListAliasesRequest, $1.ListAliasesResponse>(
        'ListAliases',
        listAliases_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.ListAliasesRequest.fromBuffer(value),
        ($1.ListAliasesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.LookupHtlcResolutionRequest, $1.LookupHtlcResolutionResponse>(
        'LookupHtlcResolution',
        lookupHtlcResolution_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.LookupHtlcResolutionRequest.fromBuffer(value),
        ($1.LookupHtlcResolutionResponse value) => value.writeToBuffer()));
  }

  $async.Future<$1.WalletBalanceResponse> walletBalance_Pre($grpc.ServiceCall $call, $async.Future<$1.WalletBalanceRequest> $request) async {
    return walletBalance($call, await $request);
  }

  $async.Future<$1.ChannelBalanceResponse> channelBalance_Pre($grpc.ServiceCall $call, $async.Future<$1.ChannelBalanceRequest> $request) async {
    return channelBalance($call, await $request);
  }

  $async.Future<$1.TransactionDetails> getTransactions_Pre($grpc.ServiceCall $call, $async.Future<$1.GetTransactionsRequest> $request) async {
    return getTransactions($call, await $request);
  }

  $async.Future<$1.EstimateFeeResponse> estimateFee_Pre($grpc.ServiceCall $call, $async.Future<$1.EstimateFeeRequest> $request) async {
    return estimateFee($call, await $request);
  }

  $async.Future<$1.SendCoinsResponse> sendCoins_Pre($grpc.ServiceCall $call, $async.Future<$1.SendCoinsRequest> $request) async {
    return sendCoins($call, await $request);
  }

  $async.Future<$1.ListUnspentResponse> listUnspent_Pre($grpc.ServiceCall $call, $async.Future<$1.ListUnspentRequest> $request) async {
    return listUnspent($call, await $request);
  }

  $async.Stream<$1.Transaction> subscribeTransactions_Pre($grpc.ServiceCall $call, $async.Future<$1.GetTransactionsRequest> $request) async* {
    yield* subscribeTransactions($call, await $request);
  }

  $async.Future<$1.SendManyResponse> sendMany_Pre($grpc.ServiceCall $call, $async.Future<$1.SendManyRequest> $request) async {
    return sendMany($call, await $request);
  }

  $async.Future<$1.NewAddressResponse> newAddress_Pre($grpc.ServiceCall $call, $async.Future<$1.NewAddressRequest> $request) async {
    return newAddress($call, await $request);
  }

  $async.Future<$1.SignMessageResponse> signMessage_Pre($grpc.ServiceCall $call, $async.Future<$1.SignMessageRequest> $request) async {
    return signMessage($call, await $request);
  }

  $async.Future<$1.VerifyMessageResponse> verifyMessage_Pre($grpc.ServiceCall $call, $async.Future<$1.VerifyMessageRequest> $request) async {
    return verifyMessage($call, await $request);
  }

  $async.Future<$1.ConnectPeerResponse> connectPeer_Pre($grpc.ServiceCall $call, $async.Future<$1.ConnectPeerRequest> $request) async {
    return connectPeer($call, await $request);
  }

  $async.Future<$1.DisconnectPeerResponse> disconnectPeer_Pre($grpc.ServiceCall $call, $async.Future<$1.DisconnectPeerRequest> $request) async {
    return disconnectPeer($call, await $request);
  }

  $async.Future<$1.ListPeersResponse> listPeers_Pre($grpc.ServiceCall $call, $async.Future<$1.ListPeersRequest> $request) async {
    return listPeers($call, await $request);
  }

  $async.Stream<$1.PeerEvent> subscribePeerEvents_Pre($grpc.ServiceCall $call, $async.Future<$1.PeerEventSubscription> $request) async* {
    yield* subscribePeerEvents($call, await $request);
  }

  $async.Future<$1.GetInfoResponse> getInfo_Pre($grpc.ServiceCall $call, $async.Future<$1.GetInfoRequest> $request) async {
    return getInfo($call, await $request);
  }

  $async.Future<$1.GetDebugInfoResponse> getDebugInfo_Pre($grpc.ServiceCall $call, $async.Future<$1.GetDebugInfoRequest> $request) async {
    return getDebugInfo($call, await $request);
  }

  $async.Future<$1.GetRecoveryInfoResponse> getRecoveryInfo_Pre($grpc.ServiceCall $call, $async.Future<$1.GetRecoveryInfoRequest> $request) async {
    return getRecoveryInfo($call, await $request);
  }

  $async.Future<$1.PendingChannelsResponse> pendingChannels_Pre($grpc.ServiceCall $call, $async.Future<$1.PendingChannelsRequest> $request) async {
    return pendingChannels($call, await $request);
  }

  $async.Future<$1.ListChannelsResponse> listChannels_Pre($grpc.ServiceCall $call, $async.Future<$1.ListChannelsRequest> $request) async {
    return listChannels($call, await $request);
  }

  $async.Stream<$1.ChannelEventUpdate> subscribeChannelEvents_Pre($grpc.ServiceCall $call, $async.Future<$1.ChannelEventSubscription> $request) async* {
    yield* subscribeChannelEvents($call, await $request);
  }

  $async.Future<$1.ClosedChannelsResponse> closedChannels_Pre($grpc.ServiceCall $call, $async.Future<$1.ClosedChannelsRequest> $request) async {
    return closedChannels($call, await $request);
  }

  $async.Future<$1.ChannelPoint> openChannelSync_Pre($grpc.ServiceCall $call, $async.Future<$1.OpenChannelRequest> $request) async {
    return openChannelSync($call, await $request);
  }

  $async.Stream<$1.OpenStatusUpdate> openChannel_Pre($grpc.ServiceCall $call, $async.Future<$1.OpenChannelRequest> $request) async* {
    yield* openChannel($call, await $request);
  }

  $async.Future<$1.BatchOpenChannelResponse> batchOpenChannel_Pre($grpc.ServiceCall $call, $async.Future<$1.BatchOpenChannelRequest> $request) async {
    return batchOpenChannel($call, await $request);
  }

  $async.Future<$1.FundingStateStepResp> fundingStateStep_Pre($grpc.ServiceCall $call, $async.Future<$1.FundingTransitionMsg> $request) async {
    return fundingStateStep($call, await $request);
  }

  $async.Stream<$1.CloseStatusUpdate> closeChannel_Pre($grpc.ServiceCall $call, $async.Future<$1.CloseChannelRequest> $request) async* {
    yield* closeChannel($call, await $request);
  }

  $async.Future<$1.AbandonChannelResponse> abandonChannel_Pre($grpc.ServiceCall $call, $async.Future<$1.AbandonChannelRequest> $request) async {
    return abandonChannel($call, await $request);
  }

  $async.Future<$1.SendResponse> sendPaymentSync_Pre($grpc.ServiceCall $call, $async.Future<$1.SendRequest> $request) async {
    return sendPaymentSync($call, await $request);
  }

  $async.Future<$1.SendResponse> sendToRouteSync_Pre($grpc.ServiceCall $call, $async.Future<$1.SendToRouteRequest> $request) async {
    return sendToRouteSync($call, await $request);
  }

  $async.Future<$1.AddInvoiceResponse> addInvoice_Pre($grpc.ServiceCall $call, $async.Future<$1.Invoice> $request) async {
    return addInvoice($call, await $request);
  }

  $async.Future<$1.ListInvoiceResponse> listInvoices_Pre($grpc.ServiceCall $call, $async.Future<$1.ListInvoiceRequest> $request) async {
    return listInvoices($call, await $request);
  }

  $async.Future<$1.Invoice> lookupInvoice_Pre($grpc.ServiceCall $call, $async.Future<$1.PaymentHash> $request) async {
    return lookupInvoice($call, await $request);
  }

  $async.Stream<$1.Invoice> subscribeInvoices_Pre($grpc.ServiceCall $call, $async.Future<$1.InvoiceSubscription> $request) async* {
    yield* subscribeInvoices($call, await $request);
  }

  $async.Future<$1.PayReq> decodePayReq_Pre($grpc.ServiceCall $call, $async.Future<$1.PayReqString> $request) async {
    return decodePayReq($call, await $request);
  }

  $async.Future<$1.ListPaymentsResponse> listPayments_Pre($grpc.ServiceCall $call, $async.Future<$1.ListPaymentsRequest> $request) async {
    return listPayments($call, await $request);
  }

  $async.Future<$1.DeletePaymentResponse> deletePayment_Pre($grpc.ServiceCall $call, $async.Future<$1.DeletePaymentRequest> $request) async {
    return deletePayment($call, await $request);
  }

  $async.Future<$1.DeleteAllPaymentsResponse> deleteAllPayments_Pre($grpc.ServiceCall $call, $async.Future<$1.DeleteAllPaymentsRequest> $request) async {
    return deleteAllPayments($call, await $request);
  }

  $async.Future<$1.ChannelGraph> describeGraph_Pre($grpc.ServiceCall $call, $async.Future<$1.ChannelGraphRequest> $request) async {
    return describeGraph($call, await $request);
  }

  $async.Future<$1.NodeMetricsResponse> getNodeMetrics_Pre($grpc.ServiceCall $call, $async.Future<$1.NodeMetricsRequest> $request) async {
    return getNodeMetrics($call, await $request);
  }

  $async.Future<$1.ChannelEdge> getChanInfo_Pre($grpc.ServiceCall $call, $async.Future<$1.ChanInfoRequest> $request) async {
    return getChanInfo($call, await $request);
  }

  $async.Future<$1.NodeInfo> getNodeInfo_Pre($grpc.ServiceCall $call, $async.Future<$1.NodeInfoRequest> $request) async {
    return getNodeInfo($call, await $request);
  }

  $async.Future<$1.QueryRoutesResponse> queryRoutes_Pre($grpc.ServiceCall $call, $async.Future<$1.QueryRoutesRequest> $request) async {
    return queryRoutes($call, await $request);
  }

  $async.Future<$1.NetworkInfo> getNetworkInfo_Pre($grpc.ServiceCall $call, $async.Future<$1.NetworkInfoRequest> $request) async {
    return getNetworkInfo($call, await $request);
  }

  $async.Future<$1.StopResponse> stopDaemon_Pre($grpc.ServiceCall $call, $async.Future<$1.StopRequest> $request) async {
    return stopDaemon($call, await $request);
  }

  $async.Stream<$1.GraphTopologyUpdate> subscribeChannelGraph_Pre($grpc.ServiceCall $call, $async.Future<$1.GraphTopologySubscription> $request) async* {
    yield* subscribeChannelGraph($call, await $request);
  }

  $async.Future<$1.DebugLevelResponse> debugLevel_Pre($grpc.ServiceCall $call, $async.Future<$1.DebugLevelRequest> $request) async {
    return debugLevel($call, await $request);
  }

  $async.Future<$1.FeeReportResponse> feeReport_Pre($grpc.ServiceCall $call, $async.Future<$1.FeeReportRequest> $request) async {
    return feeReport($call, await $request);
  }

  $async.Future<$1.PolicyUpdateResponse> updateChannelPolicy_Pre($grpc.ServiceCall $call, $async.Future<$1.PolicyUpdateRequest> $request) async {
    return updateChannelPolicy($call, await $request);
  }

  $async.Future<$1.ForwardingHistoryResponse> forwardingHistory_Pre($grpc.ServiceCall $call, $async.Future<$1.ForwardingHistoryRequest> $request) async {
    return forwardingHistory($call, await $request);
  }

  $async.Future<$1.ChannelBackup> exportChannelBackup_Pre($grpc.ServiceCall $call, $async.Future<$1.ExportChannelBackupRequest> $request) async {
    return exportChannelBackup($call, await $request);
  }

  $async.Future<$1.ChanBackupSnapshot> exportAllChannelBackups_Pre($grpc.ServiceCall $call, $async.Future<$1.ChanBackupExportRequest> $request) async {
    return exportAllChannelBackups($call, await $request);
  }

  $async.Future<$1.VerifyChanBackupResponse> verifyChanBackup_Pre($grpc.ServiceCall $call, $async.Future<$1.ChanBackupSnapshot> $request) async {
    return verifyChanBackup($call, await $request);
  }

  $async.Future<$1.RestoreBackupResponse> restoreChannelBackups_Pre($grpc.ServiceCall $call, $async.Future<$1.RestoreChanBackupRequest> $request) async {
    return restoreChannelBackups($call, await $request);
  }

  $async.Stream<$1.ChanBackupSnapshot> subscribeChannelBackups_Pre($grpc.ServiceCall $call, $async.Future<$1.ChannelBackupSubscription> $request) async* {
    yield* subscribeChannelBackups($call, await $request);
  }

  $async.Future<$1.BakeMacaroonResponse> bakeMacaroon_Pre($grpc.ServiceCall $call, $async.Future<$1.BakeMacaroonRequest> $request) async {
    return bakeMacaroon($call, await $request);
  }

  $async.Future<$1.ListMacaroonIDsResponse> listMacaroonIDs_Pre($grpc.ServiceCall $call, $async.Future<$1.ListMacaroonIDsRequest> $request) async {
    return listMacaroonIDs($call, await $request);
  }

  $async.Future<$1.DeleteMacaroonIDResponse> deleteMacaroonID_Pre($grpc.ServiceCall $call, $async.Future<$1.DeleteMacaroonIDRequest> $request) async {
    return deleteMacaroonID($call, await $request);
  }

  $async.Future<$1.ListPermissionsResponse> listPermissions_Pre($grpc.ServiceCall $call, $async.Future<$1.ListPermissionsRequest> $request) async {
    return listPermissions($call, await $request);
  }

  $async.Future<$1.CheckMacPermResponse> checkMacaroonPermissions_Pre($grpc.ServiceCall $call, $async.Future<$1.CheckMacPermRequest> $request) async {
    return checkMacaroonPermissions($call, await $request);
  }

  $async.Future<$1.SendCustomMessageResponse> sendCustomMessage_Pre($grpc.ServiceCall $call, $async.Future<$1.SendCustomMessageRequest> $request) async {
    return sendCustomMessage($call, await $request);
  }

  $async.Stream<$1.CustomMessage> subscribeCustomMessages_Pre($grpc.ServiceCall $call, $async.Future<$1.SubscribeCustomMessagesRequest> $request) async* {
    yield* subscribeCustomMessages($call, await $request);
  }

  $async.Future<$1.ListAliasesResponse> listAliases_Pre($grpc.ServiceCall $call, $async.Future<$1.ListAliasesRequest> $request) async {
    return listAliases($call, await $request);
  }

  $async.Future<$1.LookupHtlcResolutionResponse> lookupHtlcResolution_Pre($grpc.ServiceCall $call, $async.Future<$1.LookupHtlcResolutionRequest> $request) async {
    return lookupHtlcResolution($call, await $request);
  }

  $async.Future<$1.WalletBalanceResponse> walletBalance($grpc.ServiceCall call, $1.WalletBalanceRequest request);
  $async.Future<$1.ChannelBalanceResponse> channelBalance($grpc.ServiceCall call, $1.ChannelBalanceRequest request);
  $async.Future<$1.TransactionDetails> getTransactions($grpc.ServiceCall call, $1.GetTransactionsRequest request);
  $async.Future<$1.EstimateFeeResponse> estimateFee($grpc.ServiceCall call, $1.EstimateFeeRequest request);
  $async.Future<$1.SendCoinsResponse> sendCoins($grpc.ServiceCall call, $1.SendCoinsRequest request);
  $async.Future<$1.ListUnspentResponse> listUnspent($grpc.ServiceCall call, $1.ListUnspentRequest request);
  $async.Stream<$1.Transaction> subscribeTransactions($grpc.ServiceCall call, $1.GetTransactionsRequest request);
  $async.Future<$1.SendManyResponse> sendMany($grpc.ServiceCall call, $1.SendManyRequest request);
  $async.Future<$1.NewAddressResponse> newAddress($grpc.ServiceCall call, $1.NewAddressRequest request);
  $async.Future<$1.SignMessageResponse> signMessage($grpc.ServiceCall call, $1.SignMessageRequest request);
  $async.Future<$1.VerifyMessageResponse> verifyMessage($grpc.ServiceCall call, $1.VerifyMessageRequest request);
  $async.Future<$1.ConnectPeerResponse> connectPeer($grpc.ServiceCall call, $1.ConnectPeerRequest request);
  $async.Future<$1.DisconnectPeerResponse> disconnectPeer($grpc.ServiceCall call, $1.DisconnectPeerRequest request);
  $async.Future<$1.ListPeersResponse> listPeers($grpc.ServiceCall call, $1.ListPeersRequest request);
  $async.Stream<$1.PeerEvent> subscribePeerEvents($grpc.ServiceCall call, $1.PeerEventSubscription request);
  $async.Future<$1.GetInfoResponse> getInfo($grpc.ServiceCall call, $1.GetInfoRequest request);
  $async.Future<$1.GetDebugInfoResponse> getDebugInfo($grpc.ServiceCall call, $1.GetDebugInfoRequest request);
  $async.Future<$1.GetRecoveryInfoResponse> getRecoveryInfo($grpc.ServiceCall call, $1.GetRecoveryInfoRequest request);
  $async.Future<$1.PendingChannelsResponse> pendingChannels($grpc.ServiceCall call, $1.PendingChannelsRequest request);
  $async.Future<$1.ListChannelsResponse> listChannels($grpc.ServiceCall call, $1.ListChannelsRequest request);
  $async.Stream<$1.ChannelEventUpdate> subscribeChannelEvents($grpc.ServiceCall call, $1.ChannelEventSubscription request);
  $async.Future<$1.ClosedChannelsResponse> closedChannels($grpc.ServiceCall call, $1.ClosedChannelsRequest request);
  $async.Future<$1.ChannelPoint> openChannelSync($grpc.ServiceCall call, $1.OpenChannelRequest request);
  $async.Stream<$1.OpenStatusUpdate> openChannel($grpc.ServiceCall call, $1.OpenChannelRequest request);
  $async.Future<$1.BatchOpenChannelResponse> batchOpenChannel($grpc.ServiceCall call, $1.BatchOpenChannelRequest request);
  $async.Future<$1.FundingStateStepResp> fundingStateStep($grpc.ServiceCall call, $1.FundingTransitionMsg request);
  $async.Stream<$1.ChannelAcceptRequest> channelAcceptor($grpc.ServiceCall call, $async.Stream<$1.ChannelAcceptResponse> request);
  $async.Stream<$1.CloseStatusUpdate> closeChannel($grpc.ServiceCall call, $1.CloseChannelRequest request);
  $async.Future<$1.AbandonChannelResponse> abandonChannel($grpc.ServiceCall call, $1.AbandonChannelRequest request);
  $async.Stream<$1.SendResponse> sendPayment($grpc.ServiceCall call, $async.Stream<$1.SendRequest> request);
  $async.Future<$1.SendResponse> sendPaymentSync($grpc.ServiceCall call, $1.SendRequest request);
  $async.Stream<$1.SendResponse> sendToRoute($grpc.ServiceCall call, $async.Stream<$1.SendToRouteRequest> request);
  $async.Future<$1.SendResponse> sendToRouteSync($grpc.ServiceCall call, $1.SendToRouteRequest request);
  $async.Future<$1.AddInvoiceResponse> addInvoice($grpc.ServiceCall call, $1.Invoice request);
  $async.Future<$1.ListInvoiceResponse> listInvoices($grpc.ServiceCall call, $1.ListInvoiceRequest request);
  $async.Future<$1.Invoice> lookupInvoice($grpc.ServiceCall call, $1.PaymentHash request);
  $async.Stream<$1.Invoice> subscribeInvoices($grpc.ServiceCall call, $1.InvoiceSubscription request);
  $async.Future<$1.PayReq> decodePayReq($grpc.ServiceCall call, $1.PayReqString request);
  $async.Future<$1.ListPaymentsResponse> listPayments($grpc.ServiceCall call, $1.ListPaymentsRequest request);
  $async.Future<$1.DeletePaymentResponse> deletePayment($grpc.ServiceCall call, $1.DeletePaymentRequest request);
  $async.Future<$1.DeleteAllPaymentsResponse> deleteAllPayments($grpc.ServiceCall call, $1.DeleteAllPaymentsRequest request);
  $async.Future<$1.ChannelGraph> describeGraph($grpc.ServiceCall call, $1.ChannelGraphRequest request);
  $async.Future<$1.NodeMetricsResponse> getNodeMetrics($grpc.ServiceCall call, $1.NodeMetricsRequest request);
  $async.Future<$1.ChannelEdge> getChanInfo($grpc.ServiceCall call, $1.ChanInfoRequest request);
  $async.Future<$1.NodeInfo> getNodeInfo($grpc.ServiceCall call, $1.NodeInfoRequest request);
  $async.Future<$1.QueryRoutesResponse> queryRoutes($grpc.ServiceCall call, $1.QueryRoutesRequest request);
  $async.Future<$1.NetworkInfo> getNetworkInfo($grpc.ServiceCall call, $1.NetworkInfoRequest request);
  $async.Future<$1.StopResponse> stopDaemon($grpc.ServiceCall call, $1.StopRequest request);
  $async.Stream<$1.GraphTopologyUpdate> subscribeChannelGraph($grpc.ServiceCall call, $1.GraphTopologySubscription request);
  $async.Future<$1.DebugLevelResponse> debugLevel($grpc.ServiceCall call, $1.DebugLevelRequest request);
  $async.Future<$1.FeeReportResponse> feeReport($grpc.ServiceCall call, $1.FeeReportRequest request);
  $async.Future<$1.PolicyUpdateResponse> updateChannelPolicy($grpc.ServiceCall call, $1.PolicyUpdateRequest request);
  $async.Future<$1.ForwardingHistoryResponse> forwardingHistory($grpc.ServiceCall call, $1.ForwardingHistoryRequest request);
  $async.Future<$1.ChannelBackup> exportChannelBackup($grpc.ServiceCall call, $1.ExportChannelBackupRequest request);
  $async.Future<$1.ChanBackupSnapshot> exportAllChannelBackups($grpc.ServiceCall call, $1.ChanBackupExportRequest request);
  $async.Future<$1.VerifyChanBackupResponse> verifyChanBackup($grpc.ServiceCall call, $1.ChanBackupSnapshot request);
  $async.Future<$1.RestoreBackupResponse> restoreChannelBackups($grpc.ServiceCall call, $1.RestoreChanBackupRequest request);
  $async.Stream<$1.ChanBackupSnapshot> subscribeChannelBackups($grpc.ServiceCall call, $1.ChannelBackupSubscription request);
  $async.Future<$1.BakeMacaroonResponse> bakeMacaroon($grpc.ServiceCall call, $1.BakeMacaroonRequest request);
  $async.Future<$1.ListMacaroonIDsResponse> listMacaroonIDs($grpc.ServiceCall call, $1.ListMacaroonIDsRequest request);
  $async.Future<$1.DeleteMacaroonIDResponse> deleteMacaroonID($grpc.ServiceCall call, $1.DeleteMacaroonIDRequest request);
  $async.Future<$1.ListPermissionsResponse> listPermissions($grpc.ServiceCall call, $1.ListPermissionsRequest request);
  $async.Future<$1.CheckMacPermResponse> checkMacaroonPermissions($grpc.ServiceCall call, $1.CheckMacPermRequest request);
  $async.Stream<$1.RPCMiddlewareRequest> registerRPCMiddleware($grpc.ServiceCall call, $async.Stream<$1.RPCMiddlewareResponse> request);
  $async.Future<$1.SendCustomMessageResponse> sendCustomMessage($grpc.ServiceCall call, $1.SendCustomMessageRequest request);
  $async.Stream<$1.CustomMessage> subscribeCustomMessages($grpc.ServiceCall call, $1.SubscribeCustomMessagesRequest request);
  $async.Future<$1.ListAliasesResponse> listAliases($grpc.ServiceCall call, $1.ListAliasesRequest request);
  $async.Future<$1.LookupHtlcResolutionResponse> lookupHtlcResolution($grpc.ServiceCall call, $1.LookupHtlcResolutionRequest request);
}
