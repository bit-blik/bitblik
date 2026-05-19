//
//  Generated code. Do not modify.
//  source: lnd/signer.proto
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

import 'signer.pb.dart' as $5;

export 'signer.pb.dart';

@$pb.GrpcServiceName('signrpc.Signer')
class SignerClient extends $grpc.Client {
  static final _$signOutputRaw = $grpc.ClientMethod<$5.SignReq, $5.SignResp>(
      '/signrpc.Signer/SignOutputRaw',
      ($5.SignReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.SignResp.fromBuffer(value));
  static final _$computeInputScript = $grpc.ClientMethod<$5.SignReq, $5.InputScriptResp>(
      '/signrpc.Signer/ComputeInputScript',
      ($5.SignReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.InputScriptResp.fromBuffer(value));
  static final _$signMessage = $grpc.ClientMethod<$5.SignMessageReq, $5.SignMessageResp>(
      '/signrpc.Signer/SignMessage',
      ($5.SignMessageReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.SignMessageResp.fromBuffer(value));
  static final _$verifyMessage = $grpc.ClientMethod<$5.VerifyMessageReq, $5.VerifyMessageResp>(
      '/signrpc.Signer/VerifyMessage',
      ($5.VerifyMessageReq value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.VerifyMessageResp.fromBuffer(value));
  static final _$deriveSharedKey = $grpc.ClientMethod<$5.SharedKeyRequest, $5.SharedKeyResponse>(
      '/signrpc.Signer/DeriveSharedKey',
      ($5.SharedKeyRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.SharedKeyResponse.fromBuffer(value));
  static final _$muSig2CombineKeys = $grpc.ClientMethod<$5.MuSig2CombineKeysRequest, $5.MuSig2CombineKeysResponse>(
      '/signrpc.Signer/MuSig2CombineKeys',
      ($5.MuSig2CombineKeysRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.MuSig2CombineKeysResponse.fromBuffer(value));
  static final _$muSig2CreateSession = $grpc.ClientMethod<$5.MuSig2SessionRequest, $5.MuSig2SessionResponse>(
      '/signrpc.Signer/MuSig2CreateSession',
      ($5.MuSig2SessionRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.MuSig2SessionResponse.fromBuffer(value));
  static final _$muSig2RegisterNonces = $grpc.ClientMethod<$5.MuSig2RegisterNoncesRequest, $5.MuSig2RegisterNoncesResponse>(
      '/signrpc.Signer/MuSig2RegisterNonces',
      ($5.MuSig2RegisterNoncesRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.MuSig2RegisterNoncesResponse.fromBuffer(value));
  static final _$muSig2Sign = $grpc.ClientMethod<$5.MuSig2SignRequest, $5.MuSig2SignResponse>(
      '/signrpc.Signer/MuSig2Sign',
      ($5.MuSig2SignRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.MuSig2SignResponse.fromBuffer(value));
  static final _$muSig2CombineSig = $grpc.ClientMethod<$5.MuSig2CombineSigRequest, $5.MuSig2CombineSigResponse>(
      '/signrpc.Signer/MuSig2CombineSig',
      ($5.MuSig2CombineSigRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.MuSig2CombineSigResponse.fromBuffer(value));
  static final _$muSig2Cleanup = $grpc.ClientMethod<$5.MuSig2CleanupRequest, $5.MuSig2CleanupResponse>(
      '/signrpc.Signer/MuSig2Cleanup',
      ($5.MuSig2CleanupRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $5.MuSig2CleanupResponse.fromBuffer(value));

  SignerClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$5.SignResp> signOutputRaw($5.SignReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signOutputRaw, request, options: options);
  }

  $grpc.ResponseFuture<$5.InputScriptResp> computeInputScript($5.SignReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$computeInputScript, request, options: options);
  }

  $grpc.ResponseFuture<$5.SignMessageResp> signMessage($5.SignMessageReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$signMessage, request, options: options);
  }

  $grpc.ResponseFuture<$5.VerifyMessageResp> verifyMessage($5.VerifyMessageReq request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$verifyMessage, request, options: options);
  }

  $grpc.ResponseFuture<$5.SharedKeyResponse> deriveSharedKey($5.SharedKeyRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deriveSharedKey, request, options: options);
  }

  $grpc.ResponseFuture<$5.MuSig2CombineKeysResponse> muSig2CombineKeys($5.MuSig2CombineKeysRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muSig2CombineKeys, request, options: options);
  }

  $grpc.ResponseFuture<$5.MuSig2SessionResponse> muSig2CreateSession($5.MuSig2SessionRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muSig2CreateSession, request, options: options);
  }

  $grpc.ResponseFuture<$5.MuSig2RegisterNoncesResponse> muSig2RegisterNonces($5.MuSig2RegisterNoncesRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muSig2RegisterNonces, request, options: options);
  }

  $grpc.ResponseFuture<$5.MuSig2SignResponse> muSig2Sign($5.MuSig2SignRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muSig2Sign, request, options: options);
  }

  $grpc.ResponseFuture<$5.MuSig2CombineSigResponse> muSig2CombineSig($5.MuSig2CombineSigRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muSig2CombineSig, request, options: options);
  }

  $grpc.ResponseFuture<$5.MuSig2CleanupResponse> muSig2Cleanup($5.MuSig2CleanupRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$muSig2Cleanup, request, options: options);
  }
}

@$pb.GrpcServiceName('signrpc.Signer')
abstract class SignerServiceBase extends $grpc.Service {
  $core.String get $name => 'signrpc.Signer';

  SignerServiceBase() {
    $addMethod($grpc.ServiceMethod<$5.SignReq, $5.SignResp>(
        'SignOutputRaw',
        signOutputRaw_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SignReq.fromBuffer(value),
        ($5.SignResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SignReq, $5.InputScriptResp>(
        'ComputeInputScript',
        computeInputScript_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SignReq.fromBuffer(value),
        ($5.InputScriptResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SignMessageReq, $5.SignMessageResp>(
        'SignMessage',
        signMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SignMessageReq.fromBuffer(value),
        ($5.SignMessageResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.VerifyMessageReq, $5.VerifyMessageResp>(
        'VerifyMessage',
        verifyMessage_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.VerifyMessageReq.fromBuffer(value),
        ($5.VerifyMessageResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.SharedKeyRequest, $5.SharedKeyResponse>(
        'DeriveSharedKey',
        deriveSharedKey_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.SharedKeyRequest.fromBuffer(value),
        ($5.SharedKeyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MuSig2CombineKeysRequest, $5.MuSig2CombineKeysResponse>(
        'MuSig2CombineKeys',
        muSig2CombineKeys_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MuSig2CombineKeysRequest.fromBuffer(value),
        ($5.MuSig2CombineKeysResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MuSig2SessionRequest, $5.MuSig2SessionResponse>(
        'MuSig2CreateSession',
        muSig2CreateSession_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MuSig2SessionRequest.fromBuffer(value),
        ($5.MuSig2SessionResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MuSig2RegisterNoncesRequest, $5.MuSig2RegisterNoncesResponse>(
        'MuSig2RegisterNonces',
        muSig2RegisterNonces_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MuSig2RegisterNoncesRequest.fromBuffer(value),
        ($5.MuSig2RegisterNoncesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MuSig2SignRequest, $5.MuSig2SignResponse>(
        'MuSig2Sign',
        muSig2Sign_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MuSig2SignRequest.fromBuffer(value),
        ($5.MuSig2SignResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MuSig2CombineSigRequest, $5.MuSig2CombineSigResponse>(
        'MuSig2CombineSig',
        muSig2CombineSig_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MuSig2CombineSigRequest.fromBuffer(value),
        ($5.MuSig2CombineSigResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.MuSig2CleanupRequest, $5.MuSig2CleanupResponse>(
        'MuSig2Cleanup',
        muSig2Cleanup_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.MuSig2CleanupRequest.fromBuffer(value),
        ($5.MuSig2CleanupResponse value) => value.writeToBuffer()));
  }

  $async.Future<$5.SignResp> signOutputRaw_Pre($grpc.ServiceCall $call, $async.Future<$5.SignReq> $request) async {
    return signOutputRaw($call, await $request);
  }

  $async.Future<$5.InputScriptResp> computeInputScript_Pre($grpc.ServiceCall $call, $async.Future<$5.SignReq> $request) async {
    return computeInputScript($call, await $request);
  }

  $async.Future<$5.SignMessageResp> signMessage_Pre($grpc.ServiceCall $call, $async.Future<$5.SignMessageReq> $request) async {
    return signMessage($call, await $request);
  }

  $async.Future<$5.VerifyMessageResp> verifyMessage_Pre($grpc.ServiceCall $call, $async.Future<$5.VerifyMessageReq> $request) async {
    return verifyMessage($call, await $request);
  }

  $async.Future<$5.SharedKeyResponse> deriveSharedKey_Pre($grpc.ServiceCall $call, $async.Future<$5.SharedKeyRequest> $request) async {
    return deriveSharedKey($call, await $request);
  }

  $async.Future<$5.MuSig2CombineKeysResponse> muSig2CombineKeys_Pre($grpc.ServiceCall $call, $async.Future<$5.MuSig2CombineKeysRequest> $request) async {
    return muSig2CombineKeys($call, await $request);
  }

  $async.Future<$5.MuSig2SessionResponse> muSig2CreateSession_Pre($grpc.ServiceCall $call, $async.Future<$5.MuSig2SessionRequest> $request) async {
    return muSig2CreateSession($call, await $request);
  }

  $async.Future<$5.MuSig2RegisterNoncesResponse> muSig2RegisterNonces_Pre($grpc.ServiceCall $call, $async.Future<$5.MuSig2RegisterNoncesRequest> $request) async {
    return muSig2RegisterNonces($call, await $request);
  }

  $async.Future<$5.MuSig2SignResponse> muSig2Sign_Pre($grpc.ServiceCall $call, $async.Future<$5.MuSig2SignRequest> $request) async {
    return muSig2Sign($call, await $request);
  }

  $async.Future<$5.MuSig2CombineSigResponse> muSig2CombineSig_Pre($grpc.ServiceCall $call, $async.Future<$5.MuSig2CombineSigRequest> $request) async {
    return muSig2CombineSig($call, await $request);
  }

  $async.Future<$5.MuSig2CleanupResponse> muSig2Cleanup_Pre($grpc.ServiceCall $call, $async.Future<$5.MuSig2CleanupRequest> $request) async {
    return muSig2Cleanup($call, await $request);
  }

  $async.Future<$5.SignResp> signOutputRaw($grpc.ServiceCall call, $5.SignReq request);
  $async.Future<$5.InputScriptResp> computeInputScript($grpc.ServiceCall call, $5.SignReq request);
  $async.Future<$5.SignMessageResp> signMessage($grpc.ServiceCall call, $5.SignMessageReq request);
  $async.Future<$5.VerifyMessageResp> verifyMessage($grpc.ServiceCall call, $5.VerifyMessageReq request);
  $async.Future<$5.SharedKeyResponse> deriveSharedKey($grpc.ServiceCall call, $5.SharedKeyRequest request);
  $async.Future<$5.MuSig2CombineKeysResponse> muSig2CombineKeys($grpc.ServiceCall call, $5.MuSig2CombineKeysRequest request);
  $async.Future<$5.MuSig2SessionResponse> muSig2CreateSession($grpc.ServiceCall call, $5.MuSig2SessionRequest request);
  $async.Future<$5.MuSig2RegisterNoncesResponse> muSig2RegisterNonces($grpc.ServiceCall call, $5.MuSig2RegisterNoncesRequest request);
  $async.Future<$5.MuSig2SignResponse> muSig2Sign($grpc.ServiceCall call, $5.MuSig2SignRequest request);
  $async.Future<$5.MuSig2CombineSigResponse> muSig2CombineSig($grpc.ServiceCall call, $5.MuSig2CombineSigRequest request);
  $async.Future<$5.MuSig2CleanupResponse> muSig2Cleanup($grpc.ServiceCall call, $5.MuSig2CleanupRequest request);
}
