import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs requests/responses and surfaces `request_id` for bug reports, per
/// docs/MOBILE_APP_GUIDE.md §3.1.
class RequestIdLogInterceptor extends Interceptor {
  final bool _verbose;
  RequestIdLogInterceptor({bool verbose = true}) : _verbose = verbose;

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (_verbose && data is Map<String, dynamic>) {
      final meta = data['meta'];
      final requestId = meta is Map<String, dynamic>
          ? meta['request_id']
          : null;
      final error = data['error'];
      if (error is Map<String, dynamic>) {
        // Surface request_id on failures so bug reports carry it.
        final errorRequestId = error['request_id'];
        debugLog(
          '[API] ${response.statusCode} ${response.requestOptions.method} '
          '${response.requestOptions.path} error=${error['code']} '
          'request_id=${errorRequestId ?? requestId}',
        );
      } else if (requestId != null) {
        debugLog(
          '[API] ${response.statusCode} ${response.requestOptions.method} '
          '${response.requestOptions.path} request_id=$requestId',
        );
      }
    }
    handler.next(response);
  }

  void debugLog(String message) {
    debugPrint(message);
  }
}
