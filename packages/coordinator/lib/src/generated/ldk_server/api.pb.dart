//
//  Generated code. Do not modify.
//  source: api.proto
//
// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'types.pb.dart' as $2;
import 'types.pbenum.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Retrieve the latest node info like `node_id`, `current_best_block` etc.
/// See more:
/// - https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.node_id
/// - https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.status
class GetNodeInfoRequest extends $pb.GeneratedMessage {
  factory GetNodeInfoRequest() => create();
  GetNodeInfoRequest._() : super();
  factory GetNodeInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNodeInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNodeInfoRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNodeInfoRequest clone() => GetNodeInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNodeInfoRequest copyWith(void Function(GetNodeInfoRequest) updates) => super.copyWith((message) => updates(message as GetNodeInfoRequest)) as GetNodeInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNodeInfoRequest create() => GetNodeInfoRequest._();
  GetNodeInfoRequest createEmptyInstance() => create();
  static $pb.PbList<GetNodeInfoRequest> createRepeated() => $pb.PbList<GetNodeInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static GetNodeInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNodeInfoRequest>(create);
  static GetNodeInfoRequest? _defaultInstance;
}

/// The response for the `GetNodeInfo` RPC. On failure, a gRPC error status is returned.
class GetNodeInfoResponse extends $pb.GeneratedMessage {
  factory GetNodeInfoResponse({
    $core.String? nodeId,
    $2.BestBlock? currentBestBlock,
    $fixnum.Int64? latestLightningWalletSyncTimestamp,
    $fixnum.Int64? latestOnchainWalletSyncTimestamp,
    $fixnum.Int64? latestFeeRateCacheUpdateTimestamp,
    $fixnum.Int64? latestRgsSnapshotTimestamp,
    $fixnum.Int64? latestNodeAnnouncementBroadcastTimestamp,
    $core.Iterable<$core.String>? listeningAddresses,
    $core.Iterable<$core.String>? announcementAddresses,
    $core.String? nodeAlias,
    $core.Iterable<$core.String>? nodeUris,
    $2.Network? network,
    $pb.PbMap<$core.int, $2.Feature>? features,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (currentBestBlock != null) {
      $result.currentBestBlock = currentBestBlock;
    }
    if (latestLightningWalletSyncTimestamp != null) {
      $result.latestLightningWalletSyncTimestamp = latestLightningWalletSyncTimestamp;
    }
    if (latestOnchainWalletSyncTimestamp != null) {
      $result.latestOnchainWalletSyncTimestamp = latestOnchainWalletSyncTimestamp;
    }
    if (latestFeeRateCacheUpdateTimestamp != null) {
      $result.latestFeeRateCacheUpdateTimestamp = latestFeeRateCacheUpdateTimestamp;
    }
    if (latestRgsSnapshotTimestamp != null) {
      $result.latestRgsSnapshotTimestamp = latestRgsSnapshotTimestamp;
    }
    if (latestNodeAnnouncementBroadcastTimestamp != null) {
      $result.latestNodeAnnouncementBroadcastTimestamp = latestNodeAnnouncementBroadcastTimestamp;
    }
    if (listeningAddresses != null) {
      $result.listeningAddresses.addAll(listeningAddresses);
    }
    if (announcementAddresses != null) {
      $result.announcementAddresses.addAll(announcementAddresses);
    }
    if (nodeAlias != null) {
      $result.nodeAlias = nodeAlias;
    }
    if (nodeUris != null) {
      $result.nodeUris.addAll(nodeUris);
    }
    if (network != null) {
      $result.network = network;
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    return $result;
  }
  GetNodeInfoResponse._() : super();
  factory GetNodeInfoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetNodeInfoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetNodeInfoResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..aOM<$2.BestBlock>(3, _omitFieldNames ? '' : 'currentBestBlock', subBuilder: $2.BestBlock.create)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'latestLightningWalletSyncTimestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'latestOnchainWalletSyncTimestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'latestFeeRateCacheUpdateTimestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'latestRgsSnapshotTimestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'latestNodeAnnouncementBroadcastTimestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pPS(9, _omitFieldNames ? '' : 'listeningAddresses')
    ..pPS(10, _omitFieldNames ? '' : 'announcementAddresses')
    ..aOS(11, _omitFieldNames ? '' : 'nodeAlias')
    ..pPS(12, _omitFieldNames ? '' : 'nodeUris')
    ..e<$2.Network>(13, _omitFieldNames ? '' : 'network', $pb.PbFieldType.OE, defaultOrMaker: $2.Network.BITCOIN, valueOf: $2.Network.valueOf, enumValues: $2.Network.values)
    ..m<$core.int, $2.Feature>(14, _omitFieldNames ? '' : 'features', entryClassName: 'GetNodeInfoResponse.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: $2.Feature.create, valueDefaultOrMaker: $2.Feature.getDefault, packageName: const $pb.PackageName('api'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetNodeInfoResponse clone() => GetNodeInfoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetNodeInfoResponse copyWith(void Function(GetNodeInfoResponse) updates) => super.copyWith((message) => updates(message as GetNodeInfoResponse)) as GetNodeInfoResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetNodeInfoResponse create() => GetNodeInfoResponse._();
  GetNodeInfoResponse createEmptyInstance() => create();
  static $pb.PbList<GetNodeInfoResponse> createRepeated() => $pb.PbList<GetNodeInfoResponse>();
  @$core.pragma('dart2js:noInline')
  static GetNodeInfoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetNodeInfoResponse>(create);
  static GetNodeInfoResponse? _defaultInstance;

  /// The hex-encoded `node-id` or public key for our own lightning node.
  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);

  ///  The best block to which our Lightning wallet is currently synced.
  ///
  ///  Should be always set, will never be `None`.
  @$pb.TagNumber(3)
  $2.BestBlock get currentBestBlock => $_getN(1);
  @$pb.TagNumber(3)
  set currentBestBlock($2.BestBlock v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentBestBlock() => $_has(1);
  @$pb.TagNumber(3)
  void clearCurrentBestBlock() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.BestBlock ensureCurrentBestBlock() => $_ensure(1);

  ///  The timestamp, in seconds since start of the UNIX epoch, when we last successfully synced our Lightning wallet to
  ///  the chain tip.
  ///
  ///  Will be `None` if the wallet hasn't been synced yet.
  @$pb.TagNumber(4)
  $fixnum.Int64 get latestLightningWalletSyncTimestamp => $_getI64(2);
  @$pb.TagNumber(4)
  set latestLightningWalletSyncTimestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasLatestLightningWalletSyncTimestamp() => $_has(2);
  @$pb.TagNumber(4)
  void clearLatestLightningWalletSyncTimestamp() => $_clearField(4);

  ///  The timestamp, in seconds since start of the UNIX epoch, when we last successfully synced our on-chain
  ///  wallet to the chain tip.
  ///
  ///  Will be `None` if the wallet hasn’t been synced since the node was initialized.
  @$pb.TagNumber(5)
  $fixnum.Int64 get latestOnchainWalletSyncTimestamp => $_getI64(3);
  @$pb.TagNumber(5)
  set latestOnchainWalletSyncTimestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasLatestOnchainWalletSyncTimestamp() => $_has(3);
  @$pb.TagNumber(5)
  void clearLatestOnchainWalletSyncTimestamp() => $_clearField(5);

  ///  The timestamp, in seconds since start of the UNIX epoch, when we last successfully update our fee rate cache.
  ///
  ///  Will be `None` if the cache hasn’t been updated since the node was initialized.
  @$pb.TagNumber(6)
  $fixnum.Int64 get latestFeeRateCacheUpdateTimestamp => $_getI64(4);
  @$pb.TagNumber(6)
  set latestFeeRateCacheUpdateTimestamp($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(6)
  $core.bool hasLatestFeeRateCacheUpdateTimestamp() => $_has(4);
  @$pb.TagNumber(6)
  void clearLatestFeeRateCacheUpdateTimestamp() => $_clearField(6);

  ///  The timestamp, in seconds since start of the UNIX epoch, when the last rapid gossip sync (RGS) snapshot we
  ///  successfully applied was generated.
  ///
  ///  Will be `None` if RGS isn’t configured or the snapshot hasn’t been updated since the node was initialized.
  @$pb.TagNumber(7)
  $fixnum.Int64 get latestRgsSnapshotTimestamp => $_getI64(5);
  @$pb.TagNumber(7)
  set latestRgsSnapshotTimestamp($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasLatestRgsSnapshotTimestamp() => $_has(5);
  @$pb.TagNumber(7)
  void clearLatestRgsSnapshotTimestamp() => $_clearField(7);

  ///  The timestamp, in seconds since start of the UNIX epoch, when we last broadcasted a node announcement.
  ///
  ///  Will be `None` if we have no public channels or we haven’t broadcasted since the node was initialized.
  @$pb.TagNumber(8)
  $fixnum.Int64 get latestNodeAnnouncementBroadcastTimestamp => $_getI64(6);
  @$pb.TagNumber(8)
  set latestNodeAnnouncementBroadcastTimestamp($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasLatestNodeAnnouncementBroadcastTimestamp() => $_has(6);
  @$pb.TagNumber(8)
  void clearLatestNodeAnnouncementBroadcastTimestamp() => $_clearField(8);

  ///  The addresses the node is currently listening on for incoming connections.
  ///
  ///  Will be empty if the node is not listening on any addresses.
  @$pb.TagNumber(9)
  $pb.PbList<$core.String> get listeningAddresses => $_getList(7);

  ///  The addresses the node announces to the network.
  ///
  ///  Will be empty if no announcement addresses are configured.
  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get announcementAddresses => $_getList(8);

  ///  The node alias, if configured.
  ///
  ///  Will be `None` if no alias is configured.
  @$pb.TagNumber(11)
  $core.String get nodeAlias => $_getSZ(9);
  @$pb.TagNumber(11)
  set nodeAlias($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(11)
  $core.bool hasNodeAlias() => $_has(9);
  @$pb.TagNumber(11)
  void clearNodeAlias() => $_clearField(11);

  ///  The node URIs that can be used to connect to this node, in the format `node_id@address`.
  ///
  ///  These are constructed from the announcement addresses and the node's public key.
  ///  Will be empty if no announcement addresses are configured.
  @$pb.TagNumber(12)
  $pb.PbList<$core.String> get nodeUris => $_getList(10);

  /// The Bitcoin network the node is running on (e.g., "bitcoin", "testnet", "signet", "regtest").
  @$pb.TagNumber(13)
  $2.Network get network => $_getN(11);
  @$pb.TagNumber(13)
  set network($2.Network v) { $_setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasNetwork() => $_has(11);
  @$pb.TagNumber(13)
  void clearNetwork() => $_clearField(13);

  /// Features advertised by this node, keyed by the signaled BOLT feature bit.
  @$pb.TagNumber(14)
  $pb.PbMap<$core.int, $2.Feature> get features => $_getMap(12);
}

/// Retrieve a new on-chain funding address.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.OnchainPayment.html#method.new_address
class OnchainReceiveRequest extends $pb.GeneratedMessage {
  factory OnchainReceiveRequest() => create();
  OnchainReceiveRequest._() : super();
  factory OnchainReceiveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OnchainReceiveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OnchainReceiveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OnchainReceiveRequest clone() => OnchainReceiveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OnchainReceiveRequest copyWith(void Function(OnchainReceiveRequest) updates) => super.copyWith((message) => updates(message as OnchainReceiveRequest)) as OnchainReceiveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OnchainReceiveRequest create() => OnchainReceiveRequest._();
  OnchainReceiveRequest createEmptyInstance() => create();
  static $pb.PbList<OnchainReceiveRequest> createRepeated() => $pb.PbList<OnchainReceiveRequest>();
  @$core.pragma('dart2js:noInline')
  static OnchainReceiveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OnchainReceiveRequest>(create);
  static OnchainReceiveRequest? _defaultInstance;
}

/// The response for the `OnchainReceive` RPC. On failure, a gRPC error status is returned.
class OnchainReceiveResponse extends $pb.GeneratedMessage {
  factory OnchainReceiveResponse({
    $core.String? address,
  }) {
    final $result = create();
    if (address != null) {
      $result.address = address;
    }
    return $result;
  }
  OnchainReceiveResponse._() : super();
  factory OnchainReceiveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OnchainReceiveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OnchainReceiveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OnchainReceiveResponse clone() => OnchainReceiveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OnchainReceiveResponse copyWith(void Function(OnchainReceiveResponse) updates) => super.copyWith((message) => updates(message as OnchainReceiveResponse)) as OnchainReceiveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OnchainReceiveResponse create() => OnchainReceiveResponse._();
  OnchainReceiveResponse createEmptyInstance() => create();
  static $pb.PbList<OnchainReceiveResponse> createRepeated() => $pb.PbList<OnchainReceiveResponse>();
  @$core.pragma('dart2js:noInline')
  static OnchainReceiveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OnchainReceiveResponse>(create);
  static OnchainReceiveResponse? _defaultInstance;

  /// A Bitcoin on-chain address.
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);
}

enum OnchainSendRequest_Amount {
  amountSats, 
  allFunds, 
  notSet
}

/// Send an on-chain payment to the given address.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.OnchainPayment.html#method.send_to_address
class OnchainSendRequest extends $pb.GeneratedMessage {
  factory OnchainSendRequest({
    $core.String? address,
    $fixnum.Int64? amountSats,
    AllFunds? allFunds,
    $fixnum.Int64? feeRateSatPerVb,
  }) {
    final $result = create();
    if (address != null) {
      $result.address = address;
    }
    if (amountSats != null) {
      $result.amountSats = amountSats;
    }
    if (allFunds != null) {
      $result.allFunds = allFunds;
    }
    if (feeRateSatPerVb != null) {
      $result.feeRateSatPerVb = feeRateSatPerVb;
    }
    return $result;
  }
  OnchainSendRequest._() : super();
  factory OnchainSendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OnchainSendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OnchainSendRequest_Amount> _OnchainSendRequest_AmountByTag = {
    2 : OnchainSendRequest_Amount.amountSats,
    3 : OnchainSendRequest_Amount.allFunds,
    0 : OnchainSendRequest_Amount.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OnchainSendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<AllFunds>(3, _omitFieldNames ? '' : 'allFunds', subBuilder: AllFunds.create)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'feeRateSatPerVb', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OnchainSendRequest clone() => OnchainSendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OnchainSendRequest copyWith(void Function(OnchainSendRequest) updates) => super.copyWith((message) => updates(message as OnchainSendRequest)) as OnchainSendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OnchainSendRequest create() => OnchainSendRequest._();
  OnchainSendRequest createEmptyInstance() => create();
  static $pb.PbList<OnchainSendRequest> createRepeated() => $pb.PbList<OnchainSendRequest>();
  @$core.pragma('dart2js:noInline')
  static OnchainSendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OnchainSendRequest>(create);
  static OnchainSendRequest? _defaultInstance;

  OnchainSendRequest_Amount whichAmount() => _OnchainSendRequest_AmountByTag[$_whichOneof(0)]!;
  void clearAmount() => $_clearField($_whichOneof(0));

  /// The address to send coins to.
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);

  /// Send the given amount of satoshis while retaining any required Anchor channel reserves.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountSats => $_getI64(1);
  @$pb.TagNumber(2)
  set amountSats($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountSats() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountSats() => $_clearField(2);

  /// Send all available on-chain funds, minus fees and any required Anchor channel reserves.
  @$pb.TagNumber(3)
  AllFunds get allFunds => $_getN(2);
  @$pb.TagNumber(3)
  set allFunds(AllFunds v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAllFunds() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllFunds() => $_clearField(3);
  @$pb.TagNumber(3)
  AllFunds ensureAllFunds() => $_ensure(2);

  /// If `fee_rate_sat_per_vb` is set it will be used on the resulting transaction. Otherwise we'll retrieve
  /// a reasonable estimate from BitcoinD.
  @$pb.TagNumber(4)
  $fixnum.Int64 get feeRateSatPerVb => $_getI64(3);
  @$pb.TagNumber(4)
  set feeRateSatPerVb($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFeeRateSatPerVb() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeeRateSatPerVb() => $_clearField(4);
}

/// The response for the `OnchainSend` RPC. On failure, a gRPC error status is returned.
class OnchainSendResponse extends $pb.GeneratedMessage {
  factory OnchainSendResponse({
    $core.String? txid,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    return $result;
  }
  OnchainSendResponse._() : super();
  factory OnchainSendResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OnchainSendResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OnchainSendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'txid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OnchainSendResponse clone() => OnchainSendResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OnchainSendResponse copyWith(void Function(OnchainSendResponse) updates) => super.copyWith((message) => updates(message as OnchainSendResponse)) as OnchainSendResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OnchainSendResponse create() => OnchainSendResponse._();
  OnchainSendResponse createEmptyInstance() => create();
  static $pb.PbList<OnchainSendResponse> createRepeated() => $pb.PbList<OnchainSendResponse>();
  @$core.pragma('dart2js:noInline')
  static OnchainSendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OnchainSendResponse>(create);
  static OnchainSendResponse? _defaultInstance;

  /// The transaction ID of the broadcasted transaction.
  @$pb.TagNumber(1)
  $core.String get txid => $_getSZ(0);
  @$pb.TagNumber(1)
  set txid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);
}

/// Return a BOLT11 payable invoice that can be used to request and receive a payment
/// for the given amount, if specified.
/// The inbound payment will be automatically claimed upon arrival.
/// See more:
/// - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.receive
/// - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.receive_variable_amount
class Bolt11ReceiveRequest extends $pb.GeneratedMessage {
  factory Bolt11ReceiveRequest({
    $fixnum.Int64? amountMsat,
    $2.Bolt11InvoiceDescription? description,
    $core.int? expirySecs,
  }) {
    final $result = create();
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (description != null) {
      $result.description = description;
    }
    if (expirySecs != null) {
      $result.expirySecs = expirySecs;
    }
    return $result;
  }
  Bolt11ReceiveRequest._() : super();
  factory Bolt11ReceiveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Bolt11InvoiceDescription>(2, _omitFieldNames ? '' : 'description', subBuilder: $2.Bolt11InvoiceDescription.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expirySecs', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveRequest clone() => Bolt11ReceiveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveRequest copyWith(void Function(Bolt11ReceiveRequest) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveRequest)) as Bolt11ReceiveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveRequest create() => Bolt11ReceiveRequest._();
  Bolt11ReceiveRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveRequest> createRepeated() => $pb.PbList<Bolt11ReceiveRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveRequest>(create);
  static Bolt11ReceiveRequest? _defaultInstance;

  /// The amount in millisatoshi to send. If unset, a "zero-amount" or variable-amount invoice is returned.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amountMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set amountMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmountMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountMsat() => $_clearField(1);

  /// An optional description to attach along with the invoice.
  /// Will be set in the description field of the encoded payment request.
  @$pb.TagNumber(2)
  $2.Bolt11InvoiceDescription get description => $_getN(1);
  @$pb.TagNumber(2)
  set description($2.Bolt11InvoiceDescription v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Bolt11InvoiceDescription ensureDescription() => $_ensure(1);

  /// Invoice expiry time in seconds.
  @$pb.TagNumber(3)
  $core.int get expirySecs => $_getIZ(2);
  @$pb.TagNumber(3)
  set expirySecs($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpirySecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpirySecs() => $_clearField(3);
}

/// The response for the `Bolt11Receive` RPC. On failure, a gRPC error status is returned.
class Bolt11ReceiveResponse extends $pb.GeneratedMessage {
  factory Bolt11ReceiveResponse({
    $core.String? invoice,
    $core.String? paymentHash,
    $core.String? paymentSecret,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (paymentSecret != null) {
      $result.paymentSecret = paymentSecret;
    }
    return $result;
  }
  Bolt11ReceiveResponse._() : super();
  factory Bolt11ReceiveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..aOS(2, _omitFieldNames ? '' : 'paymentHash')
    ..aOS(3, _omitFieldNames ? '' : 'paymentSecret')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveResponse clone() => Bolt11ReceiveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveResponse copyWith(void Function(Bolt11ReceiveResponse) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveResponse)) as Bolt11ReceiveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveResponse create() => Bolt11ReceiveResponse._();
  Bolt11ReceiveResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveResponse> createRepeated() => $pb.PbList<Bolt11ReceiveResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveResponse>(create);
  static Bolt11ReceiveResponse? _defaultInstance;

  /// An invoice for a payment within the Lightning Network.
  /// With the details of the invoice, the sender has all the data necessary to send a payment
  /// to the recipient.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);

  /// The hex-encoded 32-byte payment hash.
  @$pb.TagNumber(2)
  $core.String get paymentHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentHash() => $_clearField(2);

  /// The hex-encoded 32-byte payment secret.
  @$pb.TagNumber(3)
  $core.String get paymentSecret => $_getSZ(2);
  @$pb.TagNumber(3)
  set paymentSecret($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPaymentSecret() => $_has(2);
  @$pb.TagNumber(3)
  void clearPaymentSecret() => $_clearField(3);
}

/// Return a BOLT11 payable invoice for a given payment hash.
/// The inbound payment will NOT be automatically claimed upon arrival.
/// Instead, the payment will need to be manually claimed by calling `Bolt11ClaimForHash`
/// or manually failed by calling `Bolt11FailForHash`.
/// See more:
/// - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.receive_for_hash
/// - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.receive_variable_amount_for_hash
class Bolt11ReceiveForHashRequest extends $pb.GeneratedMessage {
  factory Bolt11ReceiveForHashRequest({
    $fixnum.Int64? amountMsat,
    $2.Bolt11InvoiceDescription? description,
    $core.int? expirySecs,
    $core.String? paymentHash,
  }) {
    final $result = create();
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (description != null) {
      $result.description = description;
    }
    if (expirySecs != null) {
      $result.expirySecs = expirySecs;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  Bolt11ReceiveForHashRequest._() : super();
  factory Bolt11ReceiveForHashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveForHashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveForHashRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Bolt11InvoiceDescription>(2, _omitFieldNames ? '' : 'description', subBuilder: $2.Bolt11InvoiceDescription.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expirySecs', $pb.PbFieldType.OU3)
    ..aOS(4, _omitFieldNames ? '' : 'paymentHash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveForHashRequest clone() => Bolt11ReceiveForHashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveForHashRequest copyWith(void Function(Bolt11ReceiveForHashRequest) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveForHashRequest)) as Bolt11ReceiveForHashRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveForHashRequest create() => Bolt11ReceiveForHashRequest._();
  Bolt11ReceiveForHashRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveForHashRequest> createRepeated() => $pb.PbList<Bolt11ReceiveForHashRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveForHashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveForHashRequest>(create);
  static Bolt11ReceiveForHashRequest? _defaultInstance;

  /// The amount in millisatoshi to receive. If unset, a "zero-amount" or variable-amount invoice is returned.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amountMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set amountMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmountMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountMsat() => $_clearField(1);

  /// An optional description to attach along with the invoice.
  /// Will be set in the description field of the encoded payment request.
  @$pb.TagNumber(2)
  $2.Bolt11InvoiceDescription get description => $_getN(1);
  @$pb.TagNumber(2)
  set description($2.Bolt11InvoiceDescription v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Bolt11InvoiceDescription ensureDescription() => $_ensure(1);

  /// Invoice expiry time in seconds.
  @$pb.TagNumber(3)
  $core.int get expirySecs => $_getIZ(2);
  @$pb.TagNumber(3)
  set expirySecs($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpirySecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpirySecs() => $_clearField(3);

  /// The hex-encoded 32-byte payment hash to use for the invoice.
  @$pb.TagNumber(4)
  $core.String get paymentHash => $_getSZ(3);
  @$pb.TagNumber(4)
  set paymentHash($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPaymentHash() => $_has(3);
  @$pb.TagNumber(4)
  void clearPaymentHash() => $_clearField(4);
}

/// The response for the `Bolt11ReceiveForHash` RPC. On failure, a gRPC error status is returned.
class Bolt11ReceiveForHashResponse extends $pb.GeneratedMessage {
  factory Bolt11ReceiveForHashResponse({
    $core.String? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  Bolt11ReceiveForHashResponse._() : super();
  factory Bolt11ReceiveForHashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveForHashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveForHashResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveForHashResponse clone() => Bolt11ReceiveForHashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveForHashResponse copyWith(void Function(Bolt11ReceiveForHashResponse) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveForHashResponse)) as Bolt11ReceiveForHashResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveForHashResponse create() => Bolt11ReceiveForHashResponse._();
  Bolt11ReceiveForHashResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveForHashResponse> createRepeated() => $pb.PbList<Bolt11ReceiveForHashResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveForHashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveForHashResponse>(create);
  static Bolt11ReceiveForHashResponse? _defaultInstance;

  /// An invoice for a payment within the Lightning Network.
  /// With the details of the invoice, the sender has all the data necessary to send a payment
  /// to the recipient.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
}

/// Manually claim a payment for a given payment hash with the corresponding preimage.
/// This should be used to claim payments created via `Bolt11ReceiveForHash`.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.claim_for_hash
class Bolt11ClaimForHashRequest extends $pb.GeneratedMessage {
  factory Bolt11ClaimForHashRequest({
    $core.String? paymentHash,
    $fixnum.Int64? claimableAmountMsat,
    $core.String? preimage,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (claimableAmountMsat != null) {
      $result.claimableAmountMsat = claimableAmountMsat;
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    return $result;
  }
  Bolt11ClaimForHashRequest._() : super();
  factory Bolt11ClaimForHashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ClaimForHashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ClaimForHashRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentHash')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'claimableAmountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'preimage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ClaimForHashRequest clone() => Bolt11ClaimForHashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ClaimForHashRequest copyWith(void Function(Bolt11ClaimForHashRequest) updates) => super.copyWith((message) => updates(message as Bolt11ClaimForHashRequest)) as Bolt11ClaimForHashRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ClaimForHashRequest create() => Bolt11ClaimForHashRequest._();
  Bolt11ClaimForHashRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11ClaimForHashRequest> createRepeated() => $pb.PbList<Bolt11ClaimForHashRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ClaimForHashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ClaimForHashRequest>(create);
  static Bolt11ClaimForHashRequest? _defaultInstance;

  /// The hex-encoded 32-byte payment hash.
  /// If provided, it will be used to verify that the preimage matches.
  @$pb.TagNumber(1)
  $core.String get paymentHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);

  /// The amount in millisatoshi that is claimable.
  /// If not provided, skips amount verification.
  @$pb.TagNumber(2)
  $fixnum.Int64 get claimableAmountMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set claimableAmountMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClaimableAmountMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearClaimableAmountMsat() => $_clearField(2);

  /// The hex-encoded 32-byte payment preimage.
  @$pb.TagNumber(3)
  $core.String get preimage => $_getSZ(2);
  @$pb.TagNumber(3)
  set preimage($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPreimage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPreimage() => $_clearField(3);
}

/// The response for the `Bolt11ClaimForHash` RPC. On failure, a gRPC error status is returned.
class Bolt11ClaimForHashResponse extends $pb.GeneratedMessage {
  factory Bolt11ClaimForHashResponse() => create();
  Bolt11ClaimForHashResponse._() : super();
  factory Bolt11ClaimForHashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ClaimForHashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ClaimForHashResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ClaimForHashResponse clone() => Bolt11ClaimForHashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ClaimForHashResponse copyWith(void Function(Bolt11ClaimForHashResponse) updates) => super.copyWith((message) => updates(message as Bolt11ClaimForHashResponse)) as Bolt11ClaimForHashResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ClaimForHashResponse create() => Bolt11ClaimForHashResponse._();
  Bolt11ClaimForHashResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11ClaimForHashResponse> createRepeated() => $pb.PbList<Bolt11ClaimForHashResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ClaimForHashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ClaimForHashResponse>(create);
  static Bolt11ClaimForHashResponse? _defaultInstance;
}

/// Manually fail a payment for a given payment hash.
/// This should be used to reject payments created via `Bolt11ReceiveForHash`.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.fail_for_hash
class Bolt11FailForHashRequest extends $pb.GeneratedMessage {
  factory Bolt11FailForHashRequest({
    $core.String? paymentHash,
  }) {
    final $result = create();
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    return $result;
  }
  Bolt11FailForHashRequest._() : super();
  factory Bolt11FailForHashRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11FailForHashRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11FailForHashRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentHash')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11FailForHashRequest clone() => Bolt11FailForHashRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11FailForHashRequest copyWith(void Function(Bolt11FailForHashRequest) updates) => super.copyWith((message) => updates(message as Bolt11FailForHashRequest)) as Bolt11FailForHashRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11FailForHashRequest create() => Bolt11FailForHashRequest._();
  Bolt11FailForHashRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11FailForHashRequest> createRepeated() => $pb.PbList<Bolt11FailForHashRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11FailForHashRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11FailForHashRequest>(create);
  static Bolt11FailForHashRequest? _defaultInstance;

  /// The hex-encoded 32-byte payment hash.
  @$pb.TagNumber(1)
  $core.String get paymentHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentHash($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentHash() => $_clearField(1);
}

/// The response for the `Bolt11FailForHash` RPC. On failure, a gRPC error status is returned.
class Bolt11FailForHashResponse extends $pb.GeneratedMessage {
  factory Bolt11FailForHashResponse() => create();
  Bolt11FailForHashResponse._() : super();
  factory Bolt11FailForHashResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11FailForHashResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11FailForHashResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11FailForHashResponse clone() => Bolt11FailForHashResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11FailForHashResponse copyWith(void Function(Bolt11FailForHashResponse) updates) => super.copyWith((message) => updates(message as Bolt11FailForHashResponse)) as Bolt11FailForHashResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11FailForHashResponse create() => Bolt11FailForHashResponse._();
  Bolt11FailForHashResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11FailForHashResponse> createRepeated() => $pb.PbList<Bolt11FailForHashResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11FailForHashResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11FailForHashResponse>(create);
  static Bolt11FailForHashResponse? _defaultInstance;
}

/// Return a BOLT11 payable invoice that can be used to request and receive a payment via an
/// LSPS2 just-in-time channel.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.receive_via_jit_channel
class Bolt11ReceiveViaJitChannelRequest extends $pb.GeneratedMessage {
  factory Bolt11ReceiveViaJitChannelRequest({
    $fixnum.Int64? amountMsat,
    $2.Bolt11InvoiceDescription? description,
    $core.int? expirySecs,
    $fixnum.Int64? maxTotalLspFeeLimitMsat,
  }) {
    final $result = create();
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (description != null) {
      $result.description = description;
    }
    if (expirySecs != null) {
      $result.expirySecs = expirySecs;
    }
    if (maxTotalLspFeeLimitMsat != null) {
      $result.maxTotalLspFeeLimitMsat = maxTotalLspFeeLimitMsat;
    }
    return $result;
  }
  Bolt11ReceiveViaJitChannelRequest._() : super();
  factory Bolt11ReceiveViaJitChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveViaJitChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveViaJitChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Bolt11InvoiceDescription>(2, _omitFieldNames ? '' : 'description', subBuilder: $2.Bolt11InvoiceDescription.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expirySecs', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'maxTotalLspFeeLimitMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveViaJitChannelRequest clone() => Bolt11ReceiveViaJitChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveViaJitChannelRequest copyWith(void Function(Bolt11ReceiveViaJitChannelRequest) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveViaJitChannelRequest)) as Bolt11ReceiveViaJitChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveViaJitChannelRequest create() => Bolt11ReceiveViaJitChannelRequest._();
  Bolt11ReceiveViaJitChannelRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveViaJitChannelRequest> createRepeated() => $pb.PbList<Bolt11ReceiveViaJitChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveViaJitChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveViaJitChannelRequest>(create);
  static Bolt11ReceiveViaJitChannelRequest? _defaultInstance;

  /// The amount in millisatoshi to request.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amountMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set amountMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmountMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountMsat() => $_clearField(1);

  /// An optional description to attach along with the invoice.
  /// Will be set in the description field of the encoded payment request.
  @$pb.TagNumber(2)
  $2.Bolt11InvoiceDescription get description => $_getN(1);
  @$pb.TagNumber(2)
  set description($2.Bolt11InvoiceDescription v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.Bolt11InvoiceDescription ensureDescription() => $_ensure(1);

  /// Invoice expiry time in seconds.
  @$pb.TagNumber(3)
  $core.int get expirySecs => $_getIZ(2);
  @$pb.TagNumber(3)
  set expirySecs($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpirySecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpirySecs() => $_clearField(3);

  /// Optional upper bound for the total fee an LSP may deduct when opening the JIT channel.
  @$pb.TagNumber(4)
  $fixnum.Int64 get maxTotalLspFeeLimitMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set maxTotalLspFeeLimitMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMaxTotalLspFeeLimitMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxTotalLspFeeLimitMsat() => $_clearField(4);
}

/// The response for the `Bolt11ReceiveViaJitChannel` RPC. On failure, a gRPC error status is returned.
class Bolt11ReceiveViaJitChannelResponse extends $pb.GeneratedMessage {
  factory Bolt11ReceiveViaJitChannelResponse({
    $core.String? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  Bolt11ReceiveViaJitChannelResponse._() : super();
  factory Bolt11ReceiveViaJitChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveViaJitChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveViaJitChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveViaJitChannelResponse clone() => Bolt11ReceiveViaJitChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveViaJitChannelResponse copyWith(void Function(Bolt11ReceiveViaJitChannelResponse) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveViaJitChannelResponse)) as Bolt11ReceiveViaJitChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveViaJitChannelResponse create() => Bolt11ReceiveViaJitChannelResponse._();
  Bolt11ReceiveViaJitChannelResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveViaJitChannelResponse> createRepeated() => $pb.PbList<Bolt11ReceiveViaJitChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveViaJitChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveViaJitChannelResponse>(create);
  static Bolt11ReceiveViaJitChannelResponse? _defaultInstance;

  /// An invoice for a payment within the Lightning Network.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
}

/// Return a variable-amount BOLT11 invoice that can be used to receive a payment via an LSPS2
/// just-in-time channel.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.receive_variable_amount_via_jit_channel
class Bolt11ReceiveVariableAmountViaJitChannelRequest extends $pb.GeneratedMessage {
  factory Bolt11ReceiveVariableAmountViaJitChannelRequest({
    $2.Bolt11InvoiceDescription? description,
    $core.int? expirySecs,
    $fixnum.Int64? maxProportionalLspFeeLimitPpmMsat,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (expirySecs != null) {
      $result.expirySecs = expirySecs;
    }
    if (maxProportionalLspFeeLimitPpmMsat != null) {
      $result.maxProportionalLspFeeLimitPpmMsat = maxProportionalLspFeeLimitPpmMsat;
    }
    return $result;
  }
  Bolt11ReceiveVariableAmountViaJitChannelRequest._() : super();
  factory Bolt11ReceiveVariableAmountViaJitChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveVariableAmountViaJitChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveVariableAmountViaJitChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<$2.Bolt11InvoiceDescription>(1, _omitFieldNames ? '' : 'description', subBuilder: $2.Bolt11InvoiceDescription.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'expirySecs', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'maxProportionalLspFeeLimitPpmMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveVariableAmountViaJitChannelRequest clone() => Bolt11ReceiveVariableAmountViaJitChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveVariableAmountViaJitChannelRequest copyWith(void Function(Bolt11ReceiveVariableAmountViaJitChannelRequest) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveVariableAmountViaJitChannelRequest)) as Bolt11ReceiveVariableAmountViaJitChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveVariableAmountViaJitChannelRequest create() => Bolt11ReceiveVariableAmountViaJitChannelRequest._();
  Bolt11ReceiveVariableAmountViaJitChannelRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveVariableAmountViaJitChannelRequest> createRepeated() => $pb.PbList<Bolt11ReceiveVariableAmountViaJitChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveVariableAmountViaJitChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveVariableAmountViaJitChannelRequest>(create);
  static Bolt11ReceiveVariableAmountViaJitChannelRequest? _defaultInstance;

  /// An optional description to attach along with the invoice.
  /// Will be set in the description field of the encoded payment request.
  @$pb.TagNumber(1)
  $2.Bolt11InvoiceDescription get description => $_getN(0);
  @$pb.TagNumber(1)
  set description($2.Bolt11InvoiceDescription v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Bolt11InvoiceDescription ensureDescription() => $_ensure(0);

  /// Invoice expiry time in seconds.
  @$pb.TagNumber(2)
  $core.int get expirySecs => $_getIZ(1);
  @$pb.TagNumber(2)
  set expirySecs($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasExpirySecs() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpirySecs() => $_clearField(2);

  /// Optional upper bound for the proportional fee, in parts-per-million millisatoshis, that an
  /// LSP may deduct when opening the JIT channel.
  @$pb.TagNumber(3)
  $fixnum.Int64 get maxProportionalLspFeeLimitPpmMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set maxProportionalLspFeeLimitPpmMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMaxProportionalLspFeeLimitPpmMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearMaxProportionalLspFeeLimitPpmMsat() => $_clearField(3);
}

/// The response for the `Bolt11ReceiveVariableAmountViaJitChannel` RPC. On failure, a gRPC error status is returned.
class Bolt11ReceiveVariableAmountViaJitChannelResponse extends $pb.GeneratedMessage {
  factory Bolt11ReceiveVariableAmountViaJitChannelResponse({
    $core.String? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  Bolt11ReceiveVariableAmountViaJitChannelResponse._() : super();
  factory Bolt11ReceiveVariableAmountViaJitChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11ReceiveVariableAmountViaJitChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11ReceiveVariableAmountViaJitChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveVariableAmountViaJitChannelResponse clone() => Bolt11ReceiveVariableAmountViaJitChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11ReceiveVariableAmountViaJitChannelResponse copyWith(void Function(Bolt11ReceiveVariableAmountViaJitChannelResponse) updates) => super.copyWith((message) => updates(message as Bolt11ReceiveVariableAmountViaJitChannelResponse)) as Bolt11ReceiveVariableAmountViaJitChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveVariableAmountViaJitChannelResponse create() => Bolt11ReceiveVariableAmountViaJitChannelResponse._();
  Bolt11ReceiveVariableAmountViaJitChannelResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11ReceiveVariableAmountViaJitChannelResponse> createRepeated() => $pb.PbList<Bolt11ReceiveVariableAmountViaJitChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11ReceiveVariableAmountViaJitChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11ReceiveVariableAmountViaJitChannelResponse>(create);
  static Bolt11ReceiveVariableAmountViaJitChannelResponse? _defaultInstance;

  /// An invoice for a payment within the Lightning Network.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
}

/// Send a payment for a BOLT11 invoice.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.send
class Bolt11SendRequest extends $pb.GeneratedMessage {
  factory Bolt11SendRequest({
    $core.String? invoice,
    $fixnum.Int64? amountMsat,
    $2.RouteParametersConfig? routeParameters,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (routeParameters != null) {
      $result.routeParameters = routeParameters;
    }
    return $result;
  }
  Bolt11SendRequest._() : super();
  factory Bolt11SendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11SendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11SendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.RouteParametersConfig>(3, _omitFieldNames ? '' : 'routeParameters', subBuilder: $2.RouteParametersConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11SendRequest clone() => Bolt11SendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11SendRequest copyWith(void Function(Bolt11SendRequest) updates) => super.copyWith((message) => updates(message as Bolt11SendRequest)) as Bolt11SendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11SendRequest create() => Bolt11SendRequest._();
  Bolt11SendRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11SendRequest> createRepeated() => $pb.PbList<Bolt11SendRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11SendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11SendRequest>(create);
  static Bolt11SendRequest? _defaultInstance;

  /// An invoice for a payment within the Lightning Network.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);

  /// Set this field when paying a so-called "zero-amount" invoice, i.e., an invoice that leaves the
  /// amount paid to be determined by the user.
  /// This operation will fail if the amount specified is less than the value required by the given invoice.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMsat() => $_clearField(2);

  /// Configuration options for payment routing and pathfinding.
  @$pb.TagNumber(3)
  $2.RouteParametersConfig get routeParameters => $_getN(2);
  @$pb.TagNumber(3)
  set routeParameters($2.RouteParametersConfig v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRouteParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearRouteParameters() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.RouteParametersConfig ensureRouteParameters() => $_ensure(2);
}

/// The response for the `Bolt11Send` RPC. On failure, a gRPC error status is returned.
class Bolt11SendResponse extends $pb.GeneratedMessage {
  factory Bolt11SendResponse({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  Bolt11SendResponse._() : super();
  factory Bolt11SendResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11SendResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11SendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11SendResponse clone() => Bolt11SendResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11SendResponse copyWith(void Function(Bolt11SendResponse) updates) => super.copyWith((message) => updates(message as Bolt11SendResponse)) as Bolt11SendResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11SendResponse create() => Bolt11SendResponse._();
  Bolt11SendResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11SendResponse> createRepeated() => $pb.PbList<Bolt11SendResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11SendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11SendResponse>(create);
  static Bolt11SendResponse? _defaultInstance;

  /// An identifier used to uniquely identify a payment in hex-encoded form.
  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

/// Send part of the amount for a fixed-amount BOLT11 invoice.
/// Other nodes must send partial payments for the same invoice until the combined amount equals the invoice amount.
/// Without those payments, the receiver holds the incomplete MPP payment and eventually fails it.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt11Payment.html#method.send_using_amount_underpaying
class Bolt11SendUnderpayingRequest extends $pb.GeneratedMessage {
  factory Bolt11SendUnderpayingRequest({
    $core.String? invoice,
    $fixnum.Int64? amountMsat,
    $2.RouteParametersConfig? routeParameters,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (routeParameters != null) {
      $result.routeParameters = routeParameters;
    }
    return $result;
  }
  Bolt11SendUnderpayingRequest._() : super();
  factory Bolt11SendUnderpayingRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11SendUnderpayingRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11SendUnderpayingRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.RouteParametersConfig>(3, _omitFieldNames ? '' : 'routeParameters', subBuilder: $2.RouteParametersConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11SendUnderpayingRequest clone() => Bolt11SendUnderpayingRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11SendUnderpayingRequest copyWith(void Function(Bolt11SendUnderpayingRequest) updates) => super.copyWith((message) => updates(message as Bolt11SendUnderpayingRequest)) as Bolt11SendUnderpayingRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11SendUnderpayingRequest create() => Bolt11SendUnderpayingRequest._();
  Bolt11SendUnderpayingRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt11SendUnderpayingRequest> createRepeated() => $pb.PbList<Bolt11SendUnderpayingRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt11SendUnderpayingRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11SendUnderpayingRequest>(create);
  static Bolt11SendUnderpayingRequest? _defaultInstance;

  /// A fixed-amount BOLT11 invoice for a payment within the Lightning Network.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);

  /// Amount in millisatoshis from this payer. Must be less than the amount required by the invoice.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMsat() => $_clearField(2);

  /// Configuration options for payment routing and pathfinding.
  @$pb.TagNumber(3)
  $2.RouteParametersConfig get routeParameters => $_getN(2);
  @$pb.TagNumber(3)
  set routeParameters($2.RouteParametersConfig v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRouteParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearRouteParameters() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.RouteParametersConfig ensureRouteParameters() => $_ensure(2);
}

/// The response for the `Bolt11SendUnderpaying` RPC. On failure, a gRPC error status is returned.
class Bolt11SendUnderpayingResponse extends $pb.GeneratedMessage {
  factory Bolt11SendUnderpayingResponse({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  Bolt11SendUnderpayingResponse._() : super();
  factory Bolt11SendUnderpayingResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt11SendUnderpayingResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt11SendUnderpayingResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt11SendUnderpayingResponse clone() => Bolt11SendUnderpayingResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt11SendUnderpayingResponse copyWith(void Function(Bolt11SendUnderpayingResponse) updates) => super.copyWith((message) => updates(message as Bolt11SendUnderpayingResponse)) as Bolt11SendUnderpayingResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt11SendUnderpayingResponse create() => Bolt11SendUnderpayingResponse._();
  Bolt11SendUnderpayingResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt11SendUnderpayingResponse> createRepeated() => $pb.PbList<Bolt11SendUnderpayingResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt11SendUnderpayingResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt11SendUnderpayingResponse>(create);
  static Bolt11SendUnderpayingResponse? _defaultInstance;

  /// An identifier used to uniquely identify a payment in hex-encoded form.
  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

///  Returns a BOLT12 offer for the given amount, if specified.
///
///  See more:
///  - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt12Payment.html#method.receive
///  - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt12Payment.html#method.receive_variable_amount
class Bolt12ReceiveRequest extends $pb.GeneratedMessage {
  factory Bolt12ReceiveRequest({
    $core.String? description,
    $fixnum.Int64? amountMsat,
    $core.int? expirySecs,
    $fixnum.Int64? quantity,
  }) {
    final $result = create();
    if (description != null) {
      $result.description = description;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (expirySecs != null) {
      $result.expirySecs = expirySecs;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    return $result;
  }
  Bolt12ReceiveRequest._() : super();
  factory Bolt12ReceiveRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12ReceiveRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12ReceiveRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'expirySecs', $pb.PbFieldType.OU3)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12ReceiveRequest clone() => Bolt12ReceiveRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12ReceiveRequest copyWith(void Function(Bolt12ReceiveRequest) updates) => super.copyWith((message) => updates(message as Bolt12ReceiveRequest)) as Bolt12ReceiveRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12ReceiveRequest create() => Bolt12ReceiveRequest._();
  Bolt12ReceiveRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt12ReceiveRequest> createRepeated() => $pb.PbList<Bolt12ReceiveRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt12ReceiveRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12ReceiveRequest>(create);
  static Bolt12ReceiveRequest? _defaultInstance;

  /// An optional description to attach along with the offer.
  /// Will be set in the description field of the encoded offer.
  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);

  /// The amount in millisatoshi to send. If unset, a "zero-amount" or variable-amount offer is returned.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMsat() => $_clearField(2);

  /// Offer expiry time in seconds.
  @$pb.TagNumber(3)
  $core.int get expirySecs => $_getIZ(2);
  @$pb.TagNumber(3)
  set expirySecs($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasExpirySecs() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpirySecs() => $_clearField(3);

  /// If set, it represents the number of items requested, can only be set for fixed-amount offers.
  @$pb.TagNumber(4)
  $fixnum.Int64 get quantity => $_getI64(3);
  @$pb.TagNumber(4)
  set quantity($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasQuantity() => $_has(3);
  @$pb.TagNumber(4)
  void clearQuantity() => $_clearField(4);
}

/// The response for the `Bolt12Receive` RPC. On failure, a gRPC error status is returned.
class Bolt12ReceiveResponse extends $pb.GeneratedMessage {
  factory Bolt12ReceiveResponse({
    $core.String? offer,
    $core.String? offerId,
  }) {
    final $result = create();
    if (offer != null) {
      $result.offer = offer;
    }
    if (offerId != null) {
      $result.offerId = offerId;
    }
    return $result;
  }
  Bolt12ReceiveResponse._() : super();
  factory Bolt12ReceiveResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12ReceiveResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12ReceiveResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offer')
    ..aOS(2, _omitFieldNames ? '' : 'offerId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12ReceiveResponse clone() => Bolt12ReceiveResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12ReceiveResponse copyWith(void Function(Bolt12ReceiveResponse) updates) => super.copyWith((message) => updates(message as Bolt12ReceiveResponse)) as Bolt12ReceiveResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12ReceiveResponse create() => Bolt12ReceiveResponse._();
  Bolt12ReceiveResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt12ReceiveResponse> createRepeated() => $pb.PbList<Bolt12ReceiveResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt12ReceiveResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12ReceiveResponse>(create);
  static Bolt12ReceiveResponse? _defaultInstance;

  /// An offer for a payment within the Lightning Network.
  /// With the details of the offer, the sender has all the data necessary to send a payment
  /// to the recipient.
  @$pb.TagNumber(1)
  $core.String get offer => $_getSZ(0);
  @$pb.TagNumber(1)
  set offer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);

  /// The hex-encoded offer id.
  @$pb.TagNumber(2)
  $core.String get offerId => $_getSZ(1);
  @$pb.TagNumber(2)
  set offerId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasOfferId() => $_has(1);
  @$pb.TagNumber(2)
  void clearOfferId() => $_clearField(2);
}

/// Send a payment for a BOLT12 offer.
/// See more:
/// - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt12Payment.html#method.send
/// - https://docs.rs/ldk-node/latest/ldk_node/payment/struct.Bolt12Payment.html#method.send_using_amount
class Bolt12SendRequest extends $pb.GeneratedMessage {
  factory Bolt12SendRequest({
    $core.String? offer,
    $fixnum.Int64? amountMsat,
    $fixnum.Int64? quantity,
    $core.String? payerNote,
    $2.RouteParametersConfig? routeParameters,
  }) {
    final $result = create();
    if (offer != null) {
      $result.offer = offer;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (payerNote != null) {
      $result.payerNote = payerNote;
    }
    if (routeParameters != null) {
      $result.routeParameters = routeParameters;
    }
    return $result;
  }
  Bolt12SendRequest._() : super();
  factory Bolt12SendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12SendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12SendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offer')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'quantity', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'payerNote')
    ..aOM<$2.RouteParametersConfig>(5, _omitFieldNames ? '' : 'routeParameters', subBuilder: $2.RouteParametersConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12SendRequest clone() => Bolt12SendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12SendRequest copyWith(void Function(Bolt12SendRequest) updates) => super.copyWith((message) => updates(message as Bolt12SendRequest)) as Bolt12SendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12SendRequest create() => Bolt12SendRequest._();
  Bolt12SendRequest createEmptyInstance() => create();
  static $pb.PbList<Bolt12SendRequest> createRepeated() => $pb.PbList<Bolt12SendRequest>();
  @$core.pragma('dart2js:noInline')
  static Bolt12SendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12SendRequest>(create);
  static Bolt12SendRequest? _defaultInstance;

  /// An offer for a payment within the Lightning Network.
  @$pb.TagNumber(1)
  $core.String get offer => $_getSZ(0);
  @$pb.TagNumber(1)
  set offer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);

  /// Set this field when paying a so-called "zero-amount" offer, i.e., an offer that leaves the
  /// amount paid to be determined by the user.
  /// This operation will fail if the amount specified is less than the value required by the given offer.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMsat() => $_clearField(2);

  /// If set, it represents the number of items requested.
  @$pb.TagNumber(3)
  $fixnum.Int64 get quantity => $_getI64(2);
  @$pb.TagNumber(3)
  set quantity($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasQuantity() => $_has(2);
  @$pb.TagNumber(3)
  void clearQuantity() => $_clearField(3);

  /// If set, it will be seen by the recipient and reflected back in the invoice.
  @$pb.TagNumber(4)
  $core.String get payerNote => $_getSZ(3);
  @$pb.TagNumber(4)
  set payerNote($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPayerNote() => $_has(3);
  @$pb.TagNumber(4)
  void clearPayerNote() => $_clearField(4);

  /// Configuration options for payment routing and pathfinding.
  @$pb.TagNumber(5)
  $2.RouteParametersConfig get routeParameters => $_getN(4);
  @$pb.TagNumber(5)
  set routeParameters($2.RouteParametersConfig v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasRouteParameters() => $_has(4);
  @$pb.TagNumber(5)
  void clearRouteParameters() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.RouteParametersConfig ensureRouteParameters() => $_ensure(4);
}

/// The response for the `Bolt12Send` RPC. On failure, a gRPC error status is returned.
class Bolt12SendResponse extends $pb.GeneratedMessage {
  factory Bolt12SendResponse({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  Bolt12SendResponse._() : super();
  factory Bolt12SendResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Bolt12SendResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Bolt12SendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Bolt12SendResponse clone() => Bolt12SendResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Bolt12SendResponse copyWith(void Function(Bolt12SendResponse) updates) => super.copyWith((message) => updates(message as Bolt12SendResponse)) as Bolt12SendResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Bolt12SendResponse create() => Bolt12SendResponse._();
  Bolt12SendResponse createEmptyInstance() => create();
  static $pb.PbList<Bolt12SendResponse> createRepeated() => $pb.PbList<Bolt12SendResponse>();
  @$core.pragma('dart2js:noInline')
  static Bolt12SendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Bolt12SendResponse>(create);
  static Bolt12SendResponse? _defaultInstance;

  /// An identifier used to uniquely identify a payment in hex-encoded form.
  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

/// Send a spontaneous payment, also known as "keysend", to a node.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.SpontaneousPayment.html#method.send
class SpontaneousSendRequest extends $pb.GeneratedMessage {
  factory SpontaneousSendRequest({
    $fixnum.Int64? amountMsat,
    $core.String? nodeId,
    $2.RouteParametersConfig? routeParameters,
    $core.Iterable<$2.CustomTlvRecord>? customTlvs,
    $core.String? preimage,
  }) {
    final $result = create();
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    if (routeParameters != null) {
      $result.routeParameters = routeParameters;
    }
    if (customTlvs != null) {
      $result.customTlvs.addAll(customTlvs);
    }
    if (preimage != null) {
      $result.preimage = preimage;
    }
    return $result;
  }
  SpontaneousSendRequest._() : super();
  factory SpontaneousSendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpontaneousSendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SpontaneousSendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'nodeId')
    ..aOM<$2.RouteParametersConfig>(3, _omitFieldNames ? '' : 'routeParameters', subBuilder: $2.RouteParametersConfig.create)
    ..pc<$2.CustomTlvRecord>(4, _omitFieldNames ? '' : 'customTlvs', $pb.PbFieldType.PM, subBuilder: $2.CustomTlvRecord.create)
    ..aOS(5, _omitFieldNames ? '' : 'preimage')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpontaneousSendRequest clone() => SpontaneousSendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpontaneousSendRequest copyWith(void Function(SpontaneousSendRequest) updates) => super.copyWith((message) => updates(message as SpontaneousSendRequest)) as SpontaneousSendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpontaneousSendRequest create() => SpontaneousSendRequest._();
  SpontaneousSendRequest createEmptyInstance() => create();
  static $pb.PbList<SpontaneousSendRequest> createRepeated() => $pb.PbList<SpontaneousSendRequest>();
  @$core.pragma('dart2js:noInline')
  static SpontaneousSendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpontaneousSendRequest>(create);
  static SpontaneousSendRequest? _defaultInstance;

  /// The amount in millisatoshis to send.
  @$pb.TagNumber(1)
  $fixnum.Int64 get amountMsat => $_getI64(0);
  @$pb.TagNumber(1)
  set amountMsat($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAmountMsat() => $_has(0);
  @$pb.TagNumber(1)
  void clearAmountMsat() => $_clearField(1);

  /// The hex-encoded public key of the node to send the payment to.
  @$pb.TagNumber(2)
  $core.String get nodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set nodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearNodeId() => $_clearField(2);

  /// Configuration options for payment routing and pathfinding.
  @$pb.TagNumber(3)
  $2.RouteParametersConfig get routeParameters => $_getN(2);
  @$pb.TagNumber(3)
  set routeParameters($2.RouteParametersConfig v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRouteParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearRouteParameters() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.RouteParametersConfig ensureRouteParameters() => $_ensure(2);

  /// Custom TLV records to attach to the outgoing payment.
  @$pb.TagNumber(4)
  $pb.PbList<$2.CustomTlvRecord> get customTlvs => $_getList(3);

  /// An optional hex-encoded 32-byte payment preimage. If provided, it will be used instead of
  /// generating a random one. The payment hash will be the SHA256 of this value.
  @$pb.TagNumber(5)
  $core.String get preimage => $_getSZ(4);
  @$pb.TagNumber(5)
  set preimage($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasPreimage() => $_has(4);
  @$pb.TagNumber(5)
  void clearPreimage() => $_clearField(5);
}

/// The response for the `SpontaneousSend` RPC. On failure, a gRPC error status is returned.
class SpontaneousSendResponse extends $pb.GeneratedMessage {
  factory SpontaneousSendResponse({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  SpontaneousSendResponse._() : super();
  factory SpontaneousSendResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpontaneousSendResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SpontaneousSendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpontaneousSendResponse clone() => SpontaneousSendResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpontaneousSendResponse copyWith(void Function(SpontaneousSendResponse) updates) => super.copyWith((message) => updates(message as SpontaneousSendResponse)) as SpontaneousSendResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpontaneousSendResponse create() => SpontaneousSendResponse._();
  SpontaneousSendResponse createEmptyInstance() => create();
  static $pb.PbList<SpontaneousSendResponse> createRepeated() => $pb.PbList<SpontaneousSendResponse>();
  @$core.pragma('dart2js:noInline')
  static SpontaneousSendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpontaneousSendResponse>(create);
  static SpontaneousSendResponse? _defaultInstance;

  /// An identifier used to uniquely identify a payment in hex-encoded form.
  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

/// Selects all available on-chain funds.
class AllFunds extends $pb.GeneratedMessage {
  factory AllFunds() => create();
  AllFunds._() : super();
  factory AllFunds.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllFunds.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AllFunds', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllFunds clone() => AllFunds()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllFunds copyWith(void Function(AllFunds) updates) => super.copyWith((message) => updates(message as AllFunds)) as AllFunds;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllFunds create() => AllFunds._();
  AllFunds createEmptyInstance() => create();
  static $pb.PbList<AllFunds> createRepeated() => $pb.PbList<AllFunds>();
  @$core.pragma('dart2js:noInline')
  static AllFunds getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllFunds>(create);
  static AllFunds? _defaultInstance;
}

enum OpenChannelRequest_Amount {
  channelAmountSats, 
  allFunds, 
  notSet
}

/// Creates a new outbound channel to the given remote node.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.connect_open_channel
class OpenChannelRequest extends $pb.GeneratedMessage {
  factory OpenChannelRequest({
    $core.String? nodePubkey,
    $core.String? address,
    $fixnum.Int64? channelAmountSats,
    $fixnum.Int64? pushToCounterpartyMsat,
    $2.ChannelConfig? channelConfig,
    $core.bool? announceChannel,
    $core.bool? disableCounterpartyReserve,
    AllFunds? allFunds,
  }) {
    final $result = create();
    if (nodePubkey != null) {
      $result.nodePubkey = nodePubkey;
    }
    if (address != null) {
      $result.address = address;
    }
    if (channelAmountSats != null) {
      $result.channelAmountSats = channelAmountSats;
    }
    if (pushToCounterpartyMsat != null) {
      $result.pushToCounterpartyMsat = pushToCounterpartyMsat;
    }
    if (channelConfig != null) {
      $result.channelConfig = channelConfig;
    }
    if (announceChannel != null) {
      $result.announceChannel = announceChannel;
    }
    if (disableCounterpartyReserve != null) {
      $result.disableCounterpartyReserve = disableCounterpartyReserve;
    }
    if (allFunds != null) {
      $result.allFunds = allFunds;
    }
    return $result;
  }
  OpenChannelRequest._() : super();
  factory OpenChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, OpenChannelRequest_Amount> _OpenChannelRequest_AmountByTag = {
    3 : OpenChannelRequest_Amount.channelAmountSats,
    8 : OpenChannelRequest_Amount.allFunds,
    0 : OpenChannelRequest_Amount.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..oo(0, [3, 8])
    ..aOS(1, _omitFieldNames ? '' : 'nodePubkey')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'channelAmountSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'pushToCounterpartyMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.ChannelConfig>(5, _omitFieldNames ? '' : 'channelConfig', subBuilder: $2.ChannelConfig.create)
    ..aOB(6, _omitFieldNames ? '' : 'announceChannel')
    ..aOB(7, _omitFieldNames ? '' : 'disableCounterpartyReserve')
    ..aOM<AllFunds>(8, _omitFieldNames ? '' : 'allFunds', subBuilder: AllFunds.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenChannelRequest clone() => OpenChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenChannelRequest copyWith(void Function(OpenChannelRequest) updates) => super.copyWith((message) => updates(message as OpenChannelRequest)) as OpenChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenChannelRequest create() => OpenChannelRequest._();
  OpenChannelRequest createEmptyInstance() => create();
  static $pb.PbList<OpenChannelRequest> createRepeated() => $pb.PbList<OpenChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static OpenChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenChannelRequest>(create);
  static OpenChannelRequest? _defaultInstance;

  OpenChannelRequest_Amount whichAmount() => _OpenChannelRequest_AmountByTag[$_whichOneof(0)]!;
  void clearAmount() => $_clearField($_whichOneof(0));

  /// The hex-encoded public key of the node to open a channel with.
  @$pb.TagNumber(1)
  $core.String get nodePubkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodePubkey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodePubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodePubkey() => $_clearField(1);

  /// An address which can be used to connect to a remote peer.
  /// It can be of type IPv4:port, IPv6:port, OnionV3:port or hostname:port
  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);

  /// Commit the given amount of satoshis while retaining any required Anchor channel reserves.
  @$pb.TagNumber(3)
  $fixnum.Int64 get channelAmountSats => $_getI64(2);
  @$pb.TagNumber(3)
  set channelAmountSats($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelAmountSats() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelAmountSats() => $_clearField(3);

  /// The amount of satoshis to push to the remote side as part of the initial commitment state.
  @$pb.TagNumber(4)
  $fixnum.Int64 get pushToCounterpartyMsat => $_getI64(3);
  @$pb.TagNumber(4)
  set pushToCounterpartyMsat($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasPushToCounterpartyMsat() => $_has(3);
  @$pb.TagNumber(4)
  void clearPushToCounterpartyMsat() => $_clearField(4);

  /// The channel configuration to be used for opening this channel. If unset, default ChannelConfig is used.
  @$pb.TagNumber(5)
  $2.ChannelConfig get channelConfig => $_getN(4);
  @$pb.TagNumber(5)
  set channelConfig($2.ChannelConfig v) { $_setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasChannelConfig() => $_has(4);
  @$pb.TagNumber(5)
  void clearChannelConfig() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.ChannelConfig ensureChannelConfig() => $_ensure(4);

  /// Whether the channel should be public.
  @$pb.TagNumber(6)
  $core.bool get announceChannel => $_getBF(5);
  @$pb.TagNumber(6)
  set announceChannel($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAnnounceChannel() => $_has(5);
  @$pb.TagNumber(6)
  void clearAnnounceChannel() => $_clearField(6);

  /// Allow the counterparty to spend all its channel balance. This cannot be set together with `announce_channel`.
  @$pb.TagNumber(7)
  $core.bool get disableCounterpartyReserve => $_getBF(6);
  @$pb.TagNumber(7)
  set disableCounterpartyReserve($core.bool v) { $_setBool(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDisableCounterpartyReserve() => $_has(6);
  @$pb.TagNumber(7)
  void clearDisableCounterpartyReserve() => $_clearField(7);

  /// Commit all available on-chain funds, minus fees and any required Anchor channel reserves.
  @$pb.TagNumber(8)
  AllFunds get allFunds => $_getN(7);
  @$pb.TagNumber(8)
  set allFunds(AllFunds v) { $_setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasAllFunds() => $_has(7);
  @$pb.TagNumber(8)
  void clearAllFunds() => $_clearField(8);
  @$pb.TagNumber(8)
  AllFunds ensureAllFunds() => $_ensure(7);
}

/// The response for the `OpenChannel` RPC. On failure, a gRPC error status is returned.
class OpenChannelResponse extends $pb.GeneratedMessage {
  factory OpenChannelResponse({
    $core.String? userChannelId,
  }) {
    final $result = create();
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    return $result;
  }
  OpenChannelResponse._() : super();
  factory OpenChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory OpenChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'OpenChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userChannelId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  OpenChannelResponse clone() => OpenChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  OpenChannelResponse copyWith(void Function(OpenChannelResponse) updates) => super.copyWith((message) => updates(message as OpenChannelResponse)) as OpenChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static OpenChannelResponse create() => OpenChannelResponse._();
  OpenChannelResponse createEmptyInstance() => create();
  static $pb.PbList<OpenChannelResponse> createRepeated() => $pb.PbList<OpenChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static OpenChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<OpenChannelResponse>(create);
  static OpenChannelResponse? _defaultInstance;

  /// The local channel id of the created channel that user can use to refer to channel.
  @$pb.TagNumber(1)
  $core.String get userChannelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userChannelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserChannelId() => $_clearField(1);
}

enum SpliceInRequest_Amount {
  spliceAmountSats, 
  allFunds, 
  notSet
}

/// Increases the channel balance by the given amount.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.splice_in
class SpliceInRequest extends $pb.GeneratedMessage {
  factory SpliceInRequest({
    $core.String? userChannelId,
    $core.String? counterpartyNodeId,
    $fixnum.Int64? spliceAmountSats,
    AllFunds? allFunds,
  }) {
    final $result = create();
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (spliceAmountSats != null) {
      $result.spliceAmountSats = spliceAmountSats;
    }
    if (allFunds != null) {
      $result.allFunds = allFunds;
    }
    return $result;
  }
  SpliceInRequest._() : super();
  factory SpliceInRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpliceInRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, SpliceInRequest_Amount> _SpliceInRequest_AmountByTag = {
    3 : SpliceInRequest_Amount.spliceAmountSats,
    4 : SpliceInRequest_Amount.allFunds,
    0 : SpliceInRequest_Amount.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SpliceInRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..oo(0, [3, 4])
    ..aOS(1, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'spliceAmountSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<AllFunds>(4, _omitFieldNames ? '' : 'allFunds', subBuilder: AllFunds.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpliceInRequest clone() => SpliceInRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpliceInRequest copyWith(void Function(SpliceInRequest) updates) => super.copyWith((message) => updates(message as SpliceInRequest)) as SpliceInRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpliceInRequest create() => SpliceInRequest._();
  SpliceInRequest createEmptyInstance() => create();
  static $pb.PbList<SpliceInRequest> createRepeated() => $pb.PbList<SpliceInRequest>();
  @$core.pragma('dart2js:noInline')
  static SpliceInRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpliceInRequest>(create);
  static SpliceInRequest? _defaultInstance;

  SpliceInRequest_Amount whichAmount() => _SpliceInRequest_AmountByTag[$_whichOneof(0)]!;
  void clearAmount() => $_clearField($_whichOneof(0));

  /// The local `user_channel_id` of the channel.
  @$pb.TagNumber(1)
  $core.String get userChannelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userChannelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserChannelId() => $_clearField(1);

  /// The hex-encoded public key of the channel's counterparty node.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// Splice in the given amount of satoshis while retaining any required Anchor channel reserves.
  @$pb.TagNumber(3)
  $fixnum.Int64 get spliceAmountSats => $_getI64(2);
  @$pb.TagNumber(3)
  set spliceAmountSats($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSpliceAmountSats() => $_has(2);
  @$pb.TagNumber(3)
  void clearSpliceAmountSats() => $_clearField(3);

  /// Splice in all available confirmed on-chain funds, minus fees and any required Anchor channel reserves.
  @$pb.TagNumber(4)
  AllFunds get allFunds => $_getN(3);
  @$pb.TagNumber(4)
  set allFunds(AllFunds v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAllFunds() => $_has(3);
  @$pb.TagNumber(4)
  void clearAllFunds() => $_clearField(4);
  @$pb.TagNumber(4)
  AllFunds ensureAllFunds() => $_ensure(3);
}

/// The response for the `SpliceIn` RPC. On failure, a gRPC error status is returned.
class SpliceInResponse extends $pb.GeneratedMessage {
  factory SpliceInResponse() => create();
  SpliceInResponse._() : super();
  factory SpliceInResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpliceInResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SpliceInResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpliceInResponse clone() => SpliceInResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpliceInResponse copyWith(void Function(SpliceInResponse) updates) => super.copyWith((message) => updates(message as SpliceInResponse)) as SpliceInResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpliceInResponse create() => SpliceInResponse._();
  SpliceInResponse createEmptyInstance() => create();
  static $pb.PbList<SpliceInResponse> createRepeated() => $pb.PbList<SpliceInResponse>();
  @$core.pragma('dart2js:noInline')
  static SpliceInResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpliceInResponse>(create);
  static SpliceInResponse? _defaultInstance;
}

/// Decreases the channel balance by the given amount.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.splice_out
class SpliceOutRequest extends $pb.GeneratedMessage {
  factory SpliceOutRequest({
    $core.String? userChannelId,
    $core.String? counterpartyNodeId,
    $core.String? address,
    $fixnum.Int64? spliceAmountSats,
  }) {
    final $result = create();
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (address != null) {
      $result.address = address;
    }
    if (spliceAmountSats != null) {
      $result.spliceAmountSats = spliceAmountSats;
    }
    return $result;
  }
  SpliceOutRequest._() : super();
  factory SpliceOutRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpliceOutRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SpliceOutRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(3, _omitFieldNames ? '' : 'address')
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'spliceAmountSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpliceOutRequest clone() => SpliceOutRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpliceOutRequest copyWith(void Function(SpliceOutRequest) updates) => super.copyWith((message) => updates(message as SpliceOutRequest)) as SpliceOutRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpliceOutRequest create() => SpliceOutRequest._();
  SpliceOutRequest createEmptyInstance() => create();
  static $pb.PbList<SpliceOutRequest> createRepeated() => $pb.PbList<SpliceOutRequest>();
  @$core.pragma('dart2js:noInline')
  static SpliceOutRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpliceOutRequest>(create);
  static SpliceOutRequest? _defaultInstance;

  /// The local `user_channel_id` of this channel.
  @$pb.TagNumber(1)
  $core.String get userChannelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userChannelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserChannelId() => $_clearField(1);

  /// The hex-encoded public key of the channel's counterparty node.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  ///  A Bitcoin on-chain address to send the spliced-out funds.
  ///
  ///  If not set, an address from the node's on-chain wallet will be used.
  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(2);
  @$pb.TagNumber(3)
  set address($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => $_clearField(3);

  /// The amount of sats to splice out of the channel.
  @$pb.TagNumber(4)
  $fixnum.Int64 get spliceAmountSats => $_getI64(3);
  @$pb.TagNumber(4)
  set spliceAmountSats($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSpliceAmountSats() => $_has(3);
  @$pb.TagNumber(4)
  void clearSpliceAmountSats() => $_clearField(4);
}

/// The response for the `SpliceOut` RPC. On failure, a gRPC error status is returned.
class SpliceOutResponse extends $pb.GeneratedMessage {
  factory SpliceOutResponse({
    $core.String? address,
  }) {
    final $result = create();
    if (address != null) {
      $result.address = address;
    }
    return $result;
  }
  SpliceOutResponse._() : super();
  factory SpliceOutResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SpliceOutResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SpliceOutResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SpliceOutResponse clone() => SpliceOutResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SpliceOutResponse copyWith(void Function(SpliceOutResponse) updates) => super.copyWith((message) => updates(message as SpliceOutResponse)) as SpliceOutResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SpliceOutResponse create() => SpliceOutResponse._();
  SpliceOutResponse createEmptyInstance() => create();
  static $pb.PbList<SpliceOutResponse> createRepeated() => $pb.PbList<SpliceOutResponse>();
  @$core.pragma('dart2js:noInline')
  static SpliceOutResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SpliceOutResponse>(create);
  static SpliceOutResponse? _defaultInstance;

  /// The Bitcoin on-chain address where the funds will be sent.
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);
}

/// Update the config for a previously opened channel.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.update_channel_config
class UpdateChannelConfigRequest extends $pb.GeneratedMessage {
  factory UpdateChannelConfigRequest({
    $core.String? userChannelId,
    $core.String? counterpartyNodeId,
    $2.ChannelConfig? channelConfig,
  }) {
    final $result = create();
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (channelConfig != null) {
      $result.channelConfig = channelConfig;
    }
    return $result;
  }
  UpdateChannelConfigRequest._() : super();
  factory UpdateChannelConfigRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateChannelConfigRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateChannelConfigRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOM<$2.ChannelConfig>(3, _omitFieldNames ? '' : 'channelConfig', subBuilder: $2.ChannelConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateChannelConfigRequest clone() => UpdateChannelConfigRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateChannelConfigRequest copyWith(void Function(UpdateChannelConfigRequest) updates) => super.copyWith((message) => updates(message as UpdateChannelConfigRequest)) as UpdateChannelConfigRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChannelConfigRequest create() => UpdateChannelConfigRequest._();
  UpdateChannelConfigRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateChannelConfigRequest> createRepeated() => $pb.PbList<UpdateChannelConfigRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateChannelConfigRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateChannelConfigRequest>(create);
  static UpdateChannelConfigRequest? _defaultInstance;

  /// The local `user_channel_id` of this channel.
  @$pb.TagNumber(1)
  $core.String get userChannelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userChannelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserChannelId() => $_clearField(1);

  /// The hex-encoded public key of the counterparty node to update channel config with.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The updated channel configuration settings for a channel.
  @$pb.TagNumber(3)
  $2.ChannelConfig get channelConfig => $_getN(2);
  @$pb.TagNumber(3)
  set channelConfig($2.ChannelConfig v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasChannelConfig() => $_has(2);
  @$pb.TagNumber(3)
  void clearChannelConfig() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.ChannelConfig ensureChannelConfig() => $_ensure(2);
}

/// The response for the `UpdateChannelConfig` RPC. On failure, a gRPC error status is returned.
class UpdateChannelConfigResponse extends $pb.GeneratedMessage {
  factory UpdateChannelConfigResponse() => create();
  UpdateChannelConfigResponse._() : super();
  factory UpdateChannelConfigResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateChannelConfigResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateChannelConfigResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateChannelConfigResponse clone() => UpdateChannelConfigResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateChannelConfigResponse copyWith(void Function(UpdateChannelConfigResponse) updates) => super.copyWith((message) => updates(message as UpdateChannelConfigResponse)) as UpdateChannelConfigResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateChannelConfigResponse create() => UpdateChannelConfigResponse._();
  UpdateChannelConfigResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateChannelConfigResponse> createRepeated() => $pb.PbList<UpdateChannelConfigResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateChannelConfigResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateChannelConfigResponse>(create);
  static UpdateChannelConfigResponse? _defaultInstance;
}

/// Closes the channel specified by given request.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.close_channel
class CloseChannelRequest extends $pb.GeneratedMessage {
  factory CloseChannelRequest({
    $core.String? userChannelId,
    $core.String? counterpartyNodeId,
  }) {
    final $result = create();
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    return $result;
  }
  CloseChannelRequest._() : super();
  factory CloseChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseChannelRequest clone() => CloseChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseChannelRequest copyWith(void Function(CloseChannelRequest) updates) => super.copyWith((message) => updates(message as CloseChannelRequest)) as CloseChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseChannelRequest create() => CloseChannelRequest._();
  CloseChannelRequest createEmptyInstance() => create();
  static $pb.PbList<CloseChannelRequest> createRepeated() => $pb.PbList<CloseChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static CloseChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseChannelRequest>(create);
  static CloseChannelRequest? _defaultInstance;

  /// The local `user_channel_id` of this channel.
  @$pb.TagNumber(1)
  $core.String get userChannelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userChannelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserChannelId() => $_clearField(1);

  /// The hex-encoded public key of the node to close a channel with.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);
}

/// The response for the `CloseChannel` RPC. On failure, a gRPC error status is returned.
class CloseChannelResponse extends $pb.GeneratedMessage {
  factory CloseChannelResponse() => create();
  CloseChannelResponse._() : super();
  factory CloseChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CloseChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CloseChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CloseChannelResponse clone() => CloseChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CloseChannelResponse copyWith(void Function(CloseChannelResponse) updates) => super.copyWith((message) => updates(message as CloseChannelResponse)) as CloseChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CloseChannelResponse create() => CloseChannelResponse._();
  CloseChannelResponse createEmptyInstance() => create();
  static $pb.PbList<CloseChannelResponse> createRepeated() => $pb.PbList<CloseChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static CloseChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CloseChannelResponse>(create);
  static CloseChannelResponse? _defaultInstance;
}

/// Force closes the channel specified by given request.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.force_close_channel
class ForceCloseChannelRequest extends $pb.GeneratedMessage {
  factory ForceCloseChannelRequest({
    $core.String? userChannelId,
    $core.String? counterpartyNodeId,
    $core.String? forceCloseReason,
  }) {
    final $result = create();
    if (userChannelId != null) {
      $result.userChannelId = userChannelId;
    }
    if (counterpartyNodeId != null) {
      $result.counterpartyNodeId = counterpartyNodeId;
    }
    if (forceCloseReason != null) {
      $result.forceCloseReason = forceCloseReason;
    }
    return $result;
  }
  ForceCloseChannelRequest._() : super();
  factory ForceCloseChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForceCloseChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForceCloseChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userChannelId')
    ..aOS(2, _omitFieldNames ? '' : 'counterpartyNodeId')
    ..aOS(3, _omitFieldNames ? '' : 'forceCloseReason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForceCloseChannelRequest clone() => ForceCloseChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForceCloseChannelRequest copyWith(void Function(ForceCloseChannelRequest) updates) => super.copyWith((message) => updates(message as ForceCloseChannelRequest)) as ForceCloseChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForceCloseChannelRequest create() => ForceCloseChannelRequest._();
  ForceCloseChannelRequest createEmptyInstance() => create();
  static $pb.PbList<ForceCloseChannelRequest> createRepeated() => $pb.PbList<ForceCloseChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static ForceCloseChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForceCloseChannelRequest>(create);
  static ForceCloseChannelRequest? _defaultInstance;

  /// The local `user_channel_id` of this channel.
  @$pb.TagNumber(1)
  $core.String get userChannelId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userChannelId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserChannelId() => $_clearField(1);

  /// The hex-encoded public key of the node to close a channel with.
  @$pb.TagNumber(2)
  $core.String get counterpartyNodeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set counterpartyNodeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCounterpartyNodeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCounterpartyNodeId() => $_clearField(2);

  /// The reason for force-closing.
  @$pb.TagNumber(3)
  $core.String get forceCloseReason => $_getSZ(2);
  @$pb.TagNumber(3)
  set forceCloseReason($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasForceCloseReason() => $_has(2);
  @$pb.TagNumber(3)
  void clearForceCloseReason() => $_clearField(3);
}

/// The response for the `ForceCloseChannel` RPC. On failure, a gRPC error status is returned.
class ForceCloseChannelResponse extends $pb.GeneratedMessage {
  factory ForceCloseChannelResponse() => create();
  ForceCloseChannelResponse._() : super();
  factory ForceCloseChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ForceCloseChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ForceCloseChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ForceCloseChannelResponse clone() => ForceCloseChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ForceCloseChannelResponse copyWith(void Function(ForceCloseChannelResponse) updates) => super.copyWith((message) => updates(message as ForceCloseChannelResponse)) as ForceCloseChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ForceCloseChannelResponse create() => ForceCloseChannelResponse._();
  ForceCloseChannelResponse createEmptyInstance() => create();
  static $pb.PbList<ForceCloseChannelResponse> createRepeated() => $pb.PbList<ForceCloseChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static ForceCloseChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForceCloseChannelResponse>(create);
  static ForceCloseChannelResponse? _defaultInstance;
}

/// Returns a list of known channels.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.list_channels
class ListChannelsRequest extends $pb.GeneratedMessage {
  factory ListChannelsRequest() => create();
  ListChannelsRequest._() : super();
  factory ListChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListChannelsRequest clone() => ListChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListChannelsRequest copyWith(void Function(ListChannelsRequest) updates) => super.copyWith((message) => updates(message as ListChannelsRequest)) as ListChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChannelsRequest create() => ListChannelsRequest._();
  ListChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<ListChannelsRequest> createRepeated() => $pb.PbList<ListChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChannelsRequest>(create);
  static ListChannelsRequest? _defaultInstance;
}

/// The response for the `ListChannels` RPC. On failure, a gRPC error status is returned.
class ListChannelsResponse extends $pb.GeneratedMessage {
  factory ListChannelsResponse({
    $core.Iterable<$2.Channel>? channels,
  }) {
    final $result = create();
    if (channels != null) {
      $result.channels.addAll(channels);
    }
    return $result;
  }
  ListChannelsResponse._() : super();
  factory ListChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<$2.Channel>(1, _omitFieldNames ? '' : 'channels', $pb.PbFieldType.PM, subBuilder: $2.Channel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListChannelsResponse clone() => ListChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListChannelsResponse copyWith(void Function(ListChannelsResponse) updates) => super.copyWith((message) => updates(message as ListChannelsResponse)) as ListChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListChannelsResponse create() => ListChannelsResponse._();
  ListChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<ListChannelsResponse> createRepeated() => $pb.PbList<ListChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListChannelsResponse>(create);
  static ListChannelsResponse? _defaultInstance;

  /// List of channels.
  @$pb.TagNumber(1)
  $pb.PbList<$2.Channel> get channels => $_getList(0);
}

/// Returns payment details for a given payment_id.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.payment
class GetPaymentDetailsRequest extends $pb.GeneratedMessage {
  factory GetPaymentDetailsRequest({
    $core.String? paymentId,
  }) {
    final $result = create();
    if (paymentId != null) {
      $result.paymentId = paymentId;
    }
    return $result;
  }
  GetPaymentDetailsRequest._() : super();
  factory GetPaymentDetailsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentDetailsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentDetailsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'paymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentDetailsRequest clone() => GetPaymentDetailsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentDetailsRequest copyWith(void Function(GetPaymentDetailsRequest) updates) => super.copyWith((message) => updates(message as GetPaymentDetailsRequest)) as GetPaymentDetailsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentDetailsRequest create() => GetPaymentDetailsRequest._();
  GetPaymentDetailsRequest createEmptyInstance() => create();
  static $pb.PbList<GetPaymentDetailsRequest> createRepeated() => $pb.PbList<GetPaymentDetailsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentDetailsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentDetailsRequest>(create);
  static GetPaymentDetailsRequest? _defaultInstance;

  /// An identifier used to uniquely identify a payment in hex-encoded form.
  @$pb.TagNumber(1)
  $core.String get paymentId => $_getSZ(0);
  @$pb.TagNumber(1)
  set paymentId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasPaymentId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPaymentId() => $_clearField(1);
}

/// The response for the `GetPaymentDetails` RPC. On failure, a gRPC error status is returned.
class GetPaymentDetailsResponse extends $pb.GeneratedMessage {
  factory GetPaymentDetailsResponse({
    $2.Payment? payment,
  }) {
    final $result = create();
    if (payment != null) {
      $result.payment = payment;
    }
    return $result;
  }
  GetPaymentDetailsResponse._() : super();
  factory GetPaymentDetailsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetPaymentDetailsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetPaymentDetailsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<$2.Payment>(1, _omitFieldNames ? '' : 'payment', subBuilder: $2.Payment.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetPaymentDetailsResponse clone() => GetPaymentDetailsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetPaymentDetailsResponse copyWith(void Function(GetPaymentDetailsResponse) updates) => super.copyWith((message) => updates(message as GetPaymentDetailsResponse)) as GetPaymentDetailsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetPaymentDetailsResponse create() => GetPaymentDetailsResponse._();
  GetPaymentDetailsResponse createEmptyInstance() => create();
  static $pb.PbList<GetPaymentDetailsResponse> createRepeated() => $pb.PbList<GetPaymentDetailsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetPaymentDetailsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPaymentDetailsResponse>(create);
  static GetPaymentDetailsResponse? _defaultInstance;

  /// Represents a payment.
  /// Will be `None` if payment doesn't exist.
  @$pb.TagNumber(1)
  $2.Payment get payment => $_getN(0);
  @$pb.TagNumber(1)
  set payment($2.Payment v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPayment() => $_has(0);
  @$pb.TagNumber(1)
  void clearPayment() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Payment ensurePayment() => $_ensure(0);
}

/// Retrieves list of all payments.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.list_payments
class ListPaymentsRequest extends $pb.GeneratedMessage {
  factory ListPaymentsRequest({
    $2.PageToken? pageToken,
  }) {
    final $result = create();
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  ListPaymentsRequest._() : super();
  factory ListPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<$2.PageToken>(1, _omitFieldNames ? '' : 'pageToken', subBuilder: $2.PageToken.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaymentsRequest clone() => ListPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaymentsRequest copyWith(void Function(ListPaymentsRequest) updates) => super.copyWith((message) => updates(message as ListPaymentsRequest)) as ListPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaymentsRequest create() => ListPaymentsRequest._();
  ListPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListPaymentsRequest> createRepeated() => $pb.PbList<ListPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPaymentsRequest>(create);
  static ListPaymentsRequest? _defaultInstance;

  ///  `page_token` is a pagination token.
  ///
  ///  To query for the first page, `page_token` must not be specified.
  ///
  ///  For subsequent pages, use the value that was returned as `next_page_token` in the previous
  ///  page's response.
  @$pb.TagNumber(1)
  $2.PageToken get pageToken => $_getN(0);
  @$pb.TagNumber(1)
  set pageToken($2.PageToken v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageToken() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.PageToken ensurePageToken() => $_ensure(0);
}

/// The response for the `ListPayments` RPC. On failure, a gRPC error status is returned.
class ListPaymentsResponse extends $pb.GeneratedMessage {
  factory ListPaymentsResponse({
    $core.Iterable<$2.Payment>? payments,
    $2.PageToken? nextPageToken,
  }) {
    final $result = create();
    if (payments != null) {
      $result.payments.addAll(payments);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListPaymentsResponse._() : super();
  factory ListPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<$2.Payment>(1, _omitFieldNames ? '' : 'payments', $pb.PbFieldType.PM, subBuilder: $2.Payment.create)
    ..aOM<$2.PageToken>(2, _omitFieldNames ? '' : 'nextPageToken', subBuilder: $2.PageToken.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPaymentsResponse clone() => ListPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPaymentsResponse copyWith(void Function(ListPaymentsResponse) updates) => super.copyWith((message) => updates(message as ListPaymentsResponse)) as ListPaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPaymentsResponse create() => ListPaymentsResponse._();
  ListPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListPaymentsResponse> createRepeated() => $pb.PbList<ListPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPaymentsResponse>(create);
  static ListPaymentsResponse? _defaultInstance;

  /// List of payments.
  @$pb.TagNumber(1)
  $pb.PbList<$2.Payment> get payments => $_getList(0);

  ///  `next_page_token` is a pagination token, used to retrieve the next page of results.
  ///  Use this value to query for next-page of paginated operation, by specifying
  ///  this value as the `page_token` in the next request.
  ///
  ///  If `next_page_token` is `None`, then the "last page" of results has been processed and
  ///  there is no more data to be retrieved.
  ///
  ///  If `next_page_token` is not `None`, it does not necessarily mean that there is more data in the
  ///  result set. The only way to know when you have reached the end of the result set is when
  ///  `next_page_token` is `None`.
  ///
  ///  **Caution**: Clients must not assume a specific number of records to be present in a page for
  ///  paginated response.
  @$pb.TagNumber(2)
  $2.PageToken get nextPageToken => $_getN(1);
  @$pb.TagNumber(2)
  set nextPageToken($2.PageToken v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.PageToken ensureNextPageToken() => $_ensure(1);
}

/// Retrieves list of all forwarded payments.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/enum.Event.html#variant.PaymentForwarded
class ListForwardedPaymentsRequest extends $pb.GeneratedMessage {
  factory ListForwardedPaymentsRequest({
    $2.PageToken? pageToken,
  }) {
    final $result = create();
    if (pageToken != null) {
      $result.pageToken = pageToken;
    }
    return $result;
  }
  ListForwardedPaymentsRequest._() : super();
  factory ListForwardedPaymentsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListForwardedPaymentsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListForwardedPaymentsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<$2.PageToken>(1, _omitFieldNames ? '' : 'pageToken', subBuilder: $2.PageToken.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListForwardedPaymentsRequest clone() => ListForwardedPaymentsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListForwardedPaymentsRequest copyWith(void Function(ListForwardedPaymentsRequest) updates) => super.copyWith((message) => updates(message as ListForwardedPaymentsRequest)) as ListForwardedPaymentsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListForwardedPaymentsRequest create() => ListForwardedPaymentsRequest._();
  ListForwardedPaymentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListForwardedPaymentsRequest> createRepeated() => $pb.PbList<ListForwardedPaymentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListForwardedPaymentsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListForwardedPaymentsRequest>(create);
  static ListForwardedPaymentsRequest? _defaultInstance;

  ///  `page_token` is a pagination token.
  ///
  ///  To query for the first page, `page_token` must not be specified.
  ///
  ///  For subsequent pages, use the value that was returned as `next_page_token` in the previous
  ///  page's response.
  @$pb.TagNumber(1)
  $2.PageToken get pageToken => $_getN(0);
  @$pb.TagNumber(1)
  set pageToken($2.PageToken v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPageToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearPageToken() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.PageToken ensurePageToken() => $_ensure(0);
}

/// The response for the `ListForwardedPayments` RPC. On failure, a gRPC error status is returned.
class ListForwardedPaymentsResponse extends $pb.GeneratedMessage {
  factory ListForwardedPaymentsResponse({
    $core.Iterable<$2.ForwardedPayment>? forwardedPayments,
    $2.PageToken? nextPageToken,
  }) {
    final $result = create();
    if (forwardedPayments != null) {
      $result.forwardedPayments.addAll(forwardedPayments);
    }
    if (nextPageToken != null) {
      $result.nextPageToken = nextPageToken;
    }
    return $result;
  }
  ListForwardedPaymentsResponse._() : super();
  factory ListForwardedPaymentsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListForwardedPaymentsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListForwardedPaymentsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<$2.ForwardedPayment>(1, _omitFieldNames ? '' : 'forwardedPayments', $pb.PbFieldType.PM, subBuilder: $2.ForwardedPayment.create)
    ..aOM<$2.PageToken>(2, _omitFieldNames ? '' : 'nextPageToken', subBuilder: $2.PageToken.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListForwardedPaymentsResponse clone() => ListForwardedPaymentsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListForwardedPaymentsResponse copyWith(void Function(ListForwardedPaymentsResponse) updates) => super.copyWith((message) => updates(message as ListForwardedPaymentsResponse)) as ListForwardedPaymentsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListForwardedPaymentsResponse create() => ListForwardedPaymentsResponse._();
  ListForwardedPaymentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListForwardedPaymentsResponse> createRepeated() => $pb.PbList<ListForwardedPaymentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListForwardedPaymentsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListForwardedPaymentsResponse>(create);
  static ListForwardedPaymentsResponse? _defaultInstance;

  /// List of forwarded payments.
  @$pb.TagNumber(1)
  $pb.PbList<$2.ForwardedPayment> get forwardedPayments => $_getList(0);

  ///  `next_page_token` is a pagination token, used to retrieve the next page of results.
  ///  Use this value to query for next-page of paginated operation, by specifying
  ///  this value as the `page_token` in the next request.
  ///
  ///  If `next_page_token` is `None`, then the "last page" of results has been processed and
  ///  there is no more data to be retrieved.
  ///
  ///  If `next_page_token` is not `None`, it does not necessarily mean that there is more data in the
  ///  result set. The only way to know when you have reached the end of the result set is when
  ///  `next_page_token` is `None`.
  ///
  ///  **Caution**: Clients must not assume a specific number of records to be present in a page for
  ///  paginated response.
  @$pb.TagNumber(2)
  $2.PageToken get nextPageToken => $_getN(1);
  @$pb.TagNumber(2)
  set nextPageToken($2.PageToken v) { $_setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPageToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPageToken() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.PageToken ensureNextPageToken() => $_ensure(1);
}

/// Sign a message with the node's secret key.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.sign_message
class SignMessageRequest extends $pb.GeneratedMessage {
  factory SignMessageRequest({
    $core.List<$core.int>? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  SignMessageRequest._() : super();
  factory SignMessageRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignMessageRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignMessageRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'message', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignMessageRequest clone() => SignMessageRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignMessageRequest copyWith(void Function(SignMessageRequest) updates) => super.copyWith((message) => updates(message as SignMessageRequest)) as SignMessageRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignMessageRequest create() => SignMessageRequest._();
  SignMessageRequest createEmptyInstance() => create();
  static $pb.PbList<SignMessageRequest> createRepeated() => $pb.PbList<SignMessageRequest>();
  @$core.pragma('dart2js:noInline')
  static SignMessageRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignMessageRequest>(create);
  static SignMessageRequest? _defaultInstance;

  /// The message to sign, as raw bytes.
  @$pb.TagNumber(1)
  $core.List<$core.int> get message => $_getN(0);
  @$pb.TagNumber(1)
  set message($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
}

/// The response for the `SignMessage` RPC. On failure, a gRPC error status is returned.
class SignMessageResponse extends $pb.GeneratedMessage {
  factory SignMessageResponse({
    $core.String? signature,
  }) {
    final $result = create();
    if (signature != null) {
      $result.signature = signature;
    }
    return $result;
  }
  SignMessageResponse._() : super();
  factory SignMessageResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SignMessageResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SignMessageResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'signature')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SignMessageResponse clone() => SignMessageResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SignMessageResponse copyWith(void Function(SignMessageResponse) updates) => super.copyWith((message) => updates(message as SignMessageResponse)) as SignMessageResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SignMessageResponse create() => SignMessageResponse._();
  SignMessageResponse createEmptyInstance() => create();
  static $pb.PbList<SignMessageResponse> createRepeated() => $pb.PbList<SignMessageResponse>();
  @$core.pragma('dart2js:noInline')
  static SignMessageResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignMessageResponse>(create);
  static SignMessageResponse? _defaultInstance;

  /// The signature of the message, as a zbase32-encoded string.
  @$pb.TagNumber(1)
  $core.String get signature => $_getSZ(0);
  @$pb.TagNumber(1)
  set signature($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSignature() => $_has(0);
  @$pb.TagNumber(1)
  void clearSignature() => $_clearField(1);
}

/// Verify a signature against a message and public key.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.verify_signature
class VerifySignatureRequest extends $pb.GeneratedMessage {
  factory VerifySignatureRequest({
    $core.List<$core.int>? message,
    $core.String? signature,
    $core.String? publicKey,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    if (signature != null) {
      $result.signature = signature;
    }
    if (publicKey != null) {
      $result.publicKey = publicKey;
    }
    return $result;
  }
  VerifySignatureRequest._() : super();
  factory VerifySignatureRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifySignatureRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifySignatureRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'message', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'signature')
    ..aOS(3, _omitFieldNames ? '' : 'publicKey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifySignatureRequest clone() => VerifySignatureRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifySignatureRequest copyWith(void Function(VerifySignatureRequest) updates) => super.copyWith((message) => updates(message as VerifySignatureRequest)) as VerifySignatureRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifySignatureRequest create() => VerifySignatureRequest._();
  VerifySignatureRequest createEmptyInstance() => create();
  static $pb.PbList<VerifySignatureRequest> createRepeated() => $pb.PbList<VerifySignatureRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifySignatureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifySignatureRequest>(create);
  static VerifySignatureRequest? _defaultInstance;

  /// The message that was signed, as raw bytes.
  @$pb.TagNumber(1)
  $core.List<$core.int> get message => $_getN(0);
  @$pb.TagNumber(1)
  set message($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);

  /// The signature to verify, as a zbase32-encoded string.
  @$pb.TagNumber(2)
  $core.String get signature => $_getSZ(1);
  @$pb.TagNumber(2)
  set signature($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);

  /// The hex-encoded public key of the signer.
  @$pb.TagNumber(3)
  $core.String get publicKey => $_getSZ(2);
  @$pb.TagNumber(3)
  set publicKey($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicKey() => $_clearField(3);
}

/// The response for the `VerifySignature` RPC. On failure, a gRPC error status is returned.
class VerifySignatureResponse extends $pb.GeneratedMessage {
  factory VerifySignatureResponse({
    $core.bool? valid,
  }) {
    final $result = create();
    if (valid != null) {
      $result.valid = valid;
    }
    return $result;
  }
  VerifySignatureResponse._() : super();
  factory VerifySignatureResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifySignatureResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifySignatureResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'valid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifySignatureResponse clone() => VerifySignatureResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifySignatureResponse copyWith(void Function(VerifySignatureResponse) updates) => super.copyWith((message) => updates(message as VerifySignatureResponse)) as VerifySignatureResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifySignatureResponse create() => VerifySignatureResponse._();
  VerifySignatureResponse createEmptyInstance() => create();
  static $pb.PbList<VerifySignatureResponse> createRepeated() => $pb.PbList<VerifySignatureResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifySignatureResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifySignatureResponse>(create);
  static VerifySignatureResponse? _defaultInstance;

  /// Whether the signature is valid.
  @$pb.TagNumber(1)
  $core.bool get valid => $_getBF(0);
  @$pb.TagNumber(1)
  set valid($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearValid() => $_clearField(1);
}

/// Export the pathfinding scores used by the router.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.export_pathfinding_scores
class ExportPathfindingScoresRequest extends $pb.GeneratedMessage {
  factory ExportPathfindingScoresRequest() => create();
  ExportPathfindingScoresRequest._() : super();
  factory ExportPathfindingScoresRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportPathfindingScoresRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportPathfindingScoresRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportPathfindingScoresRequest clone() => ExportPathfindingScoresRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportPathfindingScoresRequest copyWith(void Function(ExportPathfindingScoresRequest) updates) => super.copyWith((message) => updates(message as ExportPathfindingScoresRequest)) as ExportPathfindingScoresRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportPathfindingScoresRequest create() => ExportPathfindingScoresRequest._();
  ExportPathfindingScoresRequest createEmptyInstance() => create();
  static $pb.PbList<ExportPathfindingScoresRequest> createRepeated() => $pb.PbList<ExportPathfindingScoresRequest>();
  @$core.pragma('dart2js:noInline')
  static ExportPathfindingScoresRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportPathfindingScoresRequest>(create);
  static ExportPathfindingScoresRequest? _defaultInstance;
}

/// The response for the `ExportPathfindingScores` RPC. On failure, a gRPC error status is returned.
class ExportPathfindingScoresResponse extends $pb.GeneratedMessage {
  factory ExportPathfindingScoresResponse({
    $core.List<$core.int>? scores,
  }) {
    final $result = create();
    if (scores != null) {
      $result.scores = scores;
    }
    return $result;
  }
  ExportPathfindingScoresResponse._() : super();
  factory ExportPathfindingScoresResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExportPathfindingScoresResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExportPathfindingScoresResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'scores', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExportPathfindingScoresResponse clone() => ExportPathfindingScoresResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExportPathfindingScoresResponse copyWith(void Function(ExportPathfindingScoresResponse) updates) => super.copyWith((message) => updates(message as ExportPathfindingScoresResponse)) as ExportPathfindingScoresResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExportPathfindingScoresResponse create() => ExportPathfindingScoresResponse._();
  ExportPathfindingScoresResponse createEmptyInstance() => create();
  static $pb.PbList<ExportPathfindingScoresResponse> createRepeated() => $pb.PbList<ExportPathfindingScoresResponse>();
  @$core.pragma('dart2js:noInline')
  static ExportPathfindingScoresResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExportPathfindingScoresResponse>(create);
  static ExportPathfindingScoresResponse? _defaultInstance;

  /// The serialized pathfinding scores data.
  @$pb.TagNumber(1)
  $core.List<$core.int> get scores => $_getN(0);
  @$pb.TagNumber(1)
  set scores($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasScores() => $_has(0);
  @$pb.TagNumber(1)
  void clearScores() => $_clearField(1);
}

/// Retrieves an overview of all known balances.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.list_balances
class GetBalancesRequest extends $pb.GeneratedMessage {
  factory GetBalancesRequest() => create();
  GetBalancesRequest._() : super();
  factory GetBalancesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBalancesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBalancesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBalancesRequest clone() => GetBalancesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBalancesRequest copyWith(void Function(GetBalancesRequest) updates) => super.copyWith((message) => updates(message as GetBalancesRequest)) as GetBalancesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBalancesRequest create() => GetBalancesRequest._();
  GetBalancesRequest createEmptyInstance() => create();
  static $pb.PbList<GetBalancesRequest> createRepeated() => $pb.PbList<GetBalancesRequest>();
  @$core.pragma('dart2js:noInline')
  static GetBalancesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBalancesRequest>(create);
  static GetBalancesRequest? _defaultInstance;
}

/// The response for the `GetBalances` RPC. On failure, a gRPC error status is returned.
class GetBalancesResponse extends $pb.GeneratedMessage {
  factory GetBalancesResponse({
    $fixnum.Int64? totalOnchainBalanceSats,
    $fixnum.Int64? spendableOnchainBalanceSats,
    $fixnum.Int64? totalAnchorChannelsReserveSats,
    $fixnum.Int64? totalLightningBalanceSats,
    $core.Iterable<$2.LightningBalance>? lightningBalances,
    $core.Iterable<$2.PendingSweepBalance>? pendingBalancesFromChannelClosures,
  }) {
    final $result = create();
    if (totalOnchainBalanceSats != null) {
      $result.totalOnchainBalanceSats = totalOnchainBalanceSats;
    }
    if (spendableOnchainBalanceSats != null) {
      $result.spendableOnchainBalanceSats = spendableOnchainBalanceSats;
    }
    if (totalAnchorChannelsReserveSats != null) {
      $result.totalAnchorChannelsReserveSats = totalAnchorChannelsReserveSats;
    }
    if (totalLightningBalanceSats != null) {
      $result.totalLightningBalanceSats = totalLightningBalanceSats;
    }
    if (lightningBalances != null) {
      $result.lightningBalances.addAll(lightningBalances);
    }
    if (pendingBalancesFromChannelClosures != null) {
      $result.pendingBalancesFromChannelClosures.addAll(pendingBalancesFromChannelClosures);
    }
    return $result;
  }
  GetBalancesResponse._() : super();
  factory GetBalancesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetBalancesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetBalancesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalOnchainBalanceSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'spendableOnchainBalanceSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'totalAnchorChannelsReserveSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'totalLightningBalanceSats', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<$2.LightningBalance>(5, _omitFieldNames ? '' : 'lightningBalances', $pb.PbFieldType.PM, subBuilder: $2.LightningBalance.create)
    ..pc<$2.PendingSweepBalance>(6, _omitFieldNames ? '' : 'pendingBalancesFromChannelClosures', $pb.PbFieldType.PM, subBuilder: $2.PendingSweepBalance.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetBalancesResponse clone() => GetBalancesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetBalancesResponse copyWith(void Function(GetBalancesResponse) updates) => super.copyWith((message) => updates(message as GetBalancesResponse)) as GetBalancesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetBalancesResponse create() => GetBalancesResponse._();
  GetBalancesResponse createEmptyInstance() => create();
  static $pb.PbList<GetBalancesResponse> createRepeated() => $pb.PbList<GetBalancesResponse>();
  @$core.pragma('dart2js:noInline')
  static GetBalancesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetBalancesResponse>(create);
  static GetBalancesResponse? _defaultInstance;

  /// The total balance of our on-chain wallet.
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalOnchainBalanceSats => $_getI64(0);
  @$pb.TagNumber(1)
  set totalOnchainBalanceSats($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTotalOnchainBalanceSats() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalOnchainBalanceSats() => $_clearField(1);

  ///  The currently spendable balance of our on-chain wallet.
  ///
  ///  This includes any sufficiently confirmed funds, minus `total_anchor_channels_reserve_sats`.
  @$pb.TagNumber(2)
  $fixnum.Int64 get spendableOnchainBalanceSats => $_getI64(1);
  @$pb.TagNumber(2)
  set spendableOnchainBalanceSats($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSpendableOnchainBalanceSats() => $_has(1);
  @$pb.TagNumber(2)
  void clearSpendableOnchainBalanceSats() => $_clearField(2);

  /// The share of our total balance that we retain as an emergency reserve to (hopefully) be
  /// able to spend the Anchor outputs when one of our channels is closed.
  @$pb.TagNumber(3)
  $fixnum.Int64 get totalAnchorChannelsReserveSats => $_getI64(2);
  @$pb.TagNumber(3)
  set totalAnchorChannelsReserveSats($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTotalAnchorChannelsReserveSats() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalAnchorChannelsReserveSats() => $_clearField(3);

  ///  The total balance that we would be able to claim across all our Lightning channels.
  ///
  ///  Note this excludes balances that we are unsure if we are able to claim (e.g., as we are
  ///  waiting for a preimage or for a timeout to expire). These balances will however be included
  ///  as `MaybePreimageClaimableHTLC` and `MaybeTimeoutClaimableHTLC` in `lightning_balances`.
  @$pb.TagNumber(4)
  $fixnum.Int64 get totalLightningBalanceSats => $_getI64(3);
  @$pb.TagNumber(4)
  set totalLightningBalanceSats($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTotalLightningBalanceSats() => $_has(3);
  @$pb.TagNumber(4)
  void clearTotalLightningBalanceSats() => $_clearField(4);

  ///  A detailed list of all known Lightning balances that would be claimable on channel closure.
  ///
  ///  Note that less than the listed amounts are spendable over lightning as further reserve
  ///  restrictions apply. Please refer to `Channel::outbound_capacity_msat` and
  ///  Channel::next_outbound_htlc_limit_msat as returned by `ListChannels`
  ///  for a better approximation of the spendable amounts.
  @$pb.TagNumber(5)
  $pb.PbList<$2.LightningBalance> get lightningBalances => $_getList(4);

  ///  A detailed list of balances currently being swept from the Lightning to the on-chain
  ///  wallet.
  ///
  ///  These are balances resulting from channel closures that may have been encumbered by a
  ///  delay, but are now being claimed and useable once sufficiently confirmed on-chain.
  ///
  ///  Note that, depending on the sync status of the wallets, swept balances listed here might or
  ///  might not already be accounted for in `total_onchain_balance_sats`.
  @$pb.TagNumber(6)
  $pb.PbList<$2.PendingSweepBalance> get pendingBalancesFromChannelClosures => $_getList(5);
}

/// Connect to a peer on the Lightning Network.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.connect
class ConnectPeerRequest extends $pb.GeneratedMessage {
  factory ConnectPeerRequest({
    $core.String? nodePubkey,
    $core.String? address,
    $core.bool? persist,
  }) {
    final $result = create();
    if (nodePubkey != null) {
      $result.nodePubkey = nodePubkey;
    }
    if (address != null) {
      $result.address = address;
    }
    if (persist != null) {
      $result.persist = persist;
    }
    return $result;
  }
  ConnectPeerRequest._() : super();
  factory ConnectPeerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectPeerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectPeerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodePubkey')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOB(3, _omitFieldNames ? '' : 'persist')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectPeerRequest clone() => ConnectPeerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectPeerRequest copyWith(void Function(ConnectPeerRequest) updates) => super.copyWith((message) => updates(message as ConnectPeerRequest)) as ConnectPeerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectPeerRequest create() => ConnectPeerRequest._();
  ConnectPeerRequest createEmptyInstance() => create();
  static $pb.PbList<ConnectPeerRequest> createRepeated() => $pb.PbList<ConnectPeerRequest>();
  @$core.pragma('dart2js:noInline')
  static ConnectPeerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectPeerRequest>(create);
  static ConnectPeerRequest? _defaultInstance;

  /// The hex-encoded public key of the node to connect to.
  @$pb.TagNumber(1)
  $core.String get nodePubkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodePubkey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodePubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodePubkey() => $_clearField(1);

  /// An address which can be used to connect to a remote peer.
  /// It can be of type IPv4:port, IPv6:port, OnionV3:port or hostname:port
  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);

  /// Whether to persist the peer connection, i.e., whether the peer will be re-connected on
  /// restart.
  @$pb.TagNumber(3)
  $core.bool get persist => $_getBF(2);
  @$pb.TagNumber(3)
  set persist($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPersist() => $_has(2);
  @$pb.TagNumber(3)
  void clearPersist() => $_clearField(3);
}

/// The response for the `ConnectPeer` RPC. On failure, a gRPC error status is returned.
class ConnectPeerResponse extends $pb.GeneratedMessage {
  factory ConnectPeerResponse() => create();
  ConnectPeerResponse._() : super();
  factory ConnectPeerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConnectPeerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ConnectPeerResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ConnectPeerResponse clone() => ConnectPeerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ConnectPeerResponse copyWith(void Function(ConnectPeerResponse) updates) => super.copyWith((message) => updates(message as ConnectPeerResponse)) as ConnectPeerResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ConnectPeerResponse create() => ConnectPeerResponse._();
  ConnectPeerResponse createEmptyInstance() => create();
  static $pb.PbList<ConnectPeerResponse> createRepeated() => $pb.PbList<ConnectPeerResponse>();
  @$core.pragma('dart2js:noInline')
  static ConnectPeerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConnectPeerResponse>(create);
  static ConnectPeerResponse? _defaultInstance;
}

/// Disconnect from a peer and remove it from the peer store.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.disconnect
class DisconnectPeerRequest extends $pb.GeneratedMessage {
  factory DisconnectPeerRequest({
    $core.String? nodePubkey,
  }) {
    final $result = create();
    if (nodePubkey != null) {
      $result.nodePubkey = nodePubkey;
    }
    return $result;
  }
  DisconnectPeerRequest._() : super();
  factory DisconnectPeerRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectPeerRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectPeerRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodePubkey')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectPeerRequest clone() => DisconnectPeerRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectPeerRequest copyWith(void Function(DisconnectPeerRequest) updates) => super.copyWith((message) => updates(message as DisconnectPeerRequest)) as DisconnectPeerRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectPeerRequest create() => DisconnectPeerRequest._();
  DisconnectPeerRequest createEmptyInstance() => create();
  static $pb.PbList<DisconnectPeerRequest> createRepeated() => $pb.PbList<DisconnectPeerRequest>();
  @$core.pragma('dart2js:noInline')
  static DisconnectPeerRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectPeerRequest>(create);
  static DisconnectPeerRequest? _defaultInstance;

  /// The hex-encoded public key of the node to disconnect from.
  @$pb.TagNumber(1)
  $core.String get nodePubkey => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodePubkey($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodePubkey() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodePubkey() => $_clearField(1);
}

/// The response for the `DisconnectPeer` RPC. On failure, a gRPC error status is returned.
class DisconnectPeerResponse extends $pb.GeneratedMessage {
  factory DisconnectPeerResponse() => create();
  DisconnectPeerResponse._() : super();
  factory DisconnectPeerResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DisconnectPeerResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DisconnectPeerResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DisconnectPeerResponse clone() => DisconnectPeerResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DisconnectPeerResponse copyWith(void Function(DisconnectPeerResponse) updates) => super.copyWith((message) => updates(message as DisconnectPeerResponse)) as DisconnectPeerResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DisconnectPeerResponse create() => DisconnectPeerResponse._();
  DisconnectPeerResponse createEmptyInstance() => create();
  static $pb.PbList<DisconnectPeerResponse> createRepeated() => $pb.PbList<DisconnectPeerResponse>();
  @$core.pragma('dart2js:noInline')
  static DisconnectPeerResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DisconnectPeerResponse>(create);
  static DisconnectPeerResponse? _defaultInstance;
}

/// Returns a list of peers.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/struct.Node.html#method.list_peers
class ListPeersRequest extends $pb.GeneratedMessage {
  factory ListPeersRequest() => create();
  ListPeersRequest._() : super();
  factory ListPeersRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPeersRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPeersRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPeersRequest clone() => ListPeersRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPeersRequest copyWith(void Function(ListPeersRequest) updates) => super.copyWith((message) => updates(message as ListPeersRequest)) as ListPeersRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPeersRequest create() => ListPeersRequest._();
  ListPeersRequest createEmptyInstance() => create();
  static $pb.PbList<ListPeersRequest> createRepeated() => $pb.PbList<ListPeersRequest>();
  @$core.pragma('dart2js:noInline')
  static ListPeersRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPeersRequest>(create);
  static ListPeersRequest? _defaultInstance;
}

/// The response for the `ListPeers` RPC. On failure, a gRPC error status is returned.
class ListPeersResponse extends $pb.GeneratedMessage {
  factory ListPeersResponse({
    $core.Iterable<$2.Peer>? peers,
  }) {
    final $result = create();
    if (peers != null) {
      $result.peers.addAll(peers);
    }
    return $result;
  }
  ListPeersResponse._() : super();
  factory ListPeersResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListPeersResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ListPeersResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<$2.Peer>(1, _omitFieldNames ? '' : 'peers', $pb.PbFieldType.PM, subBuilder: $2.Peer.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListPeersResponse clone() => ListPeersResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListPeersResponse copyWith(void Function(ListPeersResponse) updates) => super.copyWith((message) => updates(message as ListPeersResponse)) as ListPeersResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListPeersResponse create() => ListPeersResponse._();
  ListPeersResponse createEmptyInstance() => create();
  static $pb.PbList<ListPeersResponse> createRepeated() => $pb.PbList<ListPeersResponse>();
  @$core.pragma('dart2js:noInline')
  static ListPeersResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListPeersResponse>(create);
  static ListPeersResponse? _defaultInstance;

  /// List of peers.
  @$pb.TagNumber(1)
  $pb.PbList<$2.Peer> get peers => $_getList(0);
}

/// Returns a list of all known short channel IDs in the network graph.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/graph/struct.NetworkGraph.html#method.list_channels
class GraphListChannelsRequest extends $pb.GeneratedMessage {
  factory GraphListChannelsRequest() => create();
  GraphListChannelsRequest._() : super();
  factory GraphListChannelsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphListChannelsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphListChannelsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphListChannelsRequest clone() => GraphListChannelsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphListChannelsRequest copyWith(void Function(GraphListChannelsRequest) updates) => super.copyWith((message) => updates(message as GraphListChannelsRequest)) as GraphListChannelsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphListChannelsRequest create() => GraphListChannelsRequest._();
  GraphListChannelsRequest createEmptyInstance() => create();
  static $pb.PbList<GraphListChannelsRequest> createRepeated() => $pb.PbList<GraphListChannelsRequest>();
  @$core.pragma('dart2js:noInline')
  static GraphListChannelsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphListChannelsRequest>(create);
  static GraphListChannelsRequest? _defaultInstance;
}

/// The response for the `GraphListChannels` RPC. On failure, a gRPC error status is returned.
class GraphListChannelsResponse extends $pb.GeneratedMessage {
  factory GraphListChannelsResponse({
    $core.Iterable<$fixnum.Int64>? shortChannelIds,
  }) {
    final $result = create();
    if (shortChannelIds != null) {
      $result.shortChannelIds.addAll(shortChannelIds);
    }
    return $result;
  }
  GraphListChannelsResponse._() : super();
  factory GraphListChannelsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphListChannelsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphListChannelsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'shortChannelIds', $pb.PbFieldType.KU6)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphListChannelsResponse clone() => GraphListChannelsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphListChannelsResponse copyWith(void Function(GraphListChannelsResponse) updates) => super.copyWith((message) => updates(message as GraphListChannelsResponse)) as GraphListChannelsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphListChannelsResponse create() => GraphListChannelsResponse._();
  GraphListChannelsResponse createEmptyInstance() => create();
  static $pb.PbList<GraphListChannelsResponse> createRepeated() => $pb.PbList<GraphListChannelsResponse>();
  @$core.pragma('dart2js:noInline')
  static GraphListChannelsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphListChannelsResponse>(create);
  static GraphListChannelsResponse? _defaultInstance;

  /// List of short channel IDs known to the network graph.
  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get shortChannelIds => $_getList(0);
}

/// Returns information on a channel with the given short channel ID from the network graph.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/graph/struct.NetworkGraph.html#method.channel
class GraphGetChannelRequest extends $pb.GeneratedMessage {
  factory GraphGetChannelRequest({
    $fixnum.Int64? shortChannelId,
  }) {
    final $result = create();
    if (shortChannelId != null) {
      $result.shortChannelId = shortChannelId;
    }
    return $result;
  }
  GraphGetChannelRequest._() : super();
  factory GraphGetChannelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphGetChannelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphGetChannelRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'shortChannelId', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphGetChannelRequest clone() => GraphGetChannelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphGetChannelRequest copyWith(void Function(GraphGetChannelRequest) updates) => super.copyWith((message) => updates(message as GraphGetChannelRequest)) as GraphGetChannelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphGetChannelRequest create() => GraphGetChannelRequest._();
  GraphGetChannelRequest createEmptyInstance() => create();
  static $pb.PbList<GraphGetChannelRequest> createRepeated() => $pb.PbList<GraphGetChannelRequest>();
  @$core.pragma('dart2js:noInline')
  static GraphGetChannelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphGetChannelRequest>(create);
  static GraphGetChannelRequest? _defaultInstance;

  /// The short channel ID to look up.
  @$pb.TagNumber(1)
  $fixnum.Int64 get shortChannelId => $_getI64(0);
  @$pb.TagNumber(1)
  set shortChannelId($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShortChannelId() => $_has(0);
  @$pb.TagNumber(1)
  void clearShortChannelId() => $_clearField(1);
}

/// The response for the `GraphGetChannel` RPC. On failure, a gRPC error status is returned.
class GraphGetChannelResponse extends $pb.GeneratedMessage {
  factory GraphGetChannelResponse({
    $2.GraphChannel? channel,
  }) {
    final $result = create();
    if (channel != null) {
      $result.channel = channel;
    }
    return $result;
  }
  GraphGetChannelResponse._() : super();
  factory GraphGetChannelResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphGetChannelResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphGetChannelResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<$2.GraphChannel>(1, _omitFieldNames ? '' : 'channel', subBuilder: $2.GraphChannel.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphGetChannelResponse clone() => GraphGetChannelResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphGetChannelResponse copyWith(void Function(GraphGetChannelResponse) updates) => super.copyWith((message) => updates(message as GraphGetChannelResponse)) as GraphGetChannelResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphGetChannelResponse create() => GraphGetChannelResponse._();
  GraphGetChannelResponse createEmptyInstance() => create();
  static $pb.PbList<GraphGetChannelResponse> createRepeated() => $pb.PbList<GraphGetChannelResponse>();
  @$core.pragma('dart2js:noInline')
  static GraphGetChannelResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphGetChannelResponse>(create);
  static GraphGetChannelResponse? _defaultInstance;

  /// The channel information.
  @$pb.TagNumber(1)
  $2.GraphChannel get channel => $_getN(0);
  @$pb.TagNumber(1)
  set channel($2.GraphChannel v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasChannel() => $_has(0);
  @$pb.TagNumber(1)
  void clearChannel() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.GraphChannel ensureChannel() => $_ensure(0);
}

/// Returns a list of all known node IDs in the network graph.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/graph/struct.NetworkGraph.html#method.list_nodes
class GraphListNodesRequest extends $pb.GeneratedMessage {
  factory GraphListNodesRequest() => create();
  GraphListNodesRequest._() : super();
  factory GraphListNodesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphListNodesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphListNodesRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphListNodesRequest clone() => GraphListNodesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphListNodesRequest copyWith(void Function(GraphListNodesRequest) updates) => super.copyWith((message) => updates(message as GraphListNodesRequest)) as GraphListNodesRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphListNodesRequest create() => GraphListNodesRequest._();
  GraphListNodesRequest createEmptyInstance() => create();
  static $pb.PbList<GraphListNodesRequest> createRepeated() => $pb.PbList<GraphListNodesRequest>();
  @$core.pragma('dart2js:noInline')
  static GraphListNodesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphListNodesRequest>(create);
  static GraphListNodesRequest? _defaultInstance;
}

/// The response for the `GraphListNodes` RPC. On failure, a gRPC error status is returned.
class GraphListNodesResponse extends $pb.GeneratedMessage {
  factory GraphListNodesResponse({
    $core.Iterable<$core.String>? nodeIds,
  }) {
    final $result = create();
    if (nodeIds != null) {
      $result.nodeIds.addAll(nodeIds);
    }
    return $result;
  }
  GraphListNodesResponse._() : super();
  factory GraphListNodesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphListNodesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphListNodesResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'nodeIds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphListNodesResponse clone() => GraphListNodesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphListNodesResponse copyWith(void Function(GraphListNodesResponse) updates) => super.copyWith((message) => updates(message as GraphListNodesResponse)) as GraphListNodesResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphListNodesResponse create() => GraphListNodesResponse._();
  GraphListNodesResponse createEmptyInstance() => create();
  static $pb.PbList<GraphListNodesResponse> createRepeated() => $pb.PbList<GraphListNodesResponse>();
  @$core.pragma('dart2js:noInline')
  static GraphListNodesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphListNodesResponse>(create);
  static GraphListNodesResponse? _defaultInstance;

  /// List of hex-encoded node IDs known to the network graph.
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get nodeIds => $_getList(0);
}

///  Send a payment given a BIP 21 URI or BIP 353 Human-Readable Name.
///
///  This method parses the provided URI string and attempts to send the payment. If the URI
///  has an offer and/or invoice, it will try to pay the offer first followed by the invoice.
///  If they both fail, the on-chain payment will be paid.
///  See more: https://docs.rs/ldk-node/latest/ldk_node/payment/struct.UnifiedPayment.html#method.send
class UnifiedSendRequest extends $pb.GeneratedMessage {
  factory UnifiedSendRequest({
    $core.String? uri,
    $fixnum.Int64? amountMsat,
    $2.RouteParametersConfig? routeParameters,
  }) {
    final $result = create();
    if (uri != null) {
      $result.uri = uri;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (routeParameters != null) {
      $result.routeParameters = routeParameters;
    }
    return $result;
  }
  UnifiedSendRequest._() : super();
  factory UnifiedSendRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnifiedSendRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnifiedSendRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uri')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.RouteParametersConfig>(3, _omitFieldNames ? '' : 'routeParameters', subBuilder: $2.RouteParametersConfig.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnifiedSendRequest clone() => UnifiedSendRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnifiedSendRequest copyWith(void Function(UnifiedSendRequest) updates) => super.copyWith((message) => updates(message as UnifiedSendRequest)) as UnifiedSendRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnifiedSendRequest create() => UnifiedSendRequest._();
  UnifiedSendRequest createEmptyInstance() => create();
  static $pb.PbList<UnifiedSendRequest> createRepeated() => $pb.PbList<UnifiedSendRequest>();
  @$core.pragma('dart2js:noInline')
  static UnifiedSendRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnifiedSendRequest>(create);
  static UnifiedSendRequest? _defaultInstance;

  /// A BIP 21 URI or BIP 353 Human-Readable Name to pay.
  @$pb.TagNumber(1)
  $core.String get uri => $_getSZ(0);
  @$pb.TagNumber(1)
  set uri($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUri() => $_has(0);
  @$pb.TagNumber(1)
  void clearUri() => $_clearField(1);

  /// The amount in millisatoshis to send. Required for "zero-amount" or variable-amount URIs.
  @$pb.TagNumber(2)
  $fixnum.Int64 get amountMsat => $_getI64(1);
  @$pb.TagNumber(2)
  set amountMsat($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAmountMsat() => $_has(1);
  @$pb.TagNumber(2)
  void clearAmountMsat() => $_clearField(2);

  /// Configuration options for payment routing and pathfinding.
  @$pb.TagNumber(3)
  $2.RouteParametersConfig get routeParameters => $_getN(2);
  @$pb.TagNumber(3)
  set routeParameters($2.RouteParametersConfig v) { $_setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasRouteParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearRouteParameters() => $_clearField(3);
  @$pb.TagNumber(3)
  $2.RouteParametersConfig ensureRouteParameters() => $_ensure(2);
}

enum UnifiedSendResponse_PaymentResult {
  txid, 
  bolt11PaymentId, 
  bolt12PaymentId, 
  notSet
}

/// The response for the `UnifiedSend` RPC. On failure, a gRPC error status is returned.
class UnifiedSendResponse extends $pb.GeneratedMessage {
  factory UnifiedSendResponse({
    $core.String? txid,
    $core.String? bolt11PaymentId,
    $core.String? bolt12PaymentId,
  }) {
    final $result = create();
    if (txid != null) {
      $result.txid = txid;
    }
    if (bolt11PaymentId != null) {
      $result.bolt11PaymentId = bolt11PaymentId;
    }
    if (bolt12PaymentId != null) {
      $result.bolt12PaymentId = bolt12PaymentId;
    }
    return $result;
  }
  UnifiedSendResponse._() : super();
  factory UnifiedSendResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UnifiedSendResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, UnifiedSendResponse_PaymentResult> _UnifiedSendResponse_PaymentResultByTag = {
    1 : UnifiedSendResponse_PaymentResult.txid,
    2 : UnifiedSendResponse_PaymentResult.bolt11PaymentId,
    3 : UnifiedSendResponse_PaymentResult.bolt12PaymentId,
    0 : UnifiedSendResponse_PaymentResult.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnifiedSendResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..oo(0, [1, 2, 3])
    ..aOS(1, _omitFieldNames ? '' : 'txid')
    ..aOS(2, _omitFieldNames ? '' : 'bolt11PaymentId')
    ..aOS(3, _omitFieldNames ? '' : 'bolt12PaymentId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UnifiedSendResponse clone() => UnifiedSendResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UnifiedSendResponse copyWith(void Function(UnifiedSendResponse) updates) => super.copyWith((message) => updates(message as UnifiedSendResponse)) as UnifiedSendResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnifiedSendResponse create() => UnifiedSendResponse._();
  UnifiedSendResponse createEmptyInstance() => create();
  static $pb.PbList<UnifiedSendResponse> createRepeated() => $pb.PbList<UnifiedSendResponse>();
  @$core.pragma('dart2js:noInline')
  static UnifiedSendResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnifiedSendResponse>(create);
  static UnifiedSendResponse? _defaultInstance;

  UnifiedSendResponse_PaymentResult whichPaymentResult() => _UnifiedSendResponse_PaymentResultByTag[$_whichOneof(0)]!;
  void clearPaymentResult() => $_clearField($_whichOneof(0));

  /// An on-chain payment was made. Contains the transaction ID.
  @$pb.TagNumber(1)
  $core.String get txid => $_getSZ(0);
  @$pb.TagNumber(1)
  set txid($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTxid() => $_has(0);
  @$pb.TagNumber(1)
  void clearTxid() => $_clearField(1);

  /// A BOLT11 payment was made. Contains the payment ID in hex-encoded form.
  @$pb.TagNumber(2)
  $core.String get bolt11PaymentId => $_getSZ(1);
  @$pb.TagNumber(2)
  set bolt11PaymentId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBolt11PaymentId() => $_has(1);
  @$pb.TagNumber(2)
  void clearBolt11PaymentId() => $_clearField(2);

  /// A BOLT12 payment was made. Contains the payment ID in hex-encoded form.
  @$pb.TagNumber(3)
  $core.String get bolt12PaymentId => $_getSZ(2);
  @$pb.TagNumber(3)
  set bolt12PaymentId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBolt12PaymentId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBolt12PaymentId() => $_clearField(3);
}

/// Returns information on a node with the given ID from the network graph.
/// See more: https://docs.rs/ldk-node/latest/ldk_node/graph/struct.NetworkGraph.html#method.node
class GraphGetNodeRequest extends $pb.GeneratedMessage {
  factory GraphGetNodeRequest({
    $core.String? nodeId,
  }) {
    final $result = create();
    if (nodeId != null) {
      $result.nodeId = nodeId;
    }
    return $result;
  }
  GraphGetNodeRequest._() : super();
  factory GraphGetNodeRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphGetNodeRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphGetNodeRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'nodeId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphGetNodeRequest clone() => GraphGetNodeRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphGetNodeRequest copyWith(void Function(GraphGetNodeRequest) updates) => super.copyWith((message) => updates(message as GraphGetNodeRequest)) as GraphGetNodeRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphGetNodeRequest create() => GraphGetNodeRequest._();
  GraphGetNodeRequest createEmptyInstance() => create();
  static $pb.PbList<GraphGetNodeRequest> createRepeated() => $pb.PbList<GraphGetNodeRequest>();
  @$core.pragma('dart2js:noInline')
  static GraphGetNodeRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphGetNodeRequest>(create);
  static GraphGetNodeRequest? _defaultInstance;

  /// The hex-encoded node ID to look up.
  @$pb.TagNumber(1)
  $core.String get nodeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set nodeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNodeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearNodeId() => $_clearField(1);
}

/// The response for the `GraphGetNode` RPC. On failure, a gRPC error status is returned.
class GraphGetNodeResponse extends $pb.GeneratedMessage {
  factory GraphGetNodeResponse({
    $2.GraphNode? node,
  }) {
    final $result = create();
    if (node != null) {
      $result.node = node;
    }
    return $result;
  }
  GraphGetNodeResponse._() : super();
  factory GraphGetNodeResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GraphGetNodeResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GraphGetNodeResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOM<$2.GraphNode>(1, _omitFieldNames ? '' : 'node', subBuilder: $2.GraphNode.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GraphGetNodeResponse clone() => GraphGetNodeResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GraphGetNodeResponse copyWith(void Function(GraphGetNodeResponse) updates) => super.copyWith((message) => updates(message as GraphGetNodeResponse)) as GraphGetNodeResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GraphGetNodeResponse create() => GraphGetNodeResponse._();
  GraphGetNodeResponse createEmptyInstance() => create();
  static $pb.PbList<GraphGetNodeResponse> createRepeated() => $pb.PbList<GraphGetNodeResponse>();
  @$core.pragma('dart2js:noInline')
  static GraphGetNodeResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GraphGetNodeResponse>(create);
  static GraphGetNodeResponse? _defaultInstance;

  /// The node information.
  @$pb.TagNumber(1)
  $2.GraphNode get node => $_getN(0);
  @$pb.TagNumber(1)
  set node($2.GraphNode v) { $_setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNode() => $_has(0);
  @$pb.TagNumber(1)
  void clearNode() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.GraphNode ensureNode() => $_ensure(0);
}

/// Decode a BOLT11 invoice and return its parsed fields.
/// This does not require a running node — it only parses the invoice string.
class DecodeInvoiceRequest extends $pb.GeneratedMessage {
  factory DecodeInvoiceRequest({
    $core.String? invoice,
  }) {
    final $result = create();
    if (invoice != null) {
      $result.invoice = invoice;
    }
    return $result;
  }
  DecodeInvoiceRequest._() : super();
  factory DecodeInvoiceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeInvoiceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeInvoiceRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'invoice')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeInvoiceRequest clone() => DecodeInvoiceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeInvoiceRequest copyWith(void Function(DecodeInvoiceRequest) updates) => super.copyWith((message) => updates(message as DecodeInvoiceRequest)) as DecodeInvoiceRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeInvoiceRequest create() => DecodeInvoiceRequest._();
  DecodeInvoiceRequest createEmptyInstance() => create();
  static $pb.PbList<DecodeInvoiceRequest> createRepeated() => $pb.PbList<DecodeInvoiceRequest>();
  @$core.pragma('dart2js:noInline')
  static DecodeInvoiceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeInvoiceRequest>(create);
  static DecodeInvoiceRequest? _defaultInstance;

  /// The BOLT11 invoice string to decode.
  @$pb.TagNumber(1)
  $core.String get invoice => $_getSZ(0);
  @$pb.TagNumber(1)
  set invoice($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInvoice() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvoice() => $_clearField(1);
}

/// The response for the `DecodeInvoice` RPC. On failure, a gRPC error status is returned.
class DecodeInvoiceResponse extends $pb.GeneratedMessage {
  factory DecodeInvoiceResponse({
    $core.String? destination,
    $core.String? paymentHash,
    $fixnum.Int64? amountMsat,
    $fixnum.Int64? timestamp,
    $fixnum.Int64? expiry,
    $core.String? description,
    $core.String? fallbackAddress,
    $fixnum.Int64? minFinalCltvExpiryDelta,
    $core.String? paymentSecret,
    $core.Iterable<$2.Bolt11RouteHint>? routeHints,
    $pb.PbMap<$core.int, $2.Feature>? features,
    $core.String? currency,
    $core.String? paymentMetadata,
    $core.String? descriptionHash,
    $core.bool? isExpired,
  }) {
    final $result = create();
    if (destination != null) {
      $result.destination = destination;
    }
    if (paymentHash != null) {
      $result.paymentHash = paymentHash;
    }
    if (amountMsat != null) {
      $result.amountMsat = amountMsat;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (expiry != null) {
      $result.expiry = expiry;
    }
    if (description != null) {
      $result.description = description;
    }
    if (fallbackAddress != null) {
      $result.fallbackAddress = fallbackAddress;
    }
    if (minFinalCltvExpiryDelta != null) {
      $result.minFinalCltvExpiryDelta = minFinalCltvExpiryDelta;
    }
    if (paymentSecret != null) {
      $result.paymentSecret = paymentSecret;
    }
    if (routeHints != null) {
      $result.routeHints.addAll(routeHints);
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (currency != null) {
      $result.currency = currency;
    }
    if (paymentMetadata != null) {
      $result.paymentMetadata = paymentMetadata;
    }
    if (descriptionHash != null) {
      $result.descriptionHash = descriptionHash;
    }
    if (isExpired != null) {
      $result.isExpired = isExpired;
    }
    return $result;
  }
  DecodeInvoiceResponse._() : super();
  factory DecodeInvoiceResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeInvoiceResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeInvoiceResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'destination')
    ..aOS(2, _omitFieldNames ? '' : 'paymentHash')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'amountMsat', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'expiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'description')
    ..aOS(7, _omitFieldNames ? '' : 'fallbackAddress')
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'minFinalCltvExpiryDelta', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(9, _omitFieldNames ? '' : 'paymentSecret')
    ..pc<$2.Bolt11RouteHint>(10, _omitFieldNames ? '' : 'routeHints', $pb.PbFieldType.PM, subBuilder: $2.Bolt11RouteHint.create)
    ..m<$core.int, $2.Feature>(11, _omitFieldNames ? '' : 'features', entryClassName: 'DecodeInvoiceResponse.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: $2.Feature.create, valueDefaultOrMaker: $2.Feature.getDefault, packageName: const $pb.PackageName('api'))
    ..aOS(12, _omitFieldNames ? '' : 'currency')
    ..aOS(13, _omitFieldNames ? '' : 'paymentMetadata')
    ..aOS(14, _omitFieldNames ? '' : 'descriptionHash')
    ..aOB(15, _omitFieldNames ? '' : 'isExpired')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeInvoiceResponse clone() => DecodeInvoiceResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeInvoiceResponse copyWith(void Function(DecodeInvoiceResponse) updates) => super.copyWith((message) => updates(message as DecodeInvoiceResponse)) as DecodeInvoiceResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeInvoiceResponse create() => DecodeInvoiceResponse._();
  DecodeInvoiceResponse createEmptyInstance() => create();
  static $pb.PbList<DecodeInvoiceResponse> createRepeated() => $pb.PbList<DecodeInvoiceResponse>();
  @$core.pragma('dart2js:noInline')
  static DecodeInvoiceResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeInvoiceResponse>(create);
  static DecodeInvoiceResponse? _defaultInstance;

  /// The hex-encoded public key of the destination node.
  @$pb.TagNumber(1)
  $core.String get destination => $_getSZ(0);
  @$pb.TagNumber(1)
  set destination($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDestination() => $_has(0);
  @$pb.TagNumber(1)
  void clearDestination() => $_clearField(1);

  /// The hex-encoded 32-byte payment hash.
  @$pb.TagNumber(2)
  $core.String get paymentHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set paymentHash($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPaymentHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearPaymentHash() => $_clearField(2);

  /// The amount in millisatoshis, if specified in the invoice.
  @$pb.TagNumber(3)
  $fixnum.Int64 get amountMsat => $_getI64(2);
  @$pb.TagNumber(3)
  set amountMsat($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAmountMsat() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmountMsat() => $_clearField(3);

  /// The creation timestamp in seconds since the UNIX epoch.
  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);

  /// The invoice expiry time in seconds.
  @$pb.TagNumber(5)
  $fixnum.Int64 get expiry => $_getI64(4);
  @$pb.TagNumber(5)
  set expiry($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasExpiry() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiry() => $_clearField(5);

  /// The invoice description, if a direct description was provided.
  @$pb.TagNumber(6)
  $core.String get description => $_getSZ(5);
  @$pb.TagNumber(6)
  set description($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDescription() => $_has(5);
  @$pb.TagNumber(6)
  void clearDescription() => $_clearField(6);

  /// The fallback on-chain address, if any.
  @$pb.TagNumber(7)
  $core.String get fallbackAddress => $_getSZ(6);
  @$pb.TagNumber(7)
  set fallbackAddress($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasFallbackAddress() => $_has(6);
  @$pb.TagNumber(7)
  void clearFallbackAddress() => $_clearField(7);

  /// The minimum final CLTV expiry delta.
  @$pb.TagNumber(8)
  $fixnum.Int64 get minFinalCltvExpiryDelta => $_getI64(7);
  @$pb.TagNumber(8)
  set minFinalCltvExpiryDelta($fixnum.Int64 v) { $_setInt64(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasMinFinalCltvExpiryDelta() => $_has(7);
  @$pb.TagNumber(8)
  void clearMinFinalCltvExpiryDelta() => $_clearField(8);

  /// The hex-encoded 32-byte payment secret.
  @$pb.TagNumber(9)
  $core.String get paymentSecret => $_getSZ(8);
  @$pb.TagNumber(9)
  set paymentSecret($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasPaymentSecret() => $_has(8);
  @$pb.TagNumber(9)
  void clearPaymentSecret() => $_clearField(9);

  /// Route hints for finding a path to the payee.
  @$pb.TagNumber(10)
  $pb.PbList<$2.Bolt11RouteHint> get routeHints => $_getList(9);

  /// Features advertised in the invoice, keyed by the signaled BOLT feature bit.
  @$pb.TagNumber(11)
  $pb.PbMap<$core.int, $2.Feature> get features => $_getMap(10);

  /// The currency or network (e.g., "bitcoin", "testnet", "signet", "regtest").
  @$pb.TagNumber(12)
  $core.String get currency => $_getSZ(11);
  @$pb.TagNumber(12)
  set currency($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCurrency() => $_has(11);
  @$pb.TagNumber(12)
  void clearCurrency() => $_clearField(12);

  /// The payment metadata, hex-encoded. Only present if the invoice includes payment metadata.
  @$pb.TagNumber(13)
  $core.String get paymentMetadata => $_getSZ(12);
  @$pb.TagNumber(13)
  set paymentMetadata($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasPaymentMetadata() => $_has(12);
  @$pb.TagNumber(13)
  void clearPaymentMetadata() => $_clearField(13);

  /// The hex-encoded SHA-256 hash of the description, if a description hash was used.
  @$pb.TagNumber(14)
  $core.String get descriptionHash => $_getSZ(13);
  @$pb.TagNumber(14)
  set descriptionHash($core.String v) { $_setString(13, v); }
  @$pb.TagNumber(14)
  $core.bool hasDescriptionHash() => $_has(13);
  @$pb.TagNumber(14)
  void clearDescriptionHash() => $_clearField(14);

  /// Whether the invoice has expired.
  @$pb.TagNumber(15)
  $core.bool get isExpired => $_getBF(14);
  @$pb.TagNumber(15)
  set isExpired($core.bool v) { $_setBool(14, v); }
  @$pb.TagNumber(15)
  $core.bool hasIsExpired() => $_has(14);
  @$pb.TagNumber(15)
  void clearIsExpired() => $_clearField(15);
}

/// Decode a BOLT12 offer and return its parsed fields.
/// This does not require a running node — it only parses the offer string.
class DecodeOfferRequest extends $pb.GeneratedMessage {
  factory DecodeOfferRequest({
    $core.String? offer,
  }) {
    final $result = create();
    if (offer != null) {
      $result.offer = offer;
    }
    return $result;
  }
  DecodeOfferRequest._() : super();
  factory DecodeOfferRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeOfferRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeOfferRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offer')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeOfferRequest clone() => DecodeOfferRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeOfferRequest copyWith(void Function(DecodeOfferRequest) updates) => super.copyWith((message) => updates(message as DecodeOfferRequest)) as DecodeOfferRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeOfferRequest create() => DecodeOfferRequest._();
  DecodeOfferRequest createEmptyInstance() => create();
  static $pb.PbList<DecodeOfferRequest> createRepeated() => $pb.PbList<DecodeOfferRequest>();
  @$core.pragma('dart2js:noInline')
  static DecodeOfferRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeOfferRequest>(create);
  static DecodeOfferRequest? _defaultInstance;

  /// The BOLT12 offer string to decode.
  @$pb.TagNumber(1)
  $core.String get offer => $_getSZ(0);
  @$pb.TagNumber(1)
  set offer($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOffer() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffer() => $_clearField(1);
}

/// The response for the `DecodeOffer` RPC. On failure, a gRPC error status is returned.
class DecodeOfferResponse extends $pb.GeneratedMessage {
  factory DecodeOfferResponse({
    $core.String? offerId,
    $core.String? description,
    $core.String? issuer,
    $2.OfferAmount? amount,
    $core.String? issuerSigningPubkey,
    $fixnum.Int64? absoluteExpiry,
    $2.OfferQuantity? quantity,
    $core.Iterable<$2.BlindedPath>? paths,
    $pb.PbMap<$core.int, $2.Feature>? features,
    $core.Iterable<$core.String>? chains,
    $core.String? metadata,
    $core.bool? isExpired,
  }) {
    final $result = create();
    if (offerId != null) {
      $result.offerId = offerId;
    }
    if (description != null) {
      $result.description = description;
    }
    if (issuer != null) {
      $result.issuer = issuer;
    }
    if (amount != null) {
      $result.amount = amount;
    }
    if (issuerSigningPubkey != null) {
      $result.issuerSigningPubkey = issuerSigningPubkey;
    }
    if (absoluteExpiry != null) {
      $result.absoluteExpiry = absoluteExpiry;
    }
    if (quantity != null) {
      $result.quantity = quantity;
    }
    if (paths != null) {
      $result.paths.addAll(paths);
    }
    if (features != null) {
      $result.features.addAll(features);
    }
    if (chains != null) {
      $result.chains.addAll(chains);
    }
    if (metadata != null) {
      $result.metadata = metadata;
    }
    if (isExpired != null) {
      $result.isExpired = isExpired;
    }
    return $result;
  }
  DecodeOfferResponse._() : super();
  factory DecodeOfferResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DecodeOfferResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DecodeOfferResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'offerId')
    ..aOS(2, _omitFieldNames ? '' : 'description')
    ..aOS(3, _omitFieldNames ? '' : 'issuer')
    ..aOM<$2.OfferAmount>(4, _omitFieldNames ? '' : 'amount', subBuilder: $2.OfferAmount.create)
    ..aOS(5, _omitFieldNames ? '' : 'issuerSigningPubkey')
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'absoluteExpiry', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.OfferQuantity>(7, _omitFieldNames ? '' : 'quantity', subBuilder: $2.OfferQuantity.create)
    ..pc<$2.BlindedPath>(8, _omitFieldNames ? '' : 'paths', $pb.PbFieldType.PM, subBuilder: $2.BlindedPath.create)
    ..m<$core.int, $2.Feature>(9, _omitFieldNames ? '' : 'features', entryClassName: 'DecodeOfferResponse.FeaturesEntry', keyFieldType: $pb.PbFieldType.OU3, valueFieldType: $pb.PbFieldType.OM, valueCreator: $2.Feature.create, valueDefaultOrMaker: $2.Feature.getDefault, packageName: const $pb.PackageName('api'))
    ..pPS(10, _omitFieldNames ? '' : 'chains')
    ..aOS(11, _omitFieldNames ? '' : 'metadata')
    ..aOB(12, _omitFieldNames ? '' : 'isExpired')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DecodeOfferResponse clone() => DecodeOfferResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DecodeOfferResponse copyWith(void Function(DecodeOfferResponse) updates) => super.copyWith((message) => updates(message as DecodeOfferResponse)) as DecodeOfferResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DecodeOfferResponse create() => DecodeOfferResponse._();
  DecodeOfferResponse createEmptyInstance() => create();
  static $pb.PbList<DecodeOfferResponse> createRepeated() => $pb.PbList<DecodeOfferResponse>();
  @$core.pragma('dart2js:noInline')
  static DecodeOfferResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DecodeOfferResponse>(create);
  static DecodeOfferResponse? _defaultInstance;

  /// The hex-encoded offer ID.
  @$pb.TagNumber(1)
  $core.String get offerId => $_getSZ(0);
  @$pb.TagNumber(1)
  set offerId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOfferId() => $_has(0);
  @$pb.TagNumber(1)
  void clearOfferId() => $_clearField(1);

  /// The description of the offer, if any.
  @$pb.TagNumber(2)
  $core.String get description => $_getSZ(1);
  @$pb.TagNumber(2)
  set description($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDescription() => $_has(1);
  @$pb.TagNumber(2)
  void clearDescription() => $_clearField(2);

  /// The issuer of the offer, if any.
  @$pb.TagNumber(3)
  $core.String get issuer => $_getSZ(2);
  @$pb.TagNumber(3)
  set issuer($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIssuer() => $_has(2);
  @$pb.TagNumber(3)
  void clearIssuer() => $_clearField(3);

  /// The amount, if specified.
  @$pb.TagNumber(4)
  $2.OfferAmount get amount => $_getN(3);
  @$pb.TagNumber(4)
  set amount($2.OfferAmount v) { $_setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearAmount() => $_clearField(4);
  @$pb.TagNumber(4)
  $2.OfferAmount ensureAmount() => $_ensure(3);

  /// The hex-encoded public key used by the issuer to sign invoices, if any.
  @$pb.TagNumber(5)
  $core.String get issuerSigningPubkey => $_getSZ(4);
  @$pb.TagNumber(5)
  set issuerSigningPubkey($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIssuerSigningPubkey() => $_has(4);
  @$pb.TagNumber(5)
  void clearIssuerSigningPubkey() => $_clearField(5);

  /// The absolute expiry time in seconds since the UNIX epoch, if any.
  @$pb.TagNumber(6)
  $fixnum.Int64 get absoluteExpiry => $_getI64(5);
  @$pb.TagNumber(6)
  set absoluteExpiry($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAbsoluteExpiry() => $_has(5);
  @$pb.TagNumber(6)
  void clearAbsoluteExpiry() => $_clearField(6);

  /// The supported quantity of items.
  @$pb.TagNumber(7)
  $2.OfferQuantity get quantity => $_getN(6);
  @$pb.TagNumber(7)
  set quantity($2.OfferQuantity v) { $_setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasQuantity() => $_has(6);
  @$pb.TagNumber(7)
  void clearQuantity() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.OfferQuantity ensureQuantity() => $_ensure(6);

  /// Blinded paths to the offer recipient.
  @$pb.TagNumber(8)
  $pb.PbList<$2.BlindedPath> get paths => $_getList(7);

  /// Features advertised in the offer, keyed by the signaled BOLT feature bit.
  @$pb.TagNumber(9)
  $pb.PbMap<$core.int, $2.Feature> get features => $_getMap(8);

  /// Supported blockchain networks (e.g., "bitcoin", "testnet", "signet", "regtest").
  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get chains => $_getList(9);

  /// The metadata, hex-encoded, if any.
  @$pb.TagNumber(11)
  $core.String get metadata => $_getSZ(10);
  @$pb.TagNumber(11)
  set metadata($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasMetadata() => $_has(10);
  @$pb.TagNumber(11)
  void clearMetadata() => $_clearField(11);

  /// Whether the offer has expired.
  @$pb.TagNumber(12)
  $core.bool get isExpired => $_getBF(11);
  @$pb.TagNumber(12)
  set isExpired($core.bool v) { $_setBool(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasIsExpired() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsExpired() => $_clearField(12);
}

/// Subscribe to a stream of server events.
class SubscribeEventsRequest extends $pb.GeneratedMessage {
  factory SubscribeEventsRequest() => create();
  SubscribeEventsRequest._() : super();
  factory SubscribeEventsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SubscribeEventsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SubscribeEventsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SubscribeEventsRequest clone() => SubscribeEventsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SubscribeEventsRequest copyWith(void Function(SubscribeEventsRequest) updates) => super.copyWith((message) => updates(message as SubscribeEventsRequest)) as SubscribeEventsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SubscribeEventsRequest create() => SubscribeEventsRequest._();
  SubscribeEventsRequest createEmptyInstance() => create();
  static $pb.PbList<SubscribeEventsRequest> createRepeated() => $pb.PbList<SubscribeEventsRequest>();
  @$core.pragma('dart2js:noInline')
  static SubscribeEventsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SubscribeEventsRequest>(create);
  static SubscribeEventsRequest? _defaultInstance;
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
