/// API envelope contract per docs/MOBILE_APP_GUIDE.md §3.1.
///
/// Every API response is wrapped in the same shape:
/// ```jsonc
/// {
///   "data":  { ... },                       // null on error
///   "meta":  { "request_id": "01J..." },
///   "error": { "code", "message", "fields", "request_id" }
/// }
/// ```
/// `ApiClient` unwraps `data` and throws [ApiException] on any `error`;
/// [requestId] must be surfaced in bug reports.
library;

/// API-level failure carrying the server's error contract.
///
/// [code] is the machine-readable error code (`validation_failed`,
/// `insufficient_credits`, ...). [fields] maps form keys to server messages
/// for 422s. [requestId] is always surfaced for bug reports.
class ApiException implements Exception {
  final String code;
  final String message;
  final Map<String, dynamic>? fields;
  final String? requestId;

  const ApiException({
    required this.code,
    required this.message,
    this.fields,
    this.requestId,
  });

  factory ApiException.fromJson(Map<String, dynamic> json) {
    final fields = json['fields'] as Map<String, dynamic>?;
    return ApiException(
      code: json['code'] as String? ?? 'unknown_error',
      message: json['message'] as String? ?? 'Something went wrong',
      fields: fields,
      requestId: json['request_id'] as String?,
    );
  }

  bool get isValidation => code == 'validation_failed' || fields != null;
  bool get isInsufficientCredits => code == 'insufficient_credits';

  @override
  String toString() =>
      'ApiException($code): $message'
      '${requestId != null ? ' [request_id: $requestId]' : ''}';
}
