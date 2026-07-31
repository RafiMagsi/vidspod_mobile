import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/auth/session_events.dart';
import 'package:vidspod_mobile/core/push/push_registration_service.dart';
import 'package:vidspod_mobile/features/auth/auth_providers.dart';
import 'package:vidspod_mobile/features/auth/data/auth_repository.dart';

enum AuthStatus { unauthenticated, authenticated, loading }

class AuthStateNotifier extends StateNotifier<AuthStatus> {
  final AuthRepository _authRepository;
  final PushRegistrationService? _pushRegistration;
  final SessionEvents _sessionEvents;
  StreamSubscription<void>? _sessionExpiredSub;

  AuthStateNotifier(
    this._authRepository,
    this._sessionEvents, [
    this._pushRegistration,
  ]) : super(
         Config.previewMode
             ? AuthStatus.authenticated
             : AuthStatus.unauthenticated,
       ) {
    if (!Config.previewMode) {
      _init();
      // Hard logout from the auth interceptor (§4) flips the UI back to login.
      _sessionExpiredSub = _sessionEvents.onSessionExpired.listen((_) {
        state = AuthStatus.unauthenticated;
      });
    }
  }

  @override
  void dispose() {
    _sessionExpiredSub?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    final accessToken = await _authRepository.getAccessToken();
    if (accessToken != null) {
      state = AuthStatus.authenticated;
      _registerPush();
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
      _registerPush();
    } catch (e) {
      state = AuthStatus.unauthenticated;
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = AuthStatus.unauthenticated;
  }

  void _registerPush() {
    // Best-effort: registers the device for completion notifications (§9).
    _pushRegistration?.registerIfAvailable();
  }
}

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthStatus>((
  ref,
) {
  final authRepository = ref.watch(authRepositoryProvider);
  final sessionEvents = ref.watch(sessionEventsProvider);
  final pushRegistration = PushRegistrationService(
    ref.watch(devicesRepositoryProvider),
  );
  return AuthStateNotifier(authRepository, sessionEvents, pushRegistration);
});
