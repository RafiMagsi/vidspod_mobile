import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Connectivity stream. Per §8, never queue a credit-costing action while
/// offline — surface "no connection" instead of a silent retry that could
/// double-charge.
final connectivityProvider = StreamProvider<bool>((ref) async* {
  final stream = Connectivity().onConnectivityChanged;
  yield _hasNetwork(await Connectivity().checkConnectivity());
  await for (final result in stream) {
    yield _hasNetwork(result);
  }
});

bool _hasNetwork(List<ConnectivityResult> results) {
  return results.any((r) => r != ConnectivityResult.none);
}
