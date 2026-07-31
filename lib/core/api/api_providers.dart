import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/api/api_client.dart';
import 'package:vidspod_mobile/core/auth/session_events.dart';
import 'package:vidspod_mobile/core/auth/token_store.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenStore = ref.watch(tokenStoreProvider);
  final sessionEvents = ref.watch(sessionEventsProvider);
  return ApiClient(
    tokenStore: tokenStore,
    onSessionExpired: sessionEvents.notifySessionExpiredAsync,
  );
});
