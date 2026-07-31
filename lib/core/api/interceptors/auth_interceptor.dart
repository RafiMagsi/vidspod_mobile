import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_response.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/auth/token_store.dart';

/// Attaches the bearer token, and on a 401 refreshes exactly once and replays
/// the request. A second failure hard-logs-out via [onSessionExpired].
///
/// The refresh request itself is excluded from the retry logic to avoid an
/// infinite loop. Per docs/MOBILE_APP_GUIDE.md §4.
class AuthInterceptor extends QueuedInterceptor {
  final TokenStore _tokenStore;
  final Dio _dio;
  final Future<void> Function()? onSessionExpired;

  /// The in-flight refresh so concurrent 401s share one refresh call.
  Future<void>? _refreshFuture;

  AuthInterceptor({
    required TokenStore tokenStore,
    required Dio dio,
    this.onSessionExpired,
  }) : _tokenStore = tokenStore,
       _dio = dio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _tokenStore.readAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_is401(err) && !_isAuthPath(err.requestOptions.path)) {
      try {
        await _ensureFreshToken();
        // Replay the original request with the (possibly refreshed) token.
        final accessToken = await _tokenStore.readAccessToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      } on DioException catch (e) {
        // Second failure: the session is unrecoverable.
        if (_is401(e)) {
          await _tokenStore.clear();
          await onSessionExpired?.call();
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: const ApiException(
                code: 'session_expired',
                message: 'Your session has expired. Please sign in again.',
              ),
            ),
          );
          return;
        }
      }
    }
    handler.next(err);
  }

  bool _is401(DioException err) => err.response?.statusCode == 401;

  bool _isAuthPath(String path) {
    return path.contains(Endpoints.mobileLogin) ||
        path.contains(Endpoints.login) ||
        path.contains(Endpoints.mobileRefresh) ||
        path.contains(Endpoints.passwordReset) ||
        path.contains(Endpoints.emailVerification);
  }

  /// Ensures a fresh access token. Concurrent callers share a single refresh
  /// so bursts of parallel 401s trigger one refresh, not one per request.
  Future<void> _ensureFreshToken() {
    final inFlight = _refreshFuture;
    if (inFlight != null) return inFlight;

    final future = _doRefresh();
    _refreshFuture = future;
    return future;
  }

  Future<void> _doRefresh() async {
    try {
      final refreshToken = await _tokenStore.readRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        await onSessionExpired?.call();
        throw DioException(
          requestOptions: RequestOptions(path: Endpoints.mobileRefresh),
          error: const ApiException(
            code: 'no_refresh_token',
            message: 'No refresh token available. Please sign in again.',
          ),
        );
      }
      final response = await _dio.post(
        Endpoints.mobileRefresh,
        data: {'refresh_token': refreshToken},
        options: Options(headers: {'Authorization': ''}),
      );
      final data = response.data;
      final access = data is Map<String, dynamic>
          ? data['access_token'] as String?
          : null;
      final refresh = data is Map<String, dynamic>
          ? data['refresh_token'] as String?
          : null;
      if (access == null) {
        throw const ApiException(
          code: 'refresh_failed',
          message: 'Token refresh returned no access token.',
        );
      }
      await _tokenStore.writeTokens(
        access: access,
        refresh: refresh ?? refreshToken,
      );
    } finally {
      _refreshFuture = null;
    }
  }
}
