import 'package:dio/dio.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_response.dart';
import 'package:vidspod_mobile/core/api/interceptors/auth_interceptor.dart';
import 'package:vidspod_mobile/core/api/interceptors/request_id_log_interceptor.dart';
import 'package:vidspod_mobile/core/api/interceptors/retry_interceptor.dart';
import 'package:vidspod_mobile/core/api/page.dart';
import 'package:vidspod_mobile/core/auth/token_store.dart';

/// Dio-based API client with envelope unwrapping per
/// docs/MOBILE_APP_GUIDE.md §3.
///
/// Every request goes through:
///  1. [AuthInterceptor] — attaches the bearer token, refreshes once on 401,
///     and replays the request (or hard-logs-out on a second failure).
///  2. [RetryInterceptor] — backs off and retries idempotent GETs on
///     429/5xx/network blips, honoring `Retry-After` (§3.4).
///  3. [RequestIdLogInterceptor] — surfaces `request_id` for bug reports.
///
/// Typed helpers ([getObject]/[getList]/[postObject]/...) unwrap the `data`
/// field from the envelope and throw [ApiException] on any `error`.
class ApiClient {
  late final Dio _dio;

  ApiClient({
    required TokenStore tokenStore,
    Future<void> Function()? onSessionExpired,
    Dio? dio,
  }) {
    _dio =
        dio ??
        Dio(
          BaseOptions(
            baseUrl: Config.apiUrl,
            // Short connect so the "no network" case fails fast instead of
            // hanging (mapped in error_mapper). Uploads get more slack.
            connectTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
          ),
        );

    _dio.interceptors.addAll([
      AuthInterceptor(
        tokenStore: tokenStore,
        dio: _dio,
        onSessionExpired: onSessionExpired,
      ),
      RetryInterceptor(dio: _dio),
      RequestIdLogInterceptor(),
    ]);
  }

  /// Raw Dio handle. Prefer the typed helpers below so responses are
  /// envelope-unwrapped consistently.
  Dio get dio => _dio;

  Future<T> getObject<T>(
    String path, {
    required T Function(Map<String, dynamic> json) decoder,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    return _unwrapObject(response, decoder);
  }

  Future<List<T>> getList<T>(
    String path, {
    required T Function(Map<String, dynamic> json) decoder,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    return _unwrapList(response, decoder);
  }

  Future<T> postObject<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> json) decoder,
    Options? options,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return _unwrapObject(response, decoder);
  }

  Future<List<T>> postList<T>(
    String path, {
    Object? data,
    required T Function(Map<String, dynamic> json) decoder,
    Options? options,
  }) async {
    final response = await _dio.post(path, data: data, options: options);
    return _unwrapList(response, decoder);
  }

  Future<T> patchObject<T>(
    String path, {
    Object? data,
    required T Function(Map<String, dynamic> json) decoder,
    Options? options,
  }) async {
    final response = await _dio.patch(path, data: data, options: options);
    return _unwrapObject(response, decoder);
  }

  Future<void> delete(String path, {Object? data, Options? options}) async {
    final response = await _dio.delete(path, data: data, options: options);
    // Unwrap (and throw on) any envelope error even though we discard the body.
    _extractData(response);
  }

  /// Fetches one page of a paginated list per §3.2. Mirrors both styles:
  ///  - Keyset (projects): `data.items[]` + `data.next_cursor`.
  ///  - Page-number (my-shorts): `data.items[]` + `data.pagination.page`.
  ///
  /// Returns the raw `data` list when the server sends one (a few list
  /// endpoints return a bare array), so callers stay compatible either way.
  Future<Page<T>> getPage<T>(
    String path, {
    required T Function(Map<String, dynamic> json) decoder,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    final payload = _extractData(response);

    if (payload is List) {
      return Page(items: _decodeList(payload, decoder));
    }
    if (payload is Map<String, dynamic>) {
      final items = payload['items'];
      if (items is List) {
        final pagination = payload['pagination'];
        final page = pagination is Map<String, dynamic>
            ? (pagination['page'] as num?)?.toInt()
            : null;
        return Page(
          items: _decodeList(items, decoder),
          nextCursor: payload['next_cursor'] as String?,
          page: page,
        );
      }
    }
    throw const ApiException(
      code: 'bad_data_shape',
      message: 'The server returned an unexpected payload shape.',
    );
  }

  /// Unwraps a single-object payload from the envelope.
  T _unwrapObject<T>(
    Response response,
    T Function(Map<String, dynamic> json) decoder,
  ) {
    final payload = _extractData(response);
    if (payload == null) {
      throw const ApiException(
        code: 'empty_data',
        message: 'The server returned an empty response.',
      );
    }
    if (payload is! Map<String, dynamic>) {
      throw const ApiException(
        code: 'bad_data_shape',
        message: 'The server returned an unexpected payload shape.',
      );
    }
    return decoder(payload);
  }

  List<T> _unwrapList<T>(
    Response response,
    T Function(Map<String, dynamic> json) decoder,
  ) {
    final payload = _extractData(response);
    if (payload == null) return const [];
    if (payload is! List) {
      throw const ApiException(
        code: 'bad_data_shape',
        message: 'The server returned an unexpected payload shape.',
      );
    }
    return _decodeList(payload, decoder);
  }

  List<T> _decodeList<T>(
    List<dynamic> raw,
    T Function(Map<String, dynamic> json) decoder,
  ) {
    return raw.map((item) => decoder(item as Map<String, dynamic>)).toList();
  }

  /// Extracts `data` from the envelope, or throws [ApiException] if the
  /// response carries an `error` block.
  Object? _extractData(Response response) {
    final body = response.data;
    if (body is Map<String, dynamic>) {
      final error = body['error'];
      if (error is Map<String, dynamic>) {
        throw ApiException.fromJson(error);
      }
      return body['data'];
    }
    return body;
  }
}
