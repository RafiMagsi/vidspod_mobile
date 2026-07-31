import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Broadcasts app-wide auth events so non-widget code (interceptors) can
/// notify the auth layer without depending on it.
///
/// `ApiClient` fires [notifySessionExpired] when the auth interceptor hard
/// logs out (second consecutive 401 after a failed refresh, or no refresh
/// token at all — see docs/MOBILE_APP_GUIDE.md §4). The auth state listens and
/// flips to `unauthenticated`, which the router redirects to `/login`.
class SessionEvents {
  final StreamController<void> _controller = StreamController<void>.broadcast();

  Stream<void> get onSessionExpired => _controller.stream;

  void notifySessionExpired() {
    if (!_controller.isClosed) _controller.add(null);
  }

  Future<void> notifySessionExpiredAsync() async => notifySessionExpired();

  void dispose() => _controller.close();
}

final sessionEventsProvider = Provider<SessionEvents>((ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
});
