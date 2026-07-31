import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_response.dart';

/// Maps a [DioException] to the API error contract per
/// docs/MOBILE_APP_GUIDE.md §3.1 / §3.4.
///
/// The server envelope carries `error: {code, message, fields, request_id}`.
/// When the body is not an envelope (network failure, non-JSON), we synthesize
/// a client-side [ApiException] so every error path has the same shape.
ApiException mapDioException(DioException err) {
  final response = err.response;
  final data = response?.data;

  if (data is Map<String, dynamic>) {
    final error = data['error'];
    if (error is Map<String, dynamic>) {
      final apiException = ApiException.fromJson({
        ...error,
        if (error['request_id'] == null && data['meta'] != null)
          'request_id': (data['meta'] as Map<String, dynamic>)['request_id'],
      });
      return apiException;
    }
  }

  // Synthesize from the HTTP status when no envelope is present.
  switch (err.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const ApiException(
        code: 'timeout',
        message: 'The request timed out. Please try again.',
      );
    case DioExceptionType.connectionError:
      return const ApiException(
        code: 'no_connection',
        message: 'No internet connection. Please check your network.',
      );
    case DioExceptionType.cancel:
      return const ApiException(
        code: 'cancelled',
        message: 'Request cancelled.',
      );
    default:
      break;
  }

  switch (response?.statusCode) {
    case 401:
      return const ApiException(
        code: 'unauthorized',
        message: 'Your session has expired. Please sign in again.',
      );
    case 402:
      return const ApiException(
        code: 'insufficient_credits',
        message: 'You do not have enough credits for this action.',
      );
    case 409:
      return const ApiException(
        code: 'conflict',
        message: 'This run changed state. Please refresh and try again.',
      );
    case 429:
      return ApiException(
        code: 'rate_limited',
        message: 'Too many requests. Please try again later.',
        requestId: _retryAfterMs(response),
      );
    default:
      return ApiException(
        code: 'unknown_error',
        message: err.message ?? 'Something went wrong.',
      );
  }
}

/// Surfaces `Retry-After` on 429 responses so callers can honor backoff.
String? _retryAfterMs(Response? response) {
  final header = response?.headers.value('retry-after');
  if (header == null) return null;
  final seconds = int.tryParse(header);
  return seconds != null ? '${seconds * 1000}' : header;
}
