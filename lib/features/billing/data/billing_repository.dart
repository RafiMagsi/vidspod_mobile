import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/billing/domain/account_credits.dart';

/// Billing & credits per docs/MOBILE_APP_GUIDE.md §5.13 / §10.
class BillingRepository {
  final ApiClient _apiClient;

  BillingRepository(this._apiClient);

  Future<AccountCredits> getCredits() async {
    try {
      return await _apiClient.getObject(
        Endpoints.accountCredits,
        decoder: AccountCredits.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  /// IAP receipt verification (§10). `payload` carries `{product_id,
  /// receipt, platform, store}`.
  Future<Map<String, dynamic>> verifyReceipt(
    Map<String, dynamic> payload,
  ) async {
    try {
      return await _apiClient.postObject(
        Endpoints.verifyReceipt,
        data: payload,
        decoder: (json) => json,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
