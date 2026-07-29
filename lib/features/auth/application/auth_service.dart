import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/features/auth/auth_providers.dart';
import 'package:vidspod_mobile/features/auth/data/auth_repository.dart';

enum AuthStatus { unauthenticated, authenticated, loading }

class AuthStateNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository _authRepository;

  AuthStateNotifier(this._authRepository)
    : super(
        Config.previewMode
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated,
      ) {
    if (!Config.previewMode) {
      _init();
    }
  }

  Future<void> _init() async {
    final accessToken = await _authRepository.getAccessToken();
    if (accessToken != null) {
      state = AuthStatus.authenticated;
    }
  }

  Future<void> login(String email, String password) async {
    if (Config.previewMode) {
      state = AuthStatus.authenticated;
      return;
    }
    state = AuthStatus.loading;
    try {
      await _authRepository.login(email, password);
      state = AuthStatus.authenticated;
    } catch (e) {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = AuthStatus.unauthenticated;
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthStatus>((
  ref,
) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(authRepository);
});
