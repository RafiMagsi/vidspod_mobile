import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';
part 'user_session.g.dart';

/// Mobile login session per docs/MOBILE_APP_GUIDE.md §4.
/// POST /auth/mobile/login → `{access_token, refresh_token, expires_in, user}`.
@freezed
abstract class UserSession with _$UserSession {
  const factory UserSession({
    required String accessToken,
    required String refreshToken,
    int? expiresIn,
    @JsonKey(name: 'user') SessionUser? user,
  }) = _UserSession;

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);
}

@freezed
abstract class SessionUser with _$SessionUser {
  const factory SessionUser({required String id, String? email, String? name}) =
      _SessionUser;

  factory SessionUser.fromJson(Map<String, dynamic> json) =>
      _$SessionUserFromJson(json);
}
