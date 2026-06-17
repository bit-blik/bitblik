/// JSON-RPC style envelope exchanged inside encrypted Nostr events
/// (kinds [kKindCoordinatorRequest] and [kKindCoordinatorResponse]).

class NostrRequest {
  final String method;
  final Map<String, dynamic> params;
  final String? id;

  /// Identifies the client that issued the request, as `<app|cli>/<version>`
  /// (e.g. `app/0.8.0`, `cli/0.1.0`). Set centrally by [BitblikRpcClient] so the
  /// coordinator can attribute requests to a client build. Optional for
  /// backward compatibility with older clients that don't send it.
  final String? client;

  const NostrRequest({
    required this.method,
    required this.params,
    this.id,
    this.client,
  });

  Map<String, dynamic> toJson() => {
        'method': method,
        'params': params,
        if (id != null) 'id': id,
        if (client != null) 'client': client,
      };

  factory NostrRequest.fromJson(Map<String, dynamic> json) {
    return NostrRequest(
      method: json['method'] as String,
      params: (json['params'] as Map?)?.cast<String, dynamic>() ?? const {},
      id: json['id'] as String?,
      client: json['client'] as String?,
    );
  }
}

class NostrResponse {
  final String? id;
  final Map<String, dynamic>? result;
  final Map<String, dynamic>? error;

  const NostrResponse({this.id, this.result, this.error});

  factory NostrResponse.fromJson(Map<String, dynamic> json) {
    return NostrResponse(
      id: json['id'] as String?,
      result: (json['result'] as Map?)?.cast<String, dynamic>(),
      error: (json['error'] as Map?)?.cast<String, dynamic>(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (result != null) 'result': result,
        if (error != null) 'error': error,
      };

  bool get isSuccess => error == null;
}
