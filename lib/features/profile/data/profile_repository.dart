import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/errors/api_error.dart';
import 'package:vidspod_mobile/features/profile/domain/profile.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<Profile> getProfile() async {
    try {
      final response = await _apiClient.dio.get('/me/profile');
      return Profile.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }

  Future<Profile> updateProfile(Profile profile) async {
    try {
      final response = await _apiClient.dio.patch('/me/profile', data: profile.toJson());
      return Profile.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromJson(e.response!.data);
    }
  }
}
