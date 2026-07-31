import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';

/// YouTube Downloader per docs/MOBILE_APP_GUIDE.md §5.10 — the highest-value
/// mobile tool. Flow: info → pick format → server job → signed file URL.
class YouTubeDownloadRepository {
  final ApiClient _apiClient;

  YouTubeDownloadRepository(this._apiClient);

  /// `{url}` → `{title, thumbnail, duration, formats[]}`
  Future<Map<String, dynamic>> getInfo(String url) async {
    try {
      return await _apiClient.postObject(
        Endpoints.youtubeDownloaderInfo,
        data: {'url': url},
        decoder: (json) => json,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// `{url, format_id}` → `{download_id}`
  Future<String> startDownload(String url, String formatId) async {
    try {
      final result = await _apiClient.postObject(
        Endpoints.youtubeDownloaderDownload,
        data: {'url': url, 'format_id': formatId},
        decoder: (json) => json,
      );
      return result['download_id'] as String? ?? '';
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// `{status, progress, error}`
  Future<Map<String, dynamic>> getStatus(String downloadId) async {
    try {
      return await _apiClient.getObject(
        Endpoints.youtubeDownloaderStatusWith(downloadId),
        decoder: (json) => json,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// Signed file URL for the finished download.
  Future<String> getFileUrl(String downloadId) async {
    try {
      final result = await _apiClient.getObject(
        Endpoints.youtubeDownloaderFileWith(downloadId),
        decoder: (json) => json,
      );
      return result['url'] as String? ?? '';
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
