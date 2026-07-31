import 'package:dio/dio.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/api/endpoints.dart';
import 'package:vidspod_mobile/core/api/error_mapper.dart';
import 'package:vidspod_mobile/features/profile/domain/profile.dart';

class ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepository(this._apiClient);

  Future<Profile> getProfile() async {
    try {
      return await _apiClient.getObject(
        Endpoints.meProfile,
        decoder: Profile.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<Profile> updateProfile(Profile profile) async {
    try {
      return await _apiClient.patchObject(
        Endpoints.meProfile,
        data: profile.toJson(),
        decoder: Profile.fromJson,
      );
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
