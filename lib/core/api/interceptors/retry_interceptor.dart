import 'package:dio/dio.dart';

/// Retries idempotent requests on transient failures per
/// docs/MOBILE_APP_GUIDE.md §3.4.
///
/// - Retries only safe methods (GET) — credit-costing POSTs are never
///   auto-retried, so an offline retry can't double-charge.
/// - On 429 honors the server's `Retry-After`; otherwise exponential backoff.
/// - Never retries auth endpoints (401 handling lives in [AuthInterceptor]).
///
/// Retries replay through the owning client's chain (via `_dio.fetch`), so the
/// replayed request still goes through auth + request-id logging, and each
/// failure re-enters this interceptor with an incremented `retry_count` until
/// [_maxRetries] is reached.
class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int _maxRetries;
  final Duration _baseDelay;

  RetryInterceptor({
    required Dio dio,
    int maxRetries = 2,
    Duration baseDelay = const Duration(milliseconds: 500),
  }) : _dio = dio,
       _maxRetries = maxRetries,
       _baseDelay = baseDelay;

  static const _retriableMethods = ['GET'];
  static const _excludedPaths = ['/auth/'];

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final attempt = (options.extra['retry_count'] as int?) ?? 0;

    if (_shouldRetry(err, options, attempt)) {
      options.extra['retry_count'] = attempt + 1;
      final delay = _backoff(err, attempt);
      await Future<void>.delayed(delay);
      try {
        final response = await _dio.fetch(options);
        handler.resolve(response);
        return;
      } on DioException catch (retryErr) {
        // Re-enter this interceptor for the next backoff; `_shouldRetry`
        // stops once `attempt >= _maxRetries`.
        return onError(retryErr, handler);
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err, RequestOptions options, int attempt) {
    if (attempt >= _maxRetries) return false;
    if (!_retriableMethods.contains(options.method)) return false;
    if (_excludedPaths.any((p) => options.path.startsWith(p))) return false;

    final status = err.response?.statusCode;
    // 429 rate limit, 5xx server errors, or network-level failures.
    if (status == 429) return true;
    if (status != null && status >= 500 && status < 600) return true;
    if (status == null &&
        (err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.sendTimeout)) {
      return true;
    }
    return false;
  }

  Duration _backoff(DioException err, int attempt) {
    final retryAfter = err.response?.headers.value('retry-after');
    final seconds = int.tryParse(retryAfter ?? '');
    if (seconds != null) {
      return Duration(seconds: seconds);
    }
    // Exponential: base * 2^attempt (500ms, 1s, 2s, ...).
    return _baseDelay * (1 << attempt);
  }
}
