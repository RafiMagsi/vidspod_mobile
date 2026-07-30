import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/core/storage/secure_storage_repository.dart';
import 'package:vidspod_mobile/features/auth/domain/auth_tokens.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorageRepository _secureStorageRepository;

  AuthRepository(this._apiClient, this._secureStorageRepository);

  Future<void> register(String email, String password) async {
    try {
      await _apiClient.dio.post(
        '/auth/register',
        data: {'email': email, 'password': password},
      );
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<AuthTokens> login(String email, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      final tokens = AuthTokens.fromJson(response.data);
      await _secureStorageRepository.write(
        key: 'access_token',
        value: tokens.accessToken,
      );
      await _secureStorageRepository.write(
        key: 'refresh_token',
        value: tokens.refreshToken,
      );
      return tokens;
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<void> logout() async {
    await _secureStorageRepository.delete(key: 'access_token');
    await _secureStorageRepository.delete(key: 'refresh_token');
  }

  Future<String?> getAccessToken() async {
    return await _secureStorageRepository.read(key: 'access_token');
  }
}
